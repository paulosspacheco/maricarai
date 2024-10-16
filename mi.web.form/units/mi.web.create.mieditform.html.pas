unit Mi.Web.Create.MiEditForm.html;
{:< A unit **@name** implementa a classe TCreate_MiEditForm_html com objetivo de criar
    uma cliente html dinâmico.

    - Primeiro autor: Paulo Sérgio da Silva Pacheco paulosspacheco@@yahoo.com.br)

    - **VERSÃO**
      - Alpha - 1.0.0

    - **CÓDIGO FONTE**:
      - @html(<a href="../units/mi.web.create.mieditform.html.pas">Mi.Web.Create.MiEditForm.html.pas</a>)


    - **PENDÊNCIAS**
      - T12 Em create iniciar as propriedades:
        - HtmlFile
          - Contém o nome do arquivo de template gerado.

        - HtmlFileResult
          - Contém o nome do arquivo html gerado.

    - **CONCLUÍDO**
      - 2024/10/12
        -

      - 2024/10/11
        - T12 Criar a unit **@name** ✅
        - T12 Criar propriedade DmxScroller_Form:TDmxScroller_Form;✅
        - T12 Criar  constructor constructor Create(aOwner: TComponent;aDmxScroller_Form:TDmxScroller_Form); reintroduce;✅

    }

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,StrUtils,db
  , mi.rtl.objects.methods.pageproducer
  , mi_rtl_ui_Dmxscroller
  , mi_rtl_ui_dmxscroller_form
  , umi_lcl_ui_ds_form
  , mi.rtl.all
  , mi.rtl.Types
  ,uMi_LCL_Scrollbox
  ,mi.rtl.Consts

  ,uMaskedit_mi_lcl
  ,uDbedit_mi_lcl

  ,uComboBox_mi_lcl
  ,uDbcombobox_mi_lcl

  ,uDblookupcombobox_mi_lcl


  ,uButton_mi_lcl

  ,uCheckbox_mi_lcl
  ,uDbcheckbox_mi_lcl

  ,uRadiogroup_mi_lcl
  ,uDbradiogroup_mi_lcl

  ,uLabel_mi_lcl
  ;

type
  TMi_web_js_Form = class;

  { TCreate_MiEditForm_html }
  {: A classe **@name** usa templates html e javascript para criar o cliente html dinâmico
     adicionando ao formulários do template os campos declarados na propriedade
     DmxScroller_Form: TDmxScroller_Form;

     - Template usado:
       - Nome do arquivo de templates:
         - './templates/Create_MiEditForm_html.html'

         - Tags atualizadas no template:
           - ~title
             - Nome do formulário
           - ~createDate
             - Data da criação da página
           - ~createDateUpdate
             - Data da última atualização da página
           - ~description
             - Criente Restfull que se comuica com TMi_rtl_WebModule_base
           - ~keywords
             - Chave de pesquisa para que o browser possa localizar a página.
           - <!--#fieldset-container#-->
             -  Essa tag deve retornar uma lista dos seguintes templates:

                ```html

                  <!--Template para usado na criação dos campos do formulário:
                      <fieldset>
                          <label for="~field.name">~field.name:</label>
                              <input type="text" id="~field.name" name="~field.name" placeholder="~field.name" data-mask="~field.template_org" data-mask-type="~field.TypeCode"  />
                      </fieldset>
                  -->

                ```

  }
  TCreate_MiEditForm_html = class(TDataModule)
    published
      PageProducer_MiEditForm: TPageProducer;
