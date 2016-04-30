CREATE OR REPLACE FUNCTION check_permissions (
  channel INTEGER,
  user_id INTEGER,
  code    TEXT
) RETURNS BOOLEAN LANGUAGE plpgsql SECURITY DEFINER AS $$
  DECLARE
      access_codes VARCHAR[];
      result BOOLEAN DEFAULT FALSE;
  BEGIN
      SELECT INTO access_codes "roles"."access"
      FROM "roles"
      WHERE "roles"."code" = (
        SELECT "role"
        FROM "channel_roles"
        WHERE "channel_roles"."channel" = $1 AND
              "channel_roles"."user" = $2
      );

      IF FOUND THEN
        result := (access_codes @> ARRAY['ALL']) OR (access_codes @> ARRAY[$3]);
      END IF;

      RETURN result;
  END;
$$;