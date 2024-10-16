// MiMethods.js
import { MiConsts } from './MiConsts.js';
import { MiDates } from './MiDates.js';

// Classe com as constantes do projeto
export class MiMethods extends MiConsts{
    constructor() {
        super(); // Chama o construtor da classe pai
    }
        
    static isDateTime(aTemplate) {
        // Função simulada para converter a máscara (substituindo MaskEdit_to_Mask do Pascal)
        function maskEditToMask(template) {
            const MASK_INVALID = 'MASK_INVALID';
            
            // Aqui você precisa implementar a lógica que valida o template como uma máscara de data/hora
            // Por exemplo, se o template for válido, retorna um valor diferente de MASK_INVALID
            // Caso contrário, retorna MASK_INVALID
            
            // Exemplo simples de validação (você deve ajustar conforme a lógica de maskEditToMask do seu sistema):
            const validMaskRegex = /^\d{2}\/\d{2}\/\d{4}\s\d{2}:\d{2}:\d{2}$/; // Exemplo de máscara para "dd/MM/yyyy HH:mm:ss"
            
            if (validMaskRegex.test(template)) {
            return 'VALID_MASK'; // Se for válida, retorna uma máscara qualquer
            } else {
            return MASK_INVALID;
            }
        }
        
        return maskEditToMask(aTemplate) !== 'MASK_INVALID';
    }
    

    static TypeFld(aTemplate) {
        let i, j;       

        if (this.isDateTime(aTemplate)) {            
            return miconsts.FldDateTime;
        } else {
            for (i = 0; i < aTemplate.length; i++) {
                // Verifica se o caractere não é de formatação ou separação de campo
                if (![' ', 'z', 'Z', '\0'].includes(aTemplate[i])) {
                    switch (aTemplate[i]) {
                        case MiConsts.fldStrNumber:
                        case MiConsts.fldStrAlfa:
                        case MiConsts.fldStr:                            
                            return aTemplate[i];

                        case MiConsts.fldAnsiChar:
                        case MiConsts.fldAnsiCharAlfa:
                        case MiConsts.fldAnsiCharNumPositive:
                        case MiConsts.fldAnsiCharNum:                            
                            return aTemplate[i];

                        case MiConsts.FldOperador:
                        // case MiConsts.^X:
                        case MiConsts.fldBoolean:
                        case MiConsts.fldByte:
                        case MiConsts.fldShortInt:                            
                            return aTemplate[i];

                        case MiConsts.fldSmallWord:                            
                            return aTemplate[i];

                        case MiConsts.fldSmallInt:                            
                            return aTemplate[i];

                        case MiConsts.CharExecAction:
                        case MiConsts.fldAPPEND:
                        case MiConsts.fldSItems:
                        case MiConsts.FldDateTime:
                        case MiConsts.fldLHora:
                        case MiConsts.fld_LHora:                            
                            return aTemplate[i];

                        case MiConsts.fldENum:
                        case MiConsts.fldENum_db:
                        case MiConsts.fldLongInt:                            
                            return aTemplate[i];

                        case MiConsts.fldDouble:
                        case MiConsts.fldDoublePositive:                            
                            return aTemplate[i];

                        case MiConsts.fldReal4:
                        case MiConsts.fldReal4Positivo:
                        case MiConsts.fldReal4P:
                        case MiConsts.fldReal4PPositivo:                            
                            return aTemplate[i];

                        case MiConsts.fldExtended:                            
                            return aTemplate[i];

                        case MiConsts.FldRadioButton:
                            return aTemplate[i];

                        case MiConsts.FldMemo:
                        case MiConsts.fldBLOb:                            
                            return aTemplate[i];

                        case MiConsts.CharShowPassword:
                        case MiConsts.fldZEROMOD:
                        case MiConsts.fldCONTRACTION:
                        case MiConsts.fldHexValue:                            
                            return aTemplate[i];

                        default:
                            return '\0'; // Tipo indefinido
                    }
                }
            }
            return '\0'; // Tipo indefinido
    }
        }
    
    // Função auxiliar para simular sizeof
    static sizeOf(type) {
        const sizes = {
            'TDateTime': 8,
            'byte': 1,
            'SmallWord': 2,
            'SmallInt': 2,
            'Longint': 4,
            'TRealNum': 8,
            'Real': 4,
            'Extended': 10
        };
        return sizes[type] || 0;
    }

    static isNumberReal(aTemplate) {
        const type = MiMethods.TypeFld(aTemplate);
        switch (type) {
            case MiConsts.fldExtended:
            case MiConsts.fldDouble:
            case MiConsts.fldDoublePositive:
            case MiConsts.fldReal4Positivo:
            case MiConsts.fldReal4PPositivo:
            case MiConsts.fldReal4:
            case MiConsts.fldReal4P:
                return true;
            default:
                return false;
        }
    }

