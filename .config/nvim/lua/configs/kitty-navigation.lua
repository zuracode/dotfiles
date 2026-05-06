--- check nvim mode for restricting or accepting - kitty window focus, move toward direction actions mappings for kitty-nvim window

function send_data_to_ui(value)
  local base64_table = { [true] = 'MQ==', [false] = 'MA==' }
  local base64_value = base64_table[value]

  local send_content = '\x1b]1337;SetUserVar=KITTY_APPLICABLE_ACTION_FROM_INNER_PROGRAM=' .. base64_value .. '\007'

  if vim.api.nvim_ui_send then
    vim.api.nvim_ui_send(send_content)
  else
    io.stdout:write(send_content)
  end
end

vim.api.nvim_create_autocmd({ 'VimEnter', 'VimResume', 'UIEnter', 'VimLeave', 'VimSuspend', 'BufEnter' }, {
  callback = function()
    send_data_to_ui(true)
  end,
})

vim.api.nvim_create_autocmd('ModeChanged', {
  callback = function()
    local mode = vim.api.nvim_get_mode().mode

    if mode == 'n' then
      send_data_to_ui(true)
    else
      send_data_to_ui(false)
    end
  end,
})
