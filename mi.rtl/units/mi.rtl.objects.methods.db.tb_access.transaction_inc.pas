{ Incluide de Tb_Access.DbTra.Pas.pa

 Objeto para controle de transação}
{Const
  DbTra_VersaoSistema  : Byte = 0;  Inicio da Versao 7.01 em 31/07/00
  DbTra_SerieDaVersao  : word = 01;
  DbTra_DataVersao     : TypeData = (dia:08;mes:09;ano:00);}
{
  NOVO
    31/07/2000
    1 -  Analise de como implementar as transações no Tb_Access.DbTra.Pas.pas

    08/09/2000
    1 - Inicio da programação

    09/09/2000
    1 - Inicio da Implementação da interface dos objeto TTransaction

    18/09/2000
    1 - Continuacao da Implementação da interface dos objeto TTransaction

    27/12/2021
      - Adaptar para que funcione no lazarus e linux.

  CORREÇÕES
    11/01/02
      1 - Apareceu um problema nos indexs dos arquivos na versao Delphi. Verificar o que esta acontecendo.


  MELHORIAS
  PENDENCIAS
}
TYPE
{  T_TTransaction = (Tra_AddRec,Tra_PutRec,Tra_DeleteRec);}

  PID_Reg_Transaction = ^TID_Reg_Transaction;
  TID_Reg_Transaction =
  Record
    Reservado              : TTb_Access.TypeHeaderRecord;
    Current_DatF_Tipo      : AnsiChar;{ D=Dados. Indica ao CloseFilesOpens que se trata de um arquivo de Dados }
    Current_DatF_FileName  : ShortString;
    Current_Nr             : Longint;
    Transaction            : TTb_Access.T_TTransaction;
    Data                   : TDates.TVarGetDate;
    Hora                   : TDates.TVarGetTime;
    TipoDeRegistro         : AnsiChar;    {D= DataFile; I= IndexFile}
    TamReg                 : TTb_Access.SmallWord;    {Tamanho do registro}
  End;


  TReg = array[1..TTb_Access.MaxDataRecSize] of Byte;

  PReg_Transaction = ^TReg_Transaction;
  TReg_Transaction = {Tipo registro do arquivo de transação}
  Record
    IDReg_Transaction : TID_Reg_Transaction;
    Reg               : TReg;
  END;

  TClass_Reg_Transaction = Class(TTb_Access)
  Public
    Reg_Transaction : TReg_Transaction;
    Constructor Create(Const aReg_Transaction : TReg_Transaction);
  End;

  TCol_Class_Reg_Transaction = Class(TCollection)
    Function Reg_Transaction_ByNum(Const Nr : Longint): TClass_Reg_Transaction;
  End;


  TCollDatFsNaTransacao = Class(TSortedCollection)
    function Compare(Key1, Key2: Pointer): Integer; Override;
    procedure FreeItem(Item: Pointer); Override;
    Function Find(Const aCurrent_DatF_FileName:PathStr):TDataFile;
    Function DataFileByNum(Const Numero_do_DataFile : Sw_Integer):TDataFile;
  End;

Type
  TTransaction =
  Class(TObjectsSystem)
  Private
    DatF                      : TFileStream;
    Col_Class_Reg_Transaction : TCol_Class_Reg_Transaction;
    CollDatFsNaTransacao      : TCollDatFsNaTransacao;
    CurrentDatFsNaTransacao   : TDataFile;

    TTTransaction           : TTb_Access.T_TTransaction;{Tipo da transacao}
    Delta                   : Word; {Usado para prealocar os registros do arquivos de
                                     tranzaáao para que os DOS nao se perca caso haja falha.
                                     }
    {ATENÇÃO: E necessario RollBack_Reg_Transaction porque o roolback usa
         PutFile e putFile usa Reg_Transaction.
         Se usar Reg_Transaction nada será desfeito visto que quando
         o sistema for ler o registro anterior em _putRec o buffer e destruido.
         }

    Reg_Transaction          : TReg_Transaction;
    RollBack_Reg_Transaction : PReg_Transaction;
    OkRollback               : Boolean;{Indica que o sistema esta desfazendo uma transação}
    RecordBufPtr             : TTb_Access.TaRecordBufPtr; {Usado para ler o registro anterior em _PutRec}

    wFileModeDenyALL    : Boolean;
//    AProgress1Passo : TProgressDlg;
    N               : Longint;
//    aApp            : TApplication;

    aDataFile    : TTb_Access.DataFile;  {Temp}
    aObjDataFile : TDataFile; {Temp}

    aFlushBuffer_Disk : Boolean;
    wSysCtrlSleep_Enable : Boolean;

  Public
    Function AssignFile   (Const aFileName : PathStr):Word;
    Constructor Create  (Const aFileName : PathStr);
    Destructor Destroy;Override;

    Function TransactionPendant:SmallInt;

    FUNCTION OpenFileDatF:Integer;
    FUNCTION StartTransaction(Const aDelta : Word):Integer;

    Function COMMIT:Boolean;
    Procedure Copy_To_Reg_Transaction(Var  aCurrent_DatF : TTb_Access.DataFile;
                                     Const aCurrent_NR   : Longint;
                                     var   aCurrent_Reg;
                                     Const aT_TTransaction : TTb_Access.T_TTransaction);

    Function DbTra_AddRec      (Var   aCurrent_DatF : TTb_Access.DataFile;
                                Const aCurrent_NR    : Longint;
                                var   aCurrent_Reg;
                                Const aT_TTransaction : TTb_Access.T_TTransaction):Boolean;

    Function Valid_Reg_Transaction(Const aReg_Transaction:TReg_Transaction):Boolean;
    Function Init_CollDatFsNaTransacao: Integer;
    Function OpenFile_CollDatFsNaTransacao:Integer;
    Function AnulaTransacao:SmallInt;
    Procedure EscrevaFErrRollBack(OperacaoInversa:String;i:Longint;Const aReg_Transaction : PReg_Transaction);
    Function Rollback:Integer;

  End;

