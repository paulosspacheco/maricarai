unit mi.rtl.web.module;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs,
  httpdefs, fpHTTP, fpWeb, DB,fpJson
  ,mi.rtl.webmodule.base, mi_rtl_ui_Dmxscroller;

type

  { Tmi_rtl_web_module }

  Tmi_rtl_web_module = class(TMi_rtl_WebModule_base)
    procedure DataModuleCreate(Sender: TObject);
    procedure DmxScroller_Form1CalcFields(const aUiDmxScroller: TUiDmxScroller);
    procedure DmxScroller_Form1ChangeField(aField: pDmxFieldRec);
    procedure DmxScroller_Form1EnterField(aField: pDmxFieldRec);
    procedure DmxScroller_Form1ExitField(aField: pDmxFieldRec);
    function DmxScroller_Form1GetTemplate(aNext: PSItem): PSItem;
  private

  public

  end;

//var
//  mi_rtl_web_module: Tmi_rtl_web_module;

implementation

{$R *.lfm}

{ Tmi_rtl_web_module }

procedure Tmi_rtl_web_module.DataModuleCreate(Sender: TObject);
begin
  inherited;
  if Not Assigned(DmxScroller_Form1.Mi_ActionList)
  then DmxScroller_Form1.Mi_ActionList := ActionList1;
  DmxScroller_Form1.Active:=true;

  writeLn('Tmi_rtl_web_module.DataModuleCreate: ',TimeToStr(time));
  Flush(output);
end;

procedure Tmi_rtl_web_module.DmxScroller_Form1EnterField(aField: pDmxFieldRec);
begin

end;

procedure Tmi_rtl_web_module.DmxScroller_Form1ExitField(aField: pDmxFieldRec);
begin

end;

procedure Tmi_rtl_web_module.DmxScroller_Form1CalcFields(const aUiDmxScroller: TUiDmxScroller);
begin

end;

procedure Tmi_rtl_web_module.DmxScroller_Form1ChangeField(aField: pDmxFieldRec);
begin

end;



function Tmi_rtl_web_module.DmxScroller_Form1GetTemplate(aNext: PSItem): PSItem;
begin
  with DmxScroller_Form1 do
  begin
    Result :=
    NewSItem(GetTemplate_CRUD_Buttons(CmNewRecord,CmUpdateRecord,'CmLocate',CmDeleteRecord,CmCancel),
    NewSItem(GetTemplate_DbNavigator_Buttons(CmGoBof,CmNextRecord,CmPrevRecord,CmGoEof,CmRefresh),
    NewSItem('~~',
    NewSItem('~ID:            ~\LLLLLL'+chFN+'id'+CharAccReadOnly+CharPfInKeyPrimary+CharPfInKeyPrimaryAutoIncrement,//+CharAccSkip,
    NewSItem('~Nome:          ~\ssssssssssssssssssssssssssssssssssssssssssssssssss'+chFN+'nome'+ChDf+'Nome?'+CharHint+'Campo alfanumérico aceita maiuscula e minuscula',
    NewSItem('~endereco       ~\ssssssssssssssssssssssssssssssssssssssssssssssssss'+chFN+'endereco',
    NewSItem('~cnpj           ~\##.###.###/####-##'+chFN+'cnpj',
    NewSItem('~cpf            ~\###.###.###-##'+chFN+'cpf',
    NewSItem('~cep            ~\##.###-###'+chFN+'cep',
    NewSItem('~valor_SMALLINT ~\IIIII'+chFN+'valor_SMALLINT',
    NewSItem('~valor_Integer  ~\LLL.LLL'+chFN+'valor_Integer',//Maximo:2.147.483.647
    NewSItem('~valor_FLOAT8   ~\RRR,RRR,RRR.RR'+chFN+'valor_FLOAT8',
    NewSItem('~TESTE DE DATAS E HORAS~',
    NewSItem('~ ~',
    NewSItem('~ Data: dia/mes/ano ~',
    NewSItem('~  dd/mm/yy         ~\Ddd/mm/yy'+chFN+'dd_mm_yy',
    NewSItem('~  dd/mm/yyyy       ~\Ddd/mm/yyyy'+chFN+'dd_mm_yyyy',
    NewSItem('~ ~',
    NewSItem('~ Horas: Hora:Minutos:Segundos ~',
    NewSItem('~  hh:nn:ss         ~\Dhh:nn:ss'+chFN+'hh_nn_ss',
    NewSItem('~  hh:nn            ~\Dhh:nn'+chFN+'hh_nn'+ChH+'Campo hora e minutos',
    NewSItem('~ ~',
    NewSItem('~ Data e Horas: dia/mes/ano hora:minutos:segundos~',
    NewSItem('~    dd/mm/yy hh:nn:ss:   ~\Ddd/mm/yy hh:nn:ss'+chFN  +'dd_mm_yy_hh_nn_ss',
    NewSItem('~    dd/mm/yyyy hh:nn:ss: ~\Ddd/mm/yyyy hh:nn:ss'+chFN+'dd_mm_yyyy_hh_nn_ss',
    NewSItem('',
    NewSItem('~ Data e Horas: dia/mes/ano hora:minutos~',
    NewSItem('~    dd/mm/yy hh:nn:      ~\Ddd/mm/yy hh:nn'+chFN+'dd_mm_yy_hh_nn',
    NewSItem('~    dd/mm/yyyy hh:nn:    ~\Ddd/mm/yyyy hh:nn'+chFN+'dd_mm_yyyy_hh_nn',
    NewSItem('',
    NewSItem(GetTemplate_CRUD_Buttons(CmNewRecord,CmUpdateRecord,'',CmDeleteRecord,CmCancel),
    NewSItem(GetTemplate_DbNavigator_Buttons(CmGoBof,CmNextRecord,CmPrevRecord,CmGoEof,CmRefresh),
    NewSItem('',
    aNext)))))))))))))))))))))))))))))))));
  end;

end;




initialization
  RegisterHTTPModule('Tmi_rtl_web_module', Tmi_rtl_web_module);

end.

