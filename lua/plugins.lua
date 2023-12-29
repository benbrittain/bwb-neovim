--[[
  File: plugins.lua
  Description: This file needed for loading plugin list into lazy.nvim and loading plugins
  Info: Use <zo> and <zc> to open and close foldings
  See: https://github.com/folke/lazy.nvim
]]

require "helpers/globals"

return {
  -- Mason {{{
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
      "simrat39/rust-tools.nvim",
    },
    config = function()
      require "extensions.mason"
    end
  },
  -- }}}

-- CMP {{{
  {
    'hrsh7th/nvim-cmp',
    event = "InsertEnter",
    dependencies = {
      'hrsh7th/cmp-vsnip',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'hrsh7th/vim-vsnip',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'onsails/lspkind-nvim',
    },
    config = function()
      require "extensions.cmp"
    end
  },
  -- }}}

  -- Theme: Gruvbox {{{
  { 
    "ellisonleao/gruvbox.nvim", 
    priority = 1000,
    config = function()
      require "extensions.gruvbox"
    end,
    opts = ...
  }
  -- }}}
}

-- vim:tabstop=2 shiftwidth=2 expandtab syntax=lua foldmethod=marker foldlevelstart=0 foldlevel=0
