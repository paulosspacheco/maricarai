unit unit1;
  {:< - A Unit **@name** reune os testes de uso das classe métodos globais usados pelo pacote **mi.rtl**.
                 Esta unit foi testada nas plataformas: win32, win64 e linux.

    - **VERSÃO**
      - Alpha - 0.7.1

    - **CÓDIGO FONTE**:
      - @html(<a href="../units/unit1.pas">unit1.pas</a>)

    - **HISTÓRICO**
      - Criado por: Paulo Sérgio da Silva Pacheco paulosspacheco@@yahoo.com.br)
        - **2021-11-04 20:30** - Data em que essa unit foi criada.
        - **2021-11-04 21:00**
          - Criado exemplo de uso da classe método TFile.FileOpen
          - Criado exemplo de uso da classe método TFile.FileClose

        - **2021-11-15 15:00**
          - Documentação da Unit.
          - Criado exemplo de uso da classe método TFile.FileCreate;
          - Criado exemplo de uso da classe método TFile.FileTruncate;
          - Criado exemplo de uso da classe método FindFirst;
          - Removi as constante que eu usava para compatibilidade com o passado e coloquei as atuais.
          - Adicionado o MenuBar
          - Adicionei o componente ActionList com objetivo de criar ações para adicionar nos menus de opções.

        - **2021-11-16**
          - Hora de início: 08:00
            - Adicionar um menu de opções
            - Adicionar a class TActionList
            - Converter os eventos dos botões para TActionList
            - Criar os itens do menu main usando TActionList.

          - Hora de início: 13:30
            - Documentar a unit **@name**.
            - Criar exemplo de uso do método **TObjectss.FileSize()**
            - Criar exemplo de uso do método **TObjectss.FileSeek()**

            - Criar exemplo de uso do método **TObjectss.FileSize()**
          - Hora de início: 20:30
            - Criar exemplo de uso do método **TObjectss.FileRead()**

        - **2021-11-29**
          - 09:05 a 10:10 - T12 Criar exemplos da classe TFileStream com header: 
            - TForm1.Test_FileStream_com_header;
          - 12:50 a 14:41 - T21 Documentar a classe TFileStream. 
          - 14:45 a 15:20 - T21 Documentar a classe TBufferMemory.
            
        - **2021-12-04**
          - 15:00 a 15:10 - Criar menu mi.ui/Dialogs
          - 15:11 a 16:51
             - Criar exemplo TForm1.Test_tobjects_dlgs_Confirm;
             - Criar exemplo TForm1.Test_tobjects_dlgs_Prompt;
             - Criar exemplo TForm1.Test_tobjects_dlgs_password;

        - **2021-12-13**
          - 20:40 a 22:15
            - Criar método : TForm1.Action_test_Logs_WarningExecute
            - Criar método : TForm1.Action_test_Logs_ErrorExecute
            - Criar método : TForm1.Action_test_Logs_InfoExecute

        - **2021-12-20**
          - 09:35 a 12:34 : T12 Criar um exemplo visual para entender a função FindFirst.
                            procedure TForm1.Action_test_FindFirstExecute(Sender: TObject);
          - 14:00 a 16:26 : T12 Testar o atributo FaDirectory

          - 20:20 a 22:30 : T12 - Criar exemplo de uso da classe TfilesStreams.
                            procedure TForm1.TabSheet_TfilesStreamsEnter(Sender: TObject);
        - **2021-12-30**
          - 08:57 a 11:35  : Criar exemplo Test_String_Asc_GUI_to_Asc_Ingles  de como converter caracteres acima de 127 para caractere equivalente abaixo de 127.
          - 08:57 a 11:35  : Criar exemplo Test_String_Asc_GUI_to_Asc_html  de como converter caracteres acima de 127 para caractere equivalente em html.

        - **2023-04-24**
          - 9:42   : Criar exemplo de uso do



  }



  {$IFDEF FPC}
    {$MODE Delphi} {$H+}
  {$ENDIF}


interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, ActnList,
  ComCtrls, ExtCtrls, StdCtrls,
  simpleipc, //comunição entre processo; https://wiki.freepascal.org/SimpleIPC
  Grids, LazHelpHTML, //charset,lazUtils,
//  mi.ui.CreateMessageDialog,    // LConvEncoding,  LazUTF8,
  //mi.rtl.objects.consts.MI_MsgBox,
//  mi.rtl.objects.Methods.tprogressdlg_if,
//  mi.ui.types,

  {$IFDEF linux}
    systemlog,
  {$ENDIF}
  FileUtil ,
  eventlog,
  LazLogger
  ,Mi_ui_mi_msgBox_dm
//  ,test
  ,mi.rtl.objects.methods.db.tb__access_test
  //, mi.rtl.objects.methods.ui.Dmxscroller.test
  , mi.rtl.objectss
  ,mi.rtl.Types
  , Types
  ,mi.rtl.objects.methods.pageproducer.test

  ;

