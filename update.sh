#!/usr/bin/env bash
# Usage: bash $GITHUB_WORKSPACE/update.sh languages.txt https://gist.github.com/SeekerTestBot/6f87957bdeecb59238ffd770e3d36431/raw
curl -o $1 -L $2
brew ruby $GITHUB_WORKSPACE/print-formulae.rb $1 > $HOME/.brew_livecheck_watchlist
if [ $? -eq 0 ]; then
  brew livecheck --newer-only --quiet > $1 || true
  cat $1
  echo >> $1
fi
exit 0
