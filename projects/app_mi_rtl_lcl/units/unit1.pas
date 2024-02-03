unit Unit1;
{:< A unit **@name** é usado para demonstração do uso da unit da  **mi_ui_mi_msgbox_dm**.

- **NOTAS**
  - A unit **mi_ui_mi_msgbox_dm** não precisa ser inicializada no projeto principal
    porque a mesma auto se cria caso ela seja declarada no projeto principal.

  - Os dialogos da **LCL** são executados indiretamente pela classe **TMI_MsgBox**.
    - Motivo:
      - A classe **TMI_MsgBox** pode ser usada em todos os tipos de aplicação, inclusive
        javascript, pelo menos essa é a ideia.
  - O projeto **mi.rtl.tests** tem um exemplo completo de todas as funcionalidades do
    pacote **mi.rtl**
}


{$mode Delphi}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls
  ,mi.rtl.Objectss;

type

  { TForm1 }

  {: O form **@name** demonstra o uso do método TObjectss.InputPassword() }
  TForm1 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
  var
    senha : string ='0123';
begin
  TObjectss.InputPassword('Senha: ',senha );

end;

end.

