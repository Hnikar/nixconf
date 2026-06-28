{ self, inputs, ... }:
{
  flake.nixosModules.sddm =
    { ... }:
    {
      services.displayManager = {
        defaultSession = "niri";

        sddm = {
          enable = true;
          wayland.enable = true;
        };
      };
    };
}
