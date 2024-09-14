unit mi.rtl.Objects.Methods.Db.Tb__Access;
{:< Esta unit **@name** é usada para criar banco de dados local usando estrutura **Type Record  End**;
}

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface
Uses
    Classes, SysUtils, dos,
    mi.rtl.Objects.Methods.Paramexecucao.Application,
    mi.rtl.objects.Methods.Exception,
    mi.rtl.objects.Methods.dates,
    mi.rtl.objects.methods.ParamExecucao,
    mi.rtl.objects.methods.db.tb_access
  ;

  type TTb__Access_types = class(TTb_Access)
    Type TFuncGetAddRec = FUNCTION (Var RegFonte;Const TamFonte:SmallWord;Var RegDestino;Const TamDestino : SmallWord):BOOLEAN;
    type TMI_DataFile  = record
                             NomeArq    : PathStr;
                             TamReg     : Word;
                             NArqIndice : Byte;       { Numero de Arquivos }
                             DF         : DataFile;
                           end;

    type TMI_IndexFile = record
                             NomeArqIndice : PathStr;
                             TamChave,
                             RepeteChave   : byte;
                             IndiceArray   : byte;
                             PosicaoNoReg  : Byte;
                             OkMsgDuplicidade : Boolean;
                             Ix            : IndexFile;
                           end;

    type TipoPonteiroBD = Record
                            PA : Pointer; {:< Ponteiro para um arq. tipo TMI_DataFile }
                            PI : Pointer; {:< Ponteiro para um arq. tipo TMI_IndexFile}
                            PR : Pointer; {:< Ponteiro para um variável qualquer       }
                            Nr : Longint; {:< Número do registro de Skip }
                          End;

    type TipoFuncao = Function : Boolean;



  end;

  type TTb__Access_consts = class(TTb__Access_types)
      const EndClearAll     : TipoProc = Nil;
      const EndOpenFiles    : TipoProc = Nil; {< Rotina para abertura dos arquivos genericos }
      const EndCloseFiles   : TipoProc = Nil; {< Rotina para Fechar os arquivos genericos }

              {: True = O sistema deve reindexar todos os arquivos}
      const OkDeveReindexarDB : Boolean = false;

              {: True = O Sistema deve executar a rotina para reparar as consistências entre tabelas}
      const OkDeveRepararDB   : Boolean = false;

      {: A constante **@name** é o número do registro corrente temporário.

         - **NOTA**
          - É usado para manter a compatibilidade com o passado.
      }
      Const NRecAux      : Longint = 0;

      {: A constante **@name** é o número do registro corrente

         - **NOTA**
           - É usado para manter a compatibilidade com o passado.
      }
      Const NRec         : Longint = 0;


      {Variáveis usadas para salvar a situação anterior de destroy memory e create memory}
      const WCursorLigado : Boolean = true;
      const WEndCloseFiles: TipoProc = nil;
      const WEndOpenFiles : TipoProc = nil;

  end;

  type TTb__Access = class(TTb__Access_consts)
    public class function StartTransaction(Const DatF              : TMI_DataFile ;
                                           Var aok_Set_Transaction : Boolean): Integer;Overload;

    public class function FileSize(Var MI_DataFile : TMI_DataFile):Longint;Overload;

    public class Procedure Init_MI_DataFile(Var MI_DataFile    : TMI_DataFile;
                                            NomeArquivo        : PathStr;
                                            tamanhoRegistro    : SmallWord;
                                            NumeroDeArqIndice  : byte );Overload;

    public class Procedure Init_MI_DataFile(Var MI_DataFile    : TMI_DataFile;
                                            NomeArquivo        : PathStr;
                                            tamanhoRegistro    : TTb_Access.SmallWord;
                                            NumeroDeArqIndice  : byte;
                                            wOkTemporario      : Boolean);Overload;


    public class Procedure Init_IxF(Const Indice         : Byte;
                                    Var   IxF            : TMI_IndexFile;
                                    Const CNomeArqIndice : PathStr;
                                    Const CRepeteChave   : Byte;
                                    Const StrCondicao    : tString        );

    public class function MakeFile(Const FileName:PathStr;Const TamArq:Longint):Integer;overload;
    public class function MakeFile(var DatF : TMI_DataFile ):Integer;overload;

    public class function MakeIndex(Const FileName:PathStr;Const RepeteChave,TamChave:Byte):Integer;overload;
    public class function MakeIndex(var IxF : TMI_IndexFile):Integer;Overload;

    public class function OpenFile(var DatF : TMI_DataFile;OkCreate : Boolean):Integer;Overload;
    public class function OpenFile(var DatF : TMI_DataFile ):Integer;Overload;

    public class function OpenIndex(var IxF : TMI_IndexFile):Integer;Overload;

    public class function CloseFile(var DatF : TMI_DataFile ):Integer;overload;
    public class function CloseIndex(var IxF : TMI_IndexFile):Boolean;overload;

    {: A class procedure **@name** é usado criar aquivo sem o registro 0 }
    public class Procedure MakeArq(VAR DatF : TMI_DataFile; VAR Buff  );

    {: A class procedure **@name** é usado abrir aquivo sem o registro 0 }
    public class Procedure OpenArq(VAR DatF : TMI_DataFile; VAR Buff  );
    public class Procedure AbreArqSemHeader(VAR Arqdados:TMI_DataFile ; VAR Buff );
    public class Procedure CloseArqSemHeader(VAR DatF : TMI_DataFile);

    public class function GetAddRec(Const Title : tString;
                                Const NomeFonte:PathStr;
                                Var RegFonte;
                                Const TamFonte : SmallWord;
                                Const NomeDestino : PathStr;
                                Var regDestino;
                                Const TamDestino : SmallWord;
                                Const AtualizaDestino : TFuncGetAddRec;
                                Const OkMakeFile :Boolean) : Boolean;

    public class function ModifyStructurFile(Const FName:FileName;Const RecLenDest : SmallWord ):Boolean;override;

    public class function PrimeiroLivre(VAR DatF: TMI_DataFile) : LONGINT;

    public class function TraveArq(Var DatF : TMI_DataFile):Boolean;
    public class function DestraveArq(Var DatF : TMI_DataFile):Boolean;

    public class function UsedRecs(var DatF : TMI_DataFile ) : Longint;Overload;

    public class function GetRec(var DatF : TMI_DataFile ;Const R : Longint;var Buffer  ):Boolean;overload;

    public class function PutRec(var DatF : TMI_DataFile ;Const R : Longint;var Buffer  ):Boolean;overload;

    public class function AddRec(var DatF : TMI_DataFile ;var R : Longint;var Buffer ):Boolean;overload;

    public class function DeleteRec(var DatF : TMI_DataFile ;Const R : Longint):Boolean;overload;

    public class function FileLen(var DatF : TMI_DataFile ) : Longint;overload;

    public class function MakeIndex(var IxF : TMI_IndexFile;Exclusivo:Boolean ):Integer;Overload;

    public class function OpenIndex(var IxF : TMI_IndexFile;Exclusivo         :Boolean ):Integer;Overload;
    public class function OpenIndex(var IxF : TMI_IndexFile;Exclusivo,OkCreate:Boolean ):Integer;Overload;

    public class function ClearKey(var IxF : TMI_IndexFile) :Boolean;overload;

    public class function NextKey(var IxF : TMI_IndexFile;
                                  var ProcDatRef : Longint;
                                  var ProcKey ):Boolean;overload;

    public class function PrevKey(var IxF : TMI_IndexFile;
                                  var ProcDatRef : Longint;
                                  var ProcKey ):Boolean;overload;

    public class function FindKeyTop(var IxF : TMI_IndexFile ;
                                     var ProcDatRef : Longint;
                                     var ProcKey ):Boolean;overload;

    public class function FindKey(var IxF : TMI_IndexFile;
                                   var ProcDatRef : Longint;
                                   var ProcKey ):Boolean;overload;

    public class function SearchKey(var IxF : TMI_IndexFile;
                                    var ProcDatRef : Longint;
                                    var ProcKey:TaKeyStr ):Boolean;overload;

    public class function SearchKeyTop(var IxF : TMI_IndexFile ;
                           var ProcDatRef : Longint;
                           var ProcKey :TaKeyStr;
                           Const Okequal : Boolean ):Boolean;overload;

    public class function AddKey(var IxF : TMI_IndexFile;
                                  Const ProcDatRef : Longint;
                                  Const ProcKey    : TaKeyStr ):Boolean;overload;

    public class function DeleteKey(var IxF : TMI_IndexFile;
                                    Const ProcDatRef : Longint;
                                    Const ProcKey    : TaKeyStr):Boolean;overload;

    public class procedure FlushFile(var DatF :TMI_DataFile );overload;

    public class procedure FlushIndex(var IxF : TMI_IndexFile );overload;


