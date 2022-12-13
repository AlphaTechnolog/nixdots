local present, mason = pcall(require, 'mason')
local helpers = require("helpers")

-- also checking for the setup property... idk why but it gets the palette too
-- if mason isn't installed? wtf
if not present then
  return
elseif not helpers.dict_contains(mason, 'setup') then
  return
end

mason.setup()

-- setup completion
local cmp = require("cmp")
local lspkind = require("lspkind")
local luasnip = require("luasnip")

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup {
  window = {
    completion = {
      winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
      col_offset = -3,
      side_padding = 0,
    },
  },
  formatting = {
    fields = {'kind', 'abbr', 'menu'},
    format = function (entry, vim_item)
      local kind = lspkind.cmp_format({
        mode = 'symbol_text',
        max_width = 50
      })(entry, vim_item)

      local strings = vim.split(kind.kind, '%s', { trimempty = true })

      local mappings = {
        TypeParameter = ''
      }

      -- apply mappings to strings[1]
      for name, icon in pairs(mappings) do
        if name == strings[1] then
          strings[1] = icon
        end
      end

      kind.kind = ' ' .. strings[1] .. ' '

      if #strings > 1 then
        kind.menu = '    (' .. strings[2] .. ')'
      end

      return kind
    end
  },
  snippet = {
    expand = function (args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" }
  }, {
    { name = "buffer" }
  })
}

cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" }
  }
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" }
  }, {
    { name = "cmdline" }
  })
})

-- get capabilities
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- setup lspconfig
local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup()

-- setup automatic lsp installations!
mason_lspconfig.setup_handlers({
  function (server_name)
    require("lspconfig")[server_name].setup {
      capabilities = capabilities
    }
  end,
  ["sumneko_lua"] = function ()
    require("lspconfig").sumneko_lua.setup {
      settings = {
        Lua = {
          runtime = {
            version = 'LuaJIT',
          },
          diagnostics = {
            globals = {'vim'},
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
          },
          telemetry = {
            enable = false,
          },
        },
      },
    }
  end
})
