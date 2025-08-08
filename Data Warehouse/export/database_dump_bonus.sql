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
-- Name: brands; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.brands (
    brand_id integer NOT NULL,
    brand_name character varying(100) NOT NULL
);


ALTER TABLE public.brands OWNER TO postgres;

--
-- Name: brands_brand_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.brands_brand_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.brands_brand_id_seq OWNER TO postgres;

--
-- Name: brands_brand_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.brands_brand_id_seq OWNED BY public.brands.brand_id;


--
-- Name: camera_video_capabilities; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.camera_video_capabilities (
    camera_id integer NOT NULL,
    resolution_id integer NOT NULL
);


ALTER TABLE public.camera_video_capabilities OWNER TO postgres;

--
-- Name: cameras; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cameras (
    camera_id integer NOT NULL,
    name character varying(255),
    model character varying(100),
    launch_date date,
    launch_price_usd integer,
    pixel_depth_mp numeric(4,1),
    brand_id integer,
    format_id integer,
    mount_id integer
);


ALTER TABLE public.cameras OWNER TO postgres;

--
-- Name: dim_brands; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dim_brands (
    brand_key integer NOT NULL,
    brand_name character varying(100) NOT NULL
);


ALTER TABLE public.dim_brands OWNER TO postgres;

--
-- Name: dim_brands_brand_key_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dim_brands_brand_key_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dim_brands_brand_key_seq OWNER TO postgres;

--
-- Name: dim_brands_brand_key_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dim_brands_brand_key_seq OWNED BY public.dim_brands.brand_key;


--
-- Name: dim_cameras; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dim_cameras (
    camera_key integer NOT NULL,
    camera_id integer NOT NULL,
    name character varying(255),
    model character varying(100)
);


ALTER TABLE public.dim_cameras OWNER TO postgres;

--
-- Name: dim_cameras_camera_key_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dim_cameras_camera_key_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dim_cameras_camera_key_seq OWNER TO postgres;

--
-- Name: dim_cameras_camera_key_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dim_cameras_camera_key_seq OWNED BY public.dim_cameras.camera_key;


--
-- Name: dim_sensor_formats; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dim_sensor_formats (
    format_key integer NOT NULL,
    format_name character varying(50) NOT NULL
);


ALTER TABLE public.dim_sensor_formats OWNER TO postgres;

--
-- Name: dim_sensor_formats_format_key_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dim_sensor_formats_format_key_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dim_sensor_formats_format_key_seq OWNER TO postgres;

--
-- Name: dim_sensor_formats_format_key_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dim_sensor_formats_format_key_seq OWNED BY public.dim_sensor_formats.format_key;


--
-- Name: dim_time; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dim_time (
    time_key integer NOT NULL,
    full_date date NOT NULL,
    year integer NOT NULL,
    quarter integer NOT NULL,
    month integer NOT NULL,
    day integer NOT NULL
);


ALTER TABLE public.dim_time OWNER TO postgres;

--
-- Name: fact_camera_performance; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fact_camera_performance (
    camera_key integer,
    brand_key integer,
    format_key integer,
    time_key integer,
    launch_price_usd integer,
    pixel_depth_mp numeric(4,1),
    overall_score integer,
    portrait_score numeric(4,1),
    landscape_score numeric(4,1),
    sports_score integer
);


ALTER TABLE public.fact_camera_performance OWNER TO postgres;

--
-- Name: lens_mounts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lens_mounts (
    mount_id integer NOT NULL,
    mount_name character varying(100) NOT NULL
);


ALTER TABLE public.lens_mounts OWNER TO postgres;

--
-- Name: lens_mounts_mount_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.lens_mounts_mount_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.lens_mounts_mount_id_seq OWNER TO postgres;

--
-- Name: lens_mounts_mount_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.lens_mounts_mount_id_seq OWNED BY public.lens_mounts.mount_id;


--
-- Name: lenses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lenses (
    lens_id integer NOT NULL,
    lens_name character varying(255) NOT NULL,
    brand character varying(100),
    price_usd integer,
    aperture character varying(50),
    focal_length character varying(50),
    stabilization boolean,
    mount_id integer
);


ALTER TABLE public.lenses OWNER TO postgres;

--
-- Name: lenses_lens_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.lenses_lens_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.lenses_lens_id_seq OWNER TO postgres;

--
-- Name: lenses_lens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.lenses_lens_id_seq OWNED BY public.lenses.lens_id;


--
-- Name: scores; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scores (
    score_id integer NOT NULL,
    camera_id integer NOT NULL,
    score_type character varying(50),
    score_value numeric(10,1)
);


ALTER TABLE public.scores OWNER TO postgres;

--
-- Name: sensor_formats; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sensor_formats (
    format_id integer NOT NULL,
    format_name character varying(50) NOT NULL
);


ALTER TABLE public.sensor_formats OWNER TO postgres;

--
-- Name: sensor_formats_format_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sensor_formats_format_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sensor_formats_format_id_seq OWNER TO postgres;

--
-- Name: sensor_formats_format_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sensor_formats_format_id_seq OWNED BY public.sensor_formats.format_id;


--
-- Name: video_resolutions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.video_resolutions (
    resolution_id integer NOT NULL,
    resolution_name character varying(50) NOT NULL,
    max_fps integer
);


ALTER TABLE public.video_resolutions OWNER TO postgres;

--
-- Name: video_resolutions_resolution_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.video_resolutions_resolution_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.video_resolutions_resolution_id_seq OWNER TO postgres;

--
-- Name: video_resolutions_resolution_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.video_resolutions_resolution_id_seq OWNED BY public.video_resolutions.resolution_id;


--
-- Name: brands brand_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.brands ALTER COLUMN brand_id SET DEFAULT nextval('public.brands_brand_id_seq'::regclass);


--
-- Name: dim_brands brand_key; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_brands ALTER COLUMN brand_key SET DEFAULT nextval('public.dim_brands_brand_key_seq'::regclass);


--
-- Name: dim_cameras camera_key; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_cameras ALTER COLUMN camera_key SET DEFAULT nextval('public.dim_cameras_camera_key_seq'::regclass);


--
-- Name: dim_sensor_formats format_key; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_sensor_formats ALTER COLUMN format_key SET DEFAULT nextval('public.dim_sensor_formats_format_key_seq'::regclass);


--
-- Name: lens_mounts mount_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lens_mounts ALTER COLUMN mount_id SET DEFAULT nextval('public.lens_mounts_mount_id_seq'::regclass);


--
-- Name: lenses lens_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lenses ALTER COLUMN lens_id SET DEFAULT nextval('public.lenses_lens_id_seq'::regclass);


--
-- Name: sensor_formats format_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sensor_formats ALTER COLUMN format_id SET DEFAULT nextval('public.sensor_formats_format_id_seq'::regclass);


--
-- Name: video_resolutions resolution_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.video_resolutions ALTER COLUMN resolution_id SET DEFAULT nextval('public.video_resolutions_resolution_id_seq'::regclass);


--
-- Data for Name: brands; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.brands (brand_id, brand_name) FROM stdin;
1	Leica
2	Pixii
3	Phase One
4	Sony
5	Samsung
6	Canon
7	DJI
8	Nikon
9	Pentax
10	Hasselblad
11	Panasonic
\.


--
-- Data for Name: camera_video_capabilities; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.camera_video_capabilities (camera_id, resolution_id) FROM stdin;
\.


