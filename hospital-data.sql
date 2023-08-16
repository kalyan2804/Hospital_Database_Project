insert into patients values(1,'Kevin','100 s street',9456787655),
					 (2,'Sachin','250 s street',6849022332),
                     (3,'Sehwag','red street',7543234561),
                     (4,'Pat','oxford england',7776543237),
                     (5,'Matt','queens new york',2456787652);
                     
insert into physician values(101,'Brenda brown','university dr','dermatologist',33333,4321),
						   (102,'Kal bent','italy','cardialogist',53668,8765),
                           (103,'Win fird','greece','Neurologist',94754,1234),
                           (104,'Senthil Mist','queens','dermatologist',86840,2456),
                           (105,'Anand ally','brroklyn','General Surgeon',00401,7890);
                           
insert into PhysicianPatient values (1,101,1),
									(2,102,2),
                                    (3,103,3),
                                    (4,104,4),
                                    (5,105,5);
                                    
insert into healthRecord values(12301,1,'Malaria','2022-09-01','Cured','fine'),
							   (12302,2,'Diarrhea','2020-08-14','not cured','common'),
                               (12303,3,'allergy','2021-11-21','not cured','previously a year ago'),
                               (12304,4,'stomach pain','2021-11-04','cured','repeated'),
                               (12305,5,'red eye','2019-07-08','cured','common in season');
                               
insert into instructions values(1,200,'avoid junk food',101),
								(2,500,'wash hands',102),
                                (3,500,'talk walk',104),
                                (4,200,'sleep properly',105),
                                (5,300,'eat fruits and vegetables',103);
                                
insert into rooms values(201,30,100,1),
						(202,12,78,2),
                        (203,23,150,3),
                        (204,18,170,4),
                        (205,36,100,5);
                        
insert into payments values(1101,1,201,168.98,'2021-09-07'),
						   (1102,2,202,150.77,'2021-10-10'),
                           (1103,3,203,200.98,'2023-01-11'),
                           (1104,4,204,238.98,'2020-01-11'),
                           (1105,5,205,300.54,'2019-04-23');
                           
insert into nurse values(16801,'Sithara',5433,'Charlotte',65432,101),
						(16802,'priya',5434,'Charlotte',65433,101),
                        (16803,'jordan',5435,'Charlotte',65434,102),
                        (16804,'manny',5436,'Charlotte',65435,102),
                        (16805,'penny',5437,'Charlotte',65436,102),
                        (16806,'joe',5438,'Charlotte',65437,102);
                        
insert into medications values (11101,'Paracetamal',111.54,1,16801),
							   (11102,'neflon',134.56,2,16802),
                               (11103,'burnol',200.54,3,16803),
                               (11104,'anti acid',234.76,4,16804),
                               (11105,'Azitromycin',33.65,5,16805);                        
                                