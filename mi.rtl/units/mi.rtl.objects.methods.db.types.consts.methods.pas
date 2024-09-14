unit mi.rtl.objects.Methods.db.types.consts.Methods;
  {:< - A unit **@name** implementa a classe **TDb_Methods** do pacote **mi.rtl.db**.

    - **NOTAS**
      -

    - **VERSÃO**
      - Alpha - 1.0.0

    - **HISTÓRICO**
      - Criado por: Paulo Sérgio da Silva Pacheco e-mail: paulosspacheco@@yahoo.com.br
        - **01/12/2021**
          - 10:15 a ?? : Criar a unit mi.rtl.db_Methods.pas


    - **CÓDIGO FONTE**:
      - @html(<a href="../units/mi.rtl.db.Methods.pas">mi.rtl.db.Methods.pas</a>)

  }
  {$IFDEF FPC}
    {$MODE Delphi} {$H+}
  {$ENDIF}


interface

uses
  Classes, SysUtils
  ,mi.rtl.objects.Methods.db.types.consts
  ,mi.rtl.objects.methods.StreamBase.Stream

  ,mi.rtl.objects.TException
  ;



  {: - A classe **@name** implementa os método de classe comum a todas as classes de TDB do pacote **mi.rtl.db**.}
  type
  TDb_Methods =
  class(TDbConsts)
    public constructor Create(aowner:TComponent);Overload;Override;
    public destructor Destroy; override;
    public function FExisteCodigo (Var IxF:IndexFile; Const codigo:tString):Boolean;//inline;
    public procedure CreateTAccess;
    public procedure DestroyTAccess;


    public function EscrevaTurboError(DatF   : DataFile;Const NR     : Longint;Error:SmallWord):Boolean;
    public function TAIOCheck(VAR DatF : DataFile;Const R : LONGINT):Boolean; //inline;

    public function SincronizaPosChave(Var datFIx:IndexFile;Const NrCurrent:Longint; KeyCurrent : TaKeyStr):Boolean;//inline;

    public function GetRec(var DatF : DataFile;Const R : Longint;var Buffer ):Boolean;//inline;

    public function GetRecBlock(VAR DatF   : DataFile; Const R : LONGINT; delta:Word;Var BlocksRead:Word ;VAR Buffer  ):Boolean;//inline;

    public function _PutRec(var DatF : DataFile;Const R : Longint;var Buffer;Const Transaction_Current : T_TTransaction):Boolean;

    public function PutRec(var DatF : DataFile;Const R : Longint;var Buffer  ):Boolean;//inline;



    public function MakeFile(var DatF : DataFile;Const FName : TFileName;Const RecLen : SmallWord):Integer;

    public function FMakeFile(Const FileName:PathStr;Const TamArq:Longint):Integer;

    public function AtualizaDestino(Var RegFonte;   Const TamFonte:SmallWord;
                             var RegDestino; Const TamDestino : SmallWord) : BOOLEAN;

    public function FDelStrBrancos(S:tString):tString;


    public function FileNameTemp_Ext(const aPath:PathStr;Var NomeArqTemp : PathStr;Extencao : PathStr):Boolean;overload; { Cria arquivo temporário }
    public function FileNameTemp_Ext(Var NomeArqTemp : PathStr;Extencao : PathStr):Boolean;Overload;

    public function FileNameTemp    (Extencao : PathStr):PathStr;//inline; { Cria arquivo temporário }

    public function FileName_Seq(Const aName:PathStr;Const aExt : PathStr):PathStr;//inline;
    public function IsPortLocal(WPort: tString):Boolean;   //inline;
    public function DelFile( Const Nome : TFileName):Boolean;//inline;
    public function SetOkAddRecFirstFree(Const aOkAddRecFirstFree: Boolean):Boolean;//inline;

    public function TestaSePodeAbrirArquivo(Const FName  : PathStr): Byte;//inline;
    public function FileShared(Const FName  : PathStr) : Boolean;

    public function FTrocaExtencao(Const NomeArq:TFileName; Extencao:PathStr) : PathStr;//inline;
    public function Ren(NomeFonte,NomeDestino: PathStr) : Boolean; //inline;

    /// <since>
    ///   . OkItemSize
    ///   . Retorna true se o Tamanho do registro em arquivo > tamanho do buffer do registro em Memória.
    /// </since>
    public function OkRecSizeMismatch(Const FName  : TFileName;Const RecLenBufferRecord : SmallWord):Boolean;//inline;

    public function ModifyStructurFile(Const FName:TFileName;Const RecLenDest : SmallWord ):Boolean;//inline;

    public function OpenFile(var DatF:DataFile;
                      Const FName : TFileName;
                      Const RecLen:SmallWord;
                      AFileMode:Word ):Integer;//inline;

    public function ReadHeader(VAR DatF   : DataFile):Boolean;//inline;
    public function PutFileHeader(VAR DatF : DataFile):Boolean;  //inline;
    public function NaoMuDOuHeader(VAR DatF : DataFile) : BOOLEAN;//inline;
    public function MudouHeaderEmMemoria(VAR DatF : DataFile) : BOOLEAN;//inline;

    public function aCloseFile(VAR DatF : DataFile):boolean;
    public function CloseFile(VAR DatF : DataFile):boolean;Overload;
    public function CloseFile(VAR DatF : DataFile;OkCondicional:Boolean):boolean;Overload;

    public function FlushFile(VAR DatF : DataFile):Boolean;//inline;
    public function TraveRegistro(VAR  DatF : DataFile; Const R : LONGINT):Boolean;//inline;
    public function DestraveRegistro(Var  DatF : DataFile;Const R : Longint):Boolean;//inline;
    public function TraveHeader(VAR DatF : DataFile):Boolean;//inline;
    public function DestraveHeader(VAR DatF : DataFile):Boolean;//inline;

    public function FileSize(VAR DatF : DataFile):Longint;Overload;//inline;

    public procedure NewRec(VAR DatF  : DataFile;VAR R     : LONGINT  );//inline;
    public function AddRec(var DatF : DataFile;var R  : Longint;var Buffer ):Boolean;//inline;
    public function DeleteRecord(VAR DatF : DataFile; Const R : LONGINT; Var Buffer ):Boolean;//inline;
    public function DeleteRec(var DatF : DataFile;Const R: Longint):Boolean;//inline;

    public function FileLen(VAR DatF : DataFile) : LONGINT;//inline;

    public function UsedRecs(VAR DatF : DataFile) : LONGINT; Overload;//inline;
    public function UsedRecs(VAR DatF : DataFile;OK_GetHeader : Boolean) : LONGINT;Overload;//inline;

    public function UsedRecs(Var IxF  :IndexFile;OK_GetHeaderDoIndice : Boolean) : LONGINT;Overload; //inline;
    public function UsedRecs(Var IxF  :IndexFile) : LONGINT;Overload;//inline;

    public function UsedRecs(Const FileName:PathStr) : Longint;Overload;//inline;


    public procedure TaPack(VAR Page : TaPage;Const KeyL : BYTE);
    public procedure TaUnpack(VAR Page : TaPage; Const     KeyL : BYTE);

    public function Multiplo_Mais_proximo_de_N(Const K,N:Longint): Longint;//inline;

    public function MakeIndex(var IxF : IndexFile;Const FName : TFileName;Const KeyLen,S : byte):Integer;


    public function FMakeIndex(Const FileName:PathStr;Const RepeteChave,TamChave:Byte):Integer;


    public procedure LeiaHeaderDoIndice( VAR IxF       : IndexFile);//inline;

    public function aCloseIndex(VAR IxF : IndexFile):Boolean;//inline;

    public function CloseIndex(VAR IxF : IndexFile;OkCondicional:Boolean):boolean;Overload;
    public function CloseIndex(VAR IxF : IndexFile):boolean;Overload;//inline;


    public function FlushIndex(VAR IxF       : IndexFile):boolean;//inline;

    public function EraseFile(VAR DatF : DataFile):boolean;//inline;
    public function EraseIndex(VAR IxF : IndexFile):boolean;//inline;
    public function TaGetPage(VAR IxF  : IndexFile;Const R     : LONGINT;VAR PgPtr : TaPagePtr):boolean;////inline;
    public procedure TaNewPage(VAR IxF  : IndexFile; VAR R     : LONGINT; VAR PgPtr : TaPagePtr);//inline;

    public procedure TaDeletePage(var IxF : IndexFile; VAR R     : LONGINT; VAR PgPtr : TaPagePtr);//inline;

    public procedure ClearKey(VAR IxF : IndexFile);//inline;
    public function NextKey(VAR IxF : IndexFile; VAR DataRecNum : LONGINT; VAR ProcKey ):Boolean;//inline;
    public function PrevKey(var IxF : IndexFile; var DataRecNum : Longint; var ProcKey ):Boolean;//inline;
    public procedure TaXKey(VAR K:TaKeyStr; Const KeyL : BYTE);
    public function TaCompKeys(Const K1 ,K2; DR1,DR2 : LONGINT; Const Dup : BOOLEAN ) : Shortint;//inline;

    public function TaFindKey(VAR IxF       : IndexFile;VAR DataRecNum : LONGINT;VAR ProcKey ):boolean;////inline;

    public function FindKey(var IxF : IndexFile;var DataRecNum : Longint;var ProcKey ):Boolean;//inline;
    public function FindKeyTop(var IxF : IndexFile;var DataRecNum : Longint;var ProcKey ):Boolean;//inline;

    public function SearchKey(var IxF : IndexFile; var DataRecNum : Longint; var ProcKey:TaKeyStr):Boolean;
    public function SearchKeyTop(var IxF : IndexFile; var DataRecNum : Longint; var ProcKey:TaKeyStr;Const Okequal : Boolean):Boolean;


    public procedure TaUpdatePage(VAR IxF  : IndexFile;
                           VAR R     : LONGINT;
                           VAR PgPtr : TaPagePtr;
                           Const Transaction_Current : T_TTransaction);//inline;

    //=====================================================================================================
    {$Region 'Local> Rotinas locais de AddKey publicadas para implementação de Inline <Local'}
    //=====================================================================================================

      public procedure AddKey_Search_Insert(
                        var IxF : IndexFile;
                        Var PrPgRef1 : LONGINT;
                        VAR PrPgRef2,c : LONGINT;

                        VAR PagePtr1,PagePtr2  : TaPagePtr;
                        VAR ProcItem1, ProcItem2 : TaItem;
                        vAR PassUp, okAddKey  : BOOLEAN;
                        Const ProcKey    : TaKeyStr;
                        Const DataRecNum : Longint;
                        VAR K,L     : SmallInt;
                        Var R : SmallInt
                       );//inline;

      public procedure AddKey_Search_Init_ProcItem1(Const ProcKey    : TaKeyStr;
                                             Const DataRecNum : Longint;
                                             vAR PassUp : BOOLEAN; VAR ProcItem1 : TaItem);//inline;

      public procedure AddKey_Search(var IxF : IndexFile;
                       PrPgRef1 : LONGINT;
                       VAR PrPgRef2,c : LONGINT;

                       VAR PagePtr1,PagePtr2  : TaPagePtr;
                       VAR ProcItem1, ProcItem2 : TaItem;
                       vAR PassUp, okAddKey  : BOOLEAN;
                       Const ProcKey    : TaKeyStr;
                       Const DataRecNum : Longint;
                       VAR K,L     : SmallInt
                       );//inline;

      public function AddKey(var IxF : IndexFile; Const DataRecNum : Longint; Const ProcKey    : TaKeyStr):Boolean;//inline;

    //=====================================================================================================
    {$EndRegion 'Local> Rotinas locais de AddKey publicadas para implementação de Inline <Local'}
    //=====================================================================================================

    public function DeleteKey(var IxF : IndexFile;Const DataRecNum : Longint;var ProcKey:TaKeyStr ):Boolean;

    {public function PTaPageStk : TaPageStackPtr;}

    public function FGetHeaderDataFile(Const FileName: PathStr;Var Header : TsImagemHeader;Var aFileSize : Longint):Boolean;//inline;

    public function FTamRegDataFile(Const FileName: PathStr):SmallWord;//inline;

    public function NewFileName(FileName,Extencao:PathStr):PathStr;//inline;

    public function FTb(Const FileName:PathStr):PathStr;//inline;
    public function FObj(Const FileName:PathStr):PathStr;//inline;
    public function FIx(Const FileName:PathStr):PathStr;//inline;
    public function FDup(Const FileName:PathStr):PathStr;//inline;

    public procedure AssignDataFile (Var DatF :DataFile;
                              Const aFileName:PathStr;
                              aBaseSize,
                              aRecSize:SmallWord;
                              Const AFileMode: Word;
                              aF :TStream;
                              WTipo  : AnsiChar {'D = File; I : Index'}
                              );Overload;

    public procedure AssignDataFile (Var DatF :DataFile;Const aFileName:PathStr;aBaseSize,aRecSize:SmallWord);Overload;
    public procedure AssignIndexFile(Var IxF            : IndexFile;
                                     Const aFileName    : PathStr;
                                     aBaseSize,
                                     aRecSize           : SmallWord);Overload;

    public function UpperCase(str:AnsiString):AnsiString;//inline;
    public function Lowcase(str:AnsiString):AnsiString;//inline;

    public function Int2str(Const L : LongInt) : tString;//inline;

    public function spc(Const campo:AnsiString;Const tam :Longint):AnsiString;//inline;


    {public function Set_FileModeDenyALL(Const ModoDoArquivo : Boolean):Boolean;}

    public function SetOkTransaction(Const aOkTransaction : BOOLEAN):BOOLEAN; {Habilita o controle de transações}

    public function StartTransaction(Const aDelta : SmallWord):Integer; Overload;
    public function StartTransaction(Const DatF : DataFile ; Var aok_Set_Transaction : Boolean): Integer;Overload;

    public function COMMIT:Boolean;Overload;
    public function COMMIT(Const Wok_Set_Transaction : Boolean):Boolean;Overload;

    public procedure Rollback;

    public function SetTransaction(const OnOff:Boolean;
                            Var WOK : Boolean // False =
                            ):Boolean;Overload; // Retorna true se sucesso e false se houve fracasso na chamada

    public function SetTransaction(const OnOff:Boolean;
                            Var WOK,
                            { Retorna true se a transacao foi inicializada e false caso contrario
                             usado para executar rollback ou commite se o processo criou a trasacao}
                           Wok_Set_Transaction:Boolean):Boolean;Overload;

    public function GetFileName_Transaction(): tString;
    public function Assign_Transaction(Const aFileName : PathStr):SmallWord;


    public function TransactionPendant_Error:Boolean;
    public function TransactionPendant:Boolean;
    public procedure Truncate(Var DatF: DataFile;NR : LongInt);//inline;{Trunca o arquivo no registro NR}
    public procedure CopyFrom(Font_DatF: DataFile ;Var Dest_DatF: DataFile); Overload;//inline;
    public procedure CopyFrom(Font_IxF : IndexFile ;Var Dest_IxF : IndexFile);Overload;//inline;

    public Function Is_TFileOpen(const a_TFile : TStream):Boolean;
  end;

implementation

 Function TDb_Methods.Is_TFileOpen(const a_TFile : TStream):Boolean;
Begin
  Try
    If Not isValidPtr(a_TFile)
    Then Result := False
    else Result := a_TFile.IsFileOpen;
  Except
    Result := False;
  end;
end;

 procedure TDb_Methods. Truncate(Var DatF: DataFile;NR : LongInt);{Trunca o arquivo no registro NR}
Begin
  If Not Is_TFileOpen(DatF.F)
  Then Begin
         TaStatus := ErroArquivoFechado;
         Abort;
       End;
  DatF.F.Truncate(Nr);
end;

procedure TDb_Methods.CopyFrom(Font_DatF: DataFile ;Var Dest_DatF: DataFile); Overload;
Begin
  Try
    If Not Is_TFileOpen(Dest_DatF.F)
    Then Begin
           TaStatus := ErroArquivoFechado;
           Abort;
         End;

    If Not Is_TFileOpen(Font_DatF.F)
    Then Begin
           TaStatus := ErroArquivoFechado;
           Abort;
         End;

    Dest_DatF.F.CopyFrom(Font_DatF.F);

    If TaStatus = 0
    Then ReadHeader(Dest_DatF);

    If TaStatus <> 0
    Then Abort;

  Except
    If TaStatus = 0
    Then TaStatus := Erro_Excecao_inesperada;

    Raise TException.Create(Self,
                             'CopyFrom',
                             Dest_DatF.FileName,
                             '',
                             TaStatus
                            );
  end;
end;

procedure TDb_Methods.CopyFrom(Font_IxF : IndexFile ;Var Dest_IxF : IndexFile);Overload;
Begin
  CopyFrom(Font_IxF.DataF,Dest_IxF.DataF);
  LeiaHeaderDoIndice(Dest_IxF);

  If TaStatus <> 0
  Then Raise TException.Create(Self,
                            'CopyFrom',
                            Dest_IxF.DataF.FileName,
                            '',
                            TaStatus);
end;



//{$I Tb_Acce2_Inc.pas}  {  Implementation TTransaction}
//{$I Tb_Acce3_Inc.pas}  {  Implementation TFilesOpens}



{I Tb_Acce5.Inc}  {  Implementation DbPageSt}

Function TDb_Methods.SetOkTransaction(Const aOkTransaction: Boolean):Boolean;
Begin
  if aOkTransaction = False Then
  Begin
    If (Not OkCreateTransaction) and (Transaction<>nil) and (not ok_Set_Transaction)
    Then
    Begin
      If Transaction.TransactionPendant=0
      Then Transaction.Rollback
      else Begin
             Transaction.DatF.Close;
             ok := true ;
           end;

      If Not ok
      Then Begin
             SetOkTransaction:= ok;
             exit;
           end;
    End;
  End;

  SetOkTransaction := OkTransaction;
  OkTransaction := aOkTransaction;
End;


FUNCTION TDb_Methods.StartTransaction(Const aDelta : SmallWord):Integer;
  Var
    Wok : Boolean;
Begin
  Wok := ok;

  If OkTransaction and (Transaction<>nil)
  Then StartTransaction := Transaction.StartTransaction(aDelta)
  else StartTransaction := O_gerente_de_transacoes_esta_inativo;

  ok := wok;
End;

Function TDb_Methods.StartTransaction(Const DatF : DataFile ; Var aok_Set_Transaction : Boolean): Integer;
Begin
  aok_Set_Transaction := ok_Set_Transaction;

{  If (Not OkCreateTransaction) and (Transaction<>nil) and (not ok_Set_Transaction)
  Then Begin
         If Transaction.TransactionPendant=0
         Then TaStatus := Transaction.Rollback
         else TaStatus := 0;
         If TaStatus <> 0 Then Abort;
       End; }

  If OkTransaction and (Not OkCreateTransaction)  and  (not ok_Set_Transaction) and (Not DatF.okTemporario) And (Transaction<>nil)
  Then Result := Transaction.StartTransaction(1)
  else Result := 0;
end;

Function TDb_Methods.COMMIT:Boolean;
Begin
  If OkTransaction and (Transaction<>nil)
  Then Result := Transaction.COMMIT
  Else Result := true;
End;

Function TDb_Methods.COMMIT(Const Wok_Set_Transaction : Boolean):Boolean;Overload;
Begin
  If OkTransaction and (Not Wok_Set_Transaction) And ok_Set_Transaction and  (Transaction<>nil)
  Then Begin
         If TaStatus = 0
         Then Result := Transaction.COMMIT
         Else Result := Transaction.Rollback=0;
       end
  Else Result := true;
End;


 procedure TDb_Methods.Rollback;
Begin
  If OkTransaction and (Transaction<>nil) Then
  Begin
    If (ok_Set_Transaction) and (Transaction.DatF.Handle<>-1) Then
      Transaction.Rollback;
{    else Begin
           TaStatus := Objeto_Nao_Inicializado;
           Raise TException.Create(Name_Type_App_MarIcaraiV1,
                                   'Tb_Access.Pas',
                                   'Rollback',
                                   TaSTatus);

         End;}
  End;
End;
{Function ok_Set_Transaction:Boolean;
Begin
  If (Transaction<>nil) Then
    ok_Set_Transaction := Transaction.ok_Set_Transaction
  else
    ok_Set_Transaction := false;
End;}

Function TDb_Methods.SetTransaction(const OnOff:Boolean;
                        Var WOK,
                        { Retorna true se a transacao foi inicializada e false caso contrario
                         usado para executar rollback ou commite se o processo criou a trasacao}
                       Wok_Set_Transaction:Boolean):Boolean;Overload;
{Var
  WWok : Boolean;}
Begin
{  WWok := ok;}  {Salva a variável ok para que ele nao seja trocado com a chamada desta funcao}
  If OnOff
  Then Begin
         If (OkTransaction) and  (Not ok_Set_Transaction)
         Then Begin
                wOK := StartTransaction(1)=0;
                Wok_Set_Transaction := WOK;
              End
         else BEGIN
                Wok_Set_Transaction := False;
                WOK := ok_Set_Transaction or (Not OkTransaction);
              END;
       End
  Else Begin
         If Wok_Set_Transaction
         Then Begin
                If Wok
                Then Wok := Commit
                Else Begin
                       Rollback;
{                       If (NrCurrent = NrCurrentAnt) and (Not AppendIng) And (NrCurrent>0)
                       Then FindKeyAtual;}
                     end;
                MessageError; {Se alguma mensagem de error tiver pendente imprimirar aqui}
              End;

       End;
  Result := wok;
