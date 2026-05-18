{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.flatpak =
    {
      pkgs,
      ...
    }:
    {
      imports = [ inputs.nix-flatpak.nixosModules.nix-flatpak ];
      services.flatpak = {
        enable = true;
      };
    };
}
