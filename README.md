# 📖 Doi2Bib

A simple plugin which replaces a DOI link with the corresponding BibTex entry using
[Crossrefs REST API](https://www.crossref.org/documentation/retrieve-metadata/rest-api/).

## ⚡️ Requirements
- Internet connection
- curl

## 📦 Installation

### [Packer](https://github.com/wbthomason/packer.nvim)
<!-- -- Lua -->
```Lua
use({
    "timoleistner/doi2bib/",
    rocks = { "Lua-cURL" },
})
```

## 🌱 Usage
###
Doi2Bib comes with the command:
- `Doi2Bib`: Replaces DOI (cWORD) under cursor with BibTex entry.

Example mapping:

```Lua
vim.api.nvim_set_keymap(
    'n', 'gb', '<cmd>lua require("doi2bib").doi2bib()<cr>',
    { noremap = true, silent = true }
)
```
