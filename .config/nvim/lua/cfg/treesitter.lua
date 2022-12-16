require'nvim-treesitter.configs'.setup {
  ensure_installed = { "elixir", "eex", "erlang", "heex", "html", "surface" },
  sync_install = false,
  ignore_install = { },
  highlight = {
    enable = true,
    disable = { },
    additional_vim_regex_highlighting = false,
  },
  matchup = {
      enable = true
  }
}
