unit dm_unit2;
{:< A unit **@name** contém um  datamodule para acessar um banco de dados definido
    na propriedade **TDataModule1.SQLConnector1.ConnectorType**

- **Versão atual - main**

  - Data em que esta versão foi criada: 11/01/2024
  - Versão atual: 0.0.1
  - Versão do Free Pascal: 3.2.2
  - Versão do Lazarus: Lazarus_fixe-3.0

- **Descrição das tarefas a fazer - dm_unit2**

- **11/01/2024**  a  **11/01/2024**
  - [x] Criar unit dm_unit2.pas
  - [x] Documentar projeto

}

{$mode Delphi}

interface

uses
  Classes, SysUtils, SQLDB, DB, dm_unit1
  , mi_rtl_ui_dmxscroller_form
  , mi_rtl_ui_Dmxscroller;

type

  { TDataModule2 }
  {: A unit **@name** é usado como modelo de datamodule para acessar uma tabela
     do banco de dados definido na propriedade **TDataModule1.SQLConnector1.ConnectorType**

     - O nome da tabela deve ser definida na propriedade **TDataModule2.SQLQuery1.SQL**
       da seguinte forma:

       ```pascal

          select * from nome_da_tabela2

       ```
  }
  TDataModule2 = class(TDataModule)

    {: A classe **@name** é usado para desenhar um  formulário genérico que será
       usado por formulários LCL, HTML, app para celular etc...}
    DmxScroller_Form1: TDmxScroller_Form;

    {: A classe **@name** usada para acessar uma tabela no banco de dados onde
       a mesma é  definida na propriedade **SQLQuery1.SQL** usando o comando
       select:

       ```pascal

          select * from nome_da_tabela2

       ```
    }
    SQLQuery1: TSQLQuery;

    {: A classe **@name** usada para realizar operaçõe de CRUD na tabela através
       da propriedade **DataSource1.DataSet** }
    DataSource1: TDataSource;

    procedure DmxScroller_Form1AddTemplate(const aUiDmxScroller: TUiDmxScroller
      );
  private

  public

  end;

var
  DataModule2: TDataModule2;

implementation

{$R *.lfm}

{ TDataModule2 }

procedure TDataModule2.DmxScroller_Form1AddTemplate(
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

