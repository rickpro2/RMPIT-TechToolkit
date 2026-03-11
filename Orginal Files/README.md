# RMPIT Tech Toolkit

Enterprise-style PowerShell launcher for managing and deploying internal IT scripts from GitHub.

RMPIT Tech Toolkit provides a centralized, auto-updating, categorized interface for running administrative scripts in a structured and controlled way.

---

## 🚀 Features

- Tabbed script categories
- Dark / Light mode toggle
- Progress bar and status bar
- Automatic launcher update check
- Administrator privilege detection
- Public desktop installer (all users)
- GitHub-hosted script distribution
- Logging to `C:\ProgramData\RMPIT_Launcher.log`

---

## 📁 Repository Structure

RMPIT-TechToolkit
│
├── Launcher
│   ├── RMPIT-Launcher.ps1
│   └── launcher.version
│
├── scripts.json
│
└── Scripts
    ├── Optimization
    ├── Installers
    └── Maintenance



---

## 📦 How It Works

1. The launcher downloads `scripts.json`
2. Scripts are grouped into categories (tabs)
3. Selecting or double-clicking a script:
   - Downloads latest version from GitHub
   - Checks for required admin rights
   - Executes in memory
4. Launcher checks for version updates automatically

---

## 🛠 Installation (All Users)

Run the installer script as Administrator:

```powershell
irm https://raw.githubusercontent.com/rickpro2/RMPIT-TechToolkit/main/Install-RMPIT.ps1 | iex
