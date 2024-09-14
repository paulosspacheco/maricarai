<map version="freeplane 1.7.0">
<!--To view this file, download free mind mapping software Freeplane from http://freeplane.sourceforge.net -->
<node TEXT="TMi_rtl_WebModule" FOLDED="false" ID="ID_191153586" CREATED="1724172285497" MODIFIED="1724244859158" ICON_SIZE="36.0 pt" LINK="menuitem:_ExternalImageAddAction" STYLE="oval">
<font SIZE="22"/>
<hook NAME="MapStyle" layout="OUTLINE">
    <properties edgeColorConfiguration="#808080ff,#ff0000ff,#0000ffff,#00ff00ff,#ff00ffff,#00ffffff,#7c0000ff,#00007cff,#007c00ff,#7c007cff,#007c7cff,#7c7c00ff" show_icon_for_attributes="true" show_note_icons="true" fit_to_viewport="false"/>

<map_styles>
<stylenode LOCALIZED_TEXT="styles.root_node" STYLE="oval" UNIFORM_SHAPE="true" VGAP_QUANTITY="24.0 pt">
<font SIZE="24"/>
<stylenode LOCALIZED_TEXT="styles.predefined" POSITION="right" STYLE="bubble">
<stylenode LOCALIZED_TEXT="default" ICON_SIZE="12.0 pt" COLOR="#000000" STYLE="fork">
<font NAME="SansSerif" SIZE="10" BOLD="false" ITALIC="false"/>
</stylenode>
<stylenode LOCALIZED_TEXT="defaultstyle.details"/>
<stylenode LOCALIZED_TEXT="defaultstyle.attributes">
<font SIZE="9"/>
</stylenode>
<stylenode LOCALIZED_TEXT="defaultstyle.note" COLOR="#000000" BACKGROUND_COLOR="#ffffff" TEXT_ALIGN="LEFT"/>
<stylenode LOCALIZED_TEXT="defaultstyle.floating">
<edge STYLE="hide_edge"/>
<cloud COLOR="#f0f0f0" SHAPE="ROUND_RECT"/>
</stylenode>
</stylenode>
<stylenode LOCALIZED_TEXT="styles.user-defined" POSITION="right" STYLE="bubble">
<stylenode LOCALIZED_TEXT="styles.topic" COLOR="#18898b" STYLE="fork">
<font NAME="Liberation Sans" SIZE="10" BOLD="true"/>
</stylenode>
<stylenode LOCALIZED_TEXT="styles.subtopic" COLOR="#cc3300" STYLE="fork">
<font NAME="Liberation Sans" SIZE="10" BOLD="true"/>
</stylenode>
<stylenode LOCALIZED_TEXT="styles.subsubtopic" COLOR="#669900">
<font NAME="Liberation Sans" SIZE="10" BOLD="true"/>
</stylenode>
<stylenode LOCALIZED_TEXT="styles.important">
<icon BUILTIN="yes"/>
</stylenode>
</stylenode>
<stylenode LOCALIZED_TEXT="styles.AutomaticLayout" POSITION="right" STYLE="bubble">
<stylenode LOCALIZED_TEXT="AutomaticLayout.level.root" ICON_SIZE="64.0 pt" COLOR="#000000" STYLE="oval" SHAPE_HORIZONTAL_MARGIN="10.0 pt" SHAPE_VERTICAL_MARGIN="10.0 pt">
<font NAME="Segoe Print" SIZE="22"/>
<edge COLOR="#ffffff"/>
</stylenode>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,1" ICON_SIZE="32.0 px" COLOR="#000000" BACKGROUND_COLOR="#ffffcc" STYLE="bubble" SHAPE_HORIZONTAL_MARGIN="2.6 pt" SHAPE_VERTICAL_MARGIN="2.6 pt" BORDER_WIDTH_LIKE_EDGE="true">
<font SIZE="18" BOLD="false" ITALIC="true"/>
<edge STYLE="sharp_bezier" WIDTH="8"/>
</stylenode>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,2" ICON_SIZE="28.0 px" COLOR="#000000" BORDER_WIDTH_LIKE_EDGE="true">
<font SIZE="16"/>
<edge STYLE="bezier" WIDTH="4"/>
</stylenode>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,3" ICON_SIZE="24.0 px" COLOR="#000000" BORDER_WIDTH_LIKE_EDGE="true">
<font SIZE="14"/>
<edge STYLE="bezier" WIDTH="3"/>
</stylenode>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,4" ICON_SIZE="24.0 px" COLOR="#111111" BORDER_WIDTH_LIKE_EDGE="true">
<font SIZE="13"/>
<edge STYLE="bezier" WIDTH="2"/>
</stylenode>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,5" ICON_SIZE="24.0 px" BORDER_WIDTH_LIKE_EDGE="true">
<font SIZE="12"/>
<edge STYLE="bezier" WIDTH="1"/>
</stylenode>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,6" ICON_SIZE="24.0 px">
<edge STYLE="bezier"/>
</stylenode>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,7" ICON_SIZE="16.0 px">
<font SIZE="10"/>
<edge STYLE="bezier"/>
</stylenode>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,8" ICON_SIZE="16.0 px">
<edge STYLE="bezier"/>
</stylenode>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,9" ICON_SIZE="16.0 px">
<edge STYLE="bezier"/>
</stylenode>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,10" ICON_SIZE="16.0 px">
<edge STYLE="bezier"/>
</stylenode>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,11" ICON_SIZE="16.0 px">
<edge STYLE="bezier"/>
</stylenode>
</stylenode>
</stylenode>
</map_styles>
</hook>
<hook NAME="AutomaticEdgeColor" COUNTER="15" RULE="ON_BRANCH_CREATION"/>
<hook NAME="accessories/plugins/AutomaticLayout.properties" VALUE="ALL"/>
<edge COLOR="#ffffff"/>
<richcontent TYPE="DETAILS">

