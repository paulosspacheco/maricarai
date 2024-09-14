unit uform_main;

{$mode Delphi}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  ActnList, Menus, ComCtrls, StdCtrls, Buttons, strUtils
  , AnchorDockPanel
  , AnchorDocking
  , XMLPropStorage
  , AnchorDockOptionsDlg
  , mi.rtl.all
  , mi_rtl_ui_Dmxscroller
  , mi_rtl_ui_dmxscroller_form
  , uMi_lcl_inputbox
  , udm_connections
  , uFormDock
  , uconvenios, uform_convenios
  ;

type

  { Tform_main }

  Tform_main = class(TForm)
    Action: TAction;
    Action_test: TAction;
    Cadastros: TMenuItem;
    Menu: TMenuItem;
    MenuItem4: TMenuItem;
    Test_inputBox: TAction;
    CmExitApp: TAction;

    AnchorDockPanel1: TAnchorDockPanel;

    ImageList1: TImageList;
    ActionList1: TActionList;
    Action_home: TAction;
    Action_search: TAction;
    MainMenu1: TMainMenu;
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


    procedure ActionExecute(Sender: TObject);
    procedure CmExitAppExecute(Sender: TObject);



    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);


    procedure FormCreate(Sender: TObject);

    procedure Action_homeExecute(Sender: TObject);
//    procedure Action_indexExecute(Sender: TObject);
    procedure Action_searchExecute(Sender: TObject);


    {: O Método **"name** é um exemplo de como editar um fromulário complexo usando
       apenas o commando inputBox
    }
    procedure Test_inputBoxExecute(Sender: TObject);


  protected
    {: O método **@name** é usado para executar os formulários da aplicação}
    procedure DockMasterCreateControl(Sender: TObject; aName: string; var   AControl: TControl; DoDisableAutoSizing: boolean);

    {: O método **@name** é usado para salva o leyout atual da aplicação}
    procedure SaveLayout(Filename: string);
    {: O método **@name** é usado para carregar o ultimo leyout da aplicação}
    procedure LoadLayout(Filename: string);

  public

  private
//    procedure onExcept(sender: TObject; e: Exception);

    procedure Test_inputBox_CloseQuery(aDmxScroller: TUiDmxScroller;    var CanClose: boolean);
    procedure Test_inputBox_EnterField(aField: pDmxFieldRec);
    procedure Test_inputBox_ExitField(aField: pDmxFieldRec);


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


//procedure Tform_main.onExcept(sender: TObject; e: Exception);
//
//begin
//  TMi_RTL.MessageBox('Tform_main.onExcept');
//
//  TMi_RTL.MessageBox(e.Message);
//end;

procedure Tform_main.FormCreate(Sender: TObject);
begin
  DockMaster.MakeDockPanel(AnchorDockPanel1,admrpChild);
  DockMaster.OnCreateControl:=DockMasterCreateControl;
  DockMaster.OnShowOptions:=@ShowAnchorDockOptions;

  if TMi_rtl.FileExists('layout.xml')
  then LoadLayout('layout.xml');
//  application.onException := onExcept ;
end;


procedure Tform_main.CmExitAppExecute(Sender: TObject);
begin
  close;
end;


procedure Tform_main.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  SaveLayout('layout.xml');
end;


procedure Tform_main.ActionExecute(Sender: TObject);
begin
  DockMaster.ShowControl('form_convenios',true);
end;


procedure Tform_main.DockMasterCreateControl(Sender: TObject;  aName: string; var AControl: TControl; DoDisableAutoSizing: boolean);

