--[[
  File: mason.lua
  Description: Mason plugin configuration (with lspconfig)
  See: https://github.com/williamboman/mason.nvim
]]

local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local lspconfig = require("lspconfig")
local rt = require("rust-tools")

mason.setup({
    ui = {
        icons = {
            package_installed = "✔️,",
            package_pending = "⏳",
            package_uninstalled = "❌",
        },
    }
})

mason_lspconfig.setup({
  ensure_installed = {
    "rust_analyzer",      -- LSP for Rust
  }
});

-- Setup every needed language server in lspconfig
mason_lspconfig.setup_handlers {
  function (server_name)
    lspconfig[server_name].setup {}
  end,
  
  ["rust_analyzer"] = function()
    rt.setup {}
  end
}
