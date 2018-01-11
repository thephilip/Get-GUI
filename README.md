# Get-GUI
A PowerShell module to build basic interfaces.

## Usage Example
```powershell
# copy Get-GUI module to %userprofile%\documents\WindowsPowerShell\Modules
Import-Module Get-GUI

$form = New-Form -size @(415,100) -title "Form Title"
$pc_label = New-Label -size @(75,30) -location @(15,17) -text "Dat label tho"
$pc_textbox = New-TextBox -text "default text" -location @(95,15)
$statusbar = New-StatusBar -text "Ready."
$actions = {
  $statusbar.Text = "Running..."
  New-MessageBox -title "Message" -text "Button clicked!" -action $view
  $statusbar.Text = "Ready."
}
$host_btn = New-Button -text "Touch Me" -location @(275,12) -action $actions

Render -gui @(
  $form,
  $pc_label,
  $pc_textbox,
  $host_btn,
  $statusbar
)
`
