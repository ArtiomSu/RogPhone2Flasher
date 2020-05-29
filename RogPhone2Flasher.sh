#!/usr/bin/env bash
##############
### config ###
##############

#config values change these before running script
magisk_name="Magisk-v20.4.zip"
kernel_name="Kirisakura_Yoda_Q_2.6.2.zip"
twrpQ_boot="twrp-3.3.1-14-I001D-Q-mauronofrio.img"
twrpP_boot="twrp-3.3.1-14-I001D-Pie-mauronofrio.img"
twrp_installer="twrp-3.3.1-14-I001D-installer-mauronofrio.zip"
# magisk and kernel should be in the scripts folder also if you are flashing twrp put it in here
scripts_folder="/media/2tbssd/asus-rog-phone-2/downloads/exp1/scripts"
# this is where all of your stock rom images need to be
asus_images_folder="/media/2tbssd/asus-rog-phone-2/downloads/exp1/payload_dumper/output"
# this is where all of your stock rom images need to be
havoc_images_folder="/media/2tbssd/asus-rog-phone-2/downloads/exp1/havoc/payload_dumper/output"
# this allows you to skip the [y,n] confirmations by setting it to false
always_confirm_user_action=true

# check if we are using windows with the linux subsystem
windowscheck="$(uname -r | grep Microsoft)"
if [ ! -z $windowscheck ]
then
	# if you are using windows then change scripts_folder, asus_images_folder, havoc_images_folder, windows_adb and windows_fastboot bellow
	# change the following 3 folders to suit your windows environment
	scripts_folder="/mnt/d/asus-rog-phone-2/downloads/exp1/scripts"
	asus_images_folder="/mnt/d/asus-rog-phone-2/downloads/exp1/payload_dumper/output"
	havoc_images_folder="/mnt/d/asus-rog-phone-2/downloads/exp1/havoc/payload_dumper/output"
	windows_adb="/mnt/d/asus-rog-phone-2/platform-tools_r29.0.5-windows/adb.exe"
	# your fastboot file in windows
	windows_fastboot="/mnt/d/asus-rog-phone-2/platform-tools_r29.0.5-windows/fastboot.exe"

	echo "windows detected chaging some stuff"
	if [ ! -f "$windows_adb" ]; then
		echo "adb not found cannot continue"
		exit 1
	fi
	if [ ! -f "$windows_fastboot" ]; then
		echo "fastboot not found cannot continue"
		exit 1
	fi
	shopt -s expand_aliases
	alias adb="$windows_adb"
	alias fastboot="$windows_fastboot"
fi
#####################
### end of config ###
#####################


########################################
### operational values - do not edit ###
########################################
current_slot=""
SCRIPT="$(realpath $0)"
SCRIPTPATH="$(dirname $SCRIPT)"
###############################################
### end of operational values - do not edit ###
###############################################


############
### main ###
############
# check if all of the scripts are there
clone_error="please git clone https://github.com/ArtiomSu/RogPhone2Flasher.git"

[ ! -f $SCRIPTPATH/scripts/helper_functions.sh ] && echo $clone_error && exit 1
source $SCRIPTPATH/scripts/helper_functions.sh

[ ! -f $SCRIPTPATH/scripts/rebooting_functions.sh ] && echo $clone_error && exit 1
source $SCRIPTPATH/scripts/rebooting_functions.sh

[ ! -f $SCRIPTPATH/scripts/flashing_functions.sh ] && echo $clone_error && exit 1
source $SCRIPTPATH/scripts/flashing_functions.sh

[ ! -f $SCRIPTPATH/scripts/menus.sh ] && echo $clone_error && exit 1
source $SCRIPTPATH/scripts/menus.sh

[ ! -f $SCRIPTPATH/scripts/backup_functions.sh ] && echo $clone_error && exit 1
source $SCRIPTPATH/scripts/backup_functions.sh

[ ! -f $SCRIPTPATH/scripts/multi_rom.sh ] && echo $clone_error && exit 1
source $SCRIPTPATH/scripts/multi_rom.sh

[ ! -f $SCRIPTPATH/scripts/colours.sh ] && echo $clone_error && exit 1
source $SCRIPTPATH/scripts/colours.sh
#now lets check to see if these folders and files exist
check_if_folders_and_files_are_ok
#run main menu
menu 
###################
### end of main ###
###################


