unit mi.rtl.Objectss;
  {:< - A Unit **@name** reune todas as classes base pacote **mi.rtl**.

    - **NOTAS**
      - Esta unit foi testada nas plataformas: win32, win64 e linux.

    - **VERSÃO**
      - Alpha - 1.0.0

    - **HISTÓRICO**
      - Criado por: Paulo Sérgio da Silva Pacheco e-mail: paulosspacheco@@yahoo.com.br
        - **20/11/2021**
          - 9:10 a ??: Criar a unit **@name**
        - **22/07/2023**
          - Implementar a propriedade ObjectsTemplate : TObjectsTemplate

    - **CÓDIGO FONTE**:
      - @html(<a href="../units/mi.rtl.objects.pas">mi.rtl.objects.pas</a>)

  }



  {$IFDEF FPC}
    {$MODE Delphi} {$H+}
  {$ENDIF}


  interface

  uses
    Classes
    ,SysUtils

    ,mi.rtl.Objects.Methods.Paramexecucao.Application
    ,mi.rtl.types
    ,mi.rtl.Consts
    ,mi.rtl.MiStringListBase
    ,mi.rtl.MiStringList
    ,mi.rtl.files
    ,mi.rtl.objects.types
    ,mi.rtl.objects.consts
    ,mi.rtl.objects.consts.MI_MsgBox
    ,mi.rtl.objects.consts.progressdlg_if
    ,mi.rtl.objects.Methods
    ,mi.rtl.objects.Methods.Dates
    ,mi.rtl.objects.methods.ParamExecucao
    ,mi.rtl.objects.Methods.Exception
    ,mi.rtl.objects.methods.StreamBase
    ,mi.rtl.objects.methods.StreamBase.Stream
    ,mi.rtl.objects.methods.StreamBase.Stream.MemoryStream
    ,mi.rtl.objects.methods.StreamBase.Stream.MemoryStream.BufferMemory
    ,mi.rtl.objects.methods.StreamBase.Stream.FileStream
    ,mi.rtl.objects.methods.Collection
    ,mi.rtl.objects.methods.Collection.SortedCollection
    ,mi.rtl.objects.methods.Collection.SortedCollection.StrCollection
    ,mi.rtl.objects.methods.Collection.SortedCollection.stringCollection
    ,mi.rtl.objects.methods.Collection.SortedCollection.stringcollection.CollectionString
    ,mi.rtl.objects.methods.Collection.FilesStreams
    ,mi.rtl.objects.methods.db.tb_access
    ,mi.rtl.objects.methods.db.tb__access
    ,mi.rtl.objects.methods.db.tb___access
    ,mi.rtl.objects.methods.pageproducer
    ,mi.rtl.objects.methods.html.tags

    ;

     type

     { TObjectss }
     {: A classe **@name** é a  base de todas as classes do pacote **mi.rtl**.

       - **EXEMPLO DE USO**

         ```pascal


         ```

      - **HISTÓRICO**
        - Criado por: Paulo Sérgio da Silva Pacheco e-mail: paulosspacheco@@yahoo.com.br
          - **19/11/2021** 21:25 a 23:15 Criar a classe **TStream**
          - **20/11/2021** 09:10 a ??: Criar a classe **TObjects**
          - **23/11/2021** 21:50 a 22:00 Declarar as classes TFileSream e TFileMemory em TObjectss
     }
     TObjectss =
       class(TObjectsMethods)
         public class function Application: TApplication;
         public Class Procedure Set_MI_MsgBox(aMI_MsgBox: TMI_MsgBox);Virtual;
         public type TMI_MsgBox       = mi.rtl.objects.consts.MI_MsgBox.TMI_MsgBox;
         public type TMI_MsgBoxConsts = mi.rtl.objects.consts.MI_MsgBox.TMI_MsgBoxConsts;
         public type TTypes          = mi.rtl.types.TTypes;
         public type TConsts         = mi.rtl.Consts.TConsts;
         public type TStringListBase = mi.rtl.MiStringListBase.TStringListBase;
         public type TMiStringList   = mi.rtl.MiStringList.TMiStringList;
         public type TFiles          = mi.rtl.files.TFiles;
         public type TObjectsTypes  = mi.rtl.objects.types.TObjectsTypes;
         public type TObjectsConsts = mi.rtl.objects.consts.TObjectsConsts;
         public type TObjectsMethods = mi.rtl.objects.Methods.TObjectsMethods;
         public type TException      = mi.rtl.objects.Methods.Exception.TException;
         public type TStreambase     = mi.rtl.objects.methods.StreamBase.TStreambase;
         public type TStream         = mi.rtl.objects.methods.StreamBase.Stream.TStream;
         public type TMemoryStream   = mi.rtl.objects.methods.StreamBase.Stream.MemoryStream.TMemoryStream;
         public type TFileStream     = mi.rtl.objects.methods.StreamBase.Stream.FileStream.TFileStream;
         public type TBufferMemory   = mi.rtl.objects.methods.StreamBase.Stream.MemoryStream.BufferMemory.TBufferMemory;

         public type TCollection           = mi.rtl.objects.methods.Collection.TCollection;
         public type TSortedCollection     = mi.rtl.objects.methods.Collection.SortedCollection.TSortedCollection;
         public type TCollectionString     = mi.rtl.objects.methods.Collection.SortedCollection.stringcollection.CollectionString.TCollectionString;
         public type TStringCollection     = mi.rtl.objects.methods.Collection.SortedCollection.stringcollection.TStringCollection;
         public type TUnStringCollection   = mi.rtl.objects.methods.Collection.SortedCollection.stringcollection.TUnSortedStringCollection;
         public type TStrCollection        = mi.rtl.objects.methods.Collection.SortedCollection.StrCollection.TStrCollection;
         public type TUnStrCollection      = mi.rtl.objects.methods.Collection.SortedCollection.StrCollection.TUnSortedStrCollection;
         public type TFilesStreams         = mi.rtl.objects.methods.Collection.FilesStreams.TFilesStreams;

         public type TDates                = mi.rtl.objects.Methods.Dates.TDates;

         public type TParamExecucao = mi.rtl.objects.methods.ParamExecucao.TParamExecucao;

         public type TTb_Access_types = mi.rtl.objects.methods.db.tb_access.TTb_Access_types;
         public type TTb_Access_conts = mi.rtl.objects.methods.db.tb_access.TTb_Access_consts;
         public type Ttb_access =  mi.rtl.objects.methods.db.tb_access.TTb_Access;

         public type TTb__Access_types = mi.rtl.objects.methods.db.tb__access.TTb__Access_types;
         public type TTb__Access_conts = mi.rtl.objects.methods.db.tb__access.TTb__Access_consts;
         public type Ttb__access = mi.rtl.objects.methods.db.tb__access.Ttb__access;

         public type TTb___Access_types = mi.rtl.objects.methods.db.tb___access.TTb___Access_types;
         public type TTb___Access_consts = mi.rtl.objects.methods.db.tb___access.TTb___Access_consts;
         public type TTb___Acces = mi.rtl.objects.methods.db.tb___access.TTb___Access;

         public Type TListBoxRec = record    {<-- omit if TListBoxRec is defined else where}
                       PS           : TCollectionString;
                       Selection    : longint;
                       {: O campo a seguir devolve a pedaco da string limitadas por ~ usada para transferencia de dados}
                       StrSelection : String;
                     end;

         public type TPageProducer = mi.rtl.objects.methods.pageproducer.TPageProducer;
         public type Thtml_tags = mi.rtl.objects.methods.html.tags.Thtml_tags;

