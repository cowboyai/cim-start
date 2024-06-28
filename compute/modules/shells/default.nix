{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    #autocd = true;
    # dirHashes = {
    #   dl = "$HOME/Downloads";
    #   docs = "$HOME/Documents";
    #   code = "$HOME/Documents/code";
    #   dots = "$HOME/Documents/code/dotfiles";
    #   pics = "$HOME/Pictures";
    #   vids = "$HOME/Videos";
    #   nixpkgs = "$HOME/Documents/code/git/nixpkgs";
    # };
    #dotDir = ".config/zsh";
    # history = {
    #   expireDuplicatesFirst = true;
    #   path = "${config.xdg.dataHome}/zsh_history";
    # };

    # initExtra = ''
    #   # search history based on what's typed in the prompt
    #   autoload -U history-search-end
    #   zle -N history-beginning-search-backward-end history-search-end
    #   zle -N history-beginning-search-forward-end history-search-end
    #   bindkey "^[OA" history-beginning-search-backward-end
    #   bindkey "^[OB" history-beginning-search-forward-end

    #   # case insensitive tab completion
    #   zstyle ':completion:*' completer _complete _ignored _approximate
    #   zstyle ':completion:*' list-colors '\'
    #   zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
    #   zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
    #   zstyle ':completion:*' menu select
    #   zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
    #   zstyle ':completion:*' verbose true
    #   _comp_options+=(globdots)

    #   # run programs that are not in PATH with comma
    #   command_not_found_handler() {
    #     ${pkgs.comma}/bin/comma "$@"
    #   }
    # '';

    # shellAliases = {
    #   grep = "grep --color";
    #   ip = "ip --color";
    #   l = "eza -l";
    #   la = "eza -la";
    #   md = "mkdir -p";
    #   pf = "powerprofilesctl launch -p performance";

    #   us = "systemctl --user";
    #   rs = "sudo systemctl";
    # };
    # shellGlobalAliases = {eza = "eza --icons --git";};
  };

  programs.starship = {
    enable = true;
    settings = {
      character = {
        success_symbol = "[›](bold green)";
        error_symbol = "[›](bold red)";
      };

      git_status = {
        deleted = "✗";
        modified = "✶";
        staged = "✓";
        stashed = "≡";
      };

      nix_shell = {
        symbol = "❄️ ";
        heuristic = true;
      };
    };
  };
}
