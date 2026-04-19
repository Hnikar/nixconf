{ self, inputs, ... }: {
  flake.nixosModules.spicetify = { pkgs, username, ... }: {
    
    home-manager.users.${username} = {
      programs.spicetify = {
        enable = true;
        theme = "dribbblish";
        #colorScheme = "dark";
        #enableExtension = true;
        extensionSources = [
          {
            name = "marketplace";
            src = pkgs.spicetify-cli + "/share/spicetify/Extensions/marketplace.js";
            dest = "Extensions/marketplace.js";
          }
        ];
      };
    };
    
  };
}
