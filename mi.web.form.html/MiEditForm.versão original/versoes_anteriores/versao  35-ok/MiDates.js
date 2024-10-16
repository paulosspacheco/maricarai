import { MiConsts } from './MiConsts.js';

// Classe TDates que estende MiConsts para tratamento de datas
export class MiDates extends MiConsts {
    // Função auxiliar para adicionar zeros à esquerda
    static leftFillChar(value, length, padChar = '0') {
        return value.toString().padStart(length, padChar);
    }    

    static maskToMaskDateTime(aMask) {
        let result;

        switch (aMask) {
            case MiConsts.TMask.Mask_yy_mm_dd:
                result = 'yy/mm/dd';
                break;
            case MiConsts.TMask.Mask_yyyy_mm_dd:
                result = 'yyyy/mm/dd';
                break;
            case MiConsts.TMask.Mask_dd_mm_yy:
                result = 'dd/mm/yy';
                break;
            case MiConsts.TMask.Mask_dd_mm_yyyy:
                result = 'dd/mm/yyyy';
                break;
            case MiConsts.TMask.Mask_dd_mm_yyyy_hh_nn:
                result = 'dd/mm/yyyy hh:nn';
                break;
            case MiConsts.TMask.Mask_mm_yyyy:
                result = 'mm/yyyy';
                break;
            case MiConsts.TMask.Mask_dd_mm_yy_hh_nn_ss:
                result = 'dd/mm/yy hh:nn:ss';
                break;
            case MiConsts.TMask.Mask_dd_mm_yy_hh_nn:
                result = 'dd/mm/yy hh:nn';
                break;
            case MiConsts.TMask.Mask_dd_mm_yyyy_hh_nn_ss:
                result = 'dd/mm/yyyy hh:nn:ss';
                break;
            case MiConsts.TMask.Mask_hh_nn:
                result = 'hh:nn';
                break;
            case MiConsts.TMask.Mask_hh_nn_ss:
                result = 'hh:nn:ss';
                break;
            case MiConsts.TMask.Mask_hh_nn_ss_zzz:
                result = 'hh:nn:ss.zzz';
                break;
            case MiConsts.TMask.Mask_Extenco:
                result = 'ddd of mmm of yyyy';
                break;
            default:
                result = '';
                break;
        }

        return result;
    }

    static maskDateTimeToMask(aMaskDateTime) {
        const masks = [
            'yy/mm/dd',  // 0
            'yyyy/mm/dd', // 1
            'dd/mm/yy',   // 2
            'dd/mm/yyyy', // 3
            'dd/mm/yyyy hh:nn', // 4
            'mm/yyyy',    // 5
            'dd/mm/yy hh:nn:ss', // 6
            'dd/mm/yy hh:nn',    // 7
            'dd/mm/yyyy hh:nn:ss', // 8
            'hh:nn',              // 9
            'hh:nn:ss',           // 10
            'hh:nn:ss.zzz',       // 11
            'ssssssssssssssssssssssssssssssssss' // 12
        ];

        const index = masks.indexOf(aMaskDateTime);

        switch (index) {
            case 0:
                return MiConsts.TMask.Mask_yy_mm_dd;
            case 1:
                return MiConsts.TMask.Mask_yyyy_mm_dd;
            case 2:
                return MiConsts.TMask.Mask_dd_mm_yy;
            case 3:
                return MiConsts.TMask.Mask_dd_mm_yyyy;
            case 4:
                return MiConsts.TMask.Mask_dd_mm_yyyy_hh_nn;
            case 5:
                return MiConsts.TMask.Mask_mm_yyyy;
            case 6:
                return MiConsts.TMask.Mask_dd_mm_yy_hh_nn_ss;
            case 7:
                return MiConsts.TMask.Mask_dd_mm_yy_hh_nn;
            case 8:
                return MiConsts.TMask.Mask_dd_mm_yyyy_hh_nn_ss;
            case 9:
                return MiConsts.TMask.Mask_hh_nn;
            case 10:
                return MiConsts.TMask.Mask_hh_nn_ss;
            case 11:
                return MiConsts.TMask.Mask_hh_nn_ss_zzz;
            case 12:
                return MiConsts.TMask.Mask_Extenco;
            default:
                return MiConsts.TMask.Mask_Invalid;
        }
    }
    
    static maskDateTimeToMaskEdit(aMaskDateTime) {
      const maskList = [
          'yy/mm/dd',  // 00
          'yyyy/mm/dd', // 01
          'dd/mm/yy',   // 02
          'dd/mm/yyyy', // 03
          'dd/mm/yyyy hh:nn', // 04
          'mm/yyyy',    // 05
          'dd/mm/yy hh:nn:ss',   // 06
          'dd/mm/yy hh:nn',      // 07
          'dd/mm/yyyy hh:nn:ss', // 08
          'hh:nn',               // 09
          'hh:nn:ss',            // 10
          'hh:nn:ss.zzz',        // 11
          'ssssssssssssssssssssssssssssssssss' // 12
      ]; 
      const index = maskList.indexOf(aMaskDateTime);      
      switch (index) {
          case 0: return '##/##/##';
          case 1: return '####/##/##';
          case 2: return '##/##/##';
          case 3: return '##/##/####';
          case 4: return '##/##/####-##:##';
          case 5: return '######';
          case 6: return '##/##/##-##:##:##';
          case 7: return '##/##/##-##:##';
          case 8: return '##/##/####-##:##:##';
          case 9: return '##:##';
          case 10: return '##:##:##';
          case 11: return '##:##:##.###';
          case 12: return 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa';
          default: return '';
      }
    }
  
