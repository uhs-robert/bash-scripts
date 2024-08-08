# Bash Scripts for Linux
These scripts are designed for Linux to accomplish various tasks quickly.

## Cloning the Repository
To get started, clone this repository to a folder that you will remember later on your local machine using the following command:
`git clone https://github.com/UpHillSolutions-roberth/bash-scripts.git`

## Setting Permissions
After cloning the repository, you need to set executable permissions for the scripts. Follow these steps:

1. Navigate to the cloned directory: `cd bash-scripts`
2. Run the following command to make each script file executable: `chmod +x *`
3. *(Optional)* To save the permissions to your folder, run this command (replace path/to with your file path): `chmod -R +x /path/to/bash-scripts`
> [!TIP] This command ensures that you have the necessary permissions to execute the scripts.

## Bash Scripts
Each script comes with a -h or --help option to see how they work and how to use them.
> [!NOTE] `bash_utilities` is an exception. This script houses general functions for the other scripts.

### bash_utilities
This script provides various utility functions to enhance the functionality of other scripts. It includes functions for color formatting and header printing.

### 2pdf
This script converts various document formats to PDF using LibreOffice. It's useful for preparing documents for sharing or printing. Supported formats include `.doc`, `.docx`, `.odt`, `.rtf`, `.txt`, and `.html`.
#### Requirements
Make sure LibreOffice is installed on your system to use this script. You can install it using your package manager. If LibreOffice is not installed, the script will display an error message.

> [!NOTE] The script will place the converted PDF output in the same directory as the original file.

### add2emu
This script moves all files from the current directory to a specified emulator folder for BATOCERA. The emulator folder is determined by the emulator name, and the type specifies the base folder (either 'rom' or 'music'). 

#### Requirements
- **Dependencies**:
  - **pv**: This script requires the `pv` command-line utility for monitoring the progress of file transfers. It will be installed automatically if not found.
- **Permissions**: The script must be executed with sufficient permissions to move files and create directories in the specified paths.

#### Options
- **`-h, --help`**: Displays the help message with usage instructions.
- **`<emulator_name>`**: The name of the emulator folder where files will be moved.
- **`[type]`**: The base folder type. Can be:
  - **`rom`** (default): Moves ROM files to the emulator folder.
  - **`music`**: Moves music files to the emulator folder.

> [!NOTE] The script assumes the directory is in `run/media/$username/SHARE`. This should be modified to match your directory for BATOCERA.

### clean_empty_dirs
This script removes empty directories from the current path, helping to declutter your filesystem.

### compress_files
This script compresses specified files or directories into a .zip format, useful for storage and transfer.

### get_ip
This script retrieves the current public IP address of your machine. It's handy for troubleshooting or sharing network information.

### net_speed_test
This script performs a speed test of your internet connection, providing real-time upload and download speeds.

### org_files_by_date
This script organizes files in the current directory into subdirectories based on their creation or modification date.

### sysup
This script performs a comprehensive system update on Fedora, including DNF package updates, security updates, cleanup of old packages, updating Flatpak packages, and cleaning up cached package data.
#### Options
- `-h, --help`: Display help message.
- `-s, --skip-security`: Skip security updates.
- `-f, --skip-flatpak`: Skip Flatpak updates.
- `-c, --skip-clean-cache`: Skip cleaning the DNF cache.
- `-n, --no-confirm`: Run DNF commands without the `-y` flag to require user confirmation.

> [!WARNING] Only works with Linux Fedora.

### xtract
This script extracts files of the specified type from the current directory. It can also extract files into their own directories named after the file if the `-d` option is used.

#### Options:
- `-h, --help`: Display help message.
- `-d`: Extract files into their own directories named after the file.
- `<file_type>`: The type of files to extract (e.g., `.zip`, `.tar`, `.gz`).

### yt2mp3
This script downloads audio from YouTube URLs provided in a file or a single URL. Downloaded audio files will be saved in the specified output directory or the current directory if not provided.

#### Requirements
Ensure `yt-dlp` is installed on your system to use this script. You can install it using your package manager or by following the installation instructions on the [yt-dlp GitHub page](https://github.com/yt-dlp/yt-dlp).

#### Options:
- `-h, --help`: Display help message.
- `-o, --output [directory]`: Specify the output directory for downloaded audio files.
- `[file]`: A text file containing YouTube URLs (one per line).
- `[URL]`: A single YouTube URL or playlist to download audio from.

