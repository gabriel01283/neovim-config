
--CONFIGS DE USO--

vim.g.mapleader = " "

vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.smartindent = true
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.scrolloff = 8
vim.opt.wrap = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.clipboard = "unnamedplus"
vim.opt.undofile = true
vim.opt.swapfile = true
vim.opt.splitright = true
vim.opt.splitbelow = true

--CONEXÃO E CONFIGURAÇÃO DO LAZY.NVIM--

vim.opt.rtp:prepend(vim.fn.stdpath("data") .. "/lazy/lazy.nvim")

require("lazy").setup({
    "xero/miasma.nvim",
    "rebelot/heirline.nvim",

    {
        "nvim-treesitter/nvim-treesitter",
        branch = "master",
        build = ":TSUpdate",
    },

    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-nvim-lsp",
        },
    },

    {
        "mason-org/mason.nvim",
        opts = {},
    },

    {
        "neovim/nvim-lspconfig",
    },

    {
        "mason-org/mason-lspconfig.nvim",
        dependencies = {
            "mason-org/mason.nvim",
            "neovim/nvim-lspconfig",
        },
        opts = {
            ensure_installed = {
                "lua_ls",
                "basedpyright",
                "clangd",
                "ts_ls",
                "html",
                "cssls",
                "jsonls",
                "gopls",
                "kotlin_language_server",
                "jdtls",
                "sqls",
            },
            automatic_enable = false,
        },
    },

    {
        "nvim-tree/nvim-tree.lua",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
    },

    {
        "tpope/vim-dadbod",
        lazy = false,
    },

    {
        "kristijanhusak/vim-dadbod-ui",
        dependencies = {
            "tpope/vim-dadbod",
        },
        lazy = false,
    },

    {
        "kristijanhusak/vim-dadbod-completion",
        dependencies = {
            "tpope/vim-dadbod",
        },
        lazy = false,
    },
})

--TEMA--

vim.cmd.colorscheme("miasma")

--TREESITTER--

require("nvim-treesitter.configs").setup({
    ensure_installed = {
        "lua",
        "python",
        "java",
        "javascript",
        "typescript",
        "tsx",
        "c",
        "cpp",
        "c_sharp",
        "go",
        "kotlin",
        "html",
        "css",
        "json",
        "sql",
        "bash",
        "markdown",
        "markdown_inline",
    },

    highlight = {
        enable = true,
    },
})

--DIRETORIO DO PROJETO--

vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        local arquivo = vim.fn.expand("%:p")

        if arquivo ~= "" and vim.fn.filereadable(arquivo) == 1 then
            vim.cmd.cd(vim.fn.fnameescape(vim.fn.fnamemodify(arquivo, ":h")))
        end
    end,
})

--EXPLORADOR DE ARQUIVOS--

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup({
    sort = {
        sorter = "case_sensitive",
    },

    view = {
        width = 32,
        side = "left",
    },

    sync_root_with_cwd = true,
    respect_buf_cwd = true,

    renderer = {
        group_empty = true,
        highlight_git = true,

        icons = {
            show = {
                file = true,
                folder = true,
                folder_arrow = true,
                git = true,
            },
        },
    },

    filters = {
        dotfiles = false,
    },

    git = {
        enable = true,
        ignore = false,
    },

    update_focused_file = {
        enable = true,
        update_root = false,
    },
})

vim.keymap.set("n", "<C-b>", "<cmd>NvimTreeToggle<CR>", {
    desc = "Abrir ou fechar explorador",
})

vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeFocus<CR>", {
    desc = "Focar no explorador",
})

--CONFIGURAÇÃO DOS SERVIDORES LSP--

local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config("*", {
    capabilities = capabilities,
})

--LUA--

vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },

            diagnostics = {
                globals = { "vim" },
            },
        },
    },
})

--PYTHON--

vim.lsp.config("basedpyright", {
    settings = {
        basedpyright = {
            analysis = {
                typeCheckingMode = "basic",
            },
        },
    },
})

--SQL--

vim.lsp.config("sqls", {
    settings = {
        sqls = {},
    },
})

--ATIVAÇÃO DOS SERVIDORES LSP--

