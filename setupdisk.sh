LFS_DISK="$1"

# n : create new partition 
# p after n : primary partition
# number : partiion number 
# a : bootable partition
# read fdisk manual for more information

sudo fdisk "$LFS_DISK" << EOF
o
n
p
1

+100M
a
n
p
2


p
w
q
EOF

#after creating the partitions , create the filesystem
sudo mkfs -v -t ext2 "${LFS_DISK}1"
sudo mkfs -v -t ext4 "${LFS_DISK}2"