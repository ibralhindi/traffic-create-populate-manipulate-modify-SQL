/* 3(i)*/
DROP SEQUENCE intercept_seq;

DROP SEQUENCE suspension_seq;

CREATE SEQUENCE intercept_seq START WITH 100 INCREMENT BY 1;

CREATE SEQUENCE suspension_seq START WITH 100 INCREMENT BY 1;

/* 3(ii)*/
INSERT INTO intercept VALUES (
    intercept_seq.NEXTVAL,
    TO_DATE('05/12/2021 09:00 AM', 'dd/mm/yyyy hh:mi AM'),
    'Nerrena Rd, Leongatha, 3953',
    (
        SELECT
            officer_id
        FROM
            officer
        WHERE
                officer_fname = 'Dolley'
            AND officer_lname = 'Hedling'
    ),
    '4T1BE32K34WU88093',
    (
        SELECT
            lic_no
        FROM
            driver
        WHERE
            lic_mobile = '0446215683'
    )
);

INSERT INTO offence VALUES (
    (
        SELECT
            dem_code
        FROM
            demerit
        WHERE
            dem_description = 'Using a mobile phone illegally while driving'
    ),
    intercept_seq.CURRVAL
);

COMMIT;

/* 3(iii)*/
INSERT INTO intercept VALUES (
    intercept_seq.NEXTVAL,
    TO_DATE('05/12/2021 08:00 PM', 'dd/mm/yyyy hh:mi PM') + 7,
    'Intersection of Turner St and Bent St, Leongatha, 3953',
    (
        SELECT
            officer_id
        FROM
            officer
        WHERE
                officer_fname = 'Geoff'
            AND officer_lname = 'Kilmartin'
    ),
    '4T1BE32K34WU88093',
    (
        SELECT
            lic_no
        FROM
            driver
        WHERE
            lic_mobile = '0446215683'
    )
);

INSERT INTO offence VALUES (
    (
        SELECT
            dem_code
        FROM
            demerit
        WHERE
            dem_description = 'Exceeding the speed limit by 25 km/h or more'
    ),
    intercept_seq.CURRVAL
);

INSERT INTO offence VALUES (
    (
        SELECT
            dem_code
        FROM
            demerit
        WHERE
            dem_description = 'Failing to give way, or stop, or remain stopped'
    ),
    intercept_seq.CURRVAL
);

INSERT INTO offence VALUES (
    (
        SELECT
            dem_code
        FROM
            demerit
        WHERE
            dem_description = 'Driving at night or in bad weather without headlights/tail lights on'
    ),
    intercept_seq.CURRVAL
);

INSERT INTO suspension VALUES (
    suspension_seq.NEXTVAL,
    TO_DATE('05/12/2021', 'dd/mm/yyyy') + 7,
    add_months(TO_DATE('05/12/2021', 'dd/mm/yyyy') + 7, 6),
    (
        SELECT
            lic_no
        FROM
            driver
        WHERE
            lic_mobile = '0446215683'
    )
);

COMMIT;

/* 3(iv)*/
UPDATE offence
SET
    dem_code = (
        SELECT
            dem_code
        FROM
            demerit
        WHERE
            dem_description = 'Exceeding the speed limit by 10 km/h or more but less than 25 km/h'
    )
WHERE
        dem_code = (
            SELECT
                dem_code
            FROM
                demerit
            WHERE
                dem_description = 'Exceeding the speed limit by 25 km/h or more'
        )
    AND intercept_no = (
        SELECT
            intercept_no
        FROM
            intercept
        WHERE
                intercept_datetime = TO_DATE('15/12/2021 08:00 PM', 'dd/mm/yyyy hh:mi PM') -
                3
            AND lic_no = (
                SELECT
                    lic_no
                FROM
                    driver
                WHERE
                    lic_mobile = '0446215683'
            )
    );

DELETE FROM suspension
WHERE
        sus_startdate = TO_DATE('15/12/2021', 'dd/mm/yyyy') - 3
    AND lic_no = (
        SELECT
            lic_no
        FROM
            driver
        WHERE
            lic_mobile = '0446215683'
    );

COMMIT;