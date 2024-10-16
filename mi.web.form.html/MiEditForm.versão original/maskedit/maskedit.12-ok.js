/**
 * Classe que aplica máscaras de formatação em campos de entrada (input).
 * Permite máscaras monetárias e genéricas, além de restringir valores conforme o 
 * tipo de máscara.
 */
class TMaskEdit {
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

    set mask(newMask) {
        this._mask = newMask;
        this.inputElement.value = this.applyMask(this.inputElement.value);
    }

    isMonetaryMask() {
        return this.maskType === 'r' || this.maskType === 'R';
    }

    isGenericMask() {
        return this._mask.includes('#') || this._mask.includes('0');
    }

    onFocus() {
        this.inputElement.dataset.value = this.inputElement.value;
        this.setCursorToEnd();
    }

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

    onInput() {
        const cleanValue = this.cleanValue(this.inputElement.value);
        this.inputElement.value = this.applyMask(cleanValue);
        this.lastValidValue = this.inputElement.value;
        this.setCursorToEnd();
    }

    onKeyDown(e) {
        const selectionStart = this.inputElement.selectionStart;
        const selectionEnd = this.inputElement.selectionEnd;

        if (e.key === 'Backspace' && selectionStart === selectionEnd) {
            e.preventDefault();
            this.handleBackspace(selectionStart);
        }
    }

    cleanValue(value) {
        return this.isMonetaryMask() ? value.replace(/[^\d-]/g, '') : value.replace(/\D/g, '');
    }

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

    setCursorToEnd() {
        const length = this.inputElement.value.length;
        this.inputElement.setSelectionRange(length, length);
    }

    applyMask(value) {
        if (this.isMonetaryMask()) {
            return this.applyMonetaryMask(value);
        } else if (this.isGenericMask()) {
            return this.applyGenericMask(value);
        } else {
            return value;
        }
    }

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

// Inicializando a classe TMaskEdit para cada input
document.querySelectorAll('input[data-mask]').forEach(input => {
    const mask = input.getAttribute('data-mask');
    const maskType = input.getAttribute('data-mask-type'); 

    new TMaskEdit(input, mask, maskType);
});
