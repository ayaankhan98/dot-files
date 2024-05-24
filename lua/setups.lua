
-- LuaLine
require('lualine').setup();

-- Gitsigns
require('gitsigns').setup();

-- Nvim Tree
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    width = 60,
    number = true,
  },
  renderer = {
    group_empty = true,
  },
})


require("lsp_signature").setup();

-- Backline
--require("indent_blankline").setup();

-- Notify
vim.notify = require('notify');

-- Telescope
require('telescope').setup{ 
  defaults = { 
    file_ignore_patterns = { 
      "node_modules" 
    }
  }
}

--LSP Setup
require('lspconfig').tsserver.setup {}
require('lspconfig').angularls.setup{}
require('lspconfig').html.setup{}


		  
