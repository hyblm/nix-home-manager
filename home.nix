{ pkgs, inputs, lib, ... }:


{
  imports =[
    inputs.xremap-flake.homeManagerModules.default
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = [
        "HDMI-A-2,preferred,0x0,1"
        ",preferred,auto,1"
      ];
    plugins = [
      # inputs.hyprland-plugins.packages."${pkgs.system}".hyprbars
      inputs.hycov.packages."${pkgs.system}".hycov
    ];
      plugin = {
        hycov = {
          overview_gappo = 60;
          overview_gappi = 24;
        };
      #   hyprbars = {
      #     bar_color = "rgba(12120ffa)";
      #     bar_height = 25;
      #     bar_buttons_alignment = "left";
      #     bar_part_of_window = true;
      #     bar_precedence_over_border = true;

      #     bar_title_enabled = true;
      #     bar_text_font = "Geist";
      #     "col.text" = "rgb(625e5a)";

      #     bar_button_padding = 10;
      #     bar_padding = 10;
      #     hyprbars-button = [
      #       "rgb(c4746e), 12, , hyprctl dispatch killactive"
      #       "rgb(c4b28a), 12, , hyprctl dispatch fullscreen 1"
      #       "rgb(8a9a7b), 12, , hyprctl dispatch fullscreen 1"
      #     ];
      #   };
      };
      exec-once = [
        "mako"
        "hyprpaper"
        "nm-applet"
        "waybar"
        # "foot --server"
        # "swww init"
        "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"
      ];

      env = [
        "XCURSOR_SIZE,24"
        "MOZ_ENABLE_WAYLAND,1"
        "OBSIDIAN_USE_WAYLAND,1"
      ];

      gestures = {
          workspace_swipe = true;
          workspace_swipe_fingers = 4;
          workspace_swipe_forever = true;
      };

      # device = {
      #     name = "ferris";
      # }

      input = {
          kb_layout = "recurva";
          # kb_variant = ",,qwerty";
          kb_options = "compose:prsc,shift:both_capslock";

          follow_mouse = 1;
          mouse_refocus = false;
          touchpad = {
              natural_scroll = true;
          };
      };

      general = {
          gaps_in = 4;
          gaps_out = 8;
          border_size = 3;

          "col.active_border"   = "rgba(d27e99dd) rgba(957fb8dd) 60deg";
          "col.inactive_border" = "rgba(2a2a2d00)";

          layout = "dwindle";
      };
      decoration = {
          rounding = 10;

          dim_inactive = true;
          dim_special = 0.8;
          dim_strength = 0.1;
          drop_shadow = true;
          shadow_scale = 0.995;
          shadow_range = 25;
          shadow_render_power = 2;
          shadow_offset = "2 2";
          "col.shadow" = "0x99000000";
          "col.shadow_inactive" = "0x00000000";

          blur = {
              new_optimizations = true;
              xray = true;
          };
      };

      "$mainMod" = "SUPER";
      bind = [
        "$mainMod, return, exec, kitty --single-instance"
        "$mainMod, Q, killactive, "
        "$mainMod SHIFT, backspace, exit, "
        "$mainMod, V, togglefloating, "
        "$mainMod, P, pseudo, # dwindle"
        "$mainMod, X, togglesplit, # dwindle"
        "$mainMod ALT, D, exec, pkill -SIGUSR1 waybar"
        "$mainMod ALT, W, exec, pkill -SIGUSR1 waybar"

        # Exposé
        # "$mainMod, escape, hycov:toggleoverview"
        

        # Screenshots
        "$mainMod CTRL, 3, exec, grim"
        ''$mainMod CTRL, 4, exec, grim -g (slurp)''

        "$mainMod, space, exec, rofi -show drun"
        "$mainMod CTRL, space, exec, rofimoji"
        "$mainMod, N, exec, rofi-todo"

        "$mainMod CTRL, O, exec, xdg-open obsidian://open?vault=Notes"
        "$mainMod CTRL, S, exec, xdg-open obsidian://open?vault=ShadowDark"

        # Move focus with mainMod + arrow keys
        # "$mainMod, left, movefocus, l"
        # "$mainMod, right, movefocus, r"
        # "$mainMod, up, movefocus, u"
        # "$mainMod, down, movefocus, d"

        "$mainMod, up, cyclenext,"
        "$mainMod, down, cyclenext, prev"
        "$mainMod SHIFT, up, swapnext,"
        "$mainMod SHIFT, down, swapnext, prev"

        "$mainMod CTRL, ., changegroupactive, f"
        "$mainMod CTRL, a, changegroupactive, b"
        "$mainMod CTRL SHIFT, G, togglegroup,"
        "$mainMod CTRL, escape, moveoutofgroup,"

        #osdcyclenextcyclenext
        ",XF86AudioRaiseVolume, exec, pamixer -i 5"
        ",XF86AudioLowerVolume, exec, pamixer -d 5"
        ",XF86AudioMute, exec, pamixer -t"
        ",XF86MonBrightnessUp, exec, brightnessctl set +10% "
        ",XF86MonBrightnessDown, exec, brightnessctl set 10%-"

        # Switch workspaces with mainMod + [0-9]
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        "$mainMod , tab, workspace, previous"

        "$mainMod, left, workspace, e-1"
        "$mainMod, right, workspace, e+1"
        "$mainMod SHIFT, left, movetoworkspace, e-1"
        "$mainMod SHIFT, right, movetoworkspace, e+1"
        "$mainMod, bracketleft, workspace, -1"
        "$mainMod, bracketright, workspace, +1"
        "$mainMod SHIFT, bracketleft, movetoworkspace, -1"
        "$mainMod SHIFT, bracketright, movetoworkspace, +1"

        "$mainMod, semicolon, togglespecialworkspace, comms"
        "$mainMod SHIFT, semicolon, movetoworkspace, special:comms"

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        "$mainMod CTRL, F, fullscreen, 0"
        "$mainMod, F, fakefullscreen,"
        "$mainMod, Y, fullscreen, 1"
        # "$mainMod CTRL SHIFT, P, togglefloating, active"
        "$mainMod CTRL SHIFT, P, pin, active"

        "$mainMod, O, focusmonitor, +1"
        "$mainMod SHIFT, O, movecurrentworkspacetomonitor, +1"
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      bindr = [ "$mainMod ALT, W, exec, pkill -SIGUSR1 waybar" ];
      # Move/resize windows with mainMod + LMB/RMB and dragging

      animations = {
          enabled = true;

              bezier = [
                "overshot,0.015,1.3,0.2,0.95"
                "ease-in,0.99,0,0.62,1.05"
                "light-ease-in,0.32,0,0.68,1"
                "linear,0,0,1,1"
              ];

              animation = [
              "windows,1,1,ease-in,popin"
              "windowsMove,1,2,overshot,popin"

              "fadeSwitch,0,1,ease-in"

              "border,1,20,overshot"
              "borderangle,1,50,light-ease-in,loop"

              "workspaces,1,3,overshot,slidevert"
              "specialWorkspace,1,3,overshot,slidevert"
              ];
      };

    };
    extraConfig = ''

      dwindle {
          # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
          pseudotile = yes # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
          preserve_split = yes # you probably want this
          # no_gaps_when_only = true
      }

      misc {
          disable_hyprland_logo = true
          disable_splash_rendering = true
          enable_swallow = true
          swallow_regex = .*kitty.*
      }

      # Example per-device config
      # See https://wiki.hyprland.org/Configuring/Keywords/#executing for more
      # device:epic-mouse-v1 {
      #     sensitivity = -0.5
      # }

      # Example windowrule v1
      windowrule = tile, ^(foot)$
      # Example windowrule v2
      # windowrulev2 = float,class:^(foot)$,title:^(kitty)$
      # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
      windowrulev2 = float,class:(Lispworks-.*),title:(micro-graphics)(.*)
      windowrulev2 = move onscreen 80% 10%,class:(Lispworks-.*),title:(micro-graphics)(.*)
      windowrulev2 = minsize 400 400,class:(Lispworks-.*),title:(micro-graphics)(.*)
      layerrule = blur, waybar
    '';
  };

  home.username = "matyas";
  home.homeDirectory = "/home/matyas";
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "electron-25.9.0"
    ];
  };

  home.packages = with pkgs; [
    ### Productivity tools of choice
    qmk
    qemu
    qutebrowser
    kitty
    jetbrains.rust-rover
    jetbrains.idea-community-bin
    morgen
    brave
    obsidian
    vscode

    ### Development tools
    sshfs
    python3
    gh
    gitoxide
    valgrind
    hyperfine
    just
    cmake
    gnumake
    hexyl
    gdb
    gf
    coreutils
    nasm
    rustup
    bacon
    corepack
    wget
    bottom
    tlrc # tldr

    ### Language Tools
    clang-tools
    odin
    clang
    stylua
    nodePackages.prettier
    eslint_d
    nodePackages_latest.typescript-language-server
    emmet-ls
    zls
    ols
    tailwindcss-language-server
    lua-language-server
    roswell
    nodejs

    ### Comunication
    discord
    ferdium
    telegram-desktop
    teams-for-linux

    ### Creative tools
    # blender
    krita
    gimp
    mypaint
    inkscape

    ### Games
    prismlauncher
    
    ### System Tools
    mpv
    ffmpegthumbnailer
    zathura
    asciiquarium
    fd
    ripgrep
    pastel
    watchexec
    blueman
    unzip
    libnotify
    killall
    procs
    pamixer
    brightnessctl
    pavucontrol
    zerotierone
    wl-clipboard
    oculante
    grim
    slurp
    hyprpicker
    rofi-wayland
    rofimoji
    hyprpaper
    mako
    neofetch

    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  services = {
    unclutter.enable = true;
    poweralertd.enable = true;

    darkman = {
      enable = true;
      settings = {
        lat = 49.59;
        lng = 17.25;
        usegeoclue = true;
        portal = true;
      };
      darkModeScripts = {
        gtk-theme = ''
          notify-send "🌑 "
         ${pkgs.dconf}/bin/dconf write /org/gnome/desktop/interface/color-scheme "'prefer-dark'"
         kitty +kitten themes Kanagawa_Dragon
        '';
      };
      lightModeScripts = {
        gtk-theme = ''
          notify-send "☀️ "
         ${pkgs.dconf}/bin/dconf write /org/gnome/desktop/interface/color-scheme "'prefer-light'"
         kitty +kitten themes Kanagawa_Light
        '';
      };
    };

    xremap = {
      withWlroots = true;
      config = {
        virtual_modifiers = ["capslock"];
        keymap = [
          {
             remap = {
                capslock-h = "left";
                capslock-j = "down";
                capslock-k = "up";
                capslock-l = "right";

                # capslock-n = "$";
                # capslock-y = "^";
                capslock-u = "leftbrace";
                capslock-i = "rightbrace";
                capslock-o = "minus";
                capslock-p = "equal";
                "capslock-semicolon" = "apostrophe";
             };
          }
        ];
        modmap = [
          {
            remap = {
              capslock = {
                held = "leftctrl";
                alone = "esc";
                alone_timeout_millis = 170;
              };
              enter = {
                held = "rightctrl";
                alone = "enter";
                alone_timeout_millis = 170;
              };
              leftalt = {
                held = "leftmeta";
                alone = "tab";
                alone_timeout_millis = 170;
              };
              rightalt = {
                held = "rightmeta";
                alone = "backspace";
                alone_timeout_millis = 170;
              };
              # btn_right = {
              #   alone = "enter";
              # };
              # Capslock is then remaped to switch languages
              leftctrl = "leftalt";
              rightctrl = "rightalt";
              leftmeta = "capslock";
              print = "rightalt";
            };
          }
        ];
      };
    };

    network-manager-applet.enable = true;
    gpg-agent = {
         enable = true;
         defaultCacheTtl = 1800;
         enableSshSupport = true;
       };
  };

  programs = {
      jujutsu.enable = true;
    yazi = {
      enable = true;
      enableNushellIntegration = true;
      settings = {
        append_previewers = [
          { mime = "*"; exec = "hexyl"; }
        ];
      };
    };

    # neovim.enable = true;
    helix.enable = true;

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    bash.enable = true;
    nushell = { enable = true;
      extraConfig = ''
        let carapace_completer = {|spans|
          carapace $spans.0 nushell $spans | from json
        }
        $env.config = {
          show_banner: false,
          completions: {
            case_sensitive: false
            quick: true
            partial: true
            algorithm: "fuzzy"
            external: {
              enable: true
              max_results: 100
              completer: $carapace_completer
            }
          }
          keybindings: [
            {
              name: lfcd
              modifier: control
              keycode: char_o
              mode: [emacs, vi_normal, vi_insert]
              event: {
                send: executehostcommand
                cmd: "lfcd"
              }
            }
          ]
        }
        $env.EDITOR = "nvim"
        $env.PATH = ($env.PATH | split row (char esep) |
        prepend /home/matyas/.apps |
        append /home/matyas/.cargo/bin |
        append /usr/bin/env
        )

    def --env lfcd [] {
      let tmp = (mktemp)
      lf -last-dir-path $tmp
      try {
        let target_dir = (open --raw $tmp)
        rm -f $tmp
        try {
            if ($target_dir != $env.PWD) { cd $target_dir }
        } catch { |e| print -e $'lfcd: Can not change to ($target_dir): ($e | get debug)' }
      } catch {
        |e| print -e $'lfcd: Reading ($tmp) returned an error: ($e | get debug)'
      }
    }
'';

    };

    starship = {
      enable = true;
      settings = {
        add_newline = false;
        character = {
          success_symbol = "[ 󱄅 ](bold blue)";
          error_symbol = "[ 󱄅 ](bold red)";
          # success_symbol = "[ ](bold blue)";
          # error_symbol = "[ ](bold red)";
        };
      };
    };

    zellij = {
      enable = true;
      settings = {
        simplified_ui = true;
        default_layout = "compact";
        default_shell = "nu";
        pane_frames = false;
        ui.pane_frames.hide_session_name = true;
        theme = "kanagawa_dragon";
        themes.kanagawa_dragon = {
		      bg = "#161617";
		      fg = "#c5c9c5";
		      red = "#ea83a5";
		      green = "#87a987";
		      blue = "#aca1cf";
		      yellow = "#e6b99d";
		      magenta = "#e29eca";
		      orange = "#f5a191";
		      cyan = "#7dcfff";
		      black = "#131314";
		      white = "#c5c9c5";
        };
      };
    };

    zoxide = {
      enable = true;
      enableNushellIntegration = true;
      options = [];
    };

    bat = {
      enable = true;
      config = {
        pager = "less -FR";
      };
    };

    ssh.enable = true;
    git = {
      enable = true;
      userName = "hyblm";
      userEmail = "hyma.code@gmail.com";
      diff-so-fancy = {
        enable = true;
        changeHunkIndicators = true;
      };
      extraConfig = {
        init = {
          defaultBranch = "main";
        };
        rebase = {
          updateRefs = true;
        };
      };
    };

    waybar = {
      enable = true;
      settings = {
        mainbar = {
          layer = "top";
          position = "right";
          margin-right = 0;

          modules-left = [ "hyprland/workspaces" ];
          modules-center = [ "wlr/taskbar" ];
          modules-right = [ "tray" "group/audio" "battery" "clock" ];

          tray = {
            icon-size = 24;
            spacing = 15;
            reverse-direction = true;
          };

          "group/audio" = {
            orientation = "inherit";
            drawer = {
              transition-duration = 500;
              transition-left-to-right = false;
            };
            modules = [ "wireplumber" "pulseaudio/slider" ];
          };
          # "hyprland/language" = {
          #   format = "{}";
          #   format-en = "🇺🇸";
          #   format-cs = "🇨🇿";
          # };

          "hyprland/workspaces" = {
            # active-only = true;
            # format = "<sub>{id}</sub>\n{windows}";
            format = "<span font-size=\"130%\">{windows}</span>\n<sub>{id}</sub>";
            format-window-separator = "\n";
            window-rewrite-default = "";
            window-rewrite = {
              "title<.*youtube.*>" = "󰗃";
              "class<firefox>" = "󰆋";
              "class<Brave-browser>" = "󰆋";
              "class<kitty>" = "󰄛";
              "class<foot>" = "";
              "title<.*helix.*>" = "󰚄";
              "title<.*nvim.*>" = "";
              "code" = "󰨞";
              "title<.*Notes.*>" = "󰻂";
              "title<.*ShadowDark.*>" = "";
              # "obsidian" = "󱎂 󱅕 󰂩󰯊";
            };
          };

          "wlr/taskbar" = {
              icon-size = 24;
              # sort-by-app-id = true;
              on-click = "activate";
              on-click-right = "fullscreen";
              on-click-middle = "close";
            };

          battery = {
            interval = 60;
            states = {
              warning = 30;
              critical = 15;
            };
            format-icons = ["󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
            format = "<span font-size=\"150%\">{icon}</span>\n{capacity}";
            format-charging = "<span font-size=\"150%\">⚡</span>\n  {capacity}";
          };
          upower = {
            icon-size = 32;
            format = "{}";
          };

          clock = {
            # format = "{:%a %b %e  %I:%M %p}";
            format = "{:%a\n%b\n  %e\n\n  %I\n  %M\n %p}";
            format-alt = "{:%a %e\n %I\n %M}";
          };

          wireplumber = {
            format = "<span font-size=\"130%\">{icon}</span>";
            # format = "{icon}\n {volume}";
            format-muted = "<span font-size=\"130%\">󰝟</span>";
            on-click = "pamixer -t";
            on-click-right = "pavucontrol";
            format-icons = ["" "" ""];
          };
          "pulseaudio/slider" = {
            orientation = "vertical";
          };

        };
      };

      style = ''
        * {
          font-family: "Geist, JetBrains Mono NerdFont";
          font-weight: 600;
          font-size: 13px;
        }

      window#waybar {
        background-color: rgba(11, 11, 10, 0.2);

       transition-property: background-color;
       transition-duration: .5s;
      }

      .modules-right {
        margin-bottom: 10px;
      }

      .modules-left {
        margin-top: 10px;
      }

      window#waybar.hidden {
        opacity: 0.2;
      }

#taskbar button        { padding: 5px 0; }
#taskbar button.active { border-right: 2px solid #ffffff; }

/** Common style **/
#backlight, 
#battery,
#clock,
#cpu,
#disk,
#mode,
#memory,
#mpd,
#tray,
#wireplumber,
#language,
#workspaces button,
#network {
  background-color: rgba(11, 11, 10, 0.0);
  border-radius: 10px;
margin: 6px 0px;
padding: 5px 2px;
}

#workspaces button {
  background-color: rgba(11,11,10,0.2);
  color: #aaaaaa;
}
#workspaces button.active { color: #ffffff; }

