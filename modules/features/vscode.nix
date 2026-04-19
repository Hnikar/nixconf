{ self, inputs, ... }: {
  flake.nixosModules.vscode = { pkgs, username, ...}: {
    home-manager.users.${username} = {
    programs.vscode = {
      enable = true;
      package = pkgs.vscode;
      profiles.default.extensions = with pkgs.vscode-extensions; [
        ms-azuretools.vscode-containers
        esbenp.prettier-vscode
        jnoortheen.nix-ide
        asvetliakov.vscode-neovim
        ms-vscode-remote.remote-containers
        # noctalia.noctaliatheme
        github.copilot-chat
      ];
    };
  };
  };
}