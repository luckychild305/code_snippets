#!/bin/bash
cd /opt/src
node index.js

# check if user has specified /bin/bash CMD
using_shell=0
for var in "$@"; do
  if [ "$var" == "/bin/bash" ]; then
    using_shell=1
  fi
done

# start /bin/bash
if [ $using_shell -eq 1 ]; then
  cd /opt/src
  exec "/bin/bash"
# daemon mode - sleep indefinitely
#else
#  while true; do sleep 10000; done
fi