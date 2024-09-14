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
    Button_Pesquisar: TButton;
    Cadastra: TTabSheet;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    Edit_Pesquisar: TEdit;
    Label1: TLabel;
    Mi_LCL_Scrollbox1: TMi_LCL_Scrollbox;
    Mi_lcl_ui_ds_Form1: TMi_lcl_ui_ds_Form;
    OpenDialog: TOpenDialog;
    Panel2: TPanel;
    SaveDialog: TSaveDialog;
    ImageList1: TImageList;
    Panel1: TPanel;
    PageControl1: TPageControl;
    Lista: TTabSheet;
    procedure Button_PesquisarClick(Sender: TObject);
    procedure cmCloseExecute(Sender: TObject);

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
  end;

var
  form_table: Tform_table;

implementation
{$R *.lfm}


procedure Tform_table.SetDataModule(adm_table: Tdm_table);
  var
    s : string;
begin
  dm_table := adm_table;
  dm_table.Active:=true;

  if not Assigned(Mi_lcl_ui_ds_Form1.DmxScroller_Form)
  Then Mi_lcl_ui_ds_Form1.DmxScroller_Form := dm_table.DmxScroller_Form1;

  if not Assigned(Mi_lcl_ui_ds_Form1.ParentLCL)
  Then Mi_lcl_ui_ds_Form1.ParentLCL := Mi_LCL_Scrollbox1;

  if not Assigned(Mi_lcl_ui_ds_Form1.Mi_ActionList)
  then Mi_lcl_ui_ds_Form1.Mi_ActionList := dm_table.ActionList1;

  if dm_table.Mi_SQLQuery1.Active
  Then begin
         Mi_lcl_ui_ds_Form1.Active:=true;
         if Mi_lcl_ui_ds_Form1.Active
         then begin
                DBGrid1.DataSource := dm_table.DmxScroller_Form1.DataSource;
                DBNavigator1.DataSource := DBGrid1.DataSource;
                s :=  Mi_lcl_ui_ds_Form1.Alias;
                Panel1.Caption:= Mi_lcl_ui_ds_Form1.Alias;
                self.Caption := Panel1.Caption;
//                Show;
              end;
       end;
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



procedure Tform_table.TabSheet1Enter(Sender: TObject);
begin
 // Label_title.Caption :=Cadastra.Caption;
end;

end.
