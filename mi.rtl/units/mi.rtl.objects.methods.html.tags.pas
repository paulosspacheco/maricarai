{$H-}
unit mi.rtl.objects.methods.html.tags;

{$MODE Delphi}

interface
  uses
    sysutils
    ,mi.rtl.Objects.Methods
    ;

type
  Thtml_tags = class(TObjectsMethods)

    Type
      TValue_Html = Record
                      hTITLE,
                      hForm,
                      hForm_Name,
                      hForm_method,
                      hForm_Action,
    //                hForm_OnEvent,

                      hSELECT_DATA,
                      hSELECT_DATA_Action,   {Action deve se o numero do evento a ser executado depois de selecionar a tabela}
                      hSELECT_DATA_Name ,    {Nome do evento}
                      hSELECT_DATA_Value,    {Nome da tabela}
                      hSELECT_DATA_Caption,  {Alias da tabela}

                      hSELECT_DATA_Value_KeyCurrent, {Chave atual da tabela. No Modo Cliente Servidor o sistema deve alimentar a a pagian do cliente com esta chave}
                      hSELECT_DATA_REACH,            {Alcance da Pesquisa}
                      hSELECT_DATA_Reach_Value,      {CURRENT,next,prev,Locate,All}
                      hSELECT_DATA_Reach_Value_Value,{Quando Value = goBof, GoEof, Current, Locate, next ou prev}

                      hInput,
                      hInput_Type,
                      hInput_Name,
                      hInput_SIZE,
                      hInput_Value,

                      hWIDHT,
                      hHEIGHT,
                      hIMG_SRC,
                      hALIGN,
                      hBORDER   : AnsiString;
                      //
                    End;
    Const                    {SINTAXE}
      HRL_HTPP   = 'HTPP';   {HTPP://endereco}
      HRL_FTP    = 'FTP';    {FTP://endereco}
      HRL_GOPHER = 'GOPHER'; {GOPHER://endereco}
      HRL_NEWS   = 'NEWS';   {NEWS://endereco}
      HREF       = 'HREF';   {HREF=endereco>} {Sintaxe: <A HREF=Endereco> texto visivel </A>}
    {                        '<A '+HREF+'Endereco > texto visivel </A>'}


    {TAGS}
      hHTML       = 'HTML';   {<HTML> Documento </HTML>}
      hHEAD       = 'HEAD';   {<HEAD> Cabe�lho da Pagina </HEAD>}
      hTITLE      = 'TITLE';  {<TITLE> Titulo da Pagina </TITLE>}
      hBODY       = 'BODY';   {<BODY> Corpo visivel do documento </BODY>}
      hBR         = 'BR';     {<BR> Passa pra uma linha }
      hIMG_SRC    = 'IMG SRC' {<IMG SRC = Endereco da imagem> Visualiza a imagem} ;
      hParagraph  = 'P';      {<P> texto do paragrafo </P>}


      hList_enumerated     = 'OL'; {<OL> itens da lista </OL>}
      hList_Not_enumerated = 'UL'; {<UL> itens da lista </UL>}
      hList_Title          = 'LH'; {<LH> titulo da lista </LH>}

      hList_Item           = 'LI'; {<LI> Item da lista </LI>}

      hForm          = 'FORM'; // Usado para executar uma acao no servidor passando como parametro os dados dos campos Input
      hForm_Name     = 'NAME'  ; // Nome do Formulario
      hForm_Action   = 'ACTION' ; // Endereco do CGI com seus parametros
      hForm_method   = 'METHOD'; // Metodo de chamada do CGI;
      hForm_OnSubmit = 'ONSUBMIT'; // Evento associado ao form

      hInput     = 'INPUT';
      hNAME      = 'NAME';    {<A NAME="Alvo"> </A> Link na mesma pagina}
      hValue     = 'VALUE';
      hCaption   = 'CAPTION';
      hType      = 'TYPE';

    {PARAMETRO DOS ELEMENTOS MODIFICADORES DAS TAGS}
      hSIZE       = 'SIZE';   {Tamanho. tem parametro}
      hWIDHT      = 'WIDHT';  {Largura tem parametro}
      hHEIGHT     = 'HEIGHT';  {Altura tem parametro}

      hRIGHT      = 'RIGHT';  {Direita}
      hCENTER     = 'CENTER'; {Centro}
      hNOSHAD     = 'NOSHAD'; {Sem efeito 3D. }

    {ELEMNTOS MODIFICADORES DA TAG}
      hBASEFONT   = 'BASEFONT'; {<BASEFONT SIZE = X> Obs: X = 1..7 onde padrao e 3. Obs: Deve declara sempre apos o <BODY>}
      hFONT       = 'FONT';    {<FONT SIZE=X> texto a ser alterado  </FONT> Obs: X = 1..7 onde padrao e <BASEFONT>}

     {Obs: A tag <Hn> onde n = 1..6 determina que o texto entre a tag e um titulo e o seu tamanho a
           inversamente proporcional a n. Ou seja <H1> e maior que <H6>}
      hH1         = 'H1';     {<H1> Titulo de tamanho1 </H1>}
      hH2         = 'H2';     {<H2> Titulo de tamanho2 </H2>}
      hH3         = 'H3';     {<H3> Titulo de tamanho3 </H3>}
      hH4         = 'H4';     {<H4> Titulo de tamanho4 </H4>}
      hH5         = 'H5';     {<H5> Titulo de tamanho5 </H5>}
      hH6         = 'H6';     {<H6> Titulo de tamanho6 </H6>}
      hHR         = 'HR';     {<HR> Linha Horizonta}
      hALIGN      = 'ALIGN';  {Alinhamento. Sintaxe: ALIGN=RIGHT ou CENTER ou ? }
      hNegrito    = 'STRONG'; {<B> texto em negrito <B>}
      hItalico    = 'EM';     {<EM> texto em italico <EM>}
      hBORDER     = 'BORDER'; {<BORDER=X> Onde x: 1 ate N onde N nao tem limite. Dezenha uma Borda na Imagem. }

    {NORSOFT}
    { TAGS USADA NAS PASSAGENS DE PARAMETROS PARA O CGI }
      hSELECT_DATA  = 'SELECT_DATA';
      Haction       = 'ACTION';  {Nome do Evento : Opcional. Se for omitido o sistema usara self Default = SELF}
      hTabela       = 'TABELA';  {Usado na tag hSELECT_DATA NAME=}
      hReport       = 'REPORT';  {Usado na tag hSELECT_DATA NAME=}

      hSELECT_DATA_Name  = hNAME;     {Nome do Evento : Opcional. Se for omitido o sistema usara self Default = SELF}
      hSELECT_DATA_Value = hValue;    {Nome da tabela  : Opcional. Se for omitido o sistema usara self Default = SELF}
      hSELECT_DATA_Value_KeyCurrent = 'KEYCURRENT';    {Chave atual da tabela. No Modo Cliente Servidor o sistema deve alimentar a pagian do cliente com esta chave}
      hSELECT_DATA_Caption = hCaption;  {Alias da tabela}

      hSELECT_DATA_Reach = 'REACH';      // Default = Se o Relationship = 1ParaN entao Default= ALL Se nao Default = TViRecord.Serch(hSELECT_DATA_Value_KeyCurrent)}
      {Parametros do comando hSELECT_DATA_Reach}
         hCurrent      = 'CURRENT'; //Executa o comando TViRecord.Find(hSELECT_DATA_Value_KeyCurrent)
         hNext         = 'NEXT';    //Next N  : onde  N e numero de registros depois de TViRecord.Find(hSELECT_DATA_Value_KeyCurrent)
         hPrev         = 'PREV';    //Prev N  : onde  N e numero de registros antes de TViRecord.Find(hSELECT_DATA_Value_KeyCurrent)
         hGoBof        = 'GOBOF';   // Posiciona no primeiro registro
         hGoEof        = 'GOEOF';   // Posiciona no ultimo registro
         hLocate       = 'LOCATE';
         hAll          = 'ALL';     // Alcance de Bof a Eof
         hSELECT_DATA_Reach_Value = hValue; {Parametros de
                                           Next   " N " onde e Numero de restros depois de TViRecord.Find(hSELECT_DATA_Value_KeyCurrent)
                                           Prev   " N " onde e Numero de restros antes de TViRecord.Find(hSELECT_DATA_Value_KeyCurrent)
                                           Locate "Expressao de pesquisa"
                                          }
      hField_Custom ='FIELD';   {O string que vier ap�s o sinal ~ deve ser substituido pelo conteudo do campo quando estiver no comando SELECT_DATA}
      hBlockquote   = 'Blockquote';


    {CORES}
      HColor_Padrao      : String = '""';
      HColor_background  : String = '"#D8EEFE"';
      HColor_Cinza       : String = '"#808080"';
      HColor_Cinza_Claro : String = '"#CCCCCC"';//'"#C0C0C0"';//'"#A4A4A4"';
      HColor_Prateado    : String = '"#C0C0C0"';
      HColor_Branco_Gelo : String = '"#F4F4F4"';

    //Cores padrão dos forms.
      HColor_glbnav_background_Acima : String = '#C2C7CA'; //Cor da parte de cima da imagem glbnav_background.gif
      HColor_BG_Nav                  : String = '#EBEDEC'; //Cor da figura BG_Nav.gif
      HColor_Fonts_Azul              : String = '#0099E0'; //Cor da fonte onde a figura BG_Nav.gif for uzada.
      HColor_Help                    : String = '#FFFFCC';

    //tags usada em tabela
      hTable      = 'TABLE';// <Table> </Table>
      hTr         = 'TR'   ;// <Tr> </Tr> Linha da tabela
      hTd         = 'TD'   ;// <Tr> </Tr> Celia das linhas da tabela

      hKey_Spc = '&nbsp;'; //C�digo html do espaco em branco.

    class Function GetValue_TagParam(Const aTagParam : AnsiString ;Const aTag : AnsiString; Var aValue : AnsiString ):Boolean;
    class Function PutValue_TagParam(Const aTagParam : AnsiString ;Const aTag : AnsiString; const aValue : AnsiString ):AnsiString;

    /// <since>
    ///   � Troca espa�o em branco pelo c�digo HTML do espa�o em branco.
    /// </since>
    class Function Spc_to_HTML(Const aStr:AnsiString):AnsiString;

    class Function Tag_Blockquote(aNivel:Integer;OnOff:Boolean) : AnsiString;

    class Function Str_to_Html_List(Const aStr:AnsiString):AnsiString;//< Retorna Uma sequencia de <li> </li>

  end;


Implementation

/// <since>
///   � Troca espa�o em branco pelo c�digo HTML do espa�o em branco.
/// </since>

class function Thtml_tags.Spc_to_HTML(Const aStr:AnsiString):AnsiString;
  Var
    i,L : Longint;

Begin
  Result := '';
  i := 0;
  While i < Length(aStr) do
  begin
    inc(i);
    case aStr[i] of
      ' ' : Begin
                Result := Result + hKey_Spc;
            End;
      Else Begin
             Result := Result + aStr[i]
           End;
    end; //Case;
  end;
 End;


class function Thtml_tags.Str_to_Html_List(Const aStr:AnsiString):AnsiString;//< Retorna Uma sequencia de <li> </li>
  ///RECEBER: Em aStr um string longo separado por
  ///           ^M = Final de linha.
  ///
  ///           ^C = O string e centralizado
  ///
  /// RETORNA: . aStr sendo  que ^M � trocado pela tag <BR> e depois de ^M o espa�o em branco � trocado
  ///            pelo c�digo HTML do espa�o em branco &nbsp;   para que o inicio do texto fique identado
  ///
  ///         .  O final da lista termina com "'<p>&nbsp;</p>'" para que passe uma linha em branco no final da lista.
  Var
    i : Longint;
Begin
  if Pos('<LI>',aStr )<>0
  then Result := ''
  Else Result := '<LI>';

  i := 0;
  While i < Length(aStr) do
  begin
    inc(i);
    case aStr[i] of
      ^J  : Begin //Usado para passar uma linha quando a mesma tem mais de 255 caracteres mais pertence ao paragrafo.
//              Result := Result +^M+^J;//'<!--'+^M+^J+'-->';
            End;
//      '"' : Begin
//              result := result + '&quot;'; //Obs: Caso haja substitui��o de " no c�digo html ent�o o browser n�o vai reconhecer os comandos .
//              result := result + '&#34;';
//            end;

      ^M  : Begin //Fin do paragrafo.

              //Passa linhas enquanto o proximo for ^M
              while  aStr[i] = ^M  do
              begin
                Result := Result + '<BR>'+ '<!--'+^M+^J+'-->';
                inc(i);
              end;

              //Insere brancos no inicio da linha.
              //inc(i);
              while (i < Length(aStr)) and (aStr[i] = ' ') do
              Begin
                Result := Result + '&nbsp;';
                inc(i);
              End;

              if (i <= Length(aStr))
              then Result := Result + aStr[i];
            End;

      Else Begin
             Result := Result + aStr[i]
           End;
    end; //Case;
  end;
  if Pos('<LI>',aStr ) =0
  then Result := Result + '</LI>';

  Result := Result+'<p>&nbsp;</p>';

//  Result := Result+'&nbsp;<BR>';

End;


class function Thtml_tags.Tag_Blockquote(aNivel:Integer;OnOff:Boolean) : AnsiString;
  Var
    i : Integer;
Begin
  Result := '';
  If aNivel > 0
  Then For i := 1 to aNivel do
       Begin
         If onOff
         Then Result := Result + '<'+hBlockquote+'>'+^M+^J
         Else Result := Result + '</'+hBlockquote+'>'+^M+^J;
       end;
end;

{
class  function GetValue_TagParam(Const aTagParam : AnsiString ;Const aTag : AnsiString; Var aValue : AnsiString ):Boolean;
  Var
    PosTag : Integer;
    P0,P1,P2 : PAnsiChar;
Begin
  P0 := PAnsiChar(aTagParam);
  P1 := P0;
  P2 := P1;
  PosTag := 1;

  While Not (P2^ in ['=',#0,' ']) do
  Begin
    If P2^ = '<'
    Then PosTag := P2-p1+2;
    Inc(p2);
  end;


  If (TObjectsMethods.UpperCase(Copy(aTagParam,PosTag,Length(aTag))) <> aTag)
  Then Begin
         Result := false;
         exit;
       End
  Else Result := True;

  If p2^=#0
  Then Begin
         aValue := '';
         exit;
       End;

  If P2^<>#0
  Then Inc(p2);
  P1 := p2;

  While Not (p2^ in ['"',#0,'=',' ']) do Inc(p2);

  If P2^<>#0
  Then inc(p2);

  if P2^ in [#0,'"']
  Then Begin
         If p2='"'
         Then P1 := p2;

         While Not (p2^ in ['"',#0,' '])
         do Inc(p2);

         if (p2-P1) > 0
         Then Begin
                aValue  := TObjectsMethods.UpperCase(Copy(tString(P1),1,p2-P1));
                Result  := true;
              End
         Else Result := False;
        end;
end;
}
class  function Thtml_tags.GetValue_TagParam(Const aTagParam : AnsiString ;Const aTag : AnsiString; Var aValue : AnsiString ):Boolean;
  Var
    PosTag : Integer;
    P0,P1,P2 : PAnsiChar;
Begin
  P0 := PAnsiChar(aTagParam);
  P1 := P0;
  P2 := P1;
  PosTag := 1;

  While Not (P2^ in ['=',#0,' ']) do
  Begin
    If P2^ = '<'
    Then PosTag := P2-p1+2;
    Inc(p2);
  end;



  If (TObjectsMethods.UpperCase(Copy(aTagParam,PosTag,Length(aTag))) <> aTag)
  Then Begin
         Result := false;
         exit;
       End
  Else Result := True;

  If p2^=#0
  Then Begin
         aValue := '';
         exit;
       End;

  Inc(p2);

  While Not (p2^ in ['"',#0,'=']) do Inc(p2);
  inc(p2);
  if P2^<>#0
  Then Begin
         P1 := p2;

         While Not (p2^ in ['"',#0])
         do Inc(p2);

         if P2^<>#0
         Then Begin
                aValue  := TObjectsMethods.UpperCase(Copy(AnsiString(P1),1,p2-P1));
                Result  := true;
              End
         Else Result := False;
        end;
end;

class  function Thtml_tags.PutValue_TagParam(Const aTagParam : AnsiString ;Const aTag : AnsiString; const aValue : AnsiString ):AnsiString ;

  Var
    Pos1,Pos2  : Integer;
    P0,P1,P2 : PAnsiChar;
Begin
  P0 := PAnsiChar(aTagParam);
  P1 := P0;
  P2 := P1;
  While Not (P2^ in ['=',#0,' ']) do Inc(p2);

  If (P2=#0) or (TObjectsMethods.UpperCase(Copy(aTagParam,1,p2-p0)) <> aTag)
  Then Begin
         Result := aTagParam;
         exit;
       End;

  Result := '';
  While Not (p2^ in ['"',#0]) do Inc(p2);

  If p2^ <>#0 Then Inc(P2);
  if P2<>#0
  Then Begin
         Result := Copy(aTagParam ,1,p2-p1);
         P1 := p2;
         if P2<>#0 Then While Not (p2^ in ['"',#0]) do Inc(p2);
         If p2^ <>#0 Then Inc(P2);
         if P2<>#0
         Then Begin
                Result  := Result +aValue+Copy(aTagParam ,p2-p0,length(aTagParam));
              End
         Else Result := aTagParam;
       end
  Else Result := aTagParam;
end;


end.



