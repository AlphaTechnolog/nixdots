local M = {}
local core = require('pkgs.theme.core')
local highlights = require('pkgs.theme.highlights')

function M.setup (opts)
  if opts == nil then
    opts = {
      cmp = {
        block_kind = false,
      },
      italics = {
        code = true,
        comments = false
      }
    }
  end
  -- disable bold
  vim.cmd [[ set t_md= ]]
	vim.opt.termguicolors = true

  local cmp_opts = opts.cmp or { block_kind = false }

  vim.g.decay_cmp_block_kind = cmp_opts.block_kind == nil and true or cmp_opts.block_kind

  local colors = core.get_palette()

  highlights.highlight_all(colors, opts)
end

return M
