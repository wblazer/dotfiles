# env.nu
#
# Installed by:
# version = "0.103.0"
#
# Previously, environment variables were typically configured in `env.nu`.
# In general, most configuration can and should be performed in `config.nu`
# or one of the autoload directories.
#
# This file is generated for backwards compatibility for now.
# It is loaded before config.nu and login.nu
#
# See https://www.nushell.sh/book/configuration.html
#
# Also see `help config env` for more options.
#
# You can remove these comments if you want or leave
# them for future reference.
$env.PATH ++= ['~/.local/bin', '~/.nix_profile/bin', '/nix/var/nix/profiles/default/bin']

let mise_path = $nu.default-config-dir | path join mise.nu
^mise activate nu | save $mise_path --force

zoxide init --cmd cd nushell | save -f ~/.zoxide.nu

let tools_path = ("~/tools" | path expand)
if $tools_path not-in $env.PATH {
    $env.PATH ++= [$tools_path]
}

# opam env | lines | split column ';' vars | get vars | parse "{var}='{value}'" | transpose --header-row --as-record | load-env
open ~/.env | from toml | load-env
