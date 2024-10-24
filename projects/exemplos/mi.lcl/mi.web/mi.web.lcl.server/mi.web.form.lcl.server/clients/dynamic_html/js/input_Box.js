class InputBox {
    constructor(template) {
        // Dividir o template em linhas e processar cada uma
        this.fields = [];
        const lines = template.split('\n');

        lines.forEach(line => {
            const currentLine = [];
            let currentLabel = '';
            let inputLength = 0;
            let inLabel = false;

            for (let i = 0; i < line.length; i++) {
                switch (line[i]) {
                    case '~':
                        // Alterna entre label e campo
                        if (inLabel) {
                            // Finaliza o rótulo
                            inLabel = false;
                        } else {
                            // Inicia um novo rótulo
                            currentLabel = '';
                            inLabel = true;
                        }
                        break;
                    case '\\': // Marca o início de um campo de entrada
                        i++; // Avança para o próximo caractere após '\'

                        // Conta o número de 's' (cada 's' representa um caractere permitido no campo)
                        while (line[i] === 's') {
                            inputLength++;
                            i++;
                        }

                        // Se houver um rótulo atual, adicione o campo correspondente
                        if (currentLabel) {
                            currentLine.push({
                                label: currentLabel.trim(), // Adiciona o rótulo capturado
                                maxLength: inputLength      // Adiciona o comprimento máximo com base em 's'
                            });
                            currentLabel = ''; // Limpa o rótulo para o próximo campo
                        }
                        continue; // Já processamos o campo, podemos pular o incremento abaixo
                    default:
                        // Adiciona caracteres ao rótulo atual
                        if (inLabel) {
                            currentLabel += line[i];
                        }
                        break;
                }
            }

            // Adiciona a linha atual ao array de campos se houver campos
            if (currentLine.length > 0) {
                this.fields.push(currentLine);
            }
        });
    }

    showInputBox() {
        // Criar overlay para o diálogo
        const overlay = document.createElement('div');
        overlay.className = 'dialog-overlay';

        // Criar elementos do formulário
        const form = document.createElement('div');
        form.className = 'dialog-box'; // Aplicar a classe do CSS
        // form.style.width = '800px'; // Aumentar a largura do diálogo para 800px
        // form.style.maxHeight = '80vh'; // Limitar altura do diálogo a 80% da altura da tela

        // Criar campos de entrada
        const inputValues = {};
        this.fields.forEach(line => {
            const lineContainer = document.createElement('div');
            lineContainer.style.display = 'flex'; // Usar flexbox para a linha
            lineContainer.style.flexWrap = 'wrap'; // Permitir quebra de linha se necessário

            line.forEach(field => {
                // Criar rótulo
                const labelElement = document.createElement('label');
                labelElement.innerText = field.label + ' ';
                lineContainer.appendChild(labelElement);

                // Criar campo de entrada
                const inputField = document.createElement('input');
                inputField.type = 'text';
                inputField.maxLength = field.maxLength; // Define o tamanho máximo
                inputField.className = 'dialog-box'; // Aplicar a classe do CSS
                inputValues[field.label] = inputField;
                lineContainer.appendChild(inputField);
            });

            // Adicionar a linha ao formulário
            form.appendChild(lineContainer);
        });

        // Criar botão OK apenas após os campos
        const okButton = document.createElement('button');
        okButton.innerText = 'OK';
        okButton.className = 'action-buttons'; // Aplicar a classe do CSS
        okButton.onclick = () => {
            const values = {};
            this.fields.forEach(line => {
                line.forEach(field => {
                    values[field.label] = inputValues[field.label].value;
                });
            });
            alert(`Valores inseridos:\n${JSON.stringify(values, null, 2)}`);
            document.body.removeChild(overlay); // Remover o overlay
        };

        // Adicionar o botão OK ao formulário após todos os campos
        const buttonContainer = document.createElement('div');
        buttonContainer.className = 'button-container'; // Aplicar a classe do CSS
        buttonContainer.appendChild(okButton);
        form.appendChild(buttonContainer);

        // Adicionar formulário ao overlay
        overlay.appendChild(form);
        document.body.appendChild(overlay);
    }
}

// Template de exemplo
// const inputBoxTemplate = 
//     `~Nome do Aluno:~\\ssssssssssssss
//      ~Endereço:~\\ssssssssssssssssss ~Número:~\\ssss`;

// // Usar a classe
// const inputBox = new InputBox(inputBoxTemplate);
// inputBox.showInputBox();