--
-- Data for Name: cameras; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cameras (camera_id, name, model, launch_date, launch_price_usd, pixel_depth_mp, brand_id, format_id, mount_id) FROM stdin;
1	Hasselblad X1D-50c	X1D-50c	2016-06-22	8995	50.0	10	2	\N
2	Pentax 645Z	645Z	2014-04-15	8499	51.4	9	2	\N
3	Leica M11	M11	2022-01-13	8350	60.3	1	1	\N
4	Nikon Z7II	Z7II	2020-10-14	3399	45.8	8	1	\N
5	Nikon D850	D850	2017-08-23	3300	45.7	8	1	\N
6	Panasonic Lumix DC-S1R	Lumix DC-S1R	2019-02-01	3700	47.3	11	1	\N
7	Sony A7R V	A7R V	2022-10-26	3900	60.0	4	1	\N
8	Sony A7R III	A7R III	2017-10-25	3200	42.4	4	1	\N
9	Nikon Z7	Z7	2018-08-23	3400	45.7	8	1	\N
10	Sony A7R IV	A7R IV	2019-07-16	3500	61.2	4	1	\N
11	Nikon Z8	Z8	2023-05-25	4000	45.7	8	1	\N
12	Nikon Z9	Z9	2021-12-24	5999	45.7	8	1	\N
13	Sony A1	A1	2021-01-26	6499	50.1	4	1	\N
14	Sony A7R II	A7R II	2015-06-10	3198	42.4	4	1	\N
15	Nikon D810	D810	2014-06-26	3300	36.3	8	1	\N
16	Sony A7IV	A7IV	2021-12-23	2800	33.0	4	1	\N
17	Sony Cyber-shot DSC-RX1R II	Cyber-shot DSC-RX1R II	2015-10-14	3300	42.4	4	1	\N
18	Canon EOS R3	EOS R3	2021-09-14	5999	24.1	6	1	\N
19	Leica Q2	Q2	2019-03-07	5000	47.3	1	1	\N
20	Nikon D800E	D800E	2012-02-07	3300	36.3	8	1	\N
21	Pentax K-1	K-1	2016-02-17	1800	36.4	9	1	\N
22	Sony A7 III	A7 III	2018-02-27	2000	24.2	4	1	\N
23	Canon EOS R5	EOS R5	2020-07-30	4499	45.0	6	1	\N
24	Leica SL2-S	SL2-S	2020-12-10	4895	24.6	1	1	\N
25	Nikon Z6	Z6	2018-08-23	2000	24.5	8	1	\N
26	Nikon D800	D800	2012-02-07	2999	36.3	8	1	\N
27	Panasonic Lumix DC-S1	Lumix DC-S1	2019-02-01	2500	24.2	11	1	\N
28	Sony A7C	A7C	2020-11-01	1799	24.2	4	1	\N
29	Sony A7R	A7R	2013-10-16	2300	36.0	4	1	\N
30	Nikon Z6II	Z6II	2020-10-14	1995	24.5	8	1	\N
31	Nikon D610	D610	2013-10-08	1999	24.0	8	1	\N
32	Nikon D600	D600	2012-09-13	2100	24.3	8	1	\N
33	Panasonic Lumix DCS5	Lumix DCS5	2021-02-09	1999	24.2	11	1	\N
34	Canon EOS R8	EOS R8	2023-02-08	1499	24.2	6	1	\N
35	Nikon D750	D750	2014-09-12	2300	24.3	8	1	\N
36	Pixii Max	Max	2024-11-01	3999	24.5	2	1	\N
37	Sony a9 II	a9 II	2019-10-03	4500	24.2	4	1	\N
38	Sony Cyber-shot DSC-RX1	Cyber-shot DSC-RX1	2012-09-12	2800	24.3	4	1	\N
39	Sony a9	a9	2017-04-19	4500	24.2	4	1	\N
40	Sony SLT Alpha 99 II	SLT Alpha 99 II	2016-09-19	3200	42.4	4	1	\N
41	Canon  EOS-1D X Mark III	 EOS-1D X Mark III	2020-01-07	6500	20.1	6	1	\N
42	Canon EOS 5D Mark IV	EOS 5D Mark IV	2016-08-25	3500	30.4	6	1	\N
43	Phase One IQ180 Digital Back	IQ180 Digital Back	2011-01-24	42490	80.0	3	2	\N
44	Sony Cyber-shot DSC-RX1R	Cyber-shot DSC-RX1R	2013-06-27	2800	24.3	4	1	\N
45	Canon EOS R6	EOS R6	2020-08-27	2499	20.1	6	1	\N
46	Pixii A1571	A1571	2021-09-27	2999	26.0	2	3	\N
47	Sony A7 II	A7 II	2014-11-20	1600	24.3	4	1	\N
48	Sony A7	A7	2013-10-16	1700	24.0	4	1	\N
49	Canon EOS R	EOS R	2018-09-05	2300	30.3	6	1	\N
50	Nikon D4s	D4s	2014-02-25	6500	16.2	8	1	\N
51	Nikon Df	Df	2013-11-05	2749	16.2	8	1	\N
52	Nikon D4	D4	2012-01-06	5999	16.2	8	1	\N
53	Phase One P65 Plus	P65 Plus	2008-07-14	39900	60.5	3	2	\N
54	Sony SLT Alpha 99	SLT Alpha 99	2012-09-12	2800	24.3	4	1	\N
55	Canon  EOS-1D X Mark II	 EOS-1D X Mark II	2016-02-02	6000	20.2	6	1	\N
56	Leica SL (Typ 601)	SL (Typ 601)	2015-10-20	7450	24.0	1	1	\N
57	Nikon D5	D5	2016-01-06	6500	20.8	8	1	\N
58	Nikon D3X	D3X	2008-12-01	9172	24.5	8	1	\N
59	Canon EOS 5DS	EOS 5DS	2015-02-06	3700	50.6	6	1	\N
60	Nikon D7200	D7200	2015-03-02	1200	24.2	8	3	\N
61	Phase One P40 Plus	P40 Plus	2009-04-29	19500	40.0	3	2	\N
62	Samsung NX500	NX500	2015-02-05	800	28.0	5	3	\N
63	Sony A9 III	A9 III	2023-11-08	5999	24.6	4	1	\N
64	Sony A7S	A7S	2014-04-06	2499	12.2	4	1	\N
65	Canon EOS 5DS R	EOS 5DS R	2015-02-06	3900	50.6	6	1	\N
66	DJI Zenmuse X7	Zenmuse X7	2017-10-11	2700	24.0	7	3	\N
67	Leica M10	M10	2017-01-18	6895	24.0	1	1	\N
68	Nikon D7500	D7500	2017-04-12	1250	20.9	8	3	\N
69	Nikon D3400	D3400	2016-08-17	650	24.2	8	3	\N
70	Sony A7SIII	A7SIII	2020-07-28	3499	12.1	4	1	\N
71	Canon EOS RP	EOS RP	2019-02-14	1300	26.0	6	1	\N
72	Canon EOS 6D Mark II	EOS 6D Mark II	2017-06-29	2000	26.2	6	1	\N
73	Leica Q Typ 116	Q Typ 116	2015-06-10	4250	24.2	1	1	\N
74	Sony A6500	A6500	2016-10-06	1400	24.2	4	3	\N
75	Sony A6300	A6300	2016-02-03	1000	24.2	4	3	\N
76	Sony A7S II	A7S II	2015-09-11	3000	12.2	4	1	\N
77	Leica M Typ 240	M Typ 240	2012-09-17	6950	24.0	1	1	\N
78	Nikon D5600	D5600	2016-11-10	700	24.2	8	3	\N
79	Nikon D500	D500	2016-01-06	2000	20.9	8	3	\N
80	Nikon D5500	D5500	2015-01-06	900	24.2	8	3	\N
81	Nikon D5200	D5200	2012-11-06	897	24.1	8	3	\N
82	Nikon D5300	D5300	2013-10-17	800	24.2	8	3	\N
83	Nikon D7100	D7100	2013-02-21	1200	24.1	8	3	\N
84	Samsung NX1	NX1	2014-09-15	1500	28.2	5	3	\N
85	Sony A6400	A6400	2019-01-15	900	24.2	4	3	\N
86	Canon EOS 6D	EOS 6D	2012-09-17	2099	20.2	6	1	\N
87	Canon EOS 1Dx	EOS 1Dx	2011-10-18	6800	18.1	6	1	\N
88	Nikon D3300	D3300	2014-01-07	650	24.2	8	3	\N
89	Nikon D3s	D3s	2009-10-14	5510	12.1	8	1	\N
90	Pentax K-5 II	K-5 II	2012-09-11	999	16.3	9	3	\N
91	Pentax K-5 IIs	K-5 IIs	2012-09-11	1199	16.3	9	3	\N
92	Pentax K5	K5	2010-09-20	1600	16.3	9	3	\N
93	Pentax 645D	645D	2010-03-01	9400	40.0	9	2	\N
94	Sony A6600	A6600	2019-08-28	1200	24.2	4	3	\N
95	Sony SLT Alpha 77 II	SLT Alpha 77 II	2014-05-01	1200	24.3	4	3	\N
96	Sony A6000	A6000	2014-02-12	799	24.3	4	3	\N
97	Canon EOS 5D Mark III	EOS 5D Mark III	2012-03-02	3499	22.3	6	1	\N
98	Nikon D3200	D3200	2012-04-19	699	24.2	8	3	\N
99	Nikon D3	D3	2007-08-23	4300	12.1	8	1	\N
100	Sony NEX-7	NEX-7	2011-08-24	1720	24.3	4	3	\N
\.


