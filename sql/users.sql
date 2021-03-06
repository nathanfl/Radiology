
-- ---
-- Globals
-- ---

-- SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
-- SET FOREIGN_KEY_CHECKS=0;

-- ---
-- Table 'Areas'
-- 
-- ---

DROP TABLE IF EXISTS Areas;
		
CREATE TABLE Areas (
  id INTEGER AUTO_INCREMENT primary key,
  description varchar(50),
  icon varchar(150)
) engine = InnoDB;

insert into Areas(description) values('CT DN');
insert into Areas(description) values('CT South');
insert into Areas(description) values('MRI DN');
insert into Areas(description) values('MRI Mobile');
insert into Areas(description) values('Peds Sedation');
insert into Areas(description) values('JHall');
insert into Areas(description) values('D1');

-- ---
-- Table 'AccessLevels'
-- 
-- ---

DROP TABLE IF EXISTS AccessLevels;
		
CREATE TABLE AccessLevels (
  id INTEGER AUTO_INCREMENT primary key,
  description varchar(50)
) engine = InnoDB;

insert into AccessLevels(description) values('technician');
insert into AccessLevels(description) values('nurse');
insert into AccessLevels(description) values('doctor');
insert into AccessLevels(description) values('manager');
insert into AccessLevels(description) values('administrator');

DROP TABLE IF EXISTS Groups;
		
CREATE TABLE Groups (
  id INTEGER AUTO_INCREMENT not null primary key,
  description VARCHAR(50),
  access_level INTEGER,
	foreign key(access_level) references AccessLevels(id) on update cascade on delete cascade
) engine=InnoDB;

insert into Groups(description, access_level) values('Technicians', 1);
insert into Groups(description, access_level) values('Nurses', 2);
insert into Groups(description, access_level) values('Doctors', 3);
insert into Groups(description, access_level) values('Managers', 4);
insert into Groups(description, access_level) values('Administrators', 5);

-- ---
-- Table 'Users'
-- 
-- ---

DROP TABLE IF EXISTS Users;
		
CREATE TABLE Users (
  id INTEGER AUTO_INCREMENT primary key,
  username VARCHAR(50),
  password VARCHAR(50),
  group_id INTEGER,
  date_added TIMESTAMP,
  session_id VARCHAR(100),
  last_login DATETIME,
  current_ip CHAR(15),
	foreign key(group_id) references Groups(id) on delete cascade on update cascade
) engine=InnoDB;

insert into Users(username, password, group_id) values('soulblast@gmail.com', 'felix', 5);
	
drop table if exists AreaConfigurations;

create table AreaConfigurations(
	id integer not null auto_increment primary key,
	area integer not null,
	manager integer not null,
	opening_time integer not null default 700,
	closing_time integer not null default 2200,
	numberOfScanners integer not null,
	foreign key(area) references Areas(id) on update cascade on delete cascade,
	foreign key(manager) references Users(id) on update cascade on delete cascade
) engine = InnoDb;

drop table if exists AreaTimeSlots;

create table AreaTimeSlots(
	id integer not null auto_increment primary key,
	area integer not null,
	time integer not null,
	slots integer not null,
	foreign key(area) references Areas(id) on update cascade on delete cascade
) engine = InnoDb;

insert into AreaTimeSlots(area, time, slots) values(1,700,3);
insert into AreaTimeSlots(area, time, slots) values(1,730,3);
insert into AreaTimeSlots(area, time, slots) values(1,800,3);
insert into AreaTimeSlots(area, time, slots) values(1,830,3);
insert into AreaTimeSlots(area, time, slots) values(1,900,3);
insert into AreaTimeSlots(area, time, slots) values(1,930,3);
insert into AreaTimeSlots(area, time, slots) values(1,1000,3);
insert into AreaTimeSlots(area, time, slots) values(1,1030,3);
insert into AreaTimeSlots(area, time, slots) values(1,1100,3);
insert into AreaTimeSlots(area, time, slots) values(1,1130,3);
insert into AreaTimeSlots(area, time, slots) values(1,1200,3);
insert into AreaTimeSlots(area, time, slots) values(1,1230,3);
insert into AreaTimeSlots(area, time, slots) values(1,1300,3);
insert into AreaTimeSlots(area, time, slots) values(1,1330,3);
insert into AreaTimeSlots(area, time, slots) values(1,1400,3);
insert into AreaTimeSlots(area, time, slots) values(1,1430,3);
insert into AreaTimeSlots(area, time, slots) values(1,1500,3);
insert into AreaTimeSlots(area, time, slots) values(1,1530,3);
insert into AreaTimeSlots(area, time, slots) values(1,1600,3);
insert into AreaTimeSlots(area, time, slots) values(1,1630,3);
insert into AreaTimeSlots(area, time, slots) values(1,1700,3);
insert into AreaTimeSlots(area, time, slots) values(1,1730,3);
insert into AreaTimeSlots(area, time, slots) values(1,1800,3);
insert into AreaTimeSlots(area, time, slots) values(1,1830,3);
insert into AreaTimeSlots(area, time, slots) values(1,1900,3);
insert into AreaTimeSlots(area, time, slots) values(1,1930,3);
	
