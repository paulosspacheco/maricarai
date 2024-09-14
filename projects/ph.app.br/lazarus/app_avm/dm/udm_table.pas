unit udm_table;

{$mode Delphi}

interface

uses
  Classes, SysUtils, ActnList, SQLDB,  DB
  ,mi.rtl.all
  ,mi_rtl_ui_Dmxscroller  
  ,mi_rtl_ui_dmxscroller_form, Mi_SQLQuery
  ,udm_connections
  , BufDataset;

type


  { Tdm_table }

  Tdm_table = class(TDataModule)
    DmxScroller_Form1: TDmxScroller_Form;
    Mi_SQLQuery1: TMi_SQLQuery;

    ActionList1: TActionList;
    CmRefresh: TAction;
    CmGoEof: TAction;
    CmPrevRecord: TAction;
    CmNextRecord: TAction;
    CmGoBof: TAction;
    CmNewRecord: TAction;
    CmLocate: TAction;
    CmUpdateRecord: TAction;
    CmDeleteRecord: TAction;

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
    procedure CmLocateExecute(Sender: TObject);


    {$Region Propriedade active}

      private Function GetActive : Boolean;
      private procedure SetActive(a_active : Boolean);

      {: A propriedade **@name** é usado para ativar e desativa o datamodule }
      public property active : Boolean  read GetActive write SetActive;

    {$EndRegion Propriedade active}

    {$Region Método Set_Active}
      {: O atributo **@name** é usado para criar uma consulta temporária usada para
         selecionar uma lista de registros possíveis para um campo lookupComboBox}
      private var _SqlText :String ;


      {: O método **@name** é usado para fazer uma consulta ao banco de dados
         usando o parâmetro a_SqlText.

         - Passo a passo
           - Criar método function Sql_to_template(a_SqlText:String):PSitem;

           - Criar propriedade template para o caso a_SqlText <> ''.
             - Quando a_SqlText <> '', ativar template := sql_to_template(a_SqlText)

         - EXEMPLO:
           -  Set_Active := ('select a.nome,a.id from operadores a order by a.nome asc');
      }
      public procedure Set_Active(a_active : Boolean;a_SqlText:String);virtual;

    {$EndRegion Método Set_Active}

    public procedure Refresh;
    public procedure Locate(campo1:string);

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
  inherited;
  dm_connections := Tdm_connections.Create(self);
  RemoveDataModule(Self);
  _SqlText := '';
  active := false;
  DmxScroller_Form1.Mi_ActionList := ActionList1;
end;

procedure Tdm_table.DataModuleDestroy(Sender: TObject);
begin
  active := false;
end;


procedure Tdm_table.Locate(campo1:string);
  //  query: String;

begin
  //Mi_SQLQuery1.Locate('id',campo1,[loCaseInsensitive]);


  Mi_SQLQuery1.Locate('nome',campo1,[loPartialKey]);

//  // Construir a consulta SQL baseada nos campos de entrada
//  query := 'SELECT * FROM '+DmxScroller_Form1.TableName+' WHERE ID=:'+campo1;
//
//  // Configurar a consulta SQL
//  Mi_SQLQuery1.SQL.Text := query;
//  Mi_SQLQuery1.Params.ParamByName('ID').AsString := campo1;
////  Mi_SQLQuery1.Params.ParamByName('campo2').AsString := EditCampo2.Text;
//
//  // Executar a consulta
//  Mi_SQLQuery1.Open;
//
//  // Para obter o Bookmark, você pode fazer isso quando um registro é selecionado no DBGrid, por exemplo:
//  // DBGrid1.OnCellClick := DBGridCellClick;


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
                if _sqlText <>''
                Then  begin
                       Mi_SQLQuery1.sql.Clear;
                       Mi_SQLQuery1.sql.Add(_sqlText);
                     end;

                Mi_SQLQuery1.SetConnection(SQLConnector1,DmxScroller_Form1);
                DmxScroller_Form1.DoOnNewRecord_FillChar:=true;
                DmxScroller_Form1.Active:=a_active;
                CmRefreshExecute(SELF);
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


procedure Tdm_table.Set_Active(a_active: Boolean; a_SqlText: String);
begin
  _SqlText := a_SqlText;
  active   := a_active;
end;

procedure Tdm_table.CmNewRecordExecute(Sender: TObject);
begin
  DmxScroller_Form1.DoOnNewRecord;
end;

procedure Tdm_table.CmLocateExecute(Sender: TObject);
begin
  Tmi_rtl.ShowMessage('Evento: Tdm_table.PesquisarExecute');
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
  //with DmxScroller_Form1,MI_MsgBox do
  //  if
  DmxScroller_Form1.DeleteRec;
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
//  DmxScroller_Form1.Appending:=false;
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

