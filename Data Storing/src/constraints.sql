-- FUNCTIONS
CREATE FUNCTION public.normalize_email() RETURNS trigger
    LANGUAGE plpgsql
    AS $
begin
new.email = LOWER(new.email);
return new;
end;
$;

CREATE FUNCTION public.update_modified_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $
begin
new.updated_at = NOW();
return new;
end;
$;

-- CONSTRAINTS
ALTER TABLE ONLY public.developers
    ADD CONSTRAINT developers_name_key UNIQUE (name);

ALTER TABLE ONLY public.developers
    ADD CONSTRAINT developers_pkey PRIMARY KEY (developer_id);

ALTER TABLE ONLY public.game_developers
    ADD CONSTRAINT game_developers_pkey PRIMARY KEY (game_id, developer_id);

ALTER TABLE ONLY public.game_genres
    ADD CONSTRAINT game_genres_pkey PRIMARY KEY (game_id, genre_id);

ALTER TABLE ONLY public.game_media
    ADD CONSTRAINT game_media_name_key UNIQUE (name);

ALTER TABLE ONLY public.game_media
    ADD CONSTRAINT game_media_pkey PRIMARY KEY (critic_id);

ALTER TABLE ONLY public.game_publishers
    ADD CONSTRAINT game_publishers_pkey PRIMARY KEY (game_id, publisher_id);

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_pkey PRIMARY KEY (game_id);

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_title_key UNIQUE (title);

ALTER TABLE ONLY public.genres
    ADD CONSTRAINT genres_name_key UNIQUE (name);

ALTER TABLE ONLY public.genres
    ADD CONSTRAINT genres_pkey PRIMARY KEY (genre_id);

ALTER TABLE ONLY public.publishers
    ADD CONSTRAINT publishers_name_key UNIQUE (name);

ALTER TABLE ONLY public.publishers
    ADD CONSTRAINT publishers_pkey PRIMARY KEY (publisher_id);

ALTER TABLE ONLY public.regional_releases
    ADD CONSTRAINT regional_releases_pkey PRIMARY KEY (release_id);

ALTER TABLE ONLY public.regions
    ADD CONSTRAINT regions_name_key UNIQUE (name);

ALTER TABLE ONLY public.regions
    ADD CONSTRAINT regions_pkey PRIMARY KEY (region_id);

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_game_id_critic_id_key UNIQUE (game_id, critic_id);

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_pkey PRIMARY KEY (review_id);

ALTER TABLE ONLY public.user_game_library
    ADD CONSTRAINT user_game_library_pkey PRIMARY KEY (user_game_id);

ALTER TABLE ONLY public.user_game_library
    ADD CONSTRAINT user_game_library_user_id_game_id_key UNIQUE (user_id, game_id);

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);

-- CHECK CONSTRAINTS
ALTER TABLE public.reviews 
    ADD CONSTRAINT check_score_range CHECK (((score >= 0) AND (score <= 100)));

ALTER TABLE public.user_game_library
    ADD CONSTRAINT check_status_values CHECK (((status)::text = ANY ((ARRAY['played'::character varying, 'playing'::character varying, 'backlog'::character varying, 'wishlist'::character varying, 'dropped'::character varying])::text[])));

ALTER TABLE public.user_game_library
    ADD CONSTRAINT check_user_rating_range CHECK (((user_rating >= 1) AND (user_rating <= 10)));

ALTER TABLE public.users
    ADD CONSTRAINT check_email_format CHECK (((email)::text ~~ '%@%'::text));

-- INDEXES
CREATE INDEX idx_game_developers_developer_id ON public.game_developers USING btree (developer_id);
CREATE INDEX idx_game_genres_game_id ON public.game_genres USING btree (genre_id);
CREATE INDEX idx_game_publishers_publisher_id ON public.game_publishers USING btree (publisher_id);
CREATE INDEX idx_regional_releases_game_id ON public.regional_releases USING btree (game_id);
CREATE INDEX idx_reviews_game_id ON public.reviews USING btree (game_id);
CREATE INDEX idx_user_game_library_game_id ON public.user_game_library USING btree (game_id);
CREATE INDEX idx_user_game_library_user_id ON public.user_game_library USING btree (user_id);

-- TRIGGERS
CREATE TRIGGER trigger_normalize_user_email BEFORE INSERT OR UPDATE ON public.users FOR EACH ROW EXECUTE FUNCTION public.normalize_email();
CREATE TRIGGER trigger_update_games_modtime BEFORE UPDATE ON public.games FOR EACH ROW EXECUTE FUNCTION public.update_modified_column();

-- FOREIGN KEYS
ALTER TABLE ONLY public.game_developers
    ADD CONSTRAINT game_developers_developer_id_fkey FOREIGN KEY (developer_id) REFERENCES public.developers(developer_id) ON DELETE CASCADE;

ALTER TABLE ONLY public.game_developers
    ADD CONSTRAINT game_developers_game_id_fkey FOREIGN KEY (game_id) REFERENCES public.games(game_id) ON DELETE CASCADE;

ALTER TABLE ONLY public.game_genres
    ADD CONSTRAINT game_genres_game_id_fkey FOREIGN KEY (game_id) REFERENCES public.games(game_id) ON DELETE CASCADE;

ALTER TABLE ONLY public.game_genres
    ADD CONSTRAINT game_genres_genre_id_fkey FOREIGN KEY (genre_id) REFERENCES public.genres(genre_id) ON DELETE CASCADE;

ALTER TABLE ONLY public.game_publishers
    ADD CONSTRAINT game_publishers_game_id_fkey FOREIGN KEY (game_id) REFERENCES public.games(game_id) ON DELETE CASCADE;

ALTER TABLE ONLY public.game_publishers
    ADD CONSTRAINT game_publishers_publisher_id_fkey FOREIGN KEY (publisher_id) REFERENCES public.publishers(publisher_id) ON DELETE CASCADE;

ALTER TABLE ONLY public.regional_releases
    ADD CONSTRAINT regional_releases_game_id_fkey FOREIGN KEY (game_id) REFERENCES public.games(game_id) ON DELETE CASCADE;

ALTER TABLE ONLY public.regional_releases
    ADD CONSTRAINT regional_releases_region_id_fkey FOREIGN KEY (region_id) REFERENCES public.regions(region_id) ON DELETE CASCADE;

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_critic_id_fkey FOREIGN KEY (critic_id) REFERENCES public.game_media(critic_id) ON DELETE CASCADE;

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_game_id_fkey FOREIGN KEY (game_id) REFERENCES public.games(game_id) ON DELETE CASCADE;

ALTER TABLE ONLY public.user_game_library
    ADD CONSTRAINT user_game_library_game_id_fkey FOREIGN KEY (game_id) REFERENCES public.games(game_id) ON DELETE CASCADE;

ALTER TABLE ONLY public.user_game_library
    ADD CONSTRAINT user_game_library_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;
