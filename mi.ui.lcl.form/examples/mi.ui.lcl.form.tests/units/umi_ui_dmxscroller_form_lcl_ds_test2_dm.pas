unit uMi_ui_DmxScroller_Form_Lcl_ds_test2_dm;

{$mode Delphi}

interface

uses
  Classes, SysUtils, ActnList, DB, uMi_ui_DmxScroller_Form_Lcl_ds,
  uMi_ui_DmxScroller_Form_Lcl, mi_rtl_ui_Dmxscroller;

type

  { TMi_ui_DmxScroller_Form_Lcl_ds_test2_dm }

  TMi_ui_DmxScroller_Form_Lcl_ds_test2_dm = class(TDataModule)
    GoBof: TAction;
    Next: TAction;
    Prev: TAction;
    GoEof: TAction;

    ActionList1: TActionList;
    DataSource1: TDataSource;
    DmxScroller_Form_Lcl_DS1: TDmxScroller_Form_Lcl_DS;
    Excluir: TAction;
    Gravar: TAction;
    Novo: TAction;
    Pesquisar: TAction;
    procedure DataModuleCreate(Sender: TObject);
    procedure GoBofExecute(Sender: TObject);
    procedure DmxScroller_Form_Lcl_DS1AddTemplate(
      const aUiDmxScroller: TUiDmxScroller);
    procedure ExcluirExecute(Sender: TObject);
    procedure GoEofExecute(Sender: TObject);
    procedure GravarExecute(Sender: TObject);
    procedure NextExecute(Sender: TObject);
    procedure NovoExecute(Sender: TObject);
    procedure PesquisarExecute(Sender: TObject);
    procedure PrevExecute(Sender: TObject);


  private

  public

  end;

  var
    Mi_ui_DmxScroller_Form_Lcl_ds_test2_dm: TMi_ui_DmxScroller_Form_Lcl_ds_test2_dm;

implementation

{$R *.lfm}

{ TMi_ui_DmxScroller_Form_Lcl_ds_test2_dm }

  procedure TMi_ui_DmxScroller_Form_Lcl_ds_test2_dm.DmxScroller_Form_Lcl_DS1AddTemplate(const aUiDmxScroller: TUiDmxScroller);
  {:< O método add está com problema nos campos combobox e integer}
  begin
    with DmxScroller_Form_Lcl_DS1 do
      begin
        AlignmentLabels:= taRightJustify;
        //AlignmentLabels:= taLeftJustify;
        //AlignmentLabels:= taCenter;
        add('~    ~'+
                 '~🔲 &Novo~'+ChH+'Executa DoOnNewRecord'+ChEA+Novo.Name+
                 '~✔  Gravar~'+ChEA+Gravar.Name+
                 '~🔍 &Pesquisar~'+ChEA+Pesquisar.Name+
                 '~❌ Excluir~'+ChEA+Excluir.Name);
        add('');
        add('');
        add('~Estado:~\SS'+ChFN+'estado'+CharPfInKeyPrimary+
                 ChH+'O campo estado é um campo string com 2 posições. Nota: Ele é o primeiro campo da chave primária.');

        add('~Cidade:~\Sssssssssssssss`sssssssssssssss'+ChFN+'cidade'+CharPfInKeyPrimary+
                 ChH+'O campo cidade é um campo string com 30 posições); mais só é visualizado 15 posições. Nota: Ele é o segundo campo da chave primária.');

        add('~   Cep:~\##.###-###'+ChFN+'cep'+
                 ChH+'Cep é um campo string com 8 posições. Nota: Só aceita números. Template = ##.###-###');

        add('~Valor.:~\RRR,RRR.RR'+ChFN+'valor'+
                 ChH+'Valor é um campo do tipo double. Nota: Só aceita números. Template = RRR);RRR.ZZ');

        add('~SmalIn:~\II,III'+ChFN+'fldSmallInt'+ChH+'Número inteiro curdo com 2 bytes Faixa:(-32768 .. 32767). Mask: III);III');

        add('~Driver:~'+ CreateEnumField(TRUE,accNormal, 0,
                               NewSItem('indefinido',
                               NewSItem('Pen driver',
                               NewSItem('SSD',
                               NewSItem('Nuvem',
                                        nil)))))+ChFN+'driver'+
                 ChH+'Driver é um tipo longint e seu valor varia entre 0 e 3. Nota: Contém o número do item da lista suspensa.' + '~Disks.~');

        add('~Venci.:~\sssssssssss'+ChFN+'Dia'+
                              CreateOptions(2,NewSItem('Dia 10',
                                              NewSItem('Dia 15',
                                              NewSItem('Dia 20',
                                              NewSItem('Dia 25 e 26',
                                            nil)))))+
                 ChH+'O campo dia); é um string com 11 posições. Nota: O número '+
                     'de caracteres do maior item da lista); não pode ter mais de 11 caracteres.' +
                 '~ dias~');
        add('');
        add('~Status:~\X '+ChFN+'status'+
                 chH+'O campo status é um campo lógico. Nota: Só permite dois valores: 0 ou 1.');
        add('');
        add('~SEXO:~');
        add('~       ~\kA Indefinido '+chFN+'sexo');
        add('~       ~\kA Masculino   ');
        add('~       ~\kA Feminino   '+
                  chH+'O campo sexo é um do tipo byte.');
        add('');
        add('');
        add('~    ~'
            +'~⏭️ &Primeiro~'+ChEA+GoBof.Name
            +'~⏩ P&róximo ~'+ChEA+Next.Name
            +'~⏪️&Anterior~'+ChEA+Prev.Name
            +'~⏮️ &Ultimo  ~'+ChEA+GoEof.Name);
        add('');
      end;
  end;

  procedure TMi_ui_DmxScroller_Form_Lcl_ds_test2_dm.DataModuleCreate(Sender: TObject);
  begin
    Novo.Enabled:= true;
    Gravar.Enabled:= False;
    Pesquisar.Enabled:= True;
    Excluir.Enabled:=False;

    GoBof.Enabled:= DataSource1.Enabled;
    Next.Enabled:= DataSource1.Enabled;
    prev.Enabled:= DataSource1.Enabled;
    GoBof.Enabled:= DataSource1.Enabled;
    DataSource1.AutoEdit:=true;

  end;

