{ self, inputs, ... }: 
{
  flake.nixosModules.razer = { pkgs, username, ... }: {
    hardware.openrazer.enable = true;
    # Optional: Install a GUI front-end like Polychromatic
    environment.systemPackages = with pkgs; [ polychromatic ];
    users.users.${username}.extraGroups = [ "openrazer" ];
  };
}