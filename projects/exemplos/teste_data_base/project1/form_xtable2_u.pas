unit form_xtable2_u;

{$MODE Delphi}

interface

uses LCLIntf, LCLType, LMessages, Classes, Graphics, Forms, Controls, Menus,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, ImgList, StdActns,
  ActnList, ToolWin, DBCtrls, uMi_ui_scrollbox_lcl
  ,unit_formdock;

type

  { Tform_xtable2 }

  Tform_xtable2 = class(Tformdock)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    Label_title: TLabel;
    Mi_ScrollBox_LCL1: TMi_ScrollBox_LCL;
    Mi_ScrollBox_LCL2: TMi_ScrollBox_LCL;
    Mi_ScrollBox_LCL3: TMi_ScrollBox_LCL;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    ActionList1: TActionList;
    File_CmNewRecord: TAction;
    File_CmUpdateRecord: TAction;
    FileExit1: TAction;
    EditCut1: TEditCut;
    EditCopy1: TEditCopy;
    EditPaste1: TEditPaste;
    HelpAbout1: TAction;
    ImageList1: TImageList;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    FileNewItem: TMenuItem;
    FileOpenItem: TMenuItem;
    FileSaveItem: TMenuItem;
    FileSaveAsItem: TMenuItem;
    N1: TMenuItem;
    FileExitItem: TMenuItem;
    Edit1: TMenuItem;
    CutItem: TMenuItem;
    CopyItem: TMenuItem;
    PasteItem: TMenuItem;
    Help1: TMenuItem;
    HelpAboutItem: TMenuItem;
    CmNewRecord: TAction;
    NovoRegistro1: TMenuItem;
    CmUpdateRecord: TAction;
    Grava1: TMenuItem;
    CmDeleteRecord: TAction;
    ExcluirregistroSelecionado1: TMenuItem;
    CmLocate: TAction;
    Pesquisar1: TMenuItem;
    N2: TMenuItem;
    File_CmPrint: TAction;
    File_CmView: TAction;
    N3: TMenuItem;
    CmProcess: TAction;
    Produto1: TMenuItem;
    CFOP1: TMenuItem;
    CentrodeCustos1: TMenuItem;
    File_CmDeleteRecord: TAction;
    Produto2: TMenuItem;
    NaturezadaOperao1: TMenuItem;
    CentrodeCustos2: TMenuItem;
    Excluir1: TMenuItem;
    Produto3: TMenuItem;
    NaturezadaOperao2: TMenuItem;
    CentrodeCustos3: TMenuItem;
    Panel1: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    ToolBar1: TToolBar;
    procedure File_CmNewRecordExecute(Sender: TObject);
    procedure File_CmUpdateRecordExecute(Sender: TObject);
    procedure FileSave1Execute(Sender: TObject);
    procedure FileExit1Execute(Sender: TObject);
    procedure HelpAbout1Execute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CmNewRecordExecute(Sender: TObject);
    procedure CmUpdateRecordExecute(Sender: TObject);
    procedure CmDeleteRecordExecute(Sender: TObject);

    procedure PageControl1MouseDown(Sender: TObject; Button: TMouseButton;      Shift: TShiftState; X, Y: Integer);


    procedure ToolButton7Click(Sender: TObject);
    procedure CmLocateExecute(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure File_CmPrintExecute(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure File_CmViewExecute(Sender: TObject);
    procedure CmProcessExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  form_xtable2: Tform_xtable2;

implementation

//uses Form_Basico_Modelo_u, uTForm_TDI_Main;

{$R *.lfm}

procedure Tform_xtable2.File_CmNewRecordExecute(Sender: TObject);
begin
  { Do nothing }
  ShowMessage('Bot�o novo File Novo cadastros pressionado');
end;

procedure Tform_xtable2.File_CmUpdateRecordExecute(Sender: TObject);
begin
  //OpenDialog.Execute;
  ShowMessage('Bot�o Consultar cadastros pressionado');
end;

procedure Tform_xtable2.FileSave1Execute(Sender: TObject);
begin
  SaveDialog.Execute;
end;

procedure Tform_xtable2.FormCreate(Sender: TObject);
begin

  //Transforma o console corrent como filho de aWinControl.
  //windows.SetParent(handle, Form_Basico_Modelo.PageControl1.ActivePage.handle );

  Show;
end;

procedure Tform_xtable2.CmLocateExecute(Sender: TObject);
begin
  //Localizar o registro do arquivo selecionado
  ShowMessage('Bot�o localizar registro da tabela selecionada pressionado!');
end;

procedure Tform_xtable2.CmUpdateRecordExecute(Sender: TObject);
begin
  // Gravar o registro selecionado.
    ShowMessage('Bot�o Grava Corrente altera��o pressionado!');
end;

procedure Tform_xtable2.CmNewRecordExecute(Sender: TObject);
begin
 //Executar comando para Posiciona o Formul�rio no novo Registro
 ShowMessage('Bot�o novo Pressionado!');
end;

procedure Tform_xtable2.File_CmViewExecute(Sender: TObject);
begin
  //
  ShowMessage('Bot�o Visualizar impress�o pressionado!');
end;

procedure Tform_xtable2.CmDeleteRecordExecute(Sender: TObject);
begin
  // Excluir o registro Selecioado.
  ShowMessage('Bot�o Excluir Registro pressionado!');
end;

//procedure Tform_xtable2.PageControl1Change(Sender: TObject);
//begin
//  Label_title.Caption := PageControl1.ActivePage.Caption;
//end;

procedure Tform_xtable2.PageControl1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
//  ShowMessage('TabSheet1 pressionado!');
  Label_title.Caption := PageControl1.ActivePage.Caption;
end;



procedure Tform_xtable2.File_CmPrintExecute(Sender: TObject);
begin
  // Aqui deve executara a��o de imprimir o registro selecionado pela tab.
  ShowMessage('Bot�o Imprimir formul�rio selecioado pressionado!');
end;

procedure Tform_xtable2.CmProcessExecute(Sender: TObject);
begin
  //Executar o comando CmProcess se habilitado.
  ShowMessage('Bot�o Processa registro pressionado!');
end;

procedure Tform_xtable2.BitBtn6Click(Sender: TObject);
begin
  //Executar comando para visualizar o arquivo selecionado.
end;

procedure Tform_xtable2.Button1Click(Sender: TObject);
begin
  //Form_TDI_Main.Show;
end;

procedure Tform_xtable2.FileExit1Execute(Sender: TObject);
begin
  //Close;
  //Form_Basico_Modelo.Close;
end;

procedure Tform_xtable2.HelpAbout1Execute(Sender: TObject);
begin
  //AboutBox.ShowModal;
end;

procedure Tform_xtable2.ToolButton7Click(Sender: TObject);
begin
  //Localizar o registro na aba selecionada.
end;

end.
