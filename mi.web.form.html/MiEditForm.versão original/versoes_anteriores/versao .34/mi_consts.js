// mi_consts.js
// Classe com as constantes do projeto

export class MiConsts {
    constructor() {
        this.state = 0; // Inicializa o estado como 0
    }
    
    // Mapas de bits usados para controle de estado
    static Mb_Bit00 = 0x0001;  // 0
    static Mb_Bit01 = 0x0002;  // 1
    static Mb_Bit02 = 0x0004;  // 2
    static Mb_Bit03 = 0x0008;  // 3
    static Mb_Bit04 = 0x0010;  // 4
    static Mb_Bit05 = 0x0020;  // 5
    static Mb_Bit06 = 0x0040;  // 6
    static Mb_Bit07 = 0x0080;  // 7
    static Mb_Bit08 = 0x0100;  // 8
    static Mb_Bit09 = 0x0200;  // 9
    static Mb_Bit10 = 0x0400;  // A
    static Mb_Bit11 = 0x0800;  // B
    static Mb_Bit12 = 0x1000;  // C
    static Mb_Bit13 = 0x2000;  // D
    static Mb_Bit14 = 0x4000;  // E
    static Mb_Bit15 = 0x8000;  // F
    static Mb_Bit16 = 0x10000; // 10
    static Mb_Bit17 = 0x20000; // 11
    static Mb_Bit18 = 0x40000; // 12
    static Mb_Bit19 = 0x80000; // 13
    static Mb_Bit20 = 0x100000; // 14
    static Mb_Bit21 = 0x200000; // 15
    static Mb_Bit22 = 0x400000; // 16
    static Mb_Bit23 = 0x800000; // 17
    static Mb_Bit24 = 0x1000000; // 18
    static Mb_Bit25 = 0x2000000; // 19
    static Mb_Bit26 = 0x4000000; // 1A
    static Mb_Bit27 = 0x8000000; // 1B
    static Mb_Bit28 = 0x10000000; // 1C
    static Mb_Bit29 = 0x20000000; // 1D
    static Mb_Bit30 = 0x40000000; // 1E
    static Mb_Bit31 = 0x80000000; // 1F    


    // Definindo as constantes para os estados
    static Mb_St_Focused = MiConsts.Mb_Bit00;
    static Mb_St_Creating = MiConsts.Mb_Bit01;
    static Mb_St_Creating_Index = MiConsts.Mb_Bit02;
    static Mb_St_Indexing = MiConsts.Mb_Bit03;
    static Mb_St_Creating_Relating = MiConsts.Mb_Bit04;
    static Mb_St_Related = MiConsts.Mb_Bit05;
    static Mb_St_Active = MiConsts.Mb_Bit06;
    static Mb_St_Edit = MiConsts.Mb_Bit07;
    static Mb_St_Locked = MiConsts.Mb_Bit08;
    static Mb_St_AddRec = MiConsts.Mb_Bit09;
    static Mb_St_UpdateRec = MiConsts.Mb_Bit10;
    static Mb_St_DeleteRec = MiConsts.Mb_Bit11;
    static Mb_St_Report = MiConsts.Mb_Bit12;
    static Mb_St_Synchronizing = MiConsts.Mb_Bit13;
    static Mb_St_NonCriticIfActiveCommands = MiConsts.Mb_Bit14;
    static Mb_OnCalcRecord = MiConsts.Mb_Bit15;
    static Mb_Destroying = MiConsts.Mb_Bit16;
    static Mb_St_Creating_Template = MiConsts.Mb_Bit17;
    static Mb_St_DB_Connecting = MiConsts.Mb_Bit18;
    static Mb_St_Insert = MiConsts.Mb_Bit19;
    static Mb_St_Browse = MiConsts.Mb_Bit20;
    static Mb_St_ControlsEnabled = MiConsts.Mb_Bit21;

    // Método para definir o estado e retornar o estado anterior
    setState(stateBit, enable) {
        // Verifica se o estado desejado já está ativado (estado anterior)
        let result = (this.state & stateBit) !== 0;

        // Atualiza o estado com base na variável enable
        if (enable) {
            this.state |= stateBit; // Ativa o estado
        } else {
            this.state &= ~stateBit; // Desativa o estado
        }

        // Retorna o estado anterior (se o bit estava ativado ou não)
        return result;
    }


