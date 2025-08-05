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

--
-- Name: check_rating_range(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.check_rating_range() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NEW.rating IS NOT NULL AND (NEW.rating < 0 OR NEW.rating > 10) THEN
        RAISE EXCEPTION 'Rating must be between 0 and 10';
    END IF;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.check_rating_range() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: cast_credit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cast_credit (
    videogame_id integer NOT NULL,
    star_id integer NOT NULL
);


ALTER TABLE public.cast_credit OWNER TO postgres;

--
-- Name: country; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.country (
    id integer NOT NULL,
    country_name character varying(100) NOT NULL
);


ALTER TABLE public.country OWNER TO postgres;

--
-- Name: country_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.country_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.country_id_seq OWNER TO postgres;

--
-- Name: country_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.country_id_seq OWNED BY public.country.id;


--
-- Name: director; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.director (
    id integer NOT NULL,
    director_name character varying(255) NOT NULL
);


ALTER TABLE public.director OWNER TO postgres;

--
-- Name: director_credit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.director_credit (
    videogame_id integer NOT NULL,
    director_id integer NOT NULL
);


ALTER TABLE public.director_credit OWNER TO postgres;

--
-- Name: director_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.director_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.director_id_seq OWNER TO postgres;

--
-- Name: director_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.director_id_seq OWNED BY public.director.id;


--
-- Name: genre; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.genre (
    id integer NOT NULL,
    genre_name character varying(100) NOT NULL
);


ALTER TABLE public.genre OWNER TO postgres;

--
-- Name: genre_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.genre_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.genre_id_seq OWNER TO postgres;

--
-- Name: genre_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.genre_id_seq OWNED BY public.genre.id;


--
-- Name: platform; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.platform (
    id integer NOT NULL,
    platform_name character varying(100) NOT NULL
);


ALTER TABLE public.platform OWNER TO postgres;

--
-- Name: platform_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.platform_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.platform_id_seq OWNER TO postgres;

--
-- Name: platform_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.platform_id_seq OWNED BY public.platform.id;


--
-- Name: star; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.star (
    id integer NOT NULL,
    star_name character varying(255) NOT NULL
);


ALTER TABLE public.star OWNER TO postgres;

--
-- Name: star_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.star_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.star_id_seq OWNER TO postgres;

--
-- Name: star_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.star_id_seq OWNED BY public.star.id;


--
-- Name: videogame; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.videogame (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    year integer,
    age_rating character varying(20),
    rating double precision,
    description text,
    country_id integer
);


ALTER TABLE public.videogame OWNER TO postgres;

--
-- Name: videogame_genre; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.videogame_genre (
    videogame_id integer NOT NULL,
    genre_id integer NOT NULL
);


ALTER TABLE public.videogame_genre OWNER TO postgres;

--
-- Name: videogame_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.videogame_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.videogame_id_seq OWNER TO postgres;

--
-- Name: videogame_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.videogame_id_seq OWNED BY public.videogame.id;


--
-- Name: videogame_platform; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.videogame_platform (
    videogame_id integer NOT NULL,
    platform_id integer NOT NULL
);


ALTER TABLE public.videogame_platform OWNER TO postgres;

--
-- Name: country id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.country ALTER COLUMN id SET DEFAULT nextval('public.country_id_seq'::regclass);


--
-- Name: director id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.director ALTER COLUMN id SET DEFAULT nextval('public.director_id_seq'::regclass);


--
-- Name: genre id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genre ALTER COLUMN id SET DEFAULT nextval('public.genre_id_seq'::regclass);


--
-- Name: platform id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.platform ALTER COLUMN id SET DEFAULT nextval('public.platform_id_seq'::regclass);


--
-- Name: star id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.star ALTER COLUMN id SET DEFAULT nextval('public.star_id_seq'::regclass);


--
-- Name: videogame id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.videogame ALTER COLUMN id SET DEFAULT nextval('public.videogame_id_seq'::regclass);


--
-- Data for Name: cast_credit; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cast_credit (videogame_id, star_id) FROM stdin;
1	1
1	2
1	3
2	4
2	5
2	6
3	7
3	8
3	9
4	10
4	11
4	12
5	13
5	14
5	15
6	16
6	17
6	18
7	19
7	20
7	21
8	22
8	23
8	24
9	25
9	4
9	26
10	13
10	27
10	28
11	29
11	30
11	31
14	32
14	33
14	34
15	35
15	36
15	37
16	3
16	38
16	39
17	40
17	41
17	42
18	43
18	44
18	45
19	25
19	46
19	47
20	48
20	49
20	50
21	51
21	52
21	53
22	13
22	54
22	15
23	55
23	56
23	57
24	58
24	59
24	60
25	61
25	58
25	62
26	63
26	64
26	29
27	65
27	66
27	67
28	68
28	69
28	70
31	71
31	72
31	73
33	74
33	75
33	76
34	77
34	78
34	79
35	80
35	81
35	82
36	83
36	84
36	85
37	86
37	87
37	88
38	41
38	40
38	89
39	90
39	91
39	92
40	93
40	94
40	95
41	96
41	97
41	98
42	99
42	100
42	101
43	102
43	69
43	103
44	104
44	105
44	106
45	104
45	105
45	106
46	58
46	107
46	108
47	109
47	110
47	111
48	112
48	113
48	114
49	115
49	116
49	117
50	118
50	119
50	120
51	121
51	122
51	123
53	71
53	72
53	73
54	29
54	124
54	84
55	125
55	126
55	127
56	4
56	128
56	129
57	130
57	131
57	132
58	133
58	134
58	135
59	136
59	137
59	25
60	136
60	137
60	25
61	138
61	139
61	140
62	141
62	142
62	59
63	143
63	144
63	145
64	104
64	105
64	146
65	147
65	148
65	149
66	99
66	150
66	151
67	152
67	153
67	154
68	155
68	156
68	157
69	48
69	158
69	159
70	160
70	161
70	162
71	163
71	164
71	165
72	17
72	166
72	167
73	168
73	169
74	170
74	171
74	172
75	173
75	174
75	175
76	176
76	168
76	16
77	177
77	178
78	51
78	179
78	180
80	71
80	73
80	72
81	181
81	182
81	183
82	184
82	185
82	186
84	187
84	188
84	4
85	189
85	190
85	191
86	192
86	193
86	194
87	25
87	26
87	46
88	13
88	195
88	196
89	197
89	198
89	199
90	200
90	16
90	201
91	202
91	203
91	204
92	205
92	206
92	207
93	168
93	201
93	208
94	209
94	210
94	211
95	212
95	184
95	186
96	62
96	213
96	108
97	214
97	215
97	216
98	217
98	218
98	219
99	220
99	221
99	222
100	170
100	223
100	224
\.


--
-- Data for Name: country; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.country (id, country_name) FROM stdin;
\.


--
-- Data for Name: director; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.director (id, director_name) FROM stdin;
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
-- Data for Name: director_credit; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.director_credit (videogame_id, director_id) FROM stdin;
2	1
2	2
3	3
4	4
5	5
6	6
6	7
6	8
8	9
9	1
9	2
10	5
11	9
12	10
12	11
12	12
13	10
13	13
13	14
15	15
17	16
18	17
18	18
18	19
19	20
19	2
21	21
22	5
23	22
23	23
24	24
25	24
27	25
28	26
29	27
29	5
30	28
31	29
32	28
32	17
33	30
34	31
35	32
36	9
38	16
39	33
39	34
40	35
40	36
40	37
41	38
42	39
43	40
44	4
45	4
46	24
47	41
47	42
48	43
49	44
50	45
51	46
52	47
52	28
53	29
54	9
55	48
56	49
57	50
58	49
61	10
62	15
63	51
64	52
64	53
65	38
65	54
65	55
66	56
67	57
68	38
70	58
71	59
71	60
72	6
72	8
73	47
74	61
74	62
74	63
75	64
76	65
77	66
78	21
79	67
79	10
80	68
80	69
81	70
81	71
82	72
83	73
84	16
85	65
86	74
86	75
87	20
87	76
88	5
89	77
90	78
91	79
91	80
91	81
92	6
93	8
94	6
95	82
95	45
96	24
98	83
98	84
99	49
100	85
\.


--
-- Data for Name: genre; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.genre (id, genre_name) FROM stdin;
\.


--
-- Data for Name: platform; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.platform (id, platform_name) FROM stdin;
\.


--
-- Data for Name: star; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.star (id, star_name) FROM stdin;
1	Benjamin Byron Davis
2	Roger Clark
3	Rob Wiethoff
4	Troy Baker
5	Ashley Johnson
6	Hana Hayes
7	Doug Cockle
8	Denise Gough
9	Jo Wyatt
10	Christopher Judge
11	Sunny Suljic
12	Jeremy Davies
13	David Hayter
14	Patric Zimmerman
15	Peter Lurie
16	Nobuyuki Hiyama
17	Fujiko Takimoto
18	Jun Mizusawa
19	Shawn Fonteno
20	Ned Luke
21	Steven Ogg
22	Shohreh Aghdashloo
23	Maggie Baird
24	Adam Baldwin
25	Nolan North
26	Richard McGonagle
27	Jodi Benson
28	Jim Piddock
29	Jennifer Hale
30	Raphael Sbarge
31	Rafael Ferrer
32	Young Maylay
33	Faizon Love
34	Yolanda 'Yo-Yo' Whittaker
35	Max von Sydow
36	Christopher Plummer
37	Joan Allen
38	Josh Blaylock
39	Sophia Marzocchi
40	Kevin Conroy
41	Mark Hamill
42	David Kaye
43	Kengo Takanashi
44	Yû Shimamura
45	Kôji Takeda
46	Emily Rose
47	Claudia Black
48	Ellen McLain
49	Stephen Merchant
50	J.K. Simmons
51	Robert Guillaume
52	Robert Culp
53	Louis Gossett Jr.
54	Josh Keaton
55	Guy Cihi
56	Monica Horgan
57	Donna Burke
58	Charlie Adler
59	Ron Perlman
60	Dwight Schultz
61	David Warner
62	Dee Bradley Baker
63	Michael T. Weiss
64	Rob Paulsen
65	Daisuke Tsuji
66	Kazuya Nakai
67	Eric Steinberg
68	Jun Fukuyama
69	Mamoru Miyano
70	Nana Mizuki
71	Dominic Armato
72	Earl Boen
73	Alexandra Boyd
74	Kenji Nojima
75	Kazuhiro Nakata
76	Kyôko Hikami
77	Valorie Curry
78	Bryan Dechart
79	Jesse Williams
80	Yuri Lowenthal
81	Tara Platt
82	Travis Willingham
83	Steven Barr
84	Kimberly Brooks
85	Keith David
86	Ray Liotta
87	William Fichtner
88	Tom Sizemore
89	Arleen Sorkin
90	Paul Mercier
91	Carolyn Lawrence
92	Rino Romano
93	Dave Fennoy
94	Melissa Hutchison
95	Nick Herman
96	Daniel Fine
97	William Vanderpuye
98	Andrew Tiernan
99	James McCaffrey
100	Haviland Morris
101	Chris Phillips
102	Miyu Irino
103	Risa Uchida
104	Linda Hunt
105	Terrence 'T.C.' Carson
106	Michael Clarke Duncan
107	Richard Dean Anderson
108	Jeff Bennett
109	Kathy Levin
110	Harry S. Robins
111	Mike Shapiro
112	Michael Sorvino
113	William DeMeo
114	George DiCenzo
115	Jay Anthony Franke
116	Brent Anderson
117	Ralph Barbagallo
118	Tony Plana
119	Maria Canals-Barrera
120	Alan Blumenfeld
121	Robert Belgrade
122	Ramsay Scott
123	Kimberly Forsythe
124	Mark Meer
125	Ashly Burch
126	Laura van Tol
127	Ava Potter
128	Courtnee Draper
129	Kiff VandenHeuvel
130	George Ball
131	Adrienne Barbeau
132	Susanne Blakeslee
133	John Ahlin
134	Greg Baldwin
135	Jane Beller
136	Roger Craig Smith
137	Kristen Bell
138	James Arnold Taylor
139	Hedy Burress
140	John DiMaggio
141	Liam Neeson
142	Malcolm McDowell
143	Steve Valentine
144	Peter Renaday
145	Kate Mulgrew
146	Carole Ruggier
147	Pik Sen Lim
148	Olivia Mace
149	Roger Ringrose
150	Wendy Hoopes
151	Jonathan Davis
152	Paul Haddad
153	Alyson Court
154	Sally Cahill
155	Adam Sopp
156	Andy Gathergood
157	Blake Ritson
158	Mike Patton
159	Alesia Glidewell
160	Michael Guinn
161	Susan Papa
162	Thessaly Lerner
163	André Sogliuzzo
164	Andy Milder
165	Armando Valdes-Kennedy
166	Sachi Matsumoto
167	Kôji Tobe
168	Charles Martinet
169	Leslie Swan
170	Glynnis Talken
171	Michael Gough
172	Paul Eiding
173	Kevin Bayliss
174	Ken Lobb
175	Scott Hochberg
176	Dean Harrington
177	Kenji Yamamoto
178	Dan Owsen
179	Merle Dandridge
180	Tony Todd
181	Hiroshi Fujioka
182	Masaya Matsukaze
183	Corey Marshall
184	Denny Delk
185	David Gitin
186	Jane Jacobs
187	Carlos Alazraqui
188	Laura Bailey
189	Jaz Adams
190	Rikako Aikawa
191	Justin Anselmi
192	Takaya Kuroda
193	Hidenari Ugaki
194	Kazuhiro Nakaya
195	Quinton Flynn
196	Christopher Randolph
197	Billy Murray
198	Craig Fairbrass
199	David Sobolov
200	Kate Higgins
201	Kenny James
202	Trey Parker
203	Matt Stone
204	Mona Marshall
205	Akira Sasanuma
206	Akiko Kômoto
207	Hironori Miyata
208	Samantha Kelly
209	Nate Bihldorff
210	Osamu Hosoi
211	Asami Imai
212	Richard Sanders
213	Michael Bell
214	Frank Gorshin
215	Liana Young
216	James Harper
217	Sarah Hamilton
218	Regina Lund
219	Louis Aguirre
220	Kemal Amarasingham
221	Laura Baldwin
222	Matt Boynton
223	Jack Ritschel
224	Paul Ainsley
\.


--
-- Data for Name: videogame; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.videogame (id, title, year, age_rating, rating, description, country_id) FROM stdin;
1	Red Dead Redemption II	2018	M	9.7	Follows outlaw Arthur Morgan and his gang, led by the charismatic Dutch Van der Linde, as they struggle to cope with the loss of their way of life amidst the decline of the Wild West at the turn of the 20th century.	\N
2	The Last of Us	2013	M	9.7	In a hostile, post-pandemic world, Joel and Ellie, brought together by desperate circumstances, must rely on each other to survive a brutal journey across what remains of the United States.	\N
3	The Witcher 3: Wild Hunt	2015	M	9.6	The monster slayer Geralt of Rivia must find his adoptive daughter who is being pursued by the Wild Hunt, and prevent the White Frost from bringing about the end of the world.	\N
4	God of War	2018	M	9.5	After wiping out the gods of Mount Olympus, Kratos moves on to the frigid lands of Scandinavia, where he and his son must embark on an odyssey across a dangerous world of gods and monsters.	\N
5	Metal Gear Solid	1998	M	9.5	A crack government anti-terrorist squad takes over an obscure Alaskan nuclear disposal facility. Solid Snake is up for the task to infiltrate the facility, rescue the two hostages and thwart the terrorists' plans.	\N
6	The Legend of Zelda: Ocarina of Time	1998	E	9.6	A young Kokiri boy discovers that his destiny is to free the Seven Sages and save the land of Hyrule from the treacherous sorcerer Ganondorf.	\N
7	Grand Theft Auto V	2013	M	9.4	Three very different criminals team up for a series of heists and walk into some of the most thrilling experiences in the corrupt city of Los Santos in the sate of Southern San Andreas.	\N
8	Mass Effect 2	2010	M	9.5	After being revived from death and having to join a pro-human organization without a choice, Commander Shepard must assemble a team, battle a new threat, and make tough choices in order to save the galaxy from total annihilation once more.	\N
9	Uncharted 4: A Thief's End	2016	T	9.4	Thrown back into the dangerous underworld he'd tried to leave behind, Nathan Drake must decide what he's willing to sacrifice to save the ones he loves.	\N
10	Metal Gear Solid 3: Snake Eater	2004	M	9.5	In 1964, a U.S. government operative codenamed "Snake" must infiltrate mountainous Soviet territory to rescue a scientist building a weapon of terrible power.	\N
11	Star Wars: Knights of the Old Republic	2003	T	9.5	A republic soldier, training to become a Jedi Knight, is given the task of halting the conquest of Darth Malak by discovering the location of a weapon known as the Star Forge.	\N
12	Final Fantasy VII	1997	T	9.5	A former soldier from an evil company joins a mercenary clan to fight the company he once served.	\N
13	Chrono Trigger	1995	E	9.4	Crono, a young boy, is thrust to adventure by destiny to destroy an oncoming threat that will destroy the world in 1999.	\N
14	Grand Theft Auto: San Andreas	2004	M	9.4	In 1992, Carl "CJ" Johnson, a member of the Grove Street gang, comes home after a family tragedy to find the streets of Los Santos overtaken by crime and corruption, which he must take back before things become worse.	\N
15	The Elder Scrolls V: Skyrim	2011	M	9.3	After escaping execution, the last living Dragonborn must grow in strength and power to defeat the dragons that have once again begun to plague the land of Skyrim.	\N
16	Red Dead Redemption	2010	M	9.4	Follows a former outlaw, John Marston, who is forced by the federal government to hunt down the members of his old gang during the decline of the American frontier in the year 1911.	\N
17	Batman: Arkham City	2011	T	9.4	When part of Gotham is turned into a private reserve for criminals known as Arkham City, all hell is sure to break loose, and the Dark Knight is the only one who can stop it.	\N
18	The Legend of Zelda: Breath of the Wild	2017	E10+	9.4	After a century of hibernation, Link reawakens to once again save a ruined Hyrule from a great evil.	\N
19	Uncharted 2: Among Thieves	2009	18+	9.3	After being tracked down by Harry Flynn, Nathan Drake goes on a quest for Marco Polo's lost fleet. However when things take an unexpected turn for the worst, Drake must rely on those closest to him in order to find the Cintomani Stone.	\N
20	Portal 2	2011	E10+	9.4	Many years after "Portal," Chell reawakens at Aperture Science and tries to stop GLaDOS once again with the help of Wheatley, who has his own plans for the historical facility.	\N
21	Half-Life 2	2004	M	9.4	Dr. Freeman is taken out of stasis by his "employer" to help rid the planet of invading aliens forces known as the Combine that entered through the portals he helped create.	\N
22	Metal Gear Solid 4: Guns of the Patriots	2008	M	9.3	When the nations of the world rely upon private military companies to fight their battles for them, renegade Liquid Ocelot emerges as the head of a potent coalition of mercenary powers. Solid Snake returns to save the world once again.	\N
23	Silent Hill 2	2001	M	9.4	After receiving a letter from his late wife, from Silent Hill, James Sunderland heads towards the town to search for her, only to come across a terrifying road of truth and redemption.	\N
24	Fallout 2: A Post-Nuclear Role-Playing Game	1998	M	9.4	In a post-nuclear future, the descendant of an ancient exiled hero must leave his tribe in search of the Garden of Eden Creation Kit, the last chance of survival for his people.	\N
25	Baldur's Gate II: Shadows of Amn	2000	T	9.4	Jon Irenicus, a sadistic secretive powerful mage bent on revenge, captures Gorion's ward and his/her party for a diabolical experiment.	\N
26	Planescape: Torment	1999	T	9.3	In the city of Sigil, the only place from which all realities of the Planescape universe can be reached, an immortal amnesiac, the Nameless One, must uncover his past, the mystery of his immortality as well as who's trying to kill him.	\N
27	Ghost of Tsushima	2020	M	9.2	Set in 1274 on the Tsushima Island, the last samurai, Jin Sakai, must master a new fighting style, the way of the Ghost, to defeat the Mongol forces and fight for the freedom and independence of Japan.	\N
28	Persona 5	2016	M	9.2	A group of high school students create a vigilante group to expose the crimes of corrupt adults but soon find themselves in the midst of a worldwide conspiracy and targeted by powerful individuals who would do anything to silence them.	\N
29	P.T.	2014	M	9.2	The player must navigate a series of continuously looping hallways, solving cryptic puzzles, all while being hunted by a hostile apparition named Lisa.	\N
30	Super Mario World	1990	E	9.2	While Mario and Luigi are vacationing in Dinosaur Land, Bowser kidnaps the Princess. Mario and his new dino friend Yoshi go on a mission to save her.	\N
31	The Secret of Monkey Island	1990	E	9.3	Young pirate wanna-be Guybrush Threepwood sets out to pass the Three Trials, woo the governess Elaine Marley, reach the fabled Monkey Island and vanquish the nefarious ghost pirate LeChuck.	\N
32	The Legend of Zelda: A Link to the Past	1991	E	9.2	The wizard Agahnim has abducted seven maidens, intent on using their power to open a portal to the Dark World. Armed with a trusty sword and shield, Link begins a great and treacherous journey.	\N
33	Shadow of the Colossus	2005	T	9.2	A young man brings a deceased woman to a forbidden land inhabited by colossal beings said to house the power to revive the dead.	\N
34	Detroit: Become Human	2018	M	9.1	Three androids go on a quest to discover who they really are.	\N
35	Spider-Man	2018	T	9.2	When a new villain threatens New York City, Peter Parker and Spider-Man's worlds collide. To save the city and those he loves, he must rise up and be greater.	\N
36	Mass Effect	2007	M	9.1	In a technologically advanced future, an elite human soldier takes command of a prototype star ship and works to defend the galaxy from danger.	\N
37	Grand Theft Auto: Vice City	2002	M	9.2	In 1986, after doing 15 years in prison in Liberty City, gangster Tommy Vercetti is sent away to Vice City to take over the town and rise to the top of the criminal empire.	\N
38	Batman: Arkham Asylum	2009	T	9.1	Batman battles his archenemy, the Joker, who instigates an elaborate plot to seize control of Arkham Asylum, trap Batman inside with many of his incarcerated foes, and threaten Gotham City with hidden bombs.	\N
39	Resident Evil 4	2005	M	9.2	Six years after the events in Raccoon City, Leon Kennedy, now a federal agent, is sent to a rural part of Spain to rescue the U.S. President's kidnapped daughter, Ashley Graham from a sinister cult.	\N
40	The Walking Dead: A Telltale Game Series	2012	M	9.2	In a world devastated by the undead, a convicted criminal is given a second chance at life when he comes across a little girl named Clementine.	\N
41	Bloodborne	2015	M	9.2	A hunter awakens in the plagued lands of Yharnam, where the denizens have succumbed to beasthood, in an attempt to learn the truth and how to end the plague, unbeknownst of the true horror lurking within the city.	\N
42	Max Payne	2001	M	9.2	A troubled NYPD cop is framed for murder and finds himself being hunted by the police, the mob, and a ruthless corporation.	\N
43	Kingdom Hearts	2002	E	9.1	When his world is destroyed and his friends mysteriously disappear, a young boy named Sora is thrust into a quest to find his missing friends and prevent the armies of darkness from destroying many other worlds.	\N
44	God of War II	2007	M	9.2	After being betrayed by the gods of Olympus and annulled of his divine powers, Kratos must embark on a journey to meet the Sisters of Fate and take his revenge on Olympus.	\N
45	God of War II	2007	M	9.2	After being betrayed by the gods of Olympus and annulled of his divine powers, Kratos must embark on a journey to meet the Sisters of Fate and take his revenge on Olympus.	\N
46	Fallout	1997	M	9.1	After being sent by the overseer of his vault to search for a new water purifying chip, the player discovers the horrors of post apocalyptic America, and the threat of the Master's Army.	\N
47	Half-Life	1998	M	9.1	Dr. Gordon Freeman must fight his way out of a secret research facility after a teleportation experiment goes disastrously wrong.	\N
48	Mafia: The City of Lost Heaven	2002	M	9.1	Set within the fictional American city of Lost Heaven during the 1930s, the story follows the rise and fall of taxi driver-turned-mobster Tommy Angelo within the Salieri crime family.	\N
49	Deus Ex	2000	M	9.2	In a dark cyberpunk future where poverty, disease, oppression and terrorism are widespread, J.C. Denton, a new cybernetically-enhanced special agent, finds evidence of a massive conspiracy when his brother, also an agent, goes rogue.	\N
50	Grim Fandango	1998	T	9.1	Manuel Calavera is a travel agent in The Land of the Dead who has stumbled across a ring of corruption.	\N
51	Castlevania: Symphony of the Night	1997	T	9.2	In 1797, Shaft manages to regain power through a curse placed on Richter Belmont. Four years later, Dracula's son Alucard awakens from his eternal slumber, intent on destroying his evil father once and for all.	\N
52	Super Mario Bros. 3	1988	E	9.2	King Koopa has kidnapped Princess Toadstool, taken over all seven kingdoms in the Mushroom World, and put his seven kids in charge of all of them. It's the Mario Brothers to the rescue.	\N
53	Monkey Island 2: LeChuck's Revenge	1991	E	9.2	Having vanquished the ghost pirate LeChuck with a soft drink, Guybrush Threepwood now seeks the treasure of Big Whoop. During his quest he discovers LeChuck is back from the dead. Once again.	\N
54	Mass Effect 3	2012	M	9.1	Earth is under attack by a monstrous race of gigantic living ships known as the Reapers. Even if Commander Shepard could unite all surviving species in the galaxy, only a miracle could save them. Then again, Shepard did come back from the dead.	\N
55	Horizon Zero Dawn	2017	T	8.9	In a primitive tribal world where strange, monstrous, animalistic machines roam the wilderness, a brave young female warrior goes on a quest to learn the truth about her mysterious origin and the state the world is in.	\N
56	BioShock Infinite	2013	M	9.1	A man is sent to the flying city of Columbia to find a missing girl. However, upon arrival he discovers that the city, its people, and his objective are all not what they seem.	\N
57	God of War III	2010	M	9.1	Armed with his deadly double-chained blades, Kratos must take on Greek mythology's darkest creatures to destroy Olympus and the mighty Zeus himself.	\N
58	BioShock	2007	M	9.1	In 1960, a lone survivor of a plane crash named Jack discovers an abandoned underwater utopia, only to find out that the mystery behind its creation is much more sinister than he first believed.	\N
59	Assassin's Creed II	2009	M	9	Desmond Miles is trained to become a modern-day Assassin through the resurrected memories of ancestor Ezio Auditore da Firenze, who uncovers a massive Templar conspiracy in Renaissance Italy leading to the new Pope.	\N
60	Assassin's Creed II	2009	M	9	Desmond Miles is trained to become a modern-day Assassin through the resurrected memories of ancestor Ezio Auditore da Firenze, who uncovers a massive Templar conspiracy in Renaissance Italy leading to the new Pope.	\N
61	Final Fantasy X	2001	T	9.1	A celebrated young athlete is drawn from his futuristic hometown and convenient lifestyle to a harsh and techno-phobic land by a mysterious force only known as Sin.	\N
62	Fallout 3	2008	M	9	Centuries following nuclear war, a teen leaves the safety of an underground vault in order to find their father, who left in hopes of creating a water purifier.	\N
63	Dragon Age: Origins	2009	M	9.1	After four hundred years since the last Blight, a new Archdemon seeks to destroy the land of Ferelden. It is up to the player - as one of the remaining Grey Wardens - to unite the divided armies of Ferelden and save humanity.	\N
64	God of War	2005	M	9	After 10 years of endless nightmares and servitude to the gods of Olympus, Kratos is assigned with a final task, to kill Ares, the God of War.	\N
65	Dark Souls III	2016	M	9.1	The fire is fading. Darkness creeps across the land. The Lords of Cinder charged with watching over the First Flame have abandoned their thrones. The Champion of Ash, an undead is chosen to return them to their thrones.	\N
66	Max Payne 2: The Fall of Max Payne	2003	M	9.1	The brooding cop has left the DEA and returned to the NYPD. When his latest case ends up involving the thought-dead femme fatale Mona Sax, he finds that his journey through the night is far from over.	\N
67	Resident Evil 2	1998	M	9.1	Two months after the mansion events, the deadly T-virus escapes into the streets of Raccoon City. Leon Kennedy and Claire Redfield find the police office left abandoned. In an underground facility the story of Umbrella Corp. gets unfolded.	\N
68	Dark Souls	2011	M	9	After narrowly escaping a doomed fate in an asylum, an undead warrior fights his way through the desolate remains of Lordran, once a sprawling utopia lead by the gods, to seek his purpose and fulfill a centuries old prophecy.	\N
69	Portal	2007	T	9.1	A test subject wakes up in a scientific facility controlled by a sadistic artificial intelligence and must escape with the help of the only instrument she has--a gun that makes portals.	\N
70	Silent Hill	1999	M	9	Harry awakes from a car crash to notice his daughter, Cheryl, vanished. As he searches for her, through the eerie town of Silent Hill, a terrifying descent into the unknown is set.	\N
71	Vampire: The Masquerade - Bloodlines	2004	M	9.1	Beginning your journey as a new Kindred, you must choose your path to follow the high class Vampire Society, or the lawbreaking group of Anarchs as you find your place in this new world.	\N
72	The Legend of Zelda: Majora's Mask	2000	E	9	After becoming the hero of Hyrule, Link stumbles into the enchanted land of Termina, where a falling moon will crush the world in three days.	\N
73	Super Mario 64	1996	K-A	9.1	When the evil Bowser steals 120 power stars and traps Princess Peach within the walls of her own castle, it's up to Mario to save her once again.	\N
74	StarCraft	1998	T	9.1	In 2499 in the Koprulu sector, a ferocious collective race known as the Zerg arrives to massacre the exiled human colonies while a highly advanced race, the Protoss, intervenes to exterminate the Zerg.	\N
75	GoldenEye 007	1997	T	9.1	James Bond must track down agent-turned-terrorist Alec Trevelyan to stop the launch of a powerful satellite. Play the game that set the stage for the First-person shooter genre on the console.	\N
76	Super Smash Bros. Melee	2001	T	9	Smash Bros. installment for the GameCube with fast-paced, highly competitive and technical gameplay of realtime chess and hype using various Nintendo characters, with simple controls yet deep mechanics.	\N
77	Super Metroid	1994	E	9.1	Samus Aran returns to the brooding planet Zebes to recover the last metroid from the Space Pirates.	\N
78	Half-Life 2: Episode Two	2007	M	9.1	Gordon Freeman, along with the help of human and non-human allies, continues his fight against the ruthless alien force known as the Combine.	\N
79	Final Fantasy VI	1994	T	9.1	A mysterious woman joins a group of mercenaries in order to find out about her destiny and means of saving the world from an evil madman.	\N
80	The Curse of Monkey Island	1997	K-A	9.1	After unwittingly turning his true love Elaine into solid gold with a cursed engagement ring, Guybrush Threepwood must find a map, a ship and a crew, sail to Blood Island and track down an uncursed diamond ring to reverse the curse.	\N
81	Shenmue	1999	T	9	Ryo, a respected Japanese student sees his father killed in front of his own eyes. He sets out to find the man in charge of his fathers death and the mystery of who and why?	\N
82	Indiana Jones and the Fate of Atlantis	1992	T	9	Indiana Jones must fight the nazis again in search for Atlantis and a newly discovered mineral of unbelievable power, the Orichalcum.	\N
83	Metal Gear: Ghost Babel	2000	E	9	In this non-canonical sequel to Metal Gear Solid, Solid Snake is called upon from his home in Alaska to infiltrate an enemy base searching for Metal Gear.	\N
84	Batman: Arkham Knight	2015	M	9	With his back against the wall, Batman turns to his closest allies to help him save Gotham City from the clutches of Scarecrow and the Arkham Knight's army. A familiar face also returns to give The Dark Knight a message he cannot ignore.	\N
85	Super Smash Bros. Ultimate	2018	E10+	8.8	Super Smash Bros. Ultimate for the Nintendo Switch brings back every fighter in the history of the series, adds newcomers and over 100 stages, and introduces a new adventure mode called "World of Light''.	\N
86	Yakuza 0	2015	M	8.9	Kiryu and Majima, both Yakuza's who are in different cities in Japan in 1988, as the fate of the two characters become intertwined in a gritty, violent, and often touching narrative.	\N
87	Uncharted 3: Drake's Deception	2011	T	9	Treasure hunter Nathan Drake embarks on a quest in search of the Atlantis of the Sands while battling an ancient, sinister organization.	\N
88	Metal Gear Solid 2: Sons of Liberty	2001	M	9	Two years after the death of Solid Snake, a rookie FOX-HOUND agent, on his first mission, infiltrates an offshore decontamination facility to rescue the President.	\N
89	Call of Duty 4: Modern Warfare	2007	M	9	The Call of Duty series returns this time into a modern day setting. The player takes control of a character nicknamed "Soap," for the majority of the campaign and will need to progress through many modern warfare scenarios.	\N
90	Super Mario Odyssey	2017	E10+	9	Mario must travel to worlds unknown in order to stop Bowser from marrying Princess Peach.	\N
91	South Park: The Stick of Truth	2014	M	8.8	As the New Kid, discover the lost Stick of Truth, and earn your place at the side of Stan, Kyle, Cartman and Kenny as their new friend.	\N
92	The Legend of Zelda: Twilight Princess	2006	T	9	Link, a young man from a small farming village, finds Hyrule is being consumed by an otherworldly twilight. Guided by a strange pixie named Midna, he endeavors to return light to the land and confront the usurper king Zant.	\N
93	Super Mario Galaxy	2007	E	9.1	When Princess Peach is abducted as part of Bowser's galaxy creation scheme, stalwart plumber Mario must leap to her rescue, with the help of new celestial friends and powers.	\N
94	The Legend of Zelda: The Wind Waker	2002	E	9	After his sister gets kidnapped from their peaceful island, a young boy aims to emulate the Hero of Time by saving her.	\N
95	Day of the Tentacle	1993	E	8.9	A disembodied tentacle is accidentally exposed to nuclear waste, giving it human abilities and an ambition to take over the world.	\N
96	Baldur's Gate	1998	T	8.9	The main character, ward of mystical monk Gorion, whose name, sex, race and class are defined by the players, leaves his order's keep for the first time and starts a journey to discover his true identity. But someone wants him dead.	\N
97	Diablo II	2000	M	9	Evil has survived. Diablo, the Lord of Terror, now seeks to free his demonic brothers. The armies of Heaven are forbidden to interfere with his plan, so an Amazon, a Barbarian, a Necromancer, a Paladin and a Sorceresses join the battle.	\N
98	The Longest Journey	1999	M	8.9	April Ryan is a young visual-arts student in Venice, Newport. She's been having some strange dreams lately, but little does she know about the important role she'll have in changing the future.	\N
99	System Shock 2	1999	M	8.9	An agent is deployed on a mission to explore a distant planet, but instead wakes up from his cryosleep five months later only to discover that the ship's artificial intelligence has been corrupted and the humans infected by an alien race.	\N
100	StarCraft: Brood War	1998	T	9	After the events of StarCraft (1998) the Protoss try to unite their divided race while still fighting the weakened Zerg which is also attacked by human expedition from Earth.	\N
\.


--
-- Data for Name: videogame_genre; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.videogame_genre (videogame_id, genre_id) FROM stdin;
\.


--
-- Data for Name: videogame_platform; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.videogame_platform (videogame_id, platform_id) FROM stdin;
\.


--
-- Name: country_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.country_id_seq', 1, false);


--
-- Name: director_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.director_id_seq', 1, false);


--
-- Name: genre_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.genre_id_seq', 1, false);


--
-- Name: platform_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.platform_id_seq', 1, false);


--
-- Name: star_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.star_id_seq', 1, false);


--
-- Name: videogame_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.videogame_id_seq', 100, true);


--
-- Name: cast_credit cast_credit_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cast_credit
    ADD CONSTRAINT cast_credit_pkey PRIMARY KEY (videogame_id, star_id);


--
-- Name: country country_country_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.country
    ADD CONSTRAINT country_country_name_key UNIQUE (country_name);


--
-- Name: country country_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.country
    ADD CONSTRAINT country_pkey PRIMARY KEY (id);


--
-- Name: director_credit director_credit_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.director_credit
    ADD CONSTRAINT director_credit_pkey PRIMARY KEY (videogame_id, director_id);


--
-- Name: director director_director_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.director
    ADD CONSTRAINT director_director_name_key UNIQUE (director_name);


--
-- Name: director director_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.director
    ADD CONSTRAINT director_pkey PRIMARY KEY (id);


--
-- Name: genre genre_genre_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genre
    ADD CONSTRAINT genre_genre_name_key UNIQUE (genre_name);


--
-- Name: genre genre_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genre
    ADD CONSTRAINT genre_pkey PRIMARY KEY (id);


--
-- Name: platform platform_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_pkey PRIMARY KEY (id);


--
-- Name: platform platform_platform_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_platform_name_key UNIQUE (platform_name);


--
-- Name: star star_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_pkey PRIMARY KEY (id);


--
-- Name: star star_star_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_star_name_key UNIQUE (star_name);


--
-- Name: videogame_genre videogame_genre_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.videogame_genre
    ADD CONSTRAINT videogame_genre_pkey PRIMARY KEY (videogame_id, genre_id);


--
-- Name: videogame videogame_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.videogame
    ADD CONSTRAINT videogame_pkey PRIMARY KEY (id);


--
-- Name: videogame_platform videogame_platform_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.videogame_platform
    ADD CONSTRAINT videogame_platform_pkey PRIMARY KEY (videogame_id, platform_id);


--
-- Name: cast_credit cast_credit_star_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cast_credit
    ADD CONSTRAINT cast_credit_star_id_fkey FOREIGN KEY (star_id) REFERENCES public.star(id) ON DELETE CASCADE;


--
-- Name: cast_credit cast_credit_videogame_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cast_credit
    ADD CONSTRAINT cast_credit_videogame_id_fkey FOREIGN KEY (videogame_id) REFERENCES public.videogame(id) ON DELETE CASCADE;


--
-- Name: director_credit director_credit_director_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.director_credit
    ADD CONSTRAINT director_credit_director_id_fkey FOREIGN KEY (director_id) REFERENCES public.director(id) ON DELETE CASCADE;


--
-- Name: director_credit director_credit_videogame_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.director_credit
    ADD CONSTRAINT director_credit_videogame_id_fkey FOREIGN KEY (videogame_id) REFERENCES public.videogame(id) ON DELETE CASCADE;


--
-- Name: videogame videogame_country_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.videogame
    ADD CONSTRAINT videogame_country_id_fkey FOREIGN KEY (country_id) REFERENCES public.country(id);


--
-- Name: videogame_genre videogame_genre_genre_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.videogame_genre
    ADD CONSTRAINT videogame_genre_genre_id_fkey FOREIGN KEY (genre_id) REFERENCES public.genre(id) ON DELETE CASCADE;


--
-- Name: videogame_genre videogame_genre_videogame_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.videogame_genre
    ADD CONSTRAINT videogame_genre_videogame_id_fkey FOREIGN KEY (videogame_id) REFERENCES public.videogame(id) ON DELETE CASCADE;


--
-- Name: videogame_platform videogame_platform_platform_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.videogame_platform
    ADD CONSTRAINT videogame_platform_platform_id_fkey FOREIGN KEY (platform_id) REFERENCES public.platform(id) ON DELETE CASCADE;


--
-- Name: videogame_platform videogame_platform_videogame_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.videogame_platform
    ADD CONSTRAINT videogame_platform_videogame_id_fkey FOREIGN KEY (videogame_id) REFERENCES public.videogame(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

