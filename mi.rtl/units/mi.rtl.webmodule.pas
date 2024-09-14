unit Mi.rtl.WebModule;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, ActnList, Mi_SQLQuery, mi_rtl_ui_dmxscroller_form,
  httpdefs, fpHTTP, fpWeb;

type

  { TMi_rtl_WebModule }

  TMi_rtl_WebModule = class(TFPWebModule)
    ActionList1: TActionList;
    CmCancel: TAction;
    CmDeleteRecord: TAction;
    CmGoBof: TAction;
    CmGoEof: TAction;
    CmLocate: TAction;
    CmNewRecord: TAction;
    CmNextRecord: TAction;
    CmPrevRecord: TAction;
    CmRefresh: TAction;
    CmUpdateRecord: TAction;
    DmxScroller_Form1: TDmxScroller_Form;
    Mi_SQLQuery1: TMi_SQLQuery;
    procedure CmLocateExecute(Sender: TObject);
    procedure CmNewRecordExecute(Sender: TObject);
    procedure CmUpdateRecordExecute(Sender: TObject);
  private

  public

  end;

//var
//  Mi_rtl_WebModule: TMi_rtl_WebModule;

implementation

{$R *.lfm}

//initialization
//  RegisterHTTPModule('TMi_rtl_WebModule', TMi_rtl_WebModule);

{ TMi_rtl_WebModule }

procedure TMi_rtl_WebModule.CmNewRecordExecute(Sender: TObject);
begin
  DmxScroller_Form1.DoOnNewRecord;
end;

procedure TMi_rtl_WebModule.CmUpdateRecordExecute(Sender: TObject);
begin
  DmxScroller_Form1.UpdateRec;
end;

procedure TMi_rtl_WebModule.CmLocateExecute(Sender: TObject);
begin
  if Locate() = MrNo
  Then TMi_rtl.ShowMessage('Registro não localizado!');
end;

end.

