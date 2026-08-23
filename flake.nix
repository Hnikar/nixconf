{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/26.05";

    flake-parts.url = "github:hercules-ci/flake-parts";

    import-tree.url = "github:vic/import-tree";

    niri.url = "github:sodiboo/niri-flake";

    spicetify-nix.url = "github:Gerg-L/spicetify-nix";

    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";

    millennium.url = "github:SteamClientHomebrew/Millennium?dir=packages/nix";

    creamlinux-installer = {
      url = "github:Novattz/creamlinux-installer";
      flake = false;
    };

    distro-grub-themes.url = "github:AdisonCavani/distro-grub-themes";

    noctalia = {
      url = "github:noctalia-dev/noctalia/legacy-v4";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia-greeter = {
      url = "github:noctalia-dev/noctalia-greeter";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wrapper-modules.url = "github:BirdeeHub/nix-wrapper-modules";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mac-style-plymouth = {
      url = "github:SergioRibera/s4rchiso-plymouth-theme";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf = {
      url = "github:NotAShelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.6.0";

    ## Non-flakes
    tidy-sddm = {
      url = "github:loadfred/tidy-sddm/v0.4";
      flake = false;
    };
  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules);
}
