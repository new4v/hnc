# modules/virt.nix
# Virtualization roles — host/hypervisor or VM guest.
# Add to a host's modules list, then configure via NixOS options:
#
#   virt.host  = { enable = true; users = [ "alice" ]; iommu = false; };
#   virt.guest = { enable = true; spice = true; };

{ config, lib, pkgs, ... }:

let
  cfg = config.virt;
in {

  options.virt = {

    host = {
      enable = lib.mkEnableOption "KVM/QEMU hypervisor (libvirt + virt-manager)";

      iommu = lib.mkEnableOption "IOMMU/VFIO PCIe passthrough (intel_iommu / amd_iommu)";

      users = lib.mkOption {
        type        = with lib.types; listOf str;
        default     = [];
        example     = [ "alice" ];
        description = "Users to add to the libvirtd and kvm groups.";
      };
    };

    guest = {
      enable = lib.mkEnableOption "QEMU guest agent and SPICE tools";

      spice = lib.mkOption {
        type        = lib.types.bool;
        default     = true;
        description = "Enable spice-vdagent for clipboard sync and display resize.";
      };
    };

  };

  config = lib.mkMerge [

    # ── Host / Hypervisor ──────────────────────────────────────────────
    (lib.mkIf cfg.host.enable {

      boot.kernelModules = [ "kvm-intel" "kvm-amd" ];

      virtualisation.libvirtd = {
        enable = true;
        qemu = {
          package      = pkgs.qemu_kvm;
          runAsRoot    = false;
          swtpm.enable = true;  # TPM 2.0 emulation (Windows 11, secure guests)
          ovmf.enable  = true;  # UEFI firmware for guests
        };
      };

      virtualisation.spiceUSBRedirection.enable = true;

      environment.systemPackages = with pkgs; [
        virt-manager  # GUI VM manager
        virt-viewer   # lightweight guest display client
      ];

      # Grant named users access without hardcoding groups in users.nix
      users.groups.libvirtd.members = cfg.host.users;
      users.groups.kvm.members      = cfg.host.users;

    })

    # ── IOMMU / VFIO passthrough (opt-in) ─────────────────────────────
    (lib.mkIf (cfg.host.enable && cfg.host.iommu) {

      boot.kernelParams  = [ "intel_iommu=on" "amd_iommu=on" "iommu=pt" ];
      boot.kernelModules = [ "vfio" "vfio_iommu_type1" "vfio_pci" ];

    })

    # ── Guest ──────────────────────────────────────────────────────────
    (lib.mkIf cfg.guest.enable {

      services.qemuGuest.enable      = true;
      services.spice-vdagentd.enable = cfg.guest.spice;

      # Ensure virtio drivers are present early in the initrd
      boot.initrd.availableKernelModules =
        [ "virtio_pci" "virtio_scsi" "virtio_blk" "virtio_net" ];

    })

  ];

}
