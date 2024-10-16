export class Dialogs {
    private type: string;
    private buttons: string[];
    private buttonReferences: Record<string, HTMLButtonElement>;
    private overlay: HTMLElement | null = null;
    private dialogsBox: HTMLElement | null = null;
    private titleElement: HTMLHeadingElement | null = null;
    private messageElement: HTMLParagraphElement | null = null;

    constructor(type: string = 'mtInformation', buttons: string[] = ['OK']) {
        this.type = type;
        this.buttons = buttons; // Botões personalizados
        this.buttonReferences = {}; // Inicializa o objeto de referências dos botões
        this.createDialogsElements();
        this.setMessageClass(); // Aplica a classe do título com base no tipo
    }

    private handleButtonClick(button: string): void {
        // Aqui você pode adicionar ações específicas para cada botão
        // console.log(`Botão ${button} clicado`);
        this.close(); // Fecha o diálogo após a ação
    }

    private createDialogsElements(): void {
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

    private getButtonLabel(button: string): string {
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

    private setMessageClass(): void {
        // Remove todas as classes de estilo do título
        if (this.titleElement) {
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
    }

    public show(message: string): void {
        if (this.messageElement && this.overlay) {
            this.messageElement.textContent = message;
            this.overlay.style.display = 'flex'; // Faz o diálogo aparecer
        }
    }

    public close(): void {
        if (this.overlay) {
            this.overlay.remove(); // Remove o contêiner do diálogo
            this.overlay = null; // Limpa a referência
        }
    }

    private getDialogClass(dialogType: string): string {
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

    public messageBox(
        message: string,
        title: string = 'dialogs',
        dialogType: string = 'mtInformation',
        buttons: string[] = ['mbOK']
    ): Promise<string> {
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

    public async showMessage(type: string = 'mtInformation', message: string): Promise<string | undefined> {
        const title = 'dialogs';
        if (this.messageElement && this.titleElement) {
            this.messageElement.textContent = message; // Define a mensagem do dialog
            this.titleElement.textContent = title; // Define o título do dialog
        }

        let result: string | undefined; // Variável para armazenar o resultado

        // Aguardar a ação do usuário
        await new Promise((resolve) => {
            // Adicione verificações para garantir que os botões existem
            this.buttons.forEach((button) => {
                const btn = this.buttonReferences[button];
                if (btn) {
                    btn.addEventListener('click', () => {
                        result = button; // Armazena o botão pressionado
                        this.close(); // Fecha o dialog
                        resolve(result); // Resolve a promessa com o resultado
                    });
                } else {
                    console.error(`Botão ${button} não encontrado no objeto dialogs.`);
                }
            });
        });

        this.close(); // Fechar o dialog (garantindo que o overlay é removido)

        return result; // Retornar o resultado
    }
}

/*==========================================================*/
// Funções globais
/*==========================================================*/
// Tipos para os botões e tipos de diálogo
type DialogType = 'mtInformation' | 'mtWarning' | 'mtError'; // Defina os tipos possíveis para dialogType
type ButtonType = 'mbOK' | 'mbCancel' | 'mbYes' | 'mbNo'; // Defina os tipos possíveis para os botões

// Função global messageBox
export async function messageBox(
  message: string,
  title: string = 'dialogs',
  dialogType: DialogType = 'mtInformation',
  buttons: ButtonType[] = ['mbOK']
): Promise<ButtonType> {
  const dialogs = new Dialogs(dialogType, buttons); // Passa dialogType e buttons para a instância do dialogs
  dialogs.messageElement.textContent = message; // Define a mensagem do dialogs
  dialogs.titleElement.textContent = title; // Define o título do dialogs

  let result: ButtonType; // Variável para armazenar o resultado

  // Aguardar a ação do usuário
  await new Promise<ButtonType>((resolve) => {
    // Adicione verificações para garantir que os botões existem
    buttons.forEach((button) => {
      if (dialogs.buttonReferences[button]) { // Usando buttonReferences
        dialogs.buttonReferences[button].addEventListener('click', () => {
          result = button; // Armazena o botão pressionado
          dialogs.close(); // Fecha o dialogs
          resolve(result); // Resolve a promessa com o resultado
        });
      } else {
        console.error(`Botão ${button} não encontrado no objeto dialogs.`);
      }
    });
  });

  // Remover o overlay após a ação do usuário
  dialogs.close(); // Fechar o dialogs (garantindo que o overlay é removido)

  return result; // Retornar o resultado
}

// Função global showMessage
export async function showMessage(
  dialogType: DialogType = 'mtInformation',
  message: string
): Promise<ButtonType> {
  
  const buttons: ButtonType[] = ['mbOK'];
  const dialogs = new Dialogs(dialogType, buttons); // Passa dialogType e buttons para a instância do dialogs
  dialogs.messageElement.textContent = message; // Define a mensagem do dialogs
  dialogs.titleElement.textContent = title; // Define o título do dialogs

  let result: ButtonType; // Variável para armazenar o resultado

  // Aguardar a ação do usuário
  await new Promise<ButtonType>((resolve) => {
    // Adicione verificações para garantir que os botões existem
    buttons.forEach((button) => {
      if (dialogs.buttonReferences[button]) { // Usando buttonReferences
        dialogs.buttonReferences[button].addEventListener('click', () => {
          result = button; // Armazena o botão pressionado
          dialogs.close(); // Fecha o dialogs
          resolve(result); // Resolve a promessa com o resultado
        });
      } else {
        console.error(`Botão ${button} não encontrado no objeto dialogs.`);
      }
    });
  });

  // Remover o overlay após a ação do usuário
  dialogs.close(); // Fechar o dialogs (garantindo que o overlay é removido)

  return result; // Retornar o resultado
}



