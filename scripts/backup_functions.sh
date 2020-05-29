########################
### backup functions ###
########################
twrp_backup_folder=""

create_backup_folder(){
	adb shell mkdir -p /sdcard/RogPhone2Flasher/backups
}

get_backup_folder_name(){
	device_name="$(adb shell ls /sdcard/TWRP/BACKUPS)"
	twrp_backup_folder="/sdcard/TWRP/BACKUPS/${device_name}"
}

backup_data_havoc(){
	get_backup_folder_name
	adb shell rm -r ${twrp_backup_folder}/data_backup_havoc
	adb shell twrp backup D data_backup_havoc
}

restore_data_havoc(){
	adb shell twrp restore data_backup_havoc D
}

backup_boot_havoc(){
	get_backup_folder_name
	adb shell rm -r ${twrp_backup_folder}/boot_backup_havoc
	adb shell twrp backup B boot_backup_havoc 
}

restore_boot_havoc(){
	adb shell twrp restore boot_backup_havoc B
}

backup_data_omni(){
	get_backup_folder_name
	adb shell rm -r ${twrp_backup_folder}/data_backup_omni
	adb shell twrp backup D data_backup_omni
}

restore_data_omni(){
	adb shell twrp restore data_backup_omni D
}

backup_data_stock(){
	get_backup_folder_name
	adb shell rm -r ${twrp_backup_folder}/data_backup_stock
	adb shell twrp backup D data_backup_stock
}

restore_data_stock(){
	adb shell twrp restore data_backup_stock D
}

twrp_wipe_data_by_boot_android_10(){
	boot_into_twrp_using_Q_img
	adb shell twrp wipe data
}

twrp_wipe_data_by_boot_android_9(){
	boot_into_twrp_using_P_img
	adb shell twrp wipe data
}

twrp_wipe_data(){
	reboot_to_twrp
	adb shell twrp wipe data
}




###############################
### end of backup functions ###
###############################