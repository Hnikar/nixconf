{ self, inputs, ... }: 
{
  flake.nixosModules.git = { pkgs, username, ... }: {
    
    home-manager.users.${username} = {
      programs.git = {
        enable = true;
        settings = {
          user = {
            name = "Hnikar";
            email = "140448550+Hnikar@users.noreply.github.com";
          };
        };
      };

    }; 
  };
}