drop table if exists Patients;

create table Patients(
	id integer auto_increment primary key,
	first_name varchar(50),
	middle_name varchar(50),
	last_name varchar(50),
	mrn char(10) not null,
	date_of_birth date,
	constraint unique_mrn unique(mrn)
) engine = InnoDB;

insert into Patients(first_name, middle_name, last_name, mrn, date_of_birth) values('Nathan', 'Scott', 'Bardgett', 'NB0529', '1981-05-29 00:00:00');
insert into Patients(first_name, middle_name, last_name, mrn, date_of_birth) values('MiMi', 'Chan', 'Bardgett', 'MB1066', '1966-10-19 00:00:00');
insert into Patients(first_name, middle_name, last_name, mrn, date_of_birth) values('Erimi', 'Merigrace', 'Kendrick', 'EMK0711', '2002-07-11 00:00:00');
insert into Patients(first_name, middle_name, last_name, mrn, date_of_birth) values('Georgie', 'Merigrace', 'Bardgett', 'GP9710', '2004-10-19 00:00:00');
	
drop table if exists LabValues;

create table LabValues(
	id integer not null auto_increment primary key,
	patient_id integer not null,
	creatinine decimal(2,2) not null,
	gfr integer,
	date_of_result date,
	foreign key(patient_id) references Patients(id) on update cascade on delete cascade
) engine = InnoDB;

drop table if exists Allergens;

create table Allergens(
	id integer not null auto_increment primary key,
	description varchar(100)
) engine = InnoDB;

insert into Allergens(description) values('NKDA');
insert into Allergens(description) values('Sudafed');
insert into Allergens(description) values('Multivitamins');

drop table if exists Allergies;

create table Allergies(
	id integer not null auto_increment primary key,
	patient_id integer not null,
	allergen_id integer not null default 1,
	reaction varchar(50) default 'undefined',
	foreign key(patient_id) references Patients(id) on update cascade on delete cascade,
	foreign key(allergen_id) references Allergens(id) on update cascade on delete cascade
) engine = InnoDB;

insert into allergies(patient_id, allergen_id, reaction) values(1, 2, 'seizures');
insert into allergies(patient_id, allergen_id, reaction) values(1, 3, 'severe insomnia');
insert into allergies(patient_id, allergen_id, reaction) values(2, 1, '');	
	
drop table if exists ProcedureStatus;

create table ProcedureStatus(
	id integer not null auto_increment primary key,
	description varchar(100)
) engine = InnoDB; 

insert into ProcedureStatus(description) values('Procedure Ordered');
insert into ProcedureStatus(description) values('Front Desk');
insert into ProcedureStatus(description) values('Changing');
insert into ProcedureStatus(description) values('Triage');
insert into ProcedureStatus(description) values('C1/C3 Triage');
insert into ProcedureStatus(description) values('GI Triage');
insert into ProcedureStatus(description) values('On Bed');
insert into ProcedureStatus(description) values('Scanning');
insert into ProcedureStatus(description) values('Scan Complete');
insert into ProcedureStatus(description) values('Discharged');

drop table if exists IVSites;

create table IVSites(
	id integer not null auto_increment primary key,
	description varchar(50)
) engine = InnoDB;

insert into IVSites(description) values('None');
insert into IVSites(description) values('Right AC');
insert into IVSites(description) values('Left AC');
insert into IVSites(description) values('Bilateral AC');
insert into IVSites(description) values('Right Forearm');
insert into IVSites(description) values('Left Forearm');
insert into IVSites(description) values('Right Wrist');
insert into IVSites(description) values('Left Wrist');
insert into IVSites(description) values('Right Hand');
insert into IVSites(description) values('Left Hand');

drop table if exists ProcedureProtocols;

create table ProcedureProtocols(
	id integer not null auto_increment primary key,
	description varchar(50),
	iv_size integer default 20,
	iv_site_id integer not null,
	speed integer default 3,
	foreign key(iv_site_id) references IVSites(id)
) engine = InnoDB;

insert into ProcedureProtocols(description, iv_site_id) values('CAPc', 2);
insert into ProcedureProtocols(description, iv_site_id) values('APc', 2);
insert into ProcedureProtocols(description, iv_site_id) values('Pc', 2);
insert into ProcedureProtocols(description, iv_site_id) values('Standard Chest', 1);
insert into ProcedureProtocols(description, iv_site_id) values('GU', 2);
insert into ProcedureProtocols(description, iv_size, iv_site_id) values('Hepatic Resection', 18, 2);
insert into ProcedureProtocols(description, iv_size, iv_site_id) values('PE', 18, 2);
insert into ProcedureProtocols(description, iv_size, iv_site_id) values('Chest Dissection', 18, 2);
insert into ProcedureProtocols(description, iv_site_id) values('AAA', 2);
insert into ProcedureProtocols(description, iv_site_id) values('CTA Brain', 2);
insert into ProcedureProtocols(description, iv_site_id) values('CTA Chest', 2);
insert into ProcedureProtocols(description, iv_site_id) values('CTA Heart', 2);
insert into ProcedureProtocols(description, iv_site_id) values('CTA Runoff', 2);
insert into ProcedureProtocols(description, iv_site_id) values('Neuro c', 2);
insert into ProcedureProtocols(description, iv_site_id) values('Neuro Neck c', 2);
insert into ProcedureProtocols(description, iv_site_id) values('Orbits', 2);
	
