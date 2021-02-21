#!/bin/bash
#
# ©2021 Copyright 2021 Robert D. Chin
# Email: RDevChin@Gmail.com
#
# Usage: bash filename_tagger.sh
#        (not sh filename_tagger.sh)
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program. If not, see <https://www.gnu.org/licenses/>.
#
# +--------------------------------------------------------------------------+
# |                                                                          |
# |                 Customize Menu choice options below.                     |
# |                                                                          |
# +--------------------------------------------------------------------------+
#
# Format: <#@@> <Menu Option> <#@@> <Description of Menu Option> <#@@> <Corresponding function or action or cammand>
#
#@@Exit#@@Exit this menu.#@@break
#
#@@Tag#@@Add tags to file names.#@@f_tagger^$GUI^$TARGET_DIR
#
#@@Untag#@@Delete tags to file names.#@@f_untagger^$GUI^$TARGET_DIR
#
#@@About#@@Version information of this script.#@@f_about^$GUI
#
#@@Code History#@@Display code change history of this script.#@@f_code_history^$GUI
#
#@@Version Update#@@Check for updates to this script and download.#@@f_check_version^$GUI
#
#@@Help#@@Display help message.#@@f_help_message^$GUI
#
# +----------------------------------------+
# |        Default Variable Values         |
# +----------------------------------------+
#
VERSION="2021-02-21 18:46"
THIS_FILE="$0"
TEMP_FILE=$THIS_FILE"_temp.txt"
GENERATED_FILE=$THIS_FILE"_menu_generated.lib"
#
#
#================================================================
# EDIT THE LINES BELOW TO SET REPOSITORY SERVERS AND DIRECTORIES
# AND TO INCLUDE ALL DEPENDENT SCRIPTS AND LIBRARIES TO DOWNLOAD.
#================================================================
#
#
#-------------------------------------------------
# Set variables to check for network connectivity.
#-------------------------------------------------
#
# Ping Local File Server Repository
# PING_LAN_TARGET="[FILE SERVER NAME]"
PING_LAN_TARGET="scotty"
#
# Ping Web File Server Repository
# PING_WAN_TARGET="[WEB FILE REPOSITORY]"
PING_WAN_TARGET="raw.githubusercontent.com"
#
#--------------------------------------------------------------
# Set variables to mount the Local Repository to a mount-point.
#--------------------------------------------------------------
#
# LAN File Server shared directory.
SERVER_DIR="//scotty/files"
#
# Local PC mount-point directory.
MP_DIR="/mnt/scotty/files"
#
# Local PC target directory, sub-directory below mount-point directory.
# TARGET_DIR="[ LOCAL MOUNT-POINT DIRECTORY/REPOSITORY SUB-DIRECTORY PATH GOES HERE ]"
TARGET_DIR="/mnt/scotty/files/LIBRARY/PC-stuff/PC-software/BASH_Scripting_Projects/Repository"
#
#
#=================================================================
# EDIT THE LINES BELOW TO SPECIFY THE FILE NAMES TO UPDATE.
# FILE NAMES INCLUDE ALL DEPENDENT SCRIPTS LIBRARIES.
#=================================================================
#
#
# --------------------------------------------
# Create a list of all dependent library files
# and write to temporary file, FILE_LIST.
# --------------------------------------------
#
# Temporary file FILE_LIST contains a list of file names of dependent
# scripts and libraries.
# Format: [File Name]^[Local/
#
FILE_LIST=$THIS_FILE"_file_temp.txt"
#
# Format: [File Name]^[Local/Web]^[Local repository directory]^[web repository directory]
echo "$THIS_FILE^Local^/mnt/scotty/files/LIBRARY/PC-stuff/PC-software/BASH_Scripting_Projects/Repository"           > $FILE_LIST
echo "common_bash_function.lib^Web^/mnt/scotty/files/LIBRARY/PC-stuff/PC-software/BASH_Scripting_Projects/Repository^https://raw.githubusercontent.com/rdchin/BASH_function_library/master/" >> $FILE_LIST
#
# Create a list of files FILE_DL_LIST, which need to be downloaded.

