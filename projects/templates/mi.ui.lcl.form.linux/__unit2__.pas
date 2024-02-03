unit __unit2__;

{$mode delphi}{$H+}

interface

uses
  Classes, SysUtils
  ,TypInfo, ActnList, Controls, mi_rtl_ui_dmxscroller_form,  SQLDB, DB
  ,inifiles
  ,mi.rtl.Objectss
  ,umi_ui_InputBox_lcl;

type
  TParam = record
             //CONEXÂO
             ConnectorType,
             HostName,
             UserName,
             Password:string;
           end;
type

  { T__DataModule1__ }
  {: O Data Module **@name** é usado para conectar-se ao banco de dados através
     de parâmetros salvos no arquivo config.ini
  }
  T__DataModule1__ = class(TDataModule)
    Action1: TAction;
    Action2: TAction;
    Action3: TAction;
    ActionList1: TActionList;
    ImageList1: TImageList;
    SQLConnector1: TSQLConnector;
    SQLTransaction1: TSQLTransaction;


    {: O evento **@name** é usado para checar no banco de dados se o usuário
       tem permisão para conectar-se.
    }
    procedure Action1Execute(Sender: TObject);
    procedure SQLConnector1Login(Sender: TObject; Username, Password: string);

  private
    _FileNameInit : string;
    _Inifile : TInifile ;
    _Param : TParam;
  public
    Function GetParametros_Conexao(aFileName:String;var aParam:TParam):Boolean;
    procedure SetParametros_Conexao(aFileName:String;var aParam:TParam);

    {$Region '--->Cosntrução da propriedade Connection<---'}

        var _Connection:Boolean ;

        {: O método **@name** conecta-se ou desconecta-se do banco de dados.

           - Notas:
             - A método **@name** checa se o arquivo **config.ini** existe,
               se exis__DataModule1__.Action1tir, ler os parãmetros de conexão do arquivo **config.ini**,
               se não existir pede para a pessoa que executou o programa informar
               os parâmetros para conexão, em seguida salva os parâmetros no arquivo
               **config.ini**.

             - **PARÂMETROS DE CONEXÃO**
               - SESSÃO CONEXÃO;
                 - ConnectorType;
                 - UserName;
                 - Password;
                 - HostName;

             - **REFERÊNCIAS**
               - [Using INI Files](https://wiki.freepascal.org/Using_INI_Files)

        }
        Private Procedure SetConnection(a_Connection:Boolean);
        Private function GetConnection():Boolean;

        Public Property Connection :Boolean Read GetConnection Write SetConnection;
    {$EndRegion '--->Cosntrução da propriedade Connection<---'}
  end;


var
  __DataModule1__: T__DataModule1__;


implementation

{$R *.lfm}



{ T__DataModule1__ }

Procedure InputBoxOnCloseQuery (aDmxScroller:TUiDmxScroller; var CanClose:boolean);
  //Esta função permite validar o formulário ao pressionar o botão ok.

begin
  //s := aDmxScroller.FieldByName('matricula').AsString;
  //matricula := StrToInt(s);
  //
  //with aDmxScroller,MI_MsgBox do
  //if  (matricula > 1000)
  //then begin
  //       aDmxScroller.MI_MsgBox.MessageBox('ATENÇÃO',
  //       Format('Esse campo só aceita valores entre %d a %d  ',[1,1000]),mtWarning, [mbOK],mbOk);
  //       CanClose := false;
  //     end
  //else CanClose := true;


  if  aDmxScroller.FieldByName('password').AsString <> 'masterkey'
  then with aDmxScroller,MI_MsgBox do
       begin
         aDmxScroller.MI_MsgBox.MessageBox('ATENÇÃO', 'Usuário ou senha do usuário inválidos!  ',mtWarning, [mbOK],mbOk);

         CanClose := false;
       end
  else CanClose := true;
end;

procedure InputBoxOnEnter(aDmxScroller: TUiDmxScroller);

  //Ao entrar no formulário este evento inicia os campos
  procedure SetValue(Field:String;Value:String; hint:String);
    var
      aField: pDmxFieldRec;
  begin
    with aDmxScroller do
    begin
      aField := FieldByName(Field);
      if aField<>nil
      Then begin
             aField.AsString:= value;
             SetHelpCtx_Hint(aField,hint);
           end;
    end;
  end;

begin
  with aDmxScroller do
  begin
    setValue('ConnectorType','PostgreSQL','Tipo de banco de dados ');
    setValue('HostName'     ,'45.160.125.12','Ip do banco de dados');
    setValue('UserName'     ,'postgres','Nome do usuário root do banco de dados');
    setValue('Password'     ,'masterkey','Senha do usuário root do banco de dados');
  end;
end;

function GetForm_Connections(out ConnectorType,HostName,UserName,Password : string):integer;
  Var
    MI_UI_InputBox : TMI_UI_InputBox = nil;
    Template : AnsiString;

begin
  Template := '~ConnectorType:~\ssssssssssssssssssss`sssssssssssssssssssss'+ChFN+'ConnectorType'+^M+
              '~     HostName:~\ssssssssssssssssssss`sssssssssssssssssssss'+ChFN+'HostName'+^M+
              '~     UserName:~\ssssssssssssssssssss`sssssssssssssssssssss'+ChFN+'UserName'+^M+
              '~     Password:~\ssssssssssssssssssss`sssssssssssssssssssss'+CharShowPassword+ChFN+'Password'+^M;
  with TObjectss,MI_MsgBox do
  begin
    result := umi_ui_InputBox_lcl.InputBox(
                 'Informe os parâmetros para conexão',
                 Template,
                 InputBoxOnCloseQuery,
                 'Courier New',
                 InputBoxOnEnter,//InputBoxOnEnter,
                 nil,
                 nil,//InputBoxOnEnterField
                 nil,
                 [],//['PostgreSQL','45.160.125.12','postgres','masterkey'],
                 MI_UI_InputBox
                );

    if result = MrOk
    then with MI_UI_InputBox.DmxScroller_Form_Lcl1 do
         begin //Neste bloco pode-se fazer qualcoisa comos dados do formulário.
           ConnectorType := FieldByName('ConnectorType').AsString;
           HostName      := FieldByName('HostName').AsString;
           UserName      := FieldByName('UserName').AsString;
           Password      := FieldByName('Password').AsString;
           MI_UI_InputBox.free;
         end;

  end;
end;

function T__DataModule1__.GetParametros_Conexao(aFileName: String;
  var aParam: TParam): Boolean;
begin
  aFileName := ExpandFileName(aFileName);
  if TObjectss.FileExists(aFileName)
  then With aParam do
       try
        _Inifile := TINIFile.Create(aFileName);
        ConnectorType := _Inifile.ReadString('CONEXAO','ConnectorType','');
        HostName      := _Inifile.ReadString('CONEXAO','HostName','');
        UserName      := _Inifile.ReadString('CONEXAO','UserName','');
        Password      := _Inifile.ReadString('CONEXAO','Password','');

         result := true;
       finally
          freeandnil(_Inifile);
       end
  else Result := false
end;

procedure T__DataModule1__.SetParametros_Conexao(aFileName: String;  var aParam: TParam);
begin
  With aParam do
  try
    _Inifile := TINIFile.Create(aFileName);

    _Inifile.WriteString('CONEXAO','ConnectorType',ConnectorType );
    _Inifile.WriteString('CONEXAO','HostName',HostName);
    _Inifile.WriteString('CONEXAO','UserName',UserName);
    _Inifile.WriteString('CONEXAO','Password',Password);

  finally
    freeandnil(_Inifile);
  end;
end;


procedure T__DataModule1__.SQLConnector1Login(Sender: TObject; Username, Password: string);
begin
//  writeLn(Sender.Classname,' Username: '+Username, ' Password: '+Password);
  TObjectss.LogError(Sender.Classname+' Username: '+Username+ ' Password: '+Password);

  //if not GetFormLogin(Username,Password)
  //then TObjectss.TException.Create('Usuário ou senha inválido!');
end;

procedure T__DataModule1__.Action1Execute(Sender: TObject);
begin
 TObjectss.ShowMessage('Item 01  ');
end;


procedure T__DataModule1__.SetConnection(a_Connection: Boolean);

  procedure disconnect;
  begin
    SQLConnector1.Connected := False;
    _Connection := false;
  end;

  var
    Result_GetForm_Connections:integer;

begin
  if a_Connection
  Then begin
         //Desconecta
         if _Connection
         then disconnect;

          _FileNameInit := ChangeFileExt(ParamStr(0),'.ini');
          if not _Connection
          then repeat
                  if not GetParametros_Conexao(_FileNameInit,_Param)
                  then  begin
                          Result_GetForm_Connections := GetForm_Connections( _Param.ConnectorType,_Param.HostName,_Param.UserName,_Param.Password);
                        end
                  else Result_GetForm_Connections := TObjectss.MI_MsgBox.mrOK;

                  if Result_GetForm_Connections = TObjectss.MI_MsgBox.mrOK
                  then begin
                         try
                           SQLConnector1.ConnectorType := _Param.ConnectorType;
                           SQLConnector1.UserName      := _Param.UserName;
                           SQLConnector1.Password      := _Param.Password;
                           SQLConnector1.HostName      := _Param.HostName;

//                           TObjectss.MessageBox('Pressione ok para conectar-se ao banco de dados...');
                           SQLConnector1.Connected     := true;
                           _Connection                 := SQLConnector1.Connected;

                           SetParametros_Conexao(_FileNameInit,_Param);

                         Except
                           on E : Exception do
                           begin
                             TObjectss.LogError(E.Message);
                             TObjectss.MessageBox(E.Message);
                             _Connection := false;
                             TObjectss.DeleteFile(_FileNameInit);
                           end;
                         end;
                       end;

               until _Connection or (Result_GetForm_Connections <> TObjectss.MI_MsgBox.mrOK);
       end
    else disconnect;
end;

function T__DataModule1__.GetConnection(): Boolean;
begin
  result := _Connection and SQLConnector1.Connected;
end;






end.

