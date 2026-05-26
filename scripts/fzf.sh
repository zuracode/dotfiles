#!/bin/bash

# extended fzf for blocking kitty window navigation for fzf up, down navigation(in fzf terms actions)
function fzf {
  kitten @ set-user-vars KITTY_APPLICABLE_ACTION_FROM_INNER_PROGRAM=0; command fzf "$@"; kitten @ set-user-vars KITTY_APPLICABLE_ACTION_FROM_INNER_PROGRAM=1
}

export fzf
