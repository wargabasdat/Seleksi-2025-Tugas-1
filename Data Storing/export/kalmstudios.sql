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
-- Name: categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categories (
    category_id integer NOT NULL,
    category_name character varying(20) NOT NULL
);


ALTER TABLE public.categories OWNER TO postgres;

--
-- Name: class_equipment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.class_equipment (
    class_id character varying(50) NOT NULL,
    equipment_id integer NOT NULL
);


ALTER TABLE public.class_equipment OWNER TO postgres;

--
-- Name: classes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.classes (
    class_id character varying(50) NOT NULL,
    name character varying(60) NOT NULL,
    category_id integer NOT NULL,
    duration integer,
    difficulty_level character varying(20),
    location character varying(30),
    about_class_description text
);


ALTER TABLE public.classes OWNER TO postgres;

--
-- Name: equipment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.equipment (
    equipment_id integer NOT NULL,
    equipment_name character varying(20) NOT NULL
);


ALTER TABLE public.equipment OWNER TO postgres;

--
-- Name: equipment_equipment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.equipment_equipment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.equipment_equipment_id_seq OWNER TO postgres;

--
-- Name: equipment_equipment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.equipment_equipment_id_seq OWNED BY public.equipment.equipment_id;


--
-- Name: instructors; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.instructors (
    instructor_id character varying(20) NOT NULL,
    name character varying(30) NOT NULL,
    role character varying(30)
);


ALTER TABLE public.instructors OWNER TO postgres;

--
-- Name: related_classes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.related_classes (
    related_order integer NOT NULL,
    main_class_id character varying(50) NOT NULL,
    title character varying(60),
    stars_rating numeric(2,1),
    duration integer,
    difficulty_level character varying(20),
    description text
);


ALTER TABLE public.related_classes OWNER TO postgres;

--
-- Name: reviews; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reviews (
    review_order integer NOT NULL,
    class_id character varying(50) NOT NULL,
    instructor_reviewed character varying(30),
    review_text text,
    review_location character varying(30),
    stars_rating integer,
    CONSTRAINT reviews_stars_rating_check CHECK (((stars_rating >= 1) AND (stars_rating <= 5)))
);


ALTER TABLE public.reviews OWNER TO postgres;

--
-- Name: schedules; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.schedules (
    schedule_id character varying(20) NOT NULL,
    class_id character varying(50) NOT NULL,
    instructor_id character varying(20) NOT NULL,
    date date NOT NULL,
    start_time time without time zone,
    duration integer,
    location character varying(50)
);


ALTER TABLE public.schedules OWNER TO postgres;

--
-- Name: equipment equipment_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.equipment ALTER COLUMN equipment_id SET DEFAULT nextval('public.equipment_equipment_id_seq'::regclass);


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categories (category_id, category_name) FROM stdin;
1	Yoga
2	Prenatal Yoga
3	Mat Pilates
4	Private Pilates
5	Group Reformer
\.


--
-- Data for Name: class_equipment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.class_equipment (class_id, equipment_id) FROM stdin;
021ec006-09cd-4db7-bc7d-46eec8e047fb	1
021ec006-09cd-4db7-bc7d-46eec8e047fb	4
021ec006-09cd-4db7-bc7d-46eec8e047fb	3
894cc2bd-7a1e-4ebc-bdeb-76d15107cd95	2
894cc2bd-7a1e-4ebc-bdeb-76d15107cd95	3
894cc2bd-7a1e-4ebc-bdeb-76d15107cd95	4
94f3d4ac-910b-4181-b947-827bfff13164	1
94f3d4ac-910b-4181-b947-827bfff13164	4
94f3d4ac-910b-4181-b947-827bfff13164	3
ec2c6dc1-497f-4392-9897-c82b6e39de02	2
ec2c6dc1-497f-4392-9897-c82b6e39de02	3
ec2c6dc1-497f-4392-9897-c82b6e39de02	4
d019bb2f-b4d6-4948-b797-fa2fd87ed98c	2
d019bb2f-b4d6-4948-b797-fa2fd87ed98c	4
d019bb2f-b4d6-4948-b797-fa2fd87ed98c	3
02457d6e-294e-4a24-89fc-edaa0f1f1224	2
02457d6e-294e-4a24-89fc-edaa0f1f1224	4
02457d6e-294e-4a24-89fc-edaa0f1f1224	3
2b496fe5-4617-4b66-a033-9643167406f0	2
2b496fe5-4617-4b66-a033-9643167406f0	3
2b496fe5-4617-4b66-a033-9643167406f0	4
e343282f-b803-4f8d-9552-00d555798b8c	2
e343282f-b803-4f8d-9552-00d555798b8c	4
e343282f-b803-4f8d-9552-00d555798b8c	3
09d8a770-2d06-40b3-a019-1bea981fc16a	2
09d8a770-2d06-40b3-a019-1bea981fc16a	4
09d8a770-2d06-40b3-a019-1bea981fc16a	3
af761997-f321-4682-886a-6e745be717ed	1
af761997-f321-4682-886a-6e745be717ed	4
af761997-f321-4682-886a-6e745be717ed	3
9fa780f9-d41e-419b-94dc-11b45a1a20ce	3
9fa780f9-d41e-419b-94dc-11b45a1a20ce	4
d22df6a4-ce74-4164-9fde-6e4981cf5fa7	2
d22df6a4-ce74-4164-9fde-6e4981cf5fa7	3
d22df6a4-ce74-4164-9fde-6e4981cf5fa7	4
f1b6c72c-1765-4be7-8db8-2b5c3ddcb4a9	2
f1b6c72c-1765-4be7-8db8-2b5c3ddcb4a9	3
f1b6c72c-1765-4be7-8db8-2b5c3ddcb4a9	4
7ed0df06-2eeb-4496-947e-14890ca7a8dc	2
7ed0df06-2eeb-4496-947e-14890ca7a8dc	4
7ed0df06-2eeb-4496-947e-14890ca7a8dc	3
8d948a73-8f78-4903-98bb-bbee31d83a69	1
8d948a73-8f78-4903-98bb-bbee31d83a69	3
8d948a73-8f78-4903-98bb-bbee31d83a69	4
629ae1b6-615a-4e62-8647-6bbf5da3d957	2
629ae1b6-615a-4e62-8647-6bbf5da3d957	4
629ae1b6-615a-4e62-8647-6bbf5da3d957	3
5449236d-1652-4d0a-8df2-03264dcd27a2	1
5449236d-1652-4d0a-8df2-03264dcd27a2	4
5449236d-1652-4d0a-8df2-03264dcd27a2	3
2f3e5060-258f-4b3d-9fcf-0c403895fa46	1
2f3e5060-258f-4b3d-9fcf-0c403895fa46	4
2f3e5060-258f-4b3d-9fcf-0c403895fa46	3
fde7bb58-0cc0-4e98-bbc5-6ee519d977ac	1
fde7bb58-0cc0-4e98-bbc5-6ee519d977ac	4
fde7bb58-0cc0-4e98-bbc5-6ee519d977ac	3
77c19388-0b68-4d88-a0cd-b80f9280ac00	2
77c19388-0b68-4d88-a0cd-b80f9280ac00	4
77c19388-0b68-4d88-a0cd-b80f9280ac00	3
f6459ecb-616d-479e-b498-a8e3cf92bf56	2
f6459ecb-616d-479e-b498-a8e3cf92bf56	4
f6459ecb-616d-479e-b498-a8e3cf92bf56	3
7055c44c-d30b-4ae9-af2f-d70fe5ef4940	2
7055c44c-d30b-4ae9-af2f-d70fe5ef4940	3
7055c44c-d30b-4ae9-af2f-d70fe5ef4940	4
c035853b-3aaa-496a-a3a0-d61d6f4917f5	2
c035853b-3aaa-496a-a3a0-d61d6f4917f5	4
c035853b-3aaa-496a-a3a0-d61d6f4917f5	3
d7d7d5b9-2935-4ebc-91e4-9991d4cd028b	2
d7d7d5b9-2935-4ebc-91e4-9991d4cd028b	4
d7d7d5b9-2935-4ebc-91e4-9991d4cd028b	3
01b1d9c5-dff6-47dd-bdf0-c5c9f3e92a28	2
01b1d9c5-dff6-47dd-bdf0-c5c9f3e92a28	4
01b1d9c5-dff6-47dd-bdf0-c5c9f3e92a28	3
e700155f-6cf2-40bd-b239-d2adaa2f297c	2
e700155f-6cf2-40bd-b239-d2adaa2f297c	4
e700155f-6cf2-40bd-b239-d2adaa2f297c	3
022f7c1d-b674-40d9-84d5-a6b750ffefb8	2
022f7c1d-b674-40d9-84d5-a6b750ffefb8	4
022f7c1d-b674-40d9-84d5-a6b750ffefb8	3
231c248b-51c0-4e41-9fde-c63ee0f5839f	2
231c248b-51c0-4e41-9fde-c63ee0f5839f	4
231c248b-51c0-4e41-9fde-c63ee0f5839f	3
e58731ea-89fb-49db-a13b-8e46273ea737	2
e58731ea-89fb-49db-a13b-8e46273ea737	4
e58731ea-89fb-49db-a13b-8e46273ea737	3
aed6f26d-61a6-4a33-9620-1323f3e47bb2	2
aed6f26d-61a6-4a33-9620-1323f3e47bb2	3
aed6f26d-61a6-4a33-9620-1323f3e47bb2	4
e3174b55-ebd9-427c-ac86-ed0804e75039	2
e3174b55-ebd9-427c-ac86-ed0804e75039	4
e3174b55-ebd9-427c-ac86-ed0804e75039	3
e8279957-4413-4101-9b96-2654f81ba8a6	2
e8279957-4413-4101-9b96-2654f81ba8a6	3
e8279957-4413-4101-9b96-2654f81ba8a6	4
\.