{Implementacao das constantes usadas no objeto TTransaction-----------------}
CONST
  OkCreateTransaction : Boolean = False; {True = Indica que esta inicializando o arquivo de transação}
  Transaction       : TTransaction = Nil;

{----------------------------------------------------------------------}

  Constructor TClass_Reg_Transaction.Create(Const aReg_Transaction : TReg_Transaction);
  Begin
    Inherited  Create(nil);
    Reg_Transaction := aReg_Transaction;
  end;

  Function TCol_Class_Reg_Transaction.Reg_Transaction_ByNum(Const Nr : Longint): TClass_Reg_Transaction;

  Begin
    Result := TClass_Reg_Transaction(At(Nr));
  end;

  function TCollDatFsNaTransacao.Compare(Key1, Key2: Pointer): Integer;
  Var
    sKey1, sKey2 : PathStr;
  Begin
    sKey1 :=  UpperCase(TDataFile(Key1).DataFile.FileName);
    sKey2 :=  UpperCase(TDataFile(Key2).DataFile.FileName);

    {Teste se Key 1 Key}
    If sKey1 < sKey2
    Then Compare := -1
    else If sKey1 = sKey2
         Then Compare := 0
         else Compare := 1; {Key1 > Key2}
  End;

  procedure TCollDatFsNaTransacao.FreeItem(Item: Pointer);
  Begin
    Try
//      {$IFDEF TaDebug}Application.Push_MsgErro('Tb_Access.DbTra.pas.TCollDatFsNaTransacao.FreeItem',ListaDeChamadas);{$ENDIF}
      with TTb_Access do
      Try
        If Is_TFileOpen(TDataFile(Item).DataFile.F) and TDataFile(Item).Ok_CloseDataFile Then
        Begin
          CloseFile(TDataFile(Item).DataFile^);
        end;
      Except
      end;

      Inherited FreeItem(Item);
    Finally

    End;
  End;

  Function TCollDatFsNaTransacao.Find(Const aCurrent_DatF_FileName:PathStr):TDataFile;
  {Pesquisa se o registro esta travado}
  var
    I : Longint;
  Begin
    For I := 0 to Count-1 do
      If (PItemList(Items)^[i] <> nil)
        And (TDataFile(PItemList(Items)^[i]).DataFile<>nil)
        And (TDataFile(PItemList(Items)^[i]).DataFile.f<>nil)
        And (TDataFile(PItemList(Items)^[i]).DataFile.F.FileName = aCurrent_DatF_FileName)
      Then Begin
             Find := TDataFile(PItemList(Items)^[i]);
             exit;
           End;
    Find:= nil;
  End;

  Function TCollDatFsNaTransacao.DataFileByNum(Const Numero_do_DataFile : Sw_Integer):TDataFile;
  Begin
    DataFileByNum := TDataFile(At(Numero_do_DataFile));
  end;

{@@@@@@@@@@@@@ Implementation the TTransaction @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@}

  Function TTransaction.AssignFile(Const aFileName : PathStr):Word;
  Begin

    If (DatF.Handle = HANDLE_INVALID)
    Then Begin
           TTb_Access.FileName_Transaction := FExpand(TTb_Access.FTb(aFileName));
           DatF.FileName        := TTb_Access.FileName_Transaction;
           Result               := DatF.ErrorInfo;
         End
    Else Result := ErrorTentativa_de_abrir_um_arquivo_aberto;

  End;


  Constructor TTransaction.Create(Const aFileName : PathStr);
  Begin
    Inherited Create(nil);
//      If Not okcreate Then Abort_Create;

    New(RecordBufPtr);
//      If RecordBufPtr= nil Then Abort_create;

    New(RollBack_Reg_Transaction);
//      If RollBack_Reg_Transaction = nil Then Abort_create;

    Col_Class_Reg_Transaction := TCol_Class_Reg_Transaction.Create(100,100);

    //If Not Col_Class_Reg_Transaction.okcreate Then Abort_Create;

    CollDatFsNaTransacao := TCollDatFsNaTransacao.Create(100,100);
    //If Not CollDatFsNaTransacao.okcreate Then Abort_Create;

//    DatF := TFileStream.Create('',stOpen or FmWait);
     DatF := TFileStream.Create('',fileMode,ShareMode);

