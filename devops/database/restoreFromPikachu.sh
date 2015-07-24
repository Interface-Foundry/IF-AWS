#!/bin/bash
rm -rf dump
mongodump -h pikachu.kipapp.co -d foundry
mongorestore --drop dump
