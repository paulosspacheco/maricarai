USE DBADMESCOLA; --Com esta, todos os próximos scripts serão criados em DBADMESCOLA

--As próximas linhas podem ser executadas todas ao mesmo tempo
--TB_PESSOA
INSERT INTO TB_PESSOA (NU_MATRICULA, NO_PESSOA) VALUES ('010001', 'MAYANA');
INSERT INTO TB_PESSOA (NU_MATRICULA, NO_PESSOA) VALUES ('010002', 'KATIUSCIA');
INSERT INTO TB_PESSOA (NU_MATRICULA, NO_PESSOA) VALUES ('010003', 'GRACIANA');
INSERT INTO TB_PESSOA (NU_MATRICULA, NO_PESSOA) VALUES ('010004', 'MARCELO');
INSERT INTO TB_PESSOA (NU_MATRICULA, NO_PESSOA) VALUES ('010005', 'ARLETE');
INSERT INTO TB_PESSOA (NU_MATRICULA, NO_PESSOA) VALUES ('010006', 'WILLIAM');
INSERT INTO TB_PESSOA (NU_MATRICULA, NO_PESSOA) VALUES ('010007', 'ADRIANO');
INSERT INTO TB_PESSOA (NU_MATRICULA, NO_PESSOA) VALUES ('010008', 'GERALDO');
INSERT INTO TB_PESSOA (NU_MATRICULA, NO_PESSOA) VALUES ('010009', 'MOISÉS');
INSERT INTO TB_PESSOA (NU_MATRICULA, NO_PESSOA) VALUES ('020001', 'CRISTIANO');

--TB_CURSO
INSERT INTO TB_CURSO (NU_CURSO, NO_CURSO) VALUES ('SQ01', 'SQL SERVER 2012');
INSERT INTO TB_CURSO (NU_CURSO, NO_CURSO) VALUES ('JV01', 'JAVA WEB 8');

--TB_CONTEUDO_PROGRAMATICO
INSERT INTO TB_CONTEUDO_PROGRAMATICO (NU_AULA, DT_AULA, DS_CONTEUDO, CO_PESSOA, CO_CURSO)
       VALUES (1, '23/09/2017', 'REVISÃO DE CONSTRAINTS: PK, UK, CK e FK, E JOIN ENTRE TABELAS',
          (SELECT CO_SEQ_PESSOA FROM TB_PESSOA WHERE NU_MATRICULA = '020001'),
          (SELECT CO_SEQ_CURSO FROM TB_CURSO WHERE NU_CURSO = 'SQ01'));

INSERT INTO TB_CONTEUDO_PROGRAMATICO (NU_AULA, DT_AULA, DS_CONTEUDO, CO_PESSOA, CO_CURSO)
       VALUES (2, '30/09/2017', 'JOIN, LEFT JOIN E RIGHT JOIN E NORMALIZAÇÃO DE TABELA',
         (SELECT CO_SEQ_PESSOA FROM TB_PESSOA WHERE NU_MATRICULA = '020001'),
         (SELECT CO_SEQ_CURSO FROM TB_CURSO WHERE NU_CURSO = 'SQ01'));

INSERT INTO TB_CONTEUDO_PROGRAMATICO (NU_AULA, DT_AULA, DS_CONTEUDO, CO_PESSOA, CO_CURSO)
       VALUES (3, '07/1//0/2017', 'ALTERAÇÃO DO NOME DE TB_PESSOA PARA TB_PESSOA E CRIAÇÃO DE UK COMPOSTA EM TB_AULA',
         (SELECT CO_SEQ_PESSOA FROM TB_PESSOA WHERE NU_MATRICULA = '020001'),
         (SELECT CO_SEQ_CURSO FROM TB_CURSO WHERE NU_CURSO = 'SQ01'));

INSERT INTO TB_CONTEUDO_PROGRAMATICO (NU_AULA, DT_AULA, DS_CONTEUDO, CO_PESSOA, CO_CURSO)
       VALUES (4, '21/10/2017', 'CRIAÇÃO DE TB_PESSOA_TIPO E TB_TIPO_PESSOA; TRIGGER',
         (SELECT CO_SEQ_PESSOA FROM TB_PESSOA WHERE NU_MATRICULA = '020001'),
         (SELECT CO_SEQ_CURSO FROM TB_CURSO WHERE NU_CURSO = 'SQ01'));

