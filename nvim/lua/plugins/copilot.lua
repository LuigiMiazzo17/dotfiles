return {
  {
    "hrsh7th/nvim-cmp",
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      opts.experimental.ghost_text = false
      opts.completion.completeopt = "menu,menuone,noselect"

      local cmp = require("cmp")
      opts.mapping["<CR>"] = cmp.mapping.confirm()
    end,
  },

  {
    "zbirenbaum/copilot.lua",
    enabled = true,
    event = "VeryLazy",
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept_line = "<M-L>",
        },
      },
      filetypes = {
        ["*"] = true,
      },
    },
  },
}
