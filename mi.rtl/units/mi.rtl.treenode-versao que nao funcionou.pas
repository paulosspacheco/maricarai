
unit mi.rtl.treenode;
{:< - A Unit **@name** implementa a classe **TTreeNode** do pacote **mi.rtl**.

  - **NOTAS**
    - Esta unit foi testada nas plataformas: linux.

  - **VERSÃO**
    - Alpha - 1.0.0

  - **HISTÓRICO**
    - Criado por: Paulo Sérgio da Silva Pacheco e-mail: paulosspacheco@@yahoo.com.br
    - **06/11/2023** - Inicio do projeto unit mi.rtl.treenode.pas
    - **07/11/2023** - Fim do projeto unit mi.rtl.treenode.pas
    - **09/11/2023** - Idetifiquei um erro no código html gerado no método TreeToStringListHtml
    FindNodeWithText

  - **CÓDIGO FONTE**:
    - @html(<a href="../units/mi.rtl.treenode.pas">mi.rtl.treenode.pas</a>)

}


{$IFDEF FPC}
  {$MODE Delphi} {$H+}
{$ENDIF}



interface

uses
  Classes, SysUtils
  //,LResources
  ;

type
  TTreeNode = class;

  { TTreeNodes }

  TTreeNodes = class(TStringList)
    public Owner:TTreeNode;
    public constructor create (AOwner: TTreeNode);Virtual;overload;
    private fCurrent : Integer;
//    public function FindNodeWithTextInTree(aTree:TTreeNode;aName:string):TTreeNode;
    public function FindNodeWithText(aName:string):TTreeNode;

    public function FirstChild: TTreeNode;
    public function NextChild(AValue:TTreeNode):TTreeNode;
    {: A classe método **@name** retorna um string sem os separadores de
       de pastas e arquivo.

       - Nota
         - Usado para iniciar nome do componente.
    }
    function GetNameValid(aFileName:String):String;

    {: o método **@name** retorna um string com a pasta e subpastas até o
       parâmetro n separador de pasta.

       - **Nota**
         - Usado calcula o nome do componenente, por isso a propriedade name do
           item não pode ser repetido dentro da pasta.
    }
    function getName(FilePath:TStringArray;n:Integer):string;
    {: o método **@name** retorna um array com a pasta de subpasta e arquivo
       passado pelo parâmentro aInputString }
    function SplitString(aInputString:string; aDelimiter: Char):TStringArray;

    function AddObject(const S: string; AObject: TObject): Integer; Override; overload;

    {: o método **@name** adiciona um item na lista.}
    function AddChild(ParentNode: TTreeNode; const aName,aFilePath: string; IsSheet: Boolean):TTreeNode;overload;
    {: O Método **@name** cria a arvore usando um string no formato /past1/subpasta1/subpasta2/files.txt

       - **ATENÇÃO**
         - Está com problema, gerando excesão.
    }
    function AddChild(aRoot:TTreeNode;aFileName:String):TTreeNode;overload;
  end;

  { TTreeNode }
  {: - A classe **@name** implementa a classe **TTreeNode** do pacote **mi.rtl**.

    - **NOTA**
      - A classe **@name** é usado para criar arvores de strings a partir da
        string no formato /path1/path2/path2/file.html.

      - O método AddChild ( aFileName ) divide o nome das subpastas e
        o nome do arquivo e adiciona na arvore.

    - **EXEMPLOS DE USO DA CLASSE: @name**:
      -

        ```pascal

           //Teste da classe TTreeNode
           program project1;
           uses
             mi.RTL.treenode;
           begin
             TTreeNode.Test1;
             TTreeNode.Test2;
             TTreeNode.Test3;
           end.

        ```

    - **NOTAS**
      - Esta unit foi testada nas plataformas: win32, win64 e linux.

    - **VERSÃO**
      - Alpha - 1.0.0

    - **HISTÓRICO**
      - Criado por: Paulo Sérgio da Silva Pacheco e-mail: paulosspacheco@@yahoo.com.br
      - **06/11/2023**
        - 16:00 a 17:20 Criar a unit mi.rtl.treenode.pas

    - **07/11/2023**
      - Criar métodos
        - AddChild
        - AddChildList
        - TreeToStringList
        - TreeToStringListHtml
        - Test1;
        - Test2;
        - Test3;

      - Documentação da classe;

    - **08/11/2023**
      - Criar método GetNodeLevel
      - Ao lista a pasta informa o nível da arvore.

    - **09/11/2023**
      - Idetifiquei um erro no código html gerado no método TreeToStringListHtml
        - O problema está na construção da arvore com o método AddChild().

    - **10/11/2023**
      - Corrigir a construção do método AddChild().
      -

    - **CÓDIGO FONTE**:
      - @html(<a href="../units/mi.rtl.treenode.pas">mi.rtl.treenode.pas</a>)

  }
  TTreeNode = class(TComponent)
    private FIsSheet: Boolean;
    private FTreeNodes: TTreeNodes;
    private fLevel   : Integer;

    public fFilePath: string;
    public fTitle   : string;

    public

      {: o método **@name** retorna o primeiro item}
      Function GetFirstChild:TTreeNode;

      {: o método **@name** retorna próximo item }
      function GetNextChild(AValue: TTreeNode): TTreeNode;

     {: o método **@name** retorna o nível atual do nó}
      function GetNodeLevel():Integer;

      {: o método **@name** adiciona um item na arvore.}
      function AddChild(ParentNode: TComponent; const aName,aFilePath: string; IsSheet: Boolean):TTreeNode;overload;
      function AddChild(ParentNode: TComponent; const aName,aFilePath: string; IsSheet: Boolean;aTitle:String):TTreeNode;overload;
      function AddChild(aTreeNode:TTreeNode;aFileName:String):TTreeNode;overload;


      {: o método **@name** usado para calcular o próximo item da lista. }