--
-- Data for Name: dim_brands; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dim_brands (brand_key, brand_name) FROM stdin;
1	Leica
2	Pixii
3	Phase One
4	Sony
5	Samsung
6	Canon
7	DJI
8	Nikon
9	Pentax
10	Hasselblad
11	Panasonic
\.


--
-- Data for Name: dim_cameras; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dim_cameras (camera_key, camera_id, name, model) FROM stdin;
1	1	Hasselblad X1D-50c	X1D-50c
2	2	Pentax 645Z	645Z
3	3	Leica M11	M11
4	4	Nikon Z7II	Z7II
5	5	Nikon D850	D850
6	6	Panasonic Lumix DC-S1R	Lumix DC-S1R
7	7	Sony A7R V	A7R V
8	8	Sony A7R III	A7R III
9	9	Nikon Z7	Z7
10	10	Sony A7R IV	A7R IV
11	11	Nikon Z8	Z8
12	12	Nikon Z9	Z9
13	13	Sony A1	A1
14	14	Sony A7R II	A7R II
15	15	Nikon D810	D810
16	16	Sony A7IV	A7IV
17	17	Sony Cyber-shot DSC-RX1R II	Cyber-shot DSC-RX1R II
18	18	Canon EOS R3	EOS R3
19	19	Leica Q2	Q2
20	20	Nikon D800E	D800E
21	21	Pentax K-1	K-1
22	22	Sony A7 III	A7 III
23	23	Canon EOS R5	EOS R5
24	24	Leica SL2-S	SL2-S
25	25	Nikon Z6	Z6
26	26	Nikon D800	D800
27	27	Panasonic Lumix DC-S1	Lumix DC-S1
28	28	Sony A7C	A7C
29	29	Sony A7R	A7R
30	30	Nikon Z6II	Z6II
31	31	Nikon D610	D610
32	32	Nikon D600	D600
33	33	Panasonic Lumix DCS5	Lumix DCS5
34	34	Canon EOS R8	EOS R8
35	35	Nikon D750	D750
36	36	Pixii Max	Max
37	37	Sony a9 II	a9 II
38	38	Sony Cyber-shot DSC-RX1	Cyber-shot DSC-RX1
39	39	Sony a9	a9
40	40	Sony SLT Alpha 99 II	SLT Alpha 99 II
41	41	Canon  EOS-1D X Mark III	 EOS-1D X Mark III
42	42	Canon EOS 5D Mark IV	EOS 5D Mark IV
43	43	Phase One IQ180 Digital Back	IQ180 Digital Back
44	44	Sony Cyber-shot DSC-RX1R	Cyber-shot DSC-RX1R
45	45	Canon EOS R6	EOS R6
46	46	Pixii A1571	A1571
47	47	Sony A7 II	A7 II
48	48	Sony A7	A7
49	49	Canon EOS R	EOS R
50	50	Nikon D4s	D4s
51	51	Nikon Df	Df
52	52	Nikon D4	D4
53	53	Phase One P65 Plus	P65 Plus
54	54	Sony SLT Alpha 99	SLT Alpha 99
55	55	Canon  EOS-1D X Mark II	 EOS-1D X Mark II
56	56	Leica SL (Typ 601)	SL (Typ 601)
57	57	Nikon D5	D5
58	58	Nikon D3X	D3X
59	59	Canon EOS 5DS	EOS 5DS
60	60	Nikon D7200	D7200
61	61	Phase One P40 Plus	P40 Plus
62	62	Samsung NX500	NX500
63	63	Sony A9 III	A9 III
64	64	Sony A7S	A7S
65	65	Canon EOS 5DS R	EOS 5DS R
66	66	DJI Zenmuse X7	Zenmuse X7
67	67	Leica M10	M10
68	68	Nikon D7500	D7500
69	69	Nikon D3400	D3400
70	70	Sony A7SIII	A7SIII
71	71	Canon EOS RP	EOS RP
72	72	Canon EOS 6D Mark II	EOS 6D Mark II
73	73	Leica Q Typ 116	Q Typ 116
74	74	Sony A6500	A6500
75	75	Sony A6300	A6300
76	76	Sony A7S II	A7S II
77	77	Leica M Typ 240	M Typ 240
78	78	Nikon D5600	D5600
79	79	Nikon D500	D500
80	80	Nikon D5500	D5500
81	81	Nikon D5200	D5200
82	82	Nikon D5300	D5300
83	83	Nikon D7100	D7100
84	84	Samsung NX1	NX1
85	85	Sony A6400	A6400
86	86	Canon EOS 6D	EOS 6D
87	87	Canon EOS 1Dx	EOS 1Dx
88	88	Nikon D3300	D3300
89	89	Nikon D3s	D3s
90	90	Pentax K-5 II	K-5 II
91	91	Pentax K-5 IIs	K-5 IIs
92	92	Pentax K5	K5
93	93	Pentax 645D	645D
94	94	Sony A6600	A6600
95	95	Sony SLT Alpha 77 II	SLT Alpha 77 II
96	96	Sony A6000	A6000
97	97	Canon EOS 5D Mark III	EOS 5D Mark III
98	98	Nikon D3200	D3200
99	99	Nikon D3	D3
100	100	Sony NEX-7	NEX-7
\.


--
-- Data for Name: dim_sensor_formats; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dim_sensor_formats (format_key, format_name) FROM stdin;
1	Full Frame
2	Medium Format
3	APS-C
\.


