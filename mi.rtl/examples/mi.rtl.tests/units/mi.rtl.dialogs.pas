unit mi.ui.dialogs;
{:< - A unit **@name** implementa a classe TDialogs do pacote mi.ui.

    - **VERSÃO**:
      - Alpha - 0.8.0

    - **CÓDIGO FONTE**:
      - @html(<a href="../units/mi.ui.dialogs.pas">mi.ui.Dialogs.pas</a>)

    - **HISTÓRICO**
      - Criado por: Paulo Sérgio da Silva Pacheco e-mail: paulosspacheco@@yahoo.com.br
        - 2021-12-02
          - 23:00 a 23:35 - Criado a unit **@name** e implementação da classe **TDialogs**

      - 2021-12-03
        - 09:40 a 12:00
          - Criar método de classe Confirm();
          - Criar método de classe Prompt();
          - Criar método de classe Password();

      - **2021-12-04**
        - 15:11 a 16:40
           - Criar exemplo TForm1.Test_tobjects_dlgs_Confirm;
           - Criar exemplo TForm1.Test_tobjects_dlgs_Prompt;
           - Criar exemplo TForm1.Test_tobjects_dlgs_password;

}
{$IFDEF FPC}
  {$MODE Delphi} {$H+}
{$ENDIF}

interface

uses
  Classes, SysUtils
  ,Forms
  ,Dialogs
  ,Graphics
  ,StdCtrls
  ,mi.rtl.objects.consts
  ,mi.rtl.objects.Methods
  ,mi.rtl.objects.consts.dialogs;

  type
    {: - A classe **@name** é usada para construção de mensagens para o usuário. Uso a unit Dialogs do Lazarus.
    }

    { TDialogs }

    TDialogs = class(mi.rtl.objects.consts.dialogs.TDialogs)
      public constructor Create(aOwner: TObjectsConsts);overload;override;

      {: - O método **@name** mostra uma mensagem formatada onde a função reconhece ^M para passagem de linha, ^J retorno do carro e ^C.

         - **NOTA**
           - O texto entre ^C vai ficar alinhado no centro do topo do formulário.

         - **EXEMPLO**

           ```pascal


           ```
      }
      public function CreateMessageDialog( aCaption, aMsg: string; DlgType: TMsgDlgType;  Buttons: TMsgDlgButtons): integer; overload;

      {: - A procedure **@name** executa um dialogo com botão **OK**
      }
      public Procedure Alert(aTitle: AnsiString;aMsg:AnsiString);  override;

      {: - A procedure **@name** executa um diálogo com dois botões: **OK** e **Cancel**

         - **RETORNA:**
           - **True** : Se o botão **OK** foi pŕessionando;
           - **False** : Se o botão **Cancel** foi pŕessionando.

         - **EXEMPLO**

           ```pascal

             procedure TForm1.Test_tobjects_dlgs_Confirm;
             begin
               with TObjectss.dlgs do
                 if Confirm('Test_tobjects_dlgs_Confirm','Continua o processamento?')
                 then Alert('Test_tobjects_dlgs_Confirm','Confirmado a ação!')
                 else Alert('Test_tobjects_dlgs_Confirm','Não confirmado a ação!');
             end;


           ```

      }
      public Function Confirm(aTitle: AnsiString;aPergunta:AnsiString):Boolean;override;

      {: - A função **@name** mostra um dialogo com dois botões **OK** e **Cancel** e uma entrada de dados solicitando
           que o usuário digite um valor.

         - **RETORNA:**
           - **True** : Se o botão **ok** foi pŕessionando;
           - **False** : Se o botão **cancel** foi pŕessionando.
           - **aResult** : Retorna a string digitada no formulário;

         - **EXEMPLO**

           ```pascal

             procedure TForm1.Test_tobjects_dlgs_Prompt;
               var idade,fmt : string;
             begin
               idade := '';
               with TObjectss.dlgs do
                 if Prompt('Test de Dlgs.Prompt','Qual a sua idade',idade)
                 then begin
                        fmt := format('Idade digitada: %s   '+^M+
                                      'Idade de meu pai é %d ',[idade,102]);
                        Alert('Test de Dlgs.Prompt',fmt) //
                      end
                 else Alert('Test de Dlgs.Prompt','Ok. Respeito sua privacidade.');
             end;


           ```

      }
      public Function Prompt(aTitle: AnsiString;aPergunta:AnsiString;Var aResult: AnsiString):Boolean;override;


      {: - A função **@name** mostra um diálogo para receber um valor sem mostrar o que foi digitado.
           O formulário possui dois botões **OK** e **Cancel**

         - **RETORNA:**
           - **True** : Se o botão **ok** foi pressionado;
           - **False** : Se o botão **cancel** foi pressionado.
           - **apassword** : Retorna a string com a senha do usuário.
      }
      Function GetPassword(aTitle: AnsiString;
                           var apassword:AnsiString):Boolean;Overload;override;

      {: - A função **@name** mostra um dialogo solicitando o login do usuário e a senha e dois botões **OK**
           e **Cancel**

         - **RETORNA:**
           - **True** : Se o botão **ok** foi pŕessionando;
           - **False** : Se o botão **cancel** foi pŕessionando.
           - **aUsername** : Retorna a string com nome do usuário.
           - **apassword** : Retorna a string com a senha do usuário.

         - **EXEMPLO**

           ```pascal

             procedure TForm1.Test_tobjects_dlgs_password;
               Var
                 s,u : string;
             begin
               s := '';
               with TObjectss.dlgs do
                 if GetPassword('Password',u,s)
                 then Alert('Password','A senha digitada é: '+S)
                 else Alert('Password','Senha não informada');

             end;

           ```

      }
      public Function GetPassword(aTitle: AnsiString;
                           var aUsername:AnsiString;
                           var apassword:AnsiString):Boolean;Overload;override;

    end;

    Const _Dialogs : mi.ui.Dialogs.TDialogs = nil;

