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
-- Name: characters; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.characters (
    character_id integer NOT NULL,
    name character varying(100) NOT NULL,
    description text
);


ALTER TABLE public.characters OWNER TO postgres;

--
-- Name: characters_character_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.characters_character_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.characters_character_id_seq OWNER TO postgres;

--
-- Name: characters_character_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.characters_character_id_seq OWNED BY public.characters.character_id;


--
-- Name: friends; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.friends (
    friend_id integer NOT NULL,
    character_id integer,
    friend_name text
);


ALTER TABLE public.friends OWNER TO postgres;

--
-- Name: friends_friend_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.friends_friend_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.friends_friend_id_seq OWNER TO postgres;

--
-- Name: friends_friend_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.friends_friend_id_seq OWNED BY public.friends.friend_id;


--
-- Name: goods; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.goods (
    goods_id integer NOT NULL,
    name character varying(100),
    character_id integer,
    category character varying(100),
    release_date date
);


ALTER TABLE public.goods OWNER TO postgres;

--
-- Name: goods_goods_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.goods_goods_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.goods_goods_id_seq OWNER TO postgres;

--
-- Name: goods_goods_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.goods_goods_id_seq OWNED BY public.goods.goods_id;


--
-- Name: high_rank_ov; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.high_rank_ov (
    high_rank_id integer NOT NULL,
    vote_count character varying(20),
    comment text
);


ALTER TABLE public.high_rank_ov OWNER TO postgres;

--
-- Name: high_rank_ov_high_rank_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.high_rank_ov_high_rank_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.high_rank_ov_high_rank_id_seq OWNER TO postgres;

--
-- Name: high_rank_ov_high_rank_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.high_rank_ov_high_rank_id_seq OWNED BY public.high_rank_ov.high_rank_id;


--
-- Name: low_rank_ov; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.low_rank_ov (
    low_rank_id integer NOT NULL
);


ALTER TABLE public.low_rank_ov OWNER TO postgres;

--
-- Name: low_rank_ov_low_rank_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.low_rank_ov_low_rank_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.low_rank_ov_low_rank_id_seq OWNER TO postgres;

--
-- Name: low_rank_ov_low_rank_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.low_rank_ov_low_rank_id_seq OWNED BY public.low_rank_ov.low_rank_id;


--
-- Name: news; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.news (
    news_id integer NOT NULL,
    title text,
    category character varying(100)
);


ALTER TABLE public.news OWNER TO postgres;

--
-- Name: news_character; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.news_character (
    news_id integer NOT NULL,
    character_id integer NOT NULL
);


ALTER TABLE public.news_character OWNER TO postgres;

--
-- Name: news_news_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.news_news_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.news_news_id_seq OWNER TO postgres;

--
-- Name: news_news_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.news_news_id_seq OWNED BY public.news.news_id;


--
-- Name: overall_rankings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.overall_rankings (
    overall_rank_id integer NOT NULL,
    character_id integer,
    rank integer NOT NULL,
    profile_link text,
    rank_category character varying(10) NOT NULL
);


ALTER TABLE public.overall_rankings OWNER TO postgres;

--
-- Name: overall_rankings_overall_rank_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.overall_rankings_overall_rank_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.overall_rankings_overall_rank_id_seq OWNER TO postgres;

--
-- Name: overall_rankings_overall_rank_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.overall_rankings_overall_rank_id_seq OWNED BY public.overall_rankings.overall_rank_id;


--
-- Name: region_rankings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.region_rankings (
    region_rank_id integer NOT NULL,
    region_id integer,
    rank integer NOT NULL,
    character_id integer,
    profile_link text
);


ALTER TABLE public.region_rankings OWNER TO postgres;

--
-- Name: region_rankings_region_rank_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.region_rankings_region_rank_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.region_rankings_region_rank_id_seq OWNER TO postgres;

--
-- Name: region_rankings_region_rank_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.region_rankings_region_rank_id_seq OWNED BY public.region_rankings.region_rank_id;


