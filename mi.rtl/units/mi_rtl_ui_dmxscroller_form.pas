unit mi_rtl_ui_dmxscroller_form;
  {:< A unit **@name** implementa a classe TDmxScroller_Form cuja a sua função
      é vincular o componente TUiDmxScroller ao componentes visualais tais como
      TMi_lcl_ui_Form, TMi_lcl_ui_ds_Form e TMi_lcl_ui_js_Form..

    - Primeiro autor: Paulo Sérgio da Silva Pacheco paulosspacheco@@yahoo.com.br)

    - **VERSÃO**
      - Alpha - 1.0.0

    - **CÓDIGO FONTE**:
      - @html(<a href="../units/umi_ui_dmxscroller_form.pas">uMi_rtl_ui_Dmxscroller_form.pas</a>)

    - **HISTÓRICO**:
      - @html(<a href="../units/umi_ui_dmxscroller_form_historico.md">umi_ui_dmxscroller_form_historico.md</a>)

    - **PENDÊNCIAS**
      - T12 Criar método public procedure DoCreateForm();
      - T12 Criar propriedade UiDmxScroller_Buttons:TUiDmxScroller_Buttons


    - **CONCLUÍDO**
      - T12 Implementar o método: Procedure Select_First_Field_Normal; virtual;abstract;✅
      - Criar método procedure LockUpdates;virtual;✅
      - Criar método procedure UnlockUpdate;virtual;✅

      - T12 O método **PutBuffers** se DataSource for <> nil, com o buffer da
            propriedade dataSource.DataSet deve atualizar o buffer da propriedade
            **TDmxScroller_Form**. ✅

      - T12 O método **PutBuffers** se DataSource for <> nil, com o buffer da classe
        **TDmxScroller_Form** deve atualizar a buffer da propriedade dataSource.DataSet. ✅

      - Criar atributo private FirstDataRow    : integer; ✅
      - Criar atributo private PrevRec         : integer; ✅
      - Criar atributo protected DMXFields : TFPList; ✅
      - Criar atributo protected FldRadioButtonsAdicionados:TStringList;✅
      - Criar atributo Public Function SetHelpCtx_Hint ✅
      - Criar atributo Public Procedure SetHelpCtx_Hint ✅
      - Criar constructor Create(aOwner:TComponent);Override;  ✅
      - Criar método public procedure AfterConstruction; override;  ✅
      - Criar public destructor destroy;override;  ✅
      - Criar método protected procedure ShowControlState;override;  ✅
      - Criar método protected procedure CreateStruct ✅
      - Criar método Protected procedure DestroyStruct; Override;  ✅
      - Criar método procedure Scroll_it_inview_LCL ✅
      - Criar método public procedure Scroll_it_inview ✅
      - Criar método protected procedure CreateFormLCL ✅
      - Criar método public function GetTemplate(aNext: PSItem) ✅
      - Criar método protected   procedure UpdateBuffers_Controls;virtual;  ✅
      - Criar método public procedure UpdateBuffers;override;  ✅
      - Criar método public procedure Refresh;override;  ✅
      - Criar método protected procedure SetActiveTarget(aActive : Boolean);override;  ✅
      - Criar método protected procedure SetActive(aActive : Boolean);override;  ✅
      - T12 Documentar a unit.  ✅
  }

{$mode Delphi}

interface

uses
  Classes, SysUtils ,Dialogs
  ,db
  ,LResources
  ,Contnrs
  ,ActnList
  ,typInfo
  ,mi.rtl.Objects.Consts.Mi_MsgBox
  ,mi.rtl.Objects.Methods.Exception
  ,mi.rtl.Consts
  ,mi_rtl_ui_Dmxscroller
  ;

//Constantes publicas
{$include ./mi_rtl_ui_Dmxscroller_consts_inc.pas}


