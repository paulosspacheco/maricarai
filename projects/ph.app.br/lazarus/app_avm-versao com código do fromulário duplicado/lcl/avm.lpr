{$IFDEF FPC}
{$MESSAGEBOX MyMessageBox}
{$ENDIF}

program avm;
{:< Este programa tem com foco criar uma agenda virtual usando as tecnologias
    desktop LCL, whatapp e chatgpt.

- **Notas**:
  - Este projeto depende dos seguintes pacotes:
    - LCL;
    - mi.rtl
    - mi.rtl.form

- **Versão atual - @name**

  - Data em que esta versão foi criada: 22/03/2024
  - Versão atual: 0.0.1
  - Versão do Free Pascal: 3.2.2
  - Versão do Lazarus: Lazarus_fixe-3.0

- **Descrição das tarefas a fazer em @name**

- **22/03/2024**  a  **22/03/2024**
  - [x] Criar projeto @name**
  - [x] Documentar projeto
  - [ ] Criado formulário uForm_Operadores;
  - [ ] Criado formulário uForm_Operadores2;
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
    ,uform_operadores
    ,uform_operadores2
    , uform_main;

begin

  //RequireDerivedFormResource:=True;
  SetRequireDerivedFormResource(True);
  Application.Scaled:=True;
  Application.Initialize;
//  TMi_rtl.ShowMessage('Modelo de uma aplicação maricarai configurado para gerar código para linux64, win32 e win64...');
  Application.CreateForm(Tdm_connections,dm_connections);
  if Assigned(dm_connections)
  then begin
         dm_connections.Connection  := true;
         if not dm_connections.Connection
         then halt // Termina a aplicação
         else dm_connections.Connection  := true; //Fecha a conexão com o banco de dados
         Application.CreateForm(Tform_main,form_main);
         Application.Run;
       end;


end.



