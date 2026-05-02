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
    shellIntegration.enableFishIntegration = true;
    settings = {
        enable_audio_bell = "no";
        font_family = "JetBrainsMono Nerd Font";
    };
  };
   
  };
  };
}