    static maskToMaskEdit(aMask) {
      switch (aMask) {
          case MiConsts.TMask.Mask_yy_mm_dd:
              return '##/##/##';
          case MiConsts.TMask.Mask_yyyy_mm_dd:
              return '####/##/##';
          case MiConsts.TMask.Mask_dd_mm_yy:
              return '##/##/##';
          case MiConsts.TMask.Mask_dd_mm_yyyy:
              return '##/##/####';
          case MiConsts.TMask.Mask_dd_mm_yyyy_hh_nn:
              return '##/##/####-##:##';
          case MiConsts.TMask.Mask_mm_yyyy:
              return '##/####';
          case MiConsts.TMask.Mask_dd_mm_yy_hh_nn_ss:
              return '##/##/##-##:##:##';
          case MiConsts.TMask.Mask_dd_mm_yy_hh_nn:
              return '##/##/##-##:##';
          case MiConsts.TMask.Mask_dd_mm_yyyy_hh_nn_ss:
              return '##/##/####-##:##:##';
          case MiConsts.TMask.Mask_hh_nn:
              return '##:##';
          case MiConsts.TMask.Mask_hh_nn_ss:
              return '##:##:##';
          case MiConsts.TMask.Mask_hh_nn_ss_zzz:
              return '##:##:##.###';
          case MiConsts.TMask.Mask_Extenco:
              return 'ssssssssssssssssssssssssssssssssss';
          default:
              return '';
      }
    }    

    static getMask(templateOrg) {
        let result;
        let ws = '';
           
        const TypeCode = templateOrg.charAt(0); // Extrai o primeiro caractere de templateOrg
    
        // Verifica se o template tem mais de 2 caracteres e se o primeiro caractere é 'D'
        if (templateOrg.length > 2 && TypeCode === MiConsts.fldDateTime) {
            // Extrai parte do template a partir do segundo caractere
            ws = templateOrg.substring(1); // Começa do índice 1 (equivalente a Copy(Template_org, 2,...))
    
            if (ws !== '') {
                // Chame sua função equivalente a maskDateTimeToMask
                result = MiDates.maskDateTimeToMask(ws);
            } else {
                result = 'Mask_Invalid'; // Substitua com o valor equivalente para Mask_Invalid
            }
        } else {
            result = 'Mask_Invalid'; // Substitua com o valor equivalente para Mask_Invalid
        }
    
        return result;
    }   
   

