class CRUDHandler {
    constructor(formId, keyFields) {
        this.form = document.getElementById(formId);
        if (!this.form) {
            throw new Error(`Formulário com ID ${formId} não encontrado.`);
        }
        this.keyFields = keyFields.split(';');
        this.options = 'loCaseInsensitive,loPartialKey';
        this.isDataSetActive = false; // Inicialmente não está ativo
        this.state = 0; // Representa o estado atual
        this.recordAltered = false; // Indica se o registro foi alterado
        this.appending = false; // Indica se está no modo de inserção
        this.bof = false; // Indica se é o início do conjunto de registros
        this.eof = false; // Indica se é o fim do conjunto de registros

        // Chama o método para normalizar os campos de ID e Name do formulário
        this.normalizeFormIdsAndName();
                
        // Verifica se a API está disponível
        this.checkApiAvailability();
    }

    async checkApiAvailability() {
        try {
            const { status } = await this.sendRequest('CmhealthCheck', null, 'GET');
            if (status === 200) {
                // API disponível, habilitar botões se necessário
                this.enableButtons();
                this.isDataSetActive = true; // API ativa
            } else {
                // API indisponível, desabilitar todos os botões
                this.disableAllButtons();
                this.isDataSetActive = false; // API não ativa
            }
        } catch (error) {
            console.error(`Erro ao verificar disponibilidade da API: ${error.message}`);
            this.disableAllButtons(); // Desabilita botões em caso de erro
            this.isDataSetActive = false; // API não ativa
        }
    }

    // Método para desabilitar todos os botões
    disableAllButtons() {
        const buttons = this.form.querySelectorAll('button');
        buttons.forEach(button => button.disabled = true);
    }

    // Método para habilitar os botões (substitua por sua lógica específica)
    enableButtons() {
        const buttons = this.form.querySelectorAll('button');
        buttons.forEach(button => button.disabled = false);
    }

    // Método para atualizar o estado dos comandos
    updateCommands() {
        if (this.isDataSetActive) {
            if (this.state & Mb_St_Insert) {
                this.disableCommands([]);
                if (this.recordAltered) {
                    this.enableCommands([CmUpdateRecord, CmCancel]);
                } else {
                    this.enableCommands([CmRefresh, CmLocate]);
                }
            } else if (this.state & Mb_St_Edit) {
                if ((!this.bof && !this.eof) || this.recordAltered) {
                    if (this.recordAltered) {
                        this.disableCommands([]);
                        this.enableCommands([CmUpdateRecord, CmCancel]);
                    } else {
                        this.disableCommands([]);
                        this.enableCommands([CmNewRecord, CmDeleteRecord, CmGoBof, CmNextRecord, CmPrevRecord, CmGoEof, CmLocate, CmRefresh]);

                        if (this.bof) {
                            this.disableCommands([CmGoBof]);
                        } else if (this.eof) {
                            this.disableCommands([CmGoEof]);
                        }
                    }
                } else {
                    if (!this.appending) {
                        this.enableCommands([]);
                        this.disableCommands([CmUpdateRecord, CmCancel]);
                    }

                    if (this.eof) {
                        this.disableCommands([CmNextRecord, CmGoEof]);
                    } else if (this.bof) {
                        this.disableCommands([CmPrevRecord, CmGoBof]);
                    }
                }
            } else {
                if (!this.appending && !this.recordAltered) {
                    this.enableCommands([]);
                    this.disableCommands([CmUpdateRecord, CmCancel]);
                }
            }
        }
    }

    // Métodos para habilitar e desabilitar comandos
    enableCommands(commands) {
        commands.forEach(command => {
            const button = document.getElementById(command);
            if (button) button.disabled = false;
        });
    }

    disableCommands(commands) {
        commands.forEach(command => {
            const button = document.getElementById(command);
            if (button) button.disabled = true;
        });
    }

    normalizeFormIdsAndNames() {
        const formFields = this.form.querySelectorAll('input, textarea, select');

        formFields.forEach(field => {
            if (field.id) {
                field.id = field.id.toLowerCase();
            }

            if (field.name) {
                field.name = field.name.toLowerCase();
            }

            const label = this.form.querySelector(`label[for="${field.id}"]`);
            if (label) {
                label.setAttribute('for', field.id);
            }
        });
    }

    getFormData() {
        const formData = new FormData(this.form);
        const data = {};

        formData.forEach((value, key) => {
            data[key.toLowerCase()] = value; // Armazena o nome do campo em minúsculas
        });

        return data;
    }

    getFieldValue(fieldName) {
        const field = document.getElementById(fieldName.toLowerCase());
        if (field) {
            return field.value;
        } else {
            throw new Error(`Campo ${fieldName} não encontrado.`);
        }
    }

    setFieldValue(fieldName, value) {
        const field = document.getElementById(fieldName.toLowerCase());
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
            this.setFieldValue(key, value);
        }
    }

    async sendRequest(action, jsonData, method) {
        let url = `http://192.168.15.2:8080/Tmi_rtl_web_module/${action}`;

        // Adiciona parâmetros de consulta apenas se jsonData não for null
        if (jsonData) {
            const queryParams = this.buildQueryParams();
            if (queryParams && (method === 'GET' || method === 'DELETE' || method === 'PUT')) {
                url += `?${queryParams}`;
            }
        }

        // const queryParams = this.buildQueryParams();
        // if (queryParams && (method === 'GET' || method === 'DELETE' || method === 'PUT')) {
        //     url += `?${queryParams}`;
        // }

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
            const queryParams = this.buildQueryParams();
            const { status, data } = await this.sendRequest('Cmlocate', queryParams, 'GET');
            this.updateForm(data);
        } catch (error) {
            console.error(`Erro ao localizar registro: ${error.message}`);
        }
    }

    buildQueryParams() {
        const params = new URLSearchParams();
        this.keyFields.forEach(field => {
            const value = this.getFieldValue(field);
            if (value) {
                params.append(field, value);
            }
        });
        return params.toString();
    }

}

