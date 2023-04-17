#begin account open
$AccountsOpen               = New-Object system.Windows.Forms.Form -Property @{
    ClientSize    = '410,490'
    Text          = "Генератор счетов"
    StartPosition = [Windows.Forms.FormStartPosition]::CenterScreen
    FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::Fixed3D
}

$tooltip            = New-Object System.Windows.Forms.ToolTip

$ShowHelp={
     Switch ($this.name) {
        "calendar"  {$tip = "Выбрать дату"}
        "min_date" {$tip = "Ввести начальную дату периода (формат 20200101)"}
        "max_date" {$tip = "Ввести конечную дату периода (формат 20200101)"}
        "cBoxTypes" {$tip = "Выбрать набор счетов для создания или ввести свой (формат ('20202'), ('40817')"}
        "lblTypes" {$tip = "Выбрать набор счетов для создания или ввести свой (формат ('20202'), ('40817')"}
      }
     $tooltip.SetToolTip($this,$tip)
}

$grBoxDates     = New-Object system.Windows.Forms.Groupbox -Property @{
    Height      = 185
    Width       = 410
    Location    = New-Object System.Drawing.Point(0,0)
    Text = "Выбор даты или периода"
}

$calendar           = New-Object Windows.Forms.MonthCalendar -Property @{
    ShowTodayCircle   = $false
    MaxSelectionCount = 1
    Location          = New-Object System.Drawing.Point(5,17)
    Name              = "calendar"
}
$calendar.add_MouseHover($ShowHelp)

$lblMinDate         = New-Object system.Windows.Forms.Label -Property @{
    Text     = "Дата начала:"
    AutoSize = $true
    Width    = 25
    Height   = 10
    Location = New-Object System.Drawing.Point(180,20)
    Font     = 'Microsoft Sans Serif,10'
}
                     
$txtMinDate         = New-Object system.Windows.Forms.TextBox -Property @{
    Multiline = $false
    Width     = 105
    Height    = 20
    Anchor    = 'top'
    Location  = New-Object System.Drawing.Point(292,17)
    Font      = 'Microsoft Sans Serif,10'
    Name      = "min_date"
}
$txtMinDate.add_MouseHover($ShowHelp)

$txtMinDate.Add_TextChanged({
    $this.Text = $this.Text -replace '\D'
})
                     
$lblMaxDate         = New-Object system.Windows.Forms.Label -Property @{
    Text     = "Дата окончания:"
    AutoSize = $true
    Width    = 25
    Height   = 10
    Location = New-Object System.Drawing.Point(180,50)
    Font     = 'Microsoft Sans Serif,10'
}
                     
$txtMaxDate         = New-Object system.Windows.Forms.TextBox -Property @{
    Multiline = $false
    Width     = 105
    Height    = 20
    Anchor    = 'top'
    Location  = New-Object System.Drawing.Point(292,47)
    Font      = 'Microsoft Sans Serif,10'
    Name      = "max_date"
}
$txtMaxDate.add_MouseHover($ShowHelp)

$txtMaxDate.Add_TextChanged({
    $this.Text = $this.Text -replace '\D'
})
                                                       
$grBoxParameters     = New-Object system.Windows.Forms.Groupbox -Property @{
    Height      = 300
    Width       = 410
    Location    = New-Object System.Drawing.Point(0,185)
    Text        = "Ввод параметров"
}

$lblDepartment      = New-Object system.Windows.Forms.Label -Property @{
    Text       = "Структурные подразделения:"
    AutoSize   = $false
    Width      = 110
    Height     = 30
    Location   = New-Object System.Drawing.Point(5,20)
    Font       = 'Microsoft Sans Serif,10'
}

$tBarDepartment     = New-Object Windows.Forms.TrackBar -Property @{
    Location      = New-Object System.Drawing.Point(120,15)
    Orientation   = "Horizontal"
    Width         = 240
    Height        = 10
    TickFrequency = 1
    TickStyle     = "TopLeft"
    Value         = 1
}
$tBarDepartment.SetRange(1, 10)
$tbarDepartmentValue = 1
$global:DepartmentValue = 1

