local stat_mode = require('stat.mode')

Stat = {}

function Stat.get_status_line()
    local mode_name = stat_mode.get_full_mode_name()
    local statusline = {
        mode_name,
        ' %f',
        ' %m',
        ' %r',
        '%=',
        ' %y',
        ' %l:%c',
    }
    return table.concat(statusline, '')
end

vim.o.statusline = '%!v:lua.Stat.get_status_line()'