type
  TDmxScroller_Form = class;

  { Os tipos abaixo foi declarado fora da classe TDmxScroller_Form_Atributos para
     que os componentes não derivados de TDmxScroller_Form_Atributos possam reconhece-los 
     sem declarar o nome da classe TDmxScroller_Form_Atributos.}

  TDmxFieldRec = mi_rtl_ui_Dmxscroller.TDmxFieldRec;
  pDmxFieldRec = mi_rtl_ui_Dmxscroller.pDmxFieldRec;
  SmallWord    = TUiDmxScroller.SmallWord;

  { TMi_rtl_ui_Form_abstract }

  {: A classe **@name** é uma classe abstrata cujo objetivo é editar o buffer
     da classe **TDmxScroller_Form**.
     Esta classe deve ser a base para implementação de componentes visuais
     tais como Formulários LCL, web Browser, Controles android.
  }
  TMi_rtl_ui_Form_abstract = class(TComponent,IMi_rtl_ui_Form)

    {:A lista **@name** é usada para inserir os controles em _Owner em
      createForm com objetivo de destruir em DestroyForm.

      - Motivo: Não posso destruir _Owner porque o mesmo foi alocado em
                outra posição do código.
    }
    protected _ControlFields : TFPList;

    {: A constante **@name** usada como margen acima e abaixo do texto das linhas.
    }
    private public const HeightCharMargin :byte = 7;

    public constructor Create(AOwner: TComponent); override;
    public destructor destroy; override;

    {$REGION '--->Construção da propriedade Alias'}
      Protected Function GetAlias:AnsiString;Virtual;
      Protected Procedure SetAlias(Const aAlias:AnsiString);Virtual;
      published  Property Alias : AnsiString Read GetAlias Write SetAlias;
    {$ENDREGION}

    {$REGION --> Propriedade DmxScroller_Form}

    {: O método **@anme** deve ser anulado para destruir as referências
          a classe TUiDmxScroller se **_UiDmxScroller** for <> nil }
       //protected procedure destroyRef_DmxScroller_Form;virtual;
       private _DmxScroller_Form: TDmxScroller_Form;

       {: O método **@name** deve contruir e destrui as referência a classe
          _UiDmxScroller de processamento.
       }
       public Procedure Set_DmxScroller_Form(a_DmxScroller_Form: TDmxScroller_Form);Virtual;
       Public Function Get_DmxScroller_Form:TDmxScroller_Form;Virtual;
       {: A propriedade **@name** integra a classe visual a classe de processamento }
       published property DmxScroller_Form: TDmxScroller_Form read Get_DmxScroller_Form write Set_DmxScroller_Form;

    {$ENDREGION --> Propriedade DmxScroller_Form}

    {$REGION --> Propriedade Active}
       //private _DmxScroller_Form_Active_old:Boolean;
       private _Active :Boolean;
       protected function GetActive: Boolean;Virtual;
       protected procedure SetActive(aActive : Boolean);virtual;
       published property Active : Boolean Read GetActive Write SetActive;

    {$ENDREGION --> Propriedade Active}

    {$REGION --> Propriedade FldRadioButtonsAdicionados}

       {: Usado para evitar que RadiosButton sejam adicionados mais de uma vês em
          radiosgroups diferentes.
          - Mais informações veja campos FldRadioGrous.
       }
       private _FldRadioButtonsAdicionados:TStringList;
       protected function getFldRadioButtonsAdicionados:TStringList;
       public property FldRadioButtonsAdicionados:TStringList read GetFldRadioButtonsAdicionados;

   {$ENDREGION --> Propriedade FldRadioButtonsAdicionados}

    public procedure ShowControlState;Virtual;Abstract;

    {: O método **@name** é usado para da o scroller na janela onde esse componente for inserido.
       - **NOTA**
          - A LCL não rola a tela com a tecla tab e o controle não estiver visível.
    }

    {:O método **@name** permite scroller em dmxScroller}
    public procedure Scroll_it_inview(AControl: pDmxFieldRec);Virtual;overload;Abstract;

    {: O método **@name** é executado antes de executar getTemplate em SetActiveTarget.}

    public procedure DoBeforeSetActiveTarget;Virtual;Abstract;

    {: O método **@name** calcula a largura média do caractere só funciona bem
       para as fontes Courie new ou Dejavu Sans Mono tamanho 12 }
    public function GetWidthChar():integer;virtual;Overload;

    public function GetHeightChar():integer;virtual;Overload;

    {: O método **@name** calcula a largura média do caractere só funciona bem
       para as fontes Courie new ou Dejavu Sans Mono tamanho 12 }
    public function TextWidthChar(AFont: TPersistent): Integer;virtual;overload;

    public function TextHeightChar(AFont: TPersistent): Byte;virtual;overload;

    {: O método **@name** calcula a haltura média do caractere só funciona bem
       para as fontes Courie new ou Dejavu Sans Mono tamanho 12 }
    public function TextHeightChar: Byte;virtual;overload;
    //public procedure DestroyStruct; Virtual;Abstract;
    public procedure LockUpdates;virtual;Abstract;
    public procedure UnlockUpdate;virtual;Abstract;
    public procedure UpdateBuffers_Controls;Virtual;Abstract;

    {: O método **@name** refresh repinta os campo se foi auterado. }
    public procedure Refresh;Virtual;Abstract;
    protected procedure RefreshInternal;VIRTUAL;Abstract;

    {: O método **@name** altera a fonte e o tamanho do controle passado por **ctrl** e de seus filhos.}
    public procedure ModifyFontsAll(ctrl_WinControl: TComponent;aFontName:String;aSize:integer);virtual;overload;Abstract;

    {: O método **@name** altera a fonte do controle passado por **ctrl** e de seus filhos.}
    public procedure ModifyFontsAll(ctrl_WinControl: TComponent;aFontName:String);Virtual;overload;Abstract;

    //Verifica se o componente fornecido possui uma relação db e se o conteúdo foi alterado
    public function isValueDbChanged(Sender: TComponent): Boolean;Virtual;

    {: O método @name Executa o browser padrão do sistema operacional.

       - Exemplo:

         ```pascal

           program Project1;
            uses
              Interfaces,
              mi_rtl_ui_methods;
           begin

            TUiDmxScroller_ViewMethods.ShowHtml('https://wiki.freepascal.org/Webbrowser');

           end.
         ```
    }
    Public Procedure ShowHtml(URL:string);Virtual;Abstract;

    {: O método **@name** inicia a documentação resumida do campo. aFldNum }
    Public Function SetHelpCtx_Hint(aFldNum:Integer;a_HelpCtx_Hint:AnsiString):pDmxFieldRec;Virtual;overload;

    {: O método **@name** inicia a documentação resumida do campo passado em :apDmxFieldRec}
    Public Procedure SetHelpCtx_Hint(apDmxFieldRec:pDmxFieldRec;a_HelpCtx_Hint:AnsiString);Virtual;overload;

    {: O Método **@name** cria o formulário LCL baseado na lista de campos PDmxScroller. }
    public procedure CreateForm();Virtual;abstract;
    public procedure DestroyForm();Virtual;Abstract;

    {: O método **@name** Trava a edição do formulário}
    protected Procedure SetLocked(aLocked:Boolean);virtual;Abstract;

    {$Region ' ---> Property Mi_ActionList'}
      private _Mi_ActionList: TActionList;
      Private Procedure Set_Mi_ActionList(a_Mi_ActionList:TActionList);
      public property Mi_ActionList:TActionList read _Mi_ActionList write Set_Mi_ActionList;
    {$EndRegion ' ---> Property Mi_ActionList'}

    {: O Método **@name** deve ser implementado na visão para que selecione
             o primeiro campo que pode ser editado do formulário.
    }
    protected Procedure Select_First_Field_Normal; Virtual;Abstract;

    {: O Método **@name** deve excuta TMi_rtl.Locate()
    }
    public function Locate(aField:pDmxFieldRec): TMI_MsgBox.TModalResult;Virtual;Abstract;

    {O método **@name** é usuado para criar formulários clientes baseados em
     templates da aplicação destino.

     - A aplicação default é uma acplicação LCL cliente baseado nos dados do
       self.
    }
    public procedure BuildCustomerFormFromTemplate();Virtual;Abstract;
  end;

  { _TDmxScroller_Form_Atributos }
  {: A class **@name** contém os atributos da class TDmxScroller_Form
  }
  _TDmxScroller_Form_Atributos = class(TUiDmxScroller)
    private FirstDataRow    : integer;
    private PrevRec         : integer;
    Public destructor Destroy;Override;
    {: O método **@name** inicia a documentação resumida do campo. aFldNum }
    Public Function SetHelpCtx_Hint(aFldNum:Integer;a_HelpCtx_Hint:AnsiString):pDmxFieldRec;override;

    {: O método **@name** inicia a documentação resumida do campo passado em :apDmxFieldRec}
    Public Procedure SetHelpCtx_Hint(apDmxFieldRec:pDmxFieldRec;a_HelpCtx_Hint:AnsiString);override;overload;

    {$REGION --> Propriedade DmxScroller_Form}
       private _Mi_rtl_ui_Form: TMi_rtl_ui_Form_abstract;
       protected Procedure Set_Mi_rtl_ui_Form(a_Mi_rtl_ui_Form: TMi_rtl_ui_Form_abstract);overload;
       {: A propriedade **name** permite que o buffer de self possa ser visualizado
          em qualquer interface visual desde que a classe **TMi_rtl_ui_Form_abstract**
          seja implementada na plataforma destino.
       }
       public property Mi_rtl_ui_Form: TMi_rtl_ui_Form_abstract read _Mi_rtl_ui_Form write Set_Mi_rtl_ui_Form;
    {$ENDREGION --> Propriedade Mi_rtl_ui_Form_abstract}
  end;

  { _TDmxScroller_Form }
  {: A classe **@name** implementa a construção de formulários usando uma lista
     de Templates do tipo TDmxScroller}
  _TDmxScroller_Form = class(_TDmxScroller_Form_Atributos)
    published  property DataSource ;
    {: Constrói o componente}
    public constructor Create(aOwner:TComponent);Override;
    public procedure AfterConstruction; override;

    {: O método **@name** destrói o componente}
    public destructor destroy;override;

    {: O método **@name** interpreta uma lista de strings do tipo **PSItem** e
       adiciona os layout de cada campo em pDmxFieldRec, em seguida adiciona
       **pDmxFieldRec** em **DMXFields** com todos os campos de formação de formulário visual.
    }
    protected procedure CreateStruct(var ATemplate : PSItem);override;overload;

    {: O método **@name** destrói os dados criados em **CreateStruct()**. }
    Protected procedure DestroyStruct; Override;

    {: O método **@name** retorna uma lista de **PSItem** (Lista de strings) com o modelo
       usado para criar a tela.

       - **NOTA**
         - O Evento onGetTemplate só é iniciado em tempo de execução, por
           isso o formulário não pode ser criado em tempo de desenho do aplicativo.
         - Caso o evento onGetTemplate seja nil, então não posso ativar a tela.
         - Esse método pode ser anulado, caso se queira ignorar o evento onGetTemplate
           e definir o Template em uma método pai herdado desta classe.
         - O modelo cria um formulário  usando os tipos de dados primitivos.

       - **EXEMPLO**

         ```pascal

           // Implementação de um modelo no Alvo LCL
           function TDMAlunos.DmxScroller_Form_AlunoGetTemplate(aNext: PSItem): PSItem;
           begin
             with DmxScroller_Form_Aluno do
             begin
               // AlignmentLabels:= taCenter;
               AlignmentLabels := taLeftJustify;
               // AlignmentLabels := taRightJustify ;
               Result :=
                 NewSItem('~     Matrícula ~\LLLLL'+CharFieldName+'matricula'+CharAccReadOnly+CharPfInKeyPrimary+CharPfInAutoIncrement,
                 NewSItem('~Nome do aluno: ~\ssssssssssssssssssss`sssssss'+CharFieldName+'Nome'+CharPfInKey,
                 NewSItem('',
                 NewSItem('~     Endereço: ~\ssssssssssssssssssss`sssssssssss'+CharFieldName+'Endereco',
                 NewSItem('~P. Referência: ~\ssssssssssssssssssss`sssss'+CharFieldName+'PontoDeReferencia',
                 NewSItem('~          Cep: ~\##.###-###'+CharFieldName+'cep',
                 NewSItem('~       Estado: ~\SS'+CharFieldName+'Estado'+CharForeignKeyN_Um_false+'Estados,Estado',
                 NewSItem('~       Cidade: ~\ssssssssssssssssssss`sssss'+CharFieldName+'cidade'+CharForeignKeyN_Um_false+'Cidades,Estado;Cidade',
                 NewSItem('',
                 aNext)))))))));
             end;
           end;

         ```
    }
    public  function GetTemplate(aNext: PSItem) : PSItem;overload;override;

    protected procedure LockUpdates;virtual;
    protected procedure UnlockUpdate;virtual;
    protected procedure UpdateBuffers_Controls;virtual;
    public procedure UpdateBuffers;override;

    {: O Método **name** deve checar ser _ScroolingForm lementar  }
    protected procedure DoBeforeSetActiveTarget;virtual;

    {: O método **@name** ler o arquivo de extenção tableName.mi_lfm e coloca
       na string **_Strings** que é capturada em getTemplate se não houver definição
       de template em tempo de execução.

       - **OBJETIVO**
         - Criar formulário baseado em recursos tipo maricarai em arquivo.
         - Nome do arquivo: TableName.mi_lfm

    }
    public function DoAddTemplate:Boolean;Override;

    {: A procedure **@name** seta a propriedade active e criar um formulário
       na plataforma alvo
    }
    protected procedure SetActiveTarget(aActive: Boolean);virtual;//unimplemented;

    {$REGION --> Propriedade Active}

      {: A procedure **@name** seta a propriedade active  e criar um formulário
         LCL ou HTML dependendo do tipo de aplicação
      }
    protected procedure SetActive(aActive : Boolean);override;


    protected function GetBuffers: Boolean;override;
    protected function PutBuffers: Boolean;override;

     {: O método **@name** é usado para da o scroller na janela onde esse componente for inserido.
        - **NOTA**
          - A LCL não rola a tela com a tecla tab e o controle não estiver visível.
     }
     public procedure Scroll_it_inview(AControl: pDmxFieldRec);override;

     protected procedure ShowControlState;override;

     protected procedure RefreshInternal;override;


     public function isValueDbChanged(Sender: TComponent): Boolean;override;
     protected Procedure SetLocked(aLocked:Boolean);override;

     {: O Método **@name** deve ser implementado na visão para que selecione
        o primeiro campo que pode ser editado do formulário.
     }
     protected Procedure Select_First_Field_Normal; override;
     public function Locate(): TMi_MsgBox.TModalResult;override;overload;

     {$REGION ' ---> Propriedade ClientsTemplatesDataModule'}
       private _ClientsTemplatesDataModule : AnsiString;
       {:A propriedade contém o nome do DataModule usado como modelo para criação
         de novas aplicações clientes.
       }
       public Property ClientsTemplatesDataModule : AnsiString
               read _ClientsTemplatesDataModule write _ClientsTemplatesDataModule;
     {$ENDREGION ' ---> Propriedade ClientsTemplatesDataModule '}

     {$REGION ' ---> Propriedade ClientsPathName '}
       private function GetClientsPathName(aEnClientsApplication:TEnClientsApplication): AnsiString;
       public Property ClientsPathName[AppType: TEnClientsApplication] : AnsiString  read GetClientsPathName;
     {$ENDREGION ' ---> Propriedade ClientsPathName '}

     {$REGION ' ---> Propriedade ClientsTemplatesDataModuleFileName '}
       private function GetClientsTemplatesDataModuleFileName(aEnClientsApplication:TEnClientsApplication): AnsiString;
       public Property ClientsTemplatesDataModuleFileName[AppType: TEnClientsApplication] : AnsiString read GetClientsTemplatesDataModuleFileName;
     {$ENDREGION ' ---> Propriedade ClientsTemplatesDataModuleFileName '}

     {$REGION ' ---> Propriedade ClientsTemplatesFormFileName     '}
       private function GetClientsTemplatesFormFileName(aEnClientsApplication:TEnClientsApplication) : AnsiString;
       public Property ClientsTemplatesFormFileName[AppType: TEnClientsApplication]     : AnsiString read GetClientsTemplatesFormFileName   ;
     {$REGION ' ---> Propriedade ClientsTemplatesFormFileName    '}

     {$REGION ' ---> Propriedade ClientsApplicationsDataModuleFileName     '}
       private function GetClientsApplicationsDataModuleFileName(aEnClientsApplication:TEnClientsApplication) : AnsiString;
       public Property ClientsApplicationsDataModuleFileName[AppType: TEnClientsApplication]     : AnsiString read GetClientsApplicationsDataModuleFileName   ;
     {$REGION ' ---> Propriedade ClientsApplicationsDataModuleFileName    '}

     {$REGION ' ---> Propriedade ClientsApplicationsFormFileName     '}
       private function GetClientsApplicationsFormFileName(aEnClientsApplication:TEnClientsApplication) : AnsiString;
       public Property ClientsApplicationsFormFileName[AppType: TEnClientsApplication]: AnsiString read GetClientsApplicationsFormFileName   ;
     {$REGION ' ---> Propriedade ClientsApplicationsFormFileName    '}

     {:O método **@name** é usuado para criar pasta da aplicação cliente e
       pasta de seu template.
     }
     public procedure RewriteFileClients(aEnClientsApplication:TEnClientsApplication);

     //public procedure DoBuildFormFromTemplate();Virtual;overload; abstract;
     public procedure BuildCustomerFormFromTemplate();overload;

  end;

  { _TDmxScroller_Form }
  {: A classe **@name** implementa a construção de formulários usando uma lista
     de Templates do tipo TDmxScroller}
  TDmxScroller_Form = class(_TDmxScroller_Form)
    //published property Active; Não tem sentido porque os formulários não estão em arquivo .lfm

    published property name;
    published property Alias;
    published property AlignmentLabels;
//    published property Strings;  Para publicar preciso criar analisar sintático pq a constante +chFn+nãi é interpretada corretamente.
    published property OnAddTemplate;
    Published property OnNewRecord;
    published Property onCloseQuery;
    published Property onEnter;
    published Property onExit;
    published Property onEnterField;
    published Property onExitField;
    published property onGetTemplate;
    published property TableName;
    published Property DoOnNewRecord_FillChar;

    published property onBeforeInsert;
    published property onAfterInsert;

    published property onBeforeUpdate;
    published property onAfterUpdate;

    published property onBeforeDelete;
    published property onAfterDelete;

    published Property OnCalcFields;
    published Property OnCalcField;
    published Property OnChangeField;
//    published property Strings; Não pode ser published
    published property Mi_ActionList;

    published property ShouldSaveTemplate;

    {:A proprieade **@name** contém o nome do dataModule base a ser usado nos
      templates para gerar aplicações clientes}
    published property ClientsTemplatesDataModule;
  end;

procedure Register;

implementation
 {%CLASSGROUP 'System.Classes.TPersistent'}

const
  reintrance : boolean = false;

procedure Register;
begin
  {$I mi_rtl_ui_dmxscroller_form_icon.lrs}
  RegisterComponents('Mi.rtl', [TDmxScroller_Form]);
end;

{ TMi_rtl_ui_Form_abstract }
//procedure TMi_rtl_ui_Form_abstract.Set_DmxScroller_Form(a_DmxScroller_Form: TDmxScroller_Form);
//begin
//    if a_DmxScroller_Form = _DmxScroller_Form
//    Then exit;
//
//    if Assigned(_DmxScroller_Form)
//    Then _DmxScroller_Form.Set_Mi_rtl_ui_Form(nil);
//
//    _DmxScroller_Form := a_DmxScroller_Form;
//    if Assigned(_DmxScroller_Form)
//    then with begin
//           if _DmxScroller_Form.Active
//           then begin
//                  _DmxScroller_Form.Active := false;
//                  _DmxScroller_Form.Set_Mi_rtl_ui_Form(self);
//                  _DmxScroller_Form.Active := true;
//                end
//           else begin
//                  DmxScroller_Form.Set_Mi_rtl_ui_Form(self);
//                  if DmxScroller_Form.owner = self.Owner
//                  Then DmxScroller_Form_owner_is_private := true
//                  else if Assigned(DmxScroller_Form.owner) and
//                          Assigned(DmxScroller_Form.owner.Owner) and
//                          (DmxScroller_Form.owner.Owner = self.Owner)
//                       Then DmxScroller_Form_owner_is_private := true
//                       else DmxScroller_Form_owner_is_private := False;
//                end;
//
//           if (not Assigned(Mi_ActionList)) and Assigned(_DmxScroller_Form.Mi_ActionList)
//           Then Mi_ActionList := _DmxScroller_Form.Mi_ActionList;
//         end;
//end;
procedure TMi_rtl_ui_Form_abstract.Set_DmxScroller_Form(a_DmxScroller_Form: TDmxScroller_Form);
begin
    if a_DmxScroller_Form = _DmxScroller_Form
    Then exit;

    if Assigned(_DmxScroller_Form)

    Then begin
          if _DmxScroller_Form.Mi_ActionList=Mi_ActionList
          Then Mi_ActionList := nil;
           _DmxScroller_Form.Set_Mi_rtl_ui_Form(nil);
         end;

    _DmxScroller_Form := a_DmxScroller_Form;
    if Assigned(_DmxScroller_Form)
    Then begin
           _DmxScroller_Form.Set_Mi_rtl_ui_Form(self);
           if Mi_ActionList=nil
           Then Mi_ActionList := _DmxScroller_Form.Mi_ActionList;
         end;
end;


function TMi_rtl_ui_Form_abstract.Get_DmxScroller_Form: TDmxScroller_Form;
begin
  result := _DmxScroller_Form;
end;

function TMi_rtl_ui_Form_abstract.GetActive: Boolean;
begin
  Result := _Active;
  With TDmxScroller_Form do
  if self._Active and
     ((not Assigned(DmxScroller_Form))
     )
  Then Raise TException.create(self,{$I %CURRENTROUTINE%},'Algo errado o formulário lcl está ativo e dmxScroller inatvo!');
end;

procedure TMi_rtl_ui_Form_abstract.SetActive(aActive: Boolean);
  Var
    CanClose:Boolean = false;
begin
  if not Assigned(DmxScroller_Form)
  then exit;

  if aActive
  then begin
         if Active
         then Active := false;
         if not DmxScroller_Form.Active
         Then begin
               DmxScroller_Form.Active := true;
             end;
         If not Assigned(DmxScroller_Form.Mi_ActionList)
         Then Raise TException.create(self,{$I %CURRENTROUTINE%},'A propriedade DmxScroller_Form.Mi_ActionList = nil!');

         if DmxScroller_Form.Active
         Then begin
                CreateForm();
               _Active := aActive;
              end;
       end
  else begin
         if DmxScroller_Form.Active
         Then begin
                DestroyForm();
                _Active:= aActive;
              end;
       end;
end;

function TMi_rtl_ui_Form_abstract.getFldRadioButtonsAdicionados: TStringList;
begin
  result := _FldRadioButtonsAdicionados;
end;

function TMi_rtl_ui_Form_abstract.GetWidthChar(): integer;
begin
  result := 17;
end;

function TMi_rtl_ui_Form_abstract.GetHeightChar(): integer;
begin
  result := 17;
end;

function TMi_rtl_ui_Form_abstract.isValueDbChanged(Sender: TComponent): Boolean;
begin
  result := false;
end;

function TMi_rtl_ui_Form_abstract.TextWidthChar(AFont: TPersistent): Integer;
begin
  result := 10;
end;

function TMi_rtl_ui_Form_abstract.TextHeightChar(AFont: TPersistent): Byte;
begin
  result := 17;
end;

function TMi_rtl_ui_Form_abstract.TextHeightChar: Byte;
begin
  result := 17;
end;


function TMi_rtl_ui_Form_abstract.SetHelpCtx_Hint(aFldNum: Integer;  a_HelpCtx_Hint: AnsiString): pDmxFieldRec;
begin
  if Assigned(DmxScroller_Form)
  Then result := DmxScroller_Form.SetHelpCtx_Hint(aFldNum,a_HelpCtx_Hint)
  else result:= nil;
end;

procedure TMi_rtl_ui_Form_abstract.SetHelpCtx_Hint(apDmxFieldRec: pDmxFieldRec; a_HelpCtx_Hint: AnsiString);
begin
  if Assigned(_DmxScroller_Form)
  Then DmxScroller_Form.SetHelpCtx_Hint(apDmxFieldRec,a_HelpCtx_Hint);
end;

constructor TMi_rtl_ui_Form_abstract.Create(AOwner: TComponent);
begin
  inherited Create(aOwner);
  _FldRadioButtonsAdicionados := TStringList.create;
  _ControlFields := TFPList.Create;
end;

destructor TMi_rtl_ui_Form_abstract.destroy;
begin
  if active
  Then Active := false;
  FreeAndNil(_ControlFields);
  FreeAndNil(_FldRadioButtonsAdicionados);
  inherited destroy;
end;

function TMi_rtl_ui_Form_abstract.GetAlias: AnsiString;
begin
  if Assigned(DmxScroller_Form) and (DmxScroller_Form.Alias<>'')
  then result := DmxScroller_Form.Alias
  else result := '';
end;

procedure TMi_rtl_ui_Form_abstract.SetAlias(const aAlias: AnsiString);
begin
  if aAlias<>''
  then begin
         if Assigned(DmxScroller_Form)
         then DmxScroller_Form.Alias :=aAlias
       end
  else begin
         if Assigned(DmxScroller_Form)
         then DmxScroller_Form.Alias :='TMi_rtl_ui_Form_abstract';
      end;
end;

procedure TMi_rtl_ui_Form_abstract.Set_Mi_ActionList( a_Mi_ActionList: TActionList);
begin
  if Assigned(DmxScroller_Form)
  then begin
         _Mi_ActionList := a_Mi_ActionList;
         if not Assigned(DmxScroller_Form.Mi_ActionList)
         Then DmxScroller_Form.Mi_ActionList := _Mi_ActionList;
       end;
end;



{ _TDmxScroller_Form_Atributos ============================================== }

destructor _TDmxScroller_Form_Atributos.Destroy;
begin
  _Mi_rtl_ui_Form := nil;
  inherited Destroy;
end;

function _TDmxScroller_Form_Atributos.SetHelpCtx_Hint(aFldNum: Integer;a_HelpCtx_Hint: AnsiString): pDmxFieldRec;
begin
  result := inherited SetHelpCtx_Hint(aFldNum, a_HelpCtx_Hint);
end;

procedure _TDmxScroller_Form_Atributos.SetHelpCtx_Hint(apDmxFieldRec: pDmxFieldRec; a_HelpCtx_Hint: AnsiString);
begin
  inherited SetHelpCtx_Hint(apDmxFieldRec,a_HelpCtx_Hint);
end;

{_TDmxScroller_Form ==========================================================}

constructor _TDmxScroller_Form.Create(aOwner: TComponent);
begin
  inherited Create(aowner);
  _ClientsTemplatesDataModule := 'mi.rtl.web.module';
end;

procedure _TDmxScroller_Form.AfterConstruction;
begin
  inherited AfterConstruction;
end;

destructor _TDmxScroller_Form.destroy;
begin
  if getState(Mb_St_Active) and active
  then begin
         active := false;
         if active
         Then Raise TException.create(self,{$I %CURRENTROUTINE%},ParametroInvalido);
         inherited destroy;
       end
  else inherited destroy;
end;

procedure _TDmxScroller_Form_Atributos.Set_Mi_rtl_ui_Form( a_Mi_rtl_ui_Form: TMi_rtl_ui_Form_abstract);
begin
  if a_Mi_rtl_ui_Form = _Mi_rtl_ui_Form
  Then exit;

  _Mi_rtl_ui_Form:= a_Mi_rtl_ui_Form;
  If Assigned(_Mi_rtl_ui_Form)
  Then _Mi_rtl_ui_Form.Alias:= Alias;
end;




procedure _TDmxScroller_Form.CreateStruct(var ATemplate: PSItem);
  var
    Items      : PSItem;
    i,Lim      : integer;
    AllZ,
    aShouldSaveTemplate : boolean;
    S          : tString;
    First      : pDmxFieldRec;
    aForm      : AnsiString = '';
begin
  aShouldSaveTemplate := ShouldSaveTemplate ;
  ShouldSaveTemplate := False;

  Items := ATemplate;
  If (Items = nil)
  then Exit;
  FirstDataRow := -1;
  AllZ := (Items.Value <> nil) and
          (Items.Value^[1] = CharAllZeroes);
  DMXFields := TFPList.Create;
  i := 0;
  Lim := 0;
  First := DMXField1;
  Self.CurrentRecord := -1;
  Items := ATemplate;
  While (Items <> nil)  do
  begin
    DMXField1 := nil;
    Self.CurrentRecord := Self.CurrentRecord +1;
    Limit.X := 0;
    If (Items^.Value = nil) or (Items^.Value^ = '') or (Items^.Value^ = CharAllZeroes)
    then S := ' '
    else S := Items.Value^;
    If AllZ and (length(S) < pred(sizeof(S)))
    then Insert(CharAllZeroes, S, 1);
    aForm := aForm + s +New_Line;
    Inherited CreateStruct(S);

    if First = nil
    Then begin
            First := DMXField1;
          end;
    If (FirstDataRow < 0) and (RecordSize > 0)
    then begin
            _CurrentField := DMXField1;
            While (_CurrentField <> nil) and ((_CurrentField^.FieldSize = 0)
               or (_CurrentField^.access and (accHidden or accSkip) <> 0)) do
            begin
              _CurrentField := _CurrentField^.Next;
            end;
            If (_CurrentField <> nil)
            then FirstDataRow := i;
         end;
    If (Lim < Limit.X)
    then Lim := Limit.X;
    DMXFields.Add(DMXField1);
    Inc(i);
    Items := Items.Next;
  end;
  Limit.X := Lim;
  DataBlockSize := RecordSize;
  DataBlockSize := DataBlockSize * Fields.Count;
  If (FirstDataRow >= 0)
  then CurrentRecord := FirstDataRow;
  DMXField1 := DMXFields[CurrentRecord];
  PrevRec := -1;

  UpdateDataField_AliasList; //Atualiza os campo fldRadioButton

  if aShouldSaveTemplate and (TableName<>'')
  Then SaveTemplate(TableName+'.mi_lfm',aForm);
end;

procedure _TDmxScroller_Form.DestroyStruct;
  var
    i   : integer;
begin
  If (DMXFields = nil)
  then Exit;

  //if Assigned(_BufDataset)
  //then BufDataset := nil ;

  i := DMXFields.Count;
  While (i > 0) do
  begin
    DMXField1 := DMXFields[pred(i)];
    If (DMXField1 <> nil)
    then Inherited DestroyStruct;
    Dec(i);
  end;
  DestroyData;
  freeAndNil(DMXFields);
end;

function _TDmxScroller_Form.GetTemplate(aNext: PSItem): PSItem;
begin
  if GetState( Mb_St_Creating_Template )
  then begin
          if Assigned(onAddTemplate)
          then begin
                 //Executa o evento definido em tempo de desenho.
                 onAddTemplate(Self);
                 result := Strings.PListSItem;
               End
          else if Assigned(onGetTemplate)
               then begin
                      //Executa o evento definido em tempo de projeto.
                      result := onGetTemplate(aNext);
                    End
               else If Strings.Count >0 //Temĺate criado em tempo de projeto.
                    then begin
                           result := Strings.PListSItem;
                         end
                    else result := aNext;
                    //implementar no futuro a possibilidade de ler do arquivo.
       end;
end;

procedure _TDmxScroller_Form.LockUpdates;
begin
  if Assigned(Mi_rtl_ui_Form)
  then Mi_rtl_ui_Form.LockUpdates
  else Raise TException.Create(self,{$I %CURRENTROUTINE%},'Método é abstrato virtual e deve ser implementado na classe filha!');
end;

procedure _TDmxScroller_Form.UnlockUpdate;
begin
  if Assigned(Mi_rtl_ui_Form)
  then Mi_rtl_ui_Form.UnlockUpdate
  else Raise TException.Create(self,{$I %CURRENTROUTINE%},'Método é abstrato virtual e deve ser implementado na classe filha!');
end;

procedure _TDmxScroller_Form.UpdateBuffers_Controls;
begin
  if Assigned(Mi_rtl_ui_Form)
  then Mi_rtl_ui_Form.UpdateBuffers_Controls
  else Raise TException.Create(self,{$I %CURRENTROUTINE%},'Método é abstrato virtual e deve ser implementado na classe filha!');
end;

procedure _TDmxScroller_Form.UpdateBuffers;
  Var i : integer;
      wCurrentField : pDmxFieldRec;
      ds : TDataSet;
begin
  if (not reintrance)
      and Assigned(DMXFields)
      and (Not ControlsDisabled)
  then begin
         ds := GetDataSet;
         If not (ds.State in [dsEdit,DsInsert])
         then begin
                //writeLn('Chamada inválida ao método');Exit;
                Raise TException.Create(self,{$I %CURRENTROUTINE%},'Método é abstrato virtual e deve ser implementado na classe filha!');
              end;

        try
          reintrance := true;
          wCurrentField := CurrentField;

          for i := 0 to DMXFields.Count-1 do
          begin
            CurrentField := DMXFields[i];
            while (CurrentField) <> nil do
            with CurrentField^ do begin
              if (Template <> nil)
                 and (Fieldnum<>0)
                 and (LinkEdit<>nil)
              then begin
                     UpdateBuffers_Controls;
                   end;

              if CurrentField <> nil
              Then CurrentField := Next;
            end;

            if CurrentField <> nil
            Then CurrentField := CurrentField^.Next;
          End;

        Finally
          CurrentField := wCurrentField;
          reintrance := false;
        end;
  end;

end;

procedure _TDmxScroller_Form.DoBeforeSetActiveTarget;
begin
  if Assigned(Mi_rtl_ui_Form)
  then Mi_rtl_ui_Form.DoBeforeSetActiveTarget;
end;

function _TDmxScroller_Form.DoAddTemplate: Boolean;

   Procedure Codifica_caractere_de_controle;
      Var
        i,j : Integer;
        S,result : AnsiString;
   begin
     if Strings.Count > 0
     Then For i := 0 to Strings.Count-1 do
          begin
            result := '';
            s := Strings[i];
            j := 1;
            while j <= length(s) do
            begin
              case s[j] of
                '^' : begin
                        case s[j+1] of
                        'A','a' : result := result + ^A;
                        'B','b' : result := result + ^B;
                        'C','c' : result := result + ^C;
                        'D','d' : result := result + ^D;
                        'E','e' : result := result + ^E;
                        'F','f' : result := result + ^F;
                        'G','g' : result := result + ^G;
                        'H','h' : result := result + ^H;
                        'I','i' : result := result + ^I;
                        'J','j' : result := result + ^J;
                        'K','k' : result := result + ^K;
                        'L','l' : result := result + ^L;
                        'M','m' : result := result + ^M;
                        'N','n' : result := result + ^N;
                        'O','o' : result := result + ^O;
                        'P','p' : result := result + ^P;
                        'Q','q' : result := result + ^Q; //Livre
                        'R','r' : result := result + ^R;
                        'S','s' : result := result + ^S;
                        'T','t' : result := result + ^T;
                        'U','u' : result := result + ^U;
                        'V','v' : result := result + ^V;
                        'W','w' : result := result + ^W;
                        'X','x' : result := result + ^X;
                        'Y','y' : result := result + ^Y;
                        'Z','z' : result := result + ^Z;
                        else result := result + s[j];
                      end;
                      inc(j);
                     end;
                else result := result + s[j];
              end;
              inc(j);
            end;
            Strings[i] := result;
          end;
   end;

  var
    f:ansiString;

begin
  //dialogs.ShowMessage('Anstes DoAddTemplate.Strings.Clear;');
  Strings.Clear;

  if TableName <> ''
  Then //with Application.ParamExecucao.NomeDeArquivosGenericos do
       begin
         f := TableName+'.mi_lfm';
         if SysUtils.FileExists(f)
          Then begin
                 Result := true;
                 Strings.LoadFromFile(f);
                 Codifica_caractere_de_controle;
               end
          else Result := false;

        end
        else Result := false;

end;

procedure _TDmxScroller_Form.SetActiveTarget(aActive: Boolean);
begin
  DoBeforeSetActiveTarget;
  if aActive
  then begin
         //AlignmentLabels:= taLeftJustify;// taCenter;taRightJustify;
         //AlignmentLabels:= taCenter;//taRightJustify;//taLeftJustify;
         //AlignmentLabels:= taRightJustify;//taLeftJustify;//taCenter;

         //dialogs.ShowMessage('Antes SetActivo.DoAddTemplate');
         if  Assigned(onGetTemplate) or
              Assigned(onAddTemplate) or
              DoAddTemplate
         then begin
                 SetState(Mb_St_Creating,true);
                 CreateStruct;
                 if Assigned(BufDataset)
                 Then BufDataset.LoadFromFile();

                 SetState(Mb_St_Creating,False);

                 inherited SetActive(aActive);

                 if Assigned(Parent)
                 Then EnableControls;
                 if Assigned(onEnter)
                 then begin
                        DoOnEnter(Self);
                        RefreshInternal;
                        //dialogs.ShowMessage('depois SetActivo.RefreshInternal');
                      end
              end
         else begin
                //dialogs.ShowMessage('Os eventos getTemplate ou AddTemplate não definido!');
                Raise TException.Create(self,{$I %CURRENTROUTINE%},'Os eventos getTemplate ou AddTemplate não definido!');
              end;
       end
  else begin
         //dialogs.ShowMessage('Chamada inválida ao método!');
         Raise TException.Create(self,{$I %CURRENTROUTINE%},'Chamada inválida ao método!');
       end;
end;

procedure _TDmxScroller_Form.SetActive(aActive: Boolean);
  Var CanClose : boolean;
    s:string;
begin
  if (Assigned(self)) and
     (not GetState(MB_Destroying))
  then
  begin
    if Active and aActive
    then begin
           SetActive(false);
         end
    else if Active
         then begin
                CanClose := true;
                DoOnCloseQuery (Self,CanClose) ;
                if CanClose
                then begin
                       if Assigned(Parent)
                       Then DisableControls;

                       if Assigned(onExit)
                       then OnExit(Self);
                       SetState(MB_Destroying,true);
                       //destroyRef_DmxScroller_Form;
                       //Destruir os ponteiros da contrução anterior;
                       DestroyStruct;

                       //SetState(Mb_St_Active,false);
                       inherited SetActive(false);

                       SetState(MB_Destroying,false);
                    End;
               end;

    //Criar um formulário da aplicação tipo LCL, web, celular etc...
    if (not Active) and aActive
    Then begin
           //Dialogs.ShowMessage('Antes de SetActiveTarget');
           SetActiveTarget(aActive);
           //Dialogs.ShowMessage('Depois de SetActiveTarget');
         end;
  end;
end;

function _TDmxScroller_Form.GetBuffers: Boolean;
  Var
    wCurrentField : pDmxFieldRec;
    s : AnsiString;
    i,posPonto : Integer;
    st:TDataSetState;
    f : TField;
    ds : TDataSet;
begin
  ds := GetDataSet;
  if Assigned(ds)
  then st := ds.state;

  if Assigned(ds) and isDataSetActive and (ds.State in [dsBrowse,dsEdit,dsInsert]) and
     Assigned(Fields)
  then begin
         Try
           wCurrentField := CurrentField;
           for i := 0 to Fields.Count-1 do
           begin
             SetCurrentField(Fields[i]);
             if CurrentField.Fieldnum<>0
             then begin
                    posPonto := Pos('.',CurrentField.FieldName);
                    if posPonto <> 0
                    then begin
                           s := copy(CurrentField.FieldName,posPonto+1,length(CurrentField.FieldName)-posPonto);
                           f := ds.FindField(s);
                         end
                    else f := ds.FindField(CurrentField.FieldName);

                    if (Assigned(f))
                    Then CurrentField.CopyFrom(f);
                  end;
           end;

         Finally
           SetCurrentField(wCurrentField);
         end;

         if Assigned(Fields)
         Then begin
                result := inherited GetBuffers;
                RefreshInternal;
              end
         else result := false;
       end
  else result := false;
end;

function _TDmxScroller_Form.PutBuffers: Boolean;
  Procedure  Put(aFieldName:String);
   var
     s:String;
     posPonto:integer;
     f : TField;
  begin
    posPonto := Pos('.',CurrentField.FieldName);
    if posPonto<> 0
    then begin
           s := copy(CurrentField.FieldName,posPonto+1,length(CurrentField.FieldName)-posPonto);
           f := GetDataSet.FindField(s);
         end
    else f := GetDataSet.FindField(aFieldName);

    if Assigned(f)
    then CurrentField.CopyTo(f);
  end;

  Var
    i  : Integer;
    wCurrentField : pDmxFieldRec;
begin
  result := inherited PutBuffers;
  if isDataSetActive
  then Try
         wCurrentField := CurrentField;
         If Not (GetDataSet.State in dsEditModes)
         Then edit;

         for i := 0 to Fields.Count-1 do
         begin
           SetCurrentField(Fields[i]);
           if (CurrentField.Fieldnum<>0)
           then put(CurrentField.FieldName);
         end;
         result := true;
       Finally
         SetCurrentField(wCurrentField);

       end;
end;

procedure _TDmxScroller_Form.Scroll_it_inview(AControl: pDmxFieldRec);
begin
  if Assigned(Mi_rtl_ui_Form) and (not ControlsDisabled)
  then Mi_rtl_ui_Form.Scroll_it_inview(AControl);
end;

procedure _TDmxScroller_Form.ShowControlState;
begin
  if Assigned(Mi_rtl_ui_Form)
  then Mi_rtl_ui_Form.ShowControlState
  else Raise TException.Create(self,{$I %CURRENTROUTINE%},'Método é abstrato virtual e deve ser implementado na classe filha!');
end;

procedure _TDmxScroller_Form.RefreshInternal;
begin
  if Active and
     (Not GetState(Mb_St_Creating))
     and GetState( Mb_St_ControlsEnabled) and RecordSelected
  then begin
         inherited RefreshInternal;
         if Assigned(Mi_rtl_ui_Form)  //(not Appending) and
         then Mi_rtl_ui_Form.RefreshInternal;
       end;
end;

function _TDmxScroller_Form.isValueDbChanged(Sender: TComponent): Boolean;
begin
  if Assigned(Mi_rtl_ui_Form)
  then result := Mi_rtl_ui_Form.isValueDbChanged(Sender)
  else Result:=inherited isValueDbChanged(Sender);
end;

procedure _TDmxScroller_Form.SetLocked(aLocked: Boolean);
begin
  inherited SetLocked(aLocked);
  if Assigned(Mi_rtl_ui_Form)
  then Mi_rtl_ui_Form.SetLocked(aLocked);
end;

procedure _TDmxScroller_Form.Select_First_Field_Normal;
begin
  if Assigned(Mi_rtl_ui_Form)
  then Mi_rtl_ui_Form.Select_First_Field_Normal;
end;

function _TDmxScroller_Form.Locate: TMi_MsgBox.TModalResult;
begin
  if Assigned(Mi_rtl_ui_Form) and isDataSetActive
  then try
         DoOnExit(self);
         DisableControls;

         Result := Mi_rtl_ui_Form.Locate(CurrentField_focused);

       finally
         EnableControls;
         DoOnEnter(self);

       end;
end;

function _TDmxScroller_Form.GetClientsPathName(aEnClientsApplication: TEnClientsApplication): AnsiString;
begin
  result := Application.ParamExecucao.PathRaiz;
  if result[length(result)]= PathDelim
  then Result := Result +'clients'+PathDelim+NameClientsApplication[aEnClientsApplication]+PathDelim
  else Result := Result +PathDelim+'clients'+PathDelim+NameClientsApplication[aEnClientsApplication]+PathDelim;
end;

function _TDmxScroller_Form.GetClientsTemplatesDataModuleFileName(aEnClientsApplication: TEnClientsApplication): AnsiString;
begin
  Result := ClientsPathName[aEnClientsApplication]+PathDelim+
               'templates'+PathDelim+ClientsTemplatesDataModule+'.'+NameClientsApplicationExt[aEnClientsApplication]
 end;

function _TDmxScroller_Form.GetClientsTemplatesFormFileName(aEnClientsApplication: TEnClientsApplication): AnsiString;
begin
  Result := ClientsPathName[aEnClientsApplication]+PathDelim+
               'templates'+PathDelim+ClientsTemplatesDataModule+'.form.'+NameClientsApplicationExt[aEnClientsApplication]
end;

function _TDmxScroller_Form.GetClientsApplicationsDataModuleFileName(
                aEnClientsApplication: TEnClientsApplication): AnsiString;
begin
  if Assigned(self.Owner)
  Then Result := ClientsPathName[aEnClientsApplication]+PathDelim+
                            PathDelim+self.Owner.className+'.'+NameClientsApplicationExt[aEnClientsApplication]
  else Result := ClientsPathName[aEnClientsApplication]+PathDelim+
                            PathDelim+className+'.'+NameClientsApplicationExt[aEnClientsApplication];
end;

function _TDmxScroller_Form.GetClientsApplicationsFormFileName(
                        aEnClientsApplication: TEnClientsApplication): AnsiString;
begin
  if Assigned(self.Owner)
  Then Result := ClientsPathName[aEnClientsApplication]+PathDelim+
                               PathDelim+self.Owner.className+'.form.'+NameClientsApplicationExt[aEnClientsApplication]
  else Result := ClientsPathName[aEnClientsApplication]+PathDelim+
                                PathDelim+className+'.form.'+NameClientsApplicationExt[aEnClientsApplication];
end;

procedure _TDmxScroller_Form.RewriteFileClients(aEnClientsApplication: TEnClientsApplication);
  var
   FilePath, DirPath: string;
   f : Text;
   ErrIo : Integer;
begin
  FilePath := ClientsTemplatesDataModuleFileName[aEnClientsApplication];
  DirPath := ExtractFilePath(FilePath);

  // Criar o diretório e subdiretórios, se necessário
  if not DirectoryExists(DirPath)
  Then if not CreateDirectory(DirPath)
       then Raise TException.create(self,{$I %CURRENTROUTINE%},LastError);

  if Not FileExists(FilePath)
  then begin
         AssignFile(f,FilePath);
         {$i-}
         Rewrite(f);
         {$i+}
         ErrIo := IoResult;
         if ErrIo = 0
         Then begin
                {$i-}
                writeLn(f,NameClientsApplication[aEnClientsApplication]);
                {$i+}ErrIo := IoResult;
                if ErrIo = 0
                Then begin
                        {$i-}
                        CloseFile(f);
                        {$i+}ErrIo := IoResult;
                     end;
             end;

        if ErrIO<>0
        Then Raise TException.create(self,{$I %CURRENTROUTINE%},ErrIO);
       end;
end;

procedure _TDmxScroller_Form.BuildCustomerFormFromTemplate();
begin
  if Assigned(Mi_rtl_ui_Form) and isDataSetActive
  Then Mi_rtl_ui_Form.BuildCustomerFormFromTemplate();
end;


end.


{
procedure Ttestsdfspecific.TestOutput;
// Basic assignment test: assign some difficult data to records and
// see if the RecordCount is correct.
const
  NAME: array[1..4] of string = (
    'J"T"',                             // Data with quotes
    'Hello, goodbye',                   // Data with delimiter
    '  Just a line with spaces     ',   // Regular data
    'Delimiter,"and";quote'             // Data with delimiter and quote
  );
var
  i: integer;
begin
  // with Schema, with Header line
  TestDataset.Schema[1] := 'NAME=30';
  TestDataset.FileName := TestFileName('output.csv');
  TestDataset.Open;

  // Fill test data
  TestDataset.Append;
  TestDataset.FieldByName('ID').AsInteger := 1;
  TestDataset.FieldByName('NAME').AsString := NAME[1];
  TestDataset.FieldByName('BIRTHDAY').AsDateTime := ScanDateTime('yyyymmdd', '19761231', 1);
  TestDataset.Post;

  TestDataset.Append;
  TestDataset.FieldByName('ID').AsInteger := 2;
  TestDataset.FieldByName('NAME').AsString := NAME[2];
  TestDataset.FieldByName('BIRTHDAY').AsDateTime := ScanDateTime('yyyymmdd', '19761231', 1);
  TestDataset.Post;

  TestDataset.Append;
  TestDataset.FieldByName('ID').AsInteger := 4;
  TestDataset.FieldByName('NAME').AsString := NAME[4];
  TestDataset.FieldByName('BIRTHDAY').AsDateTime := ScanDateTime('yyyymmdd', '19761231', 1);
  TestDataset.Post;

  TestDataset.Insert;
  TestDataset.FieldByName('ID').AsInteger := 3;
  TestDataset.FieldByName('NAME').AsString := NAME[3];
  TestDataset.FieldByName('BIRTHDAY').AsDateTime := ScanDateTime('yyyymmdd', '19761231', 1);
  TestDataset.Post;

  // test sequential order of records
  TestDataset.First;
  for i:=1 to 4 do begin
    AssertEquals('RecNo', i, TestDataset.RecNo);
    AssertEquals(i, TestDataset.FieldByName('ID').AsInteger);
    TestDataset.Next;
  end;
  // set/test RecNo
  for i:=1 to 4 do begin
    TestDataset.RecNo := i;
    AssertEquals('RecNo', i, TestDataset.RecNo);
    AssertEquals(i, TestDataset.FieldByName('ID').AsInteger);
  end;
  AssertEquals('RecordCount', 4, TestDataset.RecordCount);
  TestDataset.Close;
  AssertEquals('RecordCount after Close', 0, TestDataset.RecordCount);

  // reopen, retest
  TestDataset.Open;
  for i:=1 to 4 do begin
    AssertEquals(NAME[i], TestDataset.FieldByName('NAME').AsString);
    TestDataset.Next;
  end;
  AssertTrue('Eof', TestDataset.Eof);
end;
}