$txtDepartmentCount         = New-Object system.Windows.Forms.TextBox -Property @{
    Multiline = $false
    Width     = 35
    Height    = 15
    Anchor    = 'top'
    Location  = New-Object System.Drawing.Point(360,20)
    Font      = 'Microsoft Sans Serif,10'
    Text      = "$tbarDepartmentValue"
}

$txtDepartmentCount.add_TextChanged({
    $tbarDepartmentValue = $txtDepartmentCount.Text
    $lblDepartmentCount.Text = "Количество: $tbarDepartmentValue"
    $tBarDepartment.Value = $txtDepartmentCount.Text
    $global:DepartmentValue = $tbarDepartmentValue
})

$tBarDepartment.add_ValueChanged({
    $tbarDepartmentValue = $tBarDepartment.Value
    $lblDepartmentCount.Text = "Количество: $tbarDepartmentValue"
    $txtDepartmentCount.Text = $tbarDepartmentValue
    $global:DepartmentValue = $tbarDepartmentValue
})

$lblDepartmentCount = New-Object System.Windows.Forms.Label -Property @{
    Width           = 150
    Height          = 30
    Location        = New-Object System.Drawing.Point(210,45)
    Font            = 'Microsoft Sans Serif,8'
    Text            = "Количество: $tbarDepartmentValue"
}

$lblAccounts        = New-Object system.Windows.Forms.Label -Property @{
    Text     = "Счета:"
    AutoSize = $true
    Width    = 25
    Height   = 10
    Location = New-Object System.Drawing.Point(5,85)
    Font     = 'Microsoft Sans Serif,10'
}

$tBarAccounts       = New-Object Windows.Forms.TrackBar -Property @{
    Location      = New-Object System.Drawing.Point(120,75)
    Orientation   = "Horizontal"
    Width         = 240
    Height        = 10
    TickFrequency = 100
    TickStyle     = "TopLeft"
    Value         = 1
}
$tBarAccounts.SetRange(1, 1500)
$tBarAccountsValue = 1
$global:AccountsValue = 1

$txtAccountsCount         = New-Object system.Windows.Forms.TextBox -Property @{
    Multiline = $false
    Width     = 35
    Height    = 15
    Anchor    = 'top'
    Location  = New-Object System.Drawing.Point(360,80)
    Font      = 'Microsoft Sans Serif,10'
    Text      = "$tbarAccountsValue"
}

$txtAccountsCount.add_TextChanged({
    $tbarAccountsValue = $txtAccountsCount.Text
    $lblAccountsCount.Text = "Количество: $tbarAccountsValue"
    $tBarAccounts.Value = $txtAccountsCount.Text
    $global:AccountsValue = $tbarAccountsValue
})

$tBarAccounts.add_ValueChanged({
    $tbarAccountsValue = $tBarAccounts.Value
    $lblAccountsCount.Text = "Количество: $tbarAccountsValue"
    $txtAccountsCount.Text = $tbarAccountsValue
    $global:AccountsValue = $tbarAccountsValue
})

$lblAccountsCount   = New-Object System.Windows.Forms.Label -Property @{
    Width         = 130
    Height        = 30
    Location      = New-Object System.Drawing.Point(210,105)
    Font          = 'Microsoft Sans Serif,8'
    Text          = "Количество: $tBarAccountsValue"
}

$lblOldClientsPercent= New-Object system.Windows.Forms.Label -Property @{
    Text     = "Счета, открываемые действующим клиентам:"
    AutoSize   = $false
    Width      = 110
    Height     = 60
    Location = New-Object System.Drawing.Point(5,125)
    Font     = 'Microsoft Sans Serif,10'
}

$tBarOldClientsPercent       = New-Object Windows.Forms.TrackBar -Property @{
    Location      = New-Object System.Drawing.Point(120,135)
    Orientation   = "Horizontal"
    Width         = 240
    Height        = 10
    TickFrequency = 10
    TickStyle     = "TopLeft"
    Value         = 0
}
$tBarOldClientsPercent.SetRange(0, 100)
$tBarOldClientsPercentValue = 0
$global:OldClientsPercentValue = 0