--
-- Data for Name: dim_time; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dim_time (time_key, full_date, year, quarter, month, day) FROM stdin;
20190307	2019-03-07	2019	1	3	7
20140406	2014-04-06	2014	2	4	6
20070823	2007-08-23	2007	3	8	23
20141120	2014-11-20	2014	4	11	20
20081201	2008-12-01	2008	4	12	1
20091014	2009-10-14	2009	4	10	14
20170629	2017-06-29	2017	2	6	29
20211223	2021-12-23	2021	4	12	23
20200107	2020-01-07	2020	1	1	7
20201210	2020-12-10	2020	4	12	10
20221026	2022-10-26	2022	4	10	26
20120913	2012-09-13	2012	3	9	13
20200827	2020-08-27	2020	3	8	27
20130627	2013-06-27	2013	2	6	27
20200730	2020-07-30	2020	3	7	30
20121106	2012-11-06	2012	4	11	6
20170118	2017-01-18	2017	1	1	18
20140225	2014-02-25	2014	1	2	25
20241101	2024-11-01	2024	4	11	1
20150302	2015-03-02	2015	1	3	2
20140912	2014-09-12	2014	3	9	12
20160202	2016-02-02	2016	1	2	2
20150205	2015-02-05	2015	1	2	5
20160622	2016-06-22	2016	2	6	22
20120302	2012-03-02	2012	1	3	2
20090429	2009-04-29	2009	2	4	29
20131008	2013-10-08	2013	4	10	8
20170412	2017-04-12	2017	2	4	12
20131017	2013-10-17	2013	4	10	17
20160825	2016-08-25	2016	3	8	25
20131016	2013-10-16	2013	4	10	16
20140107	2014-01-07	2014	1	1	7
20160106	2016-01-06	2016	1	1	6
20160919	2016-09-19	2016	3	9	19
20190828	2019-08-28	2019	3	8	28
20190716	2019-07-16	2019	3	7	16
20200728	2020-07-28	2020	3	7	28
20190201	2019-02-01	2019	1	2	1
20080714	2008-07-14	2008	3	7	14
20150106	2015-01-06	2015	1	1	6
20210927	2021-09-27	2021	3	9	27
20100920	2010-09-20	2010	3	9	20
20120419	2012-04-19	2012	2	4	19
20131105	2013-11-05	2013	4	11	5
20160817	2016-08-17	2016	3	8	17
20210126	2021-01-26	2021	1	1	26
20180227	2018-02-27	2018	1	2	27
20120207	2012-02-07	2012	1	2	7
20211224	2021-12-24	2021	4	12	24
20150610	2015-06-10	2015	2	6	10
20150206	2015-02-06	2015	1	2	6
20140626	2014-06-26	2014	2	6	26
20180823	2018-08-23	2018	3	8	23
20120917	2012-09-17	2012	3	9	17
20161006	2016-10-06	2016	4	10	6
20230208	2023-02-08	2023	1	2	8
20151014	2015-10-14	2015	4	10	14
20111018	2011-10-18	2011	4	10	18
20130221	2013-02-21	2013	1	2	21
20110824	2011-08-24	2011	3	8	24
20210209	2021-02-09	2021	1	2	9
20170823	2017-08-23	2017	3	8	23
20210914	2021-09-14	2021	3	9	14
20171025	2017-10-25	2017	4	10	25
20151020	2015-10-20	2015	4	10	20
20140212	2014-02-12	2014	1	2	12
20140415	2014-04-15	2014	2	4	15
20220113	2022-01-13	2022	1	1	13
20120912	2012-09-12	2012	3	9	12
20160217	2016-02-17	2016	1	2	17
20201014	2020-10-14	2020	4	10	14
20180905	2018-09-05	2018	3	9	5
20161110	2016-11-10	2016	4	11	10
20190214	2019-02-14	2019	1	2	14
20190115	2019-01-15	2019	1	1	15
20230525	2023-05-25	2023	2	5	25
20120911	2012-09-11	2012	3	9	11
20120106	2012-01-06	2012	1	1	6
20140915	2014-09-15	2014	3	9	15
20150911	2015-09-11	2015	3	9	11
20231108	2023-11-08	2023	4	11	8
20160203	2016-02-03	2016	1	2	3
20100301	2010-03-01	2010	1	3	1
20191003	2019-10-03	2019	4	10	3
20140501	2014-05-01	2014	2	5	1
20110124	2011-01-24	2011	1	1	24
20170419	2017-04-19	2017	2	4	19
20201101	2020-11-01	2020	4	11	1
20171011	2017-10-11	2017	4	10	11
\.


