unit mi.rtl.treenode;
{:< - A Unit **@name** implementa a classe **TTreeNode** do pacote **mi.rtl**.

  - **NOTAS**
    - Este documento descreve a unidade TTreeNode escrita em FreePascal.
      - A unidade define uma classe TTreeNode que representa um nó em uma
        árvore hierárquica.

  - **VERSÃO**
    - Alpha - 1.0.0

  - **HISTÓRICO**
    - Criado por: Paulo Sérgio da Silva Pacheco e-mail: paulosspacheco@@yahoo.com.br
    - **06/11/2023** - Inicio do projeto unit mi.rtl.treenode.pas
    - **07/11/2023** - Fim do projeto unit mi.rtl.treenode.pas
    - **09/11/2023** - Idetifiquei um erro no código html gerado no método TreeToStringListHtml
    - **16/08/2024** - Transformar test1 e test2 em teste(aaListaHtml:Boolesn).
    - **17/08/2024**
      - Documentar a unit usando como auxilia o Gemini do Google.
      - Criar método function CompareNodes(const Node1, Node2: TObject): integer;
      - Criar método function AddChildOrdered
      - Criar método AddChildAction para criar arvore de menus
      - Criar objeto TPathAction para ser usando em AddChildAction
      - Criar exemplos
        - Test_AddChildFileName
        -
  - **CÓDIGO FONTE**:
    - @html(<a href="../units/mi.rtl.treenode.pas">mi.rtl.treenode.pas</a>)

}


{$IFDEF FPC}
  {$MODE Delphi} {$H+}
{$ENDIF}

interface

uses
  Classes, SysUtils
  , LResources
  , Contnrs
  ,ActnList   ;

