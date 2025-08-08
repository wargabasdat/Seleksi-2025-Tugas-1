--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5
-- Dumped by pg_dump version 17.5

-- Started on 2025-08-08 20:24:33

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
-- TOC entry 223 (class 1259 OID 18458)
-- Name: ability; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ability (
    equipment_id character varying(255) NOT NULL,
    ability_id integer NOT NULL,
    ability_name character varying(255),
    keybind character varying(50),
    mastery_cost character varying(50),
    fragment_cost integer
);


ALTER TABLE public.ability OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 18412)
-- Name: equipment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.equipment (
    equipment_id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    url text,
    "timestamp" timestamp without time zone,
    type character varying(100),
    rarity character varying(100),
    release_date character varying(255)
);


ALTER TABLE public.equipment OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 18426)
-- Name: fruit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fruit (
    equipment_id character varying(255) NOT NULL,
    fruit_type character varying(100),
    money_price integer,
    robux_price integer,
    can_m1 character varying(10),
    fruit_value integer,
    fruit_demand integer,
    fruit_status character varying(255)
);


ALTER TABLE public.fruit OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 18448)
-- Name: gun; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.gun (
    equipment_id character varying(255) NOT NULL
);


ALTER TABLE public.gun OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 18419)
-- Name: stock_event; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.stock_event (
    stock_event_id character varying(255) NOT NULL,
    "timestamp" timestamp without time zone,
    stock_start_time character varying(255)
);


ALTER TABLE public.stock_event OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 18487)
-- Name: stock_item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.stock_item (
    stock_event_id character varying(255) NOT NULL,
    stock_item_id integer NOT NULL,
    fruit_id character varying(255) NOT NULL
);


ALTER TABLE public.stock_item OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 18438)
-- Name: sword; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sword (
    equipment_id character varying(255) NOT NULL
);


ALTER TABLE public.sword OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 18405)
-- Name: update; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.update (
    update_id character varying(255) NOT NULL,
    update_title character varying(255) NOT NULL,
    release_date character varying(255),
    "timestamp" timestamp without time zone
);


ALTER TABLE public.update OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 18470)
-- Name: update_item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.update_item (
    update_id character varying(255) NOT NULL,
    change_history_id integer NOT NULL,
    equipment_id character varying(255) NOT NULL,
    change text
);


ALTER TABLE public.update_item OWNER TO postgres;

