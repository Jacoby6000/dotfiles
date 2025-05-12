return {
  cmd = { "pylsp" },
  filetypes = { "python" },
  root_markers = { ".git", "pyproject.toml", "requirements.txt", "setup.py", "setup.cfg" },
  settings = {
    pylsp = {
      plugins = {
        flake8 = { enabled = true },
        mypy = { enabled = true },
        isort = { enabled = true },
        jedi_completion = { enabled = false },
        rope_autoimport = { enabled = true },
        rope_completion = { enabled = true },
      },
    },
  },
}
