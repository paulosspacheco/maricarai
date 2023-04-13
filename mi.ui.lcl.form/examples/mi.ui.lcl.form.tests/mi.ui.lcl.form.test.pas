// Para manter a compatibilidade de fonts com o windows instalar pacote:
// sudo apt-get install msttcorefonts
// Site: https://linuxhint.com/ttf-mscorefonts-installer/

program mi.ui.lcl.form.test;
{:< O programa **@name** é usado para testar o pacote mi.db configurado para gerar
    código para: win32, win64 e linux.

  - **VERSÃO**:
    - Alpha - 0.7.0.0

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
  Interfaces, Forms, sdflaz, lazcontrols, memdslaz, tachartlazaruspkg, drivers,
  sysUtils, dialogs, LCLIntf, uMi_ui_mi_msgbox_dm, mi.rtl.Types,
  mi.rtl.Objects.Methods, mi_rtl_ui_consts, umi_ui_inputbox_lcl_test,
  uMi_ui_DmxScroller_Form_Lcl_ds_test, uMi_ui_DmxScroller_Form_Lcl_ds_test2_dm,
  uMi_ui_DmxScroller_Form_Lcl_ds_test2, uDmxScroller_Form_Lcl_test,
  uDmxScroller_Form_Lcl_add_test, uDmxScroller_Form_Lcl_add_test2;

{$R *.res}

function CreateDb(okCria:Boolean):boolean;
  var
    s : String;

begin
  result := true;
  with TObjectsMethods do
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


begin
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
  TUiConsts.OkCreateTableSQL := false;

  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  //  Application.CreateForm(TMi_ui_mi_msgBox, Mi_ui_mi_msgBox);
  //  Application.CreateForm(TMI_UI_InputBox, MI_UI_InputBox);


  Application.CreateForm(TDmxscroller_form_lcl_test          , Dmxscroller_form_lcl_test);
  Application.CreateForm(TMi_ui_DmxScroller_Form_Lcl_ds_test , Mi_ui_DmxScroller_Form_Lcl_ds_test);

  Application.CreateForm(TMi_ui_DmxScroller_Form_Lcl_ds_test2_dm, Mi_ui_DmxScroller_Form_Lcl_ds_test2_dm);
  Application.CreateForm(TMi_ui_DmxScroller_Form_Lcl_ds_test2   , Mi_ui_DmxScroller_Form_Lcl_ds_test2);

  Application.CreateForm(TDmxScroller_Form_Lcl_add_test,DmxScroller_Form_Lcl_add_test);
  Application.CreateForm(TDmxScroller_Form_Lcl_add_test2,DmxScroller_Form_Lcl_add_test2);
  Application.Run;
end.





