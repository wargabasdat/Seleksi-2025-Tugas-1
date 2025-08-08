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
-- Name: dim_classes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dim_classes (
    class_key integer NOT NULL,
    class_id character varying(50) NOT NULL,
    class_name character varying(100),
    category_name character varying(30),
    difficulty_level character varying(30),
    duration_minutes integer,
    location character varying(50)
);


ALTER TABLE public.dim_classes OWNER TO postgres;

--
-- Name: dim_classes_class_key_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dim_classes_class_key_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dim_classes_class_key_seq OWNER TO postgres;

--
-- Name: dim_classes_class_key_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dim_classes_class_key_seq OWNED BY public.dim_classes.class_key;


--
-- Name: dim_date; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dim_date (
    date_key integer NOT NULL,
    full_date date NOT NULL,
    day_of_week character varying(10),
    month_name character varying(15),
    year integer,
    is_weekend boolean DEFAULT false
);


ALTER TABLE public.dim_date OWNER TO postgres;

--
-- Name: dim_date_date_key_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dim_date_date_key_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dim_date_date_key_seq OWNER TO postgres;

--
-- Name: dim_date_date_key_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dim_date_date_key_seq OWNED BY public.dim_date.date_key;


--
-- Name: dim_instructors; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dim_instructors (
    instructor_key integer NOT NULL,
    instructor_id character varying(30) NOT NULL,
    instructor_name character varying(50),
    role character varying(50)
);


ALTER TABLE public.dim_instructors OWNER TO postgres;

--
-- Name: dim_instructors_instructor_key_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dim_instructors_instructor_key_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dim_instructors_instructor_key_seq OWNER TO postgres;

--
-- Name: dim_instructors_instructor_key_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dim_instructors_instructor_key_seq OWNED BY public.dim_instructors.instructor_key;


--
-- Name: dim_location; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dim_location (
    location_key integer NOT NULL,
    location_name character varying(50) NOT NULL
);


ALTER TABLE public.dim_location OWNER TO postgres;

--
-- Name: dim_location_location_key_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dim_location_location_key_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dim_location_location_key_seq OWNER TO postgres;

--
-- Name: dim_location_location_key_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dim_location_location_key_seq OWNED BY public.dim_location.location_key;


--
-- Name: fact_class_summary; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fact_class_summary (
    summary_key integer NOT NULL,
    class_key integer NOT NULL,
    instructor_key integer,
    date_key integer,
    location_key integer NOT NULL,
    total_reviews integer DEFAULT 0,
    avg_rating numeric(3,2) DEFAULT 0.00,
    total_duration_hours numeric(4,2) DEFAULT 0.00,
    equipment_count integer DEFAULT 0
);


ALTER TABLE public.fact_class_summary OWNER TO postgres;

--
-- Name: fact_class_summary_summary_key_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.fact_class_summary_summary_key_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.fact_class_summary_summary_key_seq OWNER TO postgres;

--
-- Name: fact_class_summary_summary_key_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.fact_class_summary_summary_key_seq OWNED BY public.fact_class_summary.summary_key;


--
-- Name: dim_classes class_key; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_classes ALTER COLUMN class_key SET DEFAULT nextval('public.dim_classes_class_key_seq'::regclass);


--
-- Name: dim_date date_key; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_date ALTER COLUMN date_key SET DEFAULT nextval('public.dim_date_date_key_seq'::regclass);


--
-- Name: dim_instructors instructor_key; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_instructors ALTER COLUMN instructor_key SET DEFAULT nextval('public.dim_instructors_instructor_key_seq'::regclass);


--
-- Name: dim_location location_key; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_location ALTER COLUMN location_key SET DEFAULT nextval('public.dim_location_location_key_seq'::regclass);


--
-- Name: fact_class_summary summary_key; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_class_summary ALTER COLUMN summary_key SET DEFAULT nextval('public.fact_class_summary_summary_key_seq'::regclass);


