/**
 * Classe usada para incrementar e decrementar um contador específico
 * Criei essa classe ao estudar functions anonimas e function seta.
 */
class Tcounter {
    constructor() {
      this.value = 0;
    }
    /*Contador. incrementa 1 toda vez que pe chamado.*/
    inc() {
      return ++this.value
    }
    /*Contador. decrementa 1 toda vez que é chamado.*/
    dec() {
      return --this.value
    }
  }
  