{Essa Include contém todas as constantes usadas e: mi_rtl_ui_Dmxscroller.pas
- **VERSÃO**
  - Alpha - 1.0.0.621
}

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

{: A constante **@name** informa que o campo pode ser visualizado mas não deve receber o focus}
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
Const fldAnsiChar_LowCase = TConsts.fldAnsiChar_LowCase;

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
Const fldAnsiCharNUM        = TConsts.fldAnsiCharNUM     ;

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
Const fldAnsiCharVAL        = TConsts.fldAnsiCharVAL     ;

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


{: A constante **@name** (Const fldBYTE = 'B') usado na máscara do Template, 
   informa ao componente **TUiDmxScroller** que a sequência de caracteres 'B' 
   após o caractere **"\"** representa no buffer do formulário um tipo byte.

   - **EXEMPLO**
       
       ```pascal

          Const
             idade := '\BB' //Os dois dígitos estarão em um buffer de 1 byte;

       ```   
}
Const fldBYTE               = TConsts.fldBYTE            ;

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
Const FldDateTime               = TConsts.FldDateTime            ;

{: A constante **@name** ...}
Const FldDateTimeDos        = TConsts.FldDateTimeDos     ;

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
Const fldENUM               = TConsts.fldENUM            ;

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

{: A constante **@name** (fldExtended='E') usado na máscara do Template,
   informa ao componente **TUiDmxScroller** que a sequência de caracteres 'E'
   após o caractere **"\"** representa no buffer do formulário um tipo Extended.

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
Const FldDateTime              = TConsts.FldDateTime           ;

{: A constante **@name** ...}
Const fldLHora              = TConsts.fldLHora           ;

{: A constante **@name** ...}
Const fldLONGINT            = TConsts.fldLONGINT         ;

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
Const fldRealNum            = TConsts.fldRealNum         ;

{: A constante **@name** ...}
Const fldRealNum_Positivo   = TConsts.fldRealNum_Positivo;

{: A constante **@name** ...}
Const FldSData              = TConsts.FldSData           ;

{: A constante **@name** ...}
Const FldSDateTimeDos       = TConsts.FldSDateTimeDos    ;

{: A constante **@name** ...}
Const FldSHora              = TConsts.FldSHora           ;

{: A constante **@name** ...}
Const fldSHORTINT           = TConsts.fldSHORTINT        ;

{: A constante **@name** ...}
Const fldSItems             = TConsts.fldSItems          ;

{: A constante **@name** ...}
Const fldSmallInt           = TConsts.fldSmallInt        ;

{: A constante **@name** ...}
Const fldSmallWORD          = TConsts.fldSmallWORD       ;

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
Const fldSTR                = TConsts.fldSTR          ;

{: A constante **@name** (Const fldstr_Lowcase = 's') usado na máscara do Template,
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
Const fldstr_Lowcase      = TConsts.fldstr_Lowcase;

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
Const fldSTRNUM             = TConsts.fldSTRNUM       ;

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


