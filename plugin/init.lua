local stat_mode = require('stat.mode')
local stat_git = require('stat.git')
local stat_lsp = require('stat.lsp')

Stat = {}

local COMPACT_WIN_WIDTH = 100

local MAX_GIT_BRANCH_WIDTH = 16

local function redraw_status_line()
    vim.cmd("redrawstatus")
end

vim.api.nvim_create_autocmd({
    "LspAttach", 
    "LspDetach", 
},{
    callback = redraw_status_line
})

-- TODO: Implement status messages
--[[
vim.api.nvim_create_autocmd({
    "LspRequest", 
    "LspProgressUpdate",
},{
    group = "User",
    callback = redraw_status_line
})
--]]

function Stat.get_status_line()
    local window_width = vim.fn.winwidth(vim.fn.win_getid())
    local is_compact = window_width <= COMPACT_WIN_WIDTH

    local mode_name = stat_mode.get_status_line_string()
    local branch_name = stat_git.get_status_line_string({ max_width = MAX_GIT_BRANCH_WIDTH })
    local lsp_string = stat_lsp.get_status_line_string({ show_client_name = not is_compact })

    local status_line = {
        ' ' .. mode_name,
        string.len(branch_name) > 0 and (' | ' .. branch_name) or '',
        ' | %f',
        ' %m%r',
        '%=',
        lsp_string,
        ' %y',
        ' %l:%c',
    }

    return table.concat(status_line, '')
end

vim.o.statusline = '%!v:lua.Stat.get_status_line()'
