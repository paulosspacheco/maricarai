var tipuesearch = {"pages": [
     {"title": "uMi_ui_mi_msgbox_dm", "text": "A unit uMi_ui_mi_msgbox_dm é usado para implementar os formulários genéricos LCL necessário para o pacote mi.rtl quando o pacote mi.rtl for usado com um projeto LCL.       Formulários genéricos registrado no projeto mi.rtl:      MI_MsgBox1InputBox;   MI_MsgBox1InputPassword;   MI_MsgBox1InputValue;   MI_MsgBox1MessageBox   MI_MsgBox1MessageBox_03   MI_MsgBox1MessageBox_04   MI_MsgBox1MessageBox_04_PSItem   MI_MsgBox1MessageBox_05   MI_MsgBox1MessageBox_ListBoxRec_PSItem      Classe abstrada implementada aqui é MI_MsgBox1 : TMI_MsgBox;      Essa classe associa os formuário que vem no projeto lazarus ao projeto mi.rtl;   Nota:      Caso o projeto mi.rtl seja usado na web então essa classe deve ser usando código html ou javascript;   Caso o projeto mi.rtl seja usado no console então essa classe deve ser usando o projeto Freevision;            ", "tags": "", "url": "uMi_ui_mi_msgbox_dm.html"},
     {"title": "uMi_ui_mi_msgbox_dm.TMi_ui_mi_msgBox", "text": "TMi_ui_mi_msgBox       EXEMPLO DE USO:      Program test_MI_MsgBox Var   S : String[10] = ''; begin   if MI_MsgBox.InputBox('InputBox Test','Gual a sua indade? ',s,'ssssssssss') = Mrok   then ShowMessage('Sua idade é: 's);   end.        ", "tags": "", "url": "uMi_ui_mi_msgbox_dm.TMi_ui_mi_msgBox.html"},
     {"title": "uMi_ui_mi_msgbox_dm.TMi_ui_mi_msgBox.MI_MsgBox1", "text": "   ", "tags": "", "url": "uMi_ui_mi_msgbox_dm.TMi_ui_mi_msgBox.html#MI_MsgBox1"},
     {"title": "uMi_ui_mi_msgbox_dm.TMi_ui_mi_msgBox.MI_MsgBox1InputBox", "text": "     O evento MI_MsgBox1InputBox é executado pelo método TMI_MsgBox.InputBox       ", "tags": "", "url": "uMi_ui_mi_msgbox_dm.TMi_ui_mi_msgBox.html#MI_MsgBox1InputBox"},
     {"title": "uMi_ui_mi_msgbox_dm.TMi_ui_mi_msgBox.MI_MsgBox1InputPassword", "text": "     O evento MI_MsgBox1InputPassword é executado pelo método TMI_MsgBox.InputPassword       ", "tags": "", "url": "uMi_ui_mi_msgbox_dm.TMi_ui_mi_msgBox.html#MI_MsgBox1InputPassword"},
     {"title": "uMi_ui_mi_msgbox_dm.TMi_ui_mi_msgBox.MI_MsgBox1InputValue", "text": "     O evento MI_MsgBox1InputValue é executado pelo método TMI_MsgBox.InputValue       ", "tags": "", "url": "uMi_ui_mi_msgbox_dm.TMi_ui_mi_msgBox.html#MI_MsgBox1InputValue"},
     {"title": "uMi_ui_mi_msgbox_dm.TMi_ui_mi_msgBox.MI_MsgBox1MessageBox", "text": "     O evento MI_MsgBox1MessageBox é executado pelo método TMI_MsgBox.MessageBox(const aMsg: AnsiString)       ", "tags": "", "url": "uMi_ui_mi_msgbox_dm.TMi_ui_mi_msgBox.html#MI_MsgBox1MessageBox"},
     {"title": "uMi_ui_mi_msgbox_dm.TMi_ui_mi_msgBox.MI_MsgBox1MessageBox_03", "text": "     O evento MI_MsgBox1MessageBox_03 é executado pelo método TMI_MsgBox.MessageBox(const aMsg: AnsiString; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons)       ", "tags": "", "url": "uMi_ui_mi_msgbox_dm.TMi_ui_mi_msgBox.html#MI_MsgBox1MessageBox_03"},
     {"title": "uMi_ui_mi_msgbox_dm.TMi_ui_mi_msgBox.MI_MsgBox1MessageBox_04", "text": "     O evento MI_MsgBox1MessageBox_04 é executado pelo método TMI_MsgBox.MessageBox(aPSItem : TMI_MsgBoxTypes.PSItem; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; ButtonDefault: TMsgDlgBtn)       ", "tags": "", "url": "uMi_ui_mi_msgbox_dm.TMi_ui_mi_msgBox.html#MI_MsgBox1MessageBox_04"},
     {"title": "uMi_ui_mi_msgbox_dm.TMi_ui_mi_msgBox.MI_MsgBox1MessageBox_05", "text": "     O evento MI_MsgBox1MessageBox_05 é executado pelo método TMI_MsgBox.MessageBox(aTitle : AnsiString; Msg: AnsiString; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; ButtonDefault: TMsgDlgBtn)       ", "tags": "", "url": "uMi_ui_mi_msgbox_dm.TMi_ui_mi_msgBox.html#MI_MsgBox1MessageBox_05"},
     {"title": "uMi_ui_mi_msgbox_dm.TMi_ui_mi_msgBox.MI_MsgBox1MessageBox_ListBoxRec_PSItem", "text": "     O evento MI_MsgBox1MessageBox_ListBoxRec_PSItem é executado pelo método TMI_MsgBox.MessageBox(aTitle : AnsiString; Msg: AnsiString; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; ButtonDefault: TMsgDlgBtn)       ", "tags": "", "url": "uMi_ui_mi_msgbox_dm.TMi_ui_mi_msgBox.html#MI_MsgBox1MessageBox_ListBoxRec_PSItem"},
     {"title": "uMi_ui_mi_msgbox_dm.get_MI_MsgBox", "text": "    ", "tags": "", "url": "uMi_ui_mi_msgbox_dm.html#get_MI_MsgBox"},
     {"title": "uMi_ui_mi_msgbox_dm.Mi_ui_mi_msgBox", "text": "   ", "tags": "", "url": "uMi_ui_mi_msgbox_dm.html#Mi_ui_mi_msgBox"},
     {"title": "Unit1", "text": "A unit Unit1 é usado para demonstração do uso da unit da mi_ui_mi_msgbox_dm.       NOTAS      A unit mi_ui_mi_msgbox_dm não precisa ser inicializada no projeto principal porque a mesma auto se cria caso ela seja declarada no projeto principal.   Os dialogos da LCL são executados indiretamente pela classe TMI_MsgBox.      Motivo:      A classe TMI_MsgBox pode ser usada em todos os tipos de aplicação, inclusive javascript, pelo menos essa é a ideia.         O projeto mi.rtl.tests tem um exemplo completo de todas as funcionalidades do pacote mi.rtl         ", "tags": "", "url": "Unit1.html"},
     {"title": "Unit1.TForm1", "text": "O form TForm1 demonstra o uso do método TObjectss.InputPassword()   ", "tags": "", "url": "Unit1.TForm1.html"},
     {"title": "Unit1.TForm1.Button1", "text": "   ", "tags": "", "url": "Unit1.TForm1.html#Button1"},
     {"title": "Unit1.TForm1.Button1Click", "text": "    ", "tags": "", "url": "Unit1.TForm1.html#Button1Click"},
     {"title": "Unit1.Form1", "text": "   ", "tags": "", "url": "Unit1.html#Form1"}
]};