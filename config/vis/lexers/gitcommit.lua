-- © 2021 Romi Hervier <r@sansfontieres.com>
-- gitcommit LPeg lexer.

local l = require('lexer')
local token = l.token

local M = {_NAME = 'gitcommit'}

-- Whitespace.
local ws = token(l.WHITESPACE, l.space^1)

-- Comments.
local comment = token(l.COMMENT, l.starts_line('#') * l.nonnewline^0)

M._rules = {
  {'whitespace', ws},
  {'comment', comment},
}


return M
