
{ self, inputs, ... }: 
{
  flake.nixosModules.fonts = { pkgs, username, ... }: {
      fonts.packages = with pkgs; [
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-color-emoji
      ];
  };
}