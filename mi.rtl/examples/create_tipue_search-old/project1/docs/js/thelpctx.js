//A Class ThelpCtx é usada como base a criação de classes que necessitem de documentos.
// Data: 30/10/2020

 class THelpCtx  {
    
  constructor(aOwner,aAlias) {  
     var tOwner = THelpCtx;
     this.Owner =  tOwner;
    
     this.Owner = aOwner; 
     this.alias = aAlias;
    
     this.HelpCtx_Historico = ''; //O atribuito HelpCtx_Historico armazena um texto indicativo da alterações do documento
     this.HelpCtx_Porque = '';    //O atribuito HelpCtx_Porque armazena porque este documento é necessário
     this.HelpCtx_Onde = '';      //O atribuito HelpCtx_Onde armazena onde este documento é usado
     this.HelpCtx_Como = '';      //O atributo HelpCtx_Como armazena como este documento é usado
     this.HelpCtx_Quais = '';     // O atribuito HelpCtx_Quais armazena um texto indicativo de onde este documento será usado
     this.HelpCtx_Hint = '';      //Criação da propriedade HelpCtx_Hint 
       
    
   }
 
 } 
 
 class THelpCtxModule {
   constructor(aOwner) {    
     this.owner = aOwner;       //Criação do atributo HelpCtx_StrModule armazena o Nome do Módulo que está utilizando esta classe.
     this.HelpCtx_StrModule = '';    
     this.HelpCtx_StrCommand = ''; //O atribuito HelpCtx_StrCommand. Obs: Nome do comando que está utilizando esta classe.      
     this.HelpCtx_StrCommand_Topic = ''; //Criação da propriedade HelpCtx_StrCommand_Topic
     //Criação da propriedade HelpCtx_StrCurrentModule. Obs: Corrente módulo em execução independente do módulo da classe.
     this.HelpCtx_StrCurrentModule ='';   //&lsaquo; Nortsoft Obs: Ao criar o objeto inicializa com Db_Global.StrCurrentModule
     //Criação da propriedade HelpCtx_StrCurrentCommand
     this.HelpCtx_StrCurrentCommand = ''; //&lsaquo; Nortsoft Obs: Ao criar o objeto inicializa com Db_Global.StrCurrentCommand
     //criação da propriedade HelpCtx_StrCurrentCommand_Opcao
     this.HelpCtx_StrCurrentCommand_Opcao = ''; //&lsaquo; Nome da opcao ativa dentro do comando      
     this.HelpCtx_StrCurrentCommand_Topic = ''; //Criação da propriedade HelpCtx_StrCurrentCommand_Topic      
     this.HelpCtx_StrCurrentCommand_Topic_Content = ''; //Criação da propriedade HelpCtx_StrCurrentCommand_Topic_Content      
   }  
     
 }
  
 class NomeDoAluno extends THelpCtx {
     constructor(aOwner,aNameAluno){    
       super (aOwner);
       this.alias = 'Nome do Aluno';      
       this.NameAluno = aNameAluno;
       
       //Logger.log("Alias da class:"+this.alias);
       //Logger.log("Nome do Aluno.:"+this.NameAluno);
     }
      
  } 
 
  function testAluno(){
    var nomeDoAluno = new NomeDoAluno(null,'Paulo');  
    
    return nomeDoAluno.alias;
    //return "Teste Aluno"
  }         

      
  class SalaDeAula extends THelpCtx {
    constructor(aOwner,aNomeDaSalaDeAula){    
    super (aOwner,aNomeDaSalaDeAula);
    }
  }

  function testSalaDeAula() {
    var sa = new TSalaDeAula(null, "Quinta Serie");
    return sa.alias ; 
  } 

  
  class TSalaDeAula extends THelpCtx {
    constructor(aNomeDaSalaDeAula){    
    super (document,aNomeDaSalaDeAula); //Obs: A chamada super(null, aNomeDaSalaDeAula) gera exceção
   } 
  }

  function testTSalaDeAula() {
    var sa = new TSalaDeAula("Quinta Serie");
    return sa.alias ; 
  }
 

