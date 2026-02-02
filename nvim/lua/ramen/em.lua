-- Emulate Emacs useful bindings

local function get_position()
    return #((vim.fn.getcmdline() .. ' '):sub(1, vim.fn.getcmdpos())) - 1
end

local function move(from, to)
    if from < to then
        return string.rep('<Right>', to - from)
    else
        return string.rep('<Left>', from - to)
    end
end

local function kill(from, to)
    if from == to then
        return ''
    end

    if from < to then
        return string.rep('<Del>', to - from)
    else
        return string.rep('<BS>', from - to)
    end
end

local function previous_word(position)
    local line = vim.fn.getcmdline()
    while position > 0 and not line:sub(position, position):match('%w') do
        position = position - 1
    end
    while position > 0 and line:sub(position, position):match('%w') do
        position = position - 1
    end

    return position
end

local function next_word(position)
    local line = vim.fn.getcmdline()
    while position < #line and not line:sub(position, position):match('%w') do
        position = position + 1
    end
    while position < #line and line:sub(position, position):match('%w') do
        position = position + 1
    end

    return position
end

vim.keymap.set('c', '<C-a>', '<Home>', { noremap = true })
vim.keymap.set('c', '<C-e>', '<End>', { noremap = true })
vim.keymap.set('c', '<C-p>', '<Up>', { noremap = true })
vim.keymap.set('c', '<C-n>', '<Down>', { noremap = true })
vim.keymap.set('c', '<C-b>', '<Left>', { noremap = true })
vim.keymap.set('c', '<C-f>', '<Right>', { noremap = true })
vim.keymap.set('c', '<C-d>', '<Delete>', { noremap = true })
vim.keymap.set('c', '<C-h>', '<BS>', { noremap = true })
vim.keymap.set('c', '<C-k>', function()
    return kill(get_position(), #vim.fn.getcmdline())
end, { expr = true, noremap = true })
vim.keymap.set('c', '<M-b>', function()
    local position = get_position()
    return move(position, previous_word(position))
end, { expr = true, noremap = true })
vim.keymap.set('c', '<M-f>', function()
    local position = get_position()
    return move(position, next_word(position))
end, { expr = true, noremap = true })
vim.keymap.set('c', '<M-d>', function()
    local position = get_position()
    return kill(position, next_word(position))
end, { expr = true, noremap = true })
vim.keymap.set('c', '<M-BS>', function()
    local position = get_position()
    return kill(position, previous_word(position))
end, { expr = true, noremap = true })

vim.keymap.set('n', '<C-x><C-f>', function()
    local ok, path = pcall(vim.fn.input, {
        prompt = 'Find file: ',
        default = vim.fn.fnamemodify(vim.fn.expand('%:p:h'), ':~') .. '/',
        completion = 'file',
    })

    if not ok or not path or path == '' then
        return
    end

    vim.cmd.edit(vim.fn.fnamemodify(vim.fn.expand(path), ':p:.'))
end, { noremap = true })

vim.keymap.set('n', '<C-x>b', function()
    local last_buffer = vim.fn.fnamemodify(vim.fn.bufname('#'), ':~:.')
    local default = last_buffer ~= '' and (' (default ' .. last_buffer .. ')') or ''
    local ok, name = pcall(vim.fn.input, {
        prompt = 'Switch to buffer' .. default .. ': ',
        completion = 'buffer',
    })

    if not ok then
        return
    end

    if name == '' then
        vim.cmd.buffer('#')
        return
    end

    local bufnr = vim.fn.bufnr(name)
    if bufnr ~= -1 then
        vim.cmd.buffer(bufnr)
    end
end, { noremap = true })
