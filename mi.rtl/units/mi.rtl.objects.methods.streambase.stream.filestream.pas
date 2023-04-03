unit mi.rtl.Objects.Methods.StreamBase.Stream.FileStream;
  {:< - A Unit **@name** implementa a classe TFileStream do pacote **mi.rtl**.

    - **NOTAS**
      - Implementa banco um fluxo de dados em disco.

    - **VERSÃO**
      - Alpha - 0.7.0.0

    - **HISTÓRICO**
      - Criado por: Paulo Sérgio da Silva Pacheco e-mail: paulosspacheco@@yahoo.com.br
        - **22/11/2021**
          - 17:00 a 19:45 Criar a unit @name

        - **29/11/2021**
          - 10:10 a 12:01 - t12 Documentar a classe TFileStream. Exemplo 01: Test_FileStream_com_header
          - 13:50 a 14:33 - t12 Documentar a classe TFileStream. Exemplo 01: Test_FileStream_sem_header

        - **21/12/2021**
          - 15:30 a 16:20 - T12 Transferir os métodos de TDosStream para TFileStrem.

    - **CÓDIGO FONTE**:
      - @html(<a href="..//units/mi.rtl.objects.methods.StreamBase.Stream.FileStream.pas">/units/mi.rtl.objects.methods.StreamBase.Stream.FileStream.pas</a>)

  }

  {$IFDEF FPC}
    {$MODE Delphi} {$H+}
  {$ENDIF}

interface

