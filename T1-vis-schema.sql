/* Task 1 Add Create table statments for the Missing TABLES below*/
/* Ensure all column comments, and constraints (other than FK's)*/
/* are included. FK constraints are to be added in the FK Constraints section*/

/* INTERCEPT*/
CREATE TABLE intercept (
    intercept_no        NUMBER(7) NOT NULL,
    intercept_datetime  DATE NOT NULL,
    intercept_location  VARCHAR2(100) NOT NULL,
    officer_id          NUMBER(8) NOT NULL,
    veh_vin             CHAR(17) NOT NULL,
    lic_no              NUMBER(9) NOT NULL,
    CONSTRAINT intercept_pk PRIMARY KEY ( intercept_no ),
    CONSTRAINT intercept_nk1 UNIQUE ( intercept_datetime,
                                      officer_id ),
    CONSTRAINT intercept_nk2 UNIQUE ( intercept_datetime,
                                      veh_vin ),
    CONSTRAINT intercept_nk3 UNIQUE ( intercept_datetime,
                                      lic_no )
);

COMMENT ON COLUMN intercept.intercept_no IS
    'Intercept number (unique)';

COMMENT ON COLUMN intercept.intercept_datetime IS
    'Intercept date and time';

COMMENT ON COLUMN intercept.intercept_location IS
    'Intercept location';

COMMENT ON COLUMN intercept.officer_id IS
    'ID of the officer who intercepted the vehicle';

COMMENT ON COLUMN intercept.veh_vin IS
    'VIN of the intercepted vehicle';

COMMENT ON COLUMN intercept.lic_no IS
    'Licence number of the intercepted vehicle''s driver';


/* OFFENCE*/
CREATE TABLE offence (
    dem_code      NUMBER(3) NOT NULL,
    intercept_no  NUMBER(7) NOT NULL,
    CONSTRAINT offence_pk PRIMARY KEY ( dem_code,
                                        intercept_no )
);

COMMENT ON COLUMN offence.intercept_no IS
    'Intercept number';

COMMENT ON COLUMN offence.dem_code IS
    'Demerit unique code';


/* SUSPENSION*/
CREATE TABLE suspension (
    sus_no         NUMBER(7) NOT NULL,
    sus_startdate  DATE NOT NULL,
    sus_enddate    DATE NOT NULL,
    lic_no         NUMBER(9) NOT NULL,
    CONSTRAINT suspension_pk PRIMARY KEY ( sus_no ),
    CONSTRAINT suspension_nk UNIQUE ( sus_startdate,
                                      lic_no )
);

COMMENT ON COLUMN suspension.sus_no IS
    'Suspension number (unique)';

COMMENT ON COLUMN suspension.sus_startdate IS
    'Suspension start date (date only, no time required)';

COMMENT ON COLUMN suspension.sus_enddate IS
    'Suspension end date (date only, no time required)';

COMMENT ON COLUMN suspension.lic_no IS
    'Licence number of the suspended driver';


/* Add all missing FK Constraints below here*/
ALTER TABLE intercept ADD (
    CONSTRAINT officer_intercept_fk FOREIGN KEY ( officer_id )
        REFERENCES officer ( officer_id ),
    CONSTRAINT vehicle_intercept_fk FOREIGN KEY ( veh_vin )
        REFERENCES vehicle ( veh_vin ),
    CONSTRAINT driver_intercept_fk FOREIGN KEY ( lic_no )
        REFERENCES driver ( lic_no )
);

ALTER TABLE offence ADD (
    CONSTRAINT intercept_offence_fk FOREIGN KEY ( intercept_no )
        REFERENCES intercept ( intercept_no ),
    CONSTRAINT demerit_offence_fk FOREIGN KEY ( dem_code )
        REFERENCES demerit ( dem_code )
);

ALTER TABLE suspension
    ADD CONSTRAINT driver_suspension_fk FOREIGN KEY ( lic_no )
        REFERENCES driver ( lic_no );
                                                             
        
/*----------------------------------------------------------------*/
/*RUN THE CODE BELOW TO CREATE A TRIGGER TO CHECK*/
/*DRIVER'S TOTAL DEMERIT POINTS IN THE LAST 3 YEARS*/

/*YOU MUST NOT MODIFY THE CODE BELOW*/
/*----------------------------------------------------------------*/