--
-- Data for Name: classes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.classes (class_id, name, category_id, duration, difficulty_level, location, about_class_description) FROM stdin;
021ec006-09cd-4db7-bc7d-46eec8e047fb	Private Pilates (Mat, Reformer, Cadillac, Chair, Barrel)	4	55	Open to all	Summarecon Bekasi	*THIS CLASS IS NOT SUITABLE FOR PRENATAL / POST-NATAL / SCOLIOSIS CLIENTS*A private Pilates Reformer class offers personalized,...
894cc2bd-7a1e-4ebc-bdeb-76d15107cd95	Serenity Glow Flow	1	60	Open to all	Summarecon Bekasi	A morning vinyasa flow is a dynamic sequence designed to awaken the body and energize the mind. It...
94f3d4ac-910b-4181-b947-827bfff13164	Total Body Reformer	5	50	Open to all	Summarecon Bekasi	A Tower class for all levels is a full-body workout that combines traditional Pilates exercises with the resistance...
ec2c6dc1-497f-4392-9897-c82b6e39de02	Vinyasa Delight	1	60	Open to all	Summarecon Bekasi	A morning vinyasa flow is a dynamic sequence designed to awaken the body and energize the mind. It...
d019bb2f-b4d6-4948-b797-fa2fd87ed98c	Backbend Flow	1	60	Open to all	Summarecon Bekasi	A morning vinyasa flow is a dynamic sequence designed to awaken the body and energize the mind. It...
02457d6e-294e-4a24-89fc-edaa0f1f1224	Hatha Flow	1	60	Open to all	Summarecon Bekasi	A morning vinyasa flow is a dynamic sequence designed to awaken the body and energize the mind. It...
2b496fe5-4617-4b66-a033-9643167406f0	Hip-Opening	1	60	Open to all	Summarecon Bekasi	A morning vinyasa flow is a dynamic sequence designed to awaken the body and energize the mind. It...
e343282f-b803-4f8d-9552-00d555798b8c	Sun-Kissed Flow	1	60	Intermediate	Summarecon Bekasi	A morning vinyasa flow is a dynamic sequence designed to awaken the body and energize the mind. It...
09d8a770-2d06-40b3-a019-1bea981fc16a	Arm Balance	1	60	Open to all	Summarecon Bekasi	A morning vinyasa flow is a dynamic sequence designed to awaken the body and energize the mind. It...
af761997-f321-4682-886a-6e745be717ed	Reformer 101	5	50	Beginner	Summarecon Bekasi	A Tower class for all levels is a full-body workout that combines traditional Pilates exercises with the resistance...
9fa780f9-d41e-419b-94dc-11b45a1a20ce	Prenatal Yoga	2	60	Open to all	Summarecon Bekasi	\N
d22df6a4-ce74-4164-9fde-6e4981cf5fa7	Mat Pilates	3	60	Open to all	Summarecon Bekasi	\N
f1b6c72c-1765-4be7-8db8-2b5c3ddcb4a9	Moonlight Flow	1	60	Open to all	Summarecon Bekasi	A morning vinyasa flow is a dynamic sequence designed to awaken the body and energize the mind. It...
7ed0df06-2eeb-4496-947e-14890ca7a8dc	Saturday Inversion Party	1	60	Open to all	Summarecon Bekasi	A morning vinyasa flow is a dynamic sequence designed to awaken the body and energize the mind. It...
8d948a73-8f78-4903-98bb-bbee31d83a69	Strength & Flow Reformer	5	50	Intermediate	Summarecon Bekasi	A Tower class for all levels is a full-body workout that combines traditional Pilates exercises with the resistance...
629ae1b6-615a-4e62-8647-6bbf5da3d957	Basic Yoga	1	60	Beginner	Summarecon Bekasi	A morning vinyasa flow is a dynamic sequence designed to awaken the body and energize the mind. It...
5449236d-1652-4d0a-8df2-03264dcd27a2	Tower Only	5	50	Open to all	Summarecon Bekasi	In this invigorating class, you'll experience the perfect blend of strength-building and fluid movement. Designed for intermediate to...
2f3e5060-258f-4b3d-9fcf-0c403895fa46	Private Reformer	4	50	All Levels	Summarecon Bekasi	A Private Pilates Class with all equipments (Mat, Reformer, Cadillac, Chair, Barrel) is a personalized session designed to...
fde7bb58-0cc0-4e98-bbc5-6ee519d977ac	Reformer / Tower	5	50	Open to all	Summarecon Bekasi	A Tower class for all levels is a full-body workout that combines traditional Pilates exercises with the resistance...
77c19388-0b68-4d88-a0cd-b80f9280ac00	Power Yoga: Heat and Heart	1	60	Open to all	Summarecon Bekasi	A morning vinyasa flow is a dynamic sequence designed to awaken the body and energize the mind. It...
f6459ecb-616d-479e-b498-a8e3cf92bf56	Early Rise Flow	1	60	Open to all	Summarecon Bekasi	A morning vinyasa flow is a dynamic sequence designed to awaken the body and energize the mind. It...
7055c44c-d30b-4ae9-af2f-d70fe5ef4940	Twilight Flow	1	60	Open to all	Summarecon Bekasi	A morning vinyasa flow is a dynamic sequence designed to awaken the body and energize the mind. It...
c035853b-3aaa-496a-a3a0-d61d6f4917f5	All Body Flow	1	60	Open to all	Summarecon Bekasi	A morning vinyasa flow is a dynamic sequence designed to awaken the body and energize the mind. It...
d7d7d5b9-2935-4ebc-91e4-9991d4cd028b	Backbend Lab 101	1	60	Open to all	Summarecon Bekasi	A morning vinyasa flow is a dynamic sequence designed to awaken the body and energize the mind. It...
01b1d9c5-dff6-47dd-bdf0-c5c9f3e92a28	Morning Vinyasa Flow	1	60	Open to all	Summarecon Bekasi	A Vinyasa Flow class for all levels combines dynamic flow sequences with breath-centered movement, offering a balanced practice...
e700155f-6cf2-40bd-b239-d2adaa2f297c	Mandala Flow	1	60	Open to all	Summarecon Bekasi	A morning vinyasa flow is a dynamic sequence designed to awaken the body and energize the mind. It...
022f7c1d-b674-40d9-84d5-a6b750ffefb8	Vinyasa: Dropback Flow	1	60	Open to all	Summarecon Bekasi	A morning vinyasa flow is a dynamic sequence designed to awaken the body and energize the mind. It...
231c248b-51c0-4e41-9fde-c63ee0f5839f	Vinyasa- Inversion Flow	1	60	Open to all	Summarecon Bekasi	A morning vinyasa flow is a dynamic sequence designed to awaken the body and energize the mind. It...
e58731ea-89fb-49db-a13b-8e46273ea737	Ngabuburit Flow	1	60	Open to all	Summarecon Bekasi	A morning vinyasa flow is a dynamic sequence designed to awaken the body and energize the mind. It...
aed6f26d-61a6-4a33-9620-1323f3e47bb2	Easy Vinyasa	1	60	Open to all	Summarecon Bekasi	A morning vinyasa flow is a dynamic sequence designed to awaken the body and energize the mind. It...
e3174b55-ebd9-427c-ac86-ed0804e75039	Midweek Recharge	1	60	Open to all	Summarecon Bekasi	A morning vinyasa flow is a dynamic sequence designed to awaken the body and energize the mind. It...
e8279957-4413-4101-9b96-2654f81ba8a6	Vinyasa - Eagle Flow	1	60	Open to all	Summarecon Bekasi	A morning vinyasa flow is a dynamic sequence designed to awaken the body and energize the mind. It...
\.


