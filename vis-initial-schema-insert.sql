-- Database Teaching Team
-- Assignment 2A 2021 Oct12
-- Traffic Demerit System partial schema and insert
-- This script must not be altered in ANY WAY

----------------------
--DROP TABLE STATEMENTS--
----------------------

DROP TABLE demerit CASCADE CONSTRAINTS;

DROP TABLE driver CASCADE CONSTRAINTS;

DROP TABLE intercept CASCADE CONSTRAINTS;

DROP TABLE offence CASCADE CONSTRAINTS;

DROP TABLE officer CASCADE CONSTRAINTS;

DROP TABLE suspension CASCADE CONSTRAINTS;

DROP TABLE vehicle CASCADE CONSTRAINTS;

---------------------------
--CREATE TABLE STATEMENTS--
---------------------------

CREATE TABLE demerit (
    dem_code         NUMBER(3) NOT NULL,
    dem_description  VARCHAR2(75) NOT NULL,
    dem_points       NUMBER(2) NOT NULL
);

COMMENT ON COLUMN demerit.dem_code IS
    'Demerit unique code';

COMMENT ON COLUMN demerit.dem_description IS
    'Demerit description';

COMMENT ON COLUMN demerit.dem_points IS
    'Demerit points';

ALTER TABLE demerit ADD CONSTRAINT demerit_pk PRIMARY KEY ( dem_code );

ALTER TABLE demerit ADD CONSTRAINT demerit_nk UNIQUE ( dem_description );

CREATE TABLE driver (
    lic_no        NUMBER(9) NOT NULL,
    lic_fname     VARCHAR2(30),
    lic_lname     VARCHAR2(30),
    lic_mobile    CHAR(10) NOT NULL,
    lic_street    VARCHAR2(50) NOT NULL,
    lic_town      VARCHAR2(20) NOT NULL,
    lic_postcode  CHAR(4) NOT NULL,
    lic_dob       DATE NOT NULL,
    lic_expiry    DATE NOT NULL
);

COMMENT ON COLUMN driver.lic_no IS
    'Licence number';

COMMENT ON COLUMN driver.lic_fname IS
    'Licenced driver first name';

COMMENT ON COLUMN driver.lic_lname IS
    'Licenced driver last name';

COMMENT ON COLUMN driver.lic_mobile IS
    'Licenced driver mobile number';

COMMENT ON COLUMN driver.lic_street IS
    'Licenced driver street address';

COMMENT ON COLUMN driver.lic_town IS
    'Licenced driver town';

COMMENT ON COLUMN driver.lic_postcode IS
    'Licenced driver postcode';

COMMENT ON COLUMN driver.lic_dob IS
    'Licenced driver DOB';

COMMENT ON COLUMN driver.lic_expiry IS
    'Licence expiry date';

ALTER TABLE driver ADD CONSTRAINT driver_pk PRIMARY KEY ( lic_no );

ALTER TABLE driver ADD CONSTRAINT driver_nk UNIQUE ( lic_mobile );

CREATE TABLE officer (
    officer_id     NUMBER(8) NOT NULL,
    officer_fname  VARCHAR2(30),
    officer_lname  VARCHAR2(30)
);

COMMENT ON COLUMN officer.officer_id IS
    'TDS officer id number';

COMMENT ON COLUMN officer.officer_fname IS
    'TDS officer first name';

COMMENT ON COLUMN officer.officer_lname IS
    'TDS officer last name';

ALTER TABLE officer ADD CONSTRAINT officer_pk PRIMARY KEY ( officer_id );

CREATE TABLE vehicle (
    veh_vin        CHAR(17) NOT NULL,
    veh_yrmanuf    DATE NOT NULL,
    veh_maincolor  VARCHAR2(20) NOT NULL,
    veh_manufname  VARCHAR2(30) NOT NULL,
    veh_modname    VARCHAR2(20) NOT NULL,
    veh_type       CHAR(2) NOT NULL
);

