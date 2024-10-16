{Essa Include contém todas as constantes usadas e: mi_rtl_ui_Dmxscroller.pas}


{$REGION ' --->  Constantes '}
  // Used for ModalResult
  const
    MaxBufLength   = $ff00;
    mbOK       = TMI_MsgBoxTypes.mbOK;
    mrOK       = TMI_MsgBoxTypes.mrOK;

    mbCancel   = TMI_MsgBoxTypes.mbCancel ;
    mrCancel   = TMI_MsgBoxTypes.mrCancel;

    mbAbort    = TMI_MsgBoxTypes.mbAbort;
    mrAbort    = TMI_MsgBoxTypes.mrAbort;
    mrIgnore   = TMI_MsgBoxTypes.mrIgnore;

    mbYes      = TMI_MsgBoxTypes.mbYes;
    mrYes      = TMI_MsgBoxTypes.mrYes;

    mbNo       = TMI_MsgBoxTypes.mbNo;
    mrNo       = TMI_MsgBoxTypes.mrNo;

    mbClose    = TMI_MsgBoxTypes.mbClose;
    mrClose    = TMI_MsgBoxTypes.mrClose;

    mbAll      = TMI_MsgBoxTypes.mbAll;
    mrAll      = TMI_MsgBoxTypes.mrAll;

    mbNoToAll  = TMI_MsgBoxTypes.mbNoToAll;
    mrNoToAll  = TMI_MsgBoxTypes.mrNoToAll;

    mbYesToAll = TMI_MsgBoxTypes.mbYesToAll;
    mrYesToAll = TMI_MsgBoxTypes.mrYesToAll;

    // Used for ModalResult
    mrNone     = TMI_MsgBoxTypes.mrNone;

    mrLast     = TMI_MsgBoxTypes.mrLast    ;
    mbRetry    = TMI_MsgBoxTypes.mbRetry;
    mrRetry    = TMI_MsgBoxTypes.mrRetry;

    mbIgnore   = TMI_MsgBoxTypes.mbIgnore ;
    mbHelp     = TMI_MsgBoxTypes.mbHelp;
{$ENDREGION ' --->  Constantes '}

{$REGION ' --->  Tipos'}
  // Message dialog related
  Type TMsgDlgType = TMI_MsgBoxTypes.TMsgDlgType;
  Type TMsgDlgBtn  = TMI_MsgBoxTypes.TMsgDlgBtn;
  Type TMsgDlgButtons = TMI_MsgBoxTypes.TMsgDlgButtons;

  // ModalResult
  type TModalResult = TMI_MsgBoxTypes.TModalResult;
  Type TArray_MsgDlgBtn = TMI_MsgBoxTypes.TArray_MsgDlgBtn;
  Type TPanel_Lista_de_Botoes = TMI_MsgBoxTypes.TPanel_Lista_de_Botoes;

{$ENDREGION ' --->  Tipos e constantes '}

