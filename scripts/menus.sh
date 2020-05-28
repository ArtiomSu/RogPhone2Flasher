flash_menu(){
	echo ""
	echo "     #############################################"
	echo "      ###########################################"
	echo "      #                                         #"
	echo "      #        Asus Rog Phone 2 Flasher V0.2    #"
	echo "      #        By                               #"
	echo "      #        Terminal_Heat_Sink               #"
	echo "      #                                         #"
	echo "      #        Video guide:                     #"
	echo "      #        https://youtu.be/-M_MJUzCuvM     #"
	echo "      #                                         #"
	echo "      #        Flashing Menu                    #"
	echo "      #                                         #"
	echo "      ###########################################"
	echo "      ###########                     ###########"
	echo "       #########                       ######### "
	echo "        #######                         #######  "
	echo "     #############                   #############"
	echo ""
	PS3="$(header) Flashing Menu: "
	options=( "flash magisk" "flash kernel" "flash twrp for android 9" "flash twrp for android 10" "flash_everything_including_magisk_and_kernel" "flash_everything_and_magisk" "flash_all_roms" "go back")
	select opt in "${options[@]}"
	do
	    case $opt in
	    	"flash magisk")
				confirm "Do you want to install magisk? [y/N]" && menu_flash_magisk
				;;
			"flash kernel")
				confirm "Do you want to flash a custom kernel? [y/N]" && menu_flash_kernel
				;;
			"flash twrp for android 9")
				confirm "Do you want to flash twrp for android 9? [y/N]" && menu_flash_twrp_for_android_9
				;;
			"flash twrp for android 10")
				confirm "Do you want to flash twrp for android 10? [y/N]" && menu_flash_twrp_for_android_10
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
	        "go back")
	            break
	            ;;
	        *) 
				echo "invalid option $REPLY"
				;;
	    esac
	    echo ""
	    PS3="$(header) Flashing Menu: "
	done
}

menu (){
	echo ""
	echo "     #############################################"
	echo "      ###########################################"
	echo "      #                                         #"
	echo "      #        Asus Rog Phone 2 Flasher V0.2    #"
	echo "      #        By                               #"
	echo "      #        Terminal_Heat_Sink               #"
	echo "      #                                         #"
	echo "      #        Video guide:                     #"
	echo "      #        https://youtu.be/-M_MJUzCuvM     #"
	echo "      #                                         #"
	echo "      #        Main Menu                        #"
	echo "      #                                         #"
	echo "      ###########################################"
	echo "      ###########                     ###########"
	echo "       #########                       ######### "
	echo "        #######                         #######  "
	echo "     #############                   #############"
	echo ""
	PS3="$(header) Main Menu: "
	options=( "reboot to OS" "reboot to fastboot" "reboot to twrp" "switch slots" "flashing Menu" "Quit / Ctrl+C")
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
	    	"flashing Menu")
				flash_menu
				;;
	        "Quit / Ctrl+C")
	            break
	            ;;
	        *) 
				echo "invalid option $REPLY"
				;;
	    esac
	    echo ""
	    PS3="$(header) Main Menu: "
	done
}
