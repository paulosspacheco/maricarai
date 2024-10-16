unit uFormMain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, StdCtrls, Dialogs, Buttons, ComCtrls,
  ExtCtrls, ActnList, fphttpclient, fpjson, jsonparser
  ,mi.rtl.treenode, uform_UsuarioController, uForm_Mi_rtl_WebModule_Custom

  ,umi_lcl_ui_ds_form
  ;

type

  { TFormMain }

  TFormMain = class(TForm)
     Action_TMi_rtl_WebModule_Custom_ShowModal: TAction;
     Action_TUsuarioController_ShowModal: TAction;
     ActionList1: TActionList;
     Mi_lcl_ui_ds_Form1: TMi_lcl_ui_ds_Form;
     Panel1: TPanel;
     TreeView1: TTreeView;
     procedure Action_TMi_rtl_WebModule_Custom_ShowModalExecute(Sender: TObject);
     procedure Action_TUsuarioController_ShowModalExecute(Sender: TObject);
     procedure FormCreate(Sender: TObject);
     procedure FormDestroy(Sender: TObject);
     procedure TreeView1Change(Sender: TObject; Node: TTreeNode);
   private
   public
   var
     RootNode: TMi_rtl_treenode;
  end;

var
  FormMain: TFormMain;

implementation

{$R *.lfm}

{ TFormMain }


//procedure TFormMain.PopulateTreeViewFromTMi_rtl_treenode(aNode: TMi_rtl_treenode; TreeViewNode: TTreeNode);
//var
//  Child: TMi_rtl_treenode;
////  NewTreeNode: TTreeNode;
//begin
//  if aNode = nil then Exit;
//
//  // Adiciona um novo nó ao TTreeView
//  if TreeViewNode = nil then
//    TreeViewNode := TreeView1.Items.AddChild(nil, TPathAction(aNode.Data).Data)
//  else
//    TreeViewNode := TreeView1.Items.AddChild(TreeViewNode, TPathAction(aNode.Data).Data);
//
//    // Associa a ação, se houver
//    if TPathAction(aNode.Data).Action <> nil
//    then TreeViewNode.Data := Pointer(TPathAction(aNode.Data).Action);
//
//  // Itera sobre os filhos do nó TMi_rtl_treenode
//  Child := aNode.GetFirstChild;
//  while Child <> nil do
//  begin
//    PopulateTreeViewFromTMi_rtl_treenode(Child, TreeViewNode);
//    Child := Child.GetNextSibling;
//  end;
//end;
//

procedure TFormMain.FormCreate(Sender: TObject);
begin
  // Criação e configuração do nó raiz e da árvore
  RootNode := TMi_rtl_treenode.Create(TPathAction.Create('Root Node', False));
  try
    RootNode.AddChildAction('TUsuarioController/ShowModal', Action_TUsuarioController_ShowModal);
    RootNode.AddChildAction('TMi_rtl_WebModule_Custom/ShowModal', Action_TMi_rtl_WebModule_Custom_ShowModal);

    // Popula o TTreeView com os dados do TMi_rtl_treenode
    Mi_lcl_ui_ds_Form1.PopulateTreeViewFromTMi_rtl_treenode(RootNode,TreeView1,nil);
  finally
  end;

end;

procedure TFormMain.FormDestroy(Sender: TObject);
begin
  RootNode.Free;
end;

procedure TFormMain.TreeView1Change(Sender: TObject; Node: TTreeNode);
begin
  Mi_lcl_ui_ds_Form1.ExecuteTreeViewNodeAction(Node);
end;

procedure TFormMain.Action_TUsuarioController_ShowModalExecute(Sender: TObject);
begin
  Mi_lcl_ui_ds_Form1.ShowModal(TForm_UsuarioController);
end;

procedure TFormMain.Action_TMi_rtl_WebModule_Custom_ShowModalExecute(Sender: TObject);
begin
  Mi_lcl_ui_ds_Form1.ShowModal(TForm_Mi_rtl_WebModule_Custom);
end;

end.


