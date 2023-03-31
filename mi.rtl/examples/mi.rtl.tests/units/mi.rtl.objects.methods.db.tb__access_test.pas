unit mi.rtl.objects.methods.db.tb__access_test;

{$IFDEF FPC}
  {$MODE Delphi} {$H+}
{$ENDIF}


interface

uses
  Classes, SysUtils//,Dialogs
  ,mi.rtl.Consts
  ,mi.rtl.objectss
  ;

type
  {: A class **@name** desmonstra o uso da classe TObjectss.Ttb__access }
  TAluno = class
    type TRegAluno = record
                        herder : TObjectss.Ttb__access.TypeHeaderRecordNovo;
                        id : Longint;
                        nome : String[60];
                     end;
    public Const NR_Bof      : Longint = 0 ;
    public Const NR_Current  : Longint = 0 ;
    public Const NR_Eof     : Longint = 0 ;

    public Const OkBof : boolean = true;
    public Const OkEof : Boolean = false;
    public Const RecordSelected : Boolean = false;
    public var  ArqAluno : TObjectss.Ttb__access.TMI_DataFile; static;
    public var  RegAluno : TRegAluno; static;

    public class procedure Init_ArqAluno;
    public class function Create_ArqAluno:Boolean;
    public class procedure DoOnNewRecord(aNome:AnsiString);
    public class function AddRec(aNome:AnsiString):Boolean;
    public class function NextRec:Boolean;
    public class Function GoBof: Boolean ;
    public class function Cadastra :Boolean;
    public class Procedure Lista_ordem_crescente;

    public class Function GoEof: Boolean ;
    public class function PrevRec:Boolean;
    public class Procedure Lista_ordem_Decrescente;

    public class function DeleteRec:Boolean;

    Public class Function Test_SetTransaction:Boolean;
  end;

implementation

  class procedure TAluno.Init_ArqAluno;
  begin

    NR_Bof     := 0 ;
    NR_Current := 0 ;
    NR_Eof     := 0 ;

    OkBof := true;
    OkEof := false;
    RecordSelected := false;

    // Inicializa a variável TArqAluno
    with TObjectss.Ttb__access do
      Init_MI_DataFile(ArqAluno,'Aluno.tb',sizeof(TRegAluno),0);
  end;

  class function TAluno.Create_ArqAluno:Boolean;
  begin
    // Cria o arquivo de aluno
    with TObjectss,Ttb__access do
    begin

      if ArqAluno.NomeArq = ''
      then Raise TObjectss.TException.Create7('',
                            'mi.rtl.objects.methods.db.tb__access_test.Pas',
                            'TAluno',
                            'Create_ArqAluno',
                            '',
                            '',
                            'A variável ArqAluno não inicializada.');

      if MakeFile(ArqAluno) = 0
      then begin
             result := true;
             CloseFile(ArqAluno);
           end
      else result := false;
    end;
  end;

  class procedure TAluno.DoOnNewRecord(aNome:AnsiString);
  begin
    //Inicia o registro de aluno.
    fillchar(RegAluno,sizeof(RegAluno),0);
    inc(Nr_Current);
    RegAluno.id:= NR_Current;
    RegAluno.nome:= aNome;
  end;

  class function TAluno.AddRec(aNome:AnsiString):Boolean;
  begin
    DoOnNewRecord(aNome);
    with TObjectss.Ttb__access do
    result := addRec(ArqAluno,nr_Current,regAluno);
  end;

  class function TAluno.NextRec:Boolean;
  begin
    with TObjectss.Ttb__access do
    begin
      if NR_Current < FileSize(ArqAluno)
      then begin
             inc(NR_Current);
             Result := getRec(ArqAluno,nr_Current,regAluno);
             if not Result
             Then result := NextRec;
           end
      else begin
             okEof := true;
             result := false;
           end;
    end;
  end;

  class Function TAluno.GoBof: Boolean ;
  Begin
    with TObjectss.Ttb__access do
    begin
      if (NR_Bof = 0)
      then begin
             If ((FileSize(ArqAluno)-1) >= 1) And
                (UsedRecs(ArqAluno) <> 0)
             Then Begin
                     NR_Bof := 1;
                     Nr_Current := NR_Bof;
                     result := getRec(ArqAluno,nr_Current,regAluno);
                     if not result
                     then Result := NextRec;
                   End
              Else Begin
                     Nr_Current := 0;
                     okBof := false;
                     Result    := False;
                   End;
           end
      Else Begin
             Result  := GetRec(ArqAluno,NR_Bof,RegAluno);
             if Not Result
             then Begin
                    NR_Bof := 0;
                    Result  := GoBof;
                  End
             Else begin
                    OkBof := true;
                    OkEof := false;
                  end;
           End;

      NR_Bof := nr_Current;

      ok     := Result;
      if not Result
      then RecordSelected := false;
      OkEof  := False;
      OkBof  := true;
    end;
  End;

  class function TAluno.Cadastra : Boolean;
    Var
      Wok_Set_Transaction:boolean;
      Wok : Boolean;
      p  : Tobjectss.PSItem;
  begin
    with TObjectss,Ttb__access do
    begin
      Init_ArqAluno;
      if Create_ArqAluno then begin
        if OpenFile(ArqAluno) = 0
        then begin

               SetTransaction(true,wOK,Wok_Set_Transaction);
               try

