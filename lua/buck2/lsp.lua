local buck2 = require("buck2")
local lspconfig = require("lspconfig")
local lspconfig_utils = require("lspconfig.util")
local server_status = require("buck2.server_status")

local M = {}

local function setup_autocmds()
  local group = vim.api.nvim_create_augroup("Buck2Autocmds", { clear = true })

  vim.api.nvim_create_autocmd("VimEnter", {
    pattern = "*.bzl",
    callback = buck2.lsp.start_standalone_if_required,
    group = group,
  });
end

local function setup_capabilities()
  local lsp_opts = buck2.config.options.server
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  -- snippets
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  ---- send actions with hover request
  capabilities.experimental = {
    hoverActions = true,
  --  hoverRange = true,
    serverStatusNotification = true,
  --  snippetTextEdit = true,
  --  codeActionGroup = true,
  --  ssr = true,
  }

  ---- enable auto-import
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = { "documentation", "detail", "additionalTextEdits" },
  }

  ---- rust analyzer goodies
  capabilities.experimental.commands = {
    commands = {
      "starlark.enableGotoDefinition",
  ----    --"rust-analyzer.runSingle",
  ----    --"rust-analyzer.debugSingle",
  ----    --"rust-analyzer.showReferences",
  ----    --"rust-analyzer.gotoLocation",
  ----    --"editor.action.triggerParameterHints",
    },
  }

  lsp_opts.capabilities = vim.tbl_deep_extend(
    "force",
    capabilities,
    lsp_opts.capabilities or {}
  )
end


local function get_root_dir(filename)
  local fname = filename or vim.api.nvim_buf_get_name(0)
  -- TODO buckconfig without buckroot
  return lspconfig_utils.root_pattern(".buckroot")(fname) -- or lspconfig_utils.find_git_ancestor(fname)
end

function M.start_standalone_if_required()
  local lsp_opts = buck2.config.options.server
  local current_buf = vim.api.nvim_get_current_buf()

  if
    lsp_opts.standalone
    and buck2.utils.is_bufnr_rust(current_buf)
    and (get_root_dir() == nil)
  then
    require("buck2.standalone").start_standalone_client()
  end
end


local function setup_commands()
  local lsp_opts = buck2.config.options.server

  lsp_opts.commands = vim.tbl_deep_extend("force", lsp_opts.commands or {}, {
    Buck2HoverActions = { buck2.hover_actions.hover_actions },
  })
end

local function setup_on_init()
  local lsp_opts = buck2.config.options.server
  local old_on_init = lsp_opts.on_init

  lsp_opts.on_init = function(...)
    buck2.utils.override_apply_text_edits()
    if old_on_init ~= nil then
      old_on_init(...)
    end
  end
end

local function setup_lsp()
  lspconfig.buck2.setup(buck2.config.options.server)
end

local function setup_handlers()
  local lsp_opts = buck2.config.options.server
  local custom_handlers = {}

  custom_handlers["experimental/serverStatus"] = buck2.utils.mk_handler(
    server_status.handler
  )

  lsp_opts.handlers = vim.tbl_deep_extend(
    "force",
    custom_handlers,
    lsp_opts.handlers or {}
  )
end

local function setup_root_dir()
  local lsp_opts = buck2.config.options.server
  if not lsp_opts.root_dir then
    lsp_opts.root_dir = get_root_dir
  end
end

function M.setup()
  setup_autocmds()
  -- setup capabilities
  setup_capabilities()
  -- setup on_init
  setup_on_init()
  -- setup root_dir
  setup_root_dir()
  ---- setup handlers
  setup_handlers()
  -- setup user commands
  setup_commands()
  -- setup rust analyzer
  setup_lsp()
end

return M
