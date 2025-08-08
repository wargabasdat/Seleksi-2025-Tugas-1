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
-- Name: book_writer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.book_writer (
    book_id integer NOT NULL,
    writer_name character varying(100) NOT NULL
);


ALTER TABLE public.book_writer OWNER TO postgres;

--
-- Name: book_zone; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.book_zone (
    book_id integer NOT NULL,
    zone_id integer NOT NULL
);


ALTER TABLE public.book_zone OWNER TO postgres;

--
-- Name: books; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.books (
    book_id integer NOT NULL,
    program_id integer NOT NULL,
    title character varying(100) NOT NULL,
    subtitle character varying(200),
    isbn character varying(20) NOT NULL,
    translator character varying(50),
    total_pages integer NOT NULL,
    length numeric(10,2) NOT NULL,
    width numeric(10,2) NOT NULL,
    spine numeric(10,2) NOT NULL
);


ALTER TABLE public.books OWNER TO postgres;

--
-- Name: books_price; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.books_price (
    book_id integer NOT NULL,
    price_zone_1 integer NOT NULL,
    price_zone_2 integer NOT NULL,
    price_zone_3 integer NOT NULL,
    price_zone_4 integer NOT NULL,
    price_zone_5 integer NOT NULL,
    price_zone_6 integer NOT NULL
);


ALTER TABLE public.books_price OWNER TO postgres;

--
-- Name: branch; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.branch (
    branch_name character varying(100) NOT NULL,
    address character varying(300) NOT NULL
);


ALTER TABLE public.branch OWNER TO postgres;

--
-- Name: class_program; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.class_program (
    program_id integer NOT NULL
);


ALTER TABLE public.class_program OWNER TO postgres;

--
-- Name: coding_class_info; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.coding_class_info (
    course_name character varying(50) NOT NULL,
    course_materials character varying(1000) NOT NULL,
    course_audience character varying(100) NOT NULL,
    course_duration character varying(100) NOT NULL,
    course_enrollment integer NOT NULL,
    course_tuition integer NOT NULL,
    program_id integer NOT NULL
);


ALTER TABLE public.coding_class_info OWNER TO postgres;

--
-- Name: kiddo_stem_program; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.kiddo_stem_program (
    class_name character varying(100) NOT NULL,
    age character varying(20) NOT NULL,
    program_id integer NOT NULL
);


ALTER TABLE public.kiddo_stem_program OWNER TO postgres;

--
-- Name: kinder_coding_package; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.kinder_coding_package (
    package_name character varying(20) NOT NULL,
    membership_length character varying(20) NOT NULL,
    total_session integer NOT NULL,
    discount boolean NOT NULL,
    program_id integer NOT NULL
);


ALTER TABLE public.kinder_coding_package OWNER TO postgres;

--
-- Name: non_class_program; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.non_class_program (
    program_id integer NOT NULL
);


ALTER TABLE public.non_class_program OWNER TO postgres;

--
-- Name: paud_teacher_training; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.paud_teacher_training (
    training_id character varying(10) NOT NULL,
    program_id integer,
    province character varying(20) NOT NULL,
    city character varying(30) NOT NULL,
    number_of_facilitators integer NOT NULL
);


ALTER TABLE public.paud_teacher_training OWNER TO postgres;

--
-- Name: program; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.program (
    program_id integer NOT NULL,
    program_name character varying(50) NOT NULL
);


ALTER TABLE public.program OWNER TO postgres;

--
-- Name: program_available_at; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.program_available_at (
    program_id integer NOT NULL,
    branch_name character varying(100) NOT NULL
);


ALTER TABLE public.program_available_at OWNER TO postgres;

--
-- Name: school_teacher_training; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.school_teacher_training (
    training_id character varying(10) NOT NULL,
    program_id integer,
    province character varying(20) NOT NULL,
    city character varying(30) NOT NULL,
    class_name character varying(50) NOT NULL,
    target_audience integer NOT NULL,
    lower_bound_price integer NOT NULL,
    upper_bound_price integer NOT NULL,
    training_branch character varying(100) NOT NULL
);


ALTER TABLE public.school_teacher_training OWNER TO postgres;

--
-- Name: student; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.student (
    student_id integer NOT NULL,
    student_name character varying(100) NOT NULL,
    branch_name character varying(100) NOT NULL
);


ALTER TABLE public.student OWNER TO postgres;

--
-- Name: student_program; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.student_program (
    student_id integer NOT NULL,
    program_id integer NOT NULL
);


ALTER TABLE public.student_program OWNER TO postgres;

--
-- Name: thematic_class; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.thematic_class (
    topic character varying(100) NOT NULL,
    topic_description character varying(1000),
    program_id integer NOT NULL
);


ALTER TABLE public.thematic_class OWNER TO postgres;

--
-- Name: webinar; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.webinar (
    webinar_name character varying(100) NOT NULL,
    webinar_date date,
    program_id integer NOT NULL
);


ALTER TABLE public.webinar OWNER TO postgres;

--
-- Name: zone; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.zone (
    zone_id integer NOT NULL,
    details character varying(1000) NOT NULL
);


ALTER TABLE public.zone OWNER TO postgres;

--
-- Data for Name: book_writer; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.book_writer (book_id, writer_name) FROM stdin;
1	Pankaj Kumar Verma
1	Drupal R. Shah
1	Khushbu Chauhan
1	Devi M.
2	Meilani Hendrawidjaja
2	Guruh Nusantara
2	Tevin Odysseus
2	Wych Dewangga
3	Pankaj Kumar Verma
3	Drupal R. Shah
3	Khushbu Chauhan
3	Devi M.
4	Pankaj Kumar Verma
4	Akshat Srivastava
5	Meilani Hendrawidjaja
5	Guruh Nusantara
5	Tevin Odysseus
5	Wych Dewangga
\.


