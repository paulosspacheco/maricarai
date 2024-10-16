program Project1;


{$mode objfpc} // Habilita o modo de objetos

uses
  SysUtils;
  var number: Integer;
begin
  try
    // Código que pode gerar exceções
    Writeln('Digite um número:');

    ReadLn(number);
    try
    // Levanta uma exceção se o número for negativo
    if number < 0 then
      raise Exception.Create('Número negativo não é permitido!');

    Writeln('Número digitado: ', number);

    except
      on E: Exception do
        Writeln('Erro: ', E.Message); // Trata a exceção
      end;


  finally
    Writeln('Este código sempre será executado.'); // Limpeza ou finalização
  end;
end.

