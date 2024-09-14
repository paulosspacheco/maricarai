unit mi.rtl.Objects.Methods.Db.Tb___Access;
{:< Esta unit **@name** é usada para criar banco de dados local usando estrutura 
   **Type Record  End**;

  - **NOTA**
    - Comandos parecidos com clipper
    - Está obsoleto não recomendo seu uso.
}

// TODO: Remove essa unit do pacote porque está obsoleta.

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
    mi.rtl.objects.methods.db.tb_access,
    mi.rtl.objects.methods.db.tb__access  ;

  type TTb___Access_types = class(TTb__Access)
    {: Uma Base permite um arquivo de dados + Um arquivo de indice }
    Const MaxBase = 135;
    type TipoBaseDeDados = Array[1..MaxBase] of ^TipoPonteiroBD;
    type TipoSkip        = ( Next,Find,Prev,Searc);
    type TipoStatusArq    = (Aberto,fechado);
    type NumeroDeArquivos = (Um,Todos,TodosC); { Obs. TodosC usa-se na indexArquivos }


  end;

  type TTb___Access_consts = class(TTb___Access_types)
    Const NBase : Byte = 0;
    Const
      MatPFile : TipoBaseDeDados = (Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,
                                    Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,
                                    Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,
                                    Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,
                                    Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,
                                    Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,
                                    Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil );

  end;

  type

  { TTb___Access }

 TTb___Access = class(TTb___Access_consts)
    public class function OpenFile(var DatF    : TMI_DataFile ;
                                    var IxF : TMI_IndexFile;
                                    Const condicao  : NumeroDeArquivos ) : Integer;overload;

    public class procedure CloseFile(var DatF : TMI_DataFile ;
                                     var IxF : TMI_IndexFile ;
                                     Const condicao : NumeroDeArquivos );overload;

    public class function LocRegUse(Const P : TipoPonteiroBD): Byte;
    public class function  NRecSkip(Var Buff) : Longint;
    public class Procedure Replace(Var Buff);
    public class Procedure Locate(Var Buff;NRec:Longint);
    public class Procedure ReplaceUnLock(Var Buff);
    public class Procedure TrocaChave(Var Buff;
                                      Var IxF : TMI_IndexFile;
                                      ChaveAnterior,
                                      ChaveAtual   : TaKeyStr);

    public class function FPosicao(Posicao : Byte ) : Byte;
    public class function IndiceSele(Var Buff) : PathStr;
    public class Procedure ClearSkipAll;
    public class function Use(Var DatF : TMI_DataFile ;
                              Var IxF : TMI_IndexFile ;
                              Var Buff ):Boolean;

    public class Procedure UseC(Var Buff);

    public class Procedure Skip(Var Buff;
                                Var Chave : TaKeyStr;
                                Const ModoDePesquisa : TipoSkip );

    public class function  FSkip(Var Buff;
                                 Var Chave : tString;
                                 Const ModoDePesquisa : TipoSkip ):Boolean;

    public class function FSkipSearch(Var Buff;
                                      Chave : tString):Boolean;

    public class Procedure SeekRec(Var Buff;
                                   Var IxF : TMI_IndexFile ;
                                   Var Chave : TaKeyStr;
                                   Const ModoDePesquisa : TipoSkip );

    public class Procedure SkipLock(Var Buff;
                                    Var Chave : tString;
                                    Const ModoDePesquisa : TipoSkip );
    public class function LocRegSkip(P : TipoPonteiroBD): Byte;

    public class Procedure Sele(Var Buff;
                                Var IxF : TMI_IndexFile );

    public class Procedure AAddRec(Var Buff;Var IxF : TMI_IndexFile ; Var Chave : tString);overload;
    public class Procedure ADeleteRec(Var Buff;Var IxF : TMI_IndexFile ;Var Chave : tString);overload;

    public class Procedure CloseFilesOpens;override;
    public class procedure EscrevaDataFile(Var DatF : TMI_DataFile; Var IxF : TMI_IndexFile);



  end;


implementation



{ TTb__Access }

