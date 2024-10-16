import { MiConsts } from './mi_consts.js';
import { Alert } from './alert.js';
import { InputBox } from './jsonInputBox.js';
import { showMessage } from './alert.js';
import { messageBox} from './alert.js';

class Action {
    constructor(name) {
        this.name = name;
        this.enabled = true; // ou qualquer outro valor padrão
    }
}

export class MiEditForm extends MiConsts {

    constructor(formId, keyFields) {
        super(); // Chama o construtor da classe pai

        // Inicializa o formulário
        this.form = document.getElementById(formId);
        if (!this.form) {
            throw new Error(`Formulário com ID ${formId} não encontrado.`);
        }
        this.keyFields = keyFields.split(';');
        this.options = 'loCaseInsensitive,loPartialKey';

        // Normaliza os campos de ID e Name do formulário
        try {
            this.normalizeFormIdsAndNames();
        } catch (error) {
            this.showMessage('Erro ao normalizar campos de formulário:', error);
        }
                

        // Mapeamento de ações
        this.actionList = {
            CmHealthCheck: new Action('CmHealthCheck'),
            CmNewRecord: new Action('CmNewRecord'),  // Carrega um novo registro em branco
            CmAddRecord: new Action('CmAddRecord'),  // Adiciona o registro carregado
            CmPutRecord: new Action('CmPutRecord'),
            CmLocate: new Action('CmLocate'),
            CmDeleteRecord: new Action('CmDeleteRecord'),
            CmGoBof: new Action('CmGoBof'),
            CmNextRecord: new Action('CmNextRecord'),
            CmPrevRecord: new Action('CmPrevRecord'),
            CmGoEof: new Action('CmGoEof'),
            CmCancel: new Action('CmCancel'),
            CmRefresh: new Action('CmRefresh'),                        
        };

        this.initInputListeners() ;
        this.initEventListeners();        
        this.init();
    }    
    
    init(){
        // Inicializa propriedades
        this.active = false;        
        
        this.isDataSetActive = false; // Inicialmente não está ativo        
        this.recordAltered = false; // Indica se o registro foi alterado
        this.appending = false; // Indica se está no modo de inserção
        this.bof = false; // Indica se é o início do conjunto de registros
        this.eof = false; // Indica se é o fim do conjunto de registros
               
        this.workingData = null; // Buffer corrente
        this.wWorkingData = null; // Cópia dos dados atuais
        this.workingDataOld = null; // Buffer anterior        
        this.wWorkingDataOld = null; // Cópia dos dados antigos

        this.reintranceChangeMadeOnOff = false; // Controle de reentrância
        this.recordAltered = false; // Verifica se o registro foi alterado
        this.keyAltered = false; // Estado do botão ou chave alterada        
        
        this.setState(MiConsts.Mb_St_Insert, false);
        this.setState(MiConsts.Mb_St_Edit, false);                                            
        
        // Verifica se a API está disponível
        try {
            this.checkApiAvailability();
        } catch (error) {
            this.showMessage('Erro ao verificar disponibilidade da API:', error);
        }        
        this.updateCommands();

    }

    clearForm() {
        const formFields = this.form.querySelectorAll('input, textarea, select');
        formFields.forEach(field => field.value = '');
    }

    // Método para redesenhar a interface
    redraw() {
        // Atualiza o estado de todos os botões presentes em actionList
        for (const actionName in this.actionList) {
            const action = this.actionList[actionName];
            const button = document.getElementById(action.name);
            if (button) {
                console.log(`Atualizando botão: ${action.name} - Habilitado: ${action.enabled}`);
                button.disabled = !action.enabled; // Habilita ou desabilita o botão
            } else {
                this.showMessage(`Botão não encontrado: ${action.name}`);
            }
        }

        // Atualiza o estado de outros controles (inputs, selects, checkboxes, etc.)
        const allControls = document.querySelectorAll('input, select, textarea, button');
        allControls.forEach(control => {
            if (!this.actionList[control.id]) {  // Se o controle não estiver na actionList
                // Adicionar sua lógica aqui para habilitar/desabilitar outros controles
                console.log(`Atualizando controle: ${control.tagName} - ID: ${control.id}`);
                
                // Exemplo: Você pode definir uma regra para desabilitar todos os campos de input
                if (control.tagName === 'INPUT' || control.tagName === 'SELECT' || control.tagName === 'TEXTAREA') {
                    control.disabled = false; // Ou baseado em alguma lógica específica
                } else if (control.type === 'checkbox' || control.type === 'radio') {
                    control.disabled = false;
                }
            }
        });
    }

