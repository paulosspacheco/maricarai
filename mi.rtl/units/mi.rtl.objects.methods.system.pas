{$H-}
unit mi.rtl.Objects.Methods.System;
{:<
 ****************************************************************************************
  SISTEMA : Nort Soft Data Base
  MODULO  : MARICARAY
  AUTOR   : Paulo Pacheco
  ---------
  HISTORIA
  ---------
  DATA     HARA  HORA  OCORRENCIA
  -------- ----- ----- ------------------------------------------------------------------
  01/08/02 08:00       Implementacao inicial
  08/08/02       23:00 Implementacao Final
  25/01/22             Convertido para lazarus
 *****************************************************************************************
}

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface

Uses
  Classes,SysUtils,crt,
  mi.rtl.objects.Methods,
  mi.rtl.objects.Methods.Exception,
  mi.rtl.objects.methods.StreamBase.Stream,
  mi.rtl.objects.methods.StreamBase.Stream.FileStream,
  mi.rtl.objects.methods.StreamBase.Stream.MemoryStream.BufferMemory,
  mi.rtl.objects.methods.Collection.FilesStreams
  ;

  type
    TObjectsSystem = class (TObjectsMethods)

      class function FlushDOSFile(VAR F : File):Boolean;

      class function BlockRead(var F: File; var Buf; Count: Word):Word;
      class function BlockWrite(var F: File; var Buf; Count: Word):Word;
      class function Seek (VAR F:FILE ;Const NR: Longint):SmallInt ;
      class function AppendText (VAR F:Text;AFileMode:Word):SmallInt ;

      class function Rewrite (VAR F:Text;AFileMode:SmallWord):SmallInt ;overload;
      class function Rewrite (VAR F:File;Const aRecLen:Integer;AFileMode:SmallWord):SmallInt ;overload;

      class function Close(Var F:File):Boolean; Overload;
      class function Close(Var F:Text):Boolean;Overload;


      class function Reset (VAR F:FILE ;Const aRecLen:Integer;Const AFileMode:SmallWord):Integer ;Overload;

      class function OpenText(VAR F:Text;Mode: Word{StCreate,St}):SmallInt ;

      class function Reset(VAR F:Text ;Const AFileMode:SmallWord):SmallInt ;Overload;

      class function FileFlushBuffers(VAR F : File):Boolean;overload;
      class function FileFlushBuffers(VAR F : File; const Ok_FileFlushBuffers : Boolean):Boolean;Overload;

      class function Size_LinFeed_Text(aFileName : AnsiString):SmallInt ;

      class procedure FTempoDeTentativas(Const HcHelp:SmallInt);


      class function Is_TFileOpen(const a_TFile : TStream{TFile}):Boolean;



      class function CopyFiles(const SourceName, TargetName: AnsiString):Integer;
      class function DeleteFiles(const SourceName:AnsiString):Integer;


      class function Existe_Espaco_em_Dobro : Boolean;


      {Declarado no dataSeguimento para agilizar a leitura(GetRec) e escrita(PutRec)}
      Const BlocksRead    : Word = 0;
      Const BlocksWrite   : Word = 0;
    end;

