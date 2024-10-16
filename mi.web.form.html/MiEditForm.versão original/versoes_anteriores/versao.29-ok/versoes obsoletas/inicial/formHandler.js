// formHandler.js

async function sendRequest(aAction, aParams, aJSONObject, aMethod) {
    let responseStr = '';
    let url = `http://192.168.15.2:8080/Tmi_rtl_web_module/${aAction}`;

    // Configurar o corpo da requisição
    let options = {
        method: aMethod.startsWith('Cm') ? 'POST' : aMethod,
        headers: {}
    };

    if (aJSONObject) {
        options.headers['Content-Type'] = 'application/json';
        options.body = JSON.stringify(aJSONObject);
    }

    try {
        const response = await fetch(url, options);
        
        if (!response.ok) {
            throw new Error(`Erro: Código de status HTTP ${response.status}`);
        }

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

async function createNewRecord() {
    try {
        const result = await sendRequest('CmNewRecord', {}, null, 'POST');
        document.getElementById('result').textContent = JSON.stringify(result, null, 2);
    } catch (error) {
        document.getElementById('result').textContent = `Erro ao criar novo registro: ${error.message}`;
    }
}

async function addRecord() {
    const name = document.getElementById('nameField').value;
    try {
        const result = await sendRequest('CmAddRecord', {}, { nome: name }, 'POST');
        document.getElementById('result').textContent = JSON.stringify(result, null, 2);
    } catch (error) {
        document.getElementById('result').textContent = `Erro ao adicionar registro: ${error.message}`;
    }
}

async function locateRecord() {
    const id = document.getElementById('idField').value;
    const keyFields = 'id';  // Definindo o campo da chave

    try {
        // Construindo a URL com os parâmetros da chave na query string
        const queryParams = new URLSearchParams({
            KeyFields: keyFields,
            KeyValues: id
        }).toString();

        const result = await sendRequest('Cmlocate?' + queryParams, {}, null, 'GET');
        document.getElementById('result').textContent = JSON.stringify(result, null, 2);
    } catch (error) {
        document.getElementById('result').textContent = `Erro ao localizar registro: ${error.message}`;
    }
}


async function updateRecord() {
    const id = document.getElementById('idField').value;  // ID do registro para atualizar
    const name = document.getElementById('nameField').value;  // Nome a ser atualizado
    const keyFields = 'id';  // Campo da chave

    try {
        // Construindo a query string com os parâmetros de chave
        const queryParams = new URLSearchParams({
            KeyFields: keyFields,
            KeyValues: id
        }).toString();

        // Corpo da requisição com os dados a serem atualizados
        const dataToUpdate = { nome: name };

        // Chamando sendRequest com a URL contendo a query string e os dados no corpo
        const result = await sendRequest('CmPutRecord?' + queryParams, {}, dataToUpdate, 'PUT');
        document.getElementById('result').textContent = JSON.stringify(result, null, 2);
    } catch (error) {
        document.getElementById('result').textContent = `Erro ao atualizar registro: ${error.message}`;
    }
}


async function deleteRecord() {
    const id = document.getElementById('idField').value;  // ID do registro a ser excluído
    const keyFields = 'id';  // Campo da chave

    try {
        // Construindo a query string com os parâmetros de chave
        const queryParams = new URLSearchParams({
            KeyFields: keyFields,
            KeyValues: id
        }).toString();

        // Chamando sendRequest com a URL contendo a query string e sem corpo
        const result = await sendRequest('CmDeleteRecord?' + queryParams, {}, null, 'DELETE');
        document.getElementById('result').textContent = JSON.stringify(result, null, 2);
    } catch (error) {
        document.getElementById('result').textContent = `Erro ao excluir registro: ${error.message}`;
    }
}

