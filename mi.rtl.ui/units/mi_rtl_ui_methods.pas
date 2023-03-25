unit mi_rtl_ui_methods;

{$mode Delphi}

interface

uses
  Classes, SysUtils,db,Controls,DBCtrls,Variants,Graphics,LazHelpHtml,UTF8Process
  ,System.UITypes
  //,mi.rtl.Types
  //,mi.rtl.Objects.Methods.Paramexecucao.Application
  //,mi.rtl.Objects.Methods.ui.Consts
  //,mi.rtl.objects.consts.mi_msgbox
  //,mi.rtl.objects.consts.progressdlg_if
  //,mi.rtl.objects.Methods.Exception
  //,mi.rtl.objects.methods.Collection.SortedCollection.stringcollection.CollectionString
  ,mi_rtl_ui_consts;


  type

    { TUiMethods }

    TUiMethods = class(TUiConsts)
      {: A class function **@name** é usado para encandear Templates do tipo TString}
      public class function CreateAppendFields(ATemplate: ptString) : DmxIDstr;

      {: A class function **@name** é usado para encandear campos do tipo blob}
      public class function CreateBlobField(Len: integer; AccMode,Default: byte) : DmxIDstr;

      {: A class function **@name** é usado para encandear Templates do tipo enumerado}
      public class function CreateEnumField(ShowZ: boolean; AccMode,Default: LongInt;AItems: PSItem) : DmxIDstr;

      {: A class function **@name** é usado para encandear Templates do tipo checkbox}
      public class function CreateCheckBoxField(CharNumberField: AnsiChar;ShowZ: boolean; AccMode,Default: byte;AItems: PSItem) : AnsiString;

      {: A class function **@name** é usado para encandear Templates do tipo PSItem}
      public class function CreateTSItemFields(ATemplates: PSItem) : DmxIDstr;

      {: A class function **@name** é usado para informar uma lista de opções para o campo.

         - **NOTA**
           O campo que pode receber uma lista pode ser de qualquer tipo, exceto os tipos:
           - FldEnum,FldBoolean e FldRadioButton.

         - **EXEMPLO DE USO**

            ```pascal

              with aUiDmxScroller do
              begin
                add('~_EXEMPLO DE TEMPLATE________________________________________~');
                add('');
                add('~Vencimento:~\Ssssss'+ChFN+'Vencimento'+CreateOptions(1,NewSItem('Dia 10',
                                                                             NewSItem('Dia 15',
                                                                             NewSItem('Dia 20',
                                                                             NewSItem('Dia 25',
                                                                             nil)))))+'~ dias~');

                add('~     Prazo:~\BB'+ChFN+'Dias'+CreateOptions(2,NewSItem('30',
                                                                   NewSItem('60',
                                                                   NewSItem('90',
                                                                   NewSItem('120',
                                                                   nil)))))+'~ dias~');

                add('');
              end;

            ```

      }
      public class function CreateOptions(Default: LongInt;AItems: PSItem) : DmxIDstr;

      public class Function GetMaxTViRect : TViRect;
      public class Function AnsiString_to_TCollectionString(Msg: AnsiString): TCollectionString;
      public class Function MsgDlgButtons_To_MsgDlgBtn(Buttons: TMI_MsgBox.TMsgDlgButtons): TMI_MsgBox.TArray_MsgDlgBtn;
      public class function FStrSelection(S:AnsiString):AnsiString;
      public class Procedure EliminaTilDeTodasAsStrings(ATCollectionString: TCollectionString;Var aFrist_Item_Valid : Integer);
      public class function  GetModalResult(ButtonDefault: TMI_MsgBox.TMsgDlgBtn):TModalResult;

      {: O método **@name** verifica se o componente fornecido tem uma relação com **db** e o conteúdo foi alterado}
      public class function isValueDbChanged(Sender: TComponent): Boolean;

      public class function TextWidthChar(AFont: TFont): Integer;

      {: O método **@name** retorna o mapa de bits da posição aBit. Ou seja:
         a função move o bit para a esquerda aBits posição.
          
         - **NOTA**
           - Como o mapa de bits possui 4 bytes este método gera exceção
           se aBit for maior que 32.

         - Example:
           - Command is: 00000100 shl 2 (shift left 2 bits)
           - Action is:  00000100 <- 00 (00 gets added to the right of the value; left 00 "disappears")
           - Result is:  00010000  
      }
      function FMb_Bits(const aBit: Byte): Longint;

      {: O método @name Executa o browser padrão do sistema operacional.

         - Exemplo:

           ```pascal

             program Project1;
              uses
                Interfaces,
                mi_rtl_ui_methods;
             begin

              TUiMethods.ShowHtml('https://wiki.freepascal.org/Webbrowser');

             end.
           ```
      }
      Public class Procedure ShowHtml(URL:string);override;
    end;


