/* MiThemeDialog.js*/

export class MiThemeDialog {
    constructor() {
        // Criar o fundo da caixa de diálogo (modal overlay)
        this.dialogOverlay = document.createElement('div');
        this.dialogOverlay.style.position = 'fixed';
        this.dialogOverlay.style.top = '0';
        this.dialogOverlay.style.left = '0';
        this.dialogOverlay.style.width = '100vw';
        this.dialogOverlay.style.height = '100vh';
        this.dialogOverlay.style.backgroundColor = 'rgba(0, 0, 0, 0.5)';
        this.dialogOverlay.style.display = 'flex';
        this.dialogOverlay.style.justifyContent = 'center';
        this.dialogOverlay.style.alignItems = 'center';
        this.dialogOverlay.id = 'dialog-overlay';

        // Criar o container da caixa de diálogo
        this.dialogBox = document.createElement('div');
        this.dialogBox.style.backgroundColor = '#fff';
        this.dialogBox.style.padding = '20px';
        this.dialogBox.style.borderRadius = '8px';
        this.dialogBox.style.boxShadow = '0 0 10px rgba(0, 0, 0, 0.25)';
        this.dialogBox.style.width = '300px';
        this.dialogBox.style.textAlign = 'center';

        // Título da caixa de diálogo
        const dialogTitle = document.createElement('h2');
        dialogTitle.textContent = 'Selecione um Tema';
        this.dialogBox.appendChild(dialogTitle);

        // Criar o rótulo para o seletor de temas
        const label = document.createElement('label');
        label.setAttribute('for', 'theme-selector');
        label.textContent = 'Temas:';
        this.dialogBox.appendChild(label);

        // Criar o seletor de temas (combobox)
        this.select = document.createElement('select');
        this.select.id = 'theme-selector';
        const themes = [
            { name: 'Tons de amarelo', value: 'color_tons_amarelo.css' },
            { name: 'Tons dark', value: 'color_tons_dark.css' },
            { name: 'Tons dark claro', value: 'color_tons_de_dark_claro.css' },
            { name: 'Tons de azul', value: 'color_tons_de_azul_ceu.css' },
            { name: 'Tons de cinza', value: 'color_tons_de_cinza.css' },
            { name: 'Tons de lilás claro', value: 'color_tons_de_lilas_claro.css' },
            { name: 'Tons de verde claro', value: 'color_tons_de_verde_claro.css' }
        ];

        themes.forEach(theme => {
            const option = document.createElement('option');
            option.value = theme.value;
            option.textContent = theme.name;
            this.select.appendChild(option);
        });

        this.dialogBox.appendChild(this.select);

        // Botão "Aplicar Tema"
        const applyButton = document.createElement('button');
        applyButton.textContent = 'Aplicar Tema';
        applyButton.style.marginTop = '10px';
        applyButton.onclick = () => this.applyTheme();
        this.dialogBox.appendChild(applyButton);

        // Botão "Cancelar"
        const cancelButton = document.createElement('button');
        cancelButton.textContent = 'Cancelar';
        cancelButton.style.marginLeft = '10px';
        cancelButton.onclick = () => this.close();
        this.dialogBox.appendChild(cancelButton);

        // Adicionar a caixa de diálogo ao overlay
        this.dialogOverlay.appendChild(this.dialogBox);
    }

    // Método para abrir o diálogo
    open() {
        document.body.appendChild(this.dialogOverlay);
    }

    // Método para fechar o diálogo
    close() {
        if (this.dialogOverlay) {
            this.dialogOverlay.remove();
        }
    }

    // Método para aplicar o tema selecionado
    applyTheme() {
        const selectedTheme = this.select.value;
        MiThemeDialog.changeTheme(selectedTheme);
        this.close(); // Fecha o diálogo após aplicar o tema
    }

    // Método para alterar o tema (adaptado da função changeTheme)
    static changeTheme(themeFile) {
        // Verifica se já existe um <style> para o tema
        let themeStyle = document.getElementById('theme-style');

        if (themeStyle) {
            // Se o <style> já existe, altera o conteúdo de @import
            themeStyle.innerHTML = `@import url('./css/${themeFile}');`;
        } else {
            // Se o <style> não existe, cria um e adiciona no <head>
            themeStyle = document.createElement('style');
            themeStyle.id = 'theme-style';
            themeStyle.innerHTML = `@import url('./css/${themeFile}');`;
            document.head.appendChild(themeStyle);
        }
    }
}
