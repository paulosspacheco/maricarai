unit dm_unit1;
{:< A unit **@name** contém um  datamodule para acessar um banco de dados definido
    na propriedade **TDataModule1.SQLConnector1.ConnectorType**

- **Versão atual - main**

  - Data em que esta versão foi criada: 11/01/2024
  - Versão atual: 0.0.1
  - Versão do Free Pascal: 3.2.2
  - Versão do Lazarus: Lazarus_fixe-3.0

- **Descrição das tarefas a fazer - dm_unit1**

- **11/01/2024**  a  **11/01/2024**
  - [x] Criar unit dm_unit1.pas
  - [x] Documentar projeto

}

{$mode Delphi}{$H+}

interface

uses
  Classes, SysUtils, SQLDB, DB, mi_rtl_ui_dmxscroller_form, mi_rtl_ui_Dmxscroller;

type

  { TDataModule1 }
  {: A unit **@name** é usado como modelo de datamodule para acessar um banco de dados definido 
    na propriedade **TDataModule1.SQLConnector1.ConnectorType**

  - O nome da tabela com a lista de usuários que tem acesso ao sistema
    está definida na propriedade **TDataModule1.SQLQuery1.SQL**
    da seguinte forma:

    ```pascal

       select * from nome_da_tabela1

    ```

  }
  TDataModule1 = class(TDataModule)

    {: A classe **@name** é usado para desenhar um  formulário genérico que será
       usado por formulários LCL, HTML, app para celular etc...}
    DmxScroller_Form1: TDmxScroller_Form;

    {: A classe **@name** é usada para conectar-se ao banco de dados sql }
    SQLConnector1: TSQLConnector;

    {: A classe **@name** é usada para realizar trabnsações no banco de dados sql }
    SQLTransaction1: TSQLTransaction;

    {: A classe **@name** usada para acessar uma tabela no banco de dados onde a
       mesma é definida na propriedade **SQLQuery1.SQL** usando o comando select:

       ```pascal

          select * from nome_da_tabela1

       ```
    }
    SQLQuery1: TSQLQuery;

    {: A classe **@name** usada para realizar operaçõe de CRUD na tabela através
       da propriedade **DataSource1.DataSet**
    }
    DataSource1: TDataSource;

    procedure DmxScroller_Form1AddTemplate(const aUiDmxScroller: TUiDmxScroller
      );
  private

  public

  end;

var
  DataModule1: TDataModule1;

implementation

{$R *.lfm}

{ TDataModule1 }

procedure TDataModule1.DmxScroller_Form1AddTemplate(
  const aUiDmxScroller: TUiDmxScroller);
begin
  with aUiDmxScroller do
  begin
    AlignmentLabels:= taRightJustify;//taCenter;//taLeftJustify;

    add('~IDENTIFIÇÃO~');
    add('~ E-mail:~\ssssssssssssssssssssssssss`ssssssssssssssssssssssss'+ChFN+'login'+ChH+'Informe seu e-mail');
    add('~ Senha:~\**********`****************************************'+ChFN+'login'+ChH+'Informe seu e-mail');
    add('');

  end;
end;

end.

