class TMaskEdit {
  constructor(inputElement) {
    this.inputElement = inputElement;
    this.mask = inputElement.getAttribute('data-mask');
    this.bindEvents();
  }

  bindEvents() {
    this.inputElement.addEventListener('input', (e) => this.applyMask(e));
  }

  applyMask(event) {
    let value = this.inputElement.value.replace(/\D/g, ''); // Remove tudo que não for número
    let maskedValue = '';
    let maskIndex = 0;

    for (let i = 0; i < value.length; i++) {
      while (this.mask[maskIndex] && this.mask[maskIndex].match(/\D/)) {
        maskedValue += this.mask[maskIndex];
        maskIndex++;
      }
      maskedValue += value[i];
      maskIndex++;
    }

    // Atualiza o campo com a máscara aplicada
    this.inputElement.value = maskedValue;
  }
}

// Inicializa a máscara em todos os campos com `data-mask`
document.querySelectorAll('input[data-mask]').forEach(input => {
  new TMaskEdit(input);
});
