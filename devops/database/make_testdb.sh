#!/bin/bash

DATE=`date +%Y-%m-%d`

# landmarks in NYC
mongodump -d if -c landmarks -u ifappuser -p $MP --query '{loc:{$near:{$geometry:{type:"Point",coordinates:[-73.9878042,40.7479261]},$maxDistance:20000}},"loc.coordinates.0":{$ne:-74.0059}}' -o dump_$DATE

# users
mongodump -d if -c users -u ifappuser -p $MP --query '{"local.email":/interfacefoundry/}' -o dump_$DATE

# everything else
mongodump -u ifappuser -p $MP -d if -c announcements -o dump_$DATE
mongodump -u ifappuser -p $MP -d if -c contestentries -o dump_$DATE
mongodump -u ifappuser -p $MP -d if -c contests -o dump_$DATE
#mongodump -u ifappuser -p $MP -d if -c instagrams -o dump_$DATE
mongodump -u ifappuser -p $MP -d if -c stickers -o dump_$DATE
mongodump -u ifappuser -p $MP -d if -c styles -o dump_$DATE
#mongodump -u ifappuser -p $MP -d if -c tweets -o dump_$DATE
mongodump -u ifappuser -p $MP -d if -c visits -o dump_$DATE
mongodump -u ifappuser -p $MP -d if -c worldchats -o dump_$DATE

# targz dat shit
tar czvf dump_$DATE.tar.gz

