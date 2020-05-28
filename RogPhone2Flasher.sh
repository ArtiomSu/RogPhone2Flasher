#!/usr/bin/env bash


#unlocked=$(sudo fastboot getvar unlocked)
#read unlocked < <(sudo fastboot getvar unlocked)
#echo "unlocked is $unlocked"

#fastboot reboot bootloader
#adb reboot recovery


# interesting atricle https://www.xda-developers.com/how-a-b-partitions-and-seamless-updates-affect-custom-development-on-xda/

##############
### config ###
##############

#config values change these before running script
magisk_name="Magisk-v20.4.zip"
kernel_name="Kirisakura_Yoda_Q_2.6.2.zip"
twrpQ_boot="twrp-3.3.1-14-I001D-Q-mauronofrio.img"
twrp_installer="twrp-3.3.1-14-I001D-installer-mauronofrio.zip"
# magisk and kernel should be in the scripts folder also if you are flashing twrp put it in here
scripts_folder="/media/2tbssd/asus-rog-phone-2/downloads/exp1/scripts"
# this is where all of your stock rom images need to be
asus_images_folder="/media/2tbssd/asus-rog-phone-2/downloads/exp1/payload_dumper/output"
# this is where all of your stock rom images need to be
havoc_images_folder="/media/2tbssd/asus-rog-phone-2/downloads/exp1/havoc/payload_dumper/output"

#####################
### end of config ###
#####################



########################################
### operational values - do not edit ###
########################################
SCRIPT="$(realpath $0)"
SCRIPTPATH="$(dirname $SCRIPT)"
current_slot=""
###############################################
### end of operational values - do not edit ###
###############################################
clone_error="please git clone https://github.com/ArtiomSu/RogPhone2Flasher.git"
[ ! -f $SCRIPTPATH/scripts/rebooting_functionsd.sh ] && echo $clone_error && exit 1

source $SCRIPTPATH/scripts/rebooting_functions.sh




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
	    confirm "twrp boot img not found this might cause serious issues down the line are you sure you want to continue? [y,n]" || exit 0
	fi

	if [ ! -f "${scripts_folder}/$twrp_installer" ]; then
	    confirm "twrp installer not found this might cause serious issues down the line are you sure you want to continue? [y,n]" || exit 0
	fi
}

###############################
### end of helper functions ###
###############################





##########################h
### flashing functions ###
##########################

flash_all_stock_specific_images(){
	echo "flashing Asus images"
	cd "$asus_images_folder"
	fastboot flash abl_a abl.img
	fastboot flash abl_b abl.img

	fastboot flash aop_a aop.img
	fastboot flash aop_b aop.img

	fastboot flash asusfw_a	asusfw.img
	fastboot flash asusfw_b	asusfw.img

	fastboot flash bluetooth_a bluetooth.img
	fastboot flash bluetooth_b bluetooth.img

	#fastboot flash boot_a boot.img
	#fastboot flash boot_b boot.img

	fastboot flash cmnlib64_a cmnlib64.img
	fastboot flash cmnlib64_b cmnlib64.img

	fastboot flash cmnlib_a	cmnlib.img
	fastboot flash cmnlib_b	cmnlib.img

	fastboot flash devcfg_a	devcfg.img
	fastboot flash devcfg_b	devcfg.img

	fastboot flash dsp_a dsp.img
	fastboot flash dsp_b dsp.img

	#fastboot flash dtbo_a dtbo.img
	#fastboot flash dtbo_b dtbo.img

	fastboot flash hyp_a hyp.img
	fastboot flash hyp_b hyp.img

	fastboot flash keymaster_a keymaster.img
	fastboot flash keymaster_b keymaster.img

	fastboot flash modem_a modem.img
	fastboot flash modem_b modem.img

	fastboot flash qupfw_a qupfw.img
	fastboot flash qupfw_b qupfw.img

	#fastboot flash system_a system.img
	#fastboot flash system_b system.img

	fastboot flash tz_a	tz.img
	fastboot flash tz_b	tz.img

	fastboot flash uefisecapp_a uefisecapp.img
	fastboot flash uefisecapp_b uefisecapp.img

	#fastboot flash vbmeta_a vbmeta.img
	#fastboot flash vbmeta_b	vbmeta.img

	fastboot flash vendor_a	vendor.img
	fastboot flash vendor_b	vendor.img

	fastboot flash xbl_config_a xbl_config.img
	fastboot flash xbl_config_b xbl_config.img

	fastboot flash xbl_a xbl.img
	fastboot flash xbl_b xbl.img

	fastboot flash xrom_a xrom.img
	fastboot flash xrom_b xrom.img
}

flash_all_havoc_specific_images(){
	echo "flashing Havoc images"
	cd "$havoc_images_folder"
	fastboot flash boot_a boot.img
	fastboot flash boot_b boot.img

	fastboot flash dtbo_a dtbo.img
	fastboot flash dtbo_b dtbo.img

	fastboot flash system_a system.img
	fastboot flash system_b system.img

	fastboot flash vbmeta_a vbmeta.img
	fastboot flash vbmeta_b	vbmeta.img
}

