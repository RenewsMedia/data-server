CREATE TABLE IF NOT EXISTS "contents" (
  "id"      SERIAL NOT NULL,
  "type"    ARTICLE_CONTENT DEFAULT 'text',
  "article" INTEGER,
  "url"     VARCHAR(300),
  "data"    INTEGER,
  "order"   INTEGER DEFAULT 0,

  FOREIGN KEY ("article") REFERENCES "articles" ("id") ON DELETE CASCADE,
  FOREIGN KEY ("data")    REFERENCES "text_data" ("id") ON DELETE CASCADE,

  PRIMARY KEY ("id")
);
CREATE INDEX ON "channels" (lower('url'));