    async checkApiAvailability() {
        try {
            const { status } = await this.sendRequest('CmHealthCheck', null, null, 'GET');
            if (status === 200) {
                // API disponível
                this.setState(MiConsts.Mb_St_Active, true); // Habilita o estado ativo
                // this.saveWorkingData(); Neste momento pode não ter dados validos                       
            } else {
                // API indisponível
                this.setState(MiConsts.Mb_St_Active, false); // Desabilita o estado ativo
                this.showMessage(`Servidor não está disponível!`);                
            }
            //this.redraw();
        } catch (error) {
            this.showMessage(`Erro ao verificar disponibilidade da API: ${error.message}`);
            this.showMessage(`Erro ao verificar disponibilidade da API: ${error.message}`);
            this.setState(MiConsts.Mb_St_Active, false); // Desabilita o estado ativo
        }
    }
      
    // Método para definir o estado de uma ação com base no comando
    setStateAction(command, enable) {
        const action = this.actionList[command]; // Acesso direto ao objeto
        if (action) {
            action.enabled = enable; // Atualiza o estado da ação
            
            // Atrasar a atualização do botão para garantir que o DOM seja atualizado
            setTimeout(() => {
                const button = document.getElementById(command); // Encontra o botão correspondente
                if (button) {
                    button.disabled = !action.enabled; // Habilita ou desabilita o botão
                }
            }, 0);

          
        }
    }  

    enableCommands(commands) {
        if (this.actionList) {
            if (commands.length === 0) { // Habilita todos
                for (let key in this.actionList) {
                    if (this.actionList[key] instanceof Action) {
                        this.setStateAction(key,true);                                                
                    }
                }
                return;
            }
    
            // Habilita comandos específicos
            for (let command of commands) {
                if (this.actionList[command] instanceof Action) {                    
                    this.setStateAction(command,true); // Habilita comando específico                                                                                      
                }
            }
        }
    } 

    disableCommands(commands) {    
        if (this.actionList) {
            if (commands.length === 0) { // Desabilita todos
                for (let key in this.actionList) {
                    if (this.actionList[key] instanceof Action) {
                        this.setStateAction(key,false);                                                
                    }
                }
                return;
            }
    
            // Desabilita comandos específicos
            for (let command of commands) {
                if (this.actionList[command] instanceof Action) {                    
                    this.setStateAction(command,false); // Habilita comando específico                                                                                      
                }
            }
        }
    } 

