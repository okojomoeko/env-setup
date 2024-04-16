function write_string() {
    if ! grep -q "$1" "$2"; then
        echo "$1" >> "$2"
    fi
}