ALTER TABLE vehicle
    ADD CHECK ( veh_type IN ( 'CR', 'HV', 'MB' ) );

COMMENT ON COLUMN vehicle.veh_vin IS
    'Vehicle identification number';

COMMENT ON COLUMN vehicle.veh_yrmanuf IS
    'Vehicle manufactured year';

COMMENT ON COLUMN vehicle.veh_maincolor IS
    'Vehicle main body color';

COMMENT ON COLUMN vehicle.veh_manufname IS
    'Manufacturer name of the vehicle';

COMMENT ON COLUMN vehicle.veh_modname IS
    'Model name of the vehicle';

COMMENT ON COLUMN vehicle.veh_type IS
    'Vehicle type - can be CR ( Car), MB (Motorbike) or HV (Heavy Vehicle)';

ALTER TABLE vehicle ADD CONSTRAINT vehicle_pk PRIMARY KEY ( veh_vin );

----------------------
--INSERT STATEMENTS--
----------------------

--INSERT statements for officer table
INSERT INTO officer VALUES (10000001, 'Kanya', 'Harverson');
INSERT INTO officer VALUES (10000002, 'Hazel', 'Dorcey');
INSERT INTO officer VALUES (10000003, 'Kirsteni', 'Boncoeur');
INSERT INTO officer VALUES (10000004, 'Katuscha', 'Barnish');
INSERT INTO officer VALUES (10000005, 'Prentiss', 'Blatchford');
INSERT INTO officer VALUES (10000006, 'Pier', 'Schwier');
INSERT INTO officer VALUES (10000007, 'Cirilo', 'Polglase');
INSERT INTO officer VALUES (10000008, 'Deane', 'Mowles');
INSERT INTO officer VALUES (10000009, 'Brucie', 'Hackinge');
INSERT INTO officer VALUES (10000010, 'Lionello', 'Champagne');
INSERT INTO officer VALUES (10000011, 'Dolley', 'Hedling');
INSERT INTO officer VALUES (10000012, 'Kerk', 'Dowgaine');
INSERT INTO officer VALUES (10000013, 'Chiarra', 'Dimeloe');
INSERT INTO officer VALUES (10000014, 'Roshelle', 'Every');
INSERT INTO officer VALUES (10000015, 'Geoff', 'Kilmartin');
INSERT INTO officer VALUES (10000016, 'Edie', 'Chatel');
INSERT INTO officer VALUES (10000017, 'Alla', 'Ghiraldi');
INSERT INTO officer VALUES (10000018, 'Merry', 'Justun');
INSERT INTO officer VALUES (10000019, 'Lamont', 'Streatfield');
INSERT INTO officer VALUES (10000020, 'Audry', 'Prinn');
INSERT INTO officer VALUES (10000021, 'Dimitry', 'Jumont');

