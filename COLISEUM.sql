GO 
USE master
GO
IF EXISTS (SELECT * FROM sysdatabases WHERE NAME='COLISEUM')
		DROP DATABASE COLISEUM
GO
CREATE DATABASE COLISEUM
GO
USE COLISEUM
GO
CREATE TABLE C_Habilidad(
	Apodo VarChar(30) PRIMARY KEY,
	Descripcion VarChar(200) NOT NULL 
	)
GO
CREATE TABLE C_Arma(
	ID Int PRIMARY KEY,
	Nombre VarChar(40) NOT NULL,
	Daño Int NOT NULL,
	Tipo Char(5) NOT NULL,
	Categoria SmallInt NOT NULL,
	Precio Money NOT NULL,

	CONSTRAINT CK_DañoArma CHECK (Daño BETWEEN 0 AND 100),
	CONSTRAINT CK_Tipo CHECK (Tipo IN ('CORT','PERF','CONT','MIST')),
	CONSTRAINT CK_CategoriaArma CHECK (Categoria BETWEEN 1 AND 5)
	)
GO
CREATE TABLE C_Mascota(
	ID Int PRIMARY KEY,
	Especie VarChar(20) NOT NULL,
	Daño Int NOT NULL,
	Categoria SmallInt NOT NULL,
	Precio Money NOT NULL,

	CONSTRAINT CK_DañoMascota CHECK (Daño BETWEEN 0 AND 100),
	CONSTRAINT CK_CategoriaMascota CHECK (Categoria BETWEEN 1 AND 5)
	)
GO
CREATE TABLE C_Combate(
	ID Int PRIMARY KEY,
	Fecha Date NOT NULL,
	Rondas Int NOT NULL
	)
GO 
CREATE TABLE C_Gladiador (
	Apodo VarChar(30) PRIMARY KEY,
	Nombre VarChar(30) NOT NULL,
	Nivel SmallInt NOT NULL,
	Fuerza SmallInt NOT NULL,
	Vida SmallInt NOT NULL,
	Velocidad SmallInt NOT NULL, 
	Dinero Money NULL,
	Categoria SmallInt NOT NULL,
	IDArma Int NULL CONSTRAINT FK_ArmaGladiador FOREIGN KEY REFERENCES C_Arma(ID) ON DELETE CASCADE ON UPDATE CASCADE,
	IDMascota Int NULL CONSTRAINT FK_MascotaGladiador FOREIGN KEY REFERENCES C_Mascota(ID) ON DELETE CASCADE ON UPDATE CASCADE,

	CONSTRAINT CK_Nivel CHECK (Nivel BETWEEN 1 AND 10),
	CONSTRAINT CK_Fuerza CHECK (Fuerza BETWEEN 1 AND 200 ),
	CONSTRAINT CK_Vida CHECK (Vida BETWEEN 1 AND 200),
	CONSTRAINT CK_Velocidad CHECK (Velocidad BETWEEN 1 AND 200 ),
	CONSTRAINT CK_Caracteristicas CHECK ((Fuerza+Vida+Velocidad)>=50),
	CONSTRAINT CK_CategoriaGladiador CHECK (Categoria BETWEEN 1 AND 5)
	)
GO
CREATE TABLE C_GladiadorHabilidad(
	ApodoGladiador VarChar(30) CONSTRAINT FK_Gladiador FOREIGN KEY REFERENCES C_Gladiador(Apodo) ON DELETE NO ACTION ON UPDATE NO ACTION,
	ApodoHabilidad VarChar(30) CONSTRAINT FK_Habilidad FOREIGN KEY REFERENCES C_Habilidad(Apodo) ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT PK_GladiadorHabilidad PRIMARY KEY (ApodoGladiador,ApodoHabilidad)
	)
CREATE TABLE C_GladiadorCombate(
	IDCombate Int CONSTRAINT FK_Combate FOREIGN KEY REFERENCES C_Combate(ID) ON DELETE NO ACTION ON UPDATE NO ACTION,
	ApodoGladiador1 VarChar(30) CONSTRAINT FK_Gladiador1 FOREIGN KEY REFERENCES C_Gladiador(Apodo) ON DELETE NO ACTION ON UPDATE NO ACTION,
	ApodoGladiador2 VarChar(30) CONSTRAINT FK_Gladiador2 FOREIGN KEY REFERENCES C_Gladiador(Apodo) ON DELETE NO ACTION ON UPDATE NO ACTION,
	Ganador VarChar(30) NOT NULL,
	CONSTRAINT PK_GladiadorCombate PRIMARY KEY (IDCombate,ApodoGladiador1,ApodoGladiador2), 
	CONSTRAINT CK_Ganador CHECK (Ganador=ApodoGladiador1 OR Ganador=ApodoGladiador2)
)
GO


