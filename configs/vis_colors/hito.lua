-- Hitodama color theme
-- © 2021 Romi Hervier <r@sansfontieres.com>
local lexers = vis.lexers

local colors = {
	['bg_0'] = '#ffffff',
	['bg_1'] = '#ebebeb',
	['bg_2'] = '#cccccc',
	['md_0'] = '#858585',
	['md_1'] = '#5c5c5c',
	['fg_0'] = '#3d3d3d',
	['fg_1'] = '#2a2a2a',
	['red'] = '#d11100',
	['green'] = '#309900',
	['yellow'] = '#c79800',
	['blue'] = '#0063db',
	['magenta'] = '#d4008d',
	['cyan'] = '#00b8a5',
	['bred'] = '#b80f00',
	['bgreen'] = '#218f00',
	['byellow'] = '#b38900',
	['bblue'] = '#0059d2',
	['bmagenta'] = '#b8007a',
	['bcyan'] = '#009485',
	['gold'] = '#846d21',
	['specials'] = '#fed200',
	['orange'] = '#db6600'
}

lexers.colors = colors

lexers.STYLE_DEFAULT = 'fore:' .. colors.fg_1 .. ',back:' .. colors.bg_0
lexers.STYLE_NOTHING = 'back:' .. colors.bg_0
lexers.STYLE_CLASS = 'bold'
lexers.STYLE_COMMENT = 'fore:' .. colors.green
lexers.STYLE_CONSTANT = 'bold'
lexers.STYLE_DEFINITION = 'fore:' .. colors.orange
lexers.STYLE_ERROR = 'fore:' .. colors.red .. ',italics'
lexers.STYLE_FUNCTION = 'bold'
lexers.STYLE_KEYWORD = 'bold'
lexers.STYLE_LABEL = 'fore:' .. colors.green
lexers.STYLE_NUMBER = 'fore:' .. colors.md_0
lexers.STYLE_OPERATOR = 'fore:' .. colors.fg_1
lexers.STYLE_REGEX = 'fore:green'
lexers.STYLE_STRING = 'fore:' .. colors.blue
lexers.STYLE_PREPROCESSOR = 'fore:' .. colors.orange
lexers.STYLE_TAG = 'fore:' .. colors.fg_0
lexers.STYLE_TYPE = 'fore:' .. colors.yellow
lexers.STYLE_VARIABLE = 'fore:' .. colors.blue
lexers.STYLE_WHITESPACE = ''
lexers.STYLE_EMBEDDED = 'back:' .. colors.bg_1 .. ',fore:' .. colors.gold
lexers.STYLE_IDENTIFIER = 'fore:' .. colors.fg_1

lexers.STYLE_LINENUMBER = 'back:' ..colors.bg_2.. ',fore:' .. colors.md_1
lexers.STYLE_LINENUMBER_CURSOR = 'fore:' .. colors.gold .. ',back:' .. colors.bg_1
lexers.STYLE_CURSOR = 'fore:' .. colors.bg_0 .. ',back:' .. colors.orange
lexers.STYLE_CURSOR_PRIMARY = 'fore:' .. colors.bg_0 .. ',back:' .. colors.orange
lexers.STYLE_CURSOR_LINE = 'back:' .. colors.bg_1
lexers.STYLE_COLOR_COLUMN = 'back:' .. colors.bg_1 .. ',fore:' .. colors.red
lexers.STYLE_SELECTION = 'back:' .. colors.specials
lexers.STYLE_STATUS = 'back:' .. colors.bg_2 .. ',fore:' .. colors.md_0
lexers.STYLE_STATUS_FOCUSED = 'back:' .. colors.bg_2 .. ',fore:' .. colors.bmagenta
lexers.STYLE_SEPARATOR = lexers.STYLE_DEFAULT
lexers.STYLE_INFO = 'fore:default,back:default,bold'
