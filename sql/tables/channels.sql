CREATE TABLE IF NOT EXISTS 'channels' (
    'id' SERIAL NOT NULL,
    'owner' INTEGER NOT NULL,
    'name' VARCHAR(20) NOT NULL,
    'description' VARCHAR(5000) NOT NULL,
    'date_create' TIMESTAMP DEFAULT now(),

    FOREIGN KEY ('owner') REFERENCES 'users' ('id'),
    PRIMARY KEY ('id')
);