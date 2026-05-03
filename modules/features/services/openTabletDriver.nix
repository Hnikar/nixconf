{ self, inputs, ... }:
{
  flake.nixosModules.openTabletDriver = { pkgs, lib, ... }: {
    hardware.opentabletdriver.enable = true;
    hardware.uinput.enable = true;
    boot.kernelModules = [ "uinput" ];
  };
}