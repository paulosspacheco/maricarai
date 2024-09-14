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

        public type TFunc_Set_EnvironmentVariables = Function(aParamExecucao: TParamExecucao) :boolean;


        Public Type TEnvironmentVariables =
                      record
                        LANGUAGE                : AnsiString;
                        pwd                     : DirStr;
                        SessionName             : DirStr;
                        SHELL                   : PathStr;
                        NomeArqExe              : DirStr;
                        NomeArqDll              : DirStr;
                        DirExe                  : DirStr;
                        DirDataBaseName_Template: DirStr;
                        CGI_BIN                 : DirStr;

                        {: O campo **@name** contém a pasta de recursos do
                           template para criar formulários
                        }
                        Dir_lfm_mi              : DirStr;

                        Dir_Local_Ferr          : DirStr;
                        Name_Local_Ferr         : DirStr;
                        Path_Schema             : DirStr;
                        Name_Schema             : DirStr;
                        Ext_Schema              : ExtStr;
                        Path_Import             : DirStr;
                        Path_Export             : DirStr;
                        OS                      : DirStr;   //<  Sistema operacional
                        ComputerName            : DirStr;
                        LOGONSERVER             : DirStr;
                        USERDOMAIN              : DirStr;
                        USERNAME                : DirStr;
                        USERPROFILE             : DirStr;
                        ALLUSERSPROFILE         : DirStr;
                        ProgramFiles            : DirStr;
                        CommonProgramFiles      : DirStr;
                        HOME                    : DirStr;
                        HOMEDRIVE               : DirStr;
                        HOMEPATH                : DirStr;
                        SystemDrive             : DirStr;
                        SystemRoot              : DirStr;
                        windir                  : AnsiString;
                        DirHTML_Template        : DirStr;
                        DirHTML_imagens         : DirStr;
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
          Public var Func_Set_EnvironmentVariables : TFunc_Set_EnvironmentVariables;static;
          public Const  Func_Set_EnvironmentVariables_Global : TFunc_Set_EnvironmentVariables = nil;
        end;

        TParamExecucao = Class (TParamExecucao_consts)
          protected Var okCreate:Boolean;
          public Constructor Create(aOwner:TComponent);overload;override;
          public Procedure SetParamametros(aPathRaiz:Ansistring);Virtual;
          Destructor Destroy;override;
          private R_ParamExecucao_Local_ant : TR_ParamExecucao_Local;
          Public Function Set_EnvironmentVariables() :boolean;
          public EnvironmentVariables : TEnvironmentVariables;
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

          public procedure Set_ParamStr();Overload;

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

Procedure TParamExecucao_types.TEnvironmentVariables.Set_DirDoc(a_DirDoc: DirStr);
Begin
  DirHTML                    := TObjectsMethods.ChangeSubStr(_DirDoc,a_DirDoc,DirHTML);
  DirHTML_Template           := TObjectsMethods.ChangeSubStr(_DirDoc,a_DirDoc,DirHTML_Template);
  DirHTML_Template_Default   := TObjectsMethods.ChangeSubStr(_DirDoc,a_DirDoc,DirHTML_Template_Default);
  DirHTML_Template_Default   := TObjectsMethods.ChangeSubStr(_DirDoc,a_DirDoc,DirHTML_Template_Default);
  DirHTML_Template_Custom    := TObjectsMethods.ChangeSubStr(_DirDoc,a_DirDoc,DirHTML_Template_Custom);
  DirHTML_Doc_Program	     := TObjectsMethods.ChangeSubStr(_DirDoc,a_DirDoc,DirHTML_Doc_Program);
  _DirDoc := a_DirDoc;
End;


Procedure TParamExecucao_types.TEnvironmentVariables.Set_DirDataBaseName(a_DirDataBaseName: DirStr);
begin
  if a_DirDataBaseName[length(a_DirDataBaseName)] <> PathDelim
  then a_DirDataBaseName := a_DirDataBaseName + PathDelim;


  _DirDataBaseName := FExpand(a_DirDataBaseName);

  Path_Schema := TObjectsMethods.ChangeSubStr(_DirDataBaseName,a_DirDataBaseName,Path_Schema);
  Path_Import := TObjectsMethods.ChangeSubStr(_DirDataBaseName,a_DirDataBaseName,Path_Import);
  Path_Export := TObjectsMethods.ChangeSubStr(_DirDataBaseName,a_DirDataBaseName,Path_Export);
end;

Procedure TParamExecucao_types.TEnvironmentVariables.Set_DataBaseName(a_DataBaseName: NameStr);
Begin
  if a_DataBaseName = ''
  then _DataBaseName := ExtractFileName(Self.NomeArqExe) + '.tb'
  Else _DataBaseName := ExtractFileName(FExpand(a_DataBaseName));

  //Se o path não for informado então usar o path onde a tabela a_DataBaseName informar.
  if _DirDataBaseName = ''
  then _DirDataBaseName := ExtractFilePath(FExpand(a_DataBaseName));
End;