--
-- TOC entry 4853 (class 0 OID 18458)
-- Dependencies: 223
-- Data for Name: ability; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ability (equipment_id, ability_id, ability_name, keybind, mastery_cost, fragment_cost) FROM stdin;
fruit_leopard	5	Body Flicker	F	200	\N
fruit_dragon	1	Normal Attack	TAP	\N	\N
fruit_dragon	2	Heatwave Cannon	Z	1	\N
fruit_dragon	3	Infernal Pincer	X	150	\N
fruit_dragon	4	Scorching Downfall	C	250	\N
fruit_dragon	5	Imperial Evolution	V	350	\N
fruit_dragon	6	Draconic Soar	F	75	\N
fruit_dragon	7	Normal Attack	TAP	\N	\N
fruit_dragon	8	Heatwave Cannon	Z	1	\N
fruit_dragon	9	Infernal Pincer	X	150	\N
fruit_dragon	10	Scorching Downfall	C	250	\N
fruit_dragon	11	Imperial Evolution	V	350	\N
fruit_dragon	12	Draconic Soar	F	75	\N
fruit_dragon	13	Normal Attack	TAP	\N	\N
fruit_dragon	14	Heatwave Cannon	Z	1	\N
fruit_dragon	15	Infernal Pincer	X	150	\N
fruit_dragon	16	Scorching Downfall	C	250	\N
fruit_dragon	17	Imperial Evolution	V	350	\N
fruit_dragon	18	Draconic Soar	F	75	\N
fruit_dragon	19	Normal Attack	TAP	\N	\N
fruit_dragon	20	Heatwave Cannon	Z	1	\N
fruit_dragon	21	Infernal Pincer	X	150	\N
fruit_dragon	22	Scorching Downfall	C	250	\N
fruit_dragon	23	Imperial Evolution	V	350	\N
fruit_dragon	24	Draconic Soar	F	75	\N
fruit_soul	1	Soul Snatcher	Z	1	\N
fruit_soul	2	Wrath of Ra	X	150	\N
fruit_soul	3	Outraged Raijin	C	250	\N
fruit_soul	4	End of Times	V	350	\N
fruit_soul	5	Sky Ruler	F	75	\N
fruit_revive	1	Possession	Z	1	\N
fruit_revive	2	Soul Ruler	X	60	\N
fruit_revive	3	Resurrection	C	110	\N
fruit_revive	4	Wandering Soul	F	30	\N
fruit_kilo	1	10,000KG	Z	1	\N
fruit_kilo	2	20,000KG	X	20	\N
fruit_kilo	3	50,000KG	C	50	\N
fruit_kilo	4	Lighten	F	75	\N
fruit_falcon	1	Plumage	Z	1	\N
fruit_falcon	2	Wind Burst	X	1	\N
fruit_falcon	3	Bone Crusher	C	80	\N
fruit_falcon	4	Soaring Talon	V	120	\N
fruit_falcon	5	Flight	F	20	\N
fruit_leopard	1	Finger Revolver	Z	1	\N
fruit_leopard	2	Spiraling Kick	X	50	\N
fruit_leopard	3	Afterimage Assault	C	100	\N
fruit_leopard	4	Transformation	V	300	\N
fruit_leopard	6	Normal Attack	TAP	\N	\N
fruit_leopard	7	Finger Revolver	Z	1	\N
fruit_leopard	8	Spiraling Kick	X	50	\N
fruit_leopard	9	Afterimage Assault	C	100	\N
fruit_leopard	10	Transformation	V	300	\N
fruit_leopard	11	Body Flicker	F	200	\N
fruit_barrier	1	Barrier Wall	Z	1	\N
fruit_barrier	2	Surprise Attack	X	45	\N
fruit_barrier	3	Barrier Prison	C	90	\N
fruit_barrier	4	Barrier Towers	V	130	\N
fruit_barrier	5	Stairs	F	10	\N
fruit_yeti	1	Arctic Clap	Z	1	\N
fruit_yeti	2	Frostbite Boulder	X	50	\N
fruit_yeti	3	Glacial Execution	C	100	\N
fruit_yeti	4	Transformation	V	300	\N
fruit_yeti	5	Tundra Rush	F	200	\N
fruit_yeti	6	Normal Attack	TAP	\N	\N
fruit_yeti	7	Arctic Clap	Z	1	\N
fruit_yeti	8	Frostbite Boulder	X	50	\N
fruit_yeti	9	Glacial Execution	C	100	\N
fruit_yeti	10	Transformation	V	300	\N
fruit_yeti	11	Tundra Rush	F	200	\N
fruit_chop	1	Tackle	Z	1	\N
fruit_chop	2	Dance	X	20	\N
fruit_chop	3	Party	C	50	\N
fruit_chop	4	Helicopter	F	80	\N
fruit_shadow	1	Somber Rebellion	Z	1	\N
fruit_shadow	2	Shade Nest	X	100	\N
fruit_shadow	3	Nightmare Leech	C	200	\N
fruit_shadow	4	Corvus Torment	V	300	\N
fruit_shadow	5	Umbrage	F	50	\N
fruit_control	1	Control Area	Z	1	\N
fruit_control	2	Levitate	X	1	\N
fruit_control	3	Echo Knife	C	150	\N
fruit_control	4	Gamma Rush	V	350	\N
fruit_control	5	Teleport	F	250	\N
fruit_dough	1	Fried Dough	Z	1	\N
fruit_dough	2	Sticky Dough	X	100	\N
fruit_dough	3	Carved Dough	C	200	\N
fruit_dough	4	Restless Dough Barrage	V	300	\N
fruit_dough	5	Roller Donut	F	50	\N
fruit_dough	6	Normal Attack	TAP	\N	4000
fruit_dough	7	Missile Jab	Z	1	500
fruit_dough	8	Pastry River	X	100	3000
fruit_dough	9	Piercing Clothesline	C	200	4000
fruit_dough	10	Dough Fist Fusillade	V	300	5000
fruit_dough	11	Scorching Donut	F	50	2000
fruit_venom	1	Poison Daggers	Z	1	\N
fruit_venom	2	Noxious Shot	X	100	\N
fruit_venom	3	Toxic Fog	C	200	\N
fruit_venom	4	Transformation	V	300	\N
fruit_venom	5	Serpent’s Wrath	F	50	\N
fruit_venom	6	Poison Daggers	Z	1	\N
fruit_venom	7	Noxious Shot	X	100	\N
fruit_venom	8	Toxic Fog	C	200	\N
fruit_venom	9	Transformation	V	300	\N
fruit_venom	10	Serpent's Wrath	F	50	\N
fruit_gas	1	Normal Attack	TAP	\N	\N
fruit_gas	2	Suffocating Fumes	Z	1	\N
fruit_gas	3	Bursting Vapor	X	100	\N
fruit_gas	4	Smog Demons	C	200	\N
fruit_gas	5	Vapor Condensation	V	300	\N
fruit_gas	6	Traveling Gas	F	50	\N
fruit_gas	7	Normal Attack	TAP	\N	\N
fruit_gas	8	Suffocating Fumes	Z	1	\N
fruit_gas	9	Bursting Vapor	X	100	\N
fruit_gas	10	Smog Demons	C	200	\N
fruit_gas	11	Vapor Condensation	V	300	\N
fruit_gas	12	Traveling Gas	F	50	\N
fruit_spirit	1	Tap	TAP	\N	\N
fruit_spirit	2	Frostfire Grasp	Z	1	\N
fruit_spirit	3	Wrath of Ra	X	150	\N
fruit_spirit	4	Wrath of Shu	C	250	\N
fruit_spirit	5	End of Times	V	350	\N
fruit_spirit	6	Sky Ruler	F	75	\N
fruit_sound	1	Rhapsody Notes	Z	1	\N
fruit_sound	2	Fortissimo	X	50	\N
fruit_sound	3	Symphonic Radiance	C	100	\N
fruit_sound	4	Glorious Harmony	V	250	\N
fruit_sound	5	Tempo: Prestissimo	F	175	\N
fruit_sound	6	Rhapsody Notes	Z	1	\N
fruit_sound	7	Fortissimo	X	50	\N
fruit_sound	8	Symphonic Radiance	C	100	\N
fruit_sound	9	Glorious Harmony	V	250	\N
fruit_sound	10	Tempo: Prestissimo	F	175	\N
fruit_portal	1	Tap	TAP	\N	\N
fruit_portal	2	Portal Dash	Z	1	\N
fruit_portal	3	Parallel Escape	X	50	\N
fruit_portal	4	World Warp	C	200	\N
fruit_portal	5	Dimensional Rift	V	300	\N
fruit_portal	6	Quantum Leap	F	100	\N
fruit_phoenix	1	Cannon	Z	1	\N
fruit_phoenix	2	Regeneration Flames	X	90	\N
fruit_phoenix	3	Fast Kick	C	160	\N
fruit_phoenix	4	Full Transformation	V	250	\N
fruit_phoenix	5	Hybrid Flight	F	30	\N
fruit_phoenix	6	Cannon	Z	1	\N
fruit_phoenix	7	Regeneration Flames	X	90	\N
fruit_phoenix	8	Fast Kick	C	160	\N
fruit_phoenix	9	Full Transformation	V	250	\N
fruit_phoenix	10	Hybrid Flight	F	30	\N
fruit_phoenix	11	Normal Attack	TAP	\N	4000
fruit_phoenix	12	Cremation Cannon	Z	1	500
fruit_phoenix	13	Blue Flames	X	90	3000
fruit_phoenix	14	Flame Exodus	C	160	4000
fruit_phoenix	15	Blazing Plumage	V	250	5000
fruit_phoenix	16	Swift Flight	F	30	2000
fruit_phoenix	17	Normal Attack	TAP	\N	4000
fruit_phoenix	18	Cremation Cannon	Z	1	500
fruit_phoenix	19	Blue Flames	X	90	3000
fruit_phoenix	20	Flame Exodus	C	160	4000
fruit_phoenix	21	Blazing Plumage	V	250	5000
fruit_phoenix	22	Swift Flight	F	30	2000
fruit_spider	1	Spider Wraith	Z	1	\N
fruit_spider	2	Multi-string Attack	X	50	\N
fruit_spider	3	Over-heated Sniper	C	100	\N
fruit_spider	4	Ultimate Thread	V	225	\N
fruit_spider	5	Spider Path	F	15	\N
fruit_spider	6	Thermal Laceration	Z	1	800
fruit_spider	7	Silk Prison	X	50	3500
fruit_spider	8	Eternal White	C	100	4500
fruit_spider	9	Heavenly Punishment	V	225	6000
fruit_spider	10	Spider Highway	F	15	2500
fruit_gravity	1	Normal Attack	TAP	0	\N
fruit_gravity	2	Singularity	Z	1	\N
fruit_gravity	3	Orbital Chain	X	100	\N
fruit_gravity	4	Gravitational Prison	C	200	\N
fruit_gravity	5	Asteroid Crash	V	300	\N
fruit_gravity	6	Shooting Star	F	50	\N
fruit_mammoth	1	Ancient Cutter	Z	1	\N
fruit_mammoth	2	True Prehistoric Punt	X	50	\N
fruit_mammoth	3	Colossal Crusher	C	100	\N
fruit_mammoth	4	Transformation	V	300	\N
fruit_mammoth	5	Stampede	F	200	\N
fruit_mammoth	6	Normal Attack	TAP	\N	\N
fruit_mammoth	7	Ancient Cutter	Z	1	\N
fruit_mammoth	8	True Prehistoric Punt	X	50	\N
fruit_mammoth	9	Colossal Crusher	C	100	\N
fruit_mammoth	10	Transformation	V	300	\N
fruit_mammoth	11	Stampede	F	200	\N
fruit_rumble	1	Rumble Dragon	Z	1	\N
fruit_rumble	2	Sky Thunder	X	90	\N
fruit_rumble	3	Sky Beam	C	160	\N
fruit_rumble	4	Thunder Bomb	V	250	\N
fruit_rumble	5	Lightning Dash	F	30	\N
fruit_rumble	6	Lightning Beast	Z	1	500
fruit_rumble	7	Thunderstorm	X	90	3000
fruit_rumble	8	Sky Judgement	C	160	4000
fruit_rumble	9	Thunderball Destruction	V	250	5000
fruit_rumble	10	Electric Flash	F	30	2000
fruit_pain	1	Heavy Pain	Z	1	\N
fruit_pain	2	Pain Barrage	X	100	\N
fruit_pain	3	Pain Nuke	C	200	\N
fruit_pain	4	Torture	V	300	\N
fruit_pain	5	Self Repel	F	50	\N
fruit_creation	1	Normal Attack	TAP	\N	\N
fruit_creation	2	Batter Up	Z	1	\N
fruit_creation	3	Sleight of Hand	X	45	\N
fruit_creation	4	Sword Box	C	90	\N
fruit_creation	5	Magic City	V	130	\N
fruit_creation	6	Fortify	F	10	\N
fruit_creation	7	Wall	Z	0	\N
fruit_creation	8	Floor	X	0	\N
fruit_creation	9	Ramp	C	0	\N
fruit_creation	10	Erase	V	0	\N
fruit_creation	11	Exit	F	0	\N
fruit_blizzard	1	Snowflake Shuriken	Z	1	\N
fruit_blizzard	2	White Out	X	90	\N
fruit_blizzard	3	Howling Wind	C	160	\N
fruit_blizzard	4	Blizzard Domain	V	250	\N
fruit_blizzard	5	Tornado Flight	F	40	\N
fruit_rubber	1	Normal Attack	TAP	\N	\N
fruit_rubber	2	Cannon	Z	25	\N
fruit_rubber	3	Smash	X	50	\N
fruit_rubber	4	Rush	C	125	\N
fruit_rubber	5	Transformation	V	225	\N
fruit_rubber	6	Slingshot	F	80	\N
fruit_rubber	7	Normal Attack	TAP	\N	\N
fruit_rubber	8	Cannon	Z	25	\N
fruit_rubber	9	Smash	X	50	\N
fruit_rubber	10	Rush	C	125	\N
fruit_rubber	11	Transformation	V	225	\N
fruit_rubber	12	Slingshot	F	80	\N
fruit_quake	1	Quake Punch	Z	1	\N
fruit_quake	2	Quake Wave	X	50	\N
fruit_quake	3	Quake Erupt	C	100	\N
fruit_quake	4	Dual Tsunami	V	150	\N
fruit_quake	5	Fatal Demolisher	Z	1	1000
fruit_quake	6	Air Crusher	X	50	3000
fruit_quake	7	Spatial Shockwave	C	100	5000
fruit_quake	8	Seaquake	V	150	8000
fruit_love	1	Heart Shot	Z	1	\N
fruit_love	2	Cupid's Zone	X	50	\N
fruit_love	3	Irresistible Attraction	C	150	\N
fruit_love	4	Besto Friendo	V	200	\N
fruit_love	5	Flamingo Ride	F	100	\N
fruit_dark	1	Dark Rocks	Z	1	\N
fruit_dark	2	Black Spiral	X	40	\N
fruit_dark	3	Black Hole	C	80	\N
fruit_dark	4	Dark Bomb	V	110	\N
fruit_dark	5	Dimensional Slash	Z	1	500
fruit_dark	6	Abyssal Darkness	X	40	3000
fruit_dark	7	Endless Hole	C	80	4000
fruit_dark	8	World of Darkness	V	110	5000
fruit_dark	9	Ghastly Step	F	0	2000
fruit_magma	1	Magma Clap	Z	1	\N
fruit_magma	2	Magma Eruption	X	45	\N
fruit_magma	3	Magma Fist	C	95	\N
fruit_magma	4	Magma Meteors	V	140	\N
fruit_magma	5	Magma Floor	F	10	\N
fruit_magma	6	Magma Shower	Z	1	500
fruit_magma	7	Volcanic Assault	X	45	3000
fruit_magma	8	Great Magma Hound	C	95	4000
fruit_magma	9	Volcanic Storm	V	140	5000
fruit_magma	10	Beast Ride	F	10	2000
fruit_ghost	1	Shivering Possession	Z	1	\N
fruit_ghost	2	Spectral Release	X	50	\N
fruit_ghost	3	Cries of the Underworld	C	100	\N
fruit_ghost	4	Ghost Busters	V	150	\N
fruit_ghost	5	Wandering Soul	F	75	\N
fruit_light	1	Normal Attack	TAP	\N	\N
fruit_light	2	Light Ray	Z	1	\N
fruit_light	3	Barrage of Light	X	40	\N
fruit_light	4	Reflection Kick	C	80	\N
fruit_light	5	Sky Beam Barrage	V	110	\N
fruit_light	6	Light Flight	F	10	\N
fruit_light	7	Normal Attack	TAP	\N	\N
fruit_light	8	Divine Arrow	Z	1	500
fruit_light	9	Hand of the Emperor	X	40	3000
fruit_light	10	Lightspeed Destroyer	C	80	4000
fruit_light	11	Wrath of God	V	110	5000
fruit_light	12	Shining Flight	F	10	2000
fruit_diamond	1	Radiant Lunge	TAP	\N	\N
fruit_diamond	2	Encrust	Z	1	\N
fruit_diamond	3	Shard Storm	X	1	\N
fruit_diamond	4	Shimmering Disruption	C	80	\N
fruit_diamond	5	Prismatic Reflection	V	110	\N
fruit_buddha	1	Transform	Z	1	\N
fruit_buddha	2	Impact	X	1	\N
fruit_buddha	3	Buddha Leap	C	100	\N
fruit_buddha	4	Buddha Explosion	V	200	\N
fruit_buddha	5	Shift	Z	1	500
fruit_buddha	6	Heavenly Impact	X	1	3000
fruit_buddha	7	Light of Annihilation	C	100	4000
fruit_buddha	8	Twilight of the Gods	V	200	5000
fruit_buddha	9	Retribution Dash	F	0	2000
fruit_bomb	1	Targeted Bomb	Z	1	\N
fruit_bomb	2	Bomb Grab	X	50	\N
fruit_bomb	3	Land Mines	C	75	\N
fruit_bomb	4	Self Destruct	V	125	\N
fruit_bomb	5	Explosive Jump	F	25	\N
fruit_sand	1	Desert Sword	Z	1	\N
fruit_sand	2	Desert Funeral	X	40	\N
fruit_sand	3	Sand Tornado	C	80	\N
fruit_sand	4	Heavy Sand	V	120	\N
fruit_sand	5	Sand Flight	F	15	\N
fruit_sand	6	Desert Blade	Z	1	500
fruit_sand	7	Sand Coffin	X	40	3000
fruit_sand	8	Sandstorm	C	80	4000
fruit_sand	9	Deep Sand	V	120	5000
fruit_sand	10	Tornado Flight	F	15	2000
fruit_smoke	1	Smoke Slam	Z	1	\N
fruit_smoke	2	Smoke Blast	X	20	\N
fruit_smoke	3	Smoke Liberation	C	50	\N
fruit_smoke	4	Smoke Bomber	F	10	\N
fruit_ice	1	Normal Attack	TAP	\N	\N
fruit_ice	2	Ice Spears	Z	1	\N
fruit_ice	3	Ice Surge	X	25	\N
fruit_ice	4	Ice Bird	C	50	\N
fruit_ice	5	Glacial Epoch	V	100	\N
fruit_ice	6	Normal Attack	TAP	\N	\N
fruit_ice	7	Cold Storm	Z	1	500
fruit_ice	8	Glacial Surge	X	25	3000
fruit_ice	9	Frozen Dragon	C	50	4000
fruit_ice	10	Absolute Zero	V	100	5000
fruit_ice	11	Ice Skating	F	0	2000
fruit_spring	1	Knock	Z	1	\N
fruit_spring	2	Spring Snipe	X	20	\N
fruit_spring	3	Spring Cannon	C	50	\N
fruit_spring	4	Spring Emperor	V	125	\N
fruit_spring	5	Spring Leap	F	75	\N
fruit_spike	1	Spike Summon	Z	1	\N
fruit_spike	2	Whirlwind	X	25	\N
fruit_spike	3	Spiky Ball	C	50	\N
fruit_spike	4	Spike Barrage	V	75	\N
fruit_spin	1	Razor Wind	Z	1	\N
fruit_spin	2	Tornado Assault	X	50	\N
fruit_spin	3	Air Slasher	C	90	\N
fruit_spin	4	Helicopter Flight	F	25	\N
fruit_flame	1	Fire Bullets	Z	1	\N
fruit_flame	2	Burning Blast	X	25	\N
fruit_flame	3	Fire Column	C	50	\N
fruit_flame	4	Flame Destroyer	V	100	\N
fruit_flame	5	Fire Flight	F	10	\N
fruit_flame	6	Blue Fire Bullets	Z	1	500
fruit_flame	7	Prominence Burst	X	25	3000
fruit_flame	8	Flaming Vortex	C	50	4000
fruit_flame	9	Hell's Core	V	100	5000
fruit_flame	10	Rocket Flight	F	10	2000
fruit_blade	1	Normal Attack	TAP	\N	\N
fruit_blade	2	Razor Cyclone	Z	1	\N
fruit_blade	3	Blade Dance	X	20	\N
fruit_blade	4	Saw Shredder	C	50	\N
fruit_blade	5	Turbine Flight	F	80	\N
fruit_kitsune	1	Normal Attack	TAP	\N	\N
fruit_kitsune	2	Accursed Enchantment	Z	1	\N
fruit_kitsune	3	Tails of Burning Agony	X	50	\N
fruit_kitsune	4	Fox Fire Disruption	C	100	\N
fruit_kitsune	5	Transformation	V	300	\N
fruit_kitsune	6	Wild Assault	F	200	\N
fruit_kitsune	7	Normal Attack	TAP	\N	\N
fruit_kitsune	8	Accursed Enchantment	Z	1	\N
fruit_kitsune	9	Tails of Burning Agony	X	50	\N
fruit_kitsune	10	Fox Fire Disruption	C	100	\N
fruit_kitsune	11	Transformation	V	300	\N
fruit_kitsune	12	Wild Assault	F	200	\N
fruit_rocket	1	Missile Fist	Z	1	\N
fruit_rocket	2	Air Strike	X	20	\N
fruit_rocket	3	Rocket Crash	C	50	\N
fruit_rocket	4	Blast Off	F	75	\N
fruit_eagle	1	Normal Attack	TAP	\N	\N
fruit_eagle	2	Wind Burst	Z	1	\N
fruit_eagle	3	Feather Storm	X	35	\N
fruit_eagle	4	Bone Crusher	C	80	\N
fruit_eagle	5	Soaring Talon	V	110	\N
fruit_eagle	6	Flight	F	150	\N
sword_dark_blade	1	One Thousand Slices	Z	1	\N
sword_dark_blade	2	Dark Air Slash	X	50	\N
sword_dark_blade	3	One Thousand Slices	Z	1	\N
sword_dark_blade	4	Dark Air Slash	X	50	\N
sword_dark_blade	5	One Thousand Slices	Z	1	\N
sword_dark_blade	6	Dark Air Slash	X	50	\N
sword_dark_blade	7	One Thousand Slices	Z	1	\N
sword_dark_blade	8	Dark Air Slash	X	50	\N
sword_jitte	1	Smoke Leopard	Z	150	\N
sword_jitte	2	Smoke Apparition	X	300	\N
sword_buddha	1	Transform	Z	1	\N
sword_buddha	2	Impact	X	1	\N
sword_buddha	3	Buddha Leap	C	100	\N
sword_buddha	4	Buddha Explosion	V	200	\N
sword_buddha	5	Shift	Z	1	\N
sword_buddha	6	Heavenly Impact	X	1	\N
sword_buddha	7	Light of Annihilation	C	100	\N
sword_buddha	8	Twilight of the Gods	V	200	\N
sword_buddha	9	Retribution Dash	F	0	\N
sword_blade	1	Normal Attack	TAP	\N	\N
sword_blade	2	Razor Cyclone	Z	1	\N
sword_blade	3	Blade Dance	X	20	\N
sword_blade	4	Saw Shredder	C	50	\N
sword_blade	5	Turbine Flight	F	80	\N
sword_hallow_scythe	1	Death Cyclone	Z	150	\N
sword_hallow_scythe	2	Soul Execution	X	350	\N
sword_cursed_dual_katana	1	Revolving Ravager	Z	175	\N
sword_cursed_dual_katana	2	Slayer of Goliath	X	375	\N
sword_true_triple_katana	1	Wolf Fang Rush	Z	150	\N
sword_true_triple_katana	2	Dragon Hurricane	X	350	\N
sword_control	1	Control Area	Z	1	\N
sword_control	2	Levitate	X	1	\N
sword_control	3	Echo Knife	C	150	\N
sword_control	4	Gamma Rush	V	350	\N
sword_control	5	Teleport	F	250	\N
sword_yama	1	Hellish Slash	Z	150	\N
sword_yama	2	Infernal Hurricane	X	300	\N
sword_shark_anchor	1	Typhoon Toss	Z	150	\N
sword_shark_anchor	2	Armor Breaker	X	350	\N
sword_tushita	1	Heavenly Lunges	Z	150	\N
sword_tushita	2	Celestial Ravager	X	300	\N
sword_spikey_trident	1	Dough Hurricane	Z	150	\N
sword_spikey_trident	2	Flying Trident Pull	X	300	\N
sword_rengoku	1	Demon Slayer	Z	150	\N
sword_rengoku	2	Burning Slash	X	350	\N
sword_saber	1	Deadly Rush	Z	50	\N
sword_saber	2	Triple Slash	X	125	\N
sword_saber	3	Deadly Rush	Z	50	\N
sword_saber	4	Triple Slash	X	125	\N
sword_saishi	1	Swords Dance	Z	150	\N
sword_saishi	2	True Air Slash	X	300	\N
sword_pole_2nd_form	1	Hand of God	Z	150	\N
sword_pole_2nd_form	2	Electric Prison	X	350	\N
sword_pole_1st_form	1	Explosive Cloud	Z	80	\N
sword_pole_1st_form	2	Lightning Rain	X	180	\N
sword_shizu	1	True Quiet Rush	Z	150	\N
sword_shizu	2	Focus Shot	X	300	\N
sword_oroshi	1	Continuous Slashing	Z	150	\N
sword_oroshi	2	Dragon Gust	X	300	\N
sword_midnight_blade	1	Portal Opening	Z	150	\N
sword_midnight_blade	2	Crescent Dash	X	325	\N
sword_fox_lamp	1	Scorching Azure	Z	150	\N
sword_fox_lamp	2	Infernal Firestorm	X	350	\N
sword_dragonheart	1	Draconic Blitz	Z	150	\N
sword_dragonheart	2	Infernal Catastrophe	X	350	\N
sword_koko	1	Electric Stab	Z	150	\N
sword_koko	2	Injection Shot	X	325	\N
sword_canvander	1	Piercing Dash	Z	150	\N
sword_canvander	2	Scattering Gust	X	300	\N
sword_dark_dagger	1	Proficient Impale	Z	150	\N
sword_dark_dagger	2	Shaming Slash	X	300	\N
sword_bisento	1	Wind Breaker	Z	50	\N
sword_bisento	2	Quake Sphere	X	150	\N
sword_bisento	3	Wind Breaker	Z	50	\N
sword_bisento	4	Quake Sphere	X	150	\N
sword_buddy_sword	1	Heat Slash	Z	150	\N
sword_buddy_sword	2	Lightning Wave	X	300	\N
sword_wardens_sword	1	Multi-Target Slash	Z	35	\N
sword_wardens_sword	2	Tornado Slash	X	80	\N
sword_soul_cane	1	Soul Beam	Z	40	\N
sword_soul_cane	2	Soul Slashes	X	120	\N
sword_pipe	1	Pipe Ignition	Z	1	\N
sword_pipe	2	Dragon Blast	X	50	\N
sword_longsword	1	Annihilate	Z	100	\N
sword_longsword	2	Glorious Smash	X	200	\N
sword_trident	1	Trident Throw	Z	50	\N
sword_trident	2	Water Pulse	X	125	\N
sword_gravity_blade	1	Dimensional Grasp	Z	125	\N
sword_gravity_blade	2	Lunar Blitz	X	250	\N
sword_flail	1	Smoke Leopard	Z	150	\N
sword_flail	2	Smoke Apparition	X	300	\N
sword_dual-headed_blade	1	Assassinate	Z	20	\N
sword_dual-headed_blade	2	Raging Wind	X	100	\N
sword_triple_katana	1	Air Slashes Barrage	Z	20	\N
sword_triple_katana	2	Violent Rush	X	60	\N
sword_dual_katana	1	Whirlwind	Z	1	\N
sword_dual_katana	2	Tornado	X	30	\N
sword_dragon_trident	1	Sea Dragon Fury	Z	150	\N
sword_dragon_trident	2	Water Dragon Shower	X	350	\N
sword_katana	1	Quiet Rush	Z	1	\N
sword_katana	2	Air Slash	X	20	\N
sword_iron_mace	1	Mace Smash	Z	1	\N
sword_iron_mace	2	Killer Combo	X	30	\N
sword_shark_saw	1	Consecutive Slashes	Z	10	\N
sword_shark_saw	2	Execution	X	60	\N
sword_cutlass	1	Quiet Rush	Z	1	\N
sword_cutlass	2	Air Slash	X	20	\N
sword_twin_hooks	1	Sky Cyclone	Z	150	\N
sword_twin_hooks	2	Prehistoric Punt	X	300	\N
gun_bizarre_revolver	1	Normal Attack	TAP	\N	\N
gun_bizarre_revolver	2	Space Bending Blast	Z	150	\N
gun_bizarre_revolver	3	Dimensional Surge	X	300	\N
gun_acidum_rifle	1	Normal Attack	TAP	\N	\N
gun_acidum_rifle	2	Spiky Bomb	Z	100	\N
gun_acidum_rifle	3	Acidic Smoke	X	200	\N
gun_bizarre_rifle	1	Normal Attack	TAP	\N	\N
gun_bizarre_rifle	2	Heat-Seeking Shot	Z	150	\N
gun_bizarre_rifle	3	Hellfire Shower	X	300	\N
gun_refined_flintlock	1	Disabling Shot	Z	40	\N
gun_refined_flintlock	2	Rapid Gun	X	80	\N
gun_refined_musket	1	Dragon Bullet	Z	75	\N
gun_refined_musket	2	Bold Pistolero	X	200	\N
gun_dragonstorm	1	Normal Attack	TAP	\N	\N
gun_dragonstorm	2	Draconic Cascade	Z	125	\N
gun_dragonstorm	3	Infernal Comet	X	250	\N
gun_skull_guitar	1	Undead Notes	TAP	\N	\N
gun_skull_guitar	2	Soul Shaker	Z	150	\N
gun_skull_guitar	3	El Diablo	X	300	\N
gun_rubber	1	Normal Attack	TAP	\N	\N
gun_rubber	2	Cannon	Z	25	\N
gun_rubber	3	Smash	X	50	\N
gun_rubber	4	Rush	C	125	\N
gun_rubber	5	Transformation	V	225	\N
gun_rubber	6	Slingshot	F	80	\N
gun_rubber	7	Normal Attack	TAP	\N	\N
gun_rubber	8	Cannon	Z	25	\N
gun_rubber	9	Smash	X	50	\N
gun_rubber	10	Rush	C	125	\N
gun_rubber	11	Transformation	V	225	\N
gun_rubber	12	Slingshot	F	80	\N
gun_venom_bow	1	Normal Attack	TAP	\N	\N
gun_venom_bow	2	Venomous Spit	Z	125	\N
gun_venom_bow	3	Serpent Bite	X	250	\N
gun_bazooka	1	Normal Attack	TAP	\N	\N
gun_bazooka	2	Heat Wave	Z	100	\N
gun_bazooka	3	Flaring Missiles	X	250	\N
gun_kabucha	1	Blazing Phoenix	Z	125	\N
gun_kabucha	2	Dragon Tempest	X	250	\N
gun_dual_flintlock	1	Normal Attack	TAP	\N	\N
gun_dual_flintlock	2	Splitting Beam	Z	30	\N
gun_dual_flintlock	3	Bullet Storm	X	120	\N
gun_cannon	1	Chain Detonation	Z	40	\N
gun_cannon	2	Incendiary Ammo	X	100	\N
gun_magma_blaster	1	Scorching Burst	Z	75	\N
gun_magma_blaster	2	Magmatic Pressure	X	200	\N
gun_refined_slingshot	1	Ink Swarm	Z	40	\N
gun_refined_slingshot	2	Cluster Bomb	X	80	\N
gun_musket	1	Draconic Bullet	Z	20	\N
gun_musket	2	Torching Shot	X	50	\N
gun_flintlock	1	Concentrated Shot	Z	15	\N
gun_flintlock	2	Marksman Fury	X	80	\N
gun_slingshot	1	Ink Bomb	Z	20	\N
gun_slingshot	2	Proximity Bomb	X	40	\N
\.


