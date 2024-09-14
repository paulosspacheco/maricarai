unit unit_form_main;

{$mode Delphi}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  ActnList, Menus, ComCtrls, StdCtrls, Buttons, strUtils
  , AnchorDockPanel
  , AnchorDocking
  , XMLPropStorage
  , AnchorDockOptionsDlg
  , mi.rtl.Objectss
  , unit_dm_connections
  , unit_formdock
  , unit_ZOperadores
  , unit_form4

  ;

type

  { Tform_main }

  Tform_main = class(TForm)
    Action1: TAction;
    Action_sair: TAction;
    ActionForm4: TAction;
    ActionZOperadores: TAction;
    AnchorDockPanel1: TAnchorDockPanel;

    ImageList1: TImageList;
    ActionList1: TActionList;
    Action_home: TAction;
    Action_search: TAction;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
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
    procedure Action_sairExecute(Sender: TObject);
    procedure ActionZOperadoresExecute(Sender: TObject);
    procedure ActionForm4Execute(Sender: TObject);
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

  if Assigned(DM_Connections)
  then begin
         DM_Connections.Connection  := true;
         if not DM_Connections.Connection
         then halt // Termina a aplicação
         else DM_Connections.Connection  := false; //Fecha a conexão com o banco de dados
       end;


end;

procedure Tform_main.ActionZOperadoresExecute(Sender: TObject);
begin
  DockMaster.ShowControl('ZOperadores',true);
end;

procedure Tform_main.Action_sairExecute(Sender: TObject);
begin
  close;
end;

procedure Tform_main.ActionForm4Execute(Sender: TObject);
begin
  DockMaster.ShowControl('Form4',true);
end;

procedure Tform_main.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  SaveLayout('layout.xml');
end;


procedure Tform_main.DockMasterCreateControl(Sender: TObject;  aName: string; var AControl: TControl; DoDisableAutoSizing: boolean);

begin
  case AnsiIndexStr(UpperCase(aName),
       [UpperCase('ZOperadores'), //0
        UpperCase('Form4'), //1
        UpperCase('2'),
        UpperCase('3'),
        UpperCase('4'),
        UpperCase('5'),
        UpperCase('6'),
        UpperCase('7'),
        UpperCase('8'),
        UpperCase('9'),
        UpperCase('10'),
        UpperCase('11')
       ]) of
     0 : begin
          AControl := Tformdock.GetForm(TZOperadores,aName,DoDisableAutoSizing);
        end;
     1 : AControl := Tformdock.GetForm(TForm4,aName,DoDisableAutoSizing);
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

