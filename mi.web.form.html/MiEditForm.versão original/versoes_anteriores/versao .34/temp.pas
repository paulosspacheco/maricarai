Por favor converta esse codigo em pascal para javascript.

        type TField = record                              
                        Name : String;
                        Value : String;
                        typ   : string; 
                        size  : Integer;
                      end;
      {$REGION --> Propriedade CurrentField}
          {: O atributo protected **@name** contem os dados da propriedade CurrentField.}
          protected _CurrentField  : TField;


          {: O atributo **@name** salva o currentefield anterior ao atual.

             - **ATENÇÃO**
               - Necessário caso se deseja fazer alguma crítica com os dados do buffer
                 do corrente campo focado ao pressionar um botão de ação.
          }
          public CurrentField_old : TField;

          {: O Método **@name** Set o currenteField com aCurrentField}
          protected Procedure SetCurrentField(aCurrentField : TField);

          {: A propriedade **@name** contém um ponteiro para o campo selecionado }
          public property CurrentField : TField  read _CurrentField write SetCurrentField;

          {: A atributo **@name** contém um ponteiro para o campo selecionado
             e que FieldNum seja diferente de zero.
          }
          public protected CurrentField_focused  : TField;
      {$ENDREGION --> Propriedade CurrentField}  

      