type
  {:P tipo **@name** é usado para comparação na ordenação de nós}
  TCompareNodes = function(const Node1, Node2: TObject): integer of object;


  { TMi_rtl_treenode }
  {:A class **@name** foi criada para criar menu html ou arvores de strings usando
    sintaxe simples de adição de nós e folhas.

    - **NOTAS**
      - Esta classe representa um nó em uma árvore hierárquica.
        - Ela possui propriedades e métodos para gerenciar filhos, dados associados
          ao nó e navegação na árvore.

      - Este código fornece uma estrutura básica para trabalhar com árvores
        hierárquicas no FreePascal. Você pode estender a classe TTreeNode para
        adicionar funcionalidades específicas à sua aplicação.

    - **EXEMPLOS**
      - Gera menu em HTML e um índice em arquivo .txt

        ```pascal

          class procedure TTreeNode.Test(okListHTML:boolean);
          var
            Root: TTreeNode;
            List : TStringList;
            S : string;

          begin
            writeLn('TTreeNode.Test');
            writeLn('Inicio: ===============');

            Root := TTreeNode.Create(TPath.create('root',false));

            with Root do
            begin
              List := TStringList.Create;

              // Adicione os caminhos de diretórios e folhas da árvore manualmente
              // ...

              // Adicione o arquivo '/home/documentos/test1.pas' com pastas no nome
              AddChildFileName(Root,'/home/documentos/test1.pas');
              AddChildFileName(Root,'/home/documentos/test2.pas');
              AddChildFileName(Root,'/home/documentos/mamae/test3.pas');
              AddChildFileName(Root,'/home/documentos/mamae/celia/test4.pas');
          //    s := (root..Owner.Owner as TTreeNode).fFilePath;
              AddChildFileName(Root,'test5.pas');
              AddChildFileName(Root,'/home/test6.pas');

              // Exiba a árvore de diretórios
              WriteLn('Árvore de diretórios:');
              if okListHTML
              then Root.TreeToStringListHtml(Root,List)
              else Root.TreeToStringList(Root,List);
              for s in List do
                writeLn(s);

              List.Free;

            end;
            Root.Free;
            writeLn('Fim: ===============');

          end;


        ```

      - Gera uma formulário dinamicamente com menu de opções baseado no componente
        treenode:

        ```pascal

          procedure PopulateMenuFromTreeNode(Node: TTreeNode; ParentMenuItem: TMenuItem);
          var
            Child: TTreeNode;
            NewMenuItem: TMenuItem;
            PathAction: TPathAction;
          begin
            if Node <> nil then
            begin
              PathAction := TPathAction(Node.Data); // Obtém o objeto TPath associado ao nó

              NewMenuItem := TMenuItem.Create(ParentMenuItem);
              NewMenuItem.Caption := PathAction.Data;
              NewMenuItem.Action  := PathAction.Action;

              ParentMenuItem.Add(NewMenuItem);

              // Se o nó atual não for uma folha, adiciona seus filhos ao menu
              if not PathAction.IsSheet then
              begin
                Child := Node.GetFirstChild;
                while Child <> nil do
                begin
                  PopulateMenuFromTreeNode(Child, NewMenuItem);
                  Child := Child.GetNextSibling;
                end;
              end;
            end;
          end;


          type

            //TForm

            TForm = class(Forms.TForm)
            private
              procedure ShowMessageAction(Sender: TObject);
            public
              constructor Create(AOwner: TComponent); override;
              function CreateAction(const ACaption: string): TAction;
            end;

          constructor TForm.Create(AOwner: TComponent);
          begin
            //inherited Create(AOwner);
            inherited CreateNew(AOwner, 1); // O segundo parâmetro é uma janela vazia
            Self.Caption := 'My Form';
            Self.SetBounds(100, 100, 400, 300); // Define o tamanho e a posição do formulário

            // Aqui você pode criar e adicionar componentes manualmente
          end;

          procedure TForm.ShowMessageAction(Sender: TObject);
          begin
            ShowMessage('Alô mundo');
          end;

          function TForm.CreateAction(const ACaption: string): TAction;
          begin
            Result := TAction.Create(Self);
            Result.Caption := ACaption;
            Result.OnExecute := @ShowMessageAction; // Associa o método ao evento OnExecute
          end;

          procedure TTreeNode_Test_AddChildAction();
          var
            Root: TTreeNode;
            MainMenu: TMainMenu;
            Form: TForm;
            action : TAction;
          begin
            // Criação e configuração do formulário e do menu
            Form := TForm.Create(nil);

            // Criação do nó raiz e inicialização da árvore
            Root := TTreeNode.Create(TPathAction.Create('root', False));
            With Root,Form do
            try
              // Adiciona os caminhos de diretórios e folhas da árvore
              AddChildAction('/home/documentos/ShowMessageAction',CreateAction('ShowMessageAction'));
              AddChildAction('/home/documentos/test2.pas',nil);
              AddChildAction('/home/documentos/mamae/test3.pas',nil);
              AddChildAction('/home/documentos/test1.pas',nil);
              AddChildAction('/home/documentos/test2.pas',nil);
              AddChildAction('/home/documentos/mamae/test3.pas',nil);
              AddChildAction('/home/documentos/mamae/celia/test4.pas',nil);
              AddChildAction('test5.pas',nil);
              AddChildAction('/home/test6.pas',nil);
              AddChildAction('test5.pas',nil);
              AddChildAction('/home/test6.pas',nil);

              try
                MainMenu := TMainMenu.Create(Form);
                Form.Menu := MainMenu;

                // Popula o menu a partir da árvore
                PopulateMenuFromTreeNode(Root, MainMenu.Items);

                Form.ShowModal;
              finally
                Form.Free;
              end;
            finally
              Root.Free;
            end;
          end;

        ```


    - Outros pontos importantes do código incluem:
      - A estrutura de TTreeNode permite criar e manipular árvores hierárquicas,
        com a capacidade de associar dados específicos a cada nó.
      - A classe TPath foi projetada para representar o caminho dos nós,
        distinguindo entre arquivos e diretórios.
      - A classe TPathAction estende TPath para incluir uma ação associada, permitindo
        criar árvores interativas com funcionalidade adicional.
  }
  TMi_rtl_treenode = class

    {: O atributo **@name** se True insere em ordem alfabetica}
    public Sorted : Boolean;

    {: O constructor **@name** inicializa o nó com o dado AData e cria uma lista
       vazia de filhos.
    }
    public constructor Create(AData: TObject);

      {:O destructor **@name** Libera a lista de filhos e chama o destrutor herdado.
      }
    public
      destructor Destroy; override;

    {$REGION Métodos de Gerenciamento de Filhos}
      {:O método **@name** adiciona um novo filho ao nó atual.

        - **PASSOS**
          - O método recebe o dado do filho AChildData;
          - Cria um novo nó TMi_rtl_treenode;
          - Atribui o nó atual como pai e o adiciona na lista de filhos;
          - Retorna o novo nó filho criado.}
      function AddChild(AChildData: TObject): TMi_rtl_treenode;

      {:O método **name** é usado para comparar os nós com base no campo 'Data'
        do objeto 'TPath' e insere ordenado ou não, depende do atributo Sorted.}
      function CompareNodes(const Node1, Node2: TObject): integer;

      {:O método **name** é usado para comparar os nós com base no campo 'Data'
        do objeto 'TPath' e insere na ordem crescente.}
      function AddChildOrdered(AChildData: TObject;CompareFunction: TCompareNodes): TMi_rtl_treenode;

      {:O método **@name** remove um filho específico da lista de filhos do nó
        atual.}
      procedure RemoveChild(AChild: TMi_rtl_treenode);

      {:O método **@name** remove todos os filhos do nó atual.}
      procedure ClearChildren;

      {:O método **@name** verifica se o nó atual tem algum filho na lista
        FChildren. Se houver, ele retorna o primeiro filho. Caso contrário,
        retorna nil.}
      public function GetFirstChild: TMi_rtl_treenode;
    {$ENDREGION}

    {$REGION '--->Construção da metodo AddChildFileName'}

      {:O método **@name** é responsável por criar um novo objeto do tipo TPath.

        - **NOTAS**
          - A finalidade principal é determinar se o objeto criado representará
            uma folha (sheet) ou um nó interno na árvore, com base no nome do
            arquivo e da parte do caminho fornecidos como parâmetros.

        - **PARÂMETROS**:
          - aFileName:
            - String que representa o nome completo do arquivo.
          - aPart:
            - String que representa a parte do caminho que está sendo analisada.

        - **RETORNO**:
          - Um objeto do tipo TPath.
            - Se a parte do caminho corresponder ao nome do arquivo (indicando
              uma folha), o objeto TPath será criado com a propriedade com **IsSheet**
              como **True**, caso contrário, **IsSheet** será False.

        - **EXEMPLO*

          ```pascal

            // Criando um nó representando um arquivo
            var
              Node: TMi_rtl_treenode;
              PathObject: TPath;
            begin
              PathObject := Create_Object('C:\meus_documentos\arquivo.txt', 'arquivo.txt') as TPath;
              Node := TMi_rtl_treenode.Create(PathObject);
              // Node agora representa uma folha (IsSheet = True)
            end;
          ```
      }
      function Create_Object(aFileName, aPart: string): TObject; virtual;overload;

      {:O método **@name** adiciona um novo nó filho a um nó raiz (Root) com base
        no nome de um arquivo especificado (FileName).

        - Esse método é útil quando se deseja construir uma estrutura hierárquica
          de nós de árvore que represente o caminho de um arquivo ou um conjunto
          de arquivos.

        - PARÂMETROS:
          - Root: TMi_rtl_treenode
            - O nó raiz ao qual o novo nó filho será adicionado. Este parâmetro
              representa o ponto de partida na árvore onde o novo nó será inserido.
          - FileName: string
            - O nome do arquivo que será utilizado para criar o novo nó. O
              FileName pode ser um caminho completo ou parcial, e os nós serão
              criados de acordo com as partes do caminho.
        - RETORNO:
          - TMi_rtl_treenode
            - Retorna o novo nó filho criado e adicionado à árvore. Este nó
              corresponde ao nome do arquivo especificado.

        - COMPORTAMENTO:
          - O método divide o FileName em partes, utilizando o separador de
            diretório (normalmente / ou \), e então cria ou encontra cada nó
            correspondente no caminho, adicionando-os à árvore sob o nó Root.
          - Se o caminho completo já existir na árvore, o método simplesmente
            retorna o nó correspondente ao FileName fornecido.
          - Se FileName contiver apenas um nome de arquivo (sem diretórios), o
            novo nó será adicionado diretamente como um filho de Root.

        - **EXEMPLO**

          ```pascal

              var
                RootNode, NewNode: TMi_rtl_treenode;
                FilePath: string;
              begin
                // Cria um nó raiz
                RootNode := TMi_rtl_treenode.Create(nil);
                RootNode.Text := 'Root';

                // Caminho do arquivo para adicionar à árvore
                FilePath := 'C:\Users\JohnDoe\Documents\file.txt';

                // Adiciona nós com base no caminho do arquivo
                NewNode := AddChildFileName(RootNode, FilePath);

                // Se desejar verificar o resultado, você pode percorrer e listar a árvore
                // (Essa parte é opcional e serve apenas para demonstrar como você pode verificar o resultado)
                ShowMessage('O nó filho foi criado com o texto: ' + NewNode.Text);
              end;
          ```
      }
      function AddChildFileName(Root: TMi_rtl_treenode; FileName: string):TMi_rtl_treenode;overload;

      {:O método **@name** executa o método AddChildFileName(Root,...) passando
        o root como self.
      }
      function AddChildFileName(FileName: string):TMi_rtl_treenode;overload;
    {$ENDREGION}

    {$REGION '--->Construção da metodo AddChildAction'}
      {:O método **@name** é responsável por criar e retornar uma instância da
        classe TPathAction, uma extensão de TPath que inclui uma ação associada.

        - O método determina se a parte do caminho (aPart) corresponde ao nome
          do arquivo e, com base nisso, configura o objeto criado como um nó de
          folha (arquivo) ou um nó interno (diretório).

        - **PARÂMETROS:
          - aFileName (string):
            O caminho completo do arquivo ou diretório em questão. Este parâmetro
            é usado para verificar se aPart corresponde ao nome do arquivo ou se
            representa um diretório.
          - aPart (string):
            - A parte do caminho que será utilizada para nomear o objeto TPathAction
              criado. Pode ser o nome do arquivo ou o nome de um diretório.
          - aAction (TAction):
            - A ação que será associada ao objeto TPathAction criado. Esta ação
              pode ser executada quando o nó correspondente na árvore é ativado.

        - **RETORNO**
          - TObject:
            - Retorna uma instância de TPathAction, que é uma classe que estende
              TPath e inclui uma ação associada. Essa instância pode ser utilizada
              como Data em um nó da árvore (TMi_rtl_treenode).
            - O método retorna o objeto TPathAction recém-criado, que pode ser
              associado ao Data de um nó da árvore.

        - **FUNCIONAMENTO**:
          - O método compara o nome do arquivo extraído de aFileName com aPart.
            - Se forem iguais (ignorando maiúsculas e minúsculas), isso indica
              que aPart é o nome do arquivo, e o objeto criado será marcado como
              uma folha (IsSheet := true).
            - Caso contrário, aPart representa um diretório, e o objeto será
              marcado como nó interno (IsSheet := false).

        - **EXEMPLO DE USO*

          ```pascal
              var
                Obj: TObject;
              begin
                // Suponha que um TreeNode já tenha sido criado

                // Cria um objeto associado ao arquivo 'test1.pas' com uma ação Action1
                Obj := TreeNode.Create_Object('/home/documentos/test1.pas', 'test1.pas', Action1);

                // Obj agora é uma instância de TPathAction associada ao arquivo 'test1.pas'
                // e com a ação Action1 associada.
              end;
          ```

        - Benefícios:
          - Flexibilidade:
            - O método permite criar objetos de caminho (TPathAction) que são
              conscientes de sua posição na hierarquia da árvore, seja como um
              arquivo ou diretório.
            - Associação de Ação: Além de criar o objeto, o método associa uma
              ação específica, facilitando a interação do usuário com os nós da
              árvore.

        - Observações:
          - Este método é fundamental para a criação e manipulação dinâmica de
            árvores onde cada nó pode ter uma ação específica associada, como
            em menus contextuais ou na execução de comandos específicos relacionados
            ao nó.
      }
      function Create_Object(aFileName, aPart: string; aAction: TAction): TObject; virtual; overload;

      {:O método **@name** adiciona uma série de nós filhos a partir de uma
        cadeia de nomes (TreeNodeNames) a um nó raiz (Root) e associa uma ação
        (Action) ao último nó da cadeia, se for uma folha.

        -

        - **PARÂMETROS**:
          - Root:
            - O nó raiz ao qual os novos nós serão adicionados. Este parâmetro
              representa o ponto de partida na árvore onde os novos nós serão
              inseridos.

          - TreeNodeNames (string):
            - Uma cadeia de nomes dos nós a serem criados. Os nomes devem ser
              separados por barras (/) ou outro delimitador que você escolher.
              Cada nome na cadeia representará um novo nó na árvore.

            - Action (TAction):
              - A ação (TAction) que será associada ao último nó da cadeia de
                nós se ele for uma folha. Se o último nó não for uma folha, a
                ação não será associada..

        - **RETORNO**:
          - TMi_rtl_treenode:
             - Retorna o último nó adicionado na árvore. Esse nó pode ser
               utilizado para operações adicionais se necessário.

        - **EXEMPLO**

          ```Pacal

            var
              RootNode, NewNode: TMi_rtl_treenode;
              MyAction: TAction;
            begin
              // Supondo que 'RootNode' e 'MyAction' já estão definidos
              // Exemplo de uso: Adiciona nós para "Users/JohnDoe/Documents/file.txt" sob o nó "RootNode"
              NewNode := RootNode.AddChildAction(RootNode, 'Users/JohnDoe/Documents/file.txt', MyAction);

              // 'NewNode' será o nó "file.txt" e 'MyAction' será associado a ele se "file.txt" for uma folha
            end;

          ```

        - Notas:
          - O delimitador usado em TreeNodeNames deve ser consistente com o
            utilizado na implementação. Se a cadeia TreeNodeNames usar barras (/),
            elas serão usadas para determinar a estrutura hierárquica dos nós.

          - Se o último nó na cadeia não for uma folha (ou seja, ele tiver filhos),
            a ação fornecida não será associada a ele.
      }
      public function AddChildAction(Root: TMi_rtl_treenode;const TreeNodeNames: string; Action: TAction): TMi_rtl_treenode;overload;

      {:O método **@name** executa o método AddChildAction(Root,...) passando
        o root como self.
      }
      public function AddChildAction(const FileName: string; Action: TAction): TMi_rtl_treenode;overload;
    {$ENDREGION '--->Construção da metodo AddChildAction'}

    {$REGION Métodos de Navegação}
      {: o método **@name** calcula o nível do nó atual na árvore.

         - **NOTAS**
           - O nível é contado a partir da raiz (0) e incrementado para cada nó
             pai encontrado.
      }
      function GetNodeLevel(): integer;

      {:O método **@name** é uma função auxiliar, ela cria uma string repetida um
          determinado número de vezes.

          - **NOTAS**
            - Utilizado para indentação na exibição da árvore.
        }
      function conststr(i: longint; str: string): string;

      {:O método **@name** procurar um nó filho na árvore. Esse método percorre
        os nós filhos do nó atual e retorna o nó que tem o nome especificado
        por AName.

        - **NOTAS***
          - Percorre os filhos do nó atual: O método verifica todos os filhos do
            nó atual para encontrar um que tenha um nome correspondente a AName.
          - Retorna::
            - Se encontrar um filho cujo nome corresponda a AName, ele retorna
              esse nó.
            - Retorna nil se nenhum nó for encontrado: Se não encontrar nenhum
              nó filho com o nome especificado, o método retorna nil, indicando
              que o nó não existe entre os filhos.

        - **PARÂMETRO*
          - AName
            - é uma string que representa o nome do nó que você está tentando
              encontrar.
      }
      function FindChild(const AName: string): TMi_rtl_treenode;

      function GetNextSibling: TMi_rtl_treenode;
    {$ENDREGION}

    {$REGION Métodos de Exibição}
      {: O método **@name** retorna uma lista de strings indentada.

         - **NOTAS**
           - Percorre a árvore recursivamente e adiciona o caminho e tipo
             (folha ou nó) de cada nó a uma lista TStringList.
      }
      procedure TreeToStringList(Mi_rtl_treenode: TMi_rtl_treenode; var S: TStringList); virtual;

        {: O método **@name** retorna código html como uma lista de strings indentada.

           - **NOTAS**
             - Similar ao TreeToStringList, porém gera a saída em formato HTML com
               tags <ul> e <li> para representar a hierarquia.
        }
      procedure TreeToStringListHtml(Mi_rtl_treenode: TMi_rtl_treenode; var S: TStringList); virtual;
    {$ENDREGION}

    {$REGION Propriedade Data}
      private FData: TObject;
      {:A propriedade **@name** armazena um dado associado ao nó. Pode ser
        qualquer tipo de objeto derivado de TObject. Esta propriedade permite
        que você associe informações adicionais a um nó específico na estrutura
        da árvore, que pode ser útil para armazenar metadados, informações de
        configuração ou qualquer outra informação relevante.

        - **EXEMPLO**

          ```pascal

            var
              Node: TMi_rtl_treenode;
              MyObject: TMyCustomObject;
            begin
              Node := TMi_rtl_treenode.Create;
              MyObject := TMyCustomObject.Create;

              // Associando um objeto ao nó
              Node.Data := MyObject;

              // Acessando o objeto associado ao nó
              if Node.Data is TMyCustomObject then
                // Realizar operações com MyObject
            end;

          ```
      }
      public property Data: TObject read fData write fData;
    {$ENDREGION Propriedade Data}

    {$REGION Propriedade Children}
      private
        FChildren: TObjectList;
        {:A prpriedade **@name** é uma lista contendo os nós filhos do nó atual.}
      public
        property Children: TObjectList read FChildren;
    {$ENDREGION Propriedade Children}

    {$REGION Propriedade Parent}
      private
        FParent: TMi_rtl_treenode;
          {:A propriedade **@name** adicionando a referência ao nó pai
          }
      public property Parent: TMi_rtl_treenode read FParent write FParent; // Nova propriedade
    {$ENDREGION Propriedade Parent}

    {:A método de classe **@name** cria uma árvore de exemplo adicionando alguns
      caminhos de arquivo e exibe a estrutura da árvore utilizando TreeToStringList
      ou TreeToStringListHtml dependendo do parâmetro okListHTML.}
    class procedure Test_AddChildFileName(okListHTML: boolean);
  end;

