unit mi.rtl.objects.Methods.dates;
 {:< -A Unit **@name** implementa a classe **TDates**.

    - **VERSÃO**
      - Alpha - 0.7.1

    - **CÓDIGO FONTE**:
      - @html(<a href="../units/mi.rtl.objects.Methods.dates.pas">mi.rtl.objects.Methods.dates.pas</a>)


    - **HISTÓRICO**
      - Criado por: Paulo Sérgio da Silva Pacheco e-mail: paulosspacheco@@yahoo.com.br
        - **27/01/99 05:12 a 08:00** - Retirei do Db_Generic e Db_Global todas as rotinas com referência a datas.
        - **27/01/99 09:05 a 09:30** - Debugar as rotinas de datas utilizando o ano 2000.
        - **27/01/99 09:30 a      ** - Todos os relatórios que necessitam de datas de início e fim do período devem
                                       ser inicializadas com as datas mínimas e máximas.
        - **15/12/21 13:50 a 14:30** - Criar classe mi.rtl.objects.Methods.dates.Tdates e adicionar as rotinas de datas do passado.

  }

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}


interface
Uses
  Classes,SysUtils,DateUtils,dos
  ,mi.rtl.objects.Methods
  ,mi.rtl.objects.consts.MI_MsgBox

  ;

{: - A classe **@name** contém todas os métodos necessários para acessar data no formato de 3 bytes.

   - NOTA**
     - Formato de data e hora tratado por essa classe:
       - type TypeData = Record dia:byte;mes:Byte;ano : byte; End;
       - type TipoHora = record H,M,S,S100 : Word; end;
       - Type TData_e_Hora_Compactada = Longint;
}
type
  TDates = class(TObjectsMethods)
    public type TypeData  = Record dia:byte;mes:Byte;ano : byte; End;
    public type PTypeData = ^TypeData;

    public const AnoLimit : Byte = 30; //1930 a 2030

    private const _AnoLimit = 30;
    public  const DataMinima : TypeData = (dia:1;mes:1  ;ano:_AnoLimit);
    public  const DataMaxima : TypeData = (dia:31;mes:12;ano:_AnoLimit-1);


    public type TipoHora = record
                             H,M,S,S100 : SmallWord;
                           end;

    public type TVarGetDate = Record Dia,Mes,Ano,DiaDaSemana : SmallWord;  end;
    public type TVarGetTime = record Hora,Minuto,Segundo,S100 : SmallWord; end;
    public Type TDateMask = (DateMask_AA_MM_DD,
                              DateMask_AAAA_MM_DD,
                              DateMask_DD_MM_AA,// DD/MM/AA
                              DateMask_DDMMAA, // DDMMAA
                              DateMask_DD_MM_AAAA,
                              DateMask_MM_AA,
                              DateMask_MM_AAAA,
                              DateMask_NomeMM_AA,
                              DateMask_NomeMM_AAAA,

                              DateMask_MM_NomeMM,
                              DateMask_MM_NomeMM_AA,
                              DateMask_MM_NomeMM_AAAA,
                              DateMask_Extenco,

                              DateMask_DD_MM_AA_HH_MM_SS,   // DD/MM/AA HH:MM:SS
                              DateMask_DDMMAAHHMMSS,        // DDMMAAHHMMSS

                              DateMask_DD_MM_AA_HH_MM,      // DD/MM/AA HH:MM
                              DateMask_DDMMAAHHMM,          // DDMMAAHHMM

                              DateMask_DD_MM_AAAA_HH_MM_SS,  // DD/MM/AAAA HH:MM:SS
                              DateMask_DDMMAAAAHHMMSS,       // DD/MM/AAAA HH:MM:SS

                              DateMask_AAAAMMDDHHMMSS        // AAAAMMDDHHMMSS

                              );
    public type THourMask = (HourMask_HH_MM ,
                             HourMask_HH_MM_SS,
                             HourMask_HH_MM_SS_S100);

    public type TMeses = (MesNulo,
                          Janeiro,
                          Fevereiro,
                          Marco,
                          Abril,
                          Maio,
                          Junho,
                          Julho,
                          Agosto,
                          Setembro,
                          Outubro,
                          Novembro,
                          Dezembro);
    public const ArrayStrMeses : Array[TMeses] of string = ('',
                                                            'Janeiro',
                                                            'Fevereiro',
                                                            'Marco',
                                                            'Abril',
                                                            'Maio',
                                                            'Junho',
                                                            'Julho',
                                                            'Agosto',
                                                            'Setembro',
                                                            'Outubro',
                                                            'Novembro',
                                                            'Dezembro');


    public Const StrDiaSemana  : Array[0..6] of String[7] = ('Sabado ',
                                                             'Domingo',
                                                             'Segunda',
                                                             'Terca  ',
                                                             'Quarta ',
                                                             'Quinta ',
                                                             'Sexta  ');

    public const HoraInicial : TipoHora = (H    : 0; {< Usado em EscrevaTempoEstimado do indice }
                                           M    : 0; {< Onde HoraInicialAux hora transcorrida  }
                                           S    : 0; {< entre o inicio da indexacao e a atual}
                                           S100 : 0 );

    public DataSistOp : TypeData; static;//Record DiaSo,MesSo,AnoSo : Byte End;
    public TempData   : TypeData; static; {Data usada no retorno de chamadas de funcoes que retornam datas}

    class function juliano(d,m,a : SmallInt) : TRealNum;

    class function DifeData(diaAtual, mesAtual, anoAtual,diaAnterior   , mesAnterior   ,  anoAnterior  : byte  ) :Longint;Overload;
    class function DifeData(Const DAntBuff,DAtuBuff:TypeData) : Longint;Overload;
    class function DifeData(Const DatAnterior:TypeData;Const DatAtual : TypeData;
                      Const Operador:AnsiChar;
                      Const operando : Longint) : Boolean;Overload;

    class procedure somaData(var dia,mes:Byte; Var ano : SmallInt ; diasAsomar : Integer); Overload;
    class procedure somaData(var dia,mes,ano : byte ; diasAsomar : Integer);Overload;
    class procedure SomaData(Var Buff:TypeData;Prazo: Integer) ;Overload;
    class function FSomaData(Buff:TypeData;Prazo: Integer):TString ;Overload;

    class procedure SomaDataEmMeses(Const DataFont : TypeData;
                              Const Meses    : SmallInt;
                              Var   DataDest : TypeData);


    class procedure SomeDataPara(Const Buff1:TypeData;Var Buff2:TypeData ;Const Prazo: Integer) ;

    class function Dtjuliana(Var Buff) : TRealNum;
    class procedure moveData(var
                         dataFonte,
                         dataDestino);
    class function ConvNomeData (Const NomeArqFonte     :String;
                                 NomeArqDestino : String;
                           Const Mes,Ano        : Byte;
                           var
                             Mensagem     : String ) : String;
    class function StrDataMesAno(Const mes,Ano:byte) : String;
    class function DiaMaxDoMes(Const Mes : Byte;Ano : Integer) : Byte;
    class function FDiaSemana (Var BuffData) : Byte;
    class function FStrDiaSemana   (Var data ) : String;
    class function StrMes(Const mes : Word ) : String;
    class function StrData(Const Dia,mes,ano: Word ; Const ch :AnsiChar) : string;
    class function StringData(Const Buff :TypeData;Const Ch : AnsiChar) : String;

    class function GetDataSistOp(Var Buff;const Separador:AnsiChar{Pode Ser: '/',':',' '}):String;
    class function FGetDataSistOp(const Separador:AnsiChar{Pode Ser: '/',':',' '}):String;
    class function GetDateSystem(const DateMask:TDateMask):String;
    class function GetHourSystem(const HourMask :THourMask):String;


    {Funcoes a seguir sao usadas para atualiza o tempo dos registro de dados}
    {------------------------------------------------------------------------}
    class function GetFTimeDos:Longint;Overload; {Devolve a data do Systema operacional compactado}
    class function GetFTimeDos(Var wSec1000:SmallInt):Longint;Overload; {Data da atualizacao}
    class function GetFTimeDos(Var wSec100:Byte;Var wSec1000:SmallInt):Longint;Overload; {Data da atualizacao}

    class function GetFTimeDos_Valid(aTime_UltimoAcesso:Longint;aMinutos_de_tolerancia_do_Ultimo_Acesso:byte):Boolean;

    class function PackDate(Const Data:TypeData):Longint;Overload;
    class function PackDate(Const Data:String; Const Mask: TDateMask):Longint;Overload;
    class function PackDate(Const Data:String; Const Mask: TDateMask; TimePack:Longint):Longint;Overload;

    class function PackHour(Const Hora:String; Const Mask: THourMask; TimePack:Longint):Longint;Overload;

    class function UnPackDate(Const TimePack:Longint):TypeData;

    class procedure UnPackHora(Const TimePack:Longint;Var Hora : TipoHora);
    class procedure PackHora  (Const Hora : TipoHora; Var TimePack:Longint);

    class procedure PackDateHora(Data:TypeData;
                           Hora :TipoHora;
                           Var TimePack:Longint);
    class procedure UnPackDateHora(Const TimePack:Longint;
                             Var Data:TypeData;
                             Var Hora :TipoHora);

    class function StringTimeD(Const TimePack:Longint;Const Ch : AnsiChar) : String;
    class function StringTimeH(Const TimePack:Longint) : String;
    class function StringTimeHSemPonto(Const TimePack:Longint) : String;

    class function FIncAno(Ano:SmallInt) : Byte;
    class function FDecAno(Ano:SmallInt) : Byte;
    class function FAno(Ano:SmallWord) : SmallWord;
    class function FAno2Digito(Ano : SmallWord):Byte;
    class function FAnoDoIndex(Const Dia,Ano : byte):String;
    class function StrAno(ano : SmallInt ) : String;

    class function StrToDate(aStrDate:String; Const Mask: TDateMask):PTypeData;

    class function DateToStr(Const aDate:TypeData;Const Mask: TDateMask) : String;Overload;
    class function DateToStr(Const aDate:Longint;Const Mask: TDateMask) : String;Overload;

    class function DateToDateTime(aDate:TypeData): System.TDateTime;Overload;
    class function DateToDateTime(aTimePack:Longint):System.TDateTime;Overload;


    class function DateTimeToDate(aDateTime:TDateTime):TypeData;Overload;
    class function DateTimeToDateStr(aDateTime:TDateTime):String;Overload;
    class function DateTimeToTimeStr(aDateTime:TDateTime):String;
    class function DateTimeToDateTimeDos(aDateTime:TDateTime):Longint;Overload;
    class function DateTimeDosToStr(aTimePack:Longint;Mask:TDateMask):String;

    class function StrToDateTime(aDataTime:String;Mask:TDateMask):TDateTime;Overload;
    class function StrToDateTimeDos(aDataTime:String;Mask:TDateMask):Longint;Overload;

    class function StrToHora( aStrHora:String; Const Mask: THourMask):TipoHora;
    class function StrToHour(Const aStrHora:String; Const Mask: THourMask):Longint;Overload;
    class function StrToHour(Const aStrHora:String; Const Mask: THourMask;TimePack:Longint):Longint;Overload;

    class function HourToStr(Const aStrHora:Longint; Const Mask: THourMask;Const OkSpc : Boolean):String;Overload;
    class function HourToStr(Const Hora:TipoHora; Const Mask: THourMask;Const OkSpc : Boolean):String;   Overload;

    class function HourToDateTime(Const aTimePack:Longint): TDateTime;Overload;

    class function str2jul  (DateStr:string): longint;
    class function jul2str  (JulDate:longint) :string;
    class function  Julian  ( Year, Month, Day : Word ) : LongInt;
    class function LeapYear ( Year : Word ) : Boolean ;


    class function DiaMaxMes(Const DataAtual :TypeData) : byte;

    class function DateMask_to_Str(Const aDateMask : TDateMask ):String;
    class function Str_to_DateMask(aStrDate:String):TDateMask;

    class function HourMask_to_Str(Const aHourMask : THourMask ):String;
    //class procedure SetDataAtual(Var Data );

    class function ValidDate( aData : TypeData):Byte;
    class function ValidHour( H,M,S,S100 : Word):Byte;

    //class procedure DifHora(Const HAtu,HAnt : TipoHora ; Var HDif    : TipoHora  );
    class function DifHoraEmSegundos(Const HAtu,HAnt : TipoHora ):Longint;
    class function DifHora_Retorne_TipoHora(Const HAtu,HAnt : TipoHora ):TipoHora;Overload;
    class function DifHora_Retorne_TipoHora(Const HAtu,HAnt : Longint  ):TipoHora;Overload;

    class function DifHora_Retorne_Horas_Fracao(const HAtu,HAnt : TipoHora  ):Double;Overload;
    class function DifHora_Retorne_Horas_Fracao(const HAtu,HAnt : Longint  ):Double;Overload;

    class function DifHora_Retorne_Minutos(Const HAtu,HAnt : TipoHora  ):Longint;Overload;
    class function DifHora_Retorne_Minutos(Const HAtu,HAnt : Longint  ):Longint;Overload;

    class function DifHora_Retorne_Time(Const HAtu,HAnt : TipoHora  ):Longint;Overload; //Retorna a hora compactada
    class function DifHora_Retorne_Time(Const HAtu,HAnt : Longint  ):Longint;Overload;  //Retorna a hora compactada

    class function SegundosEmHora(Const Segundos:Longint):String;
    class function  New_Lista_Str_Meses : PSitem;

    class function getDateStr :tstring ;
    class function getTimeStr :tstring ;
  end;

