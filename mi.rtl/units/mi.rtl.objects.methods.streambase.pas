unit mi.rtl.Objects.Methods.StreamBase;
{:< - A unit **@name** implementa a classe TStreamBase do pacote **mi.rtl**.

  - **NOTAS**
    - O Use da classe @name não deve ser instanciada antes de implementar os métodos abstratos;

  - **VERSÃO**
    - Alpha - 0.8.0

  - **HISTÓRICO**
    - Criado por: Paulo Sérgio da Silva Pacheco e-mail: paulosspacheco@@yahoo.com.br
      - **19/11/2021** 21:25 a 23:15 Criar a unit mi.rtl.objects.methods.StreamBase.pas
      - **20/11/2021** 14:02 a 15:19 Documentação da classe e agrupar métodos virtuais, métodos
                                     não virtuais e proteger os métodos abstratos. 
  - **CÓDIGO FONTE**:
    - @html(<a href="../units/mi.rtl.objects.methods.StreamBase.pas">mi.rtl.objects.methods.StreamBase.pas</a>)

}

{$IFDEF FPC}
  {$MODE Delphi} {$H+}
{$ENDIF}


interface

uses
  Classes, SysUtils
  ,mi.rtl.types
  ,mi.rtl.objects.Methods
  ;


  //TStreambase = Class (TNSComponent {TClass})
  {: - A class **@name** é uma classe abstrata para implementação de streams.
  }
  type
  TStreamBase =
  class(TObjectsMethods)

    //Atributos public
        public Status    : Integer;   {:< Stream status }
//        public ErrorInfo : Integer;   {:< Stream error info } Transferido para Consts
        public StreamSize: int64;   {:< Stream current size }
        public Position  : Int64;   {:< Current position }
        public Alias     : AnsiString;

      public constructor Create; overload;virtual;
      Public destructor Destroy;Override;

    //Método Protected virtuais
      protected procedure Open;overload;                            Virtual;
      public procedure Close;                                     Virtual;
      protected procedure Rewrite; Overload;                         Virtual;
      protected procedure Flush;                                     Virtual;
      protected procedure Truncate;Overload;                         Virtual;
      protected procedure Read (Var Buf; Count: Sw_Word); Overload;  Virtual;
      public procedure Write (Var Buf; Count: Sw_Word);Overload;  Virtual;

    //Métodos Public  não virtuais
      public function ReadStr: ptstring;
      public function Get: TClass;
      public function StrRead: PAnsiChar;
      public procedure Put (P: TClass);
      public procedure StrWrite (P: PAnsiChar);
      public procedure WriteStr (P: ptstring);
      public procedure CopyFrom (Var S: TStreamBase; Count: LongInt);


    //Métodos Public  virtuais
      public function GetPos: LongInt;                                      Virtual;
      public function GetSize: LongInt;                                     Virtual;
      public procedure Reset; Overload;                                     Virtual;

      public procedure Seek (Pos: LongInt);overload;                        Virtual;
      Public procedure Seek(NR: LongInt;a_RecSize:Longint);Overload;        Virtual;

      public procedure Error (Code, Info: Integer);                         Virtual;

      Public function GetDriveType:TDriveType;overload;virtual;


  END;