type
  { TPath }
  {:A classe **@name** representar um caminho dentro da estrutura da árvore.

    - **NOTAS**
      - Indica se o caminho representa uma folha (arquivo) ou um nó interno
       (diretório).
      - A classe **@name** é uma classe simples e específica para a sua aplicação.
        Você pode estendê-la com outras propriedades e métodos para atender a
        necessidades mais complexas.
  }
  TPath = class(TObject)
    {:O atributo **name** armazena o nome do caminho ou do arquivo.
    }
  public
    Data: string;

    {: O atributo **@name** indica se o caminho representa uma folha (True) ou
       um nó interno (False).}
  public
    IsSheet: boolean;

    {: O contructor **@name** inicializa um novo objeto TPath com os valores
       fornecidos.

       - **PARÂMETROS**
         - aData:
           - Nome do caminho ou arquivo.

         - aIsSheet:
           - Indica se é uma folha ou nó interno.

       - **USO**
         - A classe **TPath** é utilizada principalmente como dado associado aos
           nós da árvore **TMi_rtl_treenode**. O atributo **IsSheet** permite distinguir
           entre nós que representam arquivos (folhas) e aqueles que representam
           diretórios (nós internos).

       - **EXEMPLO**

         ```pascal
           // Criando um objeto TPath para representar um arquivo
           var
             PathObj: TPath;
           begin
             PathObj := TPath.Create('arquivo.txt', True); // True indica que é uma folha
             // Agora, PathObj pode ser associado a um nó TMi_rtl_treenode
           end;
         ```
    }
  public
    constructor Create(aData: string; aIsSheet: boolean); virtual; overload;
  end;

  { TPathAction }
  {:O objeto **@name** é usado par associar uma ação a folha da arvore.}
  TPathAction = class(TPath)
  public
    Action: TAction;
    constructor Create(aData: string; aIsSheet: boolean; aAction: TAction);Virtual; reintroduce; overload;
  end;