//      DatF.ATTRIBUTE := FILE_ATTRIBUTE_COMPRESSED;
//      DatF.Flags     := FILE_FLAG_SEQUENTIAL_SCAN or FILE_FLAG_WRITE_THROUGH;

    ok := AssignFile(aFileName)=0;
    if ok
    then aObjDataFile := TDataFile.Create(aDataFile,false)
    else  Raise TException.Create7('',
                            'Tb_Acce2.Pas',
                            'TTransaction',
                            'Create',
                             aFileName,
                            '',
                             TaStatus);



  End;

  Destructor TTransaction.Destroy;
    Var
      i : Byte;
  Begin
    Discard(TObject(DatF));
    If CollDatFsNaTransacao<>nil
    Then Begin
           if CollDatFsNaTransacao.Count > 0
           Then For i := 0 to CollDatFsNaTransacao.Count-1  do
                  With TDataFile(PItemList(CollDatFsNaTransacao.Items)^[i] ) do
                  If Ok_CloseDataFile and Is_TFileOpen(DataFile^.F)
                  Then TTb_Access.aCloseFile(TDataFile(PItemList(CollDatFsNaTransacao.Items)^[i] ).DataFile^);
           Discard(TObject(CollDatFsNaTransacao));
         End;


    If RecordBufPtr <> nil Then Dispose(RecordBufPtr);
    if RollBack_Reg_Transaction <> nil Then Dispose(RollBack_Reg_Transaction);
    Discard(TObject(Col_Class_Reg_Transaction));
    Discard(TObject(aObjDataFile));

    Inherited Destroy;


  End;

  Function TTransaction.TransactionPendant:SmallInt;
    {
     Condição para que uma transação esteja pendente:
      1 - Col_Class_Reg_Transaction.Count > 0
      2 - DatF.Status_Rewrite = 0
      3 - DatF.GetSize > 0

     Condição para que outro usuário esteja processando uma transação:
      1 - O arquivo DbTra.Tb foi aberto esclusivo. -> taStatus in [5,32, 33]

     Condição para a transação esteja livre:
      1 - Col_Class_Reg_Transaction.Count = 0
      2 - DatF.Status_Rewrite = 1
      3 - DatF.GetSize = 0
    }

  Begin
    Sleep(0);
    If DatF.Handle = HANDLE_INVALID
    Then Begin
           DatF.Open(stOpen,FmWait);
           If (DatF.Status = 0)
           Then Begin
                  If DatF.getSize = 0
                  Then Result := AcessoNegado5
                  Else Result := 0;
                end
           Else If (DatF.Status <> 0) and (DatF.ErrorInfo<>0)
                Then Result := DatF.ErrorInfo
                Else If (DatF.Status <> 0) and (DatF.ErrorInfo=0)
                     Then Result := AcessoNegado5;
         end
    Else Begin
           If DatF.getSize = 0
           Then Result := AcessoNegado5
           Else Result := 0;
         end
  End;

  FUNCTION TTransaction.OpenFileDatF:Integer;
  Begin
    Try
      If TransactionPendant=0
      Then TaStatus := Rollback
      Else TaStatus := 0;

      If TaStatus = 0
      Then Begin
             DatF.Reset(stOpen,fmShareCompat or fmShareExclusive or stCreate or FmWait);
             If (DatF.Status = 0) and (DatF.Status_Rewrite=1) {Se não criar um arquivo é porque outra estação caiu}
             Then Begin
                    TaStatus := 0;
                    Exit;
                  end
             Else If (DatF.Status = 0) and (DatF.Status_Rewrite=0) {Se nao criou um arquivo e porque outra estacao caiu}
                  Then Begin
                         If DatF.GetSize-1 > 0
                         Then Begin
                                TaStatus := Rollback;
                                If TaStatus = 0
                                Then TaStatus := OpenFileDatF;
                              End
                         else TaStatus := 0;

                       end;
{                  Else If ((DatF.Status <> 0)) and (DatF.ErrorInfo <> 0)
                       Then TaStatus := DatF.ErrorInfo
                       Else If Datf.Handle = -1
                            Then TaStatus := ErroArquivoFechado;}
           End;
    Finally
      Result := TaStatus;
    end;
  End;


  FUNCTION TTransaction.StartTransaction(Const aDelta : Word):Integer;
  Begin

    Try
      If ok_Set_Transaction
      Then Begin
             TaStatus := TTransaction_Commit_esperado;
             Raise TException.Create(Self,'StartTransaction',DatF.fileName,'', TaStatus);
      end;

      Delta := aDelta;
      TaStatus := OpenFileDatF;

    Finally
      ok_Set_Transaction := TaStatus = 0;
      Result             := TaStatus;


      wSysCtrlSleep_Enable := Set_CTRL_SLEEP_ENABLE(False);

      OkRollback         := False;
    end;
  End;

  Function TTransaction.COMMIT:Boolean;
    {Descrição
     O Commit mátodo finaliza as transações atuais e assim todas as
     modificações são confirmadas no banco de dados desde a áltima
     chamada de StartTransaction.
     Se nenhuma transação á ativa, commit retorna FALSE.
    }
    Var
      Wok : Boolean;
  Begin
    Try
      Wok := Ok;
//      {$IFDEF TaDebug}Application.Push_MsgErro('Tb_Access.DbTra.Pas.TTransaction.COMMIT',ListaDeChamadas);{$ENDIF}