#pulseaudio-slider {
  min-height: 100px;
  margin-bottom: 0;
}

#pulseaudio-slider highlight {
  min-width: 15px;
  border-radius: 8px;
}

#wireplumber {
  margin-top: -6px;
  margin-right: 6px;
}

#tray > .passive {
  -gtk-icon-effect: dim;
}
#tray > .needs-attention {
  -gtk-icon-effect: highlight;
}
#tray > .active {
}

/************ Battery ************/
#battery.charging {
color: #f6c177;
}

#battery.plugged {
color: #90b99f;
}

@keyframes blink {
  to {
color: #000000;
  }
}

#battery.critical:not(.charging) {
  background-color: #f38ba8;
color: #f38ba8;
       animation-name: blink;
       animation-duration: 0.5s;
       animation-timing-function: linear;
       animation-iteration-count: infinite;
       animation-direction: alternate;
}

      '';
      systemd.enable = false;
    };
  };

  home.keyboard = null;
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.graphite-cursors;
    name = "graphite-dark";
  };

  gtk = {
    enable = true;
    theme = {
      # name = "WhiteSur-Dark-pink";
      # package = pkgs.graphite-gtk-theme.override {
      #     themeVariants = [ "all" ];
      #     tweaks = [ "black" "rimless" "normal" ];
      #     withGrub = true;
      #     darkerColor = true;
      #   };

      # package = pkgs.whitesur-gtk-theme.override {
      #     themeVariants = [ "all" ];
      #     darkerColor = true;
      #   };

      name = "Colloid-Pink-Dark";
      package = pkgs.colloid-gtk-theme.override {
          themeVariants = [ "pink" ];
          tweaks = [ "black" ];
        };

    };
    iconTheme = {
        name = "WhiteSur-pink";
        package = pkgs.whitesur-icon-theme.override {
            boldPanelIcons = true;
            themeVariants = [ "all" ];
          };
    };

    cursorTheme.package = pkgs.graphite-cursors;
    cursorTheme.name = "graphite-dark";
  };

  # TODO: Test this
  # xdg.mimeApps = {
  #   enable = true;
  #   defaultApplications = {
  #     # "text/html" = [ "brave.desktop" "firefox.desktop" ];
  #   };
  # };

  home.stateVersion = "22.11";
  programs.home-manager.enable = true;
}
