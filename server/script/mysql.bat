@echo off

rem ---------------------------------------------------------
rem ���ƽű�
rem @author kqqsysu@gmail.com
rem ---------------------------------------------------------

rem ����
set PASSWORD=123456
set ACCOUNT=root
set MYSQL=C:\phpStudy\PHPTutorial\MySQL\bin\mysql.exe -u%ACCOUNT% -p%PASSWORD%
set MYSQLDUMP=C:\phpStudy\PHPTutorial\MySQL\bin\mysqldump.exe -u%ACCOUNT% -p%PASSWORD%


set inp=%1
if "%inp%" == "" goto fun_wait_input
goto fun_run

:fun_wait_input
    set inp=
    echo.
    echo ==============================
    echo create:�������ݿ�
    echo copyy:�������ݿ�ṹ
    echo batch:����ִ��
    echo account:�����˺�
    echo ------------------------------
    set /p inp=������ָ��:
    echo ------------------------------
    goto fun_run

:where_to_go
    rem �����Ƿ���������в���
    if [%1]==[] goto fun_wait_input
    goto end

:fun_run
    if [%inp%]==[create] goto fun_create
    if [%inp%]==[copyy] goto fun_copy
    if [%inp%]==[batch] goto fun_batch
    if [%inp%]==[account] goto fun_account
    goto where_to_go


:fun_create
    set /p data=���������ݿ�����:

    %MYSQL% -e "drop database if exists %data%"
    %MYSQL% -e "create database %data%"
    echo �������
    goto where_to_go

:fun_batch
    set /p dir=������Ŀ¼:
    set /p data=ִ�е����ݿ�:
    for /R %dir% %%s in (.,*) do ( 
        %MYSQL% "%data%" < %%s
        echo %%s
    ) 
    echo �������
    goto where_to_go

:fun_copy
    set /p source=Դ���ݿ�:
    set /p target=Ŀ�����ݿ�:
    echo ���ڵ����ṹ......
    %MYSQLDUMP% --opt -d "%source%" > "%source%.sql"
    echo "�ѵ���%source%.sql�����ڵ���ṹ......"
    %MYSQL% "%target%" < "%source%.sql"
    echo �������ݿ�ṹ���
    goto where_to_go

:fun_account
    set /p data=���������ݿ�����:
    %MYSQL% "%data%" -e "update player_login inner join(select @rownum:=@rownum+1 as rank,player_state.pkey,player_state.cbp from player_state join (select @rownum:=0) as r order by player_state.cbp desc) c on player_login.pkey=c.pkey set player_login.accname = c.rank;update player_login set channel_id=11111,game_id=11111,game_channel_id=11111;"
    echo ------ �˺������Ѿ���Ϊս��������� ------
    goto where_to_go

:end