//                 Push_MsgErro('AddRec Paulo Sérgio');

                 DoOnNewRecord('Paulo Sérgio');
                 AddRec(ArqAluno,Nrec,RegAluno);

                 if ok then
                 begin
                   DoOnNewRecord('Paulo Silva');
                   AddRec(ArqAluno,Nrec,RegAluno);
                 end;
//                 ok := false;
//                 raise TException.Create('Este é uma teste do método Tobjectss.TException. ');

                 if ok then
                 begin
                   DoOnNewRecord('Paulo Pacheco');
                   AddRec(ArqAluno,Nrec,RegAluno);
                 end;

               finally
                  result := ok;
                  SetTransaction(false,result,Wok_Set_Transaction);
                  CloseFile(ArqAluno);
               end;

             end
        else result := false;
      end else result := false;
    end;
  end;

  class Procedure TAluno.Lista_ordem_crescente;
    var
      S : AnsiString;
      Var
        Wok_Set_Transaction:boolean;
        wok : Boolean;
  begin
    S := '';

    with TObjectss.Ttb__access do
    begin
      Init_ArqAluno;
      if OpenFile(ArqAluno) = 0
      then begin
             try
               SetTransaction(true,wok,Wok_Set_Transaction);
               S := 'LISTAGEM DE ALUNOS - Ordem Crescente.'+LF+LF;
               if GoBof then
               repeat
                 GetRec(ArqAluno,Nr_Current,RegAluno);
                 if ok then
                 begin
                   S := S + format('id: %d ; Nome : %s' ,[RegAluno.id,RegAluno.nome])+LF;
                 end;
                 wok := ok;
               until Not NextRec;
               SetTransaction(false,wok,Wok_Set_Transaction);
             finally
           //    ShowMessageFmt('%s',[s]);
             end;

             CloseFile(ArqAluno);
           end;
    end;
  end;

  class Function TAluno.GoEof: Boolean ;
  begin
    with TObjectss.Ttb__access do
    begin
      if (NR_Eof = 0)
      then Begin
              Nr_Current := FileSize(ArqAluno);
              If (Nr_Current > 1) And (UsedRecs(ArqAluno) <> 0)
              Then Begin
                     Result := PrevRec;
                   End
              Else Begin
                     Nr_Current := FileSize(ArqAluno)-1;
                     if Nr_Current > 0
                     then Result := true
                     Else Result := False;
                   End;
           End
      Else Begin
             Result  := GetRec(ArqAluno,NR_Eof,RegAluno);
             if Not Result
             then Begin
                    NR_Eof := 0;
                    Result  := GoEof;
                  End;
           End;

      NR_Eof := Nr_Current;

      ok     := Result ;
      if not Result
      then Self.RecordSelected := false;

      OkEof  := true;
      OkBof  := false;
    end;
  end;

  class function TAluno.PrevRec:Boolean;
  begin
    with TObjectss.Ttb__access do
    Try
      Repeat
        If Nr_Current > 1 Then
        Begin
           Nr_Current := Nr_Current -1;
           result := GetRec(ArqAluno,Nr_Current,RegAluno);
           if Not result
           then result := PrevRec;

           if result
           then Begin
                  OkBof := False;
                  OkEof := False;
                End;
        End
        else
        Begin
          ok    := False;
          OkBof := True;
          OkEof := False;
        End;

      Until OkBof or (ok );

    Finally
      PrevRec := ok;

    End;
  end;

  class Procedure TAluno.Lista_ordem_Decrescente;
    var
      S : AnsiString;
    Var
      Wok_Set_Transaction:boolean;
      Wok : Boolean;

  begin
    with TObjectss.Ttb__access do
    begin
      Init_ArqAluno;
      if OpenFile(ArqAluno) = 0
      then begin
             try
               SetTransaction(true,wOK,Wok_Set_Transaction);
               S := 'LISTAGEM DE ALUNOS - Ordem Descrescente'+LF+LF;
               if GoEof then
               repeat
                 GetRec(ArqAluno,Nr_Current,RegAluno);
                 if ok then
                 begin
                   S := S + format('id: %d ; Nome : %s' ,[RegAluno.id,RegAluno.nome])+LF;
                 end;
                 wok := ok;
               until Not PrevRec;
               SetTransaction(false,wOK,Wok_Set_Transaction);
             finally
               //ShowMessageFmt('%s',[s]);
               CloseFile(ArqAluno);
             end;

           end;
    end;

  end;

  class function TAluno.DeleteRec:Boolean;
    var nr,NrDefalt : String;

  begin
    with TObjectss.Ttb__access do
    begin
      Init_ArqAluno;
      result := OpenFile(ArqAluno) = 0;
      if result
      then begin
             NrDefalt := '0';
             nr := InputBox('Deleta Record',Format('Qual o registro entre 0..%d',[FileSize(ArqAluno)]),NrDefalt);
             if Nr <> NrDefalt
             then begin
                    NR_Current := StrToInt(nr);
                    if (NR_Current < 1) or (NR_Current > FileSize(ArqAluno)-1)
                    then Raise TObjectss.TException.Create7('',
                                                            'mi.rtl.objects.methods.db.tb__access_test.Pas',
                                                            'TAluno',
                                                            'DeleteRec',
                                                            ExtractFileName(ArqAluno.NomeArq),
                                                            '',
                                                            'Faixa de registro inválida para excluir o registro!');

                     if DeleteRec(ArqAluno,Nr_Current)
                     then ShowMessageFmt('Registro número %d deletado com sucesso!.',[Nr_current])
                     else ShowMessageFmt('Registro número %d não pode ser deletado!.',[Nr_current]);

             end;

             CloseFile(ArqAluno);
           end;
    end;
  end;

  class Function TAluno.Test_SetTransaction:Boolean;
    Var
      Wok_Set_Transaction:boolean;
      Wok : Boolean;
  begin
    with TObjectss.Ttb__access do
    try
      SetTransaction(true,wOK,Wok_Set_Transaction);
      Init_ArqAluno;
      if OpenFile(ArqAluno) = 0
      then begin
             try

               DoOnNewRecord('George Bruno');
               //Grava george Bruno no primeiro registro;
               PutRec(ArqAluno,1,RegAluno);

               //Delete o registro número 2
               if ok then
                 DeleteRec(ArqAluno,2);

               //Adiciona Paulo Henrique
               if ok then
               begin
                 DoOnNewRecord('Paulo Henrique');
                 AddRec(ArqAluno,Nrec,RegAluno);
               end;

               //Adiciona Céia Melo
               if ok then
               begin
                 DoOnNewRecord('Célia Melo');
                 AddRec(ArqAluno,Nrec,RegAluno);
               end;

               //Teste: Não confirmar a transação
               //ok := false;
               //abort;

               showMessage('Transação concluida com êxito! ');


             finally
                result := ok;
                if not ok
                then showMessage('Transação não confirmada! ');

                SetTransaction(False,OK,Wok_Set_Transaction);
                CloseFile(ArqAluno);
             end;
           end
      else Begin
             result := false;
             Raise TObjectss.TException.Create7('',
                            'mi.rtl.objects.methods.db.tb__access_test.Pas',
                            'TAluno',
                            'Test_SetTransaction',
                            ArqAluno.NomeArq,
                            '',
                            TaStatus);

           end;

    Except
      Result := false;
      showMessage('Exceção inesperada.')
    end;

  end;

end.

