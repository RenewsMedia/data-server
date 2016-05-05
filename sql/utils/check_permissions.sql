CREATE OR REPLACE FUNCTION check_permissions (
  channel INTEGER,
  user_id INTEGER,
  code    TEXT
) RETURNS BOOLEAN LANGUAGE plpgsql SECURITY DEFINER AS $$
  DECLARE
      access_codes RECORD;
  BEGIN
      SELECT "roles"."access"
      INTO access_codes
      FROM "roles"
      WHERE "roles"."code" = (
        SELECT "role"
        FROM "channel_roles"
        WHERE "channel_roles"."channel" = $1 AND
              "channel_roles"."user" = $2
      );

      IF FOUND THEN
        RETURN (access_codes."access" @> ARRAY['ALL']::VARCHAR[]) OR (access_codes."access" @> ARRAY[$3]::VARCHAR[]);
      END IF;

      RETURN FALSE;
  END;
$$;