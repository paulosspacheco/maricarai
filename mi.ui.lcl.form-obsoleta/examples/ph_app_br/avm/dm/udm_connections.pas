
unit udm_connections;

{$mode delphi}{$H+}

interface

uses
  Classes, SysUtils

  ,TypInfo, mi_rtl_ui_dmxscroller_form,  SQLDB, DB

  //,RttiUtils
, mi_rtl_ui_Dmxscroller;

//type
//  string50 =   string[50];
//  String20 = String[20];
//
//type
//  {$M+}
//  TOperadores = class//(TPersistent)
//
//  private
//    FId: Integer;
//    FNome: String50;
//    FTelefone: String20;
//  published
//    property Id: Integer read FId write FId;
//    property Nome: String50 read FNome write FNome;
//    property Telefone: String20 read FTelefone write FTelefone;
//  end;

//type

  { TRTTIUtility }

  //TRTTIUtility = class
  //  class procedure GetObjectFieldInfo(AnObject: TObject);
  //end;
  //
type

  { TDM_Connections }

  TDM_Connections = class(TDataModule)
    DmxScroller_Form1: TDmxScroller_Form;


    SQLConnector1: TSQLConnector;
    SQLTransaction1: TSQLTransaction;
    Operadores: TSQLQuery;
    DataSource1: TDataSource;

    id: TLongintField;
    login: TStringField;
    password: TStringField;
    nome: TStringField;
    telefone: TStringField;



    procedure DmxScroller_Form1AddTemplate(const aUiDmxScroller: TUiDmxScroller
      );
    procedure SQLConnector1Login(Sender: TObject; Username, Password: string);

  private

  public
    function GetFormLogin(Const login: String; Const Senha: String): boolean;
    function DoConnect(Const login: String; Const Senha: String): boolean;

  end;


//  procedure RTTIExample;

var
  DM_Connections: TDM_Connections;

implementation

{$R *.lfm}

{ TRTTIUtility }

//class procedure TRTTIUtility.GetObjectFieldInfo(AnObject: TObject);
//
//var
//  PropList: PPropList;
//  PropCount, I: Integer;
//begin
//  PropCount := GetPropList(AnObject.ClassType, PropList);
//  try
//    Writeln('Field Information for Class: ', AnObject.ClassName);
//    for I := 0 to PropCount - 1 do
//    begin
//      Writeln('Name: ', PropList[I]^.Name, ', Type: ', PropList[I]^.PropType^.Name);
//      if PropList[I]^.PropType^.Kind = tkString then
//        Writeln('Size: ', GetStrProp(AnObject, PropList[I]^.Name));
//    end;
//  finally
//    FreeMem(PropList);
//  end;
//end;


//procedure RTTIExample;
//
//procedure GetObjectFieldInfo(AnObject: TObject);
//var
//  PropList: PPropList;
//
//  PropCount, I: Integer;
//begin
//  PropCount := GetPropList(AnObject.ClassType, PropList);
//  try
//    Writeln('Field Information for Class: ', AnObject.ClassName);
//    for I := 0 to PropCount - 1 do
//    begin
//      Writeln('Name: ', PropList[I]^.Name, ', Type: ', PropList[I]^.PropType^.Name);
//      if PropList[I]^.PropTfunction TDM_Connections.Connection(Const login: String; Const Senha: String): boolean;ype^.Kind = tkString then
//        Writeln('Size: ', GetStrProp(AnObject, PropList[I]^.Name));
//    end;
//  finally
//    FreeMem(PropList);
//  end;
//end;
//
//var
//  OperadoresInstance: TOperadores;
//begin
//  OperadoresInstance := TOperadores.Create;
//  try
//    GetObjectFieldInfo(OperadoresInstance);
//  finally
//    OperadoresInstance.Free;
//  end;
//end;

{ TDM_Connections }


function TDM_Connections.GetFormLogin(const login: String; const Senha: String  ): boolean;
begin
  try
    if Assigned(SQLConnector1.OnLogin)
    then SQLConnector1.OnLogin(self,login,Senha);
    result := SQLConnector1.Connected;
  Except;
    Result := false;
  end;
end;

procedure TDM_Connections.SQLConnector1Login(Sender: TObject; Username, Password: string);
begin
  //with DmxScroller_Form_Lcl_DS1 do
  //  if not GetFormLogin(Username,Password)
  //  then Raise TException.Create('Usuário ou senha inválido');
end;

procedure TDM_Connections.DmxScroller_Form1AddTemplate(
  const aUiDmxScroller: TUiDmxScroller);
begin
  with aUiDmxScroller do
  begin
    AlignmentLabels:= taRightJustify;//taCenter;//taLeftJustify;

    add('~IDENTIFIÇÃO~');
    add('~ E-mail:~\ssssssssssssssssssssssssss`ssssssssssssssssssssssss'+ChFN+'login'+ChH+'Informe seu e-mail');
    add('~ Senha:~\**********`****************************************'+ChFN+'senha'+ChH+'Informe seu e-mail');
    add('');

  end;

end;






function TDM_Connections.DoConnect(const login: String; const Senha: String  ): boolean;
begin
  if GetFormLogin(login,Senha)
  then begin
         SQLConnector1.Connected := true;
         result := SQLConnector1.Connected;
       end
  else result := false;
end;





end.

