{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.flatpak =
    {
      pkgs,
      username,
      ...
    }:
    {
      imports = [ nix-flatpak.nixosModules.nix-flatpak ];
      services.flatpak.enable = true;
      services.flatpak.packages = [
        "net.lutris.Lutris"
      ];
    };
}
