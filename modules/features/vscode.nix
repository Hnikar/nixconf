{ self, inputs, ... }: {
  flake.nixosModules.vscode = { pkgs, ...}: {
    programs.vscode = {
      enable = true;
      package = pkgs.vscode;
    extensions = with pkgs.vscode-extensions; [
        ms-azuretools.vscode-containers
        esbenp.prettier-vscode
        jnoortheen.nix-ide
        asvetliakov.vscode-neovim
        ms-vscode-remote.remote-containers
     #   noctalia.noctaliatheme
        github.copilot-chat
      ];
    };
  };
}