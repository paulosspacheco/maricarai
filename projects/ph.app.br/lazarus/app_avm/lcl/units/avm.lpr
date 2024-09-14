{$IFDEF FPC}
{$MESSAGEBOX MyMessageBox}
{$ENDIF}

program avm;
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

  - Data em que esta versão foi criada: 06/03/2024
  - Versão atual: 0.0.1
  - Versão do Free Pascal: 3.2.2
  - Versão do Lazarus: Lazarus_fixe-3.0

- **Descrição das tarefas a fazer em @name**

- **01/03/2024**  a  **06/03/2024**
  - [] Criar projeto @name**
  - [] Documentar projeto
}


  {$mode Delphi}{$H+}

  uses
    {$IFDEF UNIX}
    cthreads,
    {$ENDIF}
    {$IFDEF HASAMIGA}
    athreads,
    {$ENDIF}
    Interfaces, anchordockpkg // this includes the LCL widgetset
    ,sysutils
    //,forms
    ,umi_lcl_application
    , mi.rtl.all
    , udm_connections
    , udm_table
    ,uoperadores
    ,uform_default
    ,uformdock
    , uform_main, uform_operadores;

begin

  //RequireDerivedFormResource:=True;
  SetRequireDerivedFormResource(True);
  Application.Scaled:=True;
  Application.Initialize;
//  TMi_rtl.ShowMessage('Modelo de uma aplicação maricarai configurado para gerar código para linux64, win32 e win64...');
  Application.CreateForm(Tform_main,form_main);
  Application.Run;

  //Application.CreateForm(Tdm_connections,dm_connections);
  //if Assigned(dm_connections)
  //then begin
  //       dm_connections.Connection  := true;
  //       if not dm_connections.Connection
  //       then halt // Termina a aplicação
  //       else dm_connections.Connection  := true; //Fecha a conexão com o banco de dados
  //       Application.CreateForm(Tform_main,form_main);
  //       Application.Run;
  //     end;


end.

//Tobjectss.ShowMessage('Modelo de uma aplicação maricarai configurado para gerar código para linux64, win32 e win64...');
//  Application.CreateForm(TDM_Connections, DM_Connections);
//  Application.CreateForm(Tdm_xtable, dm_xtable);
//Application.CreateForm(Tform_main, form_main);
//Application.CreateForm(Tform_default, form_default);