type
   {: A classe **@name** com objetivo inserir a classe TMi_rtl_treenode em um
      TDataModule ou um TForm. }
  TMi_rtl_treenodeComponent = class(TComponent)
  type TMi_rtl_treenode = mi.rtl.treenode.TMi_rtl_treenode;
  end;

procedure Register;

implementation

procedure Register;
begin
  {$I mi.rtl.treenode_icon.lrs}
  RegisterComponents('Mi.Rtl', [TMi_rtl_treenodeComponent]);
end;

{ TPath }
constructor TPath.Create(aData: string; aIsSheet: boolean);
begin
  inherited Create;
  Data := aData;
  IsSheet := aIsSheet;
end;

{ TPathAction }

constructor TPathAction.Create(aData: string; aIsSheet: boolean;aAction: TAction);
begin
  inherited Create(aData, aIsSheet);
  Self.Action := aAction;
end;

{TMi_rtl_treenode}
constructor TMi_rtl_treenode.Create(AData: TObject);
begin
  Inherited Create;
  Sorted:=false;
  FData := AData;
  FChildren := TObjectList.Create(True);
end;

destructor TMi_rtl_treenode.Destroy;
begin
  FChildren.Free;
  inherited Destroy;
end;

function TMi_rtl_treenode.AddChild(AChildData: TObject): TMi_rtl_treenode;
var
  ChildNode: TMi_rtl_treenode;
