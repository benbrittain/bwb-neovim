local M = {
  lsp = nil,
  standalone = nil,
}

function M.setup(opts)
  local commands = require("buck2.commands")

  local config = require("buck2.config")
  M.config = config

  local lsp = require("buck2.lsp")
  M.lsp = lsp

  config.setup(opts)
  lsp.setup()
  commands.setup_lsp_commands()
end

return M
