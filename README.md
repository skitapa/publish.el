Terminal publish
================

This is a description and a script to automate the publishing of some file to a server using FUSE and sshfs.

My problem was that I wanted to be able to publish files from GNU Emacs and could not find a package for it.

This will be a work in progress and I am not responisble for any bad things that might happen to your files.


To start you need to install FUSE and sshfs.
On Mac OS X you can find it here: http://osxfuse.github.io
First install OSXFuse and then sshfs.

When that is done you should mount your server under a local directory.
I have chosen to use testserver under my home directory but you are free to mount it where you wish.

Use the command:

sshfs user@your_web_server.com:/path/to/web/root/ ~/testserver/

It helps if you are using passwordless login with a key. More info here: http://bit.ly/1sUHGrL

Now you can just copy your files from your working directory to ~/testserver/dir but the downside of doing it manually is that it is easy to get wrong when you are tired so I will set up a script to automate the procedure.

The goal is to have a single script command to publish your file interactivly to your server.
