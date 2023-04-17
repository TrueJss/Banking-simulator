Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

Set-Location $PSScriptRoot

$ProcessingStart               = New-Object system.Windows.Forms.Form -Property @{
    ClientSize    = '260,210'
    Text          = "Авторизация"
    StartPosition = [Windows.Forms.FormStartPosition]::CenterScreen
    FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::Fixed3D
}

$grBoxConnection    = New-Object system.Windows.Forms.Groupbox -Property @{
    Height       = 210
    Width        = 260
    Anchor       = 'top,right,left'
    Location     = New-Object System.Drawing.Point(1,1)
}
                    
$lblServerName      = New-Object system.Windows.Forms.Label -Property @{
    Text       = "Сервер:"
    AutoSize   = $true
    Width      = 25
    Height     = 20
    Anchor     = 'bottom'
    Location   = New-Object System.Drawing.Point(5,10)
    Font       = 'Microsoft Sans Serif,10'
}
                    
$txtServerName      = New-Object system.Windows.Forms.TextBox -Property @{
    Multiline  = $false
    Width      = 130
    Height     = 20
    Anchor     = 'top'
    Location   = New-Object System.Drawing.Point(65,9)
    Font       = 'Microsoft Sans Serif,10'
    Text       = "localhost"
}

$chBoxSSPI          = New-Object system.Windows.Forms.CheckBox -Property @{
    Text     = "SSPI"
    AutoSize = $false
    Width    = 55
    Height   = 20
    Anchor   = 'bottom'
    Location = New-Object System.Drawing.Point(203,9)
    Font     = 'Microsoft Sans Serif,10'
    Checked  = $false
}
                    
$lblLogin           = New-Object system.Windows.Forms.Label -Property @{
    Text     = "Логин:"
    AutoSize = $true
    Width    = 25
    Height   = 20
    Anchor   = 'bottom'
    Location = New-Object System.Drawing.Point(5,42)
    Font     = 'Microsoft Sans Serif,10'
}
                    
$txtLogin           = New-Object system.Windows.Forms.TextBox -Property @{
    Multiline = $false
    Width     = 190
    Height    = 20
    Anchor    = 'top'
    Location  = New-Object System.Drawing.Point(65,39)
    Font      = 'Microsoft Sans Serif,10'
}
                    
$lblPassword        = New-Object system.Windows.Forms.Label -Property @{
    Text     = "Пароль:"
    AutoSize = $true
    Width    = 25
    Height   = 20
    Anchor   = 'bottom'
    Location = New-Object System.Drawing.Point(5,72)
    Font     = 'Microsoft Sans Serif,10'
}
                    
$txtPassword        = New-Object system.Windows.Forms.TextBox -Property @{
    Multiline    = $false
    Width        = 190
    Height       = 20
    Anchor       = 'top'
    Location     = New-Object System.Drawing.Point(65,69)
    Font         = 'Microsoft Sans Serif,10'
    PasswordChar = '*'
}
                                      
$btnConnectTest     = New-Object system.Windows.Forms.Button -Property @{
    Text        = "Проверка подключения"
    Width       = 250
    Height      = 25
    Anchor      = 'top'
    Location    = New-Object System.Drawing.Point(5,99)
    Font        = 'Microsoft Sans Serif,10'
    Name        = "btnConnectTest"
}
                    
$lblDataBase        = New-Object system.Windows.Forms.Label -Property @{
    Text     = "База данных:"
    AutoSize = $false
    Width    = 60
    Height   = 30
    Anchor   = 'bottom'
    Location = New-Object System.Drawing.Point(5,130)
    Font     = 'Microsoft Sans Serif,10'
}
                    
$cboxDataBase       = New-Object system.Windows.Forms.ComboBox -Property @{
    Width         = 190
    Height        = 20
    Location      = New-Object System.Drawing.Point(65,130)
    Font          = 'Microsoft Sans Serif,10'
    DropDownStyle = [System.Windows.Forms.ComboBoxStyle]::DropDownList
}

$btnNext             = New-Object system.Windows.Forms.Button -Property @{
    Text     = "Далее"
    Width    = 250
    Height   = 25
    Anchor   = 'top'
    Location = New-Object System.Drawing.Point(5,165)
    Font     = 'Microsoft Sans Serif,10'
}

$ProcessingStart.controls.AddRange(@($grBoxConnection))
$grBoxConnection.controls.AddRange(@($lblServerName,$txtServerName,$lblLogin,$txtLogin,$lblPassword,$txtPassword,$chBoxSSPI,$cboxDataBase,$lblDataBase, $btnConnectTest,$btnNext))

function btnConnectTest_Click() 
{
    try{
        if($chBoxSSPI.Checked){
            $server = $txtServerName.Text
            $txtLogin.Enabled = $false
            $txtPassword.Enabled = $false
            $global:conn = new-object System.Data.SqlClient.SqlConnection("Data Source = $server;Integrated Security=SSPI;Initial Catalog=master");
        }
        else{
            $server = $txtServerName.Text
            $txtLogin.Enabled = $true
            $txtPassword.Enabled = $true
            $uid = $txtLogin.Text
            $pwd = $txtPassword.Text
            $global:conn = new-object System.Data.SqlClient.SqlConnection("Data Source = $server;User ID = $uid; Password = $pwd;Initial Catalog=master");   
        }

        $global:conn.Open()
        Write-Host $global:conn.Database "first_db"
        $command = new-object system.data.sqlclient.Sqlcommand("select name from sys.databases where database_id > 4 order by name",$global:conn)
        $adapter = New-Object System.Data.sqlclient.SqlDataAdapter $command
        $datatable = New-Object System.Data.DataTable
        $adapter.Fill($datatable) | Out-Null
        $cboxDataBase.DataSource = $datatable
        $cboxDataBase.DisplayMember = "name"
        $true
        } catch {
            if ($_.Exception.Message -match 'cannot open server') {
            $false
            } else {
                throw $_
            }
        } 
}

$btnConnectTest.Add_Click({ btnConnectTest_Click })

$cboxDataBase.add_SelectedIndexChanged(
    { 
        $script:InitDB = $cboxDataBase.SelectedItem.name
        $global:conn.ChangeDatabase($InitDB)
        Write-Host $global:conn.Database "2nd_db"
    })

$btnNext.Add_Click({
       $ProcessingStart.Close()
       $ProcessingStart.Dispose()
       . .\step_one.ps1
})

$ProcessingStart.ShowDialog()