unit udm_table;

{$mode Delphi}

interface

uses
  Classes, SysUtils, ActnList, SQLDB,  DB
  ,mi.rtl.all
  ,mi_rtl_ui_Dmxscroller  
  ,mi_rtl_ui_dmxscroller_form, Mi_SQLQuery, umi_lcl_ui_ds_form
  ,udm_connections
  , BufDataset;

type


  { Tdm_table }

  Tdm_table = class(TDataModule)
    ActionList1: TActionList;
    CmCancel: TAction;

    CmRefresh: TAction;
    CmGoEof: TAction;
    CmPrevRecord: TAction;
    CmNextRecord: TAction;
    CmGoBof: TAction;
    CmNewRecord: TAction;
    CmLocate: TAction;
    CmUpdateRecord: TAction;
    CmDeleteRecord: TAction;
    DmxScroller_Form1: TDmxScroller_Form;
    Mi_SQLQuery1: TMi_SQLQuery;


    procedure CmCancelExecute(Sender: TObject);
    procedure CmLocateExecute(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure CmDeleteRecordExecute(Sender: TObject);
    procedure CmGoBofExecute(Sender: TObject);
    procedure CmGoEofExecute(Sender: TObject);
    procedure CmNextRecordExecute(Sender: TObject);
    procedure CmPrevRecordExecute(Sender: TObject);
    procedure CmRefreshExecute(Sender: TObject);
    procedure CmUpdateRecordExecute(Sender: TObject);
    procedure CmNewRecordExecute(Sender: TObject);



//    public constructor Create(AOwner: TComponent); override;
    {$Region Propriedade active}

      private Function GetActive : Boolean;
      private procedure SetActive(a_active : Boolean);

      {: A propriedade **@name** é usado para ativar e desativa o datamodule }
      public property active : Boolean  read GetActive write SetActive;

    {$EndRegion Propriedade state}

    public procedure Refresh;

    public Function Locate(const KeyFields: string; const KeyValues: Variant; Options: TLocateOptions):boolean;overload;
    public function Locate(): Boolean;overload;

    {$Region Propriedade state}
      private function GetState : TDataSetState ;
      {: A propriedade **@name** é usado para controlar o estado da tabela}
      public property State : TDataSetState  read GetState;

    {$EndRegion Propriedade state}
    //protected function PutBuffers:Boolean;
    //public function DoAddRec: Boolean;virtual;


    {: O método **@anme** retorna o maximo do campo ID da tabela dm_table

       - EXMPLO DE USO:

          ´´´pascal
              procedure TForm_Operadores.Button1Click(Sender: TObject);
                Var
                  Id : string;
              begin
                id := Operadores.ReturnMaxPKey('dm_table','id',1);
                Tmi_rtl.ShowMessage('Proxímo número = '+id);
              end;

           ```
       - REFERÊNCIA:

         - ATENÇÂO:
           - [Geração automática de instruções SQL de atualização](https://www.freepascal.org/docs-html/fcl/sqldb/updatesqls.html)
           - [aprenda-programar-funcao-para-retornar](https://infocotidiano.com.br/2016/09/aprenda-programar-funcao-para-retornar.html)
           - [postgresql-max-function](https://www.postgresqltutorial.com/postgresql-aggregate-functions/postgresql-max-function/)

    }
    public  function ReturnMaxPKey(aTabela, aID: String; vAtribui: variant  ): Variant;

    private dm_connections : Tdm_connections;


  end;


implementation

{$R *.lfm}

{ Tdm_table }
procedure Tdm_table.DataModuleCreate(Sender: TObject);
begin
  dm_connections := Tdm_connections.Create(self);
  if not dm_connections.Connection
  then dm_connections.Connection := true;
  RemoveDataModule(Self);
  active := false;
  if Not Assigned(DmxScroller_Form1.Mi_ActionList)
  Then DmxScroller_Form1.Mi_ActionList := ActionList1;
end;

procedure Tdm_table.DataModuleDestroy(Sender: TObject);
begin
  active := false;
end;

function Tdm_table.Locate(const KeyFields: string; const KeyValues: Variant;Options: TLocateOptions): boolean;
begin
  result := DmxScroller_Form1.Locate(KeyFields,KeyValues,Options);
end;

function Tdm_table.GetActive: Boolean;
begin
  Result := DmxScroller_Form1.Active;
end;

procedure Tdm_table.SetActive(a_active: Boolean);
begin
  if a_active
  Then begin
         if not dm_connections.Connection
         then dm_connections.Connection := true;

         if dm_connections.Connection
         Then with dm_connections do
              begin
                Mi_SQLQuery1.SetConnection(SQLConnector1,DmxScroller_Form1);

                DmxScroller_Form1.DoOnNewRecord_FillChar:=true;
                //CmRefreshExecute(SELF);
              end;
       end
  else begin
         if dm_connections.Connection
         Then with dm_connections do
               Mi_SQLQuery1.SetConnection(nil,DmxScroller_Form1);

         if dm_connections.Connection
         then dm_connections.Connection := false;
       end;
end;

procedure Tdm_table.CmNewRecordExecute(Sender: TObject);
begin
  DmxScroller_Form1.DoOnNewRecord;
end;

function Tdm_table.Locate(): Boolean;
begin
  result := DmxScroller_Form1.Locate();
end;

procedure Tdm_table.CmLocateExecute(Sender: TObject);
begin
  if Not Locate()
  Then TMi_rtl.ShowMessage('Registro não localizado');
end;

procedure Tdm_table.CmCancelExecute(Sender: TObject);
begin
  DmxScroller_Form1.Cancel;
end;

procedure Tdm_table.Refresh;
begin
  if DmxScroller_Form1.Active
  then CmRefreshExecute(SELF);
end;

procedure Tdm_table.CmUpdateRecordExecute(Sender: TObject);
begin
  DmxScroller_Form1.UpdateRec;
end;

procedure Tdm_table.CmDeleteRecordExecute(Sender: TObject);
begin
  with DmxScroller_Form1 do
   if MessageBox('Confirma a exclusão do registro?',TMi_MsgBox.mtConfirmation,TMi_MsgBox.mbYesNo,TMi_MsgBox.mbyes) = TMi_MsgBox.mrYes
   Then If not DmxScroller_Form1.DeleteRec
        Then ShowMessage('Erro ao excluir o registro!');
end;

procedure Tdm_table.CmGoBofExecute(Sender: TObject);
begin
  DmxScroller_Form1.FirstRec;
end;

procedure Tdm_table.CmGoEofExecute(Sender: TObject);
begin
  DmxScroller_Form1.LastRec;
end;

procedure Tdm_table.CmNextRecordExecute(Sender: TObject);
begin
  DmxScroller_Form1.NextRec;
end;

procedure Tdm_table.CmPrevRecordExecute(Sender: TObject);
begin
  DmxScroller_Form1.PrevRec;
end;

procedure Tdm_table.CmRefreshExecute(Sender: TObject);
begin
  DmxScroller_Form1.Refresh;
end;

function Tdm_table.GetState: TDataSetState;
begin
  result := Mi_SQLQuery1.DataSource.DataSet.State;
end;

function Tdm_table.ReturnMaxPKey(aTabela, aID: String; vAtribui: variant  ): Variant;
  //Como saber o próximo valor do auto incremento?
  var
    nQTD : Variant;   // Variável para próximo incremento
    wSQL,s    : String;
begin
  try
    wSQL := Mi_SQLQuery1.sql.Text;

    nQTD:=vAtribui; // atribuição a variavel nQTD o valor do próximo incremento obtido pelo parametro da funcao
  //    Mi_SQLQuery1.Close; // fecha Query
    Mi_SQLQuery1.Active:=false;
    Mi_SQLQuery1.sql.Clear; // limpa Query
    //Mi_SQLQuery1.SQL.Add('Select Max('+aID+') as aID_Inc from '+aTabela);

    // escreve nova query com parâmetros recebido da função
    Mi_SQLQuery1.SQL.Clear;
    Mi_SQLQuery1.SQL.Add('SELECT MAX('+aID+') as vr_max_id FROM '+aTabela);
    s := Mi_SQLQuery1.SQL.text;
  //    Mi_SQLQuery1.Open; // abre a nova query
    Mi_SQLQuery1.Active:=true;

    case Mi_SQLQuery1.Fields[0].DataType of
      ftSmallint, ftWord, ftInteger: // se o campo AI for SmallInt, Word ou Integer
        Result := Mi_SQLQuery1.Fields[0].AsInteger + nQtd;

      ftFloat, ftCurrency: // Se o campo for Float ou Currency
        Result := Mi_SQLQuery1.Fields[0].AsFloat + nQtd;
    end;

  finally
    Mi_SQLQuery1.Close; // fecha query
    Mi_SQLQuery1.sql.Clear; // limpa Query
    Mi_SQLQuery1.sql.Text := WSQL;
    Mi_SQLQuery1.Open; // abre a nova query
  end;

end;


end.