{      Desativei FlushAllFiles porque esta interferindo nos indexs de estoque e no index do razao contabil. Verificar depois porque}

       If (FilesOpens<> nil)
       Then FilesOpens.FlushAllFiles;

      Try
        Col_Class_Reg_Transaction.FreeAll;
      Except
      end;

      Try
        CollDatFsNaTransacao.FreeAll;
      Except
      end;

      DatF.Truncate(0);
      DatF.Close;
      Result := DatF.Status =0;

{      iF ok_Set_Transaction
      THEN Result := DelFile(DatF.fIleName)
      Else Result:= false;}

    Finally
     ok_Set_Transaction := False;
//      Discard(TObject(aApp));

     ok := wOk;
//     SysSetThreadPriority(tpNormal);
     Set_CTRL_SLEEP_ENABLE(wSysCtrlSleep_Enable);
    End;
  End;

  Procedure TTransaction.Copy_To_Reg_Transaction
                             (Var   aCurrent_DatF : TTb_Access.DataFile;
                              Const aCurrent_NR   : Longint;
                              var   aCurrent_Reg;
                              Const aT_TTransaction : TTb_Access.T_TTransaction);
  Begin

    With Reg_Transaction,IDReg_Transaction do
    Begin
       If aCurrent_NR <> 0
       Then TamReg            := aCurrent_DatF.f.RecSize    {Tamanho do registro}
       Else Begin
              TamReg            := aCurrent_DatF.f.BaseSize;  {Tamanho da Base}
              If (UpCase(aCurrent_DatF.Tipo) = 'I') And (TamReg<>TTb_Access.FileHeaderSize)
              Then Raise TException.Create(Self,
                                           'Copy_To_Reg_Transaction',
                                            aCurrent_DatF.FileName,
                                            '',
                                           ParametroInvalido);
            End;

       Current_DatF_Tipo      := aCurrent_DatF.Tipo;
       Current_DatF_FileName  := aCurrent_DatF.f.FileName;
       Current_NR             := aCurrent_NR;
       Transaction            := aT_TTransaction;

       With  Data do GetDate(Ano, Mes, Dia, DiaDaSemana);
       With Hora do GetTime(Hora,Minuto,Segundo,S100);


       if TamReg > TTb_Access.MaxDataRecSize
       then Raise TException.Create(Self,'Copy_To_Reg_Transaction',
                                          aCurrent_DatF.FileName,
                                          '',
                                         ParametroInvalido);


       Move(aCurrent_Reg,Reg_Transaction.Reg,TamReg);
    End;
  End;

  Function TTransaction.DbTra_AddRec (
                                Var   aCurrent_DatF : TTb_Access.DataFile;
                                Const aCurrent_NR    : Longint;
                                var   aCurrent_Reg;
                                Const aT_TTransaction : TTb_Access.T_TTransaction):Boolean;
  Begin
    Try
      Copy_To_Reg_Transaction(aCurrent_DatF,aCurrent_NR,aCurrent_Reg,aT_TTransaction);

      If (Not aCurrent_DatF.OkTemporario) And (aCurrent_DatF.F.GetDriveType <> dt_Memory_Stream)
      Then Begin //Salva a transacao em disco para o caso de interrupição inesperada do processamento
             if Reg_Transaction.IDReg_Transaction.TamReg > TTb_Access.MaxDataRecSize
             then Raise TException.Create(Self,'DbTra_AddRec',
                                           aCurrent_DatF.FileName,
                                           '',
                                           ParametroInvalido);

            DatF.Write(Reg_Transaction,Sizeof(Reg_Transaction.IDReg_Transaction)+Reg_Transaction.IDReg_Transaction.TamReg);
            TaStatus := DatF.ErrorInfo;
            If TaStatus = 0
            Then Begin
                   aFlushBuffer_Disk := SetFlushBuffer_Disk(FlushBuffer_Disk_Transaction);
                   DatF.Flush;
                   SetFlushBuffer_Disk(aFlushBuffer_Disk);
                   TaStatus := DatF.ErrorInfo;
                 End
            Else Raise TException.Create(Self,
                                         'DbTra_AddRec',
                                          aCurrent_DatF.FileName,
                                          '',
                                         TaStatus);

           End
      Else TaStatus := 0;

      If TTb_Access.ok_Debug_Transaction
      Then LogError(Spc('DbTra_AddRec  '+aCurrent_DatF.f.FileName,70)+LF+
                    ' NR: '+IStr(Reg_Transaction.IDReg_Transaction.Current_NR,'IIIIII')+'  '+LF+
                    ' Tra: '+IStr(ord(Reg_Transaction.IDReg_Transaction.Transaction),'BB')+' '+LF+
                      ' Chave: '+ IStr(Reg_Transaction.IDReg_Transaction.data.Ano  ,'IIII')+LF+
                      IStr(Reg_Transaction.IDReg_Transaction.data.mes    ,'BB')+LF+
                      IStr(Reg_Transaction.IDReg_Transaction.data.dia    ,'BB')+LF+
                      IStr(Reg_Transaction.IDReg_Transaction.hora.Hora   ,'BB')+LF+
                      IStr(Reg_Transaction.IDReg_Transaction.hora.minuto ,'BB')+LF+
                      IStr(Reg_Transaction.IDReg_Transaction.hora.Segundo,'BB')+LF+
                      IStr(Reg_Transaction.IDReg_Transaction.hora.S100,'BBB')+LF);


    Finally
      Result := (TaStatus=0) {and (BlocksWrite=1)};

      If Result and Not OkRollback
      Then Begin
             Col_Class_Reg_Transaction.Insert(TClass_Reg_Transaction.create(Reg_Transaction));

             aObjDataFile.SetDataFile(aCurrent_DatF,False);

             If CollDatFsNaTransacao.IndexOf(aObjDataFile)= -1
             Then CollDatFsNaTransacao.Insert(TDataFile.Create(aObjDataFile.DataFile^,aObjDataFile.Ok_CloseDataFile));

           End;

    end;

  End;

  Function TTransaction.Valid_Reg_Transaction(Const aReg_Transaction:TReg_Transaction):Boolean;
    {Testa se o regisro a ser recuperado á valido}
  Begin
    Result:=
      (aReg_Transaction.IDReg_Transaction.Current_DatF_FileName<>'') and
      (aReg_Transaction.IDReg_Transaction.TamReg >= TTb_Access.MinDataRecSize)  and
      (aReg_Transaction.IDReg_Transaction.TamReg <= TTb_Access.maxDataRecSize) and
{          (TamReg <= DatF.ItemSize) and}
      ((aReg_Transaction.IDReg_Transaction.Data.Ano >= 1980) and (aReg_Transaction.IDReg_Transaction.Data.Ano <= 2000+DefaultFormatSettings.TwoDigitYearCenturyWindow{AnoLimit}  )) And
      ((aReg_Transaction.IDReg_Transaction.Data.Mes >= 1   ) and (aReg_Transaction.IDReg_Transaction.Data.Mes <= 12             )) And
      ((aReg_Transaction.IDReg_Transaction.Data.Dia >= 1   ) and (aReg_Transaction.IDReg_Transaction.Data.Dia <= 31             )) and
      (aReg_Transaction.IDReg_Transaction.Hora.Hora <= 24  ) and
      (aReg_Transaction.IDReg_Transaction.Hora.minuto <= 60 ) and
      (aReg_Transaction.IDReg_Transaction.Hora.Segundo<= 60 ) and
      (aReg_Transaction.IDReg_Transaction.Hora.S100   <= 999) ;

  End;

  Function TTransaction.Init_CollDatFsNaTransacao: Integer;
   {  ATENÇÃO:
      Caso a maquina tenha sido desligada e o scanDisk nao foi executado;
      então FileSize(datF) retornara mais registros do que realmente existe
      em DatF e o ultimo seek_Nr retornara error 5=Acesso negado.
   }
  Var
    DF           : TDataFile;

  Begin
    If (Col_Class_Reg_Transaction.Count >0) or (DatF.GetSize =0)
    Then Begin
           TaStatus := 0;
           Result := TaSTatus;
           exit;
         End;

    Try


      Inc(N);//SetProgress1Passo(AProgress1Passo,N);

      If TTb_Access.ok_Debug_Transaction
      Then Begin
             LogError('  Inicio de: Init_CollDatFsNaTransacao');
           End;

      DatF.Seek(0);
      If (aObjDataFile <> nil) and (DatF.Status=0)
      Then //With Reg_Transaction,IDReg_Transaction,Data,Hora do
           While (Not DatF.Eof) and (DatF.Status=0)  do
           Begin
             DatF.Read(Reg_Transaction,Sizeof(TID_Reg_Transaction));

             if Reg_Transaction.IDReg_Transaction.TamReg > TTb_Access.MaxDataRecSize
             then Raise TException.Create(Self,'Init_CollDatFsNaTransacao',
                                               '', //aCurrent_DatF.FileName,
                                               '',
                                               ParametroInvalido);


             If DatF.Status = 0
             Then DatF.Read(Reg_Transaction.Reg,Reg_Transaction.IDReg_Transaction.TamReg);



             If (DatF.Status=0)
             Then Begin
                     if  Valid_Reg_Transaction(Reg_Transaction)
                     Then Begin
                            try
                              {s := Reg_Transaction.IDReg_Transaction.Current_DatF_FileName;
                              if s <>'' then; }
                            //==========================================================================================================
                            {$REGION ' ---> O campo Current_datF_FileName está gerando exceção.Self'}
                            //==========================================================================================================
                              { DONE 1 -oTTransaction.Init_CollDatFsNaTransacao -cBUG NO CÓDIGO :
 2010/12/08 á O campo Current_datF_FileName está gerando exceção.Self

           á SOLUÇÃO: Trocar todos os nomes de arquivos de Ansistring para pathStr tipo shortsring.

                              }
                            {$ENDREGION}
                            //==========================================================================================================

                            aObjDataFile.DataFile.Filename          := Reg_Transaction.IDReg_Transaction.Current_DatF_FileName;
                            aObjDataFile.DataFile.Tipo              := Reg_Transaction.IDReg_Transaction.Current_DatF_Tipo; {Redefinido em OpenFile}
                            aObjDataFile.DataFile.OkAddRecFirstFree := False;
                            aObjDataFile.DataFile.ItemSize          := Reg_Transaction.IDReg_Transaction.TamReg;

                            Except
                              LogError(Reg_Transaction.IDReg_Transaction.Current_DatF_FileName);
                              raise;
                            end;


                            if FileExists(aObjDataFile.DataFile.Filename)
                            then begin
                                   Ok := TRUE;
                                    /// <since>
                                    ///   . Se o tamanho do registro for <= a FileHeaderSizeo arquivo á invêlido e o mesmo deve ser ignorado
                                    /// </since>
                                   if aObjDataFile.DataFile.ItemSize < TTb_Access.FileHeaderSize
                                   then Begin
                                          deleteFile(aObjDataFile.DataFile.Filename);
                                          Ok := false;
                                        End;
{                                   Else if (UpperCase(ExtractFileExt(aObjDataFile.DataFile.Filename)) = '.IX') and
                                           (aObjDataFile.DataFile.ItemSize = FileHeaderSize)
                                        then begin
                                               deletefile(aObjDataFile.DataFile.Filename);
                                               Ok := false;
                                             end;
}
                                    if OK
                                    then BEGIN

                                            If CollDatFsNaTransacao.IndexOf(aObjDataFile)= -1
                                            Then Begin
                                                   DF := TDataFile.Create(aObjDataFile.DataFile^,true);

                                                   CollDatFsNaTransacao.Insert(DF);
                                                  If TTb_Access.ok_Debug_Transaction
                                                  Then Begin
                                                         LogError('  FileName...: '+Df.DataFile.FileName);
                                                         LogError('  Tipo.......: '+Df.DataFile.Tipo);
                                                         LogError('  ItemSize...: '+IStr(Df.DataFile.ItemSize,'IIIII'));
                                                       End;
                                                 End;
                                            Col_Class_Reg_Transaction.Insert(TClass_Reg_Transaction.create(Reg_Transaction));
                                    END;
                                 end;
                          End
                     else with logs do
                          Begin
                            WriteLnFErr('Error CRC na tabela-> '+TTb_Access.FileName_Transaction+' ao ler a transação-> '+Reg_Transaction.IDReg_Transaction.Current_DatF_FileName);
                            WriteLnFErr(TStrError.ErrorMessage(Self,
                                                              'Init_CollDatFsNaTransacao',
                                                               Reg_Transaction.IDReg_Transaction.Current_DatF_FileName,
                                                              '',
                                                              TaStatus));