    // Método para atualizar o estado dos comandos
    updateCommands() {
        this.disableCommands([]); // Desabilita todos os comandos antes de aplicar a lógica
        this.enableCommands(['CmHealthCheck']);

        if (!this.isDataSetActive) { // Se o DataSet não estiver ativo
            // Habilita apenas os botões de navegação e o botão de novo registro
            this.enableCommands(['CmNewRecord', 'CmLocate', 'CmGoBof', 'CmPrevRecord', 'CmNextRecord', 'CmGoEof']);
            return; // Sai da função já que os outros comandos não devem ser alterados
        }

        // Se o DataSet estiver ativo, segue com a lógica de inserção/edição
        if (this.state & MiConsts.Mb_St_Insert) { // Modo de inserção
            this.disableCommands(['CmLocate']); // Desabilita o botão de localizar no modo de inserção
            if (this.appending && this.recordAltered) {
                this.enableCommands(['CmAddRecord', 'CmCancel']); // Habilita o botão de adicionar apenas se appending for true
            } else {
                // this.enableCommands(['CmRefresh','CmCancel']);
                this.enableCommands([
                    'CmGoBof', 'CmNextRecord', 'CmPrevRecord', 'CmGoEof']
                );
            }
        } else if (this.state & MiConsts.Mb_St_Edit) { // Modo de edição
            if (this.recordAltered) {
                this.enableCommands(['CmPutRecord', 'CmCancel']);
            } else {
                this.enableCommands([
                    'CmNewRecord', 'CmDeleteRecord', 'CmGoBof', 
                    'CmNextRecord', 'CmPrevRecord', 'CmGoEof', 
                    'CmLocate', 'CmRefresh'
                ]);

                if (this.bof) {
                    this.disableCommands(['CmGoBof', 'CmPrevRecord']);
                }
                if (this.eof) {
                    this.disableCommands(['CmGoEof', 'CmNextRecord']);
                }
            }
        }

        // Lógica quando não está no modo insert ou edit
        if (!(this.state & MiConsts.Mb_St_Insert) || !(this.state & MiConsts.Mb_St_Edit)) {
            if (this.appending) {
                if (this.recordAltered) {                
                    this.enableCommands(['CmAddRecord', 'CmCancel']);
                }
                else {
                    this.enableCommands(['CmRefresh','CmCancel']);   
                }
            } else if (this.recordAltered) {
                this.enableCommands(['CmPutRecord', 'CmCancel']);
            } else {
                this.disableCommands(['CmPutRecord', 'CmCancel']);
                this.enableCommands(['CmNewRecord', 'CmLocate', 'CmRefresh']);
            }

            if (this.bof) {
                this.disableCommands(['CmGoBof', 'CmPrevRecord']);
            }
            if (this.eof) {
                this.disableCommands(['CmGoEof', 'CmNextRecord']);
            }
        }
    }

