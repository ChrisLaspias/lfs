#create bash.profile and bashrc for the lfs user and set some variables
cat > ~/.bash_profile << "EOF"
exec env -i HOME=$HOME TERM=$TERM PS1='\u:\w\$ ' /bin/bash
EOF


cat > ~/.bashrc << "EOF"
set +h
umask 022
LFS=/mnt/lfs
USER=$(whoami)
LC_ALL=POSIX
LFS_TGT=$(uname -m)-lfs-linux-gnu
PATH=/usr/bin
if [ ! -L /bin ]; then PATH=/bin:$PATH; fi
PATH=$LFS/tools/bin:$PATH
CONFIG_SITE=$LFS/usr/share/config.site
export USER LFS LC_ALL LFS_TGT PATH CONFIG_SITE
EOF

source ~/.bash_profile
