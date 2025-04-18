{ lib, pkgs, ... }:

{
  home.packages = [
    pkgs.gh
    pkgs.jetbrains-toolbox
  ];

  programs.git = {
    enable = true;
    userName = "Justin Conner";
    userEmail = "jstncnnr@outlook.com";
  };

  programs.ssh = {
    enable = true;
    extraConfig = ''
      IdentityAgent ~/.1password/agent.sock
    '';
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

  programs.zsh = {
    enable = true;

    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
  };

  programs.oh-my-posh = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      version = 3;
      final_space = true;
      console_title_template = "{{ .Shell }} in {{ .Folder }}";
      palette = {
        black = "#262b44";
	blue = "#4b95e9";
	green = "#59c9a5";
	orange = "#f07623";
	red = "#d81e5b";
	white = "#e0def4";
	yellow = "#f3ae35";
      };
      transient_prompt = {
        template = " ";
	foreground = "p:white";
	background = "transparent";
      };
      blocks = [
        {
          type = "prompt";
	  alignment = "left";
	  newline = true;
	  segments = [
            {
	      type = "os";
	      style = "powerline";
	      template = " {{ .Icon }} ";
	      foreground = "p:black";
	      background = "p:white";
	      powerline_symbol = "";
	      leading_powerline_symbol = "<transparent>";
	    }
	    {
	      type = "session";
	      style = "powerline";
	      template = "{{ if .SSHSession }} {{ .UserName }}@{{ .HostName }} {{ end }}";
	      foreground = "p:black";
	      background = "p:red";
	      powerline_symbol = "";
	    }
	    {
	      type = "path";
	      style = "powerline";
	      template = "  {{ .Path }} ";
	      foreground = "p:white";
	      background = "p:blue";
	      powerline_symbol = "";
	      properties.style = "powerlevel";
	    }
	    {
	      type = "git";
	      style = "powerline";
	      templates = [
                " {{ .HEAD }}"
		"{{ if .BranchStatus }} {{ .BranchStatus }} {{ end }}"
		"{{ if .Working.Changed }}  {{ .Working.String }}{{ end }}"
		"{{ if .Staging.Changed }}  {{ .Staging.String }}{{ end }}"
	      ];
	      templates_logic = "join";
	      foreground = "p:black";
	      background = "p:green";
	      foreground_templates = [
                "{{ if or (.Working.Changed) (.Staging.Changed) }}p:black{{ end }}"
		"{{ if and (gt .Ahead 0) (gt .Behind 0) }}p:white{{ end }}"
		"{{ if gt .Ahead 0 }}p:white{{ end }}"
	      ];
	      background_templates = [
                "{{ if or (.Working.Changed) (.Staging.Changed) }}p:yellow{{ end }}"
		"{{ if and (gt .Ahead 0) (gt .Behind 0) }}p:red{{ end }}"
		"{{ if gt .Ahead 0 }}#49416d{{ end }}"
		"{{ if gt .Behind 0 }}#7a306c{{ end }}"
	      ];
	      powerline_symbol = "";
	    }
	  ];
	}
	{
	  type = "prompt";
	  alignment = "right";
	  segments = [
            {
	      type = "executiontime";
	      style = "powerline";
	      foreground = "p:black";
	      background = "p:yellow";
	      powerline_symbol = "<transparent>";
	      leading_powerline_symbol = "";
	      properties.style = "round";
	    }
	  ];
	}
	{
	  type = "prompt";
	  alignment = "left";
	  newline = true;
	  segments = [
            {
	      type = "text";
	      style = "plain";
	      template = "";
	      foreground = "p:white";
	    }
	  ];
	}
      ];
    };
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
  };
}
