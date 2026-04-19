{ self, inputs, ... }: 
{
  flake.nixosModules.git = { pkgs, ... }: {
    
    home-manager.users.izanagi = {
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