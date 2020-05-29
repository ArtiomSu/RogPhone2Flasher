flash_menu(){
	echo ""
	echo "     #############################################"
	echo "      ###########################################"
	echo "      #                                         #"
	echo "      #        Asus Rog Phone 2 Flasher V0.9    #"
	echo "      #        By                               #"
	echo "      #        Terminal_Heat_Sink               #"
	echo "      #                                         #"
	echo "      #        Video guide:                     #"
	echo "      #        https://youtu.be/-M_MJUzCuvM     #"
	echo "      #                                         #"
	echo -e "      #        ${colour_LightPurple}Flashing Menu${colour_NC}                    #"
	echo "      #                                         #"
	echo "      ###########################################"
	echo "      ###########                     ###########"
	echo "       #########                       ######### "
	echo "        #######                         #######  "
	echo "     #############                   #############"
	echo ""
	PS3="$(header) Flashing Menu: "
	options=( "flash magisk" "flash kernel" "flash twrp for android 9" "flash twrp and magisk for android 9" "flash twrp for android 10" "flash twrp and magisk for android 10" "flash_everything_including_magisk_and_kernel" "flash_everything_and_magisk" "flash_all_roms" "go back")
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
			"flash twrp and magisk for android 9")
				confirm "Do you want to flash twrp and magisk for android 9? [y/N]" && menu_flash_twrp_magisk_for_android_9
				;;
			"flash twrp for android 10")
				confirm "Do you want to flash twrp for android 10? [y/N]" && menu_flash_twrp_for_android_10
				;;	
			"flash twrp and magisk for android 10")
				confirm "Do you want to flash twrp and magisk for android 10? [y/N]" && menu_flash_twrp_magisk_for_android_10
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

backup_menu(){
	echo ""
	echo "     #############################################"
	echo "      ###########################################"
	echo "      #                                         #"
	echo "      #        Asus Rog Phone 2 Flasher V0.9    #"
	echo "      #        By                               #"
	echo "      #        Terminal_Heat_Sink               #"
	echo "      #                                         #"
	echo "      #        Video guide:                     #"
	echo "      #        https://youtu.be/-M_MJUzCuvM     #"
	echo "      #                                         #"
	echo -e "      #        ${colour_LightPurple}Backup Menu${colour_NC}                      #"
	echo "      #                                         #"
	echo "      ###########################################"
	echo "      ###########                     ###########"
	echo "       #########                       ######### "
	echo "        #######                         #######  "
	echo "     #############                   #############"
	echo ""
	PS3="$(header) Backup Menu: "
	options=( "reboot to twrp" "backup havoc data" "backup stock data" "backup omni data" "restore havoc data" "restore stock data" "restore omni data" "go back")
	select opt in "${options[@]}"
	do
	    case $opt in
	    	"reboot to twrp")
				reboot_to_twrp
				;;
			"backup havoc data")
				backup_data_havoc
				;;
			"backup stock data")
				backup_data_stock
				;;	
			"backup omni data")
				backup_data_omni
				;;
			"restore havoc data")
				restore_data_havoc
				;;
			"restore stock data")
				restore_data_stock
				;;		
			"restore omni data")
				restore_data_omni
				;;											
	        "go back")
	            break
	            ;;
	        *) 
				echo "invalid option $REPLY"
				;;
	    esac
	    echo ""
	    PS3="$(header) Backup Menu: "
	done
}

multi_rom_a10_havoc_menu(){
	PS3="$(header) Multi rom stock/havoc: "
	options=( "reboot to fastboot" "flash stock and havoc roms" "switch to stock rom" "switch to stock rom for the first time" "switch to havoc rom" "wipe data if you have twrp installed (if you dont have a backup to restore)" "wipe data if you dont have twrp installed (if you dont have a backup to restore)" "go back")
	select opt in "${options[@]}"
	do
	    case $opt in
	    	"reboot to fastboot")
				reboot_fastboot
				;;	
			"flash stock and havoc roms")
				prepare_stock_a10_and_havoc
				;;
	    	"switch to stock rom")
				stock_a10_and_havoc_reboot_to_stock
				;;
			"switch to stock rom for the first time")
				stock_a10_reboot_to_stock_first_time
				;;	
	    	"switch to havoc rom")
				stock_a10_and_havoc_reboot_to_havoc
				;;
	    	"wipe data if you have twrp installed (if you dont have a backup to restore)")
				confirm "this will basically reboot into twrp and wipe data [y,n]" || return 0
				twrp_wipe_data
				;;	
	    	"wipe data if you dont have twrp installed (if you dont have a backup to restore)")
				confirm "this will boot into twrp using the boot.img this is handy since stock doesnt have twrp preinstalled continue? [y,n]"
				twrp_wipe_data_by_boot_android_10
				;;															
	        "go back")
	            break
	            ;;
	        *) 
				echo "invalid option $REPLY"
				;;
	    esac
	    echo ""
	    PS3="$(header) Multi rom stock/havoc: "
	done
}

