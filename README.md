# RogPhone2Flasher

I made this script to easily update custom roms on the Asus Rog Phone 2.

Normally to update a custom rom fully you need to flash the stock rom twice and then flash the custom rom.

With this script you technically only flash once since it flashed all of the images to both slots in one go, therefore updating is faster since we dont need to flash the same image twice. 

For example the system image of stock rom will be overwritten by the system image of custom rom so there is no point in wasting time flashing stock system image.


## To use this script please watch my video guide

[![guide](https://img.youtube.com/vi/-M_MJUzCuvM/0.jpg)](https://www.youtube.com/watch?v=-M_MJUzCuvM)


## Setup
You will need to use [Payload Dumper](https://github.com/vm03/payload_dumper) to extract the images


edit the config options in the script to suite your own folder locations
```
magisk_name=""
kernel_name=""
scripts_folder=""
asus_images_folder=""
havoc_images_folder=""
```

## Run
When running the script (`./RogPhone2Flasher.sh`) you will be presented with a menu
```
     #############################################
      ###########################################
      #                                         #
      #        Asus Rog Phone 2 Flasher V0.1    #
      #        By                               #
      #        Terminal_Heat_Sink               #
      #                                         #
      #        Video guide:                     #
      #        https://youtu.be/-M_MJUzCuvM     #
      #                                         #
      ###########################################
      ###########                     ###########
       #########                       ######### 
        #######                         #######  
     #############                   #############

1) reboot to OS	       4) switch slots	  7) flash_everything_including_magisk_and_kernel  10) Quit / Ctrl+C
2) reboot to fastboot	 5) flash magisk	  8) flash_everything_and_magisk
3) reboot to twrp		 6) flash kernel	  9) flash_all_roms
```

## bugs and feature requests
[Telegram Group](https://t.me/Terminal_Heat_Sink_Group)
[Telegram direct chat](https://t.me/Terminal_Heat_Sink)
