{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "simon";
  home.homeDirectory = "/home/simon";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # Add this to allow unfree packages in Home Manager
  nixpkgs.config.allowUnfree = true;

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    pkgs.brave
    pkgs.claude-code
    pkgs.youtube-tui
    pkgs.mpv
    pkgs.obsidian
    pkgs.ranger
    pkgs.steam
    # pkgs.git
    pkgs.wl-clipboard
    pkgs.lazygit
    pkgs.btop
    pkgs.yq-go
    pkgs.ghostty

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })



    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
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

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/simon/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
    SHELL = "${pkgs.zsh}/bin/zsh";
  };

	programs.zsh = {
	  enable = true;
	  shellAliases.ll = "ls -la";
	  initContent = "source ~/.env &>>/tmp/zsh_env.logs";
	};

  # Git configuration
  programs.git = {
    enable = true;
    settings.user = {
      name = "Simon Hryszko";
      email = "simonhryszko@gmail.com";
    };
  };

  # Syncthing service
  services.syncthing = {
    enable = true;
    tray.enable = true;
    guiAddress = "127.0.0.1:8384";
  };

  # Sway window manager configuration
  wayland.windowManager.sway = {
    enable = true;
    config = {
      modifier = "Mod4";
      terminal = "ghostty";

      bars = [
        {
          position = "top";
          statusCommand = "while true; do date +'%Y-%m-%d %H:%M'; sleep 60; done";
        }
      ];
    };
  };

  # Ghostty terminal configuration
  programs.ghostty = {
    enable = true;
    settings = {
      theme = "Blue Matrix";
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
