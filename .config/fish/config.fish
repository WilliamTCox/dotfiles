status --is-interactive; and rbenv init - | source
status --is-interactive; and pyenv init - | source
status --is-interactive; and pyenv virtualenv-init - | source

set -- fish_color_host --bold brgreen
set -- fish_color_host_remote --bold bryellow
set -- fish_color_cwd --bold brblue
set -- fish_color_cwd_root --bold brred
set -- fish_color_user --bold brgreen
set -- fish_color_user_root --bold brred

set __fish_git_prompt_show_informative_status 1
set __fish_git_prompt_showupstream 'informative'
set __fish_git_prompt_showcolorhints 1