begin
  ChildNode := TMi_rtl_treenode.Create(AChildData);
  ChildNode.Parent := Self; // Atribui o nó pai
  FChildren.Add(ChildNode);
  Result := ChildNode;
end;

function TMi_rtl_treenode.CompareNodes(const Node1, Node2: TObject): integer;
  var
    s1,s2 :string;
begin
  // Converte os dados para string antes de comparar
  if (not Assigned(Node1)) or (NOt Assigned(Node2))
  Then abort;
  s1 := (Node1 as TPath).Data;
  s2 := (Node2 as TPath).Data;
  Result := CompareText(s1, s2);
end;

function TMi_rtl_treenode.AddChildOrdered(AChildData: TObject;CompareFunction: TCompareNodes): TMi_rtl_treenode;
var
  i: integer;
  ChildNode: TMi_rtl_treenode;
begin
  ChildNode := TMi_rtl_treenode.Create(AChildData);
  ChildNode.Parent := Self; // Atribui o nó pai

  // Encontra a posição correta para inserir o novo nó
  for i := 0 to FChildren.Count - 1 do
  begin
    if CompareFunction(ChildNode.data, (FChildren[i] as TMi_rtl_treenode).Data) < 0 then
    begin
      FChildren.Insert(i, ChildNode);
      Result := ChildNode;
      Exit;
    end;
  end;

  // Se não encontrar uma posição anterior, insere no final

  FChildren.Add(ChildNode);
  Result := ChildNode;
