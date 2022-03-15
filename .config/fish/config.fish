# ensure brew stuff is on PATH
if test -f /opt/homebrew/bin/brew
    eval (/opt/homebrew/bin/brew shellenv)
    fish_add_path /opt/homebrew/bin
    fish_add_path /opt/homebrew/opt/llvm/bin
end

export GPG_TTY=(tty)
export EDITOR="nvim"
export DOTNET_CLI_TELEMETRY_OPTOUT=1

fish_add_path "$HOME/scripts"
fish_add_path "$HOME/.cargo/bin"
fish_add_path "$HOME/.dotnet/tools"

source $HOME/.config/fish/fzf-config.fish
source $HOME/.config/fish/aliases.fish

# for local-only, non-sync'd stuff
if test -e $HOME/.config/fish/local.fish
    source $HOME/.config/fish/local.fish
end

if status is-interactive
    # workaround for https://github.com/fish-shell/fish-shell/issues/3481
    function fish_vi_cursor
    end
    fish_vi_key_bindings
    bind -M insert jk "if commandline -P; commandline -f cancel; else; set fish_bind_mode default; commandline -f backward-char force-repaint; end"

    op completion fish | source
    thefuck --alias | source
    starship init fish | source
    atuin init fish | source
    set CTRLG_TMUX true
    set CTRLG_TMUX_POPUP true
    set CTRLG_TMUX_POPUP_ARGS -w "75%" -h "85%" -x 10
    ctrlg init fish | source
    nvm use $nvm_default_version >/dev/null

    # start tmux session by default
    if [ -z "$TMUX" ] && [ "$START_TMUX_PLEASE" = 1 ]
        exec tmux new-session -A -s $USER
    end
end