INSERT INTO TB_CONTEUDO_PROGRAMATICO (NU_AULA, DT_AULA, DS_CONTEUDO, CO_PESSOA, CO_CURSO)
       VALUES (1, '23/10/2017', 'CONFIGURAÇÃO DO AMBIENTE DE ESTUDO; ATRIBUTO, MÉTODO E CLASSE',
         (SELECT CO_SEQ_PESSOA FROM TB_PESSOA WHERE NU_MATRICULA = '020001'),
         (SELECT CO_SEQ_CURSO FROM TB_CURSO WHERE NU_CURSO = 'JV01'));

--TB_AULA
INSERT INTO TB_AULA (DT_AULA, TP_PRESENCA, CO_PESSOA, CO_CONTEUDOPROGRAMATICO)
             VALUES ('23/09/2017 11:36:00', 'P', (SELECT CO_SEQ_PESSOA FROM TB_PESSOA WHERE NU_MATRICULA = '010001'),
                     (SELECT CO_SEQ_CONTEUDOPROGRAMATICO
                        FROM TB_CONTEUDO_PROGRAMATICO
                       WHERE NU_AULA = 1
                         AND CO_PESSOA = (SELECT CO_SEQ_PESSOA FROM TB_PESSOA WHERE NU_MATRICULA = '020001')));
INSERT INTO TB_AULA (DT_AULA, TP_PRESENCA, CO_PESSOA, CO_CONTEUDOPROGRAMATICO)
             VALUES ('23/09/2017 11:36:00', 'P', (SELECT CO_SEQ_PESSOA FROM TB_PESSOA WHERE NU_MATRICULA = '010002'),
                     (SELECT CO_SEQ_CONTEUDOPROGRAMATICO
                        FROM TB_CONTEUDO_PROGRAMATICO
                       WHERE NU_AULA = 1
                         AND CO_PESSOA = (SELECT CO_SEQ_PESSOA FROM TB_PESSOA WHERE NU_MATRICULA = '020001')));
INSERT INTO TB_AULA (DT_AULA, TP_PRESENCA, CO_PESSOA, CO_CONTEUDOPROGRAMATICO)
             VALUES ('23/09/2017 11:36:00', 'P', (SELECT CO_SEQ_PESSOA FROM TB_PESSOA WHERE NU_MATRICULA = '010003'),
                     (SELECT CO_SEQ_CONTEUDOPROGRAMATICO
                        FROM TB_CONTEUDO_PROGRAMATICO
                       WHERE NU_AULA = 1
                         AND CO_PESSOA = (SELECT CO_SEQ_PESSOA FROM TB_PESSOA WHERE NU_MATRICULA = '020001')));
INSERT INTO TB_AULA (DT_AULA, TP_PRESENCA, CO_PESSOA, CO_CONTEUDOPROGRAMATICO)
             VALUES ('23/09/2017 11:36:00', 'P', (SELECT CO_SEQ_PESSOA FROM TB_PESSOA WHERE NU_MATRICULA = '010004'),
                     (SELECT CO_SEQ_CONTEUDOPROGRAMATICO
                        FROM TB_CONTEUDO_PROGRAMATICO
                       WHERE NU_AULA = 1
                         AND CO_PESSOA = (SELECT CO_SEQ_PESSOA FROM TB_PESSOA WHERE NU_MATRICULA = '020001')));
INSERT INTO TB_AULA (DT_AULA, TP_PRESENCA, CO_PESSOA, CO_CONTEUDOPROGRAMATICO)
             VALUES ('23/09/2017 11:36:00', 'P', (SELECT CO_SEQ_PESSOA FROM TB_PESSOA WHERE NU_MATRICULA = '010005'),
                     (SELECT CO_SEQ_CONTEUDOPROGRAMATICO
                        FROM TB_CONTEUDO_PROGRAMATICO
                       WHERE NU_AULA = 1
                         AND CO_PESSOA = (SELECT CO_SEQ_PESSOA FROM TB_PESSOA WHERE NU_MATRICULA = '020001')));