//      Function Find_Items(ATreeNodes:TTreeNodes;aComponent:TComponent):TComponent;

    public

      {: O contructor **@name** inicializa os atributos **FIsSheet** e **FTreeNodes** }
      constructor Create(AOwner: TComponent); override;

      {: O destructor **@name** destroi os componentes filhos e o atributos **FTreeNodes** }
      destructor Destroy; override;

      {: A proriedade **@name** retorna true se o item corrente é arquivo e
         false se o item corrente for pasta.}
      property IsSheet: Boolean read FIsSheet write FIsSheet;

      {: A proriedade **@name** retorna a lista de items da pasta corrente}
      property TreeNodes: TTreeNodes read FTreeNodes;

      {: O método **@name** adiciona na arvore a pasta e subpastas e arquivo
         passado pelo  parâmetro **aFilePath**

         **Exemplo**

           ```pascal

             AddChild(root,'/path1/path2/path3/file.txt');

           ```

           - Nota:
             - Esse comando adiciona 3 pastas e um arquivo na arvore.

      }
      //function AddChild(TreeNode:TTreeNode;const aFilePath: string): TTreeNode;virtual;
      //
      //procedure AddChild(aTreeNode:TTreeNode;aFileName:String);overload;

      {: O método **@name** adiciona na arvore uma lista de nome de arquivos
         passados pelo parâmetro aList
      }