begin
  case AnsiIndexStr(UpperCase(aName),
       [UpperCase('form_convenios'), //0
        UpperCase('1'),
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
           AControl := TFormDock.GetForm(tform_convenios,aName,DoDisableAutoSizing);
           (AControl as Tform_convenios).SetDataModule(Tconvenios.Create(AControl));
         end;
     1 : begin
         end;
     2 : begin
         end;
     3 : begin AControl := nil; end;
     4 : begin AControl := nil; end;
     5 : begin AControl := nil; end;
     6 : begin AControl := nil; end;
     7 : begin AControl := nil; end;
     8 : begin AControl := nil; end;
     9 : begin AControl := nil; end;
    10 : begin AControl := nil; end;
    11 : begin AControl := nil; end;
    else raise TMi_rtl.TException.Create(self,'DockMasterCreateControl','Opção "'+aName+'" inválida!!!');
  end;
end;

procedure Tform_main.Action_homeExecute(Sender: TObject);
begin
  TMi_rtl.ShowMessage('Executar um formulário com as principais ações do aplicativo.');
end;

procedure Tform_main.Action_searchExecute(Sender: TObject);
begin
  TMi_rtl.ShowMessage('Executar formulário de pesquisa do aplicativo!');
end;


procedure Tform_main.Test_inputBox_CloseQuery(aDmxScroller: TUiDmxScroller; var CanClose: boolean);
begin
  // Se CanClose = false o dialogo de inputBox não será fechado com o botão ok.
end;

procedure Tform_main.Test_inputBox_EnterField(aField: pDmxFieldRec);
begin
  if aField.FieldName = 'valor_unitario'
  Then begin
         aField.GetOwner.FieldByName('valor_total').value :=
         aField.value *  aField.GetOwner.FieldByName('quantidade').value;
       end;
end;

procedure Tform_main.Test_inputBox_ExitField(aField: pDmxFieldRec);
begin
  if aField.FieldName = 'valor_unitario'
  Then begin
         aField.GetOwner.FieldByName('valor_total').value :=
         aField.value * aField.GetOwner.FieldByName('quantidade').value;
       end;
end;

procedure Tform_main.Test_inputBoxExecute(Sender: TObject);
  var
    in_JSONObject,
    out_JSONObject : TMi_rtl.TJSONObject;

  var
    Mi_rtl : TMi_rtl;
    Resposta :Variant;
begin
  try
    Mi_rtl := TMi_rtl.Create(self);
    with Mi_rtl do
    begin
      in_JSONObject := TJSONObject.Create(['id'      , 1,
                                        'nome'    ,'Paulo Sérgio',
                                        'endereco','Rua Francisco de Souza Oliveira',
                                        'cep'     ,'61624300']);

      if InputBox('Teste InputBox sem eventos',
          ' ~Id:      ~\LLLLLL'+chFN+'id'+^M+
          ' ~Nome:    ~\sssssssssssssssssssssssssssss`sssssssssssssssssssss'+ChFN+'Nome'+^M+
          ' ~Endereço:~\sssssssssssssssssssssssssssss`ssssssssssssssssssssssss'+ChFN+'Endereco'+^M+
          ' ~Cep:     ~\##.###-###'+ChFN+'cep'+^M
          ,in_JSONObject
          ,out_JSONObject) = mrok
      then begin
             printaJsonObject(out_JSONObject);
             out_JSONObject.free;
           end;

      if InputBox('Teste InputBox com evento onFormCloseQuery',
          ' ~Id:      ~\LLLLLL'+chFN+'id'+^M+
          ' ~Nome:    ~\sssssssssssssssssssssssssssss`sssssssssssssssssssss'+ChFN+'Nome'+^M+
          ' ~Endereço:~\sssssssssssssssssssssssssssss`ssssssssssssssssssssssss'+ChFN+'Endereco'+^M+
          ' ~Cep:     ~\##.###-###'+ChFN+'cep'+^M
          ,Test_inputBox_CloseQuery
          ,in_JSONObject
          ,out_JSONObject) = mrok
      then begin
             Resposta := '';
             if Prompt('Pergunta','Imprime o resultado?',Resposta)
             Then printaJsonObject(out_JSONObject);

             out_JSONObject.free;
           end;

      in_JSONObject.free;
      in_JSONObject := TJSONObject.Create(['id'      , 1,
                                        'produto' ,'',
                                        'quantidade',10,
                                        'valor_unitario' ,2,
                                        'valor_total',20
                                        ]);

      if InputBox('Teste InputBox com eventow onEnterField e onExitField ',
          ' ~Id:             ~\LLLLLL'+chFN+'id'+^M+
          ' ~Produto:        ~\sssssssssssssssssssssssssssss`sssssssssssssssssssss'+ChFN+'produto'+^M+
          ' ~Quantidade:     ~\RRR.RR'+ChFN+'quantidade'+^M+
          ' ~Valor Unitário: ~\R,RRR.RR'+ChFN+'valor_unitario'+^M+
          ' ~Valor Total:    ~\RRR,RRR.RR'+CharAccSkip+ChFN+'valor_total'+^M
          ,nil
          ,''
          ,nil
          ,nil
          ,Test_inputBox_EnterField
          ,Test_inputBox_ExitField
          ,in_JSONObject
          ,out_JSONObject) = mrok
      then begin
             Resposta := 's';
             InputValue('Pergunta','Imprime o resultado? s/n',Resposta);
             if Resposta = 's'
             Then printaJsonObject(out_JSONObject);

             out_JSONObject.free;
           end;
    end;


  finally
    in_JSONObject.free;
    FreeAndNil(Mi_rtl);
  end;

end;



initialization



end.

