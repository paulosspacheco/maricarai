{ Incluide de Tb_Access.pas

Objeto para controle dos arquivos aberto
  NOVO
    09/09/2000
      1 Implementacao de Function MaxTamReg:Word;

  CORRE�OES
  MELHORIAS
  PENDENCIAS
}

(* Declaracao publica porque Tb__Access a utiliza
Type
{FilesOpens � uma colecao que mantem todos os arquivos abertos ate o momento
 com objetivo de  fecha-los nos casos execessao.}
  TFilesOpens= ^TFilesOpens;
  TFilesOpens = Class(TSortedCollection {TCollection})
                    okFlushAllFiles : Boolean;{True = Habilita FlushAllFiles}
                    constructor Create;
                    function Compare(Key1, Key2: Pointer): SmallInt;Override;
                    Procedure ListaTabelas;
                    procedure Insert(Item: Pointer); Override;
                    procedure FreeItem(Item: Pointer); Override;
                    Function FOkCodigo (NomeIxF:PathStr;Const código:tString):Boolean;
                    Procedure FlushIndexs;
                    Procedure FlushAllFiles;
                    Function StrDatFRecsLocks(Const DatF:dataFile):tString;
                    Function StrRecsLocks(Const aFileName:PathStr):tString;
                    Procedure EstatisticasDosArquivosAbertos;
                    Procedure SaveCurrentState;
                    Procedure RestoreCurrentState;
                    Function MaxTamReg:Word;
                  End;
Var
  FilesOpens   : TFilesOpens;
*)

constructor TFilesOpens.Create;{(ALimit, ADelta: SmallInt);}
Begin
//  {$IFDEF TADebug} Application.Push_MsgErro('Tb_Access.TFilesOpens.Create',ListaDeChamadas);{$ENDIF}

  Inherited Create(TTb_Access.MaxFilesOpens,10);
  okFlushAllFiles := False; { True = Habilita FlushAllFiles}

  Duplicates      := TRUE;{Permite duplicado}

End;

destructor TFilesOpens.destroy;
begin
  Try
    CloseAllFiles; // Antes de destruir as classes � bom que se fecha todos os arquivos:
  except
  end;

  try
    Inherited destroy;
  except

  end;
end;


Function TFilesOpens.Set_OkFlushAllFiles(wOkFlushAllFiles:boolean):Boolean;
Begin
  Result          := OkFlushAllFiles;
  OkFlushAllFiles := wOkFlushAllFiles;
end;

function TFilesOpens.Compare(Key1, Key2: Pointer): Sw_Integer;
Var
  sKey1, sKey2 : PathStr;
Begin
  {Identifica a primeira chave}
  Try
    If (Key1 <> nil) and (AnsiChar(Key1^) in ['D','I'])
    Then Begin
            If AnsiChar(Key1^) = 'D' {DataFile}
            Then sKey1 :=  UpperCase(TTb_Access.DataFile(Key1^).Filename)
            ELSE If AnsiChar(Key1^) = 'I' {IndexFile}
                 Then sKey1 :=  UpperCase(TTb_Access.IndexFile(Key1^).NomeArqDados)+
                                UpperCase(TTb_Access.IndexFile(Key1^).DataF.Filename)
                  Else sKey1 :=  '';
         End
    Else sKey1 :=  '';

    {Identifica a segunda chave}
    If (Key2 <> nil) and (AnsiChar(Key2^) in ['D','I'])
    Then Begin
            If AnsiChar(Key2^) = 'D' {DataFile}
            Then sKey2 :=  UpperCase(TTb_Access.DataFile(Key2^).Filename)
            else If AnsiChar(Key2^) = 'I' {IndexFile}
                 THEN sKey2 := UpperCase(TTb_Access.IndexFile(Key2^).NomeArqDados)+
                               UpperCase(TTb_Access.IndexFile(Key2^).DataF.FileName)
                 ELSE SKey2 := '';
         End
    ELSE SKey2 := '';
  Except
    sKey1 :=  #0;
    sKey2 :=  #1;
  end;
  {Teste se Key 1 Key}
  If sKey1 < sKey2
  Then Result := -1
  else If sKey1 = sKey2
       Then Result := 0
       else Result := 1; {Key1 > Key2}
End;

Procedure TFilesOpens.ListaTabelas;
  {Lista as tabelas abertas no momento}
  Var i : SmallInt;
