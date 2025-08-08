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
-- Name: job_jobsid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.job_jobsid_seq', 21, true);


--
-- Name: country country_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.country
    ADD CONSTRAINT country_pkey PRIMARY KEY (countryid);


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

