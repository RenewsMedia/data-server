CREATE TABLE IF NOT EXISTS 'users' (
    'id' SERIAL NOT NULL,
    'login' VARCHAR(20) NOT NULL,
    'password' VARCHAR(32) NOT NULL,
    'mail' VARCHAR(100) NOT NULL,
    'name' VARCHAR(20),
    'surname' VARCHAR(20),
    'country' VARCHAR(2),
    'date_reg' TIMESTAMP DEFAULT now(),

    FOREIGN KEY ('country') REFERENCES 'countries' ('code'),
    PRIMARY KEY ('id')
);