Begin
  WRITElN;
  WriteLn('**********ARQUIVOS ABERTOS NO MOMENTO!***********');
  WRITElN;
  If IsValidPtr(Items) Then
  For i := 0 to Count-1 do
  Begin
    If IsValidPtr(Items^[i])  And
       (AnsiChar(PItemList(Items)^[i]^) = 'I')
    Then
       WriteLn('Index......:',TTb_Access.Lowcase(TTb_Access.IndexFile(PItemList(Items)^[i]^).DataF.F.FileName))
    else
      If IsValidPtr(Items^[i])  And
       (AnsiChar(PItemList(Items)^[i]^) = 'D') Then
       WriteLn('Tabela.....:',UpperCase(TTb_Access.DataFile(PItemList(Items)^[i]^).F.FileName))
     else
     Begin
       TaStatus := Objeto_Nao_Inicializado;
{       TaIOcheck(DatF,0);}
       Raise TException.Create(Self,'ListaTabelas()','','',TaStatus);

     end;
     WriteLn('            Tecle algo para continuar');
     WriteLn('Numero do arquivo: ',I);
     UAnsiChar:= Readkey;
  End;
end;

procedure TFilesOpens.Insert(Item: Pointer);
Begin
// {$IFDEF TaDebug}Application.Push_MsgErro('Tb_Access.TFilesOpens.Insert',ListaDeChamadas);{$ENDIF}
{  If IsValidPtr(Item) Then}
  If Item <> nil Then
  Begin
    Inherited Insert(Item);
  End
  else        Raise TException.Create(Self,'Insert()','','',Objeto_Nao_Inicializado);


End;

procedure TFilesOpens.FreeItem(Item: Pointer);
Begin
  Try
//    {$IFDEF TaDebug}Application.Push_MsgErro('Tb_Access.TFilesOpens.FreeItem',ListaDeChamadas);{$ENDIF}
    If IsValidPtr(Item) Then
    with TTb_Access do
    Begin
      Case AnsiChar(Item^) of
        'D' : Begin
                If Is_TFileOpen(DataFile(Item^).F)
                Then aCloseFile(DataFile(Item^));

              End;
        'I' : Begin
                If Is_TFileOpen(IndexFile(Item^).DataF.F) Then
                  ACloseIndex(IndexFile(Item^));
              End;
      End;
    End;
  Finally

  End;
End;

Function TFilesOpens.FOkCodigo (NomeIxF:PathStr;Const codigo:tString):Boolean;
Var I        : SmallInt;
{    FileName : PAnsiChar;}
    WOk : Boolean;
Begin
//  {$IFDEF TADebug} Application.Push_MsgErro('Tb_Access.TFilesOpens.FOkCodigo',ListaDeChamadas);{$ENDIF}
  WOk := ok;
  NomeIxF := UpperCase(NomeIxF);
  If IsValidPtr(Items) Then
  For i := 0 to Count-1 do
  Begin
    If IsValidPtr(Items^[i])  And
       (AnsiChar(PItemList(Items)^[i]^) = 'I') And
       (UpperCase(TTb_Access.IndexFile(PItemList(Items)^[i]^).DataF.F.FileName) = NomeIxF )
    Then
    Begin
      FOkCodigo := TTb_Access.FExisteCodigo(TTb_Access.IndexFile(PItemList(Items)^[i]^),codigo);
      Ok := Wok;

      Exit;
    End;
  End;
  FOkCodigo := False;
  Ok := Wok;

End;

Procedure TFilesOpens.FlushIndexs;
Var I        : SmallInt;
{    FileName : PAnsiChar;}
    aFlushBuffer : Boolean;
Begin
//  {$IFDEF TaDebug}Application.Push_MsgErro('Tb_Access.TFilesOpens.FlushIndexs',ListaDeChamadas);{$ENDIF}
  aFlushBuffer := FlushBuffer;
  FlushBuffer  := True;
  If IsValidPtr(Items) Then
  For i := 0 to Count-1 do
  with TTb_Access do
  BEGIN
    If IsValidPtr(Items^[i])  And
       (AnsiChar(PItemList(Items)^[i]^) = 'I')
    Then
      If Is_TFileOpen(IndexFile(PItemList(Items)^[i]^).DataF.F) Then
         FlushIndex(IndexFile(PItemList(Items)^[i]^));
  END;
  FlushBuffer := aFlushBuffer;