--
-- TOC entry 4848 (class 0 OID 18412)
-- Dependencies: 218
-- Data for Name: equipment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.equipment (equipment_id, name, url, "timestamp", type, rarity, release_date) FROM stdin;
fruit_dragon	Dragon	https://blox-fruits.fandom.com/wiki/Dragon	2025-08-08 11:22:46	Beast	Mythical	Update 13
fruit_soul	Soul	https://blox-fruits.fandom.com/wiki/Soul	2025-08-08 11:22:48	Natural	Mythical	Update 17.1
fruit_revive	Revive	https://blox-fruits.fandom.com/wiki/Revive	2025-08-08 11:22:48	Natural	Uncommon	Update 16
fruit_kilo	Kilo	https://blox-fruits.fandom.com/wiki/Kilo	2025-08-08 11:22:48	Natural	Common	Update 15
fruit_falcon	Falcon	https://blox-fruits.fandom.com/wiki/Falcon	2025-08-08 11:22:48	Beast	Uncommon	Update 15
fruit_leopard	Leopard	https://blox-fruits.fandom.com/wiki/Leopard	2025-08-08 11:22:48	Beast	Mythical	Update 17.3
fruit_barrier	Barrier	https://blox-fruits.fandom.com/wiki/Barrier	2025-08-08 11:22:48	Natural	Rare	Update 8
fruit_yeti	Yeti	https://blox-fruits.fandom.com/wiki/Yeti	2025-08-08 11:22:48	Beast	Mythical	Update 25
fruit_chop	Chop	https://blox-fruits.fandom.com/wiki/Chop	2025-08-08 11:22:48	Natural	Common	Update 1
fruit_shadow	Shadow	https://blox-fruits.fandom.com/wiki/Shadow	2025-08-08 11:22:48	Natural	Mythical	Update 16
fruit_control	Control	https://blox-fruits.fandom.com/wiki/Control	2025-08-08 11:22:48	Natural	Mythical	Update 10
fruit_dough	Dough	https://blox-fruits.fandom.com/wiki/Dough	2025-08-08 11:22:48	Elemental	Mythical	Update 9
fruit_venom	Venom	https://blox-fruits.fandom.com/wiki/Venom	2025-08-08 11:22:48	Natural	Mythical	Update 15
fruit_gas	Gas	https://blox-fruits.fandom.com/wiki/Gas	2025-08-08 11:22:49	Elemental	Mythical	Update 24
fruit_door	Door	https://blox-fruits.fandom.com/wiki/Door	2025-08-08 11:22:49	Natural	Rare	Update 15
fruit_spirit	Spirit	https://blox-fruits.fandom.com/wiki/Spirit	2025-08-08 11:22:49	Natural	Mythical	Update 17.1
fruit_sound	Sound	https://blox-fruits.fandom.com/wiki/Sound	2025-08-08 11:22:49	Natural	Legendary	Update 20
fruit_portal	Portal	https://blox-fruits.fandom.com/wiki/Portal	2025-08-08 11:22:49	Natural	Legendary	Update 17
fruit_phoenix	Phoenix	https://blox-fruits.fandom.com/wiki/Phoenix	2025-08-08 11:22:49	Beast	Legendary	Update 2
fruit_spider	Spider	https://blox-fruits.fandom.com/wiki/Spider	2025-08-08 11:22:49	Natural	Legendary	Update 3
fruit_gravity	Gravity	https://blox-fruits.fandom.com/wiki/Gravity	2025-08-08 11:22:49	Natural	Mythical	Update 5
fruit_mammoth	Mammoth	https://blox-fruits.fandom.com/wiki/Mammoth	2025-08-08 11:22:49	Beast	Mythical	Update 20
fruit_rumble	Rumble	https://blox-fruits.fandom.com/wiki/Rumble	2025-08-08 11:22:49	Elemental	Legendary	Update 3
fruit_pain	Pain	https://blox-fruits.fandom.com/wiki/Pain	2025-08-08 11:22:49	Natural	Legendary	Update 7
fruit_creation	Creation	https://blox-fruits.fandom.com/wiki/Creation	2025-08-08 11:22:49	Natural	Legendary	Update 26
fruit_blizzard	Blizzard	https://blox-fruits.fandom.com/wiki/Blizzard	2025-08-08 11:22:49	Elemental	Legendary	Update 17
fruit_rubber	Rubber	https://blox-fruits.fandom.com/wiki/Rubber	2025-08-08 11:22:49	Natural	Rare	Update 1
fruit_quake	Quake	https://blox-fruits.fandom.com/wiki/Quake	2025-08-08 11:22:50	Natural	Legendary	Update 1
fruit_love	Love	https://blox-fruits.fandom.com/wiki/Love	2025-08-08 11:22:50	Natural	Legendary	Update 15
fruit_dark	Dark	https://blox-fruits.fandom.com/wiki/Dark	2025-08-08 11:22:50	Elemental	Uncommon	Update 1
fruit_magma	Magma	https://blox-fruits.fandom.com/wiki/Magma	2025-08-08 11:22:50	Elemental	Rare	Update 1
fruit_ghost	Ghost	https://blox-fruits.fandom.com/wiki/Ghost	2025-08-08 11:22:50	Natural	Rare	Update 16
fruit_light	Light	https://blox-fruits.fandom.com/wiki/Light	2025-08-08 11:22:50	Elemental	Rare	Update 1
fruit_diamond	Diamond	https://blox-fruits.fandom.com/wiki/Diamond	2025-08-08 11:22:50	Natural	Uncommon	Update 15
fruit_buddha	Buddha	https://blox-fruits.fandom.com/wiki/Buddha	2025-08-08 11:22:50	Beast	Legendary	Update 1
fruit_bomb	Bomb	https://blox-fruits.fandom.com/wiki/Bomb	2025-08-08 11:22:50	Natural	Common	Update 1
fruit_sand	Sand	https://blox-fruits.fandom.com/wiki/Sand	2025-08-08 11:22:50	Elemental	Uncommon	Update 4
fruit_smoke	Smoke	https://blox-fruits.fandom.com/wiki/Smoke	2025-08-08 11:22:50	Elemental	Common	Update 1
fruit_ice	Ice	https://blox-fruits.fandom.com/wiki/Ice	2025-08-08 11:22:50	Elemental	Uncommon	Update 1
fruit_spring	Spring	https://blox-fruits.fandom.com/wiki/Spring	2025-08-08 11:22:50	Natural	Common	Update 2
fruit_spike	Spike	https://blox-fruits.fandom.com/wiki/Spike	2025-08-08 11:22:50	Natural	Common	Update 1
fruit_spin	Spin	https://blox-fruits.fandom.com/wiki/Spin	2025-08-08 11:22:51	Natural	Common	Update 15
fruit_flame	Flame	https://blox-fruits.fandom.com/wiki/Flame	2025-08-08 11:22:51	Elemental	Uncommon	Update 1
fruit_blade	Blade	https://blox-fruits.fandom.com/wiki/Blade	2025-08-08 11:22:51	Natural	Common	Update 24
fruit_kitsune	Kitsune	https://blox-fruits.fandom.com/wiki/Kitsune	2025-08-08 11:22:51	Beast	Mythical	Update 22
fruit_rocket	Rocket	https://blox-fruits.fandom.com/wiki/Rocket	2025-08-08 11:22:51	Natural	Common	Update 20
fruit_eagle	Eagle	https://blox-fruits.fandom.com/wiki/Eagle	2025-08-08 11:22:51	Beast	Uncommon	Update 26
sword_dark_blade	Dark Blade	https://blox-fruits.fandom.com/wiki/Dark_Blade	2025-08-08 11:23:05	Swords	Mythical	Update 1
sword_jitte	Jitte	https://blox-fruits.fandom.com/wiki/Jitte	2025-08-08 11:23:10	Swords	Rare	Update 10
sword_buddha	Buddha	https://blox-fruits.fandom.com/wiki/Buddha	2025-08-08 11:23:10	Beast	Legendary	Update 1
sword_triple_dark_blade	Triple Dark Blade	https://blox-fruits.fandom.com/wiki/Triple_Dark_Blade	2025-08-08 11:23:11	Swords	Mythical	Update
sword_blade	Blade	https://blox-fruits.fandom.com/wiki/Blade	2025-08-08 11:23:11	Natural	Common	Update 24
sword_hallow_scythe	Hallow Scythe	https://blox-fruits.fandom.com/wiki/Hallow_Scythe	2025-08-08 11:23:11	Swords	Mythical	Update 16
sword_cursed_dual_katana	Cursed Dual Katana	https://blox-fruits.fandom.com/wiki/Cursed_Dual_Katana	2025-08-08 11:23:11	Swords	Mythical	Update 17.3
sword_true_triple_katana	True Triple Katana	https://blox-fruits.fandom.com/wiki/True_Triple_Katana	2025-08-08 11:23:11	Swords	Mythical	Update 9
sword_control	Control	https://blox-fruits.fandom.com/wiki/Control	2025-08-08 11:23:11	Natural	Mythical	Update 10
sword_yama	Yama	https://blox-fruits.fandom.com/wiki/Yama	2025-08-08 11:23:11	Swords	Legendary	Update 15
sword_shark_anchor	Shark Anchor	https://blox-fruits.fandom.com/wiki/Shark_Anchor	2025-08-08 11:23:11	Swords	Legendary	Update 20
sword_tushita	Tushita	https://blox-fruits.fandom.com/wiki/Tushita	2025-08-08 11:23:11	Swords	Legendary	Update 15
sword_spikey_trident	Spikey Trident	https://blox-fruits.fandom.com/wiki/Spikey_Trident	2025-08-08 11:23:11	Swords	Legendary	Update 17.2
sword_rengoku	Rengoku	https://blox-fruits.fandom.com/wiki/Rengoku	2025-08-08 11:23:12	Swords	Legendary	Update 13
sword_saber	Saber	https://blox-fruits.fandom.com/wiki/Saber	2025-08-08 11:23:12	Swords	Legendary	Update 1
sword_saishi	Saishi	https://blox-fruits.fandom.com/wiki/Saishi	2025-08-08 11:23:12	Swords	Legendary	Update 8
sword_pole_2nd_form	Pole (2nd Form)	https://blox-fruits.fandom.com/wiki/Pole_(2nd_Form)	2025-08-08 11:23:12	Swords	Legendary	Update 14
sword_pole_1st_form	Pole (1st Form)	https://blox-fruits.fandom.com/wiki/Pole_(1st_Form)	2025-08-08 11:23:12	Swords	Legendary	Update 3
sword_shizu	Shizu	https://blox-fruits.fandom.com/wiki/Shizu	2025-08-08 11:23:12	Swords	Legendary	Update 8
sword_oroshi	Oroshi	https://blox-fruits.fandom.com/wiki/Oroshi	2025-08-08 11:23:12	Swords	Legendary	Update 8
sword_midnight_blade	Midnight Blade	https://blox-fruits.fandom.com/wiki/Midnight_Blade	2025-08-08 11:23:12	Swords	Legendary	Update 12
sword_fox_lamp	Fox Lamp	https://blox-fruits.fandom.com/wiki/Fox_Lamp	2025-08-08 11:23:12	Swords	Legendary	Update 22
sword_dragonheart	Dragonheart	https://blox-fruits.fandom.com/wiki/Dragonheart	2025-08-08 11:23:13	Swords	Legendary	Update 24
sword_koko	Koko	https://blox-fruits.fandom.com/wiki/Koko	2025-08-08 11:23:13	Swords	Legendary	Update 10
sword_canvander	Canvander	https://blox-fruits.fandom.com/wiki/Canvander	2025-08-08 11:23:13	Swords	Legendary	Update 15
sword_dark_dagger	Dark Dagger	https://blox-fruits.fandom.com/wiki/Dark_Dagger	2025-08-08 11:23:13	Swords	Legendary	Update 15
sword_bisento	Bisento	https://blox-fruits.fandom.com/wiki/Bisento	2025-08-08 11:23:13	Swords	Legendary	Update 1
sword_buddy_sword	Buddy Sword	https://blox-fruits.fandom.com/wiki/Buddy_Sword	2025-08-08 11:23:13	Swords	Legendary	Update 17
sword_wardens_sword	Wardens Sword	https://blox-fruits.fandom.com/wiki/Wardens_Sword	2025-08-08 11:23:13	Swords	Rare	Update 1
sword_soul_cane	Soul Cane	https://blox-fruits.fandom.com/wiki/Soul_Cane	2025-08-08 11:23:13	Swords	Rare	Update 2
sword_pipe	Pipe	https://blox-fruits.fandom.com/wiki/Pipe	2025-08-08 11:23:13	Swords	Rare	Update 1
sword_longsword	Longsword	https://blox-fruits.fandom.com/wiki/Longsword	2025-08-08 11:23:14	Swords	Rare	Update 8
sword_trident	Trident	https://blox-fruits.fandom.com/wiki/Trident	2025-08-08 11:23:14	Swords	Rare	Update 3
sword_gravity_blade	Gravity Blade	https://blox-fruits.fandom.com/wiki/Gravity_Blade	2025-08-08 11:23:14	Swords	Rare	Update 8
sword_flail	Flail	https://blox-fruits.fandom.com/wiki/Flail	2025-08-08 11:23:14	Swords	Rare	Update 10
sword_dual-headed_blade	Dual-Headed Blade	https://blox-fruits.fandom.com/wiki/Dual-Headed_Blade	2025-08-08 11:23:14	Swords	Rare	Update 1
sword_triple_katana	Triple Katana	https://blox-fruits.fandom.com/wiki/Triple_Katana	2025-08-08 11:23:15	Swords	Uncommon	Update 1
sword_dual_katana	Dual Katana	https://blox-fruits.fandom.com/wiki/Dual_Katana	2025-08-08 11:23:15	Swords	Common	Update 1
sword_dragon_trident	Dragon Trident	https://blox-fruits.fandom.com/wiki/Dragon_Trident	2025-08-08 11:23:15	Swords	Rare	Update 14
sword_katana	Katana	https://blox-fruits.fandom.com/wiki/Katana	2025-08-08 11:23:15	Swords	Common	Update 1
sword_iron_mace	Iron Mace	https://blox-fruits.fandom.com/wiki/Iron_Mace	2025-08-08 11:23:15	Swords	Uncommon	Update 1
sword_shark_saw	Shark Saw	https://blox-fruits.fandom.com/wiki/Shark_Saw	2025-08-08 11:23:15	Swords	Uncommon	Update 1
sword_cutlass	Cutlass	https://blox-fruits.fandom.com/wiki/Cutlass	2025-08-08 11:23:15	Swords	Common	Update 1
sword_twin_hooks	Twin Hooks	https://blox-fruits.fandom.com/wiki/Twin_Hooks	2025-08-08 11:23:15	Swords	Uncommon	Update 15
gun_bizarre_revolver	Bizarre Revolver	https://blox-fruits.fandom.com/wiki/Bizarre_Revolver	2025-08-08 11:23:19	Guns	Rare	Update 12
gun_acidum_rifle	Acidum Rifle	https://blox-fruits.fandom.com/wiki/Acidum_Rifle	2025-08-08 11:23:19	Guns	Rare	Update 8
gun_bizarre_rifle	Bizarre Rifle	https://blox-fruits.fandom.com/wiki/Bizarre_Rifle	2025-08-08 11:23:19	Guns	Rare	Update 12
gun_refined_flintlock	Refined Flintlock	https://blox-fruits.fandom.com/wiki/Refined_Flintlock	2025-08-08 11:23:23	Guns	Rare	Update 1
gun_refined_musket	Refined Musket	https://blox-fruits.fandom.com/wiki/Refined_Musket	2025-08-08 11:23:23	Guns	Rare	Update 2
gun_dragonstorm	Dragonstorm	https://blox-fruits.fandom.com/wiki/Dragonstorm	2025-08-08 11:23:24	Guns	Legendary	Update 24
gun_skull_guitar	Skull Guitar	https://blox-fruits.fandom.com/wiki/Skull_Guitar	2025-08-08 11:23:24	Guns	Mythical	Update 17.3
gun_rubber	Rubber	https://blox-fruits.fandom.com/wiki/Rubber	2025-08-08 11:23:24	Natural	Rare	Update 1
gun_venom_bow	Venom Bow	https://blox-fruits.fandom.com/wiki/Venom_Bow	2025-08-08 11:23:24	Guns	Legendary	Update 15
gun_bazooka	Bazooka	https://blox-fruits.fandom.com/wiki/Bazooka	2025-08-08 11:23:25	Guns	Legendary	Update 3
gun_kabucha	Kabucha	https://blox-fruits.fandom.com/wiki/Kabucha	2025-08-08 11:23:25	Guns	Legendary	Update 8
gun_dual_flintlock	Dual Flintlock	https://blox-fruits.fandom.com/wiki/Dual_Flintlock	2025-08-08 11:23:25	Guns	Rare	Update 1
gun_cannon	Cannon	https://blox-fruits.fandom.com/wiki/Cannon	2025-08-08 11:23:25	Guns	Rare	Update 1
gun_magma_blaster	Magma Blaster	https://blox-fruits.fandom.com/wiki/Magma_Blaster	2025-08-08 11:23:25	Guns	Rare	Update 24
gun_refined_slingshot	Refined Slingshot	https://blox-fruits.fandom.com/wiki/Refined_Slingshot	2025-08-08 11:23:25	Guns	Rare	Update 1
gun_musket	Musket	https://blox-fruits.fandom.com/wiki/Musket	2025-08-08 11:23:25	Guns	Uncommon	Update 1
gun_flintlock	Flintlock	https://blox-fruits.fandom.com/wiki/Flintlock	2025-08-08 11:23:25	Guns	Uncommon	Update 1
gun_slingshot	Slingshot	https://blox-fruits.fandom.com/wiki/Slingshot	2025-08-08 11:23:25	Guns	Common	Update 1
\.


