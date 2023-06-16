# **HISTÓRICO DA UNIT: Mi_ui_Dmxscroller_form**

1. **2022-02-24 14:46**  
    1. T12 Remover o campo TDmxScroller_Form.NumRows e substituir por TDmxScroller_Form.DMXFields.Count ✅
    2. Início da documentação desta unidade. ✅
    3. T12 Documentar o método TDmxScroller_Form.CreateFormLCL ✅

2. **2022-03-13 8:30**
      <!--TODO:T12 Checar...DmxSrollBox-->
   1. T12 Checar porque quando não insiro uma linha em branco na ultima linha do Template
          o DmxSrollBox ficar menor do que é para ser.
      1. Solução:
         1. Após inserir todos os campos definir a altura do DmxScrollBox:

          ```pascal
              (aOwner as TScrollingWinControl).Height:= Control.Height + HeightChar+10;
          ```

      2. NÃO DEU CERTO ESSA SOLUÇÃO PORQUE BAGUNÇA O FORMULÁRIO.

      3. A solução acima resolve um problema e cria outros , pois caso haja botões
         embaixo do TScrollBox os mesmos sumirão da visão .

   2. T12 Permitir que um rótulo torne-se invisível.
      1. Se o Caractere seguinte ao ~ for ^H então o rótulo é invisível. ✅

   3. T12 Criar constantes para os caracteres de controles e desativar os caracteres de
         controle que não vou precisar com objetivo de ganhar caractere de controle para
         as tags de formatação \<h1\> \<h2\> \<b\> \<i\> Link etc... ✅

3. **2022-05-30 14:00**
   1. T12 Em TDmxScrollerForm.CreateFormLCL criar um botão ao lado de TDmxEdit_LCL caso ExecAction seja <> nil.

4. **2022-06-01 14:55**
   1. T12 Implementar um botão associado ao TMaskEdit para que seja acionado para localizar um registro no banco de dados e atualiza o buffer do campo . ✅
      1. T12 Criar componente TMI_CheckBox_Lcl e inserir no formulário para editar os campos do tipo FldBoolean  ✅

5. **2022-06-06 10:00**
   1. T12 Criar componente TMI_RadioGroup_LCL para editar os campos do tipo FldRadioButton.  ✅

6. **2022-06-23**  
   1. 08:50
      1. Separar o histórico da unidade uMi_ui_dmxScroller_form.pas para melhorar
       a visibilidade da Unit principal do pacote.

   2. 09:35
      1. No método CreateFormLCL setar os parâmetros:
         1. HorizontalScrollBar. ✅
         2. VerticalScrollBar. ✅

   3. 14:17
      1. O componente TMi_ui_Button_lcl não está na lista dos campos selecionados na tecla tab. ✅
         1. O problema estava no componente Tmi_ui_Button_Lcl.

   4. 15:02
      1. T12 O grupo TMi_RadioGroup_Lcl não é selecionado com a tecla na tecla **TAB**
         1. T12 Quando os botões TRadioButton estão dentro do TRadioGroup  a propriedade TRadioGroup.TabStop não funciona.
         2. **Não achei a solução.**
   5. T12 O help do FldEnum não está funcionando.  ✅

7. **2022-07-08**
   1. 15:00
      1. T12 Remover toda a referência a interface gráfica LCL

