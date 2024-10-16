class TMaskEdit {
  constructor(inputElement) {
      this.inputElement = inputElement;
      // Obter a máscara do atributo data-mask
      this.maskType = inputElement.getAttribute('data-mask');

      this.inputElement.addEventListener('focus', () => this.onFocus());
      this.inputElement.addEventListener('blur', () => this.onBlur());
      this.inputElement.addEventListener('input', () => this.onInput());
  }

  onFocus() {
      // Ao ganhar foco, remover a máscara para edição
      const value = this.removeMask(this.inputElement.value);
      this.inputElement.value = value;
      this.setCursorToEnd();
  }

  onBlur() {
      // Ao perder o foco, aplicar a máscara
      const value = this.inputElement.value;
      this.inputElement.value = this.applyMask(value);
  }

  onInput() {
      // Atualiza o valor à medida que o usuário digita
      const value = this.inputElement.value;
      this.inputElement.value = this.applyMask(this.removeMask(value));
  }

  applyMask(value) {
      switch (this.maskType) {
          case '000.000.000-00':
              return this.applyCpfMask(value);
          case '(00) 00000-0000':
              return this.applyPhoneMask(value);
          case 'R$ 0.000,00':
              return this.applyCurrencyMask(value);
          case 'fracionario':
              return this.applyFractionalMask(value);
          default:
              return value; // Retorna o valor sem formatação se a máscara não for reconhecida
      }
  }

  applyCpfMask(value) {
      // Remove caracteres não numéricos
      const numericValue = value.replace(/[^\d]/g, '');

      // Aplica a máscara
      return numericValue.replace(/(\d{3})(\d)/, '$1.$2')
                         .replace(/(\d{3})(\d)/, '$1.$2')
                         .replace(/(\d{2})(\d)/, '$1-$2')
                         .replace(/-$/, ''); // Remove o último hífen se estiver vazio
  }

  applyPhoneMask(value) {
      // Remove caracteres não numéricos
      const numericValue = value.replace(/[^\d]/g, '');

      // Aplica a máscara
      return numericValue.replace(/(\d{2})(\d)/, '($1) $2')
                         .replace(/(\d{5})(\d)/, '$1-$2');
  }

  applyCurrencyMask(value) {
      // Remove caracteres não numéricos
      const numericValue = value.replace(/[^\d]/g, '');

      // Formatação: R$ 0.000,00
      const integerPart = numericValue.slice(0, -2);
      const decimalPart = numericValue.slice(-2);

      // Formata a parte inteira com separadores de milhar
      const formattedInteger = integerPart.replace(/\B(?=(\d{3})+(?!\d))/g, '.');

      // Monta o valor final
      return `R$ ${formattedInteger}${decimalPart ? ',' + decimalPart : ''}`;
  }

  applyFractionalMask(value) {
      // Remove caracteres não numéricos
      const numericValue = value.replace(/[^\d]/g, '');

      // Formatação: separador de milhar e decimal
      const integerPart = numericValue.slice(0, -2);
      const decimalPart = numericValue.slice(-2);

      // Formata a parte inteira com separadores de milhar
      const formattedInteger = integerPart.replace(/\B(?=(\d{3})+(?!\d))/g, '.');

      // Monta o valor final
      return formattedInteger + (decimalPart ? ',' + decimalPart : '');
  }

  removeMask(value) {
      // Remove a máscara para obter apenas o valor numérico
      return value.replace(/[.\, R\$()]/g, '').replace(/^0+/, '');
  }

  setCursorToEnd() {
      // Coloca o cursor no final do campo de entrada
      const length = this.inputElement.value.length;
      this.inputElement.setSelectionRange(length, length);
  }
}

// Exemplo de uso
document.addEventListener("DOMContentLoaded", () => {
  const inputs = document.querySelectorAll("[data-mask]");
  inputs.forEach(input => new TMaskEdit(input));
});
