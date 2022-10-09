#
# Script that should fully set up a new Arch install
#

# Enable parallel downloads and multilib
sudo sed -i "s|#ParallelDownloads = .*|ParallelDownloads = 10|" /etc/pacman.conf
sudo sed -i -e '/^#\[multilib]/s/^#//' -e '/\[multilib]/{n;s/^#//}' /etc/pacman.conf

# Install packages I like
sudo pacman -Sy --needed --noconfirm \
	autorandr \
	dunst \
	exa \
	fzf \
	gdb \
	gimp \
	git \
	i3-wm \
	imagemagick \
	intel-ucode \
	libreoffice-fresh \
	light \
	maim \
	man \
	mpv \
	neovim \
	ntp \
	openssh \
	openvpn \
	pandoc \
	picom \
	powertop \
	python \
	python-pip \
	stow \
	sxiv \
	tlp \
	tmux \
	xclip \
	xorg-server \
	xorg-xinit \
	xorg-xinput \
	xorg-xrandr \
	zsh

# Install paru aur helper
rm -rf /tmp/paru
sudo -u $(USER) git clone https://aur.archlinux.org/paru.git /tmp/paru
(cd /tmp/paru && sudo -u $(USER) makepkg -si)
rm -rf /tmp/paru

# Change shell to zsh
sudo -u $(USER) chsh -s /bin/zsh $(USER)

# Move block IPs to host file
sudo -u $(USER) curl https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts >>/tmp/blockips
sudo cat /tmp/blockips >>/etc/hosts

# Symlink config
../make install
