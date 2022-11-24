local present, decay = pcall(require, 'decay')
local opts = require("common")

if not present then
	return
end

decay.setup {
	style = 'decayce',
	nvim_tree = {
		contrast = true,
	},
	cmp = {
		block_kind = false,
	},
	italics = {
		comments = opts.italic,
		code = opts.italic,
	}
}