vim.lsp.enable({
    "lua_ls",
    "basedpyright",
    "clangd",
    "ts_ls",
    "html",
    "cssls",
    "jsonls",
    "gopls",
    "kotlin_language_server",
    "sqls",
})

--AUTOCOMPLETAR--

local cmp = require("cmp")

cmp.setup({
    completion = {
        completeopt = "menu,menuone,noselect",
    },

    preselect = cmp.PreselectMode.None,

    mapping = cmp.mapping.preset.insert({
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-p>"] = cmp.mapping.select_prev_item(),

        ["<CR>"] = cmp.mapping.confirm({
            select = false,
        }),
    }),

    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "buffer" },
    }),
})

--AUTOCOMPLETE SQL--

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "sql", "mysql", "plsql" },

    callback = function()
        vim.bo.omnifunc = "vim_dadbod_completion#omni"
    end,
})

--BANCO DE DADOS POSTGRESQL--

vim.g.db_ui_use_nerd_fonts = 0
vim.g.db_ui_show_database_icon = true
vim.g.db_ui_force_echo_notifications = true

vim.keymap.set("n", "<leader>db", "<cmd>DBUIToggle<CR>", {
    desc = "Abrir interface de banco de dados",
})

vim.keymap.set("n", "<leader>df", "<cmd>DBUIFindBuffer<CR>", {
    desc = "Encontrar consulta no banco",
})

vim.keymap.set("n", "<leader>dr", "<cmd>DBUIRenameBuffer<CR>", {
    desc = "Renomear consulta SQL",
})

vim.keymap.set("n", "<leader>dl", "<cmd>DBUILastQueryInfo<CR>", {
    desc = "Informações da última consulta",
})

--DIAGNÓSTICOS--

vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
})

--ATALHOS LSP--

vim.keymap.set("n", "gd", vim.lsp.buf.definition, {
    desc = "Ir para definição",
})

vim.keymap.set("n", "gr", vim.lsp.buf.references, {
    desc = "Mostrar referências",
})

vim.keymap.set("n", "K", vim.lsp.buf.hover, {
    desc = "Mostrar documentação",
})

vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {
    desc = "Renomear símbolo",
})

vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {
    desc = "Ações de código",
})

--BARRA INFERIOR--

local heirline = require("heirline")

local colors = {
    bg = "#292A25",
    fg = "#A5A087",
    green = "#929D59",
    yellow = "#D2BD72",
    dark = "#20211F",
}

local Mode = {
    provider = function()
        local modes = {
            n = "NORMAL",
            i = "INSERT",
            v = "VISUAL",
            V = "VISUAL",
        }

        return " " .. (modes[vim.fn.mode()] or "OUTRO") .. " "
    end,

    hl = {
        fg = colors.dark,
        bg = colors.green,
        bold = true,
    },
}

local FileName = {
    provider = function()
        return " " .. vim.fn.expand("%:t") .. " "
    end,

    hl = {
        fg = colors.green,
        bg = colors.bg,
    },
}

local Position = {
    provider = function()
        return " " .. vim.fn.line(".") .. ":" .. vim.fn.col(".") .. " "
    end,

    hl = {
        fg = colors.fg,
        bg = colors.bg,
    },
}

local StatusLine = {
    Mode,
    FileName,
    { provider = "%=" },
    Position,
}

heirline.setup({
    statusline = StatusLine,
})

--TERMINAL INTEGRADO--

local terminal_buf = nil
local terminal_win = nil

local function toggle_terminal()
    if terminal_win and vim.api.nvim_win_is_valid(terminal_win) then
        vim.api.nvim_win_hide(terminal_win)
        terminal_win = nil
        return
    end

    vim.cmd("botright 12split")
    terminal_win = vim.api.nvim_get_current_win()

    if terminal_buf and vim.api.nvim_buf_is_valid(terminal_buf) then
        vim.api.nvim_win_set_buf(terminal_win, terminal_buf)
    else
        vim.cmd("terminal")
        terminal_buf = vim.api.nvim_get_current_buf()
    end

    vim.cmd("startinsert")
end

vim.keymap.set({ "n", "t" }, "<C-x>", function()
    if vim.api.nvim_get_mode().mode == "t" then
        vim.cmd("stopinsert")
    end

    toggle_terminal()
end, {
    desc = "Abrir ou esconder terminal",
})
