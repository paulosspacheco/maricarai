unit Mi.rtl.WebModule;
{:< A unit **@name** implementa a classe TMi_rtl_WebModule.

  - **NOTAS**:
    - A classe  TMi_rtl_WebModule implementa a Interfaces  IMi_rtl_WebModule:

      ```pascal
        IMi_rtl_WebModule = Interface ['88DB8A8D-5926-4F55-9740-FC66E19455C4']
          Function Locate(const aKeyFields: string; const aKeyValues: Variant; Options: TLocateOptions):boolean;overload;
        end;

      ```
}
{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, ActnList,httpdefs, fpHTTP, fpWeb, DB,fpJson
  ,mi.rtl.all
  ,uMiConnectionsDb
  ,Mi_SQLQuery
  ,mi_rtl_ui_dmxscroller_form, mi_rtl_ui_Dmxscroller;


type
   {: O tipo **@name** é usado para implementar evento onEnter da classe TUiDmxScroller

      - **PARÂMETROS**
         - aKeyFields
            - Contém a lista de campos que pertence a chave primária
              - **EXEMPLOS**:
                - **Chave simples**:
                  - 'Matricula'.

                - **Chave composta**:
                  - 'Estado,Cidade'.
         - aKeyValues
           - Contém um array de variantes do valor da chave.

             ```pascal

                 procedure LocateMyRecord;
                 var
                   aCityID, aCountryID: integer;
                 begin
                   if Locate('city_id;country_id', VarArrayOf([aCityID, aCountryID]), []) then
                   begin
                     DoSomething;
                   end;
                 end;
             ```
      - **REFERÊNCIAS**
        - [wiki.freepascal.org](https://wiki.freepascal.org/locate#:~:text=locate%20looks%20for%20a%20record,semicolon%2Dseparated%20list%20of%20fields.)

   }
   TOnLocate = function(const aKeyFields: string; const aKeyValues: Variant; aOptions: TLocateOptions):boolean of Object unimplemented;

type
  {: A classe **@name** foi criada para /??}
  TParamOnLocate = class(TPersistent)
//    published property KeyFields: string; KeyValues : Array:
  end;


type
  IMi_rtl_WebModule = Interface ['{88DB8A8D-5926-4F55-9740-FC66E19455C4}']
    {: O método **@name** localiza um registro baseado nos campos passados por
       aKeyFields e valores dos campos aKeyValues.
    }
    Function Locate(const aKeyFields: string; const aKeyValues: Variant; Options: TLocateOptions):boolean;overload;
  end;

  { TMi_rtl_WebModule  }
  {:A classe **@name** é usada para concentrar as regras de negócio e que as
    mesmas possam ser expostas na web.
     - **REFERÊNCIAS**
       - [fcl-web](https://wiki.freepascal.org/fcl-web)

  }
  TMi_rtl_WebModule = class(TFPWebModule,IMi_rtl_WebModule)
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

    {: O método **@name** da ação CmNewRecord executa o método
       DmxScroller_Form1.DoOnNewRecord;
    }
    procedure CmNewRecordExecute(Sender: TObject);

    {: O método **@name** da ação CmLocate executa o método DmxScroller_Form1.Locate;

       - **Nota**:
         - Locate criar um formulário de pesquisa baseado no que está selecionado na edição.
    }
    procedure CmLocateExecute(Sender: TObject);

    {: O método **@name** da ação CmUpdateRecord executa o método
       DmxScroller_Form1.UpdateRec;
    }
    procedure CmUpdateRecordExecute(Sender: TObject);

    {: O método **@name** da ação CmDeleteRecord executa o método
       DmxScroller_Form1.DeleteRec;
    }
    procedure CmDeleteRecordExecute(Sender: TObject);

    {: O método **@name** da ação CmGoBof executa o método
       DmxScroller_Form1.FirstRec;
    }
    procedure CmGoBofExecute(Sender: TObject);

    {: O método **@name** da ação CmNextRecord executa o método
       DmxScroller_Form1.NextRec;
    }
    procedure CmNextRecordExecute(Sender: TObject);

    {: O método **@name** da ação CmPrevRecord executa o método
       DmxScroller_Form1.PrevRec;}
    procedure CmPrevRecordExecute(Sender: TObject);

    {: O método **@name** da ação CmGoEof executa o método
       DmxScroller_Form1.LastRec;
    }
    procedure CmGoEofExecute(Sender: TObject);

    {: O método **@name** da ação CmRefresh executa o método
    DmxScrol    public constructor Create(AOwner: TComponent); override;ler_Form1.Refresh;}
    procedure CmRefreshExecute(Sender: TObject);

    {: O método **@name** da ação CmCancel executa o método
       DmxScroller_Form1.Cancel;
    }
    procedure CmCancelExecute(Sender: TObject);

    {: O método **name** cria o módulo de dados dos componentes sqldb (SQLConnector1
       e SQLTransaction1 para que possa ser usado pelo componente Mi_SQLQuery1 e
       DmxScroller_Form1
    }
    procedure DataModuleCreate(Sender: TObject);

    {: O método **name** faz com qua a propriedade seja active := false; antes de
       de destruir o modulo de dados.
    }
    procedure DataModuleDestroy(Sender: TObject);


    {:O método **@name localiza um registro com as chaves passas pelos parâmetros
      de consulta. Caso o evento **OnLocate** seja assinalado, o método LocateAction
      executa onLocate e transfere a responsabilidade de localizar o registro para
      o módulo filho deste.

      - **NOTAS**
        - Caso a onLocate seja assinalado o mesmo será executado para que o mesmo
          localize o registro.
          - Se **onLocate** retorna **true** então retorna em AResponse.Content
            a propriedade DmxScroller_Form1.JSONObject caso o registro esteja
            selecionado.

        - Caso a onLocate não esteja assinalado então executa o método
          Locate(aKeyFields,aKeyValues,aOptions) e retorna em AResponse.Content
          a propriedade DmxScroller_Form1.JSONObject caso o registro esteja
          selecionado.

        - Caso as consultas retornem **false**, então retorna em aResponse.Content o
          erro '{"error":"Registro não localizado"}';

        - Os parâmetros são passados usando o método parâmetros de consulta de URL.

        - Os parâmetros de consulta de URL são passados da seguinte forma:
          - http://localhost:9080/TMiWebModule/?name1=value1&name2=value2...nameN=ValueN.
            - Obs:
              - Uma URL não pode ter mais que 2000 bytes.
    }
    procedure locateRequest(Sender: TObject; ARequest: TRequest;AResponse: TResponse; var Handled: Boolean);

    //IMPLEMENTAÇÃO DOS EVENTOS QUE PODEM SER ACESSADOS PELO CLIENTE
    {$REGION '--> Property Locate'}

    protected _OnLocate : TOnLocate;

    {: O evento **@name** é disparado pelo locateRequest passando os campos
       aKeyFields e aKeyValues recebidos do cliente.

    }
//      public keysPrimaryKeyComposite : AnsiString;
    published Property onLocate : TOnLocate Read _OnLocate write _onLocate;
    {$ENDREGION '<-- Property Locate'}

    public constructor Create(AOwner: TComponent); override;

    {$Region Propriedade active}
      //*** Daqui para baixo foram criado manualmente e não foram criado pela IDE.***

      {: O atributo **name** contéem uma instância do módulo de dados TMiConnectionsDb
         criada no método DataModuleCreate.
      }
      protected var MiConnectionsDb : TMiConnectionsDb;

      private Function GetActive : Boolean;
      private procedure SetActive(a_active : Boolean);

      {: A propriedade **@name** é usado para ativar e desativa o datamodule }
      public property active : Boolean  read GetActive write SetActive;

    {$EndRegion Propriedade state}

    {$Region Propriedade state}
      private function Get_State : TDataSetState ;
      {: A propriedade **@name** é usado para saber o estado da tabela}
      public property State : TDataSetState  read Get_State;
    {$EndRegion Propriedade state}


    {: O método **@name** executa uma caixa de diálogo de pesquisa com os dados
       do campo corrente.
    }
    public function Locate(): TModalResult;overload;

    {: O método **@name** localiza um registro baseado nos campos passados por
       aKeyFields e valores dos campos aKeyValues.
    }
    public Function Locate(const aKeyFields: string; const aKeyValues: Variant; aOptions: TLocateOptions):boolean;overload;

  end;


  TMi_rtl_WebModule_Interface = Class(TMi_rtl_WebModule)
  private
    _Intf: IMi_rtl_WebModule;
  Protected

  Public
    Property Intf : IMi_rtl_WebModule Read _Intf Write _Intf;
  end;

//var
//  Mi_rtl_WebModule: TMi_rtl_WebModule;

implementation

{$R *.lfm}

//initialization
//  RegisterHTTPModule('TMi_rtl_WebModule', TMi_rtl_WebModule);

{ TMi_rtl_WebModule }

procedure TMi_rtl_WebModule.CmNewRecordExecute(Sender: TObject);
begin
  DmxScroller_Form1.DoOnNewRecord;
end;

function TMi_rtl_WebModule.Locate(): TModalResult;
begin
  result := DmxScroller_Form1.Locate();
end;

function TMi_rtl_WebModule.Locate(const aKeyFields: string;
                                  const aKeyValues: Variant;
                                  aOptions: TLocateOptions): boolean;
begin
  result := DmxScroller_Form1.Locate(aKeyFields,aKeyValues,aOptions);
end;

function TMi_rtl_WebModule.GetActive: Boolean;
begin
  Result := Mi_SQLQuery1.Active and DmxScroller_Form1.Active;
end;

procedure TMi_rtl_WebModule.SetActive(a_active: Boolean);
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

function TMi_rtl_WebModule.Get_State: TDataSetState;
begin
  result := Mi_SQLQuery1.DataSource.DataSet.State;
end;

procedure TMi_rtl_WebModule.CmLocateExecute(Sender: TObject);
begin
  if Locate() = MrNo
  Then TMi_rtl.ShowMessage('Registro não localizado!');
end;

procedure TMi_rtl_WebModule.CmUpdateRecordExecute(Sender: TObject);
begin
  DmxScroller_Form1.UpdateRec;
end;

procedure TMi_rtl_WebModule.CmDeleteRecordExecute(Sender: TObject);
begin
  with DmxScroller_Form1 do
   if MessageBox('Confirma a exclusão do registro?',TMi_MsgBox.mtConfirmation,TMi_MsgBox.mbYesNo,TMi_MsgBox.mbyes) = TMi_MsgBox.mrYes
   Then If not DmxScroller_Form1.DeleteRec
        Then ShowMessage('Erro ao excluir o registro!');

end;

procedure TMi_rtl_WebModule.CmGoBofExecute(Sender: TObject);
begin
  DmxScroller_Form1.FirstRec;
end;

procedure TMi_rtl_WebModule.CmNextRecordExecute(Sender: TObject);
begin
  DmxScroller_Form1.NextRec;
end;

procedure TMi_rtl_WebModule.CmPrevRecordExecute(Sender: TObject);
begin
  DmxScroller_Form1.PrevRec;
end;

procedure TMi_rtl_WebModule.CmGoEofExecute(Sender: TObject);
begin
   DmxScroller_Form1.LastRec;
end;

procedure TMi_rtl_WebModule.CmRefreshExecute(Sender: TObject);
begin
  DmxScroller_Form1.Refresh;
end;

procedure TMi_rtl_WebModule.CmCancelExecute(Sender: TObject);
begin
  DmxScroller_Form1.Cancel;
end;

procedure TMi_rtl_WebModule.DataModuleCreate(Sender: TObject);
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

procedure TMi_rtl_WebModule.DataModuleDestroy(Sender: TObject);
begin
  active := false;
end;

procedure TMi_rtl_WebModule.locateRequest(Sender: TObject;
                                          ARequest: TRequest;
                                          AResponse: TResponse; var Handled: Boolean);

  //type
  //  TJSONEnum = Record
  //                Key    : TJSONStringType;
  //                KeyNum : Integer;
  //                Value  : TJSONData;
  //              end;

//  Function GetKeys:String;
//    var
//      JSONData : TJSONData;
//      JSONObject : TJSONObject;
//      i          : Integer;
//      aValue     : Variant;
//  begin
//    result := '';
//    // Verifica se a chave primária está nos parâmetros da rota
////    For i := 0 to ARequest.RouteParams.coun
//    Result := ARequest.RouteParams['id'];
//
//    // Se não encontrar na rota, verifica a query string
//    if Result = ''
//    then result := DmxScroller_Form1.getFieldsKeys(ARequest.QueryFields,aValue);
//
//      //Result := ARequest.QueryFields.Values['id'];
//
//    // Se não encontrar na query string, busca no corpo da requisição
//    if Result = ''
//    then begin
//           JSONObject := GetJSON(ARequest.Content) as TJSONObject;
//           if Assigned(JSONObject)
//           then try
//                  For i := 0 to JSONObject.Count-1 do
//                  begin
//                    Result := JSONObject.Items[i].AsString+';' ;
//                  end;
//
//                finally
//                  JSONObject.Free;
//                end;
//         end;
//  end;

  var
    aKeyFields: string;
    aKeyValues: array of string;//TArray<string>;//Variant;

    aOptions  : TLocateOptions;

  function LocateLocal():Boolean;
  begin
    if Assigned(onLocate)
    then Result := onLocate(aKeyFields,aKeyValues,[])
    else Result := Locate(aKeyFields,aKeyValues,[]);
  end;

begin
  aKeyValues:=[];
  aKeyFields := DmxScroller_Form1.getFieldsKeys(ARequest.QueryFields,aKeyValues);
  if aKeyFields <> ''
  Then begin
         if LocateLocal()
         Then begin
                AResponse.Content := DmxScroller_Form1.JSONObject.AsJSON;
              end
         else begin
                AResponse.Content := '{"error":"Usuário não encontrado"}';
              end;
         Handled:=true;
       end
  else begin
         Handled:=false;
         Raise Tmi_rtl.TException.Create(Self,{$I %CURRENTROUTINE%},'Parâmetros não informado!');
       end;
end;

constructor TMi_rtl_WebModule.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

//initialization
//  RegisterHTTPModule('TMi_rtl_WebModule', TMi_rtl_WebModule);

end.

