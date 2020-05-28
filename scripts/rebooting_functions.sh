###########################
### rebooting functions ###
###########################

reboot_to_recovery(){
	echo "rebooting to recovery"
	fastboot reboot recovery 	# this for some reason reboots the phone and not to recovery?
	# so we must wait for adb rofl
	echo "waiting for adb device"
	adb wait-for-device
	echo "rebooting to recovery"
	adb reboot recovery
}

wait_for_twrp(){
	adb get-state > /dev/null 2>&1
	while [ $? -ne 0 ]
	do
		echo "waiting for twrp to come online ( you might have to type in your code )"
		sleep 5
		adb get-state > /dev/null 2>&1
	done
}

reboot_to_twrp(){
	check_if_in_fastboot && reboot_to_recovery && wait_for_twrp && echo "Inside twrp" && return 0 || echo "waiting for adb device" && adb wait-for-device && echo "rebooting to recovery" && adb reboot recovery && wait_for_twrp && echo "Inside twrp" && return 0
}

reboot_phone(){
	check_if_in_fastboot && fastboot reboot && return 0 || adb reboot && return 0
}

reboot_fastboot(){
	check_if_in_fastboot && echo "rebooting to fastboot" && fastboot reboot bootloader && wait_for_fastboot && echo "rebooted to fasboot" && return 0 || echo "rebooting to fastboot" && adb reboot bootloader && wait_for_fastboot && echo "rebooted to fasboot" && return 0
}

##################################
### end of rebooting functions ###
##################################