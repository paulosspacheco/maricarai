unit __dm_table_u__;

{$mode Delphi}

interface

uses
  Classes, SysUtils, __unit_dm_connections__, SQLDB,  DB
  ,mi.rtl.all, mi_rtl_ui_dmxscroller_form
  ;

type

  { T__dm_table__ }

  T__dm_table__ = class(TDataModule)
    DmxScroller_Form1: TDmxScroller_Form;
    SQLQuery1: TSQLQuery;
    DataSource1: TDataSource;

    procedure DataModuleCreate(Sender: TObject);

    {$Region Propriedade state}
      private function GetState : TDataSetState ;
      {: A propriedade **@name** é usado para controlar o estado da tabela}
      public property State : TDataSetState  read GetState;

    {$EndRegion Propriedade state}
    protected function PutBuffers:Boolean;
    public function DoAddRec: Boolean;virtual;

    {: O método **@anme** retorna o maximo do campo ID da tabela operadores

       - EXMPLO DE USO:

          ´´´pascal
              procedure TForm_Operadores.Button1Click(Sender: TObject);
                Var
                  Id : string;
              begin
                id := Operadores.ReturnMaxPKey('operadores','id',1);
                Tmi_rtl.ShowMessage('Proxímo número = '+id);
              end;

           ```
       - REFERÊNCIA:

         - ATENÇÂO: É muito importante entender esse documento:
           - [Geração automática de instruções SQL de atualização](https://www.freepascal.org/docs-html/fcl/sqldb/updatesqls.html)
         - [aprenda-programar-funcao-para-retornar](https://infocotidiano.com.br/2016/09/aprenda-programar-funcao-para-retornar.html)
         - [postgresql-max-function](https://www.postgresqltutorial.com/postgresql-aggregate-functions/postgresql-max-function/)

    }
    public  function ReturnMaxPKey(aTabela, aID: String; vAtribui: variant  ): Variant;

  end;


implementation

{$R *.lfm}

{ T__dm_table__ }

procedure T__dm_table__.DataModuleCreate(Sender: TObject);
begin
  if not __DM_Connections__.Connection
  then __DM_Connections__.Connection := true;

  if __DM_Connections__.Connection
  then begin
          SQLQuery1.DataBase := __DM_Connections__.SQLConnector1;
          SQLQuery1.SQL.Clear;
          SQLQuery1.SQL.Add('select * from '+DmxScroller_Form1.TableName);
          SQLQuery1.Active:=true;
       end
  else raise Tmi_rtl.TException.Create(self,'DataModuleCreate','Banco de dados não conectado!');

end;

function T__dm_table__.GetState: TDataSetState;
begin
  result := SQLQuery1.State;
end;

function T__dm_table__.PutBuffers: Boolean;
begin
  result := DmxScroller_Form1.PutBuffers;
end;

function T__dm_table__.DoAddRec: Boolean;
begin
  if Not DmxScroller_Form1.Active
  Then raise TMi_Rtl.TException.Create(self,'DoAddRec','Classe DmxScroller_Form1 não está ativa!');

  if (State in [dsInsert]) and DmxScroller_Form1.Appending
  then begin
         try
           if (SQLQuery1 as TSQLQuery).SQLTransaction.Active
           then Begin
                  if PutBuffers
                  then begin
                         (SQLQuery1 as TSQLQuery).Post;
                       end
                  else Raise TMi_rtl.TException.Create(Self,'DoAddRec',SQLQuery1.FileName,'','O Método PutBuffer retornou false!. Não posso gravar.');
                end;
           result := true;

         Except;
           result := false;
         End;
       End
  else Begin
         result := false;
         Raise TMi_rtl.TException.Create(Self,
                                 'DoAddRec',
                                  TMi_rtl.Attempt_to_insert_record_without_is_selected);

       end;

end;

function T__dm_table__.ReturnMaxPKey(aTabela, aID: String; vAtribui: variant  ): Variant;
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

