unit uCustomForm1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, DBCtrls, DBGrids,
  ExtCtrls, ActnList, ComCtrls, umi_lcl_scrollbox,
  uCustomDataMudule, uForm_Default,
  umi_lcl_ui_ds_form ;

type

  { TCustomForm1 }
  TCustomForm1 = class(TForm_Default)
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    Mi_LCL_Scrollbox1: TMi_LCL_Scrollbox;
    Panel1: TPanel;

    public Mi_lcl_ui_ds_Form1: TMi_lcl_ui_ds_Form;
    public dm_table : TCustomDataMudule;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    {: O método **@name** assinala o atributo **dm_table** e as propriedades
       de Mi_lcl_ui_ds_Form1 e ativa-o para edição.

       - **PARÂMETROS*
         - adm_table
           - Módulo de dados com os dados para criação do formulário.
         - **aOkJson**
           - True
             - Grava os dados no arquivo com o nome do modulo de dados e com a
               extensao .json.
           - False
             - Procura o nome TableName no banco e se existe conecta, caso contrário
               gera exceção.

       - **ATENÇÃO**
         - As propriedade **dm_table.DmxScroller_Form1.Mi_ActionList** e
           **Mi_lcl_ui_ds_Form1.DmxScroller_Form** devem serem iniciadas com as
           informações do parâmetro **aDm_Table**, por isso as mesmas não devem
           ser modificadas em tempo de designer neste formulários (TCustomForm1).
     }
    public Procedure SetDataModule(adm_table : TCustomDataMudule;aOkJson:Boolean);
  end;


implementation

{$R *.lfm}

{ TCustomForm1 }

constructor TCustomForm1.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Mi_lcl_ui_ds_Form1 := TMi_lcl_ui_ds_Form.Create(nil);
  Mi_lcl_ui_ds_Form1.ParentLCL := Mi_LCL_Scrollbox1;
end;

destructor TCustomForm1.Destroy;
begin
  Freeandnil(Mi_lcl_ui_ds_Form1);
  inherited Destroy;

end;

//procedure TCustomForm1.SetDataModule(adm_table: TCustomDataMudule;aOkJson: Boolean);
//  var
//    s : string;
//    //Precisei usar essa variável temp abaixo porque ao setar a propriedade
//    //Mi_lcl_ui_ds_Form1.active := true, o atributo Mi_lcl_ui_ds_Form1 fica nil
//    //caso Mi_lcl_ui_ds_Form1 seja inserido no formulário em tempo de designer.
//    //Penso que é bug do compilador.
//    temp : TMi_lcl_ui_ds_Form;
//begin
//  dm_table := adm_table;
//  if not aOkJson
//  Then dm_table.Active:=true;
//
//  Mi_lcl_ui_ds_Form1.DmxScroller_Form := dm_table.DmxScroller_Form1;
//  Mi_lcl_ui_ds_Form1.Mi_ActionList    := dm_table.ActionList1;
//
//  temp := Mi_lcl_ui_ds_Form1;
//  temp.Active:=true;
//  Mi_lcl_ui_ds_Form1 := temp;
//  if Mi_lcl_ui_ds_Form1.Active
//  then begin
//         DBGrid1.DataSource := dm_table.DmxScroller_Form1.DataSource;
//         DBNavigator1.DataSource := DBGrid1.DataSource;
//         s :=  Mi_lcl_ui_ds_Form1.Alias;
//         Panel1.Caption:= Mi_lcl_ui_ds_Form1.Alias;
//         self.Caption := Panel1.Caption;
//       end;
//end;

procedure TCustomForm1.SetDataModule(adm_table: TCustomDataMudule;aOkJson: Boolean);
  var
    s : string;
begin
  dm_table := adm_table;
  if not aOkJson
  Then dm_table.Active:=true;
  Mi_lcl_ui_ds_Form1.DmxScroller_Form := dm_table.DmxScroller_Form1;
  Mi_lcl_ui_ds_Form1.Mi_ActionList    := dm_table.ActionList1;
  Mi_lcl_ui_ds_Form1.Active:=true;
  if Mi_lcl_ui_ds_Form1.Active
  then begin
         DBGrid1.DataSource := dm_table.DmxScroller_Form1.DataSource;
         DBNavigator1.DataSource := DBGrid1.DataSource;
         s :=  Mi_lcl_ui_ds_Form1.Alias;
         Panel1.Caption:= Mi_lcl_ui_ds_Form1.Alias;
         self.Caption := Panel1.Caption;
       end;
end;

end.

