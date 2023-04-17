#begin account close
$form_AccountsClose                 = New-Object system.Windows.Forms.Form -Property @{
    ClientSize      = '410,410'
    Text            = "Закрытие счетов"
    TopMost         = $false
    StartPosition = [Windows.Forms.FormStartPosition]::CenterScreen
    FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::Fixed3D
}

$lblAccountsClose                   = New-Object system.Windows.Forms.Label -Property @{
    Text              = "Параметры закрытия счетов"
    AutoSize          = $true
    Location          = New-Object System.Drawing.Point(105,5)
    Font              = 'Microsoft Sans Serif,10'
}

$grBoxTrackBars_acccls     = New-Object system.Windows.Forms.Groupbox -Property @{
    Height      = 80
    Width       = 410
    Location    = New-Object System.Drawing.Point(0,205)
    Text = "Количество закрываемых счетов"
}

$lblClosePercent      = New-Object system.Windows.Forms.Label -Property @{
    Text       = "Закрываемые счета:"
    AutoSize   = $true
    Location   = New-Object System.Drawing.Point(5,20)
    Font       = 'Microsoft Sans Serif,10'
}

$tBarClosePercent     = New-Object Windows.Forms.TrackBar -Property @{
    Location      = New-Object System.Drawing.Point(140,15)
    Orientation   = "Horizontal"
    Width         = 150
    Height        = 10
    TickFrequency = 5
    TickStyle     = "TopLeft"
    Value         = 0
}
$tBarClosePercent.SetRange(0, 100)
$tbarClosePercentValue = 0
$global:ClosePercentValue = 0

$txtClosePercentCount         = New-Object system.Windows.Forms.TextBox -Property @{
    Multiline = $false
    Width     = 30
    Height    = 15
    Anchor    = 'top'
    Location  = New-Object System.Drawing.Point(290,20)
    Font      = 'Microsoft Sans Serif,10'
    Text      = "$tbarClosePercentValue"
}

$txtClosePercentCount.add_TextChanged({
    $tbarClosePercentValue = $txtClosePercentCount.Text
    $lblClosePercentCount.Text = "Процент от кол-ва открытых в день: $tbarClosePercentValue%"
    $tBarClosePercent.Value = $txtClosePercentCount.Text
    $global:ClosePercentValue = $tbarClosePercentValue
})

$tBarClosePercent.add_ValueChanged({
    $tbarClosePercentValue = $tBarClosePercent.Value
    $lblClosePercentCount.Text = "Процент от кол-ва открытых в день: $tbarClosePercentValue%"
    $txtClosePercentCount.Text = $tbarClosePercentValue
    $global:ClosePercentValue = $tbarClosePercentValue
})

$lblClosePercentCount = New-Object System.Windows.Forms.Label -Property @{
    Width           = 150
    Height          = 30
    Location        = New-Object System.Drawing.Point(145,45)
    Font            = 'Microsoft Sans Serif,8'
    Text            = "Процент от кол-ва открытых в день: $tbarClosePercentValue%"
}

$grBoxDates_acccls     = New-Object system.Windows.Forms.Groupbox -Property @{
    Height      = 185
    Width       = 410
    Location    = New-Object System.Drawing.Point(0,25)
    Text = "Выбор даты или периода"
}

$lblMinDate_acccls         = New-Object system.Windows.Forms.Label -Property @{
    Text     = "Дата начала:"
    AutoSize = $true
    Width    = 25
    Height   = 10
    Location = New-Object System.Drawing.Point(180,20)
    Font     = 'Microsoft Sans Serif,10'
}
                     
$txtMinDate_acccls         = New-Object system.Windows.Forms.TextBox -Property @{
    Multiline = $false
    Width     = 105
    Height    = 20
    Anchor    = 'top'
    Location  = New-Object System.Drawing.Point(292,17)
    Font      = 'Microsoft Sans Serif,10'
    Name      = "min_date_acccls"
}

$txtMinDate_acccls.Add_TextChanged({
    $this.Text = $this.Text -replace '\D'
})
                     
$lblMaxDate_acccls         = New-Object system.Windows.Forms.Label -Property @{
    Text     = "Дата окончания:"
    AutoSize = $true
    Width    = 25
    Height   = 10
    Location = New-Object System.Drawing.Point(180,50)
    Font     = 'Microsoft Sans Serif,10'
}
                     
