unit uform_table;

{$MODE Delphi}

interface

uses LCLIntf, LCLType, Classes, DB, Graphics, Forms, Controls, Menus, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ComCtrls, ImgList, StdActns, ActnList, DBCtrls,
  DBGrids, umi_lcl_scrollbox, uMi_lcl_ui_Form, umi_lcl_ui_ds_form, uFormDock,
  udm_table, Types;

type

  { Tform_table }

  Tform_table = class(TFormDock)
    cmClose: TAction;
    BitBtn9: TBitBtn;
    cmCancel: TAction;
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
    BitBtn8: TBitBtn;
    Cadastra: TTabSheet;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    Edit_Pesquisar: TEdit;
    Label1: TLabel;
    Label_title: TLabel;
    Mi_LCL_Scrollbox1: TMi_LCL_Scrollbox;
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
    procedure cmCloseExecute(Sender: TObject);
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
    procedure TabSheet1Enter(Sender: TObject);

  private
    { Private declarations }
    private var dm_table : Tdm_table;

    {: O método **@name** assinala o atributo **dm_table** e as propriedades
       de Mi_lcl_ui_ds_Form1 e ativa-o.

       - **ATENÇÃO**
         - As propriedade **dm_table.DmxScroller_Form1.Mi_ActionList** e
           **Mi_lcl_ui_ds_Form1.DmxScroller_Form** devem serem iniciadas com as
           informações do parâmetro **aDm_Table**, por isso as mesmas não devem
           ser modificadas em tem de designer neste formulários (  TForm_table).
    }
    public Procedure SetDataModule(adm_table : Tdm_table);
    public var Mi_lcl_ui_ds_Form1 : TMi_lcl_ui_ds_Form;
  end;

var
  form_table: Tform_table;

implementation
{$R *.lfm}

procedure Tform_table.SetDataModule(adm_table: Tdm_table);
begin
  dm_table := adm_table;
  if not Assigned(Mi_lcl_ui_ds_Form1.DmxScroller_Form)
  Then Mi_lcl_ui_ds_Form1.DmxScroller_Form := dm_table.DmxScroller_Form1;

  if not Assigned(Mi_lcl_ui_ds_Form1.ParentLCL)
  Then Mi_lcl_ui_ds_Form1.ParentLCL := Mi_LCL_Scrollbox1;

  //if not Assigned(Mi_lcl_ui_ds_Form1.Mi_ActionList)
  //then Mi_lcl_ui_ds_Form1.Mi_ActionList := ActionList1;

  dm_table.active:=true;
  Mi_lcl_ui_ds_Form1.Active:=true;

  if dm_table.DmxScroller_Form1.Active
  then begin
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

procedure Tform_table.FormCreate(Sender: TObject);
begin
  Mi_lcl_ui_ds_Form1 := TMi_lcl_ui_ds_Form.Create(self);
end;

procedure Tform_table.Button_PesquisarClick(Sender: TObject);
begin
  dm_table.Locate('nome',Edit_Pesquisar.Text,[loPartialKey]);  //loCaseInsensitive
end;

procedure Tform_table.cmCloseExecute(Sender: TObject);
begin
  Close;
end;



procedure Tform_table.Edit_PesquisarExit(Sender: TObject);
begin
  Button_PesquisarClick(Sender);
end;

procedure Tform_table.CmDeleteRecordExecute(Sender: TObject);
begin
//   dm_table.CmDeleteRecordExecute(self);
end;

procedure Tform_table.CmGoBofExecute(Sender: TObject);
begin
//  dm_table.CmGoBofExecute(self);
end;

procedure Tform_table.CmGoEofExecute(Sender: TObject);
begin
//  dm_table.CmGoEofExecute(self);
end;

procedure Tform_table.CmLocateExecute(Sender: TObject);
begin
  PageControl1.ActivePage := Lista;
end;

procedure Tform_table.CmNewRecordExecute(Sender: TObject);
begin
 // dm_table.CmNewRecordExecute(self);
end;

procedure Tform_table.CmNextRecordExecute(Sender: TObject);
begin
 // dm_table.CmNextRecordExecute(self);
end;

procedure Tform_table.CmPrevRecordExecute(Sender: TObject);
begin
//  dm_table.CmPrevRecordExecute(self);
end;

procedure Tform_table.CmRefreshExecute(Sender: TObject);
begin
//  dm_table.CmRefreshExecute(self);
end;

procedure Tform_table.CmUpdateRecordExecute(Sender: TObject);
begin
// dm_table.CmUpdateRecordExecute(self);
end;

procedure Tform_table.TabSheet1Enter(Sender: TObject);
begin
 // Label_title.Caption :=Cadastra.Caption;
end;

end.