INSERT INTO [dbo].[C_Arma]
           ([ID]
           ,[Nombre]
           ,[Daño]
           ,[Tipo]
           ,[Categoria]
		   ,[Precio])
VALUES (1,'Puerro',5,'MIST',5,10),
		(2,'Gladius',10,'CORT',5,25),
		(3,'Hueso de Gladiador',12,'CONT',5,30),
		(4,'Cuchillo',7,'PERF',5,17),
		(5,'Puño americano',8,'CONT',5,20),
		(6,'Latigo de Espinas',15,'CORT',4,38),
		(7,'Lanza',20,'PERF',4,50),
		(8,'Hacha',19,'CORT',4,48),
		(9,'Lucero del Alba',22,'CONT',4,55),
		(10,'Caña de Pescar',15,'MIST',4,38),
		(11,'Mangual',30,'CONT',3,100),
		(12,'Flagrum',28,'MIST',3,94),
		(13,'Cimitarra',25,'CORT',3,84),
		(14,'Espadón',40,'CORT',3,134),
		(15,'Tridente',35,'PERF',3,117),
		(16,'Guja',47,'CORT',2,235),
		(17,'Sai',35,'PERF',2,175),
		(18,'Florete',42,'PERF',2,210),
		(19,'Hacha Gigante',55,'CORT',2,275),
		(20,'Martillo de Pinchos',52,'CONT',2,260),
		(21,'Guadaña',65,'CORT',1,650),
		(22,'Frostmourne',70,'CORT',1,700),
		(23,'Espadon de Luz de Luna',68,'CORT',1,680),
		(24,'Rayo de Zeus',67,'MIST',1,670),
		(25,'Lapiz',69,'MIST',1,690)
GO
INSERT INTO [dbo].[C_Mascota]
           ([ID]
           ,[Especie]
           ,[Daño]
           ,[Categoria]
		   ,[Precio])
     VALUES (1,'Perro',5,5,10),
			(2,'Cerdo',3,5,6),
			(3,'Rata',2,5,2),
			(4,'Lobo',10,4,25),
			(5,'Lince',8,4,20),
			(6,'Águila',12,4,30),
			(7,'Oso',23,3,80),
			(8,'Hipopótamo',25,3,90),
			(9,'Guepardo',20,3,60),
			(10,'Elefante',27,2,140),
			(11,'Leon',30,2,150),
			(12,'Titanoboa',35,2,175),
			(13,'Hidra',40,1,200),
			(14,'Arcangel',45,1,250),
			(15,'Espectro de Cthulhu',50,1,300),
			(16,'Sindragosa',47,1,280)
GO
INSERT INTO [dbo].[C_Habilidad]
           ([Apodo]
           ,[Descripcion])
     VALUES ('Salud de Hierro','Robusto como una roca. Tu salud se multiplica por dos'),
			('Luchador Experimentado','Tu experiencia hace que mejores conforme avanza el combate. Ganarás +10 de daño tras la ronda 10.'),
			('Luchador Fugaz','Tienes una fuerza explosiva, pero te dura poco. Ganarás +30 de daño las 10 primeras rondas'),
			('Velocista','Destacas por tu velocidad. Velocidad +20'),
			('Herrero','Las armas son una elongación de tu cuerpo. +10 de Daño si tienes un arma.'),
			('Monje','No necesitas armas para ser una máquina de matar. +50 de daño si no tienes armas.'),
			('Maestro de Bestias','Tus bestias son tus mejores amigos. Tus mascotas tienen +20 de daño.'),
			('Contraataque','El arte de la lucha no tiene secretos para ti. Cuando recibes un ataque, tienes una posibilidad de contraatacar'),
			('Golpe Crítico','La furia del combate te invade. Hay una probabilidad que metas un golpe crítico.'),
			('Brad Pitt','Has nacido con el don de la belleza, algo bastante inutil en un combate a muerte, pero al menos morirás guapo.')
