/* 4(i)*/
ALTER TABLE driver ADD lic_times_suspended NUMBER(7) DEFAULT 0 NOT NULL;

COMMENT ON COLUMN driver.lic_times_suspended IS
    'Number of times licence has been suspended';

UPDATE driver
SET
    lic_times_suspended = (
        SELECT
            COUNT(*)
        FROM
            suspension
        WHERE
            suspension.lic_no = driver.lic_no
    );

COMMIT;

/* 4(ii)*/

DROP TABLE licence_expiry CASCADE CONSTRAINTS;

CREATE TABLE licence_expiry
    AS
        SELECT
            lic_no,
            lic_expiry
        FROM
            driver;

COMMENT ON COLUMN licence_expiry.lic_no IS
    'Licence number';

COMMENT ON COLUMN licence_expiry.lic_expiry IS
    'Licence expiry date';

ALTER TABLE licence_expiry ADD (
    CONSTRAINT licence_expiry_pk PRIMARY KEY ( lic_no,
                                               lic_expiry ),
    CONSTRAINT driver_licence_expiry_fk FOREIGN KEY ( lic_no )
        REFERENCES driver ( lic_no )
);

ALTER TABLE driver DROP COLUMN lic_expiry;

INSERT INTO licence_expiry VALUES (
    112185029,
    (
        SELECT
            add_months(MAX(lic_expiry), 10 * 12)
        FROM
            licence_expiry
        WHERE
            lic_no = 112185029
    )
);

COMMIT;

/* 4(iii)*/
ALTER TABLE offence ADD (
    offence_rev_stat VARCHAR2(2) DEFAULT 'NR' NOT NULL,
    CONSTRAINT offence_rev_stat_chk CHECK ( offence_rev_stat IN ( 'R', 'NR' ) )
);

COMMENT ON COLUMN offence.offence_rev_stat IS
    'Whether the offence is revoked (R) or not revoked (NR)';

DROP TABLE offence_revoked CASCADE CONSTRAINTS;

CREATE TABLE offence_revoked (
    dem_code             NUMBER(3) NOT NULL,
    intercept_no         NUMBER(7) NOT NULL,
    offence_revoke_date  DATE NOT NULL,
    officer_id           NUMBER(8) NOT NULL,
    revoke_reason_code   CHAR(3) NOT NULL,
    CONSTRAINT offence_revoked_pk PRIMARY KEY ( dem_code,
                                                intercept_no )
);

COMMENT ON COLUMN offence_revoked.intercept_no IS
    'Intercept number';

COMMENT ON COLUMN offence_revoked.dem_code IS
    'Demerit unique code';

COMMENT ON COLUMN offence_revoked.offence_revoke_date IS
    'The date the offence was revoked';

COMMENT ON COLUMN offence_revoked.officer_id IS
    'TDS officer id number';

COMMENT ON COLUMN offence_revoked.revoke_reason_code IS
    'The offence revocation reason code';

DROP TABLE revoke_reason CASCADE CONSTRAINTS;

CREATE TABLE revoke_reason (
    revoke_reason_code  CHAR(3) NOT NULL,
    revoke_reason_desc  VARCHAR(100) NOT NULL,
    CONSTRAINT revoke_reason_pk PRIMARY KEY ( revoke_reason_code ),
    CONSTRAINT revoke_reason_nk UNIQUE ( revoke_reason_desc )
);

COMMENT ON COLUMN revoke_reason.revoke_reason_code IS
    'The offence revocation reason code';

COMMENT ON COLUMN revoke_reason.revoke_reason_desc IS
    'The offence revocation reason description';

ALTER TABLE offence_revoked ADD (
    CONSTRAINT officer_offence_revoked_fk FOREIGN KEY ( officer_id )
        REFERENCES officer ( officer_id ),
    CONSTRAINT revoke_reason_offence_revoked_fk FOREIGN KEY ( revoke_reason_code )
        REFERENCES revoke_reason ( revoke_reason_code ),
    CONSTRAINT offence_offence_revoked_fk FOREIGN KEY ( dem_code,
                                                        intercept_no )
        REFERENCES offence ( dem_code,
                             intercept_no )
);

INSERT INTO revoke_reason VALUES (
    'FOS',
    'First offence exceeding the speed limit by less than 10km/h'
);

INSERT INTO revoke_reason VALUES (
    'FEU',
    'Faulty equipment used'
);

INSERT INTO revoke_reason VALUES (
    'DOU',
    'Driver objection upheld'
);

INSERT INTO revoke_reason VALUES (
    'COH',
    'Court hearing'
);

INSERT INTO revoke_reason VALUES (
    'EIP',
    'Error in proceedings'
);

COMMIT;

INSERT INTO offence_revoked VALUES (
    (
        SELECT
            dem_code
        FROM
            demerit
        WHERE
            dem_description = 'Using a mobile phone illegally while driving'
    ),
    (
        SELECT
            intercept_no
        FROM
            intercept
        WHERE
                intercept_datetime = TO_DATE('05/12/2021 09:00 AM', 'dd/mm/yyyy hh:mi AM')
            AND lic_no = (
                SELECT
                    lic_no
                FROM
                    driver
                WHERE
                    lic_mobile = '0446215683'
            )
    ),
    TO_DATE('17/12/2021', 'dd/mm/yyyy'),
    10000019,
    (
        SELECT
            revoke_reason_code
        FROM
            revoke_reason
        WHERE
            revoke_reason_desc = 'Driver objection upheld'
    )
);

UPDATE offence
SET
    offence_rev_stat = 'R'
WHERE
    ( dem_code, intercept_no ) IN (
        SELECT
            dem_code,
            intercept_no
        FROM
            offence_revoked
    );

COMMIT;