{ self, inputs, ... }:
{
  flake.nixosModules.vim =
    { pkgs, ... }:
    {
      imports = [ inputs.nvf.nixosModules.default ];
      programs.nvf = {
        enable = true;

        settings = {
          vim = {
            viAlias = false;
            vimAlias = true;
            lsp.enable = true;
            treesitter.enable = true;
            theme = {
              enable = true;
              name = "gruvbox";
              style = "dark";
            };
            statusline.lualine.enable = true;
            telescope.enable = true;
            autocomplete.nvim-cmp.enable = true;
          };
        };
      };
    };
}
