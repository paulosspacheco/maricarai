    (*: - A função SysDuplicateHandle retorna um texto com o nome do erro passado por ErrorCode

          - **PARÂMETRO**
            - **ErrorCode** - Número do erro

          - **RETORNA**
            - Nome do erro

          - **NOTA**
            - O sistema converte os erros dos sistemas operacionais windows e linux para os erros descritos nesta função.
            -

          - **LISTA DOS ERROS POSSÍVEIS**
            - [SysError.inc](./units/include/windows/SysError.inc)

            ```pascal

              0: Result := '000: Chamada inválida a função Result.';
              {1..99 RESERVADO PARA ERROS DO DOS}
              1: Result := '001: GPF';
              2: Result := '002: Arquivo não encontrado';
              3: Result := '003: Nome do arquivo inválido';
              4: Result := '004: Muitos arquivos aberto simultaneamente';
              5: Result := '005: Acesso ao arquivo negado';
              6: Result := '006: Handle do arquivo inválido';
              7: Result := '007: Seek fora da faixa do arquivo';
              8: Result := '008: Não ha memória disponível';
              9: Result := '009: Endereço do bloco em memória inválido';
              10: Result := '010: Ambiente inválido';
              11: Result := '011: Formato inválido';
              12: Result := '012: Código de acesso ao arquivo inválido';
              13: Result := '013: Dados inválido';
              14: Result := '014: Unidade desconhecida';
              15: Result := '015: Número do drive inválido';
              16: Result := '016: Diretório atual não pode ser removido';
              17: Result := '017: Não pode executar troca de nomes entre discos';
              18: Result := '018: Não ha mais arquivos';
              19: Result := '019: Disco protegido contra escrita';
              20: Result := '020: Unidade desconhecida';
              21: Result := '021: Drive não esta pronto';
              22: Result := '022: Comando desconhecido';
              23: Result := '023: Erro de dados CRC';
              24: Result := '024: Erro de tamanho de estrutura do pedido';
              25: Result := '025: Erro de busca';
              26: Result := '026: Meio de armazenamento desconhecido';
              27: Result := '027: Setor não encontrado';
              28: Result := '028: Falta de papel na impressora ';
              29: Result := '029: Falha na gravação';
              30: Result := '030: Falha na leitura';
              31: Result := '031: Falha geral';
              32: Result := '032: Violação de arquivo compartilhado';
              33: Result := '033: Violação de Lacre (Tentativa de acesso a região bloqueada)';
              34: Result := '034: Mudança de disco inválido';
              35: Result := '035: Bloco de controle de arquivo inválido';
              36: Result := '036: Excesso de buffer compartilhado';
              37: Result := '037: Campo não existe no registro do arquivo ';
              38: Result := '038: Tipo em memória incompatÍvel com o tipo do campo no arquivo ';
              39: Result := '039: Erro de sintaxe na expressão';
              40: Result := '040: Tipos de campos incompatíveis';
              41: Result := '041: Tipo de campo não conhecido';
              42: Result := '042: Campo em duplicidade na estrutura da tabela';
              43..49 : Result := '043..49: Reservado para DOS erros';
              50: Result := '050: Falta de suporte na requisicao de rede';
              51: Result := '051: Máquina remota não recebendo';
              52: Result := '052: Nome em duplicata na rede';
              53: Result := '053: Nome de rede não encontrado';
              54: Result := '054: Rede ocupada';
              55: Result := '055: Dispositivo não conectado na rede';
              56: Result := '056: Excesso no limite do comando NetBios';
              57: Result := '057: Erro de hardware no adaptador de rede';
              58: Result := '058: Resposta incorreta da rede';
              59: Result := '059: Erro inesperado na rede ';
              60: Result := '060: Adaptador remoto incompatÍvel';
              61: Result := '061: Fila de impressão cheia';
              62: Result := '062: Fila de impressão vazia';
              63: Result := '063: Espaco não suficiente para impressão de arquivo';
              64: Result := '064: Nome de rede deletado';
              65: Result := '065: Acesso negado';
              66: Result := '066: Tipo incorreto de dispositivo de rede';
              67: Result := '067: Nome de rede não encontrado';
              68: Result := '068: Excedido limite para o nome-de-rede';
              69: Result := '069: Excesso no limite de sessão do NetBios';
              70: Result := '070: Pausa temporária';
              71: Result := '071: Pedido de rede não encontrado';
              72: Result := '072: Pausa no redirecionamento de impressora ou disco';
              73..79: Result := '073..079: Reservado para DOS erros';
              80: Result := '080: Arquivo ja existe';
              81: Result := '081: Reservado';
              82: Result := '082: Não pode criar Diretório';
              83: Result := '083: Falha na interrupção 24. Erro crítico';
              84: Result := '084: Falta de estrutura';
              85: Result := '085: Já atribuído';
              86: Result := '086: Senha inválida';
              87: Result := '087: Parametro inválido';
              88: Result := '088: Falha de gravação na rede';
              89..99 : Result := '089..099: Reservado para DOS erros';

              {100 A 149 ERROS DE ENTRADA E SAIDA (I/O)}
              100: Result := '100: Erro ao ler o disco';//EndOfFile no delphi
              101: Result := '101: Erro ao gravar no disco';//DiskFull no delphi
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

            ```


          - **REFERÊNCIAS**:
            - FreePascal - acesso a arquivos.  : https://www.freepascal.org/docs-html/rtl/system/ioresult.html
            - windows:     https://docs.microsoft.com/pt-br/cpp/c-runtime-library/errno-constants?view=msvc-170
            - DOS: https://docs.microsoft.com/pt-br/cpp/c-runtime-library/errno-doserrno-sys-errlist-and-sys-nerr?view=msvc-170
            - Linux: https://man7.org/linux/man-pages/man3/errno.3.html

    *)


