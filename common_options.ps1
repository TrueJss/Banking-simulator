#begin processing common config
$form_Processing_options                 = New-Object system.Windows.Forms.Form -Property @{
    ClientSize      = '400,400'
    Text            = "Настройки процессинга"
    TopMost         = $false
    StartPosition = [Windows.Forms.FormStartPosition]::CenterScreen
    FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::Fixed3D
}

$lblProcessing_options                   = New-Object system.Windows.Forms.Label -Property @{
    Text              = "Общие настройки"
    AutoSize          = $true
    Location          = New-Object System.Drawing.Point(130,5)
    Font              = 'Microsoft Sans Serif,10'
}

$grBoxDates_options     = New-Object system.Windows.Forms.Groupbox -Property @{
    Height      = 325
    Width       = 200
    Location    = New-Object System.Drawing.Point(0,25)
    Text = "Выбор даты или периода"
}

$lblMinDate_options         = New-Object system.Windows.Forms.Label -Property @{
    Text     = "Дата начала:"
    AutoSize = $true
    Width    = 25
    Height   = 10
    Location = New-Object System.Drawing.Point(5,185)
    Font     = 'Microsoft Sans Serif,10'
}
                     
$txtMinDate_options         = New-Object system.Windows.Forms.TextBox -Property @{
    Multiline = $false
    Width     = 100
    Height    = 20
    Anchor    = 'top'
    Location  = New-Object System.Drawing.Point(5,205)
    Font      = 'Microsoft Sans Serif,10'
    Name      = "min_date_options"
}

$txtMinDate_options.Add_TextChanged({
    $this.Text = $this.Text -replace '\D'
})
                     
$lblMaxDate_options         = New-Object system.Windows.Forms.Label -Property @{
    Text     = "Дата окончания:"
    AutoSize = $true
    Width    = 25
    Height   = 10
    #Location = New-Object System.Drawing.Point(5,215)
    Location = New-Object System.Drawing.Point(5,230)
    Font     = 'Microsoft Sans Serif,10'
}
                     
$txtMaxDate_options         = New-Object system.Windows.Forms.TextBox -Property @{
    Multiline = $false
    Width     = 100
    Height    = 20
    Anchor    = 'top'
    #Location  = New-Object System.Drawing.Point(117,213)
    Location  = New-Object System.Drawing.Point(5,250)
    Font      = 'Microsoft Sans Serif,10'
    Name      = "max_date_options"
}

$txtMaxDate_options.Add_TextChanged({
    $this.Text = $this.Text -replace '\D'
})

$calendar_options           = New-Object Windows.Forms.MonthCalendar -Property @{
    ShowTodayCircle   = $false
    MaxSelectionCount = 1
    Location          = New-Object System.Drawing.Point(5,17)
    Name              = "calendar_options"
}

$grBoxTbars_options     = New-Object system.Windows.Forms.Groupbox -Property @{
    Height      = 325
    Width       = 200
    Location    = New-Object System.Drawing.Point(200,25)
    Text = "Параметры"
}

$tBarDayQty     = New-Object Windows.Forms.TrackBar -Property @{
    Location      = New-Object System.Drawing.Point(0,15)
    Orientation   = "Horizontal"
    Width         = 160
    Height        = 10
    TickFrequency = 100
    TickStyle     = "TopLeft"
    Value         = 0
}
$tBarDayQty.SetRange(0, 2000)
$tbarDayQtyValue = 100
$global:DayQtyValue = 100

$txtDayQtyCount         = New-Object system.Windows.Forms.TextBox -Property @{
    Multiline = $false
    Width     = 36
    Height    = 15
    Anchor    = 'top'
    Location  = New-Object System.Drawing.Point(160,20)
    Font      = 'Microsoft Sans Serif,8'
    Text      = "$tbarDayQtyValue"
}

$txtDayQtyCount.add_TextChanged({
    $tbarDayQtyValue = $txtDayQtyCount.Text
    $lblDayQtyCount.Text = "Кол-во операций в день: $tbarDayQtyValue"
    $tBarDayQty.Value = $txtDayQtyCount.Text
    $global:DayQtyValue = $tbarDayQtyValue
})

$tBarDayQty.add_ValueChanged({
    $tbarDayQtyValue = $tBarDayQty.Value
    $lblDayQtyCount.Text = "Кол-во операций в день: $tbarDayQtyValue"
    $txtDayQtyCount.Text = $tbarDayQtyValue
    $global:DayQtyValue = $tbarDayQtyValue
})

$lblDayQtyCount = New-Object System.Windows.Forms.Label -Property @{
    Width           = 170
    Height          = 30
    Location        = New-Object System.Drawing.Point(9,50)
    Font            = 'Microsoft Sans Serif,8'
    Text            = "Кол-во операций в день: $tbarDayQtyValue"
}

