unit udm_xtable;

{$mode Delphi}

interface

uses
  Classes, SysUtils, ActnList, DB, SQLDB  
  ,mi.rtl.all  
  ,mi_rtl_ui_Dmxscroller  
  ,mi_rtl_ui_dmxscroller_form
  ,udm_connections
  ,udm_table
  ;

type

  { Tdm_xtable }

  Tdm_xtable = class(Tdm_table)
      function DmxScroller_Form1AfterDelete(const aUiDmxScroller: TUiDmxScroller): boolean;
      function DmxScroller_Form1BeforeDelete( const aUiDmxScroller: TUiDmxScroller): boolean;
      procedure DmxScroller_Form1CalcField(aField: pDmxFieldRec);
      procedure DmxScroller_Form1CalcFields(const aUiDmxScroller: TUiDmxScroller        );
      function DmxScroller_Form1GetTemplate(aNext: PSItem): PSItem;

    private

    public
      //class procedure test_key_duplicate;
      //class procedure test2_key_duplicate;
  end;


implementation

{$R *.lfm}

{ Tdm_xtable }

//function Tdm_xtable.DmxScroller_Form1AfterInsert(
//  const aUiDmxScroller: TUiDmxScroller): boolean;
//begin
//  //result := false;
//  result := true;
//  //TMi_rtl.ShowMessage('Evento DmxScroller_Form1AfterInsert');
//end;

//function Tdm_xtable.DmxScroller_Form1BeforeInsert( const aUiDmxScroller: TUiDmxScroller): boolean;
//begin
//  result := true;
//  //TMi_rtl.ShowMessage('Evento DmxScroller_Form1BeforeInsert');
//end;

function Tdm_xtable.DmxScroller_Form1AfterDelete(
  const aUiDmxScroller: TUiDmxScroller): boolean;
begin
    result := true;
end;

function Tdm_xtable.DmxScroller_Form1BeforeDelete(
  const aUiDmxScroller: TUiDmxScroller): boolean;
begin
  result := true;
end;

procedure Tdm_xtable.DmxScroller_Form1CalcField(aField: pDmxFieldRec);
begin
  if CompareText('status',aField.FieldName)=0
  Then aField.AsString := aField.owner_UiDmxScroller.GetDataSet_Status;
end;

procedure Tdm_xtable.DmxScroller_Form1CalcFields( const aUiDmxScroller: TUiDmxScroller);
  var
    f : pDmxFieldRec;
begin
  f := aUiDmxScroller.FieldByName('status');
  if Assigned(f)
  Then f.AsString := aUiDmxScroller.GetDataSet_Status;
end;


function Tdm_xtable.DmxScroller_Form1GetTemplate(aNext: PSItem): PSItem;
begin
   with DmxScroller_Form1 do
   begin
     Result :=
     NewSItem('',
     NewSItem(GetTemplate_CRUD_Buttons(CmNewRecord,CmUpdateRecord,'CmLocate',CmDeleteRecord,CmCancel),
     NewSItem(GetTemplate_DbNavigator_Buttons(CmGoBof,CmNextRecord,CmPrevRecord,CmGoEof,CmRefresh),
     NewSItem('',
     //NewSItem('~Status:        ~\ssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss'+CharAccSkip+chFN+'status',//+CharAccReadOnly,

      //NewSItem('~ID:            ~\LLLLLL'+chFN+'id'+CharAccReadOnly+CharPfInKeyPrimary+CharPfInKeyPrimaryAutoIncrement,
      NewSItem('~ID:            ~\LLLLLL'+chFN+'id'+CharPfInKeyPrimary+CharPfInKeyPrimaryAutoIncrement+CharAccSkip,
     //NewSItem('~ID:            ~\LLLLLL'+chFN+'id',
     //NewSItem('~ID:            ~'+CreateEnumField(TRUE, accNormal, 10000,NewSItem('ssssssssssssssssssssssssssssssssssssssssssssssssss',nil),
     //                                             Mi_SQLQuery1.DataSource,'id','nome')+
     //                                             ChFN+'id'+
     //                                             CharHint+'Campo enumero lookup',

     NewSItem('~Nome:          ~\ssssssssssssssssssssssssssssssssssssssssssssssssss'+chFN+'nome'+CharHint+'Campo alfanumérico aceita maiuscula e minuscula',
     NewSItem('~endereco       ~\ssssssssssssssssssssssssssssssssssssssssssssssssss'+chFN+'endereco',
     NewSItem('~cnpj           ~\##.###.###/####-##'+chFN+'cnpj',
     NewSItem('~cpf            ~\###.###.###-##'+chFN+'cpf',
     NewSItem('~cep            ~\##.###-###'+chFN+'cep',
     NewSItem('~valor_SMALLINT ~\IIIII'+chFN+'valor_SMALLINT',
     NewSItem('~valor_Integer  ~\LLL.LLL'+chFN+'valor_Integer',//Maximo:2.147.483.647

     NewSItem('~valor_FLOAT8   ~\RRR,RRR,RRR.RR'+chFN+'valor_FLOAT8',
     NewSItem('~Data_1         ~\Ddd/mm/yyyy'+chFN+'Data_1',
     NewSItem('~Data_2         ~\Ddd/mm/yyyy'+chFN+'Data_2',
     NewSItem('~hora_1         ~\Dhh:nn:ss'+chFN+'hora_1',
     NewSItem('~hora_2         ~\Dhh:nn'+chFN+'hora_2',
     NewSItem('',
     NewSItem(GetTemplate_CRUD_Buttons(CmNewRecord,CmUpdateRecord,'',CmDeleteRecord,CmCancel),
     NewSItem(GetTemplate_DbNavigator_Buttons(CmGoBof,CmNextRecord,CmPrevRecord,CmGoEof,CmRefresh),
     NewSItem('',
     aNext)))))))))))))))))))));

   end;
