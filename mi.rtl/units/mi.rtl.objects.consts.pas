unit mi.rtl.Objects.Consts;
{:< - A Unit **@name** reune todos as contantes da unit **TObjects** globais usados pela class TObjects e suas descendências do pacote **mi.rtl**.

    - **NOTAS**
      - Esta unit foi testada nas plataformas: win32, win64 e linux.

    - **VERSÃO**
      - Alpha - 1.0.0

    - **HISTÓRICO**
      - Criado por: Paulo Sérgio da Silva Pacheco e-mail: paulosspacheco@@yahoo.com.br
        - **18/11/2021** 10:56 a ?? - Criar a unit mi.rtl.objects.Consts.pas
        - **19/11/2021** 20:35 a 21:22 - Conclusão da classe **TObjectsConsts**
        - **13/12/2021** 21:00 a 22:10 - Documentar unidade.
        - **22/05/2024** 08:00 a 11:30 - Implementação do campo FldENum_db

    - **CÓDIGO FONTE**:
      - @html(<a href="../units/mi.rtl.objects.consts.pas">mi.rtl.objects.consts.pas</a>)          
    
 }

{$IFDEF FPC}
  {$MODE Delphi} {$H+}
{$ENDIF}


interface

uses
  Classes, SysUtils,db, mi.rtl.objects.types
  ,mi.rtl.MiStringListBase

  ;

  type
    TPushMsgErro = Procedure (const Str: AnsiString);
  var
    PushMsgErro : TPushMsgErro = nil;

  {: - A class **@name** usada para separar as contantes da unit **TObjects** do pacote **mi.rtl**.
  }
  type
  TObjectsConsts =
       class(TObjectsTypes)
               {: True zera a memória alocada por FGetMem}
         public Const  OkZeraFGetMem    : Boolean = True;

         public const ErrorInfo : Integer = 0;   {:< Stream error info }

         public
         //---------------------------------------------------------------------------
         {$REGION 'CONSTANTES DO STREAM ERROR STATE MASKS'}
            Const stOk         =  0;  //:< - No stream error
            Const stError      = -1;  //:< - Access error
            Const stCreateError= -2;  //:< - Initialize error
            Const stReadError  = -3;  //:< - Stream read error
            Const stWriteError = -4;  //:< - Stream write error
            Const stGetError   = -5;  //:< - Get Class error
            Const stPutError   = -6;  //:< - Put Class error
            Const stSeekError  = -7;  //:< - Seek error in stream
            Const stOpenError  = -8;  //:< - Error opening stream
            Const StShareError = -9;  //:< - Erro de compartilhamento
         {$ENDREGION}
         //---------------------------------------------------------------------------

         //---------------------------------------------------------------------------
         {$REGION 'File mode constantes'}
                                                      {   2109876543210}
            Const FmReadOnly       = fmOpenRead;      //:<          000
            Const FmWriteOnly      = fmOpenWrite;     //:<          001
            Const FmReadWrite      = fmOpenReadWrite; //:<          010

            Const FmDenyALL        = fmShareCompat or fmShareExclusive;//:<      0010000
            Const FmDenyWrite      = fmShareCompat or fmShareDenyWrite;//:<      0100000
            Const FmDenyRead       = fmShareCompat or fmShareDenyRead; //:<      0110000
            Const FmDenyNone       = fmShareCompat or fmShareDenyNone; //:<      1000000


            Const FmChildProcesses = $0080;           //:<     10000000
            Const FmCreate         = $0100;           //:<    100000000

            {TODO -cBUG: 2023/09/07 : O modo FmWait não está funcionando no linux.
                                      Entender como faço no windows para reproduzir no linux.}
            {: O flag **@name** indica que quando o arquivo estiver ocupado a
               rotina de abertura deve esperar até desocupar.}
            Const FmWait           = $0200 ;          //:<   1000000000

            Const FmMemory         = $0400 ;          //:<  10000000000 - Indica que o arquivo esta em tStreamemoria
            Const FmMemory_Temp    = $0800 ;          //:< 100000000000 - Indica que o arquivo e temporario e esta em tStreamemoria
          
            Const stOpenRead  = FmReadOnly ;          //:<          000 - Read access only
            Const stOpenWrite = FmWriteOnly;          //:<          001 - Write access only
            Const stOpen      = fmOpenReadWrite;          //:<          010 - Read/write access
            Const StCreate    = FmCreate   ;          //:<    100000000 - Create new file
         {$ENDREGION}
         //---------------------------------------------------------------------------

         //---------------------------------------------------------------------------
         {$REGION 'As variáveis abaixo indica o modo como a aplicação foi compilada.'}

            {: - A constante **@name** indica se a aplicação  CGI deve ser compilado no modo console.
            }
            {$IFDEF CONSOLE} 
              IsApp_Console      : Boolean = True;
            {$ELSE}
              IsApp_Console      : Boolean = false;
            {$ENDIF}

            {: - A constante **@name** indica se a aplicação é gráfica independente de usar vcl ou não.
            } 
            {$IFDEF GUI} 
              IsApp_ServerHttp         : Boolean = True;
            {$ELSE}
              IsApp_ServerHttp          : Boolean = false;
            {$ENDIF}

            {: - A constante **@name** indica se a Aplicação é CGI.
               - **NOTA**
                 -Ignora todo acesso do teclado e video do console usada como aplicações web, console
                  ou GUI quando usado como pacote em tempo de designer.}
            {$IFDEF App_CGI}
              IsApp_Cgi          : Boolean = True;
            {$ELSE}
              IsApp_Cgi          : Boolean = false;
            {$ENDIF}


            {: - A constante **@name** indica se a aplicação web é compilada como dll deve ser executada em conjunto com browser.}
            {$IFDEF App_FastCgi}
              IsApp_FastCgi  : Boolean = True;
            {$ELSE}
              IsApp_FastCgi  : Boolean = False;
            {$ENDIF}


            {: - A constante **@name** indica se a aplicação LCL.}
            {$IFDEF App_LCL}
              IsApp_LCL           : Boolean = True;
            {$ELSE}
              IsApp_LCL          : Boolean = false;
            {$ENDIF}


            {: - A constante **@name** indica se a Aplicação App_RestApi.
                 - **NOTA**
                   - Ignora todo acesso ao teclado e video do console usada como 
                     aplicações servidor de dados.}
            {$IFDEF App_RestApi}
              IsApp_RestApi : Boolean = True;
            {$ELSE}
              IsApp_RestApi : Boolean = false;
            {$ENDIF}

         {$ENDREGION}
         //---------------------------------------------------------------------------

          
          const coIndexError = -1; //:< Index out of range
          const coOverflow   = -2; //:< Overflow

          {---------------------------------------------------------------------------}
          {         VMT HEADER CONSTANT - HOPEFULLY WE CAN DROP THIS LATER            }
          {---------------------------------------------------------------------------}
          const vmtHeaderSize = 8;    //:< VMT header size
          
          {$REGION 'MAXIUM DATA SIZES'                                                }
          //---------------------------------------------------------------------------
            const MaxBytes = MAX_BYTE; //:< Maximum data size
            const MaxWords = MAX_WORD; //:< Max word data size
            const MaxSmallWords = MAX_SMALL_WORD;  //:< Max word data size

            const  MaxPtrs = MAX_ARRAY_PTR; //:< Max ptr data size
            const  MaxCollectionSize = MaxPtrs; //:< Max collection size
          {$ENDREGION}
          //---------------------------------------------------------------------------

            //----------------------------------------------------------------------
            {$REGION ' File open modes. obs: Compatibilidade com o passado'}
 (*
                {: - Modo somente de leitura com compatibilidade com o DOS
                   - REFERÊNCIA:
                     - Veja fmOpenRead or fmShareCompat
                }
                const  FmReadOnly       = fmOpenRead or fmShareCompat;

                {: - Modo somente de escrita com compatibilidade com o DOS
                   - REFERÊNCIA:
                     - Beja: fmOpenWrite or fmShareCompat
                }
                const  FmWriteOnly      = fmOpenWrite or fmShareCompat;

                {: - Modo de leitura e escrita com compatibilidade com o DOS
                   - REFERÊNCIA:
                     - Veja fmOpenReadWrite or fmShareCompat
                }
                const  FmReadWrite      = fmOpenReadWrite or fmShareCompat;

                {: - A constante **FmDenyALL** combinada com as constantes FmReadOnly, fmWriteOnly
                     e FmReadWrite é usada para setar a variável fileMode com objetivo de não
                     permite que o arquivo seja usado por mais de uma conexão.
                      - Exemplo:
                        - fileMode = FmReadOnly or FmDenyALL
                        - fileMode = FmWriteOnly or FmDenyALL
                        - fileMode = FmReadWrite or FmDenyALL
                }
                const FmDenyALL        = fmShareExclusive;

                {: - A constante **FmDenyWrite** combinada com as constantes FmReadOnly, fmWriteOnly
                     e FmReadWrite é usada para setar a variável fileMode com objetivo de não
                     permite escrita no arquivo.
                      - Exemplo:
                        - fileMode = FmReadOnly  or FmDenyWrite
                        - fileMode = FmWriteOnly or FmDenyWrite
                        - fileMode = FmReadWrite or FmDenyWrite
                }
                const FmDenyWrite      = fmShareDenyWrite;

                {: - A constante **FmDenyRead** combinada com as constantes FmReadOnly, fmWriteOnly
                     e FmReadWrite é usada para setar a variável fileMode com objetivo de não
                     permite leitura no arquivo.
                      - Exemplo:
                        - fileMode = FmReadOnly  or FmDenyRead
                        - fileMode = FmWriteOnly or FmDenyRead
                        - fileMode = FmReadWrite or FmDenyRead
                }
                const FmDenyRead       = fmShareDenyRead;

                {: - A constante **FmDenyNone** combinada com as constantes **FmReadOnly**, **fmWriteOnly**
                     e **FmReadWrite** é usada para setar a variável **fileMode** com objetivo de permite leitura no arquivo.
                      - Exemplo:
                        - fileMode = FmReadOnly  or FmDenyNone
                        - fileMode = FmWriteOnly or FmDenyNone
                        - fileMode = FmReadWrite or FmDenyNone
                }
                const FmDenyNone       = fmShareDenyNone or fmShareCompat;
*)
            {$ENDREGION }
            //----------------------------------------------------------------------



          const  StreamTypes: PStreamRec = Nil; //:< Stream types reg
          Const AnsiChar_Control_Template : AnsiCharSet = [#0..#31,fldCONTRACTION]; //:< AnsiChar_Control_Template : AnsiCharSet = [#0..#31,fldCONTRACTION,^a..^z,^A..^Z];


          // Variaveis usada no controle do acesso a pessoas não autorizada caso o usuario com acesso esqueça um formulário aberto.
       // se Okprocessing = True  = O Sistema esta em loop fazendo um processamento.
        const Okprocessing              : Boolean = false;

       // OkprocessingControlTime = true Habilita o controle de ociosidade dos dialogos
        const OkprocessingControlTime : Boolean = true;

       // TimeOut = Tempo em segundos de ociosidade permitida
        const OkOkprocessingTime        : Longint = 5 * 60;  //= 5 minuts
    //    OkOkprocessingTime        : Longint = 1 * 10;  //= 5 minuts

    //    OkOkprocessingTime        : Longint = 1 * 5;  //= 5 segundos

       //Ação caso o sistema fique ocioso
        const OkProcessingTime_Action    : TOkProcessingTime_Action = OkProcessingTime_Action_Password;

       // Tempo ocorrido do ultimo evento
        const OkOkprocessingClockBegin  : DWord = 0;

      {: Habilita TempoDeTentativas nas leitura e escritas ao arquivo }
      Const OkTempoDeTentativas : Boolean = true;

      {: TimeOut = Tempo em segundos de tentativos nos processos de abertura, leitura e
          gravacao de arquivos }
      Const TempoDeTentativas   : Longint = 10;


        public Class Function SetOkprocessing(aOkprocessing : Boolean) : Boolean;
        public class procedure FreeAndNil(var Obj);
        public class procedure FreeAndNilSafe(var aObj);

        {: -
        }
        public class function NewStr (Const S: AnsiString): ptstring;
        public class function NewSItem(const Str: tString; ANext: PSItem): PSItem;
        public class Function CloneSItems(Const Items: PSItem):PSItem;

        {: A class function **@name** é necessario porque um Template pode ser uma lista de Strings, onde está lista pode
           ser inserida em um objeto e discartada ao destruir o objeto.
        }
        public class Function CopyTemplateFrom(Const aTemplate:tString): tString;

        public class Procedure PushSItem(Const Str: AnsiString; Var ANext: PSItem);

        {: Coloca uma string na pilha  }
        public class Procedure Push_MsgErro(Const Str: AnsiString);virtual;

       end;

implementation

  class function TObjectsConsts.SetOkprocessing(aOkprocessing: Boolean  ): Boolean;
  Begin
    Result := Okprocessing;
    Okprocessing := aOkprocessing;
  end;

  class procedure TObjectsConsts.FreeAndNil(var Obj);
    //var
    //  Temp: TObject;
  begin
    FreeAndNilSafe(Obj);
//    SysUtils.FreeAndNil(Obj);
    //Try
    //  Temp := TObject(Obj);
    //  Pointer(Obj) := nil;
    //  Temp.Free;
    //
    //Except
    //  Pointer(Obj) := nil;
    //end;

  end;

  class procedure TObjectsConsts.FreeAndNilSafe(var aObj);
  begin
    //SysUtils.FreeAndNilSafe(aObj);

    if TObject(aObj) = nil then
      exit;
    try // slower but paranoidically safe
      TObject(aObj).Destroy;
    except
    end;
    TObject(aObj) := nil; // we could do it AFTER destroy
  end;


  class function TObjectsConsts.NewStr(const S: AnsiString): ptstring;
    Var
      Len : Byte;
  BEGIN
    if Length(S) > 255
    then Len := 254
    else Len := Length(S);

     If (S = '')
     Then Result := Nil
     Else Begin               // Empty returns nil
            GetMem(Result, Len + 1); // Allocate memory
            Result^[0] := Ansichar(Length(S));
            Move(S[1],Result^[1],Length(S));
     End;
  END;

  class function TObjectsConsts.NewSItem(const Str: tString; ANext: PSItem): PSItem;
  var
    Item: PSItem;
  begin
    New(Item);
    Item^.Value := NewStr(Str);
    Item^.Next := ANext;
    NewSItem := Item;
  end;

  class Function TObjectsConsts.CloneSItems(Const Items: PSItem):PSItem;
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

  class Function TObjectsConsts.CopyTemplateFrom(Const aTemplate:tString): tString;
     Var P1  : PSItem;
         Ds : TDataSource;
         KeyField   : Ansistring;
         ListFields : Ansistring;
         Default : Longint;
  Begin
    If aTemplate <> ''
    Then Case aTemplate[1] of
             //<Os Campos abaixo pode ser uma lista de PSItem
             fldENum,
             fldENum_db: Begin
                           Move(aTemplate[EnumField_ofs.TypeField],P1,sizeof(pSitem));

                           move(aTemplate[EnumField_ofs.Default],Default,Sizeof(TEnumField.Default));

                           if aTemplate[1] = fldENUM
                           Then Result := CreateEnumField({ShowZ  } boolean(Byte(aTemplate[EnumField_ofs.ShowZ])),
                                                          {AccMode} Byte(aTemplate[EnumField_ofs.AccMode]),
                                                          {Default} Default,
                                                          {AItems}  CloneSItems(P1))
                           else begin
                                  move(aTemplate[EnumField_ofs.DataSource],Ds,Sizeof(TEnumField.DataSource));
                                  move(aTemplate[EnumField_ofs.KeyField],KeyField,Sizeof(TEnumField.KeyField));
                                  move(aTemplate[EnumField_ofs.ListField],ListFields,Sizeof(TEnumField.ListField));

                                  Result := CreateEnumField({ShowZ  } boolean(Byte(aTemplate[EnumField_ofs.ShowZ])),
                                                          {AccMode}   Byte(aTemplate[EnumField_ofs.AccMode]),
                                                          {Default}   Default,
                                                          {AItems}    CloneSItems(P1),
                                                          {DataSource}DS,
                                                          {KeyField}  KeyField,
                                                          {ListField} ListFields);
                                 end;


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

  class procedure TObjectsConsts.PushSItem(Const Str: AnsiString; var ANext: PSItem);
    var
      Item     : PSItem;

    Procedure add(St:ShortString);
    Begin
      New(Item);
      Item^.Value := NewStr(St);//mi.Objects.NewStr(S);
      Item^.Next  := ANext;
      ANext       := Item;
    end;

    var
      S        : AnsiString;
      i,len    : Integer;
  begin
    s := '';
    len := length(str);
    For i := Len downto 1 do
    begin
      case str[i] of
       ^M : begin
              add(s);
              s := '';
            end;
      else begin
             s:= str[i]+s;
           end;
      end;
    end;

    if s = ''
    Then s := ' ';

    add(s);

  end;

  //class procedure TObjectsConsts.PushSItem(Str: AnsiString; var ANext: PSItem);
  //  var
  //    Item     : PSItem;
  //    S        : AnsiString;
  //    I    : Integer;
  //    Primeiro_CrtlM : Boolean;
  //begin
  //
  //    Repeat
  //      CtrlSleep(0);
  //      S := '';
  //      Primeiro_CrtlM := true;
  //
  //      //Pega a ultima linha da string
  //      If (Str<>'') and (Length(Str) > 0)
  //      Then For i := Length(Str) downto 1 do
  //            Begin
  //              If Primeiro_CrtlM and (str[i] = ^M)
  //              Then Begin
  //                     Primeiro_CrtlM := false;
  //                     Insert(str[i],S,1);
  //                   end
  //              Else If (Not Primeiro_CrtlM) and (str[i] = ^M)
  //                   Then Break
  //                   Else Insert(str[i],S,1);
  //            end;
  //
  //      If S = ''
  //      Then S := ' ';
  //
  //      If Length(Str)-Length(S) > 0
  //      Then Delete(Str,Length(Str)-Length(S)+1,Length(S))
  //      Else Str := '';
  //
  //      If S <> ''
  //      Then Begin
  //              New(Item);
  //              while (Pos(^M,S)<> 0) and (length(S)>0) do
  //                 delete(S,Pos(^M,S),1);
  //
  //              Item^.Value := NewStr(S);//mi.Objects.NewStr(S);
  //              Item^.Next  := ANext;
  //              ANext       := Item;
  //           end;
  //
  //    Until Str = '';
  //
  //end;

  class procedure TObjectsConsts.Push_MsgErro(Const Str: AnsiString);
  Begin
    PushSItem(Str,ListaDeMsgErro);
  end;

initialization
  PushMsgErro := @TObjectsConsts.Push_MsgErro;

end.

