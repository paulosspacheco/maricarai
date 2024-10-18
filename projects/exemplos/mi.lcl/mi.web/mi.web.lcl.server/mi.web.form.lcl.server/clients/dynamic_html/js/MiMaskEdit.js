// MiMaskEdit.js

import { MiConsts } from './MiConsts.js';
import { MiMethods } from './MiMethods.js';

export class MiMaskEdit extends MiMethods {

    constructor(inputElement) {
        super(); // Chama o construtor da classe pai
        this.inputElement = inputElement;
        this.mask = inputElement.dataset.mask;
        this.maskType = inputElement.dataset.maskType;

        // Adiciona o evento para formatar ou processar enquanto o usuário interage
        if (this.isInputField()) {
            this.inputElement.addEventListener('input', this.formatInput.bind(this));
        } else if (this.isSelectField()) {
            this.inputElement.addEventListener('change', this.processSelect.bind(this));
        } else if (this.isCheckboxOrRadio()) {
            this.inputElement.addEventListener('change', this.processCheckboxOrRadio.bind(this));
        } else if (this.isButton()) {
            this.inputElement.addEventListener('click', this.processButton.bind(this));
        }
    }

    isInputField() {
        return this.inputElement.tagName.toLowerCase() === 'input';
    }

    isSelectField() {
        return this.inputElement.tagName.toLowerCase() === 'select';
    }

    isCheckboxOrRadio() {
        return this.inputElement.type === 'checkbox' || this.inputElement.type === 'radio';
    }

    isButton() {
        return this.inputElement.tagName.toLowerCase() === 'button';
    }

    formatInput(event) {
        let cursorPosition = event.target.selectionStart || 0;
        let inputValue = event.target.value;
        const originalLength = inputValue.length;

        try {
            if (this.maskType === MiConsts.fldEnum || this.maskType === MiConsts.fldEnum_Db) {
                this.createSelectForEnum(event.target);
                return;
            }

            switch (this.maskType) {
                case 'S':                    
                case 's':
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
                    event.target.value = MiMethods.formatValue(inputValue, this.mask);                        
                    break;                        
                default:
                    event.target.value = inputValue;
            }
        } catch (error) {
            console.error("Erro ao aplicar a formatação:", error);
        } finally {
            const newLength = event.target.value.length;
            cursorPosition += (newLength - originalLength);
            event.target.setSelectionRange(cursorPosition, cursorPosition);
        }
    }

    processSelect(event) {
        const selectedValue = event.target.value;
        console.log("Valor selecionado:", selectedValue);
        // Lógica adicional para o campo select pode ser adicionada aqui
    }

    processCheckboxOrRadio(event) {
        const isChecked = event.target.checked;
        console.log("Checkbox ou RadioButton está marcado:", isChecked);
        // Lógica adicional para checkbox ou radiobutton pode ser adicionada aqui
    }

    processButton(event) {
        console.log("Botão clicado:", event.target);
        // Lógica adicional para botões pode ser adicionada aqui
    }
}

// Modifica a função initializeFormMasks para lidar com diferentes tipos de elementos
export function initializeFormMasks(formElement) {
    if (!formElement || !(formElement instanceof HTMLElement)) {
        throw new Error('Um elemento de formulário válido deve ser fornecido.');
    }

    function initializeMaskEdits() {
        const inputElements = formElement.querySelectorAll('[data-mask]');

        inputElements.forEach(inputElement => {
            new MiMaskEdit(inputElement);
        });
    }

    initializeMaskEdits();
}

// Aplica as máscaras em todos os formulários do documento
export function initializeFormsMasks() {
    function initializeMaskEdits() {
        const formElements = document.querySelectorAll('form');

        formElements.forEach(form => {
            const inputElements = form.querySelectorAll('[data-mask]');

            inputElements.forEach(inputElement => {
                new MiMaskEdit(inputElement);
            });
        });
    }

    initializeMaskEdits();
}