End;

Function TDb_Methods.SetTransaction(const OnOff:Boolean;
                        Var WOK : Boolean // False =
                        ):Boolean; // Retorna true se sucesso e false se houve fracasso na chamada
  Var
    Result_Set_Transaction : Boolean;
Begin
  Result := SetTransaction(OnOff,WOK,Result_Set_Transaction);
End;

Function TDb_Methods.Assign_Transaction(Const aFileName : PathStr):SmallWord;
Begin
  If (Transaction<>nil) Then
    Assign_Transaction := Transaction.AssignFile(aFileName)
  Else
    Assign_Transaction := Objeto_Nao_Inicializado;
End;

Function TDb_Methods.GetFileName_Transaction(): tString;
Begin
  Result := Transaction.DatF.FileName;
end;

Function TDb_Methods.TransactionPendant_Error:Boolean;
Begin
  If (Transaction<>nil)
  Then with Transaction do
       Begin
         If TransactionPendant = 0
         Then Result := DatF.GetSize=0
         Else Result := false;
         Transaction.DatF.Close;
       End
  Else Result := false;
End;

Function TDb_Methods.TransactionPendant:Boolean;
Begin
  If (Transaction<>nil)
  Then Begin
         TransactionPendant := Transaction.TransactionPendant=0;
         Transaction.DatF.Close;
       End
  Else TransactionPendant := False;
End;


Function TDb_Methods.WriteHeaderMakeFile(VAR DatF   : DataFile):boolean;
BEGIN
  WITH DatF DO
  BEGIN
    MOVE(DatF.FirstFree,TaRecBuf^,FileHeaderSize);
    MOVE(DatF.FirstFree,IH.FirstFree,FileHeaderSize);

    Ok := _PutRec(DatF,0,TaRecBuf^,Tra_AddRec);

    DatF.NumRec := 1; {NumRec=1 ao criar o arquivo pela primeira vez}
  END;
  Result := ok;
END; { WriteHeaderMakeFile }


 procedure TDb_Methods.AssignDataFile (Var DatF :DataFile;
                          Const aFileName:PathStr;
                          aBaseSize,
                          aRecSize:SmallWord;
                          Const AFileMode: Word;
                          aF :_TStream;
                          WTipo  : AnsiChar {'D = File; I : Index'}
                          );Overload;
Begin
  {Discard(TObject(DatF.F));} {Se datF Tiver assinalado ele desaloca o arquivo. Somente precaução}
  If Is_TFileOpen(DatF.F)
  Then CloseFile(DatF);

  DatF.FileName          := UpperCase(aFileName);
  DatF.Tipo              := UpCase(WTipo); { D=dados. Indica ao CloseFilesOpens que se trata de um arquivo de dados }
  If Not (DatF.Tipo in ['I','D'])
  THEN DatF.Tipo := 'D';

  If DatF.Tipo = 'I'
  Then aBaseSize := Sizeof(TsImagemHeader);

  DatF.FirstFree         := -1;
  DatF.ItemSize          := aRecSize;

  DatF.OkAddRecFirstFree := OkAddRecFirstFree;
  DatF.FileModeDenyALL       := FileModeDenyALL;
  DatF.NumberKey         := 0;
  DatF.RR                := 0;

  If aF = nil
  Then Begin
         If ((aFileName = '') or ((aFileMode and (FmMemory or FmMemory_Temp))<>0)) or DatF.OkTemporario
         Then Begin
                DatF.F   := TMemoryStream.Create({aFileName,}aBaseSize,aRecSize);
                WriteHeaderMakeFile(DatF);
              End
         Else DatF.F     := TFile.Create('',aFileMode,aRecSize {Multiplo_Mais_proximo_de_N(aRecSize,BlockSize_DatF)*4},{Header} aBaseSize,aRecSize);
       End
  Else DatF.F            := aF;

  DatF.F.FileName        := UpperCase(ExpandFileName(aFileName));

  If DatF.OkTemporario
  Then DatF.F.attribute := FILE_ATTRIBUTE_TEMPORARY;

End;

 procedure TDb_Methods. AssignDataFile(Var DatF :DataFile;Const aFileName:PathStr;aBaseSize,aRecSize:SmallWord;Const AFileMode    : Word);
Begin
  AssignDataFile(DatF,aFileName,aBaseSize,aRecSize, AFileMode,nil,'D');
end;

 procedure TDb_Methods. AssignIndexFile(Var IxF :IndexFile;Const aFileName:PathStr;aBaseSize,aRecSize:SmallWord;Const AFileMode    : Word);
Begin
  AssignDataFile(IxF.DataF,aFileName,aBaseSize,aRecSize,AFileMode,nil,'I');
  IxF.DataF.OkAddRecFirstFree := false;//Não aproveita espaço de registro deletado.
  IxF.PP         := 0;
{  IxF.Tipo       := 'I';} { I=Indice. Indica ao CloseFilesOpens que se trata de um arquivo de indice }
{  IxF.DataF.Tipo := 'I';}
end;

Function TDb_Methods.FileSize(VAR DatF : DataFile):Longint;
Begin
  If (DatF.F <> nil) and DatF.F.IsFileOpen
  Then Result := DatF.F.FileSize
  Else Result := 0;
End;

Function TDb_Methods.IoResult(Var DatF : DataFile) : Integer;Far;
Begin
  IoResult := Db_Error.IoResult;
  DatF.ErroDos := ErroDos;
End;

{@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@}

Function TDb_Methods.FTb(Const FileName:PathStr):PathStr;
Begin
//  If Pos('.',FileName) = 0
  If dos.ExtractFileExt(FileName) = ''
  Then FTb := FileName+'.Tb'
  Else FTb := FileName;
End;
Function TDb_Methods.FObj(Const FileName:PathStr):PathStr;
Begin

//  If Pos('.',FileName) = 0
  If dos.ExtractFileExt(FileName) = ''
  Then FObj := FileName+'.TbO' {Tabelas de objetos vinculados a tabela m�e}
  Else FObj := FileName;

End;

Function TDb_Methods.FIx(Const FileName:PathStr):PathStr;
Begin

//  If Pos('.',FileName) = 0
  If dos.ExtractFileExt(FileName) = ''
  Then FIx := FileName+'.Ix'
  Else FIx := FileName;

End;
Function TDb_Methods.FDup(Const FileName:PathStr):PathStr;
Begin

//  If Pos('.',FileName) = 0
  If dos.ExtractFileExt(FileName) = ''
  Then FDup := FileName+'.TbD'
  Else FDup := Copy(FileName,1,Pos('.',FileName))+'TbD';
End;

Function TDb_Methods.FGetHeaderDataFile(Const FileName: PathStr;
                            Var Header : TsImagemHeader;
                            Var aFileSize : Longint):Boolean;
Var
  F : File;
Begin

  If FileExists(FTb(FileName)) Then
  Begin
    Assign(F,FTb(FileName));
    If Systemm.FileSize(FileName) = 0
    Then Begin
           aFileSize := 0;
           FillChar(Header,sizeof(Header),0);
           Result    := false;
           exit;
         end;

{    If Systemm.FileSize(FileName) = 0
    Then Raise TException.Create(Name_Type_App_MarIcaraiV1,
                                'Tb_Access.Pas',
                                'FGetHeaderDataFile(' + FileName+ ')'
                                ,
                                'Tamanho do arquivo igual a zero.');}

    Reset(F,MinDataRecSize,FileMode);
    IF TaStatus=0 THEN
    Begin
      BlocksRead := BLOCKREAD(F,Header,1);
      FGetHeaderDataFile := (TaStatus = 0 ) and (BlocksRead=1);

      If (TaStatus = 0 ) and (BlocksRead=1) and (Header.ItemSize>0)
      Then aFileSize := System.FileSize(f)*MinDataRecSize Div Header.ItemSize
      else aFileSize := -1;
      Close(F);
    End
    else FGetHeaderDataFile := false;
  End
  else FGetHeaderDataFile := false;

End;

Function TDb_Methods.FTamRegDataFile(Const FileName: PathStr):SmallWord;
  Var
    Header : TsImagemHeader;
    aFileSize : Longint;
Begin


  If FGetHeaderDataFile(FileName,Header,aFileSize) Then
    FTamRegDataFile := Header.ItemSize
  else
    FTamRegDataFile := 0;


end;

function TDb_Methods.UsedRecs(var DatF : ConfigDataFile ) : Longint;
begin

  Result := UsedRecs(DatF.Df);

end;

Function TDb_Methods.UsedRecs(Const FileName:PathStr) : Longint;
  Var
    Header : TsImagemHeader;
    aFileSize : Longint;
Begin

  If FGetHeaderDataFile(FileName,Header,aFileSize)
  Then Result := aFileSize - Header.NumberFree - 1
  else Result := -1;;

End;


FUNCTION TDb_Methods.UsedRecs(Var IxF  :IndexFile;OK_GetHeaderDoIndice : Boolean) : LONGINT;Overload;
Begin
  Try

    If OK_GetHeaderDoIndice and Is_TFileOpen(IxF.DataF.F)
    Then LeiaHeaderDoIndice(IxF)
    Else TaStatus := 0;

  Finally
    If TaStatus = 0
    Then Result := IxF.DataF.NumberKey
    Else Result := 0;


  End;
end;

FUNCTION TDb_Methods.UsedRecs(Var IxF  :IndexFile) : LONGINT;Overload;
Begin
  Result := UsedRecs(IxF,true);
end;


Function TDb_Methods.NewFileName(FileName,Extencao:PathStr):PathStr;
Begin

{  While Pos(' ',FileName) <> 0
  do Delete(FileName,Pos(' ',FileName),1);}

  NewFileName:= Copy(FileName,1,Pos('.',FileName)) + Extencao;


End;

function TDb_Methods.Int2str(Const L : LongInt) : tString;
{ Converts an SmallInt to a tString for use with OutText, OutTextXY }
var
  S : tString;
begin
  Str(L:0, S);
  Int2Str := S;
end; { Int2Str }


 procedure TDb_Methods. Beep;
begin
  SysSound(300);
  SysDelay(50);
  SysNoSound;
end; { Beep }

{ procedure TDb_Methods. clreoln(i,j,tamanho : byte );
Var WindMinAux,WindMaxAux : SmallWord;
begin
  WindMinAux := WindMin;WindMaxAux := WindMax;
  Window(1,1,80,25);
  gotoxy(j,i); write('': tamanho);
  Window(Lo(WindMinAux)+1,Hi(WindMinAux)+1,Lo(WindMaxAux)+1,Hi(WindMaxAux)+1);
end;}

Function TDb_Methods.EscrevaTurboError(DatF   : DataFile;Const NR     : Longint;Error:SmallWord):Boolean;
Var
  StrError,
  StrErrorExtendido    ,
  _StErre          ,
  _StErrAcaoRecomendada ,
  _SterrLocalizacao     : tString;
  ItemSelecionado : TListBoxRec;

  Comando{,i}          : SmallWord;
  Msg     : tString;
  MsgError,aMsgError : PSItem;
{  TelaAux          : TipoTela;}
  Wnr,SeqNrTravados,aFileName,
  wIsFileOpen,
  WFileSize,
  wDatF_NumRec    : tString;
  var
    Wok : Boolean;
    WTaStatus : Integer;
    wItemSize : AnsiString;
Begin

  Try
    WTaStatus := TaStatus;
