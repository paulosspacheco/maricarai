# Teste do componente TPageProducer

- [Teste do componente TPageProducer](#teste-do-componente-tpageproducer)
  - [Tag genérica podendo ser qualquer tipo de código](#tag-genérica-podendo-ser-qualquer-tipo-de-código)
  - [Tag TgCustom](#tag-tgcustom)
  - [**Teste da tag TgLink**](#teste-da-tag-tglink)
  - [Tag TgTable](#tag-tgtable)
  - [Tag TgImage](#tag-tgimage)
  - [Tag TgMapImage](#tag-tgmapimage)

## Tag genérica podendo ser qualquer tipo de código

1. A tag abaixo preenche a data e hora atual no formato: **"DD/MM/YYYY hh:mm:ss"**
   1. &lt;--# DATETIME [-FORMAT=MM/DD hh:mm:ss-] #-->
      1. **Resultado não definida:**
         1. Data e hora: <!--# DATETIME [-FORMAT=DD/MM/YYYY hh:mm:ss-] #-->

## Tag TgCustom

1. A tag abaixo informa ao componente _TPageProduce_ que deve executar o método ListFilesText.
   1. &lt;--# tgCustom [- ListFilesText=Arquivo: -"~ListFilesText" -] #-->
      - Formato de saída:
        - Arquivo: - xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        - Arquivo: - xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        - ...
        - Arquivo: - xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
   2. **Resultado TgCustom com parâmetro ListFilesText :**

         ```html

            <!--# tgCustom [- ListFilesText=
                 Arquivo:
                 -"~ListFilesText" -]
            #-->

         ```

2. **NOTA:**
    1. A tag _ListFilesText_ executa o código TPageProducer.ListFilesText() no qual retorna uma lista de nomes de arquivos da pasta corrente e subpastas no formato informado pela tag.

## **Teste da tag TgLink**

1. A tag **TgLink** com parâmetro **BlogPsspAppBr** deve ser preenchida com o link para: http://www.pssp.app.br, onde o destino da visualização é uma nova aba do browser.
   1. &lt;!--# tgLink [- BlogPsspAppBr=[a href="~url" target="_blank" title="~title"] ~text [/a]  -] #-->
   2. **Resultado da combinação de tag TgLink e BlogPsspAppBr:**
      1. <!--# tgLink [- BlogPsspAppBr=[a href="~url" target="_blank" title="~title"] ~text [/a]  -] #-->

2. A tag **TgLink** com parâmetro **PsspAppB** deve ser preenchida com o endereço: http://www.pssp.app.br. onde o destino da visualização é uma variável definida no ato da produção da página:
   1. &lt;!--# tgLink [-  PsspAppBr=[a href="~url" target="~target" title="~title"] ~text [/a]  -] #-->
   2. **Resultado da combinação de tag TgLink e PsspAppBr:**
      1. <!--# tgLink [-  PsspAppBr=[a href="~url" target="~target" title="~title"] ~text [/a]  -] #-->

3. A tag **TgLink** com parâmetro **FindFileAll** para listar links de nomes dos arquivos da pasta atual e subpastas**.
    1. Tag FindFilesAll
       1. &lt;--# tgLink [- FindFilesAll=[a href="~url" target="_blank" title="~title"] ~text [/a]  -] -->
          1. Resultado da combinação de tag TgLink e FindFilesAll:
             1. <!--# tgLink [- FindFilesAll=[a href="~url" target="_blank" title="~title"] ~text [/a]  -] #-->

## Tag TgTable

1. Template para preencher os dados da tabela _ALUNOS_, onde o _id="table"_.
   1. Esse modelo de tabela tem rodapé.

   ```html
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

2. Template para preencher os dados da tabela _ALUNOS2_, onde o _id="~TypeTable"_.
   1. Esse modelo de tabela não tem rodapé.

   ```html
      <!--# tgTable [- ALUNOS2=[Alias="Cadastro de Alunos 2";
                                 Header="Column1",":Column2:",":Column3",":Column4","Column5";
                                 widths="200px"  ,"150px"    ,"150px"   ,"120px","150px";
                                 OneRow=["1 Paulo Sérgio","Marcos Pacheco","George Bruno  ","George Bruno","1",/,
                                          "2 José Carlos" ,"Antônio       ","Paulo Henrique","George Bruno","2",/,
                                        ];
                                 Footer="soma Columm1","soma Columm2","soma Columm3","soma Columm4","soma Columm5";
                                 NotFound="Mensagem em caso de erro";
                                 template="<Table id="~TypeTable">
                                                <thead id="theadAlunos2" >
                                                   <tr><th colspan="5"> <p  style="text-align: center">  ~Alias  </p> </th>  </tr> 
                                                   <tr>~HeaderCols</tr> 
                                                </thead >
                                                <tbody id="tbodyAlunos2">
                                                   ~OneRowCols 
                                                </tbody>                                                
                                          </Table>"
                               ]
                    -]
      #-->

   ```

   <!--# tgTable [- ALUNOS2=[Alias="Cadastro de Alunos 2";
                              Header="Column1",":Column2:",":Column3",":Column4","Column5";
                              widths="200px"  ,"150px"    ,"150px"   ,"120px","150px";
                              OneRow=["1 Paulo Sérgio","Marcos Pacheco","George Bruno  ","George Bruno","1",/,
                                       "2 José Carlos" ,"Antônio       ","Paulo Henrique","George Bruno","2",/,
                                       ];
                              Footer="soma Columm1","soma Columm2","soma Columm3","soma Columm4","soma Columm5";
                              NotFound="Mensagem em caso de erro";
                              template="<Table id="~TypeTable">
                                             <thead id="theadAlunos2" >
                                                <tr><th colspan="5"> <p  style="text-align: center">  ~Alias  </p> </th>  </tr> 
                                                <tr>~HeaderCols</tr> 
                                             </thead >
                                             <tbody id="tbodyAlunos2">
                                                ~OneRowCols 
                                             </tbody>                                                
                                       </Table>"
                              ]
                  -]
   #-->

3. Template para preencher os dados da tabela _PROFESSORES_, onde o id="table".
   1. Esse modelo de tabela tem rodapé, porém o conteúdo do mesmo não é informando.

   ```html

      <!--# tgTable [- PROFESSORES=[Alias="Cadastro de Professores";
                                    Header="Column1:      ",":Column2:     ",":Column3      ",":Column4    ";
                                    widths="300px"         ,"250px"         ,"150px"         ,"180px";
                                    OneRow=["A11","A12","A13","A14",/,
                                            "A21","A22","A23","A24",/,
                                            "A31","A32","A33","A34",/,
                                            "A41","A42","A43","A44",/,
                                          ];
                                    template="<Table id="table">
                                                <thead id="theadProfessores">
                                                   <tr><th colspan="4"> <p  style="text-align: center">  ~Alias  </p> </th>  </tr> 
                                                   <tr>~HeaderCols</tr> 
                                                </thead>
                                                <tbody id="tbodyProfessores">
                                                   ~OneRowCols 
                                                </tbody>

                                             </Table>"
                                   ]
                    -]
      #-->

   ```

   <!--# tgTable [- PROFESSORES=[Alias="Cadastro de Professores";
                                 Header="Column1:      ",":Column2:     ",":Column3      ",":Column4    ";
                                 widths="300px"         ,"250px"         ,"150px"         ,"180px";
                                 OneRow=["A11","A12","A13","A14",/,
                                          "A21","A22","A23","A24",/,
                                          "A31","A32","A33","A34",/,
                                          "A41","A42","A43","A44",/,
                                       ];
                                 template="<Table id="table">
                                             <thead id="theadProfessores">
                                                <tr><th colspan="4"> <p  style="text-align: center">  ~Alias  </p> </th>  </tr> 
                                                <tr>~HeaderCols</tr> 
                                             </thead>
                                             <tbody id="tbodyProfessores">
                                                ~OneRowCols 
                                             </tbody>
                                             <tfoot id="tfootProfessores">
                                                ~FooterCols 
                                             </tfoot>
                                          </Table>"
                                 ]
                  -]
   #-->

## Tag TgImage

1. Template para preencher os dados referente a uma imagem.

   ```html

      <!--# tgImage [- NomeDaFigura=[ <figure>
                                        <img src="~src" alt="~alt" title="~title" style="width:10%; height:10%">
                                        <figcaption>~figcaption</figcaption>
                                      </figure>  ]
                  -]      
      #-->
      
   ```

   <!--# tgImage [- NomeDaFigura=[ <figure>
                                      <img src="~src" alt="~alt" title="~title" style="width:10%; height:10%">
                                      <figcaption>~figcaption</figcaption>
                                   </figure>  ]
                 -]      
   #-->

## Tag TgMapImage

1. Template para gerar a imagem clicável em vários pontos.
   1. O parâmetro  _oneRowArea_ do template abaixo, foi feito com ajuda do site [https://www.image-map.net/](https://www.image-map.net/).

      ```html
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

   2. <!--# tgImageMap [- img_map=[src="./img/img_map.jpg"; 
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

   3. Notas:
      1. [Documentação da tag &lt;map&gt;](https://developer.mozilla.org/pt-BR/docs/Web/HTML/Element/area)
      2. [Clique aqui para gerar coords da área do mapa](https://www.image-map.net)      

<!-- O código abaixo deve ser inserido na tag <head></head>.

       <style>

         thead {
            display: block;
            background-color: #bfc2c4;         
            border: 1px solid #333;
            padding: 3px;
            border-radius: 5px;
   
         }
   
         tbody {
            display: block;
            background-color: #eaedef;
            border: 1px solid #333;
            overflow-y: scroll;
            overflow-x: hidden;
            height: 100px;
            padding: 3px;
            /*color:blue;*/
            border-radius: 5px;
   
         }
   
         tfoot {
            display: block;         
            background-color: #bfc2c4;         
            border: 1px solid #333;
            padding: 3px;
            border-radius: 5px;
      
         }
   
         table {
            font-family: "Times New Roman", Times, serif;   
            table-layout: fixed;
            border-collapse: collapse;
            /*width: 0%;*/
            /*margin-bottom : .5em;*/
            /*table-layout: fixed;*/
            text-align: center;      
         }
   
         th, td {
            border: solid 1px;
            padding: 0
         }

         table th {
            background-color: #bfc2c4;
         }
         
         Table tr:nth-child(even){background-color: #f2f2f2;}   
         Table tr:hover {background-color: #ddd;}
         
      </style>
   
      <style>
      
         #miTable1 {
            font-family: "Times New Roman", Times, serif;
            border-collapse: collapse;
            /* width: 100%; */
         }
   
         #miTable1 td, #miTable1 th {
            border: 1px solid #ddd;
            padding:3px;
         }
         #miTable1 th {
            background-color: #bfc2c4;
         }
         
   
         #miTable1 tr:nth-child(even){background-color: #f2f2f2;} 
         #miTable1 tr:hover {background-color: #ddd;}
   
         #miTable1 th {
            padding-top: 3px;
            padding-bottom: 3px;
            text-align: left;         
            background-color: #bfc2c4;                        
            text-align: right;
         }
   
      </style>
   
      <link type="text/css" href="./css/Alunos.css"  rel="stylesheet"/>
      <link type="text/css" href="./css/Alunos2.css"  rel="stylesheet"/>
      <link type="text/css" href="./css/Professores.css" rel="stylesheet" />        

-->
