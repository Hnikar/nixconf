{ self, inputs, ... }:
{
  flake.nixosModules.creamlinux =
    { pkgs, ... }:
    {
      environment.systemPackages = [
        (import inputs.creamlinux-installer { inherit pkgs; })
      ];
    };
}