//      procedure PageProducer_MiEditFormFieldsHTMLTag_Undefined(Sender: TObject;const TagString: string; TagParams: TStrings; var ReplaceText: string);

      procedure PageProducer_MiEditFormHTMLTag_Undefined(Sender: TObject;const TagString: string; TagParams: TStrings; var ReplaceText: string);

    {$REGION 'Construção Propriedade Mi_web_js_Form'}
      private public _Mi_web_js_Form   : TMi_web_js_Form;

      {: A propriedade **@name** fornece todos os recursos necessários para criar a página
         html.
      }
      public property Mi_web_js_Form : TMi_web_js_Form read _Mi_web_js_Form write _Mi_web_js_Form;
    {$ENDREGION 'Construção Propriedade DmxScroller_Form'}


  private
    var _temp_PathRaiz:String;


    {:O método **@name** retorna formulário passado por DmxScroller_Form.
    }
    function GetFieldSetContainer :String;
    //function GetFieldSetContainer():string;

    {: O método **@name** salva no arquivo **htmlFileResult** o conteúdo da
       propriedade HTMLContent.
    }
    Public Procedure  SaveHTMLContentToFile;
  public
    public procedure create_cliente_app_dynamic_html;
  end;

  {:A classe **name** é a base para a criação de formulários web contendo tudo
       que precisa para que os componentes TDmxScroller_Form e TMi_web_js_Form
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

   { TTMi_web_js_Form }

   { TMi_web_js_Form }

   TMi_web_js_Form = class(TMi_lcl_ui_ds_Form)
     private _Create_MiEditForm_html :TCreate_MiEditForm_html;
     public constructor Create(AOwner: TComponent); override;
     public destructor destroy; override;


     {$REGION 'Construção Propriedade Mi_lcl_ui_ds_Form'}
       private public _Mi_lcl_ui_ds_Form   : TMi_lcl_ui_ds_Form;

       public Procedure Set_Mi_lcl_ui_ds_Form(a_Mi_lcl_ui_ds_Form: TMi_lcl_ui_ds_Form);

       {: A propriedade **@name** fornece todos os recursos necessários para criar a página
          html.
       }
       public property Mi_lcl_ui_ds_Form : TMi_lcl_ui_ds_Form read _Mi_lcl_ui_ds_Form write Set_Mi_lcl_ui_ds_Form;
     {$ENDREGION 'Construção Propriedade DmxScroller_Form'}


     public procedure CreateForm();reintroduce;
     public procedure BuildCustomerFormFromTemplate();override;
   end;

//var
//  Create_MiEditForm_html: TCreate_MiEditForm_html;

//resourcestring

implementation

{$R *.lfm}

{ TCreate_MiEditForm_html }



function TCreate_MiEditForm_html.GetFieldSetContainer: String;

  function GetHTMLContent: String;
    //Var
    //  typ,s:String;
  begin
    with Mi_web_js_Form.Mi_lcl_ui_ds_Form.DmxScroller_Form,CurrentField^ do
    begin
      if LinkEdit is TLabel_mi_lcl
      Then result := (LinkEdit as TLabel_mi_lcl).GetHTMLContent
      else
      if LinkEdit is TDbEdit_mi_LCL
      Then result := (LinkEdit as TDbEdit_mi_LCL).GetHTMLContent
      else if LinkEdit is TDBLookupComboBox_mi_Lcl
           then result := (LinkEdit as TDBLookupComboBox_mi_Lcl).GetHTMLContent
           else if (LinkEdit is TDbComboBox_mi_LCL)
                then result := (LinkEdit as TDbComboBox_mi_LCL).GetHTMLContent
                else if (LinkEdit is TMI_ui_DbRadioGroup_Lcl)
                     then result := (LinkEdit as TMI_ui_DbRadioGroup_Lcl).GetHTMLContent
                     else if (LinkEdit is TComboBox_mi_LCL)
                          then result := (LinkEdit as TComboBox_mi_LCL).GetHTMLContent
                          else if LinkEdit is TMaskEdit_mi_LCL
                               Then result := (LinkEdit as TMaskEdit_mi_LCL).GetHTMLContent
                               else if LinkEdit is TDBCheckBox_mi_Lcl
                                    Then result := (LinkEdit as TDBCheckBox_mi_Lcl).GetHTMLContent
                                    else if LinkEdit is TCheckBox_mi_Lcl
                                         Then result := (LinkEdit as TCheckBox_mi_Lcl).GetHTMLContent
                                         else result :=  '';//Raise TException.Create({$I %CURRENTROUTINE%},'Corrente campo não tem controle implementado!');
    end;
  end;


  Var i : integer;
      wCurrentField : pDmxFieldRec;
     // ds : TDataSet;
begin
  result := '';
  with Mi_web_js_Form.Mi_lcl_ui_ds_Form.DmxScroller_Form do
  if Assigned(DMXFields)
  then begin
       // ds := GetDataSet;
        try

          wCurrentField := CurrentField;

          for i := 0 to DMXFields.Count-1 do
          begin
            CurrentField := DMXFields[i];
            while (CurrentField) <> nil do
            with CurrentField^ do begin
              if (Template <> nil)
                 //and (Fieldnum<>0)
                 and (LinkEdit<>nil)
              then begin
                     Result := Result + GetHTMLContent+New_Line;//+'<br>';
                   end;

              if CurrentField <> nil
              Then CurrentField := Next;
            end;

            if CurrentField <> nil
            Then CurrentField := CurrentField^.Next;
          End;

        Finally
          CurrentField := wCurrentField;
        end;
  end;

end;

procedure TCreate_MiEditForm_html.SaveHTMLContentToFile;
  var
    f : TStringList;
    s,fr:String;

begin
  f := TStringList.Create;
  s:=PageProducer_MiEditForm.HTMLContent;
  if s<>''
  Then begin
         f.Add(s);
         fr:= PageProducer_MiEditForm.HTMLFileResult;
         f.SaveToFile(fr);
       end;
  f.Free;
end;

procedure TCreate_MiEditForm_html.PageProducer_MiEditFormHTMLTag_Undefined(Sender: TObject; const TagString: string; TagParams: TStrings;var ReplaceText: string);
  var
    i: integer;
    s: string;
    DataSystem: longint;
    valueKeys:Variant;
begin
  //   Mapa_site.get_Contudo;
  with PageProducer_MiEditForm,TMi_rtl,Mi_web_js_Form.Mi_lcl_ui_ds_Form.DmxScroller_Form do
  begin
    i := AnsiIndexStr(UpperCase(TagString),
      ['TITLE', 'CREATEDATE', 'CREATEDATEUPDATE', 'DESCRIPTION', 'KEYWORDS',
       'FIELDSET-CONTAINER','MENU','AUTHOR','DMXSCROLLER_FORM_NAME','FIELDSKEYS']);
    case i of
      0: begin {'TITLE' }
           ReplaceText := ChangeSubStr('_',' ',TableName );
         end;
      1, 2: begin {'CREATEDATE','CREATEDATEUPDATE' }
              DataSystem := TDates.GetFTimeDos();
              ReplaceText := TDates.StringTimeD(DataSystem, '/');
            end;

      3: begin {'DESCRIPTION' }
           ReplaceText := '';
         end;

      4: begin {'KEYWORDS' }
           ReplaceText := '';
         end;

      5: begin {'Mi_lcl_ui_ds_Form' }
           ReplaceText := GetFieldSetContainer;
         end;

      6: begin {'MENU' }
           ReplaceText := '';
         end;
      7: begin {AUTHOR}
           ReplaceText := 'Paulo Pacheco';
         end;
      8: begin {DMXSCROLLER_FORM}
           ReplaceText := TableName;
         end;
      9: begin {'FieldsKeys' }
           ReplaceText := getFieldsKeys(valueKeys);
         end;

      else
        ReplaceText := 'Erro: Tag indefiida...';
    end;
    s := ReplaceText;
  end;

end;

procedure TCreate_MiEditForm_html.create_cliente_app_dynamic_html;
  var
    s:String;
begin
  with Mi_web_js_Form.Mi_lcl_ui_ds_Form.DmxScroller_Form do
  begin
    //Template main
    s := ExtractFileDir(ClientsTemplatesDataModuleFileName[en_app_dynamic_html]);
    s := S+PathDelim+ 'MiEditForm.html';
    PageProducer_MiEditForm.HTMLFile    := s;

    s:= ClientsApplicationsFormFileName[en_app_dynamic_html];
    PageProducer_MiEditForm.HTMLFileResult:=s;

    if (PageProducer_MiEditForm.OnHTMLTag_Undefined <> nil)
    Then SaveHTMLContentToFile;

  end;
end;



{================== TMi_web_js_Form =================================== }

constructor TMi_web_js_Form.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  _Create_MiEditForm_html := TCreate_MiEditForm_html.Create(self);
end;

destructor TMi_web_js_Form.destroy;
begin
  DestroyForm();
  inherited destroy;
end;

procedure TMi_web_js_Form.Set_Mi_lcl_ui_ds_Form(a_Mi_lcl_ui_ds_Form: TMi_lcl_ui_ds_Form);
begin
  _Mi_lcl_ui_ds_Form := a_Mi_lcl_ui_ds_Form;
  _Create_MiEditForm_html.Mi_web_js_Form := self;

  if not Assigned(Mi_lcl_ui_ds_Form)
  Then raise TMi_rtl.TException.Create(self,{$I %CURRENTROUTINE%},'A propriedade Mi_lcl_ui_ds_Form não pode ser nil!');
end;

procedure TMi_web_js_Form.CreateForm();
begin
  with TMi_rtl do
  begin
    if not Assigned(Mi_lcl_ui_ds_Form)
    then raise TException.Create(self,{$I %CURRENTROUTINE%},'Mi_lcl_ui_ds_Form não pode ser nil!');
    _Create_MiEditForm_html.create_cliente_app_dynamic_html;
  end;

end;


procedure TMi_web_js_Form.BuildCustomerFormFromTemplate();
begin
  if Assigned(Mi_lcl_ui_ds_Form)
  Then begin
         //Mi_lcl_ui_ds_Form.RewriteFileClients(en_app_javascript);
       end;

  CreateForm();
  DestroyForm();
end;



end.