--
-- Data for Name: book_zone; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.book_zone (book_id, zone_id) FROM stdin;
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
-- Data for Name: books; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.books (book_id, program_id, title, subtitle, isbn, translator, total_pages, length, width, spine) FROM stdin;
1	8	Cendekia Digital	Belajar Koding, Kecerdasan Artifisial & Teknologi dengan MenyenangkanKelas 5	978-634-04-0983-3	Meilani Hendrawidjaja	121	27.00	21.60	27.00
2	8	BERPIKIR KOMPUTASI	Melatih Berpikir Komputasi Dengan KodingKelas 5	978-634-04-0982-6		138	27.00	21.60	27.00
3	8	Cendekia Digital	Koding dan Kecerdasan Artifisial dengan Aplikasi PictoBloxJenjang SMP/MTs	978-634-04-0981-9	Tim KodeKiddo	128	27.00	21.60	27.00
4	8	Kecerdasan Artifisial	Eksplorasi Kecerdasan Artifisial dan Pemelajaran Mesin dengan Aplikasi PictoBloxJenjang SMA/MA/SMK	978-634-04-0980-2	Tim KodeKiddo	111	27.00	21.60	27.00
5	8	Unplugged Koding	Aktivitas Unplugged Koding dan Kecerdasan Artifisial Jenjang SMP/MTs	978-634-04-0872-0		70	27.00	21.60	27.00
\.


--
-- Data for Name: books_price; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.books_price (book_id, price_zone_1, price_zone_2, price_zone_3, price_zone_4, price_zone_5, price_zone_6) FROM stdin;
1	44000	45800	47700	69600	73300	91600
2	49800	51900	53900	78800	83000	103700
3	59000	69000	79000	89000	99000	109000
4	66000	76000	86000	86000	96000	106000
5	66000	75000	85000	95000	105000	115000
\.


--
-- Data for Name: branch; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.branch (branch_name, address) FROM stdin;
Center Karawaci	Jl. Taman Permata no.20. Lippo Karawaci.Binong, Curug, Tangerang Banten
Center Bintaro, Tangerang Selatan	( Shining Stars Acedemy Bintaro), Jl. Elang Blok HF1 no.15, Pondok Pucung, Pondok Aren, Bintaro, Tangerang Selatan, Banten
Center Permata Buana, Jakarta	Rukan Taman Permata Buana, Jl. Pulau Bira Raya Blok B9/23,Puri Kembangan, Jakarta barat
Kepa Duri, Kebon Jeruk	Jl. Mangga XVII Blok A-1C, Duri Kepa, Kebon Jeruk, Jakarta Barat, 11510
Center Pantai Indah Kapuk	Jl. Pantai Indah Utara 2.Ruko Arcade, unit PK.Kapuk Muara, Penjaringan, Jakarta Utara
Center Kelapa Gading, Jakarta	Jl. Raya Boulevard BaratRuko Inkopal Blok C33AKelapa Gading, Jakarta Utara 14240
Center Pondok Indah, Jakarta Selatan	Plaza 5 Pondok Indah B11, Jl. Margaguna Raya, Jakarta Selatan, 12140
Center Cibubur	Ruko Proland Ciangsana no.3Jl. Ciangsana, Gunung Putri Bogor, Jawa Barat, 16968
Center Cipinang Indah	Jl. Cendrawasih Blok A / 16, Cipinang Indah II RT.004/RW.004, Pd. Bambu, Duren Sawit, Jakarta Timur 13430
Grand Galaxy, Bekasi	Ruko Arcadia Blok BD 100,Grand Galaxy City (sebelah danau galaxy)Jl. Pulo Sirih Utama,Bekasi Jawa Barat 17148
Center Bandung	Jl. Gatot Subroto No.28,Malabar, Kec. Lengkong,Kota Bandung, Jawa Barat 40262
Center Cirebon	G-Work(lantai 2)Jalan Jend. Ahmad YaniKota Cirebon, Jawa Barat
Center Tegal	Jl. Jalak Barat no.27APekauman, Tegal Barat, Kota TegalJawa Tengah
Center Semarang	Jl. Pemuda no. 138, Gramedia Amaris lt.3,Semarang, Jawa Tengah
Pati - Jawa Tengah	Ruko Tentrem No. 7CJln. Setiabudi No.7 Pecinan, Pati KidulPati 59114, Jawa Tengah
Center Kudus	Jl. Pemuda no 57Kudus, Jawa Tengah 59312
Center Solo	Jl. Abdul Muis 23Kepatihan Kulon, Jebres,Surakarta, Jawa Tengah 57129
Center Yogyakarta	Gedung KompasJl. Suroto 4, Kotabaru YogyakartaYogyakarta 55281
Center Surabaya Barat	Jl. Alas Malang Ruko Palma Galeria RB 01/3,Surabaya, Jawa Timur 60198
Center Surabaya Timur	Pakuwon City, Ruko San Antonio N1 102, Jl. Kalisari Utara I lantai 2, Kec. Mulyorejo, Surabaya, Jawa Timur 60112
Center Malang	Jl. Telaga Bodas y2/2 (next to charis school) Tidar, KarangbesukiMalang, Jawa Timur
Center Madiun	Jl. Abdurrahman Saleh no 4Madiun, Jawa Timur 63132
Center Denpasar, Bali	Jl. Jaya Giri no. 10Dangin Puri KLOD,Denpasar Timur, Bali
Center Jimbaran, Bali	Jl. Danau Batur Raya No.6,Jimbaran, Badung Regency,Bali 80361
Center Medan	Lestari, Jl. Komp. Multatuli Indah Blok A/8, A U R, Kec. Medan Maimun, Kota Medan, Sumatera Utara 20212
Center Pekanbaru	Kompleks Pemuda City Walk Blok B No. 26, Jl. PemudaKota Pekanbaru, Riau 28291
Center Pontianak	Aneka PavilionJl. Slt. Abdurrahman No.1A, Akcaya, Kec. Pontianak Sel.Kota Pontianak, Kalimantan Barat 78113
Center Banjarmasin	Jl. Pramuka No.73A,Pemurus Luar, Kec. Banjarmasin Tim.Kota Banjarmasin, Kalimantan Selatan 70238
Center Manado	Jl. Piere Tendean, Marina Plaza B11.Manado, Sulawesi Utara 95000
\.


