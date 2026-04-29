{ self, inputs, ... }: {

  flake.nixosModules.hostAmaterasuConfiguration = { pkgs, lib, ... }: {
    imports = [
      self.nixosModules.hostAmaterasuHardware

      self.nixosModules.grub

      self.nixosModules.bluetooth

      #self.nixosModules.plymouth

      self.nixosModules.niri
      self.nixosModules.noctalia
      
      self.nixosModules.homeManager

      self.nixosModules.discord
      self.nixosModules.vscode
      self.nixosModules.steam
      self.nixosModules.git
      self.nixosModules.fish
      self.nixosModules.spicetify
      self.nixosModules.kitty
    ];

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    time.hardwareClockInLocalTime = true;
  
    networking.hostName = "Amaterasu";
  
    networking.networkmanager.enable = true;
	
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

    users.users.izanagi = {
      isNormalUser = true;
      description = "Izanagi";
      extraGroups = [ "networkmanager" "wheel" "podman"];
      packages = with pkgs; [];
    };

    home-manager.users.izanagi = { pkgs, ... }: {
      # Clipboard manager
      services.cliphist.enable = true;
      
      # Cursor theme
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

    nixpkgs.config.allowUnfree = true;
    
    environment.systemPackages = with pkgs; [
      # Cli
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


    
    # Trash
    services.gvfs.enable = true;

    security.polkit.enable = true;

    services.udisks2.enable = true;

    programs.kdeconnect.enable = true;

    environment.variables.EDITOR = "nvim";

    environment.variables.QT_QPA_PLATFORMTHEME = "qt6ct";

    services.displayManager.gdm.enable = true;
    system.stateVersion = "25.11";

    # VIRT
    virtualisation.vmware.guest.enable = true;
  };
}
