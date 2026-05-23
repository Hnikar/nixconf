{ self, inputs, ... }:
{
  flake.nixosModules.communicationApps =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        fractal
        mumble
        signal-desktop
        telegram-desktop
      ];
    };
}