uses
  Classes, SysUtils
  ,mi.rtl.types
  ,mi.rtl.consts
  ,mi.rtl.files
  ,mi.rtl.objects.types
  ,mi.rtl.objects.Methods  
  ,mi.rtl.objects.methods.StreamBase 
  ,mi.rtl.objects.methods.StreamBase.Stream
  ,mi.rtl.objects.consts.MI_MsgBox

  ;

  type
    {: - A classe **@name** é usada para criar um fluxo de dados em disco usada no banco de dados mar-icarai, onde é
         possível adicionar um registro no início do arquivo de tamanho maior ou menor que os registros seguintes ao registro zero.

       - **EXEMPLOS**
         - Test_FileStream_sem_header

          ```pascal

           Procedure TMi_Rtl_Tests.Test_FileStream_sem_header;
             type
              TAluno = record
                         Id : integer;
                         nome : string[35];
                       end;

             var
               FileStream_Alunos : TObjectss.TFileStream;
               aluno : TAluno;//Registro de aluno

               nr : longint; //Número do registro.
               n  : longint; //Contador

           begin
             with TObjectss do
             try
               fillchar(aluno,sizeof(aluno),' ');

               if TObjectss.FileExists(expandFileName('aluno.txt'))
               then FileStream_Alunos := TFileStream.Create(expandFileName('aluno.txt'),fileMode)
               else FileStream_Alunos := TFileStream.Create(expandFileName('aluno.txt'),fileMode,fmCreate );

               with aluno,FileStream_Alunos do
               if status = StOk then
               begin
                 //Define o tamanho do registro
                 recSize := sizeof(aluno);

                 //Adiciona o registro 0;
                 if status = StOk then
                 begin
                   n := 0;
                   Id:= n;
                   nome:= 'Paulo Sergio';
                   PutRec(n,aluno);
                 end;

                 //Adiciona o registro 1;
                 if status = StOk then
                 begin
                   inc(n);
                   Id:= n;
                   nome:= 'George Bruno';
                   PutRec(n,aluno);
                 end;

                 // Ler e imprime os registros salvos acima.
                 if status = StOk then
                 begin
                   for nr := 0 to n do
                   begin
                     GetRec(nr,aluno);
                     if Status = Stok
                     then begin
                            SysMessageBox('Nr ='+intToStr(nr)+    '; id ='+intToStr(aluno.id)+'; Aluno ='+al
                                          ,'Test_FileStream_sem_header'
                                          ,false);

                          end
                     else break;
                   end;
                 end;//if
               end; //with

               with FileStream_Alunos do
                 if status <> StOk
                 then SysMessageBox(ErrorMessage(ErrorInfo),'Test_FileStream_sem_header',true);

             finally
               FileStream_Alunos.Destroy;
             end;

           end;

          ```

         - Test_FileStream_com_header

          ```pascal

            procedure TMi_Rtl_Tests.Test_FileStream_com_header;

              type

               // Tipo de registro 1 ao final do arquivo:
               TAluno = record
                          Id : integer;
                          nome : string[35];
                        end;

               // Tipo de registro a ser usado no registro zero do arquivo.

               THeadAlunos = record
                               TotalDeAlunos:longint;
                             end;

              var
                FileStream_Alunos : TObjectss.TFileStream;
                aluno     : TAluno;//Registro de aluno
                headAluno : THeadAlunos;

                nr : longint; //Número do registro.
                n  : longint; //Contador

            //Início da procedure
            begin
             with TObjectss do
             try
               fillchar(aluno,sizeof(aluno),' ');

               if TObjectss.FileExists(expandFileName('aluno.txt'))
               then FileStream_Alunos := TFileStream.Create(expandFileName('aluno.txt'),fileMode)
               else FileStream_Alunos := TFileStream.Create(expandFileName('aluno.txt'),fileMode,fmCreate );

               with aluno,FileStream_Alunos do
               if status = StOk then
               begin
                 //Define o tamanho do registro zero
                 baseSize := sizeof(headAluno);

                 //Define o tamanho do registro
                 recSize := sizeof(aluno);

                 headAluno.TotalDeAlunos := 0;
                 PutRecBase(headAluno);

                 //Adiciona o registro 0;
                 if status = StOk then
                 begin
                   inc(headAluno.TotalDeAlunos);
                   n := headAluno.TotalDeAlunos;
                   Id:= n;
                   nome:= 'Paulo Sergio';
                   PutRec(n,aluno);
                   PutRecBase(headAluno);
                 end;

                 //Adiciona o registro 1;
                 if status = StOk then
                 begin
                   inc(headAluno.TotalDeAlunos);
                   n := headAluno.TotalDeAlunos;
                   nome:= 'George Bruno';
                   PutRec(n,aluno);
                   PutRecBase(headAluno);
                 end;

                 // Ler e imprime os registros salvos acima.
                 if status = StOk then
                 begin
                   getRecBase(headAluno);
                   if status = StOk then
                   begin
                     SysMessageBox('Número de registros='+intToStr(headAluno.TotalDeAlunos)
                                   ,'Test_FileStream_sem_header'
                                   ,false);

                     for nr := 1 to headAluno.TotalDeAlunos do
                     begin
                       GetRec(nr,aluno);
                       if Status = Stok then
                       begin
                         SysMessageBox('Nr ='+intToStr(nr)+    '; id ='+intToStr(aluno.id)+'; Aluno ='+aluno.nome
                                      ,'Test_FileStream_sem_header'
                                      ,false);

                       end else break;
                     end;
                   end;
                 end;
               end; //with

               with FileStream_Alunos do
                 if status <> StOk
                 then SysMessageBox(ErrorMessage(ErrorInfo),'Test_FileStream_sem_header',true);

             finally
               FileStream_Alunos.Destroy;
             end;
            end;

          ```
    }
    TFileStream =
    Class (TStream)

        protected _ShareModeAnt : CARDINAL;

        Public Handle : THandle; //:< DOS file handle
      //Protected

        Protected procedure SetShareMode(Const a_ShareMode:CARDINAL);override;

        Protected procedure SetFileName(a_FileName: AnsiString);Override;
