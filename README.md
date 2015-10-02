--------------------
Octave Installation:
--------------------

http://wiki.octave.org/Octave_for_MacOS_X#Simple_Installation_Instructions_3

Make sure to install XQuartz per the instructions.

brew tap homebrew/science
brew update && brew upgrade
brew install --with-gui octave

Might need to add this line to ~/.octaverc

setenv ("GNUTERM", "X11")

---------------------
Troubleshooting
---------------------
1. May need to install Java for Mac OSX:

https://support.apple.com/kb/DL1572?locale=en_US

2. Brew says to run 'brew link ghostscript' but gives error:

Linking /usr/local/Cellar/ghostscript/9.14...
Error: Could not symlink share/ghostscript/Resource
/usr/local/share/ghostscript is not writable.

Run:

sudo chown -R `whoami` /usr/local/share/ghostscript
