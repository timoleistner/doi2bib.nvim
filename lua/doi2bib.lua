#!/usr/bin/env lua
local curl = require 'cURL'

local Doi2Bib = {}

local function split(s, sep)
    if sep == nil then
        sep = "%s"
    end
    local array = {}
    for str in string.gmatch(s, "([^"..sep.."]+)") do
        table.insert(array, str)
    end
    return array
end

--- Replaces <cWORD> DOI with the corresponding bibtex entry
function Doi2Bib.doi2bib()
    local doi = vim.call('expand', '<cWORD>')
    local url = "http://api.crossref.org/works/" .. doi .. "/transform/application/x-bibtex"
    local c = curl.easy{ url = url }
    local body = {}
    c:setopt_writefunction(table.insert, body)
    c:perform()
    local curl_string = table.concat(body)
    local table = split(curl_string, "\n")

    local buf = vim.api.nvim_get_current_buf()
    local row = vim.api.nvim_win_get_cursor(0)[1]

    local shiftwidth = vim.api.nvim_get_option("shiftwidth")
    for i, line in ipairs(table) do
        table[i] = line:gsub("\t", string.rep(" ", shiftwidth))
    end

    --- replace current line (with doi) with bibtex entry
    if string.match(table[1], "Resource not found.") then
        print(table[1])
    else
        vim.api.nvim_buf_set_lines(buf, row - 1, row, "v:true", table)
    end
end

return Doi2Bib
