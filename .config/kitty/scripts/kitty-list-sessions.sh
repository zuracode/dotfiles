#!/usr/bin/env bash

set -euo pipefail

kitty_bin="/Applications/kitty.app/Contents/MacOS/kitty"

# Requirements
if ! command -v fzf >/dev/null 2>&1; then
  echo "fzf is not installed or not in PATH."
  echo "install fzf"
  exit 1
fi

if ! command -v jq >/dev/null 2>&1; then
  echo "jq is not installed or not in PATH."
  echo "install jq"
  exit 1
fi

# checks kitty existens
if [[ ! -x "$kitty_bin" ]]; then
  echo "kitty binary not found at: $kitty_bin"
  exit 1
fi

# checks if kitty running
sock="$(find /tmp/mykitty-* 2>/dev/null | head -n1)"
if [[ -z "$sock" ]]; then
  echo "no kitty sockets found in /tmp (kitty not running or remote control not available)."
  exit 1
fi

sessions=$(ls "$HOME/.config/kitty/sessions")

active_sessions="$(
    "$kitty_bin" @ --to "unix:${sock}" ls 2>/dev/null | jq -r '
      [
        .[] as $os
        | $os.tabs[] as $tab
        | $tab.windows[]?
        | select(.session_name != null and .session_name != "")
          | {
              session_name: .session_name,
              os_focused: ($os.is_focused // false),
              tab_focused: ($tab.is_focused // false),
              last_focused_at: (.last_focused_at // 0)
            }
        ]
      # Sort sessions by recency using Kitty-provided window last_focused_at
      # See: https://github.com/kovidgoyal/kitty/issues/9799
      | sort_by(.session_name)
      | group_by(.session_name)
      | map({
          session_last_focused_at: (map(.last_focused_at) | max),
          pick: (
            if (map(.os_focused and .tab_focused) | any) then
              (map(select(.os_focused and .tab_focused)) | .[0])
            else
              .[0]
            end
          )
        })
      | map(.pick + {session_last_focused_at: .session_last_focused_at})
      # Most recent sessions first, then name for stable ordering
      | sort_by(-.session_last_focused_at, .session_name)
        | .[]
        | [(.session_name|tostring), (.os_focused|tostring), (.tab_focused|tostring)]
        | @tsv
        ')"

# get first part - "session name" (which is separated with dot - "." from "extension") of filename
sessions_with_name=$( echo "$sessions" | awk '{
  split($1, arr, ".")
  print arr[1], "false", "false" }'
)

# merge sessions with active sessions
merged_sessions=''

if [[ ${#active_sessions} -gt 0 ]]; then
  merged_sessions=$(echo -e "$active_sessions\n$sessions_with_name")
else
  merged_sessions=$(echo -e "$sessions_with_name")
fi

distinct_sessions=$(echo "$merged_sessions" | awk '!seen[$1]++' | awk '{
  os_focused=$2
  tab_focused=$3
  os_focused_text=""
  tab_focused_text=""

  if(os_focused == "true"){
    os_focused_text="active"
  }

  if(tab_focused == "true"){
    tab_focused_text="focused"
  }

  if(!length(os_focused_text)){
    printf "%s\n", $1
  } else {
    if(!length(tab_focused_text)){
      printf "%s%s%s\n", $1, " - ", os_focused_text
    } else {
      printf "%s%s%s%s%s\n", $1, " - ", os_focused_text, ", ", tab_focused_text
    }
  }
}')

fzf_out="$(echo "$distinct_sessions" | fzf --height=100% --reverse \
          --header="enter - open, esc - normal, d - close" \
          --prompt="list open kitty sessions > " \
          --expect=enter,ctrl-d,esc \
          --bind="ctrl-d:abort"
)"

fzf_out_lines=$(echo "$fzf_out" | wc -l)

sessions_path="$HOME/.config/kitty/sessions"
session_file_extention="kitty-session"

if [[ $fzf_out_lines -eq 2 ]];
then
  fzf_key=$(echo "$fzf_out" | sed -n '1p')
  selected_session_name=$(echo "$fzf_out" | sed -n '2p' | awk '{ print $1 }')

  if [[ $fzf_key == "ctrl-d" ]];
  then
    "$kitty_bin" @ --to "unix:${sock}" action close_session "$selected_session_name" >/dev/null 2>&1 || true
  elif [[ $fzf_key == 'enter' ]];
  then
    "$kitty_bin" @ --to "unix:${sock}" action goto_session "$sessions_path/$selected_session_name.$session_file_extention"
  fi
fi

exit 0
