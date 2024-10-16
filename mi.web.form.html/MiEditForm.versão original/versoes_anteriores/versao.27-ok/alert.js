export class Alert {
    constructor(type = 'mtInformation', buttons = ['OK']) {
        this.type = type; 
        this.buttons = buttons; // Botões personalizados
        this.createAlertElements();
        this.setMessageClass(); // Aplica a classe do título com base no tipo
    }

    createAlertElements() {
        // Cria o fundo escuro (overlay)
        this.overlay = document.createElement('div');
        this.overlay.className = 'dialog-overlay'; // Usa o estilo da camada de fundo

        // Cria o contêiner do diálogo
        this.alertBox = document.createElement('div');
        this.alertBox.className = 'dialog-box'; // Aplica o estilo da classe dialog-box

        // Cria o elemento de título
        this.titleElement = document.createElement('h2'); 
        this.titleElement.classList.add('dialog-title'); // Classe para estilizar o título
        this.alertBox.appendChild(this.titleElement); // Adiciona o título ao diálogo

        // Cria o elemento de mensagem
        this.messageElement = document.createElement('p');
        this.messageElement.textContent = 'Aqui está a mensagem do alerta.'; // Mensagem padrão ou personalizada
        this.messageElement.classList.add('dialog-message'); // Classe para estilizar a mensagem
        this.alertBox.appendChild(this.messageElement); // Adiciona a mensagem ao diálogo

        // Criação do contêiner dos botões
        const buttonContainer = document.createElement('div');
        buttonContainer.className = 'button-container'; // Classe para centralizar botões
        this.alertBox.appendChild(buttonContainer);

        // Adiciona os botões personalizados ao contêiner
        this.buttons.forEach(button => {
            const actionButton = document.createElement('button');
            actionButton.textContent = this.getButtonLabel(button); // Define o texto do botão
            actionButton.classList.add('action-buttons'); // Aplica a classe de estilo para botões
            actionButton.addEventListener('click', () => this.handleButtonClick(button)); // Adiciona o evento de clique
            buttonContainer.appendChild(actionButton); // Adiciona o botão ao contêiner
        });

        // Adiciona o diálogo (alertBox) ao overlay
        this.overlay.appendChild(this.alertBox);

        // Adiciona o overlay ao corpo do documento (faz o diálogo aparecer)
        document.body.appendChild(this.overlay);
    }

    getButtonLabel(button) {
        switch (button) {
            case 'mbYes':
                return 'Sim';
            case 'mbNo':
                return 'Não';
            case 'mbOK':
                return 'OK';
            case 'mbCancel':
                return 'Cancelar';
            case 'mbAbort':
                return 'Abortar';
            case 'mbRetry':
                return 'Tentar Novamente';
            case 'mbIgnore':
                return 'Ignorar';
            case 'mbAll':
                return 'Todos';
            case 'mbNoToAll':
                return 'Não Para Todos';
            case 'mbYesToAll':
                return 'Sim Para Todos';
            case 'mbHelp':
                return 'Ajuda';
            case 'mbClose':
                return 'Fechar';
            default:
                return 'OK'; // Padrão
        }
    }

    handleButtonClick(button) {
        // Aqui você pode adicionar ações específicas para cada botão
        console.log(`Botão ${button} clicado`);
        this.close(); // Fecha o diálogo após a ação
    }

    setMessageClass() {
        // Remove todas as classes de estilo do título
        this.titleElement.classList.remove('warning', 'error', 'info', 'confirmation', 'custom', 'default');

        switch (this.type) {
            case 'mtWarning':
                this.titleElement.classList.add('warning');
                this.titleElement.textContent = 'Aviso';
                break;
            case 'mtError':
                this.titleElement.classList.add('error');
                this.titleElement.textContent = 'Erro';
                break;
            case 'mtInformation':
                this.titleElement.classList.add('info');
                this.titleElement.textContent = 'Informação';
                break;
            case 'mtConfirmation':
                this.titleElement.classList.add('confirmation');
                this.titleElement.textContent = 'Confirmação';
                break;
            case 'mtCustom':
                this.titleElement.classList.add('custom');
                this.titleElement.textContent = 'Personalizado';
                break;
            default:
                this.titleElement.classList.add('default');
                this.titleElement.textContent = 'Alerta';
                break;
        }
    }

    show(message) {
        this.messageElement.textContent = message;
        this.overlay.style.display = 'flex'; // Faz o diálogo aparecer
    }

    close() {
        // Lógica para fechar o alerta e remover do DOM
        if (this.overlay) {
            this.overlay.remove();
        }
        // Remova o container do alerta se necessário
    }    
    // close() {
    //     this.overlay.style.display = 'none'; // Fecha o diálogo
    //     this.overlay.remove(); // Remove o overlay do DOM
    // }

     /**
     * Exibe uma caixa de diálogo customizada com mensagem, título, tipo de diálogo e botões.
     * @param {string} message - A mensagem a ser exibida.
     * @param {string} title - O título da caixa de diálogo.
     * @param {string} dialogType - O tipo de diálogo (mtInformation, mtError, etc.).
     * @param {Array<string>} buttons - Array de botões a serem exibidos (mbOK, mbYes, mbNo, etc.).
     * @returns {Promise<string>} Retorna o botão clicado (resolve com o tipo do botão).
     */
    messageBox(message, title = 'Alerta', dialogType = 'mtInformation', buttons = ['mbOK']) {
        return new Promise((resolve) => {
            // Criar elementos HTML para a caixa de diálogo
            const overlay = document.createElement('div');
            overlay.className = 'dialog-overlay'; // Fundo escuro

            const dialogBox = document.createElement('div');
            dialogBox.className = 'dialog-box'; // Caixa de diálogo

            // Título da mensagem
            const dialogTitle = document.createElement('h2');
            dialogTitle.className = `dialog-title ${this.getDialogClass(dialogType)}`;
            dialogTitle.textContent = title;
            dialogBox.appendChild(dialogTitle);

            // Mensagem
            const dialogMessage = document.createElement('p');
            dialogMessage.className = 'dialog-message';
            dialogMessage.textContent = message;
            dialogBox.appendChild(dialogMessage);

            // Container dos botões
            const buttonContainer = document.createElement('div');
            buttonContainer.className = 'button-container';
            dialogBox.appendChild(buttonContainer);

            // Adiciona os botões conforme o parâmetro "buttons"
            buttons.forEach(button => {
                const btn = document.createElement('button');
                btn.textContent = this.getButtonLabel(button);
                btn.classList.add('action-buttons');
                btn.addEventListener('click', () => {
                    resolve(button); // Retorna o botão clicado
                    overlay.remove(); // Fecha o diálogo
                });
                buttonContainer.appendChild(btn);
            });

            // Adiciona a caixa de diálogo ao overlay e insere no corpo do documento
            overlay.appendChild(dialogBox);
            document.body.appendChild(overlay);
        });
    }

    showMessage(type, aMsg) {
        this.type = type;
        this.setMessageClass(); // Atualiza a classe com base no novo tipo
        
        // Cria o botão "OK"
        this.okButton = document.createElement('button');
        this.okButton.textContent = 'OK';

        // Adiciona o botão ao DOM (exemplo)
        const alertContainer = document.createElement('div');
        alertContainer.appendChild(this.okButton);
        document.body.appendChild(alertContainer); // Coloque onde o alerta deve aparecer

        // Exibe a mensagem (você pode ajustar esta parte)
        alertContainer.innerHTML += `<p>${aMsg}</p>`;
    }

    // Retorna a classe CSS correta para o tipo de diálogo
    getDialogClass(dialogType) {
        switch (dialogType) {
            case 'mtWarning':
                return 'warning';
            case 'mtError':
                return 'error';
            case 'mtInformation':
                return 'info';
            case 'mtConfirmation':
                return 'confirmation';
            case 'mtCustom':
                return 'custom';
            default:
                return 'default';
        }
    }

    // Retorna o rótulo de cada botão com base no seu tipo
    getButtonLabel(button) {
        switch (button) {
            case 'mbYes':
                return 'Sim';
            case 'mbNo':
                return 'Não';
            case 'mbOK':
                return 'OK';
            case 'mbCancel':
                return 'Cancelar';
            case 'mbAbort':
                return 'Abortar';
            case 'mbRetry':
                return 'Tentar Novamente';
            case 'mbIgnore':
                return 'Ignorar';
            case 'mbAll':
                return 'Todos';
            case 'mbNoToAll':
                return 'Não Para Todos';
            case 'mbYesToAll':
                return 'Sim Para Todos';
            case 'mbHelp':
                return 'Ajuda';
            case 'mbClose':
                return 'Fechar';
            default:
                return 'OK'; // Padrão
        }
    }        
}

