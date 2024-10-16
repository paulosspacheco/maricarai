class TMaskEdit {
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
            this.inputElement.value = this.applyMask(cleanValue);
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
    
        // Número máximo de dígitos inteiros permitido pela máscara
        const maxIntegers = (this._mask.match(/0/g) || []).length - 2; // Subtraímos 2 porque temos dois dígitos decimais
    
        // Limitar o valor ao número de inteiros e dois decimais
        if (cleanValue.length <= 2) {
            cleanValue = cleanValue.padStart(3, '0'); // Preencher com zeros à esquerda
        } else {
            // Limitar os inteiros ao máximo permitido pela máscara
            const integerPart = cleanValue.slice(0, -2).slice(-maxIntegers);
            const decimalPart = cleanValue.slice(-2);
            cleanValue = integerPart + decimalPart;
        }
    
        let decimalPart = cleanValue.slice(-2);
        let integerPart = cleanValue.slice(0, -2);
    
        integerPart = integerPart.replace(/^0+/, ''); // Remover zeros à esquerda
        integerPart = integerPart.replace(/\B(?=(\d{3})+(?!\d))/g, '.'); // Formatar como milhar
    
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

        // Limitar o número de caracteres com base na máscara, contando os caracteres # e 0
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
}

// Inicializando a classe TMaskEdit para cada input
document.querySelectorAll('input[data-mask]').forEach(input => {
    const mask = input.getAttribute('data-mask');
    const maskType = input.getAttribute('data-mask-type'); 

    new TMaskEdit(input, mask, maskType);
});
