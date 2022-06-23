-- Database: EmployeesDB

-- DROP DATABASE IF EXISTS "EmployeesDB";
	
--- Tables Creation ---

CREATE TABLE Job(
	idJob	 SERIAL PRIMARY KEY,
	name	 VARCHAR(20)
);

CREATE TABLE Employee(
	idEmployee	 	SERIAL 		PRIMARY KEY,
	idJob			INT     	NOT NULL,			
	salaryLocal		MONEY		NOT NULL,
	salaryDollars	MONEY		NOT NULL,
	calification		INT,
	CONSTRAINT 	fk_idJob
	FOREIGN KEY (idJob)
	REFERENCES 	Job
);