Implementation


  class function TObjectsSystem. Existe_Espaco_em_Dobro : Boolean;
  Var
    SomaDad,SomaIx,Error,DiscoLivre  : int64;
  Begin
    if DiskFree(0,DiscoLivre) = 0
    then begin
           Error := FileSizes('*.Tb',SomaDad);
            if Error = 0
            Then Error := FileSize('*.Ix',SomaIx);

            if (error = 0) and ((SomaDad+SomaIx) < DiscoLivre)
            Then Existe_Espaco_em_Dobro := true
            Else with Mi_MsgBox do Begin
                   Existe_Espaco_em_Dobro := false;
                   MessageBox('Disco cheio. Sao Necessário pelo menos: '+
                              Istr((SomaDad+SomaIx) div 1024,'LLLLLLLLLL')+' KBytes',
                              mtError,
                              mbOKButton,
                              mbok);
                 end;

    end
    else Result := false;
  End;



  class function TObjectsSystem.CopyFiles(const SourceName, TargetName: AnsiString):Integer;
    var
      filesStreams : TfilesStreams ;
  Begin
    try // Finally
      filesStreams := TfilesStreams.Create ;
      try // Excecpt
        With filesStreams do
        Begin
          Mask := SourceName;
          If Status = 0
          Then Result := CopyFiles(TargetName)
          Else Result := ErrorInfo;
        End;

      Except
        IF TaStatus = 0
        Then TaStatus := Erro_Excecao_inesperada;

        Raise TException.Create8('',unitName,ClassName,'CopyFiles',SourceName,'',TStrError.ErrorMessage(TaStatus),'');
      end;

    Finally
      Discard(TObject(filesStreams));
    end;
  end;

  class function TObjectsSystem. DeleteFiles(const SourceName:AnsiString):Integer;
    var
      filesStreams : TfilesStreams ;
  Begin
    try // Finally
      filesStreams := TfilesStreams.Create ;
      try // Excecpt
        With filesStreams do
        Begin
          Mask := SourceName;
          If Status = 0
          Then Result := DeleteFiles()
          Else Result := ErrorInfo;
        End;

      Except
        IF TaStatus = 0
        Then TaStatus := Erro_Excecao_inesperada;
        Raise TException.Create8('',unitName,ClassName,'DeleteFiles',SourceName,'',TStrError.ErrorMessage(TaStatus),'');
      end;

    Finally
      Discard(TObject(filesStreams));
    end;
  end;

  class function TObjectsSystem. Is_TFileOpen(const a_TFile : TStream):Boolean;
  Begin
    Try
      If Not isValidPtr(a_TFile)
      Then Result := False
      else begin
             if a_TFile is TFileStream
             then Result := (a_TFile as TFileStream).IsFileOpen
             else begin
                    Result := true;
                  end;

      end;
    Except
      Result := False;
    end;
  end;


  class procedure TObjectsSystem. FTempoDeTentativas(Const HcHelp:SmallInt);
  BEGIN
    uAnsiChar := ReadKey;
    IF (UAnsiChar = #0) THEN
    BEGIN
      TeclaF  := -ord(readKey);
      IF TeclaF = -18{TAltE}   THEN
      BEGIN
        Mi_MsgBox.InputBox('TEMPO DE ESPERA','Quanto tempo em segundos devo ficar tentando ? ',TempoDeTentativas,'~~\LLLL');
      END;
    END
  END;


  class function TObjectsSystem.FileFlushBuffers(VAR F : File):Boolean;
    Label
      Inicio;
  Begin
    Try
      If (FileRec(F).UserData[Sizeof(FileRec(F).UserData)] = 0) {:< O Registro nao foi alterado}
      Then Begin
             TaStatus := 0;
             exit;
           end;

      If (System.FileSize(F) = 0)
      Then Begin {Obs. Caso se execute um flush em um arquivo com fileSize=0;
                  simplesmente nos próximos acesso ao arquivo ele falhara com o
                  erro Handle do arquivo invalido.}
             Result := false;
             exit;
           end;

      Inicio:
        TaStatus := FileFlushBuffers(FILEREC(F).Handle);
        IF taStatus <> 0 THEN
        BEGIN
          CASE TaStatus OF
            AcessoNegado5,
            AcessoNegado32,
            ErroViolacaoDeLacre  : Begin
                                     delay(1);
                                     goto Inicio;
                                   end;
            ELSE Result       := False;
          End;
        END
        ELSE
        BEGIN
          TaStatus := 0;
          Result := True;
          FileRec(F).UserData[Sizeof(FileRec(F).UserData)] := 0;
        END;

    Finally

    end;

  End;


  class function TObjectsSystem.FlushDOSFile(VAR F : File):Boolean;
  BEGIN
    If FileRec(F).UserData[Sizeof(FileRec(F).UserData)-2] = 0 {Não tem registro travado} {OkTransaction and (Transaction<>nil) and (ok_Set_Transaction)}
    Then Result := FileFlushBuffers(F,false)
    Else Result := FileFlushBuffers(F);
  END;


  class function TObjectsSystem. Rewrite (VAR F:File;Const aRecLen:Integer;AFileMode:SmallWord):SmallInt ;
    {$I-}
  BEGIN
    IF AFileMode AND FmWriteOnly <> 0 THEN
    BEGIN
      AFileMode := AFileMode AND NOT FmWriteOnly ;
      AFileMode := AFileMode OR FmReadWrite ;
    END ;

    IOResult; //Essa instrução inicializa InOutRes para que o próximo acesso ao DOS não gera a Int24
    REPEAT
      FileRec(f).UserData[Sizeof(FileRec(F).UserData)-1] := Byte(FileMode);
      System.Rewrite (F ,aRecLen);
      IOResult;
      Case taStatus of
        0  : Begin
               Close (F );
               Reset (F ,aRecLen,AFileMode );
             END;

        AcessoNegado5,
        AcessoNegado32,
        ErroViolacaoDeLacre  : CtrlSleep (1);
        else
        Begin
          Raise TException.Create7('',
                                    unitName,
                                    className,
                                   'Rewrite',
                                    WideStringToString(FileRec(F).name),
                                    '' ,
                                    TaStatus
                                  );
        end;
      End;
    UNTIL {(AFileMode AND FmWait = 0 ) OR} (TaStatus =0 );

    Result := TaStatus ;

  END ;

  class function TObjectsSystem. Rewrite (VAR F:Text;AFileMode:SmallWord):SmallInt ;
    {$I-}
    Var
      aAFileMode : BYTE;
  BEGIN
    Try
      aAFileMode := system.fileMode;
      system.FileMode   := Byte(AFileMode);
      REPEAT
        IOResult; {Essa instrucao inicializa InOutRes para que
                   a proximo acesso ao DOS nao gera a Int24}
        TextRec(f).UserData[Sizeof(TextRec(F).UserData)-1] := system.FileMode;
        System.Rewrite (F);
        IoResult;
        If (TaStatus <> 0 ) and (aFileMode AND FmWait = 0)
        Then Begin
               Raise TException.Create7('',
                                        unitName,
                                        className,
                                       'Rewrite',
                                        WideStringToString(TextRec(F).name),
                                        '' ,
                                        TaStatus
                                      );

             End
        else CtrlSleep (1);
      UNTIL (TaStatus =0 );

    Finally
      system.FileMode   := Byte(aAFileMode);
      Result:= TaStatus;

    end;
  End;

  class function TObjectsSystem. AppendText (VAR F:Text;AFileMode:Word):SmallInt ;
    {$I-}
    Var
      aAFileMode : BYTE;
  BEGIN
  Try
    aAFileMode := system.fileMode;
    system.FileMode   := Byte(AFileMode) ;

    If Not FileExists(WideStringToString(TextRec(F).Name))
    Then Begin
           Result := Rewrite(F,system.FileMode);
           exit;
         End;

    REPEAT
      IOResult; {Essa instrucao inicializa InOutRes para que
                 a proximo acesso ao DOS nao gera a Int24}
      System.Append(F);
      IoResult;

      If (TaStatus <> 0 ) and (AFileMode AND FmWait = 0 ) Then
      Begin
        Raise TException.Create7('',
                          unitName,
                          className,
                         'AppendText',
                          WideStringToString(TextRec(F).name),
                          '' ,
                          TaStatus
                        );

        exit;
      End
      Else CtrlSleep (1);

    UNTIL (TaStatus =0 );

  Finally
    system.FileMode   := Byte(aAFileMode);
    Result := TaStatus;

  End;


  End;

  class function TObjectsSystem. Seek (VAR F:FILE ;Const NR: Longint):SmallInt ;
    {$I-}
  Var
      aTempoDeTentativas : Longint;
      ClockBegin         : DWord;
      _Progress1Passo    : TProgressDlg_If;

  {    aScreenBuffer      : PVideoBuf;}
  BEGIN
    Try
  //    {$IFDEF TaDebug}Application.Push_MsgErro('Systemm.Seek',ListaDeChamadas);{$ENDIF}
      IOResult; {Essa instrucao inicializa TaStatus para que
               a proximo acesso ao DOS nao gera a Int24}
      {$I+}
      System.Seek(F , NR);
      {$I+}
      IOResult;

      If (TaStatus <> 0 ) and OkTempoDeTentativas
      Then Begin
             Try
               _Progress1Passo := TProgressDlg_If.Create('Aguarde... ','Seek. Codigo: '+Format('%d',[TaStatus]),Delta_Locate,TempoDeTentativas);


               aTempoDeTentativas := TempoDeTentativas ;
               ClockBegin         := GetDosTicks; //Clock;

               WHILE (FileMode AND FmWait <>0 ) AND (TaStatus <> 0 ) and (GetDosTicks - ClockBegin <= Seg_to_MillSeg(Longint(TempoDeTentativas))) DO
               BEGIN
                 _Progress1Passo.IncPosition(GetDosTicks - ClockBegin);

                 CASE TaStatus  OF
                    AcessoNegado5,
                    AcessoNegado32,
                    ErroViolacaoDeLacre  : DELAY (1);
                    ELSE BEGIN
                           Raise TException.Create7('',
                                                    unitName,
                                                    className,
                                                   'Seek',
                                                    WideStringToString(FileRec(F).name),
                                                    '' ,
                                                    TaStatus
                                                  );
                         End;
                 END ;
                 {$I-}
                 System.Seek(F , NR);
                 {$I+}
                 IOResult;

                 IF KeyPressed
                 THEN FTempoDeTentativas(0);
               END ;

             Finally
               TempoDeTentativas := aTempoDeTentativas ;
               Discard(TObject(_Progress1Passo));
             End;
           End;

    Finally
      Seek := IOResult;

    End;
  END ;


  class function TObjectsSystem. BlockRead(var F: File; var Buf; Count: Word):Word;
  {$I-}
  Begin
    Try

  //    {$IFDEF TaDebug}Application.Push_MsgErro('Systemm.BlockRead',ListaDeChamadas);{$ENDIF}
      IoResult;
      System.BLOCKREAD(F,Buf,Count,BlocksRead);
      IoResult;
      BlockRead := BlocksRead;

    Finally

    end;
  End;

  class function TObjectsSystem. BlockWrite(var F: File; var Buf; Count: Word):Word;
  {$I-}
  Begin
    Try
  //    {$IFDEF TaDebug}Application.Push_MsgErro('Systemm.BlockWrite',ListaDeChamadas);{$ENDIF}
      IoResult;
      System.BlockWrite(F,Buf,Count,BlocksWrite);
      IoResult;

      If FlushBuffer and (TaStatus = 0)
      Then FileRec(F).UserData[Sizeof(FileRec(F).UserData)] := 1;

      BlockWrite := BlocksWrite;

    Finally

    end;
  End;


  class function TObjectsSystem. Close(Var F:File):Boolean;
  Begin {Obs. Se Chamar IoResult de Db_Error o ultimo TaStatus � perdido }
  //  {$IFDEF TaDebug}Application.Push_MsgErro('Systemm.Close',ListaDeChamadas);{$ENDIF}
    Ok := system.IoResult=0;
    {$I-}
    System.Close(F);
    {$I+}
    Ok := System.IoResult = 0;
    Close := Ok;

  End;

  class function TObjectsSystem. Close(Var F:Text):Boolean;
  {$I-}
  Begin  {Obs. Se Chamar IoResult de Db_Error o ultimo TaStatus � perdido }
    Ok := System.IoResult=0;
    System.Close(F);
    Ok := System.IoResult = 0;
    Close := Ok;
  End;



  class function TObjectsSystem.Reset (VAR F:FILE ;Const aRecLen:Integer;Const AFileMode:SmallWord):Integer ;
    VAR
      aAFileMode : BYTE;
      aTempoDeTentativas : Longint;
       ClockBegin        : DWord;

      wFileName          : tString;
      _Progress1Passo : TProgressDlg_If;
  BEGIN
    Try
  //    {$IFDEF TaDebug}Application.Push_MsgErro('Systemm.Reset',ListaDeChamadas);{$ENDIF}
      aAFileMode := system.FileMode ;
      system.FileMode   := Byte(AFileMode) ;

      wFileName := WideStringToString(FileRec(F).Name);

      FileRec(F).UserData[Sizeof(FileRec(F).UserData)-1] := Byte(system.FileMode);

      IoResult;         {Essa instrucao inicializa InOutRes para que
                        a proximo acesso ao DOS nao gera a Int24}
      {$I-}
      System.Reset(F , aRecLen );
      {$I+}
      IoResult;

      If ((AFileMode AND FmWait <>0 ) AND (TaStatus <> 0 )) and OkTempoDeTentativas Then
      Begin
        Try               aTempoDeTentativas := TempoDeTentativas ;
          ClockBegin         := GetDosTicks;


         _Progress1Passo := TProgressDlg_If.Create('Arquivo: '+wFileName,'Erro: '+Format('%d',[TaStatus]),1,TempoDeTentativas);

          WHILE (AFileMode AND FmWait <>0 ) AND (TaStatus <> 0 ) and (GetDosTicks - ClockBegin <= Seg_to_MillSeg(TempoDeTentativas))
          DO
          BEGIN
            _Progress1Passo.IncPosition(GetDosTicks - ClockBegin);
            CASE TaStatus  OF
              AcessoNegado5,
              AcessoNegado32,
              ErroViolacaoDeLacre   : CtrlSleep (1);
              ELSE
              BEGIN
                Raise TException.Create7('',
                                         unitName,
                                         className,
                                        'Reset',
                                         WideStringToString(FileRec(F).name),
                                         '' ,
                                         TaStatus
                                       );
              END ;
            END ;

            {$I-}
            System.Reset (F , aRecLen );
            {$I+}

            IoResult;
            IF KeyPressed THEN
              FTempoDeTentativas(0);
          END ;

        Finally
          TempoDeTentativas := aTempoDeTentativas ;
          //CloseProgress1Passo(_Progress1Passo);
          Discard(TObject(_Progress1Passo));
        End;

      End;

      system.FileMode   := Byte(aAFileMode) ;
      Reset    := TaStatus;

    Finally

    end;
  END ;

  class function TObjectsSystem.FileFlushBuffers(VAR F : File; const Ok_FileFlushBuffers : Boolean):Boolean;
  Begin
    If (FileRec(F).UserData[Sizeof(FileRec(F).UserData)] = 0) {O Registro nao foi alterado}
    Then Begin
           Result := true;
           TaStatus := 0;
           exit;
         end;

     If FlushBuffer_Disk and Ok_FileFlushBuffers
     Then FileFlushBuffers(FileRec(F).Handle);

     Close(F);
     With FILEREC(F) do
     Begin
        UserData[Sizeof(UserData)] := 0;
        Result := Reset(F,RecSize,UserData[Sizeof(UserData)-1])=0  ;
     End;
  end;

  class function TObjectsSystem. OpenText(VAR F:Text;Mode: Word{StCreate,St}):SmallInt ;
  Begin
    If FileExists(TextRec(f).Name)
    Then Result := Reset(F,System.FileMode)
    Else If Mode = StCreate
         Then Begin
                Result := Rewrite(F,system.FileMode);
                If Result = 0
                Then Begin
                       Close(F);
                       Result := Reset(F,system.FileMode);
                     End
              End
         Else Begin
                TaStatus := ArquivoNaoEncontrado2;
                Result := TaStatus;
              End;
  End;

  class function TObjectsSystem. Reset(VAR F:Text ;Const AFileMode:SmallWord):SmallInt ;
    {$I-}
    VAR
      aAFileMode : BYTE;
      aTempoDeTentativas : Longint;
      ClockBegin         : DWord;
      wFileName          : tString;
      _Progress1Passo : TProgressDlg_If;
  Begin
    aAFileMode := system.FileMode ;
    system.FileMode   := Byte(AFileMode) ;

    wFileName := WideStringToString(TextRec(F).Name);

    TextRec(F).UserData[Sizeof(TextRec(F).UserData)-1] := Byte(FileMode);


    IoResult; {Essa instrucao inicializa InOutRes para que
               a proximo acesso ao DOS nao gera a Int24}
    Try
        {$I-}
        System.Reset(F);
        {$I+}
        IoResult;


        If ((AFileMode AND FmWait <>0 ) AND (TaStatus <> 0 )) and OkTempoDeTentativas Then
        Begin
          aTempoDeTentativas := TempoDeTentativas ;
          ClockBegin         := GetDosTicks;


          _Progress1Passo := TProgressDlg_If.Create('Arquivo: '+wFileName,'Erro: '+Format('%d',[TaStatus]),Delta_Locate,TempoDeTentativas);

          WHILE (AFileMode AND FmWait <>0 ) AND (TaStatus <> 0 ) and
                (GetDosTicks - ClockBegin <= Seg_to_MillSeg(Longint(TempoDeTentativas)))
          Do
          BEGIN
            //SetProgress1Passo(_Progress1Passo,Clock - ClockBegin);
            _Progress1Passo.IncPosition(GetDosTicks - ClockBegin);
            CASE TaStatus  OF
              AcessoNegado5,
              AcessoNegado32,
              ErroViolacaoDeLacre  : CtrlSleep (1);
              ELSE
              BEGIN
                FileMode   := aAFileMode ;
                Discard(TObject(_Progress1Passo));

                Raise TException.Create7('',
                                         unitName,
                                         className,
                                        'Reset',
                                         WideStringToString(TextRec(F).name),
                                         '' ,
                                         TaStatus
                                       );

//                Reset := MsgIoResult(StrMessageBox('Systemm','Reset',SysWideStringToString(TextRec(F).name),TaStatus));
//                exit;
              END ;
            END ;
            {$I-}
            System.Reset (F);
            {$I+}
            IoResult;

            IF KeyPressed THEN
              FTempoDeTentativas(0);
          END ;
          TempoDeTentativas := aTempoDeTentativas ;
  //        CloseProgress1Passo(_Progress1Passo);
           Discard(TObject(_Progress1Passo));
      {    RestoraTela(aScreenBuffer);}
        End;

    Finally
      system.FileMode   := Byte(aAFileMode);
      Reset := TaStatus;
    End;

  End;



  class function TObjectsSystem.Size_LinFeed_Text(aFileName : AnsiString):SmallInt ;

  // Numero_de_caracteres_separadores_de_linha de arquivo Texto

  //    Pode ser 1 ou 2.
  //    Tamanho do registro + ^M+^J = 2
  //    Tamanho do registro + ^J    = 1

  //   Ideia inicial /22/05/2009
  //      - Contar o número de line feed (LF) #10 = ^J e carriage return #13 (CR) = ^M dos primeiros 1024 bytes.
  //      - Se número de LF igual ao numero de CR Retornar o número 2 caso contrário retornar 1;

   Var
     Ch : Char;
     FileText      :Text;
     I,
     Total_LF,
     Total_CR  : Integer;

  Begin
     Total_LF  := 0;
     Total_CR  := 0;
     I         := 0;
    Set_FileModeDenyALL(False);
    //Assinala o nome do arquivo em FileText;
    AssignFile(FileText,aFileName);

    //Abre o arquivo
    OpenText(FileText,FileMode);

    //Se não houver erro de abertura de arquivo ent�o calcula
    if TaStatus =  0
    then Begin
           Try
               while Not Eof(FileText) and (i<2048) do
               Begin
                 Inc(i);

                 //Ler um caractere;
                 {$I-} Read(FileText,Ch); {$I+}

                 // Salva o erro em taStatus
                 TaStatus := IoResult;

                 //Se houver erro de leitura em disco ent�o gera exce��o
                 If TaStatus <> 0
                 Then Raise TException.Create7('',
                                               unitName,
                                               className,
                                              'Size_LinFeed_Text',
                                               aFileName,
                                               '' ,
                                               TaStatus
                                             );


                 case ch of
                   ^M : Begin
                          Inc(Total_CR);
                        End;
                   ^J : Begin
                          Inc(Total_LF);
                        End;
                 end;
               End;


           Finally
              if (Total_CR=Total_LF)
              then Result := 2
              Else Result := 1;
              Close(FileText);
           End;
         End
    Else If TaStatus <> 0
         Then Raise TException.Create7('',
                                       unitName,
                                       className,
                                      'Size_LinFeed_Text',
                                       aFileName,
                                       '' ,
                                       TaStatus);
  End;

end.