//    public class Procedure TSeek(Var DatF : TMI_DataFile;Const R : Longint );
    public class function  Seek(Var DatF : TMI_DataFile;Const R : Longint ):SmallInt;overload;

    public class Procedure CloseFilesOpens;virtual;

    public class Procedure MyDestroyMemory;
    public class Procedure MyCreateMemory;
    public class Procedure MyDestroyMemorySemVideo;
    public class Procedure MyCreateMemorySemVideo;

    public class function ExecCommand(FileName:PathStr;Flags: Longint;aExecAsync : Longint): Byte;Overload;
    public class function ExecCommand(FileName:PathStr;Flags: Longint): Byte;Overload;

    {: A classe método **@name** executa um programa externo de form assíncrona.

       - **EXEMPLO**

         ```pascal

            ExecDos('/usr/bin/gnome-terminal','ls');

         ```
    }
    public class function ExecDos(Const Path: PathStr; Const ComLine: ComStr): Byte;


    {Procedure ExecutaCommand;}

    {public class function TroqueChave(Var ArqDupIndice:TMI_IndexFile;NR:Longint;ChaveAnterior,ChaveAtual : tString):Boolean;}
    public class function FindKey(var IxF : TMI_IndexFile;
                                  var ProcDatRef : Longint;
                                      ProcKey    : TaKeyStr):Boolean ;overload;
    public class function AdicioneChave(var IxF : TMI_IndexFile ;
                           Const ProcDatRef : Longint;
                           Const ProcKey    : TaKeyStr):Boolean;
    public class function EliminaChave(var IxF : TMI_IndexFile ;
                          Const ProcDatRef : Longint;
                          Const ProcKey    : TaKeyStr):Boolean;


    public class function NomeDaEstacao:tString;


    { Determina o numero maximo de arquivos que podem ser aberto ao mesmo tempo}
    {procedure MenuRedirecionaRelatorios;}
    {public class function DriveValido(Drive: AnsiChar): Boolean;
    public class function PathValid(var Path: PathStr): Boolean;}

    public class function ValidFileName(Const Name : PathStr):Byte;

    public class function FConcatNomeArq(Nome,Extencao:PathStr) : PathStr;



    {Procedure RewriteTemp(Var DatF : DataFile; Var NomeArqTemp : tString);} { Cria arquivo temporario }
    public class function CriaArqTemp(Var ArqF : TMI_DataFile;
                         Const TamArqTemp : SmallWord;
                         Const  NumeroDeIndice : Byte ):Boolean; { Cria arquivo temporario }

    public class function CriaArqTempI(Var IxF: TMI_IndexFile;
                          Const RepeteChave : Byte;
                          Const EndChaveNoRegistro: tString):Boolean; { Cria arquivo temporario }

    public class function EspacoEmDisco(NomeFonte,DriveDestino:PathStr) :boolean;
    public class function TTraveRegistro(Var  DatF : TMI_DataFile;Const R : Longint):Boolean;
    public class function TDestraveRegistro(Var  DatF : TMI_DataFile;Const R : Longint):Boolean;
    public class function FPackDataFile(NomeArq  :PathStr):Boolean;
    public class function  FLeiaGrave (Const     MsgStr    : tString;
                          Const     NomeArqDados  : PathStr;
                          Var
                            RegBuff   ;
                          Const     TamRegBuff    : SmallWord;
                          Const    OkFunc    : TipoFuncao) : Boolean;
    public class function  LeiaGrave (Const     MsgStr    : tString;
                         Var ArqDados  : TMI_DataFile;
                         Var RegBuff   ;
                         Const     OkFunc    : TipoFuncao) : Boolean;
    public class function FLeieEGraveRegistro(Const     NomeFonte:PathStr;
                                 Var RegFonte;
                                 Const     TamFonte : SmallWord;

                                 Const     NomeDestino : PathStr;
                                 Var regDestino;
                                 Const     TamDestino : SmallWord;
                                 AtualizaDestino : TipoFuncao;
                                 Const OkMakeFile :Boolean) : Boolean;


    public class function StrDataEmQueFoiAlterado(Const NomeArquivo :PathStr) : tString;
    public class function StrDateFile(Const NomeArquivo : PathStr;Const Ch:AnsiChar) : tString;


    public class function CreateLst:Boolean;

    public class  Procedure DestroyLst;

    public class function GeraSequencia(Var ArqI:IndexFile) :Longint;
    public class function  TestaAberturaDeArquivo(MaxFile : Byte; {:< Número máximo de arquivo a ser aberto}
                                                   Var NumMaxPossivel:Byte {:< Devolve o número de arquivos que conseguiu abrir }
                                                   ): Boolean;


    public class function AssingLst(Const WopcaoRedireciona : AnsiChar; {I=Impressora; A e R = Arquivo}
                                    Const aNomeRedireciona   : PathStr):Boolean;

    public class procedure redirecionaParaNul;

    public class  Procedure Create;
    public class  Procedure Destroy;

  end;

Implementation



{procedure TTb__Access. InicializaTb__Access;
Begin
  CreateTAccess;
  EndOpenFiles   := Nil;
  EndCloseFiles  := Nil;
  EndClearAll    := CloseFilesOpens;
  FuncTurboError := TurboError;
End;}


class function TTb__access.StartTransaction(Const DatF : TMI_DataFile ; Var aok_Set_Transaction : Boolean): Integer;
begin
  result := StartTransaction(DatF,aok_Set_Transaction);
end;

class function TTb__access.FileSize(Var MI_DataFile : TMI_DataFile):Longint;
begin
  result := FileSize(MI_DataFile.df);
end;

class procedure TTb__access.Init_MI_DataFile(Var MI_DataFile          : TMI_DataFile;
                       NomeArquivo        : PathStr;
                       tamanhoRegistro    : SmallWord;
                       NumeroDeArqIndice  : byte;
                       wOkTemporario      : Boolean
                      );

begin
  FillChar(MI_DataFile,sizeof(MI_DataFile),0);
  with MI_DataFile do
  begin
    df.Tipo          := 'D';
    NomeArq       := ExpandFileName(LowerCase(ExtractFileName(NomeArquivo)));
    tamReg        := tamanhoRegistro;
    df.ItemSize      := tamanhoRegistro;
    NArqIndice    := NumeroDeArqIndice;
    df.OkTemporario  := wOkTemporario;
  end;
end;

class procedure TTb__access. Init_MI_DataFile(Var MI_DataFile          : TMI_DataFile;
                       NomeArquivo        : PathStr;
                       tamanhoRegistro    : SmallWord;
                       NumeroDeArqIndice  : byte
                      );
Begin
  Init_MI_DataFile(MI_DataFile,NomeArquivo,tamanhoRegistro,NumeroDeArqIndice,false);
end;

class procedure TTb__access. Init_IxF(Const      Indice             : Byte;
                        Var        IxF                : TMI_IndexFile;
                        Const      CNomeArqIndice     : PathStr;
                        Const      CRepeteChave       : Byte;
                        Const      StrCondicao        : tString        );

  procedure InicEnderecoReg;

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
                      //val(St,SegmentoReg,Err);
                      SegmentoReg := StrToInt(St);

                    St := '';
                  end;
      ';'       : if LArq = Indice then
                  begin
                    with EnderecoReg[CArq] do
                      //val(St,OffsetReg,Err);
                      OffsetReg := StrToInt(St);
                    st := '';
                    inc(CArq);
                  end;

      '.'       : if LArq = Indice then
                  begin
                    with EnderecoReg[CArq] do
                      //val(St,OffsetReg,Err);
                      OffsetReg := StrToInt(St);

                    with IxF do
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
  FillChar(IxF,sizeof(ixF),0);
  with IxF,Ix,dataF do
  begin
    OkAddRecFirstFree := false;//Não aproveita espaço do registro deletado.
    Tipo          := 'I';
    IndiceArray   := Indice;
    nomeArqIndice := ExpandFileName(LowerCase(ExtractFileName(CNomeArqIndice)));
    RepeteChave   := CRepeteChave;
    OkMsgDuplicidade := True;
    OkTemporario  := False;
    OrderByDesc   := False; // Padrao � ordem crescente.
    InicEnderecoReg;
  end;

end;

class function TTb__Access.MakeFile(Const FileName:PathStr;Const TamArq:Longint):Integer;
Var
  Arq : TMI_DataFile;
Begin
  Init_MI_DataFile(Arq,FileName,TamArq,0);
  Result := MakeFile(Arq);
  If Result = 0 Then CloseFile(Arq);

End;

class function TTb__access.MakeIndex(Const FileName:PathStr;Const RepeteChave,TamChave:Byte):Integer;
   Var
     ArqI : TMI_IndexFile;
Begin
  Init_IxF(1,ArqI,FileName,RepeteChave,'1,'+IStr(TamChave,'99')+'.');
  Result := MakeIndex(ArqI);
  If Result = 0
  Then CloseIndex(ArqI);