--
-- Data for Name: dim_classes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dim_classes (class_key, class_id, class_name, category_name, difficulty_level, duration_minutes, location) FROM stdin;
1	021ec006-09cd-4db7-bc7d-46eec8e047fb	Private Pilates (Mat, Reformer, Cadillac, Chair, Barrel)	Private Pilates	Open to all	55	Summarecon Bekasi
2	894cc2bd-7a1e-4ebc-bdeb-76d15107cd95	Serenity Glow Flow	Yoga	Open to all	60	Summarecon Bekasi
3	94f3d4ac-910b-4181-b947-827bfff13164	Total Body Reformer	Group Reformer	Open to all	50	Summarecon Bekasi
4	ec2c6dc1-497f-4392-9897-c82b6e39de02	Vinyasa Delight	Yoga	Open to all	60	Summarecon Bekasi
5	d019bb2f-b4d6-4948-b797-fa2fd87ed98c	Backbend Flow	Yoga	Open to all	60	Summarecon Bekasi
6	02457d6e-294e-4a24-89fc-edaa0f1f1224	Hatha Flow	Yoga	Open to all	60	Summarecon Bekasi
7	2b496fe5-4617-4b66-a033-9643167406f0	Hip-Opening	Yoga	Open to all	60	Summarecon Bekasi
8	e343282f-b803-4f8d-9552-00d555798b8c	Sun-Kissed Flow	Yoga	Intermediate	60	Summarecon Bekasi
9	09d8a770-2d06-40b3-a019-1bea981fc16a	Arm Balance	Yoga	Open to all	60	Summarecon Bekasi
10	af761997-f321-4682-886a-6e745be717ed	Reformer 101	Group Reformer	Beginner	50	Summarecon Bekasi
11	9fa780f9-d41e-419b-94dc-11b45a1a20ce	Prenatal Yoga	Prenatal Yoga	Open to all	60	Summarecon Bekasi
12	d22df6a4-ce74-4164-9fde-6e4981cf5fa7	Mat Pilates	Mat Pilates	Open to all	60	Summarecon Bekasi
13	f1b6c72c-1765-4be7-8db8-2b5c3ddcb4a9	Moonlight Flow	Yoga	Open to all	60	Summarecon Bekasi
14	7ed0df06-2eeb-4496-947e-14890ca7a8dc	Saturday Inversion Party	Yoga	Open to all	60	Summarecon Bekasi
15	8d948a73-8f78-4903-98bb-bbee31d83a69	Strength & Flow Reformer	Group Reformer	Intermediate	50	Summarecon Bekasi
16	629ae1b6-615a-4e62-8647-6bbf5da3d957	Basic Yoga	Yoga	Beginner	60	Summarecon Bekasi
17	5449236d-1652-4d0a-8df2-03264dcd27a2	Tower Only	Group Reformer	Open to all	50	Summarecon Bekasi
18	2f3e5060-258f-4b3d-9fcf-0c403895fa46	Private Reformer	Private Pilates	All Levels	50	Summarecon Bekasi
19	fde7bb58-0cc0-4e98-bbc5-6ee519d977ac	Reformer / Tower	Group Reformer	Open to all	50	Summarecon Bekasi
20	77c19388-0b68-4d88-a0cd-b80f9280ac00	Power Yoga: Heat and Heart	Yoga	Open to all	60	Summarecon Bekasi
21	f6459ecb-616d-479e-b498-a8e3cf92bf56	Early Rise Flow	Yoga	Open to all	60	Summarecon Bekasi
22	7055c44c-d30b-4ae9-af2f-d70fe5ef4940	Twilight Flow	Yoga	Open to all	60	Summarecon Bekasi
23	c035853b-3aaa-496a-a3a0-d61d6f4917f5	All Body Flow	Yoga	Open to all	60	Summarecon Bekasi
24	d7d7d5b9-2935-4ebc-91e4-9991d4cd028b	Backbend Lab 101	Yoga	Open to all	60	Summarecon Bekasi
25	01b1d9c5-dff6-47dd-bdf0-c5c9f3e92a28	Morning Vinyasa Flow	Yoga	Open to all	60	Summarecon Bekasi
26	e700155f-6cf2-40bd-b239-d2adaa2f297c	Mandala Flow	Yoga	Open to all	60	Summarecon Bekasi
27	022f7c1d-b674-40d9-84d5-a6b750ffefb8	Vinyasa: Dropback Flow	Yoga	Open to all	60	Summarecon Bekasi
28	231c248b-51c0-4e41-9fde-c63ee0f5839f	Vinyasa- Inversion Flow	Yoga	Open to all	60	Summarecon Bekasi
29	e58731ea-89fb-49db-a13b-8e46273ea737	Ngabuburit Flow	Yoga	Open to all	60	Summarecon Bekasi
30	aed6f26d-61a6-4a33-9620-1323f3e47bb2	Easy Vinyasa	Yoga	Open to all	60	Summarecon Bekasi
31	e3174b55-ebd9-427c-ac86-ed0804e75039	Midweek Recharge	Yoga	Open to all	60	Summarecon Bekasi
32	e8279957-4413-4101-9b96-2654f81ba8a6	Vinyasa - Eagle Flow	Yoga	Open to all	60	Summarecon Bekasi
\.