//      function AddChildList(Var aList:TStringList): TTreeNode;virtual;

      function conststr(i: Longint; str: String): String;

      {: O método **@name** retorna uma lista de strings indentada}
      Procedure TreeToStringList(TreeNode: TTreeNode; Var S: TStringList);virtual;

      {: O método **@name** código html com a lista de strings indentada}
      Procedure TreeToStringListHtml(TreeNode: TTreeNode; Var S: TStringList);virtual;

      {: A classe método **@name** mostra o uso dos métodos **AddChild** e
         **TreeToStringList**

         ```pascal
            // Teste1:

            class procedure TTreeNode.Test1;
            var
              Root: TTreeNode;
              List : TStringList;
              S : string;

            begin
              writeLn('TTreeNode.Test1');
              writeLn('Inicio: ===============');

              Root := TTreeNode.Create(nil);
              with Root do
              begin
                Root.Name := 'Root';
                Root.IsSheet:=False;
                List := TStringList.Create;

                // Adicione os caminhos de diretórios e folhas da árvore manualmente
                // ...

                // Adicione o arquivo '/home/documentos/test1.pas' com pastas no nome
                AddChild(Root,'/home/documentos/test1.pas');
                AddChild(Root,'/home/documentos/test2.pas');
                AddChild(Root,'test1.pas');
                AddChild(Root,'/home/test1.pas');

                // Exiba a árvore de diretórios
                WriteLn('Árvore de diretórios:');
                Root.TreeToStringList(Root,'   ',List);
                for s in List do
                  writeLn(s);

                List.Free;

              end;
              Root.Free;
            //  ReadLn;
              writeLn('Fim: ===============');

            end;


         ```

      }
      class procedure Test1;

      {: A classe método **@name** mostra o uso dos métodos **AddChild** ,
         **TreeToStringList** e **TreeToStringListHTML**

         ```pascal
           // Teste2:
             class procedure TTreeNode.Test2;
             var
               Root: TTreeNode;
               List : TStringList;
               S : string;


             begin
               writeLn('TTreeNode.Test2');
               writeLn('Inicio: ===============');

               Root := TTreeNode.Create(nil);
               with Root do
               begin
                 Root.Name := 'Root';
                 Root.IsSheet:=False;
                 List := TStringList.Create;

                 // Adicione os caminhos de diretórios e folhas da árvore manualmente
                 // ...

                 // Adicione o arquivo '/home/documentos/test1.pas' com pastas no nome
                 AddChild(Root,'/home/documentos/test1.pas');
                 AddChild(Root,'/home/documentos/test2.pas');
                 AddChild(Root,'test1root.pas');
                 AddChild(Root,'/home/test1.pas');
                 AddChild(Root,'/home/test2.pas');
                 AddChild(Root,'/home/download/test2.pas');

                 // Exiba a árvore de diretórios
                 WriteLn('Árvore de diretórios:');

                 writeLn('Imprimindo list de strings: ');
                 List.Clear;
                 Root.TreeToStringList(Root,'   ',List);
                 for s in List do
                   writeLn(s);


                 writeLn('Imprimindo código HTML: ');
                 List.Clear;
                 Root.TreeToStringListHTML(Root,'  ',List);
                 for s in List do
                   writeLn(s);

                 List.Free;

               end;
               Root.Free;
             //  ReadLn;
             writeLn('Fim: ===============');
             end;

         ```

      }
      class procedure Test2;

      {: A classe método **@name** mostra o uso dos métodos **AddChildList** e
         **TreeToStringList**

         ```pascal
           // Teste3:

           class procedure TTreeNode.Test3;
           var
             Root: TTreeNode;
             List  : TStringList;
             Files : TStringList;
             S : string;


           begin
             writeLn('TTreeNode.Test3');
             writeLn('Inicio: ===============');

             Root := TTreeNode.Create(nil);
             with Root do
             begin
               Root.Name := 'Root';
               Root.IsSheet:=False;
               List := TStringList.Create;

               Files := TStringList.Create;
                 Files.add('/home/documentos/test1.pas');
                 Files.Add('/home/documentos/test2.pas');
                 Files.Add('test1root.pas');
                 Files.Add('/home/test1.pas');
                 Files.Add('/home/test2.pas');
                 Files.Add('/home/download/test2.pas');
               Root.AddChildList(Files);

               // Exiba a árvore de diretórios
               WriteLn('Árvore de diretórios:');
               Root.TreeToStringList(Root,'   ',List);
               for s in List do
                 writeLn(s);

               //writeLn('Imprimindo código HTML: ');
               //List.Clear;
               //Root.TreeToStringListHTML(Root,'  ',List);
               //for s in List do
               //  writeLn(s);

               List.Free;
               Files.free;

             end;
             Root.Free;
             writeLn('Fim: ===============');
           end;

         ```

      }
      class procedure Test3;
  end;

procedure Register;

implementation


procedure Register;
begin
  {$I treenode_icon.lrs}
  RegisterComponents('Mi.Rtl',[TTreeNode]);
end;



{ TTreeNodes ============================================================}

constructor TTreeNodes.create(AOwner:TTreeNode);
begin
  inherited  create;
  Owner := AOwner;
//  Sorted:=true;
  fCurrent := 0;
end;

//function TTreeNodes.FindNodeWithTextInTree(aTree:TTreeNode;aName:string):TTreeNode;
//  var
//    i,N ,t: Integer;
//    tree : TTreeNode = nil;
//    s : string;
//begin
//  if Owner <> nil
//  then t := Owner.ComponentCount;
//  result := nil;
// N := Count;
// for i := 0 to n-1 do
// begin
//   s := Get(i);
//   if s<>''
//   then begin
//          if aTree.TreeNodes.GetObject(i)<>nil
//          Then tree := aTree.TreeNodes.GetObject(i) as TTreeNode
//          else Tree := nil;
//
//           if  tree <> nil
//           Then result := (tree as TTreeNode).TreeNodes.FindNodeWithText(aName)
//           else result := nil;
//
//           if Result = nil
//           Then result := FindNodeWithTextInTree(tree,aName);
//
//           if result <> nil
//           then break;
//        end;
// end;
//
//end;


function TTreeNodes.FindNodeWithText(aName:string):TTreeNode;
  Var
    i : Integer;
    CompareRes: PtrInt;
    ws : String;

begin
  if Sorted
  then begin
         if Find(UpCase(aName), fCurrent)
         then Result := GetObject(fCurrent) as TTreeNode
         else Result := nil;
       end
  else begin //Busca sequencial
         Result := nil;
         fCurrent:=-1;
         For i := 0 to Count-1 do
         begin
           ws := Get(I);
           CompareRes := DoCompareText(aName, ws);
           if (CompareRes=0) then
           begin
             fCurrent:= i;
             Result := GetObject(fCurrent) as TTreeNode ;
             break;
           end;
         end;
       end;

end;

