unit uMiDataModule;
{:< A unit **@name** implemnta a classe **TMiDataModule** usada como base para acesso
    a tabelas no banco de dados.}
{$mode Delphi}

interface

uses
  Classes, SysUtils, LResources, ActnList,db,fpjson
  ,Mi_SQLQuery
  ,uMiConnectionsDb, mi.rtl.all, mi_rtl_ui_dmxscroller_form;

type

  { TMiDataModule }
  {$M+}//A diretiva M+ permite que esse módulo seja usado por programas que precise
       //de informações de métodos ou seja RTTI.

  {: A class **@name** é usado com módulo de dados para acesso a uma tabela
     através dos componentes TMi_SQLQuery e DmxScroller_Form1 }
  TMiDataModule = class(TDataModule)
    ActionList1: TActionList;
    CmCancel: TAction;
    CmDeleteRecord: TAction;
    CmGoBof: TAction;
    CmGoEof: TAction;
    CmLocate: TAction;
    CmNewRecord: TAction;
    CmNextRecord: TAction;
    CmPrevRecord: TAction;
    CmRefresh: TAction;
    CmUpdateRecord: TAction;
    DmxScroller_Form1: TDmxScroller_Form;
    Mi_SQLQuery1: TMi_SQLQuery;

    {: O método **@name** da ação CmNewRecord executa o método DmxScroller_Form1.DoOnNewRecord;}
    procedure CmNewRecordExecute(Sender: TObject);

    {: O método **@name** da ação CmUpdateRecord executa o método DmxScroller_Form1.UpdateRec;}
    procedure CmUpdateRecordExecute(Sender: TObject);

    {: O método **@name** da ação CmDeleteRecord executa o método DmxScroller_Form1.DeleteRec;}
    procedure CmDeleteRecordExecute(Sender: TObject);

    {: O método **@name** da ação CmGoBof executa o método DmxScroller_Form1.FirstRec;}
    procedure CmGoBofExecute(Sender: TObject);

    {: O método **@name** da ação CmGoEof executa o método DmxScroller_Form1.LastRec;}
    procedure CmGoEofExecute(Sender: TObject);

    {: O método **@name** da ação CmNextRecord executa o método DmxScroller_Form1.NextRec;}
    procedure CmNextRecordExecute(Sender: TObject);

    {: O método **@name** da ação CmPrevRecord executa o método DmxScroller_Form1.PrevRec;}
    procedure CmPrevRecordExecute(Sender: TObject);

    {: O método **@name** da ação CmCancel executa o método DmxScroller_Form1.Cancel;}
    procedure CmCancelExecute(Sender: TObject);

    {: O método **@name** da ação CmRefresh executa o método DmxScroller_Form1.Refresh;}
    procedure CmRefreshExecute(Sender: TObject);

    {: O método **@name** da ação CmLocate executa o método DmxScroller_Form1.Locate;

       - **Nota**:
         - Locate criar um formulário de pesquisa baseado no que está selecionado na edição.
    }
    procedure CmLocateExecute(Sender: TObject);

    {: O método **name** cria o módulo de dados dos componentes sqldb (SQLConnector1
       e SQLTransaction1 para que possa ser usado pelo componente Mi_SQLQuery1 e
       DmxScroller_Form1
    }
    procedure DataModuleCreate(Sender: TObject);

    {: O método **name** faz com qua a propriedade seja active := false; antes de
       de destruir o modulo de dados.
    }
    procedure DataModuleDestroy(Sender: TObject);

    //*** Daqui para baixo foram criado manualmente e não foram criado pela IDE.***

    {$Region Propriedade active}
      {: O atributo **name** contéem uma instância do módulo de dados TMiConnectionsDb
         criada no método DataModuleCreate.
      }
      protected var MiConnectionsDb : TMiConnectionsDb;

      private Function GetActive : Boolean;
      private procedure SetActive(a_active : Boolean);

      {: A propriedade **@name** é usado para ativar e desativa o datamodule }
      public property active : Boolean  read GetActive write SetActive;

    {$EndRegion Propriedade state}

    {: O método **@name** executa uma caixa de diálogo de pesquisa com os dados
       do campo corrente.
    }
    public function Locate(): TModalResult;overload;

    {: O método **@name** localiza um registro baseado nos campos passados por
       aKeyFields e valores dos campos aKeyValues.

       - **NOTAS**
         - [wiki.freepascal.org/locate](https://wiki.freepascal.org/locate#:~:text=locate%20looks%20for%20a%20record,semicolon%2Dseparated%20list%20of%20fields.)
    }
    public Function Locate(const aKeyFields: string; const aKeyValues: Variant; Options: TLocateOptions):boolean;overload;

    {$Region Propriedade state}
      private function Get_State : TDataSetState ;
      {: A propriedade **@name** é usado para saber o estado da tabela}
      public property State : TDataSetState  read Get_State;
    {$EndRegion Propriedade state}

    {: O método **@name** executa o método datasource.dataset.append  e inicia-o
       com valores default definidos no template caso o prâmetros aIn_JSONObject
       seja diferente de nil, seta o registro com os dados enviados em aIn_JSONObject
       onde o mesmo só é gravado caso o método UpdateRecord seja executado sem
       parâmetros;

       - **RESULT**
         - Json : 'result',true ou false
           - true  : Modo Appending habilitado
           - false : Modo Appending desabilitado
    }
    public function NewRecord(const aIn_JSONObject: TJSONObject):TJSONObject;overload;

    {: O método **@name** executa o método datasource.dataset.append  e inicia-o
       com valores default definidos no template.
       - **RESULT**
         - Json : 'appening',true ou false
           - true  : Modo Appending habilitado
           - false : Modo Appending desabilitado em caso de execão
    }
    public function NewRecord():TJSONObject;overload;

    {: O método **name** grava os campos passados por aIn_JSONObject no registro
       selecionado em chamada anterior ao método .doOnNewReord() ou .locate().

       - **RESULT = appending**
         - Json : result,boolean
           - true  : sucesso ao gravar o registro
           - false : fracasso ao gravar o registro
    }
    public function UpdateRecord(const aIn_JSONObject: TJSONObject):TJSONObject;

    {: O método **@name** delete o registro selecionado por .locate() ou pelos
       métodos FirstRecord(), NextRecord(), PrevRecord() ou LastRecord().
       - **RESULT**
         - Json : 'result',true ou false
           - true  : Sucesso ao excluir o registro
           - false : False ao excluir o registro
    }
    public function DeleteRecord():TJSONObject;

    {: O método **@name** retorna o estado do dataset que pode ser:

       - Estados:
         - DsActive      : true ou false;
         - dsAppending   : true ou false; //Se dsInsert for diferente de appending tem erro.
         - dsInsert      : true ou false;
         - dsRecordAltered : true ou false; // Indica que foi alterado
         - dsBrowse      : true ou false;
         - dsEdit        : true ou false;
    }
    public function GetState : TJSONObject;

    public constructor Create(AOwner: TComponent); override;
  end;
  {$M-}

//procedure Register;

implementation

{$R *.lfm}
{ Procedure DoTestObject;
    Var
      J : TJSONObject;
      I : Char;
      k : Integer;
  begin
    Writeln('Objeto JSON com elementos: a=0,b=1,c=2,d=3');
    J:=TJSONObject.Create(['a',0,'b',1,'c',2,'d',3]);
    Write('Obtenha nomes de elementos com a propriedade de array Names[]: ');
    For K:=0 to J.Count-1 do
    begin
      Write(J.Names[k]);
      If K<J.Count-1 then
        Write(', ');
    end;
    Writeln;
  end;
}


//procedure Register;
//begin
//  {$I midatamodule_icon.lrs}
//  RegisterComponents('Mi.Rtl',[TMiDataModule]);
//end;

{ TMiDataModule }

function TMiDataModule.GetActive: Boolean;
begin
  Result := Mi_SQLQuery1.Active and DmxScroller_Form1.Active;
end;

procedure TMiDataModule.SetActive(a_active: Boolean);
begin
  if a_active
  Then begin
         if not MiConnectionsDb.Connection
         then MiConnectionsDb.Connection := true;

         if MiConnectionsDb.Connection
         Then begin
                Mi_SQLQuery1.SetConnection(MiConnectionsDb.SQLConnector1,DmxScroller_Form1);

                DmxScroller_Form1.DoOnNewRecord_FillChar:=true;
              end
         else raise DmxScroller_Form1.TException.Create(self,{$I %CURRENTROUTINE%},'Banco de dados não conectado!');
       end
  else begin
         if MiConnectionsDb.Connection
         Then Mi_SQLQuery1.SetConnection(nil,DmxScroller_Form1);
       end;
end;

procedure TMiDataModule.CmNewRecordExecute(Sender: TObject);
begin
  DmxScroller_Form1.DoOnNewRecord;
end;

procedure TMiDataModule.CmUpdateRecordExecute(Sender: TObject);
begin
  DmxScroller_Form1.UpdateRec;
end;

procedure TMiDataModule.CmDeleteRecordExecute(Sender: TObject);
begin
  with DmxScroller_Form1 do
   if MessageBox('Confirma a exclusão do registro?',TMi_MsgBox.mtConfirmation,TMi_MsgBox.mbYesNo,TMi_MsgBox.mbyes) = TMi_MsgBox.mrYes
   Then If not DmxScroller_Form1.DeleteRec
        Then ShowMessage('Erro ao excluir o registro!');
end;

procedure TMiDataModule.CmGoBofExecute(Sender: TObject);
begin
  DmxScroller_Form1.FirstRec;
end;

procedure TMiDataModule.CmGoEofExecute(Sender: TObject);
begin
  DmxScroller_Form1.LastRec;
end;

procedure TMiDataModule.CmNextRecordExecute(Sender: TObject);
begin
  DmxScroller_Form1.NextRec;
end;

procedure TMiDataModule.CmPrevRecordExecute(Sender: TObject);
begin
  DmxScroller_Form1.PrevRec;
end;

procedure TMiDataModule.CmCancelExecute(Sender: TObject);
begin
   DmxScroller_Form1.Cancel;
end;

procedure TMiDataModule.CmRefreshExecute(Sender: TObject);
begin
  DmxScroller_Form1.Refresh;
end;

function TMiDataModule.Locate: TModalResult;
begin
  result := DmxScroller_Form1.Locate();
end;

procedure TMiDataModule.CmLocateExecute(Sender: TObject);
begin
  if Locate() = MrNo
  Then TMi_rtl.ShowMessage('Registro não localizado!');
end;

function TMiDataModule.Locate(const aKeyFields: string;
  const aKeyValues: Variant; Options: TLocateOptions): boolean;
begin
  result := DmxScroller_Form1.Locate(aKeyFields,aKeyValues,Options);
end;

function TMiDataModule.Get_State: TDataSetState;
begin
  result := Mi_SQLQuery1.DataSource.DataSet.State;
end;

function TMiDataModule.NewRecord(const aIn_JSONObject: TJSONObject): TJSONObject;

    //Chamada javascript deste método:
    //
    //  async function callNewRecord(aIn_JSONObject) {
    //    const url = 'http://yourserver.com/api/newrecord';
    //
    //    const requestOptions = {
    //        method: 'POST', // Assumindo que o método NewRecord usa o método POST
    //        headers: {
    //            'Content-Type': 'application/json'
    //        },
    //        body: JSON.stringify(aIn_JSONObject)
    //    };
    //
    //    try {
    //        const response = await fetch(url, requestOptions);
    //
    //        if (!response.ok) {
    //            throw new Error('Network response was not ok ' + response.statusText);
    //        }
    //
    //        const result = await response.json();
    //        console.log('Result:', result);
    //
    //        // Handle the result here
    //        if (result.appening) {
    //            if (result.appening === true) {
    //                console.log('Modo Appending habilitado');
    //            } else {
    //                console.log('Modo Appending desabilitado');
    //            }
    //        }
    //
    //        return result;
    //    } catch (error) {
    //        console.error('There was a problem with the fetch operation:', error);
    //    }
    //  }
    //
    //// Exemplo de uso
    //const exampleJSONObject = {
    //    // Adicione as propriedades do seu objeto JSON aqui
    //    key1: 'value1',
    //    key2: 'value2'
    //};
    //
    //callNewRecord(exampleJSONObject);

begin
  with DmxScroller_Form1 do
  begin
    DoOnNewRecord;
    if Assigned(aIn_JSONObject)
    Then JSONObject := aIn_JSONObject;
    result := TJSONObject.Create(['result',DmxScroller_Form1.Appending]); ;
  end;
end;

function TMiDataModule.NewRecord(): TJSONObject;

  //Chamada javascript deste método:
  //
  //async function callNewRecord() {
  //  const url = 'http://yourserver.com/api/newrecord';
  //
  //  const requestOptions = {
  //      method: 'POST', // Assumindo que o método NewRecord usa o método POST
  //      headers: {
  //          'Content-Type': 'application/json'
  //      }
  //  };
  //
  //  try {
  //      const response = await fetch(url, requestOptions);
  //
  //      if (!response.ok) {
  //          throw new Error('Network response was not ok ' + response.statusText);
  //      }
  //
  //      const result = await response.json();
  //      console.log('Result:', result);
  //
  //      // Handle the result here
  //      if (result.appening) {
  //          if (result.appening === true) {
  //              console.log('Modo Appending habilitado');
  //          } else {
  //              console.log('Modo Appending desabilitado');
  //          }
  //      }
  //
  //      return result;
  //  } catch (error) {
  //      console.error('There was a problem with the fetch operation:', error);
  //  }
  //}
  //
  //Chamada do método
  //  callNewRecord();

begin
  with DmxScroller_Form1 do
  begin
    DoOnNewRecord;
    result := TJSONObject.Create(['appending',DmxScroller_Form1.Appending]);
  end;
end;

function TMiDataModule.UpdateRecord(const aIn_JSONObject: TJSONObject): TJSONObject;

    //Chamada javascript deste método:
    //
    //async function updateRecord(aIn_JSONObject) {
    //    const url = 'http://yourserver.com/api/updaterecord';
    //
    //    const requestOptions = {
    //        method: 'POST',
    //        headers: {
    //            'Content-Type': 'application/json'
    //        },
    //        body: JSON.stringify(aIn_JSONObject)
    //    };
    //
    //    try {
    //        const response = await fetch(url, requestOptions);
    //
    //        if (!response.ok) {
    //            throw new Error('Network response was not ok ' + response.statusText);
    //        }
    //
    //        const result = await response.json();
    //        console.log('Result:', result);
    //
    //        // Handle the result here
    //        if (result.result) {
    //            console.log('Registro atualizado com sucesso.');
    //        } else {
    //            console.log('Falha ao atualizar o registro.');
    //        }
    //
    //        return result;
    //    } catch (error) {
    //        console.error('There was a problem with the fetch operation:', error);
    //    }
    //}
    //
    //// Exemplo de uso
    //const exampleJSONObject = {
    //    // Adicione as propriedades do seu objeto JSON aqui
    //    key1: 'value1',
    //    key2: 'value2',
    //    appending: true // ou false, dependendo do estado
    //};
    //
    //updateRecord(exampleJSONObject);

begin
  If Assigned(aIn_JSONObject)
  then begin
         DmxScroller_Form1.JSONObject:=aIn_JSONObject;
         if DmxScroller_Form1.UpdateRec
         then result := TJSONObject.Create(['result',true])
         else result := TJSONObject.Create(['result',false]);
       end
  else result := TJSONObject.Create(['result',false]);
end;

function TMiDataModule.DeleteRecord(): TJSONObject;
begin
  with DmxScroller_Form1 do
  begin
    if DeleteRec
    then result := TJSONObject.Create(['result',true])
    else result := TJSONObject.Create(['result',false]);
  end;
end;

function TMiDataModule.GetState: TJSONObject;
begin
  if not Active
  then result := TJSONObject.Create(['dsInactive'])
  else begin
         Result := TJSONObject.Create([]);
         with DmxScroller_Form1 do
         begin
           Result.Add('dsAppending',Appending);
           Result.Add('dsRecordAltered',RecordAltered);

           if GetState(mb_st_Insert)
           Then Result.Add('dsInsert',true)
           else Result.Add('dsInsert',false);

           if GetState(mb_st_edit)
           Then Result.Add('dsEdit',true)
           else Result.Add('dsEdit',false);

           if GetState(Mb_St_Browse)
           Then Result.Add('dsBrowse',true)
           else Result.Add('dsBrowse',false);
         end;
       end;
end;

constructor TMiDataModule.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

procedure TMiDataModule.DataModuleCreate(Sender: TObject);
begin
  RemoveDataModule(Self);
  MiConnectionsDb := TMiConnectionsDb.Create(self);
  if not MiConnectionsDb.Connection
  then MiConnectionsDb.Connection := true;
  if MiConnectionsDb.Connection
  then begin
         active := false;
         if Not Assigned(DmxScroller_Form1.Mi_ActionList)
         Then DmxScroller_Form1.Mi_ActionList := ActionList1;
       end
  else raise DmxScroller_Form1.TException.Create(self,{$I %CURRENTROUTINE%},'Banco de dados não conectado!');
end;

procedure TMiDataModule.DataModuleDestroy(Sender: TObject);
begin
  active := false;
end;

end.