End;

Procedure TFilesOpens.FlushAllFiles;
Var I            : SmallInt;
    aFlushBuffer : Boolean;
    aFlushBuffer_Disk : Boolean;
Begin

  Try
//    {$IFDEF TADebug} Application.Push_MsgErro('Tb_Access.TFilesOpens.FlushAllFiles',ListaDeChamadas); {$ENDIF}
    If okFlushAllFiles Then
    Begin
      aFlushBuffer      := FlushBuffer;
      aFlushBuffer_Disk := FlushBuffer_Disk;

      FlushBuffer       := True;
      FlushBuffer_Disk  := true;

      If IsValidPtr(Items) Then
      For i := 0 to Count-1 do
      with TTb_Access do
      BEGIN
          If IsValidPtr(Items^[i])
          Then If (UPcase(AnsiChar(PItemList(Items)^[i]^)) = 'D')
               Then With DataFile(PItemList(Items)^[i]^) do
                    Begin
                       If Is_TFileOpen(f)
                       Then Begin
                              F.Flush;
//                              F.Flush_Disk; {Forca a gravacao em disco}
                            End;
                    End
               Else If (UPcase(AnsiChar(PItemList(Items)^[i]^)) = 'I')
                    Then With IndexFile(PItemList(Items)^[i]^).DataF do
                         Begin
                           If Is_TFileOpen(F)
                           Then Begin
                                  F.Flush;
//                                  F.Flush_Disk; {Forca a gravacao em disco}
                                End;
                         End;
      END;

      FlushBuffer      := aFlushBuffer;
      FlushBuffer_Disk := aFlushBuffer_Disk;

    End;
  Finally

  End;
End;

Function TFilesOpens.OpenAllFiles:Boolean;
  Var i : SmallInt;
Begin
  Try
    If IsValidPtr(Items) Then
    For i := 0 to Count-1 do
    with TTb_Access do
    BEGIN
        If IsValidPtr(Items^[i])
        Then If (UPcase(AnsiChar(PItemList(Items)^[i]^)) = 'D')
             Then With DataFile(PItemList(Items)^[i]^) do
                  Begin
                     If Not Is_TFileOpen(f)
                     Then Begin
                            try
                              F.Reset;
                              TaStatus :=  F.Status;
                              Result :=  TaStatus= 0;
                              If Not result
                              Then Abort;

                            except
                              If TaStatus = 0
                              Then TaStatus := Erro_Excecao_inesperada;

                              Raise TException.Create(Self,'OpenAllFiles()',
                                                       F.FileName,
                                                       '',
                                                      TaStatus);

                            End;
                          End;
                  End
             Else If (UPcase(AnsiChar(PItemList(Items)^[i]^)) = 'I')
                  Then With IndexFile(PItemList(Items)^[i]^).DataF do
                       Begin
                         If Not Is_TFileOpen(F)
                         Then Begin
                                try
                                  F.Reset;
                                  TaStatus :=  F.Status;
                                  Result :=  TaStatus= 0;
                                  If Not result
                                  Then Abort;

                                except
                                  If TaStatus = 0
                                  Then TaStatus := Erro_Excecao_inesperada;

                                  Raise TException.Create(Self,'OpenAllFiles()',
                                                           F.FileName,
                                                           '',
                                                          TaStatus);
                                End;
                              End;
                       End;
    END;

  Finally

  End;
End;

Function TFilesOpens.CloseAllFiles:Boolean;
Var I : SmallInt;
Begin
  Try
    If IsValidPtr(Items) Then
    For i := 0 to Count-1 do
    with TTb_Access do
    BEGIN
        If IsValidPtr(Items^[i])
        Then If (UPcase(AnsiChar(PItemList(Items)^[i]^)) = 'D')
             Then With DataFile(PItemList(Items)^[i]^) do
                  Begin
                     If Is_TFileOpen(f)
                     Then Begin
                            try
                              F.Close;
                              TaStatus :=  F.Status;
                              Result :=  TaStatus= 0;
                              If Not result
                              Then Abort;

                            except
                              If TaStatus = 0
                              Then TaStatus := Erro_Excecao_inesperada;

                              Raise TException.Create(Self,'CloseAllFiles()',
                                                       F.FileName,
                                                       '',
                                                      TaStatus);

                            End;
                          End;
                  End
             Else If (UPcase(AnsiChar(PItemList(Items)^[i]^)) = 'I')
                  Then With IndexFile(PItemList(Items)^[i]^).DataF do
                       Begin
                         If Is_TFileOpen(F)
                         Then Begin
                                try
                                  F.Close;
                                  TaStatus :=  F.Status;
                                  Result :=  TaStatus= 0;
                                  If Not result
                                  Then Abort;

                                except
                                  If TaStatus = 0
                                  Then TaStatus := Erro_Excecao_inesperada;

                                  Raise TException.Create(Self,'CloseAllFiles()',
                                                           F.FileName,
                                                           '',
                                                          TaStatus);
                                End;
                              End;
                       End;
    END;

  Finally

  End;
