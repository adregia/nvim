return {
  "akinsho/bufferline.nvim",
  event = "ColorScheme",
  config = function()
    local highlights = require("rose-pine.plugins.bufferline")
    require("bufferline").setup({ highlights = highlights })
  end,
  --  opts = function(_, opts)
  --    if (vim.g.colors_name or ""):find("catppuccin") then
  --      opts.highlights = require("catppuccin.special.bufferline").get_theme()
  --    end
  --  end,
}
