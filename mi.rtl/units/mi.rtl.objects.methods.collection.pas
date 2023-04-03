unit mi.rtl.Objects.Methods.Collection;
{:< - A Unit **@name** implementa a classe **TCollection** do  pacote **mi.rtl**.

  - **NOTAS**
    - Esta unit foi testada nas plataformas: linux.

  - **VERSÃO**
    - Alpha - 0.7.0.0

  - **CÓDIGO FONTE**:
    - @html(<a href="../units/mi.rtl.objects.TCollection.pas">mi.rtl.objects.TCollection.pas</a>)

  - **HISTÓRICO**
    - Criado por: Paulo Sérgio da Silva Pacheco e-mail: paulosspacheco@@yahoo.com.br
      - **20/11/2021** 10:12 a 22:49 : Criada a classe @name

}
{$IFDEF FPC}
  {$MODE Delphi} {$H+}
{$ENDIF}


interface

uses
  Classes, SysUtils
  ,mi.rtl.objects.Methods
  ,mi.rtl.objects.methods.StreamBase.Stream;


  //TStream = Class (TNSComponent {TClass})
  {: - A class **@name** implementa coleções no pacote **mi.rtl**.
  }
  type
  TCollection =
  class(TObjectsMethods)
      type TStream = mi.rtl.objects.methods.StreamBase.Stream.TStream;

    //Atributos privados  
      Private _Count: Sw_Integer;             {:< Item count }            

    //Atributos Publicos
      Public var Items: PItemList;            {:< Item list pointer }            
      Public var State          : Longint;
      
      Public Limit: Sw_Integer;               {:< Item limit count }            
      Public Delta: Sw_Integer;               {:< Inc delta size }            

      Public Status    : Integer;             {:< TCollection status }            
      Public ErrorInfo : Integer;             {:< TCollection error info }            
    
    //Constructor / Destructor 
      Public constructor Create(ALimit, ADelta: Sw_Integer);overload; virtual;
//      Public constructor Load(Var S: tStream );
      Public destructor Destroy; Override;

    // Métodos Publicos Virtuais
      protected function IndexOf (Item: Pointer): Sw_Integer;                  Virtual;
      protected function GetItem (Var S: tStream ): Pointer;                    Virtual;
      protected procedure Insert (Item: Pointer);                              Virtual;
      protected procedure FreeItem (Item: Pointer);                            Virtual;
      protected procedure SetLimit (ALimit: Sw_Integer);                       Virtual;
      protected procedure Error (Code, Info: Integer);                         Virtual;
      protected procedure PutItem (Var S: tStream ; Item: Pointer);             Virtual;

    // Métodos Publicos PP
      Public procedure Create_Progress1Passo(ATitle : tstring;Obs:tstring ; ATotal : Longint);Virtual;
      Public procedure Set_Progress1Passo(aNumber : Longint);Virtual;
      Public procedure Destroy_Progress1Passo; Virtual;
      Public function MessageBox(const Msg: AnsiString): Word;Virtual;

    // Métodos Publicos PP
      Public function At (Index: Sw_Integer): Pointer;
          //Public function LastThat (Test: Pointer): Pointer;
      Public function LastThat (Test: TCallbackFunBoolParam): Pointer;
      Public function FirstThat (Test: Pointer): Pointer;
      Public procedure Pack;
      Public procedure FreeAll;Virtual;{PauloSSPacheco}
      Public procedure DeleteAll;
      Public procedure Free (Item: Pointer);
      Public procedure Delete (Item: Pointer);
      Public procedure AtFree (Index: Sw_Integer);
      Public procedure AtDelete (Index: Sw_Integer);
      Public procedure ForEach (Action: Pointer);
      Public procedure AtPut (Index: Sw_Integer; Item: Pointer);
      Public procedure AtInsert (Index: Sw_Integer; Item: Pointer);
//      Public procedure Store (Var S: tStream );

    // Método published
      Published Property Count: Sw_Integer 
                Read _Count write _Count;     {:< Item count }            

  end;

