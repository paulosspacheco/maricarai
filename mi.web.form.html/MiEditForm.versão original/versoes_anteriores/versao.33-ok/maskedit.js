/**
 * Classe que aplica máscaras de formatação em campos de entrada (input).
 * Permite máscaras monetárias e genéricas, além de restringir valores conforme o 
 * tipo de máscara.
 */
export class TMaskEdit {
    /**
     * Cria uma instância da classe TMaskEdit.
     * @param inputElement O elemento de entrada HTML que receberá a máscara.
     * @param mask A máscara a ser aplicada (ex: '###.###.###-##').
     * @param maskType O tipo de máscara, que define regras adicionais (ex: 'R' 
     * para monetária, 'B', 'J' para valores restritos).
     */
    constructor(inputElement, mask, maskType) {
        this.inputElement = inputElement;
        this._mask = mask;
        this.maskType = maskType;
        this.lastValidValue = '';
        this.inputElement.addEventListener('focus', this.onFocus.bind(this));
        this.inputElement.addEventListener('blur', this.onBlur.bind(this));
        this.inputElement.addEventListener('input', this.onInput.bind(this));
        this.inputElement.addEventListener('keydown', this.onKeyDown.bind(this));
    }
    
    /**
     * Obtém a máscara atual.
     * @returns {string} A máscara atual aplicada ao campo.
     */
    get mask() {
        return this._mask;
    }

    /**
     * Define uma nova máscara e reaplica-a ao valor atual do campo de entrada.
     * @param {string} newMask A nova máscara que será aplicada.
     */    
    set mask(newMask) {
        this._mask = newMask;
        this.inputElement.value = this.applyMask(this.inputElement.value);
    }

    /**
     * Verifica se a máscara é do tipo monetária (R$).
     * @returns {boolean} Verdadeiro se a máscara for monetária.
     */    
    isMonetaryMask() {
        return this.maskType === 'r' || this.maskType === 'R';
    }

    /**
     * Verifica se a máscara é genérica (contém # ou 0 como placeholders).
     * @returns {boolean} Verdadeiro se a máscara for genérica.
     */    
    isGenericMask() {
        return this._mask.includes('#') || this._mask.includes('0');
    }

    /**
     * Manipula o evento de foco no campo de entrada.
     * Salva o valor atual do campo e posiciona o cursor ao final do valor.
     */    
    onFocus() {
        this.inputElement.dataset.value = this.inputElement.value;
        this.setCursorToEnd();
    }

    /**
     * Manipula o evento de perda de foco no campo de entrada.
     * Limpa o valor e aplica a máscara, verificando se o valor está dentro 
     * do intervalo permitido para o tipo de máscara.
     */    
    onBlur() {
        const cleanValue = this.cleanValue(this.inputElement.value);
        if (cleanValue) {
            if (this.isValueInRange(cleanValue)) {
                this.inputElement.value = this.applyMask(cleanValue);
            } else {
                alert(`Valor fora da faixa permitida para ${this.maskType}`);
                this.inputElement.value = '';
            }
        } else {
            this.inputElement.value = '';
        }
    }

    /**
     * Manipula o evento de entrada (input) no campo de entrada.
     * Limpa o valor atual e reaplica a máscara conforme o valor inserido.
     */    
    onInput() {
        const cleanValue = this.cleanValue(this.inputElement.value);
        this.inputElement.value = this.applyMask(cleanValue);
        this.lastValidValue = this.inputElement.value;
        this.setCursorToEnd();
    }

    /**
     * Manipula o evento de tecla pressionada (keydown) no campo de entrada.
     * Lida com a exclusão (backspace) personalizada para remover os caracteres 
     * da máscara adequadamente.
     * @param {KeyboardEvent} e O evento de teclado.
     */    
    onKeyDown(e) {
        const selectionStart = this.inputElement.selectionStart;
        const selectionEnd = this.inputElement.selectionEnd;

        if (e.key === 'Backspace' && selectionStart === selectionEnd) {
            e.preventDefault();
            this.handleBackspace(selectionStart);
        }
    }

    /**
     * Limpa o valor, removendo todos os caracteres que não fazem parte do 
     * valor principal (como símbolos monetários).
     * @param {string} value O valor a ser limpo.
     * @returns {string} O valor limpo, contendo apenas dígitos.
     */    
    cleanValue(value) {
        return this.isMonetaryMask() ? value.replace(/[^\d-]/g, '') : value.replace(/\D/g, '');
    }

