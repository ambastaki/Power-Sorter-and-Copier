Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName PresentationFramework

function Get-FolderBrowseDialog($description) {
    $dialog = New-Object System.Windows.Forms.FolderBrowserDialog
    $dialog.Description = $description
    $dialog.ShowNewFolderButton = $false
    if ($dialog.ShowDialog() -eq "OK") {
        return $dialog.SelectedPath
    } else {
        return $null
    }
}

# Prompt for source folder
$srcFolder = Get-FolderBrowseDialog "Select the folder containing your Video files"
if (-not $srcFolder) { 
    Write-Host "No source folder selected. Exiting." -ForegroundColor Red
    exit 
}

# Get all Video files (change *.mxf to the filetype in your directory that you want sorted and copied)
$files = Get-ChildItem -Path $srcFolder -Filter '*.mxf'

# Filter files with a SUFFIX, in this case 'K00' has been added please change as per the suffix you have used
$k00Files = $files | Where-Object { $_.Name -match 'K00(\d+)' } | 
    Sort-Object { [int]([regex]::Match($_.Name, 'K00(\d+)').Groups[1].Value) }

# Ensure $k00Files is always treated as an array (change k00 to your suffix)
$k00Files = @($k00Files)

# Display filtered and sorted files with numbering (change k00 to your suffix)
if ($k00Files.Count -eq 0) {
    Write-Host "No files with 'K00' found. Exiting." -ForegroundColor Yellow
    exit
} else {
    Write-Host "`nFiles with 'K00' in their names (sorted and numbered):"
    $i = 1
    $k00Files | ForEach-Object {
        Write-Host "$i. $($_.Name) - Size: $([math]::Round($_.Length / 1GB, 2)) GB"
        $i++
    }
    Write-Host "`nTotal files with 'K00': $($k00Files.Count)"
}

# Prompt to select a batch of files (change how many batches you would like, it is also fluid, you can do as many transfers as you would like)
Write-Host "`nEnter the range of files to copy (e.g., 1-1000):"
$range = Read-Host "File range"
if (-not $range -match '^\d+-\d+$') {
    Write-Host "Invalid range format. Please enter in the format 'start-end'. Exiting." -ForegroundColor Red
    exit
}

# Parse the range
$start, $end = $range -split '-'
$start = [int]$start
$end = [int]$end

# Validate range
if ($start -lt 1 -or $end -gt $k00Files.Count -or $start -gt $end) {
    Write-Host "Invalid range. Please ensure the range is within 1 to $($k00Files.Count). Exiting." -ForegroundColor Red
    exit
}

# Select the files in the range (change k00 Suffix)
$selectedFiles = $k00Files[($start-1)..($end-1)]
Write-Host "`nSelected files:"
$i = $start
$selectedFiles | ForEach-Object {
    Write-Host "$i. $($_.Name) - Size: $([math]::Round($_.Length / 1GB, 2)) GB"
    $i++
}

# Prompt for destination folder
$destFolder = Get-FolderBrowseDialog "Select the destination folder to copy the files"
if (-not $destFolder) { 
    Write-Host "No destination folder selected. Exiting." -ForegroundColor Red
    exit 
}

# Confirm transfer
Write-Host "`nYou are about to copy $($selectedFiles.Count) files to $destFolder."
$confirmation = Read-Host "Do you want to proceed? (yes/no)"
if ($confirmation -ne "yes") {
    Write-Host "Operation cancelled. Exiting." -ForegroundColor Yellow
    exit
}

# Copy selected files to destination
Write-Host "`nCopying files to $destFolder ...`n"
foreach ($file in $selectedFiles) {
    $destFile = Join-Path $destFolder $file.Name
    Write-Host "Copying $($file.Name) ..."
    Copy-Item -Path $file.FullName -Destination $destFile -Force
}
Write-Host "`nSelected files copied successfully to $destFolder."