//  var
//    Index: Integer;
//    countt :Integer;
//begin
//  countt:=count;
//  if countt > 1
//  then begin
//          if find(Upcase(aName),index)
//          then Result := GetObject(index) as TTreeNode
//          else Result := nil;
//       end
//  else Result := nil;
//end;


function TTreeNodes.FirstChild:TTreeNode;
begin
  result := GetObject(0) as TTreeNode;
end;

function TTreeNodes.NextChild(AValue:TTreeNode):TTreeNode;
  var
    index :Integer;
begin
  if find(AValue.Name,index)then
  begin
    if index < count then
    begin
      fCurrent:= index+1;
      result := GetObject(fCurrent) as TTreeNode;
    end
    else Result := nil;
  end
  else Result := nil;
end;


function TTreeNodes.GetNameValid(aFileName:String):String;

  type TAnsiCharSet = Set Of AnsiChar;//:< AnsiCharacter set

  function RemoveAccents(const str: String): String;
    const
      AccentedChars : array[0..25] of string = ('á','à','ã','â','ä','é','è','ê','ë','í','ì','ï','î','ó','ò','õ','ô','ö','ú','ù','ü','û','ç','ñ','ý','ÿ');
      NormalChars   : array[0..25] of string = ('a','a','a','a','a','e','e','e','e','i','i','i','i','o','o','o','o','o','u','u','u','u','c','n','y','y');
    var
      i: Integer;
  begin
    Result := str;
    for i := 0 to 25 do
      Result := StringReplace(Result, AccentedChars[i], NormalChars[i], [rfReplaceAll]);
  end;

  function DeleteChars(campo: AnsiString;CharInvalid:TAnsiCharSet): AnsiString;
    Var
      I : Integer;
      ch : WideChar;
  Begin
    Result := '';
    campo := RemoveAccents(campo);
    For i :=  1 to Length(campo)   do
    Begin
      ch := campo[i];
      if (not(ch in CharInvalid )) and (ord(ch)>0)
      Then Begin
             if campo[i] <> ' '
             Then Result := Result + campo[i]
             else Result := Result + '_';
           end;
    end;

  end;

begin
  result := Upcase(DeleteChars(aFileName,['{','}','-','.']));
end;

function TTreeNodes.getName(FilePath:TStringArray;n:Integer):string;
  var
    j : Integer;

begin
  Result := '';
  for j := 1 to N do
    Result := Result + GetNameValid(FilePath[j]);
end;

function TTreeNodes.AddObject(const S: string; AObject: TObject): Integer;
  var
    c :Integer;
begin
  c := count;
  Result := inherited AddObject(S,AObject);

  c := count;
end;

function TTreeNodes.AddChild(ParentNode: TTreeNode; const aName,aFilePath: string; IsSheet: Boolean):TTreeNode;overload;
  Var coun : integer;
      s : string;
begin

  if FindNodeWithText(aname)<>nil
  then begin result := nil ; exit;end;

  result := TTreeNode.Create(nil);
  if ParentNode <>nil
  Then ParentNode.InsertComponent(result);


  result.Name := GetNameValid(aName);
  result.IsSheet := IsSheet;
  result.fFilePath:=aFilePath;

  if ParentNode <>nil
  Then Begin
         (ParentNode as  TTreeNode).TreeNodes.AddObject(result.Name,result);

         coun := (ParentNode as  TTreeNode).TreeNodes.Count;
         s := (ParentNode as  TTreeNode).name;
       end
  else begin
         AddObject(result.Name ,result);
         coun := self.Count;
         s := result.name;
       end;
end;

function TTreeNodes.SplitString(aInputString:string; aDelimiter: Char):TStringArray;

   procedure AddChildToArray(var A: TStringArray; const B: String);
   begin
     SetLength(A, Length(A) + 1);
     A[High(A)] := B;
   end;

 var
   StringList: TStringList;
   Part: string;

begin
  Result := [];
  StringList := TStringList.Create;
  try
    StringList.Delimiter := aDelimiter;
    StringList.DelimitedText := aInputString;

    for Part in StringList do
    begin
      AddChildToArray(Result,Part);
    end;

  finally
     StringList.Free;
  end;
end;


function TTreeNodes.AddChild(aRoot:TTreeNode;aFileName:String):TTreeNode;overload;
 var
   s_owner : string;
var
  Parts: TStringArray;
  CurrentNode: TTreeNode;
//  Part: string;
  i : Integer;
