# 1Bash v2.0

Linux Bash Customization, AliMD Edition ;)

## Install

```bash
# clone project
export ONE_BASH=~/1bash
git clone https://github.com/AliMD/1bash.git $ONE_BASH

# copy user config
cp -av $ONE_BASH/inputrc ~/.inputrc
cp -av $ONE_BASH/profile ~/.profile
cp -aiv $ONE_BASH/gitconfig ~/.gitconfig
```

## Customize Logo

Put your logo or any welcome message in `~/.1bash_logo`.

```bash
nano ~/.1bash_logo
```

[Generate your own logo](http://patorjk.com/software/taag)

## Upgrade

Just pull the 1bash git repository.

```bash
cd $ONE_BASH
g pl
```