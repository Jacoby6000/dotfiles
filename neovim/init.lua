local enabled_lsp_servers = {
  "basedpyright",
  "vtsls",
  "lua-language-server"
}

local function setup_lazy(plugins, opts)
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", -- latest stable release
      lazypath,
    })
  end
  vim.opt.rtp:prepend(lazypath)

  require("lazy").setup(plugins, opts)
end

local function configure_lsp()
  vim.lsp.config("*", {
    capabilities = {
      textDocument = {
        semanticTokens = {
          multilineTokenSupport = true,
        },
      },
    },
    root_markers = { ".git" },
  })

  for server in enabled_lsp_servers do
    vim.lsp.enable(server)
  end
end

local function render_dashboard() 
  --require("extras.pending_reviews")
  --local dashboard_bufnr = vim.api.nvim_create_buf(false, false)
  --draw_github_notifications(dashboard_bufnr)
end

function main()
  -- vim.lsp.set_log_level(vim.log.levels.TRACE)
  
  require("config.keymaps")
  require("config.options")
  configure_lsp()

  setup_lazy("plugins")
  require("config.autocmds")

end


main()