# From FILE_LIST (list of script and library files), find the files which
# need to be downloaded and put those file names in FILE_DL_LIST.
#
FILE_DL_LIST=$THIS_FILE"_file_dl_temp.txt"
# Format: [File Name]^[Local/Web]^[Local repository directory]^[web repository directory]
#
# +----------------------------------------+
# |            Brief Description           |
# +----------------------------------------+
#
#& Brief Description
#&
#& This script will insert tag names into the beginning of file names.
#& The list of tag names may be edited or appended in the Main program
#& according to the general topic or subject matter.
#& 
#& The tag names initially chosen for this script are on PC software and
#& hardware topics.
#&
#& Required scripts: filename_tagger.sh, common_bash_function.lib.
#&
#& Usage: bash filename_tagger.sh [ target directory ]
#&        (not sh filename_tagger.sh)
#&
#&    This program is free software: you can redistribute it and/or modify
#&    it under the terms of the GNU General Public License as published by
#&    the Free Software Foundation, either version 3 of the License, or
#&    (at your option) any later version.
#&
#&
#&    This program is distributed in the hope that it will be useful,
#&    but WITHOUT ANY WARRANTY; without even the implied warranty of
#&    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#&    GNU General Public License for more details.
#&
#&    You should have received a copy of the GNU General Public License
#&    along with this program. If not, see <https://www.gnu.org/licenses/>.
#
# +----------------------------------------+
# |             Help and Usage             |
# +----------------------------------------+
#
#?    Usage: bash filename_tagger.sh [OPTION(S)]
#?
#? Examples:
#?
#?                                   Force display to use a different UI.
#? bash filename_tagger.sh [TARGET DIRECTORY] [USER-INTERFACE]
#? bash filename_tagger.sh [TARGET DIRECTORY] text       Use Cmd-line UI.
#?                                            dialog     Use Dialog   UI.
#?                                            whiptail   Use Whiptail UI.
#?
#? bash filename_tagger.sh --help     Displays this help message.
#?                         -?
#?
#? bash filename_tagger.sh --about    Displays script version.
#?                         --version
#?                         --ver
#?                         -v
#?
#? bash filename_tagger.sh --update   Update script.
#?                         -u
#?
#? bash filename_tagger.sh --history  Displays script code history.
#?                         --hist
#
# +----------------------------------------+
# |           Code Change History          |
# +----------------------------------------+
#
## Code Notes
##
## To disable the [ OPTION ] --update -u to update the script:
##    1) Comment out the call to function fdl_download_missing_scripts in
##       Section "Start of Main Program".
##
## To completely delete the [ OPTION ] --update -u to update the script:
##    1) Delete the call to function fdl_download_missing_scripts in
##       Section "Start of Main Program".
##    2) Delete all functions beginning with "f_dl"
##    3) Delete instructions to update script in Section "Help and Usage".
##
## To disable the Main Menu:
##    1) Comment out the call to function f_menu_main under "Run Main Code"
##       in Section "Start of Main Program".
##    2) Add calls to desired functions under "Run Main Code"
##       in Section "Start of Main Program".
##
## To completely remove the Main Menu and its code:
##    1) Delete the call to function f_menu_main under "Run Main Code" in
##       Section "Start of Main Program".
##    2) Add calls to desired functions under "Run Main Code"
##       in Section "Start of Main Program".
##    3) Delete the function f_menu_main.
##    4) Delete "Menu Choice Options" in example_library.lib located under
##       Section "Customize Menu choice options below".
##       The "Menu Choice Options" lines begin with "#@@".
##
## Code Change History
##
## (After each edit made, please update Code History and VERSION.)
##
## 2021-02-21 *fdl_download_missing_scripts added to modulize existing code
##             under Section "Main Program" to allow easier deletion of code
##             the "Update Version" feature is not desired.
##            *Functions related to "Update Version" renamed with an "fdl"
##             prefix to identify dependent functions to delete if that
##             function is not desired.
##            *Section "Code Change History" added instructions on how to
##             disable/delete "Update Version" feature or "Main Menu".
##
## 2021-02-13 *Changed menu item wording from "Exit to command-line" prompt.
##                                         to "Exit this menu."
##
## 2021-02-09 *Updated to latest standards.
##
## 2021-02-08 *Updated to latest standards.
##
## 2020-11-22 Initial Release. Decided to use menu dependent on Library.
##
## 2020-11-21 *Beta Release. TO DO 2 arguments and version updating.
##
## 2020-11-18 *Alpha Release. Crude working code.
##
## 2020-11-12 *Start researching how to do it and coding.
# +------------------------------------+
# |     Function f_display_common      |
# +------------------------------------+
#
#     Rev: 2021-01-30
#  Inputs: $1=GUI - "text", "dialog" or "whiptail" the preferred user-interface.
#          $2=Delimiter of text to be displayed.
#          $3="NOK", "OK", or null [OPTIONAL] to control display of "OK" button.
#          $4=Pause $4 seconds [OPTIONAL]. If "NOK" then pause to allow text to be read.
#          THIS_DIR, THIS_FILE, VERSION.
#    Uses: X.
# Outputs: None.
#
# PLEASE NOTE: RENAME THIS FUNCTION WITHOUT SUFFIX "_TEMPLATE" AND COPY
#              THIS FUNCTION INTO ANY SCRIPT WHICH DEPENDS ON THE
#              LIBRARY FILE "common_bash_function.lib".
#
f_display_common () {
      #
      # Specify $THIS_FILE name of the file containing the text to be displayed.
      # $THIS_FILE may be re-defined inadvertently when a library file defines it
      # so when the command, source [ LIBRARY_FILE.lib ] is used, $THIS_FILE is
      # redefined to the name of the library file, LIBRARY_FILE.lib.
      # For that reason, all library files now have the line
      # THIS_FILE="[LIBRARY_FILE.lib]" deleted.
      #
      #
      #================================================================================
      # EDIT THE LINE BELOW TO DEFINE $THIS_FILE AS THE ACTUAL FILE NAME WHERE THE
      # ABOUT, CODE HISTORY, AND HELP MESSAGE TEXT IS LOCATED.
      #================================================================================
      #
      #
                                      #
      THIS_FILE="filename_tagger.sh"  # <<<--- INSERT ACTUAL FILE NAME HERE.
                                      #
      TEMP_FILE=$THIS_DIR/$THIS_FILE"_temp.txt"
      #
      # Set $VERSION according as it is set in the beginning of $THIS_FILE.
      X=$(grep --max-count=1 "VERSION" $THIS_FILE)
      # X="VERSION=YYYY-MM-DD HH:MM"
      # Use command "eval" to set $VERSION.
      eval $X
      #
      echo "Script: $THIS_FILE. Version: $VERSION" > $TEMP_FILE
      echo >>$TEMP_FILE
      #
      # Display text (all lines beginning ("^") with $2 but do not print $2).
      # sed substitutes null for $2 at the beginning of each line
      # so it is not printed.
      sed --silent "s/$2//p" $THIS_DIR/$THIS_FILE >> $TEMP_FILE
      #
      case $3 in
           "NOK" | "nok")
              f_message $1 "NOK" "Message" $TEMP_FILE $4
           ;;
           *)
              f_message $1 "OK" "(use arrow keys to scroll up/down/side-ways)" $TEMP_FILE
           ;;
      esac
      #
} # End of function f_display_common.
#
# +----------------------------------------+
# |        Function f_check_version        |
# +----------------------------------------+
#
#     Rev: 2021-02-08
#  Inputs: $1=GUI - "dialog" or "whiptail" The CLI GUI application in use.
#    Uses: SERVER_DIR, MP_DIR, TARGET_DIR, TARGET_FILE, VERSION, TEMP_FILE, ERROR.
# Outputs: $1=GUI.
#          $2=Samba File server Directory
#          $3=Local Mount Point (Directory)
#          $4=File server Target Directory.
#          $5=File server File Name to compare.
#          $6=Version of file to compare. String$
#          $7=Temporary file name with list of files to be upgraded.
#          ERROR
#
# PLEASE NOTE: RENAME THIS FUNCTION WITHOUT SUFFIX "_TEMPLATE" AND COPY
#              THIS FUNCTION INTO ANY SCRIPT WHICH DEPENDS ON THE
#              LIBRARY FILE "common_bash_function.lib".
#
# Synopsis: Check version $6 of $5 local file with version of repository file.
#           If the repository file has latest version, then copy all 
#           dependent files and libraries from the repository to local PC. 
#
f_check_version () {
      #
      #
      #=================================================================
      # EDIT THE LINES BELOW TO DEFINE THE LAN FILE SERVER DIRECTORY AND
      # SHARED MOUNTPOINT DIRECTORY, LOCAL TARGET DIRECTORY AND FILE. 
      #=================================================================
      #
      #
      # LAN File Server shared directory.
      SERVER_DIR="//scotty/files"
      #
      # Local PC mount-point directory.
      MP_DIR="/mnt/scotty/files"
      #
      # Local PC target directory, sub-directory below mount-point directory.
      TARGET_DIR="/mnt/scotty/files/LIBRARY/PC-stuff/PC-software/BASH_Scripting_Projects/Repository"
      #
      # Local PC file within TARGET_DIR.
      FILE_TO_COMPARE="filename_tagger.sh"
      #
      # Version of TARGET_FILE.
      VERSION=$(grep --max-count=1 "VERSION" $FILE_TO_COMPARE)
      #
      FILE_LIST=$THIS_DIR/$THIS_FILE"_file_temp.txt"
      ERROR=0
      #
      #
      #=================================================================
      # EDIT THE LINES BELOW TO SPECIFY THE FILE NAMES TO UPDATE.
      # FILE NAMES INCLUDE ALL DEPENDENT SCRIPTS LIBRARIES.
      #=================================================================
      #
      #
      # Create list of files to update and write to temporary file, FILE_LIST.
      #
      echo "filename_tagger" > $FILE_LIST  # <<<--- INSERT ACTUAL FILE NAME HERE.
      echo "common_bash_function.lib^Web^/mnt/scotty/files/LIBRARY/PC-stuff/PC-software/BASH_Scripting_Projects/Repository^https://raw.githubusercontent.com/rdchin/BASH_function_library/master/" >> $FILE_LIST
      #
      f_version_compare $1 $SERVER_DIR $MP_DIR $TARGET_DIR $FILE_TO_COMPARE "$VERSION" $FILE_LIST
      #
      if [ -r  $FILE_LIST ] ; then
         rm  $FILE_LIST
      fi
      #
}  # End of function f_check_version.
#
# +----------------------------------------+
# |          Function f_menu_main          |
# +----------------------------------------+
#
#     Rev: 2021-01-30
#  Inputs: $1=GUI.
#    Uses: ARRAY_FILE, GENERATED_FILE, MENU_TITLE.
# Outputs: None.
#
# PLEASE NOTE: RENAME THIS FUNCTION WITHOUT SUFFIX "_TEMPLATE" AND COPY
#              THIS FUNCTION INTO THE MAIN SCRIPT WHICH WILL CALL IT.
#
f_menu_main () { # Create and display the Main Menu.
      #
      #
      #================================================================================
      # EDIT THE LINE BELOW TO DEFINE $THIS_FILE AS THE ACTUAL FILE NAME WHERE THE
      # ABOUT, CODE HISTORY, AND HELP MESSAGE TEXT IS LOCATED.
      #================================================================================
      #
      #
                                      #
      THIS_FILE="filename_tagger.sh"  # <<<--- INSERT ACTUAL FILE NAME HERE.
                                      #
      GENERATED_FILE=$THIS_DIR/$THIS_FILE"_menu_main_generated.lib"
      #
      # Does this file have menu items in the comment lines starting with "#@@"?
      grep --silent ^\#@@ $THIS_DIR/$THIS_FILE
      ERROR=$?
      # exit code 0 - menu items in this file.
      #           1 - no menu items in this file.
      #               file name of file containing menu items must be specified.
      if [ $ERROR -eq 0 ] ; then
         # Extract menu items from this file and insert them into the Generated file.
         # This is required because f_menu_arrays cannot read this file directly without
         # going into an infinite loop.
         grep ^\#@@ $THIS_DIR/$THIS_FILE >$GENERATED_FILE
         #
         # Specify file name with menu item data.
         ARRAY_FILE="$GENERATED_FILE"
      else
         #
         #
         #================================================================================
         # EDIT THE LINE BELOW TO DEFINE $ARRAY_FILE AS THE ACTUAL FILE NAME (LIBRARY)
         # WHERE THE MENU ITEM DATA IS LOCATED. THE LINES OF DATA ARE PREFIXED BY "#@@".
         #================================================================================
         #
         #
         # Specify library file name with menu item data.
         # ARRAY_FILE="[FILENAME_GOES_HERE]"
         ARRAY_FILE="$THIS_DIR/$THIS_FILE"
      fi
      #
      # Create arrays from data.
      f_menu_arrays $ARRAY_FILE
      #
      # Calculate longest line length to find maximum menu width
      # for Dialog or Whiptail using lengths calculated by f_menu_arrays.
      let MAX_LENGTH=$MAX_CHOICE_LENGTH+$MAX_SUMMARY_LENGTH
      #
      # Create generated menu script from array data.
      #
      # Note: ***If Menu title contains spaces,
      #       ***the size of the menu window will be too narrow.
      #
      # Menu title MUST use underscores instead of spaces.
      MENU_TITLE="CLI_Action_Menu"  # Menu title must substitute underscores for spaces
      TEMP_FILE=$THIS_DIR/$THIS_FILE"_menu_main_temp.txt"
      #
      f_create_show_menu $1 $GENERATED_FILE $MENU_TITLE $MAX_LENGTH $MAX_LINES $MAX_CHOICE_LENGTH $TEMP_FILE
      #
      if [ -r $GENERATED_FILE ] ; then
         rm $GENERATED_FILE
      fi
      #
      if [ -r $TEMP_FILE ] ; then
         rm $TEMP_FILE
      fi
      #
} # End of function f_menu_main.
#
# +----------------------------------------+
# |       Function fdl_choose_dl_source      |
# +----------------------------------------+
#
#     Rev: 2020-10-22
#  Inputs: $1="Web" or "Local".
#          $2=file to download.
# Outputs: ANS.
#
fdl_choose_dl_source () {
      #
      DL_FILE=$(echo $DL_LINE | awk -F "^" '{ print $1 }')
      DL_SOURCE=$(echo $DL_LINE | awk -F "^" '{ print $2 }')
      # Format [File name]^[Local/Web]
      DL_LINE=$(echo $DL_LINE | awk -F "^" '{ print $1"^"$2}')
      #
      fdl_choose_download_source $DL_SOURCE $DL_FILE
      # Insert ANS into FILE_DL_LIST.
      # Substitute DL_LINE_NEW for DL_LINE.
      # ANS [Local/Web] is the project's download choice for all project files.
      # ANS will over-write any existing value [Local/Web] for each project file.
      # Substitute ANS for existing value whether "Local" or "Web".
      DL_LINE_NEW=${DL_LINE/$DL_FILE^Local/$DL_FILE^$ANS}
      DL_LINE_NEW=${DL_LINE/$DL_FILE^Web/$DL_FILE^$ANS}
      #
      # Change or substitute new ANS or download choice into download file list.
      sed -i "s/$DL_LINE/$DL_LINE_NEW/" $FILE_DL_LIST
      #
} # End of function fdl_choose_dl_source.
#
# +----------------------------------------+
# |    Function fdl_choose_download_source   |
# +----------------------------------------+
#
#     Rev: 2020-10-22
#  Inputs: $1="Web" or "Local".
#          $2=file to download.
# Outputs: ANS.
#
fdl_choose_download_source () {
      #
      # Is $1 specified or "local"?
      ANS=""
      if [ $1 != "Local" ] ; then
         while [ "$ANS" = "" ]
               do
                  echo
                  echo "Do you want to download the file: $2"
                  echo -n "from the web repository? (W)eb or the local repository (L)ocal ($1):" ; read ANS
                  case $ANS in
                       [Ww])
                          ANS="Web"
                       ;;
                       [Ll] | "")
                          ANS="Local"
                       ;;
                       *)
                          ANS="$1"
                       ;;
                  esac
               done
      else
         # If "Local" download source, do not give a choice, use Local Repository for download.
         ANS="Local"
      fi
      #
} # End of function fdl_choose_download_source.
#
# +----------------------------------------+
# |      fdl_dwnld_library_from_web_site     |
# +----------------------------------------+
#
#     Rev: 2021-01-30
#  Inputs: $1=GitHub Repository
#          $2=file name to download.
#          $3=ERROR.
#    Uses: None.
# Outputs: None.
#
# PLEASE NOTE: RENAME THIS FUNCTION WITHOUT SUFFIX "_TEMPLATE" AND COPY
#              THIS FUNCTION INTO ANY SCRIPT WHICH DEPENDS ON THE
#              LIBRARY FILE "common_bash_function.lib".
#
fdl_dwnld_library_from_web_site () {
      #
      ERROR=$3
      #
      if [ $ERROR -eq 0 ] ; then
         # $1 ends with a slash "/" so can append $2 immediately after $1.
         wget --show-progress $1$2
         ERROR=$?
         if [ $ERROR -ne 0 ] ; then
            echo
            echo "!!! wget download failed !!!"
            echo "from GitHub.com for file: $2"
            echo
            echo "Cannot continue, exiting program script."
            sleep 3
            exit 1  # Exit with error.
         fi
         #
         # Make downloaded file executable.
         chmod 755 $2
         #
         echo
         echo ">>> Please run program again after download. <<<"
         echo
         # Delay to read messages on screen.
         echo -n "Press \"Enter\" key to continue" ; read X
         #
      fi
      #
} # End of function fdl_dwnld_library_from_web_site.
#
# +------------------------------------------+
# |   fdl_dwnld_library_from_local_repository  |
# +------------------------------------------+
#
#     Rev: 2021-01-30
#  Inputs: $1=Local Repository Directory.
#          $2=File to download.
#          $3=ERROR.
#    Uses: TEMP_FILE, SMBUSER, PASSWORD, ERROR.
# Outputs: TEMP_FILE.
#
# This is used to download any file with a text-only UI.
# This can be used to download the Common Function Library.
# Used to download any file before the Common Library is even downloaded.
#
fdl_dwnld_library_from_local_repository () {
      #
      ERROR=$3
      #
      if [ $ERROR -eq 0 ] ; then
         eval cp -p $1/$2 .
         ERROR=$?
         #
         if [ $ERROR -ne 0 ] ; then
            echo
            echo -e "Error occurred\nError copying $2."
            sleep 2
            ERROR=1
         else
            # Make file executable (useable).
            chmod +x $2
            #
            if [ -x $2 ] ; then
               # File is good.
               ERROR=0
            else
               echo
               echo "File Error"
               echo -e "$2 is missing or file is not executable.\n\nCannot continue, exiting program script."
               sleep 3
               ERROR=1
            fi
         fi
      fi
      #
      if [ $ERROR -ne 0 ] ; then
         echo
         echo -e "Error occurred\nError copying $2."
      else
         echo
         echo -e "Successful Update of $2 to latest version.\n\nScript must be re-started to use the latest version."
         echo "____________________________________________________"
      fi
      #
} # End of function fdl_dwnld_library_from_local_repository.
#
# +------------------------------------------+
# |               fdl_mount_local              |
# +------------------------------------------+
#
#     Rev: 2021-01-30
#  Inputs: $1=Server Directory.
#          $2=Local Mount Point Directory
#          TEMP_FILE
#    Uses: TARGET_DIR, UPDATE_FILE, ERROR.
# Outputs: ERROR.
#
fdl_mount_local () {
      #
      # Mount local repository on mount-point.
      mountpoint $2 >/dev/null 2>$TEMP_FILE # Write any error messages to file $TEMP_FILE. Get status of mountpoint, mounted?.
      ERROR=$?
      if [ $ERROR -ne 0 ] ; then
         # Mount directory.
         echo
         read -p "Enter user name: " SMBUSER
         echo
         read -s -p "Enter Password: " PASSWORD
         echo
         sudo mount -t cifs -o username="$SMBUSER" -o password="$PASSWORD" $1 $2
         mountpoint $2 >/dev/null 2>$TEMP_FILE # Write any error messages to file $TEMP_FILE. Get status of mountpoint, mounted?.
         ERROR=$?
         if [ $ERROR -ne 0 ] ; then
            echo
            echo "Mount failure"
            echo
            echo "Directory mount-point $2 is not mounted."
            echo
            echo -e "Mount using Samba failed. Are \"samba\" and \"cifs-utils\" installed?"
            echo
            echo -e "Press \"Enter\" key to continue."
         fi
         unset SMBUSER PASSWORD
      fi
      #
} # End of function fdl_mount_local.
#
# +----------------------------------------+
# |             Function f_source          |
# +----------------------------------------+
#
#     Rev: 2020-10-22
#  Inputs: $1=File name to source.
# Outputs: ANS.
#
f_source () {
      #
      if [ -x "$1" ] ; then
         # If $1 is a library, then source it.
         case $1 in
              common_bash_function.lib)
                 source $1
              ;;
              *.lib)
                 source $1
              ;;
         esac
      fi
      #
} # End of function f_source.
#
# +----------------------------------------+
# |    Function f_select_target_directory  |
# +----------------------------------------+
#
#  Inputs: $1=GUI
#    Uses: TEMP_FILE, ANS, ERROR, SCRIPT_LIST.
# Outputs: TARGET_DIR.
#
f_select_target_directory () {
      #
      # Get the screen resolution or X-window size.
      # Get rows (height).
      YSCREEN=$(stty size | awk '{ print $1 }')
      # Get columns (width).
      XSCREEN=$(stty size | awk '{ print $2 }')
      #
      case $1 in
           dialog)
              #
              # Dialog needs about 6 more lines for the header and [OK] button.
              let Y=$YSCREEN-16
              # If number of lines exceeds screen/window height then set textbox height.
              #
              # Dialog needs about 10 more spaces for the right and left window frame. 
              let X=$XSCREEN-10
              #
              TARGET_DIR=$($1 --stdout --title "Use <tab>, <up/down arrows> and <spacebar> to select a directory." --backtitle "Please choose a directory" --cancel-label "Exit" --fselect $THIS_DIR $Y $X)
              ERROR=$?
              #
           ;;
           whiptail)
              # User-input via "inputbox" free-form TARGET_DIR name entry.
              $1 --title "User-entered Directory" --cancel-button "Exit" --inputbox "Enter Target Directory name:" 8 70 2>$TEMP_FILE
              ERROR=$?
              TARGET_DIR=$(cat $TEMP_FILE)
              #
           ;;
           text)
              ERROR=0
              echo "Enter Target Directory Name"
              echo
              echo -n "Enter Target Directory name: "
              read TARGET_DIR
              if [ -z "$TARGET_DIR" ] ; then
                 # Force exit script.
                 ERROR=1
              fi
           ;;
      esac
      #
      if [ $ERROR -eq 1 ] ; then
         #f_exit_script $1
         return 1  # Return to Main Menu.
      fi
      #
} # End of function f_project_process_user_files
#
# +----------------------------------------+
# |             Function f_tagger          |
# +----------------------------------------+
#
#     Rev: 2020-11-22
#  Inputs: $1=GUI - "text", "dialog" or "whiptail" the preferred user-interface.
#          $2=Target Directory.
# Outputs: ANS.
#
f_tagger () {
      #
      unset TARGET_DIR
      #
      # If there is no target directory specified, ask for directory.
      TARGET_DIR=$2
      #
      if [ -z $TARGET_DIR ] ; then
         f_select_target_directory $1
      fi
      #
      if [ $ERROR -eq 1 ] ; then
         return 1  # Return to Main Menu.
      fi
      #
      # Create list of files.
      ls $TARGET_DIR > $TEMP_FILE
      #
      # Create diagnostic log file of output.
      #TEMP_FILE2=$THIS_FILE"_OUTPUT_temp.txt  # Diagnostic line.
      #
      # Exclude shell script filenames *.sh by deleting them from $TEMP_FILE.
      sed -i '/\.sh$/d' $TEMP_FILE
      #
      # Exclude filenames *.tar by deleting them from $TEMP_FILE.
      sed -i '/\.tar$/d' $TEMP_FILE
      #
      # Exclude filenames*.gz by deleting them from $TEMP_FILE.
      sed -i '/\.gz$/d' $TEMP_FILE
      #
      # Exclude filenames*.zip by deleting them from $TEMP_FILE.
      sed -i '/\.zip$/d' $TEMP_FILE
      #
      # Exclude filenames *.deb by deleting them from $TEMP_FILE.
      sed -i '/\.deb$/d' $TEMP_FILE
      #
      # Status indicator.
      clear
      echo -n "Script: filename_tagger.sh tagging file names in directory $TARGET_DIR "
      #
      # Read file name.
      while read FILE
            do
               # Wait indicator elipses.
               echo -n "."
               # Are there existing tags?
               # Yes, strip tags from file name.
               if [[ $FILE == *--TAGS--* ]] ; then
                  # Strip tags.
                  FILE_NO_TAGS=$(echo $TARGET_DIR$FILE | sed --regexp-extended 's/.*--TAGS--//')
               else
                 FILE_NO_TAGS=$FILE
               fi
               #
               # The code lines below are not used but here for reference.
               # Extract file name extension.
               #FILE_EXT=${FILE_NAME_NO_TAGS##*.}
               #
               # Extract base file name.
               #FILE_NAME_BASE=${FILE_NAME_NO_TAGS%.*}
               # End of unused code.
               #
               # Convert $FILE to upper-case to compare words with $TAG (upper-case).
               FILE_UPPERCASE=$(echo $FILE_NO_TAGS | sed 's/./\U&/g') 
               #
               NEWTAG=""
               #
               #
               #================================================================================
               # EDIT THE LINE BELOW WHICH IS A LIST OF TAG NAMES TO PREFIX THE FILE NAMES. 
               # NEW FILE NAME FORMAT: $TAG"--TAG--"[FILE NAME].
               #================================================================================
               #
               #
               for TAG in ADAPTER ADDRESS APT APT-GET ARRAY AWK BACKUP BASH BLUETOOTH BOOTING CLI CLIENT CLOUD COMMAND COMMAND_LINE COMPRESS COMPRESSION CONKY CONSOLE CONTAINER CONVERSION COPY CPU CRON DEBIAN DESKTOP DHCP DIALOG DIRECTORIES DIRECTORY DISKS DISTRO DNS DROPBOX EMACS ENCRYPT EXT4 FAT32 FEDORA FINANCE FIREWALL FLASH GAME GIT GNOME GUIDE HACKS HARDWARE HELP HISTORY HOW-TO HOWTO IMAGE INSTALL INTERNET JOB KDE LIBREOFFICE LINUX LINUX_MINT MAN_PAGE MEMORY MICROSOFT MONITOR MOUNT MUSIC NAS NETWORK NEWBIES NTFS OPEN_SOURCE PACKAGE PARTITION PASSWORD PIM PLAYERS PORTS PRIVACY PRIVATE PYTHON RAID RASPBERRY REFERENCE REMOTE RENAME REPLACE ROUTER RSYNC SCREEN SCRIPT SEARCH SECURITY SED SERVER SHARE SHELL SHUTDOWN SQL SSH SUDO SYNC SYSADMIN SYSTEM TERMINAL TIPS TOOLS TUTORIAL UBUNTU UNMOUNT UPDATE USB UTILITIES UTILITY VIM VIRTUAL VIRTUALBOX VIRUS WEB WHIPTAIL WIFI ZFS
                   do 
                      # Does the file name include the existing tag?
                      if [[ $FILE_UPPERCASE == *$TAG* ]] ; then
                         # Yes, write tag to prefix.
                         if [ -z $NEWTAG ] ; then
                            NEWTAG=$TAG
                         else
                            NEWTAG=$NEWTAG"_"$TAG             
                         fi
                      fi
                      # Get next tag.
                  done
                 #
               # End of tag list?
               #
               #echo "---------------------------------"  # Diagnostic line.
               #echo $FILE_UPPERCASE                      # Diagnostic line.
               #echo "NEWTAG=$NEWTAG"                     # Diagnostic line.
               #
               if [ -z $NEWTAG ] ; then
                  # No matching tags so do not change file name.
                  NEW_FILE_NAME=$FILE_NO_TAGS
               else
                  # Append tag prefix to file name.
                  NEW_FILE_NAME=$NEWTAG"--TAGS--"$FILE_NO_TAGS
               fi
               #
               # Rename file with tag names.
               if [ "$NEW_FILE_NAME" != "$FILE" ] ; then
                  #echo >>$TEMP_FILE2  # Diagnostic line.
                  #echo "---------------------------------" >>$TEMP_FILE2  # Diagnostic line.
                  #echo "ORIG=$TARGET_DIR$FILE"          >>$TEMP_FILE2  # Diagnostic line.
                  #echo "NEW =$TARGET_DIR$NEW_FILE_NAME" >>$TEMP_FILE2  # Diagnostic line.
                  mv $TARGET_DIR$FILE $TARGET_DIR$NEW_FILE_NAME
               fi
               # End of file name list?
               # No, get next file name.
            done < $TEMP_FILE
            #
            unset TARGET_DIR
            #
} # End of function f_tagger.
#
# +----------------------------------------+
# |            Function f_untagger         |
# +----------------------------------------+
#
#     Rev: 2020-11-22
#  Inputs: $1=GUI - "text", "dialog" or "whiptail" the preferred user-interface.
#          $2=Target Directory.
# Outputs: ANS.
#
f_untagger () {
      #
      unset TARGET_DIR
      #
      # If there is no target directory specified, ask for directory.
      TARGET_DIR=$2
      #
      if [ -z $TARGET_DIR ] ;
       then
         f_select_target_directory $1
      fi
      #
      if [ $ERROR -eq 1 ] ; then
         return 1  # Return to Main Menu.
      fi
      #
      # Create list of files.
      ls $TARGET_DIR > $TEMP_FILE
      #
      # Create diagnostic log file of output.
      #TEMP_FILE2=$THIS_FILE"_OUTPUT_temp.txt  # Diagnostic line.
      #
      # Status indicator.
      clear
      echo -n "Script: filename_tagger.sh tagging file names in directory $TARGET_DIR "
      #
      # Read file name.
      while read FILE
            do
               # Wait indicator elipses.
               echo -n "."
               # Are there existing tags?
               # Yes, strip tags from file name.
               if [[ $FILE == *--TAGS--* ]] ; then
                  # Strip tags.
                  FILE_NO_TAGS=$(echo $TARGET_DIR$FILE | sed --regexp-extended 's/.*--TAGS--//')
               else
                 FILE_NO_TAGS=$FILE
               fi
               #
               # The code lines below are not used but here for reference.
               # Extract file name extension.
               #FILE_EXT=${FILE_NAME_NO_TAGS##*.}
               #
               # Extract base file name.
               #FILE_NAME_BASE=${FILE_NAME_NO_TAGS%.*}
               # End of unused code.
               #
               # Remove all tags from file name.
               NEW_FILE_NAME=$FILE_NO_TAGS  # Diagnostic line.
               #
               # Rename file with tag names.
               if [ "$NEW_FILE_NAME" != "$FILE" ] ; then
                  #echo >>$TEMP_FILE2  # Diagnostic line.
                  #echo "---------------------------------" >>$TEMP_FILE2  # Diagnostic line.
                  #echo "ORIG=$TARGET_DIR$FILE"          >>$TEMP_FILE2  # Diagnostic line.
                  #echo "NEW =$TARGET_DIR$NEW_FILE_NAME" >>$TEMP_FILE2  # Diagnostic line.
                  mv $TARGET_DIR$FILE $TARGET_DIR$NEW_FILE_NAME
               fi
               # End of file name list?
               # No, get next file name.
            done < $TEMP_FILE
            #
} # End of function f_untagger.
#
# **************************************
# **************************************
# ***     Start of Main Program      ***
# **************************************
# **************************************
#     Rev: 2021-01-30
#
if [ -e $TEMP_FILE ] ; then
   rm $TEMP_FILE
