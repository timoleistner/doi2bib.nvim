#!/usr/bin/env lua
local curl = require("cURL")
local util = require("doi2bib.util")

local Doi2Bib = {}

--- get bibtex entry as a table
local function get_bibentry()
    local doi = vim.call('expand', '<cWORD>')
    local url = "http://api.crossref.org/works/" .. doi .. "/transform/application/x-bibtex"
    local c = curl.easy{ url = url }
    local body = {}
    c:setopt_writefunction(table.insert, body)
    c:perform()
    local curl_string = table.concat(body)
    return util.split(curl_string, "\n")
end

--- Replaces <cWORD> DOI with the corresponding bibtex entry
function Doi2Bib.doi2bib()
    local table = get_bibentry()

    --- remove \t's with vim.opt.shiftwidth amount of spaces
    local shiftwidth = vim.api.nvim_get_option("shiftwidth")
    for i, line in ipairs(table) do
        table[i] = line:gsub("\t", string.rep(" ", shiftwidth))
    end

    --- replace current line (with doi) with bibtex entry
    if string.match(table[1], "Resource not found.") then
        print(table[1])
    else
        util.replace_line(table)
    end
end

--- Turns a DOI into an URL
function Doi2Bib.doi2url()
    local table = get_bibentry()
    if string.match(table[1], "Resource not found.") then
        print(table[1])
    else
        local url = table[3]:gsub("^%s+url = {", ""):gsub("},", "")
        util.replace_line(url)
    end
end

return Doi2Bib
