unit mi.rtl.objects.methods.pageproducer;
{:< - A unit **@name** implementa as propriedade e métodos para produzir
      página html, semelhante a unit HTTPProd do Delphi.

  - **NOTAS**
    -

  - **VERSÃO**
    - Alpha - 1.0.0

  - **HISTÓRICO**
    - Criado por: Paulo Sérgio da Silva Pacheco e-mail: paulosspacheco@@yahoo.com.br
      - **23/07/2023**
        - 08:12 a 12:00: Criar a unit **@name**

      - **24/07/2023**
        - 08:45 a 12:00: Documento da unit
        - 14:00 a 17:30: Documento da unit

      - **25/07/2023**
        - 08:15 a 12:00: Documento da unit
        - 13:30 a 17:30: Documento da unit

      - **10/08/2023**
        - 08:10 a 12:00: Implementar componente TPageProducer

      - **16/08/2023**
        - 08:00 a 12:00: T12 Criar o componente TPageProducer.
                         A procedure create_css_table() deve criar
                         o arquivo na pasta template/css
        - 13:20 a 17:25: T12 Criar o componente TPageProducer.GetHtmlTable
      - **16/08/2023**
        - 08:00 a 12:00 T12 Documentar componente TPageProducer
        - 13:30 a 17:30 T12 Documentar componente TPageProducer

      - **17/08/2023**
        - 08:00 a 11:56 T12 Documentar componente TPageProducer
        - 13:30 a 17:17 T12 Documentar componente TPageProducer

      - **18/08/2023**
        - 09:55 a 12:00 T12 Documentar componente TPageProducer
        - 14:23 a 17:15 T12 Documentar componente TPageProducer

      - **25/08/2023**
        - 09:35 a 12:00 T12 Documentar componente TPageProducer
        - 14:23 a 17:15 T12 Documentar componente TPageProducer


  - **CÓDIGO FONTE**:
    - @html(<a href="../units/mi.rtl.objects.methods.pageproducer.pas</a>)

}

{$IFDEF FPC}
  {$MODE Delphi} {$H+}
{$ENDIF}

interface

uses
  Classes, SysUtils,StrUtils
  ,LResources
  ,Contnrs

  ,FPTemplate
  ,mi.rtl.Consts
  ,mi.rtl.Objects.Methods
  ,mi.rtl.miStringlist
  ,mi.rtl.Objects.Methods.Paramexecucao.Application

  ;


Type

  { TBasePageProducer }
  {: A classe **@name** permite criar documentos baseados em modelos,
     podendo ser html ou não.

     - **NOTA**
       - Tentei manter o mesmo comportamento do TPageProduce do Delphi, porém faz mais porque
         está documentado com exemplos de uso.
  }
  TBasePageProducer = class(TObjectsMethods)

    {: O constructor **@name** inicializa os parâmetros padrões da classe e
       instancia a classe FPTemplate.

       - Parâmetro usado aqui:
         - TConsts.DefaultStartDelimiter;
         - TConsts.DefaultEndDelimiter;
         - TConsts.DefaultParamStartDelimiter;
         - TConsts.DefaultParamValueSeparator;
         - TConsts.DefaultParamEndDelimiter;
         - TConsts.DefaultAllowTagParams;
    }
    public constructor create(aOwner:TComponent);override;

    {: O Destructor **@name** destroy a classe **TBasePageProducer** e livra da memória o atributo FPTemplate criado
       em constructor.
    }
    public destructor destroy; override;

    {$REGION '---> Construção da propriedade ID_Dinamic'}
      Private _ID_Dinamic   : AnsiString; //
      private Function GetID_Dinamic:AnsiString;

      {: - A propriedade **@name** retorno um string com um registro tipo
         [**TGuid**](https://www.freepascal.org/docs-html/rtl/system/tguid.html) para
         representar a classe.
      }
      Public  Property ID_Dinamic : AnsiString Read GetID_Dinamic;
    {$ENDREGION}

    {: O método **@name** retorna uma string com o nome de todos os arquivos
       com a extensão passada por a aMask.

       - **PARÂMETROS**
         - aTagName
           - Nome da tag
         - atemplate
           - Modelo onde cada nome de arquivo deve ser inserido

             ```pascal

                <!--# tgCustom [- ListFilesText=Arquivo:
                                                -"~ListFilesText" -]
                #-->

              ```
         - aPath
           - Nome do diretório

         - aMask
           - Filtro de pesquisa.
             - Ex: *.html

       - **EXEMPLO**

         ```pascal

            procedure TForm_pageproducer_test.PageProducer1HTMLTag_tgCustom(
                     Sender: TObject; const TagString: string; TagParams: TStrings;  var ReplaceText: string);

              var
                s1 : string;
            begin
              s1 := TagParams.Values['ListFilesText'];
              if s1 <> ''
              Then begin //Retorna a lista de links.
                     ReplaceText:=TPageProducer.ListFilesText('ListFilesText',s1,'','*');
                   end;
            end;

          ```

       - **NOTA**
         - O parâmetro **atemplate** pode conter qualquer formato em cada
           linha, visto que o modelo passado por **atemplate** é inserido
           o nome do arquivo no lugar de aTagName.
    }
    class function ListFilesText(const aTagName, atemplate,aPath,aMask :String) : string;

    {$REGION '---> Construção da propriedade OnHTMLTag_tgcustom'}
      Private _OnHTMLTag_tgcustom : THTMLTagEvent;

      {: - O evento **@name** retorna em *ReplaceText* o código preenchido passado por
           *TagString* e *TagParams*.

         - **DESCRIÇÃO**
           - A propriedade **@name** foi criado para processar todo template
             criado pelo usuário e que não tem relação com nome de tags html.

         - **EXEMPLO DE TEMPLATE CUSTOMIZADO**
           - A Tag <# tgCustom [- ListFilesText=Arquivo:-"~ListFilesText" -]#>
             informa ao componente TPageProduce que deve executar o método
             ListFilesText, porém o resultado deve ser uma lista de textos com
             nome dos arquivos da pasta atual e de suas subpastas.
             - Formato de saída:
               - Arquivo:
                   - xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
               - Arquivo:
                   - xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

             ```pascal

                <!--# tgCustom [- ListFilesText=
                                  Arquivo:
                                    -"~ListFilesText" -]
                #-->
             ```

           - O método *@name* retorna no parâmetro em **ReplaceText** a lista de texto.

             ```pascal

               procedure TForm_pageproducer_test.PageProducer1HTMLTag_tgCustom(
                         Sender: TObject; const TagString: string; TagParams: TStrings;  var ReplaceText: string);


               var
                 s1 : string;
               begin
                 if AnsiCompareText(TagString, 'tgCustom') = 0 then
                 begin
                   s1 := TagParams.Values['ListFilesText'];
                   if s1 <> ''
                   Then begin //Retorna a lista de links.
                          ReplaceText:=TPageProducer.ListFilesText('ListFilesText',s1,'','*');
                        end;
                 end
                 else ReplaceText:='A tag <'+TagString+'>Não conhecida';
               end;


             ```
      }
      Public Property OnHTMLTag_tgcustom : THTMLTagEvent Read _OnHTMLTag_tgcustom write _OnHTMLTag_tgcustom ;
    {$ENDREGION}

    {$REGION '---> Construção da propriedade OnHTMLTag_tgLink'}
      Private _OnHTMLTag_tgLink : THTMLTagEvent;

      {: - O evento **@name** retorna em *ReplaceText* o código preenchido passado
           por *TagString* e *TagParams*, onde *TagString*, contém a tag *tgLink*
           e *TagParams* contém o template de um link html com os atributos hRef,
           target, title, text.

         - **DESCRIÇÃO**
           - O método **@name** foi criado para processar todos os templates
             referentes a links cuja a tag seja *tgLink* dentro do arquivo de
             templates.html

         - **EXEMPLO DE TEMPLATE **
           - O template abaixo dentro de TPageProduce.FileName, informa para o evento *@name*
             que os parâmetros BlogPsspAppBr e PsspAppBr deve ser preenchido com um link. A 
             função *FindFilesAll* deve retornar um código html com uma lista de links de
             todos os nomes de arquivos dentro da pasta corrente e subpastas.

             ```pascal
                 <!-- Arquivo: template.html -->

                 <html lang="pt-BR">
                   <head>
                       <meta charset="UTF-8">
                       <title>Teste do componente mi.rtl.Objects.Methods.TPageProduce</title>

                       <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

                   </head>

                 <bodY>
                   <h3> Meu Blog </h3>

                   <p> A tag abaixo deve ser preenchida com o endereço: http://www.pssp.app.br
                        onde o destino da visualização é uma nova aba do browser<p>
                   <!--# tgLink [- BlogPsspAppBr=[a href="~url" target="_blank" title="~title"] ~text [/a]  -] #-->

                   <p> A tag abaixo deve ser preenchida com o endereço: http://www.pssp.app.br
                        onde o destino da visualização é uma variável definida no ato da produção
                        da página</p>
                   <!--# tgLink [-     PsspAppBr=[a href="~url" target="~target" title="~title"] ~text [/a]  -] #-->

                   <br>

                   <h3> Link com a lista de arquivos .html da pasta corrente</h3>
                   <!--# tgLink [- FindFilesAll=[a href="~url" target="_blank" title="~title"] ~text [/a]  -] #-->
                   <br>
                  </body>
                 </html>

             ```

           - O método *@name* retorna no parâmetro em **ReplaceText** o template acima preenchido.

             ```pascal

                 procedure TFPWebModule.@name(Sender: TObject; const TagString:  String; TagParams: TStringList; Out ReplaceText: String);override;
                 begin
                   s1 := TagParams.Values['BlogPsspAppBr'];
                   ReplaceText := TObjectss.StringReplaceTgLink('BlogPsspAppBr',
                                                                 s1,
                                                                 'http://www.pssp.app.br',
                                                                 '', // Mantém o destino definido no ptemplate
                                                                 'Blog do Paulo Sérgio da Silva Pacheco',
                                                                 'http://www.pssp.app.br  ➚');

                   s1 := TagParams.Values['PsspAppBr'];
                   if s1 <> ''
                   then ReplaceText := TObjectss.StringReplaceTgLink('PsspAppBr',
                                                                     s1,
                                                                     'http://www.pssp.app.br',
                                                                     '_self', //Abre o documento na mesma aba
                                                                     'Blog do Paulo Pacheco',
                                                                     'http://www.pssp.app.br')
                   else begin
                          s1 := TagParams.Values['FindFilesAll'];
                          if s1 <> ''
                          Then begin //Retorna a lista de links.
                                 ReplaceText:=ListFilesURLs(s1);
                               end;
                        end;
                 end;

             ```

           - Notas:
             - A ação padrão de @name é executar o evento *OnHTMLTag_tgLink*, porém
               é possível ser redefinido para ter outro tipo de comportamento
               conforme preferência da aplicação que o utiliza.
      }
      Public Property OnHTMLTag_tgLink : THTMLTagEvent Read _OnHTMLTag_tgLink write _OnHTMLTag_tgLink ;
    {$ENDREGION}

    {$REGION '---> Construção da propriedade OnHTMLTag_tgImage'}
      Private _OnHTMLTag_tgImage : THTMLTagEvent;

      {: A classe método **@name** recebe um template tipo image e retorna o mesmo
         preenchido com o conteúdo os parâmetros: aSrc, aAlt, aTitle, aFigcaption.
      }
      public class function StringReplaceTgImage(const aTemplate, aSrc, aAlt, aTitle, aFigcaption: String): string;

      {: O evento **@name** retorna em *ReplaceText* o código preenchido passado
         por *TagString* e *TagParams*, onde *TagString*, contém a tag *tgImage*
         e *TagParams* contém o template de um link html para imagem com os
         atributos Src, Alt, aTitle e text.

         - **DESCRIÇÃO**
           - O método **@name** foi criado para processar todos os templates
             referentes a img cuja a tag seja *tgimage* dentro do arquivo de
             templates.html

         - **ATRIBUTOS:**
           - **src** : Especifica o caminho para a imagem;
             - Value : URL.

           - **Alt** : Especifica um texto alternativo para uma imagem;
             - Value : Text.

           - **usemap** : Associa na tag <img> ao nome do mapa de imagem definido
                           na tag <map> </map>.
                           lado do cliente;

             - Value : Nome da tag mapa
               - Ex..: #image_tag Obs: Deve ter o símbolo cancela (#) para indicar
                       que a imagem está na mesma página;

             - Exemplo: *<img src="form_instalar_pacotes.jpeg" usemap="#image-map">*

           - **height** : Especifica a altura de uma imagem;
             - Value : pixels.

           - **width** : Especifica a largura de uma imagem;
             - Value : pixels.


         - **EXEMPLO DE TAG DE IMAGEM**

           ```pascal
                <!-- Arquivo: template.html
                     Code template: mi_HTMLTag_tgImage_template
                -->

                <!--# tgImage [- NomeDaFigura=[ <figure>
                                                   <img src="~src"
                                                        alt="~alt"
                                                        title="~title"
                                                        style="width:10%">
                                                   <figcaption>~figcaption</figcaption>
                                                </figure>
                                              ]
                              -]
                #-->

           ```

           ```pascal
                <!-- EVENTO USADO PARA PREENCHER O TEMPLATE

                     Code Template: mi_HTMLTag_tgImage_Event
                -->

                procedure TForm_pageproducer_test.PageProducer1HTMLTag_tgImage(Sender: TObject;
                  const TagString: string; TagParams: TStrings; var ReplaceText: string);
                var
                  s1 : string;
                begin
                  s1 := TagParams.Values['NomeDaFigura'];
                  if s1 <> ''
                  Then begin //Retorna a tag com a figura
                         ReplaceText:= TPageProducer.StringReplaceTgImage(s1,'./img/brasao.png','Pachecos','Hint da imagem','Brasão da Família Pacheco');

                       end;
                end;


           ```
      }
      Public Property OnHTMLTag_tgImage : THTMLTagEvent Read _OnHTMLTag_tgImage write _OnHTMLTag_tgImage ;

    {$ENDREGION}

    {$REGION '---> Construção da propriedade OnHTMLTag_tgTable'}

      Private _OnHTMLTag_tgTable : THTMLTagEvent;

      {: O método **@name**  retorna em *ReplaceText* o código preenchido passado
         por *TagString* e *TagParams*.

         - O evento **@name** é usado para tratar especificamente criação de tabelas.

         - **EXEMPLO DE TAG**

           ```pascal

            <!-- Arquivo......: template.html
                 Code template: mi_HTMLTag_tgtable_template
            -->

            <!-- Adicionar a linha abaixo em header do documento-->
            <link type="text/css" href="./css/$Param(NomeDaTabela).css" rel="stylesheet" />

            <!-- Tag para criar uma tabela no estilo $Param(table)
              <!--# tgTable [- $Param(NomeDaTabela)=
                               [ Alias="$Param(Alias_da_tabela)";
                                 Header="$Param(Column1):",":$Param(Column2):",":$Param(Column3)",":$Param(Column4)";
                                 widths="$Param(300px)","$Param(250px)","$Param(150px)","$Param(180px)";
                                 OneRow=["$Param(a11)","$Param(a12)","$Param(a13)  ","$Param(a14)",/,
                                         "$Param(a21)" ,"$Param(a22)","$Param(a23)","$Param(a24)",/,
                                         <!-- Adicione aqui ,mais linhas semelhantes a linha acima e apague esse comentário-->
                                        ];
                                 Footer="$Param(soma Columm1)","$Param(soma Columm2)","$Param(soma Columm3)","$Param(soma Columm4)";
                                 NotFound="$Param(Mensagem em caso de erro)";
                                 template="<Table id="$Param(table)">
                                               <thead id="thead$Param(NomeDaTabela)">
                                                  <tr><th colspan="$Param(4)"> <p  style="text-align: center"> ~Alias  </p> </th>  </tr>
                                                  <tr>~HeaderCols</tr>
                                               </thead>
                                               <tbody id="tbody$Param(NomeDaTabela)">
                                                  ~OneRowCols
                                               </tbody>
                                               <tfoot id="tfoot$Param(NomeDaTabela)">
                                                  ~FooterCols
                                               </tfoot>
                                           </Table>"
                               ]
                            -]
              #-->

           ```

           - **PARÂMETROS ESPERADOS EM  TAGPARAMS**
             - **Alias**
               - Descrição da tabela que deve fica na primeira linha do header
                 da tabela.

             - **Header**
               - Em **Header** se informa o título das colunas e através de **:** se
                 informa o alinhamento da coluna, podendo ser a esquerda **:Column1**,
                 ou a direita **Column2:** ou  ao centro **:Column3:** ou usar padrão
                 da tabela como na **Column4**

             - **Widths**
               - Em **width** se informa a largura de cada coluna;

             - **OneRow**
               - Em **OneRow** se informa o conteúdo das linhas onde a colunas
                 deve estar entre aspa(") e separado por vírgula(,) e o fim da
                 linha se usa a barra (/) sem as aspa (").

             - **Footer**
               - O parâmetro **Footer** usado para separar a ultima linha da
                 tabela quando a mesma contem conteúdo de soma da coluna.

             - **NotFound**
               - O parâmetro **NotFound** é usado para dar uma mensagem quando
                 não existe registro para inserir em **OneRow**.

             - **Template**
               - O parâmetro **Template** deve conter o **html** usado para criar
                 a tabela.


         - **EXEMPLO DE CÓDIGO A TAG ACIMA**

           ```pascal

             //Code template: mi_HTMLTag_tgtable_event

             procedure TForm_pageproducer_test.$Param(NomeDoObjeto)HTMLTag_tgTable(Sender: TObject;
                          const TagString: string; TagParams: TStrings; var ReplaceText: string);
               Var
                 s1 : string='';
             begin

               s1 := TagParams.Values['$Param(NomeDaTabela)'];
               if s1 <> '' Then
               begin

                 ReplaceText:= $Param(NomeDoObjeto).GetHtmlTable(TagParams,'$Param(NomeDaTabela)','$Param(table)');
                 exit;
               end;//$Param(NomeDaTabela)

             end;

           ```

         - @url("#" 🔝)
      }
      Public Property OnHTMLTag_tgTable : THTMLTagEvent Read _OnHTMLTag_tgTable write _OnHTMLTag_tgTable ;
    {$ENDREGION}

    {$REGION '---> Construção da propriedade OnHTMLTag_tgImageMap'}
      Private _OnHTMLTag_tgImageMap : THTMLTagEvent;

      {: O método **@name**  retorna em *ReplaceText* o código preenchido passado
         por *TagString* e *TagParams*.

         - O evento **@name** é usado para tratar especificamente mapa de imagem,
           com áreas clicáveis.

         - **<map name="#Name_usemap"></map>**
           - **<area>** : Tag usada para informar uma área dentro da imagem
                          #Name_usemap;
             - atributos:
               - **Alt** : Especifica um texto alternativo para a área da imagem;
                 - Value : Text.

               - **Shape** : A forma do ponto de acesso associado. As especificações
                         para html 5 e HTML 4 definem os valores **rect** para
                         região rectangular; **circle** para uma região circular
                         e **poli** para um polígono determinado por toda região
                         determinada pelas coordenadas.
                 - Value:
                   - rect: Espera em Coords dois pontos: x1, y1 x2,y2;
                   - circle: Espera em Coodes 2 pontos e o raio: x,y,r;
                   - poly : Espera em Coodes n pares de pontos: x1,y1,x2,y2,
                            x3,y3..xn,yn;
               - **Coords**
                 - Value:
                   - Se shape = rect então o valor é dois pontos: x1, y1 x2,y2;
                   - Se shape = circle então o valor é 2 pontos e o raio: x,y,r;
                   - Se shape = poly então o valor é n pares de pontos: x1,y1,x2,
                                y2,x3,y3..xn,yn;


           - **Notas**:
             - Entre as tags <map></map> é esperado uma lista de tag <area>.

               ```pascal
                  <map name="#Name_usemap">
                    <area ... >
                    <area ... >
                    <area ... >
                    <area ... >
                  </map>
               ```

         - **EXEMPLO DE TAG ESPERADO**

             ```pascal

              <!-- Arquivo......: template.html
                   Code template: mi_HTMLTag_tgImageMap_template

                   OneRowArea =
              -->

              <!-- Tag para uma imagem clicável -->

                <!--# tgImageMap [- $Param(NomeDaImagem)=[
                                       src="$Param(src)";
                                       alt="$Param(alt)";
                                       width="$Param(300px)";
                                       height="$Param(400PX)";
                                       OneRow=["rect","$Param(x1)","$Param(y1)","$Param(x2)","$Param(y2)",/,
                                               "circle","$Param(x1)" ,"$Param(y1)","$Param(r)",/,
                                               "poly","$Param(x1)" ,"$Param(y1)","$Param(x2)" ,"$Param(y2)"$Param(xn)" ,"$Param(yn)",/,
                                               <!-- Adicione aqui ,mais linhas semelhantes a linha acima e apague esse comentário-->
                                              ];
                                       templateOneRowArea =<area shape="~shape" alt="~alt"  href="~href" coords="~coords">
                                       templateImageMap=<img src="~src"
                                                           alt="~alt"
                                                           usemap="#~usemap"
                                                           width="~width"
                                                           height="~height">
                                                           <map name="~usemap">
                                                              OneRowArea
                                                           </map>

                                    ]
                              -]
                #-->

             ```

      }
      Public Property OnHTMLTag_tgImageMap : THTMLTagEvent Read _OnHTMLTag_tgImageMap write _OnHTMLTag_tgImageMap ;
    {$ENDREGION}

    {$REGION '---> Construção da propriedade OnHTMLTag_tgObject'}
      Private _OnHTMLTag_tgObject : THTMLTagEvent;
      {: A propriedade **@name** ..

      }
      Public Property OnHTMLTag_tgObject : THTMLTagEvent Read _OnHTMLTag_tgObject write _OnHTMLTag_tgObject ;
    {$ENDREGION}

    {$REGION '---> Construção da propriedade OnHTMLTag_tgEmbed'}
      Private _OnHTMLTag_tgEmbed : THTMLTagEvent;
      Public Property OnHTMLTag_tgEmbed : THTMLTagEvent Read _OnHTMLTag_tgEmbed write _OnHTMLTag_tgEmbed ;
    {$ENDREGION}

    {$REGION '---> Construção da propriedade OnHTMLTag_tgVideo'}
      Private _OnHTMLTag_tgVideo : THTMLTagEvent;
      Public Property OnHTMLTag_tgVideo : THTMLTagEvent Read _OnHTMLTag_tgVideo write _OnHTMLTag_tgVideo ;
    {$ENDREGION}

    {$REGION '---> Construção da propriedade OnHTMLTag_tgAudio'}
      Private _OnHTMLTag_tgAudio : THTMLTagEvent;
      Public Property OnHTMLTag_tgAudio : THTMLTagEvent Read _OnHTMLTag_tgAudio write _OnHTMLTag_tgAudio ;
    {$ENDREGION}

    {$REGION '---> Construção da propriedade OnHTMLTag_Undefined'}
      Private _OnHTMLTag_Undefined : THTMLTagEvent;
      {: A propriedade **@name** é usada quando o projeto não tem um padrão definido.

      }
      Public Property OnHTMLTag_Undefined : THTMLTagEvent Read _OnHTMLTag_Undefined write _OnHTMLTag_Undefined ;
    {$ENDREGION}

    {: - O método **@name** é usado para preencher templates html **tgLink** usado nos
         templates do componente *TPageProducer*.

       - PARÂMETROS
         - aAlias     = Apelido do template
         - atemplate  = <!--# tgLink [- %s=[a href="~url" target="_blank" title="~title"] ~text [/a]  -] #-->
         - aURL       = Endereço do link
         - atarget    = Destino onde a página deve ser aberta, se vazio abre na aba atual.
         - aTitle     = Documentação do link
         - aText      = Descrição do link

       - ATRIBUTOS DO TEMPLATE
         - ~alias     = Apelido do template;
         - ~url       = Endereço do link
         - ~target    = Destino onde a página deve ser aberta, se vazio abre na aba atual.
         - ~title     = Documentação do link
         - ~text      = Descrição do link
    }
    public class function StringReplaceTgLink(
                            const aAlias,
                                  atemplate,
                                  aURL,
                                  atarget,
                                  aTitle,
                                  aText:String):string;

    {: A classe método **@name** é usado para preencher um template passado
       por template dentro de um template.html para criar tabelas html
       usado na tag **tbTable**.

       - **EXEMPLOS**
         - Template esperado no evento **OnHTMLTag_tgTable**

         ```pascal

           <!--# tgTable [- ALUNOS=[title="Cadastro de Alunos:";
                                   Header="Column1:      ",":Column2:     ",":Column3      ",":Column4    ";
                                   OneRow=["1 Paulo Sérgio","Marcos Pacheco","George Bruno  ","George Bruno",/,
                                           "2 José Carlos" ,"Antônio       ","Paulo Henrique","George Bruno",/,
                                          ];
                                   FooterCols="soma Columm1","soma Columm2","soma Columm3","soma Columm4";
                                   NOTFOUND="Mensagem em caso de erro";
                                   template="<Table id="table">
                                               <thead>
                                                 <tr>~Alias</tr> <br>
                                                 <tr>
                                                   ~HeaderCols <br>
                                                 <tr>
                                               </thead>

                                               <tbody>
                                                 ~OneRowCols <br>
                                               </tbody>

                                               <tfoot>
                                                ~FooterCols <br>
                                               </tfoot>

                                            </Table>"
                                  ]
                         -]
           #-->


         ```

    }
    public class function StringReplaceTgTable(
                       Const aAlias  : string; //="Teste de tabelas";
                       Const aHeaderCols : string; //="Column1","Column2",...";
                       Const aOneRowCols : string; //="Value1","Value2",...;
                       Const aFooterCols : string; //="soma_value1","soma_value2",...;
                       Const aNotFound : string;//="Mensagem em caso de erro"
                       Const aTypeTable:String; // miTable ou table
                       Const aTemplate :String  //<table>......</table>
                   ):string;

    {: O método **@name** Executa o evento OnHTMLTag_tgCustom se o mesmo for
       assinalado visualmente ou não pelo usuário para preencher as tags do tipo
       tgCustom.}

    protected procedure DoOnHTMLTag_tgCustom  (Sender: TObject; const TagString: String;TagParams: TStringList; var ReplaceText: String);Virtual;

    {: O método **@name** Executa o evento OnHTMLTag_tgLink se o mesmo for
       assinalado visualmente ou não pelo usuário para preencher as tags do tipo tgLink.}
    protected procedure DoOnHTMLTag_tgLink    (Sender: TObject; const TagString: String;TagParams: TStringList; var ReplaceText: String);Virtual;

    {: O método **@name** Executa o evento OnHTMLTag_tgImage se o mesmo for
       assinalado visualmente ou não pelo usuário para preencher as tags do tipo
       tgImage.}
    protected procedure DoOnHTMLTag_tgImage   (Sender: TObject; const TagString: String;TagParams: TStringList; var ReplaceText: String);Virtual;

    {: O método **@name** Executa o evento OnHTMLTag_tgTable se o mesmo for
       assinalado visualmente ou não pelo usuário para preencher as tags do tipo
       tgTable.}
    protected procedure DoOnHTMLTag_tgTable   (Sender: TObject; const TagString: String;TagParams: TStringList; var ReplaceText: String);Virtual;

    {: O método **@name** Executa o evento OnHTMLTag_tgImageMap se o mesmo for
       assinalado visualmente ou não pelo usuário para preencher as tags do tipo
       tgImageMap.}
    protected procedure DoOnHTMLTag_tgImageMap(Sender: TObject; const TagString: String;TagParams: TStringList; var ReplaceText: String);Virtual;

    {: O método **@name** Executa o evento OnHTMLTag_tgObject se o mesmo for
       assinalado visualmente ou não pelo usuário para preencher as tags do tipo
       tgObject.}
    protected procedure DoOnHTMLTag_tgObject  (Sender: TObject; const TagString: String;TagParams: TStringList; var ReplaceText: String);Virtual;

    {: O método **@name** Executa o evento OnHTMLTag_tgEmbed se o mesmo for
       assinalado visualmente ou não pelo usuário para preencher as tags do tipo
       tgEmbed.}
    protected procedure DoOnHTMLTag_tgEmbed   (Sender: TObject; const TagString: String;TagParams: TStringList; var ReplaceText: String);Virtual;

    {: O método **@name** Executa o evento OnHTMLTag_tgVideo se o mesmo for
       assinalado visualmente ou não pelo usuário para preencher as tags do tipo
       tgVideo.}
    protected procedure DoOnHTMLTag_tgVideo   (Sender: TObject; const TagString: String;TagParams: TStringList; var ReplaceText: String);Virtual;

    {: O método **@name** Executa o evento OnHTMLTag_tgAudio se o mesmo for
       assinalado visualmente ou não pelo usuário para preencher as tags do tipo
       tgAudio.}
    protected procedure DoOnHTMLTag_tgAudio   (Sender: TObject; const TagString: String;TagParams: TStringList; var ReplaceText: String);Virtual;

    {: O método **@name** Executa o evento OnHTMLTag_Undefined se o mesmo for
       assinalado visualmente ou não pelo usuário para preencher as tags
       personalizadas sem uso da tah tbCustom.}
    protected procedure DoOnHTMLTag_Undefined  (Sender: TObject; const TagString: String; TagParams: TStringList; out ReplaceText: String);virtual;

    {: O método @name
    }
    protected procedure DoReplaceTag_Default(Sender: TObject; const TagString: String;TagParams: TStringList; Out ReplaceText: String);virtual;

    {: O método **@name** retorna para a propriedade **HTMLContent** o documento
       processado pela método FPTemplate.GetContent.

       - **NOTA**
         - Só processa o template se a propriedade **OnHTMLTag** for igual a **true**.
    }
    protected Function GetHTMLContent : AnsiString;Virtual;

    {: A propriedade **@name** retorna o template com as tags processadas.
    }
    Public Property HTMLContent : AnsiString Read GetHTMLContent;// write SetHTMLContent;

    {$REGION '---> Construção da propriedade OnHTMLTag'}
      Private  var _OnHTMLTag : Boolean;
      Private Procedure SetOnHTMLTag(const aOnHTMLTag    : Boolean);
      {: A propriedade **@name** habilita e desabilita a produção de página
         html.

         - **NOTAS**
           - True  : Criar _FPTemplate
           - False : Livra da memória _FPTemplate

         - **EXEMPLO**

            ```pascal

              procedure TBasePageProducer.SetHTMLDoc(const aHTMLDoc: String);
              Begin
                _HTMLDoc := aHTMLDoc;

                OnHTMLTag := true;
                If OnHTMLTag
                Then begin
                       FPTemplate.Template := aHTMLDoc;

                     end;

              end;

            ```
      }
      Public Property OnHTMLTag  : Boolean Read _OnHTMLTag Write SetOnHTMLTag;
    {$ENDREGION}

    {$REGION '---> Construção da propriedade HTMLDoc'}
      private var _HTMLDoc: String;
      Private Procedure SetHTMLDoc(Const aHTMLDoc: String);
      Private Function GetHTMLDoc: String;

      {: A propriedade **@name** contém um string usado como template para
         produção de documentos.

         - **NOTA**
           - A tag **@name** deve ser usada quando temos modelos de template
             em memória e não precisa de arquivo. Ex: Um template pode estar
             no arquivo de recurso, tais como: Template_html_tglink e Tag_html_tgTable.

           - Quando HTMLDoc <> '' então não existe htmlFileResult por não existir a
             propriedadehtmlFile.
      }
      Public Property HTMLDoc  : String Read GetHTMLDoc Write SetHTMLDoc;
    {$ENDREGION}

    {$REGION '---> Construção da propriedade HTMLFile'}
      Protected Procedure SetHTMLFile(Const aHTMLFile: TFileName );Overload;Virtual;

      {: A propriedade **@name** contém o nome do arquivo do template.

         - **Nota:**
           - O arquivo deve estar na pasta de templates.
      }
      Protected Function GetHTMLFile : TFileName;Virtual;

      {: A propriedade **@name** contém o nome do arquivo de template a ser usado
         para produzir a página}
      Public Property HTMLFile : TFileName read GetHTMLFile Write SetHTMLFile;
    {$ENDREGION}

    {$REGION '---> Construção da propriedade HTMLFileResult'}
      private _HTMLFileResult: Tfilename;

      {: A propriedade **@name** contém o nome do arquivo resultado da chamada
         da propriedade HtmlContent

         - **Nota:**
           - O nome do arquivo será o nome do template com a extensão **.html**
             porém na pasta HTML.
      }
      Public Property HTMLFileResult : TFileName read _HTMLFileResult Write _HTMLFileResult;

    {$ENDREGION}

    {: O método **@name** salva no arquivo **FileNameDest** o conteúdo da
       propriedade HTMLContent.
    }
    Public Function  SaveHTMLContentToFile(FileNameDest:AnsiString):Integer;overload ;Virtual;

    {: O método **@name** salva no arquivo **htmlFileResult** o conteúdo da
       propriedade HTMLContent.
    }
    Public Function  SaveHTMLContentToFile:Integer;overload ;Virtual;

    {$REGION '---> Construção da propriedade StartDelimiter'}
      Private _StartDelimiter : TParseDelimiter;
      {: A propriedade **@name** contém a marca inicial de tagParam.

         - **Nota:**
           - Padrão é **<!--#**
      }
      Public Property StartDelimiter : TParseDelimiter read _StartDelimiter write _StartDelimiter;
    {$ENDREGION}

    {$REGION '---> Construção da propriedade EndDelimiter'}
      Private _EndDelimiter : TParseDelimiter;
      {: A propriedade **@name** contém a marca final de tagParam.

         - **Nota:**
           - Padrão é **#-->**
      }
      Public Property EndDelimiter : TParseDelimiter read _EndDelimiter write _EndDelimiter;
    {$ENDREGION}

    {$REGION '---> Construção da propriedade FParamStartDelimiter'}
      Private _ParamStartDelimiter : TParseDelimiter;

      {: A propriedade **@name** contém a marca inicial do parâmetro de tagParam.

         - **Nota:**
           - Padrão é **[**
      }
      Public Property ParamStartDelimiter : TParseDelimiter read _ParamStartDelimiter write _ParamStartDelimiter;
    {$ENDREGION}

    {$REGION '---> Construção da propriedade FParamEndDelimiter'}
      Private _ParamEndDelimiter : TParseDelimiter;
      {: A propriedade **@name** contém a marca final do parâmetro de tagParam.

         - **Nota:**
           - Padrão é **]**
      }
      Public Property ParamEndDelimiter : TParseDelimiter read _ParamEndDelimiter write _ParamEndDelimiter;
    {$ENDREGION}

    {$REGION '---> Construção da propriedade FParamValueSeparator'}
      Private _ParamValueSeparator : TParseDelimiter;
      {: A propriedade **@name** contém a marca de separação entre o parâmetro e o valor dele de tagParam.

         - **Nota:**
           - Padrão é **=**
      }
      Public Property ParamValueSeparator : TParseDelimiter read _ParamValueSeparator write _ParamValueSeparator;
    {$ENDREGION}

    {$REGION '---> Construção da propriedade _AllowTagParams'}
      Private _AllowTagParams : Boolean;
      {: A propriedade **@name** informa se a tags tem modelo simples ou complexo.
         contendo parâmeros internos a tag.

         - **Nota**
           - Se **true** a tags de modelo com parâmetros é permitidos, o evento
             [FOnReplaceTag] é usado para todas as substituições de tags, caso
             seja **false**, o evento [FOnReplaceTag] não será executado.
           - O padrão é **true**.
      }
      Public Property AllowTagParams : Boolean read _AllowTagParams write _AllowTagParams;
    {$ENDREGION}

    {$REGION '---> Construção da propriedade FPTemplate'}

      Private _FPTemplate : TFPTemplate;
      private procedure SetFPTemplate(const a_FPTemplate : TFPTemplate);

      {: A propriedade **@name** é o componente oficial do pacote fcl-web e tem
         como objetivo produzir documento usando <#tag>.

         - Veja o documento **fpTemplate.txt** convertido para html:
           - @html(<a href="./fcl-base/src/fptemplate.html" target="_blank">./fcl-base/src/fptemplate.html ➚</a>)
           - @html(<iframe width="100%" height="100%" src="./fcl-base/src/fptemplate.html" frameborder="0"          allowfullscreen></iframe>)
      }
      Public Property FPTemplate : TFPTemplate read _FPTemplate write SetFPTemplate;
    {$ENDREGION}

    Class procedure delete_quotes_from_ends(var s:string);

    Class Function delete_two_points_from_extremes( s:string):String;

    {: A propriedade **@name** recebe uma tag do tipo tgTable e retorna uma
       tabela preenchida com os parâmetros passado.

       - **PARÂMETROS**
         - atgTable: String;
           - Recebe uma tag no padrão abaixo:

             ```pascal

               <!--# tgTable [- ALUNOS=[Alias="Cadastro de Alunos";
                                        Header="Column1:      ",":Column2:     ",":Column3      ",":Column4    ";
                                        widths="300px"         ,"250px"         ,"150px"         ,"180px";
                                        OneRow=["1 Paulo Sérgio","Marcos Pacheco","George Bruno  ","George Bruno",/,
                                                "2 José Carlos" ,"Antônio       ","Paulo Henrique","George Bruno",/,
                                               ];
                                        Footer="soma Columm1","soma Columm2","soma Columm3","soma Columm4";
                                        NotFound="Mensagem em caso de erro";
                                        template="<Table id="table">
                                                      <thead id="theadAlunos">
                                                         <tr><th colspan="4"> <p  style="text-align: center">  ~Alias  </p> </th>  </tr>
                                                         <tr>~HeaderCols</tr>
                                                      </thead>
                                                      <tbody id="tbodyAlunos">
                                                         ~OneRowCols
                                                      </tbody>
                                                      <tfoot id="tfootAlunos">
                                                         ~FooterCols
                                                      </tfoot>
                                                  </Table>"
                                       ]
                             -]
                  #-->
             ```
         - aNameTable: String;
           - Nome da tabela usado no parâmetro, no exemplo acima a tag ALUNOS.

         - aTypeTable: String

    }
    function GetHtmlTable(atgTable: String;aNameTable,aTypeTable:String):String;virtual;

    {: A propriedade **@name** recebe uma tag do tipo tgImageMap e retorna uma
       tabela preenchida com os parâmetros passado.

       - **TAG EXEMPLO:**



       - **PARÂMETROS**
         - atgImageMap: String;
           - Recebe uma tag igual a essa:
             ```pascal
               <!--# tgImageMap [- img_map=[src="./img/img_map.jpg";
                                            Alt="Imagem teste de imagens clicáveis";
                                            useMap="img_map";
                                            oneRowArea="["target" , "alt_rect"   , "title_rect"   , "href_rect.html"   , "19,53,66,107", "rect",
                                                         "target" , "alt_circle" , "title_circle" , "href_circle.html" , "126,85,34","circle",
                                                         "target" , "alt_poly"   , "title_poly"   , "href_poly.html"   , "202,54,266,52,265,98,247,93,233,97,222,101,207,103,198,98","poly"
                                                        ]";
                                             templateOneRowArea="<area target="~target" alt="~alt" title="~title" href="~href" coords="~coords" shape="~shape">";
                                             templateImageMap="<img src="~src" Alt="~alt" usemap="#~useMap">
                                                                <map name="~useMap" Alt="~Alt">
                                                                   <area shape="default" nohref />
                                                                   ~oneRowArea
                                                                </map>"
                                           ]
                                -]
               #-->

             ```
         - aNameImageMap
           - Nome do mapa de imagem.



    }
    function GetHtmlImageMap(atgImageMap : string;aimg_map:String):String;Virtual;
  end;

type
  {: A classe **@name** usada para produzir documento html, usando modelos html
     ou outro formato de texto qualquer.
  }
  TPageProducer = class(TBasePageProducer)

    {: Veja implementação TBasePageProducer.HTMLFile
    }
    Published Property HTMLFile;

    {: Veja implementação TBasePageProducer.HTMLFileResult
    }
    Published Property HTMLFileResult;

    {: Veja implementação TBasePageProducer.StartDelimiter.
    }
    Published Property StartDelimiter;

    {: Veja implementação TBasePageProducer.EndDelimiter.
    }
    Published Property EndDelimiter;

    {: Veja implementação TBasePageProducer.ParamStartDelimiter.
    }
    Published Property ParamStartDelimiter;

    {: Veja implementação TBasePageProducer.ParamEndDelimiter.
    }
    Published Property ParamEndDelimiter;

    {: Veja implementação TBasePageProducer.ParamValueSeparator.
    }
    Published Property ParamValueSeparator;

    {: Veja implementação TBasePageProducer.HTMLDoc.
    }
    Published Property HTMLDoc;

    {: Veja implementação TBasePageProducer.AllowTagParams.
    }
    published Property AllowTagParams;

    {: Veja implementação TBasePageProducer.OnHTMLTag_tgCustom
    }
    Published Property OnHTMLTag_tgCustom;

    {: Veja implementação TBasePageProducer.OnHTMLTag_tgLink
    }
    Published Property OnHTMLTag_tgLink;

    {: Veja implementação TBasePageProducer.OnHTMLTag_tgImage
    }
    Published Property OnHTMLTag_tgImage;

    {: Veja implementação TBasePageProducer.OnHTMLTag_tgTable
    }
    Published Property OnHTMLTag_tgTable;

    {: Veja implementação TBasePageProducer.OnHTMLTag_tgImageMap
    }
    Published Property OnHTMLTag_tgImageMap;

    {: Veja implementação TBasePageProducer.OnHTMLTag_tgObject
    }
    Published Property OnHTMLTag_tgObject;

    {: Veja implementação TBasePageProducer.OnHTMLTag_tgEmbed
    }
    Published Property OnHTMLTag_tgEmbed;

    {: Veja implementação TBasePageProducer.OnHTMLTag_tgVideo
    }
    Published Property OnHTMLTag_tgVideo;

    {: Veja implementação TBasePageProducer.OnHTMLTag_tgAudio
    }
    Published Property OnHTMLTag_tgAudio;

    {: Veja implementação TBasePageProducer.OnHTMLTag_Undefined
    }
    Published Property OnHTMLTag_Undefined;

  end;


Resourcestring

  {: O recurso **@name** é usado como template para o componente *TBasePageProducer* com
     a finalidade de produzir links variáveis.

     - O evento **OnHTMLTag_tgLink** deve ser usado para preencher as varáveis do
       template.

     - **PARÂMETROS**
       - TagName = Nome do template.
         - Deve ser informado no template

       - ~url    = Endereço do link
         - Deve ser informado no evento **OnHTMLTag_tgLink**

       - ~target = Destino onde a página deve ser aberta, se vazio abre na aba atual.
         - Deve ser informado no evento **OnHTMLTag_tgLink**

       - ~title  = Documentação do link
         - Deve ser informado no evento **OnHTMLTag_tgLink**

       - ~text   = Descrição do link
         - Deve ser informado no evento **OnHTMLTag_tgLink**

     - **Exemplo de uso**:

       ```pascal

          <!--# tgLink [-  PsspAppBr=[a href="~url" target="~target" title="~title"] ~text [/a]  -] #-->

          <!--# tgCustom [- ListFilesText=Arquivo:-"~ListFilesText" -] #-->

       ```
  }
  Template_html_tglink = '<!--# tgLink [- TagName=[a href="~url" target="_blank" title="~title"] ~text [/a]  -] #-->';

  {: O recurso **@name** é usado para criar tabela em um arquivo de modelo.

     - **PARÂMETROS**
       - TagName=[] : Nome da tag
         - Deve ser informado na **tag**;

       - Alias : Título da tabela
         - Deve ser informado na **tag**;

       - Header : Lista os rótulos do título da tabela
         - Deve ser informado na **tag**;

       - widths : Lista as larguras das colunas e alinhamentos onde o : indica
                  se o alinhamento usando as regras do markdown.
         - Deve ser informado na **tag**;

       - OneRow=[] : Matriz do conteúdo com todas as linhas e colunas da tabela,
                     onde o número de colunas deve coincidir  o número de elementos 
                     do Header e número de elementos do widths e o número de elementos
                     do Footer.
         - Deve ser informado na **tag**;

       - NotFound : String com uma mensagem de erro se existir.
         - Deve ser informado na **tag**;

       - Footer   : Lista as somas impressas no rodapé da tabela, podendo ser
                    omitida;
         - Deve ser informado na **tag**;

       - Template : Template de uma tabela onde os parâmetros acima serão
                    inseridos.
         - Deve ser informado na **tag**;

         - **Notas**:
           - Parâmetros obrigatórios do template:
             - id="table", onde o nome table deve ser um elemento .css no heard
               da página.
               - Deve ser informado na **tag**;

             - id="theadTagName", onde a palavra tagName deve ter o mesmo nome
               do parâmetro tagName[] acima;
               - Deve ser informado na **tag**;

             - id="tbodyTagName", onde a palavra tagName deve ter o mesmo nome
               do parâmetro tagName[] acima;
               - Deve ser informado na **tag**;

             - id="tfootTagName", onde a palavra tagName deve ter o mesmo nome
               do parâmetro tagName[] acima;
               - Deve ser informado na **tag**;

             - colspan="4", onde 4 deve ser substituído pelo número de colunas
               a ser mesclada para formar a barra de títulos;
               - Deve ser informado na **tag**;

             - ~Alias : Indica a posição onde o título deve ser inserido;
               - Deve ser informado na **tag**;

             - ~HeaderCols : Indica a posição onde a lista de rótulos deve ser
                             inserida;
               - Deve ser informado na **tag**;

             - ~OneRowCols : Indica a posição onde a matriz de linhas e colunas
                             deve ser inserida;
               - Deve ser informado na **tag**;

             - ~FooterCols : Indica a posição onde a lista Footer deve ser inserida;
               - Deve ser informado na **tag**;

       - **Exemplo de uso**:

         ```pascal
             <!--# tgTable [- ALUNOS=[Alias="Cadastro de Alunos";
                                      Header="Column1:      ",":Column2:     ",":Column3      ",":Column4    ";
                                      widths="300px"         ,"250px"         ,"150px"         ,"180px";
                                      OneRow=["1 Paulo Sérgio","Marcos Pacheco","George Bruno  ","George Bruno",/,
                                              "2 José Carlos" ,"Antônio       ","Paulo Henrique","George Bruno",/,
                                             ];
                                      Footer="soma Columm1","soma Columm2","soma Columm3","soma Columm4";
                                      NotFound="Mensagem em caso de erro";
                                      template="<Table id="table">

                                                 <thead id="theadAlunos">
                                                   <tr><th colspan="4"> <p  style="text-align: center">  ~Alias  </p> </th>  </tr>
                                                   <tr>~HeaderCols</tr>
                                                 </thead>

                                                 <tbody id="tbodyAlunos">
                                                   ~OneRowCols
                                                 </tbody>

                                                 <tfoot id="tfootAlunos">
                                                   ~FooterCols
                                                 </tfoot>
                                                </Table>"
                                     ]
                           -]
             #-->

         ```
     - **NOTAS**
       - As palavras que começam com o sinal **~** são substituídas no evento
         **OnHTMLTag_tgTable** pelos dados informados na própria **tag**, porém
         em caso de omissão do dado, o programa pode inserir uma varável específica.


  }
  Tag_html_tgTable = ''+
    '<!--# tgTable [- TagName=[Alias="Titulo da tabela";'+TConsts.New_Line+
    '                                 Header="Column1: ",":Column2:",":Column3",":Column4" ;'+TConsts.New_Line+
    '                                 widths="300px"    ,"250px"    ,"150px"   ,"180px"    ;'+TConsts.New_Line+
    '                                 OneRow=["   a11  ","    a12  ","  a13r  ","    a14 ",/,'+TConsts.New_Line+
    '                                         "   a21  ","    a22  ","  a23r  ","    a24 ",/,'+TConsts.New_Line+
    '                                        ];'+TConsts.New_Line+
    '                                 Footer="soma Columm1","soma Columm2","soma Columm3","soma Columm4";'+TConsts.New_Line+
    '                                 NotFound="Mensagem em caso de erro";'+TConsts.New_Line+
    '                                 template="<Table id="table">'+TConsts.New_Line+
    '                                               <thead id="theadTagName">'+TConsts.New_Line+
    '                                                  <tr><th colspan="4"> <p  style="text-align: center">  ~Alias  </p> </th>  </tr>'+TConsts.New_Line+
    '                                                  <tr>~HeaderCols</tr>'+TConsts.New_Line+
    '                                               </thead>'+TConsts.New_Line+
    '                                               <tbody id="tbodyTagName">'+TConsts.New_Line+
    '                                                  ~OneRowCols'+TConsts.New_Line+
    '                                               </tbody>'+TConsts.New_Line+
    '                                               <tfoot id="tfootTagName">'+TConsts.New_Line+
    '                                                  ~FooterCols'+TConsts.New_Line+
    '                                               </tfoot>'+TConsts.New_Line+
    '                                           </Table>"'+TConsts.New_Line+
    '                                ]'+TConsts.New_Line+
    '                      -]'+TConsts.New_Line+
    '#-->'+TConsts.New_Line;

  Tag_html_tgImage = ''+
    '<!--# tgImage [- $Param(NomeDaFigura)=[<figure>'+TConsts.New_Line+
    '                                        <img src="~src"'+TConsts.New_Line+
    '                                             alt="~alt"'+TConsts.New_Line+
    '                                             title="~title"'+TConsts.New_Line+
    '                                             style="width:10%">'+TConsts.New_Line+
    '                                        <figcaption>~figcaption</figcaption>'+TConsts.New_Line+
    '                                       </figure>'+TConsts.New_Line+
    '                                      ]'+TConsts.New_Line+
    '              -]'+TConsts.New_Line+
    '#-->'+TConsts.New_Line;



  Tag_html_tgImageMap = ''+
    '<!--# tgImageMap [- $Param(NomeDaImagem)=[ src="./img/$Param(NomeDaImagem).jpg";'+TConsts.New_Line+
    '                                           usemap="$Param(NomeDaImagem)";'+TConsts.New_Line+
    '                                           OneRowArea=["$Param(rect)"   , "$Param(target)" , "$Param(alt_rect)"   , "$Param(title_rect)"   , "$Param(href_rect.html)"   , "$Param(y1),$Param(y1),$Param(x2),$Param(y2)",/,'+TConsts.New_Line+
    '                                                       "$Param(circle)" , "$Param(target)" , "$Param(alt_circle)" , "$Param(title_circle)" , "$Param(href_circle.html)" , "$Param(x1),$Param(y1),$Param(raio)",/,'+TConsts.New_Line+
    '                                                       "$Param(poly)"   , "$Param(target)" , "$Param(alt_poly)"   , "$Param(title_poly)"   , "$Param(href_poly.html)"   , "$Param(x1),$Param(y1),$Param(x2),$Param(y2),$Param(x3),$Param(y3),$Param(x4),$Param(y4)$Param(..),$Param(xn),$Param(yn)",/,'+TConsts.New_Line+
    '                                                       <!-- Adicione aqui ,mais linhas semelhantes a linha acima e apague esse comentário-->'+TConsts.New_Line+
    '                                                      ];'+TConsts.New_Line+
    '                                           templateOneRowArea=<area target="~target" alt="~alt" title="~title" href="~href" coords="~coords" shape="~shape">;'+TConsts.New_Line+
    '                                           templateImageMap="< img src="~src"'+TConsts.New_Line+
    '                                                               alt="~alt"'+TConsts.New_Line+
    '                                                               usemap="#~usemap">'+TConsts.New_Line+
    '                                                               <map name="~usemap">'+TConsts.New_Line+
    '                                                                  <area shape="default" nohref />'+TConsts.New_Line+
    '                                                                  ~OneRowArea'+TConsts.New_Line+
    '                                                               </map>"'+TConsts.New_Line+
    '                                         ]'+TConsts.New_Line+
    '                 -]'+TConsts.New_Line+
    '#-->'+TConsts.New_Line;


procedure register;

implementation

procedure register;
begin
  {$I mi.rtl.objects.methods.pageproducer_icon.lrs}
  RegisterComponents('Mi.Rtl', [TPageProducer]);
end;

constructor TBasePageProducer.create(aOwner:TComponent);
begin
  inherited create(aOwner);
  _FPTemplate := TFPTemplate.Create;

  StartDelimiter      := DefaultStartDelimiter;
  EndDelimiter        := DefaultEndDelimiter;

  ParamStartDelimiter := DefaultParamStartDelimiter;
  ParamValueSeparator := DefaultParamValueSeparator;
  ParamEndDelimiter   := DefaultParamEndDelimiter;

  AllowTagParams      := DefaultAllowTagParams;
  FPTemplate.OnReplaceTag  := DoReplaceTag_Default;//DoOnHTMLTagEvent;
end;

destructor TBasePageProducer.destroy;
begin
  freeAndnil(_FPTemplate);
  inherited destroy;
end;

function TBasePageProducer.GetID_Dinamic: AnsiString;
begin
  if _ID_Dinamic = ''
  then _ID_Dinamic := _ID_Dinamic;

  result := _ID_Dinamic;
end;

class function TBasePageProducer.ListFilesText(const aTagName, atemplate, aPath,  aMask: String): string;
  var
    ListFiles : TStringList;
    i : Integer;
begin
  ListFiles := TStringList.Create;
  try
    Result := New_Line;
    // Retorna todos os arquivos da pasta e subpastas
    FindFilesAll(aPath,aMask,faArchive,true ,ListFiles,true);
    For i := 0 to ListFiles.Count-1 do
    begin
      Result := result + StringReplace(atemplate,'~'+aTagName  , ListFiles.Strings[i]  , [rfReplaceAll]);
    end;
  finally
    FreeAndNil(ListFiles);
  end;
end;

class function TBasePageProducer.StringReplaceTgImage(const aTemplate, aSrc,
                                                      aAlt, aTitle, aFigcaption: String): string;
begin
  try
    result :=  atemplate;
    Result := StringReplace(Result, '~src'        , aSrc   , [rfReplaceAll]);
    Result := StringReplace(Result, '~alt'        , aAlt   , [rfReplaceAll]);
    Result := StringReplace(Result, '~title'      , aTitle , [rfReplaceAll]);
    Result := StringReplace(Result, '~figcaption' , aFigcaption , [rfReplaceAll]);
    Result := StringReplace(Result, '['           , ' ', [rfReplaceAll]);
    Result := StringReplace(Result, ']'           , ' ', [rfReplaceAll]);
  finally
  end;
end;

class function TBasePageProducer.StringReplaceTgLink(const aAlias,atemplate,aURL,atarget,aTitle,aText:String):string;
begin
   result :=  atemplate;
   Result := StringReplace(Result, '~alias'  , aAlias  , [rfReplaceAll]);
   Result := StringReplace(Result, '~url'    , aURL    , [rfReplaceAll]);
   Result := StringReplace(Result, '~target' , atarget , [rfReplaceAll]);
   Result := StringReplace(Result, '~title'  , aTitle, [rfReplaceAll]);
   Result := StringReplace(Result, '~text'   , aText, [rfReplaceAll]);
   Result := StringReplace(Result, '['       , '<', [rfReplaceAll]);
   Result := StringReplace(Result, ']'       , '>', [rfReplaceAll]);
end;

class function TBasePageProducer.StringReplaceTgTable(
                    const aAlias: string;
                    const aHeaderCols: string; const aOneRowCols: string;
                    const aFooterCols: string; const aNotFound: string;
                    const aTypeTable: String; const aTemplate: String): string;
begin
  result :=  atemplate;
  Result := StringReplace(Result, '~Alias'      , DeleteChars(aAlias,['"']) , [rfReplaceAll]);
  Result := StringReplace(Result, '~HeaderCols' , aHeaderCols , [rfReplaceAll]);
  Result := StringReplace(Result, '~OneRowCols' , aOneRowCols , [rfReplaceAll]);
  Result := StringReplace(Result, '~FooterCols' , aFooterCols , [rfReplaceAll]);
  Result := StringReplace(Result, '~NotFound'   , aNotFound   , [rfReplaceAll]);
  Result := StringReplace(Result, '~TypeTable'  , aTypeTable  , [rfReplaceAll]);
end;

procedure TBasePageProducer.DoOnHTMLTag_tgCustom(Sender: TObject;const TagString: String; TagParams: TStringList; var ReplaceText: String);
begin
  if Assigned(OnHTMLTag_tgCustom)
  then OnHTMLTag_tgCustom(Sender,TagString,TagParams,ReplaceText);
end;

procedure TBasePageProducer.DoOnHTMLTag_tgLink(Sender: TObject; const TagString: String; TagParams: TStringList; var ReplaceText: String);
begin
  if Assigned(OnHTMLTag_tgLink)
  then OnHTMLTag_tgLink(Sender,TagString,TagParams,ReplaceText);
end;

procedure TBasePageProducer.DoOnHTMLTag_tgImage(Sender: TObject;  const TagString: String; TagParams: TStringList; var ReplaceText: String);
begin
  if Assigned(OnHTMLTag_tgImage)
  then OnHTMLTag_tgImage(Sender,TagString,TagParams,ReplaceText);
end;

procedure TBasePageProducer.DoOnHTMLTag_tgTable   (Sender: TObject; const TagString: String;TagParams: TStringList; var ReplaceText: String);

 {Original:
   tgTable  = The TagString parameter is TABLE.
              The TagParams describe a desired tabular image.
              The event handler should return a sequence of HTML commands beginning with a
              <TABLE> tag and ending with a </TABLE> tag.

   tgTable = O parametro de TagString e TABELA.
             O TagParams descrevem uma imagem tabelar desejada.
             O manipulador de evento deveria devolver uma sucessão de comandos de HTML que comecam com um
             <TABLE> etiqueta e terminando com um </TABLE> etiqueta.

   TAG=<#TABLE#>
 }

 Begin
   if Assigned(OnHTMLTag_tgTable)
   then OnHTMLTag_tgTable(Sender,TagString,TagParams,ReplaceText);
 end;

procedure TBasePageProducer.DoOnHTMLTag_tgImageMap(Sender: TObject; const TagString: String;TagParams: TStringList; var ReplaceText: String);
Begin
 if Assigned(OnHTMLTag_tgImageMap)
 then OnHTMLTag_tgImageMap(Sender,TagString,TagParams,ReplaceText);
end;

procedure TBasePageProducer.DoOnHTMLTag_tgObject  (Sender: TObject; const TagString: String;TagParams: TStringList; var ReplaceText: String);
Begin
 if Assigned(OnHTMLTag_tgObject)
 then OnHTMLTag_tgObject(Sender,TagString,TagParams,ReplaceText);

end;

procedure TBasePageProducer.DoOnHTMLTag_tgEmbed   (Sender: TObject; const TagString: String;TagParams: TStringList; var ReplaceText: String);
Begin
 if Assigned(OnHTMLTag_tgEmbed)
 then OnHTMLTag_tgEmbed(Sender,TagString,TagParams,ReplaceText);
end;

procedure TBasePageProducer.DoOnHTMLTag_tgVideo(Sender: TObject;
  const TagString: String; TagParams: TStringList; var ReplaceText: String);
begin
 if Assigned(OnHTMLTag_tgVideo)
 then _OnHTMLTag_tgVideo(Sender,TagString,TagParams,ReplaceText);
end;

procedure TBasePageProducer.DoOnHTMLTag_tgAudio(Sender: TObject;
  const TagString: String; TagParams: TStringList; var ReplaceText: String);
begin
 if Assigned(OnHTMLTag_tgAudio)
 then OnHTMLTag_tgAudio(Sender,TagString,TagParams,ReplaceText);
end;

procedure TBasePageProducer.DoOnHTMLTag_Undefined(Sender: TObject;const TagString: String; TagParams: TStringList; out ReplaceText: String);
begin
 if Assigned(OnHTMLTag_Undefined)
 then OnHTMLTag_Undefined(Sender,TagString,TagParams,ReplaceText);
end;

procedure TBasePageProducer.DoReplaceTag_Default(Sender: TObject;    const TagString: String; TagParams: TStringList; out ReplaceText: String);
begin
 case AnsiIndexStr(UpperCase(TagString),
      ['ALIAS','ID','TGCUSTOM','TGLINK','TGIMAGE','TGTABLE','TGIMAGEMAP','TGOBJECT','TGEMBED']) of
   0 : ReplaceText := Self.ALIAS;
   1 : ReplaceText := ID_Dinamic;
   2 : DoOnHTMLTag_tgCustom(Sender,TagString,TagParams,ReplaceText);
   3 : DoOnHTMLTag_tgLink(Sender,TagString,TagParams,ReplaceText);
   4 : DoOnHTMLTag_tgImage(Sender,TagString,TagParams,ReplaceText);
   5 : DoOnHTMLTag_tgTable(Sender,TagString,TagParams,ReplaceText);
   6 : DoOnHTMLTag_tgImageMap(Sender,TagString,TagParams,ReplaceText);
   7 : DoOnHTMLTag_tgObject(Sender,TagString,TagParams,ReplaceText);
   8 : DoOnHTMLTag_tgEmbed(Sender,TagString,TagParams,ReplaceText);
   else DoOnHTMLTag_Undefined(Sender,TagString,TagParams,ReplaceText);
 end;
end;

procedure TBasePageProducer.SetOnHTMLTag(const aOnHTMLTag: Boolean);
Begin
   If aOnHTMLTag
   Then with TObjectsMethods do
        Begin
          //se tiver assinalado deve ser descartado
          If isValidPtr(_FPTemplate)
          Then Discard(TObject(_FPTemplate));
          If FPTemplate=nil
          Then Begin
                 FPTemplate := TFPTemplate.Create;
                 //FPTemplate.StripParamQuotes := false; Não encontrei no fptemplate
               End;

         _OnHTMLTag := True;
        End
   Else Begin
          TObjectsMethods.Discard(TObject(_FPTemplate));
          _OnHTMLTag := false;
        End;
End;

procedure TBasePageProducer.SetHTMLFile(const aHTMLFile: TFileName);
Begin
  If (aHTMLFile='') or (TObjectsMethods.FileExists(aHTMLFile))
  Then Begin
         OnHTMLTag := true;
         If OnHTMLTag
         Then begin
                 //function ExtractRelativePath(const BaseName, DestName: string): string; overload;
                 FPTemplate.FileName:= aHTMLFile
              end;
       End
  Else Begin
         OnHTMLTag := False;
         TObjectsMethods.TaStatus  := TObjectsMethods.ArquivoNaoEncontrado2;
       end;
end;

function TBasePageProducer.GetHTMLFile: TFileName;
Begin
  If OnHTMLTag
  Then Result := FPTemplate.FileName
  Else Result := '';
end;

function TBasePageProducer.SaveHTMLContentToFile(FileNameDest: AnsiString): Integer;
  Var
    PathDest : AnsiString;
    F        : Text;

begin
  Result := -1;
  If OnHTMLTag
  Then with TObjectsMethods do
       Begin
         Try  //Except
           PathDest := ExtractFileDir(FileNameDest);

           if Not DirectoryExists(PathDest)
           Then ok := CreateDir(PathDest)
           Else ok := true;

           If ok
           Then Begin
                  AssignFile(F,FileNameDest);

                  {$I+}
                  rewrite(f);
                  {$I-}

                  Result := IoResult ;

                  If Result = 0
                  Then Begin
                         {$I+}
                         write(F,self.HTMLContent);
                         {$I-}
                         Result := IoResult;

                         close(f) ;
                       End;

                End;
         Except
           if Result = 0
           then Result :=   Erro_Excecao_inesperada ;
           Raise
         end;
       End;
end;

function TBasePageProducer.SaveHTMLContentToFile: Integer;
Begin
  Result := SaveHTMLContentToFile(HTMLFileResult);
End;

procedure TBasePageProducer.SetFPTemplate(const a_FPTemplate: TFPTemplate);
begin
  _FPTemplate := a_FPTemplate;
  if Assigned(_FPTemplate)
  then begin
         _FPTemplate.StartDelimiter := StartDelimiter;
         _FPTemplate.EndDelimiter   := EndDelimiter ;
         _FPTemplate.ParamStartDelimiter := ParamStartDelimiter;
         _FPTemplate.ParamEndDelimiter := ParamEndDelimiter;
         _FPTemplate.ParamValueSeparator := ParamValueSeparator;
         _FPTemplate.AllowTagParams      := AllowTagParams;
         _FPTemplate.StartDelimiter      := StartDelimiter;
         _FPTemplate.EndDelimiter        := EndDelimiter;
         _FPTemplate.OnReplaceTag        := DoReplaceTag_Default;//DoOnHTMLTagEvent;
       end;
end;

procedure TBasePageProducer.SetHTMLDoc(const aHTMLDoc: String);
Begin
  _HTMLDoc := aHTMLDoc;

  OnHTMLTag := true;
  If OnHTMLTag
  Then begin
         FPTemplate.Template := aHTMLDoc;

       end;

end;

//procedure TBasePageProducer.SetHTMLFile;
//begin
//
//
//end;

function TBasePageProducer.GetHTMLDoc: String;
Begin
  If OnHTMLTag
  Then Result := FPTemplate.Template
  Else Result := '';
end;

function TBasePageProducer.GetHTMLContent: AnsiString;
{< NortSoft
   Retorna O código HTML implementados em:
     1 - TvDialogs.TButton      Retorna o código Html associado ao botão
     2 - ViEditor.TDmxEditor    Retorna o código Html associado ao Dmx
     3 - ViEditor.TLIsDialog   Retorna a lista html
     4 - tvDMXBUF.TDmxEditBuf;  Retorna o formulário em forma de gride
     5 - View.TWindow           Retorna todos os códigos html dentro da windows
     6 - TvDialogs.TDialog      Retorna o formulário completo <html lang="pt-BR"><head> </head> <bodY>  </body></html
}
Begin
  If OnHTMLTag
  Then Result := FPTemplate.GetContent
  Else Result := '';
end;

class procedure TBasePageProducer.delete_quotes_from_ends(var s:string);
begin
  //Remove aspa da posição 1;
  system.Delete(s,1,1);
  //Remove aspa da posição length(s);
  system.Delete(s,length(s),1);
end;

class function TBasePageProducer.delete_two_points_from_extremes(s: string
  ): String;
begin
  with TPageProducer do
    result := DelSpcED(s);

  //Remove pontos da posição 1;
  if result[1]= ':'
  then system.Delete(result,1,1);

  //Remove pontos da posição length(s);
  if pos(':',copy(Result,length(Result))) <> 0
  then system.Delete(Result,length(Result),1);
end;

function TBasePageProducer.GetHtmlTable(atgTable:string;aNameTable,aTypeTable:String):String;

  function GetAlignCol_Markdown(aRotulo:String):String;
  begin
    With TPageProducer do
      result := DelSpcED(aRotulo);

    if pos(':',result)<>0
    then begin
           if pos(':',result)= 1
           then begin
                  if pos(':',copy(result,2,Length(result)))<>0
                  then Result := 'Center'
                  else Result := 'Left';
                end
           else Result := 'Right';
         end
         else Result := 'Center';//Não informado o alinhamento.
  end;

  (*: O método **@name** cria um arquivos .css para definir a largura
      e alinhamento de cada coluna da tabela

      - Formato do arquivo a ser gerado é do tipo texto com os seguintes
        linhas, dependendo do número de colunas da tabela passada pelo
        template que está sendo processado no momento.

          #thead1 th:nth-child(1) {  width: size1;text-align:Center;}
          #thead1 th:nth-child(2) {  width: size2;text-align:Center;}
    ..............................................
          #thead1 th:nth-child(4) {  width: sizen;text-align:Center;}

          #tbody1 td:nth-child(1) {  width: size1;text-align:Center;}
          #tbody1 td:nth-child(2) {  width: size2;}
    ..............................................
          #tbody1 td:nth-child(4) {  width: sizen;text-align:Center;}

          #tfoot1 td:nth-child(1) {  width: size1;text-align:Center;}
          #tfoot1 td:nth-child(2) {  width: size2;text-align:Center;}
    ..............................................
          #tfoot1 td:nth-child(4) {  width: sizen;text-align:Center;}
  *)
  Procedure create_Css_Cols_Table(aNameTable, aHeaderCols,aWidths:String);

    function StringReplaceTgCss(aNameTable:String;

                                aCol : Integer;
                                aSize:String;
                                aAlign:String;
                                const aTemplate: String):string;
    begin
      result :=  atemplate;
      Result := StringReplace(Result, '~NameTable' , aNameTable     , [rfReplaceAll]);
      Result := StringReplace(Result, '~col'       , IntToStr(aCol) , [rfReplaceAll]);
      Result := StringReplace(Result, '~size'      , aSize          , [rfReplaceAll]);
      Result := StringReplace(Result, '~align'    , aAlign          , [rfReplaceAll]);

    end;


    Type
      TTemplateCol = Record
        thead : String;
        tbody : string;
        tfoot : string;
      end;

    var
      ListHeaderCols : TMiStringList;
      ListWidthCols : TMiStringList;
      FileCss       : TMiStringList;

    Var
      T : TTemplateCol = (thead:'#thead~NameTable th:nth-child(~col) {width:~size;text-align:~align;}';
                          tbody:'#tbody~NameTable td:nth-child(~col) {width:~size;text-align:~align;}';
                          tfoot:'#tfoot~NameTable td:nth-child(~col) {width:~size;text-align:~align;}'
                         );
      i : integer;
      s : string = '';
      AlignCol : string = 'left';
  begin
//    With TObjectss do
    try
      ListHeaderCols := TMiStringList.Create;
      ListHeaderCols.AddTagValue(aHeaderCols);

      ListWidthCols := TMiStringList.Create;
      ListWidthCols.AddTagValue(aWidths);

      FileCss :=  TMiStringList.Create;
      FileCss.Clear;
      for i := 0 to ListWidthCols.Count-1 do
      begin
        s := ListWidthCols.Strings[i];
        with t do
        begin
          AlignCol := GetAlignCol_Markdown(ListHeaderCols.Strings[i]);
          FileCss.Add(StringReplaceTgCss(aNameTable,
                                         i+1,
                                         s,
                                         AlignCol,
                                         thead));
          FileCss.Add(StringReplaceTgCss(aNameTable,
                                         i+1,
                                         s,
                                         AlignCol,
                                         tbody));
          FileCss.Add(StringReplaceTgCss(aNameTable,
                                         i+1,
                                         s,
                                         AlignCol,
                                         tfoot));

        end;

      end;

      FileCss.SaveToFile(ExpandFileName(ExtractFileDir(HTMLFileResult)+'/css/'+aNameTable+'.css'));

    finally
      Freeandnil(ListHeaderCols);
      Freeandnil(ListWidthCols);
      Freeandnil(FileCss);
    end;
  end;

  Function GetTable(aAlias      : string; //="Teste de tabelas";
                    aHeaderCols : string; //="Column1","Column2",...";
                    aOneRowCols : string; //="Value1","Value2",...;
                    aFooterCols : string; //="soma_value1","soma_value2",...;
                    aNotFound : string;//="Mensagem em caso de erro"
                    aTypeTable:String; // miTable ou table
                    aTemplate :String //<table>......</table>
                   ): string;
    var
      ListHeaderCols : TMiStringList;
      ListOneRowCols : TMiStringList;
      ListFooterCols : TMiStringList;

      Function GetRowCols(aList:TMiStringList):String;
        var
          i : integer;
          AchouBarra  : Boolean = true;
      Begin
//        With TObjectss do
        begin
          Result := '';
          For i := 0 to aList.Count-1 do
          begin
            if AchouBarra and (aList.Strings[i] = '/')
            Then begin
                   Result := Result + '</tr>'+New_Line;
                   AchouBarra := false;
                 end;

            if (not AchouBarra) and (aList.Strings[i] = '/')
            Then begin
                   Result := Result + '</tr>'+New_Line;
                   Result := Result + '<tr>'+New_Line;
                   AchouBarra := true;
                 end;

            if (aList.Strings[i] <> '/')
            then begin
                   if ListHeaderCols<>aList
                   then begin
                           Result := Result + '<td>';
                           Result := Result + aList.Strings[i];
                           Result := Result + '</td>';
                        end
                   else begin
                           Result := Result + '<th>';
                           Result := Result + delete_two_points_from_extremes(aList.Strings[i]);
                           Result := Result + '</th>';
                        end;
                end;
          end;
          if AchouBarra
          Then begin
                 Result := Result + '</tr>'+New_Line;;
                 AchouBarra := false;
                end;
        end;
      end;

  begin
//    With TObjectss, TPageProducer do
    try

      ListHeaderCols := TMiStringList.Create;
      ListHeaderCols.AddTagValue(aHeaderCols);

      ListOneRowCols := TMiStringList.Create;
      ListOneRowCols.AddTagValue(aOneRowCols);

      ListFooterCols := TMiStringList.Create;
      ListFooterCols.AddTagValue(aFooterCols);

      aHeaderCols := GetRowCols(ListHeaderCols);
      aOneRowCols := GetRowCols(ListOneRowCols);
      aFooterCols := GetRowCols(ListFooterCols);

      delete_quotes_from_ends(aTemplate);
      Result :=StringReplaceTgTable(aAlias,
                                    aHeaderCols,
                                    aOneRowCols,
                                    aFooterCols,
                                    aNotFound,
                                    aTypeTable,
                                    aTemplate);

    Finally
      ListHeaderCols.Free;
      ListOneRowCols.Free;
      ListFooterCols.Free;
    end;

  end;


  Var
    Params: TMiStringList;
begin
  if aTgTable <> '' Then
  begin
    try
      Params := TMiStringList.Create;
      Params.AddTag(aTgTable);
      Result := GetTable( Params.Values['Alias'],
                          Params.Values['Header'],
                          Params.Values['OneRow'],
                          Params.Values['Footer'],
                          Params.Values['NotFound'],
                          aTypeTable,
                          Params.Values['Template']
                                                  );
      create_Css_Cols_Table(aNameTable,Params.Values['Header'],Params.Values['widths']);
    finally
      Freeandnil(Params);
    end;
  end
  else Result := '';
end;


function TBasePageProducer.GetHtmlImageMap(aTgImageMap : string;aimg_map:String):String;


  Function GetImageMap(aSrc,    // Arquivo com a imagem
                       aAlt,    // Nome da imagem caso a imagem não exista
                       aUsemap, // Nome do mapa associado ao aqruivo de imagem
                       aOneRowArea, //["Value1","Value2",...];
                       atemplateOneRowArea, // Template da área de cada linha
                       templateImageMap :String //<img> <Map>......</Map>
                   ): string;
    var
      ListOneRowArea : TMiStringList;

      {: O método **@name** cria um arquivos das áreas clicáveis:

         - Os elementos de área estão em uma lista;

         - Exemplo:
          ´´´html
            <area target="~target" alt="~alt" title="~title" href="~href" coords="~coords" shape="~shape">
            <area target="~target" alt="~alt" title="~title" href="~href" coords="~coords" shape="~shape">
            <area target="~target" alt="~alt" title="~title" href="~href" coords="~coords" shape="~shape">
            <area target="~target" alt="~alt" title="~title" href="~href" coords="~coords" shape="~shape">
          ´´´
      }
      Function GetOneRowArea(aList:TMiStringList):String;

        //aTemplate: <area target="~target" alt="~alt" title="~title" href="~href" coords="~coords" shape="~shape">;
        function StringReplaceTgArea(Const atarget, aAlt,aTitle,aHref,aCoords,aShape: String):String;
        begin
          result := atemplateOneRowArea;
          Result := StringReplace(Result, '~target' , atarget    , [rfReplaceAll]);
          Result := StringReplace(Result, '~alt'    , aAlt       , [rfReplaceAll]);
          Result := StringReplace(Result, '~title'  , aTitle     , [rfReplaceAll]);
          Result := StringReplace(Result, '~href'   , aHref      , [rfReplaceAll]);
          Result := StringReplace(Result, '~coords' , aCoords    , [rfReplaceAll]);
          Result := StringReplace(Result, '~shape'  , aShape     , [rfReplaceAll]);
        end;

        var
          n   : integer;
          Col : Integer = 5;
          i : Integer = 0;
      Begin
        Result := '';
        n := aList.Count -1;
        while i <= n do
        begin
          // Atualiza com o valores da lista que obrigatoriamente deve esta na nesta ordem
          // atemplateOneRowArea= <area target="~target" alt="~alt" title="~title" href="~href" coords="~coords" shape="~shape">;
          // Algoritimo para pegar o e-nésimo elemento da lista
          // a1,b1,c1,a2,b2,c2
          // 0  1  2  3  4  5

          // i = 0
              // a1 = ai = i+0 = 2*0+0 = 0;
              // a2 = ai = i+1 = 2*0+1 = 1;
              // a3 = ai = i+2 = 2*0+2 = 2;

          // i = i + 2+1
              // a4 = ai = i+0 = 2*1+0 = 3;
              // a5 = ai = i+1 = 2*1+1 = 4;
              // a6 = ai = i+2 = 2*1+2 = 5;

          //Generalizando
             //Loop
             // i =0
             // target = ai = i+0;
             // alt    = ai = i+1;
             // title  = ai = i+2;
             // href   = ai = i+3;
             // coords = ai = i+4;
             // shape  = ai = i+5;
             // i:= i+5;

          Result := Result + StringReplaceTgArea(aList.Strings[i+0],//atarget
                                                 aList.Strings[i+1],//aAlt
                                                 aList.Strings[i+2],//aTitle
                                                 aList.Strings[i+3],//aHref
                                                 aList.Strings[i+4],//aCoords
                                                 aList.Strings[i+col] //aShape
                                                 )+ New_Line;
          inc(i,Col+1);
        end;
      end;

      function StringReplaceTgImageMap():String;
      begin
       result :=  templateImageMap;
       Result := StringReplace(Result, '~src'        , aSrc        , [rfReplaceAll]);
       Result := StringReplace(Result, '~alt'        , aAlt        , [rfReplaceAll]);
       Result := StringReplace(Result, '~useMap'     , aUsemap     , [rfReplaceAll]);
       Result := StringReplace(Result, '~oneRowArea' , aOneRowArea , [rfReplaceAll]);
      end;

  begin
    try
      ListOneRowArea := TMiStringList.Create;
//      ListOneRowArea.testTags2;
      ListOneRowArea.AddTagValue(aOneRowArea);
      aOneRowArea := GetOneRowArea(ListOneRowArea);

      Result :=StringReplaceTgImageMap();

    Finally
      ListOneRowArea.Free;
    end;

  end;


  Var
    s1,s2,s3,s4,s5,s6 : string;
    Params: TMiStringList;
begin
  if aTgImageMap <> '' Then
  begin
    try
      Params := TMiStringList.Create;
      Params.AddTag(aTgImageMap);

      s1 := Params.Values['src'];
      delete_quotes_from_ends(s1);

      s2 := Params.Values['alt'];
      delete_quotes_from_ends(s2);

      s3 := Params.Values['useMap'];
      delete_quotes_from_ends(s3);

      s4 := Params.Values['oneRowArea'];
      delete_quotes_from_ends(s4);

      s5 := Params.Values['templateOneRowArea'];
      delete_quotes_from_ends(s5);

      s6 := Params.Values['templateImageMap'];
      delete_quotes_from_ends(s6);

      Result := GetImageMap( s1, s2,  s3, s4, s5,s6);

    finally
      Freeandnil(Params);
    end;
  end
  else Result := '';
end;


end.
