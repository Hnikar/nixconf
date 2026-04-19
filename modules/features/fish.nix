{ self, inputs, ... }: {
  flake.nixosModules.fish = { pkgs, username, ...}: {
    
    # 1. Enable fish system-wide (This fixes the error)
    programs.fish.enable = true; 

    # 2. Configure fish for your specific user via Home Manager
    home-manager.users.${username} = {
      programs.fish = {
        enable = true;
        package = pkgs.fish;
        plugins = [
          {
            name = "pure";
            src = pkgs.fishPlugins.pure.src;
          }];
      };
    };
    
  };
}