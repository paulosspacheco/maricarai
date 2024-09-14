unit Mi.Template.Highlighter;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Graphics, SynEditHighlighter, SynEditTypes, LResources;

type
  TRangeState = (rsNormal, rsLabel);

  TMi_Template_Highlighter = class(TSynCustomHighlighter)
  private
    fRange: TRangeState;
    fLine: string;
    Run: LongInt;
    FLabelAttri: TSynHighlighterAttributes;
  protected
    function GetSampleSource: string; override;
    function GetTokenAttribute: TSynHighlighterAttributes; override;
    function GetTokenKind: integer; override;
    function GetTokenPos: Integer; override;
    function GetEol: Boolean; override;
    function GetRange: Pointer; override;
    procedure SetRange(Value: Pointer); override;
    procedure ResetRange; override;
    function GetToken: string; override; // Implementação do método abstract
  public
    constructor Create(AOwner: TComponent); override;
    procedure SetLine(const NewValue: string; LineNumber: Integer); override;
    procedure Next; override;
    procedure GetTokenEx(out TokenStart: PChar; out TokenLength: integer); override;
  published
    property LabelAttri: TSynHighlighterAttributes read FLabelAttri write FLabelAttri;
  end;

procedure Register;

implementation

constructor TMi_Template_Highlighter.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FLabelAttri := TSynHighlighterAttributes.Create('Label');
  FLabelAttri.Foreground := clBlue;
  AddAttribute(FLabelAttri);

  SetAttributesOnChange(@DefHighlightChange);
end;

procedure TMi_Template_Highlighter.SetLine(const NewValue: string; LineNumber: Integer);
begin
  fLine := NewValue;
  Run := 1; // Start at the beginning of the line
  Next;
end;

procedure TMi_Template_Highlighter.Next;
begin
  // Check if we need to change the state based on the current character
  while Run <= Length(fLine) do
  begin
    case fLine[Run] of
      '~':
        begin
          // Toggle range state on encountering '~'
          if fRange = rsLabel then
            fRange := rsNormal
          else
            fRange := rsLabel;
          Inc(Run);
          Exit;
        end;
    else
      // If not '~', continue with normal state
      fRange := rsNormal;
      Inc(Run);
    end;
  end;

  // If end of line, set state to normal
  fRange := rsNormal;
end;

function TMi_Template_Highlighter.GetTokenAttribute: TSynHighlighterAttributes;
begin
  case fRange of
    rsLabel: Result := FLabelAttri;
  else
    Result := nil;
  end;
end;

function TMi_Template_Highlighter.GetTokenKind: integer;
begin
  Result := Ord(fRange);
end;

function TMi_Template_Highlighter.GetTokenPos: Integer;
begin
  Result := Run;
end;

function TMi_Template_Highlighter.GetEol: Boolean;
begin
  Result := Run > Length(fLine);
end;

function TMi_Template_Highlighter.GetRange: Pointer;
begin
  Result := Pointer(PtrInt(fRange));  // Convertendo TRangeState para Pointer
end;

procedure TMi_Template_Highlighter.SetRange(Value: Pointer);
begin
  fRange := TRangeState(PtrInt(Value));  // Convertendo Pointer de volta para TRangeState
end;

procedure TMi_Template_Highlighter.ResetRange;
begin
  fRange := rsNormal;
end;

function TMi_Template_Highlighter.GetSampleSource: string;
begin
  Result := '~Nome do Aluno:~ \sssssssssssssss';
end;

function TMi_Template_Highlighter.GetToken: string;
begin
  Result := Copy(fLine, Run, Length(fLine) - Run + 1);
end;

procedure TMi_Template_Highlighter.GetTokenEx(out TokenStart: PChar; out TokenLength: integer);
begin
  TokenStart := PChar(GetToken);
  TokenLength := Length(GetToken);
end;

procedure Register;
begin
  {$I mi.template.highlighter_icon.lrs}
  RegisterComponents('Mi.Lcl', [TMi_Template_Highlighter]);
end;

end.

