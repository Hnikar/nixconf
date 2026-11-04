{ self, inputs, ... }:
{
  flake.nixosModules.networking =
    { pkgs-unstable, ... }:
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
      programs.winbox = {
        enable = true;
        openFirewall = true;
        package = pkgs-unstable.winbox;
      };
    };
}
