{: - A unit **@name** implementa a classe TProgressDlg_If do pacote mi.rtl.

    - **VERSÃO**:
      - Alpha - 0.7.1.621

    - **CÓDIGO FONTE**:
      - @html(<a href="../units/mi.rtl.objects.methods.tprogressdlg_if.pas">mi.rtl.objects.methods.tprogressdlg_if.pas</a>)

    - **HISTÓRICO**
      - Criado por: Paulo Sérgio da Silva Pacheco e-mail: paulosspacheco@@yahoo.com.br
        - 2021-12-18
          - 14:42 15:30 - T12 Criar a unit **@name** e a classe **Tprogressdlg_if**

        - 2021-12-21
          - 8:27 a xx - T21 documentar a classe **TProgressDlg_If**
}
unit mi.rtl.Objects.Consts.ProgressDlg_If;


{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface
   Uses
     Classes,
     drivers,
     DOS,
     LazarusPackageIntf,
     mi.rtl.objects.consts
     ;
  type

    {: - A classe **@name** é uma classe abstrata para comunicação com o usuário
           cujo a implementação deve ser feita nas plataformas: LCL, HTML e  JavaScript.

       - **NOTA**
         - Só cria o dialogo se a posição chegar no delta.

       - Exemplo do uso de TProgressDlg_If

          ```pascal

            Var
              ProgressDlg_If : TProgressDlg_If;
            Begin
              ProgressDlg_If := TProgressDlg_If.Create('Pesquisando registro',Alias,20);

              Repeat
                ProgressDlg_If.IncPosition;
              Until Not next;

              ProgressDlg_If.Free;
            end.
          ```
    }
    TProgressDlg_If = class(TObjectsConsts)
      Private Var _Okprocessing : Boolean ; //:< Salva o estado da variável Okprocessing
      private Var Position       : longint;

      private Var wSysCtrlSleep_Enable : Boolean;
      private Var _ProgressDlg    : TComponent;//:< Salva o component criado por .Create para ser destruido por .destroy

      {$REGION ' ---> Property Total : Longint '}
        strict Private Var _Total : Longint;
        Protected procedure Set_Total(aTotal: Longint);Virtual;
        {: A propriedade **@name** é o total de elementos previstos na lista ao inicial o dialogo }
        Published property  Total: Longint Read _Total   Write  Set_Total;
      {$ENDREGION}

      {$REGION ' ---> Property Delta : Longint '}
        strict Private Var _Delta : Longint;
        Protected procedure Set_Delta(aDelta: Longint);Virtual;
        {: A propriedade **@name** informado ao dialogo o intervalo no qual o dialogo precisa ser criado para que o usuário veja a previsão de termino.}
        Published property  Delta: Longint Read _Delta   Write  Set_Delta;
      {$ENDREGION}

      {$REGION ' ---> Property Limit : Longint '}
        strict Private Var _Limit : Longint;
        Protected procedure Set_Limit(aLimit: Longint);Virtual;
        {: A propriedade **@name** é o numero de linhas do controle que está sendo visualizado. }
        Published  property  Limit: Longint Read _Limit   Write  Set_Limit;
      {$ENDREGION}

      {$REGION ' ---> Property Title : AnsiString '}
        strict Private Var _Title : AnsiString;
        Protected procedure Set_Title(aTitle: AnsiString);Virtual;
        {: A propriedade **@name** é usado no título do dialogo indicando a tarefa que está sendo executada.}
        Published property  Title: AnsiString Read _Title   Write  Set_Title;
      {$ENDREGION}

      {$REGION ' ---> Property observation : AnsiString '}
        strict Private Var _observation : AnsiString;
        Protected procedure Set_observation(aobservation: AnsiString);Virtual;
        {: A propriedade **@name** é usado na barra de status do dialogo indicando qual o atalho aborta a operação}
        Published property  observation: AnsiString Read _observation   Write  Set_observation;
      {$ENDREGION}

      {$REGION ' ---> Property onCreate_ProgressDlg : TCreate_ProgressDlg '}
         Type TCreate_ProgressDlg = Function (Sender: TProgressDlg_If;
                                              Var aTitle      : AnsiString;
                                              Var aobservation : AnsiString;
                                              Var aDelta      : longint;
                                              Var aTotal      : longint
                                             ):TComponent of object;

          strict Private Var _onCreate_ProgressDlg : TCreate_ProgressDlg;
          {: A propriedade **@name** deve ser implementado no pacote visual ou seja: Na interface do usuário que pode ser **LCL**, Javascript, tv32 etc..}
          Published  property  onCreate_ProgressDlg: TCreate_ProgressDlg Read _onCreate_ProgressDlg   Write  _onCreate_ProgressDlg;
      {$ENDREGION}

      {: A procedure **@name** deve ser anulada para implementar a criação do diálogo no pacote visual ou seja: Na interface do usuário que pode ser **LCL**, Javascript, tv32 etc..}
      Public Procedure Create_ProgressDlg;overload;Virtual;

      {: A procedure **@name** deve ser anulada para implementar os eventos desta classe caso a mesma não esteja registrada na IDE }  
      Protected Procedure RegisterOnEvents;Virtual; // unimplemented;
      
      {: O constructor **@name** é necessário porque essa classe pode ser registrada da IDE}
      public constructor Create(AOwner: TComponent);Overload;override;

     {: O constructor **@name** é usado para criar a classe sem a IDE}
      Public constructor Create(aTitle    : AnsiString;
                           aobservation      : AnsiString;
                           aDelta,
                           aTotal    : longint
                           );Overload;Virtual;
      {: O destructor **@name** é usado para destruir a classe.} 
      Destructor Destroy;Override;

      {$REGION ' ---> Property onIncPosition_01 : TIncPosition_01 '}
         Type TIncPosition_01 = procedure (Const aDelta :longint) Of object;
         strict Private Var _onIncPosition_01 : TIncPosition_01;
         {: A propriedade **@name** deve ser implementada na classe visual para incrementar aDelta na posição atual do processamento. }
         Published property  onIncPosition_01: TIncPosition_01 Read _onIncPosition_01   Write  _onIncPosition_01;
      {$ENDREGION}

      {: A propriedade **@name** deve ser anulada na classe visual para incrementar **aDelta** na posição atual do processamento. }
      Public procedure IncPosition(Const aDelta :longint);Overload;Virtual;

      {$REGION ' ---> Property onIncPosition : TIncPosition '}
        Type TIncPosition = procedure  of Object;
          strict Private Var _onIncPosition : TIncPosition;
          {: A propriedade **@name** deve ser implementada na classe visual para incrementar 1 na posição atual do processamento. }
          Published property  onIncPosition: TIncPosition Read _onIncPosition   Write  _onIncPosition;
      {$ENDREGION}

      {: A propriedade **@name** deve ser anulada na classe visual para incrementar 1 na posição atual do processamento. }
      Public procedure IncPosition;Overload;Virtual;

      {$REGION ' ---> Property OnRedraw : TRedraw '}
        {: O evento **@name** é usado para atualiza a tela.}
        Type TRedraw = procedure (a_Total        : longint;
                                  a_LastPosition : longint;
                                  a_TimeCurrent  : Longint; //:< - Tempo transcorrido
                                  a_TimeBegin    : Longint; //:< - Tempo inicial
                                  a_TimeForeseen : Longint; //:< - Tempo previsto
                                  a_Percent      : SmallInt //:< - Percentual  0..100%
                                 ) of object;

        strict Private Var _OnRedraw : TRedraw;
        {: A propriedade **@name** deve ser implementada na classe visual para atualizar a tela com a posição atual do processamento. }
        Published  property  OnRedraw: TRedraw Read _OnRedraw   Write  _OnRedraw;
      {$ENDREGION}

      {: A propriedade **@name** deve ser anulada para implementar na classe visual para atualizar a tela com a posição atual do processamento. }
      Protected Procedure Redraw;Virtual;

      Private    Var _LastPosition : longint;
      protected  Var _TimeCurrent  : Longint; // tempo transcorrido 
      protected  Var _TimeBegin    : Longint; // tempo inicial  
      protected  Var _TimeForeseen : Longint; //tempo previsto 
      protected  Var _Percent      : SmallInt; // 0..100%

      {: A procedure **@name** é usado para informar ao dialogo a posição atual da contagem. 

         - **NOTA**
           - Calcula o percentual atual do processamento.}
      Public procedure SetPerc(const aPosition : longint);
    end;

    Type
      TProgressDlg_If_Class = Class of TProgressDlg_If;



procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Mi.Rtl', [TProgressDlg_If]);
end;


//function KeyIsDown(const Key: integer): boolean;
//begin
//
//  Result := GetKeyState(Key) and 128 > 0;
//end;

procedure TProgressDlg_If.Set_Total(aTotal: Longint);
begin
  if ATotal = 0
  then _Total := 1
  else _Total := ATotal;

  Try
    If Total > 1
    Then Limit :=  Longint(Round(0.025 * Total))
    Else Limit := 1;
  Except
    Limit := 10;
  end;
end;

Function GetFTimeDos:Longint;Overload;
Var
  DiaDaSemana ,Sec100 : Word;
  Time                : DateTime;
  TimePack            : Longint;
Begin
  With Time do
  Begin
    GetDate(Year,Month,Day,DiaDaSemana);
    GetTime(Hour,Min  ,Sec,Sec100);
  End;
  PackTime(Time,TimePack); {Obs: Sec100 nao e compactada. }
  GetFTimeDos := TimePack;
End;

procedure TProgressDlg_If.SetPerc(const aPosition: Integer);
begin
  try
    if (aPosition - _LastPosition) < Limit
    then Begin
           if aPosition > 1
           then Exit;
         End;

    _LastPosition := aPosition;
    Try
      _TimeCurrent  := GetFTimeDos - _TimeBegin;
      If aPosition >0
      Then _TimeForeseen := Longint(Trunc((_TimeCurrent/ aPosition) * Total)) //Calculo da posição prevista.
      else _TimeForeseen :=  0;

    Except
    end;

    if aPosition >= Total then
     begin
       _Percent := 100;
     end
     else
     begin
       _Percent := (aPosition*100) div Total;
     end;
     Redraw;
  Except
  end;
end;

procedure TProgressDlg_If.Set_Delta(aDelta: Longint);
Begin
  Self._Delta := aDelta;
End;

procedure TProgressDlg_If.Set_Limit(aLimit: Longint);
Begin
  Self._Limit := aLimit;
End;

procedure TProgressDlg_If.Set_Title(aTitle: AnsiString);
Begin
  Self._Title := aTitle;
End;

procedure TProgressDlg_If.Set_observation(aobservation: AnsiString);
Begin
  Self._observation := aobservation;
End;

constructor TProgressDlg_If.Create(AOwner: TComponent);
begin
  Inherited create(AOwner);
  Create('Title Progresse','Observação',10,100);
end;

Constructor TProgressDlg_If.Create(aTitle : AnsiString;aobservation      : AnsiString; aDelta   : longint;aTotal    : longint);
Begin
  if owner=nil
  then inherited Create(nil);
  Alias := ClassName+'.Create()';
 ;
//  if _application <> nil Then _Application.GetCommands(wCommands);

  CtrlBreakHit := False;
  Delta  := aDelta;


  observation    := aobservation;
  _TimeBegin    := GetFTimeDos;   // tempo inicial
  _Okprocessing := SetOkprocessing(True);

  RegisterOnEvents; //Seta OnCreate_ProgressDlg
  Create_ProgressDlg;
  RegisterOnEvents; //Necessário pq Create_ProgressDlg cria a classe visual

  Title  := aTitle ;

  if aTotal > 0
  then Total  := aTotal
  else Total  := 0;

  If Total < Delta
  Then Total  := Delta * 2;

  redraw;
end;

Procedure TProgressDlg_If.Create_ProgressDlg();
begin
  freeandnil(_ProgressDlg);
  if @onCreate_ProgressDlg<>nil
  then _ProgressDlg := onCreate_ProgressDlg(Self,
                                            _Title,
                                            _observation,
                                            _Delta,
                                            _Total
                                            );
end;

Destructor TProgressDlg_If.Destroy;
Begin
  SetOkprocessing(_Okprocessing);
  Inherited Destroy;
//  If _application <> nil Then _Application.SetCommands(wCommands);
end;

procedure TProgressDlg_If.IncPosition(Const aDelta :longint);
Begin
  Inc(Position,aDelta);
  if @onIncPosition_01<>nil
  then onIncPosition_01(aDelta);
  SetPerc(Position);
end;

procedure TProgressDlg_If.IncPosition;
Begin
  Inc(Position,1);
  if @onIncPosition<>nil
  then onIncPosition;
  SetPerc(Position);
end;

procedure TProgressDlg_If.Redraw;
begin
  if @OnRedraw<>nil
  then onRedraw(_Total,
                _LastPosition,
                _TimeCurrent,   // tempo transcorrido  // Nortsoft
                _TimeBegin    , // tempo inicial  // Nortsoft
                _TimeForeseen , //tempo previsto // Nortsoft
                _Percent           {* 0..100% *}
                );
end;

procedure TProgressDlg_If.RegisterOnEvents;//unimplemented;
begin
  //Deve ser redefinido para registrar os eventos:
//  onCreate_ProgressDlg := nil;
//  onIncPosition_01     := nil;
//  onIncPosition        := nil;
//  OnRedraw             := nil;
end;



end.
