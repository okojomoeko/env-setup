function write_string() {
    if [ ! -f "$2" ]; then
        touch "$2"
    fi

    if ! grep -q "$1" "$2"; then
        echo "$1" >> "$2"
    fi
}
