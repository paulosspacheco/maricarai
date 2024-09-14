unit uCustomDataMudule;
{:< A unit **@name** implementa a classe TCustomDataMudule usada como base para
  acesso a tabela do banco de dados que o componente TsqlDb implementa.
}
{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils,uMiDataModule,mi_rtl_ui_dmxscroller_form;

type

  { TCustomDataMudule }
  {: A classe **@name** herdada de TMiDataModule deve ser usado quando se quer
     acessar uma tabela no banco de dados e a mesma deve ser usada como modelo
     de novos modulos de dados que  acessem ao banco de dados.

     - **NOTAS**
       - Propriedade disponíveis:
         - Active
           - Ao setar a propriedade active para true a mesma cria uma conexão com
             o banco de dados e cria uma consulta select * from DmxScroller_Form1.TableName
           - Caso active seja false o sistema fecha a conexão com a tabela.

         - Caso a propriedade active seja true então as propriedades abaixo estão
           ativadas:
           - Mi_SQLQuery1.Active;
           - DmxScroller_Form1.Active
  }
  TCustomDataMudule = class(TMiDataModule)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);

  private

  public

  end;

var
  CustomDataMudule: TCustomDataMudule;

implementation

{$R *.lfm}

{ TCustomDataMudule }

procedure TCustomDataMudule.DataModuleCreate(Sender: TObject);
begin
  Inherited;
end;

procedure TCustomDataMudule.DataModuleDestroy(Sender: TObject);
begin
  inherited;
end;


end.

