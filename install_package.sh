CHAPTER="$1"
PACKAGE="$2"

cat wget-list-sysv | grep -i "$PACKAGE" | grep -i -v "\.patch;" | while read line; do
	FULL="${line##*/}"
	PACKAGE="${FULL%-*}"
	VERSION="${FULL##*-}"
	VERSION="$(echo $VERSION | sed 's/\(.*\)\.tar\..*/\1/')"
	DIRNAME="$(echo $FULL | sed 's/\(.*\)\.tar\..*/\1/')"
	echo $PACKAGE
	echo $VERSION
	echo $DIRNAME

	mkdir -pv "$DIRNAME"
	tar -xf "$FULL" -C "$DIRNAME"

	pushd "$DIRNAME"

	if [ "$(ls -1A | wc -l)" == "1" ]; then
		mv $(ls -1A)/* ./
	fi

	echo "Compiling $FULL"
	sleep 5


	mkdir -pv "../log/chapter$CHAPTER/"
	
	if ! source "../chapter$CHAPTER/$PACKAGE.sh" 2>&1 | tee "../log/chapter$CHAPTER/$PACKAGE.log"; then
		echo "Compiling $FULL FAILED !"
		popd
		exit 1
	fi

	echo "Done compiling $FULL"

	popd
done
