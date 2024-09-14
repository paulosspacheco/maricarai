{
   File generated automatically by Lazarus Package Manager

   fpmake.pp for mi.rtl 0.9.0.621

   This file was generated on 22/08/2023
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

    D := P.Dependencies.Add('lazutils');
    P.Options.Add('-MDelphi');
    P.Options.Add('-Scghi');
    P.Options.Add('-O1');
    P.Options.Add('-g');
    P.Options.Add('-gl');
    P.Options.Add('-l');
    P.Options.Add('-vewnhibq');
    P.IncludePath.Add('../../../../Lazarus/lazarus-2.2.6/projects/lib/x86_64-linux');
    P.IncludePath.Add('units/include/linux');
    P.IncludePath.Add('units/include/windows');
    P.IncludePath.Add('units');
    P.IncludePath.Add('units/horse/src');
    P.IncludePath.Add('units/fcl-base/src');
    P.UnitPath.Add('units');
    P.UnitPath.Add('units/fcl-base/src');
    P.UnitPath.Add('.');
    T:=P.Targets.AddUnit('mi.rtl.pas');
    t.Dependencies.AddUnit('mi.rtl');
    t.Dependencies.AddUnit('fptemplate');
    t.Dependencies.AddUnit('mi.rtl.mistringlist');
    t.Dependencies.AddUnit('mi.rtl.mistringlistbase');
    t.Dependencies.AddUnit('mi.rtl.libbinres');
    t.Dependencies.AddUnit('mi.rtl.applicationabstract');
    t.Dependencies.AddUnit('mi.rtl.class_of_char');
    t.Dependencies.AddUnit('mi.rtl.types');
    t.Dependencies.AddUnit('mi.rtl.consts');
    t.Dependencies.AddUnit('mi.rtl.files');
    t.Dependencies.AddUnit('mi.rtl.consts.strerror');
    t.Dependencies.AddUnit('mi.rtl.objects.types');
    t.Dependencies.AddUnit('mi.rtl.objects.consts');
    t.Dependencies.AddUnit('mi.rtl.objects.consts.logs');
    t.Dependencies.AddUnit('mi.rtl.objects.consts.mi_msgbox');
    t.Dependencies.AddUnit('mi.rtl.objects.consts.progressdlg_if');
    t.Dependencies.AddUnit('mi.rtl.objects.methods');
    t.Dependencies.AddUnit('mi.rtl.objects.methods.dates');
    t.Dependencies.AddUnit('mi.rtl.objects.methods.exception');
    t.Dependencies.AddUnit('mi.rtl.objects.methods.paramexecucao');
    t.Dependencies.AddUnit('mi.rtl.objects.methods.paramexecucao.application');
    t.Dependencies.AddUnit('mi.rtl.objects.methods.streambase');
    t.Dependencies.AddUnit('mi.rtl.objects.methods.streambase.stream');
    t.Dependencies.AddUnit('mi.rtl.objects.methods.streambase.stream.filestream');
    t.Dependencies.AddUnit('mi.rtl.objects.methods.streambase.stream.memorystream');
    t.Dependencies.AddUnit('mi.rtl.objects.methods.streambase.stream.memorystream.buffermemory');
    t.Dependencies.AddUnit('mi.rtl.objects.methods.collection');
    t.Dependencies.AddUnit('mi.rtl.objects.methods.collection.filesstreams');
    t.Dependencies.AddUnit('mi.rtl.objects.methods.system');
    t.Dependencies.AddUnit('mi.rtl.objects.methods.collection.sortedcollection');
    t.Dependencies.AddUnit('mi.rtl.objects.methods.collection.sortedcollection.stringcollection');
    t.Dependencies.AddUnit('mi.rtl.objects.methods.collection.sortedcollection.stringcollection.collectionstring');
    t.Dependencies.AddUnit('mi.rtl.objects.methods.collection.sortedcollection.strcollection');
    t.Dependencies.AddUnit('mi.rtl.objects.methods.db.tb_access');
    t.Dependencies.AddUnit('mi.rtl.objects.methods.db.tb__access');
    t.Dependencies.AddUnit('mi.rtl.objects.methods.db.tb___access');
    t.Dependencies.AddUnit('mi.rtl.objects.methods.pageproducer');
    t.Dependencies.AddUnit('mi.rtl.objectss');
    t.Dependencies.AddUnit('mi_rtl_ui_types');
    t.Dependencies.AddUnit('mi_rtl_ui_consts');
    t.Dependencies.AddUnit('mi_rtl_ui_methods');
    t.Dependencies.AddUnit('mi_rtl_ui_dmxscroller_buttons');
    t.Dependencies.AddUnit('mi_rtl_ui_dmxscroller');
    t.Dependencies.AddUnit('mi_rtl_ui_dmxscroller_form');
    t.Dependencies.AddUnit('mi_rtl_ui_custom_application');

    T:=P.Targets.AddUnit('mi.rtl.pas');
    T:=P.Targets.AddUnit('units/fcl-base/src/fptemplate.pp');
    T:=P.Targets.AddUnit('units/mi.rtl.mistringlist.pas');
    T:=P.Targets.AddUnit('units/mi.rtl.mistringlistbase.pas');
    T:=P.Targets.AddUnit('units/mi.rtl.libbinres.pas');
    T:=P.Targets.AddUnit('units/mi.rtl.applicationabstract.pas');
    T:=P.Targets.AddUnit('units/mi.rtl.class_of_char.pas');
    T:=P.Targets.AddUnit('units/mi.rtl.types.pas');
    T:=P.Targets.AddUnit('units/mi.rtl.consts.pas');
    T:=P.Targets.AddUnit('units/mi.rtl.files.pas');
    T:=P.Targets.AddUnit('units/mi.rtl.consts.strerror.pas');
    T:=P.Targets.AddUnit('units/mi.rtl.objects.types.pas');
    T:=P.Targets.AddUnit('units/mi.rtl.objects.consts.pas');
    T:=P.Targets.AddUnit('units/mi.rtl.objects.consts.logs.pas');
    T:=P.Targets.AddUnit('units/mi.rtl.objects.consts.mi_msgbox.pas');
    T:=P.Targets.AddUnit('units/mi.rtl.objects.consts.progressdlg_if.pas');
    T:=P.Targets.AddUnit('units/mi.rtl.objects.methods.pas');
    T:=P.Targets.AddUnit('units/mi.rtl.objects.methods.dates.pas');
    T:=P.Targets.AddUnit('units/mi.rtl.objects.methods.exception.pas');
    T:=P.Targets.AddUnit('units/mi.rtl.objects.methods.paramexecucao.pas');
    T:=P.Targets.AddUnit('units/mi.rtl.objects.methods.paramexecucao.application.pas');
    T:=P.Targets.AddUnit('units/mi.rtl.objects.methods.streambase.pas');
    T:=P.Targets.AddUnit('units/mi.rtl.objects.methods.streambase.stream.pas');
    T:=P.Targets.AddUnit('units/mi.rtl.objects.methods.streambase.stream.filestream.pas');
    T:=P.Targets.AddUnit('units/mi.rtl.objects.methods.streambase.stream.memorystream.pas');
    T:=P.Targets.AddUnit('units/mi.rtl.objects.methods.streambase.stream.memorystream.buffermemory.pas');
    T:=P.Targets.AddUnit('units/mi.rtl.objects.methods.collection.pas');
    T:=P.Targets.AddUnit('units/mi.rtl.objects.methods.collection.filesstreams.pas');
    T:=P.Targets.AddUnit('units/mi.rtl.objects.methods.system.pas');
    T:=P.Targets.AddUnit('units/mi.rtl.objects.methods.collection.sortedcollection.pas');
    T:=P.Targets.AddUnit('units/mi.rtl.objects.methods.collection.sortedcollection.stringcollection.pas');
    T:=P.Targets.AddUnit('units/mi.rtl.objects.methods.collection.sortedcollection.stringcollection.collectionstring.pas');
    T:=P.Targets.AddUnit('units/mi.rtl.objects.methods.collection.sortedcollection.strcollection.pas');
    T:=P.Targets.AddUnit('units/mi.rtl.objects.methods.db.tb_access.pas');
    T:=P.Targets.AddUnit('units/mi.rtl.objects.methods.db.tb__access.pas');
    T:=P.Targets.AddUnit('units/mi.rtl.objects.methods.db.tb___access.pas');
    T:=P.Targets.AddUnit('units/mi.rtl.objects.methods.pageproducer.pas');
    T:=P.Targets.AddUnit('units/mi.rtl.objectss.pas');
    T:=P.Targets.AddUnit('units/mi_rtl_ui_types.pas');
    T:=P.Targets.AddUnit('units/mi_rtl_ui_consts.pas');
    T:=P.Targets.AddUnit('units/mi_rtl_ui_methods.pas');
    T:=P.Targets.AddUnit('units/mi_rtl_ui_dmxscroller_buttons.pas');
    T:=P.Targets.AddUnit('units/mi_rtl_ui_dmxscroller.pas');
    T:=P.Targets.AddUnit('units/mi_rtl_ui_dmxscroller_form.pas');
    T:=P.Targets.AddUnit('units/mi_rtl_ui_custom_application.pas');

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
