unit mi_rtl_ui_DmxScroller_Buttons;
{:< A unit **@name** implementa a classe TUiDmxScroller_Buttons.

  - **VERSÃO**
    - Alpha - 0.5.0.693

  - **CÓDIGO FONTE**:
    - @html(<a href="../units/mi_rtl_ui_dmxscroller_buttons.pas">mi_rtl_ui_DmxScroller_Buttons.pas</a>)

    - **PENDÊNCIAS**

    - **CONCLUÍDO**
      - Criar classe TUiDmxScroller_Buttons ✅️
      - Criar constructor Create.✅️
      - Criar Function Create_RCommands. ✅️
      - Commands_Buttons_High : Byte; ✅️
      - Commands_Buttons      : Array[0..Max_List_Buttons] of TRCommand; ✅️
      - Max_List_Buttons = sizeof(Longint); ✅️
      - Commands_Buttons_Mb   : Longint; ✅️
      - Function  Add_RCommands_Buttons;  ✅️
      - Function  Create_RCommands_Buttons; ✅️
      - Function  Set_Commands_Buttons_Mb(Const aMb_Bits:Longint):Longint;✅️

      - Documentar os atributos abaixo:    ️
        - Commands_Buttons_High : Byte; ✅️
        - Commands_Buttons      : Array[0..Max_List_Buttons] of TRCommand; ✅️


    - **HISTÓRICOS**
      - **DIAS ANTERIORES**
          - @html(<a href="../units/mi_rtl_ui_dmxscroller_buttons_historico.md">./mi_rtl_ui_DmxScroller_Buttons_historico.md </a>)

      - **DO DIA**
        - **2022-07-07**
          - **09:45**
            - Documentar o método **Add_RCommands_Buttons**
          - **14:55**
            - Documentar o método **Add_RCommands_Buttons**
}

{$mode Delphi}{$H+}

interface

uses
  Classes, SysUtils
  ,mi_rtl_ui_methods
  ,mi_rtl_ui_Dmxscroller;

