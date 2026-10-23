{
  flake.nixosModules.console =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      environment.systemVariables = {
        NU_EXPERIMENTAL_OPTIONS = "native-clip";
        STARSHIP_LOG = "error";
        CARAPACE_BRIDGES = "zsh,fish,bash,inshellisense";
      };
      programs = {
        nushell = {
          enable = true;
          plugins = with pkgs.nushellPlugins; [
            formats
            query
            highlight
            units
            desktop_notifications
          ];
          interactiveShellInit = ''
            if $env.TERM? != "dumb" {
              source ${
                pkgs.runCommand "carapace-nushell-config.nu" { }
                  ''${pkgs.carapace} _carapace nushell | sed 's|"/homeless-shelter|$"($env.HOME)|g' >> "$out"''
              }
            }
          '';
        };
        bash = {
          enable = true;
          completion.enable = true;
          shellAliases = {
            btw = ''print "I use NixOS, btw"'';
            vi = "hx";
            vim = "hx";

            e = "exit";
            lg = "lazygit";
            gw = "./gradlew";
            cr = "cargo run";
            crq = "cr --quiet";
            cb = "cargo build";
            cbq = "cb --quiet";
            ct = "cargo test";
            ctq = "ct --quiet";
            ".." = "z ..";
            "..." = "z ../..";
            "3.." = "z ../../..";
            "4.." = "z ../../../..";
            "5.." = "z ../../../../";
          };
        };
        zoxide = {
          enable = true;
          enableBashIntegration = true;
        };
      };

      hjem.users.${config.preferences.user.name}.rum.programs = {
        zoxide = {
          enable = true;
          integrations.nushell.enable = true;
        };
        nushell = {
          enable = true;
          aliases = {
            btw = ''print "I use NixOS, btw"'';
            vi = "hx";
            vim = "hx";

            e = "exit";
            lg = "lazygit";
            reload = "exec nu";
            gw = "./gradlew";
            cr = "cargo run";
            crq = "cr --quiet";
            cb = "cargo build";
            cbq = "cb --quiet";
            ct = "cargo test";
            ctq = "ct --quiet";
            ".." = "z ..";
            "..." = "z ../..";
            "3.." = "z ../../..";
            "4.." = "z ../../../..";
            "5.." = "z ../../../../";
          };

          settings = {
            show_banner = false;
            buffer_editor = "nvim";
            use_kitty_protocol = true;
            edit_mode = "helix";
            completions.algorithm = "fuzzy";
            highlight_resolved_externals = true;
          };

          extraConfig =
            let
              starship = lib.getExe pkgs.starship;
            in
            ''
              def --env get-env [name] { $env | get $name }
              def --env set-env [name, value] { load-env { $name: $value } }
              def --env unset-env [name] { hide-env $name }

              def greeter []: nothing -> string {
                $"\n  (ansi black_bold)(ansi {bg: black})(ansi "#5BCFFA") Ｈ(ansi "#F5ABB9")ｅ(ansi white)ｌ(ansi "#F5ABB9")ｌ(ansi "#5BCFFA")ｏ　(ansi "#5BCFFA")Ｋ(ansi "#F5ABB9")ｏ(ansi white)ｄ(ansi "#F5ABB9")ｉ(ansi "#5BCFFA")ｅ (ansi "#5BCFFA") (ansi "#F5ABB9") (ansi {fg: black, bg: none})(ansi rst)"
              }

              def --env --wrapped clear [...rest: string] { ^clear ...$rest; print (greeter)}
              alias c = clear

              def --env --wrapped blkid [...rest: string] {
                sudo ^blkid ...$rest
                | lines
                | parse -r '^(?<DEV>\S+):(?:\s+LABEL="(?<LABEL>\S+)")?\s+UUID="(?<UUID>\S+)"(?:\s+UUID_SUB="(?<UUID_SUB>\S+)")?(?:\s+BLOCK_SIZE="(?<BLOCK_SIZE>\S+)")?\sTYPE="(?<TYPE>\S+)"(?:\s+PARTLABEL="(?<PARTLABEL>\S+)")?(?:\s+PARTUUID="(?<PARTUUID>\S*)")?'
                | sort-by BLOCK_SIZE
              }

              def ztls [] {
                sudo zerotier-cli listnetworks | str replace -m -r -a '200 listnetworks ' "" | lines | skip 1 | split column ' ' 'id' 'name' 'mac' 'status' 'type' 'dev' 'ip'
              }

              def --env --wrapped df [...rest: string] {
                df -h ...$rest | lines | skip 1 | split column -r  '\s+' filesystem 1K-blocks Used Available Use% "Mounted On" | sort
              }

              print (greeter)

              export-env { load-env {
                  SUDO_PROMPT: (^${starship} prompt --profile=sudo_prompt --terminal-width=((term size).columns) --jobs=(job list | length)))
                  PROMPT_MULTILINE_INDICATOR: (^${starship} prompt --continuation)
                  TRANSIENT_PROMPT_MULTILINE_INDICATOR: (^${starship} prompt --continuation)
                  TRANSIENT_PROMPT_INDICATOR: ""
                  TRANSIENT_PROMPT_COMMAND: {|| (^${starship} prompt --profile=transient --terminal-width=((term size).columns) --jobs=(job list | length)) }
              }}

              $env.config.hooks.pre_prompt = ($env.config.hooks.pre_prompt?
              | default []
              | append {||
                ${lib.getExe pkgs.direnv} export json
                | from json --strict
                | default {}
                | items {|key, value|
                  let value = do (
                    {
                      "PATH": {
                        from_string: {|s| $s | split row (char esep) | path expand --no-symlink }
                        to_string: {|v| $v | path expand --no-symlink | str join (char esep) }
                      }
                    }
                    | merge ($env.ENV_CONVERSIONS? | default {})
                    | get ([[value, optional, insensitive]; [$key, true, true] [from_string, true, false]] | into cell-path)
                    | if ($in | is-empty) { {|x| $x} } else { $in }
                  ) $value
                  return [ $key $value ]
                }
                | into record
                | load-env
              })
            '';
        };
      };
    };
}
