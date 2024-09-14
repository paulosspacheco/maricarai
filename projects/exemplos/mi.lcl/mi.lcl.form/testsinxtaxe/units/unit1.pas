unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, SynEdit
  ,mi.Template.Highlighter;

type

  { TForm1 }

  TForm1 = class(TForm)
    SynEdit1: TSynEdit;
    procedure FormCreate(Sender: TObject);
  private
    FTemplateHighlighter: TMi_Template_Highlighter;
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  // Criar e configurar o highlighter
  FTemplateHighlighter := TMi_Template_Highlighter.Create(Self);

  // Associar o highlighter ao SynEdit
  SynEdit1.Highlighter := FTemplateHighlighter;

  // Exemplo de texto para o SynEdit
  SynEdit1.Lines.Text := '~Nome do Aluno:~\sssssssssssssss';
end;

end.

