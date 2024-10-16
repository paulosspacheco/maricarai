// alert.js
export class Alert {
    constructor() {
      this.createAlertElements();
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
      this.titleElement.textContent = 'Alerta'; // Título do alerta
      this.titleElement.classList.add('dialog-title'); // Classe opcional para estilizar o título
      this.alertBox.appendChild(this.titleElement); // Adiciona o título ao diálogo
  
      // Cria o elemento de mensagem
      this.messageElement = document.createElement('p');
      this.messageElement.textContent = 'Aqui está a mensagem do alerta.'; // Mensagem padrão ou personalizada
      this.messageElement.classList.add('dialog-message'); // Classe opcional para estilizar a mensagem
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
  
  
  
  
    show(message) {
      this.messageElement.textContent = message;
      this.overlay.style.display = 'flex';
    }
  
    close() {
      this.overlay.style.display = 'none';
    }
  }
  
  