<?php

$rules = [
    'full_opening_tag'                   => false,
    'no_closing_tag'                     => false,
    'blank_line_after_opening_tag'       => false,
    'phpdoc_to_comment'                  => false,
    'phpdoc_summary'                     => false,
    'no_extra_blank_lines'               => false,
    'no_blank_lines_after_phpdoc'        => false,
    'no_blank_lines_after_class_opening' => false,
];

$finder = PhpCsFixer\Finder::create()
    ->in(getcwd())
    ->name('*.php')
    ->ignoreDotFiles(true)
    ->ignoreVCS(true);

return (new PhpCsFixer\Config())
    ->setRules($rules)
    ->setFinder($finder);
