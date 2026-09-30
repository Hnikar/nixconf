{ self, inputs, ... }:
{
  flake.nixosModules.discord =
    { pkgs-unstable, ... }:
    {
      environment.systemPackages = with pkgs-unstable; [
        vesktop
      ];
    };
}