flash_magisk(){
	echo "uploading magisk"
	cd "$scripts_folder"
	adb push ./${magisk_name} /tmp
	echo "flashing magisk"
	adb shell twrp install /tmp/${magisk_name}
	echo "magisk flashed"
	adb shell rm /tmp/${magisk_name}
}

flash_kernel(){
	echo "uploading kernel"
	cd "$scripts_folder"
	adb push ./${kernel_name} /tmp
	echo "flashing kernel"
	adb shell twrp install /tmp/${kernel_name}
	echo "kernel flashed"
	adb shell rm /tmp/${kernel_name}
}

flash_twrp(){
	echo "uploading twrp installer"
	cd "$scripts_folder"
	adb push ./${twrp_installer} /tmp
	echo "flashing twrp"
	adb shell twrp install /tmp/${twrp_installer}
	echo "twrp flashed"
	adb shell rm /tmp/${twrp_installer}
}

flash_everything_including_magisk_and_kernel(){
	 check_if_unlocked
	 flash_all_stock_specific_images
	 flash_all_havoc_specific_images
	 reboot_to_twrp
	 flash_magisk
	 flash_kernel
	 echo "Everything is done phone rebooting"
	 adb reboot
}

flash_everything_and_magisk(){
	 check_if_unlocked
	 flash_all_stock_specific_images
	 flash_all_havoc_specific_images
	 reboot_to_twrp
	 flash_magisk
	 echo "Everything is done phone rebooting"
	 adb reboot
}

flash_all_roms(){
	 check_if_unlocked
	 flash_all_stock_specific_images
	 flash_all_havoc_specific_images
	 echo "Everything is done"
}

menu_flash_magisk(){	 
	reboot_to_twrp
	flash_magisk
}

menu_flash_kernel(){	 
	reboot_to_twrp
	flash_kernel
}

#################################
### end of flashing functions ###
#################################


######################
### misq functions ###
######################

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

menu (){
	echo "     #############################################"
	echo "      ###########################################"
	echo "      #                                         #"
	echo "      #        Asus Rog Phone 2 Flasher V0.1    #"
	echo "      #        By                               #"
	echo "      #        Terminal_Heat_Sink               #"
	echo "      #                                         #"
	echo "      #        Video guide:                     #"
	echo "      #        https://youtu.be/-M_MJUzCuvM     #"
	echo "      #                                         #"
	echo "      ###########################################"
	echo "      ###########                     ###########"
	echo "       #########                       ######### "
	echo "        #######                         #######  "
	echo "     #############                   #############"
	echo ""
	PS3="$(header) Enter your choice: "
	options=( "reboot to OS" "reboot to fastboot" "reboot to twrp" "switch slots" "flash magisk" "flash kernel" "flash_everything_including_magisk_and_kernel" "flash_everything_and_magisk" "flash_all_roms" "Quit / Ctrl+C")
	select opt in "${options[@]}"
	do
	    case $opt in
	    	"reboot to OS")
	    		reboot_phone
	    		;;
	    	"reboot to fastboot")
				reboot_fastboot
	    		;;
	    	"reboot to twrp")
	    		reboot_to_twrp
	    		;;	
	    	"switch slots")
	    		echo "current slot is $current_slot"
	    		confirm "Do you want to switch to the other slot? [y/N]" && swap_slot	
	    		;;
	    	"flash magisk")
				confirm "Do you want to install magisk? [y/N]" && menu_flash_magisk
				;;
			"flash kernel")
				confirm "Do you want to flash a custom kernel? [y/N]" && menu_flash_kernel
				;;	
	        "flash_everything_including_magisk_and_kernel")
	            confirm "will flash stock and custom rom aswell as flashing magisk and custom kernel after Are you sure? [y/N]" && flash_everything_including_magisk_and_kernel	       
	            ;;
	        "flash_everything_and_magisk")
	            confirm "will flash stock and custom rom aswell as flashing magisk after Are you sure? [y/N]" && flash_everything_and_magisk
	            ;;
	        "flash_all_roms")
	            confirm "will flash stock and custom rom Are you sure? [y/N]" && flash_all_roms
	            ;;
	        "Quit / Ctrl+C")
	            break
	            ;;
	        *) 
				echo "invalid option $REPLY"
				;;
	    esac
	    echo ""
	    PS3="$(header) Enter your choice: "
	done
}

#############################
### end of misq functions ###
#############################



############
### main ###
############
#now lets check to see if these folders and files exist
check_if_folders_and_files_are_ok
#run main menu
menu 
###################
### end of main ###
###################






# if you wanna do stuff manually 
### start up ####
# check_if_unlocked
# flash_all_stock_specific_images
# flash_all_havoc_specific_images
## fastboot reboot # if you arent going to flash magisk


### flash magisk and other stuff ##
# reboot_to_twrp
# flash_magisk
# flash_kernel
# echo "Everything is done phone rebooting"
# adb reboot




# update_current_slot


# echo "unlocked is $unlocked"
# echo "current slot is $current_slot"
# echo "yo"

# reboot_to_recovery

# swap_slot
# update_current_slot
# echo "current slot is $current_slot"