--INSERT statements for demerit table
INSERT INTO demerit VALUES (99, 'Exceeding the speed limit by 25 km/h or more', 4);
INSERT INTO demerit VALUES (100, 'Blood alcohol charge', 4);
INSERT INTO demerit VALUES (101, 'Level crossing offence', 4);
INSERT INTO demerit VALUES (102, 'Using a mobile phone illegally while driving', 4);
INSERT INTO demerit VALUES (103, 'Using a visual display unit or television illegally while driving', 4);
INSERT INTO demerit VALUES (104, 'Driving a fatigue-regulated Heavy vehicle against max work req. - Critical', 4);
INSERT INTO demerit VALUES (105, 'Driving a fatigue-regulated Heavy vehicle against min. rest req. - Critical', 4);
INSERT INTO demerit VALUES (106, 'Exceeding the speed limit by 10 km/h or more but less than 25 km/h', 3);
INSERT INTO demerit VALUES (107, 'Disobeying traffic lights, signs or police or authorised person', 3);
INSERT INTO demerit VALUES (108, 'Failing to give way, or stop, or remain stopped', 3);
INSERT INTO demerit VALUES (109, 'Driving without wearing an approved helmet', 3);
INSERT INTO demerit VALUES (110, 'Driving without properly fastened seat belt', 3);
INSERT INTO demerit VALUES (111, 'Driving with an unrestrained passenger', 3);
INSERT INTO demerit VALUES (112, 'Driving on the wrong side of double lines or divided hwy or painted island', 3);
INSERT INTO demerit VALUES (113, 'Risk colliding with exiting, boarding or waiting tram passengers', 3);
INSERT INTO demerit VALUES (114, 'Driving a fatigue-regulated heavy vehicle while impaired by fatigue', 3);
INSERT INTO demerit VALUES (115, 'Driving a fatigue-regulated heavy vehicle against max work req. - Severe', 3);
INSERT INTO demerit VALUES (116, 'Driving a fatigue-regulated heavy vehicle against min. rest req. - Severe', 3);
INSERT INTO demerit VALUES (117, 'Driving contrary to a major defect notice', 3);
INSERT INTO demerit VALUES (118, 'Careless driving', 3);
INSERT INTO demerit VALUES (119, 'Driving with an obscured or improperly displayed number plate', 3);
INSERT INTO demerit VALUES (120, 'Failure to display P plate', 3);
INSERT INTO demerit VALUES (121, 'Probationary driver who drives a probationary prohibited vehicle on a road', 3);
INSERT INTO demerit VALUES (122, 'Driving the wrong way on a one way service road', 3);
INSERT INTO demerit VALUES (123, 'Improper overtaking or passing', 2);
INSERT INTO demerit VALUES (124, 'Turn or stop without signalling', 2);
INSERT INTO demerit VALUES (125, 'Turn improperly', 2);
INSERT INTO demerit VALUES (126, 'Fail to keep left', 2);
INSERT INTO demerit VALUES (127, 'Exceed speed limit by less than 10km/h', 1);
INSERT INTO demerit VALUES (128, 'Driving contrary to a minor defect notice', 1);
INSERT INTO demerit VALUES (129, 'Fail to dip headlights', 1);
INSERT INTO demerit VALUES (130, 'Driving at night or in bad weather without headlights/tail lights on', 1);
INSERT INTO demerit VALUES (131, 'Following too closely', 1);

