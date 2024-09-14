# Como converter a classe TException do projeto **mi.rtl**

1. **Análise para converter a classe TException**
   1. **Dependências**:
      1. Dos, Db_Global, BbUtil, BbError, Objects, App, strings, Mi_msgBox, drivers, memory,InvokeRegistry.

   2. **Notas**
      1. Como essa classe precisa da unit **mi.rtl.msgbox** então a classe **mi.rtl.tException** deve ser herdada da classe **TObjectss**.
      2. Como ela precisa da unit **bbError.pas** eu preciso criar primeiro:
         1. ok - Transferir as contantes de erros do sistema para a classe **mi.rtl.consts**;
         2. Criar a classe **mi.rtl.files.logs** com os métodos:
            1. Function WriteFErr(Const S : AnsiString):SmallInt;
            2. Function WriteLnFErr(Const S : AnsiString):SmallInt;
            3. Function _Write(Var FOutput : Text;Const S : AnsiString;Ln:Boolean):SmallInt;
            4. procedure LogError(const s : AnsiString);
            5. Function FOpenFerr(aFileName:PathStr):SmallInt;
            6. Function Create_Ferr (aFileName:PathStr):SmallInt;
            7. Procedure Close_Ferr;
            8. PROCEDURE Destroy_Ferr ;
            9. Function MessageIoResut(Const aFileName:PathStr;Const Error:SmallInt):SmallWord;
            10. Function IoErrorExtendido:Integer;
            11. Function CopyFerrToSevidor(Const FileNameFont:PathStr;FileNameDest:PathStr):SmallInt;
            12. PROCEDURE BBExit (StackFrame : SmallWord);FAR;
  