--
-- Data for Name: class_program; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.class_program (program_id) FROM stdin;
1
2
3
4
5
\.


--
-- Data for Name: coding_class_info; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.coding_class_info (course_name, course_materials, course_audience, course_duration, course_enrollment, course_tuition, program_id) FROM stdin;
Introduction to Coding	Ditujukan untuk mereka yang belum memiliki pengalaman programming sebelumnya.Memperkenalkan konsep dasar programming Menggunakan visual programming languages dan online platforms. Mengerjakan simple software-hardware projects dengan robot Sphero, BB8, Dash.	SD	90 mins â€“ 1x seminggu	150000	350000	1
Coding for SD (Beginner)	Perkenalan konsep coding, Computational Thinking, dan computer science: menggunakan online platforms popular: Tynker, Kodu, CodeMonkey, Blockly, Scratch, Kodable memecahkan online puzzle dengan programming membuat animasi dan video game membuat custom Minecraft modding latihan computational thinking untuk kompetisi BebrasProgramming dengan robots: memprogram Sphero, BB-8, Dash robots mengontrol robot with block programming berkerja sama dalam group memecahkan masalah dengan programming	SD Grade 1-3	1-2x seminggu	150000	350000	1
Coding for SD (Advance)	Memperdalam konsep coding, Computational Thinking, dan computer science: menggunakan online platforms popular: Tynker, Scratch, CodeMonkey, MIT App Inventor, Grok Learning membuat animasi, video game, web pages, mobile apps membuat custom Minecraft mod latihan computational thinking untuk kompetisi Bebras perkenalan ke dasar text-based coding languages (HTML, Python, Java, C++, C, Javascript) dan konsep Artificial Intelligent â€“ Maching Learning.Programming dengan hardware: memprogram Sphero, BB-8, Dash, Cozmo robots dan circuit hardware Microbit, Makey-Makey mengontrol robot with block programming berkerja sama dalam group memecahkan masalah dengan programming	SD Grade 4-6	1-2x seminggu	150000	350000	1
Coding for SMP	Memperdalam konsep coding, Computational Thinking, dan computer science untuk level SMP: perkenalan dasar coding dengan menggunakan block programming dan dilanjutkan ke text-based coding languages (HTML, Python, Java, C++, C, Javascript) membuat animasi, websites, mobile apps, games dengan menggunakan programming latihan computational thinking untuk kompetisi Bebras perkenalan konsep Artificial Intelligent â€“ Maching LearningProgramming dengan hardware: memprogram robot MakeBot, UB Kit, Dash implementasi coding ke circuit hardware Microbit, Makey-Makey, Arduino	SMP	1-2x seminggu	150000	475000	1
Coding for SMA	Perkenalan ke programming dan dilanjutkan dengan eksplorasi coding di area berikut: Game Development Web Development App Development Computer Science, Algorithm, and Math in Coding Data, Database and AI Intro for SMUSetelah menyelesaikan kelas perkenalan tersebut, murid dapat memilih spesialisasi di bidang yang lebih spesifik: Android App Development Data Science AI & Machine Learning Android App Development iOS App Development Python Programming Algebra, Algorithm & Programming	SMA	90 Min1-2x Seminggu	150000	500000	1
\.


--
-- Data for Name: kiddo_stem_program; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.kiddo_stem_program (class_name, age, program_id) FROM stdin;
discoverer	TK - SD 2	4
explorer	SD 3 - SD 5	4
investigator	SD 5 - SMP	4
\.


--
-- Data for Name: kinder_coding_package; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.kinder_coding_package (package_name, membership_length, total_session, discount, program_id) FROM stdin;
Monthly Regular	monthly	4	t	3
Green Package	max 3 months	10	t	3
\.


--
-- Data for Name: non_class_program; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.non_class_program (program_id) FROM stdin;
6
7
8
\.


--
-- Data for Name: paud_teacher_training; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.paud_teacher_training (training_id, program_id, province, city, number_of_facilitators) FROM stdin;
paud1	6	Jakarta	Kota Jakarta Utara	12
paud2	6	Jakarta	Kota Jakarta Pusat	9
paud3	6	Jakarta	Kota Jakarta Timur	8
paud4	6	Jakarta	Kota Jakarta Barat	12
paud5	6	Jakarta	Kota Jakarta Selatan	8
paud6	6	Jawa Barat	Kota Depok	2
paud7	6	Jawa Barat	Kota Bogor	4
paud8	6	Jawa Barat	Kab Bogor	2
paud9	6	Jawa Barat	Kota Bekasi	4
paud10	6	Jawa Barat	Kab Bekasi	4
paud11	6	Banten	Kota Tangerang	6
paud12	6	Banten	Kota Tangerang Selatan	10
paud13	6	Banten	Kabupaten Tangerang	10
paud14	6	Jawa Tengah	Kota Tegal	4
paud15	6	Jawa Tengah	Kabupaten Brebes	2
paud16	6	Jawa Timur	Kota Surabaya	6
paud17	6	Jawa Timur	Kabupaten Sidoarjo	4
paud18	6	Jawa Timur	Kabupaten Gresik	2
paud19	6	Jawa Timur	Kota Malang	2
\.


--
-- Data for Name: program; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.program (program_id, program_name) FROM stdin;
1	Coding & AI Class
2	Thematic Class
3	KinderCoding
4	KiddoSTEM
5	Webinar dan Workshop
6	Pelatihan Guru PAUD
7	Pelatihan Guru SD SMP
8	Kiddo Press
\.


