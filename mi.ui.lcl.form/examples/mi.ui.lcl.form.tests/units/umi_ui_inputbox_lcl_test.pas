unit umi_ui_inputbox_lcl_test;
{: A unit **@name** domonstra o uso da classe TMI_UI_InputBox }

{$mode Delphi}

interface

uses
  Classes, SysUtils
  ,umi_ui_InputBox_lcl;

Procedure TestinputBox;

implementation

procedure InputBoxOnEnter(aDmxScroller: TUiDmxScroller);

  //Ao entrar no formulário este evento inicia os campos nome, endereço e cep
  procedure SetValue(Field:String;Value:String; hint:String);
    var
      aField: pDmxFieldRec;
  begin
    with aDmxScroller do
    begin
      aField := FieldByName(Field);
      if aField<>nil
      Then begin
             aField.AsString:= value;
//             aField.HelpCtx_Hint:=hint;
             SetHelpCtx_Hint(aField,hint);
           end;
    end;

  end;

begin
  with aDmxScroller do
  begin
    setValue('nome','Paulo Henrique','Nome do alunos com 35 posições');
    setValue('endereco','Rua Francisco de Souza Oliveira, 15','Número da rua com 50 posições');
    setValue('cep','60310770','Cep da rua do aluno com 15 posições');
  end;
end;

procedure InputBoxOnEnterField(aField: pDmxFieldRec);
  // Ao entrar no campo 01 e o mesmo for vazio inicializa-o com o nome Paulo Sérgio
begin
  Case aField.Fieldnum of
    1 : begin
          if aField.AsString = ''
          then aField.AsString := 'Paulo Sérgio';
        end;
    2 : begin end;
  end;

end;

Procedure InputBoxOnCloseQuery (aDmxScroller:TUiDmxScroller; var CanClose:boolean);
  //Esta função permite validar o formulário ao pressionar o botão ok.
  var
    matricula : integer;
    s : string;
begin
  s := aDmxScroller.FieldByName('matricula').AsString;
  matricula := StrToInt(s);

  with aDmxScroller,MI_MsgBox do
  if  (matricula > 1000)
  then begin
         aDmxScroller.MI_MsgBox.MessageBox('ATENÇÃO',
         Format('Esse campo só aceita valores entre %d a %d  ',[1,1000]),mtWarning, [mbOK],mbOk);
         CanClose := false;
       end
  else CanClose := true;
end;

//  with TDmxScroller_Form_Lcl do
//  Template :=  '~Nome do Aluno:~\Sssssssssssssssssssssssss`ssssssssssssssss'+ChFN+'Nome'+lf+
//               '~     Endereço:~\Sssssssssssssssssssssssss`ssssssssssssssss'+ChFN+'endereco'+lf+
//               '~          Cep:~\##-###-###'+ChFN+'cep'+lf+
//               '~       Bairro:~\sssssssssssssssssssssssss'+ChFN+'bairro'+lf+
//               '~       Cidade:~\sssssssssssssssssssssssss'+ChFN+'cidade'+lf+
//               '~       Estado:~\SS'+ChFN+'estado'+lf+
//               '~        Idade:~\BB'+ChFN+'idade'+CharUpperlimit+#64+lf+
//               '~    Matricula:~\IIII'+ChFN+'matricula'+lf+
//               '~      Valor da~'+lf+
//               '~  Mensalidade:~\R,RRR.RR'+ChFN+'mensalidade'+lf+
//               lf
////               '~                    ~\'#27'~O&k~'+ActionItem
//               ;

Procedure TestinputBox;
  //Criar o formulário
  Var
   MI_UI_InputBox : TMI_UI_InputBox = nil;
   Template : AnsiString;
   StringList : TStringList;
begin
  StringList := TStringList.Create;
  with StringList do
  begin
    add('~Nome do Aluno:~\Ssssssssssssssssssss`sssssssssssssssssssss'+ChFN+'Nome');
    add('~     Endereço:~\Ssssssssssssssssssss`sssssssssssssssssssss'+ChFN+'endereco');
    add('~          Cep:~\##-###-###'+ChFN+'cep');
    add('~       Bairro:~\ssssssssssssssssssss`sssss'+ChFN+'bairro');
    add('~       Cidade:~\ssssssssssssssssssss`sssss'+ChFN+'cidade');
    add('~       Estado:~\SS'+ChFN+'estado');
    add('~        Idade:~\BB'+ChFN+'idade'+CharUpperlimit+#64);
    add('~    Matricula:~\IIII'+ChFN+'matricula');
    add('~      Valor da~');
    add('~  Mensalidade:~\R,RRR.RR'+ChFN+'mensalidade');

  end;

  Template := StringList.Text;
  Freeandnil(StringList);

  with TDmxScroller_Form_Lcl,MI_MsgBox do
    if umi_ui_InputBox_lcl.InputBox('Dados do aluno',
                 Template,
                 'Courier New',
                 InputBoxOnEnter,nil,
                 InputBoxOnEnterField,nil,
                 InputBoxOnCloseQuery,
                 MI_UI_InputBox
                ) = MrOk
  then with MI_UI_InputBox.DmxScroller_Form_Lcl1 do
       begin //Neste bloco pode-se fazer qualcoisa comos dados do formulário.
         if FieldByName('nome').AsString = ''
         then begin
                ShowMessage('Campo "nome" não pode ser vazio');
              end;
         MI_UI_InputBox.free;
       end;
end;

end.

