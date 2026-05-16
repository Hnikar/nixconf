{ self, inputs, ... }:
{
  flake.nixosModules.vim =
    { pkgs, ... }:
    {
      import = [
        inputs.nvf.vim
      ];
      programs.nvf = {
        enable = true;
        # Your settings need to go into the settings attribute set
        # most settings are documented in the appendix
        settings = {
          vim.viAlias = false;
          vim.vimAlias = true;
          vim.lsp = {
            enable = true;
          };
        };
      };

    };

}