class function TTb___Access.OpenFile(var DatF: TMI_DataFile;var IxF: TMI_IndexFile; const condicao: NumeroDeArquivos): Integer;

  Var
{    i         : 1..16;}
    ArrayIxF : array[1..16] of TMI_IndexFile absolute IxF ;

    procedure OpenIxF;

      procedure AbreArqIndice;
      var i : 1..16;
      begin
        for i := 1 to TMI_DataFile(DatF).NArqIndice do
        begin
          OpenIndex(ArrayIxF[i],FileModeDenyALL,True);
          if Not ok
          then exit ;
        end;
      end;

    begin
      case condicao of
        Um    : Begin
                 OpenIndex(ArrayIxF[1],FileModeDenyALL,True);
                 if Not ok then begin
                   CloseFile(TMI_DataFile(DatF));
                   ok := False;
                 end
               end;
        Todos,
        TodosC: Begin
                 AbreArqIndice;
                 if not ok then
                 with Application.Mi_MsgBox do begin
                   MessageBox('Erro: Na abertura dos arquivos',MtError, MbOKButton,mbOk);
                   CloseFile(TMI_DataFile(DatF));
                   ok := False;
                 end;
               end;
        else    begin
                 TaStatus := ParametroInvalido;
                 Raise TException.Create7('',
                                             'mi.rtl.objects.methods.db.tb__access.Pas',
                                             'TTb__Access',
                                             'OpenFile',
                                             '',
                                             '',
                                             TaStatus);
               end;
      end; {Case}

    end;
begin
  Try
    If Not Is_TFileOpen(TMI_DataFile(DatF).DF.F)
    Then TaStatus := OpenFile(TMI_DataFile(DatF))
    Else TaStatus := 0;

    With TMI_DataFile(DatF),DF do
      If Is_TFileOpen(F)
      Then OpenIxF
      else begin
             If FileShared(TMI_DataFile(DatF).NomeArq)
             Then Begin
                    with Application.Mi_MsgBox do
                    If MessageBox('O arquivo '+TMI_DataFile(DatF).nomeArq+' não existe.'+^M+
                                  ^M+
                                  'Cria o arquivo agora?'
                                  ,MtConfirmation,mbYesNoCancel,mbYes)= MrYes
                    Then begin
                           TaStatus := MakeFile(TMI_DataFile(DatF));
                           If TaStatus=0
                           Then CloseFile(TMI_DataFile(DatF));

                           If TaStatus =0
                           Then TaStatus := OpenFile(DatF,IxF,condicao);
                         end
                    else TaStatus := ArquivoNaoEncontrado2;
                  End
           end;

  Finally
    If TaStatus<>0
    Then with Application.Mi_MsgBox do
           MessageBox(TStrError.ErrorMessage7('',
                                               'mi.rtl.objects.methods.db.tb__access.Pas',
                                               'TTb__Access',
                                               'OpenFile',
                                               '',
                                               '',
                                               TaStatus));
    Result := taStatus;
    ok     := Result = 0;

  end;

end;


class procedure TTb___Access.CloseFile(var DatF: TMI_DataFile;var IxF: TMI_IndexFile; const condicao: NumeroDeArquivos);
var
  {i             : 1..16;}
  ArrayIxF     : array[1..16] of TMI_IndexFile absolute IxF;

  procedure FechaTMI_IndexFile;
    var j  : 1..16;
  begin
    for j := 1 to TMI_DataFile(DatF).NArqIndice do
    with ArrayIxF[j] do CloseIndex(ArrayIxF[j]);
  end;

begin
  CloseFile(TMI_DataFile(DatF));
  If condicao in [ Todos,todosC ] then fechaTMI_IndexFile
  else CloseIndex(ArrayIxF[1]);
end;


class function TTb___Access.LocRegUse(const P: TipoPonteiroBD): Byte;
   Var i : Byte;
Begin
  i := 1;
  While (MatPFile[i] <> Nil) And (i < MaxBase) Do
  Begin
    If (P.PR = MatPFile[i]^.PR) And (P.PI = MatPFile[i]^.PI) Then
    Begin
      LocRegUse := i;

      Exit;
    End;
    i := i + 1;
  End;

  If (i <= MaxBase) And (MatPFile[i] = Nil)
  Then LocRegUse := i
  Else LocRegUse := 0;

