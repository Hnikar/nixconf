{ self, inputs, ... }: 
{
  flake.nixosModules.razer = { pkgs, ... }: {
    hardware.openrazer.enable = true;
    # Optional: Install a GUI front-end like Polychromatic
    environment.systemPackages = with pkgs; [ polychromatic ];
  };
}