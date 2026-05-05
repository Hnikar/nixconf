{ self, inputs, ... }:
{
  flake.nixosModules.communicationApps = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      cinny-desktop
      mumble
      signal-desktop
      telegram-desktop
    ];
  };
}