//{$mode objfpc}{$H+}
//
//interface
//
//uses
//  Classes, SysUtils, Graphics, SynEditHighlighter, SynEditTypes,LResources;
//
//type
//  TRangeState = (rsUnknown);
//
//  TMi_Template_Highlighter  = class(TSynCustomHighlighter)
//  private
//    fRange: TRangeState;
//    fTokenPos: Integer;
//    fLine: string;
//    Run: LongInt;
//    FLabelAttri: TSynHighlighterAttributes;
//    FEditableAttri: TSynHighlighterAttributes;
//  protected
//    function GetSampleSource: string; override;
//    function GetTokenAttribute: TSynHighlighterAttributes; override;
//    function GetTokenKind: integer; override;
//    function GetTokenPos: Integer; override;
//    function GetEol: Boolean; override;
//    function GetRange: Pointer; override;
//    procedure SetRange(Value: Pointer); override;
//    procedure ResetRange; override;
//  public
//    constructor Create(AOwner: TComponent); override;
//    procedure SetLine(const NewValue: string; LineNumber: Integer); override;
//    procedure Next; override;
//    procedure GetTokenEx(out TokenStart: PChar; out TokenLength: integer); override;
//  published
//    property LabelAttri: TSynHighlighterAttributes read FLabelAttri write FLabelAttri;
//    property EditableAttri: TSynHighlighterAttributes read FEditableAttri write FEditableAttri;
//  end;
//
//  procedure Register;
//
//implementation
//  procedure Register;
//  begin
//    {$I mi.template.highlighter_icon.lrs}
//    RegisterComponents('Mi.Lcl',[TMi_Template_Highlighter]);
//  end;
//
//constructor TMi_Template_Highlighter .Create(AOwner: TComponent);
//begin
//  inherited Create(AOwner);
//
//  FLabelAttri := TSynHighlighterAttributes.Create('Label');
//  FLabelAttri.Foreground := clBlue;
//  AddAttribute(FLabelAttri);
//
//  FEditableAttri := TSynHighlighterAttributes.Create('Editable');
//  FEditableAttri.Foreground := clGreen;
//  AddAttribute(FEditableAttri);
//
//  SetAttributesOnChange(@DefHighlightChange);
//end;
//
//procedure TMi_Template_Highlighter .SetLine(const NewValue: string; LineNumber: Integer);
//begin
//  fLine := NewValue;
//  Run := 1;
//  Next;
//end;
//
//procedure TMi_Template_Highlighter .Next;
//begin
//  fTokenPos := Run;
//
//  if Run > Length(fLine) then
//    Exit;
//
//  case fLine[Run] of
//    '~': fRange := rsUnknown; // Modify this according to your parsing logic
//    '\': fRange := rsUnknown; // Modify this according to your parsing logic
//  else
//    fRange := rsUnknown; // Default case
//  end;
//
//  Inc(Run);
//end;
//
//function TMi_Template_Highlighter .GetTokenAttribute: TSynHighlighterAttributes;
//begin
//  case fRange of
//    rsUnknown: Result := FLabelAttri; // Modify this according to your logic
//  else
//    Result := FEditableAttri;
//  end;
//end;
//
//function TMi_Template_Highlighter .GetTokenKind: integer;
//begin
//  Result := Ord(fRange);
//end;
//
//function TMi_Template_Highlighter .GetTokenPos: Integer;
//begin
//  Result := fTokenPos;
//end;
//
//function TMi_Template_Highlighter .GetEol: Boolean;
//begin
//  Result := Run > Length(fLine);
//end;
//
//function TMi_Template_Highlighter .GetRange: Pointer;
//begin
//  Result := Pointer(PtrInt(fRange));  // Convertendo TRangeState para Pointer
//end;
//
//procedure TMi_Template_Highlighter .SetRange(Value: Pointer);
//begin
//  fRange := TRangeState(PtrInt(Value));  // Convertendo Pointer de volta para TRangeState
//end;
//
//procedure TMi_Template_Highlighter .ResetRange;
//begin
//  fRange := rsUnknown;
//end;
//
//function TMi_Template_Highlighter .GetSampleSource: string;
//begin
//  Result := '~Nome do Aluno:~\sssssssssssssss';
//end;
//
//procedure TMi_Template_Highlighter .GetTokenEx(out TokenStart: PChar; out TokenLength: integer);
//begin
//  TokenStart := PChar(@fLine[Run]);
//  TokenLength := Run - fTokenPos;
//end;
//
//end.

