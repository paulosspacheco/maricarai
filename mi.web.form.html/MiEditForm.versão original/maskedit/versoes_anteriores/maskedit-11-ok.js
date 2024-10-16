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
        return this._mask.includes('#');
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

        if (cleanValue.length === 1) cleanValue = '00' + cleanValue;
        if (cleanValue.length === 2) cleanValue = '0' + cleanValue;

        let decimalPart = cleanValue.slice(-2);
        let integerPart = cleanValue.slice(0, -2);

        integerPart = parseInt(integerPart, 10).toString().replace(/\B(?=(\d{3})+(?!\d))/g, '.');

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

        for (let i = 0; i < this._mask.length; i++) {
            const maskChar = this._mask[i];

            if (maskChar === '#') {
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
