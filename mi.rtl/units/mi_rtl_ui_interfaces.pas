{Documento tirado de: E:\PPacheco\Meus Sites\Estudos\Linguagens\HTML\Sintaxe das Tgs HTML\internetz_com - HTML Programming - HTML Basics -  HTML Elements.htm
}
unit mi_rtl_ui_interfaces;
{:< - A unit **@name** é usada para implementar as interfaces do pacote mi.ui com propopósito de permitir que
    se possa criar as interfaces com usuário independente do pacote gráfico instalado.

    - **NOTA**
      - O IDE Lazarus cria automaticamente o número da interface. Tecla: **Crt+Alt+G**
}

interface

  Const IITable : TGUID = '{937B4AC1-A9B5-437C-A2ED-7EFF6CEEA919}';
  Const IIInputText : TGUID = '{CBEFA72F-A283-4374-AED4-8A62C05335D9}';

Type

 // Tipos usados para gera documentação, baseado no conteúdo do campo selecionado.
   TEnum_HelpCtx_StrCurrentCommand_Topic_Content_run = (

 {Quando a tecla F1 é pressiona, o sistema executa com o browser o arquivo do topico cujo o nome é:
  GetHelpCtx_Path + HelpCtx_StrCurrentCommand+'.htm'+'#'+HelpCtx_StrCurrentCommand_Topic

NOTA:
  1 - Indica ao sistema, que o conteúdo do campo selecionado deve ser ignorado ao criar o arquivo de documento.

  2 - Caso o campo selecionado executar o método TDmxEditor.EditViewHelpCtx() com a opção HelpCtx_StrCurrentCommand_Topic_Content_run_Parameter_File,
      então todos os campos devem imprimir o valor corrente no documento criado.

Caso o campo selecionado executar o método TDmxEditor.EditViewHelpCtx() com a opção HelpCtx_StrCurrentCommand_Topic_Content_run_Parameter_File, então todos os campos devem imprimir o valor corrente no documento criado.

  3 - Caso o arquivo não exista, o sistema gera abaixo da Documentação do nome do campo selecionado, as seguintes informções:
      A lista de valores possiveis para o campos, caso o tipo seja enumerado (InputListBox, InputComoBox, InputSelect, InputChequeButton, InputRadioButton).
  }
      HelpCtx_StrCurrentCommand_Topic_Content_run_Parameter_Indefinido,

{ Quando a tecla F1 é pressiona, o sistema executa com o browser o arquivo do topico cujo o nome é:
  GetHelpCtx_Path + HelpCtx_StrCurrentCommand+'.htm'+'#'+HelpCtx_StrCurrentCommand_Topic+'_'+HelpCtx_StrCurrentCommand_Topic_Content

  Nota: Caso o arquivo não exista, o sistema gera abaixo da Documentação do nome do campo selecionado, as seguintes informções:
         1 - Conteudo do campo Selecionado com o rótulo Valor Corrente.
         2 - A lista de valores possiveis para o campos, caso o tipo seja enumerado (InputListBox, InputComoBox, InputSelect, InputChequeButton, InputRadioButton).
            ou lista o valor do campo selecionado de todos os registros do arquivo mais o conteudo dos campos vinculados ao compo corrente.
  }
       HelpCtx_StrCurrentCommand_Topic_Content_run_Parameter_indicator,


{ Quando a tecla F1 é pressiona, o sistema executa com o browser o arquivo do topico cujo o nome é:
  GetHelpCtx_Path + HelpCtx_StrCurrentCommand+'_'+HelpCtx_StrCurrentCommand_Topic+'_'HelpCtx_StrCurrentCommand_Topic_Content+'.htm'

  Nota 1:
    Caso o arquivo não exista, o sistema gera abaixo da Documentação do nome do campo selecionado, as seguintes informções:
      1 - Conteudo do campo Selecionado com o rótulo Valor Corrente.
      2 - A lista de valores possiveis para o campos, caso o tipo seja enumerado (InputListBox, InputComoBox, InputSelect, InputChequeButton, InputRadioButton).
            ou lista o valor do campo selecionado de todos os registros do arquivo mais o conteudo dos campos vinculados ao compo corrente.
  Nota 2 :
    Caso o arquivo não existe, o sistema criar um arquivo com o nome do conteúdo do campo selecionado, com objetivo de documentar
    o registro, baseado no conteúdo do campo. Obs: Criei esta opção para documentar as naturezas de operação (CFOP).

  }
       HelpCtx_StrCurrentCommand_Topic_Content_run_Parameter_File
      );
