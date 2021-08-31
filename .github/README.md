<p align="center">dotfiles</p>

## Introduction

This repository contains some of my configurations files. It was made to sync configurations files between both of my laptops, my personal laptop, and my work laptop.

Please consider that both laptops are MacBookPro, so if you are on a different platform chances are that maybe some of the configurations need to be different or maybe they just could not work for your platform.

#### Inspiration

This repository is inspired by and derived from the article [The best way to store your dotfiles: A bare Git repository](https://www.atlassian.com/git/tutorials/dotfiles) by Nicola Paolucci.

## How to create a repository like this

```bash
git init --bare $HOME/.cfg

alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

config config --local status.showUntrackedFiles no
```

The first line creates a bare repository under `$HOME/.cfg`.

The second line is just a temporary alias that allows us to work easily with this new repository while you finish the rest of the setup. **Warning:** this alias will only exist during the current session, in order to keep it forever you must add it to your `.*rc` file, like `.zshrc`, or in my case `.aliases` file.

And the last line is meant to hide files we are not explicitly tracking yet. This is useful because we don't want to add all the files in our home directory to a `.gitignore` file.

After that, create a new repository on GitHub.

When you have the new repository do the following:

```bash
echo ".cfg" >> .gitignore

config add .gitignore

config commit -m "Added .gitignore file to ignore the .cfg directory"

config branch -M main

config remote add origin https://github.com/{GIT_USERNAME}/dotfiles.git

config pull origin main --rebase

config push -u origin main
```

Keep in mind that `config` is the alias that you set up above and also that this is an example and some of the commands could not be required depending on your system. For example, set up your `main` branch could not be needed.

Replace the repository `https://github.com/{GIT_USERNAME}/dotfiles.git` with your own.

## Usage

After the previous setup, any file within the `$HOME` folder can be versioned with normal commands, replacing git with your newly created config alias, like:

```bash
config status
config add .vimrc
config commit -m "Add vimrc"
config add .bashrc
config commit -m "Add bashrc"
config push
```

## Using your dotfiles onto a new system

**WARNING:** If you have already some configurations files on your new system, before executing the next, please do a **BACKUP** of each file if you care about it or delete the file if you don't.

```bash
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

config config --local status.showUntrackedFiles no

config checkout
```

And that's it, from now on you can use your `config` alias to update or create new configurations files.

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.
