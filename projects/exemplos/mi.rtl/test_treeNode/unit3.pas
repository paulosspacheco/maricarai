unit Unit3;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Contnrs, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm2 }

  TForm2 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
  private

  public

  end;

var
  Form2: TForm2;

implementation

{$R *.lfm}

{ TForm2 }



type
  TComponentNode = class
    Name: string;
    ComponentType: string;
    Left: Integer;
    Top: Integer;
    Width: Integer;
    Height: Integer;
    Caption: string;
    Children: TList;
    constructor Create;
    destructor Destroy; override;
  end;

constructor TComponentNode.Create;
begin
  Children := TList.Create;
end;

destructor TComponentNode.Destroy;
var
  i: Integer;
begin
  for i := 0 to Children.Count - 1 do
    TComponentNode(Children[i]).Free;
  Children.Free;
  inherited Destroy;
end;

function ExtractPropertyValue(const Line: string): string;
begin
  Result := Trim(Copy(Line, Pos('=', Line) + 2, MaxInt));
end;

procedure AddComponentToParent(Parent, CurrentComponent: TComponentNode);
begin
  if Assigned(Parent) and Assigned(CurrentComponent) then
    Parent.Children.Add(CurrentComponent);
end;

procedure ConvertLFMToHTML(const LFMFileName, HTMLFileName, CSSFileName: string);
var
  LFMFile, HTMLFile, CSSFile: TextFile;
  Line: string;
  RootNode, CurrentNode: TComponentNode;
  ComponentStack: TList;
  InComponent: Boolean;

  procedure GenerateHTML(Node: TComponentNode);
  var
    i: Integer;
  begin
    if Node.ComponentType = 'TForm' then
      Writeln(HTMLFile, '<div id="' + Node.Name + '" class="TForm">')
    else if Node.ComponentType = 'TButton' then
      Writeln(HTMLFile, '<button id="' + Node.Name + '" class="TButton">' + Node.Caption + '</button>');

    for i := 0 to Node.Children.Count - 1 do
      GenerateHTML(TComponentNode(Node.Children[i]));

    if Node.ComponentType = 'TForm' then
      Writeln(HTMLFile, '</div>');
  end;

  procedure GenerateCSS(Node: TComponentNode);
  begin
    if Node.ComponentType = 'TForm' then
    begin
      Writeln(CSSFile, '#' + Node.Name + ' {');
      Writeln(CSSFile, '  position: absolute;');
      Writeln(CSSFile, '  left: ' + IntToStr(Node.Left) + 'px;');
      Writeln(CSSFile, '  top: ' + IntToStr(Node.Top) + 'px;');
      Writeln(CSSFile, '  width: ' + IntToStr(Node.Width) + 'px;');
      Writeln(CSSFile, '  height: ' + IntToStr(Node.Height) + 'px;');
      Writeln(CSSFile, '  background-color: #f0f0f0;');
      Writeln(CSSFile, '}');
    end
    else if Node.ComponentType = 'TButton' then
    begin
      Writeln(CSSFile, '#' + Node.Name + ' {');
      Writeln(CSSFile, '  position: absolute;');
      Writeln(CSSFile, '  left: ' + IntToStr(Node.Left) + 'px;');
      Writeln(CSSFile, '  top: ' + IntToStr(Node.Top) + 'px;');
      Writeln(CSSFile, '  width: ' + IntToStr(Node.Width) + 'px;');
      Writeln(CSSFile, '  height: ' + IntToStr(Node.Height) + 'px;');
      Writeln(CSSFile, '  background-color: #007bff;');
      Writeln(CSSFile, '  color: #fff;');
      Writeln(CSSFile, '  border: none;');
      Writeln(CSSFile, '  padding: 5px 10px;');
      Writeln(CSSFile, '  text-align: center;');
      Writeln(CSSFile, '  cursor: pointer;');
      Writeln(CSSFile, '}');
    end;
  end;

