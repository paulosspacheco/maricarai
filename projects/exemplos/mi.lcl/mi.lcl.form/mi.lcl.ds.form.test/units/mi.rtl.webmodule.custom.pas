unit Mi.rtl.WebModule.Custom;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, fphttp, Forms, Controls, Graphics, Dialogs, ActnList,
  Mi.rtl.WebModule,
  mi_rtl_ui_dmxscroller_form, mi_rtl_ui_Dmxscroller;

type

  { TMi_rtl_WebModule_Custom }

  TMi_rtl_WebModule_Custom = class(TMi_rtl_WebModule)
    procedure DataModuleCreate(Sender: TObject);
    function DmxScroller_Form1GetTemplate(aNext: PSItem): PSItem;
  private

  public

  end;

var
  Mi_rtl_WebModule_Custom: TMi_rtl_WebModule_Custom;



implementation

{$R *.lfm}

{ TMi_rtl_WebModule_Custom }

procedure TMi_rtl_WebModule_Custom.DataModuleCreate(Sender: TObject);
begin
  inherited;
  DmxScroller_Form1.Active:=true;
end;

function TMi_rtl_WebModule_Custom.DmxScroller_Form1GetTemplate(aNext: PSItem): PSItem;
begin
  with DmxScroller_Form1 do
  begin
    Result :=
    NewSItem('',
    NewSItem(GetTemplate_CRUD_Buttons(CmNewRecord,CmUpdateRecord,'CmLocate',CmDeleteRecord,CmCancel),
    NewSItem(GetTemplate_DbNavigator_Buttons(CmGoBof,CmNextRecord,CmPrevRecord,CmGoEof,CmRefresh),
    NewSItem('',
    //NewSItem('~Status:        ~\ssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss'+CharAccSkip+chFN+'status',//+CharAccReadOnly,

     NewSItem('~ID:            ~\LLLLLL'+chFN+'id'+CharAccReadOnly+CharPfInKeyPrimary+CharPfInKeyPrimaryAutoIncrement,//+CharAccSkip,

//     NewSItem('~ID:           ~\LLLLLL'+chFN+'id'+CharPfInKeyPrimary+CharPfInKeyPrimaryAutoIncrement+CharAccSkip,

    //NewSItem('~ID_operadores:  ~'+CreateEnumField(TRUE, accNormal, 1,NewSItem('ssssssssssssssssssssss',nil),
    //                                             Mi_SQLQuery1.DataSource,'id_operadores','nome')+
    //                                             ChFN+'id_Operadores'+
    //                                             CharHint+'Campo enumero lookup',

//     NewSItem('~ID_operadores: ~\LLLLLL'+chFN+'id_operadores',
    NewSItem('~Nome:          ~\ssssssssssssssssssssssssssssssssssssssssssssssssss'+chFN+'nome'+CharHint+'Campo alfanumérico aceita maiuscula e minuscula',
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
    aNext))))))))))))))))))))))))))))))))));
  end;
end;

  //with DmxScroller_Form1 do
  //begin
  //  Result :=   NewSItem('~Data: dia/mes/ano ~',
  //              NewSItem(' ~Data_1         ~\Ddd/mm/yy'+chFN+'Data_1',
  //              NewSItem(' ~Data_2         ~\Ddd/mm/yyyy'+chFN+'Data_2',
  //              NewSItem('',
  //              NewSItem('~Data: ano/mes/dia ~',
  //              NewSItem(' ~Data_3         ~\Dyy/mm/dd'+chFN+'Data_3',
  //              NewSItem(' ~Data_4         ~\Dyyyy/mm/dd'+chFN+'Data_4',
  //              NewSItem('',
  //              NewSItem('~Horas: dia/mes/ano ~',
  //              NewSItem(' ~hora_1         ~\Dhh:nn:ss'+chFN+'hora_1',
  //              NewSItem(' ~hora_2         ~\Dhh:nn'+chFN+'hora_2'+ChH+'Campo hora e minutos',
  //              NewSItem('',
  //              NewSItem('~Data e Horas: dia/mes/ano hora:minutos:segundos~',
  //              NewSItem(' ~dd/mm/yy hh:nn:ss:   ~\Ddd/mm/yy hh:nn:ss'+chFN+'DateTime_1',
  //              NewSItem(' ~dd/mm/yyyy hh:nn:ss: ~\Ddd/mm/yyyy hh:nn:ss'+chFN+'DateTime_2',
  //              NewSItem('',
  //              NewSItem('~Data e Horas: dia/mes/ano hora:minutos~',
  //              NewSItem(' ~dd/mm/yy hh:nn:      ~\Ddd/mm/yy hh:nn'+chFN+'DateTime_3',
  //              NewSItem(' ~dd/mm/yyyy hh:nn:    ~\Ddd/mm/yyyy hh:nn'+chFN+'DateTime_4',
  //              NewSItem(''
  //                      ,aNext))))))))))))))))))));
  //end;

//end;



initialization
  RegisterHTTPModule('TMi_rtl_WebModule_Custom', TMi_rtl_WebModule_Custom);
end.

