-- Per-project competItest config. competItest finds this by walking up from the
-- buffer's directory until it hits a .competitest.lua (see
-- config.load_local_config), and merges it over the global setup.
--
-- Its job here is routing: competitive-companion sends `group` as
-- "<judge> - <contest>" and competItest exposes the judge half as $(JUDGE).
-- This does the same split in Lua so the directory can be a plain slug instead
-- of whatever the judge calls itself ("CS Academy", with the space).
--
-- Nothing here is required for competItest to work -- without this file a
-- received problem lands in your cwd. It just keeps the tree tidy.

-- Root of this repository, taken from this file's own path rather than from
-- getcwd(): the file is loaded with dofile, so debug.getinfo reports where it
-- actually came from, which is correct no matter which directory Neovim was
-- started in. One :h -- this file sits in the root, so that is where it ends.
local root = vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":h")

-- Judge name as competitive-companion spells it -> directory under src/.
local SOURCES = {
  ["cs academy"] = "csacademy",
  ["hackerrank"] = "hackerrank",
}

---@param task table competitive-companion task
---@return string
local function source_dir(task)
  local judge = task.group:match("^(.-)%s+%-%s+") or task.group
  -- An unmapped judge still gets a directory rather than landing in src/
  -- directly, just spelled consistently with the mapped ones.
  return SOURCES[judge:lower()] or (judge:gsub("%s+", ""):lower())
end

--- Problem names come across as free-form titles ("A. Castle Defense"), so
--- they need to become something that survives being a file name.
---@param name string
---@return string
local function slug(name)
  return (name:gsub("[^%w%-_]", "-"):gsub("%-+", "-"):gsub("^%-+", ""):gsub("%-+$", ""))
end

return {
  -- Testcases go in a dot-directory next to the source instead of beside it.
  -- competitest reads and writes through the same path
  -- (testcases.lua: buf_get_testcases_path), so this moves both directions, and
  -- utils.write_string_on_file creates the directory on first write.
  --
  -- It is one directory per tier, not per problem, so the file names still
  -- carry the problem name -- testcases_input_file_format's default of
  -- "$(FNOEXT)_input$(TCNUM).txt" is what keeps two problems in the same tier
  -- from overwriting each other.
  testcases_directory = ".testcases",

  -- Where :CompetiTest receive problem puts the source file. This is only the
  -- pre-filled value: received_problems_prompt_path keeps the dialog up, so
  -- you can retype it into a tier directory (src/csacademy/Hard/...) when you
  -- already know how hard the problem is.
  received_problems_path = function(task, file_extension)
    return ("%s/src/%s/%s.%s"):format(root, source_dir(task), slug(task.name), file_extension)
  end,

  -- Only HackerRank has a contest parser; CS Academy does not, so
  -- :CompetiTest receive contest is a HackerRank-only thing.
  received_contests_directory = function(task)
    return ("%s/src/%s"):format(root, source_dir(task))
  end,
  received_contests_problems_path = function(task, file_extension)
    return ("%s.%s"):format(slug(task.name), file_extension)
  end,
}
