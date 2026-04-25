{ self, inputs, ... }: {
  flake.nixosModules.niri = { pkgs, lib, ... }: {
    programs.niri = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri;
    };
  };

  perSystem = { pkgs, lib, self', ... }: {
    packages.myNiri = inputs.wrapper-modules.wrappers.niri.wrap {
      inherit pkgs; # THIS PART IS VERY IMPORTAINT, I FORGOT IT IN THE VIDEO!!!
      #v2-settings = true;
      settings = {
        spawn-at-startup = [
          (lib.getExe self'.packages.myNoctalia)
        ];
        xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

        input.keyboard = {
          xkb = {
            layout = "us,ru";
            options = "grp:alt_shift_toggle,caps:escape";
          };
          repeat-rate = 40;
          repeat-delay = 250;
        };
        layout.gaps = 5;

        layout.focus-ring = {
          width = 2;
          active-color = "#fe8019";
        };
        prefer-no-csd = true;

        binds = {
          # Terminal
          #"Mod+Return".spawn-sh = lib.getExe pkgs.ghostty;
          "Mod+Return".spawn-sh = lib.getExe pkgs.kitty;


          # Apps
          "Mod+E".spawn-sh = lib.getExe pkgs.nautilus;
          "Mod+B".spawn-sh = lib.getExe pkgs.brave;


          # Core
          "Mod+S".spawn-sh = "${lib.getExe self'.packages.myNoctalia} ipc call launcher toggle";
          "Mod+Space".spawn-sh = "${lib.getExe self'.packages.myNoctalia} ipc call controlCenter toggle";
          "Mod+Comma".spawn-sh = "${lib.getExe self'.packages.myNoctalia} ipc call settings toggle";
          "Mod+Q".close-window = {};


          # Window & Column Navigation
          ## Using Arrows
          "Mod+Left".focus-column-left = {};
          "Mod+Right".focus-column-right = {};
          "Mod+Up".focus-window-up = {};
          "Mod+Down".focus-window-down = {};
          
          ## Using Vi-keys (HJKL)
          # "Mod+H".focus-column-left = {};
          # "Mod+L".focus-column-right = {};
          # "Mod+K".focus-window-up = {};
          # "Mod+J".focus-window-down = {};
          
          "Mod+Home".focus-column-first = {};
          "Mod+End".focus-column-last = {};


          # Window & Column Movement
          "Mod+Ctrl+Left".move-column-left = {};
          "Mod+Ctrl+Right".move-column-right = {};
          "Mod+Ctrl+Up".move-window-up = {};
          "Mod+Ctrl+Down".move-window-down = {};

          "Mod+Ctrl+Shift+Down".move-column-to-workspace-down = {};
          "Mod+Ctrl+Shift+Up".move-column-to-workspace-up = {};

          "Mod+R".switch-preset-column-width = {};

          "Mod+BracketLeft".consume-or-expel-window-left = {};
          "Mod+BracketRight".consume-or-expel-window-right = {};
          
          # "Mod+Ctrl+H".move-column-left = {};
          # "Mod+Ctrl+L".move-column-right = {};
          # "Mod+Ctrl+K".move-window-up = {};
          # "Mod+Ctrl+J".move-window-down = {};
          

          # Move to Workspace
          "Mod+Ctrl+1".move-column-to-workspace = 1;
          "Mod+Ctrl+2".move-column-to-workspace = 2;
          "Mod+Ctrl+3".move-column-to-workspace = 3;
          "Mod+Ctrl+4".move-column-to-workspace = 4;
          "Mod+Ctrl+5".move-column-to-workspace = 5;
          "Mod+Ctrl+6".move-column-to-workspace = 6;
          "Mod+Ctrl+7".move-column-to-workspace = 7;
          "Mod+Ctrl+8".move-column-to-workspace = 8;
          "Mod+Ctrl+9".move-column-to-workspace = 9;

          "Mod+Shift+1".move-window-to-workspace = 1;
          "Mod+Shift+2".move-window-to-workspace = 2;
          "Mod+Shift+3".move-window-to-workspace = 3;
          "Mod+Shift+4".move-window-to-workspace = 4;
          "Mod+Shift+5".move-window-to-workspace = 5;
          "Mod+Shift+6".move-window-to-workspace = 6;
          "Mod+Shift+7".move-window-to-workspace = 7;
          "Mod+Shift+8".move-window-to-workspace = 8;
          "Mod+Shift+9".move-window-to-workspace = 9;


          # Monitor Navigation
          "Mod+Shift+Left".focus-monitor-left = {};
          "Mod+Shift+Right".focus-monitor-right = {};
          "Mod+Shift+Up".focus-monitor-up = {};
          "Mod+Shift+Down".focus-monitor-down = {};
          
          "Mod+Shift+Ctrl+Left".move-column-to-monitor-left = {};
          "Mod+Shift+Ctrl+Right".move-column-to-monitor-right = {};


          #  Layout & Window Modes
          "Mod+F".maximize-column = {};
          "Mod+Shift+F".fullscreen-window = {};
          "Mod+C".center-column = {};
          "Mod+Minus".set-column-width = "-10%"; ## хз 25 или 10
          "Mod+Equal".set-column-width = "+10%";
          "Mod+Shift+Minus".set-window-height = "-10%";
          "Mod+Shift+Equal".set-window-height = "+10%";
          
          "Mod+T".toggle-window-floating = {};
          "Mod+W".toggle-column-tabbed-display = {};
          "Mod+O".toggle-overview = {};

          "Mod+Shift+T".switch-focus-between-floating-and-tiling = {};


          # Workspace Management
          "Mod+1".focus-workspace = 1;
          "Mod+2".focus-workspace = 2;
          "Mod+3".focus-workspace = 3;
          "Mod+4".focus-workspace = 4;
          "Mod+5".focus-workspace = 5;
          "Mod+6".focus-workspace = 6;
          "Mod+7".focus-workspace = 7;
          "Mod+8".focus-workspace = 8;
          "Mod+9".focus-workspace = 9;
          "Mod+Tab".focus-workspace-previous = {};  


          # Scroll Navigation
          "Mod+WheelScrollDown".focus-column-left = {};
          "Mod+WheelScrollUp".focus-column-right = {};
          "Mod+Ctrl+WheelScrollDown".focus-workspace-down = {};
          "Mod+Ctrl+WheelScrollUp".focus-workspace-up = {};


          # Screenshots
          "Print".screenshot = {};
          "Ctrl+Print".screenshot-screen = {};
          "Alt+Print".screenshot-window = {};


          # Misc
          "Mod+Shift+Escape".show-hotkey-overlay = {};
          #"Mod+Shift+P".power-off-monitors = {};
          "Ctrl+Alt+Delete".quit = {};


          # Media
          "XF86AudioRaiseVolume".spawn-sh = "${lib.getExe self'.packages.myNoctalia} ipc call volume increase";
          "XF86AudioLowerVolume".spawn-sh = "${lib.getExe self'.packages.myNoctalia} ipc call volume decrease";
          "XF86AudioMute".spawn-sh = "${lib.getExe self'.packages.myNoctalia} ipc call volume muteOutput";
          "XF86AudioMicMute".spawn-sh = "${lib.getExe self'.packages.myNoctalia} ipc call volume micmute";
          
          # Media Player Controls
          "XF86AudioPlay".spawn-sh = "${lib.getExe pkgs.playerctl} play-pause";
          "XF86AudioNext".spawn-sh = "${lib.getExe pkgs.playerctl} next";
          "XF86AudioPrev".spawn-sh = "${lib.getExe pkgs.playerctl} previous";
         
          # Brightness
          #"XF86MonBrightnessUp".spawn-sh = "${lib.getExe self'.packages.myNoctalia} ipc call brightness increase";
          #"XF86MonBrightnessDown".spawn-sh = "${lib.getExe self'.packages.myNoctalia} ipc call brightness decrease";
        };
      };
    };
  };
}