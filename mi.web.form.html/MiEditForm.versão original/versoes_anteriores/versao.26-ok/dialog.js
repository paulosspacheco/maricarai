// dialog.js
class Dialog {
    constructor() {
        // Criação do contêiner do diálogo
        this.dialog = document.createElement('div');
        this.dialog.className = 'dialog hidden';

        // Criação do conteúdo do diálogo
        this.dialogContent = document.createElement('div');
        this.dialogContent.className = 'dialog-content';

        // Título do diálogo
        this.titleElement = document.createElement('h2');
        this.titleElement.className = 'dialog-title';

        // Mensagem do diálogo
        this.messageElement = document.createElement('p');

        // Botão OK
        this.okButton = document.createElement('button');
        this.okButton.textContent = 'OK';

        // Montagem da estrutura do diálogo
        this.dialogContent.appendChild(this.titleElement);
        this.dialogContent.appendChild(this.messageElement);
        this.dialogContent.appendChild(this.okButton);
        this.dialog.appendChild(this.dialogContent);
        document.body.appendChild(this.dialog);

        // Evento para fechar o diálogo
        this.okButton.addEventListener('click', () => this.close());
        
        // Ocultar o diálogo ao clicar fora dele
        this.dialog.addEventListener('click', (event) => {
            if (event.target === this.dialog) {
                this.close();
            }
        });
    }

    show(message, type) {
        // Define o título e a classe com base no tipo
        switch (type) {
            case 'warning':
                this.titleElement.innerText = 'Atenção!';
                this.titleElement.className = 'dialog-title warning';
                break;
            case 'error':
                this.titleElement.innerText = 'Erro!';
                this.titleElement.className = 'dialog-title error';
                break;
            case 'info':
                this.titleElement.innerText = 'Informação!';
                this.titleElement.className = 'dialog-title info';
                break;
            case 'confirmation':
                this.titleElement.innerText = 'Confirmação!';
                this.titleElement.className = 'dialog-title confirmation';
                break;
            default:
                this.titleElement.innerText = 'Mensagem!';
                this.titleElement.className = 'dialog-title default';
        }

        this.messageElement.innerText = message;
        this.dialog.classList.remove('hidden');
    }

    close() {
        this.dialog.classList.add('hidden');
    }
}
