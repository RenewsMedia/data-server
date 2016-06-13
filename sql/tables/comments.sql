CREATE TABLE IF NOT EXISTS "comments" (
  "id"        SERIAL NOT NULL,
  "ref_id"    INTEGER,
  "author"    INTEGER,
  "data"      INTEGER,
  "published" TIMESTAMP DEFAULT (now() at time zone 'utc'),

  FOREIGN KEY ("ref_id") REFERENCES "comments" ("id") ON DELETE CASCADE,
  FOREIGN KEY ("author") REFERENCES "users" ("id"),
  FOREIGN KEY ("data")   REFERENCES "text_data" ("id") ON DELETE CASCADE,

  PRIMARY KEY ("id")
);