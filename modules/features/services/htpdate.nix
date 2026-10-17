{ self, inputs, ... }:
{
  flake.nixosModules.htpdate =
    { pkgs, ... }:
    {
      services.timesyncd.enable = false;

      systemd.services.htpdate = {
        description = "HTTP time synchronization";
        wantedBy = [ "multi-user.target" ];
        after = [ "network-online.target" ];
        wants = [ "network-online.target" ];
        serviceConfig = {
          ExecStart = "${pkgs.htpdate}/bin/htpdate -F -s -l www.google.com www.cloudflare.com www.microsoft.com";
          Restart = "on-failure";
          RestartSec = "30s";
        };
      };
    };
}
