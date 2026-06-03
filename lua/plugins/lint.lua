local pattern = "([^:]+):(%d+):(%d+):(%d+):(%d+): (%a+): (.*) %[(%a[%a-]+)%]"
local groups = { "file", "lnum", "col", "end_lnum", "end_col", "severity", "message", "code" }
local severities = {
  error = vim.diagnostic.severity.ERROR,
  warning = vim.diagnostic.severity.WARN,
  note = vim.diagnostic.severity.HINT,
}

return {
  {
    "mfussenegger/nvim-lint",
    event = "LazyFile",
    opts = {
      -- Event to trigger linters
      events = { "BufWritePost", "BufReadPost", "InsertLeave" },
      linters_by_ft = {
        python = { "mypy" },
      },
      linters = {
        mypy = {
          cmd = "mypy",
          stdin = false,
          stream = "both",
          ignore_exitcode = true,
          args = {
            "--show-column-numbers",
            "--show-error-end",
            "--hide-error-context",
            "--no-color-output",
            "--no-error-summary",
            "--no-pretty",
            "--config-file",
            function()
              -- Find pyproject.toml starting from the current file's directory,
              -- stopping at the git root or system root.
              return vim.fs.find("pyproject.toml", {
                path = vim.api.nvim_buf_get_name(0),
                upward = true,
              })[1] or "pyproject.toml" -- Fallback if not found
            end,
          },
          condition = function(ctx)
            -- Find pyproject.toml
            local root = vim.fs.find("pyproject.toml", { path = ctx.filename, upward = true })[1]

            -- If no config file, don't run
            if not root then
              return false
            end

            -- Read the file to see if [tool.mypy] is actually defined
            local f = io.open(root, "r")
            if f then
              local content = f:read("*a")
              f:close()
              -- Return true ONLY if [tool.mypy] is found in the text
              return content:find("%[tool%.mypy%]") ~= nil
            end

            return false
          end,
        },
      },
    },
  },
}
