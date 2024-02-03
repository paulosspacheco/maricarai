unit unit_form_main;

{$mode Delphi}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  ActnList, Menus, ComCtrls, StdCtrls, Buttons
  , StrUtils
  , AnchorDockPanel
  , AnchorDocking
  , XMLPropStorage
  , AnchorDockOptionsDlg
  , mi.rtl.Objectss
  , unit_dm_connections
  , unit_FormDock
  , unit_form3
  , unit_form4

  ;

type

  { Tform_main }

  Tform_main = class(TForm)
    Action_Sair: TAction;
    Action_Suporte_Ajuda: TAction;
    Action_Relatorios_Analises: TAction;
    Action_Integracao_Configuracoes: TAction;
    Action_Gestao_Operadores: TAction;
    Action_Gestao_Convenios_Hospitais: TAction;
    Action_Agendamentos: TAction;
    Action_Gestao_Financeira: TAction;
    Action_Gestao_usuario_pacientes: TAction;
    Action_Gestao_Profissionais_medicos: TAction;
    Actionform4: TAction;
    Actionform3: TAction;
    AnchorDockPanel1: TAnchorDockPanel;

    ImageList1: TImageList;
    ActionList1: TActionList;
    Action_home: TAction;
    Action_search: TAction;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem_test: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    MenuItem_index: TMenuItem;
    MenuItem_home: TMenuItem;
    MenuItem_search: TMenuItem;
    StatusBar1: TStatusBar;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    TopCoolBar: TCoolBar;


    {: O método **@name** testa se o banco de dados está disponível, caso não
    esteja aborta o porgrama}
    procedure Actionform3Execute(Sender: TObject);
    procedure Actionform4Execute(Sender: TObject);
    procedure Action_SairExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);

    procedure Action_homeExecute(Sender: TObject);
//    procedure Action_indexExecute(Sender: TObject);
    procedure Action_searchExecute(Sender: TObject);


  protected
    {: O método **@name** é usado para executar os formulários da aplicação}
    procedure DockMasterCreateControl(Sender: TObject; aName: string; var   AControl: TControl; DoDisableAutoSizing: boolean);

    {: O método **@name** é usado para salva o leyout atual da aplicação}
    procedure SaveLayout(Filename: string);
    {: O método **@name** é usado para carregar o ultimo leyout da aplicação}
    procedure LoadLayout(Filename: string);

  public

  end;

var
  form_main: Tform_main;

implementation

{$R *.lfm}

{ Tform_main }

procedure Tform_main.SaveLayout(Filename: string);
var
  XMLConfig: TXMLConfigStorage;
begin
  try
    // create a new xml config file
    XMLConfig:=TXMLConfigStorage.Create(Filename,false);
    try
      // save the current layout of all forms
      DockMaster.SaveLayoutToConfig(XMLConfig);
      DockMaster.SaveSettingsToConfig(XMLConfig);
      XMLConfig.WriteToDisk;

    finally
      XMLConfig.Free;
    end;
  except
    on E: Exception do begin
      MessageDlg('Error',
        'Error saving layout to file '+Filename+':'#13+E.Message,mtError,
        [mbCancel],0);
    end;
  end;
end;

procedure Tform_main.LoadLayout(Filename: string);
var
  XMLConfig: TXMLConfigStorage;
begin
  try
    // load the xml config file
    XMLConfig:=TXMLConfigStorage.Create(Filename,True);
    try
      // restore the layout
      // this will close unneeded forms and call OnCreateControl for all needed
      DockMaster.LoadLayoutFromConfig(XMLConfig,true);
      DockMaster.LoadSettingsFromConfig(XMLConfig);
    finally
      XMLConfig.Free;
    end;
  except
    on E: Exception do begin
      MessageDlg('Error',
        'Error loading layout from file '+Filename+':'#13+E.Message,mtError,
        [mbCancel],0);
    end;
  end;
end;


procedure Tform_main.FormCreate(Sender: TObject);
begin
  //DockMaster.MakeDockSite(Self,[akBottom],admrpChild);
  DockMaster.MakeDockPanel(AnchorDockPanel1,admrpChild);
  DockMaster.OnCreateControl:=DockMasterCreateControl;
  DockMaster.OnShowOptions:=@ShowAnchorDockOptions;


  if TObjectss.FileExists('layout.xml')
  then LoadLayout('layout.xml');

  if Assigned(dm_connections)
  then begin
         dm_connections.Connection  := true;
         if not dm_connections.Connection
         then halt // Termina a aplicação
         else dm_connections.Connection  := false; //Fecha a conexão com o banco de dados
       end;


end;

procedure Tform_main.Actionform3Execute(Sender: TObject);
begin
  DockMaster.ShowControl('form3',true);
end;

procedure Tform_main.Actionform4Execute(Sender: TObject);
begin
  DockMaster.ShowControl('form4',true);
end;

procedure Tform_main.Action_SairExecute(Sender: TObject);
begin
  close;
end;

procedure Tform_main.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  SaveLayout('layout.xml');
end;


procedure Tform_main.DockMasterCreateControl(Sender: TObject;  aName: string;
                                             var AControl: TControl; DoDisableAutoSizing: boolean);
begin
  case AnsiIndexStr(UpperCase(aName),
       ['FORM3', //0
        'FORM4', //1
        '2',
        '3',
        '4',
        '5',
        '6',
        '7',
        '8',
        '9',
        '10',
        '11'
       ]) of
     0 : begin
          AControl := TFormDock.GetForm(Tform3,aName,DoDisableAutoSizing);
          (AControl as Tform3).Memo1.Text:='form3';
        end;
     1 : AControl := TFormDock.GetForm(Tform4,aName,DoDisableAutoSizing);
     2 : begin end;
     3 : begin end;
     4 : begin end;
     5 : begin end;
     6 : begin end;
     7 : begin end;
     8 : begin end;
     9 : begin end;
    10 : begin end;
    11 : begin end;
    else raise TObjectss.TException.Create(self,'DockMasterCreateControl','Opção "'+aName+'" inválida!!!');
  end;

end;

procedure Tform_main.Action_homeExecute(Sender: TObject);
begin
  TObjectss.ShowMessage('Executar um formulário com as principais ações do aplicativo.');
end;

procedure Tform_main.Action_searchExecute(Sender: TObject);
begin
  TObjectss.ShowMessage('Executar formulário de pesquisa do aplicativo!');
end;








end.

