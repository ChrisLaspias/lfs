#download wget-list-sysv (a file containing all packages)
#use this file to download the actual packages and store them in $LFS/sources
#wget https://www.linuxfromscratch.org/lfs/view/stable/wget-list-sysv
#wget --input-file=wget-list-sysv --continue --directory-prefix=$LFS/sources

#download md5sums and check all packages
#wget https://www.linuxfromscratch.org/lfs/view/stable/md5sums 
#mv md5sums $LFS/sources
#pushd $LFS/sources
#  md5sum -c md5sums
#popd

cat packages.csv | while read line ; do
	NAME="`echo $line | cut -d\; -f1`"
	VERSION="`echo $line | cut -d\; -f2`"
	URL="`echo $line | cut -d\; -f3`"
	MD5="`echo $line | cut -d\; -f4`"
	CACHEFILE="$(basename "$URL")"
	if [ ! -f "$CACHEFILE" ] ; then 
		echo "Downloading $VERSION"
		wget "$URL"
	fi

	#todo check md5 sum
	
done
