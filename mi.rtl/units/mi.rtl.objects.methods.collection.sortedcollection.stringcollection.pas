unit mi.rtl.Objects.Methods.Collection.SortedCollection.StringCollection;
  {:< - A Unit **@name** implementa a classe **tstringCollection** do  pacote **mi.rtl**.


      - **NOTA**
        - A diferença de tstringCollection para TStrCollection é que a primeira é uma coleção de shortstring e a segunda é
          uma coleção de PByteArray usada para trabalhar com AnsiString;

      - **VERSÃO**
        - Alpha - 1.0.0

      - **CÓDIGO FONTE**:
        - @html(<a href="../units/mi.rtl.objects.tcollection.tsortedcollection.tstringcollection.pas">mi.rtl.objects.tcollection.tsortedcollection.tstringcollection.pas</a>)

      - **HISTÓRICO**
        - Criado por: Paulo Sérgio da Silva Pacheco e-mail: paulosspacheco@@yahoo.com.br
          - **30/11/2021**
            - 14:20 a 15:15 : Criada a unit @name e a classe **tstringCollection**

  }
  {$IFDEF FPC}
    {$MODE Delphi} {$H+}
  {$ENDIF}


  interface

  uses
    Classes, SysUtils,
    mi.rtl.objects.methods.Collection.SortedCollection,
    mi.rtl.objects.methods.StreamBase.Stream;


  type
    {: A classe **@name** implementa uma coleção de **AnsiString**
    }
    TStringCollection = Class (TSortedCollection)
       FUNCTION GetItem (Var S: TStream): Pointer;                    Override;
       FUNCTION Compare (Key1, Key2: Pointer): Sw_Integer;            Override;
       PROCEDURE FreeItem (Item: Pointer);                            Override;
       PROCEDURE PutItem (Var S: TStream; Item: Pointer);             Override;
    END;

  type
    {: A classe **@name** implementa uma coleção de **Shortstring** na ordem original de inserção dos ShortStrings
    }
    TUnSortedStringCollection = Class (TStringCollection)
        PROCEDURE Insert (Item: Pointer);                              Override;
    END;


implementation

  //================================================================================
  {$REGION 'TStringCollection'}


    FUNCTION TStringCollection.GetItem (Var S: TStream): Pointer;
    BEGIN
       GetItem := S.ReadStr;                              { Get new item }
    END;

    FUNCTION TStringCollection.Compare (Key1, Key2: Pointer): Sw_Integer;
    VAR I, J: Integer; P1, P2: ptstring;
    BEGIN
       P1 := ptstring(Key1);                               { String 1 pointer }
       P2 := ptstring(Key2);                               { String 2 pointer }

       If (Length(P1^)<Length(P2^))
       Then J := Length(P1^)
       Else J := Length(P2^);                             { Shortest length }

       I := 1;                                            { First AnsiCharacter }

       While (I<J) AND (P1^[I] = P2^[I]) Do Inc(I);       { Scan till fail }

       If (I=J)
       Then Begin                                         { Possible match }
            { * REMARK * - Bug fix   21 August 1997 }
              If (P1^[I]<P2^[I])
              Then Compare := -1                          { String1 < String2 }
              Else If (P1^[I]>P2^[I])
                   Then Compare := 1                      { String1 > String2 }
                   Else If (Length(P1^)>Length(P2^))
                        Then Compare := 1                 { String1 > String2 }
                        Else If (Length(P1^)<Length(P2^))
                        Then Compare := -1                { String1 < String2 }
                        Else Compare := 0;                { String1 = String2 }

            { * REMARK END * - Leon de Boer }
            End
       Else If (P1^[I]<P2^[I])
            Then Compare := -1                            { String1 < String2 }
            Else Compare := 1;                            { String1 > String2 }
    END;

    PROCEDURE TStringCollection.FreeItem (Item: Pointer);
    BEGIN
      Try
        DisposeStr(ptstring(Item));                                  { Dispose item }
      Except
      end;
    END;

    PROCEDURE TStringCollection.PutItem (Var S: TStream; Item: Pointer);
    BEGIN
       S.WriteStr(Item);                                  { Write string }
    END;

  {$ENDREGION 'TStringCollection'}
  //================================================================================



  //================================================================================
  {$REGION 'TUnSortedStringCollection'}

    PROCEDURE TUnSortedStringCollection.Insert (Item: Pointer);
    BEGIN
       AtInsert(Count, Item);                             { Insert - NO sorting }
    END;

  {$ENDREGION 'TUnSortedStringCollection'}
  //================================================================================
end.


