function fish_prompt
  set -l color_normal (set_color $fish_color_normal)
  set -l color_user (set_color $fish_color_user)
  set -l color_host (set_color $fish_color_host)
  set -l color_pwd (set_color $fish_color_cwd)
  set -l color_ruby (set_color red)
  set -l color_python (set_color yellow)
  set -l prompt_suffix '$'

  if test (id -u) -eq 0
    set -q fish_color_user_root && set color_user (set_color $fish_color_user_root)
    set -q fish_color_cwd_root && set color_pwd (set_color $fish_color_cwd_root)
    set prompt_suffix '#'
  end
  if set -q SSH_TTY
    set -q fish_color_host_remote && set color_host (set_color $fish_color_host_remote)
  end

  echo -s -n $color_normal '╭─' $color_user $USER
  echo -s -n $color_normal $color_host '@' (prompt_hostname)
  echo -s -n $color_normal ' ' $color_pwd (prompt_pwd)

  set -l python_version (__fish_prompt_python_version)
  set -l ruby_version (__fish_prompt_ruby_version)
  if test -n "$python_version" && test 'system' != "$python_version"
    echo -s -n $color_normal ' ' $color_python ‹ $python_version ›
  end
  if test -n "$ruby_version" && test 'system' != "$ruby_version"
    echo -s -n $color_normal ' ' $color_ruby ‹ $ruby_version ›
  end

  set -l vcs_text (fish_vcs_prompt)
  test -n "$vcs_text" && echo -s -n $color_normal $vcs_text

  echo $color_normal

  echo -s -n $color_normal '╰' (__fish_prompt_mode)
  echo -s -n $color_normal (set_color --bold) $prompt_suffix $color_normal ' '
end

function fish_right_prompt
  set -l last_pipestatus $pipestatus
  __fish_print_pipestatus '⤷ ' '' '|' (set_color $fish_color_error) (set_color $fish_color_status) $last_pipestatus
end

function fish_mode_prompt
end

function __fish_prompt_mode
  if not contains -- "$fish_key_bindings" 'fish_vi_key_bindings' 'fish_hybrid_key_bindings'
    return
  end

  echo -n '┤'

  switch $fish_bind_mode
    case default
      set_color --bold --background red white
      echo -n 'N'
    case insert
      set_color green
      echo -n 'I'
    case replace_one
      set_color --bold --background green white
      echo -n 'R'
    case replace
      set_color --bold --background cyan white
      echo -n 'R'
    case visual
      set_color --bold --background magenta white
      echo -n 'V'
    case '*'
      set_color --bold --background $fish_color_error white
      echo -n '?'
  end

  set_color $fish_color_normal
  echo -n '├'
end

function __fish_prompt_ruby_version
  if type -q rbenv
    rbenv version-name
  else if type -q rvm-prompt
    rvm-prompt s i v p g
  end
end

function __fish_prompt_python_version
  if type -q pyenv
    pyenv version-name
  else if set -q VIRTUAL_ENV
    basename $VIRTUAL_ENV
  end
end
