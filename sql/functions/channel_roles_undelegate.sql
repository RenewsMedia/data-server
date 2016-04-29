CREATE FUNCTION 'f_main'.'channel_roles_undelegate' (
    channel INTEGER,
    user_id INTEGER
) RETURNS BOOLEAN LANGUAGE plpgsql SECURITY DEFINER AS $$
    BEGIN
        DELETE
          FROM 'channel_roles'
         WHERE 'channel'    = channel,
               'user'       = user_id;

        RETURN FOUND;
    END;
$$;