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
-- Name: country; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.country (
    countryid integer NOT NULL,
    countryname character varying(100) NOT NULL
);


ALTER TABLE public.country OWNER TO postgres;

--
-- Name: country_countryid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.country_countryid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.country_countryid_seq OWNER TO postgres;

--
-- Name: country_countryid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.country_countryid_seq OWNED BY public.country.countryid;


--
-- Name: dimcountry; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dimcountry (
    countryid integer NOT NULL,
    countryname character varying(100) NOT NULL
);


ALTER TABLE public.dimcountry OWNER TO postgres;

--
-- Name: dimcountry_countryid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dimcountry_countryid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dimcountry_countryid_seq OWNER TO postgres;

--
-- Name: dimcountry_countryid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dimcountry_countryid_seq OWNED BY public.dimcountry.countryid;


--
-- Name: dimjob; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dimjob (
    jobsid integer NOT NULL,
    jobname character varying(100) NOT NULL
);


ALTER TABLE public.dimjob OWNER TO postgres;

--
-- Name: dimjob_jobsid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dimjob_jobsid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dimjob_jobsid_seq OWNER TO postgres;

--
-- Name: dimjob_jobsid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dimjob_jobsid_seq OWNED BY public.dimjob.jobsid;


--
-- Name: dimperson; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dimperson (
    personid integer NOT NULL,
    personname character varying(255) NOT NULL,
    rank integer
);


ALTER TABLE public.dimperson OWNER TO postgres;

--
-- Name: dimperson_personid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dimperson_personid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dimperson_personid_seq OWNER TO postgres;

--
-- Name: dimperson_personid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dimperson_personid_seq OWNED BY public.dimperson.personid;


