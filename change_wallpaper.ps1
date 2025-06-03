# Config
$apiKey = "YOUR_API_KEY_HERE"
$latitude = "YOUR_LATTITUDE"
$longitude = "YOUR_LONGITUDE"
$wallpaperPath = "C:\Wallpapers"
$logFile = "$wallpaperPath\wallpaper_change.log"

# Function to log messages
function Write-Log {
    param([string]$message)
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logMessage = "$timestamp - $message"
    Add-Content -Path $logFile -Value $logMessage
    Write-Host $message
}

Write-Log "🌤 Starting wallpaper update..."

# Get current hour
$currentHour = (Get-Date).Hour

# Determine time slot
if ($currentHour -ge 5 -and $currentHour -lt 9) {
    $timeOfDay = "morning"
} elseif ($currentHour -ge 9 -and $currentHour -lt 16) {
    $timeOfDay = "day"
} elseif ($currentHour -ge 16 -and $currentHour -lt 19) {
    $timeOfDay = "evening"
} else {
    $timeOfDay = "night"
}
Write-Log "🕒 Time of day determined: $timeOfDay"

# Default weather
$weatherType = "default"

# Fetch weather using coordinates
try {
    $url = "http://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric"
    $response = Invoke-RestMethod -Uri $url -ErrorAction Stop
    $weatherMain = $response.weather[0].main.ToLower()
    Write-Log "☁️ Raw weather: $weatherMain"

    switch -Regex ($weatherMain) {
        "clear"                      { $weatherType = "clear" }
        "clouds"                     { $weatherType = "cloudy" }
        "rain|drizzle|thunderstorm"  { $weatherType = "rain" }
        "fog|mist|haze|smoke"        { $weatherType = "foggy" }
        default                      { $weatherType = "default" }
    }

    Write-Log "🌦 Weather type determined: $weatherType"
}
catch {
    Write-Log "⚠️ Weather fetch failed. Using default weather type."
}

# Build wallpaper filename
$imageName = "$timeOfDay" + "_" + "$weatherType" + ".jpg"
$imageFullPath = Join-Path $wallpaperPath $imageName

# Fallback if wallpaper not found
if (!(Test-Path $imageFullPath)) {
    Write-Log "❌ Wallpaper not found: $imageName, using default."
    $imageName = "$timeOfDay" + "_default.jpg"
    $imageFullPath = Join-Path $wallpaperPath $imageName
}

# Set wallpaper using COM
Add-Type @"
using System.Runtime.InteropServices;
public class Wallpaper {
  [DllImport("user32.dll", SetLastError = true)]
  public static extern bool SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
}
"@

[Wallpaper]::SystemParametersInfo(20, 0, $imageFullPath, 3)
Write-Log "✅ Wallpaper set to $imageName"
