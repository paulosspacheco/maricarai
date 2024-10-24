class CRUDHandler {
    constructor(formId, keyFields) {
        this.form = document.getElementById(formId);
        if (!this.form) {
            throw new Error(`Formulário com ID ${formId} não encontrado.`);
        }
        this.keyFields = keyFields.split(';');
        this.options = 'loCaseInsensitive,loPartialKey';
    }

    getFieldValue(fieldName) {
        const field = document.getElementById(fieldName);
        if (field) {
            return field.value;
        } else {
            throw new Error(`Campo ${fieldName} não encontrado.`);
        }
    }

    setFieldValue(fieldName, value) {
        const field = document.getElementById(fieldName);
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
            const normalizedKey = key.toLowerCase();
            const matchingField = this.keyFields.find(field => field.toLowerCase() === normalizedKey);
            if (matchingField) {
                this.setFieldValue(matchingField, value);
            }
        }
    }
    
    async sendRequest(action, jsonData, method) {
        let url = `http://192.168.15.2:8080/Tmi_rtl_web_module/${action}`;
        
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

    getFormData() {
        const formData = new FormData(this.form);
        const data = {};
        formData.forEach((value, key) => {
            data[key] = value;
        });
        return data;
    }

    buildQueryParams() {
        const formData = this.getFormData();
        const params = new URLSearchParams();
        
        params.append('KeyFields', this.keyFields.join(';'));
        const keyValues = this.keyFields.map(field => formData[field] || '').join(';');
        params.append('KeyValues', keyValues);
        params.append('Options', this.options);

        return params.toString();
    }
}
