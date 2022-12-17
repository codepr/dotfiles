local lsp = require('lsp-zero')

lsp.preset('recommended')
lsp.setup({
  settings = {
     elixirLS = {
       dialyzerEnabled = false,
       fetchDeps = false
     }
  }
})
