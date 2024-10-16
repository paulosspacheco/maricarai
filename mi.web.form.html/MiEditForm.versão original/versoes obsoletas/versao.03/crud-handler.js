class CRUDHandler {
    constructor(formId, keyField) {
        this.formId = formId;
        this.keyField = keyField;
    }

    buildQueryParams(keyFields, record) {
        const fields = keyFields.split(',').map(field => field.trim());
        const values = fields.map(field => record[field] || '');

        if (!fields.length || values.some(value => value === '')) {
            throw new Error('Os campos-chave e seus valores devem ser preenchidos.');
        }

        return new URLSearchParams({
            KeyFields: fields.join(','),
            KeyValues: values.join(',')
        }).toString();
    }

    async sendRequest(action, queryParams, jsonObject, method) {
        let url = `http://192.168.15.2:8080/Tmi_rtl_web_module/${action}`;

        if (queryParams && (method === 'GET' || method === 'DELETE' || method === 'PUT')) {
            url += `?${queryParams}`;
        }

        let options = {
            method: method,
            headers: {}
        };

        if (jsonObject) {
            options.headers['Content-Type'] = 'application/json';
            options.body = JSON.stringify(jsonObject);
        }

        try {
            const response = await fetch(url, options);
            const validStatusCodes = {
                'POST': [200, 201],
                'PUT': [200, 400],
                'GET': [200, 202, 404],
                'DELETE': [200, 204]
            };

            if (!validStatusCodes[method].includes(response.status)) {
                throw new Error(`Erro: Código de status HTTP ${response.status}`);
            }

            const responseStr = await response.text();
            if (!responseStr.trim()) {
                throw new Error('Resposta vazia.');
            }

            if (responseStr.startsWith('{')) {
                return JSON.parse(responseStr);
            } else {
                throw new Error('Resposta não é um JSON válido.');
            }

        } catch (error) {
            document.getElementById('result').textContent = `Erro ao enviar requisição: ${error.message}`;
        }
    }

    // Método para criar um novo registro
    async newRecord() {
        try {
            // Faz a requisição para criar um novo registro
            const result = await this.sendRequest('CmNewRecord', '', null, 'GET');
            
            // Adiciona logs para depuração
            console.log('Resposta bruta do servidor:', result);
    
            // Verifica se a resposta é um objeto e se contém os campos esperados
            if (result && typeof result === 'object') {
                const { id, nome, endereco } = result;
    
                // Verifica se os campos estão presentes na resposta
                if (id !== undefined && nome !== undefined && endereco !== undefined) {
                    // Preenche os campos do formulário
                    document.getElementById(`${this.formId}-id`).value = id || '0'; // Preenche com "0" caso esteja vazio
                    document.getElementById(`${this.formId}-name`).value = nome || 'Qual o nome?';
                    document.getElementById(`${this.formId}-endereco`).value = endereco || '';
    
                    // Exibe o resultado no campo de texto
                    document.getElementById('result').textContent = JSON.stringify(result, null, 2);
                } else {
                    throw new Error('Campos esperados não foram encontrados na resposta do servidor.');
                }
            } else {
                throw new Error('Resposta não é um objeto ou não contém dados.');
            }
        } catch (error) {
            // Mostra o erro no campo de resultado
            document.getElementById('result').textContent = `Erro ao criar novo registro: ${error.message}`;
        }
    }
    
    
    
    // async newRecord() {
    //     try {
    //         const result = await this.sendRequest('CmNewRecord', {}, null, 'POST');
    //         document.getElementById('result').textContent = JSON.stringify(result, null, 2);
    //     } catch (error) {
    //         document.getElementById('result').textContent = `Erro ao criar novo registro: ${error.message}`;
    //     }
    // }


    async addRecord() {
        try {
            const record = {
                id: document.getElementById(`${this.formId}-id`).value,
                nome: document.getElementById(`${this.formId}-name`).value,
                endereco: document.getElementById(`${this.formId}-endereco`).value
            };

            const result = await this.sendRequest('CmAddRecord', '', record, 'POST');
            document.getElementById('result').textContent = JSON.stringify(result, null, 2);
        } catch (error) {
            document.getElementById('result').textContent = `Erro ao adicionar registro: ${error.message}`;
        }
    }

    async updateRecord() {
        try {
            const record = {
                id: document.getElementById(`${this.formId}-id`).value,
                nome: document.getElementById(`${this.formId}-name`).value,
                endereco: document.getElementById(`${this.formId}-endereco`).value
            };

            const queryParams = this.buildQueryParams('id', record);
            const result = await this.sendRequest('CmPutRecord', queryParams, record, 'PUT');
            document.getElementById('result').textContent = JSON.stringify(result, null, 2);
        } catch (error) {
            document.getElementById('result').textContent = `Erro ao atualizar registro: ${error.message}`;
        }
    }

    async deleteRecord() {
        try {
            const record = {
                id: document.getElementById(`${this.formId}-id`).value
            };

            const queryParams = this.buildQueryParams('id', record);
            const result = await this.sendRequest('CmDeleteRecord', queryParams, null, 'DELETE');
            document.getElementById('result').textContent = JSON.stringify(result, null, 2);
        } catch (error) {
            document.getElementById('result').textContent = `Erro ao deletar registro: ${error.message}`;
        }
    }

    async locateRecord() {
        try {
            const record = {
                id: document.getElementById(`${this.formId}-id`).value
            };

            const queryParams = this.buildQueryParams('id', record);
            const result = await this.sendRequest('Cmlocate', queryParams, null, 'GET');
            document.getElementById('result').textContent = JSON.stringify(result, null, 2);
        } catch (error) {
            document.getElementById('result').textContent = `Erro ao localizar registro: ${error.message}`;
        }
    }
}
