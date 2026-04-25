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
    }; 
  };
  };
}