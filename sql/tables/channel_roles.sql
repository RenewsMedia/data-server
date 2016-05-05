CREATE TABLE IF NOT EXISTS "channel_roles" (
  "role"    VARCHAR(3),
  "channel" INTEGER,
  "user"    INTEGER,

  FOREIGN KEY ("role")    REFERENCES "roles" ("code") ON DELETE CASCADE,
  FOREIGN KEY ("channel") REFERENCES "channels" ("id") ON DELETE CASCADE,
  FOREIGN KEY ("user")    REFERENCES "users" ("id") ON DELETE CASCADE,

  PRIMARY KEY ("channel", "user")
);