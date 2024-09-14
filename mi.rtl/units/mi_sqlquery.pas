unit Mi_SQLQuery;

{$mode Delphi}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls
  , Graphics, Dialogs, sqldb,db
  ,mi.rtl.all
  ,mi.rtl.Consts.transaction
  ,mi_rtl_ui_Dmxscroller;

type

  { TMi_SQLQuery }
  TMi_SQLQuery = class;
  {: A Propriedade **@name** tem como finalidade criar um dataSource ao
     criar o componente TMi_SqlQuery}
  TMi_SQLQuery = class(TSQLQuery)
  private

  protected

  public
   constructor Create(AOwner: TComponent); override;
   destructor Destroy; override;
   Procedure SetDataSource_DataSet(aMi_SQLQuery:TMi_SQLQuery);

   {$REGION Property DataSource }
     private _DataSource : TDataSource;
     private Procedure SetDataSource(aDataSource:TDataSource);

     {: A propriedade **@name** anula o dataSouce anterior, porém a propriedade
        datasource.name deve ser assinalado para 'DataSource1', caso contrário,
        haverá referência circular ao iniciar a tabela.
     }
     public property DataSource : TDataSource read _DataSource Write SetDataSource;

   {$ENDREGION Property DataSource }

   public procedure SetConnection(aSQLConnector:TSQLConnector; aUiDmxScroller:TUiDmxScroller);

   protected property options;

   public Function MaxPKey(aTabela, aID: String; vAtribui: variant  ): Variant;

  end;

procedure Register;

implementation

procedure Register;
begin
  {$I mi_sqlquery_icon.lrs}
  RegisterComponents('Mi.Rtl',[TMi_SQLQuery]);
  Tmi_rtl.UnlistPublishedProperty(TMi_SQLQuery,'Options');
  Tmi_rtl.UnlistPublishedProperty(TMi_SQLQuery,'FileName');
  Tmi_rtl.UnlistPublishedProperty(TMi_SQLQuery,'DataSource');
  Tmi_rtl.UnlistPublishedProperty(TMi_SQLQuery,'UniDirecional');
  Tmi_rtl.UnlistPublishedProperty(TMi_SQLQuery,'Tag');
  Tmi_rtl.UnlistPublishedProperty(TMi_SQLQuery,'PacketRecords');
end;

{ TMi_SQLQuery }

constructor TMi_SQLQuery.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  DataSource := TDataSource.Create(self);
  DataSource.name := 'DataSource1';

  //PacketRecords := 1;
  //IndexName := 'DEFAULT_ORDER';
  //MaxIndexesCount := 4;
  //FieldDefs := <>;
  //Database := SQLConnector.SQLConnector1;
  //Transaction := SQLConnector.SQLTransaction1;
  //SQL.text :=  'select * from __dm_xtable__';

  SQL.text :=  '';

  //tipo TSQLQueryOptions = conjunto de (
  //sqoKeepOpenOnCommit ,
  //Mantenha o conjunto de dados aberto após a confirmação da consulta (buscará todos os registros).
  //sqoAutoApplyUpdates ,
  //Chame ApplyUpdates na postagem ou exclusão
  //sqoAutoCommit ,
  //Chame o commit após cada ApplyUpdates ou ExecSQL
  //sqoCancelUpdatesOnRefresh ,
  //Cancele quaisquer atualizações pendentes quando a atualização for chamada
  //sqoRefreshUsingSelect
  //Forçar uma atualização usando a seleção fornecida em vez de usar a cláusula RETURNING
  //
  //);


  UniDirectional:=false;
  SetDataSource_DataSet(self);
end;

destructor TMi_SQLQuery.Destroy;
begin
  if Assigned(_DataSource) and (_DataSource.Owner=self)
  then FreeAndNil(_DataSource);

  inherited Destroy;
end;

procedure TMi_SQLQuery.SetDataSource_DataSet(aMi_SQLQuery: TMi_SQLQuery);
begin
  DataSource.DataSet := aMi_SQLQuery;
  DataSource.Enabled := true;
end;

procedure TMi_SQLQuery.SetDataSource(aDataSource: TDataSource);
begin
  if Assigned(_DataSource) and (_DataSource.Owner=self)
  then FreeAndNil(_DataSource);

  _DataSource := aDataSource;
end;

procedure TMi_SQLQuery.SetConnection(aSQLConnector:TSQLConnector; aUiDmxScroller:TUiDmxScroller);
  var
    s1,s2 : string;
    i : integer;
begin
  if not Assigned(aSQLConnector)
  then begin
         if Active
         then Active:=false;

         if Assigned(DataBase)
         then begin
                if Assigned(aUiDmxScroller)
                then aUiDmxScroller.Active:=false;

                DataBase := nil;
                Transaction := nil;
              end;
       end
  else begin
          if aSQLConnector.Connected and (not Active)
          then begin
                  DataBase    := aSQLConnector;
                  Transaction := aSQLConnector.Transaction;
                  aUiDmxScroller.Mi_Transaction.SQLTransaction := aSQLConnector.Transaction;
                  s2 := '';
                  s1 := sql.Text;
                  //Delete caracteres de controle;
                  for i := 1 to length(s1) do
                    if ord(s1[i]) >= 32
                    then s2 := s2+s1[i];

                  if s2=''
                  then begin
                         if aUiDmxScroller.TableName = ''
                         Then raise Tmi_rtl.TException.Create(self,'SetConnection','A propriedade "DmxScroller_Form1".tableName não informado!');

                         s2 := 'select * from '+aUiDmxScroller.TableName + ' order by id asc';
                         SQL.Add(s2);
                       end;
                  try
                    if Transaction.Active
                    then Transaction.Active := false;

                    open;

                  Except
                    On E : Exception do
                    begin
                       raise TMi_Rtl.TException.Create(self,'SetConnection',E.Message);
                    end;
                  end;

                  if not active
                  Then raise Tmi_rtl.TException.Create(self,'SetConnection','Algo errado a abrir o arquivo!');

                  aUiDmxScroller.DataSource := DataSource;
               end
          else if not aSQLConnector.Connected
               then raise Tmi_rtl.TException.Create(self,'SetConnection','Banco de dados não conectado!');
       end;

end;

function TMi_SQLQuery.MaxPKey(aTabela, aID: String; vAtribui: variant): Variant;
  //Como saber o próximo valor do auto incremento?
  var
    nQTD : Variant;   // Variável para próximo incremento
    wSQL,s    : String;
begin
  try
    wSQL := sql.Text;

    nQTD:=vAtribui; // atribuição a variavel nQTD o valor do próximo incremento obtido pelo parametro da funcao
  //    Close; // fecha Query
    Active:=false;
    sql.Clear; // limpa Query
    // escreve nova query com parâmetros recebido da função
    SQL.Clear;

    //SQL.Add('Select Max('+aID+') as aID_Inc from '+aTabela);
    SQL.Add('SELECT MAX('+aID+') as vr_max_id FROM '+aTabela);

    s := SQL.text;
  //Open; // abre a nova query
    Active:=true;

    case Fields[0].DataType of
      ftSmallint,
      ftWord,
      ftInteger: Result := Fields[0].AsInteger + nQtd; // se o campo AI for SmallInt, Word ou Integer

      ftFloat, ftCurrency: Result := Fields[0].AsFloat + nQtd; // Se o campo for Float ou Currency
    end;

  finally
  //  Close; // fecha query
    Active:=false;

    sql.Clear; // limpa Query
    sql.Text := WSQL;

  //  Open; // abre a nova query
    Active:=true;
  end;
end;


end.

