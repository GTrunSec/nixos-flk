#!/usr/bin/env bash

## Author  : Aditya Shakya
## Mail    : adi1090x@gmail.com
## Github  : @adi1090x
## Twitter : @adi1090x

# Available Styles
# >> Created and tested on : rofi 1.6.0-1
#
# blurry	blurry_full		kde_simplemenu		kde_krunner		launchpad
# gnome_do	slingshot		appdrawer			appdrawer_alt	appfolder
# column	row				row_center			screen			row_dock		row_dropdown

theme="screen"
dir="$HOME/.config/rofi/themes"

case "$1" in
"drun")
  shift 1
  rofi -no-lazy-grab -show drun -modi drun -theme $dir/"blurry.rasi"
  ;;
"window")
  shift 1
  rofi -no-lazy-grab -show window -modi window -theme $dir/"blurry.rasi"
  ;;
"run")
  shift 1
  rofi -no-lazy-grab -show run -modi run -theme $dir/"blurry.rasi"
  ;;
esac