--
-- Data for Name: fact_camera_performance; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fact_camera_performance (camera_key, brand_key, format_key, time_key, launch_price_usd, pixel_depth_mp, overall_score, portrait_score, landscape_score, sports_score) FROM stdin;
19	1	1	20190307	5000	47.3	96	26.4	13.5	2491
64	4	1	20140406	2499	12.2	87	23.9	13.2	3702
99	8	1	20070823	4300	12.1	81	23.5	12.2	2290
47	4	1	20141120	1600	24.3	90	24.9	13.6	2449
58	8	1	20081201	9172	24.5	88	24.7	13.7	1992
89	8	1	20091014	5510	12.1	82	23.5	12.0	3253
72	6	1	20170629	2000	26.2	85	24.4	11.9	2862
16	4	1	20211223	2800	33.0	97	25.4	14.7	3379
41	6	1	20200107	6500	20.1	91	24.2	14.5	3248
24	1	1	20201210	4895	24.6	95	25.2	14.1	3504
7	4	1	20221026	3900	60.0	100	26.1	14.8	3187
32	8	1	20120913	2100	24.3	94	25.1	14.2	2980
45	6	1	20200827	2499	20.1	90	24.2	14.3	3394
44	4	1	20130627	2800	24.3	91	25.0	13.6	2537
23	6	1	20200730	4499	45.0	95	25.3	14.6	3042
81	8	3	20121106	897	24.1	84	24.2	13.9	1284
67	1	1	20170118	6895	24.0	86	24.4	13.2	2133
50	8	1	20140225	6500	16.2	89	24.4	13.3	3074
36	2	1	20241101	3999	24.5	93	25.2	13.6	3108
60	8	3	20150302	1200	24.2	87	24.5	14.6	1333
35	8	1	20140912	2300	24.3	93	24.8	14.5	2956
55	6	1	20160202	6000	20.2	88	24.1	13.5	3207
62	5	3	20150205	800	28.0	87	24.8	13.9	1379
1	10	2	20160622	8995	50.0	102	26.2	14.8	4489
97	6	1	20120302	3499	22.3	81	24.0	11.7	2293
61	3	2	20090429	19500	40.0	87	25.3	13.0	1307
31	8	1	20131008	1999	24.0	94	25.1	14.4	2925
68	8	3	20170412	1250	20.9	86	24.3	14.0	1483
82	8	3	20131017	800	24.2	83	24.0	13.9	1338
42	6	1	20160825	3500	30.4	91	24.8	13.6	2995
48	4	1	20131016	1700	24.0	90	24.8	14.2	2248
29	4	1	20131016	2300	36.0	95	25.6	14.1	2746
88	8	3	20140107	650	24.2	82	24.3	12.8	1385
79	8	3	20160106	2000	20.9	84	24.1	14.0	1324
57	8	1	20160106	6500	20.8	88	25.1	12.3	2434
40	4	1	20160919	3200	42.4	92	25.4	13.4	2317
94	4	3	20190828	1200	24.2	82	23.8	13.4	1497
10	4	1	20190716	3500	61.2	99	26.0	14.8	3344
70	4	1	20200728	3499	12.1	86	23.7	13.9	2520
27	11	1	20190201	2500	24.2	95	25.2	14.5	3333
6	11	1	20190201	3700	47.3	100	26.4	14.1	3525
53	3	2	20080714	39900	60.5	89	26.0	13.0	1158
80	8	3	20150106	900	24.2	84	24.1	14.0	1438
46	2	3	20210927	2999	26.0	90	25.1	13.5	1939
92	9	3	20100920	1600	16.3	82	23.7	14.1	1162
98	8	3	20120419	699	24.2	81	24.1	13.2	1131
51	8	1	20131105	2749	16.2	89	24.6	13.1	3279
69	8	3	20160817	650	24.2	86	24.8	13.9	1192
13	4	1	20210126	6499	50.1	98	25.9	14.5	3163
22	4	1	20180227	2000	24.2	96	25.1	14.7	3722
26	8	1	20120207	2999	36.3	95	25.3	14.4	2853
20	8	1	20120207	3300	36.3	96	25.6	14.3	2979
12	8	1	20211224	5999	45.7	98	26.3	14.4	2451
73	1	1	20150610	4250	24.2	85	24.3	12.7	2221
14	4	1	20150610	3198	42.4	98	26.0	13.9	3434
65	6	1	20150206	3900	50.6	86	24.6	12.4	2308
59	6	1	20150206	3700	50.6	87	24.7	12.4	2381
15	8	1	20140626	3300	36.3	97	25.7	14.8	2853
25	8	1	20180823	2000	24.5	95	25.3	14.3	3299
9	8	1	20180823	3400	45.7	99	26.3	14.6	2668
77	1	1	20120917	6950	24.0	84	24.0	13.3	1860
86	6	1	20120917	2099	20.2	82	23.8	12.1	2340
74	4	3	20161006	1400	24.2	85	24.5	13.7	1405
34	6	1	20230208	1499	24.2	93	24.5	14.7	3295
17	4	1	20151014	3300	42.4	97	25.8	13.9	3204
87	6	1	20111018	6800	18.1	82	23.8	11.8	2786
83	8	3	20130221	1200	24.1	83	24.2	13.7	1256
100	4	3	20110824	1720	24.3	81	24.1	13.4	1016
33	11	1	20210209	1999	24.2	94	25.1	14.5	2697
5	8	1	20170823	3300	45.7	100	26.4	14.8	2660
18	6	1	20210914	5999	24.1	96	25.0	14.7	4086
8	4	1	20171025	3200	42.4	100	26.0	14.7	3523
56	1	1	20151020	7450	24.0	88	25.0	13.4	1821
96	4	3	20140212	799	24.3	82	24.1	13.1	1347
2	9	2	20140415	8499	51.4	101	26.0	14.7	4505
3	1	1	20220113	8350	60.3	100	26.3	14.8	3376
54	4	1	20120912	2800	24.3	89	25.0	14.0	1555
38	4	1	20120912	2800	24.3	93	25.1	14.3	2534
21	9	1	20160217	1800	36.4	96	25.4	14.6	3280
30	8	1	20201014	1995	24.5	94	25.0	14.4	3303
4	8	1	20201014	3399	45.8	100	26.3	14.7	2841
49	6	1	20180905	2300	30.3	89	24.5	13.5	2742
78	8	3	20161110	700	24.2	84	24.1	14.0	1306
71	6	1	20190214	1300	26.0	85	24.3	11.9	2978
85	4	3	20190115	900	24.2	83	24.0	13.6	1431
11	8	1	20230525	4000	45.7	98	26.3	14.2	2548
91	9	3	20120911	1199	16.3	82	23.9	14.1	1208
90	9	3	20120911	999	16.3	82	23.8	14.1	1235
52	8	1	20120106	5999	16.2	89	24.7	13.1	2965
84	5	3	20140915	1500	28.2	83	24.2	13.2	1363
76	4	1	20150911	3000	12.2	85	23.6	13.3	2993
63	4	1	20231108	5999	24.6	87	24.1	13.0	3224
75	4	3	20160203	1000	24.2	85	24.4	13.7	1437
93	9	2	20100301	9400	40.0	82	24.6	12.6	1262
37	4	1	20191003	4500	24.2	93	25.0	14.0	3434
95	4	3	20140501	1200	24.3	82	24.4	13.4	1013
43	3	2	20110124	42490	80.0	91	26.5	13.6	966
39	4	1	20170419	4500	24.2	92	24.9	13.3	3517
28	4	1	20201101	1799	24.2	95	25.0	14.7	3407
66	7	3	20171011	2700	24.0	86	24.6	13.9	1482
\.


--
-- Data for Name: lens_mounts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.lens_mounts (mount_id, mount_name) FROM stdin;
\.


--
-- Data for Name: lenses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.lenses (lens_id, lens_name, brand, price_usd, aperture, focal_length, stabilization, mount_id) FROM stdin;
\.


