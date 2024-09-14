//Erros que podem aparecer no windows.
//function SysErrorMessage(Const ErrorCode : SmallWord) : AnsiString;
//BEGIN
  CASE ErrorCode OF
    0: Result := '000: Chamada inválida a função Result.';

    {1..99 RESERVADO PARA ERROS DO DOS/linux/ou?}
    1: Result := '001: EPERM - GPF ou Operação não permitida.';
    2: Result := '002: ENOENT - Arquivo ou diretório inexistente';
    3: Result := '003: ESRCH - Path not found ou Processo inexistente';
    4: Result := '004: EINTR - Muitos arquivos aberto simultaneamente ou Chamada de sistema interrompida';
    5: Result := '005: EIO - Acesso ao arquivo negado ou erro de entrada/saída';
    6: Result := '006: ENXIO - Handle do arquivo inválido ou  Endereço ou dispositivo inexistente';
    7: Result := '007: E2BIG - Seek fora da faixa do arquivo ou  Lista de argumentos muito longa';
    8: Result := '008: ENOEXEC - Não ha memória disponível ou erro no formato exec';
    9: Result := '009: EBADF - Endereço do bloco em memória inválido ou descritor de arquivo inválido';
    10: Result := '010: ECHILD - Ambiente inválido ou não há processos filhos';
    11: Result := '011: EAGAIN - Formato inválido ou recurso temporariamente indisponível';
    12: Result := '012: ENOMEM - Código de acesso ao arquivo inválido ou não foi possível alocar memória';
    13: Result := '013: EACCES - Dados inválido ou permissão negada';
    14: Result := '014: EFAULT - Unidade desconhecida ou endereço inválido';
    15: Result := '015: ENOTBLK - Número do drive inválido ou Dispositivo de bloco requerido';
    16: Result := '016: EBUSY - Diretório atual não pode ser removido ou dispositivo ou recurso está ocupado';
    17: Result := '017: EEXIST - Não pode executar troca de nomes entre discos ou arquivo existe';
    18: Result := '018: EXDEV - Não ha mais arquivos ou Link entre dispositivos inválido';
    19: Result := '019: ENODEV - Disco protegido contra escrita ou dispositivo inexistente';
    20: Result := '020: ENOTDIR - Unidade desconhecida ou Não é um diretório';
    21: Result := '021: EISDIR - Drive não está pronto ou é um diretório';
    22: Result := '022: EINVAL - Comando desconhecido ou argumento inválido';
    23: Result := '023: ENFILE - Erro de dados CRC ou muitos arquivos abertos no sistema';
    24: Result := '024: EMFILE - Erro de tamanho de estrutura do pedido ou muitos arquivos abertos';
    25: Result := '025: ENOTTY - Erro de busca ou ioctl inapropriado para dispositivo';
    26: Result := '026: ETXTBSY - Meio de armazenamento desconhecido ou área de texto ocupada';
    27: Result := '027: EFBIG - Setor não encontrado ou Arquivo muito grand';
    28: Result := '028: ENOSPC - Falta de papel na impressora ou não há espaço disponível no dispositivo';
    29: Result := '029: ESPIPE - Falha na gravação ou ou procura ilegal';
    30: Result := '030: EROFS - Falha na leitura ou sistema de arquivos somente para leitura';
    31: Result := '031: EMLINK - Falha geral ou muitos links';
    32: Result := '032: EPIPE - Violação de arquivo compartilhado ou pipe quebrado';
    33: Result := '033: EDOM - Violação de Lacre (Tentativa de acesso a região bloqueada) ou argumento numérico fora de domínio';
    34: Result := '034: ERANGE - Mudança de disco inválido ou resultado numérico fora de alcance';
    35: Result := '035: EDEADLK - Bloco de controle de arquivo inválido ou evitado deadlock de recurso';
    36: Result := '036: ENAMETOOLONG - Excesso de buffer compartilhado ou nome de arquivo muito longo';
    37: Result := '037: ENOLCK - Campo não existe no registro do arquivo ou bão há travas disponíveis';
    38: Result := '038: ENOSYS - Tipo em memória incompatÍvel com o tipo do campo no arquivo ou função não implementada';
    39: Result := '039: ENOTEMPTY - Erro de sintaxe na expressão ou diretório não vazio';
    40: Result := '040: ELOOP - Tipos de campos incompatíveis ou muitos níveis de links simbólicos';
    41: Result := '041: EWOULDBLOCK - Tipo de campo não conhecido ou recurso temporariamente indisponível';
    42: Result := '042: ENOMSG - Campo em duplicidade na estrutura da tabela ou não há mensagens do tipo desejado';
    43: Result := '043: EIDRM  Identificador removido';
    44: Result := '044: ECHRNG  Número do canal fora do intervalo';
    45: Result := '045: EL2NSYNC - Nível 2 não sincronizado';
    46: Result := '046: EL3HLT - Nível 3 parado';
    47: Result := '047: EL3RST - Nível 3 reiniciado';
    48: Result := '048: ELNRNG - Número de link fora da faixa';
    49: Result := '049: EUNATCH - Driver de protocolo não anexado';
    50: Result := '050: ENOCSI - Falta de suporte na requisicao de rede ou não há estrutura CSI disponível';
    51: Result := '051: EL2HLT - Máquina remota não recebendo ou parada de sistema nível 2';
    52: Result := '052: EBADE - Nome em duplicata na rede ou troca inválida';
    53: Result := '053: EBADR - Nome de rede não encontrado ou descritor de requisição inválido';
    54: Result := '054: EXFULL - Rede ocupada ou troca completa';
    55: Result := '055: ENOANO - Dispositivo não conectado na rede ou sem anode';
    56: Result := '056: EBADRQC - Excesso no limite do comando NetBios ou código de requisição inválido';
    57: Result := '057: EBADSLT - Erro de hardware no adaptador de rede ou slot inválido';
    58: Result := '058: EDEADLOCK - Resposta incorreta da rede ou evitado deadlock de recurso';
    59: Result := '059: EBFONT - Erro inesperado na rede ou formato do arquivo fonte inválido';
    60: Result := '060: ENOSTR - Adaptador remoto incompatÍvel ou dispositivo não é um stream';
    61: Result := '061: ENODATA - Fila de impressão cheia ou não há dados disponíveis';
    62: Result := '062: ETIME - Fila de impressão vazia ou tempo expirado';
    63: Result := '063: ENOSR - Espaco não suficiente para impressão de arquivo ou sem recursos de streams';
    64: Result := '064: ENOSR - Nome de rede deletado ou sem recursos de streams';
    65: Result := '065: ENOPKG - Acesso negado ou pacote não instalado';
    66: Result := '066: EREMOTE - Tipo incorreto de dispositivo de rede ou objeto é remoto';
    67: Result := '067: ENOLINK - Nome de rede não encontrado ou link foi cortado';
    68: Result := '068: EADV - Excedido limite para o nome-de-rede ou erro de aviso';
    69: Result := '069: ESRMNT - Excesso no limite de sessão do NetBios ou erro de srmount';
    70: Result := '070: COMM - Pausa temporária ou erro de comunicação ao enviar';
    71: Result := '071: EPROTO - Pedido de rede não encontrado ou erro de protocolo';
    72: Result := '072: EMULTIHOP - Pausa no redirecionamento de impressora ou tentativa de Multihop';
    73: Result := '073: EDOTDOT - Erro específico de RFS';
    74: Result := '074: EBADMSG - Mensagem inválida';
    75: Result := '075: EOVERFLOW - Valor muito grande para o tipo de dados definido';
    76: Result := '076: ENOTUNIQ - O nome não é único na rede';
    77: Result := '077: EBADFD - Descritor de arquivo em mal estado';
    78: Result := '078: EREMCHG - Endereço remoto alterado';
    79: Result := '079: ELIBACC - Não foi possível acessar uma biblioteca compartilhada';

    80: Result := '080: ELIBBAD - Arquivo ja existe ou acessando uma biblioteca compartilhado corrompida';
    81: Result := '081: ELIBSCN - Seção .lib corrompida em a.out';
    82: Result := '082: ELIBMAX - Não pode criar diretório ou tentando vincular em muitas bibliotecas compartilhadas';
    83: Result := '083: ELIBEXEC - Falha na interrupção 24. Erro crítico ou não foi possível executar uma biblioteca compartilhado diretamente';
    84: Result := '084: EILSEQ - Falta de estrutura ou multibyte ou caractere largo inválido';
    85: Result := '085: ERESTART - Já atribuído ou chamada de sistema interrompida deve ser reiniciada';
    86: Result := '086: ESTRPIPE - Senha inválida ou erro de fluxos de pipe';
    87: Result := '087: EUSERS - Parametro inválido ou Muitos usuários';
    88: Result := '088: ENOTSOCK - Falha de gravação na rede ou operação socket em um arquivo não-socket';
    89: Result := '089: EDESTADDRREQ - Endereço de destino requerido';
    90: Result := '090: EMSGSIZE - Mensagem muito longa';
    91: Result := '091: EPROTOTYPE - Tipo errado de protocolo para socket';
    92: Result := '092: ENOPROTOOPT - Protocolo não disponível';
    93: Result := '093: EPROTONOSUPPORT - Protocolo sem suporte';
    94: Result := '094: ESOCKTNOSUPPORT - Tipo socket sem suporte';
    95: Result := '095: EOPNOTSUPP - Operação sem suporte';
    96: Result := '096: EPFNOSUPPORT - Família de protocolo sem suporte';
    97: Result := '097: EAFNOSUPPORT - Família de endereços sem suporte pelo protocolo';
    98: Result := '098: EADDRINUSE - Endereço já em uso';
    99: Result := '099: EADDRNOTAVAIL - Não foi possível acessar o endereço requisitado';


    {100 A 149 ERROS DE ENTRADA E SAIDA (I/O)}
    100: Result := '100: Erro ao ler o disco';//EndOfFile no Delphi
    101: Result := '101: Erro ao gravar no disco';//DiskFull no Delphi
    102: Result := '102: Arquivo não assinalado (falta ASSIGN) ';
    103: Result := '103: Arquivo fechado';
    104: Result := '104: O arquivo fechado para entrada';
    105: Result := '105: O arquivo fechado para saída';
    106: Result := '106: Formato numérico inválido ou incompatÍvel';
    107: Result := '107: Disco cheio';
    108..149:
        Result := '108..149: Reservado para I/O ';

    {150..199 RESERVADO PARA ERROS CRITICOS}
    150: Result := '150: Disco protegido';
    151: Result := '151: UNIT desconhecida';
    152: Result := '152: Drive não esta pronto';
    153: Result := '153: Comando desconhecido';
    154: Result := '154: Erro na CRC de dados';
    155: Result := '155: Erro no drive solicitado pelo tamanho';
    156: Result := '156: Erro no posicionamento de disco';
    157: Result := '157: Tipo de meio desconhecido';
    158: Result := '158: Setor não encontrado';
    159: Result := '159: Impressora sem papel';
    160: Result := '160: Erro de escrita no dispositivo de saída ( Impressora )';
    161: Result := '161: Falta dispositivo de entrada ( Leitura )';
    162: Result := '162: Falta hardware ( equipamento )';
    163..199:
        Result := '163..199: RESERVADO PARA ERROS CRITICOS';

    {200..255 RESERVADO PARA ERROS FATAL}
    200: Result := '200: Divisão por zero';
    201: Result := '201: Error na checagem de faixa';
    202: Result := '202: Estouro no stack de memória';
    203: Result := '203: Estouro no heap de memória';
    204: Result := '204: Operação de pointer inválida';
    205: Result := '205: Estouro em operação com ponto flutuante';
    206: Result := '206: Erro de underflow com ponto-flutuante (Somente com 8087) ';
    207: Result := '207: Operação inválida com ponto flutuante';
    208: Result := '208: Gerenciador de Overlay não instalado';
    209: Result := '209: Erro da leitura no arquivo de overlay';
    210: Result := '210: Objeto não inicializado';
    211: Result := '211: Chamada a um metodo abstrato';
    212: Result := '212: Stream registration error';

    213: Result := '213: Collection index out of range';
    214: Result := '214: Collection overflow error';
    215: Result := '215: Arithmetic overflow error';
    216: Result := '216: General Protection fault';

    {MarIcarai 217..255}
    217: Result := '217: Tentativa de abrir um arquivo aberto.';
    218: Result := '218: Tentativa de excluir um registro excluido';
    219: Result := '219: Tentativa de ler um registro excluído';
    220: Result := '220: Outro usuário da rede alterou o registro';
    221: Result := '221: Estrutura da tabela esta danificada';
    222: Result := '222: Tentativa de gravar em um registro compartilhado sem que o mesmo esteja travado';

    {ApCLiSvr.pas}
    223: Result := '223: Evento executado por outro processo';
    224: Result := '224: Servidor de API não instalado';

    225: Result := '225: TTransaction.Commit esperado.';//TTransaction
    226: Result := '226: Não é uma expressão válida';
    227: Result := '227: Muitos parentese na expressão';
    228: Result := '228: Muitos operadores na expressão';
    229: Result := '229: Operador aritmético esperado na expressão';
    230: Result := '230: O Número não pode ser lido na expressão';

    REC_TOO_LARGE   :  Result  := 'Tamanho do registro em memória maior que o permitido (MaxDataRecSize)';
    REC_TOO_SMALL   :  Result  := 'Tamanho do Registro e muito longo';
    KeyTooLarge     :  Result  := 'Tamanho da chave maior do que o maximo permitido (MaxKeyLen) ';
    RecSizeMismatch :  Result  := 'Registro de dados incompatÍvel com a estrutura corrente. ';
    KeySizeMismatch :  Result  := 'Tamanho da pagina ou chave incompatÍvel com a estrutura corrente';
    MemOverflow     :  Result  := 'Não ha memória para os indice dos arquivos';
    ArqIndexInconsistente
                    :  Result  := 'Arquivo de indice inconsistente.';
    238             :  Result := '238: O gerente de transacoes esta inativo'; //TTransaction
    239             :  Result := '239: Excecao inesperada';
    240: Result     := '240: Acesso negado ao arquivo por falta de autorizacao de seu superior imediato';
    241: Result     := '241: Registro não localizado'; // Erros retornados nas buscas de registros
    242: Result     := '242: O evento OnEnter Retornou falso';
    243: Result     := '242: O evento OnExit Retornou falso';
    244
    ..
    254: Result := '238..254: RESERVADO PARA ERROS FATAIS';
    255: Result := '255: ^C. Sistema abortado.';

    ELSE Result := 'Erro indefinido Maior que 255';
  END;
//END;


