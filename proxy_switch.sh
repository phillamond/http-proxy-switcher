#!/bin/bash

echo "Choose from the following options:
1. Turn HTTP proxy on
2. Turn HTTP proxy off"

read input
echo "You chose option $input"

proxy='http://www-cache.reith.bbc.co.uk:80'
env_vars=(http_proxy HTTP_PROXY https_proxy HTTPS_PROXY)

switch() {
  for env_var in ${env_vars[@]};
    do
      if [[ $1 = 'on' ]]
      then
        export $env_var=$proxy
      elif [[ $1 = 'off' ]]
      then
        unset $env_var
      fi
  done 
}

if [[ $input = '1' ]]
then
  echo 'Turning HTTP proxy ON...'
  switch 'on'
  echo 'Swapping ~/.subversion/servers'
  cp ~/.subversion/servers_on_reith ~/.subversion/servers
  echo 'done'
elif [[ $input = '2' ]]
then
  echo 'Turning HTTP proxy OFF...'
  switch 'off'
  echo 'Swapping ~/.subversion/servers'
  cp ~/.subversion/servers_off_reith ~/.subversion/servers
  echo 'done'
else
  echo 'Warning: invalid option'
fi

echo 'Proxy report:'
env | grep -i "http[s|_]" | grep -vi 'maven'
echo 'Bye'
echo

