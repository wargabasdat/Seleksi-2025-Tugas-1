--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5
-- Dumped by pg_dump version 17.5

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
-- Name: dim_director; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dim_director (
    director_id integer NOT NULL,
    director_name text NOT NULL
);


ALTER TABLE public.dim_director OWNER TO postgres;

--
-- Name: dim_videogame; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dim_videogame (
    videogame_id integer NOT NULL,
    title text NOT NULL
);


ALTER TABLE public.dim_videogame OWNER TO postgres;

--
-- Name: dim_year; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dim_year (
    year_id integer NOT NULL
);


ALTER TABLE public.dim_year OWNER TO postgres;

--
-- Name: fact_director_credit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fact_director_credit (
    videogame_id integer NOT NULL,
    year_id integer NOT NULL,
    director_id integer NOT NULL
);


ALTER TABLE public.fact_director_credit OWNER TO postgres;

--
-- Name: fact_videogame_rating; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fact_videogame_rating (
    videogame_id integer NOT NULL,
    year_id integer NOT NULL,
    rating double precision
);


ALTER TABLE public.fact_videogame_rating OWNER TO postgres;

--
-- Data for Name: dim_director; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dim_director (director_id, director_name) FROM stdin;
1	Neil Druckmann
2	Bruce Straley
3	Konrad Tomaszkiewicz
4	Cory Barlog
5	Hideo Kojima
6	Eiji Aonuma
7	Yoichi Yamada
8	Yoshiaki Koizumi
9	Casey Hudson
10	Yoshinori Kitase
11	Yasushi Matsumura
12	Masato Yagi
13	Akihiko Matsui
14	Takashi Tokita
15	Todd Howard
16	Sefton Hill
17	Hidemaro Fujibayashi
18	Hiroki Hirano
19	Kentaro Tominaga
20	Amy Hennig
21	David Speyrer
22	Takayuki Kobayashi
23	Masashi Tsuboyama
24	Feargus Urquhart
25	Nate Fox
26	Katsura Hashino
27	Guillermo del Toro
28	Takashi Tezuka
29	Ron Gilbert
30	Fumito Ueda
31	David Cage
32	Ryan Smith
33	Shinji Mikami
34	Kuniomi Matsushita
35	Sean Ainsworth
36	Nick Herman
37	Dennis Lenart
38	Hidetaka Miyazaki
39	Petri Järvilehto
40	Tetsuya Nomura
41	Gabe Newell
42	Randy Pitchford
43	Daniel Vávra
44	Warren Spector
45	Tim Schafer
46	Toru Hagihara
47	Shigeru Miyamoto
48	Mathijs de Jonge
49	Ken Levine
50	Stig Asmussen
51	Dan Tudge
52	David Jaffe
53	Greg Tiernan
54	Yajuan Cheng
55	Jun'ya Morita
56	Markus Mäki
57	Hideki Kamiya
58	Keiichiro Toyama
59	Jason Anderson
60	Leonard Boyarsky
61	Matt Samia
62	Mark Schwarz
63	Duane Stinnett
64	Martin Hollis
65	Masahiro Sakurai
66	Yoshio Sakamoto
67	Hiroyuki Itô
68	Jonathan Ackley
69	Larry Ahern
70	Keiji Okayasu
71	Yu Suzuki
72	Hal Barwood
73	Shinta Nojiri
74	Kazuki Hosokawa
75	Toshihiro Nagoshi
76	Justin Richmond
77	Jason West
78	Kenta Motokura
79	Zane Lyon
80	Chris Parker
81	Chris 'Crispy' Brion
82	Dave Grossman
83	Didrik Tollefsen
84	Ragnar Tørnquist
85	Matthew Samia
\.


