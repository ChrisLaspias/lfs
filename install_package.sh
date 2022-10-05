CHAPTER="$1"
PACKAGE="$2"

cat packages.csv | grep -i "^$PACKAGE" | grep -i -v "\.patch;" | while read line; do
	VERSION="`echo $line | cut -d\; -f2`"
	URL="`echo $line | cut -d\; -f3`"
	CACHEFILE="$(basename "$URL")"
	DIRNAME="$(echo $CACHEFILE | sed 's/\(.*\)\.tar\..*/\1/')"

	if [ -d "$DIRNAME" ] ; then
		rm -rf "$DIRNAME"
	fi

	mkdir -pv "$DIRNAME"
	tar -xf "$CACHEFILE" -C "$DIRNAME"

	pushd "$DIRNAME"

	if [ "$(ls -1A | wc -l)" == "1" ]; then
		mv $(ls -1A)/* ./
	fi

	echo "Compiling $CACHEFILE"
	sleep 5

	mkdir -pv "../log/chapter$CHAPTER/"
	
	if ! source "../chapter$CHAPTER/$PACKAGE.sh" 2>&1 | tee "../log/chapter$CHAPTER/$PACKAGE.log"; then
		echo "Compiling $CACHEFILE FAILED !"
		popd
		exit 1
	fi

	echo "Done compiling $FULL"

	popd
done
