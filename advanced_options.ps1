#begin processing advanced config
$form_Processing_options_adv                 = New-Object system.Windows.Forms.Form -Property @{
    ClientSize      = '400,550'
    Text            = "Настройки процессинга"
    TopMost         = $false
    StartPosition = [Windows.Forms.FormStartPosition]::CenterScreen
    FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::Fixed3D
}

$lblProcessing_options_adv                   = New-Object system.Windows.Forms.Label -Property @{
    Text              = "Расширенные настройки"
    AutoSize          = $true
    Location          = New-Object System.Drawing.Point(130,5)
    Font              = 'Microsoft Sans Serif,10'
}

$grBoxTbars_from_equires     = New-Object system.Windows.Forms.Groupbox -Property @{
    Height      = 205
    Width       = 400
    Location    = New-Object System.Drawing.Point(0,25)
    Text = "Пополнения от эквайеров"
}

$grBoxTbars_from_equires_atm     = New-Object system.Windows.Forms.Groupbox -Property @{
    Height      = 175
    Width       = 200
    Location    = New-Object System.Drawing.Point(0,25)
    Text = "Пополнения через банкоматы"
}

$tBarAtmKop     = New-Object Windows.Forms.TrackBar -Property @{
    Location      = New-Object System.Drawing.Point(0,15)
    Orientation   = "Horizontal"
    Width         = 160
    Height        = 10
    TickFrequency = 10
    TickStyle     = "TopLeft"
    Value         = 0
}
$tBarAtmKop.SetRange(0, 100)
$tbarAtmKopValue = 90
$global:AtmKopValue = 90

$txtAtmKopCount         = New-Object system.Windows.Forms.TextBox -Property @{
    Multiline = $false
    Width     = 36
    Height    = 15
    Anchor    = 'top'
    Location  = New-Object System.Drawing.Point(160,25)
    Font      = 'Microsoft Sans Serif,8'
    Text      = "$tbarAtmKopValue"
}

$txtAtmKopCount.add_TextChanged({
    $tbarAtmKopValue = $txtAtmKopCount.Text
    $lblAtmKopCount.Text = "Вероятность внесения суммы без копеек: $tbarAtmKopValue%"
    $tBarAtmKop.Value = $txtAtmKopCount.Text
    $this.Text = $this.Text -replace '\D'
})

$tBarAtmKop.add_ValueChanged({
    $tbarAtmKopValue = $tBarAtmKop.Value
    $lblAtmKopCount.Text = "Вероятность внесения суммы без копеек: $tbarAtmKopValue%"
    $txtAtmKopCount.Text = $tbarAtmKopValue
    $global:AtmKopValue = $tbarAtmKopValue
})

$lblAtmKopCount = New-Object System.Windows.Forms.Label -Property @{
    Width           = 170
    Height          = 30
    Location        = New-Object System.Drawing.Point(9,50)
    Font            = 'Microsoft Sans Serif,8'
    Text            = "Вероятность внесения суммы без копеек: $tbarAtmKopValue%"
}

$tBarAtmMultiply     = New-Object Windows.Forms.TrackBar -Property @{
    Location      = New-Object System.Drawing.Point(0,75)
    Orientation   = "Horizontal"
    Width         = 160
    Height        = 10
    TickFrequency = 10
    TickStyle     = "TopLeft"
    Value         = 0
}
$tBarAtmMultiply.SetRange(0, 100)
$tbarAtmMultiplyValue = 75
$global:AtmMultiplyValue = 75

$txtAtmMultiplyCount         = New-Object system.Windows.Forms.TextBox -Property @{
    Multiline = $false
    Width     = 36
    Height    = 15
    Anchor    = 'top'
    Location  = New-Object System.Drawing.Point(160,85)
    Font      = 'Microsoft Sans Serif,8'
    Text      = "$tbarAtmMultiplyValue"
}

$txtAtmMultiplyCount.add_TextChanged({
    $tbarAtmMultiplyValue = $txtAtmMultiplyCount.Text
    $lblAtmMultiplyCount.Text = "Вероятность внесения суммы, кратной N руб.: $tbarAtmMultiplyValue%"
    $tBarAtmMultiply.Value = $txtAtmMultiplyCount.Text
    $global:AtmMultiplyValue = $tbarAtmMultiplyValue
    $this.Text = $this.Text -replace '\D'
})

$tBarAtmMultiply.add_ValueChanged({
    $tbarAtmMultiplyValue = $tBarAtmMultiply.Value
    $lblAtmMultiplyCount.Text = "Вероятность внесения суммы, кратной N руб: $tbarAtmMultiplyValue%"
    $txtAtmMultiplyCount.Text = $tbarAtmMultiplyValue
    $global:AtmMultiplyValue = $tbarAtmMultiplyValue
})

$lblAtmMultiplyCount = New-Object System.Windows.Forms.Label -Property @{
    Width           = 170
    Height          = 30
    Location        = New-Object System.Drawing.Point(9,110)
    Font            = 'Microsoft Sans Serif,8'
    Text            = "Вероятность внесения суммы, кратной N руб: $tbarAtmMultiplyValue%"
}

$lblAtmMultiplier = New-Object System.Windows.Forms.Label -Property @{
    Width           = 70
    Height          = 30
    Location        = New-Object System.Drawing.Point(9,143)
    Font            = 'Microsoft Sans Serif,8'
    Text            = "Введите N:"
}

$txtAtmMultiplier         = New-Object system.Windows.Forms.TextBox -Property @{
    Multiline = $false
    Width     = 36
    Height    = 15
    Anchor    = 'top'
    Location  = New-Object System.Drawing.Point(160,140)
    Font      = 'Microsoft Sans Serif,8'
    Text      = 1000
}

$txtAtmMultiplier.add_TextChanged({
    $this.Text = $this.Text -replace '\D'
})

$grBoxTbars_from_equires_site     = New-Object system.Windows.Forms.Groupbox -Property @{
    Height      = 175
    Width       = 200
    Location    = New-Object System.Drawing.Point(200,25)
    Text = "Пополнения через сайты"
}

$tBarSiteKop     = New-Object Windows.Forms.TrackBar -Property @{
    Location      = New-Object System.Drawing.Point(0,15)
    Orientation   = "Horizontal"
    Width         = 160
    Height        = 10
    TickFrequency = 10
    TickStyle     = "TopLeft"
    Value         = 0
}
$tBarSiteKop.SetRange(0, 100)
$tbarSiteKopValue = 60
$global:SiteKopValue = 60

$txtSiteKopCount         = New-Object system.Windows.Forms.TextBox -Property @{
    Multiline = $false
    Width     = 36
    Height    = 15
    Anchor    = 'top'
    Location  = New-Object System.Drawing.Point(160,25)
    Font      = 'Microsoft Sans Serif,8'
    Text      = "$tbarSiteKopValue"
}

$txtSiteKopCount.add_TextChanged({
    $tbarSiteKopValue = $txtSiteKopCount.Text
    $lblSiteKopCount.Text = "Вероятность внесения суммы без копеек: $tbarSiteKopValue%"
    $tBarSiteKop.Value = $txtSiteKopCount.Text
    $global:SiteKopValue = $tbarSiteKopValue
    $this.Text = $this.Text -replace '\D'
})

$tBarSiteKop.add_ValueChanged({
    $tbarSiteKopValue = $tBarSiteKop.Value
    $lblSiteKopCount.Text = "Вероятность внесения суммы без копеек: $tbarSiteKopValue%"
    $txtSiteKopCount.Text = $tbarSiteKopValue
    $global:SiteKopValue = $tbarSiteKopValue
})

$lblSiteKopCount = New-Object System.Windows.Forms.Label -Property @{
    Width           = 170
    Height          = 30
    Location        = New-Object System.Drawing.Point(9,50)
    Font            = 'Microsoft Sans Serif,8'
    Text            = "Вероятность внесения суммы без копеек: $tbarSiteKopValue%"
}

