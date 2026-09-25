return {
  -- Keep the existing Catppuccin setup available as a fallback. The default
  -- Dusk schemes are local runtime files and do not add another dependency.
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = {
      flavour = "macchiato",
      transparent_background = true,
      term_colors = true,
      color_overrides = {
        macchiato = {
          rosewater = "#FCE4DE",
          flamingo  = "#F2BFB4",
          pink      = "#F3BDCA",
          mauve     = "#C4A2D4",
          red       = "#E27878",
          maroon    = "#E09898",
          peach     = "#DDA05C",
          yellow    = "#DEC47C",
          green     = "#82C8A0",
          teal      = "#6EC4B8",
          sky       = "#75D6F6",
          sapphire  = "#5CB8E4",
          blue      = "#68ACE0",
          lavender  = "#B0BCE8",
          text      = "#F3F5FC",
          subtext1  = "#D2D5DE",
          subtext0  = "#B2B6C1",
          overlay2  = "#8F939F",
          overlay1  = "#7E828F",
          overlay0  = "#6E7280",
          surface2  = "#60646E",
          surface1  = "#52565F",
          surface0  = "#454850",
          base      = "#393C43",
          mantle    = "#2F3238",
          crust     = "#26282D",
        },
      },
      integrations = {
        cmp = true,
        gitsigns = true,
        neo_tree = true,
        treesitter = true,
        notify = true,
        mason = true,
        native_lsp = {
          enabled = true,
        },
        indent_blankline = {
          enabled = true,
          scope_color = "lavender",
        },
        mini = { enabled = true },
        snacks = true,
        which_key = true,
      },
    },
  },

  -- Tell LazyVim to use the local Dusk Darker scheme by default.
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "dusk-darker",
    },
  },

  -- Transparent Dusk clears StatusLine, which lualine's auto theme would
  -- otherwise fill with black. The middle section shows the canvas; the
  -- branch section sits on surface0 like the Starship Git rail.
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      local name = vim.g.colors_name or ""
      local c = require("colors.dusk").palette(name)
      if not c or vim.g.dusk_transparent == false then
        return
      end
      local theme = require("lualine.themes.auto")
      for _, mode in pairs(theme) do
        if type(mode) == "table" then
          if mode.b then
            mode.b.bg = c.surface0
          end
          if mode.c then
            mode.c.bg = "NONE"
          end
        end
      end
      opts.options = opts.options or {}
      opts.options.theme = theme
    end,
  },
}
