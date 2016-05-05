CREATE TABLE IF NOT EXISTS "articles" (
  "id"        SERIAL NOT NULL,
  "channel"   INTEGER,
  "author"    INTEGER,
  "title"     VARCHAR(150),
  "created"   TIMESTAMP DEFAULT (now() at time zone 'utc'),
  "published" TIMESTAMP DEFAULT (now() at time zone 'utc'),
  "hidden"    BOOLEAN DEFAULT FALSE,

  FOREIGN KEY ("channel") REFERENCES "channels" ("id") ON DELETE CASCADE,
  FOREIGN KEY ("author")  REFERENCES "users" ("id") ON DELETE CASCADE,

  PRIMARY KEY ("id")
);
CREATE INDEX ON "articles" (lower('title'));