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
      ];

      environment.systemPackages = with pkgs; [
        heroic
        winetricks
        wineWowPackages.stagingFull
      ];

      services.joycond.enable = true;
      programs.gamemode.enable = true;

      # programs.gamescope = {
      #   enable = true;
      #   capSysNice = true;
      #   args = [
      #     "--rt"
      #     "--expose-wayland"
      #   ];
      # };
    };
}
