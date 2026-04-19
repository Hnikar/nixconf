{ self, inputs, ... }: {
  flake.nixosModules.fish = { pkgs, username, ...}: {
    home-manager.users.${username} = {
    programs.fish = {
      enable = true;
      package = pkgs.fish;
    };
  };
  users.${username}.shell = pkgs.fish;
  };
}