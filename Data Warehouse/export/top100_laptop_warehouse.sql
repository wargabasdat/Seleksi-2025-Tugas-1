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
-- Name: dim_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dim_config (
    config_id integer NOT NULL,
    ram_size integer,
    storage_size integer,
    operating_system text
);


ALTER TABLE public.dim_config OWNER TO postgres;

--
-- Name: dim_cpu; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dim_cpu (
    cpu_id integer NOT NULL,
    cpu_name character varying(100),
    cpu_rank integer
);


ALTER TABLE public.dim_cpu OWNER TO postgres;

--
-- Name: dim_gpu; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dim_gpu (
    gpu_id integer NOT NULL,
    gpu_name character varying(100),
    gpu_rank integer
);


ALTER TABLE public.dim_gpu OWNER TO postgres;

--
-- Name: dim_laptop; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dim_laptop (
    laptop_id integer NOT NULL,
    laptop_name character varying(50),
    start_price numeric(10,2)
);


ALTER TABLE public.dim_laptop OWNER TO postgres;

--
-- Name: fact_laptop_performance; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fact_laptop_performance (
    laptop_id integer NOT NULL,
    cpu_id integer NOT NULL,
    gpu_id integer NOT NULL,
    config_id integer NOT NULL,
    color_score character varying(20),
    brightness_score character varying(20),
    contrast_score character varying(20),
    dci_p3_score character varying(20),
    eye_safety_score character varying(20),
    cpu_benchmark_score integer,
    total_score character varying(20),
    laptop_ranking integer
);


ALTER TABLE public.fact_laptop_performance OWNER TO postgres;

--
-- Data for Name: dim_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dim_config (config_id, ram_size, storage_size, operating_system) FROM stdin;
43792	24	512	macOS
18854	24	512	macOS
60157	24	512	macOS
38885	24	512	macOS
98724	24	1000	macOS
40137	24	1000	macOS
51383	24	1000	macOS
64057	24	1000	macOS
56281	48	512	macOS
77699	48	1000	macOS
80208	48	1000	macOS
11274	36	1000	macOS
44517	36	1000	macOS
42539	36	1000	macOS
47655	36	1000	macOS
22190	128	1000	macOS
62288	24	512	macOS
98302	24	512	macOS
54825	24	512	macOS
19965	24	1000	macOS
82686	24	512	macOS
33394	48	512	macOS
72463	24	1000	macOS
51139	48	512	macOS
56338	24	1024	macOS
38647	48	512	macOS
85197	48	512	macOS
45268	48	1000	macOS
33957	48	1000	macOS
99536	48	2000	macOS
34925	36	1000	macOS
75404	48	1000	macOS
36170	48	1000	macOS
40783	36	1000	macOS
41726	48	1000	macOS
44787	48	1000	macOS
40042	64	1000	macOS
36577	64	1000	macOS
42728	64	1000	macOS
91080	64	2000	macOS
56665	64	2000	macOS
30446	64	2000	Chrome OS
23983	64	2000	macOS
25712	128	1000	macOS
20287	48	4000	macOS
98580	128	1000	macOS
96956	128	2000	macOS
74574	128	4000	macOS
90455	16	512	Windows 11 Pro
10868	32	1000	Windows 11 Home
80972	32	1000	Windows 11 Pro
15539	16	512	Windows 11 Pro
73214	32	1000	Windows 10 Pro
58653	32	2000	Windows 10 Pro
91352	16	512	Windows 10 Pro
51342	64	1000	Windows 11 Pro
74532	32	1000	Windows 11 Pro
85303	32	1000	Windows 11 Pro
46009	32	1000	Windows 11 Pro
74330	64	1000	Windows 11 Pro
76995	32	1000	Windows 10 Pro
46735	64	2000	Windows 11 Pro
62150	64	4000	Windows 11 Pro
39110	32	2000	Windows 10 Pro
99201	\N	\N	macOS Sonoma
85584	64	4000	Windows 11 Pro
26809	96	4000	Windows 10 Pro
17097	32	1000	Windows 11 Pro
78909	16	1000	Windows 11 Pro
65466	32	2000	Windows 11 Pro
72694	36	2000	macOS
80879	18	512	macOS
14268	36	1000	macOS
75860	36	1000	macOS
55519	48	1000	macOS
61605	64	1000	macOS
99959	48	1000	macOS
32911	64	1000	macOS
69925	36	4000	macOS
25776	96	2000	macOS
77922	96	4000	macOS
70302	16	512	Windows 11 Pro
51373	16	512	Windows 11 Pro
11103	32	512	Windows 11 Pro
11549	16	512	Windows 11 Pro
98356	16	512	Windows 10 Pro
37623	16	512	Windows 11 Pro
59732	32	1000	Windows 11
86153	16	1000	Windows 11 Pro
23205	16	512	Windows 11 Pro
52655	32	1000	Windows 11 Pro
57395	32	1000	Windows 10 Pro
90318	32	1000	Windows 11 Pro
44039	16	2000	Windows 10 Pro
81901	16	512	Windows 11 Pro
44452	32	1024	Windows 11 Pro
41082	16	1000	Windows 11 Pro
45311	48	1000	Windows 11 Pro
71780	48	1000	Windows 11 Pro
90358	32	2000	Windows 11 Pro
54970	64	1000	Windows 11 Pro
57962	64	2000	Windows 11 Pro
34105	16	512	Windows 11 Pro
75374	32	1000	Windows 11 Pro
65567	16	1000	Windows 11 Pro
99202	\N	\N	Windows 11 Pro
37594	64	2000	Windows 11 Pro
64931	32	2048	Windows 11 Pro
58799	64	4000	Windows 11 Pro
57851	64	2000	Windows 11 Pro
62506	32	4000	Windows 11 Pro
46651	96	2000	Windows 11 Pro
69077	96	4000	Windows 11 Pro
33578	96	4000	Windows 11 Pro
84895	32	512	Windows 11 Pro
27188	64	4000	Windows 11 Pro
85483	64	4000	Windows 11 Pro
99916	16	512	Windows 11 Pro
39958	4	512	Windows 10 Pro
23090	32	512	Windows 11 Pro
40907	16	512	Windows 11 Pro
82789	32	1000	Windows 11 Pro
66651	128	2000	Windows 11 Pro
59923	32	512	Windows 11 Pro
35698	32	1024	Windows 11 Pro
29116	32	1000	Windows 11 Pro
29601	32	2048	Windows 11 Pro
71995	32	1000	Windows 11 Pro
11276	128	4000	Windows 11 Pro
33148	32	1000	Windows 11 Pro
65249	64	2000	Windows 11 Pro
75483	64	1000	Windows 11 Pro
27625	32	1000	Windows 11 Pro
92660	96	2000	Windows 11 Pro
77765	64	2000	Windows 11 Pro
79990	32	512	Windows 11 Pro
73782	16	512	Windows 11 Home
49326	16	1000	Windows 11 Home
42895	16	1000	Windows 11 Home
83680	32	1000	Windows 11 Home
84427	16	1000	Windows 11 Home
16253	32	2000	Windows 11 Pro
62219	32	1000	Windows 11 Home
22972	64	4000	Windows 11 Pro
31409	32	1000	Windows 11 Home
95179	16	1000	Windows 11 Pro
17869	32	2000	Windows 11 Home
38241	64	2000	Windows 11 Pro
72460	64	1000	Windows 11 Pro
92557	32	2000	Windows 11 Pro
68963	64	1000	Windows 11 Pro
53864	64	2000	Windows 11 Pro
44048	64	4000	Windows 11 Pro
57312	64	4000	Windows 11 Pro
57226	64	2000	Windows 11 Pro
83446	64	2000	Windows 11 Pro
83071	64	4000	Windows 11 Pro
43779	64	8000	Windows 11 Pro
55107	64	8000	Windows 11 Pro
12599	64	8000	Windows 11 Pro
63970	32	2000	Windows 11 Pro
25890	64	4000	Windows 11 Pro
56018	64	8000	Windows 11 Pro
99074	16	1000	Windows 11 Home
89374	16	1000	Windows 11
36077	32	1000	Windows 11 Home
85609	16	2000	Windows 11 Home
95082	32	1000	Windows 11 Home
80574	32	1000	Windows 11 Home
32877	32	1000	Windows 11 Pro
47304	32	2000	Windows 11 Pro
56544	32	2000	Windows 11 Home
52610	32	2000	Windows 11 Pro
98236	32	4000	Windows 11 Pro
76904	32	4000	Windows 11 Pro
73896	16	8000	Windows 11 Home
68580	32	4000	Windows 11 Home
20277	32	4000	Windows 11 Pro
59947	32	1000	Windows 10 Pro
90434	32	1000	Windows 11 Pro
47555	32	1000	Windows 11 Home
70784	16	1000	Windows 11 Pro
92799	16	1000	Windows 11 Pro
28985	16	1000	Windows 11 Home
31964	16	1000	Windows 11 Home
93962	16	2000	Windows 11 Pro
54222	16	2000	Windows 11 Home
65288	16	2000	Windows 11 Pro
92742	16	1000	Windows 11 Pro
90256	16	4000	Windows 11 Home
84925	16	2000	Windows 11 Home
63054	32	2000	Windows 11 Home
19351	32	2000	Windows 11 Home
20369	32	2000	Windows 11 Pro
31233	32	4000	Windows 11 Home
55039	32	4000	Windows 11 Pro
39912	32	4000	Windows 11 Home
51088	16	1000	Windows 11 Pro
51533	16	1000	Windows 11 Home
95591	16	512	Windows 11 Home
48188	16	512	Windows 11 Pro
89349	16	512	Windows 11 Home
94494	16	512	Windows 11 Pro
61833	16	1000	Windows 11 Home
45553	16	1000	Windows 11 Home
68313	16	1000	Windows 11 Pro
57600	16	2000	Windows 11 Home
86928	16	2000	Windows 11 Pro
78280	16	1000	Windows 11 Pro
69020	16	2000	Windows 11 Pro
31930	16	2000	Windows 11 Pro
34102	16	2000	Windows 11 Pro
13027	16	4000	Windows 11 Home
26389	16	4000	Windows 11 Pro
40753	16	512	Windows 11 Pro
42983	16	512	Windows 11 Pro
37600	16	512	Windows 11 Pro
31877	32	512	Windows 11 Pro
62041	32	1000	Windows 11 Pro
23501	32	512	Windows 11 Pro
22524	32	512	Windows 11 Pro
18361	32	1000	Windows 11 Pro
81884	32	2000	Windows 11 Pro
17055	64	4000	Windows 11 Pro
13455	32	2000	Windows 11 Pro
62037	64	2000	Windows 11 Pro
78679	64	2000	Windows 11 Pro
20911	64	4000	Windows 11 Pro
23622	64	4000	Windows 11 Pro
44400	64	8000	Windows 11 Pro
91015	24	512	macOS
30352	8	512	macOS
21050	8	512	macOS
95830	8	512	macOS
61097	8	512	macOS
50549	24	512	macOS
99203	\N	\N	Windows 11 Home
40062	8	256	macOS
42426	16	256	macOS
47247	16	256	macOS
68085	24	512	macOS
92114	24	512	macOS
26569	24	512	macOS
27206	16	512	macOS
79041	16	512	macOS
32361	32	2000	Windows 11 Pro
13744	32	2000	Windows 11 Pro
14607	64	2000	Windows 11 Pro
96972	32	4000	Windows 11 Pro
56771	64	2000	Windows 11 Pro
52624	64	2000	Windows 11 Pro
72410	64	2000	Windows 11 Pro
71235	64	4000	Windows 11 Pro
45705	64	4000	Windows 11 Pro
81898	64	4000	Windows 11 Pro
68306	32	2000	Windows 11 Pro
27709	64	8000	Windows 11 Pro
73225	16	1000	Windows 11 Home
33204	64	8000	Windows 11 Pro
87441	64	8000	Windows 11 Pro
88326	64	8000	Windows 11 Pro
69840	32	2000	Windows 11 Pro
92712	64	8000	Windows 11 Pro
93342	64	2000	Windows 11 Pro
83922	64	2000	Windows 11 Pro
67013	64	4000	Windows 11 Pro
78610	64	4000	Windows 11 Pro
93858	64	8000	Windows 11 Pro
93824	64	8000	Windows 11 Pro
79964	16	512	Windows 11 Pro
50587	16	512	Windows 11 Pro
55504	16	512	Windows 11 Pro
73131	16	512	Windows 11 Pro
80735	16	512	Windows 11 Pro
39770	16	512	Windows 10 Pro
21738	16	512	Windows 11 Pro
67915	16	1000	Windows 11 Pro
50352	16	512	Windows 11 Pro
64028	16	1000	Windows 11 Pro
44053	16	512	Windows 11 Pro
30410	32	1000	Windows 10 Pro
49789	32	1000	Windows 11 Pro
11383	32	1000	Windows 11 Pro
10012	16	512	Windows 10 Pro
78592	16	512	Windows 11 Pro
27865	16	512	Windows 11 Pro
55073	16	512	Windows 10 Pro
47586	32	2000	Windows 11 Pro
71498	16	1000	Windows 11 Pro
80136	16	1000	Windows 10 Pro
11090	24	1000	Windows 11 Pro
74478	32	1000	Windows 10 Pro
72530	32	1000	Windows 11 Pro
49270	32	1000	Windows 11 Pro
11197	32	1000	Windows 11 Pro
66418	32	1000	Windows 11 Pro
48393	24	2000	Windows 10 Pro
88250	24	2000	Windows 11 Pro
40305	48	1000	Windows 11 Pro
10946	16	512	Windows 10 Pro
81855	16	512	Windows 11 Pro
58974	48	1000	Windows 11 Pro
34716	32	2000	Windows 11 Pro
63967	32	2000	Windows 11 Pro
83472	32	2000	Windows 11 Pro
67292	32	2000	Windows 11 Pro
61740	16	1000	Windows 11 Pro
42754	64	2000	Windows 11 Pro
31400	32	1000	Windows 11 Pro
94671	32	512	Windows 10 Pro
61081	24	1000	Windows 11 Pro
59592	32	1000	Windows 10 Pro
38913	32	1000	Windows 11 Pro
44469	32	1000	Windows 10 Pro
20382	16	2000	Windows 10 Pro
65343	16	2000	Windows 11 Pro
91962	48	1000	Windows 11 Pro
41399	32	4000	Windows 10 Pro
77713	64	4000	Windows 10 Pro
90375	40	1000	Windows 10 Pro
99737	64	2000	Windows 11 Pro
45633	24	2000	Windows 11 Pro
47313	64	2000	Windows 10 Pro
94994	48	1000	Windows 10 Pro
79722	48	1000	Windows 11 Pro
45235	48	1000	Windows 11 Pro
64120	48	1000	Windows 10 Pro
34641	32	2000	Windows 10 Pro
18973	32	2000	Windows 11 Pro
33908	32	2000	Windows 10 Pro
27907	48	4000	Windows 10 Pro
47957	48	2000	Windows 11 Pro
24464	64	1000	Windows 11 Pro
93478	64	1000	Windows 10 Pro
90967	48	2000	Windows 11 Pro
69345	48	2000	Windows 11 Pro
45669	48	2000	Windows 10 Pro
91625	64	4000	Windows 10 Pro
74486	64	4000	Windows 11 Pro
34613	64	4000	Windows 11 Pro
52027	32	4000	Windows 11 Pro
12542	32	4000	Windows 10 Pro
29942	64	2000	Windows 11 Pro
80119	64	2000	Windows 10 Pro
12900	64	2000	Windows 11 Pro
34371	48	4000	Windows 11 Pro
23405	48	4000	Windows 10 Pro
46977	64	4000	Windows 10 Pro
45283	64	4000	Windows 11 Pro
67464	64	4000	Windows 11 Home
11075	48	4000	Windows 11 Pro
40514	64	4000	Windows 10 Pro
21822	64	4000	Windows 10 Pro
29750	64	4000	Windows 10 Pro
11930	24	2000	Windows 10 Pro
74694	16	1000	Windows 11 Home
38467	16	1000	Windows 11 Home
54815	16	1000	Windows 11 Home
65082	16	1000	Windows 11 Home
50838	16	1000	Windows 11 Home
75325	16	1000	Windows 11 Home
58679	16	1000	Windows 11 Home
70776	16	1000	Windows 11 Home
53286	16	1000	Windows 11 Home
20515	16	1000	Windows 11 Home
29148	16	1000	Windows 11 Home
17345	16	1000	Windows 11 Home
44931	32	4000	Windows 11 Pro
61435	32	1000	Windows 11 Home
19356	32	1000	Windows 11 Home
71623	16	1000	Windows 11 Home
33803	32	1000	Windows 11 Home
35191	32	1000	Windows 11 Home
42778	32	1000	Windows 11 Home
11653	32	2000	Windows 11 Pro
25985	64	4000	Windows 11 Pro
42631	32	2000	Chrome OS
60436	32	2000	Windows 11 Pro
68059	32	2000	Windows 11 Home
42396	32	2000	Windows 11 Pro
14392	64	4000	Windows 11 Home
36106	64	2000	Windows 11 Pro
70402	8	512	macOS
22315	16	256	macOS
78306	8	256	macOS
97294	8	512	macOS
37321	8	512	macOS
71974	16	512	macOS
61003	24	512	macOS
99318	8	512	macOS
50908	16	512	macOS
52344	16	1000	Windows 11 Pro
30789	16	1000	Windows 11 Home
92465	8	1000	Windows 11 Pro
15529	16	512	Windows 10 Home
82034	16	1024	Windows 11 Home
78278	16	1000	Windows 11 Home
26009	32	1024	Windows 11 Home
73075	16	2000	Windows 11 Home
93692	32	4000	Windows 10 Pro
49166	64	2000	Windows 11 Home
36047	64	4000	Windows 11 Home
57241	32	2000	Windows 11 Home
16827	32	2000	Windows 11 Home
97385	32	2000	Windows 11 Home
38545	16	1000	Windows 11 Home
24801	64	2000	Windows 11 Home
40928	64	2000	Windows 10 Home
92956	64	2000	Windows 11 Home
66906	64	4000	Windows 11 Home
52534	64	1000	Windows 11 Home
11974	32	1000	Windows 11 Home
31936	16	1000	Windows 11 Pro
46188	16	1000	Windows 11 Pro
86637	16	2000	Windows 11 Pro
25682	16	512	Windows 11 Home
41862	32	1000	Windows 11 Pro
11170	32	1000	Windows 11 Home
15504	16	1000	Windows 11 Home
86162	64	2000	Windows 11 Pro
72294	64	2000	Windows 11 Home
88146	64	4000	Windows 11 Pro
30315	32	2000	Windows 11 Pro
21728	32	2000	Windows 11 Home
42600	64	1000	Windows 11 Home
30669	64	1000	Windows 11 Pro
75525	32	2000	Windows 11 Pro
21980	32	2000	Windows 11 Pro
99908	64	4000	Windows 11 Pro
91087	64	2000	Windows 11 Pro
54357	64	1000	Windows 11 Pro
91937	64	2000	Windows 11 Pro
17871	64	1000	Windows 11 Home
17834	64	4000	Windows 11 Pro
56598	64	4000	Windows 11 Pro
94485	32	4000	Windows 11 Pro
30174	64	4000	Windows 11 Pro
80300	64	2000	Windows 11 Pro
24076	64	8000	Windows 11 Pro
26492	64	4000	Windows 11 Pro
73942	64	8000	Windows 11 Pro
40497	64	4000	Windows 11 Home
51515	16	512	Windows 11 Pro
83184	32	1000	Windows 11 Pro
94495	32	1000	Windows 11 Home
55523	32	2000	Windows 11 Pro
67503	32	1000	Windows 11 Pro
35292	64	4000	Windows 11 Pro
12798	64	6000	Windows 11 Pro
59514	96	6000	Windows 11 Pro
56945	64	16000	Windows 11 Pro
27659	64	16000	Windows 11 Pro
42859	64	1000	Windows 11 Pro
15175	32	1000	Windows 11 Pro
73609	64	2000	Windows 11 Pro
67344	64	2000	Windows 11 Pro
83272	64	4000	Windows 11 Home
48628	64	4000	Windows 11 Pro
81137	64	4000	Windows 11 Pro
74237	32	2000	Windows 11 Pro
34874	64	1000	Windows 11 Pro
84278	64	4000	Windows 11 Pro
34461	64	4000	Windows 11 Pro
81253	32	1000	Windows 11 Pro
55569	64	1000	Windows 11 Pro
52425	32	2000	Windows 11 Pro
71393	96	2000	Windows 11 Pro
46087	32	2000	Windows 11 Pro
88470	64	2000	Windows 11 Pro
82682	32	2000	Windows 11 Pro
31016	64	1000	Windows 11 Pro
19027	64	2048	Windows 11 Pro
79617	64	3000	Windows 11 Pro
30319	32	4000	Windows 11 Pro
68901	96	2000	Windows 11 Pro
48754	96	2000	Windows 11 Pro
80989	64	4000	Windows 11 Pro
58118	64	4000	Windows 11 Pro
69517	96	3000	Windows 11 Pro
10094	96	4000	Windows 11 Pro
93627	32	2000	Windows 11 Pro
76316	64	8000	Windows 11 Pro
59681	64	10000	Windows 11 Pro
34318	64	10000	Windows 11 Pro
12453	96	10000	Windows 11 Pro
91229	96	10000	Windows 11 Pro
57720	64	16000	Windows 11 Pro
91290	96	16000	Windows 11 Pro
41298	64	16000	Windows 11 Pro
52034	96	16000	Windows 11 Pro
18302	32	1000	Windows 11 Home
96283	32	1000	Windows 11 Pro
80642	32	2000	Windows 11 Pro
60789	32	2000	Windows 11 Home
34886	64	2000	Windows 11 Pro
99551	64	2000	Windows 11 Home
75214	16	1000	Windows 11 Home
82281	16	1000	Windows 11 Pro
30202	64	1000	Windows 11 Pro
90352	64	2000	Windows 11 Pro
47110	16	1000	Windows 11 Home
52283	16	1000	Windows 10 Pro
63713	16	1000	Windows 11 Home
94004	8	256	Windows 11 Home
52208	16	512	Windows 10 Home
24478	16	512	Windows 10 Pro
22616	16	2000	Windows 11 Home
78576	16	4000	Windows 11 Home
96362	32	1000	Windows 11 Home
18739	32	1000	Windows 11 Pro
15737	64	4000	Windows 11 Pro
33414	32	1000	Windows 11 Pro
14099	64	2000	Windows 11 Pro
36486	32	1000	Windows 11 Pro
24031	64	1000	Windows 11 Pro
73618	64	1000	Windows 10 Pro
35115	64	2000	Windows 11 Pro
22943	64	4000	Windows 11 Pro
14170	16	1000	Windows 11 Home
84843	16	2000	Windows 11 Home
94115	16	1000	Windows 11 Home
60934	64	1000	Windows 11 Home
96235	64	2000	Windows 11 Home
74213	16	1024	Windows 11 Home
78920	16	1000	Windows 10 Home
91785	32	1000	Windows 11 Home
87371	32	2000	Windows 11 Pro
43546	16	1000	Windows 10 Home
16433	24	1000	Windows 10 Home
58018	64	1000	Windows 11 Home
38930	32	1000	Windows 11 Home
89423	16	1000	Windows 10 Home
19289	16	1000	Windows 11 Home
11715	16	1000	Windows 11 Home
37359	16	1000	Windows 10 Home
95950	16	1000	Windows 10 Home
74409	16	1000	Windows 11 Home
20480	16	2000	Windows 10 Home
71349	32	1000	Windows 11 Home
93744	32	1000	Windows 10 Pro
17956	24	1000	Windows 10 Pro
57307	32	1000	Windows 10 Pro
83140	24	1000	Windows 11 Home
64519	24	1000	Windows 10 Home
17641	16	1000	Windows 11 Pro
90862	16	1000	Windows 10 Pro
44840	16	1000	Windows 10 Pro
79339	16	1000	Windows 10 Pro
15328	16	1000	Windows 11 Pro
19225	16	1000	Windows 11
49833	16	1000	Windows 11 Home
38298	16	1000	Windows 10 Home
78089	32	1000	Windows 11 Home
22729	16	2000	Windows 10 Pro
23267	24	2000	Windows 10 Home
40279	24	2000	Windows 11 Home
79685	24	2000	Windows 11 Home
60506	24	1000	Windows 11 Pro
34832	24	1000	Windows 10 Pro
35312	32	1000	Windows 11 Home
78969	32	1000	Windows 10 Home
96098	16	1000	Windows 10 Pro
42605	16	1000	Windows 11 Pro
84714	16	1000	Windows 10 Pro
33448	24	2000	Windows 11 Pro
83193	32	2000	Windows 10 Home
83156	24	2000	Windows 10 Pro
64419	32	1000	Windows 11 Home
23829	32	1000	Windows 10 Home
93705	32	1000	Windows 11 Pro
85571	32	1000	Windows 10 Pro
56918	32	2000	Windows 10 Home
98407	32	2000	Windows 11 Pro
70125	16	4000	Windows 11 Home
97194	32	2000	Windows 11 Pro
65977	32	1000	Windows 10 Pro
23644	32	1000	Windows 11 Pro
31864	16	2000	Windows 11
33644	16	2000	Windows 10 Home
82085	16	2000	Windows 11 Home
62632	16	2000	Windows 10 Home
76151	16	2000	Windows 11 Home
54238	16	2000	Windows 10 Home
96184	16	1000	\N
30732	16	1000	Windows 10 Home
88632	48	2000	Windows 11 Home
68066	48	2000	Windows 10 Home
51307	48	2000	Windows 11 Home
82100	32	2000	Windows 11 Home
52553	32	2000	Windows 10 Home
58722	24	2000	Windows 11 Home
66438	16	2000	Windows 11 Pro
52395	24	2000	Windows 11 Home
89745	24	2000	Windows 10 Home
41551	16	2000	Windows 11 Pro
83812	16	2000	Windows 10 Pro
38039	48	1000	Windows 10 Home
59160	48	1000	Windows 11 Home
82120	32	1000	Windows 11 Pro
43303	16	2000	Windows 11 Home
57187	48	2000	Windows 11 Pro
69297	32	2000	Windows 11 Pro
68654	32	2000	Windows 10 Pro
62047	24	2000	Windows 11 Pro
10025	24	2000	Windows 10 Pro
14543	16	2000	Windows 11 Home
47287	32	4000	Windows 11 Home
88087	32	2000	Windows 11 Home
12136	32	2000	Windows 10 Home
77844	48	1000	Windows 11 Pro
27705	48	1000	Windows 10 Pro
49562	48	2000	Windows 11 Pro
10860	48	2000	Windows 11 Home
49365	48	2000	Windows 10 Home
39083	64	2000	Windows 10 Home
38157	64	2000	Windows 11 Home
51275	32	4000	Windows 11 Pro
12844	32	2000	Windows 11 Pro
82569	32	2000	Windows 10 Pro
77013	64	1000	Windows 10 Home
82918	16	4000	Windows 10 Home
84922	16	4000	Windows 11 Home
30278	64	2000	Windows 11 Pro
22358	48	2000	Windows 10 Pro
14946	48	2048	Windows 10 Home
70341	64	2000	Windows 11 Pro
56616	64	2000	Windows 11 Home
30461	64	2000	Windows 10 Home
28141	64	2000	Windows 11 Home
44732	16	1000	Windows 11 Pro
58114	16	2000	Windows 11 Pro
86304	16	1000	Windows 11 Home
42749	48	2000	Windows 11 Home
49361	16	2000	Windows 11 Pro
22046	16	4000	Windows 10 Pro
84774	16	4000	Windows 11 Pro
62402	16	2000	Windows 11 Home
84588	64	2000	Windows 10 Pro
38499	48	4000	Windows 10 Pro
20118	48	4000	Windows 11 Home
52558	48	2000	Windows 11 Pro
73246	16	1024	Windows 11 Pro
32662	32	4000	Windows 10 Home
73999	64	2000	Windows 10 Pro
85527	48	4000	Windows 10 Pro
88018	64	4000	Windows 11 Home
94181	64	4000	Windows 10 Home
49373	48	4000	Windows 10 Pro
14898	64	4000	Windows 11 Pro
60010	64	4000	Windows 11 Home
20286	64	4000	Windows 10 Pro
17329	64	4000	Windows 10 Home
53829	16	2000	Windows 11 Home
66925	32	4000	Windows 10 Pro
64594	32	4000	Windows 11 Pro
25799	16	2000	Windows 11 Home
39716	32	1000	Windows 11 Home
95561	32	2000	Windows 11 Home
88944	16	2000	Windows 11 Pro
93084	16	2000	Windows 11 Pro
92862	64	2000	Windows 11 Home
60133	64	2000	Windows 10 Home
17094	32	2000	Windows 11 Home
49948	64	4000	Windows 10 Home
78731	64	4000	Windows 10 Pro
15397	64	4000	Windows 11 Pro
80769	16	1000	Windows 11 Home
84044	48	4000	Windows 11 Home
29605	16	1024	Windows 11 Pro
52838	64	2048	Windows 11 Pro
75850	64	2000	Windows 11 Pro
38940	64	2000	Windows 10 Pro
30079	64	4000	Windows 11 Pro
16621	48	4000	Windows 11 Pro
98294	48	4000	Windows 10 Pro
61495	16	2000	Windows 11 Pro
68407	16	4000	Windows 11 Home
88005	32	1000	Windows 11 Pro
85399	32	2000	Windows 11 Home
76155	64	4000	Windows 11 Home
39109	64	4000	Windows 10 Home
66614	32	2000	Windows 11 Pro
47982	32	2000	Windows 11 Home
61684	64	4000	Windows 11 Pro
29400	16	4000	Windows 11 Pro
27326	48	8000	Windows 10 Home
54062	48	8000	Windows 10 Home
20819	64	4000	Windows 11 Home
72371	64	4000	Windows 10 Home
84899	16	4000	Windows 11 Pro
16463	48	8000	Windows 11 Pro
81847	48	8000	Windows 10 Pro
62322	64	4000	Windows 10 Pro
44413	64	4000	Windows 11 Pro
21151	32	2000	Windows 11 Pro
62235	64	8000	Windows 10 Home
66949	32	1000	Windows 11 Pro
27088	16	4000	Windows 11 Home
27677	32	2000	Windows 11 Pro
73035	16	4000	Windows 11 Pro
83308	64	8000	Windows 10 Pro
35966	32	4000	Windows 11 Home
61815	64	8000	Windows 10 Pro
95491	32	4000	Windows 11 Pro
84885	32	4000	Windows 11 Home
35703	32	4000	Windows 11 Home
83553	64	2000	Windows 11 Home
90739	64	2000	Windows 11 Home
78714	32	4000	Windows 11 Home
42275	64	1000	Windows 11 Home
41760	32	4000	Windows 11 Pro
19390	32	4000	Windows 11 Pro
44898	64	2000	Windows 11 Pro
66369	64	2000	Windows 11 Pro
52390	64	2000	Windows 11 Home
99749	64	2000	Windows 11 Pro
85499	64	4000	Windows 11 Home
21743	64	2000	Windows 11 Pro
24749	64	2000	Windows 11 Pro
65974	16	256	macOS
98047	64	4000	Windows 11 Home
64209	64	4000	Windows 11 Pro
65514	64	4000	Windows 11 Pro
57876	64	4000	Windows 11 Pro
55653	64	4000	Windows 11 Home
34967	64	4000	Windows 11 Pro
52039	64	4000	Windows 11 Pro
55157	64	1000	Windows 11 Pro
87840	64	4000	Windows 11 Pro
95905	24	1000	Windows 10 Pro
13172	48	2000	Windows 10 Home
49953	32	2000	Windows 10 Home
32184	32	2000	Windows 10 Pro
55838	32	4000	Windows 10 Home
90769	32	4000	Windows 10 Pro
91681	48	2000	Windows 11 Pro
29112	48	4000	Windows 11 Pro
67732	64	2000	Windows 10 Home
15882	64	2000	Windows 11 Home
40603	64	4000	Windows 11 Home
36173	16	1000	Windows 11 Home
99831	32	1000	Windows 11 Home
58997	32	1000	Windows 11 Home
21247	32	4000	Windows 11 Home
24728	16	512	Windows 11 Pro
17148	32	1000	Windows 11 Pro
41856	64	1000	Windows 11 Pro
91396	16	512	Windows 11 Pro
29356	64	2000	Windows 11 Pro
47707	32	1000	Windows 10 Pro
11800	16	512	Windows 10 Pro
54993	16	512	Windows 11 Pro
24585	32	1000	Windows 11 Pro
49992	16	512	Windows 11 Pro
68990	16	512	Windows 10 Pro
71759	16	512	Windows 11 Pro
12981	16	512	Windows 10 Pro
53499	16	512	Windows 11 Pro
37395	16	512	Windows 11 Pro
80517	16	512	Windows 10 Pro
37770	16	1000	Windows 11 Pro
36712	16	1000	Windows 10 Pro
81620	16	1000	Windows 11 Pro
78585	32	1000	Windows 10 Pro
73311	32	1000	Windows 11 Pro
91663	24	1000	Windows 10 Pro
28526	16	1000	Windows 10 Pro
97590	24	1000	Windows 11 Pro
12410	24	1000	Windows 11 Pro
59362	24	1000	Windows 10 Pro
86415	24	1000	Windows 10 Pro
96969	24	1000	Windows 11 Pro
79048	24	1000	Windows 10 Pro
15699	24	1000	Windows 11 Pro
43483	24	1000	Windows 11 Pro
32324	24	1000	Windows 10 Pro
17878	32	1000	Windows 10 Pro
47226	32	1000	Windows 11 Pro
36305	32	1000	Windows 11 Pro
90997	32	1000	Windows 10 Pro
45557	16	2000	Windows 10 Pro
16957	32	1000	Windows 10 Pro
70943	32	1000	Windows 11 Pro
95820	32	1000	Windows 10 Pro
11092	32	1000	Windows 11 Pro
18729	16	2000	Windows 10 Pro
96556	16	2000	Windows 11 Pro
45561	32	1000	Windows 11 Pro
96898	16	2000	Windows 11 Pro
96520	16	2000	Windows 10 Pro
24141	24	2000	Windows 11 Pro
12500	24	2000	Windows 10 Pro
48337	24	2000	Windows 10 Pro
95119	24	2000	Windows 11 Pro
60662	24	2000	Windows 10 Pro
40299	24	2000	Windows 11 Pro
59899	24	2000	Windows 10 Pro
76655	24	2000	Windows 11 Pro
23055	32	2000	Windows 11 Pro
73525	24	2000	Windows 11 Pro
88263	32	2000	Windows 11 Pro
79672	32	2000	Windows 10 Pro
21537	32	1000	Windows 11 Pro
34434	32	2000	Windows 10 Pro
36066	32	2000	Windows 11 Pro
75621	32	2000	Windows 11 Pro
70029	32	2000	Windows 10 Pro
83490	32	512	Windows 11 Pro
12816	32	2000	Windows 10 Pro
15210	64	1000	Windows 11 Pro
49967	64	1000	Windows 10 Pro
53721	64	1000	Windows 11 Pro
74216	64	1000	Windows 11 Pro
61563	64	1000	Windows 11 Pro
30578	32	2000	Windows 11 Pro
12408	48	2000	Windows 10 Pro
55453	48	2000	Windows 11 Pro
99694	32	2048	Windows 10 Pro
56125	48	2000	Windows 10 Pro
56580	48	2000	Windows 11 Pro
91950	64	2000	Windows 10 Pro
49626	64	2000	Windows 10 Pro
40959	64	2000	Windows 11 Pro
75700	32	4000	Windows 10 Pro
46159	64	2048	Windows 10 Pro
18127	64	2000	Windows 11 Pro
92023	64	2000	Windows 10 Pro
43774	32	1024	Windows 11 Pro
60747	64	2000	Windows 10 Pro
13862	64	2000	Windows 11 Pro
82737	64	2048	Windows 11 Pro
46725	48	4000	Windows 11 Pro
29884	48	4000	Windows 10 Pro
54798	64	4000	Windows 11 Pro
61491	48	4000	Windows 11 Pro
96105	48	4000	Windows 10 Pro
27991	48	4000	Windows 11 Pro
21507	48	4000	Windows 10 Pro
60096	64	4000	Windows 11 Pro
78251	64	4000	Windows 11 Pro
98866	64	4000	Windows 10 Pro
90274	64	4000	Windows 10 Pro
91988	64	4000	Windows 11 Pro
99983	64	1000	Windows 11 Pro
39809	64	4000	Windows 10 Pro
64700	32	4000	Windows 11 Pro
41504	64	8000	Windows 11 Pro
85090	64	8000	Windows 11 Pro
30021	64	4000	Windows 10 Pro
65897	64	8000	Windows 10 Pro
50944	64	8000	Windows 11 Pro
89346	64	8000	Windows 10 Pro
53160	64	8000	Windows 11 Pro
68873	64	8000	Windows 11 Pro
81071	64	8000	Windows 10 Pro
27271	64	8000	Windows 10 Pro
37100	64	2000	Windows 11 Pro
95520	64	8000	Windows 10 Pro
28163	16	1000	Windows 11 Home
86156	64	2000	Windows 11 Pro
80956	16	1000	Windows 11 Home
99659	64	1000	Windows 11 Pro
36517	24	2000	Windows 10 Home
28102	32	2000	Windows 11 Pro
50501	64	2000	Windows 11 Pro
78656	48	8000	Windows 11 Pro
27727	64	2000	Windows 11 Pro
29025	24	1000	Windows 11 Pro
96013	24	512	Windows 11 Home
84035	24	1000	Windows 11 Home
30715	24	1000	Windows 11 Home
51614	32	1000	Windows 11 Home
18888	32	1000	Windows 11 Home
83051	32	1000	Windows 11 Home
79856	32	1000	Windows 11 Pro
25517	32	1000	Windows 11 Pro
34134	32	1000	Windows 11 Pro
51628	24	2000	Windows 11 Pro
29073	32	2000	Windows 11 Home
51771	32	2000	Windows 11 Home
64269	32	2000	Windows 11 Home
63903	32	2000	Windows 11 Pro
49760	32	2000	Windows 11 Pro
68065	32	2000	Windows 11 Pro
93472	24	4000	Windows 11 Pro
45887	32	2000	Windows 11 Home
29917	32	1000	Windows 11 Pro
34632	32	1000	Windows 11 Pro
23994	32	2000	Windows 11 Pro
27241	32	4000	Windows 11 Pro
34215	32	2000	Windows 11 Home
13433	32	4000	Windows 11 Home
90213	32	4000	Windows 11 Pro
90864	32	4000	Windows 11 Home
44978	32	4000	Windows 11 Pro
89377	32	4000	Windows 11 Home
84323	32	4000	Windows 11 Pro
90263	32	8000	Windows 11 Home
40266	32	8000	Windows 11 Pro
88166	32	8000	Windows 11 Home
40432	32	8000	Windows 11 Pro
13418	32	8000	Windows 11 Home
57089	32	8000	Windows 11 Pro
20417	16	1000	Windows 11 Home
72469	16	512	Windows 11 Home
75840	32	1000	Windows 11 Pro
89260	32	2000	Windows 11 Pro
71441	32	2000	Windows 11 Pro
95140	32	4000	Windows 11 Pro
34114	16	1000	Windows 11 Home
60785	16	512	Windows 11 Home
74414	16	1000	Windows 11 Home
72108	16	1000	Windows 11 Pro
28024	16	2000	Windows 11 Home
31467	16	2000	Windows 10 Pro
35330	16	2000	Windows 11 Pro
39658	64	8000	Windows 11 Pro
63554	16	512	Windows 11 Pro
11967	16	512	Windows 11 Pro
45370	16	256	Windows 11 Pro
64138	16	1000	Windows 11 Pro
39170	16	512	Windows 11 Pro
97993	32	1000	Windows 11 Pro
36585	32	2000	Windows 10 Pro
36812	32	1000	Windows 11 Pro
18668	32	1000	Windows 11 Pro
33209	64	1000	Windows 10 Pro
67577	64	2000	Windows 11 Pro
90879	32	1000	Windows 11 Pro
74217	32	1000	Windows 11 Pro
52584	32	1000	Windows 10 Pro
69971	16	512	Windows 10 Pro
42346	16	512	Windows 10 Pro
66040	64	1000	Windows 11 Pro
63066	32	1000	Windows 11 Pro
89682	32	1000	Windows 10 Pro
51012	32	1000	Windows 11 Pro
61662	32	1000	Windows 10 Pro
90151	64	1000	Windows 11 Pro
84964	24	1000	Windows 11 Home
80275	24	1000	Windows 10 Home
78843	16	1000	Windows 11 Pro
94068	32	2000	Windows 11 Pro
15047	32	2000	Windows 10 Pro
89802	8	256	macOS
78242	16	2000	Windows 11 Home
24328	32	2000	Windows 11 Pro
69193	32	1000	Windows 10 Pro
69886	32	1000	Windows 11 Pro
15559	32	1000	Windows 10 Pro
42207	32	1000	Windows 11 Pro
77987	32	2000	Windows 11 Pro
80499	32	2000	Windows 10 Pro
61853	48	2000	Windows 11 Pro
15144	48	2000	Windows 10 Pro
83098	24	2000	Windows 11 Home
60777	16	2000	Windows 10 Pro
77649	32	2000	Windows 11 Home
16461	32	2000	Windows 11 Pro
34884	32	2000	Windows 10 Pro
48165	64	4000	Windows 11 Pro
67613	64	2000	Windows 11 Pro
49918	64	2000	Windows 10 Pro
47475	32	2000	Windows 11 Pro
70469	32	2000	Windows 10 Pro
31821	48	2000	Windows 10 Home
51482	8	512	macOS
65372	48	2000	Windows 11 Home
48590	64	2000	Windows 11 Pro
90364	64	2000	Windows 10 Pro
17149	64	2000	Windows 11 Pro
77760	48	2000	Windows 11 Pro
70762	48	2000	Windows 10 Pro
94685	32	4000	Windows 11 Pro
69204	32	4000	Windows 10 Pro
21854	32	4000	Windows 11 Home
75622	32	4000	Windows 10 Home
24833	64	2000	Windows 11 Home
33562	64	2000	Windows 11 Pro
86735	64	2000	Windows 11 Pro
81618	32	4000	Windows 11 Pro
27734	32	4000	Windows 10 Pro
61520	64	4000	Windows 10 Pro
52396	48	3000	Windows 11 Pro
69098	64	2000	Windows 11 Pro
13265	64	2000	Windows 10 Pro
33445	64	2000	Windows 11 Pro
69464	64	2000	Windows 10 Pro
44034	8	512	macOS
87373	48	4000	Windows 11 Pro
36467	48	4000	Windows 11 Pro
69596	48	4000	Windows 10 Pro
21820	48	4000	Windows 11 Pro
52477	48	4000	Windows 10 Pro
95010	64	4000	Windows 11 Pro
31495	48	4000	Windows 10 Pro
26193	64	4000	Windows 11 Home
21952	64	4000	Windows 10 Home
24963	64	4000	Windows 11 Home
68903	64	4000	Windows 11 Pro
93109	64	4000	Windows 10 Pro
57571	64	4000	Windows 11 Pro
21181	64	4000	Windows 10 Pro
78657	16	256	No OS
60343	64	2000	Windows 11 Pro
77065	64	1000	Windows 11 Pro
90225	32	1000	Windows 11 Pro
30958	128	4000	Windows 11 Pro
59634	128	4000	Windows 10 Pro
82134	48	8000	Windows 11 Pro
85385	8	512	macOS
59886	48	8000	Windows 10 Pro
32398	64	8000	Windows 11 Pro
53934	32	1000	Windows 11 Pro
84120	128	4000	Windows 11 Pro
96445	128	4000	Windows 10 Pro
29672	64	8000	Windows 11 Pro
31249	64	8000	Windows 10 Pro
28953	128	4000	Windows 10 Pro
33444	128	4000	Windows 11 Home
16725	128	4000	Windows 11 Home
64995	128	4000	Windows 10 Pro
50378	128	4000	Windows 10 Pro
50569	128	4000	Windows 11 Pro
68491	128	4000	Windows 10 Pro
47851	128	4000	Windows 11 Pro
92110	128	8000	Windows 11 Pro
33684	128	8000	Windows 10 Pro
25408	128	8000	Windows 10 Pro
27245	128	8000	Windows 11 Pro
36588	128	8000	Windows 10 Pro
10463	128	8000	Windows 11 Pro
56380	8	256	macOS
91600	128	8000	Windows 11 Pro
43175	128	8000	Windows 10 Pro
11600	128	8000	Windows 11 Pro
70115	128	2000	Windows 11 Pro
75225	32	4000	Windows 11 Pro
75358	64	2000	Windows 11 Pro
81237	32	1000	Windows 11 Pro
10753	16	256	macOS
89689	16	256	macOS
74679	16	256	macOS
41179	16	256	macOS
38426	16	256	macOS
87183	16	256	macOS
96438	16	256	macOS
72352	16	256	macOS
69472	16	512	macOS
63759	16	512	macOS
67917	16	512	macOS
20407	16	512	macOS
88802	24	512	macOS
88656	16	512	macOS
10861	16	512	macOS
42075	16	512	macOS
81741	16	512	macOS
46452	24	512	macOS
91233	24	512	macOS
92396	24	512	macOS
83079	24	512	macOS
16411	24	512	macOS
34227	24	512	macOS
29432	16	1000	macOS
17217	16	1000	macOS
95626	24	1000	macOS
55746	32	512	macOS
14813	24	2000	macOS
29054	16	512	Windows 11 Pro
14250	16	512	Windows 10 Pro
97424	16	2000	Windows 11 Pro
85771	64	2000	Windows 11 Pro
89073	64	2000	Windows 11 Pro
53399	32	1000	Windows 10 Pro
21495	64	1024	Windows 11 Pro
16426	32	1000	Windows 11 Pro
24272	16	256	Windows 10 Pro
64651	16	512	Windows 10 Pro
33363	64	512	Windows 11 Pro
31146	32	512	Windows 10 Pro
98092	32	2000	Windows 11 Pro
47274	32	256	Windows 11 Pro
90096	32	1000	Windows 11 Pro
87983	64	1000	Windows 11 Pro
85010	32	512	Windows 10 Pro
83685	64	1000	Windows 11 Pro
33254	64	2000	Windows 11 Pro
85886	64	2000	Windows 11 Pro
57210	64	1000	Windows 11 Pro
14697	64	512	Windows 10 Pro
22206	64	1000	Windows 11 Pro
49229	64	4000	Windows 11 Pro
52312	64	2000	Windows 11 Pro
58309	64	512	Windows 11 Pro
59668	32	1000	Windows 10 Pro
18869	64	1000	Windows 10 Pro
66010	64	2000	Windows 10 Pro
82151	16	512	Windows 11 Pro
18509	16	512	Windows 11 Pro
48382	32	512	Windows 11 Pro
71710	16	512	Windows 11 Pro
27635	16	512	Windows 11 Pro
25993	16	512	Windows 11 Pro
45968	16	1000	Windows 11 Pro
53150	16	1000	Windows 11 Pro
79081	32	512	Windows 11 Pro
64232	16	2000	Windows 11 Pro
78766	16	2000	Windows 11 Pro
37504	16	512	Windows 11 Home
37400	16	512	Windows 10 Home
90223	16	512	Windows 11 Pro
17626	16	1000	Windows 11 Home
24326	16	1000	Windows 11 Pro
84890	32	1000	Windows 10 Pro
92441	32	512	Windows 11 Home
79330	32	1024	Windows 11 Home
21491	32	1024	Windows 11 Home
73394	32	512	Windows 10 Pro
89269	8	256	macOS
47642	16	256	macOS
27001	8	256	macOS
90516	8	256	macOS
83745	16	512	macOS
75063	16	512	macOS
78118	16	1000	Windows 11 Home
92818	16	1000	Windows 11 Home
74553	16	1000	Windows 11 Home
33580	16	1000	Windows 10 Home
89876	16	1000	Windows 11 Home
40503	24	1000	Windows 10 Home
48074	16	1000	Windows 10 Pro
35369	16	1000	Windows 11 Home
10207	32	1000	Windows 11 Pro
25493	64	2000	Windows 11 Home
13143	32	1000	Windows 11 Home
70933	16	1000	Windows 11
91980	24	2000	Windows 10 Pro
25456	24	2000	Windows 11 Pro
37175	64	4000	Windows 11 Home
90649	32	1000	Windows 11 Home
51744	16	1000	Windows 10 Pro
64346	32	1000	Windows 11 Home
15962	32	2000	Windows 10 Pro
53750	32	2000	Windows 11 Home
55829	32	2000	Windows 11 Home
83454	64	1000	Windows 11 Home
93558	32	2000	Windows 11 Home
37831	32	1000	Windows 11 Pro
11480	32	2000	Windows 11 Pro
93967	48	2000	Windows 11 Pro
36370	48	2000	Windows 10 Pro
46913	64	4000	Windows 11 Home
43347	64	2000	Windows 11 Home
18891	32	4000	Windows 11 Home
50340	64	2000	Windows 11 Home
49358	16	1000	\N
76412	64	2000	Windows 10 Pro
82088	16	1000	Windows 11 Pro
52457	32	1000	Windows 11 Pro
10803	64	4000	Windows 11 Home
99893	32	4000	Windows 11 Home
53684	64	4000	Windows 11 Pro
61910	48	4000	Windows 11 Pro
84569	64	4000	Windows 11 Pro
13816	64	1000	Windows 11 Pro
33020	32	2000	Windows 11 Pro
53321	64	4000	Windows 11 Pro
54294	64	4000	Windows 10 Pro
98142	64	4000	Windows 10 Pro
72797	64	4000	Windows 11 Home
72193	16	1000	Windows 11 Home
14660	48	8000	Windows 11 Home
94626	64	4000	Windows 11 Home
27793	48	8000	Windows 11 Pro
73110	16	1000	Windows 11 Home
30366	16	1000	Windows 11 Home
92208	32	1000	Windows 11 Home
70374	32	2000	Windows 11 Home
53923	32	1000	Windows 11 Pro
70616	32	1000	Windows 10 Pro
64257	32	1000	Windows 10 Pro
17342	64	2000	Windows 11 Home
78298	32	2000	Windows 10 Pro
49235	32	1000	Windows 11 Pro
84048	32	1000	Windows 11 Home
98892	64	1000	Windows 10 Pro
51353	32	2000	Windows 10 Pro
80239	32	2000	Windows 11 Pro
37297	32	2000	Windows 11 Pro
85680	32	4000	Windows 11 Pro
99848	64	2000	Windows 10 Pro
53479	64	2000	Windows 10 Pro
18678	64	1000	Windows 10 Pro
29569	64	1000	Windows 11 Pro
46760	64	2000	Windows 11 Pro
14085	32	4000	Windows 10 Pro
54453	32	4000	Windows 11 Pro
59183	64	4000	Windows 11 Pro
92118	64	4000	Windows 10 Pro
80028	32	4000	Windows 10 Pro
31753	64	4000	Windows 11 Pro
84839	64	1000	Windows 10 Pro
89388	64	8000	Windows 11 Pro
61061	64	2000	Windows 11 Home
34560	16	512	Windows 11 Pro
88012	32	1000	Windows 11 Pro
25315	32	512	Windows 11 Pro
50407	32	1000	Windows 11 Pro
14145	32	1024	Windows 11 Pro
45585	16	512	Windows 11 Pro
64246	32	512	Windows 11 Pro
21376	32	512	Windows 11 Pro
75149	32	512	Windows 11 Pro
41148	32	2512	Windows 11 Pro
58704	32	512	Windows 11 Pro
69232	64	1000	Windows 11 Home
49666	64	1000	Windows 11 Pro
38329	32	512	Windows 11 Home
78825	64	1000	Windows 11 Pro
49625	32	1000	Windows 11 Pro
32939	32	1000	Windows 11 Pro
45527	16	1000	Windows 11 Pro
24710	16	1000	Windows 11 Pro
59049	16	512	Windows 11 Pro
14901	16	1000	Windows 11 Pro
36489	16	512	Windows 11 Pro
22137	16	1000	Windows 11 Pro
68166	64	2000	Windows 11 Pro
76321	16	512	Windows 11 Home
13268	16	1000	Windows 11 Home
73263	32	1000	Windows 11 Pro
75543	32	1000	Windows 11 Home
30195	32	2000	Windows 11 Pro
54579	64	1000	Windows 11 Pro
73369	64	1000	Windows 11 Pro
78632	32	2000	Windows 11 Pro
50679	32	2000	Windows 11 Pro
52904	64	2000	Windows 11 Pro
28781	64	2000	Windows 11 Pro
22878	64	4000	Windows 11 Pro
77652	64	4000	Windows 11 Pro
98698	32	512	Windows 11 Home
27395	32	2000	Windows 11 Home
36894	32	2000	Windows 11 Pro
14791	64	12000	Windows 11 Pro
70210	16	1000	Windows 11 Pro
60801	32	1000	Windows 11 Pro
78464	32	1000	Windows 11
25182	16	2000	Windows 11
10538	64	2000	Windows 11
15771	32	2000	Windows 11 Pro
87894	16	512	Windows 11
21413	16	512	Windows 11
71194	16	512	Windows 11 Home
16047	16	512	Windows 11 Home
23513	16	1000	Windows 11 Pro
78233	16	1000	Windows 11
50957	16	1000	Windows 11
12946	16	512	Windows 11 Home
85701	16	512	Windows 10 S
50913	16	512	Windows 11
93735	16	512	Windows 11 Home
52058	16	512	Windows 10 Home
36287	16	512	Windows 11 Home
35237	16	512	Windows 11 Home
47560	16	512	Windows 11 Home
46261	16	512	Windows 10 Home
79766	16	512	Windows 10 Pro
51831	16	512	Windows 11 Pro
67817	16	512	Windows 10 Pro
97965	16	512	Windows 11 Pro
25420	16	512	Windows 11 Pro
45737	16	512	Windows 10 Pro
29571	16	512	Windows 11 Pro
30643	16	512	Windows 10 Pro
45866	16	1000	Windows 10 Home
25002	16	1000	Windows 11
11999	16	1000	Windows 11 Home
91650	16	1000	Windows 11 Home
83351	16	1000	Windows 11 Home
77378	16	1000	Windows 10 Home
23418	16	1000	Windows 10 Home
37076	16	1000	Windows 11 Home
81110	16	1000	Windows 10 Home
55916	16	2000	Windows 11 Home
82006	16	2000	Windows 11
28554	16	1000	Windows 10 Pro
85246	16	1000	Windows 11 Pro
42089	16	1000	Windows 10 Pro
32449	16	1000	Windows 11 Pro
19337	16	2000	Chrome OS
50812	16	2000	Windows 10 Home
90381	16	2000	Windows 10 Home
54399	16	2000	Windows 11 Home
80854	16	2000	Windows 11 Home
68149	16	2000	Windows 11 Home
16648	16	2000	Windows 10 Home
27049	16	2000	Windows 11 Pro
13800	16	2000	Windows 10 Pro
71700	16	2000	Windows 11 Pro
98538	16	2000	Windows 11 Pro
16613	16	2000	Windows 10 Pro
23884	16	4000	Windows 11 Pro
60279	16	256	macOS
21287	16	256	macOS
61369	16	256	macOS
33459	16	256	macOS
88134	16	256	macOS
87693	16	256	macOS
92505	16	256	macOS
68436	16	256	Chrome OS
90781	16	512	macOS
56612	16	512	macOS
50952	16	512	macOS
53559	16	512	macOS
35971	16	512	macOS
97932	16	512	macOS
20295	16	512	macOS
71039	24	256	macOS
84421	24	512	macOS
27274	24	512	macOS
22178	24	512	macOS
71377	24	512	macOS
22748	24	512	macOS
69714	24	512	macOS
50683	24	512	macOS
99715	24	1000	macOS
94465	24	1000	macOS
71675	32	512	macOS
40368	16	4000	Windows 11 Home
39333	16	1000	Windows 11 Home
28837	16	1000	Windows 11 Home
90863	16	1000	Windows 11 Pro
43823	16	1000	Windows 11 Home
57638	16	1000	Windows 11 Pro
61390	16	1000	Windows 11 Home
34032	16	1000	Windows 11 Pro
97186	16	4000	Chrome OS
53296	16	1000	Windows 10 Home
52567	16	2000	Windows 11 Pro
69412	16	1000	Windows 11 Home
73898	16	1000	Windows 10 Home
13966	16	2048	Windows 11 Home
18567	16	1000	Windows 11 Pro
72303	16	1000	Windows 10 Pro
24796	16	2000	Windows 10 Home
56064	16	1000	Chrome OS
72737	16	2000	Windows 10 Pro
70455	16	2000	Windows 11 Pro
32387	16	4000	Windows 11 Pro
46996	16	4000	Windows 11 Home
55693	16	1000	Windows 11 Home
89225	16	4000	Windows 11 Home
85324	16	4000	Windows 11 Home
26697	16	4000	Windows 10 Home
76577	16	1000	Windows 11 Home
23491	16	4000	Windows 10 Pro
63174	32	1000	Windows 11 Home
24022	16	1000	Windows 11 Home
52712	16	1000	Windows 11 Home
82895	32	2000	Windows 11 Home
95124	32	4000	Windows 11 Home
19296	8	512	Windows 11 Home
79828	16	1000	Windows 11 Home
70420	16	1000	Windows 11 Home
62535	16	2000	Windows 11 Home
87402	16	1000	Windows 11
64190	16	1000	Windows 10 Home
91379	16	1000	Windows 11 Home
41941	16	1000	Windows 10 Home
81820	16	1000	Windows 11 Home
30843	16	1000	Windows 10 Home
60307	16	1000	Windows 10 Home
18658	16	1000	Windows 10 Pro
54658	24	1000	Windows 10 Home
37294	16	1000	Windows 11 Pro
87459	16	1000	Windows 11 Pro
66511	24	1000	Windows 10 Home
67062	16	1000	Windows 10 Pro
84345	16	1000	Windows 11 Pro
54852	16	1000	Windows 10 Pro
81372	24	1000	Windows 10 Home
40953	16	1000	Windows 11 Pro
32686	16	1000	Windows 10 Pro
96849	16	1000	Windows 10 Pro
97766	32	1000	Windows 11 Home
20209	32	10	\N
85260	24	1000	Windows 10 Pro
24984	24	1000	Windows 10 Pro
87616	32	1000	Windows 10 Home
88128	32	1000	Windows 10 Home
70674	32	1000	Windows 11 Home
52647	32	1000	Windows 10 Home
82756	32	1000	Windows 11 Home
22799	32	1000	Windows 10 Home
68355	32	1000	Windows 11 Home
33091	32	1000	Windows 10 Home
50374	16	1000	Windows 11 Home
63188	16	1000	Windows 11 Home
19123	16	1000	Windows 10 Home
88415	16	1000	Windows 11 Home
24253	16	1000	Windows 10 Home
99850	16	1000	Windows 10 Home
59664	16	1000	Windows 11 Home
52914	16	1000	Windows 10 Home
74788	32	2000	Windows 11 Home
94540	16	2000	Windows 10 Home
96529	16	2000	Windows 10 Home
18058	16	2000	Windows 11 Home
21866	16	2000	Windows 10 Home
38522	16	1000	Windows 11 Pro
28208	32	1000	Windows 10 Pro
93379	24	1000	Windows 11 Home
10024	16	1000	Windows 10 Pro
29231	32	1000	Windows 10 Pro
96623	32	1000	Windows 11 Pro
69372	32	1000	Windows 10 Pro
79632	16	1000	Windows 11 Pro
48207	32	1000	Windows 11 Pro
61115	32	1000	Windows 11 Pro
90684	16	1000	Windows 11 Pro
68610	24	1000	Windows 11 Home
35646	24	1000	Windows 10 Home
36956	16	1000	Windows 10 Pro
99327	16	1000	Windows 10 Pro
51497	16	1000	Windows 10 Pro
49286	16	1000	Windows 10 Pro
99071	16	1000	Windows 11 Pro
49917	24	2000	Windows 10 Home
66980	24	2000	Windows 11 Home
55123	16	2000	Windows 11 Pro
86379	16	2000	Windows 11 Pro
11064	24	2000	Windows 10 Home
90149	16	2000	Windows 10 Pro
76902	32	1000	Windows 10 Home
62978	32	1000	Windows 10 Home
26718	32	1000	Windows 11 Home
48559	32	1000	Windows 10 Home
18180	24	1000	Windows 11 Pro
58394	32	1000	Windows 11 Home
81943	32	1000	Windows 10 Home
16963	24	1000	Windows 11 Pro
10110	24	1000	Windows 10 Pro
83404	32	1000	Windows 11 Home
57086	32	1000	Windows 11 Home
24378	32	1000	Windows 11 Home
46989	32	1000	Windows 10 Home
14087	32	2000	Windows 10 Home
40833	24	2000	Windows 10 Pro
66585	24	2000	Windows 11 Pro
87353	16	2000	Windows 11 Home
61677	16	2000	Windows 10 Home
91948	32	2000	Windows 10 Home
51697	32	2000	Windows 11 Home
60173	32	2000	Windows 10 Home
63219	32	2000	Windows 11 Home
60012	16	2000	Windows 10 Home
67041	16	2000	Windows 11 Home
81449	16	2000	Windows 10 Home
37684	32	1000	Windows 10 Pro
96833	32	1000	Windows 10 Pro
32729	32	1000	Windows 11 Pro
72242	32	1000	Windows 11 Pro
28228	32	1000	Windows 10 Pro
34671	32	1000	Windows 10 Pro
82800	32	1000	Windows 11 Pro
60409	32	1000	Windows 10 Pro
57223	32	1000	Windows 11 Pro
64687	24	1000	Windows 11 Pro
30220	32	2000	Windows 11 Pro
47810	16	2000	Windows 11 Home
97826	16	2000	Windows 10 Pro
26455	24	2000	Windows 10 Home
27600	32	2000	Windows 11 Pro
11520	32	2000	Windows 10 Pro
19403	32	2000	Windows 11 Pro
94985	32	2000	Windows 10 Pro
12058	24	2000	Windows 11 Home
28873	24	2000	Windows 10 Home
73792	16	2000	Windows 11 Pro
67243	64	1000	Windows 11 Home
27796	64	1000	Windows 10 Home
21097	64	1000	Windows 11 Home
27985	48	1000	Windows 10 Home
94180	48	1000	Windows 11 Home
64507	32	1000	Windows 11 Pro
69772	64	4000	Windows 11 Home
89223	48	2000	Windows 11 Home
65797	48	2000	Windows 10 Home
91690	48	2000	Windows 11 Home
33566	16	2000	Windows 10 Pro
69558	32	2000	Windows 10 Home
76770	32	2000	Windows 10 Home
65590	48	2000	Windows 10 Home
68988	48	2000	Windows 11 Home
60425	24	2000	Windows 10 Pro
56570	48	2000	Windows 11 Home
39588	48	2000	Windows 10 Home
34352	32	2000	Windows 10 Home
65675	16	2000	Windows 10 Pro
89242	32	2000	Windows 11 Home
10973	32	2000	Windows 11 Home
85751	24	2000	Windows 11 Pro
75294	24	2000	Windows 10 Pro
41031	32	2000	Windows 10 Home
75762	32	2000	Windows 11 Home
45291	64	1000	Windows 10 Pro
63849	64	1000	Windows 11 Pro
81587	48	1000	Windows 11 Home
85543	48	2000	Windows 10 Pro
58099	48	1000	Windows 11 Pro
14385	48	1000	Windows 10 Pro
14963	32	1000	Windows 11 Pro
84468	48	2000	Windows 10 Pro
73342	32	2000	Windows 10 Pro
58310	48	2000	Windows 11 Pro
24832	48	2000	Windows 10 Pro
86056	48	2000	Windows 10 Pro
73115	32	2000	Windows 10 Pro
28623	32	2000	Windows 11 Pro
78997	32	2000	Windows 11 Pro
46624	32	2000	Windows 10 Pro
70940	32	2000	Windows 11 Pro
77757	32	2000	Windows 11 Pro
20254	32	2000	Windows 11 Pro
78597	32	2000	Windows 11 Home
21592	64	1000	Windows 10 Home
42142	32	4000	Windows 10 Home
92662	32	4000	Windows 10 Home
96997	32	4000	Windows 10 Home
97650	32	4000	Windows 11 Home
20234	32	4000	Windows 10 Home
99662	32	4000	Windows 11 Home
93058	64	1000	Windows 11 Home
80673	64	1000	Windows 10 Home
85973	64	2000	Windows 11 Home
50959	64	2000	Windows 11 Home
16917	64	2000	Windows 11 Home
55029	64	2000	Windows 10 Home
80127	64	2000	Windows 10 Home
11413	64	2000	Windows 10 Home
71455	48	2000	Windows 11 Home
69511	48	2000	Windows 11 Home
77195	48	2000	Windows 10 Home
71503	32	4000	Windows 11 Pro
85230	32	4000	Windows 10 Pro
53452	32	4000	Windows 11 Pro
65183	32	4000	Windows 11 Pro
56257	32	4000	Windows 10 Pro
48616	32	4000	Windows 10 Pro
47907	64	1000	Windows 11 Pro
31955	64	1000	Windows 10 Pro
14630	64	2000	Windows 11 Pro
88333	64	2000	Windows 10 Pro
49855	64	2000	Windows 10 Pro
83886	64	2000	Windows 11 Pro
44136	64	2000	Windows 10 Pro
18050	64	2000	Windows 11 Pro
92483	64	2000	Windows 10 Pro
72018	64	2000	Windows 11 Pro
85778	48	2000	Windows 11 Pro
32161	48	2000	Windows 11 Pro
85085	32	2000	Windows 11 Pro
16765	48	4000	Windows 11 Home
96025	48	4000	Windows 10 Home
48240	48	4000	Windows 11
13578	48	4000	Windows 11 Home
47593	48	4000	Windows 10 Home
73538	48	2000	Windows 10 Pro
20814	64	2000	Windows 10 Home
26622	64	2000	Windows 11 Home
76269	64	2000	Windows 10 Home
20074	32	4000	Windows 10 Home
46418	32	4000	Windows 11 Home
43036	48	4000	Windows 11 Pro
27372	48	4000	Windows 10 Pro
90713	64	2000	Windows 11 Pro
46827	64	2000	\N
46073	64	2000	Windows 11 Pro
43679	64	2000	Windows 11 Pro
11861	64	2000	Windows 10 Pro
89144	32	4000	Windows 11 Pro
32886	32	4000	Windows 10 Pro
87564	64	2000	Windows 11 Pro
29809	64	2000	Windows 10 Home
96396	64	2000	Windows 11 Home
68543	64	4000	Windows 10 Home
58466	64	4000	Windows 11 Home
32989	64	4000	Windows 10 Home
44242	64	4000	Windows 11 Home
40958	64	4000	Windows 11 Home
73559	64	4000	Windows 10 Home
33699	64	2000	Windows 11 Pro
79125	64	4000	Windows 10 Pro
14337	64	4000	Windows 10 Pro
54937	64	4000	Windows 10 Pro
21062	64	4000	Windows 11 Pro
29014	64	4000	Windows 10 Pro
88059	64	4000	Windows 10 Pro
30204	64	4000	Windows 11 Pro
75004	64	4000	Windows 11 Home
64125	64	4000	Windows 10 Home
60222	64	4000	Windows 10 Home
41188	64	4000	Windows 10 Home
96594	16	4000	Windows 11 Home
67695	64	4000	Windows 10 Pro
93568	64	4000	Windows 10 Pro
31926	64	4000	Windows 11 Pro
37637	64	4000	Windows 11 Pro
85727	64	4000	Windows 10 Pro
55229	64	4000	Windows 10 Pro
17120	64	4000	Windows 11 Pro
44654	64	4000	Windows 11 Home
25203	64	4000	Windows 11 Pro
16884	64	8000	Windows 11 Home
31967	64	8000	Windows 11 Home
70819	64	8000	Windows 11 Home
62264	64	8000	Windows 10 Home
72420	64	8000	Windows 10 Pro
49500	64	8000	Windows 11 Pro
72425	64	8000	Windows 10 Pro
79798	64	8000	Windows 11 Pro
40626	64	8000	Windows 11 Pro
59781	64	8000	Windows 10 Pro
99589	64	8000	Windows 10 Pro
61127	16	512	Windows 11 Pro
44422	16	512	Windows 11 Pro
79526	24	512	Windows 11 Pro
66981	24	1000	Windows 11 Pro
11554	24	1000	Windows 11 Pro
47852	40	1000	Windows 11 Pro
60070	24	1000	Windows 11 Pro
98931	40	1000	Windows 11 Pro
51377	12	512	Windows 10 Pro
79501	8	256	Windows 11 Pro
99505	16	512	Windows 11 Pro
22761	16	512	Windows 11 Pro
79637	16	512	Windows 11 Pro
93548	16	256	Windows 11 Pro
56376	8	1000	Windows 10 Pro
66595	12	512	Windows 11 Pro
90017	16	512	Windows 11 Pro
95467	16	1000	Windows 11 Pro
45728	16	512	Windows 11 Pro
53904	16	512	Windows 11 Pro
45432	40	1000	Windows 11 Pro
45007	32	1000	Windows 11 Home
22881	16	512	Windows 11 Pro
43468	40	2000	Windows 11 Pro
95766	32	1000	Windows 11 Pro
61269	16	512	Windows 11 Pro
70438	40	1000	Windows 11 Pro
98511	32	512	Windows 11 Pro
41692	32	512	Windows 10 Pro
98065	32	512	Windows 11 Pro
87165	16	2000	Windows 11 Pro
35549	16	512	Windows 10 Pro
78151	32	1000	Windows 11 Pro
54224	32	1000	Windows 11 Pro
98829	32	1000	Windows 11 Pro
33582	40	2000	Windows 10 Pro
51060	16	512	Windows 11 Pro
81776	16	512	Windows 10 Pro
11386	16	512	Windows 11 Pro
98185	24	4000	Windows 10 Pro
18906	24	512	Windows 11 Pro
22805	24	512	Windows 11 Pro
78847	24	512	Windows 10 Pro
23619	16	1000	Windows 11 Pro
99849	48	1000	Windows 11 Pro
68450	16	1000	Windows 10 Pro
56073	16	1000	Windows 11 Pro
38759	16	1000	Windows 10 Pro
47132	16	512	Windows 11 Pro
43016	24	1000	Windows 11 Pro
35307	24	1000	Windows 10 Pro
14461	24	1000	Windows 11 Pro
13106	24	1000	Windows 10 Pro
91185	32	1000	Windows 11 Pro
22050	32	1000	Windows 11 Pro
87874	16	512	Windows 10 Pro
96062	32	1000	Windows 11 Pro
38419	32	1000	Windows 10 Pro
88562	24	2000	Windows 11 Pro
25963	48	2000	Windows 11 Pro
25725	16	2000	Windows 10 Pro
89257	48	2000	Windows 11 Pro
27027	24	2000	Windows 10 Pro
59277	24	2000	Windows 11 Pro
96034	24	2000	Windows 10 Pro
94922	48	2000	Windows 11 Pro
84195	48	1000	Windows 11 Pro
34217	48	1000	Windows 10 Pro
24528	16	1000	Windows 10 Pro
34151	32	2000	Windows 11 Pro
43205	32	2000	Windows 10 Pro
48609	32	2000	Windows 11 Pro
71204	32	2000	Windows 10 Pro
96570	48	1000	Windows 11 Pro
19924	32	4000	Windows 10 Pro
93726	32	2000	Windows 11 Pro
69433	48	2000	Windows 11 Pro
46226	16	4000	Windows 11 Pro
65965	16	4000	Windows 10 Pro
52389	48	2000	Windows 10 Pro
43729	48	2000	Windows 11 Pro
19698	48	2000	Windows 10 Pro
46344	24	4000	Windows 11 Pro
18177	24	4000	Windows 10 Pro
60174	32	4000	Windows 11 Pro
60933	32	4000	Windows 10 Pro
53601	48	4000	Windows 10 Pro
17872	48	4000	Windows 11 Pro
43847	48	4000	Windows 11 Pro
44690	48	4000	Windows 10 Pro
33321	16	256	Windows 11 Pro
67747	32	1000	Windows 11 Pro
19096	8	512	Windows 11 Home
74450	8	512	Windows 11 Home
89993	32	2000	Windows 11 Home
61463	32	1000	Windows 11 Pro
33388	32	2000	Windows 11 Pro
94604	64	1000	Windows 11 Pro
74494	32	1000	Windows 11 Pro
24212	32	1000	Windows 11 Pro
28857	64	2000	Windows 11 Pro
80861	64	4000	Windows 11 Pro
66525	16	1000	Windows 11 Pro
38624	16	1000	Windows 11 Home
23926	32	1000	Windows 11 Pro
67878	16	1000	Windows 10 Home
43947	16	1000	Windows 11 Home
14569	64	2000	Windows 11 Home
19557	16	1000	Windows 10 Pro
19229	16	1000	Windows 11 Pro
84887	24	1000	Windows 10 Home
42846	24	1000	Windows 11 Home
68442	16	1024	Windows 10 Pro
12459	24	1000	Windows 10 Pro
75234	24	1000	Windows 11 Pro
29510	32	1000	Windows 10 Home
95572	32	1000	Windows 11 Home
93930	16	2000	Windows 10 Home
10113	16	2000	Windows 11 Home
14959	32	1000	Windows 10 Pro
97111	32	1000	Windows 11 Pro
61181	16	2000	Windows 10 Pro
44922	16	2000	Windows 10 Pro
29871	24	2000	Windows 10 Home
53231	24	2000	Windows 11 Home
61292	16	2000	Windows 11 Pro
85319	64	4000	Windows 11 Pro
10485	24	2000	Windows 11 Pro
74314	32	2000	Windows 10 Home
72670	32	2048	Windows 11 Home
62941	32	2000	Windows 11 Home
19188	32	2000	Windows 10 Pro
39602	32	2000	Windows 11 Pro
10433	64	1000	Windows 10 Home
60387	64	1000	Windows 11 Home
73185	64	1000	Windows 10 Pro
25886	64	1000	Windows 11 Pro
80163	48	2000	Windows 10 Pro
57044	48	2000	Windows 11 Pro
53704	32	4000	Windows 10 Home
99369	32	4000	Windows 11 Home
62509	32	4000	Windows 11 Pro
17234	64	2000	Windows 11 Home
92873	64	2048	Windows 11 Home
94813	64	2000	Windows 10 Home
21883	64	1000	Windows 11 Pro
57887	32	4000	Windows 10 Pro
80074	64	2000	Windows 11 Pro
54572	64	2000	Windows 11 Pro
20545	64	2048	Windows 10 Pro
70245	64	2000	Windows 10 Pro
48005	64	2048	Windows 11 Pro
94907	64	2000	Windows 11 Pro
36623	32	1000	Windows 11 Pro
33149	48	4000	Windows 10 Home
82676	48	4000	Windows 11 Home
15155	48	4000	Windows 11 Pro
60353	48	4000	Windows 10 Pro
96603	64	4000	Windows 10 Home
35035	64	4000	Windows 11 Home
49173	64	4000	Windows 11 Pro
61131	64	4000	Windows 10 Pro
92656	24	2000	Windows 11 Home
73766	48	8000	Windows 10 Home
21123	48	8000	Windows 11 Home
92941	48	8000	Windows 10 Pro
67407	48	8000	Windows 11 Pro
34833	64	8000	Windows 10 Home
28342	64	8000	Windows 11 Home
14679	64	8000	Windows 10 Pro
35309	64	8000	Windows 11 Pro
13324	64	2000	Windows 11 Pro
87718	128	16000	Windows 11 Pro
41258	64	8000	Windows 11 Home
74124	16	1000	Windows 10 Home
60956	16	1000	Windows 11 Home
18256	16	2000	Windows 10 Home
80851	16	2000	Windows 10 Pro
94332	16	2000	Windows 11 Home
50334	24	1000	Windows 10 Home
75494	24	1000	Windows 10 Pro
79984	24	1000	Windows 11 Pro
68891	24	2000	Windows 10 Home
12151	24	2000	Windows 11 Home
14855	24	2000	Windows 10 Pro
54470	24	2000	Windows 11 Pro
17347	32	1000	Windows 10 Home
54265	32	1000	Windows 10 Pro
15611	32	2000	Windows 10 Pro
63150	32	2000	Windows 10 Home
25491	32	4000	Windows 10 Home
37745	32	4000	Windows 10 Pro
95701	32	4000	Windows 11 Pro
97466	48	2000	Windows 10 Home
78566	48	2048	Windows 10 Pro
70079	48	2000	Windows 11 Pro
98877	48	4000	Windows 10 Home
29523	48	4000	Windows 10 Pro
85936	48	4000	Windows 11 Home
40537	48	4000	Windows 11 Pro
19441	48	8000	Windows 10 Pro
14833	48	8000	Windows 10 Home
28558	48	8000	Windows 11 Home
74080	64	2000	Windows 10 Home
95699	64	2000	Windows 10 Pro
12498	64	4000	Windows 10 Home
71763	64	8000	Windows 10 Home
91051	64	4000	Windows 11 Pro
16003	64	8000	Windows 10 Pro
41808	24	1000	Windows 11 Home
95037	48	8000	Windows 11 Pro
27109	32	1000	Windows 11 Pro
11882	32	2000	Windows 11 Home
32577	64	2000	Windows 11 Home
92924	32	4000	Windows 11 Home
16548	16	2000	Windows 11 Pro
50283	16	1000	Windows 11 Pro
22752	32	1000	Windows 11 Home
69793	64	4000	Windows 11 Home
90114	64	2000	Windows 11 Pro
32372	64	2000	Windows 11 Pro
87469	24	1000	Windows 11 Home
18383	24	1000	Windows 10 Home
23937	24	1000	Windows 11 Pro
24965	64	2000	Windows 10 Pro
75161	64	1000	Windows 10 Home
87984	64	1000	Windows 10 Pro
90691	64	1000	Windows 11 Pro
38910	32	2000	Windows 11 Home
18271	64	2000	Windows 10 Pro
36560	32	1000	Windows 11 Pro
65864	16	1024	Windows 11 Home
54216	32	1000	Windows 11 Home
62692	32	1000	Windows 11 Pro
52498	32	2000	Windows 11 Pro
25833	16	1000	Windows 11 Home
99664	32	1000	Windows 11 Home
85493	16	1000	Windows 11 Home
81550	32	2000	Windows 11 Pro
28000	32	2000	Windows 11 Pro
52151	64	2000	Windows 11 Pro
37948	64	2000	Windows 11 Pro
15975	64	4000	Windows 11 Pro
87736	32	1000	Windows 11 Home
32734	64	2000	Windows 11 Pro
53975	64	4000	Windows 11 Pro
18286	64	2000	Windows 11 Pro
45899	64	2000	Windows 11 Pro
28512	64	4000	Windows 11 Pro
64415	64	8000	Windows 11 Pro
32026	64	8000	Windows 11 Pro
58487	64	8000	Windows 11 Pro
82536	32	2000	Windows 11 Pro
28754	48	2000	Windows 11 Home
31627	64	1000	Windows 11 Home
67496	64	8000	Windows 11 Pro
41934	32	2000	Windows 11 Pro
86282	32	1000	Windows 11 Pro
15334	32	2000	Windows 11 Pro
23102	64	1000	Windows 11 Pro
92863	64	4000	Windows 11 Pro
90273	32	1000	Windows 11 Home
59300	16	512	Windows 10 Pro
30677	16	1000	Windows 11 Home
12048	16	512	Windows 10 Pro
73827	32	1000	Windows 11 Pro
20580	16	512	Windows 11 Home
10832	16	1000	Windows 11 Home
33516	16	1000	Windows 10 Home
21683	16	1000	Windows 11 Home
87821	16	1000	Windows 10 Pro
47189	16	1000	Windows 10 Pro
64555	32	1000	Windows 10 Home
72391	24	1000	Windows 10 Pro
26632	32	1000	Windows 10 Home
37021	32	2000	Windows 11 Pro
93863	24	1000	Windows 11 Home
45513	48	2000	Windows 10 Home
78562	48	2000	Windows 11 Home
69037	16	1000	Windows 11 Home
64005	24	2000	Windows 10 Pro
32878	32	2000	Windows 10 Pro
90024	32	4000	Windows 11 Pro
14931	48	2000	Windows 10 Pro
88154	48	2000	Windows 10 Pro
33593	48	2000	Windows 11 Pro
75521	32	4000	Windows 11 Pro
90222	64	2000	Windows 10 Pro
92207	48	4000	Windows 10 Pro
49478	48	4000	Windows 11 Pro
55593	48	4000	Windows 10 Pro
64891	48	8000	Windows 10 Home
10599	64	4000	Windows 10 Pro
83100	48	8000	Windows 10 Home
40885	48	8000	Windows 11 Pro
35153	48	8000	Windows 10 Home
25401	16	512	Windows 11 Home
79494	64	8000	Windows 11 Pro
22541	16	1000	Windows 11 Pro
91123	32	1000	Windows 11 Pro
57435	16	512	Windows 11 Home
80742	32	512	Windows 11 Home
76524	32	1024	Windows 11 Home
38740	16	512	Windows 11 Home
70845	16	512	Windows 11 Pro
92111	16	512	Windows 11 Home
96419	16	512	Windows 11 Home
37277	16	512	Windows 11 Pro
46231	16	1000	Windows 11 Home
35391	16	512	Windows 11 Home
24769	16	512	Windows 11 Pro
99816	16	1000	Windows 11 Pro
72182	16	1000	Windows 11 Pro
75210	32	1000	Windows 11 Home
33111	16	1000	Windows 11 Home
30940	16	1000	Windows 11 Pro
97836	16	2000	Windows 11 Home
15651	16	1000	Windows 11 Pro
17081	16	2000	Windows 11 Pro
69302	24	1000	Windows 11 Pro
94523	16	2000	Windows 11 Home
57735	16	2000	Windows 11 Pro
37471	16	2000	Windows 11 Pro
42949	16	512	Windows 11 Home
53816	16	512	Windows 11 Home
90847	16	512	Windows 11 Pro
69394	16	512	Windows 11 Pro
15677	32	1000	Windows 11 Pro
23686	32	1000	Windows 11 Home
16875	64	2000	Windows 10 Home
80432	32	2000	Windows 10 Home
13809	32	1000	Windows 11 Home
73577	64	4000	Windows 11 Pro
77489	64	2000	Windows 11 Pro
25212	32	2000	Windows 11 Pro
40841	64	2000	Windows 11 Pro
68303	32	2000	Windows 11 Pro
87687	32	2000	Windows 11 Pro
85990	64	4000	Windows 11 Pro
52725	64	2000	Windows 11 Pro
64927	64	4000	Windows 11 Pro
36050	64	4000	Windows 11 Pro
98716	64	1000	Windows 11 Pro
52688	64	4000	Windows 11 Pro
40154	32	2000	Windows 11 Home
24435	16	512	Windows 11 Home
39855	16	512	Windows 11 Home
22853	16	512	Windows 11 Home
41079	16	512	Windows 11 Home
64079	16	1000	Windows 11 Home
36208	16	1000	Windows 11 Home
59221	16	1000	Windows 11 Home
38922	16	1000	Windows 11 Home
71733	16	512	DOS
86689	16	512	Windows 11 Pro
73492	16	1000	Windows 11 Home
17122	16	512	Windows 11 Pro
67129	16	1000	Windows 11 Pro
28997	32	1000	Windows 11 Pro
38333	32	512	Windows 11 Pro
89879	16	1000	Windows 11 Pro
69636	32	2000	Windows 11 Pro
33338	32	512	Windows 11 Pro
60768	32	1000	Windows 11 Pro
58953	32	1000	Windows 11 Pro
27878	32	1000	Windows 11 Pro
69996	16	512	Windows 10 Pro
35448	16	256	Windows 11 Pro
92840	32	1000	Windows 11 Pro
57001	16	512	Windows 10 Pro
45349	32	1000	Windows 11 Pro
36504	32	512	Windows 11 Pro
54025	32	2000	Windows 11 Pro
26673	32	4000	Windows 11 Pro
14206	16	1000	Windows 11 Pro
84536	32	1000	Windows 11 Pro
17818	32	1000	Windows 11 Pro
46779	32	2000	Windows 11 Pro
27891	32	4000	Windows 11 Pro
24563	32	512	Windows 11 Pro
71018	16	2000	Windows 11 Pro
70106	32	4000	Windows 11 Pro
64817	32	1000	Windows 11 Pro
55033	32	1000	Windows 10 Pro
38816	32	1000	Windows 11 Pro
48687	32	1000	Windows 11 Pro
89119	32	2000	Windows 11 Pro
30550	32	2000	Windows 10 Pro
93623	32	2000	Windows 10 Pro
90154	32	2000	Windows 11 Pro
32273	32	2000	Windows 11 Pro
85775	16	512	Windows 11 Pro
82450	64	2000	Windows 11 Pro
40107	32	4000	Windows 11 Pro
21334	32	4000	Windows 11 Pro
63961	32	4000	Windows 10 Pro
78389	32	1000	Windows 11 Pro
74122	32	1000	Windows 11 Pro
38369	16	1000	Windows 11 Home
87539	64	2000	Windows 11 Pro
72061	64	4000	Windows 11 Pro
70655	16	512	Windows 10 Home
46591	16	512	Windows 11 Home
11901	32	1000	Windows 11 Pro
66113	16	1000	Windows 11
42329	16	1000	Windows 10 Home
42483	16	1000	Windows 11 Home
66917	16	1000	Windows 10 Home
85951	16	512	Windows 11 Home
39151	16	512	Windows 11 Pro
29525	16	512	Windows 10 Pro
85196	64	2000	Windows 11 Pro
10665	24	1000	Windows 10 Home
64758	24	1000	Windows 10 Home
15796	24	1000	Windows 11 Home
15250	24	1000	Windows 10 Home
71689	16	1000	Windows 10 Pro
14406	24	1000	Windows 11 Pro
72818	24	1000	Windows 10 Pro
22844	32	1000	Windows 10 Home
74918	24	1000	Windows 10 Pro
41524	16	1000	Windows 11 Pro
20890	32	1000	Windows 11 Pro
83202	16	2000	Windows 10 Home
11628	16	2000	Windows 11 Home
63296	32	1000	Windows 11 Pro
38574	32	1000	Windows 11 Home
27394	24	2000	Windows 11
56976	24	2000	Windows 11 Home
48769	24	2000	Windows 10 Home
41334	16	2000	Windows 10 Pro
94887	48	1000	Windows 11 Home
21892	48	1000	Windows 10 Home
12087	24	2000	Windows 10 Pro
72886	32	2000	Windows 11 Home
97691	32	2000	Windows 10 Home
49955	24	2000	Windows 11 Pro
31207	24	2000	Windows 10 Pro
70199	32	2000	Windows 11 Pro
84760	16	1000	Windows 11 Pro
86501	48	1000	Windows 10 Pro
13199	32	2000	Windows 11 Pro
69616	32	2000	Windows 10 Pro
28169	48	2000	Windows 10 Home
63131	48	2000	Windows 11 Home
34241	48	2000	Windows 10 Home
58551	32	1000	Windows 11 Pro
92157	48	2000	Windows 11 Pro
70856	48	2000	Windows 10 Pro
93021	64	2000	Windows 10 Home
10178	64	2000	Windows 11 Pro
92222	64	2000	Windows 11 Pro
19266	64	2000	Windows 11 Home
53634	64	2000	Windows 10 Pro
14287	64	3000	Windows 10 Home
48874	64	4000	Windows 11 Home
65823	64	4000	Windows 10 Home
45361	64	4000	Windows 11 Pro
90281	64	4000	Windows 10 Pro
81098	64	4000	Windows 11 Pro
85396	64	4000	Windows 10 Pro
37151	64	1000	Windows 11 Home
99740	64	4000	Windows 11 Home
20611	32	2000	Windows 10 Pro
91324	64	4000	Windows 11 Pro
54000	64	2000	Windows 11 Pro
17184	32	2000	Windows 11 Pro
77467	64	2000	Windows 11 Home
98428	64	1000	Windows 11 Pro
57708	64	1000	Windows 11 Home
16758	64	1000	Windows 10 Home
24544	32	4000	Windows 11 Pro
60194	32	4000	Windows 11 Home
57918	32	4000	Windows 10 Pro
70994	32	1000	Windows 10 Pro
91151	32	1000	Windows 11 Home
15357	16	512	Windows 11 Home
57916	16	512	Windows 11 Home
58029	32	1000	Windows 10 Home
32972	32	1000	Windows 11 Home
94957	16	1000	Windows 11 Home
83241	24	1000	Windows 10 Pro
18782	24	1000	Windows 11 Home
83499	16	1000	Windows 11 Pro
36832	16	1000	Windows 11 Pro
53899	24	1000	Windows 11 Pro
80730	32	1000	Windows 11 Home
24884	32	1000	Windows 11 Pro
95070	24	2000	Windows 11 Pro
72717	32	2000	Windows 11 Home
86037	32	1000	Windows 11 Home
37498	64	1000	Windows 10 Home
39548	32	2000	Windows 11 Pro
52003	32	1000	Windows 11 Pro
56230	16	1000	\N
45043	32	1000	Windows 11 Home
76003	64	2000	Windows 11 Home
99158	64	1000	Windows 11 Pro
65434	16	1000	Windows 11
46325	32	2000	Windows 11 Pro
17138	64	2000	Windows 11 Pro
18305	64	2000	Windows 11 Pro
58865	24	1000	Windows 11
55249	16	1000	Windows 11 Pro
69298	32	1000	Windows 11 Home
73730	16	512	Windows 11 Pro
75726	16	1000	Windows 11 Home
79033	16	1000	Windows 11 Home
26083	24	1000	Windows 11 Pro
71625	32	1000	Windows 10 Pro
79717	32	1000	Windows 11 Pro
79842	64	4000	Windows 11 Home
48307	24	2000	Windows 11
69241	64	4000	Windows 11 Pro
91389	24	2000	Windows 11 Pro
58253	32	2000	Windows 11 Home
98251	32	2000	Windows 11 Pro
18601	32	2000	Windows 11 Pro
34687	16	512	Windows 11 Home
70014	48	1000	Windows 11 Pro
21443	48	2000	Windows 11 Home
20508	64	2000	Windows 11 Home
61207	16	1000	Windows 11 Pro
33437	64	2000	Windows 11 Pro
47797	16	1000	Windows 11 Pro
20085	32	1000	Windows 11 Pro
31596	32	2000	Windows 11 Pro
46168	16	1000	Windows 11 Home
24683	16	1000	Windows 11 Pro
29392	64	4000	Windows 11
75054	64	2000	Windows 11 Pro
29726	64	2000	Windows 11 Pro
78247	32	1000	Windows 11 Pro
92218	32	1000	Windows 11 Pro
12974	32	11	\N
48426	32	1000	Windows 11 Home
99443	64	4000	Windows 11 Home
80966	16	512	Windows 10 Pro
27305	16	2000	Windows 11 Home
72115	64	4000	Windows 11 Pro
55442	64	512	Windows 11 Pro
65067	16	1000	Windows 11 Home
68177	64	4000	Windows 11 Pro
12815	32	2000	Windows 11 Home
48209	32	2000	Windows 11 Pro
34780	32	2000	Windows 11 Pro
18250	32	2000	Windows 11 Home
12888	64	1000	Windows 11 Pro
40451	64	1000	Windows 11 Pro
78107	64	1000	Windows 11 Home
54024	32	1000	Windows 11 Home
85851	64	4000	Windows 11 Pro
54930	32	1000	Windows 10 Pro
95951	64	2000	Windows 11 Pro
94679	64	2000	Windows 11 Home
52769	64	2000	Windows 11 Home
73720	64	2000	Windows 11 Pro
87772	24	2048	Windows 11 Pro
97274	32	2000	Windows 10 Home
79489	32	2000	Windows 11 Pro
81888	16	2000	Windows 10 Pro
68360	64	4000	Windows 11 Home
70031	64	4000	Windows 11 Home
49856	64	4000	Windows 11 Pro
84350	48	2000	Windows 10 Pro
27295	64	1000	Windows 11 Home
50172	64	1000	Windows 10 Pro
32509	64	1000	Windows 11 Home
44079	64	2000	Windows 11 Home
39724	64	4000	Windows 11 Home
73470	64	4000	Windows 11 Home
58745	16	1000	Windows 11
47767	48	2000	Windows 11 Home
16202	48	1000	Windows 10 Home
29443	32	1000	Chrome OS
56284	16	1000	Windows 10 Pro
91085	16	2000	Windows 10 Pro
31075	16	1000	Windows 11 Pro
80165	32	1000	Windows 11 Pro
47387	32	512	Windows 11 Pro
32984	64	1000	Windows 11 Pro
97340	64	2000	Windows 11 Pro
30117	64	512	Windows 10 Pro
31135	64	2000	Windows 11
41182	16	1000	Windows 11
25324	16	2000	Windows 11
15393	32	2000	Windows 11
51500	16	2000	Windows 11 Pro
85304	32	2000	Windows 11 Pro
26577	32	512	Windows 10 Pro
67788	64	2000	Windows 11 Home
44132	48	4000	Windows 10 Home
58453	48	2000	Windows 10 Home
34182	48	1000	Windows 11 Pro
36890	48	1000	Windows 11 Home
83726	48	1000	Windows 10 Pro
14546	48	1000	Windows 10 Home
97235	32	1000	Windows 10 Home
51542	24	2000	Windows 10 Pro
55068	24	2000	Windows 10 Home
29391	16	2000	Windows 10 Pro
58878	16	1000	Windows 10 Pro
68776	16	1000	Windows 10 Home
80761	48	1000	Windows 10 Home
31311	16	2000	Windows 10 Pro
79945	32	512	Windows 11 Home
49526	64	4000	Windows 10 Pro
25923	48	1000	Windows 11 Home
13266	16	1000	Windows 11 Home
63026	24	2000	Windows 10 Pro
75459	16	512	Windows 10 Home
29055	64	6000	Windows 11 Home
51971	20	512	Windows 11 Home
30454	20	1000	Windows 11 Pro
10562	24	2000	Windows 11 Home
81584	16	2000	Windows 11 Pro
53421	16	2000	Windows 11 Home
94835	16	512	Windows 10 Pro
48739	32	1000	Windows 11 Home
72116	32	1000	Windows 11 Pro
47988	16	512	Windows 11 Home
85199	32	2000	Windows 11 Pro
29278	48	2000	Windows 11 Pro
84086	32	2000	Windows 10 Pro
67947	24	1000	Windows 11 Home
54392	24	1000	Windows 10 Pro
24721	24	1000	Windows 10 Home
15253	16	1000	Windows 10 Pro
28274	16	1000	Windows 10 Home
98867	64	2000	Windows 11 Home
82215	64	2000	Windows 10 Home
25319	32	2000	Windows 10 Home
50380	32	1000	Windows 10 Home
13250	64	4000	Windows 10 Pro
62642	64	2000	Windows 11 Pro
90939	32	2000	Windows 11 Pro
38883	32	512	Windows 11 Home
68454	64	4000	Windows 11 Home
56844	16	1000	Windows 11 Home
22121	32	1000	Windows 11 Home
52777	16	256	Windows 11 Home
17213	16	512	Windows 11 Home
89711	16	512	Windows 11 Home
35578	16	512	Windows 11 Home
86471	16	512	Windows 11 Home
79000	16	512	Windows 11 Home
39116	16	512	Windows 11 Pro
46428	16	512	Windows 11 Home
35652	16	512	Windows 11 Home
12955	16	512	Windows 11 Home
20956	16	512	Windows 11 Home
80570	16	1000	Windows 11 Home
68387	16	1000	Windows 11 Home
98744	16	256	Windows 11 Home
98022	16	1000	Windows 11 Home
21452	16	512	Windows 11 Home
77081	16	512	Windows 11 Home
61697	32	1000	Windows 11 Home
35486	16	1000	Windows 11 Home
74286	16	2000	Windows 11 Home
51649	16	256	Windows 11 Home
89058	16	1000	Windows 11 Home
89308	16	512	Windows 11 Pro
77050	16	256	Windows 11 Pro
17346	16	512	Windows 11 Pro
97394	16	512	Windows 11 Pro
57325	32	1000	Windows 11 Pro
62108	16	256	Windows 11 Pro
66051	16	256	Windows 11 Home
58448	16	512	Windows 11 Pro
60608	32	1000	Windows 11 Home
58867	16	512	Windows 11 Pro
11597	16	512	Windows 11 Home
47309	16	2000	Windows 11 Pro
55209	32	1000	Windows 11 Pro
56052	16	1000	Windows 11 Pro
50381	32	1000	Windows 11 Pro
68402	32	1000	Windows 11 Home
83535	32	1000	Windows 11 Pro
21481	32	1500	Windows 11 Pro
38271	32	2000	Windows 11 Pro
68224	16	512	Windows 11 Home
64474	32	1000	Windows 11 Pro
67999	16	1000	Windows 11 Home
47831	16	512	Windows 11 Pro
31468	16	512	Windows 11 Pro
65552	16	512	Windows 11 Pro
64289	16	512	Windows 11 Pro
28293	16	1000	Windows 10 Pro
86962	16	2000	Windows 10 Pro
21282	16	1000	Windows 11 Home
28827	16	512	Windows 11 Pro
37234	32	1000	Windows 11 Home
49745	32	1000	Windows 11 Pro
72208	32	2000	Windows 11 Pro
78852	32	8000	Windows 11 Pro
53963	32	1000	Windows 11 Pro
87421	32	2000	Windows 11 Pro
59253	32	1000	Windows 11 Home
21593	32	2000	Windows 11 Pro
10867	32	2000	Windows 11 Home
63668	32	2000	Windows 11 Home
93729	32	2000	Windows 11 Pro
64331	32	4000	Windows 11 Home
32923	32	4000	Windows 11 Home
82851	32	4000	Windows 11 Pro
70570	32	8000	Windows 11 Home
84437	32	8000	Windows 11 Pro
27947	16	512	Windows 11 Pro
36117	32	512	Windows 11 Pro
34380	16	256	Windows 11 Pro
60039	16	1000	Windows 11 Pro
47940	16	512	Windows 11 Pro
82596	16	512	Windows 11 Pro
74302	16	1000	Windows 11 Pro
15535	16	512	Windows 11 Pro
49582	32	512	Windows 11 Pro
86704	32	2000	Windows 11 Pro
74762	32	512	Windows 11 Pro
83306	16	1024	Windows 11 Pro
70745	32	1000	Windows 11 Pro
39428	64	1000	Windows 11 Pro
13517	32	1000	Windows 11 Pro
10320	16	512	Windows 11 Pro
30188	32	1000	Windows 11 Pro
44429	64	2000	Windows 11 Pro
49343	16	2000	Windows 11 Pro
93958	32	2000	Windows 11 Pro
93435	64	512	Windows 11 Pro
71936	32	2000	Windows 11 Pro
26276	32	1000	Windows 11 Pro
95696	64	1000	Windows 11 Pro
97282	64	1000	Windows 11 Pro
64677	16	1000	Windows 11 Pro
33510	16	256	Windows 11 Pro
74472	64	2000	Windows 11 Pro
94513	16	1000	Windows 11 Pro
42079	64	2000	Windows 11 Pro
13728	32	512	Windows 11 Pro
25644	32	1000	Windows 11 Pro
46335	16	512	Windows 11 Pro
74625	16	512	Windows 11 Pro
18745	16	1000	Windows 11 Pro
88497	16	1000	Windows 10 Pro
57416	32	1000	Windows 11 Pro
86161	32	1000	Windows 11 Pro
72978	16	2000	Windows 11 Pro
84130	32	2000	Windows 11 Pro
67156	64	512	Windows 11 Pro
43804	64	1000	Windows 11 Pro
92312	48	2000	Windows 11 Pro
99903	64	512	Windows 11 Pro
72395	64	1000	Windows 11 Pro
25674	64	2000	Windows 11 Pro
77177	48	4000	Windows 11 Pro
85400	64	4000	Windows 10 Pro
12299	64	4000	Windows 11 Pro
44018	32	1000	Windows 11 Pro
31344	16	1000	Windows 11 Home
86238	16	1000	Windows 11 Pro
17669	16	2000	Windows 11 Home
29154	16	2000	Windows 11 Pro
51901	16	4000	Windows 11 Pro
70429	16	1000	Windows 11 Pro
27759	32	1000	Windows 11 Pro
56843	32	2000	Windows 11 Pro
31405	64	2000	Windows 11 Pro
16932	16	512	Windows 11 Pro
45739	16	512	Windows 11 Home
57338	16	512	Windows 11 Pro
64986	32	1000	Windows 11 Pro
93394	16	512	Windows 11 Pro
56659	32	512	Windows 11 Pro
16385	32	1000	Windows 11 Pro
47992	16	1000	Windows 11 Pro
48228	32	2000	Windows 10 Pro
79417	32	1000	Windows 11 Pro
93747	16	512	Windows 11 Pro
20069	16	1000	Windows 11 Home
77353	32	1000	Windows 10 Pro
35403	16	512	Windows 11 Pro
92317	32	1000	Windows 11 Home
34018	32	1000	Windows 11 Pro
88480	32	1000	Windows 11 Pro
31906	16	512	Windows 10 Home
81265	32	1000	Windows 11 Home
51446	16	512	Windows 11 Pro
99780	32	1000	Windows 11 Pro
49462	16	512	Windows 10 Pro
45580	32	2000	Windows 11 Pro
99842	32	2000	Windows 11 Home
22561	64	1000	Windows 11 Pro
80047	32	1000	Windows 11 Pro
86027	32	2000	Windows 10 Pro
56088	32	1000	Windows 11 Home
11690	64	1000	Windows 11 Home
27950	16	1000	Windows 11 Pro
77917	16	1000	Windows 10 Pro
46885	32	2000	Windows 11 Pro
58891	64	1000	Windows 11 Pro
73556	24	1000	Windows 11 Pro
54605	32	1000	Windows 10 Home
31368	32	1000	Windows 11 Home
23424	16	2000	Windows 11 Home
38557	64	2000	Windows 11 Home
75979	32	2000	Windows 11 Pro
38981	64	2000	Windows 11 Pro
34696	32	1000	Windows 11 Pro
83224	32	1000	Windows 11 Pro
90403	24	2000	Windows 11 Home
78898	32	4000	Windows 11 Home
79742	64	2000	Windows 11 Pro
82235	32	1000	Windows 11 Pro
24937	64	4000	Windows 11 Home
64702	64	2000	Windows 11 Pro
70357	32	4000	Windows 11 Pro
20013	64	4000	Windows 11 Pro
25278	32	4000	Windows 11 Pro
27200	64	4000	Windows 11 Pro
12277	64	4000	Windows 11 Pro
72851	64	4000	Windows 11 Home
55640	16	1000	Windows 11 Pro
57522	64	4000	Windows 11 Home
28220	64	2000	Windows 10 Home
67925	64	4000	Windows 10 Home
88335	16	1000	Windows 11 Home
54832	16	2000	Windows 11 Pro
32571	32	2000	Windows 11 Pro
49935	16	512	Windows 11 Pro
13769	16	512	Windows 11 Pro
\.


--
-- Data for Name: dim_cpu; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dim_cpu (cpu_id, cpu_name, cpu_rank) FROM stdin;
14039	Intel Core i3-1215U	5
61788	Intel Core i7-1255U	\N
67047	AMD Ryzen AI 5 340	3
38681	Intel Core i5-1345U	\N
35875	Intel Core i5-1340P	\N
61248	Qualcomm Snapdragon X Elite X1E-80-100	1
57692	Intel Core Ultra 7 165H	\N
48096	Intel Core i7-1365U	\N
85061	Intel Core Ultra 5 125H	\N
71561	Intel Core i7-1265U	\N
99803	Intel Core Ultra 7 268V	2
98773	Intel Core Ultra 7 155H	\N
24264	AMD Ryzen AI 9 HX 370	\N
46264	Intel Core i7-14650HX	\N
53393	Intel Core Ultra 7 155U	\N
68487	Intel Core i5-1335U	\N
48663	AMD Ryzen 7 8840HS	\N
37886	Intel Core i7-1255U	\N
94613	Intel Core i9-13900H	\N
77880	Intel Core i7-1255U	\N
97096	Apple M4 Max (14-core CPU)	\N
87120	Intel Core Ultra 5 226V	\N
97862	Intel Core i7-14700HX	\N
38992	AMD Ryzen 7 7735HS	\N
69591	Intel Core i5-1250P	\N
35232	AMD Ryzen 9 8945HS	1
79922	Intel Core i5-1245U	\N
38818	Intel Core i5-1235U	\N
25506	Intel Core i5-13420H	1
70666	Intel Core i7-1365U	\N
19587	Intel Core i5-13420H	\N
53478	Intel Core i7-14650HX	\N
89503	Intel Core i5-12600HX	\N
10633	Intel Core Ultra 7 155H	\N
60797	Apple M4 Max (14-core CPU)	\N
84128	Intel Core i7-14700HX	\N
12213	Intel Core i5-1345U	\N
23621	AMD Ryzen AI 9 HX 370	1
82110	Intel Core Ultra 9 275HX	\N
37102	Intel Core i7-1280P	\N
20744	Intel Core i7-13620H	\N
19232	AMD Ryzen AI 9 HX PRO 370	\N
30869	AMD Ryzen 7 PRO 7840HS	1
42943	Intel Core Ultra 9 185H	1
66757	Intel Core i7-1365U	\N
28398	Intel Core i5-1340P	\N
91048	Intel Core i7-12800HX	\N
99837	Intel Core i5-14450HX	5
79888	Intel Core i7-12700H	1
15297	Intel Core i7-1355U	\N
86756	Intel Core i5-12600HX	\N
77350	Intel Core i9-14900HX	1
25036	Intel Core Ultra 7 256V	\N
48558	Intel Core Ultra 7 165H	\N
34507	AMD Ryzen 7 7735HS	1
19760	AMD Ryzen 7 8840HS	1
50065	Intel Core Ultra 9 185H	\N
10659	Intel Core Ultra 7 165U	1
23911	Intel Core i5-1245U	\N
56810	Intel Core i9-12900H	\N
97679	Intel Core Ultra 9 285HX	\N
63429	AMD Ryzen 7 8840HS	\N
63101	Intel Core i7-1280P	\N
43127	Intel Core i5-1340P	\N
77746	AMD Ryzen 7 7840HS	1
44159	Intel Core i7-1265U	\N
21471	AMD Ryzen AI 9 HX 370	\N
33255	Intel Core Ultra 5 135H	4
13113	Intel Core i9-13980HX	2
22577	AMD Ryzen 7 7435HS	\N
35362	Intel Core Ultra 9 185H	\N
31096	Intel Core i9-13900HX	\N
96430	Intel Core Ultra 5 125H	\N
15610	Intel Core Ultra 5 228V	\N
57948	Qualcomm Snapdragon X Elite X1E-80-100	\N
51462	Intel Core Ultra 9 185H	\N
97988	Intel Core i7-12650H	3
47373	Intel Core Ultra 9 185H	\N
15326	Intel Core Ultra 7 255HX	1
90856	Intel Core i7-1355U	\N
62007	Intel Core i5-1235U	\N
77411	AMD Ryzen 5 7640HS	4
49498	Intel Core i7-12850HX	\N
37532	Intel Core Ultra 7 165U	\N
48854	Intel Core Ultra 9 185H	\N
55351	Intel Core Ultra 9 275HX	\N
23113	Intel Core i9-14900HX	\N
75820	Intel Core Ultra 7 155H	\N
57028	Intel Core i7-1365U	\N
80736	Intel Core i5-1245U	\N
95914	Intel Core i5-12500H	\N
96858	AMD Ryzen AI 9 365	\N
90482	Intel Core i7-1365U	\N
30146	Intel Core Ultra 7 258V	\N
73682	Intel Core i5-13500H	\N
80101	Intel Core i9-12950HX	\N
51652	Intel Core i7-13700H	\N
81939	Intel Core i7-13700H	\N
15747	AMD Ryzen 5 7430U	\N
92788	Qualcomm Snapdragon X Elite X1E-80-100	\N
68373	Intel Core i7-1360P	\N
94746	AMD Ryzen 9 8945HS	\N
99701	Apple M3 Pro	15
10773	Intel Core i9-12900HX	4
35746	Intel Core i7-13700H	\N
80484	AMD Ryzen AI 7 350	1
14088	Qualcomm Snapdragon X Elite X1E-78-100	\N
41958	Intel Core Ultra 5 238V	\N
43901	AMD Ryzen AI 5 340	\N
47989	Intel Core i5-1235U	\N
80809	Intel Core i7-13700H	\N
62876	Intel Core i9-14900HX	\N
53327	Intel Core Ultra 7 256V	\N
41310	Intel Core i7-1370P	\N
59987	Intel Core Ultra 9 285HX	\N
76680	AMD Ryzen 5 7535HS	\N
71122	Intel Core Ultra 7 155H	\N
60577	Intel Core i9-13900HX	\N
81765	Intel Core i9-13950HX	1
28350	Intel Core i9-13900HX	\N
85361	AMD Ryzen AI 9 365	\N
98250	Intel Core i9-13980HX	\N
22051	Apple M3 (8-core CPU)	\N
28884	Intel Core Ultra 9 185H	\N
61445	Intel Core Ultra 9 185H	\N
25023	Apple M4 (10-core CPU)	\N
15475	AMD Ryzen 9 7940HX	\N
70191	Intel Core i7-14700HX	\N
42266	Qualcomm Snapdragon X Plus X1P-64-100	\N
12441	Qualcomm Snapdragon X Plus X1P-64-100	\N
67367	Intel Core i7-1280P	1
27048	Intel Core Ultra 7 155H	\N
22871	Intel Core i5-1345U	\N
71879	Intel Core i5-1235U	\N
16086	Intel Core i5-1245U	\N
34116	Intel Core i7-13700H	\N
53458	Intel Core i7-13700H	\N
57020	Intel Core i7-1355U	\N
96944	Intel Core Ultra 9 185H	\N
11699	Intel Core Ultra 5 226V	1
18288	Intel Core i7-12800H	\N
36945	AMD Ryzen AI 9 365	2
82298	Intel Core i7-1270P	\N
77181	AMD Ryzen 7 8845HS	\N
72126	Intel Core i7-1270P	\N
15235	Intel Core Ultra 9 288V	\N
46780	Intel Core i5-13500H	\N
69129	AMD Ryzen 9 7945HX	\N
59440	Intel Core Ultra 9 275HX	1
44634	Intel Core Ultra 7 255H	\N
94072	Intel Core i7-12850HX	\N
91039	Intel Core i9-13900HX	1
88204	Intel Core Ultra 7 155H	\N
32779	AMD Ryzen 5 7535HS	2
81645	Apple M3 Pro (12-core CPU)	3
30290	Intel Core Ultra 5 226V	\N
67163	Intel Core i7-14700HX	\N
82368	Intel Core Ultra 5 238V	1
10739	Intel Core Ultra 7 258V	\N
52065	Intel Core Ultra 5 226V	\N
38830	Intel Core i7-1365U	1
58422	Intel Core Ultra 7 258V	\N
92173	Intel Core i7-12800HX	\N
26152	AMD Ryzen 9 7845HX	4
61653	Intel Core Ultra 5 125U	2
68414	Intel Core Ultra 7 255HX	\N
95105	AMD Ryzen AI Max 385	\N
51662	Intel Core Ultra 9 275HX	\N
44649	Intel Core Ultra 9 288V	\N
38939	Intel Core i7-1360P	\N
76967	Apple M4 Pro (12-core CPU)	3
49066	Intel Core Ultra 7 165H	\N
61052	Intel Core i5-1335U	\N
84299	Intel Core i7-14650HX	\N
35470	Intel Core i5-1335U	\N
57774	AMD Ryzen 7 8845HS	\N
68400	AMD Ryzen 7 7730U	1
46583	Intel Core Ultra 9 285H	1
65601	AMD Ryzen 9 9955HX3D	\N
20793	AMD Ryzen 5 7535HS	\N
78864	Intel Core i7-1370P	7
89087	Apple M3 Max (16-core CPU)	1
19882	AMD Ryzen AI 9 365	\N
86568	Intel Core Ultra 7 155H	\N
47070	Intel Core i7-13620H	1
17051	Intel Core Ultra 5 228V	1
90785	Intel Core i9-14900HX	\N
52287	Intel Core Ultra 7 256V	\N
33038	Intel Core i9-13900HK	\N
16157	Apple M4 Pro (14-core CPU)	\N
29162	AMD Ryzen 9 8945HS	\N
94926	Intel Core Ultra 5 135H	\N
57349	Intel Core i7-1270P	\N
69067	Intel Core i5-13420H	\N
73916	Intel Core i5-1335U	\N
18936	Intel Core i5-1345U	4
31737	Intel Core i7-1355U	\N
96755	Intel Core Ultra 7 155H	\N
73373	AMD Ryzen 7 8845HS	\N
97946	Intel Core Ultra 7 155H	\N
97632	Intel Core Ultra 5 226V	\N
73806	AMD Ryzen 5 7530U	2
30152	Intel Core i9-14900HX	\N
89511	Intel Core i7-13700H	\N
74297	Intel Core Ultra 5 135H	\N
44502	Intel Core i5-13500HX	\N
29974	Intel Core i9-14900HX	\N
99703	Intel Core i7-1255U	78
37941	Intel Core i5-14500HX	4
92132	AMD Ryzen 7 7745HX	3
75907	Intel Core i7-1265U	\N
31093	Intel Core Ultra 5 125H	\N
83575	AMD Ryzen AI Max 390	\N
53036	Intel Core i5-12450H	\N
59992	Intel Core i7-1260P	4
72240	AMD Ryzen AI Max+ 395	\N
77388	Intel Core i5-1345U	\N
84233	Intel Core Ultra 9 185H	\N
21157	Intel Core i7-13850HX	1
11461	Apple M2 (10-core CPU)	2
19452	AMD Ryzen 7 8845HS	1
75683	Intel Core i7-1255U	\N
43425	Intel Core Ultra 9 288V	3
37627	Intel Core i9-14900HX	\N
86269	Qualcomm Snapdragon X Elite X1E-00-1DE	1
13238	AMD Ryzen 9 7940HS	\N
64516	Intel Core Ultra 9 185H	\N
18829	Intel Core i7-1360P	\N
49936	Intel Core i5-13600HX	\N
99921	AMD Ryzen 5 7535HS	\N
39837	AMD Ryzen AI 7 350	\N
70909	Intel Core i5-1335U	\N
11388	AMD Ryzen AI 9 HX 370	\N
94182	Intel Core i7-14700HX	1
40375	Intel Core i7-13620H	\N
18239	Intel Core i5-13420H	\N
92603	Intel Core i7-13700HX	\N
92511	Intel Core i7-14650HX	\N
94498	Intel Core i5-13500H	\N
39269	Intel Core Ultra 7 165H	\N
81529	AMD Ryzen 7 8840U	2
56884	Intel Core i7-1255U	2
82954	Intel Core Ultra 9 185H	\N
40673	Intel Core Ultra 7 256V	\N
82308	Intel Core i5-1335U	\N
19149	Intel Core i7-13700HX	\N
14965	Intel Core i7-13700HX	\N
40740	Intel Core i5-12450H	5
48479	Intel Core Ultra 5 125H	\N
99477	Intel Core Ultra 5 125H	3
87337	Intel Core i7-1260P	\N
73828	Intel Core i5-1340P	\N
37752	Intel Core Ultra 5 125U	\N
35751	Apple M3 Max (14-core CPU)	2
34100	Intel Core i7-1360P	1
28671	AMD Ryzen 5 8645HS	3
50980	Intel Core Ultra 7 258V	1
64087	Intel Core Ultra 5 135U	\N
41142	Apple M4 Pro (14-core CPU)	2
43631	Intel Core i9-13900H	1
50038	Intel Core i5-1345U	\N
16665	Intel Core Ultra 5 226V	\N
72908	Intel Core i7-1370P	\N
33480	Intel Core i5-1350P	\N
99702	Intel Core i7-1360P	45
99899	Intel Core i9-12950HX	\N
19600	AMD Ryzen AI 7 350	\N
93071	Intel Core Ultra 7 155H	\N
33329	AMD Ryzen 7 8845HS	\N
36619	Intel Core Ultra 7 165H	2
15230	Intel Core i5-1235U	\N
90439	Intel Core Ultra 7 268V	\N
87280	Intel Core Ultra 7 155H	\N
76209	Intel Core i5-1340P	1
80405	Intel Core Ultra 5 135U	\N
82754	AMD Ryzen 9 PRO 7940HS	2
95397	Intel Core Ultra 7 155H	\N
14804	Intel Core i5-1240P	\N
30889	Intel Core i5-1335U	2
66139	Intel Core Ultra 7 165H	\N
17128	Intel Core i7-13700HX	\N
76900	Intel Core i5-1240P	\N
48141	Intel Core i7-13700H	\N
96602	Intel Core i5-1240P	1
27875	Qualcomm Snapdragon X Plus X1P-64-100	2
55069	Intel Core Ultra 7 155U	\N
95709	Qualcomm Snapdragon X Plus X1P-64-100	\N
47701	Apple M4 Max (16-core CPU)	1
51053	Intel Core Ultra 5 135H	\N
77357	AMD Ryzen 7 7735HS	\N
51471	Intel Core i7-1355U	\N
15226	Intel Core Ultra 5 228V	\N
60014	Apple M4 Max (16-core CPU)	\N
94663	AMD Ryzen 9 8945HS	\N
78236	Intel Core i7-1355U	1
90689	Intel Core Ultra 7 155U	3
33770	Intel Core Ultra 9 185H	\N
84356	Intel Core Ultra 5 125H	\N
42858	Intel Core i7-1355U	\N
80513	Intel Core Ultra 7 155H	\N
93105	AMD Ryzen 5 8640U	3
91338	Intel Core Ultra 7 155H	1
28530	AMD Ryzen 9 7945HX	\N
19552	Intel Core i9-14900HX	\N
80597	Intel Core i7-13700HX	\N
27603	Intel Core i5-14450HX	\N
10960	Intel Core i5-12500H	2
88234	Intel Core Ultra 5 228V	\N
39035	Qualcomm Snapdragon X Elite X1E-78-100	1
81182	Intel Core Ultra 7 155H	\N
63011	Intel Core i5-13500HX	2
20022	AMD Ryzen AI 9 HX 370	\N
21338	Intel Core i5-12600H	\N
76476	Qualcomm Snapdragon X Plus X1P-42-100	5
68073	Intel Core Ultra 7 258V	\N
91201	Intel Core Ultra 7 155H	\N
96431	Intel Core i7-14700HX	\N
37964	Intel Core Ultra 9 285H	\N
91412	Intel Core Ultra 7 258V	\N
59146	AMD Ryzen 7 7735HS	\N
60860	AMD Ryzen 9 7945HX3D	1
25643	Intel Core i7-14650HX	3
99674	Intel Core i7-1360P	\N
57290	Intel Core Ultra 7 155H	\N
68827	Intel Core Ultra 7 155H	\N
99073	Intel Core i9-13900H	\N
85877	Qualcomm Snapdragon X Elite X1E-84-100	\N
39563	Intel Core Ultra 7 256V	2
70458	Intel Core i7-13620H	\N
11153	Intel Core Ultra 7 258V	\N
51984	AMD Ryzen 9 7940HS	\N
85067	Intel Core Ultra 7 164U	4
55796	AMD Ryzen 9 7940HS	1
81233	Intel Core i5-1250P	\N
66165	Intel Core Ultra 9 275HX	\N
84162	Intel Core Ultra 7 155H	\N
21869	Intel Core i7-1270P	\N
30489	Intel Core i5-1250P	\N
19514	Apple M4 (10-core CPU)	\N
73857	Intel Core i5-1335U	\N
43018	AMD Ryzen 7 260	4
27548	Intel Core i5-13500H	\N
79533	Intel Core i7-13700HX	1
91968	Intel Core Ultra 7 165H	\N
80390	Intel Core Ultra 5 125H	\N
41502	Intel Core i9-14900HX	\N
57118	Intel Core i5-14500HX	\N
53365	Intel Core i5-1350P	\N
38632	Intel Core Ultra 5 225H	\N
18581	Intel Core i7-12800H	\N
58906	Apple M2 (8-core CPU)	1
24860	Intel Core i9-14900HX	\N
26805	Intel Core i7-12700H	\N
93995	Intel Core i9-14900HX	\N
31940	Intel Core Ultra 9 185H	\N
53500	Intel Core Ultra 7 255H	\N
58200	Intel Core Ultra 5 228V	\N
56934	Apple M3 (8-core CPU)	\N
82551	Apple M1	\N
\.


--
-- Data for Name: dim_gpu; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dim_gpu (gpu_id, gpu_name, gpu_rank) FROM stdin;
58606	NVIDIA GeForce RTX 4080 (Laptop, 175W)	\N
59326	Apple M3 Max GPU (40-core)	\N
64162	Apple M2 GPU (10-core)	\N
85513	NVIDIA GeForce RTX 4090 (Laptop, 175W)	\N
24230	NVIDIA GeForce RTX 4080 (Laptop, 175W)	\N
14726	NVIDIA GeForce RTX 4070 (Laptop, 105W)	\N
78490	Intel Iris Xe Graphics G7 (80EU)	\N
22622	NVIDIA GeForce RTX 4060 (Laptop, 140W)	\N
99803	Intel Iris Xe Graphics	178
47487	NVIDIA GeForce RTX 4070 (Laptop, 140W)	\N
85757	Intel Iris Xe Graphics G7 (96EU)	\N
44483	NVIDIA GeForce RTX 3050 (Laptop, 95W)	\N
12942	NVIDIA GeForce RTX 4060 (Laptop)	2
20202	Intel Arc (8-Cores)	\N
80268	AMD Radeon 760M	2
24855	NVIDIA GeForce RTX 5070 Ti (Laptop)	\N
73192	AMD Radeon 880M	\N
37617	NVIDIA GeForce RTX 5060 (Laptop)	\N
63143	Intel Arc (7-Cores)	\N
88675	NVIDIA GeForce RTX 4050 (Laptop, 140W)	\N
41886	NVIDIA GeForce RTX 4060 (Laptop, 45W)	3
17531	NVIDIA GeForce RTX 4050 (Laptop, 95W)	5
34498	Intel Arc Graphics 130V	\N
63857	NVIDIA GeForce RTX 4070 (Laptop, 110W)	1
36438	NVIDIA GeForce RTX 4080 (Laptop, 175W)	\N
95792	Intel UHD Graphics Xe 750 (32EU)	\N
89365	NVIDIA GeForce RTX 4070 (Laptop, 140W)	\N
30625	Intel Arc (8-Cores)	\N
77915	NVIDIA GeForce RTX 4060 (Laptop, 140W)	\N
99727	NVIDIA GeForce RTX 4070 (Laptop, 125W)	\N
68877	NVIDIA GeForce RTX 5070 Ti (Laptop)	\N
88311	NVIDIA GeForce RTX 4060 (Laptop, 130W)	4
77193	NVIDIA GeForce RTX 4050 (Laptop, 120W)	4
32356	NVIDIA GeForce RTX 4060 (Laptop, 140W)	\N
98940	AMD Radeon 780M	\N
59369	NVIDIA RTX 2000 Ada Generation (50W)	2
99801	Apple M3 Pro GPU	25
60523	NVIDIA GeForce RTX 4060 (Laptop, 105W)	3
31983	NVIDIA GeForce RTX 4060 (Laptop, 140W)	\N
65846	Intel UHD Graphics (Alder Lake, 64EU)	3
96461	NVIDIA GeForce RTX 4070 (Laptop, 140W)	\N
31068	NVIDIA GeForce RTX 4060 (Laptop)	\N
78512	NVIDIA GeForce RTX 4050 (Laptop, 140W)	\N
64344	NVIDIA GeForce RTX 5090 (Laptop)	\N
28096	Intel Graphics (4-Cores)	\N
47548	NVIDIA GeForce RTX 4070 (Laptop, 130W)	3
83281	Intel Arc (8-Cores)	\N
20986	Intel UHD Graphics Xe G4 (48EU)	1
10157	AMD Radeon 840M	2
73208	NVIDIA GeForce RTX 5090 (Laptop)	\N
15136	NVIDIA GeForce RTX 3050 (Laptop, 95W)	5
15655	NVIDIA GeForce RTX 4090 (Laptop, 175W)	1
99802	Intel Iris Xe Graphics	156
59572	NVIDIA GeForce RTX 4070 (Laptop, 105W)	1
77608	Qualcomm Snapdragon X Elite Adreno GPU	\N
97773	Intel Iris Xe Graphics G7 (96EU)	\N
41359	Intel Iris Xe Graphics G7 (96EU)	\N
46167	NVIDIA GeForce RTX 4060 (Laptop, 50W)	1
31134	Intel Iris Xe Graphics G7 (96EU)	1
43791	NVIDIA RTX A2000 (Laptop)	\N
40475	Intel Iris Xe Graphics G7 (80EU)	\N
21818	NVIDIA GeForce RTX 4060 (Laptop, 140W)	\N
71822	NVIDIA GeForce RTX 4060 (Laptop, 140W)	\N
92515	NVIDIA GeForce RTX 4060 (Laptop, 125W)	3
77720	Apple M3 Pro GPU (18-core)	\N
31206	NVIDIA GeForce RTX 4090 (Laptop, 175W)	\N
73390	Intel Iris Xe Graphics G7 (80EU)	\N
14405	NVIDIA RTX 3000 Ada Generation (50W)	\N
87640	Apple M3 GPU (10-core)	\N
57151	NVIDIA GeForce RTX 4050 (Laptop, 105W)	2
47152	AMD Radeon 8050S Graphics	2
88579	NVIDIA RTX 2000 Ada Generation (50W)	\N
96006	NVIDIA GeForce RTX 3050 (Laptop, 95W, 6GB)	\N
36255	NVIDIA GeForce RTX 4060 (Laptop)	\N
87436	NVIDIA GeForce RTX 5050 (Laptop)	\N
73191	AMD Radeon 680M	2
16822	NVIDIA GeForce RTX 4070 (Laptop, 120W)	1
31706	NVIDIA GeForce RTX 5050 (Laptop)	\N
85352	NVIDIA GeForce RTX 4050 (Laptop)	\N
25336	Intel Iris Xe Graphics G7 (80EU)	\N
18399	NVIDIA GeForce RTX 3050 Ti (Laptop, 95W)	2
46118	NVIDIA RTX 3500 Ada Generation (Laptop)	1
62354	NVIDIA GeForce RTX 4050 (Laptop, 50W)	2
23529	Apple M4 Max (40-core GPU)	\N
15116	Intel Iris Xe Graphics G7 (80EU)	\N
99337	NVIDIA GeForce RTX 3050 (Laptop, 45W)	2
30636	NVIDIA GeForce RTX 4060 (Laptop, 140W)	\N
63194	Intel Arc (8-Cores)	\N
15693	NVIDIA GeForce RTX 5060 (Laptop)	\N
57477	Intel Arc Graphics 140V	\N
32214	NVIDIA GeForce RTX 4050 (Laptop, 140W)	\N
47128	Intel UHD Graphics Xe 750 (32EU)	3
80685	AMD Radeon 860M	3
75951	NVIDIA T550	3
39215	Apple M3 Max GPU (30-core)	\N
95634	Intel Arc Graphics 130V	\N
26762	NVIDIA GeForce RTX 4080 (Laptop, 175W)	1
57483	NVIDIA RTX A2000 (Laptop)	\N
67658	NVIDIA GeForce RTX 5060 (Laptop)	1
65517	NVIDIA RTX 2000 Ada Generation (95W)	5
51405	NVIDIA RTX A4500 (Laptop)	\N
12170	NVIDIA GeForce RTX 4070 (Laptop, 140W)	\N
99701	NVIDIA GeForce RTX 3050 (Laptop)	2
40145	NVIDIA GeForce RTX 5090 (Laptop)	1
98345	NVIDIA GeForce RTX 4090 (Laptop)	\N
30287	NVIDIA GeForce RTX 3080 Ti (Laptop, 135W)	\N
91685	NVIDIA GeForce RTX 4060 (Laptop, 140W)	\N
10609	Intel Iris Xe Graphics G7 (80EU)	\N
86916	Intel Arc Graphics 140V	\N
73113	Apple M3 GPU (10-core)	\N
40122	NVIDIA GeForce RTX 4080 (Laptop, 105W)	1
82036	NVIDIA GeForce RTX 4050 (Laptop, 140W)	\N
66557	NVIDIA GeForce RTX 4070 (Laptop, 115W)	1
76918	NVIDIA RTX 1000 Ada Generation	\N
14948	NVIDIA GeForce RTX 4050 (Laptop, 140W)	\N
67536	NVIDIA GeForce RTX 4050 (Laptop, 100W)	\N
78289	NVIDIA GeForce RTX 4070 (Laptop, 140W)	\N
96652	Intel Arc (8-Cores)	\N
77441	NVIDIA GeForce RTX 5070 Ti (Laptop)	\N
20104	NVIDIA GeForce RTX 5080 (Laptop)	\N
62513	NVIDIA GeForce RTX 4060 (Laptop, 140W)	\N
10932	Apple M4 (10-core GPU)	\N
40116	NVIDIA GeForce RTX 4060 (Laptop, 140W)	\N
86406	Qualcomm Snapdragon X Elite Adreno GPU	\N
72539	Intel Iris Xe Graphics G7 (96EU)	\N
38389	NVIDIA GeForce RTX 5080 (Laptop)	\N
39067	NVIDIA GeForce RTX 4090 (Laptop, 175W)	\N
89098	AMD Radeon 880M	2
88558	NVIDIA GeForce RTX 4080 (Laptop, 175W)	\N
65139	NVIDIA GeForce RTX 4050 (Laptop, 115W)	\N
54520	NVIDIA GeForce RTX 4050 (Laptop, 45W)	1
88419	NVIDIA RTX A5500 (Laptop)	2
86368	NVIDIA GeForce RTX 4080 (Laptop, 175W)	\N
72759	NVIDIA GeForce RTX 5070 Ti (Laptop)	\N
38752	Intel Arc Graphics 140V	\N
48568	NVIDIA RTX A500 (Laptop, 30W)	1
90473	NVIDIA GeForce RTX 4050 (Laptop, 100W)	\N
63588	NVIDIA RTX A2000 (Laptop, 95W)	\N
36522	NVIDIA GeForce RTX 4060 (Laptop, 140W)	\N
87410	AMD Radeon RX Vega 8 (R4000/5000, 15W)	1
29692	Intel Arc Graphics 140V	\N
42786	NVIDIA GeForce RTX 3050 (Laptop)	\N
93345	NVIDIA GeForce RTX 4050 (Laptop, 140W)	\N
85354	Intel Iris Xe Graphics G7 (96EU)	\N
90200	NVIDIA RTX 4000 Ada Generation (Laptop)	2
32942	NVIDIA GeForce RTX 4050 (Laptop)	\N
59613	NVIDIA RTX 1000 Ada Generation (50W)	3
87028	Intel Arc Graphics 140V	\N
29249	Intel Graphics (4-Cores)	\N
19487	NVIDIA GeForce RTX 4050 (Laptop)	\N
25444	NVIDIA RTX A4500 (Laptop, 135W)	1
76107	NVIDIA GeForce RTX 2050 (Laptop)	6
20490	NVIDIA GeForce RTX 4070 (Laptop, 140W)	\N
66224	NVIDIA GeForce RTX 4050 (Laptop, 100W)	3
76629	Intel UHD Graphics (Alder Lake, 64EU)	\N
50193	NVIDIA RTX 4000 Ada Generation (Laptop)	\N
59969	AMD Radeon 860M	\N
85008	NVIDIA GeForce RTX 4080 (Laptop, 125W)	\N
98503	NVIDIA GeForce RTX 5080 (Laptop)	\N
73407	Intel UHD Graphics 770	6
57880	Intel Arc (8-Cores)	1
19023	AMD Radeon RX Vega 7 (R4000/5000, 15W)	2
78337	Apple M4 Max (32-core GPU)	\N
25509	Intel Graphics (4-Cores)	2
58524	Intel Graphics (4-Cores)	\N
56255	Intel Arc (7-Cores)	2
65023	NVIDIA GeForce RTX 4090 (Laptop, 175W)	\N
55625	Intel Iris Xe Graphics G7 (96EU)	\N
89826	NVIDIA GeForce RTX 4060 (Laptop, 140W)	\N
67065	NVIDIA GeForce RTX 3070 Ti (Laptop, 150W)	3
59155	NVIDIA RTX A1000 (Laptop, 95W)	4
73133	NVIDIA GeForce RTX 4070 (Laptop, 140W)	\N
45847	Apple M4 Max (40-core GPU)	\N
77717	Intel Arc (8-Cores)	\N
76353	NVIDIA GeForce RTX 5060 (Laptop)	\N
33839	NVIDIA GeForce RTX 4070 (Laptop, 140W)	\N
40191	Intel Arc (7-Cores)	\N
75972	NVIDIA GeForce RTX 4070 (Laptop, 140W)	\N
99861	NVIDIA GeForce RTX 4070 (Laptop, 140W)	\N
65769	NVIDIA GeForce RTX 4060 (Laptop, 140W)	\N
10716	Intel Arc Pro A30M Graphics	\N
56285	Intel UHD Graphics (Alder Lake, 64EU)	\N
32786	NVIDIA RTX 3000 Ada Generation (50W)	1
27082	AMD Radeon 890M	1
63840	Intel Arc Graphics 130V	\N
38109	NVIDIA GeForce RTX 4070 (Laptop, 140W)	\N
22214	NVIDIA GeForce RTX 4050 (Laptop)	\N
46806	Intel Arc (8-Cores)	\N
85168	Apple M3 GPU (8-core)	\N
62502	Intel Iris Xe Graphics G7 (96EU)	\N
63363	NVIDIA GeForce RTX 5070 (Laptop)	\N
36698	Apple M2 GPU (8-core)	\N
95096	AMD Radeon 660M	\N
47289	AMD Radeon 890M	\N
13584	Intel Arc Graphics 130V	\N
57925	NVIDIA RTX 5000 Ada Generation (Laptop)	3
11403	NVIDIA GeForce RTX 4090 (Laptop, 175W)	\N
62183	NVIDIA GeForce RTX 4090 (Laptop)	1
90481	Apple M4 (10-core GPU)	\N
46242	Qualcomm Snapdragon X Elite Adreno GPU	\N
40079	NVIDIA GeForce RTX 5050 (Laptop)	\N
72373	NVIDIA T600	3
12014	NVIDIA GeForce RTX 4070 (Laptop, 140W)	\N
96427	NVIDIA GeForce RTX 5080 (Laptop)	\N
62095	NVIDIA RTX 1000 Ada Generation	\N
69437	NVIDIA GeForce RTX 4060 (Laptop, 140W)	\N
25239	Intel Iris Xe Graphics G7 (80EU)	\N
93924	NVIDIA GeForce RTX 4070 (Laptop, 100W)	1
12440	NVIDIA GeForce RTX 4050 (Laptop, 140W)	2
21939	Intel Iris Xe Graphics G7 (80EU)	\N
23954	NVIDIA GeForce RTX 4070 (Laptop, 105W)	\N
83284	AMD Radeon 880M	\N
72786	NVIDIA GeForce RTX 5070 (Laptop)	\N
21382	NVIDIA GeForce RTX 4070 (Laptop, 50W)	4
68034	NVIDIA GeForce RTX 4070 (Laptop, 140W)	\N
71789	NVIDIA GeForce RTX 4080 (Laptop, 175W)	\N
77277	AMD Radeon 780M	\N
96099	NVIDIA GeForce RTX 4070 (Laptop, 140W)	\N
43263	NVIDIA RTX A1000 (Laptop)	\N
44223	Intel Arc (8-Cores)	\N
23143	NVIDIA GeForce RTX 4080 (Laptop, 175W)	\N
35496	NVIDIA GeForce RTX 3050 (Laptop, 50W, 6GB)	2
61792	Intel Arc A370M	7
69606	Intel Iris Xe Graphics G7 (80EU)	\N
31119	NVIDIA GeForce RTX 4090 (Laptop, 125W)	2
42975	Apple M3 Pro GPU (14-core)	\N
28705	NVIDIA GeForce RTX 5080 (Laptop)	\N
89498	NVIDIA GeForce RTX 5070 (Laptop)	\N
88753	NVIDIA GeForce RTX 5090 (Laptop)	\N
83815	Intel Iris Xe Graphics G7 (96EU)	\N
95403	Intel Iris Xe Graphics G7 (96EU)	\N
62947	NVIDIA GeForce RTX 4050 (Laptop)	\N
70387	NVIDIA GeForce RTX 2050 (Laptop, 45W)	4
58546	NVIDIA GeForce RTX 5070 (Laptop)	\N
94341	Intel Arc 140T	1
22807	NVIDIA GeForce RTX 4080 (Laptop, 175W)	\N
28214	NVIDIA GeForce RTX 5070 (Laptop)	2
85842	Intel Arc Graphics 140V	1
10037	NVIDIA GeForce RTX 4070 (Laptop, 140W)	\N
36924	NVIDIA RTX A5500 (Laptop, 135W)	\N
81267	NVIDIA RTX A4500 (Laptop)	\N
43244	Qualcomm Snapdragon X Elite Adreno GPU	\N
39661	NVIDIA GeForce RTX 4060 (Laptop, 50W)	\N
10864	NVIDIA GeForce RTX 5080 (Laptop)	1
83872	NVIDIA GeForce RTX 4070 (Laptop, 140W)	1
99208	NVIDIA RTX 2000 Ada Generation (Laptop)	3
84012	NVIDIA RTX A1000 (Laptop)	\N
59424	NVIDIA GeForce RTX 4060 (Laptop, 140W)	\N
94837	Intel Iris Xe Graphics G7 (80EU)	2
78126	NVIDIA RTX A3000 (Laptop, 135W)	2
89195	AMD Radeon 660M	3
84732	NVIDIA RTX 500 Ada Generation (35W)	4
33425	NVIDIA GeForce RTX 4050 (Laptop, 140W)	\N
88618	Intel Iris Xe Graphics G7 (96EU)	\N
29603	NVIDIA GeForce RTX 4080 (Laptop, 175W)	\N
74797	NVIDIA GeForce RTX 4060 (Laptop, 100W)	\N
85713	NVIDIA RTX 3500 Ada Generation (Laptop)	\N
40365	NVIDIA GeForce RTX 4070 (Laptop, 140W)	\N
73238	NVIDIA GeForce RTX 4060 (Laptop, 140W)	\N
43776	Intel Arc (8-Cores)	\N
32973	NVIDIA GeForce RTX 4080 (Laptop)	1
21552	NVIDIA GeForce RTX 3060 (Laptop, 130W)	6
86725	Intel Iris Xe Graphics G7 (80EU)	\N
41938	NVIDIA GeForce RTX 4050 (Laptop)	1
33597	Intel Arc 130T	5
73172	Intel Iris Xe Graphics G7 (96EU)	\N
21239	Intel Arc Graphics 140V	\N
60374	NVIDIA GeForce RTX 4070 (Laptop, 140W)	\N
90576	NVIDIA T1200	2
96736	AMD Radeon 8060S Graphics	1
93574	NVIDIA GeForce RTX 4060 (Laptop, 140W)	1
52476	Apple M4 Pro (16-core GPU)	\N
87207	AMD Radeon 780M	\N
61000	NVIDIA GeForce RTX 4060 (Laptop, 140W)	\N
25608	NVIDIA GeForce RTX 4070 (Laptop, 140W)	\N
82365	Apple M1 GPU (8-core)	\N
77681	NVIDIA RTX 500 Ada Generation (50W)	1
35525	NVIDIA GeForce RTX 4060 (Laptop, 140W)	\N
73813	NVIDIA GeForce RTX 3050 (Laptop, 63W, 6GB)	1
82165	Apple M4 (8-core GPU)	\N
68536	NVIDIA GeForce RTX 4050 (Laptop, 140W)	\N
55135	NVIDIA RTX 2000 Ada Generation (Laptop)	\N
55544	Intel Iris Xe Graphics G7 (80EU)	\N
34775	NVIDIA RTX A1000 (Laptop)	5
80504	Intel Arc (7-Cores)	\N
44249	AMD Radeon 780M	\N
95854	Intel Iris Xe Graphics G7 (80EU)	\N
89477	NVIDIA GeForce RTX 4050 (Laptop, 50W)	\N
27329	NVIDIA GeForce RTX 4090 (Laptop, 105W)	\N
27658	NVIDIA GeForce RTX 4070 (Laptop, 125W)	1
44513	Apple M4 Max (32-core GPU)	\N
86818	NVIDIA GeForce RTX 4070 (Laptop)	5
63562	NVIDIA RTX A3000 (Laptop)	3
83080	NVIDIA GeForce RTX 4070 (Laptop, 140W)	\N
25403	NVIDIA GeForce RTX 4060 (Laptop, 140W)	\N
78425	NVIDIA GeForce RTX 4060 (Laptop, 115W)	2
83220	NVIDIA GeForce RTX 4060 (Laptop, 105W)	\N
81349	Intel Arc Graphics 130V	2
90634	NVIDIA GeForce RTX 4060 (Laptop, 140W)	\N
43360	NVIDIA GeForce RTX 4050 (Laptop, 140W)	\N
55943	AMD Radeon 840M	\N
43850	Intel Arc 140T	\N
79655	NVIDIA RTX A2000 (Laptop)	1
53283	NVIDIA GeForce RTX 5080 (Laptop)	\N
54560	Intel Iris Xe Graphics G7 (96EU)	\N
54359	Intel Iris Xe Graphics G7 (80EU)	\N
93042	Apple M4 Pro (20-core GPU)	\N
79444	NVIDIA GeForce RTX 4060 (Laptop, 100W)	1
55224	AMD Radeon 780M	1
88908	Intel Arc Graphics 130V	\N
37723	Intel Arc (7-Cores)	\N
75776	NVIDIA GeForce RTX 5070 Ti (Laptop)	1
88188	NVIDIA GeForce RTX 4050 (Laptop, 140W)	\N
95003	Apple M4 Pro (20-core GPU)	\N
10693	Intel Iris Xe Graphics G7 (96EU)	\N
\.


--
-- Data for Name: dim_laptop; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dim_laptop (laptop_id, laptop_name, start_price) FROM stdin;
35265	Acer Nitro 17 (AN17-42)	979.99
74437	ASUS Zenbook 14 UM3402 (Ryzen 7000 Series)	799.00
53449	ASUS Zenbook 14 OLED (UX3405)	749.00
39505	HP EliteBook 1040 G9	1199.98
99902	Dell XPS 13 Plus	\N
76207	Lenovo Yoga Pro 9 (16IMH9, Discrete)	2389.99
18600	Dell Latitude 14 7455	891.37
99901	Apple MacBook Pro M3	\N
62872	Apple MacBook Air 13 (2022)	638.95
83752	Apple MacBook Pro 14 (M4 Pro / M4 Max, Late 2024)	1761.69
77698	Apple MacBook Air 15 (Early 2025)	999.00
38091	HP Elite Dragonfly G4	1110.10
14334	Acer Predator Helios Neo 14 (PHN14-51)	1069.00
31432	Dell XPS 16 9640 (NVIDIA RTX 4050, 4060)	1769.00
36097	Acer Predator Helios 18 (PH18-72)	2899.99
67896	ASUS ROG Strix SCAR 17 G733 (2023)	3919.00
60206	Lenovo ThinkPad P14s Gen 5 (Intel)	1084.14
73646	ASUS ROG Strix G16 G615	1499.99
17367	HP Elite Dragonfly G3	2205.99
22873	MSI Stealth 16 AI Studio (A1Vx)	1695.00
62818	ASUS ROG Strix SCAR 18 G835	3399.00
47498	Lenovo ThinkPad X9-15 Gen 1	1179.95
13597	ASUS ProArt P16 (H7606)	1999.99
47364	Dell XPS 14 9440	1899.00
55843	Lenovo ThinkPad T14s Gen 3 (Intel)	849.00
39878	ASUS TUF Gaming A17 (FA707, 2023)	1399.00
37707	Acer Nitro 17 (AN17-71)	1899.00
70846	HP OMEN Transcend 16 (16t-u1000, 2024)	2339.00
28855	Apple MacBook Air 15 (Early 2024)	1199.00
89817	ASUS Zenbook DUO (UX8406)	1549.00
55121	Dell XPS 13 9345	689.00
99282	Lenovo Yoga Slim 7 (14Q8X9)	947.99
16507	HP ZBook Firefly 14 G10	917.00
87862	ASUS TUF Gaming A16 FA608	1675.66
61877	ASUS ROG Zephyrus G14 (GA402, 2023)	1469.00
62654	Lenovo Legion Pro 7i (16", Gen 9)	2999.99
31352	Lenovo IdeaPad Pro 5 (16IMH9)	1049.00
86923	Microsoft Surface Pro 11	815.99
32772	Lenovo ThinkPad X13 2-in-1 Gen 5	1230.11
84537	Dell Precision 16 7680	2709.93
52056	Acer Predator Helios Neo 16 (PHN16-72)	1249.99
74066	Lenovo ThinkPad X1 Carbon (11th Gen, 2023)	1249.77
46745	Acer Nitro 17 (AN17-41)	1319.00
72003	HP OmniBook Ultra Flip (14-fh0000)	1119.00
69827	Acer Nitro 16 (AN16-51)	899.00
57235	Acer Nitro 5 (AN517-55)	949.00
16460	ASUS ROG Flow Z13 GZ302	2299.99
42701	Apple MacBook Air 13 (Early 2025)	799.00
76426	Dell Precision 16 5690	2099.93
99235	Acer Predator Triton Neo 16 (PTN16-51)	1449.99
58280	Lenovo Legion Slim 5i / S5 (16" Intel, 2023)	1609.00
26236	Dell Precision 14 5490	1389.93
89295	MSI Sword 16 HX (B13Vx / B14Vx)	1498.00
89777	HP EliteBook 840 G10	739.77
34633	ASUS Zenbook 14 OLED (UM3406)	355.99
50756	MSI Pulse 15 (B13Vx)	1349.00
36309	Lenovo Legion Pro 7i (16" Intel, Gen 8)	2499.00
27779	ASUS ROG Strix G17 G713P (2023)	1349.00
45313	MSI Raider A18 HX (A9Wx)	3929.20
78719	Dell Latitude 14 9450 (2-in-1)	1449.99
46099	HP EliteBook 1040 G11	1499.99
39012	MSI Cyborg 14 (A13Ux / A13Vx)	992.51
21703	MSI Summit A16 AI+ (A3HMx)	1258.00
43903	Acer Swift X (SFX14-71G)	1849.99
58819	Acer Predator Triton 14 (PT14-51)	1499.99
58816	Acer Predator Helios 16 (PH16-72)	2994.45
45910	Alienware m16 R2	1699.00
49722	ASUS ROG Strix G18 (G814, 2024)	2111.90
21847	Lenovo ThinkBook 13x Gen 2	669.99
54284	MSI Titan 18 HX AI (A2XWx)	4972.06
33276	Lenovo Legion Pro 5 / Pro 5i (16″ Intel, 2023)	1549.00
44620	Apple MacBook Pro 16 (Late 2023)	1399.00
68471	Dell XPS 15 9530	549.98
45203	MSI Vector 16 HX AI (A2XWx)	1799.99
15083	Apple MacBook Air 13 (Early 2024)	799.00
55071	Lenovo ThinkPad P16v Gen 2 (Intel)	1539.95
72204	Acer Swift 14 AI (SF14-61 / SF14-61T)	949.99
63368	HP EliteBook x360 1040 G10	779.99
99903	HP Spectre x360	\N
95824	Lenovo Yoga Pro 7 (14", 14ARP8)	999.99
16626	Lenovo ThinkPad T14 Gen 4 (Intel, Integrated)	797.98
77537	Dell Precision 16 7670	749.00
30836	Lenovo ThinkPad X13 Gen 3 (Intel)	1742.03
84976	Lenovo Legion Pro 7i (16", Gen 10)	2299.99
85007	Acer Nitro 16 (AN16-42)	1099.00
32570	Acer Swift 16 AI (SF16-51 / SF16-51T)	949.49
63856	Lenovo Yoga 7i 2-in-1 (14", Gen 10)	1119.99
64627	ASUS Vivobook S 14 OLED (M5406)	1199.00
93284	Lenovo Legion Slim 5 (16", Gen 9)	1299.99
14005	Lenovo Legion Pro 5i (16", Gen 9)	1619.00
27614	Alienware x16 R2	1914.13
17553	Lenovo Yoga 7i (14", 2023)	849.95
62028	Alienware m18 R2	2299.99
50779	HP Pavilion Aero 13 (13z-bg0000)	999.00
49384	Lenovo ThinkPad P15v Gen 3 (Intel)	949.99
72287	Lenovo Yoga Slim 7 Aura Edition (15ILL9)	1119.99
23237	Apple MacBook Pro 16 (Late 2024)	2205.28
94853	Dell 16 Plus (DB16250)	893.00
12651	Lenovo ThinkPad X9-14 Gen 1	899.99
73499	Lenovo ThinkPad P16 Gen 1	1368.90
94614	ASUS TUF Gaming A14 FA401	1113.00
41139	Acer Predator Helios 16 (PH16-71)	1249.00
91034	ASUS ROG Strix G18 G815	2436.76
\.


--
-- Data for Name: fact_laptop_performance; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fact_laptop_performance (laptop_id, cpu_id, gpu_id, config_id, color_score, brightness_score, contrast_score, dci_p3_score, eye_safety_score, cpu_benchmark_score, total_score, laptop_ranking) FROM stdin;
33276	79533	93574	69241	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1081	92.0	84
33276	91039	83872	91389	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	100.0	84
33276	91039	83872	58253	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	100.0	84
33276	91039	83872	98251	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	100.0	84
33276	91039	83872	18601	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	100.0	84
33276	63011	93574	34687	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	795	79.0	84
33276	91039	83872	70014	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	100.0	84
33276	91039	83872	21443	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	100.0	84
33276	91039	83872	20508	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	100.0	84
33276	91039	83872	61207	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	100.0	84
33276	91039	83872	33437	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	100.0	84
33276	79533	83872	47797	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1081	100.0	84
33276	91039	83872	20085	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	100.0	84
33276	79533	93574	31596	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1081	92.0	84
33276	91039	83872	46168	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	100.0	84
33276	91039	83872	24683	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	100.0	84
33276	91039	83872	29392	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	100.0	84
33276	91039	83872	75054	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	100.0	84
33276	79533	93574	29726	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1081	92.0	84
33276	91039	83872	78247	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	100.0	84
33276	91039	83872	92218	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	100.0	84
33276	91039	83872	12974	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	100.0	84
33276	91039	83872	48426	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	100.0	84
33276	91039	83872	99443	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	100.0	84
33276	79533	93574	80966	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1081	92.0	84
33276	79533	93574	27305	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1081	92.0	84
33276	91039	83872	72115	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	100.0	84
33276	79533	93574	55442	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1081	92.0	84
33276	79533	93574	65067	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1081	92.0	84
33276	91039	83872	68177	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	100.0	84
33276	91039	83872	12815	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	100.0	84
33276	91039	83872	48209	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	100.0	84
33276	91039	83872	34780	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	100.0	84
33276	91039	83872	18250	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	100.0	84
33276	91039	83872	12888	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	100.0	84
33276	91039	83872	40451	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	100.0	84
33276	91039	83872	78107	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	100.0	84
33276	79533	93574	54024	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1081	92.0	84
33276	91039	83872	85851	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	100.0	84
33276	79533	93574	54930	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1081	92.0	84
33276	91039	83872	95951	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	100.0	84
33276	91039	83872	94679	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	100.0	84
33276	91039	83872	52769	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	100.0	84
33276	91039	83872	73720	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	100.0	84
33276	79533	83872	87772	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1081	100.0	84
33276	79533	83872	97274	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1081	100.0	84
33276	79533	93574	79489	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1081	92.0	84
33276	79533	93574	81888	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1081	92.0	84
33276	91039	83872	68360	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	100.0	84
33276	91039	83872	70031	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	100.0	84
33276	91039	83872	49856	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	100.0	84
33276	79533	83872	84350	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1081	100.0	84
33276	79533	93574	27295	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1081	92.0	84
33276	79533	93574	50172	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1081	92.0	84
33276	79533	93574	32509	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1081	92.0	84
33276	79533	93574	44079	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1081	92.0	84
33276	79533	93574	39724	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1081	92.0	84
33276	79533	93574	73470	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1081	92.0	84
33276	91039	83872	58745	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	100.0	84
33276	91039	83872	47767	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	100.0	84
33276	79533	83872	16202	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1081	100.0	84
33276	79533	93574	29443	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1081	92.0	84
33276	79533	93574	56284	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1081	92.0	84
33276	79533	93574	91085	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1081	92.0	84
33276	79533	93574	31075	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1081	92.0	84
33276	79533	93574	80165	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1081	92.0	84
33276	79533	93574	47387	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1081	92.0	84
33276	79533	93574	32984	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1081	92.0	84
33276	79533	93574	97340	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1081	92.0	84
33276	79533	93574	30117	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1081	92.0	84
33276	91039	83872	31135	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	100.0	84
33276	91039	83872	41182	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	100.0	84
33276	91039	83872	25324	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	100.0	84
33276	91039	83872	15393	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	100.0	84
33276	79533	93574	51500	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1081	92.0	84
33276	79533	93574	85304	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1081	92.0	84
33276	79533	93574	26577	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1081	92.0	84
33276	79533	83872	67788	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1081	100.0	84
33276	79533	83872	44132	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1081	100.0	84
33276	79533	83872	58453	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1081	100.0	84
33276	79533	83872	34182	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1081	100.0	84
33276	79533	83872	36890	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1081	100.0	84
33276	79533	83872	83726	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1081	100.0	84
33276	79533	83872	14546	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1081	100.0	84
33276	79533	83872	97235	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1081	100.0	84
33276	79533	83872	51542	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1081	100.0	84
33276	79533	83872	55068	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1081	100.0	84
33276	79533	83872	29391	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1081	100.0	84
33276	79533	83872	58878	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1081	100.0	84
33276	79533	83872	68776	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1081	100.0	84
33276	91039	83872	80761	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	100.0	84
33276	91039	83872	31311	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	100.0	84
33276	79533	93574	79945	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1081	92.0	84
33276	79533	83872	49526	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1081	100.0	84
33276	91039	83872	25923	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	100.0	84
33276	91039	83872	13266	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	100.0	84
33276	91039	83872	63026	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	100.0	84
33276	91039	83872	75459	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	100.0	84
33276	91039	83872	29055	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	100.0	84
33276	91039	83872	51971	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	100.0	84
33276	91039	83872	30454	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	100.0	84
33276	91039	83872	10562	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	100.0	84
33276	91039	83872	81584	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	100.0	84
33276	91039	83872	53421	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	100.0	84
33276	91039	83872	94835	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	100.0	84
33276	79533	83872	48739	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1081	100.0	84
33276	91039	83872	72116	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	100.0	84
33276	91039	83872	47988	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	100.0	84
33276	91039	83872	85199	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	100.0	84
33276	91039	83872	29278	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	100.0	84
33276	91039	83872	84086	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	100.0	84
33276	91039	83872	67947	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	100.0	84
33276	91039	83872	54392	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	100.0	84
33276	91039	83872	24721	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	100.0	84
33276	91039	83872	15253	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	100.0	84
33276	91039	83872	28274	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	100.0	84
33276	91039	83872	98867	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	100.0	84
33276	91039	83872	82215	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	100.0	84
33276	91039	83872	25319	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	100.0	84
33276	91039	83872	50380	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	100.0	84
33276	91039	83872	13250	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	100.0	84
33276	91039	83872	62642	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	100.0	84
33276	91039	83872	90939	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	100.0	84
33276	91039	83872	38883	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	100.0	84
33276	91039	83872	68454	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	100.0	84
72204	36945	89098	56844	9.0/10	5.5/10	6.0/10	6.3/10	8.1/10	1016	89.0	85
72204	36945	89098	22121	9.0/10	5.5/10	6.0/10	6.3/10	8.1/10	1016	89.0	85
86923	27875	43244	52777	9.0/10	6.1/10	4.8/10	6.7/10	6.4/10	847	39.0	86
86923	27875	43244	17213	9.0/10	6.1/10	4.8/10	6.7/10	6.4/10	847	39.0	86
86923	27875	43244	89711	9.0/10	6.1/10	4.8/10	6.7/10	6.4/10	847	39.0	86
86923	27875	43244	35578	9.0/10	6.1/10	4.8/10	6.7/10	6.4/10	847	39.0	86
86923	27875	43244	86471	9.0/10	6.1/10	4.8/10	6.7/10	6.4/10	847	39.0	86
86923	76476	43244	79000	9.0/10	6.1/10	4.8/10	6.7/10	6.4/10	717	31.0	86
86923	27875	43244	39116	9.0/10	6.1/10	4.8/10	6.7/10	6.4/10	847	39.0	86
86923	27875	43244	46428	9.0/10	6.1/10	4.8/10	6.7/10	6.4/10	847	39.0	86
86923	27875	43244	35652	9.0/10	6.1/10	4.8/10	6.7/10	6.4/10	847	39.0	86
86923	27875	43244	12955	9.0/10	6.1/10	4.8/10	6.7/10	6.4/10	847	39.0	86
86923	27875	43244	20956	9.0/10	6.1/10	4.8/10	6.7/10	6.4/10	847	39.0	86
86923	39035	43244	80570	9.0/10	6.1/10	4.8/10	6.7/10	6.4/10	1068	46.5	86
86923	61248	43244	68387	9.0/10	6.1/10	4.8/10	6.7/10	6.4/10	1085	50.0	86
86923	39035	43244	98744	9.0/10	6.1/10	4.8/10	6.7/10	6.4/10	1068	46.5	86
86923	39035	43244	98022	9.0/10	6.1/10	4.8/10	6.7/10	6.4/10	1068	46.5	86
86923	86269	43244	21452	9.0/10	6.1/10	4.8/10	6.7/10	6.4/10	1150	50.0	86
86923	61248	43244	77081	9.0/10	6.1/10	4.8/10	6.7/10	6.4/10	1085	50.0	86
86923	39035	43244	61697	9.0/10	6.1/10	4.8/10	6.7/10	6.4/10	1068	46.5	86
86923	61248	43244	35486	9.0/10	6.1/10	4.8/10	6.7/10	6.4/10	1085	50.0	86
86923	61248	43244	74286	9.0/10	6.1/10	4.8/10	6.7/10	6.4/10	1085	50.0	86
86923	86269	43244	51649	9.0/10	6.1/10	4.8/10	6.7/10	6.4/10	1150	50.0	86
86923	86269	43244	89058	9.0/10	6.1/10	4.8/10	6.7/10	6.4/10	1150	50.0	86
86923	61248	43244	89308	9.0/10	6.1/10	4.8/10	6.7/10	6.4/10	1085	50.0	86
55843	47989	94837	77050	8.8/10	5.4/10	6.1/10	6.3/10	8.2/10	\N	49.0	87
55843	72126	31134	17346	8.8/10	5.4/10	6.1/10	6.3/10	8.2/10	\N	50.0	87
55843	59992	31134	97394	8.8/10	5.4/10	6.1/10	6.3/10	8.2/10	435	84.5	87
55843	72126	31134	57325	8.8/10	5.4/10	6.1/10	6.3/10	8.2/10	\N	50.0	87
55843	96602	94837	62108	8.8/10	5.4/10	6.1/10	6.3/10	8.2/10	630	99.0	87
55843	47989	94837	66051	8.8/10	5.4/10	6.1/10	6.3/10	8.2/10	\N	49.0	87
55843	59992	31134	58448	8.8/10	5.4/10	6.1/10	6.3/10	8.2/10	435	84.5	87
55121	61248	43244	60608	8.1/10	5.7/10	6.6/10	6.1/10	8.0/10	1085	50.0	88
55121	61248	43244	58867	8.1/10	5.7/10	6.6/10	6.1/10	8.0/10	1085	50.0	88
31432	91338	62354	11597	9.2/10	5.7/10	6.4/10	7.1/10	8.0/10	1073	88.0	89
31432	91338	62354	47309	9.2/10	5.7/10	6.4/10	7.1/10	8.0/10	1073	88.0	89
31432	91338	46167	55209	9.2/10	5.7/10	6.4/10	7.1/10	8.0/10	1073	97.5	89
31432	91338	62354	56052	9.2/10	5.7/10	6.4/10	7.1/10	8.0/10	1073	88.0	89
31432	42943	46167	50381	9.2/10	5.7/10	6.4/10	7.1/10	8.0/10	1133	100.0	89
31432	42943	46167	68402	9.2/10	5.7/10	6.4/10	7.1/10	8.0/10	1133	100.0	89
31432	42943	46167	83535	9.2/10	5.7/10	6.4/10	7.1/10	8.0/10	1133	100.0	89
31432	42943	46167	21481	9.2/10	5.7/10	6.4/10	7.1/10	8.0/10	1133	100.0	89
31432	42943	46167	38271	9.2/10	5.7/10	6.4/10	7.1/10	8.0/10	1133	100.0	89
31432	91338	62354	68224	9.2/10	5.7/10	6.4/10	7.1/10	8.0/10	1073	88.0	89
31432	42943	46167	64474	9.2/10	5.7/10	6.4/10	7.1/10	8.0/10	1133	100.0	89
43903	79533	41938	67999	7.8/10	5.2/10	5.5/10	6.9/10	7.6/10	1081	100.0	90
21847	47989	94837	47831	9.2/10	5.5/10	5.7/10	6.3/10	6.7/10	\N	49.0	91
21847	47989	94837	31468	9.2/10	5.5/10	5.7/10	6.3/10	6.7/10	\N	49.0	91
21847	56884	31134	65552	9.2/10	5.5/10	5.7/10	6.3/10	6.7/10	558	100.0	91
21847	56884	31134	64289	9.2/10	5.5/10	5.7/10	6.3/10	6.7/10	558	100.0	91
21847	56884	31134	28293	9.2/10	5.5/10	5.7/10	6.3/10	6.7/10	558	100.0	91
21847	56884	31134	86962	9.2/10	5.5/10	5.7/10	6.3/10	6.7/10	558	100.0	91
47364	91338	41938	21282	8.8/10	5.8/10	6.7/10	5.8/10	8.0/10	1073	97.5	92
47364	91338	57880	28827	8.8/10	5.8/10	6.7/10	5.8/10	8.0/10	1073	70.5	92
47364	91338	41938	37234	8.8/10	5.8/10	6.7/10	5.8/10	8.0/10	1073	97.5	92
47364	91338	41938	49745	8.8/10	5.8/10	6.7/10	5.8/10	8.0/10	1073	97.5	92
47364	91338	41938	72208	8.8/10	5.8/10	6.7/10	5.8/10	8.0/10	1073	97.5	92
47364	91338	41938	78852	8.8/10	5.8/10	6.7/10	5.8/10	8.0/10	1073	97.5	92
13597	23621	60523	53963	8.6/10	6.0/10	10.0/10	9.9/10	2.2/10	1234	92.0	93
13597	23621	60523	87421	8.6/10	6.0/10	10.0/10	9.9/10	2.2/10	1234	92.0	93
13597	23621	60523	59253	8.6/10	6.0/10	10.0/10	9.9/10	2.2/10	1234	92.0	93
13597	23621	59572	21593	8.6/10	6.0/10	10.0/10	9.9/10	2.2/10	1234	97.5	93
13597	23621	59572	10867	8.6/10	6.0/10	10.0/10	9.9/10	2.2/10	1234	97.5	93
13597	23621	59572	63668	8.6/10	6.0/10	10.0/10	9.9/10	2.2/10	1234	97.5	93
13597	23621	59572	93729	8.6/10	6.0/10	10.0/10	9.9/10	2.2/10	1234	97.5	93
13597	23621	59572	64331	8.6/10	6.0/10	10.0/10	9.9/10	2.2/10	1234	97.5	93
13597	23621	59572	32923	8.6/10	6.0/10	10.0/10	9.9/10	2.2/10	1234	97.5	93
13597	23621	59572	82851	8.6/10	6.0/10	10.0/10	9.9/10	2.2/10	1234	97.5	93
13597	23621	59572	70570	8.6/10	6.0/10	10.0/10	9.9/10	2.2/10	1234	97.5	93
13597	23621	59572	84437	8.6/10	6.0/10	10.0/10	9.9/10	2.2/10	1234	97.5	93
16507	30869	55224	27947	8.3/10	5.6/10	6.0/10	6.9/10	7.9/10	916	99.5	94
16507	30869	55224	36117	8.3/10	5.6/10	6.0/10	6.9/10	7.9/10	916	99.5	94
16507	18936	75951	34380	8.3/10	5.6/10	6.0/10	6.9/10	7.9/10	394	70.0	94
16507	30869	55224	60039	8.3/10	5.6/10	6.0/10	6.9/10	7.9/10	916	99.5	94
16507	78236	48568	47940	8.3/10	5.6/10	6.0/10	6.9/10	7.9/10	536	98.0	94
16507	78236	48568	82596	8.3/10	5.6/10	6.0/10	6.9/10	7.9/10	536	98.0	94
16507	78236	48568	74302	8.3/10	5.6/10	6.0/10	6.9/10	7.9/10	536	98.0	94
16507	78236	48568	15535	8.3/10	5.6/10	6.0/10	6.9/10	7.9/10	536	98.0	94
16507	78236	48568	49582	8.3/10	5.6/10	6.0/10	6.9/10	7.9/10	536	98.0	94
16507	30869	55224	86704	8.3/10	5.6/10	6.0/10	6.9/10	7.9/10	916	99.5	94
16507	78236	48568	74762	8.3/10	5.6/10	6.0/10	6.9/10	7.9/10	536	98.0	94
16507	78236	48568	83306	8.3/10	5.6/10	6.0/10	6.9/10	7.9/10	536	98.0	94
16507	78236	48568	70745	8.3/10	5.6/10	6.0/10	6.9/10	7.9/10	536	98.0	94
16507	30869	55224	39428	8.3/10	5.6/10	6.0/10	6.9/10	7.9/10	916	99.5	94
16507	78236	48568	13517	8.3/10	5.6/10	6.0/10	6.9/10	7.9/10	536	98.0	94
16507	78236	48568	10320	8.3/10	5.6/10	6.0/10	6.9/10	7.9/10	536	98.0	94
16507	34100	31134	30188	8.3/10	5.6/10	6.0/10	6.9/10	7.9/10	596	82.5	94
16507	30869	55224	44429	8.3/10	5.6/10	6.0/10	6.9/10	7.9/10	916	99.5	94
16507	78236	48568	49343	8.3/10	5.6/10	6.0/10	6.9/10	7.9/10	536	98.0	94
16507	78236	48568	93958	8.3/10	5.6/10	6.0/10	6.9/10	7.9/10	536	98.0	94
16507	78236	48568	93435	8.3/10	5.6/10	6.0/10	6.9/10	7.9/10	536	98.0	94
16507	78236	48568	71936	8.3/10	5.6/10	6.0/10	6.9/10	7.9/10	536	98.0	94
16507	78864	31134	26276	8.3/10	5.6/10	6.0/10	6.9/10	7.9/10	366	70.0	94
16507	78236	48568	95696	8.3/10	5.6/10	6.0/10	6.9/10	7.9/10	536	98.0	94
16507	78236	48568	97282	8.3/10	5.6/10	6.0/10	6.9/10	7.9/10	536	98.0	94
16507	78236	48568	64677	8.3/10	5.6/10	6.0/10	6.9/10	7.9/10	536	98.0	94
16507	53365	94837	33510	8.3/10	5.6/10	6.0/10	6.9/10	7.9/10	\N	49.0	94
16507	78236	48568	74472	8.3/10	5.6/10	6.0/10	6.9/10	7.9/10	536	98.0	94
16507	78236	48568	94513	8.3/10	5.6/10	6.0/10	6.9/10	7.9/10	536	98.0	94
16507	78236	48568	42079	8.3/10	5.6/10	6.0/10	6.9/10	7.9/10	536	98.0	94
16507	78236	48568	13728	8.3/10	5.6/10	6.0/10	6.9/10	7.9/10	536	98.0	94
16507	78236	48568	25644	8.3/10	5.6/10	6.0/10	6.9/10	7.9/10	536	98.0	94
16507	78864	31134	46335	8.3/10	5.6/10	6.0/10	6.9/10	7.9/10	366	70.0	94
16507	78864	31134	74625	8.3/10	5.6/10	6.0/10	6.9/10	7.9/10	366	70.0	94
16507	78864	31134	18745	8.3/10	5.6/10	6.0/10	6.9/10	7.9/10	366	70.0	94
16507	78864	31134	88497	8.3/10	5.6/10	6.0/10	6.9/10	7.9/10	366	70.0	94
16507	78864	31134	57416	8.3/10	5.6/10	6.0/10	6.9/10	7.9/10	366	70.0	94
16507	78864	31134	86161	8.3/10	5.6/10	6.0/10	6.9/10	7.9/10	366	70.0	94
16507	78864	31134	72978	8.3/10	5.6/10	6.0/10	6.9/10	7.9/10	366	70.0	94
16507	78864	31134	84130	8.3/10	5.6/10	6.0/10	6.9/10	7.9/10	366	70.0	94
16507	78236	48568	67156	8.3/10	5.6/10	6.0/10	6.9/10	7.9/10	536	98.0	94
16507	78864	31134	43804	8.3/10	5.6/10	6.0/10	6.9/10	7.9/10	366	70.0	94
16507	78864	31134	92312	8.3/10	5.6/10	6.0/10	6.9/10	7.9/10	366	70.0	94
16507	78236	48568	99903	8.3/10	5.6/10	6.0/10	6.9/10	7.9/10	536	98.0	94
16507	78236	48568	72395	8.3/10	5.6/10	6.0/10	6.9/10	7.9/10	536	98.0	94
16507	78864	31134	25674	8.3/10	5.6/10	6.0/10	6.9/10	7.9/10	366	70.0	94
16507	78864	31134	77177	8.3/10	5.6/10	6.0/10	6.9/10	7.9/10	366	70.0	94
16507	78864	31134	85400	8.3/10	5.6/10	6.0/10	6.9/10	7.9/10	366	70.0	94
16507	78864	31134	12299	8.3/10	5.6/10	6.0/10	6.9/10	7.9/10	366	70.0	94
16507	38830	48568	44018	8.3/10	5.6/10	6.0/10	6.9/10	7.9/10	560	100.0	94
31352	91338	99701	31344	9.0/10	5.4/10	5.3/10	5.2/10	8.1/10	1073	72.5	95
31352	91338	99701	86238	9.0/10	5.4/10	5.3/10	5.2/10	8.1/10	1073	72.5	95
31352	91338	99701	17669	9.0/10	5.4/10	5.3/10	5.2/10	8.1/10	1073	72.5	95
31352	91338	99701	29154	9.0/10	5.4/10	5.3/10	5.2/10	8.1/10	1073	72.5	95
31352	91338	99701	51901	9.0/10	5.4/10	5.3/10	5.2/10	8.1/10	1073	72.5	95
85007	19452	93574	70429	8.4/10	6.0/10	4.8/10	7.1/10	7.4/10	1010	92.0	96
85007	19452	93574	27759	8.4/10	6.0/10	4.8/10	7.1/10	7.4/10	1010	92.0	96
85007	19452	93574	56843	8.4/10	6.0/10	4.8/10	7.1/10	7.4/10	1010	92.0	96
85007	19452	93574	31405	8.4/10	6.0/10	4.8/10	7.1/10	7.4/10	1010	92.0	96
38091	30889	94837	16932	7.4/10	5.3/10	5.6/10	5.2/10	9.2/10	526	96.0	97
38091	30889	94837	45739	7.4/10	5.3/10	5.6/10	5.2/10	9.2/10	526	96.0	97
38091	38830	31134	57338	7.4/10	5.3/10	5.6/10	5.2/10	9.2/10	560	100.0	97
38091	78236	31134	64986	7.4/10	5.3/10	5.6/10	5.2/10	9.2/10	536	98.0	97
38091	18936	94837	93394	7.4/10	5.3/10	5.6/10	5.2/10	9.2/10	394	84.0	97
38091	78236	31134	56659	7.4/10	5.3/10	5.6/10	5.2/10	9.2/10	536	98.0	97
38091	78236	94837	16385	7.4/10	5.3/10	5.6/10	5.2/10	9.2/10	536	97.0	97
38091	78236	31134	47992	7.4/10	5.3/10	5.6/10	5.2/10	9.2/10	536	98.0	97
38091	78236	31134	48228	7.4/10	5.3/10	5.6/10	5.2/10	9.2/10	536	98.0	97
38091	78236	31134	79417	7.4/10	5.3/10	5.6/10	5.2/10	9.2/10	536	98.0	97
39012	25506	70387	93747	9.0/10	5.7/10	5.1/10	6.4/10	8.1/10	729	65.0	98
39012	47070	41886	20069	9.0/10	5.7/10	5.1/10	6.4/10	8.1/10	926	100.0	98
39012	47070	41886	77353	9.0/10	5.7/10	5.1/10	6.4/10	8.1/10	926	100.0	98
39012	47070	41886	35403	9.0/10	5.7/10	5.1/10	6.4/10	8.1/10	926	100.0	98
39012	47070	41886	92317	9.0/10	5.7/10	5.1/10	6.4/10	8.1/10	926	100.0	98
39012	47070	41886	34018	9.0/10	5.7/10	5.1/10	6.4/10	8.1/10	926	100.0	98
39012	47070	41886	88480	9.0/10	5.7/10	5.1/10	6.4/10	8.1/10	926	100.0	98
39012	47070	41886	31906	9.0/10	5.7/10	5.1/10	6.4/10	8.1/10	926	100.0	98
39012	47070	41886	81265	9.0/10	5.7/10	5.1/10	6.4/10	8.1/10	926	100.0	98
39012	25506	99337	51446	9.0/10	5.7/10	5.1/10	6.4/10	8.1/10	729	69.5	98
39012	47070	41886	99780	9.0/10	5.7/10	5.1/10	6.4/10	8.1/10	926	100.0	98
39012	47070	41886	49462	9.0/10	5.7/10	5.1/10	6.4/10	8.1/10	926	100.0	98
39012	47070	41886	45580	9.0/10	5.7/10	5.1/10	6.4/10	8.1/10	926	100.0	98
39012	47070	41886	99842	9.0/10	5.7/10	5.1/10	6.4/10	8.1/10	926	100.0	98
39012	47070	41886	22561	9.0/10	5.7/10	5.1/10	6.4/10	8.1/10	926	100.0	98
39012	47070	41886	80047	9.0/10	5.7/10	5.1/10	6.4/10	8.1/10	926	100.0	98
39012	47070	41886	86027	9.0/10	5.7/10	5.1/10	6.4/10	8.1/10	926	100.0	98
39012	47070	41886	56088	9.0/10	5.7/10	5.1/10	6.4/10	8.1/10	926	100.0	98
39012	47070	41886	11690	9.0/10	5.7/10	5.1/10	6.4/10	8.1/10	926	100.0	98
39012	47070	41886	27950	9.0/10	5.7/10	5.1/10	6.4/10	8.1/10	926	100.0	98
39012	47070	41886	77917	9.0/10	5.7/10	5.1/10	6.4/10	8.1/10	926	100.0	98
39012	47070	41886	46885	9.0/10	5.7/10	5.1/10	6.4/10	8.1/10	926	100.0	98
39012	47070	41886	58891	9.0/10	5.7/10	5.1/10	6.4/10	8.1/10	926	100.0	98
39012	47070	41886	73556	9.0/10	5.7/10	5.1/10	6.4/10	8.1/10	926	100.0	98
39012	47070	41886	54605	9.0/10	5.7/10	5.1/10	6.4/10	8.1/10	926	100.0	98
39012	47070	41886	31368	9.0/10	5.7/10	5.1/10	6.4/10	8.1/10	926	100.0	98
39012	47070	41886	23424	9.0/10	5.7/10	5.1/10	6.4/10	8.1/10	926	100.0	98
39012	47070	41886	38557	9.0/10	5.7/10	5.1/10	6.4/10	8.1/10	926	100.0	98
39012	47070	41886	75979	9.0/10	5.7/10	5.1/10	6.4/10	8.1/10	926	100.0	98
39012	47070	41886	38981	9.0/10	5.7/10	5.1/10	6.4/10	8.1/10	926	100.0	98
39012	47070	41886	34696	9.0/10	5.7/10	5.1/10	6.4/10	8.1/10	926	100.0	98
39012	25506	54520	83224	9.0/10	5.7/10	5.1/10	6.4/10	8.1/10	729	82.5	98
39012	47070	41886	90403	9.0/10	5.7/10	5.1/10	6.4/10	8.1/10	926	100.0	98
39012	47070	41886	78898	9.0/10	5.7/10	5.1/10	6.4/10	8.1/10	926	100.0	98
39012	47070	41886	79742	9.0/10	5.7/10	5.1/10	6.4/10	8.1/10	926	100.0	98
39012	47070	54520	82235	9.0/10	5.7/10	5.1/10	6.4/10	8.1/10	926	93.0	98
39012	47070	41886	24937	9.0/10	5.7/10	5.1/10	6.4/10	8.1/10	926	100.0	98
39012	47070	41886	64702	9.0/10	5.7/10	5.1/10	6.4/10	8.1/10	926	100.0	98
39012	47070	41886	70357	9.0/10	5.7/10	5.1/10	6.4/10	8.1/10	926	100.0	98
39012	47070	41886	20013	9.0/10	5.7/10	5.1/10	6.4/10	8.1/10	926	100.0	98
39012	47070	41886	25278	9.0/10	5.7/10	5.1/10	6.4/10	8.1/10	926	100.0	98
39012	47070	41886	27200	9.0/10	5.7/10	5.1/10	6.4/10	8.1/10	926	100.0	98
39012	47070	41886	12277	9.0/10	5.7/10	5.1/10	6.4/10	8.1/10	926	100.0	98
39012	47070	41886	72851	9.0/10	5.7/10	5.1/10	6.4/10	8.1/10	926	100.0	98
39012	47070	41886	55640	9.0/10	5.7/10	5.1/10	6.4/10	8.1/10	926	100.0	98
39012	47070	41886	57522	9.0/10	5.7/10	5.1/10	6.4/10	8.1/10	926	100.0	98
39012	47070	41886	28220	9.0/10	5.7/10	5.1/10	6.4/10	8.1/10	926	100.0	98
39012	47070	41886	67925	9.0/10	5.7/10	5.1/10	6.4/10	8.1/10	926	100.0	98
94853	39563	85842	88335	8.1/10	6.3/10	10.0/10	9.9/10	3.4/10	582	95.5	99
94853	39563	85842	54832	8.1/10	6.3/10	10.0/10	9.9/10	3.4/10	582	95.5	99
94853	50980	85842	32571	8.1/10	6.3/10	10.0/10	9.9/10	3.4/10	637	100.0	99
39505	23911	94837	49935	8.3/10	5.6/10	6.1/10	7.2/10	7.6/10	\N	49.0	100
39505	56884	31134	13769	8.3/10	5.6/10	6.1/10	7.2/10	7.6/10	558	100.0	100
83752	76967	52476	43792	8.6/10	7.7/10	10.0/10	9.9/10	7.2/10	1480	36.0	1
83752	76967	52476	18854	8.6/10	7.7/10	10.0/10	9.9/10	7.2/10	1480	36.0	1
83752	76967	52476	60157	8.6/10	7.7/10	10.0/10	9.9/10	7.2/10	1480	36.0	1
83752	76967	52476	38885	8.6/10	7.7/10	10.0/10	9.9/10	7.2/10	1480	36.0	1
83752	41142	95003	98724	8.6/10	7.7/10	10.0/10	9.9/10	7.2/10	1759	43.0	1
83752	41142	95003	40137	8.6/10	7.7/10	10.0/10	9.9/10	7.2/10	1759	43.0	1
83752	41142	95003	51383	8.6/10	7.7/10	10.0/10	9.9/10	7.2/10	1759	43.0	1
83752	41142	95003	64057	8.6/10	7.7/10	10.0/10	9.9/10	7.2/10	1759	43.0	1
83752	76967	52476	56281	8.6/10	7.7/10	10.0/10	9.9/10	7.2/10	1480	36.0	1
83752	76967	52476	77699	8.6/10	7.7/10	10.0/10	9.9/10	7.2/10	1480	36.0	1
83752	41142	95003	80208	8.6/10	7.7/10	10.0/10	9.9/10	7.2/10	1759	43.0	1
83752	97096	78337	11274	8.6/10	7.7/10	10.0/10	9.9/10	7.2/10	\N	0.0	1
83752	97096	78337	44517	8.6/10	7.7/10	10.0/10	9.9/10	7.2/10	\N	0.0	1
83752	97096	78337	42539	8.6/10	7.7/10	10.0/10	9.9/10	7.2/10	\N	0.0	1
83752	97096	78337	47655	8.6/10	7.7/10	10.0/10	9.9/10	7.2/10	\N	0.0	1
83752	47701	23529	22190	8.6/10	7.7/10	10.0/10	9.9/10	7.2/10	2042	50.0	1
23237	41142	95003	62288	8.1/10	7.7/10	10.0/10	9.9/10	7.2/10	1759	43.0	2
23237	41142	95003	98302	8.1/10	7.7/10	10.0/10	9.9/10	7.2/10	1759	43.0	2
23237	41142	95003	54825	8.1/10	7.7/10	10.0/10	9.9/10	7.2/10	1759	43.0	2
23237	41142	95003	19965	8.1/10	7.7/10	10.0/10	9.9/10	7.2/10	1759	43.0	2
23237	41142	95003	82686	8.1/10	7.7/10	10.0/10	9.9/10	7.2/10	1759	43.0	2
23237	41142	95003	33394	8.1/10	7.7/10	10.0/10	9.9/10	7.2/10	1759	43.0	2
23237	41142	95003	72463	8.1/10	7.7/10	10.0/10	9.9/10	7.2/10	1759	43.0	2
23237	41142	95003	51139	8.1/10	7.7/10	10.0/10	9.9/10	7.2/10	1759	43.0	2
23237	41142	95003	56338	8.1/10	7.7/10	10.0/10	9.9/10	7.2/10	1759	43.0	2
23237	41142	95003	38647	8.1/10	7.7/10	10.0/10	9.9/10	7.2/10	1759	43.0	2
23237	41142	95003	85197	8.1/10	7.7/10	10.0/10	9.9/10	7.2/10	1759	43.0	2
23237	41142	95003	45268	8.1/10	7.7/10	10.0/10	9.9/10	7.2/10	1759	43.0	2
23237	41142	95003	33957	8.1/10	7.7/10	10.0/10	9.9/10	7.2/10	1759	43.0	2
23237	41142	95003	99536	8.1/10	7.7/10	10.0/10	9.9/10	7.2/10	1759	43.0	2
23237	97096	78337	34925	8.1/10	7.7/10	10.0/10	9.9/10	7.2/10	\N	0.0	2
23237	47701	23529	75404	8.1/10	7.7/10	10.0/10	9.9/10	7.2/10	2042	50.0	2
23237	47701	23529	36170	8.1/10	7.7/10	10.0/10	9.9/10	7.2/10	2042	50.0	2
23237	97096	78337	40783	8.1/10	7.7/10	10.0/10	9.9/10	7.2/10	\N	0.0	2
23237	47701	23529	41726	8.1/10	7.7/10	10.0/10	9.9/10	7.2/10	2042	50.0	2
23237	47701	23529	44787	8.1/10	7.7/10	10.0/10	9.9/10	7.2/10	2042	50.0	2
23237	47701	23529	40042	8.1/10	7.7/10	10.0/10	9.9/10	7.2/10	2042	50.0	2
23237	47701	23529	36577	8.1/10	7.7/10	10.0/10	9.9/10	7.2/10	2042	50.0	2
23237	47701	23529	42728	8.1/10	7.7/10	10.0/10	9.9/10	7.2/10	2042	50.0	2
23237	97096	78337	91080	8.1/10	7.7/10	10.0/10	9.9/10	7.2/10	\N	0.0	2
23237	47701	23529	56665	8.1/10	7.7/10	10.0/10	9.9/10	7.2/10	2042	50.0	2
23237	47701	23529	30446	8.1/10	7.7/10	10.0/10	9.9/10	7.2/10	2042	50.0	2
23237	47701	23529	23983	8.1/10	7.7/10	10.0/10	9.9/10	7.2/10	2042	50.0	2
23237	47701	23529	25712	8.1/10	7.7/10	10.0/10	9.9/10	7.2/10	2042	50.0	2
23237	47701	23529	20287	8.1/10	7.7/10	10.0/10	9.9/10	7.2/10	2042	50.0	2
23237	47701	23529	98580	8.1/10	7.7/10	10.0/10	9.9/10	7.2/10	2042	50.0	2
23237	47701	23529	96956	8.1/10	7.7/10	10.0/10	9.9/10	7.2/10	2042	50.0	2
23237	47701	95003	74574	8.1/10	7.7/10	10.0/10	9.9/10	7.2/10	2042	50.0	2
47498	11699	81349	90455	8.3/10	7.1/10	10.0/10	9.9/10	7.1/10	592	88.0	3
47498	50980	85842	10868	8.3/10	7.1/10	10.0/10	9.9/10	7.1/10	637	100.0	3
47498	99803	85842	80972	8.3/10	7.1/10	10.0/10	9.9/10	7.1/10	615	98.5	3
55071	91338	84732	15539	9.6/10	6.7/10	6.4/10	9.9/10	7.5/10	1073	74.0	4
55071	91338	59613	73214	9.6/10	6.7/10	6.4/10	9.9/10	7.5/10	1073	85.5	4
55071	91338	59613	58653	9.6/10	6.7/10	6.4/10	9.9/10	7.5/10	1073	85.5	4
55071	91338	59613	91352	9.6/10	6.7/10	6.4/10	9.9/10	7.5/10	1073	85.5	4
55071	91338	59369	51342	9.6/10	6.7/10	6.4/10	9.9/10	7.5/10	1073	92.5	4
55071	91338	59613	74532	9.6/10	6.7/10	6.4/10	9.9/10	7.5/10	1073	85.5	4
55071	36619	59613	85303	9.6/10	6.7/10	6.4/10	9.9/10	7.5/10	1003	84.5	4
55071	42943	32786	46009	9.6/10	6.7/10	6.4/10	9.9/10	7.5/10	1133	100.0	4
55071	42943	32786	74330	9.6/10	6.7/10	6.4/10	9.9/10	7.5/10	1133	100.0	4
55071	42943	32786	76995	9.6/10	6.7/10	6.4/10	9.9/10	7.5/10	1133	100.0	4
55071	42943	32786	46735	9.6/10	6.7/10	6.4/10	9.9/10	7.5/10	1133	100.0	4
55071	42943	32786	62150	9.6/10	6.7/10	6.4/10	9.9/10	7.5/10	1133	100.0	4
55071	42943	32786	39110	9.6/10	6.7/10	6.4/10	9.9/10	7.5/10	1133	100.0	4
99901	99701	99801	99201	95.5	88.2	92.1	98.7	85.3	28500	92.25	101
55071	42943	32786	85584	9.6/10	6.7/10	6.4/10	9.9/10	7.5/10	1133	100.0	4
55071	42943	32786	26809	9.6/10	6.7/10	6.4/10	9.9/10	7.5/10	1133	100.0	4
55071	42943	32786	17097	9.6/10	6.7/10	6.4/10	9.9/10	7.5/10	1133	100.0	4
63856	39563	85842	78909	8.4/10	7.0/10	10.0/10	9.9/10	6.2/10	582	95.5	5
63856	50980	85842	65466	8.4/10	7.0/10	10.0/10	9.9/10	6.2/10	637	100.0	5
44620	35751	39215	72694	8.6/10	7.7/10	10.0/10	9.9/10	5.2/10	1373	43.5	6
44620	81645	77720	80879	8.6/10	7.7/10	10.0/10	9.9/10	5.2/10	1075	34.0	6
44620	81645	77720	14268	8.6/10	7.7/10	10.0/10	9.9/10	5.2/10	1075	34.0	6
44620	35751	39215	75860	8.6/10	7.7/10	10.0/10	9.9/10	5.2/10	1373	43.5	6
44620	89087	59326	55519	8.6/10	7.7/10	10.0/10	9.9/10	5.2/10	1572	50.0	6
44620	89087	59326	61605	8.6/10	7.7/10	10.0/10	9.9/10	5.2/10	1572	50.0	6
44620	89087	59326	99959	8.6/10	7.7/10	10.0/10	9.9/10	5.2/10	1572	50.0	6
44620	89087	59326	32911	8.6/10	7.7/10	10.0/10	9.9/10	5.2/10	1572	50.0	6
44620	35751	39215	69925	8.6/10	7.7/10	10.0/10	9.9/10	5.2/10	1373	43.5	6
44620	35751	39215	25776	8.6/10	7.7/10	10.0/10	9.9/10	5.2/10	1373	43.5	6
44620	35751	39215	77922	8.6/10	7.7/10	10.0/10	9.9/10	5.2/10	1373	43.5	6
60206	99477	56255	70302	9.6/10	5.5/10	5.2/10	9.9/10	8.1/10	847	57.5	7
60206	99477	56255	51373	9.6/10	5.5/10	5.2/10	9.9/10	8.1/10	847	57.5	7
60206	91338	57880	11103	9.6/10	5.5/10	5.2/10	9.9/10	8.1/10	1073	70.5	7
60206	91338	57880	11549	9.6/10	5.5/10	5.2/10	9.9/10	8.1/10	1073	70.5	7
60206	91338	77681	98356	9.6/10	5.5/10	5.2/10	9.9/10	8.1/10	1073	97.5	7
60206	91338	77681	37623	9.6/10	5.5/10	5.2/10	9.9/10	8.1/10	1073	97.5	7
60206	91338	77681	59732	9.6/10	5.5/10	5.2/10	9.9/10	8.1/10	1073	97.5	7
60206	91338	77681	86153	9.6/10	5.5/10	5.2/10	9.9/10	8.1/10	1073	97.5	7
60206	91338	77681	23205	9.6/10	5.5/10	5.2/10	9.9/10	8.1/10	1073	97.5	7
60206	91338	77681	52655	9.6/10	5.5/10	5.2/10	9.9/10	8.1/10	1073	97.5	7
60206	91338	77681	57395	9.6/10	5.5/10	5.2/10	9.9/10	8.1/10	1073	97.5	7
60206	91338	77681	90318	9.6/10	5.5/10	5.2/10	9.9/10	8.1/10	1073	97.5	7
60206	91338	77681	44039	9.6/10	5.5/10	5.2/10	9.9/10	8.1/10	1073	97.5	7
60206	91338	77681	81901	9.6/10	5.5/10	5.2/10	9.9/10	8.1/10	1073	97.5	7
60206	91338	77681	44452	9.6/10	5.5/10	5.2/10	9.9/10	8.1/10	1073	97.5	7
60206	91338	77681	41082	9.6/10	5.5/10	5.2/10	9.9/10	8.1/10	1073	97.5	7
60206	91338	77681	45311	9.6/10	5.5/10	5.2/10	9.9/10	8.1/10	1073	97.5	7
60206	91338	77681	71780	9.6/10	5.5/10	5.2/10	9.9/10	8.1/10	1073	97.5	7
60206	91338	77681	90358	9.6/10	5.5/10	5.2/10	9.9/10	8.1/10	1073	97.5	7
60206	91338	77681	54970	9.6/10	5.5/10	5.2/10	9.9/10	8.1/10	1073	97.5	7
60206	91338	77681	57962	9.6/10	5.5/10	5.2/10	9.9/10	8.1/10	1073	97.5	7
60206	91338	77681	34105	9.6/10	5.5/10	5.2/10	9.9/10	8.1/10	1073	97.5	7
60206	36619	77681	75374	9.6/10	5.5/10	5.2/10	9.9/10	8.1/10	1003	96.5	7
60206	91338	77681	65567	9.6/10	5.5/10	5.2/10	9.9/10	8.1/10	1073	97.5	7
99902	99702	99802	99202	92.8	94.5	89.3	95.2	82.7	22400	63.75	102
60206	91338	77681	37594	9.6/10	5.5/10	5.2/10	9.9/10	8.1/10	1073	97.5	7
60206	91338	77681	64931	9.6/10	5.5/10	5.2/10	9.9/10	8.1/10	1073	97.5	7
60206	91338	77681	58799	9.6/10	5.5/10	5.2/10	9.9/10	8.1/10	1073	97.5	7
60206	91338	77681	57851	9.6/10	5.5/10	5.2/10	9.9/10	8.1/10	1073	97.5	7
60206	91338	77681	62506	9.6/10	5.5/10	5.2/10	9.9/10	8.1/10	1073	97.5	7
60206	91338	77681	46651	9.6/10	5.5/10	5.2/10	9.9/10	8.1/10	1073	97.5	7
60206	91338	77681	69077	9.6/10	5.5/10	5.2/10	9.9/10	8.1/10	1073	97.5	7
60206	91338	77681	33578	9.6/10	5.5/10	5.2/10	9.9/10	8.1/10	1073	97.5	7
60206	99477	56255	84895	9.6/10	5.5/10	5.2/10	9.9/10	8.1/10	847	57.5	7
60206	91338	77681	27188	9.6/10	5.5/10	5.2/10	9.9/10	8.1/10	1073	97.5	7
60206	91338	77681	85483	9.6/10	5.5/10	5.2/10	9.9/10	8.1/10	1073	97.5	7
60206	33255	77681	99916	9.6/10	5.5/10	5.2/10	9.9/10	8.1/10	758	83.5	7
60206	91338	77681	39958	9.6/10	5.5/10	5.2/10	9.9/10	8.1/10	1073	97.5	7
60206	36619	57880	23090	9.6/10	5.5/10	5.2/10	9.9/10	8.1/10	1003	69.5	7
60206	36619	77681	40907	9.6/10	5.5/10	5.2/10	9.9/10	8.1/10	1003	96.5	7
60206	99477	77681	82789	9.6/10	5.5/10	5.2/10	9.9/10	8.1/10	847	87.5	7
60206	91338	77681	66651	9.6/10	5.5/10	5.2/10	9.9/10	8.1/10	1073	97.5	7
60206	42943	57880	59923	9.6/10	5.5/10	5.2/10	9.9/10	8.1/10	1133	73.0	7
60206	33255	77681	35698	9.6/10	5.5/10	5.2/10	9.9/10	8.1/10	758	83.5	7
60206	91338	77681	29116	9.6/10	5.5/10	5.2/10	9.9/10	8.1/10	1073	97.5	7
60206	91338	77681	29601	9.6/10	5.5/10	5.2/10	9.9/10	8.1/10	1073	97.5	7
60206	36619	77681	71995	9.6/10	5.5/10	5.2/10	9.9/10	8.1/10	1003	96.5	7
60206	91338	77681	11276	9.6/10	5.5/10	5.2/10	9.9/10	8.1/10	1073	97.5	7
60206	36619	77681	33148	9.6/10	5.5/10	5.2/10	9.9/10	8.1/10	1003	96.5	7
60206	91338	77681	65249	9.6/10	5.5/10	5.2/10	9.9/10	8.1/10	1073	97.5	7
60206	42943	57880	75483	9.6/10	5.5/10	5.2/10	9.9/10	8.1/10	1133	73.0	7
60206	36619	77681	27625	9.6/10	5.5/10	5.2/10	9.9/10	8.1/10	1003	96.5	7
60206	91338	77681	92660	9.6/10	5.5/10	5.2/10	9.9/10	8.1/10	1073	97.5	7
60206	36619	77681	77765	9.6/10	5.5/10	5.2/10	9.9/10	8.1/10	1003	96.5	7
60206	91338	77681	79990	9.6/10	5.5/10	5.2/10	9.9/10	8.1/10	1073	97.5	7
95824	34507	73813	73782	9.0/10	5.7/10	5.5/10	9.7/10	8.2/10	795	92.0	8
73646	25643	67658	49326	9.0/10	5.8/10	5.4/10	9.7/10	8.9/10	1235	81.5	9
73646	77350	67658	42895	9.0/10	5.8/10	5.4/10	9.7/10	8.9/10	1809	97.5	9
73646	77350	28214	83680	9.0/10	5.8/10	5.4/10	9.7/10	8.9/10	1809	100.0	9
73646	59440	67658	84427	9.0/10	5.8/10	5.4/10	9.7/10	8.9/10	2231	96.0	9
73646	59440	28214	16253	9.0/10	5.8/10	5.4/10	9.7/10	8.9/10	2231	98.5	9
73646	59440	75776	62219	9.0/10	5.8/10	5.4/10	9.7/10	8.9/10	2231	87.0	9
73646	59440	28214	22972	9.0/10	5.8/10	5.4/10	9.7/10	8.9/10	2231	98.5	9
84976	59440	10864	31409	8.6/10	7.1/10	10.0/10	9.9/10	6.0/10	2231	94.5	10
89817	91338	57880	95179	8.4/10	6.1/10	10.0/10	9.9/10	5.7/10	1073	70.5	11
84976	59440	10864	17869	8.6/10	7.1/10	10.0/10	9.9/10	6.0/10	2231	94.5	10
84976	59440	10864	38241	8.6/10	7.1/10	10.0/10	9.9/10	6.0/10	2231	94.5	10
84976	59440	10864	72460	8.6/10	7.1/10	10.0/10	9.9/10	6.0/10	2231	94.5	10
84976	59440	10864	92557	8.6/10	7.1/10	10.0/10	9.9/10	6.0/10	2231	94.5	10
84976	59440	10864	68963	8.6/10	7.1/10	10.0/10	9.9/10	6.0/10	2231	94.5	10
84976	59440	10864	53864	8.6/10	7.1/10	10.0/10	9.9/10	6.0/10	2231	94.5	10
84976	59440	10864	44048	8.6/10	7.1/10	10.0/10	9.9/10	6.0/10	2231	94.5	10
84976	59440	10864	57312	8.6/10	7.1/10	10.0/10	9.9/10	6.0/10	2231	94.5	10
84976	59440	40145	57226	8.6/10	7.1/10	10.0/10	9.9/10	6.0/10	2231	98.5	10
84976	59440	40145	83446	8.6/10	7.1/10	10.0/10	9.9/10	6.0/10	2231	98.5	10
84976	59440	10864	83071	8.6/10	7.1/10	10.0/10	9.9/10	6.0/10	2231	94.5	10
84976	59440	10864	43779	8.6/10	7.1/10	10.0/10	9.9/10	6.0/10	2231	94.5	10
84976	59440	10864	55107	8.6/10	7.1/10	10.0/10	9.9/10	6.0/10	2231	94.5	10
84976	59440	10864	12599	8.6/10	7.1/10	10.0/10	9.9/10	6.0/10	2231	94.5	10
84976	59440	10864	63970	8.6/10	7.1/10	10.0/10	9.9/10	6.0/10	2231	94.5	10
84976	59440	10864	25890	8.6/10	7.1/10	10.0/10	9.9/10	6.0/10	2231	94.5	10
84976	59440	10864	56018	8.6/10	7.1/10	10.0/10	9.9/10	6.0/10	2231	94.5	10
89817	91338	57880	99074	8.4/10	6.1/10	10.0/10	9.9/10	5.7/10	1073	70.5	11
89817	91338	57880	89374	8.4/10	6.1/10	10.0/10	9.9/10	5.7/10	1073	70.5	11
89817	15326	94341	36077	8.4/10	6.1/10	10.0/10	9.9/10	5.7/10	1593	84.5	11
89817	91338	57880	85609	8.4/10	6.1/10	10.0/10	9.9/10	5.7/10	1073	70.5	11
89817	46583	94341	95082	8.4/10	6.1/10	10.0/10	9.9/10	5.7/10	2308	100.0	11
89817	46583	94341	80574	8.4/10	6.1/10	10.0/10	9.9/10	5.7/10	2308	100.0	11
89817	46583	94341	32877	8.4/10	6.1/10	10.0/10	9.9/10	5.7/10	2308	100.0	11
89817	46583	94341	47304	8.4/10	6.1/10	10.0/10	9.9/10	5.7/10	2308	100.0	11
89817	46583	94341	56544	8.4/10	6.1/10	10.0/10	9.9/10	5.7/10	2308	100.0	11
89817	46583	94341	52610	8.4/10	6.1/10	10.0/10	9.9/10	5.7/10	2308	100.0	11
89817	15326	94341	98236	8.4/10	6.1/10	10.0/10	9.9/10	5.7/10	1593	84.5	11
89817	46583	94341	76904	8.4/10	6.1/10	10.0/10	9.9/10	5.7/10	2308	100.0	11
89817	91338	57880	73896	8.4/10	6.1/10	10.0/10	9.9/10	5.7/10	1073	70.5	11
89817	42943	57880	68580	8.4/10	6.1/10	10.0/10	9.9/10	5.7/10	1133	73.0	11
89817	42943	57880	20277	8.4/10	6.1/10	10.0/10	9.9/10	5.7/10	1133	73.0	11
89817	42943	57880	59947	8.4/10	6.1/10	10.0/10	9.9/10	5.7/10	1133	73.0	11
89817	42943	57880	90434	8.4/10	6.1/10	10.0/10	9.9/10	5.7/10	1133	73.0	11
89817	42943	57880	47555	8.4/10	6.1/10	10.0/10	9.9/10	5.7/10	1133	73.0	11
72003	39563	85842	70784	8.4/10	6.1/10	10.0/10	9.9/10	5.6/10	582	95.5	12
72003	39563	85842	92799	8.4/10	6.1/10	10.0/10	9.9/10	5.6/10	582	95.5	12
72003	39563	85842	28985	8.4/10	6.1/10	10.0/10	9.9/10	5.6/10	582	95.5	12
72003	39563	85842	31964	8.4/10	6.1/10	10.0/10	9.9/10	5.6/10	582	95.5	12
72003	39563	85842	93962	8.4/10	6.1/10	10.0/10	9.9/10	5.6/10	582	95.5	12
72003	39563	85842	54222	8.4/10	6.1/10	10.0/10	9.9/10	5.6/10	582	95.5	12
72003	39563	85842	65288	8.4/10	6.1/10	10.0/10	9.9/10	5.6/10	582	95.5	12
72003	39563	85842	92742	8.4/10	6.1/10	10.0/10	9.9/10	5.6/10	582	95.5	12
72003	39563	85842	90256	8.4/10	6.1/10	10.0/10	9.9/10	5.6/10	582	95.5	12
72003	39563	85842	84925	8.4/10	6.1/10	10.0/10	9.9/10	5.6/10	582	95.5	12
72003	43425	85842	63054	8.4/10	6.1/10	10.0/10	9.9/10	5.6/10	628	99.5	12
72003	43425	85842	19351	8.4/10	6.1/10	10.0/10	9.9/10	5.6/10	628	99.5	12
72003	43425	85842	20369	8.4/10	6.1/10	10.0/10	9.9/10	5.6/10	628	99.5	12
72003	43425	85842	31233	8.4/10	6.1/10	10.0/10	9.9/10	5.6/10	628	99.5	12
72003	43425	85842	55039	8.4/10	6.1/10	10.0/10	9.9/10	5.6/10	628	99.5	12
72003	43425	85842	39912	8.4/10	6.1/10	10.0/10	9.9/10	5.6/10	628	99.5	12
32570	39563	85842	51088	9.0/10	6.1/10	10.0/10	9.9/10	5.5/10	582	95.5	13
32570	39563	85842	51533	9.0/10	6.1/10	10.0/10	9.9/10	5.5/10	582	95.5	13
32570	39563	85842	95591	9.0/10	6.1/10	10.0/10	9.9/10	5.5/10	582	95.5	13
32570	39563	85842	48188	9.0/10	6.1/10	10.0/10	9.9/10	5.5/10	582	95.5	13
32570	39563	85842	89349	9.0/10	6.1/10	10.0/10	9.9/10	5.5/10	582	95.5	13
32570	39563	85842	94494	9.0/10	6.1/10	10.0/10	9.9/10	5.5/10	582	95.5	13
32570	39563	85842	61833	9.0/10	6.1/10	10.0/10	9.9/10	5.5/10	582	95.5	13
32570	39563	85842	45553	9.0/10	6.1/10	10.0/10	9.9/10	5.5/10	582	95.5	13
32570	39563	85842	68313	9.0/10	6.1/10	10.0/10	9.9/10	5.5/10	582	95.5	13
32570	39563	85842	57600	9.0/10	6.1/10	10.0/10	9.9/10	5.5/10	582	95.5	13
32570	39563	85842	86928	9.0/10	6.1/10	10.0/10	9.9/10	5.5/10	582	95.5	13
32570	39563	85842	78280	9.0/10	6.1/10	10.0/10	9.9/10	5.5/10	582	95.5	13
32570	39563	85842	69020	9.0/10	6.1/10	10.0/10	9.9/10	5.5/10	582	95.5	13
32570	39563	85842	31930	9.0/10	6.1/10	10.0/10	9.9/10	5.5/10	582	95.5	13
32570	39563	85842	34102	9.0/10	6.1/10	10.0/10	9.9/10	5.5/10	582	95.5	13
32570	39563	85842	13027	9.0/10	6.1/10	10.0/10	9.9/10	5.5/10	582	95.5	13
32570	39563	85842	26389	9.0/10	6.1/10	10.0/10	9.9/10	5.5/10	582	95.5	13
46099	91338	57880	40753	8.1/10	6.2/10	10.0/10	9.9/10	5.6/10	1073	70.5	14
46099	36619	56255	42983	8.1/10	6.2/10	10.0/10	9.9/10	5.6/10	1003	66.5	14
46099	99477	56255	37600	8.1/10	6.2/10	10.0/10	9.9/10	5.6/10	847	57.5	14
46099	36619	57880	31877	8.1/10	6.2/10	10.0/10	9.9/10	5.6/10	1003	69.5	14
46099	91338	56255	62041	8.1/10	6.2/10	10.0/10	9.9/10	5.6/10	1073	67.5	14
46099	91338	57880	23501	8.1/10	6.2/10	10.0/10	9.9/10	5.6/10	1073	70.5	14
46099	36619	57880	22524	8.1/10	6.2/10	10.0/10	9.9/10	5.6/10	1003	69.5	14
46099	36619	57880	18361	8.1/10	6.2/10	10.0/10	9.9/10	5.6/10	1003	69.5	14
62818	59440	10864	81884	8.6/10	7.5/10	10.0/10	9.9/10	5.8/10	2231	94.5	15
62818	59440	10864	17055	8.6/10	7.5/10	10.0/10	9.9/10	5.8/10	2231	94.5	15
62818	59440	40145	13455	8.6/10	7.5/10	10.0/10	9.9/10	5.8/10	2231	98.5	15
62818	59440	40145	62037	8.6/10	7.5/10	10.0/10	9.9/10	5.8/10	2231	98.5	15
62818	59440	40145	78679	8.6/10	7.5/10	10.0/10	9.9/10	5.8/10	2231	98.5	15
62818	59440	40145	20911	8.6/10	7.5/10	10.0/10	9.9/10	5.8/10	2231	98.5	15
62818	59440	40145	23622	8.6/10	7.5/10	10.0/10	9.9/10	5.8/10	2231	98.5	15
62818	59440	40145	44400	8.6/10	7.5/10	10.0/10	9.9/10	5.8/10	2231	98.5	15
28855	56934	73113	91015	7.9/10	5.8/10	5.5/10	9.9/10	8.0/10	\N	0.0	16
28855	56934	73113	30352	7.9/10	5.8/10	5.5/10	9.9/10	8.0/10	\N	0.0	16
28855	56934	73113	21050	7.9/10	5.8/10	5.5/10	9.9/10	8.0/10	\N	0.0	16
28855	56934	73113	95830	7.9/10	5.8/10	5.5/10	9.9/10	8.0/10	\N	0.0	16
28855	56934	73113	61097	7.9/10	5.8/10	5.5/10	9.9/10	8.0/10	\N	0.0	16
28855	56934	73113	50549	7.9/10	5.8/10	5.5/10	9.9/10	8.0/10	\N	0.0	16
99903	99703	99803	99203	88.9	86.7	85.4	91.8	84.1	19800	58.849998474121094	103
28855	56934	73113	40062	7.9/10	5.8/10	5.5/10	9.9/10	8.0/10	\N	0.0	16
28855	56934	73113	42426	7.9/10	5.8/10	5.5/10	9.9/10	8.0/10	\N	0.0	16
28855	56934	73113	47247	7.9/10	5.8/10	5.5/10	9.9/10	8.0/10	\N	0.0	16
28855	56934	73113	68085	7.9/10	5.8/10	5.5/10	9.9/10	8.0/10	\N	0.0	16
28855	56934	73113	92114	7.9/10	5.8/10	5.5/10	9.9/10	8.0/10	\N	0.0	16
28855	56934	73113	26569	7.9/10	5.8/10	5.5/10	9.9/10	8.0/10	\N	0.0	16
28855	56934	73113	27206	7.9/10	5.8/10	5.5/10	9.9/10	8.0/10	\N	0.0	16
28855	56934	73113	79041	7.9/10	5.8/10	5.5/10	9.9/10	8.0/10	\N	0.0	16
91034	59440	28214	32361	8.6/10	5.8/10	5.6/10	9.5/10	8.9/10	2231	98.5	17
91034	59440	10864	13744	8.6/10	5.8/10	5.6/10	9.5/10	8.9/10	2231	94.5	17
91034	59440	10864	14607	8.6/10	5.8/10	5.6/10	9.5/10	8.9/10	2231	94.5	17
91034	59440	10864	96972	8.6/10	5.8/10	5.6/10	9.5/10	8.9/10	2231	94.5	17
91034	59440	10864	56771	8.6/10	5.8/10	5.6/10	9.5/10	8.9/10	2231	94.5	17
91034	59440	10864	52624	8.6/10	5.8/10	5.6/10	9.5/10	8.9/10	2231	94.5	17
91034	59440	10864	72410	8.6/10	5.8/10	5.6/10	9.5/10	8.9/10	2231	94.5	17
91034	59440	10864	71235	8.6/10	5.8/10	5.6/10	9.5/10	8.9/10	2231	94.5	17
91034	59440	10864	45705	8.6/10	5.8/10	5.6/10	9.5/10	8.9/10	2231	94.5	17
91034	59440	10864	81898	8.6/10	5.8/10	5.6/10	9.5/10	8.9/10	2231	94.5	17
91034	59440	10864	68306	8.6/10	5.8/10	5.6/10	9.5/10	8.9/10	2231	94.5	17
91034	59440	10864	27709	8.6/10	5.8/10	5.6/10	9.5/10	8.9/10	2231	94.5	17
69827	47070	12440	73225	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
91034	59440	10864	33204	8.6/10	5.8/10	5.6/10	9.5/10	8.9/10	2231	94.5	17
91034	59440	10864	87441	8.6/10	5.8/10	5.6/10	9.5/10	8.9/10	2231	94.5	17
91034	59440	10864	88326	8.6/10	5.8/10	5.6/10	9.5/10	8.9/10	2231	94.5	17
91034	59440	10864	69840	8.6/10	5.8/10	5.6/10	9.5/10	8.9/10	2231	94.5	17
91034	59440	10864	92712	8.6/10	5.8/10	5.6/10	9.5/10	8.9/10	2231	94.5	17
91034	59440	10864	93342	8.6/10	5.8/10	5.6/10	9.5/10	8.9/10	2231	94.5	17
91034	59440	10864	83922	8.6/10	5.8/10	5.6/10	9.5/10	8.9/10	2231	94.5	17
91034	59440	10864	67013	8.6/10	5.8/10	5.6/10	9.5/10	8.9/10	2231	94.5	17
91034	59440	10864	78610	8.6/10	5.8/10	5.6/10	9.5/10	8.9/10	2231	94.5	17
91034	59440	10864	93858	8.6/10	5.8/10	5.6/10	9.5/10	8.9/10	2231	94.5	17
91034	59440	10864	93824	8.6/10	5.8/10	5.6/10	9.5/10	8.9/10	2231	94.5	17
89777	30889	94837	79964	8.6/10	6.1/10	5.1/10	9.7/10	7.8/10	526	96.0	18
89777	30889	94837	50587	8.6/10	6.1/10	5.1/10	9.7/10	7.8/10	526	96.0	18
89777	34100	31134	55504	8.6/10	6.1/10	5.1/10	9.7/10	7.8/10	596	82.5	18
89777	30889	94837	73131	8.6/10	6.1/10	5.1/10	9.7/10	7.8/10	526	96.0	18
89777	30889	94837	80735	8.6/10	6.1/10	5.1/10	9.7/10	7.8/10	526	96.0	18
89777	30889	94837	39770	8.6/10	6.1/10	5.1/10	9.7/10	7.8/10	526	96.0	18
89777	30889	94837	21738	8.6/10	6.1/10	5.1/10	9.7/10	7.8/10	526	96.0	18
89777	30889	94837	67915	8.6/10	6.1/10	5.1/10	9.7/10	7.8/10	526	96.0	18
89777	78864	31134	50352	8.6/10	6.1/10	5.1/10	9.7/10	7.8/10	366	70.0	18
89777	30889	94837	64028	8.6/10	6.1/10	5.1/10	9.7/10	7.8/10	526	96.0	18
89777	18936	94837	44053	8.6/10	6.1/10	5.1/10	9.7/10	7.8/10	394	84.0	18
89777	30889	94837	30410	8.6/10	6.1/10	5.1/10	9.7/10	7.8/10	526	96.0	18
89777	30889	94837	49789	8.6/10	6.1/10	5.1/10	9.7/10	7.8/10	526	96.0	18
89777	30889	94837	11383	8.6/10	6.1/10	5.1/10	9.7/10	7.8/10	526	96.0	18
89777	34100	31134	10012	8.6/10	6.1/10	5.1/10	9.7/10	7.8/10	596	82.5	18
89777	34100	31134	78592	8.6/10	6.1/10	5.1/10	9.7/10	7.8/10	596	82.5	18
89777	34100	31134	27865	8.6/10	6.1/10	5.1/10	9.7/10	7.8/10	596	82.5	18
89777	34100	31134	55073	8.6/10	6.1/10	5.1/10	9.7/10	7.8/10	596	82.5	18
89777	30889	94837	47586	8.6/10	6.1/10	5.1/10	9.7/10	7.8/10	526	96.0	18
89777	34100	31134	71498	8.6/10	6.1/10	5.1/10	9.7/10	7.8/10	596	82.5	18
89777	34100	31134	80136	8.6/10	6.1/10	5.1/10	9.7/10	7.8/10	596	82.5	18
89777	34100	31134	11090	8.6/10	6.1/10	5.1/10	9.7/10	7.8/10	596	82.5	18
89777	38830	31134	74478	8.6/10	6.1/10	5.1/10	9.7/10	7.8/10	560	100.0	18
89777	34100	31134	72530	8.6/10	6.1/10	5.1/10	9.7/10	7.8/10	596	82.5	18
89777	34100	31134	49270	8.6/10	6.1/10	5.1/10	9.7/10	7.8/10	596	82.5	18
89777	34100	31134	11197	8.6/10	6.1/10	5.1/10	9.7/10	7.8/10	596	82.5	18
89777	34100	31134	66418	8.6/10	6.1/10	5.1/10	9.7/10	7.8/10	596	82.5	18
89777	34100	31134	48393	8.6/10	6.1/10	5.1/10	9.7/10	7.8/10	596	82.5	18
89777	34100	31134	88250	8.6/10	6.1/10	5.1/10	9.7/10	7.8/10	596	82.5	18
89777	38830	31134	40305	8.6/10	6.1/10	5.1/10	9.7/10	7.8/10	560	100.0	18
89777	34100	31134	10946	8.6/10	6.1/10	5.1/10	9.7/10	7.8/10	596	82.5	18
89777	34100	31134	81855	8.6/10	6.1/10	5.1/10	9.7/10	7.8/10	596	82.5	18
89777	34100	31134	58974	8.6/10	6.1/10	5.1/10	9.7/10	7.8/10	596	82.5	18
89777	38830	31134	34716	8.6/10	6.1/10	5.1/10	9.7/10	7.8/10	560	100.0	18
89777	34100	31134	63967	8.6/10	6.1/10	5.1/10	9.7/10	7.8/10	596	82.5	18
89777	34100	31134	83472	8.6/10	6.1/10	5.1/10	9.7/10	7.8/10	596	82.5	18
89777	34100	31134	67292	8.6/10	6.1/10	5.1/10	9.7/10	7.8/10	596	82.5	18
89777	34100	31134	61740	8.6/10	6.1/10	5.1/10	9.7/10	7.8/10	596	82.5	18
89777	30889	94837	42754	8.6/10	6.1/10	5.1/10	9.7/10	7.8/10	526	96.0	18
89777	38830	31134	31400	8.6/10	6.1/10	5.1/10	9.7/10	7.8/10	560	100.0	18
89777	34100	31134	94671	8.6/10	6.1/10	5.1/10	9.7/10	7.8/10	596	82.5	18
89777	34100	94837	61081	8.6/10	6.1/10	5.1/10	9.7/10	7.8/10	596	81.5	18
89777	34100	94837	59592	8.6/10	6.1/10	5.1/10	9.7/10	7.8/10	596	81.5	18
89777	34100	94837	38913	8.6/10	6.1/10	5.1/10	9.7/10	7.8/10	596	81.5	18
89777	34100	31134	44469	8.6/10	6.1/10	5.1/10	9.7/10	7.8/10	596	82.5	18
89777	34100	94837	20382	8.6/10	6.1/10	5.1/10	9.7/10	7.8/10	596	81.5	18
89777	34100	31134	65343	8.6/10	6.1/10	5.1/10	9.7/10	7.8/10	596	82.5	18
89777	38830	31134	91962	8.6/10	6.1/10	5.1/10	9.7/10	7.8/10	560	100.0	18
89777	38830	31134	41399	8.6/10	6.1/10	5.1/10	9.7/10	7.8/10	560	100.0	18
89777	30889	94837	77713	8.6/10	6.1/10	5.1/10	9.7/10	7.8/10	526	96.0	18
89777	34100	31134	90375	8.6/10	6.1/10	5.1/10	9.7/10	7.8/10	596	82.5	18
89777	34100	31134	99737	8.6/10	6.1/10	5.1/10	9.7/10	7.8/10	596	82.5	18
89777	34100	31134	45633	8.6/10	6.1/10	5.1/10	9.7/10	7.8/10	596	82.5	18
89777	34100	31134	47313	8.6/10	6.1/10	5.1/10	9.7/10	7.8/10	596	82.5	18
89777	34100	31134	94994	8.6/10	6.1/10	5.1/10	9.7/10	7.8/10	596	82.5	18
89777	34100	31134	79722	8.6/10	6.1/10	5.1/10	9.7/10	7.8/10	596	82.5	18
89777	34100	31134	45235	8.6/10	6.1/10	5.1/10	9.7/10	7.8/10	596	82.5	18
89777	34100	31134	64120	8.6/10	6.1/10	5.1/10	9.7/10	7.8/10	596	82.5	18
89777	34100	31134	34641	8.6/10	6.1/10	5.1/10	9.7/10	7.8/10	596	82.5	18
89777	34100	94837	18973	8.6/10	6.1/10	5.1/10	9.7/10	7.8/10	596	81.5	18
89777	34100	31134	33908	8.6/10	6.1/10	5.1/10	9.7/10	7.8/10	596	82.5	18
89777	38830	31134	27907	8.6/10	6.1/10	5.1/10	9.7/10	7.8/10	560	100.0	18
89777	38830	31134	47957	8.6/10	6.1/10	5.1/10	9.7/10	7.8/10	560	100.0	18
89777	34100	31134	24464	8.6/10	6.1/10	5.1/10	9.7/10	7.8/10	596	82.5	18
89777	34100	31134	93478	8.6/10	6.1/10	5.1/10	9.7/10	7.8/10	596	82.5	18
89777	34100	94837	90967	8.6/10	6.1/10	5.1/10	9.7/10	7.8/10	596	81.5	18
89777	34100	31134	69345	8.6/10	6.1/10	5.1/10	9.7/10	7.8/10	596	82.5	18
89777	34100	31134	45669	8.6/10	6.1/10	5.1/10	9.7/10	7.8/10	596	82.5	18
89777	34100	31134	91625	8.6/10	6.1/10	5.1/10	9.7/10	7.8/10	596	82.5	18
89777	34100	31134	74486	8.6/10	6.1/10	5.1/10	9.7/10	7.8/10	596	82.5	18
89777	34100	31134	34613	8.6/10	6.1/10	5.1/10	9.7/10	7.8/10	596	82.5	18
89777	34100	31134	52027	8.6/10	6.1/10	5.1/10	9.7/10	7.8/10	596	82.5	18
89777	34100	31134	12542	8.6/10	6.1/10	5.1/10	9.7/10	7.8/10	596	82.5	18
89777	34100	31134	29942	8.6/10	6.1/10	5.1/10	9.7/10	7.8/10	596	82.5	18
89777	34100	31134	80119	8.6/10	6.1/10	5.1/10	9.7/10	7.8/10	596	82.5	18
89777	34100	31134	12900	8.6/10	6.1/10	5.1/10	9.7/10	7.8/10	596	82.5	18
89777	34100	31134	34371	8.6/10	6.1/10	5.1/10	9.7/10	7.8/10	596	82.5	18
89777	34100	31134	23405	8.6/10	6.1/10	5.1/10	9.7/10	7.8/10	596	82.5	18
89777	38830	31134	46977	8.6/10	6.1/10	5.1/10	9.7/10	7.8/10	560	100.0	18
89777	38830	31134	45283	8.6/10	6.1/10	5.1/10	9.7/10	7.8/10	560	100.0	18
89777	34100	31134	67464	8.6/10	6.1/10	5.1/10	9.7/10	7.8/10	596	82.5	18
89777	34100	31134	11075	8.6/10	6.1/10	5.1/10	9.7/10	7.8/10	596	82.5	18
89777	34100	31134	40514	8.6/10	6.1/10	5.1/10	9.7/10	7.8/10	596	82.5	18
89777	34100	31134	21822	8.6/10	6.1/10	5.1/10	9.7/10	7.8/10	596	82.5	18
89777	34100	31134	29750	8.6/10	6.1/10	5.1/10	9.7/10	7.8/10	596	82.5	18
89777	34100	94837	11930	8.6/10	6.1/10	5.1/10	9.7/10	7.8/10	596	81.5	18
99235	91338	41938	74694	9.2/10	5.6/10	5.1/10	9.5/10	7.6/10	1073	97.5	19
99235	91338	41938	38467	9.2/10	5.6/10	5.1/10	9.5/10	7.6/10	1073	97.5	19
99235	91338	41938	54815	9.2/10	5.6/10	5.1/10	9.5/10	7.6/10	1073	97.5	19
99235	91338	12942	65082	9.2/10	5.6/10	5.1/10	9.5/10	7.6/10	1073	93.5	19
99235	91338	12942	50838	9.2/10	5.6/10	5.1/10	9.5/10	7.6/10	1073	93.5	19
99235	91338	41938	75325	9.2/10	5.6/10	5.1/10	9.5/10	7.6/10	1073	97.5	19
99235	91338	12942	58679	9.2/10	5.6/10	5.1/10	9.5/10	7.6/10	1073	93.5	19
99235	91338	12942	70776	9.2/10	5.6/10	5.1/10	9.5/10	7.6/10	1073	93.5	19
99235	91338	41938	53286	9.2/10	5.6/10	5.1/10	9.5/10	7.6/10	1073	97.5	19
99235	91338	12942	20515	9.2/10	5.6/10	5.1/10	9.5/10	7.6/10	1073	93.5	19
99235	91338	12942	29148	9.2/10	5.6/10	5.1/10	9.5/10	7.6/10	1073	93.5	19
99235	91338	12942	17345	9.2/10	5.6/10	5.1/10	9.5/10	7.6/10	1073	93.5	19
99235	42943	63857	44931	9.2/10	5.6/10	5.1/10	9.5/10	7.6/10	1133	100.0	19
99235	42943	63857	61435	9.2/10	5.6/10	5.1/10	9.5/10	7.6/10	1133	100.0	19
99235	42943	63857	19356	9.2/10	5.6/10	5.1/10	9.5/10	7.6/10	1133	100.0	19
99235	42943	63857	71623	9.2/10	5.6/10	5.1/10	9.5/10	7.6/10	1133	100.0	19
99235	42943	63857	33803	9.2/10	5.6/10	5.1/10	9.5/10	7.6/10	1133	100.0	19
99235	42943	63857	35191	9.2/10	5.6/10	5.1/10	9.5/10	7.6/10	1133	100.0	19
99235	42943	63857	42778	9.2/10	5.6/10	5.1/10	9.5/10	7.6/10	1133	100.0	19
62654	77350	26762	11653	8.8/10	5.8/10	5.4/10	9.7/10	8.1/10	1809	93.5	20
62654	77350	26762	25985	8.8/10	5.8/10	5.4/10	9.7/10	8.1/10	1809	93.5	20
62654	77350	15655	42631	8.8/10	5.8/10	5.4/10	9.7/10	8.1/10	1809	100.0	20
62654	77350	26762	60436	8.8/10	5.8/10	5.4/10	9.7/10	8.1/10	1809	93.5	20
62654	77350	15655	68059	8.8/10	5.8/10	5.4/10	9.7/10	8.1/10	1809	100.0	20
62654	77350	15655	42396	8.8/10	5.8/10	5.4/10	9.7/10	8.1/10	1809	100.0	20
62654	77350	15655	14392	8.8/10	5.8/10	5.4/10	9.7/10	8.1/10	1809	100.0	20
62654	77350	15655	36106	8.8/10	5.8/10	5.4/10	9.7/10	8.1/10	1809	100.0	20
15083	56934	73113	70402	7.8/10	5.8/10	5.4/10	9.9/10	7.8/10	\N	0.0	21
15083	56934	73113	22315	7.8/10	5.8/10	5.4/10	9.9/10	7.8/10	\N	0.0	21
15083	56934	85168	78306	7.8/10	5.8/10	5.4/10	9.9/10	7.8/10	\N	0.0	21
15083	56934	85168	97294	7.8/10	5.8/10	5.4/10	9.9/10	7.8/10	\N	0.0	21
15083	56934	85168	37321	7.8/10	5.8/10	5.4/10	9.9/10	7.8/10	\N	0.0	21
15083	56934	85168	71974	7.8/10	5.8/10	5.4/10	9.9/10	7.8/10	\N	0.0	21
15083	56934	85168	61003	7.8/10	5.8/10	5.4/10	9.9/10	7.8/10	\N	0.0	21
15083	56934	85168	99318	7.8/10	5.8/10	5.4/10	9.9/10	7.8/10	\N	0.0	21
15083	56934	73113	50908	7.8/10	5.8/10	5.4/10	9.9/10	7.8/10	\N	0.0	21
61877	55796	92515	52344	8.8/10	5.8/10	5.0/10	9.5/10	7.8/10	932	81.0	22
61877	55796	92515	30789	8.8/10	5.8/10	5.0/10	9.5/10	7.8/10	932	81.0	22
53449	99477	56255	92465	7.9/10	5.5/10	10.0/10	9.9/10	5.4/10	847	57.5	23
41139	79533	12440	15529	8.8/10	5.9/10	5.1/10	9.7/10	8.1/10	1081	69.5	24
41139	79533	93574	82034	8.8/10	5.9/10	5.1/10	9.7/10	8.1/10	1081	92.0	24
41139	79533	93574	78278	8.8/10	5.9/10	5.1/10	9.7/10	8.1/10	1081	92.0	24
41139	79533	93574	26009	8.8/10	5.9/10	5.1/10	9.7/10	8.1/10	1081	92.0	24
41139	79533	93574	73075	8.8/10	5.9/10	5.1/10	9.7/10	8.1/10	1081	92.0	24
41139	79533	12440	93692	8.8/10	5.9/10	5.1/10	9.7/10	8.1/10	1081	69.5	24
41139	79533	93574	49166	8.8/10	5.9/10	5.1/10	9.7/10	8.1/10	1081	92.0	24
41139	79533	93574	36047	8.8/10	5.9/10	5.1/10	9.7/10	8.1/10	1081	92.0	24
41139	91039	26762	57241	8.8/10	5.9/10	5.1/10	9.7/10	8.1/10	1769	93.5	24
41139	91039	26762	16827	8.8/10	5.9/10	5.1/10	9.7/10	8.1/10	1769	93.5	24
41139	91039	26762	97385	8.8/10	5.9/10	5.1/10	9.7/10	8.1/10	1769	93.5	24
41139	91039	26762	38545	8.8/10	5.9/10	5.1/10	9.7/10	8.1/10	1769	93.5	24
41139	91039	26762	24801	8.8/10	5.9/10	5.1/10	9.7/10	8.1/10	1769	93.5	24
41139	79533	93574	40928	8.8/10	5.9/10	5.1/10	9.7/10	8.1/10	1081	92.0	24
41139	91039	26762	92956	8.8/10	5.9/10	5.1/10	9.7/10	8.1/10	1769	93.5	24
41139	91039	26762	66906	8.8/10	5.9/10	5.1/10	9.7/10	8.1/10	1769	93.5	24
41139	91039	26762	52534	8.8/10	5.9/10	5.1/10	9.7/10	8.1/10	1769	93.5	24
16460	72240	96736	11974	8.6/10	5.9/10	5.3/10	8.9/10	7.8/10	\N	50.0	25
72287	39563	85842	31936	9.8/10	5.9/10	5.7/10	9.7/10	6.6/10	582	95.5	26
72287	39563	85842	46188	9.8/10	5.9/10	5.7/10	9.7/10	6.6/10	582	95.5	26
72287	39563	85842	86637	9.8/10	5.9/10	5.7/10	9.7/10	6.6/10	582	95.5	26
45203	15326	75776	25682	8.8/10	5.8/10	4.9/10	9.7/10	8.1/10	1593	73.0	27
45203	15326	75776	41862	8.8/10	5.8/10	4.9/10	9.7/10	8.1/10	1593	73.0	27
45203	15326	75776	11170	8.8/10	5.8/10	4.9/10	9.7/10	8.1/10	1593	73.0	27
45203	59440	75776	15504	8.8/10	5.8/10	4.9/10	9.7/10	8.1/10	2231	87.0	27
45203	15326	75776	86162	8.8/10	5.8/10	4.9/10	9.7/10	8.1/10	1593	73.0	27
45203	15326	75776	72294	8.8/10	5.8/10	4.9/10	9.7/10	8.1/10	1593	73.0	27
45203	15326	75776	88146	8.8/10	5.8/10	4.9/10	9.7/10	8.1/10	1593	73.0	27
45203	59440	75776	30315	8.8/10	5.8/10	4.9/10	9.7/10	8.1/10	2231	87.0	27
45203	15326	75776	21728	8.8/10	5.8/10	4.9/10	9.7/10	8.1/10	1593	73.0	27
45203	15326	75776	42600	8.8/10	5.8/10	4.9/10	9.7/10	8.1/10	1593	73.0	27
45203	59440	10864	30669	8.8/10	5.8/10	4.9/10	9.7/10	8.1/10	2231	94.5	27
45203	59440	10864	75525	8.8/10	5.8/10	4.9/10	9.7/10	8.1/10	2231	94.5	27
45203	59440	10864	21980	8.8/10	5.8/10	4.9/10	9.7/10	8.1/10	2231	94.5	27
45203	59440	10864	99908	8.8/10	5.8/10	4.9/10	9.7/10	8.1/10	2231	94.5	27
45203	59440	10864	91087	8.8/10	5.8/10	4.9/10	9.7/10	8.1/10	2231	94.5	27
45203	59440	10864	54357	8.8/10	5.8/10	4.9/10	9.7/10	8.1/10	2231	94.5	27
45203	59440	10864	91937	8.8/10	5.8/10	4.9/10	9.7/10	8.1/10	2231	94.5	27
45203	59440	10864	17871	8.8/10	5.8/10	4.9/10	9.7/10	8.1/10	2231	94.5	27
45203	59440	10864	17834	8.8/10	5.8/10	4.9/10	9.7/10	8.1/10	2231	94.5	27
45203	59440	10864	56598	8.8/10	5.8/10	4.9/10	9.7/10	8.1/10	2231	94.5	27
45203	59440	75776	94485	8.8/10	5.8/10	4.9/10	9.7/10	8.1/10	2231	87.0	27
45203	15326	10864	30174	8.8/10	5.8/10	4.9/10	9.7/10	8.1/10	1593	80.5	27
45203	59440	10864	80300	8.8/10	5.8/10	4.9/10	9.7/10	8.1/10	2231	94.5	27
45203	59440	10864	24076	8.8/10	5.8/10	4.9/10	9.7/10	8.1/10	2231	94.5	27
45203	59440	10864	26492	8.8/10	5.8/10	4.9/10	9.7/10	8.1/10	2231	94.5	27
45203	59440	75776	73942	8.8/10	5.8/10	4.9/10	9.7/10	8.1/10	2231	87.0	27
58816	77350	93574	40497	8.8/10	5.9/10	4.9/10	9.5/10	8.2/10	1809	92.0	28
12651	11699	81349	51515	7.9/10	6.2/10	10.0/10	9.9/10	6.4/10	592	88.0	29
12651	99803	85842	83184	7.9/10	6.2/10	10.0/10	9.9/10	6.4/10	615	98.5	29
12651	50980	85842	94495	7.9/10	6.2/10	10.0/10	9.9/10	6.4/10	637	100.0	29
12651	50980	85842	55523	7.9/10	6.2/10	10.0/10	9.9/10	6.4/10	637	100.0	29
12651	50980	85842	67503	7.9/10	6.2/10	10.0/10	9.9/10	6.4/10	637	100.0	29
54284	46583	40145	35292	8.6/10	7.2/10	10.0/10	9.9/10	3.9/10	2308	100.0	30
54284	46583	40145	12798	8.6/10	7.2/10	10.0/10	9.9/10	3.9/10	2308	100.0	30
54284	46583	40145	59514	8.6/10	7.2/10	10.0/10	9.9/10	3.9/10	2308	100.0	30
54284	46583	40145	56945	8.6/10	7.2/10	10.0/10	9.9/10	3.9/10	2308	100.0	30
54284	46583	40145	27659	8.6/10	7.2/10	10.0/10	9.9/10	3.9/10	2308	100.0	30
49722	77350	93574	42859	9.2/10	5.9/10	5.4/10	9.7/10	8.0/10	1809	92.0	31
49722	77350	83872	15175	9.2/10	5.9/10	5.4/10	9.7/10	8.0/10	1809	100.0	31
49722	77350	93574	73609	9.2/10	5.9/10	5.4/10	9.7/10	8.0/10	1809	92.0	31
49722	77350	93574	67344	9.2/10	5.9/10	5.4/10	9.7/10	8.0/10	1809	92.0	31
49722	77350	93574	83272	9.2/10	5.9/10	5.4/10	9.7/10	8.0/10	1809	92.0	31
49722	77350	93574	48628	9.2/10	5.9/10	5.4/10	9.7/10	8.0/10	1809	92.0	31
49722	77350	93574	81137	9.2/10	5.9/10	5.4/10	9.7/10	8.0/10	1809	92.0	31
49722	77350	26762	74237	9.2/10	5.9/10	5.4/10	9.7/10	8.0/10	1809	93.5	31
49722	77350	83872	34874	9.2/10	5.9/10	5.4/10	9.7/10	8.0/10	1809	100.0	31
49722	77350	26762	84278	9.2/10	5.9/10	5.4/10	9.7/10	8.0/10	1809	93.5	31
49722	77350	26762	34461	9.2/10	5.9/10	5.4/10	9.7/10	8.0/10	1809	93.5	31
49722	77350	93574	81253	9.2/10	5.9/10	5.4/10	9.7/10	8.0/10	1809	92.0	31
49722	77350	93574	55569	9.2/10	5.9/10	5.4/10	9.7/10	8.0/10	1809	92.0	31
49722	77350	83872	52425	9.2/10	5.9/10	5.4/10	9.7/10	8.0/10	1809	100.0	31
49722	77350	26762	71393	9.2/10	5.9/10	5.4/10	9.7/10	8.0/10	1809	93.5	31
49722	77350	93574	46087	9.2/10	5.9/10	5.4/10	9.7/10	8.0/10	1809	92.0	31
49722	77350	83872	88470	9.2/10	5.9/10	5.4/10	9.7/10	8.0/10	1809	100.0	31
49722	77350	26762	82682	9.2/10	5.9/10	5.4/10	9.7/10	8.0/10	1809	93.5	31
49722	77350	93574	31016	9.2/10	5.9/10	5.4/10	9.7/10	8.0/10	1809	92.0	31
49722	77350	93574	19027	9.2/10	5.9/10	5.4/10	9.7/10	8.0/10	1809	92.0	31
49722	77350	93574	79617	9.2/10	5.9/10	5.4/10	9.7/10	8.0/10	1809	92.0	31
49722	77350	93574	30319	9.2/10	5.9/10	5.4/10	9.7/10	8.0/10	1809	92.0	31
49722	77350	83872	68901	9.2/10	5.9/10	5.4/10	9.7/10	8.0/10	1809	100.0	31
49722	77350	93574	48754	9.2/10	5.9/10	5.4/10	9.7/10	8.0/10	1809	92.0	31
49722	77350	93574	80989	9.2/10	5.9/10	5.4/10	9.7/10	8.0/10	1809	92.0	31
49722	77350	83872	58118	9.2/10	5.9/10	5.4/10	9.7/10	8.0/10	1809	100.0	31
49722	77350	83872	69517	9.2/10	5.9/10	5.4/10	9.7/10	8.0/10	1809	100.0	31
49722	77350	83872	10094	9.2/10	5.9/10	5.4/10	9.7/10	8.0/10	1809	100.0	31
49722	77350	26762	93627	9.2/10	5.9/10	5.4/10	9.7/10	8.0/10	1809	93.5	31
49722	77350	93574	76316	9.2/10	5.9/10	5.4/10	9.7/10	8.0/10	1809	92.0	31
49722	77350	93574	59681	9.2/10	5.9/10	5.4/10	9.7/10	8.0/10	1809	92.0	31
49722	77350	83872	34318	9.2/10	5.9/10	5.4/10	9.7/10	8.0/10	1809	100.0	31
49722	77350	93574	12453	9.2/10	5.9/10	5.4/10	9.7/10	8.0/10	1809	92.0	31
49722	77350	83872	91229	9.2/10	5.9/10	5.4/10	9.7/10	8.0/10	1809	100.0	31
49722	77350	93574	57720	9.2/10	5.9/10	5.4/10	9.7/10	8.0/10	1809	92.0	31
49722	77350	93574	91290	9.2/10	5.9/10	5.4/10	9.7/10	8.0/10	1809	92.0	31
49722	77350	83872	41298	9.2/10	5.9/10	5.4/10	9.7/10	8.0/10	1809	100.0	31
49722	77350	83872	52034	9.2/10	5.9/10	5.4/10	9.7/10	8.0/10	1809	100.0	31
50756	79533	83872	18302	9.0/10	5.0/10	5.1/10	9.7/10	8.1/10	1081	100.0	32
50756	79533	83872	96283	9.0/10	5.0/10	5.1/10	9.7/10	8.1/10	1081	100.0	32
50756	79533	93574	80642	9.0/10	5.0/10	5.1/10	9.7/10	8.1/10	1081	92.0	32
50756	79533	83872	60789	9.0/10	5.0/10	5.1/10	9.7/10	8.1/10	1081	100.0	32
50756	79533	83872	34886	9.0/10	5.0/10	5.1/10	9.7/10	8.1/10	1081	100.0	32
50756	79533	83872	99551	9.0/10	5.0/10	5.1/10	9.7/10	8.1/10	1081	100.0	32
50756	79533	93574	75214	9.0/10	5.0/10	5.1/10	9.7/10	8.1/10	1081	92.0	32
50756	79533	93574	82281	9.0/10	5.0/10	5.1/10	9.7/10	8.1/10	1081	92.0	32
50756	79533	93574	30202	9.0/10	5.0/10	5.1/10	9.7/10	8.1/10	1081	92.0	32
50756	79533	93574	90352	9.0/10	5.0/10	5.1/10	9.7/10	8.1/10	1081	92.0	32
46745	77746	93574	47110	9.6/10	5.3/10	5.0/10	9.7/10	8.2/10	968	92.0	33
46745	34507	12440	52283	9.6/10	5.3/10	5.0/10	9.7/10	8.2/10	795	61.5	33
46745	77746	93574	63713	9.6/10	5.3/10	5.0/10	9.7/10	8.2/10	968	92.0	33
74437	73806	87410	94004	9.4/10	5.9/10	5.8/10	6.4/10	8.2/10	455	85.5	34
74437	68400	87410	52208	9.4/10	5.9/10	5.8/10	6.4/10	8.2/10	645	100.0	34
74437	68400	87410	24478	9.4/10	5.9/10	5.8/10	6.4/10	8.2/10	645	100.0	34
74437	68400	87410	22616	9.4/10	5.9/10	5.8/10	6.4/10	8.2/10	645	100.0	34
74437	68400	87410	78576	9.4/10	5.9/10	5.8/10	6.4/10	8.2/10	645	100.0	34
22873	42943	59572	96362	9.4/10	5.8/10	4.9/10	9.5/10	7.6/10	1133	97.5	35
22873	42943	59572	18739	9.4/10	5.8/10	4.9/10	9.5/10	7.6/10	1133	97.5	35
22873	42943	59572	15737	9.4/10	5.8/10	4.9/10	9.5/10	7.6/10	1133	97.5	35
22873	91338	60523	33414	9.4/10	5.8/10	4.9/10	9.5/10	7.6/10	1073	89.5	35
22873	42943	59572	14099	9.4/10	5.8/10	4.9/10	9.5/10	7.6/10	1133	97.5	35
22873	42943	60523	36486	9.4/10	5.8/10	4.9/10	9.5/10	7.6/10	1133	92.0	35
22873	42943	59572	24031	9.4/10	5.8/10	4.9/10	9.5/10	7.6/10	1133	97.5	35
22873	42943	59572	73618	9.4/10	5.8/10	4.9/10	9.5/10	7.6/10	1133	97.5	35
22873	42943	59572	35115	9.4/10	5.8/10	4.9/10	9.5/10	7.6/10	1133	97.5	35
22873	42943	59572	22943	9.4/10	5.8/10	4.9/10	9.5/10	7.6/10	1133	97.5	35
39878	55796	12440	14170	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	932	69.0	36
39878	34507	93574	84843	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	84.0	36
39878	55796	83872	94115	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	932	99.5	36
39878	34507	93574	60934	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	84.0	36
39878	55796	83872	96235	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	932	99.5	36
39878	55796	12440	74213	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	932	69.0	36
39878	55796	12440	78920	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	932	69.0	36
39878	55796	83872	91785	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	932	99.5	36
39878	34507	93574	87371	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	84.0	36
39878	55796	12440	43546	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	932	69.0	36
39878	55796	12440	16433	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	932	69.0	36
39878	55796	12440	58018	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	932	69.0	36
39878	55796	12440	38930	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	932	69.0	36
39878	34507	12440	89423	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	12440	19289	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	12440	11715	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	12440	37359	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	12440	95950	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	12440	74409	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	55796	12440	20480	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	932	69.0	36
39878	34507	93574	71349	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	84.0	36
39878	55796	12440	93744	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	932	69.0	36
39878	55796	12440	17956	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	932	69.0	36
39878	55796	12440	57307	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	932	69.0	36
39878	34507	12440	83140	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	12440	64519	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	12440	17641	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	12440	90862	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	12440	44840	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	12440	79339	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	12440	15328	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	12440	19225	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	12440	49833	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	12440	38298	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	93574	78089	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	84.0	36
39878	55796	12440	22729	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	932	69.0	36
39878	55796	12440	23267	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	932	69.0	36
39878	55796	12440	40279	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	932	69.0	36
39878	55796	12440	79685	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	932	69.0	36
39878	34507	12440	60506	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	12440	34832	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	12440	35312	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	12440	78969	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	12440	96098	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	12440	42605	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	12440	84714	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	55796	12440	33448	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	932	69.0	36
39878	55796	12440	83193	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	932	69.0	36
39878	55796	12440	83156	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	932	69.0	36
39878	34507	12440	64419	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	12440	23829	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	12440	93705	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	12440	85571	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	93574	56918	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	84.0	36
39878	55796	12440	98407	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	932	69.0	36
39878	34507	93574	70125	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	84.0	36
39878	34507	93574	97194	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	84.0	36
39878	34507	12440	65977	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	12440	23644	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	12440	31864	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	12440	33644	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	12440	82085	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	12440	62632	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	12440	76151	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	12440	54238	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	12440	96184	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	12440	30732	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	55796	12440	88632	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	932	69.0	36
39878	55796	12440	68066	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	932	69.0	36
39878	55796	12440	51307	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	932	69.0	36
39878	34507	12440	82100	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	12440	52553	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	12440	58722	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	12440	66438	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	12440	52395	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	12440	89745	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	12440	41551	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	12440	83812	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	12440	38039	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	12440	59160	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	12440	82120	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	93574	43303	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	84.0	36
39878	55796	12440	57187	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	932	69.0	36
39878	34507	12440	69297	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	12440	68654	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	12440	62047	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	12440	10025	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	93574	14543	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	84.0	36
39878	55796	12440	47287	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	932	69.0	36
39878	34507	12440	88087	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	12440	12136	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	12440	77844	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	12440	27705	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	12440	49562	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	12440	10860	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	12440	49365	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	55796	12440	39083	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	932	69.0	36
39878	55796	12440	38157	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	932	69.0	36
39878	55796	12440	51275	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	932	69.0	36
39878	34507	12440	12844	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	12440	82569	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	12440	77013	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	12440	82918	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	12440	84922	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	55796	12440	30278	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	932	69.0	36
39878	34507	12440	22358	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	12440	14946	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	12440	70341	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	12440	56616	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	12440	30461	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	12440	28141	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	93574	44732	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	84.0	36
39878	34507	93574	58114	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	84.0	36
39878	55796	83872	86304	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	932	99.5	36
39878	34507	12440	42749	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	93574	49361	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	84.0	36
39878	34507	12440	22046	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	12440	84774	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	12440	62402	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	93574	84588	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	84.0	36
39878	55796	12440	38499	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	932	69.0	36
39878	55796	12440	20118	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	932	69.0	36
39878	34507	12440	52558	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	93574	73246	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	84.0	36
39878	34507	12440	32662	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	12440	73999	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	55796	93574	85527	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	932	91.5	36
39878	55796	12440	88018	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	932	69.0	36
39878	55796	12440	94181	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	932	69.0	36
39878	55796	12440	49373	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	932	69.0	36
39878	34507	12440	14898	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	12440	60010	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	12440	20286	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	12440	17329	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	93574	53829	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	84.0	36
39878	34507	12440	66925	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	12440	64594	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	93574	25799	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	84.0	36
39878	34507	93574	39716	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	84.0	36
39878	34507	93574	95561	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	84.0	36
39878	34507	93574	88944	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	84.0	36
39878	34507	93574	93084	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	84.0	36
39878	34507	12440	92862	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	12440	60133	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	93574	17094	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	84.0	36
39878	55796	12440	49948	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	932	69.0	36
39878	55796	12440	78731	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	932	69.0	36
39878	55796	12440	15397	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	932	69.0	36
39878	34507	93574	80769	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	84.0	36
39878	34507	12440	84044	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	93574	29605	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	84.0	36
39878	34507	12440	52838	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	12440	75850	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	12440	38940	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	55796	12440	30079	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	932	69.0	36
39878	34507	12440	16621	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	12440	98294	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	93574	61495	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	84.0	36
39878	34507	93574	68407	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	84.0	36
39878	34507	93574	88005	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	84.0	36
39878	34507	93574	85399	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	84.0	36
39878	34507	12440	76155	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	12440	39109	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	93574	66614	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	84.0	36
39878	34507	93574	47982	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	84.0	36
39878	34507	12440	61684	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	93574	29400	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	84.0	36
39878	55796	12440	27326	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	932	69.0	36
39878	55796	12440	54062	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	932	69.0	36
39878	34507	12440	20819	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	12440	72371	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	93574	84899	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	84.0	36
39878	55796	12440	16463	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	932	69.0	36
39878	55796	12440	81847	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	932	69.0	36
39878	34507	12440	62322	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	12440	44413	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	61.5	36
39878	34507	93574	21151	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	84.0	36
39878	55796	12440	62235	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	932	69.0	36
39878	34507	93574	66949	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	84.0	36
39878	34507	93574	27088	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	84.0	36
39878	34507	93574	27677	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	84.0	36
39878	34507	93574	73035	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	84.0	36
39878	55796	12440	83308	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	932	69.0	36
39878	34507	93574	35966	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	84.0	36
39878	55796	12440	61815	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	932	69.0	36
39878	34507	93574	95491	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	84.0	36
39878	34507	93574	84885	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	84.0	36
39878	34507	93574	35703	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	84.0	36
39878	34507	93574	83553	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	84.0	36
39878	34507	93574	90739	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	84.0	36
39878	34507	93574	78714	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	84.0	36
39878	34507	93574	42275	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	84.0	36
39878	34507	93574	41760	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	84.0	36
39878	34507	93574	19390	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	84.0	36
39878	34507	93574	44898	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	84.0	36
39878	34507	93574	66369	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	84.0	36
39878	34507	93574	52390	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	84.0	36
39878	34507	93574	99749	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	84.0	36
39878	34507	93574	85499	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	84.0	36
39878	34507	93574	21743	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	84.0	36
39878	34507	93574	24749	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	84.0	36
62872	58906	36698	65974	5.2/10	5.9/10	5.4/10	9.7/10	8.0/10	582	50.0	57
39878	34507	93574	98047	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	84.0	36
39878	34507	93574	64209	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	84.0	36
39878	34507	93574	65514	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	84.0	36
39878	34507	93574	57876	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	84.0	36
39878	34507	93574	55653	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	84.0	36
39878	34507	93574	34967	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	84.0	36
39878	34507	93574	52039	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	795	84.0	36
39878	55796	12440	55157	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	932	69.0	36
39878	55796	12440	87840	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	932	69.0	36
39878	55796	12440	95905	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	932	69.0	36
39878	55796	12440	13172	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	932	69.0	36
39878	55796	12440	49953	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	932	69.0	36
39878	55796	12440	32184	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	932	69.0	36
39878	55796	12440	55838	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	932	69.0	36
39878	55796	12440	90769	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	932	69.0	36
39878	55796	12440	91681	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	932	69.0	36
39878	55796	12440	29112	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	932	69.0	36
39878	55796	12440	67732	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	932	69.0	36
39878	55796	12440	15882	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	932	69.0	36
39878	55796	12440	40603	9.4/10	5.3/10	4.7/10	9.9/10	8.1/10	932	69.0	36
27614	91338	83872	36173	9.6/10	5.2/10	4.8/10	9.9/10	7.6/10	1073	97.5	37
27614	42943	26762	99831	9.6/10	5.2/10	4.8/10	9.9/10	7.6/10	1133	93.5	37
27614	42943	83872	58997	9.6/10	5.2/10	4.8/10	9.9/10	7.6/10	1133	100.0	37
27614	42943	15655	21247	9.6/10	5.2/10	4.8/10	9.9/10	7.6/10	1133	100.0	37
49384	79888	90576	24728	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	846	80.5	38
49384	79888	90576	17148	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	846	80.5	38
49384	79888	90576	41856	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	846	80.5	38
49384	79888	90576	91396	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	846	80.5	38
49384	79888	90576	29356	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	846	80.5	38
49384	79888	90576	47707	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	846	80.5	38
49384	79888	72373	11800	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	846	74.0	38
49384	92173	79655	54993	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	90576	24585	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	30.5	38
49384	92173	79655	49992	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	68990	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	71759	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	12981	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	53499	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	37395	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	80517	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	37770	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	36712	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	81620	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	79888	72373	78585	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	846	74.0	38
49384	92173	79655	73311	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	91663	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	28526	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	97590	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	12410	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	59362	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	86415	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	96969	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	79048	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	15699	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	43483	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	32324	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	17878	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	47226	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	36305	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	90997	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	45557	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	16957	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	70943	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	95820	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	11092	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	18729	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	96556	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	45561	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	96898	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	96520	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	24141	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	12500	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	48337	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	95119	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	60662	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	40299	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	59899	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	76655	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	23055	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	73525	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	88263	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	79672	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	79888	90576	21537	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	846	80.5	38
49384	92173	79655	34434	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	36066	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	75621	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	70029	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	79888	90576	83490	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	846	80.5	38
49384	92173	79655	12816	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	15210	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	49967	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	53721	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	74216	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	61563	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	72373	30578	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	24.0	38
49384	92173	79655	12408	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	55453	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	99694	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	56125	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	56580	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	91950	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	49626	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	40959	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	75700	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	46159	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	18127	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	92023	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	43774	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	60747	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	13862	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	82737	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	46725	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	29884	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	54798	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	61491	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	96105	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	27991	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	21507	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	60096	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	78251	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	98866	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	90274	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	91988	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	99983	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	39809	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	64700	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	41504	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	85090	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	30021	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	65897	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	50944	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	89346	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	53160	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	68873	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	81071	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	92173	79655	27271	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
49384	79888	90576	37100	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	846	80.5	38
49384	92173	79655	95520	6.6/10	6.2/10	5.7/10	7.5/10	8.1/10	\N	31.5	38
52056	77350	93574	28163	8.8/10	5.9/10	5.0/10	9.5/10	7.6/10	1809	92.0	39
52056	77350	93574	86156	8.8/10	5.9/10	5.0/10	9.5/10	7.6/10	1809	92.0	39
52056	77350	93574	80956	8.8/10	5.9/10	5.0/10	9.5/10	7.6/10	1809	92.0	39
52056	77350	93574	99659	8.8/10	5.9/10	5.0/10	9.5/10	7.6/10	1809	92.0	39
52056	77350	93574	36517	8.8/10	5.9/10	5.0/10	9.5/10	7.6/10	1809	92.0	39
52056	77350	93574	28102	8.8/10	5.9/10	5.0/10	9.5/10	7.6/10	1809	92.0	39
52056	77350	93574	50501	8.8/10	5.9/10	5.0/10	9.5/10	7.6/10	1809	92.0	39
52056	77350	93574	78656	8.8/10	5.9/10	5.0/10	9.5/10	7.6/10	1809	92.0	39
45313	65601	10864	27727	3.9/10	7.2/10	10.0/10	9.9/10	5.8/10	\N	46.0	40
64627	36945	89098	29025	9.0/10	6.2/10	10.0/10	9.9/10	5.3/10	1016	89.0	41
64627	36945	89098	96013	9.0/10	6.2/10	10.0/10	9.9/10	5.3/10	1016	89.0	41
64627	36945	89098	84035	9.0/10	6.2/10	10.0/10	9.9/10	5.3/10	1016	89.0	41
64627	36945	89098	30715	9.0/10	6.2/10	10.0/10	9.9/10	5.3/10	1016	89.0	41
64627	36945	89098	51614	9.0/10	6.2/10	10.0/10	9.9/10	5.3/10	1016	89.0	41
64627	36945	89098	18888	9.0/10	6.2/10	10.0/10	9.9/10	5.3/10	1016	89.0	41
64627	36945	89098	83051	9.0/10	6.2/10	10.0/10	9.9/10	5.3/10	1016	89.0	41
64627	36945	89098	79856	9.0/10	6.2/10	10.0/10	9.9/10	5.3/10	1016	89.0	41
64627	36945	89098	25517	9.0/10	6.2/10	10.0/10	9.9/10	5.3/10	1016	89.0	41
64627	36945	89098	34134	9.0/10	6.2/10	10.0/10	9.9/10	5.3/10	1016	89.0	41
64627	36945	89098	51628	9.0/10	6.2/10	10.0/10	9.9/10	5.3/10	1016	89.0	41
64627	36945	89098	29073	9.0/10	6.2/10	10.0/10	9.9/10	5.3/10	1016	89.0	41
64627	36945	89098	51771	9.0/10	6.2/10	10.0/10	9.9/10	5.3/10	1016	89.0	41
64627	36945	89098	64269	9.0/10	6.2/10	10.0/10	9.9/10	5.3/10	1016	89.0	41
64627	36945	89098	63903	9.0/10	6.2/10	10.0/10	9.9/10	5.3/10	1016	89.0	41
64627	36945	89098	49760	9.0/10	6.2/10	10.0/10	9.9/10	5.3/10	1016	89.0	41
64627	36945	89098	68065	9.0/10	6.2/10	10.0/10	9.9/10	5.3/10	1016	89.0	41
64627	36945	89098	93472	9.0/10	6.2/10	10.0/10	9.9/10	5.3/10	1016	89.0	41
64627	36945	89098	45887	9.0/10	6.2/10	10.0/10	9.9/10	5.3/10	1016	89.0	41
64627	36945	89098	29917	9.0/10	6.2/10	10.0/10	9.9/10	5.3/10	1016	89.0	41
64627	36945	89098	34632	9.0/10	6.2/10	10.0/10	9.9/10	5.3/10	1016	89.0	41
64627	36945	89098	23994	9.0/10	6.2/10	10.0/10	9.9/10	5.3/10	1016	89.0	41
64627	36945	89098	27241	9.0/10	6.2/10	10.0/10	9.9/10	5.3/10	1016	89.0	41
64627	36945	89098	34215	9.0/10	6.2/10	10.0/10	9.9/10	5.3/10	1016	89.0	41
64627	36945	89098	13433	9.0/10	6.2/10	10.0/10	9.9/10	5.3/10	1016	89.0	41
64627	36945	89098	90213	9.0/10	6.2/10	10.0/10	9.9/10	5.3/10	1016	89.0	41
64627	36945	89098	90864	9.0/10	6.2/10	10.0/10	9.9/10	5.3/10	1016	89.0	41
64627	36945	89098	44978	9.0/10	6.2/10	10.0/10	9.9/10	5.3/10	1016	89.0	41
64627	36945	89098	89377	9.0/10	6.2/10	10.0/10	9.9/10	5.3/10	1016	89.0	41
64627	36945	89098	84323	9.0/10	6.2/10	10.0/10	9.9/10	5.3/10	1016	89.0	41
64627	36945	89098	90263	9.0/10	6.2/10	10.0/10	9.9/10	5.3/10	1016	89.0	41
64627	36945	89098	40266	9.0/10	6.2/10	10.0/10	9.9/10	5.3/10	1016	89.0	41
64627	36945	89098	88166	9.0/10	6.2/10	10.0/10	9.9/10	5.3/10	1016	89.0	41
64627	36945	89098	40432	9.0/10	6.2/10	10.0/10	9.9/10	5.3/10	1016	89.0	41
64627	36945	89098	13418	9.0/10	6.2/10	10.0/10	9.9/10	5.3/10	1016	89.0	41
64627	36945	89098	57089	9.0/10	6.2/10	10.0/10	9.9/10	5.3/10	1016	89.0	41
89295	25643	78425	20417	8.6/10	5.8/10	5.0/10	9.5/10	7.7/10	1235	78.5	42
94614	19452	66224	72469	8.8/10	5.6/10	6.1/10	6.6/10	8.1/10	1010	84.0	43
21703	36945	89098	75840	8.6/10	5.8/10	4.9/10	9.7/10	7.7/10	1016	89.0	44
21703	36945	89098	89260	8.6/10	5.8/10	4.9/10	9.7/10	7.7/10	1016	89.0	44
21703	36945	89098	71441	8.6/10	5.8/10	4.9/10	9.7/10	7.7/10	1016	89.0	44
21703	36945	89098	95140	8.6/10	5.8/10	4.9/10	9.7/10	7.7/10	1016	89.0	44
34633	19760	55224	34114	8.8/10	6.2/10	10.0/10	9.9/10	5.3/10	870	99.5	45
34633	19760	55224	60785	8.8/10	6.2/10	10.0/10	9.9/10	5.3/10	870	99.5	45
34633	19760	55224	74414	8.8/10	6.2/10	10.0/10	9.9/10	5.3/10	870	99.5	45
34633	19760	55224	72108	8.8/10	6.2/10	10.0/10	9.9/10	5.3/10	870	99.5	45
34633	19760	55224	28024	8.8/10	6.2/10	10.0/10	9.9/10	5.3/10	870	99.5	45
34633	19760	55224	31467	8.8/10	6.2/10	10.0/10	9.9/10	5.3/10	870	99.5	45
34633	19760	55224	35330	8.8/10	6.2/10	10.0/10	9.9/10	5.3/10	870	99.5	45
67896	60860	26762	39658	9.2/10	5.2/10	4.8/10	9.7/10	8.1/10	1828	93.5	46
37707	79533	12440	63554	8.8/10	5.2/10	4.8/10	9.7/10	8.2/10	1081	69.5	47
63368	38830	31134	11967	8.4/10	5.5/10	5.7/10	7.2/10	9.2/10	560	100.0	48
63368	30889	94837	45370	8.4/10	5.5/10	5.7/10	7.2/10	9.2/10	526	96.0	48
63368	78236	31134	64138	8.4/10	5.5/10	5.7/10	7.2/10	9.2/10	536	98.0	48
63368	78236	31134	39170	8.4/10	5.5/10	5.7/10	7.2/10	9.2/10	536	98.0	48
73499	94072	47128	97993	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	3.5	49
73499	92173	34775	36585	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	10.5	49
73499	92173	34775	36812	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	10.5	49
73499	92173	34775	18668	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	10.5	49
73499	92173	34775	33209	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	10.5	49
73499	10773	79655	67577	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	578	65.5	49
73499	80101	79655	90879	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	31.5	49
73499	92173	34775	74217	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	10.5	49
73499	92173	34775	52584	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	10.5	49
73499	92173	34775	69971	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	10.5	49
73499	92173	34775	42346	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	10.5	49
73499	92173	34775	66040	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	10.5	49
73499	10773	63562	63066	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	578	69.5	49
73499	92173	34775	89682	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	10.5	49
73499	92173	34775	51012	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	10.5	49
73499	92173	34775	61662	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	10.5	49
73499	10773	79655	90151	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	578	65.5	49
73499	92173	34775	84964	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	10.5	49
73499	92173	34775	80275	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	10.5	49
73499	92173	34775	78843	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	10.5	49
73499	92173	34775	94068	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	10.5	49
73499	92173	34775	15047	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	10.5	49
62872	58906	36698	89802	5.2/10	5.9/10	5.4/10	9.7/10	8.0/10	582	50.0	57
73499	92173	34775	78242	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	10.5	49
73499	92173	34775	24328	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	10.5	49
73499	94072	79655	69193	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	31.5	49
73499	94072	79655	69886	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	31.5	49
73499	94072	79655	15559	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	31.5	49
73499	92173	34775	42207	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	10.5	49
73499	92173	34775	77987	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	10.5	49
73499	92173	34775	80499	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	10.5	49
73499	92173	34775	61853	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	10.5	49
73499	92173	34775	15144	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	10.5	49
73499	92173	34775	83098	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	10.5	49
73499	92173	34775	60777	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	10.5	49
73499	92173	34775	77649	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	10.5	49
73499	94072	79655	16461	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	31.5	49
73499	94072	79655	34884	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	31.5	49
73499	92173	34775	48165	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	10.5	49
73499	92173	34775	67613	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	10.5	49
73499	92173	34775	49918	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	10.5	49
73499	92173	34775	47475	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	10.5	49
73499	92173	34775	70469	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	10.5	49
73499	92173	34775	31821	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	10.5	49
62872	58906	64162	51482	5.2/10	5.9/10	5.4/10	9.7/10	8.0/10	582	50.0	57
73499	92173	34775	65372	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	10.5	49
73499	92173	34775	48590	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	10.5	49
73499	92173	34775	90364	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	10.5	49
73499	92173	34775	17149	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	10.5	49
73499	92173	34775	77760	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	10.5	49
73499	92173	34775	70762	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	10.5	49
73499	92173	34775	94685	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	10.5	49
73499	92173	34775	69204	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	10.5	49
73499	92173	34775	21854	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	10.5	49
73499	92173	34775	75622	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	10.5	49
73499	92173	34775	24833	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	10.5	49
73499	92173	34775	33562	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	10.5	49
73499	92173	34775	86735	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	10.5	49
73499	94072	79655	81618	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	31.5	49
73499	94072	79655	27734	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	31.5	49
73499	92173	34775	61520	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	10.5	49
73499	94072	79655	52396	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	31.5	49
73499	94072	79655	69098	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	31.5	49
73499	94072	79655	13265	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	31.5	49
73499	92173	34775	33445	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	10.5	49
73499	92173	34775	69464	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	10.5	49
62872	58906	64162	44034	5.2/10	5.9/10	5.4/10	9.7/10	8.0/10	582	50.0	57
73499	92173	34775	87373	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	10.5	49
73499	92173	34775	36467	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	10.5	49
73499	92173	34775	69596	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	10.5	49
73499	94072	79655	21820	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	31.5	49
73499	94072	79655	52477	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	31.5	49
73499	92173	34775	95010	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	10.5	49
73499	92173	34775	31495	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	10.5	49
73499	92173	34775	26193	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	10.5	49
73499	92173	34775	21952	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	10.5	49
73499	92173	34775	24963	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	10.5	49
73499	94072	79655	68903	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	31.5	49
73499	94072	79655	93109	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	31.5	49
73499	92173	34775	57571	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	10.5	49
73499	92173	34775	21181	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	10.5	49
73499	92173	34775	78657	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	10.5	49
73499	10773	81267	60343	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	578	34.0	49
73499	10773	81267	77065	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	578	34.0	49
73499	94072	34775	90225	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	10.5	49
73499	92173	34775	30958	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	10.5	49
73499	92173	34775	59634	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	10.5	49
73499	94072	79655	82134	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	31.5	49
62872	58906	64162	85385	5.2/10	5.9/10	5.4/10	9.7/10	8.0/10	582	50.0	57
73499	94072	79655	59886	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	31.5	49
73499	92173	34775	32398	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	10.5	49
73499	94072	79655	53934	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	31.5	49
73499	92173	34775	84120	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	10.5	49
73499	92173	34775	96445	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	10.5	49
73499	94072	79655	29672	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	31.5	49
73499	94072	79655	31249	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	31.5	49
73499	92173	34775	28953	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	10.5	49
73499	92173	34775	33444	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	10.5	49
73499	92173	34775	16725	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	10.5	49
73499	94072	34775	64995	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	10.5	49
73499	94072	79655	50378	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	31.5	49
73499	94072	79655	50569	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	31.5	49
73499	94072	79655	68491	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	31.5	49
73499	92173	34775	47851	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	10.5	49
73499	92173	34775	92110	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	10.5	49
73499	92173	34775	33684	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	10.5	49
73499	92173	34775	25408	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	10.5	49
73499	92173	34775	27245	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	10.5	49
73499	92173	34775	36588	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	10.5	49
73499	94072	79655	10463	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	31.5	49
62872	58906	36698	56380	5.2/10	5.9/10	5.4/10	9.7/10	8.0/10	582	50.0	57
73499	94072	79655	91600	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	31.5	49
73499	94072	79655	43175	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	31.5	49
73499	92173	34775	11600	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	10.5	49
73499	10773	88419	70115	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	578	84.0	49
73499	92173	34775	75225	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	10.5	49
73499	80101	79655	75358	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	\N	31.5	49
73499	10773	81267	81237	6.3/10	6.5/10	5.7/10	7.7/10	7.7/10	578	34.0	49
77698	19514	10932	10753	5.7/10	5.8/10	5.2/10	9.9/10	8.0/10	\N	0.0	50
77698	19514	10932	89689	5.7/10	5.8/10	5.2/10	9.9/10	8.0/10	\N	0.0	50
77698	19514	10932	74679	5.7/10	5.8/10	5.2/10	9.9/10	8.0/10	\N	0.0	50
77698	19514	10932	41179	5.7/10	5.8/10	5.2/10	9.9/10	8.0/10	\N	0.0	50
77698	19514	10932	38426	5.7/10	5.8/10	5.2/10	9.9/10	8.0/10	\N	0.0	50
77698	19514	10932	87183	5.7/10	5.8/10	5.2/10	9.9/10	8.0/10	\N	0.0	50
77698	19514	10932	96438	5.7/10	5.8/10	5.2/10	9.9/10	8.0/10	\N	0.0	50
77698	19514	10932	72352	5.7/10	5.8/10	5.2/10	9.9/10	8.0/10	\N	0.0	50
77698	19514	10932	69472	5.7/10	5.8/10	5.2/10	9.9/10	8.0/10	\N	0.0	50
77698	19514	10932	63759	5.7/10	5.8/10	5.2/10	9.9/10	8.0/10	\N	0.0	50
77698	19514	10932	67917	5.7/10	5.8/10	5.2/10	9.9/10	8.0/10	\N	0.0	50
77698	19514	10932	20407	5.7/10	5.8/10	5.2/10	9.9/10	8.0/10	\N	0.0	50
77698	19514	10932	88802	5.7/10	5.8/10	5.2/10	9.9/10	8.0/10	\N	0.0	50
77698	19514	10932	88656	5.7/10	5.8/10	5.2/10	9.9/10	8.0/10	\N	0.0	50
77698	19514	10932	10861	5.7/10	5.8/10	5.2/10	9.9/10	8.0/10	\N	0.0	50
77698	19514	10932	42075	5.7/10	5.8/10	5.2/10	9.9/10	8.0/10	\N	0.0	50
77698	19514	10932	81741	5.7/10	5.8/10	5.2/10	9.9/10	8.0/10	\N	0.0	50
77698	19514	10932	46452	5.7/10	5.8/10	5.2/10	9.9/10	8.0/10	\N	0.0	50
77698	19514	10932	91233	5.7/10	5.8/10	5.2/10	9.9/10	8.0/10	\N	0.0	50
77698	19514	10932	92396	5.7/10	5.8/10	5.2/10	9.9/10	8.0/10	\N	0.0	50
77698	19514	10932	83079	5.7/10	5.8/10	5.2/10	9.9/10	8.0/10	\N	0.0	50
77698	19514	10932	16411	5.7/10	5.8/10	5.2/10	9.9/10	8.0/10	\N	0.0	50
77698	19514	10932	34227	5.7/10	5.8/10	5.2/10	9.9/10	8.0/10	\N	0.0	50
77698	19514	10932	29432	5.7/10	5.8/10	5.2/10	9.9/10	8.0/10	\N	0.0	50
77698	19514	10932	17217	5.7/10	5.8/10	5.2/10	9.9/10	8.0/10	\N	0.0	50
77698	19514	10932	95626	5.7/10	5.8/10	5.2/10	9.9/10	8.0/10	\N	0.0	50
77698	19514	10932	55746	5.7/10	5.8/10	5.2/10	9.9/10	8.0/10	\N	0.0	50
77698	19514	10932	14813	5.7/10	5.8/10	5.2/10	9.9/10	8.0/10	\N	0.0	50
17367	75907	31134	29054	8.8/10	5.3/10	6.0/10	6.1/10	9.2/10	\N	50.0	51
17367	75907	31134	14250	8.8/10	5.3/10	6.0/10	6.1/10	9.2/10	\N	50.0	51
17367	75907	31134	97424	8.8/10	5.3/10	6.0/10	6.1/10	9.2/10	\N	50.0	51
77537	94072	78126	85771	9.4/10	6.1/10	5.3/10	9.5/10	8.1/10	\N	44.5	52
77537	80101	81267	89073	9.4/10	6.1/10	5.3/10	9.5/10	8.1/10	\N	0.0	52
77537	86756	79655	53399	9.4/10	6.1/10	5.3/10	9.5/10	8.1/10	\N	31.5	52
77537	80101	79655	21495	9.4/10	6.1/10	5.3/10	9.5/10	8.1/10	\N	31.5	52
77537	86756	79655	16426	9.4/10	6.1/10	5.3/10	9.5/10	8.1/10	\N	31.5	52
77537	86756	59155	24272	9.4/10	6.1/10	5.3/10	9.5/10	8.1/10	\N	26.5	52
77537	94072	59155	64651	9.4/10	6.1/10	5.3/10	9.5/10	8.1/10	\N	26.5	52
77537	94072	47128	33363	9.4/10	6.1/10	5.3/10	9.5/10	8.1/10	\N	3.5	52
77537	94072	59155	31146	9.4/10	6.1/10	5.3/10	9.5/10	8.1/10	\N	26.5	52
77537	86756	79655	98092	9.4/10	6.1/10	5.3/10	9.5/10	8.1/10	\N	31.5	52
77537	94072	79655	47274	9.4/10	6.1/10	5.3/10	9.5/10	8.1/10	\N	31.5	52
77537	94072	59155	90096	9.4/10	6.1/10	5.3/10	9.5/10	8.1/10	\N	26.5	52
77537	94072	78126	87983	9.4/10	6.1/10	5.3/10	9.5/10	8.1/10	\N	44.5	52
77537	94072	63588	85010	9.4/10	6.1/10	5.3/10	9.5/10	8.1/10	\N	0.0	52
77537	94072	78126	83685	9.4/10	6.1/10	5.3/10	9.5/10	8.1/10	\N	44.5	52
77537	94072	78126	33254	9.4/10	6.1/10	5.3/10	9.5/10	8.1/10	\N	44.5	52
77537	94072	78126	85886	9.4/10	6.1/10	5.3/10	9.5/10	8.1/10	\N	44.5	52
77537	80101	79655	57210	9.4/10	6.1/10	5.3/10	9.5/10	8.1/10	\N	31.5	52
77537	94072	78126	14697	9.4/10	6.1/10	5.3/10	9.5/10	8.1/10	\N	44.5	52
77537	80101	79655	22206	9.4/10	6.1/10	5.3/10	9.5/10	8.1/10	\N	31.5	52
77537	80101	79655	49229	9.4/10	6.1/10	5.3/10	9.5/10	8.1/10	\N	31.5	52
77537	80101	79655	52312	9.4/10	6.1/10	5.3/10	9.5/10	8.1/10	\N	31.5	52
77537	94072	78126	58309	9.4/10	6.1/10	5.3/10	9.5/10	8.1/10	\N	44.5	52
77537	94072	63588	59668	9.4/10	6.1/10	5.3/10	9.5/10	8.1/10	\N	0.0	52
77537	94072	78126	18869	9.4/10	6.1/10	5.3/10	9.5/10	8.1/10	\N	44.5	52
77537	94072	78126	66010	9.4/10	6.1/10	5.3/10	9.5/10	8.1/10	\N	44.5	52
30836	59992	31134	82151	9.6/10	4.9/10	4.8/10	9.9/10	7.7/10	435	84.5	53
18600	27875	43244	18509	8.3/10	5.5/10	6.0/10	6.7/10	8.0/10	847	39.0	54
18600	61248	43244	48382	8.3/10	5.5/10	6.0/10	6.7/10	8.0/10	1085	50.0	54
18600	61248	43244	71710	8.3/10	5.5/10	6.0/10	6.7/10	8.0/10	1085	50.0	54
18600	61248	43244	27635	8.3/10	5.5/10	6.0/10	6.7/10	8.0/10	1085	50.0	54
18600	61248	43244	25993	8.3/10	5.5/10	6.0/10	6.7/10	8.0/10	1085	50.0	54
18600	61248	43244	45968	8.3/10	5.5/10	6.0/10	6.7/10	8.0/10	1085	50.0	54
18600	61248	43244	53150	8.3/10	5.5/10	6.0/10	6.7/10	8.0/10	1085	50.0	54
18600	61248	43244	79081	8.3/10	5.5/10	6.0/10	6.7/10	8.0/10	1085	50.0	54
18600	61248	43244	64232	8.3/10	5.5/10	6.0/10	6.7/10	8.0/10	1085	50.0	54
18600	61248	43244	78766	8.3/10	5.5/10	6.0/10	6.7/10	8.0/10	1085	50.0	54
50779	81529	55224	37504	9.2/10	5.6/10	5.5/10	6.4/10	7.7/10	748	92.5	55
50779	81529	55224	37400	9.2/10	5.6/10	5.5/10	6.4/10	7.7/10	748	92.5	55
50779	81529	55224	90223	9.2/10	5.6/10	5.5/10	6.4/10	7.7/10	748	92.5	55
50779	81529	55224	17626	9.2/10	5.6/10	5.5/10	6.4/10	7.7/10	748	92.5	55
50779	81529	55224	24326	9.2/10	5.6/10	5.5/10	6.4/10	7.7/10	748	92.5	55
76426	36619	34775	84890	9.2/10	5.8/10	5.4/10	9.5/10	8.1/10	1003	57.0	56
76426	91338	59613	92441	9.2/10	5.8/10	5.4/10	9.5/10	8.1/10	1073	85.5	56
76426	36619	59613	79330	9.2/10	5.8/10	5.4/10	9.5/10	8.1/10	1003	84.5	56
76426	42943	59613	21491	9.2/10	5.8/10	5.4/10	9.5/10	8.1/10	1133	88.0	56
76426	36619	34775	73394	9.2/10	5.8/10	5.4/10	9.5/10	8.1/10	1003	57.0	56
62872	58906	36698	89269	5.2/10	5.9/10	5.4/10	9.7/10	8.0/10	582	50.0	57
62872	58906	64162	47642	5.2/10	5.9/10	5.4/10	9.7/10	8.0/10	582	50.0	57
62872	58906	64162	27001	5.2/10	5.9/10	5.4/10	9.7/10	8.0/10	582	50.0	57
62872	58906	36698	90516	5.2/10	5.9/10	5.4/10	9.7/10	8.0/10	582	50.0	57
62872	58906	64162	83745	5.2/10	5.9/10	5.4/10	9.7/10	8.0/10	582	50.0	57
62872	58906	64162	75063	5.2/10	5.9/10	5.4/10	9.7/10	8.0/10	582	50.0	57
27779	15475	12440	78118	8.4/10	5.2/10	5.3/10	8.9/10	8.1/10	\N	19.5	58
27779	26152	93574	92818	8.4/10	5.2/10	5.3/10	8.9/10	8.1/10	1382	80.0	58
27779	26152	93574	74553	8.4/10	5.2/10	5.3/10	8.9/10	8.1/10	1382	80.0	58
27779	26152	93574	33580	8.4/10	5.2/10	5.3/10	8.9/10	8.1/10	1382	80.0	58
27779	60860	83872	89876	8.4/10	5.2/10	5.3/10	8.9/10	8.1/10	1828	100.0	58
27779	26152	93574	40503	8.4/10	5.2/10	5.3/10	8.9/10	8.1/10	1382	80.0	58
27779	26152	93574	48074	8.4/10	5.2/10	5.3/10	8.9/10	8.1/10	1382	80.0	58
27779	26152	93574	35369	8.4/10	5.2/10	5.3/10	8.9/10	8.1/10	1382	80.0	58
27779	60860	93574	10207	8.4/10	5.2/10	5.3/10	8.9/10	8.1/10	1828	92.0	58
27779	26152	93574	25493	8.4/10	5.2/10	5.3/10	8.9/10	8.1/10	1382	80.0	58
27779	26152	93574	13143	8.4/10	5.2/10	5.3/10	8.9/10	8.1/10	1382	80.0	58
27779	26152	93574	70933	8.4/10	5.2/10	5.3/10	8.9/10	8.1/10	1382	80.0	58
27779	26152	93574	91980	8.4/10	5.2/10	5.3/10	8.9/10	8.1/10	1382	80.0	58
27779	26152	93574	25456	8.4/10	5.2/10	5.3/10	8.9/10	8.1/10	1382	80.0	58
27779	26152	93574	37175	8.4/10	5.2/10	5.3/10	8.9/10	8.1/10	1382	80.0	58
27779	26152	93574	90649	8.4/10	5.2/10	5.3/10	8.9/10	8.1/10	1382	80.0	58
17553	78236	31134	51744	7.8/10	5.3/10	10.0/10	9.9/10	5.5/10	536	98.0	64
27779	60860	93574	64346	8.4/10	5.2/10	5.3/10	8.9/10	8.1/10	1828	92.0	58
27779	26152	93574	15962	8.4/10	5.2/10	5.3/10	8.9/10	8.1/10	1382	80.0	58
27779	26152	93574	53750	8.4/10	5.2/10	5.3/10	8.9/10	8.1/10	1382	80.0	58
27779	26152	93574	55829	8.4/10	5.2/10	5.3/10	8.9/10	8.1/10	1382	80.0	58
27779	26152	93574	83454	8.4/10	5.2/10	5.3/10	8.9/10	8.1/10	1382	80.0	58
27779	26152	93574	93558	8.4/10	5.2/10	5.3/10	8.9/10	8.1/10	1382	80.0	58
27779	26152	93574	37831	8.4/10	5.2/10	5.3/10	8.9/10	8.1/10	1382	80.0	58
27779	26152	93574	11480	8.4/10	5.2/10	5.3/10	8.9/10	8.1/10	1382	80.0	58
27779	26152	93574	93967	8.4/10	5.2/10	5.3/10	8.9/10	8.1/10	1382	80.0	58
27779	26152	93574	36370	8.4/10	5.2/10	5.3/10	8.9/10	8.1/10	1382	80.0	58
27779	26152	93574	46913	8.4/10	5.2/10	5.3/10	8.9/10	8.1/10	1382	80.0	58
27779	26152	93574	43347	8.4/10	5.2/10	5.3/10	8.9/10	8.1/10	1382	80.0	58
27779	26152	93574	18891	8.4/10	5.2/10	5.3/10	8.9/10	8.1/10	1382	80.0	58
27779	26152	93574	50340	8.4/10	5.2/10	5.3/10	8.9/10	8.1/10	1382	80.0	58
27779	26152	93574	49358	8.4/10	5.2/10	5.3/10	8.9/10	8.1/10	1382	80.0	58
27779	26152	93574	76412	8.4/10	5.2/10	5.3/10	8.9/10	8.1/10	1382	80.0	58
27779	60860	93574	82088	8.4/10	5.2/10	5.3/10	8.9/10	8.1/10	1828	92.0	58
27779	26152	93574	52457	8.4/10	5.2/10	5.3/10	8.9/10	8.1/10	1382	80.0	58
27779	26152	93574	10803	8.4/10	5.2/10	5.3/10	8.9/10	8.1/10	1382	80.0	58
27779	15475	83872	99893	8.4/10	5.2/10	5.3/10	8.9/10	8.1/10	\N	50.0	58
27779	60860	93574	53684	8.4/10	5.2/10	5.3/10	8.9/10	8.1/10	1828	92.0	58
27779	26152	93574	61910	8.4/10	5.2/10	5.3/10	8.9/10	8.1/10	1382	80.0	58
27779	26152	93574	84569	8.4/10	5.2/10	5.3/10	8.9/10	8.1/10	1382	80.0	58
27779	60860	93574	13816	8.4/10	5.2/10	5.3/10	8.9/10	8.1/10	1828	92.0	58
27779	60860	93574	33020	8.4/10	5.2/10	5.3/10	8.9/10	8.1/10	1828	92.0	58
27779	26152	93574	53321	8.4/10	5.2/10	5.3/10	8.9/10	8.1/10	1382	80.0	58
27779	26152	83872	54294	8.4/10	5.2/10	5.3/10	8.9/10	8.1/10	1382	88.0	58
27779	26152	93574	98142	8.4/10	5.2/10	5.3/10	8.9/10	8.1/10	1382	80.0	58
27779	26152	93574	72797	8.4/10	5.2/10	5.3/10	8.9/10	8.1/10	1382	80.0	58
27779	15475	83872	72193	8.4/10	5.2/10	5.3/10	8.9/10	8.1/10	\N	50.0	58
27779	26152	93574	14660	8.4/10	5.2/10	5.3/10	8.9/10	8.1/10	1382	80.0	58
27779	26152	83872	94626	8.4/10	5.2/10	5.3/10	8.9/10	8.1/10	1382	88.0	58
27779	26152	93574	27793	8.4/10	5.2/10	5.3/10	8.9/10	8.1/10	1382	80.0	58
27779	26152	83872	73110	8.4/10	5.2/10	5.3/10	8.9/10	8.1/10	1382	88.0	58
27779	60860	83872	30366	8.4/10	5.2/10	5.3/10	8.9/10	8.1/10	1828	100.0	58
27779	60860	83872	92208	8.4/10	5.2/10	5.3/10	8.9/10	8.1/10	1828	100.0	58
27779	60860	83872	70374	8.4/10	5.2/10	5.3/10	8.9/10	8.1/10	1828	100.0	58
27779	60860	83872	53923	8.4/10	5.2/10	5.3/10	8.9/10	8.1/10	1828	100.0	58
27779	60860	83872	70616	8.4/10	5.2/10	5.3/10	8.9/10	8.1/10	1828	100.0	58
27779	60860	83872	64257	8.4/10	5.2/10	5.3/10	8.9/10	8.1/10	1828	100.0	58
27779	60860	83872	17342	8.4/10	5.2/10	5.3/10	8.9/10	8.1/10	1828	100.0	58
27779	60860	83872	78298	8.4/10	5.2/10	5.3/10	8.9/10	8.1/10	1828	100.0	58
27779	60860	83872	49235	8.4/10	5.2/10	5.3/10	8.9/10	8.1/10	1828	100.0	58
27779	60860	83872	84048	8.4/10	5.2/10	5.3/10	8.9/10	8.1/10	1828	100.0	58
27779	60860	83872	98892	8.4/10	5.2/10	5.3/10	8.9/10	8.1/10	1828	100.0	58
27779	60860	83872	51353	8.4/10	5.2/10	5.3/10	8.9/10	8.1/10	1828	100.0	58
27779	60860	83872	80239	8.4/10	5.2/10	5.3/10	8.9/10	8.1/10	1828	100.0	58
27779	60860	83872	37297	8.4/10	5.2/10	5.3/10	8.9/10	8.1/10	1828	100.0	58
27779	60860	83872	85680	8.4/10	5.2/10	5.3/10	8.9/10	8.1/10	1828	100.0	58
27779	60860	83872	99848	8.4/10	5.2/10	5.3/10	8.9/10	8.1/10	1828	100.0	58
27779	60860	83872	53479	8.4/10	5.2/10	5.3/10	8.9/10	8.1/10	1828	100.0	58
27779	60860	83872	18678	8.4/10	5.2/10	5.3/10	8.9/10	8.1/10	1828	100.0	58
27779	60860	83872	29569	8.4/10	5.2/10	5.3/10	8.9/10	8.1/10	1828	100.0	58
27779	60860	83872	46760	8.4/10	5.2/10	5.3/10	8.9/10	8.1/10	1828	100.0	58
27779	60860	83872	14085	8.4/10	5.2/10	5.3/10	8.9/10	8.1/10	1828	100.0	58
27779	60860	83872	54453	8.4/10	5.2/10	5.3/10	8.9/10	8.1/10	1828	100.0	58
27779	60860	83872	59183	8.4/10	5.2/10	5.3/10	8.9/10	8.1/10	1828	100.0	58
27779	60860	83872	92118	8.4/10	5.2/10	5.3/10	8.9/10	8.1/10	1828	100.0	58
27779	60860	83872	80028	8.4/10	5.2/10	5.3/10	8.9/10	8.1/10	1828	100.0	58
27779	60860	83872	31753	8.4/10	5.2/10	5.3/10	8.9/10	8.1/10	1828	100.0	58
27779	82754	83872	84839	8.4/10	5.2/10	5.3/10	8.9/10	8.1/10	933	75.5	58
27779	60860	83872	89388	8.4/10	5.2/10	5.3/10	8.9/10	8.1/10	1828	100.0	58
27779	26152	93574	61061	8.4/10	5.2/10	5.3/10	8.9/10	8.1/10	1382	80.0	58
78719	10659	25509	34560	8.3/10	6.1/10	6.1/10	7.2/10	7.3/10	617	90.5	59
78719	10659	25509	88012	8.3/10	6.1/10	6.1/10	7.2/10	7.3/10	617	90.5	59
78719	10659	25509	25315	8.3/10	6.1/10	6.1/10	7.2/10	7.3/10	617	90.5	59
78719	10659	25509	50407	8.3/10	6.1/10	6.1/10	7.2/10	7.3/10	617	90.5	59
78719	10659	25509	14145	8.3/10	6.1/10	6.1/10	7.2/10	7.3/10	617	90.5	59
78719	10659	25509	45585	8.3/10	6.1/10	6.1/10	7.2/10	7.3/10	617	90.5	59
78719	10659	25509	64246	8.3/10	6.1/10	6.1/10	7.2/10	7.3/10	617	90.5	59
78719	91338	57880	21376	8.3/10	6.1/10	6.1/10	7.2/10	7.3/10	1073	70.5	59
84537	21157	34775	75149	9.4/10	6.1/10	5.3/10	9.5/10	7.6/10	1265	60.5	60
84537	21157	73407	41148	9.4/10	6.1/10	5.3/10	9.5/10	7.6/10	1265	52.0	60
84537	81765	46118	58704	9.4/10	6.1/10	5.3/10	9.5/10	7.6/10	1138	75.5	60
84537	21157	99208	69232	9.4/10	6.1/10	5.3/10	9.5/10	7.6/10	1265	69.5	60
84537	81765	90200	49666	9.4/10	6.1/10	5.3/10	9.5/10	7.6/10	1138	80.0	60
84537	81765	73407	38329	9.4/10	6.1/10	5.3/10	9.5/10	7.6/10	1138	47.0	60
84537	81765	46118	78825	9.4/10	6.1/10	5.3/10	9.5/10	7.6/10	1138	75.5	60
84537	21157	99208	49625	9.4/10	6.1/10	5.3/10	9.5/10	7.6/10	1265	69.5	60
84537	21157	34775	32939	9.4/10	6.1/10	5.3/10	9.5/10	7.6/10	1265	60.5	60
17553	78236	31134	45527	7.8/10	5.3/10	10.0/10	9.9/10	5.5/10	536	98.0	64
32772	90689	25509	24710	7.9/10	5.4/10	5.5/10	6.0/10	9.4/10	566	86.5	61
32772	61653	25509	59049	7.9/10	5.4/10	5.5/10	6.0/10	9.4/10	587	88.0	61
32772	10659	25509	14901	7.9/10	5.4/10	5.5/10	6.0/10	9.4/10	617	90.5	61
32772	80405	25509	36489	7.9/10	5.4/10	5.5/10	6.0/10	9.4/10	\N	40.5	61
32772	90689	25509	22137	7.9/10	5.4/10	5.5/10	6.0/10	9.4/10	566	86.5	61
32772	10659	25509	68166	7.9/10	5.4/10	5.5/10	6.0/10	9.4/10	617	90.5	61
35265	28671	12440	76321	8.1/10	4.9/10	5.4/10	8.9/10	8.1/10	699	54.0	62
35265	19452	93574	13268	8.1/10	4.9/10	5.4/10	8.9/10	8.1/10	1010	92.0	62
36309	91039	26762	73263	8.8/10	6.0/10	5.3/10	6.4/10	8.1/10	1769	93.5	63
36309	91039	26762	75543	8.8/10	6.0/10	5.3/10	6.4/10	8.1/10	1769	93.5	63
36309	91039	26762	30195	8.8/10	6.0/10	5.3/10	6.4/10	8.1/10	1769	93.5	63
36309	91039	26762	54579	8.8/10	6.0/10	5.3/10	6.4/10	8.1/10	1769	93.5	63
36309	91039	26762	73369	8.8/10	6.0/10	5.3/10	6.4/10	8.1/10	1769	93.5	63
36309	91039	26762	78632	8.8/10	6.0/10	5.3/10	6.4/10	8.1/10	1769	93.5	63
36309	91039	83872	50679	8.8/10	6.0/10	5.3/10	6.4/10	8.1/10	1769	100.0	63
36309	91039	26762	52904	8.8/10	6.0/10	5.3/10	6.4/10	8.1/10	1769	93.5	63
36309	91039	26762	28781	8.8/10	6.0/10	5.3/10	6.4/10	8.1/10	1769	93.5	63
36309	91039	83872	22878	8.8/10	6.0/10	5.3/10	6.4/10	8.1/10	1769	100.0	63
36309	91039	26762	77652	8.8/10	6.0/10	5.3/10	6.4/10	8.1/10	1769	93.5	63
36309	91039	15655	98698	8.8/10	6.0/10	5.3/10	6.4/10	8.1/10	1769	100.0	63
36309	91039	15655	27395	8.8/10	6.0/10	5.3/10	6.4/10	8.1/10	1769	100.0	63
36309	91039	15655	36894	8.8/10	6.0/10	5.3/10	6.4/10	8.1/10	1769	100.0	63
36309	91039	15655	14791	8.8/10	6.0/10	5.3/10	6.4/10	8.1/10	1769	100.0	63
36309	91039	26762	70210	8.8/10	6.0/10	5.3/10	6.4/10	8.1/10	1769	93.5	63
36309	91039	26762	60801	8.8/10	6.0/10	5.3/10	6.4/10	8.1/10	1769	93.5	63
36309	91039	83872	78464	8.8/10	6.0/10	5.3/10	6.4/10	8.1/10	1769	100.0	63
36309	91039	83872	25182	8.8/10	6.0/10	5.3/10	6.4/10	8.1/10	1769	100.0	63
36309	91039	83872	10538	8.8/10	6.0/10	5.3/10	6.4/10	8.1/10	1769	100.0	63
36309	91039	15655	15771	8.8/10	6.0/10	5.3/10	6.4/10	8.1/10	1769	100.0	63
17553	30889	94837	87894	7.8/10	5.3/10	10.0/10	9.9/10	5.5/10	526	96.0	64
17553	30889	94837	21413	7.8/10	5.3/10	10.0/10	9.9/10	5.5/10	526	96.0	64
17553	78236	94837	71194	7.8/10	5.3/10	10.0/10	9.9/10	5.5/10	536	97.0	64
17553	30889	94837	16047	7.8/10	5.3/10	10.0/10	9.9/10	5.5/10	526	96.0	64
17553	78236	31134	23513	7.8/10	5.3/10	10.0/10	9.9/10	5.5/10	536	98.0	64
17553	30889	94837	78233	7.8/10	5.3/10	10.0/10	9.9/10	5.5/10	526	96.0	64
17553	78236	94837	50957	7.8/10	5.3/10	10.0/10	9.9/10	5.5/10	536	97.0	64
17553	78236	31134	12946	7.8/10	5.3/10	10.0/10	9.9/10	5.5/10	536	98.0	64
17553	78236	31134	85701	7.8/10	5.3/10	10.0/10	9.9/10	5.5/10	536	98.0	64
17553	78236	31134	50913	7.8/10	5.3/10	10.0/10	9.9/10	5.5/10	536	98.0	64
17553	78236	31134	93735	7.8/10	5.3/10	10.0/10	9.9/10	5.5/10	536	98.0	64
17553	78236	31134	52058	7.8/10	5.3/10	10.0/10	9.9/10	5.5/10	536	98.0	64
17553	78236	31134	36287	7.8/10	5.3/10	10.0/10	9.9/10	5.5/10	536	98.0	64
17553	78236	31134	35237	7.8/10	5.3/10	10.0/10	9.9/10	5.5/10	536	98.0	64
17553	78236	31134	47560	7.8/10	5.3/10	10.0/10	9.9/10	5.5/10	536	98.0	64
17553	78236	31134	46261	7.8/10	5.3/10	10.0/10	9.9/10	5.5/10	536	98.0	64
17553	78236	31134	79766	7.8/10	5.3/10	10.0/10	9.9/10	5.5/10	536	98.0	64
17553	78236	31134	51831	7.8/10	5.3/10	10.0/10	9.9/10	5.5/10	536	98.0	64
17553	78236	31134	67817	7.8/10	5.3/10	10.0/10	9.9/10	5.5/10	536	98.0	64
17553	78236	31134	97965	7.8/10	5.3/10	10.0/10	9.9/10	5.5/10	536	98.0	64
17553	78236	31134	25420	7.8/10	5.3/10	10.0/10	9.9/10	5.5/10	536	98.0	64
17553	78236	31134	45737	7.8/10	5.3/10	10.0/10	9.9/10	5.5/10	536	98.0	64
17553	78236	31134	29571	7.8/10	5.3/10	10.0/10	9.9/10	5.5/10	536	98.0	64
17553	78236	31134	30643	7.8/10	5.3/10	10.0/10	9.9/10	5.5/10	536	98.0	64
17553	78236	31134	45866	7.8/10	5.3/10	10.0/10	9.9/10	5.5/10	536	98.0	64
17553	78236	31134	25002	7.8/10	5.3/10	10.0/10	9.9/10	5.5/10	536	98.0	64
17553	78236	31134	11999	7.8/10	5.3/10	10.0/10	9.9/10	5.5/10	536	98.0	64
17553	78236	94837	91650	7.8/10	5.3/10	10.0/10	9.9/10	5.5/10	536	97.0	64
17553	78236	31134	83351	7.8/10	5.3/10	10.0/10	9.9/10	5.5/10	536	98.0	64
17553	78236	31134	77378	7.8/10	5.3/10	10.0/10	9.9/10	5.5/10	536	98.0	64
17553	78236	31134	23418	7.8/10	5.3/10	10.0/10	9.9/10	5.5/10	536	98.0	64
17553	78236	31134	37076	7.8/10	5.3/10	10.0/10	9.9/10	5.5/10	536	98.0	64
17553	78236	31134	81110	7.8/10	5.3/10	10.0/10	9.9/10	5.5/10	536	98.0	64
17553	30889	94837	55916	7.8/10	5.3/10	10.0/10	9.9/10	5.5/10	526	96.0	64
17553	78236	94837	82006	7.8/10	5.3/10	10.0/10	9.9/10	5.5/10	536	97.0	64
17553	78236	31134	28554	7.8/10	5.3/10	10.0/10	9.9/10	5.5/10	536	98.0	64
17553	78236	31134	85246	7.8/10	5.3/10	10.0/10	9.9/10	5.5/10	536	98.0	64
17553	78236	31134	42089	7.8/10	5.3/10	10.0/10	9.9/10	5.5/10	536	98.0	64
17553	78236	31134	32449	7.8/10	5.3/10	10.0/10	9.9/10	5.5/10	536	98.0	64
17553	78236	94837	19337	7.8/10	5.3/10	10.0/10	9.9/10	5.5/10	536	97.0	64
17553	78236	31134	50812	7.8/10	5.3/10	10.0/10	9.9/10	5.5/10	536	98.0	64
17553	78236	31134	90381	7.8/10	5.3/10	10.0/10	9.9/10	5.5/10	536	98.0	64
17553	78236	31134	54399	7.8/10	5.3/10	10.0/10	9.9/10	5.5/10	536	98.0	64
17553	78236	31134	80854	7.8/10	5.3/10	10.0/10	9.9/10	5.5/10	536	98.0	64
17553	78236	31134	68149	7.8/10	5.3/10	10.0/10	9.9/10	5.5/10	536	98.0	64
17553	78236	31134	16648	7.8/10	5.3/10	10.0/10	9.9/10	5.5/10	536	98.0	64
17553	78236	31134	27049	7.8/10	5.3/10	10.0/10	9.9/10	5.5/10	536	98.0	64
17553	78236	31134	13800	7.8/10	5.3/10	10.0/10	9.9/10	5.5/10	536	98.0	64
17553	78236	31134	71700	7.8/10	5.3/10	10.0/10	9.9/10	5.5/10	536	98.0	64
17553	78236	31134	98538	7.8/10	5.3/10	10.0/10	9.9/10	5.5/10	536	98.0	64
17553	78236	31134	16613	7.8/10	5.3/10	10.0/10	9.9/10	5.5/10	536	98.0	64
17553	78236	31134	23884	7.8/10	5.3/10	10.0/10	9.9/10	5.5/10	536	98.0	64
42701	19514	10932	60279	4.9/10	5.8/10	5.2/10	9.9/10	7.9/10	\N	0.0	65
42701	19514	10932	21287	4.9/10	5.8/10	5.2/10	9.9/10	7.9/10	\N	0.0	65
42701	19514	10932	61369	4.9/10	5.8/10	5.2/10	9.9/10	7.9/10	\N	0.0	65
42701	19514	10932	33459	4.9/10	5.8/10	5.2/10	9.9/10	7.9/10	\N	0.0	65
42701	19514	82165	88134	4.9/10	5.8/10	5.2/10	9.9/10	7.9/10	\N	0.0	65
42701	19514	10932	87693	4.9/10	5.8/10	5.2/10	9.9/10	7.9/10	\N	0.0	65
42701	19514	10932	92505	4.9/10	5.8/10	5.2/10	9.9/10	7.9/10	\N	0.0	65
42701	19514	10932	68436	4.9/10	5.8/10	5.2/10	9.9/10	7.9/10	\N	0.0	65
42701	19514	10932	90781	4.9/10	5.8/10	5.2/10	9.9/10	7.9/10	\N	0.0	65
42701	19514	10932	56612	4.9/10	5.8/10	5.2/10	9.9/10	7.9/10	\N	0.0	65
42701	19514	10932	50952	4.9/10	5.8/10	5.2/10	9.9/10	7.9/10	\N	0.0	65
42701	19514	10932	53559	4.9/10	5.8/10	5.2/10	9.9/10	7.9/10	\N	0.0	65
42701	19514	10932	35971	4.9/10	5.8/10	5.2/10	9.9/10	7.9/10	\N	0.0	65
42701	19514	10932	97932	4.9/10	5.8/10	5.2/10	9.9/10	7.9/10	\N	0.0	65
42701	19514	10932	20295	4.9/10	5.8/10	5.2/10	9.9/10	7.9/10	\N	0.0	65
42701	19514	10932	71039	4.9/10	5.8/10	5.2/10	9.9/10	7.9/10	\N	0.0	65
42701	19514	10932	84421	4.9/10	5.8/10	5.2/10	9.9/10	7.9/10	\N	0.0	65
42701	19514	10932	27274	4.9/10	5.8/10	5.2/10	9.9/10	7.9/10	\N	0.0	65
42701	19514	10932	22178	4.9/10	5.8/10	5.2/10	9.9/10	7.9/10	\N	0.0	65
42701	19514	10932	71377	4.9/10	5.8/10	5.2/10	9.9/10	7.9/10	\N	0.0	65
42701	19514	10932	22748	4.9/10	5.8/10	5.2/10	9.9/10	7.9/10	\N	0.0	65
42701	19514	10932	69714	4.9/10	5.8/10	5.2/10	9.9/10	7.9/10	\N	0.0	65
42701	19514	10932	50683	4.9/10	5.8/10	5.2/10	9.9/10	7.9/10	\N	0.0	65
42701	19514	10932	99715	4.9/10	5.8/10	5.2/10	9.9/10	7.9/10	\N	0.0	65
42701	19514	10932	94465	4.9/10	5.8/10	5.2/10	9.9/10	7.9/10	\N	0.0	65
42701	19514	10932	71675	4.9/10	5.8/10	5.2/10	9.9/10	7.9/10	\N	0.0	65
14334	91338	12942	40368	8.1/10	5.6/10	4.9/10	6.0/10	8.1/10	1073	93.5	66
14334	91338	27658	39333	8.1/10	5.6/10	4.9/10	6.0/10	8.1/10	1073	97.5	66
14334	91338	27658	28837	8.1/10	5.6/10	4.9/10	6.0/10	8.1/10	1073	97.5	66
14334	91338	27658	90863	8.1/10	5.6/10	4.9/10	6.0/10	8.1/10	1073	97.5	66
14334	91338	27658	43823	8.1/10	5.6/10	4.9/10	6.0/10	8.1/10	1073	97.5	66
14334	91338	27658	57638	8.1/10	5.6/10	4.9/10	6.0/10	8.1/10	1073	97.5	66
14334	91338	27658	61390	8.1/10	5.6/10	4.9/10	6.0/10	8.1/10	1073	97.5	66
14334	91338	27658	34032	8.1/10	5.6/10	4.9/10	6.0/10	8.1/10	1073	97.5	66
14334	42943	27658	97186	8.1/10	5.6/10	4.9/10	6.0/10	8.1/10	1133	100.0	66
14334	91338	27658	53296	8.1/10	5.6/10	4.9/10	6.0/10	8.1/10	1073	97.5	66
14334	91338	27658	52567	8.1/10	5.6/10	4.9/10	6.0/10	8.1/10	1073	97.5	66
14334	91338	27658	69412	8.1/10	5.6/10	4.9/10	6.0/10	8.1/10	1073	97.5	66
14334	91338	27658	73898	8.1/10	5.6/10	4.9/10	6.0/10	8.1/10	1073	97.5	66
14334	91338	27658	13966	8.1/10	5.6/10	4.9/10	6.0/10	8.1/10	1073	97.5	66
14334	91338	27658	18567	8.1/10	5.6/10	4.9/10	6.0/10	8.1/10	1073	97.5	66
14334	91338	27658	72303	8.1/10	5.6/10	4.9/10	6.0/10	8.1/10	1073	97.5	66
14334	91338	27658	24796	8.1/10	5.6/10	4.9/10	6.0/10	8.1/10	1073	97.5	66
14334	91338	12942	56064	8.1/10	5.6/10	4.9/10	6.0/10	8.1/10	1073	93.5	66
14334	91338	27658	72737	8.1/10	5.6/10	4.9/10	6.0/10	8.1/10	1073	97.5	66
14334	91338	27658	70455	8.1/10	5.6/10	4.9/10	6.0/10	8.1/10	1073	97.5	66
14334	91338	27658	32387	8.1/10	5.6/10	4.9/10	6.0/10	8.1/10	1073	97.5	66
14334	91338	27658	46996	8.1/10	5.6/10	4.9/10	6.0/10	8.1/10	1073	97.5	66
14334	91338	12942	55693	8.1/10	5.6/10	4.9/10	6.0/10	8.1/10	1073	93.5	66
14334	91338	27658	89225	8.1/10	5.6/10	4.9/10	6.0/10	8.1/10	1073	97.5	66
14334	91338	27658	85324	8.1/10	5.6/10	4.9/10	6.0/10	8.1/10	1073	97.5	66
14334	91338	27658	26697	8.1/10	5.6/10	4.9/10	6.0/10	8.1/10	1073	97.5	66
14334	91338	12942	76577	8.1/10	5.6/10	4.9/10	6.0/10	8.1/10	1073	93.5	66
14334	91338	27658	23491	8.1/10	5.6/10	4.9/10	6.0/10	8.1/10	1073	97.5	66
14334	42943	27658	63174	8.1/10	5.6/10	4.9/10	6.0/10	8.1/10	1133	100.0	66
14334	42943	27658	24022	8.1/10	5.6/10	4.9/10	6.0/10	8.1/10	1133	100.0	66
14334	42943	27658	52712	8.1/10	5.6/10	4.9/10	6.0/10	8.1/10	1133	100.0	66
14334	42943	27658	82895	8.1/10	5.6/10	4.9/10	6.0/10	8.1/10	1133	100.0	66
14334	42943	27658	95124	8.1/10	5.6/10	4.9/10	6.0/10	8.1/10	1133	100.0	66
69827	63011	12440	19296	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	795	56.5	67
69827	47070	12440	79828	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	70420	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	62535	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	87402	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	64190	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	91379	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	41941	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	81820	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	30843	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	60307	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	18658	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	54658	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	37294	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	87459	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	66511	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	67062	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	84345	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	54852	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	81372	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	40953	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	32686	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	96849	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	97766	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	20209	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	85260	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	24984	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	87616	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	88128	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	70674	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	52647	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	82756	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	22799	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	68355	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	33091	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	79533	12440	50374	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	63188	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	19123	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	88415	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	24253	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	99850	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	59664	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	52914	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	47070	12440	74788	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	94540	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	96529	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	18058	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	21866	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	79533	12440	38522	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	47070	12440	28208	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	79533	12440	93379	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	10024	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	47070	12440	29231	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	96623	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	69372	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	79632	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	48207	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	61115	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	79533	12440	90684	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	68610	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	35646	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	36956	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	99327	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	51497	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	49286	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	99071	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	47070	12440	49917	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	66980	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	55123	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	86379	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	11064	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	90149	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	79533	12440	76902	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	62978	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	26718	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	48559	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	18180	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	58394	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	81943	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	16963	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	10110	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	83404	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	57086	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	24378	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	46989	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	47070	12440	14087	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	40833	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	66585	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	79533	12440	87353	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	61677	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	47070	12440	91948	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	51697	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	60173	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	63219	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	79533	12440	60012	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	67041	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	81449	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	37684	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	96833	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	32729	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	72242	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	28228	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	34671	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	82800	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	60409	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	57223	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	64687	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	47070	12440	30220	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	79533	12440	47810	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	97826	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	26455	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	47070	12440	27600	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	11520	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	19403	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	94985	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	79533	12440	12058	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	28873	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	73792	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	47070	12440	67243	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	27796	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	21097	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	79533	12440	27985	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	94180	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	64507	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	47070	12440	69772	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	89223	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	65797	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	91690	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	79533	12440	33566	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	69558	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	76770	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	47070	12440	65590	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	68988	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	79533	12440	60425	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	47070	12440	56570	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	39588	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	79533	12440	34352	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	65675	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	89242	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	10973	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	85751	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	75294	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	41031	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	75762	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	47070	12440	45291	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	63849	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	79533	12440	81587	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	85543	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	58099	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	14385	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	14963	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	47070	12440	84468	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	79533	12440	73342	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	47070	12440	58310	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	24832	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	86056	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	79533	12440	73115	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	28623	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	78997	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	46624	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	70940	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	77757	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	20254	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	78597	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	21592	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	47070	12440	42142	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	92662	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	96997	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	97650	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	20234	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	99662	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	79533	12440	93058	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	80673	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	47070	12440	85973	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	50959	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	16917	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	55029	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	80127	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	11413	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	79533	12440	71455	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	69511	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	77195	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	47070	12440	71503	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	85230	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	53452	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	65183	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	56257	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	48616	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	79533	12440	47907	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	31955	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	47070	12440	14630	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	88333	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	49855	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	83886	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	44136	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	18050	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	92483	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	72018	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	79533	12440	85778	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	32161	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	47070	93574	85085	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	92.0	67
69827	47070	12440	16765	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	96025	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	48240	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	13578	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	47593	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	79533	12440	73538	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	20814	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	26622	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	76269	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	20074	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	46418	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	47070	12440	43036	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	27372	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	79533	12440	90713	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	46827	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	46073	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	43679	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	11861	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	89144	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	32886	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	87564	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	29809	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	96396	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	47070	12440	68543	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	58466	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	32989	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	44242	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	40958	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	73559	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	79533	12440	33699	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	47070	12440	79125	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	14337	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	54937	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	21062	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	29014	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	88059	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	30204	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	79533	12440	75004	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	64125	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	60222	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	41188	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	96594	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	67695	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	93568	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	31926	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	37637	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	85727	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	55229	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	17120	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	44654	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	79533	12440	25203	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
69827	47070	12440	16884	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	31967	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	70819	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	62264	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	72420	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	49500	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	72425	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	79798	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	40626	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	47070	12440	59781	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	926	69.5	67
69827	79533	12440	99589	8.8/10	5.9/10	5.2/10	6.3/10	8.1/10	1081	69.5	67
16626	30889	94837	61127	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	526	96.0	68
16626	30889	94837	44422	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	526	96.0	68
16626	30889	94837	79526	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	526	96.0	68
16626	30889	94837	66981	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	526	96.0	68
16626	30889	94837	11554	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	526	96.0	68
16626	30889	94837	47852	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	526	96.0	68
16626	30889	94837	60070	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	526	96.0	68
16626	30889	94837	98931	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	526	96.0	68
16626	30889	94837	51377	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	526	96.0	68
16626	30889	94837	79501	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	526	96.0	68
16626	30889	94837	99505	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	526	96.0	68
16626	30889	94837	22761	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	526	96.0	68
16626	18936	94837	79637	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	394	84.0	68
16626	18936	94837	93548	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	394	84.0	68
16626	30889	94837	56376	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	526	96.0	68
16626	30889	94837	66595	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	526	96.0	68
16626	30889	94837	90017	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	526	96.0	68
16626	30889	94837	95467	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	526	96.0	68
16626	30889	94837	45728	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	526	96.0	68
16626	18936	94837	53904	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	394	84.0	68
16626	30889	94837	45432	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	526	96.0	68
16626	78236	31134	45007	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	536	98.0	68
16626	78236	31134	22881	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	536	98.0	68
16626	30889	94837	43468	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	526	96.0	68
16626	30889	94837	95766	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	526	96.0	68
16626	78236	31134	61269	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	536	98.0	68
16626	30889	94837	70438	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	526	96.0	68
16626	34100	31134	98511	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	596	82.5	68
16626	34100	31134	41692	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	596	82.5	68
16626	34100	31134	98065	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	596	82.5	68
16626	78236	31134	87165	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	536	98.0	68
16626	78236	31134	35549	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	536	98.0	68
16626	78236	31134	78151	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	536	98.0	68
16626	34100	31134	54224	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	596	82.5	68
16626	34100	31134	98829	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	596	82.5	68
16626	30889	94837	33582	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	526	96.0	68
16626	78236	31134	51060	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	536	98.0	68
16626	78236	31134	81776	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	536	98.0	68
16626	78236	31134	11386	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	536	98.0	68
16626	30889	94837	98185	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	526	96.0	68
16626	78236	31134	18906	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	536	98.0	68
16626	78236	31134	22805	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	536	98.0	68
16626	78236	31134	78847	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	536	98.0	68
16626	78236	31134	23619	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	536	98.0	68
16626	34100	31134	99849	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	596	82.5	68
16626	78236	31134	68450	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	536	98.0	68
16626	78236	31134	56073	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	536	98.0	68
16626	78236	31134	38759	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	536	98.0	68
16626	38830	31134	47132	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	560	100.0	68
16626	78236	31134	43016	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	536	98.0	68
16626	78236	31134	35307	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	536	98.0	68
16626	78236	31134	14461	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	536	98.0	68
16626	78236	31134	13106	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	536	98.0	68
16626	78236	31134	91185	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	536	98.0	68
16626	78236	31134	22050	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	536	98.0	68
16626	78236	94837	87874	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	536	97.0	68
16626	78236	31134	96062	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	536	98.0	68
16626	78236	31134	38419	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	536	98.0	68
16626	78236	31134	88562	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	536	98.0	68
16626	34100	31134	25963	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	596	82.5	68
16626	78236	31134	25725	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	536	98.0	68
16626	34100	31134	89257	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	596	82.5	68
16626	78236	31134	27027	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	536	98.0	68
16626	78236	31134	59277	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	536	98.0	68
16626	78236	31134	96034	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	536	98.0	68
16626	78236	31134	94922	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	536	98.0	68
16626	78236	31134	84195	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	536	98.0	68
16626	78236	31134	34217	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	536	98.0	68
16626	78236	31134	24528	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	536	98.0	68
16626	78236	31134	34151	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	536	98.0	68
16626	78236	31134	43205	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	536	98.0	68
16626	78236	31134	48609	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	536	98.0	68
16626	78236	31134	71204	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	536	98.0	68
16626	78236	31134	96570	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	536	98.0	68
16626	34100	31134	19924	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	596	82.5	68
16626	78236	31134	93726	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	536	98.0	68
16626	78236	31134	69433	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	536	98.0	68
16626	78236	31134	46226	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	536	98.0	68
16626	78236	31134	65965	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	536	98.0	68
16626	78236	31134	52389	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	536	98.0	68
16626	78236	31134	43729	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	536	98.0	68
16626	78236	31134	19698	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	536	98.0	68
16626	78236	31134	46344	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	536	98.0	68
16626	78236	31134	18177	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	536	98.0	68
16626	78236	31134	60174	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	536	98.0	68
16626	78236	31134	60933	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	536	98.0	68
16626	78236	31134	53601	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	536	98.0	68
16626	78236	31134	17872	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	536	98.0	68
16626	78236	31134	43847	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	536	98.0	68
16626	78236	31134	44690	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	536	98.0	68
16626	30889	94837	33321	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	526	96.0	68
16626	38830	31134	67747	9.2/10	5.4/10	6.1/10	6.7/10	8.2/10	560	100.0	68
57235	40740	15136	19096	7.1/10	5.1/10	5.0/10	9.7/10	8.2/10	585	45.5	69
57235	40740	15136	74450	7.1/10	5.1/10	5.0/10	9.7/10	8.2/10	585	45.5	69
57235	10960	15136	89993	7.1/10	5.1/10	5.0/10	9.7/10	8.2/10	546	56.0	69
36097	77350	26762	61463	8.1/10	7.0/10	10.0/10	9.9/10	4.2/10	1809	93.5	70
36097	77350	26762	33388	8.1/10	7.0/10	10.0/10	9.9/10	4.2/10	1809	93.5	70
36097	77350	26762	94604	8.1/10	7.0/10	10.0/10	9.9/10	4.2/10	1809	93.5	70
36097	77350	15655	74494	8.1/10	7.0/10	10.0/10	9.9/10	4.2/10	1809	100.0	70
36097	77350	15655	24212	8.1/10	7.0/10	10.0/10	9.9/10	4.2/10	1809	100.0	70
36097	77350	15655	28857	8.1/10	7.0/10	10.0/10	9.9/10	4.2/10	1809	100.0	70
36097	77350	15655	80861	8.1/10	7.0/10	10.0/10	9.9/10	4.2/10	1809	100.0	70
45910	91338	83872	66525	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1073	97.5	71
45910	42943	93574	38624	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1133	92.0	71
45910	91338	83872	23926	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1073	97.5	71
45910	91338	83872	67878	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1073	97.5	71
45910	91338	83872	43947	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1073	97.5	71
45910	91338	83872	14569	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1073	97.5	71
45910	91338	83872	19557	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1073	97.5	71
45910	91338	93574	19229	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1073	89.5	71
45910	91338	83872	84887	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1073	97.5	71
45910	91338	83872	42846	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1073	97.5	71
45910	91338	83872	68442	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1073	97.5	71
45910	91338	83872	12459	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1073	97.5	71
45910	91338	83872	75234	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1073	97.5	71
45910	91338	83872	29510	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1073	97.5	71
45910	91338	83872	95572	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1073	97.5	71
45910	91338	83872	93930	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1073	97.5	71
45910	91338	83872	10113	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1073	97.5	71
45910	91338	83872	14959	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1073	97.5	71
45910	91338	83872	97111	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1073	97.5	71
45910	91338	93574	61181	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1073	89.5	71
45910	91338	83872	44922	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1073	97.5	71
45910	91338	83872	29871	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1073	97.5	71
45910	91338	83872	53231	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1073	97.5	71
45910	91338	83872	61292	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1073	97.5	71
45910	91338	83872	85319	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1073	97.5	71
45910	91338	83872	10485	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1073	97.5	71
45910	91338	83872	74314	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1073	97.5	71
45910	91338	83872	72670	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1073	97.5	71
45910	91338	83872	62941	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1073	97.5	71
45910	91338	83872	19188	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1073	97.5	71
45910	91338	83872	39602	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1073	97.5	71
45910	91338	83872	10433	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1073	97.5	71
45910	91338	83872	60387	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1073	97.5	71
45910	91338	83872	73185	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1073	97.5	71
45910	91338	83872	25886	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1073	97.5	71
45910	91338	83872	80163	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1073	97.5	71
45910	91338	83872	57044	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1073	97.5	71
45910	91338	83872	53704	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1073	97.5	71
45910	91338	83872	99369	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1073	97.5	71
45910	91338	83872	62509	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1073	97.5	71
45910	91338	83872	17234	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1073	97.5	71
45910	91338	83872	92873	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1073	97.5	71
45910	91338	83872	94813	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1073	97.5	71
45910	42943	83872	21883	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1133	100.0	71
45910	91338	83872	57887	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1073	97.5	71
45910	91338	83872	80074	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1073	97.5	71
45910	91338	83872	54572	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1073	97.5	71
45910	91338	83872	20545	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1073	97.5	71
45910	91338	83872	70245	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1073	97.5	71
45910	91338	83872	48005	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1073	97.5	71
45910	91338	83872	94907	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1073	97.5	71
45910	42943	83872	36623	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1133	100.0	71
45910	91338	83872	33149	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1073	97.5	71
45910	91338	83872	82676	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1073	97.5	71
45910	91338	83872	15155	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1073	97.5	71
45910	91338	83872	60353	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1073	97.5	71
45910	91338	83872	96603	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1073	97.5	71
45910	91338	83872	35035	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1073	97.5	71
45910	91338	83872	49173	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1073	97.5	71
45910	91338	83872	61131	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1073	97.5	71
45910	42943	12440	92656	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1133	69.5	71
45910	91338	83872	73766	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1073	97.5	71
45910	91338	83872	21123	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1073	97.5	71
45910	91338	83872	92941	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1073	97.5	71
45910	91338	83872	67407	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1073	97.5	71
45910	91338	83872	34833	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1073	97.5	71
45910	91338	83872	28342	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1073	97.5	71
45910	91338	83872	14679	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1073	97.5	71
45910	91338	83872	35309	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1073	97.5	71
45910	91338	93574	13324	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1073	89.5	71
45910	91338	83872	87718	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1073	97.5	71
45910	42943	83872	41258	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1133	100.0	71
45910	42943	83872	74124	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1133	100.0	71
45910	42943	83872	60956	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1133	100.0	71
45910	42943	83872	18256	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1133	100.0	71
45910	42943	83872	80851	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1133	100.0	71
45910	42943	83872	94332	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1133	100.0	71
45910	42943	83872	50334	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1133	100.0	71
45910	42943	83872	75494	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1133	100.0	71
45910	42943	83872	79984	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1133	100.0	71
45910	42943	83872	68891	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1133	100.0	71
45910	42943	83872	12151	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1133	100.0	71
45910	42943	83872	14855	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1133	100.0	71
45910	42943	83872	54470	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1133	100.0	71
45910	42943	83872	17347	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1133	100.0	71
45910	42943	83872	54265	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1133	100.0	71
45910	42943	83872	15611	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1133	100.0	71
45910	42943	83872	63150	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1133	100.0	71
45910	42943	83872	25491	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1133	100.0	71
45910	42943	83872	37745	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1133	100.0	71
45910	42943	83872	95701	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1133	100.0	71
45910	42943	83872	97466	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1133	100.0	71
45910	42943	83872	78566	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1133	100.0	71
45910	42943	83872	70079	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1133	100.0	71
45910	42943	83872	98877	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1133	100.0	71
45910	42943	83872	29523	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1133	100.0	71
45910	42943	83872	85936	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1133	100.0	71
45910	42943	83872	40537	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1133	100.0	71
45910	42943	83872	19441	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1133	100.0	71
45910	42943	83872	14833	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1133	100.0	71
45910	42943	83872	28558	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1133	100.0	71
45910	42943	83872	74080	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1133	100.0	71
45910	42943	83872	95699	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1133	100.0	71
45910	42943	83872	12498	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1133	100.0	71
45910	42943	83872	71763	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1133	100.0	71
45910	42943	83872	91051	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1133	100.0	71
45910	42943	83872	16003	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1133	100.0	71
45910	42943	83872	41808	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1133	100.0	71
45910	42943	83872	95037	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1133	100.0	71
45910	42943	83872	27109	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1133	100.0	71
45910	42943	83872	11882	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1133	100.0	71
45910	42943	83872	32577	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1133	100.0	71
45910	42943	83872	92924	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1133	100.0	71
45910	42943	83872	16548	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1133	100.0	71
45910	42943	83872	50283	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1133	100.0	71
45910	42943	83872	22752	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1133	100.0	71
45910	42943	83872	69793	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1133	100.0	71
45910	42943	83872	90114	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1133	100.0	71
45910	91338	83872	32372	8.3/10	5.1/10	5.4/10	7.2/10	8.1/10	1073	97.5	71
58280	79533	93574	87469	9.0/10	5.3/10	5.1/10	6.4/10	8.2/10	1081	92.0	72
58280	79533	93574	18383	9.0/10	5.3/10	5.1/10	6.4/10	8.2/10	1081	92.0	72
58280	79533	93574	23937	9.0/10	5.3/10	5.1/10	6.4/10	8.2/10	1081	92.0	72
58280	79533	93574	24965	9.0/10	5.3/10	5.1/10	6.4/10	8.2/10	1081	92.0	72
58280	79533	93574	75161	9.0/10	5.3/10	5.1/10	6.4/10	8.2/10	1081	92.0	72
58280	79533	93574	87984	9.0/10	5.3/10	5.1/10	6.4/10	8.2/10	1081	92.0	72
58280	79533	93574	90691	9.0/10	5.3/10	5.1/10	6.4/10	8.2/10	1081	92.0	72
70846	77350	32973	38910	9.0/10	5.6/10	4.9/10	6.4/10	8.1/10	1809	100.0	73
70846	77350	47548	18271	9.0/10	5.6/10	4.9/10	6.4/10	8.1/10	1809	85.0	73
70846	77350	47548	36560	9.0/10	5.6/10	4.9/10	6.4/10	8.1/10	1809	85.0	73
70846	94182	88311	65864	9.0/10	5.6/10	4.9/10	6.4/10	8.1/10	1579	74.5	73
76207	42943	79444	54216	7.4/10	7.3/10	7.2/10	9.9/10	4.4/10	1133	93.0	74
76207	42943	79444	62692	7.4/10	7.3/10	7.2/10	9.9/10	4.4/10	1133	93.0	74
76207	42943	79444	52498	7.4/10	7.3/10	7.2/10	9.9/10	4.4/10	1133	93.0	74
62028	94182	83872	25833	7.8/10	5.1/10	4.8/10	9.1/10	8.2/10	1579	93.5	75
62028	77350	26762	99664	7.8/10	5.1/10	4.8/10	9.1/10	8.2/10	1809	93.5	75
62028	25643	93574	85493	7.8/10	5.1/10	4.8/10	9.1/10	8.2/10	1235	76.0	75
62028	77350	15655	81550	7.8/10	5.1/10	4.8/10	9.1/10	8.2/10	1809	100.0	75
62028	77350	15655	28000	7.8/10	5.1/10	4.8/10	9.1/10	8.2/10	1809	100.0	75
62028	77350	15655	52151	7.8/10	5.1/10	4.8/10	9.1/10	8.2/10	1809	100.0	75
62028	77350	15655	37948	7.8/10	5.1/10	4.8/10	9.1/10	8.2/10	1809	100.0	75
62028	77350	15655	15975	7.8/10	5.1/10	4.8/10	9.1/10	8.2/10	1809	100.0	75
62028	77350	83872	87736	7.8/10	5.1/10	4.8/10	9.1/10	8.2/10	1809	100.0	75
62028	77350	15655	32734	7.8/10	5.1/10	4.8/10	9.1/10	8.2/10	1809	100.0	75
62028	77350	15655	53975	7.8/10	5.1/10	4.8/10	9.1/10	8.2/10	1809	100.0	75
62028	77350	15655	18286	7.8/10	5.1/10	4.8/10	9.1/10	8.2/10	1809	100.0	75
62028	77350	15655	45899	7.8/10	5.1/10	4.8/10	9.1/10	8.2/10	1809	100.0	75
62028	77350	15655	28512	7.8/10	5.1/10	4.8/10	9.1/10	8.2/10	1809	100.0	75
62028	77350	15655	64415	7.8/10	5.1/10	4.8/10	9.1/10	8.2/10	1809	100.0	75
62028	77350	15655	32026	7.8/10	5.1/10	4.8/10	9.1/10	8.2/10	1809	100.0	75
62028	77350	15655	58487	7.8/10	5.1/10	4.8/10	9.1/10	8.2/10	1809	100.0	75
62028	25643	93574	82536	7.8/10	5.1/10	4.8/10	9.1/10	8.2/10	1235	76.0	75
93284	19452	93574	28754	8.8/10	5.5/10	5.1/10	6.4/10	8.2/10	1010	92.0	76
62028	77350	15655	31627	7.8/10	5.1/10	4.8/10	9.1/10	8.2/10	1809	100.0	75
62028	77350	15655	67496	7.8/10	5.1/10	4.8/10	9.1/10	8.2/10	1809	100.0	75
62028	77350	15655	41934	7.8/10	5.1/10	4.8/10	9.1/10	8.2/10	1809	100.0	75
62028	77350	26762	86282	7.8/10	5.1/10	4.8/10	9.1/10	8.2/10	1809	93.5	75
62028	77350	26762	15334	7.8/10	5.1/10	4.8/10	9.1/10	8.2/10	1809	93.5	75
62028	77350	26762	23102	7.8/10	5.1/10	4.8/10	9.1/10	8.2/10	1809	93.5	75
62028	77350	26762	92863	7.8/10	5.1/10	4.8/10	9.1/10	8.2/10	1809	93.5	75
93284	19452	93574	90273	8.8/10	5.5/10	5.1/10	6.4/10	8.2/10	1010	92.0	76
93284	19452	93574	59300	8.8/10	5.5/10	5.1/10	6.4/10	8.2/10	1010	92.0	76
93284	19452	93574	30677	8.8/10	5.5/10	5.1/10	6.4/10	8.2/10	1010	92.0	76
93284	19452	93574	12048	8.8/10	5.5/10	5.1/10	6.4/10	8.2/10	1010	92.0	76
93284	19452	93574	73827	8.8/10	5.5/10	5.1/10	6.4/10	8.2/10	1010	92.0	76
93284	19452	83872	20580	8.8/10	5.5/10	5.1/10	6.4/10	8.2/10	1010	100.0	76
93284	19452	83872	10832	8.8/10	5.5/10	5.1/10	6.4/10	8.2/10	1010	100.0	76
93284	19452	83872	33516	8.8/10	5.5/10	5.1/10	6.4/10	8.2/10	1010	100.0	76
93284	19452	83872	21683	8.8/10	5.5/10	5.1/10	6.4/10	8.2/10	1010	100.0	76
93284	19452	83872	87821	8.8/10	5.5/10	5.1/10	6.4/10	8.2/10	1010	100.0	76
93284	19452	83872	47189	8.8/10	5.5/10	5.1/10	6.4/10	8.2/10	1010	100.0	76
93284	19452	83872	64555	8.8/10	5.5/10	5.1/10	6.4/10	8.2/10	1010	100.0	76
93284	19452	83872	72391	8.8/10	5.5/10	5.1/10	6.4/10	8.2/10	1010	100.0	76
93284	19452	83872	26632	8.8/10	5.5/10	5.1/10	6.4/10	8.2/10	1010	100.0	76
93284	19452	93574	37021	8.8/10	5.5/10	5.1/10	6.4/10	8.2/10	1010	92.0	76
93284	19452	83872	93863	8.8/10	5.5/10	5.1/10	6.4/10	8.2/10	1010	100.0	76
93284	19452	93574	45513	8.8/10	5.5/10	5.1/10	6.4/10	8.2/10	1010	92.0	76
93284	19452	93574	78562	8.8/10	5.5/10	5.1/10	6.4/10	8.2/10	1010	92.0	76
93284	19452	93574	69037	8.8/10	5.5/10	5.1/10	6.4/10	8.2/10	1010	92.0	76
93284	19452	83872	64005	8.8/10	5.5/10	5.1/10	6.4/10	8.2/10	1010	100.0	76
93284	19452	83872	32878	8.8/10	5.5/10	5.1/10	6.4/10	8.2/10	1010	100.0	76
93284	19452	93574	90024	8.8/10	5.5/10	5.1/10	6.4/10	8.2/10	1010	92.0	76
93284	19452	83872	14931	8.8/10	5.5/10	5.1/10	6.4/10	8.2/10	1010	100.0	76
93284	19452	83872	88154	8.8/10	5.5/10	5.1/10	6.4/10	8.2/10	1010	100.0	76
93284	19452	83872	33593	8.8/10	5.5/10	5.1/10	6.4/10	8.2/10	1010	100.0	76
93284	19452	83872	75521	8.8/10	5.5/10	5.1/10	6.4/10	8.2/10	1010	100.0	76
93284	19452	83872	90222	8.8/10	5.5/10	5.1/10	6.4/10	8.2/10	1010	100.0	76
93284	19452	83872	92207	8.8/10	5.5/10	5.1/10	6.4/10	8.2/10	1010	100.0	76
93284	19452	83872	49478	8.8/10	5.5/10	5.1/10	6.4/10	8.2/10	1010	100.0	76
93284	19452	83872	55593	8.8/10	5.5/10	5.1/10	6.4/10	8.2/10	1010	100.0	76
93284	19452	93574	64891	8.8/10	5.5/10	5.1/10	6.4/10	8.2/10	1010	92.0	76
93284	19452	83872	10599	8.8/10	5.5/10	5.1/10	6.4/10	8.2/10	1010	100.0	76
93284	19452	83872	83100	8.8/10	5.5/10	5.1/10	6.4/10	8.2/10	1010	100.0	76
93284	19452	83872	40885	8.8/10	5.5/10	5.1/10	6.4/10	8.2/10	1010	100.0	76
93284	19452	83872	35153	8.8/10	5.5/10	5.1/10	6.4/10	8.2/10	1010	100.0	76
93284	19452	93574	25401	8.8/10	5.5/10	5.1/10	6.4/10	8.2/10	1010	92.0	76
93284	19452	83872	79494	8.8/10	5.5/10	5.1/10	6.4/10	8.2/10	1010	100.0	76
93284	19452	93574	22541	8.8/10	5.5/10	5.1/10	6.4/10	8.2/10	1010	92.0	76
93284	19452	93574	91123	8.8/10	5.5/10	5.1/10	6.4/10	8.2/10	1010	92.0	76
26236	91338	59613	57435	8.4/10	5.7/10	6.4/10	7.2/10	7.8/10	1073	85.5	77
26236	36619	59613	80742	8.4/10	5.7/10	6.4/10	7.2/10	7.8/10	1003	84.5	77
26236	42943	59613	76524	8.4/10	5.7/10	6.4/10	7.2/10	7.8/10	1133	88.0	77
99282	39035	43244	38740	8.4/10	6.8/10	10.0/10	9.9/10	2.6/10	1068	46.5	78
99282	39035	43244	70845	8.4/10	6.8/10	10.0/10	9.9/10	2.6/10	1068	46.5	78
99282	39035	43244	92111	8.4/10	6.8/10	10.0/10	9.9/10	2.6/10	1068	46.5	78
99282	39035	43244	96419	8.4/10	6.8/10	10.0/10	9.9/10	2.6/10	1068	46.5	78
99282	39035	43244	37277	8.4/10	6.8/10	10.0/10	9.9/10	2.6/10	1068	46.5	78
99282	39035	43244	46231	8.4/10	6.8/10	10.0/10	9.9/10	2.6/10	1068	46.5	78
99282	39035	43244	35391	8.4/10	6.8/10	10.0/10	9.9/10	2.6/10	1068	46.5	78
99282	39035	43244	24769	8.4/10	6.8/10	10.0/10	9.9/10	2.6/10	1068	46.5	78
99282	39035	43244	99816	8.4/10	6.8/10	10.0/10	9.9/10	2.6/10	1068	46.5	78
99282	39035	43244	72182	8.4/10	6.8/10	10.0/10	9.9/10	2.6/10	1068	46.5	78
99282	39035	43244	75210	8.4/10	6.8/10	10.0/10	9.9/10	2.6/10	1068	46.5	78
99282	39035	43244	33111	8.4/10	6.8/10	10.0/10	9.9/10	2.6/10	1068	46.5	78
99282	39035	43244	30940	8.4/10	6.8/10	10.0/10	9.9/10	2.6/10	1068	46.5	78
99282	39035	43244	97836	8.4/10	6.8/10	10.0/10	9.9/10	2.6/10	1068	46.5	78
99282	39035	43244	15651	8.4/10	6.8/10	10.0/10	9.9/10	2.6/10	1068	46.5	78
99282	39035	43244	17081	8.4/10	6.8/10	10.0/10	9.9/10	2.6/10	1068	46.5	78
68471	79533	61792	69302	8.1/10	6.0/10	6.0/10	8.1/10	8.0/10	1081	66.5	83
99282	39035	43244	94523	8.4/10	6.8/10	10.0/10	9.9/10	2.6/10	1068	46.5	78
99282	39035	43244	57735	8.4/10	6.8/10	10.0/10	9.9/10	2.6/10	1068	46.5	78
99282	39035	43244	37471	8.4/10	6.8/10	10.0/10	9.9/10	2.6/10	1068	46.5	78
99282	39035	43244	42949	8.4/10	6.8/10	10.0/10	9.9/10	2.6/10	1068	46.5	78
99282	39035	43244	53816	8.4/10	6.8/10	10.0/10	9.9/10	2.6/10	1068	46.5	78
99282	39035	43244	90847	8.4/10	6.8/10	10.0/10	9.9/10	2.6/10	1068	46.5	78
99282	39035	43244	69394	8.4/10	6.8/10	10.0/10	9.9/10	2.6/10	1068	46.5	78
14005	25643	93574	15677	8.6/10	5.4/10	5.2/10	6.4/10	8.2/10	1235	76.0	79
14005	77350	83872	23686	8.6/10	5.4/10	5.2/10	6.4/10	8.2/10	1809	100.0	79
14005	25643	93574	16875	8.6/10	5.4/10	5.2/10	6.4/10	8.2/10	1235	76.0	79
14005	25643	93574	80432	8.6/10	5.4/10	5.2/10	6.4/10	8.2/10	1235	76.0	79
14005	77350	83872	13809	8.6/10	5.4/10	5.2/10	6.4/10	8.2/10	1809	100.0	79
14005	77350	93574	73577	8.6/10	5.4/10	5.2/10	6.4/10	8.2/10	1809	92.0	79
14005	77350	83872	77489	8.6/10	5.4/10	5.2/10	6.4/10	8.2/10	1809	100.0	79
14005	77350	83872	25212	8.6/10	5.4/10	5.2/10	6.4/10	8.2/10	1809	100.0	79
14005	77350	83872	40841	8.6/10	5.4/10	5.2/10	6.4/10	8.2/10	1809	100.0	79
14005	77350	83872	68303	8.6/10	5.4/10	5.2/10	6.4/10	8.2/10	1809	100.0	79
14005	77350	83872	87687	8.6/10	5.4/10	5.2/10	6.4/10	8.2/10	1809	100.0	79
14005	77350	83872	85990	8.6/10	5.4/10	5.2/10	6.4/10	8.2/10	1809	100.0	79
14005	77350	83872	52725	8.6/10	5.4/10	5.2/10	6.4/10	8.2/10	1809	100.0	79
14005	77350	83872	64927	8.6/10	5.4/10	5.2/10	6.4/10	8.2/10	1809	100.0	79
14005	77350	83872	36050	8.6/10	5.4/10	5.2/10	6.4/10	8.2/10	1809	100.0	79
14005	77350	62183	98716	8.6/10	5.4/10	5.2/10	6.4/10	8.2/10	1809	100.0	79
14005	77350	12440	52688	8.6/10	5.4/10	5.2/10	6.4/10	8.2/10	1809	69.5	79
14005	77350	83872	40154	8.6/10	5.4/10	5.2/10	6.4/10	8.2/10	1809	100.0	79
58819	79533	57151	24435	6.6/10	6.3/10	10.0/10	9.9/10	4.1/10	1081	85.5	80
58819	79533	57151	39855	6.6/10	6.3/10	10.0/10	9.9/10	4.1/10	1081	85.5	80
58819	79533	57151	22853	6.6/10	6.3/10	10.0/10	9.9/10	4.1/10	1081	85.5	80
58819	79533	57151	41079	6.6/10	6.3/10	10.0/10	9.9/10	4.1/10	1081	85.5	80
58819	79533	59572	64079	6.6/10	6.3/10	10.0/10	9.9/10	4.1/10	1081	97.5	80
58819	79533	59572	36208	6.6/10	6.3/10	10.0/10	9.9/10	4.1/10	1081	97.5	80
58819	79533	59572	59221	6.6/10	6.3/10	10.0/10	9.9/10	4.1/10	1081	97.5	80
58819	79533	59572	38922	6.6/10	6.3/10	10.0/10	9.9/10	4.1/10	1081	97.5	80
74066	30889	94837	71733	9.2/10	5.4/10	6.0/10	6.4/10	8.1/10	526	96.0	81
74066	78236	31134	86689	9.2/10	5.4/10	6.0/10	6.4/10	8.1/10	536	98.0	81
74066	78236	31134	73492	9.2/10	5.4/10	6.0/10	6.4/10	8.1/10	536	98.0	81
74066	78236	31134	17122	9.2/10	5.4/10	6.0/10	6.4/10	8.1/10	536	98.0	81
74066	78236	31134	67129	9.2/10	5.4/10	6.0/10	6.4/10	8.1/10	536	98.0	81
74066	38830	31134	28997	9.2/10	5.4/10	6.0/10	6.4/10	8.1/10	560	100.0	81
74066	38830	31134	38333	9.2/10	5.4/10	6.0/10	6.4/10	8.1/10	560	100.0	81
74066	78236	31134	89879	9.2/10	5.4/10	6.0/10	6.4/10	8.1/10	536	98.0	81
74066	38830	31134	69636	9.2/10	5.4/10	6.0/10	6.4/10	8.1/10	560	100.0	81
74066	38830	31134	33338	9.2/10	5.4/10	6.0/10	6.4/10	8.1/10	560	100.0	81
74066	38830	31134	60768	9.2/10	5.4/10	6.0/10	6.4/10	8.1/10	560	100.0	81
74066	38830	94837	58953	9.2/10	5.4/10	6.0/10	6.4/10	8.1/10	560	99.0	81
74066	78236	31134	27878	9.2/10	5.4/10	6.0/10	6.4/10	8.1/10	536	98.0	81
74066	78236	31134	69996	9.2/10	5.4/10	6.0/10	6.4/10	8.1/10	536	98.0	81
74066	30889	94837	35448	9.2/10	5.4/10	6.0/10	6.4/10	8.1/10	526	96.0	81
74066	38830	31134	92840	9.2/10	5.4/10	6.0/10	6.4/10	8.1/10	560	100.0	81
74066	78236	31134	57001	9.2/10	5.4/10	6.0/10	6.4/10	8.1/10	536	98.0	81
74066	38830	31134	45349	9.2/10	5.4/10	6.0/10	6.4/10	8.1/10	560	100.0	81
74066	38830	31134	36504	9.2/10	5.4/10	6.0/10	6.4/10	8.1/10	560	100.0	81
74066	78236	31134	54025	9.2/10	5.4/10	6.0/10	6.4/10	8.1/10	536	98.0	81
74066	38830	31134	26673	9.2/10	5.4/10	6.0/10	6.4/10	8.1/10	560	100.0	81
74066	78236	31134	14206	9.2/10	5.4/10	6.0/10	6.4/10	8.1/10	536	98.0	81
74066	38830	31134	84536	9.2/10	5.4/10	6.0/10	6.4/10	8.1/10	560	100.0	81
74066	38830	31134	17818	9.2/10	5.4/10	6.0/10	6.4/10	8.1/10	560	100.0	81
74066	38830	31134	46779	9.2/10	5.4/10	6.0/10	6.4/10	8.1/10	560	100.0	81
74066	38830	31134	27891	9.2/10	5.4/10	6.0/10	6.4/10	8.1/10	560	100.0	81
74066	78864	31134	24563	9.2/10	5.4/10	6.0/10	6.4/10	8.1/10	366	70.0	81
74066	78236	31134	71018	9.2/10	5.4/10	6.0/10	6.4/10	8.1/10	536	98.0	81
74066	78236	31134	70106	9.2/10	5.4/10	6.0/10	6.4/10	8.1/10	536	98.0	81
74066	78864	31134	64817	9.2/10	5.4/10	6.0/10	6.4/10	8.1/10	366	70.0	81
74066	78864	31134	55033	9.2/10	5.4/10	6.0/10	6.4/10	8.1/10	366	70.0	81
74066	78864	31134	38816	9.2/10	5.4/10	6.0/10	6.4/10	8.1/10	366	70.0	81
74066	78864	31134	48687	9.2/10	5.4/10	6.0/10	6.4/10	8.1/10	366	70.0	81
74066	78864	31134	89119	9.2/10	5.4/10	6.0/10	6.4/10	8.1/10	366	70.0	81
74066	78864	31134	30550	9.2/10	5.4/10	6.0/10	6.4/10	8.1/10	366	70.0	81
74066	78864	31134	93623	9.2/10	5.4/10	6.0/10	6.4/10	8.1/10	366	70.0	81
74066	78864	31134	90154	9.2/10	5.4/10	6.0/10	6.4/10	8.1/10	366	70.0	81
74066	78864	31134	32273	9.2/10	5.4/10	6.0/10	6.4/10	8.1/10	366	70.0	81
74066	38830	31134	85775	9.2/10	5.4/10	6.0/10	6.4/10	8.1/10	560	100.0	81
74066	78864	31134	82450	9.2/10	5.4/10	6.0/10	6.4/10	8.1/10	366	70.0	81
74066	78864	31134	40107	9.2/10	5.4/10	6.0/10	6.4/10	8.1/10	366	70.0	81
74066	78864	31134	21334	9.2/10	5.4/10	6.0/10	6.4/10	8.1/10	366	70.0	81
74066	78864	31134	63961	9.2/10	5.4/10	6.0/10	6.4/10	8.1/10	366	70.0	81
74066	38830	31134	78389	9.2/10	5.4/10	6.0/10	6.4/10	8.1/10	560	100.0	81
74066	38830	31134	74122	9.2/10	5.4/10	6.0/10	6.4/10	8.1/10	560	100.0	81
87862	23621	93574	38369	8.6/10	5.4/10	4.9/10	6.6/10	8.2/10	1234	92.0	82
68471	47070	65846	87539	8.1/10	6.0/10	6.0/10	8.1/10	8.0/10	926	55.5	83
68471	47070	65846	72061	8.1/10	6.0/10	6.0/10	8.1/10	8.0/10	926	55.5	83
68471	79533	61792	70655	8.1/10	6.0/10	6.0/10	8.1/10	8.0/10	1081	66.5	83
68471	79533	61792	46591	8.1/10	6.0/10	6.0/10	8.1/10	8.0/10	1081	66.5	83
68471	79533	61792	11901	8.1/10	6.0/10	6.0/10	8.1/10	8.0/10	1081	66.5	83
68471	79533	61792	66113	8.1/10	6.0/10	6.0/10	8.1/10	8.0/10	1081	66.5	83
68471	79533	61792	42329	8.1/10	6.0/10	6.0/10	8.1/10	8.0/10	1081	66.5	83
68471	79533	61792	42483	8.1/10	6.0/10	6.0/10	8.1/10	8.0/10	1081	66.5	83
68471	79533	61792	66917	8.1/10	6.0/10	6.0/10	8.1/10	8.0/10	1081	66.5	83
68471	47070	65846	85951	8.1/10	6.0/10	6.0/10	8.1/10	8.0/10	926	55.5	83
68471	79533	61792	39151	8.1/10	6.0/10	6.0/10	8.1/10	8.0/10	1081	66.5	83
68471	79533	61792	29525	8.1/10	6.0/10	6.0/10	8.1/10	8.0/10	1081	66.5	83
68471	47070	61792	85196	8.1/10	6.0/10	6.0/10	8.1/10	8.0/10	926	66.5	83
68471	79533	61792	10665	8.1/10	6.0/10	6.0/10	8.1/10	8.0/10	1081	66.5	83
68471	79533	61792	64758	8.1/10	6.0/10	6.0/10	8.1/10	8.0/10	1081	66.5	83
68471	79533	61792	15796	8.1/10	6.0/10	6.0/10	8.1/10	8.0/10	1081	66.5	83
68471	79533	61792	15250	8.1/10	6.0/10	6.0/10	8.1/10	8.0/10	1081	66.5	83
68471	79533	61792	71689	8.1/10	6.0/10	6.0/10	8.1/10	8.0/10	1081	66.5	83
68471	79533	61792	14406	8.1/10	6.0/10	6.0/10	8.1/10	8.0/10	1081	66.5	83
68471	79533	61792	72818	8.1/10	6.0/10	6.0/10	8.1/10	8.0/10	1081	66.5	83
68471	79533	61792	22844	8.1/10	6.0/10	6.0/10	8.1/10	8.0/10	1081	66.5	83
68471	79533	61792	74918	8.1/10	6.0/10	6.0/10	8.1/10	8.0/10	1081	66.5	83
68471	79533	61792	41524	8.1/10	6.0/10	6.0/10	8.1/10	8.0/10	1081	66.5	83
68471	47070	65846	20890	8.1/10	6.0/10	6.0/10	8.1/10	8.0/10	926	55.5	83
68471	79533	61792	83202	8.1/10	6.0/10	6.0/10	8.1/10	8.0/10	1081	66.5	83
68471	79533	61792	11628	8.1/10	6.0/10	6.0/10	8.1/10	8.0/10	1081	66.5	83
68471	79533	61792	63296	8.1/10	6.0/10	6.0/10	8.1/10	8.0/10	1081	66.5	83
68471	79533	61792	38574	8.1/10	6.0/10	6.0/10	8.1/10	8.0/10	1081	66.5	83
68471	79533	61792	27394	8.1/10	6.0/10	6.0/10	8.1/10	8.0/10	1081	66.5	83
68471	79533	61792	56976	8.1/10	6.0/10	6.0/10	8.1/10	8.0/10	1081	66.5	83
68471	79533	61792	48769	8.1/10	6.0/10	6.0/10	8.1/10	8.0/10	1081	66.5	83
68471	79533	61792	41334	8.1/10	6.0/10	6.0/10	8.1/10	8.0/10	1081	66.5	83
68471	79533	61792	94887	8.1/10	6.0/10	6.0/10	8.1/10	8.0/10	1081	66.5	83
68471	79533	61792	21892	8.1/10	6.0/10	6.0/10	8.1/10	8.0/10	1081	66.5	83
68471	79533	61792	12087	8.1/10	6.0/10	6.0/10	8.1/10	8.0/10	1081	66.5	83
68471	79533	61792	72886	8.1/10	6.0/10	6.0/10	8.1/10	8.0/10	1081	66.5	83
68471	79533	61792	97691	8.1/10	6.0/10	6.0/10	8.1/10	8.0/10	1081	66.5	83
68471	79533	61792	49955	8.1/10	6.0/10	6.0/10	8.1/10	8.0/10	1081	66.5	83
68471	79533	61792	31207	8.1/10	6.0/10	6.0/10	8.1/10	8.0/10	1081	66.5	83
68471	47070	61792	70199	8.1/10	6.0/10	6.0/10	8.1/10	8.0/10	926	66.5	83
68471	79533	62354	84760	8.1/10	6.0/10	6.0/10	8.1/10	8.0/10	1081	90.5	83
68471	79533	61792	86501	8.1/10	6.0/10	6.0/10	8.1/10	8.0/10	1081	66.5	83
68471	79533	61792	13199	8.1/10	6.0/10	6.0/10	8.1/10	8.0/10	1081	66.5	83
68471	79533	61792	69616	8.1/10	6.0/10	6.0/10	8.1/10	8.0/10	1081	66.5	83
68471	79533	61792	28169	8.1/10	6.0/10	6.0/10	8.1/10	8.0/10	1081	66.5	83
68471	79533	61792	63131	8.1/10	6.0/10	6.0/10	8.1/10	8.0/10	1081	66.5	83
68471	79533	61792	34241	8.1/10	6.0/10	6.0/10	8.1/10	8.0/10	1081	66.5	83
68471	79533	62354	58551	8.1/10	6.0/10	6.0/10	8.1/10	8.0/10	1081	90.5	83
68471	79533	61792	92157	8.1/10	6.0/10	6.0/10	8.1/10	8.0/10	1081	66.5	83
68471	79533	61792	70856	8.1/10	6.0/10	6.0/10	8.1/10	8.0/10	1081	66.5	83
68471	79533	61792	93021	8.1/10	6.0/10	6.0/10	8.1/10	8.0/10	1081	66.5	83
68471	79533	62354	10178	8.1/10	6.0/10	6.0/10	8.1/10	8.0/10	1081	90.5	83
68471	79533	61792	92222	8.1/10	6.0/10	6.0/10	8.1/10	8.0/10	1081	66.5	83
68471	79533	61792	19266	8.1/10	6.0/10	6.0/10	8.1/10	8.0/10	1081	66.5	83
68471	79533	61792	53634	8.1/10	6.0/10	6.0/10	8.1/10	8.0/10	1081	66.5	83
68471	79533	61792	14287	8.1/10	6.0/10	6.0/10	8.1/10	8.0/10	1081	66.5	83
68471	79533	61792	48874	8.1/10	6.0/10	6.0/10	8.1/10	8.0/10	1081	66.5	83
68471	79533	61792	65823	8.1/10	6.0/10	6.0/10	8.1/10	8.0/10	1081	66.5	83
68471	79533	61792	45361	8.1/10	6.0/10	6.0/10	8.1/10	8.0/10	1081	66.5	83
68471	79533	61792	90281	8.1/10	6.0/10	6.0/10	8.1/10	8.0/10	1081	66.5	83
68471	79533	61792	81098	8.1/10	6.0/10	6.0/10	8.1/10	8.0/10	1081	66.5	83
68471	79533	61792	85396	8.1/10	6.0/10	6.0/10	8.1/10	8.0/10	1081	66.5	83
68471	91039	86818	37151	8.1/10	6.0/10	6.0/10	8.1/10	8.0/10	1769	100.0	83
68471	91039	86818	99740	8.1/10	6.0/10	6.0/10	8.1/10	8.0/10	1769	100.0	83
68471	79533	61792	20611	8.1/10	6.0/10	6.0/10	8.1/10	8.0/10	1081	66.5	83
68471	91039	21382	91324	8.1/10	6.0/10	6.0/10	8.1/10	8.0/10	1769	77.0	83
68471	91039	46167	54000	8.1/10	6.0/10	6.0/10	8.1/10	8.0/10	1769	100.0	83
68471	91039	46167	17184	8.1/10	6.0/10	6.0/10	8.1/10	8.0/10	1769	100.0	83
68471	91039	46167	77467	8.1/10	6.0/10	6.0/10	8.1/10	8.0/10	1769	100.0	83
68471	79533	61792	98428	8.1/10	6.0/10	6.0/10	8.1/10	8.0/10	1081	66.5	83
68471	79533	61792	57708	8.1/10	6.0/10	6.0/10	8.1/10	8.0/10	1081	66.5	83
68471	79533	61792	16758	8.1/10	6.0/10	6.0/10	8.1/10	8.0/10	1081	66.5	83
68471	79533	61792	24544	8.1/10	6.0/10	6.0/10	8.1/10	8.0/10	1081	66.5	83
68471	79533	61792	60194	8.1/10	6.0/10	6.0/10	8.1/10	8.0/10	1081	66.5	83
68471	79533	61792	57918	8.1/10	6.0/10	6.0/10	8.1/10	8.0/10	1081	66.5	83
68471	79533	61792	70994	8.1/10	6.0/10	6.0/10	8.1/10	8.0/10	1081	66.5	83
68471	91039	21382	91151	8.1/10	6.0/10	6.0/10	8.1/10	8.0/10	1769	77.0	83
33276	79533	93574	15357	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1081	92.0	84
33276	79533	93574	57916	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1081	92.0	84
33276	79533	93574	58029	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1081	92.0	84
33276	79533	83872	32972	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1081	100.0	84
33276	79533	93574	94957	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1081	92.0	84
33276	79533	93574	83241	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1081	92.0	84
33276	79533	93574	18782	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1081	92.0	84
33276	79533	93574	83499	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1081	92.0	84
33276	63011	93574	36832	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	795	79.0	84
33276	79533	93574	53899	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1081	92.0	84
33276	91039	93574	80730	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	92.0	84
33276	79533	93574	24884	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1081	92.0	84
33276	79533	93574	95070	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1081	92.0	84
33276	79533	93574	72717	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1081	92.0	84
33276	91039	93574	86037	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	92.0	84
33276	79533	93574	37498	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1081	92.0	84
33276	79533	93574	39548	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1081	92.0	84
33276	91039	83872	52003	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	100.0	84
33276	91039	83872	56230	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	100.0	84
33276	79533	83872	45043	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1081	100.0	84
33276	79533	93574	76003	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1081	92.0	84
33276	91039	83872	99158	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	100.0	84
33276	91039	83872	65434	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	100.0	84
33276	79533	83872	46325	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1081	100.0	84
33276	79533	93574	17138	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1081	92.0	84
33276	91039	83872	18305	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	100.0	84
33276	91039	83872	58865	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	100.0	84
33276	91039	83872	55249	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	100.0	84
33276	79533	93574	69298	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1081	92.0	84
33276	91039	83872	73730	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	100.0	84
33276	91039	83872	75726	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	100.0	84
33276	91039	83872	79033	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	100.0	84
33276	91039	83872	26083	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	100.0	84
33276	91039	83872	71625	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	100.0	84
33276	91039	83872	79717	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	100.0	84
33276	79533	93574	79842	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1081	92.0	84
33276	91039	83872	48307	8.3/10	5.4/10	5.7/10	6.1/10	8.1/10	1769	100.0	84
\.


--
-- Name: dim_config dim_config_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_config
    ADD CONSTRAINT dim_config_pkey PRIMARY KEY (config_id);


--
-- Name: dim_cpu dim_cpu_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_cpu
    ADD CONSTRAINT dim_cpu_pkey PRIMARY KEY (cpu_id);


--
-- Name: dim_gpu dim_gpu_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_gpu
    ADD CONSTRAINT dim_gpu_pkey PRIMARY KEY (gpu_id);


--
-- Name: dim_laptop dim_laptop_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_laptop
    ADD CONSTRAINT dim_laptop_pkey PRIMARY KEY (laptop_id);


--
-- Name: fact_laptop_performance fact_laptop_performance_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_laptop_performance
    ADD CONSTRAINT fact_laptop_performance_pkey PRIMARY KEY (laptop_id, cpu_id, gpu_id, config_id);


--
-- Name: idx_fact_cpu; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fact_cpu ON public.fact_laptop_performance USING btree (cpu_id);


--
-- Name: idx_fact_gpu; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fact_gpu ON public.fact_laptop_performance USING btree (gpu_id);


--
-- Name: idx_fact_laptop; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fact_laptop ON public.fact_laptop_performance USING btree (laptop_id);


--
-- Name: fact_laptop_performance fact_laptop_performance_config_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_laptop_performance
    ADD CONSTRAINT fact_laptop_performance_config_id_fkey FOREIGN KEY (config_id) REFERENCES public.dim_config(config_id);


--
-- Name: fact_laptop_performance fact_laptop_performance_cpu_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_laptop_performance
    ADD CONSTRAINT fact_laptop_performance_cpu_id_fkey FOREIGN KEY (cpu_id) REFERENCES public.dim_cpu(cpu_id);


--
-- Name: fact_laptop_performance fact_laptop_performance_gpu_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_laptop_performance
    ADD CONSTRAINT fact_laptop_performance_gpu_id_fkey FOREIGN KEY (gpu_id) REFERENCES public.dim_gpu(gpu_id);


--
-- Name: fact_laptop_performance fact_laptop_performance_laptop_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_laptop_performance
    ADD CONSTRAINT fact_laptop_performance_laptop_id_fkey FOREIGN KEY (laptop_id) REFERENCES public.dim_laptop(laptop_id);


--
-- PostgreSQL database dump complete
--