--
-- TOC entry 4850 (class 0 OID 18426)
-- Dependencies: 220
-- Data for Name: fruit; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fruit (equipment_id, fruit_type, money_price, robux_price, can_m1, fruit_value, fruit_demand, fruit_status) FROM stdin;
fruit_dragon	Beast	15000000	5000	Yes	\N	\N	\N
fruit_soul	Natural	3400000	2550	Yes	\N	\N	\N
fruit_revive	Natural	550000	975	No	\N	\N	\N
fruit_kilo	Natural	5000	50	No	\N	\N	\N
fruit_falcon	Beast	300000	650	No	\N	\N	\N
fruit_leopard	Beast	5000000	3000	\N	55000000	10	Overpaid
fruit_barrier	Natural	800000	1250	No	\N	\N	\N
fruit_yeti	Beast	5000000	3000	\N	140000000	10	Overpaid
fruit_chop	Natural	30000	100	No	\N	\N	\N
fruit_shadow	Natural	2900000	2425	No	6500000	6	Stable
fruit_control	Natural	3200000	2500	No	10000000	4	Underpaid
fruit_dough	Elemental	2800000	2400	\N	30000000	10	Stable
fruit_venom	Natural	3000000	2450	No	12000000	8	Stable
fruit_gas	Elemental	3200000	2500	Yes	75000000	9	Stable
fruit_door	Natural	950000	\N	No	\N	\N	\N
fruit_spirit	Natural	3400000	2550	Yes	11000000	6	Stable
fruit_sound	Natural	1700000	1900	No	2500000	4	Stable
fruit_portal	Natural	1900000	2000	Yes	10000000	10	Overpaid
fruit_phoenix	Beast	1800000	2000	\N	2750000	3	Stable
fruit_spider	Natural	1500000	1800	No	1500000	2	Stable
fruit_gravity	Natural	2500000	2300	Yes	20000000	4	Unstable
fruit_mammoth	Beast	2700000	2350	\N	10000000	6	Stable
fruit_rumble	Elemental	2100000	2100	No	30000000	10	Fluctuating
fruit_pain	Natural	\N	\N	No	15000000	4	Fluctuating
fruit_creation	Natural	1400000	1750	Yes	4000000	4	Unstable
fruit_blizzard	Elemental	2400000	2250	No	5000000	5	Stable
fruit_rubber	Natural	750000	1200	Yes	700000	1	Stable
fruit_quake	Natural	1000000	1500	No	1000000	2	Stable
fruit_love	Natural	1300000	1700	No	1500000	3	Stable
fruit_dark	Elemental	500000	950	No	400000	1	Stable
fruit_magma	Elemental	960000	1300	No	1150000	8	Overpaid
fruit_ghost	Natural	940000	1275	No	800000	1	Underpaid
fruit_light	Elemental	650000	1100	Yes	800000	2	Stable
fruit_diamond	Natural	600000	1000	Yes	1000000	2	Underpaid
fruit_buddha	Beast	1200000	1650	No	10000000	10	Overpaid
fruit_bomb	Natural	80000	220	No	80000	1	Stable
fruit_sand	Elemental	420000	850	No	420000	1	Stable
fruit_smoke	Elemental	100000	250	No	100000	1	Stable
fruit_ice	Elemental	350000	750	Yes	550000	2	Stable
fruit_spring	Natural	60000	180	No	60000	1	Stable
fruit_spike	Natural	180000	380	No	180000	1	Stable
fruit_spin	Natural	7500	75	No	7500	1	Stable
fruit_flame	Elemental	250000	550	No	250000	1	Stable
fruit_blade	Natural	30000	100	Yes	50000	1	Stable
fruit_kitsune	Beast	8000000	4000	Yes	240000000	10	Overpaid
fruit_rocket	Natural	5000	50	No	5000	1	Stable
fruit_eagle	Beast	550000	975	Yes	800000	2	Unstable
\.


--
-- TOC entry 4852 (class 0 OID 18448)
-- Dependencies: 222
-- Data for Name: gun; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.gun (equipment_id) FROM stdin;
gun_bizarre_revolver
gun_acidum_rifle
gun_bizarre_rifle
gun_refined_flintlock
gun_refined_musket
gun_dragonstorm
gun_skull_guitar
gun_rubber
gun_venom_bow
gun_bazooka
gun_kabucha
gun_dual_flintlock
gun_cannon
gun_magma_blaster
gun_refined_slingshot
gun_musket
gun_flintlock
gun_slingshot
\.


--
-- TOC entry 4849 (class 0 OID 18419)
-- Dependencies: 219
-- Data for Name: stock_event; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.stock_event (stock_event_id, "timestamp", stock_start_time) FROM stdin;
stock_20250808000000	2025-08-08 11:22:59	2025-08-08 07:00:00+07
\.


--
-- TOC entry 4855 (class 0 OID 18487)
-- Dependencies: 225
-- Data for Name: stock_item; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.stock_item (stock_event_id, stock_item_id, fruit_id) FROM stdin;
stock_20250808000000	1	fruit_smoke
stock_20250808000000	2	fruit_dark
stock_20250808000000	3	fruit_light
stock_20250808000000	4	fruit_flame
stock_20250808000000	5	fruit_dark
stock_20250808000000	6	fruit_light
stock_20250808000000	7	fruit_spider
\.