End;

class function TTb__access.MakeFile(var DatF : TMI_DataFile ):Integer;
begin
  Discard(TObject(DatF.Df.F));
  If DelFile(datF.NomeArq)
  Then TaStatus := ArquivoNaoEncontrado2;

  If TaStatus in [ArquivoNaoEncontrado2,ArquivoNaoEncontrado18]
  Then TaStatus := MakeFile(datF.Df,datF.NomeArq,datF.TamReg)
  Else TaStatus := AcessoNegado5;
  Result := TaStatus;
  ok     := Result = 0;
end;

class function TTb__access.MakeIndex(var IxF : TMI_IndexFile):Integer;

begin
  with IxF,Ix,DataF do
  Try
    If Not Is_TFileOpen(F)
    Then begin {  if FileRec(F).Mode = FmClosed then}
           If DelFile(NomeArqIndice)
           Then Begin
                  TaStatus := MakeIndex(Ix,NomeArqIndice,TamChave,RepeteChave);
                  If TaStatus = 0
                  Then Begin
                         CloseIndex(IxF);
                         TaStatus := OpenIndex(IxF);
                       End;
                End;
         End
    Else TaStatus := ErrorTentativa_de_abrir_um_arquivo_aberto;

  Finally

    If TaStatus <> 0
    Then Raise TException.Create7('',
                                 'Tb_Access.Pas',
                                 'TTb_access',
                                 'MakeIndex',
                                  IxF.Ix.DataF.FileName,
                                  Format('%d',[TamChave]),
                                 TaStatus);
    Result := TaStatus;
    ok     := Result=0;
  end;

end;

class function TTb__access.OpenFile(var DatF : TMI_DataFile):Integer;Overload;
    Var
      Wok_Set_Transaction : Boolean;
begin
  Try
    If Not Is_TFileOpen(TMI_DataFile(DatF).DF.F) Then
    Begin
      If Not FileExists(DatF.NomeArq) Then
      Begin
          TaStatus := ArquivoNaoEncontrado2;
          Raise TException.Create7('',
                                  'Tb_Access.Pas',
                                  'TTb_access',
                                  'TOpenFile',
                                  DatF.Df.FileName,
                                  '',
                                  TaStatus);
      End;

      With TMI_DataFile(DatF),DF do
      begin
        try
          SetTransaction(true,OK,Wok_Set_Transaction); //Objetivo de desfazer qualquer transação pendente.
          if ok
          then TaStatus := OpenFile(Df,NomeArq,TamReg)
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

class function TTb__access. OpenIndex(var IxF : TMI_IndexFile ):Integer;
var
{  MsgLinha : TipoLinhaTela;
  X,Y      : Byte;}
  Existe   : Boolean;
{  WindMinAux,WindMaxAux : SmallWord;}
begin
  Try
//    {$IFDEF TaDebug}Application.Push_MsgErro('Tb_Access.OpenIndex',ListaDeChamadas);{$ENDIF}

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

class function TTb__access.OpenFile(var DatF : TMI_DataFile;OkCreate : Boolean):Integer;Overload;
begin
  try

    TaStatus := OpenFile(DatF);
    if OkCreate and (TaStatus<>0) And (TaStatus in [ArquivoNaoEncontrado2,ArquivoNaoEncontrado18]) then
    begin
      If FileShared(DatF.NomeArq)
      Then begin
             if Assigned(MI_MsgBox)
             then with Mi_MsgBox do
                  Begin
                     If MessageBox('O arquivo '+DatF.nomeArq+' não existe.'+^M+
                                   ^M+
                                   'Cria o arquivo agora?'
                                   ,mtConfirmation,mbYesNoCancel,mbYes) = MrYes
                     Then Begin

                            TaStatus := MakeFile(DatF);
                            If TaStatus = 0
                            Then CloseFile(DatF);

                            If TaStatus = 0
                            Then TaStatus := OpenFile(DatF);
                          End
                     Else TaStatus := ArquivoNaoEncontrado2;
                   End;
         end;
     End; {Sucesso na operação}

  Finally
    Result := TaStatus;
    If TaStatus <>0
    Then Raise TException.Create7('',
                                  'Tb_Access.Pas',
                                  'TTb_access',
                                  'TOpenFile',
                                  DatF.NomeArq,
                                  '',
                                  TaStatus);

    Ok     := Result = 0;
  end;
end;



class function TTb__access.CloseFile(var DatF : TMI_DataFile ):Integer;
begin
  CloseFile(TMI_DataFile(DatF).DF);
  Result := TaStatus;
end;

class function TTb__access.CloseIndex(var IxF : TMI_IndexFile ):boolean;
begin
  TaStatus := 0;
  with IxF,Ix,DataF do
  if Is_TFileOpen(F) then
  begin
    ok := CloseIndex(Ix);
  end
  else ok := true;
  CloseIndex := ok;
end;




function AtualizaDestino(Var RegFonte;
                         Const TamFonte:TTb_access.SmallWord;
                         var RegDestino;
                         Const TamDestino : TTb_access.SmallWord) : BOOLEAN;
BEGIN
  Move(RegFonte,RegDestino,TamFonte);
  AtualizaDestino := true;
END;


class procedure TTb__Access.MakeArq(var DatF: TMI_DataFile; var Buff);

BEGIN
    ok :=  TaStatus=0;
    If ok
    Then Begin
            AssignDataFile(DatF.Df,DatF.NomeArq,DatF.TamReg,DatF.TamReg);

            DatF.Df.F.Rewrite(fmOpenReadWrite,fmShareCompat or fmShareDenyNone);
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

class procedure TTb__Access.OpenArq(var DatF: TMI_DataFile; var Buff);
BEGIN
  Try
    ok := TaStatus = 0;
    If ok and (Not Is_TFileOpen(DatF.DF.F))
    Then BEGIN
            AssignDataFile(DatF.Df,DatF.NomeArq,DatF.TamReg,DatF.TamReg);
            DatF.Df.F.Reset(FileMode,shareMode);
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

class procedure TTb__Access.AbreArqSemHeader(var Arqdados: TMI_DataFile;
  var Buff);
BEGIN
  IF FileExists(Arqdados.NomeArq) THEN
  BEGIN
    OpenArq(Arqdados,Buff);
    IF NOT ok THEN
      IF NOT FileShared(Arqdados.NomeArq)
      THEN if Assigned(MI_MsgBox)
           then with Mi_MsgBox do
                 MessageBox(Format('Não pode usar o arquivo %s. ( USO EXCLUSIVO )',[Arqdados.nomeArq]),MtError, mbOKButton,mbok);
  END
  ELSE
  BEGIN
    IF FileShared(Arqdados.NomeArq)
    THEN begin
           if Assigned(MI_MsgBox) then
           with Mi_MsgBox do
           BEGIN
              If MessageBox(Format('O arquivo %s Não existe.'+^M+
                            ^M+
                            'Cria o arquivo agora?',[ArqDados.nomeArq])
                            ,mtConfirmation,mbYesNoCancel,mbYes)
              = MrYes Then
                MakeArq(arqdados,Buff)
              ELSE
               Ok := False;
            END
         end
    ELSE if Assigned(MI_MsgBox) then
         with Mi_MsgBox do
         MessageBox(format('Não pode usar o arquivo %s. ( USO EXCLUSIVO )',[Arqdados.nomeArq])
                    ,mtError, mbOKButton,mbOk);
  END;

END;

class procedure TTb__Access.CloseArqSemHeader(var DatF: TMI_DataFile);
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


class function TTb__access.GetAddRec( Const Title : tString;
                    Const NomeFonte:PathStr;
                    Var RegFonte;
                    Const TamFonte : SmallWord;

                    Const NomeDestino : PathStr;
                    Var regDestino;
                    Const TamDestino : SmallWord;

                    Const AtualizaDestino : TFuncGetAddRec;

                    Const OkMakeFile :Boolean) : Boolean;
Var
  ArqFonte,ArqDestino   : TMI_DataFile;
  NRecFonte,NRecDestino : Longint;
  TamArq                : Longint;
  _Progress1Passo : TProgressDlg_If;
