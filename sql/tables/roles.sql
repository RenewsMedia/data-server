CREATE TABLE IF NOT EXISTS 'roles' (
    'code'      VARCHAR(3) NOT NULL,
    'name'      VARCHAR(20) NOT NULL,
    'access'    VARCHAR[],

    PRIMARY KEY ('code')
);