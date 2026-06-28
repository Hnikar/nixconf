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

      system.activationScripts.sddmUserFaces.text = ''
        if [ -e /home/izanagi/.face ]; then
          ${pkgs.coreutils}/bin/install -Dm0644 \
            /home/izanagi/.face \
            /var/lib/sddm/faces/izanagi.face.icon
        fi
      '';

      services.displayManager = {
        defaultSession = "niri";

        sddm = {
          enable = true;
          wayland.enable = true;
          theme = "tidy-sddm";
          settings.Theme.FacesDir = "/var/lib/sddm/faces";
          extraPackages = with pkgs.kdePackages; [
            qtsvg
            qtdeclarative
          ];
        };
      };
    };
}
