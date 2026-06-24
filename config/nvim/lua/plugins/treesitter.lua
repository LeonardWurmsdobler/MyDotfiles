return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        -- Web
        "html", "css", "scss", "javascript", "typescript", "tsx", "json", "jsonc",
        -- Systems / scripting
        "python", "bash", "lua", "c", "cpp", "rust", "go",
        -- Config / markup
        "yaml", "toml", "ini", "xml", "dockerfile",
        "markdown", "markdown_inline",
        -- Neovim internals (required by LazyVim)
        "vim", "vimdoc", "query", "regex",
      },
      highlight = { enable = true },
      indent = { enable = true },
    },
  },
}
