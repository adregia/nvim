-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Horizon sets NonText to fg=#232530 (nearly identical to the #1C1E26 bg).
-- Snacks links SnacksPickerGitStatusUntracked to NonText, making those
-- explorer items invisible. Apply overrides here and on future theme reloads.
local function fix_horizon_hl()
  local hl = vim.api.nvim_set_hl
  local peach = "#FAC29A"
  local gold = "#EBCB8B"
  local green = "#29D398"
  local purple = "#B877DB"
  local red = "#E95678"

  hl(0, "Directory", { fg = peach, bold = true })
  hl(0, "SnacksPickerDirectory", { fg = peach, bold = true })
  hl(0, "SnacksPickerGitStatusModified", { fg = gold, bold = true })
  hl(0, "SnacksPickerGitStatusUntracked", { fg = green })
  hl(0, "SnacksPickerPathIgnored", { fg = purple })
  hl(0, "SnacksPickerPathHidden", { fg = purple })
  hl(0, "SnacksPickerDir", { fg = peach, bold = true })
  hl(0, "SnacksNormal", { bg = "#1C1E26" })
  hl(0, "SnacksNormalNC", { bg = "#1C1E26" })
  hl(0, "RenderMarkdownCode", { fg = red })
  hl(0, "RenderMarkdownCodeInline", { fg = red })

  -- Transparent buffer background (terminal handles the actual transparency).
  -- Clear bg on every highlight that paints the editor area or gutter.
  for _, group in ipairs({
    "Normal",
    "NormalNC",
    "SignColumn",
    "LineNr",
    "CursorLineNr",
    "EndOfBuffer",
    "FoldColumn",
    "VertSplit",
    "WinSeparator",
    "StatusLine",
    "StatusLineNC",
    "MsgArea",
    "TabLine",
    "TabLineFill",
  }) do
    local existing = vim.api.nvim_get_hl(0, { name = group, link = false })
    existing.bg = "NONE"
    existing.ctermbg = "NONE"
    hl(0, group, existing)
  end
end

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "horizon",
  group = vim.api.nvim_create_augroup("horizon_hl_fix", { clear = true }),
  callback = fix_horizon_hl,
})

-- VeryLazy fires after the initial ColorScheme event, so apply directly now.
if vim.g.colors_name == "horizon" then
  fix_horizon_hl()
end
