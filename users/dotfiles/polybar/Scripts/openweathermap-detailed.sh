#!/bin/sh

get_icon() {
  case $1 in
  01d) icon="" ;;
  01n) icon="" ;;
  02d) icon="" ;;
  02n) icon="" ;;
  03*) icon="" ;;
  04*) icon="" ;;
  09d) icon="" ;;
  09n) icon="" ;;
  10d) icon="" ;;
  10n) icon="" ;;
  11d) icon="" ;;
  11n) icon="" ;;
  13d) icon="" ;;
  13n) icon="" ;;
  50d) icon="" ;;
  50n) icon="" ;;
  *) icon="" ;;
  esac

  echo $icon
}

KEY="9858555ad93adea82e15f3b37ec335e3"
CITY="5379524"
UNITS="Metric"
SYMBOL="°C"

if [ ! -z $CITY ]; then
  weather=$(curl -sf "http://api.openweathermap.org/data/2.5/weather?id=$CITY&appid=$KEY&units=$UNITS")
  # weather=$(curl -sf "http://api.openweathermap.org/data/2.5/forecast?APPID=$KEY&id=$CITY&units=$UNITS&cnt=1")
else
  location=$(curl -sf https://location.services.mozilla.com/v1/geolocate?key=geoclue)

  if [ ! -z "$location" ]; then
    location_lat="$(echo "$location" | jq '.location.lat')"
    location_lon="$(echo "$location" | jq '.location.lng')"
    weather=$(curl -sf "http://api.openweathermap.org/data/2.5/weather?appid=$KEY&lat=$location_lat&lon=$location_lon&units=$UNITS")
  fi
fi

if [ ! -z "$weather" ]; then
  weather_desc=$(echo "$weather" | jq -r ".weather[0].description")
  weather_temp=$(echo "$weather" | jq ".main.temp" | cut -d "." -f 1)
  weather_icon=$(echo "$weather" | jq -r ".weather[0].icon")
  weather_city=$(echo "$weather" | jq -r ".name")
  ######################  Translate section  ##################################
  ############################################################################

  # https://github.com/jaagr/polybar/wiki/Fonts
  #; Using raw formatting tags, you can mix fonts.
  #; %{T3} tells the bar to use Noto Sans and %{T-} resets it to default.
  #label-inactive = %{T3}Inactive%{T-} %time%

  echo "$weather_desc", "$weather_temp$SYMBOL" "%{T4}%{F#00BFFF}$(get_icon "$weather_icon")%{F-}%{T-}" "$weather_city"
fi
