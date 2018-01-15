
# load assemblies
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
[void] [System.Reflection.Assembly]::LoadWithPartialName("Microsoft.VisualBasic")


# New-Form :: [Array],[String],[String] -> [Object]
function New-Form {
  PARAM(
    [Array]$size = @(700,500),          # width,height in px
    [String]$title = "",                # form title text
    [String]$position = "CenterScreen"  # position on screen
  )

  $form = New-Object System.Windows.Forms.Form
  $form.Size = New-Object System.Drawing.Size($size.ForEach({Write-Output $_}) -join ",")
  $form.Text = $title
  $form.StartPosition = $position
  $form.Font = "Segoe UI"
  $form.MaximizeBox = $false
  $form.TopMost = $true

  return $form
}


# New-Label :: [Array],[Array],[String] -> [Object]
function New-Label {
  PARAM(
    [Array]$size = @(50,30),            # width, height in px
    [Array]$location,                   # position in px from left, top
    [String]$text                       # label content
  )

  $label = New-Object System.Windows.Forms.Label
  $label.Location = New-Object System.Drawing.Size($location.ForEach({Write-Output $_}) -join ",")
  $label.Size = New-Object System.Drawing.Size($size.ForEach({Write-Output $_}) -join ",")
  $label.Text = $text

  return $label
}


# New-TextBox :: [Array],[Array],[String] -> [Object]
function New-TextBox {
  PARAM(
    [Array]$size = @(175,30),           # width, height in px
    [Array]$location,                   # position in px from left,top
    [String]$text                       # default textbox content
  )

  $textbox = New-Object System.Windows.Forms.TextBox
  $textbox.Location = New-Object System.Drawing.Size($location.ForEach({Write-Output $_}) -join ",")
  $textbox.Size = New-Object System.Drawing.Size($size.ForEach({Write-Output $_}) -join ",")
  $textbox.Text = $text

  return $textbox
}


function New-ListView {
  PARAM(
    [Array]$size,
    [Array]$location,
    [String]$view = "Details"
  )

  $listview = New-Object System.Windows.Forms.ListView
  $listview.Location = New-Object System.Drawing.Size($location.ForEach({Write-Output $_}) -join ",")
  $listview.Size = New-Object System.Drawing.Size($size.ForEach({Write-Output $_}) -join ",")
  $listview.View = $view

  return $listview
}


function New-ListViewItem {
  PARAM(
    $item
  )

  $list_item = New-Object System.Windows.Forms.ListViewItem($item)

  return $list_item
}


# New-Button :: [Array],[Array],[ScriptBlock] -> [Object]
function New-Button {
  PARAM(
    [Array]$location,                   # position in px from left,top
    [Array]$size,                       # width, height of button
    [String]$text = "Click Me",         # button text content
    $action                             # button click event action
  )

  $button = New-Object System.Windows.Forms.Button
  $button.Location = New-Object System.Drawing.Size($location.ForEach({Write-Output $_}) -join ",")
  $button.Size = New-Object System.Drawing.Size($size.ForEach({Write-Output $_}) -join ",")
  $button.Text = $text
  $button.Add_Click($action)

  return $button
}


# New-MessageBox :: [String],[String],[ScriptBlock] -> [Object]
function New-MessageBox {
  PARAM(
    [String]$title = "System Message",  # messagebox title text
    [String]$text = "Hello, world!",    # messagebox text
    [String]$buttons = "OK",            # messagebox buttons
    [String]$icon = "Asterisk",         # messagebox icon type
    [String]$callback                   # callback action (if any)
  )
  # available buttons: AbortRetryIgnore, OK, OKCancel, RetryCancel,
  #                    YesNo, YesNoCancel
  # --------------------------------------------------------------------
  # available icons: Asterisk, Error, Exclamation, Hand, Information,
  #                  None, Question, Stop, Warning

  $messagebox = [System.Windows.Forms.MessageBox]::Show($text, $title, $buttons, $icon)
  if ($callback) {
    {$callback}
  }

  return $messagebox
}


function New-InputBox {
  PARAM(
    [String]$prompt,
    [String]$title,
    [String]$default_text
  )

  $inputbox = [Microsoft.VisualBasic.Interaction]::InputBox($prompt, $title, $default_text)

  return $inputbox
}


# New-StatusBar :: [String], [String] -> [Object]
function New-StatusBar {
  PARAM(
    [String]$name = "sb_1",             # status bar name
    [String]$text                       # status bar text
  )

  $statusbar = New-Object System.Windows.Forms.StatusBar
  $statusbar.Name = $name
  $statusbar.Text = $text

  return $statusbar
}


# Get-ScriptBlock :: [String] -> [ScriptBlock]
function Get-ScriptBlock {
  PARAM( [String]$string )

  $scriptblock = [ScriptBlock]::Create($string)

  return $scriptblock
}


# New-GUI :: [Array] -> [Array]
function New-GUI {
  PARAM(
    [Array]$elements
  )

  $form = $elements[0]
  for($i=1; $i -lt $elements.Length; $i++) {
    $form.Controls.Add($elements[$i])
  }

  return $form
}


# Render :: [Array] -> [Void]
function Render {
  PARAM(
    [Array]$gui
  )

  $form = New-GUI -elements $gui
  $form.KeyPreview = $true
  $form.Add_KeyDown({
    if ($_.KeyCode -eq "Escape") {
      $form.Close()
    }
  })
  $form.Add_Shown({ $form.Activate() })
  
  [Void] $form.ShowDialog()
}