$tBarSiteMultiply     = New-Object Windows.Forms.TrackBar -Property @{
    Location      = New-Object System.Drawing.Point(0,75)
    Orientation   = "Horizontal"
    Width         = 160
    Height        = 10
    TickFrequency = 10
    TickStyle     = "TopLeft"
    Value         = 0
}
$tBarSiteMultiply.SetRange(0, 100)
$tbarSiteMultiplyValue = 70
$global:SiteMultiplyValue = 70

$txtSiteMultiplyCount         = New-Object system.Windows.Forms.TextBox -Property @{
    Multiline = $false
    Width     = 36
    Height    = 15
    Anchor    = 'top'
    Location  = New-Object System.Drawing.Point(160,85)
    Font      = 'Microsoft Sans Serif,8'
    Text      = "$tbarSiteMultiplyValue"
}

$txtSiteMultiplyCount.add_TextChanged({
    $tbarSiteMultiplyValue = $txtSiteMultiplyCount.Text
    $lblSiteMultiplyCount.Text = "Вероятность внесения суммы, кратной N руб.: $tbarSiteMultiplyValue%"
    $tBarSiteMultiply.Value = $txtSiteMultiplyCount.Text
    $global:SiteMultiplyValue = $tbarSiteMultiplyValue
    $this.Text = $this.Text -replace '\D'
})

$tBarSiteMultiply.add_ValueChanged({
    $tbarSiteMultiplyValue = $tBarSiteMultiply.Value
    $lblSiteMultiplyCount.Text = "Вероятность внесения суммы, кратной N руб: $tbarSiteMultiplyValue%"
    $txtSiteMultiplyCount.Text = $tbarSiteMultiplyValue
    $global:SiteMultiplyValue = $tbarSiteMultiplyValue
})

$lblSiteMultiplyCount = New-Object System.Windows.Forms.Label -Property @{
    Width           = 170
    Height          = 30
    Location        = New-Object System.Drawing.Point(9,110)
    Font            = 'Microsoft Sans Serif,8'
    Text            = "Вероятность внесения суммы, кратной N руб: $tbarSiteMultiplyValue%"
}

$lblSiteMultiplier = New-Object System.Windows.Forms.Label -Property @{
    Width           = 70
    Height          = 30
    Location        = New-Object System.Drawing.Point(9,143)
    Font            = 'Microsoft Sans Serif,8'
    Text            = "Введите N:"
}

$txtSiteMultiplier         = New-Object system.Windows.Forms.TextBox -Property @{
    Multiline = $false
    Width     = 36
    Height    = 15
    Anchor    = 'top'
    Location  = New-Object System.Drawing.Point(160,140)
    Font      = 'Microsoft Sans Serif,8'
    Text      = 100
}

$txtSiteMultiplier.add_TextChanged({
    $this.Text = $this.Text -replace '\D'
})

$grBoxTbars_to_stores     = New-Object system.Windows.Forms.Groupbox -Property @{
    Height      = 120
    Width       = 400
    Location    = New-Object System.Drawing.Point(0,230)
    Text = "Оплата в магазины"
}

$tBarStoreKop     = New-Object Windows.Forms.TrackBar -Property @{
    Location      = New-Object System.Drawing.Point(0,15)
    Orientation   = "Horizontal"
    Width         = 160
    Height        = 10
    TickFrequency = 10
    TickStyle     = "TopLeft"
    Value         = 0
}
$tBarStoreKop.SetRange(0, 100)
$tbarStoreKopValue = 60
$global:StoreKopValue = 60

$txtStoreKopCount         = New-Object system.Windows.Forms.TextBox -Property @{
    Multiline = $false
    Width     = 36
    Height    = 15
    Anchor    = 'top'
    Location  = New-Object System.Drawing.Point(160,25)
    Font      = 'Microsoft Sans Serif,8'
    Text      = "$tbarStoreKopValue"
}

$txtStoreKopCount.add_TextChanged({
    $tbarStoreKopValue = $txtStoreKopCount.Text
    $lblStoreKopCount.Text = "Вероятность внесения суммы без копеек: $tbarStoreKopValue%"
    $tBarStoreKop.Value = $txtStoreKopCount.Text
    $global:StoreKopValue = $tbarStoreKopValue
    $this.Text = $this.Text -replace '\D'
})

$tBarStoreKop.add_ValueChanged({
    $tbarStoreKopValue = $tBarStoreKop.Value
    $lblStoreKopCount.Text = "Вероятность внесения суммы без копеек: $tbarStoreKopValue%"
    $txtStoreKopCount.Text = $tbarStoreKopValue
    $global:StoreKopValue = $tbarStoreKopValue
})

$lblStoreKopCount = New-Object System.Windows.Forms.Label -Property @{
    Width           = 170
    Height          = 30
    Location        = New-Object System.Drawing.Point(9,50)
    Font            = 'Microsoft Sans Serif,8'
    Text            = "Вероятность внесения суммы без копеек: $tbarStoreKopValue%"
}

$tBarStoreMultiply     = New-Object Windows.Forms.TrackBar -Property @{
    Location      = New-Object System.Drawing.Point(200,15)
    Orientation   = "Horizontal"
    Width         = 160
    Height        = 10
    TickFrequency = 10
    TickStyle     = "TopLeft"
    Value         = 0
}
$tBarStoreMultiply.SetRange(0, 100)
$tbarStoreMultiplyValue = 60
$global:StoreMultiplyValue = 60

$txtStoreMultiplyCount         = New-Object system.Windows.Forms.TextBox -Property @{
    Multiline = $false
    Width     = 36
    Height    = 15
    Anchor    = 'top'
    Location  = New-Object System.Drawing.Point(360,25)
    Font      = 'Microsoft Sans Serif,8'
    Text      = "$tbarStoreMultiplyValue"
}

$txtStoreMultiplyCount.add_TextChanged({
    $tbarStoreMultiplyValue = $txtStoreMultiplyCount.Text
    $lblStoreMultiplyCount.Text = "Вероятность внесения суммы, кратной N руб.: $tbarStoreMultiplyValue%"
    $tBarStoreMultiply.Value = $txtStoreMultiplyCount.Text
    $global:StoreMultiplyValue = $tbarStoreMultiplyValue
    $this.Text = $this.Text -replace '\D'
})

$tBarStoreMultiply.add_ValueChanged({
    $tbarStoreMultiplyValue = $tBarStoreMultiply.Value
    $lblStoreMultiplyCount.Text = "Вероятность внесения суммы, кратной N руб: $tbarStoreMultiplyValue%"
    $txtStoreMultiplyCount.Text = $tbarStoreMultiplyValue
    $global:StoreMultiplyValue = $tbarStoreMultiplyValue
})

$lblStoreMultiplyCount = New-Object System.Windows.Forms.Label -Property @{
    Width           = 170
    Height          = 30
    Location        = New-Object System.Drawing.Point(209,50)
    Font            = 'Microsoft Sans Serif,8'
    Text            = "Вероятность внесения суммы, кратной N руб: $tbarStoreMultiplyValue%"
}

$lblStoreMultiplier = New-Object System.Windows.Forms.Label -Property @{
    Width           = 70
    Height          = 30
    Location        = New-Object System.Drawing.Point(9,85)
    Font            = 'Microsoft Sans Serif,8'
    Text            = "Введите N:"
}

$txtStoreMultiplier         = New-Object system.Windows.Forms.TextBox -Property @{
    Multiline = $false
    Width     = 36
    Height    = 15
    Anchor    = 'top'
    Location  = New-Object System.Drawing.Point(160,80)
    Font      = 'Microsoft Sans Serif,8'
    Text      = 1000
}

$txtStoreMultiplier.add_TextChanged({
    $this.Text = $this.Text -replace '\D'
})

