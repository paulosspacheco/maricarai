unit mi_rtl_ui_dmxscroller_form;
  {:< A unit **@name** implementa a classe TDmxScroller_Form.

    - Primeiro autor: Paulo Sérgio da Silva Pacheco paulosspacheco@@yahoo.com.br)

    - **VERSÃO**
      - Alpha - 0.7.1.621

    - **CÓDIGO FONTE**:
      - @html(<a href="../units/umi_ui_dmxscroller_form.pas">uMi_rtl_ui_Dmxscroller_form.pas</a>)

    - **HISTÓRICO**:
      - @html(<a href="../units/umi_ui_dmxscroller_form_historico.md">umi_ui_dmxscroller_form_historico.md</a>)

    - **PENDÊNCIAS**
      - T12 Documentar a unit.
      - T12 Criar propriedade UiDmxScroller_Buttons:TUiDmxScroller_Buttons

    - **CONCLUÍDO**
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

  }


{$mode Delphi}

interface

uses
  Classes, SysUtils
  //,controls
  //,ActnList
  ,typInfo
//  ,types
  ,mi.rtl.Consts
  ,mi_rtl_ui_Dmxscroller
//  ,mi_rtl_ui_DmxScroller_Buttons
//  ,mi_rtl_ui_Dmxscroller_sql

   ;

//Constantes publicas
{$include ./mi_rtl_ui_Dmxscroller_consts_inc.pas}

type
  { Os tipos abaixo foi declarado fora da classe TDmxScroller_Form_Atributos para
     que os componentes não derivados de TDmxScroller_Form_Atributos possam reconhece-los 
     sem declarar o nome da classe TDmxScroller_Form_Atributos.}

  TDmxFieldRec = mi_rtl_ui_Dmxscroller.TDmxFieldRec;
  pDmxFieldRec = mi_rtl_ui_Dmxscroller.pDmxFieldRec;
  SmallWord    = TUiDmxScroller.SmallWord;

  {: A class **@name** contém os atributos da class TDmxScroller_Form
  }

  { TDmxScroller_Form_Atributos }

  TDmxScroller_Form_Atributos = class(TUiDmxScroller)

    private FirstDataRow    : integer;
    private PrevRec         : integer;

    {: O atributo **@name** salva todos os rótulos e campos da lista de Templates

       - **MOTIVO**
         - A classe mãe TUiDmxScroller mãe da classe TDmxScroller_Form cria
           Template de apenas uma linha, a lista **@name** salva todas
           as linhas para geração de um Template do tipo formulário.
    }
    protected DMXFields : TFPList;

    {: Usado para evitar que RadiosButton sejam adicionados mais de uma vês em
       radiosgroups diferentes.
       - Mais informações veja campos FldRadioGrous.
    }
    protected FldRadioButtonsAdicionados:TStringList;

    {: O método **@name** inicia a documentação resumida do campo. aFldNum }
    Public Function SetHelpCtx_Hint(aFldNum:Integer;a_HelpCtx_Hint:AnsiString):pDmxFieldRec;override;

    {: O método **@name** inicia a documentação resumida do campo passado em :apDmxFieldRec}
    Public Procedure SetHelpCtx_Hint(apDmxFieldRec:pDmxFieldRec;a_HelpCtx_Hint:AnsiString);override;overload;


  end;

  { TDmxScroller_Form }
  {: A classe **@name** implementa a construção de formulários usando uma lista
     de Templates do tipo TDmxScroller}
  TDmxScroller_Form = class(TDmxScroller_Form_Atributos)
    {: Constrói o componente}
    public constructor Create(aOwner:TComponent);Override;

    public procedure AfterConstruction; override;

    {: Destrói o componente}
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

    protected   procedure UpdateBuffers_Controls;virtual;
    public procedure UpdateBuffers;override;

    {: A procedure **@name** seta a propriedade active e criar um formulário
       na plataforma alvo
    }
    protected procedure SetActiveTarget(aActive: Boolean);virtual;


    {$REGION --> Propriedade Active}

      {: A procedure **@name** seta a propriedade active  e criar um formulário
         LCL ou HTML dependendo do tipo de aplicação
      }
      protected procedure SetActive(aActive : Boolean);override;
    {$ENDREGION --> Propriedade Active}


    published property name;
    published property Alias;
    published property Strings;
    published property OnAddTemplate;
    Published property OnNewRecord;
    published Property onCloseQuery;
    published Property onEnter;
    published Property onExit;
    published Property onEnterField;
    published Property onExitField;
    published property onGetTemplate;
    published property Active;
    published property AlignmentLabels;
//    published property ActionList;
//    published Property ParentLCL;
//    published property DataSource;
  end;

procedure Register;

implementation

const
  vidis : boolean = false;

procedure Register;
begin
  RegisterComponents('Mi.rtl', [TDmxScroller_Form]);
end;

{ TDmxScroller_Form_Atributos }

function TDmxScroller_Form_Atributos.SetHelpCtx_Hint(aFldNum: Integer;a_HelpCtx_Hint: AnsiString): pDmxFieldRec;
begin
  result := inherited SetHelpCtx_Hint(aFldNum, a_HelpCtx_Hint);
end;

procedure TDmxScroller_Form_Atributos.SetHelpCtx_Hint(apDmxFieldRec: pDmxFieldRec; a_HelpCtx_Hint: AnsiString);
begin
  inherited SetHelpCtx_Hint(apDmxFieldRec,a_HelpCtx_Hint);
end;

constructor TDmxScroller_Form.Create(aOwner: TComponent);

begin
  inherited Create(aowner);
  _active := false;
end;