$tBarAdvance     = New-Object Windows.Forms.TrackBar -Property @{
    Location      = New-Object System.Drawing.Point(0,75)
    Orientation   = "Horizontal"
    Width         = 160
    Height        = 10
    TickFrequency = 1000
    TickStyle     = "TopLeft"
    Value         = 0
}
$tBarAdvance.SetRange(0, 10000)
$tbarAdvanceValue = 3000
$global:AdvanceValue = 3000

$txtAdvanceCount         = New-Object system.Windows.Forms.TextBox -Property @{
    Multiline = $false
    Width     = 36
    Height    = 15
    Anchor    = 'top'
    Location  = New-Object System.Drawing.Point(160,80)
    Font      = 'Microsoft Sans Serif,8'
    Text      = "$tbarAdvanceValue"
}

$txtAdvanceCount.add_TextChanged({
    $tbarAdvanceValue = $txtAdvanceCount.Text
    $lblAdvanceCount.Text = "Авансовый платеж (тыс.руб.): $tbarAdvanceValue"
    $tBarAdvance.Value = $txtAdvanceCount.Text
    $global:AdvanceValue = $tbarAdvanceValue
})

$tBarAdvance.add_ValueChanged({
    $tbarAdvanceValue = $tBarAdvance.Value
    $lblAdvanceCount.Text = "Авансовый платеж (тыс.руб.): $tbarAdvanceValue"
    $txtAdvanceCount.Text = $tbarAdvanceValue
    $global:AdvanceValue = $tbarAdvanceValue
})

$lblAdvanceCount = New-Object System.Windows.Forms.Label -Property @{
    Width           = 190
    Height          = 30
    Location        = New-Object System.Drawing.Point(9,110)
    Font            = 'Microsoft Sans Serif,8'
    Text            = "Авансовый платеж (тыс.руб.): $tbarAdvanceValue"
}

$tBarStoreFee     = New-Object Windows.Forms.TrackBar -Property @{
    Location      = New-Object System.Drawing.Point(0,135)
    Orientation   = "Horizontal"
    Width         = 160
    Height        = 10
    TickFrequency = 10
    TickStyle     = "TopLeft"
    Value         = 0
}
$tBarStoreFee.SetRange(0, 100)
$tbarStoreFeeValue = 2
$global:StoreFeeValue = 2

$txtStoreFeeCount         = New-Object system.Windows.Forms.TextBox -Property @{
    Multiline = $false
    Width     = 36
    Height    = 15
    Anchor    = 'top'
    Location  = New-Object System.Drawing.Point(160,140)
    Font      = 'Microsoft Sans Serif,8'
    Text      = "$tbarStoreFeeValue"
}

$txtStoreFeeCount.add_TextChanged({
    $tbarStoreFeeValue = $txtStoreFeeCount.Text
    $lblStoreFeeCount.Text = "Комиссия, взимаемая с магазинов: $tbarStoreFeeValue%"
    $tBarStoreFee.Value = $txtStoreFeeCount.Text
    $global:StoreFeeValue = $tbarStoreFeeValue
})

$tBarStoreFee.add_ValueChanged({
    $tbarStoreFeeValue = $tBarStoreFee.Value
    $lblStoreFeeCount.Text = "Комиссия, взимаемая с магазинов: $tbarStoreFeeValue%"
    $txtStoreFeeCount.Text = $tbarStoreFeeValue
    $global:StoreFeeValue = $tbarStoreFeeValue
})

$lblStoreFeeCount = New-Object System.Windows.Forms.Label -Property @{
    Width           = 190
    Height          = 30
    Location        = New-Object System.Drawing.Point(9,170)
    Font            = 'Microsoft Sans Serif,8'
    Text            = "Комиссия, взимаемая с магазинов: $tbarStoreFeeValue%"
}

$tBarEquireFee     = New-Object Windows.Forms.TrackBar -Property @{
    Location      = New-Object System.Drawing.Point(0,195)
    Orientation   = "Horizontal"
    Width         = 160
    Height        = 10
    TickFrequency = 10
    TickStyle     = "TopLeft"
    Value         = 0
}
$tBarEquireFee.SetRange(0, 100)
$tbarEquireFeeValue = 1
$global:EquireFeeValue = 1

$txtEquireFeeCount         = New-Object system.Windows.Forms.TextBox -Property @{
    Multiline = $false
    Width     = 36
    Height    = 15
    Anchor    = 'top'
    Location  = New-Object System.Drawing.Point(160,200)
    Font      = 'Microsoft Sans Serif,8'
    Text      = "$tbarEquireFeeValue"
}

$txtEquireFeeCount.add_TextChanged({
    $tbarEquireFeeValue = $txtEquireFeeCount.Text
    $lblEquireFeeCount.Text = "Комиссия, выплачиваемая эквайерам: $tbarEquireFeeValue%"
    $tBarEquireFee.Value = $txtEquireFeeCount.Text
    $global:EquireFeeValue = $tbarEquireFeeValue
})

