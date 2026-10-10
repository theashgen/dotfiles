require "nvchad.autocmds"

-- monitor starship.toml changes
vim.cmd [[
  augroup monitor_starship
    autocmd!
    autocmd BufWritePost /Users/theashgen/.config/starship.toml echo "starship config changed!"
  augroup END
]]
