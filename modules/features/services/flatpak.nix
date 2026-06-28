{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.flatpak =
    {
      lib,
      pkgs,
      ...
    }:
    {
      imports = [ inputs.nix-flatpak.nixosModules.nix-flatpak ];
      environment.sessionVariables.XDG_DATA_DIRS = lib.mkBefore [
        "$HOME/.local/share/flatpak/exports/share"
        "/var/lib/flatpak/exports/share"
      ];
      services.flatpak = {
        enable = true;
        packages = [
          # "org.gtk.Gtk3theme.adw-gtk3-dark"
          # "org.gtk.Gtk3theme.adw-gtk3"
          {
            appId = "com.bitwarden.desktop";
            origin = "flathub";
          }
          {
            appId = "com.github.tchx84.Flatseal";
            origin = "flathub";
          }
        ];
        update.auto = {
          enable = true;
          onCalendar = "weekly";
        };
        uninstallUnmanaged = true;
        uninstallUnused = true;
      };
    };
}
