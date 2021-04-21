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
VERSION="2021-03-12 15:56"
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
#--------------------------------------------------------------
# Set variables to mount the Local Repository to a mount-point.
#--------------------------------------------------------------
#
# LAN File Server shared directory.
# SERVER_DIR="[FILE_SERVER_DIRECTORY_NAME_GOES_HERE]"
  SERVER_DIR="//scotty/files"
#
# Local PC mount-point directory.
# MP_DIR="[LOCAL_MOUNT-POINT_DIRECTORY_NAME_GOES_HERE]"
  MP_DIR="/mnt/scotty/files"
#
# Local PC mount-point with LAN File Server Local Repository full directory path.
# Example: 
#                   File server shared directory is "//file_server/public".
# Repostory directory under the shared directory is "scripts/BASH/Repository".
#                 Local PC Mount-point directory is "/mnt/file_server/public".
#
# LOCAL_REPO_DIR="$MP_DIR/[DIRECTORY_PATH_TO_LOCAL_REPOSITORY]"
  LOCAL_REPO_DIR="$MP_DIR/LIBRARY/PC-stuff/PC-software/BASH_Scripting_Projects/Repository"
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
#
FILE_LIST=$THIS_FILE"_file_temp.txt"
#
# Format: [File Name]^[Local/Web]^[Local repository directory]^[web repository directory]
echo "common_bash_function.lib^Local^$LOCAL_REPO_DIR^https://raw.githubusercontent.com/rdchin/BASH_function_library/master/" >> $FILE_LIST
#
# Create a name for a temporary file which will have a list of files which need to be downloaded.
FILE_DL_LIST=$THIS_FILE"_file_dl_temp.txt"
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
# |                Code Notes              |
# +----------------------------------------+
#
# To disable the [ OPTION ] --update -u to update the script:
#    1) Comment out the call to function fdl_download_missing_scripts in
#       Section "Start of Main Program".
#
# To completely delete the [ OPTION ] --update -u to update the script:
#    1) Delete the call to function fdl_download_missing_scripts in
#       Section "Start of Main Program".
#    2) Delete all functions beginning with "f_dl"
#    3) Delete instructions to update script in Section "Help and Usage".
#
# To disable the Main Menu:
#    1) Comment out the call to function f_menu_main under "Run Main Code"
#       in Section "Start of Main Program".
#    2) Add calls to desired functions under "Run Main Code"
#       in Section "Start of Main Program".
#
# To completely remove the Main Menu and its code:
#    1) Delete the call to function f_menu_main under "Run Main Code" in
#       Section "Start of Main Program".
#    2) Add calls to desired functions under "Run Main Code"
#       in Section "Start of Main Program".
#    3) Delete the function f_menu_main.
#    4) Delete "Menu Choice Options" in this script located under
#       Section "Customize Menu choice options below".
#       The "Menu Choice Options" lines begin with "#@@".
#
# +----------------------------------------+
# |           Code Change History          |
# +----------------------------------------+
#
## Code Change History
##
## (After each edit made, please update Code History and VERSION.)
##
## 2021-03-12 *Updated to latest standards and improved comments.
##            *fdl_download_missing_scripts added 2 arguments for file names
##             as arguments.
##
## 2021-02-21 *fdl_download_missing_scripts added to modulize existing code
##             under Section "Main Program" to allow easier deletion of code
##             the "Update Version" feature is not desired.
##            *Functions related to "Update Version" renamed with an "fdl"
##             prefix to identify dependent functions to delete if that
##             function is not desired.
##            *Section "Code Change History" added instructions on how to
##             disable/delete "Update Version" feature or "Main Menu".
##            *f_check_version fixed bad file name in FILE_LIST.
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
#
# +------------------------------------+
# |     Function f_display_common      |
# +------------------------------------+
#
#     Rev: 2021-03-31
#  Inputs: $1=UI - "text", "dialog" or "whiptail" the preferred user-interface.
#          $2=Delimiter of text to be displayed.
#          $3="NOK", "OK", or null [OPTIONAL] to control display of "OK" button.
#          $4=Pause $4 seconds [OPTIONAL]. If "NOK" then pause to allow text to be read.
#          THIS_DIR, THIS_FILE, VERSION.
#    Uses: X.
# Outputs: None.
#
# Synopsis: Display lines of text beginning with a given comment delimiter.
#
# Dependencies: f_message.
#
f_display_common () {
      #
      # Set $THIS_FILE to the file name containing the text to be displayed.
      #
      # WARNING: Do not define $THIS_FILE within a library script.
      #
      # This prevents $THIS_FILE being inadvertently re-defined and set to
      # the file name of the library when the command:
      # "source [ LIBRARY_FILE.lib ]" is used.
      #
      # For that reason, all library files now have the line
      # THIS_FILE="[LIBRARY_FILE.lib]" commented out or deleted.
      #
      #
      #==================================================================
      # EDIT THE LINE BELOW TO DEFINE $THIS_FILE AS THE ACTUAL FILE NAME
      # CONTAINING THE BRIEF DESCRIPTION, CODE HISTORY, AND HELP MESSAGE.
      #==================================================================
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
      sed -n "s/$2//"p $THIS_DIR/$THIS_FILE >> $TEMP_FILE
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
# |          Function f_menu_main          |
# +----------------------------------------+
#
#     Rev: 2021-03-07
#  Inputs: $1 - "text", "dialog" or "whiptail" the preferred user-interface.
#    Uses: ARRAY_FILE, GENERATED_FILE, MENU_TITLE.
# Outputs: None.
#
# Summary: Display Main-Menu.
#          This Main Menu function checks its script for the Main Menu
#          options delimited by "#@@" and if it does not find any, then
#          it it defaults to the specified library script.
#
# Dependencies: f_menu_arrays, f_create_show_menu.
#
f_menu_main () { # Create and display the Main Menu.
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
           ARRAY_FILE="$THIS_DIR/filename_tagger.lib"
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
      MENU_TITLE="Tagger_Menu"
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
# |  Function fdl_dwnld_file_from_web_site |
# +----------------------------------------+
#
#     Rev: 2021-03-08
#  Inputs: $1=GitHub Repository
#          $2=file name to download.
#    Uses: None.
# Outputs: None.
#
# Summary: Download a list of file names from a web site.
#          Cannot be dependent on "common_bash_function.lib" as this library
#          may not yet be available and may need to be downloaded.
#
# Dependencies: wget.
#
#
fdl_dwnld_file_from_web_site () {
      #
      # $1 ends with a slash "/" so can append $2 immediately after $1.
      echo
      echo ">>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<"
      echo ">>> Download file from Web Repository <<<"
      echo ">>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<"
      echo
      wget --show-progress $1$2
      ERROR=$?
      if [ $ERROR -ne 0 ] ; then
            echo
            echo ">>>>>>>>>>>>>><<<<<<<<<<<<<<"
            echo ">>> wget download failed <<<"
            echo ">>>>>>>>>>>>>><<<<<<<<<<<<<<"
            echo
            echo "Error copying from Web Repository file: \"$2.\""
            echo
      else
         # Make file executable (useable).
         chmod +x $2
         #
         if [ -x $2 ] ; then
            # File is good.
            ERROR=0
         else
            echo
            echo ">>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<"
            echo ">>> File Error after download from Web Repository <<<"
            echo ">>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<"
            echo
            echo "$2 is missing or file is not executable."
            echo
         fi
      fi
      #
      # Make downloaded file executable.
      chmod 755 $2
      #
} # End of function fdl_dwnld_file_from_web_site.
#
# +-----------------------------------------------+
# | Function fdl_dwnld_file_from_local_repository |
# +-----------------------------------------------+
#
#     Rev: 2021-03-08
#  Inputs: $1=Local Repository Directory.
#          $2=File to download.
#    Uses: TEMP_FILE.
# Outputs: ERROR.
#
# Summary: Copy a file from the local repository on the LAN file server.
#          Cannot be dependent on "common_bash_function.lib" as this library
#          may not yet be available and may need to be downloaded.
#
# Dependencies: None.
#
fdl_dwnld_file_from_local_repository () {
      #
      echo
      echo ">>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<"
      echo ">>> File Copy from Local Repository <<<"
      echo ">>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<"
      echo
      eval cp -p $1/$2 .
      ERROR=$?
      #
      if [ $ERROR -ne 0 ] ; then
         echo
         echo ">>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<"
         echo ">>> File Copy Error from Local Repository <<<"
         echo ">>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<"
         echo
         echo -e "Error copying from Local Repository file: \"$2.\""
         echo
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
            echo ">>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<"
            echo ">>> File Error after copy from Local Repository <<<"
            echo ">>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<"
            echo
            echo -e "File \"$2\" is missing or file is not executable."
            echo
            ERROR=1
         fi
      fi
      #
      if [ $ERROR -eq 0 ] ; then
         echo
         echo -e "Successful Update of file \"$2\" to latest version.\n\nScript must be re-started to use the latest version."
         echo "____________________________________________________"
      fi
      #
} # End of function fdl_dwnld_file_from_local_repository.
#
# +-------------------------------------+
# |       Function fdl_mount_local      |
# +-------------------------------------+
#
#     Rev: 2021-03-10
#  Inputs: $1=Server Directory.
#          $2=Local Mount Point Directory
#          TEMP_FILE
#    Uses: TARGET_DIR, UPDATE_FILE, ERROR, SMBUSER, PASSWORD.
# Outputs: ERROR.
#
# Summary: Mount directory using Samba and CIFS and echo error message.
#          Cannot be dependent on "common_bash_function.lib" as this library
#          may not yet be available and may need to be downloaded.
#
# Dependencies: Software package "cifs-utils" in the Distro's Repository.
#
fdl_mount_local () {
      #
      # Mount local repository on mount-point.
      mountpoint $2 >/dev/null 2>$TEMP_FILE # Write any error messages to file $TEMP_FILE. Get status of mountpoint, mounted?.
      ERROR=$?
      if [ $ERROR -ne 0 ] ; then
         # Mount directory.
         # Cannot use any user prompted read answers if this function is in a loop where file is a loop input.
         # The read statements will be treated as the next null parameters in the loop without user input.
         # To solve this problem, specify input from /dev/tty "the keyboard".
         #
         echo
         read -p "Enter user name: " SMBUSER < /dev/tty
         echo
         read -s -p "Enter Password: " PASSWORD < /dev/tty
         echo sudo mount -t cifs $1 $2
         sudo mount -t cifs -o username="$SMBUSER" -o password="$PASSWORD" $1 $2
         mountpoint $2 >/dev/null 2>$TEMP_FILE # Write any error messages to file $TEMP_FILE. Get status of mountpoint, mounted?.
         ERROR=$?
         if [ $ERROR -ne 0 ] ; then
            echo
            echo ">>>>>>>>>><<<<<<<<<<<"
            echo ">>> Mount failure <<<"
            echo ">>>>>>>>>><<<<<<<<<<<"
            echo
            echo -e "Directory mount-point \"$2\" is not mounted."
            echo
            echo -e "Mount using Samba failed. Are \"samba\" and \"cifs-utils\" installed?"
            echo "------------------------------------------------------------------------"
            echo
         fi
         unset SMBUSER PASSWORD
      fi
      #
} # End of function fdl_mount_local.
#
# +------------------------------------+
# |        Function fdl_source         |
# +------------------------------------+
#
#     Rev: 2021-03-10
#  Inputs: $1=File name to source.
# Outputs: ERROR.
#
# Summary: Source the provided library file and echo error message.
#          Cannot be dependent on "common_bash_function.lib" as this library
#          may not yet be available and may need to be downloaded.
#
# Dependencies: None.
#
fdl_source () {
      #
      if [ -x "$1" ] ; then
         # If $1 is a library, then source it.
         case $1 in
              *.lib)
                 source $1
                 ERROR=$?
                 #
                 if [ $ERROR -ne 0 ] ; then
                    echo
                    echo ">>>>>>>>>><<<<<<<<<<<"
                    echo ">>> Library Error <<<"
                    echo ">>>>>>>>>><<<<<<<<<<<"
                    echo
                    echo -e "$1 cannot be sourced using command:\n\"source $1\""
                    echo
                 fi
              ;;
         esac
         #
      fi
      #
} # End of function fdl_source.
#
# +----------------------------------------+
# |  Function fdl_download_missing_scripts |
# +----------------------------------------+
#
#     Rev: 2021-03-11
#  Inputs: $1 - File containing a list of all file dependencies.
#          $2 - File name of generated list of missing file dependencies.
# Outputs: ANS.
#
# Summary: This function can be used when script is first run.
#          It verifies that all dependencies are satisfied. 
#          If any are missing, then any missing required dependencies of
#          scripts and libraries are downloaded from a LAN repository or
#          from a repository on the Internet.
#
#          This function allows this single script to be copied to any
#          directory and then when it is executed or run, it will download
#          automatically all other needed files and libraries, set them to be
#          executable, and source the required libraries.
#          
#          Cannot be dependent on "common_bash_function.lib" as this library
#          may not yet be available and may need to be downloaded.
#
# Dependencies: None.
#
fdl_download_missing_scripts () {
      #
      # Delete any existing temp file.
      if [ -r  $2 ] ; then
         rm  $2
      fi
      #
      # ****************************************************
      # Create new list of files that need to be downloaded.
      # ****************************************************
      #
      # While-loop will read the file names listed in FILE_LIST (list of
      # script and library files) and detect which are missing and need 
      # to be downloaded and then put those file names in FILE_DL_LIST.
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
                     echo $LINE >> $2
                  fi
               fi
            done < $1
      #
      # If there are files to download (listed in FILE_DL_LIST), then mount local repository.
      if [ -s "$2" ] ; then
         echo
         echo "There are missing file dependencies which must be downloaded from"
         echo "the local repository or web repository."
         echo
         echo "Missing files:"
         while read LINE
               do
                  echo $LINE | awk -F "^" '{ print $1 }'
               done < $2
         echo
         echo "You will need to present credentials."
         echo
         echo -n "Press '"Enter"' key to continue." ; read X ; unset X
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
                          # Download from Local Repository on LAN File Server.
                          # Are LAN File Server directories available on Local Mount-point?
                          fdl_mount_local $SERVER_DIR $MP_DIR
                          #
                          if [ $ERROR -ne 0 ] ; then
                             # Failed to mount LAN File Server directory on Local Mount-point.
                             # So download from Web Repository.
                             fdl_dwnld_file_from_web_site $DL_REPOSITORY $DL_FILE
                          else
                             # Sucessful mount of LAN File Server directory. 
                             # Continue with download from Local Repository on LAN File Server.
                             fdl_dwnld_file_from_local_repository $TARGET_DIR $DL_FILE
                             #
                             if [ $ERROR -ne 0 ] ; then
                                # Failed to download from Local Repository on LAN File Server.
                                # So download from Web Repository.
                                fdl_dwnld_file_from_web_site $DL_REPOSITORY $DL_FILE
                             fi
                          fi
                       ;;
                       Web)
                          # Download from Web Repository.
                          fdl_dwnld_file_from_web_site $DL_REPOSITORY $DL_FILE
                          if [ $ERROR -ne 0 ] ; then
                             # Failed so mount LAN File Server directory on Local Mount-point.
                             fdl_mount_local $SERVER_DIR $MP_DIR
                             #
                             if [ $ERROR -eq 0 ] ; then
                                # Successful mount of LAN File Server directory.
                                # Continue with download from Local Repository on LAN File Server.
                                fdl_dwnld_file_from_local_repository $TARGET_DIR $DL_FILE
                             fi
                          fi
                       ;;
                  esac
               done < $2
         #
         if [ $ERROR -ne 0 ] ; then
            echo
            echo
            echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
            echo ">>> Download failed. Cannot continue, exiting program. <<<"
            echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
            echo
         else
            echo
            echo
            echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
            echo ">>> Download is good. Re-run required, exiting program. <<<"
            echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
            echo
         fi
         #
      fi
      #
      # Source each library.
      #
      while read LINE
            do
               FILE=$(echo $LINE | awk -F "^" '{ print $1 }')
               # Invoke any library files.
               fdl_source $FILE
               if [ $ERROR -ne 0 ] ; then
                  echo
                  echo ">>>>>>>>>><<<<<<<<<<<"
                  echo ">>> Library Error <<<"
                  echo ">>>>>>>>>><<<<<<<<<<<"
                  echo
                  echo -e "$1 cannot be sourced using command:\n\"source $1\""
                  echo
               fi
            done < $1
      if [ $ERROR -ne 0 ] ; then
         echo
         echo
         echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
         echo ">>> Invoking Libraries failed. Cannot continue, exiting program. <<<"
         echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
         echo
      fi
      #
} # End of function fdl_download_missing_scripts.
#
# +----------------------------------------+
# |        Function f_check_version        |
# +----------------------------------------+
#
#     Rev: 2021-03-25
#  Inputs: $1 - UI "dialog" or "whiptail" or "text".
#          $2 - [OPTIONAL] File name to compare.
#          FILE_TO_COMPARE.
#    Uses: SERVER_DIR, MP_DIR, TARGET_DIR, TARGET_FILE, VERSION, TEMP_FILE, ERROR.
# Outputs: ERROR.
#
# Summary: Check the version of a single, local file or script,
#          FILE_TO_COMPARE with the version of repository file.
#          If the repository file has latest version, then copy all 
#          dependent files and libraries from the repository to local PC.
#
# TO DO enhancement: If local (LAN) repository is unavailable, then
#          connect to repository on the web if available.
#
# Dependencies: f_version_compare.
#
f_check_version () {
      #
      #
      #=================================================================
      # EDIT THE LINES BELOW TO DEFINE THE LAN FILE SERVER DIRECTORY,
      # LOCAL MOUNTPOINT DIRECTORY, LOCAL REPOSITORY DIRECTORY AND
      # FILE TO COMPARE BETWEEN THE LOCAL PC AND (LAN) LOCAL REPOSITORY.
      #=================================================================
      #
      #
      # LAN File Server shared directory.
      # SERVER_DIR="[FILE_SERVER_DIRECTORY_NAME_GOES_HERE]"
        SERVER_DIR="//scotty/files"
      #
      # Local PC mount-point directory.
      # MP_DIR="[LOCAL_MOUNT-POINT_DIRECTORY_NAME_GOES_HERE]"
        MP_DIR="/mnt/scotty/files"
      #
      # Local PC mount-point with LAN File Server Local Repository full directory path.
      # Example: 
      #                   File server shared directory is "//file_server/public".
      # Repository directory under the shared directory is "scripts/BASH/Repository".
      #                 Local PC Mount-point directory is "/mnt/file_server/public".
      #
      # Local PC mount-point with LAN File Server Local Repository full directory path.
      # LOCAL_REPO_DIR="$MP_DIR/[DIRECTORY_PATH_TO_LOCAL_REPOSITORY]"
        LOCAL_REPO_DIR="$MP_DIR/LIBRARY/PC-stuff/PC-software/BASH_Scripting_Projects/Repository"
      #
      # Local PC file to be compared.
      if [ $# -eq 2 ] ; then
         # There are 2 arguments that have been passed to this function.
         # $2 contains the file name to compare.
         FILE_TO_COMPARE=$2
      else
         # $2 is null, so specify file name.
         if [ -z "$FILE_TO_COMPARE" ] ; then
            # FILE_TO_COMPARE is undefined so specify file name.
            FILE_TO_COMPARE=$(basename $0)
         fi
      fi
      #
      # Version of Local PC file to be compared.
      VERSION=$(grep --max-count=1 "VERSION" $FILE_TO_COMPARE)
      #
      FILE_LIST=$THIS_DIR/$THIS_FILE"_file_temp.txt"
      ERROR=0
      #
      #
      #=================================================================
      # EDIT THE LINES BELOW TO SPECIFY THE FILE NAMES TO UPDATE.
      # FILE NAMES INCLUDE ALL DEPENDENT SCRIPTS AND LIBRARIES.
      #=================================================================
      #
      #
      # Create list of files to update and write to temporary file, FILE_LIST.
      #
      echo "filename_tagger.sh"        > $FILE_LIST  # <<<--- INSERT ACTUAL FILE NAME HERE.
      echo "common_bash_function.lib" >> $FILE_LIST  # <<<--- INSERT ACTUAL FILE NAME HERE.
      #
      f_version_compare $1 $SERVER_DIR $MP_DIR $LOCAL_REPO_DIR $FILE_TO_COMPARE "$VERSION" $FILE_LIST
      #
      if [ -r  $FILE_LIST ] ; then
         rm  $FILE_LIST
      fi
      #
}  # End of function f_check_version.
#
# +----------------------------------------+
# |          Function f_select_dir         |
# +----------------------------------------+
#
#  Inputs: $1=GUI, THIS_DIR.
#          $2=String "[City/Town] Directory"
#          $3=Default parent directory.
#    Uses: TEMP_FILE, ANS, ERROR, SCRIPT_LIST.
# Outputs: ANS (List of selected files), ERROR.
#
# Summary: Prompt user-entered file name.
#
# Dependencies: f_yn_question, f_message.
#
f_select_dir () {
      #
      # Get the screen resolution or X-window size.
      # Get rows (height).
      YSCREEN=$(stty size | awk '{ print $1 }')
      # Get columns (width).
      XSCREEN=$(stty size | awk '{ print $2 }')
      #
      # Reset ERROR for while-loop to work.
      ERROR=0
      #
      # Initialize variables.
      DIR=""
      ANS=""
      #
      # Format string substitute underscores for spaces.
      DIR_STR=$(echo $2 | tr "_" " ")
      #
      case $1 in
           dialog)
              while [ "$ERROR" -eq 0 ]
                    do
                       # Dialog needs about 6 more lines for the header and [OK] button.
                       let Y=$YSCREEN-16
                       # If number of lines exceeds screen/window height then set textbox height.
                       #
                       # Dialog needs about 10 more spaces for the right and left window frame.
                       let X=$XSCREEN-10
                       #
                       DIR=$($1 --stdout --title "Use <tab>, <up/down arrows> and <spacebar> to select a $DIR_STR." --backtitle "Please choose a $DIR_STR" --ok-label "Choose $DIR_STR" --cancel-label "Done choosing" --dselect $3 $Y $X)
                       ERROR=$?
                       #
                       if [ "$ERROR" -eq 0 ] && [ -d $DIR ] ; then
                          f_yn_question $1 "Y" "Confirm $DIR_STR name" "$DIR_STR name: $DIR\n\nIs the $DIR_STR name correct?"
                          #
                          if [ "$ANS" -ne 1 ] ; then
                             # Yes, $DIR_STR name is correct. Note: $DIR includes "Directory Name".
                             # Output selected Directory Name to $ANS.
                             ANS=$DIR
                             #
                             f_message $1 "NOK" "Directory Entered" "Directory name accepted. Enter next directory name or press \"Exit\" button.\n\n$DIR" 2
                          fi
                       fi
                    done
              #
              # Reset ERROR since on exiting WHILE-loop it will always be EXIT=1.
              ERROR=0
              #
           ;;
           whiptail)
              # User-input via "inputbox" free-form directory name entry.
              $1 --title "User-entered $DIR_STR" --cancel-button "Exit" --inputbox "Enter $DIR_STR name:" 8 70 $3 2>$TEMP_FILE
              ERROR=$?
              ANS=$(cat $TEMP_FILE)
              #
           ;;
           text)
              ERROR=0
              # The user-entered directory name is whatever is after $3 default parent directory.
              echo "User-entered $DIR_STR name"
              echo
              echo -n "Enter $DIR_STR name(s): $3/"
              read ANS
              #
              # String $3 includes a trailing "/".
              ANS=$3$ANS
              #
              if [ -z "$ANS" ] ; then
                 ERROR=1
              fi
           ;;
      esac
      #
      if [ "$ERROR" -eq 1 ] ; then
         return 1  # Return to Main Menu.
      fi
      #
} # End of function f_select_dir.
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
      # Define TARGET_DIR
      TARGET_DIR="TARGET_DIR"
      #
      # If there is no target directory specified, ask for directory.
      if [ -d "$2" ] ; then
         TARGET_DIR=$2
      else
         f_select_dir $1 "Target_Directory" "/home"
         #
         # Set TARGET_DIR to the selected directory.
         TARGET_DIR=$ANS
      fi
      #
      if [ $ERROR -eq 1 ] ; then
         return 1  # Return to Main Menu.
      fi
      #
      # Does the directory exist?
      if [ ! -d "$TARGET_DIR" ] ; then
         # No, directory does not exist.
         f_message $1 "OK" "Directory Error" "$DIR_STR does not exist.\n\n$TARGET_DIR"
         return 1  # Return to Main Menu.
      fi
      #
      # Create list of files.
      ls $TARGET_DIR > $TEMP_FILE
      #
      # Create diagnostic log file of output.
      TEMP_FILE2=$THIS_FILE"_OUTPUT_temp.txt"
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
               # Initialize ERR, ERROR.
               ERROR=0
               ERR=0
               #
               # Clear TEMP_FILE2.
               echo "Error Log" > $TEMP_FILE2
               #
               # Rename file with tag names.
               if [ "$NEW_FILE_NAME" != "$FILE" ] ; then
                  mv $TARGET_DIR$FILE $TARGET_DIR$NEW_FILE_NAME 2> $TEMP_FILE2
                  ERROR=$?
                  if [ $ERROR -ne 0 ] ; then
                     let ERR=$ERR+1
                  fi
               fi
               # End of file name list?
               # No, get next file name.
            done < $TEMP_FILE
            #
            # Were there any errors renaming files?
            if [ $ERR -ne 0 ] ; then
            f_message $1 "OK" "List Error Messages" $TEMP_FILE2
            fi
            #
            # View TARGET_DIR.
            ls $TARGET_DIR > $TEMP_FILE
            f_message $1 "OK" "List tagged $TARGET_DIR" $TEMP_FILE
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
      # Define TARGET_DIR
      TARGET_DIR=""
      #
      # If there is no target directory specified, ask for directory.
      if [ -d "$2" ] ; then
         TARGET_DIR=$2
      else
         #f_select_target_directory $1
         f_select_dir $1 "Target_Directory" "/home"
         #
         # Set TARGET_DIR to the selected directory.
         TARGET_DIR=$ANS
      fi
      #
      if [ $ERROR -eq 1 ] ; then
         return 1  # Return to Main Menu.
      fi
      #
      # Does the directory exist?
      if [ ! -d "$TARGET_DIR" ] ; then
         # No, directory does not exist.
         f_message $1 "OK" "Directory Error" "$DIR_STR does not exist.\n\n$TARGET_DIR"
         return 1  # Return to Main Menu.
      fi
      #
      # Create list of files.
      ls $TARGET_DIR > $TEMP_FILE
      #
      # Create diagnostic log file of output.
      TEMP_FILE2=$THIS_FILE"_OUTPUT_temp.txt"
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
               # Initialize ERROR.
               ERROR=0
               #
               # Rename file with tag names.
               if [ "$NEW_FILE_NAME" != "$FILE" ] ; then
                  mv $TARGET_DIR$FILE $TARGET_DIR$NEW_FILE_NAME 2> $TEMP_FILE2
                  ERROR=$?
                  if [ $ERROR -ne 0 ] ; then
                     let ERR=$ERR+1
                  fi
               fi
               # End of file name list?
               # No, get next file name.
            done < $TEMP_FILE
            #
            # Were there any errors renaming files?
            if [ $ERR -ne 0 ] ; then
            f_message $1 "OK" "List Error Messages" $TEMP_FILE2
            fi
            #
            # View TARGET_DIR.
            ls $TARGET_DIR > $TEMP_FILE
            f_message $1 "OK" "List Untagged $TARGET_DIR" $TEMP_FILE
            #
            unset TARGET_DIR
            #
} # End of function f_untagger.
#
# **************************************
# **************************************
# ***     Start of Main Program      ***
# **************************************
# **************************************
#     Rev: 2021-03-11
#
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
#-------------------------------------------------------
# Detect and download any missing scripts and libraries.
#-------------------------------------------------------
#
#----------------------------------------------------------------
# Variables FILE_LIST and FILE_DL_LIST are defined in the section
# "Default Variable Values" at the beginning of this script.
#----------------------------------------------------------------
#
# Are any files/libraries missing?
fdl_download_missing_scripts $FILE_LIST $FILE_DL_LIST
#
# Are there any problems with the download/copy of missing scripts?
if [ -r  $FILE_DL_LIST ] || [ $ERROR -ne 0 ] ; then
   # Yes, there were missing files or download/copy problems so exit program.
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
   exit 0  # This cleanly closes the process generated by #!bin/bash.
           # Otherwise every time this script is run, another instance of
           # process /bin/bash is created using up resources.
fi
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
if [ -e $TEMP_FILE2 ] ; then
   rm $TEMP_FILE2
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
