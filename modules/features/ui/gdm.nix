{ self, inputs, ... }:
{
  flake.nixosModules.gdm = {
    services.displayManager = {
      defaultSession = "niri";
      gdm.enable = true;
    };
  };
}
