{ self, inputs, ... }:
{
  flake.nixosModules.defaultApps =
    { pkgs, username, ... }:
    {
      home-manager.users.${username} = {
        xdg.mimeApps = {
          enable = true;
          defaultApplications = {
            "inode/directory" = "org.gnome.Nautilus.desktop";
            "application/pdf" = "org.gnome.Papers.desktop";
            "image/avif" = "org.gnome.Loupe.desktop";
            "image/bmp" = "org.gnome.Loupe.desktop";
            "image/gif" = "org.gnome.Loupe.desktop";
            "image/heic" = "org.gnome.Loupe.desktop";
            "image/jpeg" = "org.gnome.Loupe.desktop";
            "image/jxl" = "org.gnome.Loupe.desktop";
            "image/png" = "org.gnome.Loupe.desktop";
            "image/svg+xml" = "org.gnome.Loupe.desktop";
            "image/tiff" = "org.gnome.Loupe.desktop";
            "image/webp" = "org.gnome.Loupe.desktop";
          };
        };
      };
    };
}