implementation

{ TDialogs }
constructor TDialogs.Create(aOwner: TObjectsConsts);
begin
  inherited create(aOwner);

end;

function TDialogs.CreateMessageDialog(aCaption, aMsg: string; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons): integer;
var
  pos1,pos2 : integer;
  LForm: TForm;
  M: string;
  h : string;
begin
  try
    m := aMsg;
    while (pos(^c,m)<> 0) do
    begin
      delete(m,pos(^c,m),1);
    end;

    Lform := Dialogs.CreateMessageDialog(aCaption,m, mtCustom, [mbOK]);
  //  Lform.SetInitialBounds(0,0,300,300);

    { Calcula h = Texto entre ^C.
      Ex: Formato de entrada: ^C texto ^C ^M
    }
    pos1 := pos(^C,aMsg);
    if pos1 <> 0 then
    begin //Pega o texto que deve ficar no centro.
      pos2 := pos(^C,copy(aMsg,pos1+1,length(aMsg)));
      if pos2 <> 0 then
      begin
        h := copy(aMsg,pos1+1,pos2-pos1);
        delete(aMsg,pos1,pos2-pos1);
        //Delete o ^M
        pos1 := pos(^M,aMsg);
        if  pos1 <> 0
        then delete(aMsg,1,pos1);
      end;
    end;

    with Lform do
    begin
      //Caption := aCaption;
      Font.Name := 'Courier New';
      if Font.Name <> 'Courier New'
      then Font.Name := 'DejaVu Sans Mono';
    end;


    // Criar o Label do cabeçalho
    with TLabel.Create(Lform) do begin
      Caption := h;
      ParentColor := True;
      Alignment := taCenter;
      Layout := tlCenter;
      AutoSize := true;
      left := 0;
      top := 0;
      height := 30;
      width := 200;
      //SetBounds(0, 0, LForm.Width, (LForm.Components[0] as TControl).Top);
    end;


    // Criar o Label abaixo do cabeçalho
    with TLabel.Create(Lform) do begin
      Caption := aMsg;
      ParentColor := True;
      left := 0;
      top  := 15+1;
      width := 144;
    end;

    if LForm <> nil
    then result := LForm.ShowModal
    else Result := -1;

  finally
    FreeAndNil(LForm);
  end;

end;


procedure TDialogs.Alert(aTitle: AnsiString; aMsg: AnsiString);
begin
  if pos('Erro',Atitle) > 0
  then Dialogs.MessageDlg(aTitle, aMsg, mtError,  [mbOk],0)
  else MessageDlg(aTitle, aMsg, mtWarning, [mbOk],0)
end;

function TDialogs.Confirm(aTitle: AnsiString; aPergunta: AnsiString): Boolean;
begin
  if Dialogs.MessageDlg(aTitle, aPergunta, mtConfirmation, [mbYes, mbNo],0) = mrYes
  then Result := true
  else Result := false;
end;

function TDialogs.Prompt(aTitle: AnsiString; aPergunta: AnsiString;  var aResult: AnsiString): Boolean;
   var
     v : AnsiString;
begin

  v := InputBox(aTitle, aPergunta, aResult);
  if aResult <> v
  then Begin
         result := true;
         aResult := v;
       end
  else result := false;

end;

function TDialogs.GetPassword(aTitle: AnsiString; var apassword: AnsiString  ): Boolean;
  var
    v : AnsiString;
begin
  v := apassword;
  InputQuery(aTitle, 'Digite a Senha:',true, apassword);
  if apassword <> v
  then result := true
  else result := false;
end;


function TDialogs.GetPassword(aTitle: AnsiString; var aUsername: AnsiString;var apassword: AnsiString): Boolean;
  var
    v : AnsiString;
begin
  v := apassword;
  InputQuery(aTitle, 'Digite a Senha:',true, apassword);
  if apassword <> v
  then Begin
         result := true;
       end
  else result := false;
end;


Initialization

   _Dialogs := TDialogs.Create(nil);
   TObjectsMethods.SetDialogs(_Dialogs);

finalization;

   freeAndNil(_Dialogs);
end.

