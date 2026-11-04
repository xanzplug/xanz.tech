#!/usr/bin/env bash
set -euo pipefail
ID="718601997225426998"
user=$(curl -fsS "https://api.lanyard.rest/v1/users/$ID" | jq -r '.data.discord_user')
hash=$(jq -r '.avatar // empty' <<<"$user")
[ -z "$hash" ] && { echo "no avatar"; exit 0; }
new="https://cdn.discordapp.com/avatars/$ID/$hash.png?size=256"
sed -E -i "s#https://cdn\.discordapp\.com/avatars/$ID/[A-Za-z0-9_]+\.(png|gif|webp)\?size=256#$new#g" index.html
echo "avatar: $new"
