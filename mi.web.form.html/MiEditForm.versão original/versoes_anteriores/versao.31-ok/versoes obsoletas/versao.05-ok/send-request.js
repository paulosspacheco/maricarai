// send-request.js
async function sendRequest(action, queryParams, jsonObject, method) {
    let url = `http://192.168.15.2:8080/Tmi_rtl_web_module/${action}`;

    // Adiciona parâmetros de consulta para GET, PUT e DELETE
    if (queryParams && (method === 'GET' || method === 'DELETE' || method === 'PUT')) {
        url += `?${queryParams}`;
    }

    // Configura o corpo da requisição se necessário
    const options = {
        method: method,
        headers: {}
    };

    if (jsonObject) {
        options.headers['Content-Type'] = 'application/json';
        options.body = JSON.stringify(jsonObject);
    }

    // Realiza a requisição HTTP
    try {
        const response = await fetch(url, options);

        // Verifica se a resposta está dentro dos códigos de sucesso esperados
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

        // Processa a resposta
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
