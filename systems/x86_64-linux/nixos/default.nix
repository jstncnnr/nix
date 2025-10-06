{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix

    inputs.nvf.nixosModules.default
  ];

  time.timeZone = "America/Los_Angeles";
  i18n.defaultLocale = "en_US.UTF-8";
  system.stateVersion = "25.05";
  networking.networkmanager.enable = true;

  services.openssh = {
    enable = true;
    openFirewall = true;
  };

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  programs.hyprland.enable = true;

  users.users.justin = {
    description = "Justin Conner";
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel"];
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;

  environment.systemPackages = [
    pkgs.neovim
    pkgs.brave
    pkgs.git

    (pkgs.bolt-launcher.override {
      enableRS3 = true;
    })
  ];

  # For bolt-launcher
  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1w"
  ];

  fonts.packages = [
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.nerd-fonts.meslo-lg
  ];

  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = lib.mapAttrsToList (name: _: name) config.users.users;
  };

  systemd.user.services."1password" = {
    enable = true;
    description = "1Password auto start";

    serviceConfig = {
      ExecStart = "${pkgs._1password-gui}/bin/1password --silent";
      RemainAfterExit = true;
    };

    after = ["graphical-session.target"];
    wantedBy = ["graphical-session.target"];
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  programs.ydotool = {
    enable = true;
    group = "wheel";
  };

  programs.nvf = {
    enable = true;

    settings = {
      vim.vimAlias = true;

      vim.globals = {
        mapleader = " ";
        mapleaderlocal = " ";
        have_nerd_font = true;
      };

      vim.options = {
        number = true;
        mouse = "a";
        showmode = false;
        breakindent = true;
        undofile = true;
        ignorecase = true;
        smartcase = true;
        signcolumn = "yes";
        updatetime = 250;
        timeoutlen = 300;
        splitright = true;
        splitbelow = true;
        list = true;
        inccommand = "split";
        cursorline = true;
        scrolloff = 10;
        confirm = true;
      };

      vim.autocomplete = {
        nvim-cmp = {
          enable = true;
          mappings.confirm = "<C-y>";
          mappings.next = "<C-n>";
          mappings.previous = "<C-p>";
        };
      };

      vim.binds = {
        whichKey.enable = true;
      };

      vim.clipboard = {
        enable = true;
        providers = {
          wl-copy.enable = true;
        };
        registers = "unnamedplus";
      };

      vim.comments = {
        comment-nvim.enable = true;
      };

      vim.diagnostics = {
        enable = true;
        config.signs = true;
        config.underline = true;
        nvim-lint.enable = true;
      };

      vim.formatter = {
        conform-nvim.enable = true;
      };

      vim.fzf-lua.enable = true;

      vim.git = {
        enable = true;
        gitsigns.enable = true;
        gitsigns.codeActions.enable = true;
        vim-fugitive.enable = true;
      };

      vim.languages = {
        enableExtraDiagnostics = true;
        enableFormat = true;
        enableTreesitter = true;

        bash.enable = true;
        css.enable = true;
        go.enable = true;
        helm.enable = true;
        html.enable = true;
        lua.enable = true;
        markdown.enable = true;
        nix.enable = true;
        python.enable = true;
        rust.enable = true;
        rust.crates.enable = true;
        sql.enable = true;
        ts.enable = true;
        yaml.enable = true;
      };

      vim.lsp = {
        enable = true;
        formatOnSave = true;
      };

      vim.mini = {
        ai.enable = true;
        align.enable = true;
        basics.enable = true;
      };

      vim.navigation = {
        harpoon.enable = true;
      };

      vim.snippets = {
        luasnip.enable = true;
      };

      vim.statusline = {
        lualine.enable = true;
      };

      vim.telescope.enable = true;

      vim.theme = {
        enable = true;
        transparent = true;
        name = "tokyonight";
        style = "night";
      };

      vim.treesitter = {
        enable = true;
        indent.enable = true;
      };

      vim.undoFile.enable = true;

      vim.utility = {
        sleuth.enable = true;
      };

      vim.visuals = {
        fidget-nvim.enable = true;
        nvim-web-devicons.enable = true;
      };
    };
  };
}
