sync-home:
	rsync -avz --delete \
	  --filter='+ .kube/' \
	  --filter='+ .kube/config' \
	  --filter='+ .config/' \
	  --filter='+ .config/alacritty/***' \
	  --filter='+ .config/fontconfig/***' \
	  --filter='+ .config/nvim/***' \
	  --filter='+ .config/tmux/***' \
	  --filter='+ .gitconfig' \
	  --filter='+ .rsync-filter' \
	  --filter='+ .scripts/***' \
	  --filter='+ .zshrc' \
	  --filter='- **' \
	  /$(HOME)/ home/
