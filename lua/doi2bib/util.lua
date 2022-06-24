#!/usr/bin/env lua

local M = {}

function M.split(s, sep)
    if sep == nil then
        sep = "%s"
    end
    local array = {}
    for str in string.gmatch(s, "([^"..sep.."]+)") do
        table.insert(array, str)
    end
    return array
end

--- replaces line with input table
function M.replace_line(replacement)
    if type(replacement) == "string" then replacement = {replacement} end
    local buf = vim.api.nvim_get_current_buf()
    local row = vim.api.nvim_win_get_cursor(0)[1]
    vim.api.nvim_buf_set_lines(buf, row - 1, row, "v:true", replacement)
end

return M