procedure TMi_ui_DmxScroller_Form_Lcl_ds_test2_dm.NovoExecute(Sender: TObject);
begin
  with DmxScroller_Form_Lcl_DS1 do
  begin
    if (DataSource<>nil) and (DataSource.State in [dsBrowse]) then
    begin
      //MessageBox('Novo');
      DataSource.DataSet.Append;
      Novo.Enabled:= False;
      Gravar.Enabled:= true;
      Pesquisar.Enabled:= False;
      Excluir.Enabled:=False;
    end;
  end;

end;

procedure TMi_ui_DmxScroller_Form_Lcl_ds_test2_dm.PesquisarExecute(Sender: TObject);
begin
  with DmxScroller_Form_Lcl_DS1 do
  begin
    if (DataSource<>nil) and (DataSource.State<>dsInactive) then
    begin
//    MessageBox('Pesquisar');
      DataSource.Edit;
    end;
  end;
end;


procedure TMi_ui_DmxScroller_Form_Lcl_ds_test2_dm.GravarExecute(Sender: TObject);
begin
  with DmxScroller_Form_Lcl_DS1 do
  begin
//    MessageBox('Gravar');
    if (DataSource<>nil) and (DataSource.State<>dsInactive) then
    begin
      DataSource.DataSet.Post;
      Novo.Enabled:= true;
      Gravar.Enabled:= False;
      Pesquisar.Enabled:= True;
      Excluir.Enabled:=true;
    end;
  end;
end;

procedure TMi_ui_DmxScroller_Form_Lcl_ds_test2_dm.ExcluirExecute(Sender: TObject);
begin
  with DmxScroller_Form_Lcl_DS1 do
  begin
    if (DataSource<>nil) and (DataSource.State in [dsBrowse]) then
    begin
//    MessageBox('Excluir');
      DataSource.DataSet.Delete;
      Novo.Enabled:= true;
      Gravar.Enabled:= False;
      Pesquisar.Enabled:= True;
      Excluir.Enabled:=False;
    end;
  end;
end;

procedure TMi_ui_DmxScroller_Form_Lcl_ds_test2_dm.GoBofExecute(Sender: TObject);
begin
  with DmxScroller_Form_Lcl_DS1 do
  begin
    if (DataSource<>nil) and (DataSource.State<>dsInactive) then
    begin
      //MessageBox('GoBof');
      DataSource.DataSet.First;
    end;
  end;
end;

procedure TMi_ui_DmxScroller_Form_Lcl_ds_test2_dm.NextExecute(Sender: TObject);
begin
  with DmxScroller_Form_Lcl_DS1 do
  begin
    if (DataSource<>nil) and (DataSource.State<>dsInactive) then
    begin
      //MessageBox('Next');
      DataSource.DataSet.Next;
    end;
  end;
end;
procedure TMi_ui_DmxScroller_Form_Lcl_ds_test2_dm.PrevExecute(Sender: TObject);
begin
  with DmxScroller_Form_Lcl_DS1 do
  Begin
    if (DataSource<>nil) and (DataSource.State<>dsInactive) then
    begin
      //MessageBox('Prev');
      DataSource.DataSet.Prior;
    end;
  end;