INSERT INTO TB_AULA (DT_AULA, TP_PRESENCA, CO_PESSOA, CO_CONTEUDOPROGRAMATICO)
             VALUES ('23/09/2017 11:36:00', 'P', (SELECT CO_SEQ_PESSOA FROM TB_PESSOA WHERE NU_MATRICULA = '010006'),
                     (SELECT CO_SEQ_CONTEUDOPROGRAMATICO
                        FROM TB_CONTEUDO_PROGRAMATICO
                       WHERE NU_AULA = 1
                         AND CO_PESSOA = (SELECT CO_SEQ_PESSOA FROM TB_PESSOA WHERE NU_MATRICULA = '020001')));
INSERT INTO TB_AULA (DT_AULA, TP_PRESENCA, CO_PESSOA, CO_CONTEUDOPROGRAMATICO)
             VALUES ('23/09/2017 11:36:00', 'P', (SELECT CO_SEQ_PESSOA FROM TB_PESSOA WHERE NU_MATRICULA = '010007'),
                     (SELECT CO_SEQ_CONTEUDOPROGRAMATICO
                        FROM TB_CONTEUDO_PROGRAMATICO
                       WHERE NU_AULA = 1
                         AND CO_PESSOA = (SELECT CO_SEQ_PESSOA FROM TB_PESSOA WHERE NU_MATRICULA = '020001')));

INSERT INTO TB_AULA (DT_AULA, TP_PRESENCA, CO_PESSOA, CO_CONTEUDOPROGRAMATICO)
             VALUES ('30/09/2017 12:47:00', 'P',(SELECT CO_SEQ_PESSOA FROM TB_PESSOA WHERE NU_MATRICULA = '010001'),
                     (SELECT CO_SEQ_CONTEUDOPROGRAMATICO
                        FROM TB_CONTEUDO_PROGRAMATICO
                       WHERE NU_AULA = 2
                         AND CO_PESSOA = (SELECT CO_SEQ_PESSOA FROM TB_PESSOA WHERE NU_MATRICULA = '020001')));
INSERT INTO TB_AULA (DT_AULA, TP_PRESENCA, CO_PESSOA, CO_CONTEUDOPROGRAMATICO)
             VALUES ('30/09/2017 12:47:00', 'P',(SELECT CO_SEQ_PESSOA FROM TB_PESSOA WHERE NU_MATRICULA = '010002'),
                     (SELECT CO_SEQ_CONTEUDOPROGRAMATICO
                        FROM TB_CONTEUDO_PROGRAMATICO
                       WHERE NU_AULA = 2
                         AND CO_PESSOA = (SELECT CO_SEQ_PESSOA FROM TB_PESSOA WHERE NU_MATRICULA = '020001')));
INSERT INTO TB_AULA (DT_AULA, TP_PRESENCA, CO_PESSOA, CO_CONTEUDOPROGRAMATICO)
             VALUES ('30/09/2017 12:47:00', 'P',(SELECT CO_SEQ_PESSOA FROM TB_PESSOA WHERE NU_MATRICULA = '010003'),
                     (SELECT CO_SEQ_CONTEUDOPROGRAMATICO
                        FROM TB_CONTEUDO_PROGRAMATICO
                       WHERE NU_AULA = 2
                         AND CO_PESSOA = (SELECT CO_SEQ_PESSOA FROM TB_PESSOA WHERE NU_MATRICULA = '020001')));
INSERT INTO TB_AULA (DT_AULA, TP_PRESENCA, CO_PESSOA, CO_CONTEUDOPROGRAMATICO)
             VALUES ('30/09/2017 12:47:00', 'P',(SELECT CO_SEQ_PESSOA FROM TB_PESSOA WHERE NU_MATRICULA = '010004'),
                     (SELECT CO_SEQ_CONTEUDOPROGRAMATICO
                        FROM TB_CONTEUDO_PROGRAMATICO
                       WHERE NU_AULA = 2
                         AND CO_PESSOA = (SELECT CO_SEQ_PESSOA FROM TB_PESSOA WHERE NU_MATRICULA = '020001')));
