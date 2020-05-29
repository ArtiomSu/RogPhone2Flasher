###########################
### mutli_rom functions ###
###########################

prepare_stock_a10_and_havoc(){
	confirm "This will install stock android 10 rom to slot a and havoc to slot b are you sure you want to do this? [y,n]" || return 0
	echo "flashing stock rom to slot a"
	flash_all_stock_specific_images_fully a
	echo "flashing havoc to slot b"
	flash_all_stock_specific_images b
	flash_all_havoc_specific_images b
	flash_special_vbmeta

	echo "changing slot to a (stock rom)"
	change_slot a

	echo "you are now on stock rom"

	# echo ""
	# echo "installing twrp and magisk on stock"
	# menu_flash_twrp_for_android_10 && flash_magisk
	# echo "stock should be setup ok"
	# reboot_fastboot

	# echo "setting up havoc now"
	# change_slot a
	# menu_flash_magisk
	# echo "flashing done"
}

# reboots phone to stock from havoc
stock_a10_and_havoc_reboot_to_stock(){
	confirm "This will switch to stock rom are you sure? [y,n]" || return 0
	reboot_fastboot
	change_slot b
	echo "rebooting to twrp"
	reboot_to_twrp
	echo "backing up havoc data this will take a while"
	backup_data_havoc
	echo "havoc data is backed up"

	confirm "data will now be erased, if you want you can copy the backup to pc and then type y or you can just type y now to continue" || return 0
	adb shell twrp wipe data
	echo "data is now deleted we are ready to switch roms"

	reboot_fastboot
	change_slot a
	reboot_phone
	echo -e "${colour_Green}phone rebooted you will have to reboot to fastboot manually as I dont have adb access at this time${colour_NC}"

	wait_for_fastboot
	echo "ok going to flash twrp"
	menu_flash_twrp_for_android_10

	echo "will restore stock data"
	restore_data_stock || echo "stock data not found this is ok you will just need to wipe data from the menu" 
	echo "will reboot to stock slot"
	echo "all done you can reboot to os or flash magisk"

}

# reboots phone to havoc from stock
stock_a10_and_havoc_reboot_to_havoc(){
	confirm "This will switch to havoc rom are you sure? [y,n]" || return 0
	reboot_fastboot
	change_slot a
	echo "rebooting to twrp"
	reboot_to_twrp
	echo "backing up stock data this will take a while"
	backup_data_stock
	echo "stock data is backed up"

	confirm "data will now be erased, if you want you can copy the backup to pc and then type y or you can just type y now to continue" || return 0
	adb shell twrp wipe data
	echo "data is now deleted we are ready to switch roms"

	reboot_fastboot
	change_slot b
	reboot_phone
	echo -e "${colour_Green}phone rebooted you will have to reboot to fastboot manually as I dont have adb access at this time${colour_NC}"

	wait_for_fastboot
	echo "ok going to flash twrp"
	boot_into_twrp_using_Q_img
	adb reboot recovery && wait_for_twrp

	echo "will restore havoc data"
	restore_data_havoc || echo "havoc data not found this is ok you will just need to wipe data from the menu" 
	echo "will reboot to havoc slot"
	echo "all done you can reboot to os or flash magisk"
}


##################################
### end of mutli_rom functions ###
##################################