--
-- TOC entry 4851 (class 0 OID 18438)
-- Dependencies: 221
-- Data for Name: sword; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sword (equipment_id) FROM stdin;
sword_dark_blade
sword_jitte
sword_buddha
sword_triple_dark_blade
sword_blade
sword_hallow_scythe
sword_cursed_dual_katana
sword_true_triple_katana
sword_control
sword_yama
sword_shark_anchor
sword_tushita
sword_spikey_trident
sword_rengoku
sword_saber
sword_saishi
sword_pole_2nd_form
sword_pole_1st_form
sword_shizu
sword_oroshi
sword_midnight_blade
sword_fox_lamp
sword_dragonheart
sword_koko
sword_canvander
sword_dark_dagger
sword_bisento
sword_buddy_sword
sword_wardens_sword
sword_soul_cane
sword_pipe
sword_longsword
sword_trident
sword_gravity_blade
sword_flail
sword_dual-headed_blade
sword_triple_katana
sword_dual_katana
sword_dragon_trident
sword_katana
sword_iron_mace
sword_shark_saw
sword_cutlass
sword_twin_hooks
\.


--
-- TOC entry 4847 (class 0 OID 18405)
-- Dependencies: 217
-- Data for Name: update; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.update (update_id, update_title, release_date, "timestamp") FROM stdin;
Update 1	Update 1: THE FIRST UPDATE 1️⃣	January 16, 2019	2025-08-08 11:23:28
Update 2	Update 2: 🌊	June 16, 2019	2025-08-08 11:23:28
Update 3	Update 3: ⚖	June 30, 2019	2025-08-08 11:23:28
Update 3.5	Update 3.5: ⚖	July 02, 2019	2025-08-08 11:23:28
Update 4	Update 4: ⚖	July 07, 2019	2025-08-08 11:23:28
Update 5	Update 5: 🏝	July 14, 2019	2025-08-08 11:23:28
Update 6	Update 6: The PvP/Teams Update	July 28, 2019	2025-08-08 11:23:28
Update 7	Update 7	August 11, 2019	2025-08-08 11:23:28
Update 8	Update 8: The New World Update 🏝️	November 23, 2019	2025-08-08 11:23:28
Update 9	Update 9: The Anti-Copyright Update	December 25, 2019	2025-08-08 11:23:28
Update 10	Update 10: 🔥🧊	April 17, 2020	2025-08-08 11:23:28
Update 11	Update 11: The Awakening Update	July 10, 2020	2025-08-08 11:23:28
Update 12	Update 12: Halloween Update 🎃	October 21, 2020	2025-08-08 11:23:28
Update 13	Update 13: The Christmas Update 🎄	December 23, 2020	2025-08-08 11:23:28
Update 14	Update 14: 🤖	March 20, 2021	2025-08-08 11:23:28
Update 15	Update 15: Third Sea 🌊	September 11, 2021	2025-08-08 11:23:28
Update 16	Update 16: Halloween Update 💀	November 05, 2021	2025-08-08 11:23:28
Update 17.1	Update 17.1: Christmas Update	December 31, 2021	2025-08-08 11:23:28
Update 17.2	Update 17.2	March 12, 2022	2025-08-08 11:23:28
Update 17.3	Update 17.3: Part 3	September 10, 2022	2025-08-08 11:23:28
Update 17.3.5	Update 17.3.5: Part 3.5 Christmas Update	December 26, 2022	2025-08-08 11:23:28
Update 18	Update 18: Race V4 Update	January 06, 2023	2025-08-08 11:23:28
Update 19	Update 19: Valentine's Event 💞	February 25, 2023	2025-08-08 11:23:28
Update 20	Update 20: 🦈	October 21, 2023	2025-08-08 11:23:28
Update 21	Update 21: Ghost Event 👻	November 02, 2023	2025-08-08 11:23:28
Update 22	Update 22: Kitsune Update ⛩️	December 15, 2023	2025-08-08 11:23:28
Update 23	Update 23: Winter Update Part 1 🎁	December 25, 2023	2025-08-08 11:23:28
Update 24	Update 24: Dragon Update 🐲️‍🔥	December 14, 2024	2025-08-08 11:23:28
Update 25	Update 25: XMAS Update 🎁	December 25, 2024	2025-08-08 11:23:28
Update 26	Update 26: Gravity Update ☄️⭐	April 17, 2025	2025-08-08 11:23:28
\.


