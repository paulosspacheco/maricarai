class TMaskEdit {
    constructor(inputElement, mask) {
        this.inputElement = inputElement;
        this._mask = mask;
        this.inputElement.addEventListener('focus', this.onFocus.bind(this));
        this.inputElement.addEventListener('blur', this.onBlur.bind(this));
        this.inputElement.addEventListener('input', this.onInput.bind(this));
    }

    get mask() {
        return this._mask;
    }

    set mask(newMask) {
        this._mask = newMask;
        this.inputElement.value = this.applyMask(this.inputElement.value);
    }

    onFocus() {
        this.inputElement.value = this.inputElement.value.replace(/\D/g, ''); // Limpa a formatação
    }

    onBlur() {
        this.inputElement.value = this.applyMask(this.inputElement.value);
    }

    onInput() {
        let value = this.inputElement.value.replace(/\D/g, ''); // Remove não numéricos
        
        if (this._mask === 'fracionario') {
            this.inputElement.value = this.formatAsFraction(value);
        } else {
            this.inputElement.value = this.applyMask(value);
        }

        // Coloca o cursor no final do valor
        this.inputElement.setSelectionRange(this.inputElement.value.length, this.inputElement.value.length);
    }

    applyMask(value) {
        const cleanValue = value.replace(/\D/g, ''); // Remove não numéricos
        let maskedValue = '';
        let valueIndex = 0;

        for (let i = 0; i < this._mask.length; i++) {
            const maskChar = this._mask[i];

            if (maskChar === '0' || maskChar === '9') {
                if (valueIndex < cleanValue.length) {
                    maskedValue += cleanValue[valueIndex];
                    valueIndex++;
                } else {
                    break;
                }
            } else {
                maskedValue += maskChar; // Adiciona caracteres da máscara
            }
        }

        return maskedValue;
    }

    formatAsFraction(value) {
        let cleanValue = value.replace(/\D/g, '');
        
        if (cleanValue.length === 0) cleanValue = '000';
        if (cleanValue.length === 1) cleanValue = '00' + cleanValue;
        if (cleanValue.length === 2) cleanValue = '0' + cleanValue;

        let decimalPart = cleanValue.slice(-2);
        let integerPart = cleanValue.slice(0, -2);

        integerPart = parseInt(integerPart, 10).toString().replace(/\B(?=(\d{3})+(?!\d))/g, '.');

        if (integerPart === '') integerPart = '0'; // Certifica-se de que a parte inteira nunca esteja vazia

        return `${integerPart},${decimalPart}`;
    }
}

// Inicializando a classe TMaskEdit para cada input
document.querySelectorAll('input[data-mask]').forEach(input => {
    const mask = input.getAttribute('data-mask');
    new TMaskEdit(input, mask);
});
