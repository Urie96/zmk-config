.PHONY: build shell preview

build_in_docker:
	docker run -it --rm -v .:/config -w /config zmkfirmware/zmk-build-arm:stable make build

preview:
	pcpp --passthru-unfound-includes config/corne.keymap | code -

init:
	west init -l config
	west update
	west zephyr-export

build:
	west build -s zmk/app -b "nice_nano_v2" -- -DZMK_CONFIG="./config" -DSHIELD="corne_left nice_view_adapter nice_view"
	cp build/zephyr/zmk.uf2 .