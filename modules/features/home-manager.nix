{ self, inputs, ... }: {

  flake.nixosModules.homeManager = { pkgs, lib, ... }: {

    # Import the official Home Manager NixOS module using the inputs passed by import-tree
    imports = [
      inputs.home-manager.nixosModules.home-manager
    ];

    # Configure Home Manager
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;

    # IMPORTANT: Replace 'yourusername' with your actual NixOS username!
    home-manager.users.izanagi = { ## поменять на env
      home.stateVersion = "26.05";
    };
  };
}