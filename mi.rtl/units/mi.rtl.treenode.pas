
unit mi.rtl.treenode;
{:< - A Unit **@name** implementa a classe **TTreeNode** do pacote **mi.rtl**.

  - **NOTAS**
    - Esta unit foi testada nas plataformas: linux.

  - **VERSÃO**
    - Alpha - Alpha - 0.9.0

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
  Classes, SysUtils,LResources
  , Contnrs;


type
  { TTreeNode }
  TTreeNode = class
  private
    FData: TObject;
    FChildren: TObjectList;
    FParent: TTreeNode; // Adicionando a referência ao nó pai

  public
    constructor Create(AData: TObject);
    destructor Destroy; override;

    function AddChild(AChildData: TObject): TTreeNode;
    procedure RemoveChild(AChild: TTreeNode);
    procedure ClearChildren;

    property Data: TObject read FData write FData;
    property Children: TObjectList read FChildren;

    {$REGION '--->Construção da metodo AddChildFileName'}
      function Create_Object(aFileName,aPart:String):TObject;virtual;
      procedure AddChildFileName(Root: TTreeNode; FileName: string);
    {$ENDREGION}
    {: o método **@name** retorna o nível atual do nó}
     function GetNodeLevel():Integer;

    function conststr(i: Longint; str: String): String;

    {: O método **@name** retorna uma lista de strings indentada}
    Procedure TreeToStringList(TreeNode: TTreeNode; Var S: TStringList);virtual;

    {: O método **@name** código html com a lista de strings indentada}
    Procedure TreeToStringListHtml(TreeNode: TTreeNode; Var S: TStringList);virtual;




    property Parent: TTreeNode read FParent write FParent; // Nova propriedade

    class procedure Test1;
    class procedure Test2;
  end;

  type
  { TPath }
  TPath = class(TObject)
    public Data : String;
    public IsSheet : Boolean;
    public constructor create(aData:String;aIsSheet:Boolean);virtual;overload;
  end;


  type
   {: A classe **@name** usada somente para interir a classe TTreeNode em um
      TDataModule ou um TForm. }
   TTreeNodeComponent = class(TComponent)
      type TTreeNode = mi.rtl.treenode.TTreeNode;
   end;

procedure Register;

implementation


procedure Register;
begin
  {$I treenode_icon.lrs}
  RegisterComponents('Mi.Rtl',[TTreeNodeComponent]);
end;



{ TPath }
constructor TPath.create(aData:String;aIsSheet:Boolean);
begin
  inherited create;
  Data := aData;
  IsSheet:= aIsSheet;
end;

{TTreeNode}
constructor TTreeNode.Create(AData: TObject);
begin
  FData := AData;
  FChildren := TObjectList.Create(True);
end;

destructor TTreeNode.Destroy;
begin
  FChildren.Free;
  inherited Destroy;
end;

function TTreeNode.AddChild(AChildData: TObject): TTreeNode;
var
  ChildNode: TTreeNode;
begin
  ChildNode := TTreeNode.Create(AChildData);
  ChildNode.Parent := Self; // Atribui o nó pai
  FChildren.Add(ChildNode);

  Result := ChildNode;
end;

procedure TTreeNode.RemoveChild(AChild: TTreeNode);
begin
  FChildren.Remove(AChild);
end;

procedure TTreeNode.ClearChildren;
begin
  FChildren.Clear;
end;


function TTreeNode.Create_Object(aFileName,aPart:String):TObject;

begin

  //if Pos('.',aPart)<>0
  if  LowerCase(ExtractFileName(aFileName)) = LowerCase(aPart)
  Then result := TPath.Create(aPart,true)
  else result := TPath.Create(aPart,false);
end;

procedure TTreeNode.AddChildFileName(Root: TTreeNode; FileName: string);
var
  Parts: TStringArray;
  CurrentNode, ChildNode: TTreeNode;
  Part,s: string;
  Found: Boolean;
  i : Integer;
  temp :TPath;
begin
  // Divide o caminho do arquivo em partes usando a barra como delimitador
  Parts := FileName.Split('/');

  // Começa com o nó raiz
  CurrentNode := Root;

  // Percorre as partes do caminho e cria os nós conforme necessário
  for Part in Parts do
  begin
    if Part= '' then Continue;
    Found := False;

    // Procura um filho existente com o mesmo nome
//    for ChildNode in CurrentNode.Children do
    for i := 0 to CurrentNode.Children.Count-1 do
    begin
      ChildNode := CurrentNode.Children.Items[i] as TTreeNode;
      s := (ChildNode.Data as TPath).Data;
      if s = Part then
      begin
        CurrentNode := TTreeNode(ChildNode);
        Found := True;
        Break;
      end;
    end;

    // Se não encontrou, cria um novo nó
    if not Found then
    begin
      temp := Create_Object(FileName,Part) as TPath;
      CurrentNode := CurrentNode.AddChild(temp);
    end;
  end;
end;

function TTreeNode.GetNodeLevel: Integer;
var
  ParentNode: TTreeNode;
begin
  Result := 0; // Nível padrão, considerando que o nó atual é a raiz

  ParentNode := TTreeNode(Self);

  // Percorre os pais até chegar à raiz
  while Assigned(ParentNode.Parent) do
  begin
    Inc(Result);
    ParentNode := ParentNode.Parent;
  end;
end;

function TTreeNode.conststr(i:Longint;str:String):String;
  var j : Longint;
begin
  result := '';
  for j := 0 to i do
    result := result + str;
end;

procedure TTreeNode.TreeToStringList(TreeNode:TTreeNode; var S:TStringList);

var
  FileType: string;
  i,ni : Integer;
begin
  if (TreeNode.Data as TPath).IsSheet then
    FileType := ' (Folha)'
  else
    FileType := ' (Nó)';


  if Assigned(TreeNode) then
  begin
    if (TreeNode.Data as TPath).Data <> '' //and (TreeNode.GetNodeLevel()>0)
    Then begin
           ni:= TreeNode.GetNodeLevel;
           //if (TreeNode.Data as TPath).IsSheet
           //then S.add( ConstStr(ni*2,' ')+TreeNode.fFilePath + FileType+' '+IntToStr(TreeNode.GetNodeLevel))
           //else S.add( ConstStr(ni*2,' ')+TreeNode.fFilePath + FileType+' '+IntToStr(TreeNode.GetNodeLevel));

           if (TreeNode.Data as TPath).IsSheet
           then S.add(ConstStr(ni*2,' ')+(TreeNode.Data as TPath).Data + FileType+' ')
           else S.add(ConstStr(ni*2,' ')+(TreeNode.Data as TPath).Data + FileType+' ');

          end;
  end;


  for i := 0 to TreeNode.Children.Count-1 do
  begin
    TreeToStringList(TreeNode.Children.Items[i] as TTreeNode, s);
  end;

end;

procedure TTreeNode.TreeToStringListHtml(TreeNode:TTreeNode; var S:TStringList);
var
  i: Integer;
begin
  s.Add('<ul>');
  s.Add('<li>');

  //if not (TreeNode.Data as TPath).IsSheet

  s.Add((TreeNode.Data as TPath).Data);

  for i := 0 to TreeNode.Children.Count-1 do
   begin
     TreeToStringListHtml(TreeNode.Children.Items[i] as TTreeNode, s);
   end;

  //if not (TreeNode.Data as TPath).IsSheet

  s.Add('</ul>');
  s.Add('</li>');
end;

class procedure TTreeNode.Test1;
var
  Root: TTreeNode;
  List : TStringList;
  S : string;

begin
  writeLn('TTreeNode.Test1');
  writeLn('Inicio: ===============');

  Root := TTreeNode.Create(TPath.create('root',false));

  with Root do
  begin
    List := TStringList.Create;

    // Adicione os caminhos de diretórios e folhas da árvore manualmente
    // ...

    // Adicione o arquivo '/home/documentos/test1.pas' com pastas no nome
    AddChildFileName(Root,'/home/documentos/test1.pas');
    AddChildFileName(Root,'/home/documentos/test2.pas');
    AddChildFileName(Root,'/home/documentos/mamae/test3.pas');
    AddChildFileName(Root,'/home/documentos/mamae/celia/test4.pas');
//    s := (root..Owner.Owner as TTreeNode).fFilePath;
    AddChildFileName(Root,'test5.pas');
    AddChildFileName(Root,'/home/test6.pas');

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
  writeLn('TTreeNode.Test1');
  writeLn('Inicio: ===============');

  Root := TTreeNode.Create(TPath.create('root',false));

  with Root do
  begin
    List := TStringList.Create;

    // Adicione os caminhos de diretórios e folhas da árvore manualmente
    // ...

    // Adicione o arquivo '/home/documentos/test1.pas' com pastas no nome
    AddChildFileName(Root,'/home/documentos/test1.pas');
    AddChildFileName(Root,'/home/documentos/test2.pas');
    AddChildFileName(Root,'/home/documentos/mamae/test3.pas');
    AddChildFileName(Root,'/home/documentos/mamae/celia/test4.pas');
//    s := (root..Owner.Owner as TTreeNode).fFilePath;
    AddChildFileName(Root,'test5.pas');
    AddChildFileName(Root,'/home/test6.pas');

    // Exiba a árvore de diretórios
    WriteLn('Árvore de diretórios:');
    Root.TreeToStringListHtml(Root,List);
    for s in List do
      writeLn(s);

    List.Free;

  end;
  Root.Free;
//  ReadLn;
  writeLn('Fim: ===============');

end;



end.
