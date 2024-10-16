export class Alert {
    constructor(type = 'mtInformation') { 
        this.type = type; 
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

        // Cria o botão OK
        this.okButton = document.createElement('button');
        this.okButton.textContent = 'OK';
        this.okButton.classList.add('action-buttons'); // Aplica a classe de estilo para botões
        this.okButton.addEventListener('click', () => this.close());

        // Adiciona o botão ao contêiner de botões
        buttonContainer.appendChild(this.okButton);

        // Adiciona o diálogo (alertBox) ao overlay
        this.overlay.appendChild(this.alertBox);

        // Adiciona o overlay ao corpo do documento (faz o diálogo aparecer)
        document.body.appendChild(this.overlay);
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
        this.overlay.style.display = 'none'; // Fecha o diálogo
        this.overlay.remove(); // Remove o overlay do DOM
    }
}

// Função para exibir o alerta com base no tipo
function showAlert(type) {
    const alert = new Alert(type);
    alert.show(`Esta é uma mensagem de ${type.replace('mt', '').toLowerCase()}.`);
}