--
-- TOC entry 4854 (class 0 OID 18470)
-- Dependencies: 224
-- Data for Name: update_item; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.update_item (update_id, change_history_id, equipment_id, change) FROM stdin;
Update 17.3.5	1	fruit_soul	Soul was revamped and renamed to Spirit.\n[Z] Soul Snatcher was renamed to [Z] Frostfire Grasp.\n[C] Outraged Raijin was renamed to [C] Wrath of Shu.
Update 17.3.5	2	fruit_soul	Spirit users now get buddies overtime instead of getting them from NPCs or Players.
Update 17.3	1	fruit_soul	Soul received a balancing.\nChanges on how Soul works:\nThe size of [X] Wrath of Ra now scales with the blue bar.\nThe damage of [C] Outraged Raijin now scales with the red bar.\nNerfed base stats of both moves.\nRebalanced dashes and run speed on all the races. The speed gap between Rabbit and other races shouldn't be that huge anymore.\nCharacter gravity now slowly increases the further away the user is from the ground, to avoid sky camping.
Update 17.2	1	fruit_soul	Soul was buffed.\nReduced cooldowns on [X] Wrath of Ra, [C] Outraged Raijin, [F] Sky Ruler, and summoning buddies.\n[X] Wrath of Ra and [C] Outraged Raijin now have the same cooldown duration.\n[Z] Soul Snatcher can now steal up to 2 souls (spirit/buddies) by hitting multiple enemies at once.\nSlightly increased the mood damage modifier on the [V] End of Times move.\nBuffed the damage and hitbox on [C] Outraged Raijin.
Update 17.2	2	fruit_soul	Soul was nerfed.\nThe damage of [X] Wrath of Ra was reduced.
Update 17.1	1	fruit_soul	Soul was released.
Update 26	1	fruit_barrier	Barrier was replaced by Creation.
Update 25	1	fruit_barrier	Barrier was made unavailable to purchase from the Blox Fruit Dealer's stock and Shop.
Update 20	1	fruit_barrier	Barrier Fruit's model was remade.
Update 8	1	fruit_barrier	Barrier was released.
Update 24	1	fruit_chop	Chop was replaced by Blade.
Update 20	2	fruit_chop	Chop Fruit's model was remade.
Update 1	1	fruit_chop	Chop was released.
Update 26	2	fruit_yeti	Yeti was nerfed.\nYeti's damage got reduced slightly.\nNerfed Z move range.\nThe X move can now be dodged by Instinct if the boulder directly hits in the air.\nNerfed C move range.\nNerfed defense buff to 35% instead of 50%.
Update 25	2	fruit_yeti	Yeti was released.\nYeti's damage was buffed.
Update 20	3	fruit_kilo	Kilo was replaced by Rocket.
Update 15	1	fruit_kilo	Kilo was released.
Update 21	1	fruit_revive	Revive was revamped and renamed to Ghost.
Update 20	4	fruit_revive	Revive Fruit's model was remade.
Update 16	1	fruit_revive	Revive was released.
Update 26	3	fruit_falcon	Falcon was replaced by Eagle.
Update 25	3	fruit_falcon	Falcon was made unavailable to purchase from the Blox Fruit Dealer's stock and Shop.
Update 20	5	fruit_falcon	Falcon Fruit's model was remade.
Update 19	1	fruit_falcon	Bird: Falcon was renamed to "Falcon".
Update 17.2	3	fruit_falcon	Increased passive defense from 7.5% to 10%. (This passive is currently not working.)
Update 15	2	fruit_falcon	Bird: Falcon was released.
Update 20	6	fruit_spirit	Spirit Fruit's model's icon was remade.
Update 17.3.5	3	fruit_spirit	Soul was revamped and renamed to Spirit.\n[Z] Soul Snatcher was renamed to [Z] Frostfire Grasp.\n[C] Outraged Raijin was renamed to [C] Wrath of Shu.
Update 17.3.5	4	fruit_spirit	Spirit users now get Buddies overtime instead of getting them from NPCs or Players.
Update 17.3	2	fruit_spirit	Soul received a balancing.\nChanges on how Soul works:\nThe size of [X] Wrath of Ra now scales with the blue bar.\nThe damage of [C] Outraged Raijin now scales with the red bar.\nNerfed base stats of both moves.\nRebalanced dashes and run speed on all the races. The speed gap between Rabbit and other races should not be that huge anymore.\nCharacter gravity now slowly increases the further away the user is from the ground, to avoid sky camping.
Update 17.2	4	fruit_spirit	Soul was buffed.\nReduced cooldowns on [X] Wrath of Ra, [C] Outraged Raijin, [F] Sky Ruler, and summoning buddies.\n[X] Wrath of Ra and [C] Outraged Raijin now have the same cooldown duration.\n[Z] Soul Snatcher can now steal up to 2 souls (spirit/buddies) by hitting multiple enemies at once.\nSlightly increased the mood damage modifier on the [V] End of Times move.\nBuffed the damage and hitbox on [C] Outraged Raijin.
Update 17.2	5	fruit_spirit	Soul was nerfed.\nThe damage of [X] Wrath of Ra was reduced.
Update 17.1	2	fruit_spirit	Soul was released.
Update 20	7	fruit_leopard	Leopard Fruit's model was remade.
Update 17.3	3	fruit_leopard	Leopard was released.
Update 20	8	fruit_venom	Venom Fruit's model's icon was remade.
Update 17.2	6	fruit_venom	Transformation now costs 20% of the user's Fury Meter.
Update 16	2	fruit_venom	Patched the infinite Fury Meter with Venom glitch.
Update 15	3	fruit_venom	Venom was released.
Update 20	9	fruit_shadow	Shadow Fruit's model was remade.
Update 16	3	fruit_shadow	Shadow was released.
Update 20	10	fruit_control	Control Fruit's model was remade.
Update 17.2	7	fruit_control	Control was buffed.\n[Z] Control Area now lasts longer.\nLowered cooldown on [X] Levitate and [F] Teleport.\nIncreased the damage of [V] Gamma Rush, and it no longer shrinks after catching a player, and doesn't disappear after the move.
Update 16	4	fruit_control	Control was buffed.\nIncreased the damage of [X] Levitate
Update 14	1	fruit_control	Control was buffed.\nIncreased the stun on [C] Echo Knife.\nSlightly increased damage on [V] Gamma Rush.
Update 11	1	fruit_control	Control was buffed.\nDecreased the end-lag on [C] Echo Knife.
Update 10	1	fruit_control	Control was released.
Update 17.3.5	5	fruit_door	Door was replaced by Portal.
Update 17.2	8	fruit_door	Added short immunity frames to the user while teleporting with [C] Door Gateway.
Update 15	4	fruit_door	Door was released.
Update 24	2	fruit_dough	Dough Fruit's icon was remade.
Update 20	11	fruit_dough	Dough Fruit's model was remade.
Update 19	2	fruit_dough	[C] Piercing Clothesline now needs to hit a player or an Enemy to activate.
Update 18	1	fruit_dough	[C] Piercing Clothesline\nAutomatically activates the skill even if it doesn't hit anyone.\nNow adjusts to the user's Aura color.
Update 18	2	fruit_dough	[X] Pastry River was nerfed. (Lost the auto aim ability and hit more targets)
Update 17.3	4	fruit_dough	Dough received an awakening.
Update 1	5	fruit_magma	Magma was released.
Update 11	2	fruit_dough	Dough received a slight buff.\nSlightly reduced the delay on [V] Restless Dough Barrage.\nSlightly increased the hitbox on [X] Sticky Dough and [C] Carved Dough.
Update 10	2	fruit_dough	Dough was nerfed.
Update 9	1	fruit_dough	Dough was released as a special Natural-type Blox Fruit.\nDough had Elemental Reflex passive but required the user to have Instinct on.
Update 23	1	fruit_mammoth	Mammoth's hitbox was broken for a brief amount of time, allowing users to stand in water and survive as the hitbox was just slightly above the water. This has been fixed in a later hotfix.
Update 20	12	fruit_mammoth	Mammoth was released.
Update 26	4	fruit_pain	2025-07-04:\nPain was made unavailable to purchase from the Blox Fruit Dealer's stock and Shop.
Update 20	13	fruit_pain	Paw was renamed to Pain.\n[Z] Heavy Paw was renamed to [Z] Heavy Pain.\n[X] Paw Barrage was renamed to [X] Pain Barrage.\n[C] Paw Nuke was renamed to [C] Pain Nuke.
Update 20	14	fruit_pain	Paw Fruit's model was remade.
Update 8	2	fruit_pain	Paw's visual was enhanced.
Update 7	1	fruit_pain	Paw was released.
Update 26	5	fruit_portal	Blur background visual for entering [C] World Warp was changed back to the former visuals.
Update 24	3	fruit_portal	Removed the ability to stay in [X] Parallel Escape while using M1s, as well as slightly decreasing the total time of the move.
Update 24	4	fruit_portal	Added a blur background visual when entering a portal formed by [C] World Warp.
Update 24	5	fruit_portal	Players now have to close the screen of fruit shop in order to use the GUI of [C] World Warp.
Update 24	6	fruit_portal	Portal's M1 can no longer be used when talking to an NPC.
Update 24	7	fruit_portal	Enemies now gain approximately 60 invincibility frames when being forced out of [V] Dimensional Rift, effectively removing its ability to infinite combo.
Update 21	2	fruit_portal	Slightly increased cooldown of [V] Dimensional Rift and [X] Parallel Escape.
Update 20	15	fruit_portal	Portal Fruit's model was remade.
Update 18	3	fruit_portal	Slightly increased cooldowns on Tap' (Click).
Update 17.3.5	6	fruit_portal	Door was reworked and was renamed to Portal.\n[Z] Spinning Door was renamed to [Z] Portal Dash.\n[X] Dimensional Door was renamed to [X] Parallel Escape.\n[C] Door Gateway was renamed to [C] World Warp.\nAdded [V] Dimensional Rift.\n[F] Hallway was renamed to [F] Quantum Leap.
Update 17.2	9	fruit_portal	Added short immunity frames to the user while teleporting with [C] Door Gateway.
Update 15	5	fruit_portal	Portal was released as Door.
Update 26	6	fruit_rumble	2025-07-18:\nRumble was made unavailable to purchase from the Blox Fruit Dealer's stock and Shop.
Update 24	8	fruit_rumble	Rumble's icon was remade.
Update 20	16	fruit_rumble	Rumble Fruit's model was remade.
Update 18	4	fruit_rumble	[V] Thunderball Destruction (V2) now fires faster and deals reduced knockback.
Update 17.2	10	fruit_rumble	Improved the visual effects on some Rumble V2 abilities.
Update 14	2	fruit_rumble	Rumble received an awakening.
Update 5	1	fruit_rumble	Rumble [V] and [F] moves were nerfed.
Update 3	1	fruit_rumble	Rumble was released.
Update 20	17	fruit_blizzard	Blizzard Fruit's model was remade.
Update 17.3.5	7	fruit_blizzard	Blizzard was released.
Update 20	18	fruit_phoenix	Phoenix Fruit's model was remade.
Update 19	3	fruit_phoenix	Renamed from "Bird: Phoenix" to "Phoenix".
Update 17.3	5	fruit_phoenix	All Unawakened moves were reworked.
Update 17.2	11	fruit_phoenix	Bird: Phoenix received an awakening.
Update 17.2	12	fruit_phoenix	The awakened version was severely nerfed.
Update 17.2	13	fruit_phoenix	[X] moves's heal in V1 form costs more energy to keep the recovery rate with V2.
Update 2	1	fruit_phoenix	Bird: Phoenix was released.
Update 20	19	fruit_spider	Spider Fruit's model was remade.
Update 19	4	fruit_spider	String was renamed to Spider.\n[Z] Rainbow String (V1) was renamed to "Spider Wraith".\n[F] String Path (V1) was renamed to "Spider Path".\n[F] God's Highway (V2) was renamed to "Spider Highway".
Update 19	5	fruit_spider	All moves were reworked (with the exception of awakened [X] and [Z]).
Update 17.2	14	fruit_spider	Greatly increased the auto-aim and speed on the C move unawakened.
Update 13	1	fruit_spider	String received an awakening.
Update 3	2	fruit_spider	String was released.
Update 26	7	fruit_creation	Barrier was reworked and renamed to Creation.\n[M1] ability was added.\n[Z] Barrier Wall was replaced by [Z] Batter Up.\n[X] Surprise Attack was replaced by [X] Sleight of Hand.\n[C] Barrier Prison was replaced by [C] Sword Box\n[V] Barrier Towers was enhanced to become [V] Magic City.\n[F] Stairs was enhanced to become [F] Fortify.
Update 26	8	fruit_creation	Creation's rarity was changed from Rare to Legendary.
Update 26	9	fruit_creation	Creation's price was increased:\n  800,000 ->   1,400,000\n  1,250 ->   1,750
Update 25	4	fruit_creation	Barrier was made unavailable to purchase from the Blox Fruit Dealer's stock and Shop. (Price in trading remains the same)
Update 20	20	fruit_creation	Barrier Fruit's model was remade.
Update 8	3	fruit_creation	Barrier was released.
Update 24	9	fruit_buddha	Buddha V1 received a slightly higher Air Jump (around 1.5x) compared to untransformed.
Update 24	10	fruit_buddha	Buddha icon was remade.
Update 20	21	fruit_buddha	Buddha Fruit's model was remade.
Update 19	6	fruit_buddha	Human: Buddha was renamed to "Buddha".
Update 19	7	fruit_buddha	Awakened Buddha's abilities damage were buffed.
Update 18	5	fruit_buddha	While transformed, the damage of swords' M1 was nerfed.\nHuman: Buddha users now deal 27.5% decreased M1 damage, only in PvP.
Update 17.3	6	fruit_buddha	[X] Impact (V1) was reworked.
Update 15	6	fruit_buddha	Human: Buddha received an awakening.
Update 1	2	fruit_buddha	Human: Buddha was released.
Update 26	10	fruit_gravity	Gravity was remade available to purchase.
Update 24	18	fruit_light	Light Icon was revamped.
Update 26	11	fruit_gravity	Gravity Fruit's model was slightly remade again.\nThe color of the fruit model became darker.\nThe pink ring now rotates around the fruit.
Update 26	12	fruit_gravity	Gravity Fruit's icon was remade.
Update 26	13	fruit_gravity	Added [M1] attacks.
Update 26	14	fruit_gravity	All moves were reworked.\n[Z] Gravity Push was renamed to [Z] Singularity.\n[X] Gravity Obeisance was renamed to [X] Orbital Chain.\n[C] Meteor Pitch was renamed to [C] Gravitational Prison.\n[V] Meteors Rain was renamed to [V] Asteroid Crash.\n[F] Boulder Flight was renamed to [F] Shooting Star.\nPrevious IconPrevious Inventory IconOld Gravity Fruit's model.Gravity Push (Old)Gravity Obeisance (Old)Meteor Pitch (Old)Meteors Rain (Old)Boulder Flight (Old)
Update 25	5	fruit_gravity	Gravity was made unavailable to purchase from the Blox Fruit Dealer's stock and Shop.
Update 20	22	fruit_gravity	Gravity Fruit's model was remade.
Update 17.3	7	fruit_gravity	Gravity was reworked.\nEvery ability got a VFX rework.\nOld: [V] Meteors Rain could not be aimed and used to hit randomly.\nNew: [V] Meteors Rain can be aimed.
Update 7	2	fruit_gravity	Made Gravity slightly more common.
Update 5	2	fruit_gravity	Gravity was released.
Update 24	11	fruit_love	Love was nerfed.\n[X] Cupid's Zone no longer has infinite range.
Update 21	3	fruit_love	Besto Friendo could jump, dash, and swim.\nAlso, it un-aggroed when you didn't have any tools selected.
Update 20	23	fruit_love	Love Fruit's model was remade.
Update 19	8	fruit_love	Love's price was increased.\nRare -> Legendary\n  700,000 ->   1,300,000\n  1,150 ->   1,700
Update 19	9	fruit_love	All moves were reworked.\n[Z] Mellowing Heart was renamed to [Z] Heart Shot.\n[X] Arrow of Imprisonment was renamed to [X] Cupid's Zone.\n[V] Scented Kicks was renamed to [V] Besto Friendo.
Update 15	7	fruit_love	Love was released as a Rare Blox Fruit.
Update 24	12	fruit_quake	Quake Icon was remade.
Update 20	24	fruit_quake	Quake Fruit's model was remade.
Update 17.3	8	fruit_quake	Unawakened Quake's moves were reworked.
Update 15	8	fruit_quake	Awakened [V]'s cooldown has been reduced.
Update 12	1	fruit_quake	Awakened Quake was nerfed.\nSlightly reduced damage.\nAdded some end-lag to [Z] Fatal Demolisher (V2).\n[X] Air Crusher and [C] Spatial Shockwave (V2) has a longer wind up.\nDecreased the hitbox and speed of [X] Air Crusher (V2).
Update 11	3	fruit_quake	Quake received an awakening.
Update 11	4	fruit_quake	Decreased the cooldown of [V] Dual Tsunami.
Update 3.5	1	fruit_quake	[X] Quake Wave now breaks instinct.
Update 2	2	fruit_quake	Increased cooldown, and decreased range.
Update 2	3	fruit_quake	Decreased the cooldown of [V] Dual Tsunami.
Update 1	3	fruit_quake	Quake was released.
Update 24	13	fruit_rubber	The animation of [V] Transformation was changed.
Update 20	25	fruit_rubber	Rubber Fruit's model was remade.
Update 17.3	9	fruit_rubber	Rubber was revamped.
Update 11	5	fruit_rubber	[V] Transformation was buffed.\nEnergy regeneration was decreased to 25% instead of 50%.
Update 8	4	fruit_rubber	Rubber was reworked and its visuals were enhanced.
Update 4	1	fruit_rubber	Aura now works properly on Rubber.
Update 3.5	2	fruit_rubber	Rubber was nerfed.\nRubber's 2nd Transformation's damage boost is now 22.5% instead of 25%.
Update 3	3	fruit_rubber	Rubber was buffed.\nAdded immunity to Electric fighting style and Rumble.
Update 3	4	fruit_rubber	Enlarged the Aura visual with Rubber.
Update 2	4	fruit_rubber	Rubber was reworked.
Update 1	4	fruit_rubber	Rubber was released.
Update 20	26	fruit_sand	Sand Fruit's model was remade.
Update 17.3	10	fruit_sand	Unawakened Sand was reworked.
Update 17.2	15	fruit_sand	Awakened Sand was nerfed.\nRe-balanced the general damage.\n[X] Sand coffin now stuns the user for 1.8s after a successful grab.
Update 17.2	16	fruit_sand	Fast Mode now reduces the particle on [Z] Desert Blade and [V] Deep Sand to reduce lag.
Update 17.1	3	fruit_sand	Sand received an awakening.
Update 4	2	fruit_sand	Sand was released.\nSand also received a slight buff after the release.\nBuffed the damage and the hitbox of [X] Desert Funeral.
Update 26	15	fruit_diamond	Diamond was nerfed.\n[Z] Encrust's defense was reduced from 25% to 23%.\n[X] Shard Storm's damage got slightly reduced.\n[C] Shimmering Disruption no longer stuns enemies.\n[V] Prismatic Reflection now can be dodged by Instinct and its AoE was reduced.
Update 24	14	fruit_diamond	Diamond's icon was remade.
Update 24	15	fruit_diamond	Added an [M1] attack.
Update 24	16	fruit_diamond	All moves were reworked.\n[X] Beaming Tackle was renamed to [X] Shard Storm.\n[C] Diamond Hail was renamed to [C] Shimmering Disruption.\n[V] Solar Flare was renamed to [V] Prismatic Reflection.
Update 20	27	fruit_diamond	Diamond Fruit's model was remade.
Update 17.2	17	fruit_diamond	Increased passive defense from 22.5% to 25%.
Update 15	9	fruit_diamond	Diamond was released.
Update 21	4	fruit_ghost	Revive was revamped and renamed to Ghost.\nGhost's rarity was changed from Uncommon to Rare.
Update 20	28	fruit_ghost	Revive Fruit's model was remade.
Update 16	5	fruit_ghost	Revive was released as an Uncommon Blox Fruit.
Update 24	17	fruit_magma	Magma's Icon was revamped.
Update 21	5	fruit_magma	Magma's money price was increased.\n  850,000 ->   960,000
Update 20	29	fruit_magma	Magma Fruit's model was remade.
Update 17.3	11	fruit_magma	All unawakened moves were reworked.
Update 17.2	18	fruit_magma	Awakened:\nUser can walk on water.\nThe Magma balls (big version of Scorching Puddles) deal way higher tick damage.\nSlightly buffed explosion damage on [Z].\nThe [C] move can ignore Instinct.
Update 16	6	fruit_magma	Reduced the range of the [Z] move Awakened.
Update 15	10	fruit_magma	Magma received an awakening.
Update 8	5	fruit_magma	Magma's visuals were reworked and/or enhanced.
Update 6	1	fruit_magma	Magma's [Z] and [C] have been reworked.
Update 6	2	fruit_magma	Magma's [V] was aimable.
Update 20	30	fruit_light	Light Fruit's model was remade.
Update 17.3.5	8	fruit_light	Light's sword was replaced by a spear.
Update 17.3	12	fruit_light	All moves were reworked.\nUnawakened:\n[Z] Light Beam was renamed to [Z] Light Ray.\n[X] Light Barrage was renamed to [X] Barrage of Light.\n[C] Light Kick was renamed to [C] Reflection Kick.
Update 17.2	19	fruit_light	[X] Swords of Judgement (V2) was buffed.\nThe range of the projectiles was increased.\nNow ignores Instinct.
Update 12	2	fruit_light	Light received an awakening.
Update 8	6	fruit_light	Light's visuals were reworked and/or enhanced.
Update 7	3	fruit_light	The speed of the flight move is now relative to the user's current health. (Example: 50% health = 50% speed; caps at 40% speed)
Update 6	3	fruit_light	Light's sword is no longer a move, but a passive click ability (M1), and a new [V] move have been made in place of it.
Update 2	5	fruit_light	Added Light's sword.
Update 1	6	fruit_light	Light was released.
Update 24	19	fruit_dark	Dark's icon was revamped.
Update 20	31	fruit_dark	Dark Fruit's model was revamped.
Update 17.2	20	fruit_dark	Dark was nerfed.\nThe hitbox of [X] Abyssal Darkness (V2) was reduced.
Update 12	3	fruit_dark	Dark received an awakening.
Update 1	7	fruit_dark	Dark was released.
Update 20	32	fruit_smoke	Smoke Fruit's model was remade.
Update 17.3	13	fruit_smoke	All Smoke's moves were reworked.\n[Z] Smoke Cloud was renamed to [Z] Smoke Slam.\n[X] Smoke Pull was renamed to [X] Smoke Blast.\n[C] Smoke Tackle was renamed to [C] Smoke Liberation.\n[F] Smoke Flight was renamed to [F] Smoke Bomber.
Update 1	8	fruit_smoke	Smoke was released.
Update 24	20	fruit_spike	Spike Fruit's icon was remade.
Update 20	33	fruit_spike	Spike Fruit's model was remade.
Update 17.3	14	fruit_spike	Spike's price was increased.\n  7,500 ->   180,000\n  75 ->   380
Update 17.3	15	fruit_spike	All moves were reworked and added new moves.\n[Z] Rush was renamed to [Z] Spike Summon.\n[X] Spiky Ball was renamed [X] Whirlwind and moved to [C] Spiky Ball.
Update 17.2	21	fruit_spike	Spike's moves cooldown was decreased.
Update 2	6	fruit_spike	Increased damage of the [X] Spiky Ball move.
Update 1	9	fruit_spike	Spike was released.
Update 20	34	fruit_spring	Spring Fruit's model was remade.
Update 17.3	16	fruit_spring	Added [V] Spring Emperor.
Update 2	7	fruit_spring	Spring was released.
Update 20	35	fruit_ice	Ice Fruit's model was remade.
Update 17.3	17	fruit_ice	The visuals of Ice's skills were revamped.\nIce's sword was replaced by a trident.
Update 17.2	22	fruit_ice	Ice was buffed.\nThe speed and stun of [C] Frozen Dragon (V2) were increased.\nThe stun time of [V] Absolute Zero (V2) was extended.
Update 17.2	23	fruit_ice	Ice was nerfed.\nThe ability to use [V] Absolute Zero in air was removed.
Update 11	6	fruit_ice	Ice received an awakening.
Update 6	4	fruit_ice	Added freezing water mechanic to [Z] Ice Spears.
Update 6	5	fruit_ice	[C] Ice Bird was remade.
Update 1	10	fruit_ice	Ice was released.
Update 20	36	fruit_bomb	Bomb Fruit's model was remade.
Update 17.3	18	fruit_bomb	Bomb's price was increased.\n  5,000 ->   80,000\n  60 ->   220
Update 17.3	19	fruit_bomb	All moves were reworked.\n[Z] Snipe was renamed to [Z] Targeted Bomb.\n[X] Ultimate Explosion was renamed to [X] Bomb Grab.
Update 17.2	24	fruit_bomb	Lowered cooldown on both Bomb and Spike.
Update 8	7	fruit_bomb	Reworked and/or Enhanced visuals of the Bomb move.
Update 1	11	fruit_bomb	Bomb was released.
Update 24	21	fruit_blade	Chop was reworked and renamed to Blade.\nAdded a [TAP] ability.\n[Z] Tackle was renamed to [Z] Razor Cyclone.\n[X] Dance was renamed to [X] Blade Dance.\n[C] Party was renamed to [C] Saw Shredder.\n[F] Helicopter was renamed to [F] Turbine Flight.
Update 20	37	fruit_blade	Chop Fruit's model was remade.
Update 1	12	fruit_blade	Chop was released.
Update 20	38	fruit_spin	Spin was reworked.\nChanged Spin's icon and reverted back to the old icon.
Update 20	39	fruit_spin	Spin Fruit's model was remade.
Update 17.3	20	fruit_spin	Spin's price was decreased.\n  180,000 ->   7,500\n  380 ->   75
Update 15	11	fruit_spin	Spin was released.
Update 26	16	fruit_dragon	Buffed the Fury Meter gain from landing skills on base or hybrid mode.
Update 26	17	fruit_dragon	Nerfed Dragon with the changes seen below:\nReduced the fury meter gain from landing skills on transformation.\nReduced transformed damage resistance from 60% to 53%.\nIncrease cooldowns for all moves (+0.5 seconds on each move).\nReduced damage of all moves (-5% on each move).\nSlightly decreased Western Dragon transformation's flight speed.
Update 24	22	fruit_dragon	Dragon was remade available to purchase.
Update 24	23	fruit_dragon	Dragon was reworked into two versions: Western and Eastern.\nAdded Dragon's Hybrid Form.\nAdded an M1 attack.\n[Z] Heatwave Beam was renamed to [Z] Heatwave Cannon.\n[X] Draconic Claw was renamed to [X] Infernal Pincer.\n[C] Fire Shower was renamed to [C] Scorching Downfall.\n[V] Transformation was renamed to [V] Imperial Evolution.\n[F] Dragon Flight was renamed to [F] Draconic Soar.
Update 23	2	fruit_dragon	Dragon was made unavailable to purchase from the Blox Fruit Dealer and Shop.\nIts price was changed to "IN PROGRESS".\nIt started getting reworked.
Update 20	40	fruit_dragon	Dragon Fruit's model icon was remade.
Update 17.3	21	fruit_dragon	[C] Fire Shower and [X] Dragonic Claw were reworked.\nFire Shower's hitbox was reduced.\nBoth of these abilities got a small VFX rework.
Update 13	2	fruit_dragon	Dragon was released.
Update 26	18	fruit_eagle	Falcon was reworked and renamed to Eagle.\n[TAP] Normal Attack was added.\n[Z] Plumage was replaced by [Z] Wind Burst.\n[X] Wind Burst was moved to the [Z] move and replaced by [X] Feather Storm.
Update 26	19	fruit_eagle	Eagle was made available to purchase.
Update 26	20	fruit_eagle	Eagle's price was increased.\n  300,000 ->   550,000\n  650 ->   975
Update 26	21	fruit_eagle	Eagle was given usable skins.
Update 1	33	gun_cannon	The Cannon was released.
Update 25	6	fruit_eagle	Falcon was made unavailable to purchase from the Blox Fruit Dealer's stock and Shop.
Update 20	41	fruit_eagle	Falcon Fruit's model was remade.
Update 19	10	fruit_eagle	"Bird: Falcon" was renamed to "Falcon".
Update 17.2	25	fruit_eagle	Increased passive defense from 7.5% to 10%. (This passive never worked.)
Update 15	12	fruit_eagle	Bird: Falcon was released.
Update 26	22	fruit_flame	Flame's Model got reworked.
Update 24	24	fruit_flame	Flame’s Icon was remade
Update 20	42	fruit_flame	Flame Fruit's model was remade.
Update 17.3.5	9	fruit_flame	[Z] Blue Fire Bullets (V2) was reworked.
Update 17.3.5	10	fruit_flame	Flame was buffed damage was added on all moves, [V] move received more consistent tick damage
Update 17.3	22	fruit_flame	Awakened and Unawakened Flame received a slight rework.
Update 17.2	26	fruit_flame	Awakened Flame was buffed slightly.\n[F] Rocket Flight now has a higher initial speed boost.\nIncreased the damage of [Z] Blue Fire Bullets. Additionally, it grows in size as it travels.
Update 11	7	fruit_flame	Flame received an awakening.
Update 8	8	fruit_flame	Flame's visual effect was enhanced.
Update 6	6	fruit_flame	[X] Burning Blast was remade.
Update 5	3	fruit_flame	Made some of Flame's moves cast faster.
Update 1	13	fruit_flame	Flame was released.
Update 24	25	fruit_kitsune	Transformed Kitsune's speed was severely nerfed, but then later got buffed to be slightly slower than its original speed.
Update 22	1	fruit_kitsune	Kitsune was released.
Update 20	43	fruit_rocket	Kilo was replaced by Rocket.
Update 15	13	fruit_rocket	Kilo was released.
Update 24	26	sword_shark_saw	Shark Saw's model was reworked.
Update 20	44	sword_shark_saw	Shark Saw's moves were reworked.
Update 1	14	sword_shark_saw	Shark Saw was released.
Update 20	45	sword_spikey_trident	The Spikey Trident's moves were revamped.
Update 17.2	27	sword_spikey_trident	The Spikey Trident was released.
Update 24	27	sword_dark_blade	Changed the visuals for the [X] ability.
Update 21	6	sword_dark_blade	The strength of Dark Blade's Upgrading was nerfed.\n10% -> 8% Damage Boost.
Update 20	46	sword_dark_blade	The Dark Blade was reworked.\nAdded new model.
Update 20	47	sword_dark_blade	Increased the damage and speed of [X] Dark Air Slash V2 when held.
Update 17.2	28	sword_dark_blade	Improved the visual effects on the Dark Blade's abilities.
Update 15	14	sword_dark_blade	Reduced end-lag on the [Z] One Thousand Slices ability.
Update 11	8	sword_dark_blade	The Dark Blade was re-imagined:\nNew model.\nNew and faster combat animations.\nAlternative abilities (V2-exclusive):\nHolding the [Z] One Thousand Slices ability for at least 0.25s will move the player forward.\nThe [X] Dark Air Slash ability can be charged for up to 0.4s for a slightly faster attack, and to break Instinct.
Update 9	2	sword_dark_blade	The Dark Blade was slightly buffed.
Update 8	9	sword_dark_blade	The Dark Blade's rarity was changed to Mythical.
Update 5	4	sword_dark_blade	The Dark Blade was slightly nerfed.\nThe [Z] One Thousand Slices + [X] Dark Air Slash combo is no longer inescapable.
Update 4	3	sword_dark_blade	Added the Dark Blade's V2.
Update 2	8	sword_dark_blade	The Dark Blade was nerfed.
Update 1	15	sword_dark_blade	The Dark Blade was released as a Legendary sword.
Update 24	28	sword_jitte	Jitte was replaced by Flail.
Update 20	48	sword_jitte	Jitte's moves were revamped.\n[Z] Smoke Barrage was renamed to [Z] Smoke Leopard.
Update 10	3	sword_jitte	Jitte was released.
Update 20	49	sword_control	Control Fruit's model was remade.
Update 17.2	29	sword_control	Control was buffed.\n[Z] Control Area now lasts longer.\nLowered cooldown on [X] Levitate and [F] Teleport.\nIncreased the damage of [V] Gamma Rush, and it no longer shrinks after catching a player, and doesn't disappear after the move.
Update 16	7	sword_control	Control was buffed.\nIncreased the damage of [X] Levitate
Update 14	3	sword_control	Control was buffed.\nIncreased the stun on [C] Echo Knife.\nSlightly increased damage on [V] Gamma Rush.
Update 11	9	sword_control	Control was buffed.\nDecreased the end-lag on [C] Echo Knife.
Update 10	4	sword_control	Control was released.
Update 24	29	sword_blade	Chop was reworked and renamed to Blade.\nAdded a [TAP] ability.\n[Z] Tackle was renamed to [Z] Razor Cyclone.\n[X] Dance was renamed to [X] Blade Dance.\n[C] Party was renamed to [C] Saw Shredder.\n[F] Helicopter was renamed to [F] Turbine Flight.
Update 20	50	sword_blade	Chop Fruit's model was remade.
Update 1	16	sword_blade	Chop was released.
Update 24	30	sword_buddha	Buddha V1 received a slightly higher Air Jump (around 1.5x) compared to untransformed.
Update 24	31	sword_buddha	Buddha icon was remade.
Update 20	51	sword_buddha	Buddha Fruit's model was remade.
Update 19	11	sword_buddha	Human: Buddha was renamed to "Buddha".
Update 19	12	sword_buddha	Awakened Buddha's abilities damage were buffed.
Update 18	6	sword_buddha	While transformed, the damage of swords' M1 was nerfed.\nHuman: Buddha users now deal 27.5% decreased M1 damage, only in PvP.
Update 17.3	23	sword_buddha	[X] Impact (V1) was reworked.
Update 15	15	sword_buddha	Human: Buddha received an awakening.
Update 1	17	sword_buddha	Human: Buddha was released.
Update 26	23	sword_true_triple_katana	The pull-back hitbox of [X] Dragon Hurricane was nerfed.
Update 26	24	sword_true_triple_katana	Instinct dodges no longer drain when moving out of the [X] move.
Update 24	32	sword_true_triple_katana	The pull-back hitbox of [X] Dragon Hurricane was slightly nerfed.
Update 24	33	sword_true_triple_katana	The True Triple Katana's model was revamped.\nOld True Triple Katana's Icon
Update 20	52	sword_true_triple_katana	The True Triple Katana's moves were revamped.
Update 11	10	sword_true_triple_katana	The True Triple Katana was changed:\nThe range on [Z] was reduced by ~15%.\nThe stun on [Z] was reduced by 0.2 seconds.\nThe damage on [X] was reduced.\nThe tornado hitbox on [X] was fixed and reduced (it now acted more like a cone rather than a big sphere). The end delay was also increased by 0.1s.
Update 9	3	sword_true_triple_katana	The True Triple Katana was released.
Update 20	53	sword_triple_dark_blade	The Triple Dark Blade's model and skills were revamped.
Update 20	54	sword_triple_dark_blade	Fixed Slayer Skin not applying on abilities.
Update 20	55	sword_triple_dark_blade	Added the Triple Dark Blade's Upgrading.
Update 14	4	sword_triple_dark_blade	The Triple Dark Blade has been nerfed.
Update 13	3	sword_triple_dark_blade	The Triple Dark Blade was silently added into the game.
Update 21	7	sword_hallow_scythe	Buffed Hallow Scythe's speed and damage.\n[X] move now breaks Instinct.
Update 21	8	sword_hallow_scythe	The effect of Hallow Scythe's Upgrading was nerfed.\n10% -> 8% Damage Boost
Update 16	8	sword_hallow_scythe	Hallow Scythe was released.
Update 24	34	sword_cursed_dual_katana	Cursed Dual Katana's model was reworked.
Update 18	7	sword_cursed_dual_katana	[X] Slayer of Goliath received a small visual change altering the spinning X that appears on the target's screen.
Update 17.3	24	sword_cursed_dual_katana	Cursed Dual Katana was released.
Update 24	35	sword_tushita	Tushita's model was revamped.
Update 20	56	sword_tushita	Tushita's abilities were revamped.
Update 15	16	sword_tushita	Tushita was released.
Update 24	36	sword_yama	Yama's model was revamped.
Update 20	57	sword_yama	Yama's moves were revamped.
Update 15	17	sword_yama	Yama was released.
Update 24	37	sword_saishi	Saddi was remodeled and renamed to Saishi.
Update 20	58	sword_saishi	Saddi's moves were reworked.
Update 8	10	sword_saishi	Saddi was released.
Update 24	38	sword_shizu	Shisui was remodeled and renamed to Shizu.
Update 20	59	sword_shizu	Shisui's moves were reworked.
Update 8	11	sword_shizu	Shisui was released.
Update 24	39	sword_rengoku	Rengoku's model was revamped.
Update 20	60	sword_rengoku	Rengoku's moves were reworked.
Update 20	61	sword_rengoku	Added burn damage to [Z] Demon Slayer.
Update 17.3	25	sword_rengoku	Rengoku's passive idle stance was revamped.
Update 13	4	sword_rengoku	Rengoku was released.
Update 24	40	sword_pole_2nd_form	The model of Pole (2nd Form) was revamped.
Update 20	62	sword_pole_2nd_form	The moves of Pole (2nd Form) were reworked.
Update 14	5	sword_pole_2nd_form	The Pole (2nd Form) was released.
Update 24	41	sword_saber	Saber's model was reworked.
Update 20	63	sword_saber	Saber's moves were reworked.
Update 1	18	sword_saber	Saber was released.
Update 24	42	sword_pole_1st_form	The Pole's model was revamped.
Update 20	64	sword_pole_1st_form	The Pole's moves were revamped.
Update 3	5	sword_pole_1st_form	The Pole was released.
Update 24	43	sword_oroshi	Wando was remodeled and renamed to Oroshi.
Update 20	65	sword_oroshi	Wando was reworked.\n[X] Scatter Shot was renamed to [X] Dragon Gust.
Update 8	12	sword_oroshi	Wando was released.
Update 24	44	sword_midnight_blade	Midnight Blade's model was revamped.
Update 20	66	sword_midnight_blade	Midnight Blade's moves were reworked.
Update 12	4	sword_midnight_blade	Midnight Blade was released.
Update 20	67	sword_koko	Koko's moves were reworked.
Update 17.2	30	sword_koko	Koko was buffed.\nNew: [X] Injection Shot can hit anywhere inside the user's Control Area.
Update 10	5	sword_koko	Koko was released.
Update 24	45	sword_dark_dagger	Dark Dagger's model was revamped.
Update 15	18	sword_dark_dagger	Dark Dagger was released.
Update 24	46	sword_bisento	Bisento's model was revamped.
Update 20	68	sword_bisento	Bisento's moves were revamped.
Update 17.2	31	sword_bisento	Bisento's animation was revamped.
Update 17.2	32	sword_bisento	Changed Bisento's price from   1,200,000 to   1,000,000.
Update 17.2	33	sword_bisento	Increased [X] Quake Sphere V2's hitbox.
Update 5	5	sword_bisento	Bisento was nerfed.
Update 3.5	3	sword_bisento	Bisento received a second version.
Update 3.5	4	sword_bisento	Made Bisento a bit bigger visually.
Update 2	9	sword_bisento	Bisento was nerfed.
Update 1	19	sword_bisento	Bisento was released.
Update 24	47	sword_buddy_sword	The [Z] and [X] startup animations were changed.
Update 17.1	4	sword_buddy_sword	Buddy Sword was released.
Update 24	48	sword_wardens_sword	Wardens Sword's model was reworked.
Update 20	69	sword_wardens_sword	Wardens Sword's moves were reworked.
Update 1	20	sword_wardens_sword	Wardens Sword was released.
Update 24	49	sword_trident	Trident's model was reworked.
Update 20	70	sword_trident	Trident's moves were reworked.
Update 3	6	sword_trident	Trident was released.
Update 24	50	sword_pipe	Pipe's model was reworked.
Update 20	71	sword_pipe	Pipe was reworked.
Update 1	21	sword_pipe	Pipe was released.
Update 24	51	sword_flail	Jitte was reworked and renamed to Flail.
Update 20	72	sword_flail	Jitte's moves were revamped.\n[Z] Smoke Barrage was renamed to [Z] Smoke Leopard.
Update 10	6	sword_flail	Jitte was released.
Update 24	52	sword_soul_cane	Soul Cane's model was reworked.
Update 20	73	sword_soul_cane	Soul Cane's moves were reworked.
Update 2	10	sword_soul_cane	Soul Cane was released.
Update 24	53	sword_gravity_blade	Gravity Cane was renamed to Gravity Blade and received a visual rework.
Update 20	74	sword_gravity_blade	Gravity Cane's moves were reworked.\n[Z] Gravity Push was renamed to [Z] Dimensional Grasp.\n[X] Meteor Barrage was renamed to [X] Lunar Blitz.
Update 8	13	sword_gravity_blade	Gravity Cane was released.
Update 24	54	sword_dual-headed_blade	Dual-Headed Blade's model was revamped.
Update 20	75	sword_dual-headed_blade	Dual-Headed Blade's moves were revamped.
Update 1	22	sword_dual-headed_blade	Dual-Headed Blade was released.
Update 24	55	sword_longsword	Longsword's model was reworked.
Update 20	76	sword_longsword	Longsword's moves were reworked.
Update 8	14	sword_longsword	Longsword was released.
Update 20	77	sword_triple_katana	Triple Katana was reworked.
Update 1	23	sword_triple_katana	Triple Katana was released.
Update 24	56	sword_iron_mace	Iron Mace's model was revamped.
Update 20	78	sword_iron_mace	Iron Mace's moves were revamped.
Update 1	24	sword_iron_mace	Iron Mace was released.
Update 20	79	sword_dual_katana	Dual Katana's moves were reworked.
Update 1	25	sword_dual_katana	Dual Katana was released.
Update 24	57	sword_twin_hooks	Twin Hooks' moves were revamped.
Update 15	19	sword_twin_hooks	Twin Hooks were released.
Update 20	80	sword_cutlass	The Cutlass's moves were reworked.
Update 17.1	5	sword_cutlass	The Cutlass's slash animation was reworked.
Update 1	26	sword_cutlass	The Cutlass was released.
Update 26	25	sword_dragon_trident	Dragon Trident was nerfed.\n[X] Water Dragon Shower AoE was greatly reduced.
Update 24	58	sword_dragon_trident	Dragon Trident's model was revamped.
Update 20	81	sword_dragon_trident	Dragon Trident's moves were reworked.\n[X] Water Dragon Prison was renamed to [X] Water Dragon Shower.\nOld [Z] Sea Dragon FuryOld [X] Water Dragon Prison
Update 14	6	sword_dragon_trident	Dragon Trident was released.
Update 20	82	sword_katana	The Katana's moves were reworked.
Update 17.1	6	sword_katana	The Katana's slash animation was reworked.
Update 1	27	sword_katana	The Katana was released.
Update 24	59	gun_acidum_rifle	The Acidum Rifle was revamped.
Update 24	60	gun_acidum_rifle	The Acidum Rifle M1 now has a shorter range.
Update 8	15	gun_acidum_rifle	The Acidum Rifle was released.
Update 24	61	gun_flintlock	The Flintlock was remodeled and reworked.\n[Z] Disabling Shot was renamed to [Z] Concentrated Shot.\n[X] Rapid Gun was renamed to [X] Marksman Fury.
Update 1	28	gun_flintlock	The Flintlock was released.
Update 24	62	gun_refined_musket	The Refined Musket was revamped and renamed to Magma Blaster.\n[Z] Dragon Bullet -> [Z] Scorching Burst\n[X] Bold Pistolero -> [X] Magmatic Pressure
Update 2	11	gun_refined_musket	The Refined Musket was released.
Update 24	63	gun_refined_flintlock	Refined Flintlock was revamped and renamed to Dual Flintlock.
Update 1	29	gun_refined_flintlock	Refined Flintlock was released.
Update 24	64	gun_bizarre_rifle	The Bizarre Rifle was revamped and renamed to Bizarre Revolver.
Update 12	5	gun_bizarre_rifle	The Bizarre Rifle was released.
Update 24	65	gun_rubber	The animation of [V] Transformation was changed.
Update 20	83	gun_rubber	Rubber Fruit's model was remade.
Update 17.3	26	gun_rubber	Rubber was revamped.
Update 11	11	gun_rubber	[V] Transformation was buffed.\nEnergy regeneration was decreased to 25% instead of 50%.
Update 8	16	gun_rubber	Rubber was reworked and its visuals were enhanced.
Update 4	4	gun_rubber	Aura now works properly on Rubber.
Update 3.5	5	gun_rubber	Rubber was nerfed.\nRubber's 2nd Transformation's damage boost is now 22.5% instead of 25%.
Update 3	7	gun_rubber	Rubber was buffed.\nAdded immunity to Electric fighting style and Rumble.
Update 3	8	gun_rubber	Enlarged the Aura visual with Rubber.
Update 2	12	gun_rubber	Rubber was reworked.
Update 1	30	gun_rubber	Rubber was released.
Update 24	66	gun_skull_guitar	The Soul Guitar's model was revamped and renamed to Skull Guitar.\nOld Soul Guitar's icon.
Update 21	9	gun_skull_guitar	The Soul Guitar no longer heals from ships.
Update 17.3	27	gun_skull_guitar	The Soul Guitar was released.
Update 24	67	gun_venom_bow	Serpent Bow was remodeled, revamped, and renamed to Venom Bow.\n[Z] Poisonous Blast was renamed to [Z] Venomous Spit.\n[X] Snake Bind was renamed to [X] Serpent Bite.
Update 15	20	gun_venom_bow	Serpent Bow was released.
Update 26	26	gun_dragonstorm	The effect of the Dragonstorm's Upgrading was increased.\n6% -> 8% Damage Boost.
Update 24	68	gun_dragonstorm	The Dragonstorm was released.\nThe Dragonstorm's range was later nerfed.
Update 24	69	gun_refined_slingshot	The Refined Slingshot was remodeled and reworked.\n[Z] Sticky Pellet -> [Z] Ink Swarm\n[X] Explosive Pellet -> [X] Cluster Bomb
Update 1	31	gun_refined_slingshot	The Refined Slingshot was released.
Update 24	70	gun_magma_blaster	Refined Musket was reworked and renamed to Magma Blaster.\n[Z] Dragon Bullet -> [Z] Scorching Burst\n[X] Bold Pistolero -> [X] Magmatic Pressure
Update 2	13	gun_magma_blaster	Refined Musket was released.
Update 24	71	gun_bazooka	The Bazooka was remodeled and reworked.\n[Z] Alpha Wave -> [Z] Heat Wave\n[X] Incendiary Ammo -> [X] Flaring Missiles
Update 2	14	gun_bazooka	The Bazooka was released.
Update 24	72	gun_kabucha	The Kabucha was revamped.\n[Z] Flying Fire Bird  was renamed to [Z] Blazing Phoenix.\n[X] Intense Wind was renamed to [X] Dragon Tempest.
Update 17.3	28	gun_kabucha	The VFX explosion of [Z] Flying Fire Bird was revamped.
Update 8	17	gun_kabucha	The Kabucha was released.
Update 24	73	gun_dual_flintlock	Refined Flintlock was remodeled, reworked, and renamed to Dual Flintlock.\n[Z] Disabling Shot was renamed to [Z] Splitting Beam.\n[X] Rapid Gun was renamed to [X] Bullet Storm.
Update 1	32	gun_dual_flintlock	Refined Flintlock was released.
Update 24	74	gun_cannon	The Cannon was remodeled and reworked.\n[Z] Alpha Wave -> [Z] Chain Detonation
Update 24	75	gun_musket	The Musket was remodeled and reworked.\n[Z] Dragon Bullet -> [Z] Draconic Bullet\n[X] Bold Pistolero -> [X] Torching Shot
Update 1	34	gun_musket	The Musket was released.
Update 24	76	gun_slingshot	Slingshot was remodeled and reworked.\n[Z] Sticky Pellet -> [Z] Ink Bomb\n[X] Explosive Pellet -> [X] Proximity Bomb
Update 1	35	gun_slingshot	Slingshot was released.
Update 24	77	gun_bizarre_revolver	Bizarre Rifle was revamped and renamed to Bizarre Revolver.\n[Z] Heat-seeking Shot was renamed to [Z] Space Bending Blast.\n[X] Hellfire Shower was renamed to [X] Dimensional Surge.
Update 12	6	gun_bizarre_revolver	Bizarre Rifle was released.
\.


