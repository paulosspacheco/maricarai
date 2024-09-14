
function TBasePageProducer.GetHtmlImageMap(TagParams: TStrings;aNameImageMap,aTypeImageMap:String):String;

    //aTemplate: <area target="~target" alt="~alt" title="~title" href="~href" coords="~coords" shape="~shape">;
    function StringReplaceTgArea(Const atarget, aAlt,aTitle,aHref,aCoords,aShape, aTemplate: String:String):String;
    begin
        result :=  atemplate;
        Result := StringReplace(Result, '~target' , atarget    , [rfReplaceAll]);
        Result := StringReplace(Result, '~alt'    , aAlt       , [rfReplaceAll]);
        Result := StringReplace(Result, '~title'  , aTitle     , [rfReplaceAll]);
        Result := StringReplace(Result, '~href'   , aHref      , [rfReplaceAll]);
        Result := StringReplace(Result, '~coords' , aCoords    , [rfReplaceAll]);
        Result := StringReplace(Result, '~shape'  , aShape     , [rfReplaceAll]);
    end;


    
  (*: O método **@name** cria um arquivos das áreas clicáveis:

      <area target="~target" alt="~alt" title="~title" href="~href" coords="~coords" shape="~shape">
      <area target="~target" alt="~alt" title="~title" href="~href" coords="~coords" shape="~shape">
      <area target="~target" alt="~alt" title="~title" href="~href" coords="~coords" shape="~shape">
      <area target="~target" alt="~alt" title="~title" href="~href" coords="~coords" shape="~shape">


  *)
  Function Get_Area(aTemplate_OneRowArea:String):String;
    var
      i : integer;
      s : string = '';
  begin
    
    // for i := 0 to ListWidthCols.Count-1 do
    // begin
    // end;   

  end;

  {
    <!--# tgImageMap [- img_map=[ src="./img/img_map.jpg"; usemap="img_map";
                                  OneRowArea=[ "rect"   , "target" , "alt_rect"   , "title_rect"   , "href_rect.html"   , "19,53,66,107",/,
                                               "circle" , "target" , "alt_circle" , "title_circle" , "href_circle.html" , "126,85,34",/,
                                               "poly"   , "target" , "alt_poly"   , "title_poly"   , "href_poly.html"   , "202,54,266,52,265,98,247,93,233,97,222,101,207,103,198,98",/,                                                       
                                             ];
                                    templateOneRowArea=<area target="~target" alt="~alt" title="~title" href="~href" coords="~coords" shape="~shape">;
                                    templateImageMap="< img src="~src" usemap="#~usemap">
                                                        < map name="~usemap">
                                                            <area shape="default" nohref />
                                                            ~OneRowArea
                                                        </map>";
                                ]
                     -] 
    #-->
  }
  Function GetImageMap(aSrc,    // Arquivo com a imagem
                       aUsemap, // Nome do mapa associado ao aqruivo de imagem
                       aOneRowArea, //["Value1","Value2",...];
                       atemplate_OneRowArea, // Template da área de cada linha
                       templateImageMap :String //<img> <Map>......</Map>
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
      Result :=StringReplaceTgImageMap(aAlias,
                                    aHeaderCols,
                                    aOneRowCols,
                                    aFooterCols,
                                    aNotFound,
                                    aTypeImageMap,
                                    aTemplate);

    Finally
      ListHeaderCols.Free;
      ListOneRowCols.Free;
      ListFooterCols.Free;
    end;

  end;


  Var
    s1 : string;
    Params: TMiStringList;
begin
    s1 := TagParams.Values[aNameImageMap];
    if s1 <> '' Then
    begin
      try
        Params := TMiStringList.Create;
        Params.AddTag(s1);
        Result := GetImageMap( Params.Values['Alias'],
                            Params.Values['Header'],
                            Params.Values['OneRow'],
                            Params.Values['Footer'],
                            Params.Values['NotFound'],
                            aTypeImageMap,
                            Params.Values['template']
                                                    );
        create_Css_Cols_ImageMap(aNameImageMap,Params.Values['Header'],Params.Values['widths']);
      finally
        Freeandnil(Params);
      end;
    end
    else Result := '';
end;
 