multi_rom_a10_omni_menu(){
	PS3="$(header) Multi rom stock/havoc: "
	options=( "reboot to fastboot" "flash stock and omni rom" "switch to stock rom" "switch to stock rom for the first time" "switch to omni rom" "wipe data if you have twrp installed (if you dont have a backup to restore)" "wipe data if you dont have twrp installed (if you dont have a backup to restore)" "go back")
	select opt in "${options[@]}"
	do
	    case $opt in
	    	"reboot to fastboot")
				reboot_fastboot
				;;	
			"flash stock and omni rom")
				prepare_stock_a10_and_omni
				;;
	    	"switch to stock rom")
				stock_a10_and_omni_reboot_to_stock
				;;
			"switch to stock rom for the first time")
				stock_a10_reboot_to_stock_first_time
				;;	
	    	"switch to omni rom")
				stock_a10_and_omni_reboot_to_omni
				;;
	    	"wipe data if you have twrp installed (if you dont have a backup to restore)")
				confirm "this will basically reboot into twrp and wipe data [y,n]" || return 0
				twrp_wipe_data
				;;	
	    	"wipe data if you dont have twrp installed (if you dont have a backup to restore)")
				confirm "this will boot into twrp using the boot.img this is handy since stock doesnt have twrp preinstalled continue? [y,n]"
				twrp_wipe_data_by_boot_android_10
				;;															
	        "go back")
	            break
	            ;;
	        *) 
				echo "invalid option $REPLY"
				;;
	    esac
	    echo ""
	    PS3="$(header) Multi rom stock/havoc: "
	done
}

multi_rom_menu(){
	echo ""
	echo "     #############################################"
	echo "      ###########################################"
	echo "      #                                         #"
	echo "      #        Asus Rog Phone 2 Flasher V0.9    #"
	echo "      #        By                               #"
	echo "      #        Terminal_Heat_Sink               #"
	echo "      #                                         #"
	echo "      #        Video guide:                     #"
	echo "      #        https://youtu.be/-M_MJUzCuvM     #"
	echo "      #                                         #"
	echo -e "      #        ${colour_LightPurple}Multi Rom Menu${colour_NC}                   #"
	echo "      #                                         #"
	echo "      ###########################################"
	echo "      ###########                     ###########"
	echo "       #########                       ######### "
	echo "        #######                         #######  "
	echo "     #############                   #############"
	echo ""
	echo -e "${colour_BLINK}      ###########################################"
	echo "      #                                         #"
	echo "      #        WARNING THIS CAN BRICK YOUR      #"
	echo "      #        PHONE IF YOU ARE NOT SURE        #"
	echo "      #        WHAT YOU ARE DOING               #"
	echo "      #                                         #"
	echo "      #        FOR CONVENIENCE STOCK ROM IS     #"
	echo "      #        INSTALLED TO SLOT A              #"
	echo "      #                                         #"
	echo -e "      ###########################################${colour_NC}"
	echo ""
	confirm "Are you sure you want to proceed? [y,n]" || return 0
	PS3="$(header) Multi rom: "
	options=( "reboot to fastboot" "Stock android 10 / Havoc" "Stock android 10 / Omni" "Stock android 9 / Havoc" "Stock android 9 / Omni" "Havoc / Omni" "go back")
	select opt in "${options[@]}"
	do
	    case $opt in
	    	"reboot to fastboot")
				reboot_fastboot
				;;	
			"Stock android 10 / Havoc")
				multi_rom_a10_havoc_menu
				;;	
			"Stock android 9 / Havoc")
				echo "coming soon"
				;;
			"Stock android 10 / Omni")
				multi_rom_a10_omni_menu
				;;
			"Stock android 9 / Omni")
				echo "coming soon"
				;;
			"Havoc / Omni")
				echo "coming soon"
				;;			
	        "go back")
	            break
	            ;;
	        *) 
				echo "invalid option $REPLY"
				;;
	    esac
	    echo ""
	    PS3="$(header) Multi rom: "
	done
}

menu (){
	echo ""
	echo "     #############################################"
	echo "      ###########################################"
	echo "      #                                         #"
	echo "      #        Asus Rog Phone 2 Flasher V0.9    #"
	echo "      #        By                               #"
	echo "      #        Terminal_Heat_Sink               #"
	echo "      #                                         #"
	echo "      #        Video guide:                     #"
	echo "      #        https://youtu.be/-M_MJUzCuvM     #"
	echo "      #                                         #"
	echo -e "      #        ${colour_LightPurple}Main Menu${colour_NC}                        #"
	echo "      #                                         #"
	echo "      ###########################################"
	echo "      ###########                     ###########"
	echo "       #########                       ######### "
	echo "        #######                         #######  "
	echo "     #############                   #############"
	echo ""
	PS3="$(header) Main Menu: "
	options=( "reboot to OS" "reboot to fastboot" "reboot to twrp" "switch slots" "flashing Menu" "Backup Menu" "Multi rom" "Quit / Ctrl+C")
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
				update_current_slot
	    		echo "current slot is $current_slot"
	    		confirm "Do you want to switch to the other slot? [y/N]" && swap_slot	
	    		;;
	    	"flashing Menu")
				flash_menu
				;;
			"Backup Menu")
				backup_menu
				;;
			"Multi rom")
				multi_rom_menu
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
