{ hostMeta, lib, ... }:

{
  imports =
    lib.optional (hostMeta.systemType == "physical") ./physical.nix
    ++ lib.optional (hostMeta.systemType == "vm")       ./vm.nix
    ++ lib.optional (hostMeta.systemType == "live-usb") ./live-usb.nix;
}