    static isNumberInteger(aTemplate) {
        const type = MiMethods.TypeFld(aTemplate);
        switch (type) {
            case MiConsts.fldByte:
            case MiConsts.fldShortInt:
            case MiConsts.fldSmallWord:
            case MiConsts.fldSmallInt:
            case MiConsts.fldLongInt:
            case MiConsts.fldHexValue:
            case MiConsts.fldENum:
            case MiConsts.fldENum_db:
                return true;
            default:
                return false;
        }
    }

    static isNumber(aTemplate) {
        return MiMethods.isNumberInteger(aTemplate) || MiMethods.isNumberReal(aTemplate);
    }

    /**
    * Gera uma string preenchida com um caractere específico.
    * 
    * @param {number} i - O número de vezes que o caractere deve ser repetido.
    * @param {string} a - O caractere a ser repetido (deve ser uma string de comprimento 1).
    * @returns {string} - A string gerada ou uma string vazia se i for menor ou igual a 0.
    */
    static conststr(i, a) {
        let result = '';
    
        // Verifica se i é maior que 0
        if (i > 0) {
            // Verifica se 'a' é um caractere válido
            if (typeof a === 'string' && a.length === 1) {
                result = a.repeat(i); // Repete o caractere 'a' i vezes
            } else {
                throw new Error("O parâmetro 'a' deve ser uma string de comprimento 1.");
            }
        }
    
        return result; // Retorna a string gerada ou uma string vazia
    }

    static deleteMaskValid(s, validSet) {
        /**
        * Inclui um conjunto de caracteres a tString
        *
        * Exemplo:
        * S := '"Paulo.Sergio Idade: 1958"';
        * DeleteMaskValid(S, ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']);
        *
        * Resultado: 1958
        */
        let result = '';
        
        for (let i = 0; i < s.length; i++) {
            if (validSet.includes(s[i])) {
                result += s[i];
            }
        }

        return result;
    }

    static deleteMaskInvalid(invalidSet,s) {
        let result = '';
        for (let i = 0; i < s.length; i++) {
            if (!invalidSet.includes(s[i])) {
                result += s[i];
            }
        }
        return result;
    }

