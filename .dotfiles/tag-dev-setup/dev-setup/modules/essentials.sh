#!/bin/bash

readonly SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Run the core.sh Script
# For a full listing of installed formulae and apps, refer to
# the commented core.sh source file directly and tweak it to
# suit your needs.

echo "------------------------------"
echo "Installing essential homebrew formulae and apps."
echo "This might awhile to complete, as some formulae need to be installed from source."
echo "------------------------------"
echo ""

brew bundle install --file="${SCRIPT_DIR}/../brewfiles/essentials"

# GNU core utilities (those that come with OS X are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
ln -s /usr/local/bin/gsha256sum /usr/local/bin/sha256sum

# We installed the new shell, now we have to activate it
echo "Adding the newly installed shell to the list of allowed shells"
# Prompts for password
sudo bash -c 'echo /usr/local/bin/bash >> /etc/shells'
# Change to the new shell, prompts for password
chsh -s /usr/local/bin/bash

LINE='eval "$(rbenv init -)"'
grep -q "$LINE" ~/.extra || echo "$LINE" >> ~/.extra

# Lxml and Libxslt
brew link libxml2 --force
brew link libxslt --force

# Heroku
heroku update
