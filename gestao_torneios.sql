CREATE DATABASE IF NOT EXISTS gestao_torneios;
USE gestao_torneios;

-- Tabela Equipas
CREATE TABLE Equipas (
ID_Equipa INT AUTO_INCREMENT PRIMARY KEY,
Nome_Equipa VARCHAR(100) NOT NULL,
Data_Criacao DATE NOT NULL);

CREATE TABLE Jogadores (
ID_Jogador INT AUTO_INCREMENT PRIMARY KEY,
Nome VARCHAR(100) NOT NULL,
Nickname VARCHAR(50) NOT NULL,
Data_Nascimento DATE NOT NULL,
ID_Equipa INT NOT NULL,
FOREIGN KEY (ID_Equipa)
REFERENCES Equipas(ID_Equipa));

CREATE TABLE Torneios (
ID_Torneio INT AUTO_INCREMENT PRIMARY KEY,
Nome VARCHAR(100) NOT NULL,
Data_Inicio DATE NOT NULL,
Premio_Monetario DECIMAL(10,2) NOT NULL,
CHECK (Premio_Monetario >= 0));

CREATE TABLE Participacoes (
ID_Equipa INT NOT NULL,
ID_Torneio INT NOT NULL,
PRIMARY KEY (ID_Equipa, ID_Torneio),
FOREIGN KEY (ID_Equipa)
REFERENCES Equipas(ID_Equipa),
FOREIGN KEY (ID_Torneio)
REFERENCES Torneios(ID_Torneio)
);
insert into Equipas 
values(1,"FCPenaltis","2008-12-20"),
(2,"GordosFC","2006-12-21");

insert into Jogadores 
values(1,"Jorge Barril","Barril","2005-2-25",1),
(2,"Tiago Pinto","Pintarolas","2005-3-25",2);

insert into Torneios 
values(1,"Roubo","2026-12-30",100.99),
(2,"Trolha","2026-12-26",50.80),
(3,"Podre","2026-12-12",80.70);

insert into Participacoes 
values(1,1),
(2,3),
(2,2),
(1,2);

-- 8.a
select Nome from Jogadores;
-- 8.b
select j.Nome,e.Nome_Equipa from Jogadores j inner join Equipas e on  j.ID_Equipa=e.ID_Equipa;
-- 8.c
select e.Nome_Equipa,t.Nome from Participacoes p inner join Torneios t on p.ID_Torneio=t.ID_Torneio inner join Equipas e on p.ID_Equipa=e.ID_Equipa;
-- 8.d
select ID_Equipa,count(*) from Jogadores group by  ID_Equipa having count(*) > 1;
-- 8.e
select e.Nome_Equipa,count(j.ID_Jogador) from Jogadores j inner join Equipas e on  j.ID_Equipa=e.ID_Equipa group by e.Nome_Equipa order by count(j.ID_Jogador);
-- 8.f
select t.Nome,t.Premio_Monetario,count(p.ID_Equipa) from Participacoes p inner join Torneios t on p.ID_Torneio=t.ID_Torneio group by  Nome,Premio_Monetario having count(p.ID_Equipa)>=1;