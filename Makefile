.PHONY: install update uninstall stow config-headless config-minimal config-full stow-post

install: stow

update:
	# Fully update git repository
	git pull
	git submodule update --init --recursive
	git submodule update --remote

uninstall:
	sudo -u $(USER) stow -D -t /home/$(USER)/.config .config
	sudo -u $(USER) stow -D -t /home/$(USER)/ home

stow: config-full stow-post

# Symlink headless config (servers, raspberry pi, etc.)
config-headless:
	# Create .config if it doesn't exist
	test -d /home/$(USER)/.config || sudo -u $(USER) mkdir /home/$(USER)/.config
	sudo -u $(USER) stow -S --no-folding -t /home/$(USER)/ \
		.clang-format \
		.zprofile
	sudo -u $(USER) stow -S --no-folding -d ./.config/ -t /home/$(USER)/ \
		git \
		htop \
		nvim \
		tmux \
		zsh

# Symlink basic GUI config
config-minimal: config-headless
	sudo -u $(USER) stow -S --no-folding -t /home/$(USER)/ \
		.xinitrc 
	sudo -u $(USER) stow -S --no-folding -d ./.config/ -t /home/$(USER)/ \
		i3 \
		picom \
		pipewire \
		redshift

# Symlink all config
config-full: config-minimal
	sudo -u $(USER) stow -S --no-folding -d ./.config/ -t /home/$(USER)/ \
		firejail \
		mpd \
		ncmpcpp

stow-post:
	# Install vim-plug for Neovim
	sudo -u $(USER) sh -c 'curl -fLo /home/$(USER)/.config/nvim/autoload/plug.vim --create-dirs \
         https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	# Neovim vim-plug initialization
	sudo -u $(USER) nvim +'PlugInstall --sync' +qa