--
-- Data for Name: program_available_at; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.program_available_at (program_id, branch_name) FROM stdin;
1	Center Karawaci
1	Center Bintaro, Tangerang Selatan
1	Center Permata Buana, Jakarta
1	Kepa Duri, Kebon Jeruk
1	Center Pantai Indah Kapuk
1	Center Kelapa Gading, Jakarta
1	Center Pondok Indah, Jakarta Selatan
1	Center Cibubur
1	Center Cipinang Indah
1	Grand Galaxy, Bekasi
1	Center Bandung
1	Center Cirebon
1	Center Tegal
1	Center Semarang
1	Pati - Jawa Tengah
1	Center Kudus
1	Center Solo
1	Center Yogyakarta
1	Center Surabaya Barat
1	Center Surabaya Timur
1	Center Malang
1	Center Madiun
1	Center Denpasar, Bali
1	Center Jimbaran, Bali
1	Center Medan
1	Center Pekanbaru
1	Center Pontianak
1	Center Banjarmasin
1	Center Manado
2	Center Karawaci
2	Center Bintaro, Tangerang Selatan
2	Center Permata Buana, Jakarta
2	Kepa Duri, Kebon Jeruk
2	Center Pantai Indah Kapuk
2	Center Kelapa Gading, Jakarta
2	Center Pondok Indah, Jakarta Selatan
2	Center Cibubur
2	Center Cipinang Indah
2	Grand Galaxy, Bekasi
2	Center Bandung
2	Center Cirebon
2	Center Tegal
2	Center Semarang
2	Pati - Jawa Tengah
2	Center Kudus
2	Center Solo
2	Center Yogyakarta
2	Center Surabaya Barat
2	Center Surabaya Timur
2	Center Malang
2	Center Madiun
2	Center Denpasar, Bali
2	Center Jimbaran, Bali
2	Center Medan
2	Center Pekanbaru
2	Center Pontianak
2	Center Banjarmasin
2	Center Manado
3	Center Karawaci
3	Center Bintaro, Tangerang Selatan
3	Center Permata Buana, Jakarta
3	Kepa Duri, Kebon Jeruk
3	Center Pantai Indah Kapuk
3	Center Kelapa Gading, Jakarta
3	Center Pondok Indah, Jakarta Selatan
3	Center Cibubur
3	Center Cipinang Indah
3	Grand Galaxy, Bekasi
3	Center Bandung
3	Center Cirebon
3	Center Tegal
3	Center Semarang
3	Pati - Jawa Tengah
3	Center Kudus
3	Center Solo
3	Center Yogyakarta
3	Center Surabaya Barat
3	Center Surabaya Timur
3	Center Malang
3	Center Madiun
3	Center Denpasar, Bali
3	Center Jimbaran, Bali
3	Center Medan
3	Center Pekanbaru
3	Center Pontianak
3	Center Banjarmasin
3	Center Manado
4	Center Karawaci
4	Center Bintaro, Tangerang Selatan
4	Center Permata Buana, Jakarta
4	Kepa Duri, Kebon Jeruk
4	Center Pantai Indah Kapuk
4	Center Kelapa Gading, Jakarta
4	Center Pondok Indah, Jakarta Selatan
4	Center Cibubur
4	Center Cipinang Indah
4	Grand Galaxy, Bekasi
4	Center Bandung
4	Center Cirebon
4	Center Tegal
4	Center Semarang
4	Pati - Jawa Tengah
4	Center Kudus
4	Center Solo
4	Center Yogyakarta
4	Center Surabaya Barat
4	Center Surabaya Timur
4	Center Malang
4	Center Madiun
4	Center Denpasar, Bali
4	Center Jimbaran, Bali
4	Center Medan
4	Center Pekanbaru
4	Center Pontianak
4	Center Banjarmasin
4	Center Manado
5	Center Karawaci
5	Center Bintaro, Tangerang Selatan
5	Center Permata Buana, Jakarta
5	Kepa Duri, Kebon Jeruk
5	Center Pantai Indah Kapuk
5	Center Kelapa Gading, Jakarta
5	Center Pondok Indah, Jakarta Selatan
5	Center Cibubur
5	Center Cipinang Indah
5	Grand Galaxy, Bekasi
5	Center Bandung
5	Center Cirebon
5	Center Tegal
5	Center Semarang
5	Pati - Jawa Tengah
5	Center Kudus
5	Center Solo
5	Center Yogyakarta
5	Center Surabaya Barat
5	Center Surabaya Timur
5	Center Malang
5	Center Madiun
5	Center Denpasar, Bali
5	Center Jimbaran, Bali
5	Center Medan
5	Center Pekanbaru
5	Center Pontianak
5	Center Banjarmasin
5	Center Manado
6	Center Karawaci
6	Center Bintaro, Tangerang Selatan
6	Center Permata Buana, Jakarta
6	Kepa Duri, Kebon Jeruk
6	Center Pantai Indah Kapuk
6	Center Kelapa Gading, Jakarta
6	Center Pondok Indah, Jakarta Selatan
6	Center Cibubur
6	Center Cipinang Indah
6	Grand Galaxy, Bekasi
6	Center Bandung
6	Center Cirebon
6	Center Tegal
6	Center Semarang
6	Pati - Jawa Tengah
6	Center Kudus
6	Center Solo
6	Center Yogyakarta
6	Center Surabaya Barat
6	Center Surabaya Timur
6	Center Malang
6	Center Madiun
6	Center Denpasar, Bali
6	Center Jimbaran, Bali
6	Center Medan
6	Center Pekanbaru
6	Center Pontianak
6	Center Banjarmasin
6	Center Manado
7	Center Karawaci
7	Center Bintaro, Tangerang Selatan
7	Center Permata Buana, Jakarta
7	Kepa Duri, Kebon Jeruk
7	Center Pantai Indah Kapuk
7	Center Kelapa Gading, Jakarta
7	Center Pondok Indah, Jakarta Selatan
7	Center Cibubur
7	Center Cipinang Indah
7	Grand Galaxy, Bekasi
7	Center Bandung
7	Center Cirebon
7	Center Tegal
7	Center Semarang
7	Pati - Jawa Tengah
7	Center Kudus
7	Center Solo
7	Center Yogyakarta
7	Center Surabaya Barat
7	Center Surabaya Timur
7	Center Malang
7	Center Madiun
7	Center Denpasar, Bali
7	Center Jimbaran, Bali
7	Center Medan
7	Center Pekanbaru
7	Center Pontianak
7	Center Banjarmasin
7	Center Manado
8	Center Karawaci
8	Center Bintaro, Tangerang Selatan
8	Center Permata Buana, Jakarta
8	Kepa Duri, Kebon Jeruk
8	Center Pantai Indah Kapuk
8	Center Kelapa Gading, Jakarta
8	Center Pondok Indah, Jakarta Selatan
8	Center Cibubur
8	Center Cipinang Indah
8	Grand Galaxy, Bekasi
8	Center Bandung
8	Center Cirebon
8	Center Tegal
8	Center Semarang
8	Pati - Jawa Tengah
8	Center Kudus
8	Center Solo
8	Center Yogyakarta
8	Center Surabaya Barat
8	Center Surabaya Timur
8	Center Malang
8	Center Madiun
8	Center Denpasar, Bali
8	Center Jimbaran, Bali
8	Center Medan
8	Center Pekanbaru
8	Center Pontianak
8	Center Banjarmasin
8	Center Manado
\.


