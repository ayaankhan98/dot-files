-- Vim startify options
vim.g.startify_lists = {
  {type = 'dir', header = {'                             Recent Files in the Current Directory'}},
  {type = 'commands', header = {'   Commands'}}
}

vim.g.startify_padding_left = 30


vim.g.startify_custom_header = {
'                                                  .o+`                 ',
'                                                 `ooo/                   ',
'                                                `+oooo:                  ',
'                                               `+oooooo:                ',
'                                               -+oooooo+:                ',
'                                             `/:-:++oooo+:              ',
'                                            `/++++/+++++++:              ',
'                                           `/++++++++++++++:  Y A A N    ',
'                                          `/+++ooooooooooooo/`           ',
'                                         ./ooosssso++osssssso+`          ',
'                                        .oossssso-````/ossssss+`         ',
'                                       -osssssso.      :ssssssso.        ',
'                                      :osssssss/        osssso+++.       ',
'                                     /ossssssss/        +ssssooo/-       ',
'                                   `/ossssso+/:-        -:/+osssso+-',
'                                  `+sso+:-`                 `.-/+oso:',
'                                 `++:.                           `-/+/',}

-- vim.g.startify_commands = {
--   ':!nmtui',
--   {'Exit', ':q'}
-- }

vim.g.startify_update_oldfiles = 1

vim.loader.enable()
vim.g.startify_change_to_dir = 0
