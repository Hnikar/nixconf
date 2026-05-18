{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.flatpak =
    {
      pkgs,
      ...
    }:
    {
      imports = [ inputs.nix-flatpak.nixosModules.nix-flatpak ];
      services.flatpak = {
        enable = true;
        packages = [
          "org.gtk.Gtk3theme.adw-gtk3-dark"
          "org.gtk.Gtk3theme.adw-gtk3"
        ];
      };
    };
}
