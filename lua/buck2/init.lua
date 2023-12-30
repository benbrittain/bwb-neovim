local M = {
  config = nil,
  lsp = nil,
  standalone = nil,
  hover_actions = nil,
  server_status = nil,
  utils = nil,
}

function M.setup(opts)
  local commands = require("buck2.commands")

  local config = require("buck2.config")
  M.config = config

  local lsp = require("buck2.lsp")
  M.lsp = lsp

  local hover_actions = require("buck2.hover_actions")
  M.hover_actions = hover_actions

  local server_status = require("buck2.server_status")
  M.server_status = server_status

  local standalone = require("buck2.standalone")
  M.standalone = standalone

  local utils = require("buck2.utils")
  M.utils = utils

  config.setup(opts)
  lsp.setup()
  commands.setup_lsp_commands()
end

return M
