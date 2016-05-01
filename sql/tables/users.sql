CREATE TABLE IF NOT EXISTS "users" (
  "id"       SERIAL NOT NULL,
  "login"    VARCHAR(30) NOT NULL UNIQUE,
  "password" VARCHAR(32) NOT NULL,
  "mail"     VARCHAR(100) NOT NULL,
  "verified" BOOLEAN DEFAULT FALSE,
  "name"     VARCHAR(20),
  "surname"  VARCHAR(20),
  "country"  VARCHAR(2),
  "date_reg" TIMESTAMP DEFAULT (now() at time zone 'utc'),

  FOREIGN KEY ("country") REFERENCES "countries" ("code"),

  PRIMARY KEY ("id")
);
CREATE INDEX ON "users" (lower('login'));
CREATE INDEX ON "users" (lower('mail'));
CREATE INDEX ON "users" (lower('name'), lower('surname'));