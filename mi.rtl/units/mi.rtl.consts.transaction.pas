unit mi.rtl.Consts.transaction;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,sqlDb
  ,mi.rtl.Consts;


  type

    { TMi_Transaction }
    {: A class **name** usada para gerenciar se uma transação esta ativa ou não
       porque várias tabelas poder ser abertas dentro de uma transação porém o
       startransaction deve ser chamado somente uma vêz.
    }
    TMi_Transaction = Class(TConsts)
      public constructor Create(aowner:TComponent);Overload;Override;

      {: O atributo **@name** deve ser assinalado pela aplicação principal onde
        as trasações são definidas}
      public SQLTransaction:TSQLTransaction;

      {: O método **@name** inicia uma transação se puder.

         - **RESULT**
           - True
             - Se a transação atual for false;
           - false
             - Se a transação atual for true;

           - **Objetivo:
             - Permitir que após o processamento, só executar commit ou rollback
               se StartTransaction tenha retornado true;

           - EXEMPLO DE USO

             ```pascal

                Function AddRec:Boolean;
                Var
                  Finalize : boolean;
                begin
                  try //Excepet

                    Finalize := StartTransaction;

                    AddRec;

                    if Finalize
                    then Commit

                  Except
                    On E : Exception do
                    begin
                      if finalize
                      then Roolback;

                      Raise TException.Create(Self,'AddRec',E.Message);
                    end;
                end;

             ```

      }
      public function StartTransaction:Boolean; Overload;

      {: O método **@name** confirme a transação no banco de dados}
      public function COMMIT:Boolean;Overload;

      {: O método **@name** anula a transação do banco de dados}
      public procedure Rollback;


    end;

implementation

{ TMi_Transaction }

constructor TMi_Transaction.Create(aowner: TComponent);
begin
  inherited Create(aowner);
  if aOwner is TSQLTransaction
  then SQLTransaction := aOwner as TSQLTransaction
  else SQLTransaction := nil;
end;

function TMi_Transaction.StartTransaction: Boolean;
begin
  if Assigned(SQLTransaction) and (not ok_Set_Transaction)
  then begin
         Result := SQLTransaction.Active;
         if Not Result
         Then begin
                SQLTransaction.Active := true;
                //SQLTransaction.StartTransaction;
                Result := SQLTransaction.Active;
              end;
         ok_Set_Transaction := Result;
       end
  else Result := false;
end;


function TMi_Transaction.COMMIT: Boolean;
begin
  if Assigned(SQLTransaction) and SQLTransaction.Active
  Then begin
         //SQLTransaction.Action:= caCommitRetaining;
         SQLTransaction.Action:= caCommit;
         SQLTransaction.EndTransaction;
         SQLTransaction.Active := false;
//         SQLTransaction.CommitRetaining;
         ok_Set_Transaction := SQLTransaction.Active;
         result := true;
         if Assigned(C_MessageError)
         then C_MessageError;
       end
  else Result := false;

  //if Assigned(SQLTransaction)
  //then ok_Set_Transaction := SQLTransaction.Active;
end;

procedure TMi_Transaction.Rollback;
begin
  if Assigned(SQLTransaction) and SQLTransaction.Active
  Then begin
         //SQLTransaction.Action:= caRollbackRetaining;
         SQLTransaction.Action:= caRollback;
         SQLTransaction.EndTransaction;
         SQLTransaction.Active := false;
//         SQLTransaction.RollbackRetaining;
         ok_Set_Transaction := false;

         if Assigned(C_MessageError)
         then C_MessageError;
       end
end;



end.

