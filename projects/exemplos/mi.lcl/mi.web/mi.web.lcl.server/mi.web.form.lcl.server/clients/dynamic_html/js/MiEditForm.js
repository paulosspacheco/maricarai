import { MiConsts    } from './MiConsts.js';
import { MiDialogs   } from './MiDialogs.js';
import { showMessage } from './MiDialogs.js';
import { messageBox  } from './MiDialogs.js';
import { inputBox    } from './MiInputBox.js';
import { MiThemeDialog  } from './MiThemeDialog.js';

//import { MiMaskEdit  } from './MiMaskEdit.js';

import { initializeFormMasks } from './MiMaskEdit.js';  


/**
 * Classe responsável por atualizar o estado dos botões.
 */
class Action {
    constructor(name) {
        this.name = name;
        this.enabled = true; // ou qualquer outro valor padrão
    }
}

/**
 * Definindo o TField como uma classe em JavaScript que captura as propriedades de 
 * document.activeElement
 * 
 */
class TField {
    constructor(element = null) {
        if (element) {
            this.tagName = element.tagName || '';      // Nome da tag do elemento (ex: INPUT, TEXTAREA)
            this.id = element.id || '';                // ID do elemento
            this.name = element.name || '';            // Nome do elemento
            this.value = element.value || '';          // Valor do elemento (para inputs, textareas)
            this.type = element.type || '';            // Tipo do elemento (ex: text, email, password)
            this.className = element.className || '';  // Classe CSS do elemento
            this.size = element.size || 0;             // Tamanho do campo de input
            this.maxLength = element.maxLength || -1;  // Número máximo de caracteres permitido
            this.placeholder = element.placeholder || '';  // Placeholder do campo
            this.checked = element.checked || false;   // Se o elemento está marcado (para checkbox e radio)
            this.disabled = element.disabled || false; // Se o campo está desabilitado
            this.readOnly = element.readOnly || false; // Se o campo é somente leitura
            this.tabIndex = element.tabIndex || 0;     // Índice de tabulação
            this.style = element.style || {};          // Estilos aplicados ao elemento
        } else {
            // Inicializa valores vazios
            this.tagName = '';
            this.id = '';
            this.name = '';
            this.value = '';
            this.type = '';
            this.className = '';
            this.size = 0;
            this.maxLength = -1;
            this.placeholder = '';
            this.checked = false;
            this.disabled = false;
            this.readOnly = false;
            this.tabIndex = 0;
            this.style = {};
        }
    }
}
/**
 * Classe responsável para comunicar-se com o servidor.
 * 
 */
export class MiEditForm extends MiConsts {

    constructor(formId, keyFields) {
        super(); // Chama o construtor da classe pai

        // Inicializa o formulário
        this.form = document.getElementById(formId);
        if (!this.form) {
            throw new Error(`Formulário com ID ${formId} não encontrado.`);
        }
       
        //initializeFormMasks(this.form); // Aplica máscaras apenas nesse formulário      

        this.keyFields = keyFields.split(';');
        this.options = 'loCaseInsensitive,loPartialKey';

        // Normaliza os campos de ID e Name do formulário
        try {
            this.normalizeFormIdsAndNames();
        } catch (error) {
            this.showMessage('mtError','Erro ao normalizar campos de formulário: '+ error);
        }
                

        // Array de comandos afetados pelo updateCommands
        this.commandControlList = [
            'CmHealthCheck', 
            'CmNewRecord', 
            'CmAddRecord', 
            'CmPutRecord', 
            'CmLocate', 
            'CmDeleteRecord', 
            'CmGoBof', 
            'CmNextRecord', 
            'CmPrevRecord', 
            'CmGoEof', 
            'CmCancel', 
            'CmRefresh'
        ];

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
                
        // Aplica máscaras apenas nesse formulário              
        initializeFormMasks(this.form); 
        
        // this.alert = new Alert(); // Instancia a classe Alert
        this.init();
    }
   
