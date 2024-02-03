unit __unit_form_main__;

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
  , __unit_dm_connections__
  , __Unit_FormDock__
  , __unit_form3__
  , __unit_form4__

  ;

type

  { T__form_main__ }

  T__form_main__ = class(TForm)
    Action1: TAction;
    Action_sair: TAction;
    Action__Form4__: TAction;
    Action__form3__: TAction;
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
    procedure Action__form3__Execute(Sender: TObject);
    procedure Action__Form4__Execute(Sender: TObject);
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
  __form_main__: T__form_main__;

implementation

{$R *.lfm}

{ T__form_main__ }

procedure T__form_main__.SaveLayout(Filename: string);
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

procedure T__form_main__.LoadLayout(Filename: string);
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


procedure T__form_main__.FormCreate(Sender: TObject);
begin
  //DockMaster.MakeDockSite(Self,[akBottom],admrpChild);
  DockMaster.MakeDockPanel(AnchorDockPanel1,admrpChild);
  DockMaster.OnCreateControl:=DockMasterCreateControl;
  DockMaster.OnShowOptions:=@ShowAnchorDockOptions;


  if TObjectss.FileExists('layout.xml')
  then LoadLayout('layout.xml');

  if Assigned(__DM_Connections__)
  then begin
         __DM_Connections__.Connection  := true;
         if not __DM_Connections__.Connection
         then halt // Termina a aplicação
         else __DM_Connections__.Connection  := false; //Fecha a conexão com o banco de dados
       end;


end;

procedure T__form_main__.Action__form3__Execute(Sender: TObject);
begin
  DockMaster.ShowControl('__Form3__',true);
end;

procedure T__form_main__.Action_sairExecute(Sender: TObject);
begin
  close;
end;

procedure T__form_main__.Action__Form4__Execute(Sender: TObject);
begin
  DockMaster.ShowControl('__Form4__',true);
end;

procedure T__form_main__.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  SaveLayout('layout.xml');
end;


procedure T__form_main__.DockMasterCreateControl(Sender: TObject;  aName: string; var AControl: TControl; DoDisableAutoSizing: boolean);

begin
  case AnsiIndexStr(UpperCase(aName),
       ['__FORM3__', //0
        '__FORM4__', //1
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
          AControl := T__FormDock__.GetForm(T__Form3__,aName,DoDisableAutoSizing);
          (AControl as T__Form3__).Memo1.Text:='__Form3__';
        end;
     1 : AControl := T__FormDock__.GetForm(T__Form4__,aName,DoDisableAutoSizing);
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

procedure T__form_main__.Action_homeExecute(Sender: TObject);
begin
  TObjectss.ShowMessage('Executar um formulário com as principais ações do aplicativo.');
end;

procedure T__form_main__.Action_searchExecute(Sender: TObject);
begin
  TObjectss.ShowMessage('Executar formulário de pesquisa do aplicativo!');
end;








end.

