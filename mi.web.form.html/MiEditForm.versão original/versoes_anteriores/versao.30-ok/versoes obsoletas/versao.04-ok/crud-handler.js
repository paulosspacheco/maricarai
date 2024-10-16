async function sendRequest(aAction, queryParams, aJSONObject, aMethod) {
    let responseStr = '';
    let url = `http://192.168.15.2:8080/Tmi_rtl_web_module/${aAction}`;

    // Adiciona parâmetros de consulta para GET, PUT e DELETE
    if (queryParams && (aMethod === 'GET' || aMethod === 'DELETE' || aMethod === 'PUT')) {
        url += `?${queryParams}`;
    }

    // Configurar o corpo da requisição se necessário
    let options = {
        method: aMethod,
        headers: {}
    };

    if (aJSONObject) {
        options.headers['Content-Type'] = 'application/json';
        options.body = JSON.stringify(aJSONObject);
    }

    // Realizar a requisição HTTP
    try {
        const response = await fetch(url, options);
        
        // Verificar se a resposta está dentro dos códigos de sucesso esperados
        const validStatusCodes = {
            'POST': [200, 201],
            'PUT': [200, 400],
            'PATCH': [200, 204],
            'GET': [200, 202, 404],
            'DELETE': [200, 204]
        };

        if (!validStatusCodes[aMethod].includes(response.status)) {
            throw new Error(`Erro: Código de status HTTP ${response.status}`);
        }

        // Processar a resposta
        responseStr = await response.text();
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

class CRUDHandler {
    constructor(formId, keyField) {
        this.form = document.getElementById(formId);
        this.keyField = keyField;
    }

    // Método para coletar os dados do formulário
    getFormData() {
        const formData = new FormData(this.form);
        const data = {};
        formData.forEach((value, key) => {
            data[key] = value;
        });
        return data;
    }

    // Método para preencher o formulário com os dados retornados
    fillFormData(record) {
        for (const key in record) {
            if (this.form.elements[key]) {
                this.form.elements[key].value = record[key];
            }
        }
    }

    // Método para criar um novo registro (GET)
    async newRecord() {
        try {
            const result = await sendRequest('CmNewRecord', null, null, 'GET'); // Usa o método GET
            if (result && result.hasOwnProperty(this.keyField)) {
                this.fillFormData(result); // Preenche o formulário com os dados do servidor
                console.log('Novo registro carregado:', result);
            } else {
                throw new Error('Resposta inválida ou não contém os campos esperados.');
            }
        } catch (error) {
            document.getElementById('result').textContent = `Erro ao criar novo registro: ${error.message}`;
        }
    }

    // Método para adicionar um novo registro (POST)
    async addRecord() {
        const data = this.getFormData();
        try {
            const result = await sendRequest('CmAddRecord', null, data, 'POST');
            console.log('Registro adicionado:', result);
        } catch (error) {
            document.getElementById('result').textContent = `Erro ao adicionar registro: ${error.message}`;
        }
    }

    // Método para localizar um registro (GET)
    async locateRecord() {
        const data = this.getFormData();
        const queryParams = buildQueryParams(this.keyField, data);
        try {
            const result = await sendRequest('Cmlocate', queryParams, null, 'GET');
            this.fillFormData(result);
            console.log('Registro localizado:', result);
        } catch (error) {
            document.getElementById('result').textContent = `Erro ao localizar registro: ${error.message}`;
        }
    }

    // Método para atualizar um registro (PUT)
    async updateRecord() {
        const data = this.getFormData();
        const queryParams = buildQueryParams(this.keyField, data);
        try {
            const result = await sendRequest('CmPutRecord', queryParams, data, 'PUT');
            console.log('Registro atualizado:', result);
        } catch (error) {
            document.getElementById('result').textContent = `Erro ao atualizar registro: ${error.message}`;
        }
    }

    // Método para deletar um registro (DELETE)
    async deleteRecord() {
        const data = this.getFormData();
        const queryParams = buildQueryParams(this.keyField, data);
        try {
            const result = await sendRequest('CmDeleteRecord', queryParams, null, 'DELETE');
            console.log('Registro deletado:', result);
        } catch (error) {
            document.getElementById('result').textContent = `Erro ao deletar registro: ${error.message}`;
        }
    }
}