//
//TYPE
////+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//  ITable = Interface ;
//  IInputText = Interface;
//  IInputRadio = Interface;
//  IInputCheckbox = Interface;
//  IInputPassword = Interface;
//  IInputHidden  = Interface;
//  ISelect = Interface;
//
//
//  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//  IHTML_Base = Interface
//     ['{39755713-8C08-4C12-B8F0-B9E6B1EDF587}']
//     Function IsInputText: IInputText;
//     Function IsInputRadio: IInputRadio;
//     Function IsInputCheckbox:IInputCheckbox;
//     Function IsSelect:ISelect;
//     Function isInputPassword : IInputPassword ;
//     Function IsInputHidden : IInputHidden;
//
//   //Construção da Interface ITable
//     Function Get_ITable : ITable;
//     Property Table : ITable Read Get_ITable;
//
//    // Aqui deve conter os metodos e propriedades comuns a todas as interfaces.
//
//    //Construção da propriedade ID
//     Function GetID_Dynamic:AnsiString;
//     Property ID_Dynamic:AnsiString Read GetID_Dynamic;
//
//    //Construção da propriedade Name()
//     Function GetName():AnsiString;//=name specifies the name of this input object
//     Property Name:AnsiString read GetName;//=name specifies the name of this input object
//
//     //Construção da propriedade Alias
//     Function GetAlias() : AnsiString;
//     Procedure SetAlias(Const wAlias:AnsiString);
//     Property Alias : AnsiString read getAlias Write SetAlias;
//
//     //Construção da propriedade HTMLContent
//     Function GetHTMLContent() : AnsiString;//Retorna o html da class
//     Property HTMLContent : AnsiString read GetHTMLContent;
//
//     //Construção da propriedade NoTab()
//     Function GetNoTab():Variant;// specifies that this element is not part of the tabbing order
//     Property NoTab:Variant read GetNoTab;
//
//     //Construção da propriedade TabOrder()
//     Function GetTabOrder():Variant;//=n specifies the position of this element in the tabbing order
//     Property TabOrder:Variant Read GetTabOrder;
//
////Criação da propriedade Module. Obs: Nome do Módulo que está utilizando esta classe.
//      Function GetModule :Byte;
//      property Module: Byte read GetModule ;
//
////Criação da propriedade HelpCtx_StrModule. Obs: Nome do Módulo que está utilizando esta classe.
//      Function GetHelpCtx_StrModule :AnsiString;
//      property HelpCtx_StrModule: AnsiString read GetHelpCtx_StrModule ;
//
////Criação da propriedade HelpCtx_StrCommand. Obs: Nome do comando que está utilizando esta classe.
//      Function GetHelpCtx_StrCommand: AnsiString;
//      property HelpCtx_StrCommand: AnsiString read GetHelpCtx_StrCommand;
//
////Criação da propriedade HelpCtx_StrCommand_Topic
//      Function GetHelpCtx_StrCommand_Topic: AnsiString;
//      property HelpCtx_StrCommand_Topic: AnsiString read GetHelpCtx_StrCommand_Topic ;
//
//     //Construção da propriedade HelpCtx_Hint()
//     Function GetHelpCtx_Hint():AnsiString;// Documento do objeto.
//     Property HelpCtx_Hint:AnsiString Read GetHelpCtx_Hint;
//
//     //Construção da propriedade elpCtx_StrCurrentCommand_Topic_Content()
//     Function GetHelpCtx_StrCurrentCommand_Topic_Content_Run():TEnum_HelpCtx_StrCurrentCommand_Topic_Content_run;// Documento do objeto.
//     Property HelpCtx_StrCurrentCommand_Topic_Content_Run:TEnum_HelpCtx_StrCurrentCommand_Topic_Content_run Read GetHelpCtx_StrCurrentCommand_Topic_Content_Run;
//
////Criação da propriedade HelpCtx_StrCurrentCommand_Topic
//     Function Get_Ok_HelpCtx_StrCurrentCommand_Topic_Content_run_Parameter_File:Boolean;
//     Procedure Set_Ok_HelpCtx_StrCurrentCommand_Topic_Content_run_Parameter_File(a_Ok_HelpCtx_StrCurrentCommand_Topic_Content_run_Parameter_File:Boolean);
//     property Ok_HelpCtx_StrCurrentCommand_Topic_Content_run_Parameter_File: Boolean read Get_Ok_HelpCtx_StrCurrentCommand_Topic_Content_run_Parameter_File write Set_Ok_HelpCtx_StrCurrentCommand_Topic_Content_run_Parameter_File ;
//
//
//     //Construção da propriedade elpCtx_StrCurrentCommand_Topic()
//     Function GetHelpCtx_StrCurrentCommand_Topic:AnsiString;// Documento do objeto.
//     Property HelpCtx_StrCurrentCommand_Topic:AnsiString Read GetHelpCtx_StrCurrentCommand_Topic;
//
//     //Construção da propriedade elpCtx_StrCurrentCommand_Topic_Content()
//     Function GetHelpCtx_StrCurrentCommand_Topic_Content():AnsiString;// Documento do objeto.
//     Property HelpCtx_StrCurrentCommand_Topic_Content:AnsiString Read GetHelpCtx_StrCurrentCommand_Topic_Content;
//
////Criação da propriedade HelpCtx_Historico
//      Function GetHelpCtx_Historico : AnsiString;
//      property HelpCtx_Historico : AnsiString read GetHelpCtx_Historico;
//
////Criação da propriedade HelpCtx_Porque
//      Function GetHelpCtx_Porque : AnsiString;
//      property HelpCtx_Porque : AnsiString read GetHelpCtx_Porque ;
//
////Criação da propriedade HelpCtx_Onde
//      Function GetHelpCtx_Onde : AnsiString;
//      property HelpCtx_Onde : AnsiString read GetHelpCtx_Onde ;
//
////Criação da propriedade HelpCtx_Como
//      Function GetHelpCtx_Como : AnsiString;
//      property HelpCtx_Como : AnsiString read GetHelpCtx_Como ;
//
////Criação da propriedade HelpCtx_Quais
//      Function GetHelpCtx_Quais : AnsiString;
//      property HelpCtx_Quais : AnsiString read GetHelpCtx_Quais ; //< NortSoft Obs: Texto com uma breve descrição do objeto.
//
//  end;
//
//  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//
//  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//  ITable = Interface(IHTML_Base)
//     ['{937B4AC1-A9B5-437C-A2ED-7EFF6CEEA919}']
//     Function TabIndex:Longint; //< Retorna o numero de ordem do controle no grupo.
//
//     // Propriedade acao.
//     Function GetAcao():AnsiString; //Retorna o link da ação da classe
//     Property  Acao : AnsiString Read GetAcao;
//
//     {$Region  '  Cosntrução do Nome da Tabela '}
//          //Construção da propriedade Name()
//           Function GetName_ITable():AnsiString;
//           Property NameTable:AnsiString read GetName_ITable;//= Nome da tabela
//     {$EndRegion  '  Cosntrução do Nome da Tabela '}
//
//     {$Region '  Construção do propriedade CountField'}
//         Function GetCountField: Longint;
//         PROPERTY CountField   : Longint READ GetCountField ;
//     {$EndRegion 'Construção do propriedade CurrentField_ITable '}
//
//     {$Region '  Construção do propriedade CurrentField_ITable'}
//         Function GetCurrentField_ITable : IHTML_Base;
//         Procedure SetCurrentField_ITable(wNrCurrentField : IHTML_Base);
//         PROPERTY CurrentField_ITable    : IHTML_Base READ GetCurrentField_ITable WRITE SetCurrentField_ITable;
//     {$EndRegion 'Construção do propriedade CurrentField_ITable '}
//
//     {$Region '  Construção do propriedade NrCurrent'}
//         Function GetNrCurrent : Longint;
//         Procedure SetNrCurrent(wNrCurrent : Longint);
//         PROPERTY NrCurrent    : Longint READ GetNrCurrent WRITE SetNrCurrent;
//     {$EndRegion '  Construção do propriedade NrCurrent'}
//
//         function GetHelpCtx_Path: AnsiString;
//         function GetHelpCtx_Doc_HTML: AnsiString;
//
//
////     function ExecViewHelpCtx:Word;
////     function EditViewHelpCtx:Word;
//
//
//     //===============================================================================================
//     {$Region '//*** CONSTRUÇÃO DAS PROPRIEDADES E MÉTODOS DE ACESSO AOS REGISTROS DA TABELA****'}
//     //===============================================================================================
//         Function goBof : Boolean; // Posiciona no inicio do bloco de registro do tipo default
//         Function GoEof : Boolean; // Posiciona no fin do bloco de registro do tipo default
//
//    //Construção da propriedade okBof
//         Procedure SetOkBof(aOkBof:Boolean);
//         function GetOkBof:Boolean;
//         Property OkBof    : Boolean read GetOkBof write SetOkBof;
//
//    //Construção da propriedade okEof
//         function GetOkEof:Boolean;
//         Procedure SetOkEof(aOkEof:Boolean);
//         Property okEof    : Boolean read GetOkEof write SetOkEof;
//
//    //Metodos de navegação na tabela
//         Function NextRec  : Boolean; // Posiciona no proximo registro do tipo default
//         Function PrevRec  : Boolean; // Posiciona no registro anterior do tipo default
//
//         Function GetRec:Boolean;     // Ler o registro selecionado.
//         Function PutRec:Boolean;     // Grava o registro selecionado.
//
//     {$EndRegion '//*** CONSTRUÇÃO DAS PROPRIEDADES E MÉTODOS DE ACESSO AOS REGISTROS DA TABELA****'}
//     //===============================================================================================
//
//      function FieldByName_HTML_Base(aNomeDoCampo: AnsiString): IHTML_Base;
//      function FieldByNumber_HTML_Base(aIndex: Integer): IHTML_Base;
//
//      Procedure GetBuffer;
//      Procedure PutBuffer;
//
//
////Propriedade
//
//  End;
//  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//    IInputText = Interface(IHTML_Base)
//     ['{CBEFA72F-A283-4374-AED4-8A62C05335D9}']
//
//     {<input type=text> - Defines an input Field on a form of type text.}
//
//{$REGION '---> InputText doc.'}
//{          Objeto Input TEXT
//          ------------------
//          É o principal objeto para entrada de dados.
//          Suas principais propriedades são: type, size, maxlength, name e value.
//
//          type=text : Especifica um campo para entrada de dados normal
//          size      : Especifica o tamanho do campo na tela.
//          maxlength : Especifica a quantidade máxima de caracteres permitidos.
//          name      : Especifica o nome do objeto
//          value     : Armazena o conteúdo do campo.
//
//          Os eventos associados a este objeto são: onchange, onblur, onfocus e onselect.
//
//          Ex:
//          <form name="TText">
//          <p>Entrada de Texto
//              <input type=text size=20 maxlength=30 name="CxTexto" value=""
//                      onchange="alert ('Voce digitou ' + CxTexto.value)">
//          </p>
//          </form>
//       }
//
//{$ENDREGION}
//
//        //Construção da propriedade Value
//       Function GetValue_IInputText():Variant;//=string value passed to form processing application
//       Procedure SetValue_IInputText(wValue:Variant);
//       Property Value:Variant read GetValue_IInputText Write SetValue_IInputText;
//
//     //Construção da propriedade MaxLength()
//      Function GetMaxLength():Variant;//=n specifies the maximum number of AnsiCharacters
//      Property MaxLength:Variant read GetMaxLength;
//
//     //Construção da propriedade Size()
//      Function GetSize():Variant;//=n specifies the number of AnsiCharacters to display
//      Property Size:Variant read GetSize;
//
//      {$REGION ' ---> Property vidis_OnEnter : Boolean '}
//      Function  Getvidis_OnEnter : Boolean;
//      Procedure Setvidis_OnEnter (avidis_OnEnter : Boolean );
//                    ///<since>
//                    ///  . Propriedade vidis_OnEnter : Boolean
//                    ///  . Objetivo: Usado para evitar reentrancia do evento DoOnEnter()
//                    ///</since>
//        property  vidis_OnEnter: Boolean Read Getvidis_OnEnter   Write  Setvidis_OnEnter;
//      {$ENDREGION}
//
//      {$REGION ' ---> Property vidis_OnExit : Boolean '}
//      Function  Getvidis_OnExit : Boolean;
//      Procedure Setvidis_OnExit (avidis_OnExit : Boolean );
//                    ///<since>
//                    ///  . Propriedade vidis_OnExit : Boolean
//                    ///  . Objetivo: Usado para evitar reentrancia do evento DoOnExit()
//                    ///</since>
//        property  vidis_OnExit: Boolean Read Getvidis_OnExit   Write  Setvidis_OnExit;
//      {$ENDREGION}
//
//
//      procedure DoOnEnter(Sender: TObject);
//      procedure DoOnExit(Sender: TObject);
//
//      procedure Select;
//
//    End;
//  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//    IInputRadio = Interface(IHTML_Base)
//    ['{B553965B-B733-4F0E-9787-C5D1B69C7C1C}']
//  //===================================================================================
//  {$Region '  Documento do IInpuRadio'}
//
//  //<intype=radio> - Defines an input Field on a form of type radio.
//
//  {<
//
//    Objeto Input RADIO
//    ------------------
//
//        São objetos que permitem ao usuário a escolha de apenas uma alternativa, diante de uma série de opções.
//        Suas principais propriedades são: name, value e checked.
//
//        name : Especifica o nome do objeto. Para caracterizar uma mesma série de opções,
//               todos os objetos desta série têm que ter o mesmo "name".
//        value : Especifica o valor que será enviado ao "server" se o objeto estiver ligado (checked).
//                Caso seja omitido, será enviado o valor default "on" . Esta propriedade também serve para
//                ativar comandos lógicos, testando-se a condição de "checked".
//        checked : Especifica que o objeto inicialmente estará ligado
//
//        Para utilização deste objeto é importante o conhecimento de outras propriedades associadas:
//
//        Objeto.length          : Retorna a quantidade de opções existentes na lista
//        Objeto.[index].value   : retorna o texto (value) associado a cada opção
//        Objeto.[index].checked : retorna verdadeiro ou falso
//
//        O único evento associado a este objeto é onclick.
//
//        Ex. No exemplo abaixo temos dois set's de objetos radio. O primeiro tem o objetivo
//            de mudar a cor de fundo do documento atual. O segundo tem o objetivo
//            levar informações ao "server".
//
//        <p>Radio</p>
//        <p>
//          <input type=radio name="Rad" value="1" onclick="document.bgColor='green'"     > Fundo Verde
//          <input type=radio name="Rad" value="2" onclick="document.bgColor='blueviolet'"> Fundo Violeta
//          <input type=radio name="Rad" value="3" onclick="document.bgColor='#FFFF00'"   > Fundo Amarelo
//        </p>
//        <p>
//          <input type=radio         name ="Rad2" value="1" > Solteiro
//          <input type=radio         name ="Rad2" value="2" > Casado
//          <input type=radio checked name ="Rad2" value="3" > Tico Tico
//        </p>
//
//  }
//
//  {$EndRegion '  Documento do IInpuRadio'}
//  //===================================================================================
//
//      //=======================================================
//      {$Region '  Construção da propriedade Lenght'}
//      {
//       Objetivo: Retorna o numero de items da lista onde os itens devem ser acessados com index 0 a count-1
//      }
//      Function GetCount_InputRadio:Integer;
//      Property Length : Integer Read GetCount_InputRadio;
//
//      {$EndRegion '  Construção da propriedade Lenght'}
//
//      //=======================================================
//      {$Region '  Construção da propriedade Value'}
//      {Objetivo: Ler o label associado a opção ou trocar seu valor.
//
//       - Sintaxe: Setando = Value[1] = 'Sim'; Value[2] = 'Nao'; Value[1] = 'Yes'
//                  Lendo   = If FMaiucula(Value[1]) = 'SIM' Then;
//      }
//
//      Function GetValue_InputRadio(aItem: Variant):AnsiString;
//      Procedure SetValue_InputRadio(aItem: Variant;aValue:AnsiString);
//      Property Value[Index: Variant]:AnsiString read GetValue_InputRadio Write SetValue_InputRadio;//=string value passed to form processing application
//
//      {$EndRegion '  Construção da propriedade Value'}
//
//      //=======================================================
//      {$Region '  Construção da propriedade Checked'}
//
//          { Objetivo:
//              Selecionar um item da lista de opções ou checar se a opção está selecionada
//
//            Sintaxe: 1 - If Checked[1] then ...;
//                     2 - Checked[1] := True ...;
//          }
//
//          Function GetChecked_InputRadio( aItem: Integer):Boolean;
//          Procedure SetChecked_InputRadio( aItem : Integer;aValue:Boolean);
//          property Checked[Index: Integer]: Boolean read GetChecked_InputRadio write SetChecked_InputRadio;
//
//      {$EndRegion '  Construção da propriedade Checked'}
//      //=======================================================
//
//      //=======================================================
//      {$Region 'Construção da propriedade Item_Focused :Longint'}
//      //Nota: Retorna o numero do item Selecionado
//      Function get_Item_Focused_InputRadio:Longint;
//      Property Item_Focused : Longint Read Get_Item_Focused_InputRadio;
//      {$EndRegion 'Construção da propriedade Item_Focused :Longint'}
//      //=======================================================
//
//      //=======================================================
//      {$Region 'Construção da propriedade Value_Focused :AnsiString'}
//      //Nota: Retorna o label associado a Item_Focused
//      Function Get_Value_Focused_InputRadio:AnsiString;
//      Property Value_Focused : AnsiString Read Get_Value_Focused_InputRadio;
//      {$EndRegion 'Construção da propriedade Value_Focused :AnsiString'}
//      //=======================================================
//
//    End;
//  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//    IInputCheckbox = Interface(IHTML_Base)
//    ['{591A0C92-F48F-4BF0-AAE7-7F48B05FEB7F}']
//              //=====================================================================================
//              {$Region '//*** Documento de IINputCheckBox ***'}
//
//             //<input type=checkbox>  - Defines an input Field on a form of type checkbox
//            (*<
//                Objeto Input CHECKBOX
//                ---------------------
//
//                    São objetos que permitem ao usuário ligar ou desligar uma determinada opção.
//
//                    Suas principais propriedades são: name, value e checked.
//
//                    name   : Especifica o nome do objeto
//                    value  : Especifica o valor que será enviado ao "server" se o objeto estiver ligado (checked).
//                             Caso seja omitido, será enviado o valor default "on" .
//                             Esta propriedade também serve para ativar comandos lógicos, testando-se a condição de "checked".
//                    checked : Especifica que o objeto inicialmente estará ligado
//
//                    O único evento associado a este objeto é onclick.
//
//                    Ex:
//                    No exemplo abaixo, criaremos um objeto input.text e três objetos checkbox.
//                    O primeiro checkbox, quando ativado, transformará o texto em caracteres minúsculos.
//                    O segundo checkbox, quando ativado, transformará o texto em caracteres maiúsculos.
//                    O terceiro checkbox, quando ativado, dará um aviso do conteúdo que será recebido pelo "server"
//                    caso o formulário seja submetido para este.
//
//                    <SCRIPT>
//                    function AltMaiusc () {
//                        document.TCheck.Muda.value = document.TCheck.Muda.value.toUpperCase()
//                        document.TCheck.Opt1.checked = false
//                    }
//                    function AltMinusc () {
//                       document.TCheck.Muda.value = document.TCheck.Muda.value.toLowerCase()
//                       document.TCheck.Opt2.checked = false
//                    }
//                    </SCRIPT>
//
//                    <p>
//                    <form name="TCheck">
//                      Muda Case <input type=text size=20 maxlength=20 name="Muda">
//                    </p>
//                    <p>
//                      Minusculo  <input type=checkbox name="Opt1" value="1" checked onclick="if (this.checked){ AltMinusc()} ">
//                      Maiusculo  <input type=checkbox name="Opt2" value="2" onclick="if (this.checked){ AltMaiusc() } ">
//                      Demo valor <input type=checkbox name="Opt3"onclick="if (Opt3.checked) {alert ('Server recebera = ' + Opt3.value) } ">
//                    </p>
//                    </form>
//
//                    Existe ainda uma outra forma de manipular este objeto, em forma de array, que é a seguinte:
//                    form.elements[index].propriedade.
//                    Esta não é uma boa forma porque o index é único dentro de um formulário,
//                    exigindo muito cuidado quando se acrescenta ou se deleta um objeto, pois,
//                    neste caso, haverá um natural deslocamento do index, podendo comprometer a lógica.
//
//            *)
//              {$EndRegion '//*** Documento de IINputCheckBox ***'}
//              //=====================================================================================
//
//       //======================================================================================
//       {$Region '//*** Construção da propriedade Length  ***' }
//       //======================================================================================
//
//          {
//           Objetivo: Retorna o numero de items da lista onde os itens devem ser acessados com index 0 a count-1
//          }
//          Function GetCount_InputCheckbox:Integer;
//          Property Length : Integer Read GetCount_InputCheckbox;
//
//       {$EndRegion '//*** Construção da propriedade Count ***' }
//       //======================================================================================
//
//       //======================================================================================
//       {$Region '//*** Construção da propriedade Value  ***' }
//       //======================================================================================
//
//            {
//             Objetivo: Ler o label associado a opção ou trocar seu valor.
//
//             - Sintaxe: Setando = Value[1] = 'Sim'; Value[2] = 'Nao'; Value[1] = 'Yes'
//                        Lendo   = If FMaiucula(Value[1]) = 'SIM' Then;
//            }
//            Function GetValue_InputCheckbox(aItem: Integer):AnsiString;
//            Procedure SetValue_InputCheckbox(aItem: Integer;aValue:AnsiString);
//            Property Value[Index: Integer]:AnsiString read GetValue_InputCheckbox Write SetValue_InputCheckbox;//=string value passed to form processing application
//
//       {$EndRegion '//*** Construção da propriedade Value  ***' }
//       //======================================================================================
//
//       //======================================================================================
//       {$Region '//*** Construção da propriedade Checked  ***' }
//       //======================================================================================
//
//          {Construção da propriedade Checked - Sintaxe: 1 = If Checked[1] then; 2 = Checked[1] := True.
//           Objetivo: Selecionar um item da lista de opções ou checar se a opção está selecionada
//          }
//          Function GetChecked_InputCheckbox( aItem: Integer):Boolean;
//          Procedure SetChecked_InputCheckbox( aItem : Integer;aValue:Boolean);
//          property Checked[Index: Integer]: Boolean read GetChecked_InputCheckbox write SetChecked_InputCheckbox;
//
//       {$EndRegion '//*** Construção da propriedade Checked  ***' }
//       //======================================================================================
//
//       //======================================================================================
//       {$Region '//*** Construção da propriedade Item_Focused :Longint ***'}
//       //======================================================================================
//
//          //ATENÇÃO: Não implementado como é pra ser.
//          //         O Correta é retorna todos os número estão ligados ou seja igual a 1;
//
//          //Nota: Retorna o numero do item Selecionado
//  //        Function Get_Item_Focused_InputCheckbox:Longint;
//  //        Property Item_Focused : Longint Read Get_Item_Focused_InputCheckbox;
//
//       {$EndRegion '//*** Construção da propriedade Item_Focused :Longint ***'}
//       //======================================================================================
//
//       //======================================================================================
//        {$Region '//*** Construção da propriedade Value_Focused :AnsiString ***'}
//       //======================================================================================
//
//            //ATENÇÃO: Não implementado como é pra ser.
//            //         O Correta é retorna todos as stringas cujo os bits estejão ligados ou seja igual a 1;
//
//            //Nota: Retorna o label associado a Item_Focused
//  //          Function Get_Value_Focused_InputCheckbox:AnsiString;
//  //          Property Value_Focused : AnsiString Read Get_Value_Focused_InputCheckbox;
//
//        {$EndRegion '//*** Construção da propriedade Value_Focused :AnsiString ***'}
//       //======================================================================================
//    End;
//  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//    ISelect = Interface(IHTML_Base)
//    ['{8D3583C2-4F09-4106-BD7F-6BA55DF50A51}']
//            //======================================================================================
//            {$Region '// *** Documento de ISelect *** '}
//   //<select> ... </select> - Defines a multiple choice menu within a form. Usado para campos Enumerados
//  (*
//      Objeto SELECT
//          É um objeto para entrada de opções, onde o usuário, a partir de uma lista
//          de alternativas, seleciona uma ou mais opções.
//          Suas principais propriedades são: name, size, value e multiple.
//
//          name     : Especifica o nome do objeto
//          size     : Especifica a quantidade de opções que aparecerão na tela simultaneamente
//          value    : Associa um valor ou string para cada opção (opcional)
//          multiple : Especifica a condição de múltipla escolha (usando-se a tecla Ctrl)
//
//          Para utilização deste objeto é importante o conhecimento de outras propriedades associadas:
//
//          Objeto.length                  : Retorna a quantidade de opções existentes na lista
//          Objeto.selectedindex           : Retorna o "index" do objeto selecionado (primeiro = 0)
//          Objeto.options[index].text     : retorna o texto externo associado a cada opção
//          Objeto.options[index].value    : retorna o texto interno (value) associado a cada opção
//          Objeto.options[index].selected : retorna verdadeiro ou falso
//
//          Os eventos associados a este objeto são: onchange, onblur e onfocus.
//
//          Ex1:
//          Neste exemplo é importante observar os seguintes aspectos:
//          a) A lista permite apenas uma seleção
//          b) A quarta opção aparecerá inicialmente selecionada (propriedade "selected")
//          c) Não utilizamos a propriedade "value". Assim, a propriedade "text" e a propriedade "value"
//              passam a ter o mesmo valor, ou seja, o valor externo que aparece na tela.
//          .
//          <script>
//            function Verselect(Campo)
//            {
//              Icombo = Campo.selectedIndex
//              alert ("Voce escolheu " + Campo.options[Icombo].text)
//            }
//         </script>
//
//          <p>
//            Objeto Select
//            <select name="Combo1" size=1 onchange="Verselect(Combo1)">
//              <option>Opcao 1
//              <option>Opcao 2
//              <option>Opcao 3
//              <option selected> Opcao 4 (recomendada)
//              <option>Opcao 5
//              <option>Opcao 6
//            </select>
//          </p>
//
//          Ex2:
//
//          Neste exemplo é importante observar os seguintes aspectos:
//            a) A lista permite múltiplas seleções
//
//            b) Utilizamos a propriedade "value". Assim as propriedades "text" e "value"
//               têm valores diferentes: text retornará Escolha 1 a Escolha 4 e value retornará List1 a List4.
//
//            c) O parâmetro passado, quando da ocorrência do evento onblur, foi this.
//               Esta diretiva significa que estamos passando este objeto.
//          .
//          <script>
//            function Vermult(Lista)
//            {
//              var opcoes = ""
//              for (i = 0 ; i < Lista.length ; i++)
//              {
//                if (Lista.options[i].selected)
//                {
//                opcoes += (Lista.options[i].value + ", ")
//                }
//              }
//              alert ("As opcoes escolhidas foram : " + opcoes)
//            }
//          </script>
//
//          <p>
//            Objeto Select2
//              <select name="Combo2" size=4 multiple onblur="Vermult(this)">
//                <option value="List1">Escolha 1 </option>
//                <option value="List2">Escolha 2 </option>
//                <option value="List3">Escolha 3 </option>
//                <option value="List4">Escolha 4 </option>
//              </select>
//          </p>
//  *)
//  {$EndRegion '// *** Documento de ISelect *** '}
//
//            //======================================================================================
//       //    Function GetMultiple():AnsiString;// allow multiple selections
//
//       //======================================================================================
//       {$Region '//*** Construção da propriedade ISelect.GetCount_Select  ***' }
//       //======================================================================================
//
//          {Construção da propriedade Count de campos enumerados
//           Objetivo: Retorna o numero de items da lista onde os itens devem ser acessados com index 0 a count-1
//          }
//          Function GetCount_Select:Variant;
//          Property length : Variant Read GetCount_Select;
//
//       {$EndRegion '//*** Construção da propriedade ISelect.GetCount_Select  ***' }
//       //======================================================================================
//
//       //======================================================================================
//       {$Region '//*** Construção da propriedade ISelect.GetSize_Select  ***' }
//       //======================================================================================
//
//           //Número de Linhas a ser mostrada no box. Usado em campos enumerados.
//           Function GetSize_Select():Variant;//=n specifies the number of options to display
//
//       {$EndRegion '//*** Construção da propriedade ISelect.GetSize_Select  ***' }
//       //======================================================================================
//
//       //======================================================================================
//       {$Region '//*** Construção da propriedade ISelect.Value  ***' }
//       //======================================================================================
//
//            {Construção da propriedade Value
//             Objetivo: Ler o label associado a opção ou trocar seu valor.
//
//             - Sintaxe: Setando = Value[1] = 'Sim'; Value[2] = 'Nao'; Value[1] = 'Yes'
//                        Lendo   = If FMaiucula(Value[1]) = 'SIM' Then;
//            }
//            Function GetValue_Select(aItem: Integer):AnsiString;
//            Procedure SetValue_Select(aItem: Integer;aValue:AnsiString);
//            Property Value[Index: Integer]:AnsiString read GetValue_Select Write SetValue_Select;//=string value passed to form processing application
//
//       {$EndRegion '//*** Construção da propriedade ISelect.Value  ***' }
//       //======================================================================================
//
//       //======================================================================================
//       {$Region '//*** Construção da propriedade ISelect.Checked  ***' }
//       //======================================================================================
//
//            { Sintaxe: 1 = If Checked[1] then; 2 = Checked[1] := True.
//              Objetivo: Selecionar um item da lista de opções ou checar se a opção está selecionada}
//            Function GetChecked_Select( aItem: Integer):Boolean;
//            Procedure SetChecked_Select( aItem : Integer;aValue:Boolean);
//            property Checked[Index: Integer]: Boolean read GetChecked_Select write SetChecked_Select;
//
//       {$EndRegion '//*** Construção da propriedade ISelect.Checked  ***' }
//       //======================================================================================
//
//       //======================================================================================
//       {$Region '//*** Construção da propriedade ISelect.Item_Focused  ***' }
//       //======================================================================================
//
//            //Nota: Retorna o numero do item Selecionado
//            Function Get_Item_Focused_Select:Longint;
//            Property Item_Focused : Longint Read Get_Item_Focused_Select;
//
//       {$EndRegion '//*** Construção da propriedade ISelect.Item_Focused  ***' }
//       //======================================================================================
//
//       //======================================================================================
//       {$Region '//*** Construção da propriedade ISelect.Value_Focused  ***' }
//       //======================================================================================
//
//            //Nota: Retorna o label associado a Item_Focused
//            Function Get_Value_Focused_Select:AnsiString;
//            Property Value_Focused : AnsiString Read Get_Value_Focused_Select;
//
//       {$EndRegion '//*** Construção da propriedade ISelect.Value_Focused  ***' }
//       //======================================================================================
//
//    End;
//  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//    ITextArea = Interface(IInputText)// ['{D9EDBFE4-41BD-4D91-A2BF-F11D82E7DBC9}']
//    ['{81AC488B-E8D3-41C4-8623-378E0653EA7D}']
//{$REGION '---> TextArea Doc.'}
//    {
//        Objeto TEXTAREA
//        ---------------
//
//          É um objeto para entrada de dados em um campo de múltiplas linhas. Suas
//          principais propriedades são: name, rows e cols.
//
//          name : Especifica o nome do objeto
//          rows : Especifica a quantidade de linhas que aparecerão na tela
//          cols : Especifica a quantidade de caracteres que aparecerão em cada linha
//          value : Acessa o conteúdo do campo via programação.
//
//          Os eventos associados a este objeto são: onchange, onblur, onfocus e onselect.
//
//          Ex:
//          <form name="TesteTextarea">
//          <p>
//            Texto de Múltiplas Linhas
//            <textarea name="MultText" rows=2 cols=40>
//               Primeira linha do texto inicial
//               segunda linha do texto inicial
//            </textarea>
//          </p>
//    }
//
//{$ENDREGION}
//
//    end;
//  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//    //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//    IInputPassword = Interface(IInputText)
//    ['{20933564-ED1D-4158-A198-BAD2C0BDD1AA}']
//  {$REGION '---> InputPassword doc.'}
//    {<
//           <input type=password> - Defines an input Field on a form of type password.
//
//           Objeto Input PASSWORD
//           ---------------------
//             É o objeto para entrada de Senhas de acesso (password). Os dados digitados
//             neste objeto são criptografados e, só são interpretados (vistos) pelo "server",
//             por razões de segurança.
//             Suas principais propriedades são: type, size, maxlength, name e value.
//
//             type=password : Especifica um campo para entrada de senha. Os dados digitados são substituidos (na tela) por "*".
//             size          : Especifica o tamanho do campo na tela.
//             maxlength     : Especifica a quantidade máxima de caracteres permitidos.
//             name          : Especifica o nome do objeto
//             value         : Armazena o conteúdo digitado no campo.
//
//             Os eventos associados a este objeto são: onchange, onblur, onfocus e onselect.
//
//             Ex:
//             <form name="TPassword">
//             <p>Entrada de Senha
//                 <input type=password size=10 maxlength=10 name="Senha" value="">
//             </p>
//             </form>
//     }
//
// {$ENDREGION}
//    End;
//  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//    IInputHidden = Interface(IInputText)
//    ['{33F08C50-3D16-4119-9CB2-CA98D3713619}']
//{$REGION '---> InputHidden Doc.'}
//    {<
//      <input type=hidden> - Defines an input Field on a form of type hidden.
//
//      Objeto Input HIDDEN
//      --------------------
//
//        É um objeto semelhante ao input text, porém, invisível para o usuário. Este objeto
//        deve ser utilizado para passar informações ao "server" (quando o formulário for submetido)
//        sem que o usuário tome conhecimento. Suas propriedades são: name e value.
//
//        name  : Especifica o nome do objeto.
//        value : Armazena o conteúdo do objeto
//
//        Ex:
//        <form name="THidden">
//           <input type=hidden size=20 maxlength=30 name="HdTexto" value="" >
//        </form>
//
//    }
//
//{$ENDREGION}
//    End;
//  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//    IOptions = Interface(IHTML_Base)
//    ['{4547EABE-005E-482A-8E21-9C8F686DB288}']
//     //<option> ... </option> - Define an option within a <SELECT> item in a form
//      Function GetSelected():AnsiString;// make this item initially selected
//    End;
//  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//    IInputButton = Interface(IHTML_Base)
//    ['{14423D1B-317B-4E23-A47E-E333C5D468A7}']
//   //<input type=button> -  Defines an input Field on a form of type button.
//
//{$REGION '---> InputButton  Doc.'}
//    {
//        Objeto Input BUTTON
//            Este objeto tem por finalidade criar um botão ao qual se possa atrelar
//            operações lógicas, a serem executadas quando o mesmo receber um click.
//
//            Suas propriedades são: name e value.
//
//            name  : Especifica o nome do objeto.
//            value : Especifica o nome que aparecerá sobre o botão
//
//            O único evento associado a este objeto é onclick.
//
//            Ex.
//            <p>
//            <form method="POST" name="TstButton">
//               Digite um Texto
//                  <input type=text size=30 maxlength=30 name="Teste" value="">
//            </p>
//            <p>
//               Click no Botao
//                  <input type=button name="Bteste" value="Botao de teste"
//                          onclick="alert ('Voce digitou: ' + TstButton.Teste.value)">
//            </p>
//            </form>
//
//    }
//
//    (*
//    <html lang="pt-BR"> <head>
//    <meta http-equiv="Content-Language" content="pt-br">
//    <meta http-equiv="Content-Type" content="text/html; AnsiCharset=windows-1252">
//    <title>Teste da função Submit_form </title>
//    </head> <bodY>
//    <script> //function submit_form(form,btn)
//    /* By: Paulo Pacheco em 09/08/2006
//       OBJETIVO: Submeter um formulário ao servidor da seguinte forma:
//                  O nome do script é passado em form.action.
//            A lista de parametros da ação é passado por : btn.action
//
//       A propriedade name dos botões esperado:
//          1 = novo
//        2 = gravar
//        3 = excluir
//        4 = sair
//        5 = imprimir
//        6 = cacelar. Deve dar um resert no formulário e retorna true  e nao submeter
//        7 = finalizar
//        8 = primeiro
//        9 = proximo
//       10 = anterior
//       11 = ultimo
//       12 = editar
//    */
//    function submit_form(form,btn)
//    { var waction = " ";
//        if (( btn.name == "novo" ) ||
//          ( btn.name == "gravar" ) ||
//        ( btn.name == "excluir" ) ||
//        ( btn.name == "pesquisar" ) ||
//        ( btn.name == "sair" ) ||
//        ( btn.name == "editar" ) ||
//        ( btn.name == "imprimir" ) ||
//        ( btn.name == "cancelar" ) ||
//        ( btn.name == "finalizar" ) ||
//        ( btn.name == "cancelar" ) ||
//        ( btn.name == "primeiro" ) ||
//        ( btn.name == "proximo" ) ||
//        ( btn.name == "anterior" ) ||
//        ( btn.name == "ultimo" )
//         )
//         {
//          waction = form.action;
//          form.action = waction+"/"+btn.name;
//        if (btn.name == "cancelar")
//            form.reset()
//        else form.submit();
//          form.action = waction;
//          return True;
//        }else
//        {
//       alert("comando inválido");
//         return False;
//        }
//    }
//    </script>
//    <hr>
//    name="Form1" Obs: Como submeter um formulário passando o nome do botão pressionado para o servidor
//    <hr>
//    Nome do executável = /cgi-bin/GCIC.exe
//    <hr>
//    <form method="GET" name="form1"  action="/cgi-bin/GCIC.exe/Cestoque/CmProdutoI">
//    Digite um Texto e precissione em cacelar para limpar a caixa de texto.
//       <input type=text size=10 maxlength=10 name="Teste" value="">
//    <BR>
//    <BR>
//    <input  name="novo"      type="button" id="id1"  onClick="submit_form(form1,this)" value="Novo"      tabindex="0" accesskey="N"  title="Prepara o formulário para incluir um novo registro no arquivo!">
//    <input  name="gravar"    type="button" id="id2"  onClick="submit_form(form1,this)" value="Gravar"    tabindex="2" accesskey="G"  title="Grava os dados editado no arquivo. Caso o botão novo tenha sido pressiona o sistema inclui um novo registro. Caso o botão pesqusar tenha sido selecionado o sistema faz alteração do registro selecionado.">
//    <input  name="excluir"   type="button" id="id3"  onClick="submit_form(form1,this)" value="Excluir"   tabindex="3" accesskey="E"  title="Exluir o registro corrente selecionado.">
//    <input  name="sair"      type="button" id="id4"  onClick="submit_form(form1,this)" value="Sair"      tabindex="4" accesskey="S"  title="Sair do formulário atual e retona para o formulário que o executou!">
//    <input  name="editar"    type="button" id="id5"  onClick="submit_form(form1,this)" value="Editar"    tabindex="5" accesskey="E"  title="Edita o registro corrente caso o mesmo seja uma linha de uma grade!">
//    <input  name="imprimir"  type="button" id="id6"  onClick="submit_form(form1,this)" value="Imprimir"  tabindex="6" accesskey="I"  title="Imprimir o formulário corrente na impressora">
//    <input  name="cancelar"  type="button" id="id7"  onClick="submit_form(form1,this)" value="Cancelar"  tabindex="7" accesskey="C"  title="Apaga todos os dados digitados até o momento no formulário e não envia para o servidor!">
//    <input  name="primeiro"  type="button" id="id8"  onClick="submit_form(form1,this)" value="Primeiro"  tabindex="8" accesskey="1"  title="Posiciona no primeiro registro da ordem selecionada para edição!">
//    <input  name="proximo"   type="button" id="id9"  onClick="submit_form(form1,this)" value="Próximo"   tabindex="9" accesskey="2"  title="Seleciona o próximo registro da ordem selecionada para edição!">
//    <input  name="anterior"  type="button" id="id10" onClick="submit_form(form1,this)" value="Anterior"  tabindex="10" accesskey="3" title="Seleciona o registro anterior da ordem selecionada para edição!">
//    <input  name="ultimo"    type="button" id="id11" onClick="submit_form(form1,this)" value="Último"    tabindex="11" accesskey="4" title="Posiciona no último registro  da ordem selecionada para edição!">
//    <input  name="pesquisar" type="button" id="id12" onClick="submit_form(form1,this)" value="Pesquisar" tabindex="12" accesskey="P" title="Pesquisa um registro qualquer para ser editado">
//
//    </form>
//     </body>
//    </html>
//    *)
//
//{$ENDREGION}
//
//       procedure Press;//<O método press deve executar o comando associado ao botão.
//
//       //Construção da propriedade Value. Deve retornar StrCommand
//       Function GetValue_IInputButton():Variant;//=string value passed to form processing application
//       Procedure SetValue_IInputButton(wValue:Variant);
//       Property Value:Variant read GetValue_IInputButton Write SetValue_IInputButton;
//
//       //Construção da propriedade Title
//       Function GetHelpCtx_Hint :AnsiString;
//       property Title : AnsiString read GetHelpCtx_Hint;
//
//  //    Public Title     : PString;
//  //    Public AmDefault : Boolean;
//
//    End;
//  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//    IInputSubmit = Interface(IHTML_Base)
//    ['{52DB1E02-7F6C-49AA-B513-8918CB5528B1}']
//     //<input type=submit> - Defines an button on a form of type submit.
//
//  (*
//        Objeto Input SUBMIT
//            Este objeto é um botão que tem por finalidade submeter (enviar) o conteúdo
//            dos objetos do formulário ao "server". O formulário será submetido à URL
//            especificada na propriedade "action" do formulário.
//
//            Suas propriedades são: name e value.
//
//            name  : Especifica o nome do objeto.
//            value : Especifica o nome que aparecerá sobre o botão
//
//            O único evento associado a este objeto é onclick. Embora se possa atrelar
//            lógica a este evento, não se pode evitar que o formulário seja submetido,
//            portanto, não é aconselhavel o seu uso. Mais seguro e mais útil é a utilização
//            da propriedade onSubmit do formulário. Este permite que se atrele lógica e
//            decida-se pela submissão ou não.
//
//            Ex.
//            <script>
//              function TestaVal()
//              { if (document.TesteSub.Teste.value == "")
//                {
//                  alert ("Campo nao Preenchido...Form nao Submetido")
//                  return false
//                }
//                else {alert ("Tudo Ok....Form Submetido")
//                      return true
//                     }
//              }
//            </script>
//
//            <p>
//                <form method   ="POST" name="TesteSub"
//                      onSubmit ="return TestaVal()"
//                       action  ="http://10.0.5.2/scripts/isapielo.dll/vbloja.loja.action">
//
//                      Digite um Texto
//                        <input type=text size=10 maxlength=10 name="Teste" value="">
//
//                      Botao Submit
//                        <input type=submit name="Bsub" value="Manda p/Server">
//            </p>
//            </form>
//
//            No exemplo acima, o formulário está sendo submetido a URL "10.0.5.2" (que é o endereço IP
//            de um "Server"). Este servidor está rodando o "Microsoft Internet Information Server". Estamos
//            enviando os dados a um "OLE", que está no subdiretório "scripts", chamado "isapielo.dll", que tem
//            por objetivo fazer a conecção com aplicações escritas em VB. A aplicação VB que está sendo
//            chamada, é um OLE de nome "vbloja" no qual estamos acionando a classe "loja" e o método
//            "action".
//            A aplicação VB, deste exemplo, fará apenas a devolução dos dados recebidos pelo Server.
//  *)
//
//
//    End;
//  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//    IInputFile = Interface(IHTML_Base)
//    ['{D004105F-8A0E-4BD8-9EAF-56A9EA0E0F43}']
//     //<input type=file> - Defines an input Field on a form of type file.
//
//      Function GetMaxlength():AnsiString;//=n specifies the maximum number of AnsiCharacters
//      Function GetSize():AnsiString;//=n specifies the number of AnsiCharacters to display
//    End;
//  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//    IInputImage = Interface(IHTML_Base)
//    ['{89272475-D13D-40CD-88B1-6718BAF3C9A4}']
//     //<input type=image> - Defines an input Field on a form of type image.
//      Function GetAlign():AnsiString;//=type specifies the alignment of the object (top, middle, bottom)
//      Function GetBorder():AnsiString;//=n specifies the border thickness (pixels)
//      Function GetSrc():AnsiString;//=url specifies the source URL of the image
//    End;
//  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//    IInputReset = Interface(IHTML_Base)
//    ['{012130B5-3213-40A8-B02F-710C28C43B2D}']
//      //<input type=reset> - Defines an buton on a form of type reset.
//    End;
//  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//    IIsIndex = Interface(IHTML_Base)
//    ['{D32B6912-351A-4897-8D74-C2B21BDFA1AB}']
//      //<isindex> - Creates a searchable HTML document
//
//      Function GetAction():AnsiString;//=url specifies the URL of the document that will search this document
//      Function GetPrompt():AnsiString;//=string specifies an alternate prompt for the input Field
//    End;
//  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//    ILink = Interface(IHTML_Base)
//    ['{BA3C6C33-3707-423F-AC81-EC1940961F46}']
//     //<link> ... </link> - Define a link between this document and another
//      Function GetHref():AnsiString;//=url URL of linked document
//      Function GetRel():AnsiString;//=relationship specifies the relationship to the target
//      Function GetRev():AnsiString;//=relationship specifies the relationship from the target
//      Function GetTitle():AnsiString;//=string specifies a title for the target
//      Function GetType():AnsiString;//=string specify MIME type of linked document
//    End;
//  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//    IMenu = Interface(IHTML_Base)
//    ['{A91848E0-3917-4BF9-9542-6E4466ADE369}']
//     //<menu> ... </menu> - DEfine a menu list containing <LI> tags
//      Function GetCompact():AnsiString; //compact the list if possible
//      Function GetType():AnsiString;//=bullet define the bullet type (circle, disc or square)
//    End;
//  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//    IMeta = Interface(IHTML_Base)
//    ['{B7205DD2-9B3B-497D-9E99-65695E40535B}']
//     //<meta> ... </meta> - Provides additional information about the document
//
//      Function GetAnsiCharset():AnsiString;//=name specifies the AnsiCharacter set to be used
//      Function GetContent():AnsiString;//=string specifies the value of the meta information
//      Function GetHttp_equiv():AnsiString;//=string specifies the HTTP equivalent name for the meta information
//    End;
//  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//    IPlainText = Interface(IHTML_Base)
//    ['{C195DCFD-8D6C-4405-9FB6-8F87C6CEA01F}']
//     //<plaintext> The rest of the document should be shown as preformatted text
//
//    End;
//  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//    IPre = Interface(IHTML_Base)
//    ['{DF4A8191-6C90-49DF-9BB4-A1CE540E20C7}']
//     //<pre> ... </pre> - Render the enclosed text in its original, preformatted style with spacing and line breaks in text.
//      Function GetWidth():AnsiString;//=n size the text so that n AnsiCharacters fit across the scree.
//    End;
//  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//    IHtml = Interface(IHTML_Base)
//    ['{7DD7BDBA-B1E6-4BC0-8D7F-87463C3CC7F7}']
//     //<html lang="pt-BR"> ... </html> Specifies the beginning and end of an HTML document
//
//      Function GetVersion(): AnsiString;//=string specifies the HTML version used to create the document
//    end;
//  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//    IHead = Interface(IHTML_Base)
//    ['{317CDE30-61C7-42E6-A8EB-7CC42E1BB467}']
//     //<head> ... </head> Delimits the beginning and end of the document head
//
//       {Esta inteface deve declarar os métodos que retornem tudo que precisa no cabeçaho do html}
//    end;
//  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//    IForm = interface(IHTML_Base)
//    ['{FC08B397-3D6C-425B-A0D7-2C8E0901700A}']
//    //< <form> ... </form>
//{$REGION '---> IForm  Doc'}
//
//    (*
//
//       Propriedades e métodos do objeto form
//       --------------------------------------
//        Demos uma olhada nas diferentes propriedades e métodos do objeto form de Javascript.
//        Mostramos algum exemplo de utilização de propriedades e uma simples validação de
//        formulário e envio com o método submit ().
//
//        Vamos ver agora o objeto form por si só, para destacar suas propriedades e métodos.
//
//        Propriedades do objeto form
//       Têm umas propriedades para ajustar seus atributos mediante Javascript.
//
//        action : É a ação que queremos realizar quando se submete um formulário.
//                 Coloca-se geralmente um endereço de correio ou a URL a qual lhe mandaremos os dados.
//                 Corresponde com o atributo ACTION do formulário.
//        elements array : A matriz de elementos contém cada um dos campos do formulário.
//        encoding : O tipo de codificação do formulário
//        length : O número de campos do formulário.
//        method : O método pelo qual mandamos a informação. Corresponde com o atributo METHOD do formulário.
//        name   : O nome do formulário, que corresponde com o atributo NAME do formulário.
//        target : A janela ou frame no qual está dirigido o formulário.
//                 Quando se submete se atualizará a janela ou frame indicado. Corresponde com o atributo target do formulário.
//
//        Exemplos de trabalho com as propriedades
//
//        Com estas propriedades podemos mudar dinamicamente com Javascript os valores
//        dos atributos do formulário para fazer com ele o que se deseje dependendo das exigências do momento.
//
//        Por exemplo, poderíamos mudar a URL que receberia a informação do formulário com a instrução.
//        document.meuFormulário.action = "minhaPágina.asp" Ou mudar o target para submeter um formulário
//        em uma possível janela secundária chamada minha_janela.
//        document.meuFormulário.target = "minha_janela"
//
//        Métodos do objeto form
//           Estes são os métodos que podemos invocar com um formulário.
//
//           submit() : Para fazer com que o formulário se submeta, embora não se tenha clicado o botão de submit.
//           reset()  : Para reiniciar todos os campos do formulário, como se tivéssemos clicado o botão de reset. (Javascript 1.1)
//
//        Exemplo de trabalho com os métodos
//
//        Vamos ver um exemplo muito simples sobre como validar um formulário para submete-lo
//        no caso de que esteja preenchido. Para isso, vamos utilizar o método submit() do formulário.
//
//        O mecanismo é o seguinte: em vez de colocar um botão de submit colocamos um botão normal
//        (<INPUT type="button">) e fazemos que ao clicar esse botão se chame a uma função que é a
//        encarregada de validar o formulário e, no caso de que esteja correto, submete-lo.
//
//        O formulário ficaria assim:
//
//        <form name="meuFormulário" action="mailto:colabore@criarweb.com" enctype="text/plain">
//           <input type="Text" name="campo1" value="" size="12">
//           <input type="button" value="Enviar" onclick="validaSubmite()">
//        </form>
//
//        Observamos que não há um botão de submit, e sim, um botão normal com uma chamada a uma função que podemos ver a seguir.
//
//        function validaSubmete()
//        {
//          if (document.meuFormulário.campo1.value == "")
//             alert("Deve preencher o formulário")
//          else
//             document.meuFormulário.submit()
//        }
//
//        Na função se comprova que se o que está escrito no formulário é um string vazio.
//        Se for isso, mostra-se uma mensagem de alerta que informa que se deve preencher o formulário.
//        No caso de haver algo no campo de texto submete o formulário utilizando o método submit do objeto form.
//
//    *)
//
//{$ENDREGION}
//
//      Function GetAction(): AnsiString;//<url Specify the URL of the application that will process the form
//      property Action: AnsiString Read GetAction;
//
//      Function GetEnctype(): AnsiString;//<encoding specifies how the form will be encoded
//      property Enctype: AnsiString Read GetEnctype;
//
//      Function GetMethod(): AnsiString;//<method specifies how parameters will be passed (GET or POST)
//      property Method: AnsiString read GetMethod;
//
//      Function GetTarget(): AnsiString;//<name specifies the name of the frame or window to receive the results of the form after submission
//      property Target: AnsiString read getTarget;
//
//
//
//    end;
//  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//    IFrame = Interface(IHTML_Base)
//    ['{7BE5E9BA-7A61-42A8-B9E8-AA1A3C3E3BC3}']
//     //< <frame> ... </frame> Define a frame within a <FRAMESET>
//
//       Function GetBordercolor():AnsiString; //=color set the color of the frame's border
//       Property Bordercolor:AnsiString read GetBordercolor;
//
//       Function GetFrameborder():AnsiString; //=n 1=border enabled, 0=border disabled
//       Property Frameborder:AnsiString read GetFrameborder;
//
//       Function GetMarginheight():AnsiString; //=n place n pixels of space above and below frame contents
//       Property Marginheight:AnsiString read GetMarginheight;
//
//       Function GetMarginwidth():AnsiString; //=n place n pixels of space to the left and right of frame contents
//       Property Marginwidth:AnsiString read getMarginwidth;
//
//       Function GetNoresize():AnsiString; // disable user resizing of the frame
//       Property Noresize:AnsiString read GetNoresize;
//
//       Function GetScrolling():AnsiString; //=type Yes=always scrollbars, No=never scrollbars
//       property Scrolling : AnsiString read GetScrolling;
//
//       Function GetSrc():AnsiString; //=url define the URL of the source document for this frame
//       Property Src :AnsiString read GetSrc;
//    end;
//  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//    IFrameSet = Interface(IHTML_Base)
//    ['{ED81AA1E-88BF-44A8-87A6-88EEE1DA9CF2}']
//      //<frameset> ... </frameset>  Define a collection of frames or other framesets
//
//       Function GetBorder():AnsiString; //=n define the thickness of frame borders
//       Function GetBordercolor():AnsiString; //=color define the color of the frame borders
//       Function GetCols():AnsiString; //=list specify the number and width of frames within a frameset
//       Function GetFrameborder():AnsiString; //=value 1=border enabled, 0=border disabled
//       Function GetFramespacing():AnsiString; //=n define the thickness of the frame borders
//       Function GetRows():AnsiString; //=list specify the number and height of frames within a frameset
//    End;
//  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//    ILayer = Interface(IHTML_Base) //<ilayer> ... </ilayer> Defines an inline layer
//    ['{1D0E089F-0398-46E5-A5CE-01A195102F37}']
//       Function GetAbove():AnsiString;//=name place this layer above the named layer
//       Function GetBackground():AnsiString;//=url specifies the background image for the layer
//       Function GetBelow():AnsiString;//=name place this layer below the named layer
//       Function GetBgcolor():AnsiString;//=color specifies the background color for the layer
//       Function GetClip():AnsiString;//=edge defines the layers clipping region
//       Function GetLeft():AnsiString;//=n specifies position of layer's left edge (pixels)
//       Function GetSrc():AnsiString;//=url define the URL of the source document for this frame
//       Function GetTop():AnsiString;//=n specifies the position of the layer's top edge
//       Function GetVisibility():AnsiString;//=value show or hide the layer, or inherit from containing layer
//       Function GetWidth():AnsiString;//=n width of frame (pixels)
//       Function GetZ_Index():AnsiString;//=n specifies the layer's position in the stacking order
//    end;
//  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//  {: A interface @name implementa os diálogos de comunicação com o usuário.
//  }
//  IDialogs = Interface
//      ['{48A96A2A-F5AF-49B3-9CFD-B02FA49C3BA8}']
//
//
//    {: - A procedure **@name** executa um diálogo com dois botões: **OK** e **Cancel**
//    }
//    Procedure Alert(aTitle: AnsiString;aMsg:AnsiString);
//
//    {: - A função **@name** executa um diálogo fazendo uma pergunta com os botões **OK** e **Cancel**.
//
//       - **RETORNA:**
//         - **True** : Se o botão **OK** foi pressionado;
//         - **False** : Se o botão **Cancel** foi pressionado.
//    }
//    Function Confirm(aTitle: AnsiString;aPergunta:AnsiString):Boolean;
//
//    {: - A função **@name** mostra um diálogo com dois botões **OK** e **Cancel** e uma entrada de dados solicitando
//         que o usuário digite um valor.
//
//       - **RETORNA:**
//         - **True** : Se o botão **ok** foi pressionado;
//         - **False** : Se o botão **cancel** foi pressionado.
//         - **aResult** : Retorna a string digitada no formulário;
//    }
//    Function Prompt(aTitle: AnsiString;aPergunta:AnsiString;Var aResult: Variant):Boolean;
//
//    {: - A função **@name** mostra um diálogo para receber um valor sem mostrar o que foi digitado.
//         O formulário possui dois botões **OK** e **Cancel**
//
//       - **RETORNA:**
//         - **True** : Se o botão **ok** foi pressionado;
//         - **False** : Se o botão **cancel** foi pressionado.
//         - **apassword** : Retorna a string com a senha do usuário.
//    }
//    Function InputPassword(aTitle: AnsiString;out apassword:AnsiString):Boolean;Overload;
//
//    {: - A função **@name** mostra um diálogo solicitando o login do usuário e a senha  e dois botões: **OK**
//         e **Cancel**
//
//       - **RETORNA:**
//         - **True** : Se o botão **ok** foi pressionado;
//         - **False** : Se o botão **cancel** foi pressionado.
//         - **aUsername** : Retorna a string com nome do usuário.
//         - **apassword** : Retorna a string com a senha do usuário.
//    }
//    Function InputPassword(aTitle: AnsiString;out aUsername:AnsiString; out apassword:AnsiString):Boolean;Overload;
//
//  end;
//
//
//
Implementation

