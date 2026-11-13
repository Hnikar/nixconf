{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.hostAmaterasuConfiguration =
    {
      pkgs,
      pkgs-unstable,
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
        timeServers = [ "192.168.50.1" ];
        nameservers = [ "192.168.20.88" ];
      };

      # System packages
      environment.systemPackages =
        with pkgs;
        [
          # Media
          foliate
          joplin-desktop
          obs-studio
          vlc
        ]
        ++ (with pkgs-unstable; [
          osu-lazer-bin
        ]);

      users.users.izanagi.description = "Izanagi";
    };
}
