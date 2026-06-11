#!/bin/bash
set -e
DIR="$(cd "$(dirname "$0")" && pwd)"; cd "$DIR"
PASSWORD="maraschinorules"
echo "Cifratura..."
rm -rf /tmp/lux-enc
npx --yes staticrypt index.src.html -p "$PASSWORD" --short --remember 30 \
  --template ./staticrypt-template.html \
  --template-title 'Casa Luxardo · Production Schedule' \
  --template-instructions 'Inserisci la password per accedere alla scaletta di produzione.' \
  --template-button 'Entra' --template-placeholder 'Password' \
  --template-error 'Password errata. Riprova.' \
  --template-remember 'Ricordami su questo dispositivo' \
  -d /tmp/lux-enc/ >/dev/null 2>&1
cp /tmp/lux-enc/index.src.html index.html
git add index.html
git commit -m "deploy $(date '+%Y-%m-%d %H:%M')" >/dev/null 2>&1 || true
git push --quiet
echo "Fatto → https://lazulipsd.github.io/casa-luxardo-crew-schedule/"
