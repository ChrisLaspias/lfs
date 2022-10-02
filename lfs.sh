#!/bin/bash

export LFS=/mnt/lfs
export LFS_TGT=x86_64-lfs-linux-gnu
export LFS_DISK=/dev/sdd

#if not already mounted then do the following 
if ! grep -q "$LFS" /proc/mounts; then
	# run this script to create partitions in the LFS_DISK
	source setupdisk.sh "$LFS_DISK"

	#create the directory , in which we will mount our hard disk
	sudo mkdir -pv $LFS

	# mount the filesystem 
	sudo mount -v -t ext4 "${LFS_DISK}2" "$LFS"

	#change ownership to lfs user
	sudo chown -v $USER "$LFS"
fi


# $LFS/sources directory will contain all the pacakages downloaded from the web
# $LFS/tools will contain the binaries of all packages from $LFS/sources
mkdir -pv $LFS/{boot,etc,bin,lib,sbin,usr,var,sources,tools} $LFS/usr/{bin,lib,sbin}

for i in bin lib sbin; do
  ln -sv usr/$i $LFS/$i
done

case $(uname -m) in
  x86_64) mkdir -pv $LFS/lib64 ;;
esac

#make the dir sticky (only owner can delete files)
chmod -v a+wt $LFS/sources