Begin
  GetAddRec := False;
  Init_MI_DataFile (ArqFonte  ,NomeFonte  ,TamFonte  ,0);
  Init_MI_DataFile (ArqDestino,NomeDestino,TamDestino,0);

  If Not FileExists(NomeFonte) Then
  Begin Raise TException.Create7('',
                                'Tb_Access.Pas',
                                 'TTb_access',
                                'GetAddRec',
                                   'Fonte='+NomeFonte+' ,Destino='+NomeDestino,
                                   '',
                                   'Não existe arquivo fonte... '+NomeFonte);
  End;

  Try
    AbreArqSemHeader(ArqFonte,RegFonte);
    If ok Then
    Begin
      If OkMakeFile Then
      Begin
        MakeFile(ArqDestino);
        CloseFile(ArqDestino);
      End;
      OpenFile(ArqDestino,True);
    End;

    If Ok Then
    with TDates.HoraInicial do
    Begin
      Try
        TamArq := FileSize(ArqFonte.Df)-1;
        NRecFonte := 0;
        Try
          _Progress1Passo := TProgressDlg_If_Class.Create('Gerando novo arquivo...',Title,Delta_Locate,TamArq);
          For NRecFonte := 1 to tamArq do
               Begin
                  _Progress1Passo.IncPosition();
                  FillChar(RegDestino,TamDestino,0);
                  ok := GetRec(ArqFonte.Df,NRecFonte,RegFonte);
                  If ok
                  Then Begin
                         NRec := PrimeiroLivre(ArqDestino);
                         If (Longint(RegFonte)=0)
                         Then If AtualizaDestino(RegFonte,TamFonte,RegDestino,TamDestino)
                              Then Ok := AddRec(ArqDestino,NRecDestino,RegDestino);
                       End;
               End;

        Finally
         Discard(TObject(_Progress1Passo));
        end;

      Except
         If TaStatus=0
         Then TaStatus := Erro_Excecao_inesperada;
         Raise TException.Create7('',
                                'Tb_Access.Pas',
                                 'TTb_access',
                                'GetAddRec',
                                   'Fonte='+NomeFonte+' ,Destino='+NomeDestino,
                                   '',
                                   TaStatus);
      end;

    End;
  Finally
    GetAddRec  := Ok;
    CloseArqSemHeader(ArqFonte  );
    CloseFile(ArqDestino);

  End;
End;

class function TTb__access.ModifyStructurFile(Const FName  : FileName;
                                              Const RecLenDest : SmallWord):Boolean;
Var
  wFileModeDenyALL        : Boolean;

  RegFonte,
  RegDestino          : Pointer;
  NomeDestino,
  NomeAnterior        : PathStr;

  aOkTransaction: Boolean;

  RecLenFont    : Longint;

Begin

  Try
    RegFonte       := nil;
    RegDestino     := nil;

