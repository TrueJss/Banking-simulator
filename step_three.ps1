#begin processing step 3
$form_Processing_step3                 = New-Object system.Windows.Forms.Form -Property @{
    ClientSize      = '400,150'
    Text            = "Процессинг"
    TopMost         = $false
    StartPosition = [Windows.Forms.FormStartPosition]::CenterScreen
    FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::Fixed3D
}

$grBoxProcessing_step3                 = New-Object system.Windows.Forms.Groupbox -Property @{
    Height          = 100
    Width           = 400
    Location        = New-Object System.Drawing.Point(0,25)
}

$lblProcessing_step3                   = New-Object system.Windows.Forms.Label -Property @{
    Text              = "Требуется ли пересоздание и очистка таблиц?"
    AutoSize          = $true
    Location          = New-Object System.Drawing.Point(60,5)
    Font              = 'Microsoft Sans Serif,10'
}

$btnProcessing_step3_Yes                = New-Object system.Windows.Forms.Button -Property @{
    Text           = "Да"
    Width          = 100
    Height         = 50
    Location       = New-Object System.Drawing.Point(67,25)
    Font           = 'Microsoft Sans Serif,10'
}

function btnProcessing_step3_Yes_Click() 
{
    try{
        $cmd=$global:conn.CreateCommand()
        $cmd.CommandText = "
            truncate table os
            truncate table op

            if object_id(N'dbo.out_acc') is not null drop table out_acc
            create table dbo.out_acc
            (
	            acc varchar(25), 
	            bik_out varchar(9), 
	            acc_out varchar(25)
            )

            if object_id(N'dbo.table_ost') is not null drop table table_ost
            create table table_ost  
            (
	            acc varchar(25), 
	            ost float
            )

            if object_id(N'dbo.r_operations') is not null drop table r_operations
            create table r_operations 
            (
	            id int identity(1,1),
	            acc varchar(25), 
	            acc_cor varchar(25), 
	            datetime datetime, 
	            sum float, 
	            [type] bit,
	            d_c varchar(50),
	            return_status bit
            )

            if object_id(N'dbo.r_from_equires') is not null drop table r_from_equires
            create table r_from_equires
            (
	            [ID] int identity(1,1),
	            [ID_source] [varchar](25) NULL,
	            [ID_client] [varchar](25) NULL,
	            [ID_recipient] [varchar](25) NULL,
	            [ID_equire] [varchar](25) NULL,
	            [currency] [varchar](3) NULL,
	            [data] [datetime] NULL,
	            [sum] [float] NULL
            ) ON [PRIMARY]

            if object_id(N'dbo.r_withdraw') is not null drop table r_withdraw
            create table r_withdraw
            (
	            [ID] int identity(1,1),
	            [ID_client] [varchar](25) NULL,
	            [A_client] [varchar](25) NULL,
	            [ID_recipient] [varchar](25) NULL,
	            [A_recipient] [varchar](25) NULL,
	            [currency] [varchar](3) NULL,
	            [data] [datetime] NULL,
	            [sum] [float] NULL
            ) ON [PRIMARY]

            if object_id(N'dbo.r_sources') is not null drop table r_sources
            create table r_sources
            (
	            [ID_source] [varchar](50) NULL,
	            [Type_source] [varchar](50) NULL
            ) ON [PRIMARY]

            if object_id(N'dbo.r_clients') is not null drop table r_clients
            create table r_clients
            (
	            [id] [int] IDENTITY(1,1) NOT NULL,
	            [ID_client] [varchar](50) NULL,
	            [INFO_client] [varchar](50) NULL
            ) ON [PRIMARY]
        "
        $cmd.ExecuteNonQuery()

        $cmd.CommandText = "
        insert into r_sources
        select top 300 'ATM'+convert(varchar, left(NEWID(), 8)) 'ID_source', 
        'Bankomat nomer ' + convert(varchar, ROW_NUMBER() over (partition by null order by (select null))) 'Type'
        FROM sysobjects A
        CROSS JOIN sysobjects B
        CROSS JOIN sysobjects C
        union all
        select top 1000 'S'+convert(varchar(100), left(NEWID(), 8)+right(NEWID(), 12)) 'name', 
        'Site ' + convert(varchar, ROW_NUMBER() over (partition by null order by (select null))) 'Type'
        FROM sysobjects A
        CROSS JOIN sysobjects B
        CROSS JOIN sysobjects C
        union all
        select top 1000 'RTL'+convert(varchar(100), left(NEWID(), 5)+right(NEWID(), 5)) 'name', 
        'Terminal Retail ' + convert(varchar, ROW_NUMBER() over (partition by null order by (select null))) 'Type'
        FROM sysobjects A
        CROSS JOIN sysobjects B
        CROSS JOIN sysobjects C
        "
        $cmd.ExecuteNonQuery()

        $cmd.CommandText = "
        insert into r_clients
        select * 
        from (
	        select top 1000 'C'+convert(varchar(100), left(NEWID(), 8)+right(NEWID(), 12)) 'ID_client', 
	        'Unsigned' 'INFO_client'
	        FROM sysobjects A
	        CROSS JOIN sysobjects B
	        CROSS JOIN sysobjects C
	        )p
        "
        $cmd.ExecuteNonQuery()
        
        $cmd.CommandText = "
        if object_id(N'tempdb..#card_nums') is not null drop table #card_nums
        select top 1000 concat(tt, '******', right(tt, 4)) 'card_num', ROW_NUMBER() over (partition by null order by (select null)) 'rn' 
        into #card_nums 
        from (
	        SELECT top 2000
		        round(
				        abs(COS(2 * PI() * RAND(BINARY_CHECKSUM(NEWID()))) *
				        SQRT(-2 * LOG(RAND(BINARY_CHECKSUM(NEWID()))))) * 1000000 + 5
			        , 0) 'tt'
	        FROM sysobjects A
	        CROSS JOIN sysobjects B
	        CROSS JOIN sysobjects C) t
        where len(tt) = 6

        if object_id(N'tempdb..#id_clients') is not null drop table #id_clients
        select * into #id_clients 
        from (
	        select top 1000 'C'+convert(varchar(100), left(NEWID(), 8)+right(NEWID(), 12)) 'ID_client', 
	        ROW_NUMBER() over (partition by null order by (select null)) 'rn'
	        --'Site ' + convert(varchar, ROW_NUMBER() over (partition by null order by (select null))) 'INFO_client'
	        FROM sysobjects A
	        CROSS JOIN sysobjects B
	        CROSS JOIN sysobjects C
	        )p

        insert into r_clients
        select #id_clients.ID_client, #card_nums.card_num
        from #id_clients
        join #card_nums on #card_nums.rn = #id_clients.rn
        "
        $cmd.ExecuteNonQuery()

        $cmd.CommandText = "
        if object_id(N'tempdb..#phone_nums') is not null drop table #phone_nums
        select top 500 '8'+left(convert(bigint,tt), 10) 'phone_num', ROW_NUMBER() over (partition by null order by (select null)) 'rn' 
        into #phone_nums 
        from (
	        SELECT top 2000
		        round(
				        abs(COS(2 * PI() * RAND(BINARY_CHECKSUM(NEWID()))) *
				        SQRT(-2 * LOG(RAND(BINARY_CHECKSUM(NEWID()))))) * 99999999999 + 3
			        , 0) 'tt'
	        FROM sysobjects A
	        CROSS JOIN sysobjects B
	        CROSS JOIN sysobjects C) t
        union all
        select top 500 '+7'+left(convert(bigint,tt), 10), rn
        --into #phone_nums 
        from (
	        SELECT top 2000
		        round(
				        abs(COS(2 * PI() * RAND(BINARY_CHECKSUM(NEWID()))) *
				        SQRT(-2 * LOG(RAND(BINARY_CHECKSUM(NEWID()))))) * 99999999999 + 3
			        , 0) 'tt', ROW_NUMBER() over (partition by null order by (select null)) 'rn'
	        FROM sysobjects A
	        CROSS JOIN sysobjects B
	        CROSS JOIN sysobjects C) t
        where rn > 500

        if object_id(N'tempdb..#id_clients') is not null drop table #id_clients
        select * into #id_clients 
        from (
	        select top 1000 'C'+convert(varchar(100), left(NEWID(), 8)+right(NEWID(), 12)) 'ID_client', 
	        ROW_NUMBER() over (partition by null order by (select null)) 'rn'
	        --'Site ' + convert(varchar, ROW_NUMBER() over (partition by null order by (select null))) 'INFO_client'
	        FROM sysobjects A
	        CROSS JOIN sysobjects B
	        CROSS JOIN sysobjects C
	        )p

        insert into r_clients
        select #id_clients.ID_client, #phone_nums.phone_num
        from #id_clients
        join #phone_nums on #phone_nums.rn = #id_clients.rn
        "
        $cmd.ExecuteNonQuery()

        $true
    $result = [System.Windows.Forms.MessageBox]::Show('Выполнено')
    if ($result -eq 'OK') {
        $form_Processing_step3.Close()
        $form_Processing_step3.Dispose()
        . .\common_options.ps1
    }
    } catch {
        throw $_
            }
    
}

$btnProcessing_step3_Yes.Add_Click({ btnProcessing_step3_Yes_Click })


$btnProcessing_step3_No                 = New-Object system.Windows.Forms.Button -Property @{
    Text            = "Нет"
    Width           = 100
    Height          = 50
    Location        = New-Object System.Drawing.Point(234,25)
    Font            = 'Microsoft Sans Serif,10'
}

$btnProcessing_step3_No.Add_Click({
       $form_Processing_step3.Close()
       $form_Processing_step3.Dispose()
       . .\common_options.ps1
})

$form_Processing_step3.controls.AddRange(@($grBoxProcessing_step3,$lblProcessing_step3))
$grBoxProcessing_step3.controls.AddRange(@($btnProcessing_step3_Yes,$btnProcessing_step3_No))
#end processing step 3
$form_Processing_step3.ShowDialog()