--
-- Data for Name: dim_date; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dim_date (date_key, full_date, day_of_week, month_name, year, is_weekend) FROM stdin;
1	2025-08-07	Thursday	August	2025	f
2	2025-08-08	Friday	August	2025	f
3	2025-08-09	Saturday	August	2025	t
4	2025-08-10	Sunday	August	2025	t
5	2025-08-11	Monday	August	2025	f
6	2025-08-12	Tuesday	August	2025	f
7	2025-08-13	Wednesday	August	2025	f
8	2025-08-14	Thursday	August	2025	f
9	2025-08-15	Friday	August	2025	f
10	2025-08-16	Saturday	August	2025	t
11	2025-08-17	Sunday	August	2025	t
12	2025-08-18	Monday	August	2025	f
13	2025-08-19	Tuesday	August	2025	f
14	2025-08-20	Wednesday	August	2025	f
15	2025-08-21	Thursday	August	2025	f
16	2025-08-22	Friday	August	2025	f
17	2025-08-23	Saturday	August	2025	t
18	2025-08-24	Sunday	August	2025	t
19	2025-08-25	Monday	August	2025	f
20	2025-08-26	Tuesday	August	2025	f
21	2025-08-27	Wednesday	August	2025	f
22	2025-08-28	Thursday	August	2025	f
23	2025-08-29	Friday	August	2025	f
24	2025-08-31	Sunday	August	2025	t
\.


--
-- Data for Name: dim_instructors; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dim_instructors (instructor_key, instructor_id, instructor_name, role) FROM stdin;
1	instructor_1	Keiko Indrijani	Pilates Instructor
2	instructor_2	Sarah Victoria	Pilates Instructor
3	instructor_3	Vidya Amarilis	Pilates Instructor
4	instructor_4	Putri Augustine	Yoga Teacher
5	instructor_5	Henny Wijaya	Yoga Teacher
6	instructor_6	Irene Juliency	Yoga Teacher
7	instructor_7	Dino Vrei	Pilates Instructor
8	instructor_8	Inez Priscilla	Yoga Teacher
9	instructor_9	Ivy Damara	Yoga Teacher
10	instructor_10	Irma Ars	Yoga Teacher
11	instructor_11	Faras Sekarpratiwi	Yoga Teacher
12	instructor_12	Icha Devina	Yoga Teacher
13	instructor_13	Nabila Viera	Pilates Instructor
14	instructor_14	Novi Erna	Pilates Instructor
15	instructor_15	Intan Muktipertiwi	Prenatal Yoga Teacher
16	instructor_16	Diva Mahsa	Pilates Instructor
17	instructor_17	Zara Alia	Pilates Instructor
18	instructor_18	Shinta W Permatasari	Yoga Teacher
19	instructor_19	Hanum Thaher	Pilates Instructor
20	instructor_20	Shania Hasya	Pilates Instructor
21	instructor_21	Majma A	Yoga Teacher
22	instructor_22	Cita A	Pilates Instructor
\.


--
-- Data for Name: dim_location; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dim_location (location_key, location_name) FROM stdin;
1	Summarecon Bekasi
2	Summarecon Bekasi - Reformer Studio
3	Summarecon Bekasi - Private Studio
4	Summarecon Bekasi - Yoga Studio
\.