INSERT INTO TB_AULA (DT_AULA, TP_PRESENCA, CO_PESSOA, CO_CONTEUDOPROGRAMATICO)
             VALUES ('30/09/2017 12:47:00', 'P',(SELECT CO_SEQ_PESSOA FROM TB_PESSOA WHERE NU_MATRICULA = '010005'),
                     (SELECT CO_SEQ_CONTEUDOPROGRAMATICO
                        FROM TB_CONTEUDO_PROGRAMATICO
                       WHERE NU_AULA = 2
                         AND CO_PESSOA = (SELECT CO_SEQ_PESSOA FROM TB_PESSOA WHERE NU_MATRICULA = '020001')));
INSERT INTO TB_AULA (DT_AULA, TP_PRESENCA, CO_PESSOA, CO_CONTEUDOPROGRAMATICO)
             VALUES ('30/09/2017 12:47:00', 'F',(SELECT CO_SEQ_PESSOA FROM TB_PESSOA WHERE NU_MATRICULA = '010006'),
                     (SELECT CO_SEQ_CONTEUDOPROGRAMATICO
                        FROM TB_CONTEUDO_PROGRAMATICO
                       WHERE NU_AULA = 2
                         AND CO_PESSOA = (SELECT CO_SEQ_PESSOA FROM TB_PESSOA WHERE NU_MATRICULA = '020001')));
INSERT INTO TB_AULA (DT_AULA, TP_PRESENCA, CO_PESSOA, CO_CONTEUDOPROGRAMATICO)
             VALUES ('30/09/2017 12:47:00', 'P',(SELECT CO_SEQ_PESSOA FROM TB_PESSOA WHERE NU_MATRICULA = '010007'),
                     (SELECT CO_SEQ_CONTEUDOPROGRAMATICO
                        FROM TB_CONTEUDO_PROGRAMATICO
                       WHERE NU_AULA = 2
                         AND CO_PESSOA = (SELECT CO_SEQ_PESSOA FROM TB_PESSOA WHERE NU_MATRICULA = '020001')));
INSERT INTO TB_AULA (DT_AULA, TP_PRESENCA, CO_PESSOA, CO_CONTEUDOPROGRAMATICO)
             VALUES ('30/09/2017 12:47:00', 'P',(SELECT CO_SEQ_PESSOA FROM TB_PESSOA WHERE NU_MATRICULA = '010008'),
                     (SELECT CO_SEQ_CONTEUDOPROGRAMATICO
                        FROM TB_CONTEUDO_PROGRAMATICO
                       WHERE NU_AULA = 2
                         AND CO_PESSOA = (SELECT CO_SEQ_PESSOA FROM TB_PESSOA WHERE NU_MATRICULA = '020001')));

INSERT INTO TB_AULA (DT_AULA, TP_PRESENCA, CO_PESSOA, CO_CONTEUDOPROGRAMATICO)
             VALUES ('07/10/2017 12:47:00', 'P',(SELECT CO_SEQ_PESSOA FROM TB_PESSOA WHERE NU_MATRICULA = '010001'),
			         (SELECT CO_SEQ_CONTEUDOPROGRAMATICO
					    FROM TB_CONTEUDO_PROGRAMATICO
					   WHERE NU_AULA = 3
					     AND CO_PESSOA = (SELECT CO_SEQ_PESSOA FROM TB_PESSOA WHERE NU_MATRICULA = '020001')));
INSERT INTO TB_AULA (DT_AULA, TP_PRESENCA, CO_PESSOA, CO_CONTEUDOPROGRAMATICO)
             VALUES ('07/10/2017 12:47:00', 'P',(SELECT CO_SEQ_PESSOA FROM TB_PESSOA WHERE NU_MATRICULA = '010002'),
			         (SELECT CO_SEQ_CONTEUDOPROGRAMATICO
					    FROM TB_CONTEUDO_PROGRAMATICO
					   WHERE NU_AULA = 3
					     AND CO_PESSOA = (SELECT CO_SEQ_PESSOA FROM TB_PESSOA WHERE NU_MATRICULA = '020001')));
INSERT INTO TB_AULA (DT_AULA, TP_PRESENCA, CO_PESSOA, CO_CONTEUDOPROGRAMATICO)
             VALUES ('07/10/2017 12:47:00', 'P',(SELECT CO_SEQ_PESSOA FROM TB_PESSOA WHERE NU_MATRICULA = '010003'),
			         (SELECT CO_SEQ_CONTEUDOPROGRAMATICO
					    FROM TB_CONTEUDO_PROGRAMATICO
					   WHERE NU_AULA = 3
					     AND CO_PESSOA = (SELECT CO_SEQ_PESSOA FROM TB_PESSOA WHERE NU_MATRICULA = '020001')));
