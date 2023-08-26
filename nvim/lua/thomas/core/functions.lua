local fn = vim.fn -- for conciseness

-- highlight trailing whitespace as an error
fn.matchadd('ErrorMsg', [[\s\+$]])