implementation


  constructor TStreamBase.Create;
  Begin
    Inherited Create(nil);
    Alias := Self.ClassName;
  end;

  destructor TStreamBase.Destroy;
  Begin
    Inherited Destroy;
  End;

  function TStreamBase.Get: TClass;
    TYPE LoadPtr = function (Var S: TStreamBase; Link: Sw_Word; Iv: Pointer): TClass;
    VAR ObjType : Sw_Word; P: pStreamRec;
  BEGIN
     Read(ObjType, SizeOf(ObjType));                    { Read Class type }

     If (ObjType <> 0) Then
     Begin                       { Class registered }
       P := StreamTypes;                                { Current reg list }

       While (P <> Nil) AND (P^.ObjType <> ObjType)     { Find Class type OR }
       Do P := P^.Next;                                 { Find end of chain }

       If (P = Nil) Then Begin                          { Not registered }
         Error(stGetError, ObjType);                    { Obj not registered }
         Get := Nil;                                    { Return nil pointer }
       End Else
  (*       {$IFDEF BP_VMTLink}                            { BP like VMT link }
             Get := LoadPtr(P^.Load)(Self, P^.VMTLink, Nil) { Call constructor }
         {$ELSE}                                                     { FPC/DELPHI VMT link }
         *)
  //         Get := LoadPtr(P^.Load)(Self,Sw_Word(P^.VMTLink{^}), Nil) { Call constructor }

         {ENDIF}
     End
     Else Get := Nil;                               { Return nil pointer }
  END;

  function TStreamBase.StrRead: PAnsiChar;
    VAR W: Word;
    VAR P: PAnsiChar;
  BEGIN
     Read(W, SizeOf(W));                                { Read string length }
     If (W = 0) Then StrRead := Nil Else Begin          { Check for empty }
       GetMem(P, W + 1);                                { Allocate memory }
       If (P <> Nil) Then Begin                         { Check allocate okay }
         Read(P[0], W);                                 { Read the data }
         P[W] := #0;                                    { Terminate with #0 }
       End;
       StrRead := P;                                    { PAnsiChar returned }
     End;
  END;

  function TStreamBase.ReadStr: ptstring;
    VAR B: Byte;
    VAR P: ptstring;
  BEGIN
     Read(B, 1);                                        { Read string length }
     If (B > 0) Then Begin
       GetMem(P, B + 1);                                { Allocate memory }
       If (P <> Nil) Then Begin                         { Check allocate okay }
         {$IFDEF PPC_DELPHI3}                           { DELPHI 3 COMPILER }
         SetLength(P^, B);                              { Hold new length }
         {$ELSE}
         P^[0] := Chr(B);                               { Hold new length }
         {$ENDIF}
         Read(P^[1], B);                                { Read string data }
       End;
       ReadStr := P;                                    { Return string ptr }
     End Else ReadStr := Nil;
  END;

  function TStreamBase.GetPos: LongInt;
  BEGIN
    If (Status = stOk) Then GetPos := Position         { Return position }
    Else GetPos := -1;                                 { Stream in error }
  END;

  function TStreamBase.GetSize: LongInt;
  BEGIN
     If (Status = stOk) Then GetSize := StreamSize      { Return stream size }
     Else GetSize := -1;                                { Stream in error }
  END;

  procedure TStreamBase.Close;
  BEGIN
    abstracts;                            { Abstract error }
  END;

  procedure TStreamBase.Reset;
  BEGIN
     Status := 0;                                       { Clear status }
     ErrorInfo := 0;                                    { Clear error info }
  END;

  procedure TStreamBase.Rewrite;
  Begin
     Status := 0;                                       { Clear status }
     ErrorInfo := 0;                                    { Clear error info }
  end;

  procedure TStreamBase.Flush;
  BEGIN
     abstracts;{ Abstract method }
  END;

  procedure TStreamBase.Truncate;
  BEGIN
     Abstracts;                                          { Abstract error }
  END;

  procedure TStreamBase.Put (P: TClass);

    TYPE StorePtr = procedure (Var S: TStreamBase; AnClass: TClass);
    VAR
      ObjType: Sw_Word;
      Link   : Sw_Word;
      Q      : pStreamRec;
      VmtPtr : ^Sw_Word;
      //  S      : TStreamBase;

  BEGIN
     VmtPtr := Pointer(P);                              { Xfer Class to ptr }
     Link   := VmtPtr^;                                 { VMT link }

     ObjType := 0;                                      { Set objtype to zero }
     If (P <> Nil) AND (Link <> 0) Then Begin           { We have a VMT link }
       Q := StreamTypes;                                { Current reg list }

   //    While (Q <> Nil) AND (Sw_Word(Q^.VMTLink{^}) <> Link) { Find link match OR }
  //     Do Q := Q^.Next;                               { Find end of chain }

       If (Q = Nil) Then Begin                          { End of chain found }
         Error(stPutError, 0);                          { Not registered error }
         Exit;                                          { Now exit }
       End Else ObjType := Q^.ObjType;                  { Update Class type }
     End;

     Write(ObjType, SizeOf(ObjType));                   { Write Class type }


     If (ObjType <> 0) and (Q<>nil) Then                { Registered Class }
       StorePtr(Q^.Store)(Self, P);                     { Store Class }
  END;

  procedure TStreamBase.Seek (Pos: LongInt);
  BEGIN
     If (Status = stOk) Then Begin                      { Check status }
       If (Pos < 0) Then Pos := 0;                      { Remove negatives }
       If (Pos <= StreamSize) and (Pos >= 0)
       Then Position := Pos                             { If valid set pos }
       Else Error(stSeekError,Seek_fora_da_faixa_do_arquivo {Pos});  { Position error }
     End;
  END;

  procedure TStreamBase.Seek(NR: LongInt;a_RecSize:Longint);Overload;
  begin
    Abstracts;
  end;

  procedure TStreamBase.StrWrite (P: PAnsiChar);
    VAR
      W: Word;
      Q: PByteArray;
  BEGIN
     W := 0;                                            { Preset zero size }
     Q := PByteArray(P);                                { Transfer type }
     If (Q <> Nil) Then While (Q^[W] <> 0) Do Inc(W);   { PAnsiChar length }
     Write(W, SizeOf(W));                               { Store length }
     If (P <> Nil) Then Write(P[0], W);                 { Write data }
  END;

  procedure TStreamBase.WriteStr (P: ptstring);

    CONST Empty : String[1] = '';

  BEGIN
     If (P <> Nil) Then Write(P^, Length(P^) + 1)       { Write string }
     Else Write(Empty, 1);                            { Write empty string }
  END;

  procedure TStreamBase.Open;
  BEGIN
     abstracts;{ Abstract method }
  END;

  procedure TStreamBase.Error (Code, Info: Integer);
