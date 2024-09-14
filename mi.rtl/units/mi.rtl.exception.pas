unit mi.rtl.Objects.Methods.Exception;
{:< -A unit **@name** implementa a classe TException do pacote mi.rtl.

    - **VERSÃO**:
      - Alpha - 1.0.0

    - **CÓDIGO FONTE**:
      - @html(<a href="../units/mi.rtl.objects.texception.pas">mi.rtl.objects.texception.pas</a>)

    - **HISTÓRICO**
      - Criado por: Paulo Sérgio da Silva Pacheco e-mail: paulosspacheco@@yahoo.com.br
        - 2021-12-14
          - 11:00 a 11:30 - Criado a unit **@name** e implementação da classe **TException**

        - 2021-12-15
          - 15:00 a 18:42 - T12 Criar a classe TException
          - 21:25 a 22:40 - Troquei o nome de constructor create para que fique equivalente as mensagem de TStrError.ErrorMessage.


}
{$IFDEF FPC}
  {$MODE Delphi} {$H+}
{$ENDIF}

interface

uses
  Classes, SysUtils,
  mi.rtl.Consts.StrError
  ,mi.rtl.objects.Methods

  ;

type
  {TException}
  {: - A classe  **@name** é usada com a palavra reservada **raise** para mostrar o erro, sua localização e em seguida salva no dispositivo definido em **TObjectss.Logs.LogType**.

     - **NOTA**
       - LogType = TLogType = (ltSystem,ltFile,ltStdOut,ltStdErr);
         - ltSystem = Arquivo definido pelo sistema operacional;
         - ltFile = Arquivo definido pela aplicação;
         - ltStdOut,ltStdErr = Terminal do sistema operacional.

     - **EXEMPLO DE USO**:

       ```pascal

         procedure TMi_Rtl_Tests.Action_test_TExceptionExecute(Sender: TObject);
         begin
           with TMI_ui_types do begin
             logs.EnableWriteIdentificao := true;
             try
               raise TException.Create(5);
             except
             end;

             try
               raise TException.Create('Acesso ao arquivo negado');
             except
             end;

             try
               raise TException.Create(Self, 'Action_test_TExceptionExecute','aFileName','AFieldName',5);
             except
             end;

             try
               raise TException.Create(Self, 'Action_test_TExceptionExecute','aFileName','AFieldName','Acesso ao arquivo negado');
             except
             end;


             try
               raise TException.Create(Self, 'Action_test_TExceptionExecute',5);
             except
             end;

             try
               raise TException.Create(Self, 'Action_test_TExceptionExecute','Acesso ao arquivo negado');
             except
             end;


         // Os exemplos abaixo são mantidos para manter a compatibilidade com o passado.


              try
                raise TException.Create4('aModule', 'aUnit', 'Procedure_or_Function',   'ParamResult');
              except
              end;

              try
                raise TException.Create4('aModule', 'aUnit', 'Procedure_or_Function',   5);
              except
              end;

              try
                raise TException.Create5('aModule', 'aUnit','ObjectName', 'aMethodName',   'aMsgError');
              except
              end;

              try
                raise TException.Create5('aModule', 'aUnit','ObjectName', 'aMethodName',   5);
              except
              end;

              try
                raise TException.Create6('aModule', 'ObjectName', 'aMethodName','aFileName','AFieldName', 5);
              except
              end;

              try
                raise TException.Create7('aModule', 'aUnit','ObjectName', 'aMethodName','aFileName','AFieldName',  5);
              except
              end;

              try
                raise TException.Create7('aModule', 'aUnit','ObjectName', 'aMethodName','aFileName','AFieldName',  'ParamResult');
              except
              end;

              try
                raise TException.Create8('aModule', 'aUnit','ObjectName', 'aMethodName','aFileName','AFieldName',  'aMessage','aProcedure_or_Function');
              except
              end;
            end;
         end;

       ```
  }
//  TException = class(TObjectsMethods)
    TException = class(Exception)
    private
      FMessage: AnsiString;
