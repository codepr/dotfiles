require'nvim-treesitter.configs'.setup {
  ensure_installed = { "help", "elixir", "eex", "erlang", "heex", "html", "lua", "surface" },
  sync_install = false,
  auto_install = true,
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