$txtMaxDate_acccls         = New-Object system.Windows.Forms.TextBox -Property @{
    Multiline = $false
    Width     = 105
    Height    = 20
    Anchor    = 'top'
    Location  = New-Object System.Drawing.Point(292,47)
    Font      = 'Microsoft Sans Serif,10'
    Name      = "max_date_acccls"
}

$txtMaxDate_acccls.Add_TextChanged({
    $this.Text = $this.Text -replace '\D'
})

$calendar_acccls           = New-Object Windows.Forms.MonthCalendar -Property @{
    ShowTodayCircle   = $false
    MaxSelectionCount = 1
    Location          = New-Object System.Drawing.Point(5,17)
    Name              = "calendar_acccls"
}

$grBoxTypes_acccls     = New-Object system.Windows.Forms.Groupbox -Property @{
    Height      = 80
    Width       = 410
    Location    = New-Object System.Drawing.Point(0,285)
    Text = "Выбор или ввод балансовых счетов для закрытия"
}

$cBoxTypes_acccls          = New-Object system.Windows.Forms.ComboBox -Property @{
    Width    = 215
    Height   = 20
    Location = New-Object System.Drawing.Point(5,20)
    Font     = 'Microsoft Sans Serif,10'
    Name     = "cBoxTypes_acccls"
}
    @('Вклады_тест','Кредиты_тест','Кошельки без ИД/УпрИД', 'Кошельки с ИД') | ForEach-Object {[void] $cBoxTypes_acccls.Items.Add($_)}

$lblTypesExample_acccls         = New-Object system.Windows.Forms.Label -Property @{
    Text     = "Формат ввода: ('40817'),('40702')"
    AutoSize = $true
    Width    = 25
    Height   = 10
    Location = New-Object System.Drawing.Point(225,25)
    Font     = 'Microsoft Sans Serif,8'
}

$ChkBoxTypes_acccls             = New-Object system.Windows.Forms.CheckBox -Property @{
    Text     = "Выбрать все счета"
    AutoSize = $true
    Width    = 25
    Height   = 10
    Location = New-Object System.Drawing.Point(5,50)
    Font     = 'Microsoft Sans Serif,10'

}

$prBar_acccls = New-Object System.Windows.Forms.ProgressBar -Property @{
    Width    = 165
    Height   = 30
    Maximum  = 100
    Minimum  = 0
    Location = new-object System.Drawing.Size(5,370)
}

$btnAdd_acccls             = New-Object system.Windows.Forms.Button -Property @{
    Text     = "Ввод"
    Width    = 105
    Height   = 30
    Anchor   = 'top'
    Location = New-Object System.Drawing.Point(180,370)
    Font     = 'Microsoft Sans Serif,10'
}

