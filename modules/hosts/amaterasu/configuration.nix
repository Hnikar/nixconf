{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.hostAmaterasuConfiguration =
    {
      pkgs,
      lib,
      ...
    }:
    {
      imports = [
        # Hardware and boot
        self.nixosModules.hostCommon
        self.nixosModules.hostAmaterasuHardware
        self.nixosModules.grub

        # Services and hardware helpers
        self.nixosModules.openTabletDriver
        self.nixosModules.containerTools

        # App suites
        self.nixosModules.gaming
      ];

      # Networking
      networking.hostName = "Amaterasu";

      networking.interfaces."enp8s0".ipv4.addresses = [
        {
          address = "192.168.69.2";
          prefixLength = 24;
        }
      ];

      # System packages
      environment.systemPackages = with pkgs; [
        # Media
        foliate
        joplin-desktop
        obs-studio
        osu-lazer-bin
        prismlauncher
        rimsort
        vlc

        # Productivity
        qbittorrent
      ];

      users.users.izanagi.description = "Izanagi";
    };
}
