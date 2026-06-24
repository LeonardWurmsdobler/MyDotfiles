if status is-interactive

    # ── Prompt ────────────────────────────────────────────────────────────
    starship init fish | source

    # ── Smarter cd ────────────────────────────────────────────────────────
    zoxide init fish | source

    # ── Pywal colours on terminal open ────────────────────────────────────
    cat ~/.cache/wal/sequences 2>/dev/null

    # ── Aliases ───────────────────────────────────────────────────────────

    # eza replaces ls
    alias ls  'eza --icons --group-directories-first'
    alias ll  'eza --icons --group-directories-first -l --git'
    alias la  'eza --icons --group-directories-first -la --git'
    alias lt  'eza --icons --tree --level=2'

    # bat replaces cat
    alias cat 'bat --style=plain'
    alias cат 'bat'                   # with line numbers and decorations

    # common shortcuts
    alias v   'nvim'
    alias g   'git'
    alias yy  'yay'
    alias ..  'cd ..'
    alias ... 'cd ../..'

    # Hyprland / system
    alias reload-waybar 'killall waybar; waybar &'
    alias reload-eww    'eww kill; eww daemon; eww open control-center'
    alias reload-wal    'wal -R'

    # ── Abbreviations (expand visibly as you type) ─────────────────────────
    abbr --add gs   'git status'
    abbr --add ga   'git add'
    abbr --add gc   'git commit -m'
    abbr --add gp   'git push'
    abbr --add gl   'git log --oneline --graph --decorate'
    abbr --add gd   'git diff'

    # ── Environment ───────────────────────────────────────────────────────
    set -gx EDITOR nvim
    set -gx VISUAL nvim

end
