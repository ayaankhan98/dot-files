-- LSP Config
local lspconfig = require('lspconfig')
local servers = { 'clangd', 'tsserver', 'cssls', 'cssmodules_ls' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup{}
end

-- Angular language service
--
--
local project_library_path = "/usr/lib/node_modules/@angular/language-server/"
local cmd = {"ngserver", "--stdio", "--tsProbeLocations", project_library_path , "--ngProbeLocations", project_library_path}

require'lspconfig'.angularls.setup{
  cmd = cmd,
  on_new_config = function(new_config,new_root_dir)
    new_config.cmd = cmd
  end,
}

-- See :help vim.diagnostic.* for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See :help vim.lsp.* for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format {
          async = true ,
          formatting_options = { 
              tabSize = 4, 
              insertSpaces = true } 
          }
    end, opts)
  end,
})

local lsp = require("lsp-zero")

lsp.preset("recommended")

-- navigating completions in the autocomplete popup
local cmp = require("cmp")
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings =
    lsp.defaults.cmp_mappings(
    {
        -- prev item in menu
        ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),

        -- next item in menu
        ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),

        -- confirm current selection
        ["<Enter>"] = cmp.mapping.confirm({select = true}),

        -- misc
        ["<C-Space>"] = cmp.mapping.complete()
    }
)

-- assigning previously defined mappings
lsp.setup_nvim_cmp(
    {
        mappings = cmp_mappings
    }
)

lsp.setup()