<html>
  <head>
    
  </head>
  <body>
    <p>
      Api Rest com os m&#233;todos p&#250;blicos para interagir com a aplica&#231;&#227;o cliente.
    </p>
  </body>
</html>
</richcontent>
<node TEXT="navigation actions" POSITION="right" ID="ID_273436263" CREATED="1724172285502" MODIFIED="1724179219428" HGAP_QUANTITY="91.26829627750192 pt" VSHIFT_QUANTITY="-30.731708746733723 pt">
<edge COLOR="#007c7c"/>
<node TEXT="CmlocateRequest &#x2705;" ID="ID_588194298" CREATED="1724172285502" MODIFIED="1724264258956" HGAP_QUANTITY="15.756097642670499 pt" VSHIFT_QUANTITY="-12.292683498693489 pt"><richcontent TYPE="DETAILS" HIDDEN="true">

<html>
  <head>
    
  </head>
  <body>
    <p>
      Recebe a chave enviada pelo cliente;
    </p>
    <p>
      &#160;- Captura a lista de campos em json separando campos dos valores&#160;&#160;&#160;&#160;&#160;
    </p>
    <p>
      &#160;&#160;&#160;&#160;&#160;&#160;- Executa m&#233;todo locate com os par&#226;metros recebidos;
    </p>
    <p>
      - Checa se o registro foi localizado:
    </p>
    <p>
      &#160;&#160;- Se sim:
    </p>
    <p>
      &#160;&#160;&#160;&#160;-&#160;&#160;Retorna para o cliente todos os campos do&#160; TDmxScroller_form.JSONObject.
    </p>
    <p>
      - Se n&#227;o:
    </p>
    <p>
      &#160;&#160;- Retorna o json: {&quot;error&quot;:&quot;Usu&#225;rio n&#227;o encontrado&quot;}
    </p>
  </body>
</html>

</richcontent>
</node>
<node TEXT="CmGoBofRequest" ID="ID_1104103844" CREATED="1724172285503" MODIFIED="1724264349353"><richcontent TYPE="DETAILS" HIDDEN="true">

<html>
  <head>
    
  </head>
  <body>
    <p>
      Recebe a chave atual enviada pelo cliente;
    </p>
    <p>
      &#160;- &#160;Executa CmGoBof
    </p>
    <p>
      - Checa se o registro est&#225; selecionado:
    </p>
    <p>
      &#160;&#160;- Se sim:
    </p>
    <p>
      &#160;&#160;&#160;&#160;-&#160;&#160;Retorna para o cliente todos os campos do&#160; TDmxScroller_form.JSONObject.
    </p>
    <p>
      - Se n&#227;o:
    </p>
    <p>
      &#160;&#160;-&#160;&#160;&#160;Retorna o json: {&quot;error&quot;:&quot;Arquivo vazio&quot;}
    </p>
  </body>
</html>

</richcontent>
</node>
<node TEXT="CmGoEofRequest" ID="ID_915129283" CREATED="1724176238265" MODIFIED="1724264440233"><richcontent TYPE="DETAILS" HIDDEN="true">

