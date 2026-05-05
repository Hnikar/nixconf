
{ self, inputs, ... }: 
{
  flake.nixosModules.fonts = { pkgs, username, ... }: {
    home-manager.users.${username} = {
      fonts.packages = with pkgs; [
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-color-emoji
      ];
    };
  };
}