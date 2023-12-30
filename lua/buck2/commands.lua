local buck2 = require("buck2")

local M = {}

function M.setup_lsp_commands()
  vim.lsp.commands["starlark.gotoLocation"] = function(command, ctx)
    local client = vim.lsp.get_client_by_id(ctx.client_id)
    vim.lsp.util.jump_to_location(command.arguments[1], client.offset_encoding)
  end

  vim.lsp.commands["starlark.showReferences"] = function(_)
    vim.lsp.buf.implementation()
  end
end

return M
