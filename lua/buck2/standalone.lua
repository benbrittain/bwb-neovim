local b2 = require("buck2")
local M = {}

function M.start_standalone_client()
  local config = {
    root_dir = require("lspconfig.util").path.dirname(
      vim.api.nvim_buf_get_name(0)
    ),
    name = "buck2-lsp-standalone",
    init_options = { detachedFiles = { vim.api.nvim_buf_get_name(0) } },
    cmd = { "buck2 lsp" },
    filetypes = { "buck2" },
    --    capabilities = rt.config.options.server.capabilities,
    on_init = function(client)
      local current_buf = vim.api.nvim_get_current_buf()
      vim.lsp.buf_attach_client(0, client.id)
      --local on_attach = rt.config.options.server.on_attach
      --if on_attach then
      --  on_attach(client, current_buf)
      --end
    end
  }

  vim.lsp.start_client(config)
end
