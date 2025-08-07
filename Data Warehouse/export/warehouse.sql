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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: dimgame; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dimgame (
    game_key integer NOT NULL,
    title character varying(255) NOT NULL
);


ALTER TABLE public.dimgame OWNER TO postgres;

--
-- Name: dimgame_game_key_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dimgame_game_key_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dimgame_game_key_seq OWNER TO postgres;

--
-- Name: dimgame_game_key_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dimgame_game_key_seq OWNED BY public.dimgame.game_key;


--
-- Name: dimgenre; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dimgenre (
    genre_key integer NOT NULL,
    genre_name character varying(100) NOT NULL
);


ALTER TABLE public.dimgenre OWNER TO postgres;

--
-- Name: dimgenre_genre_key_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dimgenre_genre_key_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dimgenre_genre_key_seq OWNER TO postgres;

--
-- Name: dimgenre_genre_key_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dimgenre_genre_key_seq OWNED BY public.dimgenre.genre_key;


--
-- Name: factgamerank; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.factgamerank (
    game_key integer NOT NULL,
    genre_key integer NOT NULL,
    rank integer
);


ALTER TABLE public.factgamerank OWNER TO postgres;

--
-- Name: dimgame game_key; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dimgame ALTER COLUMN game_key SET DEFAULT nextval('public.dimgame_game_key_seq'::regclass);


--
-- Name: dimgenre genre_key; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dimgenre ALTER COLUMN genre_key SET DEFAULT nextval('public.dimgenre_genre_key_seq'::regclass);


--
-- Data for Name: dimgame; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dimgame (game_key, title) FROM stdin;
1	Tony Hawk Underground 2
2	Grand Theft Auto: San Andreas
3	Final Fantas XII
4	Genji: Dawn of The Samurai
5	Jet Li: Rise of Honor
6	God of War II
7	Need For Speed Most Wanted
8	Escape from Monkey Island
9	Dynasty Tactics
10	Suikoden III
11	ICO
12	Ace Combat 5: The Unsung War
13	Destroy All Humas!
14	The Lord of The Ring: The Two Towers
15	Devil May Cry 3: Special Edition
16	Armored Core 2
17	Dragon Ball Z: Budokai Tenkaichi
18	Onimusha 2: Samurai’s destiny
19	Winning Eleven Berpangkat
20	Warriors Orochi 2
21	Yakuza 2
22	Bully
23	Fatal Frame II:
24	Time Splitter
25	Harvest Moon: Save The Homeland
26	Socom III: U.S Navy Seal
27	The Sims Castaway
28	Tom Clancy’s Splinter Cell Pandora Tomorrow
29	Fight Night: Round 2
30	Naruto Ultimate Ninja 3
31	Mana Khemia: Alchemist of Al-Revis
32	Theme Park Roller Coaster
33	Kingdom Hearts
34	Downhill
35	God Hand
36	Fatal Frame
37	Driv3r
38	Shadow of Colossus
39	Tekken 5
40	Mortal Combat: Shaolin Monks
41	Twisted Metal: Black
42	Katamari Damacy
43	Soul Calibur 3
44	Ape Escape II
45	Soul Reaver 2
46	Dragon Quest VIII: Journey of The Cursed King
47	Black
48	Def Jam: Fight of NY
49	SSX Tricky
50	Midnght Club 3 Dub Edition
51	Tony Hawk Pro Skater 4
52	Final Fantasy X-2
53	Silent Hill 2
54	Shin Megami Tensei: Persona 4
55	Enter The Matrix
56	Burnout 3: Takedown
57	Hitman 2: Silent Assasin
58	Jack and Dexter: Precursor Legacy
59	Kingdom Heart Re:Chain Memories
60	Resident Evil 4
61	Metal Gear Solid 2: Sons of Liberty
62	Mana Khemia 2: Fall of Alchemy
63	Tales of Abyss
64	Dark Cloud
65	Dynasty Warriors 4
66	Shin Megami Tensei: Persona 3
67	Ace Combat 4: Shattered Skies
68	Time Crisis II
69	Xenosaga Episode I: Der Wille zur Macth
70	Dead or Alive 2: Hardcore
71	Tony Hawk: American Wasteland
72	The Lord of The Rings: The Return of the King
73	Prince of Persia: The Sands of Time
74	GTA III
75	Klonoa 2: Lunatea’s vell
76	Dark Cloud 2
77	Gran Turismo 3: A-Spec
78	Okami
79	Metal Gear Solid 3: Snake Eater
80	Shadow Hearts
81	Tenchu: Wrath of Heaven
82	Devil May Cry
83	Max Payne
84	The Warriors
85	Medal of Honor: Frontliner
86	WWE: Smackdown! Here Comes The Pain
87	Prince of Persia: The Two Thrones
88	Guitar Hero III: Legends of Rock
89	Kessen II:
90	Onimusha Warlord
91	Resident Evil: Code Veronica
92	Grand Theft Auto: Vice City
93	The Sims Bustin’ Out
94	Crazy Taxi
95	Need For Speed Underground 2
96	Fatal Frame 3
97	Starwars Battlefront II
98	Rayman 2 Revolution
99	Disgaea: Hour of Darkness
100	Kingdom Hearts 2
101	Call of Duty 3
102	NBA Street V3
103	Final Fantasy X
104	Tony Hawk: Underground
105	NBA Street Vol.2
106	Tekken Tag Tournament
107	Rachet and Clank 3
\.


