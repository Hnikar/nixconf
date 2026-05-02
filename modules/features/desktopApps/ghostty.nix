{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.ghostty = { 
    pkgs,
    username,
    ...
  }: {
  home-manager.users.${username} = {
   programs.ghostty = {
    enable = true;
    enableFishIntegration = true;
    settings = {
        font-family = "JetBrainsMono Nerd Font";
    };
  };
   
  };
  };
}