function btnAdd_acccls_Click() 
{
    $prBar_acccls.Value = 30
    $cmd=$global:conn.CreateCommand()
#begin create accounts table    
    $cmd.CommandText = "
        if object_id(N'dbo.tt_bal') is not null drop table tt_bal
        create table tt_bal (n int identity(1,1), tt_bal varchar(5))
        "
    $cmd.ExecuteNonQuery()    
#end create accounts table 

    if(($txtMinDate_acccls.Text.Length -eq 8) -and ($txtMaxDate_acccls.Text.Length -eq 8)){
        
        $minDate = $txtMinDate_acccls.Text
        $maxDate = $txtMaxDate_acccls.Text        
        }
    else {
        $minDate = $calendar_acccls.SelectionStart.ToShortDateString()
         }

#begin close accs
    if($ChkBoxTypes_acccls.Checked){
        $cmd.CommandText = "insert into tt_bal (tt_bal) select distinct left(a, 5) from oz"
        $cmd.ExecuteNonQuery()
    }

    elseif($cBoxTypes_acccls.SelectedItem -eq "Вклады_тест"){
       
       $cmd.CommandText = "insert into tt_bal (tt_bal) values ('40802'),('40817'),('40820'),('42301'),('42302'),('42303'),('42304'),('42305'),('42306'),('42307'),('42301'),('42302'),('42303'),('42304'),('42305'),('42306'),('42307'),('47411')"
       $cmd.ExecuteNonQuery()       
                   
    }
    elseif($cBoxTypes_acccls.SelectedItem -eq "Кошельки без ИД/УпрИД"){
            
       $cmd.CommandText = "insert into tt_bal (tt_bal) values ('40903')"
       $cmd.ExecuteNonQuery()

    }
    elseif($cBoxTypes_acccls.SelectedItem -eq "Кошельки с ИД"){
            
       $cmd.CommandText = "insert into tt_bal (tt_bal) values ('40914')"
       $cmd.ExecuteNonQuery()

    }
    elseif($cBoxTypes_acccls.SelectedItem -eq "Кредиты_тест"){
            
       $cmd.CommandText = "insert into tt_bal (tt_bal) values ('45501')"
       $cmd.ExecuteNonQuery()

    }
    else{
        try{
        $global:sql_acc_type = $cBoxTypes_acccls.Text
        $cmd.CommandText = "insert into tt_bal (tt_bal) values $global:sql_acc_type"
        $cmd.ExecuteNonQuery()  
        $true      
       } catch {
            if($global:sql_acc_type -cnotmatch ("\('d*'\)")) 
            {
                throw "Неверный формат заполнения поля"
            } 
            else {
                throw "Что-то пошло не так"
                }
       } 
    }
    try{
    $cmd.CommandText = "
    declare @minDate date = '$minDate'
    declare @maxDate date = '$maxDate'
    declare @count date = @minDate;
    
    while @count <= replace(@maxDate, '1900-01-01', @minDate)
    begin
	    declare @bal_count int = 1
	    declare	@bal varchar(5) = ''
	    while @bal_count <= (select count(*) from tt_bal)
	    begin
		    set @bal = (select tt_bal from tt_bal where n = @bal_count)
		    declare @oz_qty int
		    declare @rand_percent_vol float = $global:ClosePercentValue
		    declare @rand_percent float = @rand_percent_vol/100
		    set @oz_qty = ((select count(*) from oz where a like @bal+'%' and a_opn = @count)*@rand_percent)
		    declare @i int = 1
		    while @i <= @oz_qty
		    begin
			    update oz
			    set A_CLS = @count
			    where A like @bal+'%' and A_CLS is null and A in 
				    (select top 1 a 
				    from oz 
				    where 1=1
				    and a like @bal+'%' 
				    and a_opn <= @count
				    and (select isnull(crout, 0) from os where bln = @count and a = oz.a) = 0 
				    and A_CLS is null
				    order by NEWID())
			    set @i = @i+1
		    end
		    set @bal_count = @bal_count + 1
	    end
	    set @count  = DATEADD(day, 1, @count)
    end
    "
    $cmd.ExecuteNonQuery()
    $prBar_acccls.Value = 95
    $true
    [System.Windows.Forms.MessageBox]::Show('Выполнено')
    } catch {
        if ($_.Exception.Message -match 'bal') { throw "неверно задан список балансовых счетов" }
        elseif ($_.Exception.Message -match 'data') { throw "неверно задан период" }
        elseif ($_.Exception.Message -match 'Недопустимое имя объекта "oz"') { throw "отсутствует таблица OZ" }
        else {throw $_}
    }

    $cmd.CommandText = "
        if object_id(N'dbo.tt_bal') is not null drop table tt_bal
    "
    $cmd.ExecuteNonQuery()
    $prBar_acccls.Value = 100
#end close accs
}
$btnAdd_acccls.Add_Click({ btnAdd_acccls_Click })

$btnNext_acccls             = New-Object system.Windows.Forms.Button -Property @{
    Text     = "Далее"
    Width    = 105
    Height   = 30
    Anchor   = 'top'
    Location = New-Object System.Drawing.Point(292,370)
    Font     = 'Microsoft Sans Serif,10'
}

$btnNext_acccls.Add_Click({
       $form_AccountsClose.Close()
       $form_AccountsClose.Dispose()
       . .\step_three.ps1
})

$form_AccountsClose.controls.AddRange(@($lblAccountsClose,$grBoxTrackBars_acccls,$grBoxDates_acccls,$grBoxTypes_acccls,$btnNext_acccls,$btnAdd_acccls,$prBar_acccls))
$grBoxTrackBars_acccls.controls.AddRange(@($lblClosePercent,$lblClosePercentCount,$tBarClosePercent,$txtClosePercentCount))
$grBoxDates_acccls.controls.AddRange(@($lblMinDate_acccls,$txtMinDate_acccls,$lblMaxDate_acccls,$txtMaxDate_acccls,$calendar_acccls))
$grBoxTypes_acccls.controls.AddRange(@($cBoxTypes_acccls,$lblTypesExample_acccls,$ChkBoxTypes_acccls))
#end account close
$form_AccountsClose.ShowDialog()