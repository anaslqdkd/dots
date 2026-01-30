local M = {}
function M.toggle_checkbox()
  local line = vim.api.nvim_get_current_line()
  if line:match("%- %[ %]") then
    line = line:gsub("%- %[ %]", "- [x]", 1)
  elseif line:match("%- %[x%]") then
    line = line:gsub("%- %[x%]", "- [ ]", 1)
  end
  vim.api.nvim_set_current_line(line)
end



function M.continue_checkbox_normal()
  local row = vim.api.nvim_win_get_cursor(0)[1] -- 1-indexed row
  local line = vim.api.nvim_buf_get_lines(0, row-1, row, false)[1]

  local prefix = line:match("^%s*%- %[ %]") or line:match("^%s*%- %[x%]") 
  print(prefix)
  if prefix then
	  local prefix = "- [ ]" .. "  "
    vim.api.nvim_buf_set_lines(0, row, row, true, {prefix})
    vim.api.nvim_win_set_cursor(0, {row + 1, #prefix})
	vim.api.nvim_feedkeys("i", "n", false)
  else
    vim.api.nvim_input("o")
  end
end



return M
