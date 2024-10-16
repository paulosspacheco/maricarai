unit uMi_lcl_ui_Form_attributes;
{:< A unit **name** implementa a classe TMi_lcl_ui_Form_attributes.

- **VERSÃO**
  - Alpha - 1.0.0

- **HISTÓRICO**
  - @html(<a href="../units/uMi_lcl_ui_Form_attributes.html">./Mi_lcl_ui_Form_attributes.html </a>)

- **CÓDIGO FONTE**:
  - @html(<a href="../units/uMi_lcl_ui_Form_attributes.pas">Mi_lcl_ui_Form_attributes.pas</a>)

- **PENDÊNCIAS**
  - T12 Criar método BuildCustomerFormFromTemplate(aEnumClientApplication:TEnumClientApplication);
  - T12 Criar private método CreateClientUnitDataModule
  - T12 Criar private método CreateClientUnitForm


}


{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils
  ,controls,StdCtrls,forms,typInfo,types,Graphics,ActnList,db,dbctrls,Menus,
  variants, LazHelpHtml,UTF8Process,Dialogs, ComCtrls
  ,mi.rtl.Objects.Consts.Mi_MsgBox
  ,mi_rtl_ui_Dmxscroller
  ,mi_rtl_ui_dmxscroller_form
  ,mi.rtl.All
  ,mi.rtl.treenode
  ;

 type

   { TMi_lcl_ui_Form_attributes }
   {:A classe **name** é a base para a criação de formulários lcl contendo tudo
     que precisa para que os componentes TDmxScroller_Form e TMi_lcl_ui_ds_Form
     comunicar-se.

   if Assigned(DmxScroller_Form)
   then begin
          DmxScroller_Form.Parent := _ParentLCL;
          if Assigned(_ParentLCL) and ( _ParentLCL.Caption = '')
          then begin
                 s := Alias;
                 _ParentLCL.Caption:= s;
              end;
        end;

   }
   TMi_lcl_ui_Form_attributes= class(TMi_rtl_ui_Form_abstract)
      public Procedure Set_DmxScroller_Form(a_DmxScroller_Form: TDmxScroller_Form);Override;

       protected var _Owner : TScrollingWinControl;
       //public constructor Create(aOwner:TComponent);override;overload;
       //public destructor destroy; override;

       protected function GetActive: Boolean;override;
       protected procedure SetActive(aActive : Boolean);override;

     {$REGION '--> Property ParentLCL'}
        protected _ParentLCL : TScrollingWinControl;
        protected procedure SetParentLCL(aParentLCL : TScrollingWinControl);virtual;

        {: A propriedade **@name** informa a janela q ComCtrls ue será desenhada o formulário}
        published Property ParentLCL : TScrollingWinControl Read _ParentLCL write SetParentLCL;
     {$ENDREGION '<-- Property ParentLCL'}

     public function getAction(sender : TControl;aExecAction: AnsiString): TContainedAction;
     protected class procedure Rounded_corners(Const AControl : TWinControl;Const ATop : integer = 20;ABottom : integer = 20);
     public class procedure Apply_Rounded_Corners(ctrl: TWinControl; Const ATop : integer = 20;ABottom : integer = 20);

     {: O método **@name** Trava a edição do formulário}
     protected Procedure SetLocked(aLocked:Boolean);override;

     public property Mi_ActionList;
     public procedure LockUpdates;Override;
     public procedure UnlockUpdate;Override;

     {: O método **@name** eetorna a largura do caractere. }
     public function GetWidthChar():integer;override;Overload;
     public function TextWidthChar(AFont: TFont): Integer;overload;

     {: O método **@name** retorna true se o tamanho da fonte é fixo e false se o tamanho da fonte for variável }
     public function IsMonoSpaced (can : TCanvas; Font: TFont) : Boolean;
     public function TextWidthChar(AFont: TPersistent): Integer;override;overload;
     public function GetHeightChar():integer;override;Overload;
     public function TextHeightChar(AFont: TFont): Integer;overload;
     public function TextHeightChar(AFont: TPersistent): Byte;override;overload;

     {: https://lazarus-ccr.sourceforge.io/docs/lcl/forms/tcontrolscrollbar.html}
     public procedure Scroll_it_inview_LCL(AScrollWindow:TScrollingWinControl; AControl: TControl);

     {: O método **@name** é usado para da o scroller na janela onde esse
        componente for inserido.
        - **NOTA**
          - A LCL não rola a tela com a tecla tab e o controle não estiver visível.
     }
     public procedure Scroll_it_inview(AControl: pDmxFieldRec);override;overload;
     public procedure ShowControlState;override;
     protected procedure RefreshInternal;override;
     public procedure Refresh;override;
     public procedure DoBeforeSetActiveTarget;override;

     {: O método **@name** altera a fonte e o tamanho do controle passado por **ctrl** e de seus filhos.}
     Private procedure ModifyFontsAll_LCL(ctrl: TWinControl;aFontName:String;aSize:integer);overload;

     {: O método **@name** altera a fonte do controle passado por **ctrl** e de seus filhos.}
     Private procedure ModifyFontsAll_LCL(ctrl: TWinControl;aFontName:String);overload;

     {: O método **@name** altera a fonte e o tamanho do controle passado por **ctrl** e de seus filhos.}
     public procedure ModifyFontsAll(ctrl_WinControl: TComponent;aFontName:String;aSize:integer);override;overload;

     {: O método **@name** altera a fonte do controle passado por **ctrl** e de seus filhos.}
     public procedure ModifyFontsAll(ctrl_WinControl: TComponent;aFontName:String);Override;overload;


     //Verifica se o componente fornecido possui uma relação db e se o conteúdo foi alterado
     public function isValueDbChanged(Sender: TComponent): Boolean;override;

     Public Procedure ShowHtml(URL:string);override;

     {:O método **@name** inicia a documentação resumida do campo. aFldNum }
     Public Function SetHelpCtx_Hint(aFldNum:Integer;a_HelpCtx_Hint:AnsiString):pDmxFieldRec;override;

     {:O método **@name** inicia a documentação resumida do campo passado em :apDmxFieldRec}
     Public Procedure SetHelpCtx_Hint(apDmxFieldRec:pDmxFieldRec;a_HelpCtx_Hint:AnsiString);override;overload;

     {:O método **@name** seleciona o primeiro campo que pode receber o foco no formulário.

       - **Descrição**
         - Este método percorre todos os componentes do formulário (`_Owner`) que
           são do tipo `TWinControl`. Para cada componente, ele verifica se o
           componente pode receber foco, está visível, habilitado e pode ser
           acessado por tabulação (`TabStop`). Além disso, o método verifica se o
           componente é do tipo `TDbEdit` ou `TDbComboBox`.
         - Se o componente for do tipo `TDbEdit` ou `TDbComboBox` e tiver um
           campo de dados associado (`Field`), o método tenta focar no campo de
           dados associado e, em seguida, define o foco no próprio componente.
           O método termina imediatamente após definir o foco no primeiro
           componente válido encontrado.

       - **Notas**
         - Este método não faz nada se o formulário está sendo carregado
           (`csLoading`) ou se está em modo de leitura (`csReading`).

       - **See Also**
         - [TDbEdit](#)
         - [TDbComboBox](#)
         - [FocusControl](#)

       - **Parâmetros**
         - Nenhum.

       - **Exceções**
         - Nenhuma.
     }
     Protected procedure Select_First_Field_Normal;override;

     {: O Método **@name** deve excuta TMi_rtl.Locate()
     }
     public function Locate(aField:pDmxFieldRec): TModalResult;Override;

     {$REGION ' Implementação dos comandos EnableControls e DisableControls'}
       {: O método **@name** habilitas os controles visuais do dataset}
       public procedure EnableControls;

       {: O método **@name** desabilita os controles visuais do dataset}
       public procedure DisableControls;

       {: O método **@name** retorna true se os contoles estã habilitados
          e retorna false se não tiver habilitado
       }
       public function  ControlsDisabled: Boolean;

     {$ENDREGION ' Implementação dos comandos EnableControls e DisableControls'}

     class procedure PopulateMenuFromTreeNode(Node: TTreeNode; ParentMenuItem: TMenuItem);

     {:O método **@name** preenche o TTreeView a partir de uma estrutura
       TMi_rtl_treenode
     }
     class procedure PopulateTreeViewFromTMi_rtl_treenode(aNode: TMi_rtl_treenode; var TreeView: TTreeView; ParentTreeViewNode: TTreeNode);

     {:A método **@name** executa a ação associada a um nó do TTreeView}
     class procedure ExecuteTreeViewNodeAction(TreeViewNode: TTreeNode);

     {:A método **@name** cria e executa uma classe passada por InstanceClass.
     }
     class Procedure ShowModal(InstanceClass: TComponentClass);

     {O método **@name** é usuado para criar formulários baseados em templates
      da aplicação destino.
     }
     public procedure BuildCustomerFormFromTemplate();Override;

   end;


implementation

{ TMi_lcl_ui_Form_attributes }

procedure TMi_lcl_ui_Form_attributes.Set_DmxScroller_Form(a_DmxScroller_Form: TDmxScroller_Form);
begin
  inherited Set_DmxScroller_Form(a_DmxScroller_Form);
  if Assigned(DmxScroller_Form)
  then begin
         DmxScroller_Form.Parent := _ParentLCL;
         if Assigned(_ParentLCL) and ( _ParentLCL.Caption = '')
         then begin
                _ParentLCL.Caption:= Alias;
              end;
       end;
//  else Raise TMi_rtl.TException.Create(self,{$I %CURRENTROUTINE%},'O componente DmxScroller_Form não assinalado!');

end;

function TMi_lcl_ui_Form_attributes.GetActive: Boolean;
begin
  Result:=inherited GetActive;
end;

procedure TMi_lcl_ui_Form_attributes.SetActive(aActive: Boolean);
begin
  inherited SetActive(aActive);
end;

procedure TMi_lcl_ui_Form_attributes.SetParentLCL(  aParentLCL: TScrollingWinControl);
  var s :string;
begin
  _ParentLCL := aParentLCL;
  if Assigned(DmxScroller_Form)
  then begin
         DmxScroller_Form.Parent := _ParentLCL;
         if Assigned(_ParentLCL) and ( _ParentLCL.Caption = '')
         then begin
                s := Alias;
                _ParentLCL.Caption:= s;
             end;
       end;
//  else Raise TMi_rtl.TException.Create(self,{$I %CURRENTROUTINE%},'O componente DmxScroller_Form não assinalado!');
end;

function TMi_lcl_ui_Form_attributes.getAction(sender : TControl;aExecAction: AnsiString): TContainedAction;
begin
  if Assigned(Mi_ActionList)
  Then begin
         Result := Mi_ActionList.ActionByName(aExecAction)
       end
  else if Assigned(DmxScroller_Form) and
          Assigned(DmxScroller_Form.Mi_ActionList)
       then result :=  DmxScroller_Form.Mi_ActionList.ActionByName(aExecAction)
       else result := nil;
end;

class procedure TMi_lcl_ui_Form_attributes.Rounded_corners( const AControl: TWinControl; const ATop: integer=20; ABottom: integer=20);
  var
    ABitmap: TBitmap;
begin
  try
   ABitmap := TBitmap.Create;
   ABitmap.Monochrome := True;
   ABitmap.Width := AControl.Width;
   ABitmap.Height := AControl.Height;
   ABitmap.Canvas.Brush.Color:=clBlack;
   ABitmap.Canvas.FillRect(0, 0, AControl.Width, AControl.Height);
   ABitmap.Canvas.Brush.Color:=clWhite;
   ABitmap.Canvas.RoundRect(0, 0, AControl.Width, AControl.Height,Atop,ABottom);
   AControl.SetShape(ABitmap);

  finally
    ABitmap.Free;
  end;
end;

class procedure TMi_lcl_ui_Form_attributes.Apply_Rounded_Corners(  ctrl: TWinControl; const ATop: integer= 20; ABottom: integer = 20);
  var
    i: Integer;
begin
  Rounded_corners(ctrl,ATop, ABottom);
  for i := 0 to ctrl.controlcount - 1 do
    if ctrl.controls[i] is TWinControl then
      Apply_Rounded_Corners(ctrl.controls[i] as TWinControl,ATop,ABottom);
end;

procedure TMi_lcl_ui_Form_attributes.SetLocked(aLocked: Boolean);
begin
  if Assigned(ParentLCL)
  Then if aLocked
       Then ParentLCL.Enabled:=false
       else ParentLCL.Enabled:=true
end;

procedure TMi_lcl_ui_Form_attributes.LockUpdates;
begin
  if Assigned(ParentLCL)
  then ParentLCL.DisableAlign;
end;

procedure TMi_lcl_ui_Form_attributes.UnlockUpdate;
begin
  if Assigned(ParentLCL)
  then begin
         ParentLCL.EnableAlign;
         ParentLCL.Repaint; // Force a repaint
       end;
end;

function TMi_lcl_ui_Form_attributes.GetWidthChar(): integer;
begin
  if Assigned(dmxscroller_form) then
  begin
    Result := TextWidthChar(_Owner.Font);
  end;
end;

function TMi_lcl_ui_Form_attributes.TextWidthChar(AFont: TFont): Integer;
begin
  if Assigned(dmxscroller_form)
  then begin
         with _Owner do
         begin
           if not IsMonoSpaced(Canvas,aFont)
           then Result := Canvas.TextWidth(DmxScroller_Form.CharAlfanumeric) div Length(DmxScroller_Form.CharAlfanumeric)
           else Result := Canvas.TextWidth('A');
         end;
       end
  else Result := inherited TextWidthChar(AFont);
end;

function TMi_lcl_ui_Form_attributes.IsMonoSpaced(can: TCanvas; Font: TFont  ): Boolean;
begin
  can.Font.Name := Font.name;
  result :=  can.TextWidth('i') = can.TextWidth('W');
end;

function TMi_lcl_ui_Form_attributes.TextWidthChar(AFont: TPersistent): Integer;
begin
  result := TextWidthChar(AFont as TFont);
end;

function TMi_lcl_ui_Form_attributes.GetHeightChar(): integer;
begin
  if Assigned(dmxscroller_form)
  then Result := TextHeightChar(_Owner.Font)
  else Result := Inherited GetHeightChar();
end;

function TMi_lcl_ui_Form_attributes.TextHeightChar(AFont: TFont): Integer;
begin
  if Assigned(dmxscroller_form)
  Then result := _Owner.Canvas.TextHeight(DmxScroller_Form.CharAlfanumeric)
  else result := inherited TextHeightChar(AFont);
  Result := Result +HeightCharMargin;
end;

function TMi_lcl_ui_Form_attributes.TextHeightChar(AFont: TPersistent): Byte;
begin
   result := TextHeightChar(AFont as TFont);
end;

procedure TMi_lcl_ui_Form_attributes.Scroll_it_inview_LCL(  AScrollWindow: TScrollingWinControl; AControl: TControl);
var
  xRect: types.TRect;
  APar :TControl; //added;
  aClientHeight,aClientWidth :Integer;
begin
  if Assigned(dmxscroller_form) then
  With DmxScroller_Form, AScrollWindow do
  Begin
    if AControl=nil
    then Exit;
    aClientHeight := AScrollWindow.ClientHeight;
    aClientWidth  := AScrollWindow.ClientWidth;
//    aPosition     := VertScrollBar.Position;

    xRect := AControl.BoundsRect;

   {---Added---}
    APar := ACOntrol.Parent;
    While APar <> AScrollWindow do
    Begin
      OffsetRect(xRect, Apar.BoundsRect.Left, Apar.BoundsRect.Top);
      Apar := Apar.Parent;
      if Apar = Nil
      Then Exit; //Obviously the control isn't parented
    end;

    {--_End of added--}
    OffsetRect(xRect, -HorzScrollBar.Position, -VertScrollBar.Position);

    if xRect.Left < 0
    then HorzScrollBar.Position := HorzScrollBar.Position + xRect.Left
    else if xRect.Right > aClientWidth
         then begin
                if xRect.Right - xRect.Left > aClientWidth
                then xRect.Right := xRect.Left + aClientWidth;
                HorzScrollBar.Position := HorzScrollBar.Position + xRect.Right - aClientWidth;
              end;

    if xRect.Top < 0
    then VertScrollBar.Position := VertScrollBar.Position + xRect.Top +HeightChar
    else if xRect.Bottom > ClientHeight then
         begin
           if xRect.Bottom - xRect.Top > aClientHeight
           then xRect.Bottom := xRect.Top + aClientHeight;
           VertScrollBar.Position := VertScrollBar.Position + xRect.Bottom - aClientHeight + HeightChar;
         end;
  end;
end;

procedure TMi_lcl_ui_Form_attributes.Scroll_it_inview(AControl: pDmxFieldRec);
begin
  if Assigned(AControl)
     and (ParentLCL is TScrollingWinControl)
     and (AControl^.LinkEdit is TControl)
  then with ParentLCL as TScrollingWinControl do
       begin
         ScrollInView((AControl^.LinkEdit as TControl));
       end;
end;

procedure TMi_lcl_ui_Form_attributes.ShowControlState;
begin
  if Assigned(dmxscroller_form) and (ParentLCL is TScrollingWinControl)
  then with DmxScroller_Form do
       begin
         if csFocusing in (ParentLCL as TScrollingWinControl).ControlState
         then MessageBox('csFocusing in ControlState ');
      end;
end;

procedure TMi_lcl_ui_Form_attributes.RefreshInternal;
Begin
  if Assigned(dmxscroller_form) and
     (Owner is TScrollingWinControl)
  then with (Owner as TScrollingWinControl),DmxScroller_Form do
       if Not GetState(Mb_St_Creating)
       Then begin
              if Not isDataSetActive
              Then Raise TException.Create(self,'RefreshInternal','O método deve ser executado estando nos modos DsEdit e DsInsert! ');

              if (not (GetDataSet.state in [DsEdit,DsInsert]))
              Then Edit;

              LockUpdates;
              DmxScroller_Form.UpdateBuffers;
              Invalidate;
              Update;
              UnlockUpdate;
              //inherited RefreshInternal;
           end;
End;

procedure TMi_lcl_ui_Form_attributes.Refresh;
begin
  //if Assigned(dmxscroller_form) and
  //   (Owner is TScrollingWinControl)
  //then with Owner as TScrollingWinControl do
  //     begin
  //       inherited Refresh;
  //     end;
  RefreshInternal;
end;

procedure TMi_lcl_ui_Form_attributes.DoBeforeSetActiveTarget;
begin
  if Assigned(dmxscroller_form) then
  begin
    if not Assigned(ParentLCL) and (Owner is TScrollingWinControl)
    then ParentLCL := Owner as TScrollingWinControl;

    DmxScroller_Form.Parent := ParentLCL;

    //inherited DoBeforeSetActiveTarget;
  end;
end;

procedure TMi_lcl_ui_Form_attributes.ModifyFontsAll_LCL(ctrl: TWinControl;  aFontName: String; aSize: integer);
  procedure ModifyFont(ctrl: TControl);
    var
      f: TFont;
  begin
    if IsPublishedProp(ctrl, 'Parentfont')
      and (GetOrdProp(ctrl, 'Parentfont') = Ord(false))
      and IsPublishedProp(ctrl, 'font')
      then begin
             f := TFont(GetObjectProp(ctrl, 'font', TFont));

             if aFontName <> ''
             Then f.Name := aFontName;

             If aSize<>0
             then f.size := aSize;
           end;
  end;

  var
    i: Integer;
begin
  ModifyFont(ctrl);
  for i := 0 to ctrl.controlcount - 1 do
    if ctrl.controls[i] is Twincontrol then
      ModifyFontsAll_LCL(TWincontrol(ctrl.controls[i]),aFontName)
    else
      Modifyfont(ctrl.controls[i]);
end;

procedure TMi_lcl_ui_Form_attributes.ModifyFontsAll_LCL(ctrl: TWinControl;  aFontName: String);
begin
  ModifyFontsAll_LCL(ctrl,aFontName,0);
end;

procedure TMi_lcl_ui_Form_attributes.ModifyFontsAll(
  ctrl_WinControl: TComponent; aFontName: String; aSize: integer);
begin
  if Assigned(_ParentLCL) and (_ParentLCL is TWinControl)
  Then ModifyFontsAll_LCL((_ParentLCL as TWinControl),aFontName,aSize);
end;

procedure TMi_lcl_ui_Form_attributes.ModifyFontsAll(
  ctrl_WinControl: TComponent; aFontName: String);
begin
  if Assigned(_ParentLCL) and (_ParentLCL is TWinControl)
  Then ModifyFontsAll_LCL((_ParentLCL as TWinControl),aFontName);
end;

function TMi_lcl_ui_Form_attributes.isValueDbChanged(Sender: TComponent  ): Boolean;
  var
    tmp_Field: TField;
    dlink: TObject;
begin
  Result:= inherited isValueDbChanged(Sender);
  if not result
  Then begin
        dlink := TObject(TControl(Sender).Perform(CM_GETDATALINK, 0, 0));
        if dlink is TFieldDataLink then
        begin //se houver um DataLink (consulte, por exemplo, TcxDBButtonEdit.CMGetDataLink)
          tmp_Field := (dlink as TFieldDataLink).Field;
          result :=  Assigned(tmp_Field)  and not(VarSameValue(tmp_Field.OldValue, tmp_Field.Value));
        end
        else result := false;
  end;
end;

//procedure TMi_lcl_ui_Form_attributes.ShowHtml(URL: string);
//  var
//    v: THTMLBrowserHelpViewer;
//    BrowserPath, BrowserParams: string;
//    p: LongInt;
//    BrowserProcess: TProcessUTF8;
//begin
//  v:=THTMLBrowserHelpViewer.Create(nil);
//  try
//    v.FindDefaultBrowser(BrowserPath,BrowserParams);
//    //debugln(['Path=',BrowserPath,' Params=',BrowserParams]);
//
//    //URL:='http://www.lazarus.freepascal.org';
//    p:=System.Pos('%s', BrowserParams);
//    System.Delete(BrowserParams,p,2);
//    System.Insert(URL,BrowserParams,p);
//
//    // start browser
//    BrowserProcess:=TProcessUTF8.Create(nil);
//    try
//      BrowserProcess.CommandLine:=BrowserPath+' '+BrowserParams;
//      BrowserProcess.Execute;
//    finally
//      BrowserProcess.Free;
//    end;
//  finally
//    v.Free;
//  end;
//end;

procedure TMi_lcl_ui_Form_attributes.ShowHtml(URL: string);
var
  v: THTMLBrowserHelpViewer;
  BrowserPath, BrowserParams: string;
  p: LongInt;
  BrowserProcess: TProcessUTF8;
begin
  v := THTMLBrowserHelpViewer.Create(nil);
  try
    v.FindDefaultBrowser(BrowserPath, BrowserParams);

    // Remover e substituir %s por URL
    p := System.Pos('%s', BrowserParams);
    if p > 0 then
    begin
      System.Delete(BrowserParams, p, 2);
      System.Insert(URL, BrowserParams, p);
    end
    else
      BrowserParams := URL;

    // Iniciar o navegador
    BrowserProcess := TProcessUTF8.Create(nil);
    try
      BrowserProcess.Executable := BrowserPath;
      BrowserProcess.Parameters.Text := BrowserParams;
      BrowserProcess.Execute;
    finally
      BrowserProcess.Free;
    end;
  finally
    v.Free;
  end;
end;

function TMi_lcl_ui_Form_attributes.SetHelpCtx_Hint(aFldNum: Integer; a_HelpCtx_Hint: AnsiString): pDmxFieldRec;
begin
  result := inherited SetHelpCtx_Hint(aFldNum, a_HelpCtx_Hint);
  if result^.LinkEdit is TControl
  Then (result^.LinkEdit as TControl).Hint := a_HelpCtx_Hint ;
end;

procedure TMi_lcl_ui_Form_attributes.SetHelpCtx_Hint( apDmxFieldRec: pDmxFieldRec; a_HelpCtx_Hint: AnsiString);
begin
  inherited SetHelpCtx_Hint(apDmxFieldRec,a_HelpCtx_Hint);
  if Assigned(apDmxFieldRec) and (apDmxFieldRec^.LinkEdit is TControl)
  Then (apDmxFieldRec^.LinkEdit as TControl).Hint := a_HelpCtx_Hint ;
end;

procedure TMi_lcl_ui_Form_attributes.Select_First_Field_Normal;
var
  i: Integer;
  Control: TWinControl;
begin
  if Assigned(_Owner)
  then if (not (csLoading in _Owner.ComponentState)) and
          (not (csReading in _Owner.ComponentState))
       then
             for i := 0 to _Owner.ComponentCount - 1 do
             begin
               if _Owner.Components[i] is TWinControl then
               begin
                 Control := TWinControl(_Owner.Components[i]);
                 if Assigned(Control)
                 then begin
                         // Verifique se o componente pode receber foco, está visível e habilitado
                         if ((Control.CanSetFocus) and
                             (Control.Visible) and
                             (Control.Enabled) and
                             (Control.TabStop)
                            )
                            and ((Control is TDbEdit) or
                                 (Control is TDbComboBox)
                                )
                         then begin
                                if (Control is TDbEdit)
                                then begin
                                        if Assigned((Control as TDbEdit).Field)
                                        Then (Control as TDbEdit).Field.FocusControl;
                                     end
                                else if (Control is TDbComboBox)
                                     then begin
                                             if Assigned((Control as TDbComboBox).Field)
                                             then (Control as TDbComboBox).Field.FocusControl;
                                          end;
                                Control.SetFocus;
                                exit;
                              end;
                      end;

                end;
             end;
end;

function TMi_lcl_ui_Form_attributes.Locate(aField: pDmxFieldRec): TModalResult;
begin
  if Assigned(DmxScroller_Form)
   Then Result := TMI_RTL.Locate(aField)
   else Result := TMi_MsgBox.mrCancel;
end;

procedure TMi_lcl_ui_Form_attributes.EnableControls;
begin
  if Assigned(DmxScroller_Form)
  Then DmxScroller_Form.EnableControls;
end;

procedure TMi_lcl_ui_Form_attributes.DisableControls;
begin
  if Assigned(DmxScroller_Form)
  Then DmxScroller_Form.DisableControls;
end;

function TMi_lcl_ui_Form_attributes.ControlsDisabled: Boolean;
begin
  if Assigned(DmxScroller_Form)
  Then result := DmxScroller_Form.ControlsDisabled
  else Result := true;
end;

class procedure TMi_lcl_ui_Form_attributes.PopulateMenuFromTreeNode(
  Node: TTreeNode; ParentMenuItem: TMenuItem);
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

class procedure TMi_lcl_ui_Form_attributes.ShowModal(
  InstanceClass: TComponentClass);
  var
    aForm : TForm;
begin
  try
    Application.CreateForm(InstanceClass,aForm );
    aForm.ShowModal;
  finally
    FreeAndNil(aForm);
  end;
end;

procedure TMi_lcl_ui_Form_attributes.BuildCustomerFormFromTemplate();
begin
  if Assigned(DmxScroller_Form)
  Then begin
//         DmxScroller_Form.RewriteFileClients(aEnClientsApplication);
       end

end;

//Procedura que preenche o TTreeView a partir de uma estrutura TMi_rtl_treenode
class procedure TMi_lcl_ui_Form_attributes.PopulateTreeViewFromTMi_rtl_treenode(
  aNode: TMi_rtl_treenode; var TreeView: TTreeView;
  ParentTreeViewNode: TTreeNode);
var
  Child: TMi_rtl_treenode;
  NewTreeViewNode: TTreeNode;
begin
  if aNode = nil then Exit;

  // Adiciona um novo nó ao TTreeView
  if ParentTreeViewNode = nil
  then NewTreeViewNode := TreeView.Items.AddChild(nil               , TPathAction(aNode.Data).Data)
  else NewTreeViewNode := TreeView.Items.AddChild(ParentTreeViewNode, TPathAction(aNode.Data).Data);

  NewTreeViewNode.Data := TPathAction(aNode.Data).Action;

  // Itera sobre os filhos do nó TMi_rtl_treenode
  Child := aNode.GetFirstChild;
  while Child <> nil do
  begin
    PopulateTreeViewFromTMi_rtl_treenode(Child, TreeView, NewTreeViewNode);
    Child := Child.GetNextSibling;
  end;
end;

// Procedura que executa a ação associada a um nó do TTreeView
class procedure TMi_lcl_ui_Form_attributes.ExecuteTreeViewNodeAction(
  TreeViewNode: TTreeNode);
begin
  if (TreeViewNode <> nil) and (TreeViewNode.Data <> nil) then
  begin
    // Verifica se o Data realmente aponta para um objeto
    if TObject(TreeViewNode.Data) is TAction then
    begin
      // Se for um TAction, executa a ação
      TAction(TreeViewNode.Data).Execute;
    end
    else
    begin
      ShowMessage('O item selecionado não tem uma ação associada.');
    end;
  end;
  //else
  //begin
  //  ShowMessage('Nenhuma ação associada ou nó inválido.');
  //end;
end;


end.