--------------

//{$mode objfpc}{$H+}
//
//interface
//
//uses
//  Classes, SysUtils, Graphics, SynEditTypes, SynEditHighlighter,LResources;
//
//type
//  TRangeState = (rsUnknown, rsLabel, rsEditable);
//
//  TTokenKind = (tkUnknown, tkLabel, tkEditable, tkSymbol, tkNull);
//
//  { TMi_Template_Highlighter }
//
//  TMi_Template_Highlighter = class(TSynCustomHighlighter)
//  private
//    fRange: TRangeState;
//    fTokenKind: TTokenKind;
//    fTokenPos: Integer;
//    fToken: string;
//    fLineText: string;
//    fLineNumber: Integer;
//    fLabelAttri: TSynHighlighterAttributes;
//    fEditableAttri: TSynHighlighterAttributes;
//    fSymbolAttri: TSynHighlighterAttributes;
//  protected
//    function GetSampleSource: string; override;
//    function GetTokenID: TTokenKind;
//    procedure SetLine(const NewValue: string; LineNumber: Integer); override;
//  public
//    constructor Create(AOwner: TComponent); override;
//    function GetDefaultAttribute(Index: Integer): TSynHighlighterAttributes; override;
//    function GetEol: Boolean; override;
//    function GetRange: Pointer; override;
//    function GetToken: string; override;
//    procedure GetTokenEx(out TokenStart: PChar; out TokenLength: integer);override;
//    function GetTokenAttribute: TSynHighlighterAttributes; override;
//    function GetTokenKind: Integer; override;
//    function GetTokenPos: Integer; override;
//    procedure Next; override;
//    procedure SetRange(Value: Pointer); override;
//    procedure ResetRange; override;
//  published
//    property LabelAttri: TSynHighlighterAttributes read fLabelAttri write fLabelAttri;
//    property EditableAttri: TSynHighlighterAttributes read fEditableAttri write fEditableAttri;
//    property SymbolAttri: TSynHighlighterAttributes read fSymbolAttri write fSymbolAttri;
//  end;
//
//procedure Register;
//
//implementation
//procedure Register;
//begin
//  {$I mi.template.highlighter_icon.lrs}
//  RegisterComponents('Mi.Lcl',[TMi_Template_Highlighter]);
//end;
//
//constructor TMi_Template_Highlighter.Create(AOwner: TComponent);
//begin
//  inherited Create(AOwner);
//
//  fLabelAttri := TSynHighlighterAttributes.Create('Label');
//  fLabelAttri.Foreground := clBlue;
//  AddAttribute(fLabelAttri);
//
//  fEditableAttri := TSynHighlighterAttributes.Create('Editable');
//  fEditableAttri.Foreground := clGreen;
//  AddAttribute(fEditableAttri);
//
//  fSymbolAttri := TSynHighlighterAttributes.Create('Symbol');
//  fSymbolAttri.Foreground := clRed;
//  AddAttribute(fSymbolAttri);
//
//  SetAttributesOnChange(@DefHighlightChange);
//  fRange := rsUnknown;
//end;
//
//procedure TMi_Template_Highlighter.SetLine(const NewValue: string; LineNumber: Integer);
//begin
//  inherited;
//  fLineText := NewValue;
//  fLineNumber := LineNumber;
//  fTokenPos := 0;
//  Next;
//end;
//
//procedure TMi_Template_Highlighter.Next;
//begin
//  fToken := '';
//  while (fTokenPos <= Length(fLineText)) and (fLineText[fTokenPos] in [#32, #9]) do
//    Inc(fTokenPos);
//
//  if fTokenPos > Length(fLineText) then
//  begin
//    fTokenKind := tkNull;
//    Exit;
//  end;
//
//  case fLineText[fTokenPos] of
//    '~':
//      begin
//        fToken := '~';
//        Inc(fTokenPos);
//        fTokenKind := tkLabel;
//        fRange := rsLabel;
//      end;
//    '\':
//      begin
//        fToken := '\';
//        Inc(fTokenPos);
//        fTokenKind := tkEditable;
//        fRange := rsEditable;
//      end;
//    else
//      begin
//        fToken := fLineText[fTokenPos];
//        Inc(fTokenPos);
//        fTokenKind := tkSymbol;
//      end;
//  end;
//end;
//
//function TMi_Template_Highlighter.GetSampleSource: string;
//begin
//  Result := '~Nome do Aluno:~\sssssssssssssss';
//end;
//
//function TMi_Template_Highlighter.GetTokenID: TTokenKind;
//begin
//  Result := fTokenKind;
//end;
//
//function TMi_Template_Highlighter.GetDefaultAttribute(Index: Integer): TSynHighlighterAttributes;
//begin
//  case Index of
//    SYN_ATTR_COMMENT: Result := fLabelAttri;
//    SYN_ATTR_IDENTIFIER: Result := fEditableAttri;
//    SYN_ATTR_KEYWORD: Result := fLabelAttri;
//    SYN_ATTR_STRING: Result := fEditableAttri;
//    SYN_ATTR_SYMBOL: Result := fSymbolAttri;
//    else
//      Result := nil;
//  end;
//end;
//
//function TMi_Template_Highlighter.GetEol: Boolean;
//begin
//  Result := fTokenPos > Length(fLineText);
//end;
//
//function TMi_Template_Highlighter.GetRange: Pointer;
//begin
//  Result := Pointer(PtrInt(fRange));
//end;
//
//function TMi_Template_Highlighter.GetToken: string;
//begin
//  Result := fToken;
//end;
//
//procedure TMi_Template_Highlighter.GetTokenEx(out TokenStart: PChar; out
//  TokenLength: integer);
//
//begin
//  TokenStart := PChar(fLine + Run);
//  TokenLength := fTokenPos - Run;
//end;
//
//function TMi_Template_Highlighter.GetTokenAttribute: TSynHighlighterAttributes;
//begin
//  case fTokenKind of
//    tkLabel: Result := fLabelAttri;
//    tkEditable: Result := fEditableAttri;
//    tkSymbol: Result := fSymbolAttri;
//    else
//      Result := nil;
//  end;
//end;
//
//function TMi_Template_Highlighter.GetTokenKind: Integer;
//begin
//  Result := Ord(fTokenKind);
//end;
//
//function TMi_Template_Highlighter.GetTokenPos: Integer;
//begin
//  Result := fTokenPos;
//end;
//
//procedure TMi_Template_Highlighter.SetRange(Value: Pointer);
//begin
//  fRange := TRangeState(PtrInt(Value));
//end;
//
//procedure TMi_Template_Highlighter.ResetRange;
//begin
//  fRange := rsUnknown;
//end;
//
//end.


