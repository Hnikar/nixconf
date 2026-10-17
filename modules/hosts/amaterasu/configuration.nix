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
      networking.hostName = "Amaterasu";
      networking.timeServers = [ "192.168.88.1" ];

      # System packages
      environment.systemPackages = with pkgs; [
        # Media
        foliate
        joplin-desktop
        obs-studio
        osu-lazer-bin
        prismlauncher
        vlc

        # Productivity
        qbittorrent
      ];

      users.users.izanagi.description = "Izanagi";
    };
}
