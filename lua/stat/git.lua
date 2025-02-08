local M = {}

local stat_util = require('stat.util')

local MIN_WIDTH = 8

local function file_in_repo()
    local file_dir = vim.fn.expand('%:p:h')
    local git_command = string.format('git -C %s rev-parse --is-inside-work-tree > /dev/null 2>&1', file_dir)
    local code = os.execute(git_command)
    return code == 0
end

local function get_branch_name()
    local file_dir = vim.fn.expand('%:p:h')
    local git_command = string.format('git -C %s branch --show-current', file_dir)
    local out_file = io.popen(git_command, 'r')
    local branch_name = out_file:read('*l') or 'detached HEAD'
    out_file:close()
    return branch_name
end

local function get_status_line_string(args)
    if not file_in_repo() then
        return ''
    end

    local status_string = '⎇ ' .. get_branch_name()

    if args and args.max_width then
        local max_width = math.max(MIN_WIDTH, args.max_width)
        status_string = stat_util.truncate_right(status_string, max_width)
    end

    return status_string
end

M = {
    get_status_line_string = get_status_line_string
}

return M
