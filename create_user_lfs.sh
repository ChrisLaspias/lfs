groupadd lfs
useradd -s /bin/bash -g lfs -m -k /dev/null lfs

passwd lfs

su - lfs
