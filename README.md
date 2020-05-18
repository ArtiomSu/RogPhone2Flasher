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

### if using windows
if you are using windows you will also need to edit
```
scripts_folder=""
asus_images_folder=""
havoc_images_folder=""
```
after `if [ ! -z $windowscheck ]` this is just because my windows environment uses a different path structure therefore you can run the script on linux and windows without changing anything since when the script detects a windows environment it will switch to the latter.


You will also need to change the following if using windows
```
windows_adb=""
windows_fastboot=""
```
This is because we will be running the adb.exe and fastboot.exe from ubuntu so set these to wherever you have adb and fastboot on your windows installations. It is possible to use adb and fastboot linux binaries however there is a missmatch of version numbers which takes time to resolve therefore my solution of simply runnning windows binaries is easier for the average user.

## Run
When running the script (`./RogPhone2Flasher.sh`) you will be presented with a menu
```
     #############################################
      ###########################################
      #                                         #
      #        Asus Rog Phone 2 Flasher V0.2    #
      #        By                               #
      #        Terminal_Heat_Sink               #
      #                                         #
      #        Video guide:                     #
      #        https://youtu.be/-M_MJUzCuvM     #
      #                                         #
      #        Main Menu                        #
      #                                         #
      ###########################################
      ###########                     ###########
       #########                       #########
        #######                         #######
     #############                   #############

1) reboot to OS        3) reboot to twrp      5) flashing Menu
2) reboot to fastboot  4) switch slots        6) Quit / Ctrl+C
```

## updates

### v0.1

initial release

### v0.2
```
- added support for windows through linux subsystem for windows ( use ubuntu 18.04 lts ( 20.04 has issues with sleep command not working) )
- added seperate menu for flashing as it was getting hard to breathe
```

## bugs and feature requests
[Telegram Group](https://t.me/Terminal_Heat_Sink_Group)
[Telegram direct chat](https://t.me/Terminal_Heat_Sink)