    /**
     * Lida com a tecla Backspace para excluir o último caractere do valor 
     * inserido.
     * @param {number} cursorPosition A posição atual do cursor no campo de 
     * entrada.
     */    
    handleBackspace(cursorPosition) {
        let value = this.cleanValue(this.inputElement.value);

        if (value.length > 0) {
            value = value.slice(0, -1); // Remove o último caractere
            this.inputElement.value = this.applyMask(value);

            // Posicionar o cursor corretamente
            let newPosition = Math.max(0, cursorPosition - 1);
            this.inputElement.setSelectionRange(newPosition, newPosition);
        }
    }

    /**
     * Move o cursor para o final do valor no campo de entrada.
     */    
    setCursorToEnd() {
        const length = this.inputElement.value.length;
        this.inputElement.setSelectionRange(length, length);
    }

    /**
     * Aplica a máscara ao valor informado, de acordo com o tipo de máscara.
     * @param {string} value O valor a ser mascarado.
     * @returns {string} O valor com a máscara aplicada.
     */
    applyMask(value) {
        if (this.isMonetaryMask()) {
            return this.applyMonetaryMask(value);
        } else if (this.isGenericMask()) {
            return this.applyGenericMask(value);
        } else {
            return value;
        }
    }

    /**
     * Aplica uma máscara monetária ao valor informado.
     * @param {string} value O valor a ser formatado.
     * @returns {string} O valor formatado como moeda, incluindo o símbolo R$.
     */    
    applyMonetaryMask(value) {
        let isNegative = this.maskType === 'R' && value.includes('-');
        let cleanValue = value.replace(/\D/g, '');

        if (cleanValue.length === 0) return '';

        const maxIntegers = (this._mask.match(/0/g) || []).length - 2;

        if (cleanValue.length <= 2) {
            cleanValue = cleanValue.padStart(3, '0');
        } else {
            const integerPart = cleanValue.slice(0, -2).slice(-maxIntegers);
            const decimalPart = cleanValue.slice(-2);
            cleanValue = integerPart + decimalPart;
        }

        let decimalPart = cleanValue.slice(-2);
        let integerPart = cleanValue.slice(0, -2);
        integerPart = integerPart.replace(/^0+/, '');
        integerPart = integerPart.replace(/\B(?=(\d{3})+(?!\d))/g, '.');

        if (integerPart === '') integerPart = '0';

        let maskedValue = `R$ ${integerPart},${decimalPart}`;

        if (isNegative) {
            return '-' + maskedValue;
        }

        return maskedValue;
    }

    /**
     * Aplica uma máscara genérica ao valor informado.
     * @param {string} value O valor a ser mascarado.
     * @returns {string} O valor com a máscara genérica aplicada.
     */    
    applyGenericMask(value) {
        let cleanValue = value.replace(/\D/g, '');
        let maskedValue = '';
        let valueIndex = 0;

        let maskLength = this._mask.split('').filter(char => char === '#' || char === '0').length;
        cleanValue = cleanValue.slice(0, maskLength);

        for (let i = 0; i < this._mask.length; i++) {
            const maskChar = this._mask[i];

            if (maskChar === '#' || maskChar === '0') {
                if (valueIndex < cleanValue.length) {
                    maskedValue += cleanValue[valueIndex];
                    valueIndex++;
                } else {
                    break;
                }
            } else {
                maskedValue += maskChar;
            }
        }

        return maskedValue;
    }

    /**
     * Verifica se o valor está dentro do intervalo permitido para o tipo de 
     * máscara.
     * @param {string} value O valor a ser verificado.
     * @returns {boolean} Verdadeiro se o valor estiver dentro do intervalo 
     * permitido.
     */    
    isValueInRange(value) {
        const numValue = parseInt(value, 10);
        switch (this.maskType) {
            case 'B':
                return numValue >= 0 && numValue <= 254;
            case 'J':
                return numValue >= -126 && numValue <= 127;
            case 'I':
                return numValue >= -32768 && numValue <= 32767;
            case 'W':
                return numValue >= 0 && numValue <= 65535;
            case 'L':
                return numValue >= -2147483648 && numValue <= 2147483647;
            default:
                return true; // Se não for um tipo reconhecido, assume-se que está ok
        }
    }
}

// Inicializando a classe TMaskEdit para todos os inputs com máscara
// O código abaixo só funciona se não tiver a palavra export antes da class TMaskEdit
// document.querySelectorAll('input[data-mask]').forEach(input => {
//     const mask = input.getAttribute('data-mask');
//     const maskType = input.getAttribute('data-mask-type'); 

//     new TMaskEdit(input, mask, maskType);
// });