type
  { TForm1 }
  {: - O formulário **@name** é usado para testar o pacote pacote
       mi.rtl}
  TForm1 = class(TForm)
      Action_test1_pageProducer: TAction;
      Action_sobre: TAction;
      Action_test_GetTempDir: TAction;
      Action_Test_TTb_access_SetTransaction: TAction;
      Action_test_TTb_access_DeleteRec: TAction;
      Action_Test_TTb_access_Lista_ordem_decrescente: TAction;
      Action_Test_TTb_access_Lista_ordem_crescente: TAction;
      Action_test_TTb__Access_Cadastra: TAction;
      Action_Test_MessageError: TAction;
      Action_test_removeAccents: TAction;
      Action_Test_String_Asc_GUI_to_Asc_html: TAction;
      Action_Test_String_Asc_GUI_to_Asc_Ingles: TAction;
      Action_Test_TFilesStreams: TAction;
      Action_Test_TMi_Msgbox_LCL: TAction;
      Action_test_TException: TAction;
      Action_test_LogError: TAction;
      Action_Test_Logs_Info: TAction;
      Action_test_Logs_Error: TAction;
      ActionTLazLogger: TAction;
      Action_testTLazLoggerFileHandle: TAction;
      Action_test_Logs_Warning: TAction;
      Action_Test_systemlog: TAction;
      Action12: TAction;
      Action12222: TAction;
      Action1ii: TAction;
      Button2_FindFirst: TButton;
      CheckBox_faDirectory: TCheckBox;
      CheckBox_faSymLink: TCheckBox;
      CheckBox_faAnyFile: TCheckBox;
      CheckBox_faHidden: TCheckBox;
      CheckBox_faArchive: TCheckBox;
      CheckBox_faSysFile: TCheckBox;
      CheckBox_faReadOnly: TCheckBox;
      Edit1: TEdit;
      Edit2: TEdit;
      Edit_FileSizes: TEdit;
      Label3: TLabel;
      MenuItem26: TMenuItem;
      MenuItem27: TMenuItem;
      MenuItem36: TMenuItem;
      MenuItem44: TMenuItem;
      MenuItem45: TMenuItem;
      MenuItem46: TMenuItem;
      MenuItem47: TMenuItem;
      TMi_Rtl_TObjectss: TMenuItem;
      MenuItem38: TMenuItem;
      MenuItem39: TMenuItem;
      MenuItem40: TMenuItem;
      MenuItem41: TMenuItem;
      MenuItem42: TMenuItem;
      MenuItem43: TMenuItem;
      MenuItem_CodePage: TMenuItem;

      NumeroDeArquivo: TEdit;
      GroupBox_Atributo: TGroupBox;
      Label1: TLabel;
      Label2: TLabel;
      LabelCount: TLabel;
      ListBox1: TListBox;
      MenuItem34: TMenuItem;
      MenuItem35: TMenuItem;
      MenuItem37: TMenuItem;
      MenuItemCollections: TMenuItem;
      PageControl_test: TPageControl;
      ScrollBox_TfilesStreams: TScrollBox;
      Separator1: TMenuItem;
      StringGrid1: TStringGrid;
      TabSheet_TfilesStreams: TTabSheet;
      TabSheet_TestFindFirst: TTabSheet;
      TFilesLogs: TAction;

      Action_test_TLazLoggerFileHandle: TAction;
      Action_test_CreateMessageDialog: TAction;
      Action_Test_tobjects_dlgs_password: TAction;
      Action_Test_Mi_MsgBox_Prompt: TAction;
      Action_Test_tobjects_dlgs_Confirm: TAction;
      Action_Test_FileStream_com_header: TAction;
      Action_Test_FileStream_sem_header: TAction;
      Action_test_TBufferMemory_Com_Header: TAction;
    Action_test_TBufferMemory_Sem_Header: TAction;
    Action_Test_FileWrite: TAction;
    Action_Test_FileRead: TAction;
    Action_Test_FileSize: TAction;
    Action_Test_OpenFile_exclusive_fmShareExclusive: TAction;
    Action_Test_FileSeek: TAction;
    Action_Test_Reset: TAction;
    Action_test_FindFirst: TAction;
    Action_test_CopyFile: TAction;
    Action_Test_OpenFile_exclusive_fmShareDenyNone: TAction;
    Action_test_FileTruncate: TAction;
    Action_test_FileCreate: TAction;
    Action_Test_OpenFile_exclusive_mode: TAction;
    ActionList1: TActionList;
    Button1: TButton;
    Button_test_TLazLoggerFileHandle: TButton;
    EventLog1: TEventLog;

    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem14: TMenuItem;
    MenuItem15: TMenuItem;
    MenuItem16: TMenuItem;
    MenuItem17: TMenuItem;
    MenuItem18: TMenuItem;
    MenuItem19: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem20: TMenuItem;
    MenuItem21: TMenuItem;
    MenuItem22: TMenuItem;
    MenuItem23: TMenuItem;
    MenuItem24: TMenuItem;
    MenuItem28: TMenuItem;
    MenuItem29: TMenuItem;
    MenuItem30: TMenuItem;
    MenuItem31: TMenuItem;
    MenuItem32: TMenuItem;
    MenuItem33: TMenuItem;
    MenuItem_TObjectss_logs: TMenuItem;
    MenuItem25: TMenuItem;
    MenuItemI_DB: TMenuItem;
    MenuItem_TTb__Access: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    MenuItem_Mi_rtl_TFiles: TMenuItem;
    MenuItem_Test_FileRead: TMenuItem;
    MenuItem_Test_FileSeek: TMenuItem;
    MenuItem_Mi_rtl_TObjectss: TMenuItem;
//    MenuItem_Tobjectss_logs: TMenuItem;

    TLazLoggerFileHandle: TAction;
    ToggleBox1: TToggleBox;


    procedure Action_sobreExecute(Sender: TObject);
    procedure Action_test1_pageProducerExecute(Sender: TObject);
    procedure Action_test_GetTempDirExecute(Sender: TObject);

    {: Exemplo de uso das mensagens de erros empilhadas.

       - Este recurso permite produzir um relatório dentro de uma transação uma transação onde só será
         vista após o sistema sair da transação .

       - **EXEMPLO**

         ```PASCAL
             procedure TForm1.Action_Test_MessageErrorExecute(Sender: TObject);
             begin
               with TObjectss do
               begin
                 ErrorInfo := 2;
                 Push_MsgErro(TStrError.ErrorMessage(ErrorInfo));

                 ErrorInfo := 10;
                 Push_MsgErro(TStrError.ErrorMessage(ErrorInfo));
                 TObjectss.MessageError;
               end;
             end;
         ```

    }
    procedure Action_Test_MessageErrorExecute(Sender: TObject);


    procedure Action_Test_TMi_Msgbox_LCLExecute(Sender: TObject);
    procedure Action_Test_TTb_access_SetTransactionExecute(Sender: TObject);
    procedure Action_Test_String_Asc_GUI_to_Asc_htmlExecute(Sender: TObject);
    procedure Action_Test_String_Asc_GUI_to_Asc_InglesExecute(Sender: TObject);

    procedure Action_test_TfilesStreamsExecute(Sender: TObject);
    procedure Action_test_removeAccentsExecute(Sender: TObject);

    procedure Action_test_LogErrorExecute(Sender: TObject);
    procedure Action_test_Logs_ErrorExecute(Sender: TObject);
    procedure Action_Test_Logs_InfoExecute(Sender: TObject);
    procedure Action_test_Logs_WarningExecute(Sender: TObject);
    procedure Action_Test_systemlogExecute(Sender: TObject);
    procedure Action_test_TExceptionExecute(Sender: TObject);
    procedure Action_Test_tobjects_dlgs_ConfirmExecute(Sender: TObject);
    procedure Action_Test_FileStream_com_headerExecute(Sender: TObject);
    procedure Action_Test_FileStream_sem_headerExecute(Sender: TObject);
    procedure Action_test_TBufferMemory_Com_HeaderExecute(Sender: TObject);
    procedure Action_test_TBufferMemory_Sem_HeaderExecute(Sender: TObject);
    procedure Action_Test_tobjects_dlgs_passwordExecute(Sender: TObject);
    procedure Action_Test_Mi_MsgBox_PromptExecute(Sender: TObject);
    procedure Action_test_CreateMessageDialogExecute(Sender: TObject);
    procedure Action_test_TTb_access_DeleteRecExecute(Sender: TObject);
    procedure Action_Test_TTb_access_Lista_ordem_crescenteExecute(
      Sender: TObject);
    procedure Action_Test_TTb_access_Lista_ordem_decrescenteExecute(
      Sender: TObject);
    procedure Action_test_TTb__Access_CadastraExecute(Sender: TObject);
    procedure Button2_FindFirstClick(Sender: TObject);

    procedure CheckBox_faAnyFileChange(Sender: TObject);
    procedure CheckBox_faArchiveChange(Sender: TObject);
    procedure CheckBox_faDirectoryChange(Sender: TObject);
    procedure CheckBox_faHiddenChange(Sender: TObject);
    procedure CheckBox_faReadOnlyChange(Sender: TObject);
    procedure CheckBox_faSymLinkChange(Sender: TObject);
    procedure CheckBox_faSysFileChange(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);



    procedure FormCreate(Sender: TObject);

    {: - O método **@name** testa o funcionamento do da função  TObjectss.FileCreate}
    procedure Action_test_FileCreateExecute(Sender: TObject);

    {: - O método **@name** testa o funcionamento das funçõese TObjectss.FileOpen e TObjectss.FileClose }
    procedure Action_Test_OpenFile_exclusive_fmShareDenyNoneExecute(   Sender: TObject);

    {: -- O Método testa o funcionamento das funçõese TObjectss.FileOpen e TObjectss.FileClose com fileMode ,fmOpenWrite or fmShareExclusive }
    procedure Action_Test_OpenFile_exclusive_fmShareExclusiveExecute(    Sender: TObject);

    {: - O método **@name** testa o funcionamento das funçõese TObjectss.FileOpen e TObjectss.FileClose no modo exclusivo}
    procedure Action_Test_OpenFile_exclusive_modeExecute(Sender: TObject);

    //: texto hint
    procedure Action_Test_OpenFile_exclusive_modeHint(var HintStr: string; var CanShow: Boolean);

    {: - O método **@name** testa o funcionamento do da função  TObjectss.FileTruncate}
    procedure Action_test_FileTruncateExecute(Sender: TObject);


    {: - O método **@name** testa o funcionamento da função  FindFirst}
    procedure Action_test_FindFirstExecute(Sender: TObject);

    {:- A função **@name** é usada para testar os erros possívei ao abrir um arquivo com o reset do freepascal.
    }
    procedure Action_Test_ResetExecute(Sender: TObject);

    {: - O método **@name** testa o funcionamento das funçõese TObjectss.FileOpen e TObjectss.FileClose no modo exclusivo}
    procedure Action_test_CopyFileExecute(Sender: TObject);

    {:- O Método **@name** abre um arquivo e posiciona no último byte do arquivo.
    }
    procedure Action_Test_FileSeekExecute(Sender: TObject);

    {: O Método **@name** demonstra o uso da funçao FileSize.
    }
    procedure Action_Test_FileSizeExecute(Sender: TObject);

    {: O Método **@name** demonstra o uso da funçao FileRead.
    }
    procedure Action_Test_FileReadExecute(Sender: TObject);

    {: O Método **@name** demonstra o uso da funçao FileWrite.
    }
    procedure Action_Test_FileWriteExecute(Sender: TObject);


    procedure FormDestroy(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);

    procedure TabSheet_TfilesStreamsEnter(Sender: TObject);
    private
      Form_pageproducer_test1:TForm_pageproducer_test;

    protected

    {: A procedure @name demonstra o uso da classe  **TObjectss.TBufferStream** quando o registro 0 (zero) do buffer
     é igual aos registros 1 a eof;
    }
    Procedure Test_TBufferMemory_sem_header;

    {: A procedure @name demonstra o uso da classe  **TObjectss.TBufferStream** quando o registro 0 (zero) do buffer
       é diferente dos registros 1 a eof;
    }
    Procedure Test_TBufferMemory_com_header;

    {: A procedure @name demonstra o uso da classe  **TObjectss.TFileStream** quando o registro 0 (zero) do arquivo
       é igual aos registros 1 a eof;
    }
    Procedure Test_FileStream_sem_header;

    {: A procedure @name demonstra o uso da classe  **TObjectss.TFileStream** quando o registro 0 (zero) do arquivo
       é diferente dos registros 1 a eof;
    }
    Procedure Test_FileStream_com_header;

    {: A procedure @name demonstra o uso do método de classe **TObjectss.dlgs.Confirm()**;
    }
    Procedure Test_tobjects_dlgs_Confirm;

    {: A procedure @name demonstra o uso do método de classe **TObjectss.dlgs.Prompt()**;
    }
    Procedure Test_tobjects_dlgs_Prompt;

    {: A procedure @name demonstra o uso do método de classe **TObjectss.dlgs.password()**;
    }
    Procedure Test_tobjects_dlgs_password;

    protected ListFiles : TStringList;

    Protected filesStreams  : TObjectss.TfilesStreams;

    {: A procedure **@name** é usada para converter caractere acima de 127 para caractere equivalente em HTML.

       - **EXEMPLO**
         - ç = '&ccedil;'
         - ã = '&atilde;';
         - é = '&eacute;';
         - etc...
    }
    protected procedure Test_String_Asc_GUI_to_Asc_html;

    {: A procedure **@name** é usada para converter caractere acima de 127 para caractere equivalente abaixo de 127.

       - **EXEMPLO**
         - ç = c;
         - ã = a;
         - é = e;
         - etc...
    }
    protected procedure Test_String_Asc_GUI_to_Asc_Ingles;

    {: A procedure **@name** é usada para converter caractere acima de 127 para caractere equivalente abaixo de 127.

       - **EXEMPLO**
         - ç = c;
         - ã = a;
         - é = e;
         - etc...
    }
    protected procedure test_removeAccents;


  end;



