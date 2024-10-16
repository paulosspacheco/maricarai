// MiMaskEdit.js

import { MiConsts } from './MiConsts.js';
import { MiMethods } from './MiMethods.js';

export class MiMaskEdit extends MiMethods{

    constructor(inputElement) {
        super(); // Chama o construtor da classe pai
        this.inputElement = inputElement;
        this.mask = inputElement.dataset.mask;
        this.maskType = inputElement.dataset.maskType;

        // Adiciona o evento para formatar enquanto o usuário digita
        this.inputElement.addEventListener('input', this.formatInput.bind(this));
    }

    formatInput(event) {
        let cursorPosition = event.target.selectionStart; // Posição do cursor antes da formatação
        let inputValue = event.target.value;
        const originalLength = inputValue.length; // Salva o comprimento original antes da formatação

        try {

            try {
                // Aplica a formatação de acordo com o tipo de máscara
                switch (this.maskType) {
                    case '#':
                    case 'r':
                    case 'R':
                    case 'O':
                    case 'o':
                    case 'P':    
                    case 'p':
                        event.target.value = MiMethods.formatValue(inputValue, this.mask);
                        break;
                    case 'B':
                        event.target.value = MiMethods.formatValue(
                            MiMethods.rangeValueInteger(inputValue, 0, 254),
                            this.mask
                        );
                        break;
                    case 'J':
                        event.target.value = MiMethods.formatValue(
                            MiMethods.rangeValueInteger(inputValue, -126, 127),
                            this.mask
                        );
                        break;
                    case 'I':
                        event.target.value = MiMethods.formatValue(
                            MiMethods.rangeValueInteger(inputValue, -32768, 32767),
                            this.mask
                        );
                        break;
                    case 'W':
                        event.target.value = MiMethods.formatValue(
                            MiMethods.rangeValueInteger(inputValue, 0, 65535),
                            this.mask
                        );
                        break;
                    case 'L':
                        event.target.value = MiMethods.formatValue(
                            MiMethods.rangeValueInteger(inputValue, -2147483648, 2147483647),
                            this.mask
                        );
                        break;

                    case 'D':
                        event.target.value = MiMethods.formatValue(inputValue,this.mask);                        
                        break;                        
    
                    default:
                        event.target.value = inputValue; // Se não houver máscara correspondente, mantém o valor original
                }
            } catch (error) {
                console.error("Erro ao aplicar a formatação:", error); // Trata a exceção de formatação
            }

        } finally {
            const newLength = event.target.value.length; // Salva o comprimento após a formatação

            // Ajusta a posição do cursor com base na diferença de comprimento
            cursorPosition += (newLength - originalLength);

            // Restaura a posição do cursor ajustada
            event.target.setSelectionRange(cursorPosition, cursorPosition);
        }
    }

}

// Função para inicializar todos os campos com máscara
function initializeMaskEdits() {
    const inputElements = document.querySelectorAll('[data-mask]');
    inputElements.forEach(inputElement => new MiMaskEdit(inputElement));
}

// Inicializa quando a página estiver carregada
document.addEventListener('DOMContentLoaded', initializeMaskEdits);
