local pending_reviews = {}
local popup = nil
local reviews_table = nil

local function clear_table(t)
  for k in pairs(t) do
    t[k] = nil
  end
end

local function sum_table(t, f)
  local sum = 0
  for _, v in ipairs(t) do
    sum = sum + f(v)
  end
  return sum
end

local function extract_label_names(labels)
  local label_strings = {}
  for _, label in ipairs(labels) do
    table.insert(label_strings, label["name"])
  end

  return label_strings
end

local function pad_table_string(s)
  return " " .. s .. " "
end

local function process_output(output)
  local decoded = vim.json.decode(output)
  local prs = {}
  for _, pr in ipairs(decoded) do
    local label_strings = extract_label_names(pr["labels"])

    local insert_pr = {
      pr_location = pr["repository"]["nameWithOwner"] .. "#" .. pr["number"],
      title = pr["title"],
      labels = table.concat(label_strings, ", "),
      lastUpdated = pr["updatedAt"],
      url = pr["url"],
    }

    for k, v in pairs(insert_pr) do
      insert_pr[k] = pad_table_string(v)
    end
    table.insert(prs, insert_pr)
  end

  return prs
end

local function create_table(bufnr, data)
  local NuiTable = require("nui.table")
  local columns_conf = {
    {
      align = "left",
      accessor_key = "pr_location",
      header = pad_table_string("PR"),
    },
    {
      align = "left",
      accessor_key = "title",
      header = pad_table_string("Title"),
    },
    {
      align = "left",
      accessor_key = "labels",
      header = pad_table_string("Labels"),
    },
    {
      align = "right",
      accessor_key = "lastUpdated",
      header = pad_table_string("Last Updated At"),
    },
  }

  return NuiTable({
    bufnr = bufnr,
    columns = columns_conf,
    data = data,
  })
end

local function refresh_layout()
  if not popup then
    local NuiPopup = require("nui.popup")
    popup = NuiPopup({
      enter = true,
      focusable = true,
      border = {
        style = "rounded",
      },
      position = "50%",
      size = {
        width = "10%",
        height = "10%",
      },
    })

    local event = require("nui.utils.autocmd").event
    popup:on(event.BufLeave, function()
      popup:unmount()
    end)
  end

  if not reviews_table then
    reviews_table = create_table(popup.bufnr, pending_reviews)
  end
  reviews_table:render()

  local width = 1 + sum_table(reviews_table.columns, function(c)
    return #c.header + 1
  end)

  popup.size.height = 20
  popup.size.width = width
  popup:mount()
end

function draw_github_notifications()
  local cmd_output = ""
  local error = false

  refresh_layout()

  vim.fn.jobstart(
    "gh search prs --state=open --review-requested=@me --json repository,number,title,labels,updatedAt,url",
    {
      on_exit = function(jobid, data)
        if error then
          print(cmd_output)
          return
        end

        -- clear pending reviews by updating the table
        clear_table(pending_reviews)
        local new_reviews = process_output(cmd_output)
        for _, review in ipairs(new_reviews) do
          table.insert(pending_reviews, review)
        end
        refresh_layout()
      end,
      on_stdout = function(jobid, data)
        local output = data[1]
        if output == "" then
          return
        end
        cmd_output = cmd_output .. output
      end,
      on_stderr = function(job_id, data)
        local output = data[1]
        if output == "" then
          return
        end
        error = true
        cmd_output = "ERROR: " .. output
      end,
    }
  )
end

draw_github_notifications(nil)