--
-- Data for Name: fact_class_summary; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fact_class_summary (summary_key, class_key, instructor_key, date_key, location_key, total_reviews, avg_rating, total_duration_hours, equipment_count) FROM stdin;
1	25	10	1	4	1	5.00	1.00	3
2	22	11	1	4	0	0.00	1.00	3
3	2	12	2	4	0	0.00	1.00	3
4	25	5	3	4	1	5.00	1.00	3
5	7	4	3	4	0	0.00	1.00	3
6	25	10	4	4	1	5.00	1.00	3
7	8	8	4	4	0	0.00	1.00	3
8	16	6	4	4	1	5.00	1.00	3
9	6	11	5	4	0	0.00	1.00	3
10	4	8	6	4	1	5.00	1.00	3
11	13	18	6	4	0	0.00	1.00	3
12	31	21	7	4	0	0.00	1.00	3
13	16	5	7	4	1	5.00	1.00	3
14	30	5	7	4	0	0.00	1.00	3
15	25	10	8	4	1	5.00	1.00	3
16	22	11	8	4	0	0.00	1.00	3
17	2	12	9	4	0	0.00	1.00	3
18	25	5	10	4	1	5.00	1.00	3
19	20	9	10	4	0	0.00	1.00	3
20	25	21	11	4	1	5.00	1.00	3
21	8	8	11	4	0	0.00	1.00	3
22	16	6	11	4	1	5.00	1.00	3
23	6	11	12	4	0	0.00	1.00	3
24	4	8	13	4	1	5.00	1.00	3
25	13	18	13	4	0	0.00	1.00	3
26	31	21	14	4	0	0.00	1.00	3
27	16	5	14	4	1	5.00	1.00	3
28	30	5	14	4	0	0.00	1.00	3
29	25	10	15	4	1	5.00	1.00	3
30	22	11	15	4	0	0.00	1.00	3
31	2	12	16	4	0	0.00	1.00	3
32	25	5	17	4	1	5.00	1.00	3
33	25	10	18	4	1	5.00	1.00	3
34	8	8	18	4	0	0.00	1.00	3
35	16	6	18	4	1	5.00	1.00	3
36	6	11	19	4	0	0.00	1.00	3
37	4	8	20	4	1	5.00	1.00	3
38	13	18	20	4	0	0.00	1.00	3
39	25	10	22	4	1	5.00	1.00	3
40	22	11	22	4	0	0.00	1.00	3
41	2	12	23	4	0	0.00	1.00	3
42	25	10	24	4	1	5.00	1.00	3
43	8	8	24	4	0	0.00	1.00	3
44	16	6	24	4	1	5.00	1.00	3
45	11	15	2	4	0	0.00	1.00	2
46	11	15	9	4	0	0.00	1.00	2
47	11	15	16	4	0	0.00	1.00	2
48	11	15	23	4	0	0.00	1.00	2
49	12	14	4	4	0	0.00	1.00	3
50	12	14	11	4	0	0.00	1.00	3
51	12	14	18	4	0	0.00	1.00	3
52	12	14	24	4	0	0.00	1.00	3
53	1	1	1	3	2	5.00	0.92	3
54	1	1	1	3	2	5.00	0.92	3
55	18	19	1	2	2	5.00	0.83	3
56	18	16	1	2	2	5.00	0.83	3
57	18	2	2	2	2	5.00	0.83	3
58	18	20	4	3	2	5.00	0.83	3
59	18	20	4	3	2	5.00	0.83	3
60	18	20	4	2	2	5.00	0.83	3
61	18	7	5	2	2	5.00	0.83	3
62	1	13	6	3	2	5.00	0.92	3
63	1	13	6	3	2	5.00	0.92	3
64	18	3	7	2	2	5.00	0.83	3
65	1	1	8	3	2	5.00	0.92	3
66	1	1	8	3	2	5.00	0.92	3
67	18	19	8	2	2	5.00	0.83	3
68	18	16	8	2	2	5.00	0.83	3
69	18	2	9	2	2	5.00	0.83	3
70	18	16	10	2	2	5.00	0.83	3
71	18	16	10	3	2	5.00	0.83	3
72	18	16	10	3	2	5.00	0.83	3
73	18	20	10	3	2	5.00	0.83	3
74	18	20	11	3	2	5.00	0.83	3
75	18	20	11	3	2	5.00	0.83	3
76	18	20	11	2	2	5.00	0.83	3
77	18	7	12	2	2	5.00	0.83	3
78	18	3	14	2	2	5.00	0.83	3
79	1	1	15	3	2	5.00	0.92	3
80	1	1	15	3	2	5.00	0.92	3
81	18	19	15	2	2	5.00	0.83	3
82	18	16	15	2	2	5.00	0.83	3
83	18	2	16	2	2	5.00	0.83	3
84	18	7	19	2	2	5.00	0.83	3
85	18	3	21	2	2	5.00	0.83	3
86	18	19	22	2	2	5.00	0.83	3
87	18	16	22	2	2	5.00	0.83	3
88	18	2	23	2	2	5.00	0.83	3
89	18	20	24	3	2	5.00	0.83	3
90	18	20	24	3	2	5.00	0.83	3
91	18	20	24	2	2	5.00	0.83	3
92	3	\N	\N	1	3	5.00	0.00	3
93	5	\N	\N	1	1	5.00	0.00	3
94	10	\N	\N	1	3	5.00	0.00	3
95	15	\N	\N	1	1	5.00	0.00	3
96	17	\N	\N	1	1	5.00	0.00	3
97	19	\N	\N	1	1	5.00	0.00	3
\.


