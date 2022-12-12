local present, bufferline = pcall(require, 'bufferline')

if not present then
  return
end

bufferline.setup {
  options = {
    show_buffer_icons = false,
    show_buffer_default_icon = false,
    separator_style = {'', ''},
    indicator = {
      style = 'none',
    },
    offsets = {
      {
        filetype = "NvimTree",
        text = "",
        highlight = "NvimTreeNormal",
        separator = true,
      }
    }
  }
}
