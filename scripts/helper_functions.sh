########################
### helper functions ###
########################
wait_for_fastboot(){
	up=$(fastboot devices | grep fast)
	while [ -z "$up" ]
	do
		echo "waiting for phone to come online"
		sleep 5
		up=$(fastboot devices | grep fast)
	done
}

update_current_slot(){
	wait_for_fastboot
	fastboot oem device-info > /tmp/nothing_interesting.yoyo 2>&1
	# get current slot
	current_slot=$(cat /tmp/nothing_interesting.yoyo | sed "s/(bootloader)//g" | grep "Current Slot :" | grep -oh -m1 a | tail -n 1)
	if [ -z $current_slot ]
	then
		current_slot="b"
	fi
}

check_if_in_fastboot(){
	up=$(fastboot devices | grep fast)
	if [ -z "$up" ]
	then
		false
	else
		true
	fi
}

check_if_unlocked(){
	wait_for_fastboot
	fastboot oem device-info > /tmp/nothing_interesting.yoyo 2>&1
	unlocked=$(cat /tmp/nothing_interesting.yoyo | grep "Device unlocked:" | grep -oh -m1 true)

	if [ -z $unlocked ]
	then
		echo "device is locked tis no good"
		exit 1
	fi
}

header(){
	check_if_in_fastboot && update_current_slot && echo "[Asus Rog Phone 2 Flasher (Fastboot mode) current slot is ${current_slot}]" || echo "[Asus Rog Phone 2 Flasher (adb mode)]" 
}

confirm() {
    read -r -p "${1:-Are you sure? [y/N]} " response
    case "$response" in
        [yY][eE][sS]|[yY]) 
            true
            ;;
        *)
            false
            ;;
    esac
}

check_if_folders_and_files_are_ok(){
	if [ ! -d "$scripts_folder" ]; then
    confirm "scripts folder is not correct this might cause serious issues down the line are you sure you want to continue? [y,n]" || exit 0
	fi

	if [ ! -d "$asus_images_folder" ]; then
	    confirm "asus images folder is not correct this might cause serious issues down the line are you sure you want to continue? [y,n]" || exit 0
	fi

	if [ ! -d "$havoc_images_folder" ]; then
	    confirm "custom rom images folder is not correct this might cause serious issues down the line are you sure you want to continue? [y,n]" || exit 0
	fi

	if [ ! -f "${scripts_folder}/$magisk_name" ]; then
	    confirm "magisk file is not found this might cause serious issues down the line are you sure you want to continue? [y,n]" || exit 0
	fi

	if [ ! -f "${scripts_folder}/$kernel_name" ]; then
	    confirm "custom kernel file is not found this might cause serious issues down the line are you sure you want to continue? [y,n]" || exit 0
	fi

	if [ ! -f "${scripts_folder}/$twrpQ_boot" ]; then
	    confirm "twrp android 10 boot img not found this might cause serious issues down the line are you sure you want to continue? [y,n]" || exit 0
	fi

	if [ ! -f "${scripts_folder}/$twrpP_boot" ]; then
	    confirm "twrp android 9 boot img not found this might cause serious issues down the line are you sure you want to continue? [y,n]" || exit 0
	fi

	if [ ! -f "${scripts_folder}/$twrp_installer" ]; then
	    confirm "twrp installer not found this might cause serious issues down the line are you sure you want to continue? [y,n]" || exit 0
	fi
}

wait_for_fastboot(){
	up=$(fastboot devices | grep fast)
	while [ -z "$up" ]
	do
		echo "waiting for phone to come online"
		sleep 5
		up=$(fastboot devices | grep fast)
	done
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

update_current_slot(){
	wait_for_fastboot
	fastboot oem device-info > /tmp/nothing_interesting.yoyo 2>&1
	# get current slot
	current_slot=$(cat /tmp/nothing_interesting.yoyo | sed "s/(bootloader)//g" | grep "Current Slot :" | grep -oh -m1 a | tail -n 1)
	if [ -z $current_slot ]
	then
		current_slot="b"
	fi
}

check_if_in_fastboot(){
	up=$(fastboot devices | grep fast)
	if [ -z "$up" ]
	then
		false
	else
		true
	fi
}

check_if_unlocked(){
	wait_for_fastboot
	fastboot oem device-info > /tmp/nothing_interesting.yoyo 2>&1
	unlocked=$(cat /tmp/nothing_interesting.yoyo | grep "Device unlocked:" | grep -oh -m1 true)

	if [ -z $unlocked ]
	then
		echo "device is locked tis no good"
		exit 1
	fi
}

header(){
	check_if_in_fastboot && update_current_slot && echo "[Asus Rog Phone 2 Flasher (Fastboot mode) current slot is ${current_slot}]" || echo "[Asus Rog Phone 2 Flasher (adb mode)]" 
}

confirm() {
    read -r -p "${1:-Are you sure? [y/N]} " response
    case "$response" in
        [yY][eE][sS]|[yY]) 
            true
            ;;
        *)
            false
            ;;
    esac
}

check_if_folders_and_files_are_ok(){
	if [ ! -d "$scripts_folder" ]; then
    confirm "scripts folder is not correct this might cause serious issues down the line are you sure you want to continue? [y,n]" || exit 0
	fi

	if [ ! -d "$asus_images_folder" ]; then
	    confirm "asus images folder is not correct this might cause serious issues down the line are you sure you want to continue? [y,n]" || exit 0
	fi

	if [ ! -d "$havoc_images_folder" ]; then
	    confirm "custom rom images folder is not correct this might cause serious issues down the line are you sure you want to continue? [y,n]" || exit 0
	fi

	if [ ! -f "${scripts_folder}/$magisk_name" ]; then
	    confirm "magisk file is not found this might cause serious issues down the line are you sure you want to continue? [y,n]" || exit 0
	fi

	if [ ! -f "${scripts_folder}/$kernel_name" ]; then
	    confirm "custom kernel file is not found this might cause serious issues down the line are you sure you want to continue? [y,n]" || exit 0
	fi

	if [ ! -f "${scripts_folder}/$twrpQ_boot" ]; then
	    confirm "twrp boot img not found this might cause serious issues down the line are you sure you want to continue? [y,n]" || exit 0
	fi

	if [ ! -f "${scripts_folder}/$twrp_installer" ]; then
	    confirm "twrp installer not found this might cause serious issues down the line are you sure you want to continue? [y,n]" || exit 0
	fi
}

swap_slot(){
	update_current_slot
	if [ "$current_slot" == "a" ]
	then
		echo "slot is a will reboot to b"
		fastboot --set-active=b
	elif [ "$current_slot" == "b" ]
	then
			echo "slot is b will reboot to a"
			fastboot --set-active=a
	else
			echo "slot not found exiting"
			exit 2
	fi
	fastboot reboot bootloader
	wait_for_fastboot
}

change_slot(){
	fastboot --set-active=${1}
	fastboot reboot bootloader
	wait_for_fastboot
}

###############################
### end of helper functions ###
###############################