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

        # Misc
        self.nixosModules.creamlinux
      ];

      # Networking
      networking = {
        hostName = "Amaterasu";
        timeServers = [ "192.168.88.1" ];
        nameservers = [ "192.168.88.44" ];
      };

      # System packages
      environment.systemPackages = with pkgs; [
        # Media
        foliate
        joplin-desktop
        obs-studio
        osu-lazer-bin
        prismlauncher
        vlc

        # Misc
        qbittorrent
      ];

      users.users.izanagi.description = "Izanagi";
    };
}
