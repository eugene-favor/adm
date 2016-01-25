#!/bin/sh
echo "enter new nick"

read nick

old=`grep key.*key client.ovpn |sed -e "s/key //"|sed -e "s/\.key//"|tr -d "[:space:]"`

echo old:_${old}_

echo new:_${nick}_

cat client.ovpn |sed -e "s/$old/$nick/" > tmp && mv tmp client.ovpn

zip ${nick}.zip README.txt ca.crt ${nick}.crt ${nick}.key client.ovpn