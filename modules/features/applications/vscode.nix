{ self, inputs, ... }: {
  flake.nixosModules.vscode = { pkgs, username, ...}: 
  let
    marketplace = inputs.nix-vscode-extensions.extensions.${pkgs.stdenv.hostPlatform.system}.vscode-marketplace;
  in {
    home-manager.users.${username} = {
      programs.vscode = {
        enable = true;
        package = pkgs.vscode;
        profiles.default.extensions = (with pkgs.vscode-extensions; [
          ms-azuretools.vscode-containers
          esbenp.prettier-vscode
          vscodevim.vim
          
          ms-vscode-remote.remote-containers
          github.copilot-chat
          jdinhlife.gruvbox
          jnoortheen.nix-ide
        ]); 
        #++ (with marketplace; [
        #  qufiwefefwoyn.kanagawa
        # # noctalia.noctaliatheme
        #]);
      };
    };
  };
}