{$REGION '<-- declaração do tipo de eventos'}
  {: Usado para criar modelos de formulários dinamicamente usando como parâmetro
  listas de PSItems.}
  TOnGetTemplate = mi_rtl_ui_Dmxscroller.TOnGetTemplate;

  {: O tipo @name é usado para criar modelos de formulários dinamicamente usando o método add

       - **EXEMPLO**

         ```pascal

           Procedure AddTemplate(const aUiDmxScroller:TUiDmxScroller);
           begin
             with aUiDmxScroller do
             begin
               add('~EXEMPLO DE TEMPLATE~');
               add('');
               add('~Alfanumérico maiúscula com 15 posições:~\SSSSSSSSSSSSSSS');
               add('~Alfanumérico maiúscula e minuscula com 30 posições:~');
               add('~~\ssssssssssssssssssssssssssssssssssssss');
               add('~Alfanumérico com a primeira letra maiúscula:~\Sssssssssssssss');
               add('~Valor double.......:~\RRR,RRR.RR');
               add('~Valor SmalInt......:~\II,III');
               add('~Valor Byte.........:~\BBB');
               add('~Valor SmallWord....:~\WW,WWW');
               add('~Sexo...............:~'+ CreateEnumField(TRUE, accNormal, 0,
                                             NewSItem(' indefinido ',
                                             NewSItem(' Masculino',
                                             NewSItem(' Feminino',
                                                     nil)))));
               add('~Estado Civil              ~\KA Indefinido  '+chFN+'Sexo');
               add('~~\X Casado?                \KA Masculino    ');
               add('~~\X Pretende se divorciar? \KA Feminino     ');
               add('~~\X Tens filhos?          ');
               add('');
             end;
           end;

           procedure TForm1.DmxScroller_Form1AddTemplate(const aUiDmxScroller: TUiDmxScroller);
           begin
             AddTemplate(aUiDmxScroller);
           end;

         ```
    }
  TOnAddTemplate = mi_rtl_ui_Dmxscroller.TOnAddTemplate;

  {: O tipo **@name** é usado para implementar evento onEnter da classe TUiDmxScroller
  }
  TOnEnter = mi_rtl_ui_Dmxscroller.TOnEnter;

  {: O tipo **@name** é usado para implementar evento onExit da classe TUiDmxScroller
  }
  TOnExit = mi_rtl_ui_Dmxscroller.TOnExit;

  {: O tipo **@name** é usado para implementar evento onNewRecord da classe TUiDmxScroller
  }
  TOnNewRecord = mi_rtl_ui_Dmxscroller.TOnNewRecord;

  {: O tipo **@name** é usado para implementar evento OnCloseQuery da classe TUiDmxScroller

     - **NOTA*
       - Este evento é disparado antes de desativar a classe **TUiDmxScroller**.
         - Obs: Se o parâmetro **CanClose** for **false**, então a classe **TUiDmxScroller** não é desativado.

  }
  TOnCloseQuery = mi_rtl_ui_Dmxscroller.TOnCloseQuery;

  {: O tipo **@name** é usado no evento OnEnterField e disparado em TDmxFieldRec.DoOnEnter()}
  TOnEnterField = mi_rtl_ui_Dmxscroller.TOnEnterField;

  {: O tipo **@name** é usado no evento OnExitField}
  TOnExitField = mi_rtl_ui_Dmxscroller.TOnExitField;

  {: O tipo **@name** é usado no evento para calcular um campo e é executado
     em TDmxFieldRec.DoOnEnter() e TDmxFieldRec.DoOnExit()}
  TOnCalcField = mi_rtl_ui_Dmxscroller.TOnCalcField;

  {: O tipo **@name** é usado para fazer calculos quando um valor campo é alterado.

     - PARÂMETROS:
       - aUiDmxScroller : Classi que edita o campo;
       - Previous_value : Valor do campo antes da auteração
       - Current_value  : Valor do campo atual.
  }
  TOnChangeField = mi_rtl_ui_Dmxscroller.TOnChangeField;


  {: O tipo **@name** é usado para criar o evento OnBeforeInsert e disparado no método TUiDmxScroller.AddRec}
  TOnBeforeInsert = mi_rtl_ui_Dmxscroller.TOnBeforeInsert;

  {: O tipo **@name** é usado para criar o evento OnAfterInsert e disparado no método TUiDmxScroller.AddRec}
  TOnAfterInsert = mi_rtl_ui_Dmxscroller.TOnAfterInsert;

  {: O tipo **@name** é usado para criar o evento OnBeforeUpdate e disparado no método TUiDmxScroller.PutRec}
  TOnBeforeUpdate = mi_rtl_ui_Dmxscroller.TOnBeforeUpdate;

  {: O tipo **@name** é usado para criar o evento OnAfterUpdate e disparado no método TUiDmxScroller.PutRec}
  TOnAfterUpdate = mi_rtl_ui_Dmxscroller.TOnAfterUpdate;


  {: O tipo **@name** é usado para criar o evento OnBeforeDelete e disparado no método TUiDmxScroller.PutRec}
  TOnBeforeDelete = mi_rtl_ui_Dmxscroller.TOnBeforeDelete;

  {: O tipo **@name** é usado para criar o evento OnAfterDelete e disparado no método TUiDmxScroller.PutRec}
  TOnAfterDelete = mi_rtl_ui_Dmxscroller.TOnAfterDelete;

  {: O tipo **@name** é usado para fazer calculos é executado ao entrar no registro e ao sair do registro}
  TOnCalcFields  = mi_rtl_ui_Dmxscroller.TOnCalcFields;
{$ENDREGION '<-- declaração do tipo de eventos'}



