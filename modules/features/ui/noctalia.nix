{ self, inputs, ... }: {
  flake.nixosModules.noctalia = { pkgs, username, ... }: {
    home-manager.users.${username} = {
      imports = [
        inputs.noctalia.homeModules.default
      ];
      programs.noctalia = {
        enable = true;
        settings = {
          shell = {
            font_family = "Sans Serif";
            telemetry_enabled = false;
            polkit_agent = true;
            clipboard_enabled = true;
            clipboard_history_max_entries = 100;
          };

          shell.panel = {
            control_center_placement = "attached";
            launcher_placement = "centered";
            clipboard_placement = "centered";
            session_placement = "attached";
          };

          wallpaper = {
            enabled = true;
            fill_mode = "crop";
            fill_color = "#000000";
            transition_duration = 1500;
            edge_smoothness = 0.05;
            directory = "~/Pictures/Wallpapers";
          };

          theme = {
            mode = "dark";
            source = "builtin";
            builtin = "Gruvbox";
          };

          notification = {
            enable_daemon = true;
            background_opacity = 1.0;
          };

          osd = {
            background_opacity = 1.0;
          };

          weather = {
            enabled = true;
            unit = "celsius";
            effects = true;
          };

          system.monitor.enabled = true;

          audio = {
            enable_overdrive = false;
            enable_sounds = false;
          };

          brightness = {
            enable_ddcutil = false;
            minimum_brightness = 0.0;
          };

          nightlight = {
            enabled = false;
            temperature_day = 6500;
            temperature_night = 3999;
          };

          location = {
            auto_locate = false;
            sunrise = "06:30";
            sunset = "18:30";
          };

          bar.main = {
            position = "bottom";
            thickness = 34;
            background_opacity = 0.93;
            radius = 12;
            margin_h = 4;
            margin_v = 4;
            padding = 2;
            widget_spacing = 6;
            scale = 1.0;
            reserve_space = true;
            auto_hide = false;
            show_on_workspace_switch = true;
            capsule = false;
            start = [
              "control-center"
              "workspaces"
            ];
            center = [ "media" ];
            end = [
              "tray"
              "notifications"
              "clipboard"
              "privacy"
              "keyboard_layout"
              "battery"
              "network"
              "volume"
              "clock"
              "session"
            ];
          };

          plugins = {
            source = [
              {
                enabled = true;
                kind = "git";
                name = "official";
                location = "https://github.com/noctalia-dev/official-plugins";
              }
              {
                enabled = true;
                kind = "git";
                name = "community";
                location = "https://github.com/noctalia-dev/community-plugins";
              }
            ];
            enabled = [ ];
          };
        };
      };
    };
  };
}
