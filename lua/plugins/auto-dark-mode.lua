-- Follow the system/terminal appearance and switch the rose-pine variant.
-- rose-pine is configured with `variant = "auto"` (see colorscheme.lua), so it
-- derives dawn (light) / moon (dark) from `vim.o.background`. Setting the
-- background and re-applying the colorscheme keeps everything in sync even if
-- Neovim's implicit reload doesn't fire.
return {
  "f-person/auto-dark-mode.nvim",
  dependencies = { "rose-pine/neovim" },
  opts = {
    update_interval = 1000, -- Check system theme every 1000ms
    set_dark_mode = function()
      vim.o.background = "dark"
      vim.cmd.colorscheme("rose-pine")
    end,
    set_light_mode = function()
      vim.o.background = "light"
      vim.cmd.colorscheme("rose-pine")
    end,
  },
}