CREATE OR REPLACE TRIGGER checkpointsaccumulated BEFORE
    INSERT ON offence
    FOR EACH ROW
DECLARE
    ptslastthreeyrs          NUMBER(2);
    demptsforoffence         NUMBER(1);
    maxsuspenddatefordriver  DATE;
    maxoffdatefordriver      DATE;
    ptssincelastsusp         NUMBER(2);
    newoffencedate           DATE;
    newlicno                 NUMBER(9);
BEGIN
    SELECT
        lic_no,
        intercept_datetime
    INTO
        newlicno,
        newoffencedate
    FROM
        intercept
    WHERE
        intercept_no = :new.intercept_no;

    SELECT
        nvl(MAX(sus_enddate), TO_DATE('1-JAN-1900', 'DD-MON-YYYY'))
    INTO maxsuspenddatefordriver
    FROM
        suspension
    WHERE
        lic_no = newlicno;

    IF maxsuspenddatefordriver = TO_DATE('1-JAN-1900', 'DD-MON-YYYY') THEN
        dbms_output.put_line('Driver '
                             || rtrim(newlicno)
                             || ' has never been suspended.');
        SELECT
            nvl(SUM(d.dem_points), 0)
        INTO ptslastthreeyrs
        FROM
                 demerit d
            JOIN offence    o
            ON d.dem_code = o.dem_code
            JOIN intercept  i
            ON o.intercept_no = i.intercept_no
        WHERE
            i.intercept_datetime BETWEEN add_months(newoffencedate, - 36) AND newoffencedate
            AND i.lic_no = newlicno;

        SELECT
            d.dem_points
        INTO demptsforoffence
        FROM
            demerit d
        WHERE
            dem_code = :new.dem_code;

        dbms_output.put_line('Excluding this offence, driver '
                             || rtrim(newlicno)
                             || ' has incurred '
                             || ptslastthreeyrs
                             || ' demerit points. These points are calculated from '
                             || add_months(newoffencedate, -36)
                             || ' to '
                             || newoffencedate
                             || '. Demerit point/s incurred for this offence is/are '
                             || demptsforoffence
                             || '.');

        dbms_output.put_line('Total points NOW are: '
                             ||(ptslastthreeyrs + demptsforoffence)
                             || '.');
    ELSE
        dbms_output.put_line('Driver '
                             || rtrim(newlicno)
                             || ' has been suspended before.');
        SELECT
            MAX(sus_enddate)
        INTO maxsuspenddatefordriver
        FROM
            suspension
        WHERE
            lic_no = newlicno;

        IF months_between(newoffencedate, maxsuspenddatefordriver) < 36 THEN
            dbms_output.put_line('Driver '
                                 || rtrim(newlicno)
                                 || ' has been suspended in the last 3 years. Points for this driver are calculated from '
                                 || maxsuspenddatefordriver);
        ELSE
            maxsuspenddatefordriver := add_months(newoffencedate, -36);
            dbms_output.put_line('Driver '
                                 || rtrim(newlicno)
                                 || ' has not been suspended in the last 3 years. Points for this driver are calculated from '
                                 || maxsuspenddatefordriver);

        END IF;

        SELECT
            nvl(SUM(d.dem_points), 0)
        INTO ptssincelastsusp
        FROM
                 demerit d
            JOIN offence    o
            ON d.dem_code = o.dem_code
            JOIN intercept  i
            ON o.intercept_no = i.intercept_no
        WHERE
                i.lic_no = newlicno
            AND i.intercept_datetime BETWEEN maxsuspenddatefordriver AND newoffencedate;

        SELECT
            d.dem_points
        INTO demptsforoffence
        FROM
            demerit d
        WHERE
            dem_code = :new.dem_code;

        dbms_output.put_line('Excluding this offence, driver '
                             || rtrim(newlicno)
                             || ' has incurred '
                             || ptssincelastsusp
                             || ' demerit points. These points are calculated from '
                             || maxsuspenddatefordriver
                             || ' to '
                             || newoffencedate
                             || '. Demerit point/s incurred for this offence is/are '
                             || demptsforoffence
                             || '.');

        dbms_output.put_line('Total points NOW are: '
                             ||(ptssincelastsusp + demptsforoffence)
                             || '.');
    END IF;

END;
/

SET SERVEROUTPUT ON;

/*----------------------------*/
/*END OF TRIGGER*/
/*----------------------------*/