{                             DatF.Error(StOk,0);
                             break;}

                             Raise TException.Create(Self,'Init_CollDatFsNaTransacao',
                                                           Reg_Transaction.IDReg_Transaction.Current_DatF_FileName,
                                                           '',
                                                           TaStatus);

                          End;
                  End {BLOCKREAD}
             ELSE with logs do
                  BEGIN
                    WriteLnFErr('Error CRC na tabela-> '+TTb_Access.FileName_Transaction+' ao ler a transação-> '+Reg_Transaction.IDReg_Transaction.Current_DatF_FileName);
                    WriteLnFErr(TStrError.ErrorMessage(Self,'Init_CollDatFsNaTransacao',
                                                       DatF.FileName,
                                                       '',
                                                       TaStatus));
{                    DatF.Error(StOk,0);
                    break;}

                    Raise TException.Create(Self,'Init_CollDatFsNaTransacao',
                                                  DatF.FileName,
                                                    '',
                                                       TaStatus);
                  END;

           End; {For}

    Finally
      TaStatus := DatF.ErrorInfo;
      Result := TaStatus;

      If TTb_Access.ok_Debug_Transaction
      Then Begin
             Logs.WriteLnFErr('  Fin  de..: Init_CollDatFsNaTransacao');
           End;


    End;
  End;

  Function TTransaction.OpenFile_CollDatFsNaTransacao:Integer;
    Var
      I : Longint;
      DF : TDataFile;
  Begin
    TaStatus := 0;

    Try
