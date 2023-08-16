drop database if exists hospital;
create database hospital;
USE hospital;

drop table if exists healthRecord cascade;
drop table if exists instructions cascade;
drop table if exists rooms cascade;
drop table if exists payments cascade;
drop table if exists nurse cascade;
drop table if exists medications cascade;
drop table if exists patients cascade;
drop table if exists physician cascade;
drop table if exists PhysicianPatient cascade;


create table patients (
	patient_ID  int not null,
	patient_name varchar(30) not null,
	address varchar(50),
	phoneNumber bigint,
    pphysician_ID int not null,
	primary key (patient_ID)
);

alter table patients drop column pphysician_ID;

create table physician(
	physician_ID int not null,
    physician_name varchar(30) not null,
    address varchar(50),
    field_Exp varchar(50),
    phoneNumber int,
    certificate_Number char(10),
    primary key (physician_ID)
);

create table PhysicianPatient (
	physicianpatient_id int not null,
	pphysician_ID int not null,
    ppatient_ID int not null,
    foreign key (pphysician_ID) references physician(physician_ID),
    foreign key (ppatient_ID) references patients(patient_ID),
    primary key (physicianpatient_id));
    
   
create table healthRecord(
 record_id int not null,
 patient_ID int not null,
 description varchar(200),
 date date,
 status char(10),
 disease_history varchar(45),
 primary key (record_id),
 foreign key (patient_ID) references patients(patient_ID)
);

create table instructions(
	instruction_code char(10) not null,
    fees decimal(10, 2),
    description varchar(100),
    physician_ID int not null,
    primary key(instruction_code),
    foreign key (physician_ID) references physician(physician_ID)
);

create table rooms(
	room_num int not null,
    capacity int,
    fee_per_night decimal(10,2),
    patient_ID int not null,
    primary key(room_num),
    foreign key (patient_ID) references patients(patient_ID)
);

create table payments(
	payment_id int not null,
	patient_ID int not null,
    room_id int not null,
    amount decimal(10,2),
    date date,
    primary key (payment_id,room_id),
    foreign key (patient_ID) references patients(patient_ID),
	foreign key (room_id) references rooms(room_num)
);

create table nurse(
	nurse_id int not null,
    name varchar(30),
    certification_num int,
    address varchar(45),
    phoneNumber int,
    physician_ID int not null,
    primary key(nurse_id),
    foreign key (physician_ID) references physician(physician_ID)
);

create table medications (
	medication_id int not null,
    name varchar(250),
    amount decimal(10,2),
    patient_id int not null,
    nurse_id int not null,
    primary key (medication_id),
    foreign key (patient_id) references patients(patient_id),
    foreign key (nurse_id) references nurse(nurse_id)
);       