//      FHelpContext: Integer;
    public
      property Message: Ansistring read FMessage write FMessage;
      constructor Create(const Msg: Ansistring);Overload;
      constructor Create(const aCodError:SmallInt);Overload;
      constructor Create(const Sender: TObject;Const aMethodName, aFileName, AFieldName:AnsiString;aCodError:integer );Overload;
      constructor Create(const Sender: TObject;Const aMethodName, aFileName, AFieldName:AnsiString;aMsg:AnsiString);Overload;
      constructor Create(const Sender: TObject;Const aMethodName:AnsiString;aCodError:SmallInt );Overload;
      constructor Create(const Sender: TObject;Const aMethodName:AnsiString;aMsg:AnsiString );Overload;

      constructor Create4(Const aModule,
                                aUnit,
                                Procedure_or_Function,
                                aMessage:AnsiString);Overload;

      constructor Create4(Const aModule,
                               aUnit,
                               Procedure_or_Function:AnsiString;
                               aCodError:SmallInt);Overload;

      constructor Create5(aModule,
                           aUnit,
                           aObjectName,
                           aMethodName :AnsiString;
                           aCodError:SmallInt);Overload;

      constructor Create5(aModule,
                           aUnit,
                           aObjectName,
                           aMethodName :AnsiString;
                           aMsgError:AnsiString);Overload;

      constructor Create6(aModule,
                           aObjectName,
                           aMethodName,
                           aFileName,
                           AFieldName:AnsiString;
                           aCodError:SmallInt);Overload;

      constructor Create7(aModule,
                         aUnit,
                         aObjectName,
                         aMethodName,
                         aFileName,
                         AFieldName:AnsiString;
                         aCodError:SmallInt);Overload;
      constructor Create7(aModule,
                         aUnit,
                         aObjectName,
                         aMethodName,
                         aFileName,
                         AFieldName:AnsiString;
                         aMessage:AnsiString);Overload;
      constructor Create8(aModule,
                           aUnit,
                           aObjectName,
                           aMethodName,
                           aFileName,
                           AFieldName,
                           aMessage,
                           aProcedure_or_Function :AnsiString);Overload;
    end;

