NAME = fedora-logos

all: bootloader/fedora.icns

bootloader/fedora.icns: pixmaps/fedora-logo-sprite.svg
	convert -background none -resize 128x128 pixmaps/fedora-logo-sprite.svg pixmaps/fedora-logo-sprite.png
	zopflipng -ym pixmaps/fedora-logo-sprite.png pixmaps/fedora-logo-sprite.png
	png2icns bootloader/fedora.icns pixmaps/fedora-logo-sprite.png

bootloader/bootlogo_128.png: pixmaps/fedora-logo-sprite.svg
	convert -background none -resize 128x128 pixmaps/fedora-logo-sprite.svg bootloader/bootlogo_128.png
	zopflipng -ym bootloader/bootlogo_128.png bootloader/bootlogo_128.png

bootloader/bootlogo_256.png: pixmaps/fedora-logo-sprite.svg
	convert -background none -resize 256x256 pixmaps/fedora-logo-sprite.svg bootloader/bootlogo_256.png
	zopflipng -ym bootloader/bootlogo_256.png bootloader/bootlogo_256.png

optimize:
	find . -name "*.png" -printf "%p %p\n" | \
	xargs -L 1 -P `getconf _NPROCESSORS_ONLN 2>/dev/null || echo 1` \
	zopflipng -ym

wsl-logo.ico:
	magick icons/hicolor/256x256/apps/fedora-logo-icon.png pixmaps/fedora-logo.ico

clean:
	rm -f pixmaps/fedora-logo-sprite.png bootloader/fedora.icns bootloader/bootlogo_128.png bootloader/bootlogo_256.png pixmaps/fedora-logo.ico
