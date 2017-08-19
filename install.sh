cp -v profile.d/* /etc/profile.d/

[ -f ~/.inputrc ] && mv ~/.inputrc ~/.inputrc.bk
cp -v .inputrc ~/.inputrc

[ -f ~/.bashrc ] && mv ~/.bashrc ~/.bashrc.bk
