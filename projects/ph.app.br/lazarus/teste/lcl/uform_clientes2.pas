unit uform_clientes2;

{$MODE Delphi}

interface

uses LCLIntf, LCLType,  Classes, DB, Graphics, Forms, Controls, Menus,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, ImgList, StdActns,
  ActnList,  DBCtrls, DBGrids, umi_lcl_scrollbox, uMi_lcl_ui_Form
  ,uFormDock, uclientes, Types;

type

  { Tform_clientes2 }

  Tform_clientes2 = class(TFormDock)
    Button_Pesquisar: TButton;
    CmRefresh: TAction;
    CmGoBof: TAction;
    CmPrevRecord: TAction;
    CmNextRecord: TAction;
    CmSaveFile: TAction;
    CmGoEof: TAction;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    Cadastra: TTabSheet;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    Edit_Pesquisar: TEdit;
    Label1: TLabel;
    Label_title: TLabel;
    Mi_LCL_Scrollbox1: TMi_LCL_Scrollbox;
    Mi_lcl_ui_Form1: TMi_lcl_ui_Form;
    OpenDialog: TOpenDialog;
    Panel2: TPanel;
    SaveDialog: TSaveDialog;
    ActionList1: TActionList;
    CmNewFile: TAction;
    CmExitApp: TAction;
    HelpAbout1: TAction;
    ImageList1: TImageList;
    CmNewRecord: TAction;
    CmUpdateRecord: TAction;
    CmDeleteRecord: TAction;
    CmLocate: TAction;
    cmPrint: TAction;
    CmView: TAction;
    CmProcess: TAction;
    Panel1: TPanel;
    PageControl1: TPageControl;
    Lista: TTabSheet;
    ToolBar1: TToolBar;



    procedure Button_PesquisarClick(Sender: TObject);
    procedure CadastraContextPopup(Sender: TObject; MousePos: TPoint;    var Handled: Boolean);
    procedure CmDeleteRecordExecute(Sender: TObject);
    procedure CmGoBofExecute(Sender: TObject);
    procedure CmGoEofExecute(Sender: TObject);
    procedure CmLocateExecute(Sender: TObject);
    procedure CmNewRecordExecute(Sender: TObject);
    procedure CmNextRecordExecute(Sender: TObject);
    procedure CmPrevRecordExecute(Sender: TObject);
    procedure CmRefreshExecute(Sender: TObject);
    procedure CmUpdateRecordExecute(Sender: TObject);
    procedure Edit_PesquisarExit(Sender: TObject);
    procedure FileSave1Execute(Sender: TObject);

    procedure FormCreate(Sender: TObject);
    procedure Label_titleResize(Sender: TObject);

    procedure TabSheet1Enter(Sender: TObject);


  private
    { Private declarations }
    private var clientes : Tclientes;
  public
    { Public declarations }
  end;

var
  form_clientes2: Tform_clientes2;

implementation

//uses Form_Basico_Modelo_u, uTForm_TDI_Main;

{$R *.lfm}




procedure Tform_clientes2.FileSave1Execute(Sender: TObject);
begin
  SaveDialog.Execute;
end;

procedure Tform_clientes2.CadastraContextPopup(Sender: TObject;  MousePos: TPoint; var Handled: Boolean);
begin

end;

procedure Tform_clientes2.Button_PesquisarClick(Sender: TObject);
begin
  clientes.Locate(Edit_Pesquisar.Text);
end;
procedure Tform_clientes2.Edit_PesquisarExit(Sender: TObject);
begin
  Button_PesquisarClick(Sender);
end;



procedure Tform_clientes2.CmDeleteRecordExecute(Sender: TObject);
begin
   clientes.CmDeleteRecordExecute(self);
end;

procedure Tform_clientes2.CmGoBofExecute(Sender: TObject);
begin
  clientes.CmGoBofExecute(self);
end;

procedure Tform_clientes2.CmGoEofExecute(Sender: TObject);
begin
  clientes.CmGoEofExecute(self);
end;

procedure Tform_clientes2.CmLocateExecute(Sender: TObject);
begin
  PageControl1.ActivePage := Lista;

   //clientes.CmLocateExecute(self);
end;

procedure Tform_clientes2.CmNewRecordExecute(Sender: TObject);
begin
  clientes.CmNewRecordExecute(self);
end;

procedure Tform_clientes2.CmNextRecordExecute(Sender: TObject);
begin
  clientes.CmNextRecordExecute(self);
end;

procedure Tform_clientes2.CmPrevRecordExecute(Sender: TObject);
begin
  clientes.CmPrevRecordExecute(self);
end;

procedure Tform_clientes2.CmRefreshExecute(Sender: TObject);
begin
  clientes.CmRefreshExecute(self);
end;

procedure Tform_clientes2.CmUpdateRecordExecute(Sender: TObject);
begin
 clientes.CmUpdateRecordExecute(self);
end;




procedure Tform_clientes2.FormCreate(Sender: TObject);
begin
  inherited;
  clientes := Tclientes.Create(self);
  clientes.DmxScroller_Form1.Mi_ActionList := ActionList1;
  clientes.active:=true;

  Mi_lcl_ui_Form1.DmxScroller_Form := clientes.DmxScroller_Form1;
  Mi_lcl_ui_Form1.ParentLCL        := Mi_LCL_Scrollbox1;

  Mi_lcl_ui_Form1.Active:=true;
  if clientes.DmxScroller_Form1.Active
  then begin
         if not Assigned(clientes.DmxScroller_Form1.DataSource)
         Then begin
                clientes.DmxScroller_Form1.Create_BufDataset;
              end;

         DBGrid1.DataSource := clientes.DmxScroller_Form1.DataSource;
         DBNavigator1.DataSource := DBGrid1.DataSource;

       end;

  Label_title.Caption:= clientes.DmxScroller_Form1.Alias;
  self.Caption := Label_title.Caption;
  Show;
end;

procedure Tform_clientes2.Label_titleResize(Sender: TObject);
begin
// Label_title.Caption := PageControl1.ActivePage.Caption;
end;



procedure Tform_clientes2.TabSheet1Enter(Sender: TObject);
begin
  Label_title.Caption :=Cadastra.Caption;
end;















end.
