CREATE TABLE IF NOT EXISTS 'contents' (
    'id'        SERIAL NOT NULL,
    'type'      ARTICLE_CONTENT DEFAULT 'text',
    'article'   INTEGER NOT NULL,
    'url'       VARCHAR(300),
    'data'      INTEGER,
    'order'     INTEGER DEFAULT 0,

    FOREIGN KEY ('article') REFERENCES 'articles' ('id'),
    PRIMARY KEY ('id')
);
CREATE INDEX ON 'channels' ('url');
CREATE INDEX ON 'channels' ('data');