    // Método para obter o estado
    getState(stateBit) {
        return (this.state & stateBit) !== 0; // Retorna verdadeiro se o bit estiver ativo
    }

    //Implementação da função format value

    // Definindo as constantes como propriedades estáticas da classe
    static DecimalSeparator = '.';
    static showDecimalSeparator = '.';

    static fldAnsiChar = 'C';
    static fldAnsiCharAlfa = 'c';
    static fldAnsiCharNum = 'N';
    static fldAnsiCharNumPositive = '0';
    static fldStrNumber = '#';
    static fldStr = 'S';
    static fldStrAlfa = 's';
    static fldExtended = 'E';
    static fldDouble = 'R';
    static fldReal4 = 'O';
    static fldReal4Positivo = 'o';
    static fldReal4P = 'P';
    static fldReal4PPositivo = 'p';
    static fldDoublePositive = 'r';
    static fldBoolean = 'X';
    static fldByte = 'B';
    static fldShortInt = 'J';
    static fldSmallWord = 'W';
    static fldSmallInt = 'I';
    static fldLongInt = 'L';
    static FldRadioButton = 'K';

    // Método formatValue agora acessa as propriedades estáticas
    
        static formatValue(aValue, aMask) {
      
          let result = '';
          let R;
          let s = '';
      
          if (aMask[0] === MiConsts.FldDateTime) {
            result = aValue; // Processamento de DateTime omitido
          } else {
            // Checa se a máscara é número relativo
            if (MiConsts.aMask.includes(MiConsts.fldReal4P) || aMask.includes(MiConsts.fldReal4PPositivo)) {
              R = aValue * 100;
              s = R;
              if (s.includes(MiConsts.showDecimalSeparator)) {
                s = s.replace(MiConsts.showDecimalSeparator, MiConsts.DecimalSeparator);
              }
            } else {
              s = String(aValue);
            }
      
            let LenS = s.length;
            let Len_aMask = aMask.length;
      
            // Gera a máscara
            for (let i = Len_aMask - 1; i >= 0; i--) {
              switch (aMask[i]) {
                case MiConsts.fldAnsiChar:
                case MiConsts.fldAnsiCharAlfa:
                case MiConsts.fldAnsiCharNum:
                case MiConsts.fldAnsiCharNumPositive:
                case MiConsts.fldDouble:
                case MiConsts.fldDoublePositive:
                case MiConsts.fldStrNumber:
                case MiConsts.fldStrAlfa:
                case MiConsts.fldReal4:
                case MiConsts.fldReal4Positivo:
                case MiConsts.fldReal4P:
                case MiConsts.fldReal4PPositivo:
                case MiConsts.fldExtended:
                case MiConsts.fldENum:
                case MiConsts.fldENum_db:
                case MiConsts.fldBoolean:
                case MiConsts.fldByte:
                case MiConsts.fldShortInt:
                case MiConsts.fldSmallWord:
                case MiConsts.fldSmallInt:
                case MiConsts.fldLongInt:
                case MiConsts.FldRadioButton:
                  if (LenS >= 1) {
                    if ([MiConsts.fldDouble, 
                         MiConsts.fldReal4, 
                         MiConsts.fldReal4P, 
                         MiConsts.fldReal4PPositivo, 
                         MiConsts.fldDoublePositive, 
                         MiConsts.fldExtended].includes(aMask[i])) {
                           if (s[LenS - 1] === MiConsts.DecimalSeparator) {
                             LenS--;
                            }
                            result = s[LenS - 1] + result;
                         } 
                        else {
                              result = s[LenS - 1] + result;
                             }
                  }
                  LenS--;
                  break;
                case MiConsts.fldStr:
                  if (LenS >= 1) {
                    result = s[LenS - 1].toUpperCase() + result;
                  }
                  LenS--;
                  break;
                default:
                  if (LenS >= 1) {
                    result = aMask[i] + result;
                  }
                  break;
              }
            }
          }      
          return result;
        }
      
         


}