--
-- Data for Name: scores; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.scores (score_id, camera_id, score_type, score_value) FROM stdin;
1	1	Overall	102.0
2	1	Portrait (Color Depth)	26.2
3	1	Landscape (Dynamic Range)	14.8
4	1	Sports (Low-Light ISO)	4489.0
5	2	Overall	101.0
6	2	Portrait (Color Depth)	26.0
7	2	Landscape (Dynamic Range)	14.7
8	2	Sports (Low-Light ISO)	4505.0
9	3	Overall	100.0
10	3	Portrait (Color Depth)	26.3
11	3	Landscape (Dynamic Range)	14.8
12	3	Sports (Low-Light ISO)	3376.0
13	4	Overall	100.0
14	4	Portrait (Color Depth)	26.3
15	4	Landscape (Dynamic Range)	14.7
16	4	Sports (Low-Light ISO)	2841.0
17	5	Overall	100.0
18	5	Portrait (Color Depth)	26.4
19	5	Landscape (Dynamic Range)	14.8
20	5	Sports (Low-Light ISO)	2660.0
21	6	Overall	100.0
22	6	Portrait (Color Depth)	26.4
23	6	Landscape (Dynamic Range)	14.1
24	6	Sports (Low-Light ISO)	3525.0
25	7	Overall	100.0
26	7	Portrait (Color Depth)	26.1
27	7	Landscape (Dynamic Range)	14.8
28	7	Sports (Low-Light ISO)	3187.0
29	8	Overall	100.0
30	8	Portrait (Color Depth)	26.0
31	8	Landscape (Dynamic Range)	14.7
32	8	Sports (Low-Light ISO)	3523.0
33	9	Overall	99.0
34	9	Portrait (Color Depth)	26.3
35	9	Landscape (Dynamic Range)	14.6
36	9	Sports (Low-Light ISO)	2668.0
37	10	Overall	99.0
38	10	Portrait (Color Depth)	26.0
39	10	Landscape (Dynamic Range)	14.8
40	10	Sports (Low-Light ISO)	3344.0
41	11	Overall	98.0
42	11	Portrait (Color Depth)	26.3
43	11	Landscape (Dynamic Range)	14.2
44	11	Sports (Low-Light ISO)	2548.0
45	12	Overall	98.0
46	12	Portrait (Color Depth)	26.3
47	12	Landscape (Dynamic Range)	14.4
48	12	Sports (Low-Light ISO)	2451.0
49	13	Overall	98.0
50	13	Portrait (Color Depth)	25.9
51	13	Landscape (Dynamic Range)	14.5
52	13	Sports (Low-Light ISO)	3163.0
53	14	Overall	98.0
54	14	Portrait (Color Depth)	26.0
55	14	Landscape (Dynamic Range)	13.9
56	14	Sports (Low-Light ISO)	3434.0
57	15	Overall	97.0
58	15	Portrait (Color Depth)	25.7
59	15	Landscape (Dynamic Range)	14.8
60	15	Sports (Low-Light ISO)	2853.0
61	16	Overall	97.0
62	16	Portrait (Color Depth)	25.4
63	16	Landscape (Dynamic Range)	14.7
64	16	Sports (Low-Light ISO)	3379.0
65	17	Overall	97.0
66	17	Portrait (Color Depth)	25.8
67	17	Landscape (Dynamic Range)	13.9
68	17	Sports (Low-Light ISO)	3204.0
69	18	Overall	96.0
70	18	Portrait (Color Depth)	25.0
71	18	Landscape (Dynamic Range)	14.7
72	18	Sports (Low-Light ISO)	4086.0
73	19	Overall	96.0
74	19	Portrait (Color Depth)	26.4
75	19	Landscape (Dynamic Range)	13.5
76	19	Sports (Low-Light ISO)	2491.0
77	20	Overall	96.0
78	20	Portrait (Color Depth)	25.6
79	20	Landscape (Dynamic Range)	14.3
80	20	Sports (Low-Light ISO)	2979.0
81	21	Overall	96.0
82	21	Portrait (Color Depth)	25.4
83	21	Landscape (Dynamic Range)	14.6
84	21	Sports (Low-Light ISO)	3280.0
85	22	Overall	96.0
86	22	Portrait (Color Depth)	25.1
87	22	Landscape (Dynamic Range)	14.7
88	22	Sports (Low-Light ISO)	3722.0
89	23	Overall	95.0
90	23	Portrait (Color Depth)	25.3
91	23	Landscape (Dynamic Range)	14.6
92	23	Sports (Low-Light ISO)	3042.0
93	24	Overall	95.0
94	24	Portrait (Color Depth)	25.2
95	24	Landscape (Dynamic Range)	14.1
96	24	Sports (Low-Light ISO)	3504.0
97	25	Overall	95.0
98	25	Portrait (Color Depth)	25.3
99	25	Landscape (Dynamic Range)	14.3
100	25	Sports (Low-Light ISO)	3299.0
101	26	Overall	95.0
102	26	Portrait (Color Depth)	25.3
103	26	Landscape (Dynamic Range)	14.4
104	26	Sports (Low-Light ISO)	2853.0
105	27	Overall	95.0
106	27	Portrait (Color Depth)	25.2
107	27	Landscape (Dynamic Range)	14.5
108	27	Sports (Low-Light ISO)	3333.0
109	28	Overall	95.0
110	28	Portrait (Color Depth)	25.0
111	28	Landscape (Dynamic Range)	14.7
112	28	Sports (Low-Light ISO)	3407.0
113	29	Overall	95.0
114	29	Portrait (Color Depth)	25.6
115	29	Landscape (Dynamic Range)	14.1
116	29	Sports (Low-Light ISO)	2746.0
117	30	Overall	94.0
118	30	Portrait (Color Depth)	25.0
119	30	Landscape (Dynamic Range)	14.4
120	30	Sports (Low-Light ISO)	3303.0
121	31	Overall	94.0
122	31	Portrait (Color Depth)	25.1
123	31	Landscape (Dynamic Range)	14.4
124	31	Sports (Low-Light ISO)	2925.0
125	32	Overall	94.0
126	32	Portrait (Color Depth)	25.1
127	32	Landscape (Dynamic Range)	14.2
128	32	Sports (Low-Light ISO)	2980.0
129	33	Overall	94.0
130	33	Portrait (Color Depth)	25.1
131	33	Landscape (Dynamic Range)	14.5
132	33	Sports (Low-Light ISO)	2697.0
133	34	Overall	93.0
134	34	Portrait (Color Depth)	24.5
135	34	Landscape (Dynamic Range)	14.7
136	34	Sports (Low-Light ISO)	3295.0
137	35	Overall	93.0
138	35	Portrait (Color Depth)	24.8
139	35	Landscape (Dynamic Range)	14.5
140	35	Sports (Low-Light ISO)	2956.0
141	36	Overall	93.0
142	36	Portrait (Color Depth)	25.2
143	36	Landscape (Dynamic Range)	13.6
144	36	Sports (Low-Light ISO)	3108.0
145	37	Overall	93.0
146	37	Portrait (Color Depth)	25.0
147	37	Landscape (Dynamic Range)	14.0
148	37	Sports (Low-Light ISO)	3434.0
149	38	Overall	93.0
150	38	Portrait (Color Depth)	25.1
151	38	Landscape (Dynamic Range)	14.3
152	38	Sports (Low-Light ISO)	2534.0
153	39	Overall	92.0
154	39	Portrait (Color Depth)	24.9
155	39	Landscape (Dynamic Range)	13.3
156	39	Sports (Low-Light ISO)	3517.0
157	40	Overall	92.0
158	40	Portrait (Color Depth)	25.4
159	40	Landscape (Dynamic Range)	13.4
160	40	Sports (Low-Light ISO)	2317.0
161	41	Overall	91.0
162	41	Portrait (Color Depth)	24.2
163	41	Landscape (Dynamic Range)	14.5
164	41	Sports (Low-Light ISO)	3248.0
165	42	Overall	91.0
166	42	Portrait (Color Depth)	24.8
167	42	Landscape (Dynamic Range)	13.6
168	42	Sports (Low-Light ISO)	2995.0
169	43	Overall	91.0
170	43	Portrait (Color Depth)	26.5
171	43	Landscape (Dynamic Range)	13.6
172	43	Sports (Low-Light ISO)	966.0
173	44	Overall	91.0
174	44	Portrait (Color Depth)	25.0
175	44	Landscape (Dynamic Range)	13.6
176	44	Sports (Low-Light ISO)	2537.0
177	45	Overall	90.0
178	45	Portrait (Color Depth)	24.2
179	45	Landscape (Dynamic Range)	14.3
180	45	Sports (Low-Light ISO)	3394.0
181	46	Overall	90.0
182	46	Portrait (Color Depth)	25.1
183	46	Landscape (Dynamic Range)	13.5
184	46	Sports (Low-Light ISO)	1939.0
185	47	Overall	90.0
186	47	Portrait (Color Depth)	24.9
187	47	Landscape (Dynamic Range)	13.6
188	47	Sports (Low-Light ISO)	2449.0
189	48	Overall	90.0
190	48	Portrait (Color Depth)	24.8
191	48	Landscape (Dynamic Range)	14.2
192	48	Sports (Low-Light ISO)	2248.0
193	49	Overall	89.0
194	49	Portrait (Color Depth)	24.5
195	49	Landscape (Dynamic Range)	13.5
196	49	Sports (Low-Light ISO)	2742.0
197	50	Overall	89.0
198	50	Portrait (Color Depth)	24.4
199	50	Landscape (Dynamic Range)	13.3
200	50	Sports (Low-Light ISO)	3074.0
201	51	Overall	89.0
202	51	Portrait (Color Depth)	24.6
203	51	Landscape (Dynamic Range)	13.1
204	51	Sports (Low-Light ISO)	3279.0
205	52	Overall	89.0
206	52	Portrait (Color Depth)	24.7
207	52	Landscape (Dynamic Range)	13.1
208	52	Sports (Low-Light ISO)	2965.0
209	53	Overall	89.0
210	53	Portrait (Color Depth)	26.0
211	53	Landscape (Dynamic Range)	13.0
212	53	Sports (Low-Light ISO)	1158.0
213	54	Overall	89.0
214	54	Portrait (Color Depth)	25.0
215	54	Landscape (Dynamic Range)	14.0
216	54	Sports (Low-Light ISO)	1555.0
217	55	Overall	88.0
218	55	Portrait (Color Depth)	24.1
219	55	Landscape (Dynamic Range)	13.5
220	55	Sports (Low-Light ISO)	3207.0
221	56	Overall	88.0
222	56	Portrait (Color Depth)	25.0
223	56	Landscape (Dynamic Range)	13.4
224	56	Sports (Low-Light ISO)	1821.0
225	57	Overall	88.0
226	57	Portrait (Color Depth)	25.1
227	57	Landscape (Dynamic Range)	12.3
228	57	Sports (Low-Light ISO)	2434.0
229	58	Overall	88.0
230	58	Portrait (Color Depth)	24.7
231	58	Landscape (Dynamic Range)	13.7
232	58	Sports (Low-Light ISO)	1992.0
233	59	Overall	87.0
234	59	Portrait (Color Depth)	24.7
235	59	Landscape (Dynamic Range)	12.4
236	59	Sports (Low-Light ISO)	2381.0
237	60	Overall	87.0
238	60	Portrait (Color Depth)	24.5
239	60	Landscape (Dynamic Range)	14.6
240	60	Sports (Low-Light ISO)	1333.0
241	61	Overall	87.0
242	61	Portrait (Color Depth)	25.3
243	61	Landscape (Dynamic Range)	13.0
244	61	Sports (Low-Light ISO)	1307.0
245	62	Overall	87.0
246	62	Portrait (Color Depth)	24.8
247	62	Landscape (Dynamic Range)	13.9
248	62	Sports (Low-Light ISO)	1379.0
249	63	Overall	87.0
250	63	Portrait (Color Depth)	24.1
251	63	Landscape (Dynamic Range)	13.0
252	63	Sports (Low-Light ISO)	3224.0
253	64	Overall	87.0
254	64	Portrait (Color Depth)	23.9
255	64	Landscape (Dynamic Range)	13.2
256	64	Sports (Low-Light ISO)	3702.0
257	65	Overall	86.0
258	65	Portrait (Color Depth)	24.6
259	65	Landscape (Dynamic Range)	12.4
260	65	Sports (Low-Light ISO)	2308.0
261	66	Overall	86.0
262	66	Portrait (Color Depth)	24.6
263	66	Landscape (Dynamic Range)	13.9
264	66	Sports (Low-Light ISO)	1482.0
265	67	Overall	86.0
266	67	Portrait (Color Depth)	24.4
267	67	Landscape (Dynamic Range)	13.2
268	67	Sports (Low-Light ISO)	2133.0
269	68	Overall	86.0
270	68	Portrait (Color Depth)	24.3
271	68	Landscape (Dynamic Range)	14.0
272	68	Sports (Low-Light ISO)	1483.0
273	69	Overall	86.0
274	69	Portrait (Color Depth)	24.8
275	69	Landscape (Dynamic Range)	13.9
276	69	Sports (Low-Light ISO)	1192.0
277	70	Overall	86.0
278	70	Portrait (Color Depth)	23.7
279	70	Landscape (Dynamic Range)	13.9
280	70	Sports (Low-Light ISO)	2520.0
281	71	Overall	85.0
282	71	Portrait (Color Depth)	24.3
283	71	Landscape (Dynamic Range)	11.9
284	71	Sports (Low-Light ISO)	2978.0
285	72	Overall	85.0
286	72	Portrait (Color Depth)	24.4
287	72	Landscape (Dynamic Range)	11.9
288	72	Sports (Low-Light ISO)	2862.0
289	73	Overall	85.0
290	73	Portrait (Color Depth)	24.3
291	73	Landscape (Dynamic Range)	12.7
292	73	Sports (Low-Light ISO)	2221.0
293	74	Overall	85.0
294	74	Portrait (Color Depth)	24.5
295	74	Landscape (Dynamic Range)	13.7
296	74	Sports (Low-Light ISO)	1405.0
297	75	Overall	85.0
298	75	Portrait (Color Depth)	24.4
299	75	Landscape (Dynamic Range)	13.7
300	75	Sports (Low-Light ISO)	1437.0
301	76	Overall	85.0
302	76	Portrait (Color Depth)	23.6
303	76	Landscape (Dynamic Range)	13.3
304	76	Sports (Low-Light ISO)	2993.0
305	77	Overall	84.0
306	77	Portrait (Color Depth)	24.0
307	77	Landscape (Dynamic Range)	13.3
308	77	Sports (Low-Light ISO)	1860.0
309	78	Overall	84.0
310	78	Portrait (Color Depth)	24.1
311	78	Landscape (Dynamic Range)	14.0
312	78	Sports (Low-Light ISO)	1306.0
313	79	Overall	84.0
314	79	Portrait (Color Depth)	24.1
315	79	Landscape (Dynamic Range)	14.0
316	79	Sports (Low-Light ISO)	1324.0
317	80	Overall	84.0
318	80	Portrait (Color Depth)	24.1
319	80	Landscape (Dynamic Range)	14.0
320	80	Sports (Low-Light ISO)	1438.0
321	81	Overall	84.0
322	81	Portrait (Color Depth)	24.2
323	81	Landscape (Dynamic Range)	13.9
324	81	Sports (Low-Light ISO)	1284.0
325	82	Overall	83.0
326	82	Portrait (Color Depth)	24.0
327	82	Landscape (Dynamic Range)	13.9
328	82	Sports (Low-Light ISO)	1338.0
329	83	Overall	83.0
330	83	Portrait (Color Depth)	24.2
331	83	Landscape (Dynamic Range)	13.7
332	83	Sports (Low-Light ISO)	1256.0
333	84	Overall	83.0
334	84	Portrait (Color Depth)	24.2
335	84	Landscape (Dynamic Range)	13.2
336	84	Sports (Low-Light ISO)	1363.0
337	85	Overall	83.0
338	85	Portrait (Color Depth)	24.0
339	85	Landscape (Dynamic Range)	13.6
340	85	Sports (Low-Light ISO)	1431.0
341	86	Overall	82.0
342	86	Portrait (Color Depth)	23.8
343	86	Landscape (Dynamic Range)	12.1
344	86	Sports (Low-Light ISO)	2340.0
345	87	Overall	82.0
346	87	Portrait (Color Depth)	23.8
347	87	Landscape (Dynamic Range)	11.8
348	87	Sports (Low-Light ISO)	2786.0
349	88	Overall	82.0
350	88	Portrait (Color Depth)	24.3
351	88	Landscape (Dynamic Range)	12.8
352	88	Sports (Low-Light ISO)	1385.0
353	89	Overall	82.0
354	89	Portrait (Color Depth)	23.5
355	89	Landscape (Dynamic Range)	12.0
356	89	Sports (Low-Light ISO)	3253.0
357	90	Overall	82.0
358	90	Portrait (Color Depth)	23.8
359	90	Landscape (Dynamic Range)	14.1
360	90	Sports (Low-Light ISO)	1235.0
361	91	Overall	82.0
362	91	Portrait (Color Depth)	23.9
363	91	Landscape (Dynamic Range)	14.1
364	91	Sports (Low-Light ISO)	1208.0
365	92	Overall	82.0
366	92	Portrait (Color Depth)	23.7
367	92	Landscape (Dynamic Range)	14.1
368	92	Sports (Low-Light ISO)	1162.0
369	93	Overall	82.0
370	93	Portrait (Color Depth)	24.6
371	93	Landscape (Dynamic Range)	12.6
372	93	Sports (Low-Light ISO)	1262.0
373	94	Overall	82.0
374	94	Portrait (Color Depth)	23.8
375	94	Landscape (Dynamic Range)	13.4
376	94	Sports (Low-Light ISO)	1497.0
377	95	Overall	82.0
378	95	Portrait (Color Depth)	24.4
379	95	Landscape (Dynamic Range)	13.4
380	95	Sports (Low-Light ISO)	1013.0
381	96	Overall	82.0
382	96	Portrait (Color Depth)	24.1
383	96	Landscape (Dynamic Range)	13.1
384	96	Sports (Low-Light ISO)	1347.0
385	97	Overall	81.0
386	97	Portrait (Color Depth)	24.0
387	97	Landscape (Dynamic Range)	11.7
388	97	Sports (Low-Light ISO)	2293.0
389	98	Overall	81.0
390	98	Portrait (Color Depth)	24.1
391	98	Landscape (Dynamic Range)	13.2
392	98	Sports (Low-Light ISO)	1131.0
393	99	Overall	81.0
394	99	Portrait (Color Depth)	23.5
395	99	Landscape (Dynamic Range)	12.2
396	99	Sports (Low-Light ISO)	2290.0
397	100	Overall	81.0
398	100	Portrait (Color Depth)	24.1
399	100	Landscape (Dynamic Range)	13.4
400	100	Sports (Low-Light ISO)	1016.0
\.


