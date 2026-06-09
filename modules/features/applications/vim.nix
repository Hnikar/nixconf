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

            opts.expandtab = true;

            # spellcheck = {
            #   enable = true;
            #   programmingWordlist.enable = true;
            # };

            debugger = {
              nvim-dap = {
                enable = true;
                ui.enable = true;
              };
            };

            snippets.luasnip.enable = true;

            visuals = {
              nvim-scrollbar.enable = true;
              nvim-web-devicons.enable = true;
              nvim-cursorline.enable = true;
              cinnamon-nvim.enable = true;
              fidget-nvim.enable = true;

              highlight-undo.enable = true;
              blink-indent.enable = true;
              indent-blankline.enable = true;

              # Fun
              cellular-automaton.enable = false;
            };

            theme = {
              enable = true;
              name = "gruvbox";
              style = "dark";
            };

            statusline.lualine.enable = true;
            telescope.enable = true;
            autocomplete.blink-cmp.enable = true;

            filetree = {
              neo-tree = {
                enable = true;
              };
            };

            tabline = {
              nvimBufferline.enable = true;
            };

            # treesitter.context.enable = true;

            # binds = {
            #   whichKey.enable = true;
            #   cheatsheet.enable = true;
            # };

            # git = {
            #   enable = true;
            #   gitsigns.enable = true;
            #   gitsigns.codeActions.enable = false; # throws an annoying debug message
            #   neogit.enable = true;
            # };

            # #  # minimap = {
            # #  #   minimap-vim.enable = false;
            # #  #   codewindow.enable = true; # lighter, faster, and uses lua for configuration
            # #  # };

            # dashboard = {
            #   dashboard-nvim.enable = false;
            # };

            # notify = {
            #   nvim-notify.enable = true;
            # };

            # projects = {
            #   project-nvim.enable = true;
            # };

            # utility = {
            #   ccc.enable = false;
            #   vim-wakatime.enable = false;
            #   diffview-nvim.enable = true;
            #   yanky-nvim.enable = false;
            #   qmk-nvim.enable = false; # requires hardware specific options
            #   icon-picker.enable = true;
            #   surround.enable = true;
            #   leetcode-nvim.enable = true;
            #   multicursors.enable = true;
            #   smart-splits.enable = true;
            #   undotree.enable = true;
            #   nvim-biscuits.enable = true;
            #   grug-far-nvim.enable = true;

            #   motion = {
            #     hop.enable = true;
            #     leap.enable = true;
            #     precognition.enable = true;
            #   };
            #   images = {
            #     image-nvim.enable = false;
            #     img-clip.enable = true;
            #   };
            # };

            # notes = {
            #   neorg.enable = false;
            #   orgmode.enable = false;
            #   todo-comments.enable = true;
            # };

            terminal = {
              toggleterm = {
                enable = true;
                lazygit.enable = true;
              };
            };

            # ui = {
            #   borders.enable = true;
            #   noice.enable = true;
            #   colorizer.enable = true;
            #   modes-nvim.enable = false; # the theme looks terrible with catppuccin
            #   illuminate.enable = true;
            #   breadcrumbs = {
            #     enable = true;
            #     navbuddy.enable = true;
            #   };
            #   smartcolumn = {
            #     enable = true;
            #     setupOpts.custom_colorcolumn = {
            #       # this is a freeform module, it's `buftype = int;` for configuring column position
            #       nix = "110";
            #       ruby = "120";
            #       java = "130";
            #       go = [
            #         "90"
            #         "130"
            #       ];
            #     };
            #   };
            #   fastaction.enable = true;
            # };

            assistant = {
              chatgpt.enable = false;
              copilot = {
                enable = false;
                cmp.enable = true;
              };
              codecompanion-nvim.enable = false;
              avante-nvim.enable = true;
            };

            # session = {
            #   nvim-session-manager.enable = false;
            # };

            gestures = {
              gesture-nvim.enable = false;
            };

            comments = {
              comment-nvim.enable = true;
            };

            # presence = {
            #   neocord.enable = false;
            # };

            lsp = {
              enable = true;

              formatOnSave = true;
              lspkind.enable = false;
              lightbulb.enable = true;
              lspsaga.enable = false;
              trouble.enable = true;
              otter-nvim.enable = true;
              nvim-docs-view.enable = true;
              presets.harper.enable = true;
            };

            languages = {
              enableFormat = true;
              enableTreesitter = true;
              enableExtraDiagnostics = true;

              # Languages that will be supported in default and maximal configurations.
              nix.enable = true;
              markdown.enable = true;

              # Languages that are enabled in the maximal configuration.
              bash.enable = true;
              clang.enable = true;
              cmake.enable = true;
              css.enable = true;
              scss.enable = true;
              html.enable = true;
              json.enable = true;
              sql.enable = true;
              java.enable = true;
              kotlin.enable = true;
              typescript.enable = true;
              go.enable = true;
              lua.enable = true;
              python.enable = true;
              rust = {
                enable = true;
                extensions.crates-nvim.enable = true;
              };
              toml.enable = true;
              xml.enable = true;
              tex.enable = true;
              docker.enable = true;
              env.enable = true;

              # Language modules that are not as common.
              assembly.enable = false;
              csharp.enable = false;
              ruby.enable = false;
              make.enable = false;
              qml.enable = false;
              svelte.enable = false;
              vue.enable = false;
              fish.enable = false;
            };
          };
        };
      };
    };
}
