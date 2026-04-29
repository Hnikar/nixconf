{ self, inputs, ... }: {
  flake.nixosModules.hostAmaterasuConfiguration = { pkgs, lib, ... }: {

    imports = [
      # Hardware and boot
      self.nixosModules.hostAmaterasuHardware
      self.nixosModules.grub

      # Hardware services
      self.nixosModules.bluetooth

      # Optional UI boot theme (disabled)
      #self.nixosModules.plymouth

      # Desktop / UI
      self.nixosModules.niri
      self.nixosModules.noctalia
      self.nixosModules.homeManager

      # Desktop applications & helpers
      self.nixosModules.discord
      self.nixosModules.vscode
      self.nixosModules.steam
      self.nixosModules.git
      self.nixosModules.fish
      self.nixosModules.spicetify
      self.nixosModules.kitty
    ];


    # Nix and system basics
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    ## Keep hardware clock consistent with other OSes
    time.hardwareClockInLocalTime = true;

    time.timeZone = "Europe/Warsaw";

    networking.hostName = "Amaterasu";
    networking.networkmanager.enable = true;


    # Localization
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
    users.users.izanagi = {
      isNormalUser = true;
      description = "Izanagi";
      extraGroups = [ "networkmanager" "wheel" "podman" ];
      packages = with pkgs; [];
    };


    # Home Manager (per-user UI / services)
    home-manager.users.izanagi = { pkgs, ... }: {
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
          name = "Papirus-Dark";
          package = pkgs.papirus-icon-theme;
        };
      };
    };


    # System packages

    nixpkgs.config.allowUnfree = true;

    environment.systemPackages = with pkgs; [
      # CLI
      wget
      fastfetch
      btop
      yazi
      neovim

      # Utilities
      baobab
      gnome-disk-utility
      file-roller
      zip
      libsecret
      unrar
      kdePackages.qt6ct
      btrfs-assistant

      # Containers
      distrobox
      distroshelf

      # Apps
      brave
      nautilus
      signal-desktop
      joplin-desktop
      onlyoffice-desktopeditors
      foliate
      gnome-text-editor

      # Security Apps
      bitwarden-desktop
      proton-vpn
    ];


    # Services and miscellaneous system settings

    ## Trash / file handling
    services.gvfs.enable = true;

    ## polkit for privilege management
    security.polkit.enable = true;

    ## Disk management
    services.udisks2.enable = true;

    ## KDE Connect
    programs.kdeconnect.enable = true;

    ## Display manager
    services.displayManager.gdm.enable = true;

    ## Environment variables
    environment.variables.EDITOR = "nvim";
    environment.variables.QT_QPA_PLATFORMTHEME = "qt6ct";

    ## Virtualisation
    virtualisation.vmware.guest.enable = true;


    # Keep this synced with your NixOS version
    system.stateVersion = "25.11";
  };
}