//      {$IFDEF TaDebug}Application.Push_MsgErro('Tb_Access.DbTra.Pas.TTransaction.OpenFile_CollDatFsNaTransacao',ListaDeChamadas);{$ENDIF}

      If TTb_Access.ok_Debug_Transaction
      Then Begin
             Logs.WriteLnFErr('  Inicio de: OpenFile_CollDatFsNaTransaca');
           End;

      OkCreateTransaction := True;

      Inc(N);//SetProgress1Passo(AProgress1Passo,N);
      If CollDatFsNaTransacao<>nil
      Then Begin
            if CollDatFsNaTransacao.Count > 0
            Then For i := 0 to CollDatFsNaTransacao.Count-1  do
                 Begin
                   DF :=TDataFile(PItemList(CollDatFsNaTransacao.Items)^[i] );
                   If DF.Ok_CloseDataFile
                   Then Begin
                          TaStatus := TTb_Access.OpenFile(DF.DataFile^,
                                               DF.DataFile.Filename,
                                               DF.DataFile.ItemSize);

                          If TTb_Access.ok_Debug_Transaction
                          Then with logs do
                               Begin
                                 WriteLnFErr('  FileName...: '+DF.DataFile.FileName);
                                 WriteLnFErr('  Tipo.......: '+Df.DataFile.Tipo);
                                 WriteLnFErr('  ItemSize...: '+IStr(Df.DataFile.ItemSize,'IIIII'));
                               End;

                        End
                 End;
           End
      else TaStatus := Objeto_Nao_Inicializado;

    Finally
      Result              := TaStatus;
      OkCreateTransaction := False;

      If TTb_Access.ok_Debug_Transaction
      Then Begin
             Logs.WriteLnFErr('  Fin de...: OpenFile_CollDatFsNaTransaca');
           End;


    End;
  End;

  Function TTransaction.AnulaTransacao:SmallInt;
    Var
      aCount,
      I,
      aN  : Longint;
