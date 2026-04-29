{ self, inputs, ... }:
{
  flake.nixosModules.keyring = { pkgs, lib, ... }: {
    services.gnome.gnome-keyring.enable = true;
    security.pam.services.login.enableGnomeKeyring = true;
    environment.systemPackages = with pkgs; [
      gnome-keyring
      seahorse
    ];
  };
}
