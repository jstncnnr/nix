{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nvf.homeManagerModules.default
  ];

  programs.git = {
    enable = true;
    userName = "Justin Conner";
    userEmail = "jstncnnr@outlook.com";
  };

  programs.ssh.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;

    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      font-family = "MesloLGS Nerd Font Mono";
      font-size = 12;
      background-opacity = 0.8;
      background-blur = 8;
      window-theme = "system";
      macos-titlebar-style = "native";
    };
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.go = {
    enable = true;
    goPath = ".local/go";
    goBin = ".local/go/bin";
  };

  programs.nvf = {
    enable = true;

    settings = {
      vim.vimAlias = true;

      vim.globals = {
        mapleader = " ";
        maplocalleader = " ";
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

      vim.comments.comment-nvim.enable = true;

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
        null-ls.enable = true;
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
