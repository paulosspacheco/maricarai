//https://github.com/alrieckert/freepascal/blob/master/packages/fcl-db/src/base/dbconst.pas
//Erros que podem aparecer no linux.
//  function ErrorMessage(Const ErrorCode : SmallWord) : AnsiString;
//  BEGIN

    CASE ErrorCode OF
      0: Result := '000: Chamada inválida a função Result.';

      {1..99 RESERVADO PARA ERROS DO DOS}
      1: Result := 'EPERM 1: Operação não permitida';
      2: Result := 'ENOENT 2 Arquivo ou diretório inexistente';
      3: Result := 'ESRCH 3 Processo inexistente';
      4: Result := 'EINTR 4 Chamada de sistema interrompida';
      5: Result := 'EIO 5 Erro de entrada/saída';
      6: Result := 'ENXIO 6 Endereço ou dispositivo inexistente';
      7: Result := 'E2BIG 7 Lista de argumentos muito longa';
      8: Result := 'ENOEXEC 8 Erro no formato exec';
      9: Result := 'EBADF 9 Descritor de arquivo inválido';
      10: Result := 'ECHILD 10 Não há processos filhos';
      11: Result := 'EAGAIN 11 Recurso temporariamente indisponível';
      12: Result := 'ENOMEM 12 Não foi possível alocar memória';
      13: Result := 'EACCES 13 Permissão negada';
      14: Result := 'EFAULT 14 Endereço inválido';
      15: Result := 'ENOTBLK 15 Dispositivo de bloco requerido';
      16: Result := 'EBUSY 16 Dispositivo ou recurso está ocupado';
      17: Result := 'EEXIST 17 Arquivo existe';
      18: Result := 'EXDEV 18 Link entre dispositivos inválido';
      19: Result := 'ENODEV 19 Dispositivo inexistente';
      20: Result := 'ENOTDIR 20 Não é um diretório';
      21: Result := 'EISDIR 21 É um diretório';
      22: Result := 'EINVAL 22 Argumento inválido';
      23: Result := 'ENFILE 23 Muitos arquivos abertos no sistema';
      24: Result := 'EMFILE 24 Muitos arquivos abertos';
      25: Result := 'ENOTTY 25 ioctl inapropriado para dispositivo';
      26: Result := 'ETXTBSY 26 Área de texto ocupada';
      27: Result := 'EFBIG 27 Arquivo muito grande';
      28: Result := 'ENOSPC 28 Não há espaço disponível no dispositivo';
      29: Result := 'ESPIPE 29 Procura ilegal';
      30: Result := 'EROFS 30 Sistema de arquivos somente para leitura';
      31: Result := 'EMLINK 31 Muitos links';
      32: Result := 'EPIPE 32 Pipe quebrado';
      33: Result := 'EDOM 33 Argumento numérico fora de domínio';
      34: Result := 'ERANGE 34 Resultado numérico fora de alcance';
      35: Result := 'EDEADLK 35 Evitado deadlock de recurso';
      36: Result := 'ENAMETOOLONG 36 Nome de arquivo muito longo';
      37: Result := 'ENOLCK 37 Não há travas disponíveis';
      38: Result := 'ENOSYS 38 Função não implementada';
      39: Result := 'ENOTEMPTY 39 Diretório não vazio';
      40: Result := 'ELOOP 40 Muitos níveis de links simbólicos';
      41: Result := 'EWOULDBLOCK 41 Recurso temporariamente indisponível';
      42: Result := 'ENOMSG 42 Não há mensagens do tipo desejado';
      43: Result := 'EIDRM 43 Identificador removido';
      44: Result := 'ECHRNG 44 Número do canal fora do intervalo';
      45: Result := 'EL2NSYNC 45 Nível 2 não sincronizado';
      46: Result := 'EL3HLT 46 Nível 3 parado';
      47: Result := 'EL3RST 47 Nível 3 reiniciado';
      48: Result := 'ELNRNG 48 Número de link fora da faixa';
      49: Result := 'EUNATCH 49 Driver de protocolo não anexado';
      50: Result := 'ENOCSI 50 Não há estrutura CSI disponível';
      51: Result := 'EL2HLT 51 Parada de sistema nível 2';
      52: Result := 'EBADE 52 Troca inválida';
      53: Result := 'EBADR 53 Descritor de requisição inválido';
      54: Result := 'EXFULL 54 Troca completa';
      55: Result := 'ENOANO 55 Sem anode';
      56: Result := 'EBADRQC 56 Código de requisição inválido';
      57: Result := 'EBADSLT 57 Slot inválido';
      58: Result := 'EDEADLOCK 35 Evitado deadlock de recurso';
      59: Result := 'EBFONT 59 Formato do arquivo fonte inválido';
      60: Result := 'ENOSTR 60 Dispositivo não é um stream';
      61: Result := 'ENODATA 61 Não há dados disponíveis';
      62: Result := 'ETIME 62 Tempo expirado';
      63: Result := 'ENOSR 63 Sem recursos de streams';
      64: Result := 'ENOSR 64 Sem recursos de streams';
      65: Result := 'ENOPKG 65 Pacote não instalado';
      66: Result := 'EREMOTE 66 Objeto é remoto';
      67: Result := 'ENOLINK 67 Link foi cortado';
      68: Result := 'EADV 68 Erro de aviso';
      69: Result := 'ESRMNT 69 Erro de srmount';
      70: Result := 'COMM 70 Erro de comunicação ao enviar';
      71: Result := 'EPROTO 71 Erro de protocolo';
      72: Result := 'EMULTIHOP 72 Tentativa de Multihop';
      73: Result := 'EDOTDOT 73 Erro específico de RFS';
      74: Result := 'EBADMSG 74 Mensagem inválida';
      75: Result := 'EOVERFLOW 75 Valor muito grande para o tipo de dados definido';
      76: Result := 'ENOTUNIQ 76 O nome não é único na rede';
      77: Result := 'EBADFD 77 Descritor de arquivo em mal estado';
      78: Result := 'EREMCHG 78 Endereço remoto alterado';
      79: Result := 'ELIBACC 79 Não foi possível acessar uma biblioteca compartilhada';
      80: Result := 'ELIBBAD 80 Acessando uma biblioteca compartilhado corrompida';
      81: Result := 'ELIBSCN 81 Seção .lib corrompida em a.out';
      82: Result := 'ELIBMAX 82 Tentando vincular em muitas bibliotecas compartilhadas';
      83: Result := 'ELIBEXEC 83 Não foi possível executar uma biblioteca compartilhado diretamente';
      84: Result := 'EILSEQ 84 Multibyte ou caractere largo inválido';
      85: Result := 'ERESTART 85 Chamada de sistema interrompida deve ser reiniciada';
      86: Result := 'ESTRPIPE 86 Erro de fluxos de pipe';
      87: Result := 'EUSERS 87 Muitos usuários';
      88: Result := 'ENOTSOCK 88 Operação socket em um arquivo não-socket';
      89: Result := 'EDESTADDRREQ 89 Endereço de destino requerido';
      90: Result := 'EMSGSIZE 90 Mensagem muito longa';
      91: Result := 'EPROTOTYPE 91 Tipo errado de protocolo para socket';
      92: Result := 'ENOPROTOOPT 92 Protocolo não disponível';
      93: Result := 'EPROTONOSUPPORT 93 Protocolo sem suporte';
      94: Result := 'ESOCKTNOSUPPORT 94 Tipo socket sem suporte';
      95: Result := 'EOPNOTSUPP 95 Operação sem suporte';
      96: Result := 'EPFNOSUPPORT 96 Família de protocolo sem suporte';
      97: Result := 'EAFNOSUPPORT 97 Família de endereços sem suporte pelo protocolo';
      98: Result := 'EADDRINUSE 98 Endereço já em uso';
      99: Result := 'EADDRNOTAVAIL 99 Não foi possível acessar o endereço requisitado';

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
      244: Result     := '244: Tentativa de inserir registro sem está selecionado.';
      245: Result     := '245: tentativa de editar um registro não selecionando';
      246
      ..
      254: Result := '238..254: RESERVADO PARA ERROS FATAIS';
      255: Result := '255: ^C. Sistema abortado.';

      ELSE Result := 'Erro indefinido Maior que 255';
    END;
//  END;


