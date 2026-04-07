{ inputs, ... }:

{
  # Add new hosts here by importing their directory.
  # Each host returns: { hostname, username, system, systemType, nixosModule }
  #
  # Example:
  #   myhost = import ./myhost { inherit inputs; };

  mythbox = import ./mythbox { inherit inputs; };
  myvm    = import ./myvm    { inherit inputs; };
  live    = import ./live    { inherit inputs; };
}