$grBoxTbars_eds     = New-Object system.Windows.Forms.Groupbox -Property @{
    Height      = 155
    Width       = 400
    Location    = New-Object System.Drawing.Point(0,350)
    Text = "Перевод ЭДС"
}

$tBarEdsKop     = New-Object Windows.Forms.TrackBar -Property @{
    Location      = New-Object System.Drawing.Point(0,15)
    Orientation   = "Horizontal"
    Width         = 160
    Height        = 10
    TickFrequency = 10
    TickStyle     = "TopLeft"
    Value         = 0
}
$tBarEdsKop.SetRange(0, 100)
$tbarEdsKopValue = 50
$global:EdsKopValue = 50

$txtEdsKopCount         = New-Object system.Windows.Forms.TextBox -Property @{
    Multiline = $false
    Width     = 36
    Height    = 15
    Anchor    = 'top'
    Location  = New-Object System.Drawing.Point(160,25)
    Font      = 'Microsoft Sans Serif,8'
    Text      = "$tbarEdsKopValue"
}

$txtEdsKopCount.add_TextChanged({
    $tbarEdsKopValue = $txtEdsKopCount.Text
    $lblEdsKopCount.Text = "Вероятность внесения суммы без копеек: $tbarEdsKopValue%"
    $tBarEdsKop.Value = $txtEdsKopCount.Text
    $global:EdsKopValue = $tbarEdsKopValue
    $this.Text = $this.Text -replace '\D'
})

$tBarEdsKop.add_ValueChanged({
    $tbarEdsKopValue = $tBarEdsKop.Value
    $lblEdsKopCount.Text = "Вероятность внесения суммы без копеек: $tbarEdsKopValue%"
    $txtEdsKopCount.Text = $tbarEdsKopValue
    $global:EdsKopValue = $tbarEdsKopValue
})

$lblEdsKopCount = New-Object System.Windows.Forms.Label -Property @{
    Width           = 170
    Height          = 30
    Location        = New-Object System.Drawing.Point(9,50)
    Font            = 'Microsoft Sans Serif,8'
    Text            = "Вероятность внесения суммы без копеек: $tbarEdsKopValue%"
}

$tBarEdsMultiply     = New-Object Windows.Forms.TrackBar -Property @{
    Location      = New-Object System.Drawing.Point(200,15)
    Orientation   = "Horizontal"
    Width         = 160
    Height        = 10
    TickFrequency = 10
    TickStyle     = "TopLeft"
    Value         = 0
}
$tBarEdsMultiply.SetRange(0, 100)
$tbarEdsMultiplyValue = 50
$global:EdsMultiplyValue = 50

$txtEdsMultiplyCount         = New-Object system.Windows.Forms.TextBox -Property @{
    Multiline = $false
    Width     = 36
    Height    = 15
    Anchor    = 'top'
    Location  = New-Object System.Drawing.Point(360,25)
    Font      = 'Microsoft Sans Serif,8'
    Text      = "$tbarEdsMultiplyValue"
}

$txtEdsMultiplyCount.add_TextChanged({
    $tbarEdsMultiplyValue = $txtEdsMultiplyCount.Text
    $lblEdsMultiplyCount.Text = "Вероятность внесения суммы, кратной N руб.: $tbarEdsMultiplyValue%"
    $tBarEdsMultiply.Value = $txtEdsMultiplyCount.Text
    $global:EdsMultiplyValue = $tbarEdsMultiplyValue
    $this.Text = $this.Text -replace '\D'
})

$tBarEdsMultiply.add_ValueChanged({
    $tbarEdsMultiplyValue = $tBarEdsMultiply.Value
    $lblEdsMultiplyCount.Text = "Вероятность внесения суммы, кратной N руб: $tbarEdsMultiplyValue%"
    $txtEdsMultiplyCount.Text = $tbarEdsMultiplyValue
    $global:EdsMultiplyValue = $tbarEdsMultiplyValue
})

$lblEdsMultiplyCount = New-Object System.Windows.Forms.Label -Property @{
    Width           = 170
    Height          = 30
    Location        = New-Object System.Drawing.Point(209,50)
    Font            = 'Microsoft Sans Serif,8'
    Text            = "Вероятность внесения суммы, кратной N руб: $tbarEdsMultiplyValue%"
}

$lblEdsMultiplier = New-Object System.Windows.Forms.Label -Property @{
    Width           = 70
    Height          = 30
    Location        = New-Object System.Drawing.Point(209,87)
    Font            = 'Microsoft Sans Serif,8'
    Text            = "Введите N:"
}

$txtEdsMultiplier         = New-Object system.Windows.Forms.TextBox -Property @{
    Multiline = $false
    Width     = 36
    Height    = 15
    Anchor    = 'top'
    Location  = New-Object System.Drawing.Point(360,82)
    Font      = 'Microsoft Sans Serif,8'
    Text      = 10
}

$txtEdsMultiplier.add_TextChanged({
    $this.Text = $this.Text -replace '\D'
})

$tBarEdsFee     = New-Object Windows.Forms.TrackBar -Property @{
    Location      = New-Object System.Drawing.Point(0,75)
    Orientation   = "Horizontal"
    Width         = 160
    Height        = 10
    TickFrequency = 10
    TickStyle     = "TopLeft"
    Value         = 0
}
$tBarEdsFee.SetRange(0, 100)
$tbarEdsFeeValue = 10
$global:EdsFeeValue = 10

$txtEdsFeeCount         = New-Object system.Windows.Forms.TextBox -Property @{
    Multiline = $false
    Width     = 36
    Height    = 15
    Anchor    = 'top'
    Location  = New-Object System.Drawing.Point(160,85)
    Font      = 'Microsoft Sans Serif,8'
    Text      = "$tbarEdsFeeValue"
}

$txtEdsFeeCount.add_TextChanged({
    $tbarEdsFeeValue = $txtEdsFeeCount.Text
    $tbarEdsFeeValue_ = $tbarEdsFeeValue/1000
    $tbarEdsFeeValue_lbl = $tbarEdsFeeValue/10
    $lblEdsFeeCount.Text = "Комиссия за перевод: $tbarEdsFeeValue_lbl%"
    $tBarEdsFee.Value = $txtEdsFeeCount.Text
    $global:EdsFeeValue = $tbarEdsFeeValue_
    $this.Text = $this.Text -replace '\D'
})

$tBarEdsFee.add_ValueChanged({
    $tbarEdsFeeValue = $tBarEdsFee.Value
    $tbarEdsFeeValue_ = $tbarEdsFeeValue/1000
    $tbarEdsFeeValue_lbl = $tbarEdsFeeValue/10
    $lblEdsFeeCount.Text = "Комиссия за перевод: $tbarEdsFeeValue_lbl%"
    $txtEdsFeeCount.Text = $tbarEdsFeeValue
    $global:EdsFeeValue = $tbarEdsFeeValue_
})

$tbarEdsFeeValue_ = $tbarEdsFeeValue/1000
$tbarEdsFeeValue_lbl = $tbarEdsFeeValue/10
$global:EdsFeeValue = $tbarEdsFeeValue_

$lblEdsFeeCount = New-Object System.Windows.Forms.Label -Property @{
    Width           = 170
    Height          = 30
    Location        = New-Object System.Drawing.Point(9,110)
    Font            = 'Microsoft Sans Serif,8'
    Text            = "Комиссия за перевод: $tbarEdsFeeValue_lbl%"
}

$lblEdsMinFee = New-Object System.Windows.Forms.Label -Property @{
    Width           = 150
    Height          = 30
    Location        = New-Object System.Drawing.Point(209,117)
    Font            = 'Microsoft Sans Serif,8'
    Text            = "Минимальный размер комиссии (руб.):"
}