fi
#
clear  # Blank the screen.
#
echo "Running script $THIS_FILE"
echo "***   Rev. $VERSION   ***"
echo
sleep 1  # pause for 1 second automatically.
#
clear # Blank the screen.
#
# ****************************************************
# Create new list of files that need to be downloaded.
# ****************************************************
#
#----------------------------------------------------------------
# Variables FILE_LIST and FILE_DL_LIST are defined in the section
# "Default Variable Values" at the beginning of this script.
#----------------------------------------------------------------
#
# Delete any existing temp file.
if [ -r  $FILE_DL_LIST ] ; then
   rm  $FILE_DL_LIST
fi
#
while read LINE
      do
         FILE=$(echo $LINE | awk -F "^" '{ print $1 }')
         if [ ! -x $FILE ] ; then
            # File needs to be downloaded or is not executable
            chmod +x $FILE 2>$TEMP_FILE # Write any error messages to file $TEMP_FILE.
            ERROR=$?
            if [ $ERROR -ne 0 ] ; then
               # File needs to be downloaded. Add file name to a file list in a text file.
               # Build list of files to download.
               echo $LINE >> $FILE_DL_LIST
            fi
         fi
      done < $FILE_LIST
#
# If there are files to download (listed in FILE_DL_LIST), then mount local repository.
if [ -s "$FILE_DL_LIST" ] ; then
   echo
   echo "There are missing file dependencies which must be downloaded from"
   echo "the local repository or web repository."
   echo
   echo "Missing files:"
   while read LINE
         do
            echo $LINE | awk -F "^" '{ print $1 }'
         done < $FILE_DL_LIST
   echo
   echo "You will need to present credentials."
   echo
   echo -n "Press '"Enter"' key to continue." ; read X ; unset X
   #
   # **************************************************
   # Select Download Source of Common Function Library.
   # **************************************************
   #
   #----------------------------------------
   # Get the download source of the Library.
   #----------------------------------------
   #
   DL_LINE=$(grep common_bash_function.lib $FILE_DL_LIST)
   #
   # If Library is in the download file list, then choose download source.
   if [ -n "$DL_LINE" ] ; then
      fdl_choose_dl_source $DL_LINE
   fi
   #
   # **************************************************
   # Select Download Source of Dependent Project Files.
   # **************************************************
   # Set download source for all dependent files/libraries using the same source
   # used by this file ($THIS_FILE).
   #
   #------------------------------------------
   # Get the download source for this project.
   #------------------------------------------
   # Grep $FILE_LIST not $FILE_DL_LIST to get the download source for this project.
   #
   DL_LINE=$(grep $THIS_FILE $FILE_LIST)
   #
   # If this file ($THIS_FILE) is in the download file list, then choose download source.
   if [ -n "$DL_LINE" ] ; then
      fdl_choose_dl_source $DL_LINE
   fi
   #
   #-----------------------------------------------------------------------
   # Set the download source for all the dependent files to the same source
   # used by this file ($THIS_FILE).
   #-----------------------------------------------------------------------
   # Change or substitute the new download choice for each project file
   # in the download file list.
   #
   # Get download choice for this project and save as DL_SOURCE.
   DL_LINE=$(grep $THIS_FILE $FILE_LIST)
   #
   while read LINE
         do
            DL_FILE=$(echo $LINE | awk -F "^" '{ print $1 }')
            DL_SOURCE=$(echo $DL_LINE | awk -F "^" '{ print $2 }')
            # Format [File name]^[Local/Web]
            DL_LINE=$(echo $LINE | awk -F "^" '{ print $1"^"$2}')
            # All other files, substitute DL_LINE_NEW for LINE.
            # DL_SOURCE [Local/Web] is the project's download choice for all project files.
            # DL_SOURCE will over-write any existing value [Local/Web] for each project file.
            # Substitute DL_SOURCE for existing value whether "Local" or "Web".
            DL_LINE_NEW=${DL_LINE/$DL_FILE^Local/$DL_FILE^$DL_SOURCE}
            DL_LINE_NEW=${DL_LINE/$DL_FILE^Web/$DL_FILE^$DL_SOURCE}
            sed -i "s/$DL_LINE/$DL_LINE_NEW/" $FILE_DL_LIST
         done < $FILE_DL_LIST
   #
   #--------------------------------------------------------------------------------------
   # Check if there is a LAN (Local network) connection before mounting local mount-point.
   #--------------------------------------------------------------------------------------
   #
   # Initialize Error Flag.
   ERROR_LAN=0
   #
   grep --silent "Local" $FILE_DL_LIST
   ERROR=$?
   # exit code 0 - menu items in this file.
   #           1 - no menu items in this file.
   #               file name of file containing menu items must be specified.
   #
   if [ $ERROR -eq 0 ] ; then
      #
      # Check if there is an LAN connection before doing a download.
      #
      #-----------------------------------------------------------
      # Variable PING_LAN_TARGET is defined in the section
      # "Default Variable Values" at the beginning of this script.
      #-----------------------------------------------------------
      #
      # Ping local file server.
      ping -c 1 -q $PING_LAN_TARGET >/dev/null # Ping server address.
      ERROR=$?
      #
      if [ $ERROR -ne 0 ] ; then
         echo -e "\n\nPing Test Network Connection\n\nNo network connection to local file server."
         ERROR_LAN=1
      else
         echo -e "\n\nPing Test Network Connection\n\nNetwork connnection to local file server is good."
         ERROR_LAN=0
         #
         #-------------------------------------------------
         # LAN connection is OK so mount local mount-point.
         #-------------------------------------------------
         #
         #-----------------------------------------------------------
         # Variables SERVER_DIR and MP_DIR are defined in the section
         # "Default Variable Values" at the beginning of this script.
         #-----------------------------------------------------------
         #
         # Mount the Local Repository to the mount-point.
         fdl_mount_local $SERVER_DIR $MP_DIR
         #
      fi
   fi
   #
   #------------------------------------------------------------------
   # Check if there is a WAN (Web) connection before doing a download.
   #------------------------------------------------------------------
   #
   # Initialize Error Flag.
   ERROR_WAN=0
   #
   grep --silent "Web" $FILE_DL_LIST
   ERROR=$?
   # exit code 0 - menu items in this file.
   #           1 - no menu items in this file.
   #               file name of file containing menu items must be specified.
   if [ $ERROR -eq 0 ] ; then
      #
      # Check if there is an LAN connection before doing a download.
      #
      #-----------------------------------------------------------
      # Variable PING_WAN_TARGET is defined in the section
      # "Default Variable Values" at the beginning of this script.
      #-----------------------------------------------------------
      #
      ping -c 1 -q $PING_WAN_TARGET >/dev/null # Ping server address.
      ERROR=$?
      #
      if [ $ERROR -ne 0 ] ; then
         echo -e "\n\nPing Test Network Connection\n\nNo network connection to Web server."
         ERROR_WAN=1
      else
         echo -e "\n\nPing Test Network Connection\n\nNetwork connnection to Web server is good."
         ERROR_WAN=0
      fi
   fi
   #
   #----------------------------------------------------------------------------------------
   # Select alternative download source if no network connection to primary download source.
   #----------------------------------------------------------------------------------------
   #
   # If Local connection failed, switch to Web file server download.
   if [ $ERROR_LAN -eq 1 ] ; then
      # Format [File name]^[Local/Web]
      sed -i "s/^Local^/^Web^/" $FILE_DL_LIST
   fi
   #
   # If Web connection failed, switch to Local file server download.
   if [ $ERROR_WAN -eq 1 ] ; then
      # Format [File name]^[Local/Web]
      sed -i "s/^Web^/^Local^/" $FILE_DL_LIST
   fi
   #
   #----------------------------------------------------------------------------------------------
   # From list of files to download created above $FILE_DL_LIST, download the files one at a time.
   #----------------------------------------------------------------------------------------------
   #
   while read LINE
         do
            # Get Download Source for each file.
            DL_FILE=$(echo $LINE | awk -F "^" '{ print $1 }')
            DL_SOURCE=$(echo $LINE | awk -F "^" '{ print $2 }')
            TARGET_DIR=$(echo $LINE | awk -F "^" '{ print $3 }')
            DL_REPOSITORY=$(echo $LINE | awk -F "^" '{ print $4 }')
            #
            # Initialize Error Flag.
            ERROR=0
            #
            # If a file only found in the Local Repository has source changed
            # to "Web" because LAN connectivity has failed, then do not download.
            if [ -z DL_REPOSITORY ] && [ $DL_SOURCE = "Web" ] ; then
               ERROR=1
            fi
            #
            case $DL_SOURCE in
                 Local)
                    fdl_dwnld_library_from_local_repository $TARGET_DIR $DL_FILE $ERROR
                 ;;
                 Web)
                    fdl_dwnld_library_from_web_site $DL_REPOSITORY $DL_FILE $ERROR
                 ;;
            esac
            #
         done < $FILE_DL_LIST
   #
   # Delete temporary files.
   if [ -e $TEMP_FILE ] ; then
      rm $TEMP_FILE
   fi
   #
   if [ -r  $FILE_LIST ] ; then
      rm  $FILE_LIST
   fi
   #
   if [ -r  $FILE_DL_LIST ] ; then
      rm  $FILE_DL_LIST
   fi
   #
   echo
   echo ">>> Please run program again after download. <<<"
   echo
   echo "Cannot continue, exiting program script."
   sleep 3
   exit 1  # Exit script after downloading dependent files and libraries.
   #
