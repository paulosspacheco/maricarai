// Definição do tipo de campo (TField) como um objeto em JavaScript
class TField {
    constructor(name = '', value = '', typ = '', size = 0) {
        this.name = name;    // Nome do campo
        this.value = value;  // Valor do campo
        this.typ = typ;      // Tipo do campo
        this.size = size;    // Tamanho do campo
    }
}

class MyClass {
    constructor() {
        // Atributo que contém os dados da propriedade CurrentField
        this.currentField = new TField();

        // Atributo que salva o currentField anterior ao atual
        // Necessário caso se deseje fazer alguma verificação antes de uma ação
        this._currentFieldOld = new TField();
    }

    // Método que define o currentField
    setCurrentField(aCurrentField) {
        this.currentField = aCurrentField;
    }

    // Propriedade que obtém ou define o campo atual
    get currentField() {
        return this.currentField;
    }

    set currentField(aCurrentField) {
        this.setCurrentField(aCurrentField);
    }
}