<html>
  <head>
    
  </head>
  <body>
    <p>
      Recebe a chave atual enviada pelo cliente;
    </p>
    <p>
      &#160;- &#160;Executa CmGoEof;
    </p>
    <p>
      - Checa se o registro est&#225; selecionado:
    </p>
    <p>
      &#160;&#160;- Se sim:
    </p>
    <p>
      &#160;&#160;&#160;&#160;-&#160;&#160;Retorna para o cliente todos os campos do&#160; TDmxScroller_form.JSONObject.
    </p>
    <p>
      - Se n&#227;o:
    </p>
    <p>
      &#160;&#160;-&#160;&#160;&#160;Retorna o json: {&quot;error&quot;:&quot;Arquivo vazio&quot;}
    </p>
  </body>
</html>

</richcontent>
</node>
</node>
<node TEXT="update actions" POSITION="right" ID="ID_495676614" CREATED="1724172285503" MODIFIED="1724179187625" HGAP_QUANTITY="101.80488213352491 pt" VSHIFT_QUANTITY="-42.14634342409195 pt">
<edge COLOR="#009900"/>
<node TEXT="CmNewRecordRequest" ID="ID_744391648" CREATED="1724172285503" MODIFIED="1724183445379" HGAP_QUANTITY="15.756097642670499 pt" VSHIFT_QUANTITY="-14.926829962699236 pt"><richcontent TYPE="DETAILS">

<html>
  <head>
    
  </head>
  <body>
    <p>
      Recebe a chave atual enviada pelo cliente;
    </p>
    <p>
      &#160;- Checa se o evento onNewRecord foi assinalado;
    </p>
    <p>
      &#160;&#160;&#160;&#160;- Se sim:
    </p>
    <p>
      &#160;&#160;&#160;&#160;&#160;&#160;- Executa onNewRecord com par&#226;metros recibos,
    </p>
    <p>
      &#160;&#160;&#160;&#160;- Se n&#227;o:
    </p>
    <p>
      &#160;&#160;&#160;&#160;&#160;&#160;- Executa m&#233;todo CmOnNewRecord com os par&#226;metros recebidos;
    </p>
    <p>
      - Checa se o registro esta selecionado:
    </p>
    <p>
      &#160;&#160;- Se sim:
    </p>
    <p>
      &#160;&#160;&#160;&#160;-&#160;&#160;Retorna para o cliente todos os campos do&#160; TDmxScroller_form.JSONObject.
    </p>
    <p>
      - Se n&#227;o:
    </p>
    <p>
      &#160;&#160;-&#160;&#160;&#160;Retorna o json: {&quot;error&quot;:&quot;E,Message&quot;}
    </p>
  </body>
</html>
</richcontent>
</node>
<node TEXT="CmUpdateRecordRequest" ID="ID_903669612" CREATED="1724172285503" MODIFIED="1724247700528"><richcontent TYPE="DETAILS">

<html>
  <head>
    
  </head>
  <body>
    <p>
      Recebe a chave atual enviada pelo cliente;
    </p>
    <p>
      &#160;- Checa se o evento onUpdateRecord foi iniciado;
    </p>
    <p>
      &#160;&#160;&#160;&#160;- Se sim:
    </p>
    <p>
      &#160;&#160;&#160;&#160;&#160;&#160;- Executa onUpdateRecord com par&#226;metros recibos,
    </p>
    <p>
      &#160;&#160;&#160;&#160;- Se n&#227;o:
    </p>
    <p>
      &#160;&#160;&#160;&#160;&#160;&#160;- Executa m&#233;todo CmUpdateRecord com os par&#226;metros recebidos;
    </p>
    <p>
      - Checa se o registro esta selecionado:
    </p>
    <p>
      &#160;&#160;- Se sim:
    </p>
    <p>
      &#160;&#160;&#160;&#160;-&#160;&#160;Retorna para o cliente todos os campos do&#160; TDmxScroller_form.JSONObject.
    </p>
    <p>
      - Se n&#227;o:
    </p>
    <p>
      &#160;&#160;-&#160;&#160;&#160;Retorna o json: {&quot;error&quot;:&quot;e.message&quot;}
    </p>
  </body>
</html>

</richcontent>
</node>
<node TEXT="CmDeleteRecordRequest" ID="ID_571875425" CREATED="1724176441805" MODIFIED="1724183617385"><richcontent TYPE="DETAILS">

