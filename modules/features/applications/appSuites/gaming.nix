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
        self.nixosModules.creamlinux
        self.nixosModules.steam
        self.nixosModules.wine
      ];

      environment.systemPackages = with pkgs; [
        heroic
      ];

      services.joycond.enable = true;
      programs.gamemode.enable = true;
    };
}
