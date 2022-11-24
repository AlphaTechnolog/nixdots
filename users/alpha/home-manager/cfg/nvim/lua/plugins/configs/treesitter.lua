local present, _ = pcall(require, 'nvim-treesitter')

if not present then
	return
end

local configs = require 'nvim-treesitter.configs'

configs.setup {
	ensure = {'lua', 'javascript', 'typescript', 'tsx', 'python', 'bash', 'html', 'css'},
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = true
	}
}
