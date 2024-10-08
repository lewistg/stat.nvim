local M = {}

local function get_full_mode_name()
    local short_name = vim.fn.mode()
    if string.find(short_name, "^n") then
        return "NORMAL"
    elseif string.find(short_name:lower(), "^v") or string.find(short_name, "^CTRL-V") then
        return "VISUAL"
    elseif string.find(short_name:lower(), "^s") or string.find(short_name, "^CTRL-S") then
        return "SELECT"
    elseif string.find(short_name, "^i") then
        return "INSERT"
    elseif string.find(short_name, "^R") then
        return "REPLACE"
    elseif string.find(short_name, "^c") then
        return "COMMAND"
    elseif string.find(short_name, "^r") then
        return "PROMPT"
    elseif short_name == "!" then 
        return "SHELL"
    elseif short_name == "t" then 
        return "TERMINAL"
    else
        return "UNKNOWN"
    end
end

M = {
    get_full_mode_name = get_full_mode_name
}

return M
