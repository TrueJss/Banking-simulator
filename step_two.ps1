#begin processing step 2
$form_Processing_step2                 = New-Object system.Windows.Forms.Form -Property @{
    ClientSize      = '400,150'
    Text            = "Процессинг"
    TopMost         = $false
    StartPosition = [Windows.Forms.FormStartPosition]::CenterScreen
    FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::Fixed3D
}

$grBoxProcessing_step2                 = New-Object system.Windows.Forms.Groupbox -Property @{
    Height          = 100
    Width           = 400
    Location        = New-Object System.Drawing.Point(0,25)
}

$lblProcessing_step2                   = New-Object system.Windows.Forms.Label -Property @{
    Text              = "Требуется ли закрыть действующие счета?"
    AutoSize          = $true
    Location          = New-Object System.Drawing.Point(65,5)
    Font              = 'Microsoft Sans Serif,10'
}

$btnProcessing_step2_Yes                = New-Object system.Windows.Forms.Button -Property @{
    Text           = "Да"
    Width          = 100
    Height         = 50
    Location       = New-Object System.Drawing.Point(67,25)
    Font           = 'Microsoft Sans Serif,10'
}

$btnProcessing_step2_Yes.Add_Click({
       $form_Processing_step2.Close()
       $form_Processing_step2.Dispose()
       . .\accounts_close.ps1
})

$btnProcessing_step2_No                 = New-Object system.Windows.Forms.Button -Property @{
    Text            = "Нет"
    Width           = 100
    Height          = 50
    Location        = New-Object System.Drawing.Point(234,25)
    Font            = 'Microsoft Sans Serif,10'
}

$btnProcessing_step2_No.Add_Click({
       $form_Processing_step2.Close()
       $form_Processing_step2.Dispose()
       . .\step_three.ps1
})

$form_Processing_step2.controls.AddRange(@($grBoxProcessing_step2,$lblProcessing_step2))
$grBoxProcessing_step2.controls.AddRange(@($btnProcessing_step2_Yes,$btnProcessing_step2_No))
#end processing step 2

$form_Processing_step2.ShowDialog()