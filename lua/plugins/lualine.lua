return {
  "nvim-lualine/lualine.nvim",
  opts = function()
    local p = require("rose-pine.palette")

    local colors = {
      bg = p.base,
      surface = p.overlay,
      fg = p.text,
      gray = p.subtle,
      red = p.love,
      green = p.pine,
      yellow = p.gold,
      blue = p.foam,
      purple = p.iris,
      cyan = p.leaf,
      orange = p.rose,
      coral = p.rose,
    }

    local config = {
      options = {
        -- Disable sections and component separators
        component_separators = "",
        section_separators = "",
        theme = "rose-pine",
      },
      sections = {
        -- these are to remove the defaults
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        -- These will be filled later
        lualine_c = {},
        lualine_x = {},
      },
      inactive_sections = {
        -- these are to remove the defaults
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        lualine_c = {},
        lualine_x = {},
      },
    }

    local mode_colors = {
      n = colors.orange, -- Normal
      i = colors.green, -- Insert
      v = colors.coral, -- Visual
      [""] = colors.coral, -- Visual Block
      V = colors.coral, -- Visual Line
      c = colors.orange, -- Command
      no = colors.purple,
      s = colors.red,
      S = colors.red,
      [""] = colors.red,
      ic = colors.yellow,
      R = colors.cyan,
      Rv = colors.cyan,
      cv = colors.purple,
      ce = colors.purple,
      r = colors.blue,
      rm = colors.blue,
      ["r?"] = colors.blue,
      ["!"] = colors.red,
      t = colors.red,
    }

    local conditions = {
      buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
      end,
      buffer_empty = function()
        return vim.fn.empty(vim.fn.expand("%:t")) == 1
      end,
      hide_in_width = function()
        return vim.fn.winwidth(0) > 80
      end,
      check_git_workspace = function()
        local filepath = vim.fn.expand("%:p:h")
        local gitdir = vim.fn.finddir(".git", filepath .. ";")
        return gitdir and #gitdir > 0 and #gitdir < #filepath
      end,
      diff_mode = function()
        return vim.o.diff == true
      end,
    }

    local function insert_left(component)
      table.insert(config.sections.lualine_c, component)
    end

    local function insert_right(component)
      table.insert(config.sections.lualine_x, component)
    end

    insert_left({
      "mode",
      fmt = function(str)
        return " " .. str -- Note: You need a Nerd Font installed for this to show
      end,
      separator = { right = "" },
      color = function()
        -- Get the current mode
        local mode_code = vim.fn.mode()

        return {
          -- Use the map created above, defaulting to purple if not found
          bg = mode_colors[mode_code] or colors.purple,
          fg = colors.bg,
          gui = "bold",
        }
      end,
    })

    insert_left({
      "branch",
      icon = "",
      color = { fg = colors.fg, gui = "bold" },
    })

    insert_left({
      "diff",
      symbols = { added = " ", modified = " ", removed = " " },
      diff_color = {
        added = { fg = colors.green },
        modified = { fg = colors.yellow },
        removed = { fg = colors.red },
      },
      cond = conditions.hide_in_width,
    })

    insert_left({
      "diagnostics",
      sources = { "nvim_diagnostic" },
      symbols = { error = " ", warn = " ", info = " " },
      diagnostics_color = {
        color_error = { fg = colors.red },
        color_warn = { fg = colors.yellow },
        color_info = { fg = colors.blue },
      },
    })

    insert_left({
      function()
        return "%="
      end,
    })

    insert_right({
      "location",
      color = { fg = colors.gray },
      cond = conditions.buffer_not_empty,
    })

    insert_right({
      "encoding",
    })

    insert_right({
      "filetype",
    })

    return config
  end,
}