drop table if exists ProcedureDiagnoses;

create table ProcedureDiagnoses(
	id integer not null auto_increment primary key,
	description varchar(255)
) engine = InnoDB;

insert into ProcedureDiagnoses(description) values('Abdominal Pain');
insert into ProcedureDiagnoses(description) values('Chest Pain Pain');

drop table if exists Schedules;

create table Schedules (
	id integer not null auto_increment primary key,
	patient_id int not null,
	area integer not null,
	description varchar(255),
	diagnosis_id integer not null,
	protocol_id integer not null,
	scheduled_time datetime,
	status integer not null,
	foreign key(patient_id) references Patients(id) on update cascade on delete cascade,
	foreign key(area) references Areas(id) on update cascade on delete cascade,
	foreign key(diagnosis_id) references ProcedureDiagnoses(id) on update cascade on delete cascade,
	foreign key(protocol_id) references ProcedureProtocols(id) on update cascade on delete cascade, 
	foreign key(status) references ProcedureStatus(id) on update cascade on delete cascade
) engine = InnoDB;

insert into Schedules(patient_id, area, diagnosis_id, protocol_id, scheduled_time, status) values(1, 1, 1, 1, '2011-04-01 07:00:00', 1);
insert into Schedules(patient_id, area, diagnosis_id, protocol_id, scheduled_time, status) values(2, 1, 1, 2, '2011-04-01 07:30:00', 1);
insert into Schedules(patient_id, area, diagnosis_id, protocol_id, scheduled_time, status) values(1, 1, 1, 1, '2011-04-01 08:00:00', 1);
insert into Schedules(patient_id, area, diagnosis_id, protocol_id, scheduled_time, status) values(2, 1, 1, 2, '2011-04-01 08:00:00', 1);
insert into Schedules(patient_id, area, diagnosis_id, protocol_id, scheduled_time, status) values(3, 1, 1, 3, '2011-04-01 08:00:00', 1);
insert into Schedules(patient_id, area, diagnosis_id, protocol_id, scheduled_time, status) values(4, 1, 1, 4, '2011-04-01 08:00:00', 1);
insert into Schedules(patient_id, area, diagnosis_id, protocol_id, scheduled_time, status) values(4, 1, 1, 5, '2011-04-15 08:00:00', 1);
insert into Schedules(patient_id, area, diagnosis_id, protocol_id, scheduled_time, status) values(3, 1, 1, 6, '2011-04-13 08:00:00', 1);
insert into Schedules(patient_id, area, diagnosis_id, protocol_id, scheduled_time, status) values(1, 1, 1, 7, '2011-04-04 08:00:00', 1);
insert into Schedules(patient_id, area, diagnosis_id, protocol_id, scheduled_time, status) values(2, 1, 1, 8, '2011-04-21 08:00:00', 1);
insert into Schedules(patient_id, area, diagnosis_id, protocol_id, scheduled_time, status) values(3, 1, 1, 9, '2011-04-26 08:00:00', 1);
insert into Schedules(patient_id, area, diagnosis_id, protocol_id, scheduled_time, status) values(3, 1, 1, 1, '2011-05-01 08:00:00', 1);
insert into Schedules(patient_id, area, diagnosis_id, protocol_id, scheduled_time, status) values(3, 1, 1, 1, '2011-04-16 08:00:00', 1);
insert into Schedules(patient_id, area, diagnosis_id, protocol_id, scheduled_time, status) values(4, 1, 1, 2, '2011-04-10 08:00:00', 1);

create view ct_schedule as 	
select s.id as 'schedule_id', p.id as 'patient_id', p.first_name, p.last_name, p.middle_name, p.mrn, p.date_of_birth, a.description as 'area', a.icon, ps.id as 'status_id', 
	ps.description as 'status', s.scheduled_time, pd.description as 'diagnosis', pp.description as 'protocol'
from Schedules s, Patients p, Areas a, ProcedureStatus ps, ProcedureDiagnoses pd, ProcedureProtocols pp
where s.patient_id = p.id and s.area = a.id and s.status = ps.id and s.diagnosis_id = pd.id and s.protocol_id = pp.id;

grant select, insert, update, delete on radiology.* to nodeapp@localhost identified by 'n0d34pp';
-- ---
-- Table 'Groups'
-- 
-- ---

-- ---
-- Foreign Keys 
-- ---

-- ---
-- Table Properties
-- ---

-- ALTER TABLE Users ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE Groups ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ---
-- Test Data
-- ---

-- INSERT INTO Users (id,username,password,group,date_added,session_id,last_login,current_ip) VALUES
-- ('','','','','','','','');
-- INSERT INTO Groups (id,description,access_level) VALUES
-- ('','','');
