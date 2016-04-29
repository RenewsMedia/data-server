CREATE TABLE IF NOT EXISTS 'channels' (
    'id'            SERIAL NOT NULL,
    'owner'         INTEGER NOT NULL,
    'name'          VARCHAR(20) NOT NULL,
    'description'   VARCHAR(5000),
    'date_create'   TIMESTAMP DEFAULT (now() at time zone 'utc'),

    FOREIGN KEY ('owner') REFERENCES 'users' ('id'),
    PRIMARY KEY ('id')
);
CREATE INDEX ON 'channels' ('name');