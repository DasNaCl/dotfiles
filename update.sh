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

for file in $(find .local/bin -type f -not -path './.git/*' | sed '/.\/update.sh/d' | sed '/.\/.gitignore/d'); do
  chmod +x "$HOME"/"$file"
done
chmod +x "$HOME"/.config/polybar/polybar_tray.sh

if [ ! -f "$HOME/.local/bin/update.start" ]; then
  echo "The script will install itself to $HOME/.local/bin/update.start so that it gets run at login. See your .zshrc"
  cp "$configspath/update.sh" "$HOME/.local/bin/update.start"
  chmod +x "$HOME/.local/bin/update.start"
else
  diff -u "$HOME/.local/bin/update.start" "$configspath/update.sh" > "$configspath/update.sh.patch"
  if cat "$configspath/update.sh.patch" | read -r _USELESSREPLY; then
    echo "The script will patch the file $HOME/.local/bin/update.start"
    cat "$configspath/update.sh.patch" | patch -p0 -d/
  fi
  rm "$configspath/update.sh.patch"
fi

cd "$oldpwd" || exit

