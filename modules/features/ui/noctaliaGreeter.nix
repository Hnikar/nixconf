{ self, inputs, ... }:
{
  flake.nixosModules.noctaliaGreeter =
    { pkgs, lib, ... }:
    {
      imports = [
        inputs.noctalia-greeter.nixosModules.default
      ];

      programs.noctalia-greeter = {
        enable = lib.mkDefault true;
        settings = lib.mkDefault {
          session.default = "niri";

          cursor = {
            theme = "phinger-cursors-dark";
            size = 24;
            path = "${pkgs.phinger-cursors}/share/icons";
          };

          keyboard = {
            layout = "us";
          };
        };
      };
    };
}
