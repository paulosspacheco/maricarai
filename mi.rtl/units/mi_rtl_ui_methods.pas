unit mi_rtl_ui_methods;

{$mode Delphi}

interface

uses
  Classes, SysUtils,db
//  ,Controls
//  ,DBCtrls
//  ,Graphics
//  ,LazHelpHtml
  ,Variants,UTF8Process
  ,System.UITypes
  ,mi_rtl_ui_consts;


  type

    { TUiMethods }

    TUiMethods = class(TUiConsts)

      //{: A class function **@name** é usado para encandear Templates do tipo enumerado}
      //public class function CreateEnumField(aShowZ: boolean; aAccMode:Byte;aDefault: LongInt;aItems: PSItem) : TDmxStr_ID;overload;
      //{: A class function **@name** é usado para encandear Templates do tipo enumerado}
      //public class function CreateEnumField(ShowZ: boolean; AccMode:Byte;Default: LongInt;AItems: PSItem;
      //                                     aDataSouce: TDataSource;aKeyField,aListField:AnsiString) : TDmxStr_ID;overload;






      {: A class function **@name** é usado para informar uma lista de opções para o campo.

         - **NOTA**
           O campo que pode receber uma lista pode ser de qualquer tipo, exceto os tipos:
           - fldENum,fldENum_db,FldBoolean e FldRadioButton.

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
//      public class function CreateOptions(access:byte;AItems: PSItem) : TDmxStr_ID;

      public class Function GetMaxTViRect : TViRect;
      public class Function AnsiString_to_TCollectionString(Msg: AnsiString): TCollectionString;
      public class Function MsgDlgButtons_To_MsgDlgBtn(Buttons: TMI_MsgBox.TMsgDlgButtons): TMI_MsgBox.TArray_MsgDlgBtn;
      public class function FStrSelection(S:AnsiString):AnsiString;
      public class Procedure EliminaTilDeTodasAsStrings(ATCollectionString: TCollectionString;Var aFrist_Item_Valid : Integer);
      public class function  GetModalResult(ButtonDefault: TMI_MsgBox.TMsgDlgBtn):TModalResult;

      {: O método **@name** verifica se o componente fornecido tem uma relação com
         **db** e seu conteúdo foi alterado}
      public function isValueDbChanged(Sender: TComponent): Boolean;virtual;


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

    end;


implementation


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

  //Verifica se o componente fornecido possui uma relação db e se o conteúdo foi alterado
  function TUiMethods.isValueDbChanged(Sender: TComponent): Boolean;
  begin
    result := false;
  end;

  function TUiMethods.FMb_Bits(const aBit: Byte): Longint;
  Begin
    If aBit <> 0
    Then Result := Mb_Bit01 Shl aBit
    else Result := Mb_Bit00;
  end;



end.

