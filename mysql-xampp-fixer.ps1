# First Backup old MySql data Folder
Rename-Item -Path "./data" -NewName "./data_old"

# Create a new folder mysql/data
# Copy the content that resides in mysql/backup to the  mysql/data
Copy-Item -Path "./backup" -Destination "./data" -Recurse

# Remove Test from data folder
Remove-Item "./data/test" -Recurse

# Copy all your database folders that are in `mysql/data_old` to `mysql/data` (excluding the mysql, performance_schema, and phpmyadmin)
$dbPaths = Get-ChildItem -Path "./data_old" -Exclude ('mysql', 'performance_schema', 'phpmyadmin') -Recurse -Directory
Copy-Item -Path $dbPaths.FullName -Destination "./data" -Recurse
Copy-Item -Path "./data_old/ibdata1" -Destination "./data/ibdata1"

# Notify User After Finishing The Process
Write-Host "Finished repairing MySQL data"
Write-Host "Previous data is located at ./data_old"