    init(){
        // Inicializa propriedades
        this.active = false;        
        this.recordSelected  = false;

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
        
        // Atributo que contém os dados da propriedade CurrentField
        this._currentField = null ;
        
        // Atributo que contém o campo focado
        this.currentFieldFocused = null ;


        // Verifica se a API está disponível
        try {
            this.checkApiAvailability();
        } catch (error) {
            this.showMessage('mtError','Erro ao verificar disponibilidade da API:'+error);
        }        
        this.updateCommands();
        this.ReadOnly = true;
        this.setInputFieldsReadOnly(this.ReadOnly);    
    }

    clearForm() {
        const formFields = this.form.querySelectorAll('input, textarea, select');
        formFields.forEach(field => {
            if (field.type === 'checkbox' || field.type === 'radio') {
                field.checked = false; // Limpa o checkbox ou radio
            } else {
                field.value = ''; // Limpa outros tipos de campo
            }
        });
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
                this.showMessage('mtError',`Botão não encontrado: ${action.name}`);
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
                return true;
                // this.saveWorkingData(); Neste momento pode não ter dados validos                       
            } else {
                // API indisponível
                this.setState(MiConsts.Mb_St_Active, false); // Desabilita o estado ativo
                this.showMessage('mtError',`Servidor não disponível!`);                
                return false;
            }
            //this.redraw();
        } catch (error) {            
            this.setState(MiConsts.Mb_St_Active, false); // Desabilita o estado ativo
            this.showMessage('mtError',`Erro ao verificar disponibilidade da API: ${error.message}`);            
            return false;            
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

    // Função para habilitar ou desabilitar os campos de entrada do formulário
    setInputFieldsDisabled(adisabled) {
        const inputElements = this.form.querySelectorAll('input, textarea, select');
        inputElements.forEach(element => {
            element.disabled = adisabled; // true para desabilitar, false para habilitar
        });
    }

     // Função para definir os campos de entrada como somente leitura ou editáveis
    setInputFieldsReadOnly(isReadOnly) {
        const inputElements = this.form.querySelectorAll('input, textarea, select');
        const previousStates = {}; // Objeto para armazenar os estados anteriores

        inputElements.forEach(element => {
            // Armazena o estado anterior
            previousStates[element.name] = element.readOnly;

            // Aplica readOnly apenas para os tipos que suportam essa propriedade
            if (element.tagName === 'TEXTAREA' || 
                (element.tagName === 'INPUT' && element.type !== 'checkbox' && element.type !== 'radio')) {
                element.readOnly = isReadOnly; // Atualiza o estado para somente leitura
            } else if (element.tagName === 'SELECT') {
                // Para selects, desabilita o campo para simular o comportamento de somente leitura
                element.disabled = isReadOnly;
            }
        });

        return previousStates; // Retorna os estados anteriores
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
    
        // Desabilita todos os comandos no controle
        this.disableCommands(this.commandControlList); 
                
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

    // getFormData() {
    //     const formData = new FormData(this.form);
    //     const data = {};
    
    //     // Captura todos os valores de campos padrão (input, select, textarea)
    //     formData.forEach((value, key) => {
    //         data[key.toLowerCase()] = value; // Armazena o nome do campo em minúsculas
    //     });
    
    //     // Tratamento específico para checkboxes
    //     const checkboxes = this.form.querySelectorAll('input[type="checkbox"]');
    //     checkboxes.forEach(checkbox => {
    //         data[checkbox.name.toLowerCase()] = checkbox.checked; // Armazena o estado do checkbox
    //     });
    
    //     // Tratamento específico para radio buttons
    //     const radios = this.form.querySelectorAll('input[type="radio"]');
    //     radios.forEach(radio => {
    //         if (radio.checked) {
    //             data[radio.name.toLowerCase()] = radio.value; // Armazena o valor do radio selecionado
    //         }
    //     });
    
    //     // Tratamento para selects com múltipla seleção
    //     const selects = this.form.querySelectorAll('select');
    //     selects.forEach(select => {
    //         if (select.multiple) {
    //             // Para selects múltiplos, captura os valores selecionados como um array
    //             const selectedOptions = Array.from(select.selectedOptions).map(option => option.value);
    //             data[select.name.toLowerCase()] = selectedOptions;
    //         } else {
    //             // Para selects normais, captura o valor selecionado
    //             data[select.name.toLowerCase()] = select.value;
    //         }
    //     });
    
    //     return data;
    // }
            
    // getFieldValue(fieldName) {
    //     const field = document.getElementById(fieldName.toLowerCase());
    //     if (field) {
    //         return field.value;
    //     } else {
    //         throw new Error(`Campo ${fieldName} não encontrado.`);
    //     }
    // }
    getFormData() {
        const formData = new FormData(this.form);
        const data = {};
    
        // Captura todos os valores de campos padrão (input, select, textarea)
        formData.forEach((value, key) => {
            const field = this.form.querySelector(`[name="${key}"]`);
            if (field && (field.dataset.maskType === MiConsts.fldEnum || field.dataset.maskType === MiConsts.fldEnum_Db) && field.tagName === 'SELECT') {
                // Para fldEnum e fldEnum_Db, armazenar o índice selecionado
                data[key.toLowerCase()] = field.selectedIndex;
            } else {
                data[key.toLowerCase()] = value; // Armazena o valor do campo normalmente
            }
        });
    
        // Tratamento específico para checkboxes
        const checkboxes = this.form.querySelectorAll('input[type="checkbox"]');
        checkboxes.forEach(checkbox => {
            data[checkbox.name.toLowerCase()] = checkbox.checked;
        });
    
        // Tratamento específico para radio buttons
        const radios = this.form.querySelectorAll('input[type="radio"]');
        radios.forEach(radio => {
            if (radio.checked) {
                data[radio.name.toLowerCase()] = radio.value;
            }
        });
    
        // Tratamento para selects com múltipla seleção
        const selects = this.form.querySelectorAll('select');
        selects.forEach(select => {
            if (select.multiple) {
                const selectedOptions = Array.from(select.selectedOptions).map(option => option.value);
                data[select.name.toLowerCase()] = selectedOptions;
            }
        });
    
        return data;
    }
    

    // setFieldValue(fieldName, value) {
    //     const field = document.getElementById(fieldName.toLowerCase());
    //     if (field) {
    //         if (field.type === 'checkbox' || field.type === 'radio') {
    //             field.checked = value; // Define o estado do checkbox ou radio
    //         } else {
    //             field.value = value != null ? value.toString() : '';
    //         }
    //     } else {
    //         this.showMessage('mtError', `Campo ${fieldName} não encontrado!`);
    //     }
    // }    

    setFieldValue(fieldName, value) {
        const field = document.getElementById(fieldName.toLowerCase());
        if (field) {
            if (field.type === 'checkbox' || field.type === 'radio') {
                field.checked = value;
            } else if ((field.dataset.maskType === MiConsts.fldEnum || field.dataset.maskType === MiConsts.fldEnum_Db) && field.tagName === 'SELECT') {
                // Para fldEnum e fldEnum_Db, definir o índice selecionado
                field.selectedIndex = value;
            } else {
                field.value = value != null ? value.toString() : '';
            }
        } else {
            this.showMessage('mtError', `Campo ${fieldName} não encontrado!`);
        }
    }
    

    updateForm(data) {
        if (!data || typeof data !== 'object') {
            this.showMessage('mtError','Dados para atualizar o formulário são nulos ou inválidos: '+ data);
            return;
        }

        for (const [key, value] of Object.entries(data)) {
            this.setFieldValue(key, value);
        }
    }

    buildQueryParams(keyFields) {
        const formData = this.getFormData();
        console.log('FormData:', formData); // Depuração: exibe os dados do formulário
    
        const params = new URLSearchParams();
    
        // Normaliza os campos-chave para minúsculas
        const lowerCaseKeyFields = keyFields.map(field => field.toLowerCase());
        console.log('lowerCaseKeyFields:', lowerCaseKeyFields); // Depuração: exibe os campos-chave em minúsculas
    
        // Adiciona os campos-chave à query string
        params.append('KeyFields', keyFields.join(';'));
    
        // Adiciona os valores dos campos-chave à query string
        const keyValues = lowerCaseKeyFields.map(lowerCaseField => {
            // Encontra o campo correspondente no formData, comparando em minúsculas
            const matchingField = Object.keys(formData).find(key => key.toLowerCase() === lowerCaseField);
    
            if (matchingField) {
                return formData[matchingField] || ''; // Retorna o valor do campo correspondente
            } else {
                this.showMessage('mtError', `Campo correspondente não encontrado para: ${lowerCaseField}`);
                return '';  // Se o campo não for encontrado, retorna string vazia
            }
        }).join(';');
    
        // Depuração: mostra os valores dos campos-chave que foram encontrados
        console.log('keyValues:', keyValues);
    
        if (keyValues.trim() === '') {
            this.showMessage('mtError', 'Atenção: Valores de campos-chave estão vazios.');
        }
    
        params.append('KeyValues', keyValues);
        params.append('Options', this.options);
    
        // Depuração: mostra a string completa da query
        console.log('QueryParams:', params.toString());
    
        return params.toString();
    }  

    // buildQueryParams() {
    //     const formData = this.getFormData();
    //     console.log('FormData:', formData); // Depuração: exibe os dados do formulário
        
    //     const params = new URLSearchParams();
    
    //     // Normaliza os campos-chave para minúsculas
    //     const lowerCaseKeyFields = this.keyFields.map(field => field.toLowerCase());
    //     console.log('lowerCaseKeyFields:', lowerCaseKeyFields); // Depuração: exibe os campos-chave em minúsculas
    
    //     // Adiciona os campos-chave à query string
    //     params.append('KeyFields', this.keyFields.join(';'));
    
    //     // Adiciona os valores dos campos-chave à query string
    //     const keyValues = lowerCaseKeyFields.map(lowerCaseField => {
    //         // Encontra o campo correspondente no formData, comparando em minúsculas
    //         const matchingField = Object.keys(formData).find(key => key.toLowerCase() === lowerCaseField);
    
    //         if (matchingField) {
    //             //console.log(`Campo correspondente encontrado: ${matchingField} -> Valor: ${formData[matchingField]}`);
    //             // Retorna o valor do campo correspondente (mantém a referência correta ao valor original)
    //             return formData[matchingField] || '';
    //         } else {
    //             this.showMessage('mtError',`Campo correspondente não encontrado para: ${lowerCaseField}`);
    //             return '';  // Se o campo não for encontrado, retorna string vazia
    //         }
    //     }).join(';');
    
    //     // Depuração: mostra os valores dos campos-chave que foram encontrados
    //     console.log('keyValues:', keyValues);
    
    //     if (keyValues.trim() === '') {
    //         this.showMessage('mtError','Atenção: Valores de campos-chave estão vazios.');
    //     }
    
    //     params.append('KeyValues', keyValues);
    //     params.append('Options', this.options);
    
    //     // Depuração: mostra a string completa da query
    //     console.log('QueryParams:', params.toString());
    
    //     return params.toString();
    // }      

    async sendRequest(action, queryParams, jsonData, method) {               

        try {
            this.setInputFieldsReadOnly(true);    
        
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

        } finally {
            this.setInputFieldsReadOnly(false);         
        }            
    }

    // Sobrescreve o método setState, mas chama o método da classe base primeiro
    setState(AState, enable) {
        // Primeiro, chama o método setState da classe base (MiConsts)
        super.setState(AState, enable);
        
        // Habilita ou desabilita this.isDataSetActive com base no AState
        if (AState === MiConsts.Mb_St_Active) {
            this.isDataSetActive = enable; // Habilita ou desabilita
            this.setInputFieldsReadOnly(true);                            
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
                this.showMessage('mtError','Erro: workingData ou workingDataOld não são válidos.');
            }
        } else {            
            this.showMessage('mtError','Aviso: O conjunto de dados não está ativo. Nenhum dado foi salvo.');
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
                this.showMessage('mtError','Erro: Dados de trabalho não estão definidos corretamente.');
            }
        } else {
            this.showMessage('mtError','Aviso: O conjunto de dados não ativo. Nenhum dado foi restaurado.');
        }
    }

    // Método para destruir os dados de trabalho
    destroyWorkingData() {
        this.wWorkingData = null; // Libera a referência
        this.wWorkingDataOld = null; // Libera a referência
    } 

    DoOnEnter(){
     this.recordSelected = true;
    }

    DoOnExit(){
     this.recordSelected = false;
    }
    
    // Método para atualizar os dados com a resposta do servidor
    updateWorkingDataFromServer(serverData) {
        this.DoOnExit();
        // Atualiza a interface com os dados recebidos
        this.updateForm(serverData);
        
        // Verifica se o serverData recebido é válido
        if (serverData && typeof serverData === 'object') {
            // Atualiza os dados atuais com a resposta do servidor
            this.workingData = this.deepClone(serverData); // Cópia profunda de serverData
            this.DoOnEnter();
        } else {
            this.showMessage('mtError','Erro: serverData não é um objeto válido.');
            return; // Sai da função se serverData não for válido
        }

        // Faz com que o registro atual = ao registro anterior;
        if (this.workingData && typeof this.workingData === 'object') {
            // Cópia profunda do workingData usando a função this.deepClone
            this.workingDataOld = this.deepClone(this.workingData);
        } else {
            this.showMessage('mtError','Aviso: workingData não está definido ou não é um objeto antes de fazer uma cópia.');
            this.workingDataOld = {}; // Inicializa como objeto vazio se não definido
        }

        // Verifica se workingData é válido antes de salvar
        if (this.workingData && typeof this.workingData === 'object') {
            this.saveWorkingData();
        } else {
            this.showMessage('mtError','Erro: workingData não é um objeto válido após atualização com serverData.');
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
            this.showMessage('mtError',`Erro ao cancelar a operação: ${error.message}`);
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
            this.showMessage('mtError',`Erro ao cancelar a operação: ${error.message}`);
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
            this.showMessage('mtError',`Erro ao criar novo registro: ${error.message}`);
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
                    this.showMessage('mtInformation','Registro adicionado com sucesso.');
                } else {
                    this.showMessage('mtInformation','Registro adicionado, mas sem dados retornados.');
                }             
            } else {
                this.showMessage('mtError',`Erro: ${JSON.stringify(responseData, null, 2)}`);
            }
        } catch (error) {
            this.showMessage('mtError',`Erro ao adicionar registro: ${error.message}`);
        }
    } 

    async showMessage(type = 'mtInformation',aMsg) {
        const result = showMessage(type,aMsg);//Aqui showMessage é global
    }

    messageBox(message, title = 'Alerta', dialogType = 'mtInformation', buttons = ['mbOK']){
        return messageBox(message, title,dialogType,buttons);  
    }

    // Função alert
    alert(message) {
        try {
            const miDialogs = new MiDialogs('mtWarning',['OK']); // Instancia a classe com o botão "OK"
            return miDialogs.showMessage('mtWarning', message); // Chama o método showMessage
        } catch (error) {
            console.error('Erro ao exibir a mensagem:', error);
        }
    }
    
    async createJsonFromField() {
        const formData = this.getFormData();
        // Verifica se this.currentField está definido
        if (!this.currentField || !this.currentField.name) {
            throw new Error("O campo atual não está definido ou o nome está vazio.");
        }
    
        // Cria um objeto JSON com as propriedades name e value
        const jsonObject = {
            name: this.currentField.name,      // Garante que name não seja indefinido
            value: this.currentField.value || '' // Garante que value não seja indefinido
        };
    
        // Usa prompt para editar o valor
        const newValues = await inputBox(`Informe a chave de pesquisa`, jsonObject);
        
        if (newValues !== null) {
            // Atualiza o valor no formData usando o name do currentField
            if (formData.hasOwnProperty(this.currentField.name)) {
                const fieldData = formData[this.currentField.name.toLowerCase()]; // Recupera o objeto do campo                   fieldData.value = newValues.value; // Define o novo valor no formData     
                this.currentField.value = newValues.value; // Atualiza o valor no currentField também
            } else {
                throw new Error(`Campo não encontrado em formData: ${this.currentField.name}`);
            }
        }
        
        // Retorna um array com o nome do campo
        return [this.currentField.name]; // Retorna um array com o name
    }
             

    async locateRecord() {
        try {            
            const aKey = await this.createJsonFromField();
            console.log('JSON criado:', aKey); // Exibe o JSON criado

            const queryParams = this.buildQueryParams(aKey); // Certifique-se que este método existe
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
                // console.log('Erro 404: Registro não localizado ou parâmetros inválidos.');
                if (data && data.message) {
                    this.showMessage('mtError',`Erro: ${data.message}. Status = `+status);
                } else {
                    this.showMessage('mtError','Registro não encontrado.');
                }
            } else {
                // Outros casos de erro
                // console.log(`Erro inesperado: status ${status}`);
                this.showMessage('mtError','Erro inesperado ao localizar registro. Status = '+status);
            }
        } catch (error) {
            // Erro de requisição ou de rede
            this.showMessage('mtError',`Erro ao localizar registro: ${error.message}`);
        }
    }     
    
    async PutRecord() {
        try {
            const data = this.getFormData();
            const queryParams = this.buildQueryParams(this.keyFields); // Certifique-se que este método existe            
            const { status, data: responseData } = await this.sendRequest('CmPutRecord',queryParams, data, 'PUT');

            if (status === 200) {
                this.saveWorkingData();
                this.appending = false;
                this.setState(MiConsts.Mb_St_Insert, false);
                this.setState(MiConsts.Mb_St_Edit, true);                
                this.showMessage('mtInformation','Registro atualizado com sucesso.');                
            } else {
                this.showMessage('mtError','Erro ao atualizar registro. Status = '+status);
            }
        } catch (error) {
            this.showMessage('mtError',`Erro ao atualizar registro: ${error.message}`);
        }
    }

    async deleteRecord() {
        try {
            // Supondo que você tenha uma função para construir os parâmetros da query
            const queryParams = this.buildQueryParams(this.keyFields); // Constrói a query string com os parâmetros necessários
    
            // Faz a requisição DELETE
            const { status, data } = await this.sendRequest('CmDeleteRecord', queryParams, null, 'DELETE');
    
            // Verifica o status de sucesso (200 OK)
            if (status === 200) {
                if (!(await this.nextRecord())) {
                    if (!(await this.prevRecord())) {
                        await this.newRecord();  
                    }
                }
                this.showMessage('mtInformation','Registro excluído com sucesso.');
            } else if (status === 500) {
                // Se ocorrer um erro interno no servidor (HTTP 500)
                const errorMsg = data && data.message ? data.message : 'Erro interno ao excluir registro.';                
                this.showMessage('mtError',`Erro interno no servidor: ${errorMsg}; Status = `+status);
            } else if (status === 404) {
                // Se o registro não foi localizado (HTTP 404)
                const errorMsg = data && data.message ? data.message : 'Registro não localizado.';
                this.showMessage('mtError',`Erro: ${errorMsg}. Status = `+status);
            } else {
                // Outros erros inesperados
                const errorMsg = data && data.message ? data.message : 'Erro ao excluir registro.';                
                this.showMessage(`Erro inesperado: ${errorMsg}. Status = `+status);
            }
        } catch (error) {
            // Trata erros gerais de requisição ou rede            
            this.showMessage('mtError',`Erro ao excluir registro: ${error.message}`);
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
                this.showMessage(`Erro ao ir para o primeiro registro: ${data.message}. Status = `+status);
                return false; // Retorna false em caso de falha
            }
        } catch (error) {
            this.showMessage('mtError',`Erro ao ir para o primeiro registro: ${error.message}`);
            return false; // Retorna false em caso de exceção
        }
    }
    
    async nextRecord() {        
        try {
            if (!this.eof) {
                const queryParams = this.buildQueryParams(this.keyFields);
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
                    this.showMessage('mtError',`Erro ao obter próximo registro: ${data.message}. Status = `+status);
                    this.updateCommands(); 
                    return false;
                }
            }
            return false; 
        } catch (error) {
            this.showMessage('mtError',`Erro ao obter próximo registro: ${error.message}`);
            return false;
        }
    }
    
    async prevRecord() {
        try {
            if (!this.bof) {
                const queryParams = this.buildQueryParams(this.keyFields);
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
                    this.showMessage('mtError',`Erro ao obter registro anterior: ${data.message}. Status = `+status);
                    this.updateCommands(); 
                    return false; 
                }
            } 
            return false; 
        } catch (error) {
            this.showMessage('mtError',`Erro ao obter registro anterior: ${error.message}`);
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
                this.showMessage('mtError',`Erro ao ir para o último registro: ${data.message}. Status = `+status);
                return false; // Retorna false em caso de falha
            }
        } catch (error) {
            this.showMessage('mtError',`Erro ao ir para o último registro: ${error.message}`);
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
    // O evento abaixo executa os eventos OnEnterField e OnExitField porém não está funcionando
    async eventRequestCurrentField(aCommand) {

        function getParam(buildQueryParamsResult, aCurrentFieldName, aCurrentFieldValue, aEventName) {
            // Cria uma nova instância de URLSearchParams para começar com os parâmetros existentes
            const params = new URLSearchParams(buildQueryParamsResult);
        
            // Adiciona os novos campos CurrentFieldName, CurrentFieldValue e EventName
            params.append('CurrentFieldName', aCurrentFieldName);
            params.append('CurrentFieldValue', aCurrentFieldValue);
            params.append('EventName', aEventName);
        
            // Retorna a string completa da query com os novos parâmetros adicionados
            return params.toString();
        }     

return; //está com problema em getParam

        if (!this.recordSelected) {
            return;
        }

        try {      
            const queryParams = getParam(this.buildQueryParams(this.keyFields),
                            this.currentField.name,
                            this.currentField.value,
                            aCommand      
                            );

            console.log('JSON criado:', queryParams); // Exibe o JSON criado            
 
            const { status, data } = await this.sendRequest(aCommand, queryParams, null, 'GET');
    
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
                // console.log('Erro 404: Registro não localizado ou parâmetros inválidos.');
                if (data && data.message) {
                    this.showMessage('mtError',`Erro: ${data.message}. Status = `+status);
                } else {
                    this.showMessage('mtError','Registro não encontrado.');
                }
            } else {
                // Outros casos de erro
                // console.log(`Erro inesperado: status ${status}`);
                this.showMessage('mtError','Erro inesperado ao localizar registro. Status = '+status);
            }
        } catch (error) {
            // Erro de requisição ou de rede
            this.showMessage('mtError',`Erro ao localizar registro: ${error.message}`);
        }
    }     
    
      // Função que é chamada quando o campo recebe foco
    onEnterField() {        
        // Verifica se _currentField é um elemento DOM e tem a propriedade 'value'
        if ((this.currentField && this.currentField.value !== undefined) && (this.recordSelected == true))  {
            this.eventRequestCurrentField('OnEnterField');
            console.log('Conteúdo do campo:', this.currentField.value); // Imprime o valor do campo
        } else {
            console.log('OnExitField: currentField não está definido ou não é um campo de entrada');
        }        
        console.log('Campo de entrada Ativado!');        
    }

    // método chamada quando o campo perde o foco
    onExitField() {
        // Verifica se currentField é um elemento DOM e tem a propriedade 'value'
        if ((this.currentField && this.currentField.value !== undefined) && (this.recordSelected == true)) {
            this.eventRequestCurrentField('OnExitField');            
            console.log('Conteúdo do campo atual:   ', this.currentField.value); // Imprime o valor do campo                            
        } else {
            console.log('OnExitField: currentField não está definido ou não é um campo de entrada');
        }
                
        console.log('Campo de entrada desativado!');
    }    

    // Método que define o currentField
    setCurrentField(aCurrentField) {   
        // Verifica se existe um campo atual antes de chamar onExitField
        if (this._currentField) {
            this.onExitField(); // Usando this._currentField
        }
        
        // Atualiza o campo atual
        this._currentField = aCurrentField;
       

        // Verifica se o novo campo atual é válido antes de chamar onEnterField
        if (this._currentField) {
            this.onEnterField(); // Usando this._currentField
        }
    }
    
    // Getter e setter da propriedade CurrentField
    get currentField() {
        return this._currentField;
    }

    set currentField(aCurrentField) {
        this.setCurrentField(aCurrentField);
    }

    // Método que atualiza o campo focado
    updateFocusedField() {
        const focusedElement = document.activeElement;

        if (focusedElement && (focusedElement.tagName === 'INPUT' || 
                            focusedElement.tagName === 'SELECT')) {
            // Verifica se é um checkbox ou radio button, ou outro tipo de input
            if (focusedElement.type === 'checkbox' || focusedElement.type === 'radio' || 
                focusedElement.type !== 'checkbox' && focusedElement.type !== 'radio') {
                // Atribui diretamente o elemento HTML focado
                this.currentFieldFocused = focusedElement;
                
                // Definir o campo focado como o currentField
                this.setCurrentField(this.currentFieldFocused);

                console.log('Campo focado atualizado:', this.currentFieldFocused);
            } else {
                console.log('Nenhum campo de entrada está focado.');
            }
        }
    }

    // Método para ser chamado no evento de entrada do campo
    handleInputChange(event) {
        const newValue = event.target.value;
        this.recordAltered = newValue.length > 0; // Atualiza se o campo não está vazio
        this.changeMadeOnOff(this.recordAltered); // Chama a função de alteração
    }

    
    // Método para configurar ouvintes de eventos de entrada
    initInputListeners() {
        // Seleciona todos os campos de entrada: input, select, checkbox e radio button
        const fields = document.querySelectorAll('input, select');

        if (fields.length === 0) {
            this.showMessage('mtError', 'Nenhum campo encontrado no formulário.');
            return;
        }

        // Adiciona os eventos a cada campo
        fields.forEach(field => {
            if (field.type === 'checkbox' || field.type === 'radio') {
                // Para checkboxes e radio buttons, utiliza o evento 'change'
                field.addEventListener('change', (event) => {
                    this.handleInputChange(event);
                });
            } else {
                // Para outros tipos de input e selects, utiliza o evento 'input'
                field.addEventListener('input', (event) => {
                    this.handleInputChange(event);
                });
            }

            // Adiciona o evento de foco a cada campo
            field.addEventListener('focus', () => {
                this.updateFocusedField(); // Chama a função para atualizar o campo focado
            });
        });
    }

    initEventListeners() {
        // Lista das ações CRUD
        const actions = ['CmHealthCheck', 'CmNewRecord', 'CmAddRecord', 'CmPutRecord', 'CmLocate', 
                         'CmDeleteRecord', 'CmRefresh', 'CmCancel'];
        // Lista das ações de navegação
        const navigationActions = ['CmGoBof', 'CmPrevRecord', 'CmNextRecord', 'CmGoEof','CmDialogChangeTheme'];

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

    static changeTheme(themeFile){

        // Instanciar a classe ThemeDialog
        const miThemeDialog = new MiThemeDialog();

        // Adicionar evento ao botão para abrir o diálogo
        document.getElementById('open-dialog-btn').addEventListener('click', () => {
            miThemeDialog.open();
        });

    }

    // Método para abrir o diálogo de alteração de tema
    dialogChangeTheme() {
        const miThemeDialog = new MiThemeDialog();
        miThemeDialog.open();
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
                await this.goBof();
                break;
            case 'CmGoEof':
                await this.goEof();
                break;
            case 'CmNextRecord':
                await this.nextRecord();
                break;
            case 'CmPrevRecord':
                await this.prevRecord();
                break;
            case 'CmHealthCheck':                
                const isAvailable = await this.checkApiAvailability(); // Aguarda a verificação
                if (isAvailable) {
                    this.showMessage('mtInformation', 'Servidor ativo!');
                }
                break;         

            case 'CmCancel':
                this.cancel();
                break;                
            case 'CmRefresh':
                this.refresh();
                break;

            case 'CmDialogChangeTheme':
                this.dialogChangeTheme();
                break;

            // Adicione mais ações conforme necessário
            default:
                this.showMessage('mtError',`Ação ${action} não reconhecida.`);
        }
    }

}
