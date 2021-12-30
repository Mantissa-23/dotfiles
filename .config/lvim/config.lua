lvim.plugins = {
  {
    'vimwiki/vimwiki',
    config = function()
      vim.g.vimwiki_list = {
        {
          path = '$HOME/Wiki',
          syntax = 'markdown',
          ext = '.md',
        }
      }
    end
  },
  {
    'dhruvasagar/vim-table-mode',
  },
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },
  {'morhetz/gruvbox'},
  {'tpope/vim-surround'},
  {'tpope/vim-fugitive'},
}

-- general
lvim.log.level = "warn"
-- lvim.format_on_save = true
lvim.colorscheme = "gruvbox"

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.insert_mode["jj"] = false
lvim.keys.insert_mode["fd"] = "<ESC>"

-- Custom whichkey mappings
local builtin_mappings = lvim.builtin.which_key.mappings

lvim.builtin.which_key.mappings = {
  e = builtin_mappings['e'],
  L = builtin_mappings['L'],
  l = builtin_mappings['l'],
  b = builtin_mappings['b'],
  p = builtin_mappings['p'],
  g = {
    g = { "<cmd>Git<cr>", "Git Interface" },
  },
  q = { "<cmd>BufferClose!<CR>", "Close Buffer" },
  f = {
    name = "Find (Telescope)",
    g = {
      name = "Git",
      c = { "<cmd>Telescope git_branches<cr>", "Branches (checkout)" },
    },
    p = { "<cmd>Telescope projects<cr>", "Projects" },
    f = { "<cmd>Telescope find_files<cr>", "Find File" },
    s = { "<cmd>Telescope live_grep<cr>", "Text Search (Grep)" },
    S = { "<cmd>Telescope symbols<cr>", "Symbols" },
    h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
    M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
    r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
    R = { "<cmd>Telescope registers<cr>", "Registers" },
    k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
    C = { "<cmd>Telescope commands<cr>", "Commands" },
    b = { "<cmd>Telescope buffers<cr>", "Buffers" },
    c = {
      "<cmd>lua require('telescope.builtin.internal').colorscheme({enable_preview = true})<cr>",
      "Colorscheme with Preview",
    },
  },
  w = {
    name = "VimWiki",
    ['<leader>'] = {
      name = "Diary",
      i = "Update Diary Index",
      w = "Open Today's Diary File",
      t = "Open Today's Diary File in New tab",
    },
    i = "Diary Index",
    w = "Wiki Index",
    t = "Wiki Index (new tab)",
    s = "Wiki Index (select and open)",
    d = "Delete this wiki file",
    r = "Rename this file",
  },
  -- Comment.api not working
  -- c = { "<CMD>lua require('Comment.api').toggle_current_linewise()<CR>", "Toggle Comment" },
  t = {
    name = "Table Mode",
    m = "Toggle table mode",
    t = "Tableize",
  },
  i = {
    name = "Insert",
    t = { "<cmd>pu=strftime('%c')<cr>", "Insert Current Timestamp"}
  },
}
lvim.builtin.which_key.vmappings = {
  -- Commnt.api not working
  -- c = { "<ESC><CMD>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>", "Toggle Comment" },
  T = "Tableize Delimiter",
  t = {
    name = "Table Mode",
    t = "Tableize"
  },
}

-- autocmds
lvim.autocommands.custom_groups = {
  { "BufWinEnter", "markdown,tex,markdown.mdx,vimwiki", "setlocal wrap"}
}

-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.dashboard.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.show_icons.git = 0

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "css",
  "rust",
  "java",
  "yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

-- generic LSP settings

-- ---@usage disable automatic installation of servers
lvim.lsp.automatic_servers_installation = false

-- Use prettier for JavaScript
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   -- { exe = "black", filetypes = { "python" } },
--   -- { exe = "isort", filetypes = { "python" } },
--   {
--     exe = "prettier",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     args = { "--print-with", "100" },
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "typescript", "typescriptreact" },
--   },
-- }

-- -- set additional linters
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { exe = "flake8", filetypes = { "python" } },
--   {
--     exe = "shellcheck",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     args = { "--severity", "warning" },
--   },
--   {
--     exe = "codespell",
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "javascript", "python" },
--   },
-- }
