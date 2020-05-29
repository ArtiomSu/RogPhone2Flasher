##########################h
### flashing functions ###
##########################

flash_all_stock_specific_images_fully(){
	echo "flashing stock images to slot $1"
	cd "$asus_images_folder"
	fastboot flash abl_${1} abl.img

	fastboot flash aop_${1} aop.img

	fastboot flash asusfw_${1}	asusfw.img

	fastboot flash bluetooth_${1} bluetooth.img

	fastboot flash boot_${1} boot.img

	fastboot flash cmnlib64_${1} cmnlib64.img

	fastboot flash cmnlib_${1}	cmnlib.img

	fastboot flash devcfg_${1}	devcfg.img

	fastboot flash dsp_${1} dsp.img

	fastboot flash dtbo_${1} dtbo.img

	fastboot flash hyp_${1} hyp.img

	fastboot flash keymaster_${1} keymaster.img

	fastboot flash modem_${1} modem.img

	fastboot flash qupfw_${1} qupfw.img

	fastboot flash system_${1} system.img

	fastboot flash tz_${1}	tz.img

	fastboot flash uefisecapp_${1} uefisecapp.img

	fastboot flash vbmeta_${1} vbmeta.img

	fastboot flash vendor_${1} vendor.img

	fastboot flash xbl_config_${1} xbl_config.img

	fastboot flash xbl_${1} xbl.img

	fastboot flash xrom_${1} xrom.img
}

flash_special_vbmeta(){
	echo "flashing special vbmeta for multi roms"
	cd "$asus_images_folder"
	fastboot --disable-verity --disable-verification flash vbmeta_a  vbmeta.img
	fastboot --disable-verity --disable-verification flash vbmeta_b  vbmeta.img
}

flash_all_stock_specific_images(){
	echo "flashing stock images to slot $1"
	cd "$asus_images_folder"
	fastboot flash abl_${1} abl.img

	fastboot flash aop_${1} aop.img

	fastboot flash asusfw_${1}	asusfw.img

	fastboot flash bluetooth_${1} bluetooth.img

	#fastboot flash boot_a boot.img
	#fastboot flash boot_b boot.img

	fastboot flash cmnlib64_${1} cmnlib64.img

	fastboot flash cmnlib_${1}	cmnlib.img

	fastboot flash devcfg_${1}	devcfg.img

	fastboot flash dsp_${1} dsp.img

	#fastboot flash dtbo_a dtbo.img
	#fastboot flash dtbo_b dtbo.img

	fastboot flash hyp_${1} hyp.img

	fastboot flash keymaster_${1} keymaster.img

	fastboot flash modem_${1} modem.img

	fastboot flash qupfw_${1} qupfw.img

	#fastboot flash system_a system.img
	#fastboot flash system_b system.img

	fastboot flash tz_${1}	tz.img

	fastboot flash uefisecapp_${1} uefisecapp.img

	#fastboot flash vbmeta_a vbmeta.img
	#fastboot flash vbmeta_b	vbmeta.img

	fastboot flash vendor_${1}	vendor.img

	fastboot flash xbl_config_${1} xbl_config.img

	fastboot flash xbl_${1} xbl.img

	fastboot flash xrom_${1} xrom.img
}

flash_all_havoc_specific_images(){
	echo "flashing Havoc images to slot $1"
	cd "$havoc_images_folder"
	fastboot flash boot_${1} boot.img

	fastboot flash dtbo_${1} dtbo.img
	
	fastboot flash system_${1} system.img

	fastboot flash vbmeta_${1} vbmeta.img
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
	 flash_all_stock_specific_images a
	 flash_all_stock_specific_images b
	 flash_all_havoc_specific_images a
	 flash_all_havoc_specific_images b
	 reboot_to_twrp
	 flash_magisk
	 flash_kernel
	 echo "Everything is done phone rebooting"
	 adb reboot
}

flash_everything_and_magisk(){
	 check_if_unlocked
	 flash_all_stock_specific_images a
	 flash_all_stock_specific_images b
	 flash_all_havoc_specific_images a
	 flash_all_havoc_specific_images b
	 reboot_to_twrp
	 flash_magisk
	 echo "Everything is done phone rebooting"
	 adb reboot
}

flash_all_roms(){
	 check_if_unlocked
	 flash_all_stock_specific_images a
	 flash_all_stock_specific_images b
	 flash_all_havoc_specific_images a
	 flash_all_havoc_specific_images b
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

menu_flash_twrp_for_android_9(){
	boot_into_twrp_using_P_img
	flash_twrp && adb reboot recovery && wait_for_twrp && echo "Inside twrp" && return 0
}

menu_flash_twrp_for_android_10(){
	boot_into_twrp_using_Q_img
	flash_twrp && adb reboot recovery && wait_for_twrp && echo "Inside twrp" && return 0
}

menu_flash_twrp_magisk_for_android_9(){
	boot_into_twrp_using_P_img
	flash_twrp && adb reboot recovery && wait_for_twrp && echo "Inside twrp" && flash_magisk && return 0
}

menu_flash_twrp_magisk_for_android_10(){
	boot_into_twrp_using_Q_img
	flash_twrp && adb reboot recovery && wait_for_twrp && echo "Inside twrp" && flash_magisk && return 0
}

#################################
### end of flashing functions ###
#################################

