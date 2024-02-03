unit mi.rtl.Objects.Methods.Paramexecucao;

{$IFDEF FPC}
  {$mode Delphi}
{$ENDIF}

interface


uses
  Classes, SysUtils,dos,
  mi.rtl.objects.Methods,
  mi.rtl.objects.Methods.Exception,
  mi.rtl.objects.Methods.dates;

    Type
      TParamExecucao = Class;
      TR_ParamExecucao_Local = record
                                 _ParamExecucao        : TParamExecucao;// = nil;
                                 _Destoy_ParamExecucao : Boolean;// = false;
                               end;

      TParamExecucao_types = Class (TObjectsMethods)

        public type TSet_NomeDeArquivosGenericos = Function(aParamExecucao: TParamExecucao) :boolean;
        public type TParamExecucao_Tipo_de_Execucao =
                      (TParamExecucao_Tipo_de_Execucao_Normal, {:< O sistema trabalha com menu da LCL}
                       TParamExecucao_Tipo_de_Execucao_Normal_Sem_Pedir_Password, {:< O sistema trabalha com menu da LCL}
                       TParamExecucao_Tipo_de_Execucao_Normal_Exec_Command,    {:< O sistema executa um comando depois de pedir a Password. Usado para execusão em lote }
                       TParamExecucao_Tipo_de_Execucao_VCL,     {:< O sistema trabalha com menu Grafico ???}
                       TParamExecucao_Tipo_de_Execucao_CGI,     {<O sistema trabalha com chamadas do Browse ???}
                       TParamExecucao_Tipo_de_Execucao_ISAPI);  {:< O Sistema trabalha como um serviço DLL ???}

        Public Type TNomeDeArquivosGenericos =
                      record
                        NomeArqExe : DirStr;
                        NomeArqDll            : DirStr;
                        DirExe                : DirStr;
                        DirDataBaseName_Template  : DirStr;
                        CGI_BIN               : DirStr;

                        DirPalette: DirStr;
                        Dir_Local_Ferr  : DirStr;

                        Name_Local_Ferr : DirStr;

                        Path_Schema   : DirStr;
                        Name_Schema   : DirStr;
                        Ext_Schema    : ExtStr;

                        Path_Import   : DirStr;
                        Path_Export   : DirStr;

                        OS            : DirStr;   //<  Sistema operacional
                        ComputerName  : DirStr;
                        LOGONSERVER   : DirStr;
                        SESSIONNAME   : DirStr;
                        USERDOMAIN    : DirStr;
                        USERNAME      : DirStr;
                        USERPROFILE   : DirStr;
                        ALLUSERSPROFILE: DirStr;
                        ProgramFiles: DirStr;
                        CommonProgramFiles : DirStr;
                        HOMEDRIVE          : DirStr;
                        HOMEPATH           : DirStr;
                        SystemDrive        : DirStr;
                        SystemRoot         : DirStr;
                        windir             : AnsiString;
                        DirHTML_Template   : DirStr;
                        DirHTML_imagens    : DirStr;
                        DirHTML_FileName_JPG_Program_Logomarca : String;// = 'Z:\Tv32\GCIC\GCIC_EC\GCIC_VCL_EC\images\logo.jpg';
                        DirHTML_Template_Default: DirStr;
                        DirHTML_Template_Custom : DirStr;
                        DirHTML_Temp            : DirStr; //Pasta temporária dos relatorios gerados dinamicamente.
                        DirHTML                 : DirStr;
                        DirHTML_Doc_Program     : DirStr;

                        {$Region '--->Cosntrução da propriedade DirDoc <---'}

                            Private _DirDoc: DirStr;    //Usado para concentrar todos os documentos do projeto
                            Private Procedure Set_DirDoc(a_DirDoc: DirStr);
                            Public Property DirDoc: DirStr Read _DirDoc Write Set_DirDoc;
                        {$EndRegion '--->Cosntrução da propriedade DirDoc <---'}

                        {$Region '--->Cosntrução da propriedade DirDataBaseName <---'}
                            Private _DirDataBaseName: DirStr;
                            Private Procedure Set_DirDataBaseName(a_DirDataBaseName: DirStr);
                            Public Property DirDataBaseName: DirStr Read _DirDataBaseName Write Set_DirDataBaseName;
                        {$EndRegion '--->Cosntrução da propriedade DirDataBaseName <---'}

                        {$Region '--->Cosntrução da propriedade DataBaseName <---'}
                            Private _DataBaseName: NameStr;
                            Private Procedure Set_DataBaseName(a_DataBaseName: NameStr);
                            Public Property DataBaseName: NameStr Read _DataBaseName Write Set_DataBaseName;
                        {$EndRegion '--->Cosntrução da propriedade DataBaseName <---'}

                        {$Region '--->Cosntrução da propriedade DirTemp <---'}
                            Private _DirTemp: DirStr;
                            private Function Get_DirTemp(): DirStr;
                            Public Property DirTemp: DirStr Read Get_DirTemp Write _DirTemp;
                        {$EndRegion '--->Cosntrução da propriedade DirTemp <---'}
                      End;

        Public type TIdentificacao = record
                       {Dados da matriz}
                       Diretor           : String[50];
                       Diretor_URL       : String[50];
                       Diretor_E_Mail    : String[50];
                       Diretor_Telefone  : String[50];

                       CPD                : String[50];
                       CPD_URL            : String[50];
                       CPD_E_Mail         : String[50];
                       CPD_Telefone       : String[50];

                       NumeroDeTerminais  : Byte;

                       RazaoSocial                 : String[60];
                       Endereco                    : String[60];

                       Bairro,
                       Cidade                      : String[50];
                       Estado                      : String[30];

                       Cep                         : string[10];
                       CNPJ                         : string[18];
                       InsEstadual                 : string[18];
                       PABX                        : string[50] ;

                     {Dados do usuario logado}
                       Filial          : Byte;
                       Usuario         : SmallInt;
                       UserName                 : String[25];
                       Nome_Compreto_do_Usuario : String[45];
                       Password                 : AnsiString; {< Password do usuario }
                    End;
        end;

        TParamExecucao_consts = Class (TParamExecucao_types)
          {:Usado para inicializar os paths da sessão.}
          Public var _Set_NomeDeArquivosGenericos : TSet_NomeDeArquivosGenericos;static;
          public Const  Set_NomeDeArquivosGenericos_Global : TSet_NomeDeArquivosGenericos = nil;
        end;

        TParamExecucao = Class (TParamExecucao_consts)
          protected Var okCreate:Boolean;
          public Constructor Create(aPathRaiz:Ansistring);overload;Virtual;
          public Constructor Create(aOwner:TComponent);overload;override;
          Destructor Destroy;override;

          private R_ParamExecucao_Local_ant : TR_ParamExecucao_Local;

          Public Function Set_NomeDeArquivosGenericos() :boolean;

          public NomeDeArquivosGenericos : TNomeDeArquivosGenericos;
          public PathRaiz  : AnsiString;
          public Tipo_de_Execucao : TParamExecucao_Tipo_de_Execucao;
          public Identificacao    : TIdentificacao;
          public
          public Command          : SmallInt;
          Public Modulo           : SmallInt;

          //Private
          { A variável Acao_Form é usada para em sele_next para disparar uma
            sequência de eventos do tipo comando depois qua a claasse é inicilizado

            Sintaxe
               EvCommand,Command1,..,CommandN,evKeyboard,String,

            Exemplo:
              Acao_Form := 'EvCommand,109,50010';
              Acao_Form := 'EvCommand,109,EvKeyBoard,Razao social,EvCommand,109,50010';
              Acao_Form := 'EvKeyBoard,'+^M+'Razao social';

            Caso Acao_Form Seja qualquer string abaixo então o mesmo não deve ser disparado e
            sim tratato de forma específica nas rotinas showModal de TWindows.showModal

            Function Acao_Form_Is_Event:Boolean;//< True se acao_form for um evento e False se for um mapa de bits
                Mb_Cm_Novo      =  Mb_Bit03; // Inicializar um novo registro para edição
                Mb_Cm_Edita     =  MB_Bit04; // Editar a linha corrente
                Mb_Cm_Alteracao =  Mb_Bit05; // Gravar as alterações
                Mb_Cm_Process   =  MB_Bit06; // Processar tabelas
                Mb_Cm_Exclusao  =  MB_Bit07; // Excluir
                Mb_Cm_Localiza  =  MB_Bit08; // Localizar
                Mb_Cm_FindRec   =  MB_Bit09; // Atualizar
                Mb_Cm_Visualizar=  MB_Bit10; // Visualizar
                Mb_Cm_Print     =  MB_Bit11; // Imprimir
                Mb_Cm_Ok        =  Mb_Bit12; // Ok
                Mb_Cm_Sair      =  MB_Bit13; // Sair
                Mb_Cm_Cancel    =  MB_Bit14; // Cancelar uma ação
                Mb_Cm_Bof       =  Mb_Bit15; // Vai para o inicio do arquivo
                Mb_Cm_Prev      =  Mb_Bit16; // Registro anterior
                Mb_Cm_Next      =  MB_Bit17; // Proximo registro
                Mb_Cm_Eof       =  MB_Bit18; // vai para o fin do arquivo
                mb_Cm_Locate    =  MB_Bit19; // Localizar
                mb_Cm_Find      =  MB_Bit20; // Localizar
                Mb_Cm_Bof
                Mb_Cm_Prev
                Mb_Cm_Next
                Mb_Cm_Eof
                mb_Cm_Find;

            }

          Public Acao_Form  : AnsiString;
          Public DataAtual : TDates.typeData;

