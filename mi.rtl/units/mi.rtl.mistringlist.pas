unit mi.rtl.miStringlist;
{: A unit **@name** implementa a classe TMiStringList}

{$H+}
{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}


interface

uses
  Classes, SysUtils
  ,mi.rtl.MiStringListBase
  ,mi.rtl.Consts
  ;

  {: A class **@name**  implementa a navegação como se tivesse navegando em arquivos usando os métodos NextKey,Prevkey etc...

     - **NOTA**
       - Usando quando quero manter uma lista de registros ordenada.
  }
  Type
    TMiStringList = Class(TStringListBase) //https://wiki.freepascal.org/TListBox#Assignment_of_a_StringList
                    public
                       Function AddKey(WKey:String;wNr:Longint):Boolean;
                       Function BofKey : Boolean; //:<  Posiciona no inicio do bloco de registro do tipo default
                       Function LastKey: Boolean;//:<  Posiciona no fin do bloco de registro do tipo default
                       Function EofKey : Boolean; //:<  Posiciona no fin do bloco de registro do tipo default
                       Function PrevKey  : Boolean; //:<  Posiciona no registro anterior do tipo default
                  End;

implementation





Function TMiStringList.AddKey(WKey:String;wNr:Longint):Boolean;
Begin
  Try
    Result := true;
    AddObject(UpperCase(WKey),pointer(wNr));

  except
    Result := false;
  end;
end;


Function TMiStringList.BofKey : Boolean;
//<  Posiciona no inicio do bloco de registro do tipo default

  {  Function BofKeyLocal : Boolean;
  Begin
  Result := Index_Currente <= 0;
  If Not Result
  Then Result := Copy(Strings[Index_Currente],1,length(KeyMaster)) <> KeyMaster
  end;}

Begin
  // Se relacionando executar ClearKeyLocal
  {  If KeyMaster <> ''
  Then Result := BofKeyLocal()
  Else Result := Index_Currente <= 0;}
  Result := OkBof;
end;

Function TMiStringList.LastKey : Boolean;
  //<  Posiciona no fin do bloco de registro do tipo default
  Function LastKeyLocal : Boolean;
  Begin
    Result := ClearKey;
    If Result
    Then While Not EofKey Do Begin
            Result := NextKey;
            If Not Result Then Break;
         end;
  end;

Begin
  Result := true;

  // Se relacionando executar ClearKeyLocal
  If KeyMaster <> ''
  Then Begin
         Result := LastKeyLocal();
         Exit;
  end
  Else Begin
         If Count > 0
         Then Begin
                Index_Currente := Count-1;
                Nr := PtrInt(Objects[Index_Currente]);
         end Else Nr := 0;

         OkBof := False;
         OkEof := true;
  end;
end;

Function TMiStringList.Eofkey : Boolean;
   //<  Checa se o ponteiro está no último registro
Begin
  // Se relacionando executar ClearKeyLocal
  {  If KeyMaster <> ''
  Then Result := Copy(Strings[Index_Currente],1,length(KeyMaster)) <> KeyMaster
  Else Result := Index_Currente >= Count-1;}
  Result := OkEof  ;
end;


Function TMiStringList.PrevKey  : Boolean;
//<  Posiciona no registro anterior do tipo default
Begin
  Result := okBof;
  If Not Result
  Then Begin
    If Index_Currente > 0
    Then Begin
           Dec(Index_Currente);
           Nr := Longint(Objects[Index_Currente]);
           Result := true;
    end
    Else Result := false;

    // Critica se a chave atual é igual a chave mestre
    If Result and (KeyMaster <> '')
    Then Result := Copy(Strings[Index_Currente],1,length(KeyMaster)) =  KeyMaster;

    OkBof := Not Result;
    okEof := false;
  end;
end;


end.