//uses
//
//  SysUtils, Classes, Graphics, SynEditHighlighter, SynEditTypes; //, SynUnicode
//
//
//
//
//type
//  TtkTokenKind = (tkLabel, tkEditable, tkText, tkUnknown);
//  TRangeState = (rsUnknown);
//
//  TMi_Template_Highlighter = class(TSynCustomHighlighter)
//    private
//      fTokenID: TtkTokenKind;
//      fRange: TRangeState;
//      fLine: PChar;
//      fTokenPos: Integer;
//      fTokenLength: Integer;
//    protected
//      function GetSampleSource: UnicodeString; override;
//      function GetTokenID: TtkTokenKind;
//    public
//      constructor Create(AOwner: TComponent); override;
//      function GetToken: UnicodeString; override;
//      function GetTokenAttribute: TSynHighlighterAttributes; override;
//      function GetTokenKind: integer; override;
//      function GetTokenPos: Integer; override;
//      procedure Next; override;
//      function GetEol: Boolean; override;
//      function GetRange: Pointer; override;
//      procedure SetRange(Value: Pointer); override;
//      procedure ResetRange; override;
//    published
//      property LabelAttri: TSynHighlighterAttributes read FLabelAttri write FLabelAttri;
//      property EditableAttri: TSynHighlighterAttributes read FEditableAttri write FEditableAttri;
//      property TextAttri: TSynHighlighterAttributes read FTextAttri write FTextAttri;
//    end;
//
//
//procedure Register;
//
//implementation
//
//procedure Register;
//begin
//  {$I mi.template.highlighter_icon.lrs}
//  RegisterComponents('Mi.Lcl',[TMi_Template_Highlighter]);
//end;
//
//procedure Register;
//begin
//  RegisterComponents('SynEdit', [TMi_Template_Highlighter]);
//end;
//
//constructor TMi_Template_Highlighter.Create(AOwner: TComponent);
//begin
//  inherited Create(AOwner);
//  // Inicializa os atributos de realce
//  FLabelAttri := TSynHighlighterAttributes.Create('Label');
//  FLabelAttri.Foreground := clBlue;
//  FLabelAttri.Style := [fsBold];
//  AddAttribute(FLabelAttri);
//
//  FEditableAttri := TSynHighlighterAttributes.Create('Editable');
//  FEditableAttri.Foreground := clGreen;
//  AddAttribute(FEditableAttri);
//
//  FTextAttri := TSynHighlighterAttributes.Create('Text');
//  FTextAttri.Foreground := clBlack;
//  AddAttribute(FTextAttri);
//
//  SetAttributesOnChange(@DefHighlightChange);
//end;
//
//function TMi_Template_Highlighter.GetTokenID: TtkTokenKind;
//begin
//  case fLine[fTokenPos] of
//    '~': Result := tkLabel;
//    '\': Result := tkEditable;
//    else Result := tkText;
//  end;
//end;
//
//procedure TMi_Template_Highlighter.Next;
//begin
//  fTokenPos := Run;
//
//  case fLine[Run] of
//    '~':
//      begin
//        fTokenID := tkLabel;
//        Inc(Run);
//        while not (fLine[Run] in ['~', #0]) do
//          Inc(Run);
//        if fLine[Run] = '~' then
//          Inc(Run);
//      end;
//    '\':
//      begin
//        fTokenID := tkEditable;
//        Inc(Run);
//        while (fLine[Run] = 's') do
//          Inc(Run);
//      end;
//    else
//      begin
//        fTokenID := tkText;
//        while not (fLine[Run] in ['~', '\', #0]) do
//          Inc(Run);
//      end;
//  end;
//
//  fTokenLength := Run - fTokenPos;
//end;
//
//function TMi_Template_Highlighter.GetToken: UnicodeString;
//begin
//  SetString(Result, (fLine + fTokenPos), fTokenLength);
//end;
//
//function TMi_Template_Highlighter.GetTokenAttribute: TSynHighlighterAttributes;
//begin
//  case GetTokenID of
//    tkLabel: Result := FLabelAttri;
//    tkEditable: Result := FEditableAttri;
//    tkText: Result := FTextAttri;
//    else Result := nil;
//  end;
//end;
//
//function TMi_Template_Highlighter.GetTokenKind: Integer;
//begin
//  Result := Ord(fTokenID);
//end;
//
//function TMi_Template_Highlighter.GetTokenPos: Integer;
//begin
//  Result := fTokenPos;
//end;
//
//function TMi_Template_Highlighter.GetEol: Boolean;
//begin
//  Result := fLine[Run] = #0;
//end;
//
//function TMi_Template_Highlighter.GetRange: Pointer;
//begin
//  Result := Pointer(fRange);
//end;
//
//procedure TMi_Template_Highlighter.SetRange(Value: Pointer);
//begin
//  fRange := TRangeState(Value);
//end;
//
//procedure TMi_Template_Highlighter.ResetRange;
//begin
//  fRange := rsUnknown;
//end;
//
//function TMi_Template_Highlighter.GetSampleSource: UnicodeString;
//begin
//  Result := '~Nome do Aluno:~\sssssssssssssss'; // Exemplo de código
//end;
//
//end.
