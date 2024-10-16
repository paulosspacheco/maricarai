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
        dialogBox.classList.add('form-fields'); // Adiciona a classe CSS
    
        // Define um estilo para o diálogo
        dialogBox.style.backgroundColor = '#f0f0f0'; // Fundo cinza claro
        dialogBox.style.borderRadius = '8px'; // Bordas arredondadas
        dialogBox.style.padding = '20px'; // Espaçamento interno
        dialogBox.style.boxShadow = '0 4px 8px rgba(0, 0, 0, 0.2)'; // Sombra para efeito de elevação
        dialogBox.style.width = '300px'; // Largura do diálogo
        dialogBox.style.maxWidth = '80%'; // Largura máxima
    
        this.inputTitle = document.createElement('h2');
        this.inputTitle.innerText = 'Informe a Chave de Pesquisa'; // Título informativo
        this.inputTitle.style.color = '#333'; // Cor do título (escura para contraste)
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
        buttonContainer.style.display = 'flex'; // Estilo flex para os botões
        buttonContainer.style.justifyContent = 'space-between'; // Espaçamento entre os botões
        buttonContainer.style.marginTop = '10px'; // Espaço acima dos botões
    
        this.okButton = document.createElement('button');
        this.okButton.innerText = 'OK';
        this.okButton.classList.add('action-buttons'); // Adiciona a classe CSS ao botão
        buttonContainer.appendChild(this.okButton);
        
        this.cancelButton = document.createElement('button');
        this.cancelButton.innerText = 'Cancelar';
        this.cancelButton.classList.add('action-buttons'); // Adiciona a classe CSS ao botão
        buttonContainer.appendChild(this.cancelButton);
    
        // Adiciona o contêiner de botões ao diálogo
        dialogBox.appendChild(buttonContainer);
    
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