// Função para exibir o alerta com base no tipo e botões
function showAlert(type, buttons) {
    const alert = new Alert(type, buttons);
    alert.show(`Esta é uma mensagem de ${type.replace('mt', '').toLowerCase()}.`);
}

// Função global messageBox
export async function messageBox(message, title = 'Alerta', dialogType = 'mtInformation', buttons = ['mbOK']) {
    /**
     * import { messageBox } from './caminho/para/seu/modulo';
     * Exemplo de uso
     * async function someFunction() {
     * const result = await messageBox('Esta é uma mensagem', 'Título', 'mtConfirmation', ['mbYes', 'mbNo']);
     * console.log(`Botão pressionado: ${result}`);
     * }
     */

    const alert = new Alert();  // Cria a instância do alerta
    let result; // Variável para armazenar o resultado

    // Exibir a mensagem usando o método show do Alert (ou método equivalente)
    await alert.messageBox(message, title, dialogType, buttons);

    // Aguardar a ação do usuário
    await new Promise((resolve) => {
        // Supondo que você tenha uma forma de obter o botão pressionado
        buttons.forEach((button) => {
            alert[button].addEventListener('click', () => {
                result = button;  // Armazenar o botão pressionado
                alert.close();    // Fechar o alerta
                resolve(result);  // Resolver a promessa com o resultado
            });
        });
    });

    // Remover a referência ao alerta, se necessário
    alert.overlay.remove(); // Remove o overlay do DOM

    return result; // Retornar o resultado
}

export async function showMessage(type = 'mtInformation', aMsg) {
    // Criar uma nova instância do alerta
    const alert = new Alert(type);

    // Exibir a mensagem
    alert.showMessage(type, aMsg);

    // Aguardar o usuário clicar em "OK" ou fechar o alerta
    return await new Promise((resolve) => {
        // Esperar um pequeno tempo para garantir que o botão foi adicionado ao DOM
        setTimeout(() => {
            // Verificar se o botão OK foi criado
            if (alert.okButton) {
                alert.okButton.addEventListener('click', () => {
                    alert.close(); // Fechar o alerta
                    resolve('OK clicado'); // Retornar um valor ao resolver a promessa
                });
            } else {
                console.error('Erro: Botão OK não foi encontrado.');
                resolve('Botão não encontrado'); // Retornar uma mensagem indicando o erro
            }
        }, 0); // Ajuste o tempo conforme necessário
    });
}

