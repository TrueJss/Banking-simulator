#begin processing step 1
$form_Processing_step1                 = New-Object system.Windows.Forms.Form -Property @{
    ClientSize      = '400,150'
    Text            = "Процессинг"
    TopMost         = $false
    StartPosition = [Windows.Forms.FormStartPosition]::CenterScreen
    FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::Fixed3D
}

$grBoxProcessing_step1                 = New-Object system.Windows.Forms.Groupbox -Property @{
    Height          = 100
    Width           = 400
    Location        = New-Object System.Drawing.Point(0,25)
}

$lblProcessing_step1                   = New-Object system.Windows.Forms.Label -Property @{
    Text              = "Требуется ли открытие новых счетов?"
    AutoSize          = $true
    Location          = New-Object System.Drawing.Point(80,5)
    Font              = 'Microsoft Sans Serif,10'
}

$btnProcessing_step1_Yes                = New-Object system.Windows.Forms.Button -Property @{
    Text           = "Да"
    Width          = 100
    Height         = 50
    Location       = New-Object System.Drawing.Point(67,25)
    Font           = 'Microsoft Sans Serif,10'
}

$btnProcessing_step1_Yes.Add_Click({
    $cmd=$global:conn.CreateCommand()

    $cmd.CommandText = "delete from oz
    where 1=1
    and (a = '30102810200010000001' and C_NM = 'Корреспондентский счет')
    or (a = '70601810100010000002' and C_NM = 'Комиссии взимаемые с магазинов')
    or (a = '70601810800010000001' and C_NM = 'Комиссии по переводам ЭДС')
    or (a = '70606810300010000001' and C_NM = 'Комиссии эквайерам')

    insert into oz (A_OPN, A_DCM_DT, A_DCM_N, C_ID, C_NM, A, A_ID) values
    ('20200101', '20200101', '8B4E82D3', 'FA8641D9FA07', 'Корреспондентский счет', '30102810200010000001', 'DBC6F834B139'),
    ('20200101', '20200101', '9C6DCD23', '8C5BBA143166', 'Комиссии взимаемые с магазинов', '70601810100010000002', '0A3650F6D9DD'),
    ('20200101', '20200101', 'BF0DC77D', '1B212FA45738', 'Комиссии по переводам ЭДС', '70601810800010000001', '9B63FECD56BC'),
    ('20200101', '20200101', 'D1494AAC', 'D7B104169CC2', 'Комиссии эквайерам', '70606810300010000001', '4E6D22A2E54C')"
    $cmd.ExecuteNonQuery()

    $form_Processing_step1.Close()
    $form_Processing_step1.Dispose()
    . .\accounts_open.ps1
})

$btnProcessing_step1_No                 = New-Object system.Windows.Forms.Button -Property @{
    Text            = "Нет"
    Width           = 100
    Height          = 50
    Location        = New-Object System.Drawing.Point(234,25)
    Font            = 'Microsoft Sans Serif,10'
}

$btnProcessing_step1_No.Add_Click({
    $cmd=$global:conn.CreateCommand()

    $cmd.CommandText = "delete from oz
    where 1=1
    and (a = '30102810200010000001' and C_NM = 'Корреспондентский счет')
    or (a = '70601810100010000002' and C_NM = 'Комиссии взимаемые с магазинов')
    or (a = '70601810800010000001' and C_NM = 'Комиссии по переводам ЭДС')
    or (a = '70606810300010000001' and C_NM = 'Комиссии эквайерам')

    insert into oz (A_OPN, A_DCM_DT, A_DCM_N, C_ID, C_NM, A, A_ID) values
    ('20200101', '20200101', '8B4E82D3', 'FA8641D9FA07', 'Корреспондентский счет', '30102810200010000001', 'DBC6F834B139'),
    ('20200101', '20200101', '9C6DCD23', '8C5BBA143166', 'Комиссии взимаемые с магазинов', '70601810100010000002', '0A3650F6D9DD'),
    ('20200101', '20200101', 'BF0DC77D', '1B212FA45738', 'Комиссии по переводам ЭДС', '70601810800010000001', '9B63FECD56BC'),
    ('20200101', '20200101', 'D1494AAC', 'D7B104169CC2', 'Комиссии эквайерам', '70606810300010000001', '4E6D22A2E54C')"
    $cmd.ExecuteNonQuery()

    $cmd.CommandText = "drop table if exists #tt
    create table #tt (acc varchar(5))
    insert into #tt values
    ('30102'),
    ('30232'),
    ('40914'),
    ('47422'),
    ('70601'),
    ('70606')"
    $cmd.ExecuteNonQuery()

    $cmd.CommandText = "select acc from (
    select acc, isnull(c, 0) 'c'
    from #tt
    left join (select left(a,5) 'a', count(a) 'c'
	    from oz
	    where 1=1
	    and (a like '30102%'
	    or a like '30232%'
	    or a like '40914%'
	    or a like '47422%'
	    or a like '70601%'
	    or a like '70606%'
	    )
	    group by left(a,5)
	    )oz on oz.a = #tt.acc
    )p
    where c = 0"
    $adapter = New-Object System.Data.sqlclient.SqlDataAdapter $cmd
    $datatable = New-Object System.Data.DataTable
    $adapter.Fill($datatable) | Out-Null
    if ($datatable.acc -eq $null){
        $form_Processing_step1.Close()
        $form_Processing_step1.Dispose()
        . .\step_two.ps1
        }
    else {[System.Windows.Forms.MessageBox]::Show($datatable.acc, "Отсутствуют счета")}
})

$form_Processing_step1.controls.AddRange(@($grBoxProcessing_step1,$lblProcessing_step1))
$grBoxProcessing_step1.controls.AddRange(@($btnProcessing_step1_Yes,$btnProcessing_step1_No))
#end processing step 1
$form_Processing_step1.ShowDialog()