//      aAProgress1Passo : TProgressDlg;
  Begin
    Try {Finally}
//      {$IFDEF TaDebug}Application.Push_MsgErro('Tb_Access.DbTra.Pas.TTransaction.AnulaTransacao',ListaDeChamadas);{$ENDIF}

      Inc(N);//SetProgress1Passo(AProgress1Passo,N);

//      aAProgress1Passo := OpenProgress1Passo('Anula transação...','RollBack',Col_Class_Reg_Transaction.Count-1);

      aN := 0;

      aCount := Col_Class_Reg_Transaction.Count-1;
      For i := aCount downto 0 do
      With RollBack_Reg_Transaction^,IDReg_Transaction,Data,Hora do
      Begin
        CtrlSleep(0);
        RollBack_Reg_Transaction^ := Col_Class_Reg_Transaction.Reg_Transaction_ByNum(i).Reg_Transaction;

        Inc(aN);//SetProgress1Passo(aAProgress1Passo,aN);

        CurrentDatFsNaTransacao := CollDatFsNaTransacao.Find(Current_DatF_FileName);
        If CurrentDatFsNaTransacao = nil
        Then Begin
               raise TException.create(Self,'AnulaTransacao',
                                            Current_DatF_FileName,
                                            '',
                                            'A tabela não existe em: CollDatFsNaTransacao');
               TaStatus := ParametroInvalido;
               Exit;
             End;


        CASE  Transaction  OF
           Tra_Nul :  Begin
                        TaStatus := ParametroInvalido;
                        Raise TException.Create7('',
                             'Tb_Acce2.inc',
                             'TTransaction',
                             'AnulaTransacao',
                             Current_DatF_FileName,
                             Format('%d',[Tra_Nul]),
                             TaStatus);
                      end;

            {AddRec
              1 - Pode adicionar no final do arquivo. -> Expandindo tamanho do arquivo
              2 - Aproveitar o primeiro livre que á uma especie de alteracao
            }
          Tra_AddRec : Begin
                          If TTb_Access.ok_Debug_Transaction
                          Then EscrevaFErrRollBack('Anula transação: Tra_AddRec.DeleteRec',i,RollBack_Reg_Transaction);

                          If (Current_Nr < CurrentDatFsNaTransacao.dataFile.F.FileSize) And
                             (Not TTb_Access.DeleteRec(CurrentDatFsNaTransacao.dataFile^,Current_Nr))
                          Then Raise TException.Create(Self,'AnulaTransacao',
                                                        Current_DatF_FileName,
                                                        '',
                                                        'Não posso deletar o registro que anteriormente foi adicionado');
                        End;

          {Obs. DeleteRec á um tipo de alteracao}

          Tra_PutRec,
          Tra_DeleteRec : Begin
                            If TTb_Access.ok_Debug_Transaction Then
                              EscrevaFErrRollBack('Anula transação: Tra_PutRec.PutRec',i,RollBack_Reg_Transaction);

                            If Current_Nr < CurrentDatFsNaTransacao.dataFile.F.FileSize Then
                              If Not TTb_Access.PutRec(CurrentDatFsNaTransacao.dataFile^,Current_Nr,Reg)
                              Then Raise TException.Create(Self,'AnulaTransacao',
                                                            Current_DatF_FileName,
                                                            '',
                                                            'Não posso gravar o registro que anteriormente foi modificado!.')
                          End;
        END; {Case}
      End;

    Finally
      AnulaTransacao := TaStatus;
//      CloseProgress1Passo(aAProgress1Passo);


    ENd;
  End;

  Procedure TTransaction.EscrevaFErrRollBack(OperacaoInversa:String;i:Longint;Const aReg_Transaction : PReg_Transaction);
  Begin
    Try
//      {$IFDEF TaDebug}Application.Push_MsgErro('Tb_Access.DbTra.Pas.TTransaction.EscrevaFErrRollBack',ListaDeChamadas);{$ENDIF}
      With aReg_Transaction^,IDReg_Transaction,Data,Hora do
      Logs.WriteLnFErr(Spc(OperacaoInversa,10)+' '+
                  Spc(Current_DatF_FileName,50)+'  '+
                  IStr(Current_NR,'IIIIII')+'  '+
                  IStr(ord(Transaction),'BB')
              );
    Finally

    End;
  End;

  Function TTransaction.Rollback:Integer;
  { Descrição
     Os Rollback mátodo desfaz a transação atual e assim cancela todas
     as modificações feitas ao banco de dados desde a ultima chamada para
     StartTransaction.
    Obs:
      O Índice será uma collecao de strings;

    Desfaz a transação que está pendente .
            1 - Open Transaction.Tb no modo exclusivo
            2 - Reindexa o arquivo de trasação utizando os campos Data+Hora e
          abre todos os arquivos envolvidos na transação.

            3 -  ok_Set_Transaction=true. Obs. Quando ok_Set_Transaction=true o sistema
          fará todo os passos feitos por um arquivo comum sá que Não atualizará o
           indice temporário que ele está usando.
   }

   Var //Variáveis usadas para salvar a situção anterior de Destroy memory e Create memory
     _Result   : SmallInt;
     Wok       : Boolean;

     aTempoDeTentativas : Longint;
     ClockBegin         : DWord;
     wTaStatus          : Integer;
  Begin
    Try //Finally
