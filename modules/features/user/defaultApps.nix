{ self, inputs, ... }:
{
  flake.nixosModules.defaultApps =
    { pkgs, username, ... }:
    let
      urlRules = [
        {
          name = "steam";

          patterns = [
            ''^https?://(store\.)?steampowered\.com/''
            ''^https?://steamcommunity\.com/''
          ];

          command = "${pkgs.steam}/bin/steam";
          transform = "steam://openurl/$url";
        }

        {
          name = "spotify";
          patterns = [
            ''^https?://open\.spotify\.com/''
          ];
          command = "${pkgs.spotify}/bin/spotify";
        }
      ];

      regex-url-handler = pkgs.writeShellScriptBin "regex-url-handler" ''
                set -euo pipefail

                url="''${1:-}"

                if [[ -z "$url" ]]; then
                  exit 1
                fi
        ${builtins.concatStringsSep "\n" (
          builtins.concatMap (
            rule:
            map (pattern: ''
              if [[ "$url" =~ ${pattern} ]]; then
                exec ${rule.command} "${rule.transform or "$url"}"
              fi
            '') rule.patterns
          ) urlRules
        )}

                # Everything that doesn't match a special application
                # is opened by the normal browser.
                exec ${pkgs.brave}/bin/brave "$url"
      '';
    in
    {
      home-manager.users.${username} = {
        home.packages = [
          regex-url-handler
        ];

        xdg.desktopEntries.regex-url-handler = {
          name = "Regex URL Handler";
          exec = "${regex-url-handler}/bin/regex-url-handler %u";
          terminal = false;
          type = "Application";
          categories = [ "Network" ];

          mimeType = [
            "x-scheme-handler/http"
            "x-scheme-handler/https"
          ];
        };

        xdg.mimeApps = {
          enable = true;

          defaultApplications = {
            "inode/directory" = "org.gnome.Nautilus.desktop";

            "application/xhtml+xml" = "brave-browser.desktop";
            "text/html" = "brave-browser.desktop";

            "x-scheme-handler/about" = "brave-browser.desktop";
            "x-scheme-handler/http" = "regex-url-handler.desktop";
            "x-scheme-handler/https" = "regex-url-handler.desktop";
            "x-scheme-handler/unknown" = "brave-browser.desktop";

            "x-scheme-handler/steam" = "steam.desktop";

            "application/pdf" = "org.gnome.Papers.desktop";
            "application/epub+zip" = "com.github.johnfactotum.Foliate.desktop";
            "application/vnd.amazon.mobi8-ebook" = "com.github.johnfactotum.Foliate.desktop";
            "application/x-mobipocket-ebook" = "com.github.johnfactotum.Foliate.desktop";

            "image/apng" = "org.gnome.Loupe.desktop";
            "image/avif" = "org.gnome.Loupe.desktop";
            "image/bmp" = "org.gnome.Loupe.desktop";
            "image/gif" = "org.gnome.Loupe.desktop";
            "image/heic" = "org.gnome.Loupe.desktop";
            "image/jp2" = "org.gnome.Loupe.desktop";
            "image/jpeg" = "org.gnome.Loupe.desktop";
            "image/jxl" = "org.gnome.Loupe.desktop";
            "image/png" = "org.gnome.Loupe.desktop";
            "image/qoi" = "org.gnome.Loupe.desktop";
            "image/svg+xml" = "org.gnome.Loupe.desktop";
            "image/svg+xml-compressed" = "org.gnome.Loupe.desktop";
            "image/tiff" = "org.gnome.Loupe.desktop";
            "image/vnd.microsoft.icon" = "org.gnome.Loupe.desktop";
            "image/webp" = "org.gnome.Loupe.desktop";
            "image/x-portable-anymap" = "org.gnome.Loupe.desktop";
            "image/x-portable-bitmap" = "org.gnome.Loupe.desktop";
            "image/x-portable-graymap" = "org.gnome.Loupe.desktop";
            "image/x-portable-pixmap" = "org.gnome.Loupe.desktop";
            "image/x-tga" = "org.gnome.Loupe.desktop";
            "image/x-win-bitmap" = "org.gnome.Loupe.desktop";
            "image/x-xbitmap" = "org.gnome.Loupe.desktop";
            "image/x-xpixmap" = "org.gnome.Loupe.desktop";

            "audio/aac" = "org.gnome.Decibels.desktop";
            "audio/flac" = "org.gnome.Decibels.desktop";
            "audio/mpeg" = "org.gnome.Decibels.desktop";
            "audio/ogg" = "org.gnome.Decibels.desktop";
            "audio/wav" = "org.gnome.Decibels.desktop";
            "audio/webm" = "org.gnome.Decibels.desktop";
            "audio/x-aac" = "org.gnome.Decibels.desktop";
            "audio/x-aiff" = "org.gnome.Decibels.desktop";
            "audio/x-flac" = "org.gnome.Decibels.desktop";
            "audio/x-m4a" = "org.gnome.Decibels.desktop";
            "audio/x-m4b" = "org.gnome.Decibels.desktop";
            "audio/x-mp3" = "org.gnome.Decibels.desktop";
            "audio/x-opus+ogg" = "org.gnome.Decibels.desktop";
            "audio/x-vorbis+ogg" = "org.gnome.Decibels.desktop";
            "audio/x-wav" = "org.gnome.Decibels.desktop";

            "video/mp4" = "org.gnome.Showtime.desktop";
            "video/mpeg" = "org.gnome.Showtime.desktop";
            "video/ogg" = "org.gnome.Showtime.desktop";
            "video/quicktime" = "org.gnome.Showtime.desktop";
            "video/webm" = "org.gnome.Showtime.desktop";
            "video/x-matroska" = "org.gnome.Showtime.desktop";
            "video/x-msvideo" = "org.gnome.Showtime.desktop";

            "text/markdown" = "org.gnome.TextEditor.desktop";
            "text/plain" = "org.gnome.TextEditor.desktop";
            "text/x-log" = "org.gnome.TextEditor.desktop";

            "application/gzip" = "org.gnome.FileRoller.desktop";
            "application/vnd.rar" = "org.gnome.FileRoller.desktop";
            "application/x-7z-compressed" = "org.gnome.FileRoller.desktop";
            "application/x-bzip2" = "org.gnome.FileRoller.desktop";
            "application/x-compressed-tar" = "org.gnome.FileRoller.desktop";
            "application/x-tar" = "org.gnome.FileRoller.desktop";
            "application/zip" = "org.gnome.FileRoller.desktop";

            "application/msword" = "onlyoffice-desktopeditors.desktop";
            "application/vnd.ms-excel" = "onlyoffice-desktopeditors.desktop";
            "application/vnd.ms-powerpoint" = "onlyoffice-desktopeditors.desktop";
            "application/vnd.oasis.opendocument.presentation" = "onlyoffice-desktopeditors.desktop";
            "application/vnd.oasis.opendocument.spreadsheet" = "onlyoffice-desktopeditors.desktop";
            "application/vnd.oasis.opendocument.text" = "onlyoffice-desktopeditors.desktop";
            "application/vnd.openxmlformats-officedocument.presentationml.presentation" =
              "onlyoffice-desktopeditors.desktop";
            "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" =
              "onlyoffice-desktopeditors.desktop";
            "application/vnd.openxmlformats-officedocument.wordprocessingml.document" =
              "onlyoffice-desktopeditors.desktop";
          };
        };
      };
    };
}
