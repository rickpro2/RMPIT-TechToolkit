# =====================================================

# RMPIT Tech Toolkit v5

# Dynamic GitHub Script Loader

# https://github.com/rickpro2/RMPIT-TechToolkit

# =====================================================

# ==============================

# FORCE ADMIN

# ==============================

function Test-IsAdmin {
$identity=[Security.Principal.WindowsIdentity]::GetCurrent()
$principal=New-Object Security.Principal.WindowsPrincipal($identity)
return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

if(-not(Test-IsAdmin)){
$psi=New-Object System.Diagnostics.ProcessStartInfo
$psi.FileName="powershell.exe"
$psi.Arguments="-ExecutionPolicy Bypass -NoProfile -File `"$PSCommandPath`""
$psi.Verb="runas"
try{[System.Diagnostics.Process]::Start($psi)|Out-Null}catch{exit}
exit
}

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# ==============================

# CONFIG

# ==============================

$Version="5.0"

$Repo="rickpro2/RMPIT-TechToolkit"

$RepoRaw="https://raw.githubusercontent.com/$Repo/main"

$RepoAPI="https://api.github.com/repos/$Repo/contents/Scripts"

$IconURL="$RepoRaw/Assets/icon.ico"

$VersionURL="$RepoRaw/Launcher/version.txt"

$LauncherURL="$RepoRaw/Launcher/RMPIT-TechToolkit.ps1"

# ==============================

# AUTO UPDATE

# ==============================

function Check-ToolkitUpdate{

try{

$remote=(Invoke-RestMethod $VersionURL).Trim()

if($remote -ne $Version){

$result=[System.Windows.Forms.MessageBox]::Show(
"New version $remote available. Update?",
"Toolkit Update",
"YesNo",
"Information"
)

if($result -eq "Yes"){

$temp="$env:TEMP\RMPIT-TechToolkit.ps1"

Invoke-WebRequest $LauncherURL -OutFile $temp

Start-Process powershell `-ArgumentList "-ExecutionPolicy Bypass -File`"$temp`"" `
-Verb RunAs

exit
}

}

}catch{}

}

Check-ToolkitUpdate

# ==============================

# ICON

# ==============================

$tempIcon="$env:TEMP\rmpit.ico"

try{Invoke-WebRequest $IconURL -OutFile $tempIcon}catch{}

# ==============================

# FORM

# ==============================

$form=New-Object System.Windows.Forms.Form
$form.Text="RMPIT Tech Toolkit v$Version"
$form.Size=New-Object System.Drawing.Size(1000,700)
$form.StartPosition="CenterScreen"

if(Test-Path $tempIcon){
$form.Icon=New-Object System.Drawing.Icon($tempIcon)
}

# ==============================

# TITLE

# ==============================

$title=New-Object System.Windows.Forms.Label
$title.Text="RMPIT Tech Toolkit"
$title.Font=New-Object System.Drawing.Font("Segoe UI",18,[System.Drawing.FontStyle]::Bold)
$title.AutoSize=$true
$title.Location=New-Object System.Drawing.Point(20,20)

$form.Controls.Add($title)

# ==============================

# DARK MODE

# ==============================

$themeToggle=New-Object System.Windows.Forms.CheckBox
$themeToggle.Text="Dark Mode"
$themeToggle.Location=New-Object System.Drawing.Point(220,28)
$form.Controls.Add($themeToggle)

# ==============================

# SEARCH

# ==============================

$searchBox=New-Object System.Windows.Forms.TextBox
$searchBox.Size=New-Object System.Drawing.Size(300,25)
$searchBox.Location=New-Object System.Drawing.Point(640,25)
$form.Controls.Add($searchBox)

# ==============================

# TABS

# ==============================

$tabs=New-Object System.Windows.Forms.TabControl
$tabs.Size=New-Object System.Drawing.Size(940,400)
$tabs.Location=New-Object System.Drawing.Point(20,70)

$form.Controls.Add($tabs)

# ==============================

# PROGRESS BAR

# ==============================

$progress=New-Object System.Windows.Forms.ProgressBar
$progress.Size=New-Object System.Drawing.Size(940,20)
$progress.Location=New-Object System.Drawing.Point(20,440)
$form.Controls.Add($progress)

# ==============================

# OUTPUT

# ==============================

