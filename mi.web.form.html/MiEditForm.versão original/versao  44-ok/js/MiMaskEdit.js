// MiMaskEdit.js

import { MiConsts } from './MiConsts.js';
import { MiMethods } from './MiMethods.js';

export class MiMaskEdit extends MiMethods{

    constructor(inputElement) {
        super(); // Chama o construtor da classe pai
        this.inputElement = inputElement;
        this.mask = inputElement.dataset.mask;
        this.maskType = inputElement.dataset.maskType;

        // Adiciona o evento para formatar enquanto o usuário digita
        this.inputElement.addEventListener('input', this.formatInput.bind(this));
    }

    formatInput(event) {
        let cursorPosition = event.target.selectionStart; // Posição do cursor antes da formatação
        let inputValue = event.target.value;
        const originalLength = inputValue.length; // Salva o comprimento original antes da formatação

        try {

            try {
                // Aplica a formatação de acordo com o tipo de máscara
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
                        event.target.value = MiMethods.formatValue(inputValue,this.mask);                        
                        break;                        
    
                       
                    default:
                        event.target.value = inputValue; // Se não houver máscara correspondente, mantém o valor original
                }
            } catch (error) {
                console.error("Erro ao aplicar a formatação:", error); // Trata a exceção de formatação
            }

        } finally {
            const newLength = event.target.value.length; // Salva o comprimento após a formatação

            // Ajusta a posição do cursor com base na diferença de comprimento
            cursorPosition += (newLength - originalLength);

            // Restaura a posição do cursor ajustada
            event.target.setSelectionRange(cursorPosition, cursorPosition);
        }
    }
}

// Aplica data-mask em formElement
export function initializeFormMasks(formElement) {
   
    //Você pode chamar initializeMasks passando o formulário específico que deseja como argumento.
    //Exemplo:    
    //  const myForm = document.getElementById('meuFormulario'); // Seleciona o formulário pelo ID
    //  initializeFormMasks(myForm); // Aplica máscaras apenas nesse formulário

    // Verifica se o formulário foi passado e se é um elemento válido
    if (!formElement || !(formElement instanceof HTMLElement)) {
        throw new Error('Um elemento de formulário válido deve ser fornecido.');
    }


    //console.log('Função initializeFormMasks chamada.');

    // Função para inicializar todos os campos com máscara dentro do formulário
    function initializeMaskEdits() {
        //console.log('Inicializando as máscaras de edição.');

        // Seleciona os inputs dentro do formulário que têm o atributo 'data-mask'
        const inputElements = formElement.querySelectorAll('[data-mask]');

        //console.log(`Encontrados ${inputElements.length} elementos com data-mask no formulário.`);

        inputElements.forEach(inputElement => {
          //  console.log(`Aplicando máscara no elemento:`, inputElement);
            new MiMaskEdit(inputElement);
        });

        //console.log('Máscaras aplicadas a todos os elementos com data-mask.');
    }
    //console.log('Documento carregado, chamando initializeMaskEdits.');
    initializeMaskEdits();
}

//Aplica data-mask em todos os formElement do documento.
export function initializeFormsMasks() {
    // Função para inicializar todos os campos com máscara dentro de cada formulário
    function initializeMaskEdits() {
        // Seleciona todos os formulários no documento
        const formElements = document.querySelectorAll('form');

        // Log para verificar quantos formulários foram encontrados
        console.log(`Encontrados ${formElements.length} formulários no documento.`);

        formElements.forEach(form => {
            // Seleciona os inputs dentro de cada formulário que têm o atributo 'data-mask'
            const inputElements = form.querySelectorAll('[data-mask]');

            // Log para verificar quantos elementos foram encontrados em cada formulário
            console.log(`Encontrados ${inputElements.length} elementos com data-mask no formulário.`);

            inputElements.forEach(inputElement => {
                // Log para cada elemento em que a máscara será aplicada
                console.log(`Aplicando máscara no elemento:`, inputElement);
                new MiMaskEdit(inputElement);
            });

            console.log('Máscaras aplicadas a todos os elementos com data-mask no formulário.');
        });
    }

    console.log('Documento carregado, chamando initializeMaskEdits.');
    initializeMaskEdits();
        
    // Aguarda o carregamento do DOM antes de inicializar as máscaras
    // document.addEventListener('DOMContentLoaded', () => {
    //     console.log('Documento carregado, chamando initializeMaskEdits.');
    //     initializeMaskEdits();
    // });
}
