<?php

$rules = [
    'array_syntax'           => ['syntax' => 'short'],
    'binary_operator_spaces' => [
        'default' => 'align_single_space_minimal',
    ],
    'trailing_comma_in_multiline'            => ['elements' => ['arrays']],
    'trim_array_spaces'                      => true,
    'whitespace_after_comma_in_array'        => true,
    'no_closing_tag'                         => true,
    'no_trailing_whitespace'                 => true,
    'full_opening_tag'                       => true,
    'phpdoc_to_comment'                      => false,
    'phpdoc_summary'                         => false,
    'no_blank_lines_after_phpdoc'            => false,
    'single_blank_line_at_eof'               => true,
    'cast_spaces'                            => ['space' => 'none'],
    'unary_operator_spaces'                  => true,
    'concat_space'                           => ['spacing' => 'one'],
    'function_declaration'                   => true,
    'method_argument_space'                  => ['on_multiline' => 'ignore'],
    'multiline_whitespace_before_semicolons' => ['strategy' => 'no_multi_line'],
    'spaces_inside_parentheses'              => ['space' => 'none'],
];

$finder = PhpCsFixer\Finder::create()
    ->in(getcwd())
    ->name('*.php')
    ->ignoreDotFiles(true)
    ->ignoreVCS(true);

return (new PhpCsFixer\Config())
    ->setRules($rules)
    ->setFinder($finder);
