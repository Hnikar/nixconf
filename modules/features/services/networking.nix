{ self, inputs, ... }:
{
  flake.nixosModules.networking =
    { ... }:
    {
      networking.networkmanager = {
        enable = true;
        wifi = {
          powersave = false;
          macAddress = "stable-ssid";
          scanRandMacAddress = false;
          backend = "iwd";
        };
      };
    };
}