INSERT INTO TB_AULA (DT_AULA, TP_PRESENCA, CO_PESSOA, CO_CONTEUDOPROGRAMATICO)
             VALUES ('07/10/2017 12:47:00', 'P',(SELECT CO_SEQ_PESSOA FROM TB_PESSOA WHERE NU_MATRICULA = '010004'),
			         (SELECT CO_SEQ_CONTEUDOPROGRAMATICO
					    FROM TB_CONTEUDO_PROGRAMATICO
					   WHERE NU_AULA = 3
					     AND CO_PESSOA = (SELECT CO_SEQ_PESSOA FROM TB_PESSOA WHERE NU_MATRICULA = '020001')));
INSERT INTO TB_AULA (DT_AULA, TP_PRESENCA, CO_PESSOA, CO_CONTEUDOPROGRAMATICO)
             VALUES ('07/10/2017 12:47:00', 'P',(SELECT CO_SEQ_PESSOA FROM TB_PESSOA WHERE NU_MATRICULA = '010005'),
			         (SELECT CO_SEQ_CONTEUDOPROGRAMATICO
					    FROM TB_CONTEUDO_PROGRAMATICO
					   WHERE NU_AULA = 3
					     AND CO_PESSOA = (SELECT CO_SEQ_PESSOA FROM TB_PESSOA WHERE NU_MATRICULA = '020001')));
INSERT INTO TB_AULA (DT_AULA, TP_PRESENCA, CO_PESSOA, CO_CONTEUDOPROGRAMATICO)
             VALUES ('07/10/2017 12:47:00', 'F',(SELECT CO_SEQ_PESSOA FROM TB_PESSOA WHERE NU_MATRICULA = '010006'),
			         (SELECT CO_SEQ_CONTEUDOPROGRAMATICO
					    FROM TB_CONTEUDO_PROGRAMATICO
					   WHERE NU_AULA = 3
					     AND CO_PESSOA = (SELECT CO_SEQ_PESSOA FROM TB_PESSOA WHERE NU_MATRICULA = '020001')));
INSERT INTO TB_AULA (DT_AULA, TP_PRESENCA, CO_PESSOA, CO_CONTEUDOPROGRAMATICO)
             VALUES ('07/10/2017 12:47:00', 'P',(SELECT CO_SEQ_PESSOA FROM TB_PESSOA WHERE NU_MATRICULA = '010007'),
			         (SELECT CO_SEQ_CONTEUDOPROGRAMATICO
					    FROM TB_CONTEUDO_PROGRAMATICO
					   WHERE NU_AULA = 3
					     AND CO_PESSOA = (SELECT CO_SEQ_PESSOA FROM TB_PESSOA WHERE NU_MATRICULA = '020001')));
INSERT INTO TB_AULA (DT_AULA, TP_PRESENCA, CO_PESSOA, CO_CONTEUDOPROGRAMATICO)
             VALUES ('07/10/2017 12:47:00', 'P',(SELECT CO_SEQ_PESSOA FROM TB_PESSOA WHERE NU_MATRICULA = '010008'),
			         (SELECT CO_SEQ_CONTEUDOPROGRAMATICO
					    FROM TB_CONTEUDO_PROGRAMATICO
					   WHERE NU_AULA = 3
					     AND CO_PESSOA = (SELECT CO_SEQ_PESSOA FROM TB_PESSOA WHERE NU_MATRICULA = '020001')));
INSERT INTO TB_AULA (DT_AULA, TP_PRESENCA, CO_PESSOA, CO_CONTEUDOPROGRAMATICO)
             VALUES ('07/10/2017 12:47:00', 'P',(SELECT CO_SEQ_PESSOA FROM TB_PESSOA WHERE NU_MATRICULA = '010009'),
			         (SELECT CO_SEQ_CONTEUDOPROGRAMATICO
					    FROM TB_CONTEUDO_PROGRAMATICO
					   WHERE NU_AULA = 3
					     AND CO_PESSOA = (SELECT CO_SEQ_PESSOA FROM TB_PESSOA WHERE NU_MATRICULA = '020001')));

