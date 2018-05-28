drop table if exists Service;
drop table if exists Service_provider;
drop table if exists Tenants;
drop table if exists Employee;
drop table if exists Persons;
drop table if exists Hotels;
drop table if exists Location;

create table Location(
	LocationID int not null primary key,
	Country varchar(32) not null,
	City varchar(32) not null
); 

create table Hotels( 
	HotelID int not null primary key, 
	Name varchar(64) not null, 
	Manager int,
	Capacity int not null,
	Location int not null,
	Number_of_Personss int not null,
	foreign key (Location) references Location(LocationID)
);

create table Persons(
	PersonID int not null primary key,
	Name varchar(64) not null,
	BirthDay datetime not null
);

create table Employee( 
	WorkerID int not null primary key, 
	Date_of_admission datetime not null, 
	Experience_year int, 
	Workplace int not null,
	foreign key (WorkerID) references Persons(PersonID),
	foreign key (Workplace) references Hotels(HotelID)
);

create table Tenants(
	TenantID int not null,
	time_start datetime not null,
	time_finish datetime not null,
	HotelID int not null,
	primary key (TenantID,time_start),
	foreign key (TenantID) references Persons(PersonID),
	foreign key (HotelID) references Hotels(HotelID)
); 

create table Service_provider(
	ProviderID int not null primary key,
	Name varchar(64) not null,
	Location int not null,
	Specialization varchar(32) not null,
	Scores int not null,
	foreign key (Location) references Location(LocationID)
);

create table Service(
	RelationshipID int not null,
	Hotel int not null,
	Provider int not null,
	Start_cooperation datetime not null,
	End_cooperation datetime,
	primary key (RelationshipID, Start_cooperation),
	foreign key (Hotel) references Hotels(HotelID),
	foreign key (Provider) references Service_provider(ProviderID)
);

INSERT INTO Location VALUES (1, 'Russia', 'Moscow');
INSERT INTO Location VALUES (2, 'Britain', 'London');
INSERT INTO Location VALUES (3, 'Turkey', 'Istanbul');

INSERT INTO Persons VALUES (1, 'Ivanov', '3.11.1974');
INSERT INTO Persons VALUES (2, 'Abdula', '6.01.1985');
INSERT INTO Persons VALUES (3, 'Arahim', '2.05.1993');
INSERT INTO Persons VALUES (4, 'Rukov', '8.03.1981');
INSERT INTO Persons VALUES (5, 'Burov', '4.11.1974');
INSERT INTO Persons VALUES (6, 'Rubin', '23.11.1978');
INSERT INTO Persons VALUES (7, 'Nemov', '26.09.1980');
INSERT INTO Persons VALUES (8, 'Makov', '19.12.1995');
INSERT INTO Persons VALUES (9, 'Urov', '27.10.1990');
INSERT INTO Persons VALUES (10, 'Polov', '7.02.1979');
INSERT INTO Persons VALUES (11, 'Olum', '30.08.1988');
INSERT INTO Persons VALUES (12, 'Abra', '19.10.1996');
INSERT INTO Persons VALUES (13, 'Olhov', '30.12.1970');
INSERT INTO Persons VALUES (14, 'Tracey', '24.01.1977');
INSERT INTO Persons VALUES (15, 'Abeham', '3.04.1993');
INSERT INTO Persons VALUES (16, 'Taylor', '12.12.1972');
INSERT INTO Persons VALUES (17, 'Adamson', '18.10.1984');
INSERT INTO Persons VALUES (18, 'Turin', '8.03.1985');
INSERT INTO Persons VALUES (19, 'Kubin', '10.10.1995');
INSERT INTO Persons VALUES (20, 'York', '19.06.1971');

INSERT INTO Hotels VALUES (1, 'MosHot', 1, 100, 1, 3);
INSERT INTO Hotels VALUES (2, 'Rosinochka', 6, 150, 1, 4);
INSERT INTO Hotels VALUES (3, 'Kutuzov', 7, 70, 1, 2);
INSERT INTO Hotels VALUES (4, 'LonHot', 17, 80, 2, 2);
INSERT INTO Hotels VALUES (5, 'Alin', 14, 50, 2, 1);
INSERT INTO Hotels VALUES (6, 'IstHot', 19, 200, 3, 4);
INSERT INTO Hotels VALUES (7, 'Abra', 12, 30, 3, 1);

INSERT INTO Tenants VALUES (18, '10.10.2010', '21.11.2010', 1);
INSERT INTO Tenants VALUES (19, '8.03.2018', '12.03.2018', 3);
INSERT INTO Tenants VALUES (20, '19.05.2012', '10.06.2012', 2);

INSERT INTO Employee VALUES (1, '8.10.1999', 25, 1);
INSERT INTO Employee VALUES (2, '9.12.2000', 19, 6);
INSERT INTO Employee VALUES (3, '14.09.2005', 13, 6);
INSERT INTO Employee VALUES (4, '17.04.2014', 5, 3);
INSERT INTO Employee VALUES (5, '12.02.2017', 9, 2);
INSERT INTO Employee VALUES (6, '17.11.2013', 15, 2);
INSERT INTO Employee VALUES (7, '14.12.2005', 12, 3);
INSERT INTO Employee VALUES (8, '30.06.2007', 17, 1);
INSERT INTO Employee VALUES (9, '29.05.2012', 7, 1);
INSERT INTO Employee VALUES (10, '23.09.2004', 15, 2);
INSERT INTO Employee VALUES (11, '12.10.2015', 4, 6);
INSERT INTO Employee VALUES (12, '9.11.2016', 7, 7);
INSERT INTO Employee VALUES (13, '4.05.2014', 5, 2);
INSERT INTO Employee VALUES (14, '14.02.2018', 2, 5);
INSERT INTO Employee VALUES (15, '7.03.2017', 6, 6);
INSERT INTO Employee VALUES (16, '19.04.2015', 8, 4);
INSERT INTO Employee VALUES (17, '20.07.2016', 3, 4);

INSERT INTO Service_provider VALUES (1, 'Tide', 3, 'Wasing', 5);
INSERT INTO Service_provider VALUES (2, 'Astor', 1, 'Restaurant', 3);
INSERT INTO Service_provider VALUES (3, 'CVub', 2, 'Spa', 4);
INSERT INTO Service_provider VALUES (4, 'Arba', 3, 'Restaurant', 5);
INSERT INTO Service_provider VALUES (5, 'Pivot', 2, 'Restaurant', 4);

INSERT INTO Service VALUES (1, 1, 3, '10.08.2013', null);
INSERT INTO Service VALUES (2, 4, 3, '01.09.2000', '08.08.2017');
INSERT INTO Service VALUES (3, 3, 2, '03.02.2000', '02.12.2006');
INSERT INTO Service VALUES (4, 5, 2, '22.11.2012', null);
INSERT INTO Service VALUES (5, 2, 1, '30.04.2018', null);