--
-- Data for Name: dim_videogame; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dim_videogame (videogame_id, title) FROM stdin;
1	Red Dead Redemption II
2	The Last of Us
3	The Witcher 3: Wild Hunt
4	God of War
5	Metal Gear Solid
6	The Legend of Zelda: Ocarina of Time
7	Grand Theft Auto V
8	Mass Effect 2
9	Uncharted 4: A Thief's End
10	Metal Gear Solid 3: Snake Eater
11	Star Wars: Knights of the Old Republic
12	Final Fantasy VII
13	Chrono Trigger
14	Grand Theft Auto: San Andreas
15	The Elder Scrolls V: Skyrim
16	Red Dead Redemption
17	Batman: Arkham City
18	The Legend of Zelda: Breath of the Wild
19	Uncharted 2: Among Thieves
20	Portal 2
21	Half-Life 2
22	Metal Gear Solid 4: Guns of the Patriots
23	Silent Hill 2
24	Fallout 2: A Post-Nuclear Role-Playing Game
25	Baldur's Gate II: Shadows of Amn
26	Planescape: Torment
27	Ghost of Tsushima
28	Persona 5
29	P.T.
30	Super Mario World
31	The Secret of Monkey Island
32	The Legend of Zelda: A Link to the Past
33	Shadow of the Colossus
34	Detroit: Become Human
35	Spider-Man
36	Mass Effect
37	Grand Theft Auto: Vice City
38	Batman: Arkham Asylum
39	Resident Evil 4
40	The Walking Dead: A Telltale Game Series
41	Bloodborne
42	Max Payne
43	Kingdom Hearts
44	God of War II
45	God of War II
46	Fallout
47	Half-Life
48	Mafia: The City of Lost Heaven
49	Deus Ex
50	Grim Fandango
51	Castlevania: Symphony of the Night
52	Super Mario Bros. 3
53	Monkey Island 2: LeChuck's Revenge
54	Mass Effect 3
55	Horizon Zero Dawn
56	BioShock Infinite
57	God of War III
58	BioShock
59	Assassin's Creed II
60	Assassin's Creed II
61	Final Fantasy X
62	Fallout 3
63	Dragon Age: Origins
64	God of War
65	Dark Souls III
66	Max Payne 2: The Fall of Max Payne
67	Resident Evil 2
68	Dark Souls
69	Portal
70	Silent Hill
71	Vampire: The Masquerade - Bloodlines
72	The Legend of Zelda: Majora's Mask
73	Super Mario 64
74	StarCraft
75	GoldenEye 007
76	Super Smash Bros. Melee
77	Super Metroid
78	Half-Life 2: Episode Two
79	Final Fantasy VI
80	The Curse of Monkey Island
81	Shenmue
82	Indiana Jones and the Fate of Atlantis
83	Metal Gear: Ghost Babel
84	Batman: Arkham Knight
85	Super Smash Bros. Ultimate
86	Yakuza 0
87	Uncharted 3: Drake's Deception
88	Metal Gear Solid 2: Sons of Liberty
89	Call of Duty 4: Modern Warfare
90	Super Mario Odyssey
91	South Park: The Stick of Truth
92	The Legend of Zelda: Twilight Princess
93	Super Mario Galaxy
94	The Legend of Zelda: The Wind Waker
95	Day of the Tentacle
96	Baldur's Gate
97	Diablo II
98	The Longest Journey
99	System Shock 2
100	StarCraft: Brood War
\.


--
-- Data for Name: dim_year; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dim_year (year_id) FROM stdin;
2018
2013
2015
1998
2010
2016
2004
2003
1997
1995
2011
2017
2009
2008
2001
2000
1999
2020
2014
1990
1991
2005
2007
2002
2012
1988
1996
1994
1992
2006
1993
\.


--
-- Data for Name: fact_director_credit; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fact_director_credit (videogame_id, year_id, director_id) FROM stdin;
2	2013	1
2	2013	2
3	2015	3
4	2018	4
5	1998	5
6	1998	6
6	1998	7
6	1998	8
8	2010	9
9	2016	1
9	2016	2
10	2004	5
11	2003	9
12	1997	10
12	1997	11
12	1997	12
13	1995	10
13	1995	13
13	1995	14
15	2011	15
17	2011	16
18	2017	17
18	2017	18
18	2017	19
19	2009	20
19	2009	2
21	2004	21
22	2008	5
23	2001	22
23	2001	23
24	1998	24
25	2000	24
27	2020	25
28	2016	26
29	2014	27
29	2014	5
30	1990	28
31	1990	29
32	1991	28
32	1991	17
33	2005	30
34	2018	31
35	2018	32
36	2007	9
38	2009	16
39	2005	33
39	2005	34
40	2012	35
40	2012	36
40	2012	37
41	2015	38
42	2001	39
43	2002	40
44	2007	4
45	2007	4
46	1997	24
47	1998	41
47	1998	42
48	2002	43
49	2000	44
50	1998	45
51	1997	46
52	1988	47
52	1988	28
53	1991	29
54	2012	9
55	2017	48
56	2013	49
57	2010	50
58	2007	49
61	2001	10
62	2008	15
63	2009	51
64	2005	52
64	2005	53
65	2016	38
65	2016	54
65	2016	55
66	2003	56
67	1998	57
68	2011	38
70	1999	58
71	2004	59
71	2004	60
72	2000	6
72	2000	8
73	1996	47
74	1998	61
74	1998	62
74	1998	63
75	1997	64
76	2001	65
77	1994	66
78	2007	21
79	1994	67
79	1994	10
80	1997	68
80	1997	69
81	1999	70
81	1999	71
82	1992	72
83	2000	73
84	2015	16
85	2018	65
86	2015	74
86	2015	75
87	2011	20
87	2011	76
88	2001	5
89	2007	77
90	2017	78
91	2014	79
91	2014	80
91	2014	81
92	2006	6
93	2007	8
94	2002	6
95	1993	82
95	1993	45
96	1998	24
98	1999	83
98	1999	84
99	1999	49
100	1998	85
\.


