#!/bin/bash

# Outputs a JSON File containing the Stats
# Download the files
wget https://apps.foldingathome.org/daily_team_summary.txt.bz2
wget https://apps.foldingathome.org/daily_user_summary.txt.bz2


echo "{"

# Parse team File
#tar xjf daily_team_summary.txt.bz2 --to-command "awk '/bar/ { print ENVIRON[\"TAR_FILENAME\"]; exit }'"
bzcat daily_team_summary.txt.bz2 | awk \
	'NR==1 { printf "  \"date\" : \"%s\",\n",$0; } /^244868/{ printf "  \"team\" : %s,\n  \"teamname\" : \"%s\",\n  \"score\" : %s,\n  \"wu\" : %s,\n",$1,$2,$3,$4; }'

# Users for team
echo "  \"members\" : ["

bzcat daily_user_summary.txt.bz2 | awk \
	'/\t244868$/{ count++; if( count != 1) print ","; printf "    { \"name\" : \"%s\", \"score\" : %s, \"wu\": %s }",$1,$2,$3 }'

echo -e "\n  ]\n}"
