require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "pylsp", "pyright", "gopls", "ts_ls", "tailwindcss" }
vim.lsp.enable(servers)

-- Configure pylsp settings
vim.lsp.config("pylsp", {
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          maxLineLength = 120,
        },
      },
    },
  },
})

-- Configure gopls settings
vim.lsp.config("gopls", {
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
      gofumpt = true,
    },
  },
})

-- Setup additional buffer keymaps when LSP attaches
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
  callback = function(event)
    local opts = function(desc)
      return { buffer = event.buf, desc = "LSP " .. desc }
    end
    local map = vim.keymap.set

    map("n", "gd", vim.lsp.buf.definition, opts "Go to definition")
    map("n", "gD", vim.lsp.buf.declaration, opts "Go to declaration")
    map("n", "gi", vim.lsp.buf.implementation, opts "Go to implementation")
    map("n", "gr", vim.lsp.buf.references, opts "Show references")
    map("n", "K", vim.lsp.buf.hover, opts "Hover doc")
    map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts "Code action")
    map("n", "<leader>sh", vim.lsp.buf.signature_help, opts "Signature help")

    -- TypeScript / React: jump directly to source definition
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client.name == "ts_ls" then
      map("n", "gs", "<cmd>LspTypescriptGoToSourceDefinition<CR>", opts "Go to source definition")
    end
  end,
})
