#!/usr/bin/env sh

configspath="${MY_DOTFILES:-$HOME/dotfiles}"

oldpwd="$PWD"
cd "$configspath" || exit

for file in $(find . -type f -not -path './.git/*' | sed '/.\/update.sh/d' | sed '/.\/.gitignore/d'); do
  homef="$HOME"/"$file"
  cfgf="$configspath"/"$file"
  if [ ! -f "$homef" ]; then
    dirname "$(realpath "$homef")"
    mkdir -p "$(dirname "$(realpath "$homef")")"
    cp "$cfgf" "$homef"
  else
    patchf="$configspath"/"$file.patch"
    diff "$homef" "$cfgf" > "$patchf"
    patch "$homef" "$cfgf"
    cat "$patchf"
    rm "$patchf"
  fi
done

if [ ! -f /etc/local.d/update.start ]; then
  echo "The script will install itself to /etc/local.d/ so that it gets run at boot."
  sudo cp "$configspath/update.sh" /etc/local.d/update.start
  sudo chmod +x /etc/local.d/update.start
else
  diff "$configspath/update.sh" /etc/local.d/update.start > "$configspath/update.sh.patch"
  if cat "$configspath/update.sh.patch" | read -r _USELESSREPLY; then
    echo "The script will patch the file /etc/local.d/update.start"
    sudo patch /etc/local.d/update.start "$configspath/update.sh.patch"
  fi
fi

cd "$oldpwd" || exit

