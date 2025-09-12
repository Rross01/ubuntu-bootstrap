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