$txtEdsMinFee         = New-Object system.Windows.Forms.TextBox -Property @{
    Multiline = $false
    Width     = 36
    Height    = 15
    Anchor    = 'top'
    Location  = New-Object System.Drawing.Point(360,115)
    Font      = 'Microsoft Sans Serif,8'
    Text      = 1
}

$txtEdsMinFee.add_TextChanged({
    $this.Text = $this.Text -replace '\D'
})

$btnNext_options_adv             = New-Object system.Windows.Forms.Button -Property @{
    Text     = "Запуск"
    Width    = 187
    Height   = 30
    Anchor   = 'top'
    Location = New-Object System.Drawing.Point(209,510)
    Font     = 'Microsoft Sans Serif,10'
}

$prBar = New-Object System.Windows.Forms.ProgressBar -Property @{
    Width    = 196
    Height   = 30
    Maximum  = 100
    Minimum  = 0
    Location = new-object System.Drawing.Size(5,510)
}

function btnNext_options_adv_Click() 
{
    write-host $global:EquireFeeValue "equire_fee"
    write-host $global:ReturnRateValue "return"
    write-host $global:minDate_ "min dt"
    write-host $global:maxDate_ "max_dt"
    write-host $global:DayQtyValue "qty"
    write-host $global:StoreFeeValue "store_fee"
    write-host $global:StoreMultiplyValue "tt"

    try{
        $global:AtmMultiplier = $txtAtmMultiplier.Text
        $global:SiteMultiplier = $txtSiteMultiplier.Text
        $global:StoreMultiplier = $txtStoreMultiplier.Text
        $global:EdsMultiplier = $txtEdsMultiplier.Text 
        $global:EdsMinFee = $txtEdsMinFee.Text
        $cmd=$global:conn.CreateCommand()
        $cmd.CommandTimeout=0

#begin drop functions
        $cmd.CommandText = "
        if object_id(N'dbo.new_operation') is not null drop procedure dbo.new_operation
        if object_id(N'dbo.new_ost') is not null drop procedure dbo.new_ost
        if object_id(N'dbo.main') is not null drop procedure dbo.main
        if object_id(N'dbo.new_from_equires') is not null drop procedure dbo.new_from_equires
        if object_id(N'dbo.new_withdraw') is not null drop procedure dbo.new_withdraw
        if object_id(N'dbo.v_randomValue') is not null drop view dbo.v_randomValue
        if object_id(N'dbo.p_randomValue') is not null drop function dbo.p_randomValue
        if object_id(N'dbo.create_os_begin') is not null drop procedure dbo.create_os_begin
        if object_id(N'dbo.create_os_end') is not null drop procedure dbo.create_os_end
        if object_id(N'dbo.equire_add') is not null drop procedure dbo.equire_add
        if object_id(N'dbo.new_ost_add') is not null drop procedure dbo.new_ost_add
        if object_id(N'dbo.store_withdraw') is not null drop procedure dbo.store_withdraw
        if object_id(N'dbo.stores_fee') is not null drop procedure dbo.stores_fee
        if object_id(N'dbo.equires_fee') is not null drop procedure dbo.equires_fee
        if object_id(N'dbo.create_table_out') is not null drop procedure dbo.create_table_out
        if object_id(N'dbo.main_repeat') is not null drop procedure dbo.main_repeat
        if object_id(N'dbo.return_funds') is not null drop procedure dbo.return_funds
        if object_id(N'dbo.new_operation') is not null drop procedure dbo.new_operation
        if object_id(N'dbo.store_return_ost') is not null drop function dbo.store_return_ost
        "
        $cmd.ExecuteNonQuery()
        $prBar.Value = 10
#end drop functions

#begin create functions
        $cmd.CommandText = "
        create function dbo.store_return_ost 
        (
	        @date_begin date,
	        @date_end date,
	        @acc varchar(20)
        )
        returns float
        begin

	        return 
	        (	
		        select top 1
			        isnull(round(isnull(plus.sum, 0) - isnull(minus.sum, 0), 2), 0) 'sum'
		        from
		        (
			        select
				        isnull(plus_1.acc, plus_2.acc) 'acc', 
				        isnull(plus_1.sum, 0) + isnull(plus_2.sum, 0) 'sum'
			        from
			        (
				        select 
					        acc 'acc', sum(sum) 'sum' 
				        from r_operations 
				        where acc like @acc and [type] = 1 and datetime <= dateadd(millisecond, -2, dateadd(day, 1, cast(@date_end as datetime)))
				        group by acc
			        ) plus_1
			        full join
			        (
				        select 
					        acc_cor 'acc', sum(sum) 'sum' 
				        from r_operations 
				        where acc_cor like @acc and [type] = 0 and datetime <= dateadd(millisecond, -2, dateadd(day, 1, cast(@date_end as datetime)))
				        group by acc_cor
			        ) plus_2
			        on plus_1.acc = plus_2.acc
		        ) plus
		        full join
		        (
			        select
				        isnull(minus_1.acc, minus_2.acc) 'acc', 
				        isnull(minus_1.sum, 0) + isnull(minus_2.sum, 0) 'sum'
			        from
			        (
				        select 
					        acc 'acc', sum(sum) 'sum' 
				        from r_operations 
				        where acc like @acc and [type] = 0 and return_status = 0 and datetime >= @date_begin 
				        group by acc
			        ) minus_1
			        full join
			        (
				        select 
					        acc_cor 'acc', sum(sum) 'sum' 
				        from r_operations 
				        where acc_cor like @acc and [type] = 1 and return_status = 0 and datetime >= @date_begin 
				        group by acc_cor
			        ) minus_2
			        on minus_1.acc = minus_2.acc
		        ) minus
		        on plus.acc = minus.acc
	        )

        end
        "
        $cmd.ExecuteNonQuery()
        $prBar.Value = 11

        $cmd.CommandText = "
        create procedure dbo.new_operation 
	        @acc varchar(25), 
	        @acc_cor varchar(25), 
	        @datetime datetime, 
	        @sum float, 
	        @type bit, 
	        @d_c varchar(50)
        as
	        insert into r_operations
	        select 
		        @acc,
		        @acc_cor, 
		        @datetime, 
		        @sum, 
		        @type,
		        @d_c, 
		        0

	        if @type = 1
	        begin
		        insert into op (O_ID, o_bln_dt, o_a_dt, o_a_tm, O_DT, O_TM, O_DCM_DT, O_DCM_N, DB_A, DB_A_ID, CR_A, CR_A_ID, O_AMN, O_APP,
						        DBE_BIC, DBE_A, CRE_BIC, CRE_A)
			        select right(newid(), 12), --ukey (o_id)
			        convert(date, @datetime), --data (o_bln_dt)
			        convert(date, @datetime), --data (o_a_dt)
			        convert(time, @datetime), --time (o_a_tm)
			        convert(date, @datetime), --data (O_DT)
			        convert(time, @datetime), --time (O_TM)
			        convert(date, @datetime), --data (O_DCM_DT)
			        (select left(newid(), 8)), --dcm_num (O_DCM_N)
			        @acc_cor, --dt_account
			        (select a_id from oz where a = @acc_cor), --dt_account_id
			        @acc, --kt_account
			        (select a_id from oz where a = @acc), --kt_account_id
			        @sum,
			        @d_c,
			        iif (@acc_cor like '3010%', (select top 1 bik_out from out_acc where @acc = acc), null),
			        iif (@acc_cor like '3010%', (select top 1 acc_out from out_acc where @acc = acc), null),
			        null, null
			
			
	        end
	        else if @type = 0
	        begin
		        insert into op (O_ID, o_bln_dt, o_a_dt, o_a_tm, O_DT, O_TM, O_DCM_DT, O_DCM_N, DB_A, DB_A_ID, CR_A, CR_A_ID, O_AMN, O_APP,
						        DBE_BIC, DBE_A, CRE_BIC, CRE_A)
			        select right(newid(), 12), --ukey (o_id)
			        convert(date, @datetime), --data (o_bln_dt)
			        convert(date, @datetime), --data (o_a_dt)
			        convert(time, @datetime), --time (o_a_tm)
			        convert(date, @datetime), --data (O_DT)
			        convert(time, @datetime), --time (O_TM)
			        convert(date, @datetime), --data (O_DCM_DT)
			        (select left(newid(), 8)), --dcm_num (O_DCM_N)
			        @acc, --dt_account
			        (select a_id from oz where a = @acc), --dt_account_id
			        @acc_cor, --kt_account
			        (select a_id from oz where a = @acc_cor), --kt_account_id
			        @sum,
			        @d_c,
			        null, null,
			        iif (@acc_cor like '3010%', (select top 1 bik_out from out_acc where @acc = acc), null),
			        iif (@acc_cor like '3010%', (select top 1 acc_out from out_acc where @acc = acc), null)			
	        end
        "
        $cmd.ExecuteNonQuery()
        $prBar.Value = 12

        $cmd.CommandText = "
        create procedure dbo.new_ost
	        @acc varchar(25), 
	        @ost float
        as	
	        delete from table_ost where acc = @acc
	        insert into table_ost 
	        select @acc, round(@ost, 2)
        "
        $cmd.ExecuteNonQuery()
        $prBar.Value = 13

        $cmd.CommandText = "
        create procedure dbo.new_ost_add
	        @acc varchar(25), 
	        @sum float,
	        @is_Plus bit
        as	
	        if (select count(*) from table_ost where acc = @acc) > 0
		        update table_ost
		        set ost = round(ost + iif(@is_Plus = 1, @sum, -@sum), 2)
		        where acc = @acc
	        else
		        insert into table_ost
		        select @acc, iif(@is_Plus = 1, @sum, -@sum)

        "
		$cmd.ExecuteNonQuery()
        $prBar.Value = 15

        $cmd.CommandText = "
        create procedure dbo.new_from_equires 
	        @id_source varchar(25),
	        @id_client_from_equires varchar(25),
	        @acc varchar(25), 
	        @acc_cor varchar(25), 
	        @currency varchar(3),
	        @datetime datetime, 
	        @sum float
        as
	        insert into r_from_equires
	        select 
		        @id_source,
		        @id_client_from_equires,
		        @acc,
		        @acc_cor, 
		        @currency,
		        @datetime, 
		        @sum
        "
		$cmd.ExecuteNonQuery()
        $prBar.Value = 18

        $cmd.CommandText = "
        create procedure dbo.new_withdraw 
	        @id_client_withdraw varchar(25),
	        @acc varchar(25), 
	        @acc_cor varchar(25), 
	        @id_recipient varchar(25),
	        @currency varchar(3),
	        @datetime datetime, 
	        @sum float
        as
	        insert into r_withdraw
	        select 
		        @id_client_withdraw,
		        @acc,
		        @acc_cor,
		        @id_recipient,
		        @currency,
		        @datetime, 
		        @sum
        "
		$cmd.ExecuteNonQuery()
        $prBar.Value = 21
		
        $cmd.CommandText = "
        create view v_randomValue
        AS
        select (rand(checksum(newid()))) AS randomValue
        "
		$cmd.ExecuteNonQuery()
        $prBar.Value = 24

		$cmd.CommandText = "
        create function dbo.p_randomValue(@round float = 0.01, @begin float, @end float)
        returns float
        begin
	
	        declare @random float = @begin + (select randomValue from v_randomValue) * (@end - @begin)
	        declare @random_round float = round(round(@random / @round, 0)* @round, 2)
	        if @random_round > @end
		        set @random_round = round(floor(@random / @round)* @round, 2)
	        if @random_round = 0
		        set @random_round = round(ceiling(@random / @round)* @round, 2)
		
	        return @random_round

        end
        "
		$cmd.ExecuteNonQuery()
        $prBar.Value = 27

		$cmd.CommandText = "
        create procedure dbo.return_funds

        as
	        declare @acc varchar(25)
	        declare @acc_cor varchar(25)
	        declare @date datetime
	        declare @sum float
	        declare @status bit
	        declare @proc_fee_store float = 0.02

	        DECLARE cursor_ CURSOR FOR
		        select acc, acc_cor, [datetime], [sum], [status]
		        from r_returns
		        where status = 0
	        OPEN cursor_  
  
	        FETCH NEXT FROM cursor_ INTO @acc, @acc_cor, @date, @sum, @status

	        WHILE @@FETCH_STATUS = 0  
	        BEGIN 
		        update r_returns
		        set [status] = 1
		        where acc = @acc and acc_cor = @acc_cor and [datetime] = @date and [sum] = @sum

		        declare @newdate datetime = dateadd(day, dbo.p_randomValue(1,3,14), @date)
		        declare @sum_fee_return float = round(@sum*@proc_fee_store, 2)

		        exec dbo.new_operation @acc, @acc_cor, @newdate, @sum, 1, 'Возврат денежных средств'
		        exec dbo.new_ost_add @acc, @sum, 1
		        exec dbo.new_ost_add @acc_cor, @sum, 0
		        exec dbo.new_ost_add @acc_cor, @sum_fee_return, 1

		        FETCH NEXT FROM cursor_ INTO @acc, @acc_cor, @date, @sum, @status
	        end

	        CLOSE cursor_  
	        DEALLOCATE cursor_
        "
		$cmd.ExecuteNonQuery()
        $prBar.Value = 30

		$cmd.CommandText = "
        create procedure dbo.equire_add
	        @date date
        as

	        declare @sum float
	        declare @a varchar(25)
	        declare @cor_a varchar(25)
            declare @advance int = $global:AdvanceValue*1000
	        DECLARE cursor_ CURSOR FOR
		        select a
		        from oz
		        where a like '30232%' and a_opn <= @date and isnull(a_cls, '22220101') >= @date
	        OPEN cursor_  
  
	        FETCH NEXT FROM cursor_ INTO @a

	        WHILE @@FETCH_STATUS = 0  
	        BEGIN 
		        set @sum = ceiling(@advance-isnull((select isnull(ost, 0) from table_ost where acc = @a),0))
		        set @cor_a = (select top 1 a from oz where a like '30102%' order by newid())
		        exec dbo.new_operation @a, @cor_a, @date, @sum, 1, 'Аванс'
		        exec dbo.new_ost_add @a, @sum, 1
		        exec dbo.new_ost_add @cor_a, @sum, 1
		        FETCH NEXT FROM cursor_ INTO @a
	        end

	        CLOSE cursor_  
	        DEALLOCATE cursor_
        "
		$cmd.ExecuteNonQuery()
        $prBar.Value = 33
		
        $cmd.CommandText = "
            create procedure dbo.store_withdraw
	        @date date,
	        @day_return int
        as	
	        declare @sum float
	        declare @a varchar(25), @ost float
	        declare @cor_a varchar(25)
	        DECLARE cursor_ CURSOR FOR
		        select acc, 
		        dbo.store_return_ost('20200101', dateadd(day, - @day_return, @date), acc)
		        from table_ost 
		        where 1=1
		        and acc like '47422%' 
	        OPEN cursor_  
  
	        FETCH NEXT FROM cursor_ INTO @a, @ost

	        WHILE @@FETCH_STATUS = 0  
	        BEGIN 
		        if (@ost > 1000)
		        begin
			        set @sum = dbo.p_randomValue(1000, 1000, @ost)
			        set @cor_a = (select top 1 a from oz where a like '30102%' order by newid())
			        exec dbo.new_operation @a, @cor_a, @date, @sum, 0, 'Выплата магазину'
			        exec dbo.new_ost_add @a, @sum, 0
			        exec dbo.new_ost_add @cor_a, @sum, 1
		        end

		        FETCH NEXT FROM cursor_ INTO @a, @ost
	        end

	        CLOSE cursor_  
	        DEALLOCATE cursor_
        "
		$cmd.ExecuteNonQuery()
        $prBar.Value = 36
		
        $cmd.CommandText = "
            create procedure dbo.stores_fee
	        @date date,
	        @day_return int
        as
	        declare @fee_store float = $global:StoreFeeValue
	        declare @proc_fee_store float = @fee_store/100
	        declare @acc_cor varchar(25), @sum float
	        declare @a_fee_store varchar(25) = (select top 1 a from oz where a like '70601%' and C_NM = 'Комиссии взимаемые с магазинов' order by newid())--счет 70601 по сбору комиссии с магазинов
	        DECLARE cursor_ CURSOR FOR
		        select 
			        acc_cor,
			        sum(sum) 'sum'
		        from r_operations
		        where acc_cor like '47422%' and dateadd(day, @day_return, cast(datetime as date)) = @date and [type] = 0
		        and return_status = 0
		        group by acc_cor
	        OPEN cursor_  
  
	        FETCH NEXT FROM cursor_ INTO @acc_cor, @sum

	        WHILE @@FETCH_STATUS = 0  
	        BEGIN 
		        set @sum = round((@sum * @proc_fee_store), 2)
		        if @sum > 0
		        begin
			        exec dbo.new_operation @acc_cor, @a_fee_store, @date, @sum, 0, 'Комиссия магазинов'
			        exec dbo.new_ost_add @acc_cor, @sum, 0
			        exec dbo.new_ost_add @a_fee_store, @sum, 1
		        end
		        FETCH NEXT FROM cursor_ INTO @acc_cor, @sum
	        end

	        CLOSE cursor_  
	        DEALLOCATE cursor_
        "
		$cmd.ExecuteNonQuery()
        $prBar.Value = 39
		
        $cmd.CommandText = "
        create procedure dbo.equires_fee
	        @date date
        as
	        declare @fee_equire float = $global:EquireFeeValue
	        declare @proc float = @fee_equire/100
	        declare @acc_cor varchar(25), @sum float
	        declare @a_fee_equire varchar(25) = (select top 1 a from oz where a like '70606%' and C_NM = 'Комиссии эквайерам' order by newid())--счет 70606 выплате комиссии эквайерам
	        DECLARE cursor_ CURSOR FOR
		        select 
			        acc_cor,
			        sum(sum) 'sum'
		        from r_operations
		        where acc_cor like '30232%' and dateadd(day, 1, cast(datetime as date)) = @date
		        group by acc_cor
	        OPEN cursor_  
  
	        FETCH NEXT FROM cursor_ INTO @acc_cor, @sum

	        WHILE @@FETCH_STATUS = 0  
	        BEGIN 
		        set @sum = round((@sum * @proc), 2)
		        if @sum > 0
		        begin
			        exec dbo.new_operation @acc_cor, @a_fee_equire, @date, @sum, 1, 'Комиссия эквайерам'
			        exec dbo.new_ost_add @acc_cor, @sum, 1
			        exec dbo.new_ost_add @a_fee_equire, @sum, 1
		        end
		        FETCH NEXT FROM cursor_ INTO @acc_cor, @sum
	        end

	        CLOSE cursor_  
	        DEALLOCATE cursor_
        "
		$cmd.ExecuteNonQuery()
        $prBar.Value = 42

        $cmd.CommandText = "
        create procedure dbo.create_os_begin
	        @date date
        as
	        insert into os (bln, a, crin)
	        select @date, oz.a, isnull(ost, 0)
	        from oz
	        left join table_ost on acc = a
	        where 1=1
	        and a_opn <= @date 
	        and isnull(a_cls, '22220101') >= @date
	        and not a like '70606%'
	        and not a like '30102%'

	        insert into os (bln, a, dbin)
	        select @date, oz.a, isnull(ost, 0)
	        from oz
	        left join table_ost on acc = a
	        where 1=1
	        and a_opn <= @date 
	        and isnull(a_cls, '22220101') >= @date
	        and (a like '70606%' or a like '30102%')
        "
		$cmd.ExecuteNonQuery()
        $prBar.Value = 45

        $cmd.CommandText = "
        create procedure dbo.create_os_end
	        @date date
        as
        --для пассивных счетов
	        update os set 
		        DBTRN = (select isnull(round(sum(sum), 2), 0) from r_operations op
		        where cast(op.datetime as date) = @date and
		        (
			        (op.[type] = 0 and op.acc = a)
			        or
			        (op.[type] = 1 and op.acc_cor = a)			
		        )),

		        CRTRN = (select isnull(round(sum(sum), 2), 0) from r_operations op 
		        where cast(op.datetime as date) = @date and
		        (
			        (op.[type] = 1 and op.acc = a)
			        or
			        (op.[type] = 0 and op.acc_cor = a)			
		        ))
	        where 1=1
	        and @date = bln
	        and not a like '70606%'
	        and not a like '30102%'

	        update os 
	        set CROUT = round(isnull(CRIN, 0) - isnull(DBTRN, 0) + isnull(CRTRN, 0), 2)
	        where 1=1
	        and @date = bln
	        and not a like '70606%'
	        and not a like '30102%'
        ----------------------------
        --для активных счетов
	        update os set 
	        DBTRN = (select isnull(round(sum(sum), 2), 0) from r_operations op
	        where cast(op.datetime as date) = @date and
	        (
		        (op.[type] = 0 and op.acc = a)
		        or
		        (op.[type] = 1 and op.acc_cor = a)			
	        )),

	        CRTRN = (select isnull(round(sum(sum), 2), 0) from r_operations op 
	        where cast(op.datetime as date) = @date and
	        (
		        (op.[type] = 1 and op.acc = a)
		        or
		        (op.[type] = 0 and op.acc_cor = a)			
	        ))
	        where 1=1
	        and @date = bln
	        and (a like '70606%' or a like '30102%')

	        update os 
	        set DBOUT = round(isnull(DBIN, 0) + isnull(DBTRN, 0) - isnull(CRTRN, 0), 2)
	        where 1=1
	        and @date = bln
	        and (a like '70606%' or a like '30102%')
        -----------------
        "
		$cmd.ExecuteNonQuery()
        $prBar.Value = 48

        $cmd.CommandText = "
        create procedure dbo.create_table_out
        as

	        if object_id(N'tempdb..#bik_out') is not null drop table #bik_out
	        create table #bik_out(bik varchar(9))
	        declare @i int = 0
	        while @i < 99
	        begin
		        insert into #bik_out
		        select '9999999' + iif(@i > 9, cast(@i as varchar(2)), '0' + cast(@i as varchar(1)))
		        set @i = @i + 1
	        end

	        declare @a varchar(25)
	        DECLARE cursor_ CURSOR FOR
		        select a
		        from oz 
		        left join dbo.out_acc m on oz.a = m.acc
		        where (oz.a like '47422%' or oz.a like '30232%') and m.acc is null

	        OPEN cursor_  
  
	        FETCH NEXT FROM cursor_ INTO @a

	        declare @bik_out varchar(9)
	        declare	@account varchar(20)
	        declare @bal varchar(5)
	        declare @val varchar(3) 

	        WHILE @@FETCH_STATUS = 0  
	        BEGIN 
		        set @val = substring(@a, 6, 3)
		        set @bal = iif(@a like '47422%', '40702', '30232')
	
		        set @bik_out = (select top 1 bik from #bik_out order by newid())
		        set	@account = @bal + @val + '_' + '0000' + substring(cast(10000000 + cast(dbo.p_randomValue(1, 1, 9999999) as bigint) as varchar),2,7)
		        exec dbo.sp_ControlByte @bik_out, @account, @account output

		        insert into dbo.out_acc
		        select @a, @bik_out, @account

		        FETCH NEXT FROM cursor_ INTO @a
	        end

	        CLOSE cursor_  
	        DEALLOCATE cursor_

        "
		$cmd.ExecuteNonQuery()
        $prBar.Value = 51

        $cmd.CommandText = "
        create procedure dbo.main 
	        @max_second bigint, --ввод частоты операций (сек.)
	        @dt date,
	        @day_return int
        as
	        declare @random_second bigint = (select top 1 1 + convert(bigint, (rand(checksum(newid())) * @max_second)) from sysobjects A CROSS JOIN sysobjects B) 
	        declare @datetime datetime= (select isnull(dateadd(second, @random_second, max(datetime)), convert(datetime, @dt)) from r_operations where convert(date,datetime) =  @dt)
	        declare @acc varchar(25) = (select top 1 a from oz where a like '40914%' and a_opn <= @datetime and isnull(a_cls, '22220101') >= @datetime order by newid()) --случайный действующий счет из ОЗ
	        declare @ost float = (select isnull((select top 1 isnull(ost, 0) from table_ost where acc = @acc), 0))

	        declare @type varchar(max)  -- тип операции 'Пополнение от эквайера', 'Перевод ЭДС', 'Списание денежных средств', 'Возврат'
	        declare @random int = 1
	        declare @random_value int = (select dbo.p_randomValue(1, 1, 101)-1)
	        if @random_value <= $global:ReturnRateValue --% шанс выпадения возвата
		        set @random = (select dbo.p_randomValue(1, 4, 4))
	        else
		        set @random = (select dbo.p_randomValue(1, 1, 3))
	
	        if @ost = 0  --если выбран счет с нулевым остатком, делаем пополнение
		        set @random = 1 
	        else 
	        if @ost = 40000 -- если выбран счет с максимальным остатком, делаем перевод ЭДС или списание
		        set @random = (select dbo.p_randomValue(1, 2, 3))
	
	        if @random = 1 -- Пополнение от эквайера
		        set @type = 'Пополнение от эквайера'
	        if @random = 2 -- Перевод ЭДС
		        set @type = 'Перевод ЭДС'
	        if @random = 3 -- Списание денежных средств
		        set @type = 'Списание денежных средств'
	        if @random = 4 -- Возврат денежных средств
		        set @type = 'Возврат денежных средств'	
	
	        declare @max_sum float -- максимально возможная сумма операции
	        declare @sum float -- случайно генерируемая сумма операции
	        declare @sum_minus float -- случайно генерируемая сумма операции(отрицательная)
	        declare @random_round int -- вероятность совершения операции на круглую сумму (без копеек)
	        declare @round float -- округление
	        declare @random_mod int -- вероятность совершения операции кратной @mod
	        declare @mod int -- значение кратности (10, 100, 1000 и тд)
	        declare @acc_cor varchar(max) -- корреспондирующий счет
	        declare @new_ost float -- остаток на счете после совершения операции
	        declare @id_client_from_equires varchar(25)
	        declare @id_client_withdraw varchar(25)
	        declare @id_source varchar(25)
	        declare @id_recipient varchar(25)
	        declare @comis float -- комиссия
	        declare @a_fee_eds varchar(25) = (select top 1 a from oz where a like '70601%' and C_NM = 'Комиссии по переводам ЭДС' order by newid())--счет 70601 по сбору комиссии за переводы эдс
	

	        declare @sum_commis_min float-- = 0.01 
	        declare @sum_commis_proc float-- = 0.01 
	
	        if @type = 'Пополнение от эквайера'
	        begin
		        set @max_sum = 40000 - @ost
		        set @acc_cor = 
			        (select top 1 a 
			        from oz 
			        left join table_ost on oz.a = table_ost.acc 
			        where a like '30232%' and a_opn <= @datetime and isnull(a_cls, '22220101') >= @datetime and ost > 0
			        order by newid())
		        set @max_sum = iif(@max_sum < (select ost from table_ost where acc = @acc_cor), @max_sum, (select ost from table_ost where acc = @acc_cor))

		        set @random_round = $global:AtmKopValue
		        set @round = iif(dbo.p_randomValue(1, 0, 100) < @random_round, 1, 0.01)
		        --set @mod = $global:AtmMultiplier				
		
		        set @id_source = (select top 1 id_source from r_sources where [ID_source] not like 'RTL%' order by NEWID())
		        if @id_source like 'ATM%'
			        begin
                        set @mod = $global:AtmMultiplier
				        set @id_client_from_equires = (select top 1 id_client from r_clients order by NEWID())
				        set @random_mod = $global:AtmMultiplyValue
				        if dbo.p_randomValue(1, 0, 100) < @random_mod and @max_sum >= @mod 
					        set @sum = dbo.p_randomValue(@mod, @mod, @max_sum)
				        else 
				        if @max_sum < 1
					        set @sum = dbo.p_randomValue(0.01, 0.01, @max_sum)
				        else 
					        set @sum = dbo.p_randomValue(@round, 0.01, @max_sum)
			        end
		        else if @id_source like 's%'
			        begin
                        set @mod = $global:SiteMultiplier
				        set @id_client_from_equires = (select top 1 id_client from r_clients where len(INFO_client) <> 8 and len(INFO_client) <> 10 order by NEWID())
				        set @random_mod = $global:SiteMultiplyValue
					        if dbo.p_randomValue(1, 0, 100) < @random_mod and @max_sum >= @mod
						        set @sum = dbo.p_randomValue(@mod, @mod, @max_sum)
					        else 
				        if @max_sum < 1
					        set @sum = dbo.p_randomValue(0.01, 0.01, @max_sum)
				        else 
					        set @sum = dbo.p_randomValue(@round, @round, @max_sum)
			        end

		        if @acc_cor is not null
		        begin
			        declare @currency varchar(3) = 'rub'
			        exec dbo.new_operation @acc, @acc_cor, @datetime, @sum, 1, @type

			        exec dbo.new_ost_add @acc, @sum, 1
			        exec dbo.new_ost_add @acc_cor, @sum, 0

			        exec dbo.new_from_equires @id_source, @id_client_from_equires, @acc, @acc_cor, @currency, @datetime, @sum
		        end
		        else
		        return 1
	        end

	        if @type = 'Перевод ЭДС'
	        begin

		        set @sum_commis_min = $global:EdsMinFee --минимальная комиссия			
		        declare @sum_commis int = $global:EdsFeeValue
                set @sum_commis_proc = $global:EdsFeeValue 				

		        set @max_sum = @ost
		        if round(floor(100*@max_sum/(1+@sum_commis_proc))/100, 2) < round(@max_sum - @sum_commis_min, 2)
			        set @max_sum = round(floor(100*@max_sum/(1+@sum_commis_proc))/100, 2)--round(@max_sum * round((1 - @sum_commis_proc), 2), 2)
		        else
			        set @max_sum = round(@max_sum - @sum_commis_min, 2)
		        if @max_sum <= 0
		        return 1

		        set @random_round = $global:EdsKopValue
		        set @round = iif(dbo.p_randomValue(1, 0, 100) < @random_round, 1, 0.01)
		        set @random_mod = $global:EdsMultiplyValue
		        set @mod = $global:EdsMultiplier
		        if dbo.p_randomValue(1, 0, 100) < @random_mod and @max_sum >= @mod 
			        set @sum = dbo.p_randomValue(@mod, @mod, @max_sum)
		        else 
		        if @max_sum < 1
			        set @sum = dbo.p_randomValue(0.01, 0.01, @max_sum)
		        else 
			        set @sum = dbo.p_randomValue(@round, @round, @max_sum)
		        set @acc_cor = 
			        (select top 1 a 
			        from oz 
			        left join table_ost on oz.a = table_ost.acc 
			        where a like '40914%' and a_opn <= @datetime and isnull(a_cls, '22220101') >= @datetime 
			        and a <> @acc and isnull(table_ost.ost, 0) + @sum < 40000
			        order by newid())
		        if @acc_cor is not null 
		        begin
			        exec dbo.new_operation @acc, @acc_cor, @datetime, @sum, 0, @type
			        exec dbo.new_ost_add @acc, @sum, 0
			        set @comis = iif(round(@sum * @sum_commis_proc, 2) > @sum_commis_min, round(@sum * @sum_commis_proc, 2), @sum_commis_min)
			        if @comis > 0
			        begin
				        exec dbo.new_operation @acc, @a_fee_eds, @datetime, @comis, 0, 'Комиссия за перевод ЭДС'
				        exec dbo.new_ost_add @acc, @comis, 0
				        exec dbo.new_ost_add @a_fee_eds, @comis, 1
			        end
			        exec dbo.new_ost_add @acc_cor, @sum, 1
		        end
		        else
		        return 1
	        end

	        if @type = 'Списание денежных средств'
	        begin
		        set @max_sum = @ost
		        set @random_round = $global:StoreKopValue
		        set @round = iif(dbo.p_randomValue(1, 0, 100) < @random_round, 1, 0.01)
		        set @random_mod = $global:StoreMultiplyValue
		        set @mod = $global:StoreMultiplier
		        set @acc_cor =
			        (select top 1 a 
			        from oz 
			        left join table_ost on oz.a = table_ost.acc 
			        where a like '47422%' and a_opn <= @datetime and isnull(a_cls, '22220101') >= @datetime 
			        order by newid())
		        set @id_recipient = (select top 1 id_source from r_sources order by NEWID())
		        set @id_client_withdraw = (select C_ID from oz where a = @acc)
		        set @currency = 'rub'
		
		        if dbo.p_randomValue(1, 0, 100) < @random_mod and @max_sum >= @mod 
			        set @sum = dbo.p_randomValue(@mod, @mod, @max_sum)
		        else 
		        if @max_sum < 1
			        set @sum = dbo.p_randomValue(0.01, 0.01, @max_sum)
		        else 
			        set @sum = dbo.p_randomValue(@round, @round, @max_sum)
		
		        exec dbo.new_operation @acc, @acc_cor, @datetime, @sum, 0, @type
		        exec dbo.new_ost_add @acc, @sum, 0
		        exec dbo.new_ost_add @acc_cor, @sum, 1
		        exec dbo.new_withdraw @id_client_withdraw, @acc, @id_recipient, @acc_cor,  @currency, @datetime, @sum
	        end

	        if @type = 'Возврат денежных средств'
		        begin
			
			        set @max_sum = 40000 - @ost
			        declare @id_op bigint =
			        (
				        select top 1
					        isnull(id, 0)
				        from r_operations
				        where acc = @acc and acc_cor like '47422%' and return_status = 0 
				        and datetime between dateadd(day, - @day_return + 1, @datetime) and @datetime
				        and sum <= @max_sum and [type] = 0
				        order by newid()
			        )

			        if (@id_op > 0)
			        begin
				
				        update r_operations
				        set return_status = 1
				        where id = @id_op

				        set @sum = (select sum from r_operations where id = @id_op)
				        set @acc_cor = (select acc_cor from r_operations where id = @id_op)
				
				        exec dbo.new_operation @acc, @acc_cor, @datetime, @sum, 1, @type
				        exec dbo.new_ost_add @acc, @sum, 1
				        exec dbo.new_ost_add @acc_cor, @sum, 0
			
			        end
			        else
			        return 1

		        end

	        if @ost - @sum < 0 and (@random = 2 or @random = 3)
	        begin
		        print('ost-sum < 0')
		        print(@ost)
		        print(@sum)
		        print(@type)
		        print(@datetime)
	        end
	        if @sum < 0
	        begin
		        print('sum < 0')
		        print(@ost)
		        print(@sum)
		        print(@max_sum)
		        print(@type)
		        print(@datetime)
	        end
	        return 0
        "
		$cmd.ExecuteNonQuery()
        $prBar.Value = 54
#end create functions

#begin start processing
    $cmd.CommandText = "
    if object_id(N'tempdb..#need_repeat') is not null drop table #need_repeat
    create table #need_repeat(is_need bit)

    declare @minDate date = '$global:minDate_'
    declare @maxDate date = '$global:maxDate_'
    declare @date date = @minDate;
    declare @max_count int = $global:DayQtyValue
    declare @sec int = 60*60*24 / @max_count
    declare @need_repeat bit = 1
    declare @day_return int = 15

    while @date <= replace(@maxDate, '1900-01-01', @minDate)
    begin
	    declare @i int = 1
	    exec dbo.create_table_out
	    exec dbo.create_os_begin @date
	    exec dbo.equires_fee @date
	    exec dbo.equire_add @date

	    while @i <= @max_count
	    begin
		    set @sec = (select isnull((select 60*60*24 - datediff(ss, convert(datetime, @date), max(datetime)) from r_operations where convert(date, datetime) = @date), 60*60*24) / (@max_count - @i+1))

		    exec @need_repeat = dbo.main @sec, @date, @day_return
		    while @need_repeat = 1
		    exec @need_repeat = dbo.main @sec, @date, @day_return

		    if (select count(*) from table_ost where ost< 0 and not (acc like '70606%' or acc like '30102%')) >0
		    BEGIN
			    select * from table_ost
			    select * from r_operations order by datetime desc
			    waitfor delay '01:00:00'
		    END
            
		    if (select max(ost) from table_ost where acc like '40914%' or acc like '30232%') <= 0
			    break
					
		    set @i = @i+1
	    end

	    exec dbo.stores_fee @date, @day_return
	    exec dbo.store_withdraw @date, @day_return
	    exec create_os_end @date

	    set @date  = DATEADD(day, 1, @date)
    end
    "

    $cmd.ExecuteNonQuery()
    $prBar.Value = 100
#end start processing
    $true
    [System.Windows.Forms.MessageBox]::Show('Выполнено')
    } catch {
        throw $_
            }

}

$btnNext_options_adv.Add_Click({ btnNext_options_adv_Click })

$form_Processing_options_adv.controls.AddRange(@($lblProcessing_options_adv,$grBoxTbars_from_equires,$grBoxTbars_to_stores,$grBoxTbars_eds,$prBar,$btnNext_options_adv))
$grBoxTbars_from_equires.controls.AddRange(@($grBoxTbars_from_equires_atm,$grBoxTbars_from_equires_site))
$grBoxTbars_from_equires_atm.controls.AddRange(@($lblAtmKopCount,$tBarAtmKop,$txtAtmKopCount,$lblAtmMultiplyCount,$tBarAtmMultiply,$txtAtmMultiplyCount,$lblAtmMultiplier,$txtAtmMultiplier))
$grBoxTbars_from_equires_site.controls.AddRange(@($lblSiteKopCount,$tBarSiteKop,$txtSiteKopCount,$lblSiteMultiplyCount,$tBarSiteMultiply,$txtSiteMultiplyCount,$lblSiteMultiplier,$txtSiteMultiplier))
$grBoxTbars_to_stores.controls.AddRange(@($lblStoreKopCount,$tBarStoreKop,$txtStoreKopCount,$lblStoreMultiplyCount,$tBarStoreMultiply,$txtStoreMultiplyCount,$lblStoreMultiplier,$txtStoreMultiplier))
$grBoxTbars_eds.controls.AddRange(@($lblEdsKopCount,$tBarEdsKop,$txtEdsKopCount,$lblEdsMultiplyCount,$tBarEdsMultiply,$txtEdsMultiplyCount,$lblEdsMultiplier,$txtEdsMultiplier,$lblEdsFeeCount,$tBarEdsFee,$txtEdsFeeCount,$lblEdsMinFee,$txtEdsMinFee))
#end processing advanced config

$form_Processing_options_adv.add_FormClosing({
    $global:conn.close()
    $conn.close()
    })

$form_Processing_options_adv.ShowDialog()