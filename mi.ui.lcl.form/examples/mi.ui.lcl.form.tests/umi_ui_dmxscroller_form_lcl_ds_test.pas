unit uMi_ui_DmxScroller_Form_Lcl_ds_test;
{: A unit **@name** implementa a classe TMi_ui_DmxScroller_Form_Lcl_ds_test para demostração do
   componente TDmxScroller_Form_Lcl_DS.

   - **VERSÃO**
     - Alpha - 0.9.0

   - **CÓDIGO FONTE**:
     - @html(<a href="../units/uMi_ui_DmxScroller_Form_Lcl_ds_test.pas">uMi_ui_DmxScroller_Form_Lcl_ds_test.pas</a>)

   - **PENDÊNCIAS**
     - T12 Falta documentar a unit.
     - T12 Quando o atributo DmxScroller_Form_Lcl_DS1 é transferido para um DataModule os campos Integer,
       real, checkBox e ComboBox não funciona .


   - **EXEMPLO**
     ```pascal

     ```
}

{$mode Delphi}

interface

uses
  mi.rtl.Objects.Consts, Classes, SysUtils, DB, Forms, Controls, Graphics,
  Dialogs, StdCtrls, DBGrids, DBCtrls, uMi_ui_scrollbox_lcl,
  uMi_ui_DmxScroller_Form_Lcl_ds, uMi_ui_Dmxscroller_form_lcl,
  mi_rtl_ui_Dmxscroller, uMi_Ui_DBCheckBox_Lcl  ;

type

  { TMi_ui_DmxScroller_Form_Lcl_ds_test }
  {: A class **@name** demonstra a classe **TDmxScroller_Form_Lcl_DS** integrada aos controles
     associados a DataSource1.

     - **NOTA**
       - A class **@name** cria o dataset associado a DataSource1 caso DataSource1.DataSet seja nil.
       - Caso DataSource1.dataSet <> nil, então o mesmo precisa ter os mesmo campos passado pelo
         template.
         - Obs: Se o campos passados em DataSource1.DataSet não sejão iguais aos templates, o sistema
           vai haver execeção.
  }
  TMi_ui_DmxScroller_Form_Lcl_ds_test = class(TForm)
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    DmxScroller_Form_Lcl_DS1: TDmxScroller_Form_Lcl_DS;
    GroupBox1: TGroupBox;
    Mi_ScrollBox_LCL1: TMi_ScrollBox_LCL;
    function DmxScroller_Form_Lcl_DS1GetTemplate(aNext: PSItem): PSItem;
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Mi_ui_DmxScroller_Form_Lcl_ds_test: TMi_ui_DmxScroller_Form_Lcl_ds_test;

implementation

{$R *.lfm}

{ TMi_ui_DmxScroller_Form_Lcl_ds_test }

function TMi_ui_DmxScroller_Form_Lcl_ds_test.DmxScroller_Form_Lcl_DS1GetTemplate( aNext: PSItem): PSItem;
begin
  with DmxScroller_Form_Lcl_DS1 do
    begin
      AlignmentLabels:= taRightJustify;//taCenter;//taLeftJustify;

      Result :=
        NewSItem('',
        NewSItem('~Estado:~\SS'+ChFN+'estado'+CharPfInKeyPrimary+
                 ChH+'O campo estado é um campo string com 2 posições. Nota: Ele é o primeiro campo da chave primária.',

        NewSItem('~Cidade:~\Sssssssssssssss`sssssssssssssss'+ChFN+'cidade'+CharPfInKeyPrimary+
                 ChH+'O campo cidade é um campo string com 30 posições, mais só é visualizado 15 posições. Nota: Ele é o segundo campo da chave primária.',

        NewSItem('~   Cep:~\##.###-###'+ChFN+'cep'+
                 ChH+'Cep é um campo string com 8 posições. Nota: Só aceita números. Template = ##.###-###',

        NewSItem('~Valor.:~\RRR,RRR.RR'+ChFN+'valor'+
                 ChH+'Valor é um campo do tipo double. Nota: Só aceita números. Template = RRR,RRR.ZZ',

        NewSItem('~SmalIn:~\II,III'+ChFN+'fldSmallInt'+ChH+'Número inteiro curdo com 2 bytes Faixa:(-32768 .. 32767). Mask: III,III',

        NewSItem('~Driver:~'+ CreateEnumField(TRUE, accNormal, 0,
                               NewSItem('indefinido',
                               NewSItem('Pen driver',
                               NewSItem('SSD',
                               NewSItem('Nuvem',
                                        nil)))))+ChFN+'driver'+
                 ChH+'Driver é um tipo longint e seu valor varia entre 0 e 3. Nota: Contém o número do item da lista suspensa.' + '~Disks.~',

        NewSItem('~Venci.:~\sssssssssss'+ChFN+'Dia'+
                              CreateOptions(2,NewSItem('Dia 10',
                                              NewSItem('Dia 15',
                                              NewSItem('Dia 20',
                                              NewSItem('Dia 25 e 26',
                                            nil)))))+
                 ChH+'O campo dia, é um string com 11 posições. Nota: O número '+
                     'de caracteres do maior item da lista, não pode ter mais de 11 caracteres.' +
                 '~ dias~',
//        NewSItem('',
        NewSItem('~status ~\X '+ChFN+'status'+
                 chH+'O campo status é um campo lógico. Nota: Só permite dois valores: 0 ou 1',
//        NewSItem('',
//        NewSItem('~SEXO:~',
        NewSItem('~       ~\kA Indefinido '+chFN+'sexo',
        NewSItem('~       ~\kA Masculino   ',
        NewSItem('~       ~\kA Feminino   '+
                  chH+'O campo sexo é um do tipo byte.',
//        NewSItem('',
        aNext))))))))))));
    end;

end;

procedure TMi_ui_DmxScroller_Form_Lcl_ds_test.FormCreate(Sender: TObject);
begin
  DmxScroller_Form_Lcl_DS1.Active := true;
  writeLn(Mi_ScrollBox_LCL1.WidthChar);
end;

end.

