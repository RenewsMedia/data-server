CREATE TABLE IF NOT EXISTS "article_comments" (
  "article" INTEGER,
  "comment" INTEGER,

  FOREIGN KEY ("article") REFERENCES "articles" ("id"),
  FOREIGN KEY ("comment") REFERENCES "comments" ("id"),

  PRIMARY KEY ("article", "comment")
);