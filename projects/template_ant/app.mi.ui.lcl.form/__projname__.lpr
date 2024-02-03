program __projname__;
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
  Forms
  ,__unit_dm_connections__
  ,__unit_form_main__


  ; //Formulário base para iniciar qualquer projeto

{$R *.res}

// As 3 linhas abaixo foram modificada porque a propriedade recurse=1 do arquivo project.ini não funciona.
//,__Unit_dm_mi_ui_mi_msgbox__ in 'dm/__Unit_dm_mi_ui_mi_msgbox__.pas'
//,__unit_dm_connections__ in 'dm/__unit_dm_connections__.pas'
//,__Unit_Form_Main__ in 'forms/__Unit_Form_Main__.pas'

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(T__form_main__, __form_main__);
  Application.CreateForm(T__DM_Connections__, __DM_Connections__);
  Application.Run;
end.