type
  { TUiDmxScroller_Buttons }
  {: A classe **@name** tem como objetivo registrar os dados necessários para criar os
     botões de navegação e edição de uma tabela quando TDataSource for <> nil.


     - **EXEMPLO USO**

        ```pascal

        ```
  }
  TUiDmxScroller_Buttons = class(TUiMethods)

    {: O atributo **@name** deve ser passado em constructor create}
    public UiDmxScroller : TUiDmxScroller;

    {: O construtor **@name** é usado para iniciar o atributo **_UiDmxScroller** com o cast
       (aOwner as TUiDmxScroller)}
    public constructor Create(aOwner:TComponent);Override;

    {: O atributo **@name** indica se o registro pode ser incluído ou não,
     ou seja: é o estado inicial da ação incluir informada pelo usuário.

     - **NOTA**
       - True : O registro pode ser incluído. Obs: DataSet.Append pode ser executado.
       - False: O registro não pode ser incluído. Obs: DataSet.Append não pode ser executado.
       - Esse atributo é usado nos seguintes métodos:
         - Create_RCommands_Edit
         - No método DoOnNewRecord
         - Action Novo

     - **EXEMPLO**

         ```pascal
           // Tirado do código: Function TRecord.Create_RCommands_Edit

           OkCmmNewRecord := Application.FileOptions_CommandEnabled(Module,aCmNovo);
           if aCmNovo<=255 then
             if OkCmmNewRecord
             then Application.EnableCommands([aCmNovo])
             Else Application.DisableCommands([aCmNovo]);

         ```

  }
    Public Var OkCmmNewRecord    : boolean;

    {: O atributo **@name** indica se o registro pode ser localizado ou não,
       ou seja: é o estado inicial da ação **pesquisar** informada pelo usuário.

       - **NOTA**
         - True : O registro pode ser pesquisado. DataSet.Locate pode ser executado.
         - False: O registro não pode ser pesquisado. DataSet.Locate não pode ser executado.
         - Esse atributo é usado nos seguintes métodos:
           - Create_RCommands_Edit
           - No método DoOnNewRecord
           - Action Pesquisa

       - **EXEMPLO**

           ```pascal
             // Tirado do código: Function TRecord.Create_RCommands_Edit

             if OkCmmNewRecord or OkCmmEvaluateRecord or OkCmmZeroizeRecord
             then begin
                    self.OkCmmDbLocaliza := true;
                    self.Locked := false;
                  end
             else begin
                     self.OkCmmDbLocaliza := Application.FileOptions_CommandEnabled(Module,ACmLocaliza);
                     self.Locked := True;
                   end;
           ```
    }
    Public Var OkCmmDbLocaliza   : boolean;

    {: O atributo **@name** indica se o registro pode ser alterado ou não,
       ou seja: é o estado inicial da ação alterar informada pelo usuário.

       - **NOTA**
         - True : O registro pode ser alterado. Obs: DataSet.Post pode ser executado.
         - False: O registro não pode ser alterado. Obs: DataSet.Post não pode ser executado.
         - Esse atributo é usado nos seguintes métodos:
           - Create_RCommands_Edit
           - No método DoUpdateRec
           - Action Novo

       - **EXEMPLO**

           ```pascal
              // Tirado do código: Function TRecord.Create_RCommands_Edit

              OkCmmEvaluateRecord := Application.FileOptions_CommandEnabled(Module,aCmAlteracao);
              if aCmAlteracao<=255 then
                if OkCmmEvaluateRecord
                then Application.EnableCommands([aCmAlteracao])
                Else Application.DisableCommands([aCmAlteracao]);

           ```

    }
    private OkCmmEvaluateRecord : Boolean; {Estado inicial. true=abilitado ou nao=desabilitado}

    {: O atributo **@name** indica se o registro pode ser excluído ou não,
       ou seja: é o estado inicial da ação excluir informada pelo usuário.

       - **NOTA**
         - **True** : O registro pode ser deletado.
         - **False**: O registro não pode ser deletado.
         - Esse atributo é usado nos seguintes métodos:
           - Create_RCommands_Edit
           - Nos métodos DeleteRec
           - Action Delete

       - **EXEMPLO**

           ```pascal
             // Tirado do código: Function TRecord.Create_RCommands_Edit

             OkCmmZeroizeRecord  := Application.FileOptions_CommandEnabled(Module,ACmExclusao);
             if ACmExclusao<=255 then
               if OkCmmZeroizeRecord
               then Application.EnableCommands([ACmExclusao])
               Else Application.DisableCommands([ACmExclusao]);

           ```

    }
    Public Var OkCmmZeroizeRecord: boolean;

    {: Atributo da propriedade Commands_Buttons_High}
    private _Commands_Buttons_High : Byte;

    {: A propriedade **@name** contém o número de linhas inicializadas da matriz **Commands_Buttons**,
       ou seja: é igual o número de linhas criadas em: **Create_RCommands_Buttons**.
    }
    Public Property Commands_Buttons_High : Byte Read _Commands_Buttons_High;

    {: A constante **@name** contém o número máximo de comandos da matriz Commands_Buttons}
    public Const Max_List_Buttons = sizeof(Longint)*8;

    {: O atributo **@name** contém os dados necessários para criar os botões de ações
       da classe de acesso a arquivos.

       - **EXEMPLO DE USO DESTA MATRIZ**

         ```pascal
            Commands_Buttons[1] := Create_RCommand(CmOk,'Ok'  ,'',KbEnter,AHelpCtx,Flag)^;
            Commands_Buttons[2] := Create_RCommand(CmOk,'Next','',Kbno   ,AHelpCtx,Flag)^;
         ```
    }
    Public Commands_Buttons      : Array[0..Max_List_Buttons] of TRCommand; {Comandos disponiveis}

    {$Region Propriedade Commands_Buttons_Mb}
      private _Commands_Buttons_Mb   : Longint;

      {: O atributo **@name** contém o mapa de bits dos botões que serão criados no formulário.


         - **NOTA**
           - O mapa de bits é do tipo longint (4 bytes) por isso pode conter no máximo
             (4x8=32) botões.
      }
      Public property Commands_Buttons_Mb  : Longint read _Commands_Buttons_Mb;

    {$EndRegion Propriedade Commands_Buttons_Mb}

    {: O Método **@name** seta _Commands_Buttons_Mb e retorna o mapa de bits
       **Commands_Buttons_Mb** anterior.

       **EXEMPLO DE USO**

         ```pascal

           //*** Seta as propriedades do fornecedor ***
           With ArqFornecedor do
           Begin
             Alias := sgc('Parâmetros para pesquisa de duplicatas');
             SetExpandable(False); //Não permite Inclusões
             SetLocked(False); //false = Não travado porque a janela filha pode ser alterada e expandida
             SetOkWriteRec(False);  //Desabilita a alteração.
             Set_Commands_Buttons_Mb(Mb_Cm_Bof_Prev_Next_Eof);
           end;


         ```
    }
    public  Function  Set_Commands_Buttons_Mb(Const aMb_Bits:Longint):Longint;

    {: O método **@name** é usado para iniciar os elementos da matriz **Commands_Buttons**

       - **EXEMPLO E USO**

         ```pascal

           Function Create_RCommands_Buttons(Var aCommands : Array of TRCommand):SmallWord;
           Begin
             If High(aCommands) < 2
             Then Raise TException.Create(self,'Create_RCommands_Buttons()',ParametroInvalido);

             Create_RCommand('CmDbGoBof'  ,CmDbGoBof   ,'&Inicio'   ,'',kbNoKey,0,0,Mb_Cm_Bof   ,bfNormal ,aCommands[1]);
             Create_RCommand('CmDbPrevRec',CmDbPrevRec ,'&Anterior' ,'',kbNoKey,0,0,Mb_Cm_Prev  ,bfNormal ,aCommands[2]);

           end;
         ```
    }
    public Procedure Create_RCommand (Const aStrCommand:tString;
                                      Const aName,aParam :AnsiString;
                                      Const aKeyCode:Word;
                                      Const aAHelpCtx:Word;
                                      Const aFlag : Byte; {1= Opção Desabilitada; 0 = Opção habilitada }
                                      Const aMb_Bits  : Longint; {Mapa de Bits deste comando}
                                      Const aFlags_Buttons   : Byte; {BfNormal.. etc. The following button flags are defined:}
                                      var
                                        RCommand_Temp : TRCommand
                                     );

    {: O método **@name** retorna em **aCommands** a matriz aberta de TRCommand e em **result**
       retorna o número de elementos adicionados em **aCommands**.

       - **EXEMPLO E USO**

         ```pascal

             Var
               Commands_Buttons_High : Byte; //Numero de comandos de Commands
               Commands_Buttons      : Array[0..Max_List_Buttons] of TRCommand;
            Begin
              Commands_Buttons_High := Create_RCommands_Buttons(Commands_Buttons);
            end;

         ```
    }
    protected Function Create_RCommands_Buttons(aCmNovoStr:AnsiString;aCmAlteracaoStr:AnsiString;aCmExclusaoStr:AnsiString;ACmLocalizaStr:AnsiString):Word;overload;Virtual;

    {: O método **@name** adiciona um botão na posição Commands_Buttons[Commands_Buttons_High+1]. 
    }
    function  Add_RCommands_Buttons(aStrCommand: tString;
                                    aName: AnsiString;
                                    aParam: tString;
                                    aKeyCode: Word;
                                    aAHelpCtx: Word;
                                    aState: Byte;
                                    aFlags_Buttons: Byte): Longint;

    {:O método **@name** retorna a soma do número de caracteres do campo **TRCommand.name**
      dos botões ativos }
    protected Function Length_Button_Name_Actives:Smallint;

    {: O método **@name** retorna a posição na matriz Commands_Buttons do mapa de bit
     passado por aMb_Bits.

       - **Nota**
         - A posição deve ser a mesma do Mapa: _Commands_Buttons_Mb
    }
    public Function  Get_Commands_Mb_i(Const aMb_Bits:Longint):Longint;

    {: Retorna o nome do comando passado per aMb_Bits.}
    public Function  Get_Commands_Mb_StrCommand(Const aMb_Bits:Longint):AnsiString;

  end;

