CREATE TABLE IF NOT EXISTS 'articles' (
    'id' SERIAL NOT NULL,
    'author' INTEGER NOT NULL,
    'title' VARCHAR(150) NOT NULL,
    'created' TIMESTAMP DEFAULT now(),
    'published' TIMESTAMP DEFAULT now(),
    'hidden' BOOLEAN DEFAULT FALSE,

    FOREIGN KEY ('author') REFERENCES 'users' ('id'),
    PRIMARY KEY ('id')
);