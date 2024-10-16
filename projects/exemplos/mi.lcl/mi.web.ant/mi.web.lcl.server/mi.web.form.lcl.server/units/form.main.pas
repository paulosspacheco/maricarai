unit form.main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, StdCtrls, Dialogs, Buttons, ComCtrls,
  ExtCtrls, ActnList, fphttpclient, fpjson, jsonparser
  ,mi.rtl.treenode

  ,umi_lcl_ui_ds_form, form.server, mi.rtl.web.module.form
  ;

type

  { TFormMain }

  TFormMain = class(TForm)
     CmForm_Mi_Rtl_WebModule: TAction;
     CmForm_Server: TAction;
     ActionList1: TActionList;
     Mi_lcl_ui_ds_Form1: TMi_lcl_ui_ds_Form;
     Panel1: TPanel;
     TreeView1: TTreeView;
     procedure CmForm_Mi_Rtl_WebModuleExecute(Sender: TObject);
     procedure CmForm_ServerExecute(Sender: TObject);
     procedure FormCreate(Sender: TObject);
     procedure FormDestroy(Sender: TObject);

     procedure TreeView1Change(Sender: TObject; Node: TTreeNode);
     procedure TreeView1Click(Sender: TObject);

   private
      NodeCurrent: TTreeNode ;
   public
     RootNode: TMi_rtl_treenode;
  end;

var
  FormMain: TFormMain;

implementation

{$R *.lfm}

{ TFormMain }


procedure TFormMain.FormCreate(Sender: TObject);
begin
  NodeCurrent := nil;
  if not Assigned(Form_server)
  Then begin
          Form_server := TForm_server.Create(self);
          Form_server.StartButtonClick(self);
          Form_server.Show;
       end;

  // Criação e configuração do nó raiz e da árvore
  RootNode := TMi_rtl_treenode.Create(TPathAction.Create('Raiz', False));
  try
    RootNode.AddChildAction('Server', CmForm_Server);
    RootNode.AddChildAction('Server/Form_Mi_Rtl_WebModule',CmForm_Mi_Rtl_WebModule);
    TMi_lcl_ui_ds_Form.PopulateTreeViewFromTMi_rtl_treenode(RootNode,TreeView1,nil);
    TreeView1.FullExpand;
  finally
  end;

end;

procedure TFormMain.FormDestroy(Sender: TObject);
begin
  RootNode.Free;
end;

procedure TFormMain.TreeView1Change(Sender: TObject; Node: TTreeNode);
begin
  NodeCurrent := Node;
  TMi_lcl_ui_ds_Form.ExecuteTreeViewNodeAction(NodeCurrent);
end;

procedure TFormMain.TreeView1Click(Sender: TObject);
begin
  if Assigned(NodeCurrent )
  Then TMi_lcl_ui_ds_Form.ExecuteTreeViewNodeAction(NodeCurrent);
end;



procedure TFormMain.CmForm_ServerExecute(Sender: TObject);
begin
  Form_server.Show;
end;

procedure TFormMain.CmForm_Mi_Rtl_WebModuleExecute(Sender: TObject);
begin
  TMi_lcl_ui_ds_Form.ShowModal(Tmi_rtl_web_module_form);
end;


end.



