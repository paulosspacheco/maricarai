class CRUDHandler {
    constructor(formId, keyField) {
        this.form = document.getElementById(formId);
        if (!this.form) {
            throw new Error(`Formulário com ID ${formId} não encontrado.`);
        }
        this.keyField = keyField;
        this.resultElement = document.getElementById('result');
    }

    // Função para construir a query string
    buildQueryParams(keyFields, record) {
        const fields = keyFields.split(',').map(field => field.trim());
        const values = fields.map(field => record[field] || '');

        if (!fields.length || values.some(value => value === '')) {
            throw new Error('Os campos-chave e seus valores devem ser preenchidos.');
        }

        const queryParams = new URLSearchParams({
            KeyFields: fields.join(','),
            KeyValues: values.join(',')
        }).toString();

        return queryParams;
    }

    // Função para fazer requisições HTTP
    async sendRequest(action, queryParams, jsonObject, method) {
        let url = `http://192.168.15.2:8080/Tmi_rtl_web_module/${action}`;
        if (queryParams && (method === 'GET' || method === 'DELETE' || method === 'PUT')) {
            url += `?${queryParams}`;
        }

        const options = {
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
                'PATCH': [200, 204],
                'GET': [200, 202, 404],
                'DELETE': [200, 204]
            };

            if (!validStatusCodes[method].includes(response.status)) {
                throw new Error(`Erro: Código de status HTTP ${response.status}`);
            }

            const responseStr = await response.text();
            if (responseStr.trim() === '') {
                throw new Error('Resposta vazia.');
            }

            if (responseStr.startsWith('{')) {
                return JSON.parse(responseStr);
            } else {
                throw new Error('Resposta não é um JSON válido.');
            }

        } catch (error) {
            throw new Error(`Erro: HTTP ${error.message}`);
        }
    }

    // Função para criar novo registro
    async newRecord() {
        try {
            const result = await this.sendRequest('CmNewRecord', '', null, 'GET');

            // Preenche o formulário com os dados recebidos
            if (this.resultElement) {
                this.resultElement.textContent = JSON.stringify(result, null, 2);
            }

            for (const [key, value] of Object.entries(result)) {
                const input = this.form.querySelector(`[name=${key}]`);
                if (input) {
                    input.value = value;
                }
            }

        } catch (error) {
            if (this.resultElement) {
                this.resultElement.textContent = `Erro ao criar novo registro: ${error.message}`;
            }
        }
    }

    // Função para adicionar registro
    async addRecord() {
        const formData = new FormData(this.form);
        const record = {};
        formData.forEach((value, key) => {
            record[key] = value;
        });

        try {
            const result = await this.sendRequest('CmAddRecord', '', record, 'POST');
            if (this.resultElement) {
                this.resultElement.textContent = `Registro adicionado: ${JSON.stringify(result, null, 2)}`;
            }
        } catch (error) {
            if (this.resultElement) {
                this.resultElement.textContent = `Erro ao adicionar registro: ${error.message}`;
            }
        }
    }

    // Função para atualizar registro
    async updateRecord() {
        const formData = new FormData(this.form);
        const record = {};
        formData.forEach((value, key) => {
            record[key] = value;
        });

        const keys = this.buildQueryParams(this.keyField, record);

        try {
            const result = await this.sendRequest('CmPutRecord', keys, record, 'PUT');
            if (this.resultElement) {
                this.resultElement.textContent = `Registro atualizado: ${JSON.stringify(result, null, 2)}`;
            }
        } catch (error) {
            if (this.resultElement) {
                this.resultElement.textContent = `Erro ao atualizar registro: ${error.message}`;
            }
        }
    }

    // Função para localizar registro
    async locateRecord() {
        const record = {};
        const keyInput = this.form.querySelector(`[name=${this.keyField}]`);
        if (!keyInput) {
            throw new Error(`Campo chave "${this.keyField}" não encontrado no formulário.`);
        }
        record[this.keyField] = keyInput.value;

        if (!record[this.keyField]) {
            throw new Error(`O campo chave "${this.keyField}" não pode estar vazio.`);
        }

        const queryParams = this.buildQueryParams(this.keyField, record);

        try {
            const result = await this.sendRequest('Cmlocate', queryParams, null, 'GET');

            if (this.resultElement) {
                this.resultElement.textContent = JSON.stringify(result, null, 2);
            }

            for (const [key, value] of Object.entries(result)) {
                const input = this.form.querySelector(`[name=${key}]`);
                if (input) {
                    input.value = value;
                }
            }

        } catch (error) {
            if (this.resultElement) {
                this.resultElement.textContent = `Erro ao localizar registro: ${error.message}`;
            }
        }
    }

    // Função para deletar registro
    async deleteRecord() {
        const keyInput = this.form.querySelector(`[name=${this.keyField}]`);
        if (!keyInput || !keyInput.value) {
            throw new Error(`O campo chave "${this.keyField}" deve estar preenchido para deletar um registro.`);
        }

        const record = { [this.keyField]: keyInput.value };
        const queryParams = this.buildQueryParams(this.keyField, record);

        try {
            const result = await this.sendRequest('CmDeleteRecord', queryParams, null, 'DELETE');

            if (this.resultElement) {
                this.resultElement.textContent = `Registro deletado: ${JSON.stringify(result, null, 2)}`;
            }

            // Limpa o formulário após exclusão
            this.form.reset();

        } catch (error) {
            if (this.resultElement) {
                this.resultElement.textContent = `Erro ao deletar registro: ${error.message}`;
            }
        }
    }
}