INSERT INTO TB_AULA (DT_AULA, TP_PRESENCA, CO_PESSOA, CO_CONTEUDOPROGRAMATICO)
             VALUES ('21/10/2017 12:47:00', 'P',(SELECT CO_SEQ_PESSOA FROM TB_PESSOA WHERE NU_MATRICULA = '010001'),
			         (SELECT CO_SEQ_CONTEUDOPROGRAMATICO
					    FROM TB_CONTEUDO_PROGRAMATICO
					   WHERE NU_AULA = 4
					     AND CO_PESSOA = (SELECT CO_SEQ_PESSOA FROM TB_PESSOA WHERE NU_MATRICULA = '020001')));
INSERT INTO TB_AULA (DT_AULA, TP_PRESENCA, CO_PESSOA, CO_CONTEUDOPROGRAMATICO)
             VALUES ('21/10/2017 12:47:00', 'P',(SELECT CO_SEQ_PESSOA FROM TB_PESSOA WHERE NU_MATRICULA = '010002'),
			         (SELECT CO_SEQ_CONTEUDOPROGRAMATICO
					    FROM TB_CONTEUDO_PROGRAMATICO
					   WHERE NU_AULA = 4
					     AND CO_PESSOA = (SELECT CO_SEQ_PESSOA FROM TB_PESSOA WHERE NU_MATRICULA = '020001')));
INSERT INTO TB_AULA (DT_AULA, TP_PRESENCA, CO_PESSOA, CO_CONTEUDOPROGRAMATICO)
             VALUES ('21/10/2017 12:47:00', 'P',(SELECT CO_SEQ_PESSOA FROM TB_PESSOA WHERE NU_MATRICULA = '010003'),
			         (SELECT CO_SEQ_CONTEUDOPROGRAMATICO
					    FROM TB_CONTEUDO_PROGRAMATICO
					   WHERE NU_AULA = 4
					     AND CO_PESSOA = (SELECT CO_SEQ_PESSOA FROM TB_PESSOA WHERE NU_MATRICULA = '020001')));

INSERT INTO TB_AULA (DT_AULA, TP_PRESENCA, CO_PESSOA, CO_CONTEUDOPROGRAMATICO)
             VALUES ('21/10/2017 12:47:00', 'P',(SELECT CO_SEQ_PESSOA FROM TB_PESSOA WHERE NU_MATRICULA = '010004'),
			         (SELECT CO_SEQ_CONTEUDOPROGRAMATICO
					    FROM TB_CONTEUDO_PROGRAMATICO
					   WHERE NU_AULA = 4
					     AND CO_PESSOA = (SELECT CO_SEQ_PESSOA FROM TB_PESSOA WHERE NU_MATRICULA = '020001')));
INSERT INTO TB_AULA (DT_AULA, TP_PRESENCA, CO_PESSOA, CO_CONTEUDOPROGRAMATICO)
             VALUES ('21/10/2017 12:47:00', 'P',(SELECT CO_SEQ_PESSOA FROM TB_PESSOA WHERE NU_MATRICULA = '010005'),
			         (SELECT CO_SEQ_CONTEUDOPROGRAMATICO
					    FROM TB_CONTEUDO_PROGRAMATICO
					   WHERE NU_AULA = 4
					     AND CO_PESSOA = (SELECT CO_SEQ_PESSOA FROM TB_PESSOA WHERE NU_MATRICULA = '020001')));
INSERT INTO TB_AULA (DT_AULA, TP_PRESENCA, CO_PESSOA, CO_CONTEUDOPROGRAMATICO)
             VALUES ('21/10/2017 12:47:00', 'F',(SELECT CO_SEQ_PESSOA FROM TB_PESSOA WHERE NU_MATRICULA = '010006'),
			         (SELECT CO_SEQ_CONTEUDOPROGRAMATICO
					    FROM TB_CONTEUDO_PROGRAMATICO
					   WHERE NU_AULA = 4
					     AND CO_PESSOA = (SELECT CO_SEQ_PESSOA FROM TB_PESSOA WHERE NU_MATRICULA = '020001')));
