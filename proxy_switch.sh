#!/bin/bash

echo "Choose from the following options:
1. Turn HTTP proxy on
2. Turn HTTP proxy off"

read input
echo "You chose option $input"

proxy='http://www-cache.reith.bbc.co.uk:80'

if [[ $input = '1' ]]
then
  echo 'Turning HTTP proxy ON...'
  for env_var in http_proxy HTTP_PROXY https_proxy HTTPS_PROXY
    do
      export $env_var=$proxy
    done 
  echo 'done'
elif [[ $input = '2' ]]
then
  echo 'Turning HTTP proxy OFF...'
  for env_var in http_proxy HTTP_PROXY https_proxy HTTPS_PROXY
    do
      unset $env_var
    done 
  echo 'done'
else
  echo 'Warning: invalid option'
fi

echo 'Proxy report:'
env | grep -i http | grep -vi 'maven'
echo
