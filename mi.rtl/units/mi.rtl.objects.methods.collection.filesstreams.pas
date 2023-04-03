unit mi.rtl.Objects.Methods.Collection.FilesStreams;
{:< - A unit **@name** implementa a classe TFilesStreams do pacote mi.rtl.

    - **VERSÃO**:
      - Alpha - 0.7.0.0

    - **CÓDIGO FONTE**:
      - @html(<a href="../units/mi.rtl.objects.methods.Collection.FilesStreams.pas">mi.rtl.objects.methods.Collection.FilesStreams.pas</a>)

    - **HISTÓRICO**
      - Criado por: Paulo Sérgio da Silva Pacheco e-mail: paulosspacheco@@yahoo.com.br
        - 2021-12-18
          - 14:42 a .. - T12 Criar a unit **@name** e a classe TFilesStreams

        - 2021-12-20
          - 17:11 a 18:30 - T12 Criar a classe **TFilesStreams**
          - 20:20 a 22:54 - T21 Criar exemplo de uso da classe TFilesStreams
}

{$IFDEF FPC}
  {$MODE Delphi} {$H+}
{$ENDIF}

interface

uses
  Classes
  , SysUtils
  , mi.rtl.objects.consts.MI_MsgBox
  , mi.rtl.objects.consts.progressdlg_if
  , mi.rtl.objects.methods.StreamBase.Stream
  , mi.rtl.objects.methods.StreamBase.Stream.FileStream
  , mi.rtl.objects.methods.Collection
   ;


TYPE
  {: - A classe  **@name** é usada para armazenar todos os arquivos abertos pelo sistema para
       poder fecha-los caso o programa aborte inesperadamente.

     - EXEMPLO DE USO

       ```pascal

         procedure TMi_Rtl_Tests.TabSheet_TFilesStreamsEnter(Sender: TObject);
           var
            i,L : integer;
            s:AnsiString;

         begin
           filesStreams.DeleteAll;
           StringGrid1.Clear;

           filesStreams.Mask := edit2.Text;
           StringGrid1.RowCount := filesStreams.Count+1;

           LabelCount2.Caption := Format('FilesStreams.Count %d',[filesStreams.Count]);
           LabelCount2.Show;
           L := 0;
           StringGrid1.Cells[0,l] := 'Seq';
           StringGrid1.Cells[1,l] := 'FileName';
           StringGrid1.Cells[2,l] := 'FileSize';
           inc(l);
           if filesStreams.Count > 0
           then begin
                   for i := 0 to filesStreams.Count-1 do
                   with filesStreams.FileByNum(i) do
                   begin
                     StringGrid1.Cells[0,l] := Format('%d',[l]);
                     StringGrid1.Cells[1,l] := FileName;
                     s := Format('%d',[FileSize(FileName)]);
                     StringGrid1.Cells[2,l] := s ;
                     inc(L);
                   end;
                end;

         end;

         procedure TMi_Rtl_Tests.Edit2Change(Sender: TObject);
         begin
           TabSheet_TFilesStreamsEnter(Self);
         end;

       ```
  }
  TFilesStreams =
  Class(TCollection)

    Private
      _Mask  : AnsiString;

    {: - O método **@name** é usado para filtrar os arquivo da pasta corrente do banco de dados.

       - **Nota**
         - Para compreender essa função é bom ler o exemplo: TFiles.FindFiles

    }
    protected  Procedure SetMask(a_Mask  : AnsiString); {Ao setar a mascara devo inicializar collection}

    Published
      {: - A propriedade **@name** é usada como filtro na função SysUtils.FindFirst}
      Property Mask  : AnsiString Read _mask write SetMask;

    Public
      CONSTRUCTOR Create;
      Function FileByNum (const Index:Longint):TFileStream;
      Function FileByName(const aFileName:AnsiString):TFileStream;

      Function CopyFiles(aPathDest:PathStr):Integer;
      Function DeleteFiles():Integer;

    Public
       PROCEDURE Error (Code, Info: Integer); Override;
       Procedure Create_Progress1Passo(ATitle : tString;Obs:tString ; ATotal : Longint);Override;
       Procedure Set_Progress1Passo(aNumero_Segundos_que_deve_esperar : Longint);Override;
       Procedure Destroy_Progress1Passo;Override;


    Private
      _Progress1Passo : TProgressDlg_If;

  End;


implementation


