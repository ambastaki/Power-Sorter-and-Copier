# Power-Sorter-and-Copier
Sort files and copy by suffix in Windows Powershell

# Transfer XX *.XX Files Script

This PowerShell script facilitates the transfer of (for example `.mxf`, set as an example here onwards) files with specific naming patterns (for example `K00`, set as an example here onwards) by:
1. Filtering and sorting files based on their numeric suffix (`K00XXXX`).
2. Allowing users to select a range of files to transfer.
3. Copying the selected files to a specified destination folder.

---

## Features
- **File Filtering & Sorting:** Automatically filters `.mxf` files containing `K00` in their names and sorts them by their numeric suffix in ascending order.
- **File Selection:** Users can specify a range of files (e.g., `1-1000`) to transfer.
- **Destination Selection:** Copy files to any folder of your choice.
- **Size Display:** Displays file sizes in GB for better planning.

---

## Prerequisites
- **PowerShell Environment:** Ensure you have PowerShell installed (Windows comes with it pre-installed).
- **File Access:** Ensure you have read/write access to the source and destination folders.

---

## How to Use

### Step 1: Save the Script
Save the script as `Transfer-K00-Files-Final.ps1` in a location of your choice.

### Step 2: Run the Script
1. Open PowerShell.
2. Navigate to the folder containing the script using the `cd` command:
   ```powershell
   cd <path_to_script_folder>
   ```
3. Run the script:
   ```powershell
   .\Transfer-K00-Files-Final.ps1
   ```

### Step 3: Follow the Prompts
1. **Select the Source Folder:**
   - A dialog will appear. Select the folder containing your `.mxf` files.

2. **View the Sorted List:**
   - The script will display all `.mxf` files with `K00` in their names, sorted by their numeric suffix.

3. **Select a Range of Files:**
   - Enter the range of files you want to copy (e.g., `1-1000`).

4. **Select the Destination Folder:**
   - A dialog will appear. Select the folder where you want to copy the files.

5. **Confirm the Transfer:**
   - The script will prompt you for confirmation before initiating the transfer.

### Step 4: Wait for Completion
- The script will copy the selected files to the destination folder and notify you upon completion.

---

## Example Usage

### Input:
- Source folder contains these files:
  ```
  200X-TLE-AVE-TRP-000.K001905.mxf
  200X-TON-VER-TRP-000.K001899.mxf
  200X-TLE-SRI-TRP-000.K001911.mxf
  ```
- Range entered: `1-2`
- Destination folder: `D:\ExternalDrive`

### Output:
```
Files with 'K00' in their names (sorted and numbered):
1. 200X-TON-VER-TRP-000.K001899.mxf - Size: 3.5 GB
2. 200X-TLE-AVE-TRP-000.K001905.mxf - Size: 4.0 GB
3. 200X-ABU-ANI-TRP-000.K001911.mxf - Size: 5.1 GB

Total files with 'K00': 3

Enter the range of files to copy (e.g., 1-1000):
File range: 1-2

Selected files:
1. 200X-TON-VER-TRP-000.K001899.mxf - Size: 3.5 GB
2. 200X-ABU-ANI-TRP-000.K001911.mxf - Size: 4.0 GB

You are about to copy 2 files to D:\ExternalDrive.
Do you want to proceed? (yes/no): yes

Copying files to D:\ExternalDrive ...

Copying 200X-TON-VER-TRP-000.K001899.mxf ...
Copying 200X-ABU-ANI-TRP-000.K001911.mxf ...

Selected files copied successfully to D:\ExternalDrive.
```

---

## Notes
- Ensure the source folder contains `.mxf` files with `K00` in their names.
- The script handles up to **1000 files** in a single batch. For larger transfers, repeat the process with different ranges.
- If you encounter issues, ensure:
  - The source folder is accessible.
  - The destination folder has sufficient space.
  - The selected range is valid.

---

## Troubleshooting
### Common Issues:
1. **No Files Found:**
   - Ensure the `.mxf` files in the source folder contain `K00` in their names.

2. **Invalid Range:**
   - Ensure the range is within the total number of files displayed.

3. **Permission Errors:**
   - Run PowerShell as an administrator if you encounter permission issues.

---

## License
This script is provided as-is, without warranty of any kind. Use at your own risk.

---

## Author
This script was created to simplify the transfer of `.mxf` files with specific naming patterns. Contributions and suggestions are welcome!