implementation

  class function TUiMethods.CreateAppendFields(ATemplate: ptString) : DmxIDstr; 
     var  S : DmxIDstr;
  begin
    {$IFDEF CPU32}
      //Length(Result) = 8 bytes
       S := fldAPPEND + #0#0#0#0#0#0#0;
       Move(ATemplate, S[2], 4);
    {$ENDIF}

    {$IFDEF CPU64}
      //Length(Result) = 8+4=13 bytes
      S := fldAPPEND + #0#0#0#0#0#0#0#0#0#0#0;
      Move(ATemplate, S[2], 8);
    {$ENDIF}
    result := S;
  end;

  class function TUiMethods.CreateBlobField(Len: integer; AccMode,Default: byte) : DmxIDstr;
    var  S : DmxIDstr;
  begin
    {$IFDEF CPU32}
        //Length(Result) = 7 bytes
        S := fldBLOb + #0#0#0#0#0 + chr(AccMode) + chr(Default);
        Move(Len, S[2], sizeof(Len));
    {$ENDIF}

    {$IFDEF CPU64}    //8 bytes para um ponteiro com os dados do campo memo por ser um stringlist.
       //Length(Result) = 7 bytes    
       S := fldBLOb + #0#0#0#0#0#0#0#0#0 + chr(AccMode) + chr(Default);
       Move(Len, S[2], sizeof(Len));
    {$ENDIF}
    result := S;
  end;

  class function  TUiMethods.CreateEnumField(ShowZ: boolean; AccMode,Default: LongInt;AItems: PSItem) : DmxIDstr;
  begin
    {$IFDEF CPU32}
      //Length(result) = 11   
//       Result := fldENUM + #0#0#0#0 + AnsiChar(ShowZ) + chr(AccMode) + IntToStr(Default);
       Result := fldENUM + #0#0#0#0 + AnsiChar(ShowZ) + chr(AccMode) + #0#0#0#0;;
       Move(AItems, Result[2], 4);
    {$ENDIF}
    {$IFDEF CPU64}
       //Length(result) = 15
//       Result := fldENum + #0#0#0#0#0#0#0#0 + AnsiChar(ShowZ) + chr(AccMode) + IntToStr(Default);
       Result := fldENum + #0#0#0#0#0#0#0#0 + AnsiChar(ShowZ) + chr(AccMode) + #0#0#0#0;
       Move(AItems, Result[2], 8);
       Move(Default, Result[12], 4);
    {$ENDIF}
  end;

  class function TUiMethods.CreateCheckBoxField(CharNumberField: AnsiChar;ShowZ: boolean; AccMode,Default: byte;AItems: PSItem) : AnsiString;
     {
       AItems deve retorna um templete com o seguinte formato:

       fldCheckBox + #0#0#0#0 + AnsiChar(ShowZ) + chr(AccMode) + chr(Default) +
        \[KA] ~Usuário auxiliar                ~'^R+#0
        \[KA] ~Usuário lider                   ~'^R+#0
        \[KA] ~Operador do sistema             ~'^R+#0
        \[KA] ~Operador do sistema: modo ajuste~'^R+#0
        \[KA] ~Usuário diretor                 ~'^R+#0
     }

    Var
      P : PSItem;