--
-- TOC entry 4686 (class 2606 OID 18464)
-- Name: ability ability_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ability
    ADD CONSTRAINT ability_pkey PRIMARY KEY (equipment_id, ability_id);


--
-- TOC entry 4675 (class 2606 OID 18418)
-- Name: equipment equipment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.equipment
    ADD CONSTRAINT equipment_pkey PRIMARY KEY (equipment_id);


--
-- TOC entry 4679 (class 2606 OID 18432)
-- Name: fruit fruit_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fruit
    ADD CONSTRAINT fruit_pkey PRIMARY KEY (equipment_id);


--
-- TOC entry 4683 (class 2606 OID 18452)
-- Name: gun gun_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gun
    ADD CONSTRAINT gun_pkey PRIMARY KEY (equipment_id);


--
-- TOC entry 4677 (class 2606 OID 18425)
-- Name: stock_event stock_event_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stock_event
    ADD CONSTRAINT stock_event_pkey PRIMARY KEY (stock_event_id);


--
-- TOC entry 4693 (class 2606 OID 18493)
-- Name: stock_item stock_item_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stock_item
    ADD CONSTRAINT stock_item_pkey PRIMARY KEY (stock_event_id, stock_item_id);


--
-- TOC entry 4681 (class 2606 OID 18442)
-- Name: sword sword_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sword
    ADD CONSTRAINT sword_pkey PRIMARY KEY (equipment_id);


