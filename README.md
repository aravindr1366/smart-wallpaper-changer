# 🖼️ Smart Wallpaper Changer using PowerShell & Weather API

Automatically change your Windows wallpaper based on the **current weather** and **time of day** using PowerShell and the OpenWeatherMap API.

![PowerShell](https://img.shields.io/badge/built%20with-powershell-blue)
![Windows](https://img.shields.io/badge/os-windows-informational)
![License](https://img.shields.io/badge/license-MIT-green)

## 📌 Features

- 🕒 Detects time of day (morning, day, evening, night)
- 🌦 Fetches real-time weather using OpenWeatherMap API
- 🖼 Sets wallpapers based on weather + time slot
- 🔁 Scheduled with Task Scheduler
- 🧙‍♂️ Runs silently using `.vbs` wrapper (no popups!)
- 📄 Logs every update with timestamp and status

## 🛠 Setup

### 1. Clone or Download
```bash
git clone https://github.com/aravindr1366/smart-wallpaper-changer.git
```

### 2. Get a Weather API Key
- Sign up at [https://openweathermap.org/api](https://openweathermap.org/api)
- Get your free API key

### 3. Configure `change_wallpaper.ps1`
- Replace the placeholder `apiKey` with your OpenWeatherMap key
- Set your latitude & longitude
- Point `$wallpaperPath` to your image folder

### 4. Organize Wallpapers
Inside your wallpapers folder, name images like:

```

morning_clear.jpg
morning_cloudy.jpg
morning_rain.jpg
morning_foggy.jpg
morning_default.jpg

day_clear.jpg
day_cloudy.jpg
day_rain.jpg
day_foggy.jpg
day_default.jpg

evening_clear.jpg
evening_cloudy.jpg
evening_rain.jpg
evening_foggy.jpg
evening_default.jpg

night_clear.jpg
night_cloudy.jpg
night_rain.jpg
night_foggy.jpg
night_default.jpg

```

### 5. Run Silently Using VBS
Use `RunWallpaper.vbs` to execute the script without a PowerShell window popping up.

## ⚙️ Automate with Task Scheduler

1. Open **Task Scheduler**
2. Create a new task:
   - **Trigger**: Daily / Every hour
   - **Action**: `wscript.exe`  
     - Arguments: `C:\Path\To\RunWallpaper.vbs`

## 📁 Files in this Repo

| File | Description |
|------|-------------|
| `change_wallpaper.ps1` | Core logic (weather + time → image) |
| `RunWallpaper.vbs` | Hidden launcher (no PowerShell window) |
| `wallpaper_change.log` | Log file (created automatically) |
| `README.md` | You’re reading it! |
| `.gitignore` | Ignore log files, temp files, etc. |

## 🧠 Credits

Project by **[Aravind R](https://github.com/aravindr1366)**  
B.Tech CSD @ Viswajyothi College of Engineering & Technology

## 📄 License

MIT License
