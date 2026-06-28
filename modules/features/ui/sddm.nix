{ self, inputs, ... }:
{
  flake.nixosModules.sddm =
    { pkgs, ... }:
    let
      tidy-sddm-gruvbox-dark = pkgs.stdenvNoCC.mkDerivation {
        pname = "tidy-sddm-gruvbox-dark";
        version = "0.4";
        src = inputs.tidy-sddm;

        dontBuild = true;

        installPhase = ''
          runHook preInstall

          mkdir -p $out/share/sddm/themes/tidy-sddm
          cp -r . $out/share/sddm/themes/tidy-sddm
          chmod -R u+w $out/share/sddm/themes/tidy-sddm
          substituteInPlace $out/share/sddm/themes/tidy-sddm/theme.conf \
            --replace-fail "palette=Breeze Dark" "palette=Gruvbox Dark"

          runHook postInstall
        '';
      };
    in
    {
      environment.systemPackages = [ tidy-sddm-gruvbox-dark ];

      services.displayManager = {
        defaultSession = "niri";

        sddm = {
          enable = true;
          wayland.enable = true;
          theme = "tidy-sddm";
          extraPackages = [ pkgs.kdePackages.qtsvg ];
        };
      };
    };
}
