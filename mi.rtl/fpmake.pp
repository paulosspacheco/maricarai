{
   File generated automatically by Lazarus Package Manager
   Created with the Fppkgpackagemanager package installed

   fpmake.pp for mi.rtl 0.9.0.621

   This file was generated on 22/07/2024
}

{$ifndef ALLPACKAGES} 
{$mode objfpc}{$H+}
program fpmake;

uses fpmkunit;
{$endif ALLPACKAGES}

procedure add_mi.rtl(const ADirectory: string);

var
  P : TPackage;
  T : TTarget;
  D : TDependency;

begin
  with Installer do
    begin
    P:=AddPackage('mi.rtl');
    P.Version:='0.9.0-621';

    P.Directory:=ADirectory;

    P.Author:='PauloSSPacheco@yahoo.com;';
    P.License:='Copyright (c) <2023> <PauloSSPacheco@gmail.com>'#10''#10'A permissão é concedida, gratuitamente, a qualquer pessoa que obtenha uma cópia  deste software e arquivos de documentação associados (o "Software"), para   negociar no Software sem restrições, incluindo, sem limitação, o   direitos de usar, copiar, modificar, mesclar, publicar, distribuir, sublicenciar e/ou vender cópias do Software e permitir que as pessoas a quem o Software é  munidos para o efeito, nas seguintes condições:'#10''#10'   O aviso de direitos autorais acima e este aviso de permissão devem ser incluídos em todas as cópias ou partes substanciais do Software.'#10''#10'   O SOFTWARE É FORNECIDO "COMO ESTÁ", SEM GARANTIA DE QUALQUER TIPO, EXPRESSA OU IMPLÍCITAS, INCLUINDO, SEM'#10'   LIMITAÇÃO,  AS GARANTIAS DE COMERCIALIZAÇÃO,  ADEQUAÇÃO PARA UM FIM ESPECÍFICO E NÃO VIOLAÇÃO. '#10'   EM NENHUM CASO O  OS AUTORES OU DETENTORES DOS DIREITOS AUTORAIS SERÃO RESPONSÁVEIS POR QUALQUE'#10'   REIVINDICAÇÃO,  DANOS OU OUTROS  RESPONSABILIDADE, SEJA EM UMA AÇÃO DE CONTRATO, ILÍCITO OU DE OUTRA FORMA,'#10'   DECORRENTE  DE,  FORA DE OU EM CONEXÃO COM O SOFTWARE OU O USO OU OUTROS NEGÓCIOS  NO SOFTWARE.';
    P.Description:='# Pacote mi.rtl'#10'## Objetivo do pacote _mi.rtl_'#10'- Encapsular as units do FreePascal convergindo tudo para TObjectss com propósito de evitar declaração de units secundárias bem como manter uma compatibilidade com o passado.'#10''#10'## Como funciona o número da versão do pacote'#10'- O número da versão é composta de 4 números sendo xx.yy.zz.ww'#10'  - xx : Versão PRINCIPAL do projeto e só deve mudar nas seguintes situações:'#10'    - Quando troca de estado de Alpha para Beta e Final e caso no furo se faça algo que torne o passado incompatível;'#10'  - yy : Muda a cada vez que é criado algo novo no projeto;'#10'  - zz : Muda a cada correção de bugs ou otimização.'#10'  - ww : Número de vezes que o pacote foi construido do zero.';

    P.Flags.Add('LazarusDsgnPkg');

    D := P.Dependencies.Add('sqldblaz');
    D := P.Dependencies.Add('lcl');
    D := P.Dependencies.Add('lazutils');
    P.Options.Add('-MDelphi');
    P.Options.Add('-Scaghi');
    P.Options.Add('-CirotR');
    P.Options.Add('-O1');
    P.Options.Add('-g');
    P.Options.Add('-gl');
    P.Options.Add('-gh');
    P.Options.Add('-Xg');
    P.Options.Add('-gt');
    P.Options.Add('-l');
    P.Options.Add('-vewnhibq');
    P.Options.Add('-dLCL');
    P.Options.Add('-dLCL$(LCLWidgetType)');
    P.Options.Add('-gh');
    P.Options.Add('-gl');
    P.IncludePath.Add('../projects/exemplos/mi.lcl/mi.lcl.form/mi.lcl.ds.form.test/bin/x86_64-linux/lib');
    P.IncludePath.Add('units/inc/linux');
    P.IncludePath.Add('units/inc/windows');
    P.IncludePath.Add('units');
    P.IncludePath.Add('units/fcl-base/src');
    P.UnitPath.Add('units');
    P.UnitPath.Add('units/fcl-base/src');
    P.UnitPath.Add('.');
    T:=P.Targets.AddUnit('mi.rtl.pas');
    D := T.Dependencies.AddInclude('histórico.pas');
    D := T.Dependencies.AddUnit('mi.rtl');
    D := T.Dependencies.AddUnit('mi_rtl_tarefas_a_fazer');
    D := T.Dependencies.AddUnit('mi.rtl.treenode');
    D := T.Dependencies.AddUnit('Mi_SQLQuery');
    D := T.Dependencies.AddUnit('fpTemplate');
    D := T.Dependencies.AddUnit('mi.rtl.miStringlist');
    D := T.Dependencies.AddUnit('mi.rtl.MiStringlistbase');
    D := T.Dependencies.AddUnit('mi.rtl.libBinRes');
    D := T.Dependencies.AddUnit('mi.rtl.ApplicationAbstract');
    D := T.Dependencies.AddUnit('mi.rtl.Class_Of_Char');
    D := T.Dependencies.AddUnit('mi.rtl.Types');
    D := T.Dependencies.AddUnit('mi.rtl.Consts');
    D := T.Dependencies.AddUnit('mi.rtl.Consts.transaction');
    D := T.Dependencies.AddUnit('mi.rtl.files');
    D := T.Dependencies.AddUnit('mi.rtl.Consts.StrError');
    D := T.Dependencies.AddUnit('mi.rtl.objects.types');
    D := T.Dependencies.AddUnit('mi.rtl.Objects.Consts');
    D := T.Dependencies.AddUnit('mi.rtl.Objects.Consts.Logs');
    D := T.Dependencies.AddUnit('mi.rtl.Objects.Consts.Mi_MsgBox');
    D := T.Dependencies.AddUnit('mi.rtl.Objects.Consts.ProgressDlg_If');
    D := T.Dependencies.AddUnit('mi.rtl.Objects.Methods');
    D := T.Dependencies.AddUnit('mi.rtl.objects.Methods.dates');
    D := T.Dependencies.AddUnit('mi.rtl.objects.methods.html.tags');
    D := T.Dependencies.AddUnit('mi.rtl.Objects.Methods.Exception');
    D := T.Dependencies.AddUnit('mi.rtl.Objects.Methods.Paramexecucao');
    D := T.Dependencies.AddUnit('mi.rtl.Objects.Methods.Paramexecucao.Application');
    D := T.Dependencies.AddUnit('mi.rtl.Objects.Methods.StreamBase');
    D := T.Dependencies.AddUnit('mi.rtl.Objects.Methods.StreamBase.Stream');
    D := T.Dependencies.AddUnit('mi.rtl.Objects.Methods.StreamBase.Stream.FileStream');
    D := T.Dependencies.AddUnit('mi.rtl.Objects.Methods.StreamBase.Stream.MemoryStream');
    D := T.Dependencies.AddUnit('mi.rtl.objects.methods.StreamBase.Stream.MemoryStream.BufferMemory');
    D := T.Dependencies.AddUnit('mi.rtl.Objects.Methods.Collection');
    D := T.Dependencies.AddUnit('mi.rtl.Objects.Methods.Collection.FilesStreams');
    D := T.Dependencies.AddUnit('mi.rtl.Objects.Methods.System');
    D := T.Dependencies.AddUnit('mi.rtl.Objects.Methods.Collection.SortedCollection');
    D := T.Dependencies.AddUnit('mi.rtl.Objects.Methods.Collection.SortedCollection.StringCollection');
    D := T.Dependencies.AddUnit('mi.rtl.Objects.Methods.Collection.Sortedcollection.Stringcollection.Collectionstring');
    D := T.Dependencies.AddUnit('mi.rtl.Objects.Methods.Collection.SortedCollection.StrCollection');
    D := T.Dependencies.AddUnit('mi.rtl.Objects.Methods.Db.Tb_Access');
    D := T.Dependencies.AddUnit('mi.rtl.Objects.Methods.Db.Tb__Access');
    D := T.Dependencies.AddUnit('mi.rtl.Objects.Methods.Db.Tb___Access');
    D := T.Dependencies.AddUnit('mi.rtl.objects.methods.pageproducer');
    D := T.Dependencies.AddUnit('mi.rtl.Objectss');
    D := T.Dependencies.AddUnit('mi_rtl_ui_types');
    D := T.Dependencies.AddUnit('mi_rtl_ui_consts');
    D := T.Dependencies.AddUnit('mi_rtl_ui_methods');
    D := T.Dependencies.AddUnit('mi_rtl_ui_Dmxscroller');
    D := T.Dependencies.AddUnit('mi_rtl_ui_dmxscroller_form');
    D := T.Dependencies.AddUnit('mi_rtl_ui_DmxScroller_Buttons');
    D := T.Dependencies.AddInclude('units/mi_rtl_ui_dmxscroller_consts_inc.pas');
    D := T.Dependencies.AddUnit('mi.rtl.ui.dmxscroller.inputbox');
    D := T.Dependencies.AddUnit('mi_rtl_ui_custom_application');
    D := T.Dependencies.AddUnit('mi.rtl.all');
    T := P.Targets.AddImplicitUnit('mi.rtl.pas');
    T := P.Targets.AddImplicitUnit('mi_rtl_tarefas_a_fazer.pas');
    T := P.Targets.AddImplicitUnit('units/mi.rtl.treenode.pas');
    T := P.Targets.AddImplicitUnit('units/mi_sqlquery.pas');
    T := P.Targets.AddImplicitUnit('units/fcl-base/src/fptemplate.pp');
    T := P.Targets.AddImplicitUnit('units/mi.rtl.mistringlist.pas');
    T := P.Targets.AddImplicitUnit('units/mi.rtl.mistringlistbase.pas');
    T := P.Targets.AddImplicitUnit('units/mi.rtl.libbinres.pas');
    T := P.Targets.AddImplicitUnit('units/mi.rtl.applicationabstract.pas');
    T := P.Targets.AddImplicitUnit('units/mi.rtl.class_of_char.pas');
    T := P.Targets.AddImplicitUnit('units/mi.rtl.types.pas');
    T := P.Targets.AddImplicitUnit('units/mi.rtl.consts.pas');
    T := P.Targets.AddImplicitUnit('units/mi.rtl.consts.transaction.pas');
    T := P.Targets.AddImplicitUnit('units/mi.rtl.files.pas');
    T := P.Targets.AddImplicitUnit('units/mi.rtl.consts.strerror.pas');
    T := P.Targets.AddImplicitUnit('units/mi.rtl.objects.types.pas');
    T := P.Targets.AddImplicitUnit('units/mi.rtl.objects.consts.pas');
    T := P.Targets.AddImplicitUnit('units/mi.rtl.objects.consts.logs.pas');
    T := P.Targets.AddImplicitUnit('units/mi.rtl.objects.consts.mi_msgbox.pas');
    T := P.Targets.AddImplicitUnit('units/mi.rtl.objects.consts.progressdlg_if.pas');
    T := P.Targets.AddImplicitUnit('units/mi.rtl.objects.methods.pas');
    T := P.Targets.AddImplicitUnit('units/mi.rtl.objects.methods.dates.pas');
    T := P.Targets.AddImplicitUnit('units/mi.rtl.objects.methods.html.tags.pas');
    T := P.Targets.AddImplicitUnit('units/mi.rtl.objects.methods.exception.pas');
    T := P.Targets.AddImplicitUnit('units/mi.rtl.objects.methods.paramexecucao.pas');
    T := P.Targets.AddImplicitUnit('units/mi.rtl.objects.methods.paramexecucao.application.pas');
    T := P.Targets.AddImplicitUnit('units/mi.rtl.objects.methods.streambase.pas');
    T := P.Targets.AddImplicitUnit('units/mi.rtl.objects.methods.streambase.stream.pas');
    T := P.Targets.AddImplicitUnit('units/mi.rtl.objects.methods.streambase.stream.filestream.pas');
    T := P.Targets.AddImplicitUnit('units/mi.rtl.objects.methods.streambase.stream.memorystream.pas');
    T := P.Targets.AddImplicitUnit('units/mi.rtl.objects.methods.streambase.stream.memorystream.buffermemory.pas');
    T := P.Targets.AddImplicitUnit('units/mi.rtl.objects.methods.collection.pas');
    T := P.Targets.AddImplicitUnit('units/mi.rtl.objects.methods.collection.filesstreams.pas');
    T := P.Targets.AddImplicitUnit('units/mi.rtl.objects.methods.system.pas');
    T := P.Targets.AddImplicitUnit('units/mi.rtl.objects.methods.collection.sortedcollection.pas');
    T := P.Targets.AddImplicitUnit('units/mi.rtl.objects.methods.collection.sortedcollection.stringcollection.pas');
    T := P.Targets.AddImplicitUnit('units/mi.rtl.objects.methods.collection.sortedcollection.stringcollection.collectionstring.pas');
    T := P.Targets.AddImplicitUnit('units/mi.rtl.objects.methods.collection.sortedcollection.strcollection.pas');
    T := P.Targets.AddImplicitUnit('units/mi.rtl.objects.methods.db.tb_access.pas');
    T := P.Targets.AddImplicitUnit('units/mi.rtl.objects.methods.db.tb__access.pas');
    T := P.Targets.AddImplicitUnit('units/mi.rtl.objects.methods.db.tb___access.pas');
    T := P.Targets.AddImplicitUnit('units/mi.rtl.objects.methods.pageproducer.pas');
    T := P.Targets.AddImplicitUnit('units/mi.rtl.objectss.pas');
    T := P.Targets.AddImplicitUnit('units/mi_rtl_ui_types.pas');
    T := P.Targets.AddImplicitUnit('units/mi_rtl_ui_consts.pas');
    T := P.Targets.AddImplicitUnit('units/mi_rtl_ui_methods.pas');
    T := P.Targets.AddImplicitUnit('units/mi_rtl_ui_dmxscroller.pas');
    T := P.Targets.AddImplicitUnit('units/mi_rtl_ui_dmxscroller_form.pas');
    T := P.Targets.AddImplicitUnit('units/mi_rtl_ui_dmxscroller_buttons.pas');
    T := P.Targets.AddImplicitUnit('units/mi.rtl.ui.dmxscroller.inputbox.pas');
    T := P.Targets.AddImplicitUnit('units/mi_rtl_ui_custom_application.pas');
    T := P.Targets.AddImplicitUnit('units/mi.rtl.all.pas');

    // copy the compiled file, so the IDE knows how the package was compiled
    P.Sources.AddSrc('mi.rtl.compiled');
    P.InstallFiles.Add('mi.rtl.compiled',AllOSes,'$(unitinstalldir)');

    end;
end;

{$ifndef ALLPACKAGES}
begin
  add_mi.rtl('');
  Installer.Run;
end.
{$endif ALLPACKAGES}