implementation

  CONSTRUCTOR TCollection.Create (ALimit, ADelta: Sw_Integer);
  BEGIN
    Inherited Create(nil);                             { Call ancestor }
    //Alias := 'TCollection.Create()';
    Delta := ADelta;                                   { Set increment }
    SetLimit(ALimit);                                  { Set limit }
  END;

  {--TCollection--------------------------------------------------------------}
  {  Load ->             }
  {---------------------------------------------------------------------------}
  //CONSTRUCTOR TCollection.Load (Var S: tStream );
  //
  //BEGIN
  //  abstract;
  //END;

  {--TCollection--------------------------------------------------------------}
  {  Destroy ->             }
  {---------------------------------------------------------------------------}
  destructor TCollection.Destroy;
  BEGIN
    FreeAll;                                           { Free all items }
    SetLimit(0);                                       { Release all memory }
    State := 0;
    Inherited Destroy;
  END;

  {--TCollection--------------------------------------------------------------}
  {  At ->                 }
  {---------------------------------------------------------------------------}
  function TCollection.At (Index: Sw_Integer): Pointer;
  BEGIN
    If (Index < 0) OR (Index >= Count) Then Begin      { Invalid index }
      Error(coIndexError, Index);                      { Call error }
      At := Nil;                                       { Return nil }
    End Else At := Items^[Index];                      { Return item }
  END;

  {--TCollection--------------------------------------------------------------}

  function TCollection.IndexOf (Item: Pointer): Sw_Integer;
  VAR I: Sw_Integer;
  BEGIN
    If (Count > 0) Then Begin                          { Count is positive }
      For I := 0 To Count-1 Do                         { For each item }
        If (Items^[I] = Item) Then Begin               { Look for match }
          IndexOf := I;                                { Return index }
          Exit;                                        { Now exit }
        End;
    End;
    IndexOf := -1;                                     { Return index }
  END;

  {--TCollection--------------------------------------------------------------}

  function TCollection.GetItem (Var S: tStream ): Pointer;
  BEGIN
    GetItem := S.Get;                                  { Item off stream }
  END;


  {--TCollection--------------------------------------------------------------}
  
  function TCollection.LastThat (Test: TCallbackFunBoolParam): Pointer;
  VAR I: LongInt;

  BEGIN
    For I := Count DownTo 1 Do
      Begin                   { Down from last item }
        IF Boolean(Byte(ptrUint(CallPointerLocal(Test,
          { On most systems, locals are accessed relative to base pointer,
            but for MIPS cpu, they are accessed relative to stack pointer.
            This needs adaptation for so low level routines,
            like MethodPointerLocal and related objects unit functions. }
  {$ifndef FPC_LOCALS_ARE_STACK_REG_RELATIVE}
          get_caller_frame(get_frame,get_pc_addr)
  {$else}
          get_frame
  {$endif}
          ,Items^[I-1])))) THEN
        Begin          { Test each item }
          LastThat := Items^[I-1];                     { Return item }
          Exit;                                        { Now exit }
        End;
      End;
    LastThat := Nil;                                   { None passed test }
  END;

  {//function TCollection.LastThat (Test: Pointer): Pointer;
  VAR I: LongInt;
  BEGIN

    For I := Count DownTo 1 Do
      Begin                   // Down from last item
        if Boolean(mi.use32.word(CallPointerLocal(Test,PreviousFramePointer,Items^[I-1]))) THEN
        Begin          // Test each item
          LastThat := Items^[I-1];                     // Return item
          Exit;                                        // Now exit
        End;
      End;
    LastThat := Nil;                                   // None passed test
  END;
  }


  {--TCollection--------------------------------------------------------------}
  {  FirstThat ->         }
  {---------------------------------------------------------------------------}
  function TCollection.FirstThat (Test: TCallbackFunBoolParam): Pointer;
  VAR I: LongInt;
  BEGIN
    For I := 1 To Count Do
    Begin { Acima do primeiro item }
      { Na maioria dos sistemas, os locais são acessados em relação ao ponteiro base,
        mas para CPU MIPS, eles são acessados em relação ao ponteiro de pilha.
        Isso precisa de adaptação para rotinas de nível tão baixo,
        como MethodPointerLocal e funções de unidade de objetos relacionados. }

      IF Boolean(Byte(ptrUint(CallPointerLocal(Test,
          {$ifndef FPC_LOCALS_ARE_STACK_REG_RELATIVE}
                  get_caller_frame(get_frame,get_pc_addr)
          {$else}
                  get_frame
          {$endif}
          ,Items^[I-1]))))
      then Begin          { Test each item }
             FirstThat := Items^[I-1];                      { Return item }
             Exit;                                          { Now exit }
           End;
    End;
    FirstThat := Nil;                                  { None passed test }
  END;

  {function TCollection.FirstThat (Test: Pointer): Pointer;
  VAR I: LongInt;
  BEGIN
    For I := 1 To Count Do Begin                       // Up from first item
      IF Boolean(Longword(CallPointerLocal(Test,PreviousFramePointer,Items^[I-1]))) THEN
        Begin          // Test each item
        FirstThat := Items^[I-1];                      // Return item
        Exit;                                          // Now exit
      End;
    End;
    FirstThat := Nil;                                  // None passed test
  END;}


  {--TCollection--------------------------------------------------------------}
  {  Pack ->             }
  {---------------------------------------------------------------------------}
  procedure TCollection.Pack;
  VAR I, J: Sw_Integer;
  BEGIN
    I := 0;                                            { Initialize dest }
    J := 0;                                            { Initialize test }
    While (I < Count) AND (J < Limit) Do Begin         { Check fully packed }
      If (Items^[J] <> Nil) Then Begin                 { Found a valid item }
        If (I <> J) Then Begin
          Items^[I] := Items^[J];                      { Transfer item }
          Items^[J] := Nil;                            { Now clear old item }
        End;
        Inc(I);                                        { One item packed }
      End;
      Inc(J);                                          { Next item to test }
    End;
    If (I < Count) Then Count := I;                    { New packed count }
  END;

  {--TCollection--------------------------------------------------------------}
  {  FreeAll ->          }
  {---------------------------------------------------------------------------}
  procedure TCollection.FreeAll;
  VAR I: Sw_Integer;
  BEGIN
  {   For I := 0 To Count-1 Do FreeItem(At(I));}          { Release each item }
    {Obs: FreeAll deve ser destruido na ordem inversa de criacao. Motivo Item[i+1] pode se reportar ao item[i]}

      I := Count-1;
      While  i >=0  Do
      Begin
        Try
          FreeItem(At(I));        { Release each item }
        Except
        end;

        Dec(i);
      End;
      Count := 0;                                          { Clear item count }

  END;

  {--TCollection--------------------------------------------------------------}
  {  DeleteAll ->        }
  {---------------------------------------------------------------------------}
  procedure TCollection.DeleteAll;
  BEGIN
    Count := 0;                                        { Clear item count }
  END;

  {--TCollection--------------------------------------------------------------}
  {  Free ->             }
  {---------------------------------------------------------------------------}
  procedure TCollection.Free (Item: Pointer);
  BEGIN
    Try
    Delete(Item);                                      { Delete from list }
    Except
    end;

    Try
      FreeItem(Item);                                    { Free the item }
    Except
    end;
  END;

  {--TCollection--------------------------------------------------------------}
  {  Insert ->           }
  {---------------------------------------------------------------------------}
  procedure TCollection.Insert (Item: Pointer);
  BEGIN
    AtInsert(Self.Count, Item);                             { Insert item }
  END;

  {--TCollection--------------------------------------------------------------}
  {  Delete ->           }
  {---------------------------------------------------------------------------}
  procedure TCollection.Delete (Item: Pointer);
  BEGIN
    Try
      AtDelete(IndexOf(Item));                           { Delete from list }
    Except
    end;
  END;

  {--TCollection--------------------------------------------------------------}
  {  AtFree ->           }
  {---------------------------------------------------------------------------}
  procedure TCollection.AtFree (Index: Sw_Integer);
  VAR Item: Pointer;
  BEGIN
    Try
      Item := At(Index);                                 { Retrieve item ptr }
      AtDelete(Index);                                   { Delete item }
      FreeItem(Item);                                    { Free the item }
    Except
    end;
  END;

  {--TCollection--------------------------------------------------------------}
  {  FreeItem ->         }
  {---------------------------------------------------------------------------}
  procedure TCollection.FreeItem (Item: Pointer);
  BEGIN
  //  Dispose of Class
    DISCARD(TObject(Item));
  END;

  {--TCollection--------------------------------------------------------------}
  {  AtDelete ->         }
  {---------------------------------------------------------------------------}
  procedure TCollection.AtDelete (Index: Sw_Integer);
  BEGIN
    If (Index >= 0) AND (Index < Count)
    Then Begin     { Valid index }
            {Dec(Count)}
            Count := Count -1; { One less item }

            If (Count > Index)
            Then Move(Items^[Index+1],Items^[Index], (Count-Index)*Sizeof(Pointer));  { Shuffle items down }
          End
    Else Error(coIndexError, Index);               { Index error }
  END;


  {--TCollection--------------------------------------------------------------}
  {  ForEach ->          }
  {---------------------------------------------------------------------------}
  {$PUSH}
  {$W+}
  procedure TCollection.ForEach (Action: TCallbackProcParam);
  VAR I: LongInt;
  BEGIN
    For I := 1 To Count Do                             { Up from first item }
      CallPointerLocal(Action,
        { On most systems, locals are accessed relative to base pointer,
          but for MIPS cpu, they are accessed relative to stack pointer.
          This needs adaptation for so low level routines,
          like MethodPointerLocal and related objects unit functions. }
  {$ifndef FPC_LOCALS_ARE_STACK_REG_RELATIVE}
        get_caller_frame(get_frame,get_pc_addr)
  {$else}
        get_frame
  {$endif}
        ,Items^[I-1]);   { Call with each item }
  END;
  {$POP}

  {procedure TCollection.ForEach (Action: Pointer);
  VAR I: LongInt;
  BEGIN
    For I := 1 To Count Do                             // Up from first item
      CallPointerLocal(Action,PreviousFramePointer,Items^[I-1]); // Call with each item
  END;      }

  {--TCollection--------------------------------------------------------------}
  {  SetLimit ->         }
  {---------------------------------------------------------------------------}
  procedure TCollection.SetLimit (ALimit: Sw_Integer);
  VAR
    AItems: PItemList;
  BEGIN

    If (ALimit < Count) Then
      ALimit := Count;
    If (ALimit > MaxCollectionSize) Then
      ALimit := MaxCollectionSize;
    If (ALimit <> Limit) Then
      Begin
        If (ALimit = 0) Then
          AItems := Nil
        Else
          Begin
            GetMem(AItems, ALimit * SizeOf(Pointer));
            If (AItems<>Nil) Then
              FillChar(AItems^,ALimit * SizeOf(Pointer), #0);
          End;
        If (AItems<>Nil) OR (ALimit=0) Then
          Begin
            If (AItems <>Nil) AND (Items <> Nil) Then
              Move(Items^, AItems^, Count*SizeOf(Pointer));
            If (Limit <> 0) AND (Items <> Nil) Then
              FreeMem(Items, Limit * SizeOf(Pointer));
          end;
        Items := AItems;
        Limit := ALimit;
    End;
  END;

  {--TCollection--------------------------------------------------------------}
  {  Error ->            }
  {---------------------------------------------------------------------------}
  procedure TCollection.Error (Code, Info: Integer);
    //https://wiki.lazarus.freepascal.org/RunError
  BEGIN
    Status   := Code;
    ErrorInfo := 212 - Code; 
    RunError(212 - Code);                              { Run error }
  END;

  {--TCollection--------------------------------------------------------------}
  {  AtPut ->            }
  {---------------------------------------------------------------------------}
  procedure TCollection.AtPut (Index: Sw_Integer; Item: Pointer);
  BEGIN
    If (Index >= 0) AND (Index < Count) Then           { Index valid }
      Items^[Index] := Item                            { Put item in index }
      Else Error(coIndexError, Index);                 { Index error }
  END;

  {--TCollection--------------------------------------------------------------}
  {  AtInsert ->         }
  {---------------------------------------------------------------------------}
  procedure TCollection.AtInsert (Index: Sw_Integer; Item: Pointer);
  VAR I: Sw_Integer;
  BEGIN
    If (Index >= 0) AND (Index <= Count) Then Begin    { Valid index }
      If (Count=Limit) Then SetLimit(Limit+Delta);     { Expand size if able }
      If (Limit>Count) Then Begin
        If (Index < Count) Then Begin                  { Not last item }
          For I := Count-1 DownTo Index Do               { Start from back }
            Items^[I+1] := Items^[I];                  { Move each item }
        End;
        Items^[Index] := Item;                         { Put item in list }
        {Inc(Count)} Count := Count +1;                { Inc count }
      End Else Error(coOverflow, Index);               { Expand failed }
    End Else Error(coIndexError, Index);               { Index error }
  END;

  {--TCollection--------------------------------------------------------------}
  {  Store ->            }
  {---------------------------------------------------------------------------}
  //procedure TCollection.Store (Var S: tStream );
  //
  //  procedure DoPutItem (P: Pointer); {$IFNDEF FPC} FAR;{$ENDIF}
  //  BEGIN
  //    PutItem(S, P);                                   { Put item on stream }
  //  END;
  //
  //BEGIN
  //  S.Write(_Count, Sizeof(Count));                    { Write count }
  //  S.Write(Limit, Sizeof(Limit));                     { Write limit }
  //  S.Write(Delta, Sizeof(Delta));                     { Write delta }
  //  ForEach(@DoPutItem);                               { Each item to stream }
  //END;

  {--TCollection--------------------------------------------------------------}
  {  PutItem ->          }
  {---------------------------------------------------------------------------}
  procedure TCollection.PutItem (Var S: tStream ; Item: Pointer);
  BEGIN
    S.Put(Item);                                       { Put item on stream }
  END;

  procedure TCollection.Create_Progress1Passo(ATitle : tstring;Obs:tstring ; ATotal : Longint);
  Begin
  end;

  procedure TCollection.Set_Progress1Passo(aNumber : Longint);
  Begin
  end;

  procedure TCollection.Destroy_Progress1Passo;
  Begin
  end;

  function TCollection.MessageBox(const Msg: AnsiString): Word;
  Begin
  result := 0;
  end;




end.

