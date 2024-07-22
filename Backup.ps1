$BackupLocationsFile= "C:\Github Projects\Powershell\Backup\Directories.txt"
$BackupLocations=Get-Content -Path $BackupLocationsFile

$StorageLocation="C:\Github Projects\New Folder\Backup"
$BackupName="Backup $(Get-Date -Format "yyyy-MM-dd hh-mm")"

foreach($Location in $BackupLocations ){
    Write-Output $Location
    $LeadingPath="$($Location.Replace(':',''))"
    if(-not (Test-Path  "$StorageLocation\$BackupName\$LeadingPath")){
        New-Item -Path  "$StorageLocation\$BackupName\$LeadingPath" -ItemType Directory
    
    }
    Get-ChildItem -Path $Location | Copy-Item -Destination "$StorageLocation\$BackupName\$LeadingPath" -Recurse -Container 
}

Compress-Archive -Path "$StorageLocation\$BackupName" -DestinationPath "$StorageLocaion\$BackupName.zip" -CompressionLevel Fastest

 