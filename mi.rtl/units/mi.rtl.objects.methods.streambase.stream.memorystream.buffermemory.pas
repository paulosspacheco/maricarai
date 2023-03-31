unit mi.rtl.objects.methods.StreamBase.Stream.MemoryStream.BufferMemory;
{:< - A Unit **@name** implementa a classe TBufferMemory.

  - **VERSÃO**
    - Alpha - 0.5.0.687

  - **HISTÓRICO**
    - Criado por: Paulo Sérgio da Silva Pacheco e-mail: paulosspacheco@@yahoo.com.br
      - **23/11/2021**
        - 12:55 a 14:30 - Criar a unit @name
        - 14:30 a 19:35 - Criar um exemplo de como usar a classe TBufferMemory
        - 21:35 a 22:44 - Documentar a classe TBufferMemory

      - **29/11/2021**
        - 14:45 a 15:10
          - Criar exemplo TMi_Rtl_Tests.Test_TBufferMemory_sem_header;
          - Criar exemplo TMi_Rtl_Tests.Test_TBufferMemory_com_header;


  - **CÓDIGO FONTE**:
    - @html(<a href="../units/mi.rtl.objects.methods.StreamBase.Stream.MemoryStream.BufferMemory.pas">units/mi.rtl.objects.methods.StreamBase.Stream.MemoryStream.BufferMemory.pas</a>)

}

{$IFDEF FPC}
  {$MODE Delphi} {$H+}
{$ENDIF}

interface

uses
  Classes, SysUtils
  ,mi.rtl.objects.methods.StreamBase.Stream.MemoryStream;


