--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.5 (Postgres.app)

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
-- Name: dim_category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dim_category (
    category_id character varying(50) NOT NULL,
    name character varying(100)
);


ALTER TABLE public.dim_category OWNER TO postgres;

--
-- Name: dim_measurements; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dim_measurements (
    measurement_id integer NOT NULL,
    size_name character varying(50),
    detail text
);


ALTER TABLE public.dim_measurements OWNER TO postgres;

--
-- Name: dim_products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dim_products (
    product_id character varying(50) NOT NULL,
    name character varying(255),
    description text,
    material text,
    size character varying(50),
    image_url text,
    is_discount boolean
);


ALTER TABLE public.dim_products OWNER TO postgres;

--
-- Name: dim_variants; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dim_variants (
    variant_id character varying(50) NOT NULL,
    variant_name character varying(100),
    availability character varying(100),
    color character varying(100)
);


ALTER TABLE public.dim_variants OWNER TO postgres;

--
-- Name: fact_catalog; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fact_catalog (
    product_id character varying(50) NOT NULL,
    category_id character varying(50) NOT NULL,
    variant_id character varying(50) NOT NULL,
    measurement_id integer NOT NULL,
    price numeric
);


ALTER TABLE public.fact_catalog OWNER TO postgres;

--
-- Data for Name: dim_category; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dim_category (category_id, name) FROM stdin;
C001	Dress
C002	Top
C003	Outerwear
C004	Card
C005	Pants
C006	Skirt
C007	Overall
C008	Accesories
C009	Blanket
C010	Cushion
C011	Vests
\.


--
-- Data for Name: dim_measurements; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dim_measurements (measurement_id, size_name, detail) FROM stdin;
1	ALL SIZE	{'bust': '84-100 cm', 'waist': '80-100 cm', 'length': '115 cm', 'armhole': '45 cm'}
2	ALL SIZE	{'bust': '100 cm', 'waist': '100 cm', 'length': '116 cm', 'armhole': '48 cm', 'sleeve length': '57 cm'}
3	XS	{'waist': '66 - 72 cm', 'hip': '80 - 86 cm', 'length': '100 cm', 'thigh': '48 - 52 cm', 'front/back rise': '28 cm/38 cm'}
4	SMALL	{'waist': '70 - 76 cm', 'hip': '84 - 90 cm', 'length': '102 cm', 'thigh': '50 - 54 cm', 'front/back rise': '28 cm/38 cm'}
5	MEDIUM	{'waist': '74 - 80 cm', 'hip': '88 - 94 cm', 'length': '104 cm', 'thigh': '52 - 56 cm', 'front/back rise': '30 cm/40 cm'}
6	SMALL	{'waist': '66 cm', 'hip': '94 cm', 'length': '35,5 cm', 'front/back rise': '33 cm/40,5 cm'}
7	MEDIUM	{'waist': '70 cm', 'hip': '98 cm', 'length': '36,5 cm', 'front/back rise': '34 cm/41,5 cm'}
8	LARGE	{'waist': '76 cm', 'hip': '102 cm', 'length': '37,5 cm', 'front/back rise': '35 cm/42,5 cm'}
9	ALL SIZE	{'bust': '96-106 cm', 'waist': '90-100 cm', 'length': '54 cm', 'armhole': '48 cm', 'sleeve length': '25 cm'}
10	ALL SIZE	{'bust': '106 cm', 'waist': '122 cm', 'length': '66cm', 'armhole': '48 cm'}
11	ALL SIZE	{'bust': '90 cm', 'waist': '87 cm', 'length': '84 cm', 'sleeve length': '32\\xa0cm', 'armhole': '52 cm'}
12	SMALL	{'waist': '68 cm', 'hip': '92 cm', 'thigh': '58 cm', 'front/back rise': '28 cm/38 cm', 'length': '49 cm'}
13	MEDIUM	{'waist': '72 cm', 'hip': '96 cm', 'thigh': '60 cm', 'front/back rise': '28,5 cm/38,5 cm', 'length': '50 cm'}
14	LARGE	{'waist': '76 cm', 'hip': '100 cm', 'thigh': '62 cm', 'front/back rise': '29 cm/39 cm', 'length': '51 cm'}
15	ALL SIZE	{'waist': '60 - 100 cm', 'hip': '100 cm', 'length': '81 cm'}
16	ALL SIZE	{'bust': '134 cm', 'waist': '134 cm', 'armhole': '40 cm', 'length': '69 cm', 'scarf width x length': '26 cm x 117 cm'}
17	ALL SIZE	{'bust': '92 cm', 'waist': '86 cm', 'armhole': '54 cm', 'sleeve length': '62 cm', 'length': '58 cm'}
18	ALL SIZE	{'bust': '88 cm', 'waist': '80 cm', 'length': '58 cm', 'armhole': '46 cm', 'sleeve length': '59 cm'}
19	ALL SIZE	{'bust': '90 cm', 'waist': '86 cm', 'length': '48 cm', 'sleeve length': '38 cm', 'armhole': '44 cm'}
20	1 ( S FIT TO L )	{'bust': '102cm', 'waist': '100cm', 'length': '65cm', 'sleeve length': '57cm', 'armhole': '46cm'}
21	2 ( L FIT TO XXL )	{'bust': '120cm', 'waist': '120cm', 'length': '74cm', 'sleeve length': '60cm', 'armhole': '50cm'}
22	ALL SIZE	{'bust': '90 cm', 'waist': '86 cm', 'length': '90 cm (include strap)', 'armhole': '58 cm', 'sleeve length': '26 cm'}
23	SMALL	{'waist': '66-70 cm', 'hip': '85-93 cm', 'length': '104 cm'}
24	MEDIUM	{'waist': '68-72 cm', 'hip': '89-97 cm', 'length': '105 cm'}
25	LARGE	{'waist': '72-76 cm', 'hip': '91-99 cm', 'length': '106 cm'}
26	1	{'bust': '84 cm', 'waist': '84 cm', 'length': '52 cm', 'armhole': '52 cm'}
27	2	{'bust': '90 cm', 'waist': '88 cm', 'length': '55 cm', 'armhole': '56 cm'}
28	1	{'bust': '102 cm', 'waist': '102 cm', 'length': '65 cm', 'sleeve length': '38 cm', 'armhole': '65 cm'}
29	2	{'bust': '110 cm', 'waist': '110 cm', 'length': '70 cm', 'sleeve length': '42 cm', 'armhole': '71 cm'}
30	ALL SIZE	{'bust': 'up to 100 cm', 'waist': 'up to 100 cm', 'length': '108 cm', 'armhole': '50cm'}
31	SMALL	{'waist': '60-76 cm', 'hip': '86-100 cm', 'length': '101 cm', 'thigh circumference': '54 cm', 'front rise': '30 cm', 'front/back rise': '37 cm'}
32	MEDIUM	{'waist': '66-82 cm', 'hip': '90-104 cm', 'length': '102 cm', 'thigh circumference': '56 cm', 'front rise': '30 cm', 'front/back rise': '38 cm'}
33	LARGE	{'waist': '70-86 cm', 'hip': '94-108 cm', 'length': '103 cm', 'thigh circumference': '58 cm', 'front rise': '30 cm', 'front/back rise': '38 cm'}
34	1	{'bust': '82 cm', 'waist': '78 cm', 'armhole': '40 cm', 'sleeve length': '28 cm', 'length': '55 cm'}
35	2	{'bust': '92 cm', 'waist': '88 cm', 'armhole': '46 cm', 'sleeve length': '30 cm', 'length': '60 cm'}
36	1	{'bust': '98 cm', 'waist': '98 cm', 'length': '56 cm', 'armhole': '54 cm', 'sleeve length': '27 cm'}
37	2	{'bust': '104 cm', 'waist': '104 cm', 'length': '57,5 cm', 'armhole': '56 cm', 'sleeve length': '28 cm'}
38	SMALL	{'waist': '66 - 84 cm', 'hip': '94 - 104 cm', 'length': '91 cm'}
39	MEDIUM	{'waist': '72 - 90 cm', 'hip': '100 - 110 cm', 'length': '92,5 cm'}
40	1	{'waist': '64 - 80 cm', 'hip': '108 cm', 'length': '100 cm'}
41	2	{'waist': '70 - 86 cm', 'hip': '114 cm', 'length': '100 cm'}
42	ALL SIZE	{'waist': '60 - 100 cm', 'hip': 'up to 100 cm', 'length': '81 cm'}
43	1	{'bust': '92 cm', 'waist': '92 cm', 'length': '54 cm', 'armhole': '44 cm', 'sleeve length': '16 cm'}
44	2	{'bust': '98 cm', 'waist': '98 cm', 'length': '56 cm', 'armhole': '46 cm', 'sleeve length': '17 cm'}
45	ALL SIZE	{'bust': '78 - 96 cm', 'waist': '74 - 92 cm', 'length': '117 cm', 'armhole': '42 cm'}
46	ALL SIZE	{'waist': '70-94cm', 'hip': '96cm', 'length': '100cm'}
47	ALL SIZE	{'bust': '116cm', 'waist': '116cm', 'length': '53cm', 'sleeve length': '59cm', 'armhole': '52cm'}
48	1	{'waist': '62-84 cm', 'hip': 'up to 94 cm', 'length': '100 cm'}
49	2	{'waist': '66-90 cm', 'hip': 'up to 98 cm', 'length': '100 cm'}
50	ALL SIZE	{'bust': 'Up to 120 cm', 'waist': '120 cm', 'length': '108 cm', 'armhole': '51 cm', 'sleeve length': '60 cm'}
51	SMALL	{'waist': '66 cm - 72 cm', 'hip': '96 cm', 'thigh': '60 cm', 'length': '102 cm', 'front/back rise': '30 cm/39 cm'}
52	MEDIUM	{'waist': '70 cm - 76 cm', 'hip': '100 cm', 'thigh': '62 cm', 'length': '103 cm', 'front/back rise': '30,5 cm/39,5 cm'}
53	LARGE	{'waist': '74 cm - 80 cm', 'hip': '104 cm', 'thigh': '64 cm', 'length': '104 cm', 'front/back rise': '31 cm/40 cm'}
54	SMALL	{'bust': '103 cm', 'waist': '68 cm', 'length': '58 cm (from center back)', 'armhole': '42 cm'}
55	MEDIUM	{'bust': '107 cm', 'waist': '72 cm', 'length': '59 cm (from center back)', 'armhole': '44 cm'}
56	LARGE	{'bust': '111 cm', 'waist': '76 cm', 'length': '60 cm (from center back)', 'armhole': '46 cm'}
57	ALL SIZE	{'bust': '100 cm', 'waist': '78 cm', 'length': '60 cm', 'sleeve length': '53 cm', 'armhole': '42 cm'}
58	ALL SIZE	{'waist': '68-90 cm', 'hip': '92 cm', 'length': '42 cm'}
59	ALL SIZE	{'bust': '90 cm', 'waist': '90 cm', 'length': '43 cm', 'armhole': '44 cm', 'sleeve length': '65 cm'}
60	SMALL	{'bust': '92 cm', 'waist': '92 cm', 'length': '55 cm', 'sleeve length': '15 cm', 'armhole': '46 cm'}
61	MEDIUM	{'bust': '100 cm', 'waist': '100 cm', 'length': '58 cm', 'sleeve length': '16 cm', 'armhole': '48 cm'}
62	LARGE	{'bust': '104 cm', 'waist': '104 cm', 'length': '60 cm', 'sleeve length': '17 cm', 'armhole': '50 cm'}
63	ALL SIZE	{'bust': '74 cm - 102 cm', 'waist': '70 cm - 98 cm', 'armhole': '40 cm', 'sleeve length': '58 cm', 'length': '58 cm'}
64	S	{'bust': '70-82 cm', 'waist': '68-80 cm', 'length': '50 cm', 'sleeve length': '18 cm', 'armhole': '39 cm'}
65	M	{'bust': '75-87 cm', 'waist': '73-85 cm', 'length': '51 cm', 'sleeve length': '18 cm', 'armhole': '40 cm'}
66	L	{'bust': '80-92 cm', 'waist': '78-90 cm', 'length': '52 cm', 'sleeve length': '19 cm', 'armhole': '41 cm'}
67	ALL SIZE	{'bust': '84-100 cm', 'waist': '80-95cm', 'length': '124 cm', 'sleeve length': '22 cm', 'armhole': '46 cm'}
68	1	{'bust': '84 cm', 'waist': '80 cm', 'length': '50 cm', 'armhole': '48 cm'}
69	2	{'bust': '96 cm', 'waist': '92 cm', 'length': '55 cm', 'armhole': '52 cm'}
70	SMALL	{'bust': '92 cm', 'waist': '92 cm', 'length': '55 cm', 'armhole': '46 cm', 'sleeve length': '15 cm'}
71	MEDIUM	{'bust': '100 cm', 'waist': '100 cm', 'length': '58 cm', 'armhole': '48 cm', 'sleeve length': '16 cm'}
72	S	{'waist': '66 - 76 cm', 'hip': '88 cm', 'length': '111 cm'}
73	M	{'waist': '70 - 80 cm', 'hip': '92 cm', 'length': '112 cm'}
74	L	{'waist': '74 - 84 cm', 'hip': '96 cm', 'length': '113 cm'}
75	SMALL	{'waist': '68-72 cm', 'hip': '85-89 cm', 'thigh': '50-54 cm', 'front/back rise': '30.5/38.5 cm', 'length': '104 cm'}
76	MEDIUM	{'waist': '71-75 cm', 'hip': '88-92 cm', 'thigh': '54-58 cm', 'front/back rise': '31/39 cm', 'length': '105 cm'}
77	LARGE	{'waist': '74-78 cm', 'hip': '91-95 cm', 'thigh': '56-60 cm', 'front/back rise': '31.5/39.5 cm', 'length': '106 cm'}
78	ALL SIZE	{'waist': '70 cm', 'hip': 'up to 98 cm', 'length': '72.5 cm'}
79	ALL SIZE	{'bust': '104 cm', 'waist': '104 cm', 'length': '50 cm', 'sleeve length': '57 cm', 'armhole': '46 cm'}
80	SMALL	{'waist': '66 - 84 cm', 'hip': '94 - 104 cm', 'length': '91 cm'}
81	MEDIUM	{'waist': '72 - 90 cm', 'hip': '100 - 110 cm', 'length': '92,5 cm'}
82	ALL SIZE	{'bust': '102 cm', 'waist': '112 cm', 'length': '85 cm', 'armhole': '53 cm'}
83	ALL SIZE	{'bust': '88 cm', 'waist': '80 cm', 'length': '58 cm', 'armhole': '46 cm', 'sleeve length': '59 cm'}
84	1	{'bust': '90 cm', 'waist': '100 cm', 'length': '82 cm', 'armhole': '54 cm'}
85	2	{'bust': '100 cm', 'waist': '110 cm', 'length': '84 cm', 'armhole': '58 cm'}
86	1	{'bust': '94 cm', 'waist': '110 cm', 'length': '61 cm', 'armhole': '54 cm'}
87	2	{'bust': '100 cm', 'waist': '116 cm', 'length': '63 cm', 'armhole': '56 cm'}
88	ALL SIZE	{'bust': '100 cm', 'waist': '98 cm', 'length': '62 cm', 'armhole': '50 cm'}
89	SMALL	{'waist': '66 cm - 72 cm', 'hip': '96 cm', 'thigh': '60 cm', 'length': '102 cm', 'front/back rise': '30 cm/39 cm'}
90	MEDIUM	{'waist': '70 cm - 76 cm', 'hip': '100 cm', 'thigh': '62 cm', 'length': '103 cm', 'front/back rise': '30,5 cm/39,5 cm'}
91	LARGE	{'waist': '74 cm - 80 cm', 'hip': '104 cm', 'thigh': '64 cm', 'length': '104 cm', 'front/back rise': '31 cm/40 cm'}
92	ALL SIZE	{'bust': '90 cm', 'waist': '78 cm', 'length': '62 cm', 'armhole': '58 cm', 'sleeve length': '62 cm'}
93	SMALL	{'waist': '66 cm', 'hip': '94 cm', 'thigh': '62 cm', 'length': '102 cm', 'front/back rise': '30 cm/39 cm'}
94	MEDIUM	{'waist': '70 cm', 'hip': '98 cm', 'thigh': '64 cm', 'length': '103 cm', 'front/back rise': '30,5 cm/39,5 cm'}
95	LARGE	{'waist': '76 cm', 'hip': '102 cm', 'thigh': '66 cm', 'length': '104 cm', 'front/back rise': '31 cm/40 cm'}
96	1	{'bust': '94 cm', 'waist': '110 cm', 'length': '61 cm', 'armhole': '54 cm'}
97	2	{'bust': '100 cm', 'waist': '116 cm', 'length': '63 cm', 'armhole': '56 cm'}
98	1	{'bust': '84 cm', 'waist': '74 cm', 'length': '60 cm', 'armhole': '46 cm'}
99	2	{'bust': '90 cm', 'waist': '80 cm', 'length': '61 cm', 'armhole': '48 cm'}
100	1	{'bust': '92 cm', 'waist': '88 cm', 'length': '40 cm', 'sleeve length': '16 cm', 'armhole': '43 cm'}
101	2	{'bust': '100 cm', 'waist': '96 cm', 'length': '44 cm', 'sleevength': '18 cm', 'armhole': '47 cm'}
102	1	{'bust': '80 cm', 'waist': '80 cm', 'length': '52 cm', 'sleeve length': '58 cm', 'armhole': '45 cm', 'center front length': '32 cm'}
103	2CARDIGAN	{'bust': '86 cm', 'waist': '86 cm', 'length': '53 cm', 'sleeve length': '58 cm', 'armhole': '47 cm', 'center front length': '33 cm'}
104	ALL SIZE	{'bust': '88-106 cm', 'waist': '66-92 cm', 'length': '102 cm', 'sleeve length': '52 cm', 'armhole': '42 cm', 'hip': '90-106 cm', 'thigh circumference': '54 cm', 'front rise': '34 cm', 'front/back rise': '40 cm'}
105	ALL SIZE	{'bust': '120 cm', 'waist': '110 cm', 'length': '66 cm'}
106	ALL SIZE	{'bust': '128 cm', 'waist': '86 cm', 'length': '56 cm', 'armhole': '56 cm', 'sleeve length': '47 cm'}
107	ALL SIZE	{'bust': '76 cm - 100 cm', 'waist': '62 cm - 86 cm', 'length': '68 cm', 'armhole': '40 cm', 'sleeve length': '62 cm'}
108	ALL SIZE	{'waist': '64-94 cm', 'hip': '92 cm', 'length': '42 cm'}
109	ALL SIZE	{'size': '52 cm x 24 cm'}
110	1	{'waist': '68 cm', 'hip': '100 cm', 'length': '37 cm'}
111	2	{'waist': '74 cm', 'hip': '106 cm', 'length': '38 cm'}
112	ALL SIZE	{'bust': 'up to 90 cm', 'waist': '84cm', 'length': '48cm', 'armhole': '47cm'}
113	SMALL	{'waist': '62 - 72 cm', 'hip': '94 cm', 'thigh': '62 cm', 'length': '90 cm', 'front/back rise': '33 cm/42 cm'}
114	MEDIUM	{'waist': '66 cm - 76 cm', 'hip': '98 cm', 'thigh': '64 cm', 'length': '90 cm', 'front/back rise': '33,5 cm/42,5 cm'}
115	LARGE	{'waist': '70 cm - 80 cm', 'hip': '102 cm', 'thigh': '66 cm', 'length': '91 cm', 'front/back rise': '34 cm/43 cm'}
116	ALL SIZE	{'bust': '120 cm', 'waist': '122 cm', 'length': '73 cm', 'sleeve length': '18 cm', 'armhole': '50 cm'}
117	ALL SIZE	{'bust': '120 cm', 'waist': '122 cm', 'length': '73 cm', 'sleeve length': '18 cm', 'armhole': '50 cm'}
118	1	{'bust': '96 cm', 'waist': '80 cm', 'length': '54 cm', 'armhole': '40 cm', 'sleeve length': '55 cm'}
893	SMALL	{'waist': '64 cm', 'hip': '85 cm', 'length': '104 cm'}
119	2	{'bust': '104 cm', 'waist': '88 cm', 'length': '56 cm', 'armhole': '43 cm', 'sleeve\\xa0length': '56\\xa0cm'}
120	ALL SIZE	{'bust': '74 cm - 102 cm', 'waist': '70 cm - 98 cm', 'armhole': '40 cm', 'sleeve length': '58 cm', 'length': '58 cm'}
121	ALL SIZE	{'waist': '68-110 cm', 'hip': 'up to 120 cm', 'length': '100 cm'}
122	ALL SIZE	{'bust': '94 cm', 'waist': '98 cm', 'armhole': '48 cm', 'length': '115 cm'}
123	ALL SIZE	{'bust': '112 cm', 'waist': '110 cm', 'length': '50 cm', 'sleeve length': '62 cm', 'armhole': '52 cm'}
124	ALL SIZE	{'waist': '66-90 cm', 'hip': 'up to 98 cm', 'length': '96 cm'}
125	ALL SIZE	{'bust': '90 cm', 'waist': '76 cm', 'length': '60 cm', 'armhole': '58 cm', 'sleeve length': '62 cm'}
126	1	{'bust': '90 cm', 'waist': '78 cm', 'length': '62 cm (from center)', 'armhole': '48 cm', 'sleeve length': '20 cm'}
127	2	{'bust': '96 cm', 'waist': '84 cm', 'length': '64 cm (from center)', 'armhole': '51 cm', 'sleeve length': '21 cm'}
128	ALL SIZE	{'bust': '110 cm', 'waist': '110 cm', 'length': '70 cm', 'armhole': '50 cm', 'sleeve length': '77 cm'}
129	ALL SIZE	{'bust': '100 cm', 'waist': '104 cm', 'armhole': '54 cm', 'sleeve length': '16 cm', 'length': '63 cm'}
130	SMALL	{'waist': '70 - 80 cm', 'hip': '86 - 96 cm', 'thigh': '54 - 58 cm', 'front/back rise': '27/37 cm', 'length': '100 cm'}
131	MEDIUM	{'waist': '74 - 84 cm', 'hip': '92 - 102 cm', 'thigh': '60\\xa0 - 64 cm', 'front/back rise': '27/37 cm', 'length': '102 cm'}
132	LARGE	{'waist': '78 - 88 cm', 'hip': '96 - 106 cm', 'thigh': '64 - 68 cm', 'front/back rise': '29/38 cm', 'length': '104 cm'}
133	ALL SIZE	{'bust': '114 cm', 'waist': '118 cm', 'armhole': '62 cm', 'sleeve length': '46 cm', 'front length/back length': '75/80 cm'}
134	ALL SIZE	{'bust': '90 cm', 'waist': '90 cm', 'length': '43 cm', 'armhole': '44 cm', 'sleeve length': '65 cm'}
135	ALL SIZE	{'bust': '120 cm', 'waist': '116 cm', 'length': '60 cm', 'sleeve length': '53 cm', 'armhole': '44 cm (drop shoulder)'}
136	ALL SIZE	{'bust': '90 cm', 'waist': '86 cm', 'length': '48 cm', 'sleeve length': '38 cm', 'armhole': '44 cm'}
137	ALL SIZE	{'bust': 'up to 95 cm', 'waist': 'up to 90 cm', 'length': '70 cm', 'sleeve length': '28.5 cm', 'armhole': '45 cm'}
138	ALL SIZE	{'bust': '100 cm (up to 120 cm)', 'waist': '100 cm (up to 120 cm)', 'length': '68 cm', 'armhole': '48 cm', 'sleeve length': '20 cm'}
139	ALL SIZE	{'bust': '100 cm', 'waist': '100 cm', 'length': '44 cm', 'armhole': '48 cm', 'sleeve length': '59 cm'}
140	SMALL	{'bust': '85 cm', 'waist': '78 cm', 'armhole': '45 cm', 'length': '65 cm'}
141	MEDIUM	{'bust': '91 cm', 'waist': '84 cm', 'armhole': '47 cm', 'length': '66 cm'}
142	LARGE	{'bust': '97 cm', 'waist': '90 cm', 'armhole': '49 cm', 'length': '67 cm'}
143	ALL SIZE	{'bust': '70 - 90 cm', 'waist': '60 - 80 cm', 'armhole': '40 cm', 'length': '52 cm'}
144	ALL SIZE	{'bust': '92 cm', 'waist': '106 cm', 'length': '130 cm', 'armhole': '54 cm'}
145	1 ( S FIT TO L )	{'bust': '102cm', 'waist': '100cm', 'length': '65cm', 'sleeve length': '57cm', 'armhole': '46cm'}
146	2 ( L FIT TO XXL )	{'bust': '120cm', 'waist': '120cm', 'length': '74cm', 'sleeve length': '60cm', 'armhole': '50cm'}
147	ALL SIZE	{'waist': '62 - 90 cm', 'hip': '130 cm', 'length': '67 cm'}
148	ALL SIZE	{'bust': '98 cm', 'waist': '96 cm', 'armhole': '45 cm', 'sleeve length': '52 cm', 'length': '50 cm'}
149	ALL SIZE	{'bust': '110 cm', 'waist': '108 cm', 'length': '74 cm', 'sleeve length': '60 cm', 'armhole': '50 cm'}
150	ALL SIZE	{'bust': 'up to 95 cm', 'waist': 'up to 90 cm', 'length': '70 cm', 'sleeve length': '28.5 cm', 'armhole': '45 cm'}
151	ALL SIZE	{'bust': '102 cm', 'waist': '92 cm', 'length': '117 cm', 'sleeve opening': '35 cm'}
152	1	{'waist': '66 cm', 'hip': '94 cm', 'length': '80 cm'}
153	2	{'waist': '72 cm', 'hip': '100 cm', 'length': '81 cm'}
154	1	{'bust': '80 cm', 'waist': '80 cm', 'length': '52 cm', 'sleeve length': '58 cm', 'armhole': '45 cm', 'center front length': '32 cm'}
155	2CARDIGAN	{'bust': '86 cm', 'waist': '86 cm', 'length': '53 cm', 'sleeve length': '58 cm', 'armhole': '47 cm', 'center front length': '33 cm'}
156	ALL SIZE	{'bust': '102cm', 'waist': '96cm', 'length': '68cm', 'sleeve length': '64cm', 'armhole': '52cm'}
157	ALL SIZE	{'bust': '116 cm', 'waist': '112 cm', 'length': '71 cm', 'sleevelength from shoulder': '76 cm', 'armhole': '50 cm'}
158	ALL SIZE	{'bust': '100 cm', 'waist': '90 cm', 'length': '60 cm', 'armhole': '46 cm', 'sleeve length': '51 cm'}
159	ALL SIZE	{'bust': '94 cm - 112 cm', 'waist': '74 cm - 92 cm', 'length': '64 cm', 'armhole': '40 cm', 'sleeve length': '59 cm'}
160	ALL SIZE	{'bust': '100 cm', 'waist': '104 cm', 'armhole': '54 cm', 'sleeve length': '16 cm', 'length': '63 cm'}
161	ALL SIZE	{'bust': '68 cm', 'waist': '66 cm', 'length': '44 cm', 'sleeve length': '16 cm', 'armhole': '35 cm'}
162	ALL SIZE	{'bust': '100cm', 'waist': '100cm', 'length': '45cm', 'sleeve length': '17cm', 'armhole': '47cm'}
163	ALL SIZE	{'bust': '74-100 cm', 'waist': '74-95 cm', 'armhole': '50 cm', 'sleeve length': '24 cm', 'length': '125 cm'}
164	ALL SIZE	{'small': 'Waist: 70 cm', 'hip': '102 cm', 'length': '33 cm', 'medium': 'Waist: 76 cm'}
165	ALL SIZE	{'waist': '64-100 cm', 'hip': '78-96 cm', 'length': '88 cm'}
166	1	{'bust': '90 cm', 'waist': '90 cm', 'armhole': '46 cm', 'length': '55 cm'}
167	2	{'bust': '98 cm', 'waist': '98 cm', 'armhole': '48 cm', 'length': '57 cm'}
168	ALL SIZE	{'bust': '110 cm', 'waist': '108 cm', 'length': '74 cm', 'sleeve length': '60 cm', 'armhole': '50 cm'}
169	1	{'waist': '70 cm', 'hip': '110 cm', 'length': '100 cm', 'front rise': '31 cm', 'front/back rise': '40 cm'}
170	2	{'waist': '80 cm', 'hip': '118 cm', 'length': '102 cm', 'front rise': '31 cm', 'front/back rise': '40 cm'}
171	ALL SIZE	{'width x length': '96 cm x 90 cm'}
172	1	{'waist': '64 cm - 72 cm', 'hip': '92 cm', 'length': '33 cm', 'thigh': '64 cm', 'front/back rise': '27 cm/32 cm'}
173	2	{'waist': '70 cm - 78 cm', 'hip': '98 cm', 'length': '35 cm', 'thigh': '66 cm', 'front/back rise': '28 cm/33 cm'}
174	1	{'bust': '88 cm', 'waist': '84 cm', 'length': '123 cm', 'armhole': '64 cm'}
175	2	{'bust': '94 cm', 'waist': '90 cm', 'length': '125 cm', 'armhole': '66 cm'}
176	ALL SIZE	{'bust': 'up to 100 cm', 'waist': 'up to 100 cm', 'length': '108 cm', 'armhole': '50cm'}
177	SMALL	{'bust': '84 cm', 'waist': '80 cm (adjustable back buckle)', 'armhole': '44 cm', 'length': '64 cm'}
178	MEDIUM	{'bust': '88 cm', 'waist': '84 cm (adjustable back buckle)', 'armhole': '45 cm', 'length': '65 cm'}
179	LARGE	{'bust': '92 cm', 'waist': '88 cm (adjustable back buckle)', 'armhole': '46 cm', 'length': '66 cm'}
180	ALL SIZE	{'bust': '108 cm', 'waist': '108 cm', 'armhole': '60 cm', 'sleeve length': '58 cm', 'length': '56 cm'}
181	SMALL	{'waist': '60-76 cm', 'hip': '86-100 cm', 'length': '101 cm', 'thigh circumference': '54 cm', 'front rise': '30 cm', 'front/back rise': '37 cm'}
182	MEDIUM	{'waist': '66-82 cm', 'hip': '90-104 cm', 'length': '102 cm', 'thigh circumference': '56 cm', 'front rise': '30 cm', 'front/back rise': '38 cm'}
183	LARGE	{'waist': '70-86 cm', 'hip': '94-108 cm', 'length': '103 cm', 'thigh circumference': '58 cm', 'front rise': '30 cm', 'front/back rise': '38 cm'}
184	XL	{'waist': '76-92 cm', 'hip': '100-112 cm', 'length': '104 cm', 'thigh circumference': '60 cm', 'front rise': '30 cm', 'front/back rise': '39 cm'}
185	ALL SIZE	{'bust': '120 cm', 'waist': '110 cm', 'length': '66 cm'}
186	1	{'bust': '84 cm', 'waist': '88 cm', 'length': '70 cm', 'armhole': '52 cm'}
187	2	{'bust': '92 cm', 'waist': '96 cm', 'length': '71 cm', 'armhole': '54 cm'}
188	ALL SIZE	{'bust': '80-90 cm', 'waist': '74-84 cm', 'length': '62 cm', 'armhole': '42 cm', 'sleeve length': '55 cm'}
189	ALL SIZE	{'bust': '84 cm', 'waist': '86 cm', 'length': '42 cm', 'armhole': '50 cm'}
190	ALL SIZE	{'bust': '72 cm - 100 cm', 'waist': '64 cm - 92 cm', 'armhole': '45 cm', 'length': '57 cm'}
191	ALL SIZE	{'bust': '102 cm', 'waist': '92 cm', 'length': '117 cm', 'sleeve opening': '35 cm'}
192	ALL SIZE	{'bust': 'up to 110 cm', 'waist': 'up to 110 cm', 'length': '70 cm', 'sleeve length': '51 cm', 'armhole': '43 cm'}
193	1	{'bust': '94 cm', 'waist': '94 cm', 'length': '54 cm', 'sleeve length': '44 cm', 'armhole': '44\\xa0cm'}
194	2	{'bust': '102 cm', 'waist': '102 cm', 'length': '58 cm', 'sleeve length': '47 cm', 'armhole': '46 cm'}
195	ALL SIZE	{'waist': 'up to 136 cm', 'hip': 'up to 160 cm', 'length': '84 cm'}
196	ALL SIZE	{'bust': '120 cm', 'waist': '120 cm', 'front length': '69 cm', 'center back length': '83,5 cm', 'sleeve length': '58 cm', 'armhole': '58 cm'}
197	ALL SIZE	{'bust': 'Up to 105 cm', 'waist': '93 cm', 'length': '57 cm', 'armhole': '52 cm', 'circumgerence': 'Up to 105 cm'}
198	ALL SIZE	{'bust': '70 - 100 cm', 'waist': '74 - 110 cm', 'length': '56 cm', 'armhole': '42 cm'}
199	ALL SIZE	{'bust': '100 cm', 'waist': '90 cm', 'length': '72 cm', 'armhole': '50 cm', 'sleeve length': '58 cm'}
200	ALL SIZE	{'bust': '106 cm', 'waist': '100 cm', 'length': '54 cm', 'armhole': '40 cm', '': '41 cm'}
201	ALL SIZE	{'bust': '100 cm', 'waist': '95 cm', 'length': '50cm', 'sleeve length': '53cm'}
202	SMALL	{'bust': '92 cm', 'waist': '92 cm', 'length': '55 cm', 'armhole': '46 cm', 'sleeve length': '15 cm'}
203	MEDIUM	{'bust': '100 cm', 'waist': '100 cm', 'length': '58 cm', 'armhole': '48 cm', 'sleeve length': '16 cm'}
204	1	{'bust': '84 cm', 'waist': '84 cm', 'length': '52 cm', 'armhole': '52 cm'}
205	2	{'bust': '90 cm', 'waist': '88 cm', 'length': '55 cm', 'armhole': '56 cm'}
206	1	{'waist': '66 cm - 76 cm', 'hip': '85 cm - 95 cm', 'length': '90 cm'}
207	2	{'waist': '72 cm - 82 cm', 'hip': '91 cm - 101 cm', 'length': '91 cm'}
208	ALL SIZE	{'bust': '88 cm', 'waist': '86 cm', 'length': '64 cm', 'armhole': '49 cm'}
209	ALL SIZE	{'bust': '86-94 cm', 'waist': '88-96 cm', 'length': '71 cm', 'armhole': '50 cm'}
210	ALL SIZE	{'bust': '96 cm', 'waist': '104 cm', 'length': '66 cm', 'armhole': '44 cm', 'sleeve length': '14 cm'}
211	SMALL	{'waist': '70 cm', 'hip': '94 cm', 'length': '92 cm'}
212	MEDIUM	{'waist': '76 cm', 'hip': '100 cm', 'length': '93 cm'}
213	LARGE	{'waist': '82 cm', 'hip': '106 cm', 'length': '94 cm'}
214	SMALL	{'waist': '66 cm - 84 cm', 'hip': '96 cm', 'thigh': '64 cm', 'length': '107 cm', 'front/back rise': '30 cm/39 cm'}
597	1	{'waist': '64 - 92 cm', 'hip': '92 cm', 'length': '106 cm'}
215	MEDIUM	{'waist': '70 cm - 88 cm', 'hip': '100 cm', 'thigh': '66 cm', 'length': '107 cm', 'front/back rise': '31 cm/40 cm'}
216	LARGE	{'waist': '74 cm - 92 cm', 'hip': '104 cm', 'thigh': '68 cm', 'length': '107 cm', 'front/back rise': '31 cm/40 cm'}
217	SMALL	{'waist': '66 cm - 84 cm', 'hip': '96 cm', 'thigh': '64 cm', 'length': '107 cm', 'front/back rise': '30 cm/39 cm'}
218	MEDIUM	{'waist': '70 cm - 88 cm', 'hip': '100 cm', 'thigh': '66 cm', 'length': '107 cm', 'front/back rise': '31 cm/40 cm'}
219	LARGE	{'waist': '74 cm - 92 cm', 'hip': '104 cm', 'thigh': '68 cm', 'length': '107 cm', 'front/back rise': '31 cm/40 cm'}
220	1	{'bust': '62-82 cm', 'waist': '62-82 cm', 'length': '50 cm', 'sleeve length': '27 cm', 'armhole': '38 cm'}
221	2	{'bust': '72-92 cm', 'waist': '72-92 cm', 'length': '53 cm', 'sleeve length': '30 cm', 'armhole': '40 cm'}
222	1	{'bust': '92 cm', 'waist': '102 cm', 'length': '81 cm', 'armhole': '48 cm'}
223	2	{'bust': '100 cm', 'waist': '110 cm', 'length': '86 cm', 'armhole': '54 cm'}
224	1	{'bust': '84 cm', 'waist': '84 cm', 'length': '53 cm', 'armhole': '44 cm'}
225	2	{'bust': '88 cm', 'waist': '88 cm', 'length': '53 cm', 'armhole': '45 cm'}
226	ALL SIZE	{'waist': '64-100 cm', 'hip': '78-96 cm', 'length': '88 cm'}
227	ALL SIZE	{'bust': '136 cm', 'waist': '126 cm', 'length': '77 cm', 'sleeve length': '43 cm', 'armhole': '52 cm'}
228	1	{'bust': '92 cm', 'waist': '96 cm', 'armhole': '50 cm', 'sleeve length': '58 cm', 'length': '68 cm'}
229	2	{'bust': '100 cm', 'waist': '104 cm', 'armhole': '54 cm', 'sleeve length': '60 cm', 'length': '70 cm'}
230	S	{'bust': '96 cm', 'waist': '88 cm', 'length': '72\\xa0cm', 'sleeve length': '59 cm', 'armhole': '46 cm'}
231	M	{'bust': '100 cm', 'waist': '92 cm', 'length': '73\\xa0cm', 'sleeve length': '59\\xa0cm', 'armhole': '47 cm'}
232	L	{'bust': '104\\xa0cm', 'waist': '96 cm', 'length': '74 cm', 'sleeve length': '59 cm', 'armhole': '48 cm'}
233	ALL SIZE	{'bust': '160 cm', 'length': '61 cm', 'armhole': '32 cm'}
234	1	{'bust': '86 cm', 'waist': '94 cm', 'front length/back length': '62 cm/68 cm', 'armhole': '50 cm'}
894	MEDIUM	{'waist': '66 cm', 'hip': '87 cm', 'length': '105 cm'}
235	2	{'bust': '92 cm', 'waist': '100 cm', 'front length/back length': '63 cm/69 cm', 'armhole': '53 cm'}
236	1	{'bust': '84 cm', 'waist': '78 cm', 'armhole': '47 cm', 'front length/back length': '70 cm/65 cm'}
237	2	{'bust': '90 cm', 'waist': '84 cm', 'armhole': '49 cm', 'front length/back length': '71 cm/66 cm'}
238	ALL SIZE	{'bust': '88 cm', 'waist': '94 cm', 'length': '80 cm', 'armhole': '50 cm'}
239	1	{'bust': '96 cm', 'waist': '112 cm', 'armhole': '46 cm', 'length': '59 cm'}
240	2	{'bust': '102 cm', 'waist': '118 cm', 'armhole': '49 cm', 'length': '61 cm'}
241	1	{'bust': '85 cm', 'waist': '80 cm', 'length': '81 cm', 'armhole': '48 cm'}
242	2	{'bust': '95 cm', 'waist': '90 cm', 'length': '83 cm', 'armhole': '52 cm'}
243	1	{'bust': '90 cm', 'waist': '76 cm', 'length': '60 cm', 'armhole': '48 cm', 'sleeve length': '23 cm'}
244	2	{'bust': '98 cm', 'waist': '84 cm', 'length': '63 cm', 'armhole': '50 cm', 'sleeve length': '23 cm'}
245	S	{'waist': '68 cm', 'hip': '94 cm', 'length': '98 cm'}
246	M	{'waist': '72 cm', 'hip': '100 cm', 'length': '98 cm'}
247	L	{'waist': '76 cm', 'hip': '104 cm', 'length': '98 cm'}
248	ALL SIZE	{'waist': '64-84 cm', 'hip': '92 cm', 'length': '106 cm'}
249	ALL SIZE	{'bust': '82-100 cm', 'waist': '80-98 cm', 'length': '59 cm', 'armhole': '42 cm', 'sleeve length': '59 cm'}
250	ALL SIZE	{'bust': '82-100 cm', 'waist': '80-98 cm', 'length': '59 cm', 'armhole': '42 cm', 'sleeve length': '59 cm'}
251	1	{'bust': '82 cm', 'waist': '74 cm', 'length': '114 cm', 'armhole': '48 cm'}
252	2	{'bust': '88 cm', 'waist': '80 cm', 'length': '116 cm', 'armhole': '50 cm'}
253	S	{'bust': '70-82 cm', 'waist': '68-80 cm', 'length': '50 cm', 'sleeve length': '55 cm', 'armhole': '39\\xa0cm'}
254	M	{'bust': '75-87 cm', 'waist': '73-85 cm', 'length': '51 cm', 'sleeve length': '55 cm', 'armhole': '40 cm'}
255	L	{'bust': '80-92 cm', 'waist': '78-90 cm', 'length': '52 cm', 'sleeve length': '56 cm', 'armhole': '41 cm'}
256	SMALL	{'waist': '70 cm', 'hip': '94 cm', 'length': '92 cm'}
257	MEDIUM	{'waist': '76 cm', 'hip': '100 cm', 'length': '93 cm'}
258	LARGE	{'waist': '82 cm', 'hip': '106 cm', 'length': '94 cm'}
259	1	{'waist': '70 cm', 'hip': '94 cm', 'length': '79 cm'}
260	2	{'waist': '76 cm', 'hip': '100 cm', 'length': '81 cm'}
261	1	{'bust': '92 cm', 'waist': '88 cm', 'length': '40 cm', 'sleeve length': '16 cm', 'armhole': '43 cm'}
262	2	{'bust': '100 cm', 'waist': '96 cm', 'length': '44 cm', 'sleevength': '18 cm', 'armhole': '47 cm'}
263	ALL SIZE	{'bust': '80 cm - 90 cm', 'waist': '72 cm - 82 cm', 'armhole': '45 cm', 'sleeve length': '58 cm', 'length': '58 cm'}
264	ALL SIZE	{'bust': '144 cm', 'waist': '146 cm', 'armhole': '48 cm', 'sleeve length': '48 cm', 'front length/back length': '48 cm/60 cm'}
265	ALL SIZE	{'waist': '64-94 cm', 'hip': '92 cm', 'length': '42 cm'}
266	1	{'bust': '84 cm', 'waist': '84 cm', 'length': '52 cm', 'armhole': '52 cm'}
267	2	{'bust': '90 cm', 'waist': '88 cm', 'length': '55 cm', 'armhole': '56 cm'}
268	ALL SIZE	{'width x length': '96 cm x 90 cm'}
269	ALL SIZE	{'bust': '74 cm - 102 cm', 'waist': '70 cm - 98 cm', 'armhole': '40 cm', 'sleeve length': '58 cm', 'length': '58 cm'}
270	ALL SIZE	{'bust': '110 cm', 'waist': '126 cm', 'length': '80 cm', 'sleeve length': '62 cm', 'armhole': '48 cm'}
271	SMALL	{'bust': '96 cm', 'waist': '96 cm', 'length': '70 cm', 'sleeve length': '20 cm', 'armhole': '52 cm'}
272	MEDIUM	{'bust': '104 cm', 'waist': '104 cm', 'length': '73 cm', 'sleeve length': '22 cm', 'armhole': '54 cm'}
273	LARGE	{'bust': '112 cm', 'waist': '112 cm', 'length': '76 cm', 'sleeve length': '24 cm', 'armhole': '56 cm'}
274	ALL SIZE	{'waist': '66-100 cm', 'hip': '92 cm', 'length': '82 cm'}
275	ALL SIZE	{'waist': '68 up to 108 cm', 'hip': '104 to 116 cm', 'length': '102 cm'}
276	ALL SIZE	{'bust': 'up to 110 cmWaist: 112 cmLength: 67 cmSleevelength: 58 cmArmhole: 49 cm'}
277	SMALL	{'waist': '68 cm', 'hip': '96 cm', 'length': '36 cm', 'front rise': '35 cm', 'front/back rise': '45 cm'}
278	MEDIUM	{'waist': '74 cm', 'hip': '102 cm', 'length': '37 cm', 'front rise': '35.5 cm', 'front/back rise': '45.5 cm'}
279	LARGE	{'waist': '80 cm', 'hip': '108 cm', 'length': '38 cm', 'front rise': '36 cm', 'front/back rise': '46 cm'}
280	ALL SIZE	{'bust': 'up to 120 cm', 'waist': 'up to 120 cm', 'length': '96 cm', 'armhole': '47 cm'}
281	ALL SIZE	{'width x length': '96 cm x 90 cm'}
282	1	{'bust': '84 cm', 'waist': '88 cm', 'armhole': '50 cm', 'length': '81 cm (from strap)'}
283	2	{'bust': '90 cm', 'waist': '94 cm', 'armhole': '52 cm', 'length': '82 cm (from strap)'}
284	ALL SIZE	{'bust': '112cm', 'waist': '108cm', 'length': '53cm', 'sleeve length': '47cm', 'armhole': '35cm'}
285	SMALL	{'waist': '64 cm - 84 cm', 'hip': '94 cm', 'thigh': '64 cm', 'length': '108 cm', 'front/back rise': '30 cm/39 cm'}
286	MEDIUM	{'waist': '68 cm - 88 cm', 'hip': '98 cm', 'thigh': '66 cm', 'length': '108 cm', 'front/back rise': '31 cm/40 cm'}
287	LARGE	{'waist': '72 cm - 92 cm', 'hip': '102 cm', 'thigh': '68 cm', 'length': '109 cm', 'front/back rise': '32 cm/41 cm'}
288	ALL SIZE	{'bust': '110 cm', 'waist': '104 cm', 'length': '118 cm', 'sleeve length': '52 cm', 'armhole': '48 cm'}
289	SMALL	{'bust': '85 cm', 'waist': '78 cm', 'armhole': '45 cm', 'length': '65 cm'}
290	MEDIUM	{'bust': '91 cm', 'waist': '84 cm', 'armhole': '47 cm', 'length': '66 cm'}
291	LARGE	{'bust': '97 cm', 'waist': '90 cm', 'armhole': '49 cm', 'length': '67 cm'}
292	ALL SIZE	{'bust': '130 cm', 'waist': '130 cm', 'length': '76 cm', 'sleeve length': '60 cm', 'armhole': '50 cm'}
293	SMALL	{'waist': '66 cm', 'hip': '94 cm', 'length': '82 cm'}
294	MEDIUM	{'waist': '70 cm', 'hip': '98 cm', 'length': '83 cm'}
295	ALL SIZE	{'bust': '106 cm', 'waist': '110 cm', 'front length': '75 cm', 'back length': '80 cm', 'armhole': '58 cm'}
296	SMALL	{'waist': '68 cm', 'hip': '94 cm', 'thigh': '58 cm', 'length': '105 cm', 'front/back rise': '29 cm/41 cm'}
297	MEDIUM	{'waist': '72 cm', 'hip': '98 cm', 'thigh': '60 cm', 'length': '105 cm', 'front/back rise': '29,5 cm/41,5 cm'}
895	LARGE	{'waist': '70 cm', 'hip': '91 cm', 'length': '106 cm'}
298	LARGE	{'waist': '76 cm', 'hip': '102 cm', 'thigh': '62 cm', 'length': '105 cm', 'front/back rise': '30 cm/42 cm'}
299	ALL SIZE	{'bust': '102 cm', 'waist': '98 cm', 'armhole': '52 cm', 'sleeve length': '28 cm', 'length': '56 cm'}
300	ALL SIZE	{'bust': '102 cm', 'waist': '112 cm', 'length': '85 cm', 'armhole': '53 cm'}
301	ALL SIZE	{'bust': 'Up to 140 cm', 'waist': '136 cm', 'length': '85 cm', 'armhole': '55 cm', 'sleeve length': '49 cm'}
302	SMALL	{'bust': '82 cm', 'waist': '70 cm', 'hip': '94 cm', 'length': '78 cm', 'armhole': '42 cm'}
303	MEDIUM	{'bust': '88 cm', 'waist': '76 cm', 'hip': '100 cm', 'length': '80 cm', 'armhole': '45 cm'}
304	LARGE	{'bust': '94 cm', 'waist': '82 cm', 'hip': '106 cm', 'length': '82 cm', 'armhole': '48 cm'}
305	ALL SIZE	{'bust': '102 cm', 'waist': '103 cm', 'length': '62 cm', 'armhole': '48 cm', 'sleeve length': '6 cm'}
306	ALL SIZE	{'bust': 'up to 125 cm', 'waist': '120 cm', 'length': '61 cm', 'sleeve length': '33 cm', 'armhole': '47 cm'}
307	ALL SIZE	{'bust': '72 cm - 100 cm', 'waist': '64 cm - 92 cm', 'armhole': '45 cm', 'length': '57 cm'}
308	1	{'bust': '92 cm', 'waist': '92 cm', 'length': '54 cm', 'armhole': '44 cm', 'sleeve length': '16 cm'}
309	2	{'bust': '98 cm', 'waist': '98 cm', 'length': '56 cm', 'armhole': '46 cm', 'sleeve length': '17 cm'}
310	ALL SIZE	{'bust': '160 cm', 'length': '61 cm', 'armhole': '32 cm'}
311	ALL SIZE	{'bust': '80-92 cm', 'waist': '66-80 cm', 'length': '60 cm', 'armhole': '44 cm', 'sleeve length': '61 cm'}
312	ALL SIZE	{'bust': '120 cm', 'waist': '110 cm', 'length': '66 cm'}
313	ALL SIZE	{'bust': '100 cm', 'waist': '100 cm', 'length': '50 cm', 'armhole': '44 cm', 'sleeve length': '19 cm'}
314	SMALL	{'waist': '64 - 90 cm', 'hip': '76 - 100 cm', 'length': '93 cm'}
315	MEDIUM	{'waist': '68 - 94 cm', 'hip': '80 - 104 cm', 'length': '93 cm'}
316	LARGE	{'waist': '74 - 100 cm', 'hip': '86 - 110 cm', 'length': '94 cm'}
317	ALL SIZE	{'bust': '116 cm', 'length': '50 cm', 'sleeve length': '30 cm', 'armhole': '50 cm'}
318	1	{'bust': '62-82 cm', 'waist': '62-82 cm', 'length': '50 cm', 'sleeve length': '27 cm', 'armhole': '38 cm'}
319	2	{'bust': '72-92 cm', 'waist': '72-92 cm', 'length': '53 cm', 'sleeve length': '30 cm', 'armhole': '40 cm'}
320	ALL SIZE	{'bust': '100-114 cm', 'waist': '100-114 cm', 'length': '62 cm', 'armhole': '46 cm', 'sleeve length': '17.5 cm'}
321	ALL SIZE	{'waist': '68-90 cm', 'hip': '92 cm', 'length': '42 cm'}
322	ALL SIZE	{'bust': '110 cm', 'waist': '106 cm', 'length': '68 cm', 'armhole': '48 cm', 'sleeve length': '62 cm'}
323	SMALL	{'bust': '86 - 120 cm', 'waist': '80 - 116 cm', 'length': '60 cm', 'sleeve length': '18 cm', 'armhole': '45 cm'}
324	MEDIUM	{'bust': '90 - 124 cm', 'waist': '84 - 118 cm', 'length': '62 cm', 'sleeve length': '19 cm', 'armhole': '46 cm'}
325	SMALL	{'waist': '68 cm', 'hip': '96 cm', 'thigh': '68 cm', 'front/back rise': '31 cm/41 cm', 'length': '104 cm'}
598	2	{'waist': '70 - 102 cm', 'hip': '102 cm', 'length': '107 cm'}
326	MEDIUM	{'waist': '72 cm', 'hip': '100 cm', 'thigh': '70 cm', 'front/back rise': '32 cm/42 cm', 'length': '105 cm'}
327	LARGE	{'waist': '76 cm', 'hip': '104 cm', 'thigh': '72 cm', 'front/back rise': '33 cm/43 cm', 'length': '106 cm'}
328	XL	{'waist': '85 cm', 'hip': '116 cm', 'thigh': '74 cm', 'front/back rise': '33 cm/43 cm', 'length': '106 cm'}
329	SMALL	{'bust': '85 cm', 'waist': '70 cm', 'hip': '110 cm', 'length': '118 cm', 'armhole': '45 cm'}
330	MEDIUM	{'bust': '89 cm', 'waist': '74 cm', 'hip': '114 cm', 'length': '120 cm', 'armhole': '47 cm'}
331	LARGE	{'bust': '93 m', 'waist': '78 cm', 'hip': '118 cm', 'length': '122 cm', 'armhole': '49 cm'}
332	ALL SIZE	{'bust': '80-92 cm', 'waist': '66-80 cm', 'length': '60 cm', 'armhole': '44 cm', 'sleeve length': '61 cm'}
333	SMALL	{'bust': '103 cm', 'waist': '68 cm', 'length': '58 cm (from center back)', 'armhole': '42 cm'}
334	MEDIUM	{'bust': '107 cm', 'waist': '72 cm', 'length': '59 cm (from center back)', 'armhole': '44 cm'}
335	LARGE	{'bust': '111 cm', 'waist': '76 cm', 'length': '60 cm (from center back)', 'armhole': '46 cm'}
336	ALL SIZE	{'bust': '102 cm', 'waist': '112 cm', 'length': '66 cm', 'armhole': '46 cm'}
337	SMALL	{'waist': '70 cm', 'hip': '92 cm', 'length': '38 cm'}
338	MEDIUM	{'waist': '76 cm', 'hip': '98 cm', 'length': '40 cm'}
339	SMALL	{'waist': '64 cm - 84 cm', 'hip': '94 cm', 'thigh': '64 cm', 'length': '108 cm', 'front/back rise': '30 cm/39 cm'}
340	MEDIUM	{'waist': '68 cm - 88 cm', 'hip': '98 cm', 'thigh': '66 cm', 'length': '108 cm', 'front/back rise': '31 cm/40 cm'}
341	LARGE	{'waist': '72 cm - 92 cm', 'hip': '102 cm', 'thigh': '68 cm', 'length': '109 cm', 'front/back rise': '32 cm/41 cm'}
342	S	{'bust': '70-82 cm', 'waist': '68-80 cm', 'length': '50 cm', 'sleeve length': '18 cm', 'armhole': '39 cm'}
343	M	{'bust': '75-87 cm', 'waist': '73-85 cm', 'length': '51 cm', 'sleeve length': '18 cm', 'armhole': '40 cm'}
344	L	{'bust': '80-92 cm', 'waist': '78-90 cm', 'length': '52 cm', 'sleeve length': '19 cm', 'armhole': '41 cm'}
345	ALL SIZE	{'bust': 'up to 115 cm', 'waist': 'up to 115 cm', 'length': '56 cm', 'sleeve length': '54 cm', 'armhole': '44 cm'}
346	ALL SIZE	{'bust': '78 cm - 90 cm', 'waist': '72 cm - 84 cm', 'length': '54 cm', 'armhole': '46 cm'}
347	ALL SIZE	{'bust': '92 cm', 'waist': '88 cm', 'length': '66 cm', 'sleeve length': '28 cm', 'armhole': '54 cm'}
348	1	{'bust': '78 cm - 88 cm', 'waist': '74 cm - 84 cm', 'length': '43 cm', 'armhole': '42 cm', 'sleeve length': '26 cm'}
349	2	{'bust': '84 cm - 94 cm', 'waist': '84 cm - 94 cm', 'length': '47 cm', 'armhole': '44 cm', 'sleeve length': '29 cm'}
350	SMALL	{'waist': '66 cm - 86 cm', 'hip': '96 cm', 'thigh': '64 cm', 'length': '108 cm', 'front/back rise': '30 cm/39 cm'}
351	MEDIUM	{'waist': '70 cm - 90 cm', 'hip': '100 cm', 'thigh': '66 cm', 'length': '108 cm', 'front/back rise': '31 cm/40 cm'}
352	ALL SIZE	{'bust': '94 cm', 'waist': '72 cm', 'length': '84 cm', 'armhole': '54 cm', 'hip': '108 cm'}
353	ALL SIZE	{'bust': 'Up to 106 cm', 'waist': '105 cm', 'length': '65 cm', 'armhole': '49 cm', 'sleeve length': '57 cm'}
354	ALL SIZE	{'bust': '94 cm', 'waist': '92 cm', 'armhole': '44 cm', 'sleeve length': '55 cm', 'length': '50 cm'}
355	ALL SIZE	{'waist': '68 - 100 cm', 'hips': '78 - 96 cm', 'length': '106 cm'}
356	SMALL	{'bust': '80 cm', 'waist': '74 cm', 'armhole': '45 cm', 'length': '66 cm'}
357	MEDIUM	{'bust': '84 cm', 'waist': '78 cm', 'armhole': '46 cm', 'length': '67,5 cm'}
358	LARGE	{'bust': '90 cm', 'waist': '84 cm', 'armhole': '47 cm', 'length': '69 cm'}
359	1	{'bust': '82 cm', 'waist': '78 cm', 'armhole': '40 cm', 'sleeve length': '28 cm', 'length': '55 cm'}
360	2	{'bust': '92 cm', 'waist': '88 cm', 'armhole': '46 cm', 'sleeve length': '30 cm', 'length': '60 cm'}
361	SMALL	{'waist': '66 cm', 'hip': '94 cm', 'length': '47 cm'}
362	MEDIUM	{'waist': '72 cm', 'hip': '100 cm', 'length': '49 cm'}
363	LARGE	{'waist': '78 cm', 'hip': '106 cm', 'length': '51 cm'}
364	ALL SIZE	{'bust': '120 cm', 'waist': '132 cm', 'length': '84 cm', 'armhole': '55 cm', 'sleeve length': '27 cm'}
365	ALL SIZE	{'bust': '102 cm', 'waist': '102 cm', 'length': '42 cm', 'armhole': '44 cm', 'sleeve length': '56 cm'}
366	1	{'bust': '96 cm', 'waist': '80 cm', 'length': '54 cm', 'armhole': '40 cm', 'sleeve length': '55 cm'}
367	2	{'bust': '104 cm', 'waist': '88 cm', 'length': '56 cm', 'armhole': '43 cm', 'sleeve\\xa0length': '56\\xa0cm'}
368	ALL SIZE	{'bust': '114 cm', 'waist': '114 cm', 'length': '75 cm', 'sleeve length': '60 cm', 'armhole': '56 cm'}
369	S	{'waist': '66 - 76 cm', 'hip': '88 cm', 'length': '111 cm'}
370	M	{'waist': '70 - 80 cm', 'hip': '92 cm', 'length': '112 cm'}
371	L	{'waist': '74 - 84 cm', 'hip': '96 cm', 'length': '113 cm'}
372	ALL SIZE	{'bust': '96 cm', 'waist': '100 cm', 'length from center front': '145 cm'}
373	SMALL	{'waist': '64 cm', 'hip': '85 cm', 'length': '104 cm'}
374	MEDIUM	{'waist': '66 cm', 'hip': '87 cm', 'length': '105 cm'}
375	LARGE	{'waist': '70 cm', 'hip': '91 cm', 'length': '106 cm'}
376	EXTRA LARGE	{'waist': '74 cm', 'hip': '95 cm', 'length': '107 cm'}
377	ALL SIZE	{'bust': '108 cm', 'waist': '106 cm', 'armhole': '48 cm', 'sleeve length': '56 cm', 'length': '60 cm'}
378	ALL SIZE	{'bust': '74-100 cm', 'waist': '74-95 cm', 'armhole': '50 cm', 'sleeve length': '24 cm', 'length': '125 cm'}
379	1	{'bust': '85 cm', 'waist': '82 cm', 'length': '45 cm', 'armhole': '48 cm'}
380	2	{'bust': '95 cm', 'waist': '92 cm', 'length': '50 cm', 'armhole': '52 cm'}
381	ALL SIZE	{'bust': '116 cm', 'waist': '116 cm', 'armhole': '30 cm - 45 cm (dropped shoulder)', 'sleeve length': '43 cm', 'length': '62 cm'}
382	1	{'bust': '82 cm', 'waist': '76 cm', 'length': '65 cm', 'armhole': '46 cm'}
383	2	{'bust': '90 cm', 'waist': '82 cm', 'length': '66 cm', 'armhole': '47 cm'}
384	1	{'bust': '92 cm', 'waist': '125 cm', 'length': '131 cm', 'armhole': '60 cm'}
385	2	{'bust': '100 cm', 'waist': '130 cm', 'length': '132 cm', 'armhole': '64 cm'}
386	ALL SIZE	{'bust': '120 cm', 'waist': '110 cm', 'length': '66 cm'}
387	ALL SIZE	{'bust': '112 cm', 'waist': '112 cm', 'armhole': '60 cm', 'sleeve length': '57 cm', 'puffer length': '60 cm', 'inner vest length': '63 cm'}
388	SMALL	{'waist': '68 cm', 'hip': '98 cm', 'thigh': '62 cm', 'length': '100 cm', 'front/back rise': '27 cm/37 cm'}
389	MEDIUM	{'waist': '72 cm', 'hip': '102 cm', 'thigh': '64 cm', 'length': '101 cm', 'front/back rise': '27,5 cm/37,5 cm'}
390	LARGE	{'waist': '76 cm', 'hip': '106 cm', 'thigh': '66 cm', 'length': '102 cm', 'front/back rise': '28 cm/38 cm'}
391	ALL SIZE	{'bust': '90-100 cm', 'waist': '76-90 cm', 'length': '55 cm', 'armhole': '42 cm', 'sleeve length': '64 cm'}
392	SMALL	{'bust': '86 - 120 cm', 'waist': '80 - 116 cm', 'length': '60 cm', 'sleeve length': '18 cm', 'armhole': '45 cm'}
393	MEDIUM	{'bust': '90 - 124 cm', 'waist': '84 - 118 cm', 'length': '62 cm', 'sleeve length': '19 cm', 'armhole': '46 cm'}
394	ALL SIZE	{'bust': '110 cm', 'waist': '104 cm', 'length': '118 cm', 'sleeve length': '52 cm', 'armhole': '48 cm'}
395	1	{'bust': '84 cm', 'waist': '82 cm (adjustable back belt)', 'armhole': '42 cm', 'length': '61 cm'}
396	2	{'bust': '92 cm', 'waist': '90 cm (adjustable back belt)', 'armhole': '45 cm', 'length': '63 cm'}
397	SMALL	{'bust': '92 cm', 'waist': '92 cm', 'length': '55 cm', 'armhole': '46 cm', 'sleeve length': '15 cm'}
398	MEDIUM	{'bust': '100 cm', 'waist': '100 cm', 'length': '58 cm', 'armhole': '48 cm', 'sleeve length': '16 cm'}
399	ALL SIZE	{'bust': '108 cm', 'waist': '106 cm', 'armhole': '48 cm', 'sleeve length': '56 cm', 'length': '60 cm'}
400	1	{'bust': '98 cm', 'waist': '78 cm', 'length': '53 cm', 'armhole': '46 cm', 'sleeve length': '23 cm'}
401	2	{'bust': '106 cm', 'waist': '84 cm', 'length': '55 cm', 'armhole': '51 cm', 'sleeve length': '24 cm'}
402	ALL SIZE	{'bust': '92 cm', 'waist': '96 cm', 'length': '88 cm', 'armhole': '54 cm', 'sleeve length': '50 cm'}
403	ALL SIZE	{'bust': '98 cm', 'waist': '96 cm', 'length': '55 cm', 'armhole': '48 cm', 'sleeve length': '61 cm'}
404	ALL SIZE	{'bust': '104 cm', 'waist': '104 cm', 'length': '45 cm', 'sleeve length': '17,5 cm', 'armhole': '50 cm'}
405	ALL SIZE	{'bust': '144 cm', 'waist': '140 cm', 'length': '70 cm', 'sleeve length': '45 cm', 'armhole': '46 cm'}
406	ALL SIZE	{'bust': '100 cm', 'waist': '100 cm', 'length': '116 cm', 'armhole': '48 cm', 'sleeve length': '57 cm'}
407	SMALL	{'waist': '68 - 78 cm', 'hip': '86 - 96 cm', 'thigh': '56 - 60 cm', 'front/back rise': '29/39 cm', 'length': '103 cm'}
408	MEDIUM	{'waist': '72 - 82 cm', 'hip': '90 - 100 cm', 'thigh': '58 - 62 cm', 'front/back rise': '30/40 cm', 'length': '104 cm'}
409	LARGE	{'waist': '76 - 86 cm', 'hip': '94 - 104 cm', 'thigh': '60-64 cm', 'front/back rise': '31/41 cm', 'length': '105 cm'}
410	SMALL	{'waist': '66 - 76 cm', 'hip': '82 - 92 cm', 'thigh': '54 - 58 cm', 'front/back rise': '29/39 cm', 'length': '103 cm'}
411	MEDIUM	{'waist': '70 - 80 cm', 'hip': '86 - 96 cm', 'thigh': '56 - 60 cm', 'front/back rise': '30/40 cm', 'length': '104 cm'}
412	LARGE	{'waist': '74 - 84 cm', 'hip': '90 - 100 cm', 'thigh': '58 - 62 cm', 'front/back rise': '31/41 cm', 'length': '105 cm'}
413	1	{'bust': '82-86 cm', 'waist': '70-74 cm', 'length': '57 cm', 'armhole': '46 cm'}
414	2	{'bust': '88-92 cm', 'waist': '76-80 cm', 'length': '58 cm', 'armhole': '50 cm'}
415	SMALL	{'waist': '68 cm', 'hip': '96 cm', 'thigh': '70 cm', 'front/back rise': '33/41 cm', 'length': '34 cm'}
416	MEDIUM	{'waist': '74 cm', 'hip': '102 cm', 'thigh': '72 cm', 'front/back rise': '34/42 cm', 'length': '35 cm'}
417	LARGE	{'waist': '80 cm', 'hip': '108 cm', 'thigh': '74 cm', 'front/back rise': '35/43 cm', 'length': '36 cm'}
418	SMALL	{'waist': '68 cm', 'hip': '102 cm', 'length': '81 cm'}
419	MEDIUM	{'waist': '72 cm', 'hip': '106 cm', 'length': '83 cm'}
420	LARGE	{'waist': '76 cm', 'hip': '110 cm', 'length': '85 cm'}
421	1 :	{'waist': '68 cm', 'hip': '92 cm', 'length': '36 cm'}
422	2 :	{'waist': '74 cm', 'hip': '100 cm', 'length': '37 cm'}
423	1	{'bust': '94 cm', 'waist': '110 cm', 'length': '61 cm', 'armhole': '54 cm'}
424	2	{'bust': '100 cm', 'waist': '116 cm', 'length': '63 cm', 'armhole': '56 cm'}
425	1	{'bust': '85 cm', 'waist': '82 cm', 'length': '45 cm', 'armhole': '48 cm'}
426	2	{'bust': '95 cm', 'waist': '92 cm', 'length': '50 cm', 'armhole': '52 cm'}
427	ALL SIZE	{'waist': '68 up to 108 cm', 'hip': '104 to 116 cm', 'length': '102 cm'}
428	ALL SIZE	{'bust': '100 cm', 'waist': '100 cm', 'length': '62 cm', 'sleeve length': '22 cm', 'armhole': '45 cm'}
429	SMALL	{'waist': '68 cm', 'hip': '96 cm', 'thigh': '68 cm', 'front/back rise': '31 cm/41 cm', 'length': '104 cm'}
430	MEDIUM	{'waist': '72 cm', 'hip': '100 cm', 'thigh': '70 cm', 'front/back rise': '32 cm/42 cm', 'length': '105 cm'}
431	LARGE	{'waist': '76 cm', 'hip': '104 cm', 'thigh': '72 cm', 'front/back rise': '33 cm/43 cm', 'length': '106 cm'}
432	XL	{'waist': '85 cm', 'hip': '116 cm', 'thigh': '74 cm', 'front/back rise': '33 cm/43 cm', 'length': '106 cm'}
433	ALL SIZE	{'bust': '106 cm', 'waist': '102 cm', 'length': '70 cm', 'sleeve length': '64 cm', 'armhole': '50 cm'}
434	ALL SIZE	{'bust': '100 cm', 'waist': '98 cm', 'length': '62 cm', 'armhole': '50 cm'}
435	ALL SIZE	{'bust': '100 cm', 'waist': '100 cm', 'length': '116 cm', 'armhole': '48 cm', 'sleeve length': '57 cm'}
436	ALL SIZE	{'bust': '108 cm', 'waist': '112 cm', 'front length': '49 cm', 'back length': '60 cm', 'sleeve length': '58 cm', 'armhole': '48 cm'}
437	ALL SIZE	{'bust': '102 cm', 'waist': '92 cm', 'armhole': '40 cm', 'sleeve length': '48 cm', 'length': '57 cm', 'scarf width x length': '10 x 185 cm'}
438	ALL SIZE	{'bust': '112cm', 'waist': '108cm', 'length': '53cm', 'sleeve length': '47cm', 'armhole': '35cm'}
439	ALL SIZE	{'bust': '100 cm', 'waist': '100 cm', 'length': '50 cm', 'armhole': '44 cm', 'sleeve length': '19\\xa0cm'}
440	1	{'waist': '64 - 92 cm', 'hip': '92 cm', 'length': '106 cm'}
441	2	{'waist': '70 - 102 cm', 'hip': '102 cm', 'length': '107 cm'}
442	SMALL	{'waist': '64 cm', 'hip': '85 cm', 'length': '103 cm'}
443	MEDIUM	{'waist': '66 cm', 'hip': '87 cm', 'length': '104 cm'}
444	LARGE	{'waist': '70 cm', 'hip': '91 cm', 'length': '105 cm'}
445	ALL SIZE	{'bust': '120 cm', 'length': '70 cm', 'armhole': '50 cm'}
446	ALL SIZE	{'size': '52 cm x 24 cm'}
447	ALL SIZE	{'bust': '66 cm - 92 cm', 'waist': '60 cm - 86 cm', 'length': '108 cm', 'armhole': '36 cm', 'shoulder circumference': '68 cm - 114 cm'}
448	ALL SIZE	{'bust': '96 - 112 cm', 'waist': '92 - 108 cm', 'length': '52 cm', 'sleeve length': '22 cm', 'armhole': '44 cm'}
449	ALL SIZE	{'bust': '82-100 cm', 'waist': '80-98 cm', 'length': '59 cm', 'armhole': '42 cm', 'sleeve length': '59 cm'}
450	ALL SIZE	{'bust': '88 cm', 'waist': '94 cm', 'length': '80 cm', 'armhole': '50 cm'}
451	ALL SIZE	{'bust': '144 cm', 'waist': '140 cm', 'length': '70 cm', 'sleeve length': '45 cm', 'armhole': '46 cm'}
452	1	{'bust': '86 cm', 'waist': '88 cm', 'length from center front': '56,5 cm'}
453	2	{'bust': '92 cm', 'waist': '94 cm', 'length from center front': '58 cm'}
454	1	{'bust': '90 cm', 'waist': '78 cm', 'length': '62 cm (from center)', 'armhole': '48 cm', 'sleeve length': '20 cm'}
455	2	{'bust': '96 cm', 'waist': '84 cm', 'length': '64 cm (from center)', 'armhole': '51 cm', 'sleeve length': '21 cm'}
456	1	{'bust': '96 cm', 'waist': '66 cm', 'length': '92 cm', 'armhole': '46 cm', 'sleeve length': '60 cm', 'hip': '90 cm'}
457	2	{'bust': '104 cm', 'waist': '72 cm', 'length': '94 cm', 'armhole': '50 cm', 'sleeve length': '62 cm', 'hip': '96 cm'}
458	1	{'bust': '102 cm', 'waist': '102 cm', 'length': '65 cm', 'sleeve length': '38 cm', 'armhole': '65 cm'}
459	2	{'bust': '110 cm', 'waist': '110 cm', 'length': '70 cm', 'sleeve length': '42 cm', 'armhole': '71 cm'}
460	S	{'waist': '66 cm', 'hip': '98 cm', 'length': '80 cm'}
461	M	{'waist': '72 cm', 'hip': '104 cm', 'length': '82 cm'}
462	L	{'waist': '78 cm', 'hip': '110 cm', 'length': '84 cm'}
463	ALL SIZE	{'waist': '70 cm', 'hip': 'up to 98 cm', 'length': '72.5 cm'}
464	ALL SIZE	{'bust': '74 cm - 102 cm', 'waist': '70 cm - 98 cm', 'armhole': '40 cm', 'sleeve length': '58 cm', 'length': '58 cm'}
465	1	{'bust': '84 cm', 'waist': '82 cm (adjustable back belt)', 'armhole': '42 cm', 'length': '61 cm'}
466	2	{'bust': '92 cm', 'waist': '90 cm (adjustable back belt)', 'armhole': '45 cm', 'length': '63 cm'}
467	1	{'bust': '90 cm', 'waist': '94 cm', 'armhole': '47 cm', 'sleeve length': '21 cm', 'length': '80 cm'}
468	2	{'bust': '96 cm', 'waist': '100 cm', 'armhole': '49 cm', 'sleeve length': '23 cm', 'length': '82 cm'}
469	1	{'bust': '96 cm', 'waist': '94 cm', 'armhole': '54 cm', 'sleeve length': '63 cm', 'length': '56 cm'}
470	2	{'bust': '104 cm', 'waist': '102 cm', 'armhole': '56 cm', 'sleeve length': '65 cm', 'length': '58 cm'}
471	ALL SIZE	{'bust': '102 cm - 107 cm', 'waist': '76 cm - 81 cm', 'length': '48 cm', 'armhole': '40 cm - 50 cm', 'sleeve length': '59 cm'}
472	SMALL	{'waist': '62 - 72 cm', 'hip': '94 cm', 'thigh': '62 cm', 'length': '90 cm', 'front/back rise': '33 cm/42 cm'}
473	MEDIUM	{'waist': '66 cm - 76 cm', 'hip': '98 cm', 'thigh': '64 cm', 'length': '90 cm', 'front/back rise': '33,5 cm/42,5 cm'}
474	LARGE	{'waist': '70 cm - 80 cm', 'hip': '102 cm', 'thigh': '66 cm', 'length': '91 cm', 'front/back rise': '34 cm/43 cm'}
475	1	{'waist': '66 cm', 'hip': '98 cm', 'length': '78 cm'}
476	2	{'waist': '74 cm', 'hip': '110 cm', 'length': '80 cm'}
477	1	{'bust': '98 cm', 'waist': '78 cm', 'length': '53 cm', 'armhole': '46 cm', 'sleeve length': '23 cm'}
478	2	{'bust': '106 cm', 'waist': '84 cm', 'length': '55 cm', 'armhole': '51 cm', 'sleeve length': '24 cm'}
479	ALL SIZE	{'bust': '114 cm', 'waist': '150 cm', 'length': '83 cm', 'armhole': '50 cm', 'sleeve length': '66 cm'}
480	1	{'bust': '88-96 cm', 'waist': '72-80 cm', 'length': '49 cm', 'armhole': '42 cm', 'sleeve length': '21 cm'}
481	2	{'bust': '98-106 cm', 'waist': '92-100 cm', 'length': '50 cm', 'armhole': '44 cm', 'sleeve\\xa0length': '21\\xa0cm'}
482	1	{'bust': '85 cm', 'waist': '85 cm', 'length': '52 cm', 'armhole': '50 cm'}
483	2	{'bust': '91 cm', 'waist': '91 cm', 'length': '54 cm', 'armhole': '52 cm'}
484	SMALL	{'waist': '66 cm - 84 cm', 'hip': '96 cm', 'thigh': '64 cm', 'length': '105 cm', 'front/back rise': '30 cm/39 cm'}
485	MEDIUM	{'waist': '70 cm - 88 cm', 'hip': '100 cm', 'thigh': '66 cm', 'length': '105 cm', 'front/back rise': '31 cm/40 cm'}
486	LARGE	{'waist': '74 cm - 92 cm', 'hip': '104 cm', 'thigh': '68 cm', 'length': '106 cm', 'front/back rise': '31 cm/40 cm'}
487	1	{'bust': '90 cm', 'waist': '76 cm', 'length': '60 cm', 'armhole': '48 cm', 'sleeve length': '23 cm'}
488	2	{'bust': '98 cm', 'waist': '84 cm', 'length': '63 cm', 'armhole': '50 cm', 'sleeve length': '23 cm'}
489	1	{'bust': '98 cm', 'waist': '100 cm', 'length': '67 cm', 'armhole': '54 cm', 'sleeve length': '60 cm'}
490	2	{'bust': '106 cm', 'waist': '108 cm', 'length': '68 cm', 'armhole': '56 cm', 'sleeve length': '61 cm'}
491	ALL SIZE	{'bust': '100 cm', 'waist': '100 cm', 'length': '118 cm', 'armhole': '50 cm', 'sleeve length': '58 cm'}
492	ALL SIZE	{'bust': '90 cm', 'waist': '94 cm', 'armhole': '60 cm', 'sleeve length': '29 cm', 'length': '67 cm'}
493	SMALL	{'waist': '66 cm - 84 cm', 'hip': '96 cm', 'thigh': '64 cm', 'length': '107 cm', 'front/back rise': '30 cm/39 cm'}
494	MEDIUM	{'waist': '70 cm - 88 cm', 'hip': '100 cm', 'thigh': '66 cm', 'length': '107 cm', 'front/back rise': '31 cm/40 cm'}
495	LARGE	{'waist': '74 cm - 92 cm', 'hip': '104 cm', 'thigh': '68 cm', 'length': '107 cm', 'front/back rise': '31 cm/40 cm'}
496	SMALL	{'waist': '62 - 72 cm', 'hip': '94 cm', 'thigh': '62 cm', 'length': '90 cm', 'front/back rise': '33 cm/42 cm'}
497	MEDIUM	{'waist': '66 cm - 76 cm', 'hip': '98 cm', 'thigh': '64 cm', 'length': '90 cm', 'front/back rise': '33,5 cm/42,5 cm'}
498	LARGE	{'waist': '70 cm - 80 cm', 'hip': '102 cm', 'thigh': '66 cm', 'length': '91 cm', 'front/back rise': '34 cm/43 cm'}
499	SMALL	{'bust': '94 cm', 'waist': '94 cm', 'length': '67 cm', 'armhole': '48 cm'}
500	MEDIUM	{'bust': '98 cm', 'waist': '98 cm', 'length': '68 cm', 'armhole': '50 cm'}
501	LARGE	{'bust': '102 cm', 'waist': '102 cm', 'length': '69 cm', 'armhole': '52 cm'}
502	ALL SIZE	{'bust': '120 cm', 'waist': '110 cm', 'length': '66 cm'}
503	ALL SIZE	{'bust': '90 cm', 'waist': '86 cm', 'length': '48 cm', 'sleeve length': '38 cm', 'armhole': '44\\xa0cm'}
504	ALL SIZE	{'bust': '120 cm', 'waist': '110 cm', 'length': '66 cm'}
505	SMALL	{'waist': '66-70 cm', 'hip': '85-93 cm', 'length': '104 cm'}
506	MEDIUM	{'waist': '68-72 cm', 'hip': '89-97 cm', 'length': '105 cm'}
507	LARGE	{'waist': '72-76 cm', 'hip': '91-99 cm', 'length': '106 cm'}
508	1	{'waist': '66 cm', 'hip': '94 cm', 'length': '80 cm'}
509	2	{'waist': '72 cm', 'hip': '100 cm', 'length': '81 cm'}
510	ALL SIZE	{'bust': '112 cm', 'waist': '112 cm', 'armhole': '60 cm', 'sleeve length': '57 cm', 'puffer length': '60 cm', 'inner vest length': '63 cm'}
511	1	{'waist': '70 cm', 'hip': '102 cm', 'thigh circumference': '60 cm', 'length': '104 cm', 'front rise': '30 cm', 'front/back rise': '40 cm'}
512	2	{'waist': '80 cm', 'hip': '110 cm', 'thigh circumference': '62 cm', 'length': '104 cm', 'front rise': '30 cm', 'front/back rise': '40 cm'}
513	ALL SIZE	{'waist': '64-100 cm', 'hip': '78-96 cm', 'length': '88 cm'}
514	1 (1 - 2 YEAR OLD)	{'bust': '62 cm', 'length': '45 cm', 'armhole': '28 cm', 'sleeve length': '29 cm', 'waist': '36 - 56 cm', 'hip': '66 cm'}
515	2 (2 - 3 YEAR OLD)	{'bust': '66 cm', 'length': '48 cm', 'armhole': '29 cm', 'sleeve length': '30 cm', 'waist': '40 - 60 cm', 'hip': '70 cm'}
516	3 (3-4 YEAR OLD)	{'bust': '70 cm', 'length': '51 cm', 'armhole': '30 cm', 'sleeve length': '32 cm', 'waist': '44 - 64 cm', 'hip': '74 cm'}
517	4 (4 - 5 YEAR OLD)	{'bust': '74 cm', 'length': '54 cm', 'armhole': '32 cm', 'sleeve length': '34 cm', 'waist': '48 - 68 cm', 'hip': '78 cm'}
518	ALL SIZE	{'bust': '116 cm', 'waist': '110 cm', 'front length': '69 cm', 'center back length': '83,5 cm', 'sleeve length': '58 cm', 'armhole': '58 cm'}
519	ALL SIZE	{'bust': '112 cm', 'waist': '116 cm', 'armhole': '52 cm', 'sleeve length': '50 cm', 'length': '65 cm'}
520	ALL SIZE	{'waist': '66-100 cm', 'hip': '92 cm', 'length': '82 cm'}
521	1	{'bust': '82 cm', 'waist': '70 cm', 'length': '61 cm', 'armhole': '45 cm'}
522	2	{'bust': '90 cm', 'waist': '78 cm', 'length': '63 cm', 'armhole': '50 cm'}
523	ALL SIZE	{'bust': '100 cm', 'waist': '104 cm', 'length': '72 cm', 'armhole': '46 cm', 'sleeve length': '68 cm'}
524	ALL SIZE	{'bust': '110 cm', 'waist': '110 cm', 'length': '82 cm', 'armhole': '53 cm', 'sleeve length': '59 cm'}
525	ALL SIZE	{'bust': '112 cm', 'waist': '116 cm', 'armhole': '52 cm', 'sleeve length': '50 cm', 'length': '65 cm'}
526	ALL SIZE	{'bust': '106 cm', 'waist': '104 cm', 'length': '54 cm', 'armhole': '48 cm', 'sleeve length': '58 cm'}
527	ALL SIZE	{'waist': '66-90 cm', 'hip': 'up to 98 cm', 'length': '96 cm'}
528	ALL SIZE	{'bust': '100 cm', 'waist': '100 cm', 'length': '62 cm', 'sleeve length': '22 cm', 'armhole': '45 cm'}
529	SMALL	{'bust': '96 cm', 'waist': '68 cm', 'length': '59 cm', 'sleeve length': '19 cm', 'armhole': '54 cm'}
530	MEDIUM	{'bust': '100 cm', 'waist': '72 cm', 'length': '60 cm', 'sleeve length': '20 cm', 'armhole': '56 cm'}
531	LARGE	{'bust': '104 cm', 'waist': '76 cm', 'length': '61 cm', 'sleeve length': '21 cm', 'armhole': '58 cm'}
532	1	{'bust': '90 cm', 'waist': '82 cm', 'length': '66 cm', 'armhole': '43 cm', 'sleeve length': '52 cm'}
533	2	{'bust': '102 cm', 'waist': '94 cm', 'length': '71 cm', 'armhole': '48 cm', 'sleeve length': '53 cm'}
534	1	{'bust': '92 cm', 'waist': '88 cm', 'length': '40 cm', 'sleeve length': '16 cm', 'armhole': '43 cm'}
535	2	{'bust': '100 cm', 'waist': '96 cm', 'length': '44 cm', 'sleevength': '18 cm', 'armhole': '47 cm'}
536	SMALL	{'bust': '86 cm', 'waist': '78 cm', 'length': '69 cm', 'armhole': '44 cm'}
537	MEDIUM	{'bust': '92 cm', 'waist': '84 cm', 'length': '70 cm', 'armhole': '46 cm'}
538	LARGE	{'bust': '98 cm', 'waist': '90 cm', 'length': '71 cm', 'armhole': '48 cm'}
539	SMALL	{'bust': '80 cm - 100 cm', 'waist': '72 cm - 92 cm', 'length': '62 cm', 'armhole': '40 cm', 'sleeve length': '61 cm'}
540	MEDIUM	{'bust': '84 cm - 104 cm', 'waist': '76 cm - 96 cm', 'length': '64 cm', 'armhole': '44 cm', 'sleeve length': '62 cm'}
541	LARGE	{'bust': '88 cm - 108 cm', 'waist': '82 cm - 102 cm', 'length': '66 cm', 'armhole': '46 cm', 'sleeve length': '63 cm'}
542	1	{'waist': '76 cm', 'hip': '107 cm', 'thigh': '68 cm', 'length': '31 cm', 'front/back rise': '25 cm/36 cm'}
543	2	{'waist': '82 cm', 'hip': '113 cm', 'thigh': '71 cm', 'length': '32 cm', 'front/back rise': '27 cm/38 cm'}
544	SMALL	{'bust': '86 cm', 'waist': '76 cm', 'armhole': '48 cm', 'length': '68 cm'}
545	MEDIUM	{'bust': '90 cm', 'waist': '80 cm', 'armhole': '50 cm', 'length': '69 cm'}
546	LARGE	{'bust': '94 cm', 'waist': '84 cm', 'armhole': '52 cm', 'length': '70 cm'}
547	ALL SIZE	{'bust': '100 cm', 'waist': '100 cm', 'length': '50 cm', 'armhole': '44 cm', 'sleeve length': '19\\xa0cm'}
548	ALL SIZE	{'bust': '108 cm', 'waist': '104 cm', 'length': '74 cm', 'armhole': '52 cm', 'sleeve length': '60 cm'}
549	ALL SIZE	{'waist': '68-110 cm', 'hip': 'up to 120 cm', 'length': '100 cm'}
550	ALL SIZE	{'bust': '90 cm', 'waist': '100 cm', 'armhole': '50 cm', 'length': '68 cm'}
551	ALL SIZE	{'bust': '120 cm', 'waist': '116 cm', 'length': '60 cm', 'sleeve length': '53 cm', 'armhole': '44 cm (drop shoulder)'}
552	1	{'bust': '85 cm', 'waist': '85 cm', 'length': '52 cm', 'armhole': '50 cm'}
553	2	{'bust': '91 cm', 'waist': '91 cm', 'length': '54 cm', 'armhole': '52 cm'}
554	ALL SIZE	{'bust': '100 cm', 'waist': '92 cm', 'length': '50 cm', 'armhole': '45 cm', 'sleeve length': '52 cm'}
555	ALL SIZE	{'bust': 'up to 110 cm', 'waist': 'up to 110 cm', 'length': '70 cm', 'sleeve length': '51 cm', 'armhole': '43 cm'}
556	ALL SIZE	{'bust': '90 cm', 'waist': '86 cm', 'length': '48 cm', 'sleeve length': '38 cm', 'armhole': '44 cm'}
557	ALL SIZE	{'bust': '115 cm', 'waist': '115 cm', 'length': '62 cm', 'sleeve length': '27 cm', 'armhole': '61 cm'}
558	ALL SIZE	{'bust': '74-100 cm', 'waist': '74-95 cm', 'armhole': '50 cm', 'sleeve length': '24 cm', 'length': '125 cm'}
559	ALL SIZE	{'bust': '92 cm', 'waist': '106 cm', 'length': '130 cm', 'armhole': '54 cm'}
560	ALL SIZE	{'bust': '110 cm', 'waist': '110 cm', 'length': '64 cm', 'armhole': '50 cm', 'sleeve length': '57 cm'}
561	ALL SIZE	{'bust': '72 cm - 100 cm', 'waist': '64 cm - 92 cm', 'armhole': '45 cm', 'length': '57 cm'}
562	ALL SIZE	{'bust': '112 cm', 'waist': '112 cm', 'armhole': '60 cm', 'sleeve length': '57 cm', 'puffer length': '60 cm', 'inner vest length': '63 cm'}
563	ALL SIZE	{'waist': '70 cm', 'hip': '100 cm', 'length': '37 cm', 'front/back rise': '34/44 cm', 'thigh circumference': '70 cm'}
564	1	{'bust': '92 cm', 'waist': '80 cm', 'length': '88 cm', 'armhole': '50 cm', 'sleeve length': '24 cm'}
565	2	{'bust': '100 cm', 'waist': '88 cm', 'length': '90 cm', 'armhole': '50 cm', 'sleeve length': '24 cm'}
566	S	{'bust': '96 cm', 'waist': '88 cm', 'length': '72 cm', 'sleeve length': '59 cm', 'armhole': '46 cm'}
567	M	{'bust': '100 cm', 'waist': '92 cm', 'length': '73 cm', 'sleeve length': '59 cm', 'armhole': '47 cm'}
568	L	{'bust': '104 cm', 'waist': '96 cm', 'length': '74 cm', 'sleeve length': '5 9cm', 'armhole': '48 cm'}
569	ALL SIZE	{'bust': '94 cm - 112 cm', 'waist': '74 cm - 92 cm', 'length': '64 cm', 'armhole': '40 cm', 'sleeve length': '59 cm'}
570	ALL SIZE	{'bust': '92 cm', 'waist': '86 cm', 'armhole': '54 cm', 'sleeve length': '62 cm', 'length': '58 cm'}
571	SMALL	{'waist': '64 cm', 'hip': '85 cm', 'length': '104 cm'}
572	MEDIUM	{'waist': '66 cm', 'hip': '87 cm', 'length': '105 cm'}
573	LARGE	{'waist': '70 cm', 'hip': '91 cm', 'length': '106 cm'}
574	SMALL	{'bust': '92 cm', 'waist': '92 cm', 'length': '55 cm', 'armhole': '46 cm', 'sleeve length': '15 cm'}
575	MEDIUM	{'bust': '100 cm', 'waist': '100 cm', 'length': '58 cm', 'armhole': '48 cm', 'sleeve length': '16 cm'}
576	ALL SIZE	{'bust': '74 cm - 102 cm', 'waist': '70 cm - 98 cm', 'armhole': '40 cm', 'sleeve length': '58 cm', 'length': '58 cm'}
577	SMALL	{'waist': '65 cm', 'hip': '88 cm', 'thigh': '52 cm', 'front/back rise': '30 cm/37 cm', 'length': '105 cm'}
578	MEDIUM	{'waist': '70 cm', 'hip': '94 cm', 'thigh': '56 cm', 'front/back rise': '30 cm/38 cm', 'length': '105 cm'}
579	LARGE	{'waist': '74 cm', 'hip': '98 cm', 'thigh': '58 cm', 'front/back rise': '30 cm/38 cm', 'length': '105 cm'}
580	1	{'bust': '82-86 cm', 'waist': '70-74 cm', 'length': '57 cm', 'armhole': '46 cm'}
581	2	{'bust': '88-92 cm', 'waist': '76-80 cm', 'length': '58 cm', 'armhole': '50 cm'}
582	ALL SIZE	{'bust': 'Up to 120 cm', 'waist': '120 cm', 'length': '68.5 cm', 'armhole': '77 cm', 'sleeve length': '25 cm'}
583	1	{'bust': '86 cm', 'waist': '88 cm', 'length from center front': '56,5 cm'}
584	2	{'bust': '92 cm', 'waist': '94 cm', 'length from center front': '58 cm'}
585	SMALL	{'waist': '68 - 76 cm', 'hip': '86 - 94 cm', 'length': '94 cm', 'front/back rise': '30/38 cm', 'thigh': '54 cm'}
586	MEDIUM	{'waist': '72 - 80 cm', 'hip': '90 - 98 cm', 'length': '95 cm', 'front/back rise': '31/39 cm', 'thigh': '56 cm'}
587	LARGE	{'waist': '76 - 84 cm', 'hip': '94 - 102 cm', 'length': '96 cm', 'front/back rise': '32/40 cm', 'thigh': '58cm'}
588	1	{'bust': '96 cm', 'waist': '66 cm', 'length': '92 cm', 'armhole': '46 cm', 'sleeve length': '60 cm', 'hip': '90 cm'}
589	2	{'bust': '104 cm', 'waist': '72 cm', 'length': '94 cm', 'armhole': '50 cm', 'sleeve length': '62 cm', 'hip': '96 cm'}
590	1 (XS-S)	{'waist': '66cm up to 71cm', 'hip': '88cm up to 93cm', 'length': '99cm'}
591	2 (M-L)	{'waist': '72cm up to 78cm', 'hip': '94cm up to 100cm', 'length': '100cm'}
592	ALL SIZE	{'bust': 'up to 130 cm (adjustable)', 'length': '80 cm', 'waist': 'up to 90 cm ( with belt )'}
593	1	{'bust': '90 cm', 'waist': '94 cm', 'armhole': '47 cm', 'sleeve length': '21 cm', 'length': '80 cm'}
659	1	{'bust': '82 cm', 'waist': '86 cm', 'length': '118 cm', 'armhole': '44 cm'}
594	2	{'bust': '96 cm', 'waist': '100 cm', 'armhole': '49 cm', 'sleeve length': '23 cm', 'length': '82 cm'}
595	1	{'bust': '94 cm', 'waist': '100 cm', 'length': '51 cm', 'armhole': '48 cm'}
596	2	{'bust': '100 cm', 'waist': '106 cm', 'length': '53 cm', 'armhole': '51 cm'}
599	SMALL	{'waist': '62 - 72 cm', 'hip': '94 cm', 'thigh': '62 cm', 'length': '90 cm', 'front/back rise': '33 cm/42 cm'}
600	MEDIUM	{'waist': '66 cm - 76 cm', 'hip': '98 cm', 'thigh': '64 cm', 'length': '90 cm', 'front/back rise': '33,5 cm/42,5 cm'}
601	LARGE	{'waist': '70 cm - 80 cm', 'hip': '102 cm', 'thigh': '66 cm', 'length': '91 cm', 'front/back rise': '34 cm/43 cm'}
602	ALL SIZE	{'bust': '114cm', 'waist': '112cm', 'length': '68cm', 'sleeve length': '59cm', 'armhole': '47cm'}
603	ALL SIZE	{'bust': '112 cm', 'waist': '110 cm', 'length': '50 cm', 'sleeve length': '62 cm', 'armhole': '52 cm'}
604	1	{'bust': '86 cm', 'waist': '84 cm', 'armhole': '52 cm', 'length': '48 cm'}
605	2	{'bust': '94 cm', 'waist': '92 cm', 'armhole': '55 cm', 'length': '50 cm'}
606	S	{'waist': '68 cm', 'hip': '94 cm', 'length': '98 cm'}
607	M	{'waist': '72 cm', 'hip': '100 cm', 'length': '98 cm'}
608	L	{'waist': '76 cm', 'hip': '104 cm', 'length': '98 cm'}
609	ALL SIZE	{'bust': '120 cm', 'waist': '116 cm', 'length': '60 cm', 'sleeve length': '53 cm', 'armhole': '44 cm (drop shoulder)'}
610	ALL SIZE	{'bust': '120 cm', 'waist': '120 cm', 'length': '76 cm', 'armhole': '50 cm'}
611	ALL SIZE	{'bust': '120 cm', 'length': '70 cm', 'armhole': '50 cm'}
612	1	{'waist': '76 cm', 'hip': '98 cm', 'thigh': '68 cm', 'front/back rise': '24,5 cm/34,5 cm', 'length': '27 cm'}
613	2	{'waist': '82 cm', 'hip': '104 cm', 'thigh': '71 cm', 'front/back rise': '25,5 cm/35,5 cm', 'length': '28 cm'}
614	SMALL	{'waist': '64 cm - 68 cm', 'hip': '82 cm - 86 cm (15 cm from waistline)', 'length': '95 cm'}
615	MEDIUM	{'waist': '68 cm - 72 cm', 'hip': '86 cm - 90 cm (15 cm from waistline)', 'length': '95 cm'}
616	LARGE	{'waist': '72 cm - 76 cm', 'hip': '90 cm - 94 cm (15 cm from waistline)', 'length': '95 cm'}
617	ALL SIZE	{'bust': '120 cm', 'waist': '140 cm', 'length': '93 cm', 'armhole': '47 cm', 'sleeve length': '48 cm'}
618	ALL SIZE	{'bust': '100 cm', 'waist': '100 cm', 'length': '62 cm', 'sleeve length': '22 cm', 'armhole': '45 cm'}
619	1	{'bust': '98 cm', 'waist': '88 cm', 'length': '66 cm', 'armhole': '48 cm', 'sleeve length': '21 cm'}
620	2	{'bust': '106 cm', 'waist': '94 cm', 'length': '69 cm', 'armhole': '49 cm', 'sleeve length': '23 cm'}
621	ALL SIZE	{'bust': '70 - 100 cm', 'waist': '74 - 110 cm', 'length': '56 cm', 'armhole': '42 cm'}
622	SMALL	{'waist': '65 cm', 'hip': '88 cm', 'thigh': '52 cm', 'front/back rise': '30 cm/37 cm', 'length': '105 cm'}
623	MEDIUM	{'waist': '70 cm', 'hip': '94 cm', 'thigh': '56 cm', 'front/back rise': '30 cm/38 cm', 'length': '105 cm'}
624	LARGE	{'waist': '74 cm', 'hip': '98 cm', 'thigh': '58 cm', 'front/back rise': '30 cm/38 cm', 'length': '105 cm'}
625	ALL SIZE	{'waist': '62 - 90 cm', 'hip': '130 cm', 'length': '67 cm'}
626	1	{'waist': '66 cm', 'hip': '88 cm', 'length': '102 cm'}
627	2	{'waist': '72 cm', 'hip': '94 cm', 'length': '103 cm'}
628	ALL SIZE	{'bust': '80-90 cm', 'waist': '74-84 cm', 'length': '62 cm', 'armhole': '42 cm', 'sleeve length': '55 cm'}
629	ALL SIZE	{'waist': '60 - 100 cm', 'hip': 'up to 100 cm', 'length': '81 cm'}
630	ALL SIZE	{'bust': '160 cm', 'length': '61 cm', 'armhole': '32 cm'}
631	1	{'bust': '84 cm', 'waist': '80 cm', 'length': '50 cm', 'armhole': '48 cm'}
632	2	{'bust': '96 cm', 'waist': '92 cm', 'length': '55 cm', 'armhole': '52 cm'}
633	1	{'bust': '88 cm', 'waist': '94 cm', 'length': '84 cm', 'armhole': '45 cm', 'sleeve length': '20 cm'}
634	2	{'bust': '94 cm', 'waist': '100 cm', 'length': '85 cm', 'armhole': '48 cm'}
635	ALL SIZE	{'bust': '100 cm', 'waist': '92 cm', 'length': '60 cm', 'armhole': '49 cm', 'sleeve length': '52 cm'}
636	ALL SIZE	{'bust': '100 cm', 'waist': '104 cm', 'armhole': '54 cm', 'sleeve length': '16 cm', 'length': '63 cm'}
637	ALL SIZE	{'bust': '112 cm', 'waist': '112 cm', 'length': '70 cm', 'sleeve length': '58 cm', 'armhole': '56 cm'}
638	ALL SIZE	{'bust': '84 cm', 'waist': '84 cm', 'length': '56 cm', 'sleeve length': '33 cm', 'armhole': '46 cm'}
639	ALL SIZE	{'bust': '120 cm', 'waist': '110 cm', 'length': '66 cm'}
640	ALL SIZE	{'size': '120 cm x 120 cm'}
641	SMALL	{'waist': '66 cm - 84 cm', 'hip': '96 cm', 'thigh': '64 cm', 'length': '107 cm', 'front/back rise': '30 cm/39 cm'}
642	MEDIUM	{'waist': '70 cm - 88 cm', 'hip': '100 cm', 'thigh': '66 cm', 'length': '107 cm', 'front/back rise': '31 cm/40 cm'}
643	LARGE	{'waist': '74 cm - 92 cm', 'hip': '104 cm', 'thigh': '68 cm', 'length': '107 cm', 'front/back rise': '31 cm/40 cm'}
644	ALL SIZE	{'waist': '70-94cm', 'hip': '96cm', 'length': '100cm'}
645	1	{'bust': '94 cm', 'waist': '110 cm', 'length': '61 cm', 'armhole': '54 cm'}
646	2	{'bust': '100 cm', 'waist': '116 cm', 'length': '63 cm', 'armhole': '56 cm'}
647	1	{'bust': '92 cm', 'waist': '125 cm', 'length': '131 cm', 'armhole': '60 cm'}
648	2	{'bust': '100 cm', 'waist': '130 cm', 'length': '132 cm', 'armhole': '64 cm'}
649	ALL SIZE	{'waist': '65-86 cm', 'hip': 'up to 100 cm', 'thigh': '58 cm', 'length': '98 cm'}
650	1	{'bust': '82 - 90 cm', 'waist': '82 cm - 90 cm', 'length': '65 cm', 'armhole': '52 cm'}
651	2	{'bust': '90 - 98 cm', 'waist': '90 cm - 98 cm', 'length': '65 cm', 'armhole': '56 cm'}
652	ALL SIZE	{'bust': '90 cm', 'waist': '78 cm', 'length': '62 cm', 'armhole': '58 cm', 'sleeve length': '62 cm'}
653	1	{'bust': '86 cm', 'waist': '94 cm', 'front length/back length': '62 cm/68 cm', 'armhole': '50 cm'}
654	2	{'bust': '92 cm', 'waist': '100 cm', 'front length/back length': '63 cm/69 cm', 'armhole': '53 cm'}
655	1	{'bust': '88 cm', 'waist': '84 cm', 'length': '123 cm', 'armhole': '64 cm'}
656	2	{'bust': '94 cm', 'waist': '90 cm', 'length': '125 cm', 'armhole': '66 cm'}
657	1	{'bust': '98 cm', 'waist': '96 cm', 'length': '60 cm', 'armhole': '42 cm', 'sleeve length': '50 cm'}
658	2	{'bust': '110 cm', 'waist': '108 cm', 'length': '60 cm', 'armhole': '46 cm', 'sleeve length': '50 cm'}
660	2	{'bust': '90 cm', 'waist': '96 cm', 'length': '119 cm', 'armhole': '52 cm'}
661	ALL SIZE	{'bust': '100 cm', 'waist': '100 cm', 'length': '67 cm', 'sleeve length': '22 cm', 'armhole': '48 cm'}
662	SMALL	{'bust': '84 - 118 cm', 'waist': '80 - 116 cm', 'length': '58 cm', 'sleeve length': '58 cm', 'armhole': '40 cm'}
663	MEDIUM	{'bust': '88 - 122 cm', 'waist': '84 - 118 cm', 'length': '60 cm', 'sleeve length': '59 cm', 'armhole': '42 cm'}
664	ALL SIZE	{'bust': '112 cm', 'waist': '116 cm', 'armhole': '52 cm', 'sleeve length': '50 cm', 'length': '65 cm'}
665	1	{'bust': '96 cm', 'waist': '94 cm', 'armhole': '54 cm', 'sleeve length': '63 cm', 'length': '56 cm'}
666	2	{'bust': '104 cm', 'waist': '102 cm', 'armhole': '56 cm', 'sleeve length': '65 cm', 'length': '58 cm'}
667	1	{'bust': '94 cm', 'waist': '94 cm', 'length': '46,5 cm', 'armhole': '48 cm', 'sleeve length': '17 cm'}
668	2	{'bust': '100 cm', 'waist': '100 cm', 'length': '48,5 cm', 'armhole': '50 cm', 'sleeve length': '18 cm'}
669	S	{'waist': '70 cm', 'hip': '92 cm', 'length': '38 cm'}
670	M	{'waist': '76 cm', 'hip': '98 cm', 'length': '40 cm'}
671	ALL SIZE	{'bust': '98 cm', 'waist': '144 cm', 'armhole': '48 cm', 'length': '81 cm'}
672	ALL SIZE	{'waist': '66-90 cm', 'hip': 'up to 98 cm', 'length': '96 cm'}
673	SMALL	{'waist': '64 cm', 'hip': '85 cm', 'length': '104 cm'}
674	MEDIUM	{'waist': '66 cm', 'hip': '87 cm', 'length': '105 cm'}
675	LARGE	{'waist': '70 cm', 'hip': '91 cm', 'length': '106 cm'}
676	ALL SIZE	{'bust': '78 - 96 cm', 'waist': '74 - 92 cm', 'length': '117 cm', 'armhole': '42 cm'}
677	1	{'bust': '84 cm', 'waist': '84 cm', 'length': '53 cm', 'armhole': '44 cm'}
678	2	{'bust': '88 cm', 'waist': '88 cm', 'length': '53 cm', 'armhole': '45 cm'}
679	ALL SIZE	{'bust': '87 cm', 'waist': '90 cm', 'length': '58 cm', 'armhole': '50 cm', 'sleeve length': '66 cm'}
680	ALL SIZE	{'bust': '100 cm', 'waist': '100 cm', 'length': '74 cm', 'armhole': '51 cm', 'sleeve length': '60 cm'}
681	1 (1 - 2 YEAR OLD)	{'bust': '62 cm', 'length': '45 cm', 'armhole': '28 cm', 'sleeve length': '29 cm', 'waist': '36 - 56 cm', 'hip': '66 cm'}
682	2 (2 - 3 YEAR OLD)	{'bust': '66 cm', 'length': '48 cm', 'armhole': '29 cm', 'sleeve length': '30 cm', 'waist': '40 - 60 cm', 'hip': '70 cm'}
683	3 (3-4 YEAR OLD)	{'bust': '70 cm', 'length': '51 cm', 'armhole': '30 cm', 'sleeve length': '32 cm', 'waist': '44 - 64 cm', 'hip': '74 cm'}
684	4 (4 - 5 YEAR OLD)	{'bust': '74 cm', 'length': '54 cm', 'armhole': '32 cm', 'sleeve length': '34 cm', 'waist': '48 - 68 cm', 'hip': '78 cm'}
685	ALL SIZE	{'bust': 'up to 115 cm', 'waist': 'up to 115 cm', 'length': '73 cm', 'sleeve length': '60 cm', 'armhole': '60 cm'}
686	1	{'bust': '96 cm', 'waist': '112 cm', 'armhole': '46 cm', 'length': '59 cm'}
687	2	{'bust': '102 cm', 'waist': '118 cm', 'armhole': '49 cm', 'length': '61 cm'}
688	1	{'waist': '66 cm - 76 cm', 'hip': '85 cm - 95 cm', 'length': '90 cm'}
689	2	{'waist': '72 cm - 82 cm', 'hip': '91 cm - 101 cm', 'length': '91 cm'}
690	ALL SIZE	{'bust': '94 cm - 112 cm', 'waist': '74 cm - 92 cm', 'length': '64 cm', 'armhole': '40 cm', 'sleeve length': '59 cm'}
691	ALL SIZE	{'bust': '88 cm', 'waist': '94 cm', 'length': '80 cm', 'armhole': '50 cm'}
692	SMALL	{'bust': '84 - 118 cm', 'waist': '80 - 116 cm', 'length': '58 cm', 'sleeve length': '58 cm', 'armhole': '40 cm'}
693	MEDIUM	{'bust': '88 - 122 cm', 'waist': '84 - 118 cm', 'length': '60 cm', 'sleeve length': '59 cm', 'armhole': '42 cm'}
694	1	{'bust': '90 cm', 'waist': '100 cm', 'length': '82 cm', 'armhole': '54 cm'}
695	2	{'bust': '100 cm', 'waist': '110 cm', 'length': '84 cm', 'armhole': '58 cm'}
696	1	{'bust': '84 cm', 'waist': '88 cm', 'length': '70 cm', 'armhole': '52 cm'}
697	2	{'bust': '92 cm', 'waist': '96 cm', 'length': '71 cm', 'armhole': '54 cm'}
698	S	{'waist': '70 cm', 'hip': '92 cm', 'length': '38 cm'}
699	M	{'waist': '76 cm', 'hip': '98 cm', 'length': '40 cm'}
700	ALL SIZE	{'bust': '104 cm', 'waist': '96 cm', 'length': '56 cm', 'armhole': '50 cm', 'sleeve length': '52 cm'}
701	SMALL	{'bust': '86 cm', 'waist': '86 cm', 'armhole': '46 cm', 'length': '55 cm'}
702	MEDIUM	{'bust': '90 cm', 'waist': '90 cm', 'armhole': '48 cm', 'length': '57 cm'}
703	LARGE	{'bust': '96 cm', 'waist': '96 cm', 'armhole': '50 cm', 'length': '59 cm'}
704	ALL SIZE	{'bust': '98 cm', 'waist': '92 cm', 'length': '62 cm', 'armhole': '54 cm', 'sleeve length': '65 cm'}
705	ALL SIZE	{'bust': '90 cm', 'waist': '76 cm', 'length': '60 cm', 'armhole': '58 cm', 'sleeve length': '62 cm'}
706	ALL SIZE	{'bust': '88 cm', 'waist': '88 cm', 'length': '45 cm', 'sleeve length': '22 cm', 'armhole': '48 cm'}
707	ALL SIZE	{'bust': '114 cm', 'waist': '114 cm', 'length': '75 cm', 'sleeve length': '60 cm', 'armhole': '56 cm'}
708	ALL SIZE	{'bust': '80-92 cm', 'waist': '66-80 cm', 'length': '60 cm', 'armhole': '44 cm', 'sleeve length': '61 cm'}
709	1	{'bust': '92 cm', 'waist': '92 cm', 'length': '54 cm', 'armhole': '44 cm', 'sleeve length': '16 cm'}
710	2	{'bust': '98 cm', 'waist': '98 cm', 'length': '56 cm', 'armhole': '46 cm', 'sleeve length': '17 cm'}
711	ALL SIZE	{'bust': '76 cm - 100 cm', 'waist': '62 cm - 86 cm', 'length': '68 cm', 'armhole': '40 cm', 'sleeve length': '62 cm'}
712	ALL SIZE	{'bust': '112cm', 'waist': '108cm', 'length': '53cm', 'sleeve length': '47cm', 'armhole': '35cm'}
713	1	{'bust': '82 cm', 'waist': '78 cm', 'armhole': '40 cm', 'sleeve length': '28 cm', 'length': '55 cm'}
714	2	{'bust': '92 cm', 'waist': '88 cm', 'armhole': '46 cm', 'sleeve length': '30 cm', 'length': '60 cm'}
715	SMALL	{'waist': '66 cm / 72 cm (with adjustable button)', 'hip': '108 cm', 'length': '106 cm', 'front rise': '32,5 cm', 'front/back rise': '42,5 cm'}
716	MEDIUM	{'waist': '70 cm / 76 cm (with adjustable button)', 'hip': '112 cm', 'length': '107,5 cm', 'front rise': '33 cm', 'front/back rise': '43 cm'}
717	LARGE	{'waist': '74 cm / 80 cm (with adjustable button)', 'hip': '116 cm', 'length': '108,5 cm', 'front rise': '33,5 cm', 'front/back rise': '43,5 cm'}
718	ALL SIZE	{'waist': '66 cm up to 96 cm', 'hip': '104 cm', 'length': '91 cm'}
719	1	{'bust': '96 cm', 'waist': '76 cm', 'hip': '98 cm', 'length': '81 cm', 'armhole': '48 cm', 'sleeve length': '21 cm'}
720	2	{'bust': '104 cm', 'waist': '84 cm', 'hip': '106 cm', 'length': '83 cm', 'armhole': '50 cm', 'sleeve length': '22 cm'}
721	ALL SIZE	{'bust': '90 cm', 'waist': '90 cm', 'length': '43 cm', 'armhole': '44 cm', 'sleeve length': '65 cm'}
722	1	{'bust': '88 cm', 'waist': '94 cm', 'length': '84 cm', 'armhole': '45 cm', 'sleeve length': '20 cm'}
723	2	{'': 'cm', 'waist': '100 cm', 'length': '85 cm', 'armhole': '48 cm', 'sleeve length': '20 cm'}
724	ALL SIZE	{'bust': '100 cm', 'waist': '84 cm', 'length': '58 cm', 'armhole': '46 cm', 'sleeve length': '53 cm'}
725	1	{'bust': '84 cm', 'waist': '94 cm', 'length from strap': '134 cm'}
726	2	{'bust': '90 cm', 'waist': '100 cm', 'length from strap': '135,5 cm'}
727	ALL SIZE	{'bust': '88 - 95 cm', 'waist': '89 cm', 'length': '65 cm', 'armhole': '46 cm'}
728	ALL SIZE	{'bust': 'up to 115 cm', 'waist': 'up to 115 cm', 'length': '56 cm', 'sleeve length': '54 cm', 'armhole': '44 cm'}
729	ALL SIZE	{'bust': '112 cm', 'waist': '116 cm', 'armhole': '52 cm', 'sleeve length': '50 cm', 'length': '65 cm'}
730	1	{'bust': '80 cm', 'waist': '80 cm', 'length': '52 cm', 'sleeve length': '58 cm', 'armhole': '45 cm', 'center front length': '32 cm'}
731	2CARDIGAN	{'bust': '86 cm', 'waist': '86 cm', 'length': '53 cm', 'sleeve length': '58 cm', 'armhole': '47 cm', 'center front length': '33 cm'}
732	1	{'bust': '96 cm', 'waist': '88 cm', 'length': '52 cm', 'sleeve length': '58 cm', 'armhole': '45 cm'}
733	2	{'bust': '104 cm', 'waist': '90 cm', 'length': '53 cm', 'sleeve length': '58 cm', 'armhole': '47 cm'}
734	ALL SIZE	{'bust': '110 cm', 'waist': '108 cm', 'length': '74 cm', 'sleeve length': '60 cm', 'armhole': '50 cm'}
735	ALL SIZE	{'size': '120 cm x 120 cm'}
736	ALL SIZE	{'bust': '100 cm', 'waist': '100 cm', 'length': '118 cm', 'armhole': '50 cm', 'sleeve length': '58 cm'}
737	ALL SIZE	{'bust': '80-92cm', 'waist': '72 cm', 'length': '53 cm', 'sleeve length': '54 cm', 'armhole': '46 cm'}
738	1	{'bust': '98 cm', 'waist': '92 cm', 'length': '68 cm', 'sleeve length': '60 cm', 'armhole': '50 cm'}
739	2	{'bust': '104 cm', 'waist': '100 cm', 'length': '68 cm', 'sleeve length': '61 cm', 'armhole': '52 cm'}
740	ALL SIZE	{'bust': '100 cm', 'waist': '100 cm', 'length': '67 cm', 'sleeve length': '22 cm', 'armhole': '48 cm'}
741	ALL SIZE	{'bust': 'up to 115 cm', 'waist': 'up to 120 cm', 'length': '59 cm', 'armhole': '50 cm'}
742	ALL SIZE	{'bust': '106 cm', 'waist': '110 cm', 'length': '45 cm', 'sleeve length': '21.5 cm', 'armhole': '50 cm'}
743	ALL SIZE	{'waist': '66cm up to 96cm', 'hip': '104cm', 'length': '91cm'}
744	ALL SIZE	{'bust': '70 - 90 cm', 'waist': '60 - 80 cm', 'armhole': '40 cm', 'length': '52 cm'}
745	1	{'bust': '96 cm', 'waist': '112 cm', 'armhole': '46 cm', 'length': '81 cm'}
746	2	{'bust': '102 cm', 'waist': '118 cm', 'armhole': '49 cm', 'length': '83 cm'}
747	1	{'bust': '80 cm', 'waist': '80 cm', 'length': '52 cm', 'sleeve length': '58 cm', 'armhole': '45 cm', 'center front length': '32 cm'}
748	2CARDIGAN	{'bust': '86 cm', 'waist': '86 cm', 'length': '53 cm', 'sleeve length': '58 cm', 'armhole': '47 cm', 'center front length': '33 cm'}
749	ALL SIZE	{'bust': '88 cm', 'waist': '80 cm', 'length': '58 cm', 'armhole': '46 cm', 'sleeve length': '59 cm'}
750	ALL SIZE	{'bust': '74 cm - 102 cm', 'waist': '70 cm - 98 cm', 'armhole': '40 cm', 'sleeve length': '58 cm', 'length': '58 cm'}
751	S	{'waist': '68 cm', 'hip': '94 cm', 'length': '98 cm'}
752	M	{'waist': '72 cm', 'hip': '100 cm', 'length': '98 cm'}
753	L	{'waist': '76 cm', 'hip': '104 cm', 'length': '98 cm'}
754	ALL SIZE	{'bust': '70 - 90 cm', 'waist': '60 - 80 cm', 'armhole': '40 cm', 'length': '52 cm'}
755	ALL SIZE	{'bust': '84-100 cm', 'waist': '80-100 cm', 'length': '115 cm', 'armhole': '45 cm'}
756	1	{'bust': '94 cm', 'waist': '100 cm', 'length': '51 cm', 'armhole': '48 cm'}
757	2	{'bust': '100 cm', 'waist': '106 cm', 'length': '53 cm', 'armhole': '51 cm'}
758	ALL SIZE	{'bust': '82-100 cm', 'waist': '80-98 cm', 'length': '59 cm', 'armhole': '42 cm', 'sleeve length': '59 cm'}
759	SMALL	{'waist': '58 - 88 cm', 'hip': '72 - 94 cm', 'length': '91 cm'}
760	MEDIUM	{'waist': '60 - 96 cm', 'hip': '76 - 100 cm', 'length': '92 cm'}
761	LARGE	{'waist': '66 - 102 cm', 'hip': '82 - 106 cm', 'length': '93 cm'}
762	1	{'bust': '80 cm', 'waist': '80 cm', 'length': '52 cm', 'sleeve length': '58 cm', 'armhole': '45 cm', 'center front length': '32 cm'}
763	2CARDIGAN	{'bust': '86 cm', 'waist': '86 cm', 'length': '53 cm', 'sleeve length': '58 cm', 'armhole': '47 cm', 'center front length': '33 cm'}
764	ALL SIZE	{'bust': '90 cm', 'waist': '90 cm', 'length': '46 cm', 'armhole': '50 cm', 'sleeve length': '59 cm'}
765	ALL SIZE	{'bust': '88 cm', 'waist': '86 cm', 'length': '64 cm', 'armhole': '49 cm'}
766	SMALL	{'bust': '92 cm', 'waist': '92 cm', 'length': '55 cm', 'sleeve length': '15 cm', 'armhole': '46 cm'}
767	MEDIUM	{'bust': '100 cm', 'waist': '100 cm', 'length': '58 cm', 'sleeve length': '16 cm', 'armhole': '48 cm'}
768	LARGE	{'bust': '104 cm', 'waist': '104 cm', 'length': '60 cm', 'sleeve length': '17 cm', 'armhole': '50 cm'}
769	SMALL	{'waist': '66 cm / 72 cm (with adjustable button)', 'hip': '108 cm', 'length': '106 cm', 'front rise': '32,5 cm', 'front/back rise': '42,5 cm'}
770	MEDIUM	{'waist': '70 cm / 76 cm (with adjustable button)', 'hip': '112 cm', 'length': '107,5 cm', 'front rise': '33 cm', 'front/back rise': '43 cm'}
771	LARGE	{'waist': '74 cm / 80 cm (with adjustable button)', 'hip': '116 cm', 'length': '108,5 cm', 'front rise': '33,5 cm', 'front/back rise': '43,5 cm'}
772	SMALL	{'bust': '86 - 120 cm', 'waist': '80 - 116 cm', 'length': '60 cm', 'sleeve length': '18 cm', 'armhole': '45 cm'}
773	MEDIUM	{'bust': '90 - 124 cm', 'waist': '84 - 118 cm', 'length': '62 cm', 'sleeve length': '19 cm', 'armhole': '46 cm'}
774	SMALL	{'bust': '86 - 120 cm', 'waist': '80 - 116 cm', 'length': '60 cm', 'sleeve length': '18 cm', 'armhole': '45 cm'}
775	MEDIUM	{'bust': '90 - 124 cm', 'waist': '84 - 118 cm', 'length': '62 cm', 'sleeve length': '19 cm', 'armhole': '46 cm'}
776	1	{'waist': '76 cm', 'hip': '98 cm', 'thigh': '68 cm', 'front/back rise': '24,5 cm/34,5 cm', 'length': '27 cm'}
777	2	{'waist': '82 cm', 'hip': '104 cm', 'thigh': '71 cm', 'front/back rise': '25,5 cm/35,5 cm', 'length': '28 cm'}
778	ALL SIZE	{'bust': '88 cm', 'waist': '94 cm', 'length': '80 cm', 'armhole': '50 cm'}
779	ALL SIZE	{'small': 'Waist: 70 cm', 'hip': '108 cm', 'length': '39 cm', 'medium': 'Waist: 76 cm'}
780	ALL SIZE	{'bust': '112 cm', 'waist': '116 cm', 'armhole': '52 cm', 'sleeve length': '50 cm', 'length': '65 cm'}
781	ALL SIZE	{'waist': '68 up to 108 cm', 'hip': '104 to 116 cm', 'length': '102 cm'}
782	ALL SIZE	{'waist': '64-90 cm', 'hip': '100 cm', 'length': '66 cm'}
783	ALL SIZE	{'bust': '72 cm - 100 cm', 'waist': '64 cm - 92 cm', 'armhole': '45 cm', 'length': '57 cm'}
784	1	{'waist': '62-84 cm', 'hip': 'up to 94 cm', 'length': '100 cm'}
785	2	{'waist': '66-90 cm', 'hip': 'up to 98 cm', 'length': '100 cm'}
786	SMALL	{'bust': '92 cm', 'waist': '92 cm', 'length': '55 cm', 'armhole': '46 cm', 'sleeve length': '15 cm'}
787	MEDIUM	{'bust': '100 cm', 'waist': '100 cm', 'length': '58 cm', 'armhole': '48 cm', 'sleeve length': '16 cm'}
788	ALL SIZE	{'bust': '74 - 104 cm', 'waist': '64 - 94 cm', 'armhole': '36 - 46 cm', 'sleeve length': '20 cm', 'length': '73 cm'}
789	ALL SIZE	{'bust': '102 cm', 'waist': '103 cm', 'length': '62 cm', 'armhole': '48 cm', 'sleeve length': '6 cm'}
790	S	{'waist': '68 cm', 'hip': '94 cm', 'length': '98 cm'}
791	M	{'waist': '72 cm', 'hip': '100 cm', 'length': '98 cm'}
792	L	{'waist': '76 cm', 'hip': '104 cm', 'length': '98 cm'}
793	ALL SIZE	{'bust': '100 cm', 'waist': '100 cm', 'length': '50 cm', 'armhole': '44 cm', 'sleeve length': '19 cm'}
794	ALL SIZE	{'bust': '112 cm', 'waist': '112 cm', 'length': '50 cm', 'armhole': '52 cm', 'sleeve length': '60 cm'}
795	1	{'waist': '66 - 100 cm', 'hip': '120 cm', 'length': '79 cm'}
796	2	{'waist': '70 - 110 cm', 'hip': '124 cm', 'length': '80 cm'}
797	ALL SIZE	{'bust': '70 - 100 cm', 'waist': '74 - 110 cm', 'length': '56 cm', 'armhole': '42 cm'}
798	1	{'bust': '86 cm', 'waist': '88 cm', 'armhole': '46 cm', 'length': '57 cm'}
799	2	{'bust': '92 cm', 'waist': '94 cm', 'armhole': '48 cm', 'length': '60 cm'}
800	ALL SIZE	{'bust': 'up to 100 cm', 'waist': 'up to 100 cm', 'length': '108 cm', 'armhole': '50cm'}
801	ALL SIZE	{'bust': '102 cm', 'waist': '92 cm', 'armhole': '40 cm', 'sleeve length': '48 cm', 'length': '57 cm', 'scarf width x length': '10 x 185 cm'}
802	ALL SIZE	{'bust': '60 up to 100 cm', 'waist': '56 up to 100 cm', 'sleeve length': '51 cm', 'length': '49 cm', 'armhole': '46 cm'}
803	ALL SIZE	{'bust': '84-100 cm', 'waist': '80-95cm', 'length': '124 cm', 'sleeve length': '22 cm', 'armhole': '46 cm'}
804	SMALL	{'waist': '68 cm', 'hip': '96 cm', 'length': '35 cm', 'front rise': '34 cm', 'front/back rise': '44 cm'}
805	MEDIUM	{'waist': '74 cm', 'hip': '102 cm', 'length': '36 cm', 'front rise': '34,5 cm', 'front/back rise': '44,5 cm'}
806	LARGE	{'waist': '80 cm', 'hip': '108 cm', 'length': '37 cm', 'front rise': '35 cm', 'front/back rise': '45 cm'}
807	ALL SIZE	{'bust': '102 cm', 'waist': '98 cm', 'armhole': '52 cm', 'sleeve length': '28 cm', 'length': '56 cm'}
808	1	{'bust': '82 cm', 'waist': '86 cm', 'length': '118 cm', 'armhole': '44 cm'}
809	2	{'bust': '90 cm', 'waist': '96 cm', 'length': '119 cm', 'armhole': '52 cm'}
810	ALL SIZE	{'bust': '88 cm', 'waist': '80 cm', 'length': '58 cm', 'armhole': '46 cm', 'sleeve length': '59 cm'}
811	ALL SIZE	{'bust': '130 cm', 'waist': '130 cm', 'length': '73 cm', 'sleeve length': '53 cm', 'armhole': '54 cm'}
812	ALL SIZE	{'bust': '96 cm', 'waist': '100 cm', 'length': '62 cm', 'sleeve length': '58 cm', 'armhole': '52 cm'}
813	ALL SIZE	{'bust': '100 cm', 'waist': '100 cm', 'length': '44 cm', 'armhole': '48 cm', 'sleeve length': '59 cm'}
814	ALL SIZE	{'bust': '112 cm', 'waist': '112 cm', 'armhole': '60 cm', 'sleeve length': '57 cm', 'puffer length': '60 cm', 'inner vest length': '63 cm'}
815	ALL SIZE	{'waist': '68-110 cm', 'hip': 'up to 120 cm', 'length': '100 cm'}
816	ALL SIZE	{'bust': '102 cm', 'wasit': '114 cm', 'length': '63 cm', 'sleeve length': '30 cm', 'armhole': '51 cm'}
817	1	{'bust': '92 cm', 'waist': '86 cm', 'armhole': '52 cm', 'sleeve length': '23 cm', 'length': '57 cm'}
818	2	{'bust': '98 cm', 'waist': '92 cm', 'armhole': '54 cm', 'sleeve length': '24 cm', 'length': '58,5 cm'}
819	ALL SIZE	{'bust': '84-96 cm', 'waist': '76-88 cm', 'length': '58 cm', 'armhole': '45 cm', 'sleeve length': '16.5 cm'}
820	SMALL	{'bust': '94 cm', 'waist': '94 cm', 'length': '67 cm', 'armhole': '48 cm'}
821	MEDIUM	{'bust': '98 cm', 'waist': '98 cm', 'length': '68 cm', 'armhole': '50 cm'}
822	LARGE	{'bust': '102 cm', 'waist': '102 cm', 'length': '69 cm', 'armhole': '52 cm'}
823	ALL SIZE	{'bust': '116 cm', 'waist': '94 cm', 'length': '58 cm', 'armhole': '50 cm', 'sleeve length': '54 cm'}
824	ALL SIZE	{'bust': '120 cm', 'waist': '116 cm', 'length': '60 cm', 'sleeve length': '53 cm', 'armhole': '44 cm (drop shoulder)'}
825	ALL SIZE	{'bust': '134 cm', 'waist': '134 cm', 'armhole': '40 cm', 'length': '69 cm', 'scarf width x length': '26 cm x 117 cm'}
826	ALL SIZE	{'bust': '98 cm', 'waist': '96 cm', 'length': '55 cm', 'armhole': '48 cm', 'sleeve length': '61 cm'}
827	ALL SIZE	{'bust': '78 cm - 90 cm', 'waist': '72 cm - 84 cm', 'length': '54 cm', 'armhole': '46 cm'}
828	SMALL	{'waist': '66 cm - 84 cm', 'hip': '96 cm', 'thigh': '64 cm', 'length': '107 cm', 'front/back rise': '30 cm/39 cm'}
829	MEDIUM	{'waist': '70 cm - 88 cm', 'hip': '100 cm', 'thigh': '66 cm', 'length': '107 cm', 'front/back rise': '31 cm/40 cm'}
830	LARGE	{'waist': '74 cm - 92 cm', 'hip': '104 cm', 'thigh': '68 cm', 'length': '107 cm', 'front/back rise': '31 cm/40 cm'}
831	ALL SIZE	{'bust': 'up to 125 cm', 'waist': '120 cm', 'length': '61 cm', 'sleeve length': '33 cm', 'armhole': '47 cm'}
832	S	{'waist': '66 cm', 'hip': '90 cm', 'length': '40 cm'}
833	M	{'waist': '70 cm', 'hip': '95 cm', 'length': '40 cm'}
834	L	{'waist': '72 cm', 'hip': '100\\xa0cm', 'length': '40\\xa0cm'}
835	ALL SIZE	{'bust': '108 cm', 'waist': '108 cm', 'armhole': '60 cm', 'sleeve length': '58 cm', 'length': '56 cm'}
836	ALL SIZE	{'bust': '98-112 cm', 'waist': '88-102 cm', 'length': '56 cm', 'sleeve length': '56 cm', 'armhole': '45 cm'}
837	SMALL	{'waist': '70 - 76 cm', 'hip': '92 - 98 cm', 'thigh': '56 - 60 cm', 'front/back rise': '27 cm/35 cm', 'length': '104 cm'}
838	MEDIUM	{'waist': '74 - 80 cm', 'hip': '96 - 102 cm', 'thigh': '60 - 64 cm', 'front/back rise': '27,5 cm/35,5 cm', 'length': '105 cm'}
839	LARGE	{'waist': '80 - 86 cm', 'hip': '102 - 108 cm', 'thigh': '64 - 68 cm', 'front/back rise': '28 cm/36 cm', 'length': '106 cm'}
840	ALL SIZE	{'bust': '100 cm', 'waist': '98 cm', 'length': '62 cm', 'armhole': '50 cm'}
841	1	{'bust': '80 cm', 'waist': '80 cm', 'length': '52 cm', 'sleeve length': '58 cm', 'armhole': '45 cm', 'center front length': '32 cm'}
842	2CARDIGAN	{'bust': '86 cm', 'waist': '86 cm', 'length': '53 cm', 'sleeve length': '58 cm', 'armhole': '47 cm', 'center front length': '33 cm'}
843	ALL SIZE	{'bust': '90 cm', 'waist': '96 cm', 'length': '86 cm', 'armhole': '50 cm'}
844	SMALL	{'waist': '60-76 cm', 'hip': '88-100 cm', 'length': '97 cm', 'thigh circumference': '56 cm', 'front rise': '30 cm', 'front/back rise': '37 cm'}
845	MEDIUM	{'waist': '66-82 cm', 'hip': '92-104 cm', 'length': '98 cm', 'thigh circumference': '58 cm', 'front rise': '30 cm', 'front/back rise': '38 cm'}
846	LARGE	{'waist': '70-86 cm', 'hip': '96-108 cm', 'length': '98 cm', 'thigh circumference': '60 cm', 'front rise': '30 cm', 'front/back rise': '38 cm'}
847	XL	{'waist': '76-92 cm', 'hip': '102-114 cm', 'length': '99 cm', 'thigh circumference': '62 cm', 'front rise': '30 cm', 'front/back rise': '39 cm'}
848	SMALL	{'waist': '66 cm - 84 cm', 'hip': '96 cm', 'thigh': '64 cm', 'length': '107 cm', 'front/back rise': '30 cm/39 cm'}
849	MEDIUM	{'waist': '70 cm - 88 cm', 'hip': '100 cm', 'thigh': '66 cm', 'length': '107 cm', 'front/back rise': '31 cm/40 cm'}
850	LARGE	{'waist': '74 cm - 92 cm', 'hip': '104 cm', 'thigh': '68 cm', 'length': '107 cm', 'front/back rise': '31 cm/40 cm'}
851	ALL SIZE	{'bust': '74 cm - 102 cm', 'waist': '70 cm - 98 cm', 'armhole': '40 cm', 'sleeve length': '58 cm', 'length': '58 cm'}
852	ALL SIZE	{'bust': '110 cm', 'waist': '112 cm', 'length': '76 cm', 'armhole': '59 cm', 'sleeve length': '60 cm'}
853	SMALL	{'waist': '62 - 68 cm', 'hip': '90 - 96 cm', 'thigh': '64 cm', 'front/back rise': '33/43 cm', 'length': '102 cm'}
854	MEDIUM	{'waist': '64 - 70 cm', 'hip': '94 - 100 cm', 'thigh': '66 cm', 'front/back rise': '34/44 cm', 'length': '103 cm'}
855	LARGE	{'waist': '68 - 74 cm', 'hip': '98 - 104 cm', 'thigh': '68 cm', 'front/back rise': '35/45 cm', 'length': '104 cm'}
856	1	{'bust': '92 cm', 'waist': '92 cm', 'length': '50 cm', 'armhole': '44 cm'}
857	2	{'bust': '98 cm', 'waist': '98 cm', 'length': '51,5 cm', 'armhole': '46 cm'}
858	ALL SIZE	{'bust': '110 cm', 'waist': '112 cm', 'length': '76 cm', 'armhole': '59 cm', 'sleeve length': '60 cm'}
859	ALL SIZE	{'bust': '74 cm - 102 cm', 'waist': '70 cm - 98 cm', 'armhole': '40 cm', 'sleeve length': '58 cm', 'length': '58 cm'}
860	SMALL	{'bust': '86 cm', 'waist': '78 cm', 'length': '69 cm', 'armhole': '44 cm'}
861	MEDIUM	{'bust': '92 cm', 'waist': '84 cm', 'length': '70 cm', 'armhole': '46 cm'}
862	LARGE	{'bust': '98 cm', 'waist': '90 cm', 'length': '71 cm', 'armhole': '48 cm'}
863	SMALL	{'bust': '92 cm', 'waist': '92 cm', 'length': '55 cm', 'armhole': '46 cm', 'sleeve length': '15 cm'}
864	MEDIUM	{'bust': '100 cm', 'waist': '100 cm', 'length': '58 cm', 'armhole': '48 cm', 'sleeve length': '16 cm'}
865	ALL SIZE	{'bust': '115 cm', 'waist': '115 cm', 'length': '62 cm', 'sleeve length': '27 cm', 'armhole': '61 cm'}
866	ALL SIZE	{'bust': '72 cm - 100 cm', 'waist': '64 cm - 92 cm', 'armhole': '45 cm', 'length': '57 cm'}
867	ALL SIZE	{'bust': '124 cm', 'waist': '88 cm', 'length': '52 cm', 'armhole': '40 cm', 'sleeve length': '49 cm'}
868	ALL SIZE	{'bust': '72 cm - 100 cm', 'waist': '64 cm - 92 cm', 'armhole': '45 cm', 'length': '57 cm'}
869	1	{'bust': '86 cm', 'waist': '88 cm', 'armhole': '46 cm', 'length': '57 cm'}
870	2	{'bust': '92 cm', 'waist': '94 cm', 'armhole': '48 cm', 'length': '60 cm'}
871	ALL SIZE	{'bust': '110 cm', 'waist': '110 cm', 'length': '82 cm', 'armhole': '53 cm', 'sleeve length': '59 cm'}
872	SMALL	{'waist': '60-76 cm', 'hip': '88-100 cm', 'length': '97 cm', 'thigh circumference': '56 cm', 'front rise': '30 cm', 'front/back rise': '37 cm'}
873	MEDIUM	{'waist': '66-82 cm', 'hip': '92-104 cm', 'length': '98 cm', 'thigh circumference': '58 cm', 'front rise': '30 cm', 'front/back rise': '38 cm'}
874	LARGE	{'waist': '70-86 cm', 'hip': '96-108 cm', 'length': '98 cm', 'thigh circumference': '60 cm', 'front rise': '30 cm', 'front/back rise': '38 cm'}
875	XL	{'waist': '76-92 cm', 'hip': '102-114 cm', 'length': '99 cm', 'thigh circumference': '62 cm', 'front rise': '30 cm', 'front/back rise': '39 cm'}
876	ALL SIZE	{'waist': '64-100 cm', 'hip': '96-112 cm', 'length': '38 cm'}
877	ALL SIZE	{'bust': '100 cm', 'waist': '106 cm', 'length': '83 cm', 'armhole': '54 cm', 'sleeve length': '62 cm'}
878	ALL SIZE	{'bust': '116 cm', 'waist': '112 cm', 'hem': '118 cm', 'length': '75 cm', 'armhole': '59 cm', 'sleeve length': '61 cm'}
879	ALL SIZE	{'bust': '84-94 cm', 'waist': '72-82 cm', 'length': '88 cm', 'armhole': '40 cm'}
880	SMALL	{'bust': '96 cm', 'waist': '68 cm', 'length': '59 cm', 'sleeve length': '19 cm', 'armhole': '54 cm'}
881	MEDIUM	{'bust': '100 cm', 'waist': '72 cm', 'length': '60 cm', 'sleeve length': '20 cm', 'armhole': '56 cm'}
882	LARGE	{'bust': '104 cm', 'waist': '76 cm', 'length': '61 cm', 'sleeve length': '21 cm', 'armhole': '58 cm'}
883	ALL SIZE	{'bust': '84-94 cm', 'waist': '72-82 cm', 'length': '88 cm', 'armhole': '40 cm'}
884	ALL SIZE	{'bust': '90 cm', 'waist': '86 cm', 'length': '90 cm (include strap)', 'armhole': '58 cm', 'sleeve length': '26 cm'}
885	1	{'waist': '70 cm', 'hip': '102 cm', 'thigh circumference': '60 cm', 'length': '104 cm', 'front rise': '30 cm', 'front/back rise': '40 cm'}
886	2	{'waist': '80 cm', 'hip': '110 cm', 'thigh circumference': '62 cm', 'length': '104 cm', 'front rise': '30 cm', 'front/back rise': '40 cm'}
887	ALL SIZE	{'waist': '68-120 cm', 'hip': '106 cm', 'length': '37 cm'}
888	ALL SIZE	{'bust': '112 cm', 'waist': '112 cm', 'length': '49 cm', 'sleeve length': '56 cm', 'armhole': '58 cm'}
889	1	{'bust': '86 cm', 'waist': '88 cm', 'armhole': '46 cm', 'length': '57 cm'}
890	2	{'bust': '92 cm', 'waist': '94 cm', 'armhole': '48 cm', 'length': '60 cm'}
891	1	{'waist': '64-84 cm', 'hip': 'up to 94 cm', 'length': '95 cm'}
892	2	{'waist': '68-90 cm', 'hip': 'up to 98 cm', 'length': '96 cm'}
896	EXTRA LARGE	{'waist': '74 cm', 'hip': '95 cm', 'length': '107\\xa0cm'}
897	SMALL	{'waist': '58 - 88 cm', 'hip': '72 - 94 cm', 'length': '91 cm'}
898	MEDIUM	{'waist': '60 - 96 cm', 'hip': '76 - 100 cm', 'length': '92 cm'}
899	LARGE	{'waist': '66 - 102 cm', 'hip': '82 - 106 cm', 'length': '93 cm'}
900	SMALL	{'bust': '96 cm', 'waist': '96 cm', 'length': '70 cm', 'sleeve length': '20 cm', 'armhole': '52 cm'}
901	MEDIUM	{'bust': '104 cm', 'waist': '104 cm', 'length': '73 cm', 'sleeve length': '22 cm', 'armhole': '54 cm'}
902	LARGE	{'bust': '112 cm', 'waist': '112 cm', 'length': '76 cm', 'sleeve length': '24 cm', 'armhole': '56 cm'}
903	ALL SIZE	{'bust': '88 cm', 'waist': '88 cm', 'length': '45 cm', 'sleeve length': '22 cm', 'armhole': '48 cm'}
904	ALL SIZE	{'bust': '114 cm', 'waist': '118 cm', 'armhole': '62 cm', 'sleeve length': '46 cm', 'front length/back length': '75/80 cm'}
905	ALL SIZE	{'bust': 'up to 115 cm', 'waist': 'up to 115 cm', 'length': '73 cm', 'sleeve length': '60 cm', 'armhole': '60 cm'}
906	ALL SIZE	{'bust': '82 cm - 90 cm', 'waist': '92 cm - 100 cm', 'armhole': '41 cm', 'length': '86 cm'}
907	S	{'waist': '66 cm', 'hip': '90 cm', 'thigh': '60 cm', 'front/back rise': '33/43 cm', 'length': '100 cm'}
908	M	{'waist': '70 cm', 'hip': '94 cm', 'thigh': '62 cm', 'front/back rise': '33,5/43,5 cm', 'length': '100 cm'}
909	L	{'waist': '74 cm', 'hip': '98 cm', 'thigh': '64 cm', 'front/back rise': '33,5/43,5 cm', 'length': '100 cm'}
910	1 :	{'waist': '66-90 cm', 'hip': '90 cm', 'length': '40 cm'}
911	ALL SIZE	{'bust': '84 cm', 'waist': '86 cm', 'length': '42 cm', 'armhole': '50 cm'}
912	ALL SIZE	{'bust': '94 cm - 112 cm', 'waist': '74 cm - 92 cm', 'length': '64 cm', 'armhole': '40 cm', 'sleeve length': '59 cm'}
913	ALL SIZE	{'bust': '98 cm', 'waist': '96 cm', 'length': '55 cm', 'armhole': '48 cm', 'sleeve length': '61 cm'}
914	ALL SIZE	{'bust': '88 cm', 'waist': '80 cm', 'length': '58 cm', 'armhole': '46 cm', 'sleeve length': '59 cm'}
915	ALL SIZE	{'bust': '96-102 cm', 'waist': '96-102 cm', 'length': '49 cm', 'sleeve length': '22 cm', 'armhole': '46 cm'}
916	ALL SIZE	{'bust': '96 cm', 'waist': '104 cm', 'length': '66 cm', 'armhole': '44 cm', 'sleeve length': '14 cm'}
917	ALL SIZE	{'bust': '116 cm', 'waist': '116 cm', 'armhole': '30 cm - 45 cm (dropped shoulder)', 'sleeve length': '43 cm', 'length': '62 cm'}
918	ALL SIZE	{'bust': '100 cm', 'waist': '100 cm', 'length': '116 cm', 'armhole': '48 cm', 'sleeve length': '57 cm'}
919	ALL SIZE	{'bust': '100 cm', 'waist': '104 cm', 'length': '52 cm', 'armhole': '48 cm', 'sleeve length': '59 cm'}
920	ALL SIZE	{'bust': '98 cm', 'waist': '92 cm', 'length': '62 cm', 'armhole': '54 cm', 'sleeve length': '65 cm'}
921	ALL SIZE	{'bust': '100 cm', 'waist': '100 cm', 'length': '62 cm', 'sleeve length': '22 cm', 'armhole': '45 cm'}
922	1	{'bust': '68 cm - 84 cm', 'waist': '60 cm - 74 cm', 'length': '76 cm', 'hip': '86 cm - 100 cm'}
923	2	{'bust': '72 cm - 88 cm', 'waist': '64 cm - 78 cm', 'length': '79 cm', 'hip': '90 cm - 104 cm'}
924	ALL SIZE	{'bust': '120 cm', 'waist': '124 cm', 'length': '76 cm', 'armhole': '60 cm', '': '72 cm'}
925	1	{'bust': '90 cm', 'waist': '94 cm', 'armhole': '47 cm', 'sleeve length': '21 cm', 'length': '80 cm'}
926	2	{'bust': '96 cm', 'waist': '100 cm', 'armhole': '49 cm', 'sleeve length': '23 cm', 'length': '82 cm'}
927	1	{'waist': '68 cm', 'hip': '100 cm', 'length': '37 cm'}
928	2	{'waist': '74 cm', 'hip': '106 cm', 'length': '38 cm'}
929	ALL SIZE	{'bust': '96 cm', 'waist': '94 cm', 'length': '82 cm', 'sleeve length': '20 cm', 'armhole': '46 cm'}
930	ALL SIZE	{'bust': '72cm - 100 cm', 'waist': '64 cm - 92 cm', 'armhole': '45 cm', 'length': '57 cm'}
931	1	{'bust': '90 cm', 'waist': '90 cm', 'armhole': '48 cm', 'sleeve length': '18 cm', 'length': '57 cm'}
932	2	{'bust': '98 cm', 'waist': '98 cm', 'armhole': '51 cm', 'sleeve length': '20 cm', 'length': '59 cm'}
933	ALL SIZE	{'bust': '100 cm', 'waist': '100 cm', 'length': '118 cm', 'armhole': '50 cm', 'sleeve length': '58 cm'}
934	SMALL	{'waist': '64 cm - 84 cm', 'hip': '94 cm', 'thigh': '64 cm', 'length': '108 cm', 'front/back rise': '30 cm/39 cm'}
935	MEDIUM	{'waist': '68 cm - 88 cm', 'hip': '98 cm', 'thigh': '66 cm', 'length': '108 cm', 'front/back rise': '31 cm/40 cm'}
936	LARGE	{'waist': '72 cm - 92 cm', 'hip': '102 cm', 'thigh': '68 cm', 'length': '109 cm', 'front/back rise': '32 cm/41 cm'}
937	1	{'waist': '76 cm', 'hip': '107 cm', 'thigh': '68 cm', 'length': '31 cm', 'front/back rise': '25 cm/36 cm'}
938	2	{'waist': '82 cm', 'hip': '113 cm', 'thigh': '71 cm', 'length': '32 cm', 'front/back rise': '27 cm/38 cm'}
939	ALL SIZE	{'bust': '72 cm - 100 cm', 'waist': '64 cm - 92 cm', 'armhole': '45 cm', 'length': '57 cm'}
940	SMALL	{'bust': '103 cm', 'waist': '68 cm', 'length': '58 cm (from center back)', 'armhole': '42 cm'}
941	MEDIUM	{'bust': '107 cm', 'waist': '72 cm', 'length': '59 cm (from center back)', 'armhole': '44 cm'}
942	LARGE	{'bust': '111 cm', 'waist': '76 cm', 'length': '60 cm (from center back)', 'armhole': '46 cm'}
943	ALL SIZE	{'bust': '100 cm', 'waist': '100 cm', 'length': '62 cm', 'sleeve length': '22 cm', 'armhole': '45 cm'}
944	ALL SIZE	{'bust': '100-114 cm', 'waist': '100-114 cm', 'length': '62 cm', 'armhole': '46 cm', 'sleeve length': '17.5 cm'}
945	1	{'bust': '90 cm', 'waist': '82 cm', 'length': '66 cm', 'armhole': '43 cm', 'sleeve length': '52 cm'}
946	2	{'bust': '102 cm', 'waist': '94 cm', 'length': '71 cm', 'armhole': '48 cm', 'sleeve length': '53 cm'}
947	SMALL	{'waist': '66 cm - 84 cm', 'hip': '96 cm', 'thigh': '64 cm', 'length': '107 cm', 'front/back rise': '30 cm/39 cm'}
948	MEDIUM	{'waist': '70 cm - 88 cm', 'hip': '100 cm', 'thigh': '66 cm', 'length': '107 cm', 'front/back rise': '31 cm/40 cm'}
949	LARGE	{'waist': '74 cm - 92 cm', 'hip': '104 cm', 'thigh': '68 cm', 'length': '107 cm', 'front/back rise': '31 cm/40 cm'}
\.


--
-- Data for Name: dim_products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dim_products (product_id, name, description, material, size, image_url, is_discount) FROM stdin;
8252031893743	Ruby Top Red	Cut and sewn from our all time favorite premium Japanese polyester fabric, we put a tweak to a simple tanktop by giving a puffed peplum panels on the side. Playful yet still simple, perfect to throw on for simple events or night out with friends!Model : 175 cm	100% Japanese made Premium Polyester	1, 2	http://dumaofficial.com/cdn/shop/files/RubyTopRed.jpg?v=1706001577	f
8896420479215	Riri Pants | Dark Denim	These barrel-leg denim pants are designed for comfort and style, featuring a high-waisted fit and a slightly curved silhouette. The dark-wash denim gives them a timeless, polished look, while the unique panel stitching at the bottom adds a distinctive touch. The relaxed fit ensures ease of movement, making them perfect for both casual outings and stylish everyday wear.	100% Cotton	Small, Medium, Large, XL	http://dumaofficial.com/cdn/shop/files/RIRIPANTSDARKDENIM-2.jpg?v=1740439538	f
8114152866031	Khaye Shirt Navy	Transition from summer with our short boxy shirt decorated with all-over floral embroidery. With long sleeves and front button fastening, it is scalloped at the bottom and sleeves a bit puffed. This refreshing style can be worn with your favorite bottoms from mini skirt to long denim pants!	50% Cotton, 50% Polyester	All Size	http://dumaofficial.com/cdn/shop/files/KhayeShirtNavy-2.jpg?v=1695000776	f
8030793269487	Lesley Jeans Black	Denim trousers is a definite staple for your wardrobe, especially this pair as they're comfortable and fits like a glove. This pair is shaped for a flared silhouette with full-length legs and slits at cuffs that will make your legs looks super long and slim. They're crafted from a stretch cotton denim for lightness and comfort it won't feel like your wearing jeans at all!	100% Cotton	S, M, L, XL	http://dumaofficial.com/cdn/shop/files/buttonsilver2.jpg?v=1683007165	f
8101851758831	Kano Set Fuchsia	Our cropped cardigan and adjustable tank top set is a seasonless essential that can be worn as a set or separates. Lightweight knitwear pieces, with point collar and button front fastening cardigan, completed with an adjustable strap basic tanktop. Perfect for any look you're going for any time of day!	100% Cotton	1, 2	http://dumaofficial.com/cdn/shop/files/DAN-20230615-DUMA-810.jpg?v=1692592949	f
8110097236207	Monet Top Navy	Cropped polo shirt with a shape inspired by sportswear look. Knitted in a fancy wave pattern the perfect cropped length, smartened up with pointed collar, gold buttons and scalooped edges. Crafted with Viscose yarns for fluidity and signature pink color perfect to spice up your everyday wardrobe.	85% Viscose, 15% Nylon	All Size	http://dumaofficial.com/cdn/shop/files/MonetTopNavy-2.jpg?v=1693836187	f
8843368071407	Marda Dress | Camel	Chic and versatile, this mini shirt dress is a wardrobe essential. Featuring a button-down front with covered buttons for a sleek look, it’s designed with a box-pleated skirt that adds structure and movement. The matching fabric belt with a buckle detail cinches the silhouette for a flattering, polished look. Perfect for both casual and dressy occasions, this dress combines timeless style with modern sophistication.	100% Polyester	1, 2	http://dumaofficial.com/cdn/shop/files/MARDADRESSCAMEL-1_e8d47b65-3cd2-46e5-9c6b-e972f3ed6dae.jpg?v=1734420753	f
8897161363695	Acma Shirt Top | Black	This knit top exudes elegance with its soft drape and smooth texture, offering both comfort and sophistication. Featuring a notched collar and button-down front, it blends classic tailoring with a relaxed, modern feel. The half sleeves provide a balanced look, making it suitable for both warm and transitional weather. The subtly fitted silhouette enhances the figure while maintaining ease of movement, and the split hem detail at the front adds a contemporary touch. Easily style this top with tailored trousers for a polished look or paired with denim for effortless chic.	Rayon Blend	1, 2	http://dumaofficial.com/cdn/shop/files/ACMASHIRTTOPBLACK-1.jpg?v=1740366090	f
8664379425007	Oson Outer | Denim Blue	Turn effortless cool with our Oson Denim Outer. This slightly cropped denim jacket features a boxy fit and contrast seam stitching for a modern appeal. The deep blue colorway and button detailing add a sophisticated edge. Pair with the Remmy Skort | Denim Blue or Agatha Shorts | Denim Blue for the perfect stylish set.	100% Polyester	ALL SIZE	http://dumaofficial.com/cdn/shop/files/OSONDENIMBLAZERBLUE-1.jpg?v=1720522408	f
8913099194607	Asner Houndstooth Blazer | White Multi	This black and white houndstooth top features a structured, short-sleeve design with a button-up front. The high neckline and tailored fit give it a polished and sophisticated look, making it a versatile piece for both formal and casual styling. Pair it with our Rum Houndstooth Shorts for a coordinated set, or our Balestra Skirt for an elegant contrast.	Poly Blend	1, 2	http://dumaofficial.com/cdn/shop/files/AsnerHoundstoothBlazer.jpg?v=1741855039	f
7947445043439	Malachi Sparkly Sweater Navy	A Set of oversized sweater and shorts is a classic knitwear with a shimmering twist, perfect to bring you the festive holiday mood. Crafted from soft cotton and lurex blend, the sweater is cut to a relaxed fit with drop shoulders, shorts are pull on with elastic band. Definately the perfect choice of outfit for your homey get-together this upcoming holidays season.	95% chenille 5% polyethylene	All Size	http://dumaofficial.com/cdn/shop/products/MalachiSweaterNavy_4_e63ea6eb-ee05-4f3c-9371-78b18afd2413.jpg?v=1670551840	f
8897190887663	Iggy Top | Black	Elevate your everyday style with our Iggy Top! Crafted from soft and stretch viscose yarn with ribbed detailing, this top exudes a modern and effortless appeal. This tank design features an off-center placket with tonal buttons, and a flattering, form-hugging fit. Pair it with your favorite high-waisted jeans for a casual-chic look or layer it under a blazer for a polished finish—versatile and stylish, it's a must-have staple for any wardrobe.	Soft Viscose	ALL SIZE (Fit To L)	http://dumaofficial.com/cdn/shop/files/IGGYTOPBLACK-6.jpg?v=1740458264	f
8825016811759	MMEHUILLET FOR DUMA - Hwi Scarf | White	Crafted from soft structured cotton, this hybrid poncho doubles as a scarf that can be draped over the shoulder for an effortless look. Secured with a single button on one shoulder that you can accessorize with our clip-on buttons. The dynamic silhouette and timeless color palette offer endless styling potential.	100% Cotton	All Size	http://dumaofficial.com/cdn/shop/files/HwiScarfWhite-2.jpg?v=1732724974	f
8006504284399	Maya Blazer Grey	Knitted from soft cotton yarns into the perfect blazer top design and silhouette, finished with shoulder pads and covered buttons. Something you never knew you needed in your capsule wardrobe. Undeniably comfortable, suitable for formal or business casual events, keeps you looking professional yet comfortable for your important meetings. Can't forget how perfect it looks as an outer too! This piece will be your best purchase yet!	100% COTTON	All Size	http://dumaofficial.com/cdn/shop/products/MayaTopGrey.jpg?v=1677143694	f
8196225892591	Oslo Blazer Beige	This cropped blazer is crafted with both the perfect silhouette and style, and the most delicate tailoring. Crafted from premium Japanese polyester, it's cut in an oversized boxy shape that's enhanced by the lightly padded shoulders. Additional	100% Japanese made Premium Polyester	ALL SIZE (FIT TO L)	http://dumaofficial.com/cdn/shop/files/OsloBlazerBeige.jpg?v=1700779086	f
8843358404847	Bruni Top | Dark Brown	Channeling a modern refinement, this deep brown top is crafted from premium Japanese polyester that’s soft and stretchy. It’s cut in an oversized shape with a bias-cut scarf detail to fasten around your neck or drape it effortlessly over your shoulder.	100% Japanese made Premium Polyester	ALL SIZE	http://dumaofficial.com/cdn/shop/files/BRUNITOPDARKBROWN-2.jpg?v=1734484605	f
7975351189743	Mudan Blazer Red	Tailored from smooth and lustrous satin print fabric in a double-breasted, slightly oversized silhouette. It has a face framing peak lapels with a structured tailoring front body design, and a relaxed shirt silhouette design on the back. Perfectly comfortable to wear yet still appropriate for formal occasions. Finished with Chinese button	100% Polyester	All Size	http://dumaofficial.com/cdn/shop/products/MudanBlazerRed.jpg?v=1673497112	f
7946313138415	Rafa Pants Green	Knitted from soft cotton yarns into the perfect christmas color pointelle knit pattern, this high waisted knit palazzo pants features a high rise, flared style and a relaxed fit. This pants is equally comfortable and fashionable, perfect for your get togethers this holiday season! Pair it with our Rami Cardigan to create an effortlessly chic outfit for your year end festivities!	100% Cotton	1 &amp; 2	http://dumaofficial.com/cdn/shop/products/RafaPantsGreen_4.jpg?v=1670552032	f
8986672595183	Verra Top | Black	This top features soft drapes across the front that create a flattering, elegant shape. It’s designed with shoulder padding to give structure and a bold silhouette. The added buttoned shoulder detail gives it a modern, tailored touch. A perfect mix of strong and feminine.	100% Polyester	Small, Medium, Large	http://dumaofficial.com/cdn/shop/files/VERRATOPBLACK1.jpg?v=1750786047	f
8294607487215	BELINDA | Regular Fit Extreme Soft in White	A very versatile and classic t-shirt, offered in classic white. Crafted from a special cotton blend that’s soft to the touch, this classic crew neck top is cut for a neat fit with the perfect length.	100 % Cotton Blend	All Size (Fit to XL)	http://dumaofficial.com/cdn/shop/files/LEN01114-edit.jpg?v=1708999379	f
8498246156527	Carolina Vest Grey	Focusing on classic tailoring this season, this waistcoat is meticulously crafted from premium polyester blend suiting fabric and designed with a contoured waist and a rounded hem for a more feminine touch. Style it with wide-legged trousers or midi skirt for the perfect clean girl look!	100% Polyester	S, M, LMeasurement :	http://dumaofficial.com/cdn/shop/files/CAROLINAVESTGREY-3.jpg?v=1715741507	f
8329436856559	Rosette Blazer Pink	A must have special silhouette this season. We create this outer with artful tailoring and updated design elements. Designed with a boxy fit, the perfect pink shade, soft collared neckline, and the statement draped large 3D floral fabric. The perfect crowd pleaser piece!	100% Japanese made Premium Polyester	ALL SIZE	http://dumaofficial.com/cdn/shop/files/RosetteBlazerPink_2a0346cc-6121-4a56-8410-f32abdc31e03.jpg?v=1711037505	f
8959791005935	Tan Pants | Dark Brown	Elevate your look with these effortlessly chic high-waisted satin pants. Designed with a bias cut for a beautifully fluid drape, they feature an easy wide-leg silhouette that moves gracefully with every step. The slip-on style and elasticized waistband ensure a comfortable, flattering fit, making these pants perfect for both casual and dressy occasions. Pair them with your favorite top for a polished yet relaxed vibe.	100% Premium Polyester	Small, Medium, Large	http://dumaofficial.com/cdn/shop/files/TANPANTSDARKBROWN-1.jpg?v=1747646736	f
8823420420335	MMEHUILLET FOR DUMA - Seonyul Top | White Multi	Seonyul Top combines classic sophistication with a modern twist. Featuring a structured collar that exudes an elegant, polished look while the peplum design flatteringly accentuates the waist. Crafted from custom-made tweed, the fabric boasts vibrant multi-colored stripes that adds a playful element to the timeless texture. Wear it as it is or add a little bling with our clip-on buttons, this top seamlessly merges fashion-forward style with tailored elegance.	100% Polyester	Small, Medium, Large	http://dumaofficial.com/cdn/shop/files/SeonyulTopWhite-2.jpg?v=1732725721	f
8823421108463	MMEHUILLET FOR DUMA - Seonyul Top | Green	Seonyul Top combines classic sophistication with a modern twist. Featuring a structured collar that exudes an elegant, polished look while the peplum design flatteringly accentuates the waist. Wear it as it is or add a little bling with our clip-on buttons, this top seamlessly merges fashion-forward style with tailored elegance.	100% Polyester	Small, Medium, Large	http://dumaofficial.com/cdn/shop/files/SeonyulTopGreen-2.jpg?v=1732725653	f
8211461472495	Bronte Top Maroon	Our best-selling Bronte top in a special holiday color! This long-sleeved top is one of the essential piece created for our newest collection. It’s crafted from soft breathable cotton with a touch of stretch and features a draped square neck top and bolero style fitted sleeves. Easily style with your go to pants for an elevated look in seconds.	100% Cotton	ALL SIZE	http://dumaofficial.com/cdn/shop/files/BronteTopMaroon.jpg?v=1701949525	f
8897112965359	Matchia Top | Green Multi	This sleeveless tweed top combines classic elegance with a modern touch, featuring a tweed fabric in a chic checkered pattern. The covered button closure adds a refined touch, while the rounded hem with a front slit enhances movement and creates a flattering, elongated look. Whether paired with tailored trousers for a professional setting or styled with denim for a casual yet refined look, this tweed top is a wardrobe essential for effortless sophistication.	Poly Blend	Small, Medium, Large	http://dumaofficial.com/cdn/shop/files/MATCHIATOP-5.jpg?v=1741927670	f
8005163909359	Elia Dress Bone	Designed from a lightweight fluid woven shirting fabric, this scoop neck tank top dress featuring panels that creates the perfect a-line fit with slimming silhouette is definitely a wardrobe staple for you all year round!	100% Japanese made Premium Polyester	1, 2	http://dumaofficial.com/cdn/shop/products/EliaDressBone-2.jpg?v=1677200769	f
8664988549359	Malia Knit Dress | Navy	Channeling this season's key trend of dropped-waist silhouettes, we designed and knitted this dress from soft and stretchy nylon fabric and has a form-fitting top half and flared mini skirt, with on-tone stripe textures for a more modern appeal.	100% Nylon	ALL SIZE	http://dumaofficial.com/cdn/shop/files/MALIADRESSNAVY-2.jpg?v=1720522351	f
8196079255791	Remy Tee Grey	An essential everyday fitted t-shirt, designed with a crew neck fit and a buttery soft feel. Perfect to wear alone or as a layering piece, this body-hugging tee is a must for everyone's capsule wardrobe!	90% Polyester, 10% Elastane	S, M, L	http://dumaofficial.com/cdn/shop/files/RemyTeeGrey.jpg?v=1700779596	f
8913521967343	Ruche Cardigan | Cream	This cream-colored knit top knitted from the softest viscose yarns is cozy yet stylish. It features a ruffled trim along the button-up front, decorated with pearl-like buttons for an elegant touch. The ruffles also accent the hem and cuffs, adding a feminine charm. With its classic round neckline and comfortable fit, this cardigan that also doubles as a top is perfect for both casual and dressy outfits.	Soft Viscose	ALL SIZEMeasurement :	http://dumaofficial.com/cdn/shop/files/RucheCardiganCream-4.jpg?v=1741924975	f
8329468575983	Ara Dress Black	Our Ara dress is designed with a laid back silhouette, perfect for attending your Ramadhan festivities, our to use for everyday styling. Crafted from our special lace brocade, this dress is a free flowing piece, featuring front button openings and accentuated sleeves, and includes an inner cotton dress.	100% Polyester	ALL SIZE	http://dumaofficial.com/cdn/shop/files/AraDressBlack.jpg?v=1711026496	f
7739104919791	Julian Dress Brown	Knitted from very soft and elastic viscose yarns, this relaxed fit shirt dress features a straight fit and front pocket flaps for a laid-back, casual silhouette. The sleeve cuff and buttons	SOFT VISCOSE	ALL SIZE	http://dumaofficial.com/cdn/shop/products/FUNDAMENTALSRESIZEDCATALOGArtboard2.jpg?v=1657767965	f
7894126461167	Shilpa Dress Denim Blue	Mini dress made from 100% Tencel denim. It's shaped to a voluminous silhouette with the perfectly constructed boat neckline that gives a feminine touch, and finiished with dainty shell buttons fastening. Style it with a hat and sandals on warm days, or your favorite pair of sneakers on a casual errands day!	100% TENCEL	ALL SIZE	http://dumaofficial.com/cdn/shop/products/ShilpaDenim_2.jpg?v=1666741920	f
8005157617903	Orca Shirt Black	An elevated wardrobe staple, this structured short sleeve shirt is cut from a premium stretc fabric, finished with side slit, pointed flat collar, front button fastening and the perfect contouring slim fit for an effortless look. Complete the look by pairing it with our Martis flared pants for an effortless polished look.	100% Japanese made Premium Polyester	1, 2	http://dumaofficial.com/cdn/shop/products/OrcaShirtBlack.jpg?v=1677143358	f
8037940429039	Yanza Dress Navy	In efforts of combining the comfort of knits, the elegance of printed silk, and unrestricted silhouette, we've created this dress for all the women out there. Long sleeve midi dress with basic crew neck, soft cotton knit and lustrous satin fabric combination, loose relaxed fit, slit on hem. Perfect for an easy throw on outfit!	Knit: 100% CottonPrint Fabric: 100% Polyester	ALL SIZE	http://dumaofficial.com/cdn/shop/products/YanzaNavy1.jpg?v=1681273384	f
8913102569711	Orega Blazer | Black Multi	This black and white tweed blazer features a classic checkered pattern with a structured silhouette. It has a notched lapel, a single-button closure, and two front pockets with frayed trim	Poly Blend	1, 2	http://dumaofficial.com/cdn/shop/files/OregaBlazerBlack.jpg?v=1741855069	f
8117368979695	Vallen Outer Pink	Designed for a minimal look with our signature japanese preminum polyester fabric in a limited edition pink color, this jacket has a perfectly cropped silhouette and tailored fit with a special touch of gold button closure in the center front of the jacket. Perfect to throw on all year round!	100% Japanese made Premium Polyester	ALL SIZE	http://dumaofficial.com/cdn/shop/files/VallenOuterPink.jpg?v=1695117414	f
8145570005231	Bronte Top Brown	This long-sleeved top is one of the essential piece created for our newest collection. It’s crafted from soft breathable cotton with a touch of stretch and features a draped square neck top and bolero style fitted sleeves. Easily style with your go to pants for an elevated look in seconds.	100% Cotton	All Size	http://dumaofficial.com/cdn/shop/files/BronteTopBrown.jpg?v=1697776183	f
9024414941423	Tan Pants | Pink	Elevate your look with these effortlessly chic high-waisted satin pants. Designed with a bias cut for a beautifully fluid drape, they feature an easy wide-leg silhouette that moves gracefully with every step. The slip-on style and elasticized waistband ensure a comfortable, flattering fit, making these pants perfect for both casual and dressy occasions. Pair them with your favorite top for a polished yet relaxed vibe.	100% Polyester	Small, Medium	http://dumaofficial.com/cdn/shop/files/TanPantsPink1.jpg?v=1753698350	f
8218753532143	Carli Knit Sweater Grey	Expertly crafted knit sweater in two-tone twisted yarns prefect for the holidays. This seamless sweater is made from premium cotton yarns that's equal part soft and breathable. It's designed with a thick ribbed turtle neck and a ribbed hem for subtle structure.	100% Cotton	ALL SIZE	http://dumaofficial.com/cdn/shop/files/CarliKnitSweaterGrey-2.jpg?v=1702572309	f
8294599164143	ROSA | Slim Fit Crew Neck in Black	A wardrobe staple offered in classic black, it’s crafted from soft and stretch lyocell and has a streamlined slim fit that's ideal for daily or for layering purposes.	100 % Lyocell Blend	All Size (Fit to Large)	http://dumaofficial.com/cdn/shop/files/LEN01444-edit.jpg?v=1709004757	f
8913498046703	Budan Top | Black	This sleeveless black top features a structured, tailored fit with a button-up front and a subtle flare at the waist, creating an elegant silhouette. Its minimalist design makes it a versatile staple, perfect for pairing with wide-leg trousers, our Tan Pants | Black or a sleek pencil skirt for a refined look.	Poly Blend	Small, Medium, Large	http://dumaofficial.com/cdn/shop/files/BudanTopBlack.jpg?v=1741855281	f
8498622595311	Sienna Draped Top Black | BACK IN STOCK	Crafted from Soft Buttery knit blend with a fluid hand feel, this black blouse is designed with drapes, fitted sleeves, and a mock neckline. Style it with tailored trousers and kitten heels for the perfect polished look!	90% Polyester, 10% Elastane	ALL SIZE	http://dumaofficial.com/cdn/shop/files/SIENNA_TOP_BLACK-5_29e2f62a-e916-446e-9ef7-c2d043af6023.jpg?v=1745991533	f
7894080979183	Maya Blazer White	Knitted from soft cotton yarns into the perfect blazer top design and silhouette, finished with shoulder pads and covered buttons. Something you never knew you needed in your capsule wardrobe. Undeniably comfortable, suitable for formal or business casual events, keeps you looking professional yet comfortable for your important meetings. Can't forget how perfect it looks as an outer too! This piece will be your best purchase yet!	100% COTTON	All Size	http://dumaofficial.com/cdn/shop/products/MayaWhite_3.jpg?v=1666743049	f
8081694392559	Balma Cardigan Navy	Knitted from soft cotton yarns, this tartan plaid cardigan is designed for a slim fit, with a deep v-neckline and fastened with a row of tonal buttons for a uniform finish. It's a wardrobe essential that can be styled multiple ways to create different looks. Pair it with our Kai Shorts for an easy preppy chic look.	100% COTTON	All Size	http://dumaofficial.com/cdn/shop/files/BalmaCardiganNavy1.png?v=1688920908	f
7955609616623	Ansel Cardigan Green	Knitted from soft viscose yarns, this V-neck cardigan is designed for a regular fit and features a subtly nipped-in waist. It has modern tubular trims, finished with front button closure and ribbed cuffs and hems. The perfect luxurious loungewear you need in your wardrobe!	Soft Viscose	All Size	http://dumaofficial.com/cdn/shop/products/AnselCardiganGreen.jpg?v=1670990565	f
9024432537839	Bianna Dress | White	PREORDER 14 WORKING DAYS A classic button-up shirt dress, but designed better and classier. Bianna Dress features a flattering pleated waist that adds graceful movement and structure to the silhouette, a piece that can transition effortlessly from work to weekend. The look is completed with a detachable vegan leather belt that cinches the waist for a defined shape. Fully-lined for comfort and free movement in any kind of occasions.	73% Polyester, 27% Nylon	ALL SIZE	http://dumaofficial.com/cdn/shop/files/BiannaDressWhite5.jpg?v=1753852572	f
8114152145135	Yarra Dress Navy	This lightweight mini dress is all ruffles and puffs with endless feminine	50% Cotton, 50% Polyester	All Size	http://dumaofficial.com/cdn/shop/files/YarraDressNavy-3.jpg?v=1695000721	f
8030772199663	Ross Tweed Blazer Blue	Crafted from luxurious tweed fabric, this blazer will make you stand out! Shaped for a double-breasted silhouette, it has a subtly cropped body with a boxy fit and a straight-cut raw hem. Throw it over your plain everyday basics to elevate your look in seconds!	60% Wool Blend, 35% Cotton, 5% Nylon	ALL SIZE	http://dumaofficial.com/cdn/shop/products/RossTweedBlazerBlue-3.jpg?v=1680152062	f
8145244520687	Morris Pants Beige	A staple pants that everyone needs in their capsule wardrobe. This pant is crafted from stretch premium Japanese polyester fabric and designed as a straight silhouette that taper down the legs and with ankle-length hems, finished with front patch pocket	100% Japanese made Premium Polyester	S, M, L	http://dumaofficial.com/cdn/shop/files/MorrisPantsBeige.jpg?v=1697702531	f
8959261671663	Quinn Top | Black	This sleeveless top features a sharp tailored collar and a clean front with a hidden side zipper. The standout detail is its open back with a soft, sculptural drape, adding a bold yet elegant touch. Easy to dress up or down, it pairs perfectly with tailored pants or a sleek skirt for a modern, refined look.	100% Japanese made Premium Polyester	ALL SIZE	http://dumaofficial.com/cdn/shop/files/QUINNTOPBLACK-1.jpg?v=1747639365	f
7946289217775	Chala Pants Red	Get cozy and festive this christmas with our Chala Pants! Knitted from soft cotton yarn into the perfect palazzo knit pants, featuring a high rise, wide leg and a relaxed fit. Pair it with our Cheri Shirt or Molly Cardigan for the ultimate holiday outfit for your festivities!	100% Cotton	1 &amp; 2	http://dumaofficial.com/cdn/shop/products/ChalaPantsRed_2.jpg?v=1670387106	f
8825021530351	MMEHUILLET FOR DUMA - Daon Top | Black	A must-have piece to add to your capsule wardrobe, Daon Top is the very definition of everyday wear. Knitted from soft yarns into a unique crochet texture, this piece blends both comfort and style into a loose, but flattering fit in neutral color palette. Adorn it with our clip-on rhinestone buttons for a more elevated look that can easily transition from day to night.	100% Polyester	1, 2	http://dumaofficial.com/cdn/shop/files/DaonTopBlack.jpg?v=1732724622	f
8101884526831	Nika Top Black	Knitted from soft cotton yarns, our Nika Top is an everyday staple perfect to throw on for different occasions throughout your week. With a boxy, cropped fit and front button fastenings, it is equally elegant, chic and comfortable for your everyday wear!	100% Cotton	All Size	http://dumaofficial.com/cdn/shop/files/Duma4731-edit1.jpg?v=1692614379	f
8773299405039	Galgot Blazer | Black	Focusing on classic tailoring this fall, our leather blazer is crafted with our best-selling leather fabric, and featuring a collarless neckline with most focus on the slimmer fitting, completed with single breasted front button fastening and back vents for comfort movements. Pair it with our Harmel Skirt | Black for the perfect put-together fall outfit.	100% Polyester	ALL SIZEMeasurement :	http://dumaofficial.com/cdn/shop/files/EDITERArtboard8.jpg?v=1729132990	f
7719008534767	Leya Pants Navy	Cullote pants knitted from soft and elastic viscose yarns featuring a mid-rise, cropped length, and straight fit, perfect for a casual, everyday look. Pair it with our best-selling Dali Top for a matching set!	SOFT VISCOSE	All Size	http://dumaofficial.com/cdn/shop/products/Artboard9_505991f6-cfdd-4a6f-8928-1bbcd271dfd9.png?v=1656463544	f
7739081359599	Logan Pants Grey	Long Palazzo pants with elastic waistband and the perfect monochrome pattern, with its perfectly relaxed fit and length that gives the slimmest and ellongated leg effect. Easy to style and comfortable to wear, this is definitely a perfect pair for your everyday!	97% Polyamide 3% Elastane	ALL SIZE	http://dumaofficial.com/cdn/shop/products/FUNDAMENTALSRESIZEDCATALOGArtboard91.jpg?v=1657771259	f
8498633998575	Vanya Stripe T-Shirt	Crafted from lyocell-blend that has a soft and fluid touch this long-sleeved T-shirt is cut for a streamlined slim fit, ideal for daily or layering purposes. A true wardrobe essential, it's offered in navy stripes that can easily complement most pieces in your wardrobe.	100% Lyocell Blend	S, M, L	http://dumaofficial.com/cdn/shop/files/VANYALONGSLEEVETSHIRT-3.jpg?v=1715740450	f
7950403731695	Rami Cardi Tosca	Knitted from soft cotton yarns into the perfect christmas color pointelle knit pattern! Snug and comfy, this cardigan will be the perfect company for your holiday festivities! Pair it with our priya shorts as a set for a homey look, or with our Rafa Pants for a more put together look this holiday season!	100% Cotton	1 &amp; 2	http://dumaofficial.com/cdn/shop/products/RAMITOSCA5.jpg?v=1670553553	f
8218772144367	Sully Maxi Dress Black	With this dress, we reimpreted classic tailoring into a more modern route. Tailored pants inspired maxi dress crafted from premium Japanese polyester, A-line loose silhouette, slit down the middle, and a sew-ed in mesh t-shirt on top. The perfect understated option for an end of year event.	100% Japanese made Premium Polyester	ALL SIZE	http://dumaofficial.com/cdn/shop/files/SullyMaxiDressBlack.jpg?v=1702537264	f
8196122083567	Laurent Vest Cardigan Black	An elevated two-in-one piece featuring an oversized cardigan and a sewn-in vest top inside to keep you warm and stylish during your travelling days. Pair it with our best selling Pralu pants for a comfy and minimalistic, stylish look.	Soft Viscose	ALL SIZE (FIT TO XL)	http://dumaofficial.com/cdn/shop/files/LaurentVestCardiBlack.jpg?v=1700778153	f
9000453538031	Eve T-shirt | Cedar	PREORDER 25 WORKING DAYS A classic everyday T-shirt, offered in cedar. Designed with a classic crew neckline and a flattering straight cut, this top is crafted from a silky-soft rayon blend with a touch of stretch for maximum comfort and versatility. The clean silhouette hits at the ideal length to pair with just about anything.	56,5% Rayon, 31,2% Polyamide, 12,3% Spandex	Small, Medium	http://dumaofficial.com/cdn/shop/files/EVET-SHIRTCEDAR2.jpg?v=1750852767	f
8253781967087	Lesley Jeans Sand	Denim trousers is a definite staple for your wardrobe, especially this pair as they're comfortable and fits like a glove. This pair is shaped for a flared silhouette with full-length legs and slits at cuffs that will make your legs looks super long and slim. They're crafted from a stretch cotton denim for lightness and comfort it won't feel like your wearing jeans at all!	100% Cotton	S, M, L	http://dumaofficial.com/cdn/shop/files/LesleyJeansSand.jpg?v=1706096384	f
8060379463919	Chantal Dress White	Knitted from pure cotton yarns into the perfect straight fit mini shirt dress. Featuring front pearl buttons closure, Hand stitches	100% Cotton	1 and 2	http://dumaofficial.com/cdn/shop/files/ChantalDressWhite-2.jpg?v=1685034367	f
8036433690863	Malha Puffy Shirt White	This shirt is a versatile staple, elevated with some of our signature design	100% Tencel	ALL SIZE	http://dumaofficial.com/cdn/shop/products/MalhaShirtWhite.jpg?v=1681097006	f
8896418152687	Riri Pants | Light Denim	These barrel-leg denim pants are designed for comfort and style, featuring a high-waisted fit and a slightly curved silhouette. The medium-wash denim gives them a timeless, classic look, while the unique panel stitching at the bottom adds a distinctive touch. The relaxed fit ensures ease of movement, making them perfect for both casual outings and stylish everyday wear.	100% Cotton	Small, Medium, Large, XL	http://dumaofficial.com/cdn/shop/files/RIRIPANTSLIGHTDENIM-2.jpg?v=1740439565	f
8792577900783	Mandez Pants | Denim Blue	The newest addition to our denim pants collection, Mandez Pants | Denim Blue is a pair of versatile straight pants that’s going to match any top you have. Made from stretchy medium-weight washed denim, this piece accentuates your legs in just the right places. Completed with a bit of washed effect that gives dimension and detail to this pants of the season.	70% cotton, 27% viscose, 3% elastane	Small, Medium, Large	http://dumaofficial.com/cdn/shop/files/ERINADENIMSHIRT-2_0b053d73-b4ea-4b0a-b6d9-079ff72332c0.jpg?v=1729137486	f
8081686429935	Azia Top Cream	Beautifully knitted vest made from 100% recycled polyester designed in a contoured fit completed with black scallop trimmings and fastened with horn buttons, creating a sophisticated look. Pair it with our Pralu Pants or Mare Skort to get an effortlessly chic summer look.	Recycled Polyester	All Size (Fit to M)	http://dumaofficial.com/cdn/shop/files/AziaTopCream2.png?v=1688954972	f
8030790746351	Lesley Jeans Denim	Denim trousers is a definite staple for your wardrobe, especially this pair as they're comfortable and fits like a glove. This pair is shaped for a flared silhouette with full-length legs and slits at cuffs that will make your legs looks super long and slim. They're crafted from a stretch cotton denim for lightness and comfort it won't feel like your wearing jeans at all!	100% Cotton	S, M, L, XL	http://dumaofficial.com/cdn/shop/products/LesleyJeansDenim-3.jpg?v=1680152157	f
8860251521263	Wang Top | Mustard	The very definition of edgy elegance — Wang Top features a cinched waist that accentuates your silhouette flatteringly. The design showcases a unique wavy placket, adding a touch of contemporary flair. Made from a structured fabric with slight sheen, it offers both sophistication and edge. Adorned with a row of unique handmade floral appliqués with snap buttons as the front opening, Wang Top is a gorgeous head-turner for that long-awaited special occasion.	100% Polyester	1, 2	http://dumaofficial.com/cdn/shop/files/WANGTOPMUSTARD-2.jpg?v=1736913980	f
8252043657455	Hua Dress Red	Inspired by Chinese floral petals, this simple stretch neoprene dress has a fitted body and an A-line skirt, with intricate floral petal	100% Polyester	S, M, L	http://dumaofficial.com/cdn/shop/files/HuaDressRed.jpg?v=1705996339	f
8114155389167	Gilia Jeans Denim Dark Blue	Inspired by the '70s, our Gilia Jeans is designed with a high-rise waist and wide bootcut hems. Finished with two front pockets and two back pockets, washed to the perfect light denim blue shade with fading at thighs to feel the vintage vibe. The perfect new pair of jeans that you definitely need to get your hands on!	Cotton Spadex	Small, Medium, Large	http://dumaofficial.com/cdn/shop/files/GILIA_JEANS_DENIM_DARK_BLUE-3.jpg?v=1748527509	f
8218779877615	Laurent Cardigan Vest Tosca	Our best selling Laurent vest cardigan in a limited edition color! An elevated two-in-one piece featuring an oversized cardigan and a sewn-in vest top inside to keep you warm and stylish during your travelling days. Pair it with our best selling Pralu pants for a comfy and minimalistic, stylish look.	Soft Viscose	ALL SIZE (FIT TO XL)	http://dumaofficial.com/cdn/shop/files/LaurentVestCardiTosca.jpg?v=1702537058	f
8307538493679	Garnet Maxi Skirt Navy	Our take in creating the perfect maxi skirt, cut from silky premium satin fabric and the perfect dark navy hue. It is shaped to hug the waist and hip perfectly, flows to a flared hem, and finished with an elasticated internal waistband.	100% POLYESTER	S, M, L	http://dumaofficial.com/cdn/shop/files/GarnetMaxiSkirtNavy.jpg?v=1710166046	f
8005294457071	Nadine Top Black	Crafted from soft cotton yarns, this lightweight knit top is accentuated with diagonal stitch line and scalloped edge	100% Cotton	All Size ( Fit To Medium )	http://dumaofficial.com/cdn/shop/products/NadineTopBlack-6.jpg?v=1680152729	f
7451870724335	Congratulations Card	Congratulate your special someone with this card ! Paper size : A6 Notes: Information:1. Kindly Please chat our customer service for additional notes2. If there is no custom text, the gift card will be sent in Blank card	\N	A6	http://dumaofficial.com/cdn/shop/products/Artboard4_81325608-de28-4639-8ba3-dc366363cbe6.jpg?v=1637311764	f
7946294001903	Cheri Shirt Red	Boxy cut shirt knitted from soft cotton yarns in the most perfect shades of christmas! The perfect mix of feminine and boyish, cozy and put together look. Comfortable to wear, easy to style. Pair it with our Chala Pants this holidays season fro the perfect cozy christmas outfit to attend your year end festivities.	100% COTTON	All Size	http://dumaofficial.com/cdn/shop/products/CheriShirtRed_4.jpg?v=1670555597	f
8825036570863	MMEHUILLET FOR DUMA - Blind Box Button	SHIPMENT: 26-27 December 2024 Indulge in the thrill of discovery with our Detachable Floral Button Blind Box! Each box contains 10 unique, randomly selected buttons, featuring a dazzling array of rhinestone floral designs in various colors. From soft pastels to bold hues, every button offers a chic, customizable accent for your wardrobe. Inner button’s size = up to 14 mm / 1.4 cm	\N	\N	http://dumaofficial.com/cdn/shop/files/Photo-ProductArtboard-40.png?v=1732770893	f
8218770833647	Peggy Peplum Top Black	Classically romantic style with a dose of vintage charm, this peplum top is cut from premium Japanese made polyester for its structure and tailored feel. It has a blazer collar, a row of gold heart buttons and a flattering peplum. Pair it with jeans for a timeless date night look, or switch to our Glacer mini skirt for your next holiday party!	100% Japanese made Premium Polyester	1, 2	http://dumaofficial.com/cdn/shop/files/PeggyPeplumTopBlack.jpg?v=1702537346	f
7471421260015	Peter Tencel Shirt	Button Up Shirt with rouned collar, pleated	TENCEL™ Modal	ALL SIZE	http://dumaofficial.com/cdn/shop/products/WhatsAppImage2021-12-07at13.44.10_1.jpg?v=1638927171	f
8005158142191	Sofia Top Brown	Designed from a premium stretch woven fabric, this open collar sleeveless top features oversized lapels with a deep-v-neck, bust darts and panels to highlight the silhouette and front snap button closure and hidden side pockets for a clean look with elevated comfort.	100% Japan made Polyester	1, 2	http://dumaofficial.com/cdn/shop/products/SofiaTopBrown-2.jpg?v=1677201261	f
8913633804527	Crimson Pants | Beige	Stay effortlessly stylish with these barrel-leg cropped pants, designed for both comfort and versatility. The relaxed silhouette features a flattering high rise and a unique elasticized waistband at the back for an easy, flexible fit. Perfect for casual days or dressing up with heels, these pants offer a modern, laid-back vibe to elevate any outfit.	Cotton Poly Blend	Small, Medium, Large	http://dumaofficial.com/cdn/shop/files/CrimsonPantsCream-6.jpg?v=1741926347	f
8742187466991	Mimosa Satin Skirt | Blue	The popular ankle-length satin skirt, redefined by us. Crafted from silky smooth satin fabric in the prettiest turquoise blue shade, Mimosa Satin Skirt | Blue flows down your silhouette elegantly. Prioritizing comfort and ease, we created this skirt with a side zipper opening and elasticated waistband. And as the final touch is a beautiful Iris flower to achieve that simple yet significant look.	100% Polyester	Small, Medium	http://dumaofficial.com/cdn/shop/files/MIMOSASATINSKIRTBLUE-5_c226f2ba-7532-4d7e-b897-a8938dd8d0bb.jpg?v=1724885530	f
8307532005615	Ruby Top White	Cut and sewn from our all time favorite premium Japanese polyester fabric, we put a tweak to a simple tanktop by giving a puffed peplum panels on the side. Playful yet still simple, perfect to throw on for simple events or casual day out with friends!	100% Japanese made Premium Polyester	1, 2	http://dumaofficial.com/cdn/shop/files/RubyTopWhite.jpg?v=1710166292	f
8082188796143	Pralu Pants Black | BACK IN STOCK	Our Pralu Pants is crafted for a flared fit that complements every body type! This pants surely does the trick of elongating your legs and creating the most flattering fit out of a women's legs, not to mention its super soft and stretchy fabric. Certainly a must have in everyone's wardrobe essential.	90% Polyester, 10% Elastane	S, M, L, XL	http://dumaofficial.com/cdn/shop/files/PRALUPANTSBLACK-2.jpg?v=1745989517	f
8060442575087	Becca Maxi Skirt White	A must have, wardrobe essential for the upcoming season. Denim skirt made of soft and stretchy denim that's left at a natural white color, shaped for a slimming and elongating fit and featuring back slit, belt loops, and hook and bar closure. Embrace the '90s denim-on-denim look by wearing it with the matching Rubie crop shirt.	97% Cotton, 3% Spandex	1 (XS-S), 2(M-L)	http://dumaofficial.com/cdn/shop/files/BeccaMaxiSkirtWhite.jpg?v=1685003204	f
8897219920111	Iggy Top | Olive	Elevate your everyday style with our Iggy Top! Crafted from soft and stretch viscose yarn with ribbed detailing, this top exudes a modern and effortless appeal. This tank design features an off-center placket with tonal buttons, and a flattering, form-hugging fit. Pair it with your favorite high-waisted jeans for a casual-chic look or layer it under a blazer for a polished finish—versatile and stylish, it's a must-have staple for any wardrobe.	Soft Viscose	ALL SIZE (Fit To L)	http://dumaofficial.com/cdn/shop/files/IGGYTOPOLIVE-6.jpg?v=1740458001	f
8667285913839	FIONA  | Regular Fit Crew Neck T-shirt in Olive	A classic everyday T-shirt, offered in olive green. Crafted from a special cotton blend that’s soft to the touch, this versatile crew neck top is cut for a straight cut with the perfect length to pair with just about anything.	100 % Cotton Blend	Small, Medium, Large	http://dumaofficial.com/cdn/shop/files/FionaOlive-2.jpg?v=1720506017	f
8196265967855	Vesper Pants Brown	Crafted from premium Japanese polyester fabric, we have take a quiter approach to the utility trend and made the perfect seasonless cargo pants for you. Shaped with wide legs, panel detailings, and enlarged signature cargo pockets on the either leg. Style them with the coordinating vest.	100% Japanese made Premium Polyester	1, 2	http://dumaofficial.com/cdn/shop/files/VesperPantsBrown.jpg?v=1700779739	f
8913104109807	Gome Shorts | Black Multi	Designed with a mid-waist and tailored fit, these classic checked pattern tweed shorts offer a chic silhouette that transitions seamlessly from day to night. With added fray	Poly Blend	1, 2	http://dumaofficial.com/cdn/shop/files/GomeShortsBlack.jpg?v=1741855095	f
8211495256303	Aubrey Denim Midi Skirt	We took the classic appeal of one of our best selling skirts and turn it into this voluminous flared midi skirt. Crafted from rigid cotton denim and shaped with cut panels to get the a more exaggerated flare, finished with contrast stitchings and front button fastenings.	100% Cotton	S, M, L	http://dumaofficial.com/cdn/shop/files/AubreyDenimMidiSkirt.jpg?v=1701935413	f
7571094995183	Dupone Pants | Sorbet Tone	High Waisted Knit Palazzo pants featuring a high rise, flared style and a relaxed fit. Knitted from soft cotton yarns with the perfect color combination and the perfect fitting silhouette. This pants is equally comfortable and fashionable, perfect for any occasion!	100% Cotton	S -M , M - L	http://dumaofficial.com/cdn/shop/products/Artboard93_1a854984-5681-4f4e-a981-fa4b9e35ce4d.png?v=1645669910	f
8913631740143	Crimson Pants | White	Stay effortlessly stylish with these barrel-leg cropped pants, designed for both comfort and versatility. The relaxed silhouette features a flattering high rise and a unique elasticized waistband at the back for an easy, flexible fit. Perfect for casual days or dressing up with heels, these pants offer a modern, laid-back vibe to elevate any outfit.	Cotton Poly Blend	Small, Medium, Large	http://dumaofficial.com/cdn/shop/files/CrimsonPantsWhite-3.jpg?v=1741926196	f
8665184633071	Lucca Linen Vest | White	Elevate your look this summer with our Lucca Linen Vest. Crafted from our pinstripe linen fabrication, this style forms a figure-hugging silhouette with a tailored finish. The sleeveless vest is defined by its deep U-shape neckline and princess lines for a more cinched figure. This natural white and black pinstripe top secures with front button closure and curved front hem. Pair it with the Ralf Linen Pants or Alba Linen Skirt for an easy vacation outfit.	100% Linen	Small, Medium, Large	http://dumaofficial.com/cdn/shop/files/LUCCALINENVESTWHITE-5.jpg?v=1720522323	f
8037925126383	Chai Blazer Shirt Navy	Tailored from smooth and lustrous satin print fabric in a double-breasted, slightly oversized silhouette. It has a face framing peak lapels with a structured tailoring front body design, and a relaxed shirt silhouette design on the back. Perfectly comfortable to wear yet still appropriate for formal occasions.	100% Polyester	ALL SIZE	http://dumaofficial.com/cdn/shop/products/ChaiNavy1.jpg?v=1681272956	f
8824609833199	MMEHUILLET FOR DUMA - Sona Outer | White Multi	Introducing Sona Outer, a multifunction outer/top with a relaxed and contemporary boxy fit. Its short sleeves make this outer an ideal piece for layering over both casual and dressy outfits, and the single button opening adds up on the unique	100% Polyester	1, 2	http://dumaofficial.com/cdn/shop/files/SonaOuterWhite-2.jpg?v=1732725404	f
7471338193135	Gale Skirt Navy	Knit Skirt with three ribbing styles that gets wider from the waist to the hem, which flatters one's figure perfectly! Knitted from soft cotton yarns, with comfortable elastic waistband and A-line silhouette. Pair it with our Marilou Top for the most sophisticated, elegant look this holiday season!	100% Cotton	ALL SIZE	http://dumaofficial.com/cdn/shop/products/WhatsAppImage2021-12-07at17.25.34_1.jpg?v=1638893503	f
8158401396975	Kano Set Light Blue	Our cropped cardigan and adjustable tank top set is a seasonless essential that can be worn as a set or separates. Lightweight knitwear pieces, with point collar and button front fastening cardigan, completed with an adjustable strap basic tanktop. Perfect for any look you're going for any time of day!	100% Cotton	1, 2	http://dumaofficial.com/cdn/shop/files/KanoSetLightBlue.jpg?v=1698311425	f
8252028420335	Rohe Tweed Outer Red	Meticulous craftmanship brings unparalleled elegance. Featuring an old-fashioned Chinese coin purse for a symbol of good fortune this CNY season. This jacket has a straight boxy silhouette to give it a youthful feel, and finished with perfect tailoring and covered buttons front closure. Model : 175 cm	100% Wool	ALL SIZE	http://dumaofficial.com/cdn/shop/files/RoheeTweedOuter.jpg?v=1706001671	f
9000475033839	Eve T-shirt | Black	PREORDER 25 WORKING DAYS A classic everyday T-shirt, offered in classic black. Designed with a classic crew neckline and a flattering straight cut, this top is crafted from a silky-soft rayon blend with a touch of stretch for maximum comfort and versatility. The clean silhouette hits at the ideal length to pair with just about anything.	56,5% Rayon, 31,2% Polyamide, 12,3% Spandex	Small, Medium	http://dumaofficial.com/cdn/shop/files/EVET-SHIRTBLACK1.jpg?v=1750785504	f
8824629395695	MMEHUILLET FOR DUMA - Baram Pants | Denim Blue	A pair of versatile pants to wear on repeat, Baram Pants was thoughtfully designed with a straight-leg silhouette that provides a timeless and flattering look. The soft and stretchy denim offers freedom of movement all day, everyday. Detailed with small front pockets that add functionality and a touch of uniqueness to the overall look. Pair it with any top in your wardrobe, or wear it as a set with our Sunsu Shirt.	70% cotton, 27% viscose, 3% elastane	Small, Medium, Large	http://dumaofficial.com/cdn/shop/files/BaramPantsDenimBlue.jpg?v=1732725272	f
8234756931823	Grego Leather Blazer Blue	The silhouette of this leather jacket is inspired by the classic pea coats. Tailored with a double-breasted closure, it's crafted from buttery faux leather and shaped with softly padded shoulders, notch lapels, and a full lining for easy layering. For a complete set, wear with our matching Glacer Skirt.	100% Polyester	All Size	http://dumaofficial.com/cdn/shop/files/LeatherBlazerBlue.jpg?v=1704530946	f
8304600350959	Estelle Cardigan Navy | BACK IN STOCK	Knitted from soft cotton yarns with sophisticated flower	100% Cotton	ALL SIZEMeasurement :	http://dumaofficial.com/cdn/shop/files/EstelleCardiganNavy.jpg?v=1710165623	f
9024418152687	Vento Short | Blue Multi	Vento short was designed with a beachy spirit in mind — featuring fun denim blue and cream stripes and a breathable crochet knit texture. Cut in a flattering boxy silhouette with a soft stretch waist, this piece is easy to wear from sunrise to sundown. Whether you’re lounging poolside or strolling by the coast, this piece slips effortlessly into your summer escape wardrobe. Pair it with our Iroco Top for a cute, coordinated look, or mix it with Cielo Shirt for a more laid-back vibe.	Recycled Polyester	1, 2	http://dumaofficial.com/cdn/shop/files/VentoShortBlueMulti1.jpg?v=1753852772	f
8667282800879	FIONA  | Regular Fit Crew Neck T-shirt in White	A classic everyday T-shirt, offered in classic white. Crafted from a special cotton blend that’s soft to the touch, this versatile crew neck top is cut for a straight cut with the perfect length to pair with just about anything.	100 % Cotton Blend	Small, Medium, Large	http://dumaofficial.com/cdn/shop/files/FIONATOPWHITE-5.jpg?v=1745991899	f
8818175770863	Ang T-Shirt | Black	Secure your transitional wardrobe with this staple long-sleeved mock neck top. Offered in a black tone, it’s crafted from soft lyocell blend and has a streamlined slim fit that’s ideal for layering.	76% Lyocell, 19% Wool, 5% Spandex	ALL SIZE (Fit to L)	http://dumaofficial.com/cdn/shop/files/AngT-ShirtBlack-1.png?v=1731576096	f
8145623580911	Harlow Pants Black	Crafted from premium Japanese polyester, this pants gives you two silhouettes - a wide legged and a jogger fit, depending on the adjustment of the hem button. Designed to sit mid waist, they are finished in classic black and elevated with belt loops, front pleats and centre folds for tailored style.	100% Japanese made Premium Polyester	1, 2	http://dumaofficial.com/cdn/shop/files/HarlowPantsBlack.jpg?v=1697775884	f
8060711141615	Ira Crop T-shirt White	Crafted from a sustainable premium Japanese polyester fabric that is luxuriously soft and cooling, this crop top is has the perfect fit with a straight cut, round neck and clean finishing. Pair it with the cargo pants for a cool and stylish look that provides all day comfort!	75% Polyester, 25% Cotton	1, 2	http://dumaofficial.com/cdn/shop/files/IraCropTshirtWhite-3.jpg?v=1685033743	f
7894084026607	Dorka Polo White	﻿This striped polo shirt is knitted from soft cotton yarns into a the perfectly boxy and oversized fit. A seasonless and casual piece that you'll find yourself getting too attatched to all year round. Pair it with your favorite denim pants for a casual day out!	100% COTTON	All Size	http://dumaofficial.com/cdn/shop/products/DorkaWhite_2.jpg?v=1666604151	f
8158407131375	Kano Set Sage	Our cropped cardigan and adjustable tank top set is a seasonless essential that can be worn as a set or separates. Lightweight knitwear pieces, with point collar and button front fastening cardigan, completed with an adjustable strap basic tanktop. Perfect for any look you're going for any time of day!	100% Cotton	1, 2	http://dumaofficial.com/cdn/shop/files/KanoSetSage.jpg?v=1698311525	f
8110077411567	Marion Top White Denim	Matching sets are key for the upcoming season, and the cropped length of this sleeveless top balances the coordinating mini skirt. It is crafted from washed dark blue denim and designed with halter neck and pointed collar, front button fastenings and banded waist. Wear it as a pair with our Khanyo skirt.	100% Cotton	All Size (Fit to M)	http://dumaofficial.com/cdn/shop/files/MarionTopWhite.jpg?v=1695111191	f
8196275405039	Vesper Pants Blue	Crafted from premium Japanese polyester fabric, we have take a quiter approach to the utility trend and made the perfect seasonless cargo pants for you. Shaped with wide legs, panel detailings, and enlarged signature cargo pockets on the either leg. Style them with the coordinating vest.	100% Japanese made Premium Polyester	1, 2	http://dumaofficial.com/cdn/shop/files/VesperPantsBlue.jpg?v=1700779670	f
7894089662703	Kano Set White	Our cropped cardigan and adjustable tank top set is a seasonless essential that can be worn as a set or separates. Lightweight knitwear pieces, with point collar and button front fastening cardigan, completed with an adjustable strap basic tanktop. Perfect for any look you're going for any time of day!	100% COTTON	ALL SIZE ( FIT TO MEDIUM )	http://dumaofficial.com/cdn/shop/products/KanoWhite_e3246a5d-b331-47b8-80a7-c4f56c574615.jpg?v=1666604537	f
8913520754927	Chena Cardigan | Black	This elegant black knit cardigan features a timeless round neckline, chic button	Nylon Blend	ALL SIZEMeasurement :	http://dumaofficial.com/cdn/shop/files/ChenaCardiganBlack-2.jpg?v=1741925175	f
8947908444399	Pufu Blouse | Blue	This elegant soft Tencel top is a timeless piece that effortlessly blends femininity and sophistication. Featuring delicately pleated flutter sleeves, it adds a touch of volume and grace to the silhouette. The V-neckline with a subtle keyhole cutout and loop button closure creates a refined yet modern detail. Designed in a lightweight, breathable fabric, this top is perfect for both casual and polished looks, making it an essential addition to any wardrobe.	100% Tencel	ALL SIZE	http://dumaofficial.com/cdn/shop/files/PUFUBLOUSEBLUE-5.jpg?v=1745989342	f
8005163450607	Martis Flared Pants | Black	Cut from premium stretch woven fabric in a high-rise, flared silhouette, these floor-length pants are fitted at the hips and thigh and flared at hem, creating the perfect elongated legs. This pants will be an essential piece in your wardrobe as they're comfortable but still look put together.	100% Japanese made Premium Polyester	Small, Medium, Large	http://dumaofficial.com/cdn/shop/files/MARTISPANTSBLACK-4.jpg?v=1745991307	f
8947907100911	Pufu Blouse | Pink	This elegant soft Tencel top is a timeless piece that effortlessly blends femininity and sophistication. Featuring delicately pleated flutter sleeves, it adds a touch of volume and grace to the silhouette. The V-neckline with a subtle keyhole cutout and loop button closure creates a refined yet modern detail. Designed in a lightweight, breathable fabric, this top is perfect for both casual and polished looks, making it an essential addition to any wardrobe.	100% Tencel	ALL SIZE	http://dumaofficial.com/cdn/shop/files/PUFUBLOUSEPINK-3.jpg?v=1745989433	f
8307526140143	Camille Dress Yellow	From our Rosette Collection, this mini dress is shaped for a contoured fit, enhanced by the gathered neckline. We sculpted 3D flower petals on the dress to add a special touch to this simple mini dress.	100% Japanese made Premium Polyester	1, 2	http://dumaofficial.com/cdn/shop/files/CamilleDressYellow.jpg?v=1710165594	f
7823901360367	Gigi Denim Top	Feminine and chic cropped shirt in the perfect denim shade and boxy fit, finished with an extra touch of shoulder pads that gives a slight masculinity style. Perfect for dailywear, brunches with the ladies, or to more formal dinners. Pair it with our Haylee Skort to build a clean and polished outfit in seconds!	70% Rayon, 30% Polyester	ALL SIZE	http://dumaofficial.com/cdn/shop/products/gigi9.jpg?v=1662687449	f
8959278416111	Carlo Top | Dark Grey	This sleeveless top features a structured, tailored silhouette with a sharp collar and clean lines. The front opens with a concealed zipper to maintain a minimalist, polished look. Crafted in a textured knit, it subtly hugs the body without clinging, ending in a neat hemline. Versatile and understated, it pairs effortlessly with wide-leg trousers, or our A-line skirt for a sophisticated ensemble.	100% COTTON	1, 2	http://dumaofficial.com/cdn/shop/files/CARLOTOPDARKGREY-1.jpg?v=1747640229	f
8196307550447	Faye Knit Outer Navy	Made from a loosely knitted rib texture using soft rayon yarns, this maxi cardigan coat has a fluid silhouette with notched collar and an open front. Wear it with the matching dress to elevate your lounge/travel wear.	92% Rayon, 8% Nylon	ALL SIZE (FIT TO L)	http://dumaofficial.com/cdn/shop/files/FayeOuterNavy.jpg?v=1700777578	f
7975352533231	Suri Top Green	Satin Floral Flowy Top with A-line body silhouette, Adjustable puffed sleeves and covered buttons detailing. The perfect daily top that can easily be dressed up or down. Elevate your simple look by pairing it with our Yuma Skirt to attend your upcoming cny festivities!	100% Polyester	ALL SIZE	http://dumaofficial.com/cdn/shop/products/SuriTopGreen.jpg?v=1673496713	f
8145477468399	Yeta Cardigan Beige	Tight texture knit made from soft cotton yarns, this double breasted cardigan has deep V-neck, contoured silhouette that envelops the body and balanced by relaxed sleeves. Doubles as a top, this piece is perfect for last minute outfit plannings, day to night looks, and keeping you as sophisticate as ever.	100% Cotton	1, 2	http://dumaofficial.com/cdn/shop/files/YetaCardiganBeige.jpg?v=1697785650	f
8252047950063	Galena Cardigan Maroon	This V-neck cardigan is knitted from customer's all time favorite soft viscose yarns. Designed for a contoured fit, it has neat ribbed trims and fasted with a row of horn buttons for a sleek finish. It's most definitely a wardrobe essential that will stay with you for a very long time. Model : 175 cm	Soft Viscose	ALL SIZE	http://dumaofficial.com/cdn/shop/files/GalenaCardiganMaroon.jpg?v=1705990800	f
8196294607087	Faye Knit Outer White	Made from a loosely knitted rib texture using soft rayon yarns, this maxi cardigan coat has a fluid silhouette with notched collar and an open front. Wear it with the matching dress to elevate your lounge/travel wear.	92% Rayon, 8% Nylon	ALL SIZE (FIT TO L)	http://dumaofficial.com/cdn/shop/files/FayeOuterWhite.jpg?v=1700777650	f
8006371049711	Eli Top Dark Grey	escription Knitted from soft cotton yarns, this utterly comfy knit top will easily become a staple in every women's wardrobe. As a loungewear or for going out, this top has a very versatile style that you can pair it with any bottom you can possibly think of.	100% Cotton	ALL SIZE	http://dumaofficial.com/cdn/shop/products/EliTopGrey-3.jpg?v=1677201588	f
7954349326575	Bea Pleats Cardigan Olive	Showcasing our newest pleating technique, our Bea Pleats Cardigan is minimally tailored to a loose yet slimming-fit silhouette, completed with flattering V-neckline and side pockets. Easy to throw on to embolden your everyday outfit, makes you look put together in seconds!	100% Polyester	ALL SIZE	http://dumaofficial.com/cdn/shop/products/BEAOLIVE3.jpg?v=1670821189	f
8083253723375	Galena Cardigan Navy	This V-neck cardigan is knitted from customer's all time favorite soft viscose yarns. Designed for a contoured fit, it has neat ribbed trims and fasted with a row of horn buttons for a sleek finish. It's most definitely a wardrobe essential that will stay with you for a very long time.	Soft Viscose	All Size	http://dumaofficial.com/cdn/shop/files/GalenaCardiganArtboard7.jpg?v=1689081563	f
8860169437423	Fuqi Top | Sage	A fusion of modern design and traditional influences. Designed with a refined Chinese collar, the halter neckline adds a distinctive touch with its high, mandarin-inspired style. The top’s silhouette gracefully transitions into a fit-and-flare design, contouring the bodice for a flattering fit. Completed with a back zipper opening for an easy and comfortable wear.	100% Polyester	1, 2	http://dumaofficial.com/cdn/shop/files/FUQITOPSAGE-1.jpg?v=1736841696	f
8792602018031	Jennie Tanktop | Taupe	An essential for your daily wardrobe, especially those warmer days. Offered in a warm brown tone, it’s crafted from soft lyocell blend and has a streamlined slim fit with endless styling opportunities - wear it alone or layered under shirts and blazers.	76% Lyocell, 19% Wool, 5% Spandex	ALL SIZE (Fit to L)	http://dumaofficial.com/cdn/shop/files/JENNIETANKTOPTAUPE-3.jpg?v=1729052579	f
7696638836975	Toja Pants Black	Basic pair of pants that you never know you needed! Knitted from soft cotton yarns into the perfect long black pants silhouette, completed with drawstring	100% Cotton	ALL SIZE	http://dumaofficial.com/cdn/shop/products/toja6.jpg?v=1654826677	f
8751873523951	Blanc Pants | Denim White	PREORDER 5 WORKING DAYS The perfect pair of straight pants, constructed from a dense white denim to achieve that structured but casual look. A cut that’s going to elongate your legs, combined with the refined denim material, Blanc Pants | Denim White is a versatile staple that’s easy to style and suitable for any season.	70% Cotton, 30% Polyester	Small, Medium, Large	http://dumaofficial.com/cdn/shop/files/BLANCWHITEDENIMPANTS.jpg?v=1725937999	f
8005165023471	Callan Shirt Dress Bone	Open collar shirt dress featuring an oversized fit, elongated profile, front patch pockets, concealed front button closure and a fluid silhouette for a relaxed take on tailoring. Wear it as it is for a shirt dress look, or layer over your basic go to outfit for an effortless business casual look.	100% Japan made Premium Polyester	All Size	http://dumaofficial.com/cdn/shop/products/CallanShirtDressBone.jpg?v=1677142239	f
7571085983983	Bagnu Skirt Light Blue	Pleated Rayon Denim Skirt with a classic and modern silhouette. The pleats dart will make one’s body line looks slim, and the restrained pleats give a luxurious feeling. Completed with side zipper fastening, knee-covering length, and A-line silhouette. This skirt is definitely easy to style with any top and creates an elegant look effortlessly in no time!	70% Rayon, 30% Polyester	S-M , M-L	http://dumaofficial.com/cdn/shop/products/Artboard52_c28f70be-295c-4edb-ab84-6cb2024d9f88.png?v=1645669349	f
7947446321391	Elfie Sparkly Shorts Maroon	Crafted from soft cotton and lurex blend, shorts are pull on with elastic band. Definitely the perfect choice of outfit for your homey get-together this upcoming holidays season.	95% chenille 5% polyethylene	All Size	http://dumaofficial.com/cdn/shop/products/MalachiSweaterRed_5.jpg?v=1670551693	f
7946279420143	Molly Cardigan Grey	Get cozy and chic all year round with our Molly Cardigan! Knitted from soft cotton materinal into the most elegant fit and beautifully knitted chenille knit pattern in the perfect Christmas shades, this piece is definitely going to be a crowd pleaser anywhere you go! Pair it with our Chala Pants to get an effortless everyday look in seconds!	100% Cotton	All Size	http://dumaofficial.com/cdn/shop/products/MollyCardiganGrey_2.jpg?v=1670388463	f
8742181306607	Mimosa Satin Skirt | Black	The popular ankle-length satin skirt, redefined by us. Crafted from silky smooth satin fabric, Mimosa Satin Skirt | Black flows down your silhouette elegantly. Prioritizing comfort and ease, we created this skirt with a side zipper opening and elasticated waistband. And as the final touch is a beautiful Peony flower to achieve that simple yet significant look.	100% Polyester	Small, Medium	http://dumaofficial.com/cdn/shop/files/MIMOSASATINSKIRTBLACK-4.jpg?v=1724754267	f
8211438960879	Cleo Metallic Cardigan Gold | BACK IN STOCK	Specially knitted with metallic threads to welcome you to the festive season, this cardigan is shaped for a relaxed fit, designed with deep V neckline, ribbed waistband, and completed with sparkly buttons front closure. Can easily pairs with any bottom for your upcoming festivities!	60% Cotton, 40% Polyester	ALL SIZE	http://dumaofficial.com/cdn/shop/files/CleoMetallicCardiGold.jpg?v=1701935589	f
8986676429039	Getta Cardigan | Olive	SHIPMENT 14 JULY 2025 Wrap yourself in effortless elegance with this soft viscose cardigan, designed for both comfort and style. Featuring a flattering V-neckline and a waist that accentuates your silhouette, this piece brings a refined touch to your day-to-day outfits. Added with a row of vegan leather buttons, for a touch of subtle quirk to this timeless knit.	Soft Viscose	ALL SIZE	http://dumaofficial.com/cdn/shop/files/GETTACARDIGANOLIVE2.jpg?v=1750835921	f
8145607033071	Cannolo Skirt Black	This classic midi skirt is made from soft viscose yarns that will last you a lifetime in your capsule wardrobe. It’s offered in timeless black shade and designed with a comfortable thick elasticated waist that flares out to a softly draped A-line hem. Easy to style with any top and definitely elevates any look while staying comfortable!	Soft Viscose	1, 2	http://dumaofficial.com/cdn/shop/files/CannoloSkirtBlack.jpg?v=1697775906	f
7696634478831	Ganuli Shirt White	Basic button down shirt with v-neckline, flat collar and batwing sleeves. The soft fabric makes this shirt the perfect office attire for your work from office days, keeping you comfy all day while still looking presentable! Pair it with our Toja pants to look effortlessly put together while staying comfortable.	70% Rayon, 30% Polyester	ALL SIZE ( FIT TO M )	http://dumaofficial.com/cdn/shop/products/ganuli4.jpg?v=1654826435	f
7637780922607	Kamala Skirt Blue	Crafted from soft Tencel fabric, our Kamala Skirt is cut to sit at the slimmest part of your frame, with elastics that makes it comfortable to wear, and flals to a flared midi hemline. Style it with our Acra Top to create an effortless look in seconds!	TENCEL™	ALL SIZE	http://dumaofficial.com/cdn/shop/products/WhatsAppImage2022-08-23at13.57.31_98e58c43-096e-4b92-a228-836f1650d1a7.jpg?v=1661239097	f
7823875801327	Pareo Leather Jacket Brown	Sleek and Luxuriously timeless, our leather jacket is cast in a versatile brown shade and cut to a cropped boxy profile with a pointed collar and three button fastenings through the front and curved hemline. Easy to style and highly versatile, you can easily pull off both informal and formal events!	Vegan Leather 100% Polyester	All Size	http://dumaofficial.com/cdn/shop/products/pareo2.jpg?v=1662687871	f
8082186469615	Rhoda Top White	This shirt is our contemporary take of a wardrobe essential. Crafted from soft cotton twill fabric, it's shaped for a relaxed fit and has a rounded collar, front panel detail, gathering around the shoulder and back yoke, and slightly puffed sleeves and fastened with gold buttons. Pairs easily with any bottom you have in your wardrobe!	100% Cotton	All Size	http://dumaofficial.com/cdn/shop/files/RhodaTopWhite3.png?v=1688954543	f
9024414122223	Agea Top | Pink	PREORDER 10 WORKING DAYS Classic but memorable. An A-line cut top in smooth and luxurious fabric that enhances its minimalist appeal. Designed with a clean round neckline and halter cut, Agea is a versatile top that can be worn in any kind of occasions – be it a casual brunch with the girls or a long-awaited dinner date. Pair this flowy piece with our best-selling Tan Pants for a chic, matching set look.	100% Polyester	1, 2	http://dumaofficial.com/cdn/shop/files/AgeaTopPink1.jpg?v=1753698181	f
7804254978287	Julian Dress Navy	Knitted from very soft and elastic viscose yarns, this relaxed fit shirt dress features a straight fit and front pocket flaps for a laid-back, casual silhouette. The sleeve cuff and buttons	SOFT VISCOSE	ALL SIZE	http://dumaofficial.com/cdn/shop/products/WhatsAppImage2022-08-23at13.57.53_bb327a67-a77a-451a-bb11-10c564b5fe3f.jpg?v=1661239446	f
8791912448239	Sonnet Jacket | Brown	Jumping into this fall’s suede trend, but with our own twist. This jacket is tailored into a neat slim-fit that still gives space for comfort and movement. Detailed with scooped neckline that exudes elegance and stylish front buckle opening. Sonnet Jacket | Brown is fully-lined and carefully tailored to achieve a structured, luxurious look.	100% Polyester	1, 2Measurement :	http://dumaofficial.com/cdn/shop/files/SONNETJACKETBROWN-5.jpg?v=1729052957	f
8030781243631	Buckham Blazer White	There's nothing like a good pair of classic blazer that will stay in your wardrobe staple for a very long time. This one in classic White is shaped for a contouring fit with lightly padded shoulders and darts at the front and back to define the waist. This double-breasted blazer is tailored with high peak lapels. and a pair of front flap pockets. Perfect to throw over any outfit to make you look effortlessly put together!	100% Polyester	S, M, L	http://dumaofficial.com/cdn/shop/products/BuckhamBlazerWhite.jpg?v=1680145819	f
8196115693807	Laurent Vest Cardigan Grey	An elevated two-in-one piece featuring an oversized cardigan and a sewn-in vest top inside to keep you warm and stylish during your travelling days. Pair it with our best selling Pralu pants for a comfy and minimalistic, stylish look.	Soft Viscose	ALL SIZE (FIT TO XL)	http://dumaofficial.com/cdn/shop/files/LaurentVestCardiGrey.jpg?v=1700778307	f
8304619421935	Aster Dress White	Knitted from soft and elastic cotton fabric into an intricate pointelle pattern detail in classic white, this dress is shaped to a contoured fit that flows down to a slightly flared hem. Perfect for everyday, or even some special occasions!	100% RANY	ALL SIZEMeasurement :	http://dumaofficial.com/cdn/shop/files/AsterDressWhite-2.jpg?v=1710170359	f
8110077346031	Vanka Top Black	Carefully knitted with the classic tailoring priciple to achieve the silhouette of this waistcoat. With the perfect halter neck design and beautifully contoured waist, completed with front button fastenings and welt pocket flap designs. A classic piece that will complement your body really well!	100% Cotton	1, 2	http://dumaofficial.com/cdn/shop/files/VankaTopBlack.jpg?v=1693879875	f
8198585417967	Caba Blazer Black	Our Caba Blazer is a special tailoring piece that features a collarless neckline, wide padded shoulders, and a single-breasted close. Offered in the perfect deep black shade that's precisely color-matched to the coordinating Harlow Pants.	100% Japan made Premium Polyester	ALL SIZE	http://dumaofficial.com/cdn/shop/files/WhatsAppImage2024-03-30at11.40.11.jpg?v=1711773828	f
8897163395311	Acma Shirt Top | Dark Brown	This knit top exudes elegance with its soft drape and smooth texture, offering both comfort and sophistication. Featuring a notched collar and button-down front, it blends classic tailoring with a relaxed, modern feel. The half sleeves provide a balanced look, making it suitable for both warm and transitional weather. The subtly fitted silhouette enhances the figure while maintaining ease of movement, and the split hem detail at the front adds a contemporary touch. Easily style this top with tailored trousers for a polished look or paired with denim for effortless chic.	Rayon Blend	1, 2	http://dumaofficial.com/cdn/shop/files/ACMASHIRTTOPDARKBROWN-6.jpg?v=1740458288	f
8913121313007	Aluba Top | Navy	This classic navy top is effortlessly stylish and comfortable. It features a relaxed, flowy silhouette with a playful peplum detail for a flattering shape. The short puff sleeves add a touch of femininity, while the soft fabric makes it perfect for all-day wear. A versatile piece that pairs well with both casual and dressy outfits! Pair it with our Protea Skirt | Navy for an easy elegant look!	100% Nylon	ALL SIZEMeasurement :	http://dumaofficial.com/cdn/shop/files/AlubaTopNavy.jpg?v=1741855257	f
8773349146863	Petto Vest | Black	Inspired by classic tailoring, our Petto Vest | Black is designed with a double-breasted, slightly cropped silhouette, made sleeveless for a more relaxed fit. Easy to throw on and pair with your favorite pants this fall season!	100% Cotton	1, 2	http://dumaofficial.com/cdn/shop/files/FDA057A1-844C-436A-9837-C2294DEE58AB.jpg?v=1727750090	f
8625233592559	MICOLE | Slim Fit Crew Neck in Grey	A wardrobe staple offered in cool grey shade, it’s crafted from soft and stretch lyocell and has a streamlined slim fit that's ideal for daily or for layering purposes.	100 % Lyocell Blend	Small, Medium	http://dumaofficial.com/cdn/shop/files/LEN-DUMA-6717-edit.jpg?v=1718842286	f
8005292622063	Chantal Dress Black	Knitted from pure cotton yarns into the perfect straight fit mini shirt dress. Featuring front pearl buttons closure, Hand stitches	100% Cotton	1 and 2	http://dumaofficial.com/cdn/shop/products/ChantalDress-2.jpg?v=1677199937	f
8843362238703	Sorrel Pants | Maroon	Elevate your look with these effortlessly chic high-waisted satin pants. Designed with a bias cut for a beautifully fluid drape, they feature an easy wide-leg silhouette that moves gracefully with every step. The slip-on style and elasticized waistband ensure a comfortable, flattering fit, making these pants perfect for both casual and dressy occasions. Pair them with your favorite top for a polished yet relaxed vibe.	100% Polyester	Small, Medium, Large	http://dumaofficial.com/cdn/shop/files/SORRELPANTSMAROON-2.jpg?v=1734484650	f
8860267086063	Luna Cardigan Top | Black	Combining comfort and charm, we gave this soft, buttery viscose cardigan our own special touch. Adorned with delicate floral appliqués with snap buttons that add its feminine appeal, and completed with slightly volumized sleeves that give a flattering contrast to its cinched waist. Luna Cardigan Top is both pretty and easy to wear all-day long to your red bao hunting sessions (or any event, really).	Soft Viscose	ALL SIZE	http://dumaofficial.com/cdn/shop/files/LUNACARDIGANTOPBLACK-2.jpg?v=1736900191	f
8665208684783	Ralf Linen Pants | White	A versatile addition to your summer pants edit, the Ralf Linen Pants is a relaxed take on traditional suiting. The delicate black and natural white pinstripe colourway features a high-rise silhouette with straight legs. The classic design features belt loops and front button closures. A perfect addition to your summer days, pair it with the Lucca Linen Vest for effortless styling.	100% Linen	Small, Medium, Large	http://dumaofficial.com/cdn/shop/files/RALFLINENPANTSWHITE-2.jpg?v=1720522466	f
7455634784495	Arlet Top Blue	Knit top made from a slub-melange, ribbed cotton knit that is feminine and attractive. With its long, flared out sleeves that covers the palm of our hand, its V-neckline cut that accentuate one's collarbone and its cropped, straight fit, this top screams elegance and comfort in the most perfect way. Our Arlet Top can be styled in so many different ways; as a top or as a cardigan! Pair it with our Jola Pants for a casual look, or our Paloma Dress for a more sophisticated look.	100% Cotton	All Size	http://dumaofficial.com/cdn/shop/products/Artboard71.png?v=1637732182	f
8667288600815	BERT  | Regular MEN Fit Crew Neck t-shirt in Black	A light everyday T-shirt, offered in classic black. Crafted from a special cotton blend that’s soft to the touch, it has a classic shape that sits neatly with room for movement through the chest and arms.	100 % Cotton Blend	Small, Medium, Large	http://dumaofficial.com/cdn/shop/files/BertBlack-Front.jpg?v=1720576004	f
8060419571951	Nello Unisex Tshirt White	Crafted from a soft cotton in an off-white hue, this essential T-shirt is cut for an oversized fit with a dropped shoulder for a relaxed silhouette. The minimal stitching adds a timeless finish, perfect for your capsule wardrobe.	75% Polyester, 25% Cotton	ALL SIZE (FIT TO XL)	http://dumaofficial.com/cdn/shop/files/NelloTshirtWhite.jpg?v=1685003332	f
8106582376687	Peppa Cardigan Black	Knitted from soft cotton yarns, our Peppa Cardigan is made from our crowd favorite cardigan fitting with beautiful wavy patterns and stripe hem	100% Cotton	All Size	http://dumaofficial.com/cdn/shop/files/Duma4662-1-edit1.jpg?v=1693382740	f
8082175787247	Tropez Dress Tosca	A modern slip dress with flattering halter neckline that embodies ease and elegance with a volumious a-line drape all in a luminous ombré sliky satin blend. This maxi dress will make an elegant addition to your summer wardrobe.	100% polyester	1, 2	http://dumaofficial.com/cdn/shop/files/TropezDressTosca1.png?v=1688920555	f
8667287453935	BERT  | Regular MEN Fit Crew Neck t-shirt in White	A light everyday T-shirt, offered in classic white. Crafted from a special cotton blend that’s soft to the touch, it has a classic shape that sits neatly with room for movement through the chest and arms.	100 % Cotton Blend	Small, Medium, Large	http://dumaofficial.com/cdn/shop/files/BertWhite-Front.jpg?v=1720576014	f
7894087794927	Dianne Cardigan Black	Soft and structured, this cardigan has a relaxed silhouette and casual striped pattern throughout. It is finished with covered button fastenings and the perfect cropped length. A very special piece perfect for versatile styling and easy layering.	100% COTTON	All Size	http://dumaofficial.com/cdn/shop/products/AnneBlack_2.jpg?v=1666604068	f
8082187518191	Ruston Dress Black	This straight cut mini dress-slash-top is made from our premium japanese stretch polyester. It has side tweed button	100% Japan made Polyester	1 &amp; 2	http://dumaofficial.com/cdn/shop/files/RustonDressBlack2.png?v=1688954247	f
7833922961647	Piaca Pants Blue Multi	High Waisted Knit Palazzo pants featuring a high rise, flared style and a relaxed fit. This pants is eqully comfortable and fashionable, perfect for any occasion! Pair it with our Sonya Tank Top to create an effortlessly chic outfit in less than 5 minutes.	100% Cotton	SMALL, MEDIUM	http://dumaofficial.com/cdn/shop/products/pianapants3.jpg?v=1663292405	f
9024430080239	Greno Cardigan Top  | Blue	Our Greno Cardigan Top is a seasonless essential that every wardrobe need. Lightweight knitwear pieces, with point collar and button front fastening cardigan. Perfect for any look you're going for any time of day!	100% COTTON	1, 2	http://dumaofficial.com/cdn/shop/files/GrenoTopBlue2.jpg?v=1753852806	f
8986642317551	Eloise Top | Black	A sleeveless crochet top featuring a boxy silhouette and rounded neckline. Detailed with front buttons and contrast hand-stitched detail for a refined, artisanal touch. This piece brings texture and polish—perfect for pairing with denim for a casual statement or styled with the matching skirt for a coordinated set.	Recycled Polyester	1, 2	http://dumaofficial.com/cdn/shop/files/ELOISETOPBLACK1.jpg?v=1750852301	f
8269648298223	Amore Knit Cardigan Pink	Inspired by this season of love, this cardigan is knitted from soft cotton yarns, and with a fuzzy texture. this cardigan is shaped for a relaxed fit, designed with V neckline and completed with gold heart button front closure.	100% Cotton	ALL SIZE	http://dumaofficial.com/cdn/shop/files/CardiganPinkKancingHati.jpg?v=1707104490	f
8196084859119	Orson Tee Grey	This super soft and buttery long sleeve tee is your perfect everyday or travel wear. Lightweight and breathable, especially designed to fit close to your body without being constrictive or overly warm, this long sleeve tee is works perfectly on its own or as a layering piece.	90% Polyester, 10% Elastane	S, M, L	http://dumaofficial.com/cdn/shop/files/OrsonTeeGrey.jpg?v=1700779040	f
8307522339055	Peony Top Black	Inspired by the blossoming of flowers, this knit top is made with structured flounce hem detail that gives off a playful elegance. Knitted from soft cotton yarns in classic black, it is shaped into a contoured fit body and blooming hem.	100% Cotton	ALL SIZE	http://dumaofficial.com/cdn/shop/files/PeonyTopBlack-7.jpg?v=1710230001	f
8664908923119	Agatha Shorts | Denim Blue	Upgrade your summer shorts edit with the Agatha Shorts | Denim Blue. Crafted from our soft denim fabric this shorts has a relazed A-line silhouette, front pocket	100% Polyester	Small, Medium, Large	http://dumaofficial.com/cdn/shop/files/AGATHADENIMSHORTS-1.jpg?v=1720522004	f
9000424341743	Anolo Jacket | White	Add a modern twist to a classic staple with this utilitarian cotton twill jacket, that features a sleek zipper opening and functional pockets. The structured material is balanced with its relaxed cut and elasticated bottom that gives it a stylish, slightly puffy silhouette. An ideal piece for your long-awaited traveling plan – be it for that Insta-worthy airport outfit, or to tackle a cold, windy weather.	100% Cotton	ALL SIZE	http://dumaofficial.com/cdn/shop/files/ANOLOJACKETWHITE2.jpg?v=1750851776	f
8665129943279	Thoma Vest Top | Medium Stripe	Carefully knitted with the classic tailoring principle to achieve the silhouette of this waistcoat. Stripe knit pattern that is perfect for the summertime, complemented with the perfect halter neck design and beautifully contoured waist, completed with front button fastenings and welt pocket flap designs. A classic piece that will complement your body really well!	Cotton Poly Blend	1, 2	http://dumaofficial.com/cdn/shop/files/THOMAVESTTOP_BIGSTRIPE_-3.jpg?v=1720522510	f
8860229992687	Lim Top | Sage	A clean-cut top with A-line silhouette that features an elegant combination of modernity and tradition. This piece is designed with puffed cap sleeves that add a touch of flattering contrast to its high collar. The standout feature is a pair of artisanal mandarin buttons — crafted in an intricate design, adding a decorative and functional detail. Made from high-quality structured satin, Lim Top offers a luxurious feel and a slight sheen for that special occasion.	100% Polyester	ALL SIZE	http://dumaofficial.com/cdn/shop/files/LIMTOPSAGE-1.jpg?v=1736841829	f
7113830465714	Grata Pants Black	Through the handmade knitting process involved, each piece undergoes a natural twist of yarns that are uniquely different. Making an exclusive "twist" in every piece, specially for you. High-waisted flared pants made from a slub-melange cotton knit. With the additional slit detailings, and the flared leg silhouette, this pants will undoubtedly make your legs look longer and slender. Pair it with our Parson Top, you can easily create an effortless chic look in seconds!	100% Cotton	ALL SIZE ( Fit To Medium )	http://dumaofficial.com/cdn/shop/products/WhatsAppImage2021-10-29at21.50.43_2.jpg?v=1635696727	f
8901383880943	Gilia Jeans | Denim White	Inspired by the '70s, our Gilia Jeans is designed with a high-rise waist and wide bootcut hems. Finished with two front pockets and two back pockets, this pair comes in a crisp white wash for a fresh, timeless look. The perfect new pair of jeans that you definitely need to get your hands on!	Cotton Spandex	Small, Medium	http://dumaofficial.com/cdn/shop/files/GILIAJEANSDENIMWHITE-3.jpg?v=1740546560	f
9024394625263	Cielo Shirt | White	Relaxed yet refined, this loose boxy shirt is a modern staple with timeless appeal. Designed with a clean stand collar and wide raglan sleeves, it offers a softly structured silhouette that drapes effortlessly on the body. The airy fit provides ease of movement, while the minimal detailing keeps the look contemporary.	100% Tencel	1, 2	http://dumaofficial.com/cdn/shop/files/CieloShortWhite1.jpg?v=1753694648	f
8145302880495	Yeta Cardigan Black	Tight texture knit made from soft cotton yarns, this double breasted cardigan has deep V-neck, contoured silhouette that envelops the body and balanced by relaxed sleeves. Doubles as a top, this piece is perfect for last minute outfit plannings, day to night looks, and keeping you as sophisticate as ever.	100% Cotton	1, 2	http://dumaofficial.com/cdn/shop/files/YetaCardiganBlack-2.jpg?v=1697702576	f
8329480503535	Natia Skirt Pink	An elegant addition to the collection, our Natia Midi Skirt is designed with box pleats that sinches the waist perfectly and falls to a fuller, volumous skirt. Our special brocade fabrication adds an extra tecture to this structured style, midi length and hidden zipper help polished off this silhouette. Pair it with our matching Florence top for the perfect look!	60% Polyester, 40% Cotton	1, 2	http://dumaofficial.com/cdn/shop/files/NatiaSkirtPink.jpg?v=1711027270	f
8843368300783	Marda Dress | Grey	Chic and versatile, this mini shirt dress is a wardrobe essential. Featuring a button-down front with covered buttons for a sleek look, it’s designed with a box-pleated skirt that adds structure and movement. The matching fabric belt with a buckle detail cinches the silhouette for a flattering, polished look. Perfect for both casual and dressy occasions, this dress combines timeless style with modern sophistication.	100% Polyester	1, 2	http://dumaofficial.com/cdn/shop/files/MARDADRESSGREY-1.jpg?v=1734420715	f
8498426675439	Miguel Polo Top Black	Reworking the classic polo shirt with our own touch for the season ahead. Offered in classic black, it's crafted from fine polyester yarns to created a structured fit. Design	100% Polyester	1, 2	http://dumaofficial.com/cdn/shop/files/MIGUELPOLOTOPBLACK-5_5da7ca94-d3c2-41eb-bdd5-98280cae302e.jpg?v=1715741099	f
8773307990255	Harmel Skirt | Black	Focusing on classic tailoring this fall season, this midi skirt is crafted from premium vegan leather fabric with a paneled construction precisely cut in a slim, straight silhouette that perfectly elongates the figure. Finished with back invisible zipper opening and back slit for easy walking. Pair it with our Sienna Top | White for the perfectly elegant fall outfit.	100% Polyester	1, 2Measurement :	http://dumaofficial.com/cdn/shop/files/HarmelSkirtBlack-2.jpg?v=1729132955	f
8060729688303	Pella Oversized Blazer Charcoal	Designed using premium polyester fabric from Japan, this double-breasted blazer is a classic wardrobe staple to carry you through the seasons. Crafted as an oversized fit and fully lined for easy layering featuring front flapped welt pockets and covered buttons.	100% Japan made Premium Polyester	ALL SIZE (FIT TO XL)	http://dumaofficial.com/cdn/shop/files/PellaBlazerBlack-2.jpg?v=1685033629	f
8211432308975	Galvan Sparkly Top Black	A simple yet flattering top crafted with metallic threads and shaped for a relaxed fit. Designed with ribbed hemline that sinched the waist and slightly puffed sleeves. Perfect top to throw on this holiday season.	60% Cotton, 40% Polyester	1, 2	http://dumaofficial.com/cdn/shop/files/GalvanSparklyTop.jpg?v=1701935610	f
8252042903791	Peggy Top Red	Classically romantic style with a dose of vintage charm, this peplum top is cut from premium Japanese made polyester for its structure and tailored feel. It has a blazer collar, a row of fancy diamond buttons and a flattering peplum. The red shade made it perfect to wear to your CNY festivities!Model : 175 cm	100% Japanese made Premium Polyester	1, 2	http://dumaofficial.com/cdn/shop/files/PeggyTopRed.jpg?v=1705996391	f
8498646155503	Portia Outer White	Outer of our dreams! Putting our own twist on a classic jacket silhouette, we've added frills to the front pockets for a more sophisticated element. Crafted from premium Japanese polyester twill in classic white, this is a definite must have! Pair it with our Tilda shorts for the perfect Sunday brunch look!	100% Japanese Polyester	1, 2	http://dumaofficial.com/cdn/shop/files/PORTIAOUTERWHITE-4.jpg?v=1715740211	f
8665146589423	Mina Knit Top | White	Our summertime favorite, this top is knitted with a crochet pattern for its relaxed charm, with a special touch of black hand-stitched	Cotton Poly Blend	1, 2	http://dumaofficial.com/cdn/shop/files/MINATOPWHITE-4.jpg?v=1720522373	f
8218785054959	Glacer Leather Skirt Maroon	Headline your party season outfits with this leather mini skirt! It's crafted from high quality faux leather and designed with simple A-line silhouette and hidden side zipper. Complement this special mini by styling it with our holiday limited color tops!	100% Polyester	S, M	http://dumaofficial.com/cdn/shop/files/GlacerSkirtMaroon.jpg?v=1702536925	f
8982852108527	Gaze Cardigan | White Multi	This cardigan features a unique geometric-inspired pattern throughout the body, contrasted by oversized ribbed trims along the cuffs and hem. The wide ribbing continues into a bold V-neckline that adds structure and definition to the relaxed silhouette. A statement piece that’s both cozy and polished.	100% Cotton	ALL SIZEMeasurement :	http://dumaofficial.com/cdn/shop/files/GAZECARDIGAN-1.jpg?v=1750071925	f
9000442331375	Inna Pants | White	Elevate your look with these effortlessly chic high-waisted flowy pants. Designed with a bias cut for a beautifully fluid drape, they feature an easy wide-leg silhouette that moves gracefully with every step. The slip-on style and elasticized waistband ensure a comfortable, flattering fit, making these pants perfect for both casual and dressy occasions. Pair them with your favorite top for a polished yet relaxed vibe.	100% Polyester (matte finish)	Small, Medium, Large	http://dumaofficial.com/cdn/shop/files/INNAPANTSWHITE1.jpg?v=1750823832	f
7471319777519	Carol Pants Grey	Get cozy and festive this christmas with our Carol Pants Navy! Knitted from soft cotton yarn into the perfect palazzo knit pants, featuring a high rise, wide leg and a relaxed fit. Pair it with our Noel Top or Jolly Cardigan for the ultimate holiday outfit for your festivities!	100% Cotton	SMALL, MEDIUM	http://dumaofficial.com/cdn/shop/products/WhatsAppImage2021-12-07at13.42.13_1.jpg?v=1638860450	f
8060715663599	Cho Cargo Pants Dark Navy	Crafted from a sustainable premium Japanese polyester fabric that is luxuriously soft and cooling, this cargo sweatpants are cut for a relaxed fit with a comfortable elasticated waistband with drawstrings, cargo detailings on each leg, and side seam pockets. Pair it with the matching crop t-shirt for a chic and comfy everyday look!	75% Polyester, 25% Cotton	ALL SIZE (FIT TO XL)	http://dumaofficial.com/cdn/shop/files/ChoCargoPantsDarkNavy.jpg?v=1685002882	f
8752243933423	Rugosa Top | Denim Blue	Bringing back the 80’s unforgettable style with this sleeveless denim top that can be worn as a set with our line of denim pants. We incorporated handmade frays into the neckline and hem of this boxy-cut top, crafted from soft, washed blue denim for a comfortable daily wear. Completed with a back slit opening and a classic round neck, Rugosa Top | Denim Blue is the very definition of simple, but not basic.	97% Cotton, 3% Elastane	1, 2	http://dumaofficial.com/cdn/shop/files/E33595F1-C2AA-4933-A214-6E67EB8D662D.jpg?v=1725869075	f
7739069858031	Capole Blazer Grey	A modern v-neck blazer featuring an oversized silhouette, pocket flaps and cuff-less sleeves. Crafted from the perfect monochrome pattern scuba fabric into the most ideal oversize, relaxed fit suitable for your day to night, office to ladies night out!	97% Polyamide 3% Elastane	All Size	http://dumaofficial.com/cdn/shop/products/FUNDAMENTALSRESIZEDCATALOGArtboard105.jpg?v=1657771346	f
7605187739887	Odin Vest Tweed Cream	Sleeveless tweed vest with covered buttons, elastic waist bandings and chest pockets. Its design, fabric, and color bring both lady-like and contemporary silhouette, perfect for any women, for any occasion!	60% Wool Blend, 35% Cotton, 5% Nylon	ALL SIZE	http://dumaofficial.com/cdn/shop/products/ODIN4.jpg?v=1648171949	f
8773325816047	Laya Skirt | White	This denim maxi skirt is inspired from the essence of traditional tailoring, and the casual character of a denim fabric. Cut into an A-line silhouette with front pleated panels, unique belt loop shape, and elastic waistband for additional comfort.	70% Cotton, 30% Polyester	1, 2Measurement :	http://dumaofficial.com/cdn/shop/files/LayaSkirtWhite-4.jpg?v=1729132678	f
8840007319791	Protea Set | Navy	This elegant two-piece knit set features a strapless bandeau top with a flattering peplum detail and a high-waisted flared mini skirt, creating a timeless and sophisticated silhouette. Made from premium knit fabric in a classic deep navy, it offers both structure and comfort, perfect for formal events, evening parties, or upscale gatherings. Wear it as a complete set for a polished look or mix and match with your wardrobe staples for versatile styling.	100% Nylon	1, 2Measurement :	http://dumaofficial.com/cdn/shop/files/IMG_7930.jpg?v=1733997435	f
9024378372335	Sante Pants | White	An essential for the sunny weather, this pair of straight-linen pants are a must-have for those who adore clean and minimalist aesthetic. Crafted from breathable, natural linen, it features a soft, full-length breezy lining for added comfort. The elasticated waistband offers a flexible, pull-on fit – perfect for everyday wear or an impromptu summer escape.	100% Linen	Small, Medium, Large	http://dumaofficial.com/cdn/shop/files/SantePantsWhite1.jpg?v=1753692687	f
7894111125743	Alfie Pants Denim Blue	High-waisted denim pants with an elastic waistband and straight-leg design. Made from soft 100% tencel denim fabric, completed with side pockets and tied belt in matching fabric. This will most definately be the most comfortable pair of denim pants you'll ever own, not to mention how flattering it will look on you!	100% TENCEL	1 &amp; 2	http://dumaofficial.com/cdn/shop/products/AlfieDenim_3.jpg?v=1666742037	f
9001313435887	Mod Hoodie | White	This hoodie featuring a clean silhouette, wide tonal drawstrings, and a unique button-up opening at the neckline for a subtle, elevated twist. The soft viscose keeps you cozy, while the roomy front pocket adds function without sacrificing form. It’s the perfect blend of laid-back comfort and minimal chic — ideal for traveling in style.	Soft Viscose	ALL SIZE	http://dumaofficial.com/cdn/shop/files/MODHOODIEWHITE1.jpg?v=1750823790	f
7823886057711	Nora Leather Shorts Brown	PREORDER 14 - 18 WORKING DAYS Short leather pants cast in a versatile brown shade, completed with belt loops, side slant pockets, and pleats at waist. With it’s a-line silhouette and concealed zip, button and hook fastening, this pants looks sleek and polished, easy to pair with any basics for any occasions.	Vegan Leather 100% Polyester	SMALL, MEDIUM	http://dumaofficial.com/cdn/shop/products/gigi5_b5349ec7-a8c0-4044-9baf-82e7a0415a0c.jpg?v=1662687595	f
7894084976879	Dorka Polo Black	This striped polo shirt is knitted from soft cotton yarns into a the perfectly boxy and oversized fit. A seasonless and casual piece that you'll find yourself getting too attatched to all year round. Pair it with your favorite denim pants for a casual day out!	100% COTTON	All Size	http://dumaofficial.com/cdn/shop/products/DorkaBlack.jpg?v=1666604130	f
8625230577903	MICOLE | Slim Fit Crew Neck in Beige	A wardrobe staple offered in a neutral oatmeal color, it’s crafted from soft and stretch lyocell and has a streamlined slim fit that's ideal for daily or for layering purposes.	100 % Lyocell Blend	Small, Medium	http://dumaofficial.com/cdn/shop/files/LEN-DUMA-6758-edit.jpg?v=1718842187	f
8005185241327	Ansel Cardigan Navy	Knitted from soft viscose yarns, this V-neck cardigan is designed for a regular fit and features a subtly nipped-in waist. It has modern tubular trims, finished with front button closure and ribbed cuffs and hems. The perfect luxurious loungewear you need in your wardrobe!	Soft Viscose	All Size	http://dumaofficial.com/cdn/shop/products/AnselCardiganNavy.jpg?v=1677142085	f
7946310025455	Rami Cardi Green	Knitted from soft cotton yarns into the perfect christmas color pointelle knit pattern! Snug and comfy, this cardigan will be the perfect company for your holiday festivities! Pair it with our priya shorts as a set for a homey look, or with our Rafa Pants for a more put together look this holiday season!	100% Cotton	1 &amp; 2	http://dumaofficial.com/cdn/shop/products/RamiCardiganGreen_4.jpg?v=1670552171	f
8773366907119	Olam Dress | White	Crafted from crisp cotton blend fabric, this white shirt dress is inspired by elements of workwear but made our way. Featuring a pointed collar, front button closure, A-line fit, and a flattering halter neckline. Perfect to throw on this fall season!	70% Cotton, 30% Polyester	ALL SIZE	http://dumaofficial.com/cdn/shop/files/OlamDressWhite.jpg?v=1729132619	f
7605183971567	Zannu Tweed Outer	Modern Tailored Coat made of tweed fabric with a cool tone color combination of blue, black, grey, and white that creates a classic yet elegant mood. Designed with an oversized fit, 7/8 sleeves, hidden pocket and a clean cut, this is the perfect outer to grab and go on any occasion.	60% Wool Blend, 35% Cotton, 5% Nylon	ALL SIZE	http://dumaofficial.com/cdn/shop/products/ZANNUTWEEDNAVY.jpg?v=1648172286	f
8498614468847	Ulla Dress Black	We've made the perfect little black dress for you, mixing comfort and style. Knitted from soft viscose yarns, this off shoulder dress hugs your body and compliments it perfectly. Slim-fitting and flares to a perfect midi length. Perfect for a date night!	Soft Viscose	ALL SIZE	http://dumaofficial.com/cdn/shop/files/ULLADRESSBLACK-3.jpg?v=1715741023	f
8082189746415	Izbel Jeans White	Our Izbel jeans fit slim through the hips and thighs before falling to cropped, flared cuffs. Made from natural denim with a hint of stretch, they have a high-rise, raw cut waist and tailored with front &amp; back darts to get that perfect fit.	Cotton Spandex	S, M, L	http://dumaofficial.com/cdn/shop/files/IzbelJeansWhite4.png?v=1688954127	f
8218769981679	Lumi Tweed Outer Black	Immensely wearable yet loaded with glamour, this jacket is cut from black sparkly tweed. It has an effortlessly boxy fit but is cropped to flatter your form. Pair it with our Apollo Denim Pants to give a more laid back look, or our Morris metallic pants for your upcoming holiday party!	100% Polyester	ALL SIZE	http://dumaofficial.com/cdn/shop/files/LumiTweedOuterBlack.jpg?v=1702537453	f
8211487719663	Gwen Denim Blazer	Expertly tailored denim short sleeve blazer with nipped-in waist, padded shoulders, and single breasted close. Meticulously designed for a simple and sophisticated look, pairs perfectly with our Aubrey denim midi skirt.	100% Cotton	1, 2	http://dumaofficial.com/cdn/shop/files/GwenDenimBlazer.jpg?v=1701935430	f
7823883698415	Josie Shirt White	Our best selling classic boxy-cut oversized shirt but with a twist! Made from soft Tencel fabric and featuring front cut-out	100% Tencel	ALL SIZE	http://dumaofficial.com/cdn/shop/products/josie1.jpg?v=1662434281	f
8211473334511	Sabina Denim Top	Reversible A-line top with relaxed silhouette. Allows you to choose between v-neckline or a round neckline, it's basically two in one! Pair it with our Apollo pants for an easy chic denim-on-denim look.	100% Cotton	ALL SIZE (FIT TO L)	http://dumaofficial.com/cdn/shop/files/SabinaDenimTop.jpg?v=1701935463	f
8060731719919	Pella Oversized Blazer Brown	Designed using premium polyester fabric from Japan, this double-breasted blazer is a classic wardrobe staple to carry you through the seasons. Crafted as an oversized fit and fully lined for easy layering featuring front flapped welt pockets and covered buttons.	100% Japan made Premium Polyester	ALL SIZE (FIT TO XL)	http://dumaofficial.com/cdn/shop/files/PellaBlazerBrown-2.jpg?v=1685033572	f
8843349459183	Garland Sweater | Beige	Shawl Neckline Sweater with multiple styling options, made from a mid-weight cotton knitting and featuring an intricate rib stitch. It has an oversized fit for casual sophistication. Pair it with our Sorrel satin pants for a comfortable yet stylish holiday/ airport fit.	100% Polyester	ALL SIZE	http://dumaofficial.com/cdn/shop/files/GARLANDSWEATERBEIGE-1.jpg?v=1734424099	f
8823412785391	MMEHUILLET FOR DUMA - Seoul Puffer | Green	The perfect blend of warmth and versatility, Seoul Puffer features a lightweight yet insulating design, with a smooth, quilted exterior. The real highlight is the detachable knit vest inside — a chic, textured layer that provides extra warmth. Whether you’re braving the cold or layering up for a more polished outfit, this jacket offers ultimate flexibility and a pop of color to brighten your winter wardrobe.	100% Polyester	ALL SIZE	http://dumaofficial.com/cdn/shop/files/SeoulPufferGreen.jpg?v=1732726662	f
8269578535151	Veste Tweed Vest Pink	Taking inspiration from traditional suiting, we created this special vest that is perfect for this season of love. Crafted from luxe and sparkly tweed and has a deep V-neckline, shaping darts, and a row of fancy gold floral buttons. Pairs perfectly with any bottoms you can think of!	100% Polyester	1, 2	http://dumaofficial.com/cdn/shop/files/VesteTweedVestPink.jpg?v=1707087666	f
8825018679535	MMEHUILLET FOR DUMA - Hwi Scarf | Dark Grey	Crafted from soft structured cotton, this hybrid poncho doubles as a scarf that can be draped over the shoulder for an effortless look. Secured with a single button on one shoulder that you can accessorize with our clip-on buttons. The dynamic silhouette and timeless color palette offer endless styling potential.	100% Cotton	All Size	http://dumaofficial.com/cdn/shop/files/HwiScarfDarkGrey-3.jpg?v=1732724816	f
8792594546927	Ang T-Shirt | Beige	Secure your transitional wardrobe with this staple long-sleeved mock neck top. Offered in a warm taupe tone, it’s crafted from soft lyocell blend and has a streamlined slim fit that’s ideal for layering.	76% Lyocell, 19% Wool, 5% Spandex	ALL SIZE (Fit to L)	http://dumaofficial.com/cdn/shop/files/ANGTSHIRTBEIGE-2_6a92ec31-5c75-49b1-943a-e2da3280a3b7.jpg?v=1729131415	f
8083256148207	Galena Cardigan Grey	This V-neck cardigan is knitted from customer's all time favorite soft viscose yarns. Designed for a contoured fit, it has neat ribbed trims and fasted with a row of horn buttons for a sleek finish. It's most definitely a wardrobe essential that will stay with you for a very long time.	Soft Viscose	All Size	http://dumaofficial.com/cdn/shop/files/GalenaCardiganArtboard3.jpg?v=1689081527	f
8897272807663	Kairi Top | White	Crafted from soft buttery knit blend with a fluid hand feel, this asymmetrical blouse is designed with drapes, fitted sleeves, and one shoulder silhouette. Style it with tailored skirts or trousers and kitten heels for the perfect fall outfit!	90% Polyester, 10% Elastane	ALL SIZE	http://dumaofficial.com/cdn/shop/files/KAIRITOPWHITE-1.jpg?v=1741927123	f
7946285646063	Cheri Shirt Grey	Boxy cut shirt knitted from soft cotton yarns in the most perfect shades of christmas! The perfect mix of feminine and boyish, cozy and put together look. Comfortable to wear, easy to style. Pair it with our Chala Pants for a chic and effortless everyday look!	100% COTTON	All Size	http://dumaofficial.com/cdn/shop/products/CheriShirtGrey_5.jpg?v=1670553405	f
7471335211247	Gale Skirt Maroon	Knit Skirt with three ribbing styles that gets wider from the waist to the hem, which flatters one's figure perfectly! Knitted from soft cotton yarns, with comfortable elastic waistband and A-line silhouette. Pair it with our Marilou Top for the most sophisticated, elegant look this holiday season!	100% Cotton	ALL SIZE	http://dumaofficial.com/cdn/shop/products/WhatsAppImage2021-12-07at13.42.51_1.jpg?v=1638923952	f
8791875551471	Ochre Shorts | Sand	Designed with a mid-waist and tailored fit, these shorts offer a chic silhouette that transitions seamlessly from day to night. Dress it up with our matching suede jacket in warm hues, or down with a casual tee—these suede shorts are your go-to piece for stylish fall layering.	100% Polyester	1, 2Measurement :	http://dumaofficial.com/cdn/shop/files/OCHRESHORTSSAND-5.jpg?v=1729052933	f
8006360498415	Eli Top Red	Knitted from soft cotton yarns, this utterly comfy knit top will easily become a staple in every women's wardrobe. As a loungewear or for going out, this top has a very versatile style that you can pair it with any bottom you can possibly think of.	100% Cotton	ALL SIZE	http://dumaofficial.com/cdn/shop/products/DAN-DUMA20230110-CATALOGUE2-13.jpg?v=1677132937	f
8498266865903	Matteau Blazer Navy Stripe	This double collar blazer is specially designed with a deconstructed element, to create two different looks with one. Crafted from premium suiting polyester, this blazer has a boxy oversized silhouette and front button closures. The shirt collar is detachable with button fastenings. Casual and smart in one blazer, perfect for you girl bosses!	100% Polyester	ALL SIZEMeasurement :	http://dumaofficial.com/cdn/shop/files/MATTEAUBLAZERNAVYSTRIPE-3.jpg?v=1715741294	f
8843356078319	Remmy Skort | Grey	Our best-selling Remmy Skort, now in new colors and fabric, perfect for the winter season! It has an A-line silhouette knife pleats and an inner shorts for effortless movements. Pair it with your favorite sweater for a cozy winter fit.	100% Polyester	1, 2	http://dumaofficial.com/cdn/shop/files/REMMYSKORTGREY-1.jpg?v=1734421798	f
8860280324335	Tan Pants | Cream	Elevate your look with these effortlessly chic high-waisted satin pants. Designed with a bias cut for a beautifully fluid drape, they feature an easy wide-leg silhouette that moves gracefully with every step. The slip-on style and elasticized waistband ensure a comfortable, flattering fit, making these pants perfect for both casual and dressy occasions. Pair them with your favorite top for a polished yet relaxed vibe.	100% Polyester	Small, Medium, Large	http://dumaofficial.com/cdn/shop/files/Tan_Pants_Cream_1.jpg?v=1753696584	f
8959790874863	Tan Pants | Burgundy	Elevate your look with these effortlessly chic high-waisted satin pants. Designed with a bias cut for a beautifully fluid drape, they feature an easy wide-leg silhouette that moves gracefully with every step. The slip-on style and elasticized waistband ensure a comfortable, flattering fit, making these pants perfect for both casual and dressy occasions. Pair them with your favorite top for a polished yet relaxed vibe.	100% Premium Polyester	Small, Medium, Large	http://dumaofficial.com/cdn/shop/files/TANPANTSBURGUNDY-1.jpg?v=1747646400	f
8947900711151	Jorja Top | Black	This sleeveless structured top exudes sophistication with its high mandarin collar and sleek tailored fit. Designed in a rich black hue, it features a statement gold button closure that adds a touch of elegance and refinement. The flap pockets enhance its polished appeal, while the subtly curved hem provides a flattering silhouette. Perfect for both formal and chic casual looks, this top pairs effortlessly with tailored trousers or denim for a versatile, fashion-forward ensemble.	100% Japanese made Premium Polyester	1, 2	http://dumaofficial.com/cdn/shop/files/JORJATOPBLACK-1.jpg?v=1745989072	f
8665221693679	Alba Linen Skirt | White	Mini Skirt crafted from our pinstripe linen fabrication, our Alba Linen Skirt is an essential piece for your staple summer wardrobe. Designed to sit mid-waist, this skirt exudes classic sophistication as it is cut straight and finishes upper-mid thigh. It features a waistband, belt hoops and secures with a center zip fly.	100% Linen	Small, Medium, Large	http://dumaofficial.com/cdn/shop/files/ALBALINENSKIRTWHITE-2.jpg?v=1720522066	f
7455718047983	Charli Top White	Sleeveless Oversized Shirt that doubles as an outer vest. Chic and comfortable, sporty yet sophisticated. With a relaxed silhouete, waistband to define your waist, and a front opening, this is the perfect top to wear to many different events and style it any way! Pair it with our Noor Skirt for a feminine look, or our Jola Pant for a casual everyday look.	100% Tencel	ALL SIZE	http://dumaofficial.com/cdn/shop/products/Artboard36_1.png?v=1637806213	f
8986673447151	Getta Cardigan | Dark Brown	Wrap yourself in effortless elegance with this soft viscose cardigan, designed for both comfort and style. Featuring a flattering V-neckline and a waist that accentuates your silhouette, this piece brings a refined touch to your day-to-day outfits. Added with a row of vegan leather buttons, for a touch of subtle quirk to this timeless knit.	Soft Viscose	ALL SIZE	http://dumaofficial.com/cdn/shop/files/GETTACARDIGANDARKBROWN1.jpg?v=1750786028	f
9000474640623	Eve T-shirt | Taupe	PREORDER 25 WORKING DAYS A classic everyday T-shirt, offered in taupe. Designed with a classic crew neckline and a flattering straight cut, this top is crafted from a silky-soft rayon blend with a touch of stretch for maximum comfort and versatility. The clean silhouette hits at the ideal length to pair with just about anything.	56,5% Rayon, 31,2% Polyamide, 12,3% Spandex	Small, Medium	http://dumaofficial.com/cdn/shop/files/EVET-SHIRTTAUPE1.jpg?v=1750785569	f
7740221128943	Marin Cardigan Black	Knitted from very soft and elastic viscose yarns, this calf-length cardigan with v-neckline, front button closure and side slit is a must have in every women's wardrobe. With its relaxed fit, its very easy to style with any outfit or for any occasions.	SOFT VISCOSE	ALL SIZE	http://dumaofficial.com/cdn/shop/products/FUNDAMENTALSRESIZEDCATALOGArtboard75.jpg?v=1657770965	f
8986659750127	Verra Top | Ochre	This top features soft drapes across the front that create a flattering, elegant shape. It’s designed with shoulder padding to give structure and a bold silhouette. The added buttoned shoulder detail gives it a modern, tailored touch. A perfect mix of strong and feminine.	100% Polyester	Small, Medium, Large	http://dumaofficial.com/cdn/shop/files/VERRATOPOCHRE2.jpg?v=1750835859	f
9000474935535	Eve T-shirt | Soft Beige	PREORDER 25 WORKING DAYS A classic everyday T-shirt, offered in soft beige. Designed with a classic crew neckline and a flattering straight cut, this top is crafted from a silky-soft rayon blend with a touch of stretch for maximum comfort and versatility. The clean silhouette hits at the ideal length to pair with just about anything.	56,5% Rayon, 31,2% Polyamide, 12,3% Spandex	Small, Medium	http://dumaofficial.com/cdn/shop/files/EVET-SHIRTSOFTBEIGE1.jpg?v=1750785533	f
8664974557423	Bardi Shirt | Denim Blue	An elevated wardrobe staple, this structured short sleeve shirt is cut from our soft denim fabric, finished with side slit, pointed flat collar, front button fastening and the perfect contouring slim fit for an effortless look. Complete the look by pairing it with our Agatha Shorts | Denim Blue for the perfect easy summer look!	100% Polyester	1, 2	http://dumaofficial.com/cdn/shop/files/BARDIDENIMSHIRT-4.jpg?v=1720522085	f
8329474244847	Florence Top Pink	The Florence top in our special brocade fabrication is a sweet addition to our collection. This silhouette is designed to be a relaxed fit with A-line body and front draped peplum detail and perfectly shaped slight halter neckline. Pair it with our Natia skirt for the perfect look!	60% Polyester, 40% Cotton	1, 2	http://dumaofficial.com/cdn/shop/files/FlorenceTopPink.jpg?v=1711026915	f
8116764836079	Ansel Cardigan Black	Knitted from soft viscose yarns, this V-neck cardigan is designed for a regular fit and features a subtly nipped-in waist. It has modern tubular trims, finished with front button closure and ribbed cuffs and hems. The perfect luxurious loungewear you need in your wardrobe!	Soft Viscose	All Size	http://dumaofficial.com/cdn/shop/files/AnselCardiBlack.jpg?v=1695005008	f
8196280549615	Idris Knit Dress White	Made from a loosely knitted rib texture using soft rayon yarns, this maxi dress has a relaxed tank silhouette that contours down the body beautifully. Wear it with the matching cardigan to get the perfect travelling look.	92% Rayon, 8% Nylon	ALL SIZE (FIT TO L)	http://dumaofficial.com/cdn/shop/files/IdrisDressWhite.jpg?v=1700777788	f
8005193531631	Jetro Pants Navy	Flowing, straight-cut knit pants made from soft viscose yarn, this pants definitely call for sophisticated working-from-home (or anywhere) luxurious loungewear. Just the perfect thing for you when you want to feel pulled together. Pair it with our Ansel Cardi for a complete upscale loungewear look!	Soft Viscose	All Size	http://dumaofficial.com/cdn/shop/products/JetroPantsNavy-2.jpg?v=1677200297	f
8825017958639	MMEHUILLET FOR DUMA - Olbit Cardigan | White	SHIPMENT JANUARY The kind of cardigan you would snuggle in with, this piece was knitted from the softest and comfiest viscose yarns. Versatile with a touch of unexpected twist, it can be styled both as a regular and asymmetrical cardigan, with its adjustable side buttons. Completed with a flattering deep V-neckline and detachable chic scarf, Olbit Cardigan is definitely an unforgettable scene-stealer.	Soft Viscose	All Size	http://dumaofficial.com/cdn/shop/files/OlbitCardiganWhite-6.jpg?v=1732724891	f
8860247261423	Wang Top | Sage	The very definition of edgy elegance — Wang Top features a cinched waist that accentuates your silhouette flatteringly. The design showcases a unique wavy placket, adding a touch of contemporary flair. Made from a structured fabric with slight sheen, it offers both sophistication and edge. Adorned with a row of unique handmade floral appliqués with snap buttons as the front opening, Wang Top is a gorgeous head-turner for that long-awaited special occasion.	100% Polyester	1, 2	http://dumaofficial.com/cdn/shop/files/WANGTOPSAGE-1.jpg?v=1736914111	f
7605207531759	Shayla Dress White	Elegant Wrap Style Dress with V-Neckline, Relaxed Collar, and Pleated	70% Rayon, 30% Polyester	ALL SIZE	http://dumaofficial.com/cdn/shop/products/SHAYLA1.jpg?v=1648172067	f
8114153816303	Merman Dress White	This dress is crafted from intricate cotton embroidery impeccably made for a seasonless look. It's offered in a fresh white hue and a contrasting poplin collar and cuffs expertly tailored in an oversized silhouette. The lace creates an uneven hem for a special touch.	50% Cotton, 50% Polyester	All Size	http://dumaofficial.com/cdn/shop/files/MermanDressWhite.jpg?v=1694581505	f
8036455252207	Toja Pants Fuchsia	Basic pair of pants that you never know you needed! Knitted from soft cotton yarns into the perfect long white pants silhouette that gives your legs an ellongated effect, completed with drawstring	100% Cotton	1 (S-M), 2 (M-L)	http://dumaofficial.com/cdn/shop/products/7edaaba0-e72a-4a11-baec-4054e141dff3.jpg?v=1681103994	f
8752246128879	Aqui Knit Top | Black	Inspired by the Aquilegia flower that symbolizes aspiration, this piece was created for the trend-setters and risk-takers. Knitted from structured but soft 100% cotton yarn in a relaxed, boxy cut that’s suitable for all body types. The contrasting flower in feminine hues is cute and daring at the same time, making it a one-of-a-kind top that stands out from the mainstream crowd.	100% Cotton	Small, Medium, Large	http://dumaofficial.com/cdn/shop/files/FF863216-2FF8-40AA-8EA5-2BEF2DAE3FA6.jpg?v=1725868846	f
7975352762607	Yuma Skirt Green	Satin Floral Midi Skirt with A-line silhouette, featuring hidden elastic waistband, and subtle back darts. With its subtle sheen, this is the perfect skirt to wear for any scenario, from daily wear to more formal occasions. Elevate your simple look by pairing it with our Suri Top to attend your upcoming cny festivities!	100% Polyester	All Size	http://dumaofficial.com/cdn/shop/products/YumaSkirtGreen.jpg?v=1673496627	f
8896420839663	Pufu Blouse | White	This elegant soft Tencel top is a timeless piece that effortlessly blends femininity and sophistication. Featuring delicately pleated flutter sleeves, it adds a touch of volume and grace to the silhouette. The V-neckline with a subtle keyhole cutout and loop button closure creates a refined yet modern detail. Designed in a lightweight, breathable fabric, this top is perfect for both casual and polished looks, making it an essential addition to any wardrobe.	100% Tencel	ALL SIZE	http://dumaofficial.com/cdn/shop/files/PUFU_BLOUSE_WHITE-1.jpg?v=1745910160	f
9024434962671	Possa Skirt | White	This Possa Skirt is one of those pieces that feels special without trying too hard. Made from a crisp, airy fabric that moves beautifully, it has a soft A-line shape that flatters and flows. It’s the kind of skirt you’ll reach for when you want to look put-together but still feel effortless—perfect with a simple tank for brunch, or dressed up with heels for dinner out. Either way, it’s a piece that speaks softly but stands out.	73% Polyester, 27% Nylon	Small, Medium, Large	http://dumaofficial.com/cdn/shop/files/PossaSkirtWhite2.jpg?v=1753843203	f
7823880028399	Arzel Blazer Denim	Double Breasted Oversized Blazer dusted in the perfect denim shade and tailored to a boxy silhouette with brown leather side seam	70% Rayon, 30% Polyester	All Size	http://dumaofficial.com/cdn/shop/products/arzel8.jpg?v=1662689702	f
8005164826863	Elia Dress Brown	Designed from a lightweight fluid woven shirting fabric, this scoop neck tank top dress featuring panels that creates the perfect a-line fit with slimming silhouette is definitely a wardrobe staple for you all year round!	100% Japanese made Premium Polyester	1, 2	http://dumaofficial.com/cdn/shop/products/EliaDressBrown-2.jpg?v=1677200717	f
8304613720303	Aster Dress Navy	Knitted from soft and airy cotton fabric into an intricate pointelle pattern detail in the perfect navy hue, this dress is shaped to a contoured fit that flows down to a slightly flared hem. Perfect for everyday, or even some special occasions!	100% Cotton	ALL SIZEMeasurement :	http://dumaofficial.com/cdn/shop/files/AsterDressNavy-6.jpg?v=1710170323	f
8842741317871	Doglas Tee | White	Making our basic fit white tee extra special this holiday season with our special print! Knitted from soft 100% Cotton yarn in a relaxed, cropped cut for maximum comfort in daily wear. Pair it with your favorite pair of bottom for your next cozy Christmas gatherings.	100% Cotton	1, 2	http://dumaofficial.com/cdn/shop/files/DOGLASTEE-5.jpg?v=1734492930	f
8818185371887	Jennie Tanktop | Charcoal	An essential for your daily wardrobe, especially those warmer days. Offered in a charcoal tone, it’s crafted from soft lyocell blend and has a streamlined slim fit with endless styling opportunities - wear it alone or layered under shirts and blazers.	76% Lyocell, 19% Wool, 5% Spandex	ALL SIZE (Fit to L)	http://dumaofficial.com/cdn/shop/files/JennieTanktopCharchoal-5.png?v=1731576990	f
7605183250671	Dali Top Brown	This top is an essential for everyone's capsule wardrobe! Simple design, with soft knitted fabric, and the perfect shades of neutral color. You can easily style this top with any pair of bottoms you have at home or pair it with our Grata Pant for a lazy day ootd!	Soft Viscose	All Size	http://dumaofficial.com/cdn/shop/products/Artboard27_b44b1eeb-10e4-4046-bbc5-d0aaae530d6f.png?v=1648172242	f
8030794580207	Bergo Mini Dress Navy	Short Stripes blazer knit dress crafted from soft cotton yarns, featuring a double-breasted design with lapel and covered buttons, contrast collar, and short sleeves. Perfect to throw on this spring season!	100% Cotton	All Size ( Fit To Large )	http://dumaofficial.com/cdn/shop/products/BergoDressNavy-3.jpg?v=1680152702	f
8082171101423	Capri Pants Pink	Instantly polished and as equally comfortable, our ombré silky satin pants slips on with a flat front and thin elasticized waistband and hidden drawstrings for covert ease, Its slim straight leg falls with a lightweight drape will fits flatteringly on any legs.	100% Polyester	1, 2	http://dumaofficial.com/cdn/shop/files/CapriPantsPink3.png?v=1688954776	f
8913509810415	Aluba Top | Cream	This cream-colored top is effortlessly stylish and comfortable. It features a relaxed, flowy silhouette with a playful peplum detail for a flattering shape. The short puff sleeves add a touch of femininity, while the soft fabric makes it perfect for all-day wear. A versatile piece that pairs well with both casual and dressy outfits! Pair it with our Tan Pants | Cream for an easy elegant look!	100% Nylon	ALL SIZEMeasurement :	http://dumaofficial.com/cdn/shop/files/AlubaTopCream.jpg?v=1741856331	f
9000412872943	Mellow Set | Butter	PREORDER 25 WORKING DAYS This butter-yellow set features a soft, lightweight knit fabric that feels airy and comfortable on the skin. The set consists of a sleeveless inner tank and a matching long-sleeve cardigan with a front button closure, giving it a coordinated yet relaxed look. Whether worn together or styled separately, it offers a fresh, effortless elegance ideal for daily wear or travel.	100% Lyocell	ALL SIZE	http://dumaofficial.com/cdn/shop/files/MELLOWSETBUTTER7.jpg?v=1750851664	f
8792946508015	Ora Top | White	This asymmetrical one-shoulder top might just be the comfiest and chicest piece you’ll ever have. Its ruched	90% Polyester, 10% Elastane	ALL SIZE (Fit to L)	http://dumaofficial.com/cdn/shop/files/ORATOPWHITE-3.jpg?v=1729088034	f
7113857138866	Dali Top Grey	This top is an essential for everyone's capsule wardrobe! Simple design, with soft knitted fabric, and the perfect shades of neutral color. You can easily style this top with any pair of bottoms you have at home or pair it with our Grata Pant for a lazy day ootd!	Soft Viscose	All Size	http://dumaofficial.com/cdn/shop/products/WhatsAppImage2021-10-29at21.50.58.jpg?v=1635698787	f
8498523111663	Errie Shirt Vest Tencel White	A two-in-one situation, this crop shirt is crafted from soft and crisp tencel fabric and designed uniquely like a layered top. Featuring cropped shirt with a sewn-in vest inside. Classic and stylish, the perfect addition to your wardrobe.	100% Tencel	ALL SIZE	http://dumaofficial.com/cdn/shop/files/ERRIESHIRTVESTTENCELWHITE-2.jpg?v=1715599706	f
8951255498991	Greno Cardigan Top  | Dark Grey	Our Greno Cardigan Top is a seasonless essential that every wardrobe need. Lightweight knitwear pieces, with point collar and button front fastening cardigan. Perfect for any look you're going for any time of day!	100% COTTON	1, 2	http://dumaofficial.com/cdn/shop/files/KANOSETDARKGREY-4.jpg?v=1747788372	f
9000451834095	Eve T-shirt | Pink	PREORDER 25 WORKING DAYS A classic everyday T-shirt, offered in pink. Designed with a classic crew neckline and a flattering straight cut, this top is crafted from a silky-soft rayon blend with a touch of stretch for maximum comfort and versatility. The clean silhouette hits at the ideal length to pair with just about anything.	56,5% Rayon, 31,2% Polyamide, 12,3% Spandex	Small, Medium	http://dumaofficial.com/cdn/shop/files/EVET-SHIRTSOFTPINK2.jpg?v=1750852703	f
8604408971503	Daisy Cuddle Pillow Pink	A bed is not a slumber when there is nothing to embrace and cuddle with. But that is no longer the case with our cuddle pillows! Made in 100% cotton, our cuddle pillows are designed in perfect size and shape to stay closely to you anywhere you want them to. Hold them fondly because separation will be hard. Plus, a good night sleep is only a cuddle away — is there anything better than that?	Made in 100% cotton and 95% TENCEL™️ fabric	ALL SIZE	http://dumaofficial.com/cdn/shop/files/Daisy_Pillow_Pink-5_e11911f4-f7cd-4460-a24b-64d1da21a1a2.jpg?v=1718080211	f
9024401899759	Shiba Top | Dark Brown	PREORDER 10 WORKING DAYS Meet Shiba Top, a blouse that can seamlessly transition from day to night occasions. Detailed with ruched waist and boat-neck cut, hugging your body flatteringly. Its side zipper opening and lining maintain the clean look of this contemporary top, and the structured yet smooth fabric keeps this piece’s carefully-designed silhouette in perfect shape.	100% Japanese made Premium Polyester	Small, Medium, Large	http://dumaofficial.com/cdn/shop/files/EliaTop1.jpg?v=1753696230	f
8825021006063	MMEHUILLET FOR DUMA - Olbit Cardigan | Black	The kind of cardigan you would snuggle in with, this piece was knitted from the softest and comfiest viscose yarns. Versatile with a touch of unexpected twist, it can be styled both as a regular and asymmetrical cardigan, with its adjustable side buttons. Completed with a flattering deep V-neckline and detachable chic scarf, Olbit Cardigan is definitely an unforgettable scene-stealer.	Soft Viscose	ALL SIZE	http://dumaofficial.com/cdn/shop/files/OlbitCardiganBlack.jpg?v=1732724682	f
8269638271215	Lumi Tweed Outer Pink	Immensely wearable yet loaded with glamour, this jacket is cut from pink sparkly tweed. It has an effortlessly boxy fit but is cropped to flatter your form. Pair it with our Glacer Leather Skirt for your dinner dates or Gilia Denim Jeans for your Valentines dinner!	100% Polyester	ALL SIZE	http://dumaofficial.com/cdn/shop/files/LumiOuterTweedPink.jpg?v=1707101809	f
8840005157103	Dahlia Dress | Navy Multi	This stunning floral maxi dress features a halter neckline with delicate crossover straps, flowing into a loose, layered silhouette that exudes effortless elegance. Adorned with vibrant pink and white florals on a deep navy base print, the tiered ruffles add movement and a romantic touch, making it perfect for garden parties, summer weddings, or special occasions. Light and airy, this dress offers comfort and style for any event, while its flattering cut ensures a graceful and feminine look.	100% POLYESTER	ALL SIZEMeasurement :	http://dumaofficial.com/cdn/shop/files/IMG_7927.jpg?v=1733997487	f
8825022447855	MMEHUILLET FOR DUMA - Daon Top | Brown	A must-have piece to add to your capsule wardrobe, Daon Top is the very definition of everyday wear. Knitted from soft yarns into a unique crochet texture, this piece blends both comfort and style into a loose, but flattering fit in neutral color palette. Adorn it with our clip-on rhinestone buttons for a more elevated look that can easily transition from day to night.	100% Polyester	1, 2	http://dumaofficial.com/cdn/shop/files/DaonTopBrown-2.jpg?v=1732724578	f
8913534157039	Tan Pants | Black	Elevate your look with these effortlessly chic high-waisted satin pants. Designed with a bias cut for a beautifully fluid drape, they feature an easy wide-leg silhouette that moves gracefully with every step. The slip-on style and elasticized waistband ensure a comfortable, flattering fit, making these pants perfect for both casual and dressy occasions. Pair them with your favorite top for a polished yet relaxed vibe.	100% Polyester	Small, Medium, Large	http://dumaofficial.com/cdn/shop/files/Tan_Pants_Black_1.jpg?v=1753697576	f
8664840143087	Oson Outer | Denim White	Turn effortless cool with our Oson Denim Outer. This slightly cropped denim jacket features a boxy fit and contrast seam stitching for a modern appeal. The natural white colorway and button detailing add a definition to a classic piece. Pair with our Tilda Shorts for a chic modern look.	100% Polyester	ALL SIZE	http://dumaofficial.com/cdn/shop/files/OSONDENIMBLAZERWHITE-2.jpg?v=1720522448	f
8860281962735	Zhupao Dress | Maroon	An effortlessly chic tweed dress that combines traditional elegance with modern tailoring. The high-neck collar adds a touch of refinement, while the structured A-line silhouette flatters the figure and ensures comfort for all-day wear. Adorned with one-of-a-kind pearl Chinese buttons that guarantee praises from your aunties and cousins.	100% Polyester	1, 2	http://dumaofficial.com/cdn/shop/files/ZHUPAODRESS-1.jpg?v=1736842056	f
8218752418031	Blanca Knit Cardigan Grey	This luxurious soft cardigan will be your new wardrobe staple this season. Crafted with premium soft cotton yarns, twisting two colors into the prefect texture. It has a boxy silhouette with deep V-neckline and double breasted closure completed with fancy gold buttons. Definitely a timeless piece.	100% Cotton	ALL SIZE	http://dumaofficial.com/cdn/shop/files/BlancaKnitCardiganGrey.jpg?v=1702537683	f
8773322178799	Curka Pants | White	Made from soft and stretchy denim in clear white, these pants are shaped with a high-rise waist and wide legs that effortlessly flows down your feet. Finished with our two front pocket styling that modernize the classic codes of denim.	Cotton Spandex	Small, Medium, LargeMeasurement :	http://dumaofficial.com/cdn/shop/files/CurkaPantsWhite-2.jpg?v=1729132904	f
8843357225199	Jareth Top | Brown Multi	Our Jareth Tweed Top is designed for a sophisticated, yet flattering fit. Crafted from our special festive tweed fabrication, with classic silhouettes of high neckline and subtly flared hemline, along with our special gold buttons front openings for added elegance.	100% Polyester	1, 2	http://dumaofficial.com/cdn/shop/files/JARETHTOP-1.jpg?v=1734421683	f
8329483780335	Isabel Dress Yellow	Our Isabel dress is crafted from a crisp cotton fabrication, in a calm butter yellow hue. Perfect for every day styling, featuring full length sleeves, collared neckline, adjustable waist belt and soft pleats toward the hem. Pair with a simple heel for a complete look.	100% Cotton	ALL SIZE	http://dumaofficial.com/cdn/shop/files/IsabelDressYellow-2.jpg?v=1711073342	f
7471298543855	Noel Top Navy	Get cozy this Christmas with our Noel Top Navy! Knitted from soft cotton yarn into the perfect holiday sweater for you! Pull-over style with slightly balooned sleeves, ribbed hem and sleeves cuffs. Pair it with our Carol Pants for the ultimate holiday outfit for your festivities!	100% Cotton	All Size	http://dumaofficial.com/cdn/shop/products/WhatsAppImage2021-12-07at13.42.52.jpg?v=1638860135	f
8252046409967	Jiana Knit Top Maroon	Knitted from soft cotton yarns, this cardigan/top features a deep v-neckline, contoured waistline and delicate peplum	100% Cotton	1, 2	http://dumaofficial.com/cdn/shop/files/JianaKnitTopMaroon.jpg?v=1705991126	f
8294602703087	BELINDA | Regular Fit Extreme Soft in Pink	A very versatile and classic t-shirt, offered in a subtle pink hue. Crafted from a special cotton blend that’s soft to the touch, this classic crew neck top is cut for a neat fit with the perfect length.	100 % Cotton Blend	All Size (Fit to XL)	http://dumaofficial.com/cdn/shop/files/LEN01008-edit.jpg?v=1709010828	f
8110077575407	Khanyo Skirt Dark Denim	The exagreated flare silhouette is the focal point of this skater skirt. Designed for a mini length that sits just above the knee, it features a few cut panels with contrast stitchings, front button fastenings and panel waist detail. Wear it as a set with our Marion Denim top.	100% Cotton	S, M, L	http://dumaofficial.com/cdn/shop/files/MarionKhanyoDarkDenim-3_c044d145-fcce-4721-935a-1515a4775d24.jpg?v=1693822213	f
8110093336815	Jane Cardigan Navy	This cardigan has a minimal design with fancy wave knit pattern. Offered in timeless navy, it features a basic crew neck, two hook button closure, and scalloped edges. It's shaped for a slim fit with a cropped body and sleeves, perfect for wearing with high-waisted trousers.	85% Viscose, 15% Nylon	All Size	http://dumaofficial.com/cdn/shop/files/JaneCardiganNavy-2.jpg?v=1693822148	f
8220534472943	Andy Shorts Army Green	A timeless classic silhouette shorts designed to fit all kinds. They have a comfortable high waist that falls to an A-line shape for both comfort and a flattering cut, and short hemlines to create a leg-lengthening effect. Perfect match to all your tops!	100% Polyester	\N	http://dumaofficial.com/cdn/shop/files/AndyShortsArmyGreen-2.jpg?v=1702572161	f
8005183471855	Callan Shirt Dress Brown	Open collar shirt dress featuring an oversized fit, elongated profile, front patch pockets, concealed front button closure and a fluid silhouette for a relaxed take on tailoring. Wear it as it is for a shirt dress look, or layer over your basic go to outfit for an effortless business casual look.	100% Japanese made Premium Polyester	All Size	http://dumaofficial.com/cdn/shop/products/CallanShirtDressBrown.jpg?v=1677142513	f
8791849566447	Dalmar Jacket | Sand	Dalmar Jacket | Sand is the perfect addition to your fall wardrobe. Crafted from soft, premium suede, it boasts a rich texture that enhances its timeless appeal. The warm, earthy tones are ideal for the season, easily complementing cozy knits and denim. With a boxy fit that flatters any silhouette, it features a classic button-up front and functional pockets for added practicality.	100% Polyester	ALL SIZEMeasurement :	http://dumaofficial.com/cdn/shop/files/DALMARJACKETSAND-5_8c1f7ac6-cf6d-442d-9c5e-9ae89001d408.jpg?v=1729052367	f
8005216600303	Milla Vest Black	Our Milla Vest has a looser, straight cut made from soft viscose yarns and with front button down closure. A simple, timeless piece that can be worn solo or be layered over a tank or tee as you like! Pair it with our Jetro Pants for an easy elevated daily look!	SOFT VISCOSE	ALL SIZE	http://dumaofficial.com/cdn/shop/products/MillaVestBlack-4.jpg?v=1677200183	f
8252003090671	Xin Jacquard Set Floral Multi	Cropped halter top with midi pleated skirt set in a Chinese floral watercolor print jacquard, something special for this CNY season. The top features a Chinese collar and boxy cropped silhouette for a more youthful look, while the skirt features box pleats to sinch in the waist perfectly. Model : 175 cm	100% Cotton	1, 2	http://dumaofficial.com/cdn/shop/files/XinJacquardSet.jpg?v=1706001752	f
7113846784178	Fran Shorts Black	Through the handmade knitting process involved, each piece undergoes a natural twist of yarns that are uniquely different. Making an exclusive "twist" in every piece, specially for you.Easy pull-on shorts with flared body, perfect for lounging around! Made from a slub-melange cotton knit, this shorts is different from the other knit shorts you see out there! Perfectly soft and comfortable, fits any body type. Pair it with our Parson Top to make it look effortlessly put together on your lazy days.	100% Cotton	ALL SIZE  ( fit to Large )	http://dumaofficial.com/cdn/shop/products/WhatsAppImage2021-10-29at21.50.50.jpg?v=1635697469	f
8307535905007	Garnet Maxi Skirt Pink	Our take in creating the perfect maxi skirt, cut from silky premium satin fabric and the perfect pink shade. It is shaped to hug the waist and hip perfectly, flows to a flared hem, and finished with an elasticated internal waistband.	100% POLYESTER	S, M, L	http://dumaofficial.com/cdn/shop/files/GarnetMaxiSkirtPink.jpg?v=1710166074	f
8752245506287	Orchid Knit Tee | White	Taking the basic white tee to the next level, we gave our own twist to this staple piece. Knitted from soft 100% cotton yarn in a relaxed, cropped cut for maximum comfort in daily wear. And as the cherry on top is a printed pink Orchid flower that symbolizes love and beauty — definitely a subtle but memorable detail.	100% Cotton	1, 2	http://dumaofficial.com/cdn/shop/files/56ACF790-A857-42E2-A37C-114A80A30ABF.jpg?v=1725868997	f
7696637067503	Rotto Dress White	Crafted from soft and sustainable tencel fabric, this midi shirt dress has front panels nad softly pleated body that creats a flared, A-line hem. The flat collar and sight pockets make it feel equally smart and effortless. Perfect for your daily, clean, put-together look.	100% TENCEL	ALL SIZE	http://dumaofficial.com/cdn/shop/products/rotto2.jpg?v=1654825752	f
8664861278447	Denise Vest | Denim Blue	Our Denise Denim Vest is designed for a sophisticated, yet flattering fit. Crafted from our newest special denim fabrication, with classic silhouettes of high neckline and subtly flared hemline, along with our special gold flower buttons front openings for added elegance. Wear it as a set with the Remmy Skort | Denim Blue or Agatha Shorts | Denim Blue.	100% Polyester	1, 2	http://dumaofficial.com/cdn/shop/files/DANISETOP-5.jpg?v=1745990026	f
8060379136239	Bahia Outer White	Knitted from pure cotton yarns shaped for a classic fit with a cropped hem that works particularly well with any bottoms you have. It has a close round neck, Hand stitching patch pocket	100% Cotton	ALL SIZE	http://dumaofficial.com/cdn/shop/files/BahiaCardiganWhite-2.jpg?v=1685002840	f
7455651135727	Piccolo Vest Black	V-neck Vest Top made from a slub-melange, ribbed cotton knit that is both edgy and feminine at once. With its unbalanced hemline, cropped fit, and slim fitting, this top is perfect for when you want to feel comfortable but looks like you put all the effort to your outfit! Pair it with our Jola Pants to look more edgy, or our Noor Skirt for a more feminine look.	100% Cotton	All Size fit to Medium	http://dumaofficial.com/cdn/shop/products/Artboard16_44703175-66b3-481d-b15d-c4bf92c11203.png?v=1637806806	f
8825001378031	MMEHUILLET FOR DUMA - Sunsu Shirt | Denim White	Made from soft cotton-corduroy, this half-placket shirt has a pointed collar, cropped sleeves, concealed buttons and a curved stepped hem. Style it with our Baram Pants for a polished all-white look.	100% Cotton	All Size	http://dumaofficial.com/cdn/shop/files/SunsuShirtWhite-5.jpg?v=1732725074	f
8665134366959	June Tanktop | Medium Stripe	Knitted from soft cotton poly blend with a touch of stretch, this slim fit tank top is an essential on warmer days. Its navy blue and white stripes will enhance neutral outfits and has endless styling opportunities. Wear it alone or layered under shirts and blazers, pair it with denim or linen pants for the perfect summer fits.	Cotton Poly Blend	1, 2	http://dumaofficial.com/cdn/shop/files/JUNETANKTOPNAVY-4.jpg?v=1720522230	f
8823413145839	MMEHUILLET FOR DUMA - Seoul Puffer | White	The perfect blend of warmth and versatility, Seoul Puffer features a lightweight yet insulating design, with a smooth, quilted exterior. The real highlight is the detachable knit vest inside — a chic, textured layer that provides extra warmth. Whether you’re braving the cold or layering up for a more polished outfit, this jacket offers ultimate flexibility and a pop of color to brighten your winter wardrobe.	100% Polyester	ALL SIZE	http://dumaofficial.com/cdn/shop/files/SeoulPufferWhite.jpg?v=1732726689	f
8145580327151	Ripa Top Black	Made from ribbed cotton yarn with a touch of stretch, this slim-fit top is an essential for your capsule wardrobe. It has endless styling possibilities, and the cut-out design gives it an extra edge and unique point to your outfit.	100% Cotton	1, 2	http://dumaofficial.com/cdn/shop/files/RipaTopBlack.jpg?v=1697775960	f
9000432763119	Thasa Dress | Dark Brown	This halter-neck dark brown midi dress features a clean, minimalist silhouette. Crafted from a silky satin-finish fabric, it drapes beautifully on the body, creating a flattering and timeless look. The back is secured with a delicate button closure. Can be worn on its own for a effortless statement or styled with an outer layer for a more layered, contemporary feel—perfect for both day and night occasions.	100% Polyester	1, 2	http://dumaofficial.com/cdn/shop/files/THASADRESSDARKBROWN1.jpg?v=1750785869	f
7571081887983	Pia Oversized Tencel Shirt	Classic oversized shirt with a boxy cut made from soft Tencel fabric. Featuring button detailings around the body and adjustable panel in the back waistline, to be styled into different looks. Perfect for a day to night outfit, from casual to dressy in no time!	100% Tencel	ALL SIZE	http://dumaofficial.com/cdn/shop/products/Artboard33_d29a08a8-2751-47d4-9e55-eb0aefc7024b.png?v=1645668989	f
8036455907567	Maya Blazer Fuchsia	Knitted from soft cotton yarns into the perfect blazer top design and silhouette, finished with shoulder pads and covered buttons. Something you never knew you needed in your capsule wardrobe. Undeniably comfortable, suitable for formal or business casual events, keeps you looking professional yet comfortable for your important meetings. Can't forget how perfect it looks as an outer too! This piece will be your best purchase yet!	100% COTTON	All Size	http://dumaofficial.com/cdn/shop/products/MayaFuchsia3.jpg?v=1681104130	f
8211518947567	Trixie Dress Green	A special mini dress for this holiday season! This dress is shaped for a slim fit enhanced by the ribbed waist detail at the bodice, and flares out to a sculpted peplum mini skirt. Design	100% Nylon	ALL SIZE	http://dumaofficial.com/cdn/shop/files/TrixieDressGreen-2.jpg?v=1701967693	f
8751920742639	Rugosa Top | Denim White	Bringing back the 80’s unforgettable style with this sleeveless denim top that can be worn as a set with our line of denim pants. We incorporated handmade frays into the neckline and hem of this boxy-cut top, crafted from cotton-blend white denim for a comfortable daily wear. Completed with a back slit opening and a classic round neck, Rugosa Top | Denim White is the very definition of simple, but not basic.	70% Cotton, 30% Polyester	1, 2	http://dumaofficial.com/cdn/shop/files/RUGOSAWHITEDENIMTOP-1.jpg?v=1725938138	f
8110107197679	Izbel Jeans Black	Our Izbel jeans fit slim through the hips and thighs before falling to cropped, flared cuffs. Made from natural denim with a hint of stretch, they have a high-rise, raw cut waist and tailored with front &amp; back darts to get that perfect fit.	Cotton Spandex	S, M, L	http://dumaofficial.com/cdn/shop/files/IzbelPantsBlack.jpg?v=1693816295	f
7946298622191	Jetro Pants Red	Flowing, straight-cut knit pants made from soft viscose yarn, this pants definitely call for sophisticated working-from-home (or anywhere) luxurious loungewear. Just the perfect thing for you when you want to feel pulled together. Pair it with our Ansel Cardi for a complete upscale loungewear look!	Soft Viscose	All Size	http://dumaofficial.com/cdn/shop/products/JemaPantsRed_3.jpg?v=1670552626	f
8316165914863	Jiana Knit Top Navy	Knitted from soft cotton yarns, this cardigan/top features a deep v-neckline, contoured waistline and delicate peplum	100% Cotton	1, 2	http://dumaofficial.com/cdn/shop/files/JianaTopNavy.jpg?v=1710211586	f
8824607637743	MMEHUILLET FOR DUMA - Haru Shorts | Green	A tweed A-line shorts with cinched waistband that sits comfortably on the waist, ensuring a flattering fit for all body types. Completed with buttons detail that can be worn with our clip-on buttons and front pockets that offer practical functionality. Wear it as a set with our Seonyul Top for a chic but timeless look.	100% Polyester	Small, Medium, Large	http://dumaofficial.com/cdn/shop/files/HaruShortsGreen-2.jpg?v=1732725524	f
8060443361519	Rubie Crop Denim Shirt White	Crafted from a sustainable blend of soft cotton fabric with added stretch for comfort, this crop denim shirt is cut for a relaxed fit and has a classic pointed collar, back box pleat and neat buttoned blacket. The cropped length will pair perfectly with your favorite high-waisted trousers, or to pair with our matching Becca maxi skirt.	97% Cotton, 3% Spandex	ALL SIZE (FIT TO L)	http://dumaofficial.com/cdn/shop/files/RubieDenimShirtWhite-5.jpg?v=1685034094	f
8101855527151	Baltra Skirt Black	This black knit midi skirt is made from heavyweight pure cotton yarns that will last years in your wardrobe. It's designed with a comfortable elasticated waist and flares out to a softly draped A-line hem.	100% Cotton	All Size	http://dumaofficial.com/cdn/shop/files/Duma4641-1-edit3.jpg?v=1692595531	f
8667284996335	FIONA  | Regular Fit Crew Neck T-shirt in Black	A classic everyday T-shirt, offered in classic black. Crafted from a special cotton blend that’s soft to the touch, this versatile crew neck top is cut for a straight cut with the perfect length to pair with just about anything.	100 % Cotton Blend	Small, Medium, Large	http://dumaofficial.com/cdn/shop/files/FIONATOPBLACK-3.jpg?v=1745990296	f
8792571707631	Erina Shirt | Denim Blue	A staple for the fall, Erina Shirt | Denim Blue was created with comfort and utility in mind. Made from medium-weight washed denim in blue, this boxy shirt holds just the perfect structure to give that minimalist look, while still having the softness and stretch that you need for day-to-day activities. Pair it with our matching Mandez Pants | Denim Blue to achieve a chic denim-on-denim outfit!	70% cotton, 27% viscose, 3% elastane	1, 2	http://dumaofficial.com/cdn/shop/files/ERINADENIMSHIRT-1_6d063a62-a148-4de9-8d09-2527f123fffc.jpg?v=1729137384	f
7451739914479	Christmas Card	Wish Merry Christmas to your special someone with this card ! paper size : A6 Notes:1. Kindly Please chat our customer service for additional notes2. If there is no custom text, the gift card will be sent in Blank card	\N	A6	http://dumaofficial.com/cdn/shop/products/2_56d67a07-bc94-4f4a-9ec2-b9759ace8f0a.png?v=1669894854	f
9000415723759	Hana Cardigan | Soft Pink	Light, airy, and effortlessly feminine, this pointelle cardigan is the perfect layering piece for the warmer weather. Crafted with delicate openwork knit and pretty shell buttons, it offers breathable comfort while adding a touch of texture to any outfit. A relaxed fit piece that’s perfect for your next brunch or summer getaway.	100% Cotton	ALL SIZE	http://dumaofficial.com/cdn/shop/files/HANACARDIGANSOFTPINK6.jpg?v=1750851898	f
8825005506799	MMEHUILLET FOR DUMA - Hwi Scarf | Dark Brown	Crafted from soft structured cotton, this hybrid poncho doubles as a scarf that can be draped over the shoulder for an effortless look. Secured with a single button on one shoulder that you can accessorize with our clip-on buttons. The dynamic silhouette and timeless color palette offer endless styling potential.	100% Cotton	ALL SIZE	http://dumaofficial.com/cdn/shop/files/HwiScarfDarkBrown.jpg?v=1732725028	f
8145558438127	Bronte Top Black	This long-sleeved top is one of the essential piece created for our newest collection. It’s crafted from soft breathable cotton with a touch of stretch and features a draped square neck top and bolero style fitted sleeves. Easily style with your go to pants for an elevated look in seconds.	100% Cotton	All Size	http://dumaofficial.com/cdn/shop/files/BronteTopBlack.jpg?v=1697776330	f
8896416710895	Giara Top | Light Denim	This denim top features a classic button-down front with metallic buttons. It has a micro sleeve, round neckline and an A-line silhouette, giving it a casual yet polished look. The medium-wash denim fabric provides a vintage appeal, making it a versatile piece that can be worn with your favorite bottoms or with our matching Riri Pants | Light Denim.	100% Cotton	ALL SIZE	http://dumaofficial.com/cdn/shop/files/GIARATOPLIGHTDENIM-6.jpg?v=1740458511	f
8913121149167	Kilari Shirt | White	This crisp white button-up shirt features a modern, boxy silhouette with a mandarin collar and oversized patch pockets for a contemporary utilitarian look. The oversized fit with the perfect cropped length and structured fabric make it a versatile staple—perfect for pairing with tailored trousers or a sleek skirt for a polished ensemble.	100% Cotton	ALL SIZE	http://dumaofficial.com/cdn/shop/files/KilariShirtWhite-7.jpg?v=1741925795	f
7471328526575	Jolly Cardigan Navy	Get cozy this holiday season with our Jolly Cardigan! Knitted from soft cotton material into the perfectly elegant fit and beautifully curved hem and sleeves	100% Cotton	All Size	http://dumaofficial.com/cdn/shop/products/WhatsAppImage2021-12-07at13.42.52_2.jpg?v=1638864382	f
7946294395119	Anora Dress Red	Knitted with soft cotton yarns, this lightweight straight maxi dress comes in the perfect christmas shade. It's designed perfectly to complement all body types with its perfect silhouette. The pointed collar, button closure down the center front and micro chenille zigzag knit pattern are smart finishing touches to complete this dress. Can be styled univversally as a dress, top, or even as an outer!	100% Cotton	ALL SIZE	http://dumaofficial.com/cdn/shop/products/AnoraDressRed_2.jpg?v=1670552912	f
7455707070703	Paloma Dress Blue	Knit dress made from a slub-melange, ribbed cotton knit that is simple yet flattering. With its low round neck that accentuates the collarbone, its straight fit, side slit and midi length, this is the perfect casual dress for you! Pair it with our Arlet Top to create an effortless elegant look!	100% Cotton	ALL SIZE	http://dumaofficial.com/cdn/shop/products/Artboard74.png?v=1637737003	f
8742027264239	Iris Satin Dress | Blue	Another addition of a classic statement dress to your wardrobe, Iris Satin Dress | Blue was created by our mesmerism of the elegant Iris flower. Cut in a simple yet chic A-line silhouette with dainty straps to hold the minimalist straight neckline. Adorned with a head-turner single red flower on both sides of this silky satin dress, you can walk confidently to any event and become the talk of the town.	100% Polyester	1, 2	http://dumaofficial.com/cdn/shop/files/IRISSATINDRESSBLUE-7_61c0147f-73ca-40f8-b08a-de79d3b7917c.jpg?v=1724885584	f
8897139572975	Lori Skirt | Olive Multi	Designed in a flowy, A-line silhouette, this midi-length skirt offers a graceful and flattering fit. The knit fabric provides stretch and comfort, making it ideal for all-day wear. The balanced combination of bold and neutral tones makes it a statement piece while remaining versatile enough for both casual and semi-formal occasions. Pair it with the matching Zimma Top | Olive Multi for an effortlessly chic outfit.	100% Cotton	1, 2	http://dumaofficial.com/cdn/shop/files/LORISKIRT-3.jpg?v=1741927364	f
8196075585775	Remy Tee Black	An essential everyday fitted t-shirt, designed with a crew neck fit and a buttery soft feel. Perfect to wear alone or as a layering piece, this body-hugging tee is a must for everyone's capsule wardrobe!	90% Polyester, 10% Elastane	S, M, L	http://dumaofficial.com/cdn/shop/files/RemyTeeBlack.jpg?v=1700779467	f
8604419555567	Cosmos Throw Blanket Pink	A snuggly blanket to keep you warm and comfortable, and yet light enough for travel-ready. Printed with beautiful hand-drawn illustrations on one side and covered with simple colors at the other side, our throw blanket is an essential collection that you can take anywhere — carrying the comfort of your homy bed everywhere you go.	Made in 100% cotton and 95% TENCEL™️ fabric	ALL SIZE	http://dumaofficial.com/cdn/shop/files/CosmosPink.jpg?v=1718079741	f
8211497844975	Gala Top Red	Sculpted peplum knit top that looks like an art piece, designed specially for you this holiday season. Designed with a v-neckline and front button closure, and shaped to a fitted waist and flared peplum bottom, it is definitely one simple yet flattering piece to wear to your upcoming holiday festivities.	100% Nylon	ALL SIZE	http://dumaofficial.com/cdn/shop/files/GalaTopRed.jpg?v=1701935304	f
8665156616431	Alani Knit Dress | White	Dress of the season, this midi dress knitted from soft cotton poly blend yarns with our best selling wavy knit pattern in natural white, has an elegant halter neckline with black contrast strapline, and an A-line silhouette for a relaxed summer fit.	Cotton Poly Blend	ALL SIZE	http://dumaofficial.com/cdn/shop/files/ALANIDRESSWHITE-4.jpg?v=1720522026	f
7605186199791	Jemma Tweed Black	Tweed Jacket with subtle glitter design that creates an overall feminine and classy mood. It is designed cleanly with a no collar round neck and covered buttons. Perfect outer to be worn either casually or to elevate an outfit.	60% Wool Blend, 35% Cotton, 5% Nylon	ALL SIZE	http://dumaofficial.com/cdn/shop/products/JEMMA3.jpg?v=1648181075	f
8294592512239	ROSA | Slim Fit Crew Neck in Blue	A wardrobe staple offered in a soft blue hue, it’s crafted from soft and stretch lyocell and has a streamlined slim fit that's ideal for daily or for layering purposes.	100 % Lyocell Blend	All Size (Fit to Large)	http://dumaofficial.com/cdn/shop/files/LEN01379-edit.jpg?v=1708999772	f
8145215291631	Morris Pants Black	A staple pants that everyone needs in their capsule wardrobe. This pant is crafted from stretch premium Japanese polyester fabric and designed as a straight silhouette that taper down the legs and with ankle-length hems, finished with front patch pocket	100% Japanese made Premium Polyester	S, M, L	http://dumaofficial.com/cdn/shop/files/MorrisPantsBlack.jpg?v=1697702510	f
8843361583343	Sorrel Pants | Black	Elevate your look with these effortlessly chic high-waisted satin pants. Designed with a bias cut for a beautifully fluid drape, they feature an easy wide-leg silhouette that moves gracefully with every step. The slip-on style and elasticized waistband ensure a comfortable, flattering fit, making these pants perfect for both casual and dressy occasions. Pair them with your favorite top for a polished yet relaxed vibe.	100% Polyester	Small, Medium, Large	http://dumaofficial.com/cdn/shop/files/SORRELPANTSBLACK-2.jpg?v=1734493373	f
8289522614511	Heather Leather Dress Maroon	This mini dress is a refined take on our best selling leather. Shaped in an A-line silhouette, it's designed with a rounded neckline and side slip pockets in classic maroon hue.	100% Polyester	Small, Medium, Large	http://dumaofficial.com/cdn/shop/files/Artboard5_1.png?v=1708574557	f
8005157290223	Orca Shirt Brown	An elevated wardrobe staple, this structured short sleeve shirt is cut from a premium stretc fabric, finished with side slit, pointed flat collar, front button fastening and the perfect contouring slim fit for an effortless look. Complete the look by pairing it with our Martis flared pants for an effortless polished look.	100% Japanese made Premium Polyester	1, 2	http://dumaofficial.com/cdn/shop/products/OrcaShirtBrown.jpg?v=1677143421	f
9024429129967	Positano Cardigan | Cream	Cozy up in this crocheted cardigan, designed with a boxy fit for effortless layering and laid-back charm. Featuring pretty contrasting scallop edges, that add a modern twist to a timeless texture. Completed with front patch pockets and horn buttons that serve both as	100% Cotton	ALL SIZE	http://dumaofficial.com/cdn/shop/files/PositanoCardiganCream1.jpg?v=1753701327	f
8005223088367	Milla Vest Grey	Our Milla Vest has a looser, straight cut made from soft viscose yarns and with front button down closure. A simple, timeless piece that can be worn solo or be layered over a tank or tee as you like! Pair it with our Jetro Pants for an easy elevated daily look!	SOFT VISCOSE	ALL SIZE	http://dumaofficial.com/cdn/shop/products/MillaVestGrey-2.jpg?v=1677200003	f
8843346510063	Garland Sweater | Nutmeg	Shawl Neckline Sweater with multiple styling options, made from a mid-weight cotton knitting and featuring an intricate rib stitch. It has an oversized fit for casual sophistication. Pair it with our Sorrel satin pants for a comfortable yet stylish holiday/ airport fit.	100% Polyester	ALL SIZE	http://dumaofficial.com/cdn/shop/files/GARLANDSWEATERNUTMEG-1.jpg?v=1734424306	f
8625224155375	MICOLE | Slim Fit Crew Neck in Blue	A wardrobe staple offered in a soft blue hue, it’s crafted from soft and stretch lyocell and has a streamlined slim fit that's ideal for daily or for layering purposes.	100 % Lyocell Blend	Small, Medium	http://dumaofficial.com/cdn/shop/files/LEN-DUMA-6644-edit.jpg?v=1718842224	f
8196107469039	Brea Zip Up Sweater Black	This relaxed zip up jumper is crafted from soft rayon, twisted to create a comfy knit. The laid-back piece is completed with high ribbed neckline, dropped shoulders, ribbed waistband and loose sleeves. Pair it with our Nehru jogger Pants for the perfect airport/ lounge outfit!	100% RAYON	ALL SIZE (FIT TO XL)	http://dumaofficial.com/cdn/shop/files/BreaSweaterBlack-4.jpg?v=1700799082	f
8218757071087	Rebecca Tweed Dress Black	Join the festive season with this sparkling mini dress cut from sequin tweed. It features a halter neckline, A-line silhouette, and a row of fancy gold floral buttons. Pair it with your favorite pair of heels and some statement earrings and you're good to go to your next holiday party!	100% Polyester	1, 2	http://dumaofficial.com/cdn/shop/files/RebeccaTweedDress.jpg?v=1702537560	f
8030804115695	Nada Top Navy	A soft knitted T-shirt great fir your daily fits, with an added puffed sleeve twist. This top comes in a navy blue shade and has a wide, ribbed neckline.	Soft Viscose	All Size ( Stretchy Slim Fit )	http://dumaofficial.com/cdn/shop/products/NadaTopNavy-3.jpg?v=1680145921	f
8792566825199	Ochre Shorts | Brown	Designed with a mid-waist and tailored fit, these shorts offer a chic silhouette that transitions seamlessly from day to night. Dress it up with our matching suede jacket in warm hues, or down with a casual tee—these suede shorts are your go-to piece for stylish fall layering.	100% Polyester	1, 2Measurement :	http://dumaofficial.com/cdn/shop/files/OCHRESHORTS-1.jpg?v=1729052832	f
8792597070063	Ang T-Shirt | Nutmeg	Secure your transitional wardrobe with this staple long-sleeved mock neck top. Offered in a rich nutmeg hue, it’s crafted from soft lyocell blend and has a streamlined slim fit that’s ideal for layering.	76% Lyocell, 19% Wool, 5% Spandex	ALL SIZE (Fit to L)	http://dumaofficial.com/cdn/shop/files/ANGT-SHIRTNUTMEG-4.jpg?v=1729052304	f
7605188755695	Karie Tencel White	Soft Tencel Shirt with extended collar, v-neckline, and big flare sleeves. This top fits perfectly on any body type and pairs easily with any bottoms.	100% Tencel	ALL SIZE	http://dumaofficial.com/cdn/shop/products/KARIE2.jpg?v=1648172188	f
8110085439727	Lesley Jeans White	Denim trousers is a definite staple for your wardrobe, especially this pair as they're comfortable and fits like a glove. This pair is shaped for a flared silhouette with full-length legs and slits at cuffs that will make your legs looks super long and slim. They're crafted from a stretch cotton denim for lightness and comfort it won't feel like your wearing jeans at all!	Cotton Spandex	S, M, L	http://dumaofficial.com/cdn/shop/files/LesleyJeanWhite.jpg?v=1693808761	f
8897119682799	Zimma Top | Olive Multi	This sleeveless knit top features a chic vertical stripe pattern in shades of olive green, black, and white, creating a visually elongated silhouette. It has a flattering V-neckline with a button-down front, adding a touch of elegance and versatility. The soft, breathable knit fabric ensures comfort, while the slightly relaxed fit makes it an effortless piece for layering or wearing on its own. The subtle front slit detail enhances movement and gives a modern edge to the design.	100% Cotton	1, 2	http://dumaofficial.com/cdn/shop/files/ZIMMATOP-5.jpg?v=1740458140	f
8823407837423	MMEHUILLET FOR DUMA - Seoul Puffer | Pink	The perfect blend of warmth and versatility, Seoul Puffer features a lightweight yet insulating design, with a smooth, quilted exterior. The real highlight is the detachable knit vest inside — a chic, textured layer that provides extra warmth. Whether you’re braving the cold or layering up for a more polished outfit, this jacket offers ultimate flexibility and a pop of color to brighten your winter wardrobe.	100% Polyester	ALL SIZE	http://dumaofficial.com/cdn/shop/files/SeoulPufferPink.jpg?v=1732726571	f
8498263556335	Harper Pants Grey	Crafted from premium polyester blend suiting fabric, these baggy trousers have pleats through the front to elongate the wide legs and two button	100% Polyester	S, M, LMeasurement :	http://dumaofficial.com/cdn/shop/files/HARPERPANTSGREY-2.jpg?v=1715741368	f
8196090462447	Larra Pants Grey	The comfiest wardrobe staple, designed with our favorite ultra-soft jersey fabric. This straight-leg pant style features a stretch waistband making it comfortable to wear all day long! Wear it as a set with our Remy t-shirt for an easy travel ootd!	90% Polyester, 10% Elastane	S, M, L, XL	http://dumaofficial.com/cdn/shop/files/LarraPantsGrey.jpg?v=1700777919	f
7696639983855	Eli Top Black	Knitted from soft cotton yarns, this utterly comfy knit top will easily become a staple in every women's wardrobe. As a loungewear or for going out, this top has a very versatile style that you can pair it with any bottom you can possibly think of.	100% Cotton	ALL SIZE	http://dumaofficial.com/cdn/shop/products/eli4.jpg?v=1654770890	f
8329477685487	Florence Top Mint	The Florence top in our special brocade fabrication is a sweet addition to our collection. This silhouette is designed to be a relaxed fit with A-line body and front draped peplum detail and perfectly shaped slight halter neckline. Pair it with our Natia skirt for the perfect look!	60% Polyester, 40% Cotton	1, 2	http://dumaofficial.com/cdn/shop/files/FlorenceTopMint.jpg?v=1711026832	f
8773329977583	Sienna Top | White	Crafted from soft buttery knit blend with a fluid hand feel, this white blouse is designed with drapes, fitted sleeves, and a mock neckline. Style it with tailored skirts or trousers and kitten heels for the perfect polished look!	90% Polyester, 10% Elastane	ALL SIZE	http://dumaofficial.com/cdn/shop/files/SIENNATOPWHITE-2.jpg?v=1727772539	f
9024434340079	Bianna Dress | Khaki	PREORDER 14 WORKING DAYS A classic button-up shirt dress, but designed better and classier. Bianna Dress features a flattering pleated waist that adds graceful movement and structure to the silhouette, a piece that can transition effortlessly from work to weekend. The look is completed with a detachable vegan leather belt that cinches the waist for a defined shape. Fully-lined for comfort and free movement in any kind of occasions.	73% Polyester, 27% Nylon	ALL SIZE	http://dumaofficial.com/cdn/shop/files/BiannaDressKhaki4.jpg?v=1753853214	f
9000439841007	Andia Skirt | Black	A crochet midi skirt with a straight, clean-cut silhouette. Made from soft, breathable knit with a comfortable elastic waistband. The hem is finished with contrast hand-stitched detail for a unique, crafted touch. Easy to wear as a set with the matching top or styled on its own with simple basics.	Recycled Polyester	1, 2	http://dumaofficial.com/cdn/shop/files/ANDIASKIRTBLACK1.jpg?v=1750785805	f
7739103543535	Julian Dress Black	Knitted from very soft and elastic viscose yarns, this relaxed fit shirt dress features a straight fit and front pocket flaps for a laid-back, casual silhouette. The sleeve cuff and buttons	SOFT VISCOSE	ALL SIZE	http://dumaofficial.com/cdn/shop/products/FUNDAMENTALSRESIZEDCATALOGArtboard81.jpg?v=1657771069	f
8742005244143	Prairie Satin Dress | Black	Inspired by the sophisticated Peony flower, this dress was crafted carefully from silky smooth satin fabric. A silhouette taken from our best-selling Tropez dress that will flow and sway beautifully when it’s worn, Prairie Satin Dress | Black is the very definition of an elevated summer piece. Completed with a classic round neck cut and back slit opening, this beauty will be so easy to slip into for your special occasion.	100% Polyester	1, 2	http://dumaofficial.com/cdn/shop/files/PRAIRIESATINDRESSBLACK-5.jpg?v=1724754436	f
8665120866543	Kayla Vest Top | Small Stripe	Carefully knitted with the classic tailoring principle to achieve the silhouette of this waistcoat. Stripe knit pattern that is perfect for the summertime, complemented with the perfect halter neck design and beautifully contoured waist, completed with front button fastenings and welt pocket flap designs. A classic piece that will complement your body really well!	Cotton Poly Blend	1, 2	http://dumaofficial.com/cdn/shop/files/KAYLAVESTTOP_SMALLSTRIPE_-6.jpg?v=1720522250	f
8792586879215	Suade Dress | Brown	Crafted from soft suede, this dress offers a sleek silhouette that effortlessly combines elegance and comfort. The rich, earthy tones are perfect for the season, while the sleeveless design makes it ideal for layering. Cut to a straight fit that flatters all body types, with clean lines to ensure a sophisticated, modern look. Completed with a thin belt for versatile styling and functional side pockets.	100% Polyester	ALL SIZEMeasurement :	http://dumaofficial.com/cdn/shop/files/SUADEDRESSBROWN-4_6d8c3518-3dc9-467f-bd8c-dd2ae2c31528.jpg?v=1729137574	f
8959305777391	Sienna Ease Top | Burgundy	Crafted from soft buttery knit blend with a fluid hand feel, this burgundy blouse is designed with drapes, fitted sleeves, and a mock neckline. Style it with tailored skirts or trousers and kitten heels for the perfect polished look!	95% Polyester, 5% Elastane	ALL SIZE	http://dumaofficial.com/cdn/shop/files/SIENNAEASEBURGUNDY-6.jpg?v=1747875489	f
8959266095343	Quinn Top | Beige	This sleeveless top features a sharp tailored collar and a clean front with a hidden side zipper. The standout detail is its open back with a soft, sculptural drape, adding a bold yet elegant touch. Easy to dress up or down, it pairs perfectly with tailored pants or a sleek skirt for a modern, refined look.	100% Japanese made Premium Polyester	ALL SIZE	http://dumaofficial.com/cdn/shop/files/QUINNTOPBEIGE-5.jpg?v=1747881264	f
8294596313327	ROSA | Slim Fit Crew Neck in Beige	A wardrobe staple offered in a neutral beige hue, it’s crafted from soft and stretch lyocell and has a streamlined slim fit that's ideal for daily or for layering purposes.	100 % Lyocell Blend	All Size (Fit to Large)	http://dumaofficial.com/cdn/shop/files/LEN01084-edit.jpg?v=1709002771	f
8959788941551	Lerro Cardigan | Black	Black knit cardigan features a clean and relaxed silhouette. The sleeves have subtle gathers to add volume, while the V-neck front is finished with unique leather buttons. A versatile piece for effortless layering — easy to pair with any bottoms.	Soft Viscose	ALL SIZE	http://dumaofficial.com/cdn/shop/files/LERROCARDIGAN-1.jpg?v=1747798857	f
8081767465199	Kano Set Tosca	Our cropped cardigan and adjustable tank top set is a seasonless essential that can be worn as a set or separates. Lightweight knitwear pieces, with point collar and button front fastening cardigan, completed with an adjustable strap basic tanktop. Perfect for any look you're going for any time of day!	100% Cotton	1, 2	http://dumaofficial.com/cdn/shop/files/KanoSetTosca2.png?v=1688954844	f
7455630426351	Arlet Top Red	Knit top made from a slub-melange, ribbed cotton knit that is feminine and attractive. With its long, flared out sleeves that covers the palm of our hand, its V-neckline cut that accentuate one's collarbone and its cropped, straight fit, this top screams elegance and comfort in the most perfect way. Our Arlet Top can be styled in so many different ways; as a top or as a cardigan! Pair it with our Jola Pants for a casual look, or our Paloma Dress for a more sophisticated look.	100% Cotton	All Size	http://dumaofficial.com/cdn/shop/products/Artboard46_e0c2bdf2-d4ac-48f5-9430-7d04eac8d0b8.png?v=1637746962	f
8060384837871	Nehru Jogger Pants White	These jogger-style off white trousers are made from finely knitted soft rayon. A relaxed fit that taper slightly towards the ribbed hem, and with a comfortable elasticated waist for all day wear. Complete the look with our Brea Zip Up sweater.	100% RAYON	ALL SIZE (FIT TO XL)	http://dumaofficial.com/cdn/shop/files/NehruJoggerPantsWhite.jpg?v=1685003550	f
7946296885487	Ansel Cardigan Camel	Knitted from soft viscose yarns, this V-neck cardigan is designed for a regular fit and features a subtly nipped-in waist. It has modern tubular trims, finished with front button closure and ribbed cuffs and hems. The perfect luxurious loungewear you need in your wardrobe!	Soft Viscose	All Size	http://dumaofficial.com/cdn/shop/products/AnselCardiganCamel_Edited.jpg?v=1670560963	f
8913120493807	Balestra Skirt | Black	This black maxi skirt features a high-waisted design with a wide, fitted bustier style waistband that accentuates the silhouette. The flowing, gathered fabric creates a graceful and elegant look, making it perfect for both casual and dressy occasions. Its versatile style pairs well with various tops for effortless styling.	Poly Blend	Small, Medium, Large	http://dumaofficial.com/cdn/shop/files/BalestraSkirtBlack-2.jpg?v=1741926124	f
8269638762735	Rebecca Tweed Dress Pink	Join the season of love with this sparkling mini dress cut from sequin tweed. It features a halter neckline, A-line silhouette, and a row of fancy gold floral buttons. Pair it with your favorite pair of heels and some statement earrings and you're good to go on your special date night!	100% Polyester	1, 2	http://dumaofficial.com/cdn/shop/files/RebeccaTweedDressPink.jpg?v=1707102219	f
8294597918959	ROSA | Slim Fit Crew Neck in Pink	A wardrobe staple offered in a subtle pink hue, it’s crafted from soft and stretch lyocell and has a streamlined slim fit that's ideal for daily or for layering purposes.	100 % Lyocell Blend	All Size (Fit to Large)	http://dumaofficial.com/cdn/shop/files/LEN01428-edit.jpg?v=1709004647	f
8818180620527	Ang T-Shirt | White	Secure your transitional wardrobe with this staple long-sleeved mock neck top. Offered in a white tone, it’s crafted from soft lyocell blend and has a streamlined slim fit that’s ideal for layering.	76% Lyocell, 19% Wool, 5% Spandex	ALL SIZE (Fit to L)	http://dumaofficial.com/cdn/shop/files/AngT-ShirtWhite-2.png?v=1731576624	f
7455655362799	Jola Pants Black	A must-have pant made of slub-melange, ribbed cotton knit, perfect for going out or lounging around. Featuring a mid-rise, cropped length, and straight fit, perfect for a casual, everyday look. Pair it with our Piccolo Top or a simple white shirt and you're ready to get going!	100% Cotton	All Size ( Fit to Large )	http://dumaofficial.com/cdn/shop/products/Artboard8_1347b6c0-0967-4247-b5cd-e1b38f240258.png?v=1637736541	f
8307519521007	Peony Top Pink	Inspired by the blossoming of flowers, this knit top is made with structured flounce hem detail that gives off a playful elegance. Knitted from soft cotton yarns in the perfect pink shade, it is shaped into a contoured fit body and blooming hem.	100% Cotton	ALL SIZE	http://dumaofficial.com/cdn/shop/files/PeonyTopPink-6.jpg?v=1710230023	f
8843350245615	Peony Top | Maroon	Inspired by the blossoming of flowers, this knit top is made with structured flounce hem detail that gives off a playful elegance. Knitted from soft cotton yarns in the perfect maroon shade, it is shaped into a contoured fit body and blooming hem.	100% Cotton	ALL SIZE	http://dumaofficial.com/cdn/shop/files/PEONYTOPMAROON-1_bcb7c8c6-bd18-4d7b-8094-178017910b2d.jpg?v=1736935846	f
8792612241647	Jennie Tanktop | Olive	An essential for your daily wardrobe, especially those warmer days. Offered in a rich olive hue, it’s crafted from soft lyocell blend and has a streamlined slim fit with endless styling opportunities - wear it alone or layered under shirts and blazers.	76% Lyocell, 19% Wool, 5% Spandex	ALL SIZE (Fit to L)	http://dumaofficial.com/cdn/shop/files/JENNIETANKTOPOLIVE-3.jpg?v=1729052555	f
9024408715503	Agea Top | Cream	Classic but memorable. An A-line cut top in smooth and luxurious fabric that enhances its minimalist appeal. Designed with a clean round neckline and halter cut, Agea is a versatile top that can be worn in any kind of occasions – be it a casual brunch with the girls or a long-awaited dinner date. Pair this flowy piece with our best-selling Tan Pants for a chic, matching set look.	100% Polyester	1, 2	http://dumaofficial.com/cdn/shop/files/AgeaTopCream3.jpg?v=1753853466	f
7455707791599	Paloma Dress Red	Knit dress made from a slub-melange, ribbed cotton knit that is simple yet flattering. With its low round neck that accentuates the collarbone, its straight fit, side slit and midi length, this is the perfect casual dress for you! Pair it with our Arlet Top to create an effortless elegant look!	100% Cotton	ALL SIZE	http://dumaofficial.com/cdn/shop/products/Artboard53_63ace701-43ca-4588-88b5-96269442df3b.png?v=1637770545	f
8842757177583	Hoho Sweater | Maroon Multi	Stay festive and comfortable this season with our fair-isle sweater in intricate Christmas jacquard motif and the perfect oversized fit. Comes in two colors, it’s the prefect pick for family gatherings, or twinning with someone special this holiday season.	100% Cotton	ALL SIZE	http://dumaofficial.com/cdn/shop/files/HOHOSWEATERMAROONMULTI-1.jpg?v=1734424632	f
7975353712879	Maesa Cardigan Black	Pattern Knit Cardigan with black lis detail all around and front button down. With slightly cropped and straight boxy silhouette, this cardigan is perfect to level up your monochromatic daily look. You can also easily create an effortlessly elegant look by pairing it with out Trompa mini skirt.	100% COTTON	All Size	http://dumaofficial.com/cdn/shop/products/MaesaCardiganBlack.jpg?v=1673496079	f
7740271165679	Darcie Top White	Knitted from soft cotton yarns, this v-neck top has a flattering curved yet relaxed fit and femine ruffle	100% COTTON	All Size	http://dumaofficial.com/cdn/shop/products/FUNDAMENTALSRESIZEDCATALOGArtboard18.jpg?v=1657767372	f
8295196754159	RACHEL | Slim Fit Scoop Neck in Black	A wardrobe staple offered in classic black, it’s crafted from soft and stretch lyocell and has a streamlined slim fit and flattering scoop neckline that's ideal for your everyday wear.	100 % Lyocell Blend	Small, Medium	http://dumaofficial.com/cdn/shop/files/LEN-DUMA-6850-edit.jpg?v=1718841949	f
8604127068399	Daffodil Girl Pajamas Pink	A reversible set of pajamas made in 100% cotton. With a spread of beautiful blooms all over the scallop collar and frill hem	Made in 100% cotton	1, 2, 3, 4	http://dumaofficial.com/cdn/shop/files/DaffodilPJPink-4.jpg?v=1718097850	f
8329452749039	Rowa Pants Denim Blue	Denim pants cut from stretch denim fabric washed into the perfect cool blue shade, this pants is designed with a high-rise, full length, and the perfect flared fit finished with front and back pockets. Pair it with our Danica top for a chic denim-on-denim look!	100% Cotton	S, M, L	http://dumaofficial.com/cdn/shop/files/RowaPantsDenimBlue_ff3c58a0-bca1-44d0-bc14-81da379465aa.jpg?v=1711037434	f
8145540219119	Ford Top Olive	This ribbed shirt is crafted with soft and breathable rayon yarn, shaped for a feminine and slimming silhouette, and offered in unique olive shade. It’s designed with a pointed collar, special shell buttons, long sleeves and the perfect cropped length.	90% Rayon, 10% Polyamide	All Size	http://dumaofficial.com/cdn/shop/files/FordTopOlive.jpg?v=1697785585	f
8145529307375	Lancet Crop Shirt White	This shirt is our take of a wardrobe staple. Crafted from soft and breathable white Tencel fabric, it’s cut for a relaxed fit with classic pointed collar and subtly statement front pockets. The cropped length will pair perfectly with any high-waisted pants.	100% Tencel	All Size	http://dumaofficial.com/cdn/shop/files/LancetShirtWhite.jpg?v=1697785610	f
8792581144815	Suade Dress | Sand	Crafted from soft suede, this dress offers a sleek silhouette that effortlessly combines elegance and comfort. The rich, earthy tones are perfect for the season, while the sleeveless design makes it ideal for layering. Cut to a straight fit that flatters all body types, with clean lines to ensure a sophisticated, modern look. Completed with a thin belt for versatile styling and functional side pockets.	100% Polyester	ALL SIZEMeasurement :	http://dumaofficial.com/cdn/shop/files/SUADEDRESSSAND-5_93750e94-c2b7-47dc-9c1e-3ea9264d054b.jpg?v=1729137718	f
8498656149743	Tilda Shorts White	A timeless classic silhouette shorts designed to fit all kinds. Offered in classic white, they have a comfortable high waist that falls to an A-line shape for both comfort and a flattering cut, and short hemlines to create a leg-lengthening effect. Perfect match to all your tops!	100% Polyester	S, M, L	http://dumaofficial.com/cdn/shop/files/TILDASHORTSWHITE-5.jpg?v=1720601012	f
9024412516591	Tan Pants | Cedar	Elevate your look with these effortlessly chic high-waisted satin pants. Designed with a bias cut for a beautifully fluid drape, they feature an easy wide-leg silhouette that moves gracefully with every step. The slip-on style and elasticized waistband ensure a comfortable, flattering fit, making these pants perfect for both casual and dressy occasions. Pair them with your favorite top for a polished yet relaxed vibe.	100% Polyester	Small, Medium, Large	http://dumaofficial.com/cdn/shop/files/TanPantsCedar1.jpg?v=1753698011	f
9000438857967	Thasa Dress | Black	This halter-neck black midi dress features a clean, minimalist silhouette. Crafted from a silky satin-finish fabric, it drapes beautifully on the body, creating a flattering and timeless look. The back is secured with a delicate button closure. Can be worn on its own for a effortless statement or styled with an outer layer for a more layered, contemporary feel—perfect for both day and night occasions.	100% Polyester	1, 2	http://dumaofficial.com/cdn/shop/files/THASADRESSBLACK1.jpg?v=1750785844	f
8030801264879	Voyage Blazer Navy	Knitted from soft cotton yarns, this double-breasted stripes knit cardigan has a classic blazer collar, straight fit, front pockets and covered buttons. This blazer style knit cardigan is a classic wardrobe staple to carry you through different seasons over the years!	100% COTTON	ALL SIZE	http://dumaofficial.com/cdn/shop/products/VoyageBlazerNavy-2.jpg?v=1680151991	f
8773339513071	Kairi Top | Black	Crafted from soft buttery knit blend with a fluid hand feel, this asymmetrical blouse is designed with drapes, fitted sleeves, and one shoulder silhouette. Style it with tailored skirts or trousers and kitten heels for the perfect fall outfit!	90% Polyester, 10% Elastane	ALL SIZE	http://dumaofficial.com/cdn/shop/files/DE8B88EE-6D98-4814-A9CA-E55EB0D5D347.jpg?v=1727768404	f
9000475689199	Eve T-shirt | White	PREORDER 25 WORKING DAYS A classic everyday T-shirt, offered in white. Designed with a classic crew neckline and a flattering straight cut, this top is crafted from a silky-soft rayon blend with a touch of stretch for maximum comfort and versatility. The clean silhouette hits at the ideal length to pair with just about anything.	56,5% Rayon, 31,2% Polyamide, 12,3% Spandex	Small, Medium	http://dumaofficial.com/cdn/shop/files/EVET-SHIRTWHITE5.jpg?v=1750852564	f
8498254676207	Pragh Skirt Navy Stripe	Focusing on classic tailoring, this midi skirt is crafted from premium polyester blend suiting fabric and precisely cut in a slim, straight silhouette that perfectly elongates the figure. Finished with back invisible zipper opening, two front welt pockets, and back slit for easy walking.	100% Polyester	S, M, LMeasurement :	http://dumaofficial.com/cdn/shop/files/PRAGHSKIRTNAVYSTRIPE-1.jpg?v=1715599974	f
8005217485039	Milla Vest Camel	Our Milla Vest has a looser, straight cut made from soft viscose yarns and with front button down closure. A simple, timeless piece that can be worn solo or be layered over a tank or tee as you like! Pair it with our Jetro Pants for an easy elevated daily look!	SOFT VISCOSE	ALL SIZE	http://dumaofficial.com/cdn/shop/products/MillaVestCamel-3.jpg?v=1677200093	f
7946306486511	Darcie Top Maroon	Knitted from soft cotton yarns, this v-neck top has a flattering curved yet relaxed fit and femine ruffle	100% COTTON	All Size	http://dumaofficial.com/cdn/shop/products/DarcieTopMaroon_3.jpg?v=1670331546	f
7946287939823	Anora Dress Grey	Knitted with soft cotton yarns, this lightweight straight maxi dress comes in the perfect monochrome shade. It's designed perfectly to complement all body types with its perfect silhouette. The pointed collar, button closure down the center front and micro chenille zigzag knit pattern are smart finishing touches to complete this dress. Can be styled univversally as a dress, top, or even as an outer!	100% Cotton	ALL SIZE	http://dumaofficial.com/cdn/shop/products/AnoraDressGrey_3.jpg?v=1670553320	f
8986668531951	Verra Top | Olive	This top features soft drapes across the front that create a flattering, elegant shape. It’s designed with shoulder padding to give structure and a bold silhouette. The added buttoned shoulder detail gives it a modern, tailored touch. A perfect mix of strong and feminine.	100% Polyester	Small, Medium, Large	http://dumaofficial.com/cdn/shop/files/VERRATOPOLIVE1.jpg?v=1750786069	f
8742172721391	Fleur Satin Top | Black	A piece to remember, this halter-neck satin top with an easy A-line fit is casual but not basic. Sewn carefully from silky smooth satin fabric and completed with dainty neck straps opening, Fleur Satin Top | Black is the kind of piece you would reach out to for that long-awaited summer getaway. With a beautiful Peony flower as the cherry on top, you will most definitely be the trend-setter of the season.	100% Polyester	1, 2	http://dumaofficial.com/cdn/shop/files/FLEURSATINTOPBLACK-4.jpg?v=1724754340	f
8959789039855	Rue Dress | Black	A minimalist sleeveless A-line mini dress featuring a sharp V-neckline and structured collar. Crafted in a clean fabric, it offers a tailored silhouette that flatters the upper body and gently flares out towards the hem. This piece combines modern sophistication with timeless appeal—perfect for styling with boots, heels, or layering under outerwear.	100% Japanese made Premium Polyester	ALL SIZE	http://dumaofficial.com/cdn/shop/files/RUEDRESSBLACK-2.jpg?v=1747788019	f
7823893364975	Haylee Skort Denim	Mid-Waist Skort with inner shorts and skirt style overlay, cut from soft rayon fabrin in the perfect denim hue. Feminine and Chic silhouette with V-cut waist that gives a sinched waist figure. Pair it with our Gigi Crop Top to build a clean and stylish outfit in seconds!	70% Rayon, 30% Polyester	SMALL, MEDIUM	http://dumaofficial.com/cdn/shop/products/haylee2.jpg?v=1662687536	f
8498257625327	Pragh Skirt Grey	Focusing on classic tailoring, this midi skirt is crafted from premium polyester blend suiting fabric and precisely cut in a slim, straight silhouette that perfectly elongates the figure. Finished with back invisible zipper opening, two front welt pockets, and back slit for easy walking.	100% Polyester	S, M, LMeasurement :	http://dumaofficial.com/cdn/shop/files/PRAGHSKIRTGREY-4.jpg?v=1715741448	f
8329466183919	Ara Dress White	Our Ara dress is designed with a laid back silhouette, perfect for attending your Ramadhan festivities, our to use for everyday styling. Crafted from our special lace brocade, this dress is a free flowing piece, featuring front button openings and accentuated sleeves, and includes an inner cotton dress.	100% Polyester	ALL SIZE	http://dumaofficial.com/cdn/shop/files/AraDressWhite.jpg?v=1711026686	f
8329482731759	Natia Skirt Mint	An elegant addition to the collection, our Natia Midi Skirt is designed with box pleats that sinches the waist perfectly and falls to a fuller, volumous skirt. Our special brocade fabrication adds an extra tecture to this structured style, midi length and hidden zipper help polished off this silhouette. Pair it with our matching Florence top for the perfect look!	60% Polyester, 40% Cotton	1, 2	http://dumaofficial.com/cdn/shop/files/NatiaSkirtMint-2.jpg?v=1711073392	f
8742218367215	Olga Skirt | Black	Are you searching for a skirt that would hug your body comfortably and flatteringly? Say no more, Olga Skirt | Black is here for your daily need of a versatile bottom that’s not only easy to wear, but also stylish. Crafted from a soft and stretchy fabric in an ankle-length fit, this skirt elongates your silhouette, all the while allowing you to move freely.	90% Polyester, 10% Elastane	Small, Medium, Large	http://dumaofficial.com/cdn/shop/files/OLGASKIRTBLACK-3.jpg?v=1724753586	f
9024381223151	Kyma Top | Black	Effortless and easy to wear, this breezy sleeveless top is crafted from breathable, lightweight linen – perfect for warm-weather days. Designed with a relaxed, loose fit for all-day comfort, it features a flattering V-neckline adorned with pretty ruffles, adding a touch of feminine charm. Wear it with your favorite pair of jeans or our matching Sante Pants for a chic, cruise-ready look.	100% Linen	Small, Medium, Large	http://dumaofficial.com/cdn/shop/files/KymaTopBlack5.jpg?v=1753853816	f
8211261653231	Esther Ruffle Cardigan White	Our special ribbed cardigan that is designed with a v-neckline and front button closure and shaped for a streamlined slim fit and ruffle	85% Raylon, 10% Polyester, 5% Nylon	ALL SIZE (FIT TO L)	http://dumaofficial.com/cdn/shop/files/EstherRuffleCardiWhite.jpg?v=1701935735	f
8101854544111	Kano Set Navy	Our cropped cardigan and adjustable tank top set is a seasonless essential that can be worn as a set or separates. Lightweight knitwear pieces, with point collar and button front fastening cardigan, completed with an adjustable strap basic tanktop. Perfect for any look you're going for any time of day!	100% Cotton	1, 2	http://dumaofficial.com/cdn/shop/files/DAN-20230615-DUMA-1158.jpg?v=1692594514	f
8211451150575	Glacer Leather Skirt Silver	Headline your party season outfits with this metallic mini skirt! It's crafted from high quality silver leather and designed with simple a-line silhouette and hidden side zipper. Complement this special mini by styling it with our metallic knit pieces.	100% Polyester	S, M, L	http://dumaofficial.com/cdn/shop/files/GlacerSkirtSilver.jpg?v=1701935568	f
8117392638191	Bahia Outer Navy	Knitted from pure cotton yarns shaped for a classic fit with a cropped hem that works particularly well with any bottoms you have. It has a close round neck, Hand stitching patch pocket	100% Cotton	ALL SIZEMeasurement :	http://dumaofficial.com/cdn/shop/files/LEN03038-editcopy.jpg?v=1695367682	f
8116765851887	Galena Cardigan Black	This V-neck cardigan is knitted from customer's all time favorite soft viscose yarns. Designed for a contoured fit, it has neat ribbed trims and fasted with a row of horn buttons for a sleek finish. It's most definitely a wardrobe essential that will stay with you for a very long time.	Soft Viscose	All Size	http://dumaofficial.com/cdn/shop/files/GalenaCardiBlack-3.jpg?v=1695006788	f
8196237132015	Rowan Blazer Brown	A classic tailoring piece crafted from premium Japanese polyester fabric, this blazer features a boxy fit, single-breasted silhouette, peak lapels, pocket at front, and front button closure. Perfect to throw on any day over your simple basics to elevate the look in seconds.	100% Japanese made Premium Polyester	1, 2	http://dumaofficial.com/cdn/shop/files/RowanBlazerBrown.jpg?v=1700779616	f
8107687051503	Cola Polo Top Navy	An elevated wardrobe staple, this contoured short sleeve polo shirt is cut from premium stretch fabric, finished with fancy gold buttons, pointed flat collar, and the perfect contouring slim fit for an effortless look, offered in timeless navy shade.	100% Japanese made Premium Polyester	All Size	http://dumaofficial.com/cdn/shop/files/ColaTopNavy.jpg?v=1693804592	f
8329441050863	Freya Set Blue	A perfect set consisting of a cropped shirt and voluminous midi skirt, in a cool blue shade. The cropped shirt is designed with a puffed sleeves and boxy fit, finished with concealed front buttons. The skirt is shaped in an A-line silhouette with a corset waist detail that contours the waist perfectly and a concealed zip closure.	100% Cotton	1, 2	http://dumaofficial.com/cdn/shop/files/FreyaSetBlue.jpg?v=1711026966	f
8825023037679	MMEHUILLET FOR DUMA - Daon Top | White	A must-have piece to add to your capsule wardrobe, Daon Top is the very definition of everyday wear. Knitted from soft yarns into a unique crochet texture, this piece blends both comfort and style into a loose, but flattering fit in neutral color palette. Adorn it with our clip-on rhinestone buttons for a more elevated look that can easily transition from day to night.	100% Polyester	1, 2	http://dumaofficial.com/cdn/shop/files/DaonTopWhite-6.jpg?v=1732724492	f
8037959925999	Yanza Dress Pink	In efforts of combining the comfort of knits, the elegance of printed silk, and unrestricted silhouette, we've created this dress for all the women out there. Long sleeve midi dress with basic crew neck, soft cotton knit and lustrous satin fabric combination, loose relaxed fit, slit on hem. Perfect for an easy throw on outfit!	Knit: 100% CottonPrint Fabric: 100% Polyester	ALL SIZE	http://dumaofficial.com/cdn/shop/products/YanzaPink1.jpg?v=1681273723	f
8252030943471	Mona Blazer Red	This blazer of ours was perfectly crafted seamlessly, combining contemporary and timeless tailoring elements. Featuring a traditional silhouette, it is perfected with peak lapels, flapped pockets, and waist- shaping darts for a sophisticated look. Comes in red, this is perfect to throw on over your CNY outfit. Model : 175 cm	100% Japanese made Premium Polyester	ALL SIZE	http://dumaofficial.com/cdn/shop/files/MonaBlazerRed.jpg?v=1706001620	f
9000428863727	Perr Jacket | Khaki	This jacket features a clean, minimalist silhouette with subtle utility	100% Japanese made Premium Polyester	ALL SIZE	http://dumaofficial.com/cdn/shop/files/PERRJACKETKHAKI6.jpg?v=1750835738	f
7823908372719	Jimi Shirt Blue	Boxy cut shirt knitted from soft cotton yarns in a fresh blue-ish ue pattern. The Perfect mix of feminine and boyish look. Comfortable to wear, easy to style. From bikini cover-up to workwearm this shirt will be your new favorite grab-and-go kinda top!	100% Cotton	All Size	http://dumaofficial.com/cdn/shop/products/jimi3.jpg?v=1663292247	f
7975350173935	Jetro Pants Orange	Flowing, straight-cut knit pants made from soft viscose yarn, this pants definitely call for sophisticated working-from-home (or anywhere) luxurious loungewear. Just the perfect thing for you when you want to feel pulled together. Pair it with our Ansel Cardi for a complete upscale loungewear look!	Soft Viscose	All Size	http://dumaofficial.com/cdn/shop/products/JetroPantsOrange.jpg?v=1673497290	f
8843359191279	Bruni Top | Black	Channeling a modern refinement, this classic black top is crafted from premium Japanese polyester that’s soft and stretchy. It’s cut in an oversized shape with a bias-cut scarf detail to fasten around your neck or drape it effortlessly over your shoulder.	100% Japanese made Premium Polyester	ALL SIZE	http://dumaofficial.com/cdn/shop/files/BRUNITOPBLACK-2.jpg?v=1734484628	f
8145104994543	Frank Cropped Blazer Dark Olive	Crafted from premium Japanese polyester, this single-breasted blazer in chic dark olive, is expertly tailored with defined padded shoulders, folded over wide sleeves, and the perfect cropped length. Highlight the ultra cropped length by styling it with our Harlow pants.	100% Japanese made Premium Polyester	All Size	http://dumaofficial.com/cdn/shop/files/FrankCroppedBlazerOlive-4.jpg?v=1697697700	f
8196244504815	Maray Vest Top Brown	Inspired from traditional suiting, we designed this vest with a v-neckline, adjustable belt tab, and a row of tonal buttons into the perfect fit. Style it with our Vesper pants as a set, or with your favorite maxi skirts or jeans.	100% Japanese made Premium Polyester	1, 2	http://dumaofficial.com/cdn/shop/files/MarayVestBrown.jpg?v=1700778817	f
8625234739439	MICOLE | Slim Fit Crew Neck in Navy	A wardrobe staple offered in classic navy, it’s crafted from soft and stretch lyocell and has a streamlined slim fit that's ideal for daily or for layering purposes.	100 % Lyocell Blend	Small, Medium	http://dumaofficial.com/cdn/shop/files/LEN-DUMA-6893-edit.jpg?v=1718842415	f
8145602543855	Ripa Top Beige	Made from ribbed cotton yarn with a touch of stretch, this slim-fit top is an essential for your capsule wardrobe. It has endless styling possibilities, and the cut-out design gives it an extra edge and unique point to your outfit.	100% Cotton	1, 2	http://dumaofficial.com/cdn/shop/files/RipaTopBeige.jpg?v=1697775925	f
8196136599791	Oslo Blazer Black	This cropped blazer is crafted with both the perfect silhouette and style, and the most delicate tailoring. Crafted from premium Japanese polyester, it's cut in an oversized boxy shape that's enhanced by the lightly padded shoulders. Additional	100% Japanese made Premium Polyester	ALL SIZE (FIT TO L)	http://dumaofficial.com/cdn/shop/files/OsloBlazerBlack-3.jpg?v=1700779133	f
9000450851055	Oso Pants | Black	Tailored in a clean straight cut, feature front patch pockets and a rectangular buckle belt. Crafted from a structured fabric for a polished silhouette, offer a modern, utilitarian update to classic tailoring. Effortlessly versatile, can be paired with anything from relaxed knits to sharp shirting.	100% Japanese made Premium Polyester	Small, Medium, Large	http://dumaofficial.com/cdn/shop/files/OSOPANTSBLACK1.jpg?v=1750785659	f
7946311041263	Priya Shorts Green	Knitted from soft cotton yarns into the perfect christmas color pointelle knit pattern, this easy pull-on shorts styles perfectly with any clothing piece you can think of! Pair it with our Rami Cardigan to make you look effortlessly chic for a cozy get together this holiday season!	100% Cotton	ALL SIZE	http://dumaofficial.com/cdn/shop/products/PriyaShortsGreen.jpg?v=1670331275	f
7696629530863	Calya Cardigan Grey	Our Calya Knitted Cardigan will definitely be your new favorite on the go outer! Soft and comfy, this cardigan will be the perfect company for your daily errands, office attire, or even to hang out and chill with friends! Pair it with our Petra shorts as a set for a lazy day outfit, or our Toja pants for a more put-together casual look!	100% Cotton	All Size	http://dumaofficial.com/cdn/shop/products/calya10.jpg?v=1654826494	f
7455664865519	Jola Pants Red	A must-have pant made of slub-melange, ribbed cotton knit, perfect for going out or lounging around. Featuring a mid-rise, cropped length, and straight fit, perfect for a casual, everyday look. Pair it with our Piccolo Top or a simple white shirt and you're ready to get going!	100% Cotton	All Size ( Fit to Large )	http://dumaofficial.com/cdn/shop/products/Artboard41_c9e9af9f-ec69-4fd1-9a75-dccf3258bfc3.png?v=1637736585	f
8792600543471	Ang T-Shirt | Maroon	Secure your transitional wardrobe with this staple long-sleeved mock neck top. Offered in a chic maroon tone, it’s crafted from soft lyocell blend and has a streamlined slim fit that’s ideal for layering.	76% Lyocell, 19% Wool, 5% Spandex	ALL SIZE (Fit to L)	http://dumaofficial.com/cdn/shop/files/ANGT-SHIRTMAROON-2_3bc6e297-9aa6-4dcf-874a-712b22761271.jpg?v=1729131193	f
8842759536879	Garland Sweater | Dark Brown	Shawl Neckline Sweater with multiple styling options, made from a mid-weight cotton knitting and featuring an intricate rib stitch. It has an oversized fit for casual sophistication. Pair it with our Sorrel satin pants for a comfortable yet stylish holiday/ airport fit.	100% Polyester	ALL SIZE	http://dumaofficial.com/cdn/shop/files/GARLANDSWEATERDARKBROWN-1.jpg?v=1734424401	f
8984622891247	Selna Tweed Vest | White Multi	A classic oversized tweed vest that features a fun, modern twist with its relaxed silhouette and frayed finish. Made from premium textured tweed, Selna Tweed Vest is a versatile piece that can be worn both as a top and an outer. Its neat tailoring and lining highlight this vest’s premium craftsmanship that makes it all the more timeless.	Poly Blend	ALL SIZEMeasurement :	http://dumaofficial.com/cdn/shop/files/SELNATWEED-1.jpg?v=1750314105	f
7571098894575	Massey Cardigan | Sorbet Tone	Knitted from soft cotton yarns, this oversized fit cardigan is perfect for your daily look! Completed with front button openings, Black ripped bands and the perfect color combination, this is the perfect outer for you to spice up your monochromatic outfit.	100% Cotton	ALL SIZE	http://dumaofficial.com/cdn/shop/products/Artboard70_9073e55e-d104-40bb-91bb-50c8a4dd6ef0.png?v=1645670128	f
8959791071471	Elene Skirt | Beige	High-waisted midi skirt featuring a structured A-line silhouette. Designed with a subtle front flap overlay and an off-center button closure for a modern twist on a classic shape. Made from smooth, medium-weight fabric that drapes beautifully for a flattering fit—perfect for both casual and polished looks.	100% Japanese made Premium Polyester	Small, Medium	http://dumaofficial.com/cdn/shop/files/ELENESKIRTBEIGE-7.jpg?v=1747787723	f
8076514394351	Kano Set Pink	Our cropped cardigan and adjustable tank top set is a seasonless essential that can be worn as a set or separates. Lightweight knitwear pieces, with point collar and button front fastening cardigan, completed with an adjustable strap basic tanktop. Perfect for any look you're going for any time of day!	100% Cotton	1, 2	http://dumaofficial.com/cdn/shop/files/KanoSetPink.jpg?v=1687759107	f
8860261515503	Luna Cardigan Top | Maroon	Combining comfort and charm, we gave this soft, buttery viscose cardigan our own special touch. Adorned with delicate floral appliqués with snap buttons that add its feminine appeal, and completed with slightly volumized sleeves that give a flattering contrast to its cinched waist. Luna Cardigan Top is both pretty and easy to wear all-day long to your red bao hunting sessions (or any event, really).	Soft Viscose	ALL SIZE	http://dumaofficial.com/cdn/shop/files/LUNACARDIGANTOPMAROON-2.jpg?v=1736900179	f
8218791477487	Glacer Leather Skirt Blue	Headline your party season outfits with this leather mini skirt! It's crafted from high quality faux leather and designed with simple A-line silhouette and hidden side zipper. Complement this special mini by styling it with our holiday collection tops!	100% Polyester	S, M	http://dumaofficial.com/cdn/shop/files/GlacerSkirtBlue-2.jpg?v=1702572229	f
8860267315439	Geum Top | Red Multi	Make a statement in this charming knitted top with intricate red floral jacquard. The soft, lightweight cotton yarns ensure a comfortable fit, while the short, slightly puffed sleeves balance out its cropped, relaxed fit. The floral patterns were carefully knitted, creating a textured look that pairs beautifully with both casual and dressy outfits. Whether styled with high-waisted trousers or a flowing skirt, this top is perfect to uniquely elevate your outfit.	100% Cotton	1, 2	http://dumaofficial.com/cdn/shop/files/GEUMTOP-2.jpg?v=1736913732	f
8196312072431	Anders Knit Set Black	Elevate your downtime/travel wardrobe with our Anders knit set. Crafted from soft and stretchy rayon and shaped for an easy-going and minimalistic silhouette. Regular fit cardigan top with a neat flat collar, and stretch rib waistband and relaxed fit pants.	92% Rayon, 8% Nylon	ALL SIZE (FIT TO L)	http://dumaofficial.com/cdn/shop/files/AndersKnitSet.jpg?v=1700777409	f
8294588940527	JANICE | Clean Cut Two Tone	Crafted from a special cotton blend that’s soft to the touch, this short sleeve top is cut for a close fit with the perfect length and contrasting neck and sleeve hem.	100 % Cotton Blend	All Size (Fit to Large)	http://dumaofficial.com/cdn/shop/files/Untitled-1Artboard7_12bd0263-daec-41ed-a589-70ae15db2c09.jpg?v=1709003052	f
7571084181743	Bagnu Skirt Dark Blue	Pleated Rayon Denim Skirt with a classic and modern silhouette. The pleats dart will make one’s body line looks slim, and the restrained pleats give a luxurious feeling. Completed with side zipper fastening, knee-covering length, and A-line silhouette. This skirt is definitely easy to style with any top and creates an elegant look effortlessly in no time!	70% Rayon, 30% Polyester	S-M , M-L	http://dumaofficial.com/cdn/shop/products/Artboard45_c56c63fc-b6a1-46f3-9373-d4d968f96ee4.png?v=1645669187	f
8060434252015	Nello Unisex Tshirt Black	Crafted from a soft cotton in an off-white hue, this essential T-shirt is cut for an oversized fit with a dropped shoulder for a relaxed silhouette. The minimal stitching adds a timeless finish, perfect for your capsule wardrobe.	75% Polyester, 25% Cotton	ALL SIZE (FIT TO XL)	http://dumaofficial.com/cdn/shop/files/NelloTshirtBlack-2.jpg?v=1685034219	f
7946306158831	Darcie Top Green	Knitted from soft cotton yarns, this v-neck top has a flattering curved yet relaxed fit and femine ruffle	100% COTTON	All Size	http://dumaofficial.com/cdn/shop/products/DarcieTopGreen_2.jpg?v=1670552280	f
7719007650031	Leya Pants Black	Cullote pants knitted from soft and elastic viscose yarns featuring a mid-rise, cropped length, and straight fit, perfect for a casual, everyday look. Pair it with our best-selling Dali Top for a matching set!	SOFT VISCOSE	All Size	http://dumaofficial.com/cdn/shop/products/Artboard4_7c7cc0dc-8c53-4166-8ce3-8ece154ed9c9.png?v=1656463598	f
8211517767919	Trixie Dress Red	A special mini dress for this holiday season! This dress is shaped for a slim fit enhanced by the ribbed waist detail at the bodice, and flares out to a sculpted peplum mini skirt. Design	100% Nylon	ALL SIZE	http://dumaofficial.com/cdn/shop/files/TrixieDressRed_74554754-939e-45ed-876e-1e30eacc678f.jpg?v=1706097474	f
8082175328495	Tropez Dress Pink	A modern slip dress with flattering halter neckline that embodies ease and elegance with a volumious a-line drape all in a luminous ombré sliky satin blend. This maxi dress will make an elegant addition to your summer wardrobe.	100% polyester	1, 2	http://dumaofficial.com/cdn/shop/files/TropezDressPink1.png?v=1688920698	f
8773378048239	Olam Dress | Brown	Crafted from crisp and airy polyester fabric, this brown shirt dress is inspired by elements of workwear but made our way. Featuring a pointed collar, front button closure, A-line fit, and a flattering halter neckline. Perfect to throw on this fall season!	100% Polyester	ALL SIZE	http://dumaofficial.com/cdn/shop/files/EDITERArtboard17.jpg?v=1729132495	f
8218772832495	Jane Cardigan Red	Our best selling Jane Cardigan in special holiday color! This cardigan has a minimal design with fancy wave knit pattern. It features a basic crew neck, two hook button closure, and scalloped edges. It's shaped for a slim fit with a cropped body and sleeves, perfect for wearing with high-waisted trousers.	85% Viscose, 15% Nylon	ALL SIZE	http://dumaofficial.com/cdn/shop/files/JaneCardiganRed-2.jpg?v=1702572250	f
8843365155055	Marda Dress | Dark Brown	Chic and versatile, this mini shirt dress is a wardrobe essential. Featuring a button-down front with covered buttons for a sleek look, it’s designed with a box-pleated skirt that adds structure and movement. The matching fabric belt with a buckle detail cinches the silhouette for a flattering, polished look. Perfect for both casual and dressy occasions, this dress combines timeless style with modern sophistication.	100% Japanese made Premium Polyester	1, 2	http://dumaofficial.com/cdn/shop/files/MARDADRESSDARKBROWN-2.jpg?v=1734420790	f
8959296176367	Carlo Top | Dark Brown	This sleeveless top features a structured, tailored silhouette with a sharp collar and clean lines. The front opens with a concealed zipper to maintain a minimalist, polished look. Crafted in a textured knit, it subtly hugs the body without clinging, ending in a neat hemline. Versatile and understated, it pairs effortlessly with wide-leg trousers, or our A-line skirt for a sophisticated ensemble.	100% COTTON	1, 2	http://dumaofficial.com/cdn/shop/files/CARLOTOPDARKBROWN-1.jpg?v=1747881281	f
8060699902191	Ira Crop T-shirt Dark Navy	Crafted from a sustainable premium Japanese polyester fabric that is luxuriously soft and cooling, this crop top is has the perfect fit with a straight cut, round neck and clean finishing. Pair it with the cargo pants for a cool and stylish look that provides all day comfort!	75% Polyester, 25% Cotton	1, 2	http://dumaofficial.com/cdn/shop/files/IraCropTshirtDarkNavy-3.jpg?v=1685033854	f
7471245328623	Noel Top Grey	Get cozy this Christmas with our Noel Top Grey! Knitted from soft cotton yarn into the perfect holiday sweater for you! Pull-over style with slightly balooned sleeves, ribbed hem and sleeves cuffs. Pair it with our Carol Pants for the ultimate holiday outfit for your festivities!	100% Cotton	ALL SIZE	http://dumaofficial.com/cdn/shop/products/WhatsAppImage2021-12-07at13.41.57_1.jpg?v=1638863072	f
8196303847663	Idris Knit Dress Navy	Made from a loosely knitted rib texture using soft rayon yarns, this maxi dress has a relaxed tank silhouette that contours down the body beautifully. Wear it with the matching cardigan to get the perfect travelling look.	92% Rayon, 8% Nylon	ALL SIZE (FIT TO L)	http://dumaofficial.com/cdn/shop/files/IdrisDressNavy.jpg?v=1700777720	f
8252041363695	Ruby Top Black	Cut and sewn from our all time favorite premium Japanese polyester fabric, we put a tweak to a simple tanktop by giving a puffed peplum panels on the side. Playful yet still simple, perfect to throw on for simple events or night out with friends!Model : 175 cm	100% Japanese made Premium Polyester	1, 2	http://dumaofficial.com/cdn/shop/files/RubyTopBlack.jpg?v=1706001483	f
7975351681263	Nina Top Red	Sleeveless Satin Print Top with standing collar and hidden side seam pleats that give a slimmer arm silhouette and fluidity to the body. Fits perfectly on any body type and easy to style with anything. Finished with chinese buttons, a cherry on top perfect for your CNY festivities oufit!	100% Polyester	All Size	http://dumaofficial.com/cdn/shop/products/NinaTopRed.jpg?v=1673497801	f
8145497325807	Gamo Shirt White	Our Gamo sleeveless muscle shirt is crafted from pure tencel fabric in a crisp white hue, that drapes effortlessly over the body and has an oversized silhouette that’s enhanced by the padded shoulders, curved panel	100% Tencel	All Size	http://dumaofficial.com/cdn/shop/files/GamoShirtWhite.jpg?v=1697785632	f
8145133732079	Frank Cropped Blazer Blue	Crafted from premium Japanese polyester, this single-breasted blazer in our special blue shade, is expertly tailored with defined padded shoulders, folded over wide sleeves, and the perfect cropped length. Highlight the ultra cropped length by styling it with our Harlow pants.	100% Japanese made Premium Polyester	All Size	http://dumaofficial.com/cdn/shop/files/FrankCroppedBlazerBlue-2.jpg?v=1697697646	f
8110093631727	Monet Top Pink	Cropped polo shirt with a shape inspired by sportswear look. Knitted in a fancy wave pattern the perfect cropped length, smartened up with pointed collar, gold buttons and scalooped edges. Crafted with Viscose yarns for fluidity and signature pink color perfect to spice up your everyday wardrobe.	85% Viscose, 15% Nylon	All Size	http://dumaofficial.com/cdn/shop/files/MonetTopPink-2.jpg?v=1693879939	f
8005190975727	Ansel Cardigan Grey	Knitted from soft viscose yarns, this V-neck cardigan is designed for a regular fit and features a subtly nipped-in waist. It has modern tubular trims, finished with front button closure and ribbed cuffs and hems. The perfect luxurious loungewear you need in your wardrobe!	Soft Viscose	All Size	http://dumaofficial.com/cdn/shop/products/AnselCardiganGrey.jpg?v=1677142063	f
8842742759663	Cocktail Tee | White	Making our basic fit white tee extra special this holiday season with our special print! Knitted from soft 100% Cotton yarn in a relaxed, cropped cut for maximum comfort in daily wear. Pair it with your favorite pair of bottom for your next cozy Christmas gatherings.	100% Cotton	1, 2	http://dumaofficial.com/cdn/shop/files/COCKTAILTEE-1.jpg?v=1734424866	f
8665202065647	Lucca Linen Vest | Pink	Elevate your look this summer with our Lucca Linen Vest. Crafted from our pinstripe linen fabrication, this style forms a figure-hugging silhouette with a tailored finish. The sleeveless vest is defined by its deep U-shape neckline and princess lines for a more cinched figure. This blush pink and black pinstripe top secures with front button closure and curved front hem. Pair it with the matching Alba Linen Skirt for an easy vacation outfit.	100% Linen	Small, Medium, Large	http://dumaofficial.com/cdn/shop/files/LUCCALINENVESTPINK-2.jpg?v=1720522270	f
8294600245487	ROSA | Slim Fit Crew Neck in Dark Grey	A wardrobe staple offered in a rich dark grey hue, it’s crafted from soft and stretch lyocell and has a streamlined slim fit that's ideal for daily or for layering purposes.	100 % Lyocell Blend	All Size (Fit to Large)	http://dumaofficial.com/cdn/shop/files/Untitled-1Artboard2_1fa6c992-3fc7-4d6d-a31a-c7663cc49a72.jpg?v=1709002084	f
8307532562671	Freya Set Pink	A perfect set consisting of a cropped shirt and voluminous midi skirt, in an elegant pink shade. The cropped shirt is designed with a puffed sleeves and boxy fit, finished with concealed front buttons. The skirt is shaped in an A-line silhouette with a corset waist detail that contours the waist perfectly and a concealed zip closure.	100% Cotton	1, 2	http://dumaofficial.com/cdn/shop/files/FreyaSetPink.jpg?v=1710166000	f
8196095443183	Pralu Pants Grey	Our Pralu Pants is crafted for a flared fit that complements every body type! This pants surely does the trick of elongating your legs and creating the most flattering fit out of a women's legs, not to mention its super soft and stretchy fabric. Certainly a must have in everyone's wardrobe essential.	90% Polyester, 10% Elastane	S, M, L	http://dumaofficial.com/cdn/shop/files/PraluPantsGrey.jpg?v=1700779304	f
8145136746735	Pranko Top | Black	Feminine and classic, this top is one that all women needs in their closet. Crafted from stretch premium Japanese polyester fabric, with pointed collar, contoured silhouette, and a flattering full peplum, finished with a row of our special gold buttons, this top will definitely last you a lifetime without ever going out of trend.	100% Japanese made Premium Polyester	1, 2	http://dumaofficial.com/cdn/shop/files/PANKO_TOP_BLACK-1.jpg?v=1745914688	f
8060725362927	Cho Cargo Pants Taupe	Crafted from a sustainable premium Japanese polyester fabric that is luxuriously soft and cooling, this cargo sweatpants are cut for a relaxed fit with a comfortable elasticated waistband with drawstrings, cargo detailings on each leg, and side seam pockets. Pair it with the matching crop t-shirt for a chic and comfy everyday look!	75% Polyester, 25% Cotton	ALL SIZE (FIT TO XL)	http://dumaofficial.com/cdn/shop/files/IraCropTshirtTaupe_134cff9c-3691-4a6a-aada-ef712c72a2e6.jpg?v=1685069291	f
7833926992111	Yamila Dress Blue	Midi dress knitted from a soft cotton yarn into a fresh blue-ish hue pattern and a flattering straight, v-neck silhouette that compliments all body types. Pair it with our Arzel Blazer for brunches with your girlfriends or casual meetings!	100% Cotton	ALL SIZE	http://dumaofficial.com/cdn/shop/products/yamila1.jpg?v=1663292460	f
8792600772847	Ang T-Shirt | Dark Brown	Secure your transitional wardrobe with this staple long-sleeved mock neck top. Offered in a warm dark brown tone, it’s crafted from soft lyocell blend and has a streamlined slim fit that’s ideal for layering.	76% Lyocell, 19% Wool, 5% Spandex	ALL SIZE (Fit to L)	http://dumaofficial.com/cdn/shop/files/ANGT-SHIRTDARKBROWN-2.jpg?v=1729052254	f
8818184356079	Jennie Tanktop | Beige	An essential for your daily wardrobe, especially those warmer days. Offered in a beige tone, it’s crafted from soft lyocell blend and has a streamlined slim fit with endless styling opportunities - wear it alone or layered under shirts and blazers.	76% Lyocell, 19% Wool, 5% Spandex	ALL SIZE (Fit to L)	http://dumaofficial.com/cdn/shop/files/JennieTanktopBeige-2.png?v=1731576945	f
7946301767919	Lily Velvet Dress Black	Short dual-material dress with velvet shawl collar, cross-over fastening, velvet buttons down the front, sinched waist and flared mini skirt, perfect for your year end holiday events!	95% Polyester, 5% Elastane	1 &amp; 2	http://dumaofficial.com/cdn/shop/products/LilyVelvetDress_4.jpg?v=1670552523	f
8218797605103	Morris Leather Pants Brown	A staple pants that everyone needs in their capsule wardrobe. This pant is crafted from the perfect brown shade faux leather fabric and designed as a straight silhouette that taper down the legs and with ankle-length hems, finished with front patch pocket	100% Polyester	S, M, L	http://dumaofficial.com/cdn/shop/files/MorrisLeatherPantsBrown-2.jpg?v=1702572186	f
9001294102767	Garland Sweater | Grey	Shawl neckline sweater with multiple styling options, made from a mid-weight cotton knitting and featuring an intricate rib stitch. It has an oversized fit for casual sophistication. Pair it with our Sorrel Satin Pants for a comfortable yet stylish holiday/airport fit.	100% Polyester	ALL SIZE	http://dumaofficial.com/cdn/shop/files/GARLANDSWEATERGREY2.jpg?v=1750836156	f
8329462743279	Noten Outer Yellow	The perfect outer for you this spring season! Crafted from our all time favorite premium Japanese made polyester fabrication in the most elegant pastel yellow hue, this outer has a boxy A-line silhouette with regular collar, snap button openings and 3D floral	100% Japanese made Premium Polyester	ALL SIZE	http://dumaofficial.com/cdn/shop/files/NotenOuterYellow-2.jpg?v=1711073486	f
8196097474799	Piper Top Black	This cropped sleeve top is designed for an elevated essential piece that can double as lounge or smart wear. Crafted from premium cotton yarns and cut for a boxy fit and 3/4 length sleeves, creating a chic yet comfy fit.	100% COTTON	1, 2	http://dumaofficial.com/cdn/shop/files/PiperTopBlack.jpg?v=1700779194	f
8947915292911	Sienna Top | Dark Brown	Crafted from soft buttery knit blend with a fluid hand feel, this dark brown blouse is designed with drapes, fitted sleeves, and a mock neckline. Style it with tailored skirts or trousers and kitten heels for the perfect polished look!	90% Polyester, 10% Elastane	ALL SIZE	http://dumaofficial.com/cdn/shop/files/SIENNATOPDARKBROWN-5.jpg?v=1747798938	f
7471348252911	Marley Outerwear Maroon	This tailored sleeveless knit outer is designed to be the versatile piece for your wardrobe, it can be worn anytime and perfect for your everyday pieces. The leather belt detail at the waist is meant to enhance a woman's curve. You can pair it with our Neta pants to create a smart casual look.	65% Acrylic 35% Viscose	All Size	http://dumaofficial.com/cdn/shop/products/WhatsAppImage2021-12-07at13.43.32_2.jpg?v=1638868075	f
8211420152047	Dazzle Sparkly Cardigan Black | BACK IN STOCK	Specially knitted with metallic threads to welcome you to the festive season, this cardigan is shaped for a relaxed fit, designed with V neckline and completed with sparkly buttons front closure. Can easily pairs with any bottom for your upcoming festivities!	60% Cotton, 40% Polyester	1, 2	http://dumaofficial.com/cdn/shop/files/DazzleSparklyCardigan.jpg?v=1701935658	f
8145089691887	Frank Cropped Blazer Black	Crafted from premium Japanese polyester, this single-breasted blazer in timeless black, is expertly tailored with defined padded shoulders, folded over wide sleeves, and the perfect cropped length. Highlight the ultra cropped length by styling it with our Harlow pants.	100% Japanese made Premium Polyester	All Size	http://dumaofficial.com/cdn/shop/files/FrankCroppedBlazerBlack.jpg?v=1697697741	f
8196081352943	Orson Tee Black	This super soft and buttery long sleeve tee is your perfect everyday or travel wear. Lightweight and breathable, especially designed to fit close to your body without being constrictive or overly warm, this long sleeve tee is works perfectly on its own or as a layering piece.	90% Polyester, 10% Elastane	S, M, L	http://dumaofficial.com/cdn/shop/files/OrsonTeeBlack.jpg?v=1709030613	f
8840010432751	Poppy Scarf Top | Navy Multi	Elevate your wardrobe with this elegant halter-neck top, featuring a delicate floral print. Designed with a draped neckline and a keyhole detail for added sophistication. The back showcases a long flowy panel that adds movement and drama to your look. Perfect for pairing with tailored trousers or skirts for a polished look.	100% POLYESTER	ALL SIZEMeasurement :	http://dumaofficial.com/cdn/shop/files/IMG_7928.jpg?v=1733997246	f
7975350730991	Milla Vest Orange	Our Milla Vest has a looser, straight cut made from soft viscose yarns and with front button down closure. A simple, timeless piece that can be worn solo or be layered over a tank or tee as you like! Pair it with or Jetro Pants this upcoming CNY season!	SOFT VISCOSE	ALL SIZE	http://dumaofficial.com/cdn/shop/products/MillaVestOrange-2.jpg?v=1673499656	f
8082171461871	Capri Pants Tosca	Instantly polished and as equally comfortable, our ombré silky satin pants slips on with a flat front and thin elasticized waistband and hidden drawstrings for covert ease, Its slim straight leg falls with a lightweight drape will fits flatteringly on any legs.	100% Polyester	1, 2	http://dumaofficial.com/cdn/shop/files/CapriPantsTosca2.png?v=1688954732	f
8102668370159	Biya Crop Denim Shirt White	Crafted from a sustainable blend of soft cotton fabric with added stretch for comfort, this crop denim shirt is cut for a relaxed fit and has a classic pointed collar, back box pleat and neat buttoned blacket. The cropped length will pair perfectly with your favorite high-waisted trousers, or to pair with our matching Becca maxi skirt.	100% Cotton	ALL SIZE (FIT TO L)	http://dumaofficial.com/cdn/shop/files/Duma4447-1-edit1.jpg?v=1692771218	f
7946299474159	Coco Tweed Dress Black Multi	Short tweed dress with a V-shaped neckline, long sleeves with a slightly flared hem, a faux button placket and faux pockets perfect for your year end holiday events!	60% Wool Blend, 35% Cotton, 5% Nylon	All Size	http://dumaofficial.com/cdn/shop/products/CocoDress_4.jpg?v=1670332685	f
8114155880687	Jane Cardigan White	This cardigan has a minimal design with fancy wave knit pattern. Offered in timeless navy, it features a basic crew neck, two hook button closure, and scalloped edges. It's shaped for a slim fit with a cropped body and sleeves, perfect for wearing with high-waisted trousers.	85% Viscose, 15% Nylon	All Size	http://dumaofficial.com/cdn/shop/files/JaneCardiganWhite.jpg?v=1694581340	f
7455679119599	Paloma Dress Black	Knit dress made from a slub-melange, ribbed cotton knit that is simple yet flattering. With its low round neck that accentuates the collarbone, its straight fit, side slit and midi length, this is the perfect casual dress for you! Pair it with our Arlet Top to create an effortless elegant look!	100% Cotton	ALL SIZE	http://dumaofficial.com/cdn/shop/products/Artboard1_0d14a643-4317-490c-ae62-850c4d2be1e7.png?v=1637736923	f
8107680661743	Vanka Top Pink	Carefully knitted with the classic tailoring priciple to achieve the silhouette of this waistcoat. With the perfect halter neck design and beautifully contoured waist, completed with front button fastenings and welt pocket flap designs. A classic piece that will complement your body really well!	100% Cotton	1, 2	http://dumaofficial.com/cdn/shop/files/VankaTopPink.jpg?v=1693804498	f
8604404187375	Daffodil Girl Pajamas Blue	A reversible set of pajamas made in 100% cotton. With a spread of beautiful blooms all over the scallop collar and frill hem	Made in 100% cotton	1, 2, 3, 4	http://dumaofficial.com/cdn/shop/files/DaffodilPJBlue-2.jpg?v=1718080332	f
7740224897263	Marin Cardigan White	Knitted from very soft and elastic viscose yarns, this calf-length cardigan with v-neckline, front button closure and side slit is a must have in every women's wardrobe. With its relaxed fit, its very easy to style with any outfit or for any occasions.	SOFT VISCOSE	ALL SIZE	http://dumaofficial.com/cdn/shop/products/FUNDAMENTALSRESIZEDCATALOGArtboard20.jpg?v=1657770880	f
8036433953007	Olika Knit Cardigan Top	Knitted from soft cotton yarns, this long sleeve top has a flattering, curved yet relaxed fit. Finished with a feminine ruffle detail at hem, it's perfect for a day-to-night look! Pair it with our Baroka skirt for an elegant yet comfortable look this Ramadan season!	100% Cotton	ALL SIZE (FIT TO L)	http://dumaofficial.com/cdn/shop/products/OlikaCardiganBlack-4.jpg?v=1681103152	f
8843352703215	Claus Cardigan With Rhinestones | Maroon	This elegant cable knit cardigan is a perfect blend of cozy and chic for this festive season. Featuring a timeless V-neckline and intricate cable detailing, it’s elevated with sparkling bedazzled appliqué around the neckline for a touch of glamour. The hook-and-eye closures add a delicate finish, making it versatile enough to wear open or closed. Perfect for layering over dresses or pairing with your favorite pair of bottom for a polished, standout look. Please note: the appliqué design may vary slightly from the picture, making each piece uniquely yours.	100% Cotton	ALL SIZE (Fit To M)	http://dumaofficial.com/cdn/shop/files/CLAUSCARDIGANWITHRHINESTONESMAROON-5.jpg?v=1734492876	f
8823411376367	MMEHUILLET FOR DUMA - Seoul Puffer | Blue	The perfect blend of warmth and versatility, Seoul Puffer features a lightweight yet insulating design, with a smooth, quilted exterior. The real highlight is the detachable knit vest inside — a chic, textured layer that provides extra warmth. Whether you’re braving the cold or layering up for a more polished outfit, this jacket offers ultimate flexibility and a pop of color to brighten your winter wardrobe.	100% Polyester	ALL SIZE	http://dumaofficial.com/cdn/shop/files/SeoulPufferBlue.jpg?v=1732726597	f
8211456950511	Vanka Top Maroon	Our best-selling Vanka top in a special holiday color! Carefully knitted with the classic tailoring principle to achieve the silhouette of this waistcoat. With the perfect halter neck design and beautifully contoured waist, completed with front button fastenings and welt pocket flap designs. A classic piece that will complement your body really well!	100% Cotton	1, 2	http://dumaofficial.com/cdn/shop/files/VankaTopMaroon.jpg?v=1701935550	f
8791861231855	Sonnet Jacket | Sand	Jumping into this fall’s suede trend, but with our own twist. This jacket is tailored into a neat slim-fit that still gives space for comfort and movement. Detailed with scooped neckline that exudes elegance and stylish front buckle opening. Sonnet Jacket | Sand is fully-lined and carefully tailored to achieve a structured, luxurious look.	100% Polyester	1, 2Measurement :	http://dumaofficial.com/cdn/shop/files/SONNETJACKETSAND-5.jpg?v=1729052984	f
8005296390383	Moneta Skirt Black	This black knit midi skirt is made from heavyweight pure cotton yarns that will last years in your wardrobe. It's designed with a comfortable elasticated waist and flares out to a softly draped A-line hem.	100% Cotton	All Size	http://dumaofficial.com/cdn/shop/products/NadineTopBlack_c24c9312-c805-4c8e-b53f-ce9a9c5a7dfc.jpg?v=1680148358	f
9000439218415	Andia Skirt | Cream	A crochet midi skirt with a straight, clean-cut silhouette. Made from soft, breathable knit with a comfortable elastic waistband. The hem is finished with contrast hand-stitched detail for a unique, crafted touch. Easy to wear as a set with the matching top or styled on its own with simple basics.	Recycled Polyester	1, 2	http://dumaofficial.com/cdn/shop/files/ANDIASKIRTCREAM1.jpg?v=1750785824	f
7894087074031	Dianne Cardigan White	Soft and structured, this cardigan has a relaxed silhouette and casual striped pattern throughout. It is finished with covered button fastenings and the perfect cropped length. A very special piece perfect for versatile styling and easy layering.	100% COTTON	All Size	http://dumaofficial.com/cdn/shop/products/AnneWhite_4.jpg?v=1666604101	f
8824999379183	MMEHUILLET FOR DUMA - Sunsu Shirt | Denim Blue	Made from soft washed denim, this half-placket shirt has a pointed collar, cropped sleeves, concealed buttons and a curved stepped hem. Style it with our Baram Pants for a cool denim-on-denim look.	100% Cotton	ALL SIZE	http://dumaofficial.com/cdn/shop/files/SunsuShirtBlue-6.jpg?v=1732725127	f
7455675351279	Noor Skirt Red	A kint skirt made of a slub-melange, ribbed cotton handmade knit. It features a midi length, A-line silhouette, and a slimming knit pattern, a perfect go to piece for your day to night look! Pair it with our Arlet Top for an effortlessly elegant and sophisticated look.	100% Cotton	All Size	http://dumaofficial.com/cdn/shop/products/Artboard38_c02f3557-8770-402d-b8f3-dd4b0d0cb4d7.png?v=1637736805	f
7894083371247	Maya Blazer Black	Knitted from soft cotton yarns into the perfect blazer top design and silhouette, finished with shoulder pads and covered buttons. Something you never knew you needed in your capsule wardrobe. Undeniably comfortable, suitable for formal or business casual events, keeps you looking professional yet comfortable for your important meetings. Can't forget how perfect it looks as an outer too! This piece will be your best purchase yet!	100% COTTON	All Size	http://dumaofficial.com/cdn/shop/products/MayaBlack_6.jpg?v=1666742721	f
7113856024754	Dali Top Black	This top is an essential for everyone's capsule wardrobe! Simple design, with soft knitted fabric, and the perfect shades of neutral color. You can easily style this top with any pair of bottoms you have at home or pair it with our Grata Pant for a lazy day ootd!	Soft Viscose	All Size	http://dumaofficial.com/cdn/shop/products/WhatsAppImage2021-11-01at10.30.26.jpg?v=1635737762	f
7471329968367	Jolly Cardigan Grey	Get cozy this holiday season with our Jolly Cardigan! Knitted from soft cotton material into the perfectly elegant fit and beautifully curved hem and sleeves	100% Cotton	All Size	http://dumaofficial.com/cdn/shop/products/WhatsAppImage2021-12-07at13.42.14_2.jpg?v=1638864505	f
8913091494127	Rum Houndstooth Shorts | White Multi	Cut from a classic houndstooth pattern tweed and designed with a mid-waist and tailored fit, these shorts offer a chic silhouette that transitions seamlessly from day to night. Dress it up with our matching Polan Houndstooth Top, or down with a casual tee—these tweed shorts are your new go-to piece for stylish layering.	Poly Blend	1, 2	http://dumaofficial.com/cdn/shop/files/RumHoundstoothShorts.jpg?v=1741855005	f
8959790022895	Verso Trench Vest Dress | Beige	Sleeveless trench-inspired dress crafted in a structured beige fabric, featuring a flattering A-line silhouette. The double-breasted front with fabric-covered buttons adds a tailored touch, while the soft collar and flared hem offer movement and elegance. It is fully lined, providing a clean finish that also allows it to be worn open as a sophisticated outer layer over other outfits. Wear it buttoned up as a dress or layer it over blouses, shirts, or dresses for a polished outerwear look.	100% Japanese made Premium Polyester	1, 2	http://dumaofficial.com/cdn/shop/files/VERSOTRENCHVESTDRESSBEIGE-1.jpg?v=1747798530	f
8843362861295	Crimson Pants | Maroon	Stay effortlessly stylish with these barrel-leg cropped pants, designed for both comfort and versatility. The relaxed silhouette features a flattering high rise and a unique elasticized waistband at the back for an easy, flexible fit. Perfect for casual days or dressing up with heels, these pants offer a modern, laid-back vibe to elevate any outfit.	Cotton Poly Blend	Small, Medium, Large	http://dumaofficial.com/cdn/shop/files/Artboard5.png?v=1734497736	f
7110613631154	Parson Top Black	Through the handmade knitting process involved, each piece undergoes a natural twist of yarns that are uniquely different. Making an exclusive "twist" in every piece, specially for you. Inspired by our top selling Potar Top, we created this comfortable, knit version that will surely fit any body comfortably! Made from a slub-melange cotton knit, this top is completed with a relaxed fit and a soft handfeel. Pair it with our Fran Shorts to lounge around, or our Grata Pant for a more put-together look.	100% Cotton	\N	http://dumaofficial.com/cdn/shop/products/Artboard3_5c23876b-8063-4721-897f-a563884d67ee.png?v=1635739433	f
8110093533423	Jane Cardigan Pink	This cardigan has a minimal design with fancy wave knit pattern. Offered in timeless navy, it features a basic crew neck, two hook button closure, and scalloped edges. It's shaped for a slim fit with a cropped body and sleeves, perfect for wearing with high-waisted trousers.	85% Viscose, 15% Nylon	All Size	http://dumaofficial.com/cdn/shop/files/JaneCardiganPink.jpg?v=1693880044	f
9001309339887	Mod Hoodie | Black	This hoodie featuring a clean silhouette, wide tonal drawstrings, and a unique button-up opening at the neckline for a subtle, elevated twist. The soft viscose keeps you cozy, while the roomy front pocket adds function without sacrificing form. It’s the perfect blend of laid-back comfort and minimal chic — ideal for traveling in style.	Soft Viscose	ALL SIZE	http://dumaofficial.com/cdn/shop/files/MODHOODIEBLACK2.jpg?v=1750836128	f
8329471492335	Ara Dress Taupe	Our Ara dress is designed with a laid back silhouette, perfect for attending your Ramadhan festivities, our to use for everyday styling. Crafted from our special lace brocade, this dress is a free flowing piece, featuring front button openings and accentuated sleeves, and includes an inner cotton dress.	100% Polyester	ALL SIZE	http://dumaofficial.com/cdn/shop/files/AraDressTaupe_b17e0718-983e-4199-9092-fea23bcd54ac.jpg?v=1711073438	f
8791886528751	Dalmar Jacket | Brown	Dalmar Jacket | Brown is the perfect addition to your fall wardrobe. Crafted from soft, premium suede, it boasts a rich texture that enhances its timeless appeal. The warm, earthy tones are ideal for the season, easily complementing cozy knits and denim. With a boxy fit that flatters any silhouette, it features a classic button-up front and functional pockets for added practicality.	100% Polyester	ALL SIZEMeasurement :	http://dumaofficial.com/cdn/shop/files/DALMARJACKETBROWN-3.jpg?v=1729052327	f
8082187976943	Mare Skort Black	Our Mare black mini skort is crafted from our favorite premium japanese stretch polyester. It’s cut to a high-rise waist and A-line tailored silhouette with built-in shorts and hidden side zipper. The prefect bottom for your wardrobe essential this summer!	100% Japan made Polyester	1, 2	http://dumaofficial.com/cdn/shop/files/MareSkortBlack4.png?v=1688954216	f
8060442214639	Corrin Sweater Set Grey	Finely knitted from a lightweight cotton yarn, this sweater set is the perfect two-in-one package for your capsule wardrobe! Comes with the perfect ribbed-knit tank that falls right around your hip and a loose-fitting, semi sheer deep v-neck sweater perfect for layering.	100% COTTON	ALL SIZE (FIT TO L)	http://dumaofficial.com/cdn/shop/files/CorrinSweaterSetGrey-2.jpg?v=1685034167	f
8114154406127	Gilia Jeans Denim Light Blue	Inspired by the '70s, our Gilia Jeans is designed with a high-rise waist and wide bootcut hems. Finished with two front pockets and two back pockets, washed to the perfect light denim blue shade with fading at thighs to feel the vintage vibe. The perfect new pair of jeans that you definately need to get your hands on!	Cotton Spadex	S, M, L	http://dumaofficial.com/cdn/shop/files/GiliaPantsLightBlue.jpg?v=1694581262	f
8913520197871	Josette Peplum Top | Black	This elegant classic black top features a fitted bodice with a flattering peplum hem that adds a feminine touch. Made from a soft viscose fabric, it has a classic round neckline and long sleeves, making it perfect for both casual and dressy occasions. A versatile piece that pairs beautifully with trousers or skirts for a polished look. Pair it with our Tan Pants | Black for a clean, effortless look.	Soft Viscose	ALL SIZEMeasurement :	http://dumaofficial.com/cdn/shop/files/JosetteTopBlack.jpg?v=1741856384	f
8220544205039	Blair Skort Grey	Our take on preppy 90s dressing, this skort is cut from soft flannel fabric for its tailored fit and soft textural feel. Its flattering high-waisted cut is accented by two front buttons, and is finished with an A-line silhouette, asymmetrical seam, and box pleats.	100% Polyester	S, M, L	http://dumaofficial.com/cdn/shop/files/BlairSkortGrey-2.jpg?v=1702572147	f
8664891523311	Remmy Skort | Denim Blue	This season's wardrobe staple, our Remmy Skort | Denim Blue is cut and sewn from our newest denim fabrication in a deep blue colorway. It has an A-line silhouette knife pleats and an inner shorts for effortless movements. Pair it with our Denise Vest | Denim Blue for a sophisticated summer fit.	100% Polyester	1, 2	http://dumaofficial.com/cdn/shop/files/REMMYDENIMSKORT-2.jpg?v=1720522490	f
8986641760495	Ozora Top | Black	This convertible button-up top offers a modern, versatile silhouette with thoughtful construction. Designed with high symmetrical neckline and soft structure, it can be styled in multiple ways—buttoned-up as a shirt or open as an outer layer. A timeless staple with a twist—perfect for day-to-night wear and effortless layering.	72% Polyester, 28% Nylon	ALL SIZE	http://dumaofficial.com/cdn/shop/files/OZORABLACK7.jpg?v=1750835766	f
7946302947567	Corla Shirt White	Our best selling shirt cutting with a festive twist! Basic button down shirt with badwing sleeves and ruffles collar. Perfect for layering with your christmas sweaters or cardigans. Pair it with our Molly Cardigan this holiday season for the perfect festive look!	100% Polyester	ALL SIZE	http://dumaofficial.com/cdn/shop/products/Untitled-1Artboard7.jpg?v=1670552484	f
8818183930095	Jennie Tanktop | White	An essential for your daily wardrobe, especially those warmer days. Offered in a white tone, it’s crafted from soft lyocell blend and has a streamlined slim fit with endless styling opportunities - wear it alone or layered under shirts and blazers.	76% Lyocell, 19% Wool, 5% Spandex	ALL SIZE (Fit to L)	http://dumaofficial.com/cdn/shop/files/JennieTanktopWhite-3.png?v=1731577013	f
8752242000111	Baya Pants | Denim Blue	A wide-leg jeans for the chic and stylish, crafted from stretchy medium-weight washed denim. Detailed with handmade frayed waistline and hem, Baya Pants | Denim Blue is the kind of jeans you won’t be able to find anywhere else. The silhouette was especially designed to elongate your legs for a more flattering look. Baya Pants | Denim Blue is a versatile staple that can be styled with any top or worn as a set with our Rugosa Top | Denim Blue.	97% Cotton, 3% Elastane	Small, Medium, Large	http://dumaofficial.com/cdn/shop/files/75CC8632-B52A-4504-BBBE-D6E3C9DE9D3A.jpg?v=1725869390	f
8196086137071	Larra Pants Black | BACK IN STOCK	The comfiest wardrobe staple, designed with our favorite ultra-soft jersey fabric. This straight-leg pant style features a stretch waistband making it comfortable to wear all day long! Wear it as a set with our Remy t-shirt for an easy travel ootd!	90% Polyester, 10% Elastane	S, M, L, XL	http://dumaofficial.com/cdn/shop/files/LARRAPANTSBLACK-5_9c78439d-0962-4acc-9873-2e0386a299a3.jpg?v=1745990521	f
9024432341231	Rhima Top | Butter	This timeless knit top with a classic round neckline and streamlined silhouette is a must-have wardrobe staple for any weather. Designed in a pretty soft pink shade, it offers both minimalist elegance and a touch of subtle femininity. Its lightweight, breathable cotton material makes it perfect for layering, or wearing on its own.	100% Cotton	ALL SIZE	http://dumaofficial.com/cdn/shop/files/RhimaTopButter5.jpg?v=1753853423	f
8604417097967	Daisy Cuddle Pillow Blue	A bed is not a slumber when there is nothing to embrace and cuddle with. But that is no longer the case with our cuddle pillows! Made in 100% cotton, our cuddle pillows are designed in perfect size and shape to stay closely to you anywhere you want them to. Hold them fondly because separation will be hard. Plus, a good night sleep is only a cuddle away — is there anything better than that?	Made in 100% cotton and 95% TENCEL™️ fabric	ALL SIZE	http://dumaofficial.com/cdn/shop/files/DaisyPillowBlue.jpg?v=1718079889	f
7947445764335	Malachi Sparkly Sweater Maroon	A Set of oversized sweater and shorts is a classic knitwear with a shimmering twist, perfect to bring you the festive holiday mood. Crafted from soft cotton and lurex blend, the sweater is cut to a relaxed fit with drop shoulders, shorts are pull on with elastic band. Definately the perfect choice of outfit for your homey get-together this upcoming holidays season.	95% chenille 5% polyethylene	All Size	http://dumaofficial.com/cdn/shop/products/MalachiSweaterRed_3.jpg?v=1670551787	f
8667288961263	BERT  | Regular MEN Fit Crew Neck t-shirt in Olive	A light everyday T-shirt, offered in classic olive green. Crafted from a special cotton blend that’s soft to the touch, it has a classic shape that sits neatly with room for movement through the chest and arms.	100 % Cotton Blend	Small, Medium, Large	http://dumaofficial.com/cdn/shop/files/BertOlive-Front.jpg?v=1720575987	f
8060728180975	Cho Cargo Pants White	Crafted from a sustainable premium Japanese polyester fabric that is luxuriously soft and cooling, this cargo sweatpants are cut for a relaxed fit with a comfortable elasticated waistband with drawstrings, cargo detailings on each leg, and side seam pockets. Pair it with the matching crop t-shirt for a chic and comfy everyday look!	75% Polyester, 25% Cotton	ALL SIZE (FIT TO XL)	http://dumaofficial.com/cdn/shop/files/ChoCargoPantsWhite.jpg?v=1684999533	f
8860255420655	Gou Top | Maroon	An unforgettable 2-toned tweed top that features a refined Mandarin collar and pretty pearl buttons. Its A-line silhouette that was tailored from structured, lined fabric, provides a flattering and comfortable fit for a sleek yet relaxed look. With sumptuous tweed fabric that adds depth and richness, Gou Top is perfect for that long-awaited events and dinners. Pair it with our Tan Pants or a flowing skirt for an effortlessly chic ensemble.	100% Polyester	1, 2	http://dumaofficial.com/cdn/shop/files/GOUTOP-1.jpg?v=1736841762	f
9024393019631	Cielo Shirt | Butter	Relaxed yet refined, this loose boxy shirt is a modern staple with timeless appeal. Designed with a clean stand collar and wide raglan sleeves, it offers a softly structured silhouette that drapes effortlessly on the body. The airy fit provides ease of movement, while the minimal detailing keeps the look contemporary.	100% Cotton	1, 2	http://dumaofficial.com/cdn/shop/files/CieloShirtButter1.jpg?v=1753694388	f
8306798756079	Leila Top | BACK IN STOCK	A simple yet flattering top knitted from soft cotton yarns with intricate flower cutout	100% Cotton	1, 2	http://dumaofficial.com/cdn/shop/files/LeilaTopPink-6.jpg?v=1711083429	f
8304605561071	Flor Top Navy	A simple yet flattering top knitted from soft cotton yarns with sophisticated flower	100% Cotton	ALL SIZEMeasurement :	http://dumaofficial.com/cdn/shop/files/FlorTopNavy-2.jpg?v=1710170285	f
8897159463151	Acma Shirt Top | Taupe	This knit top exudes elegance with its soft drape and smooth texture, offering both comfort and sophistication. Featuring a notched collar and button-down front, it blends classic tailoring with a relaxed, modern feel. The half sleeves provide a balanced look, making it suitable for both warm and transitional weather. The subtly fitted silhouette enhances the figure while maintaining ease of movement, and the split hem detail at the front adds a contemporary touch. Easily style this top with tailored trousers for a polished look or paired with denim for effortless chic.	Rayon Blend	1, 2	http://dumaofficial.com/cdn/shop/files/ACMASHIRTTOPTAUPE-1.jpg?v=1740375455	f
7455591432431	Arlet Top Black	Knit top made from a slub-melange, ribbed cotton knit that is feminine and attractive. With its long, flared out sleeves that covers the palm of our hand, its V-neckline cut that accentuate one's collarbone and its cropped, straight fit, this top screams elegance and comfort in the most perfect way. Our Arlet Top can be styled in so many different ways; as a top or as a cardigan! Pair it with our Jola Pants for a casual look, or our Paloma Dress for a more sophisticated look.	100% Cotton	All Size	http://dumaofficial.com/cdn/shop/products/Artboard27.png?v=1637746867	f
7894093758703	Kano Set Grey	Our cropped cardigan and adjustable tank top set is a seasonless essential that can be worn as a set or separates. Lightweight knitwear pieces, with point collar and button front fastening cardigan, completed with an adjustable strap basic tanktop. Perfect for any look you're going for any time of day!	100% COTTON	ALL SIZE ( FIT TO MEDIUM )	http://dumaofficial.com/cdn/shop/products/KanoGrey_2.jpg?v=1666742151	f
8842758521071	Hoho Sweater | Green Multi	Stay festive and comfortable this season with our fair-isle sweater in intricate Christmas jacquard motif and the perfect oversized fit. Comes in two colors, it’s the prefect pick for family gatherings, or twinning with someone special this holiday season.	100% Cotton	ALL SIZE	http://dumaofficial.com/cdn/shop/files/HOHOSWEATERGREENMULTI-1.jpg?v=1734424541	f
7471330623727	Marilou Top Navy	Structured top with contoured waistline, perfect for a formal event, or a regular day out! Knitted from soft cotton yarns, this is as cozy as it is sophisticated. Pair it with our Gale Skirt to get the perfectly elegant look this holiday season!	100% Cotton	All Size	http://dumaofficial.com/cdn/shop/products/WhatsAppImage2021-12-07at13.43.51_1.jpg?v=1638861282	f
8211400392943	Esther Ruffle Cardigan Black	Our special ribbed cardigan is designed with a v-neckline and front button closure and shaped for a streamlined slim fit and ruffle	85% Raylon, 10% Polyester, 5% Nylon	ALL SIZE (FIT TO L)	http://dumaofficial.com/cdn/shop/files/EstherRuffleCardiBlack.jpg?v=1701935677	f
8005157945583	Sofia Top Bone	Designed from a premium stretch woven fabric, this open collar sleeveless top features oversized lapels with a deep-v-neck, bust darts and panels to highlight the silhouette and front snap button closure and hidden side pockets for a clean look with elevated comfort.	100% Japan made Premium Polyester	1, 2	http://dumaofficial.com/cdn/shop/products/SofiaTopBone.jpg?v=1677143504	f
7833906741487	Sonya Top Blue	Sleeveless top knitted from soft cotton yarns into a fresh blue-ish hue pattern and the perfectly flattering silhouette of low round neckline, a-line body, and scalloped edge. Pair it with our Piaca Pants for an effortlessly chic outfit in seconds!	100% Cotton	ALL SIZE	http://dumaofficial.com/cdn/shop/products/sonya10.jpg?v=1663292341	f
8843364073711	Crimson Pants | Brown	Stay effortlessly stylish with these barrel-leg cropped pants, designed for both comfort and versatility. The relaxed silhouette features a flattering high rise and a unique elasticized waistband at the back for an easy, flexible fit. Perfect for casual days or dressing up with heels, these pants offer a modern, laid-back vibe to elevate any outfit.	Cotton Poly Blend	Small, Medium, Large	http://dumaofficial.com/cdn/shop/files/CRIMSONPANTSBROWN-4.jpg?v=1734497802	f
8082170609903	Galena Cardigan Tosca	This V-neck cardigan is knitted from customer's all time favorite soft viscose yarns. Designed for a contoured fit, it has neat ribbed trims and fasted with a row of horn buttons for a sleek finish. It's most definitely a wardrobe essential that will stay with you for a very long time.	Soft Viscose	All Size	http://dumaofficial.com/cdn/shop/files/GalenaCardiganTosca2.png?v=1688920883	f
7959651221743	Jack Polo Navy Multi	Pattern Knitted Polo made out of soft cotton yarns that will surely feel snug and cozy. This top is perfect for your little ones to leave the house looking all preppy and adorable!	100% Cotton	\N	http://dumaofficial.com/cdn/shop/products/KidsArtboard8.jpg?v=1671417156	f
8107692392687	Marion Top Dark Denim	Matching sets are key for the upcoming season, and the cropped length of this sleeveless top balances the coordinating mini skirt. It is crafted from washed dark blue denim and designed with halter neck and pointed collar, front button fastenings and banded waist. Wear it as a pair with our Khanyo skirt.	100% Cotton	All Size (Fit to M)	http://dumaofficial.com/cdn/shop/files/MarionKhanyoDarkDenim-2.jpg?v=1693879979	f
8965256806639	Greeting Card	Celebrate your loved one's special day with our Greeting Cards Size : B5 Cards Notes :1. Kindly Please chat our customer service for additional notes2. If there is no custom text, the gift card will be sent in blank card	\N	B5 Cards	http://dumaofficial.com/cdn/shop/files/IMG_5312.png?v=1747893361	f
8253784785135	Lesley Jeans Brown	Denim trousers is a definite staple for your wardrobe, especially this pair as they're comfortable and fits like a glove. This pair is shaped for a flared silhouette with full-length legs and slits at cuffs that will make your legs looks super long and slim. They're crafted from a stretch cotton denim for lightness and comfort it won't feel like your wearing jeans at all!	100% Cotton	S, M, L	http://dumaofficial.com/cdn/shop/files/WhatsAppImage2024-03-27at10.45.43.jpg?v=1711511341	f
7740497690863	Panna Pants Multi	Knitted from soft cotton yarns, our Panna shorts is the perfect loungewear shorts for you! Easy pull-on shorts with fun wave pattern and a monochromatic color palette, it styles perfectly with any clothing piece you can think of! Pair it with our Cara Cardigan to make you look effortlessly chic on your lazy days.	100% Cotton	ALL SIZE	http://dumaofficial.com/cdn/shop/products/FUNDAMENTALSRESIZEDCATALOGArtboard34.jpg?v=1657770610	f
7455674138863	Noor Skirt Blue	A kint skirt made of a slub-melange, ribbed cotton handmade knit. It features a midi length, A-line silhouette, and a slimming knit pattern, a perfect go to piece for your day to night look! Pair it with our Arlet Top for an effortlessly elegant and sophisticated look.	100% Cotton	All Size ( Fit To Large )	http://dumaofficial.com/cdn/shop/products/Artboard57.png?v=1637748316	f
8986619150575	Ozora Top | Soft Beige	This convertible button-up top offers a modern, versatile silhouette with thoughtful construction. Designed with high symmetrical neckline and soft structure, it can be styled in multiple ways—buttoned-up as a shirt or open as an outer layer. A timeless staple with a twist—perfect for day-to-night wear and effortless layering.	72% Polyester, 28% Nylon	ALL SIZE	http://dumaofficial.com/cdn/shop/files/OZORASOFTBEIGE7.jpg?v=1750835800	f
7946280599791	Chala Pants Grey	Get cozy and chic all year round with our Chala Pants! Knitted from soft cotton yarn into the perfect palazzo knit pants, featuring a high rise, wide leg and a relaxed fit. Pair it with our Cheri Shirt or Molly Cardigan for a chic and effortless everyday look!	100% Cotton	1 &amp; 2	http://dumaofficial.com/cdn/shop/products/ChalaPantsGrey2.jpg?v=1670561045	f
8329446097135	Danica Top Denim Blue | BACK IN STOCK	Feminine and classic, this top is one that all women needs in their closet. Crafted from stretch denim fabric washed into the perfect cool blue shade, with pointed collar, contoured silhouette, and a flattering full peplum, finished with a row of our special gold flower buttons, this top will definitely last you a lifetime without ever going out of trend.	100% Cotton	1 , 2	http://dumaofficial.com/cdn/shop/files/DanicaTopDenimBlue.jpg?v=1711026753	f
8211516424431	Gala Top Green	Sculpted peplum knit top that looks like an art piece, designed specially for you this holiday season. Designed with a v-neckline and front button closure, and shaped to a fitted waist and flared peplum bottom, it is definitely one simple yet flattering piece to wear to your upcoming holiday festivities.	100% Nylon	ALL SIZE	http://dumaofficial.com/cdn/shop/files/GalaTopGreen.jpg?v=1701935267	f
8604421816559	Cosmos Throw Blanket Blue	A snuggly blanket to keep you warm and comfortable, and yet light enough for travel-ready. Printed with beautiful hand-drawn illustrations on one side and covered with simple colors at the other side, our throw blanket is an essential collection that you can take anywhere — carrying the comfort of your homy bed everywhere you go.	Made in 100% cotton and 95% TENCEL™️ fabric	ALL SIZE	http://dumaofficial.com/cdn/shop/files/CosmosBlue.jpg?v=1718079656	f
8498316607727	Tanya Tanktop Black	A refined staple made for your capsule wardrobe. This modern tank top is knitted from fine polyester yarns with subtle ribbing	100% Polyester	ALL SIZE	http://dumaofficial.com/cdn/shop/files/TANYATANKTOPBLACK-7.jpg?v=1715741228	f
8742191628527	Ora Top | Black	This asymmetrical one-shoulder top might just be the comfiest and chicest piece you’ll ever have. Its ruched	90% Polyester, 10% Elastane	ALL SIZE (Fit to L)	http://dumaofficial.com/cdn/shop/files/ORATOPBLACK-3.jpg?v=1724754211	f
8773355765999	Vitto Top | Black	Taking inspiration from classic suiting, our Vitto Top | Black is buttoned up the front to meet a close-fitting crew neckline. Cropped for a slightly relaxed silhouette, this sleeveless style is crafted with our premium polyester fabric that looks crisp, has a slight shine, and keeps you comfortable year round.	100% Polyester	1, 2	http://dumaofficial.com/cdn/shop/files/C859F583-05E1-4A45-A19F-F755EC7302AE.jpg?v=1727749951	f
7947448090863	Elfie Sparkly Shorts Navy	Crafted from soft cotton and lurex blend, shorts are pull on with elastic band. Definitely the perfect choice of outfit for your homey get-together this upcoming holidays season.	95% chenille 5% polyethylene	All Size	http://dumaofficial.com/cdn/shop/products/MalachiSweaterNavy_5.jpg?v=1670330916	f
9024321257711	Kyma Top | White	Effortless and easy to wear, this breezy sleeveless top is crafted from breathable, lightweight linen – perfect for warm-weather days. Designed with a relaxed, loose fit for all-day comfort, it features a flattering V-neckline adorned with pretty ruffles, adding a touch of feminine charm. Wear it with your favorite pair of jeans or our matching Sante Pants for a chic, cruise-ready look.	100% Linen	Small, Medium, Large	http://dumaofficial.com/cdn/shop/files/KymaTopWhite1.jpg?v=1753686672	f
7975353975023	Trompa Skirt Black	Pattern Knit Mini Skirt with A-line silhouette that gives a youthful elegant look and hidden elastic waistband that snatched your waist in the most perfect way. Pair it with our Maesa Cardi for the perfect sophisticated look!'	100% COTTON	1, 2	http://dumaofficial.com/cdn/shop/products/TrompaSkirtBlack.jpg?v=1673495874	f
8233622012143	Grego Leather Blazer Brown	The silhouette of this leather jacket is inspired by the classic pea coats. Tailored with a double-breasted closure, it's crafted from buttery faux leather and shaped with softly padded shoulders, notch lapels, and a full lining for easy layering. For a complete set, wear with our matching Morris Pants.	100% Polyester	All Size	http://dumaofficial.com/cdn/shop/files/LeatherBlazerBrown.jpg?v=1704431533	f
8897118044399	Tan Pants | Olive	Elevate your look with these effortlessly chic high-waisted satin pants. Designed with a bias cut for a beautifully fluid drape, they feature an easy wide-leg silhouette that moves gracefully with every step. The slip-on style and elasticized waistband ensure a comfortable, flattering fit, making these pants perfect for both casual and dressy occasions. Pair them with your favorite top for a polished yet relaxed vibe.	100% Polyester	Small, Medium, Large	http://dumaofficial.com/cdn/shop/files/TAN_PANTS_OLIVE_1.jpg?v=1750843337	f
8030812864751	Sofia Top Black	Designed from a premium stretch woven fabric, this open collar sleeveless top features oversized lapels with a deep-v-neck, bust darts and panels to highlight the silhouette and front snap button closure and hidden side pockets for a clean look with elevated comfort.	100% Japan made Premium Polyester	1, 2	http://dumaofficial.com/cdn/shop/products/SofiaTopBlack-2.jpg?v=1680151864	f
8211467174127	Danielle Top Maroon	Our best-selling Danielle Top in a limited edition holiday color! Zigzag Knit Top made from finely knitted cotton yarns, great for your daily fits. Designed in a relaxed silhouette, with puffed sleeves and added ruffle sleeve hem	100% Cotton	ALL SIZE	http://dumaofficial.com/cdn/shop/files/DanielleTopMaroon.jpg?v=1701935499	f
8198588858607	Frank Cropped Blazer Brown	Crafted from premium Japanese polyester, this single-breasted blazer in chic dark brown, is expertly tailored with defined padded shoulders, folded over wide sleeves, and the perfect cropped length. Highlight the ultra cropped length by styling it with our Harlow pants.	100% Japanese made Premium Polyester	ALL SIZE	http://dumaofficial.com/cdn/shop/files/FrankBlazerBrown.jpg?v=1700801450	f
7471339405551	Marilou Top Maroon	Structured top with contoured waistline, perfect for a formal event, or a regular day out! Knitted from soft cotton yarns, this is as cozy as it is sophisticated. Pair it with our Gale Skirt to get the perfectly elegant look this holiday season!	100% Cotton	All Size	http://dumaofficial.com/cdn/shop/products/WhatsAppImage2021-12-07at13.42.28_3.jpg?v=1638861365	f
8289518747887	Heather Leather Dress Brown	This mini dress is a refined take on our best selling leather. Shaped in an A-line silhouette, it's designed with a rounded neckline and side slip pockets in classic brown hue.	100% Polyester	Small, Medium, Large	http://dumaofficial.com/cdn/shop/files/Artboard2_2.png?v=1708571463	f
7471316467951	Carol Pants Navy	Get cozy and festive this christmas with our Carol Pants Navy! Knitted from soft cotton yarn into the perfect palazzo knit pants, featuring a high rise, wide leg and a relaxed fit. Pair it with our Noel Top or Jolly Cardigan for the ultimate holiday outfit for your festivities!	100% Cotton	S -M , M - L	http://dumaofficial.com/cdn/shop/products/WhatsAppImage2021-12-07at17.54.37_3.jpg?v=1638923722	f
8843352211695	Dorothy Top | Navy	Add a touch of elegance to your wardrobe with this classic cable knit top. Featuring a flattering V-neckline and a front closure adorned with sparkling diamond-shaped buttons, this piece blends timeless style with a hint of glamour. Perfect for layering or wearing on its own, it’s a versatile choice for both casual and dressy occasions.	100% Cotton	ALL SIZE	http://dumaofficial.com/cdn/shop/files/DOROTHYTOPNAVY-1_2c44b405-7e34-48b3-b037-20ff142f0860.jpg?v=1734422462	f
8498232885487	Carolina Vest Navy Stripe	Focusing on classic tailoring this season, this waistcoat is meticulously crafted from premium polyester blend suiting fabric and designed with a contoured waist and a rounded hem for a more feminine touch. Style it with wide-legged trousers or midi skirt for the perfect clean girl look!	100% Polyester	S, M, LMeasurement :	http://dumaofficial.com/cdn/shop/files/CAROLINAVESTNAVYSTRIPE-2.jpg?v=1715741573	f
7767167729903	Ganuli Shirt Blue	Basic button down shirt with v-neckline, flat collar and batwing sleeves. The soft fabric makes this shirt the perfect office attire for your work from office days, keeping you comfy all day while still looking presentable! Pair it with our Toja pants to look effortlessly put together while staying comfortable.	100% TENCEL	Reguler, Oversized	http://dumaofficial.com/cdn/shop/products/CATALOGUE17AUG_GANULIBLUEArtboard19.jpg?v=1659348002	f
8824610586863	MMEHUILLET FOR DUMA - Oreum Dress | White Multi	A combination of sophistication and modern glam, Oreum Dress features a straight neckline and rhinestone-adorned shoulder straps. Cut in a classic A-line silhouette that flatteringly hugs the body and completed with a back zipper opening that ensures an easy fit. Perfect for an evening out or a special occasion, this dress effortlessly blends elegance with contemporary style.	100% Polyester	1, 2	http://dumaofficial.com/cdn/shop/files/OreumDressWhite-2.jpg?v=1732725335	f
8295198327023	RACHEL | Slim Fit Scoop Neck in Dark Grey	A wardrobe staple offered in a subdued dark grey shade, it’s crafted from soft and stretch lyocell and has a streamlined slim fit and flattering scoop neckline that's ideal for your everyday wear.	100 % Lyocell Blend	Small, Medium	http://dumaofficial.com/cdn/shop/files/LEN-DUMA-6867-edit.jpg?v=1718842069	f
8060403974383	Brea Zip Up Sweater	This relaxed zip up jumper is crafted from soft rayon, twisted to create a comfy knit. The laid-back piece is completed with high ribbed neckline, dropped shoulders, ribbed waistband and loose sleeves. Pair it with our Nehru jogger Pants for the perfect airport/ lounge outfit!	100% RAYON	ALL SIZE (FIT TO XL)	http://dumaofficial.com/cdn/shop/files/BreaZipSweaterWhite-3.jpg?v=1685034307	f
8218799669487	Morris Leather Pants Silver	Jumpstart the party season with this fun metallic pants! This pant is crafted from the perfect metallic silver faux leather fabric and designed as a straight silhouette that taper down the legs and with ankle-length hems, finished with front patch pocket	100% Polyester	S, M, L	http://dumaofficial.com/cdn/shop/files/MorrisPantsSilver-2.jpg?v=1702572175	f
7975352140015	Marmo Pants Red	Our Marmo satin pants are printed with our special geometric pattern and fits high-waisted with an elasticated waistband and have relaxed legs that fall to tapered hems. Pair yours with the matching Mudan Blazer and strappy heels for a statement look.	100% Polyester	Size 1, Size 2	http://dumaofficial.com/cdn/shop/products/MarmoPantsRed.jpg?v=1673496960	f
8896426836207	Jorja Top | Dark Brown	This sleeveless structured top exudes sophistication with its high mandarin collar and sleek tailored fit. Designed in a rich dark brown hue, it features a statement gold button closure that adds a touch of elegance and refinement. The flap pockets enhance its polished appeal, while the subtly curved hem provides a flattering silhouette. Perfect for both formal and chic casual looks, this top pairs effortlessly with tailored trousers or denim for a versatile, fashion-forward ensemble.	100% Japanese made Premium Polyester	1, 2	http://dumaofficial.com/cdn/shop/files/JORJATOPBROWN-1.jpg?v=1745991438	f
8913076879599	Polan Houndstooth Top | White Multi	This sleeveless structured top exudes sophistication with its high mandarin collar and sleek tailored fit. Designed in a classic houndstooth pattern tweed, it features a front covered button closure that adds a touch of elegance and refinement. The flap pockets enhance its polished appeal, while the subtly curved hem provides a flattering silhouette. Perfect for both formal and chic casual looks, this top pairs effortlessly with our matching Rum Houndstooth Shorts, or our Balestra Skirt for a more elegant look.	Poly Blend	Small, Medium, Large	http://dumaofficial.com/cdn/shop/files/PolanHoundstoothTop.jpg?v=1741854979	f
8860273606895	Sorrel Pants | Cherry Red	Elevate your look with these effortlessly chic high-waisted satin pants. Designed with a bias cut for a beautifully fluid drape, they feature an easy wide-leg silhouette that moves gracefully with every step. The slip-on style and elasticized waistband ensure a comfortable, flattering fit, making these pants perfect for both casual and dressy occasions. Pair them with your favorite top for a polished yet relaxed vibe.	100% Polyester	Small, Medium	http://dumaofficial.com/cdn/shop/files/SORRELPANTSCHERRY-2.jpg?v=1736914611	f
8843351294191	Dorothy Top | Maroon	Add a touch of elegance to your wardrobe with this classic cable knit top. Featuring a flattering V-neckline and a front closure adorned with sparkling diamond-shaped buttons, this piece blends timeless style with a hint of glamour. Perfect for layering or wearing on its own, it’s a versatile choice for both casual and dressy occasions.	100% Cotton	ALL SIZE	http://dumaofficial.com/cdn/shop/files/DOROTHYTOPMAROON-3_83af8631-5c26-4544-ab79-0321c4344d47.jpg?v=1734484376	f
8842747052271	Dachshund Vest | Black - Red	Bringing a festive twist to our best-selling knit top this season. Knitted from structured but soft 100% cotton yarn in a relaxed, boxy cut that’s suitable for all body types. The contrasting dachshund puppy in Christmas hat, embroidered in fully chenille yarn adds extra festive points that will definitely make you stand out in the crowd! What's even better, you can twin with your family and friends in this top!	100% Cotton	1, 2	http://dumaofficial.com/cdn/shop/files/DACHSHUNDTOPBLACK-RED-5.jpg?v=1734494355	f
8947918569711	Baram Pants | Black	A pair of versatile pants to wear on repeat, Baram Pants was thoughtfully designed with a straight-leg silhouette that provides a timeless and flattering look. The soft and stretchy denim offers freedom of movement all day, everyday. Detailed with small front pockets that add functionality and a touch of uniqueness to the overall look. Pair it with any top in your wardrobe, or wear it as a set with our Sunsu Shirt.	70% cotton, 27% viscose, 3% elastane	Small, Medium, Large	http://dumaofficial.com/cdn/shop/files/BARAMPANTSBLACK-5_9cae9066-d46b-4125-b5d5-4b795d8aca1e.jpg?v=1745989270	f
8005286330607	Bahia Outer Black	Knitted from pure cotton yarns shaped for a classic fit with a cropped hem that works particularly well with any bottoms you have. It has a close round neck, Hand stitching patch pocket	100% Cotton	ALL SIZE	http://dumaofficial.com/cdn/shop/products/BahiaOuterBlack-6.jpg?v=1677199813	f
8081704911087	Kai Shorts Navy	Knitted from soft cotton yarns, this easy pull-on tartan plaid shorts styles perfectly with any clothing piece you can think of! They're shaped for a classic cut with comfortable elastic waistbands. For a complete set, pair it with our Balma Cardigan.	100% COTTON	All Size	http://dumaofficial.com/cdn/shop/files/KaiShortsNavy1.png?v=1688920786	f
8498485231855	Miguel Polo Top Grey	Reworking the classic polo shirt with our own touch for the season ahead. Offered in cool grey, it's crafted from fine polyester yarns to created a structured fit. Design	100% Polyester	1, 2	http://dumaofficial.com/cdn/shop/files/MIGUELPOLOTOPGREY-2.jpg?v=1715741162	f
8252026028271	Samara Jacquard Dress Floral Multi	SHIPMENT (1-3 February 2024) Giving our own tweak to traditional tailoring, this dress has short sharp sleeves, the perfect mini length and contoured waist that gives the perfect hourglass figure. Featuring a Chinese floral watercolor print jacquard to make it the perfect simple outfit for this CNY season. Model : 175 cm	100% Cotton	1, 2	http://dumaofficial.com/cdn/shop/files/SamaraJacquardDress.jpg?v=1706001713	f
8196111565039	Nehru Jogger Pants Black	These jogger-style off white trousers are made from finely knitted soft rayon. A relaxed fit that taper slightly towards the ribbed hem, and with a comfortable elasticated waist for all day wear. Complete the look with our Brea Zip Up sweater.	100% RAYON	ALL SIZE (FIT TO XL)	http://dumaofficial.com/cdn/shop/files/BreaSweaterBlack_0d57e2db-0ded-4cd1-a80c-2fb18354ea7c.jpg?v=1700799128	f
8792602640623	Jennie Tanktop | Maroon	An essential for your daily wardrobe, especially those warmer days. Offered in a chic maroon tone, it’s crafted from soft lyocell blend and has a streamlined slim fit with endless styling opportunities - wear it alone or layered under shirts and blazers.	76% Lyocell, 19% Wool, 5% Spandex	ALL SIZE (Fit to L)	http://dumaofficial.com/cdn/shop/files/JENNIETANKTOPMAROON-4_dbeae847-77ba-4fb5-ae77-a2dc491183f2.jpg?v=1729130876	f
7696632578287	Petra Shorts Grey	Knitted from soft cotton yarns, our Petra shorts is the perfect loungewear shorts for you! Easy pull-on shorts with fun wave pattern and a monochromatic color palette, it styles perfectly with any clothing piece you can think of! Pair it with our Calya Cardigan to make you look effortlessly chic on your lazy days.	100% Cotton	ALL SIZE	http://dumaofficial.com/cdn/shop/products/petra4.jpg?v=1654826969	f
7946298261743	Ansel Cardigan Red	Knitted from soft viscose yarns, this V-neck cardigan is designed for a regular fit and features a subtly nipped-in waist. It has modern tubular trims, finished with front button closure and ribbed cuffs and hems. The perfect luxurious loungewear you need in your wardrobe!	Soft Viscose	All Size	http://dumaofficial.com/cdn/shop/products/AnselCardiganRed.jpg?v=1670552691	f
9001307111663	Garland Sweater | Black	Shawl neckline sweater with multiple styling options, made from a mid-weight cotton knitting and featuring an intricate rib stitch. It has an oversized fit for casual sophistication. Pair it with our Sorrel Satin Pants for a comfortable yet stylish holiday/airport fit.	100% Polyester	ALL SIZE	http://dumaofficial.com/cdn/shop/files/GARLANDSWEATERBLACK1.jpg?v=1750823749	f
8198584860911	Caba Blazer Ginger Brown	Our Caba Blazer is a special tailoring piece that features a collarless neckline, wide padded shoulders, and a single-breasted close. Offered in the perfect autumn shade of ginger brown that's precisely color-matched to the coordinating Harlow Pants.	100% Japan made Premium Polyester	ALL SIZE	http://dumaofficial.com/cdn/shop/files/transitArtboard1.jpg?v=1700800216	f
9024434798831	Naxos Shorts | Dark Denim	Naxos Shorts is a straight cut silhouette with timeless classic blue denim shade and structured fabric make these shorts perfect for stylish everyday wear. The unique waistband detail makes this piece not just functional, but also an edgy and modern statement.	80% Cotton, 17% Rayon, 3% Spandex	Small, Medium, Large	http://dumaofficial.com/cdn/shop/files/NaxosShortsDarkDenim4.jpg?v=1753843301	f
9024411500783	Agea Top | Cedar	Classic but memorable. An A-line cut top in smooth and luxurious fabric that enhances its minimalist appeal. Designed with a clean round neckline and halter cut, Agea is a versatile top that can be worn in any kind of occasions – be it a casual brunch with the girls or a long-awaited dinner date. Pair this flowy piece with our best-selling Tan Pants for a chic, matching set look.	100% Polyester	1, 2	http://dumaofficial.com/cdn/shop/files/AgeaTopCedar1.jpg?v=1753697743	f
7696641097967	Zuru Dress Navy	Knitted with soft cotton yarns, this lightweight straight maxi dress comes in classic navy. It's designed to perfectly compliment all body types with its perfect silhouette. The pointed collar, button closure down the center front and ribbed texture are smart finishing touches to complete this dress. Can be styled universally, as a dress, top, or even as an outer!	100% Cotton	ALL SIZE	http://dumaofficial.com/cdn/shop/products/zuru1.jpg?v=1654771054	f
8030789697775	Buckham Blazer Black	There's nothing like a good pair of classic blazer that will stay in your wardrobe staple for a very long time. This one in classic black is shaped for a contouring fit with lightly padded shoulders and darts at the front and back to define the waist. This double-breasted blazer is tailored with high peak lapels. and a pair of front flap pockets. Perfect to throw over any outfit to make you look effortlessly put together!	100% Polyester	S, M, L	http://dumaofficial.com/cdn/shop/products/BuckhamBlazerBlack-3.jpg?v=1680152047	f
7455669780719	Noor Skirt Black	A knit skirt made of a slub-melange, ribbed cotton handmade knit. It features a midi length, A-line silhouette, and a slimming knit pattern, a perfect go to piece for your day to night look! Pair it with our Arlet Top for an effortlessly elegant and sophisticated look.	100% Cotton	All Size ( Fit To Large )	http://dumaofficial.com/cdn/shop/products/Artboard10_96aa7ecf-1623-4121-a89a-9ae02c455a53.png?v=1637736641	f
8818183438575	Jennie Tanktop | Black	An essential for your daily wardrobe, especially those warmer days. Offered in a black tone, it’s crafted from soft lyocell blend and has a streamlined slim fit with endless styling opportunities - wear it alone or layered under shirts and blazers.	76% Lyocell, 19% Wool, 5% Spandex	ALL SIZE (Fit to L)	http://dumaofficial.com/cdn/shop/files/JennieTanktopBlack-1.png?v=1731576967	f
8825019891951	MMEHUILLET FOR DUMA - Hwi Scarf | Taupe	Crafted from soft structured cotton, this hybrid poncho doubles as a scarf that can be draped over the shoulder for an effortless look. Secured with a single button on one shoulder that you can accessorize with our clip-on buttons. The dynamic silhouette and timeless color palette offer endless styling potential.	100% Cotton	ALL SIZE	http://dumaofficial.com/cdn/shop/files/HwiScarfTaupe.jpg?v=1732724769	f
8824632770799	MMEHUILLET FOR DUMA - Baram Pants | Denim White	A pair of versatile pants to wear on repeat, Baram Pants was thoughtfully designed with a straight-leg silhouette that provides a timeless and flattering look. The soft and stretchy denim offers freedom of movement all day, everyday. Detailed with small front pockets that add functionality and a touch of uniqueness to the overall look. Pair it with any top in your wardrobe, or wear it as a set with our Sunsu Shirt.	70% cotton, 27% viscose, 3% elastane	Small, Medium, Large	http://dumaofficial.com/cdn/shop/files/BaramPantsWhite-2.jpg?v=1732725198	f
8665228214511	Alba Linen Skirt | Pink	Mini Skirt crafted from our pinstripe linen fabrication, our Alba Linen Skirt is an essential piece for your staple summer wardrobe. Designed to sit mid-waist, this skirt exudes classic sophistication as it is cut straight and finishes upper-mid thigh. It features a waistband, belt hoops and secures with a center zip fly.	100% Linen	Small, Medium, Large	http://dumaofficial.com/cdn/shop/files/ALBALINENSKIRTPINK-4.jpg?v=1720522045	f
7867716829423	Malo Sweater Grey	Crafted from soft cotton fabric, this zip-up cardigan is cut for a relaxed fit and features a feminine wave pattern, ribbed hem finishing, and a statement oversized collar. Perfect to accompany u throughout your daily activities! Pairs perfectly with our Petra shorts.	100% Cotton	All Size	http://dumaofficial.com/cdn/shop/products/Artboard1_834f0147-7b00-4b04-81d0-9b2482c3158d.png?v=1664889167	f
8196252336367	Maray Vest Top Blue	Inspired from traditional suiting, we designed this vest with a v-neckline, adjustable belt tab, and a row of tonal buttons into the perfect fit. Style it with our Vesper pants as a set, or with your favorite maxi skirts or jeans.	100% Japanese made Premium Polyester	1, 2	http://dumaofficial.com/cdn/shop/files/MarayVestBlue.jpg?v=1700778711	f
8986641989871	Eloise Top | Cream	A sleeveless crochet top featuring a boxy silhouette and rounded neckline. Detailed with front buttons and contrast hand-stitched detail for a refined, artisanal touch. This piece brings texture and polish—perfect for pairing with denim for a casual statement or styled with the matching skirt for a coordinated set.	Recycled Polyester	1, 2	http://dumaofficial.com/cdn/shop/files/ELOISETOPCREAM4.jpg?v=1750900218	f
8897200947439	Iggy Top | White	Elevate your everyday style with our Iggy Top! Crafted from soft and stretch viscose yarn with ribbed detailing, this top exudes a modern and effortless appeal. This tank design features an off-center placket with tonal buttons, and a flattering, form-hugging fit. Pair it with your favorite high-waisted jeans for a casual-chic look or layer it under a blazer for a polished finish—versatile and stylish, it's a must-have staple for any wardrobe.	Soft Viscose	ALL SIZE (Fit To L)	http://dumaofficial.com/cdn/shop/files/IGGYTOPWHITE-1.jpg?v=1740366032	f
8218759266543	Veste Tweed Vest Black	Taking inspiration from traditional suiting, we created this special vest that is perfect for this holiday season. Crafted from luxe and sparkly tweed and has a deep V-neckline, shaping darts, and a row of fancy gold floral buttons. Pairs perfectly with any bottoms you can think of!	100% Polyester	1, 2	http://dumaofficial.com/cdn/shop/files/VesteTweedVest.jpg?v=1702537508	f
7946305274095	Zuru Dress Green	Knitted with soft cotton yarns, this lightweight straight maxi dress comes in holiday green. It's designed to perfectly compliment all body types with its perfect silhouette. The pointed collar, button closure down the center front and ribbed texture are smart finishing touches to complete this dress. Can be styled universally, as a dress, top, or even as an outer!	100% Cotton	ALL SIZE	http://dumaofficial.com/cdn/shop/products/ZuruDressGreen_5.jpg?v=1670552410	f
8896417726703	Giara Top | Dark Denim	This denim top features a classic button-down front with metallic buttons. It has a micro sleeve, round neckline and an A-line silhouette, giving it a casual yet polished look. The dark-wash denim fabric provides a sleek and sophisticated appeal with a slimming effect, making it a versatile piece that can be worn with your favorite bottoms or with our matching Riri Pants | Dark Denim.	100% Cotton	ALL SIZE	http://dumaofficial.com/cdn/shop/files/GIARATOPDARKDENIM-3.jpg?v=1740549548	f
7740273590511	Darcie Top Black	Knitted from soft cotton yarns, this v-neck top has a flattering curved yet relaxed fit and femine ruffle	100% COTTON	All Size	http://dumaofficial.com/cdn/shop/products/FUNDAMENTALSRESIZEDCATALOGArtboard62.jpg?v=1657770134	f
8211469664495	Laurent Vest Cardigan Red	Our Best Selling Laurent Vest Cardigan in a limited edition holiday color! An elevated two-in-one piece featuring an oversized cardigan and a sewn-in vest top inside to keep you warm and stylish during your travelling days. Pair it with our best selling Pralu pants for a comfy and minimalistic, stylish look.	Soft Viscose	ALL SIZE (FIT TO XL)	http://dumaofficial.com/cdn/shop/files/LaurentVestCardiMaroon-3.jpg?v=1701995561	f
8742223577327	Petunia Dress | Black	A classic LBD that would make you bloom like a beautiful flower. Crafted from 100% Japanese-made premium polyester, this dress has a unique cut-and-sewn detail you’ve never seen before. It’s cinched at the waist, with a little bit of space for comfortable movements, then flares down prettily into a peplum mini skirt. Designed with a simple round-neck cut and a regular-fitting bodice to keep the whole look sophisticated.	100% Japanese made Premium Polyester	Small, Medium, Large	http://dumaofficial.com/cdn/shop/files/PETUNIADRESSBLACK-5.jpg?v=1724753455	f
8005161746671	Martis Flared Pants Bone	Cut from premium stretch woven fabric in a high-rise, flared silhouette, these floor-length pants are fitted at the hips and thigh and flared at hem, creating the perfect elongated legs. This pants will be an essential piece in your wardrobe as they're comfortable but still look put together.	100% Japan made Premium Polyester	1, 2	http://dumaofficial.com/cdn/shop/products/MartisPantsBone-2.jpg?v=1677201214	f
8843354669295	Remmy Skort | Camel	Our best-selling Remmy Skort, now in new colors and fabric, perfect for the winter season! It has an A-line silhouette knife pleats and an inner shorts for effortless movements. Pair it with your favorite sweater for a cozy winter fit.	100% Polyester	1, 2	http://dumaofficial.com/cdn/shop/files/REMMYSKORTCAMEL-1.jpg?v=1734421866	f
7740223979759	Marin Cardigan Brown	Knitted from very soft and elastic viscose yarns, this calf-length cardigan with v-neckline, front button closure and side slit is a must have in every women's wardrobe. With its relaxed fit, its very easy to style with any outfit or for any occasions.	SOFT VISCOSE	ALL SIZE	http://dumaofficial.com/cdn/shop/products/FUNDAMENTALSRESIZEDCATALOGArtboard7.jpg?v=1657770918	f
9024410321135	Agea Top | Black	Classic but memorable. An A-line cut top in smooth and luxurious fabric that enhances its minimalist appeal. Designed with a clean round neckline and halter cut, Agea is a versatile top that can be worn in any kind of occasions – be it a casual brunch with the girls or a long-awaited dinner date. Pair this flowy piece with our best-selling Tan Pants for a chic, matching set look.	100% Polyester	1, 2	http://dumaofficial.com/cdn/shop/files/AgeaTopBlack2.jpg?v=1753853620	f
8843359682799	Sorrel Pants | Brown	Elevate your look with these effortlessly chic high-waisted satin pants. Designed with a bias cut for a beautifully fluid drape, they feature an easy wide-leg silhouette that moves gracefully with every step. The slip-on style and elasticized waistband ensure a comfortable, flattering fit, making these pants perfect for both casual and dressy occasions. Pair them with your favorite top for a polished yet relaxed vibe.	100% Polyester	Small, Medium, Large	http://dumaofficial.com/cdn/shop/files/SORRELPANTSBROWN-1.jpg?v=1734421490	f
9024386564335	Sante Pants | Black	An essential for the sunny weather, this pair of straight-linen pants are a must-have for those who adore clean and minimalist aesthetic. Crafted from breathable, natural linen, it features a soft, full-length breezy lining for added comfort. The elasticated waistband offers a flexible, pull-on fit – perfect for everyday wear or an impromptu summer escape.	100% Linen	Small, Medium, Large	http://dumaofficial.com/cdn/shop/files/SantePantsBlack1.jpg?v=1753693681	f
8913528520943	Jaoni Dress | Black Multi	Elevate your wardrobe with this timeless black-and-white houndstooth knit dress. Designed with a classic A-line silhouette, this sleeveless dress offers a flattering fit that flows effortlessly. The soft yet structured knit fabric ensures all-day comfort, while the round neckline adds a touch of sophistication. Perfect for any occasion, from casual outings to chic evening gatherings, this versatile piece pairs beautifully with heels or flats.	100% Cotton	ALL SIZE	http://dumaofficial.com/cdn/shop/files/JaoniDress-2.jpg?v=1741925305	f
8295197442287	RACHEL | Slim Fit Scoop Neck in Grey	A wardrobe staple offered in cool grey shade, it’s crafted from soft and stretch lyocell and has a streamlined slim fit and flattering scoop neckline that's ideal for your everyday wear.	100 % Lyocell Blend	Small, Medium	http://dumaofficial.com/cdn/shop/files/LEN-DUMA-6569-edit.jpg?v=1718842125	f
8860253061359	Zhen Top | Maroon	An unforgettable luxurious velvet top that features a refined Mandarin collar and pretty pearl buttons. Its A-line silhouette that was tailored from structured, lined fabric, provides a flattering and comfortable fit for a sleek yet relaxed look. With sumptuous velvet fabric that adds depth and richness, Zhen Top is perfect for that long-awaited events and dinners. Pair it with our Tan pants or a flowing skirt for an effortlessly chic ensemble.	100% Polyester	1, 2	http://dumaofficial.com/cdn/shop/files/ZHENTOP-3.jpg?v=1736913813	f
8233619161327	Grego Leather Blazer Maroon	The silhouette of this leather jacket is inspired by the classic pea coats. Tailored with a double-breasted closure, it's crafted from buttery faux leather and shaped with softly padded shoulders, notch lapels, and a full lining for easy layering. For a complete set, wear with our matching Glacer Skirt.	100% Polyester	All Size	http://dumaofficial.com/cdn/shop/files/LeatherBlazerMaroon.jpg?v=1704431456	f
7455663685871	Jola Pants Blue	A must-have pant made of slub-melange, ribbed cotton knit, perfect for going out or lounging around. Featuring a mid-rise, cropped length, and straight fit, perfect for a casual, everyday look. Pair it with our Piccolo Top or a simple white shirt and you're ready to get going!	100% Cotton	All Size ( Fit to Large )	http://dumaofficial.com/cdn/shop/products/Artboard62_a088283a-9991-4ef0-9435-880950a04fef.png?v=1637736457	f
9024397902063	Shiba Top | Butter	PREORDER 10 WORKING DAYS Meet Shiba Top, a blouse that can seamlessly transition from day to night occasions. Detailed with ruched waist and boat-neck cut, hugging your body flatteringly. Its side zipper opening and lining maintain the clean look of this contemporary top, and the structured yet smooth fabric keeps this piece’s carefully-designed silhouette in perfect shape.	100% Japanese made Premium Polyester	Small, Medium, Large	http://dumaofficial.com/cdn/shop/files/EliaTopButter2.jpg?v=1753852870	f
7946305732847	Zuru Dress Maroon	Knitted with soft cotton yarns, this lightweight straight maxi dress comes in holiday maroon. It's designed to perfectly compliment all body types with its perfect silhouette. The pointed collar, button closure down the center front and ribbed texture are smart finishing touches to complete this dress. Can be styled universally, as a dress, top, or even as an outer!	100% Cotton	ALL SIZE	http://dumaofficial.com/cdn/shop/products/ZuruDressMaroon_4.jpg?v=1670552370	f
8843353587951	Claus Cardigan With Rhinestones | Navy	This elegant cable knit cardigan is a perfect blend of cozy and chic for this festive season. Featuring a timeless V-neckline and intricate cable detailing, it’s elevated with sparkling bedazzled appliqué around the neckline for a touch of glamour. The hook-and-eye closures add a delicate finish, making it versatile enough to wear open or closed. Perfect for layering over dresses or pairing with your favorite pair of bottom for a polished, standout look. Please note: the appliqué design may vary slightly from the picture, making each piece uniquely yours.	100% Cotton	ALL SIZE (Fit To M)	http://dumaofficial.com/cdn/shop/files/CLAUSCARDIGANWITHRHINESTONESNAVY-1.jpg?v=1734492671	f
8860235137263	Lim Top | Mustard	A clean-cut top with A-line silhouette that features an elegant combination of modernity and tradition. This piece is designed with puffed cap sleeves that add a touch of flattering contrast to its high collar. The standout feature is a pair of artisanal mandarin buttons — crafted in an intricate design, adding a decorative and functional detail. Made from high-quality structured satin, Lim Top offers a luxurious feel and a slight sheen for that special occasion.	100% Polyester	ALL SIZE	http://dumaofficial.com/cdn/shop/files/LIMTOPMUSTARD-2.jpg?v=1736914166	f
8825020252399	MMEHUILLET FOR DUMA - Olbit Cardigan | Taupe	SHIPMENT JANUARY The kind of cardigan you would snuggle in with, this piece was knitted from the softest and comfiest viscose yarns. Versatile with a touch of unexpected twist, it can be styled both as a regular and asymmetrical cardigan, with its adjustable side buttons. Completed with a flattering deep V-neckline and detachable chic scarf, Olbit Cardigan is definitely an unforgettable scene-stealer.	Soft Viscose	ALL SIZE	http://dumaofficial.com/cdn/shop/files/OlbitCardiganTaupe.jpg?v=1732724716	f
9000450130159	Fray Pants | Dark Denim	These straight-leg jeans are crafted from dark indigo denim with a structured fit and clean finish. Featuring a unique frayed waistband for a raw, modern edge, they offer a minimalist look with subtle detail. A versatile staple with classic pockets and a timeless cut.	80% Cotton, 17% Rayon, 3% Spandex	Small, Medium, Large	http://dumaofficial.com/cdn/shop/files/FRAYDENIMPANTS3.jpg?v=1750836062	f
9000418803951	Rhima Top | Soft Pink	This timeless knit top with a classic round neckline and streamlined silhouette is a must-have wardrobe staple for any weather. Designed in a pretty soft pink shade, it offers both minimalist elegance and a touch of subtle femininity. Its lightweight, breathable cotton material makes it perfect for layering, or wearing on its own.	100% Cotton	ALL SIZE	http://dumaofficial.com/cdn/shop/files/RHIMATOPSOFTPINK2.jpg?v=1750835966	f
8751853666543	Sophie Skort | Denim White	Introducing Sophie Skort | Denim White, a chic white denim mini skort that’s going to easily match any top in your wardrobe. Its medium-weight denim material holds the skort’s structure firmly and the built-in short pants inside ensures comfort in your daily activities. Completed with a front zipper opening and pockets detail for utility, this is definitely the kind of piece you’ll be wearing a thousand times and more.	70% Cotton, 30% Polyester	Small, Medium, Large	http://dumaofficial.com/cdn/shop/files/3656E2D3-B4E2-4C86-90F9-A560A879F913.jpg?v=1725878475	f
8860227698927	Fuqi Top | Maroon	A fusion of modern design and traditional influences. Designed with a refined Chinese collar, the halter neckline adds a distinctive touch with its high, mandarin-inspired style. The top’s silhouette gracefully transitions into a fit-and-flare design, contouring the bodice for a flattering fit. Completed with a back zipper opening for an easy and comfortable wear.	100% Polyester	1, 2	http://dumaofficial.com/cdn/shop/files/FUQITOPMAROON-1_1.jpg?v=1736841660	f
7946308813039	Maya Blazer Maroon	Knitted from soft cotton yarns into the perfect blazer top design and silhouette, finished with shoulder pads and covered buttons. Something you never knew you needed in your capsule wardrobe. Undeniably comfortable, suitable for formal or business casual events, keeps you looking professional yet comfortable for your important meetings. The perfect work outfit for you this festive season!	100% COTTON	All Size	http://dumaofficial.com/cdn/shop/products/MayaTopMaroon_4.jpg?v=1670331472	f
8211476185327	Apollo Denim Pants	We designed these jeans with laid back silhouette in mind. High-rise and cut with loose, straight legs, they’re crafted from rigid cotton denim that'll slightly stretchy and will hold it's shape. Perfect for a casual everyday fit.	100% Cotton	S, M, L	http://dumaofficial.com/cdn/shop/files/ApolloDenimPants-3.jpg?v=1702002537	f
9024416547055	Iroco Top | Blue Multi	Summer is for playful patterns. Iroco Top was designed with a beach look in mind, with its fun denim blue - cream stripes and crochet texture. Cut in a boxy silhouette and completed with a chic one-button opening, this piece will surely fit in your summer escape wardrobe. Pair it with our Naxos for a casual, laid-back outfit, or with Vento Short for a cute, matching set look.	Recycled Polyester	1, 2	http://dumaofficial.com/cdn/shop/files/IrocoTopBlueMulti2.jpg?v=1753852650	f
7947525685487	Ginza Mini Dress Green	Crafted from soft tencel fabric in everyone's go to white shade, this mini shirt dress has fitted shoulders and an A-line silhouette. The concealed placket, front panel detail, and pointed collar make it feel equally smart and effortless. Versatile piece you can wear as a dress, outer, or even tunic!	TENCEL MODAL	ALL SIZE	http://dumaofficial.com/cdn/shop/products/GinzaDressSage_2.jpg?v=1670330775	f
8792612339951	Jennie Tanktop | Dark Brown	An essential for your daily wardrobe, especially those warmer days. Offered in a rich dark brown tone, it’s crafted from soft lyocell blend and has a streamlined slim fit with endless styling opportunities - wear it alone or layered under shirts and blazers.	76% Lyocell, 19% Wool, 5% Spandex	ALL SIZE (Fit to L)	http://dumaofficial.com/cdn/shop/files/JENNIETANKTOPDARKBROWN-2.jpg?v=1729052512	f
7740234367215	Toja Pants White	Basic pair of pants that you never know you needed! Knitted from soft cotton yarns into the perfect long white pants silhouette that gives your legs an ellongated effect, completed with drawstring	100% Cotton	ALL SIZE	http://dumaofficial.com/cdn/shop/products/FUNDAMENTALSRESIZEDCATALOGArtboard60.jpg?v=1657770811	f
8818180096239	Ang T-Shirt | Grey	Secure your transitional wardrobe with this staple long-sleeved mock neck top. Offered in a grey tone, it’s crafted from soft lyocell blend and has a streamlined slim fit that’s ideal for layering.	76% Lyocell, 19% Wool, 5% Spandex	ALL SIZE (Fit to L)	http://dumaofficial.com/cdn/shop/files/AngT-ShirtGrey-3.png?v=1731576603	f
7975349747951	Ansel Cardigan Orange	Knitted from soft viscose yarns, this V-neck cardigan is designed for a regular fit and features a subtly nipped-in waist. It has modern tubular trims, finished with front button closure and ribbed cuffs and hems. The perfect luxurious loungewear you need in your wardrobe!	SOFT VISCOSE	All Size	http://dumaofficial.com/cdn/shop/products/AnselCardiganOrange.jpg?v=1673497378	f
8840020263151	Gerbera Dress With Floral Appliqués | Red	An elevated version of our Gerbera Dress, this one is filled with intricate 3D floral and sequin appliques delicately handstitched throughout the design. Featuring a high neckline, a flattering A-line silhouette, and a sleeveless cut, it offers a perfect blend of sophistication and glamour. The shimmering sequin	100% Japanese made Premium Polyester	ALL SIZE	http://dumaofficial.com/cdn/shop/files/GERBERADRESSRED_WithFloralAppliques_-1.jpg?v=1736858933	f
8498260541679	Harper Pants Navy Stripe	Crafted from premium polyester blend suiting fabric, these baggy trousers have pleats through the front to elongate the wide legs and two button	100% Polyester	S, M, LMeasurement :	http://dumaofficial.com/cdn/shop/files/HARPERPANTSNAVYSTRIPE-8.jpg?v=1715741407	f
8742178029807	Fleur Satin Top | Blue	A piece to remember, this halter-neck satin top with an easy A-line fit is casual but not basic. Sewn carefully from silky smooth satin fabric and completed with dainty neck straps opening, Fleur Satin Top | Blue is the kind of piece you would reach out to for that long-awaited summer getaway. With a beautiful Iris flower as the cherry on top, you will most definitely be the trend-setter of the season.	100% Polyester	1, 2	http://dumaofficial.com/cdn/shop/files/FLEURSATINTOPBLUE-5_5dc88083-0b0d-4644-8382-869ddff2e39b.jpg?v=1724885487	f
8005163122927	Martis Flared Pants Brown	Cut from premium stretch woven fabric in a high-rise, flared silhouette, these floor-length pants are fitted at the hips and thigh and flared at hem, creating the perfect elongated legs. This pants will be an essential piece in your wardrobe as they're comfortable but still look put together.	100% Japan made Premium Polyester	Small, Medium, Large	http://dumaofficial.com/cdn/shop/products/MartisPantsBrown-2.jpg?v=1677200877	f
8818177605871	Ang T-Shirt | Blue Grey	Secure your transitional wardrobe with this staple long-sleeved mock neck top. Offered in a blue grey tone, it’s crafted from soft lyocell blend and has a streamlined slim fit that’s ideal for layering.	76% Lyocell, 19% Wool, 5% Spandex	ALL SIZE (Fit to L)	http://dumaofficial.com/cdn/shop/files/AngT-ShirtBlueGrey-2.png?v=1731576148	f
7740496183535	Cara Cardigan Multi	Our Cara Knitted Cardigan will definitely be your new favorite on the go outer! Soft and comfy, this cardigan will be the perfect company for your daily errands, office attire, or even to hang out and chill with friends! Pair it with our Panna shorts as a set for a lazy day outfit, or our Toja pants for a more put-together casual look!	100% Cotton	All Size	http://dumaofficial.com/cdn/shop/products/FUNDAMENTALSRESIZEDCATALOGArtboard38.jpg?v=1657773075	f
8060710191343	Ira Crop T-shirt Taupe	Crafted from a sustainable premium Japanese polyester fabric that is luxuriously soft and cooling, this crop top is has the perfect fit with a straight cut, round neck and clean finishing. Pair it with the cargo pants for a cool and stylish look that provides all day comfort!	75% Polyester, 25% Cotton	1, 2	http://dumaofficial.com/cdn/shop/files/IraCropTshirtTaupe-5.jpg?v=1685033808	f
7790791557359	Julian Dress Grey	Knitted from very soft and elastic viscose yarns, this relaxed fit shirt dress features a straight fit and front pocket flaps for a laid-back, casual silhouette. The sleeve cuff and buttons	SOFT VISCOSE	ALL SIZE	http://dumaofficial.com/cdn/shop/products/CATALOGUE17AUG_GANULIBLUEArtboard29.jpg?v=1660705980	f
8901385748719	Ariel Cardigan Grey	Knitted from soft cotton yarns with sophisticated flower	100% Cotton	ALL SIZEMeasurement :	http://dumaofficial.com/cdn/shop/files/ARIELCARDIGANGREY-1_e0cbe726-8bab-4102-b68d-cc3cd94cf589.jpg?v=1745990162	f
\.


--
-- Data for Name: dim_variants; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dim_variants (variant_id, variant_name, availability, color) FROM stdin;
46549384757487	Size 1 / Black	InStock	Black
46549384790255	Size 2 / Black	InStock	Black
44136493842671	Size S / Black	OutOfStock	Black
44136493875439	Size M / Black	OutOfStock	Black
44136513175791	Size L / Black	OutOfStock	Black
44553781838063	All size / Beige	OutOfStock	Beige
46124927582447	All Size / #2B3856	OutOfStock	#2B3856
44253617029359	All Size / Black	OutOfStock	Black
43793305272559	All Size / Red	OutOfStock	Red
43040041205999	All Size / Black	OutOfStock	Black
46315771298031	All Size / White	OutOfStock	White
46063414640879	All Size / #c9b9ad	OutOfStock	#c9b9ad
46270361174255	Size Small / #000042	OutOfStock	#000042
46270361207023	Size Medium / #000042	OutOfStock	#000042
46270361239791	Size Large / #000042	OutOfStock	#000042
46328188829935	Size XL / #000042	OutOfStock	#000042
44136269119727	All Size / #2C3109	OutOfStock	#2C3109
45076697415919	Size 1 / Black	OutOfStock	Black
45076956905711	Size 2 / Black	OutOfStock	Black
44246415966447	Size 1 / #366AA4	OutOfStock	#366AA4
44246415999215	Size 2 / #366AA4	OutOfStock	#366AA4
44304810639599	Size 1 / Black	OutOfStock	Black
44304811327727	Size 2 / Black	OutOfStock	Black
46573580583151	Size 1 / Black	InStock	Black
46573580615919	Size 2 / Black	InStock	Black
42496742228207	All Size / White	OutOfStock	White
45808864067823	Size 1 / #FBFBFB	OutOfStock	#FBFBFB
45808864100591	Size 2 / #FBFBFB	OutOfStock	#FBFBFB
43989013233903	1 / #ff96cb	OutOfStock	#ff96cb
43989013627119	2 / #ff96cb	OutOfStock	#ff96cb
46549488500975	All Size / #572E19	InStock	#572E19
46662841336047	Size Small / #F7CAC9	OutOfStock	#F7CAC9
46662841368815	Size Medium / #F7CAC9	OutOfStock	#F7CAC9
46667799855343	Size Large / #F7CAC9	OutOfStock	#F7CAC9
43953581064431	All Size / White	OutOfStock	White
46063411986671	All Size / Grey	OutOfStock	Grey
44308620771567	Size S / Grey	OutOfStock	Grey
44308620804335	Size M / Grey	OutOfStock	Grey
44308631486703	Size L / Grey	OutOfStock	Grey
43645302407407	All Size / Maroon	OutOfStock	Maroon
46573587497199	Size 1 / Black	InStock	Black
46573587529967	Size 2 / Black	InStock	Black
45527314923759	Size Small / #FFFFF3	OutOfStock	#FFFFF3
45527314956527	Size Medium / #FFFFF3	OutOfStock	#FFFFF3
45527314989295	Size Large / #FFFFF3	OutOfStock	#FFFFF3
46414078279919	Size Small / Black	OutOfStock	Black
46414078312687	Size Medium / Black	OutOfStock	Black
46414078345455	Size Large / Black	OutOfStock	Black
43952829497583	All Size / White	OutOfStock	White
42146372845807	All Size / #02064a	OutOfStock	#02064a
42146394603759	All Size / Maroon	OutOfStock	Maroon
44660251951343	All Size / #FFFFE7	OutOfStock	#FFFFE7
45972973256943	All Size / #371d10	OutOfStock	#371d10
43040682246383	All Size / #02064a	OutOfStock	#02064a
46270334402799	Size Small / #186AB4	OutOfStock	#186AB4
46270348165359	Size Medium / #186AB4	OutOfStock	#186AB4
46270348198127	Size Large / #186AB4	OutOfStock	#186AB4
46328189452527	Size XL / #186AB4	OutOfStock	#186AB4
45075919405295	All Size / Black	OutOfStock	Black
46063415492847	Size 1 / Black	OutOfStock	Black
46063425093871	Size 2 / Black	OutOfStock	Black
43039856361711	All Size / Black	OutOfStock	Black
44136539980015	Size S / Beige	OutOfStock	Beige
44136540012783	Size M / Beige	OutOfStock	Beige
44136540045551	Size L / Beige	OutOfStock	Beige
46270381457647	Size 1 / #371d10	OutOfStock	#371d10
46270387945711	Size 2 / #371d10	OutOfStock	#371d10
44244945928431	All Size / Black	OutOfStock	Black
44075334140143	All Size / Black	OutOfStock	Black
44137330704623	Size 1 / Black	OutOfStock	Black
44137352102127	Size 2 / Black	OutOfStock	Black
42145903968495	All Size / #02064a	OutOfStock	#02064a
43790340292847	1 / Black	OutOfStock	Black
43790340325615	2 / Black	OutOfStock	Black
44246311502063	Size 1 / #996633	OutOfStock	#996633
44246311534831	Size 2 / #996633	OutOfStock	#996633
43642729070831	Size 1 / Green	OutOfStock	Green
43645550493935	Size 2 / Green	OutOfStock	Green
44137177809135	All Size / #857663	OutOfStock	#857663
46315766841583	Size Small / Black	OutOfStock	Black
46315766874351	Size Medium / Black	OutOfStock	Black
46315769364719	Size Large / Black	OutOfStock	Black
46270364451055	All Size / White	OutOfStock	White
43037231972591	All Size / Black	OutOfStock	Black
44137361506543	Size 1 / Black	OutOfStock	Black
44137361539311	Size 2 / Black	OutOfStock	Black
43514886324463	All Size / Black	OutOfStock	Black
44536057692399	Small / #996633	OutOfStock	#996633
44536083546351	Medium / #996633	OutOfStock	#996633
44536083579119	Large / #996633	OutOfStock	#996633
45890150695151	All Size / White	OutOfStock	White
46124926304495	All Size / Maroon	OutOfStock	Maroon
46124963102959	Size 1 / #C19A6B	OutOfStock	#C19A6B
46124963135727	Size 2 / #C19A6B	OutOfStock	#C19A6B
45890209906927	Size 1 / Black	OutOfStock	Black
45890209939695	Size 2 / Black	OutOfStock	Black
43642727432431	All Size / Maroon	OutOfStock	Maroon
44659816399087	Size 1 / #80BEE4	OutOfStock	#80BEE4
44659816431855	Size 2 / #80BEE4	OutOfStock	#80BEE4
45968880959727	All Size / #996633	OutOfStock	#996633
43672707793135	Size 1 (1-2 yo) / Black	OutOfStock	Black
43672707825903	Size 2 (2-3yo) / Black	OutOfStock	Black
43672707858671	Size 3 (3-4yo) / Black	OutOfStock	Black
45077002485999	Size 1 / Light Grey	OutOfStock	Light Grey
45077080047855	Size 2 / Light Grey	OutOfStock	Light Grey
44597327757551	Size 1 / #FFFFE7	OutOfStock	#FFFFE7
44597327790319	Size 2 / #FFFFE7	OutOfStock	#FFFFE7
46573584220399	Size 1 / #F3F2EC	InStock	#F3F2EC
46573584253167	Size 2 / #F3F2EC	InStock	#F3F2EC
43953540071663	Size 1 / #000026	OutOfStock	#000026
43953546232047	Size 2 / #000026	OutOfStock	#000026
44536085840111	Small / Maroon	OutOfStock	Maroon
44536094195951	Medium / Maroon	OutOfStock	Maroon
44536094228719	Large / Maroon	OutOfStock	Maroon
45890137522415	Size 1 / White	OutOfStock	White
45890137555183	Size 2 / White	OutOfStock	White
44660201292015	Size 1 / #D2F6DE	OutOfStock	#D2F6DE
44660216398063	Size 2 / #D2F6DE	OutOfStock	#D2F6DE
44304881549551	Size S / #36A5B2	OutOfStock	#36A5B2
44304881582319	Size M / #36A5B2	OutOfStock	#36A5B2
43642731397359	All Size / Green	OutOfStock	Green
43645309354223	All Size / Navy	OutOfStock	Navy
43790491910383	All Size / Black	OutOfStock	Black
44246203105519	All Size / Beige	OutOfStock	Beige
46315601232111	Size 1 / White	InStock	White
46315601264879	Size 2 / White	OutOfStock	White
44062111039727	Small / White	OutOfStock	White
44062111072495	Medium / White	OutOfStock	White
44062111105263	Large / White	OutOfStock	White
44075332272367	All Size / Black	OutOfStock	Black
43040655409391	All Size / #02064a	OutOfStock	#02064a
44304765714671	Size 1 / Black	OutOfStock	Black
44304778887407	Size 2 / Black	OutOfStock	Black
44244923121903	All Size / Black	OutOfStock	Black
43039905120495	SM / White	OutOfStock	White
43039905153263	ML / White	OutOfStock	White
45972796801263	All Size / #FFEEBD	OutOfStock	#FFEEBD
46170764476655	Size Small / #A20000	OutOfStock	#A20000
46170764509423	Size Medium / #A20000	OutOfStock	#A20000
44660225540335	Size 1 / Pink	OutOfStock	Pink
44660225573103	Size 2 / Pink	OutOfStock	Pink
45533403611375	Size Small / Black	OutOfStock	Black
45533403644143	Size Medium / Black	OutOfStock	Black
45533403676911	Size Large / Black	OutOfStock	Black
42922253058287	All Size / #02064a	OutOfStock	#02064a
45972743487727	Size 1 / #996633	OutOfStock	#996633
45972743520495	Size 2 / #996633	OutOfStock	#996633
43790411694319	All size / #CCC6AC	OutOfStock	#CCC6AC
46170774798575	Size 1 / #5C0000	OutOfStock	#5C0000
46170774831343	Size 2 / #5C0000	InStock	#5C0000
45773956219119	Size Small / #C8ECF4	OutOfStock	#C8ECF4
45773956251887	Size Medium / #C8ECF4	OutOfStock	#C8ECF4
46124928303343	Size 1 / #C19A6B	OutOfStock	#C19A6B
46124928336111	Size 2 / #C19A6B	OutOfStock	#C19A6B
44289398538479	All Size / Red	OutOfStock	Red
42146368159983	All Size / Maroon	OutOfStock	Maroon
45413226348783	Size Small / Light Grey	OutOfStock	Light Grey
45413226381551	Size Medium / Light Grey	OutOfStock	Light Grey
46124945506543	Size Small / Maroon	OutOfStock	Maroon
46124945539311	Size Medium / Maroon	OutOfStock	Maroon
46124945572079	Size Large / Maroon	OutOfStock	Maroon
43281641308399	All Size / #2B3856	OutOfStock	#2B3856
45533395583215	Size Small / White	OutOfStock	White
45533403119855	Size Medium / White	OutOfStock	White
45533403152623	Size Large / White	OutOfStock	White
44597335589103	Size 1 / White	OutOfStock	White
44597335621871	Size 2 / White	OutOfStock	White
46662737658095	Size Small / White	InStock	White
46662737690863	Size Medium / White	InStock	White
46662737723631	Size Large / White	InStock	White
44352442302703	All Size / #996633	OutOfStock	#996633
44069824692463	All Size / #02064a	OutOfStock	#02064a
45077279768815	All Size / White	OutOfStock	White
44597317632239	All Size / Black	OutOfStock	Black
45075583697135	Size Small / Grey	OutOfStock	Grey
45075583729903	Size Medium / Grey	InStock	Grey
45075583762671	Size Large / Grey	InStock	Grey
42090490036463	All Size / #DE3636	OutOfStock	#DE3636
46059334795503	All Size / White	InStock	White
46124963660015	Size 1 / Grey	OutOfStock	Grey
46124963692783	Size 2 / Grey	OutOfStock	Grey
44482876539119	All Size / #F7CAC9	OutOfStock	#F7CAC9
45413234901231	Size Small / #2B3856	OutOfStock	#2B3856
45413234933999	Size Medium / #2B3856	OutOfStock	#2B3856
46124919914735	All Size / Maroon	OutOfStock	Maroon
43877918540015	All Size / #cdebf9	OutOfStock	#cdebf9
46317303070959	All Size / Black	OutOfStock	Black
46576949821679	All Size / #C0C0C0	InStock	#C0C0C0
43952940253423	All Size / White	OutOfStock	White
42075728937199	Christmas Tree / Blank Card	InStock	Blank Card
42075799453935	Christmas Tree / Add Personal Notes	InStock	Add Personal Notes
42075728969967	Abstract / Blank Card	InStock	Blank Card
42075799486703	Abstract / Add Personal Notes	InStock	Add Personal Notes
43896752636143	All Size / Navy	OutOfStock	Navy
44244797358319	Size S / Light Grey	OutOfStock	Light Grey
44244797554927	Size M / Light Grey	OutOfStock	Light Grey
44244797587695	Size L / Light Grey	OutOfStock	Light Grey
44244861354223	Size XL / Light Grey	OutOfStock	Light Grey
44553786982639	All Size / DARK GREY	OutOfStock	DARK GREY
46662839599343	Size 1 (Preorder 10 Working Days) / #F7CAC9	OutOfStock	#F7CAC9
46662839632111	Size 2 (Preorder 10 Working Days) / #F7CAC9	OutOfStock	#F7CAC9
45972758364399	Size 1 / #2B3856	OutOfStock	#2B3856
45972758397167	Size 2 / #2B3856	OutOfStock	#2B3856
43877960057071	Small / Black	OutOfStock	Black
43877960089839	Medium / Black	OutOfStock	Black
43877960122607	Large / Black	OutOfStock	Black
43970323022063	Extra Large / Black	OutOfStock	Black
44002330149103	Size 1 / Black	OutOfStock	Black
44002330181871	Size 2 / Black	OutOfStock	Black
42496840859887	All Size / #98b2d1	OutOfStock	#98b2d1
46456309842159	Size 1 / #572E19	OutOfStock	#572E19
46456309874927	Size 2 / #572E19	OutOfStock	#572E19
43514872889583	All Size / Black	OutOfStock	Black
46458544750831	Size Small / #572E19	OutOfStock	#572E19
46458544783599	Size Medium / #572E19	OutOfStock	#572E19
46458544816367	Size Large / #572E19	OutOfStock	#572E19
46549383315695	All Size / Black	InStock	Black
46317267255535	All Size / #FFF7E1	OutOfStock	#FFF7E1
44590680637679	All Size / #2B3856	OutOfStock	#2B3856
46063389573359	All Size / White	OutOfStock	White
44289346568431	Size 1 / #000042	OutOfStock	#000042
44289351483631	Size 2 / #000042	OutOfStock	#000042
46061916324079	Size 1 / #FFFFF3	OutOfStock	#FFFFF3
46061916356847	Size 2 / #FFFFF3	OutOfStock	#FFFFF3
45527192109295	All Size / #FFFFF3	OutOfStock	#FFFFF3
44289297940719	Size S / #000042	OutOfStock	#000042
44289305706735	Size M / #000042	OutOfStock	#000042
44289305739503	Size L / #000042	OutOfStock	#000042
45075594543343	Size Small / #2B3856	OutOfStock	#2B3856
45075594576111	Size Medium / #2B3856	OutOfStock	#2B3856
45075594608879	Size Large / #2B3856	OutOfStock	#2B3856
43790763819247	All Size / Black	OutOfStock	Black
43790362181871	1 / #F3F2EC	OutOfStock	#F3F2EC
43790362837231	2 / #F3F2EC	OutOfStock	#F3F2EC
45527363485935	Size Small / Pink	OutOfStock	Pink
45527363518703	Size Medium / Pink	InStock	Pink
45527363551471	Size Large / Pink	OutOfStock	Pink
43790374404335	1 / #F3F2EC	OutOfStock	#F3F2EC
43790376632559	2 / #F3F2EC	OutOfStock	#F3F2EC
44618520690927	Size 1 / Navy	OutOfStock	Navy
44618520723695	Size 2 / Navy	OutOfStock	Navy
46124930531567	Size 1 / Grey	OutOfStock	Grey
46124930564335	Size 2 / Grey	OutOfStock	Grey
45807942435055	Size Small / #FBFBFB	OutOfStock	#FBFBFB
45807942467823	Size Medium / #FBFBFB	OutOfStock	#FBFBFB
45807950954735	Size Large / #FBFBFB	OutOfStock	#FBFBFB
43642735591663	Size 1 / Green	OutOfStock	Green
43642735624431	Size 2 / Green	OutOfStock	Green
42090568089839	#DE3636 / All Size	OutOfStock	All Size
44590661730543	All Size / #2B3856	OutOfStock	#2B3856
46063408677103	All Size / White	OutOfStock	White
43220078592239	All Size / #02064a	OutOfStock	#02064a
43642701611247	All Size / #C19A6B	OutOfStock	#C19A6B
43952805118191	All Size / White	OutOfStock	White
46270332502255	All Size / #000042	OutOfStock	#000042
46272142901487	Size 1 / #c9b9ad	OutOfStock	#c9b9ad
46272144867567	Size 2 / #c9b9ad	OutOfStock	#c9b9ad
43713129316591	Allsize / #c64501	OutOfStock	#c64501
44245043609839	All Size / Black	OutOfStock	Black
44482877161711	Size 1 / #F7CAC9	OutOfStock	#F7CAC9
44482877194479	Size 2 / #F7CAC9	OutOfStock	#F7CAC9
43793315889391	All Size / Dark Grey	OutOfStock	Dark Grey
42146314846447	All Size / #02064a	OutOfStock	#02064a
45808030187759	Size Small (PREORDER 5 WORKING DAYS) / #FBFBFB	OutOfStock	#FBFBFB
45808030220527	Size Medium (PREORDER 5 WORKING DAYS) / #FBFBFB	OutOfStock	#FBFBFB
45808030253295	Size Large (PREORDER 5 WORKING DAYS) / #FBFBFB	OutOfStock	#FBFBFB
46549383545071	Size 1 / #F3F2EC	InStock	#F3F2EC
46549384265967	Size 2 / #F3F2EC	InStock	#F3F2EC
46573483655407	All Size (Preorder 25 Working Days) / #FFFFE7	OutOfStock	#FFFFE7
44482898526447	All Size / #ff96cb	OutOfStock	#ff96cb
44659880853743	Size 1 / #80BEE4	OutOfStock	#80BEE4
44659933479151	Size 2 / #80BEE4	OutOfStock	#80BEE4
44136216101103	All Size / Black	OutOfStock	Black
45527178019055	Size 1 / #FFFFF3	OutOfStock	#FFFFF3
45527178051823	Size 2 / #FFFFF3	OutOfStock	#FFFFF3
46317324533999	Size Small / Black	OutOfStock	Black
46317324566767	Size Medium / Black	OutOfStock	Black
46317324599535	Size Large / Black	OutOfStock	Black
46170725122287	Size 1 / #A4A000	OutOfStock	#A4A000
46170725155055	Size 2 / #A4A000	OutOfStock	#A4A000
44062104748271	Small / #000042	OutOfStock	#000042
44062158979311	Medium / #000042	OutOfStock	#000042
44062159012079	Large / #000042	OutOfStock	#000042
45773890388207	Size 1 / Black	OutOfStock	Black
45773890420975	Size 2 / Black	OutOfStock	Black
44289505362159	All Size / #4b5320	OutOfStock	#4b5320
46458542686447	Size 1 / #ECCDBE	InStock	#ECCDBE
46458543374575	Size 2 / #ECCDBE	InStock	#ECCDBE
45328162849007	Size 1 / #F7CAC9	OutOfStock	#F7CAC9
45328162881775	Size 2 / #F7CAC9	OutOfStock	#F7CAC9
45328198893807	Size 3 / #F7CAC9	OutOfStock	#F7CAC9
45328198926575	Size 4 / #F7CAC9	OutOfStock	#F7CAC9
43037134520559	All Size / Grey	OutOfStock	Grey
46414058029295	All Size / Light Blue	OutOfStock	Light Blue
42075847917807	Blank Card	InStock	None
42075847950575	Add Personal Notes	InStock	None
46062004502767	Size Small / White	OutOfStock	White
46062004535535	Size Medium / White	OutOfStock	White
46062004568303	Size Large / White	OutOfStock	White
46662826393839	Size 1 / Ready / #572E19	OutOfStock	#572E19
46667929616623	Size 1 / Preorder 10 Working Days / #572E19	OutOfStock	#572E19
46671901917423	Size 1 / Preorder 21 Working Days / #572E19	OutOfStock	#572E19
46662826426607	Size 2 / Ready / #572E19	OutOfStock	#572E19
46667929649391	Size 2 / Preorder 10 Working Days / #572E19	OutOfStock	#572E19
46671901950191	Size 2 / Preorder 21 Working Days / #572E19	OutOfStock	#572E19
42922250240239	SM / Black	OutOfStock	Black
42935590027503	ML / Black	OutOfStock	Black
46317586022639	Size Small / White	OutOfStock	White
46317586055407	Size Medium / White	OutOfStock	White
46317586088175	Size Large / White	OutOfStock	White
43713140162799	Size 1 / Red	OutOfStock	Red
43713140195567	Size 2 / Red	OutOfStock	Red
45890176221423	All Size / Black	OutOfStock	Black
43953577787631	All Size / #c9b9ad	OutOfStock	#c9b9ad
44062161666287	Small / Black	OutOfStock	Black
44062161699055	Medium / Black	OutOfStock	Black
44062161731823	Large / Black	OutOfStock	Black
42155149721839	SM / Light Grey	OutOfStock	Light Grey
42155149754607	ML / Light Grey	OutOfStock	Light Grey
45077796323567	All Size / Black	OutOfStock	Black
46043755610351	All Size / Black	OutOfStock	Black
43037170991343	All Size / Grey	OutOfStock	Grey
46124923257071	All Size / #2B3856	OutOfStock	#2B3856
41247811272882	All Size / Grey	OutOfStock	Grey
43790518878447	All Size / Grey	OutOfStock	Grey
46043736015087	All Size / #2B3856	OutOfStock	#2B3856
45972914438383	All Size / Maroon	OutOfStock	Maroon
43790379286767	All size / #F3F2EC	OutOfStock	#F3F2EC
43893891793135	All Size / #ff0065	OutOfStock	#ff0065
45972820001007	All Size / #996633	OutOfStock	#996633
45974570205423	All Size / White	OutOfStock	White
46270330011887	All Size / #186AB4	OutOfStock	#186AB4
44426219094255	Size 1 / #556b2f	OutOfStock	#556b2f
44426228302063	Size 2 / #556b2f	OutOfStock	#556b2f
42090594173167	All Size / #80BEE4	OutOfStock	#80BEE4
46414054457583	All Size / Pink	OutOfStock	Pink
42090553573615	black / All Size	OutOfStock	All Size
43953557733615	All Size / #000026	OutOfStock	#000026
45527157047535	Size 1 / #2B3856	OutOfStock	#2B3856
45527157080303	Size 2 / #2B3856	OutOfStock	#2B3856
44304933290223	Size S / #C0C0C0	OutOfStock	#C0C0C0
44304933322991	Size M / #C0C0C0	OutOfStock	#C0C0C0
44304933355759	Size L / #C0C0C0	OutOfStock	#C0C0C0
45890230255855	All Size / White	OutOfStock	White
44244770029807	Size S / Black	OutOfStock	Black
44244770062575	Size M / Black	OutOfStock	Black
44244770095343	Size L / Black	OutOfStock	Black
44244770128111	Size XL / Black	OutOfStock	Black
43312083075311	SM / #D2EFF6	OutOfStock	#D2EFF6
43312083108079	ML / #D2EFF6	OutOfStock	#D2EFF6
46662590693615	Size Small  (Preorder 10 Working Days) / White	InStock	White
46662592790767	Size Medium (Preorder 10 Working Days) / White	InStock	White
46662592823535	Size Large  (Preorder 10 Working Days) / White	InStock	White
43790415724783	All Size / Navy	OutOfStock	Navy
42922230481135	All Size / White	OutOfStock	White
46576970793199	All Size / White	InStock	White
46124922241263	All Size / Maroon	OutOfStock	Maroon
46315625054447	Size 1 / Black	InStock	Black
46315625087215	Size 2 / Black	InStock	Black
43642673758447	All Size / Grey	OutOfStock	Grey
45527131160815	Size 1 / #336699	OutOfStock	#336699
45527131193583	Size 2 / #336699	OutOfStock	#336699
43281612112111	All Size / #996633	OutOfStock	#996633
46063378497775	All Size / #13548F	OutOfStock	#13548F
45075608273135	Size Small / Grey	OutOfStock	Grey
45075608305903	Size Medium / Grey	OutOfStock	Grey
45075608338671	Size Large / Grey	OutOfStock	Grey
44001037910255	All Size / #F3F2EC	OutOfStock	#F3F2EC
44426283909359	All Size / #DE3636	OutOfStock	#DE3636
43953551671535	Size 1 / White	OutOfStock	White
43953551704303	Size 2 / White	OutOfStock	White
46458540916975	All Size / Black	InStock	Black
43642686472431	All Size / Grey	OutOfStock	Grey
42090587619567	All Size / Black	OutOfStock	Black
43645548265711	All Size / #556b2f	OutOfStock	#556b2f
43645303029999	All Size / Maroon	OutOfStock	Maroon
46414044004591	Size 1 / Black	OutOfStock	Black
46414044037359	Size 2 / Black	OutOfStock	Black
44137218965743	All Size / Black	OutOfStock	Black
43642682310895	All Size / Grey	OutOfStock	Grey
46061996966127	Size Small / #13548F	OutOfStock	#13548F
46061996998895	Size Medium / #13548F	OutOfStock	#13548F
46061997031663	Size Large / #13548F	OutOfStock	#13548F
46549495087343	All Size (Shipment 14 July 2025) / #5A6553	OutOfStock	#5A6553
43896780718319	All Size / #FF0080	OutOfStock	#FF0080
46456161665263	All Size / Black	InStock	Black
43514910310639	All Size / Black	OutOfStock	Black
45525206237423	All Size / #2B3856	OutOfStock	#2B3856
43952938713327	ALLSIZE - FIT TO L / Grey	OutOfStock	Grey
44244685816047	Size S / Black	OutOfStock	Black
44244686373103	Size M / Black	OutOfStock	Black
44244686405871	Size L / Black	OutOfStock	Black
46315524882671	Size Small / White	InStock	White
46315531469039	Size Medium / White	OutOfStock	White
46315531501807	Size Large / White	InStock	White
43893891596527	SM / #FF0080	OutOfStock	#FF0080
43893891629295	ML / #FF0080	OutOfStock	#FF0080
44253635543279	All Size / #996633	OutOfStock	#996633
45533410099439	Size Small / White	OutOfStock	White
45533410132207	Size Medium / White	OutOfStock	White
45533410164975	Size Large / White	OutOfStock	White
46121927082223	All Size / #1E2F13	InStock	#1E2F13
43444235698415	All Size / Grey	OutOfStock	Grey
45077762539759	All Size / Black	OutOfStock	Black
43645301752047	All Size / Navy	OutOfStock	Navy
46317316374767	All Size / Black	InStock	Black
43651978100975	Size 1 / Black	OutOfStock	Black
43651978133743	Size 2 / Black	OutOfStock	Black
44137264546031	Size 1 / Black	OutOfStock	Black
44137287254255	Size 2 / Black	OutOfStock	Black
42922251419887	All Size / Black	OutOfStock	Black
43121225695471	Reguler / Light Blue	OutOfStock	Light Blue
43121235755247	Oversized / Light Blue	OutOfStock	Light Blue
46662831505647	Size Small / #572E19 / Ready	OutOfStock	Ready
46668101419247	Size Small / #572E19 / Preorder 10 Working Days	OutOfStock	Preorder 10 Working Days
46671902343407	Size Small / #572E19 / Preorder 21 Working Days	OutOfStock	Preorder 21 Working Days
46662831538415	Size Medium / #572E19 / Ready	OutOfStock	Ready
46668101452015	Size Medium / #572E19 / Preorder 10 Working Days	OutOfStock	Preorder 10 Working Days
46671902376175	Size Medium / #572E19 / Preorder 21 Working Days	InStock	Preorder 21 Working Days
46662831571183	Size Large / #572E19 / Ready	OutOfStock	Ready
46668101484783	Size Large / #572E19 / Preorder 10 Working Days	OutOfStock	Preorder 10 Working Days
46671902408943	Size Large / #572E19 / Preorder 21 Working Days	OutOfStock	Preorder 21 Working Days
46043749646575	All Size / White	OutOfStock	White
43642721632495	All Size / Green	OutOfStock	Green
43514917814511	ALLSIZE-FIT TO MEDIUM / White	OutOfStock	White
46043720515823	All Size / Black	OutOfStock	Black
43877985779951	All Size / Navy	OutOfStock	Navy
43713148616943	All Size / #A5D7B7	OutOfStock	#A5D7B7
46059349999855	Size Small / #FFFFF3	OutOfStock	#FFFFF3
46059350032623	Size Medium / #FFFFF3	OutOfStock	#FFFFF3
46059350360303	Size Large / #FFFFF3	OutOfStock	#FFFFF3
46124947013871	Size Small / Maroon	OutOfStock	Maroon
46124947046639	Size Medium / Maroon	OutOfStock	Maroon
46124947079407	Size Large / Maroon	OutOfStock	Maroon
43281812193519	All Size / #D2EFF6	OutOfStock	#D2EFF6
46315569840367	Size 1 / White	OutOfStock	White
46315569873135	Size 2 / White	OutOfStock	White
44055854481647	All Size / Black	OutOfStock	Black
43281723523311	S / #2B3856	OutOfStock	#2B3856
43281796595951	M / #2B3856	OutOfStock	#2B3856
45526578823407	Size Small / #2B3856	OutOfStock	#2B3856
45526578856175	Size Medium / #2B3856	OutOfStock	#2B3856
45526614376687	Size Large / #2B3856	OutOfStock	#2B3856
46272509935855	All Size / White	InStock	White
43790722597103	All size / Black	OutOfStock	Black
43790378860783	1 / #CCC6AC	OutOfStock	#CCC6AC
43790378893551	2 / #CCC6AC	OutOfStock	#CCC6AC
44001053016303	All Size / Navy	OutOfStock	Navy
44660162232559	Size 1 / Pink	OutOfStock	Pink
44660181270767	Size 2 / Pink	OutOfStock	Pink
46043756527855	All Size / White	OutOfStock	White
46573632356591	Size Small / #000042	InStock	#000042
46573632389359	Size Medium / #000042	InStock	#000042
46573632422127	Size Large / #000042	InStock	#000042
46544753918191	All Size / #565656	InStock	#565656
44354898723055	All Size / #36A5B2	OutOfStock	#36A5B2
44553776136431	All size / #A5DAF5	OutOfStock	#A5DAF5
43514905264367	All Size / White	OutOfStock	White
44069827150063	Small / #2B3856	InStock	#2B3856
44069827215599	Medium / #2B3856	InStock	#2B3856
44069827248367	Large / #2B3856	InStock	#2B3856
46170684326127	Size 1 / Maroon	OutOfStock	Maroon
46170684358895	Size 2 / Maroon	OutOfStock	Maroon
43877937348847	Small / White	OutOfStock	White
43877961302255	Medium / White	OutOfStock	White
43877961335023	Large / White	OutOfStock	White
46662900941039	All Size / #FFFFE7	InStock	#FFFFE7
44002289090799	Size 1 / #ff96cb	OutOfStock	#ff96cb
44002289123567	Size 2 / #ff96cb	OutOfStock	#ff96cb
44136345862383	All Size / #366AA4	OutOfStock	#366AA4
42090605773039	All Size / black	OutOfStock	black
46124916932847	All Size / #c9b9ad	OutOfStock	#c9b9ad
46170734493935	All Size / Maroon	OutOfStock	Maroon
44062136074479	All Size / #121246	OutOfStock	#121246
43642722648303	All Size / Maroon	OutOfStock	Maroon
44590646264047	All Size / #2B3856	OutOfStock	#2B3856
42922213474543	All Size / Grey	OutOfStock	Grey
43312090710255	All Size / #D2EFF6	OutOfStock	#D2EFF6
46124908118255	All Size / #996633	OutOfStock	#996633
46458544390383	Size Small / #660033	OutOfStock	#660033
46458544423151	Size Medium / #660033	OutOfStock	#660033
46458544455919	Size Large / #660033	OutOfStock	#660033
43659883282671	All Size / Olive	OutOfStock	Olive
46662901530863	All Size (Preorder 14 Working Days) / White	InStock	White
44002330312943	Size 1 / Black	OutOfStock	Black
44002330345711	Size 2 / Black	OutOfStock	Black
45773425475823	Size 1 / #C8ECF4	OutOfStock	#C8ECF4
45773425508591	Size 2 / #C8ECF4	OutOfStock	#C8ECF4
46121854337263	Size 1 / #FBFBFB	OutOfStock	#FBFBFB
46121854370031	Size 2 / #FBFBFB	OutOfStock	#FBFBFB
44289271988463	All Size / #DE3636	OutOfStock	#DE3636
44556063703279	Size Small / Light Grey	OutOfStock	Light Grey
45413296472303	Size Medium / Light Grey	OutOfStock	Light Grey
44304914317551	Size S / #996633	OutOfStock	#996633
44304914350319	Size M / #996633	OutOfStock	#996633
44304921690351	Size L / #996633	OutOfStock	#996633
46573646446831	Size Small (Preorder 25 Working Days) / #A48974	InStock	#A48974
46573646479599	Size Medium (Preorder 25 Working Days) / #A48974	InStock	#A48974
44246507454703	All Size / White	OutOfStock	White
45972909293807	All Size / #ab936b	OutOfStock	#ab936b
46043759411439	All Size / #4B4848	OutOfStock	#4B4848
45968706109679	All Size / #FFEEBD	OutOfStock	#FFEEBD
46662790906095	Size Small (Preorder 10 Working Days) / #FFFFE7	InStock	#FFFFE7
46662790938863	Size Medium (Preorder 10 Working Days) / #FFFFE7	InStock	#FFFFE7
46662793560303	Size Large (Preorder 10 Working Days) / #FFFFE7	OutOfStock	#FFFFE7
45808190062831	Size 1 / #FBFBFB	OutOfStock	#FBFBFB
45808190095599	Size 2 / #FBFBFB	OutOfStock	#FBFBFB
46576965943535	All Size / Black	InStock	Black
44005416763631	All Size / Navy	OutOfStock	Navy
44076544721135	All Size / #2B3856	OutOfStock	#2B3856
46662929907951	All Size (Preorder 14 Working Days) / #FFF8E5	InStock	#FFF8E5
46407911571695	Size XS / White	InStock	White
46282980032751	Size Small / White	OutOfStock	White
46282980065519	Size Medium / White	OutOfStock	White
46272079429871	Size Small / #77815c	OutOfStock	#77815c
46272079462639	Size Medium / #77815c	OutOfStock	#77815c
46272079495407	Size Large / #77815c	OutOfStock	#77815c
43877952225519	Small / Black	OutOfStock	Black
43877960646895	Medium / Black	OutOfStock	Black
43877960679663	Large / Black	OutOfStock	Black
43642702856431	All Size / Red	OutOfStock	Red
43878007734511	1 / Black	OutOfStock	Black
43878007767279	2 / Black	OutOfStock	Black
46124940001519	Size Small / #5F2C09	OutOfStock	#5F2C09
46124940034287	Size Medium / #5F2C09	OutOfStock	#5F2C09
46124944916719	Size Large / #5F2C09	OutOfStock	#5F2C09
43877955272943	Small / #7caac6	OutOfStock	#7caac6
43877955338479	Medium / #7caac6	OutOfStock	#7caac6
43877958189295	Large / #7caac6	OutOfStock	#7caac6
43970321514735	Extra Large / #7caac6	OutOfStock	#7caac6
44162903703791	1 / #AEE4B3	OutOfStock	#AEE4B3
44162903736559	2 / #AEE4B3	OutOfStock	#AEE4B3
44137321791727	Size 1 / Beige	OutOfStock	Beige
44137321824495	Size 2 / Beige	OutOfStock	Beige
41247752519858	Black	OutOfStock	None
43877980340463	All size / #02064a	OutOfStock	#02064a
44005419679983	All Size / Grey	OutOfStock	Grey
46059334402287	All Size / #A5D7B7	InStock	#A5D7B7
44659943375087	Small / #80BEE4	OutOfStock	#80BEE4
44659943407855	Medium / #80BEE4	OutOfStock	#80BEE4
44659943440623	Large / #80BEE4	OutOfStock	#80BEE4
44426335060207	All Size / Maroon	OutOfStock	Maroon
42611051561199	BLACK / ALL SIZE	OutOfStock	ALL SIZE
44433337024751	Size Small / #996633	OutOfStock	#996633
44433337057519	Size Medium / #996633	OutOfStock	#996633
44433337090287	Size Large / #996633	OutOfStock	#996633
44162897215727	1 / #A3D1FF	OutOfStock	#A3D1FF
44162897248495	2 / #A3D1FF	OutOfStock	#A3D1FF
44069828886767	All Size / White	OutOfStock	White
46063442034927	All Size (SHIPMENT: 26-27 December) / Pink	OutOfStock	Pink
43952800792815	Size 1 / White	OutOfStock	White
43952800825583	Size 2 / White	OutOfStock	White
46315771724015	All Size / #2B3856	OutOfStock	#2B3856
46317303955695	All Size / Black	OutOfStock	Black
44660128645359	All Size / #c9b9ad	OutOfStock	#c9b9ad
44308600389871	Size S / #4b5320	OutOfStock	#4b5320
44308600422639	Size M / #4b5320	OutOfStock	#4b5320
43281665786095	All Size / White	OutOfStock	White
43312032743663	All Size / #D2EFF6	OutOfStock	#D2EFF6
44289211465967	Size 1 / Maroon	OutOfStock	Maroon
44289220346095	Size 2 / Maroon	OutOfStock	Maroon
45527302144239	Size Small / Pink	OutOfStock	Pink
45527302177007	Size Medium / Pink	OutOfStock	Pink
45527302209775	Size Large / Pink	OutOfStock	Pink
44433326145775	Size Small / #FFEEBD	OutOfStock	#FFEEBD
44433326178543	Size Medium / #FFEEBD	OutOfStock	#FFEEBD
44433326211311	Size Large / #FFEEBD	OutOfStock	#FFEEBD
44002293612783	Size 1 / #ff96cb	OutOfStock	#ff96cb
44002293874927	Size 2 / #ff96cb	OutOfStock	#ff96cb
42090563535087	All Size / #80BEE4	OutOfStock	#80BEE4
46061916913903	Size 1 / #FFFFF3	OutOfStock	#FFFFF3
46061916946671	Size 2 / #FFFFF3	OutOfStock	#FFFFF3
45329246093551	All Size / #A5DAF5	OutOfStock	#A5DAF5
46272200868079	All Size / Black	OutOfStock	Black
46458540720367	All Size / Black	OutOfStock	Black
45526476947695	Size 1 / #2B3856	OutOfStock	#2B3856
45526535504111	Size 2 / #2B3856	OutOfStock	#2B3856
46170726465775	Size 1 / #5C0000	OutOfStock	#5C0000
46170726498543	Size 2 / #5C0000	OutOfStock	#5C0000
44660243857647	Size 1 / #D2F6DE	OutOfStock	#D2F6DE
44660243890415	Size 2 / #D2F6DE	OutOfStock	#D2F6DE
43642719404271	All Size / Green	OutOfStock	Green
42145605386479	All Size / Light Grey	OutOfStock	Light Grey
44137104244975	All Size / White	OutOfStock	White
46580046332143	All Size / #F7CAC9	OutOfStock	#F7CAC9
46662745719023	Size Small (Preorder 10 Working Days) / Black	InStock	Black
46662745751791	Size Medium (Preorder 10 Working Days) / Black	InStock	Black
46662745784559	Size Large  (Preorder 10 Working Days) / Black	InStock	Black
44058569212143	All Size / Navy	OutOfStock	Navy
41247732007090	ALL SIZE ( FIT TO M ) / Black	OutOfStock	Black
44044712968431	1 / #ff0065	OutOfStock	#ff0065
44044713001199	2 / #ff0065	OutOfStock	#ff0065
44244692599023	Size S / Light Grey	OutOfStock	Light Grey
44244694204655	Size M / Light Grey	OutOfStock	Light Grey
44244694237423	Size L / Light Grey	OutOfStock	Light Grey
46456198922479	Size 1 / #565656	OutOfStock	#565656
46456198955247	Size 2 / #565656	OutOfStock	#565656
44556083396847	Size Small / Dark Grey	OutOfStock	Dark Grey
45413479448815	Size Medium / Dark Grey	OutOfStock	Dark Grey
46272211714287	All Size / White	OutOfStock	White
46458544881903	Small / #ECCDBE	InStock	#ECCDBE
46458544914671	Medium / #ECCDBE	InStock	#ECCDBE
45773924237551	Size Small / Black	OutOfStock	Black
45773924270319	Size Medium / Black	OutOfStock	Black
42090497442031	All Size / #80BEE4	OutOfStock	#80BEE4
45075544047855	Size Small / Grey	OutOfStock	Grey
45075550601455	Size Medium / Grey	OutOfStock	Grey
45075550634223	Size Large / Grey	OutOfStock	Grey
45527261413615	Size Small / #FFFFF3	OutOfStock	#FFFFF3
45527261446383	Size Medium / #FFFFF3	OutOfStock	#FFFFF3
45527292084463	Size Large / #FFFFF3	OutOfStock	#FFFFF3
46662777143535	Size 1 / #FFFFE7	InStock	#FFFFE7
46662778650863	Size 2 / #FFFFE7	InStock	#FFFFE7
43952939204847	1 (XS-S) / White	OutOfStock	White
43952939237615	2 (M-L) / White	OutOfStock	White
45773370523887	Size 1 / Black	OutOfStock	Black
45773395656943	Size 2 / Black	OutOfStock	Black
45972900020463	All Size / #371d10	OutOfStock	#371d10
44556059574511	Size Small / Black	OutOfStock	Black
45413277565167	Size Medium / Black	OutOfStock	Black
43790338883823	1 / #CCC6AC	OutOfStock	#CCC6AC
43790338916591	2 / #CCC6AC	OutOfStock	#CCC6AC
43514969620719	Size 1 / #2B3856	OutOfStock	#2B3856
43514969653487	Size 2 / #2B3856	OutOfStock	#2B3856
42090642309359	All Size / #80BEE4	OutOfStock	#80BEE4
46121859088623	Size 1 / #FBFBFB	OutOfStock	#FBFBFB
46121859121391	Size 2 / #FBFBFB	OutOfStock	#FBFBFB
44304864805103	Size S / Maroon	OutOfStock	Maroon
44304868704495	Size M / Maroon	OutOfStock	Maroon
45808852271343	Size 1 / #7caac6	OutOfStock	#7caac6
45808852304111	Size 2 / #7caac6	OutOfStock	#7caac6
43893844213999	All Size / White	OutOfStock	White
44304812966127	All Size / Black	OutOfStock	Black
43642710622447	Size 1 / Black	OutOfStock	Black
43642710655215	Size 2 / Black	OutOfStock	Black
44553769943279	All size / Black	OutOfStock	Black
43713137901807	All Size / Red	OutOfStock	Red
45774107640047	Size Small / Black	OutOfStock	Black
45774107672815	Size Medium / Black	OutOfStock	Black
45774121107695	Size Large / Black	OutOfStock	Black
46474661036271	Blank Card	InStock	None
46474661069039	Add Personal Notes	InStock	None
46549485125871	Size Small / Black	InStock	Black
46549485158639	Size Medium / Black	OutOfStock	Black
46549485191407	Size Large / Black	OutOfStock	Black
45527345529071	Size Small / #FFFFF3	OutOfStock	#FFFFF3
45527345561839	Size Medium / #FFFFF3	OutOfStock	#FFFFF3
45527345594607	Size Large / #FFFFF3	OutOfStock	#FFFFF3
44062132601071	All Size / #ff96cb	OutOfStock	#ff96cb
43514878132463	All Size / White	OutOfStock	White
42146343125231	All Size / #02064a	OutOfStock	#02064a
46043758199023	All Size / Beige	OutOfStock	Beige
44426305569007	All Size / #DE3636	OutOfStock	#DE3636
42611041501423	NAVY / ALL SIZE	OutOfStock	ALL SIZE
44426278568175	Size 1 (SHIPMENT: 1-3 February 2024) / #556b2f	OutOfStock	#556b2f
44426278600943	Size 2 (SHIPMENT: 1-3 February 2024) / #556b2f	OutOfStock	#556b2f
46662897041647	Size 1 / #306094	InStock	#306094
46662897074415	Size 2 / #306094	InStock	#306094
45533414097135	Size Small / #77815c	OutOfStock	#77815c
45533414129903	Size Medium / #77815c	OutOfStock	#77815c
45533414162671	Size Large / #77815c	OutOfStock	#77815c
44002288697583	All Size / #36A5B2	OutOfStock	#36A5B2
43713143374063	All Size / #A5D7B7	OutOfStock	#A5D7B7
46043748106479	All Size / Grey	OutOfStock	Grey
44426325852399	Size 1 / Black	OutOfStock	Black
44426327064815	Size 2 / Black	OutOfStock	Black
46121881305327	Size 1 / Black	OutOfStock	Black
46121881338095	Size 2 / Black	OutOfStock	Black
42146602221807	All Size / White	OutOfStock	White
42090416373999	All Size / black	OutOfStock	black
43713155596527	Size 1 / Black	OutOfStock	Black
43714800156911	Size 2 / Black	OutOfStock	Black
46662797623535	Size Small (Preorder 10 Working Days) / #572E19	InStock	#572E19
46662797656303	Size Medium (Preorder 10 Working Days) / #572E19	InStock	#572E19
46662797689071	Size Large (Preorder 10 Working Days) / #572E19	OutOfStock	#572E19
44289078493423	Size 1 / #3A3A3A	OutOfStock	#3A3A3A
44289095663855	Size 2 / #3A3A3A	OutOfStock	#3A3A3A
44304845013231	All Size / #36A5B2	OutOfStock	#36A5B2
44244697612527	Size S / Black	OutOfStock	Black
44557335167215	Size M / Black	OutOfStock	Black
44557335199983	Size L / Black	OutOfStock	Black
43953550655727	Size 1 / #c9b9ad	OutOfStock	#c9b9ad
43953550688495	Size 2 / #c9b9ad	OutOfStock	#c9b9ad
46113708441839	All Size / #2B3856	OutOfStock	#2B3856
43953582866671	All Size / #4B4848	OutOfStock	#4B4848
44244883079407	Size 1 / Black	OutOfStock	Black
44244890616047	Size 2 / Black	OutOfStock	Black
46576963715311	All Size / Black	InStock	Black
46063410512111	All Size (SHIPMENT JANUARY) / White	OutOfStock	White
44062132699375	All Size / #ff96cb	OutOfStock	#ff96cb
42922222256367	All Size / Grey	OutOfStock	Grey
44058584023279	All Size / #000042	OutOfStock	#000042
46573561839855	Size 1 / #572E19	OutOfStock	#572E19
46573561872623	Size 2 / #572E19	OutOfStock	#572E19
43642720190703	All Size / Maroon	OutOfStock	Maroon
43664070476015	All Size / #C19A6B	OutOfStock	#C19A6B
44046776664303	All Size / White	OutOfStock	White
44597343617263	Size S / #FFD9FF	OutOfStock	#FFD9FF
44597352235247	Size M / #FFD9FF	OutOfStock	#FFD9FF
44597352268015	Size L / #FFD9FF	OutOfStock	#FFD9FF
44426328015087	Size 1 / #DE3636	OutOfStock	#DE3636
44426328047855	Size 2 / #DE3636	OutOfStock	#DE3636
44288487555311	All Size / White	OutOfStock	White
45773973913839	All Size / Black	OutOfStock	Black
45969032315119	Size 1 / #996633	OutOfStock	#996633
45969032347887	Size 2 / #996633	OutOfStock	#996633
42990587052271	All Size / Navy	OutOfStock	Navy
45808869441775	Size Small / Black	OutOfStock	Black
45808869474543	Size Medium / Black	OutOfStock	Black
45808875798767	Size Large / Black	OutOfStock	Black
44253615816943	All Size / #996633	OutOfStock	#996633
44001072480495	All Size / Navy	OutOfStock	Navy
43039871500527	All Size / Brown	OutOfStock	Brown
46124938559727	All Size / Black	OutOfStock	Black
44076517949679	All Size / Pink	OutOfStock	Pink
43790431813871	Allsize / Navy	OutOfStock	Navy
44245012840687	All Size / Grey	OutOfStock	Grey
45890125463791	Size Small / White	OutOfStock	White
45890125496559	Size Medium / White	OutOfStock	White
45890132345071	Size Large / White	OutOfStock	White
44553789440239	All size / Pink	OutOfStock	Pink
46662759842031	Size Small / Black	InStock	Black
46662759874799	Size Medium / Black	InStock	Black
46662759907567	Size Large / Black	InStock	Black
43642674938095	Size 1 / Grey	OutOfStock	Grey
43642674970863	Size 2 / Grey	OutOfStock	Grey
46662824165615	Size 1 / Black	OutOfStock	Black
46662824198383	Size 2 / Black	OutOfStock	Black
46272231276783	All Size / #5A6553	OutOfStock	#5A6553
42611064635631	All Size / White	OutOfStock	White
44001177305327	Size 1 / #36A5B2	OutOfStock	#36A5B2
44001177338095	Size 2 / #36A5B2	OutOfStock	#36A5B2
46573525041391	All Size / White	InStock	White
46282984554735	All Size / Light Grey	OutOfStock	Light Grey
43281680498927	S (Preorder) / #996633	OutOfStock	#996633
43281788076271	M (Preorder) / #996633	OutOfStock	#996633
43037239410927	All Size / Brown	OutOfStock	Brown
43281765400815	All Size / #2B3856	OutOfStock	#2B3856
44289229193455	All Size / Maroon	OutOfStock	Maroon
42990585905391	All Size / Black	OutOfStock	Black
46573640909039	Size Small (Preorder 25 Working Days) / #F7CAC9	InStock	#F7CAC9
46573644939503	Size Medium (Preorder 25 Working Days) / #F7CAC9	InStock	#F7CAC9
46573746421999	Size Small (Preorder 25 Working Days) / White	InStock	White
46573746454767	Size Medium (Preorder 25 Working Days) / White	InStock	White
46124943245551	Size Small / Black	OutOfStock	Black
46124943278319	Size Medium / Black	OutOfStock	Black
46124944392431	Size Large / Black	OutOfStock	Black
46573605093615	Size Small / White	OutOfStock	White
46573605126383	Size Medium / White	OutOfStock	White
46573605159151	Size Large / White	OutOfStock	White
41239140139186	All Size / Black	OutOfStock	Black
44044715032815	1 / #02064a	OutOfStock	#02064a
44044715065583	2 / #02064a	OutOfStock	#02064a
45890249261295	All Size / #996633	OutOfStock	#996633
43713125941487	All Size / #c64501	OutOfStock	#c64501
46061909770479	Size Small / #A5D7B7	OutOfStock	#A5D7B7
46061909803247	Size Medium / #A5D7B7	OutOfStock	#A5D7B7
46061909836015	Size Large / #A5D7B7	OutOfStock	#A5D7B7
44597337227503	Size 1 / #FFD9FF	OutOfStock	#FFD9FF
44597337260271	Size 2 / #FFD9FF	OutOfStock	#FFD9FF
45972971225327	All Size / #857663	OutOfStock	#857663
44304808640751	All Size / Black	OutOfStock	Black
45972896973039	All Size / Maroon	InStock	Maroon
43790494564591	All Size / #C19A6B	OutOfStock	#C19A6B
46121929507055	All Size / #371d10	OutOfStock	#371d10
45533405806831	Size Small / #77815c	OutOfStock	#77815c
45533405839599	Size Medium / #77815c	OutOfStock	#77815c
45533405872367	Size Large / #77815c	OutOfStock	#77815c
46113723384047	All Size / #DE3636	OutOfStock	#DE3636
44002294104303	Size 1 / #36A5B2	OutOfStock	#36A5B2
44002294137071	Size 2 / #36A5B2	OutOfStock	#36A5B2
46549273247983	All Size / #F3F2EC	OutOfStock	#F3F2EC
46272080511215	Size 1 / #77815c	OutOfStock	#77815c
46272080543983	Size 2 / #77815c	OutOfStock	#77815c
42146376286447	All Size / Maroon	OutOfStock	Maroon
46170729054447	Size 1 / #5C0000	OutOfStock	#5C0000
46170729087215	Size 2 / #5C0000	OutOfStock	#5C0000
45526544122095	Size 1 / #2B3856	OutOfStock	#2B3856
45526544154863	Size 2 / #2B3856	OutOfStock	#2B3856
43642718519535	All Size / White	OutOfStock	White
44246334898415	Size 1 / #366AA4	OutOfStock	#366AA4
44246355542255	Size 2 / #366AA4	OutOfStock	#366AA4
44136623341807	Size 1 / Black	OutOfStock	Black
44136739340527	Size 2 / Black	OutOfStock	Black
43642702725359	All Size / Red	OutOfStock	Red
43040032293103	All Size / White	OutOfStock	White
45972868038895	All Size / #996633	OutOfStock	#996633
42611038224623	All Size / #996633	OutOfStock	#996633
41247808815282	All Size / Black	OutOfStock	Black
45075636617455	All Size / #2B3856	OutOfStock	#2B3856
43642689126639	Size 1 / Red	OutOfStock	Red
43642689159407	Size 2 / Red	OutOfStock	Red
46113700053231	#2B3856 / Protea Set / Size 1	OutOfStock	Size 1
46317622100207	#2B3856 / Protea Set / Size 2	InStock	Size 2
46317622132975	#2B3856 / Protea Top (Only) / Size 1	InStock	Size 1
46317622165743	#2B3856 / Protea Top (Only) / Size 2	InStock	Size 2
46317622198511	#2B3856 / Protea Skirt (Only) / Size 1	InStock	Size 1
46317622231279	#2B3856 / Protea Skirt (Only) / Size 2	InStock	Size 2
44044779978991	All Size / Black	OutOfStock	Black
45075571474671	Size Small / #2B3856	OutOfStock	#2B3856
45075571507439	Size Medium / #2B3856	OutOfStock	#2B3856
45075571540207	Size Large / #2B3856	OutOfStock	#2B3856
44062104584431	1 / Black	OutOfStock	Black
44062159438063	2 / Black	OutOfStock	Black
44137063055599	Size 1 / Beige	OutOfStock	Beige
44137063121135	Size 2 / Beige	OutOfStock	Beige
42922240082159	All Size / White	OutOfStock	White
44352435519727	All Size / Maroon	OutOfStock	Maroon
42090679697647	All Size / White	OutOfStock	White
46272145653999	Size 1 / Black	OutOfStock	Black
46272145686767	Size 2 / Black	OutOfStock	Black
45890199650543	Size 1 / Black	OutOfStock	Black
45890205941999	Size 2 / Black	OutOfStock	Black
44246377070831	Size 1 / #996633	OutOfStock	#996633
44246377103599	Size 2 / #996633	OutOfStock	#996633
46662818529519	Size 1 / Ready / #FFF8E5	OutOfStock	#FFF8E5
46667903795439	Size 1 / Preorder 10 Working Days / #FFF8E5	OutOfStock	#FFF8E5
46671903457519	Size 1 / Preorder 21 Working Days / #FFF8E5	OutOfStock	#FFF8E5
46662818562287	Size 2 / Ready / #FFF8E5	OutOfStock	#FFF8E5
46667903828207	Size 2 / Preorder 10 Working Days / #FFF8E5	OutOfStock	#FFF8E5
46671903490287	Size 2 / Preorder 21 Working Days / #FFF8E5	OutOfStock	#FFF8E5
44660033716463	All Size / #FFFFE7	OutOfStock	#FFFFE7
44660092076271	All Size / Black	OutOfStock	Black
45329178263791	Size 1 / #A5DAF5	OutOfStock	#A5DAF5
45329178296559	Size 2 / #A5DAF5	OutOfStock	#A5DAF5
45329178329327	Size 3 / #A5DAF5	OutOfStock	#A5DAF5
45329178362095	Size 4 / #A5DAF5	OutOfStock	#A5DAF5
45413205999855	Size Small / Beige	OutOfStock	Beige
45413216059631	Size Medium / Beige	OutOfStock	Beige
44482699231471	Size 1 / #F7CAC9	OutOfStock	#F7CAC9
44482699264239	Size 2 / #F7CAC9	OutOfStock	#F7CAC9
44553784230127	All size / Pink	OutOfStock	Pink
44137242886383	All Size / #371d10	OutOfStock	#371d10
44002333884655	Small / White	OutOfStock	White
44002333917423	Medium / White	OutOfStock	White
44002333950191	Large / White	OutOfStock	White
46456168349935	All Size / #ECCDBE	InStock	#ECCDBE
46113697169647	All Size / #2B3856	OutOfStock	#2B3856
46581909291247	All Size / #F7CAC9	InStock	#F7CAC9
42496765690095	S-M / #2B3856	OutOfStock	#2B3856
42496765722863	M-L / #2B3856	OutOfStock	#2B3856
45890050818287	All Size / Black	OutOfStock	Black
46124951273711	Size Small / #684522	OutOfStock	#684522
46124951306479	Size Medium / #684522	OutOfStock	#684522
46124951339247	Size Large / #684522	OutOfStock	#684522
43039873859823	All Size / White	OutOfStock	White
44002331295983	Size Small / Black	OutOfStock	Black
44002333589743	Size Medium / Black	OutOfStock	Black
44002333622511	Size Large / Black	OutOfStock	Black
44002333655279	Size XL / Black	OutOfStock	Black
42611157532911	All Size / White	OutOfStock	White
44289511063791	All Size / Red	OutOfStock	Red
46426708345071	Size 1 / Grey	OutOfStock	Grey
46426752778479	Size 2 / Grey	OutOfStock	Grey
44659770917103	All Size / #FFD9FF	OutOfStock	#FFD9FF
46272038732015	Size Small / #6CA644	OutOfStock	#6CA644
46272038764783	Size Medium / #6CA644	OutOfStock	#6CA644
46272065339631	Size Large / #6CA644	OutOfStock	#6CA644
46573744619759	Size Small (Preorder 25 Working Days) / #D0C2B8	InStock	#D0C2B8
46573744652527	Size Medium (Preorder 25 Working Days) / #D0C2B8	OutOfStock	#D0C2B8
44597303410927	All Size / #FFD9FF	OutOfStock	#FFD9FF
45968766140655	Size 1 / #FFEEBD	OutOfStock	#FFEEBD
45968782033135	Size 2 / #FFEEBD	OutOfStock	#FFEEBD
46317215121647	Size Small / Black	OutOfStock	Black
46317215154415	Size Medium / Black	InStock	Black
46317232980207	Size Large / Black	OutOfStock	Black
46573745012975	Size Small (Preorder 25 Working Days) / Beige	InStock	Beige
46573745045743	Size Medium (Preorder 25 Working Days) / Beige	InStock	Beige
46059350393071	Size Small / #A5D7B7	OutOfStock	#A5D7B7
46059350425839	Size Medium / #A5D7B7	OutOfStock	#A5D7B7
46059350458607	Size Large / #A5D7B7	OutOfStock	#A5D7B7
45413144690927	Size Small / #A5DAF5	OutOfStock	#A5DAF5
45413184667887	Size Medium / #A5DAF5	OutOfStock	#A5DAF5
43642705805551	All Size / Black	OutOfStock	Black
44246442901743	All Size / White	OutOfStock	White
46538310353135	All Size / #565656	OutOfStock	#565656
44304814407919	All Size / #DE3636	OutOfStock	#DE3636
43790368440559	Size Small / #CCC6AC	OutOfStock	#CCC6AC
43790368473327	Size Medium / #CCC6AC	OutOfStock	#CCC6AC
46417287250159	Size Large / #CCC6AC	OutOfStock	#CCC6AC
42090596565231	All Size / #DE3636	OutOfStock	#DE3636
46662847856879	Size 1 / #306094 / Ready	OutOfStock	Ready
46668069667055	Size 1 / #306094 / Preorder 10 Working Days	OutOfStock	Preorder 10 Working Days
46711398138095	Size 1 / #306094 / Preorder 20 Working Days	InStock	Preorder 20 Working Days
46662847889647	Size 2 / #306094 / Ready	OutOfStock	Ready
46668069699823	Size 2 / #306094 / Preorder 10 Working Days	OutOfStock	Preorder 10 Working Days
46711398170863	Size 2 / #306094 / Preorder 20 Working Days	InStock	Preorder 20 Working Days
45077894398191	Size 1 / White	OutOfStock	White
45077915304175	Size 2 / White	OutOfStock	White
42146335555823	All Size / Light Grey	OutOfStock	Light Grey
44289151041775	All size / #CCC6AC	OutOfStock	#CCC6AC
46170771816687	Size Small (Preorder 14 Working Days) / #FFF8E5	OutOfStock	#FFF8E5
46170771849455	Size Medium / #FFF8E5	OutOfStock	#FFF8E5
46256060924143	Size Large / #FFF8E5	OutOfStock	#FFF8E5
43896802410735	All Size / #FF0080	OutOfStock	#FF0080
44137158836463	All Size / White	OutOfStock	White
46063414804719	All Size (SHIPMENT JANUARY) / #c9b9ad	OutOfStock	#c9b9ad
46170718765295	Size 1 / #D4E7C7	OutOfStock	#D4E7C7
46170721091823	Size 2 / #D4E7C7	OutOfStock	#D4E7C7
46170704117999	All Size / #A4A000	OutOfStock	#A4A000
44289515782383	All Size / #4b5320	OutOfStock	#4b5320
44246570959087	All Size / #000026	OutOfStock	#000026
45968835739887	Size 1 / #FFEEBD	OutOfStock	#FFEEBD
45968844587247	Size 2 / #FFEEBD	OutOfStock	#FFEEBD
43952922067183	All size / Black	OutOfStock	Black
44553786065135	All size / Black	OutOfStock	Black
44597356265711	Size S / #2B3856	OutOfStock	#2B3856
44597356298479	Size M / #2B3856	OutOfStock	#2B3856
44597356331247	Size L / #2B3856	OutOfStock	#2B3856
46549471887599	Size Small / #5A6553	OutOfStock	#5A6553
46549471920367	Size Medium / #5A6553	OutOfStock	#5A6553
46549471953135	Size Large / #5A6553	OutOfStock	#5A6553
45773911195887	Size 1 / #C8ECF4	OutOfStock	#C8ECF4
45773911228655	Size 2 / #C8ECF4	OutOfStock	#C8ECF4
45329205362927	Case Only / #F7CAC9	OutOfStock	#F7CAC9
45330210619631	Plus Insert / #F7CAC9	OutOfStock	#F7CAC9
43877962285295	All size / #02064a	OutOfStock	#02064a
43952853876975	All size / White	OutOfStock	White
46170742358255	Size 1 / Maroon	OutOfStock	Maroon
46170763133167	Size 2 / Maroon	OutOfStock	Maroon
46170621968623	Size 1 / #D4E7C7	OutOfStock	#D4E7C7
46170631274735	Size 2 / #D4E7C7	OutOfStock	#D4E7C7
46063416639727	Size 1 / White	OutOfStock	White
46063424798959	Size 2 / White	OutOfStock	White
46662934593775	Size Small / Ready / #000042	InStock	#000042
46668188647663	Size Small / Preorder 10 Working Days / #000042	InStock	#000042
46662934626543	Size Medium / Ready / #000042	InStock	#000042
46668188680431	Size Medium / Preorder 10 Working Days / #000042	InStock	#000042
46662934659311	Size Large / Ready / #000042	InStock	#000042
46668188713199	Size Large / Preorder 10 Working Days / #000042	InStock	#000042
42722217820399	All Size / Light Blue	OutOfStock	Light Blue
46414069793007	All Size / #371d10	InStock	#371d10
43642697973999	All Size / Red	OutOfStock	Red
43793546281199	All Size / Grey	OutOfStock	Grey
43178766074095	All Size / Grey	OutOfStock	Grey
42496776044783	S-M / #B0DBF6	OutOfStock	#B0DBF6
42496776077551	M-L / #B0DBF6	OutOfStock	#B0DBF6
45329231741167	Case Only / #A5DAF5	OutOfStock	#A5DAF5
45330218352879	Plus Insert / #A5DAF5	OutOfStock	#A5DAF5
46059333419247	All Size / #C8ECF4	OutOfStock	#C8ECF4
43953587912943	All Size / Brown	OutOfStock	Brown
44289283948783	All Size / #000042	OutOfStock	#000042
44044716245231	All Size / Black	OutOfStock	Black
44002328019183	All Size / White	OutOfStock	White
46573745209583	Size Small (Preorder 25 Working Days) / Black	InStock	Black
46573745242351	Size Medium (Preorder 25 Working Days) / Black	OutOfStock	Black
46662895763695	All Size / Ready / #F3F2EC	OutOfStock	#F3F2EC
46668098437359	All Size / Preorder 14 Working Days / #F3F2EC	OutOfStock	#F3F2EC
46671901229295	All Size / Preorder 21 Working Days / #F3F2EC	InStock	#F3F2EC
43790342914287	1 / #F3F2EC	OutOfStock	#F3F2EC
43790342947055	2 / #F3F2EC	OutOfStock	#F3F2EC
44660073464047	All Size / White	OutOfStock	White
43790757495023	Size 1 / Black	OutOfStock	Black
43795346784495	Size 2 / Black	OutOfStock	Black
46124932464879	Size 1 / #996633	OutOfStock	#996633
46124933939439	Size 2 / #996633	OutOfStock	#996633
43642698268911	All Size / Red	OutOfStock	Red
43713133183215	All Size / #c64501	OutOfStock	#c64501
43893844345071	All Size / Black	OutOfStock	Black
46549442003183	Size Small / #FFEEBD	InStock	#FFEEBD
46549442035951	Size Medium / #FFEEBD	InStock	#FFEEBD
46549442461935	Size Large / #FFEEBD	OutOfStock	#FFEEBD
44289264222447	All Size / Maroon	OutOfStock	Maroon
45972851359983	All Size / Beige	OutOfStock	Beige
45329241309423	All Size / #F7CAC9	OutOfStock	#F7CAC9
45533412851951	Size Small / Black	OutOfStock	Black
45533412917487	Size Medium / Black	OutOfStock	Black
45533412950255	Size Large / Black	OutOfStock	Black
46272101613807	Size 1 / #77815c	OutOfStock	#77815c
46272101646575	Size 2 / #77815c	OutOfStock	#77815c
44289127874799	Size 1 / #3A3A3A	OutOfStock	#3A3A3A
44289127907567	Size 2 / #3A3A3A	OutOfStock	#3A3A3A
44289189740783	Small / #C0C0C0	OutOfStock	#C0C0C0
44289189773551	Medium / #C0C0C0	OutOfStock	#C0C0C0
44289189806319	Large / #C0C0C0	OutOfStock	#C0C0C0
44246550151407	All Size / #000026	OutOfStock	#000026
46124956713199	Size 1 / #371d10	OutOfStock	#371d10
46124962578671	Size 2 / #371d10	OutOfStock	#371d10
42611057918191	CREAM / ALL SIZE	OutOfStock	ALL SIZE
44069826167023	All Size / White	OutOfStock	White
44426328408303	S / #DE3636	OutOfStock	#DE3636
44426328441071	M / #DE3636	OutOfStock	#DE3636
44426330210543	L / #DE3636	OutOfStock	#DE3636
44288994083055	All Size / Black	OutOfStock	Black
44590692761839	All Size / White	OutOfStock	White
45527148396783	Size 1 / #595959	OutOfStock	#595959
45527148429551	Size 2 / #595959	OutOfStock	#595959
46170690617583	All Size / #D4E7C7	OutOfStock	#D4E7C7
42090647355631	All Size / #DE3636	OutOfStock	#DE3636
44245204238575	All Size / Black	OutOfStock	Black
46063393341679	All Size / #371d10	OutOfStock	#371d10
44058543587567	1 / #FACAEF	OutOfStock	#FACAEF
44062697128175	2 / #FACAEF	OutOfStock	#FACAEF
44062104617199	All Size / White	OutOfStock	White
44246245081327	Size 1 / #996633	OutOfStock	#996633
44246308323567	Size 2 / #996633	OutOfStock	#996633
46272149094639	Size 1 / #371d10	OutOfStock	#371d10
46272149127407	Size 2 / #371d10	OutOfStock	#371d10
43790768865519	All Size / Black	OutOfStock	Black
45890083946735	Size 1 / Black	OutOfStock	Black
45890094465263	Size 2 / Black	OutOfStock	Black
45075456721135	Size Small / #2B3856	OutOfStock	#2B3856
45075507216623	Size Medium / #2B3856	OutOfStock	#2B3856
45075507249391	Size Large / #2B3856	OutOfStock	#2B3856
44596299694319	Size 1 / #FFD9FF	OutOfStock	#FFD9FF
44596353007855	Size 2 / #FFD9FF	OutOfStock	#FFD9FF
44289383530735	Size S / #000042	OutOfStock	#000042
44289383563503	Size M / #000042	OutOfStock	#000042
44289383596271	Size L / #000042	OutOfStock	#000042
46170742128879	All Size / Black	OutOfStock	Black
46317306020079	All Size / #FFF7E1	OutOfStock	#FFF7E1
44244723925231	Size S / Light Grey	OutOfStock	Light Grey
44244723957999	Size M / Light Grey	OutOfStock	Light Grey
44244723990767	Size L / Light Grey	OutOfStock	Light Grey
45774092894447	Size Small / Black	OutOfStock	Black
45774104101103	Size Medium / Black	OutOfStock	Black
45774104133871	Size Large / Black	OutOfStock	Black
46317588873455	Size Small / #ab936b	OutOfStock	#ab936b
46317588906223	Size Medium / #ab936b	OutOfStock	#ab936b
46317588938991	Size Large / #ab936b	OutOfStock	#ab936b
44062132306159	All Size / #2B3856	OutOfStock	#2B3856
42155146150127	SM / #02064a	OutOfStock	#02064a
42155146182895	ML / #02064a	OutOfStock	#02064a
43790344061167	1 / #CCC6AC	OutOfStock	#CCC6AC
43790344093935	2 / #CCC6AC	OutOfStock	#CCC6AC
43514855719151	All Size / White	OutOfStock	White
46662934921455	Size Small / White	InStock	White
46662934954223	Size Medium / White	InStock	White
46662935838959	Size Large / White	InStock	White
44002289254639	Size 1 / #36A5B2	OutOfStock	#36A5B2
44002289287407	Size 2 / #36A5B2	OutOfStock	#36A5B2
46573544702191	All Size / #FFEEBD	OutOfStock	#FFEEBD
45526774382831	All Size / #2B3856	OutOfStock	#2B3856
43790371913967	Size Small / Black	OutOfStock	Black
43790371946735	Size Medium / Black	OutOfStock	Black
46417286267119	Size Large / Black	OutOfStock	Black
45077838561519	Size Small / #2B3856	OutOfStock	#2B3856
45077838594287	Size Medium / #2B3856	OutOfStock	#2B3856
45077838627055	Size Large / #2B3856	OutOfStock	#2B3856
43713153728751	All Size / Black	OutOfStock	Black
44136350941423	Size 1 / Black	OutOfStock	Black
44136359919855	Size 2 / Black	OutOfStock	Black
43515015135471	All size / #2B3856	OutOfStock	#2B3856
42090536993007	All Size / black	OutOfStock	black
45526417572079	All Size / #FFFFF3	OutOfStock	#FFFFF3
46124934889711	All Size / #371d10	OutOfStock	#371d10
46456355979503	All Size / #660033	OutOfStock	#660033
44244875018479	Size S / Light Grey	OutOfStock	Light Grey
44244875051247	Size M / Light Grey	OutOfStock	Light Grey
44244875084015	Size L / Light Grey	OutOfStock	Light Grey
45526739517679	Size 1 / #2B3856	OutOfStock	#2B3856
45526758588655	Size 2 / #2B3856	OutOfStock	#2B3856
45808841490671	Size Small / #7caac6	OutOfStock	#7caac6
45808841523439	Size Medium / #7caac6	OutOfStock	#7caac6
45808841556207	Size Large / #7caac6	OutOfStock	#7caac6
45972777599215	Size Small / #2B3856	OutOfStock	#2B3856
45972777631983	Size Medium / #2B3856	OutOfStock	#2B3856
45972789756143	Size Large / #2B3856	OutOfStock	#2B3856
46121922101487	All Size / Maroon	InStock	Maroon
44304749658351	All Size / Grey	OutOfStock	Grey
43713135378671	All Size / Red	OutOfStock	Red
44304774529263	Size 1 / Black	OutOfStock	Black
44304778559727	Size 2 / Black	OutOfStock	Black
46662851068143	Size 1 / #306094 / Ready	OutOfStock	Ready
46668073631983	Size 1 / #306094 / Preorder 10 Working Days	OutOfStock	Preorder 10 Working Days
46711441719535	Size 1 / #306094 / Preorder 20 Working Days	InStock	Preorder 20 Working Days
46662851100911	Size 2 / #306094 / Ready	OutOfStock	Ready
46668073664751	Size 2 / #306094 / Preorder 10 Working Days	OutOfStock	Preorder 10 Working Days
46711441752303	Size 2 / #306094 / Preorder 20 Working Days	InStock	Preorder 20 Working Days
44426312253679	Size 1 / #DE3636	OutOfStock	#DE3636
44426315596015	Size 2 / #DE3636	OutOfStock	#DE3636
44553798451439	All size / White	OutOfStock	White
44069826396399	Small / #7caac6	OutOfStock	#7caac6
44069826429167	Medium / #7caac6	OutOfStock	#7caac6
44069826461935	Large / #7caac6	OutOfStock	#7caac6
\.


--
-- Data for Name: fact_catalog; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fact_catalog (product_id, category_id, variant_id, measurement_id, price) FROM stdin;
8986642317551	C002	46549384757487	483	685000.0
8986642317551	C002	46549384757487	482	685000.0
8986642317551	C002	46549384790255	483	685000.0
8986642317551	C002	46549384790255	482	685000.0
8145215291631	C005	44136493842671	792	650000.0
8145215291631	C005	44136493842671	791	650000.0
8145215291631	C005	44136493842671	790	650000.0
8145215291631	C005	44136493875439	792	650000.0
8145215291631	C005	44136493875439	791	650000.0
8145215291631	C005	44136493875439	790	650000.0
8145215291631	C005	44136513175791	792	650000.0
8145215291631	C005	44136513175791	791	650000.0
8145215291631	C005	44136513175791	790	650000.0
8843353587951	C003	46124927582447	17	750000.0
8198585417967	C002	44253617029359	368	487500.0
8006360498415	C002	43793305272559	88	140000.0
7740273590511	C002	43040041205999	313	525000.0
8913121149167	C002	46315771298031	264	525000.0
8896420479215	C005	46270361174255	328	700000.0
8896420479215	C005	46270361174255	327	700000.0
8896420479215	C005	46270361174255	326	700000.0
8896420479215	C005	46270361174255	325	700000.0
8896420479215	C005	46270361207023	328	700000.0
8896420479215	C005	46270361207023	327	700000.0
8896420479215	C005	46270361207023	326	700000.0
8896420479215	C005	46270361207023	325	700000.0
8896420479215	C005	46270361239791	328	700000.0
8896420479215	C005	46270361239791	327	700000.0
8896420479215	C005	46270361239791	326	700000.0
8896420479215	C005	46270361239791	325	700000.0
8896420479215	C005	46328188829935	328	700000.0
8896420479215	C005	46328188829935	327	700000.0
8896420479215	C005	46328188829935	326	700000.0
8896420479215	C005	46328188829935	325	700000.0
8145104994543	C003	44136269119727	134	700000.0
8498426675439	C002	45076697415919	349	625000.0
8498426675439	C002	45076697415919	348	625000.0
8498426675439	C002	45076956905711	349	625000.0
8498426675439	C002	45076956905711	348	625000.0
8196275405039	C005	44246415966447	512	465500.0
8196275405039	C005	44246415966447	511	465500.0
8196275405039	C005	44246415999215	512	465500.0
8196275405039	C005	44246415999215	511	465500.0
8218770833647	C002	44304810639599	488	562500.0
8218770833647	C002	44304810639599	487	562500.0
8218770833647	C002	44304811327727	488	562500.0
8218770833647	C002	44304811327727	487	562500.0
9000438857967	C001	46573580583151	656	725000.0
9000438857967	C001	46573580583151	655	725000.0
9000438857967	C001	46573580615919	656	725000.0
9000438857967	C001	46573580615919	655	725000.0
7571081887983	C002	42496742228207	811	575000.0
8752245506287	C002	45808864067823	710	475000.0
8752245506287	C002	45808864067823	709	475000.0
8752245506287	C002	45808864100591	710	475000.0
8752245506287	C002	45808864100591	709	475000.0
8076514394351	C002	43989013233903	155	600000.0
8076514394351	C002	43989013233903	154	600000.0
8076514394351	C002	43989013627119	155	600000.0
8076514394351	C002	43989013627119	154	600000.0
8986673447151	C003	46549488500975	125	650000.0
9024414941423	C005	46662841336047	643	685000.0
9024414941423	C005	46662841336047	642	685000.0
9024414941423	C005	46662841336047	641	685000.0
9024414941423	C005	46662841368815	643	685000.0
9024414941423	C005	46662841368815	642	685000.0
9024414941423	C005	46662841368815	641	685000.0
9024414941423	C005	46667799855343	643	685000.0
9024414941423	C005	46667799855343	642	685000.0
9024414941423	C005	46667799855343	641	685000.0
8060728180975	C005	43953581064431	275	725000.0
8825018679535	C003	46063411986671	171	650000.0
8220544205039	C005	44308620771567	834	575000.0
8220544205039	C005	44308620771567	833	575000.0
8220544205039	C005	44308620771567	832	575000.0
8220544205039	C005	44308620804335	834	575000.0
8220544205039	C005	44308620804335	833	575000.0
8220544205039	C005	44308620804335	832	575000.0
8220544205039	C005	44308631486703	834	575000.0
8220544205039	C005	44308631486703	833	575000.0
8220544205039	C005	44308631486703	832	575000.0
7947445764335	C002	43645302407407	405	600000.0
9000439841007	C006	46573587497199	207	695000.0
9000439841007	C006	46573587497199	206	695000.0
9000439841007	C006	46573587529967	207	695000.0
9000439841007	C006	46573587529967	206	695000.0
8947918569711	C005	46414078279919	132	675000.0
8947918569711	C005	46414078279919	131	675000.0
8947918569711	C005	46414078279919	130	675000.0
8947918569711	C005	46414078312687	132	675000.0
8947918569711	C005	46414078312687	131	675000.0
8947918569711	C005	46414078312687	130	675000.0
8947918569711	C005	46414078345455	132	675000.0
8947918569711	C005	46414078345455	131	675000.0
8947918569711	C005	46414078345455	130	675000.0
8060403974383	C005	43952829497583	728	675000.0
7471338193135	C006	42146372845807	147	650000.0
7471348252911	C003	42146394603759	592	663000.0
8329483780335	C001	44660251951343	479	337500.0
8792612339951	C002	45972973256943	930	395000.0
7740497690863	C005	43040682246383	108	450000.0
8896418152687	C005	46270334402799	432	700000.0
8896418152687	C005	46270334402799	431	700000.0
8896418152687	C005	46270334402799	430	700000.0
8896418152687	C005	46270334402799	429	700000.0
8896418152687	C005	46270348165359	432	700000.0
8896418152687	C005	46270348165359	431	700000.0
8896418152687	C005	46270348165359	430	700000.0
8896418152687	C005	46270348165359	429	700000.0
8896418152687	C005	46270348198127	432	700000.0
8896418152687	C005	46270348198127	431	700000.0
8896418152687	C005	46270348198127	430	700000.0
8896418152687	C005	46270348198127	429	700000.0
8896418152687	C005	46328189452527	432	700000.0
8896418152687	C005	46328189452527	431	700000.0
8896418152687	C005	46328189452527	430	700000.0
8896418152687	C005	46328189452527	429	700000.0
8825021530351	C002	46063415492847	799	650000.0
8825021530351	C002	46063415492847	798	650000.0
8825021530351	C002	46063425093871	799	650000.0
8825021530351	C002	46063425093871	798	650000.0
7740221128943	C001	43039856361711	933	665000.0
8145244520687	C005	44136539980015	247	650000.0
8145244520687	C005	44136539980015	246	650000.0
8145244520687	C005	44136539980015	245	650000.0
8145244520687	C005	44136540012783	247	650000.0
8145244520687	C005	44136540012783	246	650000.0
8145244520687	C005	44136540012783	245	650000.0
8145244520687	C005	44136540045551	247	650000.0
8145244520687	C005	44136540045551	246	650000.0
8145244520687	C005	44136540045551	245	650000.0
8896426836207	C002	46270381457647	396	750000.0
8896426836207	C002	46270381457647	395	750000.0
8896426836207	C002	46270387945711	396	750000.0
8896426836207	C002	46270387945711	395	750000.0
8196111565039	C005	44244945928431	718	565250.0
8116765851887	C002	44075334140143	18	600000.0
8145607033071	C006	44137330704623	476	625000.0
8145607033071	C006	44137330704623	475	625000.0
8145607033071	C006	44137352102127	476	625000.0
8145607033071	C006	44137352102127	475	625000.0
7471298543855	C002	42145903968495	306	550000.0
8196244504815	C002	44246311502063	426	402500.0
8196244504815	C002	44246311502063	425	402500.0
8196244504815	C002	44246311534831	426	402500.0
8196244504815	C002	44246311534831	425	402500.0
7946310025455	C003	43642729070831	146	650000.0
7946310025455	C003	43642729070831	145	650000.0
7946310025455	C003	43645550493935	146	650000.0
7946310025455	C003	43645550493935	145	650000.0
8145540219119	C002	44137177809135	391	420000.0
8913120493807	C006	46315766841583	616	616500.0
8913120493807	C006	46315766841583	615	616500.0
8913120493807	C006	46315766841583	614	616500.0
8913120493807	C006	46315766874351	616	616500.0
8913120493807	C006	46315766874351	615	616500.0
8913120493807	C006	46315766874351	614	616500.0
8913120493807	C006	46315769364719	616	616500.0
8913120493807	C006	46315769364719	615	616500.0
8913120493807	C006	46315769364719	614	616500.0
8896420839663	C002	46270364451055	160	525000.0
7739103543535	C001	43037231972591	2	665000.0
8145623580911	C005	44137361506543	170	325000.0
8145623580911	C005	44137361506543	169	325000.0
8145623580911	C005	44137361539311	170	325000.0
8145623580911	C005	44137361539311	169	325000.0
7894084976879	C002	43514886324463	557	650000.0
8289518747887	C001	44536057692399	82	675000.0
8289518747887	C001	44536083546351	82	675000.0
8289518747887	C001	44536083579119	82	675000.0
8773329977583	C002	45890150695151	159	427500.0
8843352703215	C003	46124926304495	570	750000.0
8843368071407	C001	46124963102959	594	637500.0
8843368071407	C001	46124963102959	593	637500.0
8843368071407	C001	46124963135727	594	637500.0
8843368071407	C001	46124963135727	593	637500.0
8773355765999	C002	45890209906927	857	495000.0
8773355765999	C002	45890209906927	856	495000.0
8773355765999	C002	45890209939695	857	495000.0
8773355765999	C002	45890209939695	856	495000.0
7946308813039	C002	43642727432431	428	409500.0
8329441050863	C002	44659816399087	457	1250000.0
8329441050863	C002	44659816399087	456	1250000.0
8329441050863	C002	44659816431855	457	1250000.0
8329441050863	C002	44659816431855	456	1250000.0
8791886528751	C003	45968880959727	835	900000.0
7959651221743	C007	43672707793135	161	350000.0
7959651221743	C007	43672707825903	161	350000.0
7959651221743	C007	43672707858671	161	350000.0
8307526140143	C001	44597327757551	242	750000.0
8307526140143	C001	44597327757551	241	750000.0
8307526140143	C001	44597327790319	242	750000.0
8307526140143	C001	44597327790319	241	750000.0
9000439218415	C006	46573584220399	689	695000.0
9000439218415	C006	46573584220399	688	695000.0
9000439218415	C006	46573584253167	689	695000.0
9000439218415	C006	46573584253167	688	695000.0
8060699902191	C002	43953540071663	262	525000.0
8060699902191	C002	43953540071663	261	525000.0
8060699902191	C002	43953546232047	262	525000.0
8060699902191	C002	43953546232047	261	525000.0
8289522614511	C001	44536085840111	300	675000.0
8289522614511	C001	44536094195951	300	675000.0
8289522614511	C001	44536094228719	300	675000.0
8773325816047	C006	45890137522415	41	486500.0
8773325816047	C006	45890137522415	40	486500.0
8773325816047	C006	45890137555183	41	486500.0
8773325816047	C006	45890137555183	40	486500.0
8329477685487	C002	44660201292015	235	399000.0
8329477685487	C002	44660201292015	234	399000.0
8329477685487	C002	44660216398063	235	399000.0
8329477685487	C002	44660216398063	234	399000.0
8218791477487	C006	44304881549551	699	600000.0
8218791477487	C006	44304881549551	698	600000.0
8218791477487	C006	44304881582319	699	600000.0
8218791477487	C006	44304881582319	698	600000.0
7947448090863	C005	43645309354223	321	270000.0
8005216600303	C007	43790491910383	778	495000.0
8196225892591	C003	44246203105519	603	875000.0
8913099194607	C003	46315601232111	818	560000.0
8913099194607	C003	46315601232111	817	560000.0
8913099194607	C003	46315601264879	818	560000.0
8913099194607	C003	46315601264879	817	560000.0
8110085439727	C005	44062111039727	675	789000.0
8110085439727	C005	44062111039727	674	789000.0
8110085439727	C005	44062111039727	673	789000.0
8110085439727	C005	44062111072495	675	789000.0
8110085439727	C005	44062111072495	674	789000.0
8110085439727	C005	44062111072495	673	789000.0
8110085439727	C005	44062111105263	675	789000.0
8110085439727	C005	44062111105263	674	789000.0
8110085439727	C005	44062111105263	673	789000.0
8116764836079	C002	44075332272367	386	595000.0
7740496183535	C003	43040655409391	611	625000.0
8218757071087	C001	44304765714671	85	725000.0
8218757071087	C001	44304765714671	84	725000.0
8218757071087	C001	44304778887407	85	725000.0
8218757071087	C001	44304778887407	84	725000.0
8196107469039	C003	44244923121903	345	675000.0
7740234367215	C005	43039905120495	46	650000.0
7740234367215	C005	43039905153263	46	650000.0
8860273606895	C005	46170764476655	351	595000.0
8860273606895	C005	46170764476655	350	595000.0
8860273606895	C005	46170764509423	351	595000.0
8860273606895	C005	46170764509423	350	595000.0
8329480503535	C006	44660225540335	153	435000.0
8329480503535	C006	44660225540335	152	435000.0
8329480503535	C006	44660225573103	153	435000.0
8329480503535	C006	44660225573103	152	435000.0
8667284996335	C002	45533403611375	62	495000.0
8667284996335	C002	45533403611375	61	495000.0
8667284996335	C002	45533403611375	60	495000.0
8667284996335	C002	45533403644143	62	495000.0
8667284996335	C002	45533403644143	61	495000.0
8667284996335	C002	45533403644143	60	495000.0
8667284996335	C002	45533403676911	62	495000.0
8667284996335	C002	45533403676911	61	495000.0
8667284996335	C002	45533403676911	60	495000.0
7696641097967	C001	42922253058287	163	675000.0
8792566825199	C005	45972743487727	777	357000.0
8792566825199	C005	45972743487727	776	357000.0
8792566825199	C005	45972743520495	777	357000.0
8792566825199	C005	45972743520495	776	357000.0
8005183471855	C002	43790411694319	524	700000.0
8860281962735	C001	46170774798575	746	800000.0
8860281962735	C001	46170774798575	745	800000.0
8860281962735	C001	46170774831343	746	800000.0
8860281962735	C001	46170774831343	745	800000.0
8742187466991	C006	45773956219119	39	510000.0
8742187466991	C006	45773956219119	38	510000.0
8742187466991	C006	45773956251887	39	510000.0
8742187466991	C006	45773956251887	38	510000.0
8843354669295	C006	46124928303343	928	550000.0
8843354669295	C006	46124928303343	927	550000.0
8843354669295	C006	46124928336111	928	550000.0
8843354669295	C006	46124928336111	927	550000.0
8211497844975	C002	44289398538479	188	675000.0
7471335211247	C006	42146368159983	625	650000.0
8625233592559	C002	45413226348783	324	400000.0
8625233592559	C002	45413226348783	323	400000.0
8625233592559	C002	45413226381551	324	400000.0
8625233592559	C002	45413226381551	323	400000.0
8843362238703	C005	46124945506543	936	595000.0
8843362238703	C005	46124945506543	935	595000.0
8843362238703	C005	46124945506543	934	595000.0
8843362238703	C005	46124945539311	936	595000.0
8843362238703	C005	46124945539311	935	595000.0
8843362238703	C005	46124945539311	934	595000.0
8843362238703	C005	46124945572079	936	595000.0
8843362238703	C005	46124945572079	935	595000.0
8843362238703	C005	46124945572079	934	595000.0
7823880028399	C002	43281641308399	637	700000.0
8667282800879	C002	45533395583215	768	495000.0
8667282800879	C002	45533395583215	767	495000.0
8667282800879	C002	45533395583215	766	495000.0
8667282800879	C002	45533403119855	768	495000.0
8667282800879	C002	45533403119855	767	495000.0
8667282800879	C002	45533403119855	766	495000.0
8667282800879	C002	45533403152623	768	495000.0
8667282800879	C002	45533403152623	767	495000.0
8667282800879	C002	45533403152623	766	495000.0
9024378372335	C005	46662737658095	91	665000.0
9024378372335	C005	46662737658095	90	665000.0
9024378372335	C005	46662737658095	89	665000.0
9024378372335	C005	46662737690863	91	665000.0
9024378372335	C005	46662737690863	90	665000.0
9024378372335	C005	46662737690863	89	665000.0
9024378372335	C005	46662737723631	91	665000.0
9024378372335	C005	46662737723631	90	665000.0
9024378372335	C005	46662737723631	89	665000.0
8233622012143	C002	44352442302703	734	995000.0
8114152145135	C001	44069824692463	11	700000.0
8498523111663	C002	45077279768815	764	545000.0
8307522339055	C002	44597317632239	198	675000.0
8498257625327	C006	45075583697135	258	300000.0
8498257625327	C006	45075583697135	257	300000.0
8498257625327	C006	45075583697135	256	300000.0
8498257625327	C006	45075583729903	258	300000.0
8498257625327	C006	45075583729903	257	300000.0
8498257625327	C006	45075583729903	256	300000.0
8498257625327	C006	45075583762671	258	300000.0
8498257625327	C006	45075583762671	257	300000.0
8498257625327	C006	45075583762671	256	300000.0
7455630426351	C002	42090490036463	284	550000.0
8823413145839	C003	46059334795503	562	1750000.0
8843368300783	C001	46124963660015	926	450000.0
8843368300783	C001	46124963660015	925	450000.0
8843368300783	C001	46124963692783	926	450000.0
8843368300783	C001	46124963692783	925	450000.0
8269638271215	C003	44482876539119	139	696500.0
8625234739439	C002	45413234901231	775	400000.0
8625234739439	C002	45413234901231	774	400000.0
8625234739439	C002	45413234933999	775	400000.0
8625234739439	C002	45413234933999	774	400000.0
8843350245615	C002	46124919914735	797	675000.0
8030772199663	C003	43877918540015	47	985000.0
8913520197871	C002	46317303070959	263	565000.0
9001294102767	C003	46576949821679	729	675000.0
8060443361519	C006	43952940253423	162	575000.0
8037925126383	C002	43896752636143	196	585000.0
8196090462447	C005	44244797358319	847	295000.0
8196090462447	C005	44244797358319	846	295000.0
8196090462447	C005	44244797358319	845	295000.0
8196090462447	C005	44244797358319	844	295000.0
8196090462447	C005	44244797554927	847	295000.0
8196090462447	C005	44244797554927	846	295000.0
8196090462447	C005	44244797554927	845	295000.0
8196090462447	C005	44244797554927	844	295000.0
8196090462447	C005	44244797587695	847	295000.0
8196090462447	C005	44244797587695	846	295000.0
8196090462447	C005	44244797587695	845	295000.0
8196090462447	C005	44244797587695	844	295000.0
8196090462447	C005	44244861354223	847	295000.0
8196090462447	C005	44244861354223	846	295000.0
8196090462447	C005	44244861354223	845	295000.0
8196090462447	C005	44244861354223	844	295000.0
8294600245487	C002	44553786982639	449	525000.0
9024414122223	C002	46662839599343	424	590000.0
9024414122223	C002	46662839599343	423	590000.0
9024414122223	C002	46662839632111	424	590000.0
9024414122223	C002	46662839632111	423	590000.0
8792571707631	C002	45972758364399	37	585000.0
8792571707631	C002	45972758364399	36	585000.0
8792571707631	C002	45972758397167	37	585000.0
8792571707631	C002	45972758397167	36	585000.0
8030793269487	C005	43877960057071	896	789000.0
8030793269487	C005	43877960057071	895	789000.0
8030793269487	C005	43877960057071	894	789000.0
8030793269487	C005	43877960057071	893	789000.0
8030793269487	C005	43877960089839	896	789000.0
8030793269487	C005	43877960089839	895	789000.0
8030793269487	C005	43877960089839	894	789000.0
8030793269487	C005	43877960089839	893	789000.0
8030793269487	C005	43877960122607	896	789000.0
8030793269487	C005	43877960122607	895	789000.0
8030793269487	C005	43877960122607	894	789000.0
8030793269487	C005	43877960122607	893	789000.0
8030793269487	C005	43970323022063	896	789000.0
8030793269487	C005	43970323022063	895	789000.0
8030793269487	C005	43970323022063	894	789000.0
8030793269487	C005	43970323022063	893	789000.0
8082187518191	C001	44002330149103	223	675000.0
8082187518191	C001	44002330149103	222	675000.0
8082187518191	C001	44002330181871	223	675000.0
8082187518191	C001	44002330181871	222	675000.0
7571098894575	C003	42496840859887	292	600000.0
8959296176367	C002	46456309842159	678	585000.0
8959296176367	C002	46456309842159	677	585000.0
8959296176367	C002	46456309874927	678	585000.0
8959296176367	C002	46456309874927	677	585000.0
7894083371247	C002	43514872889583	528	526500.0
8959791005935	C005	46458544750831	495	685000.0
8959791005935	C005	46458544750831	494	685000.0
8959791005935	C005	46458544750831	493	685000.0
8959791005935	C005	46458544783599	495	685000.0
8959791005935	C005	46458544783599	494	685000.0
8959791005935	C005	46458544783599	493	685000.0
8959791005935	C005	46458544816367	495	685000.0
8959791005935	C005	46458544816367	494	685000.0
8959791005935	C005	46458544816367	493	685000.0
8986641760495	C002	46549383315695	858	600000.0
8304613720303	C001	44590680637679	45	695000.0
8825001378031	C002	46063389573359	904	650000.0
8211487719663	C002	44289346568431	620	685000.0
8211487719663	C002	44289346568431	619	685000.0
8211487719663	C002	44289351483631	620	685000.0
8211487719663	C002	44289351483631	619	685000.0
8824609833199	C003	46061916324079	932	700000.0
8824609833199	C003	46061916324079	931	700000.0
8824609833199	C003	46061916356847	932	700000.0
8824609833199	C003	46061916356847	931	700000.0
8211476185327	C005	44289297940719	909	695000.0
8211476185327	C005	44289297940719	908	695000.0
8211476185327	C005	44289297940719	907	695000.0
8211476185327	C005	44289305706735	909	695000.0
8211476185327	C005	44289305706735	908	695000.0
8211476185327	C005	44289305706735	907	695000.0
8211476185327	C005	44289305739503	909	695000.0
8211476185327	C005	44289305739503	908	695000.0
8211476185327	C005	44289305739503	907	695000.0
8498260541679	C005	45075594543343	717	650000.0
8498260541679	C005	45075594543343	716	650000.0
8498260541679	C005	45075594543343	715	650000.0
8498260541679	C005	45075594576111	717	650000.0
8498260541679	C005	45075594576111	716	650000.0
8498260541679	C005	45075594576111	715	650000.0
8498260541679	C005	45075594608879	717	650000.0
8498260541679	C005	45075594608879	716	650000.0
8498260541679	C005	45075594608879	715	650000.0
8005294457071	C003	43790763819247	737	550000.0
8005161746671	C005	43790362181871	627	675000.0
8005161746671	C005	43790362181871	626	675000.0
8005161746671	C005	43790362837231	627	675000.0
8005161746671	C005	43790362837231	626	675000.0
8005163909359	C001	43790374404335	809	600000.0
8005163909359	C001	43790374404335	808	600000.0
8005163909359	C001	43790376632559	809	600000.0
8005163909359	C001	43790376632559	808	600000.0
8316165914863	C002	44618520690927	367	650000.0
8316165914863	C002	44618520690927	366	650000.0
8316165914863	C002	44618520723695	367	650000.0
8316165914863	C002	44618520723695	366	650000.0
8843356078319	C006	46124930531567	111	467500.0
8843356078319	C006	46124930531567	110	467500.0
8843356078319	C006	46124930564335	111	467500.0
8843356078319	C006	46124930564335	110	467500.0
8751853666543	C006	45807942435055	8	525000.0
8751853666543	C006	45807942435055	7	525000.0
8751853666543	C006	45807942435055	6	525000.0
8751853666543	C006	45807942467823	8	525000.0
8751853666543	C006	45807942467823	7	525000.0
8751853666543	C006	45807942467823	6	525000.0
8751853666543	C006	45807950954735	8	525000.0
8751853666543	C006	45807950954735	7	525000.0
8751853666543	C006	45807950954735	6	525000.0
7946313138415	C005	43642735591663	892	665000.0
7946313138415	C005	43642735591663	891	665000.0
7946313138415	C005	43642735624431	892	665000.0
7946313138415	C005	43642735624431	891	665000.0
7455664865519	C005	42090568089839	226	650000.0
8304605561071	C002	44590661730543	448	585000.0
8825016811759	C003	46063408677103	268	650000.0
7804254978287	C001	43220078592239	435	665000.0
7946296885487	C002	43642701611247	105	595000.0
8060384837871	C005	43952805118191	743	665000.0
8896417726703	C002	46270332502255	305	500000.0
8897159463151	C002	46272142901487	714	520000.0
8897159463151	C002	46272142901487	713	520000.0
8897159463151	C002	46272144867567	714	520000.0
8897159463151	C002	46272144867567	713	520000.0
7975350173935	C005	43713129316591	815	580000.0
8196122083567	C003	44245043609839	551	650000.0
8269638762735	C001	44482877161711	695	725000.0
8269638762735	C001	44482877161711	694	725000.0
8269638762735	C001	44482877194479	695	725000.0
8269638762735	C001	44482877194479	694	725000.0
8006371049711	C002	43793315889391	840	350000.0
7471328526575	C003	42146314846447	192	625000.0
8751873523951	C005	45808030187759	95	675000.0
8751873523951	C005	45808030187759	94	675000.0
8751873523951	C005	45808030187759	93	675000.0
8751873523951	C005	45808030220527	95	675000.0
8751873523951	C005	45808030220527	94	675000.0
8751873523951	C005	45808030220527	93	675000.0
8751873523951	C005	45808030253295	95	675000.0
8751873523951	C005	45808030253295	94	675000.0
8751873523951	C005	45808030253295	93	675000.0
8986641989871	C002	46549383545071	553	685000.0
8986641989871	C002	46549383545071	552	685000.0
8986641989871	C002	46549384265967	553	685000.0
8986641989871	C002	46549384265967	552	685000.0
9000412872943	C002	46573483655407	679	775000.0
8269648298223	C003	44482898526447	526	585000.0
8329446097135	C002	44659880853743	522	625000.0
8329446097135	C002	44659880853743	521	625000.0
8329446097135	C002	44659933479151	522	625000.0
8329446097135	C002	44659933479151	521	625000.0
8913534157039	C005	46317324533999	216	685000.0
8913534157039	C005	46317324533999	215	685000.0
8913534157039	C005	46317324533999	214	685000.0
8913534157039	C005	46317324566767	216	685000.0
8913534157039	C005	46317324566767	215	685000.0
8913534157039	C005	46317324566767	214	685000.0
8913534157039	C005	46317324599535	216	685000.0
8913534157039	C005	46317324599535	215	685000.0
8913534157039	C005	46317324599535	214	685000.0
8860251521263	C002	46170725122287	455	725000.0
8860251521263	C002	46170725122287	454	725000.0
8860251521263	C002	46170725155055	455	725000.0
8860251521263	C002	46170725155055	454	725000.0
8110077575407	C002	44062104748271	363	625000.0
8110077575407	C002	44062104748271	362	625000.0
8110077575407	C002	44062104748271	361	625000.0
8110077575407	C002	44062158979311	363	625000.0
8110077575407	C002	44062158979311	362	625000.0
8110077575407	C002	44062158979311	361	625000.0
8110077575407	C002	44062159012079	363	625000.0
8110077575407	C002	44062159012079	362	625000.0
8110077575407	C002	44062159012079	361	625000.0
8742172721391	C002	45773890388207	584	454750.0
8742172721391	C002	45773890388207	583	454750.0
8742172721391	C002	45773890420975	584	454750.0
8742172721391	C002	45773890420975	583	454750.0
8211516424431	C002	44289505362159	628	675000.0
8959790022895	C001	46458542686447	252	1350000.0
8959790022895	C001	46458542686447	251	1350000.0
8959790022895	C001	46458543374575	252	1350000.0
8959790022895	C001	46458543374575	251	1350000.0
8604127068399	C002	45328162849007	517	495000.0
8604127068399	C002	45328162849007	516	495000.0
8604127068399	C002	45328162849007	515	495000.0
8604127068399	C002	45328162849007	514	495000.0
8604127068399	C002	45328162881775	517	495000.0
8604127068399	C002	45328162881775	516	495000.0
8604127068399	C002	45328162881775	515	495000.0
8604127068399	C002	45328162881775	514	495000.0
8604127068399	C002	45328198893807	517	495000.0
8604127068399	C002	45328198893807	516	495000.0
8604127068399	C002	45328198893807	515	495000.0
8604127068399	C002	45328198893807	514	495000.0
8604127068399	C002	45328198926575	517	495000.0
8604127068399	C002	45328198926575	516	495000.0
8604127068399	C002	45328198926575	515	495000.0
8604127068399	C002	45328198926575	514	495000.0
7739069858031	C002	43037134520559	680	700000.0
8947908444399	C002	46414058029295	636	525000.0
8824632770799	C005	46062004502767	409	750000.0
8824632770799	C005	46062004502767	408	750000.0
8824632770799	C005	46062004502767	407	750000.0
8824632770799	C005	46062004535535	409	750000.0
8824632770799	C005	46062004535535	408	750000.0
8824632770799	C005	46062004535535	407	750000.0
8824632770799	C005	46062004568303	409	750000.0
8824632770799	C005	46062004568303	408	750000.0
8824632770799	C005	46062004568303	407	750000.0
9024411500783	C002	46662826393839	87	590000.0
9024411500783	C002	46662826393839	86	590000.0
9024411500783	C002	46667929616623	87	590000.0
9024411500783	C002	46667929616623	86	590000.0
9024411500783	C002	46671901917423	87	590000.0
9024411500783	C002	46671901917423	86	590000.0
9024411500783	C002	46662826426607	87	590000.0
9024411500783	C002	46662826426607	86	590000.0
9024411500783	C002	46667929649391	87	590000.0
9024411500783	C002	46667929649391	86	590000.0
9024411500783	C002	46671901950191	87	590000.0
9024411500783	C002	46671901950191	86	590000.0
7696638836975	C005	42922250240239	644	650000.0
7696638836975	C005	42935590027503	644	650000.0
8913631740143	C005	46317586022639	474	416500.0
8913631740143	C005	46317586022639	473	416500.0
8913631740143	C005	46317586022639	472	416500.0
8913631740143	C005	46317586055407	474	416500.0
8913631740143	C005	46317586055407	473	416500.0
8913631740143	C005	46317586055407	472	416500.0
8913631740143	C005	46317586088175	474	416500.0
8913631740143	C005	46317586088175	473	416500.0
8913631740143	C005	46317586088175	472	416500.0
8773339513071	C002	45890176221423	107	427500.0
8060725362927	C005	43953577787631	427	725000.0
8110107197679	C005	44062161666287	761	665000.0
8110107197679	C005	44062161666287	760	665000.0
8110107197679	C005	44062161666287	759	665000.0
8110107197679	C005	44062161699055	761	665000.0
8110107197679	C005	44062161699055	760	665000.0
8110107197679	C005	44062161699055	759	665000.0
8110107197679	C005	44062161731823	761	665000.0
8110107197679	C005	44062161731823	760	665000.0
8110107197679	C005	44062161731823	759	665000.0
7471319777519	C005	42155149721839	527	665000.0
7471319777519	C005	42155149754607	527	665000.0
8498622595311	C002	45077796323567	912	475000.0
8818183438575	C002	46043755610351	190	395000.0
7739081359599	C005	43037170991343	248	680000.0
8843352211695	C002	46124923257071	299	625000.0
7113857138866	C002	41247811272882	233	395000.0
8005223088367	C007	43790518878447	238	495000.0
8818177605871	C002	46043736015087	63	495000.0
8792602640623	C002	45972914438383	307	395000.0
8005165023471	C002	43790379286767	871	700000.0
8036455907567	C002	43893891793135	618	409500.0
8792586879215	C001	45972820001007	122	700000.0
8896416710895	C002	46270330011887	789	500000.0
8252003090671	C002	44426219094255	352	1500000.0
8252003090671	C002	44426228302063	352	1500000.0
7455674138863	C006	42090594173167	42	665000.0
8947907100911	C002	46414054457583	129	525000.0
7455655362799	C005	42090553573615	165	650000.0
8060715663599	C005	43953557733615	781	725000.0
8218799669487	C005	44304933290223	753	506250.0
8218799669487	C005	44304933290223	752	506250.0
8218799669487	C005	44304933290223	751	506250.0
8218799669487	C005	44304933322991	753	506250.0
8218799669487	C005	44304933322991	752	506250.0
8218799669487	C005	44304933322991	751	506250.0
8218799669487	C005	44304933355759	753	506250.0
8218799669487	C005	44304933355759	752	506250.0
8218799669487	C005	44304933355759	751	506250.0
8773366907119	C001	45890230255855	559	405000.0
8196086137071	C005	44244770029807	875	590000.0
8196086137071	C005	44244770029807	874	590000.0
8196086137071	C005	44244770029807	873	590000.0
8196086137071	C005	44244770029807	872	590000.0
8196086137071	C005	44244770062575	875	590000.0
8196086137071	C005	44244770062575	874	590000.0
8196086137071	C005	44244770062575	873	590000.0
8196086137071	C005	44244770062575	872	590000.0
8196086137071	C005	44244770095343	875	590000.0
8196086137071	C005	44244770095343	874	590000.0
8196086137071	C005	44244770095343	873	590000.0
8196086137071	C005	44244770095343	872	590000.0
8196086137071	C005	44244770128111	875	590000.0
8196086137071	C005	44244770128111	874	590000.0
8196086137071	C005	44244770128111	873	590000.0
8196086137071	C005	44244770128111	872	590000.0
7833922961647	C005	43312083075311	124	665000.0
7833922961647	C005	43312083108079	124	665000.0
9024321257711	C002	46662590693615	822	650000.0
9024321257711	C002	46662590693615	821	650000.0
9024321257711	C002	46662590693615	820	650000.0
9024321257711	C002	46662592790767	822	650000.0
9024321257711	C002	46662592790767	821	650000.0
9024321257711	C002	46662592790767	820	650000.0
9024321257711	C002	46662592823535	822	650000.0
9024321257711	C002	46662592823535	821	650000.0
9024321257711	C002	46662592823535	820	650000.0
8005185241327	C002	43790415724783	639	505750.0
7696634478831	C002	42922230481135	128	500000.0
9001313435887	C003	46576970793199	381	600000.0
8843351294191	C002	46124922241263	807	625000.0
8913104109807	C005	46315625054447	938	445500.0
8913104109807	C005	46315625054447	937	445500.0
8913104109807	C005	46315625087215	938	445500.0
8913104109807	C005	46315625087215	937	445500.0
7946279420143	C003	43642673758447	433	625000.0
7823875801327	C003	43281612112111	794	750000.0
8824999379183	C002	46063378497775	133	650000.0
8498263556335	C005	45075608273135	771	650000.0
8498263556335	C005	45075608273135	770	650000.0
8498263556335	C005	45075608273135	769	650000.0
8498263556335	C005	45075608305903	771	650000.0
8498263556335	C005	45075608305903	770	650000.0
8498263556335	C005	45075608305903	769	650000.0
8498263556335	C005	45075608338671	771	650000.0
8498263556335	C005	45075608338671	770	650000.0
8498263556335	C005	45075608338671	769	650000.0
8081686429935	C002	44001037910255	209	725000.0
8252028420335	C003	44426283909359	812	780000.0
8060711141615	C002	43953551671535	535	525000.0
8060711141615	C002	43953551671535	534	525000.0
8060711141615	C002	43953551704303	535	525000.0
8060711141615	C002	43953551704303	534	525000.0
8959789039855	C001	46458540916975	843	612000.0
7946287939823	C001	43642686472431	67	675000.0
7455669780719	C006	42090587619567	15	665000.0
7947525685487	C001	43645548265711	364	575000.0
7947446321391	C005	43645303029999	58	135000.0
8947900711151	C002	46414044004591	466	750000.0
8947900711151	C002	46414044004591	465	750000.0
8947900711151	C002	46414044037359	466	750000.0
8947900711151	C002	46414044037359	465	750000.0
8145558438127	C002	44137218965743	311	475000.0
7946285646063	C002	43642682310895	661	575000.0
8824629395695	C005	46061996966127	412	750000.0
8824629395695	C005	46061996966127	411	750000.0
8824629395695	C005	46061996966127	410	750000.0
8824629395695	C005	46061996998895	412	750000.0
8824629395695	C005	46061996998895	411	750000.0
8824629395695	C005	46061996998895	410	750000.0
8824629395695	C005	46061997031663	412	750000.0
8824629395695	C005	46061997031663	411	750000.0
8824629395695	C005	46061997031663	410	750000.0
8986676429039	C003	46549495087343	705	650000.0
8959261671663	C002	46456161665263	765	652500.0
8060442214639	C002	43952938713327	802	700000.0
8196075585775	C002	44244685816047	344	285000.0
8196075585775	C002	44244685816047	343	285000.0
8196075585775	C002	44244685816047	342	285000.0
8196075585775	C002	44244686373103	344	285000.0
8196075585775	C002	44244686373103	343	285000.0
8196075585775	C002	44244686373103	342	285000.0
8196075585775	C002	44244686405871	344	285000.0
8196075585775	C002	44244686405871	343	285000.0
8196075585775	C002	44244686405871	342	285000.0
8913076879599	C002	46315524882671	179	625500.0
8913076879599	C002	46315524882671	178	625500.0
8913076879599	C002	46315524882671	177	625500.0
8913076879599	C002	46315531469039	179	625500.0
8913076879599	C002	46315531469039	178	625500.0
8913076879599	C002	46315531469039	177	625500.0
8913076879599	C002	46315531501807	179	625500.0
8913076879599	C002	46315531501807	178	625500.0
8913076879599	C002	46315531501807	177	625500.0
8198588858607	C003	44253635543279	59	700000.0
8667287453935	C002	45533410099439	902	467500.0
8667287453935	C002	45533410099439	901	467500.0
8667287453935	C002	45533410099439	900	467500.0
8667287453935	C002	45533410132207	902	467500.0
8667287453935	C002	45533410132207	901	467500.0
8667287453935	C002	45533410132207	900	467500.0
8667287453935	C002	45533410164975	902	467500.0
8667287453935	C002	45533410164975	901	467500.0
8667287453935	C002	45533410164975	900	467500.0
8842758521071	C003	46121927082223	399	342500.0
7867716829423	C003	43444235698415	322	562500.0
8498614468847	C001	45077762539759	447	650000.0
7947445043439	C002	43645301752047	451	600000.0
8913528520943	C001	46317316374767	906	585000.0
7950403731695	C003	43651978100975	21	650000.0
7950403731695	C003	43651978100975	20	650000.0
7950403731695	C003	43651978133743	21	650000.0
7950403731695	C003	43651978133743	20	650000.0
8145580327151	C002	44137264546031	319	495000.0
8145580327151	C002	44137264546031	318	495000.0
8145580327151	C002	44137287254255	319	495000.0
8145580327151	C002	44137287254255	318	495000.0
7696639983855	C002	42922251419887	434	350000.0
7767167729903	C002	43121225695471	924	525000.0
7767167729903	C002	43121235755247	924	525000.0
9024412516591	C005	46662831505647	219	685000.0
9024412516591	C005	46662831505647	218	685000.0
9024412516591	C005	46662831505647	217	685000.0
9024412516591	C005	46668101419247	219	685000.0
9024412516591	C005	46668101419247	218	685000.0
9024412516591	C005	46668101419247	217	685000.0
9024412516591	C005	46671902343407	219	685000.0
9024412516591	C005	46671902343407	218	685000.0
9024412516591	C005	46671902343407	217	685000.0
9024412516591	C005	46662831538415	219	685000.0
9024412516591	C005	46662831538415	218	685000.0
9024412516591	C005	46662831538415	217	685000.0
9024412516591	C005	46668101452015	219	685000.0
9024412516591	C005	46668101452015	218	685000.0
9024412516591	C005	46668101452015	217	685000.0
9024412516591	C005	46671902376175	219	685000.0
9024412516591	C005	46671902376175	218	685000.0
9024412516591	C005	46671902376175	217	685000.0
9024412516591	C005	46662831571183	219	685000.0
9024412516591	C005	46662831571183	218	685000.0
9024412516591	C005	46662831571183	217	685000.0
9024412516591	C005	46668101484783	219	685000.0
9024412516591	C005	46668101484783	218	685000.0
9024412516591	C005	46668101484783	217	685000.0
9024412516591	C005	46671902408943	219	685000.0
9024412516591	C005	46671902408943	218	685000.0
9024412516591	C005	46671902408943	217	685000.0
8818180620527	C002	46043749646575	120	396000.0
7946306158831	C002	43642721632495	439	525000.0
8818175770863	C002	46043720515823	859	445500.0
8030804115695	C002	43877985779951	638	475000.0
8823420420335	C002	46059349999855	142	675000.0
8823420420335	C002	46059349999855	141	675000.0
8823420420335	C002	46059349999855	140	675000.0
8823420420335	C002	46059350032623	142	675000.0
8823420420335	C002	46059350032623	141	675000.0
8823420420335	C002	46059350032623	140	675000.0
8823420420335	C002	46059350360303	142	675000.0
8823420420335	C002	46059350360303	141	675000.0
8823420420335	C002	46059350360303	140	675000.0
8843362861295	C005	46124947013871	115	416500.0
8843362861295	C005	46124947013871	114	416500.0
8843362861295	C005	46124947013871	113	416500.0
8843362861295	C005	46124947046639	115	416500.0
8843362861295	C005	46124947046639	114	416500.0
8843362861295	C005	46124947046639	113	416500.0
8843362861295	C005	46124947079407	115	416500.0
8843362861295	C005	46124947079407	114	416500.0
8843362861295	C005	46124947079407	113	416500.0
7823908372719	C002	43281812193519	138	575000.0
8913091494127	C005	46315569840367	543	475000.0
8913091494127	C005	46315569840367	542	475000.0
8913091494127	C005	46315569873135	543	475000.0
8913091494127	C005	46315569873135	542	475000.0
8106582376687	C003	44055854481647	602	650000.0
7823893364975	C003	43281723523311	164	495000.0
7823893364975	C003	43281796595951	164	495000.0
8664908923119	C005	45526578823407	806	550000.0
8664908923119	C005	45526578823407	805	550000.0
8664908923119	C005	45526578823407	804	550000.0
8664908923119	C005	45526578856175	806	550000.0
8664908923119	C005	45526578856175	805	550000.0
8664908923119	C005	45526578856175	804	550000.0
8664908923119	C005	45526614376687	806	550000.0
8664908923119	C005	45526614376687	805	550000.0
8664908923119	C005	45526614376687	804	550000.0
8897272807663	C002	46272509935855	711	380000.0
8005286330607	C002	43790722597103	403	750000.0
8005164826863	C001	43790378860783	660	540000.0
8005164826863	C001	43790378860783	659	540000.0
8005164826863	C001	43790378893551	660	540000.0
8005164826863	C001	43790378893551	659	540000.0
8081694392559	C002	44001053016303	836	625000.0
8329474244847	C002	44660162232559	654	399000.0
8329474244847	C002	44660162232559	653	399000.0
8329474244847	C002	44660181270767	654	399000.0
8329474244847	C002	44660181270767	653	399000.0
8818183930095	C002	46043756527855	561	395000.0
9000450130159	C005	46573632356591	390	685000.0
9000450130159	C005	46573632356591	389	685000.0
9000450130159	C005	46573632356591	388	685000.0
9000450130159	C005	46573632389359	390	685000.0
9000450130159	C005	46573632389359	389	685000.0
9000450130159	C005	46573632389359	388	685000.0
9000450130159	C005	46573632422127	390	685000.0
9000450130159	C005	46573632422127	389	685000.0
9000450130159	C005	46573632422127	388	685000.0
8984622891247	C003	46544753918191	550	607500.0
8234756931823	C002	44354898723055	168	696500.0
8294592512239	C002	44553776136431	250	525000.0
8114155389167	C005	44069827150063	507	710100.0
8114155389167	C005	44069827150063	506	710100.0
8114155389167	C005	44069827150063	505	710100.0
8114155389167	C005	44069827215599	507	710100.0
8114155389167	C005	44069827215599	506	710100.0
8114155389167	C005	44069827215599	505	710100.0
8114155389167	C005	44069827248367	507	710100.0
8114155389167	C005	44069827248367	506	710100.0
8114155389167	C005	44069827248367	505	710100.0
8860227698927	C002	46170684326127	697	675000.0
8860227698927	C002	46170684326127	696	675000.0
8860227698927	C002	46170684358895	697	675000.0
8860227698927	C002	46170684358895	696	675000.0
8030781243631	C002	43877937348847	232	850000.0
8030781243631	C002	43877937348847	231	850000.0
8030781243631	C002	43877937348847	230	850000.0
8030781243631	C002	43877961302255	232	850000.0
8030781243631	C002	43877961302255	231	850000.0
8030781243631	C002	43877961302255	230	850000.0
8030781243631	C002	43877961335023	232	850000.0
8030781243631	C002	43877961335023	231	850000.0
8030781243631	C002	43877961335023	230	850000.0
9024432341231	C002	46662900941039	346	350000.0
8082171101423	C005	44002289090799	441	595000.0
8082171101423	C005	44002289090799	440	595000.0
8082171101423	C005	44002289123567	441	595000.0
8082171101423	C005	44002289123567	440	595000.0
8145133732079	C003	44136345862383	721	700000.0
7455679119599	C001	42090605773039	800	600000.0
8843349459183	C003	46124916932847	664	675000.0
8860261515503	C003	46170734493935	652	650000.0
8110097236207	C002	44062136074479	706	650000.0
7946306486511	C002	43642722648303	547	525000.0
8304600350959	C003	44590646264047	635	615000.0
7696629530863	C003	42922213474543	445	625000.0
7833926992111	C001	43312090710255	280	600000.0
8843346510063	C003	46124908118255	780	675000.0
8959790874863	C005	46458544390383	850	616500.0
8959790874863	C005	46458544390383	849	616500.0
8959790874863	C005	46458544390383	848	616500.0
8959790874863	C005	46458544423151	850	616500.0
8959790874863	C005	46458544423151	849	616500.0
8959790874863	C005	46458544423151	848	616500.0
8959790874863	C005	46458544455919	850	616500.0
8959790874863	C005	46458544455919	849	616500.0
8959790874863	C005	46458544455919	848	616500.0
7954349326575	C002	43659883282671	560	675000.0
9024432537839	C001	46662901530863	191	785000.0
8082187976943	C003	44002330312943	422	625000.0
8082187976943	C003	44002330312943	421	625000.0
8082187976943	C003	44002330345711	422	625000.0
8082187976943	C003	44002330345711	421	625000.0
8742027264239	C001	45773425475823	726	685000.0
8742027264239	C001	45773425475823	725	685000.0
8742027264239	C001	45773425508591	726	685000.0
8742027264239	C001	45773425508591	725	685000.0
8842741317871	C002	46121854337263	44	475000.0
8842741317871	C002	46121854337263	43	475000.0
8842741317871	C002	46121854370031	44	475000.0
8842741317871	C002	46121854370031	43	475000.0
8211469664495	C003	44289271988463	135	455000.0
8218797605103	C005	44304914317551	608	675000.0
8218797605103	C005	44304914317551	607	675000.0
8218797605103	C005	44304914317551	606	675000.0
8218797605103	C005	44304914350319	608	675000.0
8218797605103	C005	44304914350319	607	675000.0
8218797605103	C005	44304914350319	606	675000.0
8218797605103	C005	44304921690351	608	675000.0
8218797605103	C005	44304921690351	607	675000.0
8218797605103	C005	44304921690351	606	675000.0
9000453538031	C002	46573646446831	398	495000.0
9000453538031	C002	46573646446831	397	495000.0
9000453538031	C002	46573646479599	398	495000.0
9000453538031	C002	46573646479599	397	495000.0
8196294607087	C003	44246507454703	288	455000.0
8792602018031	C002	45972909293807	866	395000.0
8818185371887	C002	46043759411439	868	395000.0
8791849566447	C003	45968706109679	180	900000.0
9024397902063	C002	46662790906095	882	625000.0
9024397902063	C002	46662790906095	881	625000.0
9024397902063	C002	46662790906095	880	625000.0
9024397902063	C002	46662790938863	882	625000.0
9024397902063	C002	46662790938863	881	625000.0
9024397902063	C002	46662790938863	880	625000.0
9024397902063	C002	46662793560303	882	625000.0
9024397902063	C002	46662793560303	881	625000.0
9024397902063	C002	46662793560303	880	625000.0
8751920742639	C002	45808190062831	596	495000.0
8751920742639	C002	45808190062831	595	495000.0
8751920742639	C002	45808190095599	596	495000.0
8751920742639	C002	45808190095599	595	495000.0
9001309339887	C003	46576965943535	917	600000.0
8083253723375	C002	44005416763631	914	600000.0
8117392638191	C002	44076544721135	826	750000.0
9024434340079	C001	46662929907951	151	785000.0
8901383880943	C005	46407911571695	5	631200.0
8901383880943	C005	46407911571695	4	631200.0
8901383880943	C005	46407911571695	3	631200.0
8901383880943	C005	46282980032751	5	631200.0
8901383880943	C005	46282980032751	4	631200.0
8901383880943	C005	46282980032751	3	631200.0
8901383880943	C005	46282980065519	5	631200.0
8901383880943	C005	46282980065519	4	631200.0
8901383880943	C005	46282980065519	3	631200.0
8897118044399	C005	46272079429871	830	685000.0
8897118044399	C005	46272079429871	829	685000.0
8897118044399	C005	46272079429871	828	685000.0
8897118044399	C005	46272079462639	830	685000.0
8897118044399	C005	46272079462639	829	685000.0
8897118044399	C005	46272079462639	828	685000.0
8897118044399	C005	46272079495407	830	685000.0
8897118044399	C005	46272079495407	829	685000.0
8897118044399	C005	46272079495407	828	685000.0
8030789697775	C002	43877952225519	568	850000.0
8030789697775	C002	43877952225519	567	850000.0
8030789697775	C002	43877952225519	566	850000.0
8030789697775	C002	43877960646895	568	850000.0
8030789697775	C002	43877960646895	567	850000.0
8030789697775	C002	43877960646895	566	850000.0
8030789697775	C002	43877960679663	568	850000.0
8030789697775	C002	43877960679663	567	850000.0
8030789697775	C002	43877960679663	566	850000.0
7946298622191	C005	43642702856431	549	522000.0
8843359682799	C005	46124940001519	287	595000.0
8843359682799	C005	46124940001519	286	595000.0
8843359682799	C005	46124940001519	285	595000.0
8843359682799	C005	46124940034287	287	595000.0
8843359682799	C005	46124940034287	286	595000.0
8843359682799	C005	46124940034287	285	595000.0
8843359682799	C005	46124944916719	287	595000.0
8843359682799	C005	46124944916719	286	595000.0
8843359682799	C005	46124944916719	285	595000.0
8030790746351	C005	43877955272943	376	789000.0
8030790746351	C005	43877955272943	375	789000.0
8030790746351	C005	43877955272943	374	789000.0
8030790746351	C005	43877955272943	373	789000.0
8030790746351	C005	43877955338479	376	789000.0
8030790746351	C005	43877955338479	375	789000.0
8030790746351	C005	43877955338479	374	789000.0
8030790746351	C005	43877955338479	373	789000.0
8030790746351	C005	43877958189295	376	789000.0
8030790746351	C005	43877958189295	375	789000.0
8030790746351	C005	43877958189295	374	789000.0
8030790746351	C005	43877958189295	373	789000.0
8030790746351	C005	43970321514735	376	789000.0
8030790746351	C005	43970321514735	375	789000.0
8030790746351	C005	43970321514735	374	789000.0
8030790746351	C005	43970321514735	373	789000.0
8158407131375	C002	44162903703791	842	600000.0
8158407131375	C002	44162903703791	841	600000.0
8158407131375	C002	44162903736559	842	600000.0
8158407131375	C002	44162903736559	841	600000.0
8145602543855	C003	44137321791727	221	495000.0
8145602543855	C003	44137321791727	220	495000.0
8145602543855	C003	44137321824495	221	495000.0
8145602543855	C003	44137321824495	220	495000.0
7113846784178	C005	41247752519858	887	450000.0
8030801264879	C002	43877980340463	156	725000.0
8083256148207	C002	44005419679983	810	600000.0
8823412785391	C003	46059334402287	814	1750000.0
8329452749039	C005	44659943375087	77	675000.0
8329452749039	C005	44659943375087	76	675000.0
8329452749039	C005	44659943375087	75	675000.0
8329452749039	C005	44659943407855	77	675000.0
8329452749039	C005	44659943407855	76	675000.0
8329452749039	C005	44659943407855	75	675000.0
8329452749039	C005	44659943440623	77	675000.0
8329452749039	C005	44659943440623	76	675000.0
8329452749039	C005	44659943440623	75	675000.0
8252047950063	C003	44426335060207	749	600000.0
7605186199791	C003	42611051561199	353	700000.0
8253784785135	C005	44433337024751	444	552300.0
8253784785135	C005	44433337024751	443	552300.0
8253784785135	C005	44433337024751	442	552300.0
8253784785135	C005	44433337057519	444	552300.0
8253784785135	C005	44433337057519	443	552300.0
8253784785135	C005	44433337057519	442	552300.0
8253784785135	C005	44433337090287	444	552300.0
8253784785135	C005	44433337090287	443	552300.0
8253784785135	C005	44433337090287	442	552300.0
8158401396975	C002	44162897215727	731	600000.0
8158401396975	C002	44162897215727	730	600000.0
8158401396975	C002	44162897248495	731	600000.0
8158401396975	C002	44162897248495	730	600000.0
8114155880687	C002	44069828886767	556	675000.0
8060379463919	C001	43952800792815	723	785000.0
8060379463919	C001	43952800792815	722	785000.0
8060379463919	C001	43952800825583	723	785000.0
8060379463919	C001	43952800825583	722	785000.0
8913121313007	C002	46315771724015	492	675000.0
8913520754927	C003	46317303955695	148	685000.0
8329471492335	C001	44660128645359	884	1500000.0
8220534472943	C005	44308600389871	563	550000.0
8220534472943	C005	44308600422639	563	550000.0
7823883698415	C002	43281665786095	227	600000.0
7833906741487	C002	43312032743663	741	450000.0
8211456950511	C002	44289211465967	205	525000.0
8211456950511	C002	44289211465967	204	525000.0
8211456950511	C002	44289220346095	205	525000.0
8211456950511	C002	44289220346095	204	525000.0
8253781967087	C005	44433326145775	573	552300.0
8253781967087	C005	44433326145775	572	552300.0
8253781967087	C005	44433326145775	571	552300.0
8253781967087	C005	44433326178543	573	552300.0
8253781967087	C005	44433326178543	572	552300.0
8253781967087	C005	44433326178543	571	552300.0
8253781967087	C005	44433326211311	573	552300.0
8253781967087	C005	44433326211311	572	552300.0
8253781967087	C005	44433326211311	571	552300.0
8082175328495	C001	44002293612783	648	675000.0
8082175328495	C001	44002293612783	647	675000.0
8082175328495	C001	44002293874927	648	675000.0
8082175328495	C001	44002293874927	647	675000.0
7455663685871	C005	42090563535087	513	650000.0
8824610586863	C001	46061916913903	283	800000.0
8824610586863	C001	46061916913903	282	800000.0
8824610586863	C001	46061916946671	283	800000.0
8824610586863	C001	46061916946671	282	800000.0
8604421816559	C009	45329246093551	640	595000.0
8897190887663	C002	46272200868079	744	450000.0
8959788941551	C003	46458540720367	867	600000.0
8664861278447	C002	45526476947695	99	695000.0
8664861278447	C002	45526476947695	98	695000.0
8664861278447	C002	45526535504111	99	695000.0
8664861278447	C002	45526535504111	98	695000.0
8860253061359	C002	46170726465775	687	750000.0
8860253061359	C002	46170726465775	686	750000.0
8860253061359	C002	46170726498543	687	750000.0
8860253061359	C002	46170726498543	686	750000.0
8329482731759	C006	44660243857647	509	435000.0
8329482731759	C006	44660243857647	508	435000.0
8329482731759	C006	44660243890415	509	435000.0
8329482731759	C006	44660243890415	508	435000.0
7946305274095	C001	43642719404271	378	337500.0
7471245328623	C002	42145605386479	831	550000.0
8145497325807	C002	44137104244975	295	575000.0
9000415723759	C003	46580046332143	471	525000.0
9024381223151	C002	46662745719023	501	650000.0
9024381223151	C002	46662745719023	500	650000.0
9024381223151	C002	46662745719023	499	650000.0
9024381223151	C002	46662745751791	501	650000.0
9024381223151	C002	46662745751791	500	650000.0
9024381223151	C002	46662745751791	499	650000.0
9024381223151	C002	46662745784559	501	650000.0
9024381223151	C002	46662745784559	500	650000.0
9024381223151	C002	46662745784559	499	650000.0
8107687051503	C002	44058569212143	347	675000.0
7113830465714	C005	41247732007090	355	665000.0
8101851758831	C002	44044712968431	103	600000.0
8101851758831	C002	44044712968431	102	600000.0
8101851758831	C002	44044713001199	103	600000.0
8101851758831	C002	44044713001199	102	600000.0
8196079255791	C002	44244692599023	66	285000.0
8196079255791	C002	44244692599023	65	285000.0
8196079255791	C002	44244692599023	64	285000.0
8196079255791	C002	44244694204655	66	285000.0
8196079255791	C002	44244694204655	65	285000.0
8196079255791	C002	44244694204655	64	285000.0
8196079255791	C002	44244694237423	66	285000.0
8196079255791	C002	44244694237423	65	285000.0
8196079255791	C002	44244694237423	64	285000.0
8959278416111	C002	46456198922479	225	585000.0
8959278416111	C002	46456198922479	224	585000.0
8959278416111	C002	46456198955247	225	585000.0
8959278416111	C002	46456198955247	224	585000.0
8295198327023	C002	44556083396847	663	420000.0
8295198327023	C002	44556083396847	662	420000.0
8295198327023	C002	45413479448815	663	420000.0
8295198327023	C002	45413479448815	662	420000.0
8897200947439	C002	46272211714287	754	450000.0
8959791071471	C006	46458544881903	294	625500.0
8959791071471	C006	46458544881903	293	625500.0
8959791071471	C006	46458544914671	294	625500.0
8959791071471	C006	46458544914671	293	625500.0
8742181306607	C006	45773924237551	81	510000.0
8742181306607	C006	45773924237551	80	510000.0
8742181306607	C006	45773924270319	81	510000.0
8742181306607	C006	45773924270319	80	510000.0
7455634784495	C002	42090497442031	438	550000.0
8498246156527	C002	45075544047855	538	625000.0
8498246156527	C002	45075544047855	537	625000.0
8498246156527	C002	45075544047855	536	625000.0
8498246156527	C002	45075550601455	538	625000.0
8498246156527	C002	45075550601455	537	625000.0
8498246156527	C002	45075550601455	536	625000.0
8498246156527	C002	45075550634223	538	625000.0
8498246156527	C002	45075550634223	537	625000.0
8498246156527	C002	45075550634223	536	625000.0
9024393019631	C002	46662777143535	29	625000.0
9024393019631	C002	46662777143535	28	625000.0
9024393019631	C002	46662778650863	29	625000.0
9024393019631	C002	46662778650863	28	625000.0
8060442575087	C006	43952939204847	591	675000.0
8060442575087	C006	43952939204847	590	675000.0
8060442575087	C006	43952939237615	591	675000.0
8060442575087	C006	43952939237615	590	675000.0
8792600772847	C002	45972900020463	464	445500.0
8295196754159	C002	44556059574511	693	472500.0
8295196754159	C002	44556059574511	692	472500.0
8295196754159	C002	45413277565167	693	472500.0
8295196754159	C002	45413277565167	692	472500.0
7455707070703	C001	42090642309359	30	600000.0
8842742759663	C002	46121859088623	309	475000.0
8842742759663	C002	46121859088623	308	475000.0
8842742759663	C002	46121859121391	309	475000.0
8842742759663	C002	46121859121391	308	475000.0
8218785054959	C006	44304864805103	670	600000.0
8218785054959	C006	44304864805103	669	600000.0
8218785054959	C006	44304868704495	670	600000.0
8218785054959	C006	44304868704495	669	600000.0
8752243933423	C002	45808852271343	757	495000.0
8752243933423	C002	45808852271343	756	495000.0
8752243933423	C002	45808852304111	757	495000.0
8752243933423	C002	45808852304111	756	495000.0
8036433690863	C002	43893844213999	57	650000.0
7946301767919	C001	43642710622447	565	675000.0
7946301767919	C001	43642710622447	564	675000.0
7946301767919	C001	43642710655215	565	675000.0
7946301767919	C001	43642710655215	564	675000.0
8294588940527	C002	44553769943279	819	500000.0
7975351681263	C002	43713137901807	10	565000.0
8742223577327	C001	45774107640047	304	548500.0
8742223577327	C001	45774107640047	303	548500.0
8742223577327	C001	45774107640047	302	548500.0
8742223577327	C001	45774107672815	304	548500.0
8742223577327	C001	45774107672815	303	548500.0
8742223577327	C001	45774107672815	302	548500.0
8742223577327	C001	45774121107695	304	548500.0
8742223577327	C001	45774121107695	303	548500.0
8742223577327	C001	45774121107695	302	548500.0
8986672595183	C002	46549485125871	56	700000.0
8986672595183	C002	46549485125871	55	700000.0
8986672595183	C002	46549485125871	54	700000.0
8986672595183	C002	46549485158639	56	700000.0
8986672595183	C002	46549485158639	55	700000.0
8986672595183	C002	46549485158639	54	700000.0
8986672595183	C002	46549485191407	56	700000.0
8986672595183	C002	46549485191407	55	700000.0
8986672595183	C002	46549485191407	54	700000.0
8110093533423	C002	44062132601071	503	675000.0
7894084026607	C002	43514878132463	865	650000.0
7471330623727	C002	42146343125231	150	525000.0
8818184356079	C002	46043758199023	783	395000.0
8252030943471	C003	44426305569007	199	800000.0
7605183971567	C003	42611041501423	301	795000.0
8252026028271	C001	44426278568175	720	950000.0
8252026028271	C001	44426278568175	719	950000.0
8252026028271	C001	44426278600943	720	950000.0
8252026028271	C001	44426278600943	719	950000.0
9024430080239	C002	46662897041647	733	525000.0
9024430080239	C002	46662897041647	732	525000.0
9024430080239	C002	46662897074415	733	525000.0
9024430080239	C002	46662897074415	732	525000.0
8082170609903	C002	44002288697583	83	600000.0
7975352533231	C002	43713143374063	816	585000.0
8818180096239	C002	46043748106479	576	396000.0
8252041363695	C002	44426325852399	414	595000.0
8252041363695	C002	44426325852399	413	595000.0
8252041363695	C002	44426327064815	414	595000.0
8252041363695	C002	44426327064815	413	595000.0
8842747052271	C002	46121881305327	167	351000.0
8842747052271	C002	46121881305327	166	351000.0
8842747052271	C002	46121881338095	167	351000.0
8842747052271	C002	46121881338095	166	351000.0
7471421260015	C002	42146602221807	276	250000.0
7455591432431	C002	42090416373999	712	550000.0
7975353975023	C006	43713155596527	910	525000.0
7975353975023	C006	43714800156911	910	525000.0
9024401899759	C002	46662797623535	531	625000.0
9024401899759	C002	46662797623535	530	625000.0
9024401899759	C002	46662797623535	529	625000.0
9024401899759	C002	46662797656303	531	625000.0
9024401899759	C002	46662797656303	530	625000.0
9024401899759	C002	46662797656303	529	625000.0
9024401899759	C002	46662797689071	531	625000.0
9024401899759	C002	46662797689071	530	625000.0
9024401899759	C002	46662797689071	529	625000.0
8211420152047	C003	44289078493423	658	725000.0
8211420152047	C003	44289078493423	657	725000.0
8211420152047	C003	44289095663855	658	725000.0
8211420152047	C003	44289095663855	657	725000.0
8218779877615	C002	44304845013231	824	650000.0
8196081352943	C002	44244697612527	255	325000.0
8196081352943	C002	44244697612527	254	325000.0
8196081352943	C002	44244697612527	253	325000.0
8196081352943	C002	44557335167215	255	325000.0
8196081352943	C002	44557335167215	254	325000.0
8196081352943	C002	44557335167215	253	325000.0
8196081352943	C002	44557335199983	255	325000.0
8196081352943	C002	44557335199983	254	325000.0
8196081352943	C002	44557335199983	253	325000.0
8060710191343	C002	43953550655727	101	525000.0
8060710191343	C002	43953550655727	100	525000.0
8060710191343	C002	43953550688495	101	525000.0
8060710191343	C002	43953550688495	100	525000.0
8840010432751	C002	46113708441839	727	467500.0
8060729688303	C003	43953582866671	685	850000.0
8196097474799	C002	44244883079407	194	412500.0
8196097474799	C002	44244883079407	193	412500.0
8196097474799	C002	44244890616047	194	412500.0
8196097474799	C002	44244890616047	193	412500.0
9001307111663	C003	46576963715311	525	675000.0
8825017958639	C003	46063410512111	801	725000.0
8110093631727	C002	44062132699375	903	650000.0
7696632578287	C005	42922222256367	265	450000.0
8107692392687	C002	44058584023279	189	550000.0
9000432763119	C001	46573561839855	175	725000.0
9000432763119	C001	46573561839855	174	725000.0
9000432763119	C001	46573561872623	175	725000.0
9000432763119	C001	46573561872623	174	725000.0
7946305732847	C001	43642720190703	558	337500.0
7955609616623	C002	43664070476015	185	535500.0
8102668370159	C002	44046776664303	404	615000.0
8307535905007	C006	44597343617263	74	575000.0
8307535905007	C006	44597343617263	73	575000.0
8307535905007	C006	44597343617263	72	575000.0
8307535905007	C006	44597352235247	74	575000.0
8307535905007	C006	44597352235247	73	575000.0
8307535905007	C006	44597352235247	72	575000.0
8307535905007	C006	44597352268015	74	575000.0
8307535905007	C006	44597352268015	73	575000.0
8307535905007	C006	44597352268015	72	575000.0
8252042903791	C003	44426328015087	244	625000.0
8252042903791	C003	44426328015087	243	625000.0
8252042903791	C003	44426328047855	244	625000.0
8252042903791	C003	44426328047855	243	625000.0
8211261653231	C003	44288487555311	704	675000.0
8742191628527	C002	45773973913839	788	455000.0
8791912448239	C003	45969032315119	666	720000.0
8791912448239	C003	45969032315119	665	720000.0
8791912448239	C003	45969032347887	666	720000.0
8791912448239	C003	45969032347887	665	720000.0
7719008534767	C005	42990587052271	274	495000.0
8752246128879	C002	45808869441775	703	585000.0
8752246128879	C002	45808869441775	702	585000.0
8752246128879	C002	45808869441775	701	585000.0
8752246128879	C002	45808869474543	703	585000.0
8752246128879	C002	45808869474543	702	585000.0
8752246128879	C002	45808869474543	701	585000.0
8752246128879	C002	45808875798767	703	585000.0
8752246128879	C002	45808875798767	702	585000.0
8752246128879	C002	45808875798767	701	585000.0
8198584860911	C003	44253615816943	707	487500.0
8081704911087	C005	44001072480495	876	475000.0
7740223979759	C001	43039871500527	491	532000.0
8843359191279	C002	46124938559727	825	675000.0
8117368979695	C002	44076517949679	888	625000.0
8005193531631	C005	43790431813871	121	493000.0
8196115693807	C003	44245012840687	609	390000.0
8773322178799	C005	45890125463791	855	590750.0
8773322178799	C005	45890125463791	854	590750.0
8773322178799	C005	45890125463791	853	590750.0
8773322178799	C005	45890125496559	855	590750.0
8773322178799	C005	45890125496559	854	590750.0
8773322178799	C005	45890125496559	853	590750.0
8773322178799	C005	45890132345071	855	590750.0
8773322178799	C005	45890132345071	854	590750.0
8773322178799	C005	45890132345071	853	590750.0
8294602703087	C002	44553789440239	320	500000.0
9024386564335	C005	46662759842031	53	665000.0
9024386564335	C005	46662759842031	52	665000.0
9024386564335	C005	46662759842031	51	665000.0
9024386564335	C005	46662759874799	53	665000.0
9024386564335	C005	46662759874799	52	665000.0
9024386564335	C005	46662759874799	51	665000.0
9024386564335	C005	46662759907567	53	665000.0
9024386564335	C005	46662759907567	52	665000.0
9024386564335	C005	46662759907567	51	665000.0
7946280599791	C005	43642674938095	49	665000.0
7946280599791	C005	43642674938095	48	665000.0
7946280599791	C005	43642674970863	49	665000.0
7946280599791	C005	43642674970863	48	665000.0
9024410321135	C002	46662824165615	646	590000.0
9024410321135	C002	46662824165615	645	590000.0
9024410321135	C002	46662824198383	646	590000.0
9024410321135	C002	46662824198383	645	590000.0
8897219920111	C002	46272231276783	143	450000.0
7605188755695	C002	42611064635631	582	500000.0
8081767465199	C002	44001177305327	748	600000.0
8081767465199	C002	44001177305327	747	600000.0
8081767465199	C002	44001177338095	748	600000.0
8081767465199	C002	44001177338095	747	600000.0
9000424341743	C003	46573525041391	823	950000.0
8901385748719	C003	46282984554735	158	650000.0
7823886057711	C003	43281680498927	779	500000.0
7823886057711	C003	43281788076271	779	500000.0
7739104919791	C001	43037239410927	918	665000.0
7823901360367	C002	43281765400815	742	485000.0
8211461472495	C002	44289229193455	708	475000.0
7719007650031	C005	42990585905391	520	495000.0
9000451834095	C002	46573640909039	575	495000.0
9000451834095	C002	46573640909039	574	495000.0
9000451834095	C002	46573644939503	575	495000.0
9000451834095	C002	46573644939503	574	495000.0
9000475689199	C002	46573746421999	203	495000.0
9000475689199	C002	46573746421999	202	495000.0
9000475689199	C002	46573746454767	203	495000.0
9000475689199	C002	46573746454767	202	495000.0
8843361583343	C005	46124943245551	341	595000.0
8843361583343	C005	46124943245551	340	595000.0
8843361583343	C005	46124943245551	339	595000.0
8843361583343	C005	46124943278319	341	595000.0
8843361583343	C005	46124943278319	340	595000.0
8843361583343	C005	46124943278319	339	595000.0
8843361583343	C005	46124944392431	341	595000.0
8843361583343	C005	46124944392431	340	595000.0
8843361583343	C005	46124944392431	339	595000.0
9000442331375	C005	46573605093615	486	685000.0
9000442331375	C005	46573605093615	485	685000.0
9000442331375	C005	46573605093615	484	685000.0
9000442331375	C005	46573605126383	486	685000.0
9000442331375	C005	46573605126383	485	685000.0
9000442331375	C005	46573605126383	484	685000.0
9000442331375	C005	46573605159151	486	685000.0
9000442331375	C005	46573605159151	485	685000.0
9000442331375	C005	46573605159151	484	685000.0
7110613631154	C002	41239140139186	317	550000.0
8101854544111	C002	44044715032815	763	600000.0
8101854544111	C002	44044715032815	762	600000.0
8101854544111	C002	44044715065583	763	600000.0
8101854544111	C002	44044715065583	762	600000.0
8773378048239	C001	45890249261295	144	337500.0
7975349747951	C002	43713125941487	312	297500.0
8824607637743	C005	46061909770479	417	600000.0
8824607637743	C005	46061909770479	416	600000.0
8824607637743	C005	46061909770479	415	600000.0
8824607637743	C005	46061909803247	417	600000.0
8824607637743	C005	46061909803247	416	600000.0
8824607637743	C005	46061909803247	415	600000.0
8824607637743	C005	46061909836015	417	600000.0
8824607637743	C005	46061909836015	416	600000.0
8824607637743	C005	46061909836015	415	600000.0
8307532562671	C002	44597337227503	589	1250000.0
8307532562671	C002	44597337227503	588	1250000.0
8307532562671	C002	44597337260271	589	1250000.0
8307532562671	C002	44597337260271	588	1250000.0
8792612241647	C002	45972971225327	939	395000.0
8218769981679	C003	44304808640751	813	696500.0
8792600543471	C002	45972896973039	750	247500.0
8005217485039	C007	43790494564591	450	495000.0
8842759536879	C003	46121929507055	519	675000.0
8840020263151	C001	46113723384047	671	1750000.0
8082175787247	C001	44002294104303	385	675000.0
8082175787247	C001	44002294104303	384	675000.0
8082175787247	C001	44002294137071	385	675000.0
8082175787247	C001	44002294137071	384	675000.0
8986619150575	C002	46549273247983	852	600000.0
8897119682799	C002	46272080511215	651	525000.0
8897119682799	C002	46272080511215	650	525000.0
8897119682799	C002	46272080543983	651	525000.0
8897119682799	C002	46272080543983	650	525000.0
7471339405551	C002	42146376286447	137	525000.0
8860255420655	C002	46170729054447	240	700000.0
8860255420655	C002	46170729054447	239	700000.0
8860255420655	C002	46170729087215	240	700000.0
8860255420655	C002	46170729087215	239	700000.0
7946302947567	C002	43642718519535	157	525000.0
8196252336367	C002	44246334898415	380	402500.0
8196252336367	C002	44246334898415	379	402500.0
8196252336367	C002	44246355542255	380	402500.0
8196252336367	C002	44246355542255	379	402500.0
8145302880495	C002	44136623341807	946	382250.0
8145302880495	C002	44136623341807	945	382250.0
8145302880495	C002	44136739340527	946	382250.0
8145302880495	C002	44136739340527	945	382250.0
7946298261743	C002	43642702725359	504	595000.0
7740271165679	C002	43040032293103	793	525000.0
8792597070063	C002	45972868038895	851	495000.0
7605183250671	C002	42611038224623	630	395000.0
7113856024754	C002	41247808815282	310	395000.0
8498266865903	C003	45075636617455	878	895000.0
7946289217775	C005	43642689126639	785	665000.0
7946289217775	C005	43642689126639	784	665000.0
7946289217775	C005	43642689159407	785	665000.0
7946289217775	C005	43642689159407	784	665000.0
8840007319791	C001	46113700053231	923	550000.0
8840007319791	C001	46113700053231	922	550000.0
8840007319791	C001	46317622100207	923	550000.0
8840007319791	C001	46317622100207	922	550000.0
8840007319791	C001	46317622132975	923	550000.0
8840007319791	C001	46317622132975	922	550000.0
8840007319791	C001	46317622165743	923	550000.0
8840007319791	C001	46317622165743	922	550000.0
8840007319791	C001	46317622198511	923	550000.0
8840007319791	C001	46317622198511	922	550000.0
8840007319791	C001	46317622231279	923	550000.0
8840007319791	C001	46317622231279	922	550000.0
8101884526831	C002	44044779978991	915	600000.0
8498254676207	C006	45075571474671	213	300000.0
8498254676207	C006	45075571474671	212	300000.0
8498254676207	C006	45075571474671	211	300000.0
8498254676207	C006	45075571507439	213	300000.0
8498254676207	C006	45075571507439	212	300000.0
8498254676207	C006	45075571507439	211	300000.0
8498254676207	C006	45075571540207	213	300000.0
8498254676207	C006	45075571540207	212	300000.0
8498254676207	C006	45075571540207	211	300000.0
8110077346031	C002	44062104584431	27	525000.0
8110077346031	C002	44062104584431	26	525000.0
8110077346031	C002	44062159438063	27	525000.0
8110077346031	C002	44062159438063	26	525000.0
8145477468399	C003	44137063055599	533	590750.0
8145477468399	C003	44137063055599	532	590750.0
8145477468399	C003	44137063121135	533	590750.0
8145477468399	C003	44137063121135	532	590750.0
7696637067503	C001	42922240082159	617	675000.0
8233619161327	C002	44352435519727	149	995000.0
7455718047983	C002	42090679697647	610	525000.0
8897161363695	C002	46272145653999	360	520000.0
8897161363695	C002	46272145653999	359	520000.0
8897161363695	C002	46272145686767	360	520000.0
8897161363695	C002	46272145686767	359	520000.0
8773349146863	C002	45890199650543	605	650000.0
8773349146863	C002	45890199650543	604	650000.0
8773349146863	C002	45890205941999	605	650000.0
8773349146863	C002	45890205941999	604	650000.0
8196265967855	C005	44246377070831	886	665000.0
8196265967855	C005	44246377070831	885	665000.0
8196265967855	C005	44246377103599	886	665000.0
8196265967855	C005	44246377103599	885	665000.0
9024408715503	C002	46662818529519	97	590000.0
9024408715503	C002	46662818529519	96	590000.0
9024408715503	C002	46667903795439	97	590000.0
9024408715503	C002	46667903795439	96	590000.0
9024408715503	C002	46671903457519	97	590000.0
9024408715503	C002	46671903457519	96	590000.0
9024408715503	C002	46662818562287	97	590000.0
9024408715503	C002	46662818562287	96	590000.0
9024408715503	C002	46667903828207	97	590000.0
9024408715503	C002	46667903828207	96	590000.0
9024408715503	C002	46671903490287	97	590000.0
9024408715503	C002	46671903490287	96	590000.0
8329462743279	C003	44660033716463	877	1080000.0
8329468575983	C001	44660092076271	22	1500000.0
8604404187375	C002	45329178263791	684	495000.0
8604404187375	C002	45329178263791	683	495000.0
8604404187375	C002	45329178263791	682	495000.0
8604404187375	C002	45329178263791	681	495000.0
8604404187375	C002	45329178296559	684	495000.0
8604404187375	C002	45329178296559	683	495000.0
8604404187375	C002	45329178296559	682	495000.0
8604404187375	C002	45329178296559	681	495000.0
8604404187375	C002	45329178329327	684	495000.0
8604404187375	C002	45329178329327	683	495000.0
8604404187375	C002	45329178329327	682	495000.0
8604404187375	C002	45329178329327	681	495000.0
8604404187375	C002	45329178362095	684	495000.0
8604404187375	C002	45329178362095	683	495000.0
8604404187375	C002	45329178362095	682	495000.0
8604404187375	C002	45329178362095	681	495000.0
8625230577903	C002	45413205999855	393	400000.0
8625230577903	C002	45413205999855	392	400000.0
8625230577903	C002	45413216059631	393	400000.0
8625230577903	C002	45413216059631	392	400000.0
8269578535151	C002	44482699231471	69	650000.0
8269578535151	C002	44482699231471	68	650000.0
8269578535151	C002	44482699264239	69	650000.0
8269578535151	C002	44482699264239	68	650000.0
8294597918959	C002	44553784230127	758	525000.0
8145570005231	C002	44137242886383	332	475000.0
8082189746415	C005	44002333884655	899	665000.0
8082189746415	C005	44002333884655	898	665000.0
8082189746415	C005	44002333884655	897	665000.0
8082189746415	C005	44002333917423	899	665000.0
8082189746415	C005	44002333917423	898	665000.0
8082189746415	C005	44002333917423	897	665000.0
8082189746415	C005	44002333950191	899	665000.0
8082189746415	C005	44002333950191	898	665000.0
8082189746415	C005	44002333950191	897	665000.0
8959266095343	C002	46456168349935	208	652500.0
8840005157103	C001	46113697169647	372	950000.0
9000418803951	C002	46581909291247	827	350000.0
7571084181743	C006	42496765690095	463	650000.0
7571084181743	C006	42496765722863	463	650000.0
8773299405039	C003	45890050818287	548	807500.0
8843364073711	C005	46124951273711	601	416500.0
8843364073711	C005	46124951273711	600	416500.0
8843364073711	C005	46124951273711	599	416500.0
8843364073711	C005	46124951306479	601	416500.0
8843364073711	C005	46124951306479	600	416500.0
8843364073711	C005	46124951306479	599	416500.0
8843364073711	C005	46124951339247	601	416500.0
8843364073711	C005	46124951339247	600	416500.0
8843364073711	C005	46124951339247	599	416500.0
7740224897263	C001	43039873859823	736	532000.0
8082188796143	C005	44002331295983	184	590000.0
8082188796143	C005	44002331295983	183	590000.0
8082188796143	C005	44002331295983	182	590000.0
8082188796143	C005	44002331295983	181	590000.0
8082188796143	C005	44002333589743	184	590000.0
8082188796143	C005	44002333589743	183	590000.0
8082188796143	C005	44002333589743	182	590000.0
8082188796143	C005	44002333589743	181	590000.0
8082188796143	C005	44002333622511	184	590000.0
8082188796143	C005	44002333622511	183	590000.0
8082188796143	C005	44002333622511	182	590000.0
8082188796143	C005	44002333622511	181	590000.0
8082188796143	C005	44002333655279	184	590000.0
8082188796143	C005	44002333655279	183	590000.0
8082188796143	C005	44002333655279	182	590000.0
8082188796143	C005	44002333655279	181	590000.0
7605207531759	C002	42611157532911	50	675000.0
8211517767919	C001	44289511063791	883	465000.0
8329436856559	C003	44659770917103	523	1200000.0
8897112965359	C002	46272038732015	546	560000.0
8897112965359	C002	46272038732015	545	560000.0
8897112965359	C002	46272038732015	544	560000.0
8897112965359	C002	46272038764783	546	560000.0
8897112965359	C002	46272038764783	545	560000.0
8897112965359	C002	46272038764783	544	560000.0
8897112965359	C002	46272065339631	546	560000.0
8897112965359	C002	46272065339631	545	560000.0
8897112965359	C002	46272065339631	544	560000.0
9000474640623	C002	46573744619759	787	495000.0
9000474640623	C002	46573744619759	786	495000.0
9000474640623	C002	46573744652527	787	495000.0
9000474640623	C002	46573744652527	786	495000.0
8307519521007	C002	44597303410927	621	675000.0
8791861231855	C003	45968766140655	470	720000.0
8791861231855	C003	45968766140655	469	720000.0
8791861231855	C003	45968782033135	470	720000.0
8791861231855	C003	45968782033135	469	720000.0
8913498046703	C002	46317215121647	358	562500.0
8913498046703	C002	46317215121647	357	562500.0
8913498046703	C002	46317215121647	356	562500.0
8913498046703	C002	46317215154415	358	562500.0
8913498046703	C002	46317215154415	357	562500.0
8913498046703	C002	46317215154415	356	562500.0
8913498046703	C002	46317232980207	358	562500.0
8913498046703	C002	46317232980207	357	562500.0
8913498046703	C002	46317232980207	356	562500.0
9000474935535	C002	46573745012975	71	495000.0
9000474935535	C002	46573745012975	70	495000.0
9000474935535	C002	46573745045743	71	495000.0
9000474935535	C002	46573745045743	70	495000.0
8823421108463	C002	46059350393071	291	675000.0
8823421108463	C002	46059350393071	290	675000.0
8823421108463	C002	46059350393071	289	675000.0
8823421108463	C002	46059350425839	291	675000.0
8823421108463	C002	46059350425839	290	675000.0
8823421108463	C002	46059350425839	289	675000.0
8823421108463	C002	46059350458607	291	675000.0
8823421108463	C002	46059350458607	290	675000.0
8823421108463	C002	46059350458607	289	675000.0
8625224155375	C002	45413144690927	773	500000.0
8625224155375	C002	45413144690927	772	500000.0
8625224155375	C002	45413184667887	773	500000.0
8625224155375	C002	45413184667887	772	500000.0
7946299474159	C001	43642705805551	402	700000.0
8196280549615	C001	44246442901743	755	399000.0
8982852108527	C003	46538310353135	700	585000.0
8218772832495	C003	44304814407919	19	675000.0
8005163122927	C005	43790368440559	624	675000.0
8005163122927	C005	43790368440559	623	675000.0
8005163122927	C005	43790368440559	622	675000.0
8005163122927	C005	43790368473327	624	675000.0
8005163122927	C005	43790368473327	623	675000.0
8005163122927	C005	43790368473327	622	675000.0
8005163122927	C005	46417287250159	624	675000.0
8005163122927	C005	46417287250159	623	675000.0
8005163122927	C005	46417287250159	622	675000.0
7455675351279	C006	42090596565231	629	665000.0
9024416547055	C002	46662847856879	668	700000.0
9024416547055	C002	46662847856879	667	700000.0
9024416547055	C002	46668069667055	668	700000.0
9024416547055	C002	46668069667055	667	700000.0
9024416547055	C002	46711398138095	668	700000.0
9024416547055	C002	46711398138095	667	700000.0
9024416547055	C002	46662847889647	668	700000.0
9024416547055	C002	46662847889647	667	700000.0
9024416547055	C002	46668069699823	668	700000.0
9024416547055	C002	46668069699823	667	700000.0
9024416547055	C002	46711398170863	668	700000.0
9024416547055	C002	46711398170863	667	700000.0
8498646155503	C003	45077894398191	490	800000.0
8498646155503	C003	45077894398191	489	800000.0
8498646155503	C003	45077915304175	490	800000.0
8498646155503	C003	45077915304175	489	800000.0
7471329968367	C003	42146335555823	555	625000.0
8211438960879	C002	44289151041775	724	645000.0
8860280324335	C005	46170771816687	949	685000.0
8860280324335	C005	46170771816687	948	685000.0
8860280324335	C005	46170771816687	947	685000.0
8860280324335	C005	46170771849455	949	685000.0
8860280324335	C005	46170771849455	948	685000.0
8860280324335	C005	46170771849455	947	685000.0
8860280324335	C005	46256060924143	949	685000.0
8860280324335	C005	46256060924143	948	685000.0
8860280324335	C005	46256060924143	947	685000.0
8145529307375	C002	44137158836463	365	550000.0
8825020252399	C003	46063414804719	437	725000.0
8860247261423	C002	46170718765295	127	725000.0
8860247261423	C002	46170718765295	126	725000.0
8860247261423	C002	46170721091823	127	725000.0
8860247261423	C002	46170721091823	126	725000.0
8860235137263	C002	46170704117999	916	725000.0
8211518947567	C001	44289515782383	879	465000.0
8196307550447	C003	44246570959087	394	455000.0
8791875551471	C005	45968835739887	613	357000.0
8791875551471	C005	45968835739887	612	357000.0
8791875551471	C005	45968844587247	613	357000.0
8791875551471	C005	45968844587247	612	357000.0
8060434252015	C002	43952922067183	116	595000.0
8294599164143	C002	44553786065135	249	525000.0
8307538493679	C006	44597356265711	371	575000.0
8307538493679	C006	44597356265711	370	575000.0
8307538493679	C006	44597356265711	369	575000.0
8307538493679	C006	44597356298479	371	575000.0
8307538493679	C006	44597356298479	370	575000.0
8307538493679	C006	44597356298479	369	575000.0
8307538493679	C006	44597356331247	371	575000.0
8307538493679	C006	44597356331247	370	575000.0
8307538493679	C006	44597356331247	369	575000.0
8986668531951	C002	46549471887599	942	700000.0
8986668531951	C002	46549471887599	941	700000.0
8986668531951	C002	46549471887599	940	700000.0
8986668531951	C002	46549471920367	942	700000.0
8986668531951	C002	46549471920367	941	700000.0
8986668531951	C002	46549471920367	940	700000.0
8986668531951	C002	46549471953135	942	700000.0
8986668531951	C002	46549471953135	941	700000.0
8986668531951	C002	46549471953135	940	700000.0
8742178029807	C002	45773911195887	453	454750.0
8742178029807	C002	45773911195887	452	454750.0
8742178029807	C002	45773911228655	453	454750.0
8742178029807	C002	45773911228655	452	454750.0
8604408971503	C010	45329205362927	109	215000.0
8604408971503	C010	45330210619631	109	215000.0
8030794580207	C001	43877962285295	929	775000.0
8060419571951	C003	43952853876975	117	595000.0
8860267315439	C002	46170742358255	478	585000.0
8860267315439	C002	46170742358255	477	585000.0
8860267315439	C002	46170763133167	478	585000.0
8860267315439	C002	46170763133167	477	585000.0
8860169437423	C002	46170621968623	187	675000.0
8860169437423	C002	46170621968623	186	675000.0
8860169437423	C002	46170631274735	187	675000.0
8860169437423	C002	46170631274735	186	675000.0
8825023037679	C002	46063416639727	890	650000.0
8825023037679	C002	46063416639727	889	650000.0
8825023037679	C002	46063424798959	890	650000.0
8825023037679	C002	46063424798959	889	650000.0
9024434798831	C005	46662934593775	14	600000.0
9024434798831	C005	46662934593775	13	600000.0
9024434798831	C005	46662934593775	12	600000.0
9024434798831	C005	46668188647663	14	600000.0
9024434798831	C005	46668188647663	13	600000.0
9024434798831	C005	46668188647663	12	600000.0
9024434798831	C005	46662934626543	14	600000.0
9024434798831	C005	46662934626543	13	600000.0
9024434798831	C005	46662934626543	12	600000.0
9024434798831	C005	46668188680431	14	600000.0
9024434798831	C005	46668188680431	13	600000.0
9024434798831	C005	46668188680431	12	600000.0
9024434798831	C005	46662934659311	14	600000.0
9024434798831	C005	46662934659311	13	600000.0
9024434798831	C005	46662934659311	12	600000.0
9024434798831	C005	46668188713199	14	600000.0
9024434798831	C005	46668188713199	13	600000.0
9024434798831	C005	46668188713199	12	600000.0
7637780922607	C006	42722217820399	195	600000.0
8947915292911	C002	46414069793007	690	427500.0
7946294001903	C002	43642697973999	740	287500.0
8006504284399	C002	43793546281199	921	585000.0
7790791557359	C001	43178766074095	406	665000.0
7571085983983	C006	42496776044783	78	650000.0
7571085983983	C006	42496776077551	78	650000.0
8604417097967	C010	45329231741167	446	215000.0
8604417097967	C010	45330218352879	446	215000.0
8823411376367	C003	46059333419247	510	1750000.0
8060731719919	C003	43953587912943	905	850000.0
8211473334511	C002	44289283948783	336	550000.0
8082186469615	C002	44002328019183	436	575000.0
9000475033839	C002	46573745209583	864	495000.0
9000475033839	C002	46573745209583	863	495000.0
9000475033839	C002	46573745242351	864	495000.0
9000475033839	C002	46573745242351	863	495000.0
9024429129967	C003	46662895763695	79	785000.0
9024429129967	C003	46668098437359	79	785000.0
9024429129967	C003	46671901229295	79	785000.0
8005292622063	C001	43790757495023	634	785000.0
8005292622063	C001	43790757495023	633	785000.0
8005292622063	C001	43795346784495	634	785000.0
8005292622063	C001	43795346784495	633	785000.0
8843357225199	C002	46124932464879	237	700000.0
8843357225199	C002	46124932464879	236	700000.0
8843357225199	C002	46124933939439	237	700000.0
8843357225199	C002	46124933939439	236	700000.0
7946294395119	C001	43642698268911	803	675000.0
7975350730991	C007	43713133183215	691	445500.0
8036433953007	C003	43893844345071	201	575000.0
8986659750127	C002	46549442003183	335	700000.0
8986659750127	C002	46549442003183	334	700000.0
8986659750127	C002	46549442003183	333	700000.0
8986659750127	C002	46549442035951	335	700000.0
8986659750127	C002	46549442035951	334	700000.0
8986659750127	C002	46549442035951	333	700000.0
8986659750127	C002	46549442461935	335	700000.0
8986659750127	C002	46549442461935	334	700000.0
8986659750127	C002	46549442461935	333	700000.0
8211467174127	C002	44289264222447	9	625000.0
8792594546927	C002	45972851359983	269	495000.0
8604419555567	C009	45329241309423	735	595000.0
8667288600815	C002	45533412851951	273	550000.0
8667288600815	C002	45533412851951	272	550000.0
8667288600815	C002	45533412851951	271	550000.0
8667288600815	C002	45533412917487	273	550000.0
8667288600815	C002	45533412917487	272	550000.0
8667288600815	C002	45533412917487	271	550000.0
8667288600815	C002	45533412950255	273	550000.0
8667288600815	C002	45533412950255	272	550000.0
8667288600815	C002	45533412950255	271	550000.0
8897139572975	C006	46272101613807	796	665000.0
8897139572975	C006	46272101613807	795	665000.0
8897139572975	C006	46272101646575	796	665000.0
8897139572975	C006	46272101646575	795	665000.0
8211432308975	C003	44289127874799	481	500000.0
8211432308975	C003	44289127874799	480	500000.0
8211432308975	C003	44289127907567	481	500000.0
8211432308975	C003	44289127907567	480	500000.0
8211451150575	C006	44289189740783	338	600000.0
8211451150575	C006	44289189740783	337	600000.0
8211451150575	C006	44289189773551	338	600000.0
8211451150575	C006	44289189773551	337	600000.0
8211451150575	C006	44289189806319	338	600000.0
8211451150575	C006	44289189806319	337	600000.0
8196303847663	C001	44246550151407	1	432250.0
8843365155055	C001	46124956713199	468	637500.0
8843365155055	C001	46124956713199	467	637500.0
8843365155055	C001	46124962578671	468	637500.0
8843365155055	C001	46124962578671	467	637500.0
7605187739887	C003	42611057918191	197	492750.0
8114153816303	C001	44069826167023	270	700000.0
8252043657455	C001	44426328408303	331	800000.0
8252043657455	C001	44426328408303	330	800000.0
8252043657455	C001	44426328408303	329	800000.0
8252043657455	C001	44426328441071	331	800000.0
8252043657455	C001	44426328441071	330	800000.0
8252043657455	C001	44426328441071	329	800000.0
8252043657455	C001	44426330210543	331	800000.0
8252043657455	C001	44426330210543	330	800000.0
8252043657455	C001	44426330210543	329	800000.0
8211400392943	C003	44288994083055	920	675000.0
8304619421935	C001	44590692761839	676	695000.0
8860229992687	C002	46170690617583	210	725000.0
7455707791599	C001	42090647355631	176	600000.0
8196136599791	C003	44245204238575	123	875000.0
8825005506799	C003	46063393341679	281	650000.0
8107680661743	C002	44058543587567	267	525000.0
8107680661743	C002	44058543587567	266	525000.0
8107680661743	C002	44062697128175	267	525000.0
8107680661743	C002	44062697128175	266	525000.0
8110077411567	C002	44062104617199	911	550000.0
8196237132015	C003	44246245081327	739	725000.0
8196237132015	C003	44246245081327	738	725000.0
8196237132015	C003	44246308323567	739	725000.0
8196237132015	C003	44246308323567	738	725000.0
8897163395311	C002	46272149094639	35	520000.0
8897163395311	C002	46272149094639	34	520000.0
8897163395311	C002	46272149127407	35	520000.0
8897163395311	C002	46272149127407	34	520000.0
8005296390383	C003	43790768865519	782	599000.0
8773307990255	C006	45890083946735	260	582500.0
8773307990255	C006	45890083946735	259	582500.0
8773307990255	C006	45890094465263	260	582500.0
8773307990255	C006	45890094465263	259	582500.0
8498232885487	C002	45075456721135	862	625000.0
8498232885487	C002	45075456721135	861	625000.0
8498232885487	C002	45075456721135	860	625000.0
8498232885487	C002	45075507216623	862	625000.0
8498232885487	C002	45075507216623	861	625000.0
8498232885487	C002	45075507216623	860	625000.0
8498232885487	C002	45075507249391	862	625000.0
8498232885487	C002	45075507249391	861	625000.0
8498232885487	C002	45075507249391	860	625000.0
8306798756079	C002	44596299694319	401	585000.0
8306798756079	C002	44596299694319	400	585000.0
8306798756079	C002	44596353007855	401	585000.0
8306798756079	C002	44596353007855	400	585000.0
8211495256303	C006	44289383530735	462	725000.0
8211495256303	C006	44289383530735	461	725000.0
8211495256303	C006	44289383530735	460	725000.0
8211495256303	C006	44289383563503	462	725000.0
8211495256303	C006	44289383563503	461	725000.0
8211495256303	C006	44289383563503	460	725000.0
8211495256303	C006	44289383596271	462	725000.0
8211495256303	C006	44289383596271	461	725000.0
8211495256303	C006	44289383596271	460	725000.0
8860267086063	C003	46170742128879	92	650000.0
8913521967343	C003	46317306020079	354	685000.0
8742218367215	C006	45774092894447	316	535000.0
8742218367215	C006	45774092894447	315	535000.0
8742218367215	C006	45774092894447	314	535000.0
8742218367215	C006	45774104101103	316	535000.0
8742218367215	C006	45774104101103	315	535000.0
8742218367215	C006	45774104101103	314	535000.0
8742218367215	C006	45774104133871	316	535000.0
8742218367215	C006	45774104133871	315	535000.0
8742218367215	C006	45774104133871	314	535000.0
8913633804527	C005	46317588873455	498	416500.0
8913633804527	C005	46317588873455	497	416500.0
8913633804527	C005	46317588873455	496	416500.0
8913633804527	C005	46317588906223	498	416500.0
8913633804527	C005	46317588906223	497	416500.0
8913633804527	C005	46317588906223	496	416500.0
8913633804527	C005	46317588938991	498	416500.0
8913633804527	C005	46317588938991	497	416500.0
8913633804527	C005	46317588938991	496	416500.0
8110093336815	C002	44062132306159	136	675000.0
7471316467951	C005	42155146150127	672	665000.0
7471316467951	C005	42155146182895	672	665000.0
7894080979183	C002	43514855719151	943	585000.0
9024434962671	C006	46662934921455	420	650000.0
9024434962671	C006	46662934921455	419	650000.0
9024434962671	C006	46662934921455	418	650000.0
9024434962671	C006	46662934954223	420	650000.0
9024434962671	C006	46662934954223	419	650000.0
9024434962671	C006	46662934954223	418	650000.0
9024434962671	C006	46662935838959	420	650000.0
9024434962671	C006	46662935838959	419	650000.0
9024434962671	C006	46662935838959	418	650000.0
8082171461871	C005	44002289254639	598	595000.0
8082171461871	C005	44002289254639	597	595000.0
8082171461871	C005	44002289287407	598	595000.0
8082171461871	C005	44002289287407	597	595000.0
9000428863727	C003	46573544702191	106	950000.0
8005163450607	C005	43790371913967	579	675000.0
8005163450607	C005	43790371913967	578	675000.0
8005163450607	C005	43790371913967	577	675000.0
8005163450607	C005	43790371946735	579	675000.0
8005163450607	C005	43790371946735	578	675000.0
8005163450607	C005	43790371946735	577	675000.0
8005163450607	C005	46417286267119	579	675000.0
8005163450607	C005	46417286267119	578	675000.0
8005163450607	C005	46417286267119	577	675000.0
8498633998575	C002	45077838561519	541	525000.0
8498633998575	C002	45077838561519	540	525000.0
8498633998575	C002	45077838561519	539	525000.0
8498633998575	C002	45077838594287	541	525000.0
8498633998575	C002	45077838594287	540	525000.0
8498633998575	C002	45077838594287	539	525000.0
8498633998575	C002	45077838627055	541	525000.0
8498633998575	C002	45077838627055	540	525000.0
8498633998575	C002	45077838627055	539	525000.0
8145136746735	C002	44136350941423	383	625000.0
8145136746735	C002	44136350941423	382	625000.0
8145136746735	C002	44136359919855	383	625000.0
8145136746735	C002	44136359919855	382	625000.0
7455651135727	C011	42090536993007	112	500000.0
8843358404847	C002	46124934889711	16	675000.0
8959305777391	C002	46456355979503	569	346500.0
8196095443183	C005	44244875018479	33	354000.0
8196095443183	C005	44244875018479	32	354000.0
8196095443183	C005	44244875018479	31	354000.0
8196095443183	C005	44244875051247	33	354000.0
8196095443183	C005	44244875051247	32	354000.0
8196095443183	C005	44244875051247	31	354000.0
8196095443183	C005	44244875084015	33	354000.0
8196095443183	C005	44244875084015	32	354000.0
8196095443183	C005	44244875084015	31	354000.0
8752242000111	C005	45808841490671	839	675000.0
8752242000111	C005	45808841490671	838	675000.0
8752242000111	C005	45808841490671	837	675000.0
8752242000111	C005	45808841523439	839	675000.0
8752242000111	C005	45808841523439	838	675000.0
8752242000111	C005	45808841523439	837	675000.0
8752242000111	C005	45808841556207	839	675000.0
8752242000111	C005	45808841556207	838	675000.0
8752242000111	C005	45808841556207	837	675000.0
8792577900783	C005	45972777599215	587	675000.0
8792577900783	C005	45972777599215	586	675000.0
8792577900783	C005	45972777599215	585	675000.0
8792577900783	C005	45972777631983	587	675000.0
8792577900783	C005	45972777631983	586	675000.0
8792577900783	C005	45972777631983	585	675000.0
8792577900783	C005	45972789756143	587	675000.0
8792577900783	C005	45972789756143	586	675000.0
8792577900783	C005	45972789756143	585	675000.0
8842757177583	C003	46121922101487	377	342500.0
8218752418031	C003	44304749658351	554	675000.0
7975351189743	C002	43713135378671	518	675000.0
8218759266543	C002	44304774529263	632	585000.0
8218759266543	C002	44304774529263	631	585000.0
8218759266543	C002	44304778559727	632	585000.0
8218759266543	C002	44304778559727	631	585000.0
9024418152687	C005	46662851068143	173	585000.0
9024418152687	C005	46662851068143	172	585000.0
9024418152687	C005	46668073631983	173	585000.0
9024418152687	C005	46668073631983	172	585000.0
9024418152687	C005	46711441719535	173	585000.0
9024418152687	C005	46711441719535	172	585000.0
9024418152687	C005	46662851100911	173	585000.0
9024418152687	C005	46662851100911	172	585000.0
9024418152687	C005	46668073664751	173	585000.0
9024418152687	C005	46668073664751	172	585000.0
9024418152687	C005	46711441752303	173	585000.0
9024418152687	C005	46711441752303	172	585000.0
8252031893743	C003	44426312253679	581	595000.0
8252031893743	C003	44426312253679	580	595000.0
8252031893743	C003	44426315596015	581	595000.0
8252031893743	C003	44426315596015	580	595000.0
8294607487215	C002	44553798451439	944	450000.0
8114154406127	C005	44069826396399	25	789000.0
8114154406127	C005	44069826396399	24	789000.0
8114154406127	C005	44069826396399	23	789000.0
8114154406127	C005	44069826429167	25	789000.0
8114154406127	C005	44069826429167	24	789000.0
8114154406127	C005	44069826429167	23	789000.0
8114154406127	C005	44069826461935	25	789000.0
8114154406127	C005	44069826461935	24	789000.0
8114154406127	C005	44069826461935	23	789000.0
\.


--
-- Name: dim_category dim_category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_category
    ADD CONSTRAINT dim_category_pkey PRIMARY KEY (category_id);


--
-- Name: dim_measurements dim_measurements_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_measurements
    ADD CONSTRAINT dim_measurements_pkey PRIMARY KEY (measurement_id);


--
-- Name: dim_products dim_products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_products
    ADD CONSTRAINT dim_products_pkey PRIMARY KEY (product_id);


--
-- Name: dim_variants dim_variants_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_variants
    ADD CONSTRAINT dim_variants_pkey PRIMARY KEY (variant_id);


--
-- Name: fact_catalog fact_catalog_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_catalog
    ADD CONSTRAINT fact_catalog_pkey PRIMARY KEY (product_id, category_id, variant_id, measurement_id);


--
-- Name: fact_catalog fact_catalog_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_catalog
    ADD CONSTRAINT fact_catalog_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.dim_category(category_id);


--
-- Name: fact_catalog fact_catalog_measurement_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_catalog
    ADD CONSTRAINT fact_catalog_measurement_id_fkey FOREIGN KEY (measurement_id) REFERENCES public.dim_measurements(measurement_id);


--
-- Name: fact_catalog fact_catalog_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_catalog
    ADD CONSTRAINT fact_catalog_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.dim_products(product_id);


--
-- Name: fact_catalog fact_catalog_variant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_catalog
    ADD CONSTRAINT fact_catalog_variant_id_fkey FOREIGN KEY (variant_id) REFERENCES public.dim_variants(variant_id);


--
-- PostgreSQL database dump complete
--