// Desabilito a transacao por que se der errado ele faz novamente na próxima ves que abrir a tabela.
// Se nao o fizer o commit gerar um erro de GPF.
    aOkTransaction := SetOkTransaction(False);

    if Assigned(MI_MsgBox) then
    with Mi_MsgBox do
      MessageBox('O tamanho do registro do arquivo '+FName+' maior que a Versão em disco.'+^M+
                 ^M+
                 'A função "ModifyStructurFile" ajusta o arquivo para refletir a Versão corrente.'
                 ,mtError, mbOKButton,mbOk);

    RecLenFont := FTamRegDataFile(FName) ;
    If (RecLenFont=0)
    Then raise TException.Create7('',
                            'Tb_Access.Pas',
                            'TTb_access',
                            'ModifyStructurFile',
                            FName,
                            '',
                            'O arquivo e disco esta com tamanho em bytes igual a zero. Não posso contituar!');

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
          NomeAnterior := FTrocaExtencao(NomeAnterior,
                                         Const_Ext_Tabela_com_a_copia_da_versao_anterior_da_tabela
                                        );
          delFile(NomeAnterior);
          If Ren(FName,NomeAnterior)
          Then ok := Ren(NomeDestino,FName)
          Else Ok := false;
        End;
      End;
    End
    else Begin
           TaStatus := ErroArquivoFechado;
           TException.Create7('',
                                       'Tb_Access.Pas',
                                       'TTb_access',
                                       'ModifyStructurFile',
                                       FName,
                                       '',
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

class function TTb__access.PrimeiroLivre(VAR DatF: TMI_DataFile) : LONGINT;
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

class function TTb__access.TraveArq(Var DatF : TMI_DataFile):Boolean;
Var
  ok : Boolean;
Begin
  Try
//    {$IFDEF TaDebug}Application.Push_MsgErro('Tb_Access.TraveArq',ListaDeChamadas);{$ENDIF}
    If (Not FileModeDenyALL) and (not get_ok_Set_Transaction) Then
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

class function TTb__access. DestraveArq(Var DatF : TMI_DataFile):Boolean;
Var
  ok : Boolean;
Begin
  Try
//    {$IFDEF TaDebug}Application.Push_MsgErro('Tb_Access.DestraveArq',ListaDeChamadas);{$ENDIF}
    If (Not FileModeDenyALL) and (not get_ok_Set_Transaction) Then
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

class function TTb__access.UsedRecs(var DatF : TMI_DataFile ) : Longint;
begin
  Result := UsedRecs(DatF.Df);
end;


class function TTb__Access. AssingLst(Const WopcaoRedireciona : AnsiChar; {I=Impressora; A e R = Arquivo}
                                       Const aNomeRedireciona   : PathStr
                                      ):Boolean;
Var
  WFileModeDenyALL : Boolean;
  {$I-}
Begin
  AssingLst := False;
  opcaoRedireciona := WopcaoRedireciona;
  case opcaoRedireciona of
   'I'  : RedirecionaParaImpressora;
   'A',    {Arquivo do usuario com 23 linhas}
   'R' :   {Arquivo do usuario com 63 linhas}
          Begin
            CloseLST;
            PortaDaImpressora := ParamStr(0)+'_Impressora.txt';
            WFileModeDenyALL := FileModeDenyALL ;

            Set_FileModeDenyALL(True);
            If Not FileShared(aNomeRedireciona) Then
            Begin
              Set_FileModeDenyALL(WFileModeDenyALL);

              if Assigned(MI_MsgBox) then
              with Mi_MsgBox do
                MessageBox('Arquivo de relatório está sendo usado em outro processo.',
                            mtWarning, mbOKButton,mbOk);
              Exit;
            End;

            RedirecionaImpressora := True;
            RedirecionaImpNul     := False;

            AssignFile(lst,aNomeRedireciona);

            If Rewrite(lst,fileMode) <> 0 Then
            Begin
              Set_FileModeDenyALL(WFileModeDenyALL);

              if Assigned(MI_MsgBox) then
              with Mi_MsgBox do
                MessageBox('Erro ao criar arquivo de impressão: '+aNomeRedireciona,MtError, mbOKButton,mbOk);
              Exit;
            End;
            Set_FileModeDenyALL(WFileModeDenyALL);
          End;
  End;
  AssingLst := true;

End;

class procedure TTb__Access.redirecionaParaNul;
Begin
  If ApartirDeQuePagina = PaginaInicial  then
  Begin
    exit;
  end;

  If (ContaPagina < ApartirDeQuePagina) and (Not redirecionaImpNul)  Then
  Begin
    If TextRec(Lst).Mode = FmOutput Then
    begin
      Ok := IoResult=0;
      System.close(lst);
      Ok := IoResult = 0;
      redirecionaImpressora := True;
      redirecionaImpNul     := True;
      AssignFile(lst,'NUL');
      If Rewrite(lst,fileMode)<> 0 Then
        RunError(TaStatus);
    end;
  End
  Else
   If ApartirDeQuePagina = ContaPagina Then RedirecionaRelatorio;

End;

{IFDEF Generic}
{ VAR MsgTamArquivo : tString;}
{ENDIF}

class function TTb__Access. GeraSequencia(Var ArqI:IndexFile) :Longint;
  Var
    WNr,
    Retorno   : Longint;
    Err       : Integer;
    WChave    : tString;
Begin
   ClearKey(ArqI);
   PrevKey(ArqI,WNr,Wchave);
   if (Not ok)  Then
     Retorno:= 1
   Else
   Begin
     system.Val(Wchave,Retorno,Err);
     If Err <> 0 Then
       Retorno:= 1
     Else
       Inc(Retorno);
   End;
   GeraSequencia := Retorno;
End;

class function TTb__Access. TestaAberturaDeArquivo(MaxFile : Byte; {:< Número máximo de arquivo a ser aberto}
                                                   Var NumMaxPossivel:Byte {:< Devolve o número de arquivos que conseguiu abrir }
                                                   ): Boolean;
Var
  i       : Byte;
  NomeArq : PathStr;
  Arquivo : Array[1..254] of File of byte;
  iAberto : Byte;
   _Progress1Passo : TProgressDlg_If;
Begin
  iAberto := 0;
  _Progress1Passo := TProgressDlg_If.Create('TESTANDO...','M�ximo de arquivos abertos',Delta_Locate,MaxFile);

  TestaAberturaDeArquivo := True;
  If MaxFile > 254 Then
  Begin
    WriteLn('O Numero maximo de arquivos aberto que o DOS permite e 254');
    RunError(muitosArquivosAbertoSimultaneamente);
  end;
  {Cria o numero maximo de arquivos }
  for i := 1 to MaxFile do
  Begin
//    SetProgress1Passo(AProgress1Passo,I);
    _Progress1Passo.IncPosition();
    system.Str(i,NomeArq);
    NomeArq := NomeArq+ '.$$$';
    NomeArq := ExpandFileName(LowerCase(ExtractFileName(NomeArq)));
    AssignFile(Arquivo[i],NomeArq);
    IoResult;
    system.rewrite(Arquivo[i]);
    ok := IoResult = 0;
    if Not ok Then
    Begin
      TestaAberturaDeArquivo := false;
      NumMaxPossivel  := i;
      Break; { Forca a saída do loop }
    end
    Else iAberto := i;
  End;

//  CloseProgress1Passo(AProgress1Passo);
  Discard(TObject(_Progress1Passo));

  {Fecha e deleta o máximo de arquivos que foram abertos }
  MaxFilesOpens := IAberto;
  _Progress1Passo := TProgressDlg_If.Create('FECHANDO...','Os arquivos abertos',Delta_Locate,MaxFilesOpens);

  For i := 1 to iAberto do
  Begin
    //SetProgress1Passo(AProgress1Passo,I);
    _Progress1Passo.IncPosition();
    If Close(File(Arquivo[i])) Then
    Begin
      {$i-}
      Erase(Arquivo[i]);
      {$i+}
      IoResult;
    End
    Else
      Dec(MaxFilesOpens);
  End;
//  CloseProgress1Passo(AProgress1Passo);
  Discard(TObject(_Progress1Passo));
  TaStatus := 0;

end;






class function TTb__Access. StrDataEmQueFoiAlterado(Const NomeArquivo :PathStr) : tString;
var
  DirInfo : SearchRec;
  dt      : DateTime;
begin
//  {$IFDEF TaDebug}Application.Push_MsgErro('Tb__Access.StrDataEmQueFoiAlterado',ListaDeChamadas);{$ENDIF}
  ok := true;
  findFirst(NomeArquivo,Archive,dirInfo);
  if dosError <> 0 then Begin
    StrDataEmQueFoiAlterado := '';
    ok      := false;
  End
  Else Begin
   UnPackTime(dirInfo.Time,dt);
   StrDataEmQueFoiAlterado := 'Data: '+Int2Str(dt.Day)+'/'+Int2Str(dt.Month)+'/'+
                           Int2Str(dt.Year)+
                           ' Hora: '+Int2Str(dt.Hour)+':'+Int2Str(dt.Min);
  end;

end;

class function TTb__Access. StrDateFile(Const NomeArquivo : PathStr;Const Ch:AnsiChar) : tString;
var
  DirInfo : SearchRec;
begin
  ok := true;
  findFirst(NomeArquivo,Archive,dirInfo);
  if dosError <> 0 then
  Begin
    StrDateFile:= '';
    ok      := false;
  End
  Else
   StrDateFile := TDates.StringTimeD(dirInfo.Time,Ch);
end;



class function TTb__Access.CreateLst:Boolean;
{Inicializa o dispositivo de impressao para o arquivo com o nome do usuario}
begin
  Try
    CreateLst := False;
    if Not DirectoryExists(Application.ParamExecucao.EnvironmentVariables.DirTemp) Then
      ok := CreateDir(Application.ParamExecucao.EnvironmentVariables.DirTemp);

    If Not Ok Then
      if Assigned(MI_MsgBox) then
        with Mi_MsgBox do
        Begin
          MessageBox(^C+'não é possivel criar diretório para os relatórios.',mtError, mbOKButton,mbOk);
          Exit;
        End;

    If FileNameTemp_Ext(NomeRedireciona,'Prn') Then
    Begin
      CreateLst := AssingLst('A',NomeRedireciona);
    End;

  Finally

  End;
End;

class procedure TTb__Access. DestroyLst;
Begin

  CloseLst;




End;


class function TTb__Access. FPackDataFile(NomeArq  :PathStr):Boolean;
Var
  ArqFonte,
  ArqDestino  : TMI_DataFile;
  NRecDestino,
  TamArq,NRec     : Longint;
  Reg        : Pointer;
  BlocksRead : SmallWord;
  Head       : TsImagemHeader;
   _Progress1Passo : TProgressDlg_If;

  {$I-}
Begin
//  {$IFDEF TaDebug}Application.Push_MsgErro('Tb__Access.FPackDataFile',ListaDeChamadas);{$ENDIF}
  {Pega o tamanho do resgistro no proprio arquivo}

  FillChar(ArqFonte,sizeof(ArqFonte),0);
  FillChar(ArqDestino,sizeof(ArqDestino),0);

  AssignDataFile(ArqFonte.Df,NomeArq,0,FileHeaderSize);

  ArqFonte.Df.F.Reset(FileMode,ShareMode);
  Ok := TaStatus = 0;

  IF ok Then
  Begin
    BlocksRead := ArqFonte.Df.F.BLOCKREAD(0,TaRecBuf^,1);
    IF (TaStatus<> 0  ) or (BlocksRead = 0) THEN
    Begin
      RunError(TaStatus);
    End;
    MOVE(TaRecBuf^,Head,FileHeaderSize);
    Discard(TObject(ArqFonte.Df.F));
    TaStatus := IoResult;
  End
  Else
  Begin
    with Application.Mi_MsgBox do
    MessageBox('ERRO: '+Istr(TaStatus,'999')+' Em  FPackDataFile',MtError, mbOKButton,MbOk) ;

    FPackDataFile := False;

    Exit;
  End;

  If FGetMem(Reg,Head.ItemSize) Then
  Begin
    Init_MI_DataFile(ArqFonte,NomeArq,Head.ItemSize,0);
    Init_MI_DataFile(ArqDestino,FTrocaExtencao(NomeArq,'$$$'),Head.ItemSize,0);
    OpenFile(ArqFonte);
    If Ok Then
    Begin
      MakeFile(ArqDestino); {Arquivo sem os items deletados}
      If Ok Then
      Begin {Compia os items que nao estão deletados para ArqItemDestino}
        TamArq := FileSize(ArqFonte.DF)-1;
        //OpenProgressDlg('AGUARDE: Limpando arquivo'+NomeArq,'',TamArq);
        _Progress1Passo := Application.TProgressDlg_If.Create('AGUARDE: Limpando arquivo'+NomeArq,'',Delta_Locate,TamArq);
        For NRec := 1 to TamArq do
        Begin
          _Progress1Passo.IncPosition();
          GetRec(ArqFonte,NRec,Reg^);
          If ok Then
          Begin
            If (Longint(Reg^) = 0) Then  {Nao Deletado ou Nao outras condicoes}
              AddRec(ArqDestino,NRecDestino,Reg^); {So passa os registros validos}
          End; {If ArqItems.SiGotoReg(NRec) Then}
        End;{For NRec := 1 to ArqItems.TamArq do}
        CloseFile(ArqDestino);
        CloseFile(ArqFonte);
        If DelFile(NomeArq) Then
          Ren(ArqDestino.NomeArq,ArqFonte.NomeArq);
        //CloseProgressDlg;
        Discard(TObject(_Progress1Passo));
      End;
    End;
    FFreeMem(Reg,Head.ItemSize)
  End
  Else Ok := False;
  FPackDataFile:=ok;

End;


class function TTb__Access.EspacoEmDisco(NomeFonte,DriveDestino:PathStr) :boolean;
  var
    DirInfo  : SearchRec;
    SizeFiles,
    DiscoLivre : Int64;

begin
  SizeFiles := 0;
  DriveDestino := ExpandFileName(LowerCase(ExtractFileName(DriveDestino)));

  If DriveDestino[length(DriveDestino)] = '\'
  Then DriveDestino:= DriveDestino+ '*.*';

  NomeFonte := ExpandFileName(LowerCase(ExtractFileName(NomeFonte)));
  If NomeFonte[length(NomeFonte)] = '\'
  Then NomeFonte := NomeFonte + '*.*';

  findFirst(NomeFonte,Archive,dirInfo);
  While dosError = 0 do
  with dirInfo do
  begin
    SizeFiles  := SizeFiles + Size;
    FindNext(DirInfo);
  end;

  TaStatus := diskFree(ByteDrive(DriveDestino),DiscoLivre) ;
  ok := TaStatus = 0;
  //DiscoLivre := VPSysLow.SysDiskFreeLong(ByteDrive(DriveDestino));
  if ok
  then begin
         Result := SizeFiles < DiscoLivre;
       end
  else begin
         result := ok;
         Raise TException.Create7('',
                           'mi.rtl.objects.methods.db.tb__access.Pas',
                           'TTb__Access',
                           'EspacoEmDisco',
                           DriveDestino,
                           '',
                           TaStatus);
       end;

end;


class function TTb__Access. TTraveRegistro(Var  DatF : TMI_DataFile;Const R : Longint):Boolean;
Begin
  TTraveRegistro := TraveRegistro(DatF.DF,R);
End;

class function TTb__Access. TDestraveRegistro(Var  DatF : TMI_DataFile;Const R : Longint):Boolean;
Begin
//  {$IFDEF TaDebug}Application.Push_MsgErro('Tb__Access.TDestraveRegistro',ListaDeChamadas);{$ENDIF}
  TDestraveRegistro := DestraveRegistro(DatF.Df,R);

End;
(*
class function TTb__Access. NomeDaEstacao:tString;

{Int21
 RETORNA EM ds:dx O NUMERO DA ESTACAO.

 AX = 5E00h
 DS:DX -> 16-byte buffer for ASCII machine name

 Return:CF clear if successful
 CH = validity
 00h name invalid
 nonzero valid
 CL = NetBIOS number for machine name
 DS:DX buffer filled with blank-paded name
 CF set on error
 AX = error code (01h) (see #01680 at AH=59h)

 Note: Supported by OS/2 v1.3+ compatibility box, PC-NFS

 See Also: AX=5E01h

 Category: DOS Kernel - Int 21h - D

=========================================================
10NET v5.0 - GET MACHINE NAME
AX = 5E00h
Return:CL = redirector's NetBIOS name number
ES:DI -> network node ID

See Also: AX=5E01h"10NET"

Category: Network - Int 21h - @
=========================================================}

  Type
    TNomeDaEstacao  = Array[0..254] of AnsiChar;
  Var
    Regs             : Registers;
    aNomeDaEstacao   : TNomeDaEstacao;
    StrNomeDaEstacao : tString;
Begin
//  {$IFDEF TaDebug}Application.Push_MsgErro('Tb__Access.NomeDaEstacao',ListaDeChamadas);{$ENDIF}
  With regs do
  Begin
    AX  := $5E00; {Retorna o nome da estacao da rede}
    {Define o Buffer de retorno do nome da estacao}
    DS   := Seg(aNomeDaEstacao);
    DX   := Ofs(aNomeDaEstacao);
    MsDos(regs); {Executa Int21}
    NetErr := Flags and Fcarry;
    If NetErr <> 0 Then
    Begin
      NetErr         := Ax;
      TaStatus       := NetErr;
      StrNomeDaEstacao := '';
    end
    Else
    Begin
      StrNomeDaEstacao  := StrPas(aNomeDaEstacao);
      While (length(StrNomeDaEstacao) > 0) and
            (StrNomeDaEstacao[length(StrNomeDaEstacao)] = ' ') do
          Delete(StrNomeDaEstacao,length(StrNomeDaEstacao),1);
      TaStatus := 0;
    End;
  End;
  NomeDaEstacao  := StrNomeDaEstacao;

end;
*)
class function TTb__Access.NomeDaEstacao:tString;
  Type
    TNomeDaEstacao  = Array[0..254] of AnsiChar;
  Var
    aNomeDaEstacao   : TNomeDaEstacao;
  //  StrNomeDaEstacao : tString;
Begin
  abstracts;
  NomeDaEstacao  := 'Falta implementar esta funcao para rodar no windows e no linux';

end;


//class procedure TTb__Access. TSeek(Var DatF : TMI_DataFile;Const R : Longint );
//Label
//  Inicio;
//Begin
//Inicio:
//  DatF.Df.F.Seek(R);
//  Ok := TaStatus = 0;
//  If Not Ok Then
//  Begin
//    TaIOcheck(DatF.Df,R);
//    Goto Inicio;
//  End;
//End;

class function TTb__Access.Seek(Var DatF : TMI_DataFile;Const R : Longint ):SmallInt;
Begin
  DatF.Df.F.Seek(R);
  Ok :=  TaSTatus =0;
  result := TaStatus;
End;



class function TTb__Access.DeleteRec(var DatF : TMI_DataFile ;Const R : Longint):Boolean;
begin
  result := DeleteRec(DatF.Df,R);
end;


class function TTb__Access.FindKey(var IxF : TMI_IndexFile;
                                   var ProcDatRef : Longint;
                                       ProcKey    : TaKeyStr):Boolean ;
Begin
  ProcKey := UpperCase(ProcKey);
  FindKey(IxF.Ix,ProcDatRef,ProcKey);
  result := ok;
End;

class function TTb__Access. AdicioneChave(var IxF : TMI_IndexFile ;
                       Const ProcDatRef : Longint;
                       Const ProcKey    : TaKeyStr):Boolean;
begin
//  {$IFDEF TaDebug}Application.Push_MsgErro('Tb__Access.AdicioneChave',ListaDeChamadas);{$ENDIF}
  AddKey(IxF.Ix,ProcDatRef,UpperCase(ProcKey));
  If IxF.OkMsgDuplicidade Then
  Begin
    If (Not ok)
    Then with Application.Mi_MsgBox do
           MessageBox('Arquivo: '+TMI_IndexFile(IxF).NomeArqIndice+^M+
                      ^M+
                      'Chave: '+ProcKey +' em duplicidade.'
                      ,MtError, mbOKButton,mbOk);
  End
  Else
    ok := True;
  AdicioneChave := ok;

end;

class function TTb__Access. EliminaChave(var IxF : TMI_IndexFile ; Const ProcDatRef : Longint; Const ProcKey : TaKeyStr):Boolean;
  Var
    wProcKey : TaKeyStr;
begin
  wProcKey  := ProcKey ;
  DeleteKey(IxF.Ix,ProcDatRef,wProcKey);

  If IxF.OkMsgDuplicidade Then
  Begin
    If (Not ok)
    Then with Application.Mi_MsgBox do
          MessageBox('Arquivo: '+TMI_IndexFile(IxF).NomeArqIndice+^M+
                     ^M+
                     'Chave: '+ProcKey +' inexistente.',MtError, mbOKButton,mbOk);
  End
  Else
    ok := true;
  EliminaChave := ok;

end;



//class procedure TTb__Access. AppendBlank(Var Buff) ;
//Begin
//End;



{    ROTINAS PARA TRATAMENTO DE ARQUIVOS }
class function TTb__Access. GetRec(var DatF : TMI_DataFile ;Const R : Longint;var Buffer  ):Boolean;
begin
  ok := GetRec(DatF.Df,R,Buffer);
  if ok
  then ok := Longint(Buffer)=0;
  result := ok;
end;

class function TTb__Access.PutRec(var DatF : TMI_DataFile ;Const R : Longint;var Buffer  ):Boolean;

begin
  PutRec(DatF.Df,R,Buffer);
  result := ok;
end;

class procedure TTb__Access.FlushFile(var DatF : TMI_DataFile );
begin
  with DatF,Df do
    FlushFile(Df);
end;

class procedure TTb__Access. FlushIndex(var IxF : TMI_IndexFile );
begin
  with IxF,Ix,DataF do FlushIndex(TMI_IndexFile(IxF).Ix);
end;


class function TTb__Access. AddRec(var DatF : TMI_DataFile ;var R : Longint;var Buffer ):Boolean;
begin
  result := addRec(DatF.df,R,Buffer);
  result:= ok;
end;


class function TTb__Access.FileLen(var DatF : TMI_DataFile ) : Longint;
begin
  result := FileLen(DatF.Df);
end;

class function TTb__Access.MakeIndex(var IxF : TMI_IndexFile;Exclusivo:Boolean ):Integer;
Var
  WFileModeDenyALL : Boolean;
Begin
  WFileModeDenyALL := FileModeDenyALL;
  Set_FileModeDenyALL(Exclusivo);
  Result := MakeIndex(IxF);
  Set_FileModeDenyALL(WFileModeDenyALL);
End;

class function TTb__Access.OpenIndex(var IxF : TMI_IndexFile;Exclusivo:Boolean ):Integer;
  Var
    WFileModeDenyALL : Boolean;
Begin
  WFileModeDenyALL  := Set_FileModeDenyALL(Exclusivo);
  result := OpenIndex(IxF);
  Set_FileModeDenyALL(WFileModeDenyALL);
End;

class function TTb__Access.ClearKey(var IxF : TMI_IndexFile) :Boolean;
begin
  If IxF.Ix.OrderByDesc
  Then Begin
         ClearKey(IxF.Ix);
       End
  Else ClearKey(IxF.Ix);
  Result := Ok;
end;

class function TTb__Access.NextKey(var IxF : TMI_IndexFile ; var ProcDatRef : Longint; var ProcKey ):Boolean;
begin
  If IxF.Ix.OrderByDesc Then
    PrevKey(IxF.Ix,ProcDatRef,ProcKey)
  Else
    NextKey(IxF.Ix,ProcDatRef,ProcKey) ;
  Result := ok;
end;

class function TTb__Access.PrevKey(var IxF : TMI_IndexFile ; var ProcDatRef : Longint; var ProcKey ):Boolean;
begin
  If IxF.Ix.OrderByDesc
  Then NextKey(IxF.Ix,ProcDatRef,ProcKey)
  Else PrevKey(IxF.Ix,ProcDatRef,ProcKey);
  Result := ok;
end;

class function TTb__Access.FindKeyTop(var IxF : TMI_IndexFile ; var ProcDatRef : Longint; var ProcKey ):Boolean;
  { Retorna o número do registro da chave da ultima nocorrência repetida
    se o index permite chave duplicada.
  }
Begin
  If IxF.Ix.OrderByDesc
  Then Result := FindKey(IxF.Ix,ProcDatRef,ProcKey)
  Else Result := FindKeyTop(IxF.Ix,ProcDatRef,ProcKey);
end;

class function TTb__Access.FindKey(var IxF : TMI_IndexFile ; var ProcDatRef : Longint; var ProcKey ):Boolean;
begin
  If IxF.Ix.OrderByDesc
  Then Result := FindKeyTop(IxF.Ix,ProcDatRef,ProcKey)
  Else Result := FindKey(IxF.Ix,ProcDatRef,ProcKey);
end;

class function TTb__Access.SearchKey(var IxF : TMI_IndexFile ; var ProcDatRef : Longint; var ProcKey:TaKeyStr ):Boolean;
begin
  If IxF.Ix.OrderByDesc
  Then Result := SearchKeyTop(IxF.Ix,ProcDatRef,ProcKey,False)
  Else Result := SearchKey(IxF.Ix,ProcDatRef,ProcKey);
end;

class function TTb__Access.SearchKeyTop(var IxF : TMI_IndexFile ; var ProcDatRef : Longint; var ProcKey:TaKeyStr;Const Okequal : Boolean ):Boolean;
begin
  If IxF.Ix.OrderByDesc
  Then Result := SearchKey(IxF.Ix,ProcDatRef,ProcKey)
  Else Result := SearchKeyTop(IxF.Ix,ProcDatRef,ProcKey,false);
end;

class function TTb__Access.AddKey(var IxF : TMI_IndexFile ;Const  ProcDatRef : Longint; Const ProcKey:TaKeyStr ):Boolean;
begin
  AddKey(IxF.Ix,ProcDatRef,ProcKey);//{UpperCase(ProcKey));
  If IxF.OkMsgDuplicidade Then
  Begin
    Result:= ok;
    If (Not ok)
    Then with Application.Mi_MsgBox do
           MessageBox(
                      'Arquivo: '+TMI_IndexFile(IxF).NomeArqIndice+^M+
                      ^M+
                      'Chave: '+ProcKey+' em duplicidade.'
                      ,MtError, mbOKButton,mbOk);

  End
  Else
    Result := True;
end;

class function TTb__Access.DeleteKey(var IxF : TMI_IndexFile ; Const ProcDatRef : Longint; Const ProcKey:TaKeyStr ):Boolean;
  Var
    wProcKey:TaKeyStr;
begin
  wProcKey  := ProcKey;
  DeleteKey(IxF.Ix,ProcDatRef,taKeyStr(wProcKey));//UpperCase(ProcKey));
  Result := Ok;

  If Not ok
  Then with Application.Mi_MsgBox do
         MessageBox('Arquivo: '+TMI_IndexFile(IxF).NomeArqIndice+^M+
                    ^M+
                    ' Chave : '+ProcKey+' inexistente.'
                    ,MtError, mbOKButton,mbOk);

end;

{}


class function TTb__Access.OpenIndex(var IxF : TMI_IndexFile;Exclusivo,OkCreate:Boolean ):Integer;
begin
  TaStatus := OpenIndex(IxF,Exclusivo);
  if OkCreate and  (not ok) And (TaStatus in [ArquivoNaoEncontrado2,ArquivoNaoEncontrado18]) then
  begin with Application.Mi_MsgBox do
    If MessageBox('O arquivo '+IxF.nomeArqIndice+' não existe.'+^M+
                  ^M+
                  'Cria os arquivo agora?'
                  ,mtConfirmation,mbYesNoCancel,mbYes)= MrYes
    Then begin
           TaStatus := MakeIndex(IxF,FileModeDenyALL);
           If TaStatus  = 0
           Then Begin
                  CloseIndex(IxF);
                  TaStatus := OpenIndex(IxF,Exclusivo);
                End;
         end;
  end; { Nao ok }

  Result:= TaStatus ;
  Ok := Result = 0;
end;


class function TTb__Access. ValidFileName(Const Name : PathStr):Byte;
{Se o nome do arquivo nao for valido devolve a posição do erro.
 Se for valido devolve 0
}
Var
  I: Integer;
Begin
  For i := 1 to length(Name) do
    If Name[i] in [' ','\','/']
    Then BEGIN
           ValidFileName := I;
           EXIT;
         END;

  ValidFileName := 0;
End;


class function TTb__Access. FConcatNomeArq(Nome,Extencao:PathStr) : PathStr;
Begin
//  {$IFDEF TaDebug}Application.Push_MsgErro('Tb__Access.FConcatNomeArq',ListaDeChamadas);{$ENDIF}

  While ValidFileName(Nome) <> 0 do
    Delete(Nome,ValidFileName(Nome),1);

  If Nome <> ''
  Then Begin
         If Pos('.',nome) <> 0
         Then Result := Copy(Nome,1,Pos('.',Nome)) +Extencao
         Else Result := Nome+'.'+Extencao;
       End
  Else FileNameTemp_Ext(Result,Extencao);


End;
class function TTb__Access. CriaArqTemp(Var ArqF : TMI_DataFile;
                     Const TamArqTemp : SmallWord;
                     Const NumeroDeIndice : Byte ):Boolean; { Cria arquivo temporario }

Var
  NomeArq_Tb : PathStr;
  WStateFmMemory_Temp:Boolean;
Begin
  Try
//    {$IFDEF TaDebug}Application.Push_MsgErro('Tb__Access.CriaArqTemp',ListaDeChamadas);{$ENDIF}

    WStateFmMemory_Temp :=  SetStateFileMode(FmMemory_Temp,true);

    FillChar(ArqF,Sizeof(ArqF),0);
    If FileNameTemp_Ext(NomeArq_Tb,'T$$')
    Then Begin
           Init_MI_DataFile (  ArqF,NomeArq_Tb,TamArqTemp,NumeroDeIndice);
           ArqF.Df.OkTemporario  := True;
           MakeFile(ArqF);
           If Ok Then CloseFile(ArqF.dF,true);
         End;

  Finally
    Result := ok;
    SetStateFileMode(FmMemory_Temp,WStateFmMemory_Temp);

  End;

end;

class function TTb__Access. CriaArqTempI(Var IxF: TMI_IndexFile;
                      Const RepeteChave : Byte;
                                  Const  EndChaveNoRegistro: tString):Boolean; { Cria arquivo temporario }

  Var NomeArq_Ix : PathStr;
      WStateFmMemory_Temp:Boolean;
Begin
  Try

    WStateFmMemory_Temp :=  SetStateFileMode(FmMemory_Temp,true);

    FillChar(IxF,Sizeof(IxF),0);
    ok :=  FileNameTemp_Ext(NomeArq_Ix,'I$$');
    If ok
    Then; Begin { Atualiza FileRec }
            Init_IxF(1,IxF,NomeArq_ix,1,EndChaveNoRegistro);
            IxF.Ix.dataF.OkTemporario := true;

            MakeIndex(IxF);
            If Ok Then
              CloseIndex(IxF.Ix,True);
          end;
  Finally
    Result := ok;
    SetStateFileMode(FmMemory_Temp,WStateFmMemory_Temp);


  End;
end;

class function TTb__Access.  FLeiaGrave (Const     MsgStr    : tString;
                      Const     NomeArqDados  : PathStr;
                      Var RegBuff   ;
                      Const     TamRegBuff    : SmallWord;
                      Const    OkFunc    : TipoFuncao) : Boolean;
 Var
   NumRegALer,NR : Longint;
 Var
   ArqDados : TMI_DataFile;
   _Progress1Passo : TProgressDlg_If;
Begin
//  {$IFDEF TaDebug}Application.Push_MsgErro('Tb__Access.FLeiaGrave',ListaDeChamadas);{$ENDIF}
  Init_MI_DataFile (ArqDados,NomeArqDados,TamRegBuff,0 );
  OpenFile(ArqDados,true);
  If ok Then
    FLeiaGrave := True
  else
  Begin
    FLeiaGrave := False;

    Exit;
  End;
  NumRegALer := FileSize(ArqDados.Df)-1;

  _Progress1Passo := Application.TProgressDlg_If.Create('AGUARDE: Processando '+ArqDados.NomeArq,'',Delta_Locate,NumRegALer);
  For NR := 1 to NumRegALer do
  begin
    NRec := Nr;
//    if ProgressDlg <> nil Then ProgressDlg.SetPerc(NRec);
    _Progress1Passo.IncPosition();

    GetRec(ArqDados,NRec,RegBuff);
    If OkFunc Then
      PutRec(ArqDados,NRec,RegBuff);
  End;
  //CloseProgressDlg;
  Discard(TObject(_Progress1Passo));
  CloseFile(ArqDados);

End;

class function TTb__Access.  LeiaGrave (Const     MsgStr    : tString;
                     Var ArqDados  : TMI_DataFile;
                     Var RegBuff   ;
                     Const     OkFunc    : TipoFuncao) : Boolean;

Begin
//  {$IFDEF TaDebug}Application.Push_MsgErro('Tb__Access.LeiaGrave',ListaDeChamadas);{$ENDIF}
  IF Not Is_TFileOpen(ArqDados.Df.F) Then
    LeiaGrave := FLeiaGrave(MsgStr,ArqDados.NomeArq,RegBuff,ArqDados.TamReg,OkFunc)
  Else
  Begin
    CloseFile(ArqDados);
    LeiaGrave := FLeiaGrave(MsgStr,ArqDados.NomeArq,RegBuff,ArqDados.TamReg,OkFunc);
    OpenFile(ArqDados);
  End;

End;

class function TTb__Access. FLeieEGraveRegistro(Const     NomeFonte:PathStr;
                             Var RegFonte;
                             Const     TamFonte : SmallWord;

                             Const     NomeDestino : PathStr;
                             Var regDestino;
                             Const     TamDestino : SmallWord;
                             AtualizaDestino : TipoFuncao;
                             Const OkMakeFile :Boolean) : Boolean;
Var
  ArqFonte,ArqDestino   : TMI_DataFile;
  NRecFonte,NRecDestino : Longint;
  TamArq                : Longint;
Begin
//  {$IFDEF TaDebug}Application.Push_MsgErro('Tb__Access.FLeieEGraveRegistro',ListaDeChamadas);{$ENDIF}
  FLeieEGraveRegistro := False;
  Init_MI_DataFile (ArqFonte  ,NomeFonte  ,TamFonte  ,0);
  Init_MI_DataFile (ArqDestino,NomeDestino,TamDestino,0);
  If Not FileExists(NomeFonte) Then
  with Application.Mi_MsgBox do Begin
    MessageBox(
     'não existe arquivo fonte... '+NomeFonte
    ,MtError, mbOKButton,mbOk);

    Exit;
  End;
  OpenFile(ArqFonte,true);
  If ok Then
  Begin
    If OkMakeFile Then
    Begin
      MakeFile(ArqDestino);
      CloseFile(ArqDestino);
    End;
    OpenFile(ArqDestino,true);
  End;

  If Ok Then
  with TDates,HoraInicial do
  Begin
    GetTime(H, M, S, S100);


    tamArq := ArqFonte.Df.F.FileSize-1;
    For NRecFonte := 1 to tamArq do
    Begin
{      if NRecFonte Mod 10 = 0 then
        EscrevaTempoEstimado(NRecFonte,10,tamArq);}

      FillChar(RegDestino,Sizeof(TamDestino),0);
      GetRec(ArqFonte,NRecFonte,RegFonte);
      NRec := PrimeiroLivre(ArqDestino);
      If (Longint(RegFonte)=0) And AtualizaDestino Then
        AddRec(ArqDestino,NRecDestino,RegDestino);
    End;
  End;
  FLeieEGraveRegistro := Ok;
  CloseFile(ArqFonte  );
  CloseFile(ArqDestino);

End;

class procedure TTb__Access.CloseFilesOpens;
{ Fecha Todos os arquivos aberto ate o momento }
Begin
  If (@EndOpenFiles <> Nil) Then
    FilesOpens.SaveCurrentState;

  If (@EndCloseFiles <> Nil) Then
    EndCloseFiles;

  if FilesOpens<> nil
  then FilesOpens.FreeAll;

End;

{***************INICIO DE DestroyMEMORY E CreateMEMORY**************************}
{ As rotinas MyDestroyMemory e CreateMomory sao usadas para controla as chamadas
  a outros sistemas ou a DLLS
}
class procedure TTb__Access.MyDestroyMemory;
Begin
  CloseLst;
  If @EndCloseFiles <> Nil Then
  Begin
    EndCloseFiles;
    WEndCloseFiles := EndCloseFiles;
    EndCloseFiles  := nil;
  End
  Else
    WEndCloseFiles := nil;
  If @EndOpenFiles <> Nil Then
  Begin
    WEndOpenFiles:= EndOpenFiles;
    EndOpenFiles:= nil;
  End
  Else
    WEndOpenFiles := nil;
  CloseFilesOpens; {Se ficou algum arquivo aberto este rotina fecha}
End;

class procedure TTb__Access. MyCreateMemory;
Begin
  CreateLst;
  EndCloseFiles := WEndCloseFiles;
  EndOpenFiles  := WEndOpenFiles;
  If @EndOpenFiles <> Nil Then
    EndOpenFiles;
End;

{$REGION '***************INICIO DE DestroyMEMORY E CreateMEMORY sem video*************'}

   class procedure TTb__Access. MyDestroyMemorySemVideo;
   Begin
     DestroyLst;
     If @EndCloseFiles <> Nil Then
     Begin
       EndCloseFiles;
       WEndCloseFiles := EndCloseFiles;
       EndCloseFiles  := nil;
     End
     Else
       WEndCloseFiles := nil;
     If @EndOpenFiles <> Nil Then
     Begin
       WEndOpenFiles:= EndOpenFiles;
       EndOpenFiles:= nil;
     End
     Else
       WEndOpenFiles := nil;

     CloseFilesOpens; {Se ficou algum arquivo aberto este rotina fecha}
     WCursorLigado := WCursorLigado;
   End;

   class procedure TTb__Access. MyCreateMemorySemVideo;
   Begin
     CreateLst;
     EndCloseFiles := WEndCloseFiles;
     EndOpenFiles  := WEndOpenFiles;
     If @EndOpenFiles <> Nil Then
       EndOpenFiles;
   End;

{$ENDREGION '***************FIM DE DestroyMEMORY E CreateMEMORY sem video ***************'}


class function TTb__Access.ExecCommand(FileName:PathStr;Flags: Longint;aExecAsync : Longint): Byte;Overload;
Begin
  MyDestroyMemory;
  SwapVectors;
//  DOS.Exec(GetEnv('COMSPEC'), '/C ' + FileName,Flags,aExecAsync);
    DOS.Exec( FileName,'');
//  Procedure Exec(const path: pathstr; const comline: comstr)
  SwapVectors;
  Result := dosError;
  dosError    := 0;
  MyCreateMemory;
End;

class function TTb__Access. ExecCommand(FileName:PathStr;Flags: Longint): Byte;Overload;
Begin
  Result := ExecCommand(FileName,Flags,GetExecAsync);
end;



class function TTb__Access.ExecDos(Const Path: PathStr; Const ComLine: ComStr): Byte;

Begin
    Try // Finally
     Try // Except
       FilesOpens.CloseAllFiles;
       SwapVectors;

       DOS.Exec(Path,ComLine);

       SwapVectors;

     Except

       IF Tastatus = 0
       Then TaStatus := Erro_Excecao_inesperada;
       Raise TException.Create7('',
                                'mi.rtl.objects.methods.db.tb__access.Pas',
                                'TTb__Access',
                                'ExecDos',
                                path,
                                '',
                                TaStatus);
     End;

    Finally
      ExecDos:= dosError;
      TaStatus := dosError;
      FilesOpens.OpenAllFiles;
    End;
End;



Var
  okCreate : Boolean = false;
class procedure TTb__Access.Create;
Begin
  if not okCreate
  Then begin
         okCreate       := true;
         EndOpenFiles   := Nil;
         EndCloseFiles  := Nil;
         EndClearAll    := @TTb__Access.CloseFilesOpens;
         Set_FileModeDenyALL(False);
         CreateTAccess;
       end;
End;

{procedure TTb__Access. InicializaTb__Access;
Begin
  CreateTAccess;
  EndOpenFiles   := Nil;
  EndCloseFiles  := Nil;
  EndClearAll    := CloseFilesOpens;
  FuncTurboError := TurboError;
End;}

class procedure TTb__Access.Destroy;
Begin
  if okCreate
  Then begin
         DestroyLst;
         If @EndClearAll <> Nil Then
         Begin
           EndClearAll;
           EndClearAll := Nil;
         End;
         If @EndCloseFiles <> Nil Then
         Begin
           EndCloseFiles;
           EndOpenFiles  := nil;
           EndCloseFiles := nil;
         End;
         okCreate := false;
         DestroyTAccess;
       end;
End;

Initialization
  TTb__Access.Create;

Finalization
  TTb__Access.Destroy;

end.{@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@}


{********** Rotinas auto Inicializavel *************}



