unit mi.rtl.Objects.Methods.Collection.SortedCollection;
{:< - A Unit **@name** implementa a classe **TSortedCollection** do  pacote **mi.rtl**.

  - **VERSÃO**
    - Alpha - 1.0.0

  - **CÓDIGO FONTE**:
    - @html(<a href="../units/mi.rtl.objects.tcollection.tsortedcollection.pas">mi.rtl.objects.tcollection.tsortedcollection.pas</a>)

  - **HISTÓRICO**
    - Criado por: Paulo Sérgio da Silva Pacheco e-mail: paulosspacheco@@yahoo.com.br
      - **30/11/2021**
        - 9:45 a 11:47 : Criada a unit @name e a classe **TSortedCollection**


}
{$IFDEF FPC}
  {$MODE Delphi} {$H+}
{$ENDIF}


interface

uses
  Classes, SysUtils
  ,mi.rtl.objects.Methods
  ,mi.rtl.objects.methods.StreamBase
  ,mi.rtl.objects.methods.Collection;


  {: - A class **@name** implementa coleções ordenadas de objetos.

     - EXEMPLO DE USO

       ```pascal

         ???

       ```
  }
  type
  TSortedCollection =
  class(TCollection)

    //private
    Private Function Getstrings(Index: Sw_Integer):tstring;
    Private Procedure Setstrings(Index: Sw_Integer;atstrings : tstring);

    //Public
    Public Duplicates: Boolean;//: Duplicates flag
    Public CONSTRUCTOR Create (ALimit, ADelta: Sw_Integer);overload;override;
//    Public CONSTRUCTOR Load (Var S: TStream);
    protected FUNCTION KeyOf (Item: Pointer): Pointer;                       Virtual;
    protected FUNCTION IndexOf (Item: Pointer): Sw_Integer;                  Override;
    protected FUNCTION Compare (Key1, Key2: Pointer): Sw_Integer;            Virtual;
    protected FUNCTION Search (Key: Pointer; Var Index: Sw_Integer): Boolean;Virtual;
    protected PROCEDURE Insert (Item: Pointer);                              Override;
//    Public PROCEDURE Store (Var S: TStream);
    protected Function GetMaxLength():Integer;//: =n specifies the maximum number of AnsiCharacters
    protected Property tstrings[Index: Sw_Integer]: tstring Read Getstrings write Setstrings;
  end;

implementation

  {+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++}
  {                       TSortedCollection Class METHODS                    }
  {+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++}

  //=n specifies the maximum number of AnsiCharacters
  Function TSortedCollection.GetMaxLength():Integer;
    var
      i,Maior: Sw_Integer ;
  Begin
    Maior := 0;
    For i := 0 to Count-1 do
    Begin
      if Length(tstrings[i]) > Maior
      Then Maior := Length(tstrings[i]);
    end;

    Result := Maior;
  end;

  CONSTRUCTOR TSortedCollection.Create (ALimit, ADelta: Sw_Integer);
  BEGIN
     Inherited Create(ALimit, ADelta);                    { Call ancestor }
     //Alias := 'TSortedCollection.Create()';
     Duplicates := False;                               { Clear flag }
  END;


  //CONSTRUCTOR TSortedCollection.Load (Var S: TStream);
  //BEGIN
  //   Inherited Load(S);                                 { Call ancestor }
  //   S.Read(Duplicates, SizeOf(Duplicates));            { Read duplicate flag }
  //END;


  FUNCTION TSortedCollection.KeyOf (Item: Pointer): Pointer;
  BEGIN
     KeyOf := Item;                                     { Return item as key }
  END;


  FUNCTION TSortedCollection.IndexOf (Item: Pointer): Sw_Integer;
  VAR I, J: Sw_Integer;
  BEGIN
     J := -1;                                           { Preset result }
     If Search(KeyOf(Item), I) Then Begin               { Search for item }
       If Duplicates Then                               { Duplicates allowed }
         While (I < Count) AND (Item <> Items^[I]) Do
           Inc(I);                                      { Count duplicates }
       If (I < Count) Then J := I;                      { Index result }
     End;
     IndexOf := J;                                      { Return result }
  END;


  FUNCTION TSortedCollection.Compare (Key1, Key2: Pointer): Sw_Integer;
  BEGIN
     Abstracts;                                          { Abstract method }
  END;


  FUNCTION TSortedCollection.Search (Key: Pointer; Var Index: Sw_Integer): Boolean;
  VAR L, H, I, C: Sw_Integer;
  BEGIN
     Search := False;                                   { Preset failure }

     L := 0;                                            { Start count }
     H := Count - 1;                                    { End count }

     While (L <= H) Do Begin
       I := (L + H) {div 2} SHR  1;                     { Mid point }
       Try
         {If (Items^[I] <> nil) And (Key<>nil)
         Then} C := Compare(KeyOf(Items^[I]), Key);             { Compare with key }
  {       Else Abort;}
       Except
         Result := False; C:= 0; exit;
       end;
       If (C < 0) Then L := I + 1 Else Begin            { Item to left }
         H := I - 1;                                    { Item to right }
         If C = 0 Then Begin                            { Item match found }
           Search := True;                              { Result true }
           If NOT Duplicates Then L := I;               { Force kick out }
         End;
       End;
     End;
     Index := L;                                        { Return result }
  END;

  PROCEDURE TSortedCollection.Insert (Item: Pointer);
  VAR I: Sw_Integer;
  BEGIN
     If NOT Search(KeyOf(Item), I) OR Duplicates Then   { Item valid }
       AtInsert(I, Item);                               { Insert the item }
  END;


  //PROCEDURE TSortedCollection.Store (Var S: TStream);
  //BEGIN
  //{   TCollection.Store(S);???ErrorClass???}          { Call ancestor }
  //   S.Write(Duplicates, SizeOf(Duplicates));         { Write duplicate flag }
  //END;


  Function TSortedCollection.Getstrings(Index: Sw_Integer):tstring;
  Begin
    If (Index >= 0) And (Index<Count)
    Then Result := tstring(At(Index)^)
    Else Result := '';
  end;


  Procedure TSortedCollection.Setstrings(Index: Sw_Integer;atstrings : tstring);
    Var
      P : ptstring;
  Begin
    If (Index>=0) And (Index < Count)
    Then NNewStr(ptstring(Items^[Index]),atstrings)
    Else Begin
           P := NewStr(atstrings);
           Insert(P);
         End;
  end;



end.

