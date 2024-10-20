// Para manter a compatibilidade de fonts com o windows instalar pacote:
// sudo apt-get install msttcorefonts
// Site: https://linuxhint.com/ttf-mscorefonts-installer/

program mi.ui.lcl.form.test;
{:< O programa **@name** é usado para testar o pacote mi.db configurado para gerar
    código para: win32, win64 e linux.

  - **VERSÃO**:
    - Alpha - 1.0.0

    - **CÓDIGO FONTE**:
      - @html(<a href="../units/mi.ui.tests.pas">mi.ui.tests.pas.pas</a>)

  - Instalação do Lazarus
    - [Manual do Usuário criado pelo: gladiston](https://gladiston.net.br/programacao/lazarus-ide/)
    - [Instalar as fontes da Microsot para compatibilidade com o windows](https://linuxhint.com/ttf-mscorefonts-installer/)
}

{$IFDEF FPC}
  {$MODE Delphi} {$H-}
{$ENDIF}

uses
  {$ifdef unix}
    CThreads, //CMem,https://www.freepascal.org/docs-html/rtl/cmem/index.html
  {$endif}

  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces
  //, Forms
//  ,dos
  , sdflaz, lazcontrols, memdslaz, tachartlazaruspkg, drivers,
  sysUtils, dialogs, LCLIntf, LCLVersion

  , mi.rtl.Types
  //, mi.rtl.Objects.Methods
  //, mi_rtl_ui_consts
  ,mi.rtl.all
  ,uMi_ui_Application_lcl

  , uMi_ui_DmxScroller_Form_Lcl_ds_test
  , uMi_ui_DmxScroller_Form_Lcl_ds_test2_dm
  , uMi_ui_DmxScroller_Form_Lcl_ds_test2
  , uDmxScroller_Form_Lcl_test
  , uDmxScroller_Form_Lcl_add_test
  , uDmxScroller_Form_Lcl_add_test2
  , MI_UI_InputBox_lcl_test_u
  , umi_ui_dmxscroller_form_lcl_ds_test_webmodules, unit_temp;

{$R *.res}

function CreateDb(okCria:Boolean):boolean;
  var
    s : String;

begin

  result := true;
  with TMi_rtl do
  begin
    if okCria
    then begin
           s := CreateDB_or_DropDB(PostgresSQL, //aTypeDataBase : TTypeDataBase;
                             '127.0.0.1',       //aHostname,
                             'postgres',        //aUserName
                             'masterkey',       //aPassword,
                             'maricarai',       //aDataBaseName : String;
                             true); //false : exclui; true : cria
           if S = ''
           then ShowMessage('Banco de dados MarIcarai criado!')
           else begin
                  if pos('already exists',s)=0
                  then begin
                         ShowMessage(s);
                         result := false
                       End;
                End;
         End
    else Begin
           s := CreateDB_or_DropDB(PostgresSQL, //aTypeDataBase : TTypeDataBase;
                              '127.0.0.1',       //aHostname,
                              'postgres',        //aUserName
                              'masterkey',       //aPassword,
                              'maricarai',       //aDataBaseName : String;
                              false); //false : exclui; true : cria
           if S = ''
           then ShowMessage('Banco de dados MarIcarai excluído!')
           else begin
                  ShowMessage(s);
                  Result := false;
                End;
         End;

  End;
end;

Procedure fabiodica;
  const
    fpcver = 'Free Pascal Compiler version '+{$I %FPCVERSION%};
    lazver = 'Lazarus version '+lcl_version;
    compiledate =  'Data da compilação: '+{$I %DATE%}+' '+{$I %TIME%};
    cputarget = 'Target CPU: '+{$I %FPCTARGETCPU%};
    osTarget  = 'Target OS: '+{$I %FPCTARGETOS%};

begin
  writeLn('-------------------');
  writeLn(fpcver);
  writeLn(lazver);
  writeLn(compiledate);
  writeLn(cputarget);
  writeLn(osTarget);

  writeLn('-------------------');
end;


//    i : Integer;
  var
    w : word;
    s:string;
begin
  //s:= IntToStr(sizeof(system.word));

  //s := getenv(TMi_rtl.UpperCase('JAVA_HOME'));
  //for i := 0 to EnvCount do
  //begin
  //   s := EnvStr(i)
  //end;

//  fabiodica;
//  writeLn(sizeof(b));
//  showMessage(SetDirSeparators ( '/pp\bin/win32\ppc386' ) );
  // showMessage(DefaultFormatSettings.DecimalSeparator);

  //Dica do site: https://wiki.freepascal.org/Multiplatform_Programming_Guide
  //Essa dica é importante porque normalmente o local onde fica o programa não tem permissão para gravar.
  //WriteLn ( GetAppConfigDir ( True )) ;
  //WriteLn ( GetAppConfigDir ( False )) ;
  //WriteLn ( GetAppConfigFile ( True )) ;
  //WriteLn ( GetAppConfigFile ( False )) ;

  //if not CreateDb(true)
  //then exit;
//  writeLn(TObjectsMethods.DeleteMask('0.00',['0'..'9','.']));

  Tmi_rtl.OkCreateTableSQL := false;

 SetRequireDerivedFormResource(True);
//  RequireDerivedFormResource := True;

  Application.Scaled:=True;
  Application.Initialize;

  Application.CreateForm(TDmxscroller_form_lcl_test          , Dmxscroller_form_lcl_test);
  Application.CreateForm(TMi_ui_DmxScroller_Form_Lcl_ds_test,Mi_ui_DmxScroller_Form_Lcl_ds_test);

  Application.CreateForm(TMi_ui_DmxScroller_Form_Lcl_ds_test2_dm, Mi_ui_DmxScroller_Form_Lcl_ds_test2_dm);
  Application.CreateForm(TMi_ui_DmxScroller_Form_Lcl_ds_test2   , Mi_ui_DmxScroller_Form_Lcl_ds_test2);
  //
  Application.CreateForm(TDmxScroller_Form_Lcl_add_test,DmxScroller_Form_Lcl_add_test);
  Application.CreateForm(TDmxScroller_Form_Lcl_add_test2,DmxScroller_Form_Lcl_add_test2);

  Application.CreateForm(TMI_UI_InputBox_lcl_test, MI_UI_InputBox_lcl_test);

  Application.CreateForm(TFPWebModule1, FPWebModule1);
  Application.Run;
end.