fi
#
# Source each library.
#
while read LINE
      do
         FILE=$(echo $LINE | awk -F "^" '{ print $1 }')
         # Invoke any library files.
         f_source $FILE
      done < $FILE_LIST
#
#***************************************************************
# Process Any Optional Arguments and Set Variables THIS_DIR, GUI
#***************************************************************
#
# Set THIS_DIR, SCRIPT_PATH to directory path of script.
f_script_path
#
# Set Temporary file using $THIS_DIR from f_script_path.
TEMP_FILE=$THIS_DIR/$THIS_FILE"_temp.txt"
#
# Test for Optional Arguments.
# Also sets variable GUI.
f_arguments $1 $2
#
# If command already specifies GUI, then do not detect GUI.
# i.e. "bash filename_tagger.sh dialog" or "bash filename_tagger.sh text".
if [ -z $GUI ] ; then
   # Test for GUI (Whiptail or Dialog) or pure text environment.
   f_detect_ui
fi
#
# Final Check of Environment
#GUI="whiptail"  # Diagnostic line.
#GUI="dialog"    # Diagnostic line.
#GUI="text"      # Diagnostic line.
#
# Delete temporary files.
if [ -r  $FILE_LIST ] ; then
   rm  $FILE_LIST
fi
#
if [ -r  $FILE_DL_LIST ] ; then
   rm  $FILE_DL_LIST