end;

procedure TMi_rtl_treenode.RemoveChild(AChild: TMi_rtl_treenode);
begin
  FChildren.Remove(AChild);
end;

procedure TMi_rtl_treenode.ClearChildren;
begin
  FChildren.Clear;
end;

function TMi_rtl_treenode.GetFirstChild: TMi_rtl_treenode;
begin
  if FChildren.Count > 0 then
    Result := TMi_rtl_treenode(FChildren.First)
  else
    Result := nil; // Retorna nil se não houver filhos
end;

function TMi_rtl_treenode.Create_Object(aFileName, aPart: string): TObject;
begin
  if LowerCase(ExtractFileName(aFileName)) = LowerCase(aPart) then
    Result := TPath.Create(aPart, True)
  else
    Result := TPath.Create(aPart, False);
end;

function TMi_rtl_treenode.AddChildFileName(Root: TMi_rtl_treenode; FileName: string): TMi_rtl_treenode;
  var
    Parts: TStringArray;
    ChildNode: TMi_rtl_treenode;
    Part,s: string;
    Found: Boolean;
    i : Integer;
    temp :TPath;
begin
  // Divide o caminho do arquivo em partes usando a barra como delimitador
  Parts := FileName.Split('/');

  // Começa com o nó raiz
  Result := Root;
  // Percorre as partes do caminho e cria os nós conforme necessário
  for Part in Parts do
  begin
    if Part= '' then Continue;
    Found := False;
    // Procura um filho existente com o mesmo nome