end.


//
//{
//Eventos em javaScript
//São fatos que ocorrem durante a execução do sistema, a partir dos quais o programador pode
//definir ações a serem realizadas pelo programa.
//
//Abaixo apresentamos a lista dos eventos possíveis, indicando os momentos em que os mesmos
//podem ocorrer, bem como, os objetos passíveis de sua ocorrência.
//
//-------------------------------------------------------------------------------------
//
//onload - Ocorre na carga do documento. Ou seja, só ocorre no BODY do documento.
//
//onunload - Ocorre na descarga (saída) do documento. Também só ocorre no BODY.
//
//onchange - Ocorre quando o objeto perde o focus e houve mudança de conteúdo.
//           válido para os objetos Text, Select e Textarea.
//
//onblur - Ocorre quando o objeto perde o focus, independente de ter havido mudança.
//         válido para os objetos Text, Select e Textarea.
//
//onfocus - Ocorre quando o objeto recebe o focus.
//          válido para os objetos Text, Select e Textarea.
//
//onclick - Ocorre quando o objeto recebe um Click do Mouse.
//          válido para os objetos Buton, Checkbox, Radio, Link, Reset e Submit.
//
//onmouseover - Ocorre quando o ponteiro do mouse passa por sobre o objeto.
//              válido apenas para Link.
//
//onselect - Ocorre quando o objeto é selecionado.
//           válido para os objetos Text e Textarea.
//
//onsubmit - Ocorre quando um botão tipo Submit recebe um click do mouse.
//           válido apenas para o Form.
//}
//
//
//
//unit mi.ui.Interfaces;
//{:< - A unit **@name** é usada para implementar as interfaces do pacote mi.rtl com propopósito de permitor que
//    se possa criar as interfaces com usuário independente do pacote gráfico instalado.
//
//    - **NOTA**
//      - O IDE Lazarus cria automaticamente o número da interface. Tecla: **Crt+Alt+G**
//}
//
//{$mode ObjFPC}{$H+}
//
//
//interface
//
//  TYPE
//    {: <html lang="pt-BR"> ... </html> Specifies the beginning and end of an HTML document}
//    IHtml = Interface
//      ['{C08BF9F6-E206-4029-BF4A-29A2126AC828}']
//      Function GetVersion(): AnsiString;//:< =string specifies the HTML version used to create the document
//    end;
//
//    {: <head> ... </head> Delimits the beginning and end of the document head
//    }
//    IHead = Interface
//      ['{EBA6F48F-2234-42C0-A34C-64A4E8ED44B9}']
//       {Esta inteface deve declarar os métodos que retornem tudo que precisa no cabe�aho do html}
//    end;
//
//    {:   <form> ... </form>}
//    IForm = interface
//      ['{174FF245-4CBA-4EA9-A8F0-37EE02D92DF7}']
//      Function GetName(): AnsiString;//:< name specifies a name for the form
//      Function GetAction(): AnsiString;//:< url Specify the URL of the application that will process the form
//      Function GetEnctype(): AnsiString;//:< encoding specifies how the form will be encoded
//      Function GetMethod(): AnsiString;//:< method specifies how parameters will be passed (GET or POST)
//      Function GetTarget(): AnsiString;//:< name specifies the name of the frame or window to receive the results of the form after submission
//    end;
//
//    {: <frame> ... </frame> Define a frame within a <FRAMESET>}
//    IFrame = Interface
//       ['{E0F0A3CE-9747-4579-BAB7-A654FB08AD00}']
//       Function GetBordercolor():AnsiString; //:< =color set the color of the frame's border
//       Function GetFrameborder():AnsiString; //:< =n 1=border enabled, 0=border disabled
//       Function GetMarginheight():AnsiString; //:< =n place n pixels of space above and below frame contents
//       Function GetMarginwidth():AnsiString; //:< =n place n pixels of space to the left and right of frame contents
//       Function GetName():AnsiString; //:< =name set the name of the frame
//       Function GetNoresize():AnsiString; //:<  disable user resizing of the frame
//       Function GetScrolling():AnsiString; //:< =type Yes=always scrollbars, No=never scrollbars
//       Function GetSrc():AnsiString; //:< =url define the URL of the source document for this frame
//    end;
//
//    { <frameset> ... </frameset>  Define a collection of frames or other framesets}
//    IFrameSet = Interface
//       ['{AE51337A-F337-4F99-9EA4-995A632114E9}']
//       Function GetBorder():AnsiString; //:< =n define the thickness of frame borders
//       Function GetBordercolor():AnsiString; //:< =color define the color of the frame borders
//       Function GetCols():AnsiString; //:< =list specify the number and width of frames within a frameset
//       Function GetFrameborder():AnsiString; //:< =value 1=border enabled, 0=border disabled
//       Function GetFramespacing():AnsiString; //:< =n define the thickness of the frame borders
//       Function GetRows():AnsiString; //:< =list specify the number and height of frames within a frameset
//    End;
//
//    ILayer = Interface //:< <ilayer> ... </ilayer> Defines an inline layer
//       ['{7B51931A-AA86-4A62-A267-E4B50541F11E}']
//       Function GetAbove():AnsiString;//:< =name place this layer above the named layer
//       Function GetBackground():AnsiString;//:< =url specifies the background image for the layer
//       Function GetBelow():AnsiString;//:< =name place this layer below the named layer
//       Function GetBgcolor():AnsiString;//:< =color specifies the background color for the layer
//       Function GetClip():AnsiString;//:< =edge defines the layers clipping region
//       Function GetLeft():AnsiString;//:< =n specifies position of layer's left edge (pixels)
//       Function GetName():AnsiString;//:< =name set the name of the layer
//       Function GetSrc():AnsiString;//:< =url define the URL of the source document for this frame
//       Function GetTop():AnsiString;//:< =n specifies the position of the layer's top edge
//       Function GetVisibility():AnsiString;//:< =value show or hide the layer, or inherit from containing layer
//       Function GetWidth():AnsiString;//:< =n width of frame (pixels)
//       Function GetZ_Index():AnsiString;//:< =n specifies the layer's position in the stacking order
//    end;
//
//    IInputButton = Interface //:< <input type=button> -  Defines an input Field on a form of type button.
//       ['{6B77C230-0E51-4795-806C-1E8C1744DB7C}']
//       Function GetName():AnsiString;//:< =name specifies the name of this input object
//       Function GetNotab():AnsiString;//:<  specifies that this element is not part of the tabbing order
//       Function GetTabOrder():AnsiString;//:< =n specifies the position of this element in the tabbing order
//       Function GetValue():AnsiString;//:< =string value passed to form processing application
//    End;
//
//    IInputCheckbox = Interface //:< <input type=checkbox>  - Defines an input Field on a form of type checkbox
//      ['{462FF97C-5208-4BDF-AB4F-CAE2C5F0A4D8}']
//      Function GetChecked():AnsiString;//:<  marks the element as initially selected
//      Function GetName():AnsiString;//:< =name specifies the name of this input object
//      Function GetNotab():AnsiString;//:<  specifies that this element is not part of the tabbing order
//      Function GetTabOrder():AnsiString;//:< =n specifies the position of this element in the tabbing order
//      Function GetValue():AnsiString;//:< =string value passed to form processing application
//    End;
//
//    IInputFile = Interface //:< <input type=file> - Defines an input Field on a form of type file.
//      ['{65CFD1DC-F7AF-4BF8-B525-EA558822BC66}']
//      Function GetMaxlength():AnsiString;//:< =n specifies the maximum number of AnsiCharacters
//      Function GetName():AnsiString;//:< =name specifies the name of this input object
//      Function GetNotab():AnsiString;//:<  specifies that this element is not part of the tabbing order
//      Function GetSize():AnsiString;//:< =n specifies the number of AnsiCharacters to display
//      Function GetTabOrder():AnsiString;//:< =n specifies the position of this element in the tabbing order
//    End;
//
//    IInputHidden = Interface//:< <input type=hidden> - Defines an input Field on a form of type hidden.
//      ['{8DC720BA-DF50-4F0F-BD1A-6D472A630B7E}']
//      Function GetName():AnsiString;//:< =name specifies the name of this input object
//      Function GetValue():AnsiString;//:< =string value passed to form processing application
//    End;
//
//    IInputImage = Interface //:< <input type=image> - Defines an input Field on a form of type image.
//      ['{C53426E0-5301-43C3-9372-39A85538DA06}']
//      Function GetAlign():AnsiString;//:< =type specifies the alignment of the object (top, middle, bottom)
//      Function GetBorder():AnsiString;//:< =n specifies the border thickness (pixels)
//      Function GetName():AnsiString;//:< =name specifies the name of this input object
//      Function GetNoTab():AnsiString;//:<  specifies that this element is not part of the tabbing order
//      Function GetSrc():AnsiString;//:< =url specifies the source URL of the image
//      Function GetTabOrder():AnsiString;//:< =n specifies the position of this element in the tabbing order
//    End;
//
//    IInputPassword = Interface //:< <input type=password> - Defines an input Field on a form of type password.
//      ['{39D1B1D7-8C6D-4DF0-AB5C-B76533FD01E0}']
//      Function GetMaxlength():AnsiString;//:< =n specifies the maximum number of AnsiCharacters
//      Function GetName():AnsiString;//:< =name specifies the name of this input object
//      Function GetNoTab():AnsiString;//:<  specifies that this element is not part of the tabbing order
//      Function GetSize():AnsiString;//:< =n specifies the number of AnsiCharacters to display
//      Function GetTabOrder():AnsiString;//:< =n specifies the position of this element in the tabbing order
//      Function GetValue():AnsiString;//:< =string value passed to form processing application
//    End;
//
//    IInputRadio = Interface //:< <input type=radio> - Defines an input Field on a form of type radio.
//      ['{77CBA306-157D-49DA-8879-4847388A07A7}']
//      Function GetChecked():AnsiString;//:<  marks the element as initially selected
//      Function GetName():AnsiString;//:< =name specifies the name of this input object
//      Function GetNoTab():AnsiString;//:<  specifies that this element is not part of the tabbing order
//      Function GetTabOrder():AnsiString;//:< =n specifies the position of this element in the tabbing order
//      Function GetValue():AnsiString;//:< =string value passed to form processing application
//    End;
//
//    IInputReset = Interface  //:< <input type=reset> - Defines an button on a form of type reset.
//      ['{72198240-DAB4-49AB-8047-D5B11E7863AE}']
//      Function GetNoTab():AnsiString;//:<  specifies that this element is not part of the tabbing order
//      Function GetTabOrder():AnsiString;//:< =n specifies the position of this element in the tabbing order
//      Function GetValue():AnsiString;//:< =string value passed to form processing application
//    End;
//
//    IInputSubmit = Interface //:< <input type=submit> - Defines an button on a form of type submit.
//      ['{068B7C60-52A1-482E-89D5-CD7C1F580874}']
//      Function GetName():AnsiString;//:< =name specifies the name of this input object
//      Function GetNoTab():AnsiString;//:<  specifies that this element is not part of the tabbing order
//      Function GetTabOrder():AnsiString;//:< =n specifies the position of this element in the tabbing order
//      Function GetValue():AnsiString;//:< =string value passed to form processing application
//    End;
//
//    IInputText = Interface //:< <input type=text> - Defines an input Field on a form of type text.
//      ['{8C55B169-354B-4F55-BD21-AA331E7E7E71}']
//      Function GetMaxLength():AnsiString;//:< =n specifies the maximum number of AnsiCharacters
//      Function GetName():AnsiString;//:< =name specifies the name of this input object
//      Function GetNoTab():AnsiString;//:<  specifies that this element is not part of the tabbing order
//      Function GetSize():AnsiString;//:< =n specifies the number of AnsiCharacters to display
//      Function GetTabOrder():AnsiString;//:< =n specifies the position of this element in the tabbing order
//      Function GetValue():AnsiString;//:< =string value passed to form processing application
//    End;
//
//    IIsIndex = Interface  //:< <isindex> - Creates a searchable HTML document
//      ['{DEEDDEBC-7832-4550-87B2-CFFD889F870E}']
//      Function GetAction():AnsiString;//:< =url specifies the URL of the document that will search this document
//      Function GetPrompt():AnsiString;//:< =string specifies an alternate prompt for the input Field
//    End;
//
//
//    ILink = Interface //:< <link> ... </link> - Define a link between this document and another
//      ['{90462AA0-A6AB-4EB8-A426-77612D13ABFF}']
//      Function GetHref():AnsiString;//:< =url URL of linked document
//      Function GetRel():AnsiString;//:< =relationship specifies the relationship to the target
//      Function GetRev():AnsiString;//:< =relationship specifies the relationship from the target
//      Function GetTitle():AnsiString;//:< =string specifies a title for the target
//      Function GetType():AnsiString;//:< =string specify MIME type of linked document
//    End;
//
//    IManu = Interface //:< <menu> ... </menu> - DEfine a menu list containing <LI> tags
//      ['{EAF1B252-9606-48FA-9B91-2A4056D16AF6}']
//      Function GetCompact():AnsiString; //:< compact the list if possible
//      Function GetType():AnsiString;//:< =bullet define the bullet type (circle, disc or square)
//    End;
//
//
//    IMeta = Interface //:< <meta> ... </meta> - Provides additional information about the document
//      ['{7942778F-1060-4071-829A-61C7CB10BE76}']
//      Function GetAnsiCharset():AnsiString;//:< =name specifies the AnsiCharacter set to be used
//      Function GetContent():AnsiString;//:< =string specifies the value of the meta information
//      Function GetHttp_equiv():AnsiString;//:< =string specifies the HTTP equivalent name for the meta information
//      Function GetName():AnsiString;//:< =string specifies the name of the meta information
//    End;
//
//
//    ISelect = Interface //:< <select> ... </select> - Defines a multiple choice menu within a form
//      ['{E6F9C842-2F2E-432F-B338-9BC9780DAB72}']
//      Function GetMultiple():AnsiString;//:<  allow multiple selections
//      Function GetName():AnsiString;//:< =name specifies the name for passing to processing application
//      Function GetSize():AnsiString;//:< =n specifies the number of options to display
//    End;
//
//
//    IOptions = Interface //:< <option> ... </option> - Define an option within a <SELECT> item in a form
//      ['{DBEF2AAD-B5AC-4818-9B3A-B2FAEEE5A9B2}']
//      Function GetSelected():AnsiString;//:<  make this item initially selected
//      Function GetValue():AnsiString;//:< =string specifies the value sent to the form processing application
//    End;
//
//
//    IPlainText = Interface //:< <plaintext> The rest of the document should be shown as preformatted text
//      ['{0DC46C0C-75E6-44FE-8E85-22569165790E}']
//      Function GetText():AnsiString;//:< Retorna um texto pre-formatado
//    End;
//
//    IPre = Interface //:< <pre> ... </pre> - Render the enclosed text in its original, preformatted style with spacing and line breaks in text.
//      ['{37BE7F99-C3DB-4CE1-8EC9-923201253A2A}']
//      Function GetText():AnsiString;//:< Retorna um texto pre-formatado
//      Function GetWidth():AnsiString;//:< =n size the text so that n AnsiCharacters fit across the scree.
//    End;
//
//
//  {: A interface @name implementa os diálogos de comunicação com o usuário.
//  }
//  IDialogs = Interface
//      ['{48A96A2A-F5AF-49B3-9CFD-B02FA49C3BA8}']
//
//
//    {: - A procedure **@name** executa um diálogo com dois botões: **OK** e **Cancel**
//    }
//    Procedure Alert(aTitle: AnsiString;aMsg:AnsiString);
//
//    {: - A função **@name** executa um diálogo fazendo uma pergunta com os botões **OK** e **Cancel**.
//
//       - **RETORNA:**
//         - **True** : Se o botão **OK** foi pressionado;
//         - **False** : Se o botão **Cancel** foi pressionado.
//    }
//    Function Confirm(aTitle: AnsiString;aPergunta:AnsiString):Boolean;
//
//    {: - A função **@name** mostra um diálogo com dois botões **OK** e **Cancel** e uma entrada de dados solicitando
//         que o usuário digite um valor.
//
//       - **RETORNA:**
//         - **True** : Se o botão **ok** foi pressionado;
//         - **False** : Se o botão **cancel** foi pressionado.
//         - **aResult** : Retorna a string digitada no formulário;
//    }
//    Function Prompt(aTitle: AnsiString;aPergunta:AnsiString;Var aResult: Variant):Boolean;
//
//    {: - A função **@name** mostra um diálogo para receber um valor sem mostrar o que foi digitado.
//         O formulário possui dois botões **OK** e **Cancel**
//
//       - **RETORNA:**
//         - **True** : Se o botão **ok** foi pressionado;
//         - **False** : Se o botão **cancel** foi pressionado.
//         - **apassword** : Retorna a string com a senha do usuário.
//    }
//    Function InputPassword(aTitle: AnsiString;out apassword:AnsiString):Boolean;Overload;
//
//    {: - A função **@name** mostra um diálogo solicitando o login do usuário e a senha  e dois botões: **OK**
//         e **Cancel**
//
//       - **RETORNA:**
//         - **True** : Se o botão **ok** foi pressionado;
//         - **False** : Se o botão **cancel** foi pressionado.
//         - **aUsername** : Retorna a string com nome do usuário.
//         - **apassword** : Retorna a string com a senha do usuário.
//    }
//    Function InputPassword(aTitle: AnsiString;out aUsername:AnsiString; out apassword:AnsiString):Boolean;Overload;
//
//  end;

Implementation

end.

