--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`
--
--
--
--
--
--- NOTE: -  HERE ARE MY PERSON TEMPLATES !!!!!!

-- Function to create a new file from the template
function create_cpp_template(filename)
  -- Define the path to your template file
  local template_path = vim.fn.stdpath 'config' .. '/coding_templates/cpp_comp_coding_template.cpp'

  -- Read the content of the template file
  local template_file = io.open(template_path, 'r')
  if not template_file then
    print 'Error: Template file not found!'
    return
  end
  local template_content = template_file:read '*all'
  template_file:close()

  -- Open the new file
  vim.cmd('e ' .. filename)

  -- Insert the template content into the new file
  vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(template_content, '\n'))
end

-- Create the custom Neovim command 'NewCppFile'
vim.api.nvim_create_user_command('NewCppFile', function(opts)
  -- opts.args will contain the filename passed to the command
  local filename = opts.args or 'new_file.cpp' -- Default filename if not provided
  create_cpp_template(filename)
end, {
  nargs = '?', -- Allows the command to optionally take a filename as an argument
})

--- NOTE: - END OF PERSONAL TEMPLATES
--
--
-- NOTE: HERE ARE SOME PERSONAL SETTINGS, TABS SHOULD BE 4 SPACES!!!
--
-- Set tab width to 4 spaces
vim.opt.tabstop = 4 -- Number of spaces for a tab
vim.opt.shiftwidth = 4 -- Number of spaces for autoindent
vim.opt.expandtab = true -- Convert tabs to spaces

-- Optional: Ensure consistency when pasting code or opening files
vim.opt.smarttab = true -- Tab behavior when editing
vim.opt.autoindent = true -- Auto-indent new lines
vim.opt.smartindent = true -- Smart indentation for code
-- Make line numbers default
--
--
--
---- Auto-indent for C++ loops
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'cpp',
  callback = function()
    vim.bo.smartindent = true
    vim.bo.cindent = true
    vim.bo.autoindent = true
  end,
})

--  NOTE: HERE IS THE END OF MY PERSONAL CHANGES, THE REST IS TEMPLATES
--
--
--
vim.opt.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
-- vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