begin
  // Divide o caminho do arquivo em partes usando a barra como delimitador
  Parts := aFileName.Split('/');

  CurrentNode := aRoot;

  // Percorre as partes do caminho e cria os nós conforme necessário
  for i := 0 to high(Parts) do
  if Parts[i] <> '' Then
  begin
    // Procura um filho existente com o mesmo nome

    if Pos('.',Parts[i])=0 //é pasta
    then begin
           s_owner := GetName(Parts,i-1);
           CurrentNode := FindNodeWithText(s_owner);
           // Se não encontrou, cria um novo nó
           if not Assigned(CurrentNode)
           then CurrentNode := AddChild(aRoot,s_owner,s_owner,false)
         end
    else CurrentNode := AddChild(CurrentNode,Parts[i],Parts[i],true);

  end;
  result := CurrentNode;
end;



//function TTreeNodes.AddChild(aTreeNode:TTreeNode;aFileName:String):TTreeNode;overload;
//
//  function FindNodeWithTextInTree(aTree:TTreeNode;aName:string):TTreeNode;
//  begin
//    result := aTree.TreeNodes.FindNodeWithTextInTree(aTree,aName);
//  end;
//
//  var
//    Paths :TStringArray;
//    s,s_owner,folha : string;
//    i : integer;
//
//    aTreeNode_owner:TTreeNode ;
//begin
//  CurrentNode: TTreeNode;
//
//  Paths :=  SplitString(aFileName,PathDelim);
//  for i := 0 to High(Paths)do
//  begin
//    if i > 1
//    Then begin
//           if i=High(Paths)
//           then s := Paths[i]
//           else s:= GetName(Paths,i)
//
//         end
//    else s := Paths[i];
//    if s <> ''
//    then begin
//            if pos('.',s)<> 0
//            then begin
//                   if i>1
//                   then s_owner := GetName(Paths,i-1)
//                   else s_owner := '';
//
//                   if s_owner <> ''
//                   then aTreeNode_owner := FindNodeWithTextInTree(aTreeNode,s_owner)
//                   else aTreeNode_owner := aTreeNode;
//
//                   if aTreeNode_owner <> nil
//                   then result := aTreeNode.TreeNodes.AddChild(aTreeNode_owner,s_owner,aFileName,true)
//                   else result := aTreeNode.TreeNodes.AddChild(aTreeNode,aTreeNode.name,aFileName,true)
//
//                 end
//            else begin
//                   if FindNodeWithTextInTree(aTreeNode,s)=nil
//                   then begin
//                          if i>1
//                          then s_owner := GetName(Paths,i-1)
//                          else s_owner := '';
//
//                          if s_owner <> ''
//                          then aTreeNode_owner := FindNodeWithTextInTree(aTreeNode,s_owner)
//                          else aTreeNode_owner := aTreeNode;
//
//                          if aTreeNode_owner <>nil
//                          then aTreeNode := aTreeNode.TreeNodes.AddChild(aTreeNode_owner,s,s,false)
//                          else aTreeNode := aTreeNode.TreeNodes.AddChild(aTreeNode      ,s,s,false)
//                        end;
//                 end;
//         end;
//  end;
//end;


{TTreeNode =================================================================}

constructor TTreeNode.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FIsSheet := False;
  FTreeNodes := TTreeNodes.Create(aOwner as TTreeNode);
end;

destructor TTreeNode.Destroy;
  var
  i: Integer;
begin

  for i := 0 to FTreeNodes.Count - 1 do
    TTreeNode(FTreeNodes[i]).Free;
  FTreeNodes.Free;
  inherited Destroy;
end;

//function TTreeNode.GetParentComponent:TComponent;
//begin
//  result := Owner;
//end;


function TTreeNode.AddChild(ParentNode: TComponent; const aName,aFilePath: string; IsSheet: Boolean):TTreeNode;overload;
begin
  if ParentNode <> nil
  then result := TreeNodes.AddChild(ParentNode as TTreeNode,aName,aFilePath,IsSheet)
  else result := nil;
end;

//function TTreeNode.AddChild(ParentNode: TComponent; const aName,aFilePath: string; IsSheet: Boolean):TTreeNode;overload;
//  Var coun : integer;
//      s : string;
//begin
//
//  if FindComponent(Name)<>nil
//  then begin result := nil ; exit;end;
//
//  if ParentNode <>nil
//  Then result := TTreeNode.Create(ParentNode)
//  else result := TTreeNode.Create(self);
//
//  result.Name := GetNameValid(aName);
//  result.IsSheet := IsSheet;
//  result.fFilePath:=aFilePath;
//
//  if ParentNode <>nil
//  Then Begin
//         (ParentNode as  TTreeNode).TreeNodes.AddObject(result.Name,result);
//         coun := (ParentNode as  TTreeNode).TreeNodes.Count;
//         s := (ParentNode as  TTreeNode).name;
//       end
//  else begin
//         TreeNodes.AddObject(result.Name ,result);
//         coun := TreeNodes.Count;
//         s := result.name;
//       end;
//end;