//    {$IFDEF TaDebug}Application.Push_MsgErro('Tb_Access.EscrevaTurboError',ListaDeChamadas);{$ENDIF}
    Wok := ok;
    Result := False; {Indica que houver um erro e que o sistema Nao deve preocesseguir}

    If (Error> 0) And (Error<=255)
    Then Msg := ^C+'O SISTEMA OPERACIONAL Não responde com o servi�o solicitado.'
    else Msg := ^C+'Aplicação com problemas. Acione o suporte ao produto.';

    StrError              := TurboError(Error);
    StrErrorExtendido     := TurboError(ErroDOS.StatusExtendido);
    _StErre          := StrPas(StErre(ErroDos));
    _StErrAcaoRecomendada := StrPas(StErrAcaoRecomendada(ErroDos));
    _SterrLocalizacao     := StrPas(SterrLocalizacao(ErroDos));
    aFileName             := DatF.Filename;
    wItemSize             := IntToStr(DatF.ItemSize);

    SeqNrTravados         := '' {FilesOpens.StrRecsLocks(aFileName)};

    wNr                   := Int2Str(Nr);
    IoResult(DatF); {Inicializa InOutRes}
    If Is_TFileOpen(DatF.F) Then
    Begin
      wIsFileOpen := 'Aberto';
      WFileSize     := Int2Str(FileSize(DatF));
      wDatF_NumRec :=  Int2Str(DatF.NumRec);
    end
    else
    Begin
      wIsFileOpen  := 'Fechado';
      WFileSize    := '';
      wDatF_NumRec := '';
    end;

    MsgError := NewSItem(' ',
                NewSItem(Msg,
                NewSItem(' ',
                NewSItem('ERROR '+Int2Str(Error)+' :',
                NewSItem('  '+StrError,
                NewSItem(' ',
  {              NewSItem('ERRO EXTENDIDO (Intr $59)',
                NewSItem('  Erro..........: '+StrErrorExtendido ,
                NewSItem('  e do erro: '+_StErre,
                NewSItem('  Recomendação..: '+_StErrAcaoRecomendada,
                NewSItem('  Localização...: '+_SterrLocalizacao,
                NewSItem(' ',}
                NewSItem('ARQUIVO.......: '+aFileName,
                NewSItem('  Status......: '+wIsFileOpen,
                NewSItem('  FileSize(F).: '+WFileSize,
                NewSItem('  ItemSize....: '+wItemSize,
                NewSItem('  DatF.NumRec.: '+wDatF_NumRec,
                NewSItem('  Nr. corrente: '+wNr,
                NewSItem('  Nr. travados: '+SeqNrTravados,
                NewSItem(' ',
                NewSItem('ARQUIVOS EM USO: '+IStr(FilesOpens.Count,'BBB'),
                NewSItem('PRÓXIMO HANDLE.: '+IStr(FPrimeiroHandleLivre,'BBB'),
                NewSItem(' ',

                NewSItem('Não posso continuar o processamento.',
                NewSItem(' ',NIL

                )))))))))))))))))));

//    EscreveErroEmFerr;
        Application.Push_MsgErro('------------------------------------------------------------');
        Application.Push_MsgErro('Tb_Access.EscrevaTurboError');
        Application.Push_MsgErro('------------------------------------------------------------');

        aMsgError := MsgError;
        While (aMsgError <> nil) and (aMsgError^.Value<>nil) do
        Begin
          Application.Push_MsgErro(aMsgError^.Value^);
          aMsgError := aMsgError^.Next;
        End;
        Application.Push_MsgErro('------------------------------------------------------------');


  Finally
    ok := wok;
    TaStatus := wTaStatus;

  End;


End;

Function TDb_Methods.TAIOCheck(VAR DatF : DataFile;Const R : LONGINT):Boolean;
BEGIN
  IF (TaStatus <> 0) or (Not Is_TFileOpen(DatF.F)) THEN
  Begin
    DatF.ErroDos := ErroDos; {Salva as informacoes do ultimo erro}
    Result := EscrevaTurboError(DatF,R,TaStatus);
  End
  Else Result := true;
END; { TAIOCheck }


function TDb_Methods.spc(Const campo:AnsiString;Const tam :Longint):AnsiString;
begin
  {Result := '';}
  if Length(campo) < tam
  then Result := Campo + ConstStr(tam-Length(campo),' ')
  else Result := Copy(Campo,1,Tam);
end;

// procedure TDb_Methods. EscrevaRP(Const LinMsg,colMsg:SmallInt;Const Str:tString);
//Begin
//  GotoXy(colMsg,LinMsg);Write(Spc(Str,length(Str)));
//end;

(* procedure TDb_Methods. Erase(var F);
{$I-}  deu problemas por isso comentei???
Begin
  Ok := IoResult=0;
  Erase(F);
  Ok := IoResult=0;
End;*)


Function TDb_Methods.SincronizaPosChave(Var datFIx:IndexFile;Const NrCurrent:Longint; KeyCurrent : TaKeyStr):Boolean;
  {
    Com a chave anterior e o numero do registro anterior esta rotina
    Posiciona o ponteiro do indice exatamente onde estava antes

    Obs. Esta rotina e necess�ria quando se precisa voltar a posição anterior
        nos casos de índices que permite chaves repetidas.
  }
Var
  WNrCurrent  : Longint;
  wKeyCurrent : TaKeyStr;
Begin
  KeyCurrent  := AnsiUpperCase(String_Asc_Console_to_Asc_Ingles(KeyCurrent));
  wKeyCurrent := KeyCurrent;
  FindKey(datFIx ,WNrCurrent,KeyCurrent);
  If ok Then
  If (Not datFIx.AllowDuplKeys) And (NrCurrent <> WNrCurrent)
  Then Repeat //Sicroniza a posição da chave
         ok := NextKey (datFIx ,WNrCurrent,KeyCurrent);
         Ok := ok and (WKeyCurrent = AnsiUpperCase(String_Asc_Console_to_Asc_Ingles(KeyCurrent)));

       Until (NrCurrent=WNrCurrent) or Not ok;
  Result := ok;
End;

Function TDb_Methods.UpperCase(str:AnsiString):AnsiString;
var
  i : Integer;
begin
  Result := AnsiUpperCase(scg(Str));
end;

Function TDb_Methods.Lowcase(str:AnsiString):AnsiString;
var
  i:Integer;
  S : tString;
begin
  if str <> ''
  Then Begin
        {Mantém a primeira letra em Maiuscula}
        S := AnsiUpperCase(scg(copy(Str,1,1)));
        if length(str)>1
        then Begin
              Result := Copy(str,2,length(str)-1);
              Result := s + AnsiLowerCase(Result);
             end
        Else Result := s;
       End
  Else Result := '';
end;

{Function Lowcase(str:AnsiString):AnsiString;
var
  i:Integer;
begin
  if str <> '' Then
  Begin
    //Mantem a primeira letra em Min�scula
    If (Byte(Str[1]) > 96) And (Byte(Str[1]) <= 123) Then
      str[1] := AnsiChar(Byte(str[1])-32);

    for i:= 2 to Length(str) do
      If Byte(str[i]) in [65..90] then
        str[i] := AnsiChar(Byte(str[i])+32);
  End;
  Lowcase := str;
end;}


Function TDb_Methods.FExisteCodigo (Var IxF:IndexFile;Const código:tString):Boolean;
Var NRec    : Longint;
    WCodigo : tString;
Begin
//  {$IFDEF TaDebug}Application.Push_MsgErro('Tb_Access.FExisteCodigo',ListaDeChamadas);{$ENDIF}
  If Is_TFileOpen(IxF.dataF.F) Then
  Begin
    WCodigo := UpperCase(código);
    SearchKey(IxF,NRec,WCodigo);
    FExisteCodigo := ok And (código=Copy(WCodigo,1,Byte(código[0])));
  End
  Else
    FExisteCodigo := False;

End;

Function TDb_Methods.GetRec(var DatF : DataFile;Const R : Longint;var Buffer ):Boolean;
BEGIN
  Try {Finally}
      If DatF.F <> nil
      Then ok := DatF.F.GetRec(R,Buffer)=0
      Else Begin
             TaStatus := ErroArquivoFechado;
             //Abort;
             If TaStatus <> 0
             Then abort;
           End;

      If Not ok
      Then Abort;
  Finally
    Result := ok;
  end;
END; { GetRec }

Function TDb_Methods.GetRecBlock(VAR DatF   : DataFile; Const R : LONGINT; delta:Word;Var BlocksRead:Word ;VAR Buffer  ):Boolean;
BEGIN

  Try {Finally}
//    Try {Except}

      BlocksRead :=  DatF.F.BLOCKREAD(R,Buffer,Delta);
      Ok := (TaStatus = 0 ) and (BlocksRead=Delta);

      if Not ok
      then Abort;

{    Except
       ok := false;
       If TaStatus = 0
       Then TaStatus := Erro_Excecao_inesperada;

       If TaStatus <> 0
       Then Raise TException.Create(Name_Type_App_MarIcaraiV1,
                                'Tb_Access.Pas',
                                'Function GetRecBlock(' + DatF.FileName+ ')',
                                 TaStatus);
    end;}

  Finally
    Result := ok;
  End;

END; { GetRec }

Function TDb_Methods._PutRec(var DatF : DataFile;Const R : Longint;var Buffer;Const Transaction_Current : T_TTransaction):Boolean;
  Var
    aTempoDeTentativas : Longint;
    ClockBegin         : DWord;
//    _Progress1Passo    : TProgressDlg_If;
    Wok_Set_Transaction : Boolean;

BEGIN
  Try {Except}
    Try {Finally}
      SetTransaction(true,OK,Wok_Set_Transaction);
      If ok And OkTransaction and (Transaction<>nil) and (Not OkCreateTransaction)
      Then Begin
             If  ok_Set_Transaction and (Not DatF.OkTemporario)
             Then Begin
                    If (Transaction_Current <>  Tra_AddRec) {(R < FileSize(DatF)) and ok}
                    Then Begin {esta alterando o arquivo}
                           ok := GetRec(DatF,R,Transaction.RecordBufPtr^);
                           If ok
                           Then ok := Transaction.DbTra_AddRec(DatF,R,Transaction.RecordBufPtr^,Transaction_Current);
                           If Not ok
                           Then Begin
                                  _PutRec := ok;
                                  Abort;
                                End;
                         end
                    else Begin {Esta expandindo o arquivo}
                           If ok
                           Then ok := Transaction.DbTra_AddRec(DatF,R,Buffer,Transaction_Current);

                           If Not ok
                           Then Begin
                                  _PutRec := ok;
                                  Abort;
                                End;
                         End;
                  End;
           End;

      If ok
      Then Begin
             Ok := DatF.F.PutRec(R,Buffer) = 0;
             IF Not ok THEN Abort;
           End;

  Finally
    Result := ok;
{$REGION ' ---> 2013/03/21 - Tarefa: Implementar a chamada a Rollback caso esteja dentro da transação e ocorra erro e a transação tenha sido executada na função _PutRec().'}
  { DONE 1 -oVersão.9.36.26.3013>e.Metodo -cMELHORIA DO CÓDIGO :
 2013/03/21. Criado em: 2013/03/21.
   � PROBLEMA: Implementar a chamada a Rollback caso esteja dentro da transação e ocorra erro e a transação tenha sido executada na função _PutRec().
       � CAUSA:
           � As vezes um índice fica Inconsistente.
       � SOLUÇÃO:
           � Implementar o comando Rollback todas as vezes que o comando StartTransaction for executado.
  }
     SetTransaction(False,Result,Wok_Set_Transaction);
  End;

  Except
    If TaStatus = 0
    Then TaStatus := Erro_Excecao_inesperada;

    Ok := false;
    Result := ok;
    Raise TException.Create(Name_Type_App_MarIcaraiV1,
                              'Tb_Access.Pas',
                              'Function _PutRec(' + DatF.FileName+ ')',
                               TaStatus);
  end;

{$ENDREGION}
//==========================================================================================================




END; { _PutRec }

Function TDb_Methods.PutRec(var DatF : DataFile;Const R : Longint;var Buffer  ):Boolean;
Begin
  Result := _PutRec(DatF,R,Buffer,Tra_PutRec);
  IF Result and FlushBuffer
  THEN Result := FlushFile(DatF);
End;



FUNCTION TDb_Methods.PrimeiroLivre(VAR DatF: ConfigDataFile) : LONGINT;
BEGIN
  IF NOT DatF.Df.FileModeDenyALL THEN {20/03/2000
                                   Retirei para teste do RcNrec cont�bil
                                   esta dando chave em duplicidade.

                                   10/04/2000
                                    Se o ReadHeader for executado sem o teste
                                    de exclusivo o sistema Não atualiza o
                                    cabecarios do arquivo e o primeiro
                                    livre fica constante.
                                   }
  Begin
    ReadHeader(DatF.DF);
  End;
  WITH DatF,Df DO
    If (FirstFree = -1) or
       (FirstFree = 0) or
       (Not DatF.df.OkAddRecFirstFree) Then
    Begin
      NumRec        := FileSize(DatF.df);
      PrimeiroLivre := NumRec;
    End
    Else
      PrimeiroLivre := FirstFree;
END;

Function TDb_Methods.MakeFile(var DatF : DataFile;Const FName : FileName;Const RecLen : SmallWord):Integer;
  Var
    Wok_Set_Transaction : Boolean;
BEGIN
  try //Except
    Try //Finally
  //    {$IFDEF TADebug}Application.Push_MsgErro('Tb_Access.MakeFile',ListaDeChamadas);{$ENDIF}
      TaStatus := 0;
//      SetTransaction(true,OK,Wok_Set_Transaction);  Não posso colocar makefile pq a transação Não controle arquivos deletados.
      If (Not Is_TFileOpen(DatF.F)) //and ok
      Then Begin
              AssignDataFile(DatF,FName,RecLen,RecLen);

              DatF.F.Rewrite(FileMode or StCreate);
              TaStatus := DatF.F.ErrorInfo;
              ok := TaStatus = 0;


              IF TaStatus <>0
              THEN BEGIN
                     TaIOcheck(DatF,0);
                     Discard(TObject(DatF.F));
                     abort;
                   End;


              IF RecLen > MaxDataRecSize
              THEN Begin
                     TaStatus := REC_TOO_LARGE;

                     TAIOCheck(DatF, 0);
                     Discard(TObject(DatF.F));
                     abort;
                   End;

              IF RecLen < MinDataRecSize
              THEN Begin
                     TaStatus := REC_TOO_SMALL;

                     TAIOCheck(DatF, 0);
                     Discard(TObject(DatF.F));
                     Abort;
                   End;

              FilesOpens.Insert(@DatF);
              ok := WriteHeaderMakeFile(DatF);

              If Not ok
              Then Abort;
           End
      Else Begin
             If TaStatus = 0
             Then TaStatus := ErrorTentativa_de_abrir_um_arquivo_aberto;


             TAIOCheck(DatF, 0);
             abort;
           End;

    Finally
      If TaStatus <> 0
      Then  Application.Mi_MsgBox.MessageBox(StrMessageBox('',
                                     'Tb_Access',
                                     'Function MakeFile(' + FName+ ')',
                                     TurboError(TaStatus)));
      Result := TaStatus;
      Ok := Result = 0;

  {$REGION ' ---> 2013/03/21 - Tarefa: Implementar a chamada a Rollback caso esteja dentro da transação e ocorra erro e a transação tenha sido executada na função MakeFile().'}
    { DONE 1 -oVersão.9.36.26.3013>e.Metodo -cMELHORIA DO CÓDIGO :
 2013/03/21. Criado em: 2013/03/21.
     � PROBLEMA: Implementar a chamada a Rollback caso esteja dentro da transação e ocorra erro e a transação tenha sido executada na função MakeFile().
         � CAUSA:
             � As vezes um índice fica Inconsistente.
         � SOLUÇÃO:
             � Implementar o comando Rollback todas as vezes que o comando StartTransaction for executado.
    }
//        SetTransaction(False,OK,Wok_Set_Transaction);
      End;

  Except
    If TaStatus = 0
    Then TaStatus := Erro_Excecao_inesperada;

    Ok := false;
    Result := TaStatus;
    Raise TException.Create(Name_Type_App_MarIcaraiV1,
                              'Tb_Access.Pas',
                              'Function MakeFile(' + FName+ ')',
                               TaStatus);
  end;

{$ENDREGION}
//==========================================================================================================

END; { MakeFile }

Function TDb_Methods.FMakeFile(Const FileName:PathStr;Const TamArq:Longint):Integer;
Var
  Arq : ConfigDataFile;
Begin
//  {$IFDEF TaDebug}Application.Push_MsgErro('Tb_Access.FMakeFile',ListaDeChamadas);{$ENDIF}
  InicArqDados(Arq,FileName,TamArq,0);
  Result := TMakeFile(Arq);
  If Result = 0 Then TCloseFile(Arq);

End;

FUNCTION TDb_Methods.AtualizaDestino(Var RegFonte;   Const TamFonte:SmallWord;
                         var RegDestino; Const TamDestino : SmallWord) : BOOLEAN;
BEGIN
  Move(RegFonte,RegDestino,TamFonte);
  AtualizaDestino := true;
END;

Function FDelStrBrancos(S:tString):tString;
Begin
  While (Pos(' ',S) <> 0) and (S<>'') Do
    Delete(S,Pos(' ',S),1);
  FDelStrBrancos := S;
End;


 procedure TDb_Methods. inicArqDados(Var CDataFile          : ConfigDataFile;
                       NomeArquivo        : PathStr;
                       tamanhoRegistro    : SmallWord;
                       NumeroDeArqIndice  : byte;
                       wOkTemporario      : Boolean
                      );

begin
  FillChar(CDataFile,sizeof(CDataFile),0);
  with CDataFile,df do
  begin
    Tipo          := 'D';
    NomeArq       := UpperCase({FDelStrBrancos(} NomeArquivo {)});
    tamReg        := tamanhoRegistro;
    ItemSize      := tamanhoRegistro;
    NArqIndice    := NumeroDeArqIndice;
    OkTemporario  := wOkTemporario;
  end;
end;

 procedure TDb_Methods. inicArqDados(Var CDataFile          : ConfigDataFile;
                       NomeArquivo        : PathStr;
                       tamanhoRegistro    : SmallWord;
                       NumeroDeArqIndice  : byte
                      );
Begin
  inicArqDados(CDataFile,NomeArquivo,tamanhoRegistro,NumeroDeArqIndice,false);
end;

 procedure TDb_Methods. inicArqIndice(Const      Indice             : Byte;
                        Var        CIndexFile         : ConfigIndexFile;
                        Const      CNomeArqIndice     : PathStr;
                        Const      CRepeteChave       : Byte;
                        Const      StrCondicao        : tString        );

 procedure TDb_Methods. InicEnderecoReg;

type
  TipoEnd      = record
                   OffsetReg,
                   SegmentoReg : byte;
                 end;

  tipoEndereco = Array[1..5] of tipoEnd;

var
  EnderecoReg  : tipoEndereco;
  j,k,ERR        : Integer;
  St           : tString;
  LArq,
  CArq ,
  TamStr       : Byte;

begin
  St      := '';
  LArq    := 1;
  CArq    := 1;
  TamStr  := length(StrCondicao);

  for j :=  1 to TamStr do
  case StrCondicao[j] of

    '0'..'9'  : if LArq = Indice then
                  St := st + StrCondicao[j];

    ','       : if LArq = Indice then
                begin
                  with EnderecoReg[CArq] do
                    val(St,SegmentoReg,Err);
                  St := '';
                end;
    ';'       : if LArq = Indice then
                begin
                  with EnderecoReg[CArq] do
                    val(St,OffsetReg,Err);
                  st := '';
                  inc(CArq);
                end;

    '.'       : if LArq = Indice then
                begin
                  with EnderecoReg[CArq] do
                    val(St,OffsetReg,Err);
                  with CIndexFile do
                  begin
                    TamChave := 0;
                    for k := 1 to CArq do
                    TamChave := TamChave + EnderecoReg[k].OffsetReg;

                    PosicaoNoReg := EnderecoReg[1].SegmentoReg;
                  end;

                  exit;
                end
                else
                begin
                  inc(LArq);
                  CArq := 1;
                end;
  end;
end;

begin
//  {$IFDEF TaDebug}Application.Push_MsgErro('Tb_Access.inicArqIndice',ListaDeChamadas);{$ENDIF}
  FillChar(CIndexFile,sizeof(CIndexFile),0);
  with CIndexFile,Ix,dataF do
  begin
    OkAddRecFirstFree := false;//Não aproveita espaço do registro deletado.
    Tipo          := 'I';
    IndiceArray   := Indice;
    nomeArqIndice := UpperCase(CNomeArqIndice);
    RepeteChave   := CRepeteChave;
    OkMsgDuplicidade := True;
    OkTemporario  := False;
    OrderByDesc   := False; // Padrao � ordem crescente.
    InicEnderecoReg;
  end;

end;

Function TDb_Methods.GetTempDir(Const env:tString;Var path:PathStr):SmallInt;{Retorna o código do error se houver}
   var Dir: DirStr; var Name: TFileName; var Ext: ExtStr;
Begin
  taStatus := 0;
  FSplit(ParamStr(0),Dir,Name,Ext);
  Path := GetEnv(env);
  Path := FExpand(Path)+PathDelim+Name+PathDelim;
  ok   := DirectoryExists(Path);
  IF Not ok
  Then Begin
         {Path := 'c:\temp';}
         ok := CreateDir(Path);
       end;
  GetTempDir := taStatus;
end;

Function TDb_Methods.FileNameTemp_Ext(const aPath:PathStr;Var NomeArqTemp : PathStr;Extencao : PathStr):Boolean;overload; { Cria arquivo temporário }
{function GetTempFileName(PathName,PrefixString: PAnsiChar; Unique: UInt; TempFileName: PAnsiChar): UInt;}
{$I-}
{ Esta função tempo como finalidade: Criar arquivo com nome sugerido pelo DOS}

{
Parameters

  lpPathName
     Points to a null-terminated tString that specifies the directory path for the filename.
     This tString must consist of AnsiCharacters in the ANSI AnsiCharacter set.
     Applications typically specify a period (.) or the result of the GetTempPath function for this parameter.
     If this parameter is NULL, the function fails.

  lpPrefixString
     Points to a null-terminated prefix tString.
     The function uses the first three AnsiCharacters of this tString as the prefix of the filename.
     This tString must consist of AnsiCharacters in the ANSI AnsiCharacter set.

  uUnique
     Specifies an unsigned integer that the function converts to a hexadecimal tString for use in creating the temporary filename.
     If uUnique is nonzero, the function appends the hexadecimal tString to lpPrefixString to form the temporary filename.
     In this case, the function does not create the specified file, and does not test whether the filename is unique.
     If uUnique is zero, the function uses a hexadecimal tString derived from the current system time.
     In this case, the function uses different values until it finds a unique filename, and then it creates the file in the lpPathName directory.

  lpTempFileName
     Points to the buffer that receives the temporary filename.
     This null-terminated tString consists of AnsiCharacters in the ANSI AnsiCharacter set.
     This buffer should be at least the length, in bytes, specified by MAX_PATH to accommodate the path.
}

  Var
    lpPathName,
    lpPrefixString,
    lpTempFileName : Array[0..260] of AnsiChar;

    DatF           : ConfigDataFile;
    S,s1           : PathStr;



Label
  Inicio;


Begin
  Delay(100); {Dar um tempo para que gere nomes diferentes}

{  if application<>nil
  then S := application.ParamExecucao.NomeDeArquivosGenericos.DirTemp+#0
  Else Begin
          If GetTempDir('Temp',S)=0
          Then S := S+#0
          Else S := #0;
      End;}

  if aPath<>''
  then S := aPath+#0//application.ParamExecucao.NomeDeArquivosGenericos.DirTemp+#0
  Else Begin
          If GetTempDir('Temp',S)=0
          Then S := S+#0
          Else S := #0;
      End;


  FillChar(lpTempFileName,sizeof(lpTempFileName),0);
  FillChar(lpPrefixString,sizeof(lpPrefixString),0);

Inicio:
  StrPCopy(lpPathName,S);

  TaStatus := SetResult(SysGetTempFileName(lpPathName,lpPrefixString,0{uUnique}, lpTempFileName) = 0);


  Ok := TaStatus = 0;
  If Not ok
  Then Begin
         InicArqDados(DatF,StrPas(lpTempFileName),0,0);
         Ok := TaIOcheck(DatF.DF,0);
         If Not ok_Set_Transaction or ok
         Then Goto Inicio;
       end
  Else Begin
         If Extencao <> ''
         Then Begin

                S :=  AnsiString(lpTempFileName);

                NomeArqTemp := UpperCase(FTrocaExtencao(S,Extencao));

                If Not DelFile(NomeArqTemp)
                Then Raise TException.Create(Name_Type_App_MarIcaraiV1,
                                              'Tb_Access.Pas',
                                              'FileNameTemp_Ext()',
                                               TaStatus);


                ok := Ren(TFileName(lpTempFileName),NomeArqTemp);
                if ok
                then TaStatus := 0;

              end
         Else NomeArqTemp := UpperCase(StrPas(lpTempFileName));
       End;

  Result := Ok;

End;

Function TDb_Methods.FileNameTemp_Ext(Var NomeArqTemp : PathStr;Extencao : PathStr):Boolean;overload; { Cria arquivo temporário }
Begin
  if application<>nil
  then Result :=  FileNameTemp_Ext(application.ParamExecucao.NomeDeArquivosGenericos.DirTemp,NomeArqTemp,Extencao)
  Else Result :=  FileNameTemp_Ext('',NomeArqTemp,Extencao);
End;

Function TDb_Methods.FileNameTemp(Extencao : PathStr):PathStr; { Cria arquivo temporario }
Begin
  If Not FileNameTemp_Ext(Result,Extencao)
  Then Result := '';
end;


Function TDb_Methods.IsPortLocal(WPort : tString):Boolean;
Begin
  WPort := UpperCase(wPort);
  Result := (wPort = 'PRN') or
            (wPort = 'LPT1') or
            (wPort = 'LPT2') or
            (wPort = 'LPT3') or
            (wPort = 'LPT4') or
            (wPort = 'COM1') or
            (wPort = 'COM2') or
            (wPort = 'COM3') or
            (wPort = 'COM4');
end;

Function TDb_Methods.DelFile( Const Nome : TFileName):Boolean;
{Se o arquivo Não existe delFile deve retornar verdadeiro}
  Label Inicio;
  Var StrError:tString;

begin
  If IsPortLocal(nome)
  Then Begin
         TaStatus := 0;
         Ok := TaStatus = 0;
         Result := ok;
         exit;
       end;
      If FileExists(Nome)
      Then Begin
             If DeleteFile(Nome)<> 0 Then
             Begin
               Application.Mi_MsgBox.MessageBox(StrMessageBox(Name_Type_App_MarIcaraiV1,
                                   'Tb_Access',
                                   'DelFile(' + Nome+ ')',
                                   TurboError(TaStatus)));
               Ok := false;
             End;
             Ok := TaStatus = 0;
           End
      Else Ok := True{false};
    DelFile := ok;
 End;


Function TDb_Methods.FileName_Seq(Const aName:TFileName;Const aExt : ExtStr):PathStr;
  {
    Recebe:
      aName : Nome de um arquivo valido.
      aExt  : deve ter no máximo 2 caracter identificando o tipo de arquivo

    Retorna:
      Nome de um arquivo com a extensão 001,002 ... 999
      desde que Não existe no disco.


  }

  Var
    Dir  : DirStr;
    Name : TFileName;
    Ext  : ExtStr;
    i    : integer;
    Template : tString;
{    aFileName_Seq : PathStr;}

    Max  : integer;
Begin
  Template := ConstStr(3-length(aExt),'I');
  case length(Template) of
    3 : Max := 999;
    2 : Max := 99;
    1 : Max := 9;
    else Begin
           Tastatus  := ParametroInvalido;
           Application.Mi_MsgBox.MessageBox(Db_Error.StrMessageBox(
                            Name_Type_App_MarIcaraiV1,
                            'Tb_Access.Pas',
                            'FileName_Seq('+aName+')',
                             TaSTatus
                            ));

           Abort ;
         End;

  end;
  TaStatus := 0;

  FSplit(FExpand(aName),Dir,Name,Ext);
  i := 0;
  {For i := 0 to Max do}
  While i <= Max do
  Begin
    If Not FileExists(dir+Name+'.'+aExt+IStr(I,Template))
    Then Begin
           TaStatus := 0;
           FileName_Seq := dir+Name+'.'+aExt+ IStr(I,Template);
           exit;
         end;
    inc(i)
  end;

  Application.Mi_MsgBox.MessageBox(
     StrMessageBox(Name_Type_App_MarIcaraiV1,
                  '',
                  'Function FileName_Seq',
                  'Não posso criar nome do arquivo '+dir+Name+'.'+aExt+ IStr(I,Template)+
                  ' por que todos os nome já foram gerados e estão no disco!.',
                  'Tb_Access'
                 ));


  TaStatus     := 2;
  FileName_Seq := '';
end;



Function TDb_Methods.SetOkAddRecFirstFree(Const aOkAddRecFirstFree: Boolean):Boolean;
Begin
  SetOkAddRecFirstFree := OkAddRecFirstFree;
  OkAddRecFirstFree    := aOkAddRecFirstFree;
End;

Function  TDb_Methods.TMakeFile(var DatF : ConfigDataFile ):Integer;
begin
  Try
//    {$IFDEF TaDebug}Application.Push_MsgErro('Tb_Access.TMakeFile',ListaDeChamadas);{$ENDIF}

    Discard(TObject(DatF.Df.F));

    If DelFile(datF.NomeArq)
    Then TaStatus := ArquivoNaoEncontrado2;

{    If Not Is_TFileOpen(datF.DF.F)
    Then Begin
           Discard(TObject(DatF.Df.F));
           DelFile(datF.NomeArq) ;
           TaStatus := ArquivoNaoEncontrado2;
         end
    Else Begin
           TaStatus := ErrorTentativa_de_abrir_um_arquivo_aberto;
           MessageBox(StrMessageBox(Name_Type_App_MarIcaraiV1,
                                    'Tb_Access',
                                    'Function TMakeFile',
                                    StrPas(TurboError(TaStatus))));

           exit;
         End;}

    If TaStatus in [ArquivoNaoEncontrado2,ArquivoNaoEncontrado18]
    Then TaStatus := MakeFile(datF.Df,datF.NomeArq,datF.TamReg)
    Else TaStatus := AcessoNegado5;

  Finally
    Result := TaStatus;
    ok     := Result = 0;


  End;
end;

Function TDb_Methods.TOpenFile(var DatF : ConfigDataFile):Integer;Overload;
    Var
      Wok_Set_Transaction : Boolean;
begin
  Try
    If Not Is_TFileOpen(ConfigDataFile(DatF).DF.F) Then
    Begin
      If Not FileExists(DatF.NomeArq) Then
      Begin
          TaStatus := ArquivoNaoEncontrado2;
          Raise TException.Create(Name_Type_App_MarIcaraiV1,
                                  'Tb_Access.Pas',
                                  'Function TOpenFile(' + DatF.Df.FileName+ ')',
                                  TaStatus);
      End;

      With ConfigDataFile(DatF),DF do
      begin
        try
          SetTransaction(true,OK,Wok_Set_Transaction); //Objetivo de desfazer qualquer transação pendente.
          if ok
          then TaStatus := Tb_Access.OpenFile(Df,NomeArq,TamReg,Objects.FileMode)
          else Begin
                 if TaStatus =0
                 then TaStatus := ErroArquivoFechado;
               End;

        finally
          SetTransaction(False,OK,Wok_Set_Transaction);
        end;
      end;
    End;

  Finally
    Result := TaStatus;
    Ok := Result=0;
  End;
end;

Function TDb_Methods.TOpenFile(var ArqDados : ConfigDataFile;OkCreate : Boolean):Integer;Overload;
begin
  try

    TaStatus := TOpenFile(ArqDados);
    if OkCreate and (TaStatus<>0) And (TaStatus in [ArquivoNaoEncontrado2,ArquivoNaoEncontrado18]) then
    begin
      If FileShared(ArqDados.NomeArq)
      Then Begin
             If Application.Mi_MsgBox.MessageBox('O arquivo '+ArqDados.nomeArq+' Não existe.'+^M+
                           ^M+
                           'Cria o arquivo agora?'
                           ,MtConfirmation+mfYesNoCancel+MfInsertInApp,CmYes) = CmYes
             Then Begin

                    TaStatus := TMakeFile(ArqDados);
                    If TaStatus = 0
                    Then TCloseFile(ArqDados);

                    If TaStatus = 0
                    Then TaStatus := TOpenFile(ArqDados);
                  End
             Else TaStatus := ArquivoNaoEncontrado2;
           End;
     End; {Sucesso na operação}

  Finally
    Result := TaStatus;
    If TaStatus <>0
    Then Raise TException.Create(Name_Type_App_MarIcaraiV1,
                                  'Tb_Access.Pas',
                                  'Function OpenData('+ArqDados.NomeArq+')',
                                  TaStatus);

    Ok     := Result = 0;

  end;
end;



Function TDb_Methods.TCloseFile(var DatF : ConfigDataFile ):Integer;
begin
  Tb_Access.CloseFile(ConfigDataFile(DatF).DF);
  Result := TaStatus;
end;

Function TDb_Methods.TestaSePodeAbrirArquivo(Const FName  : PathStr): Byte;
{$F+}
{Retorna
   0 se o arquivo existe e Não foi aberto no modo exclusivo
   TaStatus se o arquivo existe e Não pode ser aberto.
}
  Var
    F : file of Byte;
Begin
//  {$IFDEF TaDebug}Application.Push_MsgErro('Tb_Access.TestaSePodeAbrirArquivo',ListaDeChamadas);{$ENDIF}
  If FileExists(FName) Then
  Begin
    Assign(F,FName);
    If System.IoResult <> 0 Then;
    {$I-} System.Reset(F); {$I+}

    If (Db_Error.IoResult = 0) Then
    Begin
      {$I-} System.Close(f);{$I+}
      If System.IoResult <> 0 Then;
    End;
  End;

  TestaSePodeAbrirArquivo := TaStatus;


End;

Function TDb_Methods.FileShared(Const FName  : PathStr) : Boolean;
Begin

//  {$IFDEF TaDebug}Application.Push_MsgErro('Tb_Access.FileShared',ListaDeChamadas);{$ENDIF}

  Try
    TaStatus := TestaSePodeAbrirArquivo(FName);
    If TaStatus In [0,ArquivoNaoEncontrado2,ArquivoNaoEncontrado18] Then
    Begin
      ok := True; { Sem erro ou o arquivo Não existe portanto pode ser criado }
    End
    Else
    If TaStatus in [AcessoNegado5,
                    AcessoNegado32,
                    ErroViolacaoDeLacre{,
                    ErroFaltaHardware}]
    Then
    Begin
      Ok := False;  { Acesso negado ao arquivo }
    End
    Else
    Begin
      Application.Mi_MsgBox.MessageBox(StrMessageBox('Tb_Access','FileShared',Fname,TaStatus));
      Ok := false;
    End;
    FileShared := Ok ;

 Finally

 end;


End;


Function TDb_Methods.GetAddRec( Const Title : tString;
                    Const NomeFonte:PathStr;
                    Var RegFonte;
                    Const TamFonte : SmallWord;

                    Const NomeDestino : PathStr;
                    Var regDestino;
                    Const TamDestino : SmallWord;

                    Const AtualizaDestino : TFuncGetAddRec;

                    Const OkMakeFile :Boolean) : Boolean;
Var
  ArqFonte,ArqDestino   : ConfigDataFile;
  NRecFonte,NRecDestino : Longint;
  TamArq                : Longint;
//  _Progress1Passo       : TProgressDlg_If;
  _Progress1Passo : TProgressDlg_If;
Begin
  GetAddRec := False;
  InicArqDados (ArqFonte  ,NomeFonte  ,TamFonte  ,0);
  InicArqDados (ArqDestino,NomeDestino,TamDestino,0);

  If Not FileExists(NomeFonte) Then
  Begin
    Raise TException.Create(Name_Type_App_MarIcaraiV1,
                        'Tb_Access.Pas',
                        'GetAddRec(Fonte='+NomeFonte+' ,Destino='+NomeDestino+')',
                         'Não existe arquivo fonte... '+NomeFonte);


  End;

  Try
//   {$IFDEF TaDebug}Application.Push_MsgErro('Tb_Access.GetAddRec',ListaDeChamadas);{$ENDIF}

    AbreArqSemHeader(ArqFonte,RegFonte);
    If ok Then
    Begin
      If OkMakeFile Then
      Begin
        TMakeFile(ArqDestino);
        TCloseFile(ArqDestino);
      End;
      TOpenFile(ArqDestino,True);
    End;

    If Ok Then
    with HoraInicial do
    Begin
      Try
        TamArq := FileSize(ArqFonte.Df)-1;
        NRecFonte := 0;
        Try
//          _Progress1Passo := OpenProgress1Passo('Gerando novo arquivo...',Title,TamArq);
          _Progress1Passo := Application._TProgressDlg_If.Create('Gerando novo arquivo...',Title,Delta_Locate,TamArq);
          For NRecFonte := 1 to tamArq do
{          If ArqFonte.Df.F.goBof
          Then While Not ArqFonte.Df.F.Eof do}
               Begin
//                  Inc(NRecFonte);
//                SetProgress1Passo(_Progress1Passo,NRecFonte);
                  _Progress1Passo.IncPosition();
                  FillChar(RegDestino,TamDestino,0);

                  ok := GetRec(ArqFonte.Df,NRecFonte,RegFonte);
                  If ok
                  Then Begin
                         NRec := PrimeiroLivre(ArqDestino);
                         If (Longint(RegFonte)=0)
                         Then If AtualizaDestino(RegFonte,TamFonte,RegDestino,TamDestino)
                              Then Ok := AddRec(ArqDestino.df,NRecDestino,RegDestino);
                       End;
               End;

        Finally
//         CloseProgress1Passo(_Progress1Passo);
         Discard(TObject(_Progress1Passo));
        end;
      Except
         If TaStatus=0
         Then TaStatus := Erro_Excecao_inesperada;

         Raise TException.Create(Name_Type_App_MarIcaraiV1,
                            'Tb_Access.Pas',
                            'GetAddRec(Fonte='+NomeFonte+' ,Destino='+NomeDestino+')',
                             TaStatus);

      end;
    End;
  Finally
    GetAddRec  := Ok;
    CloseArqSemHeader(ArqFonte  );
    TCloseFile(ArqDestino);

  End;
End;


Function TDb_Methods.FTrocaExtencao(Const NomeArq:TFileName; Extencao:PathStr) : PathStr;
  {g:\GCIC.Tb\estoque\inclient}
Var
  Dir           : DirStr;
  Name          : TFileName;
  Ext           : ExtStr;
Begin
  While Pos('.',Extencao) <> 0
  do delete(extencao,Pos('.',Extencao),1);

  If Extencao <> ''
  Then Begin
         FSplit(NomeArq,Dir,name,Ext);
         Result := Dir+name+'.'+Extencao;
       End
  Else Result := NomeArq;
End;

Function TDb_Methods.Ren(NomeFonte,NomeDestino: PathStr) : Boolean;
{ Renomeia Arquivos }
var
  F : file;
begin
  Try
    Ok := False;

//    {$IFDEF TaDebug} Application.Push_MsgErro('Tb_Access.pas',ListaDeChamadas);{$ENDIF}

{    While Pos(' ',NomeFonte) <> 0
    do Delete(NomeFonte,Pos(' ',NomeFonte),1);

    While Pos(' ',NomeDestino) <> 0
    do Delete(NomeDestino,Pos(' ',NomeDestino),1);}


    If UpperCase(NomeFonte) = UpperCase(NomeDestino)
    Then Begin
           Raise TException.Create(Name_Type_App_MarIcaraiV1,
                                    'Tb_Access.Pas',
                                    'Function Ren(Origem:' +NomeFonte+' , Dest:'+NomeDestino+')',
                                    'Nao posso renomear, porque o arquivo "fonte" igual ao "destino"!.');
         end;

    If Not FileExists(NomeFonte)
    Then Raise TException.Create(Name_Type_App_MarIcaraiV1,
                                    'Tb_Access.Pas',
                                    'Function Ren(Origem:' +NomeFonte+' , Dest:'+NomeDestino+')',
                                    'Nao posso renomear, porque o arquivo de origem Não existe!.')

    Else
    If FileExists(NomeDestino)
    then Raise TException.Create(Name_Type_App_MarIcaraiV1,
                                 'Tb_Access.Pas',
                                 'Function Ren(Origem:' +NomeFonte+' , Dest:'+NomeDestino+')',
                                 'Nao posso renomear, porque o arquivo destino já existe!.')
    Else
    Begin

      // O Delphi 2010 esta com bug em Rename. Ele troca o nome mais criar um arquivos com vêrios zeros na pasta corrente. ?????????????????
//      AssignFile(F,NomeFonte);
//      {$i-} Rename(f,NomeDestino);{$i+}
//      OK := Db_Error.IoResult = 0 ;

      ok :=  RenameFile (NomeFonte,NomeDestino);

      If Not Ok
      then Raise TException.Create(Name_Type_App_MarIcaraiV1,
                                 'Tb_Access.Pas',
                                 'Function Ren(Origem:' +NomeFonte+' , Dest:'+NomeDestino+')',
                                  TaStatus);
    End;

  Finally
    Result := Ok;

  End;
end;

/// <since>
///   . OkItemSize
///   . Retorna true se o Tamanho do registro em arquivo > tamanho do buffer do registro em Memória.
/// </since>
Function OkRecSizeMismatch(Const FName  : FileName;Const RecLenBufferRecord : SmallWord):Boolean;
Begin
  Result :=   FTamRegDataFile(FName) > RecLenBufferRecord;
End;

Function TDb_Methods.ModifyStructurFile(Const FName  : FileName;Const RecLenDest : SmallWord):Boolean;
  LABEL
    InicioReset ;
Var
  wFileModeDenyALL        : Boolean;

  RegFonte,
  RegDestino          : Pointer;

//  DatF : DataFile;
  NomeDestino,
  NomeAnterior        : PathStr;

  aOkTransaction: Boolean;

  RecLenFont    : Longint;

Begin

  Try
    RegFonte       := nil;
    RegDestino     := nil;

// Desabilito a transacao por que se der errado ele faz novamente na pr�xima ves que abrir a tabela.
// Se nao o fizer o commit gerar um erro de GPF.
    aOkTransaction := SetOkTransaction(False);

    Application.Mi_MsgBox.MessageBox(sgc('O tamanho do registro do arquivo '+FName+' maior que a Versão em disco.'+^M+
                  ^M+
                  'A função "ModifyStructurFile" ajusta o arquivo para refletir a Versão corrente.')
                   ,nil,MtError+ MbOKButton + mfInsertInApp,CmOk);

    RecLenFont := FTamRegDataFile(FName) ;
    If (RecLenFont=0)
    Then  Raise TException.Create(Name_Type_App_MarIcaraiV1,
                                   'Tb_Access.Pas',
                                   'ModifyStructurFile('+FName+')',
                                  sgc('O arquivo e disco esta com tamanho em bytes igual a zero. Não posso contituar!') );


    ok := (RecLenDest > RecLenFont) and (RecLenFont>0);
    If ok Then
    Begin
      ok := FileNameTemp_Ext(NomeDestino,'');
      If ok Then
      Begin
        Try
          Set_FileModeDenyALLSalvaAnt(true,wFileModeDenyALL);
          FGetMem(RegFonte  ,RecLenFont);
          FGetMem(regDestino,RecLenDest);

          ok := GetAddRec('Modificando estrutura do arquivo...',
                          FName,
                          RegFonte^,
                          RecLenFont,

                          NomeDestino,
                          regDestino^,
                          RecLenDest,

                          AtualizaDestino,

                          TRUE {OkMakeFile :Boolean}) ;

        Finally
          Set_FileModeDenyALL(wFileModeDenyALL);
          FFreeMem(RegFonte  ,RecLenFont);
          FFreeMem(regDestino,RecLenDest);
        End;

        If ok Then
        Begin
          NomeAnterior := FName;
          NomeAnterior := FTrocaExtencao(NomeAnterior,Const_Ext_Tabela_com_a_copia_da_versao_anterior_da_tabela);
          delFile(NomeAnterior);
          If Ren(FName,NomeAnterior)
          Then ok := Ren(NomeDestino,FName)
          Else Ok := false;
        End;
      End;
    End
    else Begin
           TaStatus :=ErroArquivoFechado;
           Raise TException.Create(Name_Type_App_MarIcaraiV1,
                                   'Tb_Access.Pas',
                                   'ModifyStructurFile('+FName+')',
                                   TaStatus);
         End;


  Finally

    Result := ok;
    //Obs: Delfile retorno 2 quando Não existe uma copia anterior de FName
    if Result
    then TaStatus := 0;

    OkDeveReindexarDB  := ok;
    SetOkTransaction(aOkTransaction);
  End;

End;

Function TDb_Methods.OpenFile(var DatF     : DataFile;
                  Const FName  : FileName;
                  Const RecLen : SmallWord;
                  AFileMode    : Word
                 ):Integer;
    Var
      Wok_Set_Transaction : Boolean;

BEGIN
  try //Except
    Try {Finally}

//      SetTransaction(true,OK,Wok_Set_Transaction); Não posso inicializa transação aqui porque esta rotina e chamada por rollback. Transferido para TOpenFile
      If (Not Is_TFileOpen(DatF.F)) //and ok
      Then BEGIN
             If (RecLen > systemm.FileSize(FName)) and ( systemm.FileSize(FName)>0)
             Then Begin
                    ModifyStructurFile(FName,RecLen);
                    AssignDataFile(DatF,FName,RecLen,RecLen,AFileMode,nil,DatF.Tipo);
                    DatF.OkDeveIndexar := true;
                  end
             Else AssignDataFile(DatF,FName,RecLen,RecLen,AFileMode,nil,DatF.Tipo);


             DatF.f.Reset(aFileMode);
             ok := TaStatus = 0;

             IF TaStatus<>0
             THEN BEGIN
                     TaIOcheck(DatF,0);
                     Discard(TObject(DatF.F));
                     Abort;
                   END;

             IF RecLen > MaxDataRecSize
             THEN Begin
                     TaStatus := REC_TOO_LARGE;
                     Discard(TObject(DatF.F));
                     Abort;
                  End;

             IF RecLen < MinDataRecSize
             THEN Begin
                     TaStatus := REC_TOO_SMALL;
                     Discard(TObject(DatF.F));
                     Abort;
                  End;
             FilesOpens.Insert(@DatF);

             Repeat
  //              SysCtrlSleep(0);
                ok := ReadHeader(DatF);

                If (Not ok) And (TaStatus=0)
                Then TaStatus := ErroDeLeituraEmDisco;


                If ok Then
                Begin
                  ok := RecLen = DatF.ItemSize;
                  If Not ok Then
                  Begin
                    If RecLen < DatF.ItemSize
                    Then Begin
                           TaStatus := RecSizeMismatch;
                           TAIOCheck(DatF, 0);
                           Discard(TObject(DatF.F));
                           Raise TException.Create(Name_Type_App_MarIcaraiV1,
                                'Tb_Access.Pas',
                                 'OpenFile ('+DatF.FileName+'). RecLen = '+IntToStr(RecLen)+', DatF.ItemSize = '+IntToStr(DatF.ItemSize),
                               TaStatus);
                         End
                    Else If (DatF.ItemSize >= MinDataRecSize) and (DatF.ItemSize <= MaxDataRecSize)
                         Then Begin { Ajusta o tamanho do arquivo }
                                Tb_Access.CloseFile(DatF);
                                {So tem sentido ser o novo registro for maior que o anterior }
                                If ModifyStructurFile(FName,RecLen)
                                Then Begin
                                       DatF.OkDeveIndexar := true;
                                       TaStatus := OpenFile(DatF,FName,RecLen,AFileMode);
                                       If TaStatus<>0
                                       Then Begin
                                              TAIOCheck(DatF, 0);
                                              Abort;
                                            End;
                                     End
                                Else Begin
                                       TAIOCheck(DatF, 0);
                                       Abort;
                                     end;
                              End
                         else Begin
                                TaStatus := Estrutura_da_tabela_esta_danificada;
                                TAIOCheck(DatF, 0);
                                Discard(TObject(DatF.F));
                                Abort;
                              End;
                  End;
                End
                Else
                BEGIN
                  TAIOCheck(DatF, 0);
                  ok := false;
                END;
              until ok;
           END
      ELSE Begin
             If TaStatus = 0
             Then TaStatus := ErrorTentativa_de_abrir_um_arquivo_aberto;
             Abort;
           End;

    Finally
      Result := TaStatus;
      ok := Result = 0;

      If TaStatus <>0
      Then Application.Mi_MsgBox.MessageBox(StrMessageBox('',
                                  'Tb_Access',
                                  'Function OpenFile('+FName+')',
                                  TurboError(TaStatus)));

  {$REGION ' ---> 2013/03/21 - Tarefa: Implementar a chamada a Rollback caso esteja dentro da transação e ocorra erro e a transação tenha sido executada na função OpenFile().'}
    { DONE 1 -oVersão.9.36.26.3013>e.Metodo -cMELHORIA DO CÓDIGO :
 2013/03/21. Criado em: 2013/03/21.
     � PROBLEMA: Implementar a chamada a Rollback caso esteja dentro da transação e ocorra erro e a transação tenha sido executada na função OpenFile().
         � CAUSA:
             � As vezes um índice fica Inconsistente.
         � SOLUÇÃO:
             � Implementar o comando Rollback todas as vezes que o comando StartTransaction for executado.
    }
//      SetTransaction(False,OK,Wok_Set_Transaction);
    End;

  Except
    If TaStatus = 0
    Then TaStatus := Erro_Excecao_inesperada;

    Ok := false;
    Result := TaStatus;
    Raise TException.Create(Name_Type_App_MarIcaraiV1,
                              'Tb_Access.Pas',
                              'Function OpenFile(' + DatF.FileName+ ')',
                               TaStatus);
  end;

{$ENDREGION}
//==========================================================================================================

END; { OpenFile }

Function TDb_Methods.ReadHeader(VAR DatF   : DataFile):Boolean;
BEGIN
  WITH DatF DO
  BEGIN
    Ok := GetRec(DatF,0,TaRecBuf^);
    If ok
    Then Begin
           MOVE(TaRecBuf^,DatF.FirstFree,FileHeaderSize);
           WITH DatF DO MOVE(DatF.FirstFree,IH.FirstFree,FileHeaderSize);
         End;
    DatF.NumRec := DatF.f.FileSize;
  END;
  ReadHeader := ok;
END; { ReadHeader }

Function TDb_Methods.PutFileHeader(VAR DatF : DataFile):Boolean;
BEGIN
  Try
    If (DatF.F<>nil)
    Then Begin
           MOVE(DatF.FirstFree,TaRecBuf^,FileHeaderSize);
           MOVE(DatF.FirstFree,DatF.IH.FirstFree,FileHeaderSize);
           ok := _PutRec(DatF,0,TaRecBuf^,Tra_PutRec);
         End
    Else If TaStatus = 0
         Then TaStatus := ErroArquivoFechado;

  Finally
    Result := TaStatus = 0;
  End;
END; { PutFileHeader }

FUNCTION TDb_Methods.NaoMudouHeader(VAR DatF : DataFile) : BOOLEAN;
VAR DF : DataFile;
BEGIN
  With DatF do
  Begin
    GetRec(DatF,0,TaRecBuf^);
  End;

  MOVE(TaRecBuf^,DF.FirstFree,FileHeaderSize);
  NaoMuDOuHeader  := (Df.FirstFree  = DatF.FirstFree ) And
                     (Df.NumberFree = DatF.NumberFree) And
                     (Df.RR{Int1 }      = DatF.RR{Int1}      ) And
                     (Df.ItemSize   = DatF.ItemSize  );
END;

FUNCTION TDb_Methods.MudouHeaderEmMemoria(VAR DatF : DataFile) : BOOLEAN;
BEGIN
  MuDOuHeaderEmMemoria := Not (
                             (DatF.IH.FirstFree  = DatF.FirstFree ) And
                             (DatF.IH.NumberFree = DatF.NumberFree) And
                             (DatF.IH.RR{Int1}       = DatF.RR{Int1}      ) And
                             (DatF.IH.ItemSize   = DatF.ItemSize  ) And
                             (DatF.IH.NumberKey  = DatF.NumberKey )
                             );
END;

Function TDb_Methods.aCloseFile(VAR DatF : DataFile):boolean;
BEGIN
  Try
//    {$IFDEF TADebug} Application.Push_MsgErro('Tb_Access.aCloseFile',ListaDeChamadas);{$ENDIF}
    TaStatus := 0;
    If (DatF.F <> nil) and DatF.F.IsFileOpen Then
    BEGIN

      IF MudouHeaderEmMemoria(DatF)
      THEN ok := PutFileHeader(DatF)
      Else ok := true;

      If ok Then
      Begin
        Discard(TObject(DatF.F));
      End;
    END
    Else ok := true;

  Finally
    aCloseFile := ok;

  End;
END; { CloseFile }



Function TDb_Methods.CloseFile(VAR DatF : DataFile;OkCondicional:Boolean):boolean;Overload;

   Function _CloseFile:Boolean;
   Begin
     If (FilesOpens <> nil) And (FilesOpens.IndexOf(@DatF) <> -1)
     Then Begin
             FilesOpens.Free(@DatF);
             Result := ok;
           end
     Else Result := aCloseFile(DatF);
   end;

BEGIN
  Try
//    {$IFDEF TADebug} Application.Push_MsgErro('Tb_Access.CloseFile',ListaDeChamadas); {$ENDIF}
    TaStatus := 0;
    If Is_TFileOpen(DatF.F)
    Then Begin
           If OkCondicional
           Then Begin
                  If DatF.F.GetDriveType <> dt_Memory_Stream
                  Then Result := _CloseFile;
                End
           Else Result := _CloseFile;
         End
    Else Result := true;

  Finally


  End;
END; { CloseFile }

Function TDb_Methods.CloseFile(VAR DatF : DataFile):boolean;
Begin
  CloseFile(DatF,False)
end;

Function TDb_Methods.FlushFile(VAR DatF : DataFile):Boolean;
  var
    Wok : Boolean;  {O flush na deve alterar o fluxo normal visto que ele s� avisa DOS que descarregue os buffers}
BEGIN
  Try
    Wok := ok;
    TaStatus := 0;
    If Is_TFileOpen(DatF.F) Then
    Begin
      IF MudouHeaderEmMemoria(DatF)
      THEN Begin
             Result := PutFileHeader(DatF);
             If Not Result Then exit;
      end
      else Result := true;
      If Result  {and (FlushBuffer or Not DatF.FileModeDenyALL)}
      Then Begin
             DatF.F.Flush;
             Result := TaStatus = 0;
           end;
    End
    else Begin
           TaStatus := ErroArquivoFechado;
           Result := False;
           Raise TException.Create(Name_Type_App_MarIcaraiV1,
                                   'Tb_Access.Pas',
                                   'FlushFile('+DatF.Filename+')',
                                   TaStatus);
         End;

 Finally
   ok := Wok;
 end;
END; { FlushFile }

Function TDb_Methods.TraveArq(Var DatF : ConfigDataFile):Boolean;
Var
  ok : Boolean;
Begin
  Try
//    {$IFDEF TaDebug}Application.Push_MsgErro('Tb_Access.TraveArq',ListaDeChamadas);{$ENDIF}
    If (Not FileModeDenyALL) and (not ok_Set_Transaction) Then
    Begin
      ok := TraveHeader(DatF.Df);
      If Ok Then
        DatF.Df.Exclusivo := True;
    End
    Else ok := True;

  Finally
    TraveArq := ok;

  End;
End;

Function TDb_Methods.DestraveArq(Var DatF : ConfigDataFile):Boolean;
Var
  ok : Boolean;
Begin
  Try
//    {$IFDEF TaDebug}Application.Push_MsgErro('Tb_Access.DestraveArq',ListaDeChamadas);{$ENDIF}
    If (Not FileModeDenyALL) and (not ok_Set_Transaction) Then
    Begin
      Ok := DestraveHeader(DatF.DF);
      If Ok Then
        DatF.Df.Exclusivo := False;
    End
    Else Ok := True;
  Finally
    DestraveArq := ok;

  End;
End;

Function TDb_Methods.TraveRegistro(VAR  DatF : DataFile; Const R : LONGINT):Boolean;
Var
  ok                 : Boolean;
  aTempoDeTentativas : Longint;
  ClockBegin         : DWord;

BEGIN
  Try
//    {$IFDEF TADebug} Application.Push_MsgErro('Tb_Access.TraveRegistro',ListaDeChamadas);{$ENDIF}
    If (Not DatF.FileModeDenyALL) and (not ok_Set_Transaction)
    Then Begin
           Ok := DatF.F.Lock(R,1);
         End
    Else Ok := True;

  Finally
    TraveRegistro := ok;

  End;
END;

Function TDb_Methods.DestraveRegistro(Var  DatF : DataFile;Const R : Longint):Boolean;
Var
  ok : Boolean;
Begin
  Try
//    {$IFDEF TADebug} Application.Push_MsgErro('Tb_Access.DestraveRegistro',ListaDeChamadas);{$ENDIF}
    If (Not DatF.FileModeDenyALL) and (not ok_Set_Transaction)
    Then ok := DatF.F.UnLock(R,1)
    Else Ok := True;
  Finally
    DestraveRegistro := ok;

  End;
End;

Function TDb_Methods.TraveHeader(VAR DatF : DataFile):Boolean;
BEGIN
  IF (NOT DatF.FileModeDenyALL) and (not ok_Set_Transaction)
  THEN Ok := DatF.F.Lock(0,1)
  Else Ok := True;
  TraveHeader := ok;
END;

Function TDb_Methods.DestraveHeader(VAR DatF : DataFile):Boolean;
BEGIN
//  {$IFDEF TADebug} Application.Push_MsgErro('Tb_Access.DestraveHeader',ListaDeChamadas);{$ENDIF}
  IF (NOT DatF.FileModeDenyALL) and (not ok_Set_Transaction)
  THEN Result := DatF.F.UnLock(0,1)
  Else Result := True;

END;


 procedure TDb_Methods. NewRec(VAR DatF  : DataFile;VAR R     : LONGINT  );
BEGIN

  IF (DatF.FirstFree = -1) or
     (DatF.FirstFree = 0) or
     (not DatF.OkAddRecFirstFree)
  THEN
  BEGIN //Adiciona no final do arquivo
    IF DatF.FirstFree = 0 THEN
       DatF.FirstFree := -1; { Obs. Eu }

{     DatF.NumRec := FileSize(DatF); Esta instrução gera error 202 = starck overflow}
     R := DatF.NumRec;
     Inc(DatF.NumRec);

{    R := FileSize(DatF.f);
    DatF.NumRec := R+1;}
  END
  ELSE BEGIN
     R := DatF.FirstFree;
     GetRec(DatF,R,TaRecBuf^);
     DatF.FirstFree := TaRecBuf^.I;
     Dec(DatF.NumberFree);
  END;
END; { NewRec }

Function TDb_Methods.AddRec(var DatF : DataFile;var R  : Longint;var Buffer ):Boolean;
  VAR
    Wok_Set_Transaction : Boolean;
BEGIN
  try //Except
    Try
  //    {$IFDEF TADebug} Application.Push_MsgErro('Tb_Access.AddRec',ListaDeChamadas); {$ENDIF}

  {    If OkTransaction and (Transaction<>nil) and (not ok_Set_Transaction) Then
      Begin
        If Transaction.TransactionPendant=0
        Then Transaction.Rollback
        else Begin
               Transaction.DatF.Close;
               ok := true;
             end;

        If Not ok
        Then Begin
               AddRec := ok;
               exit;
             end;
      End;}
      SetTransaction(true,OK,Wok_Set_Transaction);
      if ok
      then begin
              IF (NOT DatF.FileModeDenyALL)
              THEN BEGIN
                     IF NOT DatF.Exclusivo
                     THEN ok := TraveHeader(DatF)
                     Else ok := true;
                     If ok Then ok := ReadHeader(DatF);
              END else ok := true;

              If ok
              Then Begin
                     NewRec(DatF,R);
                     IF (NOT DatF.FileModeDenyALL)
                     THEN BEGIN
                            LONGINT(Buffer) := 0;
                            If (R = fileSize(DatF)) and ok
                            Then ok := _PutRec(DatF,R,Buffer,Tra_AddRec)
                            else If ok
                                 Then ok := _PutRec(DatF,R,Buffer,Tra_PutRec);
                            If ok
                            Then ok := PutFileHeader(DatF);

                            IF ok and FlushBuffer
                            THEN ok := FlushFile(DatF);


                            IF ok and NOT DatF.Exclusivo
                            THEN ok := DestraveHeader(DatF);
                          END
                     ELSE Begin
                            LONGINT(Buffer) := 0;

                            If (R = fileSize(DatF)) and ok
                            Then ok := _PutRec(DatF,R,Buffer,Tra_AddRec)
                            else If ok
                                 Then ok := _PutRec(DatF,R,Buffer,Tra_PutRec);

                            IF ok and FlushBuffer
                            THEN ok := FlushFile(DatF);
                          End;
                   End;
      end;

    Finally
      Result := ok;

  {$REGION ' ---> 2013/03/21 - Tarefa: Implementar a chamada a Rollback caso esteja dentro da transação e ocorra erro e a transação tenha sido executada na função AddRec().'}
    { DONE 1 -oVersão.9.36.26.3013>e.Metodo -cMELHORIA DO CÓDIGO :
 2013/03/21. Criado em: 2013/03/21.
     � PROBLEMA: Implementar a chamada a Rollback caso esteja dentro da transação e ocorra erro e a transação tenha sido executada na função AddRec().
         � CAUSA:
             � As vezes um índice fica Inconsistente.
         � SOLUÇÃO:
             � Implementar o comando Rollback todas as vezes que o comando StartTransaction for executado.
    }
        SetTransaction(False,OK,Wok_Set_Transaction);
      End;

  Except
    If TaStatus = 0
    Then TaStatus := Erro_Excecao_inesperada;

    Ok := false;
    Result := ok;
    Raise TException.Create(Name_Type_App_MarIcaraiV1,
                              'Tb_Access.Pas',
                              'Function AddRec(' + DatF.FileName+ ')',
                               TaStatus);
  end;

{$ENDREGION}
//==========================================================================================================

END; { AddRec }


Function TDb_Methods.DeleteRecord(VAR    DatF : DataFile;
                       Const  R : LONGINT;
                       Var
                         Buffer
                      ):Boolean;

VAR
  FirstFreeAux : LONGINT;
  Wok_Set_Transaction : Boolean;
BEGIN
  Try//Except
    Try //Finally
  //    {$IFDEF TADebug} Application.Push_MsgErro('Tb_Access.DeleteRecord',ListaDeChamadas); {$ENDIF}

  {    If (Transaction<>nil) and (not ok_Set_Transaction) Then
      Begin
        If Transaction.TransactionPendant=0
        Then Transaction.Rollback
        else Begin
               Transaction.DatF.Close;
               ok := true;
             end;

        If Not ok
        Then Begin
               DeleteRecord := ok;
               exit;
             end;

      End;}

      SetTransaction(true,OK,Wok_Set_Transaction);
      if Ok
      then Begin
              IF (NOT DatF.FileModeDenyALL) THEN
              BEGIN
                IF NOT DatF.Exclusivo THEN
                  ok := TraveHeader(DatF)
                Else
                  ok := true;
                If ok Then
                  ok := ReadHeader(DatF);

                If ok and (Longint(Buffer) = 0) Then
                Begin
                  FirstFreeAux         := DatF.FirstFree;
                  DatF.FirstFree       := R;
                  Inc(DatF.NumberFree);
                  Longint(Buffer):= FirstFreeAux;
                  ok := _PutRec(DatF,R,Buffer,Tra_DeleteRec);
                  If ok Then
                    ok := PutFileHeader(DatF);
                End
                Else
                  If (Longint(Buffer) <> 0) Then
                  Begin
                    IF NOT DatF.Exclusivo THEN
                    DestraveHeader(DatF);

                    TaStatus := Erro_Tentativa_de_excluir_um_registro_excluido;
                    Ok := false;

                    Raise TException.Create(Name_Type_App_MarIcaraiV1,
                            'Tb_Access.Pas',
                            'DeleteRecord('+DatF.FileName+')',
                             TaStatus);
                  End;

                IF NOT DatF.Exclusivo THEN
                  DestraveHeader(DatF);
              END
              ELSE
              BEGIN
                If Longint(Buffer) = 0 Then
                Begin
                  FirstFreeAux    := DatF.FirstFree;
                  DatF.FirstFree  := R;
                  Inc(DatF.NumberFree);
                  Longint(Buffer) := FirstFreeAux;
                  ok := _PutRec(DatF,R,Buffer,Tra_DeleteRec);
                End
                Else
                Begin
                  TaStatus := Erro_Tentativa_de_excluir_um_registro_excluido;
//                  Application.Mi_MsgBox.MessageBox(StrMessageBox('LibAccess','DeleteRecord',DatF.F.FileName,TaStatus));
                  Ok := false;
                  Raise TException.Create(Name_Type_App_MarIcaraiV1,
                            'Tb_Access.Pas',
                            'DeleteRecord('+DatF.FileName+')',
                             TaStatus);
                End;
              END;
      End;

  Finally
    IF ok and FlushBuffer
    THEN ok := FlushFile(DatF);
    Result := ok;
  {$REGION ' ---> 2013/03/21 - Tarefa: Implementar a chamada a Rollback caso esteja dentro da transação e ocorra erro e a transação tenha sido executada na função DeleteRecord().'}
    { DONE 1 -oVersão.9.36.26.3013>e.Metodo -cMELHORIA DO CÓDIGO :
 2013/03/21. Criado em: 2013/03/21.
     � PROBLEMA: Implementar a chamada a Rollback caso esteja dentro da transação e ocorra erro e a transação tenha sido executada na função DeleteRecord().
         � CAUSA:
             � As vezes um índice fica Inconsistente.
         � SOLUÇÃO:
             � Implementar o comando Rollback todas as vezes que o comando StartTransaction for executado.
    }
       SetTransaction(False,OK,Wok_Set_Transaction);
     End;

  Except
    If Wok_Set_Transaction
    Then Rollback;

    If TaStatus = 0
    Then TaStatus := Erro_Excecao_inesperada;

    Ok := false;
    Result := ok;
    Raise TException.Create(Name_Type_App_MarIcaraiV1,
                              'Tb_Access.Pas',
                              'Function DeleteRecord(' + DatF.FileName+ ')',
                               TaStatus);
  end;

{$ENDREGION}
//==========================================================================================================
END; { DeleteRec }


Function TDb_Methods.DeleteRec(var DatF : DataFile;Const R: Longint):Boolean;
VAR
  FirstFreeAux : LONGINT;
  Wok_Set_Transaction : Boolean;
BEGIN
Try//Except
  Try //Finally
//    {$IFDEF TADebug} Application.Push_MsgErro('Tb_Access.DeleteRec',ListaDeChamadas); {$ENDIF}

{    If (Transaction<>nil) and (not ok_Set_Transaction) Then
    Begin
      If Transaction.TransactionPendant=0
      Then Transaction.Rollback
      else Begin
             Transaction.DatF.Close;
             ok := true;
           end;

      If Not ok
      Then Begin
             DeleteRec := ok;
             exit;
           end;
    End;}
    SetTransaction(true,OK,Wok_Set_Transaction);
    if Ok
    then Begin
            IF (NOT DatF.FileModeDenyALL)
            THEN BEGIN
                    IF NOT DatF.Exclusivo
                    THEN ok := TraveHeader(DatF)
                    Else Ok := true;

                    If ok Then ok := ReadHeader(DatF);
                    If ok Then ok := GetRec(DatF,R,TaRecBuf^); {Salva o antigo}

                    If ok and (TaRecBuf^.I = 0)
                    Then Begin
                            FirstFreeAux         := DatF.FirstFree;
                            DatF.FirstFree       := R;
                            Inc(DatF.NumberFree);
                            TaRecBuf^.I          := FirstFreeAux;
                            ok := _PutRec(DatF,R,TaRecBuf^,Tra_DeleteRec);
                            If Ok Then ok := PutFileHeader(DatF);
                         End
                    else If ok and (TaRecBuf^.I <> 0)
                         Then Begin
                                IF NOT DatF.Exclusivo
                                THEN DestraveHeader(DatF);

                                TaStatus := Erro_Tentativa_de_excluir_um_registro_excluido;
//                                Application.Mi_MsgBox.MessageBox(StrMessageBox('LibAccess','DeleteRec',DatF.F.FileName,TaStatus));
                                Ok := false;

                                Raise TException.Create(Name_Type_App_MarIcaraiV1,
                                        'Tb_Access.Pas',
                                        'DeleteRec('+DatF.FileName+')',
                                         TaStatus);
                              End;

                    IF NOT DatF.Exclusivo
                    THEN DestraveHeader(DatF);
                 END
            ELSE BEGIN
                    ok := GetRec(DatF,R,TaRecBuf^); {Salva o antigo}
                    If ok and (TaRecBuf^.I = 0)
                    Then Begin
                            FirstFreeAux    := DatF.FirstFree;
                            DatF.FirstFree  := R;
                            Inc(DatF.NumberFree);
                            TaRecBuf^.I     := FirstFreeAux;
                            ok := _PutRec(DatF,R,TaRecBuf^,Tra_DeleteRec);
                         End
                    else If ok and (TaRecBuf^.I <> 0)
                         Then Begin
                                TaStatus := Erro_Tentativa_de_excluir_um_registro_excluido;
//                                Application.Mi_MsgBox.MessageBox(StrMessageBox('LibAccess','DeleteRec',DatF.F.FileName,TaStatus));
                                 Ok := false;
                                Raise TException.Create(Name_Type_App_MarIcaraiV1,
                                        'Tb_Access.Pas',
                                        'DeleteRec('+DatF.FileName+')',
                                         TaStatus);
                              End;
                 END;
         end;

  Finally
    IF ok and FlushBuffer
    THEN ok := FlushFile(DatF);
    Result := ok;

  {$REGION ' ---> 2013/03/21 - Tarefa: Implementar a chamada a Rollback caso esteja dentro da transação e ocorra erro e a transação tenha sido executada na função DeleteRec().'}
    { DONE 1 -oVersão.9.36.26.3013>Function.DeleteRec -cMELHORIA DO CÓDIGO :
 2013/03/21. Criado em: 2013/03/21.
      PROBLEMA: Implementar a chamada a Rollback caso esteja dentro da transação e ocorra erro e a transação tenha sido executada na função DeleteRec().
          CAUSA:
              As vezes um índice fica Inconsistente.
          SOLUÇÃO:
              Implementar o comando Rollback todas as vezes que o comando StartTransaction for executado.
    }
        SetTransaction(False,OK,Wok_Set_Transaction);
      End;

  Except
    If TaStatus = 0
    Then TaStatus := Erro_Excecao_inesperada;

    Ok := false;
    Result := ok;
    Raise TException.Create(Name_Type_App_MarIcaraiV1,
                              'Tb_Access.Pas',
                              'Function DeleteRec(' + DatF.FileName+ ')',
                               TaStatus);
  end;

{$ENDREGION}
//==========================================================================================================

END; { DeleteRec }

FUNCTION TDb_Methods.FileLen(VAR DatF : DataFile) : LONGINT;
BEGIN
  Try
//    {$IFDEF TADebug} Application.Push_MsgErro('Tb_Access.FileLen',ListaDeChamadas); {$ENDIF}
    IF NOT  DatF.FileModeDenyALL
    THEN ok := ReadHeader(DatF)
    Else ok := true;
    If ok
    Then FileLen := DatF.NumRec
    Else FileLen := 0;

  Finally

  End;
END; { FileLen }


FUNCTION TDb_Methods.UsedRecs(VAR DatF : DataFile;OK_GetHeader : Boolean) : LONGINT;
BEGIN
  IF OK_GetHeader
  THEN  ok := ReadHeader(DatF)
  Else  ok := true;

  If ok
  Then Result := {DatF.F.FileSize}DatF.NumRec - DatF.NumberFree - 1
  Else Result  := 0;
END; { UsedRecs }

FUNCTION TDb_Methods.UsedRecs(VAR DatF : DataFile) : LONGINT;
BEGIN
  IF DatF.FileModeDenyALL
  THEN  Result := UsedRecs(DatF,False)
  Else  Result := UsedRecs(DatF,True)
END; { UsedRecs }


Type
  PageBlock = array[0..High(Longint {SmallInt})-1] OF BYTE;

 procedure TDb_Methods. TaPack(VAR Page : TaPage;
                 Const
                    KeyL : BYTE);
{Se o tamanho da chave (KeyL) FOR <> DO TamMaxChave entao ???}
VAR
  I : SmallWord;
  P : ^PageBlock;

BEGIN
  P := @Page;
  IF KeyL <> MaxKeyLen THEN
    FOR I := 1 TO PageSize DO
      MOVE(Page.ItemArray[I],
           P^[(I - 1) * (KeyL + ItemOverHead) + PageOverHead],
           KeyL + ItemOverHead);
END; { TaPack }

 procedure TDb_Methods. TaUnpack(VAR Page : TaPage; Const     KeyL : BYTE);
{Se o tamanho da chave (KeyL) FOR <> DO TamMaxChave entao ???}
VAR
  I : SmallWord;
  P : ^PageBlock;
BEGIN
  P := @Page;
  IF KeyL <> MaxKeyLen THEN
    FOR I := PageSize DOwnTO 1 DO
      MOVE(P^[(I - 1) * (KeyL + ItemOverHead) + PageOverhead],
           Page.ItemArray[I],
           KeyL + ItemOverHead);
END; { TaUnpack }


Function TDb_Methods.Multiplo_Mais_proximo_de_N(Const K,N:Longint): Longint;
{Devolve o maior multiplo de N de K }
Var i,
    Wk : Longint;
Begin
  I := 0; WK := 0;
  Repeat
//    SysCtrlSleep(0);
   If ((K+i) Mod N) = 0 Then
      Wk := K+i;
    Inc(i);
  Until Wk <> 0;

  If Wk <=  Sizeof(TaStackRec)
  Then Multiplo_Mais_proximo_de_N := Wk
  Else Multiplo_Mais_proximo_de_N := K;
End;

Function TDb_Methods.MakeIndex(var IxF : IndexFile;Const FName : FileName;Const KeyLen,S : byte):Integer;

  VAR
    K : SmallWord;
    Wok_Set_Transaction : Boolean;

BEGIN
  Try //Except
    Try
//      SetTransaction(true,OK,Wok_Set_Transaction); //Não posso colocar MakeIndex na transação porque a transação Não controla arquivos deletados.
      If  Not Is_TFileOpen(IxF.DataF.F) //and ok
      Then Begin
             K := (KeyLen + ItemOverHead) * PageSize + PageOverhead;
  {           K := Multiplo_Mais_proximo_de_N(K,BlockSize_DatF);}

             WITH IxF,IxF.DataF DO
             BEGIN
                AssignIndexFile(IxF,FName,Sizeof(TsImagemHeader),K,FileMode or StCreate);

                IxF.DataF.F.Rewrite(FileMode or StCreate);

                IF TaStatus<>0 THEN
                BEGIN
                  TaIOcheck(IxF.DataF,0);
                  Discard(TObject(IxF.DataF.F));
                  Abort;
                END;

                IF KeyLen > MaxKeyLen THEN
                Begin
                  TaStatus := KeyTOoLarge;
                  TAIOcheck(DataF, 0);
                  Discard(TObject(IxF.DataF.F));
                  Abort;
                End;

                FilesOpens.Insert(@IxF);
                WriteHeaderMakeFile(IxF.DataF);
                IxF.AllowDuplKeys := S <> NoDuplicates;
                IxF.KeyL          := KeyLen;
             END;
           End
      Else Begin
             Ok := false;
             If TaStatus=0
             Then TaStatus := ErrorTentativa_de_abrir_um_arquivo_aberto;
           end;

    Finally
      Result:= TaStatus;
      If Result=0
      Then IxF.OkDeveIndexar  := True;

  {$REGION ' ---> 2013/03/21 - Tarefa: Implementar a chamada a Rollback caso esteja dentro da transação e ocorra erro e a transação tenha sido executada na função MakeIndex().'}
    { DONE 1 -oVersão.9.36.26.3013>e.Metodo -cMELHORIA DO CÓDIGO :
 2013/03/21. Criado em: 2013/03/21.
     � PROBLEMA: Implementar a chamada a Rollback caso esteja dentro da transação e ocorra erro e a transação tenha sido executada na função MakeIndex().
         � CAUSA:
             � As vezes um índice fica Inconsistente.
         � SOLUÇÃO:
             � Implementar o comando Rollback todas as vezes que o comando StartTransaction for executado.
    }
//       SetTransaction(false,OK,Wok_Set_Transaction);
     End;

  Except
    If TaStatus = 0
    Then TaStatus := Erro_Excecao_inesperada;

    Ok := false;
    Result := TaStatus;
    Raise TException.Create(Name_Type_App_MarIcaraiV1,
                              'Tb_Access.Pas',
                              'Function MakeIndex(' + IxF.DataF.FileName+ ')',
                               TaStatus);
  end;

{$ENDREGION}
//==========================================================================================================

END; { MakeIndex }

Function TDb_Methods.TMakeIndex(var IxF : ConfigIndexFile):Integer;
{  Var
    Wok , Wok_Set_Transaction : Boolean;}

begin
  Try
//    {$IFDEF TaDebug}Application.Push_MsgErro('Tb_Access.TMakeIndex',ListaDeChamadas);{$ENDIF}
{    If (Not OkCreateTransaction) and (Transaction<>nil) and (not ok_Set_Transaction)
    Then Begin
           If Transaction.TransactionPendant=0
           Then TaStatus := Transaction.Rollback
           else Begin
                  Transaction.DatF.Close;
                  TaStatus := 0;
                End;

           If TaStatus<>0
           Then  Abort;
         End;}

    with IxF,Ix,DataF do
    If Not Is_TFileOpen(F)
    Then begin {  if FileRec(F).Mode = FmClosed then}
           If DelFile(NomeArqIndice)
           Then Begin
                  TaStatus := MakeIndex(Ix,NomeArqIndice,TamChave,RepeteChave);
                  If TaStatus = 0
                  Then Begin
                         TCloseIndex(IxF);
                         TaStatus := TOpenIndex(IxF);
                       End;
                End;
         End
    Else TaStatus := ErrorTentativa_de_abrir_um_arquivo_aberto;

  Finally
    If TaStatus <> 0
    Then Raise TException.Create(Name_Type_App_MarIcaraiV1,
                                 'Tb_Access.Pas',
                                 'TMakeIndex('+IxF.Ix.DataF.FileName+')',
                                  TaStatus);
    Result := TaStatus;
    ok     := Result=0;


  end;

end;

Function TDb_Methods.FMakeIndex(Const FileName:PathStr;
                    Const RepeteChave,
                          TamChave:Byte):Integer;
Var ArqI : ConfigIndexFile;
Begin
  Try
//    {$IFDEF TaDebug}Application.Push_MsgErro('Tb_Access.FMakeIndex',ListaDeChamadas);{$ENDIF}

    InicArqIndice(1,ArqI,FileName,RepeteChave,'1,'+IStr(TamChave,'99')+'.');
    Result := TMakeIndex(ArqI);
    If Result = 0
    Then TCloseIndex(ArqI);

  Finally

  end;
End;

Function TDb_Methods.OpenIndex(var   IxF : IndexFile;Const FName : FileName;Const KeyLen,S : byte):Integer;
  VAR
    K : Word;
    Wok_Set_Transaction : Boolean;

   Function Del_Index_e_MakeIndex:Boolean;
   Begin
     Discard(TObject(IxF.DataF.F));
     DeleteFile(FName);
     TaStatus := MakeIndex(IxF,FName,KeyLen,S);
     Result := TaStatus = 0;
   end;

BEGIN
  try //Except
    Try //finally
  //    {$IFDEF TADebug} Application.Push_MsgErro('Tb_Access.OpenIndex',ListaDeChamadas); {$ENDIF}

//      SetTransaction(true,OK,Wok_Set_Transaction);
      If (Not Is_TFileOpen(IxF.DataF.F)) // and ok
      Then
      BEGIN
        K := (KeyLen + ItemOverHead) * PageSize + PageOverhead;
  {      K := Multiplo_Mais_proximo_de_N(K,BlockSize_DatF);}

  {     If IxF.DataF.OkTemporario
        Then Begin
               AssignIndexFile(IxF,FName,Sizeof(TsImagemHeader),K,FileMode or FmMemory);
               IxF.DataF.F.Reset(FileMode or FmMemory);
             end
        Else}
             Begin
               AssignIndexFile(IxF,FName,Sizeof(TsImagemHeader),K,FileMode);
               IxF.DataF.F.Reset(FileMode);
             end;
        ok := TaStatus = 0;

        IF TaStatus <> 0 THEN
        BEGIN
          Application.Mi_MsgBox.MessageBox(StrMessageBox(Name_Type_App_MarIcaraiV1,
                                   'Tb_Access',
                                   'Function OpenIndex('+FName+')',
                                    TurboError(TaStatus)));
          Ok := Del_Index_e_MakeIndex;
          Exit;
        END;


        IF ok and (KeyLen > MaxKeyLen) THEN
        Begin
          TaStatus := REC_TOO_LARGE;
          TaIOcheck(IxF.DataF,0);
          Application.Mi_MsgBox.MessageBox(StrMessageBox(Name_Type_App_MarIcaraiV1,
                                   'Tb_Access',
                                   'Function OpenIndex('+FName+')',
                                    TurboError(TaStatus)));

          Ok := Del_Index_e_MakeIndex;
          Exit;
        End;

        {Inicializa a coleção de registros travados}

        Try
          If Ok
          Then ok := ReadHeader(IxF.DataF);
          If (Not ok)
          Then Begin
                 If (TaStatus=0)
                 Then TaStatus := ErroDeLeituraEmDisco;
                 exit;
               End;
        Except
          Ok := Del_Index_e_MakeIndex;
          Exit;
        End;

        IF ok And  (K <> IxF.DataF.ItemSize) THEN
        BEGIN
          TaStatus := KeySizeMismatch;
          TaIOcheck(IxF.DataF,0);
          Application.Mi_MsgBox.MessageBox(StrMessageBox(Name_Type_App_MarIcaraiV1,
                                   'Tb_Access',
                                   'Function OpenIndex('+FName+')',
                                    TurboError(TaStatus)));

          Ok := Del_Index_e_MakeIndex;
          Exit;
        END;

        IxF.AllowDuplKeys := S <> NoDuplicates;
        IxF.KeyL          := KeyLen;
  {      IxF.DataF.RR      := IxF.DataF.RR;}
        IxF.PP            := 0;

      END
      ELSE
      Begin
        If TaStatus=0
        Then TaStatus := ErrorTentativa_de_abrir_um_arquivo_aberto;
        TaIOcheck(IxF.DataF,0);
      End;

    Finally
      If TaStatus = 0
      Then FilesOpens.Insert(@IxF);

      If TaStatus <> 0
      Then  Application.Mi_MsgBox.MessageBox(StrMessageBox('',
                                     'Tb_Access',
                                     'Function OpenIndex('+FName+')',
                                     TurboError(TaStatus)));
      Result := TaStatus;
      Ok     := TaStatus = 0;

  {$REGION ' ---> 2013/03/21 - Tarefa: Implementar a chamada a Rollback caso esteja dentro da transação e ocorra erro e a transação tenha sido executada na função OpenIndex().'}
    { DONE 1 -oVersão.9.36.26.3013>Function.OpenIndex -cMELHORIA DO CÓDIGO :
 2013/03/21. Criado em: 2013/03/21.
     � PROBLEMA: Implementar a chamada a Rollback caso esteja dentro da transação e ocorra erro e a transação tenha sido executada na função OpenIndex().
         � CAUSA:
             � As vezes um índice fica Inconsistente.
         � SOLUÇÃO:
             � Implementar o comando Rollback todas as vezes que o comando StartTransaction for executado.
    }
//        SetTransaction(False,OK,Wok_Set_Transaction);
      End;

  Except
    If TaStatus = 0
    Then TaStatus := Erro_Excecao_inesperada;

    Ok := false;
    Result := TaStatus;
    Raise TException.Create(Name_Type_App_MarIcaraiV1,
                              'Tb_Access.Pas',
                              'Function OpenIndex(' + IxF.DataF.FileName+ ')',
                               TaStatus);
  end;

{$ENDREGION}
//==========================================================================================================

END; { OpenIndex }

Function TDb_Methods.TOpenIndex(var IxF : ConfigIndexFile ):Integer;
var
{  MsgLinha : TipoLinhaTela;
  X,Y      : Byte;}
  Existe   : Boolean;
{  WindMinAux,WindMaxAux : SmallWord;}
begin
  Try
//    {$IFDEF TaDebug}Application.Push_MsgErro('Tb_Access.TOpenIndex',ListaDeChamadas);{$ENDIF}

    If Not IxF.Ix.DataF.OkTemporario
    Then Existe := FileExists(IxF.NomeArqIndice)
    Else Existe := true; {Os arquivos temporários são criados na RAM por isso sempre existe deve sr = true}

    with IxF,Ix,DataF do
    if Not Is_TFileOpen(F) and Existe
    then Result := OpenIndex(Ix,NomeArqIndice,TamChave,RepeteChave)
    else Begin { Status = Fechado and Existe arquivo }
           if Existe
           then TaStatus := 0
           else TaStatus := ArquivoNaoEncontrado2;
         End;

 Finally
   Result := TaStatus;
   Ok     := Result = 0;


 end;
end;

 procedure TDb_Methods. LeiaHeaderDoIndice( VAR IxF       : IndexFile);
VAR
  KeyLen,S : BYTE;
BEGIN
//  {$IFDEF TADebug}  Application.Push_MsgErro('Tb_Access.LeiaHeaderDoIndice',ListaDeChamadas);  {$ENDIF}
  FlushIndex(IxF);
  KeyLen := IxF.KeyL;
  IF NOT IxF.AllowDuplKeys
  THEN S := 0
  ELSE s := 1;

  ok := ReadHeader(IxF.DataF);
  If ok Then
  WITH IxF, DataF DO
  BEGIN
    IxF.AllowDuplKeys := S <> NoDuplicates;
    IxF.KeyL := KeyLen;
{    IxF.RR := IxF.DataF.Int1;}
    IxF.PP := 0;
  END;


END;


Function TDb_Methods.aCloseIndex(VAR IxF : IndexFile):boolean;
BEGIN
  FlushIndex(IxF);
  ok := aCloseFile(Ixf.DataF);
  Result := ok;
END; { CloseIndex }

Function TDb_Methods.CloseIndex(VAR IxF : IndexFile;OkCondicional:Boolean):boolean;Overload;

  Function _CloseIndex:Boolean;
  Begin
    If FilesOpens <> nil
    Then Begin
           If FilesOpens.IndexOf(@IxF) <> -1
           Then FilesOpens.Free(@IxF)
           Else ok := aCloseIndex(IxF);
         End
    Else ok := true;
    Result := ok;
  end;

BEGIN
  TaStatus := 0;

{  Try}
    Try
//      {$IFDEF TADebug} Application.Push_MsgErro('Tb_Access.CloseFile',ListaDeChamadas); {$ENDIF}
      TaStatus := 0;
      If Is_TFileOpen(IxF.DataF.F)
      Then Begin
             If OkCondicional
             Then Begin
                    If IxF.DataF.F.GetDriveType <> dt_Memory_Stream
                    Then Result := _CloseIndex;
                  End
             Else Result := _CloseIndex;
           End
      Else Result := true;

    Finally

    End;

{  Except

  end;}

END; { CloseIndex }

Function TDb_Methods.CloseIndex(VAR IxF : IndexFile):boolean;Overload;
Begin
  CloseIndex(IxF,False);
end;

Function TDb_Methods.TCloseIndex(var IxF : ConfigIndexFile ):boolean;
begin
  TaStatus := 0;
  with IxF,Ix,DataF do
  if Is_TFileOpen(F) then
  begin
    ok := CloseIndex(Ix);
  end
  else ok := true;
  TCloseIndex := ok;
end;

Function TDb_Methods.FlushIndex(VAR IxF       : IndexFile):boolean;
BEGIN
  TaStatus := 0;
  Ok       :=  FlushFile(IxF.DataF);
  Result   := ok;
END; { FlushIndex }


Function TDb_Methods.EraseFile(VAR DatF : DataFile):boolean;
BEGIN
  Try
//    {$IFDEF TADebug}  Application.Push_MsgErro('Tb_Access.EraseFile',ListaDeChamadas);  {$ENDIF}
    Tb_Access.CloseFile(DatF); {Fecha o arquivo se tiver aberto}
    Result := DelFile(DatF.Filename);
  Finally

  End;
END; { EraseFile }

Function TDb_Methods.EraseIndex(VAR IxF : IndexFile):boolean;
BEGIN
//  {$IFDEF TADebug}  Application.Push_MsgErro('Tb_Access.EraseIndex',ListaDeChamadas);  {$ENDIF}

  Result := EraseFile(IxF.DataF);


END; { EraseIndex }


Function TDb_Methods.TaGetPage(VAR IxF  : IndexFile;
                    Const
                        R     : LONGINT;
                    VAR PgPtr : TaPagePtr):boolean;
BEGIN
  Try {Finally}
//    Try {Except}
      ok := GetRec(IxF.DataF,R,PgPtr);
{$REGION ' ---> 2013-01-25 - Tarefa: Checar porque � situação que � lido uma página deletada.'}
  { TODO 4 -oVersão.9.35.25.2240>Function TaGetPage -cMELHORIA DO CÓDIGO :
 2013/01/25. Criado em: 2013-01-25.
   � Checar porque as vezes um registro deletado.

            //And (PgPtr.Reservado.NRecAnt=0); Existe uma situação em que se ler uma página deletada.
    if PgPtr.Reservado.NRecAnt <>0
    then begin
           WriteLn('Leitura de pagina deletada');
       end;
  }
    if ok
    then begin
           ok := (PgPtr.Reservado.NRecAnt=0); //Existe uma situação em que se ler uma página deletada.
            if not ok
            then begin
                   //WriteLn('ATENção: Tem algo errado porque houve a leitura de pagina deletada!!!!');
                   Raise TException.Create(Name_Type_App_MarIcaraiV1,
                                    'Tb_Access.Pas',
                                    'TaGetPage',
                                    sgc('ATENção: Tem algo errado na estrutura do arquivo de índice porque houve a leitura de página do índice deletada!!!!') );
               end;
         end;

{$ENDREGION}
//==========================================================================================================

      If ok
      Then TaUnpack(PgPtr,IxF.KeyL);


{    Except
      ok       := false;
      If TaStatus = 0
      Then TaStatus := Erro_Excecao_inesperada;

      Raise TException.Create(Name_Type_App_MarIcaraiV1,
                              'Tb_Access.Pas',
                              'Function TaGetPage(' + Ixf.DataF.FileName+ ')',
                               TaSTatus);

    end;}


  Finally
    Result := ok;
  End;

END; { TaGetPage }

 procedure TDb_Methods. TaNewPage(VAR IxF  : IndexFile;
                    VAR R     : LONGINT;
                    VAR PgPtr : TaPagePtr);
BEGIN
  PgPtr.Reservado.NRecAnt := 0;
  NewRec(IxF.DataF,R); {Obs. o Novo R esta na Memória ???}
END; { TaNewPage }

procedure TDb_Methods. TaUpdatePage(VAR IxF  : IndexFile;
                       VAR R     : LONGINT;
                       VAR PgPtr : TaPagePtr;
                       Const Transaction_Current : T_TTransaction);
BEGIN
//  Try
    TaPack(PgPtr,IxF.KeyL);
    _PutRec(IxF.DataF,R,PgPtr,Transaction_Current);
//    If Not ok Then abort;

{  Except
    ok       := false;
    If TaStatus = 0
    Then TaStatus := Erro_Excecao_inesperada;
    Application.Mi_MsgBox.MessageBox(StrMessageBox(Name_Type_App_MarIcaraiV1,
                             'Tb_Access',
                             ' procedure TDb_Methods. TaUpdatePage(' + Ixf.DataF.FileName+ ')',TaStatus));
    Abort;
  end;}
END; { TAUpdatePage }


 procedure TDb_Methods.TaDeletePage(var IxF : IndexFile; VAR R     : LONGINT; VAR PgPtr : TaPagePtr);
BEGIN
    FlushIndex(Ixf);
    If not ok
    Then  Raise TException.Create(Name_Type_App_MarIcaraiV1,
                            'Tb_Access.Pas',
                            'TaDeletePage('+Ixf.DataF.FileName+')',
                             sgc('Algo errado flushFile retortou false!'));

    DeleteRec(IxF.DataF,R);
    If Not ok
    Then abort; //se Não conseguiu deletar então aborta.
END; // TaDeletePage


 procedure TDb_Methods.ClearKey(VAR IxF : IndexFile);
BEGIN
  IF NOT IxF.DataF.FileModeDenyALL
  THEN LeiaHeaderDoIndice(IxF);
  IxF.PP := 0;
  IxF.OkBof_ix := TRUE;
  IxF.OkEof_ix := false;
END;

Function TDb_Methods.NextKey(VAR IxF       : IndexFile;
                 VAR DataRecNum : LONGINT;
                 VAR ProcKey                ):Boolean;
VAR
  R      : LONGINT;
  PagPtr : TaPagePtr;
BEGIN
  IxF.NextKey_pages_Reads := 0;
  Try  {Finally}
    IF IxF.PP = 0
    THEN R := IxF.DataF.RR { Inicio do arquivo ( Primeira chave ) }
    ELSE BEGIN
           TaGetPage(IxF,IxF.Path[IxF.PP].PageRef,PagPtr);
           if ok
           then IxF.NextKey_pages_Reads := IxF.NextKey_pages_Reads +1;

           R := PagPtr.ItemArray[IxF.Path[IxF.PP].ItemArrIndex].PageRef;

         END;

    WHILE R <> 0 DO
    BEGIN
      Inc(IxF.PP);
      IxF.Path[IxF.PP].PageRef      := R;
      IxF.Path[IxF.PP].ItemArrIndex := 0;
      TaGetPage(IxF,R,PagPtr);
      if ok
      then IxF.NextKey_pages_Reads := IxF.NextKey_pages_Reads +1;

      R := PagPtr.BckwPageRef;
    END;

    IF IxF.PP <> 0
    THEN BEGIN
           WHILE (IxF.PP > 1 ) and (IxF.Path[IxF.PP].ItemArrIndex = PagPtr.ItemsOnPage) DO
           BEGIN
             IxF.PP := IxF.PP - 1;
             TaGetPage(IxF,IxF.Path[IxF.PP].PageRef,PagPtr);
             if ok
             then IxF.NextKey_pages_Reads := IxF.NextKey_pages_Reads +1;
           END;

      IF IxF.Path[IxF.PP].ItemArrIndex < PagPtr.ItemsOnPage
      THEN BEGIN
             Inc(IxF.Path[IxF.PP].ItemArrIndex);
             WITH PagPtr.ItemArray[IxF.Path[IxF.PP].ItemArrIndex] DO
             BEGIN
               TaKeyStr(ProcKey) := Key;
               DataRecNum        := DataRef;
             END;
           END
      ELSE IxF.PP := 0;
    END;

  Finally
    If ok
    Then OK := IxF.PP <> 0;
    Result := ok;

    IxF.OkEof_ix := not ok;
  End;
END; { NextKey }

Function TDb_Methods.PrevKey(var IxF : IndexFile;
                  var DataRecNum : Longint;
                  var ProcKey ):Boolean;

VAR
  R      : LONGINT;
  PagPtr : TaPagePtr;

BEGIN
  Try
    WITH IxF DO
    BEGIN
      PrevKey_pages_Reads := 0;
      IF PP = 0 THEN
        R := DataF.RR
      ELSE
        WITH Path[PP] DO
        BEGIN

          TaGetPage(IxF,PageRef,PagPtr);
          if ok
          then PrevKey_pages_Reads := PrevKey_pages_Reads +1;


          ItemArrIndex := ItemArrIndex - 1;
          IF ItemArrIndex = 0
          THEN R := PagPtr.BckwPageRef
          ELSE R := PagPtr.ItemArray[ItemArrIndex].PageRef;
        END;

      WHILE R <> 0 DO
      BEGIN

          TaGetPage(IxF,R,PagPtr);
           if ok
           then PrevKey_pages_Reads := PrevKey_pages_Reads +1;

        Inc(PP);
        WITH Path[PP] DO
        BEGIN
          PageRef := R;
          ItemArrIndex := PagPtr.ItemsOnPage;
        END;
        WITH PagPtr DO
          R := ItemArray[ItemsOnPage].PageRef;
      END;

      IF PP <> 0 THEN
      BEGIN
        WHILE (PP > 1) and (Path[PP].ItemArrIndex = 0) DO
        BEGIN
          PP := PP - 1;

          TaGetPage(IxF,Path[PP].PageRef,PagPtr);
          if ok
          then PrevKey_pages_Reads := PrevKey_pages_Reads +1;

        END;

        IF Path[PP].ItemArrIndex > 0 THEN
          WITH PagPtr.ItemArray[Path[PP].ItemArrIndex] DO
          BEGIN
            TaKeyStr(ProcKey) := Key;
            DataRecNum := DataRef;
          END
        ELSE
          PP := 0;
      END;
      OK := PP <> 0;
    END;

  Finally
    PrevKey := ok;
    IxF.OkBof_ix := not ok;
  end;

END; { PrevKey }

 procedure TDb_Methods. TaXKey(VAR K:TaKeyStr; Const KeyL : BYTE);
BEGIN
  IF Length(TaKeyStr(K)) > KeyL THEN
    TaKeyStr(K)[0] := AnsiChar(KeyL);

END; {8 TaXKey }


FUNCTION TDb_Methods.TaCompKeys(Const K1 ,K2; DR1,DR2 : LONGINT; Const Dup : BOOLEAN ) : Shortint;
{Rotina tirada da Internet em 29/10/96
 Documento  TI426 - DataBase ToolBox
}
BEGIN
  IF TaKeyStr(K1) = TaKeyStr(K2) THEN
  Begin
    IF Not Dup or (DR1=DR2) THEN
      TaCompKeys := 0
    ELSE
      IF DR1 > DR2 Then
        TaCompKeys := 1
      ELSE
        TaCompKeys := -1
  END
  ELSE
  IF TaKeyStr(K1) > TaKeyStr(K2) THEN
    TaCompKeys := 1
  ELSE
    TaCompKeys := -1;
END;

(*
FUNCTION TaCompKeys(VAR K1 ,K2; DR1,DR2 : LONGINT; Dup : BOOLEAN ) : LONGINT;
 {Esta rotina tem problemas com chaves duplicadas.
 Isso acontece com registros acima de 32k}

BEGIN
  IF TaKeyStr(K1) = TaKeyStr(K2) THEN
    IF Dup THEN
      TaCompKeys := DR1 - DR2
    ELSE
      TaCompKeys := 0
  ELSE
  IF TaKeyStr(K1) > TaKeyStr(K2) THEN
    TaCompKeys := 1
  ELSE
    TaCompKeys := -1;
END;
*)

Function TDb_Methods.TaFindKey(VAR IxF       : IndexFile;
                    VAR DataRecNum : LONGINT;
                    VAR ProcKey                ):boolean;
VAR
  PrPgRef   : LONGINT;
  C         : Shortint;
  K,L,R     : SmallInt;
  PagPtr    : TaPagePtr;
  okFind    : BOOLEAN;
BEGIN
//  {$IFDEF TaDebug}Application.Push_MsgErro('Tb_Access.TaFindKey',ListaDeChamadas);{$ENDIF}
  WITH IxF DO
  BEGIN
    TaFindKey_pages_Reads := 0;
    TaXKey(TaKeyStr(ProcKey),KeyL);
    OKFind := false;
    PP := 0;
    PrPgRef := DataF.RR;

    WHILE (PrPgRef <> 0) and NOT OKFind DO
    BEGIN
      Inc(PP);
      Path[PP].PageRef := PrPgRef;

        TaGetPage(IxF,PrPgRef,PagPtr);
        if ok
        then TaFindKey_pages_Reads := TaFindKey_pages_Reads +1;

      WITH PagPtr DO
      BEGIN
        L := 1;
        R := ItemsOnPage;
        REPEAT
//          SysCtrlSleep(0);
          K := (L + R) div 2;
          C := TaCompKeys(TaKeyStr(ProcKey),
                          ItemArray[K].Key,
                          0,
                          ItemArray[K].DataRef,
                          AllowDuplKeys   );
          IF C <= 0 THEN R := K - 1;
          IF C >= 0 THEN L := K + 1;
        UNTIL R < L;

        IF L - R > 1 THEN
        BEGIN
          DataRecNum := ItemArray[K].DataRef;
          R          := K;
          OKFind     := true;
        END;

        IF R = 0
        THEN PrPgRef := BckwPageRef
        ELSE PrPgRef := ItemArray[R].PageRef;
      END;
      Path[PP].ItemArrIndex := R;
    END;

    IF NOT OKFind and (PP > 0) THEN
    BEGIN
      WHILE (PP > 1) and (Path[PP].ItemArrIndex = 0) DO
        PP := PP - 1;
      IF Path[PP].ItemArrIndex = 0 THEN
        PP := 0;
    END;
  END;

  ok := OKFind;
  TaFindKey := ok;

  IxF.OkBof_ix := false;
  IxF.OkEof_ix := false;


END; { TAFindKey }

Function TDb_Methods.FindKey(var IxF : IndexFile;var DataRecNum : Longint;var ProcKey ):Boolean;
  VAR
    TempKey   : TaKeyStr;
BEGIN
  Try
    taKeyStr(ProcKey) := AnsiUpperCase(String_Asc_Console_to_Asc_Ingles(taKeyStr(ProcKey)));

    IF NOT IxF.DataF.FileModeDenyALL
    THEN LeiaHeaderDoIndice(IxF)
    Else ok := true;

    If ok Then
    Begin
      TaFindKey(IxF,DataRecNum,TaKeyStr(ProcKey));
      IF (NOT OK) and IxF.AllowDuplKeys and (taStatus=0) THEN
      BEGIN
        TempKey := TaKeyStr(ProcKey);
        NextKey(IxF,DataRecNum,TaKeyStr(ProcKey));
        OK := OK and (TaKeyStr(ProcKey) = TempKey);
      END;
    End;

  Finally
    FindKey := ok;

  End;
END; { FindKey }

Function TDb_Methods.FindKeyTop(var IxF : IndexFile;var DataRecNum : Longint;var ProcKey ):Boolean;
  { Retorna o número do registro da chave da ultima ocorrência repetida
    se o index permite chave duplicada.
  }
Var
  wKeyCurrent : TaKeyStr;
Begin
  taKeyStr(ProcKey) := AnsiUpperCase(String_Asc_Console_to_Asc_Ingles(taKeyStr(ProcKey)));

  Result := FindKey(IxF,DataRecNum,ProcKey);
  If Result and (Not IxF.AllowDuplKeys)
  Then Begin
         wKeyCurrent := TaKeyStr(ProcKey);
         Repeat {Pesquisa o ultimo repetido}
//           SysCtrlSleep(0);
           ok := NextKey(IxF ,DataRecNum,ProcKey);
           If ok
           Then Ok := WKeyCurrent=TaKeyStr(ProcKey);
         Until Not ok;
         Result := PrevKey(IxF ,DataRecNum,ProcKey);
       End;


End;

Function TDb_Methods.SearchKey(var IxF : IndexFile;
                   var DataRecNum : Longint;
                   var ProcKey:TaKeyStr):Boolean;
   Var
     WBufSize  : Longint;
//==========================================================================================================
{$REGION ' ---> Tarefa: SearchKey Não deve alterar o número do registro nem a chave caso a pesquisa seja false.'}
//==========================================================================================================

  { DONE 1 -oTb_Access.SearchKey -cMELHORIA NO CÓDIGO :
 20111/02/24. Criado em: 2011/02/24.
   � SearchKey Não deve alterar o número do registro nem a chave caso a pesquisa seja false.
  }
   Var
     wDataRecNum : Longint;
     wProcKey    : TaKeyStr;

{$ENDREGION}
//==========================================================================================================

BEGIN
  Try
    ProcKey := AnsiUpperCase(String_Asc_Console_to_Asc_Ingles(ProcKey));

    IF NOT IxF.DataF.FileModeDenyALL
    THEN LeiaHeaderDoIndice(IxF)
    else ok := true;

    If Ok
    Then Begin
           wDataRecNum := 0;
           wProcKey    := ProcKey;

           TaFindKey(IxF,wDataRecNum,wProcKey);

           IF (NOT OK) and (TaStatus=0)
           THEN NextKey(IxF,wDataRecNum,wProcKey);

           if ok
           then Begin
                   DataRecNum := wDataRecNum;
                   ProcKey    := wProcKey;
                End;
         End;
  Finally
    SearchKey := ok;
  End;
END; { SearchKey }


Function TDb_Methods.SearchKeyTop(var IxF : IndexFile; var DataRecNum : Longint; var ProcKey:TaKeyStr;Const Okequal : Boolean):Boolean;
  { Retorna o número do registro da chave da ultima ocorrência repetida
    se o index permite chave duplicada.
  }
Var
  WProcKey,
  wKeyCurrent : TaKeyStr;
Begin
  ProcKey := AnsiUpperCase(String_Asc_Console_to_Asc_Ingles(ProcKey));

  WProcKey := TaKeyStr(ProcKey);
  Result := SearchKey(IxF,DataRecNum,ProcKey);
  If Result
  Then If Okequal
       Then Result := Copy(TaKeyStr(ProcKey),1,Byte(TaKeyStr(wProcKey)[0])) = wProcKey
       else Result := TaKeyStr(ProcKey)= wProcKey;

  If Result and (Not IxF.AllowDuplKeys)
  Then Begin
         Repeat {Pesquisa o ultimo repetido}
//           SysCtrlSleep(0);
           ok := NextKey(IxF ,DataRecNum,ProcKey);
           If ok
           Then If Okequal
                Then ok := Copy(TaKeyStr(ProcKey),1,Byte(TaKeyStr(wProcKey)[0])) = wProcKey
                Else ok := TaKeyStr(ProcKey) = wProcKey;
         Until Not ok;
         Result := PrevKey(IxF ,DataRecNum,ProcKey);{Posiciona no anterior}
       End;
  ok := Result;
End;

   procedure TDb_Methods. AddKey_Search_Insert(
                    var IxF : IndexFile;
                    Var PrPgRef1 : LONGINT;
                    VAR PrPgRef2,c : LONGINT;

                    VAR PagePtr1,PagePtr2  : TaPagePtr;
                    VAR ProcItem1, ProcItem2 : TaItem;
                    vAR PassUp, okAddKey  : BOOLEAN;
                    Const ProcKey    : TaKeyStr;
                    Const DataRecNum : Longint;
                    VAR K,L     : SmallInt;
                    Var R : SmallInt


                   );
    VAR
      i : Longint {SmallInt};
  BEGIN
    TaGetPage(IxF,PrPgRef1,PagePtr1);

    WITH PagePtr1 DO
    BEGIN
      IF ItemsOnPage < PageSize THEN
      BEGIN  {Insere  a chave na página}
        Inc(ItemsOnPage);
        FOR I := ItemsOnPage DOwnTO R + 2 DO
          ItemArray[I] := ItemArray[I - 1]; {Abre a posição para inserção}
        ItemArray[R + 1] := ProcItem1;
        PassUp := false;
      END
      ELSE
      BEGIN {Insere nova página}
        TaNewPage(IxF,PrPgRef2,PagePtr2);
        If Not ok
        Then abort;//exit;

        IF R <= Order
        THEN BEGIN  {Insere a chave abaixo DO orde (Metade) }
                IF R = Order
                THEN ProcItem2 := ProcItem1
                ELSE BEGIN
                       ProcItem2 := ItemArray[Order];
                       FOR I := Order DOwnTO R + 2 DO ItemArray[I] := ItemArray[I - 1];
                       ItemArray[R + 1] := ProcItem1;
                     END;

                FOR I := 1 TO Order DO PagePtr2.ItemArray[I] := ItemArray[I + Order];
              END
        ELSE  BEGIN
                R := R - Order;
                ProcItem2 := ItemArray[Order + 1];
                FOR I := 1 TO R - 1 DO  PagePtr2.ItemArray[I] := ItemArray[I + Order + 1];
                PagePtr2.ItemArray[R] := ProcItem1;
                FOR I := R + 1 TO Order DO PagePtr2.ItemArray[I] := ItemArray[I + Order];
              END;

        ItemsOnPage          := Order;
        PagePtr2.ItemsOnPage := Order;
        PagePtr2.BckwPageRef := ProcItem2.PageRef;
        ProcItem2.PageRef    := PrPgRef2;
        ProcItem1            := ProcItem2;

        TaUpdatePage(IxF,PrPgRef2,PagePtr2,Tra_AddRec);
      END;
    END;
    TaUpdatePage(IxF,PrPgRef1,PagePtr1,Tra_PutRec);
  END; { Insert }

   procedure TDb_Methods. AddKey_Search_Init_ProcItem1(Const ProcKey    : TaKeyStr;
                                         Const DataRecNum : Longint;
                                         vAR PassUp : BOOLEAN; VAR ProcItem1 : TaItem);
  Begin
    PassUp   := true;
    WITH ProcItem1 DO {Atualiza os dados da chave para se inserida em insert}
    BEGIN
      Key      := TaKeyStr(ProcKey);
      DataRef  := DataRecNum;
      PageRef  := 0;
    END;
  end;

 procedure TDb_Methods. AddKey_Search(var IxF : IndexFile;
                 PrPgRef1 : LONGINT;
                 VAR PrPgRef2,c : LONGINT;

                 VAR PagePtr1,PagePtr2  : TaPagePtr;
                 VAR ProcItem1, ProcItem2 : TaItem;
                 vAR PassUp, okAddKey  : BOOLEAN;
                 Const ProcKey    : TaKeyStr;
                 Const DataRecNum : Longint;
                 VAR K,L     : SmallInt
                 );
VAR
  R : SmallInt;

BEGIN { Search }
  IF PrPgRef1 = 0
  THEN BEGIN {Primeira chave}
//         Init_ProcItem1;
         AddKey_Search_Init_ProcItem1(ProcKey,
                                      DataRecNum,
                                      PassUp,
                                      ProcItem1);
        exit;
       END
  ELSE BEGIN {Nao e a primeira chave}
         TaGetPage(IxF,PrPgRef1,PagePtr1) ;
         WITH PagePtr1 DO
         BEGIN
            L := 1;
            R := ItemsOnPage;
            REPEAT {Pesquisa binaria para encontrar a posição da chave na página}
              K := (L + R) div 2;

              If K > 0 Then {GCICSoft. Quando tem algum problema no disco K fica zero 0 Não sei porque}
              C := TaCompKeys(TaKeyStr(ProcKey),
                              ItemArray[K].Key,
                              DataRecNum,
                              ItemArray[K].DataRef,
                              IxF.AllowDuplKeys   );
              IF C <= 0 THEN R := K - 1;
              IF C >= 0 THEN L := K + 1;
            UNTIL R < L;

            IF L - R > 1
            THEN BEGIN
                   OK := false; //13/02/2008 coloquei porque o original tem
                   okAddKey := false;
                   PassUp := false;
                 END
            ELSE BEGIN
{                     IF R = 0
                   THEN Search(BckwPageRef)
                   ELSE Search(ItemArray[R].PageRef);}

                   IF R = 0
                   THEN begin
                          AddKey_Search( IxF,
                                       BckwPageRef,//PrPgRef1,
                                       PrPgRef2,
                                       c,
                                       PagePtr1,
                                       PagePtr2,
                                       ProcItem1,
                                       ProcItem2,
                                       PassUp,
                                       okAddKey,
                                       ProcKey,
                                       DataRecNum,
                                       K,L);
                        end
                   ELSE Begin
                          AddKey_Search( IxF,
                                       ItemArray[R].PageRef,//PrPgRef1,
                                       PrPgRef2,
                                       c,
                                       PagePtr1,
                                       PagePtr2,
                                       ProcItem1,
                                       ProcItem2,
                                       PassUp,
                                       okAddKey,
                                       ProcKey,
                                       DataRecNum,
                                       K,L);
                        End;

                   If Not ok
                   Then exit;

{                   IF PassUp
                   THEN Insert();} {Insere a primeira chave}

                   IF PassUp
                   THEN AddKey_Search_Insert( IxF,
                                       PrPgRef1,//PrPgRef1,
                                       PrPgRef2,
                                       c,
                                       PagePtr1,
                                       PagePtr2,
                                       ProcItem1,
                                       ProcItem2,
                                       PassUp,
                                       okAddKey,
                                       ProcKey,
                                       DataRecNum,
                                       K,L,R); {Insere a primeira chave}


                   If Not ok Then exit;
                 END;
         END;
       END;

END; { Search }


Function TDb_Methods.AddKey(var IxF : IndexFile;
                Const DataRecNum : Longint;
                Const ProcKey    : TaKeyStr):Boolean;
VAR
  PrPgRef1,
  PrPgRef2,
  C         : LONGINT;
  {I,}
  K,L     : SmallInt;

  PassUp,
  okAddKey  : BOOLEAN;

  PagePtr1,
  PagePtr2  : TaPagePtr;

  ProcItem1,
  ProcItem2 : TaItem;

  Var
    Wok, Wok_Set_Transaction : Boolean;
BEGIN { AddKey }
  Try //Except
    Try //fINALLY
      SetTransaction(true,OK,Wok_Set_Transaction);
      If ok
      Then Begin
              IF (NOT IxF.DataF.FileModeDenyALL)
              THEN BEGIN
                     TraveHeader(IxF.DataF);
                     If ok Then LeiaHeaderDoIndice(IxF);
                   END
              else ok := true;

              If ok
              Then Begin
                     okAddKey := true;
                     //Search(IxF.DataF.RR);
                     AddKey_Search(IxF,
                                   IxF.DataF.RR,//PrPgRef1,
                                   PrPgRef2,
                                   c,
                                   PagePtr1,
                                   PagePtr2,
                                   ProcItem1,
                                   ProcItem2,
                                   PassUp,
                                   okAddKey,
                                   AnsiUpperCase(String_Asc_Console_to_Asc_Ingles(ProcKey)),
                                   DataRecNum,
                                   K,L );
                     If ok
                     Then Begin
                            IF PassUp
                            THEN BEGIN {Usado quando e a primeira chave na página}
                                   PrPgRef1 := IxF.DataF.RR;
                                   TaNewPage(IxF,IxF.DataF.RR,PagePtr1);
                                   If ok
                                   Then Begin
                                          WITH PagePtr1 DO
                                          BEGIN
                                            ItemsOnPage  := 1;
                                            BckwPageRef  := PrPgRef1;
                                            ItemArray[1] := ProcItem1;
                                          END;
                                          TaUpdatePage(IxF,IxF.DataF.RR,PagePtr1,Tra_AddRec);
                                        End;
                                 END;

                            ok := okAddKey and ok;
                            If ok
                            Then begin
                                   IxF.PP := 0;
                                   Inc(IxF.DataF.NumberKey);
                                 End;
                          End;

                     IF ok
                     THEN BEGIN
                            If  NOT IxF.DataF.FileModeDenyALL
                            Then Begin
                                   FlushIndex(IxF);
                                   DestraveHeader(IxF.DataF);
                                 End
                            Else If IxF.DataF.F.GetDriveType = dt_Memory_Stream Then FlushIndex(IxF);
                          END;

                   End
              else ok := false;
           End
      Else ok := false;

  Finally
    Result := ok;
{$REGION ' ---> 2013/03/21 - Tarefa: Implementar a chamada a Rollback caso esteja dentro da transação e ocorra erro e a transação tenha sido executada na função AddKey().'}
  { DONE 1 -oVersão.9.36.26.3013>e.Metodo -cMELHORIA DO CÓDIGO :
 2013/03/21. Criado em: 2013/03/21.
   � PROBLEMA: Implementar a chamada a Rollback caso esteja dentro da transação e ocorra erro e a transação tenha sido executada na função AddKey().
       � CAUSA:
           � As vezes um índice fica Inconsistente.
       � SOLUÇÃO:
           � Implementar o comando Rollback todas as vezes que o comando StartTransaction for executado.
  }
     SetTransaction(False,OK,Wok_Set_Transaction);
  End;

  Except
    If TaStatus = 0
    Then TaStatus := Erro_Excecao_inesperada;

    Ok := false;
    Result := ok;
    Raise TException.Create(Name_Type_App_MarIcaraiV1,
                            'Tb_Access.Pas',
                            'Function AddKey(' + Ixf.DataF.FileName+ ')',
                            TaStatus);
  end;

{$ENDREGION}
//==========================================================================================================

END; { AddKey }

Function TDb_Methods.DeleteKey(var IxF : IndexFile;Const DataRecNum : Longint;Var ProcKey:TaKeyStr ):Boolean;
VAR
  PageTooSmall : BOOLEAN;
  PagPtr       : TaPagePtr;
  OkDeleteKey  : BOOLEAN;

  procedure UnderFlow(PrPgRef,PrPgRef2 : LONGINT;R: SmallInt);
  VAR
    I,K,LItem : SmallInt;
    LPageRef  : LONGINT;

    PagPtr,
    PagePtr2,
    L        : TaPagePtr;

  BEGIN
    TaGetPage(IxF,PrPgRef,PagPtr);
    TaGetPage(IxF,PrPgRef2,PagePtr2);

    IF R < PagPtr.ItemsOnPage
    THEN BEGIN
            Inc(R);
            LPageRef := PagPtr.ItemArray[R].PageRef;
            TaGetPage(IxF,LPageRef,L);
            K                                 := (L.ItemsOnPage - Order + 1) div 2;
            PagePtr2.ItemArray[Order]         := PagPtr.ItemArray[R];
            PagePtr2.ItemArray[Order].PageRef := L.BckwPageRef;

            IF K > 0
            THEN BEGIN
                    FOR I := 1 TO K - 1 DO PagePtr2.ItemArray[I + Order] := L.ItemArray[I];
                    PagPtr.ItemArray[R]         := L.ItemArray[K];
                    PagPtr.ItemArray[R].PageRef := LPageRef;
                    L.BckwPageRef               := L.ItemArray[K].PageRef;
                    L.ItemsOnPage               := L.ItemsOnPage - K;

                    FOR I := 1 TO L.ItemsOnPage DO L.ItemArray[I] := L.ItemArray[I + K];

                    PagePtr2.ItemsOnPage := Order - 1 + K;
                    PageTooSmall         := false;
                    TaUpdatePage(IxF,LPageRef,L,Tra_PutRec);
                 END
            ELSE BEGIN
                   FOR I := 1 TO Order
                   DO PagePtr2.ItemArray[I + Order] := L.ItemArray[I];

                   FOR I := R TO PagPtr.ItemsOnPage - 1
                   DO PagPtr.ItemArray[I] := PagPtr.ItemArray[I + 1];

                   PagePtr2.ItemsOnPage := PageSize;
                   PagPtr.ItemsOnPage   := PagPtr.ItemsOnPage - 1;

                   TaDeletePage(IxF,LPageRef,L);
                   PageTooSmall          := PagPtr.ItemsOnPage < Order;
                 END;
            TaUpdatePage(IxF,PrPgRef2,PagePtr2,Tra_PutRec);
         END
    ELSE BEGIN
           IF R = 1
           THEN LPageRef := PagPtr.BckwPageRef
           ELSE LPageRef := PagPtr.ItemArray[R - 1].PageRef;
           TaGetPage(IxF,LPageRef,L);
           LItem := L.ItemsOnPage + 1;
           K := (LItem - Order) div 2;
           IF K > 0
           THEN BEGIN
                  FOR I := Order - 1 DOwnTO 1
                  DO PagePtr2.ItemArray[I + K] := PagePtr2.ItemArray[I];

                  PagePtr2.ItemArray[K]         := PagPtr.ItemArray[R];
                  PagePtr2.ItemArray[K].PageRef := PagePtr2.BckwPageRef;
                  LItem                         := LItem - K;

                  FOR I := K - 1 DOwnTO 1
                  DO PagePtr2.ItemArray[I] := L.ItemArray[I + LItem];

                  PagePtr2.BckwPageRef        := L.ItemArray[LItem].PageRef;
                  PagPtr.ItemArray[R]         := L.ItemArray[LItem];
                  PagPtr.ItemArray[R].PageRef := PrPgRef2;
                  L.ItemsOnPage               := LItem - 1;
                  PagePtr2.ItemsOnPage        := Order - 1 + K;
                  PageTooSmall                := false;
                  TaUpdatePage(IxF,PrPgRef2,PagePtr2,Tra_PutRec);
                END
           ELSE BEGIN
                  L.ItemArray[LItem]         := PagPtr.ItemArray[R];
                  L.ItemArray[LItem].PageRef := PagePtr2.BckwPageRef;

                  FOR I := 1 TO Order - 1
                  DO L.ItemArray[I + LItem] := PagePtr2.ItemArray[I];

                  L.ItemsOnPage       := PageSize;
                  PagPtr.ItemsOnPage := PagPtr.ItemsOnPage - 1;

                  TaDeletePage(IxF,PrPgRef2,PagePtr2);
                  PageTooSmall := PagPtr.ItemsOnPage < Order;
                END;
           TaUpdatePage(IxF,LPageRef,L,Tra_PutRec);
         END;

    TaUpdatePage(IxF,PrPgRef,PagPtr,Tra_PutRec);
  END; // UnderFlow

  procedure DelB(PrPgRef : LONGINT);
  VAR
    I,K,L,R    : SmallInt;
    XPageRef,C : LONGINT;
    PagPtr     : TaPagePtr;

     procedure TDb_Methods. DelA(PrPgRef2 : LONGINT);
    VAR
      C        : SmallInt;
      XPageRef : LONGINT;
      PagePtr2 : TaPagePtr;
    BEGIN
      TaGetPage(IxF,PrPgRef2,PagePtr2);
      WITH PagePtr2 DO
      BEGIN
        XPageRef := ItemArray[ItemsOnPage].PageRef;
        IF XPageRef <> 0
        THEN BEGIN
               C := ItemsOnPage;
               DelA(XPageRef);
               If Not ok Then exit;

               IF PageTooSmall
               THEN  UnderFlow(PrPgRef2,XPageRef,C);
               If Not ok Then exit;
             END
        ELSE BEGIN
               TaGetPage(IxF,PrPgRef,PagPtr);
               ItemArray[ItemsOnPage].PageRef := PagPtr.ItemArray[K].PageRef;
               PagPtr.ItemArray[K]            := ItemArray[ItemsOnPage];
               ItemsOnPage                    := ItemsOnPage - 1;
               PageTooSmall                   := ItemsOnPage < Order;

               TaUpdatePage(IxF,PrPgRef,PagPtr,Tra_PutRec);
               If ok
               Then TaUpdatePage(IxF,PrPgRef2,PagePtr2,Tra_PutRec);

               If Not ok Then exit;
             END;
      END;
    END; { DelA }


  BEGIN { DelB }

    IF PrPgRef = 0
    THEN BEGIN
           OkDeleteKey := false;
           PageTooSmall := false;
         END
    ELSE BEGIN
           TaGetPage(IxF,PrPgRef,PagPtr);
           WITH PagPtr DO
           BEGIN
             L := 1;
             R := ItemsOnPage;
             REPEAT
                K := (L + R) div 2;
                      C := TaCompKeys(TaKeyStr(ProcKey),
                                ItemArray[K].Key,
                                DataRecNum,
                                                  ItemArray[K].DataRef,
                                IxF.AllowDuplKeys   );
                    IF C <= 0 THEN R := K - 1;
                    IF C >= 0 THEN L := K + 1;
             UNTIL L > R;

             IF R = 0
             THEN XPageRef := BckwPageRef
             ELSE XPageRef := ItemArray[R].PageRef;

             IF L - R > 1
             THEN BEGIN
      {          DataRecNum := ItemArray[K].DataRef; PauloSSPacheco tirou}
                    IF XPageRef = 0
                    THEN BEGIN
                           ItemsOnPage  := ItemsOnPage - 1;
                           PageTooSmall := ItemsOnPage < Order;
                           FOR I := K TO ItemsOnPage DO ItemArray[I] := ItemArray[I + 1];
                           TaUpdatePage(IxF,PrPgRef,PagPtr,Tra_PutRec);
                         END
                    ELSE BEGIN
                           DelA(XPageRef);
                           If Not ok Then exit;
                           IF PageTooSmall
                           THEN UnderFlow(PrPgRef,XPageRef,R);
                           If Not ok Then exit;
                         END;
                  END
             ELSE BEGIN
                    DelB(XPageRef);
                    If Not ok Then exit;
                    IF PageTooSmall
                    THEN UnderFlow(PrPgRef,XPageRef,R);
                    If Not ok Then exit;
                  END;
           END;
         END;
  END; { DelB }

  Var
    Wok , Wok_Set_Transaction : Boolean;
    WIxF_RR : Longint;
BEGIN { DeleteKey }
  try //Except
    Try  //Finally
      ProcKey := AnsiUpperCase(String_Asc_Console_to_Asc_Ingles(ProcKey));

      SetTransaction(true,OK,Wok_Set_Transaction);
      If ok
      Then Begin
              IF NOT IxF.DataF.FileModeDenyALL
              THEN BEGIN
                     TraveHeader(IxF.DataF);
                     LeiaHeaderDOIndice(IxF);
                   END;

              OkDeleteKey := true;
              DelB(IxF.DataF.RR);
              IF ok  and PageTooSmall
              THEN BEGIN
                     TaGetPage(IxF,IxF.DataF.RR,PagPtr);
                     IF PagPtr.ItemsOnPage = 0
                     THEN BEGIN
                            WIxF_RR := IxF.DataF.RR;
                            IxF.DataF.RR := PagPtr.BckwPageRef;
                            TaDeletePage(IxF,WIxF_RR,PagPtr);
                          END;
                   END;
              IxF.PP := 0;
              If ok and OkDeleteKey
              Then Dec(IxF.DataF.NumberKey);

              IF NOT IxF.DataF.FileModeDenyALL
              THEN BEGIN
                     If ok
                     Then ok := FlushIndex(IxF);
                     DestraveHeader(IxF.DataF);
                   END
              Else If IxF.DataF.F.GetDriveType = dt_Memory_Stream Then FlushIndex(IxF);


              ok        := OkDeleteKey and ok;
           End;

    Finally
      Result := ok;

{$REGION ' ---> 2013/03/21 - Tarefa: Implementar a chamada a Rollback caso esteja dentro da transação e ocorra erro e a transação tenha sido executada na função DeleteKey().'}
  { DONE 1 -oVersão.9.36.26.3013>e.Metodo -cMELHORIA DO CÓDIGO :
 2013/03/21. Criado em: 2013/03/21.
   � PROBLEMA: Implementar a chamada a Rollback caso esteja dentro da transação e ocorra erro e a transação tenha sido executada na função DeleteKey().
       � CAUSA:
           � As vezes um índice fica Inconsistente.
       � SOLUÇÃO:
           � Implementar o comando Rollback todas as vezes que o comando StartTransaction for executado.
  }
       SetTransaction(False,OK,Wok_Set_Transaction);
    End;

  Except
    Ok := false;
    Result := ok;
    If TaStatus = 0
    Then TaStatus := Erro_Excecao_inesperada;

    Ok := false;
    Result := ok;
    Raise TException.Create(Name_Type_App_MarIcaraiV1,
                              'Tb_Access.Pas',
                              'Function DeleteKey(' + IxF.DataF.FileName+ ')',
                               TaStatus);
  end;

{$ENDREGION}
//==========================================================================================================

END; { DeleteKey }


procedure TDb_Methods. CreateTAccess;
  { Initialization routine called by the "main  procedure TDb_Methods." OF this unit. }
   procedure TDb_Methods. CreatePages;
  { Allocate space FOR the page stack, the page map and the record
    buffer. }
  VAR
{    i    : SmallWord;}
    DatF : DataFile;
  BEGIN
//    {$IFDEF TADebug} Application.Push_MsgErro('Tb_Access.CreateTAccess.CreatePages',ListaDeChamadas);{$ENDIF}
    FilesOpens := TFilesOpens.Create;
    IF FilesOpens<>nil THEN
    BEGIN
      IF MemAvail < SIZEOF(TaRecordBuffer)  THEN
       BEGIN
         TaStatus := MemOverflow;
         FillChar(DatF,sizeof(Datf),0);
         TaIOcheck(DatF, 0);
         RunError(TaStatus);
       END;

      NEW(TaRecBuf);
      IF TaRecBuf = NIL THEN
      Begin
        TaStatus := ErroDeMemoria;
        FillChar(DatF,sizeof(Datf),0);
        TaIOcheck(DatF, 0);
        RunError(TaStatus);
      End;
      FILLChar(TaRecBuf^, SIZEOF(TaRecBuf^), 0);

      Transaction :=  TTransaction.Create('DbTra.Tb');
      IF Transaction = NIL THEN
      Begin
        TaStatus := ErroDeMemoria;
        FillChar(DatF,sizeof(Datf),0);
        TaIOcheck(DatF, 0);
        RunError(TaStatus);
      End;

    END
    ELSE
    Begin
      TaStatus := ErroDeMemoria;
      FillChar(DatF,sizeof(Datf),0);
      TaIOcheck(DatF, 0);
      RunError(TaStatus);
    End;

  END; { CreatePages }

BEGIN { CreateTAccess }
  Ok := true;
  TaStatus := 0;
  CreatePages;
END; { CreateTAccess }

procedure TDb_Methods. DestroyTAccess;
BEGIN
  Discard(TObject(FilesOpens));
  If TaRecBuf <> Nil Then
  Begin
    Dispose(TaRecBuf);
    TaRecBuf := Nil;
  End;
  Discard(TObject(Transaction));
END; { DestroyPages }


procedure TDb_Methods. MakeArq(VAR DatF    : ConfigDataFile;
                  VAR Buff                     );
{ ProcedimenTOs para Abrir e Fechar arquivo sem o registro 0 }
  Var
    Wok , Wok_Set_Transaction : Boolean;
BEGIN

    ok :=  TaStatus=0;
    If ok
    Then Begin
            AssignDataFile(DatF.Df,DatF.NomeArq,DatF.TamReg,DatF.TamReg,FileMode);
            DatF.Df.F.Rewrite(FileMode);
            ok := TaStatus=0;

            IF Ok THEN
            WITH DatF,Df DO
            BEGIN
              IF TamReg > 65535 THEN
              Begin
                TaStatus := REC_TOO_LARGE;
                Ok       := False;
                TaIOCheck(DatF.Df, 0);
                Discard(TObject(DatF.Df.F));
                Abort;
              End;
              DatF.Df.ItemSize    := DatF.TamReg;
            END
            Else
            Begin
              TaIOCheck(DatF.Df, 0);
              ok := false;
              Discard(TObject(DatF.Df.F));
              Abort;
            End;
         End;

END; { MakeArq }

procedure TDb_Methods.OpenArq(VAR DatF    : ConfigDataFile;
                  VAR Buff                     );

  Var
    Wok_Set_Transaction : Boolean;

BEGIN
  Try
    ok := TaStatus = 0;
    If ok and (Not Is_TFileOpen(DatF.DF.F))
    Then BEGIN
            AssignDataFile(DatF.Df,DatF.NomeArq,DatF.TamReg,DatF.TamReg,FileMode);
            DatF.Df.F.Reset(FileMode);
            IF TaStatus<> 0 THEN
            BEGIN
              TaIOcheck(DatF.Df,0);
              Discard(TObject(DatF.Df.F));
              ok := false;
              Abort;
            END
            ELSE Ok := True;
            DatF.Df.ItemSize    := DatF.TamReg;
         END
    ELSE Begin
           If TaStatus = 0
           Then TaStatus := ErrorTentativa_de_abrir_um_arquivo_aberto;
           Abort;
         end;

  Finally
    ok := ok and (TaStatus =0);
  end;
END; { OpenArq }


procedure TDb_Methods.AbreArqSemHeader(VAR Arqdados:ConfigDataFile ; VAR Buff );
BEGIN
//  {$IFDEF TADebug} Application.Push_MsgErro('Tb_Access.AbreArqSemHeader',ListaDeChamadas); {$ENDIF}
  IF FileExists(Arqdados.NomeArq) THEN
  BEGIN
    OpenArq(Arqdados,Buff);
    IF NOT ok THEN
      IF NOT FileShared(Arqdados.NomeArq) THEN
        Application.Mi_MsgBox.MessageBox(
        'Não pode usar o arquivo '+Arqdados.nomeArq+'. ( USO EXCLUSIVO )'
        ,MtError+ MbOKButton + mfInsertInApp,CmOk);
  END
  ELSE
  BEGIN
    IF FileShared(Arqdados.NomeArq) THEN
    BEGIN
      If Application.Mi_MsgBox.MessageBox('O arquivo '+ArqDados.nomeArq+' Não existe.'+^M+
                    ^M+
                    'Cria o arquivo agora?'
                    ,MtConfirmation+mfYesNoCancel+MfInsertInApp,CmYes)
      = CmYes Then
        MakeArq(arqdados,Buff)
      ELSE
       Ok := False;
    END
    ELSE
      Application.Mi_MsgBox.MessageBox(
      'Não pode usar o arquivo '+Arqdados.nomeArq+'. ( USO EXCLUSIVO )'
     ,MtError+ MbOKButton + mfInsertInApp,CmOk);

  END;
END;

procedure TDb_Methods. CloseArqSemHeader(VAR DatF : ConfigDataFile);
BEGIN
//  {$IFDEF TADebug} Application.Push_MsgErro('Tb_Access.CloseArqSemHeader',ListaDeChamadas); {$ENDIF}
  If Is_TFileOpen(DatF.Df.F) Then
  BEGIN
    TaStatus := System.IOresult; {Zera InOutRes}
    Discard(TObject(DatF.Df.F));
    If TaStatus <> 0 Then
    Begin
      TaIOCheck(DatF.Df,0);
      RunError(TaStatus);
    end
    else Ok := true;
  END
  ELSE ok := True;

END; { CloseArq }

{Var
  ExitProcAnterior : Pointer;}
procedure TDb_Methods. Create;
Begin
//  {$IFDEF TaDebug}Application.Push_MsgErro('Tb_Access.Create',ListaDeChamadas);{$ENDIF}
  Set_FileModeDenyALL(False);
  CreateTAccess;
End;


 procedure TDb_Methods. Destroy;
Begin
  Try
//    {$IFDEF TaDebug}Application.Push_MsgErro('Tb_Access.Destroy',ListaDeChamadas);{$ENDIF}
    DestroyTAccess;
  Finally

  End;
End;

(*
  Esta unidade deve ser inicializada em Tb__Access visto que
  ela precisa ser a ultima a ser desalocada porque ela faz o tratamento
  de acesso a dados.

Begin
//  {$IFDEF TaDebug}Application.Push_MsgErro('Tb_Access.Begin',ListaDeChamadas);{$ENDIF}
  Tb_Access.Create;
  ExitProcAnterior  := ExitProc;
  ExitProc          := @Destroy;
*)


end.

