# Random Comic Lock Screen
This script make possible to lock your linux with a random comic from explosm.net using xscreensaver

# explosm.net

All comics are downloads from this website. If you like absurd comics, you really should visit explosm.net.

# Compatibility
Tested with Debian 11 - Bullseye

# Dependencies

### Debian/Ubuntu
```
apt-get install xscreensaver xscreensaver-gl xscreensaver-gl-extra xscreensaver-data xscreensaver-data-extra imagemagick imagemagick-common wget curl
```

### Packages
#### Xscreensaver
xscreensaver
xscreensaver-gl
xscreensaver-gl-extra
xscreensaver-data
xscreensaver-data-extra

#### Image modifications
imagemagick
imagemagick-common

#### Web page download
wget
curl

# Install
Install dependencies, see before.

Give to the scripts the execution right.
```
chmod +x lock_comic.sh create_image.sh
```

# Use
`xscreensaver-demo`, confirm using monitor 0 and quit (just needed one time)
`./wget_comic.sh`
You can create an alias to call it from everywhere.
