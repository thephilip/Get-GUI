# Get-GUI
A PowerShell module to build basic interfaces.

## Usage Example
```powershell
# copy Get-GUI module to %userprofile%\documents\WindowsPowerShell\Modules
Import-Module Get-GUI

$form = New-Form -size @(415,100) -title "Form Title"
$label = New-Label -size @(75,30) -location @(15,17) -text "Dat label tho"
$textbox = New-TextBox -text "default text" -location @(95,15)
$statusbar = New-StatusBar -text "Ready."
$actions = {
  $statusbar.Text = "Running..."
  New-MessageBox -title "Message" -text "Button clicked!" -action $view
  $statusbar.Text = "Ready."
}
$btn = New-Button -text "Touch Me" -location @(275,12) -action $actions

Render -gui @(
  $form,
  $label,
  $textbox,
  $btn,
  $statusbar
)
```

## Produces 
![demo_form](https://raw.githubusercontent.com/thephilip/Get-GUI/master/demo_form.PNG)