$output=New-Object System.Windows.Forms.TextBox
$output.Multiline=$true
$output.ScrollBars="Vertical"
$output.Size=New-Object System.Drawing.Size(940,150)
$output.Location=New-Object System.Drawing.Point(20,480)
$output.ReadOnly=$true
$form.Controls.Add($output)

# ==============================

# STATUS

# ==============================

$statusBar=New-Object System.Windows.Forms.StatusStrip
$statusLabel=New-Object System.Windows.Forms.ToolStripStatusLabel
$statusLabel.Text="Ready"

$statusBar.Items.Add($statusLabel)
$form.Controls.Add($statusBar)

# ==============================

# OUTPUT WRITER

# ==============================

function Write-OutputBox($text){

$output.AppendText("$text`r`n")
$output.SelectionStart=$output.Text.Length
$output.ScrollToCaret()

}

# ==============================

# RUN TOOL

# ==============================

function Run-Tool($Name,$URL){

try{

Write-OutputBox "Launching $Name"

if($URL -match "christitus.com"){

Start-Process powershell `-ArgumentList "-ExecutionPolicy Bypass -Command`"irm '$URL' | iex`"" `
-Verb RunAs

return
}

$file=[System.IO.Path]::GetFileName($URL)

$temp=Join-Path $env:TEMP $file

Invoke-WebRequest $URL -OutFile $temp

switch -Regex ($file){

".ps1$"{
Start-Process powershell `-ArgumentList "-ExecutionPolicy Bypass -File`"$temp`"" `
-Verb RunAs
}

".(bat|cmd)$"{
Start-Process cmd `-ArgumentList "/c`"$temp`"" `
-Verb RunAs
}

".exe$"{
Start-Process $temp -Verb RunAs
}

}

$statusLabel.Text="Running $Name"

}catch{

Write-OutputBox "Failed to run $Name"

}

}

# ==============================

# LOAD SCRIPTS FROM GITHUB

# ==============================

function Load-GitHubScripts{

Write-OutputBox "Scanning GitHub scripts..."

$folders=Invoke-RestMethod $RepoAPI

$progress.Maximum=$folders.Count
$i=0

foreach($folder in $folders){

if($folder.type -ne "dir"){continue}

$i++
$progress.Value=$i

$tab=New-Object System.Windows.Forms.TabPage
$tab.Text=$folder.name
$tabs.TabPages.Add($tab)

$scriptAPI=$folder.url

$scripts=Invoke-RestMethod $scriptAPI

$x=20
$y=20

foreach($script in $scripts){

if($script.type -ne "file"){continue}

$name=[System.IO.Path]::GetFileNameWithoutExtension($script.name)

$url=$script.download_url

$btn=New-Object System.Windows.Forms.Button
$btn.Text=$name
$btn.Size=New-Object System.Drawing.Size(200,40)
$btn.Location=New-Object System.Drawing.Point($x,$y)

$btn.Add_Click({Run-Tool $name $url})

$tab.Controls.Add($btn)

$y+=50

}

}

$progress.Value=0

Write-OutputBox "Toolkit Ready"

}

Load-GitHubScripts

# ==============================

# SEARCH

# ==============================

$searchBox.Add_TextChanged({

$q=$searchBox.Text.ToLower()

foreach($tab in $tabs.TabPages){

foreach($ctrl in $tab.Controls){

if($ctrl -is [System.Windows.Forms.Button]){

$ctrl.Visible=$ctrl.Text.ToLower().Contains($q)

}

}

}

})

# ==============================

# DARK MODE FUNCTIONS

# ==============================

function Set-Dark{

$form.BackColor="#1e1e1e"
$form.ForeColor="White"
$output.BackColor="#2d2d2d"
$output.ForeColor="White"

foreach($tab in $tabs.TabPages){

$tab.BackColor="#1e1e1e"

foreach($ctrl in $tab.Controls){

if($ctrl -is [System.Windows.Forms.Button]){

$ctrl.BackColor="#333"
$ctrl.ForeColor="White"

}

}

}

}

function Set-Light{

$form.BackColor="White"
$form.ForeColor="Black"
$output.BackColor="White"
$output.ForeColor="Black"

}

$themeToggle.Add_CheckedChanged({

if($themeToggle.Checked){Set-Dark}else{Set-Light}

})

Set-Light

# ==============================

# START

# ==============================

Write-OutputBox "RMPIT Toolkit Started"
Write-OutputBox "Version $Version"

$form.ShowDialog()
