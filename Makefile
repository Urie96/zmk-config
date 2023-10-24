.PHONY: build shell preview

build:
	./scripts/zmk_build.sh -s -v 3.2 --host-zmk-dir ~/workspace/zmk/zmk --host-config-dir .

shell:
	./scripts/zmk_run_docker.sh -v 3.2 --host-zmk-dir ~/workspace/zmk/zmk --host-config-dir .

preview:
	pcpp --passthru-unfound-includes config/corne.keymap | code -