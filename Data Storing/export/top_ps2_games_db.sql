--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: normalize_email(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.normalize_email() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
new.email = LOWER(new.email);
return new;
end;
$$;


ALTER FUNCTION public.normalize_email() OWNER TO postgres;

--
-- Name: update_modified_column(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_modified_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
new.updated_at = NOW();
return new;
end;
$$;


ALTER FUNCTION public.update_modified_column() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: developers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.developers (
    developer_id integer NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE public.developers OWNER TO postgres;

--
-- Name: developers_developer_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.developers_developer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.developers_developer_id_seq OWNER TO postgres;

--
-- Name: developers_developer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.developers_developer_id_seq OWNED BY public.developers.developer_id;


--
-- Name: game_developers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.game_developers (
    game_id integer NOT NULL,
    developer_id integer NOT NULL
);


ALTER TABLE public.game_developers OWNER TO postgres;

--
-- Name: game_genres; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.game_genres (
    game_id integer NOT NULL,
    genre_id integer NOT NULL
);


ALTER TABLE public.game_genres OWNER TO postgres;

--
-- Name: game_media; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.game_media (
    critic_id integer NOT NULL,
    name character varying(100) NOT NULL,
    website character varying(255)
);


ALTER TABLE public.game_media OWNER TO postgres;

--
-- Name: game_media_critic_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.game_media_critic_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.game_media_critic_id_seq OWNER TO postgres;

--
-- Name: game_media_critic_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.game_media_critic_id_seq OWNED BY public.game_media.critic_id;


--
-- Name: game_publishers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.game_publishers (
    game_id integer NOT NULL,
    publisher_id integer NOT NULL
);


ALTER TABLE public.game_publishers OWNER TO postgres;

--
-- Name: games; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.games (
    game_id integer NOT NULL,
    release_id integer,
    title character varying(255) NOT NULL,
    initial_rank integer,
    updated_at timestamp with time zone,
    timestamp_ekstraksi timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.games OWNER TO postgres;

--
-- Name: games_game_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.games_game_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.games_game_id_seq OWNER TO postgres;

--
-- Name: games_game_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.games_game_id_seq OWNED BY public.games.game_id;


--
-- Name: genres; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.genres (
    genre_id integer NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE public.genres OWNER TO postgres;

--
-- Name: genres_genre_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.genres_genre_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.genres_genre_id_seq OWNER TO postgres;

--
-- Name: genres_genre_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.genres_genre_id_seq OWNED BY public.genres.genre_id;


--
-- Name: publishers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.publishers (
    publisher_id integer NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE public.publishers OWNER TO postgres;

--
-- Name: publishers_publisher_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.publishers_publisher_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.publishers_publisher_id_seq OWNER TO postgres;

--
-- Name: publishers_publisher_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.publishers_publisher_id_seq OWNED BY public.publishers.publisher_id;


--
-- Name: regional_releases; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.regional_releases (
    release_id integer NOT NULL,
    game_id integer NOT NULL,
    region_id integer NOT NULL,
    release_date date,
    regional_title character varying(255)
);


ALTER TABLE public.regional_releases OWNER TO postgres;

--
-- Name: regional_releases_release_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.regional_releases_release_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.regional_releases_release_id_seq OWNER TO postgres;

--
-- Name: regional_releases_release_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.regional_releases_release_id_seq OWNED BY public.regional_releases.release_id;


--
-- Name: regions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.regions (
    region_id integer NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.regions OWNER TO postgres;

--
-- Name: regions_region_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.regions_region_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.regions_region_id_seq OWNER TO postgres;

--
-- Name: regions_region_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.regions_region_id_seq OWNED BY public.regions.region_id;


--
-- Name: reviews; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reviews (
    review_id integer NOT NULL,
    game_id integer NOT NULL,
    critic_id integer NOT NULL,
    score integer,
    review_summary text,
    review_url character varying(255),
    updated_at timestamp with time zone,
    CONSTRAINT check_score_range CHECK (((score >= 0) AND (score <= 100)))
);


ALTER TABLE public.reviews OWNER TO postgres;

--
-- Name: reviews_review_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reviews_review_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.reviews_review_id_seq OWNER TO postgres;

--
-- Name: reviews_review_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reviews_review_id_seq OWNED BY public.reviews.review_id;


--
-- Name: user_game_library; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_game_library (
    user_game_id integer NOT NULL,
    user_id integer NOT NULL,
    game_id integer NOT NULL,
    status character varying(20) DEFAULT 'played'::character varying NOT NULL,
    user_rating integer,
    added_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT check_status_values CHECK (((status)::text = ANY ((ARRAY['played'::character varying, 'playing'::character varying, 'backlog'::character varying, 'wishlist'::character varying, 'dropped'::character varying])::text[]))),
    CONSTRAINT check_user_rating_range CHECK (((user_rating >= 1) AND (user_rating <= 10)))
);


ALTER TABLE public.user_game_library OWNER TO postgres;

--
-- Name: user_game_library_user_game_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_game_library_user_game_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_game_library_user_game_id_seq OWNER TO postgres;

--
-- Name: user_game_library_user_game_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_game_library_user_game_id_seq OWNED BY public.user_game_library.user_game_id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    username character varying(50) NOT NULL,
    email character varying(255) NOT NULL,
    password_hash character varying(255) NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT check_email_format CHECK (((email)::text ~~ '%@%'::text))
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_user_id_seq OWNER TO postgres;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- Name: developers developer_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.developers ALTER COLUMN developer_id SET DEFAULT nextval('public.developers_developer_id_seq'::regclass);


--
-- Name: game_media critic_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_media ALTER COLUMN critic_id SET DEFAULT nextval('public.game_media_critic_id_seq'::regclass);


--
-- Name: games game_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games ALTER COLUMN game_id SET DEFAULT nextval('public.games_game_id_seq'::regclass);


--
-- Name: genres genre_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genres ALTER COLUMN genre_id SET DEFAULT nextval('public.genres_genre_id_seq'::regclass);


--
-- Name: publishers publisher_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.publishers ALTER COLUMN publisher_id SET DEFAULT nextval('public.publishers_publisher_id_seq'::regclass);


--
-- Name: regional_releases release_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regional_releases ALTER COLUMN release_id SET DEFAULT nextval('public.regional_releases_release_id_seq'::regclass);


--
-- Name: regions region_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regions ALTER COLUMN region_id SET DEFAULT nextval('public.regions_region_id_seq'::regclass);


--
-- Name: reviews review_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews ALTER COLUMN review_id SET DEFAULT nextval('public.reviews_review_id_seq'::regclass);


--
-- Name: user_game_library user_game_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_game_library ALTER COLUMN user_game_id SET DEFAULT nextval('public.user_game_library_user_game_id_seq'::regclass);


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- Data for Name: developers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.developers (developer_id, name) FROM stdin;
\.


--
-- Data for Name: game_developers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.game_developers (game_id, developer_id) FROM stdin;
\.


--
-- Data for Name: game_genres; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.game_genres (game_id, genre_id) FROM stdin;
1	1
2	2
2	3
3	4
4	1
5	2
6	2
6	5
7	2
8	2
9	6
10	4
11	7
11	8
12	9
13	2
14	3
15	2
16	2
17	9
18	9
19	9
19	10
20	2
20	5
21	2
21	4
22	10
23	5
24	1
25	11
26	12
27	4
28	13
29	14
29	15
30	16
30	4
31	13
32	10
33	14
33	17
34	3
35	2
36	12
37	14
38	18
38	2
39	19
40	1
41	2
41	5
42	4
43	4
45	20
46	2
47	9
48	2
49	12
49	11
50	9
51	21
52	22
53	4
53	2
54	2
54	5
55	16
56	23
57	24
58	2
59	25
60	9
61	26
62	4
63	4
64	2
64	5
65	4
66	4
67	27
68	2
68	28
69	4
70	29
71	30
72	31
73	30
74	27
75	4
76	2
76	4
77	3
78	2
79	12
80	12
81	32
82	9
83	33
84	13
85	34
86	35
87	36
87	2
88	13
89	2
89	5
90	37
91	36
91	2
91	5
92	38
93	5
93	39
94	5
95	40
96	41
97	4
98	4
99	12
100	4
101	35
102	10
103	4
104	2
105	42
105	10
106	2
107	2
107	43
108	2
\.


--
-- Data for Name: game_media; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.game_media (critic_id, name, website) FROM stdin;
\.


--
-- Data for Name: game_publishers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.game_publishers (game_id, publisher_id) FROM stdin;
\.


--
-- Data for Name: games; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.games (game_id, release_id, title, initial_rank, updated_at, timestamp_ekstraksi) FROM stdin;
1	\N	Grand Theft Auto: San Andreas	1	\N	2025-08-08 14:16:49.689717+07
2	\N	Resident Evil 4	2	\N	2025-08-08 14:16:49.689717+07
3	\N	Final Fantasy X	3	\N	2025-08-08 14:16:49.689717+07
4	\N	Bully	4	\N	2025-08-08 14:16:49.689717+07
5	\N	God of War II	5	\N	2025-08-08 14:16:49.689717+07
6	\N	Shadow of Colossus	6	\N	2025-08-08 14:16:49.689717+07
7	\N	Metal Gear Solid 3: Snake Eater	7	\N	2025-08-08 14:16:49.689717+07
8	\N	Devil May Cry 3: Special Edition	8	\N	2025-08-08 14:16:49.689717+07
9	\N	Okami	9	\N	2025-08-08 14:16:49.689717+07
10	\N	Kingdom Hearts	10	\N	2025-08-08 14:16:49.689717+07
11	\N	Ace Combat 4: Shattered Skies	11	\N	2025-08-08 14:16:49.689717+07
12	\N	WWE: Smackdown! Here Comes The Pain	12	\N	2025-08-08 14:16:49.689717+07
13	\N	Jack and Dexter: Precursor Legacy	13	\N	2025-08-08 14:16:49.689717+07
14	\N	Silent Hill 2	14	\N	2025-08-08 14:16:49.689717+07
15	\N	Devil May Cry	15	\N	2025-08-08 14:16:49.689717+07
17	\N	Tony Hawk: Underground	17	\N	2025-08-08 14:16:49.689717+07
18	\N	Need For Speed Most Wanted	18	\N	2025-08-08 14:16:49.689717+07
19	\N	Need For Speed Underground 2	19	\N	2025-08-08 14:16:49.689717+07
20	\N	Rachet and Clank 3	20	\N	2025-08-08 14:16:49.689717+07
21	\N	Kingdom Hearts 2	21	\N	2025-08-08 14:16:49.689717+07
22	\N	Burnout 3: Takedown	22	\N	2025-08-08 14:16:49.689717+07
23	\N	ICO	23	\N	2025-08-08 14:16:49.689717+07
25	\N	Starwars Battlefront II	25	\N	2025-08-08 14:16:49.689717+07
24	\N	Grand Theft Auto: Vice City	24	\N	2025-08-08 14:16:49.689717+07
26	\N	Medal of Honor: Frontliner	26	\N	2025-08-08 14:16:49.689717+07
27	\N	Suikoden III	27	\N	2025-08-08 14:16:49.689717+07
28	\N	Tekken Tag Tournament	28	\N	2025-08-08 14:16:49.689717+07
29	\N	Winning Eleven Berpangkat	29	\N	2025-08-08 14:16:49.689717+07
30	\N	Disgaea: Hour of Darkness	30	\N	2025-08-08 14:16:49.689717+07
31	\N	Def Jam: Fight of NY	31	\N	2025-08-08 14:16:49.689717+07
32	\N	Gran Turismo 3: A-Spec	32	\N	2025-08-08 14:16:49.689717+07
33	\N	Tony Hawk Underground 2	33	\N	2025-08-08 14:16:49.689717+07
34	\N	Fatal Frame II:	34	\N	2025-08-08 14:16:49.689717+07
35	\N	God Hand	35	\N	2025-08-08 14:16:49.689717+07
36	\N	Black	36	\N	2025-08-08 14:16:49.689717+07
37	\N	NBA Street Vol.2	37	\N	2025-08-08 14:16:49.689717+07
38	\N	Tenchu: Wrath of Heaven	38	\N	2025-08-08 14:16:49.689717+07
39	\N	Twisted Metal: Black	39	\N	2025-08-08 14:16:49.689717+07
40	\N	GTA III	40	\N	2025-08-08 14:16:49.689717+07
41	\N	The Lord of The Rings: The Return of the King	41	\N	2025-08-08 14:16:49.689717+07
42	\N	Xenosaga Episode I: Der Wille zur Macth	42	\N	2025-08-08 14:16:49.689717+07
43	\N	Klonoa 2: Lunatea’s vell	43	\N	2025-08-08 14:16:49.689717+07
16	\N	Metal Gear Solid 2: Sons of Liberty	44	\N	2025-08-08 14:16:49.689717+07
45	\N	Fatal Frame	45	\N	2025-08-08 14:16:49.689717+07
46	\N	Prince of Persia: The Sands of Time	46	\N	2025-08-08 14:16:49.689717+07
47	\N	NBA Street V3	47	\N	2025-08-08 14:16:49.689717+07
48	\N	The Warriors	48	\N	2025-08-08 14:16:49.689717+07
49	\N	Call of Duty 3	49	\N	2025-08-08 14:16:49.689717+07
50	\N	SSX Tricky	50	\N	2025-08-08 14:16:49.689717+07
51	\N	Time Splitter	51	\N	2025-08-08 14:16:49.689717+07
52	\N	Tom Clancy’s Splinter Cell Pandora Tomorrow	52	\N	2025-08-08 14:16:49.689717+07
53	\N	Dark Cloud 2	53	\N	2025-08-08 14:16:49.689717+07
54	\N	Onimusha 2: Samurai’s destiny	54	\N	2025-08-08 14:16:49.689717+07
55	\N	Dynasty Tactics	55	\N	2025-08-08 14:16:49.689717+07
56	\N	Ace Combat 5: The Unsung War	56	\N	2025-08-08 14:16:49.689717+07
107	\N	Driv3r	107	\N	2025-08-08 14:16:49.689717+07
57	\N	Resident Evil: Code Veronica	57	\N	2025-08-08 14:16:49.689717+07
58	\N	The Lord of The Ring: The Two Towers	58	\N	2025-08-08 14:16:49.689717+07
59	\N	Hitman 2: Silent Assasin	59	\N	2025-08-08 14:16:49.689717+07
60	\N	Tony Hawk Pro Skater 4	60	\N	2025-08-08 14:16:49.689717+07
61	\N	Crazy Taxi	61	\N	2025-08-08 14:16:49.689717+07
62	\N	Mana Khemia 2: Fall of Alchemy	62	\N	2025-08-08 14:16:49.689717+07
63	\N	Mana Khemia: Alchemist of Al-Revis	63	\N	2025-08-08 14:16:49.689717+07
64	\N	Escape from Monkey Island	64	\N	2025-08-08 14:16:49.689717+07
65	\N	Kingdom Heart Re:Chain Memories	65	\N	2025-08-08 14:16:49.689717+07
66	\N	Shin Megami Tensei: Persona 4	66	\N	2025-08-08 14:16:49.689717+07
67	\N	Naruto Ultimate Ninja 3	67	\N	2025-08-08 14:16:49.689717+07
68	\N	Yakuza 2	68	\N	2025-08-08 14:16:49.689717+07
69	\N	Dragon Quest VIII: Journey of The Cursed King	69	\N	2025-08-08 14:16:49.689717+07
70	\N	The Sims Castaway	70	\N	2025-08-08 14:16:49.689717+07
71	\N	Warriors Orochi 2	71	\N	2025-08-08 14:16:49.689717+07
72	\N	Guitar Hero III: Legends of Rock	72	\N	2025-08-08 14:16:49.689717+07
73	\N	Dynasty Warriors 4	73	\N	2025-08-08 14:16:49.689717+07
74	\N	Dragon Ball Z: Budokai Tenkaichi	74	\N	2025-08-08 14:16:49.689717+07
75	\N	Tales of Abyss	75	\N	2025-08-08 14:16:49.689717+07
76	\N	Final Fantas XII	76	\N	2025-08-08 14:16:49.689717+07
77	\N	Fatal Frame 3	77	\N	2025-08-08 14:16:49.689717+07
78	\N	Onimusha Warlord	78	\N	2025-08-08 14:16:49.689717+07
79	\N	Max Payne	79	\N	2025-08-08 14:16:49.689717+07
80	\N	Socom III: U.S Navy Seal	80	\N	2025-08-08 14:16:49.689717+07
81	\N	The Sims Bustin’ Out	81	\N	2025-08-08 14:16:49.689717+07
82	\N	Tony Hawk: American Wasteland	82	\N	2025-08-08 14:16:49.689717+07
83	\N	Fight Night: Round 2	83	\N	2025-08-08 14:16:49.689717+07
84	\N	Mortal Combat: Shaolin Monks	84	\N	2025-08-08 14:16:49.689717+07
85	\N	Prince of Persia: The Two Thrones	85	\N	2025-08-08 14:16:49.689717+07
86	\N	Tekken 5	86	\N	2025-08-08 14:16:49.689717+07
87	\N	Armored Core 2	87	\N	2025-08-08 14:16:49.689717+07
88	\N	Dead or Alive 2: Hardcore	88	\N	2025-08-08 14:16:49.689717+07
89	\N	Soul Reaver 2	89	\N	2025-08-08 14:16:49.689717+07
90	\N	Theme Park Roller Coaster	90	\N	2025-08-08 14:16:49.689717+07
91	\N	Destroy All Humas!	91	\N	2025-08-08 14:16:49.689717+07
92	\N	Katamari Damacy	92	\N	2025-08-08 14:16:49.689717+07
93	\N	Ape Escape II	93	\N	2025-08-08 14:16:49.689717+07
94	\N	Rayman 2 Revolution	94	\N	2025-08-08 14:16:49.689717+07
95	\N	Kessen II:	95	\N	2025-08-08 14:16:49.689717+07
96	\N	Harvest Moon: Save The Homeland	96	\N	2025-08-08 14:16:49.689717+07
97	\N	Final Fantasy X-2	97	\N	2025-08-08 14:16:49.689717+07
98	\N	Dark Cloud	98	\N	2025-08-08 14:16:49.689717+07
99	\N	Time Crisis II	99	\N	2025-08-08 14:16:49.689717+07
100	\N	Shadow Hearts	100	\N	2025-08-08 14:16:49.689717+07
101	\N	Soul Calibur 3	101	\N	2025-08-08 14:16:49.689717+07
102	\N	Midnght Club 3 Dub Edition	102	\N	2025-08-08 14:16:49.689717+07
103	\N	Shin Megami Tensei: Persona 3	103	\N	2025-08-08 14:16:49.689717+07
104	\N	Jet Li: Rise of Honor	104	\N	2025-08-08 14:16:49.689717+07
105	\N	Downhill	105	\N	2025-08-08 14:16:49.689717+07
106	\N	Genji: Dawn of The Samurai	106	\N	2025-08-08 14:16:49.689717+07
108	\N	Enter The Matrix	108	\N	2025-08-08 14:16:49.689717+07
\.


--
-- Data for Name: genres; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.genres (genre_id, name) FROM stdin;
1	Open World
2	Action
3	Horror
4	RPG
5	Adventure
6	Action RPG
7	Flight
8	Dogfight
9	Extreme Sport
10	Racing
11	War
12	Shooter
13	Fighting
14	Sport
15	Football
16	Tactic
17	Skateboard
18	Ninja
19	Car Combat
20	Horor
21	FPS
22	Stealth
23	Flight War
24	Zombie
25	Action Stleath
26	Arcade
27	Fight
28	Semi-Open World
29	Survival simulation
30	Musou
31	Rythim Game
32	Life Simulation
33	Boxing
34	Action Adventure
35	Figthing
36	Sci-Fi
37	Tycoon
38	Puzzle
39	Casual
40	Strategi
41	Life Simulator
42	Xtreme Sport
43	Driving
\.


--
-- Data for Name: publishers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.publishers (publisher_id, name) FROM stdin;
\.


--
-- Data for Name: regional_releases; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.regional_releases (release_id, game_id, region_id, release_date, regional_title) FROM stdin;
\.


--
-- Data for Name: regions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.regions (region_id, name) FROM stdin;
\.


--
-- Data for Name: reviews; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reviews (review_id, game_id, critic_id, score, review_summary, review_url, updated_at) FROM stdin;
\.


--
-- Data for Name: user_game_library; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_game_library (user_game_id, user_id, game_id, status, user_rating, added_at) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (user_id, username, email, password_hash, created_at) FROM stdin;
\.


--
-- Name: developers_developer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.developers_developer_id_seq', 1, false);


--
-- Name: game_media_critic_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.game_media_critic_id_seq', 1, false);


--
-- Name: games_game_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.games_game_id_seq', 1728, true);


--
-- Name: genres_genre_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.genres_genre_id_seq', 43, true);


--
-- Name: publishers_publisher_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.publishers_publisher_id_seq', 1, false);


--
-- Name: regional_releases_release_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.regional_releases_release_id_seq', 1, false);


--
-- Name: regions_region_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.regions_region_id_seq', 1, false);


--
-- Name: reviews_review_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.reviews_review_id_seq', 1, false);


--
-- Name: user_game_library_user_game_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_game_library_user_game_id_seq', 1, false);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_user_id_seq', 1, false);


--
-- Name: developers developers_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.developers
    ADD CONSTRAINT developers_name_key UNIQUE (name);


--
-- Name: developers developers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.developers
    ADD CONSTRAINT developers_pkey PRIMARY KEY (developer_id);


--
-- Name: game_developers game_developers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_developers
    ADD CONSTRAINT game_developers_pkey PRIMARY KEY (game_id, developer_id);


--
-- Name: game_genres game_genres_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_genres
    ADD CONSTRAINT game_genres_pkey PRIMARY KEY (game_id, genre_id);


--
-- Name: game_media game_media_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_media
    ADD CONSTRAINT game_media_name_key UNIQUE (name);


--
-- Name: game_media game_media_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_media
    ADD CONSTRAINT game_media_pkey PRIMARY KEY (critic_id);


--
-- Name: game_publishers game_publishers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_publishers
    ADD CONSTRAINT game_publishers_pkey PRIMARY KEY (game_id, publisher_id);


--
-- Name: games games_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_pkey PRIMARY KEY (game_id);


--
-- Name: games games_title_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_title_key UNIQUE (title);


--
-- Name: genres genres_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genres
    ADD CONSTRAINT genres_name_key UNIQUE (name);


--
-- Name: genres genres_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genres
    ADD CONSTRAINT genres_pkey PRIMARY KEY (genre_id);


--
-- Name: publishers publishers_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.publishers
    ADD CONSTRAINT publishers_name_key UNIQUE (name);


--
-- Name: publishers publishers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.publishers
    ADD CONSTRAINT publishers_pkey PRIMARY KEY (publisher_id);


--
-- Name: regional_releases regional_releases_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regional_releases
    ADD CONSTRAINT regional_releases_pkey PRIMARY KEY (release_id);


--
-- Name: regions regions_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regions
    ADD CONSTRAINT regions_name_key UNIQUE (name);


--
-- Name: regions regions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regions
    ADD CONSTRAINT regions_pkey PRIMARY KEY (region_id);


--
-- Name: reviews reviews_game_id_critic_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_game_id_critic_id_key UNIQUE (game_id, critic_id);


--
-- Name: reviews reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_pkey PRIMARY KEY (review_id);


--
-- Name: user_game_library user_game_library_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_game_library
    ADD CONSTRAINT user_game_library_pkey PRIMARY KEY (user_game_id);


--
-- Name: user_game_library user_game_library_user_id_game_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_game_library
    ADD CONSTRAINT user_game_library_user_id_game_id_key UNIQUE (user_id, game_id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: idx_game_developers_developer_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_game_developers_developer_id ON public.game_developers USING btree (developer_id);


--
-- Name: idx_game_genres_game_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_game_genres_game_id ON public.game_genres USING btree (genre_id);


--
-- Name: idx_game_publishers_publisher_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_game_publishers_publisher_id ON public.game_publishers USING btree (publisher_id);


--
-- Name: idx_regional_releases_game_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_regional_releases_game_id ON public.regional_releases USING btree (game_id);


--
-- Name: idx_reviews_game_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_reviews_game_id ON public.reviews USING btree (game_id);


--
-- Name: idx_user_game_library_game_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_game_library_game_id ON public.user_game_library USING btree (game_id);


--
-- Name: idx_user_game_library_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_game_library_user_id ON public.user_game_library USING btree (user_id);


--
-- Name: users trigger_normalize_user_email; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trigger_normalize_user_email BEFORE INSERT OR UPDATE ON public.users FOR EACH ROW EXECUTE FUNCTION public.normalize_email();


--
-- Name: game_developers game_developers_developer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_developers
    ADD CONSTRAINT game_developers_developer_id_fkey FOREIGN KEY (developer_id) REFERENCES public.developers(developer_id) ON DELETE CASCADE;


--
-- Name: game_developers game_developers_game_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_developers
    ADD CONSTRAINT game_developers_game_id_fkey FOREIGN KEY (game_id) REFERENCES public.games(game_id) ON DELETE CASCADE;


--
-- Name: game_genres game_genres_game_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_genres
    ADD CONSTRAINT game_genres_game_id_fkey FOREIGN KEY (game_id) REFERENCES public.games(game_id) ON DELETE CASCADE;


--
-- Name: game_genres game_genres_genre_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_genres
    ADD CONSTRAINT game_genres_genre_id_fkey FOREIGN KEY (genre_id) REFERENCES public.genres(genre_id) ON DELETE CASCADE;


--
-- Name: game_publishers game_publishers_game_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_publishers
    ADD CONSTRAINT game_publishers_game_id_fkey FOREIGN KEY (game_id) REFERENCES public.games(game_id) ON DELETE CASCADE;


--
-- Name: game_publishers game_publishers_publisher_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_publishers
    ADD CONSTRAINT game_publishers_publisher_id_fkey FOREIGN KEY (publisher_id) REFERENCES public.publishers(publisher_id) ON DELETE CASCADE;


--
-- Name: regional_releases regional_releases_game_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regional_releases
    ADD CONSTRAINT regional_releases_game_id_fkey FOREIGN KEY (game_id) REFERENCES public.games(game_id) ON DELETE CASCADE;


--
-- Name: regional_releases regional_releases_region_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regional_releases
    ADD CONSTRAINT regional_releases_region_id_fkey FOREIGN KEY (region_id) REFERENCES public.regions(region_id) ON DELETE CASCADE;


--
-- Name: reviews reviews_critic_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_critic_id_fkey FOREIGN KEY (critic_id) REFERENCES public.game_media(critic_id) ON DELETE CASCADE;


--
-- Name: reviews reviews_game_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_game_id_fkey FOREIGN KEY (game_id) REFERENCES public.games(game_id) ON DELETE CASCADE;


--
-- Name: user_game_library user_game_library_game_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_game_library
    ADD CONSTRAINT user_game_library_game_id_fkey FOREIGN KEY (game_id) REFERENCES public.games(game_id) ON DELETE CASCADE;


--
-- Name: user_game_library user_game_library_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_game_library
    ADD CONSTRAINT user_game_library_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

