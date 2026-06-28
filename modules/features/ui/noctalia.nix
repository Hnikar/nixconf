{ self, inputs, ... }: {
  flake.nixosModules.noctalia = { pkgs, username, ... }: {
    home-manager.users.${username} = {
      imports = [
        inputs.noctalia.homeModules.default
      ];
      programs.noctalia-shell = {
        enable = true;
        settings = (builtins.fromJSON (builtins.readFile ./noctalia.json)).settings;
        plugins = {
        sources = [
          {
            enabled = true;
            name = "Official Noctalia Plugins";
            url = "https://github.com/noctalia-dev/noctalia-plugins";
          }
        ];
        states = {
          clipboard = {
            enabled = true;
            sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
          };
          "kde-connect" = {
            enabled = false;
            sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
          };
          "polkit-agent" = {
            enabled = true;
            sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
          };
          "privacy-indicator" = {
            enabled = true;
            sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
          };
          tailscale = {
            enabled = true;
            sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
          };
        };
        version = 2;
      };
      };
    };
  };
}