//    TYPE TErrorProc = procedure (Var S: TStreamBase);
  BEGIN
     Status := Code;                                    { Hold error code }
     ErrorInfo := Info;                                 { Hold error info }
     TaStatus := ErrorInfo;

  //   If (StreamError <> Nil) Then
  //     TErrorProc(StreamError)(Self);                   { Call error ptr }
  END;

  procedure TStreamBase.Read (Var Buf; Count: Sw_Word);
  BEGIN
     abstracts;                  { Abstract error }
  END;

  procedure TStreamBase.Write (Var Buf; Count: Sw_Word);
  BEGIN
     abstracts;           { Abstract error }
  END;

  procedure TStreamBase.CopyFrom (Var S: TStreamBase; Count: LongInt);
    VAR
      W: Word;
      Buffer: Array[0..1023] of Byte;
  BEGIN
  {  S.Seek(0); Nao posso usar o seek porque CopyFrom pode ser usado para copiar blocos de bytes}
    Error(S.Status,S.ErrorInfo);
    While (Status=StOk) and (Count > 0) Do Begin
       If (Count > SizeOf(Buffer)) Then                 { To much data }
         W := SizeOf(Buffer) Else W := Count;           { Size to transfer }

       S.Read(Buffer, W);                               { Read from stream }
       If S.Status <> StOk
       Then Error(S.Status,S.ErrorInfo);

       Write(Buffer, W);                                { Write to stream }
       Dec(Count, W);                                   { Dec write count }
     End;
  END;

  function TStreamBase.GetDriveType:TDriveType;
  Begin
    Result := dt_Memory_Stream;
  end;

end.