--
-- Data for Name: school_teacher_training; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.school_teacher_training (training_id, program_id, province, city, class_name, target_audience, lower_bound_price, upper_bound_price, training_branch) FROM stdin;
school1	7	Banten	Kota Serang	SD Kota Serang 4	22	3500000	4500000	UPT Dinas Pendidikan Kec. Cipocok
school2	7	Banten	Kab. Tangerang	SMA/K Kab Tangerang 24	25	3500000	4500000	SMKS PGRI 1 BALARAJA
school3	7	Banten	Kab. Tangerang	SMA/K Kab Tangerang 25	25	3500000	4500000	SMKS Penerbangan Dirgantara
school4	7	Banten	Kab. Tangerang	SD Kab Tangerang 4	27	3000000	4875000	SDN BUARANJATI I
school5	7	Banten	Kab. Tangerang	SD Kab Tangerang 5	27	3000000	4875000	SDN PASAR KEMIS 3
school6	7	Banten	Kab. Tangerang	SD Kab Tangerang 6	27	3000000	4875000	SDN SUKAMULYA I
school7	7	Banten	Kab. Tangerang	SD Kab Tangerang 7	26	3000000	4875000	SDN PASAR KEMIS 3
school8	7	Banten	Kab. Tangerang	SD Kab Tangerang 8	26	3000000	4875000	SD PERMATA INSANI ISLAMIC SCHOOL
school9	7	Banten	Kab. Tangerang	SD Kab Tangerang 9	26	3000000	4875000	SDN CIKUPA 02
school10	7	Banten	Kota Tangerang	SD Kota Tangerang 4	31	2580000	4875000	SDN DAAN MOGOT 3
school11	7	Banten	Kota Tangerang	SD Kota Tangerang 5	31	2580000	4875000	SDN KETAPANG
school12	7	Banten	Kota Tangerang	SD Kota Tangerang 6	31	2580000	4875000	SDN PENINGGILAN 5
school13	7	Jawa Barat	Kab. Bandung	SD Kab Bandung 4	32	2750000	4540000	SDN MARGAHAYU 03
school14	7	Jawa Barat	Kab. Bandung	SD Kab Bandung 5	26	2750000	4540000	SDN Soreang 01
school15	7	Jawa Barat	Kab. Bandung	SD Kab Bandung 6	31	2750000	4540000	SDN KOTA BARU
school16	7	Jawa Barat	Kab. Bandung	SD Kab Bandung 7	32	2750000	4540000	SDN MANGGAHANG 02
school17	7	Jawa Barat	Kab. Bandung	SD Kab Bandung 8	25	2750000	4540000	SDN Cipagalo 01
school18	7	Jawa Barat	Kab. Bandung	SD Kab Bandung 9	32	2750000	4540000	SDN Cicalengka 07
school19	7	Jawa Barat	Kab. Bekasi	SD Kab Bekasi 1	31	2450000	4540000	SDN BAHAGIA 5
\.


--
-- Data for Name: student; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.student (student_id, student_name, branch_name) FROM stdin;
\.


--
-- Data for Name: student_program; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.student_program (student_id, program_id) FROM stdin;
\.


