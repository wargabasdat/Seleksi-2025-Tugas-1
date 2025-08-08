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
-- Name: auditorium_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auditorium_type (
    id integer NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE public.auditorium_type OWNER TO postgres;

--
-- Name: auditorium_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auditorium_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.auditorium_type_id_seq OWNER TO postgres;

--
-- Name: auditorium_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auditorium_type_id_seq OWNED BY public.auditorium_type.id;


--
-- Name: cinema; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cinema (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    address text,
    id_kota integer NOT NULL
);


ALTER TABLE public.cinema OWNER TO postgres;

--
-- Name: cinema_auditorium; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cinema_auditorium (
    id_bioskop integer NOT NULL,
    id_auditorium_type integer NOT NULL
);


ALTER TABLE public.cinema_auditorium OWNER TO postgres;

--
-- Name: cinema_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cinema_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cinema_id_seq OWNER TO postgres;

--
-- Name: cinema_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cinema_id_seq OWNED BY public.cinema.id;


--
-- Name: city; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.city (
    id integer NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE public.city OWNER TO postgres;

--
-- Name: city_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.city_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.city_id_seq OWNER TO postgres;

--
-- Name: city_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.city_id_seq OWNED BY public.city.id;


--
-- Name: auditorium_type id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auditorium_type ALTER COLUMN id SET DEFAULT nextval('public.auditorium_type_id_seq'::regclass);


--
-- Name: cinema id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cinema ALTER COLUMN id SET DEFAULT nextval('public.cinema_id_seq'::regclass);


--
-- Name: city id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.city ALTER COLUMN id SET DEFAULT nextval('public.city_id_seq'::regclass);


--
-- Data for Name: auditorium_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auditorium_type (id, name) FROM stdin;
0	4DX
1	VELVET
2	Sweetbox
3	STARIUM
4	GOLD
5	SATIN
6	SCREENX
7	Private
8	Sporthall
9	SPHEREX
\.


--
-- Data for Name: cinema; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cinema (id, name, address, id_kota) FROM stdin;
1	Paris Van Java	Paris van Java Resort Lifestyle Place - Jl. Sukajadi 137-139, Ground floor, Level 1 dan Level 2 Bandung 40162	0
11	Miko Mall	Miko Mall Lantai 3A Jl. Kopo Cirangrang No 559 Bandung	0
14	BEC Mall	Istana Bandung Electronic Centre 2 Lantai 3A Jl.Purnawarman No.7 – 11 Bandung 40117	0
29	23 Paskal Shopping Center	23 Paskal Shopping Centre Lt. 3 - Paskal Hyper Square : Jl. Pasirkaliki No. 25 - 27 , Kb. Jeruk , Andir - Bandung	0
38	Metro Indah Mall	MIM SF Lt. 2 - Jl. Soekarno Hatta, Kawasan Niaga MTC No. 590, Sekejati, Buahbatu - Kota Bandung 40286	0
60	Kings Shopping Center	Kings Plaza Bandung Jl. Kepatihan 4 - 6,11 - 7, Lantai 6A Balong Gede, Regol, Kota Bandung, Jawa Barat 40265	0
59	Sadang Terminal Square	Sadang Town Square, Jl. Veteran, ciwangi, 242B, bungur sari, Purwakarta - Jawa Barat 41118	1
19	Festive Walk	Festive Walk Mall lantai 5 Jl Galuh Mas Raya Komplek Perumahan Galuh - Karawang barat 41361	2
46	Technomart	Tenchomart Karawang Lt. 3 Jl. Galuh MAS Raya, Sukaharja, Telukjambe Timur, Kabupaten Karawang, Jawa Barat 41361	2
56	Cikampek Mall	Cikampek Mall Lantai 2 Jl. Jend. Sudirman No.76, Dawuan Tengah, Kec. Cikampek, Kabupaten Karawang, Jawa Barat 41373	2
69	Living Plaza Jababeka	Living Plaza Jababeka Lt. 1, Mekarmukti,Kec. Cikarang Utara, Kabupaten Bekasi, Jawa Barat 17530	3
16	Grage City Mall	Grage City Mall Lt. 2 - Jl. Ahmad Yani, Pegambiran, Cirebon	4
42	Transmart Cirebon	Transmart Cirebon 1st floor Jl. Raya Cipto Mangunkusumo No.234, Pekiringan, Kesambi, Cirebon City	4
52	Vivo Sentul	Vivo Sentul Bogor Jl. Raya Bogor KM 50, Cimandala, 16710, Jawa Barat, Kab. Bogor	5
7	Bekasi Cyber Park	Mall Bekasi Cyber Park Lantai 3 Jl. KH Noer Alie no. 177 - Bekasi	6
36	Bekasi Trade Center	BTC Mall 2 Ground Floor - Jl. H. M. Joyomartono, Bulak Kapal, Bekasi Timur, Margahayu - DKI Jakarta 17113	6
40	Lagoon Avenue Bekasi	Marketing Gallery Lagoon Avenue Bekasi. Jalan KH Noer Ali No. 3A, Kota Bekasi, DKI Jakarta 17148	6
2	Grand Indonesia	Grand Indonesia, West Mall Building 8th Floor Jl. M.H. Thamrin No. 1 Jakarta - Pusat	7
3	Pacific Place	One Pacific Place Mall 6th Floor, Jl. Jendral Sudirman Kav. 52 - 53 Sudirman Central Business District Jakarta Pusat	7
6	Central Park	Mall Central Park (Podomoro City) -Level 8 ( P13 ) Jl. Jend. S. Parman Kav 28 Jakarta Barat 11470	7
20	Slipi Jaya	Plaza Slipi Jaya Lantai 4 Jl. Letjend S Parman no. Kav 17-18 - Jakarta Barat 11410	7
25	Green Pramuka Mall	Green Pramuka Square 1st Floor, Jl. Jendral Ahmad Yani Kav. 49, Rawasari Cempaka Putih, Central Jakarta 10570	7
28	Bella Terra Lifestyle Center	Bellatera Lifestyle Center 6th floor Jl Boulevard Raya kav 1, Pulomas Kelapa Gading	7
35	Transmart Cempaka Putih	Transmart Cempaka Putih Lt. 3 - Jl. Jend A. Yani No. 83, Cempaka Putih, Jakarta Utara	7
37	Aeon Mall JGC	AEON Cakung Mall Lt. 3 Ps. Modern Jakarta Garden City Jl. Cassia Utama No. 46, Cakung - Jakarta 13960	7
49	FX Sudirman	FX Mall Lantai 7, Jl. Jend Sudirman RT.001/03, Gelora tn.Abang, Jakarta pusat 10270	7
68	Sunter Mall	Sunter Mall Lt. 3 Jl. Danau Sunter Blok.G7 Kav.2, Sunter Agung Jakarta Utara 14350	7
86	Buaran Plaza	Buaran Plaza 2nd Floor Jl. Raden Inten 1 Buaran - Jakarta Timur 13470	7
92	Poins Mall	Jl. RA kartini No. 1 Lb. Bulus -Cilandak Jakarta Selatan	7
30	Depok Mall	DMall Depok Lt. 4 - Jl. Margonda Raya Kav 88 , Kemiri Muka , Beji	8
73	DTC Depok	Depok	8
5	Teras Kota	Mall Teras Kota Lantai 2 Jl. Raya Pahlawan Seribu Sektor IV CBD Lot VIIB, BSD City - Serpong - Tangerang Selatan	9
22	Ecoplaza Citraraya Cikupa	Eco Plaza Lt. 2 - Jl. Ecopolis BoulevardSelatan, Citra Raya, Cikupa	9
45	Transmart Graha Bintaro	Transmart Graha Bintaro 1st floor Jl. Boulevard Raya, Perumahan Graha Raya Bintaro, Kel. Paku Jaya, Kec. Serpong Utara,Tangerang Selatan	9
65	Paradise Walk Serpong	Paradise Walk Serpong UG Floor Jl. Paradise Serpong City, Babakan, Kec. Setu, Kota Tangerang Selatan, Banten 15315	9
80	Grand Batavia	Grand Batavia Jl. Raya Grand Batavia, Sindangsari, Kec. Ps. Kemis, Kabupaten Tangerang, Banten 15560	9
83	Foodmosphere	Foodmoshere goldland - Jl. Imam Bonjol, Panunggangan Bar RT 3 / RW 4, Kec. Karawaci, Kota Tangerang, Banten 15810	9
89	Mal Ciputra Tangerang	Jl. Citra Raya Boulevard No.38 Lantai 3F, Ciakar, Kec. Panongan, Kabupaten Tangerang, Banten 15710	9
32	Transmart Tegal	Transmart Tegal Lt. 1 - Jl. Kolonel Sugiono, Kemandungan, Tegal 52112	10
94	Ecoplaza Citra Maja Raya	Kabupaten Serang, Banten Jalan Raya Kopo, Citra Maja Raya,	11
26	Rita Supermall	Rita Supermall Lt. 5 - Jl. Jend Sudirman No. 296, Sokanegara, Purwokerto	12
13	Jwalk Mall	Sahid J-Walk Mall 3rd fl. Jl Babarsari No.2 Catur Tunggal, Depok, Sleman. DI Yogyakarta 55281	13
17	Pakuwon Mall Jogja	Jl. Raya Ringroad Utara, Kaliwaru, Condongcatur, Kec. Depok, Kabupaten Sleman, DI Yogyakarta 55281	13
31	Transmart Maguwo	Transmart Maguwo Yogyakarta Lt. 1 - Jl. Raya Solo KM 8 No. 234, Sleman, DI Yogyakarta 55282	13
41	Transmart Solo	Transmart Solo Pabelan 5th floor Jl. Raya A. Yani No. 234, Pabelan Kartosuro, Pabelan, Kartasura, Kabupaten Sukoharjo, Jawa Tengah 57162	14
43	Transmart Lampung	Transmart Lampung 4th floor Jl. Sultan Agung No.283, Way Halim Permai, Way Halim, Kota Bandar Lampung, Lampung 35132	15
66	Plaza Lawu Madiun	Plaza Lawu Madiun Lantai 3, JL. Pahlawan, Kartoharjo, Madiun - Jawa Timur 63117	16
51	Icon Mall Gresik	Jl. Dr. Wahidin S.H. No. 712, Kembangan,Kebomas, Kabupaten Gresik, Jawa Timur 61124	17
67	Kediri Mall	Kediri Mall Lantai 7 Jl. Hayam Wuruk No. 46, Kediri, Jawa Timur.	18
23	Sunrise Mall	Sunrise Mall Lt 2 - Jl. Benteng Pancasila no. 9, Bolongsari, Mergasari - Mojokerto	19
18	Marvell City	Marvel City Mall 2nd floor Jl. Ngagel No 123, Wonokromo, Surabaya, Jawa Timur 60246	20
48	BG Junction	Jl. Bubutan No 1-7 Unit P9 Zone C Kel Pekiringan Kec Kesambi Surabaya 60174	20
81	Maspion Square	Maspion Square – 1st Floor, Jl. Ahmad Yani No. 73, Margorejo, Wonocolo Surabaya – Jawa Timur 60238	20
53	Blitar Square	Blitar Square, Jl. Merdeka No.6-7 Lantai 3 kepanjen lor, kepanjen kidul, Blitar - Jawa Timur	21
76	Malang City Point	Malang City Point Jl. Terusan Dieng No.32, Pisang Candi, Kec. Sukun, Kota Malang, Jawa Timur 65115	22
70	Wijaya Kusuma	Wijaya Kusuma Mall, Jl. Mangunharjo, Mayangan Probolinggo, Jawa timur 67218	23
27	Social Market	Social Market Citywalk Lt. 2 - Jl. Veteran No. 999 , Palembang	24
39	Transmart Palembang	Transmart Palembang 3rd floor, 26 Ilir, Bukit Kecil, Kota Palembang, Sumatera Selatan 30127	24
64	PTC Mall	PALEMBANG TRADE CENTER, Jl. R.Sukamto No. 8A, 8 ilir timur 2 Kota Palembang - Sumatera selatan 30114	24
77	Roxy Square Jember	Roxy Square Jember Jl. Hayam Wuruk No.50-58, Gerdu, Sempusari, Kaliwates, Kabupaten Jember, Jawa Timur 68131	25
34	Transmart Mataram	Transmart Mataram Lt. 1 - Jl. Selaparang No. 60, Mataram, Nusa Tenggara Barat	26
57	Park Avenue Batam	Park Avenue Batam Upper Ground, Jl.Orchard Boulevard, Belian, Batamkota, Kep. Riau 29444	27
71	Grand Batam Mall	Mall Grand Batam Lantai 3 Jl. Pembangunan, Kawasan Mall Grand Batam Penuin, Penuin, Batu Selicin, Lubuk Baja, Kota Batam, Kepulauan Riau 29444	27
79	Raya Padang	Jalan Ps. Baru 2 No. 2, Kampung Jao, Padang Barat, Kp. Jao, Padang Bar, Kota Padang, Sumatera Barat	28
33	Transmart Pekanbaru	Transmart Pekanbaru Lt. 1 - Jl. Musyawarah No. 11, Payung Sekaki, Pekanbaru 28292	29
87	Holiday Pekanbaru	Holiday 88 Jalan Sultan Syarif Qasim No.120, Kota Tinggi, LimaPuluh, Rintis, LimaPuluh, Kota Pekanbaru, Riau 28112	29
88	Studio Pekanbaru	Studio 88 Pekanbaru, Gedung Plaza Citra Lt. 5, Jl. Pepaya, Jadirejo, Pekanbaru, Jadirejo, Sukajadi,Kota Pekanbaru, Riau 28121	29
72	Panakkukang Square	PANAKKUKANG MALL Lantai 2 Jalan Adhyaksa No.1 Panakkukang Mas Makassar, Sulawesi Selatan	30
8	Plaza Balikpapan	Plaza Balikpapan Lt. 1 - Jl. Jend. Sudirman No. 1, Kelandasan Ilir, Balikpapan	31
55	Plaza Mulia	Jl. Bhayangkara No.58, 01, Bugis, Kec. Samarinda Ulu, Kota Samarinda, Kalimantan Timur 75242	32
24	Focal Point	Focal Point Mall Lt. 3 - Jl. Ring Road Setiabudi, Medan	33
\.


--
-- Data for Name: cinema_auditorium; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cinema_auditorium (id_bioskop, id_auditorium_type) FROM stdin;
1	0
1	1
11	2
29	2
29	3
29	4
29	1
38	2
38	5
60	2
59	2
19	2
46	2
46	5
46	1
56	2
69	2
16	2
42	2
52	2
7	2
36	2
40	2
2	3
2	0
2	4
2	1
2	6
2	5
2	7
3	2
3	1
3	4
6	2
6	1
6	0
6	5
6	6
20	2
25	2
28	2
28	4
35	2
35	5
37	2
37	4
37	1
37	6
49	5
49	8
68	2
86	2
92	5
30	2
73	5
5	2
5	4
5	8
22	2
45	2
65	2
65	5
80	2
89	2
89	5
89	8
32	2
26	2
13	2
17	3
17	9
17	0
17	1
31	2
41	2
43	2
66	2
51	2
67	2
23	2
18	0
18	9
48	2
81	2
76	5
70	2
27	2
27	1
39	2
64	2
64	5
34	2
57	2
57	4
57	1
71	2
71	5
33	2
87	2
72	2
72	5
8	2
8	1
55	2
55	5
24	2
24	4
\.


--
-- Data for Name: city; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.city (id, name) FROM stdin;
0	Bandung
1	Purwakarta
2	Karawang
3	Cikarang
4	Cirebon
5	Bogor
6	Bekasi
7	Jakarta
8	Depok
9	Tangerang
10	Tegal
11	Serang
12	Purwokerto
13	Yogyakarta
14	Solo
15	Lampung
16	Madiun
17	Gresik
18	Kediri
19	Mojokerto
20	Surabaya
21	Blitar
22	Malang
23	Probolinggo
24	Palembang
25	Jember
26	Mataram
27	Batam
28	Padang
29	Pekanbaru
30	Makassar
31	Balikpapan
32	Samarinda
33	Medan
\.


--
-- Name: auditorium_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auditorium_type_id_seq', 1, false);


--
-- Name: cinema_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cinema_id_seq', 1, false);


--
-- Name: city_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.city_id_seq', 1, false);


--
-- Name: auditorium_type auditorium_type_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auditorium_type
    ADD CONSTRAINT auditorium_type_name_key UNIQUE (name);


--
-- Name: auditorium_type auditorium_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auditorium_type
    ADD CONSTRAINT auditorium_type_pkey PRIMARY KEY (id);


--
-- Name: cinema_auditorium cinema_auditorium_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cinema_auditorium
    ADD CONSTRAINT cinema_auditorium_pkey PRIMARY KEY (id_bioskop, id_auditorium_type);


--
-- Name: cinema cinema_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cinema
    ADD CONSTRAINT cinema_pkey PRIMARY KEY (id);


--
-- Name: city city_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.city
    ADD CONSTRAINT city_pkey PRIMARY KEY (id);


--
-- Name: cinema_auditorium cinema_auditorium_id_auditorium_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cinema_auditorium
    ADD CONSTRAINT cinema_auditorium_id_auditorium_type_fkey FOREIGN KEY (id_auditorium_type) REFERENCES public.auditorium_type(id);


--
-- Name: cinema_auditorium cinema_auditorium_id_bioskop_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cinema_auditorium
    ADD CONSTRAINT cinema_auditorium_id_bioskop_fkey FOREIGN KEY (id_bioskop) REFERENCES public.cinema(id);


--
-- Name: cinema cinema_id_kota_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cinema
    ADD CONSTRAINT cinema_id_kota_fkey FOREIGN KEY (id_kota) REFERENCES public.city(id);


--
-- PostgreSQL database dump complete
--

