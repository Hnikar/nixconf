{ self, inputs, ... }:
{
  flake.nixosModules.pipewire = { pkgs, ... }:
    {
      environment.systemPackages = [ pkgs.pavucontrol ];
      services.pipewire.extraConfig.pipewire."91-null-sinks" = {
        "context.objects" = [
          {
            factory = "spa-node-factory";
            args = {
              "factory.name" = "support.node.driver";
              "node.name" = "Dummy-Driver";
              "priority.driver" = 8000;
            };
          }
        ];
      };
    };
}