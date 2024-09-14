program avm_lcl;
{:< O projeto **@name** é usado como modelo para projetos que usam o pacote **mi_rtl_form**
    e pacote **LCL** configurado para 3 alvos, sendo **linux**, **i386-win32**,
    **x86_64-win64** e um formulário **Unit1** para demonstração do uso da unit
    **_Unit_dm_mi_ui_mi_msgbox_**.

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

- **11/01/2024**  a  **17/01/2024**
  - [x] Criar projeto @name**
  - [x] Criar unit dm/_Unit_dm_mi_ui_mi_msgbox_.pas
  - [x] Criar unit dm/_unit_dm_connections_.pas
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
  {: Unit implementa ao projeto MarIcarai a plataforma desktop LCL}
  uMi_ui_Application_lcl

  ,anchordockpkg
  ,umi_ui_msgbox_lcl
  ,mi.rtl.Objectss
  ,unit_dm_connections, unit_XOperadores
  ,unit_formdock
  ,unit_form_main
  , unit_ZOperadores, unit_form4

  

  ; //Formulário base para iniciar qualquer projeto

{$R *.res}

// As 3 linhas abaixo foram modificada porque a propriedade recurse=1 do arquivo project.ini não funciona.
//, in 'dm/.pas'
//,unit_dm_connections in 'dm/unit_dm_connections.pas'
//,unit_form_main in 'forms/unit_form_main.pas'

begin
  //RequireDerivedFormResource:=True;
  SetRequireDerivedFormResource(True);
  Application.Scaled:=True;
  Application.Initialize;
//  Tobjectss.ShowMessage('Modelo de uma aplicação maricarai configurado para gerar código para linux64, win32 e win64...');
  Application.CreateForm(TDM_Connections, DM_Connections);
  Application.CreateForm(TXOperadores, XOperadores);
  Application.CreateForm(Tform_main, form_main);

  Application.Run;
end.