End;

class function TTb___Access.FPosicao(Posicao: Byte): Byte;

  Var Arq  : TMI_DataFile;
Begin

  If Not (Posicao in [1..MaxBase]) Then
  Begin
    FPosicao := 0;

    exit
  End;
  If MatPFile[Posicao] = Nil Then
  Begin
    FPosicao := 0;

    exit;
  End;
  With MatPFile[Posicao]^ do
  Begin
     Move(PA^,arq,sizeof(Arq));
  end;

  If (Not Is_TFileOpen(Arq.Df.F)) Then
  Begin
    FPosicao := 0;
    ok       := False;

    with Application.Mi_MsgBox do
      MessageBox('O arquivo de Dados nao esta aberto: '+Arq.NomeArq,MtError, MbOKButton,mbok);

    exit;
  end;

  FPosicao := Posicao;

End;

class function TTb___Access.IndiceSele(var Buff): PathStr;
  { Retorna o nome do arquivo de indice selecionado }
    Var Posicao : Byte; P : TipoPonteiroBD;
Begin
  With P Do PR := @Buff; Posicao := LocRegSkip(P);
  If Not (Posicao in [1..MaxBase]) Then
   RunError(201);
  With MatPFile[Posicao]^ Do
  Begin
    TMI_IndexFile(PI^).NomeArqIndice := UpperCase(TMI_IndexFile(PI^).NomeArqIndice);
    IndiceSele := TMI_IndexFile(PI^).NomeArqIndice;
  End;

End;


class function TTb___Access.NRecSkip(var Buff): Longint;

  Var Posicao : Byte; P : TipoPonteiroBD;
Begin
//  {$IFDEF TaDebug}Application.Push_MsgErro('Tb__Access.NRecSkip',ListaDeChamadas);{$ENDIF}
  With P Do PR := @Buff; Posicao := LocRegSkip(P);
  If Not (Posicao in [1..MaxBase]) Then
  Begin
    RunError(201);
  End;
  With MatPFile[Posicao]^ Do NRecSkip := NR;

End;

class procedure TTb___Access.Replace(var Buff);
  Var Posicao : Byte; P : TipoPonteiroBD;
Begin
  With P Do PR := @Buff; Posicao := LocRegSkip(P);
  If Not (Posicao in [1..MaxBase]) Then
  Begin
    RunError(201);
  End;
  With MatPFile[Posicao]^ Do Begin
    PutRec(TMI_DataFile(PA^),NR,Buff);
    If Not ok
    Then with Application.Mi_MsgBox do
           MessageBox('Erro: Na gravação do registro!!! '+IStr(Nr,'999999')
                      ,MtError, MbOKButton,mbOk);
  End;

End;


class procedure TTb___Access.Locate(var Buff; NRec: Longint);
  Var Posicao : Byte; P : TipoPonteiroBD;
Begin

  With P Do PR := @Buff; Posicao := LocRegSkip(P);
  If Not (Posicao in [1..MaxBase]) Then
  Begin
    RunError(201);
  End;
  With MatPFile[Posicao]^ Do Begin
    GetRec(TMI_DataFile(PA^),NRec,Buff);
    Nr := NRec
  End;

End;


class procedure TTb___Access.ReplaceUnLock(var Buff);
Var Posicao : Byte; P : TipoPonteiroBD;
Begin
//  {$IFDEF TaDebug}Application.Push_MsgErro('Tb__Access.ReplaceUnlock',ListaDeChamadas);{$ENDIF}
  With P Do PR := @Buff; Posicao := LocRegSkip(P);
  If Not (Posicao in [1..MaxBase]) Then
  Begin
    RunError(201);
  End;
  With MatPFile[Posicao]^ Do Begin
    PutRec(TMI_DataFile(PA^),NR,Buff);
    If Not ok
    Then with Application.Mi_MsgBox do
          MessageBox('Erro: Na gravação do registro!!! '+IStr(Nr,'999999'),MtError, MbOKButton,mbOk);

    //If Not TMI_DataFile(PA^).Df.F.UnLock(NR,1)
    //Then with Application.Mi_MsgBox do
    //       MessageBox('Algo errado não consigo destravar registro !!!'+IStr(Nr,'99999'),MtError, MbOKButton);
  End;

