{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.kitty = { 
    pkgs,
    username,
    ...
  }: {
  home-manager.users.${username} = {
   programs.kitty = {
    enable = true;
    extraConfig = ''
     include themes/noctalia.conf
    '';
    settings = {
        enable_audio_bell = "no";

        #font_size = 15;
        font_family = "JetBrainsMono Nerd Font";
    };
    };
   
  };
  };
}