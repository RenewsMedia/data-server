CREATE TABLE IF NOT EXISTS 'comments' (
    'id'        SERIAL NOT NULL,
    'author'    INTEGER NOT NULL,
    'data'      INTEGER NOT NULL,
    'published' TIMESTAMP DEFAULT (now() at time zone 'utc'),

    FOREIGN KEY ('author') REFERENCES 'users' ('id'),
    FOREIGN KEY ('data') REFERENCES 'text_data' ('id'),
    PRIMARY KEY ('id')
);