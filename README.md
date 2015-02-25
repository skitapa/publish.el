Publish.el
================

This is a description and a an GNU Emacs file to automate the publishing of some file to a webserver running on a *nix operating system via ssh.

My problem was that I wanted to be able to publish files from GNU Emacs and could not find a package for it.

This will be a work in progress and I am not responisble for any bad things that might happen to your files.
You are responisble for whatever happens if you use this script. I prefer you first look through the code before using it.

The goal is to have some kind of Emacs plugin so that you with one keystroke can publish files to your server.

Please be considerate, I am new to Emacs Lisp.

Using
=================

To use this, first setup so you have sshfs through fuse.
On a debian based distro this would be something like:
```
apt-get install sshfs
```
Then you can setup passwordless ssh-key login to save keystrokes.

On the machine which you use to login to the server type:
```
ssh-keygen
```
Answer questions. See to it that you leave the password empty when it asks for it.

Then copy the contents from *~/.ssh/id_rsa.pub* to
*~/.ssh/authorized_keys* on the remote server.

Now you should be able to ssh to that server without typing a password.

To simplify the connection I usually do the following:

Edit or create the file *~/.ssh/config* on your work machine. Add the following, change User and Hostname to your server:
```
Host testserver
    HostName address.to.magic.testserver.com
    Port 22
    User johndoe
```
Now when you type ssh testserver you should magically end up there, if you do everything works so far.

I use a small script to mount my server filesystem on a folder on my local machine, that way I can copy files from my SVN repository to there to publish them. This oneliner script is included as *pub_mount.sh*. Further down the road I will try to build this into my Emacs file.

Put the publish.el file into your lisp search path, for example *~/.emacs.d/lisp/*

Add the following to your .emacs file
```
(require 'publish)
;; keybinding for publish
(global-set-key (kbd "C-x p") 'publish)
```
Now go into publish.el and change the directory names so they match your own.
Then there is the tricky part.

My SVN work directory lies in *~/php-svn-checkout/*
and my testserver is mounted under *~/testserver/*

The script however take the full path, In my case */User/jimmy/php-svn-checkout/* and */User/jimmy/testserver/*
So In my case I want the script to cut off the path at character 29. That takes the whole path up to there away but keeps anything after. Then it adds the */User/jimmy/testserver* so that the file gets saved to the server directory.
That means you have to replace the number 29 with however many characters you need to loose.

When this is done you can press *M-x* and type *publish* on a buffer it will be copied to your set server directory.
Or use the shortcut *C-x p*

