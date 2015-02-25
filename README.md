Publish.el
================

This is a description and a an GNU Emacs file to automate the publishing of some file to a server.

My problem was that I wanted to be able to publish files from GNU Emacs and could not find a package for it.

This will be a work in progress and I am not responisble for any bad things that might happen to your files.
You are responisble for whatever happens if you use this script. I prefer you first look through the code before using it.

The goal is to have some kind of Emacs plugin so that you with one keystroke can publish files to your server.

Please be considerate, I am new to Emacs Lisp.

Using
=================

To use this, first setup so you have sshfs through fuse.
On a debian based distro this would be something like:

apt-get install sshfs

Then you can setup passwordless ssh-key login to save keystrokes.

On the machine which you use to login to the server type:

ssh-keygen

Answer questions. See to it that you leave the password empty when it asks for it.

then copy the contents from ~/.ssh/id_rsa.pub to
~/.ssh/authorized_keys on the remote server.

Now you should be able to ssh to that server without typing a password.

To simplify the connection I usually do the following:

Edit or create the file ~/.ssh/config on your work machine. Add the following, change User and Hostname:

Host testserver
    HostName address.to.magic.testserver.com
    Port 22
    User johndoe
Host prodserver
     HostName realdeal.server.com
     Port 1492
     User dude
     

Now when you type ssh testserver you should magically end up there, if you do everything works so far.

I use a small script to mount my server filesystem on a folder on my local machine, that way I can copy files from my SVN repository to there to publish them. I will inlcude this script. Further down the road I will try to build this into my Emacs file.

When you have mounted your server filesystem, open Emacs. Visit(Load) the publish.el file and change directories to match yours, then go to line 18 after the parenthesis. Press CTRL-x CTRL-e to evaluate the definition.

Now when you press M-x and type publish on a buffer it will be copied to your set server directory.
I recommend you bind the function to some key.