End;



(*
Function TFilesOpens.StrDatFRecsLocks(Const DatF:dataFile):tString;
  {Retorna uma lista de registros travados da tabela}
  var
    aStrDatFRecsLocks : tString;
    i                 : Byte;
Begin
  aStrDatFRecsLocks := '';
  If (IsValidPtr(DatF.ColRecsLocks)) and
     (DatF.ColRecsLocks.Count>=1)
  Then
    For I := 0 to DatF.ColRecsLocks.Count-1 do
     with DatF,F,ColRecsLocks do
      If (DatF.ColRecsLocks.RecLockByNum(i) <> nil) and
         (DatF.ColRecsLocks.RecLockByNum(i).NrsLocked<>0)
      Then
        aStrDatFRecsLocks := aStrDatFRecsLocks+'; NR: '+
                             IStr(DatF.ColRecsLocks.RecLockByNum(i).NrLockCreate,'LLLLLLL');
  StrDatFRecsLocks := aStrDatFRecsLocks;
End;

Function TFilesOpens.StrRecsLocks(Const aFileName:PathStr):tString;
  {
    Retorna a lista de registros travados em todas as referencias de FileName:
  }
  var
    aStrRecsLocks,SHandle : tString;
    i                     : SmallInt;
Begin

  aStrRecsLocks := '';

    If IsValidPtr(Items) Then
    For i := 0 to Count-1 do
    BEGIN
        If IsValidPtr(Items^[i]) Then
          If (AnsiChar(PItemList(Items)^[i]^) = 'D') Then
          Begin
            If Is_TFileOpen(DataFile(PItemList(Items)^[i]^).f) and
               (
               DataFile(PItemList(Items)^[i]^).f.FileName= aFileName
               )
            Then
            Begin
              SHandle := Int2Str(DataFile(PItemList(Items)^[i]^).f.Handle);
              aStrRecsLocks := aStrRecsLocks +
                               'Handle: '+SHandle+' -> '+
                               StrDatFRecsLocks(DataFile(PItemList(Items)^[i]^));
            End;
          End
          Else
          Begin
            If Is_TFileOpen(IndexFile(PItemList(Items)^[i]^).DataF.F) And
               (
               IndexFile(PItemList(Items)^[i]^).DataF.F.FileName= aFileName
               )
            Then
            Begin
              SHandle := Int2Str(IndexFile(PItemList(Items)^[i]^).DataF.F.Handle);
              aStrRecsLocks :=
              aStrRecsLocks +'Handle: '+SHandle+' -> '+
                  StrDatFRecsLocks(IndexFile(PItemList(Items)^[i]^).DataF);
            end;
          End;
    END;
  StrRecsLocks := aStrRecsLocks;

End;
*)

Procedure TFilesOpens.EstatisticasDosArquivosAbertos;
{
  Arquivo      |  Num.Regs | Num.Chaves |
  -------------|-----------|------------|
  xxxxxxxx.xxx | 999999999 |  9.999.999 |
}
  Var
    Lista        : TCollectionString;
    ListaSItem   : PSItem;

    I      : SmallInt;
    DatF   : TTb_Access.PDataFile;
    DatFIx : TTb_Access.PIndexFile;
    ItemSelecionado : TCollectionString.TListBoxRec;

    //var Dir: DirStr;
    //var Name: NameStr;
    //var Ext: ExtStr;