End;


{TrocaChave(RegCCusto,ArqCCustoI[ etCodigoCC ],wCodigo,codigoCCusto);}
class procedure TTb___Access.TrocaChave(var Buff; var IxF: TMI_IndexFile;
  ChaveAnterior, ChaveAtual: TaKeyStr);
  Var PosicaoSelecionada,PosicaoSecundaria : Byte; P  : TipoPonteiroBD;
      NRecSelecionado : Longint;
Begin
  If ChaveAnterior = ChaveAtual Then Exit;

  NRecSelecionado  := 1;
  With P do Begin PR := @Buff; PI := @IxF ; End;

  PosicaoSelecionada := LocRegSkip(P);
  If FPosicao(PosicaoSelecionada) <> 0 Then Begin
    With MatPFile[PosicaoSelecionada]^ do
    If P.PR = PR
    Then NRecSelecionado := Nr;
  End
  Else with Application.Mi_MsgBox do
         MessageBox('O arquivo de indice selecionado não esta aberto: '+IxF.NomeArqIndice
                    ,MtError,MbOKButton,mbOk);
  PosicaoSecundaria := LocRegUse(P);
  If FPosicao(PosicaoSecundaria) <> 0 Then Begin
    With MatPFile[PosicaoSecundaria]^ do
    If (P.PR = PR) And (P.PI = PI) Then Begin
      Nr := NRecSelecionado;
      DeleteKey(TMI_IndexFile(PI^),NR ,ChaveAnterior);
      If Not Ok
      Then with Application.Mi_MsgBox do
             MessageBox('Arquivo: '+TMI_IndexFile(PI^).NomeArqIndice+^M+
                        ' Chave: '+ChaveAnterior +' inexistente.'
                        ,MtError, MbOKButton,mbOk);

      AddKey(TMI_IndexFile(PI^),NR ,ChaveAtual);
      If Not Ok
      Then with Application.Mi_MsgBox do
             MessageBox( 'Erro ao adicionar Chave: '+ChaveAtual,MtError, MbOKButton,mbOk);
    End;
  End
  Else
    with Application.Mi_MsgBox do
      MessageBox('O arquivo de índice a selecionar não esta aberto: '+IxF.NomeArqIndice    ,MtError, MbOKButton,mbOk);

End;



class procedure TTb___Access.ClearSkipAll;
  Var i,N : Byte;
Begin
//  {$IFDEF TaDebug}Application.Push_MsgErro('Tb__Access.ClearSkipAll',ListaDeChamadas);{$ENDIF}
  N := NBase;
  For i := 1 to N Do
  If (MatPFile[i] <> Nil) and (MatPFile[i]^.pa <> nil) Then
  With MatPFile[i]^,TMI_DataFile(Pa^) do
  Begin
    CloseFile(TMI_DataFile(Pa^),TMI_IndexFile(PI^),Um);

    {If FileRec(Df.F).Mode <> FmInOut Then}
    If Not Is_TFileOpen(Df.F) Then
    Begin
{writeLn(TMI_DataFile(Pa^).NomeArq,'':5,TMI_IndexFile(PI^).NomeArqIndice);}
      Dispose( MatPFile[i]);
      MatPFile[i] := Nil;
      Dec(NBase);
    End;
  End
  Else
  Begin

    Exit;
  end;

End;


class procedure TTb___Access.Skip(var Buff; var Chave: TaKeyStr;
  const ModoDePesquisa: TipoSkip);
   Var Posicao : Byte; P : TipoPonteiroBD;
