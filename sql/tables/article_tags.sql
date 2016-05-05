CREATE TABLE IF NOT EXISTS "article_tags" (
  "article" INTEGER,
  "tag"     VARCHAR,

  FOREIGN KEY ("article") REFERENCES "articles" ("id") ON DELETE CASCADE,
  FOREIGN KEY ("tag")     REFERENCES "tags" ("id") ON DELETE CASCADE,

  PRIMARY KEY ("article", "tag")
);
CREATE INDEX ON "article_tags" ("article");