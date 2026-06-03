-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.number = true -- Show line numbers
vim.opt.relativenumber = false
vim.o.background = "dark"

if vim.g.neovide then
  -- 1. Match your "transparent_background = true" setting
  -- Neovide needs this value set < 1.0 to actually render the window as transparent.
  -- 0.8 to 0.9 is usually the "sweet spot" for text legibility.
  vim.g.neovide_opacity = 0.8

  -- 2. Enable "Frosted Glass" blur
  -- This makes the transparent background look premium and matches the Catppuccin vibe.
  vim.g.neovide_window_blurred = true

  -- 3. Font Configuration (REQUIRED for Neovide)
  -- Since Neovide doesn't use the terminal font, you must set this explicitly.
  -- Format: "FontName:hSize". ensure you use a Nerd Font.
  vim.o.guifont = "Monaspace Neon NF:h12"
end