// Implementacao de TFilesStreams


  CONSTRUCTOR TFilesStreams.Create;
  Begin
    Inherited Create(MaxDirSize,MaxDirSize);
  end;

  Procedure TFilesStreams.SetMask(a_Mask  : AnsiString); {Ao setar a mascara devo inicializar a collection}
    Var
      DosStream : TFileStream;

    procedure FindFiles;
      var
        sr       : TSearchRec;
        FileAttrs: Integer;
        WResult  : Boolean;
    begin
      FileAttrs := faAnyFile;
      {Exemplo de uso de findFirtt pode ser encontrado em **FindFiles**}
      WResult := SysUtils.FindFirst(Mask, FileAttrs, sr) = 0;
      If Not WResult
      Then Mi_MsgBox.ShowMessage(Format('O aquivo "%s" e com atributos "%s" não encontrado!.',[Mask,'faAnyFile'] ));

      if WResult then
      begin
        repeat
          { O atributo faAnyFile indica todos os arquivos, inclusive os diretórios}
          if ((sr.Attr and faDirectory) = 0) then
          begin
            Insert(TFileStream.Create(ExpandFileName(sr.Name),FileMode));
          end;
        until SysUtils.FindNext(sr) <> 0;
        SysUtils.FindClose(sr);
      end;
    end;

   Var
     WCurrentDir : PathStr;
     wPathFont   : tString;
  Begin
    try
      wCurrentDir := GetCurrentDir;
      wPathFont   := ExtractFilePath(a_Mask);
      If wPathFont <> ''
      Then SetCurrentDir(wPathFont);

      FreeAll;
      _Mask := ExpandFileName(a_Mask);
      FindFiles;

    finally
      SetCurrentDir(wCurrentDir);
    end;
  end;

  Function TFilesStreams.FileByNum (const Index:Longint):TFileStream;
  Begin
    Result := TFileStream(At(Index));
  end;

  Function TFilesStreams.FileByName(const aFileName:AnsiString):TFileStream;
    Var
      I : Longint;
  Begin
    For I := 0 to Count - 1 do
    Begin
      Result := FileByNum(i);

      If (Result.FileName = UpperCase(aFileName))
      Then Exit;

    end;
    Result := nil;
  end;

  Function TFilesStreams.CopyFiles(aPathDest:PathStr):Integer;
    {
     CopyFiles('PathDestino');
    }
    Var
      I          : Longint;
      aaPathDest : PathStr;
      DosStream  : TFileStream;

  Var
    N : AnsiString;
    Dir,Name,Ext,FileNameDest: PathStr;

  Begin
    If aPathDest = ''
    Then Begin
           Error(stCreateError,ParametroInvalido);
           Result := ErrorInfo;
           exit;
         End;

    aPathDest   := UpperCase(ExpandFileName(aPathDest));
    aaPathDest  := UpperCase(ExtractFilePath(ExpandFileName(aPathDest)));

    Try
      Try
//        SysSetSystemCursor_OCR_WAIT(True);
        Create_Progress1Passo('Copiando arquivos...',ExtractFileName(Mask)+' para '+aPathDest, Count{-1});

        For I := 0 to Count - 1 do
        Begin
          Set_Progress1Passo(I);

          DosStream := FileByNum(i);
          If DosStream <> nil
          Then Begin
    {             If ExtractFilePath(ExpandFileName(DosStream.FileName)) = aaPathDest
                 Then Begin
                        Error(stCreateError,ParametroInvalido);
                        Raise TException.Create(Name_Type_App_MarIcaraiV1,
                                     'Systemm.Pas',
                                     'TFilesStreams',
                                     'Function CopyFiles():Integer;',
                                      DosStream.FileName,
                                      '',
                                      ^C+'Nome do arquivo fonte e destino deve serem diferentes!...'+^M+
                                      ^M+
                                      'Nome do arquivo fonte..: '+ExpandFileName(DosStream.FileName+^M+
                                      'Nome do arquivo destino: '+aaPathDest+UpperCase(ExtractFileName(ExpandFileName(DosStream.FileName)))));

                      End;     }

    //             N := ExtractFilePath(ExpandFileName(aaPathDest))+ ExtractFileName(ExpandFileName(DosStream.FileName));

                 If IsDirectory(aPathDest)  //FileGetAttr(ExpandFileName(aPathDest)) = faDirectory
                 Then Begin
                        //FSplit(ExpandFileName(aaPathDest),Dir,Name,Ext);
                        FileNameDest := aaPathDest + ExtractFileName(ExpandFileName(DosStream.FileName));
                      End
                 Else FileNameDest := aPathDest;

                 Try
                   If ExpandFileName(DosStream.FileName) = UpperCase(ExpandFileName(FileNameDest))
                   Then Begin
                          Error(stError,ParametroInvalido);
                          raise EArgumentException.Create(TStrError.ErrorMessage(Self,
                                                                                 'CopyFiles()',
                                                                                  DosStream.FileName,
                                                                                 '',
                                                                                 'Não posso copiar um arquivo para si mesmo.!!!'));
                        end;


                   DosStream.SaveToFile(FileNameDest);

                   If DosStream.Status <> StOk
                   Then Error(DosStream.Status,DosStream.ErrorInfo);

      //             TaStatus := SysCopyFile(FExpand(DosStream.FileName),ExtractFilePath(ExpandFileName(aaPathDest))+ExtractFileName(ExpandFileName(DosStream.FileName)),false);

                 Finally
                   If TaStatus <> 0
                   Then Begin
                          Error(stError,TaStatus);
                          raise EArgumentException.Create(TStrError.ErrorMessage(Self,
                                                                                 'CopyFiles()',
                                                                                  DosStream.FileName,
                                                                                 '',
                                                                                 TaStatus));

                          //Raise TException.Create(Self,
                          //                       'Function CopyFiles():Integer;',
                          //                        DosStream.FileName,
                          //                        '',
                          //                        TaStatus);
                        End;
                 End;
               end;
        end;

      Finally
        Destroy_Progress1Passo;
        Result := ErrorInfo;
