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
	#reboot_fastboot
	#change_slot a
	echo "will restore stock data"
	#reboot_to_twrp
	restore_data_stock || echo "stock data not found this is ok you will just need to wipe data from the menu" 
	echo "will reboot to stock slot"
	reboot_fastboot
	change_slot a
	echo "all done"

}

# reboots phone to stock from havoc
stock_a10_and_havoc_reboot_to_havoc(){
	confirm "This will switch to havoc rom are you sure? [y,n]" || return 0
	reboot_fastboot
	change_slot a
	echo "rebooting to twrp"
	reboot_to_twrp
	echo "backing up stock data this will take a while"
	backup_data_stock
	echo "stock data is backed up"
	echo "will restore havoc data"
	restore_data_havoc || echo "havoc data not found this is ok you will just need to wipe data from the menu" 
	echo "will reboot to havoc slot"
	reboot_fastboot
	change_slot b
	echo "all done"
}


##################################
### end of mutli_rom functions ###
##################################