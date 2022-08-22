#!/usr/bin/env sh

configspath="${MY_DOTFILES:-$HOME/dotfiles}"

oldpwd="$PWD"
cd "$configspath" || exit

for file in $(find . -type f -not -path './.git/*' | sed '/.\/update.sh/d' | sed '/.\/.gitignore/d'); do
  homef="$HOME"/"$file"
  cfgf="$configspath"/"$file"
  if [ ! -f "$homef" ]; then
    mkdir -p "$(dirname "$homef")"
    cp "$cfgf" "$homef"
  else
    diff -u "$homef" "$cfgf" | patch -p0 -d/
  fi
done

if [ ! -f /etc/local.d/update.start ]; then
  echo "The script will install itself to /etc/local.d/ so that it gets run at boot."
  sudo cp "$configspath/update.sh" /etc/local.d/update.start
  sudo chmod +x /etc/local.d/update.start
else
  diff -u /etc/local.d/update.start "$configspath/update.sh" > "$configspath/update.sh.patch"
  if cat "$configspath/update.sh.patch" | read -r _USELESSREPLY; then
    echo "The script will patch the file /etc/local.d/update.start"
    cat "$configspath/update.sh.patch" | sudo patch -p0 -d/
  fi
  rm update.sh.patch
fi

cd "$oldpwd" || exit

