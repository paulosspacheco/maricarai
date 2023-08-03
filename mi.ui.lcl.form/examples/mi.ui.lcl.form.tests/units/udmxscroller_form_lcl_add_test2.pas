unit uDmxScroller_Form_Lcl_add_test2;

{$mode Delphi}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ButtonPanel,
  uMi_ui_scrollbox_lcl, uMi_ui_DmxScroller_Form_Lcl, mi_rtl_ui_Dmxscroller;

type

  { TDmxScroller_Form_Lcl_add_test2 }

  TDmxScroller_Form_Lcl_add_test2 = class(TForm)
    ButtonPanel1: TButtonPanel;
    DmxScroller_Form_Lcl1: TDmxScroller_Form_Lcl;
    Mi_ScrollBox_LCL1: TMi_ScrollBox_LCL;

    function DmxScroller_Form_Lcl1GetTemplate(aNext: PSItem): PSItem;
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  DmxScroller_Form_Lcl_add_test2: TDmxScroller_Form_Lcl_add_test2;

implementation

{$R *.lfm}

{ TDmxScroller_Form_Lcl_add_test2 }

function TDmxScroller_Form_Lcl_add_test2.DmxScroller_Form_Lcl1GetTemplate(aNext: PSItem): PSItem;
begin
  with DmxScroller_Form_Lcl1 do
  begin
    //AlignmentLabels:= taRightJustify;//taCenter;//taLeftJustify;
    AlignmentLabels:= taLeftJustify;//taRightJustify;taCenter;
    //AlignmentLabels:= taCenter; //taLeftJustify;taRightJustify;
    result :=
//      NewSItem('~     enumerado:~\'
        NewSItem('~012345678901234~\',
        NewSItem('~Enumerado      ~\'
          + CreateEnumField(TRUE, accNormal, 1,
                  NewSItem('item 00',
                  NewSItem('Item 01',
                          nil)))+ChFN+'Campo01'+ChH+'Campo Longint com as opções na lista supensa.',
        NewSItem('~Vencimento     ~\Ssssss'+ChFN+'Vencimento'+CreateOptions(1,NewSItem('Dia 10',
                                                               NewSItem('Dia 15',
                                                               NewSItem('Dia 20',
                                                               NewSItem('Dia 25',
                                                               nil)))))+
                              ChH+'Campo string com 6 posições com as opções na lista suspensa.',
        NewSItem('~Prazo          ~\BB'+ChFN+'Dias'+CreateOptions(2,NewSItem('30',
                                                     NewSItem('60',
                                                     NewSItem('90',
                                                     NewSItem('120',
                                                     nil)))))+
                           ChH+'Campo do tipo byte 2 caracteres numerico criado com função CreateOptions',
        NewSItem('~Nome do aluno  ~',
        NewSItem('~~\sssssssssssssssssssssssssssss'+ChFN+'NomeAluno'+ChH+'Nome do aluno ',
        nil))))));

  end;

  //add('~EXEMPLO DE TEMPLATE~');
  //add('');
  //add('~ Teste do campo~');
  //add();
  //
  //add();
  //
  //add();
  //add('');
end;



procedure TDmxScroller_Form_Lcl_add_test2.FormCreate(Sender: TObject);
begin
  DmxScroller_Form_Lcl1.ParentLCL := Mi_ScrollBox_LCL1;
  DmxScroller_Form_Lcl1.Active:= true;
  writeLn(Mi_ScrollBox_LCL1.WidthChar);
end;

end.