--
-- Data for Name: fact_videogame_rating; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fact_videogame_rating (videogame_id, year_id, rating) FROM stdin;
1	2018	9.7
2	2013	9.7
3	2015	9.6
4	2018	9.5
5	1998	9.5
6	1998	9.6
7	2013	9.4
8	2010	9.5
9	2016	9.4
10	2004	9.5
11	2003	9.5
12	1997	9.5
13	1995	9.4
14	2004	9.4
15	2011	9.3
16	2010	9.4
17	2011	9.4
18	2017	9.4
19	2009	9.3
20	2011	9.4
21	2004	9.4
22	2008	9.3
23	2001	9.4
24	1998	9.4
25	2000	9.4
26	1999	9.3
27	2020	9.2
28	2016	9.2
29	2014	9.2
30	1990	9.2
31	1990	9.3
32	1991	9.2
33	2005	9.2
34	2018	9.1
35	2018	9.2
36	2007	9.1
37	2002	9.2
38	2009	9.1
39	2005	9.2
40	2012	9.2
41	2015	9.2
42	2001	9.2
43	2002	9.1
44	2007	9.2
45	2007	9.2
46	1997	9.1
47	1998	9.1
48	2002	9.1
49	2000	9.2
50	1998	9.1
51	1997	9.2
52	1988	9.2
53	1991	9.2
54	2012	9.1
55	2017	8.9
56	2013	9.1
57	2010	9.1
58	2007	9.1
59	2009	9
60	2009	9
61	2001	9.1
62	2008	9
63	2009	9.1
64	2005	9
65	2016	9.1
66	2003	9.1
67	1998	9.1
68	2011	9
69	2007	9.1
70	1999	9
71	2004	9.1
72	2000	9
73	1996	9.1
74	1998	9.1
75	1997	9.1
76	2001	9
77	1994	9.1
78	2007	9.1
79	1994	9.1
80	1997	9.1
81	1999	9
82	1992	9
83	2000	9
84	2015	9
85	2018	8.8
86	2015	8.9
87	2011	9
88	2001	9
89	2007	9
90	2017	9
91	2014	8.8
92	2006	9
93	2007	9.1
94	2002	9
95	1993	8.9
96	1998	8.9
97	2000	9
98	1999	8.9
99	1999	8.9
100	1998	9
\.


--
-- Name: dim_director dim_director_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_director
    ADD CONSTRAINT dim_director_pkey PRIMARY KEY (director_id);


--
-- Name: dim_videogame dim_videogame_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_videogame
    ADD CONSTRAINT dim_videogame_pkey PRIMARY KEY (videogame_id);


--
-- Name: dim_year dim_year_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_year
    ADD CONSTRAINT dim_year_pkey PRIMARY KEY (year_id);


--
-- Name: fact_director_credit fact_director_credit_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_director_credit
    ADD CONSTRAINT fact_director_credit_pkey PRIMARY KEY (videogame_id, year_id, director_id);


--
-- Name: fact_videogame_rating fact_videogame_rating_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_videogame_rating
    ADD CONSTRAINT fact_videogame_rating_pkey PRIMARY KEY (videogame_id, year_id);


--
-- Name: fact_director_credit fact_director_credit_director_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_director_credit
    ADD CONSTRAINT fact_director_credit_director_id_fkey FOREIGN KEY (director_id) REFERENCES public.dim_director(director_id);


--
-- Name: fact_director_credit fact_director_credit_videogame_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_director_credit
    ADD CONSTRAINT fact_director_credit_videogame_id_fkey FOREIGN KEY (videogame_id) REFERENCES public.dim_videogame(videogame_id);


--
-- Name: fact_director_credit fact_director_credit_year_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_director_credit
    ADD CONSTRAINT fact_director_credit_year_id_fkey FOREIGN KEY (year_id) REFERENCES public.dim_year(year_id);


--
-- Name: fact_videogame_rating fact_videogame_rating_videogame_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_videogame_rating
    ADD CONSTRAINT fact_videogame_rating_videogame_id_fkey FOREIGN KEY (videogame_id) REFERENCES public.dim_videogame(videogame_id);


--
-- Name: fact_videogame_rating fact_videogame_rating_year_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_videogame_rating
    ADD CONSTRAINT fact_videogame_rating_year_id_fkey FOREIGN KEY (year_id) REFERENCES public.dim_year(year_id);


--
-- PostgreSQL database dump complete
--

