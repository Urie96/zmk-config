.PHONY: build shell preview

DOCKER_CMD=docker run -it --rm -v .:/zmk-config -w /zmk-config zmkfirmware/zmk-build-arm:stable

all: build

build_in_docker:
	$(DOCKER_CMD) make build

docker_shell:
	$(DOCKER_CMD) bash

preview:
	pcpp --passthru-unfound-includes config/corne.keymap | code -

init:
	west init -l config
	west update
	west zephyr-export

build:
	# west zephyr-export
	west build -s zmk/app -b "nice_nano_v2" -p -- -DZMK_CONFIG="$${PWD}/config" -DSHIELD="corne_left nice_view_adapter nice_view"
	cp build/zephyr/zmk.uf2 .

build-right:
	# west zephyr-export
	west build -s zmk/app -b "nice_nano_v2" -p -- -DZMK_CONFIG="$${PWD}/config" -DSHIELD="corne_right nice_view_adapter nice_view"
	cp build/zephyr/zmk.uf2 .

clean:
	rm -rf build