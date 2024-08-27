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

## add_font
This script downloads and installs a font from a specified URL, typically in a `.zip` format. It’s useful for quickly adding new fonts to your system without manually handling the installation process. The script automatically extracts the font files and updates the font cache so that the newly installed fonts are available for use immediately.

### Requirements
Ensure that `wget`, `unzip`, and `fc-cache` are installed on your system to use this script. These utilities are typically available on most Linux distributions by default or can be installed via your package manager. If any of these tools are missing, the script will fail to complete the installation process.

> [!NOTE]
> The script will place the downloaded and extracted font files in the `~/.local/share/fonts` directory and remove the downloaded `.zip` file after extraction.

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
This script compresses files in a specified directory (or the current directory if none is provided) using the chosen archive format. It allows users to delete original files after compression and customize the file types to compress.
### Features
- **Supports multiple archive formats**: zip, 7z, rar, tar, tar.gz, tar.bz2.
- **Option to delete original files** after successful compression.
- **Customizable file type** for compression (default is all files).
- **Help information** provided to guide users on script usage.

## get_ip
This script retrieves the current public IP address of your machine. It's handy for troubleshooting or sharing network information.

## net_speed_test
This script installs `speedtest-cli` if it is not already installed, runs a network speed test, and logs the results for later review. It provides an easy way to monitor network performance over time.
### Features
- **Automatic installation**: Installs `speedtest-cli` if it is not present on the system.
- **Logging**: Saves the results of the network speed test to a log file for future reference.
- **Simple usage**: Run the script with minimal command-line options.

## org_files_by_date
This script organizes files in the current directory and its subdirectories into folders based on their creation date (or modification date if the creation date is not available). Files are either moved or copied into directories named by year and month.

### Features
- **Organizes files**: Automatically sorts files into year/month folders based on their dates.
- **Flexible options**: Choose to copy files instead of moving them.
- **User-friendly**: Simple command-line interface with help options.

## reboot-plasma
This script reboots KDE Plasma. This is useful when KDE Plasma starts glitching especially with multiple monitors. Rebooting plasma will fix issues like a monitor not being detected after sleep or lock screen when it was previously detected.

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
This script extracts files of the specified type from the current directory. Users can choose to extract files into their own directories named after the file or extract them directly into the current directory.

### Features
- **Flexible extraction**: Choose to extract files into individual directories or into the current directory.
- **Supports multiple formats**: Handles various compressed file formats like `.zip`, `.tar`, `.gz`, and more.

## yt2mp3
This script downloads audio from YouTube URLs provided in a file or a single URL. The downloaded audio files will be saved in a specified output directory or the current directory if not provided.

### Features
- **Download from a file or URL**: Supports downloading audio from a list of URLs in a text file or a single YouTube URL.
- **Customizable output directory**: Specify where the audio files should be saved.
- **Audio format support**: Downloads audio in MP3 format with thumbnail embedding.

### Requirements
Ensure `yt-dlp` is installed on your system to use this script. You can install it using your package manager or by following the installation instructions on the [yt-dlp GitHub page](https://github.com/yt-dlp/yt-dlp).

### Options:
- `-h, --help`: Display help message.
- `-o, --output [directory]`: Specify the output directory for downloaded audio files.
- `[file]`: A text file containing YouTube URLs (one per line).
- `[URL]`: A single YouTube URL or playlist to download audio from.

