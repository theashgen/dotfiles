-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :( 

---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "onedark",

	-- hl_override = {
	-- 	Comment = { italic = true },
	-- 	["@comment"] = { italic = true },
	-- },
}

local function get_tree_info()
  local treeFt = "NvimTree"
  local status, nvconfig = pcall(require, "nvconfig")
  if status and nvconfig.ui and nvconfig.ui.tabufline and nvconfig.ui.tabufline.treeOffsetFt then
    treeFt = nvconfig.ui.tabufline.treeOffsetFt
  end

  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    if vim.bo[vim.api.nvim_win_get_buf(win)].ft == treeFt then
      local pos = vim.api.nvim_win_get_position(win)
      return {
        side = pos[2] == 0 and "left" or "right",
        w = vim.api.nvim_win_get_width(win),
      }
    end
  end
  return nil
end

M.ui = {
  tabufline = {
    order = { "treeOffset", "buffers", "tabs", "btns", "treeOffsetRight" },
    modules = {
      treeOffset = function()
        local info = get_tree_info()
        if info and info.side == "left" then
          return "%#NvimTreeNormal#" .. string.rep(" ", info.w) .. "%#NvimTreeWinSeparator#│"
        end
        return ""
      end,
      treeOffsetRight = function()
        local info = get_tree_info()
        if info and info.side == "right" then
          return "%#NvimTreeWinSeparator#│%#NvimTreeNormal#" .. string.rep(" ", info.w)
        end
        return ""
      end,
    },
  },
}

return M