//         public Type IDialogs = mi.rtl.objects.methods.ui.Interfaces.IDialogs;
//         public Type ITable   = mi.rtl.objects.methods.ui.Interfaces.ITable;

         //Public Type TObjectsMethodsUiTypes        = mi.rtl.Objects.Methods.Ui.Types.TObjectsMethodsUiTypes;
         //Public Type TObjectsMethodsUiConsts       = mi.rtl.Objects.Methods.Ui.Consts.TObjectsMethodsUiConsts;
         //Public Type TObjectsMethodsUiMethods      = mi.rtl.Objects.Methods.Ui.Methods.TObjectsMethodsUiMethods;
         //Public Type TObjectsMethodsUiDmxScroller  = mi.rtl.Objects.Methods.Ui.DmxScroller.TObjectsMethodsDmxScroller;

         public class Procedure ProcStreamError(Const S: TStreambase);
         public class Function StrToSItem(Const StrMsg:AnsiString; Colunas : byte;Alinhamento:TAlinhamento):PSItem;
         public class procedure WriteSItems(var S: TCollectionString; Const Items: PSItem);
         Public class Function PSItem_ListaDeMsgErro:PSItem;override;

         Public class Procedure MessageError;override;

         private
           //_ObjectsTemplate: mi.rtl.objects.methods.fptemplates.TObjectsTemplate;
           //procedure SetObjectsTemplate(AValue: mi.rtl.objects.methods.fptemplates.TObjectsTemplate);


         {: A propriedade **@name** contém um função do tipo x para preencher o modelo

            - EXEMPLO
              - procedure func1callReplaceTag(Sender: TObject; const TagString:String; TagParams: TStringList; Out ReplaceText: String);

              ```PASCAL

                type
                  TTestObjects = class(TObjectss)
                    private
                      // private declarations
                      procedure DoReplaceTag(Sender: TObject; const TagString:String; TagParams: TStringList; Out ReplaceText: String);

                    public
                     // public declarations
                     public constructor Create(aowner:TComponent);Overload;Override;
                  end;

                implementation

                 constructor Create(aowner:TComponent);
                 begin
                   inheried Create(aowner);

                   ModuleTemplate := DoReplaceTag ;

                 end;

                end.

              ```
         }
         //published Property ObjectsTemplate : TObjectsTemplate Read _ObjectsTemplate Write SetObjectsTemplate;
       end;