var
  Form1: TForm1;
  FileLog : TEventLog;


implementation

{$R *.lfm}


{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
//TObjectss.Set_MI_MsgBox(Mi_ui_mi_msgBox.MI_MsgBox1);

  ListFiles := TStringList.Create;
  filesStreams  := TObjectss.TfilesStreams.Create(10,10);
  with filesStreams do
  begin
//    Mask := GetCurrentDir;
    Mask := GetCurrentDir+'/*';
    Edit1.Text := Mask;
  end;
  Action_test_FindFirstExecute(Self);
end;


procedure TForm1.FormDestroy(Sender: TObject);
begin
  FreeAndNil(ListFiles);
  FreeAndNil(filesStreams);
end;

procedure TForm1.ListBox1Click(Sender: TObject);
begin

end;


//: Estudo de como acionar este documento.
procedure TForm1.Action_Test_OpenFile_exclusive_modeHint(
  var HintStr: string; var CanShow: Boolean);
begin
  HintStr := 'Abre o arquivo index.html da pasta corrente no modo exclusivo. ';
end;


procedure TForm1.Action_test_FileCreateExecute(Sender: TObject);

  var
    aHandle,aHandle2,aHandle3 :  TObjectss.THandle;
    err:integer;
    s : AnsiString;
begin
  with TObjectss do
  begin
    err := FileCreate('text.txt',fileMode, ShareMode ,aHandle);
    if err = 0
    then begin
           SysMessageBox('Arquivo text.txt criado na pasta corrente.','Action_test_FileCreateExecute',false);
           s := ExpandFileName('text.txt');

           FileMode := fmOpenReadWrite;
           ShareMode := fmShareCompat or fmShareDenyNone;

           err := FileOpen(s,FileMode, shareMode,aHandle2);
           if err = 0
           Then begin
                  SysMessageBox('Arquivo text.txt aberto com o modo fmOpenReadWrite e atributo fmShareCompat or fmShareDenyNone.','Action_test_FileCreateExecute',false);
                  FileClose(aHandle2);
                end
           else SysMessageBox(TStrError.ErrorMessage(err),'Action_test_FileCreateExecute',true);

           ShareMode := fmShareCompat or fmShareExclusive;
           err := FileOpen(s,fileMode,ShareMode ,aHandle3);
           if err = 0
           Then begin
                  SysMessageBox('Arquivo text.txt aberto com o modo fmOpenReadWrite e atributo fmShareCompat or fmShareExclusive.','Action_test_FileCreateExecute',false);
                  FileClose(aHandle3);
                end
           else SysMessageBox(TStrError.ErrorMessage(err),'Action_test_FileCreateExecute',true);


           FileClose(aHandle);
         end
         else SysMessageBox(TStrError.ErrorMessage(err),'Action_test_FileCreateExecute',true);
  end;
end;


procedure TForm1.Action_Test_OpenFile_exclusive_modeExecute(
  Sender: TObject);

  procedure Test_OpenFile_exclusive(aFileName:PAnsiChar);
  Var
    Err : TObjectss.integer;
    h,
    h1 : TObjectss.THandle;
  Begin
    with TObjectss do
      Err := FileOpen (aFileName, fmOpenWrite, fmShareExclusive or fmShareCompat   ,h);

    with TObjectss do
    if Err = 0
    Then Begin
           ShowMessage('Teste da função SysFileOpen retornou true');

           Err := FileOpen (aFileName,fmOpenWrite, fmShareExclusive or fmShareCompat   ,h1);
           if Err = 0
           Then Begin
                  FileClose(h1);
                  ShowMessage('Teste da função SysFileOpen retornou true')
                end
           else ShowMessage('Error: '+TStrError.ErrorMessage(Err));

           FileClose(h);
    end
    else ShowMessage('Error: '+TStrError.ErrorMessage(Err));

  End;

begin
  Test_OpenFile_exclusive('index.html');
end;

procedure TForm1.Action_Test_OpenFile_exclusive_fmShareExclusiveExecute  (Sender: TObject);

  procedure Test_OpenFile_exclusive_fmShareExclusive (aFileName:PAnsiChar);
    // Teste da função FileOpen com o modo fmOpenWrite e atributo fmShareExclusive

  Var
    Err : TObjectss.integer;
    h,
    h1  : TObjectss.THandle;
  Begin

    with TObjectss do
      Err := FileOpen (aFileName,fmOpenWrite, fmShareExclusive  ,h);

    with TObjectss do
    if Err = 0
    Then Begin
      //SysFileClose(h);
       ShowMessage('Teste da função SysFileOpen retornou true');

       Err := FileOpen (aFileName,fmOpenWrite, fmShareExclusive  ,h1);
       if Err = 0
       Then Begin
              FileClose(h1);
              ShowMessage('Teste da função SysFileOpen retornou true')
            end
       else ShowMessage('Error: '+SysErrorMessage(Err));

       FileClose(h);
    end
    else ShowMessage('Error: '+SysErrorMessage(Err));


  End;

begin
  Test_OpenFile_exclusive_fmShareExclusive('index.html');
end;

procedure TForm1.Action_Test_OpenFile_exclusive_fmShareDenyNoneExecute(  Sender: TObject);

  procedure Test_OpenFile_exclusive_fmShareDenyNone(aFileName:PAnsiChar);
    //Este procedimento teste a função FileOpen com  o modo fmOpenWrite e atributo fmShareDenyNone

  Var
    Err : TObjectss.integer;
    h,
    h1 : TObjectss.THandle;
  Begin
    with TObjectss do
      Err := FileOpen (aFileName,fmOpenWrite,  fmShareDenyNone ,h);

    with TObjectss do
    if Err = 0
    Then Begin
      //FileClose(h);
       ShowMessage('Teste da função FileOpen retornou true')
    end
    else ShowMessage('Error: '+SysErrorMessage(Err));

    with TObjectss do
      Err := FileOpen (aFileName,fmOpenWrite, fmShareDenyNone ,h1);

    with TObjectss do
    if Err = 0
    Then Begin
           FileClose(h1);
           ShowMessage('Teste da função SysFileOpen retornou true')
         end
    else ShowMessage('Error: '+SysErrorMessage(Err));

    TObjectss.FileClose(h);
  End;

begin
  Test_OpenFile_exclusive_fmShareDenyNone('index.html');
end;

procedure TForm1.Action_test_CopyFileExecute(Sender: TObject);
  // Este procedimento faz duas cópia do arquivo index.html
  Var
    err : TObjectss.integer;
Begin
  with TObjectss do
    err := CopyFile('index.html','index.bak1',false);

  with TObjectss do
  if err = 0
  Then showMessage('Copia 1 feita com sucesso.')
  else showMessage(TStrError.ErrorMessage(err));

  with TObjectss do
  try
    CopyFile('index.html','index.bak2',true);
    showMessage('Copia 2 feita com sucesso.') ;
  Except
    on E:Exception do
     ShowMessage(e.Message);
  end;
end;

procedure TForm1.Action_test_FileTruncateExecute(Sender: TObject);
    // Este procedimento Trunca o arquivos 'index.html' para 100 bytes
    Var
      aHandle: TObjectss.THandle;
      NewSize: TObjectss.word;
      err    : TObjectss.integer;
  Begin
    NewSize := 100;

    with TObjectss do
      err := FileOpen('index.html',aHandle);

    with TObjectss do
    if  err = 0
    then begin
           //Executa a função SysFileTruncate
           err := FileTruncate(aHandle,NewSize);

           if err = 0
           then showMessage('O arquivo foi truncado para 100 bytes')
           else ShowMessage('Error: '+TStrError.ErrorMessage(err));
         end
    else ShowMessage('Error: '+TStrError.ErrorMessage(err));
  end;


procedure TForm1.Action_Test_ResetExecute(Sender: TObject);
    // Teste se reset obedece o mapa de bits: fmOpenReadWrite or fmShareCompat or fmShareExclusive;
    //: - **NOTA**
    //:   - As contantes usadas para abertura de arquivo da **unit SysUtils** é totalmente diferente das
    //:     constantes usadas na **unit system**, por isso o exemplo abaixo não funciona.
    //:


    function fTest_Reset(Var f : file  ):longint;
    Begin
      AssignFile(f,'index.html');

      {$i-}
      Reset(f);
      {$i+}
      Result := IoResult;
      If Result <> 0
      then ShowMessage('Error: '+TObjectss.TStrError.ErrorMessage(result));
    end;


    Var
        f1,f2 : file;

  begin
//    Dados originais de fileMode
//    { file input modes }
//      fmClosed = $D7B0;
//      fmInput  = $D7B1;
//      fmOutput = $D7B2;
//      fmInOut  = $D7B3;
//      fmAppend = $D7B4;
//      FileMode : byte = 2;
    with TObjectss do
      system.fileMode := fmOpenReadWrite or fmShareCompat or fmShareExclusive;

    ShowMessage('Mapa de bits da constante FileMode é: fmOpenReadWrite or fmShareCompat or fmShareExclusive');

    if fTest_Reset(f1) = 0
    Then begin
           if fTest_Reset(f2) = 0
           then Begin
                  closeFile(f2);;
                  if system.fileMode and fmShareExclusive <>0
                  Then ShowMessage('Error: O FileMode indicou para abrir no modo exclusivo mais o reset não obedeceu.')
                  else ShowMessage('O arquvo foi aberto no modo compartilhado');
           end
           else begin
                  if system.fileMode and fmShareExclusive <>0
                  Then ShowMessage('Eureca: O botão reset está obdecendo o mapa de bits fmOpenReadWrite or fmShareCompat or fmShareExclusive.')
                  else ShowMessage('Error: O mapa de bits informa que o arquivo é compartilhado porém o reset não obdeceu.');
           end;

           closeFile(f1);


       end;
  end;

procedure TForm1.Action_Test_FileSizeExecute(Sender: TObject);
  // Este procedimento obtem o tamanho do arquivo em bytes do arquivo index.html;
  var
    FileName:AnsiString;
    Count:Int64;
    err:Longint;
Begin
  with TObjectss do
  begin
    FileName := 'index.html';
    err := FileSize(FileName,Count);
    if err <> 0
    Then showMessage(TStrError.ErrorMessage(err))
    else showMessage('Tamanho do arquivo é: '+intToStr(Count));
  end;
end;

procedure TForm1.Action_Test_FileSeekExecute(Sender: TObject);
    // Este procedimento posiciona o cursor no final do arquivo.
    Var
      err : TObjectss.integer;
      h   : TObjectss.THandle;
      NRec,Count : TObjectss.Int64;
Begin
  with TObjectss do
  begin

    err := FileOpen('index.html',h);
    if (err = 0)
    Then Begin
           err := fileSize('index.html',Count);
           if ( err = 0)
           Then begin
                 //Posiciona no final do arquivo
                 err := FileSeek(h,Count,fsFromBeginning,NRec);
                 if err <> 0
                 Then ShowMessage(TStrError.ErrorMessage(err))
                 Else ShowMessage('Ponteiro do arquivo é: '+IntToStr(NRec));

           end
           else ShowMessage(TStrError.ErrorMessage(err));
           FileClose(h);
         end
    else ShowMessage(TStrError.ErrorMessage(err));
  end;
end;

procedure TForm1.Action_Test_FileReadExecute(Sender: TObject);

  // Este procedimento ler os últimos 10 bytes do arquivo index.html

  Const Size = 10;
  Var
    err  : TObjectss.integer;
    h    : TObjectss.THandle;
    NRec,
    Count : TObjectss.Int64;
    s     : String[255];
    BytesLidos: Int64;
Begin
  with TObjectss do
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
                 Then ShowMessage(TStrError.ErrorMessage(err))
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
           else ShowMessage(TStrError.ErrorMessage(err));
           FileClose(h);
         end
    else ShowMessage(TStrError.ErrorMessage(err));
  end;
end;

procedure TForm1.Action_Test_FileWriteExecute(Sender: TObject);

  // Este procedimento adiciona a sequência '-0123456789-0123456789'+LF no fim do arquivo index.html

  Var
    Size : byte = 255;
    err  : TObjectss.integer;
    h    : TObjectss.THandle;
    NRec, Count : TObjectss.Int64;
    s     : String[255];
    BytesLidos,BytesWrites: Int64;
Begin
  with TObjectss do
  begin
    s :=  '-0123456789-0123456789'+LF;;
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
                           Then ShowMessage(TStrError.ErrorMessage(err))
                           else ShowMessage('Número de bytes escritos diferente de: '+IntToStr(length(s)));
                         end;
                  end
                  else ShowMessage(TStrError.ErrorMessage(err))   ;

           end
           else ShowMessage(TStrError.ErrorMessage(err));
           FileClose(h);
    end
    else ShowMessage(TStrError.ErrorMessage(err));
  end;
end;



//---------------------------------------------------------------------------------------
{$REGION ' TBufferMemory exemplo'}

  {: A procedure @name demonstra o uso da classe  **TObjectss.TBufferStream** quando o registro 0 (zero) do buffer
   é igual aos registros 1 a eof;
  }
    procedure TForm1.Test_TBufferMemory_sem_header;
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

  procedure TForm1.Action_test_TBufferMemory_Sem_HeaderExecute(Sender: TObject);
  begin
    Test_TBufferMemory_sem_header;
  end;



  {: A procedure @name demonstra o uso da classe  **TObjectss.TBufferStream** quando o registro 0 (zero) do buffer
     é diferente dos registros 1 a eof;
  }
    procedure TForm1.Test_TBufferMemory_com_header;
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
            then SysMessageBox(TStrError.errorMessage(errorInfo)
                               ,
                               'Test_FileStream_sem_header',false)

          end;
        end;

        if status <> StOk
        then SysMessageBox(TStrError.errorMessage(errorInfo)
                           ,
                           'Test_FileStream_sem_header',false)

      end;

    finally
      TBufferMemory_Alunos.Destroy;
    end;

  end;


  procedure TForm1.Action_test_TBufferMemory_Com_HeaderExecute(  Sender: TObject);
  begin
    Test_TBufferMemory_com_header;
  end;


{$ENDREGION ' TBufferMemory exemplo'}
//---------------------------------------------------------------------------------------


//---------------------------------------------------------------------------------------
{$REGION ' TFileStream exemplo'}

{: A procedure @name demonstra o uso da classe  **TObjectss.TFileStream** quando o registro 0 (zero) do arquivo
   é igual aos registros 1 a eof;
}
    procedure TForm1.Test_FileStream_sem_header;
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
                   SysMessageBox('Nr ='+intToStr(nr)+    '; id ='+intToStr(aluno.id)+'; Aluno ='+aluno.nome
                                 ,'Test_FileStream_sem_header'
                                 ,false);

                 end
            else break;
          end;
        end;//if
      end; //with

      with FileStream_Alunos do
        if status <> StOk
        then SysMessageBox(TStrError.ErrorMessage(ErrorInfo),'Test_FileStream_sem_header',true);

    finally
      FileStream_Alunos.Destroy;
    end;

  end;

  procedure TForm1.Action_Test_FileStream_sem_headerExecute(Sender: TObject    );
  begin
    Test_FileStream_sem_header;
  end;


  {: A procedure @name demonstra o uso da classe  **TObjectss.TFileStream** quando o registro 0 (zero) do arquivo
     é diferente dos registros 1 a eof;
  }
  procedure TForm1.Test_FileStream_com_header;
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
      FileStream_Alunos : TObjectss.TFileStream;
      aluno     : TAluno;//Registro de aluno
      headAluno : THeadAlunos;

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

        //Adicionar o registro 1;
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
        then SysMessageBox(TStrError.ErrorMessage(ErrorInfo),'Test_FileStream_sem_header',true);

    finally
      FileStream_Alunos.Destroy;
    end;

  end;


  procedure TForm1.Action_Test_FileStream_com_headerExecute(Sender: TObject );
  begin
    Test_FileStream_com_header;
  end;


  procedure TForm1.Test_tobjects_dlgs_Confirm;
  begin
    with TObjectss do
      if Confirm('Test_tobjects_Confirm','Continua com a ação?')
      then Alert('Test_tobjects_Confirm','Confirmado a ação!')
      else Alert('Test_tobjects_Confirm','Não confirmado a ação!');
  end;


procedure TForm1.Action_Test_tobjects_dlgs_ConfirmExecute(Sender: TObject);
begin
  Test_tobjects_dlgs_Confirm;
end;



procedure TForm1.Test_tobjects_dlgs_Prompt;
  var idade : Variant;
      id : byte;
      fmt : string;
begin
  idade := 0;
  with TObjectss do
  begin
    id := 64;
    idade := id;
    if Prompt('Test de Dlgs.Prompt','Qual a sua idade',idade)
    then begin
           fmt := format('Idade digitada: %s   '+^M+
                         'Idade de meu pai é %d ',[idade,102]);
           ShowMessage(fmt) ;
         end
    else  ShowMessage('Ok. Respeito sua privacidade.');
  end;
end;

{procedure TForm1.Test_Mi_MsgBox_inputBox;
  var idade,fmt : string;
begin
  idade := '';
  with TObjectss,MI_MsgBox do
  begin
    alert('Teste do Alerta','Este é um exemplo da procedure Alert');
    if InputBox('Test de Dlgs.Prompt','Qual a sua idade',idade,'BB') = MrOk
    then begin
           fmt := format('Idade digitada: %s   '+^M+
                         'Idade de meu pai é %d ',[idade,102]);
           ShowMessage('Test de Dlgs.Prompt') ;
         end
    else  ShowMessage('Ok. Respeito sua privacidade.');
  end;
end;
}
procedure TForm1.Action_Test_Mi_MsgBox_PromptExecute(Sender: TObject  );
begin
  Test_tobjects_dlgs_Prompt;
end;



procedure TForm1.Test_tobjects_dlgs_password;
  Var
    s : string;
begin
  s := '';
  with TObjectss do
    if InputPassword('Password',s)
    then Alert('Password','A senha digitada é: '+S)
    else Alert('Password','Senha não informada');

end;
procedure TForm1.Action_Test_tobjects_dlgs_passwordExecute(  Sender: TObject);
begin
  Test_tobjects_dlgs_password;
end;



procedure ShowMessageEx(const AMessage: string);
  //Site com forntes para baixar: https://br.maisfontes.com/menu/c
var
  LForm: TForm;
begin
  LForm := CreateMessageDialog(AMessage, mtCustom, [mbOK]);
  try
    with TLabel.Create(LForm) do begin
      LForm.Caption := 'Alerta';
      Font.Name := 'Courier New';
      if Font.Name <> 'Courier New'
      then Font.Name := 'DejaVu Sans Mono';

      ParentColor := True;
      AutoSize := False;
      //Alignment := taCenter;
      Layout := tlCenter;
      WordWrap := True;
      SetBounds(0, 0, LForm.Width, (LForm.Components[0] as TControl).Top);
      Caption := AMessage;
      Parent := LForm;
    end;
    LForm.ShowModal;
  finally
    FreeAndNil(LForm);
  end;
end;

//procedure Alert(aTitle, AMessage: string);
function CreateMessageDialog( aCaption, aMsg: string; DlgType: TMsgDlgType;  Buttons: TMsgDlgButtons): integer; overload;
  var
    pos1,pos2 : integer;
    LForm: TForm;
    M: string;
    h : string;
    l: Tlabel;
    b : Tbutton;
    atop:integer;
begin
  try
    m := aMsg;
    while (pos(^c,m)<> 0) do
    begin
      delete(m,pos(^c,m),1);
    end;

    Lform := Tform.Create(nil);
    { Calcula h = Texto entre ^C.
      Ex: Formato de entrada: ^C texto ^C ^M
    }
    pos1 := pos(^C,aMsg);
    if pos1 <> 0 then
    begin //Pega o texto que deve ficar no centro.
      pos2 := pos(^C,copy(aMsg,pos1+1,length(aMsg)));
      if pos2 <> 0 then
      begin
        h := copy(aMsg,pos1+1,pos2-pos1);
        delete(aMsg,pos1,pos2-pos1);
        //Delete o ^M
        pos1 := pos(^M,aMsg);
        if  pos1 <> 0
        then delete(aMsg,1,pos1);
      end;
    end;

    with Lform do
    begin
      AutoScroll:= true;
      Caption := aCaption;
      Position:= poScreenCenter;
//      AutoSize:= true;
      SetBounds(0, 0, 300, 300);
      Font.Name := 'Courier New';
      if Font.Name <> 'Courier New'
      then Font.Name := 'DejaVu Sans Mono';
    end;

    aTop := 0;
    L := TLabel.Create(Lform);
    Lform.InsertControl(L);
    // Criar o Label do cabeçalho
    with L do begin
      Caption := h;
      SetBounds(0, aTop, 280, 20);
      Alignment := TaCenter;
    end;

    //L := TLabel.Create(Lform);
    //Lform.InsertControl(L);
    //with L do begin
    //  aTop := atop+20;
    //  Caption := 'INFORMAÇÕES TÉCNICAS:';
    //  SetBounds(0,aTop, 280, 20);
    //end;
    //
    //L := TLabel.Create(Lform);
    //Lform.InsertControl(L);
    //with L do begin
    //  aTop := atop+20;
    //  Caption := '  Unit....: mi,rtl.tests';
    //  SetBounds(0,aTop, 280, 20);
    //end;
    //
    //L := TLabel.Create(Lform);
    //Lform.InsertControl(L);
    //with L do begin
    //  aTop := atop+20;
    //  Caption := '  Método..: test_TStrError';
    //  SetBounds(0,aTop, 280, 20);
    //end;
    //
    //L := TLabel.Create(Lform);
    //Lform.InsertControl(L);
    //with L do begin
    //  aTop := atop+20;
    //  Caption := '  Unit....: mi,rtl.tests';
    //  SetBounds(0,aTop, 280, 20);
    //end;
    //
    //L := TLabel.Create(Lform);
    //Lform.InsertControl(L);
    //with L do begin
    //  aTop := atop+20;
    //  Caption := '  Método..: test_TStrError';
    //  SetBounds(0,aTop, 280, 20);
    //end;
    //
    //L := TLabel.Create(Lform);
    //Lform.InsertControl(L);
    //with L do begin
    //  aTop := atop+20;
    //  Caption := '  Unit....: mi,rtl.tests';
    //  SetBounds(0,aTop, 280, 20);
    //end;
    //
    //L := TLabel.Create(Lform);
    //Lform.InsertControl(L);
    //with L do begin
    //  aTop := atop+20;
    //  Caption := '  Método..: test_TStrError';
    //  SetBounds(0,aTop, 280, 20);
    //end;
    //
    //
    //L := TLabel.Create(Lform);
    //Lform.InsertControl(L);
    //with L do begin
    //  aTop := atop+20;
    //  Caption := 'INFORMAÇÕES TÉCNICAS:';
    //  SetBounds(0,aTop, 280, 20);
    //end;
    //
    //L := TLabel.Create(Lform);
    //Lform.InsertControl(L);
    //with L do begin
    //  aTop := atop+20;
    //  Caption := '  Unit....: mi,rtl.tests';
    //  SetBounds(0,aTop, 280, 20);
    //end;
    //
    //L := TLabel.Create(Lform);
    //Lform.InsertControl(L);
    //with L do begin
    //  aTop := atop+20;
    //  Caption := '  Método..: test_TStrError';
    //  SetBounds(0,aTop, 280, 20);
    //end;
    //
    //L := TLabel.Create(Lform);
    //Lform.InsertControl(L);
    //with L do begin
    //  aTop := atop+20;
    //  Caption := '  Unit....: mi,rtl.tests';
    //  SetBounds(0,aTop, 280, 20);
    //end;
    //
    //L := TLabel.Create(Lform);
    //Lform.InsertControl(L);
    //with L do begin
    //  aTop := atop+20;
    //  Caption := '  Método..: test_TStrError';
    //  SetBounds(0,aTop, 280, 20);
    //end;
    //
    //L := TLabel.Create(Lform);
    //Lform.InsertControl(L);
    //with L do begin
    //  aTop := atop+20;
    //  Caption := '  Unit....: mi,rtl.tests';
    //  SetBounds(0,aTop, 280, 20);
    //end;
    //
    //L := TLabel.Create(Lform);
    //Lform.InsertControl(L);
    //with L do begin
    //  aTop := atop+20;
    //  Caption := '  Método..: test_TStrError';
    //  SetBounds(0,aTop, 280, 20);
    //end;
    //
    //
    //
    //B := TButton.Create(LForm);
    //Lform.InsertControl(B);
    //with B do begin
    //  aTop := atop+20;
    //  Caption := 'OK';
    //  ModalResult := MrOk;
    //
    //  SetBounds(10,aTop, 30, 20);
    //end;
    //


    if LForm <> nil
    then result := LForm.ShowModal
    else Result := -1;

  finally
    FreeAndNil(LForm);
  end;

end;


procedure TForm1.Action_test_CreateMessageDialogExecute(Sender: TObject);
begin


  if CreateMessageDialog('Exemplo do createMessageDialog', ^C+'Erro : Arquivo não encontrado'+^C+^M+
                                                           'INFORMAÇÕES TÉCNICAS:'+^M+
                                                           '  Unit....: unit1'+^M+
                                                           '  Método..: test_TStrError'+^M+
                                                           ' ',
                                                            mtCustom, [mbOK]) = mrOk
  then ShowMessage('Ok Pressionado');

{
LOCALIZAÇÃO:
  Unit....: unit1
  Classe..: TForm1
  Método..: Action_test_TStrErrorExecute
  Arquivo.: Exemplo.txt
  Campo...: nome
}




  //Alert('CreateMessageDialog',TObjectss.TStrError.ErrorMessage('mi.rtl','unit1','TStrErrorExecute','',211));
  with TObjectss do
  begin
//    ShowMessageEx(TStrError.ErrorMessage('Teste Mi.UI','unit1','Action_test_TStrErrorExecute',211));
//    SysMessageBox(TStrError.ErrorMessage('Teste Mi.UI','unit1','Action_test_TStrErrorExecute',211),'Test_FileStream_sem_header',true);

  end;
end;




{$ENDREGION ' TFileStream exemplo'}
//---------------------------------------------------------------------------------------

{$IFDEF linux}
procedure dotest;

var i : longint;
    prefix : Ansistring;

begin
  i:=GetProcessID;
  prefix:=format('testlog[%d] ',[i]);
  // prefix will be prepended to every message now.
  openlog(pchar(prefix),LOG_NOWAIT,LOG_DEBUG);
  for i:=1 to 10 do
    syslog(log_info,'Mensagem pp número%d'#10,[i]);
  prefix:='';
  closelog;
  showMessage('ok');
end;

{$ENDIF}

procedure TForm1.Action_Test_systemlogExecute(Sender: TObject);
begin
  //dotest;
//    testMultiLog;
  FileLog := TEventLog.Create(nil);
  with TObjectss,FileLog do
  begin
    LogType:= ltFile;
    AppendContent := true;
    RaiseExceptionOnError := true;
    FileName:= './test2.log';
    Active:= true;
    log('Conectado: Paulo' );
    Error('Error: %d'+lf+' este texto deve sta na próxima linha',[10] );
    Info('informação NÚMERO %d',[15]);
    Warning('Observe que o número %d não é válido',[15]);
    Debug('Passo %d é válido',[1]);
    Active:= false;
  end;
  FileLog.Destroy;
end;


procedure TForm1.Action_test_Logs_WarningExecute(Sender: TObject);
begin
  with TObjectss do
    if Logs.Active then
    with Logs do
    begin
      Warning('Pouco espaço em disco. Tamanho livre = %s.', ['1GB']);
      Warning('Senha inválida');
    end;
end;

procedure TForm1.Action_test_Logs_ErrorExecute(Sender: TObject);
begin
  with TObjectss do
    if Logs.Active then
    begin
      with Logs do
      begin
        Error('Exemplo de mensagem de erro. Número do erro = %d.', [5]);
        Error('Acesso ao arquivo negado.' );
      end;
    end;
end;


procedure TForm1.Action_Test_Logs_InfoExecute(Sender: TObject);
 var Message : string;
 var wMethodName : string;
// var aForm : TObjectss.PSItem;
begin
  wMethodName := MethodName(Self);


  with TObjectss do
    if Logs.Active then
    with Logs do
    begin
//      Info('A versão %s será lançada em breve.', ['Beta 3.5']);
      //info('Sistema abortou de forma inesperada.' );
      Message := Format(lf+
           'GetNamePath = %s ;'+lf+
           'ClassName = %s ;'+lf+
           'UnitName = %s ;'+lf+
           'ToString = %s ;'+lf+
           'QualifiedClassName = %s ;'+lf+
           'MethodName = %s ;'+lf   //O MethodName só funciona para métodos published.
           ,[GetNamePath,ClassName,UnitName,ToString,QualifiedClassName,wMethodName]);

//      aForm := StringToSItem(Message,255,Alinhamento_Esquerda);

      info(Message);
      SysMessageBox(Message,'Action_Test_Logs_InfoExecute',false);
    end;
end;


procedure TForm1.Action_test_LogErrorExecute(Sender: TObject);
begin
  with TObjectss do begin
     LogError('Exemplo de mensagem de erro. Número do erro = %d.', [5]);
     Logs.EnableWriteIdentificao := true;
     LogError('Acesso ao arquivo negado.' );
     Logs.EnableWriteIdentificao := False;


  end;
end;
procedure TForm1.Action_test_TExceptionExecute(Sender: TObject);
begin
  with TObjectss do begin
    logs.EnableWriteIdentificao := true;
    try
      raise TException.Create(5);
    except
    end;

    try
      raise TException.Create('Acesso ao arquivo negado');
    except
    end;

    try
      raise TException.Create(Self, 'Action_test_TExceptionExecute','aFileName','AFieldName',5);
    except
    end;

    try
      raise TException.Create(Self, 'Action_test_TExceptionExecute','aFileName','AFieldName','Acesso ao arquivo negado');
    except
    end;


    try
      raise TException.Create(Self, 'Action_test_TExceptionExecute',5);
    except
    end;

    try
      raise TException.Create(Self, 'Action_test_TExceptionExecute','Acesso ao arquivo negado');
    except
    end;


// Os exemplos abaixo são mantidos para manter a compatibilidade com o passado.


     try
       raise TException.Create4('aModule', 'aUnit', 'Procedure_or_Function',   'ParamResult');
     except
     end;

     try
       raise TException.Create4('aModule', 'aUnit', 'Procedure_or_Function',   5);
     except
     end;

     try
       raise TException.Create5('aModule', 'aUnit','ObjectName', 'aMethodName',   'aMsgError');
     except
     end;

     try
       raise TException.Create5('aModule', 'aUnit','ObjectName', 'aMethodName',   5);
     except
     end;

     try
       raise TException.Create6('aModule', 'ObjectName', 'aMethodName','aFileName','AFieldName', 5);
     except
     end;

     try
       raise TException.Create7('aModule', 'aUnit','ObjectName', 'aMethodName','aFileName','AFieldName',  5);
     except
     end;

     try
       raise TException.Create7('aModule', 'aUnit','ObjectName', 'aMethodName','aFileName','AFieldName',  'ParamResult');
     except
     end;

     try
       raise TException.Create8('aModule', 'aUnit','ObjectName', 'aMethodName','aFileName','AFieldName',  'aMessage','aProcedure_or_Function');
     except
     end;
   end;
end;


//Node js
//var fs = require("fs");
//var path = require("path");
//function walk(dir, out done) : TStringList;
//begin
//  //var results = [];
//  ListFiles := TStringList.Create;
//
//  fs.readdir(dir, function (err, list) {
//    if (err) return done(err);
//    var i = 0;
//    (function next() {
//      var file = list[i++];
//      if (!file) return done(null, results);
//      file = path.resolve(dir, file);
//      fs.stat(file, function (err, stat) {
//        if (stat && stat.isDirectory()) {
//          walk(file, function (err, res) {
//            results = results.concat(res);
//            next();
//          });
//        } else {
//          results.push(file);
//          next();
//        }
//      });
//    })();
//  });
//};
//
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

  var
    aext : String;
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
  begin
// Retorna somente os arquivos da pasta
 //FindFiles(Edit1.Text,FileAttrs ,ListFiles );

// Retorna todos os arquivos da pasta e subpastas
   aExt := ExtractFileName(Edit1.Text);
   if aExt = ''
   Then aExt := '*';


   if Confirm('Confirma?'
              ,'O método TObjectss.FindFilesAll pode demorar se o resultado for mais de 200 arguivos?')
   Then FindFilesAll(ExtractFileDir(Edit1.Text),aExt,FileAttrs,true ,ListFiles );

  end;

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

procedure TForm1.Edit1Change(Sender: TObject);
begin
  //Action_test_FindFirstExecute(Self);
end;


procedure TForm1.CheckBox_faAnyFileChange(Sender: TObject);
begin
  //Action_test_FindFirstExecute(Self);
end;

procedure TForm1.CheckBox_faArchiveChange(Sender: TObject);
begin
  //Action_test_FindFirstExecute(Self);
end;

procedure TForm1.CheckBox_faDirectoryChange(Sender: TObject);
begin
  //Action_test_FindFirstExecute(Self);
end;

procedure TForm1.CheckBox_faHiddenChange(Sender: TObject);
begin
  //Action_test_FindFirstExecute(Self);
end;

procedure TForm1.CheckBox_faReadOnlyChange(Sender: TObject);
begin
  //Action_test_FindFirstExecute(Self);
end;

procedure TForm1.CheckBox_faSymLinkChange(Sender: TObject);
begin
  //Action_test_FindFirstExecute(Self);
end;

procedure TForm1.CheckBox_faSysFileChange(Sender: TObject);
begin
  //Action_test_FindFirstExecute(Self);
end;


procedure TForm1.TabSheet_TfilesStreamsEnter(Sender: TObject);
  var
   i,L : integer;
   s:AnsiString;
   aFileSizes : int64;

begin
  filesStreams.DeleteAll;
  StringGrid1.Clear;

  filesStreams.Mask := edit2.Text;
  StringGrid1.RowCount := filesStreams.Count+1;

  NumeroDeArquivo.Text := Format('%d',[filesStreams.Count]);
  NumeroDeArquivo.Show;

  if filesStreams.FileSizes(edit2.Text,aFileSizes) = 0
  then Edit_FileSizes.text := Format('%d',[aFileSizes])
  else Edit_FileSizes.text := '0';

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

procedure TForm1.Edit2Change(Sender: TObject);
begin
  TabSheet_TfilesStreamsEnter(Self);
end;

procedure TForm1.Action_test_TfilesStreamsExecute(Sender: TObject);
begin
  TabSheet_TfilesStreamsEnter(Self);
end;


{: A procedure **@name** é usada para converter caractere acima de 127 para caractere equivalente abaixo de 127.

   - **EXEMPLO**
     - ç = c;
     - ã = a;
     - é = e;
     - etc...
}
procedure TForm1.Test_String_Asc_GUI_to_Asc_html;
  var
    s1: AnsiString ;
begin
  s1 := TObjectss.String_Asc_Gui_to_Asc_HTML('Sérgio ação');
  showmessageFMT('S1 = %s  |  Len(s1) = %d CodPage =  %d ',[s1,Length(s1),StringCodePage(s1)]);
end;

procedure TForm1.Action_Test_String_Asc_GUI_to_Asc_htmlExecute(  Sender: TObject);
begin
  Test_String_Asc_GUI_to_Asc_html;
end;


{: A procedure **@name** é usada para converter caractere acima de 127 para caractere equivalente em HTML.

   - **EXEMPLO**
     - ç = '&ccedil;'
     - ã = '&atilde;';
     - é = '&eacute;';
     - etc...
}
procedure TForm1.Test_String_Asc_GUI_to_Asc_Ingles;
  var
    s1: AnsiString ;
begin
  s1 := TObjectss.String_Asc_Gui_to_Asc_Ingles('Sérgio ação');
  showmessageFMT('S1 = %s  |  Len(s1) = %d CodPage =  %d ',[s1,Length(s1),StringCodePage(s1)]);
end;

procedure TForm1.Action_Test_String_Asc_GUI_to_Asc_InglesExecute(  Sender: TObject);
begin
  Test_String_Asc_GUI_to_Asc_Ingles;
end;

procedure TForm1.test_removeAccents;
  var
    s1: AnsiString ;
begin
  s1 := TObjectss.removeAccents('Sérgio ação');
  showmessageFMT('S1 = %s  |  Len(s1) = %d CodPage =  %d ',[s1,Length(s1),StringCodePage(s1)]);
end;

procedure TForm1.Action_test_removeAccentsExecute(Sender: TObject);

begin
  test_removeAccents;
end;


procedure TForm1.Action_Test_TMi_Msgbox_LCLExecute(Sender: TObject);
begin
  TObjectss.MI_MsgBox.ShowMessage('A classe MI_MsgBox iniciado em TForm1.FormCreate() ');
end;


procedure TForm1.Action_test_TTb__Access_CadastraExecute(Sender: TObject);
begin
  TAluno.Cadastra;
  ShowMessage('Comando TAluno.Cadastro; executado.');
end;

procedure TForm1.Button2_FindFirstClick(Sender: TObject);
begin
  Action_test_FindFirstExecute(Self);
end;

procedure TForm1.Action_Test_TTb_access_Lista_ordem_crescenteExecute(  Sender: TObject);
begin
  TAluno.Lista_ordem_crescente;
end;

procedure TForm1.Action_Test_TTb_access_Lista_ordem_decrescenteExecute( Sender: TObject);
begin
  TAluno.Lista_ordem_Decrescente;
end;

procedure TForm1.Action_test_TTb_access_DeleteRecExecute(Sender: TObject  );
begin
  TAluno.DeleteRec;
end;

procedure TForm1.Action_Test_TTb_access_SetTransactionExecute(Sender: TObject);
begin
  TAluno.Test_SetTransaction;
end;



procedure TForm1.Action_Test_MessageErrorExecute(Sender: TObject);
begin
  with TObjectss do
  begin
    ErrorInfo := 2;
    Push_MsgErro(TStrError.ErrorMessage(ErrorInfo));

    ErrorInfo := 10;
    Push_MsgErro(TStrError.ErrorMessage(ErrorInfo));
    TObjectss.MessageError;
  end;
end;

procedure test_GetTempDir;
  var
    path,FileName : TObjectss.PathStr;
begin
  with TObjectss do
  begin
    path := GetTempDir();
    if TaStatus = 0
    then showMessage(path)
    else ShowMessage(TStrError.ErrorMessage(TaStatus));


    if GetTempDir('HOME',path) = 0
    then showMessage(path)
    else ShowMessage(TStrError.ErrorMessage(TaStatus));

    FileName := GetTempFileName (path);
    if FileName <> ''
    then ShowMessage(FileName)
    else ShowMessage(TStrError.ErrorMessage(TaStatus));

  end;
end;

procedure TForm1.Action_test_GetTempDirExecute(Sender: TObject);
begin
  test_GetTempDir;
end;

procedure TForm1.Action_sobreExecute(Sender: TObject);
begin
  with TObjectss do  begin
    ShowMessageEx('Sobre: Programa de teste do pacote mi.rtl. Versão: '+
                  AppVersionInfo.VersionStr);


    //ShowMessageEx('Sobre: Programa de teste do pacote mi.rtl. Versão: '+
    //              AppVersionInfo.VersionStrEx[C_DEF_VER_FORMAT3]);
    //ShowMessageEx('Sobre: Programa de teste do pacote mi.rtl. Versão: '+
    //              AppVersionInfo.MajorAsStr + '.'+AppVersionInfo.MinorAsStr+'.'+AppVersionInfo.RevisionAsStr+ '.'+AppVersionInfo.BuildNoAsStr);
    //

  end;
end;

procedure TForm1.Action_test1_pageProducerExecute(Sender: TObject);
begin
  try
   Form_pageproducer_test1 := TForm_pageproducer_test.Create(self);
   Form_pageproducer_test1.ShowModal;

  finally
    Freeandnil(Form_pageproducer_test1);
  end;
end;




initialization
{ garantir que tenhamos problemas se em um ponto; a página de código do sistema padrão for usada}
SetMultiByteConversionCodePage(CP_OEMCP);

{ este teste só funciona em sua forma atual em sistemas que usam uma API de sistema de arquivos de dois bytes ou cuja API de 1 byte suporta UTF-8}
SetMultiByteFileSystemCodePage(CP_OEMCP);
SetMultiByteRTLFileSystemCodePage(CP_OEMCP);


end.



