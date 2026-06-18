return {
  -- rose-pine: configure only. We do NOT call `vim.cmd("colorscheme")` here.
  -- Letting LazyVim be the single thing that applies the colorscheme (see the
  -- spec below) avoids a startup race between this config, LazyVim's own
  -- colorscheme apply, and auto-dark-mode.
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false, -- Ensure it loads on startup
    priority = 1000, -- Load this before other plugins
    -- Pass options here using the standard lazy.nvim `opts` table. lazy.nvim
    -- automatically calls require("rose-pine").setup(opts) for us.
    opts = {
      -- `auto` derives the variant from `vim.o.background`:
      --   background=light -> dawn (light), background=dark -> dark_variant.
      variant = "auto", -- auto, main, moon, or dawn
      dark_variant = "moon", -- main, moon, or dawn
      dim_nc_background = false,

      -- Enable transparency
      styles = {
        transparency = true, -- Modern way to make backgrounds transparent
        italic = true, -- keep italic on so the override below can apply it selectively
      },

      -- Invert rose-pine's default italic logic for fonts like Fira Code iScript:
      -- italicize keywords/statements, leave variables/identifiers upright.
      before_highlight = function(group, highlight, _)
        if group == "Keyword" or group == "Statement" or group:match("^@keyword") then
          highlight.italic = true
        elseif
          group:match("^@variable")
          or group == "@property"
          or group == "@field"
          or group == "@parameter"
        then
          highlight.italic = false
        end
      end,
    },
  },

  -- Tell LazyVim to use rose-pine. This is the single source of truth for
  -- "which colorscheme is active", applied once after plugins load.
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "rose-pine",
    },
  },
}
-- return {
--   {
--     "akinsho/horizon.nvim",
--     version = "*",
--     lazy = false,
--     priority = 1000,
--     opts = {
--       plugins = {
--         cmp = true,
--         indent_blankline = true,
--         nvim_tree = true,
--         telescope = true,
--         which_key = true,
--         barbar = true,
--         notify = true,
--         symbols_outline = true,
--         neo_tree = true,
--         gitsigns = true,
--         crates = true,
--         hop = true,
--         navic = true,
--         quickscope = true,
--         flash = true,
--       },
--     },
--   },
--   {
--     "LazyVim/LazyVim",
--     opts = {
--       colorscheme = "horizon",
--     },
--   },
-- }
-- return {
--   {
--     "LazyVim/LazyVim",
--     opts = {
--       colorscheme = "catppuccin-mocha",
--     },
--   },
--
--   {
--     "catppuccin/nvim",
--     name = "catppuccin",
--     lazy = true,
--
--     opts = {
--       transparent_background = true,
--       lsp_styles = {
--         underlines = {
--           errors = { "undercurl" },
--           hints = { "undercurl" },
--           warnings = { "undercurl" },
--           information = { "undercurl" },
--         },
--       },
--       styles = {
--         -- Set these to { "bold" }, { "italic" }, or {} to disable
--         comments = { "italic" },
--         conditionals = { "italic" },
--         loops = {},
--         functions = { "bold" }, -- Example: Bold all functions
--         keywords = { "bold" }, -- Example: Bold all keywords (if, else, return)
--         strings = {},
--         variables = {},
--         numbers = {},
--         booleans = { "bold" },
--         properties = {},
--         types = { "bold" },
--         operators = {},
--       },
--       integrations = {
--         aerial = true,
--         alpha = true,
--         cmp = true,
--         dashboard = true,
--         flash = true,
--         fzf = true,
--         grug_far = true,
--         gitsigns = true,
--         headlines = true,
--         illuminate = true,
--         indent_blankline = { enabled = true },
--         leap = true,
--         lsp_trouble = true,
--         mason = true,
--         mini = true,
--         navic = { enabled = true, custom_bg = "lualine" },
--         neotest = true,
--         neotree = true,
--         noice = true,
--         notify = true,
--         snacks = true,
--         telescope = true,
--         treesitter_context = true,
--         which_key = true,
--       },
--       --      color_overrides = {
--       --        mocha = {
--       --          base = "#000000",
--       --          mantle = "#000000",
--       --          -- crust = "#000000",
--       --        },
--       --      },
--     },
--   },
-- }