--
-- Data for Name: dimgenre; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dimgenre (genre_key, genre_name) FROM stdin;
1	Action
2	Action Adventure
3	Action RPG
4	Action Stleath
5	Adventure
6	Arcade
7	Boxing
8	Car Combat
9	Casual
10	Dogfight
11	Driving
12	Extreme Sport
13	FPS
14	Fight
15	Fighting
16	Figthing
17	Flight
18	Flight War
19	Football
20	Horor
21	Horror
22	Life Simulation
23	Life Simulator
24	Musou
25	Ninja
26	Open World
27	Puzzle
28	RPG
29	Racing
30	Rythim Game
31	Sci-Fi
32	Semi-Open World
33	Shooter
34	Skateboard
35	Sport
36	Stealth
37	Strategi
38	Survival simulation
39	Tactic
40	Tycoon
41	War
42	Xtreme Sport
43	Zombie
\.


--
-- Data for Name: factgamerank; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.factgamerank (game_key, genre_key, rank) FROM stdin;
1	35	33
1	34	33
2	26	1
3	1	76
3	28	76
4	1	106
5	1	104
6	1	5
7	12	18
8	1	64
8	5	64
9	39	55
10	28	27
11	5	23
12	18	56
13	31	91
13	1	91
13	5	91
14	1	58
15	1	8
16	31	87
16	1	87
17	14	74
18	1	54
18	5	54
19	35	29
19	19	29
20	24	71
21	1	68
21	32	68
22	26	4
23	21	34
24	13	51
25	23	96
26	33	80
27	38	70
28	36	52
29	7	83
30	14	67
31	28	63
32	40	90
33	28	10
34	42	105
34	29	105
35	1	35
36	20	45
37	1	107
37	11	107
38	1	6
38	5	6
39	16	86
40	15	84
41	8	39
42	27	92
43	16	101
44	5	93
44	9	93
45	1	89
45	5	89
46	28	69
47	33	36
48	15	31
49	12	50
50	29	102
51	12	60
52	28	97
53	21	14
54	28	66
55	1	108
56	29	22
57	4	59
58	1	13
59	28	65
60	1	2
60	21	2
61	1	44
62	28	62
63	28	75
64	28	98
65	24	73
66	28	103
67	17	11
67	10	11
68	33	99
69	28	42
70	15	88
71	12	82
72	1	41
72	5	41
73	1	46
74	26	40
75	28	43
76	28	53
76	1	53
77	29	32
78	3	9
79	1	7
80	28	100
81	25	38
81	1	38
82	1	15
83	33	79
84	1	48
85	33	26
86	12	12
87	2	85
88	30	72
89	37	95
90	1	78
91	43	57
92	26	24
93	22	81
94	6	61
95	12	19
95	29	19
96	21	77
97	41	25
98	5	94
99	39	30
99	28	30
100	1	21
100	28	21
101	33	49
101	41	49
102	12	47
103	28	3
104	12	17
105	35	37
106	15	28
107	1	20
107	5	20
\.


--
-- Name: dimgame_game_key_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dimgame_game_key_seq', 107, true);


--
-- Name: dimgenre_genre_key_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dimgenre_genre_key_seq', 43, true);


--
-- Name: dimgame dimgame_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dimgame
    ADD CONSTRAINT dimgame_pkey PRIMARY KEY (game_key);


--
-- Name: dimgenre dimgenre_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dimgenre
    ADD CONSTRAINT dimgenre_pkey PRIMARY KEY (genre_key);


--
-- Name: factgamerank factgamerank_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.factgamerank
    ADD CONSTRAINT factgamerank_pkey PRIMARY KEY (game_key, genre_key);


--
-- Name: factgamerank factgamerank_game_key_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.factgamerank
    ADD CONSTRAINT factgamerank_game_key_fkey FOREIGN KEY (game_key) REFERENCES public.dimgame(game_key);


--
-- Name: factgamerank factgamerank_genre_key_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.factgamerank
    ADD CONSTRAINT factgamerank_genre_key_fkey FOREIGN KEY (genre_key) REFERENCES public.dimgenre(genre_key);


--
-- PostgreSQL database dump complete
--