INSERT INTO TB_AULA (DT_AULA, TP_PRESENCA, CO_PESSOA, CO_CONTEUDOPROGRAMATICO)
             VALUES ('21/10/2017 12:47:00', 'P',(SELECT CO_SEQ_PESSOA FROM TB_PESSOA WHERE NU_MATRICULA = '010007'),
			         (SELECT CO_SEQ_CONTEUDOPROGRAMATICO
					    FROM TB_CONTEUDO_PROGRAMATICO
					   WHERE NU_AULA = 4
					     AND CO_PESSOA = (SELECT CO_SEQ_PESSOA FROM TB_PESSOA WHERE NU_MATRICULA = '020001')));
INSERT INTO TB_AULA (DT_AULA, TP_PRESENCA, CO_PESSOA, CO_CONTEUDOPROGRAMATICO)
             VALUES ('21/10/2017 12:47:00', 'F',(SELECT CO_SEQ_PESSOA FROM TB_PESSOA WHERE NU_MATRICULA = '010008'),
			         (SELECT CO_SEQ_CONTEUDOPROGRAMATICO
					    FROM TB_CONTEUDO_PROGRAMATICO
					   WHERE NU_AULA = 4
					     AND CO_PESSOA = (SELECT CO_SEQ_PESSOA FROM TB_PESSOA WHERE NU_MATRICULA = '020001')));
INSERT INTO TB_AULA (DT_AULA, TP_PRESENCA, CO_PESSOA, CO_CONTEUDOPROGRAMATICO)
             VALUES ('21/10/2017 12:47:00', 'F',(SELECT CO_SEQ_PESSOA FROM TB_PESSOA WHERE NU_MATRICULA = '010009'),
			         (SELECT CO_SEQ_CONTEUDOPROGRAMATICO
					    FROM TB_CONTEUDO_PROGRAMATICO
					   WHERE NU_AULA = 4
					     AND CO_PESSOA = (SELECT CO_SEQ_PESSOA FROM TB_PESSOA WHERE NU_MATRICULA = '020001')));

INSERT INTO TB_AULA (DT_AULA, TP_PRESENCA, CO_PESSOA, CO_CONTEUDOPROGRAMATICO)
             VALUES ('23/10/2017 19:35:00', 'P', (SELECT CO_SEQ_PESSOA FROM TB_PESSOA WHERE NU_MATRICULA = '010009'),
		             (SELECT CP.CO_SEQ_CONTEUDOPROGRAMATICO
					    FROM TB_CONTEUDO_PROGRAMATICO CP, TB_CURSO C
 		               WHERE CP.CO_CURSO = C.CO_SEQ_CURSO
		                 AND CP.NU_AULA = 1
		                 AND C.NU_CURSO = 'JV01'));
INSERT INTO TB_AULA (DT_AULA, TP_PRESENCA, CO_PESSOA, CO_CONTEUDOPROGRAMATICO)
             VALUES ('23/10/2017 19:35:00', 'P', (SELECT CO_SEQ_PESSOA FROM TB_PESSOA WHERE NU_MATRICULA = '010006'),
		             (SELECT CP.CO_SEQ_CONTEUDOPROGRAMATICO
		                FROM TB_CONTEUDO_PROGRAMATICO CP, TB_CURSO C
   		               WHERE CP.CO_CURSO = C.CO_SEQ_CURSO
     		             AND CP.NU_AULA = 1
		                 AND C.NU_CURSO = 'JV01'));
INSERT INTO TB_AULA (DT_AULA, TP_PRESENCA, CO_PESSOA, CO_CONTEUDOPROGRAMATICO)
             VALUES ('23/10/2017 19:35:00', 'P', (SELECT CO_SEQ_PESSOA FROM TB_PESSOA WHERE NU_MATRICULA = '010005'),
		             (SELECT CP.CO_SEQ_CONTEUDOPROGRAMATICO
					    FROM TB_CONTEUDO_PROGRAMATICO CP, TB_CURSO C
 		               WHERE CP.CO_CURSO = C.CO_SEQ_CURSO
		                 AND CP.NU_AULA = 1
		                 AND C.NU_CURSO = 'JV01'));

--CONFERENCIA
SELECT COUNT (*) FROM TB_PESSOA; --10 REGISTROS
SELECT COUNT (*) FROM TB_CONTEUDO_PROGRAMATICO; --2 REGISTROS
SELECT COUNT (*) FROM TB_AULA; --15 REGISTROS