    // Método formatValue agora acessa as propriedades estáticas     
    static formatValue(aValue, aMask) {
    
        let result = '';                  
        try {  
            let s = '';        

            if (aMask[0] === MiConsts.fldDateTime) {
                try{
                  aMask = MiDates.maskToMaskEdit(MiDates.getMask(aMask));                                   
                } catch (error) {
                    console.error("Ocorreu um erro:", error);  
                }
            }

            if (MiMethods.isNumber(aMask)) {        
                // Remove os zeros à esquerda do número.               
                while (aValue.charAt(0) === '0') {
                    aValue = aValue.substring(1);
                }                
            }

            // Checa se a máscara é número relativo
            //if (aMask.includes(MiConsts.fldReal4P) ||
            //    aMask.includes(MiConsts.fldReal4PPositivo)) {
            //
            //    // Certifique-se de que aValue é um número antes de multiplicar
            //
            //    s = (Number(aValue) * 100).toFixed(2);
            //
            //    if (s.includes(MiConsts.showDecimalSeparator)) {
            //        s = s.replace(MiConsts.showDecimalSeparator,
            //                        MiConsts.DecimalSeparator);
            //    }
            //} else {
            //    s = String(aValue);
            //}
            //s = MiMethods.deleteMaskInvalid([':','-', '.', '/', '(', ')', '[', ']',','],s);

            s = MiMethods.deleteMaskInvalid([':','-', '.', '/', '(', ')', '[', ']',','],aValue);
            
            // Se o número for real e o length < numero de casas decimas 
            if (MiMethods.isNumberReal(aMask)) {
                if ( s.length < 3) {
                // Adiciona '00,' no início de result  para edição de numero relativo                  
                s = '0'+s;
                };             
            };

            //l1 e l2 controla o limite de aValue
            let l1 = s.length;
            let l2 = 0;
            let waMask = '';
            
            if (MiMethods.isNumber(aMask)) {
                waMask = MiMethods.deleteMaskInvalid([MiConsts.showDecimalSeparator, 
                                                    MiConsts.DecimalSeparator], aMask);
                l2 = waMask.length;
            } else {
                l2 = MiMethods.deleteMaskInvalid([':','-', '.', '/', '(', ')', '[', ']',','], aMask).length;
            }
            
            if (l1 > l2) {
                s = s.slice(0, -1);              
            }          

            let lenS = s.length;
            let len_aMask = aMask.length;

            // Gera a máscara
            if (MiMethods.isNumber(aMask)) {
                for (let i = len_aMask - 1; i >= 0; i--) {
                    switch (aMask[i]) {
                        case MiConsts.fldDoublePositive:                  
                        case MiConsts.fldReal4Positivo:                  
                        case MiConsts.fldReal4PPositivo:                
                        case MiConsts.fldAnsiCharNumPositive:                                    
                        case MiConsts.fldENum:
                        case MiConsts.fldENum_db:
                        case MiConsts.fldBoolean:
                        case MiConsts.fldByte:
                        case MiConsts.FldRadioButton:
                                if (lenS >= 1) {
                                if (s[s.length - 1] >= '0' && s[s.length - 1] <= '9') {
                                    result = s[lenS - 1] + result;
                                } else {
                                        s = s.slice(0, s.length - 1); // Remove o último caractere
                                        }

                                }
                                else {return result;}
                                lenS--;

                            break;

                        case MiConsts.fldDouble:
                        case MiConsts.fldReal4:
                        case MiConsts.fldReal4P:                  
                        case MiConsts.fldExtended:                  
                        case MiConsts.fldShortInt:
                        case MiConsts.fldSmallWord:
                        case MiConsts.fldSmallInt:
                        case MiConsts.fldLongInt:                  
                            if (lenS >= 1) {
                            if (s[s.length - 1] >= '0' && s[s.length - 1] <= '9') {
                                result = s[lenS - 1] + result;
                            } else {
                                        s = s.slice(0, s.length - 1); // Remove o último caractere
                                    }
                            }
                            else {return result;}
                            lenS--;
                            break;

                        default:
                            if (lenS > 0) {
                                result = aMask[i] + result;
                            }
                            else {
                                return result;
                            }

                            break;
                    }
                }
            }
            else{
                let j = 0;
                for (let i = 0; i < len_aMask; i++) {
                    switch (aMask[i]) {
                        case MiConsts.fldStrNumber:
                        case MiConsts.fldAnsiCharNum:
                            if (j < s.length) {
                                if (s[j] >= '0' && s[j] <= '9') {  // Verifica se s[j] é um número entre 0 e 9
                                    result = result + s[j];  // Atualiza result somente se for número
                                }                             

                            } else {
                                return result;
                            }
                            j++;
                            break;

                        case MiConsts.fldAnsiChar:
                        case MiConsts.fldAnsiCharAlfa:
                        case MiConsts.fldAnsiCharNumPositive:
                        case MiConsts.fldStrAlfa:
                            if (j <  s.length) {
                                result = result + s[j]; // Concatenação crescente
                            } else {
                                return result;
                            }
                            j++;
                            break;

                        case MiConsts.fldStr:
                            if (j <  s.length) {
                                result = result + s[j].toUpperCase(); // Concatenação crescente
                            } else {
                                return result;
                            }
                            j++;
                            break;

                        default:
                            if (lenS > 0) {
                                result = result + aMask[i]; // Concatenação crescente
                            } else {
                                return result;
                            }
                            break;
                    }
                }

            }
           // }
        } finally {  
        return result;   
        }          
    }          

    // Função para garantir que o valor esteja dentro do intervalo especificado
    static rangeValueInteger(value, min, max) {
        let numericValue = parseInt(value.replace(/\D/g, ''), 10);
        if (isNaN(numericValue)) return '';
        return Math.max(min, Math.min(numericValue, max)).toString();
    }

    // Função para garantir que o valor reais esteja dentro do intervalo especificado           
    static rangeValueFloatPoint(value,aMask, min, max) {
        // Remove caracteres não numéricos, exceto a vírgula
        // Primeiro, substituímos a vírgula por um ponto
        // e removemos os pontos, que são usados como separadores de milhar
        let cleanedValue = MiMethods.deleteMaskValid(value,'0123456789');


        // Converte para float
        let numericValue = parseFloat(cleanedValue);        
        numericValue = numericValue /100;
        // Verifica se o valor resultante é um número válido
        if (isNaN(numericValue)) return '';

        // Limita o valor dentro da faixa definida
        //let result = Math.max(min, Math.min(numericValue, max)).toString();
        let result;
        if (numericValue < min) {
            result = min;
        } else if (numericValue > max) {
            result = max;
        } else {
            result = numericValue;
        }
        result = result * 100;
        return result.toString();
    }

    // Função auxiliar para adicionar zeros à esquerda
    static leftFillChar(value, length, padChar = '0') {
        return value.toString().padStart(length, padChar);
    }    
} 