    // Método para normalizar IDs e nomes dos campos do formulário
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
            this.showMessage(`Campo com ID ${fieldName} não encontrado.`);
        }
    }

    updateForm(data) {
        if (!data || typeof data !== 'object') {
            this.showMessage('Dados para atualizar o formulário são nulos ou inválidos:', data);
            return;
        }

        for (const [key, value] of Object.entries(data)) {
            this.setFieldValue(key, value);
        }
    }

    buildQueryParams() {
        const formData = this.getFormData();
        console.log('FormData:', formData); // Depuração: exibe os dados do formulário
        
        const params = new URLSearchParams();
    
        // Normaliza os campos-chave para minúsculas
        const lowerCaseKeyFields = this.keyFields.map(field => field.toLowerCase());
        console.log('lowerCaseKeyFields:', lowerCaseKeyFields); // Depuração: exibe os campos-chave em minúsculas
    
        // Adiciona os campos-chave à query string
        params.append('KeyFields', this.keyFields.join(';'));
    
        // Adiciona os valores dos campos-chave à query string
        const keyValues = lowerCaseKeyFields.map(lowerCaseField => {
            // Encontra o campo correspondente no formData, comparando em minúsculas
            const matchingField = Object.keys(formData).find(key => key.toLowerCase() === lowerCaseField);
    
            if (matchingField) {
                console.log(`Campo correspondente encontrado: ${matchingField} -> Valor: ${formData[matchingField]}`);
                // Retorna o valor do campo correspondente (mantém a referência correta ao valor original)
                return formData[matchingField] || '';
            } else {
                this.showMessage(`Campo correspondente não encontrado para: ${lowerCaseField}`);
                return '';  // Se o campo não for encontrado, retorna string vazia
            }
        }).join(';');
    
        // Depuração: mostra os valores dos campos-chave que foram encontrados
        console.log('keyValues:', keyValues);
    
        if (keyValues.trim() === '') {
            this.showMessage('Atenção: Valores de campos-chave estão vazios.');
        }
    
        params.append('KeyValues', keyValues);
        params.append('Options', this.options);
    
        // Depuração: mostra a string completa da query
        console.log('QueryParams:', params.toString());
    
        return params.toString();
    }      

    async sendRequest(action, queryParams, jsonData, method) {
        let url = `http://192.168.15.2:8080/Tmi_rtl_web_module/${action}`;
    
        // Adiciona os parâmetros de consulta para GET, PUT e DELETE
        if (queryParams && (method === 'GET' || method === 'DELETE' || method === 'PUT')) {
            url += `?${queryParams}`;
        }
    
        const options = {
            method: method,
            headers: {
                'Content-Type': 'application/json'
            }
        };
    
        // Se o método for diferente de GET, adiciona o corpo da requisição
        if (jsonData !== null && method !== 'GET') {
            if (typeof jsonData === 'object') {
                options.body = JSON.stringify(jsonData);
            } else {
                throw new Error('jsonData deve ser um objeto.');
            }
        }
    
        try {
            const response = await fetch(url, options);
            const validStatusCodes = {
                'POST': [200, 201],
                'PUT': [200, 400],
                'PATCH': [200, 204],
                'GET': [200, 202, 404],
                'DELETE': [200, 204,404]
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

    // Sobrescreve o método setState, mas chama o método da classe base primeiro
    setState(AState, enable) {
        // Primeiro, chama o método setState da classe base (MiConsts)
        super.setState(AState, enable);
        
        // Habilita ou desabilita this.isDataSetActive com base no AState
        if (AState === MiConsts.Mb_St_Active) {
            this.isDataSetActive = enable; // Habilita ou desabilita
        }
    
        // Executa a lógica adicional da nova classe
        if ((this.state & MiConsts.Mb_St_Active) && 
            ((this.state & (MiConsts.Mb_St_Edit + 
                            MiConsts.Mb_St_Insert + 
                            MiConsts.Mb_St_Browse)) !== 0) && 
            this.isDataSetActive) {
            this.updateCommands();
        }
    }    

    // Sobrescreve o método getState, mas chama o método da classe base primeiro
    getState(AState) {
        // Chama o método getState da classe base (MiConsts) e retorna o resultado
        return super.getState(AState);
    }  

    // Método para fazer um clone profundo
    deepClone(obj) {
        if (obj === null || typeof obj !== 'object') {
            return obj;
        }

        if (Array.isArray(obj)) {
            return obj.map(item => this.deepClone(item)); // Clona cada item do array
        }

        if (obj instanceof Date) {
            return new Date(obj.getTime()); // Clona objeto do tipo Date
        }

        if (obj instanceof Uint8Array) {
            return new Uint8Array(obj); // Clona Uint8Array especificamente
        }

        // Clona objetos simples
        const clonedObj = {};
        for (const key in obj) {
            if (obj.hasOwnProperty(key)) {
                clonedObj[key] = this.deepClone(obj[key]); // Recursivamente clona as propriedades
            }
        }
        return clonedObj;
    }

    // Método para salvar os dados de trabalho
    saveWorkingData() {
        // Verifica se o conjunto de dados está ativo antes de proceder
        if (this.isDataSetActive) {
            // Verifica se workingData e workingDataOld são válidos
            if (this.workingData && this.workingDataOld) {
                // Cópia profunda dos dados atuais e antigos usando o método deepClone
                this.wWorkingData = this.deepClone(this.workingData); // Cópia profunda de workingData
                this.wWorkingDataOld = this.deepClone(this.workingDataOld); // Cópia profunda de workingDataOld
                
                // Reseta os estados de alteração
                this.recordAltered = false; // Indica que o registro não foi alterado
                this.keyAltered = false; // Estado do botão ou chave alterada
            } else {
                // this.showMessage('Erro: workingData ou workingDataOld não são válidos.'); // Log de erro se os dados não são válidos
                this.showMessage('Erro: workingData ou workingDataOld não são válidos.');
            }
        } else {
            // this.showMessage('Aviso: O conjunto de dados não está ativo. Nenhum dado foi salvo.'); // Aviso se o dataset não estiver ativo
            this.showMessage('Aviso: O conjunto de dados não está ativo. Nenhum dado foi salvo.');
        }
    }

    // Método para restaurar os dados de trabalho
    restoreWorkingData() {
        if (this.isDataSetActive) {
            if (this.workingData && this.wWorkingData && this.workingDataOld && this.wWorkingDataOld) {
                // Restaura os dados atuais e antigos usando cópia profunda com deepClone
                this.workingData = this.deepClone(this.wWorkingData); // Restaura os dados atuais
                this.workingDataOld = this.deepClone(this.wWorkingDataOld); // Restaura os dados antigos
                
                this.updateForm(this.workingData);

                // Reseta os estados de alteração
                this.recordAltered = false; // Indica que o registro não foi alterado
                this.keyAltered = false; // Estado do botão ou chave alterada
                if (this.appending){
                    this.setState(MiConsts.Mb_St_Insert, true);
                    this.setState(MiConsts.Mb_St_Edit, false);                                    
                }
                else{
                    this.setState(MiConsts.Mb_St_Insert, false);
                    this.setState(MiConsts.Mb_St_Edit, true);                                    
                }   
            } else {
                this.showMessage('Erro: Dados de trabalho não estão definidos corretamente.');
            }
        } else {
            this.showMessage('Aviso: O conjunto de dados não está ativo. Nenhum dado foi restaurado.');
        }
    }

    // Método para destruir os dados de trabalho
    destroyWorkingData() {
        this.wWorkingData = null; // Libera a referência
        this.wWorkingDataOld = null; // Libera a referência
    }     
    
    // Método para atualizar os dados com a resposta do servidor
    updateWorkingDataFromServer(serverData) {
        // Atualiza a interface com os dados recebidos
        this.updateForm(serverData);
        
        // Verifica se o serverData recebido é válido
        if (serverData && typeof serverData === 'object') {
            // Atualiza os dados atuais com a resposta do servidor
            this.workingData = this.deepClone(serverData); // Cópia profunda de serverData
        } else {
            this.showMessage('Erro: serverData não é um objeto válido.');
            return; // Sai da função se serverData não for válido
        }

        // Faz com que o registro atual = ao registro anterior;
        if (this.workingData && typeof this.workingData === 'object') {
            // Cópia profunda do workingData usando a função this.deepClone
            this.workingDataOld = this.deepClone(this.workingData);
        } else {
            this.showMessage('Aviso: workingData não está definido ou não é um objeto antes de fazer uma cópia.');
            this.workingDataOld = {}; // Inicializa como objeto vazio se não definido
        }

        // Verifica se workingData é válido antes de salvar
        if (this.workingData && typeof this.workingData === 'object') {
            this.saveWorkingData();
        } else {
            this.showMessage('Erro: workingData não é um objeto válido após atualização com serverData.');
        }

        // Atualiza o estado do registro e chave
        this.recordAltered = false; // Verifica se o registro foi alterado
        this.keyAltered = false; // Estado do botão ou chave alterada
        this.appending = false;
    }
    
    cancel() {
        try {
            this.restoreWorkingData();
            
        } catch (error) {
            this.showMessage(`Erro ao cancelar a operação: ${error.message}`);
        }
    }    

    async refresh() {
        try {
            this.cancel();
            if (this.appending) {
                this.init();
                this.clearForm();                
            } else {
                await this.locateRecord(); 
            }
        } catch (error) {
            this.showMessage(`Erro ao cancelar a operação: ${error.message}`);
        }
    }    

    async newRecord() {
        try {
            const { status, data } = await this.sendRequest('CmNewRecord',null, null, 'GET');          
            this.updateWorkingDataFromServer(data);            
            this.appending = true;
            this.setState(MiConsts.Mb_St_Edit,false);                         
            this.setState(MiConsts.Mb_St_Insert,true);             
        } catch (error) {
            this.showMessage(`Erro ao criar novo registro: ${error.message}`);
        }
    }

    async addRecord() {
        try {
            const data = this.getFormData();
            const { status, data: responseData } = await this.sendRequest('CmAddRecord',null, data, 'POST');

            if (status === 201 || status === 200) {
                if (responseData) {
                    this.updateForm(responseData);                                
                    this.saveWorkingData();                    
                    this.appending=false;
                    this.setState(MiConsts.Mb_St_Insert, false);
                    this.setState(MiConsts.Mb_St_Edit, true);                                    
                    this.showMessage('Registro adicionado com sucesso.');
                } else {
                    this.showMessage('Registro adicionado, mas sem dados retornados.');
                }
            } else {
                this.showMessage(`Erro: ${JSON.stringify(responseData, null, 2)}`);
            }
        } catch (error) {
            this.showMessage(`Erro ao adicionar registro: ${error.message}`);
        }
    } 

    async showMessage(type = 'mtInformation',aMsg) {
        const result = showMessage(type,aMsg);
    }

    messageBox(message, title = 'Alerta', dialogType = 'mtInformation', buttons = ['mbOK']){
        return messageBox(message, title,dialogType,buttons);  
    }
    
    // Exemplo de uso dentro da MiEditForm
    async confirmarAcao() {
        if (await this.messageBox(
            'Você deseja excluir este item?',  // Mensagem de confirmação
            'Confirmação de Exclusão',         // Título do diálogo
            'mtConfirmation',                  // Tipo de diálogo (Confirmação)
            ['mbYes', 'mbNo']                  // Botões exibidos
        ) === 'mbYes') {            
            this.showMessage('mtInformation','Botão MbYes pressionando');            
        } else {
            this.showMessage('mtInformation','Botão MbNo pressionando');
        }        
    }

    async openInputBox() {
        this.confirmarAcao(); 
        //  this.showMessage('mtWarning','Teste do showMessage ');
        //  this.showMessage('mtError','Teste do showMessage ');
        //  this.showMessage('mtInformation','Teste do showMessage ');        
        //  this.showMessage('mtConfirmation','Teste do showMessage ');        
        //  this.showMessage('mtCustom','Teste do showMessage ');        
         return;


        // Define um objeto com múltiplos campos
        let KeyIn = { ID: "", Name: "", Age: "" }; // Valor inicial para cada campo
        let KeyOut = await InputBox("Informa a chave de pesquisa:", KeyIn);

        if (KeyOut !== null) {
            console.log("Json de saída:", KeyOut); // Exibe o objeto JSON preenchido
        } else {
            console.log("Ação cancelada");
        }
    }
   

    async locateRecord() {
        try {
            this.openInputBox();
            return; 
            const queryParams = this.buildQueryParams(); // Certifique-se que este método existe
            const { status, data } = await this.sendRequest('Cmlocate', queryParams, null, 'GET');
    
            // Imprime a resposta completa do servidor para depuração
            console.log(`Status: ${status}`);
            console.log('Resposta do servidor:', data);
    
            // Verifica se a resposta foi bem-sucedida
            if (status === 200 && data) {
                // Sucesso: servidor retornou os dados do registro
                this.updateWorkingDataFromServer(data);                
                this.setState(MiConsts.Mb_St_Insert, false);
                this.setState(MiConsts.Mb_St_Edit, true);                
            } else if (status === 404) {
                // O servidor retornou erro 404 (Registro não encontrado ou validação falhou)
                console.log('Erro 404: Registro não localizado ou parâmetros inválidos.');
                if (data && data.message) {
                    this.showMessage(`Erro: ${data.message}`);
                } else {
                    this.showMessage('Registro não encontrado.');
                }
            } else {
                // Outros casos de erro
                console.log(`Erro inesperado: status ${status}`);
                this.showMessage('Erro inesperado ao localizar registro.');
            }
        } catch (error) {
            // Erro de requisição ou de rede
            this.showMessage(`Erro ao localizar registro: ${error.message}`);
        }
    }     
    
    async PutRecord() {
        try {
            const data = this.getFormData();
            const queryParams = this.buildQueryParams(); // Certifique-se que este método existe            
            const { status, data: responseData } = await this.sendRequest('CmPutRecord',queryParams, data, 'PUT');

            if (status === 200) {
                this.saveWorkingData();
                this.appending = false;
                this.setState(MiConsts.Mb_St_Insert, false);
                this.setState(MiConsts.Mb_St_Edit, true);                
                this.showMessage('Registro atualizado com sucesso.');                
            } else {
                this.showMessage('Erro ao atualizar registro.');
            }
        } catch (error) {
            this.showMessage(`Erro ao atualizar registro: ${error.message}`);
        }
    }

    async deleteRecord() {
        try {
            // Supondo que você tenha uma função para construir os parâmetros da query
            const queryParams = this.buildQueryParams(); // Constrói a query string com os parâmetros necessários
    
            // Faz a requisição DELETE
            const { status, data } = await this.sendRequest('CmDeleteRecord', queryParams, null, 'DELETE');
    
            // Verifica o status de sucesso (200 OK)
            if (status === 200) {
                if (!(await this.nextRecord())) {
                    if (!(await this.prevRecord())) {
                        await this.newRecord();  
                    }
                }
                this.showMessage('Registro excluído com sucesso.');
            } else if (status === 500) {
                // Se ocorrer um erro interno no servidor (HTTP 500)
                const errorMsg = data && data.message ? data.message : 'Erro interno ao excluir registro.';
                this.showMessage(errorMsg);
                this.showMessage(`Erro interno no servidor: ${errorMsg}`);
            } else if (status === 404) {
                // Se o registro não foi localizado (HTTP 404)
                const errorMsg = data && data.message ? data.message : 'Registro não localizado.';
                this.showMessage(errorMsg);
                this.showMessage(`Erro: ${errorMsg}`);
            } else {
                // Outros erros inesperados
                const errorMsg = data && data.message ? data.message : 'Erro ao excluir registro.';
                this.showMessage(errorMsg);
                this.showMessage(`Erro inesperado: ${errorMsg}`);
            }
        } catch (error) {
            // Trata erros gerais de requisição ou rede
            this.showMessage(`Erro ao excluir registro: ${error.message}`);
            this.showMessage(`Erro ao excluir registro: ${error.message}`);
        }
    }
    
    async goBof() {
        try {
            const { status, data } = await this.sendRequest('CmGoBof', null, null, 'GET');
            if (status === 200) {
                this.bof = true; 
                this.eof = false;                                       
                this.updateWorkingDataFromServer(data);
                this.setState(MiConsts.Mb_St_Insert, false);
                this.setState(MiConsts.Mb_St_Edit, true);
                return true; // Retorna true em caso de sucesso
            } else {
                this.showMessage(`Erro ao ir para o primeiro registro: ${data.message}`);
                return false; // Retorna false em caso de falha
            }
        } catch (error) {
            this.showMessage(`Erro ao ir para o primeiro registro: ${error.message}`);
            return false; // Retorna false em caso de exceção
        }
    }
    
    async nextRecord() {        
        try {
            if (!this.eof) {
                const queryParams = this.buildQueryParams();
                const { status, data } = await this.sendRequest('CmNextRecord', queryParams, null, 'GET');
                
                if (status === 200 && data) {
                    this.updateWorkingDataFromServer(data);
                    this.setState(MiConsts.Mb_St_Browse, true); // Defina o estado de navegação
                    this.setState(MiConsts.Mb_St_Insert, false);
                    this.setState(MiConsts.Mb_St_Edit, true);                
                    this.bof = false; 
                    this.updateCommands(); 
                    return true; 
                } else {
                    this.bof = false; 
                    this.eof = true;
                    this.showMessage(`Erro ao obter próximo registro: ${data.message}`);
                    this.updateCommands(); 
                    return false;
                }
            }
            return false; 
        } catch (error) {
            this.showMessage(`Erro ao obter próximo registro: ${error.message}`);
            return false;
        }
    }
    
    async prevRecord() {
        try {
            if (!this.bof) {
                const queryParams = this.buildQueryParams();
                const { status, data } = await this.sendRequest('CmPrevRecord', queryParams, null, 'GET');
                if (status === 200 && data) {                    
                    this.updateWorkingDataFromServer(data);
                    this.setState(MiConsts.Mb_St_Browse, true); // Defina o estado de navegação
                    this.setState(MiConsts.Mb_St_Insert, false);
                    this.setState(MiConsts.Mb_St_Edit, true);                
                    this.eof = false; 
                    this.updateCommands(); 
                    return true; 
                } else {
                    this.bof = true;  
                    this.eof = false;
                    this.showMessage(`Erro ao obter registro anterior: ${data.message}`);
                    this.updateCommands(); 
                    return false; 
                }
            } 
            return false; 
        } catch (error) {
            this.showMessage(`Erro ao obter registro anterior: ${error.message}`);
            return false; 
        }
    }
        
    async goEof() {
        try {
            const { status, data } = await this.sendRequest('CmGoEof', null, null, 'GET');
            if (status === 200) {
                this.bof = false;  
                this.eof = true;
                this.updateWorkingDataFromServer(data);
                this.setState(MiConsts.Mb_St_Insert, false);
                this.setState(MiConsts.Mb_St_Edit, true);
                return true; // Retorna true em caso de sucesso
            } else {
                this.showMessage(`Erro ao ir para o último registro: ${data.message}`);
                return false; // Retorna false em caso de falha
            }
        } catch (error) {
            this.showMessage(`Erro ao ir para o último registro: ${error.message}`);
            return false; // Retorna false em caso de exceção
        }
    }

  // Método para alterar o estado baseado em alterações no campo
    changeMadeOnOff(aValue) {
        if (!this.reintranceChangeMadeOnOff) {
            this.reintranceChangeMadeOnOff = true; // Marca que estamos dentro da função

            if (aValue && this.recordAltered) {
                this.keyAltered = aValue; // Atualiza o estado da chave alterada
                this.updateCommands(); // Chama a função para atualizar os comandos
            } else {
                this.keyAltered = aValue; // Atualiza apenas o estado
            }        

            this.reintranceChangeMadeOnOff = false; // Reseta a marca de reentrância
        }
    }

    // Método para ser chamado no evento de entrada do campo
    handleInputChange(event) {
        const newValue = event.target.value;
        this.recordAltered = newValue.length > 0; // Atualiza se o campo não está vazio
        this.changeMadeOnOff(this.recordAltered); // Chama a função de alteração
    }
        
    async handleAction(action) {
        switch (action) {
            case 'CmNewRecord':
                await this.newRecord();
                break;
            case 'CmAddRecord':
               await this.addRecord();
               break;                                
            case 'CmPutRecord':
                await this.PutRecord();
                break;
            case 'CmDeleteRecord':
                await this.deleteRecord();
                break;
            case 'CmLocate':
                await this.locateRecord();
                break;
            case 'CmGoBof':
                this.goBof();
                break;
            case 'CmGoEof':
                this.goEof();
                break;
            case 'CmNextRecord':
                this.nextRecord();
                break;
            case 'CmPrevRecord':
                this.prevRecord();
                break;
            case 'CmCancel':
                this.cancel();
                break;                
            case 'CmRefresh':
                this.refresh();
                break;
            case 'CmHealthCheck':
                await this.checkApiAvailability();
                break;         

            // Adicione mais ações conforme necessário
            default:
                this.showMessage(`Ação ${action} não reconhecida.`);
        }
    }

    // Método para configurar ouvintes de eventos de entrada
    initInputListeners() {
        // Seleciona todos os campos de entrada
        const campos = document.querySelectorAll('input');

        // Adiciona o evento de entrada a cada campo
        campos.forEach(campo => {
            campo.addEventListener('input', (event) => {
                this.handleInputChange(event);
            });
        });
    }

    initEventListeners() {
        // Lista das ações CRUD
        const actions = ['CmHealthCheck', 'CmNewRecord', 'CmAddRecord', 'CmPutRecord', 'CmLocate', 
                         'CmDeleteRecord', 'CmRefresh', 'CmCancel'];
        // Lista das ações de navegação
        const navigationActions = ['CmGoBof', 'CmPrevRecord', 'CmNextRecord', 'CmGoEof'];

        // Adiciona os ouvintes de eventos para as ações CRUD
        actions.forEach(action => {
            const button = document.getElementById(action);
            if (button) {
                button.addEventListener('click', () => this.handleAction(action));
            }
        });

        // Adiciona os ouvintes de eventos para as ações de navegação
        navigationActions.forEach(action => {
            const button = document.getElementById(action);
            if (button) {
                button.addEventListener('click', () => this.handleAction(action));
            }
        });
    }

    
 


}