implementation

{ TUiDmxScroller_Buttons }

constructor TUiDmxScroller_Buttons.Create(aOwner: TComponent);
begin
  inherited Create(aOwner as TUiDmxScroller);
  UiDmxScroller := aOwner as TUiDmxScroller

end;

procedure TUiDmxScroller_Buttons.Create_RCommand(const aStrCommand: tString;
                            const aName, aParam: AnsiString; const aKeyCode: Word;
                            const aAHelpCtx: Word; const aFlag: Byte; const aMb_Bits: Longint;
                            const aFlags_Buttons: Byte; var RCommand_Temp: TRCommand);
Begin
  FillChar(RCommand_Temp,sizeof(RCommand_Temp),0);
  With RCommand_Temp
  do Begin
       StrCommand    := aStrCommand;
       Name          := aName;
       Param         := aParam;
       KeyCode       := KeyCode;
       AHelpCtx      := aAHelpCtx;
       State         := aFlag;//1=Opcao Desabilitada; 0 = Opcao abilitada
       Mb_Bits       := aMb_Bits;//Mapa de Bits deste comando
       Flags_Buttons := aFlags_Buttons; //BfNormal.. etc. The following button flags are defined:
  End;
End;


function TUiDmxScroller_Buttons.Create_RCommands_Buttons(aCmNovoStr     : AnsiString;
                                                         aCmAlteracaoStr: AnsiString;
                                                         aCmExclusaoStr : AnsiString;
                                                         ACmLocalizaStr : AnsiString): Word;
  //Inicializacao da lista de buttões controles dos registros do banco dados
