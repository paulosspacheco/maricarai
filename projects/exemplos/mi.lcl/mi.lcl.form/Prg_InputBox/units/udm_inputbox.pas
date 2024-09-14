unit UDm_InputBox;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ActnList, mi.rtl.ui.dmxscroller.inputbox,
  mi_rtl_ui_Dmxscroller, mi_rtl_ui_dmxscroller_form, fpjson;

type

  { TDm_InputBox }

  TDm_InputBox = class(TDataModule)
    ActionList1: TActionList;
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
    MI_UI_InputBox1: TMI_UI_InputBox;
    procedure CmDeleteRecordExecute(Sender: TObject);
    procedure CmGoBofExecute(Sender: TObject);
    procedure CmGoEofExecute(Sender: TObject);
    procedure CmLocateExecute(Sender: TObject);
    procedure CmNewRecordExecute(Sender: TObject);
    procedure CmNextRecordExecute(Sender: TObject);
    procedure CmPrevRecordExecute(Sender: TObject);
    procedure CmRefreshExecute(Sender: TObject);
    procedure CmUpdateRecordExecute(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
    function DmxScroller_Form1GetTemplate(aNext: PSItem): PSItem;

  private
  protected

  public
    {$REGION Propriedade Template}
      private _Template:AnsiString;

      {: O Método **@name** inicia o atributo _Template e criar a lista _FormSItem : PSitem

         - **NOTAS**
           - Criar em TObjectss.TStringList o método
      }
      protected Procedure Set_Template(aTemplate:AnsiString);

      {: A propriedade **@name** é usada para criar uma lista de PSItem para ser usada como modelo do formulário.

         - **NOTAS**
           - Template é um string comum, onde cada linha é separada com ^J.
           - Template tem uma lista de string com formato Dmx.
             - Formato da propriedade Template:

               ```pascal

                   Template := '~Nome do Aluno:~\Sssssssssssssssssssssssss`ssssssssssssssss'+ChFN+'Nome'+lf+
                               '~     Endereço:~\Sssssssssssssssssssssssss`ssssssssssssssss'+ChFN+'endereco'+lf+
                               '~          Cep:~\##-###-###'+ChFN+'cep'+lf+
                               '~       Bairro:~\sssssssssssssssssssssssss'+ChFN+'bairro'+lf+
                               '~       Cidade:~\sssssssssssssssssssssssss'+ChFN+'cidade'+lf+
                               '~       Estado:~\SS'+ChFN+'estado'+lf+
                               '~        Idade:~\BB'+ChFN+'idade'+FldUpperLimit+#18+lf+
                               '~    Matricula:~\III'+ChFN+'matricula'+lf+
                               '~     Valor da~'+lf+
                               '~    Mensalidade:~\R,RRR.RR'+ChFN+'mensalidade';

               ```

           - **SINTAXE**
             - **~** (til) : Limitador de rótulos do formulário;
             - **s** (s minúsculo) : caracteres alfanumérico incluindo os maiúsculas, minusculas, números e símbolos;
             - **S** (S maiúsculo) : caracteres alfanumérico incluindo os maiúsculas, números e símbolos;
             - **#** (# cancela) : Aceita somente números de 0 a 99
             - **-** (literal ) : Separador de números
             - **B** (B maiúsculo): Campo do tipo byte
             - **FldUpperLimit** : O caractere seguinte indica o limite superior da variável. No exemplo acima é 18 anos;
             - **R** : Indica um caractere de um campo do tipo double;
             - **I** : Indica um caractere de um campo do tipo interger. Faixa: -32000 a +32000;
      }
      public property Template:AnsiString read _Template write Set_Template;
    {$ENDREGION Propriedade Template}

    public procedure SetEvents(aTitle: AnsiString;
                               aTemplate: AnsiString;
                               aOnCloseQuery: TOnCloseQuery;
                               aOnEnter: TOnEnter;
                               aOnExit: TOnExit;
                               aOnEnterField: TOnEnterField;
                               aOnExitField: TOnExitField);overload;

    public procedure SetEvents(aTitle: AnsiString;
                               aTemplate: AnsiString;
                               aOnCloseQuery: TOnCloseQuery);overload;

    public procedure Refresh;
    {$Region Propriedade active}

      private Function GetActive : Boolean;
      private procedure SetActive(a_active : Boolean);

      {: A propriedade **@name** é usado para ativar e desativa o datamodule }
      public property active : Boolean  read GetActive write SetActive;

    {$EndRegion Propriedade state}

  end;

var
  Dm_InputBox: TDm_InputBox;

implementation

{$R *.lfm}

{ TDm_InputBox }




procedure TDm_InputBox.Set_Template(aTemplate: AnsiString);
begin
  _Template := aTemplate;
end;

procedure TDm_InputBox.SetEvents(aTitle: AnsiString;
                                 aTemplate: AnsiString;
                                 aOnCloseQuery: TOnCloseQuery;
                                 aOnEnter: TOnEnter;
                                 aOnExit: TOnExit;
                                 aOnEnterField: TOnEnterField;
                                 aOnExitField: TOnExitField);
begin
  with DmxScroller_Form1 do
  begin
    Alias        := aTitle;
    Template     := aTemplate;
    OnCloseQuery := aOnCloseQuery;
    OnEnter      := aOnEnter;
    OnExit       := aOnExit;
    OnEnterField := aOnEnterField;
    OnExitField  := OnExitField;
  end;
end;

procedure TDm_InputBox.SetEvents(aTitle: AnsiString;
                                 aTemplate: AnsiString;
                                 aOnCloseQuery: TOnCloseQuery);
begin
  with DmxScroller_Form1 do
  begin
    Alias        := aTitle;
    Template     := aTemplate;
    OnCloseQuery := aOnCloseQuery;
  end;
end;

procedure TDm_InputBox.Refresh;
begin
  if DmxScroller_Form1.Active
  then CmRefreshExecute(SELF);
end;

function TDm_InputBox.GetActive: Boolean;
begin
  Result := DmxScroller_Form1.Active;
end;

procedure TDm_InputBox.SetActive(a_active: Boolean);
begin
  if a_active
  Then begin
         DmxScroller_Form1.Active:= a_active;
         DmxScroller_Form1.DoOnNewRecord_FillChar:=true;
         CmRefreshExecute(SELF);
       end
  else begin
         DmxScroller_Form1.Active := a_active;
       end;
end;

function TDm_InputBox.DmxScroller_Form1GetTemplate(aNext: PSItem): PSItem;
begin
  with DmxScroller_Form1 do
  begin
    if _Template  <> ''
    then Result := StringToSItem(_Template)
    else begin
           //Result := StringToSItem('~template não inicializado~'+^M+
           //                        '~ ~'+^M+
           //                        GetTemplate_CRUD_Buttons(CmNewRecord,CmUpdateRecord,CmLocate,CmDeleteRecord)+^M+
           //                        '~ ~'+^M+
           //                        '~ID:  ~\LLLLLL'+chFN+'id'+^M+
           //                        '~Nome:~\ssssss'+chFN+'nome'+^M+
           //                        '~ ~'+^M+
           //                        GetTemplate_DbNavigator_Buttons(CmGoBof,CmNextRecord,CmPrevRecord,CmGoEof,CmRefresh)+^M+
           //                         '~ ~'+^M);
           Result := StringToSItem('~template não inicializado~'+^M+
                                   '~ ~'+^M+
                                   '~        ~~Ok~'+ChEA+CmOk
                                    );
         end;
  end;

end;

procedure TDm_InputBox.CmNewRecordExecute(Sender: TObject);
begin

end;

procedure TDm_InputBox.CmNextRecordExecute(Sender: TObject);
begin

end;

procedure TDm_InputBox.CmPrevRecordExecute(Sender: TObject);
begin

end;

procedure TDm_InputBox.CmRefreshExecute(Sender: TObject);
begin

end;

procedure TDm_InputBox.CmUpdateRecordExecute(Sender: TObject);
begin

end;

procedure TDm_InputBox.DataModuleCreate(Sender: TObject);
begin
  inherited;
  RemoveDataModule(Self);
  active := false;
  DmxScroller_Form1.Mi_ActionList := ActionList1;
end;

procedure TDm_InputBox.CmLocateExecute(Sender: TObject);
begin

end;

procedure TDm_InputBox.CmDeleteRecordExecute(Sender: TObject);
begin

end;

procedure TDm_InputBox.CmGoBofExecute(Sender: TObject);
begin

end;

procedure TDm_InputBox.CmGoEofExecute(Sender: TObject);
begin

end;



end.

