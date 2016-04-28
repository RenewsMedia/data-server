CREATE TABLE IF NOT EXISTS 'contents' (
    'id' SERIAL NOT NULL,
    'type' ARTICLE_CONTENT DEFAULT 'text',
    'url' VARCHAR(300),
    'content' VARCHAR(5000)

    PRIMARY KEY ('id')
);