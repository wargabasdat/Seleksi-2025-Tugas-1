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
-- Name: dim_book_zone; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dim_book_zone (
    book_id integer NOT NULL,
    zone_id integer NOT NULL
);


ALTER TABLE public.dim_book_zone OWNER TO postgres;

--
-- Name: dim_books; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dim_books (
    book_id integer NOT NULL,
    title character varying(100) NOT NULL,
    subtitle character varying(200),
    isbn character varying(20) NOT NULL,
    translator character varying(50),
    total_pages integer NOT NULL,
    length numeric(10,2) NOT NULL,
    width numeric(10,2) NOT NULL,
    spine numeric(10,2) NOT NULL
);


ALTER TABLE public.dim_books OWNER TO postgres;

--
-- Name: dim_class; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dim_class (
    course_name character varying(50) NOT NULL,
    course_materials character varying(1000) NOT NULL,
    course_audience character varying(100) NOT NULL,
    course_duration character varying(100) NOT NULL,
    course_enrollment integer NOT NULL,
    course_tuition integer NOT NULL
);


ALTER TABLE public.dim_class OWNER TO postgres;

--
-- Name: dim_price; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dim_price (
    book_id integer NOT NULL,
    price_zone_1 integer NOT NULL,
    price_zone_2 integer NOT NULL,
    price_zone_3 integer NOT NULL,
    price_zone_4 integer NOT NULL,
    price_zone_5 integer NOT NULL,
    price_zone_6 integer NOT NULL
);


ALTER TABLE public.dim_price OWNER TO postgres;

--
-- Name: dim_zone; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dim_zone (
    zone_id integer NOT NULL,
    details character varying(1000) NOT NULL
);


ALTER TABLE public.dim_zone OWNER TO postgres;

--
-- Name: fact_initial_payment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fact_initial_payment (
    coding_class_name character varying(50) NOT NULL,
    book_id integer NOT NULL,
    zone_id integer NOT NULL,
    total_price integer NOT NULL
);


ALTER TABLE public.fact_initial_payment OWNER TO postgres;

--
-- Data for Name: dim_book_zone; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dim_book_zone (book_id, zone_id) FROM stdin;
1	1
1	2
1	3
1	4
1	5
1	6
2	1
2	2
2	3
2	4
2	5
2	6
3	1
3	2
3	3
3	4
3	5
3	6
4	1
4	2
4	3
4	4
4	5
4	6
5	1
5	2
5	3
5	4
5	5
5	6
\.


--
-- Data for Name: dim_books; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dim_books (book_id, title, subtitle, isbn, translator, total_pages, length, width, spine) FROM stdin;
1	Cendekia Digital	Belajar Koding, Kecerdasan Artifisial & Teknologi dengan MenyenangkanKelas 5	978-634-04-0983-3	Meilani Hendrawidjaja	121	27.00	21.60	27.00
2	BERPIKIR KOMPUTASI	Melatih Berpikir Komputasi Dengan KodingKelas 5	978-634-04-0982-6		138	27.00	21.60	27.00
3	Cendekia Digital	Koding dan Kecerdasan Artifisial dengan Aplikasi PictoBloxJenjang SMP/MTs	978-634-04-0981-9	Tim KodeKiddo	128	27.00	21.60	27.00
4	Kecerdasan Artifisial	Eksplorasi Kecerdasan Artifisial dan Pemelajaran Mesin dengan Aplikasi PictoBloxJenjang SMA/MA/SMK	978-634-04-0980-2	Tim KodeKiddo	111	27.00	21.60	27.00
5	Unplugged Koding	Aktivitas Unplugged Koding dan Kecerdasan Artifisial Jenjang SMP/MTs	978-634-04-0872-0		70	27.00	21.60	27.00
\.


