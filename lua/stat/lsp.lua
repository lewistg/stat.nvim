local M = {}

-- TODO: Implement color status counts
-- See: `help: diagnostic-highlights`
local DIAGNOSTIC_HIGHLIGHT_GROUPS = {
    [vim.diagnostic.severity.ERROR] = "DiagnosticError",
    [vim.diagnostic.severity.WARN] = "DiagnosticWarn",
    [vim.diagnostic.severity.INFO] = "DiagnosticInfo",
    [vim.diagnostic.severity.HINT] = "DiagnosticHint",
}

local function get_attached_client_names()
    local clients = vim.lsp.get_active_clients({bufnr = vim.api.nvim_get_current_buf()})
    local names = {}
    for i, client in ipairs(clients) do
        names[i] = client.name
    end
    return names
end

local function get_diagnostic_counts()
    local counts = {
        [vim.diagnostic.severity.ERROR] = 0,
        [vim.diagnostic.severity.WARN] = 0,
        [vim.diagnostic.severity.INFO] = 0,
        [vim.diagnostic.severity.HINT] = 0,
    }
    local diagnostics = vim.diagnostic.get(vim.api.nvim_get_current_buf(), { min = vim.diagnostic.severity.ERROR })
    for _, value in ipairs(diagnostics) do
        counts[value.severity] = counts[value.severity] + 1
    end
    return counts 
end

local function get_status_line_string(args)
    local client_names = get_attached_client_names()
    if #client_names == 0 then
        return ''
    end

    local show_client_name = (args and args.show_client_name == nil) and true or args.show_client_name
    print((args and args.show_client_name ~= nil))

    local status_string = {
        '🛠',
        show_client_name and (' ' .. client_names[1]) or '',
        ' ',
    }

    local diagnostic_counts = get_diagnostic_counts()
    local severities = {
        vim.diagnostic.severity.ERROR,
        vim.diagnostic.severity.WARN,
        vim.diagnostic.severity.INFO,
    }
    local severity_counts = {}
    for i, severity in ipairs(severities) do
        -- TODO: Implement color status counts
        -- local highlight_group = '%#' .. DIAGNOSTIC_HIGHLIGHT_GROUPS[severity] .. '#'
        -- severity_counts[i] = highlight_group .. diagnostic_counts[severity] .. '%#StatusLine#'
        severity_counts[i] = diagnostic_counts[severity]
    end
    severity_counts = '(' .. table.concat(severity_counts, ',') .. ')'

    table.insert(status_string, severity_counts)

    return table.concat(status_string, '')
end

M = {
    get_status_line_string = get_status_line_string
}

return M
