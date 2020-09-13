#!/usr/bin/env bash
# Usage: bash update.sh languages.txt https://gist.github.com/SeekerTestBot/6f87957bdeecb59238ffd770e3d36431/raw
curl -o $1 -L $2
brew ruby print-formulae.rb $1 > $HOME/.brew_livecheck_watchlist
if [ $? -eq 0 ]; then
  if [ ! -z "$3" ]; then
    brew tap $3
  fi
  brew livecheck --newer-only --quiet > $1 || true
fi
cat $1
echo >> $1
exit 0