begin
  AssignFile(LFMFile, LFMFileName);
  Reset(LFMFile);

  AssignFile(HTMLFile, HTMLFileName);
  Rewrite(HTMLFile);

  AssignFile(CSSFile, CSSFileName);
  Rewrite(CSSFile);

  RootNode := nil;
  CurrentNode := nil;
  ComponentStack := TList.Create;
  InComponent := False;

  while not Eof(LFMFile) do
  begin
    Readln(LFMFile, Line);

    if Pos('object ', Line) = 1 then
    begin
      if InComponent then
        ComponentStack.Add(CurrentNode);

      InComponent := True;
      CurrentNode := TComponentNode.Create;
      CurrentNode.Name := Trim(Copy(Line, 8, Pos(':', Line) - 8));
      CurrentNode.ComponentType := Trim(Copy(Line, Pos(':', Line) + 2, MaxInt));

      if RootNode = nil then
        RootNode := CurrentNode
      else if ComponentStack.Count > 0 then
        AddComponentToParent(TComponentNode(ComponentStack.Last), CurrentNode);

      Continue;
    end;

    if InComponent and (Trim(Line) = 'end') then
    begin
      if ComponentStack.Count > 0 then
      begin
        CurrentNode := TComponentNode(ComponentStack.Last);
        ComponentStack.Delete(ComponentStack.Count - 1);
      end;
      InComponent := False;
      Continue;
    end;

    if InComponent then
    begin
      if Pos('Left = ', Line) > 0 then
        CurrentNode.Left := StrToInt(ExtractPropertyValue(Line));
      if Pos('Top = ', Line) > 0 then
        CurrentNode.Top := StrToInt(ExtractPropertyValue(Line));
      if Pos('Width = ', Line) > 0 then
        CurrentNode.Width := StrToInt(ExtractPropertyValue(Line));
      if Pos('Height = ', Line) > 0 then
        CurrentNode.Height := StrToInt(ExtractPropertyValue(Line));
      if Pos('Caption = ', Line) > 0 then
        CurrentNode.Caption := ExtractPropertyValue(Line);
    end;
  end;

  // Geração do HTML e CSS a partir da árvore
  Writeln(HTMLFile, '<!DOCTYPE html>');
  Writeln(HTMLFile, '<html lang="en">');
  Writeln(HTMLFile, '<head>');
  Writeln(HTMLFile, '  <meta charset="UTF-8">');
  Writeln(HTMLFile, '  <meta name="viewport" content="width=device-width, initial-scale=1.0">');
  Writeln(HTMLFile, '  <title>Test Form</title>');
  Writeln(HTMLFile, '  <link rel="stylesheet" href="' + CSSFileName + '">');
  Writeln(HTMLFile, '</head>');
  Writeln(HTMLFile, '<body>');

  if Assigned(RootNode) then
    GenerateHTML(RootNode);

  Writeln(HTMLFile, '</body>');
  Writeln(HTMLFile, '</html>');

  // Geração do CSS
  if Assigned(RootNode) then
    GenerateCSS(RootNode);

  ComponentStack.Free;
  RootNode.Free;
  CloseFile(LFMFile);
  CloseFile(HTMLFile);
  CloseFile(CSSFile);
end;