function TTreeNode.AddChild(ParentNode:TComponent;const aName,aFilePath:string;
  IsSheet:Boolean;aTitle:String):TTreeNode;
begin
  result := AddChild(ParentNode,aName,aFilePath,IsSheet);
  result.fTitle:=aTitle;
end;

function TTreeNode.AddChild(aTreeNode:TTreeNode;aFileName:String):TTreeNode;
begin
  result := TreeNodes.AddChild(aTreeNode,aFileName);
end;


function TTreeNode.GetFirstChild:TTreeNode;
begin
  if (TreeNodes <> nil) and (TreeNodes.Count>0)
  Then result := TreeNodes.FirstChild
  else result := nil;
end;

function TTreeNode.GetNextChild(AValue:TTreeNode):TTreeNode;
  var
    i:integer;
begin
  result := treeNodes.NextChild(aValue);

end;

function TTreeNode.GetNodeLevel:Integer;
   var
     prev : Tcomponent;
  begin
    //result := fLevel;
    result := 0;
    prev   := owner;
    while prev<>nil do
    begin
      inc(Result);
      prev   := prev.Owner;
    end;


  end;

//function TTreeNode.SplitString(aInputString:string; aDelimiter: Char):TStringArray;
//
//   procedure AddChildToArray(var A: TStringArray; const B: String);
//   begin
//     SetLength(A, Length(A) + 1);
//     A[High(A)] := B;
//   end;
//
// var
//   StringList: TStringList;
//   Part: string;
//
//begin
//  Result := [];
//  StringList := TStringList.Create;
//  try
//    StringList.Delimiter := aDelimiter;
//    StringList.DelimitedText := aInputString;
//
//    for Part in StringList do
//    begin
//      AddChildToArray(Result,Part);
//    end;
//
//  finally
//     StringList.Free;
//  end;
//end;



//function TTreeNode.AddChild(TreeNode:TTreeNode;const aFilePath: string): TTreeNode;
//
//var
//  PathList: TStringArray;
//  i,scount: Integer;
//  s,s_owner:String;
//
//  nodeOwner:TComponent;
//
//begin
//  nodeOwner := TreeNode;
//  // Adicione o caminho completo do arquivo
//  PathList := SplitString(aFilePath, PathDelim);
//  result := TreeNode;
//  if High(PathList)=0
//  then begin
//         s := GetNameValid(aFilePath);
//         if (pos('.',aFilePath)<>0)
//         Then result := AddChild(TreeNode,s,aFilePath,true)
//         else result := AddChild(TreeNode,s,aFilePath,false);
//         Result.fTitle := '';
//         Result.fLevel := 1;
//        end;
//
//  // Percorra cada parte do caminho
//  for i := 1 to High(PathList) do
//  begin
//    // Se i = 1 adiciona no root
//    if i = 1 then
//    with TreeNode do
//    begin
//      s := getName(PathList,i);
//
//      if (pos('.',PathList[i])<>0)
//      Then result := AddChild(TreeNode,s,PathList[i],true)
//      else begin
//             result := find_Items(TreeNodes,FindComponent(s)) as TTreeNode;
//             if result = nil
//             Then begin
//                    result := AddChild(TreeNode,s,PathList[i],false);
//                  end;
//           end;
//      Result.fLevel := 1;
//      Continue;
//    end;
//
//    //Se i <> 1 adiciona em FindComponent(s)
//    with TreeNode do
//    begin
//      if i < High(PathList)
//      then begin
//             s_owner := getName(PathList,i-1);
//             // Checa se o componente existe.
//             nodeOwner := FindComponent(s_owner);
//           end;
//
//
//
//      s := GetName(PathList,i);
//      if (pos('.',PathList[i])<>0) // Se for folha
//      Then begin
//             if FindComponent(s) = nil
//             then result := AddChild(nodeOwner,s,PathList[i],true)
//           end
//      else begin
//             result := find_Items(TreeNodes,FindComponent(s)) as TTreeNode;
//             if result = nil
//             Then begin
//                    if nodeOwner.FindComponent(s)=nil
//                    then begin
//                           nodeOwner := AddChild(nodeOwner,s,PathList[i],false);
//                         end;
//                  end;
//           end;
//      if Result <> nil
//      then Result.fLevel := i;
//    end;
//  end;
//end;


//function TTreeNode.AddChildList(var aList:TStringList  ):TTreeNode;
//  var
//    s : string;
//begin
//  for s in aList do
//  begin
//    result := AddChild(self,s);
//  end;
//end;