//      Try //except
          Try //Finally
//            SysSetSystemCursor_OCR_WAIT_SQL(True);
            OkRollback := True;
            Wok      := Ok;
            wTaStatus := TaStatus;
            TaStatus := 0;

            If TTb_Access.ok_Debug_Transaction
            Then logs.WriteLnFErr('********** TTransaction.RollBack ************');

            Ok := (DatF.Handle=HANDLE_INVALID);
            If ok
            Then ok := (TransactionPendant=0)
            Else Ok := True;

            If ok Then
            Begin
    //          AProgress1Passo := OpenProgress1Passo('RollBack...','Processando',3);

              N := 0;

              ok_Set_Transaction := False;  {Desabila explicitamente }

              If (DatF.Handle = HANDLE_INVALID) //Rollback chamado para anular um processo nao concluido
              Then Begin
                     DatF.Open(stOpen, FmWait);
                     TaStatus := DatF.ErrorInfo;
                     Ok       := (DatF.Status=0)
                   End
              Else Ok := true;

              If ok
              Then Begin {Se Não conseguir abrir á porque outro processo fez o RollBack }
                      If DatF.GetSize=0
                      Then Begin
                             try
                               DatF.Close;
                             except
                             end;
                             TaStatus := 0;
                             exit;
                           End;
                      TaStatus := Init_CollDatFsNaTransacao;
                      If TaStatus <> 0
                      Then Begin
                             try
                               DatF.Close;
                             except
                             end;
                             exit;
                           End;

                      If (OpenFile_CollDatFsNaTransacao = 0)
                      Then Begin
                             ok_Set_Transaction := true;
                             _Result := AnulaTransacao;
                             CollDatFsNaTransacao.FreeAll;
                             Col_Class_Reg_Transaction.FreeAll;

                             If _Result = 0
                             Then DatF.Truncate(0);
                             DatF.Close;

      {                       If _Result = 0
                             Then DelFile(DatF.fileName);} {Nao pode usar commit porque fileOpens esta fechado}

                             ok_Set_Transaction := False;
                             TaStatus := _Result ;
                           End;

                   End
              Else Begin
                      //Não está mais pendente
                      If TaStatus IN [ArquivoNaoEncontrado2,ArquivoNaoEncontrado18]
                      Then TaStatus := 0
                      Else BEGIN
                             Try
                               aTempoDeTentativas := TempoDeTentativas ;
                               ClockBegin         := GetDosTicks;

    //                           AProgress1Passo := OpenProgress1Passo('Aguarde: Conectando...','Rollback. código: '+Int2Str(TaStatus),TempoDeTentativas);

                               WHILE (TaStatus <> 0 ) and (GetDosTicks - ClockBegin <= Seg_to_MillSeg(TempoDeTentativas)) DO
                               BEGIN
                                 CtrlSleep(0);
    //                             SetProgress1Passo(AProgress1Passo,GetDosTicks - ClockBegin);
                                 Case TaStatus of
                                    Estrutura_da_tabela_esta_danificada : Abort;
                                    AcessoNegado5,
                                    AcessoNegado32,
                                    ErroViolacaoDeLacre                 : Begin
                                                                            //Delay(100);
                                                                            Delay(1);
                                                                            TaStatus := RollBack;
                                                                          End;
                                    ELSE
                                    BEGIN
                                      Abort;
                                    END ;
                                 End;

                                 IF KeyPressed
                                 THEN FTempoDeTentativas(0);

                               END; {While}

                             Finally
                               TempoDeTentativas := aTempoDeTentativas ;
    //                           CloseProgress1Passo(AProgress1Passo);
                             End;

                           END; {Else BEGIN}
                   End; {Else Begin}
            End; {If Ok Then begin onde: ok:= IsFileOpen(DatF.F) or (TransactionPendant=0);}


          Finally

//            SysSetThreadPriority(tpNormal);
            Set_CTRL_SLEEP_ENABLE(wSysCtrlSleep_Enable);
    //        Set_CTRL_SLEEP_ENABLE(true);
    //        CloseProgress1Passo(AProgress1Passo);
//            SysSetSystemCursor_OCR_WAIT_SQL(false);


            Result := TaStatus;

    {       Desativei FlushAllFiles porque esta interferindo nos indexs de estoque e no index do razao contabil. Verificar depois porque}

            If (Result = 0) and (FilesOpens<> nil)
            Then FilesOpens.FlushAllFiles;



            IF TaStatus <> 0
            tHEN BEGIN
                   Raise TException.Create(Self,'Rollback()',
                                           '',
                                           '',
                                           TaStatus);

                 END;

//            SysSetThreadPriority(tpNormal);
            ok         := WOk;
            try
              DatF.Close; // fecha se estiver aberto
            except
            end;
            TaStatus   := wTaStatus;
            OkRollback := False;
          End;

        //Except
        //  Raise TException.Create(Self,'Rollback()',
        //                                '',
        //                                '',
        //                                TaStatus);
        //
        //
        //end;

    Finally
      MessageError;
    End;
  End;

{@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@}
