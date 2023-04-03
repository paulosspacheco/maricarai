unit mi.rtl.Consts.StringListBase;
{:< -A unit **@name** implementa a classe TStringListBase do pacote mi.rtl.

    - **VERSÃO**:
      - Alpha - 0.7.0.0

    - **CÓDIGO FONTE**:
      - @html(<a href="../units/mi.rtl.Consts.stringlistbase.pas">mi.rtl.Consts.StringListBase.pas</a>)

    - **HISTÓRICO**
      - Criado por: Paulo Sérgio da Silva Pacheco e-mail: paulosspacheco@@yahoo.com.br
        - **2022-01-25**
          -08:00 a 12:00 - Criado a unit **@name** e implementação da classe **TStringListBase**

      - **2022-05-17**
        - T12 Criar método CopyFrom
}

{$H+}
{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}


interface

uses
  Classes, SysUtils
  ,mi.rtl.Consts;

  {: A a **@name*** é usada para indexar uma lista de objetos ondes os mesmos são excluídos ao destruir a lista

     - **POR QUE?**
       - Para converter caracteres com acento para caracteres sem acento e seu equivalente em html.
         - class Function String_Asc_GUI_to_Asc_Ingles(Const S: String): String;
         - class Function String_Asc_GUI_to_Asc_HTML(Const S: String): String;

       - Para converter a lista de strings em lista PSItem;
         - function TStringListBase.PListSItem: TConsts.PSItem;
         - function TStringListBase.CloneSItems(const Items: TConsts.PSItem): TConsts.PSItem;
  }
  Type

    { TStringListBase }

    TStringListBase = Class(TStringList) //https://wiki.freepascal.org/TListBox#Assignment_of_a_StringList

                        public constructor Create(ALimit: longint;AOrdem:Boolean {:< - Se True insere em ordem alfabética}
                                                  );overload;virtual;

                        Private _OkDestroy_Object : Boolean;
                        Private _OkInsert : Boolean;

                        protected Index_Currente : Integer; //<  Posição atual no index;
                        protected OkBof  : Boolean; {:< Inicio de arquivo}
                        protected okEof  : Boolean; {:< Fim de arquivo   }

                        {: Usada criar relacionamento mestre detalhe.}
                        Private _KeyMaster     : String;

                        private Procedure SetKeyMaster(w_KeyMaster : String);

                        {: Número do registro corrente}
                        public Nr : PtrInt;

                        Public
                         Function ClearKey: Boolean;//<  Posiciona no inicio do bloco de registro do tipo default
                         Property KeyMaster : String Read _KeyMaster Write SetKeyMaster;  //<  Usada criar relacionamento mestre detalhe.

                         {:  Redefini porque a instância anterior não funciona com caractere #254}
                         function IndexOf(const S: string): Integer; override;

                         {: Redefini para poder deletar o objeto associando }
                         procedure Delete(Index: Integer); override;

                         {: Redefini para poder deletar o objeto associando }
                         Property OkDestroy_Object : Boolean Write _OkDestroy_Object;
                         destructor Destroy; override;
                         function Find(const S: string; Out Index: Integer): Boolean; override;
                         Function FindKey(WKey:String):Boolean;

                         Function NextKey  : Boolean; //<  Posiciona no proximo registro do tipo default
                         Function SearchKey(WKey:String):Boolean;
                         Function NewStr(S : String):Boolean;overload;
                         Function Append(S : String):Boolean;


                         procedure AddSItem(P : TConsts.PSItem;
                                            ConvertIdioma : TConsts.TConvertIdioma;
                                            OkDisposeSItems:Boolean);Overload;

                         {:Adiciona a lista passada por aSItem e desaloca a lista se OkDisposeSItems = true;}
                         procedure AddSItem(P : TConsts.PSItem);Overload;

                         Function CloneSItems(Const Items: TConsts.PSItem):TConsts.PSItem;
//                         function CreateEnumField(ShowZ: boolean; AccMode,Default: byte;AItems: TConsts.PSItem) : TConsts.tString;
                         Function CopyTemplateFrom(Const aTemplate:TConsts.tString): TConsts.tString;
                         Function PListSItem : TConsts.PSItem;

                  End;

implementation


  { TStringListBase }


  function TStringListBase.IndexOf(const S: string): Integer;
    var ws : string;
  begin
    for Result := 0 to GetCount - 1 do
    begin
      ws := Get(Result);
      if ws = S
      then Exit;
    end;
    Result := -1;
  end;


  procedure TStringListBase.Delete(Index: Integer);
    Var
    Obj : TObject;
  Begin
    If _OkDestroy_Object
    Then Obj := GetObject(index)
    Else Obj := nil;

    Inherited delete(Index);

    If Obj<>nil Then  obj.Free;
  End;

  destructor TStringListBase.Destroy;
  Begin
    While Count-1 >= 0
    do Delete(count-1);

    Inherited Destroy;
  end;

function TStringListBase.Find(const S: string; out Index: Integer): Boolean;
  Var
    i : Integer;
    CompareRes: PtrInt;
    ws : String;
begin
  if Sorted
  then Result:=inherited Find(S, Index)
  else begin //Busca sequencial
         Result := false;
         Index:=-1;
         For i := 0 to Count-1 do
         begin
           ws := Get(I);
           CompareRes := DoCompareText(S, ws);
           if (CompareRes=0) then
           begin
             Index:= i;
             Result := true;
             break;
           end;
         end;
       end;
end;

  function TStringListBase.FindKey(WKey: String): Boolean;
  //  Var  WIndex_Currente : Longint;
  Begin
    //  wIndex_Currente := Index_Currente;
    Result := Find(UpperCase(WKey),Index_Currente);

    { Teste.
    Find(UpperCase(WKey),Index_Currente);
    If wIndex_Currente <> Index_Currente
    Then Result := UpperCase(WKey) = Strings[Index_Currente]
    Else Result := true;}

    If Result
    Then Begin
           If Objects[Index_Currente] <> nil
           Then Begin
                  Nr := PtrInt(Objects[Index_Currente]);
                  Result := true;
           end
           Else Result :=  False;
    end;

    OkBof      := False;
    OkEof      := False;
  end;

        function TStringListBase.ClearKey: Boolean;
  //<  Posiciona no inicio do bloco de registro do tipo default

    Function ClearKeyLocal : Boolean;
    Begin
      Result := SearchKey(KeyMaster);
    end;

  Begin
    try
    // Se relacionando executar ClearKeyLocal
    If KeyMaster <> ''
    Then Begin
           Result := ClearKeyLocal();
           Exit;
    end;

    //posiciona no primeiro;
    Result := True;
    Index_Currente := 0;
    If Count-1 >= 0
    Then Begin
           Nr := PtrInt(Objects[Index_Currente]);
           Result := true;
    end
    else Begin
           Nr     := 0;
           Result := false;
    end;

    Finally
      OkBof := True;
      OkEof := False;
    end;

  end;

        constructor TStringListBase.Create(ALimit: longint; AOrdem: Boolean);
  begin
    inherited create;
    Sorted := AOrdem; {<Se True insere em ordem alfabetica}
    Duplicates := dupAccept; {<O padrao aceita duplicatas}
    SetCapacity(ALimit);
  end;

        procedure TStringListBase.SetKeyMaster(w_KeyMaster: String);
  {< Deve executar goBof}
  Begin
    _KeyMaster  := UpperCase(w_KeyMaster) ;
    ClearKey;
  end;

        function TStringListBase.NextKey: Boolean;
  //<  Posiciona no proximo registro do tipo default

  Begin
    Result := okEof;
    If Not Result
    Then Begin
           Inc(Index_Currente);
           If Index_Currente < Self.Count
           Then Begin
                  Nr := PtrInt(Objects[Index_Currente]);
                  Result := true;
           end
           Else Result := false;

            // Critica se a chave atual é igual a chave mestre
           If Result and (KeyMaster <> '')
           Then Result := Copy(Strings[Index_Currente],1,length(KeyMaster)) =  KeyMaster;

           OkEof := Not Result;
           okBof := False;
    end;

  end;

    function TStringListBase.SearchKey(WKey: String): Boolean;
  Begin
    Result := FindKey(WKey);
    If Not Result Then
    Begin
      Result :=  NextKey;
        //Verifica se a chava é igual  WKey
      If Result
      Then Result := Copy(Strings[Index_Currente],1,length(WKey)) = UpperCase(WKey);

      OkEof := Not Result;
      okBof := False;
    end;
  end;

    function TStringListBase.NewStr(S: String): Boolean;

      Function Insert_Not_Duplicates:Boolean;
        var I: Integer;
      Begin
        //       TDuplicates = (dupIgnore, dupAccept, dupError);
        _OkInsert  := (not SearchKey(S)) or (Duplicates = dupAccept);
        If _OkInsert
        Then Begin
        If Sorted
        Then Add(S)
        Else Insert(Count,S);//<TCollection.Insert(Objects.NewStr(S));
        End;
        Insert_Not_Duplicates := _OkInsert;
      end;

  Begin
    If S = ''
    Then S := ' ';

    If Not (Duplicates=dupAccept)
    Then  Result := Insert_Not_Duplicates
    else  Begin
    If Sorted
    Then Add(S)
    Else Insert(Count,S);//<TCollection.Insert(Objects.NewStr(S));
    Result := true;
    End;
  End;

    function TStringListBase.Append(S: String): Boolean;
  Begin
    Result := Add(S)=0;
  end;

    procedure TStringListBase.AddSItem(P: TConsts.PSItem;
    ConvertIdioma: TConsts.TConvertIdioma; OkDisposeSItems: Boolean);

    class procedure DisposeSItems(var AItems: TConsts.PSItem);var  P : TConsts.PSItem;
    begin
      While (AItems <> nil) do
      begin
        P := AItems^.Next;
        If (AItems^.Value<>nil) then DisposeStr(AItems^.Value);
        Dispose(AItems);

        AItems := P;
      end;
      AItems := nil;
    end;

      //Adiciona a lista a lista passada por aSItem e desaloca a lista se OkDisposeSItems = true;
      {<Insere uma lista de SItems na collection }
      Var
      Aux : TConsts.PSItem;
  Begin
    Aux := P;
    while aux <> nil do
    Begin
      If Aux^.Value<> nil
      Then  Begin
              if @ConvertIdioma<>nil
              then NewStr(ConvertIdioma(Aux^.Value^))
              Else NewStr(Aux^.Value^);
      End;
      Aux := Aux^.next;
    End;

    If OkDisposeSItems
    Then DisposeSItems(P);
  End;

    procedure TStringListBase.AddSItem(P: TConsts.PSItem);
  Begin
    AddSItem(P,TConsts.ConvertIdioma_Nil,true); { Default deve destruir a lista passada}
  end;

    function TStringListBase.CloneSItems(const Items: TConsts.PSItem
    ): TConsts.PSItem;
  var
    S : TStringListBase;
  Begin
    S := TStringListBase.Create;
    s.AddSItem(Items);
    If S <> nil
    Then Begin
            Result := S.PListSItem;
            FreeAndNil(S);
         End
    else Result := nil;
  End;

    function TStringListBase.CopyTemplateFrom(const aTemplate: TConsts.tString
    ): TConsts.tString;
     Var P1  : TConsts.PSItem;
  Begin
    If aTemplate <> ''
    Then with TConsts do
         Case aTemplate[1] of

             //<Os Campos abaixo pode ser uma lista de PSItem
             fldENUM   : Begin
                           {$ifdef CPU32}
                               system.Move(ATemplate[2],P1,4);
                               Result := TConsts.CreateEnumField({ShowZ  } boolean(Byte(aTemplate[6])),
                                                         {AccMode} Byte(aTemplate[7]),
                                                         {Default} longint(aTemplate[8]),
                                                         {AItems}  CloneSItems(P1));

                           {$ENDIF}
                           {$ifdef CPU64}
                               system.Move(ATemplate[2],P1,4+4);
                               Result := TConsts.CreateEnumField({ShowZ  } boolean(Byte(aTemplate[6+4])),
                                                         {AccMode} Byte(aTemplate[7+4]),
                                                         {Default} Longint(aTemplate[8+4]),
                                                         {AItems}  CloneSItems(P1));

                           {$ENDIF}

                          if length(aTemplate) > Length(Result)
                          then Begin
                                 Result := Result + copy(aTemplate,length(result)+1,length(aTemplate) - Length(Result));
                               End;
                         End;
             fldSItems : Begin
                           {$ifdef CPU32}
                              system.Move(ATemplate[2],P1,4);
                           {$ENDIF}
                           {$ifdef CPU64}
                              system.Move(ATemplate[2],P1,4+4);
                           {$ENDIF}


                           Result := CreateTSItemFields(CloneSItems(P1));

                           if length(aTemplate) > Length(Result)
                           then Begin
                                  Result := Result + copy(aTemplate,length(result)+1,length(aTemplate) - Length(Result));
                                End;
                         end;
           Else Result := aTemplate;
         end
    else Result := '';
  End;

    function TStringListBase.PListSItem: TConsts.PSItem;

    function NewStr(const S: AnsiString): TConsts.ptstring;
    BEGIN
      if Length(S)> 255
      then Begin
              raise  EArgumentException.Create('Exceção em Objects.function NewStr(): String maior que 255');
           end;

       If (S = '')
       Then Result := Nil
       Else Begin  { Empty returns nil }
              GetMem(Result, Length(S) + 1);                        { Allocate memory }
              Result^[0] := Ansichar(Length(S));

              system.Move(S[1],Result^[1],Length(S));
       End;
    END;

    function NewSItem(const Str: TConsts.tString; ANext: TConsts.PSItem): TConsts.PSItem;
    var
      Item: TConsts.PSItem;
    begin
      New(Item);
      Item^.Value := NewStr(Str);
      Item^.Next := ANext;
      NewSItem := Item;
    end;

  var
   n : Integer;
   s : ShortString;
  begin
    Result := nil;
    if Count>0 then
    For n := GetCount - 1 downto 0 do
    Begin
      S := Get(n);
      Result := NewSitem(CopyTemplateFrom(S),Result);
    End;
  end;



end.
