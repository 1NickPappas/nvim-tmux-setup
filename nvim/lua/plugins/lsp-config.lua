return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({})
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls" },
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require('lspconfig')
      lspconfig.lua_ls.setup({})

      lspconfig['move_analyzer'].setup{
        cmd = { "/root/.cargo/bin/move-analyzer" },  -- Use the path found earlier
        filetypes = { "move" },  -- Adjust to the correct filetype if necessary
        root_dir = function(fname)
          return lspconfig.util.find_git_ancestor(fname) or vim.loop.os_homedir()
        end,
        settings = {
          -- Custom settings for the LSP server, if any
        },
      }

       -- See `:help vim.lsp.*` for documentation on any of the below functions
 vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, {})
 vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
 vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
 -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {})
 -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, {})
 -- vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, {})
 -- vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, {})
 -- vim.keymap.set('n', '<leader>wl', function()
 --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
 -- end, {})
 -- vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, {})
 -- vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {})
 -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, {})
 -- vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, {})
 -- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, {})
 -- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, {})
 -- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, {})
 end
 }
}
