return {
  -- pywal colorscheme — reads ~/.cache/wal/colors, matches your wallpaper palette
  {
    "uZer/pywal16.nvim",
    lazy = false,
    priority = 1000,
  },

  -- tell LazyVim to use it
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "pywal16",
    },
  },
}
