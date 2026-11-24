{ self, ... }:
{
  flake.nixosModules.wine =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        winetricks
        wineWowPackages.stagingFull
      ];
    };
}
