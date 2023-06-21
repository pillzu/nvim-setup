local present, null_ls = pcall(require, "null-ls")

if not present then
  return
end

local b = null_ls.builtins

local sources = {

  -- webdev stuff
  b.diagnostics.eslint_d,
  b.code_actions.eslint_d,
  b.formatting.deno_fmt, -- choosed deno for ts/js files cuz its very fast!
  b.formatting.prettier.with { filetypes = { "html", "markdown", "css" } }, -- so prettier works only on these filetypes

  -- Lua
  b.formatting.stylua,

  -- cpp
  b.formatting.clang_format,

  -- buf
  b.diagnostics.buf,
  b.formatting.buf,

  -- python
  b.formatting.autoflake,
  b.formatting.autopep8,

  -- golang
  b.formatting.gofumpt,
  b.formatting.goimports,
  b.formatting.goimports_reviser,
  b.formatting.golines,
  b.diagnostics.golangci_lint,

  -- docker
  b.diagnostics.hadolint,

  --english
  b.diagnostics.misspell,
}

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
null_ls.setup {
  debug = true,
  sources = sources,
  on_attach = function(client, bufnr)
    -- on_atc(client, bufnr)
    if client.supports_method "textDocument/formatting" then
      vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format()
        end,
      })
    end
  end,
}