//        SysSetSystemCursor_OCR_WAIT(False);
      End;

    Except
      If ErrorInfo = 0
      Then ErrorInfo := 239; {Excecao_inesperada}
      TaStatus := ErrorInfo;

      Result := ErrorInfo;
    end;
  end;

  Function TFilesStreams.DeleteFiles():Integer;
    Var
      I          : Longint;
      aaPathDest : AnsiString;
      DosStream  : TFileStream;

  Var
    N : AnsiString;
    Dir,Name,Ext,FileNameDest: tString;

  Begin
   Try
      Try
//        SysSetSystemCursor_OCR_WAIT(True);
        Create_Progress1Passo('Apagando arquivos...',ExtractFileName(Mask), Count{-1});

        For I := 0 to Count - 1 do
        Begin
          Set_Progress1Passo(I);

          DosStream := FileByNum(i);
          If DosStream <> nil
          Then Begin
                 Try
                   DosStream.DeleteFile;

                   If DosStream.Status <> StOk
                   Then Error(DosStream.Status,DosStream.ErrorInfo);

                 Finally
                   If TaStatus <> 0
                   Then Begin
                          Error(stError,TaStatus);
                          raise EArgumentException.Create(TStrError.ErrorMessage(Self,
                                                       'DeleteFiles()',
                                                        DosStream.FileName,
                                                       '',
                                                       TaStatus));

                          //Raise TException.Create(Self,
                          //             'Function DeleteFiles():Integer;',
                          //              DosStream.FileName,
                          //              '',
                          //              TaStatus);
                        End;
                 End;
               end;
        end;

      Finally
        Destroy_Progress1Passo;
        Result := ErrorInfo;
//        SysSetSystemCursor_OCR_WAIT(False);
      End;

    Except
      If ErrorInfo = 0
      Then ErrorInfo := 239; {Excecao_inesperada}
      TaStatus := ErrorInfo;

      Result := ErrorInfo;
    end;
  end;


  PROCEDURE TFilesStreams.Error (Code, Info: Integer);
  Begin
    Status   := Code;
    ErrorInfo := Info;
    TaStatus := ErrorInfo;
  end;

  Procedure TFilesStreams.Create_Progress1Passo(ATitle : tString;Obs:tString ; ATotal : Longint);
  Begin
    Discard(TObject(_Progress1Passo)); //Descarta se tiver pendente
  {  If ErrorInfo <> 0
    Then _Progress1Passo := OpenProgress1Passo(ATitle,TurboError(ErrorInfo),ATotal)
    Else _Progress1Passo := OpenProgress1Passo(ATitle,Obs,ATotal);
  }
    If ErrorInfo <> 0
    Then _Progress1Passo := TProgressDlg_If.Create(ATitle,SysErrorMessage(ErrorInfo),Delta_Locate,ATotal)
    Else _Progress1Passo := TProgressDlg_If.Create(ATitle,Obs                  ,Delta_Locate,ATotal);

  end;

  Procedure TFilesStreams.Set_Progress1Passo(aNumero_Segundos_que_deve_esperar : Longint);
  Begin
    _Progress1Passo.IncPosition(aNumero_Segundos_que_deve_esperar);
  end;

  Procedure TFilesStreams.Destroy_Progress1Passo;
  Begin
    Discard(TObject(_Progress1Passo)); //Descarta se tiver pendente
  end;


end.