//      S : AnsiString;
  begin
    {Formata a lista aItems com o modelo acima }
    P := AItems;

    result := '';
    while P <> nil do
    Begin

      result := result + '\[K'+CharNumberField+ '] ~' + P.Value^+ '~' + char(AccMode);

  //    NNewStr(P.Value,S);
      P := P.Next;
    end;

    DisposeSItems(P);
  end;

  class function TUiMethods.CreateTSItemFields(ATemplates: PSItem) : DmxIDstr;
  begin
    {$IFDEF CPU32}
      //Length(result)=5
      Result := fldSItems + #0#0#0#0;//#0#0#0;
      Move(ATemplates, Result[2], 4);
    {$ENDIF}
    {$IFDEF CPU64}
     //Length(result)=9
      Result := fldSItems + #0#0#0#0#0#0#0#0;//#0#0#0;
      Move(ATemplates, Result[2], 4+4);

    {$ENDIF}

   // Result := S;
  end;

  class function TUiMethods.CreateOptions(Default: LongInt; AItems: PSItem): DmxIDstr;
  begin
    {$IFDEF CPU32}
      //Length(Result) = 9
       Result := CharListComboBox + #0#0#0#0 + #0#0#0#0;
      //Move o poneiro de SItem para a posição 2
       Move(AItems, Result[2], 4);
       //Move o poneiro de default para a posição 6
       Move(Default, Result[6], sizeof(Default));
    {$ENDIF}
    {$IFDEF CPU64}
       //Length(Result) = 13
       Result := CharListComboBox + #0#0#0#0#0#0#0#0 + #0#0#0#0;
       //Move o poneiro de SItem para a posição 2
       Move(AItems, Result[2], 8);
       //Move o poneiro de default para a posição 10
       Move(Default, Result[10], sizeof(Default));
    {$ENDIF}
  end;


  class function TUiMethods.GetMaxTViRect: TViRect;
  Begin
    If (Application<>nil)
    Then with Application do
         Begin
           Result.Assign(Origin.X,
                         Origin.y,
                         size.x,
                         size.y);                         ;
         end
    Else raise TException.Create7('',
                                  'mi.ui.Methods.Pas',
                                  'TUiMethods',
                                  'GetMaxTViRect',
                                  '',
                                  '',
                                  'A class Mi_Application não definido!');
  end;

  class function TUiMethods.AnsiString_to_TCollectionString(Msg: AnsiString
    ): TCollectionString;
    {RECEBER: Em MSG um string longo separado por
               ^M = Final de linha
               ^C = O string e centralizado
     RETORNA: TCollectionString formatado.
    }

    Var
      I      : Integer;
      S      : ShortString;
  Begin
    Result  := TCollectionString.Create(1,1,false);
    I := 1;
    While i <=  Length(Msg) do
    Begin
      S := '';
      While (i <=  Length(Msg)) and (Not (Msg[i] in [^M,^J])) do
      Begin
        S := S + Msg[i] {+^M};
        Inc(i);
      end;
      Result.NewStr(S);
      Inc(i);
    end;
  end;

  class function TUiMethods.MsgDlgButtons_To_MsgDlgBtn(
    Buttons: TMI_MsgBox.TMsgDlgButtons): TMI_MsgBox.TArray_MsgDlgBtn;
    Var
      B  : TMI_MsgBox.TMsgDlgBtn;
      I  : Integer;
  Begin
    FillChar(Result, SizeOf(Result), 0);
    { Button order is hard-coded in Windows. We follow their conventions here. }
    with TMI_MsgBox do
    begin
      if Buttons = mbYesNoCancel then
      begin
        Result[0] := mbYes;
        Result[1] := mbNo;
        Result[2] := mbCancel;
      end;

      if Buttons = mbYesNo then
      begin
        Result[0] := mbYes;
        Result[1] := mbNo;
//        Result[2] := mbNone;
      end;

      if Buttons = mbOkCancel then
      begin
        Result[0] := mbOk;
        Result[1] := mbCancel;
//        Result[2] := mbNone;
      end;

      if Buttons = [mbOk] then
      begin
        Result[0] := mbOk;
