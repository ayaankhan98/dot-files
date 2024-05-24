function KeyMap(mode, shortcut, command) 
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

function VimKeyMap(mode, shortcut, command)  vim.keymap.set(mode, shortcut, command, { noremap = true, silent = true })
end


KeyMap("n", "<C-Right>", ":tabnext<Enter>")
KeyMap("n", "<C-Left>", ":tabprevious<Enter>")
KeyMap("n", "<F4>", ":!g++ % -Wall -Werror -std=c++17 -fsanitize=address -fsanitize=leak -fsanitize=undefined -fsanitize=null -fsanitize=vla-bound -fsanitize=return -fsanitize=bounds -fsanitize=pointer-compare -fsanitize=pointer-subtract -fsanitize=integer-divide-by-zero -fsanitize=unreachable -fsanitize=null -fsanitize=signed-integer-overflow  -fsanitize=alignment -fsanitize=float-divide-by-zero -fsanitize=float-cast-overflow -fsanitize=pointer-overflow -g<Enter>")
-- KeyMap("n", "<F5>", ":r ~/algorithms/template.cpp<Enter>")
-- KeyMap("n", "<F3>", ":!cat ./input.txt<Enter>")
-- KeyMap("n", "<F2>", ":!cat ./output.txt<Enter>")
-- KeyMap("n", "<F1>", ":!./a.out<Enter>")

-- Telescope
KeyMap('', '<C-f>', ":Telescope find_files<Enter>");
KeyMap('', '<C-z>', ':NvimTreeFindFile<Enter>');
KeyMap('', '<C-g>', ":Telescope live_grep<Enter>");
KeyMap('n', '<leader>fb', ":Telescope buffers<Enter>");
KeyMap('n', '<leader>fh', ":Telescope help_tags<Enter>");

-- NvimTree
KeyMap('', '<C-b>', ":NvimTreeToggle<Enter>");
KeyMap('n', '<C-q>', ":NvimTreeResize +5<Enter>");
KeyMap('n', '<C-a>', ":NvimTreeResize -5<Enter>");

-- Lazygit
KeyMap('', '<C-n>', ':LazyGit<Enter>');

-- Tagbar
KeyMap('', '<C-s>', ':Tagbar<Enter>');

-- Angular component switch keymap
local ng = require("ng");
VimKeyMap("n", "<C-l>", ng.goto_template_for_component)
VimKeyMap("n", "<C-t>", ng.goto_component_with_template_file)

