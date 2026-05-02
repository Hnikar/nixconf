{ self, inputs, ... }: 
{
  flake.nixosModules.defaultApps = { pkgs, username, ... }: {
    home-manager.users.${username} = {
      xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "inode/directory" = "org.gnome.Nautilus.desktop";
      };
    };
    };
  };
}