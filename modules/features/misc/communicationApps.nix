{ self, inputs, ... }:
{
  flake.nixosModules.communication = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      cinny-desktop
      mumble
      signal-desktop
      telegram-desktop
    ];
  };
}