# Script to start development environment for the-cinephile project
$projectPath = "C:\Users\aruna\Documents\Github\the-cinephile"
$postmanPath = "C:\Users\aruna\AppData\Local\Postman\Postman.exe"

# Start PowerShell with Rails server
Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd '$projectPath'; Write-Host 'Starting Rails server...' -ForegroundColor Green; rails server"

# Start Git Bash
Start-Process -FilePath "C:\Program Files\Git\git-bash.exe" -ArgumentList "--cd='$projectPath'"

# Start VS Code
Start-Process -FilePath "code" -ArgumentList "$projectPath"

# Start Postman
Start-Process -FilePath $postmanPath

Write-Host "Development environment setup complete!" -ForegroundColor Cyan