//    for ChildNode in Result.Children do
    for i := 0 to Result.Children.Count-1 do
    begin
      ChildNode := Result.Children.Items[i] as TMi_rtl_treenode;
      s := (ChildNode.Data as TPath).Data;
      if s = Part then
      begin
        Result := TMi_rtl_treenode(ChildNode);
        Found := True;
        Break;
      end;
    end;
    // Se não encontrou, cria um novo nó
    if not Found then
    begin
      temp := Create_Object(FileName,Part) as TPath;
      if Sorted
      then Result := Result.AddChildOrdered(temp, CompareNodes)
      else Result := Result.AddChild(temp);
    end;
  end;
end;

function TMi_rtl_treenode.AddChildFileName(FileName: string): TMi_rtl_treenode;
begin
  result := AddChildFileName(self,FileName);
end;

function TMi_rtl_treenode.Create_Object(aFileName, aPart: string; aAction: TAction): TObject;
begin
  // Cria uma instância de TTPathAction com as informações fornecidas
  if LowerCase(ExtractFileName(aFileName)) = LowerCase(aPart) then
    Result := TPathAction.Create(aPart,true,aAction)
  else
    Result := TPathAction.Create(aPart,false,nil);
end;

function TMi_rtl_treenode.AddChildAction(Root: TMi_rtl_treenode; const TreeNodeNames: string;Action: TAction): TMi_rtl_treenode;
  var
    Parts: TStringArray;
    ChildNode: TMi_rtl_treenode;
    Part,s: string;
    Found: Boolean;
    i : Integer;
    temp :TPathAction;
begin
  // Divide o caminho do arquivo em partes usando a barra como delimitador
  Parts := TreeNodeNames.Split('/');

  // Começa com o nó raiz
  Result := Root;
  // Percorre as partes do caminho e cria os nós conforme necessário
  for Part in Parts do
  begin
    if Part= '' then Continue;
    Found := False;
    // Procura um filho existente com o mesmo nome
//    for ChildNode in Result.Children do
    for i := 0 to Result.Children.Count-1 do
    begin
      ChildNode := Result.Children.Items[i] as TMi_rtl_treenode;
      s := (ChildNode.Data as TPath).Data;
      if s = Part then
      begin
        Result := TMi_rtl_treenode(ChildNode);
        Found := True;
        Break;
      end;
    end;
    // Se não encontrou, cria um novo nó
    if not Found then
    begin
      temp := Create_Object(TreeNodeNames,Part,Action) as TPathAction;
      if Sorted
      then Result := Result.AddChildOrdered(temp, CompareNodes)
      else Result := Result.AddChild(temp);
    end;
  end;
end;

function TMi_rtl_treenode.AddChildAction(const FileName: string; Action: TAction): TMi_rtl_treenode;
begin
  result := AddChildAction(self,FileName,Action);
end;

function TMi_rtl_treenode.GetNodeLevel: integer;
var
  ParentNode: TMi_rtl_treenode;
begin
  Result := 0; // Nível padrão, considerando que o nó atual é a raiz

  ParentNode := TMi_rtl_treenode(Self);

  // Percorre os pais até chegar à raiz
  while Assigned(ParentNode.Parent) do
  begin
    Inc(Result);
    ParentNode := ParentNode.Parent;
  end;
end;

function TMi_rtl_treenode.conststr(i: longint; str: string): string;
var
  j: longint;
begin
  Result := '';
  for j := 0 to i do
    Result := Result + str;
end;

function TMi_rtl_treenode.FindChild(const AName: string): TMi_rtl_treenode;
var
  ChildIndex: integer;