{ As constantes abaixo são declaradas fora das classes para que os componentes não 
  derivados da classe possam reconhece-los sem declarar o nome da classe.}

{: A constante **@name** informa que o campo é delimitador de campos no Template.}
Const accDelimiter          = TConsts.accDelimiter ;

{: A constante **@name** (Const accHidden = 2;) é um mapa de bits usado para identificar o
   bit do campo TDmxFieldRec.access que informa se o mesmo é invisível.

   - **EXEMPLO**
     - Como usar o mapa de bits accHidden para saber se o campo está invisível.

       ```pascal

          with pDmxFieldRec^ do
            If (access and accHidden <> 0)
            then begin
                   ShowMessage(Format('O campo %s está invisível'),[CharFieldName]); 
                 end;
       ```
}
Const accHidden             = TConsts.accHidden    ;

{: A constante **@name** (Const AccNormal = 0;) é um mapa de bits usado para identificar o
   bit do campo TDmxFieldRec.access que informa se que o campo pode ser editado.

   - **EXEMPLO**
     - Como usar o mapa de bits accNormal para saber se o campo pode ser editado.

       ```pascal

          with pDmxFieldRec^ do
            If (access and accNormal <> 0) 
            then begin
                   ShowMessage(Format('O campo %s pode ser editado'),[FieldName]);
                 end;
       ```
}
const AccNormal             = TConsts.AccNormal;

{: A constante **@name** (Const ReadOnly = 1;) é um mapa de bits usado para identificar o
   bit do campo TDmxFieldRec.access que informa se o campo é somente para leitura.
   - **EXEMPLO**
     - Como usar o mapa de bits ReadOnly para saber se o campo não pode ser editado.
       ```pascal
          with pDmxFieldRec^ do
            If (access and ReadOnly <> 0)
            then begin
                   ShowMessage(Format('O campo %s não pode ser editado'),[FieldName]);
                 end;
       ```
}
Const accReadOnly           = TConsts.accReadOnly  ;

{: A constante **@name** (Const accSkip = 4;) é um mapa de bits usado para identificar o
   bit do campo TDmxFieldRec.access que informa se o campo pode receber o focus.
   - **EXEMPLO**
     - Como usar o mapa de bits accSkip para saber se o campo não pode receber o focus.
       ```pascal
          with pDmxFieldRec^ do
            If (access and accSkip <> 0)
            then begin
                   ShowMessage(Format('O campo %s não pode receber o focus'),[FieldName]);
                 end;
       ```
}        
Const accSkip               = TConsts.accSkip      ;

{:A constante **@name** é usado para documentar o campo e indica que todo o texto até o próximo
  caractere de controle será o conteúdo do campo HelpCtx_Hint.

  - **EXEMPLO**

    ```pascal

       Resourcestring

        tmp_Alunos_Idade = '\BB'+ChFN+'idade'+CharUpperlimit+#64+
                            CharHint+'A idade do aluno. Valores válidos 1 a 64'+
                            CharHintPorque+'Este campo é necessário para que se agrupe o alunos baseado em sua faixa etária'+
                            CharHintOnde+'Ele será usado pelo coordenador ao classificar a turma';


        tmp_Alunos_Matricula = \IIII'+ChFN+'matricula'+CharHint+'A matricula do aluno é um campo sequencial e calculado ao incluir o registro';

        tmp_Alunos = '~     Idade:~%s'+lf+
                     '~ Matricula:~%s'+lf;
    ```                       
}
Const CharHint              = TConsts.CharHint;

{: A contante **@name** informa que todo texto até o próximo delimitador 
   contém informações para o campo HelpCtx_Onde}
Const CharHintOnde          = TConsts.CharHintOnde;

{: A contante **@name** informa que todo texto até o próximo delimitador 
   contém informações para o campo HelpCtx_Porque}
Const CharHintPorque        = TConsts.CharHintPorque;

{: A constante **@name** é do tipo TDateTime e guarda a data compactada 'dd/nn/yy'}
Const FldDateTime             = TConsts.FldDateTime          ;

