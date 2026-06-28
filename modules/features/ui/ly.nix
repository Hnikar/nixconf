{ self, inputs, ... }:
{
  flake.nixosModules.ly = {
    services.displayManager = {
      defaultSession = "niri";
      ly.enable = true;
    };
  };
}
