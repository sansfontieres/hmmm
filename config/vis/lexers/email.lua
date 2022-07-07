local l = require('lexer')
local token, word_match = l.token, l.word_match

local P, R, S = lpeg.P, lpeg.R, lpeg.S

local M = {_NAME = 'email'}

-- Whitespace.
local ws = token(l.WHITESPACE, l.space^1)

-- Headers
local keywords = l.starts_line(word_match({
  'To',
  'From',
  'Bcc',
  'Cc',
  'Reply-To',
  'In-Reply-To',
  'Subject',
  'User-Agent',
  'Newsgroups',
  'Path',
  'Xref',
  'Message-Id',
  'Return-Path',
  'Received',
  'References',
  'Date',
  'Replied',
  'Sender',
  'Content-Type',
  'Content-Transfer-Encoding',
}, '-', true))
local keyword = token(l.KEYWORD, keywords)

-- Quote.
local quote = token(l.COMMENT, l.starts_line('>') * l.nonnewline^0)

M._rules = {
  {'whitespace', ws},
  {'keyword', keyword},
  {'quote', quote},
}

M._LEXBYLINE = true

return M
