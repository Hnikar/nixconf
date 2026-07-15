{ self, inputs, ... }:
{
  flake.nixosModules.hostTsukuyomiConfiguration =
    { pkgs, lib, ... }:
    {
      imports = [
        # Hardware and boot
        self.nixosModules.hostTsukuyomiHardware
        self.nixosModules.hostCommon
      ];

      # Bootloader
      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;

      # Enable CUPS to print documents.
      services.printing.enable = true;

      # Networking
      networking.hostName = "Tsukuyomi";

      # Laptop power and battery reporting
      services.power-profiles-daemon.enable = true;
      services.thermald.enable = true;
      services.upower.enable = true;
      services.iio-niri = {
        enable = true;
        extraArgs = [
          "--monitor"
          "eDP-1"
        ];
      };
      powerManagement.powertop.enable = true;
      hardware.enableAllFirmware = true;

      services.logind.settings.Login = {
        HandleLidSwitch = "suspend";
        HandleLidSwitchExternalPower = "ignore";
      };

      # System packages
      environment.systemPackages = with pkgs; [
        # Misc
      ];

      users.users.nozuchi.description = "Nozuchi";
    };
}
