local M = {}

local root_patterns = {
  ".git",
  ".clang-format",
  "pyproject.toml",
  "setup.py",
  "build.sbt",
  ".env",
  "mvnw",
  "gradlew",
}

function M.get_project_root()
  local root_patterns = { ".git", ".clang-format", "pyproject.toml", "setup.py", "build.sbt", ".env" }
  local root_dir = vim.fs.dirname(vim.fs.find(root_patterns, { upward = true })[1])
  return root_dir or "."
end

function M.glob_list(glob_pattern)
  return vim.fn.glob(glob_pattern, 1, 1)
end

function M.latest_local_maven_release(organization, artifact)
  local maven_repo = vim.env.HOME .. "/.m2/repository"
  local organization_path = organization:gsub("%.", "/")
  local versions = vim.fn.glob(maven_repo .. "/" .. organization_path .. "/" .. artifact .. "/*", 1, 1)

  local function version_parts(version_string)
    local parts = {}
    -- only extract numbers
    for part in version_string:gmatch("%d+") do
      table.insert(parts, part)
    end
    return parts
  end

  local function sort_version_strings(a, b)
    local a_parts = version_parts(a)
    local b_parts = version_parts(b)

    for i = 1, math.min(#a_parts, #b_parts) do
      local a_num = tonumber(a_parts[i])
      local b_num = tonumber(b_parts[i])
      if a_num ~= b_num then
        return a_num > b_num
      end
    end
  end

  table.sort(versions, sort_version_strings)

  local latest_version = versions[1]

  local jars = vim.fn.glob(latest_version .. "/*.jar", 1, 1)

  return jars
end

return M
