<?php

$rules = [
    'indentation_type'       => true,
    'array_indentation'      => true,
    'binary_operator_spaces' => [
        'default' => 'single_space',
    ],
    'no_trailing_whitespace' => true,
    'no_closing_tag'         => true,
    'no_extra_blank_lines'   => false,
    'phpdoc_to_comment'      => false,
    'phpdoc_summary'         => false,
];

$finder = PhpCsFixer\Finder::create()
    ->in(getcwd())
    ->name('*.php')
    ->ignoreDotFiles(true)
    ->ignoreVCS(true);

return (new PhpCsFixer\Config())
    ->setRules($rules)
    ->setFinder($finder);
