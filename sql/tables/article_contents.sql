CREATE TABLE IF NOT EXISTS 'article_contents' (
    'article' INTEGER NOT NULL,
    'content' INTEGER NOT NULL,
    'order' INTEGER DEFAULT 0,

    FOREIGN KEY ('article') REFERENCES 'articles' ('id'),
    FOREIGN KEY ('content') REFERENCES 'contents' ('id')
);