$txtOldClientsPercentCount         = New-Object system.Windows.Forms.TextBox -Property @{
    Multiline = $false
    Width     = 35
    Height    = 15
    Anchor    = 'top'
    Location  = New-Object System.Drawing.Point(360,140)
    Font      = 'Microsoft Sans Serif,10'
    Text      = "$tbarOldClientsPercentValue"
}

$txtOldClientsPercentCount.add_TextChanged({
    $tbarOldClientsPercentValue = $txtOldClientsPercentCount.Text
    $lblOldClientsPercentCount.Text = "Процент от открываемых счетов: $tbarOldClientsPercentValue%"
    $tBarOldClientsPercent.Value = $txtOldClientsPercentCount.Text
    $global:OldClientsPercentValue = $tbarOldClientsPercentValue
})

$tBarOldClientsPercent.add_ValueChanged({
    $tbarOldClientsPercentValue = $tBarOldClientsPercent.Value
    $lblOldClientsPercentCount.Text = "Процент от открываемых счетов: $tbarOldClientsPercentValue%"
    $txtOldClientsPercentCount.Text = $tbarOldClientsPercentValue
    $global:OldClientsPercentValue = $tbarOldClientsPercentValue
})

$lblOldClientsPercentCount   = New-Object System.Windows.Forms.Label -Property @{
    Width         = 240
    Height        = 20
    Location      = New-Object System.Drawing.Point(150,165)
    Font          = 'Microsoft Sans Serif,8'
    Text          = "Процент от открываемых счетов: $tBarOldClientsPercentValue%"
}

$lblTypes           = New-Object system.Windows.Forms.Label -Property @{
    Text     = "Ввод или выбор балансовых счетов:"
    AutoSize = $false
    Width    = 110
    Height   = 50
    Location = New-Object System.Drawing.Point(5,190)
    Font     = 'Microsoft Sans Serif,10'
    Name     = "lblTypes"
}
    $lblTypes.add_MouseHover($ShowHelp)

$cBoxTypes          = New-Object system.Windows.Forms.ComboBox -Property @{
    Width    = 270
    Height   = 20
    Location = New-Object System.Drawing.Point(125,190)
    Font     = 'Microsoft Sans Serif,10'
    Name     = "cBoxTypes"
}
    @('Вклады_тест','Кредиты_тест','Кошельки без ИД/УпрИД', 'Кошельки с ИД') | ForEach-Object {[void] $cBoxTypes.Items.Add($_)}
    $cBoxTypes.add_MouseHover($ShowHelp)
                    
$lblCurrency        = New-Object system.Windows.Forms.Label -Property @{
    Text     = "Валюты открываемых счетов:"
    AutoSize = $false
    Width    = 110
    Height   = 50
    Location = New-Object System.Drawing.Point(5,240)
    Font     = 'Microsoft Sans Serif,10'
}
                    
$LboxCurrencies = New-Object system.Windows.Forms.ListBox
$LboxCurrencies.Width         = 80
$LboxCurrencies.Height        = 65
$LboxCurrencies.Location      = New-Object System.Drawing.Point(125,235)
$LboxCurrencies.SelectionMode = 'MultiExtended'
[void] $LboxCurrencies.Items.Add("RUB")
[void] $LboxCurrencies.Items.Add("USD")
[void] $LboxCurrencies.Items.Add("EUR")
[void] $LboxCurrencies.Items.Add("GBP")
$LboxCurrencies.SelectedIndex = 0

$prBar_accopn = New-Object System.Windows.Forms.ProgressBar -Property @{
    Width    = 165
    Height   = 22
    Maximum  = 100
    Minimum  = 0
    Location = new-object System.Drawing.Size(230,270)
}
                          
$btnAdd             = New-Object system.Windows.Forms.Button -Property @{
    Text     = "Добавить"
    Width    = 80
    Height   = 30
    Anchor   = 'top'
    Location = New-Object System.Drawing.Point(230,235)
    Font     = 'Microsoft Sans Serif,10'
}

