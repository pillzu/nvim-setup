local M = {}

-- custom.plugins.lspconfig
local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = { "html", "cssls", "clangd", "emmet_ls", "pyright", "gopls", "lua_ls" }
local settings = {
  tsserver = {
    allowIncompleteCompletions = true,
    allowRenameOfImportPath = true,
    allowTextChangesInNewFiles = true,
    displayPartsForJSDoc = true,
    generateReturnInDocTemplate = true,
    includeAutomaticOptionalChainCompletions = true,
    includeCompletionsForImportStatements = true,
    includeCompletionsForModuleExports = true,
    includeCompletionsWithClassMemberSnippets = true,
    includeCompletionsWithObjectLiteralMethodSnippets = true,
    includeCompletionsWithInsertText = true,
    includeCompletionsWithSnippetText = true,
    jsxAttributeCompletionStyle = "auto",
    providePrefixAndSuffixTextForRename = true,
    provideRefactorNotApplicableReason = true,
    documentFormattings = true,
    codeActionsOnSave = {
      source = {
        organizeImports = true,
        removeUnused = true,
        addMissingImports = true,
        fixAll = true,
        sortImports = true,
      }
    }
  },
  lua_ls = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  }
}

local au_lsp = vim.api.nvim_create_augroup("LspFormatter", { clear = true })

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = function(client, bufnr)
      on_attach(client, bufnr)
      if client.server_capabilities.documentFormattingProvider then
        vim.api.nvim_create_autocmd("BufWritePre", {
          pattern = "*",
          callback = function()
            vim.lsp.buf.format()
          end,
          group = au_lsp,
        })
      end
    end,
    capabilities = capabilities,
    settings = settings[lsp]
  }
end

lspconfig.tsserver.setup {
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    client.server_capabilities.documentFormattingProvider = true
    if client.server_capabilities.documentFormattingProvider then
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*",
        callback = function()
          vim.lsp.buf.format()
        end,
        group = au_lsp,
      })
    end
  end,
  capabilities = capabilities,
  settings = {
    allowIncompleteCompletions = true,
    allowRenameOfImportPath = true,
    allowTextChangesInNewFiles = true,
    displayPartsForJSDoc = true,
    generateReturnInDocTemplate = true,
    includeAutomaticOptionalChainCompletions = true,
    includeCompletionsForImportStatements = true,
    includeCompletionsForModuleExports = true,
    includeCompletionsWithClassMemberSnippets = true,
    includeCompletionsWithObjectLiteralMethodSnippets = true,
    includeCompletionsWithInsertText = true,
    includeCompletionsWithSnippetText = true,
    jsxAttributeCompletionStyle = "auto",
    providePrefixAndSuffixTextForRename = true,
    provideRefactorNotApplicableReason = true,
    documentFormattings = true,
    codeActionsOnSave = {
      source = {
        organizeImports = true,
        removeUnused = true,
        addMissingImports = true,
        fixAll = true,
        sortImports = true,
      }
    }
  }
}


return M