--
-- Data for Name: thematic_class; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.thematic_class (topic, topic_description, program_id) FROM stdin;
Roblox Game Creation with Code Kingdoms	Jika kiddos suka bermain Roblox, di kelas ini kiddos TIDAK hanya bermain, tapi belajar MEMBUAT berbagai game Roblox dengan coding. Kiddos akan menggunakan Roblox Studio dan CodeKingdom untuk membuat game dan belajar konsep Object-Oriented Visual Programming. Dengan opsi dan tutorial yang menarik untuk berbagai jenis project, kiddos dapat belajar bahasa pemograman Lua dengan model drag & drop (cocok untuk pemula) atau dengan model text based programming (untuk intermediate).	2
Minecraft Coding Adventure in Minecraft Edu	Di kelas ini kiddos akan menggunakan platform Minecraft Education, yang khusus didesain khusus untuk mendukung proses belajar berbagai topik. Kiddos akan belajar konsep dasar coding dengan block programming di dunia Minecraft dan menerapkan ke beberapa topik menarik seperti: Artificial Intelligence untuk mencegah kebakaran hutan, Planets dan Solar System, dan Cybersafe. Di akhir sesi, kiddos akan membuat project dunia Minecraft untuk mencegah kepunahan orangutan.	2
AI & Machine Learning Intro for kids	Di kelas ini kiddos mendapat perkenalan tentang konsep Artificial Intelligence dan Machine Learning yang sesuai untuk level SD. Kiddos menggunakan visual programming platform PictoBlox (drag-and-drop code blocks) yang mirip dengan Scratch namun dengan tambahan ekstensi program yang menggunakan teknologi AI seperti computer vision, natural language processing (NPL), dan machine learning. Kiddos memahami konsep 5 Big Ideas of AI dan menerapkannya melalui berbagai project menarik seperti: face recognition, speech recognition, image recognition.	2
After Scratch : Make Mobile Apps with MIT App Inventor	Kelas cocok untuk kiddos yang telah belajar dan menguasai Scratch. Di kelas ini kiddos belajar membuat mobile apps di Android device, dengan menggunakan MIT App Inventor platform, dengan visual block programming. Kiddos belajar membuat apps dari awal sampai akhir dengan menggunakan berbagai sensor yang tersedia di handphone, misal: gerakan, tulisan, gambar, suara. Hasil aplikasi bisa diinstall di Android phone masing-masing.	2
Make AI Powered Apps with MIT App Inventor	Kelas ini menggabungkan dua topik yang seru: mobile apps dan AI. Kiddos akan mendapatkan perkenalan untuk Machine Learning yang merupakan salah satu teknologi dari Artificial Intelligence AI, memberikan data untuk melatih sistem Machine Learning menjadi cerdas untuk menjalankan tugas yang diinginkan. Setelah itu kiddos melakukan programming di platform MIT App Inventor untuk membuat aplikasi di handphone Android yang menggunakan teknologi AI tersebut. Hasil aplikasi bisa diinstall di Android phone masing-masing.	2
After Scratch : Text Programming with Python	Di kelas ini kiddos belajar bahasa pemrograman Python yang banyak digunakan untuk membuat berbagai project software. Dengan syntax yang lebih sederhana, Python mudah dipelajari saat kiddos mulai menggunakan text-based coding.Kiddos belajar konsep dasar coding seperti input, output, loops, conditional, function, object, list, dan menerapkan konsep tersebut untuk memecahkan berbagai permasalahan. Kiddos membuat program yang menerapkan konsep tersebut, seperti game, chat bot, encryption, dan algorithm solver.	2
STEM and Hardware Programming with Microbit	Di kelas ini, kiddos akan belajar tentang integrasi antara software dan hardware. Programming software menggunakan MakeBlock atau Python dan hardware menggunakan komputer mini Microbit dan berbagai tambahan sensor dan komponen. Dengan praktek langsung, kiddos akan memahami pemrograman dan prinsip-prinsip elektronika yang menyertainya. Di setiap sesi, kiddos membuat berbagai project otomatisasi yang biasa dijumpai dalam peralatan elektronika sehari-hari, seperti lampu otomatis, pemindah barang, pendeteksi suhu, dan proyek menarik lainnya. Note: perlangkapan Microbit dan komponen akan disediakan oleh KodeKiddo tanpa biaya tambahan bagi murid.	2
Game Development with Scratch	Di kelas ini kiddos belajar lebih dalam tentang Scratch dan mempelajari bagaimana cara membuat berbagai jenis games dalam Scratch. Kiddos konsep "“ konsepl pemrograman yang lebih sulit serta teknik "“ teknik dalam Scratch untuk membuat jenis games yang memiliki lebih banyak fitur dan lebih sulit dibuat.	2
Web Development with HTML, CSS, and Javascript	Di kelas ini kiddos belajar proses "“ proses serta cara untuk mengembangkan sebuah website dari 0. Kiddos mempelajari sebuah bahasa pemrograman baru, yaitu HTML, yang digunakan untuk membuat struktur dari sebuah website, CSS digunakan untuk mengubah tampilan dari sebuah website, dan Javascript untuk membuat sebuah website menjadi interaktif.	2
Introduction to Database with SQL	SQL and Database Intro adalah kelas yang cocok untuk kiddos yang ingin mengenal data dan cara mengolahnya menggunakan perintah yang disebut query. Di kelas ini Kiddo akan belajar mengenai query-query SQL untuk mengolah data seperti select, filtering, grouping, sorting, hingga join antar data.	2
Cybersecurity Fundamentals	Pada kelas Cybersecurity, kiddo akan diberikan pemahaman tentang konsep-konsep dasar keamanan informasi dan teknologi. Siswa diharapkan dapat mengidentifikasi potensi risiko keamanan, mengimplementasikan praktik-praktik keamanan yang efektif, dan memahami metode-metode untuk melindungi data dan sistem dari ancaman siber. Siswa juga diberikan tentang potensi kejahatan-kejahatan didunia maya, dikenalkan tentang encryption, decryption, dan mempraktikkan bagaimana cara membuat password yang aman.	2
Digital Citizens & Cybersecurity Exploration	Kiddo akan belajar tentang berbagai materi tentang keamanan berinternet, perlindungan password, bahaya phising, privasi data pada sosial media dan masih banyak lagi. Diakhir kelas, kiddo akan mengerjakan project cybersecurity menggunakan scratch programming.	2
Introduction to Competitive Programming (C++)	Di kelas ini KodeKiddo berkolaborasi dengan TOKI untuk memperkenalkan Competitive Programming untuk kiddos SMP "“ SMA. Kelas ini sangat cocok untuk kiddos yang telah memiliki dasar coding dan matematika yang kuat. Kiddos diberikan pemahaman algoritma dengan beberapa soal Computational Thinking dan matematika dari kontes Bebras dan Competitive Programming seperti Olimpiade Sains "“ Infomatika. Selanjutnya kiddos akan mempelajari bahasa pemrograman C++ untuk membuat program yang dapat memecahkan soal matematika tersebut.	2
\.


