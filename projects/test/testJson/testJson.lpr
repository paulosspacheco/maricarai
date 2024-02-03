program testJson;
{$mode objfpc}
{$h+}


uses fpjson;

var
  O : TJSONObject;
  A : TJSONArray;
begin
  WriteLn('Teste TJSONObject:');
  O:=TJSONObject.Create(['a',1,'b','two','three',
                         TJSONObject.Create(['x',10,'y',20])
                        ]
                       );
  Writeln (O.FormatJSon);
  Writeln (O.FormatJSon([foDonotQuoteMembers,foUseTabChar],1));
  Writeln (O.FormatJSon([foSingleLineObject,foUseTabChar],1));
  Writeln (O.asJSON);

  WriteLn('Teste: TJSONArray.Create(');
  A:=TJSONArray.Create([1,2,'a',TJSONObject.Create(['x',10,'y',20])]);

  WriteLn('Teste: A.FormatJSon');
  Writeln (A.FormatJSon());
  WriteLn('Teste: (A.FormatJSON([foSinglelineArray],2));');
  Writeln (A.FormatJSON([foSinglelineArray],2));

  WriteLn('Teste: A.FormatJSON([foSinglelineArray,foSingleLineObject],2));');
  Writeln (A.FormatJSON([foSinglelineArray,foSingleLineObject],2));

  WriteLn('Teste: A.asJSON);');
  Writeln (A.asJSON);
end.
