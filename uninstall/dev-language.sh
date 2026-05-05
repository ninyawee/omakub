#!/bin/bash

# Uninstall default programming languages
if [[ -v OMAKUB_FIRST_RUN_LANGUAGES ]]; then
  languages=$OMAKUB_FIRST_RUN_LANGUAGES
else
  AVAILABLE_LANGUAGES=("Ruby on Rails" "Node.js" "Go" "PHP" "Python" "Elixir" "Rust" "Java")
  languages=$(gum choose "${AVAILABLE_LANGUAGES[@]}" --no-limit --height 10 --header "Select programming languages to uninstall")
fi

if [[ -n "$languages" ]]; then
  mapfile -t selected_languages <<< "$languages"
  for language in "${selected_languages[@]}"; do
    case $language in
    "Ruby on Rails")
      echo -e "Removing Ruby on Rails...\n"
      mise uninstall ruby --all
      mise rm -g ruby
      rm -f ~/.gemrc
      ;;
    "Node.js")
      echo -e "Removing Node.js...\n"
      mise uninstall node --all
      mise rm -g node
      ;;
    "Go")
      echo -e "Removing Go...\n"
      mise uninstall go --all
      mise rm -g go
      ;;
    "PHP")
      echo -e "Removing PHP...\n"
      mapfile -t php_packages < <(dpkg-query -W -f='${binary:Package}\n' 'php-*' 2>/dev/null || true)
      if ((${#php_packages[@]})); then
        sudo apt-get remove -y php "${php_packages[@]}" composer
      else
        sudo apt-get remove -y php composer
      fi
      sudo apt-get autoremove -y
      sudo rm -f /usr/local/bin/composer
      ;;
    "Python")
      echo -e "Removing Python...\n"
      mise uninstall python --all
      mise rm -g python
      rm -rf ~/.local/bin/uv ~/.local/bin/uvx ~/.cargo/bin/uv 2>/dev/null || true
      ;;
    "Elixir")
      echo -e "Removing Elixir...\n"
      mise uninstall elixir --all
      mise uninstall erlang --all
      mise rm -g elixir
      mise rm -g erlang
      ;;
    "Rust")
      echo -e "Removing Rust...\n"
      rustup self uninstall -y 2>/dev/null || true
      ;;
    "Java")
      echo -e "Removing Java...\n"
      mise uninstall java --all
      mise rm -g java
      ;;
    esac
  done
fi
