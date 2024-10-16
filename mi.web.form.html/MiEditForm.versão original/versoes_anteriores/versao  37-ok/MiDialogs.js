/**
 * const dialogTypes = [
    { type: 'mtWarning', label: 'Aviso', class: 'warning' },
    { type: 'mtError', label: 'Erro', class: 'error' },
    { type: 'mtInformation', label: 'Informação', class: 'info' },
    { type: 'mtConfirmation', label: 'Confirmação', class: 'confirmation' },
    { type: 'mtCustom', label: 'Personalizado', class: 'custom' },
    { type: 'default', label: 'dialogs', class: 'default' }
   ]; 

    async testConfirmarAcao() {
            if (await this.messageBox(
                'Você deseja excluir este item?',  // Mensagem de confirmação
                'Confirmação de Exclusão',         // Título do diálogo
                'mtConfirmation',                  // Tipo de diálogo (Confirmação)
                ['mbYes', 'mbNo']                  // Botões exibidos
            ) === 'mbYes') {            
            this.showMessage('mtInformation','Botão MbYes pressionando');            
            //   this.alert('Botão MbYes pressionando');                             
            } else {
            //    this.showMessage('mtInformation','Botão MbNo pressionando');
                this.alert('Botão MbNo pressionando');
            }                
        }


 */

export class MiDialogs {
    constructor(type = 'mtInformation', buttons = ['OK']) {
        this.type = type; 
        this.buttons = buttons; // Botões personalizados
        this.buttonReferences = {}; // Inicializa o objeto de referências dos botões
        this.createDialogsElements();
        this.setMessageClass(); // Aplica a classe do título com base no tipo
    }    

    handleButtonClick(button) {
        // Aqui você pode adicionar ações específicas para cada botão
        // console.log(`Botão ${button} clicado`);
        this.close(); // Fecha o diálogo após a ação
    }

