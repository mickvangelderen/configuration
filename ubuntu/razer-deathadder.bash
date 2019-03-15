# Requires openrazer.

DRIVER_FOLDER="/sys/bus/hid/drivers/razermouse"

# Just do it for every connected mouse.
while IFS= read -r -d '' path; do
    echo "Found a mouse at ${path}".

    # Update poll rate.
    old=$(cat "$path"/poll_rate)
    echo -n 1000 > "$path"/poll_rate
    new=$(cat "$path"/poll_rate)
    echo "Poll rate changed from $old to $new."

    # Update DPI.
    old=$(cat "$path"/dpi)
    echo -n -e "\x05\xDC" > "$path"/dpi
    new=$(cat "$path"/dpi)
    echo "DPI changed from $old to $new."
done < <(find "${DRIVER_FOLDER}"/*/poll_rate -type f -printf "%h\0" | sort -z)

