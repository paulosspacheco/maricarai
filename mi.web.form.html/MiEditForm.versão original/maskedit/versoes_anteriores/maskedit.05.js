class TMaskEdit {
    constructor(inputElement, mask) {
        this.inputElement = inputElement;
        this._mask = mask;
        this.lastValidValue = '';
        this.inputElement.addEventListener('focus', this.onFocus.bind(this));
        this.inputElement.addEventListener('blur', this.onBlur.bind(this));
        this.inputElement.addEventListener('input', this.onInput.bind(this));
        this.inputElement.addEventListener('keydown', this.onKeyDown.bind(this)); // Evento de keydown
    }

    get mask() {
        return this._mask;
    }

    set mask(newMask) {
        this._mask = newMask;
        this.inputElement.value = this.applyMask(this.inputElement.value);
    }

    onFocus() {
        this.inputElement.dataset.value = this.inputElement.value; // Armazena o valor original
        this.inputElement.value = this.inputElement.value.replace(/\D/g, ''); // Limpa a formatação
        this.inputElement.setSelectionRange(0, this.inputElement.value.length); // Coloca o cursor no início
    }

    onBlur() {
        const rawValue = this.inputElement.value.replace(/\D/g, '');
        if (rawValue) {
            this.inputElement.value = this.applyMask(rawValue);
        } else {
            this.inputElement.value = ''; // Limpa se não houver valor
        }
    }

    onInput() {
        const cleanValue = this.inputElement.value.replace(/\D/g, '');

        if (this._mask === 'fracionario') {
            this.inputElement.value = this.formatAsFraction(cleanValue);
        } else {
            this.inputElement.value = this.applyMask(cleanValue);
        }

        this.lastValidValue = this.inputElement.value; // Armazena o último valor válido
        this.inputElement.setSelectionRange(this.inputElement.value.length, this.inputElement.value.length); // Coloca o cursor no final
    }

    onKeyDown(e) {
        if (e.key === 'Backspace') {
            const selectionStart = this.inputElement.selectionStart;
            const selectionEnd = this.inputElement.selectionEnd;

            if (selectionStart === selectionEnd) { // Não há seleção, apenas cursor
                // Se o cursor está em um ponto da máscara, move o cursor para antes do último número válido
                const newValue = this.inputElement.value.substring(0, selectionStart - 1) + this.inputElement.value.substring(selectionStart);
                e.preventDefault(); // Evita que o backspace apague o caractere da máscara
                this.inputElement.value = this.applyMask(newValue.replace(/\D/g, '')); // Aplica a máscara após a remoção
                this.inputElement.setSelectionRange(selectionStart - 1, selectionStart - 1); // Coloca o cursor no local correto
            }
        }
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
