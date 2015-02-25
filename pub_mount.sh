#!/bin/bash
#place this somewhere in your executable path, say /bin/, /usr/bin, /local/bin or in /home/user/bin and add that bin dir to your path.
#Change port accordingly to your needs.

sshfs -p 22 user@server.com:/var/www/some_web_project/ ~/testserver/