procedure TDmxScroller_Form.AfterConstruction;
begin
  inherited AfterConstruction;

  //Não posso livrar um componente aqui.
  //If MessageDlg('Confirme','Teste de cancelar se algo não sai como eu quero'+^M+
  //            ^M+
  //            'Aborta o componente?'
  //            ,MtConfirmation,[mbYes, mbNo, mbIgnore],0,mbNo)= MrYes
  //then raise TException.create('cancelado');
end;

destructor TDmxScroller_Form.destroy;
begin
  if getState(Mb_St_Active)
  then begin
         active := false;
         if active
         Then Raise TException(ParametroInvalido);
         inherited destroy;
       end
  else inherited destroy;
end;

procedure TDmxScroller_Form.CreateStruct(var ATemplate: PSItem);
  var
    Items      : PSItem;
    i,Lim      : integer;
    AllZ       : boolean;
    S          : tString;
    First : pDmxFieldRec;

begin
  //Move(tString(ATemplate)[1], Items, sizeof(Items));
  Items := ATemplate;

  If (Items = nil)
  then Exit;

  //p := Items;
  //i := 0;
  //while p<>nil do
  //begin
  //  if p^.Value <> nil
  //  then writeln(Format('Item %d = %s',[i,P^.Value^]));
  //  p := p.next;
  //  inc(i);
  //end;


  FirstDataRow := -1;
  AllZ := (Items.Value <> nil) and
          (Items.Value^[1] = CharAllZeroes);

  DMXFields := TFPList.Create;
  FldRadioButtonsAdicionados := TStringList.create;

  i := 0;
  Lim := 0;
//  DMXField1 := nil;
  First := DMXField1;

  Self.CurrentRecord := -1;    //itms
  Items := ATemplate;
  While (Items <> nil)  do
  begin
    DMXField1 := nil;
    Self.CurrentRecord := Self.CurrentRecord +1; //itms
    Limit.X := 0;

    If (Items^.Value = nil) or (Items^.Value^ = '') or (Items^.Value^ = CharAllZeroes)
    then S := ' '
    else S := Items.Value^;

    If AllZ and (length(S) < pred(sizeof(S)))
    then Insert(CharAllZeroes, S, 1);

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

    //DMXFields^[i] := DMXField1;
    DMXFields.Add(DMXField1);
    Inc(i);
    Items := Items.Next;
  end;

  Limit.X := Lim;

  DataBlockSize := RecordSize;
//  DataBlockSize := DataBlockSize * NumRows;
  DataBlockSize := DataBlockSize * Fields.Count;

  If (FirstDataRow >= 0)
  then CurrentRecord := FirstDataRow;

  //DMXField1 := DMXFields^[CurrentRecord];
  DMXField1 := DMXFields[CurrentRecord];

  PrevRec := -1;
end;

procedure TDmxScroller_Form.DestroyStruct;
  var
    i   : integer;
begin
  If (DMXFields = nil)
  then Exit;

  if _BufDataset <> nil
  then BufDataset := nil ;

  i := DMXFields.Count;
  While (i > 0) do
  begin
    DMXField1 := DMXFields[pred(i)];
    If (DMXField1 <> nil)
    then Inherited DestroyStruct;
    Dec(i);
  end;
  freeAndNil(DMXFields);
  FreeAndNil(FldRadioButtonsAdicionados);
  DestroyData;
end;


function TDmxScroller_Form.GetTemplate(aNext: PSItem): PSItem;
  //Var
  //  s : AnsiString;
begin
  if Assigned(onAddTemplate)
  then begin
         //Executa o evento definido em tempo de desenho.
         onAddTemplate(Self);
         result := Strings.PListSItem;
         //s := Strings.Text;
         //if length(s)>0
         //Then Result := StringToSItem(s,254)
         //else Result := nil;
       End
  else If Strings.Count >0 //Temĺate criado em dempo de projeto.
       then begin
              result := Strings.PListSItem;
              //s := Strings.Text;
              //if length(s)>0
              //Then Result := StringToSItem(s,254)
              //else result := aNext;
            end
       else result := aNext;

  if Assigned(onGetTemplate)
  then begin
         //Executa o evento definido em tempo de projeto.
         result := onGetTemplate(aNext);
       End;
end;

procedure TDmxScroller_Form.UpdateBuffers_Controls;
begin

end;

procedure TDmxScroller_Form.UpdateBuffers;
  Var i : integer;
      wCurrentField : pDmxFieldRec;
begin
  if not vidis then
  begin
    try
      vidis := true;
      wCurrentField := CurrentField;

      for i := 0 to DMXFields.Count-1 do
      begin
        CurrentField := DMXFields[i];
        while (CurrentField) <> nil do
        begin
          if (CurrentField^.Template <> nil)
             and (CurrentField^.Fieldnum<>0)
             and (CurrentField^.LinkEdit<>nil)
          then begin
                 UpdateBuffers_Controls;
               end;

          if CurrentField <> nil
          Then CurrentField := CurrentField^.Next;
        end;

        if CurrentField <> nil
        Then CurrentField := CurrentField^.Next;

      End;

    Finally
      CurrentField := wCurrentField;
      vidis := false;
    end;

  end;
end;

procedure TDmxScroller_Form.SetActiveTarget(aActive: Boolean);
begin

end;

procedure TDmxScroller_Form.SetActive(aActive: Boolean);
  Var CanClose : boolean;
begin
  if _Active
  then begin
         CanClose := true;
         DoOnCloseQuery (Self,CanClose) ;
         if CanClose
         then begin
                 if Assigned(onExit)
                 then OnExit(Self);

                 //Destruir os ponteiros da contrução anterior;
                 DestroyStruct;
                 SetState(Mb_St_Active,false);
                 _Active := false;
              End;
       end;

  //Criar um formulário da aplicação tipo LCL
  if (not Active) and aActive
  Then SetActiveTarget(aActive);
end;


end.

