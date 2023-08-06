unit mi.rtl.Objects.Methods.Collection.SortedCollection.StrCollection;
  {:< - A Unit **@name** implementa a classe **TStrCollection** do  pacote **mi.rtl**.

      - **NOTA**
        - A diferença de tstringCollection para TStrCollection é que a primeira é uma coleção de shortstring e a segunda é
          uma coleção de PByteArray usada para trabalhar com AnsiString;


      - **VERSÃO**
        - Alpha - Alpha - 0.8.0

      - **CÓDIGO FONTE**:
        - @html(<a href="../units/mi.rtl.objects.tcollection.tsortedcollection.tstrcollection.pas">mi.rtl.objects.tcollection.tsortedcollection.tstrcollection.pas</a> )

      - **HISTÓRICO**
        - Criado por: Paulo Sérgio da Silva Pacheco e-mail: paulosspacheco@@yahoo.com.br
          - **30/11/2021**
            - 11:47 a 11:47 : Criada a unit @name e a classe **TStCollection**
            - 14:00 a 14:20 : Documentar a unit


  }
  {$IFDEF FPC}
    {$MODE Delphi} {$H+}
  {$ENDIF}




  interface

  uses
    Classes, SysUtils,
    mi.rtl.objects.Methods.Collection.SortedCollection,
    mi.rtl.objects.methods.Streambase.Stream;


  type
    {: A classe **@name** implementa uma coleção de **AnsiString**
    }
    TStrCollection = Class (TSortedCollection)
      protected FUNCTION Compare (Key1, Key2: Pointer): Sw_Integer;         Override;
      public FUNCTION GetItem (Var S: TStream): Pointer;                    Override;
      protected PROCEDURE FreeItem (Item: Pointer);                         Override;
      protected PROCEDURE PutItem (Var S: TStream; Item: Pointer);          Override;
     END;

  type
    {: A classe **@name** implementa uma coleção de **AnsiString** na ordem original de inserção das AnsiStrings
    }
    TUnSortedStrCollection = Class (TStrCollection)
        PROCEDURE Insert (Item: Pointer);                              Override;
    END;



implementation


  {+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++}
  {                       TStrCollection Class METHODS                       }
  {+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++}

  FUNCTION TStrCollection.Compare (Key1, Key2: Pointer): Sw_Integer;
     VAR
       I,
       J : Sw_Integer;
       P1,
       P2: PByteArray;
  BEGIN
     P1 := PByteArray(Key1);                            { PAnsiChar 1 pointer }
     P2 := PByteArray(Key2);                            { PAnsiChar 2 pointer }

     I := 0;                                            { Preset no size }

     If (P1 <> Nil) Then
       While (P1^[I] <> 0) Do Inc(I);                   { PAnsiChar 1 length }

     J := 0;                                            { Preset no size }

     If (P2 <> Nil) Then
       While (P2^[J] <> 0) Do Inc(J);                   {PAnsiChar 2 length }

     If (I < J) Then J := I;                            { Shortest length }

     I := 0;                                            { First AnsiCharacter }

     While (I < J) AND (P1^[I] = P2^[I]) Do Inc(I);     { Scan till fail }

     If (P1^[I] = P2^[I]) Then                          { tstrings equal }
       Compare := 0
     Else
       If (P1^[I] < P2^[I]) Then                        {: String1 < String2 }
         Compare := -1
       Else
         Compare := 1;                                 { String1 > String2 }
  END;

  FUNCTION TStrCollection.GetItem (Var S: TStream): Pointer;
  BEGIN
     GetItem := S.StrRead;                              { Get string item }
  END;

  PROCEDURE TStrCollection.FreeItem (Item: Pointer);
    VAR
      I: Sw_Integer;
      P: PByteArray;
  BEGIN
     Try
       If (Item <> Nil) Then Begin                        { Item is valid }
         P := PByteArray(Item);                           { Create byte pointer }
         I := 0;                                          { Preset no size }
         While (P^[I] <> 0) Do Inc(I);                    { Find PAnsiChar end }
         FreeMem(Item, I+1);                              { Release memory }
       End;
    Except
    end;
  END;

  PROCEDURE TStrCollection.PutItem (Var S: TStream; Item: Pointer);
  BEGIN
     S.StrWrite(Item);                                  { Write the string }
  END;



   //================================================================================
  {$REGION 'TUnSortedStrCollection'}

    PROCEDURE TUnSortedStrCollection.Insert (Item: Pointer);
    BEGIN
       AtInsert(Count, Item);                             { Insert - NO sorting }
    END;

  {$ENDREGION 'TUnSortedStrCollection'}
  //================================================================================

end.