--Insert 
--INSERT statements for driver table
INSERT INTO driver VALUES (112185001, 'Dalt', 'Alfonsini', '0425216915', '7 Scoville Alley', 'Melbourne', '3000', TO_DATE('24-Sep-1989', 'DD-MON-YYYY'), TO_DATE('5-Jun-2026', 'DD-MON-YYYY'));
INSERT INTO driver VALUES (112185002, 'Klarika', 'Angrove', '0446556898', '3 Del Mar Pass', 'Carnegie', '3163', TO_DATE('22-Jan-1984', 'DD-MON-YYYY'), TO_DATE('9-Feb-2029', 'DD-MON-YYYY'));
INSERT INTO driver VALUES (112185003, 'Franky', 'Niblock', '0442649578', '1563 Cordelia Crossing', 'Murrumbeena', '3163', TO_DATE('14-Aug-2001', 'DD-MON-YYYY'), TO_DATE('24-Sep-2026', 'DD-MON-YYYY'));
INSERT INTO driver VALUES (112185004, 'Johnny', 'Sneesby', '0424116988', '85 Randy Plaza', 'Balaclava', '3183', TO_DATE('25-Nov-1978', 'DD-MON-YYYY'), TO_DATE('16-Mar-2028', 'DD-MON-YYYY'));
INSERT INTO driver VALUES (112185005, 'Jasen', 'Lempke', '0400708662', '82 Bowman Court', 'Caulfield East', '3145', TO_DATE('25-Oct-1978', 'DD-MON-YYYY'), TO_DATE('21-Dec-2029', 'DD-MON-YYYY'));
INSERT INTO driver VALUES (112185006, 'Lawrence', 'Feaks', '0471213963', '81278 Bultman Drive', 'Armadale', '3143', TO_DATE('3-Sep-1978', 'DD-MON-YYYY'), TO_DATE('18-Jul-2024', 'DD-MON-YYYY'));
INSERT INTO driver VALUES (112185007, 'Annmarie', 'Dalli', '0496196954', '30 Di Loreto Crossing', 'Arthurs Creek', '3099', TO_DATE('11-Apr-1970', 'DD-MON-YYYY'), TO_DATE('8-Jun-2027', 'DD-MON-YYYY'));
INSERT INTO driver VALUES (112185008, 'Perkin', 'Allsepp', '0416817336', '15 Dexter Terrace', 'Melbourne', '3000', TO_DATE('27-Oct-1968', 'DD-MON-YYYY'), TO_DATE('22-Apr-2022', 'DD-MON-YYYY'));
INSERT INTO driver VALUES (112185009, 'Sharona', 'Beirne', '0485294292', '1532 Debra Terrace', 'South Yarra', '3141', TO_DATE('28-Mar-1993', 'DD-MON-YYYY'), TO_DATE('22-Jul-2023', 'DD-MON-YYYY'));
INSERT INTO driver VALUES (112185010, 'Donovan', 'Pilkington', '0493849468', '18 Manitowish Terrace', 'Wallan', '3756', TO_DATE('12-Feb-1987', 'DD-MON-YYYY'), TO_DATE('14-Sep-2023', 'DD-MON-YYYY'));
INSERT INTO driver VALUES (112185011, 'Debbie', 'Hedling', '0482676748', '0 Gulseth Center', 'Malvern East', '3145', TO_DATE('4-Oct-1979', 'DD-MON-YYYY'), TO_DATE('26-Apr-2022', 'DD-MON-YYYY'));
INSERT INTO driver VALUES (112185012, 'Perri', 'Belasco', '0408000719', '42793 Londonderry Road', 'Clayton South', '3169', TO_DATE('11-Jul-1962', 'DD-MON-YYYY'), TO_DATE('25-Sep-2027', 'DD-MON-YYYY'));
INSERT INTO driver VALUES (112185013, 'Cam', 'Cardenas', '0456032414', '6199 Fairview Junction', 'Lysterfield', '3156', TO_DATE('2-Dec-1964', 'DD-MON-YYYY'), TO_DATE('22-May-2022', 'DD-MON-YYYY'));
INSERT INTO driver VALUES (112185014, 'Salvador', 'Ellings', '0447900060', '8968 Carey Avenue', 'Attwood', '3049', TO_DATE('29-May-1968', 'DD-MON-YYYY'), TO_DATE('15-Jul-2023', 'DD-MON-YYYY'));
INSERT INTO driver VALUES (112185015, 'Courtenay', 'Shank', '0417307082', '42 Messerschmidt Drive', 'Melbourne', '3000', TO_DATE('12-Aug-1995', 'DD-MON-YYYY'), TO_DATE('3-Jan-2026', 'DD-MON-YYYY'));
INSERT INTO driver VALUES (112185016, 'Shannon', 'Joul', '0439780534', '16 Blaine Drive', 'Camira', '2469', TO_DATE('9-Oct-1977', 'DD-MON-YYYY'), TO_DATE('5-Oct-2028', 'DD-MON-YYYY'));
INSERT INTO driver VALUES (112185017, 'Carmon', 'Millmore', '0426991438', '3131 Ridgeway Court', 'Richmond', '3121', TO_DATE('29-Nov-1996', 'DD-MON-YYYY'), TO_DATE('13-Dec-2027', 'DD-MON-YYYY'));
INSERT INTO driver VALUES (112185018, 'Garvey', 'Nocair', '0467238296', '9 Anniversary Place', 'Richmond', '3121', TO_DATE('20-Oct-1989', 'DD-MON-YYYY'), TO_DATE('31-Mar-2026', 'DD-MON-YYYY'));
INSERT INTO driver VALUES (112185019, 'Dorolisa', 'MacParlan', '0457296801', '793 Chinook Plaza', 'Lysterfield South', '3156', TO_DATE('24-Mar-1989', 'DD-MON-YYYY'), TO_DATE('15-Sep-2027', 'DD-MON-YYYY'));
INSERT INTO driver VALUES (112185020, 'Meggy', 'McCathie', '0488241524', '5062 Moulton Drive', 'Lysterfield', '3156', TO_DATE('25-Jan-1983', 'DD-MON-YYYY'), TO_DATE('21-Aug-2023', 'DD-MON-YYYY'));
INSERT INTO driver VALUES (112185021, 'Esmeralda', 'Kuhle', '0460506139', '286 Grasskamp Parkway', 'Lysterfield', '3156', TO_DATE('21-Mar-1963', 'DD-MON-YYYY'), TO_DATE('2-Feb-2029', 'DD-MON-YYYY'));
INSERT INTO driver VALUES (112185022, 'Maurita', 'McDunlevy', '0453704532', '72824 7th Avenue', 'Melbourne', '3000', TO_DATE('5-Feb-2001', 'DD-MON-YYYY'), TO_DATE('28-Apr-2027', 'DD-MON-YYYY'));
INSERT INTO driver VALUES (112185023, 'Sadella', 'McLise', '0493041739', '3724 Bultman Pass', 'Clifton Hill', '3068', TO_DATE('14-Jul-1990', 'DD-MON-YYYY'), TO_DATE('26-Sep-2025', 'DD-MON-YYYY'));
INSERT INTO driver VALUES (112185024, 'Pepillo', 'Doogan', '0470269940', '10986 Monument Park', 'Zara', '2484', TO_DATE('10-Aug-1974', 'DD-MON-YYYY'), TO_DATE('21-Sep-2028', 'DD-MON-YYYY'));
INSERT INTO driver VALUES (112185025, 'Reuben', 'Goodbur', '0488332718', '4668 Corben Terrace', 'Yarra Glen', '3775', TO_DATE('28-Jan-2000', 'DD-MON-YYYY'), TO_DATE('3-Dec-2028', 'DD-MON-YYYY'));
INSERT INTO driver VALUES (112185026, 'Margarita', 'Mazzia', '0424066214', '141 Trailsway Center', 'Clayton', '3168', TO_DATE('9-May-1998', 'DD-MON-YYYY'), TO_DATE('16-Apr-2022', 'DD-MON-YYYY'));
INSERT INTO driver VALUES (112185027, 'Wang', 'Howsley', '0413429990', '54733 Springview Junction', 'Richmond North', '3121', TO_DATE('1-Dec-1985', 'DD-MON-YYYY'), TO_DATE('15-May-2023', 'DD-MON-YYYY'));
INSERT INTO driver VALUES (112185028, 'Leola', 'Pariso', '0450820968', '99586 Clove Way', 'Yarrah', '5433', TO_DATE('24-May-1978', 'DD-MON-YYYY'), TO_DATE('3-Feb-2027', 'DD-MON-YYYY'));
INSERT INTO driver VALUES (112185029, 'Baily', 'Mourgue', '0498100879', '89930 Buhler Circle', 'Clayton', '3168', TO_DATE('22-Jan-1997', 'DD-MON-YYYY'), TO_DATE('31-Jan-2022', 'DD-MON-YYYY'));
INSERT INTO driver VALUES (112185030, 'Sibbie', 'Arrigo', '0473565890', '97679 Golf Course Trail', 'Clayton South', '3169', TO_DATE('4-Jul-1986', 'DD-MON-YYYY'), TO_DATE('19-May-2025', 'DD-MON-YYYY'));
INSERT INTO driver VALUES (112185031, 'Ingeberg', 'Finlason', '0480000401', '954 Barnett Place', 'Belgrave Heights', '3160', TO_DATE('6-Oct-1970', 'DD-MON-YYYY'), TO_DATE('14-Jul-2025', 'DD-MON-YYYY'));
INSERT INTO driver VALUES (112185032, 'Tricia', 'Scholard', '0444083512', '3898 Carberry Park', 'Lysterfield', '3156', TO_DATE('28-Sep-1983', 'DD-MON-YYYY'), TO_DATE('2-Sep-2027', 'DD-MON-YYYY'));
INSERT INTO driver VALUES (112185033, 'Kennedy', 'Rastrick', '0456184162', '10 Mitchell Alley', 'Berwick', '3806', TO_DATE('1-Aug-1978', 'DD-MON-YYYY'), TO_DATE('15-Aug-2028', 'DD-MON-YYYY'));
INSERT INTO driver VALUES (112185034, 'Dolphie', 'Badriver', '0494098045', '3 Bartelt Crossing', 'Lysterfield', '3156', TO_DATE('25-Feb-1985', 'DD-MON-YYYY'), TO_DATE('9-Feb-2025', 'DD-MON-YYYY'));
INSERT INTO driver VALUES (112185035, 'Celia', 'Linden', '0486983753', '2938 Packers Pass', 'Richmond South', '3121', TO_DATE('31-Jan-1957', 'DD-MON-YYYY'), TO_DATE('19-Jan-2025', 'DD-MON-YYYY'));
INSERT INTO driver VALUES (112185036, 'Odelinda', 'Buckie', '0491943793', '0868 Weeping Birch Center', 'Melbourne', '3000', TO_DATE('3-Nov-1990', 'DD-MON-YYYY'), TO_DATE('15-Oct-2028', 'DD-MON-YYYY'));
INSERT INTO driver VALUES (112185037, 'Miller', 'Gettens', '0431957385', '833 Red Cloud Court', 'Pakenham', '3810', TO_DATE('23-May-1983', 'DD-MON-YYYY'), TO_DATE('22-Aug-2028', 'DD-MON-YYYY'));
INSERT INTO driver VALUES (112185038, 'Benni', 'Jacmard', '0489058864', '300 Gina Center', 'Belgrave Heights', '3160', TO_DATE('7-Aug-1951', 'DD-MON-YYYY'), TO_DATE('31-Jul-2024', 'DD-MON-YYYY'));
INSERT INTO driver VALUES (112185039, 'Brandise', 'Panichelli', '0454666154', '1 Golden Leaf Place', 'Pakenham Upper', '3810', TO_DATE('23-Dec-1999', 'DD-MON-YYYY'), TO_DATE('18-Nov-2025', 'DD-MON-YYYY'));
INSERT INTO driver VALUES (112185040, 'Richardo', 'Lawless', '0446215683', '27 Pine View Pass', 'Leongatha South', '3953', TO_DATE('16-Jan-1977', 'DD-MON-YYYY'), TO_DATE('6-Jan-2026', 'DD-MON-YYYY'));

