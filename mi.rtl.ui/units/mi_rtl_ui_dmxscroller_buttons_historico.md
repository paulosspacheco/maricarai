{
# **HISTÓRICO DA UNIT mi_rtl_ui_DmxScroller_Buttons**

  - Criado por: Paulo Sérgio da Silva Pacheco paulosspacheco@@yahoo.com.br)

  - **2022-07-06**
    - **10:30**
      - Análise:
        - O objetivo desta classe é registrar os dados necessários para criar os
          botões de ação de navegação e edição de uma tabela.
        - O básico em todos os tipos de botões é a classe **TUiDmxScroller_Buttons**
          menos o método **Create_RCommands_Buttons**, por
          isso o mesmo deve ser **abstract**;
      - Criar classe **mi_rtl_ui_DmxScroller_Buttons** ✅️
      - Criar Function **Create_RCommands** ✅️
      - Documentar os atributos abaixo:
        - Commands_Buttons_High : Byte; ✅️
        -
    - **14:30**
      - Documentar os atributos abaixo:
        - Commands_Buttons_High : Byte; ✅️
        - Commands_Buttons      : Array[0..Max_List_Buttons] of TRCommand; ✅️
        - Max_List_Buttons = sizeof(Longint); ✅️
        - Commands_Buttons_Mb   : Longint; ✅️
        - Procedure Create_RCommand;  ✅️
        - Function  Add_RCommands_Edit;  ✅️
        - Function  Create_RCommands_Buttons; ✅️
        - Function  Set_Commands_Buttons_Mb(Const aMb_Bits:Longint):Longint;✅️
        -

    - **22:09**
      - Transforma a classe mi_rtl_ui_DmxScroller_Navigator na classe mi_rtl_ui_DmxScroller_Buttons.

  - **2022-07-07**
    - **09:45**
      - Documentar o método **Add_RCommands_Buttons**
    - **14:55**
      - Documentar o método **Add_RCommands_Buttons**
      - Documentar o método Create_RCommands_Buttons.

}


