unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs,
  StdCtrls, ComCtrls
  ,ActnList
  ,mi.rtl.treenode
  ,Unit2
  , Unit3;

type

  { TForm1 }

  TForm1 = class(TForm)
    Action1: TAction;
    Action2: TAction;
    ActionList1: TActionList;
    Button1: TButton;
    Button_Test_AddChildAction: TButton;
    Button_Test_AddChildFileName: TButton;
    TreeView1: TTreeView;
    procedure Action1Execute(Sender: TObject);
    procedure Action2Execute(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button_Test_AddChildActionClick(Sender: TObject);
    procedure Button_Test_AddChildFileNameClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TreeView1Change(Sender: TObject; Node: TTreeNode);

  private
    procedure ExecuteTreeViewNodeAction(TreeViewNode: TTreeNode);
    procedure PopulateTreeViewFromTMi_rtl_treenode(aNode: TMi_rtl_treenode; TreeViewNode: TTreeNode);


  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button_Test_AddChildFileNameClick(Sender: TObject);
begin
  TMi_rtl_treenode_Test_AddChildFileName(true);
end;

procedure TForm1.Button_Test_AddChildActionClick(Sender: TObject);
begin
  TMi_rtl_treenode_Test_AddChildAction();
end;

procedure TForm1.Action1Execute(Sender: TObject);
begin
  ShowMessage('Alo mundo');
end;

procedure TForm1.Action2Execute(Sender: TObject);
begin
  ShowMessage('Action2');
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  unit3.Form2.ShowModal;
end;

  procedure TForm1.FormCreate(Sender: TObject);
    var
      RootNode: TMi_rtl_treenode;
  begin
    // Criação e configuração do nó raiz e da árvore
    RootNode := TMi_rtl_treenode.Create(TPathAction.Create('Root Node', False));
    try
      RootNode.AddChildAction('Folder1/action1', action1);
      RootNode.AddChildAction('Folder1/action2', action2);
      RootNode.AddChildAction('Folder2/action1', nil);

      // Adicione os caminhos de diretórios e folhas da árvore
      RootNode.AddChildAction('/home/documentos/ShowMessageAction', action1);
      RootNode.AddChildAction('/home/documentos/test2.pas', nil);
      RootNode.AddChildAction('/home/documentos/mamae/test3.pas', nil);
      RootNode.AddChildAction('/home/documentos/test1.pas', nil);
      RootNode.AddChildAction('/home/documentos/test2.pas', nil);
      RootNode.AddChildAction('/home/documentos/mamae/test3.pas', nil);
      RootNode.AddChildAction('/home/documentos/mamae/celia/test4.pas', nil);
      RootNode.AddChildAction('test5.pas', nil);
      RootNode.AddChildAction('/home/test6.pas', nil);
      RootNode.AddChildAction('test5.pas', nil);
      RootNode.AddChildAction('/home/test6.pas', nil);

      // Popula o TTreeView com os dados do TMi_rtl_treenode
      PopulateTreeViewFromTMi_rtl_treenode(RootNode, nil);
    finally
      RootNode.Free;
    end;

  end;

  procedure TForm1.ExecuteTreeViewNodeAction(TreeViewNode: TTreeNode);
  begin
    if (TreeViewNode <> nil) and (TreeViewNode.Data <> nil) then
    begin
      // Verifica se o Data é um ponteiro para TAction
      if TObject(TreeViewNode.Data) is TAction then
      begin
        TAction(TreeViewNode.Data).Execute;
      end
      else
      begin
        ShowMessage('O item selecionado não tem uma ação associada.');
      end;
    end;
  end;

  procedure TForm1.TreeView1Change(Sender: TObject; Node: TTreeNode);
  begin
    ExecuteTreeViewNodeAction(TreeView1.Selected);
  end;

  procedure TForm1.PopulateTreeViewFromTMi_rtl_treenode(aNode: TMi_rtl_treenode; TreeViewNode: TTreeNode);
    var
      Child: TMi_rtl_treenode;
  begin
    if aNode = nil then Exit;

    // Adiciona um novo nó ao TTreeView
    if TreeViewNode = nil
    then TreeViewNode := TreeView1.Items.AddChild(nil, TPathAction(aNode.Data).Data)
    else TreeViewNode := TreeView1.Items.AddChild(TreeViewNode, TPathAction(aNode.Data).Data);

     TreeViewNode.Data := TPathAction(aNode.Data).Action ;

    // Itera sobre os filhos do nó TMi_rtl_treenode
    Child := aNode.GetFirstChild;
    while Child <> nil do
    begin
      PopulateTreeViewFromTMi_rtl_treenode(Child, TreeViewNode);
      Child := Child.GetNextSibling;
    end;
  end;



end.




