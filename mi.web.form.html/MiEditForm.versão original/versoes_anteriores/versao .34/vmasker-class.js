export class VMasker {
  static DIGIT = "9";
  static ALPHA = "A";
  static ALPHANUM = "S";
  static BY_PASS_KEYS = [9, 16, 17, 18, 36, 37, 38, 39, 40, 91, 92, 93];

  constructor(elements) {
    if (!elements) {
      throw new Error("VMasker: There is no element to bind.");
    }
    this.elements = "length" in elements ? (elements.length ? elements : []) : [elements];
  }

  static isAllowedKeyCode(keyCode) {
    return !VMasker.BY_PASS_KEYS.includes(keyCode);
  }

  static mergeMoneyOptions(opts = {}) {
    return {
      delimiter: opts.delimiter || ".",
      lastOutput: opts.lastOutput,
      precision: opts.hasOwnProperty("precision") ? opts.precision : 2,
      separator: opts.separator || ",",
      showSignal: opts.showSignal,
      suffixUnit: opts.suffixUnit && (" " + opts.suffixUnit.replace(/[\s]/g,'')) || "",
      unit: opts.unit && (opts.unit.replace(/[\s]/g,'') + " ") || "",
      zeroCents: opts.zeroCents,
      moneyPrecision: opts.zeroCents ? 0 : opts.precision
    };
  }

  static addPlaceholdersToOutput(output, index, placeholder) {
    for (; index < output.length; index++) {
      if(output[index] === VMasker.DIGIT || output[index] === VMasker.ALPHA || output[index] === VMasker.ALPHANUM) {
        output[index] = placeholder;
      }
    }
    return output;
  }

  unbindElementToMask() {
    for (let i = 0, len = this.elements.length; i < len; i++) {
      this.elements[i].lastOutput = "";
      this.elements[i].onkeyup = false;
      this.elements[i].onkeydown = false;

      if (this.elements[i].value.length) {
        this.elements[i].value = this.elements[i].value.replace(/\D/g, '');
      }
    }
  }

  bindElementToMask(maskFunction) {
    const that = this;
    const onType = function(e) {
      e = e || window.event;
      const source = e.target || e.srcElement;

      if (VMasker.isAllowedKeyCode(e.keyCode)) {
        setTimeout(() => {
          that.opts.lastOutput = source.lastOutput;
          source.value = VMasker[maskFunction](source.value, that.opts);
          source.lastOutput = source.value;
          if (source.setSelectionRange && that.opts.suffixUnit) {
            source.setSelectionRange(source.value.length, (source.value.length - that.opts.suffixUnit.length));
          }
        }, 0);
      }
    };

    for (let i = 0, len = this.elements.length; i < len; i++) {
      this.elements[i].lastOutput = "";
      this.elements[i].onkeyup = onType;
      if (this.elements[i].value.length) {
        this.elements[i].value = VMasker[maskFunction](this.elements[i].value, this.opts);
      }
    }
  }

  maskMoney(opts) {
    this.opts = VMasker.mergeMoneyOptions(opts);
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
    this.opts = { pattern };
    this.bindElementToMask("toPattern");
  }

  unMask() {
    this.unbindElementToMask();
  }

  static toMoney(value, opts) {
    opts = VMasker.mergeMoneyOptions(opts);

    if (opts.zeroCents) {
      opts.lastOutput = opts.lastOutput || "";
      const zeroMatcher = `(${opts.separator}[0]{0,${opts.precision}})`;
      const zeroRegExp = new RegExp(zeroMatcher, "g");
      const digitsLength = value.toString().replace(/[\D]/g, "").length || 0;
      const lastDigitLength = opts.lastOutput.toString().replace(/[\D]/g, "").length || 0;

      value = value.toString().replace(zeroRegExp, "");
      if (digitsLength < lastDigitLength) {
        value = value.slice(0, value.length - 1);
      }
    }

    let number = value.toString();
    const separatorIndex = number.indexOf(opts.separator);
    const missingZeros = (opts.precision - (number.length - separatorIndex - 1));

    if (separatorIndex !== -1 && (missingZeros > 0)) {
      number = number + ('0'.repeat(missingZeros));
    }

    number = number.replace(/[\D]/g, "");
    const clearDelimiter = new RegExp(`^(0|\\${opts.delimiter})`);
    const clearSeparator = new RegExp(`(\\${opts.separator})$`);
    let money = number.substr(0, number.length - opts.moneyPrecision);
    let masked = money.substr(0, money.length % 3);

    money = money.substr(money.length % 3, money.length);
    for (let i = 0, len = money.length; i < len; i++) {
      if (i % 3 === 0) {
        masked += opts.delimiter;
      }
      masked += money[i];
    }

    masked = masked.replace(clearDelimiter, "");
    masked = masked.length ? masked : "0";
    let signal = "";

    if (opts.showSignal === true) {
      signal = value < 0 || (value.startsWith && value.startsWith('-')) ? "-" : "";
    }

    let cents = new Array(opts.precision + 1).join("0");

    if (!opts.zeroCents) {
      const beginCents = Math.max(0, number.length - opts.precision);
      const centsValue = number.substr(beginCents, opts.precision);
      const centsLength = centsValue.length;
      const centsSliced = (opts.precision > centsLength) ? opts.precision : centsLength;

      cents = (cents + centsValue).slice(-centsSliced);
    }

    let output = opts.unit + signal + masked + opts.separator + cents;
    return output.replace(clearSeparator, "") + opts.suffixUnit;
  }

  static toPattern(value, opts) {
    const pattern = (typeof opts === 'object' ? opts.pattern : opts);
    const patternChars = pattern.replace(/\W/g, '');
    const output = pattern.split("");
    const values = value.toString().replace(/\W/g, "");
    const charsValues = values.replace(/\W/g, '');
    let index = 0;
    const outputLength = output.length;
    const placeholder = (typeof opts === 'object' ? opts.placeholder : undefined);

    for (let i = 0; i < outputLength; i++) {
        if (index >= values.length) {
            if (patternChars.length == charsValues.length) {
                return output.join("");
            } else if ((placeholder !== undefined) && (patternChars.length > charsValues.length)) {
                return this.addPlaceholdersToOutput(output, i, placeholder).join("");
            } else {
                break;
            }
        } else {
            if ((output[i] === this.DIGIT && values[index].match(/[0-9]/)) ||
                (output[i] === this.ALPHA && values[index].match(/[a-zA-Z]/)) ||
                (output[i] === this.ALPHANUM && values[index].match(/[0-9a-zA-Z]/))) {
                output[i] = values[index++];
            } else if (output[i] === this.DIGIT || output[i] === this.ALPHA || output[i] === this.ALPHANUM) {
                if (placeholder !== undefined) {
                    return this.addPlaceholdersToOutput(output, i, placeholder).join("");
                } else {
                    return output.slice(0, i).join("");
                }
            } else if (output[i] === values[index]) {
                index++;
            }
        }
    }

    return output.join("").substr(0, index);
  }

  static addPlaceholdersToOutput(output, i, placeholder) {
    // Implementação da lógica para adicionar placeholders
  }
  

  static toNumber(value) {
    return value.toString().replace(/(?!^-)[^0-9]/g, "");
  }

  static toAlphaNumeric(value) {
    return value.toString().replace(/[^a-z0-9 ]+/i, "");
  }
}