    createDialogsElements() {
        // Cria o fundo escuro (overlay)
        this.overlay = document.createElement('div');
        this.overlay.className = 'dialog-overlay';

        // Cria o contêiner do diálogo
        this.dialogsBox = document.createElement('div');
        this.dialogsBox.className = 'dialog-box';

        // Cria o elemento de título
        this.titleElement = document.createElement('h2'); 
        this.titleElement.classList.add('dialog-title');
        this.dialogsBox.appendChild(this.titleElement);

        // Cria o elemento de mensagem
        this.messageElement = document.createElement('p');
        this.messageElement.textContent = 'Aqui está a mensagem do dialogs.';
        this.messageElement.classList.add('dialog-message');
        this.dialogsBox.appendChild(this.messageElement);

        // Criação do contêiner dos botões
        const buttonContainer = document.createElement('div');
        buttonContainer.className = 'button-container';
        this.dialogsBox.appendChild(buttonContainer);

        // Adiciona os botões personalizados ao contêiner
        this.buttons.forEach(button => {
            const actionButton = document.createElement('button');
            actionButton.textContent = this.getButtonLabel(button); // Define o texto do botão
            actionButton.classList.add('action-buttons');

            // Adiciona referência do botão à propriedade
            this.buttonReferences[button] = actionButton; // Armazena a referência do botão

            actionButton.addEventListener('click', () => this.handleButtonClick(button));
            buttonContainer.appendChild(actionButton); // Adiciona o botão ao contêiner
        });

        // Adiciona o diálogo (dialogsBox) ao overlay
        this.overlay.appendChild(this.dialogsBox);
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
                this.titleElement.textContent = 'dialogs';
                break;
        }
    }

    show(message) {
        this.messageElement.textContent = message;
        this.overlay.style.display = 'flex'; // Faz o diálogo aparecer
    }

    // Método para fechar o diálogo
    close() {
        // Lógica para fechar o dialogs e remover do DOM
        if (this.overlay) {
            this.overlay.remove(); // Remove o contêiner do diálogo
            this.overlay = null; // Limpa a referência
        }
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
    
     /**
     * Exibe uma caixa de diálogo customizada com mensagem, título, tipo de diálogo e botões.
     * @param {string} message - A mensagem a ser exibida.
     * @param {string} title - O título da caixa de diálogo.
     * @param {string} dialogType - O tipo de diálogo (mtInformation, mtError, etc.).
     * @param {Array<string>} buttons - Array de botões a serem exibidos (mbOK, mbYes, mbNo, etc.).
     * @returns {Promise<string>} Retorna o botão clicado (resolve com o tipo do botão).
     */
    messageBox(message, title = 'dialogs', dialogType = 'mtInformation', buttons = ['mbOK']) {
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

    
    async showMessage(type = 'mtInformation',message) {
        const title = this.getDialogClass(type);
        this.messageElement.textContent = message; // Define a mensagem do dialog
        this.titleElement.textContent = title; // Define o título do dialog

        let result; // Variável para armazenar o resultado

        // Aguardar a ação do usuário
        await new Promise((resolve) => {
            // Adicione verificações para garantir que os botões existem
            this.buttons.forEach((button) => {
                if (this.buttonReferences[button]) { // Usando buttonReferences
                    this.buttonReferences[button].addEventListener('click', () => {
                        result = button; // Armazena o botão pressionado
                        this.close(); // Fecha o dialog
                        resolve(result); // Resolve a promessa com o resultado
                    });
                } else {
                    console.error(`Botão ${button} não encontrado no objeto dialogs.`);
                }
            });
        });

        // Remover o overlay após a ação do usuário
        this.close(); // Fechar o dialog (garantindo que o overlay é removido)

        return result; // Retornar o resultado
    }

}


// Função global messageBox
export async function messageBox(message, title = 'dialogs', dialogType = 'mtInformation', buttons = ['mbOK']) {
    const miDialogs = new MiDialogs(dialogType, buttons); // Passa dialogType e buttons para a instância do dialogs
    miDialogs.messageElement.textContent = message; // Define a mensagem do dialogs
    miDialogs.titleElement.textContent = title; // Define o título do dialogs

    let result; // Variável para armazenar o resultado

    // Aguardar a ação do usuário
    await new Promise((resolve) => {
        // Adicione verificações para garantir que os botões existem
        buttons.forEach((button) => {
            //console.log(`Verificando botão: ${button}`, dialogs.buttonReferences[button]); // Log para depuração
            
            if (dialogs.buttonReferences[button]) { // Usando buttonReferences
                dialogs.buttonReferences[button].addEventListener('click', () => {
                    result = button; // Armazena o botão pressionado
                    dialogs.close(); // Fecha o dialogsa
                    resolve(result); // Resolve a promessa com o resultado
                });
            } else {
                console.error(`Botão ${button} não encontrado no objeto dialogs.`);
            }
        });
    });

    // Remover o overlay após a ação do usuário
    dialogs.close(); // Fechar o dialogsa (garantindo que o overlay é removido)

    return result; // Retornar o resultado
}


// Função global messageBox
export async function showMessage(dialogType = 'mtInformation',message) {
    // const title = 'dialogs'; 
    const buttons = ['mbOK'];
    const miDialogs = new MiDialogs(dialogType, buttons); // Passa dialogType e buttons para a instância do dialogs
    // const title = Dialogs.getDialogClass(dialogType);
    miDialogs.messageElement.textContent = message; // Define a mensagem do dialogs
    miDialogs.titleElement.textContent = miDialogs.getDialogClass(dialogType);//title; // Define o título do dialogs

    let result; // Variável para armazenar o resultado

    // Aguardar a ação do usuário
    await new Promise((resolve) => {
        // Adicione verificações para garantir que os botões existem
        buttons.forEach((button) => {
            //console.log(`Verificando botão: ${button}`, dialogs.buttonReferences[button]); // Log para depuração
            
            if (miDialogs.buttonReferences[button]) { // Usando buttonReferences
                miDialogs.buttonReferences[button].addEventListener('click', () => {
                    result = button; // Armazena o botão pressionado
                    miDialogs.close(); // Fecha o dialogsa
                    resolve(result); // Resolve a promessa com o resultado
                });
            } else {
                console.error(`Botão ${button} não encontrado no objeto dialogs.`);
            }
        });
    });

    // Remover o overlay após a ação do usuário
    miDialogs.close(); // Fechar o dialogsa (garantindo que o overlay é removido)

    return result; // Retornar o resultado
}



