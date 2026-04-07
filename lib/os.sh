#!/usr/bin/env bash

if [[ -t 1 && -z ${NO_COLOR:-} ]]; then
  c_reset=$'\033[0m'
  c_red=$'\033[1;31m'
  c_yellow=$'\033[1;33m'
else
  c_reset=''
  c_red=''
  c_yellow=''
fi

fail() { printf '%b[os]%b %s\n' "$c_red" "$c_reset" "$*" >&2; }
warn() { printf '%b[os]%b %s\n' "$c_yellow" "$c_reset" "$*"; }

is_darwin() {
  uname -a | grep Darwin >/dev/null
}

if [ -z "${os}" ]; then
  # Find the current distribution
  if [ -f /etc/os-release ]; then
    if grep -q arch /etc/os-release; then
      os="arch-linux"
    elif grep -qi "ubuntu\|debian\|pop.os\|linuxmint\|elementary" /etc/os-release; then
      os="debian"
    elif grep -q void /etc/os-release; then
      os="void-linux"
    elif grep -q alpine /etc/os-release; then
      os="alpine"
    elif grep -qi "fedora\|rhel\|centos\|rocky\|alma" /etc/os-release; then
      os="fedora"
    elif grep -qi "opensuse\|sles" /etc/os-release; then
      os="opensuse"
    else
      warn "unrecognized distribution in /etc/os-release — proceeding with limited support"
      os="unknown-linux"
    fi
  else
    if is_darwin; then
      os="darwin"
    else
      warn "cannot detect platform via /etc/os-release or uname — proceeding best-effort"
      os="unknown"
    fi
  fi
fi

# List of supported operating systems
# Note: the chezmoi install scripts use inline package-manager detection (pacman/apt-get/brew)
# and are not gated by this list. This library is used by standalone scripts in scripts/.
supported_os_list=(arch-linux debian void-linux alpine fedora darwin)

if [[ " ${supported_os_list[*]} " != *"${os}"* ]]; then
  warn "${os} is not in the supported OS list — some features may not work correctly"
  warn "Supported: ${supported_os_list[*]}"
  # Do not exit — allow callers to proceed and handle unsupported OS gracefully
fi
