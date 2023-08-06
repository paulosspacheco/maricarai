unit mi.rtl.Consts;
{:< - A Unit **@name** reúne as constantes globais usados pelo pacote **mi.rtl**.
               Esta unit foi testada nas plataformas: win32, win64 e linux.


  - **VERSÃO**
    - Alpha - 0.7.1

  - **CÓDIGO FONTE**:
    - @html(<a href="../units/mi.rtl.consts.pas">mi.rtl.consts.pas</a>)          
  
  - **HISTÓRICO**
    - Criado por: Paulo Sérgio da Silva Pacheco e-mail: paulosspacheco@@yahoo.com.br
      - **13/11/2021** : Classe criada

      - **/16/11/2021** :
        - Em **TConsts.Initialization** executar:
          - **System.FileMode** := **TConsts.FileMode**;
          - Motivo: O mapa de Bits **System.FileMode** não permite acesso compartilhado.

      - **15/12/2021**
        - Criado a constante Identification = TIdentification.

      - **31/12/2021**
        - Criado a constante NRec e NRecAux para manter a compatibilidade com o passado.

      - **24/06/2022
        - Criar constante FldLink  
}


{$H+}

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface

uses
  {$IFDEF Windows}Windows,{$ENDIF}
  {$IFDEF UNIX}BaseUnix,  Unix, {$ENDIF}

  Classes
  ,SysUtils
  ,process
  ,mi.rtl.types;

  {: A classe **@name** declara todas as constantes globais do pacote MarIcarai
  }
  type TConsts =
  class(TTypes)
    Const C_DEF_VER_FORMAT4             = '{mjr}.{mnr}.{rev}.{bld}';
    Const C_DEF_VER_FORMAT3             = '{mjr}.{mnr}.{rev}';
    Const C_DEF_VER_FORMAT2             = '{mjr}.{mnr}';

    {: Pilha com tStrings de erros.}
    public  Const ListaDeMsgErro : TTypes.PSItem = nil;

    public
      {$REGION 'tvDMX Field access attributes' }
        { Resumo criado por Rand back:

           Modificador de código de campo:
             ' Z'--zero modificador para forçar conduzindo ou arrastando zeroes

           Códigos de controle de campo:

             ^A--Zera todos os campos
             ^C--O campo corrente possuem uma lista de opções do mesmo tipo.
             ^D--use o próximo char como um delimiter de campo
             ^E--Campos do tipo enumerado.
             ^F--Usado para criar restrições e relacionamentos
             ^H--Campo escondido
             ^P--Usado para controlar o flag do tipo de campo
             ^R--campo somente de leitura
             ^S--" salte " campo (cursor saltar  em cima disto)
             ^U--o limite superior do campo (Somente 1 a 255)
             ^V--Em caso de omissão use o tString apos ^V
             ^X--campo de BOOLEAN especial
             ^Z--zera se este campo está vazio
             ^L--Link para uma URL ou actionItens

             '~' --switch tString-literals on/off

           Delimiters de campo:

               #0--delimiter de campo técnico (não exibe)
             ' \ '--exibe como um espaço
             ' | '--exibe como uma linha vertical sólida (#179)

             Obs:
               também podem ser usados #179 ou #186 como delimiters.
               Obs: No modo console os caracteres #179 ou #186 eram impressos para dividir colunas.

           Funções de extensão do modelo:  (em arquivo DMXGIZMA.PAS)

              func CreateAppendFields ()
              func CreateBlobField ()
              func CreateEnumField ()
              func CreateTSItemFields ()
        }

        {: A constante **@name** (Const AccNormal = 0;) é um mapa de bits usado para identificar o
           bit do campo TDmxFieldRec.access que informa se que o campo pode ser editado.

           - **EXEMPLO**
             - Como usar o mapa de bits accNormal para saber se o campo pode ser editado.

               ```pascal

                  with pDmxFieldRec^ do
                    If (access and accNormal <> 0)
                    then begin
                           ShowMessage(Format('O campo %s pode ser editado'),[CharFieldName]);
                         end;
               ```
        }
        Const accNormal      =    0; //00000000 - Campo editavel

        {: A constante **@name** (Const ReadOnly = 1;) é um mapa de bits usado para identificar o
           bit do campo TDmxFieldRec.access que informa se o campo é somente para leitura.

           - **EXEMPLO**
             - Como usar o mapa de bits ReadOnly para saber se o campo não pode ser editado.

               ```pascal

                  with pDmxFieldRec^ do
                    If (access and ReadOnly <> 0)
                    then begin
                           ShowMessage(Format('O campo %s não pode ser editado'),[CharFieldName]);
                         end;
               ```
        }
        Const accReadOnly  =  $1; //00000001 - Somente para leitura

        {: A constante **@name** (Const accHidden = 2;) é um mapa de bits usado para identificar o
           bit do campo TDmxFieldRec.access que informa se o mesmo é invisível.

           - **EXEMPLO**
             - Como usar o mapa de bits accHidden para saber se o campo é invisível.

               ```pascal

                  with pDmxFieldRec^ do
                    If (access and accHidden <> 0)
                    then begin
                        ShowMessage(Format('O campo %s está invisível'),[CharFieldName]); 
                        end;
               ```
        }
        Const accHidden      =  $2; //00000010 - Campo invis=vel

        {: A constante **@name** (Const accSkip = 4;) é um mapa de bits usado para identificar o
           bit do campo TDmxFieldRec.access que informa se o campo pode receber o focus.

           - **EXEMPLO**
             - Como usar o mapa de bits accSkip para saber se o campo não pode receber o focus.

               ```pascal

                  with pDmxFieldRec^ do
                    If (access and accSkip <> 0)
                    then begin
                           ShowMessage(Format('O campo %s não pode receber o focus'),[CharFieldName]);
                         end;
               ```
        }        
        Const accSkip  =  $4; //00000100 - Passe para o próximo campo

        {: A constante **@name** informa que o campo é delimitador de campos no Template.}
        Const accDelimiter   =  $8; //00001000

        Const accExternal    =  $10;//00010000 - for future use }
        Const accSpecA       =  $20;//00100000
        Const accSpecB       =  $40;//01000000
        Const accSpecC       =  $80;//10000000


        {: A constante **@name** (Const fldStr = 'S') usado na máscara do Template,
           informa ao componente **TUiDmxScroller** que a sequência de caracteres 'S'
           após o caractere **"\"** representa no buffer do formulário um tipo ShortString
           que só aceita caractere maiúsculo.

           - **EXEMPLO**
             - Representação de um string de 10 dígitos em um buffer de 11 bytes
               onde o byte zero contém o tamanho da string;

               ```pascal

                  Const
                    Nome := '\SSSSSSSSSS'

               ```
        }
        Const fldStr              =   'S';
        Const fldS = fldStr;

        {: A constante **@name** (Const fldSTR_Minuscula = 's') usado na máscara do Template,
           informa ao componente **TUiDmxScroller** que a sequência de caracteres 's'
           após o caractere **"\"** representa no buffer do formulário um tipo ShortString
           que só aceita caractere minúscula.

           - **EXEMPLO**
             - Representação de um string de 10 dígitos em um buffer de 11 bytes
               onde o byte zero contém o tamanho da string;

               ```pascal

                  Const
                    Nome := '\ssssssssss' //paulosergi
                    Nome := '\Ssssssssss' //Paulo serg
               ```
        }
        Const fldSTR_Minuscula    =   's';
        Const fldSMi = fldSTR_Minuscula;

        {: A constante **@name** (Const fldSTRNUM = '#') usado na máscara do Template,
           informa ao componente **TUiDmxScroller** que a sequência de caracteres '#'
           após o caractere **"\"** representa no buffer do formulário um tipo ShortString
           que só aceita caractere numérico.

           - **EXEMPLO**
             - Representação de um string de 11 dígitos em um buffer de 12 bytes
               onde o byte zero contém o tamanho da string;

               ```pascal

                  Const
                    telefone := '\(##) # ####-####' //85 9 9702 4498

               ```
        }
        Const fldSTRNUM           =   '#';
        Const fldSN = fldSTRNUM;

        {: A constante **@name** (Const fldAnsiChar = 'C') usado na máscara do Template,
           informa ao componente **TUiDmxScroller** que a sequência de caracteres 'C'
           após o caractere **"\"** representa no buffer do formulário um tipo AnsiString
           que só aceita caractere maiúsculo.

           - **EXEMPLO**
             - Representação de um AnsiString de 10 dígitos em um buffer de 11 bytes
               onde o ultimo byte contém o caractere #0 informando o fim da string;

               ```pascal

                  Const
                    Nome := '\CCCCCCCCCC'; //PAULO SÉRG

               ```
        }
        Const fldAnsiChar             =   'C';
        Const fldAC = fldAnsiChar;

        {: A constante **@name** (Const fldAnsiChar = 'c') usado na máscara do Template,
           informa ao componente **TUiDmxScroller** que a sequência de caracteres 'c'
           após o caractere **"\"** representa no buffer do formulário um tipo AnsiString
           que só aceita caractere minúsculo.

           - **EXEMPLO**
             - Representação de um AnsiString de 10 dígitos em um buffer de 11 bytes
               onde o ultimo byte contém o caractere #0 informando o fim da string;

               ```pascal

                  Const
                    Nome := '\cccccccccc'; //paulo Sérg
                    Nome := '\Cccccccccc'; //Paulo Sérg


               ```
        }
        Const fldAnsiChar_Minuscula   =   'c';
        Const fldACMi = fldAnsiChar_Minuscula;

        {: A constante **@name** (Const fldAnsiChar = '0') usado na máscara do Template,
           informa ao componente **TUiDmxScroller** que a sequência de caracteres '0'
           após o caractere **"\"** representa no buffer do formulário um tipo AnsiString
           que só aceita caractere numérico ['0'..'9']] .

           - **EXEMPLO**
             - Representação de um AnsiString de 11 dígitos em um buffer de 12 bytes
               onde o ultimo byte contém o caractere #0 informando o fim da string;

               ```pascal

                  Const

                    telefone := '\(00) 0 0000-0000' //85 9 9702 4498

               ```
        }
        Const fldAnsiCharNUM          =   '0';
        Const fldACN = fldAnsiCharNUM;

        {: A constante **@name** (Const fldAnsiChar = '0') usado na máscara do Template,
           informa ao componente **TUiDmxScroller** que a sequência de caracteres '0'
           após o caractere **"\"** representa no buffer do formulário um tipo AnsiString
           que só aceita caractere numérico ['0'..'9']] com formatação dbase.

           - **EXEMPLO**
             - Representação de um AnsiString de 11 dígitos em um buffer de 12 bytes
               onde o ultimo byte contém o caractere #0 informando o fim da string;

               ```pascal

                  Const

                    telefone := '\(NN) N NNNN-NNNN' //85 9 9702 4498

               ```
        }
        Const fldAnsiCharVAL          =   'N';  

        {: A constante **@name** (Const fldBYTE = 'B') usado na máscara do Template,
           informa ao componente **TUiDmxScroller** que a sequência de caracteres 'B'
           após o caractere **"\"** representa no buffer do formulário um tipo byte.

           - **EXEMPLO**

               ```pascal

                  Const
                     idade := '\BB' //Os dois dígitos estarão em um buffer de 1 byte;

               ```
        }
        Const fldBYTE             =   'B';  //:< byte Field
        Const fldSHORTINT         =   'J';  //:< shortint Field       
        Const fldSmallWORD        =   'W';  //:< word Field NortSoft       
        Const fldSmallInt         =   'I';  //:< integer Field NortSoft
        Const fldLONGINT          =   'L';  //:< longint Field
        Const fldRealNum          =   'R';  //:< real number Field  (uses TRealNum)
        Const fldRealNum_Positivo =   'r';  //:< real number Field positive (uses TRealNum)
      
        {: A constante **@name** (fldBoolean = 'X') indica que o campo é do tipo
           byte e só pode ter dois valores.

           - **NOTA**
             - Valores possíveis:
               - 0 - False; não
               - 1 = True;  sim

             - A forma de editá-los deve ser com o componente checkbox.

           - **EXEMPLO**

               ```pascal

                  Resourcestring
                    tmp_Aceita = '\X Aceita o contrato +ChFN+'Aceita_contrato'+CharHint+'Aceita os termos do contrato?';
                    Template = tmp_Aceita+'~Aceita os termos do contrato~';
               ```
        }
        Const fldBoolean          =   'X';

        Const fldHexValue         =   'H';  //:< hexadecimal numeric entry

        {: A constante **@name** (CharUpperlimit=^U) permite informar um limite superior para campos
           do tipo byte.

           - O gerador de formulário deve usar o conteúdo do campo pDmxFieldRec.Upperlimit
             para criticar se o valor do campo está na faixa entre 1 e pDmxFieldRec.Upperlimit.
           - O valor zero significa que o campo está nulo.


           - **EXEMPLO**
              - Um campo onde o seu conteúdo não ultrapasse um byte, pode ser informado
                 no Template da seguinte forma:

                ```pascal

                  Const
                    idade := '\BBB+CharUpperlimit+#130+CharHint+'Não existe humanos
                              com a idade superior a 130 anos.';
                ```
        }
        Const CharUpperlimit       =   ^U ;  //:< Limite superior do campo (Somente 1 a 255)

        {: A constante **@name** (fldENUM=^E) é um campo do tipo longint que contém
           o índice corrente da lista de string.
           - Os controles usados para edita-lo são:
             - TComboBox se o registro não está associado a banco de dados;
             - TdbLookupComboBox se o registro estiver associado a TDataSet.

           - **EXEMPLO USO NO TEMPLATE**

             ```pascal

                Const 
                  tmpMidia : PSitem = nil;

                begin
                  tmpMidia := CreateEnumField(TRUE, accNormal, 0,
                                              NewSItem(' indefinido ', //0
                                              NewSItem(' Pendriver  ', //1
                                              NewSItem(' SSD        ', //2 
                                              nil))))+CharFieldName+'Midia;

                  Template = NewSItem('~  Eu uso ~'+ tmpMidia + '~ em meu computador.~',
                      Next);
                end;

             ```
        }
        Const fldENUM      =  ^E;   //:< enumerated Field

        {: A constante **@name** indica que o campo é não formatado 
           podendo ser um Record, porém a edição do mesmo será feito por outros meios.

           - **NOTA**
               - Para informar ao buffer do registro que o campo é **@name**,
                 a função **CreateBlobField** é necessário.
               - A **class function TUiMethods.CreateBlobField(Len: integer; AccMode,Default: byte) : DmxIDstr;**
                 reserva espaço para o mesmo.

               - Pendência: Preciso criar um exemplo de uso deste tipo de informação.  
        }        
        Const fldBLOb             =   ^M;  

        {: O tipo do campo **@name** é um campo tipo TCluster e é representado no Template
           em um controle TRadioButton

           - **NOTAS**
             - Um Template pode conter vários campos do tipo cluster e o mesmo é identificado
               após a sequencia \K? onde ? indica que a informação pertence ao campo ?
               - Exemplo:
                 - SEXO
                   - \Ka Masculino
                   - \Ka Feminino
                   - \Ka Indefinido
             - Os campos clusteres possuem o mesmo número do campo e na primeira
               ocorrência contém o nome do campo na lista pDmxFieldRec.

           - **EXEMPLO**

             ```pascal
                 Result :=
                   NewSItem('~  SEXO~',
                   NewSItem('~  ~\Ka Masculino',
                   NewSItem('~  ~\Ka Feminino',
                   NewSItem('~  ~\Ka Indefinido',
                   NewSItem('~  ESTADO CIVIL~',
                   NewSItem('~  ~\Kb Solteiro',
                   NewSItem('~  ~\Kb Casado',
                   NewSItem('~  ~\Kb Divorciado',
                   nil))))))))
             ```
        }
        Const FldRadioButton      =  'K'; //Maiúscula

        {: O tipo do campo **@name** é um campo tipo String e é representado no Template
           em controle TDbRadioButton

           - **NOTAS**
             - Um Template pode conter vários campos do tipo DbRaidoButton e o mesmo é identificado
               após a sequencia \k? onde ? indica que a informação pertence ao campo ?
               - Exemplo:
                 - SEXO
                   - \ka Masculino
                   - \ka Feminino
                   - \ka Indefinido
             - Os campos DbRadioButton possuem o mesmo número do campo e na primeira
               ocorrência contém o nome do campo na lista pDmxFieldRec.

             - O motivo pelo qual **@name** foi criado é que o banco de dados do freepascal
               reconhece esse tipo como string com o nome do caption selecionado.

             - O tamanho da string deve ser o tamanho da maior string da lista de opções.
        }
        Const FldDbRadioButton    =  'k';//minúsculo

        Const fldZEROMOD          =   'Z';  //:< zero modifier

        {: A constante **@name** omite da visão do usuário a parte do campo 
           que não precisa ser mostrado, ou seja: limita a parte visível do texto 
           permitindo scroll lateral do mesmo.  }
        Const fldCONTRACTION      =   '`';  

        {:A constante **@name** é usada para concatenar duas listas do tipo PSItem.

          - A constante **@name** é necessário porque DmxScroller trabalha com string curta
            e a mesma tem um tamanho de 255 caracteres, onde o tamanho está na posição 0.

          - Como usar a constante **@name**:

            - A função **CreateAppendFields** retorna a constante **fldAPPEND** mais
              o endereço da string a ser concatenada.

              - **EXEMPLO**

                  ```pascal

                     procedure Template : ShortString;
                       Var
                         S1,s2,Template : TString;
                     begin
                       S1 := '~Nome do Aluno....:~\ssssssssssssssssssssssssssssssssss';
                       s2 := '~Endereço do aluno:~\sssssssssssssssssssssssss';
                       result := S1+CreateAppendFields(s2);
                     end;

                  ```
              - **NOTA**
                - A contante **@name** foi criada porque o projeto inicial foi
                  para turbo pascal e ambiente console.
                - A versão atual podemos usar AnsiString visto que o limite do mesmo
                  é a memória.
                - Para usar AnsiString é necessário converter para PSitem com a função: **StringToSItem**.

                  - **EXEMPLO:**

                    ```pascal

                      function TMI_UI_InputBox.DmxScroller_Form1GetTemplate(aNext: PSItem): PSItem;
                      begin
                        with DmxScroller_Form1 do
                        begin
                          if _Template  <> ''
                          then Result := StringToSItem(_Template, 80);

                      //    Result := StringToSItem(_Template, 40,TObjectsTypes.TAlinhamento.Alinhamento_Esquerda)
                      //    Result := StringToSItem(_Template, 40,TObjectsTypes.TAlinhamento.Alinhamento_Central)
                      //    Result := StringToSItem(_Template, 40,TObjectsTypes.TAlinhamento.Alinhamento_Direita)
                      //    Result := StringToSItem(_Template, 80,TObjectsTypes.TAlinhamento.Alinhamento_Justificado)

                          else result := nil;
                        end;
                      end;

                    ```
        }
        Const fldAPPEND           =   ^G;

        Const fldSItems           =   ^I;   //:< link to chain of TSItem Templates
