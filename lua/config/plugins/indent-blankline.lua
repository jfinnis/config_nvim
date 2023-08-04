--
-- indent-blankline settings
--

require('indent_blankline').setup {
    char = '│',
    context_char = '│',
    use_treesitter = true,
    use_treesitter_scope = false,
    max_indent_increase = 1,
    show_first_indent_level = true,
    show_current_context = true,
    show_current_context_start = true,
    show_end_of_line = true,
    context_patterns = {
        -- defaults
        'class', '^func', 'method', '^if', 'while', 'for', 'with', 'try', 'except', 'arguments', 'argument_list',
        'object', 'dictionary', 'element', 'table', 'tuple', 'do_block', 'Block', 'InitList', 'FnCallArguments',
        'IfStatement', 'ContainerDecl', 'SwitchExpr', 'IfExpr', 'ParamDeclList',
        -- extensions
        'export_statement', 'lexical_declaration', 'variable_declaration', 'identifier', 'arrow_function'
    }
}
