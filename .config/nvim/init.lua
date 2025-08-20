-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugins setup
require("lazy").setup({
  -- Neo-tree file explorer
  { "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("neo-tree").setup({
        view = { width = 15 },
        filesystem = {
          follow_current_file = true,
          filtered_items = { visible = true, hide_dotfiles = false },
        },
      })
    end,
  },

  -- Lualine statusline with buffers as tabs at bottom
  { "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = { theme = "auto" },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch" },
          lualine_c = { "filename" },
          lualine_x = { "buffers" },
          lualine_y = { "filetype" },
          lualine_z = { "location" },
        },
      })
    end,
  },

  -- Telescope fuzzy finder
  { "nvim-telescope/telescope.nvim", tag = "0.1.3",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  -- Sync terminal background with neovim colorscheme
  { "typicode/bg.nvim", lazy = false },

  -- Treesitter for syntax highlighting
  { "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "cpp", "python", "bash", "php", "lua", "javascript", "yaml", "javascript", "html", "css" },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true,
        },
      })
    end,
  },
	{ "jwalton512/vim-blade" }
})

-- Keymaps
vim.keymap.set("n", "<C-e>", function()
  require("neo-tree.command").execute({ toggle = true })
end, { desc = "Toggle Neo-tree file explorer" })

vim.keymap.set("n", "<C-t>", function()
  vim.cmd("botright split | terminal")
  vim.cmd("startinsert")
end, { desc = "Open terminal at bottom" })

vim.keymap.set("n", "<leader>ff", function()
  require("telescope.builtin").find_files()
end, { desc = "Find files" })

vim.keymap.set("n", "<leader>fg", function()
  require("telescope.builtin").live_grep()
end, { desc = "Live grep (search text in files)" })

-- Line numbers and remove ~ on empty lines
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.fillchars = "eob: "  -- removes ~ on empty lines

