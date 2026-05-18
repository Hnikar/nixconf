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

      environment.systemPackages = with pkgs; [
        heroic
      ];

      services.joycond.enable = true;
      programs.gamemode.enable = true;

      programs.gamescope = {
        enable = true;
        capSysNice = true;
        args = [
          "--rt"
          "--expose-wayland"
        ];
      };
    };
}
