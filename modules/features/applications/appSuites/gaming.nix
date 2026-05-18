{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.gaming =
    {
      pkgs,
      ...
    }:
    {
      imports = [
        self.nixosModules.steam
      ];
      services.flatpak.packages = [
        "net.lutris.Lutris"
      ];

    };
}