--
-- Data for Name: equipment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.equipment (equipment_id, equipment_name) FROM stdin;
1	Grip Socks
2	Mat
3	Small Towel
4	Water Bottle
\.


--
-- Data for Name: instructors; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.instructors (instructor_id, name, role) FROM stdin;
instructor_1	Keiko Indrijani	Pilates Instructor
instructor_2	Sarah Victoria	Pilates Instructor
instructor_3	Vidya Amarilis	Pilates Instructor
instructor_4	Putri Augustine	Yoga Teacher
instructor_5	Henny Wijaya	Yoga Teacher
instructor_6	Irene Juliency	Yoga Teacher
instructor_7	Dino Vrei	Pilates Instructor
instructor_8	Inez Priscilla	Yoga Teacher
instructor_9	Ivy Damara	Yoga Teacher
instructor_10	Irma Ars	Yoga Teacher
instructor_11	Faras Sekarpratiwi	Yoga Teacher
instructor_12	Icha Devina	Yoga Teacher
instructor_13	Nabila Viera	Pilates Instructor
instructor_14	Novi Erna	Pilates Instructor
instructor_15	Intan Muktipertiwi	Prenatal Yoga Teacher
instructor_16	Diva Mahsa	Pilates Instructor
instructor_17	Zara Alia	Pilates Instructor
instructor_18	Shinta W Permatasari	Yoga Teacher
instructor_19	Hanum Thaher	Pilates Instructor
instructor_20	Shania Hasya	Pilates Instructor
instructor_21	Majma A	Yoga Teacher
instructor_22	Cita A	Pilates Instructor
\.


