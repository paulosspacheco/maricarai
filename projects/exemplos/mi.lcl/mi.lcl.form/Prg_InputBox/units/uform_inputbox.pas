unit uForm_InputBox;

{$MODE Delphi}

interface

uses LCLIntf, LCLType, Classes, DB, Graphics, Forms, Controls, Menus, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ComCtrls, ImgList, StdActns, ActnList, DBCtrls,
  DBGrids, UDm_InputBox, umi_lcl_scrollbox, uMi_lcl_ui_Form, Types;

type

  { TForm_InputBox }

  TForm_InputBox = class(TForm)
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
    Label_title: TLabel;
    Mi_LCL_Scrollbox1: TMi_LCL_Scrollbox;
    Mi_lcl_ui_Form1: TMi_lcl_ui_Form;
    OpenDialog: TOpenDialog;
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


    procedure CadastraContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure CmDeleteRecordExecute(Sender: TObject);
    procedure CmGoBofExecute(Sender: TObject);
    procedure CmGoEofExecute(Sender: TObject);
    procedure CmLocateExecute(Sender: TObject);
    procedure CmNewRecordExecute(Sender: TObject);
    procedure CmNextRecordExecute(Sender: TObject);
    procedure CmPrevRecordExecute(Sender: TObject);
    procedure CmUpdateRecordExecute(Sender: TObject);
    procedure FileSave1Execute(Sender: TObject);

    procedure FormCreate(Sender: TObject);
    procedure Label_titleResize(Sender: TObject);

    procedure TabSheet1Enter(Sender: TObject);


  private
    { Private declarations }
    private var Dm_InputBox : TDm_InputBox;
  public
    { Public declarations }
  end;

var
  Form_InputBox: TForm_InputBox;

implementation

//uses Form_Basico_Modelo_u, uTForm_TDI_Main;

{$R *.lfm}




procedure TForm_InputBox.FileSave1Execute(Sender: TObject);
begin
  SaveDialog.Execute;
end;

procedure TForm_InputBox.CadastraContextPopup(Sender: TObject;  MousePos: TPoint; var Handled: Boolean);
begin

end;

procedure TForm_InputBox.CmDeleteRecordExecute(Sender: TObject);
begin
  Dm_InputBox.CmDeleteRecordExecute(self);
end;

procedure TForm_InputBox.CmGoBofExecute(Sender: TObject);
begin
  Dm_InputBox.CmGoBofExecute(self);
end;

procedure TForm_InputBox.CmGoEofExecute(Sender: TObject);
begin
  Dm_InputBox.CmGoEofExecute(self);
end;

procedure TForm_InputBox.CmLocateExecute(Sender: TObject);
begin
  Dm_InputBox.CmLocateExecute(self);
end;

procedure TForm_InputBox.CmNewRecordExecute(Sender: TObject);
begin
  Dm_InputBox.CmNewRecordExecute(self);
end;

procedure TForm_InputBox.CmNextRecordExecute(Sender: TObject);
begin
  Dm_InputBox.CmNextRecordExecute(self);
end;

procedure TForm_InputBox.CmPrevRecordExecute(Sender: TObject);
begin
  Dm_InputBox.CmPrevRecordExecute(self);
end;

procedure TForm_InputBox.CmUpdateRecordExecute(Sender: TObject);
begin
 Dm_InputBox.CmUpdateRecordExecute(self);
end;

procedure TForm_InputBox.FormCreate(Sender: TObject);
begin
  inherited;
  Dm_InputBox := TDm_InputBox.Create(self);
  Dm_InputBox.DmxScroller_Form1.Mi_ActionList := ActionList1;
  Dm_InputBox.active:=true;

  Mi_lcl_ui_Form1.DmxScroller_Form := Dm_InputBox.DmxScroller_Form1;
  Mi_lcl_ui_Form1.ParentLCL        := Mi_LCL_Scrollbox1;

//  Mi_LCL_Scrollbox1.Mi_lcl_ui_Form := Mi_lcl_ui_Form1;


  Mi_lcl_ui_Form1.Active:=true;
  if Dm_InputBox.DmxScroller_Form1.Active
  then begin
         if not Assigned(Dm_InputBox.DmxScroller_Form1.DataSource)
         Then begin
                Dm_InputBox.DmxScroller_Form1.Create_BufDataset;
              end;

         DBGrid1.DataSource := Dm_InputBox.DmxScroller_Form1.DataSource;
         DBNavigator1.DataSource := DBGrid1.DataSource;
         Dm_InputBox.Refresh;
       end;

  //Transforma o console corrent como filho de aWinControl.
  //windows.SetParent(handle, Form_Basico_Modelo.PageControl1.ActivePage.handle );

  Show;
end;

procedure TForm_InputBox.Label_titleResize(Sender: TObject);
begin
 Label_title.Caption := PageControl1.ActivePage.Caption;
end;



procedure TForm_InputBox.TabSheet1Enter(Sender: TObject);
begin
  Label_title.Caption :=Cadastra.Caption;
end;















end.
