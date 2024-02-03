unit mi.rtl.files;
  {:<- A Unit **@name**  contém as funções [Wrapper](https://techlib.wiki/definition/wrapper.html) para os sistemas operacionais **Win32** **Win64** e **Linux x86_64** reconhecidos pelo free pascal.

      - **OBJETIVO**:
        - Evitar de alterar todos os códigos escritos para a plataforma
        windows e por isso mantenho o mesmo comportamento do windows.

      - **VERSÃO**:
        - Alpha - Alpha - 0.9.0

      - **NOTA**:
        - [Veja o link de como escrever código portátil em relação à arquitetura do processador?](https://wiki.freepascal.org/Writing_portable_code_regarding_the_processor_architecture);

        - Só devo usar units [syscalls](https://man7.org/linux/man-pages/man2/syscalls.2.html) do Linux  ou
          [Windows](https://docs.microsoft.com/pt-br/windows/win32/apiindex/windows-api-list)
          caso não encontre a mesma pronta nos projetos lazarus ou Free Pascal.

      - **REFERÊNCIA**
        - [Guia de programação multiplataforma](https://wiki.freepascal.org/Multiplatform_Programming_Guide);
        - [Reference for unit 'System': procedures and functions](https://www.freepascal.org/docs-html/rtl/system/index-5.html)

      - **CÓDIGO FONTE**:
        - @html(<a href="../units/mi.rtl.files.pas">mi.rtl.files.pas</a>)

      - **HISTÓRICO**
        - Criado por: Paulo Sérgio da Silva Pacheco e-mail: paulosspacheco@@yahoo.com.br
          - 2021-10-21 08:00 - Data em que essa unit **@name** foi criada.
          - 2021-11-02 15:42 - Escolha do projeto **pasdoc** para criar documento do pacote **mi.rtl**.
          - 2021-11-04 08:37 - Implementação da função **SysFileOpen()**
          - 2021-11-04 14:00 - Implementação da função **SysSetResult()**
          - 2021-11-04 14:30 - Implementação da função **SetFileMode()**
          - 2021-11-04 15:30 - Documentar a unit **@name** e organizar sessão de constantes, variáveis e funções.
          - 2021-11-04 21:00 - Criar exemplo de uso das funções **SysFileOpen** e **SysFileClose**.
          - 2021-11-05 21:30 - Revisar documentação desta nas funções: **SysSetResult**, ...

          - 2021-11-12 08:56 - Procurar bug da função **SysFileOpen** na máquina windows.
            - Eureca. Resolvi o problema da função **SysFileOpen**.
            - O problema da função **SysFileOpen** estava na forma como no windows a função SysUtils.fileOpen trabalha.
              - Caso ocorra um erro a função **SysUtils.fileOpen** retorna high(THandle).
              - Para corrigir precisei modificar a função **SysSetResult**.

          - 2021-11-12 16:56 - Documentar a unit **@name** e criar a função **CopyFile()**.
          - 2021-11-12 18:05 - Criar a função SysFileSetSize para truncar o arquivo e documenta-la.

          - 2021-11-13
            - Criado a class **TFiles** herdade de TConsts com propósito
              em encapsular as funções de acesso ao sistema operacional.
            - Criar método **TFiles.ErrorMessage()**;
            - Criar método **TFiles.SetLastError()**;
            - Criar método **TFiles.SetResult()**
            - Criar método **TFiles.CopyFile()**
            - Criar método **TFiles.SetFileMode()**
            - Criar método **TFiles.FileOpen(5 parametro)**
            - Criar método **TFiles.FileOpen(3 parâmetro)**
            - Criar método **TFiles.FileClose()**
            - Criar método **TFiles.FileTruncate()**
            - Criar método **TFiles.FileCreate()**

          - 2021-11-15

            - O método **TFiles.FileCreate()** não está obedecendo o mapa de bits FileMode() checar o porque:
              - Solução:
                - A função SysUtils.FileCreate precisa do fmCreate na criação do arquivo.
                - Após criar o arquivo o mesmo deve ser fechado e aberto novamente com o mapa de bits **mode** e **shareMode** passado no parâmetro.


            - Criar método **TFiles.FileSeek()**
            - Criar método **TFiles.FileRead()**

          - 2021-11-16
            - O método SysFileSeek não gerar erro se o ponteiro do arquivo for inválido.
              - Para contornar devo fazer a crítica se o ponteiro é maior que zero e menor que fileSize.
              - Essa solução não atende porque não fileSeek não tem o nome do arquivo.

              - Entendendo porque SysUtils.FileSeek não dar erro quando se tenta posicionar além do fim do arquivo:
                -  https://man7.org/linux/man-pages/man2/lseek.2.html

                -  No linux **lseek()** permite que o deslocamento do arquivo seja definido além do final do
                   arquivo (mas isso não altera o tamanho do arquivo). Se os dados forem
                   posteriormente escrito neste ponto, leituras subsequentes dos dados no
                   gap (um "buraco") retorna bytes nulos ('\ 0') até que os dados sejam realmente
                   escrito na lacuna.


            - Criar método **TFiles.FileSize()**
            - Criar exemplo de uso do método **TFiles.FileSize()**
            - Criar exemplo de uso do método **TFiles.FileSeek()**


          - 2021-11-17
            - 08:30 a 10:38 - Criar exemplo de uso do método **TFiles.FileRead()**
            - 11:36 a 11:48 - Criar método **TFiles.FileWrite()**
            - 11:50 a 12:21 - Criar exemplo de uso do método **TFiles.FileWrite()** - Falta testar.
            - 14:15 a 15:23 - Testar o exemplo de uso da função TFiles.FileWrite. ok.


          - 2021-11-21
            - 10:30 a 11:10
              - Criar classe método - **TFiles.FileExists()**
              - Criar classe método - **TFiles.DirectoryExists()**
          - 2021-11-22
            - 10:00 a 10:06 - Criar classe método : **TFiles.CreateDir()**
            - 10:29 a 11:10 - Criar classe método : **TFiles.SysGetDriveType(aPath : AnsiString): TDriveType;**
            - 11:11 a 12:02 - Criar classe método : **TFiles.DuplicateHandle(hSourceHandle: LongInt;Var lpTargeTHandle: Longint) :  Longint);
            - 14:10 a 15:16 - Criar classe método : **TFiles.FileFlushBuffers(Handle: THandle): Longint;**

            - 15:44 a 17:32 - Criar classe método : **LockFile(_Handle:THandle; _LockStart, _LockLength: Int64): LongInt;**
                            - Não encontrei no linux o equivalente ao Windows.LockFile

            - 15:44 a 17:32 - Criar classe método : **TFiles.UnLockFile(_Handle:THandle; _LockStart, _LockLength: Int64): LongInt;**
                            - Não encontrei no linux o equivalente ao Windows.unLockFile

            - 2021-12-01
              - 11:42 a ??:?? : Implementar a função TFiles.Is_TFileOpen

            - 2021-12-02
              - 20:00 a 22:15 : Implementei a classe TFiles.TStrError

            - 2021-12-30
              - 15:30 a 16:10 : Criar método TFiles.GetTempFileName

            - 2022-01-11
              - 17:10 - Criar método TFiles.ShellExecute

            - 2022-04-22
              - 15:46 - Criar método TFiles.AppVersionInfo

            - 2023=07-18
              - 16:00 - Criar a classe método FindFilesAll
            - 2023=07-27
              - 08:25 - Em mi.rtl.files.findFileAll adicionar o parâmetro apath.

  }

  {$IFDEF FPC}
    {$MODE Delphi} {$H+}
  {$ENDIF}

interface

uses
  {$IFDEF Windows}Windows,{$ENDIF}
  {$IFDEF UNIX}BaseUnix,  Unix, {$ENDIF}
  Classes
  ,dos
  ,SysUtils
  ,LazFileUtils
//  ,forms
  ,crt
  //,Dialogs // Uso o showMessage porém o mesmo deve ser substituído pelo um showMessage que não trava se tiver dentro de uma transação.
  ,FileUtil // <https://wiki.lazarus.freepascal.org/fileutil
  ,mi.rtl.libBinRes
  ,mi.rtl.types
  ,mi.rtl.Consts
  ,mi.rtl.Consts.StrError

  ;

  type
    { TFiles }
    {: - A classe **@name** contém as classes métodos para acessar o sistema operacional usada no acesso a arquivos.

       - REFERẼNCIAS
         - [Como criar aplicativo multi-plataforma](https://wiki.freepascal.org/Multiplatform_Programming_Guide)
    }
    TFiles = class(TConsts)
      {: O método @name retorna true se o arquivo F estiver aberto e false caso contrário}
      class function IsFileOpen(VAR F:Text):BOOLEAN ; overload;

      {: O método @name retorna true se o arquivo F estiver aberto e false caso contrário}
      class function IsFileOpen(VAR F:File):BOOLEAN ; overload;

     {: O método @name contém o número da versão do projeto corrente.

       - Esta contante retira essa informação do arquivo de recursos, caso o
         projeto não esteja habilitado o número da versão o acesso ao mesmo ao
         método @name vai gerar excessão.

       - **EXEMPLO DE USO**

         ```pascal

           procedure TForm1.Button1Click(Sender: TObject);
           // [0] = Major version, [1] = Minor ver, [2] = Revision, [3] = Build Number
             Var
               sProgName:string;
           begin

             With mi.rtl.files.Tfiles do
             begin

               sProgName :='PROJECT1';
               edit1.text:=sProgName + ' , Version:     ' + AppVersionInfo.MajorAsStr + '.'+AppVersionInfo.MinorAsStr+'.'+AppVersionInfo.RevisionAsStr+ '.'+AppVersionInfo.BuildNoAsStr;
               edit2.text:=sProgName + ' , VersionStr:  ' + AppVersionInfo.VersionStr;
               edit3.text:=sProgName + ' , VersionStrEx:' + AppVersionInfo.VersionStrEx[C_DEF_VER_FORMAT3];
             end;

           end;

         ```


    }
      public Class Function AppVersionInfo: TAppVersionInfo;

      type TStrError = mi.rtl.Consts.StrError.TStrError;

      {: A função **@name** captura o estados de system.ioResult e atualiza TaStatus
      }
      public class Function IoResult : Integer;

      {:- A função **@name** dar opção para que a aplicação execute outras tarefas caso ela se encontre em estado de espera.

          - **PARÂMETRO**
            - **Delay** - Tempo em milissegundo que deve aguardar**.
      }
      public class procedure CtrlSleep(Const Delay: Cardinal);

      {: - A função **@name** habilita ou não a função **CtrlSleep**.

           - **PARÂMETRO**
            - **aEnable**
              - Se **True** habilita CtrlSleep;
              - Se **false** desabilita o método CtrlSleep;

           - **RETORNA**
             - o valor anterior da variável CTRL_SLEEP_ENABLE;
      }
      public class Function Set_CTRL_SLEEP_ENABLE(Const aEnable: Boolean):Boolean;

      public class function ReadKey: AnsiChar;

      {:- A procedure **@name** atualiza as variáveis globais **LastError** e **OK**

        - **PARÂMETROS**
          - aCodeError:integer - Código do erro.


        - **EXEMPLO**

          ```pascal

              procedure tes_SetLastError();
              Begin
                //Executa a procedure SetLastError

                SetLastError(2);
                showMessage(ErrorMessage(LastError));

              end;

          ```
      }
      public class procedure SetLastError(aCodeError: integer);

      {:- A função **@name** captura o último erro se o parâmetro **aSucesso=false** ou o **aHandle for inválido**
          e retorna **0 (zero)** se **aSucesso=true** e o *aHandle for válido*.

        - A função **@name** atualiza a variável global **LastError** e a variável global **ok**:

        - **Plataformas testadas**
          - win32
          - win64
          - linux

        - **PARÂMETROS**
          - **aHandle**  - O handle do arquivo retornado pela ultima chamada ao sistema operacional.
          - **aSucesso** - Recebe **true** se sucesso ou **false** se fracasso na última chamada ao sistema operacional.

        - **RETORNA**
          - O conteúdo da variável global **LastError**.

        - **NOTA**
          - No windows, quando ocorre um erro o handle é igual = high(THandle) por
            isso é necessário passar o handle do arquivo na chamada a SetResult().
    }
      public class function SetResult(aHandle: THandle ; aSuccess: Boolean): Longint;overload;

      {:- A função **@name** copia o arquivo passado por **alpExistingFileName** para o arquivo passo por **lpNewFileName**.

        - **PARÂMETROS**
          - **alpExistingFileName**:AnsiString - Nome do arquivo a ser copiado;
          - **lpNewFileName**:AnsiString - Nome do arquivo destino da cópia;
          - **aExceptionOnError**:boolean - **True** se o sistema deve gera exceção ou **false** se o sistema não deve gera exceção.

        - **RETORNO**
          - **Integer** - Código do erro ou 0 (zero) se a cópia for feita com sucesso.
          - Caso o parâmetro  **aExceptionOnError** = true então a exceção deve ser tratada pela rotina que o chamou.


        - **EXEMPLO**

          ```pascal

            procedure TFormTests.Button_tes_CopyFileClick(Sender: TObject);

              // Este procedimento faz duas cópia do arquivo index.html

              Var
                err : TFiles.integer;
            Begin
              with TFiles do
                err := CopyFile('index.html','index.bak1',false);

              with TFiles do
              if err = 0
              Then showMessage('Copia 1 feita com sucesso.')
              else showMessage(ErrorMessage(err));

              with TFiles do
              try
                CopyFile('index.html','index.bak2',true);
                showMessage('Copia 2 feita com sucesso.') ;
              Except
                on E:Exception do
                 ShowMessage(e.Message);
              end;
            end;

          ```
    }
      public class function CopyFile(lpExistingFileName, lpNewFileName: AnsiString; aExceptionOnError: boolean): Integer;

      {:- A função **@name** modifica o valor de FileMode e retorna o valor do **FileMode** anterior;
          - **PARÂMETROS**
            - **aFileMode** é o modo de abertura do arquivo.

          - **RETORNA**
            - O FileModeAnt;

          - **NOTA**
            - A variável pública FileModeAnt é igual ao resultado desta função.
      }
      Public Class function SetFileMode(aFileMode:word):word;  
      
      {: - Seta FileMode e retorna o estado anterior do Mapa de bits passado por aState
      }
      public class Function SetStateFileMode(Const AState: Longint; Const Enable: boolean):Boolean;

      {: - Ler o estado do File Mode
      }
      public class function GetStateFileMode(Const AState: Longint): Boolean;

      {:- **Abre o arquivo passado pelo parâmetro FileName**

        - **PARÂMETROS**
          - **FileName** - Nome do arquivo a ser aberto;
          - **mode** - Modo de abertura. Valor possível veja TFileMode;
          - **attribute** - Atributo de abertura do arquivo;
          - **Flags** - flag de abertura do arquivo;
          - **Handle** - Se tiver sucesso retorna nesta variável o número do arquivo aberto;

        - **RETORNA**
          - LongInt  Zero se sucesso ou o código do erro se fracasso.

        - **NOTA**:
          - Possiveis erros pode ser visto na função ErrorMessage();

        - **EXEMPLOS DE USO**

            ```pascal

              procedure TFormTests.Button_Test_OpenFile_exclusive_modeClick(Sender: TObject);

                procedure Test_OpenFile_exclusive(aFileName:AnsiString);
                Var
                  Err : TFiles.integer;
                  h,
                  h1 : TFiles.THandle;
                Begin
                  with TFiles do
                    Err := FileOpen (aFileName, FmReadWrite or FmDenyALL  or fmShareCompat  ,h);

                  with TFiles do
                  if Err = 0
                  Then Begin
                         ShowMessage('Teste da função SysFileOpen retornou true');

                         Err := FileOpen (aFileName,FmReadWrite or FmDenyALL  or fmShareCompat  ,h1);
                         if Err = 0
                         Then Begin
                                FileClose(h1);
                                ShowMessage('Teste da função SysFileOpen retornou true')
                              end
                         else ShowMessage('Error: '+ErrorMessage(Err));

                         FileClose(h);
                  end
                  else ShowMessage('Error: '+ErrorMessage(Err));

                End;

              begin
                Test_OpenFile_exclusive('index.html');
              end;


            ```


        - **REFERÊNCIAS**
          - [FileOpen](https://www.freepascal.org/docs-html/rtl/sysutils/fileopen.html);
          - fmOpenRead;
          - FileClose;
          - THandle.

      }
      public class function FileOpen(const FileName: AnsiString;
                                     const Mode: Longint;
                                     const ShareMode : Cardinal;
                                     out Handle: THandle): Longint;Overload;

      {:- **Abre o arquivo passado pelo parâmetro  FileName**

        - **PARÂMETROS**
          - FileName  **Nome do arquivo a ser aberto;**
          - **mode** - Modo de abertura;
          - **Handle** - Se result = 0 o Handle contém o número do arquivo aberto, caso contrário, retorna HANDLE_INVALID**;

        - **RETORNA**
           - 0 (zero) se sucesso ou o código do erro se fracasso;

        - **NOTA**:
          - Possiveis erros pode ser visto na função ErrorMessage();

        - **EXEMPLO DE USO**

          ```pascal

            procedure TFormTests.TestSysOpenFileClick(Sender: TObject);
            Var
              Err : TFiles.Longint;
              h : TFiles.THandle;
            Begin
              with TFiles do
                Err := FileOpen ('index.html',fmOpenRead,h);

              with TFiles do
              if Err = 0 Then
              Begin
                FileClose(h);
                ShowMessage('Teste da função FileOpen retornou true')
              end
              else ShowMessage('Error: '+ErrorMessage(Err));
            End;


          ```

        - **REFERÊNCIAS**
          - [FileOpen](https://www.freepascal.org/docs-html/rtl/sysutils/fileopen.html);
          - fmOpenRead;
          - FileClose;
          - THandle.
     }
      Class function FileOpen(const FileName: AnsiString;
                              out Handle: THandle): Longint; Overload;

      {:- A função **@name** fecha o arquivo passando por Handle.
          - **PARÂMETRO**
            - **Handle** - Número do arquivo aberto por FileOpen.

          - **RETORNA**
            - Zero de tiver sucesso ou o código do erro se não conseguir fechar o arquivo.

          - **REFERÊNCIAS**
            - [FileClose](https://www.freepascal.org/docs-html/rtl/sysutils/FileClose.html);

      }
      Public Class function FileClose(Handle: THandle): Longint;

      {:- A função **@name** reduz o tamanho do arquivo para o tamanho passado pelo parâmetro **NewSize**.

        - **PARÂMETROS**
          - Handle:THandle - Handle do arquivo a ser truncado.
          - NewSize:Int64 - Tamanho do arquivo a se truncado.

        - **RETORNO**
          - **Longint** - 0(zero) se sucesso ou o código do erro se fracasso.

        - **REFERÊNCIA**
          - [Truncate file](https://www.freepascal.org/docs-html/rtl/sysutils/filetruncate.html)

        - **EXEMPLO**

          ```pascal

            procedure TFormTests.Button_tes_FileTruncateClick(Sender: TObject);
              // Este procedimento Trunca o arquivos 'index.html' para 100 bytes
              Var
                aHandle: TFiles.THandle;
                NewSize: TFiles.word;
                err    : TFiles.integer;
            Begin
              NewSize := 100;

              with TFiles do
                err := FileOpen('index.html',fileMode,aHandle);

              with TFiles do
              if  err = 0
              then begin
                     //Executa a função SysFileTruncate
                     err := FileTruncate(aHandle,NewSize);

                     if err = 0
                     then showMessage('O arquivo foi truncado para 100 bytes')
                     else ShowMessage('Error: '+ErrorMessage(err));
                   end
              else ShowMessage('Error: '+ErrorMessage(err));
            end;


          ```
      }
      public class function FileTruncate(Handle:THandle;NewSize:Int64 ): Longint;

      {:- A função **@name** cria um novo arquivo e retorna um identificador para ele ou código do erro houver fracasso.

        - **PARÂMETROS**
          - **FileName**: AnsiString - Nome do arquivo a ser criado;
          - **Mode**: Longint - Modo de criação do arquivo. Veja FileMode para mais informações;


        - **RETORNO**
          - **THandle** - Handle do arquivo criado;
          - **LongInt** - 0 (zero se sucesso ou o código do erro se fracasso.

        - **EXEMPLO**

          ```pascal

              procedure TFormTests.Button_test_FileCreateClick(Sender: TObject);

                function tes_FileCreate(FileName:AnsiString;out aHandle:THandle): LongInt;
                Begin
                  with TFiles do
                    result := FileCreate(FileName,fmOpenReadWrite or fmShareExclusive,aHandle);
                end;

              var
                aHandle :  TFiles.THandle;
              begin

                with TFiles do
                if tes_FileCreate('text.txt',aHandle) = 0
                then begin
                       showMessage('Arquivo text.txt criado na pasta corrente.');
                       FileClose(aHandle);
                     end;
              end;

          ```
      }
      public class function FileCreate(FileName: AnsiString;
                                       Mode: Longint;
                                       ShareMode : Cardinal;
                                       out Handle: THandle): Longint;overload;
      public class function DeleteFile (const FileName : AnsiString): SmallInt ;

      {:- A função **@name** retorna o tamanho do arquivo em bytes.

        - **PARÂMETROS**
          - FileName: AnsiString - Nome do arquivo;
          - Count: Int64 - Número de bytes do arquivo passo do **FileName**.

        - **RETORNO**
          - **longint** - 0 (zero) se sucesso ou o código do erro se houver fracasso;
          - **Count** - Número de bytes do arquivo.

        - **EXEMPLO**

          ```pascal

            procedure TMi_Rtl_Tests.Action_Test_FileSizeExecute(Sender: TObject);
                // Este procedimento obtem o tamanho do arquivo em bytes do arquivo index.html;
              var
                FileName:AnsiString;
                Count:Int64;
                err:Longint;
            Begin
              with TFiles do
              begin
                FileName := 'index.html';
                err := FileSize(FileName,Count);
                if err <> 0
                Then showMessage(ErrorMessage(err))
                else showMessage('Tamanho do arquivo é: '+intToStr(Count));
              end;
           end;


          ```
      }
      public class function FileSize( FileName: string; out Count : int64):longint;overload;

      public class function FileSize( FileName: string):int64; overload;

      {: O função **@name** retorna em aFileSize a soma de todos os arquivos que satisfaça a mascara em path;

         - **NOTA**
           - Se houver error retorna o código do error em FileSize
      }
      class function FileSizes(Mask: AnsiString;out aFileSize:Int64): Longint;overload;

      {:- A função **@name** posiciona o ponteiro do arquivo na posição FOffSet começando da origem.

        - **PARÂMETROS**
          - **Handle: THandle** - Handle do arquivo;
          - **FOffset: Int64** - Ponteiro do arquivo a ser posicionado;
          - **Origin: LongInt** - Origem do calculo da posição do arquivos pode ser:
                              - **TConsts.fsFromBeginning**;
                              - **TConsts.fsFromCurrent**;
                              - **TConsts.fsFromEnd** ;

          - **NewPos: Int64** - Se tiver sucesso a função retorna neste parametro a nova posição do arquivo.

        - **RETORNO**
          - **LongInt** - 0 (zero se sucesso ou código do erro se fracasso.
                        - Em **NewPos** retorna o número da posição atual do arquivo.

          - **EXEMPLO**

            ```pascal

              procedure TMi_Rtl_Tests.Action_Test_FileSeekExecute(Sender: TObject);
                // Este procedimento posiciona o cursor no final do arquivo.
                Var
                  err : TFiles.integer;
                  h   : TFiles.THandle;
                  NRec,Count : TFiles.Int64;
              Begin
                with TFiles do
                begin
                  err := FileOpen('index.html',h);
                  if (err = 0) and (fileSize('index.html',Count) = 0)
                  Then Begin
                         //Posiciona no final do arquivo
                         err := FileSeek(h,Count,fsFromBeginning,NRec);
                         if err <> 0
                         Then ShowMessage(ErrorMessage(err));
                         FileClose(h);
                       end
                  else ShowMessage(ErrorMessage(err));
                end;
              end;

            ```
        - **REFERÊNCIA**:
          - [FileSeek](https://www.freepascal.org/docs-html/rtl/sysutils/fileseek.html)

      }
      class function FileSeek(const Handle:THandle; Const FOffset : Int64; Origin: LongInt; out NewPos: Int64): LongInt;

      {:- O método **@name** ler **Count** bytes do arquivo passado pelo **Handle** e retorna o número de
          bytes lidos em **BytesRead**

        - **PARÂMETROS**
          - **Handle: THandle** - Handle do arquivo
          - **Out Buffer**  - Buffer para onde os dados devem ser salvos;
          - **Count: Int64** - Número de bytes a ser lido para o buffer;
          - **Out BytesRead**: Int64 - Número de Bytes lidos efetivamente.

        - **RETORNO**
          - **Longint** - 0 (zero se sucesso ou o código do erro se fracasso;
          - Em **Buffer** os dados lidos do arquivo;
          - Em **BytesRead** Retorna o número de bytes lidos efetivamente.


          - **EXEMPLO**

            ```pascal

              procedure TMi_Rtl_Tests.Action_Test_FileReadExecute(Sender: TObject);
                // Este procedimento ler os últimos 10 bytes do arquivo index.html
                Const Size = 10;
                Var
                  err  : TFiles.integer;
                  h    : TFiles.THandle;
                  NRec,
                  Count : TFiles.Int64;
                  s     : String[255];
                  BytesLidos: Int64;
              Begin
                with TFiles do
                begin

                  err := FileOpen('index.html',h);
                  if (err = 0)
                  Then Begin
                         err := fileSize('index.html',Count);
                         if ( err = 0)
                         Then begin
                               //Posiciona no final do arquivo
                               err := FileSeek(h,Count-Size-length(LF),fsFromBeginning,NRec);
                               if err <> 0
                               Then ShowMessage(ErrorMessage(err))
                               Else Begin
                                      err := FileRead(h,s[1],Size+length(LF),BytesLidos);
                                      if (err = 0) and (BytesLidos = Size+length(LF))
                                      Then Begin
                                             s[0] := chr(Size);
                                             ShowMessage('Bytes Lidos: '+s);
                                           end
                                      else ShowMessage('Ponteiro do arquivo é: '+IntToStr(NRec));
                                    end;

                         end
                         else ShowMessage(ErrorMessage(err));
                         FileClose(h);
                       end
                  else ShowMessage(ErrorMessage(err));
                end;
              end;

            ```
        - **REFERÊNCIA**
          - [FileRead](https://www.freepascal.org/docs-html/rtl/sysutils/fileread.html)

      }
      public class function FileRead(const Handle: THandle; out Buffer; const Count: Int64; out BytesRead: int64): LongInt;

      {:- O método **@name** grava **Count** bytes do arquivo passado pelo **Handle** e retorna o número de
          bytes escritos em **BytesWrite**

        - **PARÂMETROS**
          - **Handle: THandle** - Handle do arquivo
          - **Out Buffer**  - Buffer de onde os dados devem ser escritos para o arquivo;
          - **Count: Int64** - Número de bytes a ser escritos do Buffer para o arquivo;
          - **Out BytesRead**: Int64 - Número de Bytes efetivamente escritos.

        - **RETORNO**
          - **Longint** - 0 (zero se sucesso ou o código do erro se fracasso;
          - Em **Buffer** os dados as ser escrito no arquivo;
          - Em **BytesRead** Retorna o número de bytes escritos efetivamente.

          - **EXEMPLO**

            ```pascal


              procedure TMi_Rtl_Tests.Action_Test_FileWriteExecute(Sender: TObject);

                // Este procedimento adiciona a sequência '-0123456789-0123456789'+LF no fim do arquivo index.html

                Var
                  Size : byte = 255;
                  err  : TFiles.integer;
                  h    : TFiles.THandle;

                  NRec, Count : TFiles.Int64;

                  s     : String[255];

                  BytesLidos,BytesWrites: Int64;
              Begin
                with TFiles do
                begin
                  s :=  '-0123456789-0123456789'+LF;
                  Size := length(s);

                  if not FileExists('index.html')
                  Then Err := FileCreate('index.html',fmOpenReadWrite, fmShareCompat or fmShareDenyNone ,h)
                  else Err := FileOpen('index.html',h);

                  if (err = 0)
                  Then Begin
                         err := fileSize('index.html',Count);
                         if ( err = 0)
                         Then begin
                                //Posiciona no final do arquivo - length(LF)
                                if Count >= size
                                then err := FileSeek(h,Count-length(LF),fsFromBeginning,NRec)
                                else err := FileSeek(h,0,fsFromBeginning,NRec);

                                if err = 0
                                Then Begin
                                       //Acressenta string '-0123456789-0123456789'+LF no arquivo 'index.html'
                                       err:= FileWrite(h,s[1],length(s),BytesWrites);
                                       if (err = 0) and (BytesWrites = (length(s)))
                                       then Begin
                                              ShowMessage('A sequência '+S+' foi adicionada no fim do arquivo.')
                                            end
                                       else begin
                                              if (err <> 0)
                                              Then ShowMessage(ErrorMessage(err))
                                              else ShowMessage('Número de bytes escritos diferente de: '+IntToStr(length(s)));
                                            end;
                                     end
                                else Begin
                                       ShowMessage(ErrorMessage(err))   ;
                                     end;
                         end
                         else ShowMessage(ErrorMessage(err));
                         FileClose(h);
                       end
                  else ShowMessage(ErrorMessage(err));
                end;
              end;


            ```
        - **REFERÊNCIA**
          - [FileWrites](https://www.freepascal.org/docs-html/rtl/sysutils/filewrite.html)

      }
      public class function FileWrite(const Handle: THandle; const Buffer; const Count: Int64; out BytesWrites: int64): LongInt;

      {: - A classe método @name checa se o arquivo passado no parâmetro existe.} 
      public class Function FileExists (Const FileName : AnsiString) : Boolean;

      {: - A classe método @name checa se o diretório passado no parâmetro existe}
      public class Function DirectoryExists(Const Directory : AnsiString) : Boolean;

      {: - A classe método @name cria diretório passado no parâmetro
      }
      public class Function CreateDir(Const NewDir : AnsiString) : Boolean;

      {: A classe método **@name** retorna o nome de um arquivo temporário no diretório Dir.

         - **NOTA**
           - Se Dir estiver vazio, o valor retornado por GetTempDir será usado.
           - O Prefix será 'TMP'.
           - Em caso de erro, uma string vazia é retornada.
      }
      public class function GetTempFileName (const Dir : string): string ;

      {: A classe function **@name** retorna o diretório temporário do sistema.

         - **NOTA**
           - O nome retornado terminará com um caractere delimitador de diretório.

           - Não há garantia de que esse diretório exista ou seja gravável pelo usuário.
      }
      public class function GetTempDir (): string;overload;

      {: A classe function **@name** retorna o diretório temporário do sistema.

         - **PARÂMETROS**
           - **Const env** : Variável de ambiente que tenha que contenha a pasta de arquivos temporários.
           - **out path:PathStr : Retorna a pasta dos arquivos temporários.

         - **RETORNA**
           - SmallInt : Código do erro se houver ou zero (0) se conseguiu gerar o nome da pasta.
      }
      public class function GetTempDir(Const env:String;out path:PathStr):SmallInt;overload;

      {: - A função **@name** é usada para saber o tipo de dispositivo associado a pasta.

          - **PARÂMETRO**
            - **aPath** - A pasta dona do arquivo.

          - **RETORNA**
            - O tipo de dispositivo do tipo TDriveType.
      }
      public class function GetDriveType(aPath : AnsiString): TDriveType;Overload;

      {: - A classe método @name duplica o handle do arquivo no windows e linux.
      }
      public Class function DuplicateHandle(var hSource: File;Var lpTarge: File) :  Longint;overload;

      {: - A classe método @name duplica o handle do arquivo no windows e linux.
      }
      public Class function DuplicateHandle(var hSource: Text;Var lpTarge: Text) :  Longint;overload;

      {: - A classe método @name duplica o handle do arquivo no windows e no linux essa função não funciona.
      }
      public Class function DuplicateHandle(hSourceHandle: THandle;Var lpTargeTHandle: THandle) :  Longint;overload;

      {: A classe function **@name** descarrega o buffer do arquivo passado por aHandle

         - **REFERÊNCIAS**
           - [Linux](https://www.freepascal.org/docs-html/rtl/unix/fpfsync.html)
           - [windows](https://docs.microsoft.com/en-us/windows/win32/api/fileapi/nf-fileapi-flushfilebuffers)
      }
      public Class function FileFlushBuffers(aHandle: THandle): longint;overload;

      {: - A função @name trava uma região do arquivo.
         -**NOTA**
          - O lockfile do linux não bloqueia região do arquivo e sim o arquivo todo.

         - **REFERÊNCIAS**
           - [Linux](https://www.freepascal.org/docs-html/rtl/unix/fpflock.html)
           - [windows](https://docs.microsoft.com/en-us/windows/win32/api/fileapi/nf-fileapi-lockfile)

      }
      public class function LockFile(_Handle:THandle; _LockStart, _LockLength: Int64): LongInt;

      {: - A classe método @name destrava a região travada por **LockFile**.

         - **NOTA**
           - Funciona no linux mais não funciona do linux.
      }
      public class function UnLockFile(_Handle:THandle; _LockStart, _LockLength: Int64): LongInt;

      {: - A classe método **@name** retorna uma lista de nomes de arquivos e diretórios
           que satisfazem os parâmetros: **Mask** e **FileAttrs**

         - **EXEMPLO DE USO**

           ```pascal

             procedure TMi_Rtl_Tests.FormCreate(Sender: TObject);
             begin
               ListFiles := TMiStringList.Create;
               Action_test_FindFirstExecute(Self);
             end;

             procedure TMi_Rtl_Tests.Action_test_FindFirstExecute(Sender: TObject);
               //Este procedimento ler os atributos da pasta: '.'

               function GetInfoFile(FileName:string;attribute : Cardinal; out info : TSearchRec): Integer;

               begin
                  Result := FindFirst(ExpandFileName(FileName),attribute,Info);
                  if Result = 0
                  then Begin
                         ShowMessage('O arquivo '+fileName+' contém o atributo: '+intToStr(attribute));
                       end
                  else begin
                         ShowMessage('O arquivo '+fileName+' não contém o atributo: '+intToStr(attribute));
                       end;
               end;

               var
                Info: TSearchRec;
                err,i : integer;

                const FileAttrs : Cardinal = faHidden or
                                             faReadOnly or
                                             faSysFile or
                                             faArchive or
                                             faAnyFile or
                                             faSymLink or
                                             faDirectory ;


             begin
               ListFiles.Clear;
               ListBox1.Clear;

               FileAttrs := 0;

               if CheckBox_faHidden.Checked
               then FileAttrs := faHidden;

               if CheckBox_faReadOnly.checked
               then FileAttrs := FileAttrs or faReadOnly;

               if CheckBox_faSysFile.checked
               then FileAttrs := FileAttrs or faSysFile;

               if CheckBox_faArchive.checked
               then FileAttrs := FileAttrs or faArchive;

               if CheckBox_faAnyFile.checked
               then FileAttrs := FileAttrs or faAnyFile;

               if CheckBox_faSymLink.checked
               then FileAttrs := FileAttrs or faSymLink;

               if CheckBox_faDirectory.checked
               then FileAttrs := FileAttrs or faDirectory;

               with TMI_ui_types do
                 FindFiles(Edit1.Text,FileAttrs ,ListFiles );

               LabelCount.Caption := Format('ListFiles.Count %d',[ListFiles.Count]);
               LabelCount.Show;
               if ListFiles.Count > 0
               then begin
                       for i := 0 to ListFiles.Count-1 do
                       begin
                         ListBox1.Items.Add(ListFiles[i]);
                       end;
                    end;
             end;


             procedure TMi_Rtl_Tests.Edit1Change(Sender: TObject);
             begin
               Action_test_FindFirstExecute(Self);
             end;

             procedure TMi_Rtl_Tests.CheckBox_faAnyFileChange(Sender: TObject);
             begin
               Action_test_FindFirstExecute(Self);
             end;

             procedure TMi_Rtl_Tests.CheckBox_faArchiveChange(Sender: TObject);
             begin
               Action_test_FindFirstExecute(Self);
             end;

             procedure TMi_Rtl_Tests.CheckBox_faDirectoryChange(Sender: TObject);
             begin
               Action_test_FindFirstExecute(Self);
             end;

             procedure TMi_Rtl_Tests.CheckBox_faHiddenChange(Sender: TObject);
             begin
               Action_test_FindFirstExecute(Self);
             end;

             procedure TMi_Rtl_Tests.CheckBox_faReadOnlyChange(Sender: TObject);
             begin
               Action_test_FindFirstExecute(Self);
             end;

             procedure TMi_Rtl_Tests.CheckBox_faSymLinkChange(Sender: TObject);
             begin
               Action_test_FindFirstExecute(Self);
             end;

             procedure TMi_Rtl_Tests.CheckBox_faSysFileChange(Sender: TObject);
             begin
               Action_test_FindFirstExecute(Self);
             end;

           ```
      }
      class procedure FindFiles(Mask : AnsiString; FileAttrs : Cardinal; var List : TStringList);

      {: A class método **@name** retorna em **List** todos os arquivos, inclusives os arquivos dos subdiretórios
         que satisfazem os parâmetros: **Mask** e **FileAttrs**.

         - Notas
           - Suponha a pasta **views** contendo as pastas **pages** e **partial** contendo os seguintes arquivos:

             ```pascal

               views/
               ├── pages
               │   ├── about.ejs
               │   ├── about.html
               │   ├── index.ejs
               │   └── index.html
               └── partials
                   ├── footer.ejs
                   ├── head.ejs
                   └── header.ejs

             ```

           - Efeito esperado da função @name é equivalente ao comando linux abaixo:

             ```pascal

                find ./ -iname *.ejs

                > ./pages/index.ejs
                > ./pages/about.ejs
                > ./partials/head.ejs
                > ./partials/header.ejs
                > ./partials/footer.ejs

             ```
         - EXEMPLO

             ```pascal

               procedure TForm1.Action_test_FindFirstExecute(Sender: TObject);
                 //Este procedimento ler os atributos da pasta: '.'

                 var
                  i : integer;
                  const FileAttrs : Cardinal = faHidden or
                                               faReadOnly or
                                               faSysFile or
                                               faArchive or
                                               faAnyFile or
                                               faSymLink or
                                               faDirectory ;


               begin
                 ListFiles.Clear;
                 ListBox1.Clear;
                 ListBox1.Hide;
                 FileAttrs := 0;

                 if CheckBox_faHidden.Checked
                 then FileAttrs := faHidden;

                 if CheckBox_faReadOnly.checked
                 then FileAttrs := FileAttrs or faReadOnly;

                 if CheckBox_faSysFile.checked
                 then FileAttrs := FileAttrs or faSysFile;

                 if CheckBox_faArchive.checked
                 then FileAttrs := FileAttrs or faArchive;

                 if CheckBox_faAnyFile.checked
                 then FileAttrs := FileAttrs or faAnyFile;

                 if CheckBox_faSymLink.checked
                 then FileAttrs := FileAttrs or faSymLink;

                 if CheckBox_faDirectory.checked
                 then FileAttrs := FileAttrs or faDirectory;

                 with TObjectss do
                  FindFilesAll(GetCurrentDir,*.html,FileAttrs ,ListFiles );
                  // Quando o path não informado, FindFileAll seleciona todos os arquivos apartir da pasta atual.
                  FindFilesAll('',*.html,FileAttrs ,ListFiles );

                 LabelCount.Caption := Format('ListFiles.Count %d',[ListFiles.Count]);
                 LabelCount.Show;


                 if ListFiles.Count > 0
                 then begin
                         for i := 0 to ListFiles.Count-1 do
                         begin
                           ListBox1.Items.Add(ListFiles[i]);
                         end;
                      end;
                 ListBox1.Show;
               end;


             ```
      }
      class procedure FindFilesAll(aPath,Mask : AnsiString; FileAttrs : Cardinal;aRelative:Boolean; var List : TStringList);
      //      class procedure FindFilesAll(Mask: AnsiString; FileAttrs: Cardinal;var List: TStringList);

      {: A classe método **@name** retorna o corrente pasta.
      }
      class function GetCurrentDir : AnsiString;

      {: A classe método **@name** define a pasta passado por **NewDir** como pasta corrente.

         **PARÂMETRO**
           - **NewDir** - Nome da pasta a ser definida.

         **RETORNA**
           - **TRUE** - Se sucesso
           - **FALSE** - Se fracasso;
      }
      class function SetCurrentDir( const NewDir : AnsiString):Boolean;

      {: A classe método **@name** checa se a pasta passado por **Directory** é uma pasta válida.

         **PARÂMETRO**
           - **Directory** - Nome da pasta

         **RETORNA**
           - **TRUE** - Se a pasta existe
           - **FALSE** - Se a pasta não existe;
      }
      class function IsDirectory( const Directory : AnsiString):Boolean;

      {: Retorna o numero de arquivos abertos no sistema operacional

        - **NOTA**
          - TaStaus : Retorna o número do error se ouver
      }
      class Function FPrimeiroHandleLivre : SmallInt;

      {: A class function **@name**  define ou remove um bloqueio no arquivo passado por Handle.

         - **PARÂMETROS**

           - **MODE**
             - O modo pode ser uma das seguintes constantes:
               - LOCK_SH : define um bloqueio compartilhado.
               - LOCK_EX : define um bloqueio exclusivo.
               - LOCK_UN : desbloqueia o arquivo.
               - LOCK_NB : Isso pode ser OR junto com o outro. Se isso for feito,
                           o aplicativo não bloqueia ao bloquear.
         - **RETORNO**
           - LONGINT : A função retorna zero se for bem-sucedida,
                       um valor de retorno diferente de zero indica um erro.

         - **REFERÊNCIA**
           - https://www.freepascal.org/docs-html/rtl/unix/fpflock.html
      }
      class function FlockFile (Handle : Thandle; modo : LongInt): LongInt ;overload;

      {: A class function **@name** retorna o espaço livre (EM BYTES) da partição passada por Partition

         - PARÂMETRO:
           - 0 para a partição atual.
           - 1 para a primeira unidade de disquete.
           - 2 Para a segunda unidade de disquete.
           - 3 Para a primeira partição do disco rígido.
           - 4-26 Para todas as outras unidades e partições.

         - REFERÊNCIA:
           - https://www.freepascal.org/docs-html/rtl/sysutils/diskfree.html

         - OBSERVAÇÃO:
           - No Linux, e no Unix em geral, o conceito de disco é diferente do dos um, uma vez que o sistema de arquivos é visto
             como uma grande árvore de diretórios. Por esta razão, os DiskFree e DiskSize funções devem ser mimetizado utilizando
             nomes de arquivos que residem nas partições. Para obter mais informações, consulte AddDisk.

         - EXEMPLO:

           ```pascal

             procedure testDiskFree;
                var
                  VrDiskFree : int64;
             begin
               WriteLn('TestDiskFree;');

               VrDiskFree := Diskfree(0);
               Writeln ('Free space of current disk: ',VrDiskFree, ' Bytes');

               VrDiskFree := (VrDiskFree div 1024);
               Writeln ('Free space of current disk: ',VrDiskFree,' KB)');

               VrDiskFree := (VrDiskFree div 1024);
               Writeln ('Free space of current disk: ',VrDiskFree,' MB)');

               VrDiskFree := (VrDiskFree div 1024);
               Writeln ('Free space of current disk: ',VrDiskFree,' GB)');

               VrDiskFree := (VrDiskFree div 1024);
               Writeln ('Free space of current disk: ',VrDiskFree,' TB)');
             end;

           ```
      }
      class function DiskFree(Partition:byte; out VrDiskFree :Int64):integer;

      class Function ByteDrive(Const NomeArquivo:AnsiString) : Byte;

    end;

implementation


{$REGION  'implementation' }

  class function TFiles.IsFileOpen(VAR F:FILE):BOOLEAN ;
  BEGIN
    Result  := (FILEREC (F ).MODE = System.FmInOut )  OR
               (FILEREC (F ).MODE = System.FmOutput ) OR
               (FILEREC (F ).MODE = System.FmInput )  ;

  END ;

  class function TFiles.IsFileOpen(VAR F:Text):BOOLEAN ;
  BEGIN
    Result := (TextRec(F).MODE = System.FmInOut )  OR
              (TextRec(F).MODE = System.FmOutput ) OR
              (TextRec(F).MODE = System.FmInput );
  END ;


  class function TFiles.AppVersionInfo: TAppVersionInfo;
  begin
    try
      result := mi.rtl.libBinRes.AppVersionInfo;
    Except
      result := nil;
    end;

  end;

  class function TFiles.IoResult: Integer;
  Begin
    result := System.IoResult;
    TaStatus := result;
  end;


  class procedure TFiles.CtrlSleep(const Delay: Cardinal);
  begin
    If CTRL_SLEEP_ENABLE Then
    begin
      If FORMS_APPLICATION_PROCESS_MESSAGES and Assigned(onProcessMessages)
     Then onProcessMessages('TFiles.CtrlSleep');

      Sleep(Delay);

      {Desativei porque estava demorando muito para abrir um nf.
        Start := GetTickCount;
        repeat
          If Application <> nil
          Then Application.ProcessMessages;
          Sleep(0);
        until (GetTickCount - Start) >= Delay;
      }
    end;

  end;

  class function TFiles.Set_CTRL_SLEEP_ENABLE(const aEnable: Boolean): Boolean; // Retorna o estado anterior de SYS_CTRL_SLEEP_ENABLE
  Begin
    Result := CTRL_SLEEP_ENABLE;
    CTRL_SLEEP_ENABLE := aEnable;
  end;

  class function TFiles.ReadKey: AnsiChar;
  begin
    {$IFNDEF App_CGI}
      if IsConsole
      then Begin
            result := crt.ReadKey;
          End
      Else Result := #0;
    {$ELSE}
      Result := #0;
    {$ENDIF}
    UAnsiChar := result;
  end;

  class procedure TFiles.SetLastError(aCodeError: integer);
  Begin
    LastError := aCodeError;
    taStatus  := LastError;
    ok := LastError = 0;
  end;

  class function TFiles.SetResult(aHandle: THandle ; aSuccess: Boolean): Longint;
  begin
    Result := 0;
    //Checa se houver erro na função que o chamou.
    if (not aSuccess) or (aHandle = HANDLE_INVALID)
    then Begin // Pega o último erro por plataforma.
           result := GetLastOSError;
           If Result = 0
           Then Result := ParametroInvalido;
         End;
    LastError := Result;
    ok := result = 0;
  end;

  class function TFiles.CopyFile(lpExistingFileName, lpNewFileName: AnsiString;  aExceptionOnError: boolean): Integer;
  Begin
    if Not aExceptionOnError
    then begin
            if FileUtil.CopyFile(lpExistingFileName,lpNewFileName,true, aExceptionOnError)
            then SetLastError(0)
            else SetLastError(GetLastOSError);
         end
    else Begin
           if FileUtil.CopyFile(lpExistingFileName,lpNewFileName,true, aExceptionOnError)
           then SetLastError(0)
         end;
    result  := LastError;
  end;

    class function TFiles.SetFileMode(aFileMode: word): word;
  begin
    Result      := FileMode;
    FileMode    := aFileMode ;
    System.FileMode := Byte(FileMode);
  End;

    class function TFiles.SetStateFileMode(const AState: Longint;
    const Enable: boolean): Boolean;
  Begin
    If FileMode and aState <> 0
    Then Result := True
    Else Result := false;

    if Enable
    then FileMode := FileMode or AState
    else FileMode := FileMode and not AState;
  End;

    class function TFiles.GetStateFileMode(const AState: Longint): Boolean;
  Begin
    If FileMode and aState <> 0
    Then Result := True
    Else Result := false;
  End;

  class  function TFiles.FileOpen(const FileName: AnsiString;
                                  const Mode: Longint;
                                  const ShareMode : Cardinal;
                                  out Handle: THandle): Longint;Overload;
  begin
    Handle := SysUtils.FileOpen (FileName,Mode or ShareMode);
    result := SetResult(handle,Handle > 0);
    if result <> 0
    then  Handle := HANDLE_INVALID;
  end;

  class function TFiles.FileOpen(const FileName: AnsiString;  out Handle: THandle): Longint; Overload;

  begin
    Result := FileOpen(FileName,fileMode,0,Handle);
  end;

    class function TFiles.FileClose(Handle: THandle): Longint;
  begin
    SysUtils.FileClose(Handle);
    SetLastError(0);
    result := LastError;
  end;

    class function TFiles.FileTruncate(Handle: THandle; NewSize: Int64): Longint;
  begin
    SetResult(handle,SysUtils.FileTruncate(Handle,NewSize));
    result := LastError;
  end;

  class function TFiles.FileCreate(FileName: AnsiString;
                                   Mode: Longint;
                                   ShareMode : Cardinal;
                                   out Handle: THandle): Longint;
  begin
    FileName := ExpandFileName(FileName);
    Handle := SysUtils.FileCreate(FileName,fmCreate ,GLOBAL_RIGHTS);
    result := SetResult(handle,Handle > 0);

    if result <> 0
    then Handle := HANDLE_INVALID
    else begin //fecha e abre novamente para que os flags do mapa de bits ShareMode funcione.
           FileClose(Handle);
           result := FileOpen(FileName,Mode, ShareMode,Handle);
           result := SetResult(handle,Handle > 0);
           if result <> 0
           then Handle := HANDLE_INVALID
         end;
  end;

  class function TFiles.DeleteFile (const FileName : AnsiString): SmallInt;
  begin
    if not SysUtils.DeleteFile(FileName)
    then begin
           SetLastError(GetLastOSError);
           If LastError = 0
           Then SetLastError(Erro_Excecao_inesperada);//Esse erro nunca deve acontecer
    end
    else SetLastError(0);
    Result := TaStatus;
  end;


  class function TFiles.FileSize( FileName: string; out Count : int64):longint; overload;
      var F : file of byte;
    begin
      Filename := ExpandFileName(Filename);
      if SysUtils.FileExists(Filename) // Precisei fazer o teste se o arquivo existe porque Reset não identifica. Bug.
      Then Begin
              System.assign (F, Filename);

              {$I-}
                System.reset (F);
                Result := IoResult;
              {$I+}

              If Result = 0
              Then begin
                     {$I-}
                       Count := System.FileSize(F);
                       Result := IoResult;
                     {$I+}
                     if result <> 0
                     Then SetLastError(Result);
                     close (F);
                   end
              Else Begin
                     SetLastError(Result);
                   end;
           end
      else Begin
             Result := ArquivoNaoEncontrado2;
             SetLastError(Result);
         end;
  end;

  class function TFiles.FileSize( FileName: string):int64; overload;
      var err: Longint;
  begin
    err := FileSize(FileName,result);
    SetLastError(err);
  end;

  {: O função **@name** retorna em aFileSize a soma de todos os arquivos que satisfaça a mascara em path;

     - **NOTA**
       - Se houver error retorna o código do error em FileSize
  }
  class function TFiles.FileSizes(Mask: AnsiString;out aFileSize:Int64): Longint; overload;
    var
      sr       : TSearchRec;
      FileAttrs: Integer;
      WCurrentDir : PathStr;
      wPathFont   : tString;
  begin

    result    := 0;
    aFileSize := 0;
    FileAttrs := faAnyFile;
    wCurrentDir := GetCurrentDir;
    wPathFont   := ExtractFilePath(Mask);

    try
      If wPathFont <> ''
      Then SetCurrentDir(wPathFont);

      if SysUtils.FindFirst(ExpandFileName(Mask), FileAttrs, sr) <> 0
      Then begin
             result := ArquivoNaoEncontrado2;
             exit;
           end;

      repeat
        { O atributo faAnyFile indica todos os arquivos, inclusive os diretórios

        }
        if ((sr.Attr and faDirectory) = 0) then
        begin
          inc(aFileSize,sr.Size);
        end;
      until SysUtils.FindNext(sr) <> 0;
      SysUtils.FindClose(sr);

    finally
      SetCurrentDir(wCurrentDir);
    end;
  end;

  class function TFiles.FileSeek(const Handle: THandle; const FOffset: Int64;
    Origin: LongInt; out NewPos: Int64): LongInt;
  begin
    NewPos := SysUtils.FileSeek(Handle,FOffset,Origin);
    result := SetResult(handle,NewPos >= 0);

  end;

  class function TFiles.FileRead(const Handle: THandle; out Buffer; const Count: Int64; out BytesRead: int64): LongInt;
  begin
    BytesRead := SysUtils.FileRead(Handle,Buffer,Count);
    result := SetResult(handle,BytesRead > 0);
  end;

  class function TFiles.FileWrite(const Handle: THandle; const Buffer; const Count: Int64; out BytesWrites: int64): LongInt;
  Begin

    BytesWrites := SysUtils.FileWrite(Handle,Buffer,Count);
    result := SetResult(handle,BytesWrites > 0);
  end;

  class function TFiles.FileExists(const FileName: AnsiString): Boolean;
  begin
    result := SysUtils.FileExists(FExpand(FileName),true);
  end;

  class function TFiles.DirectoryExists(const Directory: AnsiString): Boolean;
  begin
    result := SysUtils.DirectoryExists(FExpand(Directory),true);
  end;

  class function TFiles.CreateDir(const NewDir: AnsiString): Boolean;
    var Dir: DirStr = '';
    var Name: NameStr ='';
    var Ext: ExtStr='';
  Begin
    Dir := NewDir;
    if NewDir[length(Dir)] <> DirectorySeparator
    then Dir := Dir + DirectorySeparator ;
   FSplit(FExpand(Dir),Dir,Name,Ext);


   result := DirectoryExists(dir);
   IF Not result
   Then Begin
          Result := SysUtils.ForceDirectories(dir);
        end;

   if not result
   then begin
          SetLastError(GetLastOSError);
          If LastError = 0
          Then SetLastError(NaoPodeCriarDiretorio);
        end
   else SetLastError(0);

  end;

  class function TFiles.GetTempFileName (const Dir : string): string ;
  begin
    result := sysUtils.GetTempFileName (Dir,'');
    if result = ''
    then begin
           SetLastError(GetLastOSError);
           If LastError = 0
           Then SetLastError(Erro_Excecao_inesperada);//Esse erro nunca deve acontecer
         end
    else SetLastError(0);
  end;

    class function TFiles.GetTempDir(const env: String; out path: PathStr
    ): SmallInt;
     var Dir: DirStr;
     var Name: NameStr;
     var Ext: ExtStr;
  Begin
    taStatus := 0;
    Path := GetEnv(env);
    if path = ''
    Then begin
           raise EArgumentException.Create('GetEven não localizou o parâmetro: '+env);
         end;

    Path := FExpand(Path)+PathDelim+'tmp'+PathDelim;
    ok   := DirectoryExists(Path);
    IF Not ok
    Then Begin
           ok := CreateDir(Path);
         end;
    Result := taStatus;
  end;

  class function TFiles.GetTempDir (): string;overload;
  begin
    result := sysUtils.GetTempDir(true);
    if result = ''
    then begin
           SetLastError(GetLastOSError);
           If LastError = 0
           Then SetLastError(Erro_Excecao_inesperada);  //Esse erro nunca deve acontecer
         end
    else SetLastError(0);
  end;

  class function TFiles.GetDriveType(aPath : AnsiString): TDriveType;Overload;
        var
      p : pChar;
  Begin
    {$IFDEF Windows}
      {$IFDEF UNICODE}
        case windows.GetDriveTypeA(AnsiString(SysWideStringToString(ExpandFileName(SysStringToWideString(aPath)))) ) of
      {$ELSE}
        p := @aPath;
        case windows.GetDriveTypeA(p) of
      {$ENDIF UNICODE}

          DRIVE_NO_ROOT_DIR  : Result := dt_DRIVE_NO_ROOT_DIR; //O caminho da raiz é inválido; por exemplo, não há volume montado no caminho especificado.
          DRIVE_FIXED        : Result := dt_HD;
          DRIVE_REMOVABLE    : Result := dt_PenDriver;
          DRIVE_CDROM        : Result := dt_CDROM;
          DRIVE_REMOTE       : Result := dt_LAN;
          DRIVE_RAMDISK      : Result := Dt_RamDisk;
          DRIVE_UNKNOWN      : Result := dt_Unknown;
        Else                 Result := dt_Invalid;
      End;//Case
    {$ENDIF}

    {$IFDEF UNIX}
       Result := dt_HD;
    {$ENDIF}

  end;


  class function TFiles.DuplicateHandle(var hSource: File;   var lpTarge: File): Longint;
  begin

     {$IFDEF WINDOWS}
       Result := DuplicateHandle(TFileRec(hSource).Handle,TFileRec(lpTarge).Handle);
     {$ELSE}
        Result := fpdup(hSource, lpTarge);
        result := SetResult(TFileRec(lpTarge).Handle,TFileRec(lpTarge).Handle > 0);
     {$ENDIF}
  end;

  class function TFiles.DuplicateHandle(var hSource: Text;   var lpTarge: Text): Longint;
//    var s,t:Thandle;
  begin
     //s := TTextRec(hSource).Handle;
     //t := TTextRec(lpTarge).Handle;

    {$IFDEF WINDOWS}
      Result := DuplicateHandle(TTextRec(hSource).Handle,TTextRec(lpTarge).Handle);
    {$ELSE}
       Result := fpdup(hSource, lpTarge);
       result := SetResult(TTextRec(lpTarge).Handle,TTextRec(lpTarge).Handle > 0);
    {$ENDIF}
  end;

  class function TFiles.DuplicateHandle(hSourceHandle: THandle; var lpTargeTHandle: THandle): Longint;

  Begin
    lpTargeTHandle := HANDLE_INVALID;


    {$IFDEF Windows}

      Result := LongInt(windows.DuplicateHandle(windows.GetCurrentProcess,// hSourceProcessHandle - Processo fonte
                                        hSourceHandle,            // handle a ser duplicado

                                        windows.GetCurrentProcess,// hTargetProcessHandle - Processo destino
                                        Pointer(@lpTargeTHandle),	// Handle duplicado
                                        0  ,                  	// dwDesiredAccess - access for duplicate handle
                                        true ,	                // BOOL bInheriTHandle - handle inheritance flag

            //                          DUPLICATE_CLOSE_SOURCE
                                        DUPLICATE_SAME_ACCESS  	// dwOptions - optional actions
                                      ));

      Result :=  SetResult(lpTargeTHandle,result > 0 );

    {$ELSE}
       lpTargeTHandle := fpdup(hSourceHandle);
       result := SetResult(lpTargeTHandle,lpTargeTHandle > 0);
       if result <> 0
       then hSourceHandle := HANDLE_INVALID;

    {$ENDIF}


  end;

  class function TFiles.FileFlushBuffers(aHandle: THandle): longint;
  begin
    if not SysUtils.FileFlush(aHandle)
    then Result := SetResult(aHandle,false)
    else Result := 0;
  end;




  class function TFiles.LockFile(_Handle:THandle; _LockStart, _LockLength: Int64): LongInt;
     var err:Longint;
  begin
    {$IFDEF WINDOWS}
       err := longInt(Windows.LockFile(_Handle, _LockStart, 0, _LockLength, 0));
    {$ELSE}
       err := 0;
       raise EArgumentException.Create('Não achei no linux função que faça a mesma coisa em TFiles.LockFile');
    {$ENDIF}

     Result := SetResult(_handle, err=0);
  end;

  class function TFiles.UnLockFile(_Handle:THandle; _LockStart, _LockLength: Int64): LongInt;
    var err:Longint;
  begin
    {$IFDEF WINDOWS}
       err := longInt(Windows.UnLockFile(_Handle, _LockStart, 0, _LockLength, 0));
    {$ELSE}
      err := 0;   Abort;
      raise EArgumentException.Create('Não achei no linux função que faça a mesma coisa em TFiles.UnLockFile');
    {$ENDIF}
    Result := SetResult(_handle, err=0);
  end;


  {$ENDREGION}


  class procedure TFiles.FindFiles(Mask : AnsiString; FileAttrs : Cardinal; var List : TStringList);
    var
      sr       : TSearchRec;
      WResult  : Boolean;
      fn        : AnsiString;
  begin
  //    FileAttrs := FileAttrs + faHidden;
  //    FileAttrs := FileAttrs + faDirectory;
    //FileAttrs := faHidden or
    //             faReadOnly or
    //             faSysFile or
    //             faArchive or
    //             faAnyFile
    //            //faArchive_nt


      Fillchar(sr,sizeof(sr),0);
      WResult := (SysUtils.FindFirst(Mask, FileAttrs, sr) = 0);

  //      If Not WResult
  //      Then  raise EArgumentException.Create(TStrError.ErrorMessage('O aquivo "'+Mask+'" nao encontrado'));

      //Mi_MsgBox.ShowMessage('O aquivo "'+Mask+'" nao encontrado');

      if WResult then
      begin
        repeat
          if ((sr.Attr and FileAttrs) <> 0) then
          begin
            //Insert(TDosStream.Create(ExpandFileName(sr.Name),FileMode));
  //            List.Add(ExpandFileName(sr.Name));
            List.Add(sr.Name);
          end;
        until SysUtils.FindNext(sr) <> 0;
        SysUtils.FindClose(sr);
      end;
      List.Sort;
    //Except
    //  If TaStatus = 0
    //  Then TaStatus := Erro_Excecao_inesperada;
    //
    //  Raise TException.Create(Self,
    //                          'SetMask',
    //                          '',
    //                          '',
    //                          TaStatus);
    //end;
  end;

//  class procedure TFiles.FindFilesAll(Mask: AnsiString; FileAttrs: Cardinal;var List: TStringList);
  class procedure TFiles.FindFilesAll(aPath,Mask: AnsiString; FileAttrs: Cardinal;aRelative:Boolean;var List: TStringList);
      var FileAtual : string;

      procedure ListarArquivosNaPasta( Pasta:string; const Padrao: string);
      var
        BuscaRecursiva: TSearchRec;
        CaminhoCompleto: string;
      begin
        if pasta[Length(pasta)] = DirectorySeparator
        then system.Delete(pasta,Length(pasta),1);

        // Procurar por arquivos na pasta atual usando caracteres coringas
        if FindFirst(Pasta + DirectorySeparator + Padrao, FileAttrs{faAnyFile}, BuscaRecursiva) = 0 then
        begin
          repeat
            // Verificar se é um arquivo regular (não diretório)
            if (BuscaRecursiva.Name <> '.') and (BuscaRecursiva.Name <> '..')
            //  and ((BuscaRecursiva.Attr and faDirectory) = 0)
            then
            begin
              if (BuscaRecursiva.Attr and FileAttrs <>0)
              Then Begin
                      CaminhoCompleto := Pasta + DirectorySeparator + BuscaRecursiva.Name;
                      //WriteLn(CaminhoCompleto);
                      if aRelative
                      Then List.Add(CreateRelativePath(CaminhoCompleto,FileAtual,false,true))
                      else List.Add(CaminhoCompleto)
                   end;

            end;
          until FindNext(BuscaRecursiva) <> 0;
          FindClose(BuscaRecursiva);
        end;

        // Procurar por subpastas
        if FindFirst(Pasta + DirectorySeparator + '*', faDirectory, BuscaRecursiva) = 0 then
        begin
          repeat
            // Verificar se é uma pasta válida
            if (BuscaRecursiva.Name <> '.') and (BuscaRecursiva.Name <> '..') then
            begin
              CaminhoCompleto := Pasta + DirectorySeparator + BuscaRecursiva.Name;
              // Chamar a função recursivamente para listar arquivos nas subpastas
              ListarArquivosNaPasta(CaminhoCompleto, Padrao);
            end;
          until FindNext(BuscaRecursiva) <> 0;
          FindClose(BuscaRecursiva);
        end;
      end;

      //var
      //  PastaAtual, Padrao: string;

      begin
        if Not Assigned(List)
        Then begin
               raise EArgumentException.Create('O Parâmetro Var List não inidicializado!');
             end;

        { Código anterior com o path incluindo em mask
          // Obter a pasta atual
          //PastaAtual := GetCurrentDir;
          PastaAtual := ExtractFilePath(mask);

          // Definir o padrão (wildcard) dos arquivos que deseja listar
          // Por exemplo, '*.txt' irá listar todos os arquivos com a extensão .txt
          Padrao := mask;
          system.Delete(Padrao,1,Length(PastaAtual));

          // Chamar a função para listar arquivos com o padrão especificado
          ListarArquivosNaPasta(PastaAtual, Padrao);
        }
        if aPath = ''
        Then aPath := GetCurrentDir;
        FileAtual := aPath ;

        // Definir o padrão (wildcard) dos arquivos que deseja listar
        // Por exemplo, '*.txt' irá listar todos os arquivos com a extensão .txt
        // Chamar a função para listar arquivos com o mask especificado
        ListarArquivosNaPasta(aPath, mask);

        List.Sort;
      end;


  class function TFiles.GetCurrentDir: AnsiString;
  begin
    result := SysUtils.GetCurrentDir;
  end;

  class function TFiles.SetCurrentDir(const NewDir: AnsiString): Boolean;
  begin
    result := SysUtils.SetCurrentDir(NewDir);
  end;

  class function TFiles.IsDirectory( const Directory : AnsiString):Boolean;
  begin
   result := SysUtils.DirectoryExists(Directory);
  end;

    class function TFiles.FPrimeiroHandleLivre: SmallInt;
    Var F   : File;
    {$I-}
  Begin
    If IoResult=0 Then;
    AssignFile(f,'FHandle.$$$');

    {$I-}rewrite(F);{$I+}
    TaStatus := IoResult;
    If TaStatus = 0 Then
    Begin
      result := FileRec(F).Handle;
      {$I-} Close(f); {$I+}
      {$I-} erase(f); {$I+}
    End
    Else
      Result := 0;
  End;

  class function TFiles.FlockFile (Handle : Thandle; modo : LongInt): LongInt ;overload;
  begin
    {$IFDEF Windows}
        raise EArgumentException.Create('FlockFile não implementado no windows: ');
        result := ParametroInvalido;
    {$ELSE}
      result := fpFlock(Handle,modo);
    {$ENDIF}

  end;

  class function TFiles.DiskFree(Partition:byte; out VrDiskFree :Int64):integer;
  begin
    VrDiskFree := SysUtils.DiskFree(Partition);
    if VrDiskFree < 0
    then begin
           VrDiskFree := 0;
           result := GetLastOSError;
           If Result = 0
           Then Result := Erro_Excecao_inesperada;
    end
    else result := 0;
  end;


    class function TFiles.ByteDrive(const NomeArquivo: AnsiString): Byte;
    Var DriveStr : AnsiChar;
    Begin
      if pos(':',NomeArquivo) > 0 then
      begin
        DriveStr := NomeArquivo[pos(':',NomeArquivo) -1];
        case upCase(DriveStr) of
         'A'   : Bytedrive := 1;
         'B'   : Bytedrive := 2;
         'C'   : Bytedrive := 3;
         'D'   : Bytedrive := 4;
         'E'   : Bytedrive := 5;
         'F'   : Bytedrive := 6;
         'G'   : Bytedrive := 7;
         'H'   : Bytedrive := 8;
         'I'   : Bytedrive := 9;
         'J'   : Bytedrive :=10;
         'K'   : Bytedrive :=11;
         'L'   : Bytedrive :=12;
         'M'   : Bytedrive :=13;
         'N'   : Bytedrive :=14;
         'O'   : Bytedrive :=15;
         'P'   : Bytedrive :=16;
         'Q'   : Bytedrive :=17;
         'R'   : Bytedrive :=18;
         'S'   : Bytedrive :=19;
         'T'   : Bytedrive :=20;
         'U'   : Bytedrive :=21;
         'V'   : Bytedrive :=22;
         'W'   : Bytedrive :=23;
         'X'   : Bytedrive :=24;
         'Y'   : Bytedrive :=25;
         'Z'   : Bytedrive :=26;
         else Begin
                Bytedrive :=0;
              end;
        end;
      end
      else ByteDrive := 0;
  End;


end.




