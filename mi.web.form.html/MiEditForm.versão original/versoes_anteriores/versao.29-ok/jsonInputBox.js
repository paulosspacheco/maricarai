// jsonInputBox.js

// Exporta a classe JsonInputBox
export class JsonInputBox {
    constructor() {
        this.overlay = null;
        this.inputFields = {}; // Objeto para armazenar campos de entrada
        this.inputTitle = null;
        this.okButton = null;
        this.cancelButton = null;
    }

    createDialog() {
        // Cria elementos para o diálogo
        this.overlay = document.createElement('div');
        this.overlay.classList.add('dialog-overlay'); // Aplica a classe .dialog-overlay
    
        const dialogBox = document.createElement('div');
        dialogBox.classList.add('dialog-box'); // Aplica a classe .dialog-box
        
        // Título do diálogo
        this.inputTitle = document.createElement('h2');
        this.inputTitle.innerText = 'Informe a Chave de Pesquisa';
        dialogBox.appendChild(this.inputTitle);
    
        // Cria campos de entrada com base em KeyIn
        for (const key in this.inputFields) {
            const label = document.createElement('label');
            label.innerText = key; // Nome do campo
            dialogBox.appendChild(label);
    
            const input = document.createElement('input');
            input.type = 'text';
            input.value = this.inputFields[key]; // Valor inicial
            this.inputFields[key] = input; // Armazena o campo de entrada
            dialogBox.appendChild(input);
        }
    
        // Criação do contêiner dos botões
        const buttonContainer = document.createElement('div');
        buttonContainer.style.display = 'flex';
        buttonContainer.style.justifyContent = 'space-between';
        buttonContainer.style.marginTop = '10px';
    
        this.okButton = document.createElement('button');
        this.okButton.innerText = 'OK';
        this.okButton.classList.add('action-buttons'); // Aplica a classe de estilo do botão
        buttonContainer.appendChild(this.okButton);
    
        this.cancelButton = document.createElement('button');
        this.cancelButton.innerText = 'Cancelar';
        this.cancelButton.classList.add('action-buttons'); // Aplica a classe de estilo do botão
        buttonContainer.appendChild(this.cancelButton);
    
        // Adiciona o contêiner de botões ao diálogo
        dialogBox.appendChild(buttonContainer);
    
        // Adiciona o diálogo ao overlay
        this.overlay.appendChild(dialogBox);
        document.body.appendChild(this.overlay);
    }
    
    
    
    
    async show(title, inputValues) {
        this.inputFields = { ...inputValues }; // Armazena os campos de entrada
        this.createDialog();

        // Configura título
        this.inputTitle.innerText = title;

        return new Promise((resolve) => {
            // Evento de OK
            this.okButton.onclick = () => {
                const result = {};
                for (const key in this.inputFields) {
                    result[key] = this.inputFields[key].value; // Coleta os valores dos campos de entrada
                }
                this.overlay.style.display = 'none';
                document.body.removeChild(this.overlay); // Remove o diálogo
                resolve(result); // Retorna o objeto preenchido
            };

            // Evento de Cancelar
            this.cancelButton.onclick = () => {
                this.overlay.style.display = 'none';
                document.body.removeChild(this.overlay); // Remove o diálogo
                resolve(null); // Retorna null se cancelar
            };
        });
    }
}

// Função de entrada para usar o JsonInputBox
export async function InputBox(aTitle, KeyIn) {
    let jsonInputBox = new JsonInputBox();
    const result = await jsonInputBox.show(aTitle, KeyIn); // Passa KeyIn diretamente

    return result; // Retorna o resultado (pode ser null ou o objeto preenchido)
}
