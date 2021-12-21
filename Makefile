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
