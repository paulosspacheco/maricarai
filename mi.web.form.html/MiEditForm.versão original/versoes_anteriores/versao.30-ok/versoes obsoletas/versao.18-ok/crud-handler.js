class CRUDHandler {
    constructor(formId, keyFields) {
        this.form = document.getElementById(formId);
        if (!this.form) {
            throw new Error(`Formulário com ID ${formId} não encontrado.`);
        }
        this.keyFields = keyFields.split(';');
        this.options = 'loCaseInsensitive,loPartialKey';
        this.isDataSetActive = false; // Inicialmente não está ativo
        this.state = 0; // Representa o estado atual
        this.recordAltered = false; // Indica se o registro foi alterado
        this.appending = false; // Indica se está no modo de inserção
        this.bof = false; // Indica se é o início do conjunto de registros
        this.eof = false; // Indica se é o fim do conjunto de registros

        // Chama o método para normalizar os campos de ID e Name do formulário
        this.normalizeFormIdsAndNames();
                
        // Verifica se a API está disponível
        this.checkApiAvailability();
    }

    clearForm() {
        const formFields = this.form.querySelectorAll('input, textarea, select');
        formFields.forEach(field => field.value = '');
    }

    async checkApiAvailability() {
        try {
            const { status } = await this.sendRequest('CmhealthCheck', null,null, 'GET');
            if (status === 200) {
                // API disponível, habilitar botões se necessário
                this.enableButtons();
                this.isDataSetActive = true; // API ativa
            } else {
                // API indisponível, desabilitar todos os botões
                this.disableAllButtons();
                this.isDataSetActive = false; // API não ativa
            }
        } catch (error) {
            console.error(`Erro ao verificar disponibilidade da API: ${error.message}`);
            this.disableAllButtons(); // Desabilita botões em caso de erro
            this.isDataSetActive = false; // API não ativa
        }
    }

    // Método para desabilitar todos os botões
    disableAllButtons() {
        const buttons = this.form.querySelectorAll('button');
        buttons.forEach(button => button.disabled = true);
    }

    // Método para habilitar os botões (substitua por sua lógica específica)
    enableButtons() {
        const buttons = this.form.querySelectorAll('button');
        buttons.forEach(button => button.disabled = false);
    }

    // Método para atualizar o estado dos comandos
    updateCommands() {
        if (this.isDataSetActive) {
            if (this.state & Mb_St_Insert) {
                this.disableCommands([]);
                if (this.recordAltered) {
                    this.enableCommands([CmUpdateRecord, CmCancel]);
                } else {
                    this.enableCommands([CmRefresh, CmLocate]);
                }
            } else if (this.state & Mb_St_Edit) {
                if ((!this.bof && !this.eof) || this.recordAltered) {
                    if (this.recordAltered) {
                        this.disableCommands([]);
                        this.enableCommands([CmUpdateRecord, CmCancel]);
                    } else {
                        this.disableCommands([]);
                        this.enableCommands([CmNewRecord, CmDeleteRecord, CmGoBof, CmNextRecord, CmPrevRecord, CmGoEof, CmLocate, CmRefresh]);

                        if (this.bof) {
                            this.disableCommands([CmGoBof]);
                        } else if (this.eof) {
                            this.disableCommands([CmGoEof]);
                        }
                    }
                } else {
                    if (!this.appending) {
                        this.enableCommands([]);
                        this.disableCommands([CmUpdateRecord, CmCancel]);
                    }

                    if (this.eof) {
                        this.disableCommands([CmNextRecord, CmGoEof]);
                    } else if (this.bof) {
                        this.disableCommands([CmPrevRecord, CmGoBof]);
                    }
                }
            } else {
                if (!this.appending && !this.recordAltered) {
                    this.enableCommands([]);
                    this.disableCommands([CmUpdateRecord, CmCancel]);
                }
            }
        }
    }

    // Métodos para habilitar e desabilitar comandos
    enableCommands(commands) {
        commands.forEach(command => {
            const button = document.getElementById(command);
            if (button) button.disabled = false;
        });
    }

    disableCommands(commands) {
        commands.forEach(command => {
            const button = document.getElementById(command);
            if (button) button.disabled = true;
        });
    }

    // Método para normalizar IDs e nomes dos campos do formulário
    normalizeFormIdsAndNames() {
        const formFields = this.form.querySelectorAll('input, textarea, select');

        formFields.forEach(field => {
            if (field.id) {
                field.id = field.id.toLowerCase();
            }

            if (field.name) {
                field.name = field.name.toLowerCase();
            }

            const label = this.form.querySelector(`label[for="${field.id}"]`);
            if (label) {
                label.setAttribute('for', field.id);
            }
        });
    }

    getFormData() {
        const formData = new FormData(this.form);
        const data = {};

        formData.forEach((value, key) => {
            data[key.toLowerCase()] = value; // Armazena o nome do campo em minúsculas
        });

        return data;
    }

    getFieldValue(fieldName) {
        const field = document.getElementById(fieldName.toLowerCase());
        if (field) {
            return field.value;
        } else {
            throw new Error(`Campo ${fieldName} não encontrado.`);
        }
    }

    setFieldValue(fieldName, value) {
        const field = document.getElementById(fieldName.toLowerCase());
        if (field) {
            field.value = value != null ? value.toString() : '';
        } else {
            console.warn(`Campo com ID ${fieldName} não encontrado.`);
        }
    }

    updateForm(data) {
        if (!data || typeof data !== 'object') {
            console.warn('Dados para atualizar o formulário são nulos ou inválidos:', data);
            return;
        }

        for (const [key, value] of Object.entries(data)) {
            this.setFieldValue(key, value);
        }
    }

    buildQueryParams() {
        const formData = this.getFormData();
        console.log('FormData:', formData); // Depuração: exibe os dados do formulário
        
        const params = new URLSearchParams();
    
        // Normaliza os campos-chave para minúsculas
        const lowerCaseKeyFields = this.keyFields.map(field => field.toLowerCase());
        console.log('lowerCaseKeyFields:', lowerCaseKeyFields); // Depuração: exibe os campos-chave em minúsculas
    
        // Adiciona os campos-chave à query string
        params.append('KeyFields', this.keyFields.join(';'));
    
        // Adiciona os valores dos campos-chave à query string
        const keyValues = lowerCaseKeyFields.map(lowerCaseField => {
            // Encontra o campo correspondente no formData, comparando em minúsculas
            const matchingField = Object.keys(formData).find(key => key.toLowerCase() === lowerCaseField);
    
            if (matchingField) {
                console.log(`Campo correspondente encontrado: ${matchingField} -> Valor: ${formData[matchingField]}`);
                // Retorna o valor do campo correspondente (mantém a referência correta ao valor original)
                return formData[matchingField] || '';
            } else {
                console.warn(`Campo correspondente não encontrado para: ${lowerCaseField}`);
                return '';  // Se o campo não for encontrado, retorna string vazia
            }
        }).join(';');
    
        // Depuração: mostra os valores dos campos-chave que foram encontrados
        console.log('keyValues:', keyValues);
    
        if (keyValues.trim() === '') {
            console.warn('Atenção: Valores de campos-chave estão vazios.');
        }
    
        params.append('KeyValues', keyValues);
        params.append('Options', this.options);
    
        // Depuração: mostra a string completa da query
        console.log('QueryParams:', params.toString());
    
        return params.toString();
    }    
    
    async sendRequest(action, queryParams, jsonData, method) {
        let url = `http://192.168.15.2:8080/Tmi_rtl_web_module/${action}`;
    
        // Adiciona os parâmetros de consulta para GET, PUT e DELETE
        if (queryParams && (method === 'GET' || method === 'DELETE' || method === 'PUT')) {
            url += `?${queryParams}`;
        }
    
        const options = {
            method: method,
            headers: {
                'Content-Type': 'application/json'
            }
        };
    
        // Se o método for diferente de GET, adiciona o corpo da requisição
        if (jsonData !== null && method !== 'GET') {
            if (typeof jsonData === 'object') {
                options.body = JSON.stringify(jsonData);
            } else {
                throw new Error('jsonData deve ser um objeto.');
            }
        }
    
        try {
            const response = await fetch(url, options);
            const validStatusCodes = {
                'POST': [200, 201],
                'PUT': [200, 400],
                'PATCH': [200, 204],
                'GET': [200, 202, 404],
                'DELETE': [200, 204]
            };
    
            if (!validStatusCodes[method].includes(response.status)) {
                throw new Error(`Erro: Código de status HTTP ${response.status}`);
            }
    
            const responseText = await response.text();
            if (responseText.trim() === '') {
                throw new Error('Resposta vazia.');
            }
    
            let responseData;
            if (responseText.startsWith('{')) {
                responseData = JSON.parse(responseText);
            } else {
                throw new Error('Resposta não é um JSON válido.');
            }
    
            return {
                status: response.status,
                data: responseData
            };
    
        } catch (error) {
            throw new Error(`Erro: HTTP ${error.message}`);
        }
    }
    
    async newRecord() {
        try {
            const { status, data } = await this.sendRequest('CmNewRecord',null, null, 'GET');
            this.updateForm(data);
        } catch (error) {
            console.error(`Erro ao criar novo registro: ${error.message}`);
        }
    }

    async addRecord() {
        try {
            const data = this.getFormData();
            const { status, data: responseData } = await this.sendRequest('CmAddRecord',null, data, 'POST');

            if (status === 201 || status === 200) {
                if (responseData) {
                    this.updateForm(responseData);
                    console.log(`Formulário atualizado com os dados:`, responseData);
                } else {
                    alert('Registro adicionado, mas sem dados retornados.');
                }
            } else {
                alert(`Erro: ${JSON.stringify(responseData, null, 2)}`);
            }
        } catch (error) {
            console.error(`Erro ao adicionar registro: ${error.message}`);
        }
    }

    async locateRecord() {
        try {
            const queryParams = this.buildQueryParams(); // Certifique-se que este método existe
            const { status, data } = await this.sendRequest('Cmlocate', queryParams,null, 'GET');
            if (status === 200 && data) {
                this.updateForm(data);
            } else {
                alert('Registro não encontrado.');
            }
        } catch (error) {
            console.error(`Erro ao localizar registro: ${error.message}`);
        }
    }
     
    async updateRecord() {
        try {
            const data = this.getFormData();
            const queryParams = this.buildQueryParams(); // Certifique-se que este método existe            
            const { status, data: responseData } = await this.sendRequest('CmPutRecord',queryParams, data, 'PUT');

            if (status === 200) {
                this.updateForm(responseData);
            } else {
                alert('Erro ao atualizar registro.');
            }
        } catch (error) {
            console.error(`Erro ao atualizar registro: ${error.message}`);
        }
    }

    async deleteRecord() {
        try {
            // Supondo que você tenha uma função para construir os parâmetros da query
            const queryParams = this.buildQueryParams(); // Constrói a query string com os parâmetros necessários
    
            const { status } = await this.sendRequest('CmDeleteRecord', queryParams, null, 'DELETE');
                
            if (status === 200 || status === 204) {
                alert('Registro excluído com sucesso.');
                this.clearForm(); // Limpa o formulário após a exclusão
            } else {
                alert('Erro ao excluir registro.');
            }
        } catch (error) {
            console.error(`Erro ao excluir registro: ${error.message}`);
        }
    }
    

    async goBof() {
        try {
            const { status, data } = await this.sendRequest('CmGoBof',null, null, 'GET');
            if (status === 200) {
                this.updateForm(data);
            } else {
                alert(`Erro ao ir para o primeiro registro: ${data.message}`);
            }
        } catch (error) {
            console.error(`Erro ao ir para o primeiro registro: ${error.message}`);
        }
    }

    async nextRecord() {
        try {
            const queryParams = this.buildQueryParams(); // Garante que os parâmetros da chave atual sejam construídos
            const { status, data } = await this.sendRequest('CmNextRecord', queryParams,null, 'GET');
            if (status === 200 && data) {
                this.updateForm(data);
            } else {
                alert(`Erro ao obter próximo registro: ${data.message}`);
            }
        } catch (error) {
            console.error(`Erro ao obter próximo registro: ${error.message}`);
        }
    }
    
    async prevRecord() {
        try {
            const queryParams = this.buildQueryParams(); // Garante que os parâmetros da chave atual sejam construídos
            const { status, data } = await this.sendRequest('CmPrevRecord', queryParams,null, 'GET');
            if (status === 200 && data) {
                this.updateForm(data);
            } else {
                alert(`Erro ao obter registro anterior: ${data.message}`);
            }
        } catch (error) {
            console.error(`Erro ao obter registro anterior: ${error.message}`);
        }
    }
    

    async goEof() {
        try {
            const { status, data } = await this.sendRequest('CmGoEof', null,null, 'GET');
            if (status === 200) {
                this.updateForm(data);
            } else {
                alert(`Erro ao ir para o último registro: ${data.message}`);
            }
        } catch (error) {
            console.error(`Erro ao ir para o último registro: ${error.message}`);
        }
    }

}
