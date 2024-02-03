program app_mi_ui_lcl_form;
{:< O projeto **@name** é usado como modelo para projetos que usam o pacote **mi_rtl_form**
    e pacote **LCL** configurado para 3 alvos, sendo **linux**, **i386-win32**,
    **x86_64-win64** e um formulário **Unit1** para demonstração do uso da unit
    **mi_ui_mi_msgbox_dm**.

- **Notas**:
  - Este projeto depende dos seguintes pacotes:
    - LCL;
    - mi.rtl
    - mi.rtl.form

- **Versão atual - @name**

  - Data em que esta versão foi criada: 11/01/2024
  - Versão atual: 0.0.1
  - Versão do Free Pascal: 3.2.2
  - Versão do Lazarus: Lazarus_fixe-3.0

- **Descrição das tarefas a fazer em @name**

- **11/01/2024**  a  **11/01/2024**
  - [x] Criar projeto @name**
  - [x] Criar unit unit1.pas
  - [x] Documentar projeto
}

{$mode Delphi}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, uMi_ui_mi_msgbox_dm, udm_connections
  ; //Formulário base para iniciar qualquer projeto

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  //Application.CreateForm(TMi_ui_mi_msgBox, Mi_ui_mi_msgBox);
  Application.CreateForm(TDM_Connections, DM_Connections);

  DM_Connections.Connection  := true;

  if DM_Connections.Connection
  then Application.Run;
end.

