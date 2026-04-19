{ self, inputs, ... }: {
  flake.nixosModules.fish = { pkgs, username, ...}: {
    
    users.users.${username}.shell = pkgs.fish;
    
    programs.fish.enable = true; 

    home-manager.users.${username} = {
      programs.fish = {
        enable = true;
        package = pkgs.fish;
        interactiveShellInit = '' set fish_greeting '';
        plugins = [
          {
            name = "pure";
            src = pkgs.fishPlugins.pure.src;
          }];
      };
    };
    
  };
}