--
-- Name: regions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.regions (
    region_id integer NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE public.regions OWNER TO postgres;

--
-- Name: regions_region_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.regions_region_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.regions_region_id_seq OWNER TO postgres;

--
-- Name: regions_region_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.regions_region_id_seq OWNED BY public.regions.region_id;


--
-- Name: spot_character; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.spot_character (
    spot_id integer NOT NULL,
    character_id integer NOT NULL
);


ALTER TABLE public.spot_character OWNER TO postgres;

--
-- Name: spots; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.spots (
    spot_id integer NOT NULL,
    name character varying(100),
    place character varying(100),
    category character varying(100),
    date date
);


ALTER TABLE public.spots OWNER TO postgres;

--
-- Name: spots_spot_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.spots_spot_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.spots_spot_id_seq OWNER TO postgres;

--
-- Name: spots_spot_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.spots_spot_id_seq OWNED BY public.spots.spot_id;


--
-- Name: characters character_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.characters ALTER COLUMN character_id SET DEFAULT nextval('public.characters_character_id_seq'::regclass);


--
-- Name: friends friend_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.friends ALTER COLUMN friend_id SET DEFAULT nextval('public.friends_friend_id_seq'::regclass);


--
-- Name: goods goods_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.goods ALTER COLUMN goods_id SET DEFAULT nextval('public.goods_goods_id_seq'::regclass);


--
-- Name: high_rank_ov high_rank_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.high_rank_ov ALTER COLUMN high_rank_id SET DEFAULT nextval('public.high_rank_ov_high_rank_id_seq'::regclass);


--
-- Name: low_rank_ov low_rank_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.low_rank_ov ALTER COLUMN low_rank_id SET DEFAULT nextval('public.low_rank_ov_low_rank_id_seq'::regclass);


--
-- Name: news news_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.news ALTER COLUMN news_id SET DEFAULT nextval('public.news_news_id_seq'::regclass);


--
-- Name: overall_rankings overall_rank_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.overall_rankings ALTER COLUMN overall_rank_id SET DEFAULT nextval('public.overall_rankings_overall_rank_id_seq'::regclass);


--
-- Name: region_rankings region_rank_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.region_rankings ALTER COLUMN region_rank_id SET DEFAULT nextval('public.region_rankings_region_rank_id_seq'::regclass);


--
-- Name: regions region_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regions ALTER COLUMN region_id SET DEFAULT nextval('public.regions_region_id_seq'::regclass);


--
-- Name: spots spot_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.spots ALTER COLUMN spot_id SET DEFAULT nextval('public.spots_spot_id_seq'::regclass);


--
-- Data for Name: characters; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.characters (character_id, name, description) FROM stdin;
1	Pompompurin	A man's co of golden retriver, with a brown belly hat traded. Its a relaxing place, and youll love it. My hobby is gathering.
2	Cinnamoroll	This is a white cousin man born on a distant sky cloud. One day, I found a place where I could fly from the sky to the sister of Caf Cinnamon. The sy is like a cinnamon roll, so it is called cinnamon.
3	Pochacco	The origin of the name is pocha. It's curious and it's a little bit. A man of dogs who love to walk more way. Born in Uguise Yokocho.
4	KUROMI	Mymel rivals. It seems to be a ent, but it is very ent! Black and Pink Dokuro Charm Point. We are str ling to chromatify the world!
5	Hello Kitty	The name is Kitty White. Born in London, England. 5 s 3 s A bright and gentle girl.
6	My Melody	She is a girl who is a brother. The treasure was made by my grandmother. I like to bake cookies with my mother. Almond Pound Cake
7	Little Twin Stars	This is a two-day star created by the caring star of Yume Homo. I came from the country of a distant star to become a star that shines. My sister's Lara is a little crying. My brother is curious. I love it.
8	Hangyodon	A half fisherman born in China. I am good at laughing people. But actually, the romanticist of the sabi. I have always been a , but I dont have to do it. Tako's Sayuri-chan is a big one.
9	Tuxedosam	A fashionable penguin man who came from the Taxidou Island in the Antarctic. Its a little bit ry. Has 365 bow ties. I have been studying in England. English Body shape of bust, waist, hip, all 100cm.
10	AHIRUNOPEKKLE	A gentle man's heart. You can enjoy singing and dancing by yourself. When the pitch spurs, it dances. Tap Dance Lesson
11	BAD BADTZ-MARU	I love it and I love it. You can enjoy fine sushi and polyparis ramen in Ginza. Future dreams become the president. Is it true?
12	HANAMARUOBAKE	It is a strange aunt that gives you a honeymoon. The aunts seem to be surrounded by people, and there are different cos. You will be able to compliment your daily hard work and effort.
13	Cogimyun	Onnako (wheat flour). I really want to be onigiri, but I dont know what kind of onigiri is. It is a very ephemeral character that is scattered by a little thing.
14	Kerokerokeroppi	I love adventures, full of energy! Popular with Donut Pond. I am good at crawling with a bitterog swim. The song is good. I live in Kerokero House on the island of Donut Pond.
15	WISH ME MELL	The rabbit woman's cousin from France. Its a little bit ry, but its straight and gentle. The rainbow tail is a charm point. I have been supporting mail delivery at Mercy Hills.
16	GUDETAMA	It's good to cook. There are various cooking methods, but it is a egg. You are trying to eat your eggs! ?
17	USAHANA	A cheerful rabbit girl's cousin perfect for summer. The long ears and ed blue human mi are charm points. 3 tulip flowers. Weight is a mass cut. It's good.
18	MY SWEET PIANO	My Mel Friends It is a woman of the sheep, of the sweet beanbo. Charm Point is a baby pink fluffy hair. My favorite food is meringue cookies. You can pick and chat mel and flowers in Nohara.
19	GAOPOWERROO	Pappau is a powerful way to go to Omurais Island. The powerful power makes everyone Wow!OL
20	COROCOROKURIRIN	Its a little bit small, but its a curious golden hamster. Flower logo is a trademark. There are seven children: chibikuri, komichi, walnut, cherry, singo, milk, chacha.
21	KIRIMICHAN.	Kirimi-chan is born with the feeling that you want to eat deliciously at the moment you are carved. We are waiting for you to eat deliciously as a partner who is close to the table today with a lot of friends. It is very good for friends.
22	Marumofubiyori	Mopp is a shirokuma man who always comes to your favorite blanket. Im still living in an Indiana-style house where I live in the aquarium. It seems that the appearance of the blanket ised with a mop, so Mr. One gave the name Mop.
23	MARRONCREAM	female cousin born in the suburbs of Paris, France. She is good at making sweets and handicrafts. Bright and positive at any time. I am a French school. Cinnamon is the best friend of Nezmi.
24	Chococat	It is full of energetic! But a little bit of a little black cat. You can catch a variety of information with a hanger antenna.
25	SHOW BY ROCK!!	MIDICITY is a city where musicians are bound by. This story is the music legend of the boys and who dream of the top star. 10th anniversary in 2022 thanks to the support of all space rockers. Home
26	Charmmykitty	The girl of Persian Cat. A pet with a chiti birthday gift. The name is charming.
27	kabukinyantaro	Mige male (It is said that it is very rare and lucky). There are many collars like kabuki costume. The bell of the neck rings when you walk. Heart mark on the back.
28	SUGARBUNNIES	The brother of the genius Patissier, known as the world of the der. The sweets made by the two will make everyone happy.
29	Dear Daniel	Boyfriend The bang is a trade mark. 4 melons tall. 3 melons. Daniel went to Africa because of his cameramans work, but he came back from New York.
30	LLOROMANNIC	berries and cherries are two devils. Living in an old Western-style building near the town where cinnamon lives. I came from the world beyond the mirror.
31	MINNANOTABO	She is always bright and energetic. I sometimes fail, but at a cancer barber shop, my friend is too good! I love my younger brother Maa-kun.
32	Pokkyokuten	Pow is a shirokuma man who travels Pok to become a smiling and funny man. CH
33	Adorozatorumary	The Experimental Two-Screen Creative Unique was born in collaboration with the songer Ado on the stage of SANRIOLABO Sanrio Research Institute which creates new characters.
34	Aggretsuko	Reser working at the Keiri Department of Carriman Corporation. A long-awaited trading company, I think of the OL life in Marunouchi, and the reality is a daily sprinkling with supervisors and self-sufficient colleagues who push a tea-free job.
35	BONBONRIBBON	Bonbori Bonchan is a stylish pink rabbit. A big ribbon made by your favorite mom is a charm point.
36	nyaninyunyenyon	5 mins walk from Tokyo station. I like marshm. She is a woman who is shy.
37	JEWELPET	Jewel Pet is a magical pet that lives in Jewelland. You can use the magic of the same effect as the jewel. She is a magical school.
38	Tiny chum	I would like to go to my house while I went to New York. He is a man, but he likes his favorite kitty.
39	Marshmallowmitainafuwafuwanyanko	This man is like marshm. I live with a fashion designer egg boy in Paris. You can sing with a very beautiful singing voice.
40	Littleforestfellow	Mel and this man's co. The nickname is Mero-O and the habit of mouth is.
41	OSARUNOMONKICHI	Dajare loves monkeys. It is a gentleman who does not stop when you can do it once. The special technique is fast-drinking ofs. You can eat 10 pieces per minute. The dream of the future is to be.
42	PATTY&JIMMY	Love couple living in Kansas City, USA. Pati is a sports all-purpose, but it is hard to study. A girl who is full of energy. Jimmy lives in a house next to Patty and is good at studying and chess. Future dreams become the president.
43	CHEERY CHUMS	Cham is a slight, tea-eye, rabbit female co. Make cakes and cookies to ensure you get the best experience. Elephant pam, bear mue, pig pue, neko mue, and mouse tue. I'm enjoying it.
44	PETAPETAMINILIAN	A spaceman who is thinking of a wide space to the earth. The purpose is to collect seals. CH
45	Maimaimaigoen	Maimai Goen is a group show depicting heart growth pain by 16 children and nurses. A story that faces each individuals individuality, close to the modern sense of living.
46	PAUPIPO	The Prince of the star of Kirin. When you use power, you will be shining. A ride that can fly anywhere. You can go to a dream country. Paupipo means small happiness in the word of the star.
47	GOROPIKADON	A si of threeatures who were born in Kaminari. Sunder School
48	PataPataPeppy	Anyone interested in Shinshin. Awatenbo's Mimizuku's man's co Cherry and pineapple fruit and nap. A sleek flight is great! Peppy, born in the north forest, is a man's house that has become a lost and traversed while playing with Yamanezumi. I love it.
49	Mewkledreamy	Miyu is a shiny colored toy. You can chat with the stars of the ears from a strange night.
50	NORANEKOLAND	Three dais of cat born in Japan. Im working together. Kro is the third son of Kyodai. The second man. I like to challenge anything. This is a woman who loves making sweets at a leisurely shop.
51	Hagurumanstyle	He is working in the mouth of each individual, and he is also working on mental care. It appears when the teeth areed, and the teeth will substitute and support it!
52	SWEETCORON	The colon is always energeticly flying around the flower fields, and the bee of the bee. Have a bucket and pick up delicious honey! When you find a delicious honey, you will be able to dance gently.
53	Hummingmint	Humming Mint is a young girl who loves singing. It was born in a beautiful night of Mint Green Aurora in the north sky. Charm Point is a pink nose and white pattern.
54	Beatcats	Beetcats are the color of the pounding that comes from the beat when you want to take a step! Love, study, future... Suck the color of various poundings, shine yourself, and press your back with song and dance! But actually,...
55	StrawberryKing	The king of theberry kingdom. Anyone is kind and gentle. I always think about peace and friendship, and I hope that I can live well.
56	ZASHIKIBUTA	It is a relaxing shop, but curious. I live while making sweets and vegetables. Tabby is the teacher of making sweets. Born in French countryside.
57	FRESHPUNCH	Stylish pattern design with candy and lipstick.
58	Puwawa	If you are moving, you will be able to get a good baby. Irido-un's Powa and the Great Nakayoshi. Let's gather shellfish!
59	MELLOTUNE	A little sabi-shigari shop, a romantic Persian cat. Beautiful flowers and stars. I like listening to the soft melodies of violin in a quiet place!
60	kashiwankomochi	On May 5th, I changed my wrinkles with the feeling that I want to buy and return. It is a daily lesson that you spend a relaxing time. If you eat deliciously, please.
61	Caribadix	Dickie and Carina were looking for members to join the band. As I can't find it, I started to work with Carina's scouted chipper, Finne and three-piece band!
62	PANKUNCHI	A child that is thrown away in the forest where lives. The treasure is a mitten that came into the cardboard where Pan-kun was.
63	Sugarminuet	A genius ballerina on the lake behind the forest of Bunny Field. The two come to the human world through the mirror of the lesson room.
64	CHERINACHERINE	Cherry forests and fairy women's cos. We can help you harvest. The two are very and the ribbon is always aligned.
65	PANDAPPLE	A man ofs who loves. Apple logo is a trademark. The most relaxing place is your favorite chair. I'm always playing with my imoushi.
66	Pokopon's Diary	I am good at writing haiku. A pure and curious man's co! He is honoured for the training to become a splendid. What's more fun with the girlfriend's. The dango is a good thing.
67	ICHIGOMAN	Character born from Hello Kitty Art Exhibition A superhero that fights monsters whose abdo heart and wicked heart of human. Hello Kitty
68	Kumamilen	Alien of the Bears, a planet with a bear-likeature. Name A pancake full of honey, especially favorite foods. CH
69	Winkipinki	A adorable, romantic cat. You can play violin, draw pictures, and collect fashionable accessories.
70	Rilu Rilu Fairilu	Fair Lil was born from the seeds (Fair Lil Seed). There are a lot of tribes, such as flower fairy, fairy, and fairy of people, centering on the fair of tulips.
71	THE VAUDEVILLE DUO	Edi and Emmy, the birthplace of New York, are the same as the day. Eddie is a boy who loves the stage directors and adventures. Emmy is a cute girl who dreams of Broadway.
72	Umeya Zakkaten	Oumebaa-chan is living as a cat tiger for cats. The shop is always full of tea drink friends and children! It is a gentle grandmother who is good at temari, pineapple ball, and ohashi.
73	TENORIKUMA	The tall bears are 4cm tall. Im working at a coffee shop called Tenori Kuma Coffee. Red scarf Rate is a cancer bar. Its a dream to save money and open my shop for some time!
74	TARAIGUMA NO LANDRY	I live in my favorite tarai and I like to wash anything. A man's co is full of energetic with tea eyes, right after eating.
75	RURURUGAKUEN	6 people are always energetic and bright.
76	Shinkaizoku	The deep sea self-proclaimed idle! Mendako's Menta has a special ability to dive anywhere, and it's a taco, but it's not sumi. Im proud to be similar to UFO, and I believe its secret to flying the sky.
77	TINY POEM	She is a child of the wind. You can enjoy the green wilderness filled with fluffy and wind. Your favorite flower is Tampo. My Boyfriend Living in a small house with a straw roof.
78	NYOKKI & PENNE	Two cats that were kept by the owner of cats who are chefs of Italian restaurants. However, I would like to try more and more! And I left the shop one day.
79	WE ARE DINOSAURS!	and friendly. Youre a leader, Tirran, Tops, Stega, Ptera, Bucky, and Pressy, theres a lot of unique fun stuff!
80	BUNNY & MATTY	The bu of tea-eye rabbits and the m es of the s. Bunny is a woman who rides cars and airplanes. Matti is a group of three people with the same name.
81	Bosanimal	Even though they are present in the animals of everyday life, animals that are slightly different from everyone. Even if there is abby time, it is the motto to live yourself as it is. I will be involved with human beings while having the opinions that have been seen from the end of theboshi bothing.
82	BUDDYEDDY	A bright andaughty eddy, but always happy pita. The two are friends of Allie and Noah, and the Asobushi!
83	THE RUNABOUTS	Danpu-no-Dan-chan is a man of dump trucks who can quickly become familiar with anyone. It is gentle and powerful. Im running around the busy streets of a colorful and fun working car that I love to work and Im always busy!
84	Seven Silly Dwarfs	The character is different, but its very supple and small. We offer animals, flowers, blue skies, and delicious food. Live in the forest.
85	Risuru	\N
86	Pannapitta	3 months after birth, a energetic panda man co. The name is Pantan. I'm always running with a totetote.
87	Sportingbears	Kumano Family It is active as a character of Yamanashi Chuo Bank!
88	tabo	\N
89	pekkle	\N
90	kikilala	\N
91	retsuko	\N
92	charmmy	\N
\.


--
-- Data for Name: friends; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.friends (friend_id, character_id, friend_name) FROM stdin;
1	1	Muffin
2	1	Scorn
3	1	Bagel
4	1	Powder
5	1	Hip
6	1	Tart
7	1	Cascade
8	1	Mint
9	1	Macaron
10	1	Vanilla
11	1	Coconut
12	1	Syrup
13	1	Cookies
14	1	Home
15	1	Daddy
16	1	Mom
17	1	Grandpa
18	1	grandma
19	2	Cappuccino
20	2	Home
21	2	Espresso
22	2	Close
23	2	Poron
24	2	Birds
25	3	Choppy
26	3	Poples
27	3	Monmon
28	3	Pill
29	3	Tickey
30	3	Rachel
31	3	Playies
32	3	Mogmog
33	3	Dutch
34	3	Maple
35	3	Home
36	3	Tap
37	3	Pepe
38	3	Jump
39	4	Nami
40	5	Mimi
41	5	Daddy
42	5	Mom
43	5	Grandpa
44	5	grandma
45	5	Daniel Star
46	5	Tiny Cham
47	5	Molly
48	5	Joey
49	5	Roti
50	5	Tim & Tammy
51	5	TIPpy
52	5	Tracy
53	5	Jodi
54	5	Thomas
55	6	Close
56	6	Home
57	6	Rhythm
58	6	Grandpa
59	6	grandma
60	6	Flat
61	6	Piano
62	6	Kangaroo
63	6	Duck Parents
64	7	Puff & Puff
65	7	Nemlin
66	8	Close
67	8	Home
68	9	PAM
69	9	TAM
70	9	Chip
71	10	Pitch
72	10	Chap
73	10	Ruby
74	10	Boot
75	10	Carl
76	11	Daddy
77	11	Mom
78	11	Bad Twins
79	11	Good Hanamaru
80	11	Home
81	11	Ogawa Sameo
82	12	Contact Us
83	12	Home
84	13	Fried Shrimp
85	13	Takoyaki Sisters
86	13	Udon
87	13	Chocolate
88	13	Cake
89	13	Brother
90	13	Home
91	14	Father
92	14	mom
93	14	Close
94	14	Home
95	14	Gantha
96	14	Norbern
97	15	Alo
98	15	Marine
99	15	Rozanne
100	15	Sandy
101	15	Mandy
102	15	Fried
103	16	Close
104	16	Lock
105	16	Hardboild
106	16	Home
107	16	Clock Madame
108	16	DJ
109	17	Sora
110	17	Buppy
111	19	Home
112	20	Sacra
113	20	Home
114	20	Walnut
115	20	Cherry
116	20	Singo
117	20	Milk
118	20	Pants
119	20	Book
120	20	Leonardo III
121	20	Joe
122	20	Michael
123	20	Old
124	20	Rain
125	20	Tough
126	20	Mom
127	20	Time
128	20	Speedy
129	20	Circus
130	20	Caught
131	20	Scoop
132	20	Mickey
133	20	Nenne
134	20	Marilyn
135	20	Chocolate
136	20	Lily
137	20	Linking
138	20	Pia
139	20	Elizabeth
140	20	Jenny
141	20	Mimiko
142	20	Pint
143	20	Heart
144	20	Pan-chan
145	20	Close
146	20	Bean
147	20	Dundee
148	20	Boss
149	20	Prince
150	20	Bell
151	20	ro
152	20	Carry
153	20	Pyun
154	20	Pets
155	20	Cosmo
156	21	Home
157	21	Close
158	21	Thailand
159	21	KARBI
160	21	Ram Chop
161	21	berry
162	22	Gyonik
163	22	Home
164	23	Smoke
165	24	Cookies
166	24	Jerry Bean
167	24	Nuts
168	26	Honey Cute
169	26	Sugar
170	26	Milfeille
171	26	Tiramisu
172	26	Bisc
173	26	Chocolat
174	26	Pearl
175	26	Ruby
176	26	Sapphire
177	26	Black Opal
178	28	More
179	28	Home
180	28	berry
181	28	Blueberry
182	28	Mint
183	28	Cappuccino
184	28	Kakao
185	28	Vanilla
186	29	Daddy
187	31	Home
188	31	Close
189	31	Grandpa
190	31	grandma
191	31	Niwatori
192	31	Kael
193	31	Blue Bird
194	31	Kidney
195	31	Nezmi
196	31	Neko
197	31	tiger
198	31	Lion
199	31	Goat
200	31	Ashika
201	31	Penguin
202	31	Shirokuma
203	31	Squirrel
204	31	Lacco
205	31	Koala
206	31	Mogra
207	31	Kaba
208	31	Uma
209	31	Kirin
210	31	Kenkai
211	31	Kappa
212	31	Tatsu
213	31	Oni
214	31	Santa
215	32	Home
216	32	Close
217	34	General Manager
218	34	Director
219	34	Director of Yaguinou
220	34	Mr. Terada
221	34	Feneko
222	34	Hida
223	34	Home
224	34	President
225	34	Yoga instructor
226	34	Cafe
227	34	Yokosawa
228	34	Majiro
229	35	Home
230	35	Laura Laura
231	35	Milky Mimi
232	36	Home
233	37	Labra
234	37	King
235	37	Dian
236	37	Diana
237	37	Granite
238	37	Garnet
239	37	Jasper
240	37	Nic
241	37	Ruby
242	37	Coral
243	37	Alek
244	37	Brownie
245	37	Angela
246	37	Kris
247	37	Plays
248	37	Milky
249	37	Home
250	37	Flora
251	37	Suffy
252	37	Io
253	37	Topaz
254	37	Cuckold
255	37	Lapis
256	37	Amelie
257	37	Larimar
258	38	Tiny Lavender
259	38	Tiny Green
260	38	Tiny Pink
261	38	Tiny Cham
262	38	Tiny Cream
263	38	Tiny Blue
264	40	Home
265	41	Home
266	42	Billy
267	42	Dora
268	43	Home
269	44	Home
270	45	Daigoro
271	45	English
272	45	Home
273	45	Lion
274	45	Lime
275	45	Mamoru
276	45	Linking
277	45	Yu da
278	45	Lumi
279	49	Home
280	49	Close
281	51	Depth
282	51	Black Teeth
283	51	Teeth
284	51	Gold Teeth
285	51	Silver Teeth
286	51	Home
287	54	Mia
288	54	Chelsea
289	54	Ema
290	54	RAYLA
291	54	Emma
292	55	Dundee
293	55	Dutch
294	55	Candy
295	55	Socrates
296	55	Key
297	60	Home
298	61	Carina
299	61	Dickie
300	61	Close
301	61	Chipper
302	61	FINE
303	62	SHOKUPAN
304	62	Coppepan
305	66	Home
306	68	Honey
307	68	UFB
308	70	Sunflower
309	70	Rose
310	70	Close
311	70	Home
312	70	Olive
313	70	Dante
314	70	Jasmine
315	70	Gerbera
316	70	Dalian
317	70	Lady
318	70	Spider
319	70	Kumamoto
320	70	Coral
321	70	Fish
322	70	Mesh
323	70	Pen
324	70	Rainbow
325	70	Thunder
326	70	Sun
327	70	Star
328	70	Wind
329	70	Dot
330	70	Dutch
331	70	corn
332	70	Carrot
333	70	ry
334	70	Bloco Cappadocia
335	70	Sirius
336	70	Apple Lemon
337	70	Pine
338	70	Blueberry
339	70	berry
340	70	Sweetie
341	70	Haetto
342	70	Dorian
343	70	Japanese
344	70	cat husband
345	71	Elf
346	73	Maple
347	73	Flappe
348	73	Maki Art
349	73	Mr. Steam
350	73	Home
351	74	Pea
352	76	Oguchi Boya's
353	76	Senju-san of Senju-san
354	76	Pink konjac body Sakejii
355	76	Mizoo's Mizu brother
356	76	Boss Sokobozu's bow-san
357	76	What is Chihiro?
358	79	Tiran
359	79	Tops
360	79	Ptera
361	81	Long hair
362	81	
363	81	r
364	81	opus
365	81	ing
366	81	(Long hair)
367	81	Short hair
368	82	Arie
369	82	Noah
370	82	Tess
371	82	Mom
372	82	Dad
373	82	Grandma
374	82	Grandpa
375	83	Wheel Loader
376	83	Mixer  Mickon
377	83	Crane
378	83	Cucumber
379	83	Shovelker Bell-kun
380	83	Lek-kun
381	83	Patker
382	83	Roll of Road Roller
383	83	Taxi
384	83	Bus
385	83	Wagon
386	83	Mailing List
387	86	Mom
388	86	Daddy
389	86	Pinotane
\.


--
-- Data for Name: goods; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.goods (goods_id, name, character_id, category, release_date) FROM stdin;
\.


--
-- Data for Name: high_rank_ov; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.high_rank_ov (high_rank_id, vote_count, comment) FROM stdin;
1	5,613,659	Yippee!Thanks so much for all your support!I'm gonna celebrate with a giant pudding!
2	5,427,983	I'm super grateful for all your support.I'll continue to be right by your side from now on!
3	3,935,101	Hey, everyone! I got third place!Thanks for everything.Let's continue to get along forever!
4	3,652,492	\N
5	3,349,642	\N
6	2,547,302	\N
7	2,282,015	\N
8	2,243,702	\N
9	2,082,914	\N
10	2,032,405	\N
11	1,852,644	\N
12	1,846,850	\N
13	1,833,994	\N
14	1,809,818	\N
15	1,381,009	\N
16	1,178,855	\N
18	1,070,050	\N
19	809,533	\N
20	807,839	\N
21	721,820	\N
22	713,415	\N
23	647,955	\N
24	594,342	\N
25	523,787	\N
26	509,884	\N
27	500,236	\N
30	452,751	\N
\.


--
-- Data for Name: low_rank_ov; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.low_rank_ov (low_rank_id) FROM stdin;
31
32
34
35
36
37
39
40
41
42
43
44
45
46
47
48
49
50
51
52
53
54
55
56
57
58
59
60
61
62
63
64
65
66
67
68
69
70
71
72
74
75
76
77
78
79
80
81
82
83
84
85
86
87
88
89
90
\.


--
-- Data for Name: news; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.news (news_id, title, category) FROM stdin;
\.


--
-- Data for Name: news_character; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.news_character (news_id, character_id) FROM stdin;
\.


--
-- Data for Name: overall_rankings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.overall_rankings (overall_rank_id, character_id, rank, profile_link, rank_category) FROM stdin;
1	1	1	https://www.sanrio.co.jp/characters/pompompurin/	high
2	2	2	https://www.sanrio.co.jp/characters/cinnamon/	high
3	3	3	https://www.sanrio.co.jp/characters/pochacco/	high
4	4	4	https://www.sanrio.co.jp/characters/kuromi/	high
5	5	5	https://www.sanrio.co.jp/characters/hellokitty/	high
6	6	6	https://www.sanrio.co.jp/characters/mymelody/	high
7	7	7	https://www.sanrio.co.jp/characters/kikilala/	high
8	8	8	https://www.sanrio.co.jp/characters/hangyodon/	high
9	9	9	https://www.sanrio.co.jp/characters/tuxedosam/	high
10	10	10	https://www.sanrio.co.jp/characters/pekkle/	high
11	11	11	https://www.sanrio.co.jp/characters/badtzmaru/	high
12	12	12	https://www.sanrio.co.jp/characters/hanamaruobake/	high
13	13	13	https://www.sanrio.co.jp/characters/cogimyun/	high
14	14	14	https://www.sanrio.co.jp/characters/keroppi/	high
15	15	15	https://www.sanrio.co.jp/characters/wishmemell/	high
16	16	16	https://www.sanrio.co.jp/characters/gudetama/	high
18	18	18	https://www.sanrio.co.jp/characters/mysweetpiano/	high
19	19	19	https://www.sanrio.co.jp/characters/gaopowerroo/	high
20	20	20	https://www.sanrio.co.jp/characters/kuririn/	high
21	21	21	https://www.sanrio.co.jp/characters/kirimichan/	high
22	22	22	https://www.sanrio.co.jp/characters/marumofubiyori/	high
23	23	23	https://www.sanrio.co.jp/characters/marroncream/	high
24	24	24	https://www.sanrio.co.jp/characters/chococat/	high
25	25	25	https://www.sanrio.co.jp/characters/showbyrock/	high
26	26	26	https://www.sanrio.co.jp/characters/charmmy/	high
27	27	27	https://www.sanrio.co.jp/characters/kabukinyantaro/	high
30	28	30	https://www.sanrio.co.jp/characters/sugarbunnies/	high
31	29	31	https://www.sanrio.co.jp/characters/daniel/	low
32	30	32	https://www.sanrio.co.jp/characters/lloromannic/	low
34	32	34	https://www.sanrio.co.jp/characters/pokkyokuten/	low
35	33	35	https://www.sanrio.co.jp/characters/adorozatorumary/	low
36	34	36	https://www.sanrio.co.jp/characters/retsuko/	low
37	35	37	https://www.sanrio.co.jp/characters/bonbonribbon/	low
39	37	39	https://www.sanrio.co.jp/characters/jewelpet/	low
40	38	40	https://www.sanrio.co.jp/characters/tinychum/	low
41	39	41	https://www.sanrio.co.jp/characters/masyumaro/	low
42	40	42	https://www.sanrio.co.jp/characters/littleforestfellow/	low
43	41	43	https://www.sanrio.co.jp/characters/monkichi/	low
44	42	44	https://www.sanrio.co.jp/characters/pattyandjimmy/	low
45	43	45	https://www.sanrio.co.jp/characters/cheerychums/	low
46	44	46	https://www.sanrio.co.jp/characters/petapetaminilian/	low
47	45	47	https://www.sanrio.co.jp/characters/maimaimaigoen/	low
48	46	48	https://www.sanrio.co.jp/characters/paupipo/	low
49	47	49	https://www.sanrio.co.jp/characters/goropikadon/	low
50	48	50	https://www.sanrio.co.jp/characters/patapatapeppy/	low
51	49	51	https://www.sanrio.co.jp/characters/mewkledreamy/	low
52	50	52	https://www.sanrio.co.jp/characters/noranekoland/	low
53	51	53	https://www.sanrio.co.jp/characters/hagurumanstyle/	low
54	52	54	https://www.sanrio.co.jp/characters/sweetcoron/	low
55	53	55	https://www.sanrio.co.jp/characters/hummingmint/	low
56	54	56	https://www.sanrio.co.jp/characters/beatcats/	low
57	55	57	https://www.sanrio.co.jp/characters/strawberryking/	low
58	56	58	https://www.sanrio.co.jp/characters/zashikibuta/	low
59	57	59	https://www.sanrio.co.jp/characters/freshpunch/	low
60	58	60	https://www.sanrio.co.jp/characters/puwawa/	low
61	59	61	https://www.sanrio.co.jp/characters/mellotune/	low
62	60	62	https://www.sanrio.co.jp/characters/kashiwankomochi/	low
63	61	63	https://www.sanrio.co.jp/characters/caribadix/	low
64	62	64	https://www.sanrio.co.jp/characters/pankunchi/	low
65	63	65	https://www.sanrio.co.jp/characters/sugarminuet/	low
66	64	66	https://www.sanrio.co.jp/characters/cherinacherine/	low
67	65	67	https://www.sanrio.co.jp/characters/pandapple/	low
68	66	68	https://www.sanrio.co.jp/characters/pokopon/	low
69	67	69	https://www.sanrio.co.jp/characters/ichigoman/	low
70	68	70	https://www.sanrio.co.jp/characters/kumamilen/	low
71	69	71	https://www.sanrio.co.jp/characters/winkipinki/	low
72	70	72	https://www.sanrio.co.jp/characters/rilurilufairilu/	low
74	71	74	https://www.sanrio.co.jp/characters/vaudevilleduo/	low
75	72	75	https://www.sanrio.co.jp/characters/umeya/	low
76	73	76	https://www.sanrio.co.jp/characters/tenorikuma/	low
77	74	77	https://www.sanrio.co.jp/characters/landry/	low
78	75	78	https://www.sanrio.co.jp/characters/rururugakuen/	low
79	76	79	https://www.sanrio.co.jp/characters/shinkaizoku/	low
80	77	80	https://www.sanrio.co.jp/characters/tinypoem/	low
81	78	81	https://www.sanrio.co.jp/characters/nyokkiandpenne/	low
82	79	82	https://www.sanrio.co.jp/characters/dinosaurs/	low
83	80	83	https://www.sanrio.co.jp/characters/bunnyandmatty/	low
84	81	84	https://www.sanrio.co.jp/characters/bosanimal/	low
85	82	85	https://www.sanrio.co.jp/characters/buddyeddy/	low
86	83	86	https://www.sanrio.co.jp/characters/runabouts2/	low
87	84	87	https://www.sanrio.co.jp/characters/ssd/	low
88	85	88	https://www.tamashin.jp/risuru/	low
89	86	89	https://www.sanrio.co.jp/characters/pannapitta/	low
90	87	90	https://www.sanrio.co.jp/characters/sportingbears/	low
\.


--
-- Data for Name: region_rankings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.region_rankings (region_rank_id, region_id, rank, character_id, profile_link) FROM stdin;
1	1	1	1	https://www.sanrio.co.jp/characters/pompompurin/
2	1	2	2	https://www.sanrio.co.jp/characters/cinnamon/
3	1	3	5	https://www.sanrio.co.jp/characters/hellokitty/
4	1	4	3	https://www.sanrio.co.jp/characters/pochacco/
5	1	5	4	https://www.sanrio.co.jp/characters/kuromi/
6	1	6	6	https://www.sanrio.co.jp/characters/mymelody/
7	1	7	18	https://www.sanrio.co.jp/characters/mysweetpiano/
8	1	8	8	https://www.sanrio.co.jp/characters/hangyodon/
9	1	9	13	https://www.sanrio.co.jp/characters/cogimyun/
10	1	10	22	https://www.sanrio.co.jp/characters/marumofubiyori/
11	2	1	2	https://www.sanrio.co.jp/characters/cinnamon/
12	2	2	4	https://www.sanrio.co.jp/characters/kuromi/
13	2	3	5	https://www.sanrio.co.jp/characters/hellokitty/
14	2	4	1	https://www.sanrio.co.jp/characters/pompompurin/
15	2	5	8	https://www.sanrio.co.jp/characters/hangyodon/
16	2	6	3	https://www.sanrio.co.jp/characters/pochacco/
18	2	8	6	https://www.sanrio.co.jp/characters/mymelody/
19	2	9	10	https://www.sanrio.co.jp/characters/pekkle/
20	2	10	14	https://www.sanrio.co.jp/characters/keroppi/
21	3	1	1	https://www.sanrio.co.jp/characters/pompompurin/
22	3	2	2	https://www.sanrio.co.jp/characters/cinnamon/
23	3	3	3	https://www.sanrio.co.jp/characters/pochacco/
24	3	4	4	https://www.sanrio.co.jp/characters/kuromi/
25	3	5	6	https://www.sanrio.co.jp/characters/mymelody/
26	3	6	5	https://www.sanrio.co.jp/characters/hellokitty/
27	3	7	8	https://www.sanrio.co.jp/characters/hangyodon/
28	3	8	7	https://www.sanrio.co.jp/characters/kikilala/
29	3	9	16	https://www.sanrio.co.jp/characters/gudetama/
30	3	10	11	https://www.sanrio.co.jp/characters/badtzmaru/
31	4	1	3	https://www.sanrio.co.jp/characters/pochacco/
32	4	2	2	https://www.sanrio.co.jp/characters/cinnamon/
33	4	3	25	https://www.sanrio.co.jp/characters/showbyrock/
34	4	4	8	https://www.sanrio.co.jp/characters/hangyodon/
35	4	5	1	https://www.sanrio.co.jp/characters/pompompurin/
36	4	6	5	https://www.sanrio.co.jp/characters/hellokitty/
37	4	7	4	https://www.sanrio.co.jp/characters/kuromi/
38	4	8	6	https://www.sanrio.co.jp/characters/mymelody/
39	4	9	14	https://www.sanrio.co.jp/characters/keroppi/
41	5	1	1	https://www.sanrio.co.jp/characters/pompompurin/
42	5	2	24	https://www.sanrio.co.jp/characters/chococat/
43	5	3	3	https://www.sanrio.co.jp/characters/pochacco/
45	5	5	2	https://www.sanrio.co.jp/characters/cinnamon/
46	5	6	4	https://www.sanrio.co.jp/characters/kuromi/
47	5	7	14	https://www.sanrio.co.jp/characters/keroppi/
48	5	8	9	https://www.sanrio.co.jp/characters/tuxedosam/
49	5	9	33	https://www.sanrio.co.jp/characters/adorozatorumary/
50	5	10	12	https://www.sanrio.co.jp/characters/hanamaruobake/
51	6	1	24	https://www.sanrio.co.jp/characters/chococat/
52	6	2	1	https://www.sanrio.co.jp/characters/pompompurin/
53	6	3	2	https://www.sanrio.co.jp/characters/cinnamon/
54	6	4	4	https://www.sanrio.co.jp/characters/kuromi/
55	6	5	3	https://www.sanrio.co.jp/characters/pochacco/
56	6	6	34	https://www.sanrio.co.jp/characters/retsuko/
57	6	7	6	https://www.sanrio.co.jp/characters/mymelody/
58	6	8	14	https://www.sanrio.co.jp/characters/keroppi/
59	6	9	11	https://www.sanrio.co.jp/characters/badtzmaru/
60	6	10	5	https://www.sanrio.co.jp/characters/hellokitty/
61	7	1	1	https://www.sanrio.co.jp/characters/pompompurin/
62	7	2	24	https://www.sanrio.co.jp/characters/chococat/
64	7	4	4	https://www.sanrio.co.jp/characters/kuromi/
65	7	5	2	https://www.sanrio.co.jp/characters/cinnamon/
66	7	6	3	https://www.sanrio.co.jp/characters/pochacco/
67	7	7	33	https://www.sanrio.co.jp/characters/adorozatorumary/
68	7	8	16	https://www.sanrio.co.jp/characters/gudetama/
69	7	9	18	https://www.sanrio.co.jp/characters/mysweetpiano/
70	7	10	12	https://www.sanrio.co.jp/characters/hanamaruobake/
71	8	1	1	https://www.sanrio.co.jp/characters/pompompurin/
72	8	2	2	https://www.sanrio.co.jp/characters/cinnamon/
73	8	3	4	https://www.sanrio.co.jp/characters/kuromi/
74	8	4	33	https://www.sanrio.co.jp/characters/adorozatorumary/
75	8	5	24	https://www.sanrio.co.jp/characters/chococat/
76	8	6	6	https://www.sanrio.co.jp/characters/mymelody/
78	8	8	26	https://www.sanrio.co.jp/characters/charmmy/
79	8	9	3	https://www.sanrio.co.jp/characters/pochacco/
80	8	10	16	https://www.sanrio.co.jp/characters/gudetama/
81	9	1	1	https://www.sanrio.co.jp/characters/pompompurin/
82	9	2	2	https://www.sanrio.co.jp/characters/cinnamon/
83	9	3	4	https://www.sanrio.co.jp/characters/kuromi/
84	9	4	24	https://www.sanrio.co.jp/characters/chococat/
85	9	5	33	https://www.sanrio.co.jp/characters/adorozatorumary/
87	9	7	3	https://www.sanrio.co.jp/characters/pochacco/
88	9	8	12	https://www.sanrio.co.jp/characters/hanamaruobake/
89	9	9	26	https://www.sanrio.co.jp/characters/charmmy/
90	9	10	6	https://www.sanrio.co.jp/characters/mymelody/
91	10	1	1	https://www.sanrio.co.jp/characters/pompompurin/
92	10	2	2	https://www.sanrio.co.jp/characters/cinnamon/
93	10	3	4	https://www.sanrio.co.jp/characters/kuromi/
94	10	4	24	https://www.sanrio.co.jp/characters/chococat/
95	10	5	33	https://www.sanrio.co.jp/characters/adorozatorumary/
97	10	7	12	https://www.sanrio.co.jp/characters/hanamaruobake/
98	10	8	3	https://www.sanrio.co.jp/characters/pochacco/
99	10	9	5	https://www.sanrio.co.jp/characters/hellokitty/
100	10	10	16	https://www.sanrio.co.jp/characters/gudetama/
101	11	1	1	https://www.sanrio.co.jp/characters/pompompurin/
102	11	2	2	https://www.sanrio.co.jp/characters/cinnamon/
103	11	3	4	https://www.sanrio.co.jp/characters/kuromi/
105	11	5	33	https://www.sanrio.co.jp/characters/adorozatorumary/
106	11	6	3	https://www.sanrio.co.jp/characters/pochacco/
107	11	7	24	https://www.sanrio.co.jp/characters/chococat/
108	11	8	16	https://www.sanrio.co.jp/characters/gudetama/
109	11	9	12	https://www.sanrio.co.jp/characters/hanamaruobake/
110	11	10	14	https://www.sanrio.co.jp/characters/keroppi/
111	12	1	2	https://www.sanrio.co.jp/characters/cinnamon/
112	12	2	1	https://www.sanrio.co.jp/characters/pompompurin/
113	12	3	4	https://www.sanrio.co.jp/characters/kuromi/
114	12	4	5	https://www.sanrio.co.jp/characters/hellokitty/
115	12	5	6	https://www.sanrio.co.jp/characters/mymelody/
116	12	6	3	https://www.sanrio.co.jp/characters/pochacco/
117	12	7	8	https://www.sanrio.co.jp/characters/hangyodon/
118	12	8	16	https://www.sanrio.co.jp/characters/gudetama/
119	12	9	9	https://www.sanrio.co.jp/characters/tuxedosam/
120	12	10	7	https://www.sanrio.co.jp/characters/kikilala/
122	13	2	2	https://www.sanrio.co.jp/characters/cinnamon/
123	13	3	4	https://www.sanrio.co.jp/characters/kuromi/
124	13	4	1	https://www.sanrio.co.jp/characters/pompompurin/
125	13	5	5	https://www.sanrio.co.jp/characters/hellokitty/
126	13	6	6	https://www.sanrio.co.jp/characters/mymelody/
127	13	7	3	https://www.sanrio.co.jp/characters/pochacco/
128	13	8	8	https://www.sanrio.co.jp/characters/hangyodon/
130	13	10	22	https://www.sanrio.co.jp/characters/marumofubiyori/
131	14	1	1	https://www.sanrio.co.jp/characters/pompompurin/
132	14	2	2	https://www.sanrio.co.jp/characters/cinnamon/
133	14	3	24	https://www.sanrio.co.jp/characters/chococat/
135	14	5	4	https://www.sanrio.co.jp/characters/kuromi/
136	14	6	3	https://www.sanrio.co.jp/characters/pochacco/
137	14	7	14	https://www.sanrio.co.jp/characters/keroppi/
138	14	8	16	https://www.sanrio.co.jp/characters/gudetama/
139	14	9	12	https://www.sanrio.co.jp/characters/hanamaruobake/
140	14	10	33	https://www.sanrio.co.jp/characters/adorozatorumary/
\.


--
-- Data for Name: regions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.regions (region_id, name) FROM stdin;
1	The Chinese Mainland
2	Hong Kong
3	Taiwan
4	South Korea
5	United States
6	Brazil
7	United Kingdom
8	Italy
9	Germany
10	France
11	Australia
12	Singapore
13	Thailand
14	Spain
\.


--
-- Data for Name: spot_character; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.spot_character (spot_id, character_id) FROM stdin;
\.


--
-- Data for Name: spots; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.spots (spot_id, name, place, category, date) FROM stdin;
\.


--
-- Name: characters_character_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.characters_character_id_seq', 98, true);


--
-- Name: friends_friend_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.friends_friend_id_seq', 389, true);


--
-- Name: goods_goods_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.goods_goods_id_seq', 1, false);


--
-- Name: high_rank_ov_high_rank_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.high_rank_ov_high_rank_id_seq', 1, false);


--
-- Name: low_rank_ov_low_rank_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.low_rank_ov_low_rank_id_seq', 1, false);


--
-- Name: news_news_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.news_news_id_seq', 1, false);


--
-- Name: overall_rankings_overall_rank_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.overall_rankings_overall_rank_id_seq', 90, true);


--
-- Name: region_rankings_region_rank_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.region_rankings_region_rank_id_seq', 140, true);


--
-- Name: regions_region_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.regions_region_id_seq', 14, true);


--
-- Name: spots_spot_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.spots_spot_id_seq', 1, false);


--
-- Name: characters characters_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.characters
    ADD CONSTRAINT characters_name_key UNIQUE (name);


--
-- Name: characters characters_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.characters
    ADD CONSTRAINT characters_pkey PRIMARY KEY (character_id);


--
-- Name: friends friends_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.friends
    ADD CONSTRAINT friends_pkey PRIMARY KEY (friend_id);


--
-- Name: goods goods_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.goods
    ADD CONSTRAINT goods_pkey PRIMARY KEY (goods_id);


--
-- Name: high_rank_ov high_rank_ov_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.high_rank_ov
    ADD CONSTRAINT high_rank_ov_pkey PRIMARY KEY (high_rank_id);


--
-- Name: low_rank_ov low_rank_ov_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.low_rank_ov
    ADD CONSTRAINT low_rank_ov_pkey PRIMARY KEY (low_rank_id);


--
-- Name: news_character news_character_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.news_character
    ADD CONSTRAINT news_character_pkey PRIMARY KEY (news_id, character_id);


--
-- Name: news news_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.news
    ADD CONSTRAINT news_pkey PRIMARY KEY (news_id);


--
-- Name: overall_rankings overall_rankings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.overall_rankings
    ADD CONSTRAINT overall_rankings_pkey PRIMARY KEY (overall_rank_id);


--
-- Name: region_rankings region_rankings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.region_rankings
    ADD CONSTRAINT region_rankings_pkey PRIMARY KEY (region_rank_id);


--
-- Name: regions regions_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regions
    ADD CONSTRAINT regions_name_key UNIQUE (name);


--
-- Name: regions regions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regions
    ADD CONSTRAINT regions_pkey PRIMARY KEY (region_id);


--
-- Name: spot_character spot_character_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.spot_character
    ADD CONSTRAINT spot_character_pkey PRIMARY KEY (spot_id, character_id);


--
-- Name: spots spots_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.spots
    ADD CONSTRAINT spots_pkey PRIMARY KEY (spot_id);


--
-- Name: friends friends_character_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.friends
    ADD CONSTRAINT friends_character_id_fkey FOREIGN KEY (character_id) REFERENCES public.characters(character_id);


--
-- Name: goods goods_character_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.goods
    ADD CONSTRAINT goods_character_id_fkey FOREIGN KEY (character_id) REFERENCES public.characters(character_id);


--
-- Name: high_rank_ov high_rank_ov_high_rank_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.high_rank_ov
    ADD CONSTRAINT high_rank_ov_high_rank_id_fkey FOREIGN KEY (high_rank_id) REFERENCES public.overall_rankings(overall_rank_id);


--
-- Name: low_rank_ov low_rank_ov_low_rank_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.low_rank_ov
    ADD CONSTRAINT low_rank_ov_low_rank_id_fkey FOREIGN KEY (low_rank_id) REFERENCES public.overall_rankings(overall_rank_id);


--
-- Name: news_character news_character_character_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.news_character
    ADD CONSTRAINT news_character_character_id_fkey FOREIGN KEY (character_id) REFERENCES public.characters(character_id);


--
-- Name: news_character news_character_news_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.news_character
    ADD CONSTRAINT news_character_news_id_fkey FOREIGN KEY (news_id) REFERENCES public.news(news_id);


--
-- Name: overall_rankings overall_rankings_character_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.overall_rankings
    ADD CONSTRAINT overall_rankings_character_id_fkey FOREIGN KEY (character_id) REFERENCES public.characters(character_id);


--
-- Name: region_rankings region_rankings_character_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.region_rankings
    ADD CONSTRAINT region_rankings_character_id_fkey FOREIGN KEY (character_id) REFERENCES public.characters(character_id);


--
-- Name: region_rankings region_rankings_region_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.region_rankings
    ADD CONSTRAINT region_rankings_region_id_fkey FOREIGN KEY (region_id) REFERENCES public.regions(region_id);


--
-- Name: spot_character spot_character_character_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.spot_character
    ADD CONSTRAINT spot_character_character_id_fkey FOREIGN KEY (character_id) REFERENCES public.characters(character_id);


--
-- Name: spot_character spot_character_spot_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.spot_character
    ADD CONSTRAINT spot_character_spot_id_fkey FOREIGN KEY (spot_id) REFERENCES public.spots(spot_id);


--
-- PostgreSQL database dump complete
--

