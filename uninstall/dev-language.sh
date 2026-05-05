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
      mise uninstall -g ruby@latest
      mise settings remove idiomatic_version_file_enable_tools ruby
      mise x ruby -- gem uninstall rails --all --ignore-dependencies --no-document

      ;;
    "Node.js")
      echo -e "Removing Node.js...\n"
      mise uninstall -g node@lts
      ;;
    "Go")
      echo -e "Removing Go...\n"
      mise uninstall -g go@latest
      ;;
    "PHP")
      echo -e "Removing PHP...\n"
      sudo apt-get remove -y php php-* composer
      sudo apt-get autoremove -y
      sudo rm -f /usr/local/bin/composer
      ;;
    "Python")
      echo -e "Removing Python...\n"
      mise uninstall -g python@latest
      ;;
    "Elixir")
      echo -e "Removing Elixir...\n"
      mise uninstall -g elixir@latest
      mise uninstall -g erlang@latest
      ;;
    "Rust")
      echo -e "Removing Rust...\n"
      rustup self uninstall -y
      ;;
    "Java")
      echo -e "Removing Java...\n"
      mise uninstall -g java@latest
      ;;
    esac
  done
fi