type
  {: - A class @name cria um **array of record** em memória usando os métodos os seek, PutREc, GetRec

     - **NOTA**
       - Uso a classe @name para criar arquivos em memória no banco de dados **Tb_Access.pas**

     - **EXEMPLO**
       -  Exemplo de como gravar um registro **sem header em memória**.

          ```pascal

            Procedure TMi_Rtl_Tests.Test_TBufferMemory_sem_header;
              type
               TAluno = record
                          Id : integer;
                          nome : string[35];
                        end;

              var
               FileMemory_Alunos : TObjectss.TBufferMemory;
               Aluno          : TAluno;

               nr : longint;
               n  : longint;

            begin
              with TObjectss do
              try
                FileMemory_Alunos := TObjectss.TBufferMemory.Create(sizeof(aluno));
                with aluno,FileMemory_Alunos do
                begin
                  if status = StOk then
                  begin
                    n := 1;
                    Id:= n;
                    nome:= 'Paulo Sérgio';
                    PutRec(id,aluno);
                  end;

                  if status = StOk then
                  begin
                    inc(n);
                    Id:= n;
                    nome:= 'George Bruno';
                    PutRec(id,aluno);
                  end;

                  if status = StOk then
                  begin
                    for nr := 1 to n do
                    begin
                      GetRec(nr,aluno);
                      if status = StOk
                      then SysMessageBox('Nr ='+intToStr(nr)+
                                         '; id ='+intToStr(Aluno.id)+
                                         '; Aluno ='+Aluno.nome
                                         ,'Test_FileStream_sem_header',false)
                      else break;
                    end;
                  end;

                end;

              finally
                FileMemory_Alunos.Destroy;
              end;

            end;


          ```

       -  Exemplo de como gravar um registro **com header em memória**.

          ```pascal

            Procedure Test_TBufferMemory_com_header;
              type
                TAluno = record
                           Id : integer;
                           nome : string[35];
                         end;
              type
                THeadAlunos = record
                                TotalDeAlunos:longint;
                              end;

              var
                TBufferMemory_Alunos : TObjectss.TBufferMemory;
                HeadAlunos : THeadAlunos;
                Aluno             : TAluno;
                nr : longint;
                n  : longint;

            begin
              with TObjectss do
              try
                TBufferMemory_Alunos := TBufferMemory.Create(sizeof(HeadAlunos),sizeof(aluno));

                with aluno,TBufferMemory_Alunos do
                if status = StOk then
                begin
                  HeadAlunos.TotalDeAlunos:= 0;
                  PutRecBase(HeadAlunos); // Grava o header

                  if status = StOk then
                  begin
                    inc(HeadAlunos.TotalDeAlunos);
                    Id:= HeadAlunos.TotalDeAlunos;
                    nome:= 'Paulo Sérgio da Silva Pacheco';
                    PutRec(id,aluno);
                    if status = StOk
                    then PutRecBase(HeadAlunos); // Grava o header
                  end;


                  if status = StOk then
                  begin
                    inc(HeadAlunos.TotalDeAlunos);
                    Id:= HeadAlunos.TotalDeAlunos;
                    nome:= 'George Bruno Melo Pacheco';

                    PutRec(id,aluno);
                    if status = StOk
                    then PutRecBase(HeadAlunos); // Grava o header
                  end;

                  if status = StOk then
                  begin
                    GetRecBase(n);
                    if status = StOk
                    then
                    begin
                      //Imprime o número de elemntos adicionado ao stream
                      SysMessageBox('Número de registros: '+intToStr(n)
                                     ,
                                     'Test_FileStream_sem_header',false);

                      // Ler e imprime os registros.
                      for nr := 1 to n do
                      begin
                          GetRec(nr,aluno);
                          if status = StOk
                          then SysMessageBox('Nr ='+intToStr(nr)+
                                             '; id ='+intToStr(Aluno.id)+
                                             '; Aluno ='+Aluno.nome
                                             ,
                                             'Test_FileStream_sem_header',false)
                          else Break;
                      end;

                      if status <> StOk
                      then SysMessageBox(errorMessage(errorInfo)
                                         ,
                                         'Test_FileStream_sem_header',false)

                    end;
                  end;

                  if status <> StOk
                  then SysMessageBox(errorMessage(errorInfo)
                                     ,
                                     'Test_FileStream_sem_header',false)

                end;

              finally
                TBufferMemory_Alunos.Destroy;
              end;

            end;


          ```
  }
  TBufferMemory = Class (TMemoryStream)
    Public
      {: - O constructor **@name** cria um stream de um **array of record** em memória onde a mesma será gravado
           após o header passado pelo parâmetro a_BaseSize.;

         - **PARÂMETROS**
           - **a_BaseSize** - Tamanho do registro usado no registro de posição zero
           - **a_RecSize** - Tamanho do registro depois do registro usado na posição depois da base;
      }
      CONSTRUCTOR Create(a_BaseSize,a_RecSize:Longint);overload;override;

      {: -  O constructor **@name** cria um stream de um **array of record** em memória onde a mesma será gravado
            após ao início do bloco em memória obs: BaseSize=0.;
      }
      CONSTRUCTOR Create(a_RecSize:Longint);overload;virtual;

      {Reimplementacao de métodos virtuais}
      PROCEDURE Seek(NR: LongInt);Overload;override;//Anula o seek anterior e implementa um seek(Nr,RecSize)
      PROCEDURE Error (Code, Info: Integer); Override;


    Private
//        _Progress1Passo : TProgressDlg_If;
    Protected

  END;

implementation


{--TBufferMemory------------------------------------------------------------}
{$Region ' TBufferMemory' }

  PROCEDURE TBufferMemory.Seek(NR: LongInt);
  {Anula o seek anterior e implementa um seek(Nr,RecSize) }
  Begin
    Seek(Nr,RecSize);
  end;

  PROCEDURE TBufferMemory.Error (Code, Info: Integer);
  Begin
    Inherited Error(Code, Info);
    TaStatus := Info;
  end;


  // **** Fin da implementacao de TBufferMemory ***

  // **** Inicio da implementacao de TMemoryStream ***
  CONSTRUCTOR TBufferMemory.Create({a_FileName: AnsiString;}a_BaseSize,a_RecSize:Longint);
  Begin
    Inherited Create({ALimit}1,{ABlockSize}64*1024);
    handle := 0;
    BaseSize := a_BaseSize;
    RecSize  := a_RecSize;
  end;


  CONSTRUCTOR TBufferMemory.Create(a_RecSize:Longint);
  begin
    create(0,a_RecSize);
  end;




{$EndRegion}
{--TBufferMemory------------------------------------------------------------}


end.