fi
#
# Test for X-Windows environment. Cannot run in CLI for LibreOffice.
# if [ x$DISPLAY = x ] ; then
#    f_message text "OK" "\Z1\ZbCannot run LibreOffice without an X-Windows environment.\ni.e. LibreOffice must run in a terminal emulator in an X-Window.\Zn"
# fi
#
# Test for BASH environment.
f_test_environment $1
#
# If an error occurs, the f_abort() function will be called.
# trap 'f_abort' 0
# set -e
#
#********************************
# Show Brief Description message.
#********************************
#
f_about $GUI "NOK" 1
#
#***************
# Run Main Code.
#***************
#
f_menu_main $GUI
#
# Delete temporary files.
#
if [ -e $TEMP_FILE ] ; then
   rm $TEMP_FILE
fi
#
if [ -e  $FILE_LIST ] ; then
   rm  $FILE_LIST
fi
#
if [ -e  $FILE_DL_LIST ] ; then
   rm  $FILE_DL_LIST
fi
#
# Nicer ending especially if you chose custom colors for this script.
# Blank the screen.
clear
#
exit 0  # This cleanly closes the process generated by #!bin/bash.
        # Otherwise every time this script is run, another instance of
        # process /bin/bash is created using up resources.
        #
# All dun dun noodles.
