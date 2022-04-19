local cmp = require 'cmp'
local lspkind = require('lspkind')

cmp.setup {
  snippet = {
    expand = function(args)
      vim.fn['vsnip#anonymous'](args.body)
    end,
  },

  mapping = {
      ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
      ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'}),
      ['<C-p>'] = cmp.mapping.select_prev_item(),
      ['<C-n>'] = cmp.mapping.select_next_item(),
      -- ['<C-Space>'] = cmp.mapping.complete(),
      -- ['<C-e>'] = cmp.mapping.close(),
      -- ['<C-y>'] = cmp.mapping.confirm {
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'path' },
    { name = 'buffer' },
  },

  window = {
      documentation = {
          winhighlight = 'NormalFloat:CmpDocumentation',
      }
  },

  experimental = {
    native_menu = false,
    ghost_text = true,
    },

  formatting = {
    format = lspkind.cmp_format({with_text = false, maxwidth = 50})
  },
}

