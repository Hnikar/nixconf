{ self, inputs, ... }:
{
  flake.nixosModules.ttyNiri =
    { username, ... }:
    {
      services.getty.autologinUser = username;

      home-manager.users.${username}.programs.fish.loginShellInit = ''
        if test -z "$WAYLAND_DISPLAY"; and test -z "$DISPLAY"; and test "$XDG_VTNR" = 1
          exec niri-session
        end
      '';
    };
}
