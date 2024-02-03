unit mi.rtl.Objects.Methods.Collection.Sortedcollection.Stringcollection.Collectionstring;

  {:< - A Unit **@name** implementa a classe **TCollectionString** do  pacote **mi.rtl**.


      - **NOTA**
        -  Essa classe foi criada para transformar Lista PSItem eem TCollection de strings;

      - **VERSÃO**
        - Alpha - Alpha - 0.9.0

      - **CÓDIGO FONTE**:
        - @html(<a href="../units/mi.rtl.objects.tcollection.tsortedcollection.tstringcollection.pas">mi.rtl.objects.tcollection.tsortedcollection.tstringcollection.pas</a>)

      - **HISTÓRICO**
        - Criado por: Paulo Sérgio da Silva Pacheco e-mail: paulosspacheco@@yahoo.com.br
          - **07/12/2021**
            - 08:00 a 10:07 : Criada a unit @name e a classe **TCollectionString**

  }
  {$IFDEF FPC}
    {$MODE Delphi} {$H+}
  {$ENDIF}

  interface

  uses
    Classes, SysUtils
    ,mi.rtl.objects.Methods
    ,mi.rtl.objects.methods.Collection.Sortedcollection.StringCollection;


    type
      TStringCollection = mi.rtl.objects.methods.Collection.Sortedcollection.StringCollection.TStringCollection;


      {: A classe **@name** implementa uma coleção de **AnsiString** baseado em listas PSitem.
      }
      TCollectionString = Class (TStringCollection)
        type TListBoxRec = record    {:< omit if TListBoxRec is defined else where}
                              PS : TCollectionString;
                              Selection : LongInt;
                              //O campo a seguir devolve a pedaco da string limitadas por ~ usada para transferencia de dados
                              StrSelection : String;
                           end;

        Private OkInsert : Boolean;

        Public Ordem:Boolean; {:< - Se True insere em ordem alfabética}
        Public FoundTesteCompleto:Boolean;

        {$Region '---> Declaração da propriedade Stringss <---'}
          Private Function GetAnsiStrings(Index: Sw_Integer):AnsiString; //:< - Ler a string sem os caracteres de controle
          Public Property AnsiStrings[Index: Sw_Integer]: AnsiString Read GetAnsiStrings;//:< Ler a string sem os caracteres de controle
        {$EndRegion '---> Declaração da propriedade Stringss <---'}

        //Public
        Public constructor Create(ALimit, ADelta: Sw_integer;AOrdem:Boolean);overload;virtual;
        Public constructor CreateLista(AOrdem:Boolean;aLista:tString;const aFoundTesteCompleto:Boolean);

        Public function NewStr(S : AnsiString):Boolean;
        Public function Append(S : AnsiString):Boolean;

        Public procedure AddSItem(P : PSItem;OkDisposeSItems:Boolean);Overload;
        Public procedure AddSItem(P : PSItem);Overload;

        Public function PListSItem : PSItem;
        Public function Get_Html_List:AnsiString;//:< Retorna Uma sequencia de <li> </li>
        Public function Found(const akey:tString):Boolean;

        Public function GetMaiorString(Const aConjDespreze:AnsiCharSet;aIgnore_ShowWid:Boolean) : Byte;Overload;
        Public function GetMaiorString(Const aConjDespreze:AnsiCharSet) : Byte;Overload;

        Public function GetMaiorAnsiString() : Integer;Overload;

        Public function Clone:TCollectionString;
        Public function Search (Key: Pointer; Var Index: Sw_Integer): Boolean;Override;

        Public procedure FormatStr(LengthMaxCol: Integer);

        Public procedure FreeItem (Item: Pointer); Override;

        public class procedure WriteSItems(var S: TCollectionString; Const Items: PSItem);
        public class function CloneSItems(Const Items: PSItem):PSItem;
        public class Function CopyTemplateFrom(Const aTemplate:tString): tString;

      END;



implementation

