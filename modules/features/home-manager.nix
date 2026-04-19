{ self, inputs, ... }: {

  flake.nixosModules.homeManager = { pkgs, lib, username, ... }: {

    imports = [
      inputs.home-manager.nixosModules.home-manager
    ];

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