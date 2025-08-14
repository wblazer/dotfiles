# config.nu
#
# Installed by:
# version = "0.103.0"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# This file is loaded after env.nu and before login.nu
#
# You can open this file in your default editor using:
# config nu
#
# See `help config nu` for more options
#
# You can remove these comments if you want or leave
# them for future reference.

$env.config.show_banner = false

$env.config.buffer_editor = "hx"
$env.config.edit_mode = "vi"
$env.config.cursor_shape.vi_insert = "line"       # Cursor shape in vi-insert mode
$env.config.cursor_shape.vi_normal = "block"  # Cursor shape in normal vi mode
$env.EDITOR = "hx"
$env.HELIX_RUNTIME = "~/src/helix/runtime"

### Starship
$env.STARSHIP_SHELL = "nu"

def create_left_prompt [] {
    starship prompt --cmd-duration $env.CMD_DURATION_MS $'--status=($env.LAST_EXIT_CODE)'
}

# Use nushell functions to define your right and left prompt
$env.PROMPT_COMMAND = { || create_left_prompt }
$env.PROMPT_COMMAND_RIGHT = ""

# The prompt indicators are environmental variables that represent
# the state of the prompt
$env.PROMPT_INDICATOR = ""
$env.PROMPT_INDICATOR_VI_INSERT = "〉"
$env.PROMPT_INDICATOR_VI_NORMAL = " "
$env.PROMPT_MULTILINE_INDICATOR = "::: "


### Aliases
alias lsa = ls -a
alias lt = ls **
alias ll = ls -l
alias c = clear
alias cat = batcat
alias lzg = lazygit
alias lzd = lazydocker

$env.config.table.mode = 'rounded'

use ($nu.default-config-dir | path join mise.nu)

source ~/.zoxide.nu

