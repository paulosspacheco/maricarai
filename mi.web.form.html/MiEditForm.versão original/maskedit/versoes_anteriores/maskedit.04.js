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
        // Armazena o valor original e limpa a formatação ao receber foco
        this.inputElement.dataset.value = this.inputElement.value; // Armazena o valor original
        this.inputElement.value = this.inputElement.value.replace(/\D/g, ''); // Limpa a formatação
        this.inputElement.setSelectionRange(0, this.inputElement.value.length); // Coloca o cursor no início
    }

    /**
     * Manipula o evento de perda de foco no campo de entrada.
     *
     * Quando o campo de entrada perde o foco, este método é chamado para 
     * aplicar a máscara ao valor inserido. Ele remove todos os caracteres 
     * não numéricos do valor de entrada e, se houver algum valor, aplica 
     * a máscara definida ao valor limpo. Se não houver valor, o campo de 
     * entrada é limpo.
     *
     * @returns {void} - Este método não retorna nenhum valor.
     *
     * @example
    * // Exemplo de uso: Este método é invocado automaticamente quando o 
    * // campo de entrada perde o foco e aplica a máscara ao valor contido 
    * // no campo.
    */    
    onBlur() {
        // Aplica a máscara ao perder o foco
        const rawValue = this.inputElement.value.replace(/\D/g, '');
        if (rawValue) {
            this.inputElement.value = this.applyMask(rawValue);
        } else {
            this.inputElement.value = ''; // Limpa se não houver valor
        }
    }

    onInput() {
        const cleanValue = this.inputElement.value.replace(/\D/g, ''); // Remove não numéricos

        if (this._mask === 'fracionario') {
            this.inputElement.value = this.formatAsFraction(cleanValue);
        } else {
            this.inputElement.value = this.applyMask(cleanValue);
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


    /**
     * Formata um valor numérico como uma string representando um valor 
     * fracionário.
     *
     * O método remove todos os caracteres não numéricos do valor de 
     * entrada e formata a parte inteira e a parte decimal de acordo com 
     * o padrão brasileiro de representação monetária, onde a parte 
     * inteira é separada por pontos e a parte decimal é separada por 
     * vírgula.
     *
     * Se o valor de entrada estiver vazio ou contiver menos de três 
     * dígitos, o método adiciona zeros à esquerda para garantir que 
     * sempre haja pelo menos duas casas decimais.
     *
     * @param {string} value - O valor de entrada que será formatado. 
     *                         Este valor pode conter caracteres não 
     *                         numéricos que serão removidos.
     *
     * @returns {string} - Retorna o valor formatado como uma string no 
     *                     formato "X.XXX.XXX,YY", onde "X" representa 
     *                     dígitos da parte inteira e "YY" representa
     *                     a parte decimal. Se o valor de entrada não 
     *                     contém dígitos, retorna "0,00".
     *
     * @example
    * // Exemplo de uso:
    * const formattedValue = formatAsFraction('12345'); // Retorna "123,45"
    * const formattedValue = formatAsFraction('9');     // Retorna "0,09"
    * const formattedValue = formatAsFraction('');      // Retorna "0,00"
    */    
    formatAsFraction(value) {
        let cleanValue = value.replace(/\D/g, '');

        if (cleanValue.length === 0) cleanValue = '000';
        if (cleanValue.length === 1) cleanValue = '00' + cleanValue;
        if (cleanValue.length === 2) cleanValue = '0' + cleanValue;

        let decimalPart = cleanValue.slice(-2);
        let integerPart = cleanValue.slice(0, -2);

        // Remover zeros à esquerda da parte inteira
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
