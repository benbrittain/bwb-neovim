local buck2 = require("buck2")

local M = {}

function M.start_standalone_client()
  print("START STANDALONE")
  print(vim.print(buck2.config.options.server.capabilities))
  local config = {
    root_dir = require("lspconfig.util").path.dirname(
      vim.api.nvim_buf_get_name(0)
    ),
    capabilities = buck2.config.options.server.capabilities,
    cmd = buck2.config.options.server.cmd or { "buckle", "lsp" },
    filetypes = { "bzl" },
    init_options = { detachedFiles = { vim.api.nvim_buf_get_name(0) } },
    name = "buck2-lsp-standalone",
    on_init = function(client)
      print("BWB DID THE INIT")
      print(vim.print(buck2.config.options.server.capabilities))
      local current_buf = vim.api.nvim_get_current_buf()
      vim.lsp.buf_attach_client(0, client.id)
      local on_attach = buck2.config.options.server.on_attach
      if on_attach then
        on_attach(client, current_buf)
      end
      --vim.cmd(
      --  "command! Buck2SetInlayHints :lua require('buck2.inlay_hints').set_inlay_hints()"
      --)
      --vim.cmd(
      --  "command! Buck2DisableInlayHints :lua require('buck2.inlay_hints').disable_inlay_hints()"
      --)
      --vim.cmd(
      --  "command! Buck2ToggleInlayHints :lua require('buck2.inlay_hints').toggle_inlay_hints()"
      --)
      --vim.cmd(
      --  "command! Buck2ExpandMacro :lua require('buck2.expand_macro').expand_macro()"
      --)
      --vim.cmd(
      --  "command! Buck2JoinLines :lua require('buck2.join_lines').join_lines()"
      --)
      vim.cmd(
        "command! Buck2HoverActions :lua require('buck2.hover_actions').hover_actions()"
      )
      --vim.cmd(
      --  "command! Buck2MoveItemDown :lua require('buck2.move_item').move_item()"
      --)
      --vim.cmd(
      --  "command! Buck2MoveItemUp :lua require('buck2.move_item').move_item(true)"
      --)
    end,
    on_exit = function()
      --vim.cmd("delcommand Buck2SetInlayHints")
      --vim.cmd("delcommand Buck2DisableInlayHints")
      --vim.cmd("delcommand Buck2ToggleInlayHints")
      --vim.cmd("delcommand Buck2ExpandMacro")
      --vim.cmd("delcommand Buck2JoinLines")
      vim.cmd("delcommand Buck2HoverActions")
      --vim.cmd("delcommand Buck2MoveItemDown")
      --vim.cmd("delcommand Buck2MoveItemUp")
    end,
    handlers = buck2.config.options.server.handlers,
  }

  vim.lsp.start_client(config)
end

return M
