{ self, inputs, ... }: {

  flake.nixosModules.homeManager = { pkgs, lib, username, ... }: {

    # Import the official Home Manager NixOS module using the inputs passed by import-tree
    imports = [
      inputs.home-manager.nixosModules.home-manager
    ];

    # Configure Home Manager
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;

    home-manager = {
      users.${username} = {
        home.stateVersion = "26.05";
      };

    backupFileExtension = "hm-backup"; ## investigate
  };
  };
}