--
-- Data for Name: webinar; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.webinar (webinar_name, webinar_date, program_id) FROM stdin;
Coding & AI di Sekolah	2023-05-27	5
Computational Thinking with Bebras	2022-10-23	5
Day of AI	2022-01-15	5
Engineering for the Week â€“ Workshop for Educators	2021-01-17	5
WAICY 2021 â€“ Workshop #2	2021-09-26	5
KinderCoding	2021-09-19	5
WAICY 2021 â€“ Workshop #1	2021-01-29	5
Imagine Cup Jr. â€“ Sharing Session	2021-04-04	5
Design Thinking for Social Innovation	2021-02-21	5
KiddoFair	2020-11-01	5
Train your Computational Thinking with Bebras	2020-11-08	5
Snap! The Next Level after Scratch	2020-10-04	5
Webinar for Parents : AI for Kids	2020-08-08	5
Pengenalan AI untuk Anak-Anak	2020-07-19	5
Our Career and College Journey in Computer Science	2020-07-11	5
Intro to Coding	2020-07-04	5
Coding and Digital Citizen with Stella Maris	2020-06-25	5
Mendampingi Generasi Milenial Jago Coding	2020-06-13	5
Digital Citizenship and CyberSecurity	2020-05-25	5
Making Apps with MIT App Inventor and Android Studio	2020-05-21	5
Coding for Interactive Presentation (for Educators)	2020-05-15	5
Minecraft Windows 10 Mods & Education Worlds	2020-05-10	5
\.