//type
//  TComponentNode = class
//    Name: string;
//    ComponentType: string;
//    Left: Integer;
//    Top: Integer;
//    Width: Integer;
//    Height: Integer;
//    Caption: string;
//    Children: TObjectList;
//    constructor Create;
//    destructor Destroy; override;
//  end;
//
//constructor TComponentNode.Create;
//begin
//  Children := TObjectList.Create(True);  // True para destruir automaticamente os objetos filhos
//end;
//
//destructor TComponentNode.Destroy;
//begin
//  Children.Free;
//  inherited Destroy;
//end;
//
//function ExtractPropertyValue(const Line: string): string;
//begin
//  Result := Trim(Copy(Line, Pos('=', Line) + 2, MaxInt));
//end;
//
//procedure AddComponentToParent(Parent, CurrentComponent: TComponentNode);
//begin
//  if Assigned(Parent) and Assigned(CurrentComponent) then
//    Parent.Children.Add(CurrentComponent);
//end;
//
//procedure ConvertLFMToCSS(const LFMFileName, CSSFileName: string);
//var
//  LFMFile, CSSFile: TextFile;
//  Line: string;
//  RootNode, CurrentNode, ParentNode: TComponentNode;
//  ComponentStack: TObjectList;
//  InComponent: Boolean;
//
//  procedure GenerateCSS(Node: TComponentNode; Level: Integer);
//  var
//    i: Integer;
//    Indent: string;
//  begin
//    Indent := StringOfChar(' ', Level * 2);
//    Writeln(CSSFile, Indent + '#' + Node.Name + ' {');
//    Writeln(CSSFile, Indent + '  @extend .' + Node.ComponentType + ';');
//    Writeln(CSSFile, Indent + '  left: ' + IntToStr(Node.Left) + 'px;');
//    Writeln(CSSFile, Indent + '  top: ' + IntToStr(Node.Top) + 'px;');
//    Writeln(CSSFile, Indent + '  width: ' + IntToStr(Node.Width) + 'px;');
//    Writeln(CSSFile, Indent + '  height: ' + IntToStr(Node.Height) + 'px;');
//    if Node.Caption <> '' then
//      Writeln(CSSFile, Indent + '  content: "' + Node.Caption + '";');
//    Writeln(CSSFile, Indent + '}');
//
//    for i := 0 to Node.Children.Count - 1 do
//      GenerateCSS(TComponentNode(Node.Children[i]), Level + 1);
//  end;
//
//begin
//  AssignFile(LFMFile, LFMFileName);
//  Reset(LFMFile);
//
//  AssignFile(CSSFile, CSSFileName);
//  Rewrite(CSSFile);
//
//  RootNode := nil;
//  CurrentNode := nil;
//  ComponentStack := TObjectList.Create(False);
//  InComponent := False;
//
//  while not Eof(LFMFile) do
//  begin
//    Readln(LFMFile, Line);
//
//    if Pos('object ', Line) = 1 then
//    begin
//      if InComponent then
//        ComponentStack.Add(CurrentNode);
//
//      InComponent := True;
//      CurrentNode := TComponentNode.Create;
//      CurrentNode.Name := Trim(Copy(Line, 8, Pos(':', Line) - 8));
//      CurrentNode.ComponentType := Trim(Copy(Line, Pos(':', Line) + 2, MaxInt));
//
//      if RootNode = nil then
//        RootNode := CurrentNode
//      else if ComponentStack.Count > 0 then
//        AddComponentToParent(TComponentNode(ComponentStack.Last), CurrentNode);
//
//      Continue;
//    end;
//
//    if InComponent and (Trim(Line) = 'end') then
//    begin
//      if ComponentStack.Count > 0 then
//      begin
//        CurrentNode := TComponentNode(ComponentStack.Last);
//        ComponentStack.Delete(ComponentStack.Count - 1);
//      end;
//      InComponent := False;
//      Continue;
//    end;
//
//    if InComponent then
//    begin
//      if Pos('Left = ', Line) > 0 then
//        CurrentNode.Left := StrToInt(ExtractPropertyValue(Line));
//      if Pos('Top = ', Line) > 0 then
//        CurrentNode.Top := StrToInt(ExtractPropertyValue(Line));
//      if Pos('Width = ', Line) > 0 then
//        CurrentNode.Width := StrToInt(ExtractPropertyValue(Line));
//      if Pos('Height = ', Line) > 0 then
//        CurrentNode.Height := StrToInt(ExtractPropertyValue(Line));
//      if Pos('Caption = ', Line) > 0 then
//        CurrentNode.Caption := ExtractPropertyValue(Line);
//    end;
//  end;
//
//  // Geração do CSS a partir da árvore
//  if Assigned(RootNode) then
//    GenerateCSS(RootNode, 0);
//
//  // Definir classes CSS para cada tipo de componente
//  Writeln(CSSFile);
//  Writeln(CSSFile, '.TButton {');
//  Writeln(CSSFile, '  display: inline-block;');
//  Writeln(CSSFile, '  padding: 5px 10px;');
//  Writeln(CSSFile, '  text-align: center;');
//  Writeln(CSSFile, '  cursor: pointer;');
//  Writeln(CSSFile, '  background-color: #007bff;');
//  Writeln(CSSFile, '  color: #fff;');
//  Writeln(CSSFile, '}');
//
//  Writeln(CSSFile, '.TForm {');
//  Writeln(CSSFile, '  display: block;');
//  Writeln(CSSFile, '  position: absolute;');
//  Writeln(CSSFile, '  padding: 10px;');
//  Writeln(CSSFile, '  background-color: #f0f0f0;');
//  Writeln(CSSFile, '}');
//
//  ComponentStack.Free;
//  RootNode.Free;
//  CloseFile(LFMFile);
//  CloseFile(CSSFile);
//end;




procedure TForm2.Button1Click(Sender: TObject);
begin
  ConvertLFMToHTML('unit3.lfm', 'index.html', 'form.css');
  ShowMessage('Conversão para .css completa.');
end;
//begin
//  ConvertLFMToHTML('form.lfm', 'index.html', 'form.css');
//  Writeln('Conversion complete.');
//end.

end.



