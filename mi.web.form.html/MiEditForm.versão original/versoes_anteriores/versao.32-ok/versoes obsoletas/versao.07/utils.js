// utils.js

function buildQueryParams(keyField, record) {
    if (!keyField || !record || !record[keyField]) {
        throw new Error('Chave ou registro inválidos para construção de parâmetros de consulta.');
    }

    let queryParams = [];
    for (const [key, value] of Object.entries(record)) {
        if (key !== keyField && value) {
            queryParams.push(`${encodeURIComponent(key)}=${encodeURIComponent(value)}`);
        }
    }

    return queryParams.join('&');
}


// utils.js

// function buildQueryParams(keyFields, record) {
//     // Divide os campos-chave por vírgula e remove espaços em branco
//     const fields = keyFields.split(',').map(field => field.trim());

//     // Cria uma lista de valores para cada campo-chave
//     const values = fields.map(field => record[field] || '');

//     // Verifica se KeyFields e KeyValues não estão vazios
//     if (!fields.length || values.some(value => value === '')) {
//         throw new Error('Os campos-chave e seus valores devem ser preenchidos.');
//     }

//     // Constrói a query string com os campos-chave e valores
//     const queryParams = new URLSearchParams({
//         KeyFields: fields.join(','),
//         KeyValues: values.join(',')
//     }).toString();

//     return queryParams;
// }
