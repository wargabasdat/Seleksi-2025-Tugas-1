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
-- Name: gunung; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA gunung;


ALTER SCHEMA gunung OWNER TO postgres;

--
-- Name: SCHEMA gunung; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA gunung IS 'Skema ini menyimpan data terkait gunung yang dipetakan melewati proses scraping dan modelling untuk seleksi Lab Basis Data.';


--
-- Name: check_ketinggian_func(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.check_ketinggian_func() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NEW.ketinggian_m < 0 THEN
        RAISE EXCEPTION 'Ketinggian tidak boleh negatif';
    END IF;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.check_ketinggian_func() OWNER TO postgres;

--
-- Name: update_jumlah_gunung_func(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_jumlah_gunung_func() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
   Update pegunungan
   set jumlah_gunung = jumlah_gunung + 1
   where id = NEW.id_pegunungan;
   return new;
end;
$$;


ALTER FUNCTION public.update_jumlah_gunung_func() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: gunung; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.gunung (
    id_gunung integer NOT NULL,
    peringkat integer,
    nama_gunung character varying(100) NOT NULL,
    ketinggian_m integer,
    lintang double precision,
    bujur double precision,
    id_pegunungan integer
);


ALTER TABLE public.gunung OWNER TO postgres;

--
-- Name: gunung_id_gunung_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.gunung_id_gunung_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.gunung_id_gunung_seq OWNER TO postgres;

--
-- Name: gunung_id_gunung_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.gunung_id_gunung_seq OWNED BY public.gunung.id_gunung;


--
-- Name: iklim; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.iklim (
    id_iklim integer NOT NULL,
    deskripsi text,
    kecepatan_angin double precision,
    suhu_terendah double precision
);


ALTER TABLE public.iklim OWNER TO postgres;

--
-- Name: iklim_gunung; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.iklim_gunung (
    id_gunung integer NOT NULL,
    id_iklim integer NOT NULL
);


ALTER TABLE public.iklim_gunung OWNER TO postgres;

--
-- Name: iklim_id_iklim_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.iklim_id_iklim_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.iklim_id_iklim_seq OWNER TO postgres;

--
-- Name: iklim_id_iklim_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.iklim_id_iklim_seq OWNED BY public.iklim.id_iklim;


--
-- Name: kategori; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.kategori (
    id_gunung integer NOT NULL,
    nama_kategori character varying(100)
);


ALTER TABLE public.kategori OWNER TO postgres;

--
-- Name: lokasi_gunung; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lokasi_gunung (
    id_negara integer NOT NULL,
    id_gunung integer NOT NULL
);


ALTER TABLE public.lokasi_gunung OWNER TO postgres;

--
-- Name: negara; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.negara (
    id_negara integer NOT NULL,
    nama_negara character varying(100) NOT NULL,
    id_region integer
);


ALTER TABLE public.negara OWNER TO postgres;

--
-- Name: negara_id_negara_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.negara_id_negara_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.negara_id_negara_seq OWNER TO postgres;

--
-- Name: negara_id_negara_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.negara_id_negara_seq OWNED BY public.negara.id_negara;


--
-- Name: pegunungan; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pegunungan (
    id_pegunungan integer NOT NULL,
    nama character varying(100) NOT NULL,
    jumlah_gunung integer
);


ALTER TABLE public.pegunungan OWNER TO postgres;

--
-- Name: pegunungan_id_pegunungan_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pegunungan_id_pegunungan_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pegunungan_id_pegunungan_seq OWNER TO postgres;

--
-- Name: pegunungan_id_pegunungan_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pegunungan_id_pegunungan_seq OWNED BY public.pegunungan.id_pegunungan;


--
-- Name: pendakian; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pendakian (
    id_pendakian integer NOT NULL,
    id_gunung integer,
    jalur character varying(100),
    nama_tim character varying(100),
    tahun integer
);


ALTER TABLE public.pendakian OWNER TO postgres;

--
-- Name: pendakian_id_pendakian_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pendakian_id_pendakian_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pendakian_id_pendakian_seq OWNER TO postgres;

--
-- Name: pendakian_id_pendakian_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pendakian_id_pendakian_seq OWNED BY public.pendakian.id_pendakian;


--
-- Name: region; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.region (
    id_region integer NOT NULL,
    nama_wilayah character varying(100) NOT NULL
);


ALTER TABLE public.region OWNER TO postgres;

--
-- Name: region_id_region_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.region_id_region_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.region_id_region_seq OWNER TO postgres;

--
-- Name: region_id_region_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.region_id_region_seq OWNED BY public.region.id_region;


--
-- Name: gunung id_gunung; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gunung ALTER COLUMN id_gunung SET DEFAULT nextval('public.gunung_id_gunung_seq'::regclass);


--
-- Name: iklim id_iklim; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.iklim ALTER COLUMN id_iklim SET DEFAULT nextval('public.iklim_id_iklim_seq'::regclass);


--
-- Name: negara id_negara; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.negara ALTER COLUMN id_negara SET DEFAULT nextval('public.negara_id_negara_seq'::regclass);


--
-- Name: pegunungan id_pegunungan; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pegunungan ALTER COLUMN id_pegunungan SET DEFAULT nextval('public.pegunungan_id_pegunungan_seq'::regclass);


--
-- Name: pendakian id_pendakian; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pendakian ALTER COLUMN id_pendakian SET DEFAULT nextval('public.pendakian_id_pendakian_seq'::regclass);


--
-- Name: region id_region; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.region ALTER COLUMN id_region SET DEFAULT nextval('public.region_id_region_seq'::regclass);


--
-- Data for Name: gunung; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.gunung (id_gunung, peringkat, nama_gunung, ketinggian_m, lintang, bujur, id_pegunungan) FROM stdin;
1	1	Mount Everest	8849	27.983333333333334	86.91666666666667	1
2	1	Sagarmatha	8849	27.983333333333334	86.91666666666667	1
3	1	Chomolungma	8849	27.983333333333334	86.91666666666667	1
4	2	K2	8611	35.86666666666667	76.5	2
5	3	Kangchenjunga	8586	27.7	88.13333333333334	3
6	4	Lhotse	8516	27.95	86.91666666666667	1
7	5	Makalu	8485	27.883333333333333	87.08333333333333	1
8	6	Cho Oyu	8188	28.083333333333332	86.65	1
9	7	Dhaulagiri I	8167	28.683333333333334	83.48333333333333	4
10	8	Manaslu	8163	28.55	84.55	5
11	9	Nanga Parbat	8126	35.233333333333334	74.58333333333333	6
12	10	Annapurna I	8091	28.583333333333332	83.81666666666666	7
13	11	Gasherbrum I	8080	35.71666666666667	76.68333333333334	2
14	11	Hidden Peak	8080	35.71666666666667	76.68333333333334	2
15	11	K5	8080	35.71666666666667	76.68333333333334	2
16	12	Broad Peak	8051	35.8	76.56666666666666	2
17	13	Gasherbrum II	8035	35.75	76.65	2
18	13	K4	8035	35.75	76.65	2
19	14	Shishapangma	8027	28.35	85.76666666666667	8
20	14	Gosainthan	8027	28.35	85.76666666666667	8
21	15	Gyachung Kang	7952	28.083333333333332	86.73333333333333	1
22	16	Annapurna II	7937	28.533333333333335	84.11666666666666	7
23	17	Gasherbrum IV	7932	35.75	76.6	2
24	17	K3	7932	35.75	76.6	2
25	18	Himalchuli	7893	28.433333333333334	84.63333333333334	5
26	19	Distaghil Sar	7884	36.31666666666667	75.18333333333334	9
27	20	Ngadi Chuli	7871	28.5	84.56666666666666	5
28	21	Khunyang Chhish	7823	36.2	75.2	9
29	22	Masherbrum	7821	35.63333333333333	76.3	10
30	22	K1	7821	35.63333333333333	76.3	10
31	23	Nanda Devi	7816	30.366666666666667	79.96666666666667	11
32	24	Chomo Lonzo	7804	27.916666666666668	87.1	1
33	25	Batura Sar	7795	36.5	74.51666666666667	12
34	26	Rakaposhi	7788	36.13333333333333	74.48333333333333	13
35	27	Namcha Barwa	7782	29.616666666666667	95.05	14
36	28	Kanjut Sar	7760	36.2	75.41666666666667	9
37	29	Kamet	7756	30.916666666666668	79.58333333333333	11
38	30	Dhaulagiri II	7751	28.75	83.38333333333334	4
39	31	Saltoro Kangri	7742	35.38333333333333	76.83333333333333	15
40	31	K10	7742	35.38333333333333	76.83333333333333	15
41	32	Kumbhakarna	7711	27.666666666666668	88.03333333333333	3
42	32	Jannu	7711	27.666666666666668	88.03333333333333	3
43	33	Tirich Mir	7708	36.25	71.83333333333333	16
44	34	Gurla Mandhata	7694	30.433333333333334	81.28333333333333	17
45	35	Saser KangriI	7672	34.86666666666667	77.75	18
46	35	K22	7672	34.86666666666667	77.75	18
47	36	Chogolisa	7665	35.6	76.56666666666666	10
48	37	Kongur Tagh	7649	38.583333333333336	75.3	19
49	38	Shispare	7611	36.43333333333333	74.66666666666667	12
50	39	Trivor	7577	36.28333333333333	75.08333333333333	9
51	40	Gangkhar Puensum	7570	28.033333333333335	90.45	20
52	41	Gongga Shan	7556	29.583333333333332	101.86666666666666	21
53	41	Minya Konka	7556	29.583333333333332	101.86666666666666	21
54	42	Annapurna III	7555	28.583333333333332	83.98333333333333	7
55	43	Skyang Kangri	7545	35.916666666666664	76.56666666666666	2
56	44	Changtse	7543	28.016666666666666	86.9	1
57	45	Kula Kangri	7538	28.216666666666665	90.6	20
58	46	Kongur Tiube	7530	38.6	75.18333333333334	19
59	47	Mamostong Kangri	7516	35.13333333333333	77.56666666666666	22
60	48	Saser Kangri II E	7513	34.8	77.8	18
61	49	Muztagh Ata	7509	38.266666666666666	75.1	23
62	50	Ismoil Somoni Peak	7495	38.93333333333333	72	24
63	51	Saser Kangri III	7495	34.833333333333336	77.78333333333333	18
64	52	Noshaq	7492	36.416666666666664	71.81666666666666	16
65	53	Pumari Chhish	7492	36.2	75.25	9
66	54	Passu Sar	7476	36.483333333333334	74.58333333333333	12
67	55	Yukshin Gardan Sar	7469	36.25	75.36666666666666	9
68	56	Teram Kangri I	7462	35.56666666666667	77.06666666666666	25
69	57	Jongsong Peak	7462	27.866666666666667	88.13333333333334	3
70	58	Malubiting	7458	36	74.86666666666666	13
71	59	Gangapurna	7455	28.6	83.95	7
72	60	Jengish Chokusu	7439	42.03333333333333	80.11666666666666	26
73	60	Tömür	7439	42.03333333333333	80.11666666666666	26
74	60	Pik Pobedy	7439	42.03333333333333	80.11666666666666	26
75	61	K12	7428	35.28333333333333	77.01666666666667	15
76	62	Yangra	7422	28.383333333333333	85.11666666666666	27
77	62	Ganesh I	7422	28.383333333333333	85.11666666666666	27
78	63	Sia Kangri	7422	35.65	76.75	25
79	64	Momhil Sar	7414	36.31666666666667	75.03333333333333	9
80	65	Kabru N	7412	27.633333333333333	88.11666666666666	3
81	66	Skil Brum	7410	35.85	76.41666666666667	2
82	67	Haramosh Peak	7409	35.833333333333336	74.88333333333334	13
83	68	Istor-o-Nal	7403	36.36666666666667	71.88333333333334	16
84	69	Ghent Kangri	7401	35.516666666666666	76.8	15
85	70	Ultar	7388	36.38333333333333	74.71666666666667	12
86	71	Rimo I	7385	35.35	77.36666666666666	22
87	72	Churen Himal	7385	28.733333333333334	83.21666666666667	4
88	73	Teram Kangri III	7382	35.583333333333336	77.03333333333333	25
89	74	Sherpi Kangri	7380	35.45	76.76666666666667	15
90	75	Labuche Kang	7367	28.3	86.35	28
91	76	Kirat Chuli	7362	27.783333333333335	88.18333333333334	3
92	77	Saraghrar	7349	36.53333333333333	72.1	16
93	78	Jomolhari	7326	27.816666666666666	89.26666666666667	29
94	78	Chomo Lhari	7326	27.816666666666666	89.26666666666667	29
95	79	Chamlang	7321	27.766666666666666	86.96666666666667	1
96	80	Chongtar	7315	35.9	76.41666666666667	2
97	81	Baltoro Kangri	7312	35.63333333333333	76.66666666666667	10
98	82	Siguang Ri	7309	28.133333333333333	86.68333333333334	1
99	83	The Crown	7295	36.1	76.2	30
100	83	Huang Guan Shan	7295	36.1	76.2	30
101	84	Gyala Peri	7294	29.8	94.96666666666667	14
102	85	Porong Ri	7292	28.383333333333333	85.71666666666667	31
103	86	Baintha Brakk	7285	35.93333333333333	75.75	32
104	86	The Ogre	7285	35.93333333333333	75.75	32
105	87	Yutmaru Sar	7283	36.21666666666667	75.36666666666666	9
106	88	K6	7282	35.416666666666664	76.55	10
107	88	Baltistan Peak	7282	35.416666666666664	76.55	10
108	89	Kangpenqing	7281	28.55	85.53333333333333	33
109	89	Gang Benchhen	7281	28.55	85.53333333333333	33
110	90	Muztagh Tower	7276	35.81666666666667	76.35	2
111	91	Mana Peak	7272	30.866666666666667	79.6	11
112	92	Diran	7266	36.11666666666667	74.65	13
113	93	Labuche Kang III	7250	28.3	86.38333333333334	28
114	93	Labuche Kang East	7250	28.3	86.38333333333334	28
115	94	Putha Hiunchuli	7246	28.733333333333334	83.13333333333334	4
116	95	Apsarasas Kangri	7245	35.53333333333333	77.13333333333334	25
117	96	Mukut Parbat	7242	30.933333333333334	79.56666666666666	11
118	97	Rimo III	7233	35.36666666666667	77.35	22
119	98	Langtang Lirung	7227	28.25	85.51666666666667	31
120	99	Karjiang	7221	28.25	90.63333333333334	20
121	100	Annapurna Dakshin (Annapurna South)	7219	28.516666666666666	83.8	7
122	101	Khartaphu	7213	28.05	86.96666666666667	1
123	102	Tongshanjiabu	7207	28.183333333333334	89.95	34
124	103	Malangutti Sar	7207	36.35	75.13333333333334	9
125	104	Noijin Kangsang	7206	28.933333333333334	90.16666666666667	35
126	104	Norin Kang	7206	28.933333333333334	90.16666666666667	35
127	105	Langtang Ri	7205	28.366666666666667	85.68333333333334	31
128	106	Kangphu Kang	7204	28.15	90.06666666666666	34
129	106	Shimokangri	7204	28.15	90.06666666666666	34
130	107	Singhi Kangri	7202	35.583333333333336	76.98333333333333	25
131	108	Lupghar Sar	7200	36.35	75.03333333333333	9
\.


--
-- Data for Name: iklim; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.iklim (id_iklim, deskripsi, kecepatan_angin, suhu_terendah) FROM stdin;
\.


--
-- Data for Name: iklim_gunung; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.iklim_gunung (id_gunung, id_iklim) FROM stdin;
\.


--
-- Data for Name: kategori; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.kategori (id_gunung, nama_kategori) FROM stdin;
\.


--
-- Data for Name: lokasi_gunung; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.lokasi_gunung (id_negara, id_gunung) FROM stdin;
1	1
2	1
1	2
2	2
1	3
2	3
3	4
2	4
1	5
4	5
2	6
1	6
1	7
2	7
2	8
1	8
1	9
1	10
3	11
1	12
3	13
2	13
3	14
2	14
3	15
2	15
3	16
2	16
3	17
2	17
3	18
2	18
2	19
2	20
1	21
2	21
1	22
3	23
3	24
1	25
3	26
1	27
3	28
3	29
3	30
4	31
2	32
3	33
3	34
2	35
3	36
4	37
1	38
3	39
4	39
3	40
4	40
1	41
1	42
3	43
2	44
4	45
4	46
3	47
2	48
3	49
3	50
5	51
2	51
2	52
2	53
1	54
3	55
2	55
2	56
2	57
5	57
2	58
4	59
4	60
2	61
6	62
4	63
7	64
3	64
3	65
3	66
3	67
2	68
4	68
4	69
2	69
1	69
3	70
1	71
8	72
2	72
8	73
2	73
8	74
2	74
3	75
4	75
2	76
1	76
2	77
1	77
3	78
2	78
3	79
4	80
1	80
3	81
3	82
3	83
3	84
4	84
3	85
4	86
1	87
4	88
2	88
3	89
2	90
1	91
4	91
3	92
5	93
2	93
5	94
2	94
1	95
2	96
3	97
2	98
2	99
2	100
2	101
2	102
3	103
3	104
3	105
3	106
3	107
2	108
2	109
3	110
2	110
4	111
3	112
2	113
2	114
1	115
4	116
2	116
4	117
2	117
4	118
1	119
2	120
1	121
2	122
5	123
2	123
3	124
2	125
2	126
1	127
2	127
5	128
2	128
5	129
2	129
4	130
2	130
3	131
\.


--
-- Data for Name: negara; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.negara (id_negara, nama_negara, id_region) FROM stdin;
1	Nepal	\N
2	China	\N
3	Pakistan	\N
4	India	\N
5	Bhutan	\N
6	Tajikistan	\N
7	Afghanistan	\N
8	Kyrgyzstan	\N
\.


--
-- Data for Name: pegunungan; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pegunungan (id_pegunungan, nama, jumlah_gunung) FROM stdin;
1	Mahalangur Himalaya	12
2	Baltoro Karakoram	13
3	Kangchenjunga Himalaya	6
4	Dhaulagiri Himalaya	4
5	Manaslu Himalaya	3
6	Nanga Parbat Himalaya	1
7	Annapurna Himalaya	5
8	Jugal Himalaya	2
9	Hispar Karakoram	10
10	Masherbrum Karakoram	6
11	Garhwal Himalaya	4
12	Batura Karakoram	4
13	Rakaposhi-Haramosh Karakoram	4
14	Assam Himalaya	2
15	Saltoro Karakoram	5
16	Hindu Kush	4
17	Nalakankar Himalaya	1
18	Saser Karakoram	4
19	Kongur Shan (Eastern Pamirs)	2
20	Kula Kangri Himalaya	3
21	Daxue Mountains (Hengduan Shan)	2
22	Rimo Karakoram	3
23	Muztagata (Eastern Pamirs)	1
24	Pamir (Academy of Sciences Range)	1
25	Siachen Karakoram	5
26	Tian Shan	3
27	Ganesh Himalaya	2
28	Labuche Himalaya	3
29	Jomolhari Himalaya	2
30	Yengisogat Karakoram	2
31	Langtang Himalaya	3
32	Panmah Karakoram	2
33	Himalaya	2
34	Lunana Himalaya	3
35	Nagarze Himalaya	2
\.


--
-- Data for Name: pendakian; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pendakian (id_pendakian, id_gunung, jalur, nama_tim, tahun) FROM stdin;
\.


--
-- Data for Name: region; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.region (id_region, nama_wilayah) FROM stdin;
\.


--
-- Name: gunung_id_gunung_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.gunung_id_gunung_seq', 1, false);


--
-- Name: iklim_id_iklim_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.iklim_id_iklim_seq', 1, false);


--
-- Name: negara_id_negara_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.negara_id_negara_seq', 1, false);


--
-- Name: pegunungan_id_pegunungan_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pegunungan_id_pegunungan_seq', 1, false);


--
-- Name: pendakian_id_pendakian_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pendakian_id_pendakian_seq', 1, false);


--
-- Name: region_id_region_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.region_id_region_seq', 1, false);


--
-- Name: gunung gunung_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gunung
    ADD CONSTRAINT gunung_pkey PRIMARY KEY (id_gunung);


--
-- Name: iklim_gunung iklim_gunung_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.iklim_gunung
    ADD CONSTRAINT iklim_gunung_pkey PRIMARY KEY (id_gunung, id_iklim);


--
-- Name: iklim iklim_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.iklim
    ADD CONSTRAINT iklim_pkey PRIMARY KEY (id_iklim);


--
-- Name: kategori kategori_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kategori
    ADD CONSTRAINT kategori_pkey PRIMARY KEY (id_gunung);


--
-- Name: lokasi_gunung lokasi_gunung_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lokasi_gunung
    ADD CONSTRAINT lokasi_gunung_pkey PRIMARY KEY (id_negara, id_gunung);


--
-- Name: negara negara_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.negara
    ADD CONSTRAINT negara_pkey PRIMARY KEY (id_negara);


--
-- Name: pegunungan pegunungan_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pegunungan
    ADD CONSTRAINT pegunungan_pkey PRIMARY KEY (id_pegunungan);


--
-- Name: pendakian pendakian_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pendakian
    ADD CONSTRAINT pendakian_pkey PRIMARY KEY (id_pendakian);


--
-- Name: region region_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.region
    ADD CONSTRAINT region_pkey PRIMARY KEY (id_region);


--
-- Name: gunung check_ketinggian; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER check_ketinggian BEFORE INSERT ON public.gunung FOR EACH ROW EXECUTE FUNCTION public.check_ketinggian_func();


--
-- Name: gunung update_jumlah_gunung; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_jumlah_gunung AFTER INSERT ON public.gunung FOR EACH ROW EXECUTE FUNCTION public.update_jumlah_gunung_func();


--
-- Name: gunung gunung_id_pegunungan_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gunung
    ADD CONSTRAINT gunung_id_pegunungan_fkey FOREIGN KEY (id_pegunungan) REFERENCES public.pegunungan(id_pegunungan) ON DELETE SET NULL;


--
-- Name: iklim_gunung iklim_gunung_id_gunung_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.iklim_gunung
    ADD CONSTRAINT iklim_gunung_id_gunung_fkey FOREIGN KEY (id_gunung) REFERENCES public.gunung(id_gunung) ON DELETE CASCADE;


--
-- Name: iklim_gunung iklim_gunung_id_iklim_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.iklim_gunung
    ADD CONSTRAINT iklim_gunung_id_iklim_fkey FOREIGN KEY (id_iklim) REFERENCES public.iklim(id_iklim) ON DELETE CASCADE;


--
-- Name: kategori kategori_id_gunung_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kategori
    ADD CONSTRAINT kategori_id_gunung_fkey FOREIGN KEY (id_gunung) REFERENCES public.gunung(id_gunung) ON DELETE CASCADE;


--
-- Name: lokasi_gunung lokasi_gunung_id_gunung_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lokasi_gunung
    ADD CONSTRAINT lokasi_gunung_id_gunung_fkey FOREIGN KEY (id_gunung) REFERENCES public.gunung(id_gunung) ON DELETE CASCADE;


--
-- Name: lokasi_gunung lokasi_gunung_id_negara_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lokasi_gunung
    ADD CONSTRAINT lokasi_gunung_id_negara_fkey FOREIGN KEY (id_negara) REFERENCES public.negara(id_negara) ON DELETE CASCADE;


--
-- Name: negara negara_id_region_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.negara
    ADD CONSTRAINT negara_id_region_fkey FOREIGN KEY (id_region) REFERENCES public.region(id_region) ON DELETE SET NULL;


--
-- Name: pendakian pendakian_id_gunung_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pendakian
    ADD CONSTRAINT pendakian_id_gunung_fkey FOREIGN KEY (id_gunung) REFERENCES public.gunung(id_gunung) ON DELETE SET NULL;


--
-- PostgreSQL database dump complete
--

