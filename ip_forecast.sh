#!/bin/bash

IPAddress=$1

if [ -z "$1" ]
then
  IPAddress=$(dig +short myip.opendns.com @resolver1.opendns.com)
fi

geoloc=$(curl -X GET -s http://ipinfo.io/$IPAddress | jq -r '.loc')
city=$(curl -X GET -s http://ipinfo.io/$IPAddress | jq -r '.city')
weatherdata=$(curl -X GET -s https://api.darksky.net/forecast/6ce2cb95ebf7afee7f2d76afcc037fb3/$geoloc)

rm -rf weatherdata.json
echo $weatherdata >> weatherdata.json
echo "Weather forecast for $geoloc ($city) :"

for day in 1 2 3
do
    summary=$(jq -r '.daily.data  | .['$day'].summary' weatherdata.json)
    epochdate=$(jq -r '.daily.data  | .['$day'].time' weatherdata.json)
    humandate=$(date -d @$epochdate +'%Y-%m-%d')
    echo  $humandate":" $summary
done