//procedure TTreeNode.AddChild(aTreeNode:TTreeNode;aFileName:String);overload;
//  var
//    Paths :TStringArray;
//    s,s_owner,folha : string;
//    i : integer;
//    aTreeNode_owner:TTreeNode ;
//begin
//  Paths :=  SplitString(aFileName,PathDelim);
//  for i := 0 to High(Paths)do
//  begin
//    if i > 1
//    Then begin
//           if i=High(Paths)
//           then s := Paths[i]
//           else s:= GetName(Paths,i)
//
//         end
//    else s := Paths[i];
//
//    if pos('.',s)<> 0
//    then begin
//           if i>1
//           then s_owner := GetName(Paths,i-1)
//           else s_owner := '';
//
//           if s_owner <> ''
//           then aTreeNode_owner := aTreeNode.TreeNodes.FindNodeWithText(s_owner)
//           else aTreeNode_owner := aTreeNode;
//
//           if aTreeNode_owner <> nil
//           then aTreeNode.TreeNodes.AddChild(aTreeNode_owner,aFileName)
//           else aTreeNode.TreeNodes.AddChild(aTreeNode,aFileName)
//
//         end
//    else begin
//           if aTreeNode.TreeNodes.FindNodeWithText(s)=nil
//           then begin
//                  if i>1
//                  then s_owner := GetName(Paths,i-1)
//                  else s_owner := '';
//
//                  if s_owner <> ''
//                  then aTreeNode_owner := aTreeNode.TreeNodes.FindNodeWithText(s_owner)
//                  else aTreeNode_owner := aTreeNode;
//
//                  aTreeNode := aTreeNode.TreeNodes.AddChild(aTreeNode_owner,s);
//                end;
//         end;
//  end;
//
//end;

function TTreeNode.conststr(i: Longint; str: String): String;
  var j : Longint;
begin
  result := '';
  for j := 0 to i do
  begin
     result := result + str;
  end;
end;

procedure TTreeNode.TreeToStringList(TreeNode:TTreeNode; var S:TStringList);

var
  ChildNode: TTreeNode;
  s1 : string;
  FileType: string;
  i,ni : Integer;
begin
  if TreeNode.IsSheet then
    FileType := ' (Folha)'
  else
    FileType := ' (Nó)';

  if (TreeNode.fFilePath <> '') and (TreeNode.GetNodeLevel()>0)
  Then begin
         ni:= TreeNode.GetNodeLevel;
         if TreeNode.IsSheet
         then S.add( ConstStr(ni*2,' ')+TreeNode.fFilePath + FileType+' '+IntToStr(TreeNode.GetNodeLevel))
         else S.add( ConstStr(ni*2,' ')+TreeNode.fFilePath + FileType+' '+IntToStr(TreeNode.GetNodeLevel));
        end;

  //for s1 in TreeNode.TreeNodes do
  //begin
  //
  //  ChildNode := nil;
  //  TreeToStringList(ChildNode, s);
  //end;
  for i := 0 to TreeNode.TreeNodes.Count-1 do
    TreeToStringList((TreeNode.TreeNodes.Objects[i]) as TTreeNode, s);


end;

//procedure TTreeNode.TreeToStringList(TreeNode:TTreeNode; var S:TStringList);
//
//var
//  ChildNode: TTreeNode;
//  FileType: string;
//  i,ni : Integer;
//begin
//  if TreeNode.IsSheet then
//    FileType := ' (Folha)'
//  else
//    FileType := ' (Nó)';
//
//  if (TreeNode.fFilePath <> '') and (TreeNode.GetNodeLevel()>0)
//  Then begin
//         ni:= TreeNode.GetNodeLevel;
//         if TreeNode.IsSheet
//         then S.add( ConstStr(ni*2,' ')+TreeNode.fFilePath + FileType+' '+IntToStr(TreeNode.GetNodeLevel))
//         else S.add( ConstStr(ni*2,' ')+TreeNode.fFilePath + FileType+' '+IntToStr(TreeNode.GetNodeLevel));
//        end;
//
//  //for ChildNode in TreeNode.TreeNodes do
//  //  TreeToStringList(ChildNode, s);
//
//  for i := 0 to TreeNode.TreeNodes.Count-1 do
//    TreeToStringList(ChildNode, s);
//
//end;

//function TTreeNode.ToHTML: string;
//var
//  i: Integer;
//  Child: TTreeNode;
//begin
//  Result := '<ul><li>' + Text;
//
//  if TreeNodes.Count > 0 then
//  begin
//    for i := 0 to TreeNodes.Count - 1 do
//    begin
//      Child := TTreeNode(TreeNodes[i]);
//      Result := Result + Child.ToHTML ;
//    end;
//  end;
//
//  Result := Result + '</li></ul>';
//end;


procedure TTreeNode.TreeToStringListHtml(TreeNode:TTreeNode; var S:TStringList);
var
  ChildNode: TTreeNode;
  i : Integer;
  ow:String;
