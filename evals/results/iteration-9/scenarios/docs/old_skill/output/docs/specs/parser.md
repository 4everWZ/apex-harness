# Parser API Specification

Status: approved

The parser adds `tokenizeQuoted(input)` to `src/tokenize.js`. It returns tokens
split on commas except commas inside double quotes. Quotes are removed. Empty
unquoted tokens are discarded. Acceptance requires focused unit tests for plain,
quoted-comma, empty, and unmatched-quote inputs. Unmatched quotes throw
`SyntaxError`. No other public API changes.