{: A constante **@name** é do tipo TDateTime e guarda a hora compactada  ##:##:##}
Const fld_LHora             = TConsts.fld_LHora          ;

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
Const fldAnsiChar           = TConsts.fldAnsiChar          ;

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
Const fldAnsiCharAlfa = TConsts.fldAnsiCharAlfa;

{: A constante **@name** informa que o campo é do tipo AnsiCharacter, 
  ou seja: O último caractere da string contém #0 e contém somente caracteres numéricos}

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
Const fldAnsiCharNumPositive        = TConsts.fldAnsiCharNumPositive     ;

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
Const fldAnsiCharNum  = TConsts.fldAnsiCharNumPositive     ;

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
Const fldAPPEND             = TConsts.fldAPPEND          ;

{: A constante **@name** indica que o campo é não formatado 
   podendo ser um Record, porém a edição do mesmo será feito por outros meios.

   - **NOTA**
     - Para informar ao buffer do registro que o campo é **@name**,
       a função **CreateBlobField** é necessário.

     - A **class function TUiMethods.CreateBlobField(Len: integer; AccMode,Default: byte) : TDmxStr_ID;**
       reserva espaço para o mesmo.

     - Pendência: Preciso criar um exemplo de uso deste tipo de informação.  
}
Const fldBLOb               = TConsts.fldBLOb            ;


{: A constante **@name** (Const fldByte = 'B') usado na máscara do Template,
   informa ao componente **TUiDmxScroller** que a sequência de caracteres 'B' 
   após o caractere **"\"** representa no buffer do formulário um tipo byte.

   - **EXEMPLO**
       
       ```pascal

          Const
             idade := '\BB' //Os dois dígitos estarão em um buffer de 1 byte;

       ```   
}
Const fldByte               = TConsts.fldByte            ;

{: A constante **@name** (fldBoolean = 'X') indica que o campo é do tipo byte e só pode ter dois valores.

   - **NOTA**
     - Valores possíveis:
       - 0 - False; não
       - 1 = True;  sim
     - A forma de editá-los deve ser com o componente checkbox.

   - **EXEMPLO**

       ```pascal

         Resourcestring
           tmp_Aceita = '\[X]'+ChFN+'Aceita_contrato'+CharHint+'Aceita os termos do contrato?';
           Template = tmp_Aceita+'~Aceita os termos do contrato~';
       ```
}
Const fldBoolean          =   TConsts.fldBoolean;


{: A constante **@name** ...}
Const fldCONTRACTION        = TConsts.fldCONTRACTION     ;


{: A constante **@name** ...}
//Const FldDateTimeDos        = TConsts.FldDateTimeDos     ;

{: A constante **@name** (fldENUM=^E) é um campo do tipo byte(0..255) que contém
   uma lista de string que são selecionadas por um componente tipo ComboBox.

   - **EXEMPLO**

     ```pascal

          Const tmpMidia : PSitem = nil;
        begin
          tmpMidia := CreateEnumField(TRUE, accNormal, 0,
                                      NewSItem(' indefinido ',
                                      NewSItem(' PenDriver  ',
                                      NewSItem(' SSD        ',
                                      nil))))+CharFieldName+'Midia;

          Template = NewSItem('~  Eu uso ~'+ tmpMidia + '~ em meu computador.~',
              Next);
        end;

     ```
}
Const fldENum               = TConsts.fldENUM            ;

{: A constante **@name** (fldENum_db=^D) é um campo do tipo longint associado
   a um dataSource, uma chave dataSource.dataSet.KeyField e um campo a ser
   visualizado na liasta dataSource.dataSet.listField.

     - Os controles usados para edita-lo são:
       - TdbLookupComboBox.

       - **EXEMPLO USO NO TEMPLATE**

         ```pascal

           function T__dm_xtable__.DmxScroller_Form1GetTemplate(aNext: PSItem): PSItem;
           begin
              with DmxScroller_Form1 do
              begin
                Result :=
                NewSItem(GetTemplate_CRUD_Buttons(CmNewRecord,CmUpdateRecord,CmLocate,CmDeleteRecord),
                NewSItem('',
                NewSItem('~ID:            ~'+CreateEnumField(TRUE, accNormal, 1,NewSItem('ssssssssssssssssssssssssssssssssssssssssssssssssss',nil),
                                                             Mi_SQLQuery1.DataSource,'id','nome')+
                                              ChFN+'id'+
                                              CharHint+'Campo enumero lookup',
                NewSItem('~Nome:          ~\ssssssssssssssssssssssssssssssssssssssssssssssssss'+chFN+'nome'+CharHint+'Campo alfanumérico aceita maiuscula e minuscula',
                NewSItem('~endereco       ~\ssssssssssssssssssssssssssssssssssssssssssssssssss'+chFN+'endereco',
                NewSItem('~cnpj           ~\##.###.###/####-##'+chFN+'cnpj',
                NewSItem('~cpf            ~\###.###.###-##'+chFN+'cpf',
                NewSItem('~cep            ~\##.###-###'+chFN+'cep',
                NewSItem('~valor_SMALLINT ~\IIIII'+chFN+'valor_SMALLINT',
                NewSItem('~valor_Integer  ~\LLLLLLLLLL'+chFN+'valor_Integer',//Maximo:2.147.483.647

                NewSItem('~valor_FLOAT8   ~\RRR,RRR.ZZ'+chFN+'valor_FLOAT8',
                NewSItem('~Data_1         ~\Ddd/mm/yy'+chFN+'Data_1',
                NewSItem('~hora_1         ~\Dhh:nn:ss'+chFN+'hora_1',
                NewSItem('~hora_2         ~\Dhh:nn'+chFN+'hora_2',
                NewSItem('',
                NewSItem(GetTemplate_DbNavigator_Buttons(CmGoBof,CmNextRecord,CmPrevRecord,CmGoEof,CmRefresh),
                NewSItem('',
                aNext)))))))))))))))));
              end;
           end;

         ```
}
Const fldENum_db            = TConsts.fldENum_db          ;

{: A contante **@name** é usado para associar ao campo atual uma classe **TAction**.

   - **NOTA**
     - O interpretador de Templates associa a ação do Template ao corrente campo.

   - **EXEMPLO DE USO DE AÇÕES NO TEMPLATE**               
     1. Se o atributo **Fieldnum** do campo for diferente de zero,
        então o **rótulo** do botão associado a ação será o caracteres 🔍
        e a ação pode atualizar o buffer do campo.
        - No exemplo a seguir um rótulo e um campo de cliente:

          ```pascal

            NewSItem('~Cliente:~'+'\LLLLL'+CharExecAction+CreateExecAction(Action_pesquisa)

          ```
     2. Se o atributo **Fieldnum** do campo for igual a zero,
        então a rótulo do botão será o rótulo do campo.
        - No exemplo a seguir um rótulo de novo cliente (icons  🆕) e um botão ok (icons 🆗) 

          ```pascal

            NewSItem('~ 🆕 &Novo cliente:~'+CharExecAction+CreateExecAction(Action_Novo)+
                     '~   ~~ 🆗 ~'+CharExecAction+CreateExecAction(Action_Ok)

          ```

}
Const CharExecAction        = TConsts.CharExecAction        ;

{: A constante **@name** usado na máscara do Template, informa ao componente
   **TUiDmxScroller** que a sequência de caracteres 'E' após o caractere **"\"**
   representa no buffer do formulário um tipo Extended.

   - **EXEMPLO**

       ```pascal

          Const
             Valor := '\EEE,EEE,EEE,EEE,EE' //Todos os números editados nesta
                                            //mascara, estarão em um buffer de 10 bytes;

       ```
}
Const fldExtended           = TConsts.fldExtended        ;

{: A constante **@name** usada para informar o nome do campo informado antes deste caractere.

   - **EXEMPLO**

       ```pascal

          Const
            idade := '\BB'+CharFieldName+'idade'

       ```


}
const CharFieldName          = TConsts.CharFieldName       ;

{: A constante **@name** é igual a CharFieldName. Foi criada para facilitar seu uso.}
Const ChFN                 = TConsts.ChFN              ;

{: A constante **@name** ...}
Const fldHexValue           = TConsts.fldHexValue        ;

{: A constante **@name** ...}
Const fldLHora              = TConsts.fldLHora           ;

{: A constante **@name** ...}
Const fldLongInt            = TConsts.fldLongInt         ;

{: A constante **@name** ...}
Const FldMemo               = TConsts.FldMemo            ;

{: A constante **@name** ...}
Const FldOperador           = TConsts.FldOperador        ;

{: A constante **@name** ...}
Const FldRadioButton        = TConsts.FldRadioButton     ;

{: A constante **@name** ...}
Const fldReal4              = TConsts.fldReal4           ;

{: A constante **@name** ...}
Const fldReal4P             = TConsts.fldReal4P          ;

{: A constante **@name** ...}
Const fldReal4Positivo      = TConsts.fldReal4Positivo   ;

{: A constante **@name** ...}
Const fldReal4PPositivo     = TConsts.fldReal4PPositivo  ;

{: A constante **@name** ...}
Const fldDouble             = TConsts.fldDouble         ;

{: A constante **@name** ...}
Const fldDoublePositive    = TConsts.fldDoublePositive;

{: A constante **@name** ...}
Const FldSData              = TConsts.FldSData           ;

{: A constante **@name** ...}
//Const FldSDateTimeDos       = TConsts.FldSDateTimeDos    ;

{: A constante **@name** ...}
Const FldSHora              = TConsts.FldSHora           ;

{: A constante **@name** ...}
Const fldShortInt           = TConsts.fldShortInt        ;

{: A constante **@name** ...}
Const fldSItems             = TConsts.fldSItems          ;

{: A constante **@name** ...}
Const fldSmallInt           = TConsts.fldSmallInt        ;

{: A constante **@name** ...}
Const fldSmallWord          = TConsts.fldSmallWord       ;

{: A constante **@name** ...}

{: A constante **@name** (Const fldStr = 'S') usado na máscara do Template,
   informa ao componente **TUiDmxScroller** que a sequência de caracteres 'S'
   após o caractere **"\"** representa no buffer do formulário um tipo ShortString
   que só aceita caractere maiúsculo.

   - **EXEMPLO**
     - Representação de um string de 10 dígitos em um buffer de 11 bytes
       onde o byte zero contém o tamanho da string;

       ```pascal

          Const
            Nome := '\SSSSSSSSSS'  //PAULO SÉRG

       ```
}
Const fldStr                = TConsts.fldStr          ;

{: A constante **@name** (Const fldStrAlfa = 's') usado na máscara do Template,
   informa ao componente **TUiDmxScroller** que a sequência de caracteres 's'
   após o caractere **"\"** representa no buffer do formulário um tipo ShortString
   que só aceita caractere minúscula.

   - **EXEMPLO**
     - Representação de um string de 10 dígitos em um buffer de 11 bytes
       onde o byte zero contém o tamanho da string;

       ```pascal

          Const
            Nome := '\ssssssssss' //paulo sérg
            Nome := '\Ssssssssss' //Paulo sérg
       ```
}
Const fldStrAlfa      = TConsts.fldStrAlfa;

{: A constante **@name** (Const fldStrNumber = '#') usado na máscara do Template,
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
Const fldStrNumber             = TConsts.fldStrNumber       ;

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
            idade := '\BBB+CharUpperlimit+#130+CharHint+'Não existe humanos com a idade superior a 130 anos.';
            
        ```
}
Const CharUpperlimit         = TConsts.CharUpperlimit      ;

{: A constante **@name** ...}
Const fldZEROMOD            = TConsts.fldZEROMOD         ;

{: A constante **@name** informa para controle que os caracteres não devem ser visualizado.

   - **NOTA**
     - Usados no campos tipo senha.
}
Const CharShowPassword          = TConsts.CharShowPassword       ;

{: A constante **@name** ...}
Const CharShowPasswordChar      = TConsts.CharShowPasswordChar   ;

{: A constante **@name** ...}
Const TypeDate              = TConsts.TypeDate           ;

{: A constante **@name** ...}
Const _TypeDate             = TConsts._TypeDate          ;

{: A constante **@name** ...}
Const TypeHora              = TConsts.TypeHora           ;

{: A constante **@name** ...}
Const TypeMemo              = TConsts.TypeMemo           ;


