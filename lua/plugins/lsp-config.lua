return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls" }
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")

      local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
      lspconfig.sourcekit.setup { capabilities = capabilities }
      lspconfig.lua_ls.setup { capabilities = capabilities }

      vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
      vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, {})
    end
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp", -- nvim-cmp source for Neovim's built-in LSP
      "hrsh7th/cmp-buffer",   -- buffer completions
      "hrsh7th/cmp-path",     -- path completions
      "hrsh7th/cmp-cmdline",  -- cmdline completions
      "saadparwaiz1/cmp_luasnip", -- snippet completions (requires a snippet engine)
      "L3MON4D3/LuaSnip",     -- LuaSnip, a snippet engine
      "rafamadriz/friendly-snippets" -- set of preconfigured snippets
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'buffer' },
          { name = 'path' }
        }),
      })

      -- Setup LSP capabilities for nvim-cmp
    end
  }
}