{$REGION '---> Inicio da Implementação de TCollectionString'}

  Function TCollectionString.GetAnsiStrings(Index: Sw_Integer):AnsiString;
    //Objetivo: Ler a string sem os caracteres de controle.
    //          Precisei em 29/06/2009 quando implementei a classe: TCollectionString_TTb____Table

    Function FS(S:tString):tString;
      Var
       I : Integer;
    Begin
      Result := '';
      for I := 1 to Length(S)
      do  if Not (S[i] in AnsiChar_Control_Template + ['`'] )
      then Result := Result + S[i];
    end;

    Var
      I,PosFldNum : Byte;
      S : PtString;
      P : PSItem;

  Begin
    Result := '';
    If (Index >= 0) And (Index<Count)
    Then Begin
           S := At(Index);
           if S<>nil
           then Begin
                  PosFldNum := Pos('\'+fldENUM,S^);
                  if PosFldNum<>0
                  then Begin
                         {$IFDEF CPU32}
                            Move(S^[PosFldNum+2],P,4);
                         {$ENDIF}
                         {$IFDEF CPU64}
                            Move(S^[PosFldNum+2],P,4+4);
                         {$ENDIF}


                         If P<>nil
                         Then Begin // Concatena a lista de PSITEM
                                while P <> nil do
                                Begin
                                  if P^.Value<>nil
                                  then Begin
                                         if Result=''
                                         then Result := FS(P^.Value^)
                                         Else Result := Result + ' ; '+ FS(P^.Value^);
                                       End;
                                  P := P.Next;
                                End
                               End
                         else Result := Fs(S^);
                       End
                  Else Result := Fs(S^);
                End
           Else Result := '';
         End
    Else Result := '';
  end;

  constructor TCollectionString.Create(ALimit, ADelta: Sw_integer;AOrdem:Boolean);
  Begin
    Inherited Create(ALimit, ADelta);
    Ordem := AOrdem; {<Se True insere em ordem alfabetica}
    Duplicates := True; {<O padrao aceita duplicatas}
  End;

  constructor TCollectionString.CreateLista(AOrdem:Boolean;aLista:tString;const aFoundTesteCompleto:Boolean);
  {< Recebe uma lista de strings separados por ponto e virgula e cria
    a colecao com os subStrings da lista

    Exemplo:
      Create1(1,1,true,'1;123;456;4566')
      Iniciliza a colecao com os numeros
      1
      123
      456
      4566
  }
  Var
    S : tString;
    p : byte;
  Begin
    Create(1,1,aOrdem);

    FoundTesteCompleto := aFoundTesteCompleto;
    While Length(aLista) <> 0 do
    Begin
      p := Pos(';',aLista);
      if p <> 0 Then
      Begin
        S := System.Copy(aLista,1,p-1);
        NewStr(S);
        System.delete(aLista,1,p);
      End
      else
      Begin
        If Length(aLista) <> 0 Then
        Begin
          NewStr(aLista);
          aLista := ''; {<fim da lista}
        End;
      End;
    End;
  End;

  Function TCollectionString.NewStr(S : AnsiString):Boolean;
    Var
       WS : TString;

    Function Insert_Not_Duplicates:Boolean;
     var
       I: Integer;

    Begin
      //==========================================================================================================
       {$REGION '--->2011/12/03 - Tarefa: Verificar porque a rotina de processamento está gerando exceção quando a contabilidade não está habilitada.'}
      //=============================================================================================3============

          { DONE 1 -oTCollectionString.NewStr -cBUG DO CÓDIGO :
        2011/12/07. Criado em: 2011/12/03. Versão: 9.27.13.1908
         <ul>
           • Verificar porque a rotina de processamento está gerando exceção quando a contabilidade não está habilitada.<BR>
             • Solução:
                • O problema foi criado quando troquei NewStr(S : TString) para NewStr(S : AnsiString), pois o aquivo ficava duplicado na lista de arquivos a serem renomeados.<BR>
                • Para resolver o problema é necessário criar a varivel Ws : TString para que a pesquisa funcione.<BR>
         </ul>
        }
      {$ENDREGION}

      //==========================================================================================================

      OkInsert  := not Search(KeyOf(@wS), I) or Duplicates;
      If OkInsert
      Then Begin
             If Ordem
             Then AtInsert(I,TObjectsMethods.NewStr(wS))
             Else AtInsert(Count,TObjectsMethods.NewStr(wS));{:< - TCollection.Insert(Objects.NewStr(wS));}
           End;
      Insert_Not_Duplicates := OkInsert;
    end;

  Begin

    Assert(length(s) <=255);
    WS := S;
    If wS = ''
    Then wS := ' ';

    If Not Duplicates
    Then  NewStr := Insert_Not_Duplicates
    else  Begin
            If Ordem
            Then Insert(TObjectsMethods.NewStr(wS))
            Else AtInsert(Count,TObjectsMethods.NewStr(wS));{<TCollection.Insert(Objects.NewStr(S));}
            NewStr := true;
          End;
  End;

  Function TCollectionString.Append(S : AnsiString):Boolean;
  Begin
    Result := newStr(S);
  end;

  procedure TCollectionString.AddSItem(P : PSItem;OkDisposeSItems:Boolean);
    {:< - Insere uma lista de SItems na collection }
    Var
      Aux : PSItem;
  Begin
    Aux := P;
    while aux <> nil do
    Begin
      If Aux^.Value<> nil Then
        NewStr(Aux^.Value^);
      Aux := Aux^.next;
    End;

    If OkDisposeSItems
    Then DisposeSItems(P);
  End;

  procedure TCollectionString.AddSItem(P : PSItem);
  Begin
    AddSItem(P,true); {:< -Default deve destruir a lista passada}
  end;

  Function TCollectionString.PListSItem : {<Dialogs.}PSItem;
    var
     S:TString;
     n : Integer;
  begin
    Result := nil;

    if Count>0 then
    For n := Count-1 downto 0 do
       If TItemList(Items^)[n] <> nil
       Then Begin
            //Result := NewSitem(tString(TItemList(Items^)[n]^),Result);
            //Result := NewSitem(CopyTemplateFrom(tString(TItemList(Items^)[n]^)),Result);
              S := tString(TItemList(Items^)[n]^);
              Result := NewSitem(CopyTemplateFrom(S),Result);
            End;

       //PListSItem:= P;
  end;

  Function TCollectionString.Get_Html_List:AnsiString;//< Retorna Uma sequencia de <li> </li>
    {:< RETORNA: Um uma lista de string no formato html onde cada linha fica entre <li>l inha </li>
      Nota: O final da lista termina com "<br>&nbsp;" para que passe uma linha em branco no final da lista
    }
    Var
      i,J,n_brancos_iniciais : Integer;
      S : AnsiString;
      PosSpace : Integer;
  Begin
    Result := '';
    For i := 0 to Count -1 do
    begin
      S := tStrings[i];
      n_brancos_iniciais := 0;


      //Troca o  espaco pelo código html do espaco.
      while (LENGTH(S) > 0) AND (S[1] = ' ')  do
      begin
        system.delete(S,1,1);
        n_brancos_iniciais := n_brancos_iniciais+1;
      end;

      //Acresssenta o números de brancos deletados usando código html.
      For j := 1 to n_brancos_iniciais do
        S := '&nbsp;' + S;

      //Troca o  espaco pelo código html do espaco.
  {   Desativei por que desta forma o texto não aceita código HTML
       PosSpace := Pos(' ', S);
      while PosSpace <> 0  do
      begin
        system.delete(S,PosSpace,1);
        System.insert('&nbsp;',S,PosSpace);
        PosSpace := Pos(' ', S);
      end;}


  { //Desativei porque a fonte era arredada na lista
       If i < count-1
       Then Result := Result + '<li>'+'<font face="Lucida Console">'+S +'</font>'+ '</li>'
       Else Result := Result + '<li>'+'<font face="Lucida Console">'+S+ '<br>&nbsp;'+'</font>'+'</li>';
  }
  {    //Desativei porque o browser mostra marcas em textos do mesmo paragrafo.
       If i < count-1
       Then Result := Result + '<li>'+S + '</li>'
       Else Result := Result + '<li>'+S+ '<br>&nbsp;</li>';
  }

  //     Result := Result+'<TR><TD>'+ S +'</TD> </TR>' ;  //Não dar certo pq caso o usuário coloque o comando <PRE> e </Pre> o mesmo não funciona.

       If i < count-1
       Then Result := Result + S +'<BR> '
       Else Result := Result + S+ '<BR>&nbsp; ';

    end;

  //  Result := '<table>'+Result+'</table>' //Não dar certo pq caso o usuário coloque o compando <PRE> e </Pre> o mesmo não funciona.
  End;


  Function TCollectionString.Found(const akey:tString):Boolean;
  Var
    I   : SmallInt;
    key : tString;
  Begin
    For I := 0 to count -1 do
    Begin
      If FoundTesteCompleto Then
      Begin
        If  aKey = PtString(At(i))^ Then
        Begin
          Found := true;
          exit;
        End
      End
      else
      Begin
        Key := PtString(At(i))^;
        If Byte(Key[0])  <  byte(aKey[0]) Then
        Begin
          If  Key = copy(akey,1,Byte(Key[0])) Then
          Begin
            Found := true;
            exit;
          End;
        End
        Else
        Begin
          If  aKey = copy(key,1,Byte(aKey[0])) Then
          Begin
            Found := true;
            exit;
          End;
        End
      End;
    End;
    Found := False;
  End;

  procedure TCollectionString.FreeItem(Item: Pointer);
  //Caso o item seja uma lista de PSITEM o mesmo deve ser destruido.
   Var P1  : PSItem;
  Begin
  If (Item<>nil) and (ptString(Item)^ <> '')
  Then Case ptString(Item)^[1] of
           //<Os Campos abaixo pode ser uma lista de PSItem
           fldENUM   : Begin
                         {$IFDEF CPU32}
                           Move(ptString(Item)^[2],P1,4);
                         {$ENDIF}
                         {$IFDEF CPU64}
                           Move(ptString(Item)^[2],P1,4+4);
                         {$ENDIF}
                         DisposeSItems(p1);
                       End;
           fldSItems : Begin
                         {$IFDEF CPU32}
                            Move(ptString(Item)^[2],P1,4);
                         {$ENDIF}
                         {$IFDEF CPU64}
                            Move(ptString(Item)^[2],P1,4+4);
                         {$ENDIF}

                         DisposeSItems(p1);
                       end;
         Else inherited FreeItem(Item);
       end;
  end;

  Function TCollectionString.GetMaiorString(Const aConjDespreze:AnsiCharSet;aIgnore_ShowWid:Boolean) : Byte;
  Var
    I,Len,aGetMaiorString   : SmallInt;
    S                         : PtString;
    P : PSItem;


    Procedure Calc_Len;
      Var
        J   : SmallInt;
    Begin
      Len  := 0;
      For j := 1 to length(S^) do
      Begin
        If Not (S^[j] in aConjDespreze)
        Then Inc(Len)
        Else Begin
               if Not aIgnore_ShowWid
               then Begin
                      If (S^[j] ='`') and (S^[j] in aConjDespreze)
                      Then Break; {<Despreza o resto da linha}
                   End
             End;
      End;
    end;

  Begin
    aGetMaiorString  := 0;
    For I := 0 to count -1 do
    Begin
      S := At(i);
      If S <> nil
      Then Begin
             Len := Pos('\'+fldENUM,S^);
             If Len  <> 0
             Then Begin
                    Move(S^[Len+2],P,sizeof(pointer));
                    If P<>nil
                    Then Len := Len + MaxItemStrLen(P)
                    else Len := 0;
                  End
             Else Calc_Len;

              If Len > aGetMaiorString Then
                aGetMaiorString := Len;
           End;
    End;
    GetMaiorString := aGetMaiorString;
  End;

  Function TCollectionString.GetMaiorString(Const aConjDespreze:AnsiCharSet) : Byte;
  Begin
    Result := GetMaiorString(aConjDespreze,False);
  End;

  Function TCollectionString.GetMaiorAnsiString() : Integer;
   Var
     I,Len : Integer;

  Begin
    Result := 0;
    for I := 0 to Count - 1 do
    Begin
      Len := Length(Self.AnsiStrings[i]);
      if Result < Len
      then Result := Len;
    End;
  End;

  Function TCollectionString.Clone:TCollectionString;
    Var
      i : Integer;
      S : PtString;
  Begin
    Result := TCollectionString.Create(Limit,delta,ordem);
    Result.FoundTesteCompleto := FoundTesteCompleto;

    For I := 0 to count -1 do
    Begin
      S := At(i);
      If S <> nil
      Then Begin
             Result.NewStr(S^);
           End;
    End;
  end;

  FUNCTION TCollectionString.Search (Key: Pointer; Var Index: Sw_Integer): Boolean;
    Var
      WIndex: Sw_Integer;
  Begin
    If Ordem
    Then Result := Inherited Search (Key, Index)
    Else begin
           For WIndex := 0 to Count-1 do
           Begin
             If (TItemList(Items^)[wIndex] <> nil) And (Compare(Key,TItemList(Items^)[wIndex] ) = 0 )
             Then Begin
                    Index := wIndex;
                    Result := true;
                    exit;
                  End;
           End;
         end;
    Result := False;
  End;

  Procedure TCollectionString.FormatStr(LengthMaxCol: Integer);

    Function GetUltPalavra(Const Ws : AnsiString ) : AnsiString;
        Var
          I : Integer;
      Begin
        Result := '';
        For I := Length(Ws) downto  1 do
        Begin
          If Ws[i] <> ' '
          Then System.Insert(Ws[i],Result,1)
          Else Break;
        End
      end;


    Var
      i,J : Sw_Integer;
      SItem  : tString;
      S      : tString;
      P      : PtString;

      Crtl_C : Boolean;

    Procedure Insert_Strings;
      Var
        SUlt : AnsiString;
    Begin
       SItem := Copy(SItem,length(s)+1,Length(SItem));

       If Crtl_C
       Then Begin
              If (S[Length(S)] <> ' ' ) And
                 ((Length(SItem)>0) And
                  (SItem[1]<> ' '))
              Then Begin
                     SUlt := GetUltPalavra(S);
                     System.Insert(SUlt,SItem,1);

                     S := System.Copy(S,1,Length(S) - Length(SUlt) );
                   End;

              tStrings[i] := CentralizesStr(S,LengthMaxCol)
            end
       ELse tStrings[i] := S;

       If (Sitem<> '')
       Then Begin
              P := TObjectsMethods.NewStr(SItem);
              AtInsert(I+1,P);
{              Inc(i);}
            End;
       S := '';
       J := 1;
    end;


  Begin
    I := 0;


    While I <= Count-1 do
    Begin
      SItem  := tStrings[i];
      Crtl_C := False;
      If SItem <> ''
      Then Begin
             S := '';
             {
               esta faltando o código??????????????????? fazer depois
             }

             J := 1;
             While (j <= length(SItem)) AND (SItem[J] <> #0)  do
             Begin
               Case SItem[j] of
                 ^C  : Begin
                         S := S + ' ';
                         If (Length(S) >= LengthMaxCol) or (j >= length(SItem))
                         Then Begin
                                Insert_Strings;
                                Inc(i);
                                Continue;
                              End;

                         Crtl_C :=  {true} Not Crtl_C;

                       End;
                 ^M,#0
                     : Begin
                         S := S + ' ';
                         Insert_Strings;
                         Inc(i);
                         Continue
                       End;
                 Else  Begin
                         If Not Crtl_C
                         Then S := S + SItem[j]
                         Else Begin
                                If (Length(S) < LengthMaxCol) and (j <= length(SItem))
                                Then S := S + SItem[j];

                                If (Length(S) >= LengthMaxCol) or
                                    (j >= length(SItem)) OR
                                   (SItem[j]=#0)
                                Then Begin
                                       Insert_Strings;
                                       Inc(i);
                                       Continue;
                                     End;
                              End;
                       End;
               End;
               Inc(J);
             End;

           End;
      Inc(i);
    End;
  end;

  class procedure TCollectionString.WriteSItems(var S: TCollectionString; Const Items: PSItem);
    {<Obs:
      S : Deve ser passado nao inicializado mais deve ser NIL
    }
    var
      P : PSItem;
  begin
    If (S = nil) And (Items<>nil) Then
    Begin
      S :=  TCollectionString.Create(1,1,False);{<Insere a tString em ordem sequencial}
      P := Items;
      While (P <> nil) do
      begin
        If P.Value <> nil
        Then S.NewStr(P.Value^);
        P := P.Next;
      end;
    End;
  end;

  class function TCollectionString.CloneSItems(Const Items: PSItem):PSItem;
  var
    S : TCollectionString;
  Begin
    S := nil;
    WriteSItems(S,Items);
    If S <> nil
    Then Begin
            Result := S.PListSItem;
            Discard(TObject(S));
         End
    else Result := nil;
  End;

  Class Function TCollectionString.CopyTemplateFrom(Const aTemplate:tString): tString;
   {:<
     Esta fução se faz necessário porque um Template pode ser uma lista de Strings onde esta lista pode
     ser inserida em um objeto e discartada ao destruir o objeto.
   }
     Var P1  : PSItem;
  Begin
    If aTemplate <> ''
    Then Case aTemplate[1] of

             //Os Campos abaixo pode ser uma lista de PSItem
             fldENUM   : Begin
                           {$IFDEF CPU32}
                              Move(ATemplate[2],P1,4);
                              Result := CreateEnumField({ShowZ  } boolean(Byte(aTemplate[6])),
                                                        {AccMode} Byte(aTemplate[7]),
                                                        {Default} longInt(aTemplate[8]),
                                                        {AItems}  CloneSItems(P1));
                           {$ENDIF}
                           {$IFDEF CPU64}
                              Move(ATemplate[2],P1,4+4);
                              Result := CreateEnumField({ShowZ  } boolean(Byte(aTemplate[6+4])),
                                                       {AccMode} Byte(aTemplate[7+4]),
                                                       {Default} longInt(aTemplate[8+4]),
                                                       {AItems}  CloneSItems(P1));

                           {$ENDIF}


                          if length(aTemplate) > Length(Result)
                          then Begin
                                 Result := Result + copy(aTemplate,length(result)+1,length(aTemplate) - Length(Result));
                               End;
                         End;
             fldSItems : Begin
                           {$IFDEF CPU32}
                             Move(ATemplate[2],P1,4);
                           {$ENDIF}
                           {$IFDEF CPU64}
                             Move(ATemplate[2],P1,4+4);
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


{$ENDREGION}




end.

