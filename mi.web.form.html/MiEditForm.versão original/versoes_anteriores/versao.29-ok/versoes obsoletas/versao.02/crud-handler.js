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
