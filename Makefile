.PHONY: all
all: build

.PHONY: preview
preview:
	pcpp --passthru-unfound-includes config/corne.keymap

.PHONY: init
init:
	west init -l config
	west update
	west update --fetch-opt=--filter=blob:none
	west zephyr-export
	# https://docs.zephyrproject.org/3.5.0/develop/getting_started/index.html#install-zephyr-sdk

.PHONY: build
build:
	west build -s zmk/app -b "nice_nano_v2" -p -- -DZMK_CONFIG="$${PWD}/config" -DSHIELD="corne_left nice_view_adapter nice_view"
	cp build/zephyr/zmk.uf2 ./corne-left.uf2

.PHONY: build-right
build-right:
	west build -s zmk/app -b "nice_nano_v2" -p -- -DZMK_CONFIG="$${PWD}/config" -DSHIELD="corne_right nice_view_adapter nice_view"
	cp build/zephyr/zmk.uf2 ./corne-right.uf2

.PHONY: build-reset
build-reset:
	west build -s zmk/app -b "nice_nano_v2" -p -- -DZMK_CONFIG="$${PWD}/config" -DSHIELD="settings_reset"
	cp build/zephyr/zmk.uf2 ./corne-reset.uf2

.PHONY: clean
clean:
	rm -rf build

.PHONY: draw
draw:
	keymap parse -c 10 -z ./config/corne.keymap >./draw/keymap.yaml
	keymap draw ./draw/keymap.yaml >./draw/keymap.svg