end;

procedure TMi_ui_DmxScroller_Form_Lcl_ds_test2_dm.GoEofExecute(Sender: TObject);
begin
  with DmxScroller_Form_Lcl_DS1 do
  begin
    if (DataSource<>nil) and (DataSource.State<>dsInactive) then
    begin
      //MessageBox('GoEof');
      DataSource.DataSet.Last;
    end;
  end;
end;




end.



//procedure TMi_ui_DmxScroller_Form_Lcl_ds_test2.FormCreate(Sender: TObject);
//begin
//  Mi_ui_DmxScroller_Form_Lcl_ds_test2_dm := TMi_ui_DmxScroller_Form_Lcl_ds_test2_dm.Create(self);
//  DBGrid1.DataSource := Mi_ui_DmxScroller_Form_Lcl_ds_test2_dm.DataSource1;
//  Mi_ui_DmxScroller_Form_Lcl_ds_test2_dm.DmxScroller_Form_Lcl_DS1.ParentLCL := Mi_ScrollBox_LCL1;
//  Mi_ui_DmxScroller_Form_Lcl_ds_test2_dm.DmxScroller_Form_Lcl_DS1.Active := true;
//end;
//



//function TMi_ui_DmxScroller_Form_Lcl_ds_test2_dm.DmxScroller_Form_Lcl_DS1GetTemplate(
//  aNext: PSItem): PSItem;
//begin
//  with DmxScroller_Form_Lcl_DS1 do
//    begin
//      AlignmentLabels:= taRightJustify;//taCenter;//taLeftJustify;
//
//      Result :=
//        NewSItem('',
//        NewSItem('~Estado:~\SS'+ChFN+'estado'+CharPfInKeyPrimary+
//                 ChH+'O campo estado é um campo string com 2 posições. Nota: Ele é o primeiro campo da chave primária.',
//
//        NewSItem('~Cidade:~\Sssssssssssssss`sssssssssssssss'+ChFN+'cidade'+CharPfInKeyPrimary+
//                 ChH+'O campo cidade é um campo string com 30 posições, mais só é visualizado 15 posições. Nota: Ele é o segundo campo da chave primária.',
//
//        NewSItem('~   Cep:~\##.###-###'+ChFN+'cep'+
//                 ChH+'Cep é um campo string com 8 posições. Nota: Só aceita números. Template = ##.###-###',
//
//        NewSItem('~Valor.:~\RRR,RRR.RR'+ChFN+'valor'+
//                 ChH+'Valor é um campo do tipo double. Nota: Só aceita números. Template = RRR,RRR.ZZ',
//
//        NewSItem('~SmalIn:~\II,III'+ChFN+'fldSmallInt'+ChH+'Número inteiro curdo com 2 bytes Faixa:(-32768 .. 32767). Mask: III,III',
//
//        NewSItem('~Driver:~'+ CreateEnumField(TRUE, accNormal, 0,
//                               NewSItem('indefinido',
//                               NewSItem('Pen driver',
//                               NewSItem('SSD',
//                               NewSItem('Nuvem',
//                                        nil)))))+ChFN+'driver'+
//                 ChH+'Driver é um tipo longint e seu valor varia entre 0 e 3. Nota: Contém o número do item da lista suspensa.' + '~Disks.~',
//
//        NewSItem('~Venci.:~\sssssssssss'+ChFN+'Dia'+
//                              CreateOptions(2,NewSItem('Dia 10',
//                                              NewSItem('Dia 15',
//                                              NewSItem('Dia 20',
//                                              NewSItem('Dia 25 e 26',
//                                            nil)))))+
//                 ChH+'O campo dia, é um string com 11 posições. Nota: O número '+
//                     'de caracteres do maior item da lista, não pode ter mais de 11 caracteres.' +
//                 '~ dias~',
////        NewSItem('',
//        NewSItem('~Status:~\X'+ChFN+'status'+'~Status~',
////                 chH+'O campo status é um campo lógico. Nota: Só permite dois valores: 0 ou 1',
////        NewSItem('',
////        NewSItem('~SEXO:~',
//        NewSItem('~       ~\kA Indefinido '+chFN+'sexo',
//        NewSItem('~       ~\kA Masculino   ',
//        NewSItem('~       ~\kA Feminino   '+
//                  chH+'O campo sexo é um do tipo byte.',
//        NewSItem('',
//
//
//        aNext)))))))))))));
//    end;
//
//end;
TDataSetState = (dsInactive, dsBrowse, dsEdit, dsInsert, dsSetKey,
  dsCalcFields, dsFilter, dsNewValue, dsOldValue, dsCurValue, dsBlockRead,
  dsInternalCalc, dsOpening, dsRefreshFields);