//        Protected function GetFileName: AnsiString;override;

      //Public
        Public CONSTRUCTOR Create(aFName: AnsiString; aFileMode: Word;aShareMode:Cardinal);overload; virtual;
        public CONSTRUCTOR Create(aFName: AnsiString; aFileMode: Word); overload; virtual;
        public CONSTRUCTOR Create(aFileName: AnsiString; aFileMode: Word;Size: Sw_Word;a_BaseSize,a_RecSize:Longint);overload; virtual;

        Public Function GetDriveType:TDriveType;Override;

        Public DESTRUCTOR Destroy;                                            Override;

        Public PROCEDURE Truncate;Overload ;                                  Override;


        Public procedure Seek(NR: LongInt;a_RecSize:Longint);Overload; override;
        Public PROCEDURE Open;overload;                              Override;
        Public PROCEDURE Open (aFileMode: Word;aShareMode:Cardinal);Overload;Virtual;

        Public PROCEDURE Close;Override;

        Public PROCEDURE Reset; Overload;    Override ;
        Public PROCEDURE Reset(aFileMode: Word;aShareMode : Cardinal); Overload;override;

        Public PROCEDURE Rewrite;Overload;Override;
        Public procedure Rewrite(aFileMode: Word;aShareMode : Cardinal);Overload;Override;

        Public PROCEDURE Read (Var Buf; Count: Sw_Word);         Overload;    Override;
        Public PROCEDURE Write(Var Buf; Count: Sw_Word);        Overload;    Override;



        Public FUNCTION GetSize: LongInt; Override;

        {: - O método @name é usado para obrigar o windows a descarregar
                o buffer do arquivo.

              - **NOTA**
                - O linux não tem a função dulicateHandle.
           }
        Public Function CloseOpen:Integer; Override;
        Public Function Flush_Disk:Integer;   Override;
        Public PROCEDURE Flush;                                               Override;
        Public Function IsFileOpen:Boolean;Override;

        //Public Function  FLock(Const wNrLockInit,w_LockLength: Longint ):_TRecLock;Override;

        Public Procedure DeleteFile;

        Public function CreateFileStream(aFName: AnsiString; aFileMode: Word) : TFileStream;Virtual;

        Public function SaveToFile(aFileName:AnsiString):Boolean;Overload;Virtual;
        Public function SaveToFile:Boolean;Overload;Virtual;
        Public function LoadFromFile(aFileName:AnsiString):Boolean;Overload;virtual;

        //published Property ShareMode : CARDINAL Read _ShareMode write SetShareMode;

        

      END;




implementation

{+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++}
{$Region '               TFileStream Class METHODS                         ' }
{+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++}

  Function TFileStream.GetDriveType:TDriveType;
  Begin
    Result := GetDriveType(FileName);
  end;


  Const
    ok_SetShareMode : Boolean = false;
  Procedure TFileStream.SetShareMode(Const a_ShareMode:Cardinal);
    Var
      WStatus ,WErrorInfo : Integer;
  Begin
    _ShareModeAnt := ShareMode;
    inherited SetShareMode(a_ShareMode);
    If Handle  <>  HANDLE_INVALID
    Then
    Begin
      //Abre o arquivo com o novo atributo
      Close;
      Open;
      If Status <> StOk
      Then
      Begin
        wStatus    := Status;
        WErrorInfo := ErrorInfo;
        ShareMode     := _ShareModeAnt;

        Open;
        If Status = StOk
        Then
        Begin
          Status    := wStatus;
          ErrorInfo := wErrorInfo;
        End;
      end;
    end;
  end;


  Procedure TFileStream.SetFileName(a_FileName: AnsiString);
  Begin
    ErrorInfo := 0;
    Status    := 0;

    If Handle  <>  HANDLE_INVALID
    Then Close;

    _FileName := ExpandFileName(LowerCase(ExtractFileName(a_FileName)));
     Handle   := HANDLE_INVALID;
  end;



  CONSTRUCTOR TFileStream.Create(aFName: AnsiString;
                                 aFileMode: Word;
                                 aShareMode:Cardinal);overload;
  BEGIN
    Handle   := HANDLE_INVALID;
    Inherited Create;

    FileName := ExpandFileName(LowerCase(ExtractFileName(aFName)));

    if (not FileExists(FileName)) and (aShareMode or StCreate <> 0)
    then
    begin
      if FileCreate(FileName,aFileMode,aShareMode, Handle) = 0
      then FileClose(handle);
    end;

    Handle   := HANDLE_INVALID;

    FileMode  := aFileMode;
    ShareMode := aShareMode;

    If FileName <> ''
    Then Reset()
    else Error(stCreateError,ParametroInvalido);

    if status = StOk
    Then RecSize := 1;

  END;

  CONSTRUCTOR TFileStream.Create(aFName: AnsiString; aFileMode: Word);overload;
  Begin
    Create (aFName,aFileMode,ShareMode); // obs: O flag FILE_FLAG_RANDOM_ACCESS só encontrei no windows
  end;

  CONSTRUCTOR TFileStream.Create(aFileName: AnsiString; aFileMode: Word;Size: Sw_Word;a_BaseSize,a_RecSize:Longint);overload;
  Begin
    Create (aFileName,aFileMode,Size);
