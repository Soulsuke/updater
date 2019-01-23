# updater
This is a simple script made easily update different Linux flavours.
So far, it only supports Arch Linux and Debian (and derivates), since
these are the flavours of my choice.

Max 80 characters per line, two spaces instead of tabs, and probably
quite dirty. Still, quite handy when you got to maintain various
systems and you don't want to do it manually every time.

To know if it runs on your system: ./main.zsh -h

### To avoid tracking local changes to a certain file:  
git update-index --assume-unchanged lib/distro\_independent.zsource  