--
-- Data for Name: related_classes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.related_classes (related_order, main_class_id, title, stars_rating, duration, difficulty_level, description) FROM stdin;
1	021ec006-09cd-4db7-bc7d-46eec8e047fb	Private Reformer	5.0	50	All Levels	*THIS CLASS IS NOT SUITABLE FOR PRENATAL / POST-NATAL / SCOLIOSIS CLIENTS*A private Pilates Reformer class offers personalized,...
1	894cc2bd-7a1e-4ebc-bdeb-76d15107cd95	Morning Vinyasa Flow	5.0	60	Open to all	A morning vinyasa flow is a dynamic sequence designed to awaken the body and energize the mind. It...
2	894cc2bd-7a1e-4ebc-bdeb-76d15107cd95	Vinyasa: Dropback Flow	\N	60	Open to all	A Vinyasa Flow class for all levels combines dynamic flow sequences with breath-centered movement, offering a balanced practice...
3	894cc2bd-7a1e-4ebc-bdeb-76d15107cd95	Hatha Flow	\N	60	Open to all	Join us for a peaceful and energizing Hatha Flow session designed for all levels. This class blends gentle...
1	94f3d4ac-910b-4181-b947-827bfff13164	Tower Only	5.0	50	Open to all	A Tower class for all levels is a full-body workout that combines traditional Pilates exercises with the resistance...
2	94f3d4ac-910b-4181-b947-827bfff13164	Strength & Flow Reformer	5.0	50	Intermediate	In this invigorating class, you'll experience the perfect blend of strength-building and fluid movement. Designed for intermediate to...
3	94f3d4ac-910b-4181-b947-827bfff13164	Reformer 101	5.0	50	Beginner	Start your Pilates journey with confidence! Our beginner-friendly Group Reformer class is designed to build a strong foundation...
1	ec2c6dc1-497f-4392-9897-c82b6e39de02	Morning Vinyasa Flow	5.0	60	Open to all	A morning vinyasa flow is a dynamic sequence designed to awaken the body and energize the mind. It...
2	ec2c6dc1-497f-4392-9897-c82b6e39de02	Vinyasa: Dropback Flow	\N	60	Open to all	A Vinyasa Flow class for all levels combines dynamic flow sequences with breath-centered movement, offering a balanced practice...
3	ec2c6dc1-497f-4392-9897-c82b6e39de02	Hatha Flow	\N	60	Open to all	Join us for a peaceful and energizing Hatha Flow session designed for all levels. This class blends gentle...
1	d019bb2f-b4d6-4948-b797-fa2fd87ed98c	Morning Vinyasa Flow	5.0	60	Open to all	A morning vinyasa flow is a dynamic sequence designed to awaken the body and energize the mind. It...
2	d019bb2f-b4d6-4948-b797-fa2fd87ed98c	Vinyasa: Dropback Flow	\N	60	Open to all	A Vinyasa Flow class for all levels combines dynamic flow sequences with breath-centered movement, offering a balanced practice...
3	d019bb2f-b4d6-4948-b797-fa2fd87ed98c	Hatha Flow	\N	60	Open to all	Join us for a peaceful and energizing Hatha Flow session designed for all levels. This class blends gentle...
1	02457d6e-294e-4a24-89fc-edaa0f1f1224	Morning Vinyasa Flow	5.0	60	Open to all	A morning vinyasa flow is a dynamic sequence designed to awaken the body and energize the mind. It...
2	02457d6e-294e-4a24-89fc-edaa0f1f1224	Vinyasa: Dropback Flow	\N	60	Open to all	A Vinyasa Flow class for all levels combines dynamic flow sequences with breath-centered movement, offering a balanced practice...
3	02457d6e-294e-4a24-89fc-edaa0f1f1224	Arm Balance	\N	60	Open to all	A Vinyasa Arm Balance Yoga class focuses on building strength, flexibility, and focus through dynamic sequences that incorporate...
1	2b496fe5-4617-4b66-a033-9643167406f0	Morning Vinyasa Flow	5.0	60	Open to all	A morning vinyasa flow is a dynamic sequence designed to awaken the body and energize the mind. It...
2	2b496fe5-4617-4b66-a033-9643167406f0	Vinyasa: Dropback Flow	\N	60	Open to all	A Vinyasa Flow class for all levels combines dynamic flow sequences with breath-centered movement, offering a balanced practice...
3	2b496fe5-4617-4b66-a033-9643167406f0	Hatha Flow	\N	60	Open to all	Join us for a peaceful and energizing Hatha Flow session designed for all levels. This class blends gentle...
1	e343282f-b803-4f8d-9552-00d555798b8c	Morning Vinyasa Flow	5.0	60	Open to all	A morning vinyasa flow is a dynamic sequence designed to awaken the body and energize the mind. It...
2	e343282f-b803-4f8d-9552-00d555798b8c	Vinyasa: Dropback Flow	\N	60	Open to all	A Vinyasa Flow class for all levels combines dynamic flow sequences with breath-centered movement, offering a balanced practice...
3	e343282f-b803-4f8d-9552-00d555798b8c	Hatha Flow	\N	60	Open to all	Join us for a peaceful and energizing Hatha Flow session designed for all levels. This class blends gentle...
1	09d8a770-2d06-40b3-a019-1bea981fc16a	Morning Vinyasa Flow	5.0	60	Open to all	A morning vinyasa flow is a dynamic sequence designed to awaken the body and energize the mind. It...
2	09d8a770-2d06-40b3-a019-1bea981fc16a	Vinyasa: Dropback Flow	\N	60	Open to all	A Vinyasa Flow class for all levels combines dynamic flow sequences with breath-centered movement, offering a balanced practice...
3	09d8a770-2d06-40b3-a019-1bea981fc16a	Hatha Flow	\N	60	Open to all	Join us for a peaceful and energizing Hatha Flow session designed for all levels. This class blends gentle...
1	af761997-f321-4682-886a-6e745be717ed	Tower Only	5.0	50	Open to all	A Tower class for all levels is a full-body workout that combines traditional Pilates exercises with the resistance...
2	af761997-f321-4682-886a-6e745be717ed	Strength & Flow Reformer	5.0	50	Intermediate	In this invigorating class, you'll experience the perfect blend of strength-building and fluid movement. Designed for intermediate to...
3	af761997-f321-4682-886a-6e745be717ed	Total Body Reformer	5.0	50	Open to all	Whether you're new to Reformer Pilates or a seasoned pro, our all-levels class has something for everyone. Join...
1	f1b6c72c-1765-4be7-8db8-2b5c3ddcb4a9	Morning Vinyasa Flow	5.0	60	Open to all	A morning vinyasa flow is a dynamic sequence designed to awaken the body and energize the mind. It...
2	f1b6c72c-1765-4be7-8db8-2b5c3ddcb4a9	Vinyasa: Dropback Flow	\N	60	Open to all	A Vinyasa Flow class for all levels combines dynamic flow sequences with breath-centered movement, offering a balanced practice...
3	f1b6c72c-1765-4be7-8db8-2b5c3ddcb4a9	Hatha Flow	\N	60	Open to all	Join us for a peaceful and energizing Hatha Flow session designed for all levels. This class blends gentle...
1	7ed0df06-2eeb-4496-947e-14890ca7a8dc	Morning Vinyasa Flow	5.0	60	Open to all	A morning vinyasa flow is a dynamic sequence designed to awaken the body and energize the mind. It...
2	7ed0df06-2eeb-4496-947e-14890ca7a8dc	Vinyasa: Dropback Flow	\N	60	Open to all	A Vinyasa Flow class for all levels combines dynamic flow sequences with breath-centered movement, offering a balanced practice...
3	7ed0df06-2eeb-4496-947e-14890ca7a8dc	Hatha Flow	\N	60	Open to all	Join us for a peaceful and energizing Hatha Flow session designed for all levels. This class blends gentle...
1	8d948a73-8f78-4903-98bb-bbee31d83a69	Tower Only	5.0	50	Open to all	A Tower class for all levels is a full-body workout that combines traditional Pilates exercises with the resistance...
2	8d948a73-8f78-4903-98bb-bbee31d83a69	Total Body Reformer	5.0	50	Open to all	Whether you're new to Reformer Pilates or a seasoned pro, our all-levels class has something for everyone. Join...
3	8d948a73-8f78-4903-98bb-bbee31d83a69	Reformer 101	5.0	50	Beginner	Start your Pilates journey with confidence! Our beginner-friendly Group Reformer class is designed to build a strong foundation...
1	629ae1b6-615a-4e62-8647-6bbf5da3d957	Morning Vinyasa Flow	5.0	60	Open to all	A morning vinyasa flow is a dynamic sequence designed to awaken the body and energize the mind. It...
2	629ae1b6-615a-4e62-8647-6bbf5da3d957	Vinyasa: Dropback Flow	\N	60	Open to all	A Vinyasa Flow class for all levels combines dynamic flow sequences with breath-centered movement, offering a balanced practice...
3	629ae1b6-615a-4e62-8647-6bbf5da3d957	Hatha Flow	\N	60	Open to all	Join us for a peaceful and energizing Hatha Flow session designed for all levels. This class blends gentle...
1	5449236d-1652-4d0a-8df2-03264dcd27a2	Strength & Flow Reformer	5.0	50	Intermediate	In this invigorating class, you'll experience the perfect blend of strength-building and fluid movement. Designed for intermediate to...
2	5449236d-1652-4d0a-8df2-03264dcd27a2	Total Body Reformer	5.0	50	Open to all	Whether you're new to Reformer Pilates or a seasoned pro, our all-levels class has something for everyone. Join...
3	5449236d-1652-4d0a-8df2-03264dcd27a2	Reformer 101	5.0	50	Beginner	Start your Pilates journey with confidence! Our beginner-friendly Group Reformer class is designed to build a strong foundation...
1	2f3e5060-258f-4b3d-9fcf-0c403895fa46	Private Pilates (Mat, Reformer, Cadillac, Chair, Barrel)	5.0	55	Open to all	A Private Pilates Class with all equipments (Mat, Reformer, Cadillac, Chair, Barrel) is a personalized session designed to...
1	fde7bb58-0cc0-4e98-bbc5-6ee519d977ac	Tower Only	5.0	50	Open to all	A Tower class for all levels is a full-body workout that combines traditional Pilates exercises with the resistance...
2	fde7bb58-0cc0-4e98-bbc5-6ee519d977ac	Strength & Flow Reformer	5.0	50	Intermediate	In this invigorating class, you'll experience the perfect blend of strength-building and fluid movement. Designed for intermediate to...
3	fde7bb58-0cc0-4e98-bbc5-6ee519d977ac	Total Body Reformer	5.0	50	Open to all	Whether you're new to Reformer Pilates or a seasoned pro, our all-levels class has something for everyone. Join...
1	77c19388-0b68-4d88-a0cd-b80f9280ac00	Morning Vinyasa Flow	5.0	60	Open to all	A morning vinyasa flow is a dynamic sequence designed to awaken the body and energize the mind. It...
2	77c19388-0b68-4d88-a0cd-b80f9280ac00	Vinyasa: Dropback Flow	\N	60	Open to all	A Vinyasa Flow class for all levels combines dynamic flow sequences with breath-centered movement, offering a balanced practice...
3	77c19388-0b68-4d88-a0cd-b80f9280ac00	Hatha Flow	\N	60	Open to all	Join us for a peaceful and energizing Hatha Flow session designed for all levels. This class blends gentle...
1	f6459ecb-616d-479e-b498-a8e3cf92bf56	Morning Vinyasa Flow	5.0	60	Open to all	A morning vinyasa flow is a dynamic sequence designed to awaken the body and energize the mind. It...
2	f6459ecb-616d-479e-b498-a8e3cf92bf56	Vinyasa: Dropback Flow	\N	60	Open to all	A Vinyasa Flow class for all levels combines dynamic flow sequences with breath-centered movement, offering a balanced practice...
3	f6459ecb-616d-479e-b498-a8e3cf92bf56	Hatha Flow	\N	60	Open to all	Join us for a peaceful and energizing Hatha Flow session designed for all levels. This class blends gentle...
1	7055c44c-d30b-4ae9-af2f-d70fe5ef4940	Morning Vinyasa Flow	5.0	60	Open to all	A morning vinyasa flow is a dynamic sequence designed to awaken the body and energize the mind. It...
2	7055c44c-d30b-4ae9-af2f-d70fe5ef4940	Vinyasa: Dropback Flow	\N	60	Open to all	A Vinyasa Flow class for all levels combines dynamic flow sequences with breath-centered movement, offering a balanced practice...
3	7055c44c-d30b-4ae9-af2f-d70fe5ef4940	Hatha Flow	\N	60	Open to all	Join us for a peaceful and energizing Hatha Flow session designed for all levels. This class blends gentle...
1	c035853b-3aaa-496a-a3a0-d61d6f4917f5	Morning Vinyasa Flow	5.0	60	Open to all	A morning vinyasa flow is a dynamic sequence designed to awaken the body and energize the mind. It...
2	c035853b-3aaa-496a-a3a0-d61d6f4917f5	Vinyasa: Dropback Flow	\N	60	Open to all	A Vinyasa Flow class for all levels combines dynamic flow sequences with breath-centered movement, offering a balanced practice...
3	c035853b-3aaa-496a-a3a0-d61d6f4917f5	Hatha Flow	\N	60	Open to all	Join us for a peaceful and energizing Hatha Flow session designed for all levels. This class blends gentle...
1	d7d7d5b9-2935-4ebc-91e4-9991d4cd028b	Morning Vinyasa Flow	5.0	60	Open to all	A morning vinyasa flow is a dynamic sequence designed to awaken the body and energize the mind. It...
2	d7d7d5b9-2935-4ebc-91e4-9991d4cd028b	Vinyasa: Dropback Flow	\N	60	Open to all	A Vinyasa Flow class for all levels combines dynamic flow sequences with breath-centered movement, offering a balanced practice...
3	d7d7d5b9-2935-4ebc-91e4-9991d4cd028b	Hatha Flow	\N	60	Open to all	Join us for a peaceful and energizing Hatha Flow session designed for all levels. This class blends gentle...
1	01b1d9c5-dff6-47dd-bdf0-c5c9f3e92a28	Vinyasa: Dropback Flow	\N	60	Open to all	A Vinyasa Flow class for all levels combines dynamic flow sequences with breath-centered movement, offering a balanced practice...
2	01b1d9c5-dff6-47dd-bdf0-c5c9f3e92a28	Hatha Flow	\N	60	Open to all	Join us for a peaceful and energizing Hatha Flow session designed for all levels. This class blends gentle...
3	01b1d9c5-dff6-47dd-bdf0-c5c9f3e92a28	Arm Balance	\N	60	Open to all	A Vinyasa Arm Balance Yoga class focuses on building strength, flexibility, and focus through dynamic sequences that incorporate...
1	e700155f-6cf2-40bd-b239-d2adaa2f297c	Morning Vinyasa Flow	5.0	60	Open to all	A morning vinyasa flow is a dynamic sequence designed to awaken the body and energize the mind. It...
2	e700155f-6cf2-40bd-b239-d2adaa2f297c	Vinyasa: Dropback Flow	\N	60	Open to all	A Vinyasa Flow class for all levels combines dynamic flow sequences with breath-centered movement, offering a balanced practice...
3	e700155f-6cf2-40bd-b239-d2adaa2f297c	Hatha Flow	\N	60	Open to all	Join us for a peaceful and energizing Hatha Flow session designed for all levels. This class blends gentle...
1	022f7c1d-b674-40d9-84d5-a6b750ffefb8	Morning Vinyasa Flow	5.0	60	Open to all	A morning vinyasa flow is a dynamic sequence designed to awaken the body and energize the mind. It...
2	022f7c1d-b674-40d9-84d5-a6b750ffefb8	Hatha Flow	\N	60	Open to all	Join us for a peaceful and energizing Hatha Flow session designed for all levels. This class blends gentle...
3	022f7c1d-b674-40d9-84d5-a6b750ffefb8	Arm Balance	\N	60	Open to all	A Vinyasa Arm Balance Yoga class focuses on building strength, flexibility, and focus through dynamic sequences that incorporate...
1	231c248b-51c0-4e41-9fde-c63ee0f5839f	Morning Vinyasa Flow	5.0	60	Open to all	A morning vinyasa flow is a dynamic sequence designed to awaken the body and energize the mind. It...
2	231c248b-51c0-4e41-9fde-c63ee0f5839f	Vinyasa: Dropback Flow	\N	60	Open to all	A Vinyasa Flow class for all levels combines dynamic flow sequences with breath-centered movement, offering a balanced practice...
3	231c248b-51c0-4e41-9fde-c63ee0f5839f	Hatha Flow	\N	60	Open to all	Join us for a peaceful and energizing Hatha Flow session designed for all levels. This class blends gentle...
1	e58731ea-89fb-49db-a13b-8e46273ea737	Morning Vinyasa Flow	5.0	60	Open to all	A morning vinyasa flow is a dynamic sequence designed to awaken the body and energize the mind. It...
2	e58731ea-89fb-49db-a13b-8e46273ea737	Vinyasa: Dropback Flow	\N	60	Open to all	A Vinyasa Flow class for all levels combines dynamic flow sequences with breath-centered movement, offering a balanced practice...
3	e58731ea-89fb-49db-a13b-8e46273ea737	Hatha Flow	\N	60	Open to all	Join us for a peaceful and energizing Hatha Flow session designed for all levels. This class blends gentle...
1	aed6f26d-61a6-4a33-9620-1323f3e47bb2	Morning Vinyasa Flow	5.0	60	Open to all	A morning vinyasa flow is a dynamic sequence designed to awaken the body and energize the mind. It...
2	aed6f26d-61a6-4a33-9620-1323f3e47bb2	Vinyasa: Dropback Flow	\N	60	Open to all	A Vinyasa Flow class for all levels combines dynamic flow sequences with breath-centered movement, offering a balanced practice...
3	aed6f26d-61a6-4a33-9620-1323f3e47bb2	Hatha Flow	\N	60	Open to all	Join us for a peaceful and energizing Hatha Flow session designed for all levels. This class blends gentle...
1	e3174b55-ebd9-427c-ac86-ed0804e75039	Morning Vinyasa Flow	5.0	60	Open to all	A morning vinyasa flow is a dynamic sequence designed to awaken the body and energize the mind. It...
2	e3174b55-ebd9-427c-ac86-ed0804e75039	Vinyasa: Dropback Flow	\N	60	Open to all	A Vinyasa Flow class for all levels combines dynamic flow sequences with breath-centered movement, offering a balanced practice...
3	e3174b55-ebd9-427c-ac86-ed0804e75039	Hatha Flow	\N	60	Open to all	Join us for a peaceful and energizing Hatha Flow session designed for all levels. This class blends gentle...
1	e8279957-4413-4101-9b96-2654f81ba8a6	Morning Vinyasa Flow	5.0	60	Open to all	A morning vinyasa flow is a dynamic sequence designed to awaken the body and energize the mind. It...
2	e8279957-4413-4101-9b96-2654f81ba8a6	Vinyasa: Dropback Flow	\N	60	Open to all	A Vinyasa Flow class for all levels combines dynamic flow sequences with breath-centered movement, offering a balanced practice...
3	e8279957-4413-4101-9b96-2654f81ba8a6	Hatha Flow	\N	60	Open to all	Join us for a peaceful and energizing Hatha Flow session designed for all levels. This class blends gentle...
\.


