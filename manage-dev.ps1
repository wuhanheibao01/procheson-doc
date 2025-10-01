# PLC ST Test Report Development Server Management Script

param(
    [Parameter(Mandatory=$false)]
    [ValidateSet("start", "stop", "status")]
    [string]$Action = "start"
)

function Start-DevServer {
    Write-Host "Starting PLC ST Test Report Development Server..." -ForegroundColor Green
    
    # Check if already running
    $existingProcess = Get-Process | Where-Object { $_.ProcessName -eq "node" -and $_.MainWindowTitle -like "*VitePress*" }
    if ($existingProcess) {
        Write-Host "Warning: Detected running VitePress server (PID: $($existingProcess.Id))" -ForegroundColor Yellow
        $response = Read-Host "Stop existing server and start new instance? (y/N)"
        if ($response -eq 'y' -or $response -eq 'Y') {
            Stop-Process -Id $existingProcess.Id -Force
            Write-Host "Stopped existing server instance" -ForegroundColor Yellow
            Start-Sleep -Seconds 2
        } else {
            Write-Host "Cancelled starting new instance" -ForegroundColor Yellow
            return
        }
    }
    
    # Start new instance
    try {
        Start-Process -FilePath "pnpm" -ArgumentList "docs:dev" -WindowStyle Minimized -PassThru
        Write-Host "VitePress development server started in background" -ForegroundColor Green
        Write-Host "Please visit http://localhost:5173 to view the website" -ForegroundColor Cyan
        Write-Host "Use .\manage-dev.ps1 -Action stop to stop the server" -ForegroundColor Gray
    } catch {
        Write-Host "Failed to start: $($_.Exception.Message)" -ForegroundColor Red
    }
}

function Stop-DevServer {
    Write-Host "Stopping PLC ST Test Report Development Server..." -ForegroundColor Yellow
    
    $processes = Get-Process | Where-Object { $_.ProcessName -eq "node" -and ($_.MainWindowTitle -like "*VitePress*" -or $_.MainWindowTitle -like "*PLC ST Test Report*") }
    
    if ($processes.Count -eq 0) {
        Write-Host "No running VitePress development server found" -ForegroundColor Gray
        return
    }
    
    foreach ($process in $processes) {
        try {
            Stop-Process -Id $process.Id -Force
            Write-Host "Stopped process PID: $($process.Id)" -ForegroundColor Green
        } catch {
            Write-Host "Failed to stop process PID: $($process.Id) - $($_.Exception.Message)" -ForegroundColor Red
        }
    }
}

function Get-ServerStatus {
    $processes = Get-Process | Where-Object { $_.ProcessName -eq "node" -and ($_.MainWindowTitle -like "*VitePress*" -or $_.MainWindowTitle -like "*PLC ST Test Report*") }
    
    if ($processes.Count -eq 0) {
        Write-Host "Status: Not running" -ForegroundColor Gray
    } else {
        Write-Host "Status: Running" -ForegroundColor Green
        foreach ($process in $processes) {
            Write-Host "  PID: $($process.Id) | Start time: $($process.StartTime)" -ForegroundColor Gray
        }
    }
}

# Execute action
switch ($Action) {
    "start" { Start-DevServer }
    "stop" { Stop-DevServer }
    "status" { Get-ServerStatus }
}