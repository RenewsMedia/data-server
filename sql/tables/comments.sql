CREATE TABLE IF NOT EXISTS 'comments' (
    'id'        SERIAL NOT NULL,
    'author'    INTEGER NOT NULL,
    'text'      INTEGER NOT NULL,
    'published' TIMESTAMP DEFAULT now(),

    FOREIGN KEY ('author') REFERENCES 'users' ('id'),
    FOREIGN KEY ('text') REFERENCES 'text_data' ('id'),
    PRIMARY KEY ('id')
);