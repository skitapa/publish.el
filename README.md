Publish.el
================

This is a description and a GNU Emacs file to automate the publishing of some file to a webserver running on a *nix operating system via ssh.

My problem was that I wanted to be able to publish files from GNU Emacs and could not find a package for it. I mounted my webserver locally with sshfs and then copied the edited files there and put them in the correct folders.
This was time consuming and prone to errors.

So what does this package do?
Well, when I edit files in my subversion working directory (or any revision control system), I load them up in buffers in GNU Emacs, I do my work on them and when done I press **Ctrl-x p** and the files are published on my webserver.
This is done by mounting the servers webcontent folders locally and copying the files there. If the server is not mounted you will be asked if you want to and the package will do it for you, if you have set it up properly.


This will be a work in progress and I am not responsible for any bad things that might happen to your files.
**You** are responsible for whatever happens if you use this script. I prefer you first look through the code before using it. That said, it works great for me!

Previous completed goal - Fix so you could publish with one keystroke

Next goal - Create a setup-script to remove necessary manual edits. Preferadly to setup passwordless ssh as well. 

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

Then copy the contents from **~/.ssh/id_rsa.pub** to
**~/.ssh/authorized_keys** on the remote server.

Now you should be able to ssh to that server without typing a password.

To simplify the connection I usually do the following:

Edit or create the file **~/.ssh/config** on your work machine. Add the following, change User, Port and Hostname to your server:
```
Host testserver
    HostName address.to.magic.testserver.com
    Port 22
    User johndoe
```
Now when you type ssh testserver you should magically end up there, if you do everything works so far.

I have included **pub_mount.sh** a oneliner bash script to automatically mount the webserver from within GNU Emacs. Put this file in one of your bin folders, say /usr/local/bin,/usr/bin,/bin or do as me and create a bin folder in your home directory and add that to your paths.

Put the publish.el file into your lisp search path, for example **~/.emacs.d/lisp/**

Add the following to your .emacs file
```
(require 'publish)
;; keybinding for publish
(global-set-key (kbd "C-x p") 'publish)
```
Now go into publish.el and change the directory names so they match your own.

On your server you probably have the webserver directory at /var/www or something similar while on your local computer the SSH mounted directory probably lies under /Users/johndoe/testserver or something like that.
What we want to do is remove these paths so that files from SVN or GIT or whatever versioning control system you use can be copied directly into the correct locally mounted folder.

One example of this would be that you are working on a file, say:
**/Users/johndoe/php-svn-checkout/private/modules/dashboard/views/dashboard_list.php**
When done editing the file you press **Ctrl-x p** and the file is copied to (in my case)
**/Users/johndoe/testserver/private/modules/dashboard/views/dashboard_list.php**

My SVN work directory lies in **~/php-svn-checkout/**
and my testserver is mounted with sshfs under **~/testserver/**

The script however take the full path, In my case **/User/johndoe/php-svn-checkout/** and **/User/johndoe/testserver/**
So In my case I want the script to cut off the path at character 29. That takes the whole path up to there away but keeps anything after. Then it adds the **/User/johndoe/testserver** so that the file gets saved to the server directory.
That means you have to replace the number 29 with however many characters you need to loose. I could ask for paths in the script, but it is equally much work for you to type it all in.

When this is done you can press **M-x** and type **publish** on a buffer it will be copied to your set server directory.
Or use the shortcut **Ctrl-x p**

Happy publishing!
