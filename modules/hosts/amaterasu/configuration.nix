{ self, inputs, ... }: {

  flake.nixosModules.hostAmaterasuConfiguration = { pkgs, lib, ... }: {
    imports = [
      self.nixosModules.hostAmaterasuHardware

      self.nixosModules.niri
      
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
	
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
  
    networking.hostName = "Amaterasu";
  
    networking.networkmanager.enable = true;
	
    time.timeZone = "Europe/Warsaw";

    i18n.defaultLocale = "en_US.UTF-8";
 
    i18n.extraLocaleSettings = {
      LC_ADDRESS = "pl_PL.UTF-8";
      LC_IDENTIFICATION = "pl_PL.UTF-8";
      LC_MEASUREMENT = "pl_PL.UTF-8";
      LC_MONETARY = "pl_PL.UTF-8";
      LC_NAME = "pl_PL.UTF-8";
      LC_NUMERIC = "pl_PL.UTF-8";
      LC_PAPER = "pl_PL.UTF-8";
      LC_TELEPHONE = "pl_PL.UTF-8";
      LC_TIME = "pl_PL.UTF-8";
    };

    users.users.izanagi = {
      isNormalUser = true;
      description = "Izanagi";
      extraGroups = [ "networkmanager" "wheel" "podman"];
      packages = with pkgs; [];
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

      # Containers
      distrobox
      distroshelf

      # Apps
      brave
      nautilus
      signal-desktop
      joplin-desktop # setup
      foliate
    ];

    
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
      gtk.enable = true; 
    };

    services.udisks2.enable = true;

    # Keyring
    services.gnome.gnome-keyring.enable = true;
    security.pam.services.gdm.enableGnomeKeyring = true;

    environment.variables.EDITOR = "nvim";

    services.displayManager.gdm.enable = true;
    system.stateVersion = "25.11";

    # VIRT
    virtualisation.vmware.guest.enable = true;
    virtualisation = {
    containers.enable = true;
      podman = {
        enable = true;
        dockerCompat = true;
        defaultNetwork.settings.dns_enabled = true; # Required for containers under podman-compose to be able to talk to each other.
      };
    };

  };

}