begin
  if Assigned(TreeNode) then
//  With treeNode do
  begin
    if TreeNode.Owner <> nil
    then ow := TreeNode.Owner.Name
    else ow:= 'new';

    s.Add('<ul><li>'+treeNode.fFilePath+' dono: '+ow);

    //for ChildNode in TreeNode.TreeNodes do
    //  TreeToStringListHtml(ChildNode, s);
    for i := 0 to TreeNode.TreeNodes.Count-1 do
      TreeToStringListHtml(ChildNode, s);


    s.Add('</li></ul>');
  end;
end;

class procedure TTreeNode.Test1;
var
  Root: TTreeNode;
  List : TStringList;
  S : string;

begin
  writeLn('TTreeNode.Test1');
  writeLn('Inicio: ===============');

  Root := TTreeNode.Create(nil);

  with Root do
  begin

    Root.Name := 'root';
    Root.fFilePath:='/';
    Root.IsSheet:=False;

    List := TStringList.Create;

    // Adicione os caminhos de diretórios e folhas da árvore manualmente
    // ...

    // Adicione o arquivo '/home/documentos/test1.pas' com pastas no nome
    AddChild(Root,'/home/documentos/test1.pas');
    AddChild(Root,'/home/documentos/test2.pas');
    AddChild(Root,'/home/documentos/mamae/test3.pas');
    AddChild(Root,'/home/documentos/mamae/celia/test4.pas');
//    s := (root..Owner.Owner as TTreeNode).fFilePath;
    AddChild(Root,'test5.pas');
    AddChild(Root,'/home/test6.pas');

    // Exiba a árvore de diretórios
    WriteLn('Árvore de diretórios:');
    Root.TreeToStringList(Root,List);
    for s in List do
      writeLn(s);

    List.Free;

  end;
  Root.Free;
//  ReadLn;
  writeLn('Fim: ===============');

end;

class procedure TTreeNode.Test2;
  var
    Root: TTreeNode;
    List : TStringList;
    S : string;


  begin
    writeLn('TTreeNode.Test2');
    writeLn('Inicio: ===============');

    Root := TTreeNode.Create(nil);
    with Root do
    begin
      Root.Name := 'Root';
      Root.IsSheet:=False;
      List := TStringList.Create;

      // Adicione os caminhos de diretórios e folhas da árvore manualmente
      // ...

      // Adicione o arquivo '/home/documentos/test1.pas' com pastas no nome
      AddChild(Root,'/home/documentos/doc_test1.pas');
      AddChild(Root,'/home/documentos/doc_test2.pas');
      AddChild(Root,'/home/documentos/pasta3/doc_test1.pas');
      //AddChild(Root,'root_test1.pas');
      //AddChild(Root,'/home/home_test1.pas');
      //AddChild(Root,'/home/home_test2.pas');
      //AddChild(Root,'/home/download/download_test1.pas');
      //AddChild(Root,'/home/download/download_test2.pas');

      // Exiba a árvore de diretórios
      WriteLn('Árvore de diretórios:');

      //writeLn('Imprimindo list de strings: ');
      //List.Clear;
      //Root.TreeToStringList(Root,List);
      //for s in List do
      //  writeLn(s);
      //

      writeLn('Imprimindo código HTML: ');
      List.Clear;
      Root.TreeToStringListHTML(Root,List);
      for s in List do
        writeLn(s);

      List.Free;

    end;
    Root.Free;
  //  ReadLn;
  writeLn('Fim: ===============');
  end;

class procedure TTreeNode.Test3;
var
  Root: TTreeNode;
  List  : TStringList;
  Files : TStringList;
  S : string;


begin
  writeLn('TTreeNode.Test3');
  writeLn('Inicio: ===============');

  Root := TTreeNode.Create(nil);
  with Root do
  begin
    Root.Name := 'Root';
    Root.IsSheet:=False;
    List := TStringList.Create;

    //Files := TStringList.Create;
    //  Files.add('/home/documentos/test1.pas');
    //  Files.Add('/home/documentos/test2.pas');
    //  Files.Add('test1root.pas');
    //  Files.Add('/home/test1.pas');
    //  Files.Add('/home/test2.pas');
    //  Files.Add('/home/download/test2.pas');
    //  Root.AddChildList(Files);

    // Exiba a árvore de diretórios
    WriteLn('Árvore de diretórios:');
    Root.TreeToStringList(Root,List);
    for s in List do
      writeLn(s);

    //writeLn('Imprimindo código HTML: ');
    //List.Clear;
    //Root.TreeToStringListHTML(Root,'  ',List);
    //for s in List do
    //  writeLn(s);

    List.Free;
    Files.free;

  end;
  Root.Free;
  writeLn('Fim: ===============');
end;

end.