--
-- Name: dim_classes_class_key_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dim_classes_class_key_seq', 32, true);


--
-- Name: dim_date_date_key_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dim_date_date_key_seq', 24, true);


--
-- Name: dim_instructors_instructor_key_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dim_instructors_instructor_key_seq', 22, true);


--
-- Name: dim_location_location_key_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dim_location_location_key_seq', 4, true);


--
-- Name: fact_class_summary_summary_key_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.fact_class_summary_summary_key_seq', 97, true);


--
-- Name: dim_classes dim_classes_class_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_classes
    ADD CONSTRAINT dim_classes_class_id_key UNIQUE (class_id);


--
-- Name: dim_classes dim_classes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_classes
    ADD CONSTRAINT dim_classes_pkey PRIMARY KEY (class_key);


--
-- Name: dim_date dim_date_full_date_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_date
    ADD CONSTRAINT dim_date_full_date_key UNIQUE (full_date);


--
-- Name: dim_date dim_date_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_date
    ADD CONSTRAINT dim_date_pkey PRIMARY KEY (date_key);


--
-- Name: dim_instructors dim_instructors_instructor_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_instructors
    ADD CONSTRAINT dim_instructors_instructor_id_key UNIQUE (instructor_id);


--
-- Name: dim_instructors dim_instructors_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_instructors
    ADD CONSTRAINT dim_instructors_pkey PRIMARY KEY (instructor_key);


--
-- Name: dim_location dim_location_location_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_location
    ADD CONSTRAINT dim_location_location_name_key UNIQUE (location_name);


--
-- Name: dim_location dim_location_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_location
    ADD CONSTRAINT dim_location_pkey PRIMARY KEY (location_key);


--
-- Name: fact_class_summary fact_class_summary_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_class_summary
    ADD CONSTRAINT fact_class_summary_pkey PRIMARY KEY (summary_key);


--
-- Name: fact_class_summary fact_class_summary_class_key_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_class_summary
    ADD CONSTRAINT fact_class_summary_class_key_fkey FOREIGN KEY (class_key) REFERENCES public.dim_classes(class_key);


--
-- Name: fact_class_summary fact_class_summary_date_key_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_class_summary
    ADD CONSTRAINT fact_class_summary_date_key_fkey FOREIGN KEY (date_key) REFERENCES public.dim_date(date_key);


--
-- Name: fact_class_summary fact_class_summary_instructor_key_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_class_summary
    ADD CONSTRAINT fact_class_summary_instructor_key_fkey FOREIGN KEY (instructor_key) REFERENCES public.dim_instructors(instructor_key);


--
-- Name: fact_class_summary fact_class_summary_location_key_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_class_summary
    ADD CONSTRAINT fact_class_summary_location_key_fkey FOREIGN KEY (location_key) REFERENCES public.dim_location(location_key);


--
-- PostgreSQL database dump complete
--