--
-- Data for Name: dim_class; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dim_class (course_name, course_materials, course_audience, course_duration, course_enrollment, course_tuition) FROM stdin;
Introduction to Coding	Ditujukan untuk mereka yang belum memiliki pengalaman programming sebelumnya.Memperkenalkan konsep dasar programming Menggunakan visual programming languages dan online platforms. Mengerjakan simple software-hardware projects dengan robot Sphero, BB8, Dash.	SD	90 mins "“ 1x seminggu	150000	350000
Coding for SD (Beginner)	Perkenalan konsep coding, Computational Thinking, dan computer science: menggunakan online platforms popular: Tynker, Kodu, CodeMonkey, Blockly, Scratch, Kodable memecahkan online puzzle dengan programming membuat animasi dan video game membuat custom Minecraft modding latihan computational thinking untuk kompetisi BebrasProgramming dengan robots: memprogram Sphero, BB-8, Dash robots mengontrol robot with block programming berkerja sama dalam group memecahkan masalah dengan programming	SD Grade 1-3	1-2x seminggu	150000	350000
Coding for SD (Advance)	Memperdalam konsep coding, Computational Thinking, dan computer science: menggunakan online platforms popular: Tynker, Scratch, CodeMonkey, MIT App Inventor, Grok Learning membuat animasi, video game, web pages, mobile apps membuat custom Minecraft mod latihan computational thinking untuk kompetisi Bebras perkenalan ke dasar text-based coding languages (HTML, Python, Java, C++, C, Javascript) dan konsep Artificial Intelligent "“ Maching Learning.Programming dengan hardware: memprogram Sphero, BB-8, Dash, Cozmo robots dan circuit hardware Microbit, Makey-Makey mengontrol robot with block programming berkerja sama dalam group memecahkan masalah dengan programming	SD Grade 4-6	1-2x seminggu	150000	350000
Coding for SMP	Memperdalam konsep coding, Computational Thinking, dan computer science untuk level SMP: perkenalan dasar coding dengan menggunakan block programming dan dilanjutkan ke text-based coding languages (HTML, Python, Java, C++, C, Javascript) membuat animasi, websites, mobile apps, games dengan menggunakan programming latihan computational thinking untuk kompetisi Bebras perkenalan konsep Artificial Intelligent "“ Maching LearningProgramming dengan hardware: memprogram robot MakeBot, UB Kit, Dash implementasi coding ke circuit hardware Microbit, Makey-Makey, Arduino	SMP	1-2x seminggu	150000	475000
Coding for SMA	Perkenalan ke programming dan dilanjutkan dengan eksplorasi coding di area berikut: Game Development Web Development App Development Computer Science, Algorithm, and Math in Coding Data, Database and AI Intro for SMUSetelah menyelesaikan kelas perkenalan tersebut, murid dapat memilih spesialisasi di bidang yang lebih spesifik: Android App Development Data Science AI & Machine Learning Android App Development iOS App Development Python Programming Algebra, Algorithm & Programming	SMA	90 Min1-2x Seminggu	150000	500000
\.


--
-- Data for Name: dim_price; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dim_price (book_id, price_zone_1, price_zone_2, price_zone_3, price_zone_4, price_zone_5, price_zone_6) FROM stdin;
1	44000	45800	47700	69600	73300	91600
2	49800	51900	53900	78800	83000	103700
3	59000	69000	79000	89000	99000	109000
4	66000	76000	86000	86000	96000	106000
5	66000	75000	85000	95000	105000	115000
\.


