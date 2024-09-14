unit dm_table_u;

{$mode Delphi}

interface

uses
  Classes, SysUtils, ActnList, unit_dm_connections, SQLDB,  DB
  ,mi.rtl.all, mi_rtl_ui_dmxscroller_form
  ;

type

  { Tdm_table }

  Tdm_table = class(TDataModule)
        Action_eof: TAction;
        Action_prev: TAction;
        Action_next: TAction;
        Action_bof: TAction;

        Action_excluir: TAction;
        Action_gravar: TAction;
        Action_pesquisar: TAction;
        Action_novo: TAction;
        ActionList1: TActionList;
    DmxScroller_Form1: TDmxScroller_Form;
    SQLQuery1: TSQLQuery;
    DataSource1: TDataSource;

    procedure Action_excluirExecute(Sender: TObject);
    procedure Action_gravarExecute(Sender: TObject);
    procedure Action_novoExecute(Sender: TObject);
    procedure Action_pesquisarExecute(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);

    {$Region Propriedade state}
      private function GetState : TDataSetState ;
      {: A propriedade **@name** é usado para controlar o estado da tabela}
      public property State : TDataSetState  read GetState;

    {$EndRegion Propriedade state}


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

  end;


implementation

{$R *.lfm}

{ Tdm_table }

procedure Tdm_table.DataModuleCreate(Sender: TObject);
begin
  if not DM_Connections.Connection
  then DM_Connections.Connection := true;

  if DM_Connections.Connection
  then begin
          SQLQuery1.DataBase    := DM_Connections.SQLConnector1;
          SQLQuery1.Transaction := DM_Connections.SQLTransaction1;
          DataSource1.DataSet   := SQLQuery1;
          DataSource1.AutoEdit  := true;
          SQLQuery1.SQL.Clear;
          SQLQuery1.SQL.Add('select * from '+DmxScroller_Form1.TableName);
          SQLQuery1.Active:=true;
       end
  else raise Tmi_rtl.TException.Create(self,'DataModuleCreate','Banco de dados não conectado!');

end;

procedure Tdm_table.Action_novoExecute(Sender: TObject);
begin
  DmxScroller_Form1.DoOnNewRecord;
end;

procedure Tdm_table.Action_gravarExecute(Sender: TObject);
begin

end;

procedure Tdm_table.Action_excluirExecute(Sender: TObject);
begin

end;

procedure Tdm_table.Action_pesquisarExecute(Sender: TObject);
begin

end;

function Tdm_table.GetState: TDataSetState;
begin
  result := SQLQuery1.State;
end;


function Tdm_table.ReturnMaxPKey(aTabela, aID: String; vAtribui: variant  ): Variant;
  //Como saber o próximo valor do auto incremento?
  var
    nQTD : Variant;   // Variável para próximo incremento
    wSQL,s    : String;
begin
  try
    wSQL := SQLQuery1.sql.Text;

    nQTD:=vAtribui; // atribuição a variavel nQTD o valor do próximo incremento obtido pelo parametro da funcao
  //    SQLQuery1.Close; // fecha Query
    SQLQuery1.Active:=false;
    SQLQuery1.sql.Clear; // limpa Query
    //SQLQuery1.SQL.Add('Select Max('+aID+') as aID_Inc from '+aTabela);

    // escreve nova query com parâmetros recebido da função
    SQLQuery1.SQL.Clear;
    SQLQuery1.SQL.Add('SELECT MAX('+aID+') as vr_max_id FROM '+aTabela);
    s := SQLQuery1.SQL.text;
  //    SQLQuery1.Open; // abre a nova query
    SQLQuery1.Active:=true;

    case SQLQuery1.Fields[0].DataType of
      ftSmallint, ftWord, ftInteger: // se o campo AI for SmallInt, Word ou Integer
        Result := SQLQuery1.Fields[0].AsInteger + nQtd;

      ftFloat, ftCurrency: // Se o campo for Float ou Currency
        Result := SQLQuery1.Fields[0].AsFloat + nQtd;
    end;

  finally
    SQLQuery1.Close; // fecha query
    SQLQuery1.sql.Clear; // limpa Query
    SQLQuery1.sql.Text := WSQL;
    SQLQuery1.Open; // abre a nova query
  end;

end;

end.

