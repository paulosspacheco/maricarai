unit u__form_xtable2__;

{$MODE Delphi}

interface

uses LCLIntf, LCLType,  Classes, DB, Graphics, Forms, Controls, Menus,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, ImgList, StdActns,
  ActnList,  DBCtrls, DBGrids, umi_lcl_scrollbox, uMi_lcl_ui_Form
  ,uFormDock, u__dm_xtable__, Types;

type

  { T__form_xtable2__ }

  T__form_xtable2__ = class(TFormDock)
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
    private var __dm_xtable__ : T__dm_xtable__;
  public
    { Public declarations }
  end;

var
  __form_xtable2__: T__form_xtable2__;

implementation

//uses Form_Basico_Modelo_u, uTForm_TDI_Main;

{$R *.lfm}




procedure T__form_xtable2__.FileSave1Execute(Sender: TObject);
begin
  SaveDialog.Execute;
end;

procedure T__form_xtable2__.CadastraContextPopup(Sender: TObject;  MousePos: TPoint; var Handled: Boolean);
begin

end;

procedure T__form_xtable2__.Button_PesquisarClick(Sender: TObject);
begin
  __dm_xtable__.Locate(Edit_Pesquisar.Text);
end;
procedure T__form_xtable2__.Edit_PesquisarExit(Sender: TObject);
begin
  Button_PesquisarClick(Sender);
end;



procedure T__form_xtable2__.CmDeleteRecordExecute(Sender: TObject);
begin
   __dm_xtable__.CmDeleteRecordExecute(self);
end;

procedure T__form_xtable2__.CmGoBofExecute(Sender: TObject);
begin
  __dm_xtable__.CmGoBofExecute(self);
end;

procedure T__form_xtable2__.CmGoEofExecute(Sender: TObject);
begin
  __dm_xtable__.CmGoEofExecute(self);
end;

procedure T__form_xtable2__.CmLocateExecute(Sender: TObject);
begin
  PageControl1.ActivePage := Lista;

   //__dm_xtable__.CmLocateExecute(self);
end;

procedure T__form_xtable2__.CmNewRecordExecute(Sender: TObject);
begin
  __dm_xtable__.CmNewRecordExecute(self);
end;

procedure T__form_xtable2__.CmNextRecordExecute(Sender: TObject);
begin
  __dm_xtable__.CmNextRecordExecute(self);
end;

procedure T__form_xtable2__.CmPrevRecordExecute(Sender: TObject);
begin
  __dm_xtable__.CmPrevRecordExecute(self);
end;

procedure T__form_xtable2__.CmRefreshExecute(Sender: TObject);
begin
  __dm_xtable__.CmRefreshExecute(self);
end;

procedure T__form_xtable2__.CmUpdateRecordExecute(Sender: TObject);
begin
 __dm_xtable__.CmUpdateRecordExecute(self);
end;




procedure T__form_xtable2__.FormCreate(Sender: TObject);
begin
  inherited;
  __dm_xtable__ := T__dm_xtable__.Create(self);
  __dm_xtable__.DmxScroller_Form1.Mi_ActionList := ActionList1;
  __dm_xtable__.active:=true;

  Mi_lcl_ui_Form1.DmxScroller_Form := __dm_xtable__.DmxScroller_Form1;
  Mi_lcl_ui_Form1.ParentLCL        := Mi_LCL_Scrollbox1;

  Mi_lcl_ui_Form1.Active:=true;
  if __dm_xtable__.DmxScroller_Form1.Active
  then begin
         if not Assigned(__dm_xtable__.DmxScroller_Form1.DataSource)
         Then begin
                __dm_xtable__.DmxScroller_Form1.Create_BufDataset;
              end;

         DBGrid1.DataSource := __dm_xtable__.DmxScroller_Form1.DataSource;
         DBNavigator1.DataSource := DBGrid1.DataSource;

       end;

  Label_title.Caption:= __dm_xtable__.DmxScroller_Form1.Alias;
  self.Caption := Label_title.Caption;
  Show;
end;

procedure T__form_xtable2__.Label_titleResize(Sender: TObject);
begin
// Label_title.Caption := PageControl1.ActivePage.Caption;
end;



procedure T__form_xtable2__.TabSheet1Enter(Sender: TObject);
begin
  Label_title.Caption :=Cadastra.Caption;
end;















end.