Begin
  if aCmNovoStr = ''
  then aCmNovoStr := 'CmNewRecord';

  if aCmAlteracaoStr = ''
  then aCmAlteracaoStr := 'CmEvaluateRecord' ;

  if aCmExclusaoStr = ''
  then aCmExclusaoStr := 'CmZeroizeRecord';

  if ACmLocalizaStr = ''
  then ACmLocalizaStr := 'CmDbLocaliza';

  Create_RCommand(ACmLocalizaStr    ,'~P~esquisar' ,'',kbNoKey,0,0,Mb_Cm_Localiza    ,BfDefault,Commands_Buttons[0]); {Comando default}
  Create_RCommand(aCmNovoStr        ,'~N~ovo'      ,'',kbNoKey,0,0,Mb_Cm_Novo        ,bfNormal ,Commands_Buttons[1]);
  Create_RCommand('CmEditDlg'       ,'E~d~itar'    ,'',kbNoKey,0,0,Mb_Cm_Edita       ,bfNormal ,Commands_Buttons[2]);
  Create_RCommand(aCmAlteracaoStr   ,'~G~ravar'    ,'',kbNoKey,0,0,Mb_Cm_Alteracao   ,bfNormal ,Commands_Buttons[3]);
  Create_RCommand('CmProcess'       ,'~F~inalizar' ,'',kbNoKey,0,0,Mb_Cm_Process     ,bfNormal ,Commands_Buttons[4]);
  Create_RCommand(aCmExclusaoStr    ,'~E~xcluir'   ,'',kbNoKey,0,0,Mb_Cm_Exclusao    ,bfNormal ,Commands_Buttons[5]);
  Create_RCommand(ACmLocalizaStr    ,'~P~esquisar' ,'',kbNoKey,0,0,Mb_Cm_Localiza    ,BfDefault,Commands_Buttons[6]); {Comando default}
  Create_RCommand('CmDbFindRe'      ,'~A~tualizar' ,'',kbNoKey,0,0,Mb_Cm_FindRec     ,bfNormal ,Commands_Buttons[7]);
  Create_RCommand('CmVisualizar'    ,'~V~isualizar','',kbNoKey,0,0,Mb_Cm_Visualizar  ,bfNormal ,Commands_Buttons[8]);
  Create_RCommand('CmPrint'         ,'I~m~primir'  ,'',kbNoKey,0,0,Mb_Cm_Print       ,bfNormal ,Commands_Buttons[9]);
  Create_RCommand('CmOk'            ,'O~K~'        ,'',kbNoKey,0,0,Mb_Cm_ok          ,bfNormal ,Commands_Buttons[10]);
  Create_RCommand('CmCancel'        ,'~C~ancelar'  ,'',kbNoKey,0,0,Mb_Cm_Cancel      ,bfNormal ,Commands_Buttons[11]);
  Create_RCommand('CmMyCancel'      ,'~S~air'      ,'',kbNoKey,0,0,Mb_Cm_Sair        ,bfNormal ,Commands_Buttons[12]);
  Create_RCommand('CmDbGoBof'       ,'~1~ Início'  ,'',kbNoKey,0,0,Mb_Cm_Bof         ,bfNormal ,Commands_Buttons[13]);
  Create_RCommand('CmDbPrevRec'     ,'~2~ Anterior','',kbNoKey,0,0,Mb_Cm_Prev        ,bfNormal ,Commands_Buttons[14]);
  Create_RCommand('CmDbNextRec'     ,'~3~ Pr¢ximo' ,'',kbNoKey,0,0,Mb_Cm_Next        ,bfNormal ,Commands_Buttons[15]);
  Create_RCommand('CmDbGoEof'       ,'~4~ éltimo'  ,'',kbNoKey,0,0,Mb_Cm_Eof         ,bfNormal ,Commands_Buttons[16]);
  Create_RCommand('CmDbNextRec'     ,'~3~ Pr¢ximo' ,'',kbNoKey,0,0,Mb_Cm_Next        ,bfNormal ,Commands_Buttons[17]);
  Create_RCommand('CmDbGoEof'       ,'~4~ éltimo'  ,'',kbNoKey,0,0,Mb_Cm_Eof         ,bfNormal ,Commands_Buttons[18]);

  _Commands_Buttons_High  := 18;
  Create_RCommands_Buttons :=   Commands_Buttons_High;

  if Application<>nil
  then Begin
         OkCmmNewRecord := Application.FileOptions_CommandEnabled(aCmNovoStr);
         if OkCmmNewRecord
         then Application.EnableCommands([aCmNovoStr])
         Else Application.DisableCommands([aCmNovoStr]);

         OkCmmEvaluateRecord := Application.FileOptions_CommandEnabled(aCmAlteracaoStr);
         if OkCmmEvaluateRecord
         then Application.EnableCommands([aCmAlteracaoStr])
         Else Application.DisableCommands([aCmAlteracaoStr]);

         OkCmmZeroizeRecord  := Application.FileOptions_CommandEnabled(aCmExclusaoStr);
         if OkCmmZeroizeRecord
         then Application.EnableCommands([aCmExclusaoStr])
         Else Application.DisableCommands([aCmExclusaoStr]);

         if OkCmmNewRecord or OkCmmEvaluateRecord or OkCmmZeroizeRecord
         then begin
                self.OkCmmDbLocaliza := true;
                UiDmxScroller.Locked := false;
              end
         else begin
                 self.OkCmmDbLocaliza := Application.FileOptions_CommandEnabled(ACmLocalizaStr);
                 UiDmxScroller.Locked := True;
               end;

           if OkCmmDbLocaliza
           then Application.EnableCommands([ACmLocalizaStr])
           Else Application.DisableCommands([ACmLocalizaStr]);
       End;