$btnNext             = New-Object system.Windows.Forms.Button -Property @{
    Text     = "Далее"
    Width    = 80
    Height   = 30
    Anchor   = 'top'
    Location = New-Object System.Drawing.Point(315,235)
    Font     = 'Microsoft Sans Serif,10'
}

$AccountsOpen.controls.AddRange(@($grBoxParameters,$grBoxDates))
$grBoxParameters.controls.AddRange(@($lblDepartment,$lblDepartmentCount,$tBarDepartment,$txtDepartmentCount,$lblAccounts,$lblAccountsCount,$tBarAccounts,$txtAccountsCount,$lblOldClientsPercent,$lblOldClientsPercentCount,$tBarOldClientsPercent,$txtOldClientsPercentCount,$lblTypes,$lblCurrency,$cBoxTypes,$LboxCurrencies,$btnAdd,$btnNext,$prBar_accopn))
$grBoxDates.controls.AddRange(@($calendar,$lblMinDate,$txtMinDate,$lblMaxDate,$txtMaxDate))

$sql_cur = $LboxCurrencies.SelectedItems

$arrTblNames = @('t_cur', 't_dep', 't_bal')

function btnAdd_Click() 
{
    $prBar_accopn.Value = 2
    $cmd=$global:conn.CreateCommand()
    $cmd.CommandTimeout=0
#begin пересоздание хранимой процедуры
    $cmd.CommandText = "if object_id(N'dbo.SP_ControlByte') is not null drop procedure dbo.SP_ControlByte"
    $cmd.ExecuteNonQuery()
    $prBar_accopn.Value = 5
    $cmd.CommandText = "
        CREATE PROCEDURE SP_ControlByte @Bik char(9), @Acc char(20), @NewAcc char(20) OUTPUT
        AS

        declare @tmpacc char(23)
        declare @key char(23)
        declare @bik_3 char(3)

        set @key='71371371371371371371371'

        if (len(RTRIM(@bik))<>9) raiserror('Неверный БИК',18,1)
        if (len(RTRIM(@acc))<>20) raiserror('Неверный счет',18,1)

        if (STR(RIGHT(@bik,3))<=2) SET @bik_3='0'+SUBSTRING(@bik,5,2)
        ELSE SET @bik_3=SUBSTRING(@bik,7,3);

        declare @i int
        declare @r int
        declare @c varchar(2)
        declare @controlbyte char(1)

        set @tmpacc=@bik_3+SUBSTRING(@acc,1,8)+'0'+SUBSTRING(@acc,10,11)
        set @i=1
        set @r=0

        WHILE @i<=LEN(@key)
        BEGIN
        SET @c=CAST(CAST(SUBSTRING(@tmpacc,@i,1) AS int)*CAST(SUBSTRING(@key,@i,1) AS int) AS varchar(2))

        Set @r=@r+CAST(SUBSTRING(@c,LEN(@c),1) AS int)
        set @i=@i+1
        END

        SET @r=@r*3
        SET @controlbyte=SUBSTRING(STR(@r),LEN(STR(@r)),1)
        SET @NewAcc=SUBSTRING(@acc,1,8)+@controlbyte+SUBSTRING(@acc,10,11)
    "
    $cmd.ExecuteNonQuery()
    $prBar_accopn.Value = 10
#end пересоздание хранимой процедуры

#begin пересоздание таблиц
    $arrTblNames | ForEach-Object {
        $cmd.CommandText = "
        if object_id(N'dbo.$_') is not null drop table $_
        create table $_ (n int identity(1,1), $_ varchar(5))
        "
        $cmd.ExecuteNonQuery()
    }
    $prBar_accopn.Value = 10
#end пересоздания таблиц

    if($cBoxTypes.SelectedItem -eq "Вклады_тест"){
       
       $cmd.CommandText = "insert into t_bal (t_bal) values ('40802'),('40817'),('40820'),('42301'),('42302'),('42303'),('42304'),('42305'),('42306'),('42307'),('42301'),('42302'),('42303'),('42304'),('42305'),('42306'),('42307'),('47411')"
       $cmd.ExecuteNonQuery()       
                   
    }
    elseif($cBoxTypes.SelectedItem -eq "Кошельки без ИД/УпрИД"){
            
       $cmd.CommandText = "insert into t_bal (t_bal) values ('40903')"
       $cmd.ExecuteNonQuery()

    }
    elseif($cBoxTypes.SelectedItem -eq "Кошельки с ИД"){
            
       $cmd.CommandText = "insert into t_bal (t_bal) values ('40914')"
       $cmd.ExecuteNonQuery()

    }
    elseif($cBoxTypes.SelectedItem -eq "Кредиты_тест"){
            
       $cmd.CommandText = "insert into t_bal (t_bal) values ('45501')"
       $cmd.ExecuteNonQuery()

    }
    else{
        try{
        $global:sql_acc_type = $cBoxTypes.Text
        $cmd.CommandText = "insert into t_bal (t_bal) values $global:sql_acc_type"
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

    if(($txtMinDate.Text.Length -eq 8) -and ($txtMaxDate.Text.Length -eq 8)){
        
        $minDate = $txtMinDate.Text
        $maxDate = $txtMaxDate.Text
        #begin создание таблицы с периодом
        $cmd.CommandText = "
            if object_id(N'dbo.t_dates') is not null drop table t_dates
            CREATE TABLE t_dates (N INT identity(1,1), data date null);

            declare @minDate date = '$minDate'
            declare @maxDate date = '$maxDate'
            declare @count date = @minDate;
            declare @res TABLE(data date);

            while @count <= replace(@maxDate, '1900-01-01', @minDate)
            begin
                insert 
                into @res (data)
                values (@count)
                set @count  = DATEADD(day, 1, @count)
            end

            insert into t_dates
	            select *
	            from @res
        "
        $cmd.ExecuteNonQuery()
        #end создание таблицы с периодом
    }
    else {
        $minDate = $calendar.SelectionStart.ToShortDateString()
        #begin создание таблицы с единственной датой
        $cmd.CommandText = "
            if object_id(N'dbo.t_dates') is not null drop table t_dates
            create table t_dates (n int identity(1,1), data date null)
            insert into t_dates (data) values ('$minDate')
        "
        $cmd.ExecuteNonQuery()
        #end создание таблицы с единственной датой
    }

#begin выбор списка валют
    foreach ($s_cur in $sql_cur) {
       if($s_cur -eq "USD"){
            $cmd.CommandText = "insert into t_cur (t_cur) values ('840')"
            $cmd.ExecuteNonQuery()
        }
        elseif($s_cur -eq "EUR"){
            $cmd.CommandText = "insert into t_cur (t_cur) values ('978')"
            $cmd.ExecuteNonQuery() 
        }
        elseif($s_cur -eq "GBP"){
            $cmd.CommandText = "insert into t_cur (t_cur) values ('826')"
            $cmd.ExecuteNonQuery() 
        }
        elseif($s_cur -eq "RUB"){
            $cmd.CommandText = "insert into t_cur (t_cur) values ('810')"
            $cmd.ExecuteNonQuery() 
        }
    }
#end выбор списка валют

#begin таблица с филиалами
        for ($i=1; $i -le $global:DepartmentValue; $i++){
            $cmd.CommandText = "insert into t_dep (t_dep) values ('000'+'$i')"
            $cmd.ExecuteNonQuery() 
            }      
#eng таблица с филиалами

    try{
    $cmd.CommandText = "
        declare	@account varchar(20)
        declare	@bik varchar(9) = '999999999'
        declare	@qty int = $global:AccountsValue;			       --Количество счетов
        declare @data date = ''
        declare @date_count int = 1
        declare @rand_percent int = $global:OldClientsPercentValue --Вероятность открытия счета существующему клиенту


        while @date_count <= (select count(*) from t_dates)
        begin
	        set @data = (select data from t_dates where n = @date_count)
	        print @data
	        declare @bal_count int = 1
	        declare	@bal varchar(5) = ''
	        while @bal_count <= (select count(*) from t_bal)
	        begin
		        set @bal = (select t_bal from t_bal where n = @bal_count)
		        print @bal
		        declare	@dep_count int = 1
		        declare @dep varchar(4) = ''
		        while @dep_count <= (select count(*) from t_dep)
		        begin
			        set @dep = (select t_dep from t_dep where n = @dep_count)
			        print @dep
			        declare	@cur_count int = 1
			        declare	@cur varchar(3) = ''
			        while @cur_count <= (select count(*) from t_cur)
			        begin
				        set @cur = (select t_cur from t_cur where n = @cur_count)
				        declare	@max_acc int = isnull((select top 1 right(a, 7) 'acc' from oz where a like @bal+@cur+'%' order by right(a, 7) desc)+1, 1) --максимальный открытый ранее номер счета + 1, либо начинаем с 1
				        declare	@cc int = @max_acc
                        declare @dcm_num varchar(25) = ''
                        declare @c_id varchar(12) = ''
                        declare @a_id varchar(12) = ''
				        print @cur
					        WHILE @cc <= @max_acc+@qty-1 
					        BEGIN
                                declare @rand_value int = (select top 1 1 + convert(int, (rand(checksum(newid())) * 100)) from sysobjects A	CROSS JOIN sysobjects B)
					            print @rand_value
					            if @rand_value <= @rand_percent
						            set @c_id = (SELECT TOP 1 c_id from oz where a like '4%' order by NEWID())
					            else
						            set @c_id = (select right(NEWID(), 12))
                                set @dcm_num = (select left(NEWID(), 8)) 
                                set @a_id = (select right(NEWID(), 12))
						        set	@account = @bal + @cur + '_' + @dep + substring(cast(10000000+@cc as varchar),2,7)
						        exec dbo.sp_ControlByte @bik, @account, @account output
						        print @account
						        INSERT INTO	oz (a_opn, a_dcm_dt, a_dcm_n, c_id, a, a_id)
						        VALUES (@data, @data, @dcm_num, isnull(@c_id, right(NEWID(), 12)), @account, isnull(@a_id, right(NEWID(), 12)))
						        set @cc=@cc+1
					        END
				        set @cur_count = @cur_count + 1
			        end
		        set @dep_count = @dep_count + 1
		        end
	        set @bal_count = @bal_count + 1
	        end
        set @date_count = @date_count + 1
        end
    "
    $cmd.ExecuteNonQuery()
    $prBar_accopn.Value = 95
    $true
    [System.Windows.Forms.MessageBox]::Show('Выполнено')
    } catch {
        if ($_.Exception.Message -match 'qty') { throw "неверно задано кол-во счетов" }
        elseif ($_.Exception.Message -match 'bal') { throw "неверно задан список балансовых счетов" }
        elseif ($_.Exception.Message -match 'cur') { throw "неверно задан список валют" }
        elseif ($_.Exception.Message -match 'dep'){ throw "неверно задано кол-во филиалов" }
        elseif ($_.Exception.Message -match 'data') { throw "неверно задан период" }
        elseif ($_.Exception.Message -match 'Недопустимое имя объекта "oz"') { throw "отсутствует таблица OZ" }
        else {throw $_}
    }
    
    $cmd.CommandText = "
        if object_id(N'dbo.t_dep') is not null drop table t_dep
        if object_id(N'dbo.t_bal') is not null drop table t_bal
        if object_id(N'dbo.t_dates') is not null drop table t_dates
        if object_id(N'dbo.t_cur') is not null drop table t_cur
    "
    $cmd.ExecuteNonQuery()
    $prBar_accopn.Value = 100

}

$btnAdd.Add_Click({ btnAdd_Click })

$btnNext.Add_Click({
       $AccountsOpen.Close()
       $AccountsOpen.Dispose()
       . .\step_two.ps1
})

#end account open
$AccountsOpen.ShowDialog()