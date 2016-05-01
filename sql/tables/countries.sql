CREATE TABLE IF NOT EXISTS "countries" (
  "code"       VARCHAR(2) NOT NULL,
  "name"       VARCHAR(40) NOT NULL,
  "phone_code" VARCHAR(17) NOT NULL,

  PRIMARY KEY ("code")
);