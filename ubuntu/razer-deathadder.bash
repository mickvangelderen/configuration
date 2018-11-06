# Turns out there are multiple
# "pointer:Razer Razer DeathAdder Elite"
# so use the device id. Not cross pc.

xinput set-prop 11 "libinput Accel Speed" 0.0

# Using openrazer

DRIVER_FOLDER="/sys/bus/hid/drivers/razermouse/0003:1532:005C.0002"

# pollrate 1000Hz
echo -n "1000" > "${DRIVER_FOLDER}/poll_rate"

# dpi 1300 in hex
echo -n -e "\x05\x14" > "${DRIVER_FOLDER}/dpi"

cat "${DRIVER_FOLDER}/dpi"
