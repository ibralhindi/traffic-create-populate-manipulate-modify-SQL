/* Task 2 Load the INTERCEPT, OFFENSE and SUSPENSION tables with your own*/
/* test data following the data requirements expressed in the brief*/

INSERT INTO intercept VALUES (
    1,
    TO_DATE('01/01/2019 09:00 AM', 'dd/mm/yyyy hh:mi AM'),
    'Chapel St, South Yarra, 3141',
    10000001,
    'WAUZZZF15KD038432',
    112185001
);

COMMIT;

INSERT INTO intercept VALUES (
    2,
    TO_DATE('05/03/2019 10:00 AM', 'dd/mm/yyyy hh:mi AM'),
    'Swanston St, Melbourne, 3000',
    10000002,
    'ZHWEF4ZF2LLA13803',
    112185002
);

INSERT INTO offence VALUES (
    99,
    2
);

INSERT INTO offence VALUES (
    100,
    2
);

COMMIT;

INSERT INTO intercept VALUES (
    3,
    TO_DATE('10/07/2019 11:00 AM', 'dd/mm/yyyy hh:mi AM'),
    'Elizabeth St, Melbourne, 3000',
    10000003,
    'WAUZZZF1XKD037356',
    112185003
);

INSERT INTO offence VALUES (
    101,
    3
);

INSERT INTO offence VALUES (
    102,
    3
);

COMMIT;

INSERT INTO intercept VALUES (
    4,
    TO_DATE('15/02/2020 12:00 PM', 'dd/mm/yyyy hh:mi PM'),
    'King St, Melbourne, 3000',
    10000004,
    'ZHWEF4ZF2LLA13803',
    112185002
);

INSERT INTO offence VALUES (
    103,
    4
);

INSERT INTO suspension VALUES (
    1,
    TO_DATE('15/02/2020', 'dd/mm/yyyy'),
    TO_DATE('15/08/2020', 'dd/mm/yyyy'),
    112185002
);

COMMIT;

INSERT INTO intercept VALUES (
    5,
    TO_DATE('20/04/2020 01:00 PM', 'dd/mm/yyyy hh:mi PM'),
    'Queen St, Melbourne, 3000',
    10000005,
    'JM0ER10L200236251',
    112185004
);

INSERT INTO offence VALUES (
    104,
    5
);

INSERT INTO offence VALUES (
    105,
    5
);

COMMIT;

INSERT INTO intercept VALUES (
    6,
    TO_DATE('25/07/2020 02:00 PM', 'dd/mm/yyyy hh:mi PM'),
    'Russell St, Melbourne, 3000',
    10000006,
    'WBAAM333XYKC67114',
    112185005
);

INSERT INTO offence VALUES (
    106,
    6
);

INSERT INTO offence VALUES (
    107,
    6
);

COMMIT;

INSERT INTO intercept VALUES (
    7,
    TO_DATE('01/03/2021 03:00 PM', 'dd/mm/yyyy hh:mi PM'),
    'Bourke St, Melbourne, 3000',
    10000007,
    'WAUZZZF1XKD037356',
    112185003
);

INSERT INTO offence VALUES (
    123,
    7
);

INSERT INTO offence VALUES (
    124,
    7
);

INSERT INTO suspension VALUES (
    2,
    TO_DATE('01/03/2021', 'dd/mm/yyyy'),
    TO_DATE('01/09/2021', 'dd/mm/yyyy'),
    112185003
);

COMMIT;

INSERT INTO intercept VALUES (
    8,
    TO_DATE('05/06/2021 04:00 PM', 'dd/mm/yyyy hh:mi PM'),
    'William St, Melbourne, 3000',
    10000008,
    'ZHWEF4ZF2LLA13803',
    112185002
);

INSERT INTO offence VALUES (
    116,
    8
);

INSERT INTO offence VALUES (
    117,
    8
);

COMMIT;

INSERT INTO intercept VALUES (
    9,
    TO_DATE('10/08/2021 05:00 PM', 'dd/mm/yyyy hh:mi PM'),
    'Exhibition St, Melbourne, 3000',
    10000009,
    '1N6ND12Y1HC385546',
    112185007
);

INSERT INTO offence VALUES (
    118,
    9
);

COMMIT;

INSERT INTO intercept VALUES (
    10,
    TO_DATE('15/11/2021 06:00 PM', 'dd/mm/yyyy hh:mi PM'),
    'Lonsdale St, Melbourne, 3000',
    10000010,
    'KMHWF25H44A010707',
    112185008
);

INSERT INTO offence VALUES (
    119,
    10
);

COMMIT;