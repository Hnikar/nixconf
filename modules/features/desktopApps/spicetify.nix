{ self, inputs, ... }: {
  flake.nixosModules.spicetify = { pkgs, username, ... }: {
    home-manager.users.${username} = {
      imports = [
        inputs.spicetify-nix.homeManagerModules.default
      ];
      programs.spicetify = 
        let spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system}; 
          in
        {
          enable = true;
          enabledExtensions = with spicePkgs.extensions; [
            adblock
            hidePodcasts
            catJamSynced
          ];
          enabledCustomApps = with spicePkgs.apps; [
            ncsVisualizer
          ];
          theme = spicePkgs.themes.text;
          colorScheme = "Kanagawa";
        };
    };
  };
}