--
-- TOC entry 4689 (class 2606 OID 18476)
-- Name: update_item update_item_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.update_item
    ADD CONSTRAINT update_item_pkey PRIMARY KEY (update_id, change_history_id);


--
-- TOC entry 4673 (class 2606 OID 18411)
-- Name: update update_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.update
    ADD CONSTRAINT update_pkey PRIMARY KEY (update_id);


--
-- TOC entry 4684 (class 1259 OID 18504)
-- Name: ability_equipment_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ability_equipment_id_idx ON public.ability USING btree (equipment_id);


--
-- TOC entry 4691 (class 1259 OID 18507)
-- Name: stock_item_fruit_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX stock_item_fruit_id_idx ON public.stock_item USING btree (fruit_id);


--
-- TOC entry 4687 (class 1259 OID 18505)
-- Name: update_item_equipment_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX update_item_equipment_id_idx ON public.update_item USING btree (equipment_id);


--
-- TOC entry 4690 (class 1259 OID 18506)
-- Name: update_item_update_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX update_item_update_id_idx ON public.update_item USING btree (update_id);


--
-- TOC entry 4697 (class 2606 OID 18465)
-- Name: ability ability_equipment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ability
    ADD CONSTRAINT ability_equipment_id_fkey FOREIGN KEY (equipment_id) REFERENCES public.equipment(equipment_id) ON DELETE CASCADE;


--
-- TOC entry 4694 (class 2606 OID 18433)
-- Name: fruit fruit_equipment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fruit
    ADD CONSTRAINT fruit_equipment_id_fkey FOREIGN KEY (equipment_id) REFERENCES public.equipment(equipment_id) ON DELETE CASCADE;


--
-- TOC entry 4696 (class 2606 OID 18453)
-- Name: gun gun_equipment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gun
    ADD CONSTRAINT gun_equipment_id_fkey FOREIGN KEY (equipment_id) REFERENCES public.equipment(equipment_id) ON DELETE CASCADE;


--
-- TOC entry 4700 (class 2606 OID 18499)
-- Name: stock_item stock_item_fruit_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stock_item
    ADD CONSTRAINT stock_item_fruit_id_fkey FOREIGN KEY (fruit_id) REFERENCES public.fruit(equipment_id) ON DELETE CASCADE;


--
-- TOC entry 4701 (class 2606 OID 18494)
-- Name: stock_item stock_item_stock_event_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stock_item
    ADD CONSTRAINT stock_item_stock_event_id_fkey FOREIGN KEY (stock_event_id) REFERENCES public.stock_event(stock_event_id) ON DELETE CASCADE;


--
-- TOC entry 4695 (class 2606 OID 18443)
-- Name: sword sword_equipment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sword
    ADD CONSTRAINT sword_equipment_id_fkey FOREIGN KEY (equipment_id) REFERENCES public.equipment(equipment_id) ON DELETE CASCADE;


--
-- TOC entry 4698 (class 2606 OID 18482)
-- Name: update_item update_item_equipment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.update_item
    ADD CONSTRAINT update_item_equipment_id_fkey FOREIGN KEY (equipment_id) REFERENCES public.equipment(equipment_id) ON DELETE CASCADE;


--
-- TOC entry 4699 (class 2606 OID 18477)
-- Name: update_item update_item_update_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.update_item
    ADD CONSTRAINT update_item_update_id_fkey FOREIGN KEY (update_id) REFERENCES public.update(update_id) ON DELETE CASCADE;


-- Completed on 2025-08-08 20:24:34

--
-- PostgreSQL database dump complete
--

