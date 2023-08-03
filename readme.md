# Maricarai

- Componente free pascal para criação de formulários LCL e pas2js baseado em templates simples, onde o template possui informações que permite o componente saber o tipo, tamanho, formatação, faixa de valor válido, dados para criação de combobox, checkbox, dispara eventos onEnter, OnExist, onEnterField e OnExitField etc... e críticas de tipo de dados de entrada.

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
          add('~Valor Smallword....:~\WW,WWW');
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

- Versão: Alpha - 0.7.1 em 21/07/2021
