class CRUDHandler {
    constructor(formId, keyFields) {
        this.form = document.getElementById(formId);
        if (!this.form) {
            throw new Error(`Formulário com ID ${formId} não encontrado.`);
        }

        // Chama a função para normalizar os IDs e nomes dos campos do formulário
        this.normalizeFormIdsAndNames();

        // Armazena os campos-chave separados por ponto e vírgula
        this.keyFields = keyFields.split(';');
        // Define opções fixas
        this.options = 'loCaseInsensitive,loPartialKey';
    }

    normalizeFormIdsAndNames() {
        const formFields = this.form.querySelectorAll('input, textarea, select');

        formFields.forEach(field => {
            if (field.id) {
                // Converte o id para minúsculas
                field.id = field.id.toLowerCase();
            }

            if (field.name) {
                // Converte o name para minúsculas
                field.name = field.name.toLowerCase();
            }

            // Atualiza o atributo 'for' dos rótulos correspondentes, se houver
            const label = this.form.querySelector(`label[for="${field.id}"]`);
            if (label) {
                label.setAttribute('for', field.id);
            }
        });
    }

    getFormData() {
        const formData = new FormData(this.form);
        const data = {};

        // Normaliza os nomes dos campos para minúsculas
        formData.forEach((value, key) => {
            data[key.toLowerCase()] = value; // Armazena o nome do campo em minúsculas
        });

        return data;
    }

    getFieldValue(fieldName) {
        const field = document.getElementById(fieldName.toLowerCase()); // Acessa pelo ID minúsculo
        if (field) {
            return field.value;
        } else {
            throw new Error(`Campo ${fieldName} não encontrado.`);
        }
    }

    setFieldValue(fieldName, value) {
        const field = document.getElementById(fieldName.toLowerCase()); // Acessa pelo ID minúsculo
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

    async sendRequest(action, jsonData, method) {
        let url = `http://192.168.15.2:8080/Tmi_rtl_web_module/${action}`;

        // Adiciona parâmetros de consulta se existirem e o método for GET, DELETE ou PUT
        const queryParams = this.buildQueryParams();
        if (queryParams && (method === 'GET' || method === 'DELETE' || method === 'PUT')) {
            url += `?${queryParams}`;
        }

        const options = {
            method: method,
            headers: {
                'Content-Type': 'application/json'
            }
        };

        if (jsonData) {
            options.body = JSON.stringify(jsonData);
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
            const { status, data } = await this.sendRequest('CmNewRecord', null, 'GET');
            this.updateForm(data);
        } catch (error) {
            console.error(`Erro ao criar novo registro: ${error.message}`);
        }
    }

    async addRecord() {
        try {
            const data = this.getFormData();
            const { status, data: responseData } = await this.sendRequest('CmAddRecord', data, 'POST');

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

    async updateRecord() {
        try {
            const data = this.getFormData();
            const { status, data: responseData } = await this.sendRequest('CmPutRecord', data, 'PUT');

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
            const { status, data } = await this.sendRequest('CmDeleteRecord', null, 'DELETE');
            if (status === 200) {
                this.updateForm({});
            } else {
                alert('Erro ao deletar registro.');
            }
        } catch (error) {
            console.error(`Erro ao deletar registro: ${error.message}`);
        }
    }

    async locateRecord() {
        try {
            const { status, data } = await this.sendRequest('Cmlocate', null, 'GET');
            if (status === 200) {
                this.updateForm(data);
            } else {
                alert('Erro ao localizar o registro.');
            }
        } catch (error) {
            console.error(`Erro ao localizar registro: ${error.message}`);
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
}
