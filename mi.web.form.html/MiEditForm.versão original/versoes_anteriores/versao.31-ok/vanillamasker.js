export class VanillaMasker {
    static DIGIT = "9";
    static ALPHA = "A";
    static ALPHANUM = "S";
    static BY_PASS_KEYS = [9, 16, 17, 18, 36, 37, 38, 39, 40, 91, 92, 93];

    constructor(elements) {
        this.elements = elements;
    }

    static isAllowedKeyCode(keyCode) {
        return !this.BY_PASS_KEYS.includes(keyCode);
    }

    static mergeMoneyOptions(opts = {}) {
        return {
            precision: opts.precision ?? 2,
            separator: opts.separator || ",",
            delimiter: opts.delimiter || ".",
            unit: opts.unit?.replace(/[\s]/g, '') + " " || "",
            suffixUnit: opts.suffixUnit?.replace(/[\s]/g, '') + " " || "",
            zeroCents: opts.zeroCents,
            lastOutput: opts.lastOutput,
            moneyPrecision: opts.zeroCents ? 0 : opts.precision,
        };
    }

    static addPlaceholdersToOutput(output, index, placeholder) {
        for (; index < output.length; index++) {
            if (output[index] === this.DIGIT || output[index] === this.ALPHA || output[index] === this.ALPHANUM) {
                output[index] = placeholder;
            }
        }
        return output;
    }

    unbindElementToMask() {
        this.elements.forEach(element => {
            element.lastOutput = "";
            element.onkeyup = null;
            element.onkeydown = null;

            if (element.value.length) {
                element.value = element.value.replace(/\D/g, '');
            }
        });
    }

    bindElementToMask(maskFunction) {
        const onType = (e) => {
            const source = e.target || e.srcElement;

            if (VanillaMasker.isAllowedKeyCode(e.keyCode)) {
                setTimeout(() => {
                    this.opts.lastOutput = source.lastOutput;
                    source.value = this[maskFunction](source.value, this.opts);
                    source.lastOutput = source.value;

                    if (source.setSelectionRange && this.opts.suffixUnit) {
                        source.setSelectionRange(source.value.length, source.value.length - this.opts.suffixUnit.length);
                    }
                }, 0);
            }
        };

        this.elements.forEach(element => {
            element.lastOutput = "";
            element.onkeyup = onType;

            if (element.value.length) {
                element.value = this[maskFunction](element.value, this.opts);
            }
        });
    }

    maskMoney(opts) {
        this.opts = VanillaMasker.mergeMoneyOptions(opts);
        this.bindElementToMask("toMoney");
    }

    maskNumber() {
        this.opts = {};
        this.bindElementToMask("toNumber");
    }

    maskAlphaNum() {
        this.opts = {};
        this.bindElementToMask("toAlphaNumeric");
    }

    maskPattern(pattern) {
        this.opts = { pattern: pattern };
        this.bindElementToMask("toPattern");
    }

    unMask() {
        this.unbindElementToMask();
    }

    toMoney(value, opts) {
        opts = VanillaMasker.mergeMoneyOptions(opts);
        
        // Remove todos os caracteres não numéricos
        let numericValue = value.replace(/\D/g, '');
        
        // Formata o número para a precisão desejada
        const numberValue = (numericValue / Math.pow(10, opts.precision)).toFixed(opts.precision);

        // Converte para o formato monetário
        const parts = numberValue.split('.');
        parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, opts.delimiter); // Adiciona delimitadores
        return opts.unit + parts.join(opts.separator);
    }

    toNumber(value) {
        return value.toString().replace(/(?!^-)[^0-9]/g, "");
    }

    toAlphaNumeric(value) {
        return value.toString().replace(/[^a-z0-9 ]+/i, "");
    }

    toPattern(value, opts) {
        // Implementação para máscara de padrão...
    }
}

// Exporta a função auxiliar para criar instâncias da VanillaMasker
export const VMasker = (el) => {
    if (!el) {
        throw new Error("VanillaMasker: There is no element to bind.");
    }
    const elements = ("length" in el) ? (el.length ? el : []) : [el];
    return new VanillaMasker(elements);
};