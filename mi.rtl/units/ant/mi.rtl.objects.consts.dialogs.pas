unit mi.rtl.objects.consts.dialogs;
  {:< -A unit **@name** implementa a classe TDialogs do pacote mi.rtl.

      - **VERSÃO**:
        - Alpha - 0.5.0.687

      - **CÓDIGO FONTE**:
        - @html(<a href="../units/mi.rtl.dialogs.pas">mi.rtl.Dialogs.pas</a>)

      - **HISTÓRICO**
        - Criado por: Paulo Sérgio da Silva Pacheco e-mail: paulosspacheco@@yahoo.com.br
          - 2021-12-02
            -22:15 a 23:00 - Criado a unit **@name** e implementação da classe **TDialogs**
  }
  {$IFDEF FPC}
    {$MODE Delphi} {$H+}
  {$ENDIF}


  interface

  uses
    Classes, SysUtils
    ,System.UITypes

    ,mi.rtl.interfaces
    ,mi.rtl.objects.consts
    ,mi.rtl.Consts.StrError;

  type
    {: - A classe **@name** é uma classe abstrata usada como base para contrução de mensagens para o usuário.

       - **NOTA**
         - A implementação da mesma deve ser feita no pacote mi.iu.dialogs;
         - A versão inicial irá usar os componentes **Lazarus** porque o mesmo está implementado em várias plataformas.
    }
    TDialogs = class({TInterfacedObject}TObjectsConsts,IDialogs)
      public type
        // Message dialog related
        TMsgDlgType = System.UITypes.TMsgDlgType;
        TMsgDlgBtn  = System.UITypes.TMsgDlgBtn;
        TMsgDlgButtons = System.UITypes.TMsgDlgButtons;

        // ModalResult
        TModalResult = System.UITypes.TModalResult;
        PModalResult = System.UITypes.PModalResult;

      const
        // Used for ModalResult
        mrNone = System.UITypes.mrNone;
        mrOK = System.UITypes.mrOK;
        mrCancel = System.UITypes.mrCancel;
        mrAbort = System.UITypes.mrAbort;
        mrRetry = System.UITypes.mrRetry;
        mrIgnore = System.UITypes.mrIgnore;
        mrYes = System.UITypes.mrYes;
        mrNo = System.UITypes.mrNo;
        mrAll = System.UITypes.mrAll;
        mrNoToAll = System.UITypes.mrNoToAll;
        mrYesToAll = System.UITypes.mrYesToAll;
        mrClose = System.UITypes.mrClose;
        mrLast = System.UITypes.mrLast;

        // String representation of ModalResult values
        ModalResultStr: array[mrNone..mrLast] of shortstring = (
          'mrNone',
          'mrOk',
          'mrCancel',
          'mrAbort',
          'mrRetry',
          'mrIgnore',
          'mrYes',
          'mrNo',
          'mrAll',
          'mrNoToAll',
          'mrYesToAll',
          'mrClose');

      type TStrError = mi.rtl.Consts.StrError.TStrError;

      protected owner : TObjectsConsts;

      public constructor Create (aOwner:TObjectsConsts);Overload;Virtual;

      {: - A procedure **@name** executa um diálogo com dois botões: **OK** e **Cancel**
      }
      public Procedure Alert(aTitle: AnsiString;aMsg:AnsiString);  virtual;

      {: - A função **@name** executa um diálogo fazendo uma pergunta com os botões **OK** e **Cancel**.

         - **RETORNA:**
           - **True** : Se o botão **OK** foi pressionado;
           - **False** : Se o botão **Cancel** foi pressionado.
      }
      public Function Confirm(aTitle: AnsiString;aPergunta:AnsiString):Boolean;virtual;

      {: - A função **@name** mostra um diálogo com dois botões **OK** e **Cancel** e uma entrada de dados solicitando
           que o usuário digite um valor.

         - **RETORNA:**
           - **True** : Se o botão **ok** foi pressionado;
           - **False** : Se o botão **cancel** foi pressionado.
           - **aResult** : Retorna a string digitada no formulário;
      }
      public Function Prompt(aTitle: AnsiString;aPergunta:AnsiString;Var aResult: AnsiString):Boolean;virtual;

      {: - A função **@name** mostra um diálogo para receber um valor sem mostrar o que foi digitado.
           O formulário possui dois botões **OK** e **Cancel**

         - **RETORNA:**
           - **True** : Se o botão **ok** foi pressionado;
           - **False** : Se o botão **cancel** foi pressionado.
           - **apassword** : Retorna a string com a senha do usuário.
      }
      Function GetPassword(aTitle: AnsiString;
                           var apassword:AnsiString):Boolean;Overload;Virtual;

      {: - A função **@name** mostra um diálogo solicitando o login do usuário e a senha  e dois botões: **OK**
           e **Cancel**

         - **RETORNA:**
           - **True** : Se o botão **ok** foi pressionado;
           - **False** : Se o botão **cancel** foi pressionado.
           - **aUsername** : Retorna a string com nome do usuário.
           - **apassword** : Retorna a string com a senha do usuário.
      }
      Function GetPassword(aTitle: AnsiString;
                           var aUsername:AnsiString;
                           var apassword:AnsiString):Boolean;Overload;virtual;

    end;


implementation

  { TDialogs }

  constructor TDialogs.Create(aOwner: TObjectsConsts);
  begin
    inherited create(aOwner);
    owner := aOwner;
  end;

  procedure TDialogs.Alert(aTitle: AnsiString; aMsg: AnsiString);
  begin
   raise EArgumentException.Create(TStrError.ErrorMessage5('mi.rtl','mi.rtl.Dialogs','TDialogs','Alert',211 ));
  end;

  function TDialogs.Confirm(aTitle: AnsiString; aPergunta: AnsiString): Boolean;
  begin
    raise EArgumentException.Create(TStrError.ErrorMessage5('mi.rtl','mi.rtl.Dialogs','TDialogs','Confirm',211 ));
  end;

  function TDialogs.Prompt(aTitle: AnsiString; aPergunta: AnsiString; var aResult: AnsiString): Boolean;
  begin
    raise EArgumentException.Create(TStrError.ErrorMessage5('mi.rtl','mi.rtl.Dialogs','TDialogs','Prompt',211 ));
  end;

  function TDialogs.GetPassword(aTitle: AnsiString; var apassword: AnsiString
    ): Boolean;
  begin
   raise EArgumentException.Create(TStrError.ErrorMessage5('mi.rtl','mi.rtl.Dialogs','TDialogs','GetPassword',211 ));
  end;

  function TDialogs.GetPassword(aTitle: AnsiString; var aUsername: AnsiString; var apassword: AnsiString): Boolean;
  begin
    raise EArgumentException.Create(TStrError.ErrorMessage5('mi.rtl','mi.rtl.Dialogs','TDialogs','GetPassword',211 ));
  end;

end.