$tBarEquireFee.add_ValueChanged({
    $tbarEquireFeeValue = $tBarEquireFee.Value
    $lblEquireFeeCount.Text = "Комиссия, выплачиваемая эквайерам: $tbarEquireFeeValue%"
    $txtEquireFeeCount.Text = $tbarEquireFeeValue
    $global:EquireFeeValue = $tbarEquireFeeValue
})

$global:EquireFeeValue = $tbarEquireFeeValue

$lblEquireFeeCount = New-Object System.Windows.Forms.Label -Property @{
    Width           = 190
    Height          = 30
    Location        = New-Object System.Drawing.Point(9,230)
    Font            = 'Microsoft Sans Serif,8'
    Text            = "Комиссия, выплачиваемая эквайерам: $tbarEquireFeeValue%"
}

$tBarReturnRate     = New-Object Windows.Forms.TrackBar -Property @{
    Location      = New-Object System.Drawing.Point(0,255)
    Orientation   = "Horizontal"
    Width         = 160
    Height        = 10
    TickFrequency = 10
    TickStyle     = "TopLeft"
    Value         = 0
}
$tBarReturnRate.SetRange(0, 100)
$tbarReturnRateValue = 5
$global:ReturnRateValue = 5

$txtReturnRateCount         = New-Object system.Windows.Forms.TextBox -Property @{
    Multiline = $false
    Width     = 36
    Height    = 15
    Anchor    = 'top'
    Location  = New-Object System.Drawing.Point(160,260)
    Font      = 'Microsoft Sans Serif,8'
    Text      = "$tbarReturnRateValue"
}

$txtReturnRateCount.add_TextChanged({
    $tbarReturnRateValue = $txtReturnRateCount.Text
    $lblReturnRateCount.Text = "Вероятность совершения возврата денежных средств: $tbarReturnRateValue%"
    $tBarReturnRate.Value = $txtReturnRateCount.Text
    $global:ReturnRateValue = $tbarReturnRateValue
})

$tBarReturnRate.add_ValueChanged({
    $tbarReturnRateValue = $tBarReturnRate.Value
    $lblReturnRateCount.Text = "Вероятность совершения возврата денежных средств: $tbarReturnRateValue%"
    $txtReturnRateCount.Text = $tbarReturnRateValue
    $global:ReturnRateValue = $tbarReturnRateValue
})

$lblReturnRateCount = New-Object System.Windows.Forms.Label -Property @{
    Width           = 190
    Height          = 30
    Location        = New-Object System.Drawing.Point(9,290)
    Font            = 'Microsoft Sans Serif,8'
    Text            = "Вероятность совершения возврата денежных средств: $tbarReturnRateValue%"
}


$btnNext_options             = New-Object system.Windows.Forms.Button -Property @{
    Text     = "Далее"
    Width    = 150
    Height   = 30
    Anchor   = 'top'
    Location = New-Object System.Drawing.Point(125,355)
    Font     = 'Microsoft Sans Serif,10'
}

#$btnNext_options.Add_Click({
#       $form_Processing_options.Close()
#       $form_Processing_options.Dispose()
#       . .\advanced_options.ps1
#})

function btnNext_options_Click() 
{
    try{
        if(($txtMinDate_options.Text.Length -eq 8) -and ($txtMaxDate_options.Text.Length -eq 8)){
        
            $global:minDate_ = $txtMinDate_options.Text
            $global:maxDate_ = $txtMaxDate_options.Text        
        }
        else {
            $global:minDate_ = $calendar_options.SelectionStart.ToShortDateString()
             }

        $form_Processing_options.Close()
        $form_Processing_options.Dispose()
        . .\advanced_options.ps1
        $true
        [System.Windows.Forms.MessageBox]::Show('Выполнено')
    } catch {
        {throw $_}
    }
    write-host $global:minDate_
}

$btnNext_options.Add_Click({ btnNext_options_Click })

$form_Processing_options.controls.AddRange(@($lblProcessing_options,$grBoxDates_options,$grBoxTbars_options,$btnNext_options))
$grBoxDates_options.controls.AddRange(@($lblMinDate_options,$txtMinDate_options,$lblMaxDate_options,$txtMaxDate_options,$calendar_options))
$grBoxTbars_options.controls.AddRange(@($lblDayQtyCount,$tBarDayQty,$txtDayQtyCount,$lblAdvanceCount,$tBarAdvance,$txtAdvanceCount,$lblStoreFeeCount,$tBarStoreFee,$txtStoreFeeCount,$lblEquireFeeCount,$tBarEquireFee,$txtEquireFeeCount,$lblReturnRateCount,$tBarReturnRate,$txtReturnRateCount))
#end processing common config

$form_Processing_options.ShowDialog()