--
-- Data for Name: reviews; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reviews (review_order, class_id, instructor_reviewed, review_text, review_location, stars_rating) FROM stdin;
1	021ec006-09cd-4db7-bc7d-46eec8e047fb	Zara Alia	suka selalu kelas kak zara pedes2 tapi nagih	Summarecon Bekasi	5
2	021ec006-09cd-4db7-bc7d-46eec8e047fb	Keiko Indrijani	Kelasnya seru sekali saya suka	Summarecon Bekasi	5
1	94f3d4ac-910b-4181-b947-827bfff13164	Novi Erna	Amazing	Summarecon Bekasi	5
2	94f3d4ac-910b-4181-b947-827bfff13164	Hanum Thaher	Went to this class with other two (I could say) very experienced in pilates. That session was the spiciest one I ever had. Kak Hanum really push our limit OVER the edge. The greatest feeling I felt ever after class. Very excellent.	Summarecon Bekasi	5
3	94f3d4ac-910b-4181-b947-827bfff13164	\N	Really fun and enjoyable class!	Summarecon Bekasi	5
1	ec2c6dc1-497f-4392-9897-c82b6e39de02	\N	It was a very enjoyable flow, as its name it was delightful! Lots of stretching and mobility practices, I love it!	Summarecon Bekasi	5
1	d019bb2f-b4d6-4948-b797-fa2fd87ed98c	Putri Augustine	Suka semua kelas yang ada di kalms, kalau kata org ‘palugada’ hehe	Summarecon Bekasi	5
1	af761997-f321-4682-886a-6e745be717ed	Sarah Victoria	kelas nya seru bangett	Summarecon Bekasi	5
2	af761997-f321-4682-886a-6e745be717ed	Novi Erna	ternyata fun dan beginner friendly!	Summarecon Bekasi	5
3	af761997-f321-4682-886a-6e745be717ed	Dino Vrei	Great	Summarecon Bekasi	5
1	8d948a73-8f78-4903-98bb-bbee31d83a69	Sarah Victoria	seru kelas sarah selalu ga ada movement yang sama di tiap kelasnya keren	Summarecon Bekasi	5
1	629ae1b6-615a-4e62-8647-6bbf5da3d957	Henny Wijaya	Seru banget ada gerakan yang aku baru belajar (compass pose) dan dapet banget yoganya	Summarecon Bekasi	5
1	5449236d-1652-4d0a-8df2-03264dcd27a2	Novi Erna	I took 11.00am class, everyone was there on time. No issue!	Summarecon Bekasi	5
1	2f3e5060-258f-4b3d-9fcf-0c403895fa46	Diva Mahsa	Senang sekali diajarkan 2 alat sekaligus	Summarecon Bekasi	5
2	2f3e5060-258f-4b3d-9fcf-0c403895fa46	\N	Over all good and interesting for first timer	Summarecon Bekasi	5
1	fde7bb58-0cc0-4e98-bbc5-6ee519d977ac	Sarah Victoria	seru banget towernya sarah tapi harus war :(	Summarecon Bekasi	5
1	01b1d9c5-dff6-47dd-bdf0-c5c9f3e92a28	Irma Ars	SELALU MANTAPPP	Summarecon Bekasi	5
\.


--
-- Data for Name: schedules; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.schedules (schedule_id, class_id, instructor_id, date, start_time, duration, location) FROM stdin;
schedule_1	01b1d9c5-dff6-47dd-bdf0-c5c9f3e92a28	instructor_10	2025-08-07	08:00:00	60	Summarecon Bekasi - Yoga Studio
schedule_2	7055c44c-d30b-4ae9-af2f-d70fe5ef4940	instructor_11	2025-08-07	19:30:00	60	Summarecon Bekasi - Yoga Studio
schedule_3	894cc2bd-7a1e-4ebc-bdeb-76d15107cd95	instructor_12	2025-08-08	19:00:00	60	Summarecon Bekasi - Yoga Studio
schedule_4	01b1d9c5-dff6-47dd-bdf0-c5c9f3e92a28	instructor_5	2025-08-09	08:30:00	60	Summarecon Bekasi - Yoga Studio
schedule_5	2b496fe5-4617-4b66-a033-9643167406f0	instructor_4	2025-08-09	15:00:00	60	Summarecon Bekasi - Yoga Studio
schedule_6	01b1d9c5-dff6-47dd-bdf0-c5c9f3e92a28	instructor_10	2025-08-10	07:00:00	60	Summarecon Bekasi - Yoga Studio
schedule_7	e343282f-b803-4f8d-9552-00d555798b8c	instructor_8	2025-08-10	08:30:00	60	Summarecon Bekasi - Yoga Studio
schedule_8	629ae1b6-615a-4e62-8647-6bbf5da3d957	instructor_6	2025-08-10	10:45:00	60	Summarecon Bekasi - Yoga Studio
schedule_9	02457d6e-294e-4a24-89fc-edaa0f1f1224	instructor_11	2025-08-11	19:00:00	60	Summarecon Bekasi - Yoga Studio
schedule_10	ec2c6dc1-497f-4392-9897-c82b6e39de02	instructor_8	2025-08-12	08:00:00	60	Summarecon Bekasi - Yoga Studio
schedule_11	f1b6c72c-1765-4be7-8db8-2b5c3ddcb4a9	instructor_18	2025-08-12	18:30:00	60	Summarecon Bekasi - Yoga Studio
schedule_12	e3174b55-ebd9-427c-ac86-ed0804e75039	instructor_21	2025-08-13	08:00:00	60	Summarecon Bekasi - Yoga Studio
schedule_13	629ae1b6-615a-4e62-8647-6bbf5da3d957	instructor_5	2025-08-13	17:30:00	60	Summarecon Bekasi - Yoga Studio
schedule_14	aed6f26d-61a6-4a33-9620-1323f3e47bb2	instructor_5	2025-08-13	19:00:00	60	Summarecon Bekasi - Yoga Studio
schedule_15	01b1d9c5-dff6-47dd-bdf0-c5c9f3e92a28	instructor_10	2025-08-14	08:00:00	60	Summarecon Bekasi - Yoga Studio
schedule_16	7055c44c-d30b-4ae9-af2f-d70fe5ef4940	instructor_11	2025-08-14	19:30:00	60	Summarecon Bekasi - Yoga Studio
schedule_17	894cc2bd-7a1e-4ebc-bdeb-76d15107cd95	instructor_12	2025-08-15	19:00:00	60	Summarecon Bekasi - Yoga Studio
schedule_18	01b1d9c5-dff6-47dd-bdf0-c5c9f3e92a28	instructor_5	2025-08-16	08:30:00	60	Summarecon Bekasi - Yoga Studio
schedule_19	77c19388-0b68-4d88-a0cd-b80f9280ac00	instructor_9	2025-08-16	14:30:00	60	Summarecon Bekasi - Yoga Studio
schedule_20	01b1d9c5-dff6-47dd-bdf0-c5c9f3e92a28	instructor_21	2025-08-17	07:00:00	60	Summarecon Bekasi - Yoga Studio
schedule_21	e343282f-b803-4f8d-9552-00d555798b8c	instructor_8	2025-08-17	08:30:00	60	Summarecon Bekasi - Yoga Studio
schedule_22	629ae1b6-615a-4e62-8647-6bbf5da3d957	instructor_6	2025-08-17	10:45:00	60	Summarecon Bekasi - Yoga Studio
schedule_23	02457d6e-294e-4a24-89fc-edaa0f1f1224	instructor_11	2025-08-18	19:00:00	60	Summarecon Bekasi - Yoga Studio
schedule_24	ec2c6dc1-497f-4392-9897-c82b6e39de02	instructor_8	2025-08-19	08:00:00	60	Summarecon Bekasi - Yoga Studio
schedule_25	f1b6c72c-1765-4be7-8db8-2b5c3ddcb4a9	instructor_18	2025-08-19	18:30:00	60	Summarecon Bekasi - Yoga Studio
schedule_26	e3174b55-ebd9-427c-ac86-ed0804e75039	instructor_21	2025-08-20	08:00:00	60	Summarecon Bekasi - Yoga Studio
schedule_27	629ae1b6-615a-4e62-8647-6bbf5da3d957	instructor_5	2025-08-20	17:30:00	60	Summarecon Bekasi - Yoga Studio
schedule_28	aed6f26d-61a6-4a33-9620-1323f3e47bb2	instructor_5	2025-08-20	19:00:00	60	Summarecon Bekasi - Yoga Studio
schedule_29	01b1d9c5-dff6-47dd-bdf0-c5c9f3e92a28	instructor_10	2025-08-21	08:00:00	60	Summarecon Bekasi - Yoga Studio
schedule_30	7055c44c-d30b-4ae9-af2f-d70fe5ef4940	instructor_11	2025-08-21	19:30:00	60	Summarecon Bekasi - Yoga Studio
schedule_31	894cc2bd-7a1e-4ebc-bdeb-76d15107cd95	instructor_12	2025-08-22	19:00:00	60	Summarecon Bekasi - Yoga Studio
schedule_32	01b1d9c5-dff6-47dd-bdf0-c5c9f3e92a28	instructor_5	2025-08-23	08:30:00	60	Summarecon Bekasi - Yoga Studio
schedule_33	01b1d9c5-dff6-47dd-bdf0-c5c9f3e92a28	instructor_10	2025-08-24	07:00:00	60	Summarecon Bekasi - Yoga Studio
schedule_34	e343282f-b803-4f8d-9552-00d555798b8c	instructor_8	2025-08-24	08:30:00	60	Summarecon Bekasi - Yoga Studio
schedule_35	629ae1b6-615a-4e62-8647-6bbf5da3d957	instructor_6	2025-08-24	10:45:00	60	Summarecon Bekasi - Yoga Studio
schedule_36	02457d6e-294e-4a24-89fc-edaa0f1f1224	instructor_11	2025-08-25	19:00:00	60	Summarecon Bekasi - Yoga Studio
schedule_37	ec2c6dc1-497f-4392-9897-c82b6e39de02	instructor_8	2025-08-26	08:00:00	60	Summarecon Bekasi - Yoga Studio
schedule_38	f1b6c72c-1765-4be7-8db8-2b5c3ddcb4a9	instructor_18	2025-08-26	18:30:00	60	Summarecon Bekasi - Yoga Studio
schedule_39	01b1d9c5-dff6-47dd-bdf0-c5c9f3e92a28	instructor_10	2025-08-28	08:00:00	60	Summarecon Bekasi - Yoga Studio
schedule_40	7055c44c-d30b-4ae9-af2f-d70fe5ef4940	instructor_11	2025-08-28	19:30:00	60	Summarecon Bekasi - Yoga Studio
schedule_41	894cc2bd-7a1e-4ebc-bdeb-76d15107cd95	instructor_12	2025-08-29	19:00:00	60	Summarecon Bekasi - Yoga Studio
schedule_42	01b1d9c5-dff6-47dd-bdf0-c5c9f3e92a28	instructor_10	2025-08-31	07:00:00	60	Summarecon Bekasi - Yoga Studio
schedule_43	e343282f-b803-4f8d-9552-00d555798b8c	instructor_8	2025-08-31	08:30:00	60	Summarecon Bekasi - Yoga Studio
schedule_44	629ae1b6-615a-4e62-8647-6bbf5da3d957	instructor_6	2025-08-31	10:45:00	60	Summarecon Bekasi - Yoga Studio
schedule_45	9fa780f9-d41e-419b-94dc-11b45a1a20ce	instructor_15	2025-08-08	10:00:00	60	Summarecon Bekasi - Yoga Studio
schedule_46	9fa780f9-d41e-419b-94dc-11b45a1a20ce	instructor_15	2025-08-15	10:00:00	60	Summarecon Bekasi - Yoga Studio
schedule_47	9fa780f9-d41e-419b-94dc-11b45a1a20ce	instructor_15	2025-08-22	10:00:00	60	Summarecon Bekasi - Yoga Studio
schedule_48	9fa780f9-d41e-419b-94dc-11b45a1a20ce	instructor_15	2025-08-29	10:00:00	60	Summarecon Bekasi - Yoga Studio
schedule_49	d22df6a4-ce74-4164-9fde-6e4981cf5fa7	instructor_14	2025-08-10	12:15:00	60	Summarecon Bekasi - Yoga Studio
schedule_50	d22df6a4-ce74-4164-9fde-6e4981cf5fa7	instructor_14	2025-08-17	12:15:00	60	Summarecon Bekasi - Yoga Studio
schedule_51	d22df6a4-ce74-4164-9fde-6e4981cf5fa7	instructor_14	2025-08-24	12:15:00	60	Summarecon Bekasi - Yoga Studio
schedule_52	d22df6a4-ce74-4164-9fde-6e4981cf5fa7	instructor_14	2025-08-31	12:15:00	60	Summarecon Bekasi - Yoga Studio
schedule_53	021ec006-09cd-4db7-bc7d-46eec8e047fb	instructor_1	2025-08-07	09:00:00	55	Summarecon Bekasi - Private Studio
schedule_54	021ec006-09cd-4db7-bc7d-46eec8e047fb	instructor_1	2025-08-07	10:00:00	55	Summarecon Bekasi - Private Studio
schedule_55	2f3e5060-258f-4b3d-9fcf-0c403895fa46	instructor_19	2025-08-07	11:00:00	50	Summarecon Bekasi - Reformer Studio
schedule_56	2f3e5060-258f-4b3d-9fcf-0c403895fa46	instructor_16	2025-08-07	15:00:00	50	Summarecon Bekasi - Reformer Studio
schedule_57	2f3e5060-258f-4b3d-9fcf-0c403895fa46	instructor_2	2025-08-08	11:00:00	50	Summarecon Bekasi - Reformer Studio
schedule_58	2f3e5060-258f-4b3d-9fcf-0c403895fa46	instructor_20	2025-08-10	10:00:00	50	Summarecon Bekasi - Private Studio
schedule_59	2f3e5060-258f-4b3d-9fcf-0c403895fa46	instructor_20	2025-08-10	11:00:00	50	Summarecon Bekasi - Private Studio
schedule_60	2f3e5060-258f-4b3d-9fcf-0c403895fa46	instructor_20	2025-08-10	12:00:00	50	Summarecon Bekasi - Reformer Studio
schedule_61	2f3e5060-258f-4b3d-9fcf-0c403895fa46	instructor_7	2025-08-11	15:00:00	50	Summarecon Bekasi - Reformer Studio
schedule_62	021ec006-09cd-4db7-bc7d-46eec8e047fb	instructor_13	2025-08-12	10:00:00	55	Summarecon Bekasi - Private Studio
schedule_63	021ec006-09cd-4db7-bc7d-46eec8e047fb	instructor_13	2025-08-12	11:00:00	55	Summarecon Bekasi - Private Studio
schedule_64	2f3e5060-258f-4b3d-9fcf-0c403895fa46	instructor_3	2025-08-13	12:00:00	50	Summarecon Bekasi - Reformer Studio
schedule_65	021ec006-09cd-4db7-bc7d-46eec8e047fb	instructor_1	2025-08-14	10:00:00	55	Summarecon Bekasi - Private Studio
schedule_66	021ec006-09cd-4db7-bc7d-46eec8e047fb	instructor_1	2025-08-14	11:00:00	55	Summarecon Bekasi - Private Studio
schedule_67	2f3e5060-258f-4b3d-9fcf-0c403895fa46	instructor_19	2025-08-14	11:00:00	50	Summarecon Bekasi - Reformer Studio
schedule_68	2f3e5060-258f-4b3d-9fcf-0c403895fa46	instructor_16	2025-08-14	15:00:00	50	Summarecon Bekasi - Reformer Studio
schedule_69	2f3e5060-258f-4b3d-9fcf-0c403895fa46	instructor_2	2025-08-15	11:00:00	50	Summarecon Bekasi - Reformer Studio
schedule_70	2f3e5060-258f-4b3d-9fcf-0c403895fa46	instructor_16	2025-08-16	07:00:00	50	Summarecon Bekasi - Reformer Studio
schedule_71	2f3e5060-258f-4b3d-9fcf-0c403895fa46	instructor_16	2025-08-16	08:00:00	50	Summarecon Bekasi - Private Studio
schedule_72	2f3e5060-258f-4b3d-9fcf-0c403895fa46	instructor_16	2025-08-16	09:00:00	50	Summarecon Bekasi - Private Studio
schedule_73	2f3e5060-258f-4b3d-9fcf-0c403895fa46	instructor_20	2025-08-16	10:00:00	50	Summarecon Bekasi - Private Studio
schedule_74	2f3e5060-258f-4b3d-9fcf-0c403895fa46	instructor_20	2025-08-17	10:00:00	50	Summarecon Bekasi - Private Studio
schedule_75	2f3e5060-258f-4b3d-9fcf-0c403895fa46	instructor_20	2025-08-17	11:00:00	50	Summarecon Bekasi - Private Studio
schedule_76	2f3e5060-258f-4b3d-9fcf-0c403895fa46	instructor_20	2025-08-17	12:00:00	50	Summarecon Bekasi - Reformer Studio
schedule_77	2f3e5060-258f-4b3d-9fcf-0c403895fa46	instructor_7	2025-08-18	15:00:00	50	Summarecon Bekasi - Reformer Studio
schedule_78	2f3e5060-258f-4b3d-9fcf-0c403895fa46	instructor_3	2025-08-20	12:00:00	50	Summarecon Bekasi - Reformer Studio
schedule_79	021ec006-09cd-4db7-bc7d-46eec8e047fb	instructor_1	2025-08-21	10:00:00	55	Summarecon Bekasi - Private Studio
schedule_80	021ec006-09cd-4db7-bc7d-46eec8e047fb	instructor_1	2025-08-21	11:00:00	55	Summarecon Bekasi - Private Studio
schedule_81	2f3e5060-258f-4b3d-9fcf-0c403895fa46	instructor_19	2025-08-21	11:00:00	50	Summarecon Bekasi - Reformer Studio
schedule_82	2f3e5060-258f-4b3d-9fcf-0c403895fa46	instructor_16	2025-08-21	15:00:00	50	Summarecon Bekasi - Reformer Studio
schedule_83	2f3e5060-258f-4b3d-9fcf-0c403895fa46	instructor_2	2025-08-22	11:00:00	50	Summarecon Bekasi - Reformer Studio
schedule_84	2f3e5060-258f-4b3d-9fcf-0c403895fa46	instructor_7	2025-08-25	15:00:00	50	Summarecon Bekasi - Reformer Studio
schedule_85	2f3e5060-258f-4b3d-9fcf-0c403895fa46	instructor_3	2025-08-27	12:00:00	50	Summarecon Bekasi - Reformer Studio
schedule_86	2f3e5060-258f-4b3d-9fcf-0c403895fa46	instructor_19	2025-08-28	11:00:00	50	Summarecon Bekasi - Reformer Studio
schedule_87	2f3e5060-258f-4b3d-9fcf-0c403895fa46	instructor_16	2025-08-28	15:00:00	50	Summarecon Bekasi - Reformer Studio
schedule_88	2f3e5060-258f-4b3d-9fcf-0c403895fa46	instructor_2	2025-08-29	11:00:00	50	Summarecon Bekasi - Reformer Studio
schedule_89	2f3e5060-258f-4b3d-9fcf-0c403895fa46	instructor_20	2025-08-31	10:00:00	50	Summarecon Bekasi - Private Studio
schedule_90	2f3e5060-258f-4b3d-9fcf-0c403895fa46	instructor_20	2025-08-31	11:00:00	50	Summarecon Bekasi - Private Studio
schedule_91	2f3e5060-258f-4b3d-9fcf-0c403895fa46	instructor_20	2025-08-31	12:00:00	50	Summarecon Bekasi - Reformer Studio
\.


--
-- Name: equipment_equipment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.equipment_equipment_id_seq', 1, false);


--
-- Name: categories categories_category_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_category_name_key UNIQUE (category_name);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (category_id);


--
-- Name: class_equipment class_equipment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.class_equipment
    ADD CONSTRAINT class_equipment_pkey PRIMARY KEY (class_id, equipment_id);


--
-- Name: classes classes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.classes
    ADD CONSTRAINT classes_pkey PRIMARY KEY (class_id);


--
-- Name: equipment equipment_equipment_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.equipment
    ADD CONSTRAINT equipment_equipment_name_key UNIQUE (equipment_name);


--
-- Name: equipment equipment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.equipment
    ADD CONSTRAINT equipment_pkey PRIMARY KEY (equipment_id);


--
-- Name: instructors instructors_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instructors
    ADD CONSTRAINT instructors_pkey PRIMARY KEY (instructor_id);


--
-- Name: related_classes related_classes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.related_classes
    ADD CONSTRAINT related_classes_pkey PRIMARY KEY (main_class_id, related_order);


--
-- Name: reviews reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_pkey PRIMARY KEY (class_id, review_order);


--
-- Name: schedules schedules_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedules
    ADD CONSTRAINT schedules_pkey PRIMARY KEY (schedule_id);


--
-- Name: class_equipment class_equipment_class_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.class_equipment
    ADD CONSTRAINT class_equipment_class_id_fkey FOREIGN KEY (class_id) REFERENCES public.classes(class_id) ON DELETE CASCADE;


--
-- Name: class_equipment class_equipment_equipment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.class_equipment
    ADD CONSTRAINT class_equipment_equipment_id_fkey FOREIGN KEY (equipment_id) REFERENCES public.equipment(equipment_id) ON DELETE CASCADE;


--
-- Name: classes classes_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.classes
    ADD CONSTRAINT classes_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(category_id);


--
-- Name: related_classes related_classes_main_class_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.related_classes
    ADD CONSTRAINT related_classes_main_class_id_fkey FOREIGN KEY (main_class_id) REFERENCES public.classes(class_id) ON DELETE CASCADE;


--
-- Name: reviews reviews_class_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_class_id_fkey FOREIGN KEY (class_id) REFERENCES public.classes(class_id) ON DELETE CASCADE;


--
-- Name: schedules schedules_class_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedules
    ADD CONSTRAINT schedules_class_id_fkey FOREIGN KEY (class_id) REFERENCES public.classes(class_id) ON DELETE CASCADE;


--
-- Name: schedules schedules_instructor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedules
    ADD CONSTRAINT schedules_instructor_id_fkey FOREIGN KEY (instructor_id) REFERENCES public.instructors(instructor_id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