end;

function TUiDmxScroller_Buttons.Add_RCommands_Buttons(aStrCommand: tString;
                                                     aName: AnsiString;
                                                     aParam: tString;
                                                     aKeyCode: Word;
                                                     aAHelpCtx: Word;
                                                     aState: Byte;
                                                     aFlags_Buttons: Byte): Longint;

Begin
  If Commands_Buttons_High < High(Commands_Buttons)
  Then inc(_Commands_Buttons_High)
  else Raise TException.Create(self,'Add_RCommands_Buttons',ParametroInvalido);

  Result := FMb_Bits(Commands_Buttons_High+Mb_Cm_Inicial);
  Create_RCommand(aStrCommand,aName,aParam ,aKeyCode,aAHelpCtx,aState,Result,aFlags_Buttons,Commands_Buttons[Commands_Buttons_High]);
end;


function TUiDmxScroller_Buttons.Set_Commands_Buttons_Mb(const aMb_Bits: Longint): Longint;
  Var
    i : Byte;
Begin
  If aMb_Bits < 0
  then Raise TException.Create(self,'Set_Commands_Buttons_Mb',ParametroInvalido);
  Result := Commands_Buttons_Mb;
  For i := 1 to Commands_Buttons_High do
    If (Commands_Buttons[i].Mb_Bits and Commands_Buttons_Mb) <> 0
    Then Commands_Buttons[i].State := 0  // 0=Opcao habilitada
    Else Commands_Buttons[i].State := 1; // 1=Opcao Desabilitada;

  _Commands_Buttons_Mb  := aMb_Bits;