Begin

  With P Do
    PR := @Buff;

  Posicao := LocRegSkip(P);

  If Not (Posicao in [1..MaxBase]) Then
  Begin
   taStatus := 201;
   Raise TException.Create7('',
           'mi.rtl.objects.methods.db.tb__access.Pas',
           'TTb__Access',
           'Skip',
           '',
           '',
           TaStatus);
  End;

  With MatPFile[Posicao]^ Do
  Case ModoDePesquisa of
   Next    : NextKey(TMI_IndexFile(PI^),NR ,Chave);
   Find    : FindKey(TMI_IndexFile(PI^),NR ,Chave);
   Prev    : PrevKey(TMI_IndexFile(PI^),NR ,Chave);
   Searc   : SearchKey(TMI_IndexFile(PI^),NR ,Chave);
   Else  Begin
           taStatus := ParametroInvalido;
           Raise TException.Create7('',
                   'mi.rtl.objects.methods.db.tb__access.Pas',
                   'TTb__Access',
                   'Skip',
                   '',
                   '',
                   TaStatus);
         End;
  End;
  With MatPFile[Posicao]^ Do
    If Ok Then GetRec(TMI_DataFile(PA^),NR,Buff);

End;


class function TTb___Access.FSkip(var Buff; var Chave: tString;const ModoDePesquisa: TipoSkip): Boolean;
Begin
  Skip(Buff,Chave,ModoDePesquisa);
  result := ok;
End;

class function TTb___Access.FSkipSearch(var Buff; Chave: tString): Boolean;
  Var WChave : tString;
Begin
  WChave := Chave; Skip(Buff,WChave,Find);
  If Not ok Then Skip(Buff,WChave,Next);
  ok := Ok And (Chave = Copy(WChave,1,Byte(Chave[0]))); FSkipSearch := ok;

End;

class function TTb___Access.Use(var DatF: TMI_DataFile; var IxF: TMI_IndexFile; var Buff): Boolean;

Var
  Posicao : Byte;
  P       : TipoPonteiroBD;
Begin
//  {$IFDEF TaDebug}Application.Push_MsgErro('Tb__Access.Use',ListaDeChamadas);{$ENDIF}
  Use := False;
  With P do
  Begin
    PR := @Buff;
    PI := @IxF;
  End;
  Posicao := LocRegUse(P);

  If Not (Posicao in [1..MaxBase])
//    Or (MaxAvail < Sizeof(MatPFile[1]^))
  Then
  Begin
    //RunError(201);
    TaStatus := 201;
    Raise TException.Create7('',
                      'mi.rtl.objects.methods.db.tb__access.Pas',
                      'TTb__Access',
                      'USE',
                      DatF.NomeArq,
                      '',
                      TaStatus);
  End
  Else
  Begin
    If MatPFile[Posicao] = Nil Then
    Begin
      ok := OpenFile(TMI_DataFile(DatF),TMI_IndexFile(IxF),Um)=0;
      If Ok Then
      Begin
        //If MaxAvail > Sizeof(TipoPonteiroBD) Then
        //Begin
          New(MatPFile[Posicao]);
          Inc(NBase);
//        End
 //       Else
//        Begin
//          CloseFile(TMI_DataFile(DatF),TMI_IndexFile(IxF),Um);
//          MatPFile[Posicao] :=  Nil;
{          MsgErroMemoria;}
//          Ok := False;
//          Exit;
//         End;
      End
      Else
      Begin
        result := ok;
        Exit;
      end;
    End;

    With MatPFile[Posicao]^ Do
    Begin
      PR:=@Buff;
      PA:=@DatF;
      PI:=@IxF;
    End;
  End;
  use := Ok;
End;

class procedure TTb___Access.UseC(var Buff);

  Var P    : TipoPonteiroBD;
      {pr   : ^TipoPonteiroBD;}
      i    : Byte;
Begin
//  {$IFDEF TaDebug}Application.Push_MsgErro('Tb__Access.UseC',ListaDeChamadas);{$ENDIF}
  With P do PR := @Buff;
  i := 1;
  While i <= NBase Do
  Begin
    If MatPFile[i] <> Nil Then  With MatPFile[i]^,TMI_DataFile(Pa^),TMI_IndexFile(PI^) do Begin
      If P.PR = PR Then
      Begin
        CloseFile(TMI_DataFile(Pa^),TMI_IndexFile(PI^),Um);
        If (Not (Is_TFileOpen(Df.F))) or
           (Not (Is_TFileOpen(ix.dataF.F)))
        Then
        Begin
          Dispose(MatPFile[i]);
          If i < NBase then begin
            Move(MatPFile[i+1],MatPFile[i],(NBase-i) * Sizeof(MatPFile[i]));
            MatPFile[NBase] := Nil;
          End Else MatPFile[i] := Nil;
          Dec(NBase);
          i := 0; { Forca iniciar o loop };
        End
        Else Ok := True;
      End;
    end;
    Inc(i);
  End;

