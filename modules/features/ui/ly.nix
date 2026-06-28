{ self, inputs, ... }:
{
  flake.nixosModules.ly = {
    services.displayManager = {
      defaultSession = "niri";
      ly = {
        enable = true;
        settings = {
          full_color = true;

          bg = "0x00282828";
          fg = "0x00ebdbb2";
          border_fg = "0x00d79921";

          error_bg = "0x00282828";
          error_fg = "0x01cc241d";
        };
      };
    };
  };
}