end;


function TUiDmxScroller_Buttons.Length_Button_Name_Actives: Smallint;
Var
  i : Byte;
Begin
  Result := 0;
  For I := 1 to High(Commands_Buttons_High) do
  With Commands_Buttons[i] do
  Begin
    If (_Commands_Buttons_Mb and Mb_Bits <> 0)
    then Result := Result + (Length(Name));
  end;
End;

function TUiDmxScroller_Buttons.Get_Commands_Mb_i(const aMb_Bits: Longint): Longint;
  Var
    I : Longint;
Begin
  For i := 1 to Commands_Buttons_High do
    If (Commands_Buttons[i].Mb_Bits and aMb_Bits) <> 0
    Then Begin
      Result := i;
      exit;
    end;
  Result := 0; {Nao achou}
End;

function TUiDmxScroller_Buttons.Get_Commands_Mb_StrCommand(const aMb_Bits: Longint): AnsiString;
//Retorna o número do comando passado per aMb_Bits.
  Var
    I : Byte;
Begin
  For i := 1 to Commands_Buttons_High do
    If (Commands_Buttons[i].Mb_Bits and aMb_Bits) <> 0
    Then Begin
      Result := Commands_Buttons[i].StrCommand;
      exit;
    end;
  Result := ''; {Nao achou}
End;

end.


{  For i := 1 to High(Commands_Buttons) do
    If ((Commands_Buttons[i].Mb_Bits and Mb_Bit01) <> 0) or
       ((Commands_Buttons[i].Mb_Bits and Mb_Bit02) <> 0) or
       ((Commands_Buttons[i].Mb_Bits and Mb_Bit03) <> 0) or
       ((Commands_Buttons[i].Mb_Bits and Mb_Bit04) <> 0) or
       ((Commands_Buttons[i].Mb_Bits and Mb_Bit05) <> 0) or
       ((Commands_Buttons[i].Mb_Bits and Mb_Bit06) <> 0) or
       ((Commands_Buttons[i].Mb_Bits and Mb_Bit07) <> 0) or
       ((Commands_Buttons[i].Mb_Bits and Mb_Bit08) <> 0) or
       ((Commands_Buttons[i].Mb_Bits and Mb_Bit09) <> 0) or
       ((Commands_Buttons[i].Mb_Bits and Mb_Bit10) <> 0) or
       ((Commands_Buttons[i].Mb_Bits and Mb_Bit11) <> 0) or
       ((Commands_Buttons[i].Mb_Bits and Mb_Bit12) <> 0) or
       ((Commands_Buttons[i].Mb_Bits and Mb_Bit13) <> 0) or
       ((Commands_Buttons[i].Mb_Bits and Mb_Bit14) <> 0) or
       ((Commands_Buttons[i].Mb_Bits and Mb_Bit15) <> 0) or
       ((Commands_Buttons[i].Mb_Bits and Mb_Bit16) <> 0) or
       ((Commands_Buttons[i].Mb_Bits and Mb_Bit17) <> 0) or
       ((Commands_Buttons[i].Mb_Bits and Mb_Bit18) <> 0) or
       ((Commands_Buttons[i].Mb_Bits and Mb_Bit19) <> 0) or
       ((Commands_Buttons[i].Mb_Bits and Mb_Bit20) <> 0) or
       ((Commands_Buttons[i].Mb_Bits and Mb_Bit21) <> 0) or
       ((Commands_Buttons[i].Mb_Bits and Mb_Bit22) <> 0) or
       ((Commands_Buttons[i].Mb_Bits and Mb_Bit23) <> 0) or
       ((Commands_Buttons[i].Mb_Bits and Mb_Bit24) <> 0) or
       ((Commands_Buttons[i].Mb_Bits and Mb_Bit25) <> 0) or
       ((Commands_Buttons[i].Mb_Bits and Mb_Bit26) <> 0) or
       ((Commands_Buttons[i].Mb_Bits and Mb_Bit27) <> 0) or
       ((Commands_Buttons[i].Mb_Bits and Mb_Bit28) <> 0) or
       ((Commands_Buttons[i].Mb_Bits and Mb_Bit29) <> 0) or
       ((Commands_Buttons[i].Mb_Bits and Mb_Bit30) <> 0) or
       ((Commands_Buttons[i].Mb_Bits and Mb_Bit31) <> 0) or
       ((Commands_Buttons[i].Mb_Bits and Mb_Bit32) <> 0) or
    Then Begin
            If (Commands_Buttons[i].Mb_Bits and Commands_Buttons_Mb) <> 0
            Then Commands_Buttons[i].State := 0  // 0=Opcao habilitada
            Else Commands_Buttons[i].State := 1; // 1=Opcao Desabilitada;
         End;

}