<html>
  <head>
    
  </head>
  <body>
    <p>
      Recebe a chave atual enviada pelo cliente;
    </p>
    <p>
      &#160;- Checa se o evento onDeleteRecord foi iniciado;
    </p>
    <p>
      &#160;&#160;&#160;&#160;- Se sim:
    </p>
    <p>
      &#160;&#160;&#160;&#160;&#160;&#160;- Executa onDeleteRecord com par&#226;metros recibos,
    </p>
    <p>
      &#160;&#160;&#160;&#160;- Se n&#227;o:
    </p>
    <p>
      &#160;&#160;&#160;&#160;&#160;&#160;- Executa m&#233;todo CmDeleteRecord com os par&#226;metros recebidos;
    </p>
    <p>
      - Checa se o registro esta selecionado:
    </p>
    <p>
      &#160;&#160;- Se sim:
    </p>
    <p>
      &#160;&#160;&#160;&#160;-&#160;&#160;Retorna para o cliente todos os campos do&#160; TDmxScroller_form.JSONObject.
    </p>
    <p>
      - Se n&#227;o:
    </p>
    <p>
      &#160;&#160;-&#160;&#160;&#160;Retorna o json: {&quot;error&quot;:&quot;e.message&quot;}
    </p>
  </body>
</html>
</richcontent>
</node>
<node TEXT="CmCancelResquest" ID="ID_1059805181" CREATED="1724176533438" MODIFIED="1724184363686"><richcontent TYPE="DETAILS">

<html>
  <head>
    
  </head>
  <body>
    <p>
      - A tecnologia usada &#233; FatCGI ou servidor http?
    </p>
    <p>
      &#160;&#160;- sim
    </p>
    <p>
      &#160;&#160;&#160;&#160;- Recebe a chave atual enviada pelo cliente;
    </p>
    <p>
      &#160;&#160;&#160;&#160;- Checa se o evento onCancel foi iniciado;
    </p>
    <p>
      &#160;&#160;&#160;&#160;&#160;&#160;- Se sim:
    </p>
    <p>
      &#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;- Executa onCancel com par&#226;metros recibos,
    </p>
    <p>
      &#160;&#160;&#160;&#160;&#160;&#160;- Se n&#227;o:
    </p>
    <p>
      &#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;- Executa m&#233;todo CmCancel com os par&#226;metros recebidos;
    </p>
    <p>
      &#160;&#160;&#160;&#160;- Checa se o registro esta selecionado:
    </p>
    <p>
      &#160;&#160;&#160;&#160;&#160;&#160;- Se sim:
    </p>
    <p>
      &#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;- Retorna para o cliente todos os campos do&#160; TDmxScroller_form.JSONObject.
    </p>
    <p>
      &#160;&#160;&#160;&#160;&#160;&#160;- Se n&#227;o:
    </p>
    <p>
      &#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;- Retorna o json: {&quot;error&quot;:&quot;e.message&quot;}
    </p>
    <p>
      &#160;&#160;- N&#227;o
    </p>
    <p>
      &#160;&#160;&#160;&#160;- Retorna o json: {&quot;error&quot;:&quot;Cgi n&#227;o guarda o estado do objeto por isso n&#227;o tem o que cancelar.&quot;}
    </p>
  </body>
</html>
</richcontent>
</node>
<node TEXT="CmRefreshRequest" ID="ID_66630836" CREATED="1724176563822" MODIFIED="1724185038788"><richcontent TYPE="DETAILS">

<html>
  <head>
    
  </head>
  <body>
    <p>
      - A tecnologia usada &#233; FatCGI ou servidor http?
    </p>
    <p>
      &#160;&#160;- sim
    </p>
    <p>
      &#160;&#160;&#160;&#160;- Recebe a chave atual enviada pelo cliente;
    </p>
    <p>
      &#160;&#160;&#160;&#160;- Checa se o evento onRefresh foi iniciado;
    </p>
    <p>
      &#160;&#160;&#160;&#160;&#160;&#160;- Se sim:
    </p>
    <p>
      &#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;- Executa onRefresh com par&#226;metros recibos,
    </p>
    <p>
      &#160;&#160;&#160;&#160;&#160;&#160;- Se n&#227;o:
    </p>
    <p>
      &#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;- Executa m&#233;todo CmRefresh com os par&#226;metros recebidos;
    </p>
    <p>
      &#160;&#160;&#160;&#160;- Checa se o registro esta selecionado:
    </p>
    <p>
      &#160;&#160;&#160;&#160;&#160;&#160;- Se sim:
    </p>
    <p>
      &#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;- Retorna para o cliente todos os campos do&#160; TDmxScroller_form.JSONObject.
    </p>
    <p>
      &#160;&#160;&#160;&#160;&#160;&#160;- Se n&#227;o:
    </p>
    <p>
      &#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;- Retorna o json: {&quot;error&quot;:&quot;e.message&quot;}
    </p>
    <p>
      &#160;&#160;- N&#227;o
    </p>
    <p>
      &#160;&#160;&#160;&#160;- Retorna o json: {&quot;error&quot;:&quot;Cgi n&#227;o guarda o estado do objeto por isso n&#227;o tem o que atualizar.&quot;}
    </p>
  </body>
