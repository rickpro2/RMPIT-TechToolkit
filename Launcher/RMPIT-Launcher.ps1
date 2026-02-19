Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# URL to fetch scripts.json
$ScriptListUrl = "https://raw.githubusercontent.com/rickpro2/RMPIT-TechToolkit/main/scripts.json"
# Cache folder
$BaseCachePath = "C:\ProgramData\RMPIT-TechToolkit"

if (!(Test-Path $BaseCachePath)) {
    New-Item -Path $BaseCachePath -ItemType Directory | Out-Null
}

# Load scripts.json
try {
    $jsonData = Invoke-WebRequest -Uri $ScriptListUrl -UseBasicParsing
    $Scripts = $jsonData.Content | ConvertFrom-Json
}
catch {
    [System.Windows.Forms.MessageBox]::Show("Failed to load script list.","Error")
    return
}

# Function to get remote script version
function Get-ScriptVersionFromContent {
    param ($Content)
    if ($Content -match "#\s*Version:\s*([0-9\.]+)") {
        return $matches[1]
    }
    return "0.0.0"
}

# Function to get local version
function Get-LocalVersion {
    param ($Name)
    $versionFile = Join-Path $BaseCachePath "$Name.version"
    if (Test-Path $versionFile) {
        return Get-Content $versionFile
    }
    return "0.0.0"
}

# Function to set local version
function Set-LocalVersion {
    param ($Name, $Version)
    Set-Content -Path (Join-Path $BaseCachePath "$Name.version") $Version
}

# Function to check admin
function Test-Admin {
    $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($identity)
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

# Function to run scripts
function Run-Script {
    param ($ScriptObject)

    try {
        $response = Invoke-WebRequest -Uri $ScriptObject.Url -UseBasicParsing -ErrorAction Stop

        $content = $response.Content

        $remoteVersion = Get-ScriptVersionFromContent $content
        $localVersion = Get-LocalVersion $ScriptObject.Name

        $cacheFile = Join-Path $BaseCachePath ($ScriptObject.Name + ".ps1")

        if ([version]$remoteVersion -gt [version]$localVersion -or !(Test-Path $cacheFile)) {
            Set-Content -Path $cacheFile -Value $content -Force
            Set-LocalVersion $ScriptObject.Name $remoteVersion
        }


        if ($ScriptObject.RequiresAdmin -and -not (Test-Admin)) {
            Start-Process powershell -ArgumentList "-ExecutionPolicy Bypass -File `"$cacheFile`"" -Verb RunAs
        }
        else {
            Start-Process powershell -ArgumentList "-ExecutionPolicy Bypass -File `"$cacheFile`"" -Wait
        }
    }
    catch {
        [System.Windows.Forms.MessageBox]::Show("Execution failed: $_","Error")
    }
}

# Create main form
$form = New-Object System.Windows.Forms.Form
$form.Text = "RMPIT Tech Toolkit"
$form.Size = New-Object System.Drawing.Size(600,400)
$form.StartPosition = "CenterScreen"

# TabControl
$tabControl = New-Object System.Windows.Forms.TabControl
$tabControl.Dock = "Fill"

# Unique categories
$categories = $Scripts | Select-Object -ExpandProperty Category -Unique

foreach ($category in $categories) {

    $tabPage = New-Object System.Windows.Forms.TabPage
    $tabPage.Text = $category

    $listBox = New-Object System.Windows.Forms.ListBox
    $listBox.Dock = "Top"
    $listBox.Height = 250

    # Filter scripts for this category
    $categoryScripts = $Scripts | Where-Object { $_.Category -eq $category }

    # Populate listbox
    foreach ($script in $categoryScripts) {
        $listBox.Items.Add($script.Name) | Out-Null
    }

   # Create the button
$runButton = New-Object System.Windows.Forms.Button
$runButton.Text = "Run Selected"
$runButton.Dock = "Bottom"

# Store needed objects in Tag
$runButton.Tag = @{
    ListBox = $listBox
    Scripts = $categoryScripts
}

$runButton.Add_Click({
    $context = $this.Tag
    $lb = $context.ListBox
    $scriptsForTab = $context.Scripts

    if ($lb.SelectedIndex -ge 0) {
        $selectedScript = $scriptsForTab[$lb.SelectedIndex]
        Run-Script $selectedScript
    }
    else {
        [System.Windows.Forms.MessageBox]::Show("Select a script first.")
    }
})


    # Assemble tab
    $tabPage.Controls.Add($listBox)
    $tabPage.Controls.Add($runButton)
    $tabControl.TabPages.Add($tabPage)
}

# Finalize form
$form.Controls.Add($tabControl)
$form.Topmost = $true
$form.Add_Shown({ $form.Activate() })

# Show dialog

[void]$form.ShowDialog()

