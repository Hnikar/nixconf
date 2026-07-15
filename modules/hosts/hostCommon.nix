{ self, inputs, ... }:
{
  flake.nixosModules.hostCommon =
    {
      pkgs,
      lib,
      username,
      ...
    }:
    {
      imports = [
        # Services and hardware helpers
        self.nixosModules.networking
        self.nixosModules.bluetooth
        self.nixosModules.fish
        self.nixosModules.git
        self.nixosModules.keyring
        self.nixosModules.appimage
        self.nixosModules.pipewire
        self.nixosModules.flatpak

        # TUI applications
        self.nixosModules.vim

        # Desktop / UI
        self.nixosModules.niri
        self.nixosModules.noctalia
        self.nixosModules.sddm

        # User / Home Manager
        self.nixosModules.homeManager
        self.nixosModules.defaultApps

        self.nixosModules.fonts

        # Desktop applications
        self.nixosModules.discord
        self.nixosModules.ghostty
        self.nixosModules.spicetify
        self.nixosModules.vscode

        # App Suites
        self.nixosModules.communicationApps
        self.nixosModules.gnomeSuite
      ];

      services.tailscale.enable = true;

      # Localization
      time.timeZone = "Europe/Warsaw";
      i18n.defaultLocale = "en_US.UTF-8";
      i18n.extraLocaleSettings = {
        LC_ADDRESS = "en_US.UTF-8";
        LC_IDENTIFICATION = "en_US.UTF-8";
        LC_MEASUREMENT = "en_US.UTF-8";
        LC_MONETARY = "en_US.UTF-8";
        LC_NAME = "en_US.UTF-8";
        LC_NUMERIC = "en_US.UTF-8";
        LC_PAPER = "en_US.UTF-8";
        LC_TELEPHONE = "en_US.UTF-8";
        LC_TIME = "en_US.UTF-8";
      };

      # Users
      users.users.${username} = {
        isNormalUser = true;
        extraGroups = [
          "networkmanager"
          "wheel"
          "podman"
          "docker"
        ];
        packages = with pkgs; [ ];
      };

      # Home Manager
      home-manager.users.${username} =
        { pkgs, ... }:
        {
          ## Clipboard manager
          services.cliphist.enable = true;

          ## Cursor theme
          home.pointerCursor = {
            name = "phinger-cursors-dark";
            package = pkgs.phinger-cursors;
            size = 24;
            gtk.enable = true;
            x11.enable = true;
          };

          gtk = {
            enable = true;
            iconTheme = {
              name = "Gruvbox-Plus-Dark";
              package = pkgs.gruvbox-plus-icons;
            };
            gtk3.extraConfig = {
              gtk-application-prefer-dark-theme = 1;
            };
            gtk4.extraConfig = {
              gtk-application-prefer-dark-theme = 1;
            };
          };
          home.sessionVariables = {
            QT_QPA_PLATFORMTHEME = "gtk3";
            QS_ICON_THEME = "Gruvbox-Plus-Dark";
          };

          # Custom desktop entries for web apps
          xdg.desktopEntries.foundry =
            let
              foundryIcon = builtins.tryEval (
                builtins.fetchurl {
                  url = "https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/foundry-vtt.png";
                  sha256 = "sha256-2IKzYVHmJK4XDPmLxGIvKLnyRfYxbFwSOgQaDD8KEOU=";
                }
              );
            in
            {
              name = "Foundry";
              exec = "${lib.getExe pkgs.brave} --app=https://poltva.org/";
            }
            // lib.optionalAttrs foundryIcon.success {
              icon = "${foundryIcon.value}";
            };
        };

      # System packages
      nixpkgs.config.allowUnfree = true;
      environment.systemPackages = with pkgs; [
        # Web browser
        brave

        # Terminal & Shell
        btop
        fastfetch
        ghostty
        neovim
        yazi

        # System Utilities
        btrfs-assistant
        file-roller
        headsetcontrol
        kdePackages.qt6ct
        libsecret
        nextcloud-client
        unrar
        wget
        zip
        efibootmgr

        # Media
        foliate

        # Productivity
        nixfmt
        onlyoffice-desktopeditors

        # Security
        proton-vpn
      ];
      xdg.terminal-exec.enable = true;

      # Misc services
      services.gvfs.enable = true;
      security.polkit.enable = true;
      services.udisks2.enable = true;

      ## Environment variables
      environment.variables.EDITOR = "nvim";
      environment.variables.QT_QPA_PLATFORMTHEME = "qt6ct";

      # Nix and system
      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];
      system.stateVersion = "26.05";
    };
}
