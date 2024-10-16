//inpuBox.js

// Exporta a classe JsonInputBox
export class JsonInputBox {
    constructor() {
        this.overlay = null;
        this.inputValue = null;
        this.inputTitle = null;
        this.okButton = null;
        this.cancelButton = null;
    }

    createDialog() {
        // Cria elementos para o diálogo
        this.overlay = document.createElement('div');
        this.overlay.style.position = 'fixed';
        this.overlay.style.top = '0';
        this.overlay.style.left = '0';
        this.overlay.style.width = '100%';
        this.overlay.style.height = '100%';
        this.overlay.style.backgroundColor = 'rgba(0, 0, 0, 0.5)';
        this.overlay.style.display = 'flex';
        this.overlay.style.alignItems = 'center';
        this.overlay.style.justifyContent = 'center';
        this.overlay.style.zIndex = '1000';

        const dialogBox = document.createElement('div');
        dialogBox.style.backgroundColor = 'white';
        dialogBox.style.padding = '20px';
        dialogBox.style.borderRadius = '5px';
        dialogBox.style.boxShadow = '0 2px 10px rgba(0, 0, 0, 0.1)';

        this.inputTitle = document.createElement('h2');
        dialogBox.appendChild(this.inputTitle);

        this.inputValue = document.createElement('input');
        this.inputValue.type = 'text';
        dialogBox.appendChild(this.inputValue);

        this.okButton = document.createElement('button');
        this.okButton.innerText = 'OK';
        dialogBox.appendChild(this.okButton);

        this.cancelButton = document.createElement('button');
        this.cancelButton.innerText = 'Cancelar';
        dialogBox.appendChild(this.cancelButton);

        this.overlay.appendChild(dialogBox);
        document.body.appendChild(this.overlay);
    }

    async show(title, initialValue) {
        this.createDialog();

        // Configura título e valor inicial
        this.inputTitle.innerText = title;
        this.inputValue.value = initialValue;

        return new Promise((resolve) => {
            // Evento de OK
            this.okButton.onclick = () => {
                this.overlay.style.display = 'none';
                document.body.removeChild(this.overlay); // Remove o diálogo
                resolve(this.inputValue.value);  // Retorna o valor do input
            };

            // Evento de Cancelar
            this.cancelButton.onclick = () => {
                this.overlay.style.display = 'none';
                document.body.removeChild(this.overlay); // Remove o diálogo
                resolve(null);  // Retorna null se cancelar
            };
        });
    }
}

// Função de entrada para usar o JsonInputBox
export async function InputBox(aTitle, KeyIn, KeyOut) {
    let jsonInputBox = new JsonInputBox();
    const result = await jsonInputBox.show(aTitle, KeyIn);

    if (result !== null) {
        KeyOut.value = result;
        return true;
    } else {
        return false;
    }
}