Function TParamExecucao_types.TEnvironmentVariables.Get_DirTemp(): DirStr;
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
threadvar
//Var
  R_ParamExecucao_Local : TR_ParamExecucao_Local;

  class Function TParamExecucao.Param_Execucao : TParamExecucao;
  begin
    With R_ParamExecucao_Local do
    begin
      If _ParamExecucao = nil
      Then Begin
             _ParamExecucao        := TParamExecucao.create(nil);
             _Destoy_ParamExecucao := True;

             if @_ParamExecucao.Func_Set_EnvironmentVariables<>nil
             Then begin
                    if _ParamExecucao.PathRaiz = ''
                    Then _ParamExecucao.PathRaiz := ParamStr(0);

                    _ParamExecucao.Set_EnvironmentVariables;
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
    _Acao_Form := UpperCase(w_Acao_Form );
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
    wAcao_form := UpperCase(Acao_form);
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
    wAcao_form := UpperCase(Acao_form);

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


  Procedure TParamExecucao.Set_ParamStr();
  Begin
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

  Procedure TParamExecucao.SetParamametros(aPathRaiz:Ansistring);
  Begin
    name := Alias_To_Name('TParamExecucao_'+CreateGUID);
//    EnvironmentVariables.NomeArqExe := FExpand(UpperCase(ParamStr(0)));
    EnvironmentVariables.NomeArqExe := UpperCase(ParamStr(0));

    If aPathRaiz = ''
    Then PathRaiz := ExtractFilePath( ParamStr(0))
    Else PathRaiz := aPathRaiz;
    Set_ParamStr();
    If (@Func_Set_EnvironmentVariables = nil ) and
       (@Func_Set_EnvironmentVariables_Global <> nil)
    then Begin
           Func_Set_EnvironmentVariables := Func_Set_EnvironmentVariables_Global;
//           Set_EnvironmentVariables(PathRaiz); não posso chamar aqui porque a variável global ParamExecução ainda é nil.
         End;
    Set_HostName('http://localHost'); //127.0.0.1

    if DefaultSystemCodePage = CP_UTF8
    then DatabaseNameCharSet := 'UTF8'
    else DatabaseNameCharSet := '';

    With EnvironmentVariables do
    Begin

      {$IFDEF Windows}
        home           := GetEnv('USERPROFILE');
        UserName       := GetEnv('USERNAME');
        DataBaseName := 'MarIcarai';
        LANGUAGE       := GetEnv('LANGUAGE');
        OS             := GetEnv('OS');
        ComputerName   := GetEnv('ComputerName');
        LOGONSERVER    := GetEnv('LOGONSERVER');
        SESSIONNAME    := GetEnv('SESSIONNAME');
        USERDOMAIN     := GetEnv('USERDOMAIN');
        shell          := GetEnv('ComSpec');

        DirTemp        := GetEnv('TEMP');
        if DirTemp = ''
        Then DirTemp   := GetEnv('TMP');

        pwd            := GetEnv('CD');
        USERPROFILE    := GetEnv('USERPROFILE');
        ALLUSERSPROFILE:= GetEnv('ALLUSERSPROFILE');
        ProgramFiles   := GetEnv('ProgramFiles');
        CommonProgramFiles:= GetEnv('CommonProgramFiles');
        HOMEDRIVE      := GetEnv('HOMEDRIVE');
        HOMEPATH       := GetEnv('HOMEPATH');
        SystemDrive    := GetEnv('SystemDrive');
        SystemRoot     := GetEnv('SystemRoot');
        windir         := GetEnv('windir');

      {$ENDIF}

      {$IFDEF UNIX}
        OS             := 'Linux';
        DataBaseName   := 'MarIcarai';
        LANGUAGE       := GetEnv('LANG');
        HOMEPATH       := GetEnv('HOME');
        USERNAME       := GetEnv('USER');
        if USERNAME = ''
        Then USERNAME  := GetEnv('LOGNAME');

        SHELL          := GetEnv('SHELL');
        DirTemp        := GetEnv('TMP');
        if DirTemp = ''
        Then DirTemp   := GetEnv('TEMP');

        pwd            := GetEnv('PWD');
        ComputerName   := GetEnv('ComputerName');
        LOGONSERVER    := GetEnv('LOGONSERVER');
        SESSIONNAME    := GetEnv('SESSIONNAME');
        USERDOMAIN     := GetEnv('USERDOMAIN');
        USERPROFILE    := GetEnv('USERPROFILE');
        ALLUSERSPROFILE:= GetEnv('ALLUSERSPROFILE');
        ProgramFiles   := GetEnv('ProgramFiles');
        CommonProgramFiles:= GetEnv('CommonProgramFiles');
        SystemDrive    := GetEnv('SystemDrive');
        SystemRoot     := GetEnv('SystemRoot');
        windir         := GetEnv('windir');

      {$ENDIF}

    end;
  End;

  Constructor TParamExecucao.Create(aOwner:TComponent);
  Begin
    inherited Create(aOwner);
    SetParamametros('');
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

  function TParamExecucao.Set_EnvironmentVariables(): boolean;
  begin
    result := true;
    IF @Func_Set_EnvironmentVariables <> NIL
    THEN Func_Set_EnvironmentVariables(SELF)
    ELSE Raise TException.Create(Self,'Set_EnvironmentVariables()','Atributo _Set_EnvironmentVariables não inicializado!.');
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