//procedure register;

implementation

  //procedure register;
  //begin
  //  RegisterComponents('Mi.Rtl', [TObjectss]);
  //end;

  class function TObjectss.Application: TApplication;
  begin
    if Assigned(FuncApplication)
    Then result := FuncApplication
    else result :=  mi.rtl.Objects.Methods.Paramexecucao.Application.Application;
  end;

  class procedure TObjectss.Set_MI_MsgBox(aMI_MsgBox: TMI_MsgBox);
  begin
    _MI_MsgBox := aMI_MsgBox;
    if Assigned(application)
    then Application.MI_MsgBox := MI_MsgBox;
  end;



  class procedure TObjectss.ProcStreamError(const S: TStreambase);
    Var msg:AnsiString;
  Begin
    if s<>nil
    then begin
           msg := lf+'Unit        : mi.rtl.objects.pas '+LF+
                     'Procedimento: ProcStreamError'+LF+
                     '      Status: '+istr(S.Status,'BBB')+LF+
                     '      Error : '+IStr(S.ErrorInfo,'BBB')+LF+
                     LF+
                     'Error critico. Nao posso continuar.';
            LogError(msg);
            raise Exception.Create(msg);
            Halt(S.ErrorInfo);
         end
    else begin
           Halt(ParametroInvalido);
         end;

  end;

  class function TObjectss.StrToSItem(const StrMsg: AnsiString; Colunas: byte;  Alinhamento: TAlinhamento): PSItem;

    Var
      aStrMsg  : AnsiString;
      i,MaxCol : Byte;
      S        : TCollectionString;
    Begin
      aStrMsg := '';
      MaxCol  := 0;
      try
        S :=  TCollectionString.Create(1,1,False);{<Insere a tString em ordem sequencial}

        If S=Nil Then
        Begin
          StrToSItem := nil;
          exit;
        End;

        for i := 1 to length(StrMsg) do
        Begin
          if (strMsg[i] in [^J,^Z{,^C,^M}]) or (MaxCol > Colunas) Then
          Begin
            While (aStrMsg[1] = ' ') and (length(aStrMsg)>0) do
              Delete(aStrMsg,1,1);

            If strMsg[i] in [^J,^Z{<,^C,^M}]
            Then S.NewStr(StrAlinhado(aStrMsg,Colunas,Alinhamento))
            Else S.NewStr(StrAlinhado(aStrMsg+ StrMsg[i],Colunas,Alinhamento));

            aStrMsg := '';
            MaxCol := 0;
          end
          Else
          Begin
            aStrMsg := aStrMsg + StrMsg[i];
            Inc(MaxCol);
          End;
        End;

      Finally
        If S <> nil
        Then Begin
               S.NewStr(aStrMsg);
               StrToSItem :=S.PListSItem;
             End;
        Discard(TObject(s));
      End;
    End;

  class procedure TObjectss.WriteSItems(var S: TCollectionString;
                                        const Items: PSItem);
      {<Obs:
        S : Deve ser passado não inicializado mais deve ser NIL
      }
    var
      P : PSItem;
    begin
      If (S = nil) And (Items<>nil) Then
      Begin
        S :=  TCollectionString.Create(1,1,False);{<Insere a tString em ordem sequencial}
        P := Items;
        While (P <> nil) do
        begin
          If P.Value <> nil
          Then S.NewStr(P.Value^);
          P := P.Next;
        end;
      End;
    end;

  class function TObjectss.PSItem_ListaDeMsgErro: PSItem;

    Var
      S1,S2 : TCollectionString;
