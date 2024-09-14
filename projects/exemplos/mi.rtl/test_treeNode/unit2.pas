unit Unit2;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils,Menus, ComCtrls,mi.rtl.treenode,Forms
  ,ActnList,Dialogs;

procedure TMi_rtl_treenode_Test_AddChildAction();

procedure TMi_rtl_treenode_Test_AddChildFileName(okListHTML: boolean);


implementation


procedure PopulateMenuFromTreeNode(Node: TMi_rtl_treenode; ParentMenuItem: TMenuItem);
var
  Child: TMi_rtl_treenode;
  NewMenuItem: TMenuItem;
  PathAction: TPathAction;
begin
  if Node <> nil then
  begin
    PathAction := TPathAction(Node.Data); // Obtém o objeto TPath associado ao nó

    NewMenuItem := TMenuItem.Create(ParentMenuItem);
    NewMenuItem.Caption := PathAction.Data;
    NewMenuItem.Action  := PathAction.Action;

    ParentMenuItem.Add(NewMenuItem);

    // Se o nó atual não for uma folha, adiciona seus filhos ao menu
    if not PathAction.IsSheet then
    begin
      Child := Node.GetFirstChild;
      while Child <> nil do
      begin
        PopulateMenuFromTreeNode(Child, NewMenuItem);
        Child := Child.GetNextSibling;
      end;
    end;
  end;
end;


type

  { TForm }

  TForm = class(Forms.TForm)
  private
    procedure ShowMessageAction(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    function CreateAction(const ACaption: string): TAction;
  end;

constructor TForm.Create(AOwner: TComponent);
begin
  //inherited Create(AOwner);
  inherited CreateNew(AOwner, 1); // O segundo parâmetro é uma janela vazia

  // Aqui você pode criar e adicionar componentes manualmente
end;

procedure TForm.ShowMessageAction(Sender: TObject);
begin
  ShowMessage('Alô mundo');
end;

function TForm.CreateAction(const ACaption: string): TAction;
begin
  Result := TAction.Create(Self);
  Result.Caption := ACaption;
  Result.OnExecute := @ShowMessageAction; // Associa o método ao evento OnExecute
end;

procedure TMi_rtl_treenode_Test_AddChildAction();
var
  Root: TMi_rtl_treenode;
  MainMenu: TMainMenu;
  Form: TForm;
  action : TAction;
begin
  // Criação e configuração do formulário e do menu
  Form := TForm.Create(nil);

  // Criação do nó raiz e inicialização da árvore
  Root := TMi_rtl_treenode.Create(TPathAction.Create('root', False));
  With Root,Form do
  try
    // Adiciona os caminhos de diretórios e folhas da árvore
    AddChildAction('/home/documentos/ShowMessageAction',CreateAction('ShowMessageAction'));
    AddChildAction('/home/documentos/test2.pas',nil);
    AddChildAction('/home/documentos/mamae/test3.pas',nil);
    AddChildAction('/home/documentos/test1.pas',nil);
    AddChildAction('/home/documentos/test2.pas',nil);
    AddChildAction('/home/documentos/mamae/test3.pas',nil);
    AddChildAction('/home/documentos/mamae/celia/test4.pas',nil);
    AddChildAction('test5.pas',nil);
    AddChildAction('/home/test6.pas',nil);
    AddChildAction('test5.pas',nil);
    AddChildAction('/home/test6.pas',nil);

    try
      MainMenu := TMainMenu.Create(Form);
      Form.Menu := MainMenu;

      // Popula o menu a partir da árvore
      PopulateMenuFromTreeNode(Root, MainMenu.Items);

      Form.ShowModal;
    finally
      Form.Free;
    end;
  finally
    Root.Free;
  end;
end;

procedure TMi_rtl_treenode_Test_AddChildFileName(okListHTML: boolean);
  var
    Root: TMi_rtl_treenode;
    List: TStringList;
    S: string;
begin
  WriteLn('TMi_rtl_treenode.Test');
  WriteLn('Inicio: ===============');

  // Criação do nó raiz e inicialização da árvore
  Root := TMi_rtl_treenode.Create(TPath.Create('root', False));
  With Root do
  try
    // Adiciona os caminhos de diretórios e folhas da árvore
    AddChildFileName('/home/documentos/test1.pas');
    AddChildFileName('/home/documentos/test2.pas');
    AddChildFileName('/home/documentos/mamae/test3.pas');
    AddChildFileName('/home/documentos/test1.pas');
    AddChildFileName('/home/documentos/test2.pas');
    AddChildFileName('/home/documentos/mamae/test3.pas');
    AddChildFileName('/home/documentos/mamae/celia/test4.pas');
    AddChildFileName('test5.pas');
    AddChildFileName('/home/test6.pas');
    AddChildFileName('test5.pas');
    AddChildFileName('/home/test6.pas');

    // Exibe a árvore de diretórios
    WriteLn('Árvore de diretórios:');
    List := TStringList.Create;
    try
      if okListHTML then
        Root.TreeToStringListHtml(Root, List)
      else
        Root.TreeToStringList(Root, List);

      for S in List do
        WriteLn(S);
    finally
      List.Free;
    end;

  finally
    Root.Free;
  end;

  WriteLn('Fim: ===============');
end;


end.

