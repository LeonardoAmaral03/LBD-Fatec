-- 1

SELECT Nrambul
FROM Ambulatorios
WHERE Capacidade = (SELECT MAX(Capacidade)
                    FROM Ambulatorios);
					
-- 2

SELECT NmMedico, COUNT(RGPaciente)
FROM Medicos, Consultas
WHERE Medicos.CRM = Consultas.CRM
GROUP BY NmMedico;

-- 3

UPDATE Consultas
SET DataConsulta = DataConsulta + '07'
WHERE Pacientes.RGPaciente = Consultas.RGPaciente AND Pacientes.Doenca = (SELECT Pacientes.Doenca
																		  FROM Pacientes
																		  WHERE Doenca = 'Alergia');

-- 4

CREATE OR REPLACE VIEW Med_Atd
	AS
		SELECT NmMedico
		FROM Medicos, Consultas
		WHERE Consultas.CRM = Medicos.CRM AND DataConsulta like '%2005'
		GROUP BY NmMedico
		HAVING COUNT(RGPacientes) > 1;
					
SELECT * FROM Med_Atd;

-- 5
 
SELECT Pacientes.RGPaciente, Pacientes.NmPaciente, Pacientes.Idade
FROM Pacientes
WHERE RGPaciente IN ((SELECT Pacientes.RGPaciente
					  FROM Pacientes, Consultas
					  WHERE Pacientes.RGPaciente = Consultas.RGPaciente)
					  MINUS
					 (SELECT Pacientes.RGPaciente
					  FROM Pacientes, Consultas, Medicos
					  WHERE Pacientes.RGPaciente = Consultas.RGPaciente AND Consultas.CRM = Medicos.CRM AND Medicos.Especialidade = 'Cardiologista'));
					   
-- 6

SELECT Ambulatorios.Nrambul, Ambulatorios.Nrandar, Pacientes.NmPaciente
FROM Pacientes, Medicos, Consultas, Ambulatorios
WHERE (NmMedico = 'João Carlos santos' OR NmMedico = 'Maria Souza') AND Doenca = 'Pneumonia' AND Pacientes.RGPaciente = Consultas.RGPaciente AND Consultas.CRM = Medicos.CRM AND Medicos.Nrambul = Ambulatorios.Nrambul;

-- 7

SELECT Medicos.NmMedico, Consultas.DataConsulta
FROM Medicos, Consultas
WHERE DataConsulta > (SELECT AVG(Consultas.DataConsulta)
					  FROM Consultas);
					  
-- 8

UPDATE Ambulatorios
SET Nrandar = '2º'
WHERE Medicos.NmMedico = 'João Carlos Souza' AND Medicos.Nrambul = Ambulatorios.Nrambul;