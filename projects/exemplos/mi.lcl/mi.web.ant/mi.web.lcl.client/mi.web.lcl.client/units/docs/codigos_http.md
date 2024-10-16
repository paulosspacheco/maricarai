# Códigos de status HTTP (HyperText Transfer Protocol)

Os códigos de status HTTP (HyperText Transfer Protocol) são respostas padrão dadas por servidores web a pedidos feitos por clientes (normalmente navegadores). Eles indicam se uma requisição HTTP foi bem-sucedida, se houve um redirecionamento, um erro, etc. No HTTP/1.1, os códigos de status são classificados em cinco categorias principais:

1. Códigos 1xx (Informativos):
   1. 100 Continue: O servidor recebeu parte da solicitação e o cliente pode continuar a enviar o restante.
   2. 101 Switching Protocols: O servidor está mudando para o protocolo solicitado pelo cliente.
   3. 102 Processing: O servidor aceitou a solicitação, mas ainda não completou a ação.

2. Códigos 2xx (Sucesso):
   1. 200 OK: A solicitação foi bem-sucedida.
   2. 201 Created: A solicitação foi bem-sucedida e um novo recurso foi criado.
   3. 202 Accepted: A solicitação foi aceita para processamento, mas o processamento ainda não foi concluído.
   4. 203 Non-Authoritative Information: A solicitação foi bem-sucedida, mas as informações retornadas são de uma fonte não original.
   5. 204 No Content: A solicitação foi bem-sucedida, mas não há conteúdo para retornar.
   6. 205 Reset Content: A solicitação foi bem-sucedida, mas o cliente deve redefinir a visualização do documento.
   7. 206 Partial Content: O servidor está enviando uma parte do recurso devido a um cabeçalho de intervalo.
3. Códigos 3xx (Redirecionamento):
   1. 300 Multiple Choices: Existem várias opções possíveis para a solicitação.
   2. 301 Moved Permanently: O recurso solicitado foi movido permanentemente para um novo URL.
   3. 302 Found: O recurso solicitado foi encontrado em um URL diferente temporariamente.
   4. 303 See Other: A resposta pode ser encontrada em um URL diferente, usando o método GET.
   5. 304 Not Modified: O recurso solicitado não foi modificado desde a última solicitação.
   6. 305 Use Proxy: O recurso solicitado deve ser acessado através de um proxy.
   7. 307 Temporary Redirect: O recurso foi temporariamente movido para um URL diferente, mas o método HTTP não deve mudar.
   8. 308 Permanent Redirect: O recurso foi permanentemente movido para um URL diferente.

4. Códigos 4xx (Erro do Cliente):
   1. 400 Bad Request: A solicitação não pode ser processada devido a uma sintaxe inválida.
   2. 401 Unauthorized: A autenticação é necessária e falhou ou não foi fornecida.
   3. 402 Payment Required: Reservado para uso futuro.
   4. 403 Forbidden: O servidor entendeu a solicitação, mas se recusa a autorizá-la.
   5. 404 Not Found: O servidor não encontrou o recurso solicitado.
   6. 405 Method Not Allowed: O método HTTP usado não é permitido para o recurso solicitado.
   7. 406 Not Acceptable: O recurso solicitado só pode gerar conteúdo não aceitável de acordo com os cabeçalhos Accept enviados na solicitação.
   8. 407 Proxy Authentication Required: O cliente deve se autenticar com o proxy.
   9. 408 Request Timeout: O servidor esgotou o tempo de espera para a solicitação do cliente.
   10. 409 Conflict: A solicitação não pôde ser concluída devido a um conflito com o estado atual do recurso.
   11. 410 Gone: O recurso solicitado não está mais disponível e não há um endereço de redirecionamento.
   12. 411 Length Required: O servidor exige um cabeçalho Content-Length na solicitação.
   13. 412 Precondition Failed: Uma condição prévia dada nos cabeçalhos da solicitação falhou.
   14. 413 Payload Too Large: A entidade da solicitação é maior do que o servidor pode ou está disposto a processar.
   15. 414 URI Too Long: O URI solicitado é maior do que o servidor pode processar.
   16. 415 Unsupported Media Type: O formato de mídia da solicitação não é suportado pelo servidor.
   17. 416 Range Not Satisfiable: O intervalo especificado nos cabeçalhos Range da solicitação não pode ser satisfeito.
   18. 417 Expectation Failed: O servidor não pode atender aos requisitos do cabeçalho Expect da solicitação.
   19. 418 I'm a teapot: Um código de status de piada definido pelo RFC 2324, indicando que o servidor é um bule de chá.
   20. 421 Misdirected Request: A solicitação foi direcionada a um servidor que não pode produzir uma resposta.
   21. 422 Unprocessable Entity: A solicitação foi bem-formada, mas não pode ser seguida devido a erros semânticos.
   22. 423 Locked: O recurso acessado está bloqueado.
   23. 424 Failed Dependency: A solicitação falhou devido a falha em uma solicitação anterior.
   24. 425 Too Early: O servidor não deseja arriscar processar uma solicitação que pode ser repetida.
   25. 426 Upgrade Required: O cliente deve atualizar para um protocolo diferente.
   26. 428 Precondition Required: O servidor requer que a solicitação seja condicional.
   27. 429 Too Many Requests: O cliente enviou muitas solicitações em um curto período de tempo.
   28. 431 Request Header Fields Too Large: Campos de cabeçalho da solicitação são muito grandes.
   29. 451 Unavailable For Legal Reasons: O recurso foi bloqueado por razões legais.

5. Códigos 5xx (Erro do Servidor):
   1. 500 Internal Server Error: O servidor encontrou uma condição inesperada que o impediu de atender à solicitação.
   2. 501 Not Implemented: O servidor não tem a funcionalidade necessária para atender à solicitação.
   3. 502 Bad Gateway: O servidor, ao atuar como um gateway ou proxy, recebeu uma resposta inválida do servidor upstream.
   4. 503 Service Unavailable: O servidor está temporariamente indisponível, geralmente devido a manutenção ou sobrecarga.
   5. 504 Gateway Timeout: O servidor, ao atuar como um gateway ou proxy, não recebeu uma resposta no tempo esperado do servidor upstream.
   6. 505 HTTP Version Not Supported: O servidor não suporta a versão do protocolo HTTP usada na solicitação.
   7. 506 Variant Also Negotiates: O servidor tem um erro de configuração interna e não pode escolher uma variante apropriada.
   8. 507 Insufficient Storage: O servidor não pode armazenar a representação necessária para concluir a solicitação.
   9. 508 Loop Detected: O servidor detectou um loop infinito ao processar uma solicitação.
   10. 510 Not Extended: As extensões adicionais necessárias para o processamento da solicitação não foram atendidas.
   11. 511 Network Authentication Required: O cliente precisa se autenticar para ganhar acesso à rede.
