#!/usr/bin/env bash
# Usage: bash update.sh languages.txt SeekerTestBot/6f87957bdeecb59238ffd770e3d36431
curl -o $1 -L https://gist.github.com/$2/raw
brew ruby $GITHUB_WORKSPACE/print-formulae.rb $1 > $HOME/.brew_livecheck_watchlist
if [ $? -eq 0 ]; then
  brew livecheck --newer-only --quiet > $1 || true
  cat $1
  echo >> $1
fi
exit 0
