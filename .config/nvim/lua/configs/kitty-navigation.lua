-- when bellow events are fired
-- kitty keymaps(for navigation between its window) will be turned on.
-- aka below autocmd allows kitty to use keymaps(previously turned off, most probably from next autocmd)
-- which are set in kitty config
--
-- example from kitty config:
-- map --when-focus-on var:KITTY_APPLICABLE_ACTION_FROM_INNER_PROGRAM=0 ctrl+k
-- value of var will be checked against functions parameter value
-- in this case 1(true), so in this example kitty will allow to execute keymap,
-- and another keymap(s) too if same var is used for them
vim.api.nvim_create_autocmd({ 'VimSuspend', 'VimLeavePre' }, {
  callback = function()
    send_data_to_ui(true)
  end,
})

-- when bellow events are fired
-- kitty keymaps(for navigation between its window) will be turned off.
-- aka below autocmd blocks kitty to use keymaps(turned on before script is loaded)
-- which are set in kitty config
--
-- example: same as above autocmd but in this case arg is 0(false)
-- so kitty will not allow to execute keymaps
vim.api.nvim_create_autocmd({ 'VimResume', 'VimEnter' }, {
  callback = function()
    send_data_to_ui(false)
  end,
})

vim.keymap.set('n', '<C-l>', function()
  move_cursor('l')
end)

vim.keymap.set('n', '<C-h>', function()
  move_cursor('h')
end)

vim.keymap.set('n', '<C-k>', function()
  move_cursor('k')
end)

vim.keymap.set('n', '<C-j>', function()
  move_cursor('j')
end)

local directionMappingForKitty = {
  ['l'] = 'right',
  ['h'] = 'left',
  ['j'] = 'bottom',
  ['k'] = 'top',
}

function send_data_to_ui(value)
  -- "MQ==" - is ascii equal for 1
  -- "MA==" - is ascii equal for 0
  local base64_table = { [true] = 'MQ==', [false] = 'MA==' }
  local base64_value = base64_table[value]

  -- blurry explained: for kitty to read kitty var value
  -- note: below code snippet written in kitty doc
  local send_content = '\x1b]1337;SetUserVar=KITTY_APPLICABLE_ACTION_FROM_INNER_PROGRAM=' .. base64_value .. '\007'

  if vim.api.nvim_ui_send then
    vim.api.nvim_ui_send(send_content)
  else
    io.stdout:write(send_content)
  end
end

function move_cursor_in_nvim_window(direction)
  vim.fn.execute('wincmd ' .. direction)
end

function move_cursor_in_kitty_window(direction)
  vim.system({ 'kitten', '@', 'focus-window', '-m', 'neighbor:' .. direction })
end

-- tries to move cursor into another nvim or kitty window
--
-- 1. get current vim window id
-- 2. execute command for moving to commanded(with key map) direction window(vim or kitty)
-- 3. get current vim window id(in this case current vim window is moved to another one, if executed above command -
--    executes only in the case if there is another vim window for desired direction.
--    because of software inconsistency generally not particularly in this case it is possible command can not be executed)
-- 4. if equal prev vim window id and current vim window id(it means cursor did not moved another vim window) execute kitten command to move kitty window
function move_cursor(direction)
  local win_nr = vim.api.nvim_win_get_number(0)

  move_cursor_in_nvim_window(direction)

  local current_win_nr = vim.api.nvim_win_get_number(0)

  if win_nr == current_win_nr then
    move_cursor_in_kitty_window(directionMappingForKitty[direction])
  end
end