//    Flags := Flags or FILE_FLAG_RANDOM_ACCESS;
    //Alias := 'TFile.Create('+aFileName+ ')';
    BaseSize := a_BaseSize;
    RecSize  := a_RecSize;
  end;

  DESTRUCTOR TFileStream.Destroy;
  BEGIN
    If (Handle  <>  HANDLE_INVALID) Then
    Begin
      Flush;
      FileClose(Handle);          { Close the file }
    End;

    State := 0;
    Inherited Destroy;                                    { Call ancestor }
  END;

  PROCEDURE TFileStream.Close;
  BEGIN
    If (Handle  <>  HANDLE_INVALID) Then
    Begin
      Flush;
      FileClose(Handle);          { Close the file }
    End;
    Position       := 0;                                    { Zero the position }
    Handle         := HANDLE_INVALID;                       { Handle now invalid }
    Status_Rewrite := 0;
    Status         := 0;
  END;

  PROCEDURE TFileStream.Truncate;
  VAR Success: Integer;
  BEGIN
     If (Status = stOk) Then
     Begin                      { Check status okay }
       If Last_Mode = En_Last_Mode_Write
       Then flush;

       Success := FileTruncate(Handle, Position);     { Truncate file }
       If (Success = 0) Then StreamSize := Position  { Adjust size }
       Else Error(stError, Success);                 { Identify error }
     End;
    TaStatus  := ErrorInfo;
  END;

  procedure TFileStream.Seek(NR: LongInt;a_RecSize:Longint);
    VAR
      Success: Integer; Li: Int64;
  BEGIN
    If (Status = stOk) and (Handle <> HANDLE_INVALID) Then
    Begin
      If Last_Mode = En_Last_Mode_Write
      Then flush;

      // Check status okay
      Position  := Calc_Pos(NR,a_RecSize);
      If (Position  < 0)
      Then Position  := 0;  // Negatives removed

      Success := FileSeek(Handle,Position ,fsFromBeginning, Li); // Set file position

      If ((Success <> 0) OR (Li <> Position )) Then
      Begin    { We have an error }
        If (Success <>0)
        Then Error(stSeekError,Success)                        { General seek error }
        Else Error(stSeekError,Seek_fora_da_faixa_do_arquivo); { Specific seek error }
      End
      Else Position := Li;                                     { Adjust position }

      If (Status <> 0) and (ErrorInfo in [AcessoNegado5,AcessoNegado32,ErroViolacaoDeLacre]) and
        (FileMode AND FmWait <>0) Then
      Begin
        If Ok_Aguarde Then
        Begin
          CtrlSleep(0);
          Error(stOk,0);
          Seek(Position);
        end;
      end
      Else If Ok_Aguarde Then Ok_Aguarde := False;
    End
    else ErrorInfo := ErroArquivoFechado;

    TaStatus  := ErrorInfo;
  END;

  PROCEDURE TFileStream.Open;
     Var Success: Integer;
  BEGIN
    If (Handle  =  HANDLE_INVALID)
    Then Begin
            Status         := 0;
            ErrorInfo      := 0;
            Success := FileOpen(FileName,FileMode,ShareMode,Handle);
            Position := 0; // Reset position

            If (Success <>0)
            Then Begin                       { File open failed }
                   Handle := HANDLE_INVALID; { Reset handle }
                   Error(stOpenError,Success {ErroArquivoFechado});
                 End;

            If (Status <> 0) and (ErrorInfo in [AcessoNegado5,AcessoNegado32,ErroViolacaoDeLacre])
               and (Handle  =  HANDLE_INVALID) and (FileMode AND FmWait <>0)
            Then Begin
                   If Ok_Aguarde
                   Then Begin
                          CtrlSleep(0);
                          Error(stOk,0);
                          Open;
                        end;
                 end
            Else If Ok_Aguarde Then Ok_Aguarde := False;

            if (Status = 0) Then GetSize;
         End;
     TaStatus  := ErrorInfo;
  END;

  PROCEDURE TFileStream.Open (aFileMode: Word;aShareMode:Cardinal);Overload;
  begin
    FileMode := aFileMode;
    ShareMode := aShareMode;
    open();
  end;

  { File not open }
  PROCEDURE TFileStream.Reset;
   Var Success: Integer;
  Begin
    If (Handle = HANDLE_INVALID)
    Then Begin
            Status         := 0;
            ErrorInfo      := 0;

            //O Modo StCreate cria o arquivo se não existir e abre o arquivo para leitura e escrita
            If (Not FileExists(FileName)) and ((ShareMode and  stCreate) <> 0)
            Then Begin
                   Rewrite;
                   If Status<>0
                   Then Success := ErrorInfo
                   else Success := 0;
                 End
            Else Status_Rewrite := 0;

            If ((FileMode and  (stOpen or stOpenRead or stOpenWrite)) <> 0)  And  (Handle  =  HANDLE_INVALID)
            Then Begin
                    Open;
                    If Status<>0
                    Then Success := ErrorInfo
                    else Success := 0;
                  end;

             If (Handle  =  HANDLE_INVALID) and (Success=0)
             Then Success := ErroArquivoFechado;{ Arquivo fechado}

             If (Handle  <> HANDLE_INVALID) and (Success = 0)
             Then Success := FileSeek(Handle,0{Distance},fsFromBeginning{ Method},Position{var Actual: Longint});{ Reset to file start }

             If (Handle = HANDLE_INVALID) or (Success <> 0)
             Then Error(stCreateError, Success);  { Call stream error }

             If (Status <> 0) and
                (ErrorInfo in [ArquivoNaoEncontrado2,ArquivoNaoEncontrado18]) and
                (Handle = HANDLE_INVALID) and
                (ShareMode AND FmWait <>0) and
                ((ShareMode and  stCreate) <> 0)
             Then Begin  {Obs: Se o modo StCreate estiver habilitado entao obrigatoriamente ele abre o arquivo ou cria independente do tempo }
                     If Not Ok_Aguarde
                     Then ClockBegin := GetDosTicks;

                     Ok_Aguarde := (GetDosTicks - ClockBegin <= Round(TempoDeTentativas*1000));
                     If Ok_Aguarde
                     Then Begin
                            CtrlSleep(0);
                            Error(stOk,0);
                            Reset;
                          end;
                  end
             Else If Ok_Aguarde Then Ok_Aguarde := False;

             if (Status = 0) Then GetSize;
         End;
    TaStatus  := ErrorInfo;
  end;

  PROCEDURE TFileStream.Reset(aFileMode: Word;aShareMode : Cardinal);
  Begin
    FileMode := aFileMode;
    ShareMode := aShareMode;
    Reset();
  end;

  PROCEDURE TFileStream.Rewrite;
    VAR
      Success: Integer;
  Begin
     Status         := 0;
     ErrorInfo      := 0;
     Status_Rewrite := 0;
     If (Handle = HANDLE_INVALID)
     Then Begin
            If Not FileExists(FileName)
            Then Begin
                   Success := FileCreate(FileName, FileMode,ShareMode,Handle);  { Create the file }
                   If (success = 0) and (Handle <> HANDLE_INVALID)
                   Then Begin
                          Status_Rewrite := 1;
                        End;
                 end
            Else Success := Arquivo_ja_existe; {O Arquivo ja Existe}
            Position := 0;                                 { Reset position }

            If (Success <>0) and (Success <> ErroArquivoFechadoParaEntrada)
            Then Begin                    { File open failed }
                   Handle := HANDLE_INVALID;                                { Reset handle }
                   Error(stOpenError,Success { ErroArquivoFechado});           { Call stream error }
                 End;

          End
    else ErrorInfo := 103; //'103: Arquivo fechado';
    TaStatus := ErrorInfo ;
  end;

  procedure TFileStream.Rewrite(aFileMode: Word;aShareMode : Cardinal);
  begin
    FileMode  := aFileMode;
    ShareMode := aShareMode;

    Rewrite();
  end;

  PROCEDURE TFileStream.Read (Var Buf; Count: Sw_Word);
     VAR Success: Integer;
         W,
         BytesMoved: int64;

        //P: PByteArray;
         p : PArrayAnsiChar;
  BEGIN
     If Last_Mode = En_Last_Mode_Write Then Flush;

     If (Status = Stok) And (Handle<>HANDLE_INVALID)
     Then Begin
            Last_Mode := En_Last_Mode_Read;

             If (Position + Count > StreamSize) Then            // Insufficient data
             begin
               Error(stReadError,ErroDeLeituraEmDisco);         //Read beyond end!!!
               exit;
             end;

             If (Handle = HANDLE_INVALID)
             Then begin
                    Error(stReadError, ErroArquivoFechado);     // File not open
                    exit;
                  end;

             P := @Buf;                                         // Transfer address
             While (Count > 0) AND (Status = stOk) Do Begin     // Check status & count
               W := Count;                                      // Transfer read size

               Success := FileRead(Handle, P^, W, BytesMoved); // Read from file

               If ((Success <> 0) OR (BytesMoved <> W))         // Error was detected
               Then Begin
                      BytesMoved := 0;                          // Clear bytes moved
                      If (Success <> 0)
                      Then Error(stReadError, Success)               // Specific read error
                      Else Error(stReadError, ErroDeLeituraEmDisco); // Non specific error
                    End;

               Inc(Position, BytesMoved);                       // Adjust position

