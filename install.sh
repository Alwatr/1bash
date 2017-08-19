cp -v profile.d/* /etc/profile.d/

[ -f ~/.inputrc ] && mv -v ~/.inputrc ~/.inputrc.bk
cp -v .inputrc ~/.inputrc

[ -f ~/.bashrc ] && mv -v ~/.bashrc ~/.bashrc.bk