//        Result[1] := mbNone;
//        Result[2] := mbNone;
      end;


      if Buttons = mbAbortRetryIgnore then
      begin
        Result[0] := mbAbort;
        Result[1] := mbRetry;
        Result[2] := mbIgnore;
      end;

      I := 0;
      for B := Low(TMsgDlgBtn) to High(TMsgDlgBtn) do
        if B in Buttons then
        begin
          Inc(I);
          if I > Ord(High(TMsgDlgBtn))
          then raise TException.Create7('',
                                  'mi.ui.Methods.Pas',
                                  'TUiMethods',
                                  'MsgDlgButtons_To_MsgDlgBtn',
                                  '',
                                  '',
                                  'Muitos botões especificados para caixa de mensagem');
        end;

    end;

  end;

  class function TUiMethods.FStrSelection(S:AnsiString):AnsiString;
    {Retorna a primeira palavra de S que estiver entre ~ ~}
    Var
      APos: SmallInt;
  Begin
    APos := Pos('~',S);
    If (Apos <> 0) Then
    Begin
      delete(S,1,Apos);
      APos := Pos('~',S);
      If APos <> 0 Then
        FStrSelection := Copy(S,1,APos-1)
      else  Begin
              raise TException.Create7('',
                                    'mi.ui.methods.mi_msgbox_lcl_form',
                                    'TUiMethods_mi_msgbox_lcl',
                                    'FStrSelection',
                                    '',
                                    '',
                                    ParametroInvalido);
            End;
    End
    Else
      FStrSelection := '';
  End;

  class procedure TUiMethods.EliminaTilDeTodasAsStrings(
    ATCollectionString: TCollectionString; var aFrist_Item_Valid: Integer);
  Var
    I    ,
    APos : Integer;
    S    : TString;
  Begin
    aFrist_Item_Valid := -1;
    if ATCollectionString.Count>0 then
    With ATCollectionString do
    For I := 0 to ATCollectionString.Count-1 do
    Begin
      S := tString(PItemList(Items)^[i]^);
      aPos := Pos('~',S);


      While APos <> 0 do
      Begin
        tString(PItemList(Items)^[i]^)[APos] := ' ';

        APos := Pos('~',TString(PItemList(Items)^[i]^));

        //Seleciona a primeira op��o valida
        if (apos <> 0) and (aFrist_Item_Valid = -1)
        then aFrist_Item_Valid := I;

        S := tString(PItemList(Items)^[i]^);
      End;
    End;
  End;

  class function  TUiMethods.GetModalResult(ButtonDefault: TMI_MsgBox.TMsgDlgBtn): TModalResult;
  begin
    result := TMI_MsgBox.MrNone;
  end;

  //Checks whether the given component has a db-relation and contents were changed
  class function TUiMethods.isValueDbChanged(Sender: TComponent): Boolean;
    var
      tmp_Field: TField;
      dlink: TObject;
    begin

      dlink := TObject(TControl(Sender).Perform(CM_GETDATALINK, 0, 0));
      if dlink is TFieldDataLink then
      begin //if there is a DataLink (see e.g. TcxDBButtonEdit.CMGetDataLink)
        tmp_Field := (dlink as TFieldDataLink).Field;
        result :=  Assigned(tmp_Field)  and not(VarSameValue(tmp_Field.OldValue, tmp_Field.Value));
      end
      else result := false;
    end;

  class function TUiMethods.TextWidthChar(AFont: TFont): Integer;
  var
    bmp: TCustomBitmap;
  begin
    Result := 0;
    bmp := TCustomBitmap.Create;
    try
      bmp.Canvas.Font.Assign(AFont);
      Result := bmp.Canvas.TextWidth('AbcXdFGHIJKLMNopqRstuVxZ32489738') div 32;
  //    WidthChar  := MyGetTextWidth('AbcXdFGHIJKLMNopqRstuVxZ32489738',(aOwner as TScrollingWinControl).Canvas.font)  div 32;

    finally
      bmp.Free;
    end;
  end;
   
  function TUiMethods.FMb_Bits(const aBit: Byte): Longint;
  Begin
    If aBit <> 0
    Then Result := Mb_Bit01 Shl aBit
    else Result := Mb_Bit00;
  end;

  class Procedure TUiMethods.ShowHtml(URL: string);

    var
      v: THTMLBrowserHelpViewer;
      BrowserPath, BrowserParams: string;
      p: LongInt;
      BrowserProcess: TProcessUTF8;
    begin
      v:=THTMLBrowserHelpViewer.Create(nil);
      try
        v.FindDefaultBrowser(BrowserPath,BrowserParams);
        //debugln(['Path=',BrowserPath,' Params=',BrowserParams]);

        //URL:='http://www.lazarus.freepascal.org';
        p:=System.Pos('%s', BrowserParams);
        System.Delete(BrowserParams,p,2);
        System.Insert(URL,BrowserParams,p);

        // start browser
        BrowserProcess:=TProcessUTF8.Create(nil);
        try
          BrowserProcess.CommandLine:=BrowserPath+' '+BrowserParams;
          BrowserProcess.Execute;
        finally
          BrowserProcess.Free;
        end;
      finally
        v.Free;
      end;
    end;



end.

