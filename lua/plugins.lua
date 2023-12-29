--[[
  File: plugins.lua
  Description: This file needed for loading plugin list into lazy.nvim and loading plugins
  Info: Use <zo> and <zc> to open and close foldings
  See: https://github.com/folke/lazy.nvim
]]

require "helpers/globals"

return {

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
