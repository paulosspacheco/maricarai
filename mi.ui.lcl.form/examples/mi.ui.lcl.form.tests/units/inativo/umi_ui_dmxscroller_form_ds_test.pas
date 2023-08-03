unit uMi_ui_DmxScroller_Form_Lcl_DS_Test;

{$mode Delphi}

interface

uses
  Classes, SysUtils, BufDataset, DB, Forms, Controls, Graphics, Dialogs,
  DBCtrls, DBGrids, ExtCtrls, StdCtrls, MaskEdit
  ,mi_rtl_ui_Dmxscroller
  ,uMi_ui_scrollbox_lcl
  ,uMi_ui_DmxScroller_Form_Lcl_DS

  ;

type

  { TMi_ui_DmxScroller_Form_Lcl_DS_Test }

  TMi_ui_DmxScroller_Form_Lcl_DS_Test = class(TForm)

    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    DmxScroller_Form_Lcl_DS1: TDmxScroller_Form_Lcl_DS;
    GroupBox1: TGroupBox;
    Panel1: TPanel;
    mi_scrollbox_lcl1: Tmi_scrollbox_lcl;

    function DmxScroller_Form_Lcl_DS1GetTemplate(aNext: PSItem): PSItem;
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Mi_ui_DmxScroller_Form_Lcl_DS_Test: TMi_ui_DmxScroller_Form_Lcl_DS_Test;

implementation

{$R *.lfm}

{ TMi_ui_DmxScroller_Form_Lcl_DS_Test }

procedure TMi_ui_DmxScroller_Form_Lcl_DS_Test.FormCreate(Sender: TObject);
begin
//  BufDataset1.CreateDataset;
//  DmxScroller_Form_Lcl_DS1.Active := true;
end;

function TMi_ui_DmxScroller_Form_Lcl_DS_Test.DmxScroller_Form_Lcl_DS1GetTemplate(aNext: PSItem): PSItem;
begin
  with DmxScroller_Form_Lcl_DS1 do
  begin
    Result :=
      NewSItem('',
      NewSItem('~Estado:~\SS'+ChFN+'estado'+CharPfInKeyPrimary,
      NewSItem('~Cidade:~\Ssssssssssssssssssssss`sssss'+ChFN+'cidade'+CharPfInKeyPrimary,
      NewSItem('~   Cep:~\##.###-###'+ChFN+'cep',
      NewSItem('~Valor.:~\RRR,RRR.ZZ'+ChFN+'valor',
      NewSItem('~Driver:~'+ CreateEnumField(TRUE, accNormal, 0,
                             NewSItem('null',
                             NewSItem('3 1/2"',
                             NewSItem('5 1/4"',
                                      nil))))+ChFN+'driver' + '~Disks.~',
      NewSItem('~Satus.:~\X '+ChFN+'status',
      NewSItem('~SEXO:~',
      NewSItem('~~\KA Indefinido '+chFN+'sexo',
      NewSItem('~~\KA Maculino   ',
      NewSItem('~~\KA Feminino   ',
      NewSItem('',
      aNext))))))))))));
  end;

end;






end.

