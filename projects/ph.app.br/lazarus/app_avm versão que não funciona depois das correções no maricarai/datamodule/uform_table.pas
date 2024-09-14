unit uform_table;

{$MODE Delphi}

interface

uses LCLIntf, LCLType,  Classes, DB, Graphics, Forms, Controls, Menus,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, ImgList, StdActns,
  ActnList,  DBCtrls, DBGrids, umi_lcl_scrollbox, uMi_lcl_ui_Form
  ,uFormDock, udm_table, Types;

type

  { Tform_table }

  Tform_table = class(TFormDock)
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
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);

    procedure FormCreate(Sender: TObject);
    procedure Label_titleResize(Sender: TObject);
    procedure Mi_LCL_Scrollbox1Click(Sender: TObject);

    procedure TabSheet1Enter(Sender: TObject);


  private
    { Private declarations }
    private var dm_table : Tdm_table;
  public
    { Public declarations }
    Procedure SetDataModule(adm_table : Tdm_table);
  end;

var
  form_table: Tform_table;

implementation

//uses Form_Basico_Modelo_u, uTForm_TDI_Main;

{$R *.lfm}



procedure Tform_table.FormCreate(Sender: TObject);
begin
  inherited;
end;

procedure Tform_table.SetDataModule(adm_table: Tdm_table);
begin
  dm_table := adm_table;
  dm_table.DmxScroller_Form1.Mi_ActionList := ActionList1;
  dm_table.active:=true;

  Mi_lcl_ui_Form1.DmxScroller_Form := dm_table.DmxScroller_Form1;
  Mi_lcl_ui_Form1.ParentLCL        := Mi_LCL_Scrollbox1;

  Mi_lcl_ui_Form1.Active:=true;
  if dm_table.DmxScroller_Form1.Active
  then begin
         if not Assigned(dm_table.DmxScroller_Form1.DataSource)
         Then begin
                dm_table.DmxScroller_Form1.Create_BufDataset;
              end;

         DBGrid1.DataSource := dm_table.DmxScroller_Form1.DataSource;
         DBNavigator1.DataSource := DBGrid1.DataSource;
       end;

  Label_title.Caption:= dm_table.DmxScroller_Form1.Alias;
  self.Caption := Label_title.Caption;
  Show;

end;

procedure Tform_table.FileSave1Execute(Sender: TObject);
begin
  SaveDialog.Execute;
end;

procedure Tform_table.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  inherited;
end;

procedure Tform_table.CadastraContextPopup(Sender: TObject;  MousePos: TPoint; var Handled: Boolean);
begin

end;

procedure Tform_table.Button_PesquisarClick(Sender: TObject);
begin
  dm_table.Locate(Edit_Pesquisar.Text);
end;
procedure Tform_table.Edit_PesquisarExit(Sender: TObject);
begin
  Button_PesquisarClick(Sender);
end;



procedure Tform_table.CmDeleteRecordExecute(Sender: TObject);
begin
   dm_table.CmDeleteRecordExecute(self);
end;

procedure Tform_table.CmGoBofExecute(Sender: TObject);
begin
  dm_table.CmGoBofExecute(self);
end;

procedure Tform_table.CmGoEofExecute(Sender: TObject);
begin
  dm_table.CmGoEofExecute(self);
end;

procedure Tform_table.CmLocateExecute(Sender: TObject);
begin
  PageControl1.ActivePage := Lista;

   //dm_table.CmLocateExecute(self);
end;

procedure Tform_table.CmNewRecordExecute(Sender: TObject);
begin
  dm_table.CmNewRecordExecute(self);
end;

procedure Tform_table.CmNextRecordExecute(Sender: TObject);
begin
  dm_table.CmNextRecordExecute(self);
end;

procedure Tform_table.CmPrevRecordExecute(Sender: TObject);
begin
  dm_table.CmPrevRecordExecute(self);
end;

procedure Tform_table.CmRefreshExecute(Sender: TObject);
begin
  dm_table.CmRefreshExecute(self);
end;

procedure Tform_table.CmUpdateRecordExecute(Sender: TObject);
begin
 dm_table.CmUpdateRecordExecute(self);
end;

procedure Tform_table.Label_titleResize(Sender: TObject);
begin
// Label_title.Caption := PageControl1.ActivePage.Caption;
end;

procedure Tform_table.Mi_LCL_Scrollbox1Click(Sender: TObject);
begin

end;



procedure Tform_table.TabSheet1Enter(Sender: TObject);
begin
  Label_title.Caption :=Cadastra.Caption;
end;
















end.
