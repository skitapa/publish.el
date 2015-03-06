#!/bin/bash
#Small script to mount server directory locally
#Check that your username, server adress and paths are correct

#Nohup needed for sshfs to work in GNU Emacs
#Output directed to /dev/null so no nohup.out is created

/usr/bin/nohup /usr/local/bin/sshfs user@webserver.com:/var/www/target/folder /local/mount/folder/testserver/ >/dev/null 2>&1