--
-- Data for Name: zone; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.zone (zone_id, details) FROM stdin;
1	Jawa Barat, Jawa Tengah, Jawa Timur, Daerah Istimewa Yogyakarta, DKI Jakarta, dan Banten.
2	Bali, Nusa Tenggara Barat, Lampung (kecuali (i) Pesisir Barat), dan Sumatera Selatan.
3	Bengkulu, Jambi, Bangka Belitung, Sumatera Barat (kecuali (i) Kepulauan Mentawai dan (ii) Solok Selatan), Riau (kecuali (i) Bengkalis, (ii) Kepulauan Meranti, (iii) , Sumatera Utara (kecuali (i) Nias, (ii) Nias Selatan, (iii) Nias Utara, (iv) Nias Barat), Sulawesi Selatan, Sulawesi Utara (kecuali (i) Kepulauan Sangihe, dan (ii) Kepulauan Talaud), Sulawesi Tengah (kecuali (i) Banggai Kepulauan, (ii) Tojo Una-Una, (iii) Sigi, dan (iv) Banggai Laut), Sulawesi Barat, Sulawesi Tenggara (kecuali (i) Konawe, (ii) Bombana, dan (iii) Konawe Kepulauan), dan Gorontalo.
4	Bengkulu, Jambi, Bangka Belitung, Sumatera Barat (kecuali (i) Kepulauan Mentawai dan (ii) Solok Selatan), Riau (kecuali (i) Bengkalis, (ii) Kepulauan Meranti, (iii) , Sumatera Utara (kecuali (i) Nias, (ii) Nias Selatan, (iii) Nias Utara, (iv) Nias Barat), Sulawesi Selatan, Sulawesi Utara (kecuali (i) Kepulauan Sangihe, dan (ii) Kepulauan Talaud), Sulawesi Tengah (kecuali (i) Banggai Kepulauan, (ii) Tojo Una-Una, (iii) Sigi, dan (iv) Banggai Laut), Sulawesi Barat, Sulawesi Tenggara (kecuali (i) Konawe, (ii) Bombana, dan (iii) Konawe Kepulauan), dan Gorontalo.
5	(1) Aceh Besar, (2) Aceh Singkil, (3) Nias, (4) Nias Selatan, (5) Nias Utara, (6) Nias Barat, (7) Kep. Mentawai, (8) Solok Selatan, (9) Pesisir Barat, (10) Sumba Barat, (11) Sumba Timur, (12) Timor Tengah Selatan, (13) Belu, (14) Alor, (15) Lembata, (16) Ende, (17) Manggarai, (18) Rote Ndao, (19) Manggarai Barat, (20) Sumba Tengah, (21) Sumba Barat Daya, (22) Nagakeo, (23) Manggarai Timur, (24) Sabu Raijua, (25) Malaka, (26) Banggai Kepulauan, (27) Tojo Una-Una, (28) Sigi, (29) Banggai Laut, (30) Konawe, (31) Bombana, (32) Konawe Kepulauan, (33) Bengkalis, (34) Kepulauan Meranti, (35) Karimun, (36) Kepulauan Anambas, (37) Natuna, (38) Kapuas Hulu, (39) Mahakam Hulu, (40) Sanggau, (41) Nunukan, (42) Malinau, (43) Berau, (44) Kepulauan Sangihe, dan (45) Kepulauan Talaud.
6	Maluku, Maluku Utara, Papua, Papua Barat, Papua Barat Daya, Papua Selatan, Papua Tengah, dan Papua Pegunungan.
\.


--
-- Name: book_writer book_writer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book_writer
    ADD CONSTRAINT book_writer_pkey PRIMARY KEY (book_id, writer_name);


--
-- Name: book_zone book_zone_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book_zone
    ADD CONSTRAINT book_zone_pkey PRIMARY KEY (book_id, zone_id);


--
-- Name: books books_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.books
    ADD CONSTRAINT books_pkey PRIMARY KEY (book_id);


--
-- Name: books_price books_price_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.books_price
    ADD CONSTRAINT books_price_pkey PRIMARY KEY (book_id);


--
-- Name: branch branch_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.branch
    ADD CONSTRAINT branch_pkey PRIMARY KEY (branch_name);


--
-- Name: class_program class_program_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.class_program
    ADD CONSTRAINT class_program_pkey PRIMARY KEY (program_id);


--
-- Name: coding_class_info coding_class_info_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.coding_class_info
    ADD CONSTRAINT coding_class_info_pkey PRIMARY KEY (course_name);


--
-- Name: kiddo_stem_program kiddo_stem_program_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kiddo_stem_program
    ADD CONSTRAINT kiddo_stem_program_pkey PRIMARY KEY (class_name);


--
-- Name: kinder_coding_package kinder_coding_package_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kinder_coding_package
    ADD CONSTRAINT kinder_coding_package_pkey PRIMARY KEY (package_name);


--
-- Name: non_class_program non_class_program_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.non_class_program
    ADD CONSTRAINT non_class_program_pkey PRIMARY KEY (program_id);


--
-- Name: paud_teacher_training paud_teacher_training_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paud_teacher_training
    ADD CONSTRAINT paud_teacher_training_pkey PRIMARY KEY (training_id);


--
-- Name: program_available_at program_available_at_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.program_available_at
    ADD CONSTRAINT program_available_at_pkey PRIMARY KEY (program_id, branch_name);


--
-- Name: program program_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.program
    ADD CONSTRAINT program_pkey PRIMARY KEY (program_id);


--
-- Name: school_teacher_training school_teacher_training_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.school_teacher_training
    ADD CONSTRAINT school_teacher_training_pkey PRIMARY KEY (training_id);


--
-- Name: student student_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_pkey PRIMARY KEY (student_id);


--
-- Name: student_program student_program_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_program
    ADD CONSTRAINT student_program_pkey PRIMARY KEY (student_id, program_id);


--
-- Name: thematic_class thematic_class_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.thematic_class
    ADD CONSTRAINT thematic_class_pkey PRIMARY KEY (topic);


--
-- Name: webinar webinar_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.webinar
    ADD CONSTRAINT webinar_pkey PRIMARY KEY (webinar_name);


--
-- Name: zone zone_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.zone
    ADD CONSTRAINT zone_pkey PRIMARY KEY (zone_id);


--
-- Name: book_writer book_writer_book_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book_writer
    ADD CONSTRAINT book_writer_book_id_fkey FOREIGN KEY (book_id) REFERENCES public.books(book_id);


--
-- Name: book_zone book_zone_book_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book_zone
    ADD CONSTRAINT book_zone_book_id_fkey FOREIGN KEY (book_id) REFERENCES public.books(book_id);


--
-- Name: book_zone book_zone_zone_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book_zone
    ADD CONSTRAINT book_zone_zone_id_fkey FOREIGN KEY (zone_id) REFERENCES public.zone(zone_id);


--
-- Name: books_price books_price_book_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.books_price
    ADD CONSTRAINT books_price_book_id_fkey FOREIGN KEY (book_id) REFERENCES public.books(book_id);


--
-- Name: books books_program_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.books
    ADD CONSTRAINT books_program_id_fkey FOREIGN KEY (program_id) REFERENCES public.non_class_program(program_id);


--
-- Name: class_program class_program_program_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.class_program
    ADD CONSTRAINT class_program_program_id_fkey FOREIGN KEY (program_id) REFERENCES public.program(program_id);


--
-- Name: coding_class_info coding_class_info_program_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.coding_class_info
    ADD CONSTRAINT coding_class_info_program_id_fkey FOREIGN KEY (program_id) REFERENCES public.class_program(program_id);


--
-- Name: kiddo_stem_program kiddo_stem_program_program_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kiddo_stem_program
    ADD CONSTRAINT kiddo_stem_program_program_id_fkey FOREIGN KEY (program_id) REFERENCES public.class_program(program_id);


--
-- Name: kinder_coding_package kinder_coding_package_program_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kinder_coding_package
    ADD CONSTRAINT kinder_coding_package_program_id_fkey FOREIGN KEY (program_id) REFERENCES public.class_program(program_id);


--
-- Name: non_class_program non_class_program_program_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.non_class_program
    ADD CONSTRAINT non_class_program_program_id_fkey FOREIGN KEY (program_id) REFERENCES public.program(program_id);


--
-- Name: paud_teacher_training paud_teacher_training_program_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paud_teacher_training
    ADD CONSTRAINT paud_teacher_training_program_id_fkey FOREIGN KEY (program_id) REFERENCES public.non_class_program(program_id);


--
-- Name: program_available_at program_available_at_branch_name_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.program_available_at
    ADD CONSTRAINT program_available_at_branch_name_fkey FOREIGN KEY (branch_name) REFERENCES public.branch(branch_name);


--
-- Name: program_available_at program_available_at_program_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.program_available_at
    ADD CONSTRAINT program_available_at_program_id_fkey FOREIGN KEY (program_id) REFERENCES public.program(program_id);


--
-- Name: school_teacher_training school_teacher_training_program_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.school_teacher_training
    ADD CONSTRAINT school_teacher_training_program_id_fkey FOREIGN KEY (program_id) REFERENCES public.non_class_program(program_id);


--
-- Name: student student_branch_name_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_branch_name_fkey FOREIGN KEY (branch_name) REFERENCES public.branch(branch_name);


--
-- Name: student_program student_program_program_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_program
    ADD CONSTRAINT student_program_program_id_fkey FOREIGN KEY (program_id) REFERENCES public.program(program_id);


--
-- Name: student_program student_program_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_program
    ADD CONSTRAINT student_program_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.student(student_id);


--
-- Name: thematic_class thematic_class_program_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.thematic_class
    ADD CONSTRAINT thematic_class_program_id_fkey FOREIGN KEY (program_id) REFERENCES public.class_program(program_id);


--
-- Name: webinar webinar_program_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.webinar
    ADD CONSTRAINT webinar_program_id_fkey FOREIGN KEY (program_id) REFERENCES public.class_program(program_id);


--
-- PostgreSQL database dump complete
--