End;


{ Sintax: SeekRec(Registro,ArqIndice,Chave,ModoDePesquisa }
class procedure TTb___Access.SeekRec(var Buff; var IxF: TMI_IndexFile;
  var Chave: TaKeyStr; const ModoDePesquisa: TipoSkip);

  Var Posicao : Byte; P : TipoPonteiroBD;
Begin

  With P do Begin PR := @Buff; PI := @IxF; End;
  Posicao := LocRegUse(P);
  If Not (Posicao in [1..MaxBase]) Then Begin
   RunError(201);
  End;
  With MatPFile[Posicao]^ Do
  Case ModoDePesquisa of
   Next    : NextKey(TMI_IndexFile(PI^),NR ,Chave);
   Find    : FindKey(TMI_IndexFile(PI^),NR ,Chave);
   Prev    : PrevKey(TMI_IndexFile(PI^),NR ,Chave);
   Searc   : SearchKey(TMI_IndexFile(PI^),NR ,Chave);
   Else  Begin
           taStatus := ParametroInvalido;
           Raise TException.Create7('',
                   'mi.rtl.objects.methods.db.tb__access.Pas',
                   'TTb__Access',
                   'SeekRec',
                   IxF.NomeArqIndice,
                   '',
                   TaStatus);

           //Application.Push_MsgErro('Error em: procedure TTb__Access. SeekRec();');

         End;

  End;

  With MatPFile[Posicao]^ Do
    If Ok Then GetRec(TMI_DataFile(PA^),NR,Buff);

End;

class procedure TTb___Access.SkipLock(var Buff; var Chave: tString;const ModoDePesquisa: TipoSkip);

  Var Posicao : Byte; P : TipoPonteiroBD;
Begin
//  {$IFDEF TaDebug}Application.Push_MsgErro('Tb__Access.SkipLock',ListaDeChamadas);{$ENDIF}
  With P Do PR := @Buff; Posicao := LocRegSkip(P);
  If Not (Posicao in [1..MaxBase]) Then Begin
   RunError(201);
  End;
  With MatPFile[Posicao]^ Do
  Case ModoDePesquisa of
   Next    : NextKey(TMI_IndexFile(PI^),NR ,Chave);
   Find    : FindKey(TMI_IndexFile(PI^),NR ,Chave);
   Prev    : PrevKey(TMI_IndexFile(PI^),NR ,Chave);
   Searc   : SearchKey(TMI_IndexFile(PI^),NR ,Chave);
   Else  Begin
           taStatus := ParametroInvalido;
           Raise TException.Create7('',
                   'mi.rtl.objects.methods.db.tb__access.Pas',
                   'TTb__Access',
                   'SkipLock',
                   '',
                   '',
                   TaStatus);
         End;
  End;
  With MatPFile[Posicao]^ Do
    If Ok Then
    Begin
      ok := TraveRegistro(TMI_DataFile(PA^).Df,NR);
      If ok Then
        GetRec(TMI_DataFile(PA^),NR,Buff);
    End;

End;

class function TTb___Access.LocRegSkip(P: TipoPonteiroBD): Byte;
  Var i : Byte;
Begin

  i := 1;
  While (MatPFile[i] <> Nil) And (i < MaxBase) Do
  Begin
    If P.PR = MatPFile[i]^.PR Then
    Begin
      LocRegSkip := i;

      Exit;
    End;
    i := i + 1;
  End;

  If (i <= MaxBase) And (MatPFile[i] = Nil)
  Then LocRegSkip := i
  Else LocRegSkip := 0;


End;


{ADeleteRec(RegCCusto,ArqCCustoI[ etCodigoCC ],regCCusto.codigoCCusto);
ADeleteRec(RegCCusto,ArqCCustoI[ etNomeCC ],regCCusto.nome);}
class procedure TTb___Access.ADeleteRec(var Buff; var IxF: TMI_IndexFile;
  var Chave: tString);

  Var PosicaoSelecionada,PosicaoSecundaria : Byte; P  : TipoPonteiroBD;
      NRecSelecionado : Longint;
Begin
  With P do Begin PR := @Buff; PI := @IxF ; End;
  PosicaoSelecionada := LocRegSkip(P);
  If FPosicao(PosicaoSelecionada) <> 0 Then Begin
    With MatPFile[PosicaoSelecionada]^ do
    If (P.PR = PR) And (P.PI = PI) Then Begin
      DeleteRec(TMI_DataFile(PA^),NR);
      If Not Ok
      Then with Application.Mi_MsgBox do
             MessageBox( 'Arquivo: '+TMI_DataFile(PA^).NomeArq+^M+
                         ' Erro ao apagar registro num: '+IStr(Nr,'999999')
                         ,MtError,MbOKButton,mbOk);

      DeleteKey(TMI_IndexFile(PI^),NR ,Chave);
      If Not Ok
      Then with Application.Mi_MsgBox do
             MessageBox('Arquivo: '+TMI_IndexFile(PI^).NomeArqIndice+^M+
                        ' Chave: '+Chave +' inexistente.'
                        ,MtError,MbOKButton,mbOk);

      Exit;
    End;
  End
  Else
    with Application.Mi_MsgBox do
      MessageBox('O arquivo de indice selecionado não esta aberto: '+IxF.NomeArqIndice
                 ,MtError,MbOKButton,mbOk);

  With MatPFile[PosicaoSelecionada]^ do
    If P.PR = PR
    Then NRecSelecionado := Nr
    else NRecSelecionado := 1;

  PosicaoSecundaria := LocRegUse(P);
  If FPosicao(PosicaoSecundaria) <> 0 Then Begin
    With MatPFile[PosicaoSecundaria]^ do
    If (P.PR = PR) And (P.PI = PI) Then Begin
      Nr := NRecSelecionado;
      DeleteKey(TMI_IndexFile(PI^),NR ,Chave);

      If Not Ok
      Then with Application.Mi_MsgBox do
             MessageBox('Arquivo: '+TMI_IndexFile(PI^).NomeArqIndice+^M+
                        ' Chave: '+Chave +' inexistente.'
                        ,MtError,MbOKButton,mbOk);
    End;
  End
  Else
    with Application.Mi_MsgBox do
      MessageBox('O arquivo de indice a selecionar não esta aberto: '+IxF.NomeArqIndice
                 ,MtError,MbOKButton,mbOk);

End;

{AAddRec(RegCCusto,ArqCCustoI[ etCodigoCC ],regCCusto.codigoCCusto);
AAddRec(RegCCusto,ArqCCustoI[ etNomeCC ],regCCusto.nome);}
class procedure TTb___Access.AAddRec(var Buff; var IxF: TMI_IndexFile;
  var Chave: tString);

  Var PosicaoSelecionada,
      PosicaoSecundaria : Byte;
      P  : TipoPonteiroBD;
      NRecSelecionado : Longint;
Begin
//  {$IFDEF TaDebug}Application.Push_MsgErro('Tb__Access.AAddRec',ListaDeChamadas);{$ENDIF}
  With P do
  Begin
    PR := @Buff;
    PI := @IxF ;
  End;
  { No indice primario deve-se Adicionar Registro }
  PosicaoSelecionada := LocRegSkip(P);
  If FPosicao(PosicaoSelecionada) <> 0 Then Begin
    With MatPFile[PosicaoSelecionada]^ do
    If (P.PR = PR) And (P.PI = PI) Then Begin
      AddRec(TMI_DataFile(PA^),NR ,Buff);
      If Ok Then Begin
        AddKey(TMI_IndexFile(PI^),NR ,Chave);
        If Not Ok Then Begin
          DeleteRec(TMI_DataFile(PA^),NR);
          with Application.Mi_MsgBox do
            MessageBox('Erro na Adição da chave '+Chave,MtError,MbOKButton,mbOk);
        End;
      End
      Else
        with Application.Mi_MsgBox do
          MessageBox('Erro na Adição do registro'+IStr(Nr,'999999'),MtError,MbOKButton,mbOk);

      Exit;
    End;
  End
  Else
    with Application.Mi_MsgBox do
      MessageBox('O arquivo de índice selecionado não esta aberto: '+IxF.NomeArqIndice,MtError, MbOKButton,mbOk);

  { Se nao for indice primario entao adiciona-se somente a chave }
  With MatPFile[PosicaoSelecionada]^ do
    If P.PR = PR
    Then NRecSelecionado := Nr
    else NRecSelecionado := 1;

  PosicaoSecundaria := LocRegUse(P);
  If FPosicao(PosicaoSecundaria) <> 0
  Then Begin
          With MatPFile[PosicaoSecundaria]^ do
          If (P.PR = PR) And (P.PI = PI)
          Then Begin
                 Nr := NRecSelecionado;
                 AddKey(TMI_IndexFile(PI^),NR ,Chave);
                 If Not Ok
                 Then with Application.Mi_MsgBox do
                        MessageBox('Erro na Adição da chave '+Chave ,MtError,MbOKButton,mbOk);
               End;
       End
  Else with Application.Mi_MsgBox do
              MessageBox('O arquivo de índice a selecionar não esta aberto: '+IxF.NomeArqIndice
                              ,MtError, MbOKButton,mbOk);



{
  gotoxy(1,1);writeLn(
  FileRec(ArqI.ix.DataF.F).Handle,LF,
  StrHex(FileRec(ArqI.ix.DataF.F).Mode),Lf,
  ArqI.DeveFechar,Lf);readLn;
}
End;


class procedure TTb___Access.Sele(var Buff; var IxF: TMI_IndexFile);
  Var PosicaoSelecionada,
      PosicaoSecundaria  : Byte;
      P                  ,
      MatPFileAux        : TipoPonteiroBD;
Begin

  With P do Begin
    PR := @Buff;
    PI := @IxF;
  End;

  PosicaoSelecionada := LocRegSkip(P);
  If FPosicao(PosicaoSelecionada) <> 0 Then
  Begin
    PosicaoSecundaria := LocRegUse(P);
    If FPosicao(PosicaoSecundaria) <> 0 Then
    Begin
      MatPFileAux := MatPFile[PosicaoSelecionada]^;
      MatPFile[PosicaoSelecionada]^ := MatPFile[PosicaoSecundaria]^;
      MatPFile[PosicaoSecundaria]^ := MatPFileAux;
    End
    Else with Application.Mi_MsgBox do
           MessageBox('O arquivo de indice a selecionar não esta aberto com USE: '+IxF.NomeArqIndice,MtError, MbOKButton,mbOk)
  End
  Else with Application.Mi_MsgBox do
         MessageBox('O arquivo de indice selecionado não esta aberto: '+IxF.NomeArqIndice,MtError, MbOKButton,mbOk);

End;

class procedure TTb___Access.CloseFilesOpens;
begin
  ClearSkipAll;
  inherited CloseFilesOpens;
end;


class procedure TTb___Access.EscrevaDataFile(var DatF: TMI_DataFile;
  var IxF: TMI_IndexFile);
{ Mostra a situacao dos arquivos }
Begin
  with DatF do Begin
{    Write(^M,
          'Arquivo de Dados ',NomeArq:12,
          ' StatusArq  ',SIF(statusArq = Aberto,' Aberto  ',' Fechado '),
          ' DeveFechar ',DeveFechar:5,
          ' Situacao   ',StrHex(FileRec(Df.F).Mode),
          ' Handler    ',FileRec(Df.F).Handle,LF,LF,
          'Arquivo Indice  ',IxF.NomeArqIndice:12,
          ' StatusArq  ',SIF(IxF.statusArq = Aberto,' Aberto  ',' Fechado '),
          ' DeveFechar ',IxF.DeveFechar:5,
          ' Situacao   ',StrHex(FileRec(IxF.Ix.DataF.F).Mode),
          ' Handler    ',FileRec(IxF.Ix.DataF.F).Handle);
    ReadLn;
 }
  End;
End;



end.



