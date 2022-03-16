let g:import_sort_settings = {}

let g:import_sort_settings['scala'] = {
\ 'import_prefix': 'import ',
\ 'import_groups': [
\   'java\(x\)\?\.',
\   'scala\.'
\  ]
\}


let g:import_sort_settings['haskell'] = {
\  'import_prefix': 'import \(qualified\)\? *',
\  'import_groups': [
\  ]
\}
