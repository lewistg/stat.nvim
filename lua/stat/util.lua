local M = {}

local function truncate_right(str, max_width)
    if string.len(str) < max_width then
        return str
    end
    return string.sub(str, 0, math.max(1, max_width - 1)) .. '>'
end

M = {
    truncate_right = truncate_right
}

return M
