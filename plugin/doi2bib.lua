#!/usr/bin/env lua

if vim.g.loaded_doi2bib then
    return
end

vim.api.nvim_create_user_command('Doi2Bib', function() require("doi2bib").doi2bib() end, { nargs = '*' })
-- vim.api.nvim_add_user_command('Upper', 'echo toupper(<q-args>)', { nargs = 1 })