--
-- Data for Name: sensor_formats; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sensor_formats (format_id, format_name) FROM stdin;
1	Full Frame
2	Medium Format
3	APS-C
\.


--
-- Data for Name: video_resolutions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.video_resolutions (resolution_id, resolution_name, max_fps) FROM stdin;
\.


--
-- Name: brands_brand_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.brands_brand_id_seq', 11, true);


--
-- Name: dim_brands_brand_key_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dim_brands_brand_key_seq', 11, true);


--
-- Name: dim_cameras_camera_key_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dim_cameras_camera_key_seq', 100, true);


--
-- Name: dim_sensor_formats_format_key_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dim_sensor_formats_format_key_seq', 3, true);


--
-- Name: lens_mounts_mount_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.lens_mounts_mount_id_seq', 1, false);


--
-- Name: lenses_lens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.lenses_lens_id_seq', 1, false);


--
-- Name: sensor_formats_format_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sensor_formats_format_id_seq', 3, true);


--
-- Name: video_resolutions_resolution_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.video_resolutions_resolution_id_seq', 1, false);


--
-- Name: brands brands_brand_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.brands
    ADD CONSTRAINT brands_brand_name_key UNIQUE (brand_name);


--
-- Name: brands brands_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.brands
    ADD CONSTRAINT brands_pkey PRIMARY KEY (brand_id);