</html>
</richcontent>
</node>
</node>
<node TEXT="Actions" POSITION="right" ID="ID_90823870" CREATED="1724172285503" MODIFIED="1724176652035" HGAP_QUANTITY="56.146343424091945 pt" VSHIFT_QUANTITY="-61.46341749346744 pt">
<edge COLOR="#ff0000"/>
<node TEXT="GetFormRequest" ID="ID_1201198400" CREATED="1724172285503" MODIFIED="1724185333009" HGAP_QUANTITY="15.756097642670499 pt" VSHIFT_QUANTITY="-15.804878784034486 pt"><richcontent TYPE="DETAILS">

<html>
  <head>
    
  </head>
  <body>
    <p>
      - Recebe a chave atual enviada pelo cliente;
    </p>
    <p>
      &#160;&#160;&#160;&#160;- Checa se o evento onGetForm foi iniciado;
    </p>
    <p>
      &#160;&#160;&#160;&#160;&#160;&#160;- Se sim:
    </p>
    <p>
      &#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;- Executa onGetForm com par&#226;metros recibos,
    </p>
    <p>
      &#160;&#160;&#160;&#160;&#160;&#160;- Se n&#227;o:
    </p>
    <p>
      &#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;- Executa m&#233;todo CmGetForm com os par&#226;metros recebidos;
    </p>
    <p>
      &#160;&#160;&#160;&#160;- Retorna o formul&#225;rio criado.
    </p>
  </body>
</html>
</richcontent>
</node>
<node TEXT="OnEnterRequest" ID="ID_1615683347" CREATED="1724172285503" MODIFIED="1724176795476" HGAP_QUANTITY="17.512195285340997 pt" VSHIFT_QUANTITY="3.512195285340997 pt"/>
<node TEXT="OnExitRequest" ID="ID_154654951" CREATED="1724176750010" MODIFIED="1724176812349"/>
</node>
<node TEXT="LCL TActionList" POSITION="left" ID="ID_25434398" CREATED="1724172285503" MODIFIED="1724196313484" HGAP_QUANTITY="73.70731985079694 pt" VSHIFT_QUANTITY="-37.75609931741573 pt">
<edge COLOR="#cc00ff"/>
<richcontent TYPE="DETAILS">

<html>
  <head>
    
  </head>
  <body>
    <p>
      Comandos usados pela aplica&#231;&#245;es lcl
    </p>
  </body>
</html>
</richcontent>
<node TEXT="CmGoBof &#x2705;" ID="ID_352937383" CREATED="1724172285504" MODIFIED="1724195198832" HGAP_QUANTITY="13.121951178664752 pt" VSHIFT_QUANTITY="-9.658537034687741 pt"><richcontent TYPE="DETAILS">

<html>
  <head>
    
  </head>
  <body>
    <p>
      Posiciona&#160;&#160;no primeiro registro.
    </p>
  </body>
</html>
</richcontent>
</node>
<node TEXT="CmGoEof &#x2705;" ID="ID_966834988" CREATED="1724172285504" MODIFIED="1724195204525" HGAP_QUANTITY="15.756097642670499 pt" VSHIFT_QUANTITY="-7.902439392017243 pt"><richcontent TYPE="DETAILS">

<html>
  <head>
    
  </head>
  <body>
    <p>
      Posiciona&#160;&#160;no &#250;timo registro.
    </p>
  </body>
</html>
</richcontent>
</node>
<node TEXT=" CmLocate &#x2705;" ID="ID_104514221" CREATED="1724173123618" MODIFIED="1724195211625"><richcontent TYPE="DETAILS">

<html>
  <head>
    
  </head>
  <body>
    <p>
      Localisa um registro baseado no valor informado no campo em foco no formul&#225;rio.
    </p>
  </body>