implementation

    constructor TException.Create(const Msg: Ansistring);
    Begin
      TObjectsMethods.CTRL_SLEEP_ENABLE := true;
      Inherited Create(Msg);
      Message := Msg;
      Try
         TObjectsMethods.LogError(Message);
      Except
      end;
      TObjectsMethods.SysMessageBox(Message,'TException.Create',true);
    end;

    constructor TException.Create(const aCodError:SmallInt);
      var
        s:ansiString;
    Begin
      TObjectsMethods.CTRL_SLEEP_ENABLE := true;
      s := tstrerror.ErrorMessage(TObjectsMethods.TaStatus);
      Inherited Create(s);
      Message := s;
      TObjectsMethods.TaStatus := aCodError;


      Try
         TObjectsMethods.LogError(Message);
      Except
      end;

      TObjectsMethods.SysMessageBox(Message,'TException.Create',true);

    end;

    constructor TException.Create(const Sender: TObject; const aMethodName, aFileName, AFieldName: AnsiString; aCodError: integer);
      var
        s : AnsiString;
    begin
      TObjectsMethods.CTRL_SLEEP_ENABLE := true;
      s := tstrerror.ErrorMessage7('',
                                sender.UnitName,
                                sender.ClassName,
                                aMethodName,
                                aFileName,
                                AFieldName,
                                aCodError
                                );
      Inherited Create(S) ;
      Message := s;

      TObjectsMethods.LogError(Message);
      TObjectsMethods.SysMessageBox(Message,'TException.Create',true);
    end;

    constructor TException.Create(const Sender: TObject; const aMethodName,   aFileName, AFieldName: AnsiString; aMsg: AnsiString);
      var
        s : AnsiString;
    begin
      TObjectsMethods.CTRL_SLEEP_ENABLE := true;
      s := tstrerror.ErrorMessage7('',
                                sender.UnitName,
                                sender.ClassName,
                                aMethodName,
                                aFileName,
                                AFieldName,
                                aMsg
                                );
      Inherited Create(s) ;
      Message := s;

      TObjectsMethods.LogError(Message);
      TObjectsMethods.SysMessageBox(Message,'TException.Create',true);
    end;

    constructor TException.Create(const Sender: TObject; const aMethodName: AnsiString; aCodError: SmallInt);
    begin
      Create(Sender,aMethodName, '', '', aCodError);
    end;

    constructor TException.Create(const Sender: TObject; const aMethodName: AnsiString; aMsg: AnsiString);
    begin
      Create(Sender,aMethodName, '', '', aMsg);
    end;

    constructor TException.Create4(const aModule, aUnit, Procedure_or_Function,   aMessage: AnsiString);
      var
        s : ansiString;
    Begin
      TObjectsMethods.CTRL_SLEEP_ENABLE := true;
      If TObjectsMethods.TaStatus = 0
      Then TObjectsMethods.TaStatus := TObjectsMethods.Erro_Excecao_inesperada;
      s := tstrerror.ErrorMessage4(aModule,
                                         aUnit,
                                         Procedure_or_Function,
                                         aMessage);
      Inherited Create(s);
      Message := s;
      TObjectsMethods.LogError(tstrerror.ErrorMessage(TObjectsMethods.TaStatus));
      TObjectsMethods.LogError(Message);
      TObjectsMethods.SysMessageBox(Message,'TException.Create4',true);
    End;

    constructor TException.Create4(const aModule, aUnit, Procedure_or_Function: AnsiString; aCodError: SmallInt);
      var
        s : AnsiString;
    Begin
      TObjectsMethods.CTRL_SLEEP_ENABLE := true;
      s := tstrerror.ErrorMessage4(aModule,
                                aUnit,
                                Procedure_or_Function,
                                aCodError);
      Inherited Create(s);
      TObjectsMethods.TaStatus := aCodError;
      Message := s;
      TObjectsMethods.LogError(Message);
      TObjectsMethods.SysMessageBox(Message,'TException.Create4',true);
    End;

    constructor TException.Create5(aModule, aUnit, aObjectName,   aMethodName: AnsiString; aMsgError: AnsiString);
      var
        s : AnsiString;
    begin
      TObjectsMethods.CTRL_SLEEP_ENABLE := true;

      s:= tstrerror.ErrorMessage5(aModule,
                                         aUnit,
                                         aObjectName,
                                         aMethodName,
                                         aMsgError);
      Inherited Create(s) ;

      Message := s;

      TObjectsMethods.LogError(Message);
      TObjectsMethods.SysMessageBox(Message,'TException.Create5',true);
    end;

    constructor TException.Create5(aModule, aUnit, aObjectName,   aMethodName: AnsiString; aCodError: SmallInt);
      var
        s : AnsiString;
    begin
      TObjectsMethods.CTRL_SLEEP_ENABLE := true;

      s := tstrerror.ErrorMessage5(aModule,
                                   aUnit,
                                   aObjectName,
                                   aMethodName,
                                   aCodError);
      Inherited Create(s) ;

      TObjectsMethods.TaStatus := aCodError;
      Message := s;

      TObjectsMethods.LogError(Message);
      TObjectsMethods.SysMessageBox(Message,'TException.Create5',true);
    end;

    constructor TException.Create6(aModule,aObjectName,aMethodName,aFileName,AFieldName:AnsiString;aCodError:SmallInt);Overload;
      var
        s : AnsiString;
    begin
       TObjectsMethods.CTRL_SLEEP_ENABLE := true;

       s := tstrerror.ErrorMessage6(aModule,
                                  aObjectName,
                                  aMethodName,
                                  aFileName,
                                  AFieldName,
                                  aCodError);
       Inherited Create(s) ;
       TObjectsMethods.TaStatus := aCodError;
       Message := s;
       TObjectsMethods.LogError(Message);
       TObjectsMethods.SysMessageBox(Message,'TException.Create6',true);
    end;

    constructor TException.Create7(aModule,aUnit,aObjectName,aMethodName,aFileName,AFieldName:AnsiString;aCodError:SmallInt);
      var
        s : AnsiString;
    Begin
      TObjectsMethods.CTRL_SLEEP_ENABLE := true;

      s := tstrerror.ErrorMessage7(aModule,
                                aUnit,
                                aObjectName,
                                aMethodName,
                                aFileName,
                                AFieldName,
                                aCodError);
      Inherited Create(s) ;

      TObjectsMethods.TaStatus := aCodError;

      Message := s;

      TObjectsMethods.LogError(Message);
      TObjectsMethods.SysMessageBox(Message,'TException.Create7',true);
    End;

    constructor TException.Create7(aModule,aUnit,aObjectName,aMethodName,aFileName,AFieldName:AnsiString;aMessage:AnsiString);
      var
        s : AnsiString;
    Begin
      TObjectsMethods.CTRL_SLEEP_ENABLE := true;

      s := tstrerror.ErrorMessage7(aModule,
                                aUnit,
                                aObjectName,
                                aMethodName,
                                aFileName,
                                AFieldName,
                                aMessage);
      Inherited Create(s);
      Message := s;

      TObjectsMethods.LogError(Message);
      TObjectsMethods.SysMessageBox(Message,'TException.Create7',true);
    End;

    constructor TException.Create8(aModule, aUnit, aObjectName, aMethodName, aFileName,  AFieldName, aMessage, aProcedure_or_Function: AnsiString);
      var
        s: AnsiString;
    begin
      TObjectsMethods.CTRL_SLEEP_ENABLE := true;

      s := tstrerror.ErrorMessage8(aModule,
                                aUnit,
                                aObjectName,
                                aMethodName,
                                aFileName,
                                AFieldName,
                                aMessage,
                                aProcedure_or_Function
                                );
      Inherited Create(s) ;

      Message := s;

      TObjectsMethods.LogError(Message);
      TObjectsMethods.SysMessageBox(Message,'TException.Create8',true);
    end;


end.