--
-- Name: factperson; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.factperson (
    factpersonid integer NOT NULL,
    personid integer,
    jobsid integer,
    countryid integer,
    occurrence integer DEFAULT 1,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.factperson OWNER TO postgres;

--
-- Name: factperson_factpersonid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.factperson_factpersonid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.factperson_factpersonid_seq OWNER TO postgres;

--
-- Name: factperson_factpersonid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.factperson_factpersonid_seq OWNED BY public.factperson.factpersonid;


--
-- Name: job; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.job (
    jobsid integer NOT NULL,
    jobname character varying(100) NOT NULL
);


ALTER TABLE public.job OWNER TO postgres;

--
-- Name: job_jobsid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.job_jobsid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.job_jobsid_seq OWNER TO postgres;

--
-- Name: job_jobsid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.job_jobsid_seq OWNED BY public.job.jobsid;


--
-- Name: person; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.person (
    rank integer NOT NULL,
    personname character varying(255) NOT NULL,
    jobsid integer,
    countryid integer
);


ALTER TABLE public.person OWNER TO postgres;

--
-- Name: country countryid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.country ALTER COLUMN countryid SET DEFAULT nextval('public.country_countryid_seq'::regclass);


--
-- Name: dimcountry countryid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dimcountry ALTER COLUMN countryid SET DEFAULT nextval('public.dimcountry_countryid_seq'::regclass);


--
-- Name: dimjob jobsid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dimjob ALTER COLUMN jobsid SET DEFAULT nextval('public.dimjob_jobsid_seq'::regclass);


--
-- Name: dimperson personid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dimperson ALTER COLUMN personid SET DEFAULT nextval('public.dimperson_personid_seq'::regclass);


--
-- Name: factperson factpersonid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.factperson ALTER COLUMN factpersonid SET DEFAULT nextval('public.factperson_factpersonid_seq'::regclass);


--
-- Name: job jobsid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job ALTER COLUMN jobsid SET DEFAULT nextval('public.job_jobsid_seq'::regclass);


--
-- Data for Name: country; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.country (countryid, countryname) FROM stdin;
1	Korea
2	Rusia
3	Amerika Serikat
4	Thailand
5	Saudi Arabi
6	Kanada
7	Australia
8	Israel
9	Filipina
10	Paraguayan
11	Jepang
12	Portugal
13	Somali
14	Yaman
15	Indonesia
16	Norwegi
17	Swedia
18	Spanyol
19	Cuban
20	Uganda
21	Turki
22	Iran
23	China
24	Prancis
25	Brazil
26	Inggris-Thailand
27	Belarusian
28	Indonesian
29	India
30	Tunisia
31	Inggris
32	Argentina
33	Malaysia
34	Hong Kong
35	Italia
36	Thailand-Belgia
37	Greek
38	Inggris-India
39	Meksiko
40	Miss Universe India
\.


--
-- Data for Name: dimcountry; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dimcountry (countryid, countryname) FROM stdin;
1	Korea
2	Rusia
3	Amerika Serikat
4	Thailand
5	Saudi Arabi
6	Kanada
7	Australia
8	Israel
9	Filipina
10	Paraguayan
11	Jepang
12	Portugal
13	Somali
14	Yaman
15	Indonesia
16	Norwegi
17	Swedia
18	Spanyol
19	Cuban
20	Uganda
21	Turki
22	Iran
23	China
24	Prancis
25	Brazil
26	Inggris-Thailand
27	Belarusian
28	Indonesian
29	India
30	Tunisia
31	Inggris
32	Argentina
33	Malaysia
34	Hong Kong
35	Italia
36	Thailand-Belgia
37	Greek
38	Inggris-India
39	Meksiko
40	Miss Universe India
\.


--
-- Data for Name: dimjob; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dimjob (jobsid, jobname) FROM stdin;
1	eks Momoland idola
2	model
3	idola K-Pop
4	aktris dan model
5	penyanyi
6	pemain catur
7	aktris
8	model dan aktris
9	model dan penyanyi
10	idol
11	model dan desainer
12	vlogger
13	tenaga kesehatan
14	penyanyi dan penari
15	aktris dan penyanyi
16	attle
17	idola
18	aktris dan supermodel
19	atlet
20	aktris Greek actress
21	Miss Universe India
\.


--
-- Data for Name: dimperson; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dimperson (personid, personname, rank) FROM stdin;
1	Nancy Jewel McDonie	1
2	Dasha Taran	2
3	Sana Twice	3
4	Gal Gadot	4
5	Jasmine Tookes	5
6	Sitala	6
7	Eleen Suliman	7
8	Andrea Botez	8
9	Jisoo BLACKPINK	9
10	Savannah Clark	10
11	Tzuyu Twice	11
12	Rosé BLACKPINK	12
13	Yael Shelbia	13
14	Lisa BLACKPINK	14
15	Nana	15
16	Andrea Brillantes	16
17	Jeon Somi	17
18	Nadia Ferreira	18
19	Nana Owada	19
20	Chaeryeong ITZY	20
21	Ivana Alaoui	21
22	Alba Batista	22
23	Jenny	23
24	Yurina Gyoten	24
25	Sydney Sweeney	25
26	Emily May	26
27	Jang Wonyoung LE SSERAFIM	27
28	Liza Soberano	28
29	Halima Aden	29
30	Sorn	30
31	Mai Omar	31
32	Lyodra Ginting	32
33	Emily Neren	33
34	Kang Seulgi RED VELVET.	34
35	LiLi Rose	35
36	Danielle NEW JEANS	36
37	Berta Castane	37
38	Song Yuqi	38
39	Ana de Armas	39
40	HARVEY	40
41	Whitney Peak	41
42	Su Burcu Yazgi Coskun	42
43	Kimia Hosseini	43
44	Vienna Maryce	44
45	Janine Gutierrez	45
46	Ningning AESPA	46
47	Tian Xi Wei	47
48	Thylane Blondeau	48
49	Beby Tsabina	49
50	Minni (G) Idle	50
51	Desiree	51
52	Hande Erçel	52
53	Oktyabrina Maksimova	53
54	Rebecca Patricia Armstrong	54
55	Kwon Eun Bi	55
56	Sasha Song	56
57	Sandrinna Michelle Skornicki	57
58	Disha Patani	58
59	Kaylyn Slevin	59
60	Ahlem Fekih	60
61	Kazuha LE SSERAFIM	61
62	Halle Bailey	62
63	Phoebe Dynevor	63
64	YooA	64
65	Candela Gallo	65
66	Anna Jobling	66
67	Brielle Clark	67
68	Rainky Wai	68
69	Sheila Turkoru	69
70	Angourie Rice	70
71	Belle Mariano	71
72	Ayaka	72
73	Alice Pagani	73
74	Sadie Sink	74
75	Dita Karang Secret Number	75
76	Ella Balinska	76
77	Violette Wautier	77
78	Özge Yağız	78
79	Ariana Grande	79
80	Enfa Walaha	80
81	Julia Butters	81
82	Yeji ITZY	82
83	Emma Watson	83
84	Hina Yoshihara	84
85	Jourdan Dunn	85
86	Livvi Dunn	86
87	Ghouli Nazer	87
88	Klelia Andriolatou	88
89	Banita Sandhu	89
90	Margot Robbie	90
91	Chuu	91
92	Leni Klum	92
93	Jenna Coleman	93
94	Shuhua	94
95	Lupita Nyong'o	95
96	Lily-Rose Depp	96
97	Afra Saraçoğlu	97
98	Freen Sarocha	98
99	Harnaz Sandhu	99
100	Emilia Clarke	100
\.


--
-- Data for Name: factperson; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.factperson (factpersonid, personid, jobsid, countryid, occurrence, created_at) FROM stdin;
1	1	1	1	1	2025-08-08 20:20:30.846887
2	2	2	2	1	2025-08-08 20:20:30.846887
3	3	3	1	1	2025-08-08 20:20:30.846887
4	4	4	3	1	2025-08-08 20:20:30.846887
5	5	2	3	1	2025-08-08 20:20:30.846887
6	6	5	4	1	2025-08-08 20:20:30.846887
7	7	2	5	1	2025-08-08 20:20:30.846887
8	8	6	6	1	2025-08-08 20:20:30.846887
9	9	3	1	1	2025-08-08 20:20:30.846887
10	10	5	7	1	2025-08-08 20:20:30.846887
11	11	3	1	1	2025-08-08 20:20:30.846887
12	12	3	1	1	2025-08-08 20:20:30.846887
13	13	2	8	1	2025-08-08 20:20:30.846887
14	14	3	1	1	2025-08-08 20:20:30.846887
15	15	7	1	1	2025-08-08 20:20:30.846887
16	16	7	9	1	2025-08-08 20:20:30.846887
17	17	3	1	1	2025-08-08 20:20:30.846887
18	18	2	10	1	2025-08-08 20:20:30.846887
19	19	8	11	1	2025-08-08 20:20:30.846887
20	20	3	1	1	2025-08-08 20:20:30.846887
21	21	9	9	1	2025-08-08 20:20:30.846887
22	22	7	12	1	2025-08-08 20:20:30.846887
23	23	5	1	1	2025-08-08 20:20:30.846887
24	24	10	11	1	2025-08-08 20:20:30.846887
25	25	7	3	1	2025-08-08 20:20:30.846887
26	26	5	3	1	2025-08-08 20:20:30.846887
27	27	3	1	1	2025-08-08 20:20:30.846887
28	28	8	9	1	2025-08-08 20:20:30.846887
29	29	11	13	1	2025-08-08 20:20:30.846887
30	30	3	1	1	2025-08-08 20:20:30.846887
31	31	4	14	1	2025-08-08 20:20:30.846887
32	32	5	15	1	2025-08-08 20:20:30.846887
33	33	12	16	1	2025-08-08 20:20:30.846887
34	34	3	1	1	2025-08-08 20:20:30.846887
35	35	13	17	1	2025-08-08 20:20:30.846887
36	36	3	1	1	2025-08-08 20:20:30.846887
37	37	4	18	1	2025-08-08 20:20:30.846887
38	38	3	1	1	2025-08-08 20:20:30.846887
39	39	7	19	1	2025-08-08 20:20:30.846887
40	40	5	11	1	2025-08-08 20:20:30.846887
41	41	7	20	1	2025-08-08 20:20:30.846887
42	42	4	21	1	2025-08-08 20:20:30.846887
43	43	7	22	1	2025-08-08 20:20:30.846887
44	44	2	6	1	2025-08-08 20:20:30.846887
45	45	7	9	1	2025-08-08 20:20:30.846887
46	46	3	1	1	2025-08-08 20:20:30.846887
47	47	7	23	1	2025-08-08 20:20:30.846887
48	48	2	24	1	2025-08-08 20:20:30.846887
49	49	4	15	1	2025-08-08 20:20:30.846887
50	50	3	1	1	2025-08-08 20:20:30.846887
51	51	14	25	1	2025-08-08 20:20:30.846887
52	52	4	21	1	2025-08-08 20:20:30.846887
53	53	2	2	1	2025-08-08 20:20:30.846887
54	54	15	26	1	2025-08-08 20:20:30.846887
55	55	3	1	1	2025-08-08 20:20:30.846887
56	56	2	27	1	2025-08-08 20:20:30.846887
57	57	7	28	1	2025-08-08 20:20:30.846887
58	58	7	29	1	2025-08-08 20:20:30.846887
59	59	8	3	1	2025-08-08 20:20:30.846887
60	60	8	30	1	2025-08-08 20:20:30.846887
61	61	3	1	1	2025-08-08 20:20:30.846887
62	62	15	3	1	2025-08-08 20:20:30.846887
63	63	7	31	1	2025-08-08 20:20:30.846887
64	64	3	1	1	2025-08-08 20:20:30.846887
65	65	2	32	1	2025-08-08 20:20:30.846887
66	66	7	33	1	2025-08-08 20:20:30.846887
67	67	16	3	1	2025-08-08 20:20:30.846887
68	68	7	34	1	2025-08-08 20:20:30.846887
69	69	8	21	1	2025-08-08 20:20:30.846887
70	70	7	7	1	2025-08-08 20:20:30.846887
71	71	7	9	1	2025-08-08 20:20:30.846887
72	72	17	11	1	2025-08-08 20:20:30.846887
73	73	4	35	1	2025-08-08 20:20:30.846887
74	74	7	3	1	2025-08-08 20:20:30.846887
75	75	3	1	1	2025-08-08 20:20:30.846887
76	76	7	3	1	2025-08-08 20:20:30.846887
77	77	5	36	1	2025-08-08 20:20:30.846887
78	78	7	21	1	2025-08-08 20:20:30.846887
79	79	5	3	1	2025-08-08 20:20:30.846887
80	80	5	4	1	2025-08-08 20:20:30.846887
81	81	7	3	1	2025-08-08 20:20:30.846887
82	82	3	1	1	2025-08-08 20:20:30.846887
83	83	7	31	1	2025-08-08 20:20:30.846887
84	84	5	11	1	2025-08-08 20:20:30.846887
85	85	18	31	1	2025-08-08 20:20:30.846887
86	86	19	3	1	2025-08-08 20:20:30.846887
87	87	7	23	1	2025-08-08 20:20:30.846887
88	88	20	37	1	2025-08-08 20:20:30.846887
89	89	7	38	1	2025-08-08 20:20:30.846887
90	90	7	7	1	2025-08-08 20:20:30.846887
91	91	3	1	1	2025-08-08 20:20:30.846887
92	92	2	3	1	2025-08-08 20:20:30.846887
93	93	7	31	1	2025-08-08 20:20:30.846887
94	94	3	1	1	2025-08-08 20:20:30.846887
95	95	4	39	1	2025-08-08 20:20:30.846887
96	96	7	3	1	2025-08-08 20:20:30.846887
97	97	4	21	1	2025-08-08 20:20:30.846887
98	98	7	4	1	2025-08-08 20:20:30.846887
99	99	21	40	1	2025-08-08 20:20:30.846887
100	100	7	31	1	2025-08-08 20:20:30.846887
\.


--
-- Data for Name: job; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.job (jobsid, jobname) FROM stdin;
1	eks Momoland idola
2	model
3	idola K-Pop
4	aktris dan model
5	penyanyi
6	pemain catur
7	aktris
8	model dan aktris
9	model dan penyanyi
10	idol
11	model dan desainer
12	vlogger
13	tenaga kesehatan
14	penyanyi dan penari
15	aktris dan penyanyi
16	attle
17	idola
18	aktris dan supermodel
19	atlet
20	aktris Greek actress
21	Miss Universe India 
\.


--
-- Data for Name: person; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.person (rank, personname, jobsid, countryid) FROM stdin;
1	Nancy Jewel McDonie	1	1
2	Dasha Taran	2	2
3	Sana Twice	3	1
4	Gal Gadot	4	3
5	Jasmine Tookes	2	3
6	Sitala	5	4
7	Eleen Suliman	2	5
8	Andrea Botez	6	6
9	Jisoo BLACKPINK	3	1
10	Savannah Clark	5	7
11	Tzuyu Twice	3	1
12	Rosé BLACKPINK	3	1
13	Yael Shelbia	2	8
14	Lisa BLACKPINK	3	1
15	Nana	7	1
16	Andrea Brillantes	7	9
17	Jeon Somi	3	1
18	Nadia Ferreira	2	10
19	Nana Owada	8	11
20	Chaeryeong ITZY	3	1
21	Ivana Alaoui	9	9
22	Alba Batista	7	12
23	Jenny	5	1
24	Yurina Gyoten	10	11
25	Sydney Sweeney	7	3
26	Emily May	5	3
27	Jang Wonyoung LE SSERAFIM	3	1
28	Liza Soberano	8	9
29	Halima Aden	11	13
30	Sorn	3	1
31	Mai Omar	4	14
32	Lyodra Ginting	5	15
33	Emily Neren	12	16
34	Kang Seulgi RED VELVET.	3	1
35	LiLi Rose	13	17
36	Danielle NEW JEANS	3	1
37	Berta Castane	4	18
38	Song Yuqi	3	1
39	Ana de Armas	7	19
40	HARVEY	5	11
41	Whitney Peak	7	20
42	Su Burcu Yazgi Coskun	4	21
43	Kimia Hosseini	7	22
44	Vienna Maryce	2	6
45	Janine Gutierrez	7	9
46	Ningning AESPA	3	1
47	Tian Xi Wei	7	23
48	Thylane Blondeau	2	24
49	Beby Tsabina	4	15
50	Minni (G) Idle	3	1
51	Desiree	14	25
52	Hande Erçel	4	21
53	Oktyabrina Maksimova	2	2
54	Rebecca Patricia Armstrong	15	26
55	Kwon Eun Bi	3	1
56	Sasha Song	2	27
57	Sandrinna Michelle Skornicki	7	28
58	Disha Patani	7	29
59	Kaylyn Slevin	8	3
60	Ahlem Fekih	8	30
61	Kazuha LE SSERAFIM	3	1
62	Halle Bailey	15	3
63	Phoebe Dynevor	7	31
64	YooA	3	1
65	Candela Gallo	2	32
66	Anna Jobling	7	33
67	Brielle Clark	16	3
68	Rainky Wai	7	34
69	Sheila Turkoru	8	21
70	Angourie Rice	7	7
71	Belle Mariano	7	9
72	Ayaka	17	11
73	Alice Pagani	4	35
74	Sadie Sink	7	3
75	Dita Karang Secret Number	3	1
76	Ella Balinska	7	3
77	Violette Wautier	5	36
78	Özge Yağız	7	21
79	Ariana Grande	5	3
80	Enfa Walaha	5	4
81	Julia Butters	7	3
82	Yeji ITZY	3	1
83	Emma Watson	7	31
84	Hina Yoshihara	5	11
85	Jourdan Dunn	18	31
86	Livvi Dunn	19	3
87	Ghouli Nazer	7	23
88	Klelia Andriolatou	20	37
89	Banita Sandhu	7	38
90	Margot Robbie	7	7
91	Chuu	3	1
92	Leni Klum	2	3
93	Jenna Coleman	7	31
94	Shuhua	3	1
95	Lupita Nyong'o	4	39
96	Lily-Rose Depp	7	3
97	Afra Saraçoğlu	4	21
98	Freen Sarocha	7	4
99	Harnaz Sandhu	21	40
100	Emilia Clarke	7	31
\.


--
-- Name: country_countryid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.country_countryid_seq', 40, true);


--
-- Name: dimcountry_countryid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dimcountry_countryid_seq', 40, true);


--
-- Name: dimjob_jobsid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dimjob_jobsid_seq', 21, true);


--
-- Name: dimperson_personid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dimperson_personid_seq', 100, true);


--
-- Name: factperson_factpersonid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.factperson_factpersonid_seq', 100, true);


--
-- Name: job_jobsid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.job_jobsid_seq', 21, true);


--
-- Name: country country_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.country
    ADD CONSTRAINT country_pkey PRIMARY KEY (countryid);


--
-- Name: dimcountry dimcountry_countryname_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dimcountry
    ADD CONSTRAINT dimcountry_countryname_key UNIQUE (countryname);


--
-- Name: dimcountry dimcountry_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dimcountry
    ADD CONSTRAINT dimcountry_pkey PRIMARY KEY (countryid);


--
-- Name: dimjob dimjob_jobname_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dimjob
    ADD CONSTRAINT dimjob_jobname_key UNIQUE (jobname);


--
-- Name: dimjob dimjob_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dimjob
    ADD CONSTRAINT dimjob_pkey PRIMARY KEY (jobsid);


--
-- Name: dimperson dimperson_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dimperson
    ADD CONSTRAINT dimperson_pkey PRIMARY KEY (personid);


--
-- Name: factperson factperson_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.factperson
    ADD CONSTRAINT factperson_pkey PRIMARY KEY (factpersonid);


--
-- Name: job job_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job
    ADD CONSTRAINT job_pkey PRIMARY KEY (jobsid);


--
-- Name: person person_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.person
    ADD CONSTRAINT person_pkey PRIMARY KEY (rank);


--
-- Name: factperson factperson_countryid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.factperson
    ADD CONSTRAINT factperson_countryid_fkey FOREIGN KEY (countryid) REFERENCES public.dimcountry(countryid);


--
-- Name: factperson factperson_jobsid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.factperson
    ADD CONSTRAINT factperson_jobsid_fkey FOREIGN KEY (jobsid) REFERENCES public.dimjob(jobsid);


--
-- Name: factperson factperson_personid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.factperson
    ADD CONSTRAINT factperson_personid_fkey FOREIGN KEY (personid) REFERENCES public.dimperson(personid);


--
-- Name: person person_countryid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.person
    ADD CONSTRAINT person_countryid_fkey FOREIGN KEY (countryid) REFERENCES public.country(countryid);


--
-- Name: person person_jobsid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.person
    ADD CONSTRAINT person_jobsid_fkey FOREIGN KEY (jobsid) REFERENCES public.job(jobsid);


--
-- PostgreSQL database dump complete
--

