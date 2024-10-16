// formHandler.js

async function sendRequest(aAction, queryParams, aJSONObject, aMethod) {
    let responseStr = '';
    let url = `http://192.168.15.2:8080/Tmi_rtl_web_module/${aAction}`;

    // Adiciona parâmetros de consulta para GET
    if (aMethod === 'GET' && queryParams) {
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

function getFieldsKeys(KeyFields, JSONObject) {
    const keyFieldsArray = KeyFields.split(','); // Divide os campos-chave
    const keyValues = [];

    // Itera sobre os campos-chave e coleta seus valores no JSONObject
    keyFieldsArray.forEach(field => {
        const value = JSONObject[field.trim()]; // Remove espaços em branco extras e acessa o valor no JSON
        if (value !== undefined && value !== '') {
            keyValues.push(value); // Adiciona o valor se estiver presente
        } else {
            throw new Error(`O campo chave "${field}" está vazio ou inválido.`);
        }
    });

    // Retorna os campos e valores encontrados
    return {
        KeyFields: KeyFields,     // Retorna os campos-chave na mesma string separada por vírgula
        KeyValues: keyValues      // Array com os valores dos campos
    };
}

function buildQueryParams(keyFields, record) {
    // Divide os campos-chave por vírgula e remove espaços em branco
    const fields = keyFields.split(',').map(field => field.trim());
    
    // Cria uma lista de valores para cada campo-chave
    const values = fields.map(field => record[field] || '');

    // Verifica se KeyFields e KeyValues não estão vazios
    if (!fields.length || values.some(value => value === '')) {
        throw new Error('Os campos-chave e seus valores devem ser preenchidos.');
    }

    // Constrói a query string com os campos-chave e valores
    const queryParams = new URLSearchParams({
        KeyFields: fields.join(','),
        KeyValues: values.join(',')
    }).toString();

    return queryParams;
}

async function locateRecord() {
    try {
        // Coletando os valores do formulário
        const record = {
            id: document.getElementById('idField').value // ID do registro
        };

        // Verifica se o valor do campo ID não está vazio
        if (!record.id) {
            throw new Error('O campo ID não pode estar vazio.');
        }

        // Construindo os parâmetros de consulta usando a função buildQueryParams
        const queryParams = buildQueryParams('id', record);

        // Valida se o JSON gerado é válido
        const isValidJSON = (json) => {
            try {
                JSON.parse(json);
                return true;
            } catch {
                return false;
            }
        };

        // Verifica se o JSON está bem formado
        if (!isValidJSON(JSON.stringify(record))) {
            throw new Error('Registro JSON inválido.');
        }

        // Faz a requisição de localização (GET)
        const result = await sendRequest('Cmlocate', queryParams, null, 'GET');

        document.getElementById('result').textContent = JSON.stringify(result, null, 2);
    } catch (error) {
        document.getElementById('result').textContent = `Erro ao localizar registro: ${error.message}`;
    }
}

async function updateRecord() {
    try {
        // Coletando os valores do formulário
        const record = {
            id: document.getElementById('idField').value,
            nome: document.getElementById('nameField').value
        };

        // Passa os campos-chave (por exemplo, "id") e o objeto JSON
        const keys = getFieldsKeys('id', record);

        // Constrói a query string com os campos-chave e valores
        const queryParams = buildQueryParams(keys.KeyFields, record);

        // Faz a requisição de atualização (PUT)
        const result = await sendRequest('CmPutRecord', queryParams, record, 'PUT');

        document.getElementById('result').textContent = JSON.stringify(result, null, 2);
    } catch (error) {
        document.getElementById('result').textContent = `Erro ao atualizar registro: ${error.message}`;
    }
}

async function putRecord() {
    try {
        // Coletando os valores do formulário
        const record = {
            id: document.getElementById('idField').value, // ID do registro
            nome: document.getElementById('nameField').value // Nome do registro
        };

        // Construindo os parâmetros de consulta
        const queryParams = buildQueryParams('id', record);

        // Faz a requisição de atualização (PUT)
        const result = await sendRequest('CmPutRecord', queryParams, record, 'PUT');

        document.getElementById('result').textContent = JSON.stringify(result, null, 2);
    } catch (error) {
        document.getElementById('result').textContent = `Erro ao atualizar registro: ${error.message}`;
    }
}

async function deleteRecord() {
    try {
        // Coletando os valores do formulário
        const record = {
            id: document.getElementById('idField').value // ID do registro
        };

        // Construindo os parâmetros de consulta
        const queryParams = buildQueryParams('id', record);

        // Faz a requisição de exclusão (DELETE)
        const result = await sendRequest('CmDeleteRecord', queryParams, null, 'DELETE');

        document.getElementById('result').textContent = JSON.stringify(result, null, 2);
    } catch (error) {
        document.getElementById('result').textContent = `Erro ao excluir registro: ${error.message}`;
    }
}
