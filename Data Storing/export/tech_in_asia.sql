--
-- PostgreSQL database dump
--

-- Dumped from database version 14.17 (Homebrew)
-- Dumped by pg_dump version 14.18 (Homebrew)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: set_closed_at_if_inactive(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.set_closed_at_if_inactive() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF NEW.is_active = FALSE AND OLD.is_active = TRUE THEN
    NEW.closed_at := NOW();
  END IF;
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.set_closed_at_if_inactive() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: applies; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.applies (
    user_id character varying(13) NOT NULL,
    resume_number integer NOT NULL,
    reviewer_id character varying(12) NOT NULL,
    job_id character varying(40) NOT NULL,
    status character varying(10),
    applied_at timestamp without time zone,
    CONSTRAINT chk_applies_status CHECK (((status)::text = ANY ((ARRAY['submitted'::character varying, 'reviewed'::character varying, 'rejected'::character varying, 'accepted'::character varying])::text[])))
);


ALTER TABLE public.applies OWNER TO postgres;

--
-- Name: company; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.company (
    company_id character varying(13) NOT NULL,
    company_name character varying(50) NOT NULL,
    scraped_at timestamp without time zone
);


ALTER TABLE public.company OWNER TO postgres;

--
-- Name: company_industry; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.company_industry (
    company_id character varying(13) NOT NULL,
    industry_id character varying(12) NOT NULL
);


ALTER TABLE public.company_industry OWNER TO postgres;

--
-- Name: job; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.job (
    job_id character varying(40) NOT NULL,
    title character varying(100) NOT NULL,
    job_type character varying(30),
    company_id character varying(13),
    function_id integer,
    location_id character varying(12),
    compensation_id character varying(12),
    is_active boolean DEFAULT true,
    posted_date date,
    scraped_at timestamp without time zone,
    closed_at timestamp without time zone
);


ALTER TABLE public.job OWNER TO postgres;

--
-- Name: company_with_total_jobs; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.company_with_total_jobs AS
 SELECT c.company_id,
    c.company_name,
    c.scraped_at,
    count(j.job_id) AS total_jobs
   FROM (public.company c
     LEFT JOIN public.job j ON (((c.company_id)::text = (j.company_id)::text)))
  GROUP BY c.company_id, c.company_name, c.scraped_at;


ALTER TABLE public.company_with_total_jobs OWNER TO postgres;

--
-- Name: compensation_package; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.compensation_package (
    compensation_id character varying(12) NOT NULL,
    min_salary integer,
    max_salary integer,
    currency character varying(10),
    with_equity boolean,
    scraped_at timestamp without time zone,
    CONSTRAINT valid_salary_range CHECK (((min_salary IS NULL) OR (max_salary IS NULL) OR (min_salary <= max_salary)))
);


ALTER TABLE public.compensation_package OWNER TO postgres;

--
-- Name: contract; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contract (
    job_id character varying(40) NOT NULL,
    contract_duration_months integer,
    renewable boolean
);


ALTER TABLE public.contract OWNER TO postgres;

--
-- Name: freelance; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.freelance (
    job_id character varying(40) NOT NULL,
    project_based boolean,
    contract_length_weeks integer,
    remote_possible boolean
);


ALTER TABLE public.freelance OWNER TO postgres;

--
-- Name: full_time; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.full_time (
    job_id character varying(40) NOT NULL,
    benefit character varying(100),
    working_hours_per_weeks integer,
    has_insurance boolean
);


ALTER TABLE public.full_time OWNER TO postgres;

--
-- Name: function; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.function (
    function_id integer NOT NULL,
    function_name character varying(30) NOT NULL,
    scraped_at timestamp without time zone
);


ALTER TABLE public.function OWNER TO postgres;

--
-- Name: industry; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.industry (
    industry_id character varying(12) NOT NULL,
    industry_name character varying(100) NOT NULL,
    scraped_at timestamp without time zone
);


ALTER TABLE public.industry OWNER TO postgres;

--
-- Name: internship; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.internship (
    job_id character varying(40) NOT NULL,
    duration_month integer,
    is_paid boolean,
    mentorship_provided boolean
);


ALTER TABLE public.internship OWNER TO postgres;

--
-- Name: job_description; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.job_description (
    job_id character varying(40) NOT NULL,
    responsibilities text,
    requirements text
);


ALTER TABLE public.job_description OWNER TO postgres;

--
-- Name: location; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.location (
    location_id character varying(12) NOT NULL,
    city character varying(100) NOT NULL,
    country character varying(100) NOT NULL,
    scraped_at timestamp without time zone
);


ALTER TABLE public.location OWNER TO postgres;

--
-- Name: part_time; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.part_time (
    job_id character varying(40) NOT NULL,
    working_hours_per_weeks integer,
    suitable_for_students boolean
);


ALTER TABLE public.part_time OWNER TO postgres;

--
-- Name: resume; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resume (
    user_id character varying(13) NOT NULL,
    resume_number integer NOT NULL,
    title character varying(100) NOT NULL,
    summary character varying(200)
);


ALTER TABLE public.resume OWNER TO postgres;

--
-- Name: resume_skill; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resume_skill (
    user_id character varying(13) NOT NULL,
    resume_number integer NOT NULL,
    skill character varying(100) NOT NULL
);


ALTER TABLE public.resume_skill OWNER TO postgres;

--
-- Name: reviewer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reviewer (
    reviewer_id character varying(12) NOT NULL,
    name character varying(100) NOT NULL,
    company_id character varying(13)
);


ALTER TABLE public.reviewer OWNER TO postgres;

--
-- Name: user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."user" (
    user_id character varying(13) NOT NULL,
    name character varying(100) NOT NULL,
    username character varying(20) NOT NULL,
    email character varying(50) NOT NULL,
    password_hash character varying(100) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    CONSTRAINT chk_user_email CHECK (((email)::text ~~ '%@%.%'::text))
);


ALTER TABLE public."user" OWNER TO postgres;

--
-- Data for Name: applies; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.applies (user_id, resume_number, reviewer_id, job_id, status, applied_at) FROM stdin;
\.


--
-- Data for Name: company; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.company (company_id, company_name, scraped_at) FROM stdin;
comp_33e9621d	Gefami Services Indonesia	2025-08-07 17:02:16
comp_97d7f220	TIXid	2025-08-07 17:02:16
comp_3815c364	Female Daily Network	2025-08-07 17:02:16
comp_cec98ce6	Boleh Dicoba Digital	2025-08-07 17:02:16
comp_64e3bb93	SIGMATECH	2025-08-07 17:02:16
comp_2352a687	Neveres Sportswear	2025-08-07 17:02:16
comp_a421fc5e	Cakap	2025-08-07 17:02:16
comp_eea9732b	TADA	2025-08-07 17:02:16
comp_5fe50081	Antikode	2025-08-07 17:02:16
comp_fb7b7841	Graha Karya Informasi	2025-08-07 17:02:16
comp_1b1164cb	Mekari	2025-08-07 17:02:16
comp_df9ed564	Felaufeẽ	2025-08-07 17:02:16
comp_e1f1e2cb	detik.com	2025-08-07 17:02:16
comp_8acb43dd	PT Metrocom Global Solusi	2025-08-07 17:02:16
comp_786c073f	Indocyber Global Teknologi	2025-08-07 17:02:16
comp_3c413fc6	Playmakers	2025-08-07 17:02:16
comp_8179f80d	Kumparan	2025-08-07 17:02:16
comp_a19f0fd8	ICHIGO Indonesia	2025-08-07 17:02:16
comp_fe107d99	GoWork	2025-08-07 17:02:16
comp_d2f535ed	ForgeFun	2025-08-07 17:02:16
comp_275c3945	KitaLulus	2025-08-07 17:02:16
comp_dc7c8654	PT Sapta Tunas Teknologi	2025-08-07 17:02:16
comp_c4301255	flitts	2025-08-07 17:02:16
comp_15920e21	PT Sinergy Informasi Pratama	2025-08-07 17:02:16
comp_b3934155	PT. ASLI Rancangan Indonesia	2025-08-07 17:02:16
comp_225c3925	Kompas Gramedia	2025-08-07 17:02:16
comp_cb2b14c7	PT Allo Bank Indonesia Tbk	2025-08-07 17:02:16
comp_ea2144e3	Makmur	2025-08-07 17:02:16
comp_ce1667a1	PT. Wahana Pembayaran Digital	2025-08-07 17:02:16
comp_acfe08af	PT Tiga Daya Digital Indonesia	2025-08-07 17:02:16
comp_001cf410	Ematic Solutions	2025-08-07 17:02:16
comp_f2d8ee5e	Deliveree On-Demand Logistics (Southeast Asia)	2025-08-07 17:02:16
comp_bd648634	Sagara Technology Group	2025-08-07 17:02:16
comp_20ac7aef	PT LOG KAR INDONESIA	2025-08-07 17:02:16
comp_59761619	bTaskee Indonesia	2025-08-07 17:02:16
comp_4b30ef66	Bina Nusantara Group	2025-08-07 17:02:16
comp_e95a250b	PT BIPO Service Indonesia	2025-08-07 17:02:16
comp_af4343c8	Happy5	2025-08-07 17:02:16
comp_539457fc	PT Appfuxion Consulting Indonesia	2025-08-07 17:02:16
comp_74da6410	Staffinc (Sampingan)	2025-08-07 17:02:16
comp_b6131bf8	Mobius Digital	2025-08-07 17:02:16
comp_0e44bed7	NRI Indonesia	2025-08-07 17:02:16
comp_9b8947da	PT. YUKK Kreasi Indonesia	2025-08-07 17:02:16
comp_a1774764	super-staff.ai	2025-08-07 17:02:16
comp_f10a1ab8	SEO Copilot Pte. LTD.	2025-08-07 17:02:16
comp_1aeaaf2a	PT Tricada Intronik	2025-08-07 17:02:16
comp_fd7c1918	Pi-xcels	2025-08-07 17:02:16
comp_af562bdb	PT JST SOFTWARE INDONESIA	2025-08-07 17:02:16
comp_d7da8446	Topremit	2025-08-07 17:02:16
comp_e63e4e84	PT. Jelita Abadi Indoneisa	2025-08-07 17:02:16
comp_f29eb0d7	FOREXimf	2025-08-07 17:02:16
comp_7f9ec5b6	Rocketindo	2025-08-07 17:02:16
comp_66101193	Labamu	2025-08-07 17:02:16
comp_f214c778	NAGAREY.com	2025-08-07 17:02:16
comp_6f1897d1	Little Joy Indonesia	2025-08-07 17:02:16
comp_b8d9b6b5	StyleDoubler	2025-08-07 17:02:16
comp_0fad9501	JALA Indonesia	2025-08-07 17:02:16
comp_4f81100f	Aruna	2025-08-07 17:02:16
comp_27286e10	Purwadhika Digital Technology School	2025-08-07 17:02:16
comp_897e329e	TurnkeyID	2025-08-07 17:02:16
comp_b7cfd20d	Jubelio	2025-08-07 17:02:16
comp_2cbee61a	Propseller	2025-08-08 11:42:39
comp_3e2b102a	Microsec	2025-08-08 11:42:39
comp_85f04910	Sea Search Sdn Bhd	2025-08-08 11:42:39
comp_8201464a	Visa	2025-08-08 11:42:39
comp_061d5045	Canva	2025-08-08 11:42:39
comp_2b79c98f	foodpanda	2025-08-08 11:42:39
comp_2d3dad41	Databricks	2025-08-08 11:42:39
comp_d3062ed3	Vestiaire Collective	2025-08-08 11:42:39
comp_69636f05	Moloco	2025-08-08 11:42:39
comp_bd7c7997	Datadog	2025-08-08 11:42:39
comp_ff343642	New Relic	2025-08-08 11:42:39
comp_0dab276b	NBCUniversal	2025-08-08 11:42:39
comp_191810d7	Terrascope	2025-08-08 11:42:39
comp_a4441e07	Mobbin	2025-08-08 11:42:39
comp_2a0cb6b4	Spotify	2025-08-08 11:42:39
comp_d5c3fb90	AppLovin	2025-08-08 11:42:39
comp_10913ed7	Brainlabs	2025-08-08 11:42:39
comp_182e6e6b	Vistar Media	2025-08-08 11:42:39
comp_a5b171d7	Wise	2025-08-08 11:42:39
comp_2cab9537	TOMRA	2025-08-08 11:42:39
comp_bd58ceda	StraitsX (formerly Xfers)	2025-08-08 11:42:39
comp_fc5b7177	SimplifyNext	2025-08-08 11:42:39
comp_3e937bff	Plaud AI	2025-08-08 11:42:39
comp_d8940ed2	Tools for Humanity	2025-08-08 11:42:39
comp_e4c611e6	Bifrost AI	2025-08-08 11:42:39
comp_7bff9de3	EVYD Technology	2025-08-08 11:42:39
comp_b3ccd852	Finmo	2025-08-08 11:42:39
comp_fbb0c353	Cobo	2025-08-08 11:42:39
comp_fbedb4f4	Blockchain.com	2025-08-08 11:42:39
comp_6d785501	Airbnb	2025-08-08 11:42:39
comp_de49a36f	Deliveroo	2025-08-08 11:42:39
comp_ddba2c92	Gemini	2025-08-08 11:42:39
comp_4ed90f1c	Circles.Life	2025-08-08 11:42:39
comp_92087caf	Crypto.com	2025-08-08 11:42:39
comp_cf673a9c	Grab	2025-08-08 11:42:39
comp_935614de	Coinhako	2025-08-08 11:42:39
comp_fc64b48c	ElevenLabs	2025-08-08 11:42:39
comp_e077b555	Kepler Group	2025-08-08 11:42:39
comp_4af26436	Reddit	2025-08-08 11:42:39
comp_2611075b	Aspire	2025-08-08 11:42:39
comp_e409be0b	Airwallex	2025-08-08 11:42:39
comp_7a9dec80	Grafana Labs	2025-08-08 11:42:39
comp_d69b8fd0	Billups	2025-08-08 11:42:39
comp_0555b28d	Fresha	2025-08-08 11:42:39
comp_bd39704c	BitMEX	2025-08-08 11:42:39
comp_fd601fda	Domino's	2025-08-08 11:42:39
comp_cdac48f2	Flywire	2025-08-08 11:42:39
comp_f130bd81	OKX	2025-08-08 11:42:39
comp_66386d47	Glance	2025-08-08 11:42:39
comp_57f2a6a7	neo4j	2025-08-08 11:42:39
comp_1f59357b	Cribl	2025-08-08 11:42:39
comp_d05d22f9	Sportradar	2025-08-08 11:42:39
comp_bc33e281	Gong	2025-08-08 11:42:39
comp_4807102a	Nas Company	2025-08-08 11:42:39
comp_e67b8b2b	Postman	2025-08-08 11:42:39
comp_08b00238	Trust Bank Singapore	2025-08-08 11:42:39
comp_45dda8dd	HoYoverse	2025-08-08 11:42:39
comp_ad58cf1d	Open Government Products	2025-08-08 11:42:39
comp_13be65af	Figma	2025-08-08 11:42:39
comp_4d08ec58	Stripe	2025-08-08 11:42:39
comp_43b2df2c	Ashby	2025-08-08 11:42:39
comp_84d12c36	H&M Group	2025-08-08 11:42:39
comp_d06cde3b	Emma - The Sleep Company	2025-08-08 11:42:39
comp_bdfb3ee8	Arta Finance	2025-08-08 11:42:39
comp_2ab6c8d1	Reka AI	2025-08-08 11:42:39
comp_1dc9253a	Shiji Group	2025-08-08 11:42:39
comp_06acf8bb	ShopBack	2025-08-08 11:42:39
comp_49c2c721	Adyen	2025-08-08 11:42:39
comp_a19ee5a9	OpenAI	2025-08-08 11:42:39
comp_06d5cd3a	Intrinsic	2025-08-08 11:42:39
comp_bdb257ec	Cohere	2025-08-08 11:42:39
comp_187a8813	Glean	2025-08-08 11:42:39
comp_486af5da	Notion	2025-08-08 11:42:39
comp_cff30d88	Harrison.ai	2025-08-08 11:42:39
comp_36d27c9f	Heidi Health	2025-08-08 11:42:39
comp_919aed83	AlphaSense	2025-08-08 11:42:39
comp_97aa25d0	Sertis	2025-08-08 11:42:39
comp_6c4b8ba7	Bosch	2025-08-08 11:42:39
comp_c3f51d90	NetEase Games	2025-08-08 11:42:39
comp_a07adcb1	Kong Inc.	2025-08-08 11:42:39
comp_f2bfda81	SEEK	2025-08-08 11:42:39
comp_8b3bb450	ClickHouse	2025-08-08 11:42:39
\.


--
-- Data for Name: company_industry; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.company_industry (company_id, industry_id) FROM stdin;
comp_33e9621d	ind_620636e9
comp_97d7f220	ind_cdd630a5
comp_3815c364	ind_b1455e5b
comp_3815c364	ind_aacfcbaa
comp_cec98ce6	ind_cd20ef17
comp_64e3bb93	ind_cd37d9da
comp_2352a687	ind_4706640a
comp_a421fc5e	ind_ee0288ec
comp_eea9732b	ind_5c278c2e
comp_5fe50081	ind_94b96d4d
comp_5fe50081	ind_9adbbf98
comp_fb7b7841	ind_620636e9
comp_1b1164cb	ind_c1f5c458
comp_df9ed564	ind_3bc9df58
comp_e1f1e2cb	ind_9c7cd759
comp_8acb43dd	ind_96d1e119
comp_786c073f	ind_96d1e119
comp_3c413fc6	ind_38b5b5f6
comp_8179f80d	ind_34c808d0
comp_a19f0fd8	ind_2a78df85
comp_fe107d99	ind_f9203ec0
comp_d2f535ed	ind_0a4cb9e1
comp_275c3945	ind_ee0288ec
comp_dc7c8654	ind_96d1e119
comp_c4301255	ind_9adbbf98
comp_c4301255	ind_e8152379
comp_15920e21	ind_96d1e119
comp_b3934155	ind_2a78df85
comp_225c3925	ind_34c808d0
comp_225c3925	ind_9c7cd759
comp_cb2b14c7	ind_3c67cd46
comp_ea2144e3	ind_49936202
comp_ce1667a1	ind_8bbf74e4
comp_acfe08af	ind_96d1e119
comp_001cf410	ind_3ceb499f
comp_f2d8ee5e	ind_7a2c34cb
comp_bd648634	ind_9adbbf98
comp_20ac7aef	ind_7a2c34cb
comp_59761619	ind_eb1b15a2
comp_4b30ef66	ind_ee0288ec
comp_e95a250b	ind_9a942cd9
comp_af4343c8	ind_c1f5c458
comp_539457fc	ind_96d1e119
comp_74da6410	ind_f615b63a
comp_b6131bf8	ind_96d1e119
comp_0e44bed7	ind_9ad05227
comp_9b8947da	ind_2a78df85
comp_a1774764	ind_96d1e119
comp_f10a1ab8	ind_ee27cde0
comp_1aeaaf2a	ind_1445c481
comp_fd7c1918	ind_e8152379
comp_af562bdb	ind_9ad05227
comp_d7da8446	ind_8bbf74e4
comp_e63e4e84	ind_5982950c
comp_f29eb0d7	ind_b2698b63
comp_7f9ec5b6	ind_58b97f3c
comp_66101193	ind_2a78df85
comp_f214c778	ind_e8152379
comp_6f1897d1	ind_f175bc98
comp_b8d9b6b5	ind_38b5b5f6
comp_0fad9501	ind_ce55655f
comp_4f81100f	ind_8b0109dd
comp_27286e10	ind_ee0288ec
comp_897e329e	ind_4c02e384
comp_b7cfd20d	ind_5c278c2e
comp_2cbee61a	ind_f79d77f2
comp_3e2b102a	ind_86bd4849
comp_85f04910	ind_9a942cd9
comp_8201464a	ind_8bbf74e4
comp_061d5045	ind_ae1723e7
comp_2b79c98f	ind_ccd3e1d8
comp_2d3dad41	ind_9ad05227
comp_d3062ed3	ind_f4403288
comp_69636f05	ind_38b5b5f6
comp_bd7c7997	ind_5c278c2e
comp_ff343642	ind_9ad05227
comp_0dab276b	ind_5f4445a1
comp_191810d7	ind_933bf21a
comp_a4441e07	ind_9ad05227
comp_2a0cb6b4	ind_131260cb
comp_d5c3fb90	ind_0a4cb9e1
comp_10913ed7	ind_38b5b5f6
comp_182e6e6b	ind_38b5b5f6
comp_a5b171d7	ind_b2698b63
comp_2cab9537	ind_17088134
comp_bd58ceda	ind_8bbf74e4
comp_fc5b7177	ind_9ad05227
comp_3e937bff	ind_1445c481
comp_d8940ed2	ind_4add517d
comp_e4c611e6	ind_4add517d
comp_7bff9de3	ind_4add517d
comp_b3ccd852	ind_8bbf74e4
comp_fbb0c353	ind_49936202
comp_fbedb4f4	ind_5cbd5840
comp_6d785501	ind_fb09ffa6
comp_de49a36f	ind_ccd3e1d8
comp_ddba2c92	ind_b2698b63
comp_4ed90f1c	ind_214e2ba6
comp_92087caf	ind_b2698b63
comp_cf673a9c	ind_145a070a
comp_935614de	ind_8bbf74e4
comp_fc64b48c	ind_6ae7a749
comp_e077b555	ind_38b5b5f6
comp_4af26436	ind_3d84a8bd
comp_2611075b	ind_8bbf74e4
comp_e409be0b	ind_8bbf74e4
comp_7a9dec80	ind_9ad05227
comp_d69b8fd0	ind_38b5b5f6
comp_0555b28d	ind_9ad05227
comp_bd39704c	ind_49936202
comp_fd601fda	ind_ccd3e1d8
comp_cdac48f2	ind_b2698b63
comp_f130bd81	ind_9ad05227
comp_66386d47	ind_9c7cd759
comp_57f2a6a7	ind_5c278c2e
comp_1f59357b	ind_9ad05227
comp_d05d22f9	ind_9ad05227
comp_bc33e281	ind_9ad05227
comp_4807102a	ind_9c7cd759
comp_e67b8b2b	ind_168a3791
comp_08b00238	ind_f2047914
comp_45dda8dd	ind_398ed329
comp_ad58cf1d	ind_9c30e11e
comp_13be65af	ind_5c278c2e
comp_4d08ec58	ind_8bbf74e4
comp_43b2df2c	ind_9ad05227
comp_84d12c36	ind_9df311e3
comp_d06cde3b	ind_6ae7a749
comp_bdfb3ee8	ind_49936202
comp_2ab6c8d1	ind_4add517d
comp_1dc9253a	ind_9ad05227
comp_06acf8bb	ind_58b97f3c
comp_49c2c721	ind_8bbf74e4
comp_a19ee5a9	ind_4add517d
comp_06d5cd3a	ind_d058025d
comp_bdb257ec	ind_4add517d
comp_187a8813	ind_4add517d
comp_486af5da	ind_9ad05227
comp_cff30d88	ind_cbc3a2b6
comp_36d27c9f	ind_cbc3a2b6
comp_919aed83	ind_9ad05227
comp_97aa25d0	ind_56148a8e
comp_6c4b8ba7	ind_b070ce5d
comp_c3f51d90	ind_398ed329
comp_a07adcb1	ind_9ad05227
comp_f2bfda81	ind_f615b63a
comp_8b3bb450	ind_5c278c2e
\.


--
-- Data for Name: compensation_package; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.compensation_package (compensation_id, min_salary, max_salary, currency, with_equity, scraped_at) FROM stdin;
pkg_8b9af780	7000000	11000000	IDR	f	2025-08-07 17:02:16
pkg_c2d3ede2	13000000	15000000	IDR	f	2025-08-07 17:02:16
pkg_93d06655	8000000	10000000	IDR	f	2025-08-08 17:30:02
pkg_9749583d	1	2	IDR	f	2025-08-08 17:30:02
pkg_822c6f38	10000000	10500000	IDR	f	2025-08-08 17:30:02
pkg_8a019595	\N	\N	\N	f	2025-08-08 17:30:02
pkg_21a93f57	10000000	13000000	IDR	f	2025-08-08 17:30:02
pkg_3c9de70a	11000000	15000000	IDR	f	2025-08-08 17:30:02
pkg_253c02c5	5300000	8000000	IDR	f	2025-08-08 17:30:02
pkg_64d51dde	7000000	9000000	IDR	f	2025-08-08 17:30:02
pkg_67eb88f3	2000000	2000000	IDR	f	2025-08-08 17:30:02
pkg_d5506bd4	7500000	12000000	IDR	f	2025-08-08 17:30:02
pkg_5da31994	5500000	6500000	IDR	f	2025-08-08 17:30:02
pkg_15bfbc3e	5500000	6000000	IDR	f	2025-08-08 17:30:02
pkg_25e4938d	4000000	5000000	VND	f	2025-08-08 17:30:02
pkg_1b1784b6	13000000	14000000	IDR	f	2025-08-08 17:30:02
pkg_4140485c	8000000	8500000	IDR	f	2025-08-08 17:30:02
pkg_c05686ed	1000	1200	MYR	f	2025-08-08 17:30:02
pkg_bd1e28a8	7000000	8500000	IDR	f	2025-08-08 17:30:02
pkg_35e73ccb	3600	3900	SGD	t	2025-08-08 17:30:02
pkg_9e20deec	8000000	11000000	IDR	f	2025-08-08 17:30:02
pkg_b9cec660	6000000	9000000	IDR	f	2025-08-08 17:30:02
pkg_3d6a9c67	7000000	10000000	IDR	f	2025-08-08 17:30:02
pkg_316c2cbb	9500000	10500000	IDR	f	2025-08-08 17:30:02
pkg_da30dd4c	7000000	7500000	IDR	f	2025-08-08 17:30:02
pkg_de1249bf	7000000	9500000	IDR	f	2025-08-08 17:30:02
pkg_76cbc06a	11000000	13000000	IDR	f	2025-08-08 17:30:02
pkg_0f9256ca	15500000	16500000	IDR	f	2025-08-08 17:30:02
pkg_73c134e8	7500000	8000000	IDR	f	2025-08-08 17:30:02
pkg_2958d81b	7200000	10800000	IDR	f	2025-08-08 17:30:02
pkg_e90aec12	5000000	8000000	IDR	f	2025-08-08 17:30:02
pkg_608ea1fd	16500000	18500000	IDR	f	2025-08-08 17:30:02
pkg_982fea78	9000000	10000000	IDR	f	2025-08-08 17:30:02
pkg_6a83c388	14000000	18000000	IDR	f	2025-08-08 17:30:02
pkg_cf7c1d4a	5500000	7000000	IDR	f	2025-08-08 17:30:02
pkg_838c6091	7000000	12000000	IDR	f	2025-08-08 17:30:02
pkg_81ad9c08	4000000	5000000	IDR	f	2025-08-08 17:30:02
pkg_fcfc528b	10000000	11000000	IDR	f	2025-08-08 17:30:02
pkg_8fe51175	10500000	12500000	IDR	f	2025-08-08 17:30:02
pkg_cc1168ba	10000000	12000000	IDR	f	2025-08-08 17:30:02
pkg_fd0eecda	15000000	18000000	IDR	f	2025-08-08 17:30:02
pkg_3ba1dc2d	14000000	16000000	IDR	f	2025-08-08 17:30:02
pkg_c6dcb635	10000000	15000000	IDR	f	2025-08-08 17:30:02
pkg_567d01d6	6000000	6000000	IDR	f	2025-08-08 17:30:02
pkg_11193b2f	1000000	1500000	IDR	f	2025-08-08 17:30:02
pkg_841aab7e	6000000	12000000	IDR	f	2025-08-08 17:30:02
pkg_54e03c9e	4500000	5500000	IDR	f	2025-08-08 17:30:02
pkg_136922f5	6000000	8000000	IDR	f	2025-08-08 17:30:02
pkg_5047dbae	5000000	7000000	IDR	f	2025-08-08 17:30:02
pkg_ef5b1e77	6500000	9000000	IDR	f	2025-08-08 17:30:02
pkg_f590c5cc	5000000	8500000	IDR	f	2025-08-08 17:30:02
pkg_56c227b2	6000000	8500000	IDR	f	2025-08-08 17:30:02
pkg_05c72e6d	15000000	25000000	IDR	f	2025-08-08 17:30:02
pkg_31b62d7d	5000000	9000000	IDR	f	2025-08-08 17:30:02
pkg_464f2da5	18000000	20000000	IDR	f	2025-08-08 17:30:02
pkg_397cfc37	8800000	8800000	\N	f	2025-08-08 17:30:02
pkg_5a12623d	1	1	IDR	f	2025-08-08 17:30:02
pkg_f2381a89	2200000	2500000	IDR	f	2025-08-08 17:30:02
pkg_971bb9b1	5000000	11000000	IDR	f	2025-08-08 17:30:02
pkg_95ae8f1d	13000000	26000000	IDR	f	2025-08-08 17:30:02
pkg_8cde7994	8500000	10000000	IDR	f	2025-08-08 17:30:02
pkg_09890443	9000000	12000000	IDR	f	2025-08-08 17:30:02
pkg_8b4c7435	13000000	16000000	IDR	f	2025-08-08 17:30:02
pkg_be9de83f	8000000	9000000	IDR	f	2025-08-08 17:30:02
pkg_ede38846	12000000	15000000	IDR	f	2025-08-08 17:30:02
pkg_7cd22d1e	6000000	7200000	IDR	f	2025-08-08 17:30:02
pkg_5940c19b	3000000	4000000	IDR	f	2025-08-08 17:30:02
pkg_e09d5c3c	2345600	2567890	IDR	f	2025-08-08 17:30:02
pkg_0fe2546a	10000000	11500000	IDR	f	2025-08-08 17:30:02
pkg_7783f459	6500000	6800000	IDR	f	2025-08-08 17:30:02
pkg_ff4ad210	9000	9000	\N	f	2025-08-08 17:30:02
pkg_39740ba4	6000000	7000000	IDR	f	2025-08-08 17:30:02
pkg_cfc9aa67	800	1000	MYR	f	2025-08-08 17:30:02
pkg_5198cc0b	2000000	2500000	IDR	f	2025-08-08 17:30:02
pkg_10d9bc52	4000000	5000000	IDR	t	2025-08-08 17:30:02
pkg_b889c007	7000000	8000000	IDR	f	2025-08-08 17:30:02
pkg_3d200299	3000000	5000000	IDR	f	2025-08-08 17:30:02
pkg_d7e485c3	10000000	16000000	IDR	f	2025-08-08 17:30:02
pkg_2d35f618	16000000	18000000	IDR	f	2025-08-08 17:30:02
pkg_7e9ce1c0	20000000	25000000	IDR	f	2025-08-08 17:30:02
pkg_cf239f18	6500000	7000000	IDR	f	2025-08-08 17:30:02
pkg_ab921f28	8500000	9000000	IDR	f	2025-08-08 17:30:02
pkg_547f8784	4500000	7000000	IDR	f	2025-08-08 17:30:02
pkg_023379cc	10000000	14000000	IDR	f	2025-08-08 17:30:02
pkg_43a18d93	11000000	12000000	IDR	f	2025-08-08 17:30:02
pkg_6df3144f	8000000	10500000	IDR	f	2025-08-08 17:30:02
pkg_1636ce6f	12000000	12500000	IDR	f	2025-08-08 17:30:02
pkg_f7cf7a36	5500000	8000000	IDR	f	2025-08-08 17:30:02
pkg_7ee28436	2500000	2500000	IDR	f	2025-08-08 17:30:02
pkg_6cc1dc31	4000000	6000000	IDR	f	2025-08-08 17:30:02
pkg_aeaa84c8	13000000	13000000	\N	f	2025-08-08 17:30:02
pkg_76f39d31	10	100	IDR	f	2025-08-08 17:30:02
pkg_0ac5bc72	10000000	20000000	IDR	f	2025-08-08 17:30:02
pkg_375391a1	8000000	15000000	IDR	f	2025-08-08 17:30:02
pkg_9251fa1d	5000000	5500000	IDR	f	2025-08-08 17:30:02
pkg_23165dfc	14000000	15000000	IDR	f	2025-08-08 17:30:02
pkg_8cd73035	6000000	10000000	IDR	f	2025-08-08 17:30:02
pkg_9eb8cc5e	8000	10000	MYR	f	2025-08-08 17:30:02
pkg_022c485c	20000000	30000000	IDR	f	2025-08-08 17:30:02
pkg_4ffc3d42	12000000	13000000	IDR	f	2025-08-08 17:30:02
pkg_0c54dd28	6500000	7100000	IDR	f	2025-08-08 17:30:02
pkg_f867c52c	7500000	8500000	IDR	f	2025-08-08 17:30:02
pkg_857782df	7000000	15000000	IDR	f	2025-08-08 17:30:02
pkg_99c064b1	25000000	40000000	IDR	f	2025-08-08 17:30:02
pkg_a4fbd25b	1000000	2000000	IDR	f	2025-08-08 17:30:02
pkg_8e7dcc95	12000000	12000000	\N	f	2025-08-08 17:30:02
pkg_8f9cde40	6500000	12000000	IDR	f	2025-08-08 17:30:02
pkg_2bb396c9	5500000	7500000	IDR	f	2025-08-08 17:30:02
pkg_2b1bfc3c	10000000	13500000	IDR	f	2025-08-08 17:30:02
pkg_74ac8e92	8000000	12000000	IDR	f	2025-08-08 17:30:02
pkg_60381dc7	10000000	12500000	IDR	f	2025-08-08 17:30:02
pkg_c026d17f	10	10	\N	f	2025-08-08 17:30:02
pkg_d3edcb4b	1500000	1800000	IDR	f	2025-08-08 17:30:02
pkg_f008ccf6	6000	9000	MYR	f	2025-08-08 17:30:02
pkg_a6bbc261	10000000	30000000	IDR	f	2025-08-08 17:30:02
pkg_4f7fa7a9	50000000	80000000	IDR	f	2025-08-08 17:30:02
pkg_64e34fb9	7000000	7000000	\N	f	2025-08-08 11:42:39
pkg_c2faaa49	5000000	6000000	IDR	f	2025-08-08 17:30:02
pkg_cf34d0a9	164000	204000	SGD	f	2025-08-08 17:30:02
pkg_e181020f	6700	8500	SGD	t	2025-08-08 17:30:02
pkg_8bc5b8e0	2000000	3000000	IDR	f	2025-08-08 17:30:02
pkg_f8003617	148800	184800	SGD	f	2025-08-08 17:30:02
pkg_b987522b	213000	253000	SGD	f	2025-08-08 17:30:02
pkg_9e7cd558	6000000	6000000	\N	f	2025-08-08 17:30:02
pkg_2dd718d2	5000000	5000000	\N	f	2025-08-08 17:30:02
pkg_a4bc76e9	1200000	1250000	IDR	f	2025-08-08 17:30:02
pkg_3695fbbb	312000	468000	SGD	t	2025-08-08 17:30:02
pkg_5a4d4df5	105600	158400	SGD	f	2025-08-08 17:30:02
pkg_f0683732	56000	75000	SGD	t	2025-08-08 17:30:02
pkg_6d5c2208	3000000	4500000	IDR	f	2025-08-08 17:30:02
pkg_0819a78e	184000	276000	SGD	t	2025-08-08 17:30:02
\.


--
-- Data for Name: contract; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.contract (job_id, contract_duration_months, renewable) FROM stdin;
\.


--
-- Data for Name: freelance; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.freelance (job_id, project_based, contract_length_weeks, remote_possible) FROM stdin;
\.


--
-- Data for Name: full_time; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.full_time (job_id, benefit, working_hours_per_weeks, has_insurance) FROM stdin;
\.


--
-- Data for Name: function; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.function (function_id, function_name, scraped_at) FROM stdin;
3	Project & Product Management	2025-08-07 17:02:16
10	DevOps & Cloud Management	2025-08-07 17:02:16
5	Marketing & PR	2025-08-07 17:02:16
1	Software Engineer	2025-08-07 17:02:16
14	QA & Testing	2025-08-07 17:02:16
12	Graphic & Motion Design	2025-08-07 17:02:16
15	Strategy & Consulting	2025-08-07 17:02:16
6	Data & Analytics	2025-08-07 17:02:16
11	Human Resources	2025-08-07 17:02:16
18	Mobile Development	2025-08-07 17:02:16
8	Finance, Legal & Accounting	2025-08-07 17:02:16
4	Sales & Business Development	2025-08-07 17:02:16
2	Web Development	2025-08-07 17:02:16
9	Enterprise Software & Systems	2025-08-07 17:02:16
21	Community Management	2025-08-07 17:02:16
7	Media & Journalism	2025-08-07 17:02:16
13	Hardware & Embedded Systems	2025-08-07 17:02:16
26	Retail & Wholesale	2025-08-07 17:02:16
24	UX/UI Design	2025-08-07 17:02:16
25	Administrative & Clerical	2025-08-07 17:02:16
16	Science & Academics	2025-08-07 17:02:16
20	Event Management	2025-08-07 17:02:16
22	Executive & Management	2025-08-07 17:02:16
17	Logistics & Operations	2025-08-07 17:02:16
19	Student	2025-08-07 17:02:16
23	Customer Success	2025-08-07 17:02:16
\.


--
-- Data for Name: industry; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.industry (industry_id, industry_name, scraped_at) FROM stdin;
ind_620636e9	Outsourcing	2025-08-07 17:02:16
ind_cdd630a5	Digital Entertainment	2025-08-07 17:02:16
ind_b1455e5b	Communities	2025-08-07 17:02:16
ind_aacfcbaa	Reviews & Recommendations	2025-08-07 17:02:16
ind_cd20ef17	Social Media Marketing	2025-08-07 17:02:16
ind_cd37d9da	Clean Technology IT	2025-08-07 17:02:16
ind_4706640a	Fashion	2025-08-07 17:02:16
ind_ee0288ec	Education Tech	2025-08-07 17:02:16
ind_5c278c2e	SaaS	2025-08-07 17:02:16
ind_94b96d4d	Interface Design	2025-08-07 17:02:16
ind_9adbbf98	Web Development	2025-08-07 17:02:16
ind_c1f5c458	Enterprise Software	2025-08-07 17:02:16
ind_3bc9df58	Beauty ecommerce platforms	2025-08-07 17:02:16
ind_9c7cd759	Digital Media	2025-08-07 17:02:16
ind_96d1e119	IT & Cybersecurity	2025-08-07 17:02:16
ind_38b5b5f6	Advertising	2025-08-07 17:02:16
ind_34c808d0	News	2025-08-07 17:02:16
ind_2a78df85	Internet technology	2025-08-07 17:02:16
ind_f9203ec0	Coworking	2025-08-07 17:02:16
ind_0a4cb9e1	Mobile Games	2025-08-07 17:02:16
ind_e8152379	General B2C/C2C	2025-08-07 17:02:16
ind_3c67cd46	Financial product comparison	2025-08-07 17:02:16
ind_49936202	Investment tools and platforms	2025-08-07 17:02:16
ind_8bbf74e4	Payments and remittance	2025-08-07 17:02:16
ind_3ceb499f	Internet marketing	2025-08-07 17:02:16
ind_7a2c34cb	Logistics	2025-08-07 17:02:16
ind_eb1b15a2	Enterprise Application	2025-08-07 17:02:16
ind_9a942cd9	Human Resource	2025-08-07 17:02:16
ind_f615b63a	Social Recruiting	2025-08-07 17:02:16
ind_9ad05227	Software	2025-08-07 17:02:16
ind_ee27cde0	Marketing Automation	2025-08-07 17:02:16
ind_1445c481	Hardware & Software	2025-08-07 17:02:16
ind_5982950c	B2B ecommerce	2025-08-07 17:02:16
ind_b2698b63	Financial exchanges	2025-08-07 17:02:16
ind_58b97f3c	Ecommerce aggregators	2025-08-07 17:02:16
ind_f175bc98	Miscellaneous ecommerce	2025-08-07 17:02:16
ind_ce55655f	Agricultural technology	2025-08-07 17:02:16
ind_8b0109dd	Food and groceries platforms	2025-08-07 17:02:16
ind_4c02e384	Big Data	2025-08-07 17:02:16
ind_f79d77f2	Property marketplaces	2025-08-08 11:42:39
ind_86bd4849	Network Security	2025-08-08 11:42:39
ind_ae1723e7	Designers	2025-08-08 11:42:39
ind_ccd3e1d8	Restaurants & Food	2025-08-08 11:42:39
ind_f4403288	Marketplaces (fashion and beauty)	2025-08-08 11:42:39
ind_5f4445a1	Entertainment Industry	2025-08-08 11:42:39
ind_933bf21a	Green	2025-08-08 11:42:39
ind_131260cb	Music	2025-08-08 11:42:39
ind_17088134	Recycling	2025-08-08 11:42:39
ind_4add517d	Artificial Intelligence	2025-08-08 11:42:39
ind_5cbd5840	Services	2025-08-08 11:42:39
ind_fb09ffa6	Hotels & Accomodation	2025-08-08 11:42:39
ind_214e2ba6	Telecommunications	2025-08-08 11:42:39
ind_145a070a	Transportation	2025-08-08 11:42:39
ind_6ae7a749	Full-time	2025-08-08 11:42:39
ind_3d84a8bd	Social Media	2025-08-08 11:42:39
ind_168a3791	Developer APIs	2025-08-08 11:42:39
ind_f2047914	Digital bank	2025-08-08 11:42:39
ind_398ed329	Games	2025-08-08 11:42:39
ind_9c30e11e	Non Profit	2025-08-08 11:42:39
ind_9df311e3	Retail (fashion and beauty)	2025-08-08 11:42:39
ind_d058025d	Robotics	2025-08-08 11:42:39
ind_cbc3a2b6	Healthtech AI	2025-08-08 11:42:39
ind_56148a8e	Consulting	2025-08-08 11:42:39
ind_b070ce5d	Consumer Electronics	2025-08-08 11:42:39
\.


--
-- Data for Name: internship; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.internship (job_id, duration_month, is_paid, mentorship_provided) FROM stdin;
\.


--
-- Data for Name: job; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.job (job_id, title, job_type, company_id, function_id, location_id, compensation_id, is_active, posted_date, scraped_at, closed_at) FROM stdin;
7403b7ad-b263-473d-8221-4ae157931570	Project Manager	Contract	comp_33e9621d	3	loc_9597ddfd	pkg_93d06655	t	2025-07-28	2025-08-07 17:02:16	\N
f45fd8f2-b418-4506-84b0-456fc22fb4b2	Infrastructure Lead	Full-time	comp_97d7f220	10	loc_6fc8a029	pkg_9749583d	t	2025-08-04	2025-08-07 17:02:16	\N
a46b938a-52bc-45ba-aa98-89b52b03127e	DevSecOps	Full-time	comp_3815c364	10	loc_6fc8a029	pkg_8a019595	t	2025-08-06	2025-08-07 17:02:16	\N
626f29a8-c88b-4e90-9c76-8aba77c89e34	Account Manager	Contract	comp_cec98ce6	3	loc_6fc8a029	pkg_8a019595	t	2025-07-04	2025-08-07 17:02:16	\N
f5f1145e-f13f-4277-b617-ecc89c9cdb77	Head of Marketing Communication	Full-time	comp_cec98ce6	5	loc_b3feaf63	pkg_8a019595	t	2025-07-02	2025-08-07 17:02:16	\N
bab28f7a-bac5-4471-9792-179fb1f28f32	Front End Developer (Nuxt Js) - Multifinance Industry	Contract	comp_64e3bb93	1	loc_6fc8a029	pkg_822c6f38	t	2025-08-07	2025-08-07 17:02:16	\N
dafc6c42-c6e1-4669-a6a7-311948e7f46e	Integration Tester (Banking Industry)	Contract	comp_64e3bb93	14	loc_6fc8a029	pkg_4140485c	t	2025-08-07	2025-08-07 17:02:16	\N
af1ecab4-33ea-45cf-be72-d011b7c16289	Motion Graphic	Full-time	comp_2352a687	12	loc_6fc8a029	pkg_bd1e28a8	t	2025-08-06	2025-08-07 17:02:16	\N
38c2ec4b-1eec-43fa-aca6-9683f162d47e	Social Media Intern	Internship	comp_a421fc5e	5	loc_9597ddfd	pkg_8a019595	t	2025-08-06	2025-08-07 17:02:16	\N
4be72b9e-7ef8-4979-b7e1-6c4356c7db43	Associate Product Manager	Full-time	comp_eea9732b	3	loc_6fc8a029	pkg_8a019595	t	2025-08-06	2025-08-07 17:02:16	\N
3bfb3ca7-9d74-4185-823d-c5e7c81ed30b	Technical Client Relation	Full-time	comp_eea9732b	15	loc_6fc8a029	pkg_8a019595	t	2025-08-06	2025-08-07 17:02:16	\N
be6b8c20-f1b9-4352-a926-32c2c3372684	Data Engineer	Full-time	comp_eea9732b	6	loc_6fc8a029	pkg_8a019595	t	2025-08-06	2025-08-07 17:02:16	\N
fc13368e-0899-428d-9fd3-7e07d5253aeb	HR People Partner	Full-time	comp_5fe50081	11	loc_9597ddfd	pkg_8a019595	t	2025-08-06	2025-08-07 17:02:16	\N
d4ebf353-5e71-4e29-9e24-2337600e91c6	Jr. KOL Specialist	Full-time	comp_3815c364	5	loc_6fc8a029	pkg_8a019595	t	2025-08-06	2025-08-07 17:02:16	\N
b3a9d415-4de8-4b18-acc3-9d4483de168f	BackEnd Developer	Contract	comp_64e3bb93	18	loc_6fc8a029	pkg_9e20deec	t	2025-08-06	2025-08-07 17:02:16	\N
95b09bf4-9a5d-4bc1-8ba4-e70f497ca427	Project Coordinator	Contract	comp_fb7b7841	3	loc_6fc8a029	pkg_b9cec660	t	2025-08-06	2025-08-07 17:02:16	\N
12229194-720e-4569-bfba-05d139603bd1	Business Intelligence	Full-time	comp_1b1164cb	6	loc_6fc8a029	pkg_8a019595	t	2025-08-06	2025-08-07 17:02:16	\N
e003b78f-874d-43db-99c3-694920ade6ad	Collection Manager (Financial Services)	Full-time	comp_1b1164cb	8	loc_6fc8a029	pkg_8a019595	t	2025-08-06	2025-08-07 17:02:16	\N
97cd17c2-2acd-400d-8db7-b8dda008348e	Head of Consumer (Financial Services)	Full-time	comp_1b1164cb	4	loc_6fc8a029	pkg_8a019595	t	2025-08-06	2025-08-07 17:02:16	\N
b089816b-ec08-4c62-9b07-5c2228349300	Product Manager (Mekari Jurnal)	Full-time	comp_1b1164cb	3	loc_6fc8a029	pkg_8a019595	t	2025-08-06	2025-08-07 17:02:16	\N
fbec3072-c70f-48a1-8ba0-5fc50b9fead3	Senior Product Manager (Mekari Talenta)	Full-time	comp_1b1164cb	3	loc_6fc8a029	pkg_8a019595	t	2025-08-06	2025-08-07 17:02:16	\N
d58b8c6b-0fa9-4f6b-8c2f-876c92757d98	QA Engineer II	Full-time	comp_1b1164cb	14	loc_6fc8a029	pkg_8a019595	t	2025-08-06	2025-08-07 17:02:16	\N
5c18ffcf-de7e-4b29-888d-7acdc020c86e	Content Strategist	Full-time	comp_df9ed564	5	loc_6fc8a029	pkg_3d6a9c67	t	2025-08-05	2025-08-07 17:02:16	\N
ecba7248-20c6-4f84-aa75-c2ed6fec8022	Data Architecture & Modelling - Multifinance Industry	Contract	comp_64e3bb93	6	loc_6fc8a029	pkg_316c2cbb	t	2025-08-05	2025-08-07 17:02:16	\N
e743d946-3023-418f-8175-9987eedaeed9	.Net Developer - Location: Karawaci	Contract	comp_64e3bb93	1	loc_8d0798bb	pkg_da30dd4c	t	2025-08-05	2025-08-07 17:02:16	\N
2d370df5-4992-4436-9cdf-dc05d04a5e70	Golang Developer (for FinTech/Leasing Industry)	Full-time	comp_64e3bb93	2	loc_6fc8a029	pkg_de1249bf	t	2025-08-05	2025-08-07 17:02:16	\N
c4cde7e3-82a4-4eb0-8968-3396fc4668cf	IT Project Manager for Retail Industry	Full-time	comp_64e3bb93	9	loc_b3feaf63	pkg_21a93f57	t	2025-08-05	2025-08-07 17:02:16	\N
0d3caa55-d416-4fc6-b1d7-6c0315861e49	Golang Developer (Banking Industry)	Contract	comp_64e3bb93	2	loc_6fc8a029	pkg_3c9de70a	t	2025-08-05	2025-08-07 17:02:16	\N
29514f7a-53a7-406a-a818-1164e4d194d4	Finance Accounting	Full-time	comp_e1f1e2cb	8	loc_6fc8a029	pkg_8a019595	t	2025-08-05	2025-08-07 17:02:16	\N
37f1a2b2-676e-4968-a290-01558c79bee8	Cashier (Bank & Treasury)	Full-time	comp_e1f1e2cb	8	loc_6fc8a029	pkg_8a019595	t	2025-08-05	2025-08-07 17:02:16	\N
a7856df8-29b0-4530-ba82-a568168236d3	Data Engineer	Full-time	comp_1b1164cb	6	loc_6fc8a029	pkg_8a019595	t	2025-08-05	2025-08-07 17:02:16	\N
e7e7a841-5a54-4778-9d11-ae388ca46586	IT Security (Cyberark)	Full-time	comp_fb7b7841	1	loc_6fc8a029	pkg_253c02c5	t	2025-08-05	2025-08-07 17:02:16	\N
54376caa-b63a-4af1-b66c-58c28230dc9e	Graphic Designer Intern	Internship	comp_a421fc5e	12	loc_5ac55fb0	pkg_8a019595	t	2025-08-04	2025-08-07 17:02:16	\N
9a7a3460-dddd-42a4-b8d8-7e97d5571b6d	Graphic Designer Intern	Internship	comp_a421fc5e	12	loc_9597ddfd	pkg_8a019595	t	2025-08-04	2025-08-07 17:02:16	\N
a9a61c06-d39f-44a2-804f-a23078614c92	L2 - Storage SAN Switch Engineer	Contract	comp_8acb43dd	1	loc_6fc8a029	pkg_64d51dde	t	2025-08-04	2025-08-07 17:02:16	\N
2fa0bddd-5726-4374-ab4e-0fd90899cca4	Java Quarkus Developer	Full-time	comp_786c073f	1	loc_6fc8a029	pkg_8a019595	t	2025-08-04	2025-08-07 17:02:16	\N
5dc30750-5da5-41f0-b713-a8eeb47687b1	Community Officer Intern (Influence ID)	Internship	comp_3c413fc6	21	loc_6fc8a029	pkg_67eb88f3	t	2025-08-04	2025-08-07 17:02:16	\N
80ddfd80-d944-4d50-bca1-16d8ea0ce0cd	Internship Brand Communication	Internship	comp_8179f80d	7	loc_6fc8a029	pkg_8a019595	t	2025-08-04	2025-08-07 17:02:16	\N
8aa2bd27-2758-4e58-881a-8f16218979cd	Finance and Accounting Intern	Full-time	comp_a421fc5e	8	loc_9597ddfd	pkg_8a019595	t	2025-08-02	2025-08-07 17:02:16	\N
71c0c202-2bc2-4a89-ab24-fd90cdcbeede	Digital Marketing Specialist	Full-time	comp_a19f0fd8	5	loc_6fc8a029	pkg_d5506bd4	t	2025-08-01	2025-08-07 17:02:16	\N
56e7fe17-fd06-46e5-b556-d0aa21e5d8d6	Jr. Mobile Developer	Contract	comp_5fe50081	2	loc_9597ddfd	pkg_8a019595	t	2025-08-01	2025-08-07 17:02:16	\N
f5d82877-71f1-4114-885f-075552a19c57	SQL Database Engineer	Full-time	comp_fb7b7841	6	loc_6fc8a029	pkg_5da31994	t	2025-08-01	2025-08-07 17:02:16	\N
b8c8da94-dd1d-4823-8eb2-a31a3cc07f2a	Sales Admin	Full-time	comp_fe107d99	4	loc_6fc8a029	pkg_15bfbc3e	t	2025-08-01	2025-08-07 17:02:16	\N
9463b278-0aa9-4388-8dc3-5eaae4914d35	Social Media Content Creator	Full-time	comp_3815c364	7	loc_6fc8a029	pkg_8a019595	t	2025-08-01	2025-08-07 17:02:16	\N
7d67c1d9-af6b-4dfd-9a28-a49c55692b97	Organization Development Associate	Full-time	comp_1b1164cb	11	loc_6fc8a029	pkg_8a019595	t	2025-07-31	2025-08-07 17:02:16	\N
f3bc42c8-6d74-48e1-b866-cdf63d3707d7	DevOps - Banking Industry	Contract	comp_64e3bb93	10	loc_6fc8a029	pkg_1b1784b6	t	2025-07-31	2025-08-07 17:02:16	\N
f4408537-d901-4450-b1f0-63479a4ceb04	Front End Developer - Banking Industry	Contract	comp_64e3bb93	1	loc_6fc8a029	pkg_76cbc06a	t	2025-07-31	2025-08-07 17:02:16	\N
5716d24d-a46d-4b50-9f3d-6035d98c2fbf	Senior Fullstack Engineer - Banking Industry	Contract	comp_64e3bb93	1	loc_6fc8a029	pkg_0f9256ca	t	2025-07-31	2025-08-07 17:02:16	\N
9158ec39-b598-4815-b049-1ad43b0e6f98	Junior QA Automation - Banking Industry	Contract	comp_64e3bb93	14	loc_6fc8a029	pkg_73c134e8	t	2025-07-31	2025-08-07 17:02:16	\N
c6dffc92-b8c4-46d6-879a-5d19a795cefd	Junior Technical Writer - Banking Industry	Contract	comp_64e3bb93	6	loc_6fc8a029	pkg_73c134e8	t	2025-07-31	2025-08-07 17:02:16	\N
51152994-4866-49ed-bbdf-a6ce6b2fb6da	Fullstack Developer	Full-time	comp_d2f535ed	2	loc_6fc8a029	pkg_8a019595	t	2025-07-31	2025-08-07 17:02:16	\N
5a35c0dc-4bed-4c60-a58b-a59097fbfad7	Brand Communication (Project Based)	Contract	comp_8179f80d	7	loc_6fc8a029	pkg_8a019595	t	2025-07-31	2025-08-07 17:02:16	\N
0e576122-2e12-4c49-a704-fd9381c4cfaa	Internship Reporter Otomotif (kumparan Academy)	Internship	comp_8179f80d	7	loc_6fc8a029	pkg_8a019595	t	2025-07-31	2025-08-07 17:02:16	\N
d5482011-021d-4bbb-9734-4b91f3473af5	Graphic Designer (Maternity Leave)	Contract	comp_8179f80d	7	loc_6fc8a029	pkg_8a019595	t	2025-07-31	2025-08-07 17:02:16	\N
6937d8dc-8523-4764-9f96-c08fa1c216fb	Backend Engineer (Golang Developer)	Full-time	comp_8179f80d	1	loc_6fc8a029	pkg_8a019595	t	2025-07-31	2025-08-07 17:02:16	\N
39818b8f-8a60-47ea-8a56-ff2ffe2d1fb3	Videographer (Automotive)	Full-time	comp_8179f80d	7	loc_6fc8a029	pkg_8a019595	t	2025-07-31	2025-08-07 17:02:16	\N
2d057fa5-ee00-4782-ae7d-7833cb112f50	IT Support	Contract	comp_786c073f	10	loc_6fc8a029	pkg_8a019595	t	2025-07-31	2025-08-07 17:02:16	\N
b7e484b3-6e63-474c-87c6-7f10398a0f0c	IT Business Analys	Contract	comp_786c073f	6	loc_6fc8a029	pkg_8a019595	t	2025-07-31	2025-08-07 17:02:16	\N
e6867d8a-1d08-44c5-ab42-aab712977590	Sales Engineer	Full-time	comp_275c3945	4	loc_b1dddaa6	pkg_3d6a9c67	t	2025-07-31	2025-08-07 17:02:16	\N
588d8bae-aa31-4a19-9eea-db416ef34a8e	Cybersecurity Engineer	Contract	comp_dc7c8654	13	loc_6fc8a029	pkg_2958d81b	t	2025-07-31	2025-08-07 17:02:16	\N
b8e237a9-c38d-48bd-b911-c837c8a0e450	Frontend & Backend Developer (Long term project)	Contract	comp_c4301255	2	loc_6fc8a029	pkg_e90aec12	t	2025-07-31	2025-08-07 17:02:16	\N
2364bf60-f3ae-4519-8551-e841edbe399c	Managed Service Engineer	Full-time	comp_15920e21	13	loc_6fc8a029	pkg_8a019595	t	2025-07-31	2025-08-07 17:02:16	\N
6e8d0c54-f397-4b16-8fe0-c5a54bd77cbe	Back End Developer (Java Springboot) - Banking Syariah Industry	Contract	comp_64e3bb93	1	loc_6fc8a029	pkg_21a93f57	t	2025-07-30	2025-08-07 17:02:16	\N
a30f2c6b-ebaf-43a8-94f3-3fefcbd37a3c	Branch Manager - Education	Full-time	comp_a421fc5e	4	loc_9597ddfd	pkg_8a019595	t	2025-07-30	2025-08-07 17:02:16	\N
08dfe30b-9029-4b86-b769-4369613794c5	IT Development Squad Lead - Banking Industry	Contract	comp_64e3bb93	1	loc_8d0798bb	pkg_608ea1fd	t	2025-07-30	2025-08-07 17:02:16	\N
f5dd469c-c8d2-47e9-a2db-45e117128495	SPG/B (Female Daily Studio Shop in Shop Metro Margo City)	Contract	comp_3815c364	26	loc_357d0063	pkg_8a019595	t	2025-07-30	2025-08-07 17:02:16	\N
628ac2e4-ba2f-4060-b2cd-4faa05899501	IT Support Veeva Engineer	Contract	comp_786c073f	2	loc_6fc8a029	pkg_8a019595	t	2025-07-30	2025-08-07 17:02:16	\N
e1b86eca-622a-4312-97ad-4204a342b254	Tax Specialist	Full-time	comp_b3934155	8	loc_6fc8a029	pkg_8a019595	t	2025-07-30	2025-08-07 17:02:16	\N
46b9e62b-c91d-43b5-aa33-7e75d017edc9	Commercial Admin - Female Daily Studio by Female Daily Network	Full-time	comp_3815c364	26	loc_6fc8a029	pkg_8a019595	t	2025-07-30	2025-08-07 17:02:16	\N
e5730d11-4597-42b5-905f-24866aaed6c5	Merchandiser (Beauty- Content & Channel Execution) - Female Daily Studio by Female Daily Network	Full-time	comp_3815c364	26	loc_6fc8a029	pkg_8a019595	t	2025-07-30	2025-08-07 17:02:16	\N
65226552-d585-40d2-ab66-4dbae3326c03	Sr Merchandiser (Beauty - Demand Planner & Forecaster) - Female Daily Studio by Female Daily Network	Full-time	comp_3815c364	26	loc_6fc8a029	pkg_8a019595	t	2025-07-30	2025-08-07 17:02:16	\N
45b6ba54-d7f1-4f4c-b105-b8eb77d92406	iOS Software Engineer - Kompas.id	Contract	comp_225c3925	2	loc_6fc8a029	pkg_8a019595	t	2025-07-30	2025-08-07 17:02:16	\N
5f266fdc-6f34-4a59-9aee-77b9c969e71a	Funding Tester - Banking Industry	Contract	comp_64e3bb93	14	loc_6fc8a029	pkg_982fea78	t	2025-07-30	2025-08-07 17:02:16	\N
558dc34e-17ca-41cb-84ef-80701ecaf039	Integration Tester - Banking Industry	Contract	comp_64e3bb93	14	loc_6fc8a029	pkg_4140485c	t	2025-07-30	2025-08-07 17:02:16	\N
eee1ff3c-bec2-4c04-b441-cea6fac6f132	Trading Bot Engineer	Full-time	comp_d2f535ed	1	loc_6fc8a029	pkg_8a019595	t	2025-07-30	2025-08-07 17:02:16	\N
81225456-d4e7-4ab1-b224-648b541f5c7e	IT Incindent Engineer L2	Full-time	comp_cb2b14c7	14	loc_6fc8a029	pkg_8a019595	t	2025-07-30	2025-08-07 17:02:16	\N
72a438cc-14dd-40a8-8116-b237748b0c5a	Account Executif	Full-time	comp_786c073f	4	loc_6fc8a029	pkg_8a019595	t	2025-07-30	2025-08-07 17:02:16	\N
3ef2fe17-9575-4543-9600-ac1c8424e1fa	Branch Manager	Full-time	comp_a421fc5e	4	loc_5ac55fb0	pkg_8a019595	t	2025-07-29	2025-08-07 17:02:16	\N
4ef31eb8-43e1-4cfb-be3d-6c0db406fd9c	UX Researcher	Full-time	comp_ea2144e3	24	loc_6fc8a029	pkg_8a019595	t	2025-07-29	2025-08-07 17:02:16	\N
f0836a67-79bd-4364-a62b-88c74e50bcdc	Senior Copywriter	Full-time	comp_ce1667a1	5	loc_6fc8a029	pkg_8a019595	t	2025-07-29	2025-08-07 17:02:16	\N
ca3e0798-e7d4-4e41-a0f3-a43d498a37b7	Network Engineer	Contract	comp_acfe08af	1	loc_6fc8a029	pkg_3d6a9c67	t	2025-07-29	2025-08-07 17:02:16	\N
ab54f0e3-6f69-4c8b-898a-a0abd403e072	Project Management Intern	Internship	comp_001cf410	3	loc_6fc8a029	pkg_8a019595	t	2025-07-29	2025-08-07 17:02:16	\N
cdc205d6-f38b-41c7-b336-29e4594a505d	Growth Intern	Internship	comp_001cf410	4	loc_6fc8a029	pkg_8a019595	t	2025-07-28	2025-08-07 17:02:16	\N
ae91c87e-b7e5-43a8-8a47-a9b7755654c2	Strategic Change Lead – Core Banking Implementation	Full-time	comp_64e3bb93	1	loc_6fc8a029	pkg_6a83c388	t	2025-07-28	2025-08-07 17:02:16	\N
a9c4d55b-6b85-4919-bbc2-c841b3d88f8f	Event Strategist	Full-time	comp_e1f1e2cb	5	loc_6fc8a029	pkg_8a019595	t	2025-07-28	2025-08-07 17:02:16	\N
cb146bf8-2fc9-44a0-bbe7-eb1b1711803b	Data Center Engineer	Contract	comp_fb7b7841	13	loc_5cca93cb	pkg_cf7c1d4a	t	2025-07-28	2025-08-07 17:02:16	\N
d7de96e8-8109-42d8-a0da-89e208dab1fe	Web Development Intern	Internship	comp_001cf410	2	loc_6fc8a029	pkg_8a019595	t	2025-07-28	2025-08-07 17:02:16	\N
aea10cd8-a72c-4762-991f-094e9901822d	PM Maintenance	Contract	comp_dc7c8654	3	loc_6fc8a029	pkg_838c6091	t	2025-07-28	2025-08-07 17:02:16	\N
7470bc24-f20c-40a0-a508-27181fe90ccd	Facility & Service Office Management Officer (CV Seng Lie)	Contract	comp_275c3945	11	loc_b3feaf63	pkg_81ad9c08	t	2025-07-28	2025-08-07 17:02:16	\N
13dc4a1d-1524-4815-a5a3-2714dfa3e2cb	.Net Developer (for Banking Industry)	Full-time	comp_64e3bb93	2	loc_6fc8a029	pkg_fcfc528b	t	2025-07-28	2025-08-07 17:02:16	\N
98ba9533-bfec-4f18-bff4-399f4df9aa3f	Talent Acquisition Intern	Internship	comp_a421fc5e	11	loc_9597ddfd	pkg_8a019595	t	2025-07-28	2025-08-07 17:02:16	\N
9111a36e-43a3-4f07-8cb2-ccc036e36ffd	IT Server Support (for Technology Industry)	Full-time	comp_64e3bb93	13	loc_8d0798bb	pkg_15bfbc3e	t	2025-07-28	2025-08-07 17:02:16	\N
ea5666ac-c049-4b45-b1b5-6eb009a11a60	IT Asset Management (for Technology Industry)	Full-time	comp_64e3bb93	25	loc_8d0798bb	pkg_5da31994	t	2025-07-28	2025-08-07 17:02:16	\N
f830ded8-3900-48a8-955c-8125af8969b3	IT Service Delivery Manager (for Technology Industry)	Full-time	comp_64e3bb93	2	loc_8d0798bb	pkg_8fe51175	t	2025-07-28	2025-08-07 17:02:16	\N
e31bcd64-f5f5-4b9b-a52b-d7508d4241e7	Network Engineer / Wireless Engineer (for Mining Industry)	Full-time	comp_64e3bb93	2	loc_6fc8a029	pkg_da30dd4c	t	2025-07-28	2025-08-07 17:02:16	\N
eb558d8c-1a08-4007-b86d-7301b0752e3a	Golang Developer - Banking Industry	Contract	comp_64e3bb93	1	loc_6fc8a029	pkg_cc1168ba	t	2025-07-28	2025-08-07 17:02:16	\N
aee144c3-89b4-49ae-b593-e9a6771477ab	.Net Developer - Banking Industry	Contract	comp_64e3bb93	1	loc_6fc8a029	pkg_cc1168ba	t	2025-07-28	2025-08-07 17:02:16	\N
af7815fb-5211-4b63-9c60-4248992de9b9	Lead IT Change Management - Banking Industry	Contract	comp_64e3bb93	3	loc_6fc8a029	pkg_fd0eecda	t	2025-07-28	2025-08-07 17:02:16	\N
6a528ad7-c246-4123-a409-859b4014ede5	Lead Infrastructure - Banking Industry	Contract	comp_64e3bb93	13	loc_6fc8a029	pkg_3ba1dc2d	t	2025-07-26	2025-08-07 17:02:16	\N
6efa25e0-5b7f-4f2f-955c-fc69ad1c506c	IT Change Management (Core Banking R24) - Banking Industry	Contract	comp_64e3bb93	3	loc_6fc8a029	pkg_c6dcb635	t	2025-07-26	2025-08-07 17:02:16	\N
c9ebbd2b-7e8d-45f2-8bfc-f3b445bcfc08	Product Owner - Insurance Industry (Exp: Investment)	Contract	comp_64e3bb93	3	loc_6fc8a029	pkg_21a93f57	t	2025-07-26	2025-08-07 17:02:16	\N
4f5a70c3-18de-424c-acc6-308e1a775b03	Office Staff (No Experience Needed)	Full-time	comp_f2d8ee5e	8	loc_6fc8a029	pkg_567d01d6	t	2025-07-25	2025-08-07 17:02:16	\N
a302c505-86e3-441a-985e-cde705444b7b	Finance Associate (Accounts Receivable)	Full-time	comp_f2d8ee5e	8	loc_6fc8a029	pkg_567d01d6	t	2025-07-25	2025-08-07 17:02:16	\N
1effbbbb-f726-4722-967a-6cc1e0387373	Asset Management Officer	Full-time	comp_8179f80d	7	loc_6fc8a029	pkg_8a019595	t	2025-07-25	2025-08-07 17:02:16	\N
4c788126-75eb-43ce-b9d7-9f61b99b1d4c	Human Resources (Fresh Graduate Program)	Internship	comp_bd648634	11	loc_6fc8a029	pkg_11193b2f	t	2025-07-25	2025-08-07 17:02:16	\N
9adf4879-89ca-4811-b366-5440aaf664dc	Social Media Officer (Student Trainee)	Internship	comp_bd648634	5	loc_6fc8a029	pkg_8a019595	t	2025-07-25	2025-08-07 17:02:16	\N
e028960f-2a9f-42e4-85a3-1387b9ba6bcf	Human Resources Manager	Full-time	comp_bd648634	11	loc_6fc8a029	pkg_841aab7e	t	2025-07-25	2025-08-07 17:02:16	\N
034e245a-bcec-4107-a53a-1f649ef4fb7e	Frontend Engineer (Student Trainee Program)	Internship	comp_bd648634	2	loc_6fc8a029	pkg_8a019595	t	2025-07-25	2025-08-07 17:02:16	\N
eba4f426-b414-46b7-bdb6-bc3839db5fe1	Public Relation Fresh Graduate Internship Program	Internship	comp_bd648634	7	loc_6fc8a029	pkg_11193b2f	t	2025-07-25	2025-08-07 17:02:16	\N
83217b78-5caa-4933-a671-2a2c05bd0c22	Front End Developer - (Fresh Graduate Internship Program)	Internship	comp_bd648634	2	loc_6fc8a029	pkg_11193b2f	t	2025-07-25	2025-08-07 17:02:16	\N
8b2e7465-477f-422e-a147-d664fe8f824f	Digital Marketing (Student Trainee)	Internship	comp_bd648634	5	loc_6fc8a029	pkg_8a019595	t	2025-07-25	2025-08-07 17:02:16	\N
0ef34561-69cf-4a29-8b74-74ecccec271e	Junior Public Relation Consultant	Full-time	comp_bd648634	5	loc_6fc8a029	pkg_54e03c9e	t	2025-07-25	2025-08-07 17:02:16	\N
b94f3b17-c1c9-45e7-a507-955309db1187	Human Resources Manager / Tech Recruiter (Jakarta)	Full-time	comp_bd648634	11	loc_6fc8a029	pkg_136922f5	t	2025-07-25	2025-08-07 17:02:16	\N
e6e56728-9f94-46c3-88d0-65d05344ea55	Junior Business Consultant	Full-time	comp_bd648634	4	loc_6fc8a029	pkg_5047dbae	t	2025-07-25	2025-08-07 17:02:16	\N
ab1c7d2c-9fc3-4c13-93c8-5ff1d854cead	Project Manager (Fresh Graduate - Internship Program)	Internship	comp_bd648634	3	loc_6fc8a029	pkg_11193b2f	t	2025-07-25	2025-08-07 17:02:16	\N
a62e5412-3b14-4e4a-a246-c581d23b4b73	Tech Recruiter	Full-time	comp_bd648634	11	loc_6fc8a029	pkg_5047dbae	t	2025-07-25	2025-08-07 17:02:16	\N
9fea77be-2214-4654-bc22-84e4224a370e	Human Resources (Fresh Graduate Internship Program)	Internship	comp_bd648634	11	loc_6fc8a029	pkg_11193b2f	t	2025-07-25	2025-08-07 17:02:16	\N
c940f1a1-917a-4a0c-b1fb-b5042280d519	Junior Project Manager	Full-time	comp_bd648634	3	loc_6fc8a029	pkg_5da31994	t	2025-07-25	2025-08-07 17:02:16	\N
19011c9b-4537-42e0-9b81-d8ff7eeaa0a7	Fullstack Engineer	Contract	comp_bd648634	2	loc_6fc8a029	pkg_ef5b1e77	t	2025-07-25	2025-08-07 17:02:16	\N
aa0da3ce-6640-4690-bf25-3728ca6e20ca	Finance & Admin (Fresh Graduate Internship Program)	Internship	comp_bd648634	8	loc_6fc8a029	pkg_11193b2f	t	2025-07-25	2025-08-07 17:02:16	\N
3fc68f71-a744-4488-b0c1-092d4ffa9111	Business Development Specialist - Teknologi.id	Contract	comp_bd648634	4	loc_6fc8a029	pkg_8a019595	t	2025-07-25	2025-08-07 17:02:16	\N
5697685d-27c8-4059-bf69-3e638b4dc678	Head of Finance	Full-time	comp_bd648634	8	loc_6fc8a029	pkg_5047dbae	t	2025-07-25	2025-08-07 17:02:16	\N
1e243391-651b-4d5c-adbc-c7dd0ac4ec59	QA Engineer (Fresh Graduate Internship Program)	Internship	comp_bd648634	2	loc_6fc8a029	pkg_11193b2f	t	2025-07-25	2025-08-07 17:02:16	\N
350d472a-1a90-4e19-9a22-5485c834ad05	Digital Marketing (Fresh Graduate Internship Program)	Internship	comp_bd648634	5	loc_6fc8a029	pkg_11193b2f	t	2025-07-25	2025-08-07 17:02:16	\N
6ea272e5-3b79-46bb-9dbe-b46ba1c39058	Digital Marketing & Crisis Mgmt. Manager	Full-time	comp_bd648634	5	loc_6fc8a029	pkg_f590c5cc	t	2025-07-25	2025-08-07 17:02:16	\N
23f97a6e-ef23-4ec6-9f68-87789d0655f5	Business Development Associate (Technology)	Full-time	comp_bd648634	4	loc_6fc8a029	pkg_e90aec12	t	2025-07-25	2025-08-07 17:02:16	\N
b3ade0db-584a-4961-90e2-7dd029569bf4	Technology Consultant	Full-time	comp_bd648634	15	loc_6fc8a029	pkg_841aab7e	t	2025-07-25	2025-08-07 17:02:16	\N
bed5c820-be86-4db9-b15d-73276e60a5ba	Front End Engineer ( Jr - Mid )	Contract	comp_20ac7aef	2	loc_6fc8a029	pkg_ef5b1e77	t	2025-07-24	2025-08-07 17:02:16	\N
8f77d309-cd88-437b-8422-a3c845746c1b	Finance, Accounting, Tax (FAT)	Full-time	comp_59761619	8	loc_6fc8a029	pkg_56c227b2	t	2025-07-24	2025-08-07 17:02:16	\N
d54c7cf8-a2cc-4080-9346-202996af0721	Reporter News (International)	Full-time	comp_8179f80d	7	loc_6fc8a029	pkg_8a019595	t	2025-07-24	2025-08-07 17:02:16	\N
2ac5fa0d-696f-45ce-af00-485e4eb2368b	IT Data Center & Hub Room Support	Full-time	comp_fb7b7841	9	loc_6fc8a029	pkg_05c72e6d	t	2025-07-24	2025-08-07 17:02:16	\N
d71b4a20-f6ec-4e81-94f3-a113ad61b89a	Event Purchasing (Procurement Officer)	Full-time	comp_8179f80d	7	loc_6fc8a029	pkg_8a019595	t	2025-07-24	2025-08-07 17:02:16	\N
2ec59cca-629c-4888-88e4-90d29c73a9d0	Technical Support	Contract	comp_dc7c8654	13	loc_6fc8a029	pkg_31b62d7d	t	2025-07-24	2025-08-07 17:02:16	\N
f4a6f547-ec5c-4f23-a704-11cb67d3e1ea	Laboratory & Studio Center Section Head	Full-time	comp_4b30ef66	10	loc_be3832cb	pkg_9749583d	t	2025-07-24	2025-08-07 17:02:16	\N
feb332ab-2419-4b77-8107-1c4f4bd7f868	Videographer & Photographer	Full-time	comp_3815c364	7	loc_6fc8a029	pkg_8a019595	t	2025-07-24	2025-08-07 17:02:16	\N
377b814e-1c37-4e76-8c04-876033ffdfa5	Jr Quality Assurance	Contract	comp_786c073f	14	loc_6fc8a029	pkg_8a019595	t	2025-07-24	2025-08-07 17:02:16	\N
a5c90d45-3d25-498b-a818-670af0a5787b	Software Quality Assurance Manual	Full-time	comp_e95a250b	1	loc_6fc8a029	pkg_8a019595	t	2025-07-24	2025-08-07 17:02:16	\N
a1293313-5f6f-494b-b5c4-89ba07ae2937	Network Engineer CCNA	Full-time	comp_fb7b7841	9	loc_cb52e018	pkg_136922f5	t	2025-07-24	2025-08-07 17:02:16	\N
cefeae6c-4cb2-422e-bdf6-b6d91455f192	Subject Content Coordinator - Digital Psychology	Full-time	comp_4b30ef66	16	loc_6dd4ee2b	pkg_8a019595	t	2025-07-24	2025-08-07 17:02:16	\N
e5f0fa0a-6210-4f30-97c2-aebee9541d7d	Account Strategist [Mediatics]	Full-time	comp_3c413fc6	5	loc_6fc8a029	pkg_8a019595	t	2025-07-23	2025-08-07 17:02:16	\N
7f04bac8-0481-4b6a-ab41-331af43da00b	Motion Graphic Designer	Full-time	comp_ea2144e3	12	loc_6fc8a029	pkg_8a019595	t	2025-07-23	2025-08-07 17:02:16	\N
fe2cb81d-2ce6-49f9-a21b-3d449793c98f	Reporter News	Full-time	comp_8179f80d	7	loc_6fc8a029	pkg_8a019595	t	2025-07-23	2025-08-07 17:02:16	\N
779c8749-cd6e-42c8-983a-cdc31360661f	IT Development Squad Lead (Banking Industry/Can Join ASAP)	Contract	comp_64e3bb93	2	loc_9597ddfd	pkg_464f2da5	t	2025-07-23	2025-08-07 17:02:16	\N
a975e9d6-9dce-4d7c-9ad1-f6c00bd99d71	.Net Developer	Contract	comp_64e3bb93	2	loc_9597ddfd	pkg_397cfc37	t	2025-07-23	2025-08-07 17:02:16	\N
3af59f80-8e10-498c-afe2-047a7ad036ad	Associate Product Manager (Remote)	Full-time	comp_af4343c8	3	loc_6fc8a029	pkg_93d06655	t	2025-07-23	2025-08-07 17:02:16	\N
6b459996-9781-4c7b-be42-6de7c12aa53e	IT Solution Architect for Banking Industry	Full-time	comp_64e3bb93	1	loc_6fc8a029	pkg_05c72e6d	t	2025-07-23	2025-08-07 17:02:16	\N
8ba50f92-afd9-4372-8305-73ad82ddc51c	Solution Architect	Contract	comp_dc7c8654	15	loc_6fc8a029	pkg_31b62d7d	t	2025-07-23	2025-08-07 17:02:16	\N
dc2d1f0b-b9b5-4234-b047-b03f89fe2604	Web Engineer Freelance Corporate IT & IS	Freelance	comp_225c3925	2	loc_6fc8a029	pkg_8a019595	t	2025-07-22	2025-08-07 17:02:16	\N
419ea29e-74c9-406f-930c-c9cd69132132	Senior Frontend Developer	Full-time	comp_539457fc	2	loc_9597ddfd	pkg_5a12623d	t	2025-07-22	2025-08-07 17:02:16	\N
b5bebb6d-796f-4890-8706-19575f9241c5	Multimedia Designer	Full-time	comp_cec98ce6	12	loc_b3feaf63	pkg_8a019595	t	2025-07-22	2025-08-07 17:02:16	\N
058dac06-2440-4454-8ee6-149d17309aa3	Senior FrontEnd Engineer	Full-time	comp_ea2144e3	1	loc_6fc8a029	pkg_8a019595	t	2025-07-21	2025-08-07 17:02:16	\N
305fee6e-09b3-4cb5-86ae-97539df741bd	Mobile Developer - Banking Industry	Contract	comp_64e3bb93	18	loc_8d0798bb	pkg_8fe51175	t	2025-07-21	2025-08-07 17:02:16	\N
2242a1ed-654d-42c1-a8c6-b5975edd5a14	Back End Developer (Golang & Java Springboot) - Banking Industry	Contract	comp_64e3bb93	1	loc_8d0798bb	pkg_8fe51175	t	2025-07-21	2025-08-07 17:02:16	\N
1687f802-a2fc-4a0b-8538-65f35370a853	Part-time Project Administration	Part-time	comp_4b30ef66	3	loc_6fc8a029	pkg_9749583d	t	2025-07-21	2025-08-07 17:02:16	\N
91191f8b-28d6-4b11-bed9-4a99f1b05bce	SAILORS Program - Project Operations Intern	Internship	comp_74da6410	3	loc_6fc8a029	pkg_67eb88f3	t	2025-07-21	2025-08-07 17:02:16	\N
7acec4ed-1b5b-421c-bd13-e0e1c63ddecc	Study Advisor (Telesales)	Full-time	comp_a421fc5e	4	loc_3377aa9f	pkg_f2381a89	t	2025-07-21	2025-08-07 17:02:16	\N
5e7228dc-809e-48c9-b02f-062512e64daf	Tester (Core Banking)	Contract	comp_64e3bb93	14	loc_9597ddfd	pkg_838c6091	t	2025-07-19	2025-08-07 17:02:16	\N
eab1bcdb-2ed6-47f4-b212-c7aca410d830	Product Manager	Full-time	comp_b6131bf8	1	loc_6fc8a029	pkg_8a019595	t	2025-07-18	2025-08-07 17:02:16	\N
c7d22adc-22bb-4d71-af19-9071976cde3c	Graphic Designer - Lampung	Full-time	comp_a421fc5e	12	loc_5ac55fb0	pkg_8a019595	t	2025-07-18	2025-08-07 17:02:16	\N
870e6c77-ef16-4249-96bd-063d4c349aaf	Full Stack Developer (PT Gadai Syariah Indonesia)	Full-time	comp_275c3945	18	loc_6fc8a029	pkg_971bb9b1	t	2025-07-17	2025-08-07 17:02:16	\N
f9472348-7165-4e61-b5bd-7bdea8b2e96c	Scrum Master	Full-time	comp_0e44bed7	18	loc_6fc8a029	pkg_95ae8f1d	t	2025-07-17	2025-08-07 17:02:16	\N
c4e17d2d-b2d6-4425-9361-d15743356ef0	Database Administrator - Insurance Industry	Contract	comp_64e3bb93	6	loc_6fc8a029	pkg_8cde7994	t	2025-07-16	2025-08-07 17:02:16	\N
7efdd854-b10b-470a-9208-b20d49754e6f	Mobile Developer (Banking Industry)	Contract	comp_64e3bb93	18	loc_9597ddfd	pkg_09890443	t	2025-07-16	2025-08-07 17:02:16	\N
f49e85dc-a6b7-42c0-adc7-921ea806a207	IT Support	Full-time	comp_a421fc5e	9	loc_9597ddfd	pkg_8a019595	t	2025-07-16	2025-08-07 17:02:16	\N
9e93df28-039d-45c9-9d51-7ded9156f73d	Product Manger - Auto loan	Full-time	comp_cb2b14c7	3	loc_148693f5	pkg_8a019595	t	2025-07-16	2025-08-07 17:02:16	\N
725d0369-6868-4210-ad0a-7db3448c9ace	Backend Developer (Java Springboot) for Banking Industry	Full-time	comp_64e3bb93	2	loc_6fc8a029	pkg_64d51dde	t	2025-07-16	2025-08-07 17:02:16	\N
54026e49-9010-4a1c-97bb-285a95afad47	UX Writer	Full-time	comp_ea2144e3	24	loc_6fc8a029	pkg_8a019595	t	2025-07-16	2025-08-07 17:02:16	\N
73d9e245-73ab-4726-8532-ece13e32adf6	Fullstack Developer (.Net & React Js)	Full-time	comp_64e3bb93	2	loc_6fc8a029	pkg_3ba1dc2d	t	2025-07-16	2025-08-07 17:02:16	\N
88e419ae-5e3a-4557-aade-0499d4e0f14e	Data Engineer (Middle)	Contract	comp_64e3bb93	6	loc_6fc8a029	pkg_1b1784b6	t	2025-07-16	2025-08-07 17:02:16	\N
d07ec920-5076-44d7-ae7c-c58ea72c82d9	Product Owner - Banking Industry	Contract	comp_64e3bb93	3	loc_6fc8a029	pkg_c6dcb635	t	2025-07-16	2025-08-07 17:02:16	\N
aa49775f-b96f-4ff4-b701-6d05118f83c8	Senior Business Analyst - Banking Industry	Contract	comp_64e3bb93	1	loc_8d0798bb	pkg_8b4c7435	t	2025-07-16	2025-08-07 17:02:16	\N
22916519-e2ee-4123-923c-ae1a07b04fe0	Application Operation Service Desk (for Insurance Industry)	Full-time	comp_64e3bb93	2	loc_6fc8a029	pkg_5da31994	t	2025-07-16	2025-08-07 17:02:16	\N
c098ce9d-095c-43df-bf0c-bc83f0ff2129	iOS Developer - Banking Industry	Contract	comp_64e3bb93	18	loc_6fc8a029	pkg_cc1168ba	t	2025-07-15	2025-08-07 17:02:16	\N
873183b4-1309-4363-9919-256e06e5d784	.Net Developer - Banking Industry	Contract	comp_64e3bb93	1	loc_6fc8a029	pkg_982fea78	t	2025-07-15	2025-08-07 17:02:16	\N
e9758afb-c50c-422c-a1b7-8cacc9e5ceb9	Business Development (Mekari Talenta)	Full-time	comp_1b1164cb	4	loc_6fc8a029	pkg_8a019595	t	2025-07-15	2025-08-07 17:02:16	\N
4d1fadc2-5e48-4b1c-baf1-00688bed5a60	Product Manager (Exp: Artificial Intelligence)	Contract	comp_64e3bb93	3	loc_6fc8a029	pkg_fd0eecda	t	2025-07-15	2025-08-07 17:02:16	\N
d323a728-849e-46c9-a74f-c0a2350d8fe8	Database Engineer - Banking Industry	Contract	comp_64e3bb93	6	loc_6fc8a029	pkg_be9de83f	t	2025-07-15	2025-08-07 17:02:16	\N
99ed555d-326d-4779-ade2-239515cf0360	Service Desk - Insurance Industry	Contract	comp_64e3bb93	9	loc_6fc8a029	pkg_5da31994	t	2025-07-15	2025-08-07 17:02:16	\N
f262603b-fdce-44df-8c18-4ac9cbfc9223	Lecturer - BINUS ASO School of Engineering (Alam Sutera)	Full-time	comp_4b30ef66	16	loc_9597ddfd	pkg_8a019595	t	2025-07-15	2025-08-07 17:02:16	\N
81063159-05c3-4adb-9c50-a82965150cf5	Alumni Communication Staff	Full-time	comp_4b30ef66	20	loc_6fc8a029	pkg_8a019595	t	2025-07-15	2025-08-07 17:02:16	\N
42bf133a-d752-40e7-a266-f4521aa5f4a4	Global Employability & Entrepreneurship Section Head - BINUS @Medan	Full-time	comp_4b30ef66	20	loc_be3832cb	pkg_8a019595	t	2025-07-15	2025-08-07 17:02:16	\N
12527d0b-3155-474c-8d64-b7ae11f22845	Sales & Business Development Manager	Full-time	comp_f2d8ee5e	4	loc_6fc8a029	pkg_8a019595	t	2025-07-15	2025-08-07 17:02:16	\N
60fe98e8-a4cd-4b24-a23c-0b75fee783d4	Operations Manager	Full-time	comp_f2d8ee5e	22	loc_6fc8a029	pkg_8a019595	t	2025-07-15	2025-08-07 17:02:16	\N
9b8996c1-8a0b-4cd9-ab9b-01fea58cd5ae	Young Professionals Fast Track	Full-time	comp_f2d8ee5e	17	loc_6fc8a029	pkg_b9cec660	t	2025-07-15	2025-08-07 17:02:16	\N
026b8663-3985-4c8f-9a10-4a21d6586128	Finance Associate/Senior Associate	Full-time	comp_f2d8ee5e	8	loc_6fc8a029	pkg_31b62d7d	t	2025-07-15	2025-08-07 17:02:16	\N
3ab65afa-80ad-47e1-b20a-9009eb7dc2d2	Sales & Business Development Manager	Full-time	comp_f2d8ee5e	4	loc_6fc8a029	pkg_8a019595	t	2025-07-15	2025-08-07 17:02:16	\N
0237c728-62ad-494b-b3c0-006757d0f9d3	Devops Engineer for Multifinance industry	Full-time	comp_64e3bb93	10	loc_6fc8a029	pkg_3d6a9c67	t	2025-07-15	2025-08-07 17:02:16	\N
89d9df3c-06cf-4b55-ba36-f88d1b4e2d11	Videographer & Live Streaming	Full-time	comp_8179f80d	7	loc_6fc8a029	pkg_8a019595	t	2025-07-14	2025-08-07 17:02:16	\N
82be2332-d58a-4598-bc9e-41d2bb819e90	Junior Project Consultant	Full-time	comp_e95a250b	3	loc_6fc8a029	pkg_8a019595	t	2025-07-14	2025-08-07 17:02:16	\N
7bccc2a7-a480-4f7c-8277-c3f8e75ac4f5	SAILORS Program - Operations Analyst Intern	Internship	comp_74da6410	17	loc_6fc8a029	pkg_67eb88f3	t	2025-07-14	2025-08-07 17:02:16	\N
c686d412-b6b4-40bd-b8c3-ef9f37681b26	SAILORS Program - Quality Assurance Intern	Internship	comp_74da6410	14	loc_6fc8a029	pkg_67eb88f3	t	2025-07-14	2025-08-07 17:02:16	\N
162b5057-54e2-4c90-8f9f-3bddb1958c0a	SAILORS Program - Commercial Excellence Intern	Internship	comp_74da6410	5	loc_6fc8a029	pkg_67eb88f3	t	2025-07-14	2025-08-07 17:02:16	\N
6b72bdbf-39b1-49e8-b577-0090038350cc	Motion Designer Intern	Internship	comp_001cf410	12	loc_6fc8a029	pkg_8a019595	t	2025-07-14	2025-08-07 17:02:16	\N
5e027b7d-ad29-4fae-bd3f-8fd96770c3ad	Preschool Teacher	Full-time	comp_a421fc5e	16	loc_6fc8a029	pkg_8a019595	t	2025-07-14	2025-08-07 17:02:16	\N
4c5427dc-ebd9-47fe-9afb-66ac9090de71	Solutions Architect	Full-time	comp_bdb257ec	4	loc_3179468e	pkg_8a019595	t	2025-06-12	2025-08-08 11:42:39	\N
be972a19-995d-4998-a82f-d51f425e4838	Fullstack Developer	Contract	comp_64e3bb93	1	loc_6fc8a029	pkg_c6dcb635	t	2025-07-12	2025-08-07 17:02:16	\N
5c68f716-dec8-467f-b534-ba7b26df98de	Golang Developer - Banking Industry	Contract	comp_64e3bb93	1	loc_8d0798bb	pkg_ede38846	t	2025-07-12	2025-08-07 17:02:16	\N
7be8a4d3-8d3f-4c20-9147-577e5721480e	Tester Manual - Banking Industry	Contract	comp_64e3bb93	14	loc_8d0798bb	pkg_7cd22d1e	t	2025-07-12	2025-08-07 17:02:16	\N
ac63f8bc-4cec-4a60-97bc-107875f2f4e4	Red Team Leader (PT Solusi Keamanan Bersama)	Full-time	comp_9b8947da	9	loc_9597ddfd	pkg_8a019595	t	2025-07-11	2025-08-07 17:02:16	\N
ba50d362-92a7-469e-b4f8-29619ef7ed10	Back End Developer (Java Springboot) - Banking Industry (ASAP Only)	Contract	comp_64e3bb93	1	loc_6fc8a029	pkg_982fea78	t	2025-07-11	2025-08-07 17:02:16	\N
76f1b790-8348-4c2f-8aad-fafcb0e6c0bc	Freelance Recruiter	Freelance	comp_a1774764	11	loc_b3feaf63	pkg_8a019595	t	2025-07-11	2025-08-07 17:02:16	\N
8e42ec48-b766-49cc-859a-e3a80dfecd61	Wordpress developer	Part-time	comp_f10a1ab8	2	loc_3377aa9f	pkg_5940c19b	t	2025-07-11	2025-08-07 17:02:16	\N
1dcd2329-8835-4366-ba7a-9edd9f2d8f17	PE COACH / Physical Education Coach	Full-time	comp_a421fc5e	16	loc_5ac55fb0	pkg_e09d5c3c	t	2025-07-11	2025-08-07 17:02:16	\N
d3250151-ea4e-4b68-889e-ae84442173a5	Recruiter Freelance	Freelance	comp_cec98ce6	11	loc_b3feaf63	pkg_8a019595	t	2025-07-11	2025-08-07 17:02:16	\N
c2265425-c63f-43bc-8e1d-c0d82a173171	Creative Designer	Full-time	comp_3c413fc6	12	loc_6fc8a029	pkg_8a019595	t	2025-07-10	2025-08-07 17:02:16	\N
822ea87a-72dd-4f7e-9302-33d8700b7cc3	Embedded Engineer	Full-time	comp_1aeaaf2a	13	loc_b3feaf63	pkg_cc1168ba	t	2025-07-10	2025-08-07 17:02:16	\N
a470975e-f61f-48cf-8ae3-590eebe42428	Security Presales Engineer	Full-time	comp_1aeaaf2a	4	loc_6fc8a029	pkg_ede38846	t	2025-07-10	2025-08-07 17:02:16	\N
e22add6f-e53b-4607-9b02-6775d912bdc2	DevOps - Multifinance Industry	Contract	comp_64e3bb93	10	loc_6fc8a029	pkg_316c2cbb	t	2025-07-10	2025-08-07 17:02:16	\N
497715bb-629f-4c54-a05f-be81f31a50c8	Project Manager (Creative Service)	Full-time	comp_cec98ce6	3	loc_6fc8a029	pkg_8a019595	t	2025-07-10	2025-08-07 17:02:16	\N
4775b341-1ac1-4dfb-b87b-25200f7f0e66	AI Engineer - Full WFO	Contract	comp_64e3bb93	1	loc_6fc8a029	pkg_c6dcb635	t	2025-07-10	2025-08-07 17:02:16	\N
456b766e-fca4-45ef-96a6-3598a05ca96c	Devops Engineer (Multifinance Industry)	Contract	comp_64e3bb93	10	loc_6fc8a029	pkg_0fe2546a	t	2025-07-10	2025-08-07 17:02:16	\N
5df863a3-a406-49e8-8a95-eb7829663c8c	IT Support (Female Only)	Contract	comp_64e3bb93	13	loc_9597ddfd	pkg_7783f459	t	2025-07-10	2025-08-07 17:02:16	\N
7a262c26-c32a-4b36-bb29-4743b450ecc9	Quality System Officer	Full-time	comp_4b30ef66	15	loc_6fc8a029	pkg_8a019595	t	2025-07-09	2025-08-07 17:02:16	\N
d747de83-e226-45ac-80d5-fd34ca8045a1	Quality Design - Academic Section Head	Full-time	comp_4b30ef66	15	loc_6fc8a029	pkg_8a019595	t	2025-07-09	2025-08-07 17:02:16	\N
fc56899d-f5b7-4485-bef7-733a8f441f66	Software Engineer - Backend	Full-time	comp_1b1164cb	1	loc_6fc8a029	pkg_8a019595	t	2025-07-09	2025-08-07 17:02:16	\N
3cabff82-2566-49c4-9d94-994f58551401	Product Security Engineer	Full-time	comp_1b1164cb	9	loc_6fc8a029	pkg_8a019595	t	2025-07-09	2025-08-07 17:02:16	\N
7cca5bb7-816d-4c57-93fb-d03368ae0653	Finance Staff - F&B Industry	Contract	comp_64e3bb93	8	loc_6fc8a029	pkg_39740ba4	t	2025-07-09	2025-08-07 17:02:16	\N
78354f3b-2a12-49f5-b5f7-27973894fe27	Senior Android Developer	Full-time	comp_539457fc	2	loc_9597ddfd	pkg_5a12623d	t	2025-07-09	2025-08-07 17:02:16	\N
d1d96e72-e37f-4e64-a6e5-b3e1298c0296	Backend Developer	Contract	comp_33e9621d	2	loc_6fc8a029	pkg_93d06655	t	2025-07-09	2025-08-07 17:02:16	\N
7f0f2c50-ed39-424e-b441-3320dbd7ea31	Frontend Developer (Web)	Contract	comp_33e9621d	2	loc_6fc8a029	pkg_93d06655	t	2025-07-09	2025-08-07 17:02:16	\N
ea5fd7f0-6d68-435d-a4fd-159c7a5f9461	Frontend Developer (Mobile)	Contract	comp_33e9621d	18	loc_6fc8a029	pkg_93d06655	t	2025-07-09	2025-08-07 17:02:16	\N
897ebc7d-d63b-4232-a979-548056c29822	People Operations Officer	Full-time	comp_3c413fc6	11	loc_6fc8a029	pkg_8a019595	t	2025-07-08	2025-08-07 17:02:16	\N
c3f94238-b5e8-42dc-a161-168b4b8821a2	Part Time English Teacher (Offline)	Part-time	comp_a421fc5e	19	loc_9597ddfd	pkg_8a019595	t	2025-07-08	2025-08-07 17:02:16	\N
3492f431-71d6-4e7b-817c-ea2d388f8948	Software Engineer (Hybrid)	Full-time	comp_fd7c1918	1	loc_b3feaf63	pkg_841aab7e	t	2025-07-08	2025-08-07 17:02:16	\N
de66632a-b47c-452f-9ddd-91f10432c5d3	Finance Accounting and Tax Intern	Internship	comp_fe107d99	8	loc_6fc8a029	pkg_5198cc0b	t	2025-07-08	2025-08-07 17:02:16	\N
77a90924-f8da-491e-a657-4132437a4538	SENIOR SALES (HYBRID)	Full-time	comp_af562bdb	4	loc_6fc8a029	pkg_3d6a9c67	t	2025-07-08	2025-08-07 17:02:16	\N
d48a406a-5ec5-45df-82c9-688ee3f7afdf	Product Manager (Based in Medan)	Full-time	comp_d7da8446	3	loc_be3832cb	pkg_10d9bc52	t	2025-07-08	2025-08-07 17:02:16	\N
0e1f2a9e-644d-4511-9433-f26f5fced873	Graphic Designer & Social Media	Full-time	comp_e63e4e84	12	loc_6fc8a029	pkg_b889c007	t	2025-07-07	2025-08-07 17:02:16	\N
5d5dcc7a-73a6-4e44-a43e-e4fee1e638a7	Business Digital Performance & Monitoring Specialist	Contract	comp_64e3bb93	4	loc_6fc8a029	pkg_cc1168ba	t	2025-07-07	2025-08-07 17:02:16	\N
d286b62b-e329-4512-95e3-60cb86d33154	Accounting Admin	Full-time	comp_df9ed564	8	loc_6fc8a029	pkg_3d200299	t	2025-07-07	2025-08-07 17:02:16	\N
d1c1a7b4-26b3-45a7-b5af-21f08d7314f7	Social Media Specialist	Full-time	comp_df9ed564	5	loc_6fc8a029	pkg_b9cec660	t	2025-07-07	2025-08-07 17:02:16	\N
4e4a61eb-2c27-44a2-8047-bddaed7bb518	Social Media Intern	Internship	comp_df9ed564	5	loc_6fc8a029	pkg_67eb88f3	t	2025-07-07	2025-08-07 17:02:16	\N
a7484679-4375-4bd0-8abc-5c2e3427640f	Java (Quarkus) - Insurance Industry	Contract	comp_64e3bb93	1	loc_6fc8a029	pkg_cc1168ba	t	2025-07-04	2025-08-07 17:02:16	\N
6bf2b12d-b859-43e7-b4a8-2f9b29ae6a31	Fullstack Developer (.Net & React Js) - Insurance Industry	Contract	comp_64e3bb93	1	loc_6fc8a029	pkg_d7e485c3	t	2025-07-04	2025-08-07 17:02:16	\N
58e0db6a-4cb9-4497-97c8-a6163a77415d	Red Team (Offensive Security) (PT Solusi Keamanan Bersama)	Full-time	comp_9b8947da	9	loc_9597ddfd	pkg_8a019595	t	2025-07-04	2025-08-07 17:02:16	\N
e08ccc26-d04b-4d6c-94fe-c4189d4eae8e	Security Engineer (PT Solusi Keamanan Bersama)	Full-time	comp_9b8947da	9	loc_9597ddfd	pkg_8a019595	t	2025-07-04	2025-08-07 17:02:16	\N
19ac61fc-59e2-46a2-9a19-bf2f5a270185	Faculty Member Bahasa Indonesia - SATU University @ Bandung	Part-time	comp_4b30ef66	19	loc_b3feaf63	pkg_8a019595	t	2025-07-04	2025-08-07 17:02:16	\N
3b7ca7e6-c631-49e6-b161-b0e7f690c66b	Backend Developer	Contract	comp_a1774764	1	loc_b3feaf63	pkg_8a019595	t	2025-07-04	2025-08-07 17:02:16	\N
b37bdfbd-3861-4458-acaf-0aa04509115b	Product Manager	Contract	comp_a1774764	3	loc_b3feaf63	pkg_8a019595	t	2025-07-04	2025-08-07 17:02:16	\N
621bb49a-3dee-4bbb-8b30-cc1cca301234	Senior Go To Market (GTM) & Acquisition	Contract	comp_a1774764	4	loc_b3feaf63	pkg_8a019595	t	2025-07-04	2025-08-07 17:02:16	\N
62467dec-87f6-456e-b48a-e3a81fb81839	Architecture Delivery & Support Specialist	Full-time	comp_539457fc	3	loc_6fc8a029	pkg_5a12623d	t	2025-07-04	2025-08-07 17:02:16	\N
076bd5c4-6af4-4c23-b4ff-b4b65582968b	CRM Intern	Internship	comp_001cf410	15	loc_6fc8a029	pkg_8a019595	t	2025-07-03	2025-08-07 17:02:16	\N
8e79b625-a374-4bdc-b764-e01f77c18879	Campaign Management Intern	Internship	comp_001cf410	15	loc_6fc8a029	pkg_8a019595	t	2025-07-03	2025-08-07 17:02:16	\N
1b2d74e5-65dc-453d-a9d0-e9a16d94038b	Salesforce Marketing Cloud Engineer	Full-time	comp_001cf410	15	loc_6fc8a029	pkg_8a019595	t	2025-07-03	2025-08-07 17:02:16	\N
4b3bc646-6ddd-4e35-a5f9-4f4b2885a989	Senior Python Developer - Can Join Immediately	Contract	comp_64e3bb93	1	loc_6fc8a029	pkg_2d35f618	t	2025-07-03	2025-08-07 17:02:16	\N
ca33fabf-8a14-49e3-8ef7-08863f7d23d8	Strategic Planning Product Manager (Ruang Kami Group)	Full-time	comp_275c3945	1	loc_6fc8a029	pkg_7e9ce1c0	t	2025-07-03	2025-08-07 17:02:16	\N
cdae7cce-561d-47f4-93b1-dc84c2419c14	IT Helpdesk	Full-time	comp_acfe08af	1	loc_6fc8a029	pkg_5047dbae	t	2025-07-03	2025-08-07 17:02:16	\N
9228183d-aba8-45b1-8d58-92a5a687e6b1	Teacher Operation Intern	Internship	comp_a421fc5e	19	loc_3377aa9f	pkg_8a019595	t	2025-07-03	2025-08-07 17:02:16	\N
0c69d407-ce01-4afd-ac20-a3482537036e	Database Administrator (for Insurance Industry)	Full-time	comp_64e3bb93	6	loc_6fc8a029	pkg_64d51dde	t	2025-07-02	2025-08-07 17:02:16	\N
4071bdc1-cb82-4ff0-aa45-915f5d46ca08	Copywriter Freelance	Freelance	comp_cec98ce6	7	loc_b3feaf63	pkg_8a019595	t	2025-07-02	2025-08-07 17:02:16	\N
3dc4793f-ea8a-474f-857a-5be810d46c1f	Technical Support (.Net) - Insurance Industry	Contract	comp_64e3bb93	1	loc_6fc8a029	pkg_cf239f18	t	2025-07-02	2025-08-07 17:02:16	\N
2811a1b4-7d50-4d89-8372-8e67a4668479	Front End Angular - Insurance Industry	Contract	comp_64e3bb93	1	loc_6fc8a029	pkg_ab921f28	t	2025-07-02	2025-08-07 17:02:16	\N
4621a4bd-fb41-4949-aff0-5105265d4ac3	Finance Support	Full-time	comp_15920e21	8	loc_6fc8a029	pkg_8a019595	t	2025-07-02	2025-08-07 17:02:16	\N
df429d01-095f-4217-91e7-4fbd361cf367	Angular Frontend Developer (Insurance Industry)	Contract	comp_64e3bb93	2	loc_6fc8a029	pkg_de1249bf	t	2025-07-02	2025-08-07 17:02:16	\N
bbd59327-20de-4fcf-a15a-436695e1f4b6	YouTube Specialist	Full-time	comp_f29eb0d7	21	loc_b3feaf63	pkg_547f8784	t	2025-07-02	2025-08-07 17:02:16	\N
c854d18f-d3a2-4568-83f5-0176ffbbe533	L1 SOC	Full-time	comp_15920e21	9	loc_6fc8a029	pkg_8a019595	t	2025-07-02	2025-08-07 17:02:16	\N
81aa6f98-21c4-49c9-8416-d8a9c03827a8	Back End Developer	Full-time	comp_cec98ce6	2	loc_b3feaf63	pkg_8a019595	t	2025-07-02	2025-08-07 17:02:16	\N
9c582362-0a9c-40d7-b76e-348bae619d63	Front End Developer	Full-time	comp_cec98ce6	1	loc_b3feaf63	pkg_8a019595	t	2025-07-02	2025-08-07 17:02:16	\N
5e9d96d7-ef65-41cc-998b-49e0a1609bab	Digital Marketing Specialist	Full-time	comp_cec98ce6	5	loc_6fc8a029	pkg_8a019595	t	2025-07-02	2025-08-07 17:02:16	\N
cba9944c-e0d0-4e62-a119-3e74e5bc8e5c	eCommerce Specialist	Full-time	comp_cec98ce6	3	loc_b3feaf63	pkg_8a019595	t	2025-07-02	2025-08-07 17:02:16	\N
81fb0f7f-d97a-47f7-af6e-199018bbc696	Data Engineer - Banking Syariah Industry	Contract	comp_64e3bb93	6	loc_6fc8a029	pkg_023379cc	t	2025-07-01	2025-08-07 17:02:16	\N
9f56a7b4-cda3-42d2-9db2-5cdd53d89cd1	Java Developer (Quarkus) - Insurance Industry	Contract	comp_64e3bb93	1	loc_6fc8a029	pkg_43a18d93	t	2025-07-01	2025-08-07 17:02:16	\N
c8f269f2-680c-42c6-9649-fed40c1b04f0	IT Security - L2 / Blue Team (for FinTech Industry)	Full-time	comp_64e3bb93	2	loc_6fc8a029	pkg_93d06655	t	2025-07-01	2025-08-07 17:02:16	\N
cde18188-2105-47a2-bfbb-5355b18a8072	Digital Products Operations (Multifinance Industry)	Contract	comp_64e3bb93	3	loc_6fc8a029	pkg_822c6f38	t	2025-07-01	2025-08-07 17:02:16	\N
dd5937ad-dd22-44fe-b4ea-a96db9acb59d	Digital Products Operations - For Multifinance Industry	Full-time	comp_64e3bb93	5	loc_6fc8a029	pkg_6df3144f	t	2025-07-01	2025-08-07 17:02:16	\N
6aaf16d4-e8bb-46eb-83d6-2957f31e1cec	Faculty Member (FM) Manajemen - SATU University @ Pontianak	Full-time	comp_4b30ef66	19	loc_0d81d8dd	pkg_8a019595	t	2025-07-01	2025-08-07 17:02:16	\N
e516fe57-c45d-4fbd-a57e-92d38863b6f2	Software Quality Assurance Automation	Full-time	comp_e95a250b	1	loc_6fc8a029	pkg_8a019595	t	2025-07-01	2025-08-07 17:02:16	\N
7a2f3bef-65b1-46d1-809d-445231ba71a8	.NET Developer (Junior - Middle Leve)	Contract	comp_786c073f	1	loc_cb52e018	pkg_8a019595	t	2025-07-01	2025-08-07 17:02:16	\N
d899e197-69c9-49e4-bda9-4ad7212e74ea	Senior Machine Learning Engineer	Full-time	comp_539457fc	2	loc_9597ddfd	pkg_5a12623d	t	2025-07-01	2025-08-07 17:02:16	\N
a32eadd8-815c-4628-9be5-ef30c284dfbb	System Analyst - Banking Industry (Can Join Immediately)	Contract	comp_64e3bb93	1	loc_8d0798bb	pkg_1636ce6f	t	2025-06-30	2025-08-07 17:02:16	\N
04c9c140-6b25-45a7-99b9-2fd67c42a87e	Quality Assurance (Temenos 24)	Contract	comp_64e3bb93	14	loc_6fc8a029	pkg_cc1168ba	t	2025-06-30	2025-08-07 17:02:16	\N
7aee9832-343c-4f55-848a-70cfddbe6321	Social Media Specialist (Female Daily Studio by Female Daily Network)	Full-time	comp_3815c364	7	loc_6fc8a029	pkg_8a019595	t	2025-06-30	2025-08-07 17:02:16	\N
ab2681f7-82e4-4e60-9dbf-bd6b247a13f0	Digital Media Planner [Mediatics]	Full-time	comp_3c413fc6	5	loc_6fc8a029	pkg_8a019595	t	2025-06-30	2025-08-07 17:02:16	\N
ad8b84a8-0dfe-461b-981c-a7caadef9038	System Engineer	Full-time	comp_fb7b7841	10	loc_6fc8a029	pkg_f7cf7a36	t	2025-06-30	2025-08-07 17:02:16	\N
8b9fdc8a-736d-4fa7-83e1-faa9db41e5aa	SIP-NEXT Fast Track Program	Full-time	comp_15920e21	15	loc_6fc8a029	pkg_7ee28436	t	2025-06-30	2025-08-07 17:02:16	\N
888c959f-8380-44df-b1fe-d62b0dc60386	Merchant Acquisition Specialist	Full-time	comp_ce1667a1	4	loc_6fc8a029	pkg_023379cc	t	2025-06-30	2025-08-07 17:02:16	\N
84a0ae5f-c918-49da-b79d-4298d0e390eb	Fresh Graduate Management Training Program	Full-time	comp_f2d8ee5e	17	loc_6fc8a029	pkg_6cc1dc31	t	2025-06-30	2025-08-07 17:02:16	\N
84711c9b-766b-4eca-9391-f66c83c36b0e	Counselor	Full-time	comp_4b30ef66	19	loc_6fc8a029	pkg_8a019595	t	2025-06-28	2025-08-07 17:02:16	\N
8550b2a4-5859-4096-9f6c-6aebd3d0da6f	Flutter Mobile Engineer	Full-time	comp_b6131bf8	2	loc_6fc8a029	pkg_8a019595	t	2025-06-26	2025-08-07 17:02:16	\N
a2b3215f-b958-4871-9a19-3608be2b0f01	Event Freelancer	Freelance	comp_f2d8ee5e	20	loc_6fc8a029	pkg_5198cc0b	t	2025-06-26	2025-08-07 17:02:16	\N
1b6f0f67-79b5-44f4-a0ea-fda752d8d999	Java Developer	Full-time	comp_64e3bb93	1	loc_6fc8a029	pkg_aeaa84c8	t	2025-06-26	2025-08-07 17:02:16	\N
cae3d06d-7c4c-45a1-9fe8-f3aab4fe0229	General Manager Enterprise Solution Corporate IT&IS	Full-time	comp_225c3925	22	loc_6fc8a029	pkg_8a019595	t	2025-06-26	2025-08-07 17:02:16	\N
00aafd86-6d8e-4cad-9e92-59f7d312f07c	Business Development (Event)	Full-time	comp_97d7f220	4	loc_6fc8a029	pkg_76f39d31	t	2025-06-26	2025-08-07 17:02:16	\N
42bd12df-3d07-4318-a214-acd8bc5b6fc4	Network Engineer Corporate IT&IS	Contract	comp_225c3925	10	loc_6fc8a029	pkg_8a019595	t	2025-06-26	2025-08-07 17:02:16	\N
bc636b93-b68d-493a-8f53-7228a00164ed	Senior Backend Java Engineer	Full-time	comp_539457fc	1	loc_6fc8a029	pkg_5a12623d	t	2025-06-26	2025-08-07 17:02:16	\N
2405045d-5591-45c1-b3aa-f112361d938d	SAP Supporter	Full-time	comp_64e3bb93	9	loc_ed9b4257	pkg_c6dcb635	t	2025-06-26	2025-08-07 17:02:16	\N
a5ec52ca-7266-4a7a-9583-8e0b6727739e	Infrastructure Administrator (Fluent English)	Full-time	comp_64e3bb93	1	loc_ed9b4257	pkg_c6dcb635	t	2025-06-26	2025-08-07 17:02:16	\N
06f5e129-a6a1-442e-9d56-d6e5088affcc	Dynamics 365 - (Fluent English)	Full-time	comp_64e3bb93	1	loc_dd964486	pkg_c6dcb635	t	2025-06-26	2025-08-07 17:02:16	\N
bd5acc2b-26ee-47b7-8c74-898a4d896365	Procuement Admin	Full-time	comp_3815c364	17	loc_6fc8a029	pkg_8a019595	t	2025-06-26	2025-08-07 17:02:16	\N
0389bc24-2066-440f-bc5e-6441f27062f8	Reporter News (Bandung)	Full-time	comp_8179f80d	7	loc_b3feaf63	pkg_8a019595	t	2025-06-25	2025-08-07 17:02:16	\N
c3541b53-654a-4e44-b35b-806e8f001800	Senior Backend Developer (SpringBoot)	Contract	comp_acfe08af	1	loc_6fc8a029	pkg_0ac5bc72	t	2025-06-25	2025-08-07 17:02:16	\N
ef15a79d-53a3-477a-b414-b4bc03464e32	Temenos Core Banking Developer	Contract	comp_acfe08af	1	loc_6fc8a029	pkg_375391a1	t	2025-06-25	2025-08-07 17:02:16	\N
5dd58a15-217c-4d2d-bf68-140f10bf3865	DevOps - Multifinance Industry	Contract	comp_64e3bb93	10	loc_6fc8a029	pkg_cc1168ba	t	2025-06-24	2025-08-07 17:02:16	\N
dcbe54ed-83e4-48d2-89dd-564f0563ba4d	Product Designer	Full-time	comp_1b1164cb	24	loc_6fc8a029	pkg_8a019595	t	2025-06-24	2025-08-07 17:02:16	\N
b9801e0b-257a-47c1-8f2b-a91f5e89b0df	Finance and Accounting Staff	Full-time	comp_b3934155	8	loc_6fc8a029	pkg_8a019595	t	2025-06-24	2025-08-07 17:02:16	\N
95a4e420-7a80-419f-b88f-ec51cc2f2ec1	Telemarketing	Full-time	comp_786c073f	4	loc_6fc8a029	pkg_8a019595	t	2025-06-24	2025-08-07 17:02:16	\N
33efabdd-0e87-4629-8bd1-b84bf4bc0822	Golang Developer - Multifinance Industry	Contract	comp_64e3bb93	1	loc_6fc8a029	pkg_93d06655	t	2025-06-24	2025-08-07 17:02:16	\N
fa0a4b12-2b59-44ae-9806-e3cfd900eb13	Business Analyst - Multifinance Industry	Contract	comp_64e3bb93	6	loc_6fc8a029	pkg_982fea78	t	2025-06-24	2025-08-07 17:02:16	\N
1682c297-5500-45ea-b243-96515d7d6bef	Community Intern	Internship	comp_275c3945	5	loc_6fc8a029	pkg_8a019595	t	2025-06-24	2025-08-07 17:02:16	\N
0bf22318-d325-40af-a754-e0f106fdc6f1	Warehouse Administrator	Full-time	comp_3815c364	26	loc_6fc8a029	pkg_8a019595	t	2025-06-24	2025-08-07 17:02:16	\N
cf10a6c9-3ec0-46d2-a146-a6e64b8242c0	Creative Strategist	Full-time	comp_cec98ce6	15	loc_b3feaf63	pkg_8a019595	t	2025-06-24	2025-08-07 17:02:16	\N
8acb3c93-f543-45db-9ff0-82242724bbc1	System Engineer Fullstack - For Banking Industry	Full-time	comp_64e3bb93	1	loc_6fc8a029	pkg_838c6091	t	2025-06-24	2025-08-07 17:02:16	\N
5c85f691-114e-4efe-83fa-37d788f1f7df	Database Engineer - For Banking Industry	Full-time	comp_64e3bb93	1	loc_6fc8a029	pkg_838c6091	t	2025-06-24	2025-08-07 17:02:16	\N
e4332a93-06b9-4732-a223-8b22b661dcd0	Data Center Engineer	Full-time	comp_fb7b7841	13	loc_6fc8a029	pkg_64d51dde	t	2025-06-24	2025-08-07 17:02:16	\N
1d381cb6-d141-4f87-895a-7300f3143470	QA Engineer (Freelance)	Freelance	comp_1b1164cb	14	loc_6fc8a029	pkg_8a019595	t	2025-06-23	2025-08-07 17:02:16	\N
46de4115-b7ee-4e37-9616-fdaf0b8a6399	Hub Associate Jakarta	Full-time	comp_fe107d99	23	loc_6fc8a029	pkg_9251fa1d	t	2025-06-23	2025-08-07 17:02:16	\N
7c9a1131-4daf-4f9e-b370-dd601303065c	Senior Infosec & Compliance	Full-time	comp_1b1164cb	9	loc_6fc8a029	pkg_8a019595	t	2025-06-23	2025-08-07 17:02:16	\N
1bfc0932-c914-4219-aa06-fdf94b11b58f	DB Server Admin (Junior)	Contract	comp_64e3bb93	13	loc_6fc8a029	pkg_da30dd4c	t	2025-06-23	2025-08-07 17:02:16	\N
736d7097-6223-44d6-a747-f1c04b87a320	IT Infrastructure (Middle)	Contract	comp_64e3bb93	13	loc_6fc8a029	pkg_bd1e28a8	t	2025-06-23	2025-08-07 17:02:16	\N
f3f61bad-7693-49b7-81e5-20b3cedd4527	IT Quality Assurance	Contract	comp_acfe08af	14	loc_6fc8a029	pkg_b9cec660	t	2025-06-23	2025-08-07 17:02:16	\N
3ac85af8-07e8-4462-a01f-dffdb99655b0	Registration & Scheduling Staff - BINUS Senayan Campus	Full-time	comp_4b30ef66	16	loc_6fc8a029	pkg_9749583d	t	2025-06-23	2025-08-07 17:02:16	\N
849b02b0-ad72-495f-b1de-18d09e31b87d	Graduate Publication Officer - BINUS Business School	Full-time	comp_4b30ef66	16	loc_6fc8a029	pkg_9749583d	t	2025-06-23	2025-08-07 17:02:16	\N
36f55ebd-b186-4be8-af93-afdf4df2b5fa	System Analyst - Retail Industry (Full WFO)	Full-time	comp_64e3bb93	9	loc_8d0798bb	pkg_fcfc528b	t	2025-06-23	2025-08-07 17:02:16	\N
4452e939-d3b2-4fe0-bc64-d72cbeb973f1	Fullstack Developer (Senior) - Insurance Industry	Full-time	comp_64e3bb93	1	loc_6fc8a029	pkg_23165dfc	t	2025-06-23	2025-08-07 17:02:16	\N
6d8b1090-5a6a-4d5a-95da-59803113113d	FrontEnd Developer - Banking Industry Exp	Contract	comp_64e3bb93	1	loc_9597ddfd	pkg_cf239f18	t	2025-06-23	2025-08-07 17:02:16	\N
a9fd39e0-0e1f-4b1d-a9a5-220cf45e564a	System Analyst - Banking Industry Exp	Contract	comp_64e3bb93	1	loc_9597ddfd	pkg_fcfc528b	t	2025-06-23	2025-08-07 17:02:16	\N
4d68a8f8-1a8c-4bcf-8212-8cf9b9082dc5	IT Project Support - For Banking Industry	Full-time	comp_64e3bb93	9	loc_6fc8a029	pkg_8cd73035	t	2025-06-23	2025-08-07 17:02:16	\N
c2aa9d01-1c7d-44aa-891b-dbdf926a754b	CRM Campaign Operations Intern	Internship	comp_275c3945	5	loc_6fc8a029	pkg_8a019595	t	2025-06-23	2025-08-07 17:02:16	\N
a896c82b-20ca-46c9-8e60-cda708fcba11	Sales & Marketing Manager	Full-time	comp_a421fc5e	4	loc_9597ddfd	pkg_8a019595	t	2025-06-22	2025-08-07 17:02:16	\N
3f3d1bac-8e62-49c5-84c1-03d7c0f995a4	Wireless Engineer - Mining Industry	Contract	comp_64e3bb93	9	loc_6fc8a029	pkg_4140485c	t	2025-06-22	2025-08-07 17:02:16	\N
feb290a5-cbaa-4efb-bea9-b4d7419d7860	Marketing Manager	Full-time	comp_f2d8ee5e	5	loc_6fc8a029	pkg_8a019595	t	2025-06-20	2025-08-07 17:02:16	\N
8adce5e8-a24b-4a48-9ca9-9627ebeeef5c	Senior Lawyer	Full-time	comp_f2d8ee5e	8	loc_6fc8a029	pkg_022c485c	t	2025-06-20	2025-08-07 17:02:16	\N
dda49916-485a-4160-b8ed-d5de63ad935f	IT Application Support (Corebanking) - Temenos 24	Contract	comp_64e3bb93	1	loc_6fc8a029	pkg_982fea78	t	2025-06-20	2025-08-07 17:02:16	\N
a02cb5e4-0512-4b07-b998-abb2a41d2178	Client Partner (Sales)	Full-time	comp_8179f80d	7	loc_6fc8a029	pkg_8a019595	t	2025-06-20	2025-08-07 17:02:16	\N
9a99ad80-464e-4dc7-a818-5b86ca3231f3	Data Analyst	Full-time	comp_cb2b14c7	6	loc_6fc8a029	pkg_8a019595	t	2025-06-20	2025-08-07 17:02:16	\N
c6f18db8-76b7-4a34-8f19-5f4562c2be4c	DevOps (Banking Industry T24)	Contract	comp_64e3bb93	10	loc_6fc8a029	pkg_4ffc3d42	t	2025-06-19	2025-08-07 17:02:16	\N
d5641eb5-ef68-437d-9c31-606f9e36da42	Learning & Engagement Intern	Internship	comp_a421fc5e	11	loc_9597ddfd	pkg_8a019595	t	2025-06-19	2025-08-07 17:02:16	\N
a06883b3-963c-4f29-b018-090e3f4c9b9c	Freelance Video Editor	Freelance	comp_8179f80d	7	loc_6fc8a029	pkg_8a019595	t	2025-06-19	2025-08-07 17:02:16	\N
d58e4508-0d6f-43b4-bb01-93b56f408d1f	Gen AI Fullstack Engineer	Contract	comp_acfe08af	1	loc_6fc8a029	pkg_c6dcb635	t	2025-06-19	2025-08-07 17:02:16	\N
2a16b768-a3f7-42b6-b357-ed4580f9912e	Account Executive (Media Industry)	Full-time	comp_275c3945	4	loc_6fc8a029	pkg_8a019595	t	2025-06-19	2025-08-07 17:02:16	\N
2bd3ea55-5f30-403b-a8cd-55ee1e7dc81c	Junior Fullstack Developer (Java Angular & Springboot) - Full Onsite	Contract	comp_64e3bb93	1	loc_6fc8a029	pkg_0c54dd28	t	2025-06-18	2025-08-07 17:02:16	\N
87883d92-aa9b-45a2-9b0e-b1242e4ce97f	Junior Golang Developer - Banking Industry	Contract	comp_64e3bb93	1	loc_6fc8a029	pkg_f867c52c	t	2025-06-18	2025-08-07 17:02:16	\N
d5e130f1-d3ca-416c-b0eb-506e27de482a	Junior Front End Developer - Banking Industry	Contract	comp_64e3bb93	1	loc_6fc8a029	pkg_f867c52c	t	2025-06-18	2025-08-07 17:02:16	\N
8f045c7b-8d45-43f0-b207-867d7897998d	Junior IT Project Support/PMO - Banking Industry	Contract	comp_64e3bb93	3	loc_6fc8a029	pkg_cf239f18	t	2025-06-18	2025-08-07 17:02:16	\N
047621c2-6769-46b0-8328-04fdfe36371c	Senior Manager (FAT)	Full-time	comp_ce1667a1	8	loc_6fc8a029	pkg_8a019595	t	2025-06-18	2025-08-07 17:02:16	\N
f7ff5c90-7ce3-45f9-ad72-44a7d25c686c	Laboratory Staff (SMART Factory) BINUS @ Bekasi Campus	Full-time	comp_4b30ef66	17	loc_b1dddaa6	pkg_8a019595	t	2025-06-18	2025-08-07 17:02:16	\N
d5fdf58b-7125-448e-b88e-b93760a89daf	Business Analyst (Multifinance Industry)	Contract	comp_64e3bb93	4	loc_6fc8a029	pkg_fcfc528b	t	2025-06-18	2025-08-07 17:02:16	\N
ba71941e-272b-4eb5-9abe-e8f533ac5e2c	Senior Product Analyst - Regional Payroll	Full-time	comp_e95a250b	3	loc_6fc8a029	pkg_8a019595	t	2025-06-18	2025-08-07 17:02:16	\N
f63ead3e-1903-483a-a5b8-ccdb74f761f2	Product Specialist - Regional Payroll	Full-time	comp_e95a250b	3	loc_6fc8a029	pkg_8a019595	t	2025-06-18	2025-08-07 17:02:16	\N
c603b291-1c19-4381-ab59-ef15fe793f09	Fashion Designer	Full-time	comp_7f9ec5b6	3	loc_6fc8a029	pkg_857782df	t	2025-06-18	2025-08-07 17:02:16	\N
43758955-ca8b-4a02-b576-f58a4bf748d1	SAP BASIS Consultant - (For Banking Industry)	Full-time	comp_64e3bb93	9	loc_6fc8a029	pkg_99c064b1	t	2025-06-18	2025-08-07 17:02:16	\N
2e2274bb-74d8-4154-8d01-22890714e679	Back End Developer - 3 Month Project	Contract	comp_64e3bb93	1	loc_6fc8a029	pkg_822c6f38	t	2025-06-17	2025-08-07 17:02:16	\N
6e089244-d2c2-4613-98f6-abcb90486cfd	Front End Developer (React Js & Next Js) - 3 Month Project	Contract	comp_64e3bb93	1	loc_6fc8a029	pkg_822c6f38	t	2025-06-17	2025-08-07 17:02:16	\N
6862ee73-bf5a-470c-a3ae-5475f489ef9d	Network Support - Mining Industry	Contract	comp_64e3bb93	9	loc_6fc8a029	pkg_4140485c	t	2025-06-17	2025-08-07 17:02:16	\N
74397d7a-8031-48e5-90d7-c9d171dcf435	Business Development	Full-time	comp_539457fc	5	loc_6fc8a029	pkg_5a12623d	t	2025-06-17	2025-08-07 17:02:16	\N
eb7d3a2e-4c5d-4dbe-9f7a-c82531ee8734	IT Security Project	Full-time	comp_cb2b14c7	1	loc_6fc8a029	pkg_8a019595	t	2025-06-17	2025-08-07 17:02:16	\N
a2db1888-bad3-436e-9af8-ad00cbe2b6fe	Auto Finance Channel Acquisition	Full-time	comp_cb2b14c7	4	loc_6fc8a029	pkg_8a019595	t	2025-06-17	2025-08-07 17:02:16	\N
3bd5ec27-cc2b-4399-83da-441cbb263742	DevOps	Contract	comp_33e9621d	10	loc_6fc8a029	pkg_c6dcb635	t	2025-06-17	2025-08-07 17:02:16	\N
0ab46ae4-7788-4cea-949e-b221e5f866f5	Part-time Marketing	Part-time	comp_4b30ef66	5	loc_6dd4ee2b	pkg_9749583d	t	2025-06-17	2025-08-07 17:02:16	\N
5b833e5b-d070-4a29-bb7e-01e1bd366933	Software Engineer	Full-time	comp_e95a250b	1	loc_6fc8a029	pkg_8a019595	t	2025-06-17	2025-08-07 17:02:16	\N
0690051c-7810-43a2-8d80-5fdfa071333a	DevSecOps	Full-time	comp_66101193	10	loc_9597ddfd	pkg_a4fbd25b	t	2025-06-17	2025-08-07 17:02:16	\N
db3b518a-e3a5-4f5c-8d31-ab2cc751b67c	Graphic Designer Intern	Internship	comp_a421fc5e	12	loc_9597ddfd	pkg_8a019595	t	2025-06-16	2025-08-07 17:02:16	\N
824e7127-76fe-4d16-899d-3011a62f42ed	Social Media Intern	Internship	comp_a421fc5e	5	loc_9597ddfd	pkg_8a019595	t	2025-06-16	2025-08-07 17:02:16	\N
2e39ce6b-066a-43e4-add3-57758ebb4c6a	Data Analyst - Ritel Industry	Full-time	comp_64e3bb93	6	loc_8d0798bb	pkg_93d06655	t	2025-06-16	2025-08-07 17:02:16	\N
4a1e06f0-1bcf-4560-a14e-bdf25245a30f	IT Business Analyst - Insurance	Contract	comp_64e3bb93	3	loc_6fc8a029	pkg_8e7dcc95	t	2025-06-16	2025-08-07 17:02:16	\N
e0cc8f76-8126-4b0f-96df-e733d727af2e	Senior Account Strategist (Influence ID)	Full-time	comp_3c413fc6	3	loc_6fc8a029	pkg_8a019595	t	2025-06-16	2025-08-07 17:02:16	\N
7482397d-efc2-42c2-9495-d7ce318dabce	Social Media Specialist	Full-time	comp_7f9ec5b6	21	loc_6fc8a029	pkg_8f9cde40	t	2025-06-16	2025-08-07 17:02:16	\N
ad9457fc-d885-44ca-a703-2d2f9ec9f0e8	Graphic Designer & Showroom Sales	Full-time	comp_f214c778	4	loc_6fc8a029	pkg_2bb396c9	t	2025-06-15	2025-08-07 17:02:16	\N
f5ad7a2d-f9b2-4175-ad26-4a17e826d923	Go To Market - Multifinance Industry	Contract	comp_64e3bb93	3	loc_6fc8a029	pkg_cc1168ba	t	2025-06-13	2025-08-07 17:02:16	\N
6aca1140-4616-4150-be6f-b64af84c2b4c	Product Owner - (Exp: Banking Syariah)	Contract	comp_64e3bb93	3	loc_8d0798bb	pkg_c6dcb635	t	2025-06-13	2025-08-07 17:02:16	\N
d1b49c79-de03-46eb-87a7-ef9a282f25cf	Community Officer Intern [Mediatics]	Internship	comp_3c413fc6	5	loc_6fc8a029	pkg_8a019595	t	2025-06-13	2025-08-07 17:02:16	\N
26ffb209-35c7-4749-a5a7-30757afaa1cc	UX/UI Designer	Full-time	comp_5fe50081	24	loc_6fc8a029	pkg_8a019595	t	2025-06-13	2025-08-07 17:02:16	\N
291a356f-67b7-4747-9fe1-de3a3940a54c	Social Media Specialist	Full-time	comp_a421fc5e	5	loc_9597ddfd	pkg_8a019595	t	2025-06-13	2025-08-07 17:02:16	\N
978d7c05-fa90-4850-a095-a0dcca4745d7	Senior Database Administrator - Banking Industry	Contract	comp_64e3bb93	6	loc_6fc8a029	pkg_2b1bfc3c	t	2025-06-13	2025-08-07 17:02:16	\N
d0f50562-97c2-46ab-8da8-a85eebd79ef7	System Analyst (Banking Industry)	Contract	comp_64e3bb93	6	loc_6fc8a029	pkg_21a93f57	t	2025-06-13	2025-08-07 17:02:16	\N
171e0b56-24e4-4b90-803e-46edd1d08bc0	Junior Oracle APEX Developer	Contract	comp_acfe08af	1	loc_6fc8a029	pkg_74ac8e92	t	2025-06-13	2025-08-07 17:02:16	\N
c24a7d0f-33af-47b8-ad9b-339740d31570	Visual Designer Specialist (Beauty Brand)	Full-time	comp_7f9ec5b6	12	loc_6fc8a029	pkg_838c6091	t	2025-06-12	2025-08-07 17:02:16	\N
144ffd12-e589-4a10-b643-70ee57a1d6d5	Web Developer	Full-time	comp_cec98ce6	2	loc_b3feaf63	pkg_8a019595	t	2025-06-12	2025-08-07 17:02:16	\N
8dfc74ea-48be-4e78-ae17-12dc520ef413	IPO Team Associate/Senior Associate	Full-time	comp_f2d8ee5e	8	loc_6fc8a029	pkg_8a019595	t	2025-06-12	2025-08-07 17:02:16	\N
03045602-852b-4b54-8cce-499ebc6d0e9f	Chinese Literature Lecturer	Full-time	comp_4b30ef66	19	loc_6fc8a029	pkg_8a019595	t	2025-06-11	2025-08-07 17:02:16	\N
5517e83e-9545-41c7-8201-98b2ed208263	Digital Strategic Specialist - Multifinance Industry (Full Onsite)	Contract	comp_64e3bb93	3	loc_6fc8a029	pkg_60381dc7	t	2025-06-11	2025-08-07 17:02:16	\N
c7c8cf76-721f-41fe-b5dd-d5c021dd5459	Backend PHP	Full-time	comp_b6131bf8	2	loc_6fc8a029	pkg_8a019595	t	2025-06-11	2025-08-07 17:02:16	\N
6f6fad49-d568-4007-9b43-4f192743bb76	Frontend Developer	Contract	comp_33e9621d	2	loc_6fc8a029	pkg_93d06655	t	2025-06-11	2025-08-07 17:02:16	\N
c0d6a9cc-6fd1-4b4c-88a6-3cebec188802	Senior UI/UX	Full-time	comp_66101193	24	loc_9597ddfd	pkg_c026d17f	t	2025-06-10	2025-08-07 17:02:16	\N
e5ad5892-375c-4286-a15a-deb85ab88975	Digital Analyst Lead	Full-time	comp_5fe50081	6	loc_9597ddfd	pkg_8a019595	t	2025-06-10	2025-08-07 17:02:16	\N
d1da6aba-b2da-46b5-9574-29293c750277	Technical Program Manager	Full-time	comp_1b1164cb	3	loc_6fc8a029	pkg_8a019595	t	2025-06-10	2025-08-07 17:02:16	\N
720ebb14-e368-49b6-9611-7e4005ce33fc	SME Partnership	Full-time	comp_cb2b14c7	4	loc_6fc8a029	pkg_8a019595	t	2025-06-10	2025-08-07 17:02:16	\N
1723dccf-1b41-414b-b6fe-628305091485	Live Streamer TikTok (Beauty, Maternity, Hair Care Product)	Full-time	comp_7f9ec5b6	5	loc_1fc48ba3	pkg_5047dbae	t	2025-06-10	2025-08-07 17:02:16	\N
b4b1f27b-97f6-4ee2-be61-1f70163a9f25	Payroll Consultant	Full-time	comp_e95a250b	8	loc_6fc8a029	pkg_8a019595	t	2025-06-10	2025-08-07 17:02:16	\N
8627d2ce-0d4c-4e54-b527-4ba880868060	Full Stack Mobile Developer (React Native & C#)	Full-time	comp_e95a250b	2	loc_6fc8a029	pkg_8a019595	t	2025-06-10	2025-08-07 17:02:16	\N
33caaeb1-337c-49e7-98b6-9aaffe899c4f	Account Executive	Contract	comp_fb7b7841	4	loc_6fc8a029	pkg_8a019595	t	2025-06-10	2025-08-07 17:02:16	\N
d83f9202-e943-49ef-be6c-b68a5dc51d92	Customer Support Center (Help Desk)	Contract	comp_15920e21	23	loc_6fc8a029	pkg_8a019595	t	2025-06-09	2025-08-07 17:02:16	\N
536d3c08-5a0d-4423-a153-d2ebe16e3e73	Creative Intern	Internship	comp_6f1897d1	12	loc_6fc8a029	pkg_d3edcb4b	t	2025-07-31	2025-08-07 17:02:16	\N
31e37eb7-0008-4511-993d-3820d5282d09	Graphic Designer	Full-time	comp_6f1897d1	12	loc_6fc8a029	pkg_39740ba4	t	2025-07-24	2025-08-07 17:02:16	\N
883ccc27-16d2-4d55-a050-c57b50feac9f	Japanese - English Interpreter	Contract	comp_b8d9b6b5	23	loc_11f7c9b7	pkg_a6bbc261	t	2025-07-24	2025-08-07 17:02:16	\N
37036bf8-5ff9-4ab3-8974-e4517b70b809	Medical Sales Representative	Full-time	comp_6f1897d1	26	loc_6fc8a029	pkg_5da31994	t	2025-07-22	2025-08-07 17:02:16	\N
b6302f2f-2956-4a20-b4da-2aab23a1ed5b	Fullstack Developer (Banking / Insurance Industry)	Full-time	comp_64e3bb93	2	loc_6fc8a029	pkg_d7e485c3	f	2025-06-09	2025-08-07 17:02:16	2025-08-08 15:15:15.629981
f5102d95-c563-4f91-8fc6-c558304fc02b	Country Manager Indonesia	Full-time	comp_b8d9b6b5	22	loc_6fc8a029	pkg_4f7fa7a9	t	2025-07-22	2025-08-07 17:02:16	\N
663f4bf7-6190-4a0e-900b-bac34a05aaed	Host Live & Operator	Full-time	comp_6f1897d1	23	loc_6fc8a029	pkg_c2faaa49	t	2025-07-21	2025-08-07 17:02:16	\N
bdf88450-752f-43f2-b04e-9437230d9daa	Trade Marketing Specialist	Full-time	comp_6f1897d1	4	loc_6fc8a029	pkg_15bfbc3e	t	2025-07-09	2025-08-07 17:02:16	\N
3c5d1fdd-945e-4e89-a7b1-7bfaf87e63ae	Business Operations Manager	Full-time	comp_6f1897d1	15	loc_6fc8a029	pkg_8a019595	t	2025-07-09	2025-08-07 17:02:16	\N
2eb29b0d-fa9b-4fd0-9034-e4c3c9b76ca9	Supply Chain Manager	Full-time	comp_6f1897d1	17	loc_6fc8a029	pkg_8a019595	t	2025-07-03	2025-08-07 17:02:16	\N
f2e3236f-3048-4eb8-9780-72e3c2ebea11	Business Intelligence Operations	Full-time	comp_6f1897d1	6	loc_6fc8a029	pkg_cc1168ba	t	2025-07-03	2025-08-07 17:02:16	\N
af92ac9a-070b-48f4-8e02-8c2dbebe76d5	Farm Technical Operation Manager	Full-time	comp_0fad9501	17	loc_3377aa9f	pkg_c6dcb635	t	2025-07-02	2025-08-07 17:02:16	\N
7c37710d-2fa2-4137-a4cf-e7702e27b9f2	Field Assistant (Lampung)	Contract	comp_0fad9501	6	loc_5ac55fb0	pkg_8bc5b8e0	t	2025-07-02	2025-08-07 17:02:16	\N
fbc64aa4-f430-4a85-a990-07f79abf1443	Farm Commercial Executive (Jawa & Bali)	Full-time	comp_0fad9501	4	loc_56d34582	pkg_5047dbae	t	2025-07-02	2025-08-07 17:02:16	\N
4a752ab2-3368-4e1f-b476-fdc93bb4e344	Tax Officer	Contract	comp_4f81100f	8	loc_6fc8a029	pkg_8a019595	t	2025-06-25	2025-08-07 17:02:16	\N
376dea9b-fc46-4aff-bca2-77e0e9c97ee0	Social Media Specialist	Full-time	comp_27286e10	7	loc_9597ddfd	pkg_9e7cd558	t	2025-06-24	2025-08-07 17:02:16	\N
15f3c3cd-ac4f-417c-b4e9-faf835dfe2af	SEO Writer	Full-time	comp_27286e10	7	loc_9597ddfd	pkg_2dd718d2	t	2025-06-24	2025-08-07 17:02:16	\N
08649eae-fe97-4654-898a-374d2b009325	QA/QC Intern	Internship	comp_0fad9501	17	loc_3377aa9f	pkg_a4bc76e9	t	2025-06-23	2025-08-07 17:02:16	\N
9333d88c-021c-42cd-8ddb-455ed61f3281	People & Culture Manager	Full-time	comp_897e329e	22	loc_ed9b4257	pkg_b9cec660	t	2025-06-18	2025-08-07 17:02:16	\N
205fa41f-0bbd-45cc-bfd9-e32e12411a66	Treasury Executive	Full-time	comp_0fad9501	8	loc_3377aa9f	pkg_6d5c2208	t	2025-06-18	2025-08-07 17:02:16	\N
0d8af5fc-cb93-43a8-aa11-13d2b3de4388	Crypto Analyst	Full-time	comp_897e329e	6	loc_c79e83a4	pkg_136922f5	t	2025-06-17	2025-08-07 17:02:16	\N
0c566704-3023-440b-9097-1ce9b6cec0ab	Data Analyst	Full-time	comp_897e329e	6	loc_c79e83a4	pkg_5047dbae	t	2025-06-17	2025-08-07 17:02:16	\N
344e54e9-cbea-4816-9ff9-b31edbfd8538	Data Monitoring & Automation	Full-time	comp_897e329e	6	loc_c79e83a4	pkg_81ad9c08	t	2025-06-17	2025-08-07 17:02:16	\N
abe705e2-5b57-42eb-afe3-1347e01f32d4	Associate Project Manager	Full-time	comp_897e329e	6	loc_c79e83a4	pkg_5047dbae	t	2025-06-16	2025-08-07 17:02:16	\N
ad5e3b11-80b2-43fb-9896-4868570b9e66	IT Support	Full-time	comp_b7cfd20d	13	loc_6fc8a029	pkg_cf7c1d4a	t	2025-06-16	2025-08-07 17:02:16	\N
954c154b-99f8-4c00-aa89-187bf77e7a76	Sales Support Executive (Lokal & Export)	Full-time	comp_0fad9501	25	loc_3377aa9f	pkg_81ad9c08	t	2025-06-12	2025-08-07 17:02:16	\N
cfaa11c2-77be-46d5-bd29-605ea8c80628	Trade and Business Analyst – Offline Sales	Full-time	comp_6f1897d1	6	loc_6fc8a029	pkg_8a019595	t	2025-06-10	2025-08-07 17:02:16	\N
227dc27b-cedc-4639-a925-93f666c80b39	Social Media Intern	Internship	comp_001cf410	15	loc_6fc8a029	pkg_8a019595	t	2025-08-07	2025-08-08 11:42:39	\N
f67730eb-d8ba-4139-b20a-130b89a00ae9	Android Developer	Contract	comp_786c073f	18	loc_6fc8a029	pkg_8a019595	t	2025-08-07	2025-08-08 11:42:39	\N
7185589e-ba8a-43e6-b914-eaacf8c36cc1	IT Security (Red Team)	Contract	comp_786c073f	1	loc_6fc8a029	pkg_8a019595	t	2025-08-07	2025-08-08 11:42:39	\N
8f07514c-12f2-431a-bf7a-7389030986ac	CRM Intern (Mandarin Speaker)	Internship	comp_001cf410	15	loc_c4a315a0	pkg_c05686ed	t	2025-08-07	2025-08-08 11:42:39	\N
9e3f69d2-dba7-4bda-96f8-7c1573038a68	Client Success Manager	Full-time	comp_2cbee61a	23	loc_3a4297ba	pkg_35e73ccb	t	2025-08-07	2025-08-08 11:42:39	\N
513d36dc-3763-41a9-aed1-af50f5ebcf59	Motion Design Intern	Internship	comp_001cf410	12	loc_11009f90	pkg_8a019595	t	2025-08-04	2025-08-08 11:42:39	\N
14d4f308-4eb6-4f5d-b7d3-5513f0d73547	Graphic Design Intern	Internship	comp_001cf410	12	loc_11009f90	pkg_8a019595	t	2025-08-04	2025-08-08 11:42:39	\N
aaa9378f-ed0b-4f50-b7c1-501b271fd202	Social Media Intern	Internship	comp_001cf410	5	loc_c4a315a0	pkg_8a019595	t	2025-08-03	2025-08-08 11:42:39	\N
434767b2-d6e2-4be1-bcbb-011619211a5f	Campaign Management Intern (Mandarin speaker)	Full-time	comp_001cf410	5	loc_f1fdffc6	pkg_25e4938d	t	2025-08-01	2025-08-08 11:42:39	\N
90f06bf2-52d4-4050-8c17-a9a941d4feb7	Performance Marketing Intern	Internship	comp_001cf410	15	loc_f1fdffc6	pkg_8a019595	t	2025-07-24	2025-08-08 11:42:39	\N
6f87c9a0-cbe0-432e-9970-802f67929fd6	Solutions Engineering Intern	Internship	comp_001cf410	15	loc_c4a315a0	pkg_8a019595	t	2025-07-15	2025-08-08 11:42:39	\N
fff4e3e7-fb1d-4d6a-bffd-24111fc21c5e	Associate Account Manager	Full-time	comp_001cf410	15	loc_c4a315a0	pkg_8a019595	t	2025-07-15	2025-08-08 11:42:39	\N
f35d7299-ee90-4625-ac60-4a8781556f59	SEO Intern	Internship	comp_001cf410	15	loc_f1fdffc6	pkg_25e4938d	t	2025-07-14	2025-08-08 11:42:39	\N
fc4c54ea-e693-43fa-aa93-6276db1aa230	Quality Assurance Intern	Internship	comp_001cf410	15	loc_f1fdffc6	pkg_8a019595	t	2025-07-11	2025-08-08 11:42:39	\N
4607802e-ca69-4938-8797-6660d177638c	Graphic Design Intern	Full-time	comp_001cf410	15	loc_f1fdffc6	pkg_25e4938d	t	2025-07-09	2025-08-08 11:42:39	\N
94d369b7-c493-4e22-9ca1-6903d8adf912	Digital Marketing Intern	Internship	comp_001cf410	15	loc_f1fdffc6	pkg_25e4938d	t	2025-07-09	2025-08-08 11:42:39	\N
116f7279-6431-4c96-b839-ed255c546c79	Digital Marketing Intern	Internship	comp_001cf410	15	loc_260afe44	pkg_ff4ad210	t	2025-07-09	2025-08-08 11:42:39	\N
21379c58-dde1-4ff4-aafb-df6aa7eb2048	Operations Intern	Internship	comp_001cf410	25	loc_c4a315a0	pkg_cfc9aa67	t	2025-07-09	2025-08-08 11:42:39	\N
770820e3-00d0-43bc-ae05-959abff9453d	Legal Associate	Full-time	comp_001cf410	8	loc_c4a315a0	pkg_8a019595	t	2025-07-08	2025-08-08 11:42:39	\N
bffdae69-98b1-40cc-8246-7d85a89a21e3	Digital Marketing Intern	Internship	comp_001cf410	15	loc_c4a315a0	pkg_8a019595	t	2025-07-03	2025-08-08 11:42:39	\N
aac95781-b2bb-46d4-b6d6-2d0eb7500869	Digital Marketing Intern	Internship	comp_001cf410	15	loc_11009f90	pkg_8a019595	t	2025-07-02	2025-08-08 11:42:39	\N
7d6c6140-968d-44eb-92a4-50e42e2e457d	Vice President, Go-to-Market (GTM), OT/ICS Cybersecurity	Full-time	comp_3e2b102a	4	loc_3a4297ba	pkg_8a019595	t	2025-07-02	2025-08-08 11:42:39	\N
0e882834-6fed-4161-b87b-97fc40cb399a	Senior Front End Developer	Full-time	comp_3e2b102a	1	loc_3a4297ba	pkg_8a019595	t	2025-07-02	2025-08-08 11:42:39	\N
fcfc5c78-893c-47c0-8561-95a9c253b682	Social Media Intern	Full-time	comp_001cf410	5	loc_f1fdffc6	pkg_25e4938d	t	2025-06-24	2025-08-08 11:42:39	\N
334a60e1-6e16-4459-be08-053012cbe069	Growth Intern	Internship	comp_001cf410	4	loc_f1fdffc6	pkg_25e4938d	t	2025-06-24	2025-08-08 11:42:39	\N
867cbcc8-6f46-4c4c-9cb2-b53b8ab5937d	Channel Sales Manager (Partnership, Cybersecurity, Petaling Jaya)	Full-time	comp_85f04910	4	loc_2d1bf72b	pkg_9eb8cc5e	t	2025-06-20	2025-08-08 11:42:39	\N
cf1ef4f5-ffde-49a3-8807-3f6fa2045c4c	Strategist (Design Industry)	Full-time	comp_275c3945	15	loc_3a4297ba	pkg_8a019595	t	2025-06-19	2025-08-08 11:42:39	\N
0fdd5b56-1f94-454e-83fd-eaf3b5403795	Campaign Management Intern	Internship	comp_001cf410	5	loc_f1fdffc6	pkg_25e4938d	t	2025-06-13	2025-08-08 11:42:39	\N
997b5a62-88e1-4a6e-91f9-61b9971c9869	Solutions Engineer Intern	Internship	comp_001cf410	1	loc_f1fdffc6	pkg_8a019595	t	2025-06-13	2025-08-08 11:42:39	\N
ed6a657a-d7e3-4f67-8670-51672e548b6c	Campaign Management Intern	Internship	comp_001cf410	15	loc_11009f90	pkg_8a019595	t	2025-06-11	2025-08-08 11:42:39	\N
779e8541-3ada-4b99-bc28-c4bebb11f73c	Senior Regional Account Manager	Full-time	comp_b8d9b6b5	4	loc_c4a315a0	pkg_f008ccf6	t	2025-07-25	2025-08-08 11:42:39	\N
decd8f92-02c8-4a05-975d-5dea466caf95	Product Manager	Full-time	comp_8201464a	3	loc_3a4297ba	pkg_8a019595	t	2025-07-07	2025-08-08 11:42:39	\N
27099f71-bf3b-4309-aeb9-b55bb40620e5	Creative Director, Southeast Asia	Full-time	comp_061d5045	5	loc_3a4297ba	pkg_8a019595	t	2025-07-07	2025-08-08 11:42:39	\N
bf900c3a-9649-423d-b2ab-f63466b1ae46	Senior Manager FP&A Quick Commerce	Full-time	comp_2b79c98f	8	loc_3a4297ba	pkg_8a019595	t	2025-07-04	2025-08-08 11:42:39	\N
de80f20c-0770-4453-9136-5b344bef2781	Strategic Core Account Executive	Full-time	comp_2d3dad41	4	loc_3a4297ba	pkg_8a019595	t	2025-07-04	2025-08-08 11:42:39	\N
87a3446a-77e0-468f-ac1d-567864f52641	QC Digital Associate (Singapore)	Contract	comp_d3062ed3	26	loc_3a4297ba	pkg_8a019595	t	2025-07-04	2025-08-08 11:42:39	\N
25b4cd08-55e9-428e-a477-062772163790	Senior Data Scientist, Product Analytics	Full-time	comp_69636f05	6	loc_3a4297ba	pkg_8a019595	t	2025-07-04	2025-08-08 11:42:39	\N
fe712524-f518-40cc-93fc-eaa70b7a87e9	Sales Engineer - Vietnamese Speaking	Full-time	comp_bd7c7997	4	loc_3a4297ba	pkg_8a019595	t	2025-07-04	2025-08-08 11:42:39	\N
794b9825-abdb-4dcb-b467-cbe76db5326f	Account Executive- Mid-Market Sales	Full-time	comp_ff343642	4	loc_3a4297ba	pkg_cf34d0a9	t	2025-07-04	2025-08-08 11:42:39	\N
c0d3a642-20f8-4482-8592-ec2ea9419f0b	News Assistant	Full-time	comp_0dab276b	7	loc_3a4297ba	pkg_8a019595	t	2025-07-04	2025-08-08 11:42:39	\N
b27ca7c4-bc8a-4ae1-a3b2-2f544441e5c2	Product Manager	Full-time	comp_191810d7	3	loc_3a4297ba	pkg_8a019595	t	2025-07-04	2025-08-08 11:42:39	\N
6dd54fd9-7b39-4018-8f13-7bbc2744760e	Fractional Legal Counsel	Part-time	comp_a4441e07	8	loc_3a4297ba	pkg_8a019595	t	2025-07-04	2025-08-08 11:42:39	\N
b12e2eed-4296-41d6-a3c1-ca84243e9bcb	Head of Editorial, SEA	Full-time	comp_2a0cb6b4	7	loc_3a4297ba	pkg_8a019595	t	2025-07-04	2025-08-08 11:42:39	\N
737a2bec-f319-4b43-b49c-f22cc36a2082	DevOps Engineer	Full-time	comp_d5c3fb90	1	loc_3a4297ba	pkg_8a019595	t	2025-07-04	2025-08-08 11:42:39	\N
07a2d112-f99a-4ec3-b7c4-56a15ee598ee	Associate, Media	Full-time	comp_10913ed7	5	loc_3a4297ba	pkg_8a019595	t	2025-07-04	2025-08-08 11:42:39	\N
f19f8b51-10f6-4e21-9a71-a6017f6c335f	Senior Business Development Manager	Full-time	comp_2b79c98f	4	loc_3a4297ba	pkg_8a019595	t	2025-07-04	2025-08-08 11:42:39	\N
45460d59-6881-4e36-bf59-fd00055e4a6d	Commercial Director, SEA	Full-time	comp_182e6e6b	4	loc_3a4297ba	pkg_8a019595	t	2025-07-04	2025-08-08 11:42:39	\N
01493003-5df2-4bd2-a63e-2dc4d446287c	Compliance Senior Specialist - Assurance	Full-time	comp_a5b171d7	8	loc_3a4297ba	pkg_e181020f	t	2025-07-04	2025-08-08 11:42:39	\N
4a71473a-9f14-4f21-88dd-47d55b4a26fb	Finance Manager	Full-time	comp_2cab9537	8	loc_3a4297ba	pkg_8a019595	t	2025-07-04	2025-08-08 11:42:39	\N
b3190ea6-c98e-44fc-9ce7-2b5565fd574c	Product Design Manager	Full-time	comp_bd58ceda	24	loc_3a4297ba	pkg_8a019595	t	2025-07-03	2025-08-08 11:42:39	\N
d729a446-3954-472f-a24a-96528482d52d	Group Product Manager	Full-time	comp_69636f05	3	loc_3a4297ba	pkg_8a019595	t	2025-07-03	2025-08-08 11:42:39	\N
0300b0de-6d37-40c2-8b89-2657ddca2f87	UI/UX Designer	Full-time	comp_fc5b7177	24	loc_3a4297ba	pkg_8a019595	t	2025-07-03	2025-08-08 11:42:39	\N
0283df69-e3b1-437b-bc6a-81ce8f94f362	Mobile Engineer (Flutter)	Full-time	comp_3e937bff	1	loc_3a4297ba	pkg_8a019595	t	2025-07-03	2025-08-08 11:42:39	\N
4d76f80f-018f-49b1-bf54-b4573fdbdc9c	Developer Relations	Full-time	comp_d8940ed2	21	loc_3a4297ba	pkg_8a019595	t	2025-07-02	2025-08-08 11:42:39	\N
66f3e893-e985-4100-b78c-3c0c71de5d66	Product Designer	Full-time	comp_e4c611e6	24	loc_3a4297ba	pkg_8a019595	t	2025-07-02	2025-08-08 11:42:39	\N
19dbc8e6-0432-4610-bed9-9f8ddc737676	UI/UX Designer	Full-time	comp_7bff9de3	24	loc_3a4297ba	pkg_8a019595	t	2025-07-02	2025-08-08 11:42:39	\N
7b43caad-db73-4ff0-a886-7fe7a2b5e886	SEO Content Specialist (Owned Sites)	Full-time	comp_a5b171d7	5	loc_3a4297ba	pkg_8a019595	t	2025-07-01	2025-08-08 11:42:39	\N
921586cf-bb9d-4370-82b6-8eb17013746e	Director, Payment Partnerships (Treasury Management)	Full-time	comp_b3ccd852	15	loc_3a4297ba	pkg_8a019595	t	2025-07-01	2025-08-08 11:42:39	\N
f4ca8980-3bd5-4b95-9f64-3eb149370362	Marketing Director	Full-time	comp_fbb0c353	5	loc_3a4297ba	pkg_8a019595	t	2025-07-01	2025-08-08 11:42:39	\N
2fc066e0-40b3-47b9-8b3d-2fc532fed0e8	Compliance Associate	Full-time	comp_fbedb4f4	8	loc_3a4297ba	pkg_8a019595	t	2025-06-30	2025-08-08 11:42:39	\N
fc475893-23ef-4ce1-923c-688d4d091b35	Head, pandamart Operations (SGMY)	Full-time	comp_2b79c98f	17	loc_3a4297ba	pkg_8a019595	t	2025-06-30	2025-08-08 11:42:39	\N
7ce32fa8-17c4-467a-9c4d-e136ad0cc065	Market Associate (English & Bahasa Indonesia)	Full-time	comp_6d785501	23	loc_3a4297ba	pkg_8a019595	t	2025-06-29	2025-08-08 11:42:39	\N
83db2ada-95ae-4d6c-948b-76b927ea2fdd	Head of Sales - Singapore	Full-time	comp_de49a36f	4	loc_3a4297ba	pkg_8a019595	t	2025-06-29	2025-08-08 11:42:39	\N
0c8b9683-8389-4717-9b5e-1b8d2ec93363	Senior Systems Engineer - APAC	Full-time	comp_a5b171d7	1	loc_3a4297ba	pkg_f8003617	t	2025-06-29	2025-08-08 11:42:39	\N
909adb7e-612d-4e94-9229-dfefcc8287ad	Senior Product Designer	Full-time	comp_ddba2c92	24	loc_3a4297ba	pkg_8a019595	t	2025-06-27	2025-08-08 11:42:39	\N
94e3b808-1b37-4485-986c-c2e29bfcf319	Marketing Campaign Associate	Full-time	comp_4ed90f1c	5	loc_3a4297ba	pkg_8a019595	t	2025-06-27	2025-08-08 11:42:39	\N
02f92f71-5532-455c-b521-a61ab5094f9a	Partner Marketing Manager	Full-time	comp_bd7c7997	5	loc_3a4297ba	pkg_8a019595	t	2025-06-27	2025-08-08 11:42:39	\N
281da893-4f66-4ee9-a148-babb0868b2d2	Senior Software Developer - Golang	Full-time	comp_92087caf	1	loc_3a4297ba	pkg_8a019595	t	2025-06-27	2025-08-08 11:42:39	\N
a0bbe528-997f-41dd-b467-1c48e4e5d08c	Senior Backend Developer	Full-time	comp_92087caf	1	loc_3a4297ba	pkg_8a019595	t	2025-06-27	2025-08-08 11:42:39	\N
0be61cca-9d94-45fc-b8ca-a909591b2d3d	Legal Intern	Internship	comp_6d785501	8	loc_3a4297ba	pkg_8a019595	t	2025-06-27	2025-08-08 11:42:39	\N
d286871c-6547-4b2b-a8c7-9d31b30dbaf9	Senior Analytics Manager	Full-time	comp_cf673a9c	6	loc_3a4297ba	pkg_8a019595	t	2025-06-27	2025-08-08 11:42:39	\N
6a29a72b-3a5f-4f9c-b973-e91f7fb156a3	KYC Analyst/Officer	Full-time	comp_935614de	8	loc_3a4297ba	pkg_8a019595	t	2025-06-27	2025-08-08 11:42:39	\N
f30dc198-4b90-4b5a-aa77-a82679f01fb2	Enterprise Marketing - Japan	N/A	comp_fc64b48c	5	loc_36248990	pkg_8a019595	t	2025-06-27	2025-08-08 11:42:39	\N
51d112df-7b91-4524-bebd-aaaca230f99c	Head of Marketing, APAC	Full-time	comp_061d5045	5	loc_3a4297ba	pkg_8a019595	t	2025-06-26	2025-08-08 11:42:39	\N
80c459aa-b1bf-476f-b911-925d3e97117f	Data Strategy & Analytics Specialist	Full-time	comp_e077b555	6	loc_3a4297ba	pkg_8a019595	t	2025-06-26	2025-08-08 11:42:39	\N
c9e11d6d-dd27-4423-bdad-f9df28bfaad9	Content Strategist	Contract	comp_4af26436	21	loc_3a4297ba	pkg_8a019595	t	2025-06-26	2025-08-08 11:42:39	\N
4b23e63a-90ef-4e1a-8363-f9b625e6786f	Growth Builder	Contract	comp_4af26436	21	loc_3a4297ba	pkg_8a019595	t	2025-06-26	2025-08-08 11:42:39	\N
f5feb898-ff0a-4470-8081-e057085dca80	Assistant Manager - Data Analytics (Finance)	Full-time	comp_2611075b	6	loc_3a4297ba	pkg_8a019595	t	2025-06-25	2025-08-08 11:42:39	\N
7faf3c1a-45c9-4002-963e-4f02be36113f	Senior Analyst, FP&A	Full-time	comp_e409be0b	8	loc_3a4297ba	pkg_8a019595	t	2025-06-25	2025-08-08 11:42:39	\N
3295207a-b791-4c36-8980-e33a26ca04f8	Regional Head, Performance Marketing, SEA	Full-time	comp_cf673a9c	5	loc_3a4297ba	pkg_8a019595	t	2025-06-25	2025-08-08 11:42:39	\N
a73c4d29-0317-4e15-b692-88ea75ce5477	Observability Architect (Remote, Singapore)	Full-time	comp_7a9dec80	23	loc_3a4297ba	pkg_b987522b	t	2025-06-25	2025-08-08 11:42:39	\N
2e543fbb-ca0b-46ab-a3c5-01627c17e149	Account Manager - Singapore	Full-time	comp_d69b8fd0	23	loc_3a4297ba	pkg_8a019595	t	2025-06-25	2025-08-08 11:42:39	\N
ae38dbca-e3d5-480f-85fb-804488c40d13	Customer Success Manager, SME & Growth	Full-time	comp_e409be0b	23	loc_3a4297ba	pkg_8a019595	t	2025-06-25	2025-08-08 11:42:39	\N
81301a34-494a-407b-87a0-d6be851059c7	Sales Account Manager (Singapore)	Full-time	comp_0555b28d	4	loc_3a4297ba	pkg_8a019595	t	2025-06-25	2025-08-08 11:42:39	\N
322897b8-54c6-4565-b718-8763bfc56b48	Senior Salesforce Developer	Full-time	comp_bd39704c	1	loc_3a4297ba	pkg_8a019595	t	2025-06-24	2025-08-08 11:42:39	\N
7a8a09d8-96c7-4229-b9cd-26df180a8300	Senior Director, Strategic Tech Partnerships, AP	Full-time	comp_8201464a	4	loc_3a4297ba	pkg_8a019595	t	2025-06-24	2025-08-08 11:42:39	\N
ac804904-4e2c-4f9f-a288-1e542e3562ce	Sales Engineer	Full-time	comp_8201464a	4	loc_3a4297ba	pkg_8a019595	t	2025-06-24	2025-08-08 11:42:39	\N
eeac7f3c-d249-431d-995b-67f27552a7f8	Technical Delivery Manager	Full-time	comp_fd601fda	3	loc_3a4297ba	pkg_8a019595	t	2025-06-24	2025-08-08 11:42:39	\N
f654325f-32b3-41c5-aa0e-4f25d0be1ff4	Chief Financial Officer (CFO)	Full-time	comp_2611075b	22	loc_3a4297ba	pkg_8a019595	t	2025-06-24	2025-08-08 11:42:39	\N
78d26cba-c59f-4561-a532-ffd9fd41e092	Chief Risk Officer (CRO)	Full-time	comp_2611075b	22	loc_3a4297ba	pkg_8a019595	t	2025-06-24	2025-08-08 11:42:39	\N
f1621821-d4cd-4c57-b4cb-68685c4fcaf7	VP Strategic Finance	Full-time	comp_2611075b	8	loc_3a4297ba	pkg_8a019595	t	2025-06-24	2025-08-08 11:42:39	\N
8690f7cf-f6ed-4d00-9195-42df3c3c6a57	Marketing Associate, GrabRentals	Full-time	comp_cf673a9c	5	loc_3a4297ba	pkg_8a019595	t	2025-06-24	2025-08-08 11:42:39	\N
6f3d4379-6467-4f85-a370-e620cf83dbd5	Legal & Compliance Specialist	Full-time	comp_cdac48f2	8	loc_3a4297ba	pkg_8a019595	t	2025-06-24	2025-08-08 11:42:39	\N
2b12a89e-e950-48c5-bb21-dfc526dbe30d	Growth Risk Data Lead	Full-time	comp_f130bd81	6	loc_3a4297ba	pkg_8a019595	t	2025-06-24	2025-08-08 11:42:39	\N
eae052a7-1f16-43ec-a1b5-c5d27846e94a	Manager - Content Partnerships (SEA)	Full-time	comp_66386d47	5	loc_3a4297ba	pkg_8a019595	t	2025-06-24	2025-08-08 11:42:39	\N
00fa673d-62f6-46dc-93b5-a26b582ce433	Logistics Supervisor	Full-time	comp_3e937bff	17	loc_3a4297ba	pkg_8a019595	t	2025-06-24	2025-08-08 11:42:39	\N
4013e3dd-611d-4c0c-aadc-2ea3d8c35abb	AI Solutions Architect - Singapore	Full-time	comp_57f2a6a7	3	loc_3a4297ba	pkg_8a019595	t	2025-06-24	2025-08-08 11:42:39	\N
19c86d5f-23f6-43bf-b7dc-ebad76e108bd	Associate, Merchant Operations	Full-time	comp_cf673a9c	17	loc_3a4297ba	pkg_8a019595	t	2025-06-23	2025-08-08 11:42:39	\N
a5c4f336-e70e-46d8-b99f-63021d7c4acf	Regional Sales Manager, Singapore (Enterprise)	Full-time	comp_1f59357b	4	loc_3a4297ba	pkg_8a019595	t	2025-06-23	2025-08-08 11:42:39	\N
bcf735de-5d41-4497-b631-c83a1f97f2d1	Product Sales Specialist	Full-time	comp_d05d22f9	4	loc_3a4297ba	pkg_8a019595	t	2025-06-23	2025-08-08 11:42:39	\N
0a8ddd8d-2c61-419a-b720-27808f7d815a	APAC Technical Architect	Full-time	comp_bc33e281	3	loc_3a4297ba	pkg_8a019595	t	2025-06-23	2025-08-08 11:42:39	\N
f48b5b68-97d8-4323-a229-8956a492dd69	Senior Fullstack UI Developer (Trading Platform)	Full-time	comp_92087caf	1	loc_3a4297ba	pkg_8a019595	t	2025-06-23	2025-08-08 11:42:39	\N
18af3e9d-009d-40dc-a76f-3660acc1a8ad	Product Manager	Full-time	comp_4807102a	3	loc_3a4297ba	pkg_8a019595	t	2025-06-23	2025-08-08 11:42:39	\N
3570b66f-61d8-4355-a852-8a22e096edf5	Engineering Manager, Workspaces	Full-time	comp_e67b8b2b	1	loc_bf984a20	pkg_8a019595	t	2025-06-20	2025-08-08 11:42:39	\N
8f607195-6e4c-43b2-b3dd-72e763025224	Operations Risk & Controls Analyst	Full-time	comp_08b00238	8	loc_3a4297ba	pkg_8a019595	t	2025-06-20	2025-08-08 11:42:39	\N
7390188f-a190-43e4-8b8c-f35d29642a28	Senior Brand Partnership Manager	Full-time	comp_45dda8dd	5	loc_3a4297ba	pkg_8a019595	t	2025-06-20	2025-08-08 11:42:39	\N
b7a32b34-42a4-4877-8144-697c08416995	Product Operations Executive (RedeemSG)	Contract	comp_ad58cf1d	17	loc_3a4297ba	pkg_8a019595	t	2025-06-20	2025-08-08 11:42:39	\N
dab43ded-ec16-4b5a-8b01-80164e00ec9c	Lead, Commercial, Merchant Development	Full-time	comp_cf673a9c	4	loc_3a4297ba	pkg_8a019595	t	2025-06-20	2025-08-08 11:42:39	\N
a999086b-c194-4e6a-be92-7f0b60996544	Associate Cybersecurity Engineer	Full-time	comp_8201464a	1	loc_3a4297ba	pkg_8a019595	t	2025-06-20	2025-08-08 11:42:39	\N
79bcd6a8-5bcc-42be-b00e-457579fd9e45	Marketing Operations Manager (Singapore)	Full-time	comp_13be65af	5	loc_3a4297ba	pkg_8a019595	t	2025-06-20	2025-08-08 11:42:39	\N
5b960bad-4c37-47c8-8cdb-e0de844c3b17	APAC Product Marketing Lead	Full-time	comp_4d08ec58	5	loc_3a4297ba	pkg_3695fbbb	t	2025-06-20	2025-08-08 11:42:39	\N
02cb7836-ffa1-4a94-bba1-3249f55af2a9	Credit Operations Analyst (Mandarin Speaking)	Full-time	comp_4d08ec58	8	loc_3a4297ba	pkg_5a4d4df5	t	2025-06-18	2025-08-08 11:42:39	\N
e47eaac7-0865-45a0-b4e0-30ad50e6c251	Product Support Specialist - APAC	Full-time	comp_43b2df2c	23	loc_3a4297ba	pkg_f0683732	t	2025-06-18	2025-08-08 11:42:39	\N
51322fd4-60bb-4077-ae3c-a58bcdaf34a9	AI Engineer	Full-time	comp_e409be0b	1	loc_3a4297ba	pkg_8a019595	t	2025-06-18	2025-08-08 11:42:39	\N
cfa39a40-e986-44d3-9518-dd8bca2a6e8c	Engineering Director	Full-time	comp_f130bd81	1	loc_3a4297ba	pkg_8a019595	t	2025-06-18	2025-08-08 11:42:39	\N
a369ddc0-6144-4e86-a1df-dbe81f9110d8	Regional Head of E-Commerce APAC	Full-time	comp_84d12c36	22	loc_3a4297ba	pkg_8a019595	t	2025-06-18	2025-08-08 11:42:39	\N
5f072989-5715-4502-b0c0-56ad185a5530	Sr. Marketing Lead South Korea	N/A	comp_d06cde3b	5	loc_3179468e	pkg_8a019595	t	2025-06-18	2025-08-08 11:42:39	\N
b4e23304-6977-46d7-82db-a73eab0af34d	Lead Software Engineer - AI Monitoring	Full-time	comp_ff343642	1	loc_2f42cc33	pkg_8a019595	t	2025-06-18	2025-08-08 11:42:39	\N
1d2e8022-262a-4e6a-928a-378adb77873a	Chief of Staff	Full-time	comp_bdfb3ee8	22	loc_3a4297ba	pkg_8a019595	t	2025-06-18	2025-08-08 11:42:39	\N
f73fe883-e8c0-4005-a8d7-ace9f1ea2100	Member of Sales Team	Full-time	comp_2ab6c8d1	4	loc_3a4297ba	pkg_8a019595	t	2025-06-18	2025-08-08 11:42:39	\N
ed817e0a-f432-4354-bfc8-b98211b45432	Chief of Staff, CEO	Full-time	comp_e409be0b	22	loc_3a4297ba	pkg_8a019595	t	2025-06-16	2025-08-08 11:42:39	\N
9accc41c-76e5-47bc-be94-3f71c79d8360	Regional Marketing Manager	Full-time	comp_1dc9253a	5	loc_3a4297ba	pkg_8a019595	t	2025-06-16	2025-08-08 11:42:39	\N
8d01754f-f77c-455d-9ba1-2b09f9e90e9d	Staff Data Analyst	Full-time	comp_4d08ec58	6	loc_3a4297ba	pkg_0819a78e	t	2025-06-13	2025-08-08 11:42:39	\N
736163c9-a5b7-48d2-aa42-ea0e2d1f509d	Global Service Operations Manager	Full-time	comp_3e937bff	23	loc_3a4297ba	pkg_8a019595	t	2025-06-13	2025-08-08 11:42:39	\N
91552b31-8a3e-485e-9eba-445f8555192d	Product Designer	Full-time	comp_06acf8bb	24	loc_3a4297ba	pkg_8a019595	t	2025-06-13	2025-08-08 11:42:39	\N
54ed187c-086d-418c-8b03-876a2468496f	Java Software Engineer, Alternatives	Full-time	comp_49c2c721	1	loc_3a4297ba	pkg_8a019595	t	2025-06-13	2025-08-08 11:42:39	\N
f647816c-e4df-4bf0-8259-451ec50064ba	Senior AI Engineer, Knowledge Platform	Full-time	comp_e409be0b	1	loc_3a4297ba	pkg_8a019595	t	2025-06-13	2025-08-08 11:42:39	\N
9ac31ac4-e452-40a3-8eb2-49efaff3f877	Regional CRM Associate	Full-time	comp_06acf8bb	5	loc_c4a315a0	pkg_8a019595	t	2025-06-12	2025-08-08 11:42:39	\N
ca0b00c6-386e-4a29-b0be-0f6a78bce954	AI Technical Support Specialist	Full-time	comp_a19ee5a9	23	loc_36248990	pkg_8a019595	t	2025-06-12	2025-08-08 11:42:39	\N
46e5b713-36fd-4c33-b76c-f37fab09cffa	Senior Software Engineer, Release and Quality Engineering	Full-time	comp_06d5cd3a	1	loc_3a4297ba	pkg_8a019595	t	2025-06-12	2025-08-08 11:42:39	\N
e5d32285-1995-4e55-8ef9-9e015310fd07	Global Expansion Manager	Full-time	comp_06acf8bb	5	loc_3a4297ba	pkg_8a019595	t	2025-06-12	2025-08-08 11:42:39	\N
17c60e5f-7037-4e1a-9ac2-ec5884edc555	Head of Regional Marketing (ShopBack Pay)	Full-time	comp_06acf8bb	5	loc_3a4297ba	pkg_8a019595	t	2025-06-11	2025-08-08 11:42:39	\N
45ab0de0-d4f9-47d8-81b2-a0e9419142d4	Content & Partnerships Lead	Full-time	comp_935614de	5	loc_3a4297ba	pkg_8a019595	t	2025-06-11	2025-08-08 11:42:39	\N
2e3594cb-77db-4116-aa58-3bd5175911f0	Head of Sales, APJ	Full-time	comp_187a8813	4	loc_3a4297ba	pkg_8a019595	t	2025-06-11	2025-08-08 11:42:39	\N
c5db7a42-417e-4b28-b664-0afd095911d2	Lead Software Engineer	Full-time	comp_8201464a	1	loc_3a4297ba	pkg_8a019595	t	2025-06-11	2025-08-08 11:42:39	\N
ebf11d07-5fe7-472d-841b-ce19dbdafa32	Engineering Manager	Full-time	comp_191810d7	1	loc_3a4297ba	pkg_8a019595	t	2025-06-11	2025-08-08 11:42:39	\N
f594eeba-5503-4eef-a72c-ec006c3caab2	Engineering Manager, AI Automation & QA	Full-time	comp_486af5da	1	loc_2f42cc33	pkg_8a019595	t	2025-06-11	2025-08-08 11:42:39	\N
ff5e5505-1c26-4db6-b06a-1fa0af4adb12	Staff Machine Learning Engineer	Full-time	comp_cff30d88	1	loc_a12a5005	pkg_8a019595	t	2025-06-11	2025-08-08 11:42:39	\N
0ac3fd56-a7e4-4d50-a4c0-101fbdc82d31	Medical AI Specialist	Full-time	comp_36d27c9f	1	loc_8d029514	pkg_8a019595	t	2025-06-11	2025-08-08 11:42:39	\N
491d39b4-c3e3-4604-8c44-4e45dc8dc8de	Senior AI Engineer	Full-time	comp_919aed83	1	loc_bf984a20	pkg_8a019595	t	2025-06-11	2025-08-08 11:42:39	\N
afb3825c-9c07-47d2-bd2a-ed5efaf7361d	Staff AI Engineer	Full-time	comp_919aed83	1	loc_bf984a20	pkg_8a019595	t	2025-06-11	2025-08-08 11:42:39	\N
f814b677-c910-415e-b8f1-59c66d0a2bcc	Product Manager (AI & Data)	Full-time	comp_97aa25d0	3	loc_260afe44	pkg_8a019595	t	2025-06-11	2025-08-08 11:42:39	\N
f28302b4-9711-47ff-ab48-fc678b18612e	Applied AI Research Scientist	Full-time	comp_6c4b8ba7	6	loc_3a4297ba	pkg_8a019595	t	2025-06-11	2025-08-08 11:42:39	\N
60821aa5-91eb-47a1-aa95-4e071e6c5d84	SG - IEG - AI Engineer (DDA)	Full-time	comp_c3f51d90	1	loc_3a4297ba	pkg_8a019595	t	2025-06-11	2025-08-08 11:42:39	\N
665e4503-ad7f-4507-8beb-2e9ac8800caf	Senior Engineer, Gateway	Full-time	comp_a07adcb1	1	loc_ffd6c037	pkg_8a019595	t	2025-06-11	2025-08-08 11:42:39	\N
5500cf9b-b522-419f-b319-5681fa97e50a	Senior Software Engineer (Java, Python, AI & ML)	Full-time	comp_f2bfda81	1	loc_c4a315a0	pkg_8a019595	t	2025-06-11	2025-08-08 11:42:39	\N
af5c1cd3-7f45-4cd2-98af-4999b47e226b	Back End Developer (Jr- Mid)	Contract	comp_20ac7aef	2	loc_6fc8a029	pkg_8b9af780	f	2025-07-21	2025-08-07 17:02:16	2025-08-08 13:01:05.654758
53f96ef9-4783-4873-99ed-ceb012e5db0f	Back End Developer (Mid-Sr)	Contract	comp_20ac7aef	2	loc_6fc8a029	pkg_c2d3ede2	f	2025-07-21	2025-08-07 17:02:16	2025-08-08 13:01:05.654758
345d02e8-762a-4091-bf54-f57141f74e89	English Teacher - Jabodetabek	Full-time	comp_a421fc5e	16	loc_9597ddfd	pkg_8a019595	f	2025-06-08	2025-08-07 17:02:16	2025-08-08 13:01:05.654758
4ab29c39-5aee-4c3f-b81b-d837e0103752	Sales & Admin - Jabodetabek	Full-time	comp_a421fc5e	4	loc_6fc8a029	pkg_8a019595	f	2025-06-08	2025-08-07 17:02:16	2025-08-08 13:01:05.654758
61725a76-720d-4014-8497-50cde0c86906	PE Coach - Jabodetabek	Full-time	comp_a421fc5e	16	loc_9597ddfd	pkg_8a019595	f	2025-06-08	2025-08-07 17:02:16	2025-08-08 13:01:05.654758
18d3520f-8ef3-4557-93bc-b2a2df07291b	English Foreign Teacher	Full-time	comp_a421fc5e	16	loc_6fc8a029	pkg_8a019595	f	2025-06-08	2025-08-07 17:02:16	2025-08-08 13:01:05.654758
a699537d-99ed-4be6-9549-9a5c96508871	Human Resources Intern	Internship	comp_a421fc5e	11	loc_9597ddfd	pkg_8a019595	f	2025-06-08	2025-08-07 17:02:16	2025-08-08 13:01:05.654758
e43c039b-8b3e-4dba-b3c4-d6ce3e27f9e2	Digital Products Operations - 3 Month Project (Extendable)	Contract	comp_64e3bb93	3	loc_6fc8a029	pkg_822c6f38	t	2025-08-08	2025-08-08 15:06:02	\N
7aa058e6-8157-4b83-99fc-745ed028d015	Digital Sentiment & Reputation Management Specialist (Public Relation)	Full-time	comp_27286e10	5	loc_9597ddfd	pkg_64e34fb9	f	2025-06-09	2025-08-07 17:02:16	2025-08-08 15:15:15.629981
a8afefc8-ad40-4f0c-a0bf-e240dd6e6e44	Business Data Analyst – Consumer Goods	Full-time	comp_6f1897d1	6	loc_6fc8a029	pkg_8a019595	f	2025-06-09	2025-08-07 17:02:16	2025-08-08 15:15:15.629981
d7f0756f-dca0-4dd7-a30d-c752ce89cb1c	Cloud Software Engineer	Full-time	comp_8b3bb450	1	loc_3a4297ba	pkg_8a019595	f	2025-06-09	2025-08-08 11:42:39	2025-08-08 16:06:05.694358
\.


--
-- Data for Name: job_description; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.job_description (job_id, responsibilities, requirements) FROM stdin;
\.


--
-- Data for Name: location; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.location (location_id, city, country, scraped_at) FROM stdin;
loc_9597ddfd	Tangerang	Indonesia	2025-08-07 17:02:16
loc_6fc8a029	Jakarta	Indonesia	2025-08-07 17:02:16
loc_b3feaf63	Bandung	Indonesia	2025-08-07 17:02:16
loc_8d0798bb	Banten	Indonesia	2025-08-07 17:02:16
loc_5ac55fb0	Bandar Lampung	Indonesia	2025-08-07 17:02:16
loc_b1dddaa6	Bekasi	Indonesia	2025-08-07 17:02:16
loc_357d0063	Depok	Indonesia	2025-08-07 17:02:16
loc_5cca93cb	Batam Island	Indonesia	2025-08-07 17:02:16
loc_be3832cb	Medan	Indonesia	2025-08-07 17:02:16
loc_cb52e018	Bogor	Indonesia	2025-08-07 17:02:16
loc_6dd4ee2b	Semarang	Indonesia	2025-08-07 17:02:16
loc_3377aa9f	Yogyakarta	Indonesia	2025-08-07 17:02:16
loc_148693f5	Indonesia Bulk Terminal	Indonesia	2025-08-07 17:02:16
loc_0d81d8dd	Pontianak	Indonesia	2025-08-07 17:02:16
loc_ed9b4257	Surabaya	Indonesia	2025-08-07 17:02:16
loc_dd964486	Sidoarjo	Indonesia	2025-08-07 17:02:16
loc_1fc48ba3	Kemayoran	Indonesia	2025-08-07 17:02:16
loc_11f7c9b7	Denpasar	Indonesia	2025-08-07 17:02:16
loc_56d34582	Kalbut Situbondo	Indonesia	2025-08-07 17:02:16
loc_c79e83a4	Malang	Indonesia	2025-08-07 17:02:16
loc_c4a315a0	Kuala Lumpur	Malaysia	2025-08-08 11:42:39
loc_3a4297ba	Singapore	Singapore	2025-08-08 11:42:39
loc_11009f90	Makati City	Philippines	2025-08-08 11:42:39
loc_f1fdffc6	Ho Chi Minh City	Vietnam	2025-08-08 11:42:39
loc_260afe44	Bangkok	Thailand	2025-08-08 11:42:39
loc_2d1bf72b	Petaling Jaya	Malaysia	2025-08-08 11:42:39
loc_36248990	Tokyo	Japan	2025-08-08 11:42:39
loc_bf984a20	Bangalore	India	2025-08-08 11:42:39
loc_3179468e	Seoul	Republic of	2025-08-08 11:42:39
loc_2f42cc33	Hyderabad	India	2025-08-08 11:42:39
loc_a12a5005	Sydney	Australia	2025-08-08 11:42:39
loc_8d029514	Melbourne	Australia	2025-08-08 11:42:39
loc_ffd6c037	Shanghai	China	2025-08-08 11:42:39
\.


--
-- Data for Name: part_time; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.part_time (job_id, working_hours_per_weeks, suitable_for_students) FROM stdin;
\.


--
-- Data for Name: resume; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resume (user_id, resume_number, title, summary) FROM stdin;
\.


--
-- Data for Name: resume_skill; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resume_skill (user_id, resume_number, skill) FROM stdin;
\.


--
-- Data for Name: reviewer; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reviewer (reviewer_id, name, company_id) FROM stdin;
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."user" (user_id, name, username, email, password_hash, created_at) FROM stdin;
\.


--
-- Name: applies applies_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.applies
    ADD CONSTRAINT applies_pkey PRIMARY KEY (user_id, resume_number, reviewer_id, job_id);


--
-- Name: company_industry company_industry_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.company_industry
    ADD CONSTRAINT company_industry_pkey PRIMARY KEY (company_id, industry_id);


--
-- Name: company company_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.company
    ADD CONSTRAINT company_pkey PRIMARY KEY (company_id);


--
-- Name: compensation_package compensation_package_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.compensation_package
    ADD CONSTRAINT compensation_package_pkey PRIMARY KEY (compensation_id);


--
-- Name: contract contract_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contract
    ADD CONSTRAINT contract_pkey PRIMARY KEY (job_id);


--
-- Name: freelance freelance_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.freelance
    ADD CONSTRAINT freelance_pkey PRIMARY KEY (job_id);


--
-- Name: full_time full_time_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.full_time
    ADD CONSTRAINT full_time_pkey PRIMARY KEY (job_id);


--
-- Name: function function_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.function
    ADD CONSTRAINT function_pkey PRIMARY KEY (function_id);


--
-- Name: industry industry_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.industry
    ADD CONSTRAINT industry_pkey PRIMARY KEY (industry_id);


--
-- Name: internship internship_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.internship
    ADD CONSTRAINT internship_pkey PRIMARY KEY (job_id);


--
-- Name: job_description job_description_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_description
    ADD CONSTRAINT job_description_pkey PRIMARY KEY (job_id);


--
-- Name: job job_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job
    ADD CONSTRAINT job_pkey PRIMARY KEY (job_id);


--
-- Name: location location_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.location
    ADD CONSTRAINT location_pkey PRIMARY KEY (location_id);


--
-- Name: part_time part_time_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.part_time
    ADD CONSTRAINT part_time_pkey PRIMARY KEY (job_id);


--
-- Name: resume resume_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resume
    ADD CONSTRAINT resume_pkey PRIMARY KEY (user_id, resume_number);


--
-- Name: resume_skill resume_skill_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resume_skill
    ADD CONSTRAINT resume_skill_pkey PRIMARY KEY (user_id, resume_number, skill);


--
-- Name: reviewer reviewer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviewer
    ADD CONSTRAINT reviewer_pkey PRIMARY KEY (reviewer_id);


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (user_id);


--
-- Name: idx_applies_job_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_applies_job_id ON public.applies USING btree (job_id);


--
-- Name: idx_applies_user_resume; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_applies_user_resume ON public.applies USING btree (user_id, resume_number);


--
-- Name: idx_company_industry_company_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_company_industry_company_id ON public.company_industry USING btree (company_id);


--
-- Name: idx_company_industry_industry_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_company_industry_industry_id ON public.company_industry USING btree (industry_id);


--
-- Name: idx_company_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_company_name ON public.company USING btree (company_name);


--
-- Name: idx_compensation_salary; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_compensation_salary ON public.compensation_package USING btree (min_salary, max_salary);


--
-- Name: idx_function_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_function_name ON public.function USING btree (function_name);


--
-- Name: idx_industry_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_industry_name ON public.industry USING btree (industry_name);


--
-- Name: idx_job_company_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_job_company_id ON public.job USING btree (company_id);


--
-- Name: idx_job_compensation_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_job_compensation_id ON public.job USING btree (compensation_id);


--
-- Name: idx_job_function_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_job_function_id ON public.job USING btree (function_id);


--
-- Name: idx_job_is_active; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_job_is_active ON public.job USING btree (is_active);


--
-- Name: idx_job_location_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_job_location_id ON public.job USING btree (location_id);


--
-- Name: idx_job_posted_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_job_posted_date ON public.job USING btree (posted_date);


--
-- Name: idx_job_title; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_job_title ON public.job USING btree (title);


--
-- Name: idx_location_city_country; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_location_city_country ON public.location USING btree (city, country);


--
-- Name: idx_reviewer_company_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_reviewer_company_id ON public.reviewer USING btree (company_id);


--
-- Name: job trigger_set_closed_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trigger_set_closed_at BEFORE UPDATE ON public.job FOR EACH ROW WHEN (((old.is_active IS TRUE) AND (new.is_active IS FALSE))) EXECUTE FUNCTION public.set_closed_at_if_inactive();


--
-- Name: applies applies_job_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.applies
    ADD CONSTRAINT applies_job_id_fkey FOREIGN KEY (job_id) REFERENCES public.job(job_id) ON DELETE CASCADE;


--
-- Name: applies applies_reviewer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.applies
    ADD CONSTRAINT applies_reviewer_id_fkey FOREIGN KEY (reviewer_id) REFERENCES public.reviewer(reviewer_id) ON DELETE SET NULL;


--
-- Name: applies applies_user_id_resume_number_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.applies
    ADD CONSTRAINT applies_user_id_resume_number_fkey FOREIGN KEY (user_id, resume_number) REFERENCES public.resume(user_id, resume_number) ON DELETE CASCADE;


--
-- Name: company_industry company_industry_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.company_industry
    ADD CONSTRAINT company_industry_company_id_fkey FOREIGN KEY (company_id) REFERENCES public.company(company_id) ON DELETE CASCADE;


--
-- Name: company_industry company_industry_industry_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.company_industry
    ADD CONSTRAINT company_industry_industry_id_fkey FOREIGN KEY (industry_id) REFERENCES public.industry(industry_id) ON DELETE CASCADE;


--
-- Name: contract contract_job_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contract
    ADD CONSTRAINT contract_job_id_fkey FOREIGN KEY (job_id) REFERENCES public.job(job_id) ON DELETE CASCADE;


--
-- Name: freelance freelance_job_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.freelance
    ADD CONSTRAINT freelance_job_id_fkey FOREIGN KEY (job_id) REFERENCES public.job(job_id) ON DELETE CASCADE;


--
-- Name: full_time full_time_job_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.full_time
    ADD CONSTRAINT full_time_job_id_fkey FOREIGN KEY (job_id) REFERENCES public.job(job_id) ON DELETE CASCADE;


--
-- Name: internship internship_job_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.internship
    ADD CONSTRAINT internship_job_id_fkey FOREIGN KEY (job_id) REFERENCES public.job(job_id) ON DELETE CASCADE;


--
-- Name: job job_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job
    ADD CONSTRAINT job_company_id_fkey FOREIGN KEY (company_id) REFERENCES public.company(company_id) ON DELETE SET NULL;


--
-- Name: job job_compensation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job
    ADD CONSTRAINT job_compensation_id_fkey FOREIGN KEY (compensation_id) REFERENCES public.compensation_package(compensation_id) ON DELETE SET NULL;


--
-- Name: job_description job_description_job_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_description
    ADD CONSTRAINT job_description_job_id_fkey FOREIGN KEY (job_id) REFERENCES public.job(job_id) ON DELETE CASCADE;


--
-- Name: job job_function_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job
    ADD CONSTRAINT job_function_id_fkey FOREIGN KEY (function_id) REFERENCES public.function(function_id) ON DELETE SET NULL;


--
-- Name: job job_location_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job
    ADD CONSTRAINT job_location_id_fkey FOREIGN KEY (location_id) REFERENCES public.location(location_id) ON DELETE SET NULL;


--
-- Name: part_time part_time_job_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.part_time
    ADD CONSTRAINT part_time_job_id_fkey FOREIGN KEY (job_id) REFERENCES public.job(job_id) ON DELETE CASCADE;


--
-- Name: resume_skill resume_skill_user_id_resume_number_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resume_skill
    ADD CONSTRAINT resume_skill_user_id_resume_number_fkey FOREIGN KEY (user_id, resume_number) REFERENCES public.resume(user_id, resume_number) ON DELETE CASCADE;


--
-- Name: resume resume_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resume
    ADD CONSTRAINT resume_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(user_id) ON DELETE CASCADE;


--
-- Name: reviewer reviewer_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviewer
    ADD CONSTRAINT reviewer_company_id_fkey FOREIGN KEY (company_id) REFERENCES public.company(company_id) ON DELETE SET NULL;


--
-- PostgreSQL database dump complete
--

