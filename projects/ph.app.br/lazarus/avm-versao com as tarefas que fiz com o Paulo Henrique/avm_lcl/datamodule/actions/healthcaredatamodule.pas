unit HealthCareDataModule;

{$mode Delphi}

interface

uses
  Classes, SysUtils, ActnList;

type

  { TDataModule1 }

  TDataModule1 = class(TDataModule)
        ActionList1: TActionList;
        // Ações para Operadores
        acOperadoresIncluir: TAction;
        acOperadoresExcluir: TAction;
        acOperadoresAlterar: TAction;
        acOperadoresConsultar: TAction;
        // Ações para Hospitais
        acHospitaisIncluir: TAction;
        acHospitaisExcluir: TAction;
        acHospitaisAlterar: TAction;
        acHospitaisConsultar: TAction;
        // Ações para Status da Agenda ou Consulta
        acStatusAgendaIncluir: TAction;
        acStatusAgendaExcluir: TAction;
        acStatusAgendaAlterar: TAction;
        acStatusAgendaConsultar: TAction;
        // Ações para Médicos
        acMedicosIncluir: TAction;
        acMedicosExcluir: TAction;
        acMedicosAlterar: TAction;
        acMedicosConsultar: TAction;
        // Ações para Serviço de Agendas
        acServicoAgendasIncluir: TAction;
        acServicoAgendasExcluir: TAction;
        acServicoAgendasAlterar: TAction;
        acServicoAgendasConsultar: TAction;
        // Ações para Convênios
        acConveniosIncluir: TAction;
        acConveniosExcluir: TAction;
        acConveniosAlterar: TAction;
        acConveniosConsultar: TAction;
        // Ações para Clientes
        acClientesIncluir: TAction;
        acClientesExcluir: TAction;
        acClientesAlterar: TAction;
        acClientesConsultar: TAction;
        // Ações para Integração
        acIntegracaoIncluir: TAction;
        acIntegracaoExcluir: TAction;
        acIntegracaoAlterar: TAction;
        acIntegracaoConsultar: TAction;
        // Ações para Expediente do Médico (Data)
        acExpedienteDataIncluir: TAction;
        acExpedienteDataExcluir: TAction;
        acExpedienteDataAlterar: TAction;
        acExpedienteDataConsultar: TAction;
        // Ações para Expediente do Médico (Horas)
        acExpedienteHorasIncluir: TAction;
        acExpedienteHorasExcluir: TAction;
        acExpedienteHorasAlterar: TAction;
        acExpedienteHorasConsultar: TAction;
        // Ações para Agenda
        acAgendaIncluir: TAction;
        acAgendaExcluir: TAction;
        acAgendaAlterar: TAction;
        acAgendaConsultar: TAction;
        // Ações para Formas de Pagamento
        acFormasPagamentoIncluir: TAction;
        acFormasPagamentoExcluir: TAction;
        acFormasPagamentoAlterar: TAction;
        acFormasPagamentoConsultar: TAction;
        // Ações para Consulta
        acConsultaIncluir: TAction;
        acConsultaExcluir: TAction;
        acConsultaAlterar: TAction;
        acConsultaConsultar: TAction;
        procedure acAgendaIncluirExecute(Sender: TObject);

      private
        { Private declarations }
      public
        { Public declarations }
      end;



var
  DataModule1: TDataModule1;

implementation

{$R *.lfm}

{ TDataModule1 }

procedure TDataModule1.acAgendaIncluirExecute(Sender: TObject);
begin

end;

end.

