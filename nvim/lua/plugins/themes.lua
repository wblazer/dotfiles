local theme_config = require("config.theme")

return {
  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin-mocha",
    opts = {
      flavour = "mocha",
    },
  },
  {
    "sainnhe/gruvbox-material",
    lazy = false,
    name = "gruvbox-material",
    config = true,
    priority = 1000,
    opts = {},
  },
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    config = true,
    name = "gruvbox-light",
    opts = {
      background = "light",
    },
  },
  {
    "rose-pine/neovim",
    name = "rose-pine-moon",
    opts = {
      variant = "moon",
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = theme_config.name,
    },
  },
}