GO
INSERT INTO [dbo].[C_Gladiador]
           ([Apodo]
           ,[Nombre]
           ,[Nivel]
           ,[Fuerza]
           ,[Vida]
           ,[Velocidad]
           ,[Dinero]
           ,[Categoria]
           ,[IDArma]
           ,[IDMascota])
     VALUES ('Naranjito','Naranja Mecánica',1,20,20,20,10,5,1,NULL),
			('Santi','PedroGuapo',1,10,5,35,0,5,NULL,NULL),
			('Viejo Sabio','Segismundo',1,5,50,70,0,5,3,NULL),
			('Soldado Rocket','James',1,50,5,12,23,5,7,3),
			('Entrenador Javamon','Ash Mostaza',1,20,30,20,100,5,NULL,1),
			('Reggaetonero','PapiGavi',3,45,30,60,1000,4,10,NULL),
			('Viejo Barbudo','JoseMaria',4,10,100,10,69,4,8,2),
			('Otaku','Nomeducho',2,20,20,120,0,4,6,5),
			('Feministe','Anne',3,50,10,50,10,4,6,NULL),
			('MonjeNinja','LeeSin',3,10,50,100,0,4,NULL,NULL),
			('Chuck','Chuck Norris',5,100,50,20,0,3,NULL,7),
			('Minion','GenioDelMal',6,100,1,120,50,3,12,NULL),
			('Lebron James','Jugador de Baloncesto',6,70,70,70,75,3,13,9),
			('LuchadorRandom','Jesus',5,100,80,10,900,3,13,9),
			('Frank Cuesta','Superviviente Extremo',5,60,70,50,130,3,NULL,8),
			('ProfesorDeInformatica','Leo',8,90,90,90,9000,2,NULL,11),
			('THE ROCK','La roca',8,150,100,10,20000,2,19,NULL),
			('JohnCena','JohnDesayuna',8,100,100,100,0,2,NULL,NULL),
			('Batman','Bruce Wayne',8,120,80,120,900000,2,20,10),
			('Presidenta','Ayuso',7,80,100,160,200,2,18,12),
			('Lich King','Arthas Menethil',9,150,150,100,0,1,22,16),
			('Asesino','John Wick',9,120,150,200,100000,1,25,NULL),
			('Dios','Zeus',9,130,130,130,0,1,24,14),
			('La Muerte','Rosario',9,180,100,190,2000,1,21,NULL),
			('Pedro','El Mejor',10,200,200,200,10000000,1,23,15)
GO
INSERT INTO [dbo].[C_Combate]
           ([ID]
           ,[Fecha]
           ,[Rondas])
     VALUES (1,CURRENT_TIMESTAMP,1),
			(2,CURRENT_TIMESTAMP,23),
			(3,CURRENT_TIMESTAMP,4),
			(4,CURRENT_TIMESTAMP,2),
			(5,CURRENT_TIMESTAMP,7),
			(6,CURRENT_TIMESTAMP,12),
			(7,CURRENT_TIMESTAMP,2),
			(8,CURRENT_TIMESTAMP,5),
			(9,CURRENT_TIMESTAMP,10),
			(10,CURRENT_TIMESTAMP,11),
			(11,CURRENT_TIMESTAMP,9),
			(12,CURRENT_TIMESTAMP,7),
			(13,CURRENT_TIMESTAMP,23),
			(14,CURRENT_TIMESTAMP,9),
			(15,CURRENT_TIMESTAMP,7),
			(16,CURRENT_TIMESTAMP,2),
			(17,CURRENT_TIMESTAMP,33),
			(18,CURRENT_TIMESTAMP,45),
			(19,CURRENT_TIMESTAMP,10),
			(20,CURRENT_TIMESTAMP,11),
			(21,CURRENT_TIMESTAMP,23),
			(22,CURRENT_TIMESTAMP,13),
			(23,CURRENT_TIMESTAMP,15),
			(24,CURRENT_TIMESTAMP,14),
			(25,CURRENT_TIMESTAMP,20)
GO
INSERT INTO [dbo].[C_GladiadorCombate]
           ([IDCombate]
           ,[ApodoGladiador1]
           ,[ApodoGladiador2]
           ,[Ganador])
     VALUES (1,'Pedro','Santi','Pedro'),
			(2,'JohnCena','THE ROCK','THE ROCK'),
			(3,'Batman','Presidenta','Presidenta'),
			(4,'LuchadorRandom','Pedro','Pedro'),
			(5,'Reggaetonero','Feministe','Reggaetonero'),
			(6,'Chuck','Frank Cuesta','Frank Cuesta'),
			(7,'La Muerte','Lebron James','La Muerte'),
			(8,'Soldado Rocket','Naranjito','Naranjito'),
			(9,'MonjeNinja','Otaku','MonjeNinja'),
			(10,'Soldado Rocket','Entrenador Javamon','Entrenador Javamon'),
			(11,'Lich King','Dios','Lich King'),
			(12,'Chuck','Minion','Chuck'),
			(13,'Asesino','La Muerte','La Muerte'),
			(14,'Viejo Barbudo','Santi','Viejo Barbudo'),
			(15,'ProfesorDeInformatica','Batman','ProfesorDeInformatica'),
			(16,'Otaku','Feministe','Feministe'),
			(17,'Lich King','La Muerte','Lich King'),
			(18,'Frank Cuesta','ProfesorDeInformatica','ProfesorDeInformatica'),
			(19,'MonjeNinja','Chuck','Chuck'),
			(20,'Naranjito','Santi','Naranjito'),
			(21,'Lebron James','Minion','Minion'),
			(22,'Viejo Sabio','Soldado Rocket','Soldado Rocket'),
			(23,'Dios','La Muerte','Dios'),
			(24,'Pedro','Dios','Pedro'),
			(25,'Santi','Entrenador Javamon','Entrenador Javamon')