</html>
</richcontent>
</node>
</node>
<node TEXT="LCL TActionList &#x2705;" POSITION="left" ID="ID_1822402846" CREATED="1724172285504" MODIFIED="1724195385260" HGAP_QUANTITY="84.24390570681993 pt" VSHIFT_QUANTITY="-36.00000167474521 pt">
<edge COLOR="#ff9900"/>
<richcontent TYPE="DETAILS">

<html>
  <head>
    
  </head>
  <body>
    <p>
      Comandos usados pela aplica&#231;&#245;es lcl
    </p>
  </body>
</html>
</richcontent>
<node TEXT="CmNewRecord &#x2705;" ID="ID_1274507163" CREATED="1724172285504" MODIFIED="1724195219410" HGAP_QUANTITY="14.0 pt" VSHIFT_QUANTITY="-21.07317171204598 pt"><richcontent TYPE="DETAILS">

<html>
  <head>
    
  </head>
  <body>
    <p>
      Posiciona o curso no estado, inicializa com os valores padr&#245;es informados no m&#233;todo getTemplate.
    </p>
  </body>
</html>
</richcontent>
</node>
<node TEXT="CmUpdateRecord &#x2705;" ID="ID_1203076641" CREATED="1724172285504" MODIFIED="1724195224117"><richcontent TYPE="DETAILS">

<html>
  <head>
    
  </head>
  <body>
    <p>
      Caso o estado atual do registro se novoregistro ent&#227;o execute o m&#233;todo DoAddRec, caso contr&#225;rio executa o m&#233;todo doUpdateRecord.
    </p>
  </body>
</html>
</richcontent>
</node>
<node TEXT="CmDeleteRecord &#x2705;" ID="ID_1447035896" CREATED="1724173089873" MODIFIED="1724195230740"><richcontent TYPE="DETAILS" HIDDEN="true">

<html>
  <head>
    
  </head>
  <body>
    <p>
      Exclui o registro selecionado.
    </p>
  </body>
</html>
</richcontent>
</node>
<node TEXT="CmCancel &#x2705;" ID="ID_1183585514" CREATED="1724173144715" MODIFIED="1724195235179"><richcontent TYPE="DETAILS" HIDDEN="true">

<html>
  <head>
    
  </head>
  <body>
    <p>
      Cancela a edi&#231;&#227;o dos dados digitados at&#233; o mento e n&#227;o gravados.
    </p>
  </body>
</html>
</richcontent>
</node>
<node TEXT="CmRefresh &#x2705;" ID="ID_154515991" CREATED="1724173204117" MODIFIED="1724195238509"><richcontent TYPE="DETAILS" HIDDEN="true">

<html>
  <head>
    
  </head>
  <body>
    <p>
      Ler novamente o&#160;&#160;registro corrente do arquivo a atuliza a interface visual;.
    </p>
  </body>
</html>
</richcontent>
</node>
</node>
<node TEXT="LCL M&#xe9;todos &#x2705;" POSITION="left" ID="ID_575079876" CREATED="1724172285504" MODIFIED="1724195389399" HGAP_QUANTITY="67.56097810145019 pt" VSHIFT_QUANTITY="-42.14634342409195 pt">
<edge COLOR="#0000ff"/>
<node TEXT="GetActive &#x2705;" ID="ID_1522387997" CREATED="1724172285504" MODIFIED="1724195291185"><richcontent TYPE="DETAILS">

<html>
  <head>
    
  </head>
  <body>
    <p>
      Result := Mi_SQLQuery1.Active and DmxScroller_Form1.Active;&#160;
    </p>
  </body>
</html>
</richcontent>
</node>
<node TEXT="SetActive &#x2705;" ID="ID_170546021" CREATED="1724174019240" MODIFIED="1724195294335"><richcontent TYPE="DETAILS">

<html>
  <head>
    
  </head>
  <body>
    <p>
      Ativa conecta-se ao banco de dados e inicia o orm baseado no formul&#225;rio editado em getTemplate.
    </p>
  </body>
</html>
</richcontent>
</node>
<node TEXT="Get_State &#x2705;" ID="ID_526724632" CREATED="1724174129595" MODIFIED="1724195298462"><richcontent TYPE="DETAILS">

<html>
  <head>
    
  </head>
  <body>
    <p>
      result := Mi_SQLQuery1.DataSource.DataSet.State;
    </p>
  </body>
</html>
</richcontent>
</node>
</node>
</node>
</map>
