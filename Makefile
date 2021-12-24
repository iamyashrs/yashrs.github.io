.PHONY: all
all: update-theme

.PHONY: update-theme
update-theme:
	git submodule update --remote

.PHONY: serve
serve: 
	hugo server

.PHONY: generate
generate: 
	hugo

.PHONY: remove-exif
remove-exif:
	exiftool -all:all= -r -overwrite_original content/

dep:
	brew install --cask hugo exiftool 
