#!/bin/bash

# Install default programming languages
if [[ -v OMAKUB_FIRST_RUN_LANGUAGES ]]; then
  languages=$OMAKUB_FIRST_RUN_LANGUAGES
else
  AVAILABLE_LANGUAGES=("Ruby on Rails" "Node.js" "Go" "PHP" "Python" "Elixir" "Rust" "Java")
  languages=$(gum choose "${AVAILABLE_LANGUAGES[@]}" --no-limit --height 10 --header "Select programming languages")
fi

install_php() {
  echo -e "Installing PHP...\n"
  sudo apt-get -y install php composer --no-install-recommends

  # Install commonly used PHP extensions if available
  local extensions_to_install=(
    curl
    apcu
    intl
    mbstring
    opcache
    pgsql
    mysql
    sqlite3
    redis
    xml
    zip
  )
  local available_extensions=()

  for extension in "${extensions_to_install[@]}"; do
    if apt-cache show "php-$extension" &>/dev/null; then
      available_extensions+=("php-$extension")
    fi
  done

  if [[ ${#available_extensions[@]} -gt 0 ]]; then
    sudo apt-get install -y --no-install-recommends "${available_extensions[@]}"
  fi
}

if [[ -n "$languages" ]]; then
  mapfile -t selected_languages <<< "$languages"
  for language in "${selected_languages[@]}"; do
    case $language in
    "Ruby on Rails")
      echo -e "Installing Ruby on Rails...\n"
      mise settings add ruby.compile false
      mise settings add idiomatic_version_file_enable_tools ruby
      mise use --global ruby@latest
      echo "gem: --no-document" >~/.gemrc
      mise x ruby -- gem install rails --no-document
      echo -e "\nYou can now run: rails new myproject"
      ;;
    "Node.js")
      echo -e "Installing Node.js...\n"
      mise use --global node
      ;;
    "Go")
      echo -e "Installing Go...\n"
      mise use --global go@latest
      ;;
    "PHP")
      install_php
      ;;
    "Python")
      echo -e "Installing Python...\n"
      mise use --global python@latest
      echo -e "\nInstalling uv...\n"
      mise use --global uv@latest
      ;;
    "Elixir")
      echo -e "Installing Elixir...\n"
      mise use --global erlang@latest
      mise use --global elixir@latest
      mise x elixir -- mix local.hex --force
      ;;
    "Rust")
      echo -e "Installing Rust...\n"
      bash -c "$(curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs)" -- -y
      ;;
    "Java")
      echo -e "Installing Java...\n"
      mise use --global java@latest
      ;;
    esac
  done
fi