--INSERT statement for vehicle table
INSERT INTO vehicle VALUES ('WAUZZZF15KD038432', TO_DATE('2019', 'YYYY'), 'Black', 'Audi', 'Q8 55 TFSI', 'CR');
INSERT INTO vehicle VALUES ('ZHWEF4ZF2LLA13803', TO_DATE('2019', 'YYYY'), 'Grey', 'Lamborghini', 'Huracan EVO', 'CR');
INSERT INTO vehicle VALUES ('WAUZZZF1XKD037356', TO_DATE('2019', 'YYYY'), 'Grey', 'Audi', 'Q8 55 TFSI', 'CR');
INSERT INTO vehicle VALUES ('ZHWES4ZF8KLA12259', TO_DATE('2019', 'YYYY'), 'Black', 'Lamborghini', 'Huracan Performante', 'CR');
INSERT INTO vehicle VALUES ('5TDBK3FH50S049497', TO_DATE('2014', 'YYYY'), 'Blue', 'Toyota', 'Kluger', 'CR');
INSERT INTO vehicle VALUES ('JM0ER10L200236251', TO_DATE('2011', 'YYYY'), 'Black', 'Mazda', 'CX-7', 'CR');
INSERT INTO vehicle VALUES ('MPATFS85JDT005836', TO_DATE('2013', 'YYYY'), 'Silver', 'Isuzu', 'D-MAX', 'CR');
INSERT INTO vehicle VALUES ('JT4RN55D1J7027072', TO_DATE('1998', 'YYYY'), 'Yellow', 'Toyota', 'Hilux', 'CR');
INSERT INTO vehicle VALUES ('YV449MRS0G2864142', TO_DATE('2016', 'YYYY'), 'Beige', 'Volvo', 'XC60', 'CR');
INSERT INTO vehicle VALUES ('JACUBS26G17100401', TO_DATE('2001', 'YYYY'), 'Silver', 'Holden', 'Jackaroo', 'CR');
INSERT INTO vehicle VALUES ('3VWRR31C56M424400', TO_DATE('2006', 'YYYY'), 'Grey', 'Volkswagen', 'Beetle', 'CR');
INSERT INTO vehicle VALUES ('WBAAM333XYKC67114', TO_DATE('2000', 'YYYY'), 'White', 'BMW', '3 Series', 'CR');
INSERT INTO vehicle VALUES ('5N1ED28T08C631303', TO_DATE('2008', 'YYYY'), 'Black', 'Nissan', 'Xterra', 'CR');
INSERT INTO vehicle VALUES ('1N6ND12Y1HC385546', TO_DATE('1987', 'YYYY'), 'Black', 'Nissan', 'D21', 'CR');
INSERT INTO vehicle VALUES ('KMHWF25H44A010707', TO_DATE('2004', 'YYYY'), 'White', 'Hyundai', 'Sonata', 'CR');
INSERT INTO vehicle VALUES ('VF1CD36B7C2582794', TO_DATE('1982', 'YYYY'), 'Orange', 'Renault', 'Fuego', 'CR');
INSERT INTO vehicle VALUES ('JM1TA2213Y1616325', TO_DATE('2000', 'YYYY'), 'Grey', 'Mazda', 'Millenia', 'CR');
INSERT INTO vehicle VALUES ('JN1PS24S7FW021159', TO_DATE('1985', 'YYYY'), 'White', 'Nissan', '200SX', 'CR');
INSERT INTO vehicle VALUES ('1HFSC2213SA700065', TO_DATE('1995', 'YYYY'), 'Red', 'Honda', 'GL1500', 'MB');
INSERT INTO vehicle VALUES ('5XYKWDA70EG526849', TO_DATE('2014', 'YYYY'), 'Grey', 'Kia', 'Sorento', 'CR');
INSERT INTO vehicle VALUES ('WDDGF4HB8CR234192', TO_DATE('2012', 'YYYY'), 'Brown', 'Mercedes Benz', 'C Class', 'CR');
INSERT INTO vehicle VALUES ('WDBKK65F13F275945', TO_DATE('2003', 'YYYY'), 'Black', 'Mercedes Benz', 'SLK Class', 'CR');
INSERT INTO vehicle VALUES ('JA3AJ46EX2U027924', TO_DATE('2002', 'YYYY'), 'Grey', 'Mitsubishi', 'Lancer', 'CR');
INSERT INTO vehicle VALUES ('JN1EB31PXNU500957', TO_DATE('1992', 'YYYY'), 'Black', 'Nissan', 'Sentra', 'CR');
INSERT INTO vehicle VALUES ('WBAEU33465PR14291', TO_DATE('2005', 'YYYY'), 'Red', 'BMW', '3 Series', 'CR');
INSERT INTO vehicle VALUES ('5UXZV4C52BL739734', TO_DATE('2011', 'YYYY'), 'Blue', 'BMW', 'X5', 'CR');
INSERT INTO vehicle VALUES ('1B3BP68J8MN518050', TO_DATE('1991', 'YYYY'), 'Silver', 'Dodge', 'Shadow', 'CR');
INSERT INTO vehicle VALUES ('4T1BD1FK5EU109805', TO_DATE('2014', 'YYYY'), 'Silver', 'Toyota', 'Camry', 'CR');
INSERT INTO vehicle VALUES ('5YJSA1CG3DFP14555', TO_DATE('2013', 'YYYY'), 'White', 'Tesla', 'Model S', 'CR');
INSERT INTO vehicle VALUES ('JN8DR09X24W803357', TO_DATE('2004', 'YYYY'), 'Grey', 'Nissan', 'Pathfinder', 'CR');
INSERT INTO vehicle VALUES ('JA4NW51S93J601384', TO_DATE('2003', 'YYYY'), 'White', 'Mitsubishi', 'Montero', 'CR');
INSERT INTO vehicle VALUES ('WBSWL93539P528903', TO_DATE('2009', 'YYYY'), 'White', 'BMW', 'M3', 'CR');
INSERT INTO vehicle VALUES ('WD8PD144765963886', TO_DATE('2006', 'YYYY'), 'White', 'Dodge', 'Sprinter', 'CR');
INSERT INTO vehicle VALUES ('5YJSA3H10EFP46509', TO_DATE('2014', 'YYYY'), 'White', 'Tesla', 'Model S', 'CR');
INSERT INTO vehicle VALUES ('1Z7HT38N070010439', TO_DATE('2007', 'YYYY'), 'Silver', 'Mitsubishi', 'Raider', 'CR');
INSERT INTO vehicle VALUES ('4T4BE46K89R209794', TO_DATE('2009', 'YYYY'), 'Red', 'Toyota', 'Camry', 'CR');
INSERT INTO vehicle VALUES ('5YJSB1A28C1B00023', TO_DATE('2012', 'YYYY'), 'Orange', 'Tesla', 'Model S', 'CR');
INSERT INTO vehicle VALUES ('WMWMF73509TV39579', TO_DATE('2009', 'YYYY'), 'Blue', 'Mini', 'Cooper', 'CR');
INSERT INTO vehicle VALUES ('4T1BE32K34WU88093', TO_DATE('2004', 'YYYY'), 'White', 'Toyota', 'Camry', 'CR');
INSERT INTO vehicle VALUES ('JA3BC54N0H0014736', TO_DATE('1987', 'YYYY'), 'Black', 'Mitsubishi', 'Starion', 'CR');
INSERT INTO vehicle VALUES ('4A3AJ46GXTE358921', TO_DATE('1996', 'YYYY'), 'Blue', 'Mitsubishi', 'Galant', 'CR');
INSERT INTO vehicle VALUES ('JT4RN60S7F5054632', TO_DATE('1985', 'YYYY'), 'White', 'Toyota', 'Hilux', 'CR');
INSERT INTO vehicle VALUES ('3N1CB51D643901195', TO_DATE('2004', 'YYYY'), 'White', 'Nissan', 'Sentra', 'CR');
INSERT INTO vehicle VALUES ('ZFFRG43A0R0096189', TO_DATE('1994', 'YYYY'), 'Orange', 'Ferrari', '348', 'CR');
INSERT INTO vehicle VALUES ('JA3AJ16E05U031516', TO_DATE('2005', 'YYYY'), 'Yellow', 'Mitsubishi', 'Lancer', 'CR');
INSERT INTO vehicle VALUES ('JT4RN60S0E0000486', TO_DATE('1984', 'YYYY'), 'White', 'Toyota', 'Hilux', 'CR');
INSERT INTO vehicle VALUES ('137PH90366E221476', TO_DATE('2006', 'YYYY'), 'Red', 'Hummer', 'H1 Alpha', 'CR');
INSERT INTO vehicle VALUES ('5YJSA1S1XFFP78690', TO_DATE('2015', 'YYYY'), 'White', 'Tesla', 'Model S', 'CR');
INSERT INTO vehicle VALUES ('4A3AX55F0TE411509', TO_DATE('1996', 'YYYY'), 'Blue', 'Mitsubishi', 'Eclipse Spyder', 'CR');
INSERT INTO vehicle VALUES ('JN1HJ01S0MT041509', TO_DATE('1991', 'YYYY'), 'Red', 'Nissan', 'Maxima', 'CR');

COMMIT;



