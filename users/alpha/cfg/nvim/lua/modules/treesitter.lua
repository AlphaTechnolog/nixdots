local present, conf = pcall(require, 'nvim-treesitter.configs')

if not present then
  return
end

conf.setup {
  ensure_installed = {'lua', 'javascript', 'typescript', 'tsx', 'python', 'bash', 'html', 'css', 'markdown'},
  auto_install = false,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true
  },
}
