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

menu_flash_twrp_for_android_9(){
	boot_into_twrp_using_P_img
	flash_twrp && adb reboot recovery && wait_for_twrp && echo "Inside twrp" && return 0
}

menu_flash_twrp_for_android_10(){
	boot_into_twrp_using_Q_img
	flash_twrp && adb reboot recovery && wait_for_twrp && echo "Inside twrp" && return 0
}

#################################
### end of flashing functions ###
#################################

