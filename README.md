configs for different things. 

probably a simpler way to to do this, but the structure is:
	- <name of software>
		- <configuration dir for everything but dotfiles>
		- <configuration dir for dotfiles>

The first directory can go wherever you want, but the dotfiles directory should be relative to your hoe directory on most systems (i.e., if the dotfiles directory contains a .config directory, the expected location of the config is ~/.config/)
