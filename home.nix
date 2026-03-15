{ config, pkgs, ...}:
let
    dotfiles = "${config.home.homeDirectory}/dotfiles/config";
    create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
    configs = {
      hypr = "hypr";
      nvim = "nvim";
      noctalia = "noctalia";
    };
in
{
    home.username = "zm";
    home.homeDirectory = "/home/zm";
    home.stateVersion = "25.11";
    home.sessionVariables = {
        EDITOR = "nvim";
        VISUAL = "nvim";
    };

    programs.bash = {
        enable = true;
        shellAliases = {
            la = "eza -la";
            lt = "eza -laT";
            ff = "fastfetch";
            pk = "pokemon-colorscripts -r";
        };
        profileExtra = ''
            if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
                exec start-hyprland
            fi
        '';
        # initExtra = ''
        #     if [[ $SHLVL -eq 1 ]]; then
        #         fastfetch
        #         # colorscript -r
        #         # pokemon-colorscripts -r
        #     fi
        # '';
    };

    programs.git = {
        enable = true;
        settings = {
            init.defaultBranch = "main";
            user.useConfigOnly = true;
            credential = {
                helper = "manager";
                credentialStore = "cache";
            };
        };
    };

    programs.kitty = {
        enable = true;
        font = {
            name = "Maple Mono NF CN";
            size = 12;
        };
        settings = {
            confirm_os_window_close = 0;
        };        
        extraConfig = ''
            include themes/noctalia.conf
        '';
    };

    programs.starship = {
        enable = true;
        presets = [
            "nerd-font-symbols"
        ];
        settings = {
            container.disabled = false;
            hostname.ssh_only = true;
            username = {
                show_always = true;
                disabled = false;
                };
            os.disabled = false;
            cmd_duration = {
                min_time = 100;
                show_milliseconds = true;
            }; 
        };
    };

    programs.fastfetch = {
        enable = true;
        settings = {
            logo = {
                source = "nixos_small";
                padding = {
                    left = 3;
                };
            };
            modules = [
                {
                    type = "title";
                    color = {
                        user = "green";
                        host = "blue";
                    };
                }
                "os"
                "kernel"
                "packages"
                "memory"
                "disk"
            ];
        };
    };
    
    i18n.inputMethod = {
      type = "fcitx5";
      enable = true;
      fcitx5.addons = with pkgs; [
        kdePackages.fcitx5-chinese-addons
        fcitx5-gtk
      ];
      fcitx5.settings.addons = {
        classicui.globalSection.Font = "Maple Mono NF CN 12";
        classicui.globalSection.Theme = "noctalia";
        pinyin.globalSection.CloudPinyinEnabled = "True";
      };
      fcitx5.waylandFrontend = true;
      fcitx5.settings.inputMethod = {
        GroupOrder."0" = "Default";
        "Groups/0" = {
          Name = "Default";
          "Default Layout" = "us";
          DefaultIM = "pinyin";
        };
        "Groups/0/Items/0".Name = "keyboard-us";
        "Groups/0/Items/1".Name = "pinyin";  
      };
    };

    programs.bat = {
        enable = true;
        config = {
            theme = "Catppuccin Mocha";
        };
        themes = {
            src.src = pkgs.fetchFromGitHub {
                owner = "catppuccin";
                repo = "bat";
                rev = "6810349b28055dce54076712fc05fc68da4b8ec0";
                sha256 = "lJapSgRVENTrbmpVyn+UQabC9fpV1G1e+CdlJ090uvg=";
            };
            src.file = "themes/Catppuccin Mocha.tmTheme";
        };
    };

    programs.zathura = {
        enable = true;
        options = {
            adjust-open = "best-fit";
            recolor = true;
            recolor-keephue = true;
            render-loading = true;
        };
        extraConfig = ''
            include noctaliarc
        '';
    };

    xdg.configFile = builtins.mapAttrs
      (name: subpath: {
        source = create_symlink "${dotfiles}/${subpath}";
        recursive = true;
      })
      configs;

    home.packages = with pkgs; [
        noctalia-shell
        neovim
        helix
        yazi
        btop
        dwt1-shell-color-scripts
        pokemon-colorscripts
        firefox
        pywalfox-native
        adw-gtk3
        nwg-look
        kdePackages.qt6ct
    ];
}

