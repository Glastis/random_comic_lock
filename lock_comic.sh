#!/bin/bash

BEG_PWD="$(pwd)"
CONFIG_PATH="$HOME/.xscreensaver"
OUTPUT_DIR='lock_image'

##################################
### Restoring config and deleting temp files
##################################
function ctrl_c() {
    printf "\r%s\n" "Cleaning..."
    cp xscreensaver.bkp "$CONFIG_PATH"
    clean_images
    cd "$BEG_PWD"
    exit
}
trap ctrl_c INT

##################################
### Getting the image from Explosm
##################################
function request_image_links() {
    curl https://explosm.net/api/get-random-panels -s | sed "s/,/\n/g" | grep 'filename' | awk -F '"' '{print $4}'
}

function download_images() {
    INC=1
    for line in ${1}; do
      wget -q "https://rcg-cdn.explosm.net/panels/$line" -O "$INC.png";
      INC=$((INC+1))
    done
}

function merge_images() {
    convert +append 1.png 2.png 3.png out.png
}

function add_background() {
    convert out.png -resize "2800x1080" -channel RGBA  -blur 0x15 -crop 1920x1080+160x0 blur.png
    convert blur.png out.png -gravity center -composite -matte out.png
}

function clean_images() {
    rm -f '1.png'
    rm -f '2.png'
    rm -f '3.png'
    rm -f 'blur.png'
    if [ -f 'out.png' ]; then
      mv 'out.png' "${OUTPUT_DIR}"
    fi
}

function create_image() {
    IMAGES_LINKS="$(request_image_links)"
    download_images "$IMAGES_LINKS"
    merge_images
    add_background
    clean_images
}


##################################
### Main
##################################
function inject_xcreensaver_config() {
    cp "$CONFIG_PATH" ./xscreensaver.bkp
    cp xscreensaver_comic.blank xscreensaver_comic
    sed s:'NON_REDONDANT_STRING_HERE':`pwd`: < xscreensaver_comic.blank > xscreensaver_comic
    cp xscreensaver_comic "$CONFIG_PATH"
}

function main() {
    cd "$(dirname "${BASH_SOURCE[0]}")" || exit 1
    inject_xcreensaver_config
    mkdir -p "${OUTPUT_DIR}"
    create_image
    sleep 1
    xscreensaver-command --lock
    while true; do
        create_image
        sleep 15
    done
}

main