//          HostName                 : String[253];

         {$REGION '---> Property HostName'}
            //  HostName : tString = 'http://www.gcic.com.br/Cgi-bin/';
            Private _HostName : AnsiString ;

            private Function Get_HostName: AnsiString;
            private Procedure SetDominioHost(aHostName : AnsiString);

            {: O campo **@name** contem o nome ou o ip do banco de dados

               - **REFERÊNCIA**
                 [nomes de host da Internet](https://networkencyclopedia.com/hostname/#:~:text=What%20is%20Hostname%3F,DNS%20server%20or%20hosts%20files.)
            }
            public property HostName : AnsiString Read Get_HostName Write SetDominioHost;

            private Function Set_HostName(aHostName : AnsiString): AnsiString;
         {$ENDREGION}


          public DatabaseNameCharSet: AnsiString;

          {DECLARAÇÃO DA LISTA DE CAMPOS COM VALORES PADRÃO PASSADO PARA AS TABELAS
          Sintaxe da lista         : Nome_do_Campo1="value_do_Campo1",Nome_do_Campo2="value_do_Campo2",..,Nome_do_CampoN="value_do_CampoN"
          Sintaxe de Nome_do_Campo : "Nome_da_Tabela.Nome_do_Campo"
          }
          public  List_Value_Default   : AnsiString;   //< ParamStr(10)

          Public Function Acao_Form_Is_Event:Boolean;//< True se acao_form for um evento e False se for um mapa de bits
          public Function Acao_Form_Is_Mb_Bit:Boolean;//< True se acao_form for um mapa de bits.

          public procedure Set_ParamStr(wFilial{1},WUsuario{2},wPassword{3}: tString);Overload;
          public procedure Set_ParamStr(wFilial{1}:Byte;WUsuario{2}:SmallInt;wPassword{3}:tString);Overload;
          public procedure Set_ParamStr(wFilial{1},WUsuario{2},wPassword{3},wCommand{4} : tString);Overload;
          public procedure Set_ParamStr(wFilial{1}:Byte;WUsuario{2}:SmallInt;wPassword{3}:tString;wCommand{4} : SmallInt);Overload;
          public procedure Set_ParamStr(wFilial{1}:Byte;WUsuario{2}:SmallInt;wNome_Compreto_do_Usuario{3} : tString;wPassword{4}:tString);Overload;
          public procedure Set_ParamStr(wFilial{1}:Byte;WUsuario{2}:SmallInt;wNome_Compreto_do_Usuario{3} : tString;wPassword{4}:tString;aUsername{5}: tString);Overload;

          public procedure Set_ParamStr(wFilial{1},WUsuario{2},wPassword{3},wModulo{4},wCommand{5} : tString);Overload;
          public procedure Set_ParamStr(wFilial{1},WUsuario{2},wPassword{3},wModulo{4},wCommand{5},a_DataAtual{6} : tString);Overload;
          public procedure Set_ParamStr(wFilial{1},WUsuario{2},wPassword{3},wModulo{4},wCommand{5},a_DataAtual{6} : tString;wAcao_Form{7}: AnsiString);Overload;

          public procedure Set_ParamStr(wFilial{1},WUsuario{2},wPassword{3},wModulo{4},wCommand{5},a_DataAtual{6} : tString;wAcao_Form{7}: AnsiString;wList_Value_Default{8}:AnsiString);Overload;

          public procedure Set_ParamStr(wFilial{1}:Byte;
                                 WUsuario{2}:SmallInt;
                                 wPassword{3}:tString;
                                 wModulo{4}:SmallInt;
                                 wCommand{5} : SmallInt);Overload;
          public procedure Set_ParamStr(wFilial{1}:AnsiString;
                                 WUsuario{2}:SmallInt;
                                 wPassword{3}:tString;
                                 wModulo{4}:SmallInt;
                                 wCommand{5} : SmallInt);Overload;
          public function Check_Se_Comando_autorizado:Boolean;


          Function Get_Password_do_Comando(aModulo: Byte; aComando : SmallInt):tString;

          public class Function Param_Execucao : TParamExecucao;
          PUBLIC class Procedure Set_ParamExecucao(aParamExecucao : TParamExecucao);
      End;



implementation



//procedure Register;
//begin
//  RegisterComponents(Name_Type_App_MarIcaraiV1, [TParamExecucao]);
//end;

Procedure TParamExecucao_types.TNomeDeArquivosGenericos.Set_DirDoc(a_DirDoc: DirStr);
Begin
  DirHTML_Template           := TObjectsMethods.ChangeSubStr(_DirDoc,a_DirDoc,DirHTML_Template);
  DirHTML_Template_Default   := TObjectsMethods.ChangeSubStr(_DirDoc,a_DirDoc,DirHTML_Template_Default);
  DirHTML_Template_Default   := TObjectsMethods.ChangeSubStr(_DirDoc,a_DirDoc,DirHTML_Template_Default);
  DirHTML_Template_Custom    := TObjectsMethods.ChangeSubStr(_DirDoc,a_DirDoc,DirHTML_Template_Custom);
  DirHTML                    := TObjectsMethods.ChangeSubStr(_DirDoc,a_DirDoc,DirHTML);
  DirHTML_Doc_Program	     := TObjectsMethods.ChangeSubStr(_DirDoc,a_DirDoc,DirHTML_Doc_Program);
  _DirDoc := a_DirDoc;
End;


Procedure TParamExecucao_types.TNomeDeArquivosGenericos.Set_DirDataBaseName(a_DirDataBaseName: DirStr);
begin
  if a_DirDataBaseName[length(a_DirDataBaseName)] <> PathDelim
  then a_DirDataBaseName := a_DirDataBaseName + PathDelim;


  _DirDataBaseName := FExpand(a_DirDataBaseName);

  Path_Schema := TObjectsMethods.ChangeSubStr(_DirDataBaseName,a_DirDataBaseName,Path_Schema);
  Path_Import := TObjectsMethods.ChangeSubStr(_DirDataBaseName,a_DirDataBaseName,Path_Import);
  Path_Export := TObjectsMethods.ChangeSubStr(_DirDataBaseName,a_DirDataBaseName,Path_Export);
end;

Procedure TParamExecucao_types.TNomeDeArquivosGenericos.Set_DataBaseName(a_DataBaseName: NameStr);
Begin
  if a_DataBaseName = ''
  then _DataBaseName := ExtractFileName(Self.NomeArqExe) + '.tb'
  Else _DataBaseName := ExtractFileName(FExpand(a_DataBaseName));

  //Se o path não for informado então usar o path onde a tabela a_DataBaseName informar.
  if _DirDataBaseName = ''
  then _DirDataBaseName := ExtractFilePath(FExpand(a_DataBaseName));
End;

Function TParamExecucao_types.TNomeDeArquivosGenericos.Get_DirTemp(): DirStr;
Begin
  If _DirTemp = ''
  Then Begin
         If TObjectsMethods.GetTempDir('Temp',_DirTemp)=0
         Then Result := _DirTemp
         Else Result := '';
       end
  else Result := _DirTemp;

end;



{$REGION '---> Function Param_Execucao : TParamExecucao'}

//Const Param_Execucao : TParamExecucao = nil;
//threadvar
Var
  R_ParamExecucao_Local : TR_ParamExecucao_Local;

  class Function TParamExecucao.Param_Execucao : TParamExecucao;
  begin
    With R_ParamExecucao_Local do
    begin
      If _ParamExecucao = nil
      Then Begin
             _ParamExecucao        := TParamExecucao.create('');
             _Destoy_ParamExecucao := True;

             if @_ParamExecucao._Set_NomeDeArquivosGenericos<>nil
             Then begin
                    if _ParamExecucao.PathRaiz = ''
                    Then _ParamExecucao.PathRaiz := ParamStr(0);

                    _ParamExecucao.Set_NomeDeArquivosGenericos;
                  end;

           end;

      Result := _ParamExecucao ;
    End;
  end;

  class Procedure TParamExecucao.Set_ParamExecucao(aParamExecucao : TParamExecucao);
  Begin
    If R_ParamExecucao_Local._Destoy_ParamExecucao
    Then Begin
           Freeandnil(R_ParamExecucao_Local._ParamExecucao);
         End;

    R_ParamExecucao_Local._ParamExecucao        := aParamExecucao;
    R_ParamExecucao_Local._Destoy_ParamExecucao := False;
  end;


{$ENDREGION}


//==============================================================================================================
{$REGION '---> Implementação de  TParamExecucao '}
//==============================================================================================================
  {Procedure TParamExecucao.Set_Acao_Form(w_Acao_Form   : AnsiString);
  Begin
    Nao posso converter a acao em maiúscula por que os eventos pode serem strings minusculo.
    _Acao_Form := FMaiuscula(w_Acao_Form );
  end;       }

  Function TParamExecucao.Acao_Form_Is_Event:Boolean;//< True se acao_form for um evento.

      { A variável Acao_Form é usada para em sele_next para disparar uma
        sequência de eventos do tipo comando depois qua a claasse é inicilizado se Acao_Form_Is_Event = true

        Sintaxe
           EvCommand,Command1,..,CommandN,evKeyboard,tString,

        Exemplo:
          Acao_Form := 'EvCommand,109,50010';
          Acao_Form := 'EvCommand,109,EvKeyBoard,Razao social,EvCommand,109,50010';
          Acao_Form := 'EvKeyBoard,'+^M+'Razao social';

        Caso Acao_Form Seja qualquer tString abaixo então o mesmo não deve ser disparado e
        sim tratato de forma específica nas rotinas showModal de TWindows.showModal

            Mb_Cm_Novo      =  Mb_Bit03; // Inicializar um novo registro para edição
            Mb_Cm_Edita     =  MB_Bit04; // Editar a linha corrente
            Mb_Cm_Alteracao =  Mb_Bit05; // Gravar as alterações
            Mb_Cm_Process   =  MB_Bit06; // Processar tabelas
            Mb_Cm_Exclusao  =  MB_Bit07; // Excluir
            Mb_Cm_Localiza  =  MB_Bit08; // Localizar
            Mb_Cm_FindRec   =  MB_Bit09; // Atualizar
            Mb_Cm_Visualizar=  MB_Bit10; // Visualizar
            Mb_Cm_Print     =  MB_Bit11; // Imprimir
            Mb_Cm_Ok        =  Mb_Bit12; // Ok
            Mb_Cm_Sair      =  MB_Bit13; // Sair
            Mb_Cm_Cancel    =  MB_Bit14; // Cancelar uma ação
            Mb_Cm_Bof       =  Mb_Bit15; // Vai para o inicio do arquivo
            Mb_Cm_Prev      =  Mb_Bit16; // Registro anterior
            Mb_Cm_Next      =  MB_Bit17; // Proximo registro
            Mb_Cm_Eof       =  MB_Bit18; // vai para o fin do arquivo
            mb_Cm_Locate    =  MB_Bit19; // Localizar
            mb_Cm_Find      =  MB_Bit20; // Localizar
            Mb_Cm_Bof
            Mb_Cm_Prev
            Mb_Cm_Next
            Mb_Cm_Eof
            mb_Cm_Find;
        }
     Var
       wAcao_form : AnsiString;
  Begin
    wAcao_form := FMaiuscula(Acao_form);
    If (Pos('EVCOMMAND',wAcao_form) <> 0) or
       (Pos('EVKEYBOARD',wAcao_form) <> 0)
    THEN RESULT := TRUE
    ELSE Result := False;
  end;


  Function TParamExecucao.Acao_Form_Is_Mb_Bit:Boolean;//< True se acao_form for um mapa de bits.

      { A variável Acao_Form é usada para em sele_next para disparar uma
        sequência de eventos do tipo comando depois qua a claasse é inicilizado se Acao_Form_Is_Event = true

        Sintaxe
           EvCommand,Command1,..,CommandN,evKeyboard,tString,

        Exemplo:
          Acao_Form := 'EvCommand,109,50010';
          Acao_Form := 'EvCommand,109,EvKeyBoard,Razao social,EvCommand,109,50010';
          Acao_Form := 'EvKeyBoard,'+^M+'Razao social';

        Caso Acao_Form Seja qualquer tString abaixo então o mesmo não deve ser disparado e
        sim tratato de forma específica nas rotinas showModal de TWindows.showModal

            Mb_Cm_Novo      =  Mb_Bit03; // Inicializar um novo registro para edição
            Mb_Cm_Edita     =  MB_Bit04; // Editar a linha corrente
            Mb_Cm_Alteracao =  Mb_Bit05; // Gravar as alterações
            Mb_Cm_Process   =  MB_Bit06; // Processar tabelas
            Mb_Cm_Exclusao  =  MB_Bit07; // Excluir
            Mb_Cm_Localiza  =  MB_Bit08; // Localizar
            Mb_Cm_FindRec   =  MB_Bit09; // Atualizar
            Mb_Cm_Visualizar=  MB_Bit10; // Visualizar
            Mb_Cm_Print     =  MB_Bit11; // Imprimir
            Mb_Cm_Ok        =  Mb_Bit12; // Ok
            Mb_Cm_Sair      =  MB_Bit13; // Sair
            Mb_Cm_Cancel    =  MB_Bit14; // Cancelar uma ação
            Mb_Cm_Bof       =  Mb_Bit15; // Vai para o inicio do arquivo
            Mb_Cm_Prev      =  Mb_Bit16; // Registro anterior
            Mb_Cm_Next      =  MB_Bit17; // Proximo registro
            Mb_Cm_Eof       =  MB_Bit18; // vai para o fin do arquivo
            mb_Cm_Locate    =  MB_Bit19; // Localizar
            mb_Cm_Find      =  MB_Bit20; // Localizar
            Mb_Cm_Bof
            Mb_Cm_Prev
            Mb_Cm_Next
            Mb_Cm_Eof
            mb_Cm_Find;
        }
     Var
       wAcao_form : AnsiString;
  Begin
    wAcao_form := FMaiuscula(Acao_form);

    {Deleta brancos a esquerda }
    While (wAcao_form[1] in [' ',#0] ) and (Length(wAcao_form)>0) do
      Delete(wAcao_form,1,1);

    {Deleta brancos a direita}
    While (wAcao_form[Length(wAcao_form)] in [' ',#0] ) and (Length(wAcao_form)>0)
    do Delete(wAcao_form,Length(wAcao_form),1);

    If ('MB_CM_NOVO'      = wAcao_form) or //     Mb_Cm_Novo      =  Mb_Bit03; // Inicializar um novo registro para edição
       ('MB_CM_EDITA'     = wAcao_form) or //     Mb_Cm_Edita     =  MB_Bit04; // Editar a linha corrente
       ('MB_CM_ALTERACAO' = wAcao_form) or //     Mb_Cm_Alteracao =  Mb_Bit05; // Gravar as alterações
       ('MB_CM_PROCESS'   = wAcao_form) or //     Mb_Cm_Process   =  MB_Bit06; // Processar tabelas
       ('MB_CM_EXCLUSAO'  = wAcao_form) or //     Mb_Cm_Exclusao  =  MB_Bit07; // Excluir
       ('MB_CM_LOCALIZA'  = wAcao_form) or //     Mb_Cm_Localiza  =  MB_Bit08; // Localizar
       ('MB_CM_FINDREC'   = wAcao_form) or //     Mb_Cm_FindRec   =  MB_Bit09; // Atualizar
       ('MB_CM_VISUALIZAR'= wAcao_form) or //     Mb_Cm_Visualizar=  MB_Bit10; // Visualizar
       ('MB_CM_PRINT'     = wAcao_form) or //     Mb_Cm_Print     =  MB_Bit11; // Imprimir
       ('MB_CM_OK'        = wAcao_form) or //     Mb_Cm_Ok        =  Mb_Bit12; // Ok
       ('MB_CM_SAIR'      = wAcao_form) or //     Mb_Cm_Sair      =  MB_Bit13; // Sair
       ('MB_CM_CANCEL'    = wAcao_form) or //     Mb_Cm_Cancel    =  MB_Bit14; // Cancelar uma ação
       ('MB_CM_BOF'       = wAcao_form) or //     Mb_Cm_Bof       =  Mb_Bit15; // Vai para o inicio do arquivo
       ('MB_CM_PREV'      = wAcao_form) or //     Mb_Cm_Prev      =  Mb_Bit16; // Registro anterior
       ('MB_CM_NEXT'      = wAcao_form) or //     Mb_Cm_Next      =  MB_Bit17; // Proximo registro
       ('MB_CM_EOF'       = wAcao_form) or //     Mb_Cm_Eof       =  MB_Bit18; // vai para o fin do arquivo
       ('MB_CM_LOCATE'    = wAcao_form) or //     mb_Cm_Locate    =  MB_Bit19; // Localizar
       ('MB_CM_FIND'      = wAcao_form)    //     mb_Cm_Find      =  MB_Bit20; // Localizar
    THEN RESULT := TRUE
    ELSE Result := False;
  end;


  Procedure TParamExecucao.Set_ParamStr(wFilial,WUsuario,wPassword : tString);
  Begin
    try
      Identificacao.filial := StrToInt(WFilial)
    Except
      Identificacao.filial := 1;
    end;

    try
      Identificacao.Usuario := StrToInt(WUsuario)
    Except
      Identificacao.filial := 1;
    end;

    Identificacao.Password := wPassword;
  end;

  Procedure TParamExecucao.Set_ParamStr(wFilial,WUsuario,wPassword,wCommand : tString);
    Var
      Err : Integer;
  Begin
    Set_ParamStr(wFilial,WUsuario,wPassword);

    try
      Command := StrToInt(wCommand);
    Except
      Command := 0;
      // wcomando deve ser uma lista de eventos do tipo: EvCommand,141,EvCommand,50045,EvCommand,4428
    end;
  end;


  Procedure TParamExecucao.Set_ParamStr(wFilial:Byte;WUsuario:SmallInt;wNome_Compreto_do_Usuario : tString;wPassword:tString;aUsername: tString);
  Begin
    Identificacao.Filial        := wFilial;
    Identificacao.Usuario       := WUsuario;
    Identificacao.Password         := wPassword;
    Identificacao.Nome_Compreto_do_Usuario := wNome_Compreto_do_Usuario;
    Identificacao.Username         := aUsername;
  end;

  Procedure TParamExecucao.Set_ParamStr(wFilial:Byte;WUsuario:SmallInt;wPassword:tString);
  Begin
    Set_ParamStr(wFilial,WUsuario,'',wPassword,'0');
  end;

  Procedure TParamExecucao.Set_ParamStr(wFilial:Byte;WUsuario:SmallInt;wPassword:tString;wCommand : SmallInt);
  Begin
    Set_ParamStr(wFilial,WUsuario,wPassword);
    Command := wCommand;
  end;

  Procedure TParamExecucao.Set_ParamStr(wFilial:Byte;WUsuario:SmallInt;wNome_Compreto_do_Usuario : tString;wPassword:tString);
  Begin
    Set_ParamStr(wFilial,WUsuario,wNome_Compreto_do_Usuario,wPassword,''{<Username do usuario});
  end;


  Procedure TParamExecucao.Set_ParamStr(wFilial,WUsuario,wPassword,wModulo,wCommand  : tString);
  Begin
    Set_ParamStr(wFilial,WUsuario,wPassword);

    try
      Modulo := StrToInt(wModulo);
    Except
      Modulo := 0;
    end;

    try
      Command := StrToInt(wCommand);
    Except
      Command := 0;
    end;
  end;

  Procedure TParamExecucao.Set_ParamStr(wFilial: AnsiString;WUsuario:SmallInt;wPassword:tString;wModulo:SmallInt;wCommand : SmallInt);
  //Mais: wModulo,wCommand SmallInt

    Var
      Err : Integer;
      BFilial : Byte;
  Begin
    Val(wFilial,BFilial,err);
    If Err <> 0
    Then Set_ParamStr(bFilial,WUsuario,wPassword,wModulo,wCommand);
  end;

  Procedure TParamExecucao.Set_ParamStr(wFilial,WUsuario,wPassword,wModulo,wCommand,a_DataAtual : tString);
  Begin
    Set_ParamStr(wFilial,WUsuario,wPassword,wModulo,wCommand);
    with Tdates do
     DataAtual := StrToDate(a_DataAtual,DateMask_DD_MM_AA)^;
  end;

  Procedure TParamExecucao.Set_ParamStr(wFilial,WUsuario,wPassword,wModulo,wCommand,a_DataAtual : tString;wAcao_Form: AnsiString);
   // Mais: wAcao_Form
  Begin
    Set_ParamStr(wFilial,WUsuario,wPassword,wModulo,wCommand,a_DataAtual);
    Acao_Form := wAcao_Form;
  //  Global_Acao_Form := wAcao_Form; // Obs: Global_Acao_Form espera que a lista de  comandos seja numerico.
  end;

  Procedure TParamExecucao.Set_ParamStr(wFilial,WUsuario,wPassword,wModulo,wCommand,a_DataAtual : tString;wAcao_Form: AnsiString;wList_Value_Default:AnsiString);
    // Mais: wList_Value_Default:AnsiString;
    Var
      Poss : Integer;
  Begin
    Set_ParamStr(wFilial,WUsuario,wPassword,wModulo,wCommand,a_DataAtual,wAcao_Form);
    List_Value_Default  := wList_Value_Default;

  // Insere " na string
    while Pos('$22',List_Value_Default) <> 0 do
    Begin
      Poss := Pos('$22',List_Value_Default);
      delete(List_Value_Default,Poss,3);
      Insert('"',List_Value_Default,Poss);
    end;

  // Insere branco na tString
    while Pos('$20',List_Value_Default) <> 0 do
    Begin
      Poss := Pos('$20',List_Value_Default);
      delete(List_Value_Default,Poss,3);
      Insert(' ',List_Value_Default,Poss);
    end;

  //  Global_List_Value_Default := List_Value_Default;
  end;

  Procedure TParamExecucao.Set_ParamStr(wFilial:Byte;WUsuario:SmallInt;wPassword:tString;wModulo:SmallInt;wCommand : SmallInt);
  Begin
    Identificacao.Filial  := wFilial;
    Identificacao.Usuario := WUsuario;
    Identificacao.Password   := wPassword;

    Modulo  := wModulo;
    Command := wCommand;
  end;


  function TParamExecucao.Check_Se_Comando_autorizado:Boolean;
  Begin
    result := true;
      If ParamCount = 3 // ParamStr(1) = Modulo e ParamStr(2) = Commando e ParamStr(3) = tString para ser enviado ao buffer do teclado
      Then Begin
             exit;
           End
      Else Begin
             If ParamCount >= 2
             Then Begin {Usuário entrando com a Password admin e indica que é a nortsodft que esta operanndo}
                      If ParamStr(2) = '0'
                      Then admin_Logado := 0
                      Else If ParamStr(2) = '1'
                           Then admin_Logado := 1
                           Else Result := false;
                           //Else Raise Exception.Create('Parâmetro inválido. Não posso continua!.');
                  end;
           End;
  end;

  Function TParamExecucao.Get_Password_do_Comando(aModulo: Byte; aComando : SmallInt):tString;
  {
    Retorna a Password do comando passado como parametro.
    Formula
      (Soma_do_ordinal_da_RazaoSocial + aModulo)  * aComando
  }
    Var
      I       : Byte;
      aResult : Int64;
  Begin
    aResult := 0;
    For i := 1 to length(Identificacao.RazaoSocial) do
      aResult := aResult + ord(Identificacao.RazaoSocial[i]);

    aResult := (aResult + aModulo) * aComando;
    Result := IntToStr(aResult);
  End;

  Constructor TParamExecucao.Create(aPathRaiz:Ansistring);
  {<  sintaxe de chamda "Programa.Exe Password_admin 0 filial usuario Password comando"

    p1 = Password_admin+' '+
    p2 = IStr(admin_Logado,'W')+' '+
    p3 = IStr(IntTipos.ParamExecucao.Identificacao.Filial,'BB')+' '+
    p4 = IStr(IntTipos.ParamExecucao.Identificacao.Usuario,'IIIII')+' '+
    p5 = IntTipos.ParamExecucao.Identificacao.Password+' '+
    p6 = IStr(aCommand,'LLLLLL')+' '+
  }

{
                   //Parametros que o sistema espera.
                    Param := 01  Password_admin+' '+
                             02  IStr(admin_Logado,'W')+' '+
                             03  IStr(App_GCIC_EC.MI_Connection_GCIC.ID_Filial,'BB')+' '+
                             04  IStr(App_GCIC_EC.MI_Connection_GCIC.ID_Username,'IIIII')+' '+
                             05  App_GCIC_EC.MI_Connection_GCIC.PassSmallInt+' '+
                             06  Istr(Byte(aModulo),'BB')+' '+
                             07  IStr(aCommand,'LLLLLL')+' '+
                             08  DateToStr(App_GCIC_EC.DataAtual,DateMask_DD_MM_AA)+' '+
                  //                             aList_Event_Command
                             09  SIF(aList_Event_Command<>'',aList_Event_Command,',');

}
  Begin
    if Not okCreate
    then Begin
           Inherited Create(nil);
           okCreate := true;
    end;

    name := Alias_To_Name('TParamExecucao_'+CreateGUID);
    NomeDeArquivosGenericos.NomeArqExe := FExpand(FMaiuscula(ParamStr(0)));

    If aPathRaiz = ''
    Then PathRaiz := ExtractFilePath( ParamStr(0))
    Else PathRaiz := aPathRaiz;


  {Nao devo inicializar _DataAtual para que possa controlar se a _DataAtual
  foi passada como parametro em um processamento em lote.
   Se _DataAtual.dia = 0 e porque a data nao foi passada como parametro.

    GetDataSistOp(_DataAtual,'/');
  }

    //If IsConsole
    //Then Check_Se_Comando_autorizado;

//    Identificacao.Filial  := 1;
//    Identificacao.Usuario := 1;
//    Identificacao.Password   := Password_admin;


    Case ParamCount of
       1  : Begin {O sistema pede a Password e executan o commando}
              Tipo_de_Execucao := TParamExecucao_Tipo_de_Execucao_Normal_Exec_Command;
              Set_ParamStr('1','','',ParamStr(1))
            End;

       3  : Begin {O sistema pede a Password e executan o commando}
              Tipo_de_Execucao := TParamExecucao_Tipo_de_Execucao_Normal_Exec_Command;
              Set_ParamStr('1','','',ParamStr(1),ParamStr(2));
            End;
  {     5  : Begin
              Tipo_de_Execucao := TParamExecucao_Tipo_de_Execucao_Normal_Sem_Pedir_Password;
              Set_ParamStr(ParamStr(3), //<  filial
                           ParamStr(4), //<  usuario
                           ParamStr(5));//<  Password
             end;
  }
       5  : Begin {O sistema trabalha com menu do turbo Vision}
              Tipo_de_Execucao := TParamExecucao_Tipo_de_Execucao_Normal_Sem_Pedir_Password;
              Set_ParamStr(ParamStr(3), //<  filial
                           ParamStr(4), //<  usuario
                           ParamStr(5), //<  Password
                           '','');
            End;

       6  : Begin
              Tipo_de_Execucao := TParamExecucao_Tipo_de_Execucao_Normal_Sem_Pedir_Password;
              Set_ParamStr(ParamStr(3), //<  filial
                           ParamStr(4), //<  usuario
                           ParamStr(5), //<  Password
                           ParamStr(6));//<  Commando
            End;

       7  : Begin {O sistema trabalha com menu Grafico}
              Tipo_de_Execucao := TParamExecucao_Tipo_de_Execucao_VCL;
              Set_ParamStr(ParamStr(3), //IStr(App_GCIC_EC.MI_Connection_GCIC.ID_Filial,'BB')+' '+
                           ParamStr(4), //IStr(App_GCIC_EC.MI_Connection_GCIC.ID_Username,'IIIII')+' '+
                           ParamStr(5), //App_GCIC_EC.MI_Connection_GCIC.PassSmallInt+' '+
                           ParamStr(6), //Istr(Byte(aModulo),'BB')+' '+
                           ParamStr(7)); //IStr(aCommand,'LLLLLL')+' '+

            End;
       8  : Begin {O sistema trabalha com menu Grafico}
              Tipo_de_Execucao := TParamExecucao_Tipo_de_Execucao_VCL;
              Set_ParamStr(ParamStr(3), //IStr(App_GCIC_EC.MI_Connection_GCIC.ID_Filial,'BB')+' '+
                           ParamStr(4), //IStr(App_GCIC_EC.MI_Connection_GCIC.ID_Username,'IIIII')+' '+
                           ParamStr(5), //App_GCIC_EC.MI_Connection_GCIC.PassSmallInt+' '+
                           ParamStr(6), //Istr(Byte(aModulo),'BB')+' '+
                           ParamStr(7), //IStr(aCommand,'LLLLLL')+' '+
                           ParamStr(8)); // DateToStr(App_GCIC_EC.DataAtual,DateMask_DD_MM_AA)+' '+
             end;

       9  : Begin {O sistema trabalha com menu Grafico}
              Tipo_de_Execucao := TParamExecucao_Tipo_de_Execucao_VCL;

              Set_ParamStr(ParamStr(3), //IStr(App_GCIC_EC.MI_Connection_GCIC.ID_Filial,'BB')+' '+
                           ParamStr(4), //IStr(App_GCIC_EC.MI_Connection_GCIC.ID_Username,'IIIII')+' '+
                           ParamStr(5), //App_GCIC_EC.MI_Connection_GCIC.PassSmallInt+' '+
                           ParamStr(6), //Istr(Byte(aModulo),'BB')+' '+
                           ParamStr(7), //IStr(aCommand,'LLLLLL')+' '+
                           ParamStr(8), // DateToStr(App_GCIC_EC.DataAtual,DateMask_DD_MM_AA)+' '+
                           ParamStr(9)); // SIF(aList_Event_Command<>'',aList_Event_Command,',');
            End;

      10  : Begin {O sistema trabalha com menu Grafico}
              Tipo_de_Execucao := TParamExecucao_Tipo_de_Execucao_VCL;
              Set_ParamStr(ParamStr(3), //IStr(App_GCIC_EC.MI_Connection_GCIC.ID_Filial,'BB')+' '+
                           ParamStr(4), //IStr(App_GCIC_EC.MI_Connection_GCIC.ID_Username,'IIIII')+' '+
                           ParamStr(5), //App_GCIC_EC.MI_Connection_GCIC.PassSmallInt+' '+
                           ParamStr(6), //Istr(Byte(aModulo),'BB')+' '+
                           ParamStr(7), //IStr(aCommand,'LLLLLL')+' '+
                           ParamStr(8), // DateToStr(App_GCIC_EC.DataAtual,DateMask_DD_MM_AA)+' '+
                           ParamStr(9), // SIF(aList_Event_Command<>'',aList_Event_Command,',');
                           ParamStr(10)); //?
  //            SysMessageBox( PAnsiChar(Global_List_Value_Default),'teste dos parametros',true);
            End;

      Else Begin

             Tipo_de_Execucao := TParamExecucao_Tipo_de_Execucao_Normal; {O sistema trabalha com menu do turbo Vision vcl normal}
             Set_ParamStr('1', //<  filial
                          '1', //<  usuario
                          Password_admin,  //<  Password
                          '','');
           End;
     End;

     If IsApp_Cgi
     Then Tipo_de_Execucao := TParamExecucao_Tipo_de_Execucao_CGI;

     if IsApp_ISAPI
     then Tipo_de_Execucao := TParamExecucao_Tipo_de_Execucao_ISAPI;

     if Tipo_de_Execucao in [TParamExecucao_Tipo_de_Execucao_CGI,TParamExecucao_Tipo_de_Execucao_ISAPI]
     then Set_ParamStr('1','1',Password_admin);


    If (@_Set_NomeDeArquivosGenericos = nil ) and (@Set_NomeDeArquivosGenericos_Global <> nil)
    then Begin
           _Set_NomeDeArquivosGenericos := Set_NomeDeArquivosGenericos_Global;

//           Set_NomeDeArquivosGenericos(PathRaiz); não posso chamar aqui porque a variável global ParamExecução ainda é nil.
         End;


    Set_HostName('127.0.0.1');

    if DefaultSystemCodePage = CP_UTF8
    then DatabaseNameCharSet := 'UTF8'
    else DatabaseNameCharSet := '';


    With NomeDeArquivosGenericos do
    Begin
      DataBaseName := 'MarIcarai';

      OS             := GetEnv('OS');
      ComputerName   := GetEnv('ComputerName');
      LOGONSERVER    := GetEnv('LOGONSERVER');
      SESSIONNAME    := GetEnv('SESSIONNAME');
      USERDOMAIN     := GetEnv('USERDOMAIN');
      USERNAME       := GetEnv('USERNAME');
      USERPROFILE    := GetEnv('USERPROFILE');
      ALLUSERSPROFILE:= GetEnv('ALLUSERSPROFILE');
      ProgramFiles   := GetEnv('ProgramFiles');
      CommonProgramFiles:= GetEnv('CommonProgramFiles');
      HOMEDRIVE      := GetEnv('HOMEDRIVE');
      HOMEPATH       := GetEnv('HOMEPATH');
      SystemDrive    := GetEnv('SystemDrive');
      SystemRoot     := GetEnv('SystemRoot');
      windir         := GetEnv('windir');
    end;
  End;

  Constructor TParamExecucao.Create(aOwner:TComponent);
  Begin
    inherited Create(aOwner);
    Create('');
  End;

  Destructor TParamExecucao.Destroy;
  begin
     freeandnil(Identificacao);
     Inherited Destroy;
  end;

  Function TParamExecucao.Set_HostName(aHostName : AnsiString): AnsiString;
  Begin
    Result := HostName;
    _HostName  := aHostName;
  End;

  function TParamExecucao.Set_NomeDeArquivosGenericos(): boolean;
  begin
    result := true;
    IF @_Set_NomeDeArquivosGenericos <> NIL
    THEN _Set_NomeDeArquivosGenericos(SELF)
    ELSE Raise TException.Create(Self,'Set_NomeDeArquivosGenericos()','Atributo _Set_NomeDeArquivosGenericos não inicializado!.');
  end;

  Procedure TParamExecucao.SetDominioHost(aHostName : AnsiString);
  Begin
    _HostName  := aHostName;
  end;

  Function TParamExecucao.Get_HostName: AnsiString;
  Begin
    Result := _HostName;
  End;



{$ENDREGION}
//==============================================================================================================


end.