//function TUiDmxScroller_Buttons.Create_RCommands_Buttons(var aCommands: array of TRCommand): Word;
//{Inicializacao da lista de buttoes de navegacao de registros do banco dados}
//Begin
//  If High(aCommands) < 6
//  Then Raise TException.Create(self,'Create_RCommands_Buttons()',ParametroInvalido);
//
//  {Inicialização da lista de butões de navegação de registros do banco dados}
//  If Ok_Buttons_por_extenco
//  Then Begin
//    Create_RCommand('CmDbNextRec' ,'<&3> Próximo '  ,'',kbNoKey,0,0,Mb_Cm_Next  ,BfDefault,aCommands[0]);{Comando default}
//    Create_RCommand('CmDbGoBof'   ,'<&1> Início  '  ,'',kbNoKey,0,0,Mb_Cm_Bof   ,bfNormal ,aCommands[1]);
//    Create_RCommand('CmDbPrevRec' ,'<&2> Anterior ' ,'',kbNoKey,0,0,Mb_Cm_Prev  ,bfNormal ,aCommands[2]);
//    Create_RCommand('CmDbNextRec' ,'<&3> Próximo '  ,'',kbNoKey,0,0,Mb_Cm_Next  ,bfNormal ,aCommands[3]); {Comando default}
//    Create_RCommand('CmDbGoEof'   ,'<&4> Último  '  ,'',kbNoKey,0,0,Mb_Cm_Eof   ,bfNormal ,aCommands[4]);
//    Create_RCommand('CmDbLocaliza','<&5> Pesquisa'  ,'',kbNoKey,0,0,mb_Cm_Locate,bfNormal ,aCommands[5]);
//    Create_RCommand('CmDbFindRec' ,'<&6> Atualiza'  ,'',kbNoKey,0,0,mb_Cm_Find  ,bfNormal ,aCommands[6]);
//  End
//  else Begin
////  ⏭️<1> ⏩<2> ⏪<3> ⏮️<4>
//    Create_RCommand('CmDbNextRec' ,'⏩<&3> '  ,'',kbNoKey,0,0,Mb_Cm_Next  ,BfDefault,aCommands[0]);//Comando default
//    Create_RCommand('CmDbGoBof'   ,'⏭️<&1> '  ,'',kbNoKey,0,0,Mb_Cm_Bof   ,bfNormal ,aCommands[1]);
//    Create_RCommand('CmDbPrevRec' ,'⏪<&2> '  ,'',kbNoKey,0,0,Mb_Cm_Prev  ,bfNormal ,aCommands[2]);
//    Create_RCommand('CmDbNextRec' ,'⏩<&3> '  ,'',kbNoKey,0,0,Mb_Cm_Next  ,bfNormal or bfBroadcast ,aCommands[3]); //Comando default
//    Create_RCommand('CmDbGoEof'   ,'⏮️<&4> '  ,'',kbNoKey,0,0,Mb_Cm_Eof   ,bfNormal ,aCommands[4]);
//    Create_RCommand('CmDbLocaliza','🔍<&5>'   ,'',kbNoKey,0,0,mb_Cm_Locate,bfNormal ,aCommands[5]);
//    Create_RCommand('CmDbFindRec' ,'🔃<~6>'   ,'',kbNoKey,0,0,mb_Cm_Find  ,bfNormal ,aCommands[6]);
//  end;
//
//  _Commands_Buttons_High := 6;
//  result := Commands_Buttons_High;
//end;


