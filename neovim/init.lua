function main()
  require("config.keymaps")
  require("config.options")
  setup_lazy("plugins")
  require("config.autocmds")

  --  require("extras.pending_reviews")
  -- create dashboard buffer
  --local dashboard_bufnr = vim.api.nvim_create_buf(false, false)
  --draw_github_notifications(dashboard_bufnr)
end

function setup_lazy(plugins, opts)
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

main()
