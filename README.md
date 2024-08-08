# Setup Instructions
These scripts are designed for Linux to accomplish various tasks quickly. Many scripts can be used by any Linux distribution by some scripts like `sysup` are for Fedora specifically as that's my flavor of choice.

## Cloning the Repository
To get started, clone this repository to a folder that you will remember later on your local machine using the following command:
`git clone https://github.com/UpHillSolutions-roberth/bash-scripts.git`

## Setting Permissions
After cloning the repository, you need to set executable permissions for the scripts. Follow these steps:

1. Navigate to the cloned directory: `cd bash-scripts`
2. Run the following command to make each script file executable: `chmod +x *`
3. *(Optional)* To save the permissions to your folder, run this command from the folder: `chmod -R +x /bash-scripts/scripts`
> [!TIP]
> This command ensures that you have the necessary permissions to execute the scripts. Adjust the file path to point to where you placed the `/bash-scripts/scripts` folder.

# Bash Scripts
Each script comes with a -h or --help option to see how they work and how to use them.
> [!NOTE]
> `bash_utilities` is the only exception. This script houses general functions for the other scripts to make maintenance easier for me.

## bash_utilities
This script provides various utility functions to enhance the functionality of other scripts. It includes functions for terminal color and text formatting as well as other terminal output functions.

## 2pdf
This script converts various document formats to PDF using LibreOffice. It's useful for preparing documents for sharing or printing. Supported formats include `.doc`, `.docx`, `.odt`, `.rtf`, `.txt`, and `.html`.
### Requirements
Make sure LibreOffice is installed on your system to use this script. You can install it using your package manager. If LibreOffice is not installed, the script will display an error message.
> [!NOTE]
> The script will place the converted PDF output in the same directory as the original file.

## add2emu
This script moves all files from the current directory to a specified emulator folder. This script is intended for usage with Batocera and uses their folder structure but can be used with any emulator as long as you have the same folder/file organization. 

You will need a folder setup as follows: 
- Group all of your emulators in a single directory like: `emulators/ps2` and `emulators/gc` etc:
- Each folder should have a `roms` folder inside of it like `emulators/ps2/roms` etc: 

With the setup above, make sure the `base_path` variable inside of the script matches the location of your `emulators` folder directory.

### Requirements
- **Dependencies**:
  - **pv**: This script requires the `pv` command-line utility for monitoring the progress of file transfers. It will be installed automatically if not found.
- **Permissions**: The script must be executed with sufficient permissions to move files and create directories in the specified paths.

### Options
- **`-h, --help`**: Displays the help message with usage instructions.
- **`<emulator_name>`**: The name of the emulator folder where files will be moved.
- **`[type]`**: The base folder type. Can be:
  - **`rom`** (default): Moves ROM files to the emulator folder.
  - **`music`**: Moves music files to the emulator folder.
> [!NOTE]
> The script assumes the directory is in `run/media/$username/SHARE`. This should be modified to match your directory for BATOCERA.

## clean_empty_dirs
This script is designed to find and delete empty directories within a specified directory. If no directory is provided, it will default to the current directory.

### Features
- **Recursively searches** for empty directories within the specified path.
- **User confirmation** before deleting any empty directories to prevent accidental data loss.
- **Help information** provided to guide users on how to use the script.

## compress_files
This script compresses specified files or directories into a .zip format, useful for storage and transfer.

## get_ip
This script retrieves the current public IP address of your machine. It's handy for troubleshooting or sharing network information.

## net_speed_test
This script performs a speed test of your internet connection, providing real-time upload and download speeds.

## org_files_by_date
This script organizes files in the current directory into subdirectories based on their creation or modification date.

## sysup
This script performs a comprehensive system update on Fedora, including DNF package updates, security updates, cleanup of old packages, updating Flatpak packages, and cleaning up cached package data.
### Options
- `-h, --help`: Display help message.
- `-s, --skip-security`: Skip security updates.
- `-f, --skip-flatpak`: Skip Flatpak updates.
- `-c, --skip-clean-cache`: Skip cleaning the DNF cache.
- `-n, --no-confirm`: Run DNF commands without the `-y` flag to require user confirmation.

> [!WARNING] Only works with Linux Fedora.

## xtract
This script extracts files of the specified type from the current directory. It can also extract files into their own directories named after the file if the `-d` option is used.

### Options:
- `-h, --help`: Display help message.
- `-d`: Extract files into their own directories named after the file.
- `<file_type>`: The type of files to extract (e.g., `.zip`, `.tar`, `.gz`).

## yt2mp3
This script downloads audio from YouTube URLs provided in a file or a single URL. Downloaded audio files will be saved in the specified output directory or the current directory if not provided.

### Requirements
Ensure `yt-dlp` is installed on your system to use this script. You can install it using your package manager or by following the installation instructions on the [yt-dlp GitHub page](https://github.com/yt-dlp/yt-dlp).

### Options:
- `-h, --help`: Display help message.
- `-o, --output [directory]`: Specify the output directory for downloaded audio files.
- `[file]`: A text file containing YouTube URLs (one per line).
- `[URL]`: A single YouTube URL or playlist to download audio from.

