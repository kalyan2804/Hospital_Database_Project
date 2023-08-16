USE hospital;

# view 1

CREATE VIEW Patient_treatment_View AS
SELECT pat.patient_name AS patient_Name, med.Name AS treatment_medication, med.amount AS Drug_Capacity
FROM patients pat, medications med
WHERE pat.Patient_ID = med.Patient_id;

select * from Patient_treatment_View;

# view 2

CREATE VIEW Patient_Disease_View AS
SELECT pat.patient_name AS patient_Name, record.description AS Disease, record.date AS reported_date
FROM patients pat,healthRecord record
WHERE pat.Patient_ID = record.Patient_ID;

select * from Patient_Disease_View;

#view 3

CREATE VIEW Patient_bill_View AS
SELECT pat.patient_name AS patient_Name,bill.amount AS bill, bill.room_id AS patient_kept_room
FROM patients pat,payments bill
WHERE pat.Patient_ID = bill.Patient_ID;

select * from Patient_bill_View;


# Trigger 1
# Checking room capacity before allocating the room to the patient
#example of before trigger
 
DELIMITER //
CREATE TRIGGER update_health_every_time
AFTER INSERT ON patients
FOR EACH ROW
BEGIN
INSERT INTO healthRecord (patient_ID, status, date, description)
VALUES (NEW.patient_ID, 'NEW', NULL, NULL);
END;
//
DELIMITER ;


# Trigger 2
delimiter //
CREATE TRIGGER check_availability
BEFORE INSERT ON rooms
FOR EACH ROW
BEGIN
    DECLARE allowed_capacity INT;
    DECLARE current_capacity INT;
    SET allowed_capacity = (
    SELECT capacity 
    FROM rooms 
    WHERE room_num = NEW.room_num);
    SET current_capacity = (
    SELECT COUNT(*) 
    FROM rooms
    WHERE room_num = NEW.room_num);
    IF allowed_capacity <= current_capacity THEN        
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'The room selected not having enough space';
	END IF;
END;
//
delimiter ;

# Trigger 3
DELIMITER //
CREATE TRIGGER generate_bill
AFTER INSERT ON rooms
FOR EACH ROW
BEGIN
INSERT INTO payments (patient_ID, room_id)
VALUES (NEW.patient_ID, NEW.room_num);
END;
//
DELIMITER ;





#join Queries

#1
select * 
from physician phy join Nurse nur 
on phy.Physician_Id = nur.Physician_id;


#2
select pat.patient_name,pat.phoneNumber,hr.description as disease, pm.amount as bill
from patients pat join healthRecord hr join payments pm
on pat.patient_ID = hr.patient_ID and hr.patient_ID=pm.patient_ID and pm.patient_ID=pat.Patient_ID;

#3
select * 
from Patients pa left join healthRecord hr 
on pa.Patient_Id  = hr.Patient_Id;

#4
select * 
from Patients pa right join rooms ro 
on pa.Patient_Id  = ro.Patient_Id;

#5 

SELECT phy.physician_name AS physician_name, nur.name AS allocated_nurse
FROM physician phy
JOIN nurse nur ON phy.physician_ID = nur.physician_ID
GROUP BY phy.physician_name, nur.name;

# Nested Queries

#1

SELECT *
FROM payments
WHERE amount > (
    SELECT AVG(amount) 
    FROM payments);

#2
SELECT AVG(amount)
FROM Payments
WHERE Room_id IN (
    SELECT Room_id
    FROM Rooms
    WHERE capacity > 1 );
    
#3
SELECT SUM(capacity)
FROM Rooms
WHERE  fee_per_night <(
   SELECT AVG( fee_per_night)
    FROM Rooms); 

#4 
SELECT patient_name,room_num
FROM patients pat, rooms rm
WHERE rm.patient_ID=pat.patient_ID and rm.patient_ID IN (SELECT patient_ID
FROM healthRecord
WHERE status='not cured');

#5
SELECT patient_name,amount
FROM patients pat, payments pm
WHERE pm.patient_ID=pat.patient_ID and pm.patient_ID IN (SELECT patient_ID
FROM healthRecord
WHERE status='not cured');



# Aggregate Queries
# 1
SELECT count(patient_ID) as admitted_count
FROM healthRecord
WHERE status='not cured';

#2
SELECT COUNT(patient_ID) AS new_patients
FROM healthRecord
WHERE date > '2021-01-01';

#3
SELECT  count(nur.name) as allocated_nurse 
FROM physician phy, nurse nur
where phy.physician_ID = nur.physician_ID AND phy.physician_name='Kal bent';


#4
select avg(amount) 
from payments, rooms
where rooms.patient_ID=payments.patient_ID AND capacity>2 and fee_per_night<=100;

#5
SELECT 
  FLOOR(DATEDIFF(MAX(date), MIN(date)) / 365) AS years,
  FLOOR((DATEDIFF(MAX(date), MIN(date)) % 365) / 30) AS months,
  (DATEDIFF(MAX(date), MIN(date)) % 30) AS days
FROM healthRecord
WHERE patient_id IS NOT NULL;
