{ ... }:
{
  flake.nixosModules.opencloud =
    {
      config,
      lib,
      pkgs-unstable,
      ...
    }:
    let
      cfg = config.programs.opencloud-desktop;
      opencloudDesktop = pkgs-unstable.opencloud-desktop.overrideAttrs (old: {
        postInstall =
          (old.postInstall or "")
          + lib.optionalString (!cfg.desktopEntry.enable) ''
            rm -f $out/share/applications/opencloud.desktop
          '';
      });
    in
    {
      options.programs.opencloud-desktop.desktopEntry.enable =
        lib.mkEnableOption "the OpenCloud Desktop application menu entry";
      config = {
        environment.systemPackages = [ opencloudDesktop ];

        # Niri's generated XDG autostart unit runs the raw binary from the
        # user's autostart file, so use the packaged Qt launcher instead.
        systemd.user.services."app-OpenCloud@autostart" = {
          overrideStrategy = "asDropin";
          # Reset the generated ExecStart and use the packaged Qt launcher.
          serviceConfig.ExecStart = [
            ""
            "${opencloudDesktop}/bin/opencloud"
          ];
        };
      };
    };
}
