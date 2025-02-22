#!/bin/bash

# Run net speed test
netspeed() {
  speedtest-cli
}

# Get public IP
myip() {
  curl -s checkip.amazonaws.com
}

# Get weather forecast
getweather() {
  curl -s wttr.in/"$1"
}

# fzfopen - Search files and open in nvim (or specified app)
# @arg $1 application name (default: nvim)
# Ex: fopen nvim
fzfopen() {
  local file app="${1:-nvim}"

  # Find files while ignoring unwanted directories
  file=$(find . -type f \( \
    ! -path "*/.git/*" \
    ! -path "*/node_modules/*" \
    ! -path "*/venv/*" \
    ! -path "*/__pycache__/*" \
    ! -path "*/.cache/*" \
    ! -path "*/.DS_Store/*" \
    ! -path "*/target/*" \
    ! -path "*/build/*" \
    ! -path "*/dist/*" \
    \) 2>/dev/null | fzf --preview 'bat --color=always --style=plain --paging=never {}' --height=80% --border --reverse)

  # If a file was selected, open it in the specified application
  if [[ -n "$file" ]]; then
    "$app" "$file"
  fi
}

# cdf - cd into the directory
# @arg $1 application name
# Ex: cdf nvim
fzfcd() {
  local dir app="${1:-}"

  # Define directories to ignore
  dir=$(find . -type d \( \
    ! -path "*/.git*" \
    ! -path "*/node_modules*" \
    ! -path "*/venv*" \
    ! -path "*/__pycache__*" \
    ! -path "*/.cache*" \
    ! -path "*/.DS_Store*" \
    ! -path "*/target*" \
    ! -path "*/build*" \
    ! -path "*/dist*" \
    \) 2>/dev/null | fzf --preview 'ls -lh {}' --height=80% --border --reverse)

  # If a directory was selected
  if [[ -n "$dir" ]]; then
    if [[ -n "$app" ]]; then
      "$app" "$dir"
    else
      cd "$dir" || echo "Failed to cd into $dir"
    fi
  fi
}

# Start Tmux
start_tmux() {
  # Check if tmux is running, and start it if not
  if ! pgrep tmux >/dev/null; then
    tmux start-server
  fi
}