    static formatDateTime(s, aMask) {

        function isValidDate(s) {
          if (s.length < 6 && !s.includes('/')) return false;
          if (s.startsWith('00')) return false;
          return true;
        }
    
        function formatDate(s, aMask) {
          let dia, mes, ano, posDia, posMes, posAno;
    
          switch (aMask) {
            case MiConsts.TMask.Mask_yy_mm_dd:
              if (!isValidDate(s)) return '';
              if (s.length === 6 && !s.includes('/')) {
                ano = s.substring(0, 2);
                mes = s.substring(2, 4);
                dia = s.substring(4, 6);
              } else {
                posAno = s.indexOf('/');
                posMes = s.indexOf('/', posAno + 1);
                ano = s.substring(0, posAno);
                mes = s.substring(posAno + 1, posMes);
                dia = s.substring(posMes + 1, posMes + 3);
              }
              return `${MiDates.leftFillChar(ano, 2)}/${MiDates.leftFillChar(mes, 2)}/${MiDates.leftFillChar(dia, 2)}`;
    
            case MiConsts.TMask.Mask_dd_mm_yy:
              if (!isValidDate(s)) return '';
              if (s.length === 6 && !s.includes('/')) {
                dia = s.substring(0, 2);
                mes = s.substring(2, 4);
                ano = s.substring(4, 6);
              } else if (s.length === 8 && !s.includes('/')) {
                dia = s.substring(0, 2);
                mes = s.substring(2, 4);
                ano = s.substring(4, 8);
              } else {
                posDia = s.indexOf('/');
                posMes = s.indexOf('/', posDia + 1);
                dia = s.substring(0, posDia);
                mes = s.substring(posDia + 1, posMes);
                ano = s.substring(s.length - 2);
              }
              return `${MiDates.leftFillChar(dia, 2)}/${MiDates.leftFillChar(mes, 2)}/${MiDates.leftFillChar(ano, 2)}`;
    
            case MiConsts.TMask.Mask_yyyy_mm_dd:
              if (!isValidDate(s)) return '';
              if (s.length === 8 && !s.includes('/')) {
                ano = s.substring(0, 4);
                mes = s.substring(4, 6);
                dia = s.substring(6, 8);
              } else {
                posAno = s.indexOf('/');
                posMes = s.indexOf('/', posAno + 1);
                ano = s.substring(0, posAno);
                mes = s.substring(posAno + 1, posMes);
                dia = s.substring(posMes + 1, posMes + 3);
              }
              return `${MiDates.leftFillChar(ano, 4)}/${MiDates.leftFillChar(mes, 2)}/${MiDates.leftFillChar(dia, 2)}`;
    
            case MiConsts.TMask.Mask_dd_mm_yyyy:
              if (!isValidDate(s)) return '';
              if (s.length === 8 && !s.includes('/')) {
                dia = s.substring(0, 2);
                mes = s.substring(2, 4);
                ano = s.substring(4, 8);
              } else {
                posDia = s.indexOf('/');
                posMes = s.indexOf('/', posDia + 1);
                dia = s.substring(0, posDia);
                mes = s.substring(posDia + 1, posMes);
                ano = s.substring(posMes + 1, posMes + 5);
              }
              return `${MiDates.leftFillChar(dia, 2)}/${MiDates.leftFillChar(mes, 2)}/${MiDates.leftFillChar(ano, 4)}`;
          }
          return '';
        }
    
        function formatTime(s, aMask) {
          let hora, minuto, segundo, milesimo, posH, posM, posS100;
    
          switch (aMask) {
            case MiConsts.TMask.Mask_hh_nn:
              if (s.length < 4 && !s.includes(':')) throw new Error('Hora inválida!');
              if (s.length === 4 || (s.length === 6 && !s.includes(':'))) {
                hora = s.substring(0, 2);
                minuto = s.substring(2, 4);
              } else {
                posH = 0;
                posM = s.indexOf(':');
                hora = s.substring(0, posM);
                minuto = s.substring(posM + 1, posM + 3);
              }
              return `${MiDates.leftFillChar(hora, 2)}:${MiDates.leftFillChar(minuto, 2)}:00`;
    
            case MiConsts.TMask.Mask_hh_nn_ss:
              if (s.length < 6 && !s.includes(':')) throw new Error('Hora inválida!');
              if (s.length === 6 && !s.includes(':')) {
                hora = s.substring(0, 2);
                minuto = s.substring(2, 4);
                segundo = s.substring(4, 6);
              } else {
                posH = s.indexOf(':');
                posM = s.indexOf(':', posH + 1);
                hora = s.substring(0, posH);
                minuto = s.substring(posH + 1, posM);
                segundo = s.substring(s.length - 2);
              }
              return `${MiDates.leftFillChar(hora, 2)}:${MiDates.leftFillChar(minuto, 2)}:${MiDates.leftFillChar(segundo, 2)}`;
    
            case MiConsts.TMask.Mask_hh_nn_ss_zzz:
              if (s.length < 9 && !s.includes(':')) throw new Error('Hora inválida!');
              if (s.length === 9 && !s.includes(':')) {
                hora = s.substring(0, 2);
                minuto = s.substring(2, 4);
                segundo = s.substring(4, 6);
                milesimo = s.substring(6, 9);
              } else {
                posH = s.indexOf(':');
                posM = s.indexOf(':', posH + 1);
                posS100 = s.indexOf('.', posM + 1);
                hora = s.substring(0, posH);
                minuto = s.substring(posH + 1, posM);
                segundo = s.substring(posM + 1, posS100);
                milesimo = s.substring(posS100 + 1, posS100 + 4);
              }
              return `${MiDates.leftFillChar(hora, 2)}:${MiDates.leftFillChar(minuto, 2)}:${MiDates.leftFillChar(segundo, 2)}.${MiDates.leftFillChar(milesimo, 3)}`;
          }
          return '';
        }
    
        // Decidir se é data, hora ou data e hora
        if (aMask.includes('yy') || aMask.includes('yyyy')) {
          const posSpace = s.indexOf(' ');
          if (posSpace !== -1) {
            const data = s.substring(0, posSpace);
            const hora = s.substring(posSpace + 1);
            const formattedData = formatDate(data, aMask);
            let formattedTime;
            switch (aMask) {
              case MiConsts.TMask.Mask_dd_mm_yy_hh_nn_ss:
                formattedTime = formatTime(hora, MiConsts.TMask.Mask_hh_nn_ss);
                break;
              case MiConsts.TMask.Mask_dd_mm_yy_hh_nn:
                formattedTime = formatTime(hora, MiConsts.TMask.Mask_hh_nn);
                break;
              case MiConsts.TMask.Mask_dd_mm_yyyy_hh_nn_ss:
                formattedTime = formatTime(hora, MiConsts.TMask.Mask_hh_nn_ss);
                break;
              case MiConsts.TMask.Mask_dd_mm_yyyy_hh_nn:
                formattedTime = formatTime(hora, MiConsts.TMask.Mask_hh_nn);
                break;
            }
            return `${formattedData} ${formattedTime}`;
          } else {
            return formatDate(s, aMask);
          }
        } else {
          return formatTime(s, aMask);
        }
      }   
}