GO
INSERT INTO [dbo].[C_GladiadorHabilidad]
           ([ApodoGladiador]
           ,[ApodoHabilidad])
     VALUES ('Santi','Brad Pitt'),
			('Entrenador Javamon','Maestro de Bestias'),
			('Reggaetonero','Luchador Fugaz'),
			('Reggaetonero','Brad Pitt'),
			('Viejo Barbudo','Salud de Hierro'),
			('Feministe','Velocista'),
			('Feministe','Luchador Experimentado'),
			('MonjeNinja','Monje'),
			('Chuck','Monje'),
			('Chuck','Contraataque'),
			('Chuck','Golpe Crítico'),
			('Minion','Luchador Fugaz'),
			('Lebron James','Salud de Hierro'),
			('LuchadorRandom','Salud de Hierro'),
			('LuchadorRandom','Herrero'),
			('Frank Cuesta','Salud de Hierro'),
			('Frank Cuesta','Monje'),
			('Frank Cuesta','Maestro de Bestias'),
			('ProfesorDeInformatica','Salud de Hierro'),
			('ProfesorDeInformatica','Luchador Experimentado'),
			('ProfesorDeInformatica','Monje'),
			('THE ROCK','Salud de Hierro'),
			('THE ROCK','Brad Pitt'),
			('THE ROCK','Golpe Crítico'),
			('JohnCena','Salud de Hierro'),
			('JohnCena','Monje'),
			('JohnCena','Luchador Fugaz'),
			('JohnCena','Luchador Experimentado'),
			('JohnCena','Brad Pitt'),
			('Batman','Salud de Hierro'),
			('Batman','Luchador Experimentado'),
			('Batman','Contraataque'),
			('Batman','Brad Pitt'),
			('Presidenta','Herrero'),
			('Presidenta','Contraataque'),
			('Presidenta','Golpe Crítico'),
			('Presidenta','Luchador Fugaz'),
			('Lich King','Salud de Hierro'),
			('Lich King','Golpe Crítico'),
			('Lich King','Contraataque'),
			('Lich King','Luchador Experimentado'),
			('Lich King','Herrero'),
			('Lich King','Maestro de Bestias'),
			('Asesino','Salud de Hierro'),
			('Asesino','Luchador Fugaz'),
			('Asesino','Luchador Experimentado'),
			('Asesino','Contraataque'),
			('Asesino','Golpe Crítico'),
			('Asesino','Herrero'),
			('Asesino','Velocista'),
			('Asesino','Brad Pitt'),
			('Dios','Salud de Hierro'),
			('Dios','Luchador Fugaz'),
			('Dios','Luchador Experimentado'),
			('Dios','Contraataque'),
			('Dios','Golpe Crítico'),
			('Dios','Velocista'),
			('La Muerte','Salud de Hierro'),
			('La Muerte','Luchador Fugaz'),
			('La Muerte','Luchador Experimentado'),
			('La Muerte','Contraataque'),
			('La Muerte','Golpe Crítico'),
			('La Muerte','Herrero'),
			('La Muerte','Velocista'),
			('Pedro','Salud de Hierro'),
			('Pedro','Luchador Fugaz'),
			('Pedro','Luchador Experimentado'),
			('Pedro','Contraataque'),
			('Pedro','Golpe Crítico'),
			('Pedro','Herrero'),
			('Pedro','Velocista'),
			('Pedro','Maestro de Bestias'),
			('Pedro','Brad Pitt'),
			('Pedro','Monje')
GO
CREATE LOGIN PapiGavi with password='BadBunnyElMejor', 
DEFAULT_DATABASE=COLISEUM
USE COLISEUM
CREATE USER PapiGavi FOR LOGIN PapiGavi
GRANT EXECUTE, INSERT, UPDATE, DELETE, 
SELECT TO PapiGavi
GO


/*SELECT * FROM C_Arma
SELECT * FROM C_Combate
SELECT * FROM C_Gladiador
SELECT * FROM C_GladiadorCombate
SELECT * FROM C_GladiadorHabilidad
SELECT * FROM C_Habilidad
SELECT * FROM C_Mascota
*/