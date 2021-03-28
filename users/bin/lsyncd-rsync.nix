{}:
''
  killall -q lsyncd &
  PID=$!
  wait $PID
  # sync to webdev
  # lsyncd -rsync ~/Nextcloud/phone /var/lib/photoprism/import/phone-backup
  # lsyncd -rsync ~/Nextcloud/oneplus /var/lib/photoprism/import/oneplus-backup
  lsyncd -rsync ~/.config/fcitx5 ~/.config/nixpkgs/dotfiles/fcitx5
''
