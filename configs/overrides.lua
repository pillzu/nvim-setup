local M = {}

M.treesitter = {
  ensure_installed = {
    "vim",
    "lua",
    "html",
    "go",
    "python",
    "css",
    "javascript",
    "typescript",
    "tsx",
    "c",
    "markdown",
    "markdown_inline",
  },
  indent = {
    enable = true,
  },
}

M.mason = {
  ensure_installed = {
    -- lua stuff
    "lua-language-server",
    "stylua",

    -- web dev stuff
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "deno",
    "prettier",

    -- c/cpp stuff
    "clangd",
    "clang-format",

    -- python
    "buf",
    "autoflake",
    "autopep8",
    "python-lsp-server",

    -- go stuff
    "gofumpt",
    "goimports",
    "goimports-reviser",
    "golangci-lint",
    "golangci-lint-langserver",
    "golines",
    "gopls",

    -- docker
    "docker-compose-language-service",
    "dockerfile-language-server",
  },
}

-- git support in nvimtree
M.nvimtree = {
  git = {
    enable = true,
  },
  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
}
M.nvdash = {
  load_on_startup = true,
}

M.statusline = {
  overridden_modules = function()
    local st_modules = require "nvchad_ui.statusline.minimal"
    return {
      mode = function()
        return st_modules.mode() .. " bruh "
        -- or just return "" to hide this module
      end,
    }
  end,
}

return M
