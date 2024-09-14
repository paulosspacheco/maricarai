
<form class="search-form" action="tipue_results.html">
  <div class="search-input">
    <input
      type="text"
      name="q"
      id="tipue_search_input"
      pattern=".{3,}"
      title="Número de caracteres mínimos para pesquisa: 3 caracteres. Pesquisa parcial deve estar entre aspas."  required
    />
    <div class="search-button">
      <input
        type="image" 
        src="/js/search.png"
        id="tipue_search_button"
        onclick="this.form.submit();"
      />
    </div>
  </div>
</form>
 <div style="clear: both"></div>

          