//               P := Pointer(Longword(P) + BytesMoved);        // Adjust buffer ptr
               P := P + BytesMoved;



               Dec(Count, BytesMoved);                          // Adjust count left }
             End;

             If (Count <> 0) Then FillChar(P^, Count, #0);      // Error clear buffer

             If (Status <> 0) and (ErrorInfo in [AcessoNegado5,AcessoNegado32,ErroViolacaoDeLacre])
                and (Handle <> HANDLE_INVALID) and (FileMode AND FmWait <>0)
             Then Begin
                    If Ok_Aguarde
                    Then Begin
                           CtrlSleep(0);
                           Error(stOk,0);
                           Read (Buf, Count);
                         end;
                  end
             Else If Ok_Aguarde Then Ok_Aguarde := False;
          End;
    TaStatus  := ErrorInfo;
  END;

  PROCEDURE TFileStream.Write (Var Buf; Count: Sw_Word);
  VAR Success: Integer;
      W, BytesMoved: int64;
      //P: PByteArray;
      p : PArrayAnsiChar;
  BEGIN
     If (Handle = HANDLE_INVALID) Then Error(stWriteError, ErroArquivoFechado);    { File not open }

     If (Status = Stok) And (Handle<>HANDLE_INVALID)
     Then Begin
            Last_Mode := En_Last_Mode_Write;  { Now set write mode }

            P := @Buf;                                         { Transfer address }
            While (Count > 0) AND (Status = stOk) Do
            Begin     { Check status & count }
              W := Count;                                      { Transfer read size }

          //     {$IFNDEF OS_OS2}                                 { DOS/DPMI/WIN/NT }
          //     If (Count > $FFFF) Then W := $FFFF;              { Cant read >64K bytes }
          //     {$ENDIF}

              Success := FileWrite(Handle, P^, W, BytesMoved); { Write to file }

              If ((Success <> 0) OR (BytesMoved <> W))         { Error was detected }
              Then Begin
                      BytesMoved := 0;                               { Clear bytes moved }
                      If (Success <> 0)
                      Then Error(stWriteError, Success)                 { Specific write error }
                      Else Error(stWriteError, ErroDeGravacaoEmDisco);  { Non specific error }
                   End;

              Inc(Position, BytesMoved);                       { Adjust position }
//              P := Pointer(Longword(P) + BytesMoved);           { Transfer address }
              P := P + BytesMoved;           { Transfer address }

              Dec(Count, BytesMoved);                          { Adjust count left }
              If (Position > StreamSize)                       { File expanded }
              Then StreamSize := Position;                     { Adjust stream size }
            End;

            If (Status <> 0) and (ErrorInfo in [AcessoNegado5,AcessoNegado32,ErroViolacaoDeLacre])
            and (Handle <> HANDLE_INVALID) and (FileMode AND FmWait <>0)
            Then Begin
                   If Ok_Aguarde
                   Then Begin
                          CtrlSleep(0);
                          Error(stOk,0);
                          Write(Buf, Count)
                        end;
                 end
            Else If Ok_Aguarde Then Ok_Aguarde := False;
          END;
    TaStatus  := ErrorInfo;
  END;


  FUNCTION TFileStream.GetSize: LongInt;

  Begin

    If (Handle = HANDLE_INVALID) Then Error(stReadError, ErroArquivoFechado);    { File not open }
    If Status = StOk
    Then Begin
           If Last_Mode = En_Last_Mode_Write
           Then flush;

           //Success := SysFileSize(Handle,Cardinal(StreamSize));
           // If Success<>0 Then Error(stReadError,Success);

           result := TFiles.FileSize(FileName);
           if ok
           then begin
                  StreamSize := result;
                  status := stok

                end
           else status := stError ;

         end;

    If Status = StOk
    Then Result := Inherited GetSize
    Else Result := 0;

    If (Status <> 0) and (ErrorInfo in [AcessoNegado5,AcessoNegado32,ErroViolacaoDeLacre])
       and (Handle <> HANDLE_INVALID) and (FileMode AND FmWait <>0)
    Then Begin
           If Ok_Aguarde
           Then Begin
                  CtrlSleep(0);
                  Error(stOk,0);
                  Result := GetSize;
                end;
         end
    Else If Ok_Aguarde Then Ok_Aguarde := False;
    TaStatus  := ErrorInfo;
  end;

  Function TFileStream.CloseOpen:Integer;
    Var
      HandleCopy : THandle;
  BEGIN
    If (Handle = HANDLE_INVALID)
    Then Error(stWriteError,ErroArquivoFechado);    { File not open }

    If (status = StOK)
    Then Begin
            Result := DuplicateHandle(Handle,HandleCopy);
            If Result = 0
            Then Result := FileClose(HandleCopy)
            else Result := 0;
         End
    Else Result := ErrorInfo;
    TaStatus  := ErrorInfo;
  END;

  Function TFileStream.Flush_Disk:Integer;
  Begin
    If (Handle = HANDLE_INVALID)
    Then Error(stWriteError,ErroArquivoFechado);    { File not open }

    If (StOK = 0) and (Last_Mode = En_Last_Mode_Write)
    Then Begin
           If FlushBuffer_Disk
           Then BEGIN
                  Result := FileFlushBuffers(Handle);
                END
           else Result := 0;

           If Result=0
           Then RESULT := CloseOpen;

           If Result<> 0
           Then Error(stWriteError,Result);    { File not open }
         End
    Else Result := ErrorInfo;
    TaStatus  := ErrorInfo;
  end;

  PROCEDURE TFileStream.Flush;

  BEGIN                                                 { Abstract method }
    If (Status = StOk) and (Handle<>HANDLE_INVALID)
    Then Begin
           If (Last_Mode = En_Last_Mode_Write)
           Then Begin
                  Flush_Disk;
                  Last_Mode := En_Last_Mode_Flush;
                  If (Status <> 0) and
                     (ErrorInfo in [AcessoNegado5,AcessoNegado32,ErroViolacaoDeLacre])
                     and (Handle <> HANDLE_INVALID) and (FileMode AND FmWait <>0)
                  Then Begin
                         If Ok_Aguarde
                         Then Begin
                                CtrlSleep(0);
                                Error(stOk,0);
                                Flush;
                              end;
                       end
                  Else If Ok_Aguarde Then Ok_Aguarde := False;
                End
           Else Last_Mode := En_Last_Mode_Flush;
         End;
    TaStatus  := ErrorInfo;
  END;

  Function TFileStream.IsFileOpen:Boolean;
  Begin
    Result := Handle <> HANDLE_INVALID;
  end;

  Procedure TFileStream.DeleteFile;
  Begin
    ErrorInfo := 0;
    if Self.IsFileOpen
    Then Self.close;

    If SysUtils.DeleteFile(FileName)
    Then Status := StOk
    Else Begin
           Status := StError;

           if SysUtils.FileExists(FileName)
           then ErrorInfo := AcessoNegado5
           else ErrorInfo := ArquivoNaoEncontrado2;
         End;
    TaStatus  := ErrorInfo;
  End;

{$EndRegion 'Implementação da TFileStream'                                   }
{----------------------------------------------------------------------------}

function TFileStream.CreateFileStream(aFName: AnsiString; aFileMode: Word) : TFileStream;
Begin
  Result := TFileStream.Create(aFName, aFileMode);
end;

function TFileStream.SaveToFile(aFileName:AnsiString):Boolean;

  procedure _SaveToFile;
    Var
      FileDest  : TFileStream;
      Nr        : Longint;
      _BaseDest,
      _RecDest  : Pointer;
  Begin
    Try
      _BaseDest := nil;
      _RecDest  := nil;

      FileDest := CreateFileStream('',FmWriteOnly or FmDenyALL or FmCreate);
      If aFileName = ''
      Then Begin
              Error(stCreateError,ParametroInvalido);
              exit;
           End;

      FileDest.FileName := aFileName;
      FileDest.Rewrite();

      If FileDest.Status <> 0 Then Exit;

      FileDest.Set_BaseSize(_BaseDest,BaseSize);  {Seta a Ponteiro da base do arquivo F com o ponteiro da base de Self}
      If FileDest.Status <> 0 Then Exit;

      FileDest.Set_RecSize(_RecDest,RecSize);     {Seta a Ponteiro do registro do arquivo F com o ponteiro do registro de Self}
      If FileDest.Status <> 0
      Then Exit;

      GetRecBase;                    {Ler a base de Self}
      If Status <> 0 Then exit;

//      Move a base de Self para a base de FileDest
      Move(_Base^,FileDest._Base^,BaseSize);
      FileDest.PutRecBase;                  {Grava a base de Self em F}
      If FileDest.Status <> 0 Then exit;

      Create_Progress1Passo('Salvando arquivo...',aFileName,FileSize-1);


      For Nr := 1 to FileSize-1 do
      Begin
           Set_Progress1Passo(Nr);
           GetRec(nr);
           If Status <> 0 Then exit;

//           Move a base de Self para a base de FileDest
            Move(_Rec^,FileDest._Rec^,RecSize);

           FileDest.PutRec(Nr);
          If FileDest.Status <> 0 Then exit;
      end;

    Finally
//      FreeMem(Block,RecSize*4096);

      If FileDest.Status <> 0
      Then Error(FileDest.Status,FileDest.ErrorInfo);

      FileDest.Free;

      Destroy_Progress1Passo;
    end;

  end;


Begin

  Error(stOk,0);
  Try
    If Not DirectoryExists(ExtractFilePath(aFileName))
    Then Begin
           If Not CreateDir(ExtractFilePath(aFileName))
           Then Error(stCreateError,ParametroInvalido);
         End;

    If Status = StOk
    Then Begin
            If GetDriveType = dt_Memory_Stream
            Then _SaveToFile
            Else Begin
                    AFileName := ExpandFileName(LowerCase(ExtractFileName(aFileName)));
                    If FileName = AFileName
                    Then Begin
                           Error(stError,ParametroInvalido);
                           exit;
                         End;
                    ErrorInfo := CopyFile(FileName,aFileName,false);
                    If ErrorInfo <> 0
                    Then Error(StError,ErrorInfo);

                 End;
         End;
  Finally
    Result := ErrorInfo=0;
  end;
end;

function TFileStream.SaveToFile:Boolean;
Begin
  If (FileName <> '')
  Then Result := SaveToFile(FileName)
  Else Begin
         Error(stCreateError,ParametroInvalido);
         Result := false;
       End
end;

function TFileStream.LoadFromFile(aFileName:AnsiString):Boolean;
  Var
    F  : TFileStream;
    Nr : Longint;
Begin
  Try
    Try

      F := TFileStream.Create('',stOpen or FmDenyNone);

      If aFileName = ''
      Then Begin
              Error(stOpenError,ParametroInvalido);
              exit;
           End;

      F.FileName := aFileName;
      F.Reset;
      If F.Status <> 0 Then Exit;

      F.Set_BaseSize(_Base,BaseSize);  {Seta a Ponteiro da base do arquivo F com o ponteiro da base de Self}
      If F.Status <> 0 Then Exit;

      F.Set_RecSize(_Rec,RecSize);     {Seta a Ponteiro do registro do arquivo F com o ponteiro do registro de Self}
      If F.Status <> 0 Then Exit;

      F.GetRecBase;                    {Ler a base de aFileName}
      If F.Status <> 0 Then exit;

      PutRecBase;                      {Grava a base de Self em Self}
      If Status <> 0 Then exit;

      Create_Progress1Passo('Carregando arquivo...',aFileName,FileSize-1);
      For Nr := 1 to F.FileSize-1 do
      Begin
         Set_Progress1Passo(Nr);
         F.GetRec(nr);             {Ler o Rec de aFileName}
         If F.Status <> 0 Then exit;

         PutRec(Nr);               {Grava o Rec em Self}
         If Status <> 0 Then exit;
      end;

    Finally
      If F.Status <> 0
      Then Error(F.Status,F.ErrorInfo);

      If Status <> 0
      Then Result := False
      Else Result := True;
      F.Free;

      Destroy_Progress1Passo;
    end;

 Except
   Result := False;
 end;
end;





end.

