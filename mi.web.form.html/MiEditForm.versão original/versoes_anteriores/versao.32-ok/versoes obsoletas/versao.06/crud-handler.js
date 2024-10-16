class CRUDHandler {
    constructor(formId, keyField) {
        this.form = document.getElementById(formId);
        if (!this.form) {
            throw new Error(`Formulário com ID ${formId} não encontrado.`);
        }
        this.keyField = keyField;
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
            field.value = value;
        } else {
            throw new Error(`Campo ${fieldName} não encontrado.`);
        }
    }

    updateForm(data) {
        for (const [key, value] of Object.entries(data)) {
            this.setFieldValue(key, value);
        }
    }

    async sendRequest(action, queryParams, jsonData, method) {
        let url = `http://192.168.15.2:8080/Tmi_rtl_web_module/${action}`;
        
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

            if (responseText.startsWith('{')) {
                return JSON.parse(responseText);
            } else {
                throw new Error('Resposta não é um JSON válido.');
            }

        } catch (error) {
            throw new Error(`Erro: HTTP ${error.message}`);
        }
    }

    async newRecord() {
        try {
            const response = await this.sendRequest('CmNewRecord', null, null, 'GET');
            this.updateForm(response);
        } catch (error) {
            console.error(`Erro ao criar novo registro: ${error.message}`);
        }
    }

    async addRecord() {
        try {
            const data = this.getFormData();
            const response = await this.sendRequest('CmAddRecord', null, data, 'POST');
            this.updateForm(response);
        } catch (error) {
            console.error(`Erro ao adicionar registro: ${error.message}`);
        }
    }

    async updateRecord() {
        try {
            const data = this.getFormData();
            const response = await this.sendRequest('CmPutRecord', this.buildQueryParams(), data, 'PUT');
            this.updateForm(response);
        } catch (error) {
            console.error(`Erro ao atualizar registro: ${error.message}`);
        }
    }

    async deleteRecord() {
        try {
            const response = await this.sendRequest('CmDeleteRecord', this.buildQueryParams(), null, 'DELETE');
            this.updateForm({});
        } catch (error) {
            console.error(`Erro ao deletar registro: ${error.message}`);
        }
    }

    async locateRecord() {
        try {
            const response = await this.sendRequest('Cmlocate', this.buildQueryParams(), null, 'GET');
            this.updateForm(response);
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
        /*  ## Método `buildQueryParams`
            ### Descrição
            O método `buildQueryParams` gera uma string de parâmetros de consulta (query string) a 
            partir dos dados de um formulário HTML. Ele coleta os valores do formulário, organiza-os 
            em pares `key=value` e retorna a string de parâmetros no formato esperado para ser 
            anexada a uma URL.
        
            ### Fluxo de Execução
            
            1. O método chama `getFormData()` para obter os dados do formulário, que são retornados 
               como um objeto chave-valor onde as chaves são os nomes dos campos do formulário e 
               os valores são os dados inseridos pelos usuários.
            2. Em seguida, cria uma instância de `URLSearchParams` para construir os parâmetros da 
               URL.
            3. O método percorre cada par chave-valor do objeto `formData` usando um loop `for in` 
               e verifica se a propriedade realmente pertence ao objeto (`hasOwnProperty`).
            4. Para cada chave, o método adiciona o par `key=value` aos parâmetros da URL usando o 
               método `append` de `URLSearchParams`.
            5. Finalmente, a string dos parâmetros de consulta é retornada usando `params.toString()`.
            
            ### Exemplo de Uso
            
            ```javascript
            const queryString = buildQueryParams();
            // Saída: 'nome=Joao&email=joao%40example.com'
        */ 

        const formData = this.getFormData();
        const params = new URLSearchParams();
        for (const key in formData) {
            if (formData.hasOwnProperty(key)) {
                params.append(key, formData[key]);
            }
        }
        return params.toString();
    }
}
