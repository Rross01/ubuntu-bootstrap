.PHONY: help
.DEFAULT_GOAL := help

CONTAINER := arch-tools
IMAGE     := archlinux:latest
BIN_DIR   := ./bin
TOOLS     := kubectl helm helmfile sops k9s dive

help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

sync-home:
	rsync -avz --delete \
	  --filter='+ .kube/' \
	  --filter='+ .kube/config' \
	  --filter='+ .config/' \
	  --filter='+ .config/ghostty/***' \
	  --filter='+ .config/nvim/***' \
	  --filter='+ .config/tmux/***' \
	  --filter='+ .gitconfig' \
	  --filter='+ .scripts/***' \
	  --filter='+ .zshrc' \
	  --filter='- **' \
	  /$(HOME)/ home/

install-bins: ensure-container update-tools copy-tools

ensure-container:
	@if ! podman container exists $(CONTAINER); then \
		podman run --name $(CONTAINER) $(IMAGE) \
		pacman -Sy --noconfirm --needed $(TOOLS); \
	fi

update-tools:
	podman start -ai $(CONTAINER)

copy-tools:
	@mkdir -p $(BIN_DIR)
	@for tool in $(TOOLS); do \
		podman cp $(CONTAINER):/usr/bin/$$tool $(BIN_DIR)/; \
	done
