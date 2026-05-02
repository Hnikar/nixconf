{ self, inputs, ... }: {
  flake.nixosModules.hostAmaterasuConfiguration = { pkgs, lib, ... }: {

    imports = [
      # Hardware and boot
      self.nixosModules.hostAmaterasuHardware
      self.nixosModules.grub

      # Hardware services
      self.nixosModules.bluetooth

      self.nixosModules.defaultApps

      # Optional UI boot theme (disabled)
      #self.nixosModules.plymouth

      # Desktop / UI
      self.nixosModules.niri
      self.nixosModules.noctalia
      self.nixosModules.homeManager
      self.nixosModules.keyring

      # Desktop applications & helpers
      self.nixosModules.discord
      self.nixosModules.vscode
      self.nixosModules.steam
      self.nixosModules.git
      self.nixosModules.fish
      self.nixosModules.spicetify
      self.nixosModules.kitty
      self.nixosModules.podman
      self.nixosModules.razer
    ];


    # Nix and system basics
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    #time.timeZone = "Europe/Warsaw"; 
    time.timeZone = "UTC"; 

    networking.hostName = "Amaterasu";
    networking.networkmanager.enable = true;

    networking.interfaces."enp8s0".ipv4.addresses = [{
      address = "192.168.69.2";
      prefixLength = 24;
    }];


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
      openssh
      headsetcontrol

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
      mumble
      prismlauncher
      obs-studio
      qbittorrent
      telegram-desktop
      cinny-desktop

      # GNOME apps
      gnome-text-editor
      showtime
      gnome-calculator
      loupe
      papers
      showtime
      snapshot
      decibels
      gnome-boxes
      

      # Security Apps
      bitwarden-desktop
      proton-vpn
    ];

    # Services and miscellaneous system settings

    ## Tailscale
    services.tailscale.enable = true;

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
    #virtualisation.vmware.guest.enable = true;


    # Keep this synced with your NixOS version
    system.stateVersion = "25.11";
  };
}
