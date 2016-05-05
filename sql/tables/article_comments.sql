CREATE TABLE IF NOT EXISTS "article_comments" (
  "article" INTEGER,
  "comment" INTEGER,

  FOREIGN KEY ("article") REFERENCES "articles" ("id") ON DELETE CASCADE,
  FOREIGN KEY ("comment") REFERENCES "comments" ("id") ON DELETE CASCADE,

  PRIMARY KEY ("article", "comment")
);