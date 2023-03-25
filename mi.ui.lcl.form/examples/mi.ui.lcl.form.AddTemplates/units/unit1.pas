unit Unit1;
{:< A unit **@name** implementa a classe TTForm1 do pacote mi.ui.}

{$IFDEF FPC}
  {$MODE Delphi} {$H-}
{$ENDIF}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, LMessages, StdCtrls,
  uMi_ui_scrollbox_lcl, uMi_ui_Dmxscroller_form_lcl, mi_rtl_ui_dmxscroller;

type
  {: A unit **@name** é usada para testar o pacote mi.ui}

  { TForm1 }

  TForm1 = class(TForm)
    DmxScroller_Form_Lcl1: TDmxScroller_Form_Lcl;
    Mi_ScrollBox_LCL1: TMi_ScrollBox_LCL;


    procedure DmxScroller_Form_Lcl1AddTemplate( const aUiDmxScroller: TUiDmxScroller);
    procedure FormCreate(Sender: TObject);
//  protected procedure WMDESTROY(var Message: TLMDESTROY); message LM_DESTROY;
  private

  public
   destructor destroy;override;
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }


procedure TForm1.FormCreate(Sender: TObject);
begin
  DmxScroller_Form_Lcl1.Active:= true;
end;


Procedure AddTemplateHeader(const aUiDmxScroller:TUiDmxScroller);
begin
  with aUiDmxScroller do
  begin
    add('~EXEMPLO DE TEMPLATE~');
    add('');
  end;
end;

Procedure AddTemplateAlfanumericos(const aUiDmxScroller:TUiDmxScroller);
begin
  with aUiDmxScroller do
  begin
    add('~_CAMPOS ALFANUMÉRICOS________________________________________~');
    add('~Alfanumérico 01:~\SSSSSSSSSSSSSSS'+ChFN+'fld01'+ChH+'Campo alfanumérico com 15 posições maiúsculas.');
    add('~Alfanumérico 02:~');
    add('~~\ssssssssssssssssssssssssssssssssssssss'+ChFN+'fld02'+chH+'Alfanumérico maiuscula e minuscula com 30 posições.');
    add('~Alfanumérico 03:~\Sssssssssssssss'+ChFN+'fld03'+ChFN+chH+'Alfanumérico com a primeira letra maiuscula.');
    add('~Alfanumérico 04:~\(##) # #### ####'+ChFN+'fld04'+ChFN+chH+'Alfanumérico que só aceita os caracteres 0 a 9.');
    add('');
  end;
end;

Procedure AddTemplateNumericos(const aUiDmxScroller:TUiDmxScroller);
begin
  with aUiDmxScroller do
  begin
    add('~_CAMPOS NUMÉRICOS____________________________________________~');
    add('~Valor double...:~\RRR,RRR.RR'+ChFN+'fld05');
    add('~Valor SmalInt..:~\II,III'+ChFN+'fld06');
    add('~Valor Byte.....:~\BBB'+ChFN+'fld07');
    add('~Valor Smallword:~\WW,WWW'+ChFN+'fld08');
    add('');
  end;
end;


Procedure AddTemplateComplexo(const aUiDmxScroller:TUiDmxScroller);
begin
  with aUiDmxScroller do
  begin
    add('~_CAMPOS COMPLEXOS____________________________________________~');
    add('~Sexo...........:~'+ CreateEnumField(TRUE, accNormal, 0,
                                  NewSItem(' indefinido ',
                                  NewSItem(' Masculino',
                                  NewSItem(' Feminino',
                                          nil))))+ChFN+'fld09');
    add('~Estado Civil              ~\KA Indefinido  '+chFN+'Sexo'+ChFN+'fld10');
    add('~~\X Casado?                '+ChFN+'fld11'+'\KA Masculino    ');
    add('~~\X Pretende se divorciar? '+ChFN+'fld12'+'\KA Feminino     ');
    add('~~\X Tens filhos?           '+ChFN+'fld13');
    add('');
  end;
end;



procedure TForm1.DmxScroller_Form_Lcl1AddTemplate( const aUiDmxScroller: TUiDmxScroller);
begin
  AddTemplateHeader(aUiDmxScroller);
  AddTemplateAlfanumericos(aUiDmxScroller);
  AddTemplateNumericos(aUiDmxScroller);
  AddTemplateComplexo(aUiDmxScroller);
end;


destructor TForm1.destroy;
begin
  inherited destroy;
end;

end.

//~EXEMPLO DE TEMPLATE~
//
//~Alfanumérico maiúscula com 15 posições:~\SSSSSSSSSSSSSSS
//~Alfanumérico maiúscula com 25 posições:~\SSSSSSSSSSSSSSS`ssssssssss
//~Alfanumérico maiuscula e minuscula com 30 posições:~
//~~\ssssssssssssssssssssssssssssssssssssss
//~~
//~Alfanumérico com a~
//~primeira letra maiuscula:~\Sssssssssssssss
//~Telefone................:~\(##) # #### ####
//~Valor double............:~\RRR,RRR.RR
//~Valor SmalInt...........:~\II,III
//~Valor Byte..............:~\BBB
//~Valor Smallword.........:~\WW,WWW



//~EXEMPLO DE TEMPLATE~
//
//~Alfanumérico maiúscula com 15 posições:~\SSSSSSSSSSSSSSS
//~Alfanumérico maiuscula e minuscula com 30 posições:~
//~~\ssssssssssssssssssssssssssssssssssssss
//~Alfanumérico com a primeira letra maiuscula:~\Sssssssssssssss
//~Telefone...........:~\(##) # #### ####
//~Valor double.......:~\RRR,RRR.RR
//~Valor SmalInt......:~\II,III
//~Valor Byte.........:~\BBB
//~Valor Smallword....:~\WW,WWW