Implementation

//  Uses    Db_Error,Bberror, app;


  class function TDates.  New_Lista_Str_Meses : PSitem;
  Begin
    Result := NewSItem('Indefinido',
              NewSItem('Janeiro',
              NewSItem('Fevereiro',
              NewSItem('Março',
              NewSItem('Abril',
              NewSItem('Maio',
              NewSItem('Junho',
              NewSItem('Julho',
              NewSItem('Agosto',
              NewSItem('Setembro',
              NewSItem('Outubro',
              NewSItem('Novembro',
              NewSItem('Dezembro',
              nil)))))))))))));
  end;


    class function TDates.DifHoraEmSegundos(const HAtu, HAnt: TipoHora): Longint;
  Var
    tempoSegAtu,
    tempoSegAnt  : Longint;
  Begin
    TempoSegAtu := HAtu.H * Longint(3600) + HAtu.M * 60+ HAtu.S ;
    TempoSegAnt := HAnt.H * Longint(3600) + HAnt.M * 60+ HAnt.S ;
    DifHoraEmSegundos := Abs(TempoSegAtu  - TempoSegAnt);
  End;

    class function TDates.DifHora_Retorne_TipoHora(const HAtu, HAnt: TipoHora
    ): TipoHora;
  var WM,Segundos : Longint;
  begin
    Segundos := DifHoraEmSegundos(HAtu,HAnt);
  {  HDif.S   := Segundos - trunc(Segundos/60) * 60;
    WM       := trunc(Segundos/60);
    HDif.M   := WORD(WM - trunc(WM/60) * 60);
    HDif.H   := trunc(Segundos/3600);}

    Result.S   := Segundos - trunc(Segundos/60) * 60;
    WM       := trunc(Segundos/60);
    Result.M   := WORD(WM - trunc(WM/60) * 60);
    Result.H   := trunc(Segundos/3600);
  end;

  class function TDates.DifHora_Retorne_TipoHora(const HAtu,HAnt : Longint  ):TipoHora;
    Var
      DataAtu :TypeData;
      HoraAtu :TipoHora;

      DataAnt :TypeData;
      HoraAnt :TipoHora;
  Begin
    UnPackDateHora(HAtu,DataAtu,HoraAtu);
    UnPackDateHora(HAnt,{Var} DataAnt,{Var} HoraAnt);
    Result := DifHora_Retorne_TipoHora(HoraAtu,HoraAnt);
  end;


    class function TDates.DifHora_Retorne_Horas_Fracao(const HAtu, HAnt: TipoHora
    ): Double;
      Var HDif : TipoHora;
  Begin
    HDif := DifHora_Retorne_TipoHora( HAtu,HAnt);
    // Converte para segundos
    Result := (HDif.H * 3600) + (HDif.M*60) + HDif.S;

  // Converte para hora fracionaria
    Result := Result /3600;
  end;

    class function TDates.DifHora_Retorne_Horas_Fracao(const HAtu, HAnt: Longint
    ): Double;
    Var
      DataAtu :TypeData;
      HoraAtu :TipoHora;

      DataAnt :TypeData;
      HoraAnt :TipoHora;
  Begin
    UnPackDateHora(HAtu,{Var} DataAtu,{Var} HoraAtu);
    UnPackDateHora(HAnt,{Var} DataAnt,{Var} HoraAnt);
    Result := DifHora_Retorne_Horas_Fracao(HoraAtu,HoraAnt);
  end;

    class function TDates.DifHora_Retorne_Minutos(const HAtu, HAnt: TipoHora
    ): Longint;
      Var HDif : TipoHora;
  Begin
    HDif := DifHora_Retorne_TipoHora( HAtu,HAnt);
    // Converte para minutos
    Result := (HDif.H * 60) + (HDif.M);// + HDif.S;
  end;

    class function TDates.DifHora_Retorne_Minutos(const HAtu, HAnt: Longint
    ): Longint;
    Var
      DataAtu :TypeData;
      HoraAtu :TipoHora;

      DataAnt :TypeData;
      HoraAnt :TipoHora;
  Begin
    UnPackDateHora(HAtu,{Var} DataAtu,{Var} HoraAtu);
    UnPackDateHora(HAnt,{Var} DataAnt,{Var} HoraAnt);
    Result := DifHora_Retorne_Minutos(HoraAtu,HoraAnt);
  end;

    class function TDates.DifHora_Retorne_Time(const HAtu, HAnt: TipoHora
    ): Longint;
   //<Retorna a hora compactada
     Var
       wResult:TipoHora;
   Begin
     Result := 0;
     wResult := DifHora_Retorne_TipoHora(HAtu,HAnt);
     PackHora(wResult,Result);
   end;

    class function TDates.DifHora_Retorne_Time(const HAtu, HAnt: Longint
    ): Longint;
  //Retorna a hora compactada
    Var
       wResult:TipoHora;
   Begin
     Result := 0;
     wResult := DifHora_Retorne_TipoHora(HAtu,HAnt);
     PackHora(wResult,Result);
   end;


    class function TDates.SegundosEmHora(const Segundos: Longint): String;
  Var Hora : TipoHora;
      WM   : longint;
  Begin
    Hora.S :=   Word(Abs(Segundos - trunc(Segundos/60) * 60));
    WM       := trunc(Segundos/60);
    Hora.M   := WORD(WM - trunc(WM/60) * 60);
    Hora.H   := Word(trunc(Segundos/3600));
    With Hora do
      SegundosEmHora := strData(h,m,s,':');
  End;

  {
  class procedure TDates. SetDataAtual(Var Data );
  Begin
    With TypeData(Data) do
    Begin
      DataAtual.diaAtu := Dia;
      DataAtual.MesAtu := Mes;
      DataAtual.AnoAtu := Ano;
    end;
  end;}

    class function TDates.DateMask_to_Str(const aDateMask: TDateMask): String;
  Begin
    Case aDateMask of
      DateMask_AA_MM_DD,
      DateMask_DD_MM_AA       : DateMask_to_Str := '##/##/##';
      DateMask_DDMMAA         : DateMask_to_Str := '######';

      DateMask_AAAA_MM_DD     : DateMask_to_Str := '####/##/##';

      DateMask_DD_MM_AAAA     : DateMask_to_Str := '##/##/####';

      DateMask_MM_AA          : DateMask_to_Str := '##/##';
      DateMask_MM_AAAA        : DateMask_to_Str := '##/####';

      DateMask_NomeMM_AA      : DateMask_to_Str := 'ssssssssss/##';
      DateMask_NomeMM_AAAA    : DateMask_to_Str := 'ssssssssss/####';

      DateMask_MM_NomeMM      : DateMask_to_Str := '##/ssssssssss';
      DateMask_MM_NomeMM_AA   : DateMask_to_Str := '##/ssssssssss/##';
      DateMask_MM_NomeMM_AAAA : DateMask_to_Str := '##/ssssssssss/####';
      DateMask_Extenco        : DateMask_to_Str := 'ssssssssssssssssssssssssss';

      DateMask_DD_MM_AA_HH_MM_SS : Result := 'DD/MM/AA HH:MM:SS';
      DateMask_DDMMAAHHMMSS      : Result := 'DDMMAAHHMMSS';

      DateMask_DD_MM_AA_HH_MM    : Result := 'DD/MM/AA HH:MM';
      DateMask_DDMMAAHHMM        : Result := 'DDMMAAHHMM';

      DateMask_DD_MM_AAAA_HH_MM_SS : Result := 'DD/MM/AAAA HH:MM:SS';
      DateMask_DDMMAAAAHHMMSS      : Result := 'DDMMAAAAHHMMSS';

      DateMask_AAAAMMDDHHMMSS      : Result := 'AAAAMMDDHHMMSS';


      Else Begin
              Push_MsgErro('Error em: class function TDates. DateMask_to_Str(Const aDateMask : TDateMask ):String;');
              RunError(ParametroInvalido);
           End;
    End;
  end;

  class function TDates. Str_to_DateMask(aStrDate:String):TDateMask;
    Var
      aDateTimeDos : Longint;
  Begin
    //Analisa se o len de aStrDate é válido.
    if (Length(aStrDate) in [14,//length('DDMMAAAAHHMMSS'),                       length('AAAAMMDDHHMMSS'),
                             12, //length('DDMMAAHHMMSS'),
                             10 //length('DDMMAAHHMM')
                            ])
    Then begin
           if Length(aStrDate) in [14 //length('DDMMAAAAHHMMSS'), length('AAAAMMDDHHMMSS')
                                  ]
           then Begin
                  Try
                    aDateTimeDos := StrToDateTimeDos(aStrDate,DateMask_DDMMAAAAHHMMSS);
                    Result := DateMask_DDMMAAAAHHMMSS;
                  Except
                    aDateTimeDos := StrToDateTimeDos(aStrDate,DateMask_AAAAMMDDHHMMSS);
                    Result := DateMask_AAAAMMDDHHMMSS;
                  End;
                End
           Else Begin
                  if Length(aStrDate) = length('DDMMAAHHMMSS')
                  Then Result := DateMask_DDMMAAHHMMSS
                  Else Result := DateMask_DDMMAAHHMM;
               end;
         end
    Else Raise EArgumentException.Create(TStrError.ErrorMessage5('mi.rtl','mi.rtl.dates','Tdates','Str_to_DateMask',ParametroInvalido ));
    //Raise TException.Create(Name_Type_App_MarIcaraiV1,
    //                               'D_Datas.pas',
    //                               'StrToDateTimeDos()',
    //                                ParametroInvalido);

  End;


    class function TDates.HourMask_to_Str(const aHourMask: THourMask): String;
  Begin
    Case aHourMask of
      HourMask_HH_MM          : HourMask_to_Str := '##:##';
      HourMask_HH_MM_SS       : HourMask_to_Str := '##:##:##';
      HourMask_HH_MM_SS_S100   : HourMask_to_Str := '##:##:##:###';
      Else Begin
             Raise EArgumentException.Create(TStrError.ErrorMessage5('mi.rtl','mi.rtl.dates','Tdates','HourMask_to_Str','A data está com formato inválido!.' ));
             //Raise TException.Create(Name_Type_App_MarIcaraiV1,
             //                      'D_Datas.pas',
             //                      'class function TDates. HourMask_to_Str(Const aHourMask : THourMask ):String;',
             //                       sgc('A data está com formato inválido!. Corrija-o por favor.')
             //                     );
           End;
    End;
  end;

    class function TDates.DiaMaxMes(const DataAtual: TypeData): byte;

    Var
      DiaMax : byte;

  begin
    diaMax := 0;
    with TypeData(dataAtual) do
      if mes in [4,6,9,11] then diaMax := 30
      else
      if mes in [1,3,5,7,8,10,12] then diaMax := 31
      else
      if ano mod 4 = 0 then diaMax := 29
      else
      diaMax := 28;
    if diaMax = 0 then diaMax := 1;
    diaMaxMes := diaMax;
  End;


    class function TDates.DateToStr(const aDate: TypeData; const Mask: TDateMask
    ): String;
  var
    StrDataAux : string;
    D,M,A      : String[4];
  begin
    str(aDate.dia:1,D);
    str(aDate.mes:1,M);
    str(aDate.ano:1,A);

    if Byte(D[0]) < 2 then insert('0',D,1);
    if Byte(M[0]) < 2 then insert('0',M,1);
    if Byte(A[0]) < 2 then insert('0',A,1);


    case Mask of
      DateMask_AA_MM_DD :
      Begin
        If (aDate.Ano >= AnoLimit) or (aDate.Dia = 0)
        Then strDataAux := Concat(A,M,D)
        Else Begin
               strDataAux := Chr(100+aDate.Ano)+M+D;
               If Length(strDataAux) = 5 Then
                 Insert('0',strDataAux,2);
              End;
      end;

      DateMask_AAAA_MM_DD : {Retorna a data dia/mes/ano com 4 digitos}
      Begin
        If aDate.Ano >= AnoLimit
        Then strDataAux := concat('19'+A,'/',M,'/',D)
        Else strDataAux := concat('20'+A,'/',M,'/',D);
      End;

      DateMask_DD_MM_AA   : strDataAux := concat(D,'/',M,'/',A);
      DateMask_DDMMAA     : strDataAux := concat(D,M,A);

      DateMask_DD_MM_AAAA : {Retorna a data dia/mes/ano com 4 digitos}
      Begin
        If aDate.Ano >= AnoLimit
        Then strDataAux := concat(D,'/',M,'/','19'+A)
        Else strDataAux := concat(D,'/',M,'/','20'+A);
      End;

      DateMask_Extenco:
      Begin
        If aDate.Ano >= AnoLimit
        Then StrDataAux := concat(D,' de ',StrMes(aDate.mes),' de ','19',A)
        Else StrDataAux := concat(D,' de ',StrMes(aDate.mes),' de ','20',A)
      End;

      DateMask_NomeMM_AAAA :
        If aDate.Ano >= AnoLimit
        Then StrDataAux := StrMes(aDate.Mes)+'/'+'19'+A
        Else StrDataAux := StrMes(aDate.Mes)+'/'+'20'+A;


      DateMask_NomeMM_AA  : StrDataAux := StrMes(aDate.Mes)+'/'+A;

      DateMask_MM_NomeMM  : StrDataAux := M+'='+StrMes(aDate.Mes);

      DateMask_MM_NomeMM_AAAA :
        If aDate.Ano >= AnoLimit
        Then StrDataAux := M+'='+StrMes(aDate.Mes)+'/'+'19'+A
        Else StrDataAux := M+'='+StrMes(aDate.Mes)+'/'+'20'+A;

      DateMask_MM_NomeMM_AA  : StrDataAux := M+'='+StrMes(aDate.Mes)+'/'+A;

  {Mes/ano}   {  StrCampo := Istr(Data.Mes,'BB')+'='+StrMes(Data.Mes)+'/'+IStr(FAno(Data.ano),'IIII');}
  {Dia}       {StrCampo := Istr(Data.Dia,'BB');}
  {Ano}         {StrCampo := IStr(FAno(Data.ano),'IIII');}

  {
      DateMask_DD_MM_AA_HH_MM_SS,   // DD/MM/AA HH:MM:SS
      DateMask_DDMMAAHHMMSS,        // DDMMAAHHMMSS

      DateMask_DD_MM_AA_HH_MM,      // DD/MM/AA HH:MM
      DateMask_DDMMAAHHMM,          // DDMMAAHHMM

      DateMask_DD_MM_AAAA_HH_MM_SS,  // DD/MM/AAAA HH:MM:SS
      DateMask_DDMMAAAAHHMMSS,       // DD/MM/AAAA HH:MM:SS

      DateMask_AAAAMMDDHHMMSS        // AAAAMMDDHHMMSS
                              : Begin

                                End;

      DateMask_MM_AA          : Begin end;
      DateMask_MM_AAAA        : Begin end;
  }

      else Begin
             Raise EArgumentException.Create(TStrError.ErrorMessage5('mi.rtl','mi.rtl.dates','Tdates','DateToStr','A data está com formato inválido!. Corrija-o por favor.' ));
             //  Raise TException.Create(Name_Type_App_MarIcaraiV1,
             //                        'D_Datas.pas',
             //                        'class function TDates. DateToStr(Var aDate:TypeData;Const Mask: TDateMask) : String;)',
             //                         sgc('A data está com formato inválido!. Corrija-o por favor.')
             //                         );
           End;
    end;


    if strDataAux <> '00/00/00;1;_' then
      DateToStr:= strDataAux
    else
      DateToStr:= '        ';
  end;

    class function TDates.DateToStr(const aDate: Longint; const Mask: TDateMask
    ): String;
  Begin
     Result := DateToStr(UnPackDate(aDate),Mask);
  end;


    class function TDates.DateToDateTime(aDate: TypeData): System.TDateTime;
  Begin
    Result := EncodeDate(FAno(aDate.ano),
                         aDate.Mes,
                         aDate.Dia);

  end;

  {class function TDates. DateToDateTime(aTimePack:Longint): TDateTime;Overload;
  Begin
     Result := FileDateToDateTime(aTimePack);
  end;}


  class function TDates. DateToDateTime(aTimePack:Longint):System.TDateTime;Overload;
   Var
     Data:TypeData;
     Hora :TipoHora;
  begin
    if aTimePack<>0
    then Begin
           UnPackDateHora(aTimePack,Data,Hora);
           //Inicia a data
           Result := EncodeDate(FAno(Data.Ano),Data.Mes,Data.dia);
           if Result >= 0
           then Result := Result + EncodeTime(Hora.H,Hora.M,Hora.S,Hora.S100)
           else Result := Result - EncodeTime(Hora.H,Hora.M,Hora.S,Hora.S100);

         End
    Else Result := 0;
  end;

  class function TDates. DateTimeToDate(aDateTime:TDateTime):TypeData;Overload;
     Var
       Year, Month, Day, Hour:System.Word;
  begin
    if aDateTime<>0
    then Begin
           DecodeDate(aDateTime, Year, Month, Day);
           Result.dia := Day;
           Result.Mes := Month;
           Result.Ano := FAno2Digito(Year);
         End
    Else Fillchar(Result,sizeof(Result),0);
  end;

  class function TDates. DateTimeToDateStr(aDateTime:TDateTime):String;Overload;
   Var
     Year, Month, Day, Hour:System.Word;
  begin
    if aDateTime<>0
    then Begin
           DecodeDate(aDateTime, Year, Month, Day);
           Result := Istr(Day,'ZB')+'/'+Istr(Month,'ZB')+'/'+Istr(Year,'ZZZI');
         End
    Else Result := '';
  end;

  class function TDates. DateTimeToTimeStr(aDateTime:TDateTime):String;
   Var
     //Year, Month, Day,
     Hour, Min, Sec, MSec: system.Word;
  begin
    if aDateTime<>0
    then Begin
           DecodeTime(aDateTime,Hour,Min,Sec,MSec);
           Result := Istr(Hour,'ZB')+':'+Istr(Min,'ZB')+':'+Istr(Sec,'ZB');
         End
    Else Result := '';
  end;

  class function TDates. DateTimeToDateTimeDos(aDateTime:TDateTime):Longint;Overload;
   Var
     Year, Month, Day, Hour, Min, Sec, MSec: System.Word;
     Data:TypeData;
     Hora :TipoHora;
  begin
    if aDateTime<>0
    then Begin
           DecodeDate(aDateTime, Year, Month, Day);
           //Inicia a data
           Data.dia := Day;
           Data.Mes := Month;
           Data.Ano := FAno2Digito(Year);

           DecodeTime(aDateTime,Hour,Min,Sec,MSec);
           //Inicia a hora
           Hora.H := Hour;
           Hora.M := Min;
           Hora.S := Sec;
           Hora.S100 := MSec;

           PackDateHora(Data,
                        Hora,
                        Result);
         End
    Else Result := 0;
  end;

  class function TDates. DateTimeDosToStr(aTimePack:Longint;Mask:TDateMask):String;
    //Result deve ser:
    {
    TDateTimeMask =
                (DateMask_DD_MM_AA_HH_MM_SS,   // DD/MM/AA HH:MM:SS
                 DateMask_DDMMAAHHMMSS,        // DDMMAAHHMMSS
                 DateMask_DD_MM_AA_HH_MM,      // DD/MM/AA HH:MM
                 DateMask_DDMMAAHHMM,          // DDMMAAHHMM
                 DateMask_DD_MM_AAAA_HH_MM_SS, // DD/MM/AAAA HH:MM:SS
                 DateMask_DDMMAAAAHHMMSS ,     // DD/MM/AAAA HH:MM:SS
                 DateMask_AAAAMMDDHHMMSS         //AAAAMMDDHHMMSS
                );
    }
    Var
      Data:TypeData;
      Hora :TipoHora;
      SeparadorData,
      SeparadorHora : String;
  begin
    if aTimePack<>0
    then Begin
           UnPackDateHora(aTimePack,
                            Data,
                            Hora);

           //Calcula os separadores de data e hora.
           if Mask in [DateMask_DD_MM_AA_HH_MM_SS,   // DD/MM/AA HH:MM:SS
                       DateMask_DD_MM_AA_HH_MM,      // DD/MM/AA HH:MM
                       DateMask_DD_MM_AAAA_HH_MM_SS  // DD/MM/AAAA HH:MM:SS
                      ]
           Then Begin
                  SeparadorData  := '/';
                  SeparadorHora  := ':';
                End
           Else Begin
                  SeparadorData  := '';
                  SeparadorHora  := '';
                End;

           //Calcula o resultado baseado na mascara passada por: Mask
           if Mask = DateMask_DD_MM_AAAA_HH_MM_SS
           then Begin
                   //Inicia a data
                   Result := IStr(Data.dia,'ZB')+SeparadorData+ IStr(Data.Mes,'ZB')+SeparadorData+ IStr(FAno(Data.Ano),'ZZZI');

                   //Inicia a hora
                   Result := Result + ' '+ Istr(Hora.H,'ZB')+SeparadorHora+Istr(Hora.M,'ZB')+SeparadorHora+Istr(Hora.S,'ZB');
                end
           Else
           if Mask = DateMask_DD_MM_AA_HH_MM_SS
           then Begin
                   //Inicia a data
                   Result := IStr(Data.dia,'ZB')+SeparadorData+ IStr(Data.Mes,'ZB')+SeparadorData+ IStr(Data.Ano,'ZB');

                   //Inicia a hora
                   Result := Result + ' '+ Istr(Hora.H,'ZB')+SeparadorHora+Istr(Hora.M,'ZB')+SeparadorHora+Istr(Hora.S,'ZB');
                end
           Else
           if Mask = DateMask_DD_MM_AA_HH_MM_SS
           then Begin //DateMask_DD_MM_AA_HH_MM
                   //Inicia a data
                   Result := IStr(Data.dia,'ZB')+SeparadorData+ IStr(Data.Mes,'ZB')+SeparadorData+ IStr(Data.Ano,'ZB');

                   //Inicia a hora
                   Result := Result + ' '+ Istr(Hora.H,'ZB')+SeparadorHora+Istr(Hora.M,'ZB');
                end
           Else
           if Mask = DateMask_AAAAMMDDHHMMSS
           then Begin
                   //Inicia a data
                   Result := IStr(FAno(Data.Ano),'ZZZI') + IStr(Data.Mes,'ZB')+IStr(Data.dia,'ZB');

                   //Inicia a hora
                   Result := Result + ' '+ Istr(Hora.H,'ZB')+SeparadorHora+Istr(Hora.M,'ZB');
                end
         End
    Else Result := '';
  end;



  Var
    TempStrToDate : TDates.TypeData; {Usado com pbuffer de retorno da funcao StrToDate}
    Vidis_StrToDate : Boolean = false;
    class function TDates.StrToDate(aStrDate: String; const Mask: TDateMask
    ): PTypeData;
  {
    TDateMask = (DateMask_AA_MM_DD,
                 DateMask_AAAA_MM_DD,
                 DateMask_DD_MM_AA,// DD/MM/AA
                 DateMask_DDMMAA, // DDMMAA
                 DateMask_DD_MM_AAAA,
                 DateMask_MM_AA,
                 DateMask_MM_AAAA,
                 DateMask_NomeMM_AA,
                 DateMask_NomeMM_AAAA,

                 DateMask_MM_NomeMM,
                 DateMask_MM_NomeMM_AA,
                 DateMask_MM_NomeMM_AAAA,
                 DateMask_Extenco,

                 DateMask_DD_MM_AA_HH_MM_SS,   // DD/MM/AA HH:MM:SS
                 DateMask_DDMMAAHHMMSS,        // DDMMAAHHMMSS

                 DateMask_DD_MM_AA_HH_MM,      // DD/MM/AA HH:MM
                 DateMask_DDMMAAHHMM,          // DDMMAAHHMM

                 DateMask_DD_MM_AAAA_HH_MM_SS,  // DD/MM/AAAA HH:MM:SS
                 DateMask_DDMMAAAAHHMMSS,       // DD/MM/AAAA HH:MM:SS

                 DateMask_AAAAMMDDHHMMSS        // AAAAMMDDHHMMSS

                 );
                xcl
  }

  {$I-}
    Var
      Err  : Integer;
      aAno : SmallInt;
      P,I        : Byte;
      Aux,Dia,Mes,Ano:String;
      aDateTimeDos :Longint;
      AuxMask: TDateMask;
  Begin
    Result := @TempStrToDate;

    if (aStrDate = '') or (aStrDate = '0')
    then begin
           result.dia := 0;
           result.mes := 0;
           Result.Ano := 0;
           exit;
         end;


    Err       := 0;
    Aux := '';
    //Retira todos os caracteres não válidos
    for I := 1 to Length(aStrDate) do
      if aStrDate[i] in ['0'..'9','/']
      then Aux  := Aux + aStrDate[i];

    if (pos('/',Aux)<>0) and (Mask in [DateMask_DD_MM_AA,// DD/MM/AA
                                       DateMask_DDMMAA, // DDMMAA
                                       DateMask_DD_MM_AAAA,
                                       DateMask_DD_MM_AA_HH_MM_SS,   // DD/MM/AA HH:MM:SS
                                       DateMask_DDMMAAHHMMSS,        // DDMMAAHHMMSS
                                       DateMask_DD_MM_AA_HH_MM,      // DD/MM/AA HH:MM
                                       DateMask_DDMMAAHHMM,          // DDMMAAHHMM
                                       DateMask_DD_MM_AAAA_HH_MM_SS,  // DD/MM/AAAA HH:MM:SS
                                       DateMask_DDMMAAAAHHMMSS       // DD/MM/AAAA HH:MM:SS
                                      ])
    Then Begin //A data tem um seprador portando pode ter mes ou dia com 1 digito.
            //Pega o dia de AUX e Preenche com zero a esquerda os dias de 1 a 9
            if pos('/',Aux)<>0
            then Begin
                   Dia := copy(Aux,1,pos('/',Aux)-1);
                   if Length(dia)<2
                   then Begin
                          Insert('0',dia,1);
                          delete(aux,1,2);
                        End
                   Else delete(aux,1,3);

                 End
            Else Begin
                   Dia := Copy(Aux,1,2);
                   delete(aux,1,2);
                 End;

            //Pega o Mes de AUX e Preenche com zero a esquerda os meses de 1 a 9
            if pos('/',Aux)<>0
            then Begin
                   Mes := copy(Aux,1,pos('/',Aux)-1);
                   if Length(Mes)<2
                   then Begin
                          Insert('0',Mes,1);
                          delete(aux,1,2);
                        End
                   Else delete(aux,1,3);
                 End
            Else Begin
                   Mes := Copy(Aux,1,2);
                   delete(aux,1,2);
                 End;

            Ano := Aux;
            aStrDate := Dia+Mes+Ano;
         End
    else Begin //Não tem separador portanto então o tamanho da variável so pode ser 6,8,10,12,14
           Aux := '';
           //Retira todos os caracteres não válidos
           for I := 1 to Length(aStrDate) do
           if aStrDate[i] in ['0'..'9']
           then Aux  := Aux + aStrDate[i];

           aStrDate := Aux;
         End;

    If aStrDate = ''
    Then Begin
           FillChar(TempStrToDate,sizeof(TempStrToDate),0);
           exit;
         end;


    //Analisa se o len de aStrDate é válido.
    if (Length(aStrDate) in [14, //length('DDMMAAAAHHMMSS'), length('AAAAMMDDHHMMSS'),
                             12, //length('DDMMAAHHMMSS'),
                             10 //length('DDMMAAHHMM')
                            ])
    Then begin //
           if Length(aStrDate) in  [14 //length('DDMMAAAAHHMMSS'),      length('AAAAMMDDHHMMSS')
                                   ]
           then Begin
                  Try
                   aDateTimeDos := StrToDateTimeDos(aStrDate,DateMask_DDMMAAAAHHMMSS);
                  Except
                    aDateTimeDos := StrToDateTimeDos(aStrDate,DateMask_AAAAMMDDHHMMSS);
                  End;
                End
           Else Begin
                  if Length(aStrDate) = length('DDMMAAHHMMSS')
                  Then aDateTimeDos := StrToDateTimeDos(aStrDate,DateMask_DDMMAAHHMMSS)
                  Else aDateTimeDos := StrToDateTimeDos(aStrDate,DateMask_DDMMAAHHMM);
               end;
           TempStrToDate := UnPackDate(aDateTimeDos);
           exit;
         end
    Else
    If Not (length(aStrDate) in [6,8]) Then //ddmmaa or ddmmaaaa
    Begin
      If aStrDate <> '' Then
         Raise EArgumentException.Create(TStrError.ErrorMessage5('mi.rtl','mi.rtl.dates','Tdates','StrToDate','A data '+aStrDate+' está com formato inválido!. Corrija-o por favor.' ));

        //Raise TException.Create(Name_Type_App_MarIcaraiV1,
        //                           'D_Datas.pas',
        //                           'class function TDates. StrToDate()',
        //                           'A data '+aStrDate+sgc(' está com formato inválido!. Corrija-o por favor.')
        //                            );
  {      Application.MI_MsgBox.MessageBox(
           StrMessageBox('/\/\arIcarai',
                         'Datas.pas',
                         'class function TDates. StrToDate',
                          '',
                          '',

                          'A data '+aStrDate+' esta com formato inv lido!. Corrija-o por favor.'

                       )
        );}

      TaStatus :=  Tipo_em_memoria_incompativel_com_o_tipo_do_campo_no_arquivo ;

      FillChar(TempStrToDate,sizeof(TempStrToDate),0);
      exit;
    End;

    Case Mask of
      DateMask_AA_MM_DD :
      Begin {AAMMDD = AnoMesDia}

       If Byte(aStrDate[1]) >= 100 {Ao acima de 2000 a 2000+ AnoLimite}
       Then Begin
               TempStrToDate.Ano := Byte(aStrDate[1]) - 100
            End
       else Val(Copy(aStrDate,1,2),TempStrToDate.ano,err);

       If Err = 0 Then Val(Copy(aStrDate,3,2),TempStrToDate.mes,err);
       If Err = 0 Then Val(Copy(aStrDate,5,2),TempStrToDate.dia,err);
       If Err<> 0 Then
       TaStatus :=  Tipo_em_memoria_incompativel_com_o_tipo_do_campo_no_arquivo ;
      End;

      DateMask_AAAA_MM_DD :
      Begin
        Val(Copy(aStrDate,1,4),Aano,err);
        If Err = 0
        Then If aAno < 2000
            Then TempStrToDate.ano := aAno - 1900
            Else TempStrToDate.ano := aAno - 2000;


        If Err = 0 Then Val(Copy(aStrDate,5,2),TempStrToDate.mes,err);
        If Err = 0 Then Val(Copy(aStrDate,7,2),TempStrToDate.dia,err);
        If Err<> 0 Then
        TaStatus :=  Tipo_em_memoria_incompativel_com_o_tipo_do_campo_no_arquivo ;
        End;

      DateMask_DDMMAA, //??? Esta rotina foi feita a mascara ###### e nao ##/##/##
      DateMask_DD_MM_AA:
      Begin
      Val(Copy(aStrDate,1,2),TempStrToDate.dia,err);
      If Err = 0
      Then Val(Copy(aStrDate,3,2),TempStrToDate.mes,err);

      if Length(aStrDate) = 6
      then Begin
             If Err = 0
             Then Begin  {Ao acima de 2000 a 2000+ AnoLimite}
                    If Byte(aStrDate[5]) >= 100
                    Then TempStrToDate.Ano := Byte(aStrDate[5]) - 100
                    else Val(Copy(aStrDate,5,2),TempStrToDate.ano,err);
                 End;
          End
      Else Begin
            Val(Copy(aStrDate,5,4),aAno,err);
            if err=0
            then TempStrToDate.Ano := FAno2Digito(aAno);
          End;
      If Err<> 0 Then
      TaStatus :=  Tipo_em_memoria_incompativel_com_o_tipo_do_campo_no_arquivo ;
      End;

      DateMask_DD_MM_AAAA :
      Begin
      If length(aStrDate) = 6
      Then Begin
            Val(Copy(aStrDate,5,2),aAno,err);
            If Err = 0
            Then aStrDate := Copy(aStrDate,1,4)+IStr(FAno(aAno),'IIII')
            Else RunError(201);
          end;

      Val(Copy(aStrDate,1,2),TempStrToDate.dia,err);
      If Err = 0 Then Val(Copy(aStrDate,3,2),TempStrToDate.mes,err);
      If Err = 0
      Then Begin  {Ao acima de 2000 a 2000+ AnoLimite}
            Val(Copy(aStrDate,5,4),aAno,err);
            If Err = 0
            Then If aAno < 2000
                 Then TempStrToDate.ano := aAno - 1900
                 Else TempStrToDate.ano := aAno - 2000;
         End;
      If err <> 0
      Then Begin
            FillChar(TempStrToDate,sizeof(TempStrToDate),0);
            TaStatus :=  Tipo_em_memoria_incompativel_com_o_tipo_do_campo_no_arquivo ;
          end;
      End;
      {
      DateMask_MM_AA      : Begin end;
      DateMask_MM_AAAA    : Begin end;
      DateMask_NomeMM_AA  : Begin end;
      DateMask_NomeMM_AAAA : Begin end;
      DateMask_MM_NomeMM      : Begin end;
      DateMask_MM_NomeMM_AA   : Begin end;
      DateMask_MM_NomeMM_AAAA : Begin end;
      DateMask_Extenco        : Begin end;
      }
      DateMask_DD_MM_AA_HH_MM_SS : Begin

                                 end;

      Else Begin
      {           RunError(ParametroInvalido);}
         TaStatus := Formato_numerico_invalido_ou_incompativel;
       end;

    End; // case

    If TaStatus = 0 // Checa se a data é valida.
    Then Begin
           Case ValidDate(TempStrToDate) of
             1 :  Begin
                    if not Vidis_StrToDate
                    then TRY
                           Vidis_StrToDate := TRUE;
                           Raise EArgumentException.Create(TStrError.ErrorMessage5('mi.rtl','mi.rtl.dates','Tdates','StrToDate','O dia esta inválido!. Corrija-o por favor.' ));
                           //Raise TException.Create(Name_Type_App_MarIcaraiV1,
                           //              'D_Datas.pas',
                           //              'class function TDates. StrToDate()',
                           //              sgc('O dia esta inválido!. Corrija-o por favor.')
                           //               );
                         fINALLY
                           Vidis_StrToDate := FALSE;
                         end;
                  End;

             2 :  Begin
                    if not Vidis_StrToDate
                    then TRY
                           Vidis_StrToDate := TRUE;
                           Raise EArgumentException.Create(TStrError.ErrorMessage5('mi.rtl','mi.rtl.dates','Tdates','StrToDate','O mês esta inválido!. Corrija-o por favor.' ));
                           //Raise TException.Create(Name_Type_App_MarIcaraiV1,
                           //              'D_Datas.pas',
                           //              'class function TDates. StrToDate()',
                           //              sgc('O mês esta inválido!. Corrija-o por favor.')
                           //               );
                         fINALLY
                           Vidis_StrToDate := FALSE;
                         end;
                  End;
           End;
         End;

    If Err <> 0
    Then Raise EArgumentException.Create(TStrError.ErrorMessage5('mi.rtl','mi.rtl.dates','Tdates','StrToDate','A data '+aStrDate+' está com formato inválido!. Corrija-o por favor.' ));

    //Raise TException.Create(Name_Type_App_MarIcaraiV1,
    //                               'D_Datas.pas',
    //                               'class function TDates. StrToDate()',
    //                               'A data '+aStrDate+sgc(' está com formato inválido!. Corrija-o por favor.')
    //                                );
  {    Application.MI_MsgBox.MessageBox(
         StrMessageBox('Genericos',
                      'Datas',
                      'class function TDates. StrToDate',
                      'A data '+aStrDate+' esta com formato inv lido!. Corrija-o por favor.',
                      'DATAS.PAS'
                     )
      );
  }
  End;

  class function TDates. StrToDateTime(aDataTime:String;Mask:TDateMask):TDateTime;Overload;
    Var
      D : TypeData;
  Begin
    D := StrToDate(aDataTime,Mask)^;
    result := DateToDateTime(D);
  End;

  class function TDates. StrToDateTimeDos(aDataTime:String;Mask:TDateMask):Longint;
  {
      class function TDates. GetMaskDateTimeDos(aDataTime:String):TDateMask;
        //Retorna a mascara caso o tipo informado seja do tipo dateTimeDos.
      Begin
      Raise TException.Create(Name_Type_App_MarIcaraiV1,
                                       'D_Datas.pas',
                                       'StrToDateTimeDos()',
                                        'Função não implementada!');
      End;}

    Var
      Data:TypeData;
      Hora :TipoHora;

    {
    TDateTimeMask =
                 DateMask_DD_MM_AA_HH_MM_SS,   // DD/MM/AA HH:MM:SS
                 DateMask_DDMMAAHHMMSS,        // DDMMAAHHMMSS

                 DateMask_DD_MM_AA_HH_MM,      // DD/MM/AA HH:MM
                 DateMask_DDMMAAHHMM,          // DDMMAAHHMM

                 DateMask_DD_MM_AAAA_HH_MM_SS,  // DD/MM/AAAA HH:MM:SS
                 DateMask_DDMMAAAAHHMMSS,       // DD/MM/AAAA HH:MM:SS

                 DateMask_AAAAMMDDHHMMSS        // AAAAMMDDHHMMSS
    }
    Var
      S : String;
      I : Byte;
  Begin
    S := '';
    //Retira todos os caracteres não válidos
    for I := 1 to Length(aDataTime) do
      if aDataTime[i] in ['0'..'9']
      then S := S + aDataTime[i];

    //Analisa se o len de aDataTime é válido.
    if not (Length(S) in [14,//length('DDMMAAAAHHMMSS'),length('AAAAMMDDHHMMSS'),
                          12, //length('DDMMAAHHMMSS'),
                          10 //length('DDMMAAHHMM')
                                  ])
    then Raise EArgumentException.Create(TStrError.ErrorMessage5('mi.rtl','mi.rtl.dates','Tdates','StrToDateTimeDos',ParametroInvalido ));
    //Raise TException.Create(Name_Type_App_MarIcaraiV1,
    //                               'D_Datas.pas',
    //                               'StrToDateTimeDos()',
    //                                ParametroInvalido);

    if (Length(S) = length('DDMMAAAAHHMMSS'))  and
       ((Mask in [DateMask_DD_MM_AAAA_HH_MM_SS,DateMask_DDMMAAAAHHMMSS] ))
    then Begin
          //Inicia a data
           Data := StrToDate(Copy(S,1,8),DateMask_DD_MM_AAAA)^;

           //Inicia a hora
           Hora := StrToHora(Copy(S,9,6),HourMask_HH_MM_SS);
         End
    Else
    If  (Length(S) = length('AAAAMMDDHHMMSS')) and
       ((Mask in [DateMask_AAAAMMDDHHMMSS] ))
    Then Begin
          //Inicia a data
           Data := StrToDate(Copy(S,1,8),DateMask_AAAA_MM_DD)^;

           //Inicia a hora
           Hora := StrToHora(Copy(S,9,6),HourMask_HH_MM_SS);

         End
    Else
    if ((Mask in [DateMask_DD_MM_AA_HH_MM_SS,DateMask_DD_MM_AA_HH_MM,
                  DateMask_DDMMAAHHMMSS,DateMask_DDMMAAHHMM] ))
    Then Begin
          //Inicia a data
           Data := StrToDate(Copy(S,1,6),DateMask_DD_MM_AA)^;

           //Inicia a hora
           if Length(S) = length('DDMMAAHHMMSS')
           then Hora := StrToHora(Copy(S,7,6),HourMask_HH_MM_SS)
           Else Hora := StrToHora(Copy(S,7,4),HourMask_HH_MM);
         End
    Else Raise EArgumentException.Create(TStrError.ErrorMessage5('mi.rtl','mi.rtl.dates','Tdates','StrToDateTimeDos',ParametroInvalido ));

    //Raise TException.Create(Name_Type_App_MarIcaraiV1,
    //                               'D_Datas.pas',
    //                               'StrToDateTimeDos()',
    //                                ParametroInvalido);

    PackDateHora(Data ,
                 Hora ,
              //Var
                  Result);
  End;


    class function TDates.StrToHora(aStrHora: String; const Mask: THourMask
    ): TipoHora;
    Var
      Err:Integer;
  Begin
    //Deleta branco da string aStrHora
    While (length(aStrHora )>0) and (Pos(' ',aStrHora ) <> 0) do
      Delete(aStrHora ,Pos(' ',aStrHora ),1);

    //Deleta #0 da string aStrHora
    While (length(aStrHora )>0)and (Pos(#0,aStrHora ) <> 0) do
      Delete(aStrHora ,Pos(#0,aStrHora ),1);

    //Deleta : da string aStrHora
    While (length(aStrHora )>0)and (Pos(':',aStrHora ) <> 0) do
      Delete(aStrHora ,Pos(':',aStrHora ),1);

    //Deleta - da string aStrHora
    While (length(aStrHora )>0)and (Pos('-',aStrHora ) <> 0) do
      Delete(aStrHora ,Pos('-',aStrHora ),1);

    if aStrHora=''
    then Begin
           FillChar(result,sizeof(result),0);
           exit;
         end;

    if (Mask = HourMask_HH_MM_SS_S100) and (Length(aStrHora) = Length('HHMMSS100'))
    then Begin
           Val(Copy(aStrHora,1,2),result.H,err);
           if Err=0 then Val(Copy(aStrHora,3,2),result.M,err);
           if Err=0 then Val(Copy(aStrHora,5,2),result.S,err);
           if Err=0 then Val(Copy(aStrHora,7,3),result.S100,err);
         end
    Else
    if (Mask = HourMask_HH_MM_SS) and (Length(aStrHora) = Length('HHMMSS'))
    then Begin
           Val(Copy(aStrHora,1,2),result.H,err);
           if Err=0 then Val(Copy(aStrHora,3,2),result.M,err);
           if Err=0 then Val(Copy(aStrHora,5,2),result.S,err);
           result.S100 := 0;
         end
    Else
    if (Mask = HourMask_HH_MM)  and (Length(aStrHora) = Length('HHMM'))
    then Begin
           Val(Copy(aStrHora,1,2),result.H,err);
           if Err=0 then Val(Copy(aStrHora,3,2),result.M,err);
           result.S    := 0;
           result.S100 := 0;
         end
    Else Raise EArgumentException.Create(TStrError.ErrorMessage5('mi.rtl','mi.rtl.dates','Tdates','StrToHora',ParametroInvalido ));
    //Raise TException.Create(Name_Type_App_MarIcaraiV1,
    //                               'D_Datas.pas',
    //                               'StrToHour()',
    //                                ParametroInvalido);
    //

    if Err<>0
    then Raise EArgumentException.Create(TStrError.ErrorMessage5('mi.rtl','mi.rtl.dates','Tdates','StrToHora',ParametroInvalido ));

    //Raise TException.Create(Name_Type_App_MarIcaraiV1,
    //                               'D_Datas.pas',
    //                               'StrToHour()',
    //                                ParametroInvalido);

    If Err = 0 // Checa se a hora é valida.
    Then with result do
         Begin
           Case ValidHour(H,M,S,S100) of
             1 :     MI_MsgBox.MessageBox('A hora esta invalido!. Corrija-o por favor.');
                     //StrMessageBox('Genericos',
                     //               'Datas',
                     //               'class function TDates. StrToHora',
                     //               'A hora esta invalido!. Corrija-o por favor.',
                     //               'DATAS.PAS'
                     //              ));
             2 :     MI_MsgBox.MessageBox('Os minutos esta invalido!. Corrija-o por favor.');
                     //StrMessageBox('Genericos',
                     // 'Datas',
                     // 'class function TDates. StrToHora',
                     // 'Os minutos esta invalido!. Corrija-o por favor.',
                     // 'DATAS.PAS'
                     //));

             3 :     MI_MsgBox.MessageBox('Os segundos esta invalido!. Corrija-o por favor.');
                     //StrMessageBox('Genericos',
                     // 'Datas',
                     // 'class function TDates. StrToHora',
                     // 'Os segundos esta invalido!. Corrija-o por favor.',
                     // 'DATAS.PAS'
                     //));

             4 :     MI_MsgBox.MessageBox('Os centecimos de segundos sta invalido!. Corrija-o por favor.');
                     //StrMessageBox('Genericos',
                     // 'Datas',
                     // 'class function TDates. StrToHora',
                     // 'Os centecimos de segundos sta invalido!. Corrija-o por favor.',
                     // 'DATAS.PAS'
                     //));
           End;
         End;
  end;

    class function TDates.StrToHour(const aStrHora: String;
    const Mask: THourMask; TimePack: Longint): Longint;
    //Retorna a Hora compactada junto com a data compactada.
    Var aData:TypeData;
    Var aHora :TipoHora;
  Begin
    UnPackDateHora(TimePack, aData, aHora);
    aHora := StrToHora(aStrHora,Mask);
    PackDateHora(aData,aHora,TimePack);
    Result := TimePack;
  end;

    class function TDates.StrToHour(const aStrHora: String; const Mask: THourMask
    ): Longint;
    Var
       Time : Longint;
  Begin
    Time:=0;
    Result := StrToHour(aStrHora,Mask,Time);
  End;

    class function TDates.HourToStr(const Hora: TipoHora; const Mask: THourMask;
    const OkSpc: Boolean): String;
     Var
       SH,SM,SS,SS100      : String[4];
       WResult : String;
  begin
    with Hora Do
    Begin
      str(H:1,SH);
      str(M:1,SM);
      if Byte(SH[0]) < 2 then insert('0',SH,1);
      if Byte(SM[0]) < 2 then insert('0',SM,1);

      If  OkSpc
      Then Result := SH+':'+SM
      Else Result := SH+SM;

      If mask in [HourMask_HH_MM_SS,HourMask_HH_MM_SS_S100]
      Then Begin
             str(S:1,SS);
             if Byte(SS[0]) < 2 then insert('0',SS,1);

             If  OkSpc
             Then Result := Result+':'+SS
             Else Result := Result+SS;


             If mask = HourMask_HH_MM_SS_S100
             Then Begin
                    str(S100:1,SS100);
                    While Length(SS100)<3 do insert('0',SS100,1);

                    If  OkSpc
                    Then Result := Result+':'+SS100
                    Else Result := Result+SS100;
                  End;
           End;
    End;

    If Not OkSpc
    Then Begin
           WResult := Result;
           While Pos('0',WResult) <> 0 do delete(WResult,Pos('0',WResult),1);
           While Pos(':',WResult) <> 0 do delete(WResult,Pos(':',WResult),1);
           If WResult = ''
           Then Result := '';
         end;
  End;

    class function TDates.HourToStr(const aStrHora: Longint;
    const Mask: THourMask; const OkSpc: Boolean): String;
     Var
       Hora : TipoHora;
       //SH,SM,SS,SS100      : String[4];
      // WResult : String;
  begin
    If aStrHora = 0
    Then Begin
           Result := '';
           exit;
         End;
    UnPackHora(aStrHora,Hora);
    Result := HourToStr(Hora,Mask,OkSpc);
  End;


    class function TDates.HourToDateTime(const aTimePack: Longint): TDateTime;
     Var
       Hora : TipoHora;
       Data : TypeData;
  begin
    If aTimePack = 0
    Then Begin
           fillchar(result,sizeof(result),0);
           exit;
         End;
    UnPackDateHora(aTimePack, Data, Hora);

  //Result := EncodeDateTime(const AYear   ,AMonth  ,ADay    ,AHour , AMinute, ASecond, AMilliSecond: Word);
    Result := EncodeDateTime(FAno(Data.Ano),Data.mes,Data.dia,Hora.H, Hora.M  ,Hora.S  ,Hora.S100);
  End;

  class function TDates. FIncAno(Ano:SmallInt) : Byte;
  Begin
    If ano+1 = 100 Then {Chegou no ano 2000}
      Result := 00
    Else Begin
           Result := Ano+1;
           If Ano >= AnoLimit
           Then Result := 0;
         End
  End;

  class function TDates. FDecAno(Ano:SmallInt) : Byte;
  Begin
    If ano-1 < 0 Then {Chegou no ano 1999}
      FDecAno := 99
    Else
      FDecAno := Ano-1;

  End;

  class function TDates. FAno(Ano:SmallWord) : SmallWord;
  Begin
    If ano < 100 then
    Begin
      If Ano >= AnoLimit
      then Fano := Ano + 1900
      Else Fano := 2000+Ano;
    End
    Else
      FAno := Ano
  End;

  class function TDates. FAno2Digito(Ano : SmallWord):Byte;
  Var
    AAno : SmallWord;
  Begin
    aAno := FAno(Ano);
    If aAno >= 2000
    Then Begin
           if (aAno - 2000 <= 99) and (aAno - 1900 >= 0)
           then Result := aAno - 2000
           Else Result := 99;
         End
    Else Begin
           if (aAno - 1900 <= 99) and (aAno - 1900 >= 0)
           then Result := aAno - 1900
           Else Result := 99;
         End;
  End;

  (*
  class function TDates. FAnoDoIndex(Const Dia,Ano : byte):String;
  {Devolve o ano exatamente como esta no arquivo de index}
  Var
    SAno : String[2];
  Begin
    If (Ano >= AnoLimit) or (Dia = 0)  Then
      Str(Ano:1,Sano)
    Else
    Begin
      Str(100+Ano:1,Sano);
      If Length(Sano) = 1 Then
        Insert('0',SAno,2);
    End;

    FAnoDoIndex := SAno;
  End;
  *)
    class function TDates.FAnoDoIndex(const Dia, Ano: byte): String;
  {Devolve o ano exatamente como esta no arquivo de index}
  Var
    SAno : String[2];
  Begin
    If (Ano >= AnoLimit) or (Dia = 0)  Then
      Str(Ano:1,Sano)
    Else
    Begin
      sAno := Chr(100+Ano);
      If Length(Sano) = 1 Then
        Insert('0',SAno,2);
    End;
    FAnoDoIndex := SAno;
  End;

    class function TDates.StrAno(ano: SmallInt): String;
  Var
    A  : String[4];
  Begin
    Str(FAno(ano):1,A);
    StrAno := A;
  End;

  class function TDates. juliano(d,m,a : SmallInt) : TRealNum;
  var
    k : TRealNum;
  begin
    if a < 100 then
    Begin
      If a >= AnoLimit
      then a := a + 1900
      Else a := 2000+a;
    End;

    k:= int((m - 14 ) / 12);

    Result := d - 32075 + int(1461 * (a + 4800 + k) / 4) +
              int(367 * (m - 2 - k * 12) / 12) -
              int(3 * int((a + 4900 + k) / 100)/4);
  end;


    class function TDates.DifeData(diaAtual, mesAtual, anoAtual, diaAnterior,
    mesAnterior, anoAnterior: byte): Longint;

  var
    dia1,dia2,
    mes1,mes2,
    ano1,ano2 : SmallInt;

  begin
      dia1 := diaAtual; dia2 := diaAnterior;
      mes1 := mesAtual; mes2 := mesAnterior;
      ano1 := anoAtual; ano2 := anoAnterior;
      If (dia1 <> 0) and (dia2 <> 0) and (mes1<>0) and (mes2<>0)
      Then result := Longint(trunc(juliano(dia2, mes2, ano2 ) - juliano(dia1, mes1, ano1 ) ))
      Else result := 0;
  end;

  class function TDates. DifeData(const DAntBuff, { E a data mais Antiga  }
                        DAtuBuff :TypeData { E a Data mais recente }) : Longint;

  {
  Type TipoData = Record dia,Mes,Ano : Byte end;
  Var  At : TipoData Absolute dATuBuff;
       An : TipoData Absolute dAntBuff;

    Var
       Dif  : SmallInt;}
  Begin
    Result := Longint(DifeData(TypeData(DAntBuff).dia,TypeData(DAntBuff).mes,TypeData(DAntBuff).ano,
                      TypeData(DAtuBuff).Dia,TypeData(DAtuBuff).Mes,TypeData(DAtuBuff).Ano));
  End;


    class procedure TDates.somaData(var dia, mes: Byte; var ano: SmallInt;
    diasAsomar: Integer);
  var
    x,b,j            : TRealNum;
    m,a            : SmallInt;
    WAno   : SmallInt;

  begin
    WAno := Ano;


    j := juliano(dia,mes,ano) + diasAsomar;

    x   := j + 68569.0;
    b   := int(4 * x / 146097.0);
    x   := x - int((146097.0 * b + 3) / 4);

    a   := SmallInt(trunc(4000.0 * (x + 1)/1461001.0));

    x   := x - int(1461.0 * a / 4 ) + 31;

    m   := SmallInt(trunc(80 * x / 2447));

    dia := Byte(trunc(x - int(2447.0 * m / 80)));

    x   := int(m/11);
    mes := trunc(m + 2 - 12 * x);

    if WAno >= AnoLimit Then
    Begin
      If WAno <= 99
      Then Begin
             ano := SmallInt(trunc(100 * (b - 49) + a + x) - 1900);
             If Ano > 99 Then
             Ano := Ano - (99 + 1);
           End
      Else ano := SmallInt(trunc(100 * (b - 49) + a + x));
    End
    Else
    Begin
      Wano := trunc(100 * (b - 49) + a + x) - 2000;
      If WAno >= 0 Then
        Ano := WAno
      Else
        Ano := 99 + (WAno + 1)
    End;
  end;

    class procedure TDates.somaData(var dia, mes, ano: byte; diasAsomar: Integer);
    Var
      WAno : SmallInt;
  begin
     WAno := Ano;
     SomaData(dia,mes,Wano,diasAsomar);
     Ano := WAno
  end;

    class procedure TDates.SomaData(var Buff: TypeData; Prazo: Integer);
  Begin
    with TypeData(Buff) Do SomaData(dia,mes,ano,Prazo);
  End;


  class function TDates. FSomaData(Buff:TypeData;Prazo: Integer):TString ;Overload;
  Begin
    SomaData(Buff,Prazo);
    Result := DateToStr(Buff,DateMask_DD_MM_AA);
  End;

    class function TDates.DifeData(const DatAnterior: TypeData;
    const DatAtual: TypeData; const Operador: AnsiChar; const operando: Longint
    ): Boolean;
  {
   Exemplo de uso:

     If DifeDate(dataAnt,DataAtu,'>',10)
     Then
  }
   Type
     DataAtu = Record
                 diaAtu,mesAtu,anoAtu : byte;
               end;
     DataAnt = Record
                 diaAnt,mesAnt,anoAnt : byte;
               end;

   Var
     DifAux       : SmallInt;
   begin
     With DataAtu(DatAtual),DataAnt(DatAnterior) do
     Case operador of
       '=' : If DifeData(diaAnt,mesAnt,anoAnt,DiaAtu,MesAtu,AnoAtu) = operando then
               Result := True
             else
               Result := False;
       '>' : If Abs(DifeData(diaAnt,mesAnt,anoAnt,DiaAtu,MesAtu,AnoAtu)) > operando then
               Result:= True
             else
               Result := False;
  {>=} ')' : If Abs(DifeData(diaAnt,mesAnt,anoAnt,DiaAtu,MesAtu,AnoAtu)) >= operando then
               Result := True
             else
               Result := False;

       '<' : begin
               DifAux := Abs(DifeData(diaAnt,mesAnt,anoAnt,DiaAtu,MesAtu,AnoAtu));
               If (DifAux < operando) And (DifAux >= 0) then
                 Result := True
               else
                 Result := False;
             end;

  { <=}'(' : begin
               DifAux := Abs(DifeData(diaAnt,mesAnt,anoAnt,DiaAtu,MesAtu,AnoAtu));
               If (DifAux <= operando) And (DifAux >= 0) then
                 Result := True
               else
                 Result := False;
             end;

  { <>}'#' : If Abs(DifeData(diaAnt,mesAnt,anoAnt,DiaAtu,MesAtu,AnoAtu)) <> operando then
               Result := True
             else
               Result := False;

     else Begin
            Push_MsgErro('Error em: class function TDates. DiferencaData();');
            RunError(ParametroInvalido);
          end;

     end;
  end;

    class procedure TDates.SomaDataEmMeses(const DataFont: TypeData;
    const Meses: SmallInt; var DataDest: TypeData);
    {Retorna uma data somada sendo que o usa o dia max do mes}
  Begin
    DataDest := DataFont;
    SomaData(DataDest,Meses*30);
    With DataDest do
      Dia := DiaMaxDoMes(Mes,Ano);
  End;

    class procedure TDates.SomeDataPara(const Buff1: TypeData;
    var Buff2: TypeData; const Prazo: Integer);
  { Soma a Buff2 sem alterar a Buff1  }

  {Type TipoData = Record dia,Mes,Ano : Byte end;}

  {Var  Data1 : TipoData Absolute Buff1;
       Data2 : TipoData Absolute Buff2;}
  Begin
  //  MoveData(Buff1,Buff2);
    Buff2 := Buff1;
    with TypeData(Buff2) Do SomaData(dia,mes,ano,Prazo);
  End;


    class function TDates.Dtjuliana(var Buff): TRealNum;
  begin
    With TypeData(Buff) do
      Dtjuliana := Juliano(Dia,Mes,Ano);
  end;

  class procedure TDates. moveData(var dataFonte,dataDestino);
  {  var
      d1 : TypeData  absolute dataFonte;
      d2 : TypeData absolute dataDestino;}
  begin
    TypeData(dataDestino) := TypeData(dataFonte);
  end;

    class function TDates.ConvNomeData(const NomeArqFonte: String;
    NomeArqDestino: String; const Mes, Ano: Byte; var Mensagem: String): String;
  var
    NomeAux        : string[8];
    MsgAux         : String;
    WData          : string[5];
  begin
    Wdata         := strdataMesAno(Mes,Ano);
    if WData <> '' then delete(Wdata,3,1);
    NomeAux       := NomeArqDestino;
    NomeArqDestino:= WData + NomeAux;
    mensagem      := Concat('Copiando o Arquivo ',NomeArqfonte,
                            ' para ',NomeArqDestino,' .');
    ConvNomedata  := NomeArqDestino;
  end;

    class function TDates.StrDataMesAno(const mes, Ano: byte): String;
  const
    dia   : byte = 1;
  var
    ZData : string[8];
    WData : string[5];
  begin
    if mes <> 0 then
    begin
      ZData     := StrData(dia,mes,ano,'/');
      WData     := copy(ZData,4,5);
    end
    else
      WData     := '';
    strDataMesAno := Wdata;
  end;

    class function TDates.DiaMaxDoMes(const Mes: Byte; Ano: Integer): Byte;
  var
    diaMax : byte;

  begin
    diaMax := 0;

    if mes in [4,6,9,11] then
      diaMax := 30
    else
    if mes in [1,3,5,7,8,10,12] then
      diaMax := 31
    else
    if ano mod 4 = 0 then
      diaMax := 29
    else
      diaMax := 28;

    if diaMax = 0 then
      diaMax := 1;

    DiaMaxDoMes := diaMax;
  end;

    class function TDates.FDiaSemana(var BuffData): Byte;

  {Esta funcao falta fazer o tratamento do bug do milenio}
  const
    R      : Array[-1..12] of SmallInt = ( 0,0,0,0,3,3,4,4,5,5,5,6,6,7 );

  Var
  {  Data : TypeData Absolute BuffData;}

    B,D,d1,d2   : longint;
  Begin

    With TypeData(BuffData)  do
    If Dia <> 0 Then
    Begin
      if Mes > 2 then
        B := Ano div 4
      else
        B := (Ano-1) div 4;

      d1 :=  (
              Ano-10
             )
             * 365;
      d2 :=  31
             *
             (
              Mes-1
             );


      D := (
            (d1
             +
             Dia
             +
             d2
             -
             R[Mes]
             +
             B
            )
             +
             4
           )
           mod
            7;


   {   D := (
            (
             (
              data.Ano-10
             )
             * 365
             +
             data.Dia
             +
             31
             *
             (
              data.Mes-1
             )
             -
             R[data.Mes]
             +
             B
            )
             +
             4
           )
           mod
            7; }

      FDiaSemana := byte(d);

    End
    Else
      FDiaSemana := 0;
  End;

    class function TDates.FStrDiaSemana(var data): String;
  Begin
    with TypeData(Data) do
      if dia <> 0 Then
        FStrDiaSemana := StrDiaSemana[FDiaSemana(Data)]
      else
        FStrDiaSemana := '   ';
  End;

  {class function TDates. FDiaSemana (Var BuffData) : Byte;
  const
    R      : Array[-1..12] of SmallInt = ( 0,0,0,0,3,3,4,4,5,5,5,6,6,7 );
  Var
    Data : TypeData Absolute BuffData;
    B    : SmallInt;
  Begin
    With Data  do
    If Dia <> 0 Then
    Begin
      if Mes > 2 then B := Ano div 4 else B := (Ano-1) div 4;
      FDiaSemana := (((Ano-10) * 365 + Dia + 31 * (Mes-1)-R[Mes]+B)+4) mod 7;
    End
    Else
      FDiaSemana := 0;
  End;
  }
    class function TDates.StrMes(const mes: Word): String;
  begin
    case mes of
      1   : StrMes := 'Janeiro'  ;
      2   : StrMes := 'Fevereiro';
      3   : StrMes := 'Maro'    ;
      4   : StrMes := 'Abril'    ;
      5   : StrMes := 'Maio'     ;
      6   : StrMes := 'Junho'    ;
      7   : StrMes := 'Julho'    ;
      8   : StrMes := 'Agosto'   ;
      9   : StrMes := 'Setembro' ;
      10  : StrMes := 'Outubro'  ;
      11  : StrMes := 'Novembro' ;
      12  : StrMes := 'Dezembro' ;
      else  StrMes := ''         ;
    end
  end;


    class function TDates.StrData(const Dia, mes, ano: Word; const ch: AnsiChar
    ): string;
  { Ch =
      ' ' : Retorna AA/MM/DD para ser usado em indices
      '/' : Retorna DD/MM/AA
      ':' : Retorna HH:MM:AA onde DD=Hora e MM=Minutos e AA=Segundos
      'S' : Retorna DDMMAA
      'C' : Retorna a data dia/mes/ano com 4 digitos
      'D' : Retorna a data Ano/mes/dia com o ano de 4 digitos
  }
  var
    StrDataAux : string;
    D,M,A      : String[2];
  begin
    str(dia:1,D);
    str(mes:1,M);
    str(ano:1,A);
    while Length(D) < 2 do insert('0',D,1);
    while Length(M) < 2 do insert('0',M,1);
    while Length(A) < 2 do insert('0',A,1);

    If Ch = ' ' Then
    Begin
      If (ano >= AnoLimit) {or (Dia = 0)}  Then
        strDataAux := Concat(A,M,D)
      Else
      Begin
       strDataAux := AnsiChar(100+Ano) + M + D;
       If Length(strDataAux) = 5 Then
         Insert('0',strDataAux,2);
      End;
    End
    else
    case ch of
      '/' : strDataAux := concat(D,'/',M,'/',A);
      ':' : strDataAux := concat(D,':',M,':',A);
      'S' : strDataAux := concat(D,M,A); {Dia mes ano sem separador}
      'C' : If Ano >= AnoLimit Then {Retorna a data dia/mes/ano com 4 digitos}
              strDataAux := concat(D,'/',M,'/','19'+A)
            Else
              strDataAux := concat(D,'/',M,'/','20'+A);
      'D' : If Ano >= AnoLimit Then {Retorna a data dia/mes/ano com 4 digitos}
              strDataAux := concat('19'+A,'/',M,'/',D)
            Else
              strDataAux := concat('20'+A,'/',M,'/',D);
      'E' : If Ano >= AnoLimit  Then
              StrDataAux := concat(D,' de ',StrMes(mes),' de ','19',A)
            Else
              StrDataAux := concat(D,' de ',StrMes(mes),' de ','20',A)
      else Begin
             Push_MsgErro('Error em: class function TDates. strData();');
             RunError(ParametroInvalido);
           End;
    end;

    if strDataAux <> '00/00/00' then
      strData := strDataAux
    else
      strData := '        ';
  end;


  class function TDates.StringData(const Buff: TypeData; const Ch: AnsiChar  ): String;
  Begin
    with TypeData(Buff) Do
      StringData  := StrData(dia,mes,ano,Ch);
  End;
                        {Buff:TypeData}
    class function TDates.GetDataSistOp(var Buff; const Separador: AnsiChar
    ): String;

    var Dia,Mes,Ano,DiaDaSemana : SmallWord;

  {    Data : Record diaS,MesS,AnoS : Byte End Absolute Buff;}

  Begin

    GetDate(Ano, Mes, Dia, DiaDaSemana);
    If Ano < 2000
    Then Ano := Ano - 1900
    Else Ano := Ano - 2000;

    TypeData(Buff).Dia := Byte(Dia);
    TypeData(Buff).Mes := Byte(Mes);
    TypeData(Buff).Ano := Byte(Ano);


    GetDataSistOp := StringData(TypeData(Buff),Separador);
  End;
  class function TDates. FGetDataSistOp(const Separador:AnsiChar{Pode Ser: '/',':',' '}):String;
    Var
      Data : TypeData;
  Begin
    FGetDataSistOp := GetDataSistOp(Data,Separador);
  End;

  class function TDates. GetDateSystem(const DateMask:TDateMask):String;
  Begin
    Result := DateToStr(GetFTimeDos,DateMask);
  End;

  class function TDates. GetHourSystem(const HourMask :THourMask):String;
  Begin
    Result := HourToStr(GetFTimeDos,HourMask,true);
  End;

  class function TDates. GetFTimeDos:Longint;Overload;
  Var
    DiaDaSemana ,Sec100 : SmallWord;
    Time                : DateTime;
    TimePack            : Longint;
  Begin
    With Time do
    Begin
      GetDate(Year,Month,Day,DiaDaSemana);
      GetTime(Hour,Min  ,Sec,Sec100);
    End;
    PackTime(Time,TimePack); {Obs: Sec100 nao e compactada. }
    GetFTimeDos := TimePack;
  End;

    class function TDates.GetFTimeDos(var wSec1000: SmallInt): Longint; {Data da atualizacao}
  Var
    DiaDaSemana ,Sec100,Sec1000 : SmallWord;

    Time                : DateTime;
    TimePack            : Longint;
  Begin
    Sec1000 := 0;
    With Time do
    Begin
      GetDate(Year,Month,Day,DiaDaSemana);
      GetTime(Hour,Min  ,Sec,Sec100);
    End;

    PackTime(Time,TimePack); //Obs: Sec100 nao e compactada.
    Result   := TimePack;
    wSec1000 := Sec1000;
  End;

    class function TDates.GetFTimeDos(var wSec100: Byte; var wSec1000: SmallInt
    ): Longint; {Data da atualizacao}
  Var
    DiaDaSemana ,Sec100 : SmallWord;
    Time                : DateTime;
    TimePack            : Longint;
  Begin
    With Time do
    Begin
      GetDate(Year,Month,Day,DiaDaSemana);
      GetTime(Hour,Min  ,Sec,Sec100);
    End;
    PackTime(Time,TimePack); {Obs: Sec100 nao e compactada. }
    Result   := TimePack;
    wSec100  := Sec100;
//    wSec1000 := Sec1000;
  End;

  class function TDates. GetFTimeDos_Valid(aTime_UltimoAcesso:Longint;aMinutos_de_tolerancia_do_Ultimo_Acesso:byte):Boolean;

   {
     O time do sistema operacional nao pode ser inferior  aTime_UltimoAcesso -  (60*aMinutos_de_tolerancia_do_Ultimo_Acesso)

   }
    Var
      D  : Longint;
  Begin
    D := GetFTimeDos - aTime_UltimoAcesso;
    If D > 0
    Then Result := true
    Else Begin
           Result := Abs(D) < (60*aMinutos_de_tolerancia_do_Ultimo_Acesso);
         end;
  end;

    class function TDates.PackDate(const Data: TypeData): Longint;
    Var Time : DateTime;
  Begin
    With Data,Time do
    Begin
      if Ano >= AnoLimit
      Then Year := Ano + 1900
      Else Year := Ano + 2000;

      Month := Mes;
      Day:=Dia;

      {Hour:=H; Min:= M; Sec := S ; S100:=0;}
    End;
    PackTime(Time,Result);
  End;


    class function TDates.PackDate(const Data: String; const Mask: TDateMask
    ): Longint;
    Var
      wDate : TypeData;
  Begin
    WDate := StrToDate(Data,Mask)^;
    Result := PackDate(Wdate);
  end;

    class function TDates.PackDate(const Data: String; const Mask: TDateMask;
    TimePack: Longint): Longint;
    //Retorna a data compactada junto com a hora compactada
    Var aData:TypeData;
    Var aHora :TipoHora;
  Begin
    UnPackDateHora(TimePack, aData, aHora);
    aData := StrToDate(Data,Mask)^;
    PackDateHora(aData,aHora,TimePack);
    Result := TimePack;
  end;

    class function TDates.PackHour(const Hora: String; const Mask: THourMask;
    TimePack: Longint): Longint;
    //Retorna a hora compactada junto com a data compactada
    Var aData:TypeData;
    Var aHora :TipoHora;
  Begin
    UnPackDateHora(TimePack, aData, aHora);
    aHora := StrToHora(Hora,Mask);
    PackDateHora(aData,aHora,TimePack);
    Result := TimePack;
  end;

  {class procedure TDates. UnPackDate(Const TimePack:Longint;Var Data:TypeData);}
    class function TDates.UnPackDate(const TimePack: Longint): TypeData;

  Var Time : DateTime;
  Begin
    UnPackTime(TimePack,Time);
    With Result,Time do
    Begin
      If Year < 2000
      Then Ano := Year-1900
      Else Ano := Year-2000;

      Mes := Month; Dia := Day;

      If (Mes = 0) or (Dia =0) Then Ano := 0;
    End;
  End;


    class procedure TDates.UnPackHora(const TimePack: Longint; var Hora: TipoHora
    );
  Var Time : DateTime;
  Begin
    UnPackTime(TimePack,Time);
    With Hora,Time do
    Begin
      H := Hour; M:=Min; S := Sec; S100:=0;
    End;
  End;

    class procedure TDates.PackHora(const Hora: TipoHora; var TimePack: Longint);
    Var
      Time : DateTime;
      Data : TypeData;
  Begin
    GetDataSistOp(Data,'/');
    With Hora,Time do
    Begin
      if Data.Ano >= AnoLimit
      Then Year := Data.Ano + 1900
      Else Year := Data.Ano + 2000;
      Month := Data.Mes;
      Day   := Data.Dia;

      Hour := H;
      Min  := M;
      Sec  := S ;
  //    S100 := 0;
    End;
    PackTime(Time,TimePack);
  end;

    class procedure TDates.PackDateHora(Data: TypeData; Hora: TipoHora;
    var TimePack: Longint);
  Var Time : DateTime;
  Begin
    With Data,Hora,Time do
    Begin
      if Ano >= AnoLimit
      Then Year := Ano + 1900
      Else Year := Ano + 2000;

      Month := Mes; Day:=Dia;

      Hour:=H; Min:= M; Sec := S ; S100:=0;
    End;
    PackTime(Time,TimePack);
  End;

    class procedure TDates.UnPackDateHora(const TimePack: Longint;
    var Data: TypeData; var Hora: TipoHora);
  Var Time : DateTime;
  Begin
    UnPackTime(TimePack,Time);
    With Data,Hora,Time do
    Begin
      If Year < 2000
      Then Ano := Year-1900
      Else Ano := Year-2000;
      Mes := Month; Dia := Day;
      H := Hour; M:=Min; S := Sec;
      S100:=0;
    End;
  End;


    class function TDates.StringTimeD(const TimePack: Longint; const Ch: AnsiChar
    ): String;
  Var  Data : TypeData;
  Begin
    Data := UnPackDate(TimePack);
    with Data Do StringTimeD := StrData(dia,mes,ano,Ch);
  End;

    class function TDates.StringTimeH(const TimePack: Longint): String;
  Var  Hora : TipoHora;
  Begin
    UnPackHora(TimePack,Hora);
    with Hora Do StringTimeH := StrData(H,M,S,':');
  End;
    class function TDates.StringTimeHSemPonto(const TimePack: Longint): String;
  Var  Hora : TipoHora;
  Begin
    UnPackHora(TimePack,Hora);
    with Hora Do StringTimeHSemPonto := StrData(H,M,S,'S');
  End;


  {INIcio funcoes que tratam datas com longint }


  class function TDates.  Julian( Year, Month, Day : Word ) : LongInt;
  Var
     Temp, Answer : TRealNum;
  begin
     if (Year < 90) then
       Year := Year + 2000    { 2000-2090 }
     else
       if (Year < 100) then
         Year := Year + 1900; { 1990-1999 }

     Temp := int((Month-14.0) / 12.0);

     Answer := Day - 32075.0 +
               int(1461.0 * (Year + 4800.0 + Temp) / 4.0) +
               int(367.0 * (Month - 2.0 - Temp * 12.0) / 12.0) -
               int(3.0 * int((Year + 4900.0 + Temp) /100.0) / 4.0);

     Result :=Longint(trunc(Answer));
  end;


  class function TDates. str2jul(DateStr:string): longint;
  var m,d,y:SmallInt;
      Err  : Integer;
  begin
    if length(datestr)=8
    then Datestr := Datestr[1]+Datestr[2]+Datestr[4]+Datestr[5]+Datestr[7]+Datestr[8];

    if (length(DateStr)<>6)
    then str2jul:= -1
    else begin
            m:=0;
            d:=0;
            y:=0;

            val(copy(DateStr,1,2),m,Err);
            val(copy(DateStr,3,2),d,Err);
            val(copy(DateStr,5,2),y,Err);

            str2jul:= julian(y,m,d);
          end;

     TaStatus := Err;

     If TaStatus <> 0
     Then MI_MsgBox.MessageBox('A data '+DateStr+' esta com formato inv lido!. Corrija-o por favor.');
        //   StrMessageBox('Genericos',
        //                'Datas',
        //                'class function TDates. str2jul',
        //                'A data '+DateStr+' esta com formato inv lido!. Corrija-o por favor.',
        //                'Db_Datas.PAS'
        //               )
        //);
  end;

  class function TDates. jul2str(JulDate:longint) :string;
  Var
     Tmp_A, Tmp_B: TRealNum;
     var y,m,d:word;
     tstr1,tstr2:string;
  begin
    if (JulDate<=0) then jul2str:='' else
    begin
      Tmp_A := JulDate + 68569.0;
      Tmp_B := int(4.0 * Tmp_A / 146097.0);
      Tmp_A := Tmp_A - int((146097.0 * Tmp_B + 3.0) / 4.0);
      Y     := trunc(4000.0 * (Tmp_A + 1.0) / 1461001.0);
      Tmp_A := Tmp_A - int(1461.0 * Y / 4.0) + 31.0;
      M     := trunc (80.0 * Tmp_A / 2447.0);
      D     := trunc (Tmp_A - int(2447.0 * M / 80.0));
      Tmp_A := int (M / 11.0);
      M     := trunc (M + 2.0 - 12.0 * Tmp_A);
      Y     := trunc(100.0 * (Tmp_B - 49.0) + Y + Tmp_A) MOD 100;

      str(m,tstr1); tstr1:=copy('00'+tstr1,length(tstr1)+1,2);
      tstr2:=tstr1;

      str(d,tstr1); tstr1:=copy('00'+tstr1,length(tstr1)+1,2);
      tstr2:=tstr2+tstr1;

      str(y,tstr1); tstr1:=copy('00'+tstr1,length(tstr1)+1,2);

      jul2str:=tstr2+tstr1;
    end;
  end;

  class function TDates. LeapYear ( Year : Word ) : Boolean ;
  {Ano Bisexto}
  Begin
     If (((Year MOD 4) = 0) and ((Year MOD 100) > 0))
     or (( Year MOD 400 ) = 0 )
     then LeapYear   :=  TRUE
     else LeapYear   :=  FALSE;
  End;

  class function TDates. ValidDate( aData : TypeData):Byte;
    { Reorna
        0 : se a data e valida;
        1 : Se o dia é unvalido;
        2 : Se o mes e invalido;
    }
  Begin
    If aData.dia > DiaMaxMes(aData)
    Then Result := 1
    Else If (aData.Mes <> 0) // devo checar se o dia <> 0
         Then  Begin
                 if (aData.dia <> 0)
                 Then Begin
                        if aData.Mes in [1..12]
                        Then Result := 0
                        else Result := 2
                      End
                 Else Result := 1; // o dia = zero e mes <> 0 erro
               End
         Else  if (aData.dia <> 0)
               Then Result := 1 // o dia <> zero e mes = 0 erro
               else Result := 0; // data valida
  end;


  class function TDates. ValidHour( H,M,S,S100 : Word):Byte;
    { Reorna
        0 : se a hora e valida;
        1 : Se o Hora é unvalido;
        2 : Se os Minutos e invalido;
        3 : Se os segundos e invalido;
        4 : Se os centecimos de segundos e invalido;
    }
  Begin
    If H > 60
    Then Result := 1
    Else If M > 60
         Then Result := 2
         Else If S > 60
              Then Result := 3
              ELse If S100 > 100
                   Then Result := 4
                   Else Result := 0;
  end;


  class function TDates.getDateStr :tstring ;
    var
      year,month,day,dayofweek:SmallWord;
  begin
     getdate (year,month , day , dayofweek );
     getdatestr := istr(day,'dd' )+ '-'+
                   iStr (month,'mm' )+ '-'+
                   iStr(year,'aaaa' )
                   ;
  end ;

  class  function TDates.getTimeStr :tstring ;
    var
      hour, minute, second, sec100: SmallWord;
  begin
    gettime (hour,minute, second,sec100);
    gettimestr:= iStr (hour,'HH')+ ':'+
                 iStr (minute,'MM')+ ':'+
                 istr (second,'ss');
  end ;


  {Fim funcoes que tratam datas com longint }




initialization

  with TDates do
  begin
    GetDataSistOp(DataSistOp,'/');
  //  MoveData(DataSistOp,DataAtual);
  //  DateAtual := @DataAtual;

    With DataMinima do Begin dia := 1;
                             mes := 1;
                             Ano := AnoLimit
                       End;

    With DataMaxima do Begin dia := 31;
                             mes := 12;
                             Ano := AnoLimit-1;
                       End;
  end;


end.