//        Const fldXSPACES          =   ' ';  //:< spaces --extended code follows <Esc>
//        Const fldXTABTO           =   ^I;   //:< tab    --extended code follows <Esc>

//        Const fldXFieldNUM        =   ^F;   //:< fnum   --extended code follows <Esc>

        {: A constante **@name** (fldExtended='E') usado na máscara do Template,
           informa ao componente **TUiDmxScroller** que a sequência de caracteres 'E'
           após o caractere **"\"** representa no buffer do formulário um tipo Extended.

           - **EXEMPLO**

               ```pascal

                  Const
                     Valor := '\EEE,EEE,EEE,EEE,EE' //Todos os número editados nesta
                                                      mascara estarão em um buffer de 10 bytes;

               ```
        }
        Const fldExtended       = 'E';  //:< Real 10 bytes
        Const fldReal4          = 'O';  //:< Real 4 Byte positivos e negativos
        Const fldReal4Positivo  = 'o';  //:< Real 4 Byte positivos
        Const fldReal4P         = 'P';  //:< P = Real de mostrado x por 100 positivos e negativos
        Const fldReal4PPositivo = 'p';  //:< P = Real de mostrado x por 100 positivos

        {: A constante **@name** indica que o campo contem um campo com 255 posições 
           que contém um endereço para um página html ou não:

           - **LINKS POSSÍVEIS:**
             - ^L+1 = Endereço de uma página na web a ser acessada pelo browser.
             - ^L+2 = Nome de uma ação da lista actionItens.
        }
        Const FldLink       = ^L; 
        Const FldlinkUrl    = ^L+'1';//:< Endereço de uma página na web a ser acessada pelo browser.
        Const FldlinkAction = ^L+'2';//:< Nome de uma ação da lista actionItens.

        Const fldData           = 'D';   //:< D = TipoData DD/DD/DD
        Const fld_LData         = 'd' ;  //:< d = TDataTime;Guarda a data compactada 'dd/dd/dd'
        Const fldLData          = #1  ;  //:< #1 = TDataTime;Guarda a data compactada '##/##/##'
        Const FldSData          = '##/##/##';
        Const fldLHora          = #2 ;  //:< #2 = Longint;Guarda a hora compactada  ##:##:##
        Const FldSHora          = '##:##:##';
        Const fld_LHora         = 'h';  //:< h = Longint;Guarda a hora compactada   hh:hh:hh
        Const FldOperador       = #3; //:< #3 = Byte indica que o campo é um operador matemático
        Const FldDateTimeDos    = #4 ;  //:< #4 = Longint;Guarda a data e hora compactada  ##/##/## ##:##:## e o ano não pode ser menor que 1980.
        Const FldSDateTimeDos   = '##/##/## ##:##:##';

        {: Usado para omitir os caracteres que estão sendo digitados em qualquer tipo de campo
        }
        Const CharShowPassword      = ^W;

        {: A contante **@name** é igual CharShowPassword. }
        Const ChSP = CharShowPassword;

        Const CharShowPasswordChar  =   '*';  {:< Caractere a ser mostrado quando CharShowPassword em fldField for igual = ^W}

        {: A contante **@name** é usado para associar ao campo atual uma classe **TAction**.

           - **NOTA**
             - O interpretador de Templates associa a ação do Template ao corrente campo.
        }
        Const CharExecAction       = ^T;  //#20=^T O Ponteiro para um procedimento

        {: A contante **@name** é igual CharExecAction. }
        Const ChEA  = CharExecAction;

        Const CharLupa_Left           = '🔍';
        Const CharLupa_Right          = '🔎';
        const Char_Seta_para_Cima     = '⬆️';
        const Char_Seta_para_Baixo    = '⬇️️';
        const Char_Seta_para_direita  : AnsiString = '➡️';
        const Char_Seta_para_esquerda : AnsiString = '⬅️️';
        const Char_Seta_Back = '🔙';
        const Char_Seta_End = '🔚';
        const Char_Seta_On  = '🔛';
        Const Char_Seta_Em_breve_Flecha  = '🔜';
        Const Char_Seta_Top              = '🔝';
        Const Char_Seta_Cicle            = '🔃';
        Const Char_Bandeira_triangular   = '🚩 ';
        Const Char_Ponto_Interrogacao    = '❓';
        Const Char_Ponto_Exclamacao      = '❗';
        Const Char_Dedo_Direita          = '👉';

        Const Char_Proxima_Faixa     = '⏭️';
        Const Char_AvancoRapido      = '⏩';
        Const Char_Retrocesso_Rapido = '⏪';
        Const Char_Ultima_Faixa      = '⏮️';
        Const Char_GoBof             = Char_Proxima_Faixa;
        Const Char_Next              = Char_AvancoRapido;
        Const Char_Prev              = Char_Retrocesso_Rapido;
        Const Char_GoEof             = Char_Ultima_Faixa;
        Const Char_Refresh           = Char_Seta_Cicle;


        {: A constante **@name** informa o nome do campo no Template.
           O nome do campo é passado após ^B e o mesmo não pode conter espaço
           em branco.

           - **EXEMPLO DE USO**

             ```pascal

                NewSitem(~Nome do produto: ~ SSSSSSSSSSSSSSSS`SSSSSSS^BNome_do_Produto,nil);

             ```
        }
        const CharFieldName     = ^B; //#2

        {: A constante **@name** é igual a CharFieldName, foi criada para facilitar seu uso.}                              
        Const ChFN = CharFieldName;//CharFieldName;

        {: A contante **@name** indica que o campo corrente possuem uma lista de opções 
           do mesmo tipo campo.

           - **EXEMPLO DE USO**

             ```pascal

                NewSItem('~Dia de vencimento:~\sssssssssss'+ChFN+'Dia'+
                          CreateOptions(2,NewSItem('Dia 10',
                                          NewSItem('Dia 15',
                                          NewSItem('Dia 20',
                                          NewSItem('Dia 25 e 26',
                                        nil)))))+
                          CharHint+'O template do campo deve ser do tamanho do maior item da lista.' +
                          '~ dias~',
                        nil);

             ```

           - **NOTA**
             - O template do campo deve ser do tamanho do maior item da lista.

        }
        Const CharListComboBox  = ^C;

        {: A contante **@name** é igual a CharListComboBox}
        Const ChLCB  = CharListComboBox;

        {: the same Date Field with a Day/Month/Year sequence
        }
        Const TypeDate        = '\ ZB'+^F+^U+AnsiChar(31)+#0+'/'+'ZB'+^U+AnsiChar(12)+#0+'/'+'ZB'+#0+^F;
        Const _TypeDate       = '\ ZB'+^F+^U+AnsiChar(31)+#0+'/'+'ZB'^U+AnsiChar(12)+#0+'/'+'ZB'{+#0}+^F;
        Const TypeHora        = '\ ZB'+^F+^U+AnsiChar(24)+#0+':'+'ZB'^U+AnsiChar(60)+#0+':'+'ZB'^U+AnsiChar(60)+#0+^F;
        Const FldMemo         = 'M';
        Const TypeMemo        = '\ZB'+^F+#0'ssssssssss'#0'ZZZZZZZL'#0'ZZZZW'#0'ZZZZW'+#0+^F; //:<Usado em conjunto com FldBLob
        Const CTypeReal       =  [fldRealNum,fldReal4,fldReal4P,fldRealNum_Positivo,fldExtended];
        Const CTypeAnsiChar   =  [fldAnsiChar,fldAnsiChar_Minuscula,fldAnsiCharVAL];
        Const CTypeString     =  [fldSTRNUM,fldSTR,fldSTR_Minuscula];
        Const CTypeInteger    =  [fldENUM,fldBOOLEAN,fldBYTE,fldSHORTINT,fldSmallWORD,fldSmallInt,fldLONGINT,FldRadioButton];
        Const CTypeDate       =  [fldData,fldLData,fld_LData,FldDateTimeDos];
        Const CTypeHour       =  [fldLHora,fld_LHora];
        Const CTypeBlob       =  [FldMemo,fldBLOb];
        Const CTypeOperator   =  [FldOperador];
        Const CTypeKnown      : AnsiCharSet = CTypeReal
                                              + CTypeAnsiChar
                                              + CTypeString
                                              + CTypeInteger
                                              + CTypeDate
                                              + CTypeHour
                                              + CTypeBlob
                                              + CTypeOperator;

     {$ENDREGION 'tvDMX Field access attributes' }

    public
      const efSync  = 0;  // exec_Sync //efSync; // Espera que o processo chamando termine
      const efAsync = 1;  // exec_AsyncResult //efAsync; // Não Espera que o processo chamando termine

    public const SW_SHOWNORMAL : integer = ord(swoShow);
    public Const Password_Admin : string = '123456';

      {:< 0 = Indica uso normal do produto; 1= Indica que a Password_admin esta logado}
    public Const Admin_Logado : SmallWord = 0;

    public
      //---------------------------------------------------------------------------
      {$REGION 'Constantes usadas para controle do cache de disco' }

         {: Indica se o arquivo e exclusivo. Usado em Set_FileModeDenyALL  }
         const FileModeDenyALL : Boolean = False;

         {: -  A constante @name dar opção para usar cache de disco ou não.

                   - **NOTA**
                     - Se **True** então executa executa **FlushDOSFile** apos atualização dos arquivos.
         }
         Const FlushBuffer     : Boolean = true;


         {: - A constante @name é usado para indicar a banco de dados MarIcarai se deve usar cache de disco ou não.
                   - **NOTA**
                     - Se **True** executa executa **SysFileFlushBuffers** após atualização dos arquivos.

         }
         Const FlushBuffer_Disk : Boolean = False;

         {: - A constante @name é usado para indicar ao banco de dados **MarIcarai** se deve usar cache de disco ou não.
                   - **NOTAS**
                     - False = habilita cache de gravação das transações
                     - True  = Desabilita cache de gravação das transações
         }
         Const FlushBuffer_Disk_Transaction : Boolean = False;

         {: - A constante @name habilita o loop TempoDeTentativas nas leitura e escritas ao arquivo.
         }
         Const OkTempoDeTentativas : Boolean = true;

         {: - A constante @name é o tempo em segundos de tentativos nos processos de
              abertura, leitura e gravação de arquivos.
         }
         Const TempoDeTentativas   : Longint = 30;

      {$ENDREGION}
      //---------------------------------------------------------------------------

      {: Último caractere digitado     }
      Const UAnsiChar : AnsiChar = ' ';

      {: Usado em readKey para capturar as Teclas Alt, Ctrl, Shift etc.}
      Const TeclaF    : SmallInt = 0;

       {: - A constante **@name** é usada para manter os dados do usuário logado ao sistema.

          - Id_branch       : 0; //Número da filial do usuário logado
          - Id_user         : 1; // Número do usuário Logado;
          - UserName        : 'PauloSSPacheco'; // Nome do usuário logado
          - FullUserName    : ''; //: Nome completo do usuário logado
          - password        : ''; //: Password do usuário logado
       }
       const Identification: TIdentification = (
                                              //: Número da filial do usuário logado
                                              Id_branch       : 0;
                                              //: Número do usuário Logado;
                                              Id_user         : 1;
                                              //: Nome do usuário logado
                                              UserName        : '';
                                              //: Nome completo do usuário logado
                                              FullUserName    : '';
                                              //: Password do usuário logado
                                              password        : '';
                                            );


      Const TimeCmTime : Longint = 10;


      {: - A constante pública global **@name** indica se o sistema deve executar a
           aplicação central caso a rotina atual tiver em loop aguardando alguma ação.
           - Exemplo: Tentando abrir um arquivo onde o mesmo se encontra dentro de uma transação.
      }
      const CTRL_SLEEP_ENABLE : Boolean = True;

      {: - A contante **@name** indica se deve ou não executar a aplicação principal;
           1. True : Processa as mensagem da aplicação gráfica quando necessário;
           2. False : ignora.
      }
      const FORMS_APPLICATION_PROCESS_MESSAGES : Boolean = false;

      {: - Se a constante **@name=True** indica que **FORMS_APPLICATION_PROCESS_MESSAGES=true** e o método
           **TForm_VCL_DmxEditor.ShowModal** está em execução.
      }
      const FORMS_APPLICATION_SHOW_MODAL       : Boolean = false;

      {: - A constante **@name** é usada para checar se um handle de um dispositivo é válido ou não
      }
      const HANDLE_INVALID = high(THandle);
      
      {- A constante **@name** é usada em writeln para passar a linha.
      }
      const LF = #10;
      const CR = #13;

      {: - A constantes **@name** é usado em **writeln** para passar a linha.
      }
      const New_Line = {$IFDEF WINDOWS} CR+LF {$ENDIF} {$IFDEF LINUX} LF {$ENDIF};


      //============================================================================
      {$REGION 'CONSTANTES PARA PARA OS MODOS DE ABERTURAS DO ARQUIVOS '}


        // fm= File open modes SysUtils

          {: - Abre um arquivo com acesso somente leitura.

             - Mapa de bits : 0 = Bit 0 desligado.

             - REFERÊNCIA:
               - [fmopenread](https://www.freepascal.org/docs-html/rtl/sysutils/fmopenread.html)
          }
          const fmOpenRead  = SysUtils.fmOpenRead  ;


          {: - Abre um arquivo com acesso somente gravação.

             - Mapa de bits : 1 = Bit 0 ligado

             - REFERÊNCIA:
               - [fmopenwrite](https://www.freepascal.org/docs-html/rtl/sysutils/fmopenwrite.html)
          }
          const fmOpenWrite = SysUtils.fmOpenWrite    ;

          {: - Abre um arquivo com acesso de leitura e gravação

             - Mapa de bits : 10 = Bit 1 ligado

             - REFERÊNCIA:
               - [fmopenreadwrite](https://www.freepascal.org/docs-html/rtl/sysutils/fmopenreadwrite.html)
          }
          const fmOpenReadWrite  = SysUtils.fmOpenReadWrite;

          // fm= Share modes  SysUtils

          {: - A Constante **@name** é usada na abertura do arquivo indicando no modo de compatibilidade com o DOS

             - Mapa de bits: 0 = bit 0(zero) desligado

             - REFERÊNCIA:
               - [fmshareexclusive](https://www.freepascal.org/docs-html/rtl/sysutils/fmsharecompat.html)
          }
          const fmShareCompat    = SysUtils.fmShareCompat   ;

            //:- Flag usado para tornar acesso ao arquivo no modo exclusivo.
            //:
            //: - **NOTA**
            //:   - Binário: 10000 = Bit 4 ligado
            //:   - As contantes usadas para abertura de arquivo da **unit SysUtils** é totalmente diferente das
            //:     constantes usadas na **unit system**, por isso o exemplo abaixo não funciona.
            //:
            //: - **REFERÊNCIA**:
            //:   - [fmshareexclusive](https://www.freepascal.org/docs-html/rtl/sysutils/fmshareexclusive.html)
            //:
            //:
            //:
            //: - EXEMPLO:
            //:
            //:   ```pascal
            //:
            //:      function TFormTests.fTest_Reset(Var f : file  ):longint;
            //:      Begin
            //:        AssignFile(f,'./doc/index.html');
            //:
            //:      {$i-}
            //:      Reset(f);
            //:     {$i+}
            //:      Result := IoResult;
            //:        If Result <> 0
            //:        then ShowMessage('Error: '+ErrorMessage(result));
            //:      end;
            //:
            //:      procedure TFormTests.Button_Test_ResetClick(Sender: TObject);
            //:        Var
            //:          f1,f2 : file;
            //:      begin
            //:        fileMode := fmOpenReadWrite or fmShareExclusive  or fmShareCompat
            //:
            //:        ShowMessage(IntToStr(fileMode));
            //:
            //:        if fTest_Reset(f1) = 0
            //:        Then fTest_Reset(f2);
            //:
            //:        closeFile(f1);
            //:        closeFile(f2);
            //:      end;
            //:
            //:   ```
          const fmShareExclusive = SysUtils.fmShareExclusive;

          {: - Bloqueie o arquivo para que outros processos possam apenas ler.

             - Mapa de Bit: 100000 = Bit 5 ligado.

             - REFERÊNCIA:
               - [fmsharedenywrite](https://www.freepascal.org/docs-html/rtl/sysutils/fmsharedenywrite.html)
          }
          const fmShareDenyWrite = SysUtils.fmShareDenyWrite;

          {: - Bloqueie o arquivo para que outros processos não possam ler.

             - Mapa de bits: 110000 = Bit 4 e 5 ligado.

             - REFERÊNCIA:
               - [fmsharedenyread](https://www.freepascal.org/docs-html/rtl/sysutils/fmsharedenyread.html)
          }
          const fmShareDenyRead  = SysUtils.fmShareDenyRead ;

          {: - Não bloqueie o arquivo.

             - Mapa de bits: 1000000 = Bit 6 ligado

             - REFERÊNCIA:
               - [fmsharedenynone](https://www.freepascal.org/docs-html/rtl/sysutils/fmsharedenynone.html)
          }
          const fmShareDenyNone  = SysUtils.fmShareDenyNone ;


          {: - A constante @name é usada em FileCreate se o sistema for linux.

             - **REFERÊNCIA**
               - https://www.gnu.org/software/libc/manual/html_node/Permission-Bits.html

          }
          {$IFDEF UNIX}
            const GLOBAL_RIGHTS = S_IRUSR or S_IWUSR or S_IRGRP or S_IWGRP or S_IROTH or S_IWOTH;
          {$ELSE}
            const  GLOBAL_RIGHTS = 0;
          {$ENDIF}

      {$ENDREGION }
      //============================================================================

      {****************************************************************************}
      {$REGION '---> CONSTANTES COM OS ATRIBUTOS ARQUIVOS E DIRETÓRIOS USADOS NAS PESQUISAS DE ARQUIVOS'}

        {: - O atributo **@name** indica que o arquivo é somente para leitura.

           - **REFERÊNCIA**
             - https://www.freepascal.org/docs-html/rtl/sysutils/fareadonly.html
             - https://www.freepascal.org/docs-html/rtl/sysutils/findfirst.html
           - **NOTA**
              - Usado em TSearchRec e FindFirst
        }
        const faReadOnly   = SysUtils.faReadOnly  ;

        {: - O atributo **@name** indica que o arquivo é um diretório.

           - **REFERÊNCIA**
             - https://www.freepascal.org/docs-html/rtl/sysutils/fadirectory.html
             - https://www.freepascal.org/docs-html/rtl/sysutils/findfirst.html

           - **NOTA**
              -  Usado em TSearchRec e FindFirst

           - **EXEMPLO**

             ```pascal

               procedure TFormTests.Button_GetInfoFileClick(Sender: TObject);

                 function GetInfoFile(FileName:string ; out info : TSearchRec): Integer;

                 begin
                    Result := FindFirst(FileName,faDirectory,Info);
                    if Result = 0
                    then Begin
                           ShowMessage('O Diretório '+fileName+' encontrado.');
                         end
                    else begin
                           ShowMessage('O diretório '+fileName+' não encontrado.');
                         end;
                 end;

                 var
                  Info: TSearchRec;
                  err : integer;
               begin
                 err := GetInfoFile(ExpandFileName('..'),info);
                 if err = 0 then
                 Begin
                   showMessage(intToStr(info.Attr));
                   FindClose(Info);
                 end;
               end;

             ```

        }
        const faDirectory  = SysUtils.faDirectory ;

        {: - O atributo **@name** indica que é uma arquivo normal.

          - **REFERÊNCIA**
             - https://www.freepascal.org/docs-html/rtl/sysutils/fanormal.html

          - **NOTA**
            - Usado em FindFirst para indicar que arquivos normais devem ser incluídos no resultado.
        }
        const faNormal     = SysUtils.faNormal    ;

        {: - O atributo **@name** indica que corresponder a qualquer arquivo

          - **REFERÊNCIA**
             -  https://www.freepascal.org/docs-html/rtl/sysutils/faanyfile.html

          - **NOTA**
            - Use este atributo na chamada FindFirst para localizar todos os arquivos correspondentes.
        }
        const faAnyFile    = SysUtils.faAnyFile   ;

        {: - O atributo **@name** indica que o bit do arquivo está definido.
          - **REFERÊNCIA**
             - https://www.freepascal.org/docs-html/rtl/sysutils/faarchive.html

          - **NOTA**
            - Significa que o arquivo tem o conjunto de bits de arquivo. Usado em TSearchRec e FindFirst
        }
        const faArchive    = SysUtils.faArchive   ;

      {$ENDREGION}
      {***************************************************************************}

      //*************************************************************************
      {$REGION 'CONSTANTES DE ACESSO A ARQUIVO PELA FUNÇÃO FILE SEEK'}
          // fs=File seek origins

          {: - O mapa de bits **@name** indica ao **TFiles.FileSeek** que o deslocamento é relativo ao primeiro byte do arquivo.
               Esta posição é baseada em zero. ou seja, o primeiro byte está no deslocamento 0 (zero).
          }
          const fsFromBeginning = SysUtils.fsFromBeginning;

          {: - O mapa de bits **@name** indica ao **TFiles.FileSeek** que o deslocamento é relativo à posição atual.
          }
          const fsFromCurrent   = SysUtils.fsFromCurrent  ;

          {: -  O mapa de bits **@name** indica ao **TFiles.FileSeek** que o deslocamento é relativo ao final do arquivo.
                Isso significa que o deslocamento só pode ser zero ou negativo neste caso.
          }
          const fsFromEnd       = SysUtils.fsFromEnd      ;
      {$ENDREGION}
      //*************************************************************************

      //*************************************************************************
      {$REGION 'CONSTANTES GLOBAIS PUBLICAS COM NÚMERO DOS POSSÍVEIS ERROS'}

       const
         ArquivoNaoEncontrado2                   = 002;
         PathNaoEncontrado                       = 003;
         muitosArquivosAbertoSimultaneamente     = 004;
         AcessoNegado5                          = 005;
         Seek_fora_da_faixa_do_arquivo           = 007;
         ErroDeMemoria                           = 008;
         ErroFormatoInvalido                     = 011;
         NaoPodeExecutarTrocaDeNomesEntreDiscos  = 017;
         ArquivoNaoEncontrado18          = 018;
         DiscoProtegidoContraEscrita     = 019;
         UnidadeDesconhecida             = 020;
         DriveNaoEstaPronto              = 021;
         ErroDeDadosCRC                  = 023;
         Falha_Geral                     = 031;
         AcessoNegado32                  = 032;
         ErroViolacaoDeLacre             = 033;
         MudancaDeDiscoInvalida          = 034;


         Campo_nao_existe_no_registro_do_arquivo = 037;
         Tipo_em_memoria_incompativel_com_o_tipo_do_campo_no_arquivo = 038;
         Erro_de_sintaxe_na_expressao    = 039;
         Tipos_de_campos_incompativeis   = 040;
         Tipos_de_campo_nao_conhecido    = 041;
         Campo_em_duplicidade_na_estrutura_da_tabela = 42;

         Arquivo_ja_existe               = 080;
         NaoPodeCriarDiretorio           = 082;
         ParametroInvalido               = 087;

         ErroDeLeituraEmDisco            = 100;
         ErroDeGravacaoEmDisco           = 101;
         ErroArquivoFechado              = 103;
         ErroArquivoFechadoParaEntrada   = 104;
         ErrorArquivoFechadoParaSaida    = 105;
         Formato_numerico_invalido_ou_incompativel   = 106;
         DiscoCheio                                  = 107;
         ErroDeEscritaNoDispositivoDeSaidaImpressora = 160;
         ErroFaltaHardware                               = 162;
         Err_Division_by_zero                            = 200;
         ErrorNaChecagemDeFaixa                          = 201;
         Objeto_Nao_Inicializado                         = 210;
         Chamada_a_um_Metodo_Abstrato                    = 211;
         Stream_Registration_error                       = 212;
         Collection_Index_Out_of_range                   = 213;
         ErrorTentativa_de_abrir_um_arquivo_aberto       = 217;
         Erro_Tentativa_de_excluir_um_registro_excluido  = 218;
         Erro_Tentativa_de_ler_um_registro_excluido      = 219;
         Erro_outro_usuario_da_rede_alterou_o_registro   = 220;
         Estrutura_da_tabela_esta_danificada             = 221;
         Tentativa_de_gravar_em_um_registro_compartilhado_sem_que_o_mesmo_esteja_travado = 222;
         AppCli_Evento_Executado_Por_Outro_Processo = 223;
         AppCLi_Svr_Api_Nao_Instalado               = 224;
         TTransaction_Commit_esperado               = 225;
         Erro_Expression_is_not_valid               = 226;
         Erro_Many_Parenthesis                      = 227;
         Erro_Many_operators                        = 228;
         Erro_Operador_aritmetico_esperado          = 229;
         Err_CalcVal_Not_Ready_Number               = 230;
         {Erros de indices do Turbo Acces}
           REC_TOO_LARGE                              = 231;
           REC_TOO_SMALL                              = 232;


         KeyTooLarge                                = 233;
         RecSizeMismatch                            = 234;
         KeySizeMismatch                            = 235;
         MemOverflow                                = 236;
         ArqIndexInconsistente                      = 237; //:< turbo access. Erros Db e DaAccess


         O_gerente_de_transacoes_esta_inativo       = 238;
         Erro_Excecao_inesperada                    = 239;
         Acesso_negado_ao_arquivo_por_falta_de_autorizacao_de_seu_superior_imediato = 240;
         Registro_nao_localizado                    = 241; //:> Erro retornados nas buscas de registros
         O_Evento_OnEnter_Retornou_falso            = 242;
         O_Evento_OnExit_Retornou_falso             = 243;

         {: Erro gerado ao tentar incluir um registro sem que o mesmo não esteja no modo appending}
         Attempt_to_insert_record_without_is_selected = 244;
         attempt_to_edit_a_record_not_selecting       = 245;

      {$ENDREGION}
      //*************************************************************************

      {**************************************************************************}
      {$REGION  'VARIÁVEIS GLOBAIS  PÚBLICAS                                   ' }


        {: - Após uma chamada ao sistema operacional a variável publica global **@name**
            guarda **0 (zero)** se sucesso ou o **código do erro** se houve fracasso.
          - A função **@name** é atualizada em SetResult.
        }
        const LastError : SmallInt =  0;

        {: - A variável pública global **@name** indica o status da última operação de acesso
            ao banco de dados Turbo Access.
            - Nota: Sua função é semelhante a **LastError**;
        }
        const TaStatus     : SmallInt = 0;


        {: - A variável pública global **@name** indica se houver erro na última ação.
            - Nota: Atualizada em **SetResult** onde **@name=true** houve sucesso e **@name=false** houve fracasso.
        }
        const OK  : Boolean = True;

        {: A constante pública **@name** guarda o modo padrão de abertura dos arquivos;

           - **NOTAS**:
             - Usada em **FileOpen** e **FileCreate**.
             - O mapa de bits usado **FileMode** é inicializado com:
               - Const **FileMode** : word = fmOpenReadWrite;

           - **EXEMPLO**

              ```pascal
                    procedure TMi_Rtl_Tests.Action_test_FileCreateExecute(Sender: TObject);

                      var
                        aHandle,aHandle2,aHandle3 :  TMI_ui_types.THandle;
                        err:integer;
                        s : AnsiString;
                    begin
                      with TMI_ui_types do
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
                ```
         }
        const FileMode : word    = fmOpenReadWrite ;

        {: - A function **SetFileMode** salva a variável **@name** atual antes de modificar **fileMode**.;
        }
        const FileModeAnt : Word  = 0;

        {: A constante pública **@name** guarda o modo padrão de compartilhamento na abertura dos arquivos;

           - **NOTAS**:
             - Usada em **FileOpen** e **FileCreate**.
             - O mapa de bits usado **ShareMode** é inicializado com:
               - Const **ShareMode** : cardinal = fmShareCompat or fmShareDenyNone;

           - **EXEMPLO**

               ```pascal

                     procedure TMi_Rtl_Tests.Action_test_FileCreateExecute(Sender: TObject);

                       var
                         aHandle,aHandle2,aHandle3 :  TMI_ui_types.THandle;
                         err:integer;
                         s : AnsiString;
                     begin
                       with TMI_ui_types do
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
               ```
        }
        const ShareMode : Cardinal = fmShareCompat or fmShareDenyNone;


        Const  MaxDirSizeFat32  = 65534;
        Const  MaxDirSizeNTFS   = 2294967295;

        {: - Máximo de pastas dos sistemas de arquivo do linux é limitada ao espaço em disco.
        }
        Const  MaxDirSizeLinux  = MaxDirSizeNTFS;

        {$IFDEF Windows}
          const  MaxDirSize : word = MaxDirSizeNTFS;
        {$ELSE}
          const  MaxDirSize : word = MaxDirSizeLinux;
        {$ENDIF}

      {$ENDREGION}
      {**************************************************************************}

      {**************************************************************************}
      {$REGION  'Constantes usadas por TvDmx - Construtor de Templates            ' }
          {: - A contante **@name** é usada na construção de formulários de entrada automaticamente.

               - **NOTA**
                 - **true** o formulário de entrada de dados insere uma linha em branco automaticamente.
          }
          Const Auto_Add_Line_Default:Boolean = false;

          Const Comma     : char  =   ','; //:< - Separador de milhar nas mascaras internas ao campo.
          Const showComma : char  =   '.'; //:< - Separador de números na visualização }

          Const DecPt      : char =   '.'; //:< - Ponto decimal usado nas mascaras internas ao campo.
          Const showDecPt  : Char =   ','; //:< - Char decimal point display }

          Const CloseParenthesis = ')';
          Const OpenParenthesis  = '(';

          {: A constante **@name** indica qua a sequẽncia seguite é um campo de dados}
          Const CharDelimiter_0 = #0;

          {: A constante **@name** indica qua a sequẽncia seguite é um campo de dados}
          Const CharDelimiter_1 = '\';

          {: A constante **@name** separa nome da tabela do nome do campo}
          Const CharDelimiter_2 = '|';

          Const CharDelimiter_3  = '~'; // Em Template os textos dentro de ~ serão tratados como textos estáticos

          {: A constante **@name** inicializa o registro com zeros}
          Const CharShowzeroes = ^Z;

          {: Se o campo for numérico, preencha com '#0'(AccNormal) se for alfanumérico, preencha com ' ' AccNormal}
          Const CharFillvalue = ^V;

          {: A contante **@name** torna o campo invisível}
          Const CharAccHidden = ^H;
          Const ChAH          = CharAccHidden;

          {: A constante **@name** indica que o campo não pode receber o foco. }
          Const CharAccSkip   = ^S;

          {: A constante **@name** é igual a CharAccSkip}
          Const ChAS   = CharAccSkip;

          {: A constante *@name** informa que o tipo de acesso ao campo é somente para leitura e não pode ser editado.}
          Const CharAccReadOnly = ^R;

          {: A constante **@name** é igual a CharAccReadOnly}
          Const ChARO   = CharAccReadOnly;


          {: A constante **@name** avisa para iniciar com #0 todos os campos}
          Const CharAllZeroes = ^A;

          {: O caractere de controle **@name** é usado pelo método **TUiDmxScroller_sql.CreateTables**
             para indicar que o caractere seguinte tem um sinalizador usado para criar tabelas no banco de dados.

             - **SINALIZADORES**
               - 0 = **pfInUpdate** : As alterações no campo devem ser propagadas para o banco de dados..

               - 1 = **pfInWhere** : O campo deve ser usado na cláusula WHERE de uma instrução de
                                     atualização no caso de upWhereChanged.

               - 2 = **pfInKey** : Campo é um campo chave e usado na cláusula WHERE de uma instrução de atualização.

               - 3 = **pfHidden**          : O valor deste campo deve ser atualizado após a inserção.

               - 4 = **pfRefreshOnInsert** : O valor deste campo deve ser atualizado após a inserção.

               - 5 = **pfRefreshOnUpdate** : O valor deste campo deve ser atualizado após a atualização.

               - 6 = **pfInKeyPrimary** : Campo é um campo chave primária e usado na cláusula WHERE de uma instrução de atualização.

               - 7 = **pfInAutoIncrement** : Campo é um campo autoincremental e usado em uma instrução de atualização.

             - **NOTAS**
               - O campos com access = ^S automaticmanente o atributo MIProviderFlag terá [pfHidden]
               - O valor defaults de MiProviderFlags := [pfInUpdate,pfInWhere];
               - **Campos de chave primária**
                 - Ao atualizar registros, TSQLQuery precisa saber quais campos
                   compõem a chave primária que pode ser usada para atualizar o registro
                   e quais campos devem ser atualizados: com base nessas informações, ele constrói
                   um comando SQL UPDATE, INSERT ou DELETE.

                 - A construção da instrução SQL é controlada pela propriedade UsePrimaryKeyAsKey
                   e pelas propriedades ProviderFlags .

                 - A propriedade Providerflags é um conjunto de 3 sinalizadores:
                   - pfInkey : O campo faz parte da chave primária
                   - pfInWhere : O campo deve ser utilizado na cláusula WHERE das instruções SQL.
                   - pfInUpdate : Atualizações ou inserções devem incluir este campo. Por padrão,
                     ProviderFlags consiste apenas em pfInUpdate .

                 - **REFERÊNCIA**
                   - [Working_With_TSQLQuery](https://wiki.freepascal.org/Working_With_TSQLQuery)

          }
          Const CharProviderFlag  = ^P;
          Const CharpfInUpdate = ^P'0'; {:< As alterações no campo devem ser propagadas para o banco de dados..}
          Const CharpfInWhere  = ^P'1'; {:< O campo deve ser usado na cláusula WHERE de uma instrução de
                                           atualização no caso de upWhereChanged.}
          Const CharPfInKey    = ^P'2';  {:< Campo é um campo chave e usado na cláusula WHERE de uma instrução de atualização.}
          Const CharPfHidden   = ^P'3';  {:< O valor deste campo deve ser atualizado após a inserção.}
          Const CharPfRefreshOnInsert = ^P'4'; {:< O valor deste campo deve ser atualizado após a inserção.}
          Const CharPfRefreshOnUpdate = ^P'5'; {:< O valor deste campo deve ser atualizado após a atualização.}
          Const CharPfInKeyPrimary    = ^P'6';  {:< Campo é um campo chave primária e usado na cláusula WHERE de uma instrução de atualização.}

          Const CharPfInKeyPrimaryAutoIncrement = ^P'7';  {:< Campo é um campo autoincremental e usado em uma instrução de atualização.}

          {: O caractere **@name** é ussado para criar restrições entre o corrente campo e uma campo de
             uma tabela estrangeira.

             - A sequência esperada após ^F corresponde a NomeDaTabela,TipoDeRelacionamento,campo1;campo2;...campoN
               - Tipo de relacionamento pode ser:
                 - 0 - UmParaUm 0 //Impor_Integridade_Referencial=True
                                1 //Impor_Integridade_Referencial=False

                 - 1 - UmParaN  2 //Impor_Integridade_Referencial=True
                                3 //Impor_Integridade_Referencial=False

                 - 2 - NParaUm, 4 // Find  Se Impor_Integridade_Referencial=True
                                5 // Searc Se Impor_Integridade_Referencial=False

                 - 3 - NParaN   6 //Impor_Integridade_Referencial=True
                                7 //Impor_Integridade_Referencial=False
          }
          Const CharForeignKey  = ^F ;

          {:< Produz um erro indicando que a exclusão ou atualização criaria
              uma violação de restrição de chave estrangeira.
              Se a restrição for adiada, esse erro será produzido no
              momento da verificação da restrição se ainda existirem linhas de referência.
              Esta é a ação padrão.}
          Const CharFk_No_Action = ^F'0' ;

          {:< Produz um erro indicando que a exclusão ou atualização criaria
              uma violação de restrição de chave estrangeira. Isso é o
              mesmo que, **NO ACTION** exceto que o cheque não é adiável.}
          Const CharFk_Restrict = ^F'1' ;


          {:< Exclua todas as linhas que fazem referência à linha excluída
              ou atualize os valores das colunas de referência para os novos
              valores das colunas referenciadas, respectivamente.}
          Const CharFk_Cascade  = ^F'2' ;

          {:<  Defina a(s) coluna(s) de referência como nula.}
          Const CharFk_Set_Null  = ^F'3' ;


          {:< A contante **@name** defina a(s) coluna(s) de referência para seus valores
              padrão. (Deve haver uma linha na tabela referenciada que
              corresponda aos valores padrão, se eles não forem nulos,
              ou a operação falhará.}
          Const CharFk_Set_Default  = ^F'4' ;

          {:O A constante **@name** é usado para documentar o campo e indica que todo o texto até o próximo
            caractere de controle será o conteúdo do campo HelpCtx_Hint.
            - **EXEMPLO**
               ```pascal

                Resourcestring
                  tmp_Alunos_Idade = '\BB'+ChFN+'idade'+CharUpperlimit+#64+
                                     CharHint+'A idade do aluno. Valores válidos 1 a 64'+
                                     CharHintPorque+'Este campo é necessário para que se agrupe o alunos baseado em sua faixa etária'+
                                     CharHintOnde+'Ele será usado pelo coordenador ao classificar a turma';


                  tmp_Alunos_Matricula = \IIII'+ChFN+'matricula'+CharHint+'A matricula do aluno é um campo sequencial e calculado ao incluir o registro';

                  tmp_Alunos = '~     Idade:~'+tmp_Alunos_Idade+lf+
                                   '~ Matricula:~'+tmp_Alunos_Matricula+lf;
          }
          Const CharHint       = '^';
          Const ChH = CharHint;

          Const CharHintPorque = '^0'; //:< A contante **@name** informa que todo texto até o próximo delimitador contém informações para o campo HelpCtx_Porque
          Const CharHintOnde   = '^1'; //:< A contante **@name** informa que todo texto até o próximo delimitador contém informações para o campo HelpCtx_Onde

          Const Delimiters : AnsiCharSet = [CharDelimiter_0,
                                            CharDelimiter_1,
                                            CharDelimiter_2,
                                            CharDelimiter_3,
                                            CharExecAction,
                                            CharFieldName,
                                            CharUpperlimit,
                                            CharAccHidden,
                                            CharAccSkip,
                                            CharAccReadOnly,
                                            CharAllZeroes,
                                            CharProviderFlag,
                                            CharForeignKey,
                                            CharHint,
                                            fldAPPEND,
                                            fldSItems,
                                            CharListComboBox
                                            ];


          //Const CharHintComo   = '^4'; //:< Todo o texto até o próximo caractere de controle será o campo HelpCtx_Como
          //Const CharHintQuais  = '^5'; //:< Todo o texto até o próximo caractere de controle será o campo HelpCtx_Quais
          //Const CharHintHistorico = '^6'; //:< Todo o texto até o próximo caractere de controle será o campo HelpCtx_Historico
          //
          const SinalDireita   : Boolean = False;
          const SinalDeMaisAtivo : Boolean = False; //:< - Mostra o sinal de + a direita dos campos numéricos

 //         type TMaskIsNumber = TAnsiCharSet;
          const MaskIsNumber : TAnsiCharSet = [];// Em implamentation inicia com os tipos de campos numéricos.

      {$ENDREGION}
      {**************************************************************************}

      Const Delta_Locate   : Longint  = 100;
      Const ConvertIdioma_Nil : TConvertIdioma = nil;

      Const //As 3 constantes abaixo são usadas para identar textos para que o formato seja igual na plataforma console, gui e html.
         Html_Nivel1 = '<font size="6">&#9642;</font>';//  ou &#9689;
         Html_Nivel2 = '<font size="5">&#9642;</font>'; // ou &#9679;
         Html_Nivel3 = '<font size="4">&#9642;</font>'; // ou &#9642;
         Html_Nivel4 = '<font size="2">&#9642;</font>'; // Alt 250

         Char_Nivel1 = Ansichar(254);        // gui = '•' ; console = #254; html = Html_Nivel1   ou &#9689;   <br>
         Char_Nivel2 = Ansichar(207);//'¤' ; // gui = #207; console = #207; html = Html_Nivel2 ou &#9679;         <br>
         Char_Nivel3 = Ansichar(248);//'°' ; // gui = #248; console = #248; html = Html_Nivel3 ou &#9642;         <br>
         Char_Nivel4 = Ansichar(250);//'·' ; // gui = #250; console = #250; html = Html_Nivel4   Alt 250           <br>

      const Array_Of_Char : TArray_Of_Char =
       (
        (Asc_Ingles :'a';Asc_GUI :'á';Asc_HTML :'&aacute;'), // 00 a Minuscolo com agudo
        (Asc_Ingles :'a';Asc_GUI :'â';Asc_HTML :'&acirc;'),  // 01 a Minuscolo com circonflexo
        (Asc_Ingles :'a';Asc_GUI :'à';Asc_HTML :'&agrave;'), // 02 a Minuscolo com crase
        (Asc_Ingles :'a';Asc_GUI :'ã';Asc_HTML :'&atilde;'), // 03 a Minuscolo com til
        (Asc_Ingles :'A';Asc_GUI :'Á';Asc_HTML :'&Aacute;'), // 04 A Maiusculo com agudo
        (Asc_Ingles :'A';Asc_GUI :'À';Asc_HTML :'&Agrave;'), // 05 A Maiusculo com crase
        (Asc_Ingles :'A';Asc_GUI :'Â';Asc_HTML :'&Acirc;'),  // 06 A Maiusculo com circonflexo
        (Asc_Ingles :'A';Asc_GUI :'Ã';Asc_HTML:'&Atilde;'),  // 07 A Maiusculo com til
        (Asc_Ingles :'c';Asc_GUI :'ç';Asc_HTML :'&ccedil;'), // 08 c cedilha Minuscolo
        (Asc_Ingles :'C';Asc_GUI :'Ç';Asc_HTML :'&Ccedil;'), // 09 C cedilha maiusculo
        (Asc_Ingles :'e';Asc_GUI :'é';Asc_HTML :'&eacute;'), // 10 e Minuscolo com agudo
        (Asc_Ingles :'e';Asc_GUI :'ê';Asc_HTML :'ê'),        // 11 e Minuscolo com circonflexo
        (Asc_Ingles :'E';Asc_GUI :'É';Asc_HTML :'&Eacute;'), // 12 E maiusculo com agudo
        (Asc_Ingles :'E';Asc_GUI :'Ê';Asc_HTML :'&Ecirc;'),  // 13 E maiusculo com circonflexo
        (Asc_Ingles :'i';Asc_GUI :'í';Asc_HTML :'&iacute;'), // 14 i Minuscolo com agudo
        (Asc_Ingles :'I';Asc_GUI :'Í';Asc_HTML :'&Iacute;'), // 15 I maiusculo com agudo
        (Asc_Ingles :'o';Asc_GUI :'ó';Asc_HTML :'ó'),        // 16 o Minuscolo com agudo
        (Asc_Ingles :'O';Asc_GUI :'Ó';Asc_HTML :'&Oacute;'), // 17 O maiusculo com agudo
        (Asc_Ingles :'o';Asc_GUI :'õ';Asc_HTML :'õ'),        // 18 o Minuscolo com til
        (Asc_Ingles :'O';Asc_GUI :'Õ';Asc_HTML :'Õ'),        // 19 O maiusculo com til
        (Asc_Ingles :'o';Asc_GUI :'ô';Asc_HTML :'ô'),        // 20 o Minuscolo com circonflexo
        (Asc_Ingles :'O';Asc_GUI :'Ô';Asc_HTML :'Ô'),        // 21 O maiusculo com circonflexo
        (Asc_Ingles :'u';Asc_GUI :'ú';Asc_HTML :'ú'),        // 22 u minusculo com agudo
        (Asc_Ingles :'U';Asc_GUI :'Ú';Asc_HTML :'&Uacute;'), // 23 U maiusculo com agudo
        (Asc_Ingles :'u';Asc_GUI :'ü';Asc_HTML :'&#252;'),   // 24 u minusculo com trema
        (Asc_Ingles :'U';Asc_GUI :'Ü';Asc_HTML :'&#220;'),   // 25 U maiusculo com trema
        (Asc_Ingles :'o';Asc_GUI :'º';Asc_HTML     :'º')     // 26 Simbolo para N º '&167;'
       );

      const PortaDaImpressora : tString = 'prn';
      const opcaoRedireciona : AnsiChar = 'I'; {< Defaust  = impressora }
      const RedirecionaImpressora  : boolean = false;
      const redirecionaImpNul      : Boolean = False;
      const NomeRedireciona        : PathStr = 'C:\Maricarai.Lst';

      {: Caso ApartirDeQuePagina > 1 então redireciona para NUL todas as paginas dos relatórios ate que ContaPagina seja =  ApartirDeQuePagina}
      const ApartirDeQuePagina     : Longint= 1;

      {: Pagina inicial na listagem }
      const PaginaInicial: Longint= 1;

      const contalinha   : Longint = 0;
      const contaPagina  : Longint= 1;


       {Comandos do Banco de dados}
        {O TVision V.20 usa no max 84

         Portanto posso usar de 85 a 100 ou seja 85+15
         Para comandos genericos.
         A documentacao recomenda usar 100 a 255

         Vou reservar para mim 85 a 109 para comandos Genericos que ncessitam ser
         desabilitados.

         A aplicacao usa de 110 a 255. Necessario para que se possa que o
         usuario pai possa desabilitar as opcoes dos filhos.
        }
        {TCmDb}
      const CmNulo                =          100 {<84};
      const CmDbNextRec           = CmNulo + 01;
      const CmDbPrevRec           = CmNulo + 02;
      const CmDbNextRecValid      = CmNulo + 03;
      const CmDbPrevRecValid      = CmNulo + 04;
      const CmDbFindRec           = CmNulo + 05;
      const CmDbSearchRec         = CmNulo + 06;
      const CmDbGoEof             = CmNulo + 07;
      const CmDbGoBof             = CmNulo + 08;
      const CmDbLocaliza          = CmNulo + 09; //Não precisa ser desabilitado
      const CmNewRecord           = CmNulo + 10;
      const CmZeroizeRecord       = CmNulo + 11;
      const CmEvaluateRecord      = CmNulo + 12;
      const CmEditDlg             = CmNulo + 13;
      const cmMyOK                = CmNulo + 14;
      const cmMyCancel            = CmNulo + 15;
      const cmPrint               = CmNulo + 16;
           //  cmHomePage            = CmNulo + 17; O comando CmHomePage nao precisa desabilitar.
      const CmImport              = CmNulo + 17;
      const CmProcess             = CmNulo + 18;
      const CmExecEndProc         = CmNulo + 19; //:<  Usado para acessar a pesquisa associado ao campo
      const CmExecComboBox        = CmNulo + 20; //:<  Usado para acessar a visao associada ao campo. Usado para visualizar CamposEnumerado e lista de forma geral
      const CmExecCommand         = CmNulo + 21; //:<  O comando vinculado ao campo focado e disparado para apliication.HanleEvent() se

      const CmCreate_Shortcut     = CmNulo + 22; //<  Cria um atalho do programa corrente no desktop do windows
                                                //<  e passa como parametro todas as tecla digitada entre o inicio e o fin da criação do atalho.
      const CmVisualizar          = CmNulo + 23;
      const CmExport_Stru         = CmNulo + 24; //<  Exporta a estrutura das consultas para o arquivo Schema.ini
      const CmExport              = CmNulo + 25; //<  Exporta a consulta seleciona para varios formatos de arquivos a serem implementados

         // ...
      const CmInt                 = CmNulo + 29;  {<= Limit dos comandos genericos que pode ser desabilitados}

      const TCmLivre    = [CmVisualizar..CmInt];



        const TCmCommands = [CmInt..255];
        const TCmDb       = [CmDbNextRec    ,
                             CmDbPrevRec    ,
                             CmDbNextRecValid,
                             CmDbPrevRecValid,
                             CmDbFindRec    ,
                             CmDbSearchRec  ,
                             CmDbGoEof      ,
                             CmDbGoBof      ,
                             CmDbLocaliza
                            ];
        const TCmDbView    = [cmMyOK                  ,
                              cmMyCancel               ,
                              CmEditDlg                ,
                              CmEvaluateRecord         ,
                              cmZeroizeRecord          ,
                              CmNewRecord,
                              CmProcess,
                              cmPrint,
                              CmExecEndProc,
                              CmExecComboBox
                           ];
        const TCmOutros        =[cmPrint];

      {********************************************************************}
        const CmNortSoft           = 50000; {<Camandos comuns que nao podem serem desabilitados}
        const CmDbAddRec           = CmNortSoft + 001;
        const CmDbDeleteRec        = CmNortSoft + 002;
        const CmDbGetRec           = CmNortSoft + 003;
        const CmDbPutRec           = CmNortSoft + 004;
        const CmDbUpdateRec        = CmNortSoft + 005;
        const CmDbSearchTop        = CmNortSoft + 006;
        const CmDbSearchKey        = CmNortSoft + 007;
        const CmDbUsedRecs_Valid    = CmNortSoft + 008;
        const CmOkEscrevaParametrosDosRelatorios = CmNortSoft + 009;
        const CmDbSelecionaIndice   = CmNortSoft + 010;
        const LivreCmVisualisa      = CmNortSoft + 011;
        const CmQuitInterno         = CmNortSoft + 012;
        const CmSobre               = CmNortSoft + 013;
        const CmDbOnEnter           = CmNortSoft + 014;
        const CmDbOnExit            = CmNortSoft + 015;
        const cmCores               = CmNortSoft + 016;
        const CmF7                  = CmNortSoft + 017;
        const CmDbLabel_DoubleClick = CmNortSoft + 018;
        const cmDbView_DoubleClick  = CmNortSoft + 019;
        const CmDbOrdemCressante    = CmNortSoft + 020;
        const CmDbOrdemDecrescente  = CmNortSoft + 021;
        const CmDbSelecColunaAtual  = CmNortSoft + 022;
        const CmMouseDownmbRightButton = CmNortSoft + 023; {<Gerado quando o botao do lado direito ‚ pressionado}
        const CmReindex             = CmNortSoft + 024;
        const CmCadastraImpressoraRede  = CmNortSoft + 025;
        const CmInfoSystem          = CmNortSoft + 026;{<Lista a rotina com as informacoes tecnicas do sistema}
        const cmPrintSemFormatar    = CmNortSoft + 027;{<Lista um arquivo texto sem formatacao de TvDmxReport}
        const CmDbDoBeforeInsert      = CmNortSoft + 028;
        const CmDbDoBeforePost        = CmNortSoft + 029;
        const CmDbDoBeforeDelete      = CmNortSoft + 030;
        const CmDbDoAfterInsert       = CmNortSoft + 031;
        const CmDbDoAfterPost         = CmNortSoft + 032;
        const CmDbDoAfterDelete       = CmNortSoft + 033;
        const CmTb_SelectRefCruzadaResume = CmNortSoft + 034;
        const CmTb_SelectSelect           = CmNortSoft + 035;
        const CmTb_SelectResume           = CmNortSoft + 036;
        const CmRegistroValido            = CmNortSoft + 037;
        const CmCopyTo                    = CmNortSoft + 038;
        const CmCadastraImpressoraLocal   = CmNortSoft + 039;
        const CmSetAppending              = CmNortSoft + 040;
        const CmStartTransaction          = CmNortSoft + 041;
        const CmCommit                    = CmNortSoft + 042;
        const CmRollback                  = CmNortSoft + 043;
        const CmOnCalcRecord_All          = CmNortSoft + 044; //<  Varre toda a tabela executando o evento OnCalcRecord
        const CmTime                      = CmNortSoft + 045; //<  Este comando faz com que o sistema dar um tempo de TimeCmTime.
        const cmEditaCores                = CmNortSoft + 046;
        const cmSalvaCores                = CmNortSoft + 047;
        const cmHomePage                  = CmNortSoft + 048;
        const CmDbPack                    = CmNortSoft + 049;

        const FirstCmdNum   =  4400;  { starting number for reserved commands }
        const cmDMX               = FirstCmdNum;
        const cmDMX_RollCall      = cmDMX +  1;
        const cmDMX_Ack           = cmDMX +  2;
        const cmDMX_FieldAltered  = cmDMX +  3;
        const cmDMX_Draw          = cmDMX +  4;
        const cmDMX_DrawData      = cmDMX +  5;
        const cmDMX_Lock          = cmDMX +  6;
        const cmDMX_LockData      = cmDMX +  7;
        const cmDMX_Unlock        = cmDMX +  8;
        const cmDMX_UnlockData    = cmDMX +  9;
        const cmDMX_FixSize       = cmDMX + 10;
        const cmDMX_SetupRecord   = cmDMX + 11;
        const cmDMX_WrongKey      = cmDMX + 12;
        const cmDMX_ZeroizeField  = cmDMX + 13;
        const cmDMX_ZeroizeRecord = cmDMX + 14;
        const cmDMX_Enter         = cmDMX + 15;
        const cmDMX_Left          = cmDMX + 16;
        const cmDMX_Right         = cmDMX + 17;
        const cmDMX_Home          = cmDMX + 18;
        const cmDMX_End           = cmDMX + 19;
        const cmDMX_goto          = cmDMX + 20;
        const cmDMX_NextRow       = cmDMX + 21;
        const cmDMX_Up            = cmDMX + 22;
        const cmDMX_Down          = cmDMX + 23;
        const cmDMX_PgUp          = cmDMX + 24;
        const cmDMX_PgDn          = cmDMX + 25;
        const cmDMX_ScreenTop     = cmDMX + 26;
        const cmDMX_ScreenBottom  = cmDMX + 27;
        const cmDMX_Top           = cmDMX + 28;
        const cmDMX_Bottom        = cmDMX + 29;
        const cmDMX_DoubleClick   = cmDMX + 30;  {< mouse was double-clicked }
        const cmDMX_RecIndClicked = cmDMX + 31;  {< record indicator was clicked }
        const cmDMX_Reset         = cmDMX + 32;  {< tvDMXCOL: reset size of collection }
        const cmDMX_ScrollBarChanged =cmDMX+33;  {< updates the TDmxLabels views }
        const cmDMX_InsertRec     = cmDMX + 34;  {< inserts a new record }
        const cmPRN_NewPage       = cmDMX + 40;  {< tvDMXREP: broadcast before new page }
        const cmPRN_EndPage       = cmDMX + 41;  {< tvDMXREP: broadcast before page end }
        const cmPRN_SetOptions    = cmDMX + 42;  {< tvDMXREP: open options window }
        const cmPRN_LineFeed      = cmDMX + 43;  {< tvDMXREP: line feed to printer }
        const cmPRN_FormFeed      = cmDMX + 44;  {< tvDMXREP: form feed to printer }
        const cmPRN_Reset         = cmDMX + 45;  {< tvDMXREP: reset printer }
        const cmUserScreen        = cmDMX + 51;  {< tvGizma: invokes User Screen }
        const cmToggleSound       = cmDMX + 52;  {< tvGizma: toggles BeepOn }
        const cmToggleVideo       = cmDMX + 53;  {< tvGizma: toggles video mode }
        const cmBeep              = cmDMX + 54;  {< tvGizma: beeps if BeepOn is TRUE }
        const cmChime             = cmDMX + 55;  {< tvGizma: broadcast every 30 minutes }
        const cmPromptMsg         = cmDMX + 56;  {< tvGizma: used by proc UserMessage }
        const cmBlinkMsg          = cmDMX + 57;  {< tvGizma: used by proc BlinkMessage }
        {Inicio NortSoft}
        const cmDbMX_GetBuffer    = cmDMX + 58;  {< Ler o buffer do registro do arquivo para  WorkingData}
        const cmDbMX_PutBuffer    = cmDMX + 59;  {< Grava o buffer de WorkingData para o registro do arquivo}
        {<Fin NortSoft}

      {: A contante **@name** contém o caractere separador de diretório.}
      public const DirectorySeparator :char = system.DirectorySeparator;   {'/' ou '\'}

      public var Lst : text ;static;

      {: - O evento @name é executado em CtrlSleep e deve ser iniciado para que possa
         processar as mensagens dos widgets que usão essa classe.
      }
      public const onProcessMessages : TOnProcedure = nil;

      {$Region Código do teclado}
      public const  kbNoKey = 0;

      {$EndRegion Código do teclado}


      {: Se MessageBoxOff = true então não mostra o dialogo e torna o comando defaust

         - Usada quando se quer despresar a ação do usuário e que ler os erros de um
           arquivo de erros. Normalmente deve ser usado nos programas controlados em linha de comando.
      }
      public const MessageBoxOff    : Boolean = false;

      public class function  CreateEnumField(ShowZ: boolean; AccMode,Default: LongInt;AItems: PSItem) : tString;
      public class function  CreateTSItemFields(ATemplates: PSItem) : tString;

    end;

    resourcestring //Padrão de código dos recursos é GUI.
      SCmDbNextRec          = 'Próximo registro';
      SCmDbPrevRec          = 'Registro Anterior';
      SCmDbNextRecValid     = 'Próximo registro válido';
      SCmDbPrevRecValid     = 'Registro válido anterior';
      SCmDbFindRec          = 'Atualiza o registro atual';
      SCmDbSearchRec        = 'SCmDbSearchRec';
      SCmDbGoEof            = 'Último registro';
      SCmDbGoBof            = 'Primeiro registro';
      SCmDbLocaliza         = 'Localiza registro';
      SCmNewRecord          = 'Novo registro';
      SCmZeroizeRecord      = 'Apaga o registro atual';
      SCmEvaluateRecord     = 'Grava o registro atual';
      SCmEditDlg            = 'Edita o registro atual';
      ScmMyOK               = 'Ok';
      ScmMyCancel           = 'Cancelar';
      ScmPrint              = 'Imprimir';
      SCmImport             = 'Importar';
      SCmProcess            = 'Processa';
      SCmExecEndProc        = 'SCmExecEndProc';  //:<  Usado para acessar a pesquisa associado ao campo
      SCmExecComboBox       = 'SCmExecComboBox'; //:<  Usado para acessar a visao associada ao campo. Usado para visualizar CamposEnumerado e lista de forma geral
      SCmExecCommand        = 'SCmExecCommand';  //:<  O comando vinculado ao campo focado e disparado para apliication.HanleEvent() se

      SCmCreate_Shortcut    = 'Cria atalho no desktop do windows'; //<  Cria um atalho do programa corrente no desktop do windows
                                                                  //<  e passa como parametro todas as tecla digitada entre o inicio e o fin da criação do atalho.
      SCmVisualizar         = 'Visualizar';
      SCmExport_Stru        = 'Exportar estrutura da tabela'; //:<  Exporta a estrutura das consultas para o arquivo Schema.ini
      SCmExport             = 'Exporta'; //:<  Exporta a consulta seleciona para varios formatos de arquivos a serem implementados


    {********************************************************************}
    //Padrão de código dos recursos é GUI.
      SCmDbAddRec             = 'Adicionar registro';
      SCmDbDeleteRec          = 'Apagar registro selecionado';
      SCmDbGetRec             = 'Ler registro selecionado';
      SCmDbPutRec             = 'Gravar registro selecionado';
      SCmDbUpdateRec          = 'Atualizar registro selecionado caso tenha sido alterado';
      SCmDbSearchTop          = 'Pesquisar primeira ocorrência a partir do topo da tabela';
      SCmDbSearchKey          = 'Pesquisar primeira ocorrência a partir do inicio da tabela';
      SCmDbUsedRecs_Valid     = 'CmDbUsedRecs_Valid';
      SCmOkEscrevaParametrosDosRelatorios = 'Escreva parâmetros dos relatórios';
      SCmDbSelecionaIndice    = 'Selecionar indice';
      SLivreCmVisualisa       = 'CmLivreCmVisualisa';
      SCmQuitInterno          = 'Quit interno';
      SCmSobre                = 'Sobre';
      SCmDbOnEnter            = 'CmDbOnEnter';
      SCmDbOnExit             = 'CmDbOnExit';
      ScmCores                = 'cmCores';
      SCmF7                   = 'Seleciona as opções para o campo selecionado';
      SCmDbLabel_DoubleClick  = 'CmDbLabel_DoubleClick';
      ScmDbView_DoubleClick   = 'cmDbView_DoubleClick';
      SCmDbOrdemCressante     = 'Ordem cressante';
      SCmDbOrdemDecrescente   = 'Ordem decrescente';
      SCmDbSelecColunaAtual   = 'CmDbSelecColunaAtual';
      SCmMouseDownmbRightButton = 'CmMouseDownmbRightButton'; {<Gerado quando o botao do lado direito ‚ pressionado}
      SCmReindex                = 'Cria indices dos arquivos';
      SCmCadastraImpressoraRede  = 'Cadastra impressora da rede';
      SCmInfoSystem            = 'Informações do sistema';{<Lista a rotina com as informacoes tecnicas do sistema}
      ScmPrintSemFormatar      = 'cmPrintSemFormatar';{<Lista um arquivo texto sem formatacao de TvDmxReport}
      SCmDbDoBeforeInsert      = 'CmDbDoBeforeInsert';
      SCmDbDoBeforePost        = 'CmDbDoBeforePost';
      SCmDbDoBeforeDelete      = 'CmDbDoBeforeDelete';
      SCmDbDoAfterInsert       = 'CmDbDoAfterInsert';
      SCmDbDoAfterPost         = 'CmDbDoAfterPost';
      SCmDbDoAfterDelete       = 'CmDbDoAfterDelete';
      SCmTb_SelectRefCruzadaResume = 'CmTb_SelectRefCruzadaResume';
      SCmTb_SelectSelect           = 'CmTb_SelectSelect';
      SCmTb_SelectResume           = 'CmTb_SelectResume';
      SCmRegistroValido            = 'Registro válido';
      SCmCopyTo                    = 'Copiar para';
      SCmCadastraImpressoraLocal   = 'Cadastra impressora local';
      SCmSetAppending              = 'CmSetAppending';
      SCmStartTransaction          = 'Inicia uma transação';
      SCmCommit                    = 'Confirma transação';
      SCmRollback                  = 'CmRollback';
      SCmOnCalcRecord_All          = 'Calcula todos os registros'; //<  Varre toda a tabela executando o evento OnCalcRecord
      SCmTime                      = 'Time'; //<  Este comando faz com que o sistema dar um tempo de TimeCmTime.
      ScmEditaCores                = 'Edita cores';
      ScmSalvaCores                = 'Salva cores';
      ScmHomePage                  = 'Gera documento no formato HTML do formulário atual';
      SCmDbPack                    = 'Pack';


      sErr201 = 'Erro: %d - O valor %s está fora da faixa permitida para o campo. Faixa: [%d .. %d ]';


implementation


class function  TConsts.CreateEnumField(ShowZ: boolean; AccMode,Default: Longint;AItems: PSItem) : tString;
begin
  {$IFDEF CPU32}
     Result := fldENUM + #0#0#0#0 + AnsiChar(ShowZ) + chr(AccMode) + IntToStr(Default);
     Move(AItems, Result[2], 4);
  {$ENDIF}
  {$IFDEF CPU64}
     Result := fldENUM + #0#0#0#0#0#0#0#0 + AnsiChar(ShowZ) + chr(AccMode) + IntToStr(Default);
     Move(AItems, Result[2], 8);
  {$ENDIF}
end;

class function  TConsts.CreateTSItemFields(ATemplates: PSItem) : tString;
  //var  S : tString;
begin
  {$IFDEF CPU32}
    Result := fldSItems + #0#0#0#0#0#0#0;
    Move(ATemplates, Result[2], 4);
  {$ENDIF}
  {$IFDEF CPU64}
    Result := fldSItems + #0#0#0#0#0#0#0#0#0#0#0;
    Move(ATemplates, Result[2], 4+4);
  {$ENDIF}
  //CreateTSItemFields := S;
end;

//Var D : TFormatSettings;

Initialization

  // Não posso fazer essa inicialização porque System.FileMode = 1 bytes apenas.
  System.FileMode := byte(TConsts.FileMode);

  with TConsts do
  begin
//    d := DefaultFormatSettings;

    decPt     := DefaultFormatSettings.DecimalSeparator;
    showDecPt := decPt;//DefaultFormatSettings.CurrencyDecimals;

    Comma     := DefaultFormatSettings.ThousandSeparator;
    showComma := Comma;
    //       showDecPt := Comma ; //Português


    {Analizar com mais detalhe se precisa permitir digitar ponto e inverter para virgula}
    //if decPt = '.'
    //then Begin
    //       Comma := ','; //Comma   := DefaultFormatSettings.ThousandSeparator;  ,
    //       showComma := decPt;  //Português
    //       showDecPt := Comma ; //Português
    //     end
    //else
    //if decPt = ',' // usuário entre com a virgula e o sistema mostra o ponto no lugar da virgula
    //then Begin
    //       Comma := '.';
    //       showComma := decPt;
    //       showDecPt := Comma ;
    //     end;
    //

    MaskIsNumber := [fldBYTE,fldSHORTINT,fldSmallWORD,
                     fldRealNum,fldSmallInt,fldLONGINT,
                     fldRealNum_Positivo,'z','Z',DecPt,showDecPt];  //fldSTRNUM é string e não número,
  end;


  

  //const MaskIsNumber : TMaskIsNumber = [fldBYTE,fldSHORTINT,fldSmallWORD,
  //                                    fldRealNum,fldSmallInt,fldLONGINT,
  //                                    fldRealNum_Positivo,'z','Z',DecPt,showDecPt];  //fldSTRNUM é string e não número,


end.