//      ListaDeMsgErro :PSitem;
      L : Integer;
  Begin
    Try
      L := 0;
//      ListaDeMsgErro := _ListaDeMsgErro;

      If (ListaDeMsgErro <> nil)  Then
      Begin
        S1     := nil;
        While (ListaDeMsgErro <> nil)   do
        Begin
            inc(L);
            if L > 20
            then CtrlSleep(0);

            IF  (ListaDeMsgErro<>nil) and (ListaDeMsgErro^.Value<>NIL)
            THEN BEGIN
                    Result := StrToSItem(ListaDeMsgErro^.Value^,255,Alinhamento_Esquerda);
                    If S1 = nil
                    Then WriteSItems(S1,Result )
                    Else S1.AddSItem(Result);
                    PopSItem(ListaDeMsgErro);
                 END
            Else PopSItem(ListaDeMsgErro);
        End; //while

        If S1 <> nil
        Then Begin
  //              If ListaDeChamadas <> nil
  //              Then Begin
  //                      S1.AddSItem(CopySItems(ListaDeChamadas));
  //                   End;

               Result := S1.PListSItem;
               S1.Destroy;
             end
        Else Result := nil;
      end
      Else Result := nil;

    finally
    end;
  end;

  var
    MessageError_reintrance :Boolean = False;
  class procedure TObjectss.MessageError;
    {: < Este procedimento imprime a sequencia de mesagems de erro}

    Var
      I               : Integer;
      ItemSelecionado : TListBoxRec;
      Wok             : Boolean;
//      Msg : AnsiString;

  Begin
    If MessageBoxOff or (Self = nil)
    then exit;

    try
      Wok := ok;
      If (Not get_ok_Set_Transaction)
         and (Not Get_ok_Set_Server_Http)
         and (not MessageError_reintrance)
      Then Begin
             Try
               MessageError_reintrance := true;
                If ListaDeMsgErro <>  nil Then
                Begin
                  ItemSelecionado.Selection := 0;

                  if Assigned(MI_MsgBox)
                  Then with MI_MsgBox do
                       BEGIN
                         //Msg :=  SItemToString(ListaDeMsgErro);
                          MessageBox_ListBoxRec_PSItem('ATENÇÃO',
                                                       ListaDeMsgErro,
                                                       ItemSelecionado.Selection,
                                                       MtWarning,
                                                       MbOKButton,
                                                       mbOK);

                         //SysMessageBox(msg,'ATENÇÃO',true);
                       end;

                  DisposeSItems(ListaDeMsgErro);
                End;

             Finally
               MessageError_reintrance := false;
             End;
          End;

    finally
      ok := wok;
    end;

  End;


{: - Inicializa a unit}
Initialization


  with TObjectss do
  begin
    C_MessageError := @TObjectss.MessageError;
    if _Logs = nil
    then _Logs :=  TFilesLogs.Create(nil);
    //Application := mi.rtl.Objects.Methods.Paramexecucao.Application.Application;
  end;


{: - Finaliza a unit}
finalization

  with TObjectss do
  begin
    if _Logs <> nil
    then begin
           FreeAndNIl(_Logs)
         end;
    C_MessageError := nil;
  end;
end.




