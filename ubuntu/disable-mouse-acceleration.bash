#!/usr/bin/env bash

# If the flat accelprofile is not supported we can use this.
# cat <<END >> /usr/share/X11/xorg.conf.d/50-mouse-acceleration.conf
# Section "InputClass"
# 	Identifier "My Mouse"
# 	MatchIsPointer "yes"
# 	Option "AccelerationProfile" "-1"
# 	Option "AccelerationScheme" "none"
# 	Option "AccelSpeed" "-1"
# EndSection
# END

cat <<END >> /usr/share/X11/xorg.conf.d/50-mouse-acceleration.conf
Section "InputClass"
	Identifier "Mick Mouse"
	Driver "libinput"
	MatchIsPointer "yes"
	Option "AccelProfile" "flat"
	Option "AccelSpeed" "0"
EndSection
END