end;


end.


//function Tdm_xtable.DmxScroller_Form1GetTemplate(aNext: PSItem): PSItem;
//begin
//   with DmxScroller_Form1 do
//   begin
//     Result :=
//     NewSItem(GetTemplate_CRUD_Buttons(CmNewRecord,CmUpdateRecord,CmLocate,CmDeleteRecord),
//     NewSItem('',
//     NewSItem('~Data_1         ~\Ddd/mm/yy'+chFN+'Data_1',
//     //NewSItem('~Data_2         ~\Ddd/mm/yyyy'+chFN+'Data_2',
//     //NewSItem('~hora_1         ~\Dhh:nn:ss'+chFN+'hora_1',
//     //NewSItem('~hora_2         ~\Dhh:nn'+chFN+'hora_2',
//     NewSItem('',
//     NewSItem(GetTemplate_DbNavigator_Buttons(CmGoBof,CmNextRecord,CmPrevRecord,CmGoEof,CmRefresh),
//     NewSItem('',
//     aNext))))));
//
//   end;
//end;

//class procedure Tdm_xtable.test_key_duplicate;
//  var
//    dm_xtable : Tdm_xtable;
//
//begin
//  try
//    dm_xtable := Tdm_xtable.Create(nil);
//    dm_xtable.active:=true;
//    dm_xtable.DmxScroller_Form1.Active :=  true;
//
//    if dm_xtable.DmxScroller_Form1.Active
//    then with dm_xtable do
//         begin
//            with DmxScroller_Form1 do
//            begin
//              DoOnNewRecord;
//              FieldByName('id').AsString:='1';
//              FieldByName('nome').AsString:='Roberto Hugo';
//              if not AddRec
//              Then begin
//                     Appending:=false;
//                     DoOnNewRecord;
//                     FieldByName('id').AsString:='3';
//                     FieldByName('nome').AsString:='Roberto Hugo';
//                     if AddRec
//                     then begin
//                             FirstRec;
//                             ShowMessage('Primeiro ID:'+FieldByName('id').AsString);
//                           end;
//
//                   end;
//            end;
//
//         end;
//
//  finally
//    freeandnil(dm_xtable);
//  end;
//end;
//
//class procedure Tdm_xtable.test2_key_duplicate;
//  var
//    dm_xtable : Tdm_xtable;
//
//begin
//  try
//    dm_xtable := Tdm_xtable.Create(nil);
//    dm_xtable.active:=true;
//    dm_xtable.DmxScroller_Form1.Active :=  true;
//
//    if dm_xtable.DmxScroller_Form1.Active
//    then with dm_xtable do
//         begin
//            with DmxScroller_Form1 do
//            begin
//              DoOnNewRecord;
//              FieldByName('id').AsString:='1';
//              FieldByName('nome').AsString:='Roberto Hugo';
//              if not AddRec
//              Then begin
//                     Appending:=false;
//                     DoOnNewRecord;
//                     FieldByName('id').AsString:='3';
//                     FieldByName('nome').AsString:='Roberto Hugo';
//                     if AddRec
//                     then begin
//                             FirstRec;
//                             ShowMessage('Primeiro ID:'+FieldByName('id').AsString);
//                           end;
//
//                   end;
//            end;
//
//         end;
//
//  finally
//    freeandnil(dm_xtable);
//  end;
//end;

//procedure Tdm_xtable.DmxScroller_Form1AddTemplate(const aUiDmxScroller: TUiDmxScroller);
//begin
//  with aUiDmxScroller do
//  begin
//    add(GetTemplate_CRUD_Buttons(CmNewRecord,CmUpdateRecord,CmLocate,CmDeleteRecord));
//    add('');
//    //Add('"Status:        "\ssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss'+{CharAccSkip+}chFN+'status');
////    Add('"ID:            "\LLLLLL'+chFN+'id');
//    Add('"ID:            "'+CreateEnumField(TRUE, accSkip, 1,NewSItem('ssssssssssssssssssssssssssssssssssssssssssssssssss',nil),
//                                            Mi_SQLQuery1.DataSource,'id','nome')+
//                            ChFN+'id'+
//                            CharHint+
//                            'Campo enumero lookup');
//
//    Add('"Nome:          "\ssssssssssssssssssssssssssssssssssssssssssssssssss'+chFN+'nome');
//    Add('"endereco       "\ssssssssssssssssssssssssssssssssssssssssssssssssss'+chFN+'endereco');
//    Add('"cnpj           "\##.###.###/####-##'+chFN+'cnpj');
//    Add('"cpf            "\###.###.###-##'+chFN+'cpf');
//    Add('"cep            "\##.###-###'+chFN+'cep');
//    Add('"valor_SMALLINT "\IIIII'+chFN+'valor_SMALLINT');
//    Add('"valor_Integer  "\LLLLLLLLLL'+chFN+'valor_Integer');//Maximo:2.147.483.647
//
//    Add('"valor_FLOAT8   "\RRR,RRR.ZZ'+chFN+'valor_FLOAT8');
//    Add('"Data_1         "\Ddd/mm/yy'+chFN+'Data_1');
//    Add('"hora_1         "\Dhh:nn:ss'+chFN+'hora_1');
//    Add('"hora_2         "\Dhh:nn'+chFN+'hora_2');
//    add('');
//    add(GetTemplate_DbNavigator_Buttons(CmGoBof,CmNextRecord,CmPrevRecord,CmGoEof,CmRefresh));
//    add('');
//
//  end;
//end;





