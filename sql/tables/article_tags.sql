CREATE TABLE IF NOT EXISTS 'article_tags' (
    'article'   INTEGER NOT NULL,
    'tag'       INTEGER NOT NULL,

    FOREIGN KEY ('article') REFERENCES 'articles' ('id'),
    FOREIGN KEY ('tag')     REFERENCES 'tags' ('id'),
    PRIMARY KEY ('article', 'tag')
);
CREATE INDEX ON 'article_tags' ('article');