--
-- Data for Name: dim_zone; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dim_zone (zone_id, details) FROM stdin;
1	Jawa Barat, Jawa Tengah, Jawa Timur, Daerah Istimewa Yogyakarta, DKI Jakarta, dan Banten.
2	Bali, Nusa Tenggara Barat, Lampung (kecuali (i) Pesisir Barat), dan Sumatera Selatan.
3	Bengkulu, Jambi, Bangka Belitung, Sumatera Barat (kecuali (i) Kepulauan Mentawai dan (ii) Solok Selatan), Riau (kecuali (i) Bengkalis, (ii) Kepulauan Meranti, (iii) , Sumatera Utara (kecuali (i) Nias, (ii) Nias Selatan, (iii) Nias Utara, (iv) Nias Barat), Sulawesi Selatan, Sulawesi Utara (kecuali (i) Kepulauan Sangihe, dan (ii) Kepulauan Talaud), Sulawesi Tengah (kecuali (i) Banggai Kepulauan, (ii) Tojo Una-Una, (iii) Sigi, dan (iv) Banggai Laut), Sulawesi Barat, Sulawesi Tenggara (kecuali (i) Konawe, (ii) Bombana, dan (iii) Konawe Kepulauan), dan Gorontalo.
4	Bengkulu, Jambi, Bangka Belitung, Sumatera Barat (kecuali (i) Kepulauan Mentawai dan (ii) Solok Selatan), Riau (kecuali (i) Bengkalis, (ii) Kepulauan Meranti, (iii) , Sumatera Utara (kecuali (i) Nias, (ii) Nias Selatan, (iii) Nias Utara, (iv) Nias Barat), Sulawesi Selatan, Sulawesi Utara (kecuali (i) Kepulauan Sangihe, dan (ii) Kepulauan Talaud), Sulawesi Tengah (kecuali (i) Banggai Kepulauan, (ii) Tojo Una-Una, (iii) Sigi, dan (iv) Banggai Laut), Sulawesi Barat, Sulawesi Tenggara (kecuali (i) Konawe, (ii) Bombana, dan (iii) Konawe Kepulauan), dan Gorontalo.
5	(1) Aceh Besar, (2) Aceh Singkil, (3) Nias, (4) Nias Selatan, (5) Nias Utara, (6) Nias Barat, (7) Kep. Mentawai, (8) Solok Selatan, (9) Pesisir Barat, (10) Sumba Barat, (11) Sumba Timur, (12) Timor Tengah Selatan, (13) Belu, (14) Alor, (15) Lembata, (16) Ende, (17) Manggarai, (18) Rote Ndao, (19) Manggarai Barat, (20) Sumba Tengah, (21) Sumba Barat Daya, (22) Nagakeo, (23) Manggarai Timur, (24) Sabu Raijua, (25) Malaka, (26) Banggai Kepulauan, (27) Tojo Una-Una, (28) Sigi, (29) Banggai Laut, (30) Konawe, (31) Bombana, (32) Konawe Kepulauan, (33) Bengkalis, (34) Kepulauan Meranti, (35) Karimun, (36) Kepulauan Anambas, (37) Natuna, (38) Kapuas Hulu, (39) Mahakam Hulu, (40) Sanggau, (41) Nunukan, (42) Malinau, (43) Berau, (44) Kepulauan Sangihe, dan (45) Kepulauan Talaud.
6	Maluku, Maluku Utara, Papua, Papua Barat, Papua Barat Daya, Papua Selatan, Papua Tengah, dan Papua Pegunungan.
\.


--
-- Data for Name: fact_initial_payment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fact_initial_payment (coding_class_name, book_id, zone_id, total_price) FROM stdin;
Coding for SD (Advance)	1	1	544000
Coding for SD (Advance)	1	2	545800
Coding for SD (Advance)	1	3	547700
Coding for SD (Advance)	1	4	569600
Coding for SD (Advance)	1	5	573300
Coding for SD (Advance)	1	6	591600
Coding for SMP	3	1	684000
Coding for SMP	3	2	694000
Coding for SMP	3	3	704000
Coding for SMP	3	4	714000
Coding for SMP	3	5	724000
Coding for SMP	3	6	734000
Coding for SMA	4	1	716000
Coding for SMA	4	2	726000
Coding for SMA	4	3	736000
Coding for SMA	4	4	736000
Coding for SMA	4	5	746000
Coding for SMA	4	6	756000
Coding for SMP	5	1	691000
Coding for SMP	5	2	700000
Coding for SMP	5	3	710000
Coding for SMP	5	4	720000
Coding for SMP	5	5	730000
Coding for SMP	5	6	740000
Coding for SD (Beginner)	2	1	549800
Coding for SD (Beginner)	2	2	551900
Coding for SD (Beginner)	2	3	553900
Coding for SD (Beginner)	2	4	578800
Coding for SD (Beginner)	2	5	583000
Coding for SD (Beginner)	2	6	603700
Introduction to Coding	2	1	549800
Introduction to Coding	2	2	551900
Introduction to Coding	2	3	553900
Introduction to Coding	2	4	578800
Introduction to Coding	2	5	583000
Introduction to Coding	2	6	603700
\.


--
-- Name: dim_book_zone dim_book_zone_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_book_zone
    ADD CONSTRAINT dim_book_zone_pkey PRIMARY KEY (book_id, zone_id);


--
-- Name: dim_books dim_books_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_books
    ADD CONSTRAINT dim_books_pkey PRIMARY KEY (book_id);


--
-- Name: dim_class dim_class_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_class
    ADD CONSTRAINT dim_class_pkey PRIMARY KEY (course_name);


--
-- Name: dim_price dim_price_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_price
    ADD CONSTRAINT dim_price_pkey PRIMARY KEY (book_id);


--
-- Name: dim_zone dim_zone_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_zone
    ADD CONSTRAINT dim_zone_pkey PRIMARY KEY (zone_id);


--
-- Name: fact_initial_payment fact_initial_payment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_initial_payment
    ADD CONSTRAINT fact_initial_payment_pkey PRIMARY KEY (coding_class_name, book_id, zone_id);


--
-- Name: dim_book_zone dim_book_zone_book_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_book_zone
    ADD CONSTRAINT dim_book_zone_book_id_fkey FOREIGN KEY (book_id) REFERENCES public.dim_books(book_id);


--
-- Name: dim_book_zone dim_book_zone_zone_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_book_zone
    ADD CONSTRAINT dim_book_zone_zone_id_fkey FOREIGN KEY (zone_id) REFERENCES public.dim_zone(zone_id);


--
-- Name: dim_price dim_price_book_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_price
    ADD CONSTRAINT dim_price_book_id_fkey FOREIGN KEY (book_id) REFERENCES public.dim_books(book_id);


--
-- Name: fact_initial_payment fact_initial_payment_book_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_initial_payment
    ADD CONSTRAINT fact_initial_payment_book_id_fkey FOREIGN KEY (book_id) REFERENCES public.dim_books(book_id);


--
-- Name: fact_initial_payment fact_initial_payment_coding_class_name_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_initial_payment
    ADD CONSTRAINT fact_initial_payment_coding_class_name_fkey FOREIGN KEY (coding_class_name) REFERENCES public.dim_class(course_name);


--
-- Name: fact_initial_payment fact_initial_payment_zone_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_initial_payment
    ADD CONSTRAINT fact_initial_payment_zone_id_fkey FOREIGN KEY (zone_id) REFERENCES public.dim_zone(zone_id);


--
-- PostgreSQL database dump complete
--

