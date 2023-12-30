local buck2 = require("buck2")

local M = {}

function M.handler(_, result)
  if result.quiescent and not M.ran_once then
    if buck2.config.options.tools.inlay_hints.auto then
      buck2.inlay_hints.enable()
    end
    if buck2.config.options.tools.on_initialized then
      buck2.config.options.tools.on_initialized(result)
    end
    M.ran_once = true
  end
end

return M
