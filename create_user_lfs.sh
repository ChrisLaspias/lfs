#create user and group lfs and switch to that user
groupadd lfs
useradd -s /bin/bash -g lfs -m -k /dev/null lfs

passwd lfs

su - lfs
