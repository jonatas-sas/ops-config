<?php

use PhpCsFixer\Config;
use PhpCsFixer\Finder;

// Rules {{{

$rules = [];

// Spaces & Indentations {{{

$rules['statement_indentation']  = true;
$rules['indentation_type']       = true;
$rules['array_indentation']      = true;
$rules['binary_operator_spaces'] = [
    'default'   => 'single_space',
    'operators' => [
        '='  => 'align_single_space_minimal',
        '=>' => 'align_single_space_minimal',
    ],
];

// }}}

// Braces & Control Structures {{{

$rules['control_structure_braces']                = true;
$rules['control_structure_continuation_position'] = [
    'position' => 'same_line',
];

$rules['braces_position'] = [
    'allow_single_line_anonymous_functions'     => true,
    'allow_single_line_empty_anonymous_classes' => true,
    'anonymous_classes_opening_brace'           => 'same_line',
    'anonymous_functions_opening_brace'         => 'same_line',
    'classes_opening_brace'                     => 'next_line_unless_newline_at_signature_end',
    'control_structures_opening_brace'          => 'same_line',
    'functions_opening_brace'                   => 'next_line_unless_newline_at_signature_end',
];

$rules['elseif']                          = true;
$rules['no_unneeded_control_parentheses'] = [
    'statements' => ['break', 'clone', 'continue', 'echo_print', 'return', 'switch_case', 'yield'],
];
$rules['switch_case_semicolon_to_colon'] = true;
$rules['switch_case_space']              = true;

// }}}

// Blank Lines Management {{{

$rules['blank_line_after_opening_tag'] = true;
$rules['blank_line_after_namespace']   = true;
$rules['blank_line_before_statement']  = [
    'statements' => ['return'],
];
$rules['no_extra_blank_lines'] = [
    'tokens' => ['extra', 'throw', 'use'],
];
$rules['no_blank_lines_after_class_opening'] = true;
$rules['no_blank_lines_after_phpdoc']        = true;

// }}}

// Array Syntax & Formatting {{{

$rules['array_syntax']                = ['syntax' => 'short'];
$rules['trailing_comma_in_multiline'] = ['elements' => ['arrays']];
// ⚠️ Remover regras deprecadas:
// 'no_trailing_comma_in_list_call'
// 'no_trailing_comma_in_singleline_array'
$rules['trim_array_spaces']               = true;
$rules['whitespace_after_comma_in_array'] = true;
$rules['whitespace_after_comma_in_array'] = true;

// }}}

// Spaces & Operators Formatting {{{

$rules['cast_spaces']                                = ['space' => 'none'];
$rules['concat_space']                               = ['spacing' => 'one'];
$rules['increment_style']                            = ['style' => 'post'];
$rules['method_argument_space']                      = ['on_multiline' => 'ignore'];
$rules['multiline_whitespace_before_semicolons']     = ['strategy' => 'no_multi_line'];
$rules['no_spaces_after_function_name']              = true;
$rules['no_spaces_around_offset']                    = ['positions' => ['inside', 'outside']];
$rules['spaces_inside_parentheses']                  = ['space' => 'none'];
$rules['no_singleline_whitespace_before_semicolons'] = true;
$rules['object_operator_without_whitespace']         = true;
$rules['space_after_semicolon']                      = true;
$rules['standardize_not_equals']                     = true;
$rules['ternary_operator_spaces']                    = true;
$rules['unary_operator_spaces']                      = true;

// }}}

$rules['constant_case']              = ['case' => 'lower'];
$rules['lowercase_cast']             = true;
$rules['lowercase_keywords']         = true;
$rules['lowercase_static_reference'] = true;
$rules['magic_method_casing']        = true;
$rules['magic_constant_casing']      = true;
$rules['native_function_casing']     = true;

// PHPDoc Management & Formatting {{{

$rules['phpdoc_indent']                  = true;
$rules['phpdoc_inline_tag_normalizer']   = true;
$rules['phpdoc_no_access']               = true;
$rules['phpdoc_no_package']              = true;
$rules['phpdoc_no_useless_inheritdoc']   = true;
$rules['phpdoc_scalar']                  = true;
$rules['phpdoc_single_line_var_spacing'] = true;
$rules['phpdoc_summary']                 = false;
$rules['phpdoc_to_comment']              = false;
$rules['phpdoc_var_without_name']        = true;

// }}}

// Import & Namespaces Formatting {{{

$rules['ordered_imports']                 = ['sort_algorithm' => 'alpha'];
$rules['no_leading_import_slash']         = true;
$rules['no_leading_namespace_whitespace'] = true;
$rules['psr_autoloading']                 = true;
$rules['no_whitespace_in_blank_line']     = true;

// }}}

// General Formatting & Best Practices {{{

$rules['declare_equal_normalize']      = true;
$rules['encoding']                     = true;
$rules['full_opening_tag']             = true;
$rules['fully_qualified_strict_types'] = true;
$rules['function_declaration']         = true;
$rules['type_declaration_spaces']      = true;
$rules['no_closing_tag']               = true;
$rules['single_blank_line_at_eof']     = true;
$rules['no_trailing_whitespace']       = true;

// }}}

// }}}

$finder = Finder::create()
    ->in(getcwd())
    ->exclude(['vendor', 'node_modules', 'storage'])
    ->name('*.php')
    ->ignoreDotFiles(true)
    ->ignoreVCS(true);

return (new Config())
    ->setRiskyAllowed(true)
    ->setIndent('    ')
    ->setLineEnding("\n")
    ->setRules($rules)
    ->setFinder($finder);
