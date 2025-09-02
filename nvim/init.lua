local home = "/home/zombo"
vim.o.shadafile = home .. "/.local/share/nvim/info.shada"

vim.cmd.syntax('on')
vim.cmd.filetype('on')
vim.o.clipboard = 'unnamedplus'
vim.o.confirm = true
vim.pack.add({
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
});

local nvim_treesitter = require("nvim-treesitter")
nvim_treesitter.setup()
nvim_treesitter.install({ 'c', 'cpp', 'zig', 'javascript' })
vim.api.nvim_create_autocmd('FileType', {
	pattern = '*',
	callback = function() pcall(vim.treesitter.start) end,
})

vim.o.virtualedit = "onemore"
vim.o.sel = "exclusive"
vim.o.guicursor = "n-v-c-sm:block,i-ci-ve:ver20,r-cr-o:hor20,a:blinkwait0-blinkoff500-blinkon500"
vim.o.winborder = 'rounded'
vim.o.wrap = false
vim.o.hlsearch = false
vim.o.number = true
vim.o.relativenumber = true
vim.o.showcmd = true
vim.o.shiftwidth = 4
vim.o.expandtab = false
vim.o.tabstop = 4
vim.o.cursorline = true
vim.o.colorcolumn = "80"
vim.o.so = 16
vim.cmd.highlight({ 'cursorline', 'cterm=NONE', 'ctermbg=0' })
vim.cmd.highlight({ 'cursorlinenr', 'cterm=bold', 'ctermbg=0' })
vim.cmd.highlight({ 'clear', 'cursorlinenr' })
vim.cmd.highlight({ 'linenr', 'ctermfg=6' })
vim.cmd.highlight({ 'folded', 'cterm=bold', 'ctermbg=0' })
vim.cmd.highlight({ 'statusline', 'cterm=NONE', 'ctermbg=8' })
vim.cmd.highlight({ 'statuslineNC', 'cterm=NONE', 'ctermbg=0' })
vim.cmd.highlight({ 'visual', 'ctermfg=NONE', 'ctermbg=8' })
vim.cmd.highlight({ 'colorcolumn', 'cterm=NONE', 'ctermbg=8' })
vim.cmd.highlight({ 'endlwhitespace', 'ctermbg=1' })
vim.fn.matchadd('endlwhitespace', [[\s\+$]])

vim.cmd.highlight({ 'identifier', 'cterm=NONE', 'ctermfg=7' })
vim.cmd.highlight({ 'constant', 'cterm=italic', 'ctermfg=9' })
vim.cmd.highlight({ 'statement', 'ctermfg=11' })
vim.cmd.highlight({ 'type', 'ctermfg=12' })
vim.cmd.highlight({ '@keyword.modifier', 'cterm=bold', 'ctermfg=12' })
vim.cmd.highlight({ 'comment', 'ctermfg=2' })
vim.cmd.highlight({ 'preproc', 'ctermfg=2' })
vim.cmd.highlight({ 'function', 'ctermfg=14' })
vim.cmd.highlight({ 'clear', 'string' })
vim.cmd.highlight({ 'def link', 'string', 'constant' })
vim.cmd.highlight({ 'def link', '@constant.builtin', 'constant' })
vim.cmd.highlight({ 'def link', '@type.builtin', 'type' })
vim.cmd.highlight({ 'def link', '@constructor', 'function' })
vim.cmd.highlight({ 'def link', '@keyword.import', 'preproc' })
vim.cmd.highlight({ 'def link', '@keyword.directive', 'preproc' })

vim.cmd.highlight({ 'netrwTreeBar', 'ctermfg=8' })
vim.cmd.highlight({ 'netrwDir', 'cterm=bold', 'ctermfg=4' })
vim.cmd.highlight({ 'netrwClassify', 'cterm=bold', 'ctermfg=4' })
vim.cmd.highlight({ 'netrwMarkFile', 'cterm=italic', 'ctermfg=2' })

vim.g.netrw_banner = 0;
vim.g.netrw_liststyle = 3;
vim.g.netrw_browse_split = 4;
vim.g.netrw_winsize = 20;
vim.g.netrw_keepdir = 0;
vim.g.netrw_localcopycmd = 'cp -r';
local netrwGroup = vim.api.nvim_create_augroup('netrw', { clear = true });
vim.api.nvim_create_autocmd('VimEnter', {
	pattern = '*',
	command = 'Vexplore',
	group = netrwGroup,
})
vim.api.nvim_create_autocmd('VimEnter', {
	pattern = '*',
	command = 'wincmd l',
	group = netrwGroup,
})

vim.g.mapleader = ' '
vim.keymap.set('n', ' ', '');
vim.keymap.set('n', '<leader>c', '^i// <esc>')
vim.keymap.set('n', '<leader>C', '^i# <esc>')
vim.keymap.set('v', '<leader>c', ':g/./normal ^i// <enter>')
vim.keymap.set('v', '<leader>C', ':g/./normal ^i# <enter>')
vim.keymap.set('n', '<leader>;', '<c-w>w')

local cStyleGroup = vim.api.nvim_create_augroup('cstyle', { clear = true });
vim.api.nvim_create_autocmd('BufWrite', {
	pattern = { '*.cpp', '*.hpp' },
	command = 'mark x',
	group = cStyleGroup,
})
vim.api.nvim_create_autocmd('BufWrite', {
	pattern = { '*.cpp', '*.hpp' },
	command = '%!astyle -A14 -T4 -xnxcxlxkxV -CxGSKxU -pxgHU -k2W3 -Oo',
	group = cStyleGroup,
})
vim.api.nvim_create_autocmd('BufWrite', {
	pattern = { '*.cpp', '*.hpp' },
	command = 'norm \'x',
	group = cStyleGroup,
})
