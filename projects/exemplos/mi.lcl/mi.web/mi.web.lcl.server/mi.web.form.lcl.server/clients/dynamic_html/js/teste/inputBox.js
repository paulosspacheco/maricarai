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
        // Criar elementos do formulário
        const form = document.createElement('div');
        form.style.width = '800px'; // Aumentar a largura do diálogo para 800px
        form.style.padding = '20px';
        form.style.border = '1px solid #ccc';
        form.style.borderRadius = '5px';
        form.style.position = 'fixed';
        form.style.top = '50%';
        form.style.left = '50%';
        form.style.transform = 'translate(-50%, -50%)';
        form.style.backgroundColor = '#fff';
        form.style.zIndex = '1000';
        form.style.overflow = 'auto'; // Para permitir rolagem
        form.style.maxHeight = '400px'; // Limitar altura do diálogo

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
                inputField.style.marginRight = '10px'; // Espaço entre o campo e o rótulo
                lineContainer.appendChild(inputField);

                // Armazenar o valor do campo
                inputValues[field.label] = inputField;
            });

            // Adicionar a linha ao formulário
            form.appendChild(lineContainer);
        });

        // Criar botão OK apenas após os campos
        const okButton = document.createElement('button');
        okButton.innerText = 'OK';
        okButton.onclick = () => {
            const values = {};
            this.fields.forEach(line => {
                line.forEach(field => {
                    values[field.label] = inputValues[field.label].value;
                });
            });
            alert(`Valores inseridos:\n${JSON.stringify(values, null, 2)}`);
            document.body.removeChild(form); // Remover o formulário
        };
        
        // Adicionar o botão OK ao formulário após todos os campos
        form.appendChild(okButton);

        // Adicionar formulário ao corpo do documento
        document.body.appendChild(form);
    }
}

// Template de exemplo
// const inputBoxTemplate = 
//     `~Nome do Aluno:~\\ssssssssssssss
//      ~Endereço:~\\ssssssssssssssssss ~Número:~\\ssss`;

// // Usar a classe
// const inputBox = new InputBox(inputBoxTemplate);
// inputBox.showInputBox();