Begin
  {Lista :=  New(TCollectionString,Create(1,1,False));}{Insere a string em ordem sequencial}
  Lista :=  TCollectionString.Create(1,1,False);{Insere a string em ordem sequencial}
  If Lista <> nil Then
  Begin                                                         {Lista de registros travado}
    Lista.NewStr('+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++');
    Lista.NewStr('Arquivo        | Regists.| Chaves  |Tam.Reg|travas / Pastas');
    Lista.NewStr('---------------|---------|---------|-------|---------------------------');

    If IsValidPtr(Items) Then
    For i := 0 to Count-1 do
    with TTb_Access do
    BEGIN
        If IsValidPtr(Items^[i]) Then
          If (AnsiChar(PItemList(Items)^[i]^) = 'D') Then
          Begin
            DatF := PDataFile(PItemList(Items)^[i]);
            If Is_TFileOpen(DatF.F) Then
            Begin
              Lista.NewStr(Spc(ExtractFileName(DatF.F.FileName)+ExtractFileExt(DatF.F.FileName),14)         +' | '+
                           IStr(FileSize(DatF.F.FileName),'LLLLLLL')+' | '+
                            '-DADOS-'+' | '+
                            IStr(DatF.ItemSize,'WWWWW')+' | '+
{                            StrDatFRecsLocks(DatF^)+' | '+}
                            ExtractFilePath(DatF.F.FileName)
                          );
            End;
          End
          Else
          Begin
            DatFIx := PIndexFile(PItemList(Items)^[i]);
            If Is_TFileOpen(DatFIx^.DataF.F) Then
            Begin
              //FSplit(FExpand(DatFIx^.DataF.F.FileName),Dir,Name,Ext);
              Lista.NewStr('  '+Spc(Spc(ExtractFileName(DatF.F.FileName)+ExtractFileExt(DatF.F.FileName),14),12)         +' | '+
                           IStr(FileSize(DatFIx^.DataF.Filename),'LLLLLLL')+' | '+
                           IStr(DatFIx^.DataF.NumberKey,'LLLLLLL')+' | '+
                           IStr(DatFIx^.DataF.ItemSize,'WWWWW')+' | '+
{                           StrDatFRecsLocks(DatFIx^.DataF)+' | '+}
                           ExtractFilePath(DatF.F.FileName)
                          );
            end;
          End;
    END;
    ListaSItem   := Lista.PListSItem;
    ItemSelecionado.Selection := 0;
    if Assigned(MI_MsgBox)
    then with MI_MsgBox do
          MessageBox_ListBoxRec_PSItem('Total de arquivos aberto: '+IStr(Count-1,'BBB'),
                       ListaSItem,
                       ItemSelecionado.Selection,
                       mtInformation,mbokButton,mbOK);
    DisposeSItems(ListaSItem);
  End;
  Discard(TObject(Lista));
End;

Procedure TFilesOpens.SaveCurrentState;
  {Este comando tem como objetivo salvar em collectionCurrentState o nome
   de todos os arquivos que forma aberto no modo exclusivo bem como
   todos os registros que estão travados no momemento da chamada.
  }
Begin
end;
Procedure TFilesOpens.RestoreCurrentState;
  {Este comando tem como objetivo  restabelecer o estado dos arquivos utilizando
   collectionCurrentState.

   Este procedimento se faz necessário quando se quer manter as travas de
   alguns tipos de arquivos como a raiz.Tb da aplicacao bem como os
   registros travados de usu�rios logados.
  }
Begin
End;

Function TFilesOpens.MaxTamReg:SmallWord;
Var
  Maior   : Word;
  i       : SmallInt;
  DatF    : TTb_Access.PDataFile;
  DatFIx : TTb_Access.PIndexFile;
Begin
  Maior := 0;
  If IsValidPtr(Items) Then
  For i := 0 to Count-1 do
  with TTb_Access do
  BEGIN
      If IsValidPtr(Items^[i]) Then
        If (AnsiChar(PItemList(Items)^[i]^) = 'D') Then
        Begin
          DatF := PDataFile(PItemList(Items)^[i]);
          If Is_TFileOpen(DatF.F) Then
          Begin
            If Maior < DatF.ItemSize Then
             Maior := DatF.ItemSize;
          End;
        End
        Else
        Begin
          DatFIx := PIndexFile(PItemList(Items)^[i]);
          If Is_TFileOpen(DatFIx^.DataF.F) Then
          Begin
            If Maior < DatFIx^.DataF.ItemSize Then
             Maior := DatFIx^.DataF.ItemSize;
          end;
        End;
  END;
  MaxTamReg := maior;
End;