begin
  if FChildren <> nil then
  begin
    for ChildIndex := 0 to FChildren.Count - 1 do
    begin
      if (TMi_rtl_treenode(FChildren[ChildIndex]).Data as TPath).Data = AName then
      begin
        Result := TMi_rtl_treenode(FChildren[ChildIndex]);
        Exit;
      end;
    end;
  end;
  Result := nil; // Não encontrou o filho
end;

function TMi_rtl_treenode.GetNextSibling: TMi_rtl_treenode;

var
  Index: Integer;
begin
  Result := nil;
  if (FParent = nil) or (FParent.FChildren.Count = 0) then
    Exit;

  Index := FParent.FChildren.IndexOf(Self);
  if (Index >= 0) and (Index < FParent.FChildren.Count - 1) then
    Result := TMi_rtl_treenode(FParent.FChildren[Index + 1]);
end;

procedure TMi_rtl_treenode.TreeToStringList(Mi_rtl_treenode: TMi_rtl_treenode;
  var S: TStringList);
var
  FileType: string;
  i, ni: integer;
begin
  if (Mi_rtl_treenode.Data as TPath).IsSheet then
    FileType := ' (Folha)'
  else
    FileType := ' (Nó)';


  if Assigned(Mi_rtl_treenode) then
  begin
    if (Mi_rtl_treenode.Data as TPath).Data <> '' //and (Mi_rtl_treenode.GetNodeLevel()>0)
    then
    begin
      ni := Mi_rtl_treenode.GetNodeLevel;
      //if (Mi_rtl_treenode.Data as TPath).IsSheet
      //then S.add( ConstStr(ni*2,' ')+Mi_rtl_treenode.fFilePath + FileType+' '+IntToStr(Mi_rtl_treenode.GetNodeLevel))
      //else S.add( ConstStr(ni*2,' ')+Mi_rtl_treenode.fFilePath + FileType+' '+IntToStr(Mi_rtl_treenode.GetNodeLevel));

      if (Mi_rtl_treenode.Data as TPath).IsSheet then
        S.add(ConstStr(ni * 2, ' ') + (Mi_rtl_treenode.Data as TPath).Data + FileType + ' ')
      else
        S.add(ConstStr(ni * 2, ' ') + (Mi_rtl_treenode.Data as TPath).Data + FileType + ' ');

    end;
  end;


  for i := 0 to Mi_rtl_treenode.Children.Count - 1 do
  begin
    TreeToStringList(Mi_rtl_treenode.Children.Items[i] as TMi_rtl_treenode, s);
  end;

end;

procedure TMi_rtl_treenode.TreeToStringListHtml(Mi_rtl_treenode: TMi_rtl_treenode; var S: TStringList);
var
  i: integer;
begin
  s.Add('<ul>');
  s.Add('<li>');

  //if not (TreeNode.Data as TPath).IsSheet

  s.Add((Mi_rtl_treenode.Data as TPath).Data);

  for i := 0 to Mi_rtl_treenode.Children.Count - 1 do
  begin
    TreeToStringListHtml(Mi_rtl_treenode.Children.Items[i] as TMi_rtl_treenode, s);
  end;

  //if not (TreeNode.Data as TPath).IsSheet

  s.Add('</ul>');
  s.Add('</li>');
end;

class procedure TMi_rtl_treenode.Test_AddChildFileName(okListHTML: boolean);
  var
    Root: TMi_rtl_treenode;
    List: TStringList;
    S: string;
begin
  WriteLn('TMi_rtl_treenode.Test');
  WriteLn('Inicio: ===============');

  // Criação do nó raiz e inicialização da árvore
  Root := TMi_rtl_treenode.Create(TPath.Create('root', False));
  With Root do
  try
    // Adiciona os caminhos de diretórios e folhas da árvore
    AddChildFileName('/home/documentos/test1.pas');
    AddChildFileName('/home/documentos/test2.pas');
    AddChildFileName('/home/documentos/mamae/test3.pas');
    AddChildFileName('/home/documentos/test1.pas');
    AddChildFileName('/home/documentos/test2.pas');
    AddChildFileName('/home/documentos/mamae/test3.pas');
    AddChildFileName('/home/documentos/mamae/celia/test4.pas');
    AddChildFileName('test5.pas');
    AddChildFileName('/home/test6.pas');
    AddChildFileName('test5.pas');
    AddChildFileName('/home/test6.pas');

    // Exibe a árvore de diretórios
    WriteLn('Árvore de diretórios:');
    List := TStringList.Create;
    try
      if okListHTML then
        Root.TreeToStringListHtml(Root, List)
      else
        Root.TreeToStringList(Root, List);

      for S in List do
        WriteLn(S);
    finally
      List.Free;
    end;

  finally
    Root.Free;
  end;

  WriteLn('Fim: ===============');
end;

end.