--
-- Name: camera_video_capabilities camera_video_capabilities_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.camera_video_capabilities
    ADD CONSTRAINT camera_video_capabilities_pkey PRIMARY KEY (camera_id, resolution_id);


--
-- Name: cameras cameras_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cameras
    ADD CONSTRAINT cameras_pkey PRIMARY KEY (camera_id);


--
-- Name: dim_brands dim_brands_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_brands
    ADD CONSTRAINT dim_brands_pkey PRIMARY KEY (brand_key);


--
-- Name: dim_cameras dim_cameras_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_cameras
    ADD CONSTRAINT dim_cameras_pkey PRIMARY KEY (camera_key);


--
-- Name: dim_sensor_formats dim_sensor_formats_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_sensor_formats
    ADD CONSTRAINT dim_sensor_formats_pkey PRIMARY KEY (format_key);


--
-- Name: dim_time dim_time_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_time
    ADD CONSTRAINT dim_time_pkey PRIMARY KEY (time_key);


--
-- Name: lens_mounts lens_mounts_mount_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lens_mounts
    ADD CONSTRAINT lens_mounts_mount_name_key UNIQUE (mount_name);


--
-- Name: lens_mounts lens_mounts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lens_mounts
    ADD CONSTRAINT lens_mounts_pkey PRIMARY KEY (mount_id);


--
-- Name: lenses lenses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lenses
    ADD CONSTRAINT lenses_pkey PRIMARY KEY (lens_id);


--
-- Name: scores scores_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scores
    ADD CONSTRAINT scores_pkey PRIMARY KEY (score_id);


--
-- Name: sensor_formats sensor_formats_format_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sensor_formats
    ADD CONSTRAINT sensor_formats_format_name_key UNIQUE (format_name);


--
-- Name: sensor_formats sensor_formats_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sensor_formats
    ADD CONSTRAINT sensor_formats_pkey PRIMARY KEY (format_id);


--
-- Name: video_resolutions video_resolutions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.video_resolutions
    ADD CONSTRAINT video_resolutions_pkey PRIMARY KEY (resolution_id);


--
-- Name: video_resolutions video_resolutions_resolution_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.video_resolutions
    ADD CONSTRAINT video_resolutions_resolution_name_key UNIQUE (resolution_name);


--
-- Name: fact_camera_performance fact_camera_performance_brand_key_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_camera_performance
    ADD CONSTRAINT fact_camera_performance_brand_key_fkey FOREIGN KEY (brand_key) REFERENCES public.dim_brands(brand_key);


--
-- Name: fact_camera_performance fact_camera_performance_camera_key_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_camera_performance
    ADD CONSTRAINT fact_camera_performance_camera_key_fkey FOREIGN KEY (camera_key) REFERENCES public.dim_cameras(camera_key);


--
-- Name: fact_camera_performance fact_camera_performance_format_key_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_camera_performance
    ADD CONSTRAINT fact_camera_performance_format_key_fkey FOREIGN KEY (format_key) REFERENCES public.dim_sensor_formats(format_key);


--
-- Name: fact_camera_performance fact_camera_performance_time_key_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_camera_performance
    ADD CONSTRAINT fact_camera_performance_time_key_fkey FOREIGN KEY (time_key) REFERENCES public.dim_time(time_key);


--
-- Name: cameras fk_brand; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cameras
    ADD CONSTRAINT fk_brand FOREIGN KEY (brand_id) REFERENCES public.brands(brand_id);


--
-- Name: scores fk_camera; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scores
    ADD CONSTRAINT fk_camera FOREIGN KEY (camera_id) REFERENCES public.cameras(camera_id) ON DELETE CASCADE;


--
-- Name: camera_video_capabilities fk_camera; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.camera_video_capabilities
    ADD CONSTRAINT fk_camera FOREIGN KEY (camera_id) REFERENCES public.cameras(camera_id) ON DELETE CASCADE;


--
-- Name: cameras fk_format; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cameras
    ADD CONSTRAINT fk_format FOREIGN KEY (format_id) REFERENCES public.sensor_formats(format_id);


--
-- Name: lenses fk_lens_mount; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lenses
    ADD CONSTRAINT fk_lens_mount FOREIGN KEY (mount_id) REFERENCES public.lens_mounts(mount_id);


--
-- Name: cameras fk_mount; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cameras
    ADD CONSTRAINT fk_mount FOREIGN KEY (mount_id) REFERENCES public.lens_mounts(mount_id);


--
-- Name: camera_video_capabilities fk_resolution; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.camera_video_capabilities
    ADD CONSTRAINT fk_resolution FOREIGN KEY (resolution_id) REFERENCES public.video_resolutions(resolution_id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

