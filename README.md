# Random Comic Lock Screen
This script make possible to lock your linux with a random comic from explosm.net using xscreensaver

# explosm.net

Nice webside with lot of fun and content. All comics are downloads from this website. If you like comics, you really should visit explosm.net.

# Compatibility
Tested with Ubuntu 14.04 - Trusty
Should works with others linux.

# Dependencies
## Needed:
### Xscreensaver
xscreensaver
xscreensaver-gl
xscreensaver-gl-extra
### Image modifications
imagemagick
### Web page download
wget
### Building
make
gcc

## Might needed:
xscreensaver-data
xscreensaver-data-extra
imagemagick-common

# Install
## Step 1
Install dependencies.

## Step 2
run `make`

## Step 3
Give script execution rights
`chmod 775 wget_comic.sh`

# Use
`./wget_comic.sh`
You can create an alias to call it from everywhere.