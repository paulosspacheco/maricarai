unit mi.rtl.Class_Of_Char;

{$H+}
{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}


interface

uses
  Classes, SysUtils
  ;

  type
   {: A class **@name** é usada na tabela de caracter para conversão das letras com acentos}
   TClass_Of_Char = Class(TObject)
                      Public Constructor Create(aAsc_Ingles       : AnsiChar;

                                                aAsc_GUI          : AnsiString;
                                                aAsc_HTML         : AnsiString);

                     //Propriedade Asc_Ingles
                     Private _Asc_Ingles  : AnsiChar;
                     Public  Property Asc_Ingles  : AnsiChar       Read _Asc_Ingles;


                     //Propriedade Asc_GUI
                     Private _Asc_GUI            : AnsiString;
                     Public Property Asc_GUI     : AnsiString       Read _Asc_GUI;

                     //Propriedade Asc_HTML
                     Private _Asc_HTML    : AnsiString;
                     public Property Asc_HTML    : AnsiString Read _Asc_HTML;


                   End;

implementation

  Constructor TClass_Of_Char.Create( aAsc_Ingles  : AnsiChar;
                                     aAsc_GUI     : AnsiString;
                                     aAsc_HTML    : AnsiString);
  Begin
    Inherited Create;
    _Asc_Ingles  := aAsc_Ingles;
    _Asc_GUI     := aAsc_GUI;
    _Asc_HTML    := aAsc_HTML;
  end;


end.

