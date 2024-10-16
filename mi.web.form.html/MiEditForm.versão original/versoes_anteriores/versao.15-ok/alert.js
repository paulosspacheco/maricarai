// alert.js
export class Alert {
    constructor() {
      this.createAlertElements();
    }
  
    createAlertElements() {
      this.overlay = document.createElement('div');
      this.overlay.className = 'overlay';
  
      this.alertBox = document.createElement('div');
      this.alertBox.className = 'alert-box';
  
      this.messageElement = document.createElement('p');
  
      this.okButton = document.createElement('button');
      this.okButton.textContent = 'OK';
      this.okButton.addEventListener('click', () => this.close());
  
      this.alertBox.appendChild(this.messageElement);
      this.alertBox.appendChild(this.okButton);
      this.overlay.appendChild(this.alertBox);
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
  
  