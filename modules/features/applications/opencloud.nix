{ ... }:
{
  flake.nixosModules.opencloud =
    {
      config,
      lib,
      pkgs,
      pkgs-unstable,
      ...
    }:
    let
      cfg = config.programs.opencloud-desktop;
      opencloudDesktop = pkgs-unstable.opencloud-desktop.overrideAttrs (old: {
        postInstall =
          (old.postInstall or "")
          + ''
            substituteInPlace $out/share/applications/opencloud.desktop \
              --replace-fail 'X-GNOME-Autostart-Delay=3' \
                'X-GNOME-Autostart-Delay=${toString cfg.autostartDelaySeconds}'
          ''
          + lib.optionalString (!cfg.desktopEntry.enable) ''
            rm -f $out/share/applications/opencloud.desktop
          '';
      });
    in
    {
      options.programs.opencloud-desktop.desktopEntry.enable =
        lib.mkEnableOption "the OpenCloud Desktop application menu entry";
      options.programs.opencloud-desktop.autostartDelaySeconds = lib.mkOption {
        type = lib.types.ints.unsigned;
        default = 10;
        description = ''
          Delay in seconds requested by OpenCloud's desktop file when the
          desktop environment launches it through XDG autostart.
        '';
      };

      config = {
        environment.systemPackages = [ opencloudDesktop ];

        # The boot autostart may not inherit OpenCloud's Qt wrapper environment.
        # Expose Qt 6's QML modules to the user session.
        environment.sessionVariables.NIXPKGS_QT6_QML_IMPORT_PATH = "${pkgs-unstable.qt6.qtdeclarative}/lib/qt-6/qml";

        # Niri uses systemd's XDG autostart generator, which ignores the
        # GNOME-specific delay field. Its generated unit also runs the raw
        # binary from the user's autostart file, bypassing the Qt wrapper.
        systemd.user.services."app-OpenCloud@autostart" = {
          overrideStrategy = "asDropin";
          serviceConfig = {
            # Reset the generated ExecStart and use the packaged Qt launcher.
            ExecStart = [
              ""
              "${opencloudDesktop}/bin/opencloud --showsettings"
            ];
          }
          // lib.optionalAttrs (cfg.autostartDelaySeconds > 0) {
            ExecStartPre = "${pkgs.coreutils}/bin/sleep ${toString cfg.autostartDelaySeconds}";
          };
        };
      };
    };
}
