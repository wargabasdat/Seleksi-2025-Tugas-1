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
-- Name: active_theatre; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.active_theatre (
    theatre_name character varying(200) NOT NULL,
    capacity integer
);


ALTER TABLE public.active_theatre OWNER TO postgres;

--
-- Name: architect; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.architect (
    id integer NOT NULL,
    name character varying(200) NOT NULL
);


ALTER TABLE public.architect OWNER TO postgres;

--
-- Name: broadway_show; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.broadway_show (
    title character varying(300) NOT NULL,
    composer character varying(200),
    writer character varying(200),
    lyricist character varying(200),
    show_type character varying(50)
);


ALTER TABLE public.broadway_show OWNER TO postgres;

--
-- Name: design_work; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.design_work (
    architect_id integer NOT NULL,
    theatre_name character varying(200) NOT NULL
);


ALTER TABLE public.design_work OWNER TO postgres;

--
-- Name: former_existing_theatre; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.former_existing_theatre (
    theatre_name character varying(200) NOT NULL,
    last_opened integer,
    current_use character varying(200)
);


ALTER TABLE public.former_existing_theatre OWNER TO postgres;

--
-- Name: organization; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.organization (
    company_name character varying(200) NOT NULL,
    company_type character varying(100)
);


ALTER TABLE public.organization OWNER TO postgres;

--
-- Name: production; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.production (
    show_title character varying(300) NOT NULL,
    theatre_name character varying(200) NOT NULL,
    opening_year integer NOT NULL
);


ALTER TABLE public.production OWNER TO postgres;

--
-- Name: theatre; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.theatre (
    theatre_name character varying(200) NOT NULL,
    address character varying(300),
    opening_year integer,
    company_name character varying(200)
);


ALTER TABLE public.theatre OWNER TO postgres;

--
-- Data for Name: active_theatre; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.active_theatre (theatre_name, capacity) FROM stdin;
Al Hirschfeld Theatre	1424
Ambassador Theatre (Broadway)	1125
August Wilson Theatre	1228
Belasco Theatre (Broadway)	1018
Bernard B. Jacobs Theatre	1078
Booth Theatre	766
Broadhurst Theatre	1186
Broadway Theatre (53rd Street)	1761
Circle in the Square Theatre	840
Ethel Barrymore Theatre	1096
Eugene O'Neill Theatre	1066
Gerald Schoenfeld Theatre	1079
Gershwin Theatre	1933
Hayes Theater	597
Hudson Theatre	975
Imperial Theatre	1443
James Earl Jones Theatre	1084
John Golden Theatre	805
Lena Horne Theatre	1094
Longacre Theatre	1091
Lunt-Fontanne Theatre	1519
Lyceum Theatre (Broadway)	922
Lyric Theatre (New York City, 1998)	1622
Majestic Theatre (Broadway)	1645
Marquis Theatre	1612
Minskoff Theatre	1710
Music Box Theatre	1009
Nederlander Theatre	1235
Neil Simon Theatre	1467
New Amsterdam Theatre	1747
Palace Theatre (New York City)	1743
Richard Rodgers Theatre	1400
Samuel J. Friedman Theatre	650
Shubert Theatre (Broadway)	1460
Stephen Sondheim Theatre	1055
St. James Theatre	1709
Studio 54	1006
Todd Haimes Theatre	740
Vivian Beaumont Theater	1080
Walter Kerr Theatre	945
Winter Garden Theatre	1526
\.


--
-- Data for Name: architect; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.architect (id, name) FROM stdin;
1	G. Albert Lansburgh
2	Albert Herter
3	Herbert J. Krapp
4	C. Howard Crane
5	Kenneth Franzheim
6	George Keister
7	Henry Beaumont Herts
8	Eugene De Rosa
9	Alan Sayles
10	Jules Fisher (consultant)
11	Ralph Alswang
12	Harry Creighton Ingalls
13	J.B. McElfatrick & Son
14	Thomas W. Lamb
15	Carrère and Hastings
16	Herts & Tallant
17	Richard Blinder
18	Beyer Blinder Belle
19	John C. Portman Jr.
20	Kahn and Jacobs
21	William Neil Smith
22	Kirchhoff & Rose
23	Warren and Wetmore
24	Eero Saarinen
25	Jo Mielziner
26	William Albert Swasey
27	Paul R
\.


--
-- Data for Name: broadway_show; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.broadway_show (title, composer, writer, lyricist, show_type) FROM stdin;
Wonderful Town	\N	\N	\N	\N
Sweet Charity	\N	\N	\N	\N
The Wedding Singer	\N	\N	\N	\N
Curtains	\N	\N	\N	\N
A Tale of Two Cities	\N	\N	\N	\N
Hair	\N	\N	\N	\N
Elf the Musical	\N	\N	\N	\N
How to Succeed in Business Without Really Trying	\N	\N	\N	\N
Fela!	\N	\N	\N	\N
Kinky Boots	\N	\N	\N	\N
Moulin Rouge!	\N	\N	\N	\N
Blossom Time	\N	\N	\N	\N
The Dream Girl	\N	\N	\N	\N
Candida	\N	\N	\N	\N
The Student Prince	\N	\N	\N	\N
The Great Gatsby	\N	\N	\N	\N
The Racket	\N	\N	\N	\N
The Outsider	\N	\N	\N	\N
Redemption	\N	\N	\N	\N
Little Accident	\N	\N	\N	\N
Street Scene	\N	\N	\N	\N
The Last Mile	\N	\N	\N	\N
Six Shakespeare plays	\N	\N	\N	\N
Death Takes a Holiday	\N	\N	\N	\N
Young Sinners	\N	\N	\N	\N
June Moon	\N	\N	\N	\N
Biography	\N	\N	\N	\N
Night of January 16th	\N	\N	\N	\N
Mulatto	\N	\N	\N	\N
EightAbbey Theatreplays	\N	\N	\N	\N
You Can't Take It with You	\N	\N	\N	\N
The Straw Hat Revue	\N	\N	\N	\N
TenGilbert and Sullivanplays	\N	\N	\N	\N
The Diary of Anne Frank	\N	\N	\N	\N
Compulsion	\N	\N	\N	\N
Back to Methuselah	\N	\N	\N	\N
The 49th Cousin	\N	\N	\N	\N
The Tenth Man	\N	\N	\N	\N
Blood, Sweat and Stanley Poole	\N	\N	\N	\N
Something About a Soldier	\N	\N	\N	\N
A Passage to India	\N	\N	\N	\N
Stop the World - I Want to Get Off	\N	\N	\N	\N
The World of Charles Aznavour	\N	\N	\N	\N
The Lion in Winter	\N	\N	\N	\N
The Investigation	\N	\N	\N	\N
You Know I Can't Hear You When the Water's Running	\N	\N	\N	\N
We Bombed in New Haven	\N	\N	\N	\N
Celebration	\N	\N	\N	\N
The Boy Friend	\N	\N	\N	\N
Paul Sills' Story Theatre	\N	\N	\N	\N
Ain't Supposed to Die a Natural Death	\N	\N	\N	\N
Warp!	\N	\N	\N	\N
Scapino	\N	\N	\N	\N
We Interrupt This Program...	\N	\N	\N	\N
Me and Bessie	\N	\N	\N	\N
Des Journees Entières Dans les Arbres	\N	\N	\N	\N
Godspell	\N	\N	\N	\N
Miss Margarida's Way	\N	\N	\N	\N
Same Time, Next Year	\N	\N	\N	\N
Eubie!	\N	\N	\N	\N
Your Arms Too Short to Box with God	\N	\N	\N	\N
Dancin'	\N	\N	\N	\N
Herman Van Veen: All of Him	\N	\N	\N	\N
A View from the Bridge	\N	\N	\N	\N
Leader of the Pack	\N	\N	\N	\N
Barbara Cook: A Concert for the Theatre	\N	\N	\N	\N
Dreamgirls	\N	\N	\N	\N
Ain't Misbehavin'	\N	\N	\N	\N
The Circle	\N	\N	\N	\N
Fool Moon	\N	\N	\N	\N
Bring in 'da Noise, Bring in 'da Funk	\N	\N	\N	\N
You're a Good Man, Charlie Brown	\N	\N	\N	\N
It Ain't Nothin' But the Blues	\N	\N	\N	\N
The Ride Down Mt. Morgan	\N	\N	\N	\N
A Class Act	\N	\N	\N	\N
Hedda Gabler	\N	\N	\N	\N
Topdog/Underdog	\N	\N	\N	\N
Chicago	\N	\N	\N	\N
Alice in Wonderland	\N	\N	\N	\N
On Your Toes	\N	\N	\N	\N
Execution of Justice	\N	\N	\N	\N
Wild Honey	\N	\N	\N	\N
The Mikado	\N	\N	\N	\N
Carrie	\N	\N	\N	\N
Run for Your Wife	\N	\N	\N	\N
Shenandoah	\N	\N	\N	\N
City of Angels	\N	\N	\N	\N
Jelly's Last Jam	\N	\N	\N	\N
My Fair Lady	\N	\N	\N	\N
Smokey Joe's Cafe	\N	\N	\N	\N
The Wild Party	\N	\N	\N	\N
Gore Vidal's The Best Man	\N	\N	\N	\N
King Hedley II	\N	\N	\N	\N
The Crucible	\N	\N	\N	\N
Flower Drum Song	\N	\N	\N	\N
Bill Maher: Victory Begins At Home	\N	\N	\N	\N
Little Shop of Horrors	\N	\N	\N	\N
Little Women	\N	\N	\N	\N
A Grand Army Man	\N	\N	\N	\N
The Warrens of Virginia	\N	\N	\N	\N
Just a Wife	\N	\N	\N	\N
The Concert	\N	\N	\N	\N
Seven Chances	\N	\N	\N	\N
Polly With a Past	\N	\N	\N	\N
Deburau	\N	\N	\N	\N
Lulu Belle	\N	\N	\N	\N
Hit the Deck	\N	\N	\N	\N
The Truth About Blayds	\N	\N	\N	\N
Criminal at Large	\N	\N	\N	\N
Awake and Sing!	\N	\N	\N	\N
Waiting for Lefty	\N	\N	\N	\N
Dead End	\N	\N	\N	\N
Golden Boy	\N	\N	\N	\N
Rocket to the Moon	\N	\N	\N	\N
Johnny Belinda	\N	\N	\N	\N
The Man with Blond Hair	\N	\N	\N	\N
Clash by Night	\N	\N	\N	\N
Nathan the Wise	\N	\N	\N	\N
MagicandHello Out There!	\N	\N	\N	\N
Dark Eyes	\N	\N	\N	\N
Kiss Them for Me	\N	\N	\N	\N
Home of the Brave	\N	\N	\N	\N
Truckline Cafe	\N	\N	\N	\N
Lysistrata	\N	\N	\N	\N
Sundown Beach	\N	\N	\N	\N
Me and Molly	\N	\N	\N	\N
The Madwoman of Chaillot	\N	\N	\N	\N
The Flowering Peach	\N	\N	\N	\N
Will Success Spoil Rock Hunter?	\N	\N	\N	\N
Fanny	\N	\N	\N	\N
The First Gentleman	\N	\N	\N	\N
Nude With Violin	\N	\N	\N	\N
Present Laughter	\N	\N	\N	\N
A Raisin in the Sun	\N	\N	\N	\N
All the Way Home	\N	\N	\N	\N
Write Me a Murder	\N	\N	\N	\N
The Seagull	\N	\N	\N	\N
Inadmissible Evidence	\N	\N	\N	\N
The Subject Was Roses	\N	\N	\N	\N
The Killing of Sister George	\N	\N	\N	\N
Dr. Cook's Garden	\N	\N	\N	\N
Don't Drink the Water	\N	\N	\N	\N
Does a Tiger Wear a Necktie?	\N	\N	\N	\N
Oh! Calcutta!	\N	\N	\N	\N
American Buffalo	\N	\N	\N	\N
The Goodbye People	\N	\N	\N	\N
Marcel MarceauOn Broadway	\N	\N	\N	\N
Accidental Death of an Anarchist	\N	\N	\N	\N
Romeo and Juliet	\N	\N	\N	\N
As You Like It	\N	\N	\N	\N
Macbeth	\N	\N	\N	\N
The Speed of Darkness	\N	\N	\N	\N
The Master Builder	\N	\N	\N	\N
Hamlet	\N	\N	\N	\N
A Doll's House	\N	\N	\N	\N
Honour	\N	\N	\N	\N
Ring Round the Moon	\N	\N	\N	\N
James Joyce's The Dead	\N	\N	\N	\N
Follies	\N	\N	\N	\N
Frankie and Johnny in the Clair de Lune	\N	\N	\N	\N
Enchanted April	\N	\N	\N	\N
Dracula, the Musical	\N	\N	\N	\N
Julius Caesar	\N	\N	\N	\N
Journey's End	\N	\N	\N	\N
Dude	\N	\N	\N	\N
Passing Strange	\N	\N	\N	\N
Joe Turner's Come and Gone	\N	\N	\N	\N
Women on the Verge of a Nervous Breakdown	\N	\N	\N	\N
Kathy Griffin Wants a Tony	\N	\N	\N	\N
End of the Rainbow	\N	\N	\N	\N
Twelfth NightandRichard III	\N	\N	\N	\N
Hedwig and the Angry Inch	\N	\N	\N	\N
Blackbird	\N	\N	\N	\N
The Glass Menagerie	\N	\N	\N	\N
Michael Moore: The Terms of My Surrender	\N	\N	\N	\N
Farinelli and the King	\N	\N	\N	\N
Gettin' the Band Back Together	\N	\N	\N	\N
Network	\N	\N	\N	\N
Girl from the North Country	\N	\N	\N	\N
Ain't No Mo'	\N	\N	\N	\N
Good Night, Oscar	\N	\N	\N	\N
How to Dance in Ohio	\N	\N	\N	\N
Appropriate	\N	\N	\N	\N
Maybe Happy Ending	\N	\N	\N	\N
Three Days of Rain	\N	\N	\N	\N
Martin Short: Fame Becomes Me	\N	\N	\N	\N
Frost/Nixon	\N	\N	\N	\N
Rock 'n' Roll	\N	\N	\N	\N
The Country Girl	\N	\N	\N	\N
13	\N	\N	\N	\N
God of Carnage	\N	\N	\N	\N
Bloody Bloody Andrew Jackson	\N	\N	\N	\N
That Championship Season	\N	\N	\N	\N
The Mountaintop	\N	\N	\N	\N
Once	\N	\N	\N	\N
It's Only a Play	\N	\N	\N	\N
The Color Purple	\N	\N	\N	\N
Bandstand	\N	\N	\N	\N
The Iceman Cometh	\N	\N	\N	\N
'The Ferryman	\N	\N	\N	\N
Betrayal	\N	\N	\N	\N
Company	\N	\N	\N	\N
Almost Famous	\N	\N	\N	\N
Parade	\N	\N	\N	\N
The Outsiders	\N	\N	\N	\N
The Great Adventure	\N	\N	\N	\N
Our American Cousin	\N	\N	\N	\N
David Garrick	\N	\N	\N	\N
The Co-Respondent	\N	\N	\N	\N
Getting Married	\N	\N	\N	\N
A Successful Calamity	\N	\N	\N	\N
The Woman in Room 13	\N	\N	\N	\N
The Better 'Ole	\N	\N	\N	\N
Too Many Husbands	\N	\N	\N	\N
The Purple Mask	\N	\N	\N	\N
The Prince and the Pauper	\N	\N	\N	\N
The Green Goddess	\N	\N	\N	\N
Seventh Heaven	\N	\N	\N	\N
Dancing Mothers	\N	\N	\N	\N
Paolo and Francesca	\N	\N	\N	\N
The Fall of Eve	\N	\N	\N	\N
John Gabriel Borkman	\N	\N	\N	\N
Escape	\N	\N	\N	\N
Uncle Vanya	\N	\N	\N	\N
The Man in Possession	\N	\N	\N	\N
The Bread-Winner	\N	\N	\N	\N
After All	\N	\N	\N	\N
If Love Were All	\N	\N	\N	\N
Jewel Robbery	\N	\N	\N	\N
Another Language	\N	\N	\N	\N
For Services Rendered	\N	\N	\N	\N
Candide	\N	\N	\N	\N
No More Ladies	\N	\N	\N	\N
The Shining Hour	\N	\N	\N	\N
The Distaff Side	\N	\N	\N	\N
Laburnum Grove	\N	\N	\N	\N
Kind Lady	\N	\N	\N	\N
Lady Precious Stream	\N	\N	\N	\N
Swing Your Lady	\N	\N	\N	\N
The Time of Your Life	\N	\N	\N	\N
The Cream in the Well	\N	\N	\N	\N
Claudia	\N	\N	\N	\N
Blithe Spirit	\N	\N	\N	\N
The Two Mrs. Carrolls	\N	\N	\N	\N
The Would-Be Gentleman	\N	\N	\N	\N
He Who Gets Slapped	\N	\N	\N	\N
Playboy of the Western World	\N	\N	\N	\N
John Loves Mary	\N	\N	\N	\N
Tenting Tonight	\N	\N	\N	\N
Portrait in Black	\N	\N	\N	\N
Duet for Two Hands	\N	\N	\N	\N
An Inspector Calls	\N	\N	\N	\N
The Play's the Thing	\N	\N	\N	\N
The Shop at Sly Corner	\N	\N	\N	\N
Richard III	\N	\N	\N	\N
At War with the Army	\N	\N	\N	\N
Come Back, Little Sheba	\N	\N	\N	\N
Lace on Her Petticoat	\N	\N	\N	\N
An Evening With Beatrice Lillie	\N	\N	\N	\N
Late Love	\N	\N	\N	\N
Dial M for Murder	\N	\N	\N	\N
All Summer Long	\N	\N	\N	\N
The Matchmaker	\N	\N	\N	\N
Visit to a Small Planet	\N	\N	\N	\N
Two for the Seesaw	\N	\N	\N	\N
A Shot in the Dark	\N	\N	\N	\N
Rattle of a Simple Man	\N	\N	\N	\N
Spoon River Anthology	\N	\N	\N	\N
Luv	\N	\N	\N	\N
At the Drop of Another Hat	\N	\N	\N	\N
The Birthday Party	\N	\N	\N	\N
Avanti!	\N	\N	\N	\N
Leonard Sillman's New Faces of 1968	\N	\N	\N	\N
Butterflies Are Free	\N	\N	\N	\N
Bad Habits	\N	\N	\N	\N
Brief Lives	\N	\N	\N	\N
Very Good Eddie	\N	\N	\N	\N
For Colored Girls Who Have Considered Suicide / When the Rainbow Is Enuf	\N	\N	\N	\N
Monteith and Rand	\N	\N	\N	\N
The Elephant Man	\N	\N	\N	\N
An Evening with Dave Allen	\N	\N	\N	\N
Mass Appeal	\N	\N	\N	\N
Good	\N	\N	\N	\N
Sunday in the Park with George	\N	\N	\N	\N
I'm Not Rappaport	\N	\N	\N	\N
A Walk in the Woods	\N	\N	\N	\N
Michael Feinstein in Concert: "Isn't It Romantic"	\N	\N	\N	\N
Shirley Valentine	\N	\N	\N	\N
Tru	\N	\N	\N	\N
Once on This Island	\N	\N	\N	\N
The Most Happy Fella	\N	\N	\N	\N
Someone Who'll Watch Over Me	\N	\N	\N	\N
The Twilight of the Golds	\N	\N	\N	\N
Broken Glass	\N	\N	\N	\N
A Tuna Christmas	\N	\N	\N	\N
Having Our Say	\N	\N	\N	\N
The Old Neighborhood	\N	\N	\N	\N
An Evening with Jerry Herman	\N	\N	\N	\N
I'm Still Here... Damn It!	\N	\N	\N	\N
Via Dolorosa	\N	\N	\N	\N
The Search for Signs of Intelligent Life in the Universe	\N	\N	\N	\N
Bea Arthur on Broadway	\N	\N	\N	\N
Our Town	\N	\N	\N	\N
The Retreat from Moscow	\N	\N	\N	\N
The Pillowman	\N	\N	\N	\N
Seascape	\N	\N	\N	\N
Faith Healer	\N	\N	\N	\N
Butley	\N	\N	\N	\N
The Year of Magical Thinking	\N	\N	\N	\N
The Seafarer	\N	\N	\N	\N
Thurgood	\N	\N	\N	\N
Dividing the Estate	\N	\N	\N	\N
The Story of My Life	\N	\N	\N	\N
Next to Normal	\N	\N	\N	\N
High	\N	\N	\N	\N
Other Desert Cities	\N	\N	\N	\N
Who's Afraid of Virginia Woolf?	\N	\N	\N	\N
I'll Eat You Last: A Chat with Sue Mengers	\N	\N	\N	\N
Hand to God	\N	\N	\N	\N
Hughie	\N	\N	\N	\N
An Act of God	\N	\N	\N	\N
Les Liaisons Dangereuses	\N	\N	\N	\N
Significant Other	\N	\N	\N	\N
The Boys in the Band	\N	\N	\N	\N
Gary: A Sequel to Titus Andronicus	\N	\N	\N	\N
Freestyle Love Supreme	\N	\N	\N	\N
Kimberly Akimbo	\N	\N	\N	\N
The Roommate	\N	\N	\N	\N
John Proctor is the Villain	\N	\N	\N	\N
Little Bear Ridge Road	\N	\N	\N	\N
Misalliance	\N	\N	\N	\N
Lord and Lady Algy	\N	\N	\N	\N
Maytime	\N	\N	\N	\N
Ladies First	\N	\N	\N	\N
The Melting of Molly	\N	\N	\N	\N
39 East	\N	\N	\N	\N
Smilin' Through	\N	\N	\N	\N
The Servant in the House	\N	\N	\N	\N
Tarzan of the Apes	\N	\N	\N	\N
The Faithful Heart	\N	\N	\N	\N
The Dancers	\N	\N	\N	\N
Beggar on Horseback	\N	\N	\N	\N
The Green Hat	\N	\N	\N	\N
Broadway	\N	\N	\N	\N
The Merchant of Venice	\N	\N	\N	\N
Here's Howe	\N	\N	\N	\N
Hold Everything!	\N	\N	\N	\N
America's Sweetheart	\N	\N	\N	\N
The Animal Kingdom	\N	\N	\N	\N
The Man Who Reclaimed His Head	\N	\N	\N	\N
Twentieth Century	\N	\N	\N	\N
Men in White	\N	\N	\N	\N
L'Aiglon	\N	\N	\N	\N
The Petrified Forest	\N	\N	\N	\N
Victoria Regina	\N	\N	\N	\N
Madame Bovary	\N	\N	\N	\N
The Fabulous Invalid	\N	\N	\N	\N
Dear Octopus	\N	\N	\N	\N
Night Music	\N	\N	\N	\N
Keep Off the Grass	\N	\N	\N	\N
Old Acquaintance	\N	\N	\N	\N
Ten Little Indians	\N	\N	\N	\N
Lady in Danger	\N	\N	\N	\N
Follow the Girls	\N	\N	\N	\N
Happy Birthday	\N	\N	\N	\N
Make Mine Manhattan	\N	\N	\N	\N
Lend an Ear	\N	\N	\N	\N
The Liar	\N	\N	\N	\N
Detective Story	\N	\N	\N	\N
Burning Bright	\N	\N	\N	\N
An Enemy of the People	\N	\N	\N	\N
Flahooley	\N	\N	\N	\N
Seventeen	\N	\N	\N	\N
Pal Joey	\N	\N	\N	\N
The Love of Four Colonels	\N	\N	\N	\N
Auntie Mame	\N	\N	\N	\N
The World of Suzie Wong	\N	\N	\N	\N
Fiorello!	\N	\N	\N	\N
Sail Away	\N	\N	\N	\N
Bravo Giovanni	\N	\N	\N	\N
No Strings	\N	\N	\N	\N
110 in the Shade	\N	\N	\N	\N
Oh, What a Lovely War!	\N	\N	\N	\N
Kelly	\N	\N	\N	\N
Half a Sixpence	\N	\N	\N	\N
Cabaret	\N	\N	\N	\N
More Stately Mansions	\N	\N	\N	\N
Weekend	\N	\N	\N	\N
The Only Game in Town	\N	\N	\N	\N
The Fig Leaves Are Falling	\N	\N	\N	\N
Play It Again, Sam	\N	\N	\N	\N
Cry For Us All	\N	\N	\N	\N
Private Lives	\N	\N	\N	\N
Four on a Garden	\N	\N	\N	\N
70, Girls, 70	\N	\N	\N	\N
Twigs	\N	\N	\N	\N
Vivat! Vivat Regina!	\N	\N	\N	\N
Grease	\N	\N	\N	\N
The Sunshine Boys	\N	\N	\N	\N
Rachael Lily Rosenbloom and Don't You Ever Forget It	\N	\N	\N	\N
Thieves	\N	\N	\N	\N
Sherlock Holmes	\N	\N	\N	\N
A Matter of Gravity	\N	\N	\N	\N
The Heiress	\N	\N	\N	\N
A Texas Trilogy	\N	\N	\N	\N
Sly Fox	\N	\N	\N	\N
Amadeus	\N	\N	\N	\N
The Tap Dance Kid	\N	\N	\N	\N
Death of a Salesman	\N	\N	\N	\N
The Odd Couple	\N	\N	\N	\N
Long Day's Journey into Night	\N	\N	\N	\N
The Life and Adventures of Nicholas Nickleby	\N	\N	\N	\N
Broadway Bound	\N	\N	\N	\N
Rumors	\N	\N	\N	\N
Aspects of Love	\N	\N	\N	\N
Shimada	\N	\N	\N	\N
A Christmas Carol	\N	\N	\N	\N
Kiss of the Spider Woman	\N	\N	\N	\N
The Tempest	\N	\N	\N	\N
Getting Away with Murder	\N	\N	\N	\N
Once Upon a Mattress	\N	\N	\N	\N
Proposals	\N	\N	\N	\N
Fosse	\N	\N	\N	\N
Into the Woods	\N	\N	\N	\N
Urban Cowboy	\N	\N	\N	\N
Never Gonna Dance	\N	\N	\N	\N
700 Sundays	\N	\N	\N	\N
Lennon	\N	\N	\N	\N
The History Boys	\N	\N	\N	\N
Les Miserables	\N	\N	\N	\N
Cat on a Hot Tin Roof	\N	\N	\N	\N
Equus	\N	\N	\N	\N
Mary Stuart	\N	\N	\N	\N
Enron	\N	\N	\N	\N
Baby It's You!	\N	\N	\N	\N
Hugh Jackman, Back on Broadway	\N	\N	\N	\N
Lucky Guy	\N	\N	\N	\N
Mamma Mia!	\N	\N	\N	\N
Misery	\N	\N	\N	\N
Tuck Everlasting	\N	\N	\N	\N
The Front Page	\N	\N	\N	\N
Anastasia	\N	\N	\N	\N
Jagged Little Pill	\N	\N	\N	\N
A Beautiful Noise	\N	\N	\N	\N
Chess	\N	\N	\N	\N
The Hills of California	\N	\N	\N	\N
Boop! The Musical	\N	\N	\N	\N
The New Yorkers	\N	\N	\N	\N
Troilus and Cressida	\N	\N	\N	\N
Earl Carroll's Vanities	\N	\N	\N	\N
Too Many Girls	\N	\N	\N	\N
Mamba's Daughters	\N	\N	\N	\N
This Is The Army	\N	\N	\N	\N
Ballet Imperial,The Fair at Sorochinsk	\N	\N	\N	\N
La Vie Parisienne	\N	\N	\N	\N
My Sister Eileen	\N	\N	\N	\N
Lady in the Dark	\N	\N	\N	\N
Artists and Models (1943)	\N	\N	\N	\N
Carmen Jones	\N	\N	\N	\N
Memphis Bound!	\N	\N	\N	\N
Up in Central Park	\N	\N	\N	\N
Song of Norway	\N	\N	\N	\N
A Flag Is Born	\N	\N	\N	\N
Beggar's Holiday	\N	\N	\N	\N
The Cradle Will Rock	\N	\N	\N	\N
High Button Shoes	\N	\N	\N	\N
Cabalgata	\N	\N	\N	\N
As the Girls Go	\N	\N	\N	\N
Katherine Dunham and Her Company	\N	\N	\N	\N
Where's Charley?	\N	\N	\N	\N
The Green Pastures	\N	\N	\N	\N
Oklahoma!	\N	\N	\N	\N
Diamond Lil	\N	\N	\N	\N
Kiss Me, Kate	\N	\N	\N	\N
Four Saints in Three Acts	\N	\N	\N	\N
Shuffle Along (1952)	\N	\N	\N	\N
South Pacific	\N	\N	\N	\N
The Saint of Bleecker Street	\N	\N	\N	\N
Mr. Wonderful	\N	\N	\N	\N
Shinbone Alley	\N	\N	\N	\N
The Body Beautiful	\N	\N	\N	\N
West Side Story	\N	\N	\N	\N
Gypsy	\N	\N	\N	\N
The Music Man	\N	\N	\N	\N
Kean	\N	\N	\N	\N
I Can Get It for You Wholesale	\N	\N	\N	\N
Tovarich	\N	\N	\N	\N
The Girl Who Came to Supper	\N	\N	\N	\N
Baker Street	\N	\N	\N	\N
The Devils	\N	\N	\N	\N
A Time for Singing	\N	\N	\N	\N
Annie Get Your Gun	\N	\N	\N	\N
Funny Girl	\N	\N	\N	\N
The Happy Time	\N	\N	\N	\N
Mame	\N	\N	\N	\N
Purlie	\N	\N	\N	\N
Fiddler on the Roof	\N	\N	\N	\N
Guys and Dolls	\N	\N	\N	\N
Nana Mouskouri on Broadway	\N	\N	\N	\N
The Wiz	\N	\N	\N	\N
Evita	\N	\N	\N	\N
Zorba	\N	\N	\N	\N
The Three Musketeers	\N	\N	\N	\N
The King and I	\N	\N	\N	\N
Big Deal	\N	\N	\N	\N
Miss Saigon	\N	\N	\N	\N
Blast!	\N	\N	\N	\N
Robin Williams: Live on Broadway	\N	\N	\N	\N
La Boheme	\N	\N	\N	\N
Bombay Dreams	\N	\N	\N	\N
Cirque Dreams	\N	\N	\N	\N
Shrek The Musical	\N	\N	\N	\N
Promises, Promises	\N	\N	\N	\N
Sister Act	\N	\N	\N	\N
Frankie Valli and the Four Seasons on Broadway	\N	\N	\N	\N
Cinderella	\N	\N	\N	\N
Doctor Zhivago	\N	\N	\N	\N
King Kong	\N	\N	\N	\N
The Little Prince	\N	\N	\N	\N
Here Lies Love	\N	\N	\N	\N
Mourning Becomes Electra	\N	\N	\N	\N
Medea	\N	\N	\N	\N
The Waltz of the Toreadors	\N	\N	\N	\N
The National Health	\N	\N	\N	\N
All God's Chillun Got Wings	\N	\N	\N	\N
Ah, Wilderness!	\N	\N	\N	\N
Geraldine Fitzgerald in Songs of the Street	\N	\N	\N	\N
The Lady from the Sea	\N	\N	\N	\N
The Night of the Iguana	\N	\N	\N	\N
The Importance of Being Earnest	\N	\N	\N	\N
Tartuffe	\N	\N	\N	\N
Saint Joan	\N	\N	\N	\N
13 Rue de l'Amour	\N	\N	\N	\N
Once in a Lifetime	\N	\N	\N	\N
The Inspector General	\N	\N	\N	\N
Man and Superman	\N	\N	\N	\N
Major Barbara	\N	\N	\N	\N
The Man Who Came to Dinner	\N	\N	\N	\N
The Bacchae	\N	\N	\N	\N
The Father	\N	\N	\N	\N
The Misanthrope	\N	\N	\N	\N
The Caine Mutiny Court-Martial	\N	\N	\N	\N
Heartbreak House	\N	\N	\N	\N
Awake and Sing	\N	\N	\N	\N
Design for Living	\N	\N	\N	\N
Arms and the Man	\N	\N	\N	\N
The Marriage of Figaro	\N	\N	\N	\N
The Caretaker	\N	\N	\N	\N
You Never Can Tell	\N	\N	\N	\N
Coastal Disturbances	\N	\N	\N	\N
An Evening with Robert Klein	\N	\N	\N	\N
The Devil's Disciple	\N	\N	\N	\N
Ghetto	\N	\N	\N	\N
Sweeney Todd	\N	\N	\N	\N
The Miser	\N	\N	\N	\N
Taking Steps	\N	\N	\N	\N
On Borrowed Time	\N	\N	\N	\N
Salome	\N	\N	\N	\N
Anna Karenina	\N	\N	\N	\N
The Shadow Box	\N	\N	\N	\N
The Rose Tattoo	\N	\N	\N	\N
Garden District	\N	\N	\N	\N
Holiday	\N	\N	\N	\N
Bus Stop	\N	\N	\N	\N
Stanley	\N	\N	\N	\N
Not About Nightingales	\N	\N	\N	\N
True West	\N	\N	\N	\N
Metamorphoses	\N	\N	\N	\N
Life (x) 3	\N	\N	\N	\N
Frozen	\N	\N	\N	\N
The 25th Annual Putnam County Spelling Bee	\N	\N	\N	\N
Glory Days	\N	\N	\N	\N
The Norman Conquests	\N	\N	\N	\N
The Miracle Worker	\N	\N	\N	\N
Lombardi	\N	\N	\N	\N
Soul Doctor	\N	\N	\N	\N
Bronx Bombers	\N	\N	\N	\N
Lady Day at Emerson's Bar and Grill	\N	\N	\N	\N
The River	\N	\N	\N	\N
Fun Home	\N	\N	\N	\N
In Transit	\N	\N	\N	\N
Chicken & Biscuits	\N	\N	\N	\N
KPOP	\N	\N	\N	\N
Just in Time	\N	\N	\N	\N
Topaze	\N	\N	\N	\N
The Truth Game	\N	\N	\N	\N
Scarlet Sister Mary	\N	\N	\N	\N
Melo	\N	\N	\N	\N
The School for Scandal	\N	\N	\N	\N
There's Always Juliet	\N	\N	\N	\N
Gay Divorce	\N	\N	\N	\N
Both Your Houses	\N	\N	\N	\N
Ruth Draper	\N	\N	\N	\N
Point Valaine	\N	\N	\N	\N
Othello	\N	\N	\N	\N
Bury the Dead	\N	\N	\N	\N
Night Must Fall	\N	\N	\N	\N
The Women	\N	\N	\N	\N
Knickerbocker Holiday	\N	\N	\N	\N
No Time for Comedy	\N	\N	\N	\N
Key Largo	\N	\N	\N	\N
Best Foot Forward	\N	\N	\N	\N
R.U.R.	\N	\N	\N	\N
Three Sisters	\N	\N	\N	\N
Rebecca	\N	\N	\N	\N
The Barretts of Wimpole Street	\N	\N	\N	\N
Marinka	\N	\N	\N	\N
Pygmalion	\N	\N	\N	\N
The Duchess of Malfi	\N	\N	\N	\N
Cyrano de Bergerac	\N	\N	\N	\N
The Telephone/The Medium	\N	\N	\N	\N
The Rat Race	\N	\N	\N	\N
The Consul	\N	\N	\N	\N
Bell, Book and Candle	\N	\N	\N	\N
The Fourposter	\N	\N	\N	\N
I've Got Sixpence	\N	\N	\N	\N
Tea and Sympathy	\N	\N	\N	\N
The Desperate Hours	\N	\N	\N	\N
Marcel Marceau	\N	\N	\N	\N
The Chalk Garden	\N	\N	\N	\N
Small War on Murray Hill	\N	\N	\N	\N
Waiting for Godot	\N	\N	\N	\N
Look Homeward, Angel	\N	\N	\N	\N
A Majority of One	\N	\N	\N	\N
The Hostage	\N	\N	\N	\N
Critic's Choice	\N	\N	\N	\N
The Complaisant Lover	\N	\N	\N	\N
Moby-Dick	\N	\N	\N	\N
The Passion of Josef D.	\N	\N	\N	\N
The Amen Corner	\N	\N	\N	\N
Wait Until Dark	\N	\N	\N	\N
We Have Always Lived in the Castle	\N	\N	\N	\N
Les Ballets Africains	\N	\N	\N	\N
Black Comedy/White Lies	\N	\N	\N	\N
The Little Foxes	\N	\N	\N	\N
The Seven Descents of Myrtle	\N	\N	\N	\N
Happiness Is Just a Little Thing Called a Rolls Royce	\N	\N	\N	\N
Conduct Unbecoming	\N	\N	\N	\N
The Philanthropist	\N	\N	\N	\N
Captain Brassbound's Conversion	\N	\N	\N	\N
Don't Play Us Cheap	\N	\N	\N	\N
The Visit	\N	\N	\N	\N
A Song at Twilight/Come Into the Garden, Maud	\N	\N	\N	\N
The Night That Made America Famous	\N	\N	\N	\N
Travesties	\N	\N	\N	\N
Legend	\N	\N	\N	\N
Poor Murderer	\N	\N	\N	\N
I Love My Wife	\N	\N	\N	\N
Romantic Comedy	\N	\N	\N	\N
The West Side Waltz	\N	\N	\N	\N
Is There Life After High School?	\N	\N	\N	\N
Foxfire	\N	\N	\N	\N
Baby	\N	\N	\N	\N
Hurlyburly	\N	\N	\N	\N
Social Security	\N	\N	\N	\N
The Secret Rapture	\N	\N	\N	\N
Lettice and Lovage	\N	\N	\N	\N
Mule Bone	\N	\N	\N	\N
The Sisters Rosensweig	\N	\N	\N	\N
Indiscretions	\N	\N	\N	\N
An Ideal Husband	\N	\N	\N	\N
The Life	\N	\N	\N	\N
Electra	\N	\N	\N	\N
Amy's View	\N	\N	\N	\N
Putting It Together	\N	\N	\N	\N
The Real Thing	\N	\N	\N	\N
The Tale of the Allergist's Wife	\N	\N	\N	\N
Imaginary Friends	\N	\N	\N	\N
Ring of Fire	\N	\N	\N	\N
Red Carpet Massacre	\N	\N	\N	\N
November	\N	\N	\N	\N
Speed-the-Plow	\N	\N	\N	\N
Exit the King	\N	\N	\N	\N
Race	\N	\N	\N	\N
Elling	\N	\N	\N	\N
Arcadia	\N	\N	\N	\N
An Evening withPatti LuPoneandMandy Patinkin	\N	\N	\N	\N
Chaplin	\N	\N	\N	\N
The Curious Incident of the Dog in the Night-Time	\N	\N	\N	\N
Alton Brown Live: Eat Your Science	\N	\N	\N	\N
The Present	\N	\N	\N	\N
Six Degrees of Separation	\N	\N	\N	\N
The Band's Visit	\N	\N	\N	\N
The Inheritance	\N	\N	\N	\N
Waitress	\N	\N	\N	\N
Paradise Square	\N	\N	\N	\N
The Piano Lesson	\N	\N	\N	\N
Peter Pan Goes Wrong	\N	\N	\N	\N
El Mago Pop	\N	\N	\N	\N
Harmony: A New Musical	\N	\N	\N	\N
Patriots	\N	\N	\N	\N
Let It Ride	\N	\N	\N	\N
Ross	\N	\N	\N	\N
A Thousand Clowns	\N	\N	\N	\N
She Loves Me	\N	\N	\N	\N
Something More!	\N	\N	\N	\N
The Freaking Out of Stephanie Blake[f]	\N	\N	\N	\N
Rosencrantz and Guildenstern Are Dead	\N	\N	\N	\N
Canterbury Tales	\N	\N	\N	\N
Last of the Red Hot Lovers	\N	\N	\N	\N
The Prisoner of Second Avenue	\N	\N	\N	\N
The Good Doctor	\N	\N	\N	\N
God's Favorite	\N	\N	\N	\N
Yentl	\N	\N	\N	\N
California Suite	\N	\N	\N	\N
Chapter Two	\N	\N	\N	\N
I Ought to Be in Pictures	\N	\N	\N	\N
Fools	\N	\N	\N	\N
Annie	\N	\N	\N	\N
Little Me	\N	\N	\N	\N
The Best Little Whorehouse in Texas	\N	\N	\N	\N
Moose Murders	\N	\N	\N	\N
Big River	\N	\N	\N	\N
Tom Waits in Concert on Broadway	\N	\N	\N	\N
M. Butterfly	\N	\N	\N	\N
La Bête	\N	\N	\N	\N
Penn & Teller: The Refrigerator Tour	\N	\N	\N	\N
The Herbal Bed	\N	\N	\N	\N
Waiting in the Wings	\N	\N	\N	\N
The Full Monty	\N	\N	\N	\N
Nine	\N	\N	\N	\N
Caroline, or Change	\N	\N	\N	\N
Good Vibrations	\N	\N	\N	\N
Spring Awakening	\N	\N	\N	\N
33 Variations	\N	\N	\N	\N
8	\N	\N	\N	\N
The Book of Mormon	\N	\N	\N	\N
Chita Rivera: The Dancer's Life	\N	\N	\N	\N
A Chorus Line	\N	\N	\N	\N
All My Sons	\N	\N	\N	\N
Impressionism	\N	\N	\N	\N
A Steady Rain	\N	\N	\N	\N
A Behanding in Spokane	\N	\N	\N	\N
A Life in the Theatre	\N	\N	\N	\N
The Motherfucker with the Hat	\N	\N	\N	\N
Bonnie & Clyde	\N	\N	\N	\N
The Best Man	\N	\N	\N	\N
Glengarry Glen Ross	\N	\N	\N	\N
Orphans	\N	\N	\N	\N
The Bridges of Madison County	\N	\N	\N	\N
The Audience	\N	\N	\N	\N
China Doll	\N	\N	\N	\N
American Psycho	\N	\N	\N	\N
The Humans	\N	\N	\N	\N
Come from Away	\N	\N	\N	\N
Take Me Out	\N	\N	\N	\N
Life of Pi	\N	\N	\N	\N
The Notebook	\N	\N	\N	\N
Buena Vista Social Club	\N	\N	\N	\N
Shirley MacLaine on Broadway	\N	\N	\N	\N
Twyla Tharp Dance on Broadway	\N	\N	\N	\N
Nureyev and Friends	\N	\N	\N	\N
Gladys Knight & the Pips&Kashif	\N	\N	\N	\N
Much Ado About Nothing	\N	\N	\N	\N
Patti LaBelle on Broadway	\N	\N	\N	\N
An Evening with Smokey Robinson	\N	\N	\N	\N
Singin' in the Rain	\N	\N	\N	\N
Starlight Express	\N	\N	\N	\N
Barry Manilow Live on Broadway	\N	\N	\N	\N
Meet Me in St. Louis	\N	\N	\N	\N
Bugs Bunny on Broadway	\N	\N	\N	\N
Moscow Circus	\N	\N	\N	\N
Grand Hotel	\N	\N	\N	\N
Tommy Tune Tonite!	\N	\N	\N	\N
Raffi	\N	\N	\N	\N
Yanni	\N	\N	\N	\N
Camelot	\N	\N	\N	\N
The Red Shoes	\N	\N	\N	\N
Men Are from Mars, Women Are from Venus	\N	\N	\N	\N
1776	\N	\N	\N	\N
On the Town	\N	\N	\N	\N
Peter Pan	\N	\N	\N	\N
Tango Argentino	\N	\N	\N	\N
Riverdance on Broadway	\N	\N	\N	\N
Linda Eder at the Gershwin	\N	\N	\N	\N
Wicked	\N	\N	\N	\N
Lobby Hero	\N	\N	\N	\N
Straight White Men	\N	\N	\N	\N
Torch Song	\N	\N	\N	\N
What the Constitution Means to Me	\N	\N	\N	\N
Linda Vista	\N	\N	\N	\N
Grand Horizons	\N	\N	\N	\N
Clyde's	\N	\N	\N	\N
Kite Runner	\N	\N	\N	\N
Between Riverside and Crazy	\N	\N	\N	\N
The Thanksgiving Play	\N	\N	\N	\N
The Cottage	\N	\N	\N	\N
Mother Play	\N	\N	\N	\N
Job	\N	\N	\N	\N
Cult of Love	\N	\N	\N	\N
Purpose	\N	\N	\N	\N
Marjorie Prime	\N	\N	\N	\N
Becky Shaw	\N	\N	\N	\N
The Marriage of Kitty	\N	\N	\N	\N
Brewster's Millions	\N	\N	\N	\N
Lady Frederick	\N	\N	\N	\N
Arsène Lupin	\N	\N	\N	\N
Frou-Frou	\N	\N	\N	\N
General John Regan	\N	\N	\N	\N
Lady Windermere's Fan	\N	\N	\N	\N
Our Betters	\N	\N	\N	\N
Friendly Enemies	\N	\N	\N	\N
The Voice From the Minaret	\N	\N	\N	\N
Fedora	\N	\N	\N	\N
So This Is London	\N	\N	\N	\N
The Fake	\N	\N	\N	\N
The Noose	\N	\N	\N	\N
The Plough and the Stars	\N	\N	\N	\N
Hot Chocolates	\N	\N	\N	\N
The Amazing Dr. Clitterhouse	\N	\N	\N	\N
Good Hunting	\N	\N	\N	\N
Lew Leslie's Blackbirds	\N	\N	\N	\N
Love for Love	\N	\N	\N	\N
All Men Are Alike	\N	\N	\N	\N
Run, Little Chillun	\N	\N	\N	\N
Arsenic and Old Lace	\N	\N	\N	\N
State of the Union	\N	\N	\N	\N
Toys in the Attic	\N	\N	\N	\N
Strange Interlude	\N	\N	\N	\N
How to Be a Jewish Mother	\N	\N	\N	\N
1984	\N	\N	\N	\N
The Parisian Woman	\N	\N	\N	\N
Head over Heels	\N	\N	\N	\N
Burn This	\N	\N	\N	\N
American Utopia	\N	\N	\N	\N
Plaza Suite	\N	\N	\N	\N
Just for Us	\N	\N	\N	\N
Merrily We Roll Along	\N	\N	\N	\N
All In: Comedy About Love	\N	\N	\N	\N
The Last Five Years	\N	\N	\N	\N
Mary Jane McKane	\N	\N	\N	\N
Rose-Marie	\N	\N	\N	\N
Oh, Kay!	\N	\N	\N	\N
The Desert Song	\N	\N	\N	\N
The New Moon	\N	\N	\N	\N
Princess Charming	\N	\N	\N	\N
Babes in Toyland	\N	\N	\N	\N
Flying Colors	\N	\N	\N	\N
Of Thee I Sing	\N	\N	\N	\N
Let 'Em Eat Cake	\N	\N	\N	\N
Say When	\N	\N	\N	\N
Panic	\N	\N	\N	\N
Jubilee	\N	\N	\N	\N
Between the Devil	\N	\N	\N	\N
Leave It to Me!	\N	\N	\N	\N
Louisiana Purchase	\N	\N	\N	\N
Let's Face It!	\N	\N	\N	\N
One Touch of Venus	\N	\N	\N	\N
Ziegfeld Follies	\N	\N	\N	\N
Miss Liberty	\N	\N	\N	\N
Call Me Madam	\N	\N	\N	\N
Wish You Were Here	\N	\N	\N	\N
John Murray Anderson's Almanac	\N	\N	\N	\N
By the Beautiful Sea	\N	\N	\N	\N
Silk Stockings	\N	\N	\N	\N
Jamaica	\N	\N	\N	\N
Destry Rides Again	\N	\N	\N	\N
Carnival!	\N	\N	\N	\N
Oliver!	\N	\N	\N	\N
A Patriot for Me	\N	\N	\N	\N
Minnie's Boys	\N	\N	\N	\N
Two by Two	\N	\N	\N	\N
Lost in the Stars	\N	\N	\N	\N
Pippin	\N	\N	\N	\N
Mark Twain Tonight!	\N	\N	\N	\N
Anna Christie	\N	\N	\N	\N
They're Playing Our Song	\N	\N	\N	\N
The Mystery of Edwin Drood	\N	\N	\N	\N
Jerome Robbins' Broadway	\N	\N	\N	\N
The Boy from Oz	\N	\N	\N	\N
Dirty Rotten Scoundrels	\N	\N	\N	\N
High Fidelity	\N	\N	\N	\N
Coram Boy	\N	\N	\N	\N
August: Osage County	\N	\N	\N	\N
Billy Elliot the Musical	\N	\N	\N	\N
Nice Work If You Can Get It	\N	\N	\N	\N
Natasha, Pierre & The Great Comet of 1812	\N	\N	\N	\N
Carousel	\N	\N	\N	\N
Ain't Too Proud	\N	\N	\N	\N
Bad Cinderella	\N	\N	\N	\N
Water for Elephants	\N	\N	\N	\N
Smash	\N	\N	\N	\N
The Princess Pat	\N	\N	\N	\N
Everyman	\N	\N	\N	\N
Abraham Lincoln	\N	\N	\N	\N
Captain Applejack	\N	\N	\N	\N
Merton of the Movies	\N	\N	\N	\N
The Assumption of Hannele	\N	\N	\N	\N
The Second Mrs. Tanqueray	\N	\N	\N	\N
The Jazz Singer	\N	\N	\N	\N
The Wrecker	\N	\N	\N	\N
Five Star Final	\N	\N	\N	\N
The Blue Bird	\N	\N	\N	\N
The Green Bay Tree	\N	\N	\N	\N
The Bishop Misbehaves	\N	\N	\N	\N
Most of the Game	\N	\N	\N	\N
There's Wisdom in Women	\N	\N	\N	\N
Room Service	\N	\N	\N	\N
The White Steed	\N	\N	\N	\N
The Male Animal	\N	\N	\N	\N
Charley's Aunt	\N	\N	\N	\N
Cafe Crown	\N	\N	\N	\N
I Killed the Count	\N	\N	\N	\N
The Winter's Tale	\N	\N	\N	\N
Antigone	\N	\N	\N	\N
Ghosts	\N	\N	\N	\N
The Happy Journey to Trenton and CamdenandThe Respectful Prostitute	\N	\N	\N	\N
Make Way for Lucia	\N	\N	\N	\N
Two Blind Mice	\N	\N	\N	\N
The Shrike	\N	\N	\N	\N
The Rainmaker	\N	\N	\N	\N
Sunrise at Campobello	\N	\N	\N	\N
Advise and Consent	\N	\N	\N	\N
Purlie Victorious	\N	\N	\N	\N
Sunday in New York	\N	\N	\N	\N
The Father,Long Day's Journey into Night, andMiss Julie	\N	\N	\N	\N
One Flew Over the Cuckoo's Nest	\N	\N	\N	\N
Boeing-Boeing	\N	\N	\N	\N
The Zulu and the Zayda	\N	\N	\N	\N
Johnny No-Trump	\N	\N	\N	\N
Something Different	\N	\N	\N	\N
Leda Had a Little Swan	\N	\N	\N	\N
Red, White and Maddox	\N	\N	\N	\N
King Richard III	\N	\N	\N	\N
Clothes for a Summer Hotel	\N	\N	\N	\N
A Moon for the Misbegotten	\N	\N	\N	\N
Ma Rainey's Black Bottom	\N	\N	\N	\N
Sarafina!	\N	\N	\N	\N
The Grapes of Wrath	\N	\N	\N	\N
Face Value	\N	\N	\N	\N
Twilight: Los Angeles, 1992	\N	\N	\N	\N
An American Daughter	\N	\N	\N	\N
Freak	\N	\N	\N	\N
The Blue Room	\N	\N	\N	\N
Kat and the Kings	\N	\N	\N	\N
The Green Bird	\N	\N	\N	\N
Hollywood Arms	\N	\N	\N	\N
A Year with Frog and Toad	\N	\N	\N	\N
Bobbi Boland	\N	\N	\N	\N
Laugh Whore	\N	\N	\N	\N
On Golden Pond	\N	\N	\N	\N
Barefoot in the Park	\N	\N	\N	\N
The Little Dog Laughed	\N	\N	\N	\N
Radio Golf	\N	\N	\N	\N
The Homecoming	\N	\N	\N	\N
The 39 Steps	\N	\N	\N	\N
You're Welcome America: A Final Night with George W. Bush	\N	\N	\N	\N
Fences	\N	\N	\N	\N
Time Stands Still	\N	\N	\N	\N
Born Yesterday	\N	\N	\N	\N
Stick Fly	\N	\N	\N	\N
The Lyons	\N	\N	\N	\N
Grace	\N	\N	\N	\N
Breakfast at Tiffany's	\N	\N	\N	\N
No Man's LandandWaiting for Godot	\N	\N	\N	\N
The Cripple of Inishmaan	\N	\N	\N	\N
This is Our Youth	\N	\N	\N	\N
Fish in the Dark	\N	\N	\N	\N
Sylvia	\N	\N	\N	\N
Bright Star	\N	\N	\N	\N
Indecent	\N	\N	\N	\N
Mike Birbiglia's The New One	\N	\N	\N	\N
King Lear	\N	\N	\N	\N
Derren Brown: Secret	\N	\N	\N	\N
The Minutes	\N	\N	\N	\N
Ohio State Murders	\N	\N	\N	\N
The Sign in Sidney Brustein's Window	\N	\N	\N	\N
Gutenberg! The Musical!	\N	\N	\N	\N
The Heart of Rock and Roll	\N	\N	\N	\N
Left on Tenth	\N	\N	\N	\N
Real Women Have Curves	\N	\N	\N	\N
Patience	\N	\N	\N	\N
Rope's End	\N	\N	\N	\N
The Venetian	\N	\N	\N	\N
Louder, Please	\N	\N	\N	\N
Tobacco Road	\N	\N	\N	\N
Eden End	\N	\N	\N	\N
Shadow and Substance	\N	\N	\N	\N
Lightnin'	\N	\N	\N	\N
Angel Street	\N	\N	\N	\N
Maurice Chevalier in an evening of Songs and Impressions	\N	\N	\N	\N
Goodbye, My Fancy	\N	\N	\N	\N
Let's Make an Opera	\N	\N	\N	\N
To Dorothy, A Son	\N	\N	\N	\N
Comedy in Music	\N	\N	\N	\N
Someone Waiting	\N	\N	\N	\N
The Potting Shed	\N	\N	\N	\N
Look Back in Anger	\N	\N	\N	\N
Epitaph for George Dillon	\N	\N	\N	\N
A Party with Betty Comden and Adolph Green	\N	\N	\N	\N
Requiem for a Nun	\N	\N	\N	\N
The Billy Barnes Revue	\N	\N	\N	\N
At the Drop of a Hat	\N	\N	\N	\N
An Evening WithMike NicholsandElaine May	\N	\N	\N	\N
An Evening withYves Montand	\N	\N	\N	\N
Beyond the Fringe	\N	\N	\N	\N
Wait a Minim!	\N	\N	\N	\N
After the Rain	\N	\N	\N	\N
Carry Me Back to Morningside Heights	\N	\N	\N	\N
The Exercise	\N	\N	\N	\N
Bob and Ray-The Two and Only	\N	\N	\N	\N
Sticks and Bones	\N	\N	\N	\N
HughieandDuet	\N	\N	\N	\N
P. S. Your Cat Is Dead!	\N	\N	\N	\N
Kennedy's Children	\N	\N	\N	\N
Going Up	\N	\N	\N	\N
Dirty Linen & New-Found-Land	\N	\N	\N	\N
The Gin Game	\N	\N	\N	\N
Murder at the Howard Johnson's	\N	\N	\N	\N
Watch on the Rhine	\N	\N	\N	\N
A Day in Hollywood / A Night in the Ukraine	\N	\N	\N	\N
Tintypes	\N	\N	\N	\N
Crimes of the Heart	\N	\N	\N	\N
'night, Mother	\N	\N	\N	\N
Blood Knot	\N	\N	\N	\N
Stepping Out	\N	\N	\N	\N
Juno and the Paycock	\N	\N	\N	\N
Eastern Standard	\N	\N	\N	\N
Falsettos	\N	\N	\N	\N
Master Class	\N	\N	\N	\N
The Chairs	\N	\N	\N	\N
Side Man	\N	\N	\N	\N
Stones in His Pockets	\N	\N	\N	\N
The Goat, or Who is Sylvia?	\N	\N	\N	\N
Vincent in Brixton	\N	\N	\N	\N
Avenue Q	\N	\N	\N	\N
Oleanna	\N	\N	\N	\N
Red	\N	\N	\N	\N
Driving Miss Daisy	\N	\N	\N	\N
The Normal Heart	\N	\N	\N	\N
Seminar	\N	\N	\N	\N
Vanya and Sonia and Masha and Spike	\N	\N	\N	\N
A Time to Kill	\N	\N	\N	\N
Mothers and Sons	\N	\N	\N	\N
A Delicate Balance	\N	\N	\N	\N
Skylight	\N	\N	\N	\N
Eclipsed	\N	\N	\N	\N
A Doll's House, Part 2	\N	\N	\N	\N
Three Tall Women	\N	\N	\N	\N
The Waverly Gallery	\N	\N	\N	\N
Hillary and Clinton	\N	\N	\N	\N
Slave Play	\N	\N	\N	\N
Thoughts of a Colored Man	\N	\N	\N	\N
Hangmen	\N	\N	\N	\N
Prima Facie	\N	\N	\N	\N
The Shark Is Broken	\N	\N	\N	\N
Stereophonic	\N	\N	\N	\N
Operation Mincemeat	\N	\N	\N	\N
Beyond the Horizon	\N	\N	\N	\N
The Dybbuk	\N	\N	\N	\N
Present Arms	\N	\N	\N	\N
Chee-Chee	\N	\N	\N	\N
The House of Connelly	\N	\N	\N	\N
Shuffle Along (1933)	\N	\N	\N	\N
Page Miss Glory	\N	\N	\N	\N
Black Limelight	\N	\N	\N	\N
Sea Legs	\N	\N	\N	\N
Antony and Cleopatra	\N	\N	\N	\N
What a Life	\N	\N	\N	\N
Thunder Rock	\N	\N	\N	\N
Meet the People	\N	\N	\N	\N
Anna Lucasta	\N	\N	\N	\N
John Bull's Other Island	\N	\N	\N	\N
Red Gloves	\N	\N	\N	\N
Come Blow Your Horn	\N	\N	\N	\N
Phèdre	\N	\N	\N	\N
Berenice	\N	\N	\N	\N
Man and Boy	\N	\N	\N	\N
The Milk Train Doesn't Stop Here Anymore	\N	\N	\N	\N
The Deputy	\N	\N	\N	\N
Love in E-Flat	\N	\N	\N	\N
A Minor Adjustment	\N	\N	\N	\N
Halfway Up the Tree	\N	\N	\N	\N
A Day in the Death of Joe Egg	\N	\N	\N	\N
Lovers and Other Strangers	\N	\N	\N	\N
Indians	\N	\N	\N	\N
Paris Is Out!	\N	\N	\N	\N
Not Now, Darling	\N	\N	\N	\N
Lenny	\N	\N	\N	\N
The River Niger	\N	\N	\N	\N
My Fat Friend	\N	\N	\N	\N
Of Mice and Men	\N	\N	\N	\N
Tribute	\N	\N	\N	\N
Bedroom Farce	\N	\N	\N	\N
Talley's Folly	\N	\N	\N	\N
Lolita	\N	\N	\N	\N
The Dresser	\N	\N	\N	\N
Beyond Therapy	\N	\N	\N	\N
Steaming	\N	\N	\N	\N
K2	\N	\N	\N	\N
Edmund Kean	\N	\N	\N	\N
Noises Off	\N	\N	\N	\N
Aren't We All?	\N	\N	\N	\N
Benefactors	\N	\N	\N	\N
Rowan Atkinson at the Atkinson	\N	\N	\N	\N
Jackie Mason's The World According to Me!	\N	\N	\N	\N
Peter, Paul & Mary "A Holiday Celebration"	\N	\N	\N	\N
Stephanie Mills Comes "Home" to Broadway	\N	\N	\N	\N
The Cemetery Club	\N	\N	\N	\N
Shadowlands	\N	\N	\N	\N
Death and the Maiden	\N	\N	\N	\N
Redwood Curtain	\N	\N	\N	\N
Buried Child	\N	\N	\N	\N
Taking Sides	\N	\N	\N	\N
Play On!	\N	\N	\N	\N
Jane Eyre	\N	\N	\N	\N
The Look of Love	\N	\N	\N	\N
Jumpers	\N	\N	\N	\N
Democracy	\N	\N	\N	\N
The Times They Are a-Changin'	\N	\N	\N	\N
Rock of Ages	\N	\N	\N	\N
Rain: A Tribute to the Beatles	\N	\N	\N	\N
Relatively Speaking	\N	\N	\N	\N
Peter and the Starcatcher	\N	\N	\N	\N
Hands on a Hardbody	\N	\N	\N	\N
After Midnight	\N	\N	\N	\N
Love Letters	\N	\N	\N	\N
It Shoulda Been You	\N	\N	\N	\N
Six	\N	\N	\N	\N
Adele	\N	\N	\N	\N
A Pair of Sixes	\N	\N	\N	\N
Secret Strings	\N	\N	\N	\N
Leave It to Jane	\N	\N	\N	\N
Adam and Eva	\N	\N	\N	\N
Nobody's Money	\N	\N	\N	\N
Rose Bernd	\N	\N	\N	\N
Little Jessie James	\N	\N	\N	\N
The Butter and Egg Man	\N	\N	\N	\N
Ritzy	\N	\N	\N	\N
Wednesday's Child	\N	\N	\N	\N
Till the Day I Die/Waiting for Lefty	\N	\N	\N	\N
Paradise Lost	\N	\N	\N	\N
Wuthering Heights	\N	\N	\N	\N
The Three Sisters	\N	\N	\N	\N
Morning's at Seven	\N	\N	\N	\N
Leave Her to Heaven	\N	\N	\N	\N
Mademoiselle Colombe	\N	\N	\N	\N
The Burning Glass	\N	\N	\N	\N
The Tender Trap	\N	\N	\N	\N
The Honeys	\N	\N	\N	\N
The Lark	\N	\N	\N	\N
Holiday for Lovers	\N	\N	\N	\N
An Evening With Yves Montand	\N	\N	\N	\N
The Rhinoceros	\N	\N	\N	\N
Mark Twain Tonight	\N	\N	\N	\N
The Mutilated/The Gnadiges Fraulein	\N	\N	\N	\N
A Hand Is on the Gate	\N	\N	\N	\N
Gilbert Becaud on Broadway	\N	\N	\N	\N
Daphne in Cottage D	\N	\N	\N	\N
Cactus Flower	\N	\N	\N	\N
Les Blancs	\N	\N	\N	\N
The Me Nobody Knows	\N	\N	\N	\N
The Ritz	\N	\N	\N	\N
The Belle of Amherst	\N	\N	\N	\N
Checking Out	\N	\N	\N	\N
No Man's Land	\N	\N	\N	\N
The Basic Training of Pavlo Hummel	\N	\N	\N	\N
Jesus Christ Superstar	\N	\N	\N	\N
Bosoms and Neglect	\N	\N	\N	\N
But Never Jam Today	\N	\N	\N	\N
Children of a Lesser God	\N	\N	\N	\N
Passion	\N	\N	\N	\N
Harrigan 'N Hart	\N	\N	\N	\N
The Musical Comedy Murders of 1940	\N	\N	\N	\N
Tony Bennett: Steppin' Out on Broadway	\N	\N	\N	\N
The Young Man From Atlanta	\N	\N	\N	\N
Golden Child	\N	\N	\N	\N
Judgment at Nuremberg	\N	\N	\N	\N
One Mo' Time	\N	\N	\N	\N
Russell Simmons Def Poetry Jam	\N	\N	\N	\N
Well	\N	\N	\N	\N
Talk Radio	\N	\N	\N	\N
Boeing Boeing	\N	\N	\N	\N
Burn the Floor	\N	\N	\N	\N
La Cage aux Folles	\N	\N	\N	\N
Chinglish	\N	\N	\N	\N
Magic/Bird	\N	\N	\N	\N
The Performers	\N	\N	\N	\N
First Date the Musical	\N	\N	\N	\N
Allegiance	\N	\N	\N	\N
A Bronx Tale	\N	\N	\N	\N
The Prom	\N	\N	\N	\N
The Lightning Thief	\N	\N	\N	\N
Diana	\N	\N	\N	\N
Leopoldstadt	\N	\N	\N	\N
Lempicka	\N	\N	\N	\N
Swept Away	\N	\N	\N	\N
Dead Outlaw	\N	\N	\N	\N
Goldilocks	\N	\N	\N	\N
The Sound of Music	\N	\N	\N	\N
Arturo Ui	\N	\N	\N	\N
Luther	\N	\N	\N	\N
Wiener Blut	\N	\N	\N	\N
Ben Franklin in Paris	\N	\N	\N	\N
Bajour	\N	\N	\N	\N
Skyscraper	\N	\N	\N	\N
Walking Happy	\N	\N	\N	\N
Marlene Dietrich	\N	\N	\N	\N
How Now, Dow Jones	\N	\N	\N	\N
Her First Roman	\N	\N	\N	\N
Come Summer	\N	\N	\N	\N
La Strada	\N	\N	\N	\N
Look to the Lilies	\N	\N	\N	\N
The Rothschilds	\N	\N	\N	\N
A Funny Thing Happened on the Way to the Forum	\N	\N	\N	\N
Ambassador	\N	\N	\N	\N
6 Rms Riv Vu	\N	\N	\N	\N
The Pajama Game	\N	\N	\N	\N
Raisin	\N	\N	\N	\N
Rex	\N	\N	\N	\N
Primitive Mysteries	\N	\N	\N	\N
Hello, Dolly!	\N	\N	\N	\N
A Broadway Musical	\N	\N	\N	\N
Beatlemania	\N	\N	\N	\N
Sophisticated Ladies	\N	\N	\N	\N
The Corn Is Green	\N	\N	\N	\N
Uptown... It's Hot!	\N	\N	\N	\N
Smile	\N	\N	\N	\N
The Gospel at Colonus	\N	\N	\N	\N
The Threepenny Opera	\N	\N	\N	\N
The Best Little Whorehouse Goes Public	\N	\N	\N	\N
A Midsummer Night's Dream	\N	\N	\N	\N
Titanic	\N	\N	\N	\N
Beauty and the Beast	\N	\N	\N	\N
The Little Mermaid	\N	\N	\N	\N
The Addams Family	\N	\N	\N	\N
Ghost the Musical	\N	\N	\N	\N
A Christmas Story: The Musical	\N	\N	\N	\N
Motown: The Musical	\N	\N	\N	\N
Finding Neverland	\N	\N	\N	\N
Frankie Valli and the Four Seasons on Broadway!	\N	\N	\N	\N
Kristin Chenoweth: My Love Letter to Broadway	\N	\N	\N	\N
Charlie and the Chocolate Factory	\N	\N	\N	\N
Summer: The Donna Summer Musical	\N	\N	\N	\N
Morrissey	\N	\N	\N	\N
Pure Yanni	\N	\N	\N	\N
Mel Brooks on Broadway	\N	\N	\N	\N
Regina Spektor: Live On Broadway	\N	\N	\N	\N
Criss Angel Raw-The Mindfreak Unplugged	\N	\N	\N	\N
Dave Chappelle on Broadway	\N	\N	\N	\N
Manilow Broadway	\N	\N	\N	\N
Tina: The Musical	\N	\N	\N	\N
Death Becomes Her	\N	\N	\N	\N
The Admirable Crichton	\N	\N	\N	\N
The Truth	\N	\N	\N	\N
Arsène Lupin[fr]	\N	\N	\N	\N
Penelope	\N	\N	\N	\N
The Pillars of Society	\N	\N	\N	\N
The Ghost Breaker	\N	\N	\N	\N
The Great Divide	\N	\N	\N	\N
The Case of Lady Camber	\N	\N	\N	\N
The Gold Diggers	\N	\N	\N	\N
Ladies of the Evening	\N	\N	\N	\N
The Sport of Kings	\N	\N	\N	\N
Berkeley Square	\N	\N	\N	\N
Anatol	\N	\N	\N	\N
Squaring the Circle	\N	\N	\N	\N
St. Helena	\N	\N	\N	\N
The Mother	\N	\N	\N	\N
When We Are Married	\N	\N	\N	\N
Junior Miss	\N	\N	\N	\N
The Doughgirls	\N	\N	\N	\N
The Enchanted	\N	\N	\N	\N
Time Out For Ginger	\N	\N	\N	\N
A Hatful of Rain	\N	\N	\N	\N
The Gazebo	\N	\N	\N	\N
Flowering Cherry	\N	\N	\N	\N
Goodbye Charlie	\N	\N	\N	\N
A Taste of Honey	\N	\N	\N	\N
The Importance of Being Oscar	\N	\N	\N	\N
Mandingo	\N	\N	\N	\N
Ages of Man	\N	\N	\N	\N
Nobody Loves an Albatross	\N	\N	\N	\N
Entertaining Mr. Sloane	\N	\N	\N	\N
You Can't Take It With You	\N	\N	\N	\N
The Wild Duck	\N	\N	\N	\N
By George	\N	\N	\N	\N
The Cherry Orchard	\N	\N	\N	\N
The Cocktail Party	\N	\N	\N	\N
Cock-a-Doodle Dandy	\N	\N	\N	\N
Three Men on a Horse	\N	\N	\N	\N
Norman, Is That You?	\N	\N	\N	\N
Borstal Boy	\N	\N	\N	\N
The School for Wives	\N	\N	\N	\N
The Great God BrownandDon Juan	\N	\N	\N	\N
Out Cry	\N	\N	\N	\N
The Lieutenant	\N	\N	\N	\N
Something's Afoot	\N	\N	\N	\N
Best Friend	\N	\N	\N	\N
Wings	\N	\N	\N	\N
"Master Harold"...and the Boys	\N	\N	\N	\N
The Man Who Had Three Arms	\N	\N	\N	\N
As Is	\N	\N	\N	\N
Timon of Athens	\N	\N	\N	\N
The Government Inspector	\N	\N	\N	\N
Gentlemen Prefer Blondes	\N	\N	\N	\N
The Lonesome West	\N	\N	\N	\N
The Invention of Love	\N	\N	\N	\N
The Play What I Wrote	\N	\N	\N	\N
I Am My Own Wife	\N	\N	\N	\N
Steel Magnolias	\N	\N	\N	\N
Souvenir	\N	\N	\N	\N
The Lieutenant of Inishmore	\N	\N	\N	\N
Inherit the Wind	\N	\N	\N	\N
Is He Dead?	\N	\N	\N	\N
Reasons to Be Pretty	\N	\N	\N	\N
In the Next Room (or The Vibrator Play)	\N	\N	\N	\N
Looped	\N	\N	\N	\N
The Scottsboro Boys	\N	\N	\N	\N
Venus in Fur	\N	\N	\N	\N
The Nance	\N	\N	\N	\N
The Realistic Joneses	\N	\N	\N	\N
Disgraced	\N	\N	\N	\N
Fully Committed	\N	\N	\N	\N
Oh, Hello	\N	\N	\N	\N
The Play That Goes Wrong	\N	\N	\N	\N
Be More Chill	\N	\N	\N	\N
Is This a RoomandDana H.	\N	\N	\N	\N
A Strange Loop	\N	\N	\N	\N
Grey House	\N	\N	\N	\N
Oh, Mary!	\N	\N	\N	\N
Ragtime	\N	\N	\N	\N
42nd Street	\N	\N	\N	\N
Chitty Chitty Bang Bang	\N	\N	\N	\N
Hot Feet	\N	\N	\N	\N
Dr. Seuss' How the Grinch Stole Christmas!	\N	\N	\N	\N
The Pirate Queen	\N	\N	\N	\N
Young Frankenstein	\N	\N	\N	\N
Spider-Man: Turn Off the Dark	\N	\N	\N	\N
Lord of the Dance: Dangerous Games	\N	\N	\N	\N
Paramour	\N	\N	\N	\N
Harry Potter and the Cursed Child	\N	\N	\N	\N
Rang Tang	\N	\N	\N	\N
Rio Rita	\N	\N	\N	\N
Artists and Models	\N	\N	\N	\N
Simple Simon	\N	\N	\N	\N
The Round Up	\N	\N	\N	\N
Pardon My English	\N	\N	\N	\N
The Bohemian Girl	\N	\N	\N	\N
The Pirates of Penzance	\N	\N	\N	\N
The Yeomen of the Guard	\N	\N	\N	\N
At Home Abroad	\N	\N	\N	\N
The Masque of Kings	\N	\N	\N	\N
The Bat	\N	\N	\N	\N
The Cat and the Canary	\N	\N	\N	\N
Babes in Arms	\N	\N	\N	\N
Margin for Error	\N	\N	\N	\N
Hellzapoppin	\N	\N	\N	\N
Porgy and Bess	\N	\N	\N	\N
Native Son	\N	\N	\N	\N
The Merry Widow	\N	\N	\N	\N
Mexican Hayride	\N	\N	\N	\N
Oedipus Rex	\N	\N	\N	\N
The Mayor of Zalamea	\N	\N	\N	\N
Call Me Mister	\N	\N	\N	\N
Allegro	\N	\N	\N	\N
Inside U.S.A.	\N	\N	\N	\N
Me and Juliet	\N	\N	\N	\N
Happy Hunting	\N	\N	\N	\N
Hot Spot	\N	\N	\N	\N
Jennie	\N	\N	\N	\N
Anyone Can Whistle	\N	\N	\N	\N
Marat/Sade	\N	\N	\N	\N
Lovely Ladies, Kind Gentlemen	\N	\N	\N	\N
Sugar	\N	\N	\N	\N
A Little Night Music	\N	\N	\N	\N
Mack & Mabel	\N	\N	\N	\N
The Act	\N	\N	\N	\N
First Monday in October	\N	\N	\N	\N
Ballroom	\N	\N	\N	\N
I Remember Mama	\N	\N	\N	\N
Bette! Divine Madness	\N	\N	\N	\N
Brigadoon	\N	\N	\N	\N
The Phantom of the Opera	\N	\N	\N	\N
Shirley Bassey	\N	\N	\N	\N
Me and My Girl	\N	\N	\N	\N
Shogun: The Musical	\N	\N	\N	\N
Nick & Nora	\N	\N	\N	\N
Man of La Mancha	\N	\N	\N	\N
The Goodbye Girl	\N	\N	\N	\N
Damn Yankees	\N	\N	\N	\N
Victor/Victoria	\N	\N	\N	\N
The Capeman	\N	\N	\N	\N
Thoroughly Modern Millie	\N	\N	\N	\N
The Woman in White	\N	\N	\N	\N
The Drowsy Chaperone	\N	\N	\N	\N
Cry-Baby	\N	\N	\N	\N
Irving Berlin's White Christmas	\N	\N	\N	\N
Soul of Shaolin	\N	\N	\N	\N
9 to 5	\N	\N	\N	\N
Come Fly Away	\N	\N	\N	\N
Wonderland: Alice's New Musical Adventure	\N	\N	\N	\N
Jekyll & Hyde	\N	\N	\N	\N
Il Divo - A Musical Affair: The Greatest Songs of Broadway	\N	\N	\N	\N
The Illusionists: Witness the Impossible	\N	\N	\N	\N
Penn & Teller on Broadway	\N	\N	\N	\N
On Your Feet!	\N	\N	\N	\N
Lewis Black: Black to the Future	\N	\N	\N	\N
Escape to Margaritaville	\N	\N	\N	\N
The Illusionists - Magic of the Holidays	\N	\N	\N	\N
Tootsie	\N	\N	\N	\N
Beetlejuice	\N	\N	\N	\N
Jonas Brothers on Broadway	\N	\N	\N	\N
Once Upon a One More Time	\N	\N	\N	\N
Stranger Things: The First Shadow	\N	\N	\N	\N
Irene	\N	\N	\N	\N
Charles Aznavouron Broadway	\N	\N	\N	\N
Tony&LenaSing	\N	\N	\N	\N
Bette Midler's Clams on the Half Shell Revue	\N	\N	\N	\N
Rockabye Hamlet	\N	\N	\N	\N
Debbie	\N	\N	\N	\N
Dutch National Ballet	\N	\N	\N	\N
Merce CunninghamDance Company	\N	\N	\N	\N
Cleoon Broadway	\N	\N	\N	\N
Angel	\N	\N	\N	\N
King of Hearts	\N	\N	\N	\N
Bejart: Ballet of the Twentieth Century	\N	\N	\N	\N
Shirley Basseyon Broadway	\N	\N	\N	\N
Engelberton Broadway	\N	\N	\N	\N
Miss Universe 1981	\N	\N	\N	\N
Can-Can	\N	\N	\N	\N
Dance a Little Closer	\N	\N	\N	\N
Marilyn: An American Fable	\N	\N	\N	\N
Patti LaBelle	\N	\N	\N	\N
Peter, Paul & Mary "From Bleecker to Broadway"	\N	\N	\N	\N
The TemptationsandThe Four Tops	\N	\N	\N	\N
Teddy & Alice	\N	\N	\N	\N
Black and Blue	\N	\N	\N	\N
Metro	\N	\N	\N	\N
Joseph and the Amazing Technicolor Dreamcoat	\N	\N	\N	\N
Sunset Boulevard	\N	\N	\N	\N
The Scarlet Pimpernel	\N	\N	\N	\N
Saturday Night Fever	\N	\N	\N	\N
The Adventures of Tom Sawyer	\N	\N	\N	\N
Dance of the Vampires	\N	\N	\N	\N
The Lion King	\N	\N	\N	\N
Music Box Revue	\N	\N	\N	\N
Paris	\N	\N	\N	\N
Dinner at Eight	\N	\N	\N	\N
As Thousands Cheer	\N	\N	\N	\N
Rain	\N	\N	\N	\N
Ceiling Zero	\N	\N	\N	\N
If This Be Treason	\N	\N	\N	\N
Pride and Prejudice	\N	\N	\N	\N
First Lady	\N	\N	\N	\N
Stage Door	\N	\N	\N	\N
I'd Rather Be Right	\N	\N	\N	\N
Set to Music	\N	\N	\N	\N
The Land Is Bright	\N	\N	\N	\N
A Kiss for Cinderella	\N	\N	\N	\N
Star and Garter	\N	\N	\N	\N
Over 21	\N	\N	\N	\N
The Linden Tree	\N	\N	\N	\N
Summer and Smoke	\N	\N	\N	\N
They Knew What They Wanted	\N	\N	\N	\N
Mrs. Gibbons' Boys	\N	\N	\N	\N
Daphne Laureola	\N	\N	\N	\N
Affairs of State	\N	\N	\N	\N
Picnic	\N	\N	\N	\N
The Solid Gold Cadillac	\N	\N	\N	\N
The Ponder Heart	\N	\N	\N	\N
Separate Tables	\N	\N	\N	\N
Miss Lonelyhearts	\N	\N	\N	\N
The Dark at the Top of the Stairs	\N	\N	\N	\N
Rashomon	\N	\N	\N	\N
Five Finger Exercise	\N	\N	\N	\N
A Far Country	\N	\N	\N	\N
Daughter of Silence	\N	\N	\N	\N
The Beauty Part	\N	\N	\N	\N
Semi-Detached	\N	\N	\N	\N
Any Wednesday	\N	\N	\N	\N
There's a Girl in My Soup	\N	\N	\N	\N
Lovers	\N	\N	\N	\N
Harkness Ballet	\N	\N	\N	\N
The Watering Place	\N	\N	\N	\N
Sleuth	\N	\N	\N	\N
Veronica's Room	\N	\N	\N	\N
Absurd Person Singular	\N	\N	\N	\N
Comedians	\N	\N	\N	\N
Side by Side by Sondheim	\N	\N	\N	\N
Deathtrap	\N	\N	\N	\N
Agnes of God	\N	\N	\N	\N
Open Admissions	\N	\N	\N	\N
The Octette Bridge Club	\N	\N	\N	\N
Hay Fever	\N	\N	\N	\N
Loot	\N	\N	\N	\N
Sweet Sue	\N	\N	\N	\N
Welcome to the Club	\N	\N	\N	\N
A Few Good Men	\N	\N	\N	\N
A Small Family Business	\N	\N	\N	\N
Blood Brothers	\N	\N	\N	\N
Swinging on a Star	\N	\N	\N	\N
State Fair	\N	\N	\N	\N
Barrymore	\N	\N	\N	\N
Closer	\N	\N	\N	\N
The Dinner Party	\N	\N	\N	\N
Fortune's Fool	\N	\N	\N	\N
Amour	\N	\N	\N	\N
In My Life	\N	\N	\N	\N
Festen	\N	\N	\N	\N
The Vertical Hour	\N	\N	\N	\N
Deuce	\N	\N	\N	\N
The Farnsworth Invention	\N	\N	\N	\N
Superior Donuts	\N	\N	\N	\N
Lend Me a Tenor	\N	\N	\N	\N
Jerusalem	\N	\N	\N	\N
One Man, Two Guvnors	\N	\N	\N	\N
Dead Accounts	\N	\N	\N	\N
The Heidi Chronicles	\N	\N	\N	\N
King Charles III	\N	\N	\N	\N
Shuffle Along, or, the Making of the Musical Sensation of 1921 and All That Followed	\N	\N	\N	\N
Dear Evan Hansen	\N	\N	\N	\N
Walking with Ghosts	\N	\N	\N	\N
Suffs	\N	\N	\N	\N
The Picture of Dorian Gray	\N	\N	\N	\N
Art	\N	\N	\N	\N
Whose Life Is It Anyway?	\N	\N	\N	\N
One Night Stand	\N	\N	\N	\N
Lena Horne: The Lady and Her Music	\N	\N	\N	\N
84 Charing Cross Road	\N	\N	\N	\N
Teaneck Tanzi: The Venus Flytrap	\N	\N	\N	\N
Amen Corner	\N	\N	\N	\N
Robert Klein on Broadway	\N	\N	\N	\N
Raggedy Ann	\N	\N	\N	\N
Our Country's Good	\N	\N	\N	\N
Rent	\N	\N	\N	\N
Brighton Beach Memoirs	\N	\N	\N	\N
Million Dollar Quartet	\N	\N	\N	\N
Newsies	\N	\N	\N	\N
Honeymoon in Vegas	\N	\N	\N	\N
Amazing Grace	\N	\N	\N	\N
Disaster!	\N	\N	\N	\N
War Paint	\N	\N	\N	\N
Pretty Woman: The Musical	\N	\N	\N	\N
Kristin Chenoweth: For The Girls	\N	\N	\N	\N
Harry Connick, Jr.: A Celebration of Cole Porter	\N	\N	\N	\N
The Lehman Trilogy	\N	\N	\N	\N
Mr. Saturday Night	\N	\N	\N	\N
Shucked	\N	\N	\N	\N
The Who's Tommy	\N	\N	\N	\N
Redwood	\N	\N	\N	\N
Biloxi Blues	\N	\N	\N	\N
Into the Light	\N	\N	\N	\N
Mort Sahlon Broadway!	\N	\N	\N	\N
Breaking the Code	\N	\N	\N	\N
Kenny Logginson Broadway	\N	\N	\N	\N
Orpheus Descending	\N	\N	\N	\N
Jackie Mason: Brand New	\N	\N	\N	\N
Jake's Women	\N	\N	\N	\N
Cyrano: The Musical	\N	\N	\N	\N
The Rise and Fall of Little Voice	\N	\N	\N	\N
Basiaon Broadway	\N	\N	\N	\N
Laurie Andersonon Broadway: The Nerve Bible	\N	\N	\N	\N
Danny Ganson Broadway: The Man of Many Voices	\N	\N	\N	\N
Swan Lake	\N	\N	\N	\N
Natalie Merchant	\N	\N	\N	\N
Elaine Stritch at Liberty	\N	\N	\N	\N
Hairspray	\N	\N	\N	\N
Harry Connick Jr.: In Concert on Broadway	\N	\N	\N	\N
Catch Me If You Can	\N	\N	\N	\N
Scandalous	\N	\N	\N	\N
Big Fish	\N	\N	\N	\N
All the Way	\N	\N	\N	\N
The Last Ship	\N	\N	\N	\N
Gigi	\N	\N	\N	\N
The Illusionists: Live on Broadway	\N	\N	\N	\N
Cats	\N	\N	\N	\N
Angels in America	\N	\N	\N	\N
The Illusionists: Magic of the Holidays	\N	\N	\N	\N
MJ the Musical	\N	\N	\N	\N
Whoop-Dee-Doo	\N	\N	\N	\N
Mother Goose	\N	\N	\N	\N
The Two Orphans	\N	\N	\N	\N
She Stoops to Conquer	\N	\N	\N	\N
Forty-five Minutes from Broadway	\N	\N	\N	\N
Peer Gynt	\N	\N	\N	\N
The Silver Star	\N	\N	\N	\N
Madame X	\N	\N	\N	\N
The Pink Lady	\N	\N	\N	\N
Ben-Hur	\N	\N	\N	\N
The Count of Luxembourg	\N	\N	\N	\N
Oh! Oh! Delphine	\N	\N	\N	\N
Sweethearts	\N	\N	\N	\N
Watch Your Step	\N	\N	\N	\N
The Girl Behind the Gun	\N	\N	\N	\N
Sally	\N	\N	\N	\N
Sunny	\N	\N	\N	\N
Trelawny of the 'Wells'	\N	\N	\N	\N
Rosalie	\N	\N	\N	\N
Whoopee	\N	\N	\N	\N
The Band Wagon	\N	\N	\N	\N
Face the Music	\N	\N	\N	\N
Roberta	\N	\N	\N	\N
Revenge with Music	\N	\N	\N	\N
George White's Scandals	\N	\N	\N	\N
King David	\N	\N	\N	\N
Mary Poppins	\N	\N	\N	\N
Aladdin	\N	\N	\N	\N
Henry, Sweet Henry	\N	\N	\N	\N
George M!	\N	\N	\N	\N
Applause	\N	\N	\N	\N
Cyrano	\N	\N	\N	\N
Bette Midler	\N	\N	\N	\N
Lorelei	\N	\N	\N	\N
Goodtime Charley	\N	\N	\N	\N
Home Sweet Homer	\N	\N	\N	\N
Shirley MacLaine Live at the Palace	\N	\N	\N	\N
An Evening with Diana Ross	\N	\N	\N	\N
The Grand Tour	\N	\N	\N	\N
Woman of the Year	\N	\N	\N	\N
The Will Rogers Follies	\N	\N	\N	\N
Minnelli on Minnelli: Live at the Palace	\N	\N	\N	\N
Aida	\N	\N	\N	\N
All Shook Up	\N	\N	\N	\N
Lestat	\N	\N	\N	\N
Legally Blonde	\N	\N	\N	\N
Liza's at The Palace....	\N	\N	\N	\N
Priscilla Queen of the Desert	\N	\N	\N	\N
Holler If Ya Hear Me	\N	\N	\N	\N
The Temptationsand theFour Topson Broadway	\N	\N	\N	\N
An American in Paris	\N	\N	\N	\N
The Illusionists: Turn of the Century	\N	\N	\N	\N
SpongeBob SquarePants	\N	\N	\N	\N
Ben Platt: Live at the Palace	\N	\N	\N	\N
Tammy Faye	\N	\N	\N	\N
The Lost Boys	\N	\N	\N	\N
Lost in Yonkers	\N	\N	\N	\N
Laughter on the 23rd Floor	\N	\N	\N	\N
Steel Pier	\N	\N	\N	\N
Footloose	\N	\N	\N	\N
Seussical	\N	\N	\N	\N
45 Seconds from Broadway	\N	\N	\N	\N
Movin' Out	\N	\N	\N	\N
Tarzan	\N	\N	\N	\N
In The Heights	\N	\N	\N	\N
Bengal Tiger at the Baghdad Zoo	\N	\N	\N	\N
Lewis Black: Running on Empty	\N	\N	\N	\N
The Rascals: Once Upon a Dream	\N	\N	\N	\N
If/Then	\N	\N	\N	\N
Hamilton	\N	\N	\N	\N
Diplomacy	\N	\N	\N	\N
Billie	\N	\N	\N	\N
The Rivals	\N	\N	\N	\N
Fine and Dandy	\N	\N	\N	\N
The Chocolate Soldier	\N	\N	\N	\N
The Geisha	\N	\N	\N	\N
The Chimes of Normandy	\N	\N	\N	\N
Naughty Marietta	\N	\N	\N	\N
The Firefly	\N	\N	\N	\N
The Gondoliers	\N	\N	\N	\N
Robin Hood	\N	\N	\N	\N
Walk a Little Faster	\N	\N	\N	\N
Ballet Russe de Monte-Carlo	\N	\N	\N	\N
Thumbs Up!	\N	\N	\N	\N
May Wine	\N	\N	\N	\N
Love from a Stranger	\N	\N	\N	\N
Richard II	\N	\N	\N	\N
Father Malachy's Miracle	\N	\N	\N	\N
King Henry IV, Part 1	\N	\N	\N	\N
Earl Carroll's Vanities (1940)	\N	\N	\N	\N
Twelfth Night	\N	\N	\N	\N
Without Love	\N	\N	\N	\N
Li'l Abner	\N	\N	\N	\N
Becket	\N	\N	\N	\N
Do Re Mi	\N	\N	\N	\N
Subways Are for Sleeping	\N	\N	\N	\N
Mr. President	\N	\N	\N	\N
Two Gentlemen of Verona	\N	\N	\N	\N
Good News	\N	\N	\N	\N
Music Is	\N	\N	\N	\N
Vieux Carre	\N	\N	\N	\N
On the Twentieth Century	\N	\N	\N	\N
Carmelina	\N	\N	\N	\N
The 1940's Radio Hour	\N	\N	\N	\N
Filumena	\N	\N	\N	\N
Barnum	\N	\N	\N	\N
Rock 'N Roll! The First 5,000 Years	\N	\N	\N	\N
My One and Only	\N	\N	\N	\N
Jerry's Girls	\N	\N	\N	\N
The Secret Garden	\N	\N	\N	\N
High Society	\N	\N	\N	\N
The Civil War	\N	\N	\N	\N
Swing!	\N	\N	\N	\N
The Producers	\N	\N	\N	\N
Desire Under the Elms	\N	\N	\N	\N
Finian's Rainbow	\N	\N	\N	\N
American Idiot	\N	\N	\N	\N
On a Clear Day You Can See Forever	\N	\N	\N	\N
Leap of Faith	\N	\N	\N	\N
Bring It On: The Musical	\N	\N	\N	\N
Barry Manilow - "Manilow on Broadway: Live at the St. James"	\N	\N	\N	\N
Let It Be	\N	\N	\N	\N
Bullets Over Broadway	\N	\N	\N	\N
Something Rotten!	\N	\N	\N	\N
Springsteen on Broadway	\N	\N	\N	\N
David Byrne's American Utopia	\N	\N	\N	\N
New York, New York	\N	\N	\N	\N
Spamalot	\N	\N	\N	\N
Illinoise	\N	\N	\N	\N
Trisha Paytas' Big Broadway Dream	\N	\N	\N	\N
The Queen of Versailles	\N	\N	\N	\N
Loose Ankles	\N	\N	\N	\N
Old Bill, M.P.	\N	\N	\N	\N
The Marquise	\N	\N	\N	\N
Pleasure Man	\N	\N	\N	\N
The Nut Farm	\N	\N	\N	\N
Carry Nation	\N	\N	\N	\N
The Family Upstairs	\N	\N	\N	\N
Triple-A Plowed Under	\N	\N	\N	\N
Brother Rat	\N	\N	\N	\N
See My Lawyer	\N	\N	\N	\N
The Unconquered	\N	\N	\N	\N
Jupiter Laughs	\N	\N	\N	\N
Kiss and Tell	\N	\N	\N	\N
No Exit	\N	\N	\N	\N
The Silver Whistle	\N	\N	\N	\N
Billy Budd	\N	\N	\N	\N
Take Her, She's Mine	\N	\N	\N	\N
Andorra	\N	\N	\N	\N
The Ninety Day Mistress	\N	\N	\N	\N
Staircase	\N	\N	\N	\N
Knock Knock	\N	\N	\N	\N
The Robber Bridegroom	\N	\N	\N	\N
The Effect of Gamma Rays on Man-in-the-Moon Marigolds	\N	\N	\N	\N
Nuts	\N	\N	\N	\N
The American Clock	\N	\N	\N	\N
A Talent for Murder	\N	\N	\N	\N
Whodunnit	\N	\N	\N	\N
Doonesbury	\N	\N	\N	\N
The Violet Hour	\N	\N	\N	\N
Sight Unseen	\N	\N	\N	\N
Reckless	\N	\N	\N	\N
Brooklyn Boy	\N	\N	\N	\N
After the Night and the Music	\N	\N	\N	\N
Rabbit Hole	\N	\N	\N	\N
Shining City	\N	\N	\N	\N
Translations	\N	\N	\N	\N
LoveMusik	\N	\N	\N	\N
Mauritius	\N	\N	\N	\N
Top Girls	\N	\N	\N	\N
To Be or Not To Be	\N	\N	\N	\N
The American Plan	\N	\N	\N	\N
Accent on Youth	\N	\N	\N	\N
The Royal Family	\N	\N	\N	\N
Collected Stories	\N	\N	\N	\N
The Pitmen Painters	\N	\N	\N	\N
Good People	\N	\N	\N	\N
Wit	\N	\N	\N	\N
The Columnist	\N	\N	\N	\N
The Other Place	\N	\N	\N	\N
The Assembled Parties	\N	\N	\N	\N
The Snow Geese	\N	\N	\N	\N
Outside Mullingar	\N	\N	\N	\N
Casa Valentina	\N	\N	\N	\N
The Country House	\N	\N	\N	\N
Constellations	\N	\N	\N	\N
Airline Highway	\N	\N	\N	\N
Fool for Love	\N	\N	\N	\N
Our Mother's Brief Affair	\N	\N	\N	\N
Heisenberg	\N	\N	\N	\N
Jitney	\N	\N	\N	\N
Prince of Broadway	\N	\N	\N	\N
The Children	\N	\N	\N	\N
The Nap	\N	\N	\N	\N
Choir Boy	\N	\N	\N	\N
Ink	\N	\N	\N	\N
The Height of the Storm	\N	\N	\N	\N
Lackawanna Blues	\N	\N	\N	\N
Skeleton Crew	\N	\N	\N	\N
How I Learned to Drive	\N	\N	\N	\N
Cost of Living	\N	\N	\N	\N
The Collaboration	\N	\N	\N	\N
Summer, 1976	\N	\N	\N	\N
Jaja's African Hair Braiding	\N	\N	\N	\N
Prayer for the French Republic	\N	\N	\N	\N
Mary Jane	\N	\N	\N	\N
Eureka Day	\N	\N	\N	\N
Stephen Sondheim's Old Friends	\N	\N	\N	\N
To-Night's the Night	\N	\N	\N	\N
Trilby	\N	\N	\N	\N
If I Were King	\N	\N	\N	\N
Love O' Mike	\N	\N	\N	\N
Eileen	\N	\N	\N	\N
Her Soldier Boy	\N	\N	\N	\N
The Copperhead	\N	\N	\N	\N
Sometime	\N	\N	\N	\N
Oh, What A Girl!	\N	\N	\N	\N
The Blue Flame	\N	\N	\N	\N
Greenwich Village Follies	\N	\N	\N	\N
The Hotel Mouse	\N	\N	\N	\N
Red Pepper	\N	\N	\N	\N
Sky High	\N	\N	\N	\N
Princess Ida	\N	\N	\N	\N
Countess Maritza	\N	\N	\N	\N
And So To Bed	\N	\N	\N	\N
Harry Delmar's Revels	\N	\N	\N	\N
The Five O'Clock Girl	\N	\N	\N	\N
The Street Singer	\N	\N	\N	\N
Symphony in Two Flats	\N	\N	\N	\N
The Last Enemy	\N	\N	\N	\N
Peter Ibbetson	\N	\N	\N	\N
Everybody's Welcome	\N	\N	\N	\N
Smiling Faces	\N	\N	\N	\N
Dodsworth	\N	\N	\N	\N
Escape Me Never	\N	\N	\N	\N
Rosmersholm	\N	\N	\N	\N
Love on the Dole	\N	\N	\N	\N
Idiot's Delight	\N	\N	\N	\N
Amphitryon 38	\N	\N	\N	\N
I Married an Angel	\N	\N	\N	\N
The Philadelphia Story	\N	\N	\N	\N
Higher and Higher	\N	\N	\N	\N
Hold On to Your Hats	\N	\N	\N	\N
The Doctor's Dilemma	\N	\N	\N	\N
Candle in the Wind	\N	\N	\N	\N
By Jupiter	\N	\N	\N	\N
The Vagabond King	\N	\N	\N	\N
Catherine Was Great	\N	\N	\N	\N
Bloomer Girl	\N	\N	\N	\N
Are You with It?	\N	\N	\N	\N
Park Avenue	\N	\N	\N	\N
Under the Counter	\N	\N	\N	\N
The First Mrs. Fraser	\N	\N	\N	\N
Anne of the Thousand Days	\N	\N	\N	\N
I Know My Love	\N	\N	\N	\N
Jose Greco Ballet	\N	\N	\N	\N
Paint Your Wagon	\N	\N	\N	\N
The Millionairess	\N	\N	\N	\N
Pipe Dream	\N	\N	\N	\N
Bells Are Ringing	\N	\N	\N	\N
Whoop-Up	\N	\N	\N	\N
Take Me Along	\N	\N	\N	\N
Bye Bye Birdie	\N	\N	\N	\N
The Gay Life	\N	\N	\N	\N
Here's Love	\N	\N	\N	\N
The Roar of the Greasepaint - The Smell of the Crowd	\N	\N	\N	\N
Ivanov	\N	\N	\N	\N
The Apple Tree	\N	\N	\N	\N
Golden Rainbow	\N	\N	\N	\N
An Evening with Richard Nixon	\N	\N	\N	\N
The Creation of the World and Other Business	\N	\N	\N	\N
Over Here!	\N	\N	\N	\N
The Constant Wife	\N	\N	\N	\N
Buddy - The Buddy Holly Story	\N	\N	\N	\N
Crazy for You	\N	\N	\N	\N
Big	\N	\N	\N	\N
A Wonderful Life	\N	\N	\N	\N
Memphis	\N	\N	\N	\N
Matilda the Musical	\N	\N	\N	\N
To Kill a Mockingbird	\N	\N	\N	\N
POTUS	\N	\N	\N	\N
Some Like It Hot	\N	\N	\N	\N
Hell's Kitchen	\N	\N	\N	\N
Anything Goes	\N	\N	\N	\N
The Trip to Bountiful	\N	\N	\N	\N
Beautiful: The Carole King Musical	\N	\N	\N	\N
Mrs. Doubtfire	\N	\N	\N	\N
& Juliet	\N	\N	\N	\N
Assassins	\N	\N	\N	\N
Pacific Overtures	\N	\N	\N	\N
A Touch of the Poet	\N	\N	\N	\N
Wishful Drinking	\N	\N	\N	\N
Sondheim on Sondheim	\N	\N	\N	\N
Brief Encounter	\N	\N	\N	\N
The People in the Picture	\N	\N	\N	\N
Harvey	\N	\N	\N	\N
Therèse Raquin	\N	\N	\N	\N
Holiday Inn	\N	\N	\N	\N
Sweat	\N	\N	\N	\N
Latin History for Morons	\N	\N	\N	\N
The Lifespan of a Fact	\N	\N	\N	\N
The Sound Inside	\N	\N	\N	\N
Pictures from Home	\N	\N	\N	\N
Days of Wine and Roses	\N	\N	\N	\N
A Wonderful World	\N	\N	\N	\N
Call Me Izzy	\N	\N	\N	\N
Oedipus	\N	\N	\N	\N
An Almost Holy Picture	\N	\N	\N	\N
The Man Who Had All the Luck	\N	\N	\N	\N
An Evening with Mario Cantone	\N	\N	\N	\N
The Boys from Syracuse	\N	\N	\N	\N
As Long As We Both Shall Laugh	\N	\N	\N	\N
After the Fall	\N	\N	\N	\N
Twelve Angry Men	\N	\N	\N	\N
A Naked Girl on the Appian Way	\N	\N	\N	\N
Prelude to a Kiss	\N	\N	\N	\N
A Man for All Seasons	\N	\N	\N	\N
After Miss Julie	\N	\N	\N	\N
Everyday Rapture	\N	\N	\N	\N
Mrs. Warren's Profession	\N	\N	\N	\N
The Road to Mecca	\N	\N	\N	\N
Don't Dress for Dinner	\N	\N	\N	\N
The Big Knife	\N	\N	\N	\N
The Winslow Boy	\N	\N	\N	\N
Machinal	\N	\N	\N	\N
Violet	\N	\N	\N	\N
Old Times	\N	\N	\N	\N
The Price	\N	\N	\N	\N
Marvin's Room	\N	\N	\N	\N
Time and the Conways	\N	\N	\N	\N
John Lithgow: Stories by Heart	\N	\N	\N	\N
Bernhardt/Hamlet	\N	\N	\N	\N
A Soldier's Play	\N	\N	\N	\N
Trouble in Mind	\N	\N	\N	\N
Birthday Candles	\N	\N	\N	\N
Fat Ham	\N	\N	\N	\N
I Need That	\N	\N	\N	\N
Doubt	\N	\N	\N	\N
Home	\N	\N	\N	\N
Yellow Face	\N	\N	\N	\N
English	\N	\N	\N	\N
Pirates! The Penzance Musical	\N	\N	\N	\N
Danton's Death	\N	\N	\N	\N
The Country Wife	\N	\N	\N	\N
The Condemned of Altona	\N	\N	\N	\N
The Caucasian Chalk Circle	\N	\N	\N	\N
The Alchemist	\N	\N	\N	\N
Yerma	\N	\N	\N	\N
Galileo	\N	\N	\N	\N
The Unknown Soldier and His Wife	\N	\N	\N	\N
Tiger at the Gates	\N	\N	\N	\N
George Dandin	\N	\N	\N	\N
A Cry of Players	\N	\N	\N	\N
Camino Real	\N	\N	\N	\N
Operation Sidewinder	\N	\N	\N	\N
The Good Woman of Setzuan	\N	\N	\N	\N
The Playboy of the Western World	\N	\N	\N	\N
Narrow Road to the Deep North	\N	\N	\N	\N
Enemies	\N	\N	\N	\N
In the Boom Boom Room	\N	\N	\N	\N
Short Eyes	\N	\N	\N	\N
Trelawny of the "Wells"	\N	\N	\N	\N
Agamemnon	\N	\N	\N	\N
The Floating Light Bulb	\N	\N	\N	\N
La Tragedie de Carmen	\N	\N	\N	\N
The Flying Karamazov Brothers	\N	\N	\N	\N
The House of Blue Leaves	\N	\N	\N	\N
Death and the King's Horseman	\N	\N	\N	\N
The Comedy of Errors	\N	\N	\N	\N
Some Americans Abroad	\N	\N	\N	\N
Monster in a Box	\N	\N	\N	\N
My Favorite Year	\N	\N	\N	\N
Abe Lincoln in Illinois	\N	\N	\N	\N
Gray's Anatomy	\N	\N	\N	\N
Racing Demon	\N	\N	\N	\N
Juan Darien: A Carnival Mass	\N	\N	\N	\N
Marie Christine	\N	\N	\N	\N
Contact	\N	\N	\N	\N
QED	\N	\N	\N	\N
Henry IV, Part 1andPart 2	\N	\N	\N	\N
The Frogs	\N	\N	\N	\N
The Light in the Piazza	\N	\N	\N	\N
The Coast of Utopia	\N	\N	\N	\N
Cymbeline	\N	\N	\N	\N
A Free Man of Color	\N	\N	\N	\N
War Horse	\N	\N	\N	\N
Act One	\N	\N	\N	\N
Oslo	\N	\N	\N	\N
Junk	\N	\N	\N	\N
Flying Over Sunset	\N	\N	\N	\N
The Skin of Our Teeth	\N	\N	\N	\N
Mike Birbiglia: The Old Man and the Pool	\N	\N	\N	\N
Mcneal	\N	\N	\N	\N
Floyd Collins	\N	\N	\N	\N
I Hate Hamlet	\N	\N	\N	\N
Two Trains Running	\N	\N	\N	\N
Angels in America[e]	\N	\N	\N	\N
Love! Valour! Compassion!	\N	\N	\N	\N
Patti LuPoneon Broadway[205][206]	\N	\N	\N	\N
Seven Guitars	\N	\N	\N	\N
The Beauty Queen of Leenane	\N	\N	\N	\N
The Weir	\N	\N	\N	\N
Proof	\N	\N	\N	\N
Gem of the Ocean	\N	\N	\N	\N
Doubt: A Parable	\N	\N	\N	\N
Grey Gardens	\N	\N	\N	\N
A Catered Affair	\N	\N	\N	\N
Irena's Vow	\N	\N	\N	\N
Lysistrata Jones	\N	\N	\N	\N
Clybourne Park	\N	\N	\N	\N
The Testament of Mary	\N	\N	\N	\N
A Gentleman's Guide to Love and Murder	\N	\N	\N	\N
Amelie	\N	\N	\N	\N
Hadestown	\N	\N	\N	\N
La Belle Paree	\N	\N	\N	\N
Vera Violetta	\N	\N	\N	\N
Robinson Crusoe, Jr.	\N	\N	\N	\N
Sinbad	\N	\N	\N	\N
Monte Cristo, Jr.	\N	\N	\N	\N
Broadway Brevities of 1920	\N	\N	\N	\N
The Whirl of New York	\N	\N	\N	\N
Make It Snappy	\N	\N	\N	\N
Greenwich Village Follies of 1923	\N	\N	\N	\N
Bombo	\N	\N	\N	\N
Innocent Eyes	\N	\N	\N	\N
Greenwich Village Follies of 1924	\N	\N	\N	\N
Big Boy	\N	\N	\N	\N
Artists and Models of 1925	\N	\N	\N	\N
The Circus Princess	\N	\N	\N	\N
A Night in Spain	\N	\N	\N	\N
Artists and Models of 1927	\N	\N	\N	\N
Greenwich Village Follies of 1928	\N	\N	\N	\N
Ziegfeld Follies of 1934	\N	\N	\N	\N
Life Begins at 8:40	\N	\N	\N	\N
Ziegfeld Follies of 1936	\N	\N	\N	\N
Hooray for What!	\N	\N	\N	\N
You Never Know	\N	\N	\N	\N
Sons o' Fun	\N	\N	\N	\N
Ziegfeld Follies of 1943	\N	\N	\N	\N
Laffing Room Only	\N	\N	\N	\N
Alive and Kicking	\N	\N	\N	\N
Make a Wish	\N	\N	\N	\N
Top Banana	\N	\N	\N	\N
My Darlin' Aida	\N	\N	\N	\N
Plain and Fancy	\N	\N	\N	\N
The Vamp	\N	\N	\N	\N
Tamburlaine The Great	\N	\N	\N	\N
Shangri-La	\N	\N	\N	\N
Ziegfeld Follies of 1957	\N	\N	\N	\N
Juno	\N	\N	\N	\N
Saratoga	\N	\N	\N	\N
The Unsinkable Molly Brown	\N	\N	\N	\N
All American	\N	\N	\N	\N
The Lady of the Camellias	\N	\N	\N	\N
Jimmy!	\N	\N	\N	\N
Georgy	\N	\N	\N	\N
Ulysses in Nighttown	\N	\N	\N	\N
Doctor Jazz	\N	\N	\N	\N
Zoot Suit	\N	\N	\N	\N
Gilda Radner: Live From New York	\N	\N	\N	\N
The Catherine Wheel	\N	\N	\N	\N
Rocky the Musical	\N	\N	\N	\N
Wolf Hall Parts One & Two	\N	\N	\N	\N
School of Rock	\N	\N	\N	\N
Back to the Future: The Musical	\N	\N	\N	\N
Good Night, and Good Luck	\N	\N	\N	\N
\.


--
-- Data for Name: design_work; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.design_work (architect_id, theatre_name) FROM stdin;
1	Al Hirschfeld Theatre
2	Al Hirschfeld Theatre
3	Ambassador Theatre (Broadway)
4	August Wilson Theatre
5	August Wilson Theatre
6	Belasco Theatre (Broadway)
3	Bernard B. Jacobs Theatre
7	Booth Theatre
3	Broadhurst Theatre
8	Broadway Theatre (53rd Street)
9	Circle in the Square Theatre
10	Circle in the Square Theatre
3	Ethel Barrymore Theatre
3	Eugene O'Neill Theatre
3	Gerald Schoenfeld Theatre
11	Gershwin Theatre
12	Hayes Theater
13	Hudson Theatre
3	Imperial Theatre
14	James Earl Jones Theatre
3	John Golden Theatre
3	Lena Horne Theatre
7	Longacre Theatre
15	Lunt-Fontanne Theatre
16	Lyceum Theatre (Broadway)
17	Lyric Theatre (New York City, 1998)
18	Lyric Theatre (New York City, 1998)
3	Majestic Theatre (Broadway)
19	Marquis Theatre
20	Minskoff Theatre
4	Music Box Theatre
21	Nederlander Theatre
3	Neil Simon Theatre
16	New Amsterdam Theatre
22	Palace Theatre (New York City)
3	Richard Rodgers Theatre
23	St. James Theatre
3	Samuel J. Friedman Theatre
7	Shubert Theatre (Broadway)
8	Studio 54
6	Todd Haimes Theatre
24	Vivian Beaumont Theater
25	Vivian Beaumont Theater
3	Walter Kerr Theatre
26	Winter Garden Theatre
3	Winter Garden Theatre
12	Stephen Sondheim Theatre
27	Stephen Sondheim Theatre
\.


--
-- Data for Name: former_existing_theatre; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.former_existing_theatre (theatre_name, last_opened, current_use) FROM stdin;
Edison Theatre	1991	Event space
Ed Sullivan Theater	1936	Television studio
Empire Theatre (42nd Street)	1931	Movie theater
Liberty Theatre	1933	Event space
New Victory Theater	1930	Off-BroadwayTheatre for Young Audiences
Sony Hall	1982	Concert venue
Mark Hellinger Theatre	1989	Nondenominational church
Times Square Theater	1933	vacant
\.


--
-- Data for Name: organization; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.organization (company_name, company_type) FROM stdin;
ATG Entertainment	\N
Shubert Organization	\N
Independent	\N
Nederlander Organization	\N
Second Stage Theater	\N
Disney Theatrical Group	\N
Manhattan Theatre Club	\N
Roundabout Theatre Company	\N
Lincoln Center Theater	\N
Hotel Edison	\N
CBS	\N
AMC Theatres	\N
Liberty Theater Catering & Events	\N
New 42nd Street	\N
Blue Note Entertainment Group	\N
Times Square Church	\N
\.


--
-- Data for Name: production; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.production (show_title, theatre_name, opening_year) FROM stdin;
Wonderful Town	Al Hirschfeld Theatre	2003
Sweet Charity	Al Hirschfeld Theatre	2005
The Wedding Singer	Al Hirschfeld Theatre	2006
Curtains	Al Hirschfeld Theatre	2007
A Tale of Two Cities	Al Hirschfeld Theatre	2008
Hair	Al Hirschfeld Theatre	2009
Elf the Musical	Al Hirschfeld Theatre	2010
How to Succeed in Business Without Really Trying	Al Hirschfeld Theatre	2011
Fela!	Al Hirschfeld Theatre	2012
Elf the Musical	Al Hirschfeld Theatre	2012
Kinky Boots	Al Hirschfeld Theatre	2013
Moulin Rouge!	Al Hirschfeld Theatre	2019
Blossom Time	Ambassador Theatre (Broadway)	1921
The Dream Girl	Ambassador Theatre (Broadway)	1924
Candida	Ambassador Theatre (Broadway)	1925
The Student Prince	Ambassador Theatre (Broadway)	1925
The Great Gatsby	Ambassador Theatre (Broadway)	1926
The Racket	Ambassador Theatre (Broadway)	1927
The Outsider	Ambassador Theatre (Broadway)	1928
Redemption	Ambassador Theatre (Broadway)	1928
Little Accident	Ambassador Theatre (Broadway)	1929
Street Scene	Ambassador Theatre (Broadway)	1929
The Last Mile	Ambassador Theatre (Broadway)	1930
Six Shakespeare plays	Ambassador Theatre (Broadway)	1930
Death Takes a Holiday	Ambassador Theatre (Broadway)	1931
Blossom Time	Ambassador Theatre (Broadway)	1931
Young Sinners	Ambassador Theatre (Broadway)	1933
June Moon	Ambassador Theatre (Broadway)	1933
Biography	Ambassador Theatre (Broadway)	1934
Night of January 16th	Ambassador Theatre (Broadway)	1935
Mulatto	Ambassador Theatre (Broadway)	1936
EightAbbey Theatreplays	Ambassador Theatre (Broadway)	1937
You Can't Take It with You	Ambassador Theatre (Broadway)	1938
The Straw Hat Revue	Ambassador Theatre (Broadway)	1939
TenGilbert and Sullivanplays	Ambassador Theatre (Broadway)	1944
The Diary of Anne Frank	Ambassador Theatre (Broadway)	1957
Compulsion	Ambassador Theatre (Broadway)	1957
Back to Methuselah	Ambassador Theatre (Broadway)	1958
The 49th Cousin	Ambassador Theatre (Broadway)	1960
The Tenth Man	Ambassador Theatre (Broadway)	1961
Blood, Sweat and Stanley Poole	Ambassador Theatre (Broadway)	1961
Something About a Soldier	Ambassador Theatre (Broadway)	1962
A Passage to India	Ambassador Theatre (Broadway)	1962
Stop the World - I Want to Get Off	Ambassador Theatre (Broadway)	1963
The World of Charles Aznavour	Ambassador Theatre (Broadway)	1965
The Lion in Winter	Ambassador Theatre (Broadway)	1966
The Investigation	Ambassador Theatre (Broadway)	1966
You Know I Can't Hear You When the Water's Running	Ambassador Theatre (Broadway)	1967
We Bombed in New Haven	Ambassador Theatre (Broadway)	1968
Celebration	Ambassador Theatre (Broadway)	1969
The Boy Friend	Ambassador Theatre (Broadway)	1970
Paul Sills' Story Theatre	Ambassador Theatre (Broadway)	1970
Ain't Supposed to Die a Natural Death	Ambassador Theatre (Broadway)	1971
Warp!	Ambassador Theatre (Broadway)	1973
Scapino	Ambassador Theatre (Broadway)	1974
We Interrupt This Program...	Ambassador Theatre (Broadway)	1975
Me and Bessie	Ambassador Theatre (Broadway)	1975
Des Journees Entières Dans les Arbres	Ambassador Theatre (Broadway)	1976
Godspell	Ambassador Theatre (Broadway)	1977
Miss Margarida's Way	Ambassador Theatre (Broadway)	1977
Same Time, Next Year	Ambassador Theatre (Broadway)	1978
Eubie!	Ambassador Theatre (Broadway)	1978
Your Arms Too Short to Box with God	Ambassador Theatre (Broadway)	1980
Dancin'	Ambassador Theatre (Broadway)	1980
Herman Van Veen: All of Him	Ambassador Theatre (Broadway)	1982
A View from the Bridge	Ambassador Theatre (Broadway)	1983
Leader of the Pack	Ambassador Theatre (Broadway)	1985
Barbara Cook: A Concert for the Theatre	Ambassador Theatre (Broadway)	1987
Dreamgirls	Ambassador Theatre (Broadway)	1987
Ain't Misbehavin'	Ambassador Theatre (Broadway)	1988
The Circle	Ambassador Theatre (Broadway)	1989
Fool Moon	Ambassador Theatre (Broadway)	1995
Bring in 'da Noise, Bring in 'da Funk	Ambassador Theatre (Broadway)	1996
You're a Good Man, Charlie Brown	Ambassador Theatre (Broadway)	1999
It Ain't Nothin' But the Blues	Ambassador Theatre (Broadway)	1999
The Ride Down Mt. Morgan	Ambassador Theatre (Broadway)	2000
A Class Act	Ambassador Theatre (Broadway)	2001
Hedda Gabler	Ambassador Theatre (Broadway)	2001
Topdog/Underdog	Ambassador Theatre (Broadway)	2002
Chicago	Ambassador Theatre (Broadway)	2003
Alice in Wonderland	August Wilson Theatre	1982
On Your Toes	August Wilson Theatre	1983
Execution of Justice	August Wilson Theatre	1986
Wild Honey	August Wilson Theatre	1986
The Mikado	August Wilson Theatre	1987
Carrie	August Wilson Theatre	1988
Run for Your Wife	August Wilson Theatre	1989
Shenandoah	August Wilson Theatre	1989
City of Angels	August Wilson Theatre	1989
Jelly's Last Jam	August Wilson Theatre	1992
My Fair Lady	August Wilson Theatre	1993
Smokey Joe's Cafe	August Wilson Theatre	1995
The Wild Party	August Wilson Theatre	2000
Gore Vidal's The Best Man	August Wilson Theatre	2000
King Hedley II	August Wilson Theatre	2001
The Crucible	August Wilson Theatre	2002
Flower Drum Song	August Wilson Theatre	2002
Bill Maher: Victory Begins At Home	August Wilson Theatre	2003
Little Shop of Horrors	August Wilson Theatre	2003
Little Women	August Wilson Theatre	2005
A Grand Army Man	Belasco Theatre (Broadway)	1907
The Warrens of Virginia	Belasco Theatre (Broadway)	1908
Just a Wife	Belasco Theatre (Broadway)	1910
The Concert	Belasco Theatre (Broadway)	1910
Seven Chances	Belasco Theatre (Broadway)	1916
Polly With a Past	Belasco Theatre (Broadway)	1917
Deburau	Belasco Theatre (Broadway)	1921
Lulu Belle	Belasco Theatre (Broadway)	1926
Hit the Deck	Belasco Theatre (Broadway)	1927
The Truth About Blayds	Belasco Theatre (Broadway)	1932
Criminal at Large	Belasco Theatre (Broadway)	1932
Awake and Sing!	Belasco Theatre (Broadway)	1935
Waiting for Lefty	Belasco Theatre (Broadway)	1935
Dead End	Belasco Theatre (Broadway)	1935
Golden Boy	Belasco Theatre (Broadway)	1937
Rocket to the Moon	Belasco Theatre (Broadway)	1938
Johnny Belinda	Belasco Theatre (Broadway)	1940
The Man with Blond Hair	Belasco Theatre (Broadway)	1941
Clash by Night	Belasco Theatre (Broadway)	1941
Nathan the Wise	Belasco Theatre (Broadway)	1942
MagicandHello Out There!	Belasco Theatre (Broadway)	1942
Dark Eyes	Belasco Theatre (Broadway)	1943
Kiss Them for Me	Belasco Theatre (Broadway)	1945
Home of the Brave	Belasco Theatre (Broadway)	1945
Truckline Cafe	Belasco Theatre (Broadway)	1946
Lysistrata	Belasco Theatre (Broadway)	1946
Sundown Beach	Belasco Theatre (Broadway)	1947
Me and Molly	Belasco Theatre (Broadway)	1948
The Madwoman of Chaillot	Belasco Theatre (Broadway)	1948
The Flowering Peach	Belasco Theatre (Broadway)	1954
Will Success Spoil Rock Hunter?	Belasco Theatre (Broadway)	1955
Fanny	Belasco Theatre (Broadway)	1956
The First Gentleman	Belasco Theatre (Broadway)	1957
Nude With Violin	Belasco Theatre (Broadway)	1957
Present Laughter	Belasco Theatre (Broadway)	1958
A Raisin in the Sun	Belasco Theatre (Broadway)	1959
All the Way Home	Belasco Theatre (Broadway)	1960
Write Me a Murder	Belasco Theatre (Broadway)	1961
The Seagull	Belasco Theatre (Broadway)	1964
The Crucible	Belasco Theatre (Broadway)	1964
Inadmissible Evidence	Belasco Theatre (Broadway)	1965
The Subject Was Roses	Belasco Theatre (Broadway)	1966
The Killing of Sister George	Belasco Theatre (Broadway)	1966
Dr. Cook's Garden	Belasco Theatre (Broadway)	1967
Don't Drink the Water	Belasco Theatre (Broadway)	1968
Does a Tiger Wear a Necktie?	Belasco Theatre (Broadway)	1969
Oh! Calcutta!	Belasco Theatre (Broadway)	1971
American Buffalo	Belasco Theatre (Broadway)	1977
The Goodbye People	Belasco Theatre (Broadway)	1979
Your Arms Too Short to Box with God	Belasco Theatre (Broadway)	1980
Ain't Misbehavin'	Belasco Theatre (Broadway)	1981
Marcel MarceauOn Broadway	Belasco Theatre (Broadway)	1983
Accidental Death of an Anarchist	Belasco Theatre (Broadway)	1984
Romeo and Juliet	Belasco Theatre (Broadway)	1986
As You Like It	Belasco Theatre (Broadway)	1986
Macbeth	Belasco Theatre (Broadway)	1986
The Speed of Darkness	Belasco Theatre (Broadway)	1991
The Crucible	Belasco Theatre (Broadway)	1991
The Master Builder	Belasco Theatre (Broadway)	1992
Hamlet	Belasco Theatre (Broadway)	1995
A Doll's House	Belasco Theatre (Broadway)	1997
Honour	Belasco Theatre (Broadway)	1998
Ring Round the Moon	Belasco Theatre (Broadway)	1999
James Joyce's The Dead	Belasco Theatre (Broadway)	2000
Follies	Belasco Theatre (Broadway)	2001
Frankie and Johnny in the Clair de Lune	Belasco Theatre (Broadway)	2002
Enchanted April	Belasco Theatre (Broadway)	2003
Dracula, the Musical	Belasco Theatre (Broadway)	2004
Julius Caesar	Belasco Theatre (Broadway)	2005
Awake and Sing!	Belasco Theatre (Broadway)	2006
Journey's End	Belasco Theatre (Broadway)	2007
Passing Strange	Belasco Theatre (Broadway)	2008
American Buffalo	Belasco Theatre (Broadway)	2008
Joe Turner's Come and Gone	Belasco Theatre (Broadway)	2009
Women on the Verge of a Nervous Breakdown	Belasco Theatre (Broadway)	2010
Kathy Griffin Wants a Tony	Belasco Theatre (Broadway)	2011
End of the Rainbow	Belasco Theatre (Broadway)	2012
Golden Boy	Belasco Theatre (Broadway)	2012
Twelfth NightandRichard III	Belasco Theatre (Broadway)	2013
Hedwig and the Angry Inch	Belasco Theatre (Broadway)	2014
Blackbird	Belasco Theatre (Broadway)	2016
The Glass Menagerie	Belasco Theatre (Broadway)	2017
Michael Moore: The Terms of My Surrender	Belasco Theatre (Broadway)	2017
Farinelli and the King	Belasco Theatre (Broadway)	2017
Gettin' the Band Back Together	Belasco Theatre (Broadway)	2018
Network	Belasco Theatre (Broadway)	2018
Girl from the North Country	Belasco Theatre (Broadway)	2020
Ain't No Mo'	Belasco Theatre (Broadway)	2022
Good Night, Oscar	Belasco Theatre (Broadway)	2023
How to Dance in Ohio	Belasco Theatre (Broadway)	2023
Appropriate	Belasco Theatre (Broadway)	2024
Maybe Happy Ending	Belasco Theatre (Broadway)	2024
Three Days of Rain	Bernard B. Jacobs Theatre	2006
Martin Short: Fame Becomes Me	Bernard B. Jacobs Theatre	2006
Frost/Nixon	Bernard B. Jacobs Theatre	2007
Rock 'n' Roll	Bernard B. Jacobs Theatre	2007
The Country Girl	Bernard B. Jacobs Theatre	2008
13	Bernard B. Jacobs Theatre	2008
God of Carnage	Bernard B. Jacobs Theatre	2009
Bloody Bloody Andrew Jackson	Bernard B. Jacobs Theatre	2010
Our Town	Booth Theatre	2002
That Championship Season	Bernard B. Jacobs Theatre	2011
The Mountaintop	Bernard B. Jacobs Theatre	2011
Once	Bernard B. Jacobs Theatre	2012
It's Only a Play	Bernard B. Jacobs Theatre	2015
The Color Purple	Bernard B. Jacobs Theatre	2015
Bandstand	Bernard B. Jacobs Theatre	2017
The Iceman Cometh	Bernard B. Jacobs Theatre	2018
'The Ferryman	Bernard B. Jacobs Theatre	2018
Betrayal	Bernard B. Jacobs Theatre	2019
Company	Bernard B. Jacobs Theatre	2021
Almost Famous	Bernard B. Jacobs Theatre	2022
Parade	Bernard B. Jacobs Theatre	2023
The Outsiders	Bernard B. Jacobs Theatre	2024
The Great Adventure	Booth Theatre	1913
Our American Cousin	Booth Theatre	1915
David Garrick	Booth Theatre	1916
The Co-Respondent	Booth Theatre	1916
Getting Married	Booth Theatre	1916
A Successful Calamity	Booth Theatre	1917
The Woman in Room 13	Booth Theatre	1919
The Better 'Ole	Booth Theatre	1919
Too Many Husbands	Booth Theatre	1919
The Purple Mask	Booth Theatre	1920
The Prince and the Pauper	Booth Theatre	1920
The Green Goddess	Booth Theatre	1921
The Truth About Blayds	Booth Theatre	1922
Seventh Heaven	Booth Theatre	1922
Dancing Mothers	Booth Theatre	1924
Paolo and Francesca	Booth Theatre	1924
The Fall of Eve	Booth Theatre	1925
Hamlet	Booth Theatre	1925
John Gabriel Borkman	Booth Theatre	1926
Escape	Booth Theatre	1927
Uncle Vanya	Booth Theatre	1930
The Man in Possession	Booth Theatre	1930
The Bread-Winner	Booth Theatre	1931
After All	Booth Theatre	1931
If Love Were All	Booth Theatre	1931
Jewel Robbery	Booth Theatre	1932
Another Language	Booth Theatre	1932
For Services Rendered	Booth Theatre	1933
Candide	Booth Theatre	1933
No More Ladies	Booth Theatre	1934
The Shining Hour	Booth Theatre	1934
The Distaff Side	Booth Theatre	1934
Laburnum Grove	Booth Theatre	1935
Kind Lady	Booth Theatre	1935
Lady Precious Stream	Booth Theatre	1936
Swing Your Lady	Booth Theatre	1936
You Can't Take It with You	Booth Theatre	1936
The Time of Your Life	Booth Theatre	1939
The Cream in the Well	Booth Theatre	1941
Claudia	Booth Theatre	1941
Blithe Spirit	Booth Theatre	1942
The Two Mrs. Carrolls	Booth Theatre	1943
The Would-Be Gentleman	Booth Theatre	1946
He Who Gets Slapped	Booth Theatre	1946
Playboy of the Western World	Booth Theatre	1946
John Loves Mary	Booth Theatre	1947
Tenting Tonight	Booth Theatre	1947
Portrait in Black	Booth Theatre	1947
Duet for Two Hands	Booth Theatre	1947
An Inspector Calls	Booth Theatre	1947
The Play's the Thing	Booth Theatre	1948
The Shop at Sly Corner	Booth Theatre	1948
Richard III	Booth Theatre	1949
At War with the Army	Booth Theatre	1949
Come Back, Little Sheba	Booth Theatre	1950
Lace on Her Petticoat	Booth Theatre	1951
An Evening With Beatrice Lillie	Booth Theatre	1952
Late Love	Booth Theatre	1953
Dial M for Murder	Booth Theatre	1954
All Summer Long	Booth Theatre	1954
The Matchmaker	Booth Theatre	1956
Visit to a Small Planet	Booth Theatre	1957
Two for the Seesaw	Booth Theatre	1958
The Tenth Man	Booth Theatre	1959
A Shot in the Dark	Booth Theatre	1961
Rattle of a Simple Man	Booth Theatre	1963
Spoon River Anthology	Booth Theatre	1963
Luv	Booth Theatre	1964
At the Drop of Another Hat	Booth Theatre	1966
The Birthday Party	Booth Theatre	1967
Avanti!	Booth Theatre	1968
Leonard Sillman's New Faces of 1968	Booth Theatre	1968
Butterflies Are Free	Booth Theatre	1969
That Championship Season	Booth Theatre	1972
Bad Habits	Booth Theatre	1974
Brief Lives	Booth Theatre	1974
Very Good Eddie	Booth Theatre	1975
For Colored Girls Who Have Considered Suicide / When the Rainbow Is Enuf	Booth Theatre	1976
Monteith and Rand	Booth Theatre	1979
The Elephant Man	Booth Theatre	1979
An Evening with Dave Allen	Booth Theatre	1981
Mass Appeal	Booth Theatre	1981
Good	Booth Theatre	1982
American Buffalo	Booth Theatre	1983
Sunday in the Park with George	Booth Theatre	1984
I'm Not Rappaport	Booth Theatre	1985
A Walk in the Woods	Booth Theatre	1988
Michael Feinstein in Concert: "Isn't It Romantic"	Booth Theatre	1988
Shirley Valentine	Booth Theatre	1989
Tru	Booth Theatre	1989
Once on This Island	Booth Theatre	1990
The Most Happy Fella	Booth Theatre	1992
Someone Who'll Watch Over Me	Booth Theatre	1992
The Twilight of the Golds	Booth Theatre	1993
Broken Glass	Booth Theatre	1994
A Tuna Christmas	Booth Theatre	1994
Having Our Say	Booth Theatre	1995
The Old Neighborhood	Booth Theatre	1997
An Evening with Jerry Herman	Booth Theatre	1998
I'm Still Here... Damn It!	Booth Theatre	1998
Via Dolorosa	Booth Theatre	1999
The Search for Signs of Intelligent Life in the Universe	Booth Theatre	2000
Bea Arthur on Broadway	Booth Theatre	2001
I'm Not Rappaport	Booth Theatre	2002
The Retreat from Moscow	Booth Theatre	2003
The Pillowman	Booth Theatre	2005
Seascape	Booth Theatre	2006
Faith Healer	Booth Theatre	2006
Butley	Booth Theatre	2006
The Year of Magical Thinking	Booth Theatre	2007
The Seafarer	Booth Theatre	2007
Thurgood	Booth Theatre	2008
Dividing the Estate	Booth Theatre	2008
The Story of My Life	Booth Theatre	2009
Next to Normal	Booth Theatre	2009
High	Booth Theatre	2011
Other Desert Cities	Booth Theatre	2011
Who's Afraid of Virginia Woolf?	Booth Theatre	2012
I'll Eat You Last: A Chat with Sue Mengers	Booth Theatre	2013
The Glass Menagerie	Booth Theatre	2013
The Elephant Man	Booth Theatre	2014
Hand to God	Booth Theatre	2015
Hughie	Booth Theatre	2016
An Act of God	Booth Theatre	2016
Les Liaisons Dangereuses	Booth Theatre	2016
Significant Other	Booth Theatre	2017
The Boys in the Band	Booth Theatre	2018
Gary: A Sequel to Titus Andronicus	Booth Theatre	2019
Freestyle Love Supreme	Booth Theatre	2019
Who's Afraid of Virginia Woolf?	Booth Theatre	2020
Freestyle Love Supreme	Booth Theatre	2021
For Colored Girls Who Have Considered Suicide / When the Rainbow Is Enuf	Booth Theatre	2022
Kimberly Akimbo	Booth Theatre	2022
The Roommate	Booth Theatre	2024
John Proctor is the Villain	Booth Theatre	2025
Little Bear Ridge Road	Booth Theatre	2025
Misalliance	Broadhurst Theatre	1917
Lord and Lady Algy	Broadhurst Theatre	1917
Maytime	Broadhurst Theatre	1918
Ladies First	Broadhurst Theatre	1918
The Melting of Molly	Broadhurst Theatre	1918
39 East	Broadhurst Theatre	1919
Smilin' Through	Broadhurst Theatre	1919
Macbeth	Broadhurst Theatre	1921
The Servant in the House	Broadhurst Theatre	1921
Tarzan of the Apes	Broadhurst Theatre	1921
The Faithful Heart	Broadhurst Theatre	1922
The Dancers	Broadhurst Theatre	1923
Beggar on Horseback	Broadhurst Theatre	1924
The Green Hat	Broadhurst Theatre	1925
Broadway	Broadhurst Theatre	1926
The Merchant of Venice	Broadhurst Theatre	1928
Here's Howe	Broadhurst Theatre	1928
Hold Everything!	Broadhurst Theatre	1928
June Moon	Broadhurst Theatre	1929
America's Sweetheart	Broadhurst Theatre	1931
Hamlet	Broadhurst Theatre	1931
The Animal Kingdom	Broadhurst Theatre	1932
The Man Who Reclaimed His Head	Broadhurst Theatre	1932
Twentieth Century	Broadhurst Theatre	1932
Men in White	Broadhurst Theatre	1933
L'Aiglon	Broadhurst Theatre	1934
The Petrified Forest	Broadhurst Theatre	1935
Victoria Regina	Broadhurst Theatre	1935
Madame Bovary	Broadhurst Theatre	1937
A Doll's House	Broadhurst Theatre	1938
The Fabulous Invalid	Broadhurst Theatre	1938
Dear Octopus	Broadhurst Theatre	1939
Night Music	Broadhurst Theatre	1940
Keep Off the Grass	Broadhurst Theatre	1940
Old Acquaintance	Broadhurst Theatre	1941
Ten Little Indians	Broadhurst Theatre	1944
Lady in Danger	Broadhurst Theatre	1945
Follow the Girls	Broadhurst Theatre	1945
Happy Birthday	Broadhurst Theatre	1946
Make Mine Manhattan	Broadhurst Theatre	1948
Lend an Ear	Broadhurst Theatre	1949
The Liar	Broadhurst Theatre	1950
Detective Story	Broadhurst Theatre	1950
Burning Bright	Broadhurst Theatre	1950
An Enemy of the People	Broadhurst Theatre	1950
Romeo and Juliet	Broadhurst Theatre	1951
Flahooley	Broadhurst Theatre	1951
Seventeen	Broadhurst Theatre	1951
Pal Joey	Broadhurst Theatre	1952
The Love of Four Colonels	Broadhurst Theatre	1953
Auntie Mame	Broadhurst Theatre	1956
The World of Suzie Wong	Broadhurst Theatre	1958
Fiorello!	Broadhurst Theatre	1959
Sail Away	Broadhurst Theatre	1961
My Fair Lady	Broadhurst Theatre	1962
Bravo Giovanni	Broadhurst Theatre	1962
No Strings	Broadhurst Theatre	1962
110 in the Shade	Broadhurst Theatre	1963
Oh, What a Lovely War!	Broadhurst Theatre	1964
Kelly	Broadhurst Theatre	1965
Half a Sixpence	Broadhurst Theatre	1965
Luv	Broadhurst Theatre	1966
Cabaret	Broadhurst Theatre	1966
More Stately Mansions	Broadhurst Theatre	1967
Weekend	Broadhurst Theatre	1968
The Only Game in Town	Broadhurst Theatre	1968
You Know I Can't Hear You When the Water's Running	Broadhurst Theatre	1968
The Fig Leaves Are Falling	Broadhurst Theatre	1969
Play It Again, Sam	Broadhurst Theatre	1969
Cry For Us All	Broadhurst Theatre	1970
Private Lives	Broadhurst Theatre	1970
Four on a Garden	Broadhurst Theatre	1970
70, Girls, 70	Broadhurst Theatre	1971
Twigs	Broadhurst Theatre	1971
Vivat! Vivat Regina!	Broadhurst Theatre	1972
Grease	Broadhurst Theatre	1972
The Sunshine Boys	Broadhurst Theatre	1972
Rachael Lily Rosenbloom and Don't You Ever Forget It	Broadhurst Theatre	1973
Thieves	Broadhurst Theatre	1974
Sherlock Holmes	Broadhurst Theatre	1974
A Matter of Gravity	Broadhurst Theatre	1976
The Heiress	Broadhurst Theatre	1976
Godspell	Broadhurst Theatre	1976
A Texas Trilogy	Broadhurst Theatre	1976
Sly Fox	Broadhurst Theatre	1976
Dancin'	Broadhurst Theatre	1978
Amadeus	Broadhurst Theatre	1980
The Tap Dance Kid	Broadhurst Theatre	1983
Death of a Salesman	Broadhurst Theatre	1984
The Odd Couple	Broadhurst Theatre	1985
Long Day's Journey into Night	Broadhurst Theatre	1986
The Life and Adventures of Nicholas Nickleby	Broadhurst Theatre	1986
Broadway Bound	Broadhurst Theatre	1986
Rumors	Broadhurst Theatre	1988
Aspects of Love	Broadhurst Theatre	1990
Private Lives	Broadhurst Theatre	1992
Shimada	Broadhurst Theatre	1992
A Christmas Carol	Broadhurst Theatre	1992
Kiss of the Spider Woman	Broadhurst Theatre	1993
The Tempest	Broadhurst Theatre	1995
Getting Away with Murder	Broadhurst Theatre	1996
Once Upon a Mattress	Broadhurst Theatre	1996
Proposals	Broadhurst Theatre	1997
Fosse	Broadhurst Theatre	1999
Into the Woods	Broadhurst Theatre	2002
Urban Cowboy	Broadhurst Theatre	2003
Never Gonna Dance	Broadhurst Theatre	2003
700 Sundays	Broadhurst Theatre	2004
Lennon	Broadhurst Theatre	2005
The History Boys	Broadhurst Theatre	2006
Les Miserables	Broadhurst Theatre	2006
Cat on a Hot Tin Roof	Broadhurst Theatre	2008
Equus	Broadhurst Theatre	2008
Mary Stuart	Broadhurst Theatre	2009
Hamlet	Broadhurst Theatre	2009
Enron	Broadhurst Theatre	2010
The Merchant of Venice	Broadhurst Theatre	2010
Baby It's You!	Broadhurst Theatre	2011
Hugh Jackman, Back on Broadway	Broadhurst Theatre	2011
Lucky Guy	Broadhurst Theatre	2013
Mamma Mia!	Broadhurst Theatre	2013
Misery	Broadhurst Theatre	2015
Tuck Everlasting	Broadhurst Theatre	2016
The Front Page	Broadhurst Theatre	2016
Anastasia	Broadhurst Theatre	2017
Frankie and Johnny in the Clair de Lune	Broadhurst Theatre	2019
Jagged Little Pill	Broadhurst Theatre	2019
A Beautiful Noise	Broadhurst Theatre	2022
Chess	Broadhurst Theatre	2022
The Hills of California	Broadhurst Theatre	2024
Boop! The Musical	Broadhurst Theatre	2025
The New Yorkers	Broadway Theatre (53rd Street)	1930
Troilus and Cressida	Broadway Theatre (53rd Street)	1932
Earl Carroll's Vanities	Broadway Theatre (53rd Street)	1932
Too Many Girls	Broadway Theatre (53rd Street)	1940
Mamba's Daughters	Broadway Theatre (53rd Street)	1940
This Is The Army	Broadway Theatre (53rd Street)	1942
Ballet Imperial,The Fair at Sorochinsk	Broadway Theatre (53rd Street)	1942
La Vie Parisienne	Broadway Theatre (53rd Street)	1942
My Sister Eileen	Broadway Theatre (53rd Street)	1942
Lady in the Dark	Broadway Theatre (53rd Street)	1943
The Student Prince	Broadway Theatre (53rd Street)	1943
Artists and Models (1943)	Broadway Theatre (53rd Street)	1943
Carmen Jones	Broadway Theatre (53rd Street)	1943
The Tempest	Broadway Theatre (53rd Street)	1945
Memphis Bound!	Broadway Theatre (53rd Street)	1945
Up in Central Park	Broadway Theatre (53rd Street)	1945
Song of Norway	Broadway Theatre (53rd Street)	1946
A Flag Is Born	Broadway Theatre (53rd Street)	1946
Beggar's Holiday	Broadway Theatre (53rd Street)	1946
The Cradle Will Rock	Broadway Theatre (53rd Street)	1948
High Button Shoes	Broadway Theatre (53rd Street)	1948
Cabalgata	Broadway Theatre (53rd Street)	1949
As the Girls Go	Broadway Theatre (53rd Street)	1949
Katherine Dunham and Her Company	Broadway Theatre (53rd Street)	1950
Where's Charley?	Broadway Theatre (53rd Street)	1951
The Green Pastures	Broadway Theatre (53rd Street)	1951
Oklahoma!	Broadway Theatre (53rd Street)	1951
Diamond Lil	Broadway Theatre (53rd Street)	1951
Kiss Me, Kate	Broadway Theatre (53rd Street)	1952
Four Saints in Three Acts	Broadway Theatre (53rd Street)	1952
Shuffle Along (1952)	Broadway Theatre (53rd Street)	1952
South Pacific	Broadway Theatre (53rd Street)	1953
The Saint of Bleecker Street	Broadway Theatre (53rd Street)	1954
Mr. Wonderful	Broadway Theatre (53rd Street)	1956
Shinbone Alley	Broadway Theatre (53rd Street)	1957
The Most Happy Fella	Broadway Theatre (53rd Street)	1957
The Body Beautiful	Broadway Theatre (53rd Street)	1958
West Side Story	Broadway Theatre (53rd Street)	1959
Gypsy	Broadway Theatre (53rd Street)	1959
The Music Man	Broadway Theatre (53rd Street)	1960
Fiorello!	Broadway Theatre (53rd Street)	1961
Kean	Broadway Theatre (53rd Street)	1961
My Fair Lady	Broadway Theatre (53rd Street)	1962
I Can Get It for You Wholesale	Broadway Theatre (53rd Street)	1962
Tovarich	Broadway Theatre (53rd Street)	1963
The Girl Who Came to Supper	Broadway Theatre (53rd Street)	1963
Baker Street	Broadway Theatre (53rd Street)	1965
The Devils	Broadway Theatre (53rd Street)	1965
A Time for Singing	Broadway Theatre (53rd Street)	1966
Annie Get Your Gun	Broadway Theatre (53rd Street)	1966
Funny Girl	Broadway Theatre (53rd Street)	1966
The Happy Time	Broadway Theatre (53rd Street)	1968
Cabaret	Broadway Theatre (53rd Street)	1968
Mame	Broadway Theatre (53rd Street)	1969
Purlie	Broadway Theatre (53rd Street)	1970
Fiddler on the Roof	Broadway Theatre (53rd Street)	1970
Dude	Broadway Theatre (53rd Street)	1972
Candide	Broadway Theatre (53rd Street)	1974
Hamlet	Imperial Theatre	1936
Guys and Dolls	Broadway Theatre (53rd Street)	1976
Nana Mouskouri on Broadway	Broadway Theatre (53rd Street)	1977
The Wiz	Broadway Theatre (53rd Street)	1977
Evita	Broadway Theatre (53rd Street)	1979
Zorba	Broadway Theatre (53rd Street)	1983
The Three Musketeers	Broadway Theatre (53rd Street)	1984
The King and I	Broadway Theatre (53rd Street)	1985
Big Deal	Broadway Theatre (53rd Street)	1986
Les Miserables	Broadway Theatre (53rd Street)	1987
Miss Saigon	Broadway Theatre (53rd Street)	1991
Blast!	Broadway Theatre (53rd Street)	2001
Robin Williams: Live on Broadway	Broadway Theatre (53rd Street)	2002
La Boheme	Broadway Theatre (53rd Street)	2002
Bombay Dreams	Broadway Theatre (53rd Street)	2004
The Color Purple	Broadway Theatre (53rd Street)	2005
Cirque Dreams	Broadway Theatre (53rd Street)	2008
Shrek The Musical	Broadway Theatre (53rd Street)	2008
Promises, Promises	Broadway Theatre (53rd Street)	2010
Sister Act	Broadway Theatre (53rd Street)	2011
Frankie Valli and the Four Seasons on Broadway	Broadway Theatre (53rd Street)	2012
Cinderella	Broadway Theatre (53rd Street)	2013
Doctor Zhivago	Broadway Theatre (53rd Street)	2015
Fiddler on the Roof	Broadway Theatre (53rd Street)	2015
Miss Saigon	Broadway Theatre (53rd Street)	2017
King Kong	Broadway Theatre (53rd Street)	2018
West Side Story	Broadway Theatre (53rd Street)	2020
The Little Prince	Broadway Theatre (53rd Street)	2022
Here Lies Love	Broadway Theatre (53rd Street)	2023
The Great Gatsby	Broadway Theatre (53rd Street)	2024
Mourning Becomes Electra	Circle in the Square Theatre	1972
Medea	Circle in the Square Theatre	1973
Uncle Vanya	Circle in the Square Theatre	1973
The Waltz of the Toreadors	Circle in the Square Theatre	1973
The Iceman Cometh	Circle in the Square Theatre	1973
Scapino	Circle in the Square Theatre	1974
The National Health	Circle in the Square Theatre	1974
Where's Charley?	Circle in the Square Theatre	1974
All God's Chillun Got Wings	Circle in the Square Theatre	1975
Death of a Salesman	Circle in the Square Theatre	1975
Ah, Wilderness!	Circle in the Square Theatre	1975
The Glass Menagerie	Circle in the Square Theatre	1975
Geraldine Fitzgerald in Songs of the Street	Circle in the Square Theatre	1976
The Lady from the Sea	Circle in the Square Theatre	1976
Pal Joey	Circle in the Square Theatre	1976
The Night of the Iguana	Circle in the Square Theatre	1976
Romeo and Juliet	Circle in the Square Theatre	1977
The Importance of Being Earnest	Circle in the Square Theatre	1977
Tartuffe	Circle in the Square Theatre	1977
Saint Joan	Circle in the Square Theatre	1977
13 Rue de l'Amour	Circle in the Square Theatre	1978
Once in a Lifetime	Circle in the Square Theatre	1978
The Inspector General	Circle in the Square Theatre	1978
Man and Superman	Circle in the Square Theatre	1978
Major Barbara	Circle in the Square Theatre	1980
The Man Who Came to Dinner	Circle in the Square Theatre	1980
The Bacchae	Circle in the Square Theatre	1980
John Gabriel Borkman	Circle in the Square Theatre	1980
The Father	Circle in the Square Theatre	1981
Candida	Circle in the Square Theatre	1981
Macbeth	Circle in the Square Theatre	1982
Present Laughter	Circle in the Square Theatre	1982
The Misanthrope	Circle in the Square Theatre	1983
The Caine Mutiny Court-Martial	Circle in the Square Theatre	1983
Heartbreak House	Circle in the Square Theatre	1983
Awake and Sing	Circle in the Square Theatre	1984
Design for Living	Circle in the Square Theatre	1984
Arms and the Man	Circle in the Square Theatre	1985
The Marriage of Figaro	Circle in the Square Theatre	1985
The Caretaker	Circle in the Square Theatre	1986
You Never Can Tell	Circle in the Square Theatre	1986
Coastal Disturbances	Circle in the Square Theatre	1987
An Evening with Robert Klein	Circle in the Square Theatre	1988
The Night of the Iguana	Circle in the Square Theatre	1988
The Devil's Disciple	Circle in the Square Theatre	1988
Ghetto	Circle in the Square Theatre	1989
Sweeney Todd	Circle in the Square Theatre	1989
The Miser	Circle in the Square Theatre	1990
Taking Steps	Circle in the Square Theatre	1991
Getting Married	Circle in the Square Theatre	1991
On Borrowed Time	Circle in the Square Theatre	1991
Salome	Circle in the Square Theatre	1992
Anna Karenina	Circle in the Square Theatre	1992
The Shadow Box	Circle in the Square Theatre	1994
Uncle Vanya	Circle in the Square Theatre	1995
The Rose Tattoo	Circle in the Square Theatre	1995
Garden District	Circle in the Square Theatre	1995
Holiday	Circle in the Square Theatre	1995
Bus Stop	Circle in the Square Theatre	1996
Tartuffe	Circle in the Square Theatre	1996
Hughie	Circle in the Square Theatre	1996
Stanley	Circle in the Square Theatre	1997
Not About Nightingales	Circle in the Square Theatre	1999
True West	Circle in the Square Theatre	2000
Metamorphoses	Circle in the Square Theatre	2002
Life (x) 3	Circle in the Square Theatre	2003
Frozen	Circle in the Square Theatre	2004
The 25th Annual Putnam County Spelling Bee	Circle in the Square Theatre	2005
Glory Days	Circle in the Square Theatre	2008
The Norman Conquests	Circle in the Square Theatre	2009
The Miracle Worker	Circle in the Square Theatre	2010
Lombardi	Circle in the Square Theatre	2010
Godspell	Circle in the Square Theatre	2011
Soul Doctor	Circle in the Square Theatre	2013
Bronx Bombers	Circle in the Square Theatre	2014
Lady Day at Emerson's Bar and Grill	Circle in the Square Theatre	2014
The River	Circle in the Square Theatre	2014
Fun Home	Circle in the Square Theatre	2015
In Transit	Circle in the Square Theatre	2016
Once on This Island	Circle in the Square Theatre	2017
Oklahoma!	Circle in the Square Theatre	2019
Chicken & Biscuits	Circle in the Square Theatre	2021
American Buffalo	Circle in the Square Theatre	2022
KPOP	Circle in the Square Theatre	2022
An Enemy of the People	Circle in the Square Theatre	2024
Romeo and Juliet	Circle in the Square Theatre	2024
Just in Time	Circle in the Square Theatre	2025
Death Takes a Holiday	Ethel Barrymore Theatre	1929
Topaze	Ethel Barrymore Theatre	1930
The Truth Game	Ethel Barrymore Theatre	1930
Scarlet Sister Mary	Ethel Barrymore Theatre	1930
Melo	Ethel Barrymore Theatre	1931
The School for Scandal	Ethel Barrymore Theatre	1931
There's Always Juliet	Ethel Barrymore Theatre	1932
Gay Divorce	Ethel Barrymore Theatre	1932
Design for Living	Ethel Barrymore Theatre	1933
Both Your Houses	Ethel Barrymore Theatre	1934
Ruth Draper	Ethel Barrymore Theatre	1934
Point Valaine	Ethel Barrymore Theatre	1935
Othello	Ethel Barrymore Theatre	1935
Macbeth	Ethel Barrymore Theatre	1935
Bury the Dead	Ethel Barrymore Theatre	1936
Night Must Fall	Ethel Barrymore Theatre	1936
The Women	Ethel Barrymore Theatre	1936
Knickerbocker Holiday	Ethel Barrymore Theatre	1938
No Time for Comedy	Ethel Barrymore Theatre	1939
Key Largo	Ethel Barrymore Theatre	1939
Pal Joey	Ethel Barrymore Theatre	1940
Best Foot Forward	Ethel Barrymore Theatre	1941
R.U.R.	Ethel Barrymore Theatre	1942
Three Sisters	Ethel Barrymore Theatre	1943
Rebecca	Ethel Barrymore Theatre	1945
The Barretts of Wimpole Street	Ethel Barrymore Theatre	1945
Marinka	Ethel Barrymore Theatre	1945
Pygmalion	Ethel Barrymore Theatre	1945
The Duchess of Malfi	Ethel Barrymore Theatre	1946
Cyrano de Bergerac	Ethel Barrymore Theatre	1946
The Telephone/The Medium	Ethel Barrymore Theatre	1947
The Rat Race	Ethel Barrymore Theatre	1949
The Consul	Ethel Barrymore Theatre	1950
Bell, Book and Candle	Ethel Barrymore Theatre	1950
The Fourposter	Ethel Barrymore Theatre	1951
I've Got Sixpence	Ethel Barrymore Theatre	1952
Misalliance	Ethel Barrymore Theatre	1953
Tea and Sympathy	Ethel Barrymore Theatre	1953
The Desperate Hours	Ethel Barrymore Theatre	1955
Marcel Marceau	Ethel Barrymore Theatre	1955
The Chalk Garden	Ethel Barrymore Theatre	1955
Small War on Murray Hill	Ethel Barrymore Theatre	1957
Waiting for Godot	Ethel Barrymore Theatre	1957
Look Homeward, Angel	Ethel Barrymore Theatre	1957
A Raisin in the Sun	Ethel Barrymore Theatre	1959
A Majority of One	Ethel Barrymore Theatre	1959
The Hostage	Ethel Barrymore Theatre	1960
Critic's Choice	Ethel Barrymore Theatre	1960
The Complaisant Lover	Ethel Barrymore Theatre	1961
Moby-Dick	Ethel Barrymore Theatre	1962
The Passion of Josef D.	Ethel Barrymore Theatre	1964
The Amen Corner	Ethel Barrymore Theatre	1965
Wait Until Dark	Ethel Barrymore Theatre	1966
We Have Always Lived in the Castle	Ethel Barrymore Theatre	1966
Les Ballets Africains	Ethel Barrymore Theatre	1966
Black Comedy/White Lies	Ethel Barrymore Theatre	1967
The Little Foxes	Ethel Barrymore Theatre	1967
Don't Drink the Water	Ethel Barrymore Theatre	1968
The Seven Descents of Myrtle	Ethel Barrymore Theatre	1968
Happiness Is Just a Little Thing Called a Rolls Royce	Ethel Barrymore Theatre	1968
The Goodbye People	Ethel Barrymore Theatre	1968
The Front Page	Ethel Barrymore Theatre	1969
Conduct Unbecoming	Ethel Barrymore Theatre	1970
The Philanthropist	Ethel Barrymore Theatre	1971
Ain't Supposed to Die a Natural Death	Ethel Barrymore Theatre	1971
Captain Brassbound's Conversion	Ethel Barrymore Theatre	1972
Don't Play Us Cheap	Ethel Barrymore Theatre	1972
The Visit	Ethel Barrymore Theatre	1973
Holiday	Ethel Barrymore Theatre	1973
A Song at Twilight/Come Into the Garden, Maud	Ethel Barrymore Theatre	1974
The Night That Made America Famous	Ethel Barrymore Theatre	1975
Travesties	Ethel Barrymore Theatre	1975
Legend	Ethel Barrymore Theatre	1976
Poor Murderer	Ethel Barrymore Theatre	1976
American Buffalo	Ethel Barrymore Theatre	1977
I Love My Wife	Ethel Barrymore Theatre	1977
Romantic Comedy	Ethel Barrymore Theatre	1979
The West Side Waltz	Ethel Barrymore Theatre	1981
Is There Life After High School?	Ethel Barrymore Theatre	1982
Foxfire	Ethel Barrymore Theatre	1982
Baby	Ethel Barrymore Theatre	1983
Hurlyburly	Ethel Barrymore Theatre	1984
Social Security	Ethel Barrymore Theatre	1986
Joe Turner's Come and Gone	Ethel Barrymore Theatre	1988
The Secret Rapture	Ethel Barrymore Theatre	1988
Rumors	Ethel Barrymore Theatre	1989
Lettice and Lovage	Ethel Barrymore Theatre	1990
Mule Bone	Ethel Barrymore Theatre	1991
The Sisters Rosensweig	Ethel Barrymore Theatre	1993
Indiscretions	Ethel Barrymore Theatre	1995
An Ideal Husband	Ethel Barrymore Theatre	1996
The Life	Ethel Barrymore Theatre	1997
Electra	Ethel Barrymore Theatre	1998
Amy's View	Ethel Barrymore Theatre	1999
Putting It Together	Ethel Barrymore Theatre	1999
The Real Thing	Ethel Barrymore Theatre	2000
The Tale of the Allergist's Wife	Ethel Barrymore Theatre	2000
Imaginary Friends	Ethel Barrymore Theatre	2002
Salome	Ethel Barrymore Theatre	2003
Sly Fox	Ethel Barrymore Theatre	2004
The Glass Menagerie	Ethel Barrymore Theatre	2005
Ring of Fire	Ethel Barrymore Theatre	2006
Company	Ethel Barrymore Theatre	2006
Red Carpet Massacre	Ethel Barrymore Theatre	2007
November	Ethel Barrymore Theatre	2008
Speed-the-Plow	Ethel Barrymore Theatre	2008
Exit the King	Ethel Barrymore Theatre	2009
Race	Ethel Barrymore Theatre	2009
Elling	Ethel Barrymore Theatre	2010
Arcadia	Ethel Barrymore Theatre	2011
An Evening withPatti LuPoneandMandy Patinkin	Ethel Barrymore Theatre	2011
Death of a Salesman	Ethel Barrymore Theatre	2012
Chaplin	Ethel Barrymore Theatre	2012
Macbeth	Ethel Barrymore Theatre	2013
Betrayal	Ethel Barrymore Theatre	2013
A Raisin in the Sun	Ethel Barrymore Theatre	2014
The Curious Incident of the Dog in the Night-Time	Ethel Barrymore Theatre	2014
Alton Brown Live: Eat Your Science	Ethel Barrymore Theatre	2016
The Present	Ethel Barrymore Theatre	2016
Six Degrees of Separation	Ethel Barrymore Theatre	2017
The Band's Visit	Ethel Barrymore Theatre	2017
The Inheritance	Ethel Barrymore Theatre	2019
Waitress	Ethel Barrymore Theatre	2021
Paradise Square	Ethel Barrymore Theatre	2022
The Piano Lesson	Ethel Barrymore Theatre	2022
Peter Pan Goes Wrong	Ethel Barrymore Theatre	2023
El Mago Pop	Ethel Barrymore Theatre	2023
Harmony: A New Musical	Ethel Barrymore Theatre	2023
Patriots	Ethel Barrymore Theatre	2024
Our Town	Ethel Barrymore Theatre	2024
Othello	Ethel Barrymore Theatre	2025
The Hostage	Eugene O'Neill Theatre	1960
Let It Ride	Eugene O'Neill Theatre	1961
Ross	Eugene O'Neill Theatre	1961
A Thousand Clowns	Eugene O'Neill Theatre	1962
She Loves Me	Eugene O'Neill Theatre	1963
Something More!	Eugene O'Neill Theatre	1964
The Odd Couple	Eugene O'Neill Theatre	1966
The Freaking Out of Stephanie Blake[f]	Eugene O'Neill Theatre	1967
Rosencrantz and Guildenstern Are Dead	Eugene O'Neill Theatre	1968
Canterbury Tales	Eugene O'Neill Theatre	1969
Last of the Red Hot Lovers	Eugene O'Neill Theatre	1969
The Prisoner of Second Avenue	Eugene O'Neill Theatre	1971
The Good Doctor	Eugene O'Neill Theatre	1973
God's Favorite	Eugene O'Neill Theatre	1974
Yentl	Eugene O'Neill Theatre	1975
California Suite	Eugene O'Neill Theatre	1976
Your Arms Too Short to Box with God	Eugene O'Neill Theatre	1977
Chapter Two	Eugene O'Neill Theatre	1979
I Ought to Be in Pictures	Eugene O'Neill Theatre	1980
Fools	Eugene O'Neill Theatre	1981
Annie	Eugene O'Neill Theatre	1981
Little Me	Eugene O'Neill Theatre	1982
The Best Little Whorehouse in Texas	Eugene O'Neill Theatre	1982
Moose Murders	Eugene O'Neill Theatre	1983
The Glass Menagerie	Eugene O'Neill Theatre	1983
Big River	Eugene O'Neill Theatre	1985
Tom Waits in Concert on Broadway	Eugene O'Neill Theatre	1987
M. Butterfly	Eugene O'Neill Theatre	1988
Cat on a Hot Tin Roof	Eugene O'Neill Theatre	1990
La Bête	Eugene O'Neill Theatre	1991
Penn & Teller: The Refrigerator Tour	Eugene O'Neill Theatre	1991
A Christmas Carol	Eugene O'Neill Theatre	1991
Grease	Eugene O'Neill Theatre	1994
The Herbal Bed	Eugene O'Neill Theatre	1998
Death of a Salesman	Eugene O'Neill Theatre	1999
Waiting in the Wings	Eugene O'Neill Theatre	2000
The Full Monty	Eugene O'Neill Theatre	2000
Nine	Eugene O'Neill Theatre	2003
Caroline, or Change	Eugene O'Neill Theatre	2004
Good Vibrations	Eugene O'Neill Theatre	2005
Sweeney Todd	Eugene O'Neill Theatre	2005
Spring Awakening	Eugene O'Neill Theatre	2006
33 Variations	Eugene O'Neill Theatre	2009
Fela!	Eugene O'Neill Theatre	2009
8	Eugene O'Neill Theatre	2011
The Book of Mormon	Eugene O'Neill Theatre	2011
Chita Rivera: The Dancer's Life	Gerald Schoenfeld Theatre	2005
The Caine Mutiny Court-Martial	Gerald Schoenfeld Theatre	2006
A Chorus Line	Gerald Schoenfeld Theatre	2006
All My Sons	Gerald Schoenfeld Theatre	2008
Impressionism	Gerald Schoenfeld Theatre	2009
A Steady Rain	Gerald Schoenfeld Theatre	2009
A Behanding in Spokane	Gerald Schoenfeld Theatre	2010
A Life in the Theatre	Gerald Schoenfeld Theatre	2010
The Motherfucker with the Hat	Gerald Schoenfeld Theatre	2011
Bonnie & Clyde	Gerald Schoenfeld Theatre	2011
The Best Man	Gerald Schoenfeld Theatre	2012
Glengarry Glen Ross	Gerald Schoenfeld Theatre	2012
Orphans	Gerald Schoenfeld Theatre	2013
The Bridges of Madison County	Gerald Schoenfeld Theatre	2014
It's Only a Play	Gerald Schoenfeld Theatre	2014
The Audience	Gerald Schoenfeld Theatre	2015
China Doll	Gerald Schoenfeld Theatre	2015
American Psycho	Gerald Schoenfeld Theatre	2016
The Humans	Gerald Schoenfeld Theatre	2016
Come from Away	Gerald Schoenfeld Theatre	2017
Take Me Out	Gerald Schoenfeld Theatre	2022
Life of Pi	Gerald Schoenfeld Theatre	2023
The Notebook	Gerald Schoenfeld Theatre	2024
Buena Vista Social Club	Gerald Schoenfeld Theatre	2025
Mame	Gershwin Theatre	1983
Shirley MacLaine on Broadway	Gershwin Theatre	1984
Twyla Tharp Dance on Broadway	Gershwin Theatre	1984
Nureyev and Friends	Gershwin Theatre	1984
Gladys Knight & the Pips&Kashif	Gershwin Theatre	1984
Much Ado About Nothing	Gershwin Theatre	1984
Cyrano de Bergerac	Gershwin Theatre	1984
Patti LaBelle on Broadway	Gershwin Theatre	1985
An Evening with Smokey Robinson	Gershwin Theatre	1985
Singin' in the Rain	Gershwin Theatre	1985
Starlight Express	Gershwin Theatre	1987
Barry Manilow Live on Broadway	Gershwin Theatre	1989
Meet Me in St. Louis	Gershwin Theatre	1989
Bugs Bunny on Broadway	Gershwin Theatre	1990
Fiddler on the Roof	Gershwin Theatre	1990
Moscow Circus	Gershwin Theatre	1991
Grand Hotel	Gershwin Theatre	1992
Tommy Tune Tonite!	Gershwin Theatre	1992
Raffi	Gershwin Theatre	1993
Yanni	Gershwin Theatre	1993
Camelot	Gershwin Theatre	1993
The Red Shoes	Gershwin Theatre	1993
Men Are from Mars, Women Are from Venus	Gershwin Theatre	1997
Candide	Gershwin Theatre	1997
1776	Gershwin Theatre	1997
On the Town	Gershwin Theatre	1998
Peter Pan	Gershwin Theatre	1999
Tango Argentino	Gershwin Theatre	1999
Riverdance on Broadway	Gershwin Theatre	2000
Linda Eder at the Gershwin	Gershwin Theatre	2001
Oklahoma!	Gershwin Theatre	2002
Wicked	Gershwin Theatre	2003
Lobby Hero	Hayes Theater	2018
Straight White Men	Hayes Theater	2018
Torch Song	Hayes Theater	2018
What the Constitution Means to Me	Hayes Theater	2019
Linda Vista	Hayes Theater	2019
Grand Horizons	Hayes Theater	2020
Clyde's	Hayes Theater	2021
Take Me Out	Hayes Theater	2022
Kite Runner	Hayes Theater	2022
Between Riverside and Crazy	Hayes Theater	2022
The Thanksgiving Play	Hayes Theater	2023
The Cottage	Hayes Theater	2023
Appropriate	Hayes Theater	2023
Mother Play	Hayes Theater	2024
Job	Hayes Theater	2024
Cult of Love	Hayes Theater	2024
Purpose	Hayes Theater	2025
Marjorie Prime	Hayes Theater	2025
Becky Shaw	Hayes Theater	2026
The Marriage of Kitty	Hudson Theatre	1903
Man and Superman	Hudson Theatre	1905
Brewster's Millions	Hudson Theatre	1907
Lady Frederick	Hudson Theatre	1908
Arsène Lupin	Hudson Theatre	1909
Frou-Frou	Hudson Theatre	1912
General John Regan	Hudson Theatre	1913
Lady Windermere's Fan	Hudson Theatre	1914
Alice in Wonderland	Hudson Theatre	1915
Our Betters	Hudson Theatre	1917
Friendly Enemies	Hudson Theatre	1918
The Voice From the Minaret	Hudson Theatre	1922
Fedora	Hudson Theatre	1922
So This Is London	Hudson Theatre	1922
The Fake	Hudson Theatre	1924
The Noose	Hudson Theatre	1926
The Plough and the Stars	Hudson Theatre	1927
Hot Chocolates	Hudson Theatre	1929
The Inspector General	Hudson Theatre	1930
An Enemy of the People	Hudson Theatre	1937
The Amazing Dr. Clitterhouse	Hudson Theatre	1937
Good Hunting	Hudson Theatre	1938
Lew Leslie's Blackbirds	Hudson Theatre	1939
Love for Love	Hudson Theatre	1940
All Men Are Alike	Hudson Theatre	1941
Run, Little Chillun	Hudson Theatre	1943
Arsenic and Old Lace	Hudson Theatre	1943
State of the Union	Hudson Theatre	1945
Detective Story	Hudson Theatre	1949
Toys in the Attic	Hudson Theatre	1960
Ross	Hudson Theatre	1962
Strange Interlude	Hudson Theatre	1963
How to Be a Jewish Mother	Hudson Theatre	1967
Sunday in the Park with George	Hudson Theatre	2017
1984	Hudson Theatre	2017
The Parisian Woman	Hudson Theatre	2017
Head over Heels	Hudson Theatre	2018
Burn This	Hudson Theatre	2019
American Utopia	Hudson Theatre	2019
Plaza Suite	Hudson Theatre	2022
Death of a Salesman	Hudson Theatre	2022
A Doll's House	Hudson Theatre	2023
Just for Us	Hudson Theatre	2023
Merrily We Roll Along	Hudson Theatre	2023
Once Upon a Mattress	Hudson Theatre	2024
All In: Comedy About Love	Hudson Theatre	2024
The Last Five Years	Hudson Theatre	2025
Mary Jane McKane	Imperial Theatre	1923
Rose-Marie	Imperial Theatre	1924
Oh, Kay!	Imperial Theatre	1926
The Desert Song	Imperial Theatre	1927
The New Moon	Imperial Theatre	1928
Princess Charming	Imperial Theatre	1930
Babes in Toyland	Imperial Theatre	1930
Flying Colors	Imperial Theatre	1932
Of Thee I Sing	Imperial Theatre	1933
Let 'Em Eat Cake	Imperial Theatre	1933
Say When	Imperial Theatre	1934
Panic	Imperial Theatre	1935
Jubilee	Imperial Theatre	1935
On Your Toes	Imperial Theatre	1936
Between the Devil	Imperial Theatre	1937
You Can't Take It with You	Imperial Theatre	1938
Leave It to Me!	Imperial Theatre	1938
Too Many Girls	Imperial Theatre	1939
Louisiana Purchase	Imperial Theatre	1940
Let's Face It!	Imperial Theatre	1941
One Touch of Venus	Imperial Theatre	1943
Ziegfeld Follies	Imperial Theatre	1943
Song of Norway	Imperial Theatre	1944
Annie Get Your Gun	Imperial Theatre	1946
Miss Liberty	Imperial Theatre	1949
Peter Pan	Imperial Theatre	1950
Call Me Madam	Imperial Theatre	1950
Wish You Were Here	Imperial Theatre	1952
John Murray Anderson's Almanac	Imperial Theatre	1953
By the Beautiful Sea	Imperial Theatre	1954
Silk Stockings	Imperial Theatre	1955
The Most Happy Fella	Imperial Theatre	1956
Jamaica	Imperial Theatre	1957
Destry Rides Again	Imperial Theatre	1959
Gypsy	Imperial Theatre	1960
Carnival!	Imperial Theatre	1961
Oliver!	Imperial Theatre	1963
Fiddler on the Roof	Imperial Theatre	1964
Cabaret	Imperial Theatre	1967
Zorba	Imperial Theatre	1968
A Patriot for Me	Imperial Theatre	1969
Minnie's Boys	Imperial Theatre	1970
Two by Two	Imperial Theatre	1970
On the Town	Imperial Theatre	1971
Lost in the Stars	Imperial Theatre	1972
Pippin	Imperial Theatre	1972
Mark Twain Tonight!	Imperial Theatre	1977
Anna Christie	Imperial Theatre	1977
Chapter Two	Imperial Theatre	1977
They're Playing Our Song	Imperial Theatre	1979
Dreamgirls	Imperial Theatre	1981
The Mystery of Edwin Drood	Imperial Theatre	1985
Cabaret	Imperial Theatre	1987
Chess	Imperial Theatre	1988
Jerome Robbins' Broadway	Imperial Theatre	1989
Les Miserables	Imperial Theatre	1990
The Boy from Oz	Imperial Theatre	2003
Dirty Rotten Scoundrels	Imperial Theatre	2005
High Fidelity	Imperial Theatre	2006
Coram Boy	Imperial Theatre	2007
August: Osage County	Imperial Theatre	2007
Billy Elliot the Musical	Imperial Theatre	2008
Nice Work If You Can Get It	Imperial Theatre	2012
700 Sundays	Imperial Theatre	2013
Les Miserables	Imperial Theatre	2014
Natasha, Pierre & The Great Comet of 1812	Imperial Theatre	2016
Carousel	Imperial Theatre	2018
Ain't Too Proud	Imperial Theatre	2019
Bad Cinderella	Imperial Theatre	2023
Water for Elephants	Imperial Theatre	2024
Smash	Imperial Theatre	2025
The Princess Pat	James Earl Jones Theatre	1915
Everyman	James Earl Jones Theatre	1918
The Merchant of Venice	James Earl Jones Theatre	1918
As You Like It	James Earl Jones Theatre	1918
Julius Caesar	James Earl Jones Theatre	1918
The Better 'Ole	James Earl Jones Theatre	1918
Abraham Lincoln	James Earl Jones Theatre	1919
Captain Applejack	James Earl Jones Theatre	1921
Merton of the Movies	James Earl Jones Theatre	1922
The Assumption of Hannele	James Earl Jones Theatre	1924
The Second Mrs. Tanqueray	James Earl Jones Theatre	1924
The Jazz Singer	James Earl Jones Theatre	1925
The Wrecker	James Earl Jones Theatre	1928
Uncle Vanya	James Earl Jones Theatre	1930
Five Star Final	James Earl Jones Theatre	1930
The Blue Bird	James Earl Jones Theatre	1932
The Green Bay Tree	James Earl Jones Theatre	1933
The Bishop Misbehaves	James Earl Jones Theatre	1935
Most of the Game	James Earl Jones Theatre	1935
There's Wisdom in Women	James Earl Jones Theatre	1935
Room Service	James Earl Jones Theatre	1937
The White Steed	James Earl Jones Theatre	1939
The Male Animal	James Earl Jones Theatre	1940
Charley's Aunt	James Earl Jones Theatre	1940
Cafe Crown	James Earl Jones Theatre	1942
I Killed the Count	James Earl Jones Theatre	1942
The Winter's Tale	James Earl Jones Theatre	1946
Antigone	James Earl Jones Theatre	1946
Candida	James Earl Jones Theatre	1946
Lady Windermere's Fan	James Earl Jones Theatre	1946
Ghosts	James Earl Jones Theatre	1948
Hedda Gabler	James Earl Jones Theatre	1948
The Happy Journey to Trenton and CamdenandThe Respectful Prostitute	James Earl Jones Theatre	1948
Make Way for Lucia	James Earl Jones Theatre	1948
Two Blind Mice	James Earl Jones Theatre	1949
The Father	James Earl Jones Theatre	1949
As You Like It	James Earl Jones Theatre	1950
Saint Joan	James Earl Jones Theatre	1951
The Shrike	James Earl Jones Theatre	1952
The Rainmaker	James Earl Jones Theatre	1954
The Diary of Anne Frank	James Earl Jones Theatre	1955
Sunrise at Campobello	James Earl Jones Theatre	1958
Once Upon a Mattress	James Earl Jones Theatre	1960
The Hostage	James Earl Jones Theatre	1960
Advise and Consent	James Earl Jones Theatre	1960
Purlie Victorious	James Earl Jones Theatre	1961
Sunday in New York	James Earl Jones Theatre	1961
The Father,Long Day's Journey into Night, andMiss Julie	James Earl Jones Theatre	1962
One Flew Over the Cuckoo's Nest	James Earl Jones Theatre	1963
Boeing-Boeing	James Earl Jones Theatre	1965
The Zulu and the Zayda	James Earl Jones Theatre	1965
Johnny No-Trump	James Earl Jones Theatre	1967
Something Different	James Earl Jones Theatre	1967
Leda Had a Little Swan	James Earl Jones Theatre	1968
Red, White and Maddox	James Earl Jones Theatre	1969
King Richard III	James Earl Jones Theatre	1979
Clothes for a Summer Hotel	James Earl Jones Theatre	1980
Medea	James Earl Jones Theatre	1982
A Moon for the Misbegotten	James Earl Jones Theatre	1984
Ma Rainey's Black Bottom	James Earl Jones Theatre	1984
Sarafina!	James Earl Jones Theatre	1988
The Grapes of Wrath	James Earl Jones Theatre	1990
Face Value	James Earl Jones Theatre	1993
Twilight: Los Angeles, 1992	James Earl Jones Theatre	1994
The Heiress	James Earl Jones Theatre	1995
An American Daughter	James Earl Jones Theatre	1997
Freak	James Earl Jones Theatre	1998
The Blue Room	James Earl Jones Theatre	1998
Kat and the Kings	James Earl Jones Theatre	1999
The Green Bird	James Earl Jones Theatre	2000
Hollywood Arms	James Earl Jones Theatre	2002
A Year with Frog and Toad	James Earl Jones Theatre	2003
Bobbi Boland	James Earl Jones Theatre	2003
Laugh Whore	James Earl Jones Theatre	2004
On Golden Pond	James Earl Jones Theatre	2005
Barefoot in the Park	James Earl Jones Theatre	2006
The Little Dog Laughed	James Earl Jones Theatre	2006
Radio Golf	James Earl Jones Theatre	2007
The Homecoming	James Earl Jones Theatre	2007
The 39 Steps	James Earl Jones Theatre	2008
You're Welcome America: A Final Night with George W. Bush	James Earl Jones Theatre	2009
A View from the Bridge	James Earl Jones Theatre	2010
Fences	James Earl Jones Theatre	2010
Time Stands Still	James Earl Jones Theatre	2010
Born Yesterday	James Earl Jones Theatre	2011
Stick Fly	James Earl Jones Theatre	2011
The Lyons	James Earl Jones Theatre	2012
Grace	James Earl Jones Theatre	2012
Breakfast at Tiffany's	James Earl Jones Theatre	2013
No Man's LandandWaiting for Godot	James Earl Jones Theatre	2013
The Cripple of Inishmaan	James Earl Jones Theatre	2014
This is Our Youth	James Earl Jones Theatre	2014
Fish in the Dark	James Earl Jones Theatre	2015
Sylvia	James Earl Jones Theatre	2015
Bright Star	James Earl Jones Theatre	2016
Indecent	James Earl Jones Theatre	2017
M. Butterfly	James Earl Jones Theatre	2017
Mike Birbiglia's The New One	James Earl Jones Theatre	2018
King Lear	James Earl Jones Theatre	2019
Derren Brown: Secret	James Earl Jones Theatre	2019
The Minutes	James Earl Jones Theatre	2020
Ohio State Murders	James Earl Jones Theatre	2022
The Sign in Sidney Brustein's Window	James Earl Jones Theatre	2023
Gutenberg! The Musical!	James Earl Jones Theatre	2023
The Heart of Rock and Roll	James Earl Jones Theatre	2024
Left on Tenth	James Earl Jones Theatre	2024
Real Women Have Curves	James Earl Jones Theatre	2025
Patience	John Golden Theatre	1927
Rope's End	John Golden Theatre	1929
The Venetian	John Golden Theatre	1931
Louder, Please	John Golden Theatre	1931
Tobacco Road	John Golden Theatre	1933
Eden End	John Golden Theatre	1935
Shadow and Substance	John Golden Theatre	1938
Lightnin'	John Golden Theatre	1938
The White Steed	John Golden Theatre	1939
Angel Street	John Golden Theatre	1941
Maurice Chevalier in an evening of Songs and Impressions	John Golden Theatre	1948
Goodbye, My Fancy	John Golden Theatre	1949
Let's Make an Opera	John Golden Theatre	1950
The Green Bay Tree	John Golden Theatre	1951
To Dorothy, A Son	John Golden Theatre	1951
The Fourposter	John Golden Theatre	1952
Comedy in Music	John Golden Theatre	1953
Someone Waiting	John Golden Theatre	1956
Waiting for Godot	John Golden Theatre	1956
The Potting Shed	John Golden Theatre	1957
Look Back in Anger	John Golden Theatre	1958
Epitaph for George Dillon	John Golden Theatre	1958
A Party with Betty Comden and Adolph Green	John Golden Theatre	1958
Requiem for a Nun	John Golden Theatre	1959
The Billy Barnes Revue	John Golden Theatre	1959
At the Drop of a Hat	John Golden Theatre	1959
An Evening WithMike NicholsandElaine May	John Golden Theatre	1960
An Evening withYves Montand	John Golden Theatre	1961
Sunday in New York	John Golden Theatre	1962
Beyond the Fringe	John Golden Theatre	1962
Wait a Minim!	John Golden Theatre	1966
After the Rain	John Golden Theatre	1967
Brief Lives	John Golden Theatre	1967
Carry Me Back to Morningside Heights	John Golden Theatre	1968
The Exercise	John Golden Theatre	1968
Bob and Ray-The Two and Only	John Golden Theatre	1970
You're a Good Man, Charlie Brown	John Golden Theatre	1971
Sticks and Bones	John Golden Theatre	1972
HughieandDuet	John Golden Theatre	1975
P. S. Your Cat Is Dead!	John Golden Theatre	1975
Kennedy's Children	John Golden Theatre	1975
Going Up	John Golden Theatre	1976
Dirty Linen & New-Found-Land	John Golden Theatre	1977
The Gin Game	John Golden Theatre	1977
Murder at the Howard Johnson's	John Golden Theatre	1979
Watch on the Rhine	John Golden Theatre	1980
A Day in Hollywood / A Night in the Ukraine	John Golden Theatre	1980
Tintypes	John Golden Theatre	1980
Crimes of the Heart	John Golden Theatre	1981
'night, Mother	John Golden Theatre	1983
Glengarry Glen Ross	John Golden Theatre	1984
Blood Knot	John Golden Theatre	1985
Stepping Out	John Golden Theatre	1987
All My Sons	John Golden Theatre	1987
Juno and the Paycock	John Golden Theatre	1988
Eastern Standard	John Golden Theatre	1989
Falsettos	John Golden Theatre	1992
Master Class	John Golden Theatre	1995
The Chairs	John Golden Theatre	1998
Side Man	John Golden Theatre	1998
Stones in His Pockets	John Golden Theatre	2001
The Goat, or Who is Sylvia?	John Golden Theatre	2002
Vincent in Brixton	John Golden Theatre	2003
Avenue Q	John Golden Theatre	2003
Oleanna	John Golden Theatre	2009
Red	John Golden Theatre	2010
Driving Miss Daisy	John Golden Theatre	2010
The Normal Heart	John Golden Theatre	2011
Seminar	John Golden Theatre	2011
Vanya and Sonia and Masha and Spike	John Golden Theatre	2013
A Time to Kill	John Golden Theatre	2013
Mothers and Sons	John Golden Theatre	2014
A Delicate Balance	John Golden Theatre	2014
Skylight	John Golden Theatre	2015
The Gin Game	John Golden Theatre	2015
Eclipsed	John Golden Theatre	2016
A Doll's House, Part 2	John Golden Theatre	2017
Three Tall Women	John Golden Theatre	2018
The Waverly Gallery	John Golden Theatre	2018
Hillary and Clinton	John Golden Theatre	2019
Slave Play	John Golden Theatre	2019
Thoughts of a Colored Man	John Golden Theatre	2021
Hangmen	John Golden Theatre	2022
Topdog/Underdog	John Golden Theatre	2022
Prima Facie	John Golden Theatre	2023
The Shark Is Broken	John Golden Theatre	2023
Stereophonic	John Golden Theatre	2024
Operation Mincemeat	John Golden Theatre	2025
Beyond the Horizon	Lena Horne Theatre	1926
The Dybbuk	Lena Horne Theatre	1926
Ghosts	Lena Horne Theatre	1927
Present Arms	Lena Horne Theatre	1928
Chee-Chee	Lena Horne Theatre	1928
The Green Pastures	Lena Horne Theatre	1930
The House of Connelly	Lena Horne Theatre	1931
Shuffle Along (1933)	Lena Horne Theatre	1932
Page Miss Glory	Lena Horne Theatre	1934
Black Limelight	Lena Horne Theatre	1936
Sea Legs	Lena Horne Theatre	1937
Antony and Cleopatra	Lena Horne Theatre	1937
What a Life	Lena Horne Theatre	1939
Thunder Rock	Lena Horne Theatre	1939
Juno and the Paycock	Lena Horne Theatre	1940
Meet the People	Lena Horne Theatre	1940
As You Like It	Lena Horne Theatre	1941
Anna Lucasta	Lena Horne Theatre	1944
The Cradle Will Rock	Lena Horne Theatre	1947
John Bull's Other Island	Lena Horne Theatre	1948
Red Gloves	Lena Horne Theatre	1948
Lend an Ear	Lena Horne Theatre	1949
Come Blow Your Horn	Lena Horne Theatre	1961
Phèdre	Lena Horne Theatre	1963
Berenice	Lena Horne Theatre	1963
Man and Boy	Lena Horne Theatre	1963
The Milk Train Doesn't Stop Here Anymore	Lena Horne Theatre	1964
The Deputy	Lena Horne Theatre	1964
The Glass Menagerie	Lena Horne Theatre	1965
Love in E-Flat	Lena Horne Theatre	1967
A Minor Adjustment	Lena Horne Theatre	1967
Halfway Up the Tree	Lena Horne Theatre	1967
A Day in the Death of Joe Egg	Lena Horne Theatre	1968
Lovers and Other Strangers	Lena Horne Theatre	1968
Indians	Lena Horne Theatre	1969
Paris Is Out!	Lena Horne Theatre	1970
Charley's Aunt	Lena Horne Theatre	1970
Not Now, Darling	Lena Horne Theatre	1970
Lenny	Lena Horne Theatre	1971
Lysistrata	Lena Horne Theatre	1972
The River Niger	Lena Horne Theatre	1973
My Fat Friend	Lena Horne Theatre	1974
Of Mice and Men	Lena Horne Theatre	1974
Same Time, Next Year	Lena Horne Theatre	1975
Tribute	Lena Horne Theatre	1978
Bedroom Farce	Lena Horne Theatre	1979
Talley's Folly	Lena Horne Theatre	1980
Lolita	Lena Horne Theatre	1981
The Dresser	Lena Horne Theatre	1981
Beyond Therapy	Lena Horne Theatre	1982
Ghosts	Lena Horne Theatre	1982
Steaming	Lena Horne Theatre	1982
K2	Lena Horne Theatre	1983
Edmund Kean	Lena Horne Theatre	1983
Noises Off	Lena Horne Theatre	1983
Aren't We All?	Lena Horne Theatre	1985
Benefactors	Lena Horne Theatre	1985
Rowan Atkinson at the Atkinson	Lena Horne Theatre	1986
Jackie Mason's The World According to Me!	Lena Horne Theatre	1986
Cafe Crown	Lena Horne Theatre	1989
Peter, Paul & Mary "A Holiday Celebration"	Lena Horne Theatre	1989
Stephanie Mills Comes "Home" to Broadway	Lena Horne Theatre	1989
The Cemetery Club	Lena Horne Theatre	1990
Shadowlands	Lena Horne Theatre	1990
Death and the Maiden	Lena Horne Theatre	1992
Redwood Curtain	Lena Horne Theatre	1993
She Loves Me	Lena Horne Theatre	1993
Buried Child	Lena Horne Theatre	1996
Taking Sides	Lena Horne Theatre	1996
Play On!	Lena Horne Theatre	1997
Wait Until Dark	Lena Horne Theatre	1998
Fool Moon	Lena Horne Theatre	1998
The Iceman Cometh	Lena Horne Theatre	1999
The Rainmaker	Lena Horne Theatre	1999
Uncle Vanya	Lena Horne Theatre	2000
Jane Eyre	Lena Horne Theatre	2000
Noises Off	Lena Horne Theatre	2001
Medea	Lena Horne Theatre	2002
The Look of Love	Lena Horne Theatre	2003
Jumpers	Lena Horne Theatre	2004
Democracy	Lena Horne Theatre	2004
Mark Twain Tonight!	Lena Horne Theatre	2005
The Odd Couple	Lena Horne Theatre	2005
The Times They Are a-Changin'	Lena Horne Theatre	2006
A Moon for the Misbegotten	Lena Horne Theatre	2007
Grease	Lena Horne Theatre	2007
Rock of Ages	Lena Horne Theatre	2009
Rain: A Tribute to the Beatles	Lena Horne Theatre	2011
Relatively Speaking	Lena Horne Theatre	2011
Peter and the Starcatcher	Lena Horne Theatre	2012
Hands on a Hardbody	Lena Horne Theatre	2013
After Midnight	Lena Horne Theatre	2013
Love Letters	Lena Horne Theatre	2014
It Shoulda Been You	Lena Horne Theatre	2015
Spring Awakening	Lena Horne Theatre	2015
Waitress	Lena Horne Theatre	2016
Six	Lena Horne Theatre	2021
Adele	Longacre Theatre	1913
A Pair of Sixes	Longacre Theatre	1914
Secret Strings	Longacre Theatre	1914
Leave It to Jane	Longacre Theatre	1917
Ghosts	Longacre Theatre	1919
Adam and Eva	Longacre Theatre	1919
Nobody's Money	Longacre Theatre	1921
Rose Bernd	Longacre Theatre	1923
Romeo and Juliet	Longacre Theatre	1923
Little Jessie James	Longacre Theatre	1923
The Butter and Egg Man	Longacre Theatre	1925
Ritzy	Longacre Theatre	1930
Wednesday's Child	Longacre Theatre	1934
Till the Day I Die/Waiting for Lefty	Longacre Theatre	1935
Kind Lady	Longacre Theatre	1935
Paradise Lost	Longacre Theatre	1935
Hedda Gabler	Longacre Theatre	1936
On Borrowed Time	Longacre Theatre	1938
Wuthering Heights	Longacre Theatre	1939
The Three Sisters	Longacre Theatre	1939
Morning's at Seven	Longacre Theatre	1939
Leave Her to Heaven	Longacre Theatre	1940
Johnny Belinda	Longacre Theatre	1940
Hedda Gabler	Longacre Theatre	1942
Mademoiselle Colombe	Longacre Theatre	1954
The Burning Glass	Longacre Theatre	1954
The Tender Trap	Longacre Theatre	1954
Tea and Sympathy	Longacre Theatre	1955
The Honeys	Longacre Theatre	1955
The Lark	Longacre Theatre	1955
Holiday for Lovers	Longacre Theatre	1957
An Evening With Yves Montand	Longacre Theatre	1959
The Rhinoceros	Longacre Theatre	1961
Purlie Victorious	Longacre Theatre	1961
The Sign in Sidney Brustein's Window	Longacre Theatre	1964
Mark Twain Tonight	Longacre Theatre	1966
The Mutilated/The Gnadiges Fraulein	Longacre Theatre	1966
A Hand Is on the Gate	Longacre Theatre	1966
Gilbert Becaud on Broadway	Longacre Theatre	1966
Daphne in Cottage D	Longacre Theatre	1967
Cactus Flower	Longacre Theatre	1968
Candida	Longacre Theatre	1970
Les Blancs	Longacre Theatre	1970
The Me Nobody Knows	Longacre Theatre	1971
The Sign in Sidney Brustein's Window	Longacre Theatre	1972
Thieves	Longacre Theatre	1974
The Ritz	Longacre Theatre	1975
The Belle of Amherst	Longacre Theatre	1976
Checking Out	Longacre Theatre	1976
No Man's Land	Longacre Theatre	1976
The Basic Training of Pavlo Hummel	Longacre Theatre	1977
Jesus Christ Superstar	Longacre Theatre	1977
Ain't Misbehavin'	Longacre Theatre	1978
Faith Healer	Longacre Theatre	1979
Bosoms and Neglect	Longacre Theatre	1979
But Never Jam Today	Longacre Theatre	1979
Children of a Lesser God	Longacre Theatre	1980
Passion	Longacre Theatre	1983
Harrigan 'N Hart	Longacre Theatre	1985
A Day in the Death of Joe Egg	Longacre Theatre	1985
The Musical Comedy Murders of 1940	Longacre Theatre	1987
Tony Bennett: Steppin' Out on Broadway	Longacre Theatre	1993
Medea	Longacre Theatre	1994
The Young Man From Atlanta	Longacre Theatre	1997
Golden Child	Longacre Theatre	1998
Judgment at Nuremberg	Longacre Theatre	2001
A Thousand Clowns	Longacre Theatre	2001
One Mo' Time	Longacre Theatre	2002
Russell Simmons Def Poetry Jam	Longacre Theatre	2002
Who's Afraid of Virginia Woolf?	Longacre Theatre	2005
Well	Longacre Theatre	2006
Talk Radio	Longacre Theatre	2007
Boeing Boeing	Longacre Theatre	2008
Burn the Floor	Longacre Theatre	2009
La Cage aux Folles	Longacre Theatre	2010
Chinglish	Longacre Theatre	2011
Magic/Bird	Longacre Theatre	2012
The Performers	Longacre Theatre	2012
First Date the Musical	Longacre Theatre	2013
Of Mice and Men	Longacre Theatre	2014
You Can't Take It with You	Longacre Theatre	2014
Allegiance	Longacre Theatre	2015
A Bronx Tale	Longacre Theatre	2016
The Prom	Longacre Theatre	2018
The Lightning Thief	Longacre Theatre	2019
Diana	Longacre Theatre	2021
Macbeth	Longacre Theatre	2022
Leopoldstadt	Longacre Theatre	2022
Lempicka	Longacre Theatre	2024
Swept Away	Longacre Theatre	2024
Dead Outlaw	Longacre Theatre	2025
The Visit	Lunt-Fontanne Theatre	1958
Goldilocks	Lunt-Fontanne Theatre	1958
Les Ballets Africains	Lunt-Fontanne Theatre	1959
Much Ado About Nothing	Lunt-Fontanne Theatre	1959
The Sound of Music	Lunt-Fontanne Theatre	1959
Little Me	Lunt-Fontanne Theatre	1962
Arturo Ui	Lunt-Fontanne Theatre	1963
Luther	Lunt-Fontanne Theatre	1964
Hamlet	Lunt-Fontanne Theatre	1964
Wiener Blut	Lunt-Fontanne Theatre	1964
Ben Franklin in Paris	Lunt-Fontanne Theatre	1964
Bajour	Lunt-Fontanne Theatre	1965
Skyscraper	Lunt-Fontanne Theatre	1965
Walking Happy	Lunt-Fontanne Theatre	1966
Marlene Dietrich	Lunt-Fontanne Theatre	1967
How Now, Dow Jones	Lunt-Fontanne Theatre	1967
Her First Roman	Lunt-Fontanne Theatre	1968
You Know I Can't Hear You When the Water's Running	Lunt-Fontanne Theatre	1968
Come Summer	Lunt-Fontanne Theatre	1969
Hamlet	Lunt-Fontanne Theatre	1969
La Strada	Lunt-Fontanne Theatre	1969
Look to the Lilies	Lunt-Fontanne Theatre	1970
The Rothschilds	Lunt-Fontanne Theatre	1970
A Funny Thing Happened on the Way to the Forum	Lunt-Fontanne Theatre	1972
Ambassador	Lunt-Fontanne Theatre	1972
6 Rms Riv Vu	Lunt-Fontanne Theatre	1973
The Pajama Game	Lunt-Fontanne Theatre	1973
The Sunshine Boys	Lunt-Fontanne Theatre	1974
Raisin	Lunt-Fontanne Theatre	1975
Rex	Lunt-Fontanne Theatre	1976
My Fair Lady	Lunt-Fontanne Theatre	1976
Primitive Mysteries	Lunt-Fontanne Theatre	1977
The Shadow Box	Lunt-Fontanne Theatre	1977
Hello, Dolly!	Lunt-Fontanne Theatre	1978
A Broadway Musical	Lunt-Fontanne Theatre	1978
Beatlemania	Lunt-Fontanne Theatre	1979
Peter Pan	Lunt-Fontanne Theatre	1979
Sophisticated Ladies	Lunt-Fontanne Theatre	1981
Private Lives	Lunt-Fontanne Theatre	1983
The Corn Is Green	Lunt-Fontanne Theatre	1983
The Wiz	Lunt-Fontanne Theatre	1984
The Iceman Cometh	Lunt-Fontanne Theatre	1985
Uptown... It's Hot!	Lunt-Fontanne Theatre	1986
Smile	Lunt-Fontanne Theatre	1986
The Gospel at Colonus	Lunt-Fontanne Theatre	1988
The Threepenny Opera	Lunt-Fontanne Theatre	1989
Peter Pan	Lunt-Fontanne Theatre	1990
Oh, Kay!	Lunt-Fontanne Theatre	1991
The Best Little Whorehouse Goes Public	Lunt-Fontanne Theatre	1994
Hello, Dolly!	Lunt-Fontanne Theatre	1995
Three Sisters	Lunt-Fontanne Theatre	1996
A Midsummer Night's Dream	Lunt-Fontanne Theatre	1996
Titanic	Lunt-Fontanne Theatre	1997
Beauty and the Beast	Lunt-Fontanne Theatre	1999
The Little Mermaid	Lunt-Fontanne Theatre	2008
The Addams Family	Lunt-Fontanne Theatre	2010
Ghost the Musical	Lunt-Fontanne Theatre	2012
A Christmas Story: The Musical	Lunt-Fontanne Theatre	2012
Motown: The Musical	Lunt-Fontanne Theatre	2013
Finding Neverland	Lunt-Fontanne Theatre	2015
Frankie Valli and the Four Seasons on Broadway!	Lunt-Fontanne Theatre	2016
Kristin Chenoweth: My Love Letter to Broadway	Lunt-Fontanne Theatre	2016
Charlie and the Chocolate Factory	Lunt-Fontanne Theatre	2017
Summer: The Donna Summer Musical	Lunt-Fontanne Theatre	2018
Morrissey	Lunt-Fontanne Theatre	2019
Pure Yanni	Lunt-Fontanne Theatre	2019
Mel Brooks on Broadway	Lunt-Fontanne Theatre	2019
Regina Spektor: Live On Broadway	Lunt-Fontanne Theatre	2019
Criss Angel Raw-The Mindfreak Unplugged	Lunt-Fontanne Theatre	2019
Dave Chappelle on Broadway	Lunt-Fontanne Theatre	2019
Manilow Broadway	Lunt-Fontanne Theatre	2019
Tina: The Musical	Lunt-Fontanne Theatre	2019
Sweeney Todd	Lunt-Fontanne Theatre	2023
Death Becomes Her	Lunt-Fontanne Theatre	2024
The Admirable Crichton	Lyceum Theatre (Broadway)	1903
David Garrick	Lyceum Theatre (Broadway)	1904
A Doll's House	Lyceum Theatre (Broadway)	1905
The Truth	Lyceum Theatre (Broadway)	1907
Arsène Lupin[fr]	Lyceum Theatre (Broadway)	1909
Penelope	Lyceum Theatre (Broadway)	1909
The Pillars of Society	Lyceum Theatre (Broadway)	1910
The Assumption of Hannele	Lyceum Theatre (Broadway)	1910
The Importance of Being Earnest	Lyceum Theatre (Broadway)	1910
The Ghost Breaker	Lyceum Theatre (Broadway)	1913
John Gabriel Borkman	Lyceum Theatre (Broadway)	1915
The Great Divide	Lyceum Theatre (Broadway)	1917
The Case of Lady Camber	Lyceum Theatre (Broadway)	1917
The Gold Diggers	Lyceum Theatre (Broadway)	1919
The Merchant of Venice	Lyceum Theatre (Broadway)	1922
The School for Scandal	Lyceum Theatre (Broadway)	1923
Antony and Cleopatra	Lyceum Theatre (Broadway)	1924
Ladies of the Evening	Lyceum Theatre (Broadway)	1924
The Sport of Kings	Lyceum Theatre (Broadway)	1926
Berkeley Square	Lyceum Theatre (Broadway)	1929
Anatol	Lyceum Theatre (Broadway)	1931
Squaring the Circle	Lyceum Theatre (Broadway)	1935
St. Helena	Lyceum Theatre (Broadway)	1936
The Mother	Lyceum Theatre (Broadway)	1939
When We Are Married	Lyceum Theatre (Broadway)	1939
Junior Miss	Lyceum Theatre (Broadway)	1941
The Doughgirls	Lyceum Theatre (Broadway)	1942
Born Yesterday	Lyceum Theatre (Broadway)	1946
The Enchanted	Lyceum Theatre (Broadway)	1950
The Country Girl	Lyceum Theatre (Broadway)	1950
Anna Christie	Lyceum Theatre (Broadway)	1952
Time Out For Ginger	Lyceum Theatre (Broadway)	1952
A Hatful of Rain	Lyceum Theatre (Broadway)	1955
Look Back in Anger	Lyceum Theatre (Broadway)	1957
The Gazebo	Lyceum Theatre (Broadway)	1958
The Billy Barnes Revue	Lyceum Theatre (Broadway)	1959
Flowering Cherry	Lyceum Theatre (Broadway)	1959
Goodbye Charlie	Lyceum Theatre (Broadway)	1959
A Taste of Honey	Lyceum Theatre (Broadway)	1960
The Importance of Being Oscar	Lyceum Theatre (Broadway)	1960
Mandingo	Lyceum Theatre (Broadway)	1960
The Caretaker	Lyceum Theatre (Broadway)	1961
Ages of Man	Lyceum Theatre (Broadway)	1963
Nobody Loves an Albatross	Lyceum Theatre (Broadway)	1963
Entertaining Mr. Sloane	Lyceum Theatre (Broadway)	1965
You Can't Take It With You	Lyceum Theatre (Broadway)	1965
The School for Scandal	Lyceum Theatre (Broadway)	1966
The Wild Duck	Lyceum Theatre (Broadway)	1967
By George	Lyceum Theatre (Broadway)	1967
Exit the King	Lyceum Theatre (Broadway)	1968
The Cherry Orchard	Lyceum Theatre (Broadway)	1968
The Cocktail Party	Lyceum Theatre (Broadway)	1968
The Misanthrope	Lyceum Theatre (Broadway)	1968
Cock-a-Doodle Dandy	Lyceum Theatre (Broadway)	1969
Hamlet	Lyceum Theatre (Broadway)	1969
Three Men on a Horse	Lyceum Theatre (Broadway)	1969
Norman, Is That You?	Lyceum Theatre (Broadway)	1970
Borstal Boy	Lyceum Theatre (Broadway)	1970
The School for Wives	Lyceum Theatre (Broadway)	1971
The Great God BrownandDon Juan	Lyceum Theatre (Broadway)	1972
Out Cry	Lyceum Theatre (Broadway)	1973
The Lieutenant	Lyceum Theatre (Broadway)	1975
Something's Afoot	Lyceum Theatre (Broadway)	1976
Best Friend	Lyceum Theatre (Broadway)	1976
Your Arms Too Short to Box with God	Lyceum Theatre (Broadway)	1976
Wings	Lyceum Theatre (Broadway)	1979
Morning's at Seven	Lyceum Theatre (Broadway)	1980
"Master Harold"...and the Boys	Lyceum Theatre (Broadway)	1982
The Man Who Had Three Arms	Lyceum Theatre (Broadway)	1983
As Is	Lyceum Theatre (Broadway)	1985
Our Town	Lyceum Theatre (Broadway)	1988
Saint Joan	Lyceum Theatre (Broadway)	1993
Three Men on a Horse	Lyceum Theatre (Broadway)	1993
Timon of Athens	Lyceum Theatre (Broadway)	1993
The Government Inspector	Lyceum Theatre (Broadway)	1994
The Flowering Peach	Lyceum Theatre (Broadway)	1994
Gentlemen Prefer Blondes	Lyceum Theatre (Broadway)	1995
The School for Scandal	Lyceum Theatre (Broadway)	1995
The Gin Game	Lyceum Theatre (Broadway)	1997
The Sunshine Boys	Lyceum Theatre (Broadway)	1997
Night Must Fall	Lyceum Theatre (Broadway)	1999
The Lonesome West	Lyceum Theatre (Broadway)	1999
The Invention of Love	Lyceum Theatre (Broadway)	2001
Morning's at Seven	Lyceum Theatre (Broadway)	2002
The Play What I Wrote	Lyceum Theatre (Broadway)	2003
I Am My Own Wife	Lyceum Theatre (Broadway)	2003
Steel Magnolias	Lyceum Theatre (Broadway)	2005
Souvenir	Lyceum Theatre (Broadway)	2005
The Lieutenant of Inishmore	Lyceum Theatre (Broadway)	2006
Inherit the Wind	Lyceum Theatre (Broadway)	2007
Is He Dead?	Lyceum Theatre (Broadway)	2007
Macbeth	Lyceum Theatre (Broadway)	2008
Reasons to Be Pretty	Lyceum Theatre (Broadway)	2009
In the Next Room (or The Vibrator Play)	Lyceum Theatre (Broadway)	2009
Looped	Lyceum Theatre (Broadway)	2010
The Scottsboro Boys	Lyceum Theatre (Broadway)	2010
Venus in Fur	Lyceum Theatre (Broadway)	2012
The Nance	Lyceum Theatre (Broadway)	2013
The Realistic Joneses	Lyceum Theatre (Broadway)	2014
Disgraced	Lyceum Theatre (Broadway)	2014
The Visit	Lyceum Theatre (Broadway)	2015
A View from the Bridge	Lyceum Theatre (Broadway)	2015
Fully Committed	Lyceum Theatre (Broadway)	2016
Oh, Hello	Lyceum Theatre (Broadway)	2016
The Play That Goes Wrong	Lyceum Theatre (Broadway)	2017
Be More Chill	Lyceum Theatre (Broadway)	2019
A Christmas Carol	Lyceum Theatre (Broadway)	2019
Is This a RoomandDana H.	Lyceum Theatre (Broadway)	2021
A Strange Loop	Lyceum Theatre (Broadway)	2022
Grey House	Lyceum Theatre (Broadway)	2023
Oh, Mary!	Lyceum Theatre (Broadway)	2024
Ragtime	Lyric Theatre (New York City, 1998)	1998
Jesus Christ Superstar	Lyric Theatre (New York City, 1998)	2000
42nd Street	Lyric Theatre (New York City, 1998)	2001
Chitty Chitty Bang Bang	Lyric Theatre (New York City, 1998)	2005
Hot Feet	Lyric Theatre (New York City, 1998)	2006
Dr. Seuss' How the Grinch Stole Christmas!	Lyric Theatre (New York City, 1998)	2006
The Pirate Queen	Lyric Theatre (New York City, 1998)	2007
Young Frankenstein	Lyric Theatre (New York City, 1998)	2007
Spider-Man: Turn Off the Dark	Lyric Theatre (New York City, 1998)	2011
On the Town	Lyric Theatre (New York City, 1998)	2014
Lord of the Dance: Dangerous Games	Lyric Theatre (New York City, 1998)	2015
Paramour	Lyric Theatre (New York City, 1998)	2016
Harry Potter and the Cursed Child	Lyric Theatre (New York City, 1998)	2018
Rang Tang	Majestic Theatre (Broadway)	1927
Rio Rita	Majestic Theatre (Broadway)	1928
Artists and Models	Majestic Theatre (Broadway)	1930
The Student Prince	Majestic Theatre (Broadway)	1931
Simple Simon	Majestic Theatre (Broadway)	1931
The Round Up	Majestic Theatre (Broadway)	1932
Pardon My English	Majestic Theatre (Broadway)	1933
The Bohemian Girl	Majestic Theatre (Broadway)	1933
The Pirates of Penzance	Majestic Theatre (Broadway)	1933
The Yeomen of the Guard	Majestic Theatre (Broadway)	1933
At Home Abroad	Majestic Theatre (Broadway)	1936
On Your Toes	Majestic Theatre (Broadway)	1936
The Masque of Kings	Majestic Theatre (Broadway)	1937
The Bat	Majestic Theatre (Broadway)	1937
Miss Universe 1981	Minskoff Theatre	1981
The Cat and the Canary	Majestic Theatre (Broadway)	1937
Babes in Arms	Majestic Theatre (Broadway)	1937
Margin for Error	Majestic Theatre (Broadway)	1940
Hellzapoppin	Majestic Theatre (Broadway)	1941
Porgy and Bess	Majestic Theatre (Broadway)	1942
Native Son	Majestic Theatre (Broadway)	1942
Junior Miss	Majestic Theatre (Broadway)	1943
The Merry Widow	Majestic Theatre (Broadway)	1943
Mexican Hayride	Majestic Theatre (Broadway)	1944
Carousel	Majestic Theatre (Broadway)	1945
Oedipus Rex	Majestic Theatre (Broadway)	1946
The Mayor of Zalamea	Majestic Theatre (Broadway)	1947
Alice in Wonderland	Majestic Theatre (Broadway)	1947
Call Me Mister	Majestic Theatre (Broadway)	1947
Allegro	Majestic Theatre (Broadway)	1947
Inside U.S.A.	Majestic Theatre (Broadway)	1948
South Pacific	Majestic Theatre (Broadway)	1949
Me and Juliet	Majestic Theatre (Broadway)	1953
By the Beautiful Sea	Majestic Theatre (Broadway)	1954
Fanny	Majestic Theatre (Broadway)	1954
Happy Hunting	Majestic Theatre (Broadway)	1956
The Music Man	Majestic Theatre (Broadway)	1957
Camelot	Majestic Theatre (Broadway)	1960
The School for Scandal	Majestic Theatre (Broadway)	1963
Hot Spot	Majestic Theatre (Broadway)	1963
Tovarich	Majestic Theatre (Broadway)	1963
Jennie	Majestic Theatre (Broadway)	1963
Anyone Can Whistle	Majestic Theatre (Broadway)	1964
A Funny Thing Happened on the Way to the Forum	Majestic Theatre (Broadway)	1964
Golden Boy	Majestic Theatre (Broadway)	1964
Funny Girl	Majestic Theatre (Broadway)	1966
Breakfast at Tiffany's	Majestic Theatre (Broadway)	1966
Marat/Sade	Majestic Theatre (Broadway)	1967
Fiddler on the Roof	Majestic Theatre (Broadway)	1967
Lovely Ladies, Kind Gentlemen	Majestic Theatre (Broadway)	1970
1776	Majestic Theatre (Broadway)	1971
Sugar	Majestic Theatre (Broadway)	1972
A Little Night Music	Majestic Theatre (Broadway)	1973
Mack & Mabel	Majestic Theatre (Broadway)	1974
The Wiz	Majestic Theatre (Broadway)	1975
The Act	Majestic Theatre (Broadway)	1977
First Monday in October	Majestic Theatre (Broadway)	1978
Ballroom	Majestic Theatre (Broadway)	1978
I Remember Mama	Majestic Theatre (Broadway)	1979
The Most Happy Fella	Majestic Theatre (Broadway)	1979
Bette! Divine Madness	Majestic Theatre (Broadway)	1979
Grease	Majestic Theatre (Broadway)	1980
Brigadoon	Majestic Theatre (Broadway)	1980
42nd Street	Majestic Theatre (Broadway)	1981
The Phantom of the Opera	Majestic Theatre (Broadway)	1988
Gypsy	Majestic Theatre (Broadway)	2024
Shirley Bassey	Marquis Theatre	1986
Me and My Girl	Marquis Theatre	1986
Shogun: The Musical	Marquis Theatre	1990
Gypsy	Marquis Theatre	1991
Nick & Nora	Marquis Theatre	1991
Man of La Mancha	Marquis Theatre	1992
The Goodbye Girl	Marquis Theatre	1993
Damn Yankees	Marquis Theatre	1994
Victor/Victoria	Marquis Theatre	1995
The Capeman	Marquis Theatre	1998
Peter Pan	Marquis Theatre	1998
Annie Get Your Gun	Marquis Theatre	1999
Thoroughly Modern Millie	Marquis Theatre	2002
La Cage aux Folles	Marquis Theatre	2004
The Woman in White	Marquis Theatre	2005
The Drowsy Chaperone	Marquis Theatre	2006
Cry-Baby	Marquis Theatre	2008
Irving Berlin's White Christmas	Marquis Theatre	2008
Soul of Shaolin	Marquis Theatre	2009
9 to 5	Marquis Theatre	2009
Irving Berlin's White Christmas	Marquis Theatre	2009
Come Fly Away	Marquis Theatre	2010
Wonderland: Alice's New Musical Adventure	Marquis Theatre	2011
Follies	Marquis Theatre	2011
Evita	Marquis Theatre	2012
Jekyll & Hyde	Marquis Theatre	2013
Il Divo - A Musical Affair: The Greatest Songs of Broadway	Marquis Theatre	2013
The Illusionists: Witness the Impossible	Marquis Theatre	2014
Penn & Teller on Broadway	Marquis Theatre	2015
On Your Feet!	Marquis Theatre	2015
Lewis Black: Black to the Future	Marquis Theatre	2017
Escape to Margaritaville	Marquis Theatre	2018
The Illusionists - Magic of the Holidays	Marquis Theatre	2018
Tootsie	Marquis Theatre	2019
Beetlejuice	Marquis Theatre	2022
Jonas Brothers on Broadway	Marquis Theatre	2023
Once Upon a One More Time	Marquis Theatre	2023
The Wiz	Marquis Theatre	2024
Elf the Musical	Marquis Theatre	2024
Stranger Things: The First Shadow	Marquis Theatre	2025
Irene	Minskoff Theatre	1973
Charles Aznavouron Broadway	Minskoff Theatre	1974
Tony&LenaSing	Minskoff Theatre	1974
Bette Midler's Clams on the Half Shell Revue	Minskoff Theatre	1975
Hello, Dolly!	Minskoff Theatre	1975
Rockabye Hamlet	Minskoff Theatre	1976
Debbie	Minskoff Theatre	1976
Dutch National Ballet	Minskoff Theatre	1976
Merce CunninghamDance Company	Minskoff Theatre	1977
Pippin	Minskoff Theatre	1977
Cleoon Broadway	Minskoff Theatre	1977
Dutch National Ballet	Minskoff Theatre	1978
Angel	Minskoff Theatre	1978
King of Hearts	Minskoff Theatre	1978
Bejart: Ballet of the Twentieth Century	Minskoff Theatre	1979
Shirley Basseyon Broadway	Minskoff Theatre	1979
Engelberton Broadway	Minskoff Theatre	1979
West Side Story	Minskoff Theatre	1980
Can-Can	Minskoff Theatre	1981
The Pirates of Penzance	Minskoff Theatre	1981
Dance a Little Closer	Minskoff Theatre	1983
Marilyn: An American Fable	Minskoff Theatre	1983
The Tap Dance Kid	Minskoff Theatre	1984
Patti LaBelle	Minskoff Theatre	1986
Peter, Paul & Mary "From Bleecker to Broadway"	Minskoff Theatre	1986
The TemptationsandThe Four Tops	Minskoff Theatre	1986
Sweet Charity	Minskoff Theatre	1986
Teddy & Alice	Minskoff Theatre	1987
Cabaret	Minskoff Theatre	1988
Black and Blue	Minskoff Theatre	1989
Peter Pan	Minskoff Theatre	1991
Metro	Minskoff Theatre	1992
Joseph and the Amazing Technicolor Dreamcoat	Minskoff Theatre	1993
Sunset Boulevard	Minskoff Theatre	1994
The Scarlet Pimpernel	Minskoff Theatre	1997
Saturday Night Fever	Minskoff Theatre	1999
The Adventures of Tom Sawyer	Minskoff Theatre	2001
Dance of the Vampires	Minskoff Theatre	2002
Fiddler on the Roof	Minskoff Theatre	2004
The Lion King	Minskoff Theatre	2006
Music Box Revue	Music Box Theatre	1921
Earl Carroll's Vanities	Music Box Theatre	1924
Chicago	Music Box Theatre	1926
Paris	Music Box Theatre	1928
Topaze	Music Box Theatre	1930
Once in a Lifetime	Music Box Theatre	1930
Of Thee I Sing	Music Box Theatre	1931
Dinner at Eight	Music Box Theatre	1932
As Thousands Cheer	Music Box Theatre	1933
Merrily We Roll Along	Music Box Theatre	1934
Rain	Music Box Theatre	1935
Ceiling Zero	Music Box Theatre	1935
If This Be Treason	Music Box Theatre	1935
Pride and Prejudice	Music Box Theatre	1935
First Lady	Music Box Theatre	1935
Stage Door	Music Box Theatre	1936
Of Mice and Men	Music Box Theatre	1937
I'd Rather Be Right	Music Box Theatre	1938
Set to Music	Music Box Theatre	1939
The Man Who Came to Dinner	Music Box Theatre	1939
The Land Is Bright	Music Box Theatre	1941
A Kiss for Cinderella	Music Box Theatre	1942
Star and Garter	Music Box Theatre	1942
Over 21	Music Box Theatre	1944
I Remember Mama	Music Box Theatre	1944
A Flag Is Born	Music Box Theatre	1946
The Linden Tree	Music Box Theatre	1948
Summer and Smoke	Music Box Theatre	1948
They Knew What They Wanted	Music Box Theatre	1949
Mrs. Gibbons' Boys	Music Box Theatre	1949
Lost in the Stars	Music Box Theatre	1949
Daphne Laureola	Music Box Theatre	1950
Affairs of State	Music Box Theatre	1950
Much Ado About Nothing	Music Box Theatre	1952
The Male Animal	Music Box Theatre	1952
Picnic	Music Box Theatre	1953
The Solid Gold Cadillac	Music Box Theatre	1954
Bus Stop	Music Box Theatre	1955
The Ponder Heart	Music Box Theatre	1956
Separate Tables	Music Box Theatre	1956
Miss Lonelyhearts	Music Box Theatre	1957
The Dark at the Top of the Stairs	Music Box Theatre	1957
Rashomon	Music Box Theatre	1959
Five Finger Exercise	Music Box Theatre	1959
A Far Country	Music Box Theatre	1961
Daughter of Silence	Music Box Theatre	1961
The Beauty Part	Music Box Theatre	1962
Semi-Detached	Music Box Theatre	1963
Any Wednesday	Music Box Theatre	1964
Wait Until Dark	Music Box Theatre	1966
The Homecoming	Music Box Theatre	1967
There's a Girl in My Soup	Music Box Theatre	1967
Lovers	Music Box Theatre	1968
Harkness Ballet	Music Box Theatre	1968
The Watering Place	Music Box Theatre	1969
Sleuth	Music Box Theatre	1970
Veronica's Room	Music Box Theatre	1973
Absurd Person Singular	Music Box Theatre	1974
Who's Afraid of Virginia Woolf?	Music Box Theatre	1976
Comedians	Music Box Theatre	1976
Side by Side by Sondheim	Music Box Theatre	1977
Deathtrap	Music Box Theatre	1978
Agnes of God	Music Box Theatre	1982
Open Admissions	Music Box Theatre	1984
The Octette Bridge Club	Music Box Theatre	1985
Hay Fever	Music Box Theatre	1985
Loot	Music Box Theatre	1986
Sweet Sue	Music Box Theatre	1987
Les Liaisons Dangereuses	Music Box Theatre	1987
Welcome to the Club	Music Box Theatre	1989
A Few Good Men	Music Box Theatre	1989
A Small Family Business	Music Box Theatre	1992
Blood Brothers	Music Box Theatre	1993
Swinging on a Star	Music Box Theatre	1995
State Fair	Music Box Theatre	1996
Barrymore	Music Box Theatre	1997
The Diary of Anne Frank	Music Box Theatre	1997
Closer	Music Box Theatre	1999
Amadeus	Music Box Theatre	1999
Macbeth	Music Box Theatre	2000
The Dinner Party	Music Box Theatre	2000
Fortune's Fool	Music Box Theatre	2002
Amour	Music Box Theatre	2002
Cat on a Hot Tin Roof	Music Box Theatre	2003
In My Life	Music Box Theatre	2005
Festen	Music Box Theatre	2006
The Vertical Hour	Music Box Theatre	2006
Deuce	Music Box Theatre	2007
The Farnsworth Invention	Music Box Theatre	2007
August: Osage County	Music Box Theatre	2008
Superior Donuts	Music Box Theatre	2009
Lend Me a Tenor	Music Box Theatre	2010
La Bête	Music Box Theatre	2010
Jerusalem	Music Box Theatre	2011
Private Lives	Music Box Theatre	2011
One Man, Two Guvnors	Music Box Theatre	2012
Dead Accounts	Music Box Theatre	2012
Pippin	Music Box Theatre	2013
The Heidi Chronicles	Music Box Theatre	2015
King Charles III	Music Box Theatre	2015
Shuffle Along, or, the Making of the Musical Sensation of 1921 and All That Followed	Music Box Theatre	2016
Dear Evan Hansen	Music Box Theatre	2016
Walking with Ghosts	Music Box Theatre	2022
Dancin'	Music Box Theatre	2023
Purlie Victorious	Music Box Theatre	2023
Suffs	Music Box Theatre	2024
The Picture of Dorian Gray	Music Box Theatre	2025
Art	Music Box Theatre	2025
Whose Life Is It Anyway?	Nederlander Theatre	1979
Betrayal	Nederlander Theatre	1980
One Night Stand	Nederlander Theatre	1980
Lena Horne: The Lady and Her Music	Nederlander Theatre	1981
84 Charing Cross Road	Nederlander Theatre	1982
Teaneck Tanzi: The Venus Flytrap	Nederlander Theatre	1983
Amen Corner	Nederlander Theatre	1983
Strange Interlude	Nederlander Theatre	1985
Robert Klein on Broadway	Nederlander Theatre	1986
Raggedy Ann	Nederlander Theatre	1986
Our Country's Good	Nederlander Theatre	1991
Rent	Nederlander Theatre	1996
Guys and Dolls	Nederlander Theatre	2009
Brighton Beach Memoirs	Nederlander Theatre	2009
Million Dollar Quartet	Nederlander Theatre	2010
Newsies	Nederlander Theatre	2012
Honeymoon in Vegas	Nederlander Theatre	2015
Amazing Grace	Nederlander Theatre	2015
Disaster!	Nederlander Theatre	2016
Motown: The Musical	Nederlander Theatre	2016
War Paint	Nederlander Theatre	2017
Pretty Woman: The Musical	Nederlander Theatre	2018
Kristin Chenoweth: For The Girls	Nederlander Theatre	2019
Harry Connick, Jr.: A Celebration of Cole Porter	Nederlander Theatre	2019
The Lehman Trilogy	Nederlander Theatre	2021
Mr. Saturday Night	Nederlander Theatre	2022
A Christmas Carol	Nederlander Theatre	2022
Shucked	Nederlander Theatre	2023
The Who's Tommy	Nederlander Theatre	2024
Redwood	Nederlander Theatre	2025
Biloxi Blues	Neil Simon Theatre	1985
Into the Light	Neil Simon Theatre	1986
Blithe Spirit	Neil Simon Theatre	1987
Mort Sahlon Broadway!	Neil Simon Theatre	1987
Breaking the Code	Neil Simon Theatre	1987
Long Day's Journey into Night	Neil Simon Theatre	1988
Ah, Wilderness!	Neil Simon Theatre	1988
Kenny Logginson Broadway	Neil Simon Theatre	1988
Orpheus Descending	Neil Simon Theatre	1989
Jackie Mason: Brand New	Neil Simon Theatre	1990
Jake's Women	Neil Simon Theatre	1992
Cyrano: The Musical	Neil Simon Theatre	1993
The Rise and Fall of Little Voice	Neil Simon Theatre	1994
Basiaon Broadway	Neil Simon Theatre	1994
Laurie Andersonon Broadway: The Nerve Bible	Neil Simon Theatre	1995
Danny Ganson Broadway: The Man of Many Voices	Neil Simon Theatre	1995
The King and I	Neil Simon Theatre	1996
A View from the Bridge	Neil Simon Theatre	1998
Swan Lake	Neil Simon Theatre	1998
Natalie Merchant	Neil Simon Theatre	1999
The Scarlet Pimpernel	Neil Simon Theatre	1999
The Music Man	Neil Simon Theatre	2000
Elaine Stritch at Liberty	Neil Simon Theatre	2002
Hairspray	Neil Simon Theatre	2002
Ragtime	Neil Simon Theatre	2009
Harry Connick Jr.: In Concert on Broadway	Neil Simon Theatre	2010
Rain: A Tribute to the Beatles	Neil Simon Theatre	2010
Catch Me If You Can	Neil Simon Theatre	2011
Jesus Christ Superstar	Neil Simon Theatre	2012
Scandalous	Neil Simon Theatre	2012
Big Fish	Neil Simon Theatre	2013
All the Way	Neil Simon Theatre	2014
The Last Ship	Neil Simon Theatre	2014
Gigi	Neil Simon Theatre	2015
The Illusionists: Live on Broadway	Neil Simon Theatre	2015
Cats	Neil Simon Theatre	2016
Angels in America	Neil Simon Theatre	2018
The Illusionists: Magic of the Holidays	Neil Simon Theatre	2019
MJ the Musical	Neil Simon Theatre	2022
A Midsummer Night's Dream	New Amsterdam Theatre	1903
Whoop-Dee-Doo	New Amsterdam Theatre	1903
Mother Goose	New Amsterdam Theatre	1903
The Two Orphans	New Amsterdam Theatre	1904
She Stoops to Conquer	New Amsterdam Theatre	1905
Richard III	New Amsterdam Theatre	1905
Forty-five Minutes from Broadway	New Amsterdam Theatre	1906
The Merry Widow	New Amsterdam Theatre	1907
Peer Gynt	New Amsterdam Theatre	1907
The Silver Star	New Amsterdam Theatre	1909
Madame X	New Amsterdam Theatre	1910
The Pink Lady	New Amsterdam Theatre	1911
Ben-Hur	New Amsterdam Theatre	1911
The Count of Luxembourg	New Amsterdam Theatre	1912
Oh! Oh! Delphine	New Amsterdam Theatre	1913
Ziegfeld Follies	New Amsterdam Theatre	1913
Sweethearts	New Amsterdam Theatre	1913
Watch Your Step	New Amsterdam Theatre	1914
The Girl Behind the Gun	New Amsterdam Theatre	1918
Sally	New Amsterdam Theatre	1920
Sunny	New Amsterdam Theatre	1925
Trelawny of the 'Wells'	New Amsterdam Theatre	1927
Rosalie	New Amsterdam Theatre	1928
Whoopee	New Amsterdam Theatre	1928
Earl Carroll's Vanities	New Amsterdam Theatre	1930
The Band Wagon	New Amsterdam Theatre	1931
Face the Music	New Amsterdam Theatre	1932
Alice in Wonderland	New Amsterdam Theatre	1933
The Cherry Orchard	New Amsterdam Theatre	1933
Roberta	New Amsterdam Theatre	1933
Revenge with Music	New Amsterdam Theatre	1934
George White's Scandals	New Amsterdam Theatre	1936
Othello	New Amsterdam Theatre	1937
King David	New Amsterdam Theatre	1997
The Lion King	New Amsterdam Theatre	1997
Chess	New Amsterdam Theatre	2003
Mary Poppins	New Amsterdam Theatre	2006
Aladdin	New Amsterdam Theatre	2014
Sweet Charity	Palace Theatre (New York City)	1966
Henry, Sweet Henry	Palace Theatre (New York City)	1967
George M!	Palace Theatre (New York City)	1968
Applause	Palace Theatre (New York City)	1970
Cyrano	Palace Theatre (New York City)	1973
Bette Midler	Palace Theatre (New York City)	1973
Lorelei	Palace Theatre (New York City)	1974
Goodtime Charley	Palace Theatre (New York City)	1975
Home Sweet Homer	Palace Theatre (New York City)	1976
Shirley MacLaine Live at the Palace	Palace Theatre (New York City)	1976
An Evening with Diana Ross	Palace Theatre (New York City)	1976
Man of La Mancha	Palace Theatre (New York City)	1977
The Grand Tour	Palace Theatre (New York City)	1979
Beatlemania	Palace Theatre (New York City)	1979
Oklahoma!	Palace Theatre (New York City)	1979
Woman of the Year	Palace Theatre (New York City)	1981
La Cage aux Folles	Palace Theatre (New York City)	1983
The Will Rogers Follies	Palace Theatre (New York City)	1991
Beauty and the Beast	Palace Theatre (New York City)	1994
Minnelli on Minnelli: Live at the Palace	Palace Theatre (New York City)	1999
Aida	Palace Theatre (New York City)	2000
All Shook Up	Palace Theatre (New York City)	2005
Lestat	Palace Theatre (New York City)	2006
Legally Blonde	Palace Theatre (New York City)	2007
Liza's at The Palace....	Palace Theatre (New York City)	2008
West Side Story	Palace Theatre (New York City)	2009
Priscilla Queen of the Desert	Palace Theatre (New York City)	2011
Annie	Palace Theatre (New York City)	2012
Holler If Ya Hear Me	Palace Theatre (New York City)	2014
The Temptationsand theFour Topson Broadway	Palace Theatre (New York City)	2014
An American in Paris	Palace Theatre (New York City)	2015
The Illusionists: Turn of the Century	Palace Theatre (New York City)	2016
Sunset Boulevard	Palace Theatre (New York City)	2017
SpongeBob SquarePants	Palace Theatre (New York City)	2017
Ben Platt: Live at the Palace	Palace Theatre (New York City)	2024
Tammy Faye	Palace Theatre (New York City)	2024
Glengarry Glen Ross	Palace Theatre (New York City)	2025
Beetlejuice	Palace Theatre (New York City)	2025
The Lost Boys	Palace Theatre (New York City)	2026
Oh, Kay!	Richard Rodgers Theatre	1990
Lost in Yonkers	Richard Rodgers Theatre	1991
Fool Moon	Richard Rodgers Theatre	1993
Laughter on the 23rd Floor	Richard Rodgers Theatre	1993
A Christmas Carol	Richard Rodgers Theatre	1994
How to Succeed in Business Without Really Trying	Richard Rodgers Theatre	1995
Chicago	Richard Rodgers Theatre	1996
Steel Pier	Richard Rodgers Theatre	1997
Footloose	Richard Rodgers Theatre	1998
Seussical	Richard Rodgers Theatre	2000
45 Seconds from Broadway	Richard Rodgers Theatre	2001
Private Lives	Richard Rodgers Theatre	2002
Movin' Out	Richard Rodgers Theatre	2002
Tarzan	Richard Rodgers Theatre	2006
Cyrano de Bergerac	Richard Rodgers Theatre	2007
In The Heights	Richard Rodgers Theatre	2008
Bengal Tiger at the Baghdad Zoo	Richard Rodgers Theatre	2011
Porgy and Bess	Richard Rodgers Theatre	2012
Lewis Black: Running on Empty	Richard Rodgers Theatre	2012
Cat on a Hot Tin Roof	Richard Rodgers Theatre	2012
The Rascals: Once Upon a Dream	Richard Rodgers Theatre	2013
Romeo and Juliet	Richard Rodgers Theatre	2013
If/Then	Richard Rodgers Theatre	2014
Hamilton	Richard Rodgers Theatre	2015
She Stoops to Conquer	St. James Theatre	1928
Diplomacy	St. James Theatre	1928
Billie	St. James Theatre	1928
The Rivals	St. James Theatre	1930
Fine and Dandy	St. James Theatre	1930
The Merry Widow	St. James Theatre	1931
The Chocolate Soldier	St. James Theatre	1931
The Geisha	St. James Theatre	1931
The Chimes of Normandy	St. James Theatre	1931
Naughty Marietta	St. James Theatre	1931
The Firefly	St. James Theatre	1931
The Gondoliers	St. James Theatre	1932
Robin Hood	St. James Theatre	1932
Walk a Little Faster	St. James Theatre	1932
Ballet Russe de Monte-Carlo	St. James Theatre	1933
The Chocolate Soldier	St. James Theatre	1934
Thumbs Up!	St. James Theatre	1934
May Wine	St. James Theatre	1935
Love from a Stranger	St. James Theatre	1936
Richard II	St. James Theatre	1937
Father Malachy's Miracle	St. James Theatre	1937
Hamlet	St. James Theatre	1938
King Henry IV, Part 1	St. James Theatre	1939
Earl Carroll's Vanities (1940)	St. James Theatre	1940
Twelfth Night	St. James Theatre	1940
Native Son	St. James Theatre	1941
Pal Joey	St. James Theatre	1941
Claudia	St. James Theatre	1942
Without Love	St. James Theatre	1942
Oklahoma!	St. James Theatre	1943
Where's Charley?	St. James Theatre	1948
Peter Pan	St. James Theatre	1950
The King and I	St. James Theatre	1951
The Pajama Game	St. James Theatre	1954
Li'l Abner	St. James Theatre	1956
Flower Drum Song	St. James Theatre	1958
Once Upon a Mattress	St. James Theatre	1960
Becket	St. James Theatre	1960
Do Re Mi	St. James Theatre	1960
Subways Are for Sleeping	St. James Theatre	1961
Mr. President	St. James Theatre	1962
Luther	St. James Theatre	1963
Hello, Dolly!	St. James Theatre	1964
1776	St. James Theatre	1970
Two Gentlemen of Verona	St. James Theatre	1971
Good News	St. James Theatre	1974
The Misanthrope	St. James Theatre	1975
My Fair Lady	St. James Theatre	1976
Music Is	St. James Theatre	1976
Vieux Carre	St. James Theatre	1977
On the Twentieth Century	St. James Theatre	1978
Carmelina	St. James Theatre	1979
The 1940's Radio Hour	St. James Theatre	1979
Filumena	St. James Theatre	1980
Barnum	St. James Theatre	1980
Rock 'N Roll! The First 5,000 Years	St. James Theatre	1982
My One and Only	St. James Theatre	1983
Jerry's Girls	St. James Theatre	1985
42nd Street	St. James Theatre	1987
Gypsy	St. James Theatre	1989
The Secret Garden	St. James Theatre	1991
The Who's Tommy	St. James Theatre	1993
A Funny Thing Happened on the Way to the Forum	St. James Theatre	1996
Patti LaBelle on Broadway	St. James Theatre	1998
High Society	St. James Theatre	1998
The Civil War	St. James Theatre	1999
Swing!	St. James Theatre	1999
The Producers	St. James Theatre	2001
Dr. Seuss' How the Grinch Stole Christmas!	St. James Theatre	2007
Gypsy	St. James Theatre	2008
Desire Under the Elms	St. James Theatre	2009
Finian's Rainbow	St. James Theatre	2009
American Idiot	St. James Theatre	2010
Hair	St. James Theatre	2011
On a Clear Day You Can See Forever	St. James Theatre	2011
Leap of Faith	St. James Theatre	2012
Bring It On: The Musical	St. James Theatre	2012
Barry Manilow - "Manilow on Broadway: Live at the St. James"	St. James Theatre	2013
Let It Be	St. James Theatre	2013
Bullets Over Broadway	St. James Theatre	2014
Something Rotten!	St. James Theatre	2015
Present Laughter	St. James Theatre	2017
Frozen	St. James Theatre	2018
Springsteen on Broadway	St. James Theatre	2021
David Byrne's American Utopia	St. James Theatre	2021
Into the Woods	St. James Theatre	2022
New York, New York	St. James Theatre	2023
Spamalot	St. James Theatre	2023
Illinoise	St. James Theatre	2024
Sunset Boulevard	St. James Theatre	2024
Trisha Paytas' Big Broadway Dream	St. James Theatre	2025
The Queen of Versailles	St. James Theatre	2025
Loose Ankles	Samuel J. Friedman Theatre	1926
Old Bill, M.P.	Samuel J. Friedman Theatre	1926
The Marquise	Samuel J. Friedman Theatre	1927
Pleasure Man	Samuel J. Friedman Theatre	1928
The Nut Farm	Samuel J. Friedman Theatre	1929
Carry Nation	Samuel J. Friedman Theatre	1932
The Family Upstairs	Samuel J. Friedman Theatre	1933
Triple-A Plowed Under	Samuel J. Friedman Theatre	1936
Brother Rat	Samuel J. Friedman Theatre	1936
What a Life	Samuel J. Friedman Theatre	1938
See My Lawyer	Samuel J. Friedman Theatre	1939
The Unconquered	Samuel J. Friedman Theatre	1940
Jupiter Laughs	Samuel J. Friedman Theatre	1940
My Sister Eileen	Samuel J. Friedman Theatre	1940
Kiss and Tell	Samuel J. Friedman Theatre	1943
No Exit	Samuel J. Friedman Theatre	1946
The Heiress	Samuel J. Friedman Theatre	1947
The Silver Whistle	Samuel J. Friedman Theatre	1948
Billy Budd	Samuel J. Friedman Theatre	1951
Take Her, She's Mine	Samuel J. Friedman Theatre	1961
Andorra	Samuel J. Friedman Theatre	1963
Barefoot in the Park	Samuel J. Friedman Theatre	1963
The Ninety Day Mistress	Samuel J. Friedman Theatre	1967
Staircase	Samuel J. Friedman Theatre	1968
Loot	Samuel J. Friedman Theatre	1968
Hair	Samuel J. Friedman Theatre	1968
Knock Knock	Samuel J. Friedman Theatre	1976
The Robber Bridegroom	Samuel J. Friedman Theatre	1976
Hair	Samuel J. Friedman Theatre	1977
The Effect of Gamma Rays on Man-in-the-Moon Marigolds	Samuel J. Friedman Theatre	1978
Nuts	Samuel J. Friedman Theatre	1980
The American Clock	Samuel J. Friedman Theatre	1980
A Talent for Murder	Samuel J. Friedman Theatre	1981
Deathtrap	Samuel J. Friedman Theatre	1982
Whodunnit	Samuel J. Friedman Theatre	1982
Doonesbury	Samuel J. Friedman Theatre	1983
The Violet Hour	Samuel J. Friedman Theatre	2003
Sight Unseen	Samuel J. Friedman Theatre	2004
Reckless	Samuel J. Friedman Theatre	2004
Brooklyn Boy	Samuel J. Friedman Theatre	2005
After the Night and the Music	Samuel J. Friedman Theatre	2005
Absurd Person Singular	Samuel J. Friedman Theatre	2005
Rabbit Hole	Samuel J. Friedman Theatre	2006
Shining City	Samuel J. Friedman Theatre	2006
Translations	Samuel J. Friedman Theatre	2007
LoveMusik	Samuel J. Friedman Theatre	2007
Mauritius	Samuel J. Friedman Theatre	2007
Come Back, Little Sheba	Samuel J. Friedman Theatre	2008
Top Girls	Samuel J. Friedman Theatre	2008
To Be or Not To Be	Samuel J. Friedman Theatre	2008
The American Plan	Samuel J. Friedman Theatre	2009
Accent on Youth	Samuel J. Friedman Theatre	2009
The Royal Family	Samuel J. Friedman Theatre	2009
Time Stands Still	Samuel J. Friedman Theatre	2010
Collected Stories	Samuel J. Friedman Theatre	2010
The Pitmen Painters	Samuel J. Friedman Theatre	2010
Good People	Samuel J. Friedman Theatre	2011
Master Class	Samuel J. Friedman Theatre	2011
Venus in Fur	Samuel J. Friedman Theatre	2011
Wit	Samuel J. Friedman Theatre	2012
The Columnist	Samuel J. Friedman Theatre	2012
An Enemy of the People	Samuel J. Friedman Theatre	2012
The Other Place	Samuel J. Friedman Theatre	2013
The Assembled Parties	Samuel J. Friedman Theatre	2013
The Snow Geese	Samuel J. Friedman Theatre	2013
Outside Mullingar	Samuel J. Friedman Theatre	2014
Casa Valentina	Samuel J. Friedman Theatre	2014
The Country House	Samuel J. Friedman Theatre	2014
Constellations	Samuel J. Friedman Theatre	2015
Airline Highway	Samuel J. Friedman Theatre	2015
Fool for Love	Samuel J. Friedman Theatre	2015
Our Mother's Brief Affair	Samuel J. Friedman Theatre	2016
The Father	Samuel J. Friedman Theatre	2016
Heisenberg	Samuel J. Friedman Theatre	2016
Jitney	Samuel J. Friedman Theatre	2017
The Little Foxes	Samuel J. Friedman Theatre	2017
Prince of Broadway	Samuel J. Friedman Theatre	2017
The Children	Samuel J. Friedman Theatre	2017
Saint Joan	Samuel J. Friedman Theatre	2018
The Nap	Samuel J. Friedman Theatre	2018
Choir Boy	Samuel J. Friedman Theatre	2019
Ink	Samuel J. Friedman Theatre	2019
The Height of the Storm	Samuel J. Friedman Theatre	2019
Lackawanna Blues	Samuel J. Friedman Theatre	2021
Skeleton Crew	Samuel J. Friedman Theatre	2022
How I Learned to Drive	Samuel J. Friedman Theatre	2022
Cost of Living	Samuel J. Friedman Theatre	2022
The Collaboration	Samuel J. Friedman Theatre	2022
Summer, 1976	Samuel J. Friedman Theatre	2023
Jaja's African Hair Braiding	Samuel J. Friedman Theatre	2023
Prayer for the French Republic	Samuel J. Friedman Theatre	2024
Mary Jane	Samuel J. Friedman Theatre	2024
Eureka Day	Samuel J. Friedman Theatre	2024
Stephen Sondheim's Old Friends	Samuel J. Friedman Theatre	2025
To-Night's the Night	Shubert Theatre (Broadway)	1914
Trilby	Shubert Theatre (Broadway)	1915
If I Were King	Shubert Theatre (Broadway)	1916
Love O' Mike	Shubert Theatre (Broadway)	1917
Eileen	Shubert Theatre (Broadway)	1917
Her Soldier Boy	Shubert Theatre (Broadway)	1917
Maytime	Shubert Theatre (Broadway)	1917
The Copperhead	Shubert Theatre (Broadway)	1918
Sometime	Shubert Theatre (Broadway)	1918
Oh, What A Girl!	Shubert Theatre (Broadway)	1919
The Blue Flame	Shubert Theatre (Broadway)	1920
Greenwich Village Follies	Shubert Theatre (Broadway)	1920
The Hotel Mouse	Shubert Theatre (Broadway)	1922
Red Pepper	Shubert Theatre (Broadway)	1922
Blossom Time	Shubert Theatre (Broadway)	1923
Artists and Models	Shubert Theatre (Broadway)	1923
Othello	Shubert Theatre (Broadway)	1925
Sky High	Shubert Theatre (Broadway)	1925
Beggar on Horseback	Shubert Theatre (Broadway)	1925
Princess Ida	Shubert Theatre (Broadway)	1925
Countess Maritza	Shubert Theatre (Broadway)	1926
And So To Bed	Shubert Theatre (Broadway)	1927
Harry Delmar's Revels	Shubert Theatre (Broadway)	1927
The Five O'Clock Girl	Shubert Theatre (Broadway)	1928
The Street Singer	Shubert Theatre (Broadway)	1929
Symphony in Two Flats	Shubert Theatre (Broadway)	1930
The Last Enemy	Shubert Theatre (Broadway)	1930
Peter Ibbetson	Shubert Theatre (Broadway)	1931
Everybody's Welcome	Shubert Theatre (Broadway)	1931
Smiling Faces	Shubert Theatre (Broadway)	1932
Gay Divorce	Shubert Theatre (Broadway)	1933
Dodsworth	Shubert Theatre (Broadway)	1934
Escape Me Never	Shubert Theatre (Broadway)	1935
Rosmersholm	Shubert Theatre (Broadway)	1935
Love on the Dole	Shubert Theatre (Broadway)	1936
Idiot's Delight	Shubert Theatre (Broadway)	1936
The Masque of Kings	Shubert Theatre (Broadway)	1937
Babes in Arms	Shubert Theatre (Broadway)	1937
Amphitryon 38	Shubert Theatre (Broadway)	1937
The Seagull	Shubert Theatre (Broadway)	1938
I Married an Angel	Shubert Theatre (Broadway)	1938
The Philadelphia Story	Shubert Theatre (Broadway)	1939
Higher and Higher	Shubert Theatre (Broadway)	1940
Hold On to Your Hats	Shubert Theatre (Broadway)	1940
The Doctor's Dilemma	Shubert Theatre (Broadway)	1941
Pal Joey	Shubert Theatre (Broadway)	1941
Candle in the Wind	Shubert Theatre (Broadway)	1941
The Rivals	Shubert Theatre (Broadway)	1942
Candida	Shubert Theatre (Broadway)	1942
By Jupiter	Shubert Theatre (Broadway)	1942
The Vagabond King	Shubert Theatre (Broadway)	1943
Othello	Shubert Theatre (Broadway)	1943
Catherine Was Great	Shubert Theatre (Broadway)	1944
Bloomer Girl	Shubert Theatre (Broadway)	1944
Are You with It?	Shubert Theatre (Broadway)	1946
Park Avenue	Shubert Theatre (Broadway)	1946
Sweethearts	Shubert Theatre (Broadway)	1947
Under the Counter	Shubert Theatre (Broadway)	1947
The First Mrs. Fraser	Shubert Theatre (Broadway)	1947
High Button Shoes	Shubert Theatre (Broadway)	1947
Anne of the Thousand Days	Shubert Theatre (Broadway)	1948
Lend an Ear	Shubert Theatre (Broadway)	1949
I Know My Love	Shubert Theatre (Broadway)	1949
Kiss Me, Kate	Shubert Theatre (Broadway)	1950
Jose Greco Ballet	Shubert Theatre (Broadway)	1951
Paint Your Wagon	Shubert Theatre (Broadway)	1951
The Millionairess	Shubert Theatre (Broadway)	1952
The Love of Four Colonels	Shubert Theatre (Broadway)	1953
Can-Can	Shubert Theatre (Broadway)	1953
Pipe Dream	Shubert Theatre (Broadway)	1955
Will Success Spoil Rock Hunter?	Shubert Theatre (Broadway)	1956
The Pajama Game	Shubert Theatre (Broadway)	1956
Bells Are Ringing	Shubert Theatre (Broadway)	1956
Whoop-Up	Shubert Theatre (Broadway)	1958
A Majority of One	Shubert Theatre (Broadway)	1959
Take Me Along	Shubert Theatre (Broadway)	1959
Bye Bye Birdie	Shubert Theatre (Broadway)	1961
The Gay Life	Shubert Theatre (Broadway)	1961
I Can Get It for You Wholesale	Shubert Theatre (Broadway)	1962
Stop the World - I Want to Get Off	Shubert Theatre (Broadway)	1962
Here's Love	Shubert Theatre (Broadway)	1963
Oliver!	Shubert Theatre (Broadway)	1964
Bajour	Shubert Theatre (Broadway)	1964
The Roar of the Greasepaint - The Smell of the Crowd	Shubert Theatre (Broadway)	1965
Inadmissible Evidence	Shubert Theatre (Broadway)	1965
Ivanov	Shubert Theatre (Broadway)	1966
Wait Until Dark	Shubert Theatre (Broadway)	1966
The Apple Tree	Shubert Theatre (Broadway)	1966
Golden Rainbow	Shubert Theatre (Broadway)	1968
Promises, Promises	Shubert Theatre (Broadway)	1968
An Evening with Richard Nixon	Shubert Theatre (Broadway)	1972
The Creation of the World and Other Business	Shubert Theatre (Broadway)	1972
A Little Night Music	Shubert Theatre (Broadway)	1973
The Sunshine Boys	Shubert Theatre (Broadway)	1973
Over Here!	Shubert Theatre (Broadway)	1974
Seascape	Shubert Theatre (Broadway)	1975
The Constant Wife	Shubert Theatre (Broadway)	1975
A Chorus Line	Shubert Theatre (Broadway)	1975
Buddy - The Buddy Holly Story	Shubert Theatre (Broadway)	1990
Crazy for You	Shubert Theatre (Broadway)	1992
Big	Shubert Theatre (Broadway)	1996
Chicago	Shubert Theatre (Broadway)	1996
Gypsy	Shubert Theatre (Broadway)	2003
Spamalot	Shubert Theatre (Broadway)	2005
A Wonderful Life	Shubert Theatre (Broadway)	2005
Blithe Spirit	Shubert Theatre (Broadway)	2009
Memphis	Shubert Theatre (Broadway)	2009
Brigadoon	Shubert Theatre (Broadway)	2010
Camelot	Shubert Theatre (Broadway)	2011
Oliver!	Shubert Theatre (Broadway)	2012
Matilda the Musical	Shubert Theatre (Broadway)	2013
Hello, Dolly!	Shubert Theatre (Broadway)	2017
To Kill a Mockingbird	Shubert Theatre (Broadway)	2018
POTUS	Shubert Theatre (Broadway)	2022
Some Like It Hot	Shubert Theatre (Broadway)	2022
Hell's Kitchen	Shubert Theatre (Broadway)	2024
Anything Goes	Stephen Sondheim Theatre	2011
The Trip to Bountiful	Stephen Sondheim Theatre	2013
Beautiful: The Carole King Musical	Stephen Sondheim Theatre	2014
Mrs. Doubtfire	Stephen Sondheim Theatre	2021
& Juliet	Stephen Sondheim Theatre	2022
Cabaret	Studio 54	1998
Assassins	Studio 54	2004
Pacific Overtures	Studio 54	2004
A Touch of the Poet	Studio 54	2005
The Threepenny Opera	Studio 54	2006
The Apple Tree	Studio 54	2006
110 in the Shade	Studio 54	2007
The Ritz	Studio 54	2007
Sunday in the Park with George	Studio 54	2008
Pal Joey	Studio 54	2008
Waiting for Godot	Studio 54	2009
Wishful Drinking	Studio 54	2009
Sondheim on Sondheim	Studio 54	2010
Brief Encounter	Studio 54	2010
The People in the Picture	Studio 54	2011
Harvey	Studio 54	2012
The Mystery of Edwin Drood	Studio 54	2012
Cabaret	Studio 54	2014
An Act of God	Studio 54	2015
Therèse Raquin	Studio 54	2015
She Loves Me	Studio 54	2016
Holiday Inn	Studio 54	2016
Sweat	Studio 54	2017
Latin History for Morons	Studio 54	2017
Children of a Lesser God	Studio 54	2018
The Lifespan of a Fact	Studio 54	2018
Kiss Me, Kate	Studio 54	2019
The Sound Inside	Studio 54	2019
Caroline, or Change	Studio 54	2021
The Minutes	Studio 54	2022
Pictures from Home	Studio 54	2023
Days of Wine and Roses	Studio 54	2024
A Wonderful World	Studio 54	2024
Call Me Izzy	Studio 54	2025
Oedipus	Studio 54	2025
The Man Who Came to Dinner	Todd Haimes Theatre	2000
Betrayal	Todd Haimes Theatre	2000
Design for Living	Todd Haimes Theatre	2001
Major Barbara	Todd Haimes Theatre	2001
The Women	Todd Haimes Theatre	2001
An Almost Holy Picture	Todd Haimes Theatre	2002
The Man Who Had All the Luck	Todd Haimes Theatre	2002
An Evening with Mario Cantone	Todd Haimes Theatre	2002
The Boys from Syracuse	Todd Haimes Theatre	2002
Tartuffe	Todd Haimes Theatre	2003
A Day in the Death of Joe Egg	Todd Haimes Theatre	2003
As Long As We Both Shall Laugh	Todd Haimes Theatre	2003
Big River	Todd Haimes Theatre	2003
The Caretaker	Todd Haimes Theatre	2003
Twentieth Century	Todd Haimes Theatre	2004
After the Fall	Todd Haimes Theatre	2004
Twelve Angry Men	Todd Haimes Theatre	2004
The Constant Wife	Todd Haimes Theatre	2005
A Naked Girl on the Appian Way	Todd Haimes Theatre	2005
The Pajama Game	Todd Haimes Theatre	2006
Heartbreak House	Todd Haimes Theatre	2006
Prelude to a Kiss	Todd Haimes Theatre	2007
Old Acquaintance	Todd Haimes Theatre	2007
Pygmalion	Todd Haimes Theatre	2007
The 39 Steps	Todd Haimes Theatre	2008
Les Liaisons Dangereuses	Todd Haimes Theatre	2008
A Man for All Seasons	Todd Haimes Theatre	2008
Hedda Gabler	Todd Haimes Theatre	2009
The Philanthropist	Todd Haimes Theatre	2009
After Miss Julie	Todd Haimes Theatre	2009
Present Laughter	Todd Haimes Theatre	2010
Everyday Rapture	Todd Haimes Theatre	2010
Mrs. Warren's Profession	Todd Haimes Theatre	2010
The Importance of Being Earnest	Todd Haimes Theatre	2011
Man and Boy	Todd Haimes Theatre	2011
The Road to Mecca	Todd Haimes Theatre	2012
Don't Dress for Dinner	Todd Haimes Theatre	2012
Cyrano de Bergerac	Todd Haimes Theatre	2012
Picnic	Todd Haimes Theatre	2013
The Big Knife	Todd Haimes Theatre	2013
The Winslow Boy	Todd Haimes Theatre	2013
Machinal	Todd Haimes Theatre	2014
Violet	Todd Haimes Theatre	2014
The Real Thing	Todd Haimes Theatre	2014
On the Twentieth Century	Todd Haimes Theatre	2015
Old Times	Todd Haimes Theatre	2015
Noises Off	Todd Haimes Theatre	2016
Long Day's Journey into Night	Todd Haimes Theatre	2016
The Cherry Orchard	Todd Haimes Theatre	2016
The Price	Todd Haimes Theatre	2017
Marvin's Room	Todd Haimes Theatre	2017
Time and the Conways	Todd Haimes Theatre	2017
John Lithgow: Stories by Heart	Todd Haimes Theatre	2018
Travesties	Todd Haimes Theatre	2018
Bernhardt/Hamlet	Todd Haimes Theatre	2018
True West	Todd Haimes Theatre	2019
All My Sons	Todd Haimes Theatre	2019
The Rose Tattoo	Todd Haimes Theatre	2019
A Soldier's Play	Todd Haimes Theatre	2020
Trouble in Mind	Todd Haimes Theatre	2021
Birthday Candles	Todd Haimes Theatre	2022
1776	Todd Haimes Theatre	2022
Fat Ham	Todd Haimes Theatre	2023
I Need That	Todd Haimes Theatre	2023
Doubt	Todd Haimes Theatre	2024
Home	Todd Haimes Theatre	2024
Yellow Face	Todd Haimes Theatre	2024
English	Todd Haimes Theatre	2025
Pirates! The Penzance Musical	Todd Haimes Theatre	2025
Danton's Death	Vivian Beaumont Theater	1965
The Country Wife	Vivian Beaumont Theater	1965
The Condemned of Altona	Vivian Beaumont Theater	1966
The Caucasian Chalk Circle	Vivian Beaumont Theater	1966
The Alchemist	Vivian Beaumont Theater	1966
Yerma	Vivian Beaumont Theater	1966
Galileo	Vivian Beaumont Theater	1967
The Unknown Soldier and His Wife	Vivian Beaumont Theater	1967
The Little Foxes	Vivian Beaumont Theater	1967
Saint Joan	Vivian Beaumont Theater	1968
Tiger at the Gates	Vivian Beaumont Theater	1968
Cyrano de Bergerac	Vivian Beaumont Theater	1968
The Three Musketeers	Vivian Beaumont Theater	1968
George Dandin	Vivian Beaumont Theater	1968
Tartuffe	Vivian Beaumont Theater	1968
Lovers	Vivian Beaumont Theater	1968
King Lear	Vivian Beaumont Theater	1968
A Cry of Players	Vivian Beaumont Theater	1968
The Miser	Vivian Beaumont Theater	1969
The Time of Your Life	Vivian Beaumont Theater	1969
Camino Real	Vivian Beaumont Theater	1970
Operation Sidewinder	Vivian Beaumont Theater	1970
Beggar on Horseback	Vivian Beaumont Theater	1970
The Good Woman of Setzuan	Vivian Beaumont Theater	1970
The Playboy of the Western World	Vivian Beaumont Theater	1971
An Enemy of the People	Vivian Beaumont Theater	1971
Antigone	Vivian Beaumont Theater	1971
Mary Stuart	Vivian Beaumont Theater	1971
Narrow Road to the Deep North	Vivian Beaumont Theater	1972
Twelfth Night	Vivian Beaumont Theater	1972
The Crucible	Vivian Beaumont Theater	1972
Man of La Mancha	Vivian Beaumont Theater	1972
Enemies	Vivian Beaumont Theater	1972
The Plough and the Stars	Vivian Beaumont Theater	1973
The Merchant of Venice	Vivian Beaumont Theater	1973
In the Boom Boom Room	Vivian Beaumont Theater	1973
Short Eyes	Vivian Beaumont Theater	1974
A Doll's House	Vivian Beaumont Theater	1975
Trelawny of the "Wells"	Vivian Beaumont Theater	1975
Hamlet	Vivian Beaumont Theater	1975
Mrs. Warren's Profession	Vivian Beaumont Theater	1976
The Threepenny Opera	Vivian Beaumont Theater	1976
The Cherry Orchard	Vivian Beaumont Theater	1977
Agamemnon	Vivian Beaumont Theater	1977
The Philadelphia Story	Vivian Beaumont Theater	1980
Macbeth	Vivian Beaumont Theater	1981
The Floating Light Bulb	Vivian Beaumont Theater	1981
La Tragedie de Carmen	Vivian Beaumont Theater	1983
Oedipus Rex	Vivian Beaumont Theater	1984
The Flying Karamazov Brothers	Vivian Beaumont Theater	1986
The House of Blue Leaves	Vivian Beaumont Theater	1986
The Front Page	Vivian Beaumont Theater	1986
Death and the King's Horseman	Vivian Beaumont Theater	1987
The Comedy of Errors	Vivian Beaumont Theater	1987
Anything Goes	Vivian Beaumont Theater	1987
The Tenth Man	Vivian Beaumont Theater	1989
Some Americans Abroad	Vivian Beaumont Theater	1990
Six Degrees of Separation	Vivian Beaumont Theater	1990
Monster in a Box	Vivian Beaumont Theater	1991
My Favorite Year	Vivian Beaumont Theater	1992
Abe Lincoln in Illinois	Vivian Beaumont Theater	1993
Gray's Anatomy	Vivian Beaumont Theater	1993
Carousel	Vivian Beaumont Theater	1994
Arcadia	Vivian Beaumont Theater	1995
Racing Demon	Vivian Beaumont Theater	1995
Juan Darien: A Carnival Mass	Vivian Beaumont Theater	1996
The Little Foxes	Vivian Beaumont Theater	1997
Ivanov	Vivian Beaumont Theater	1997
Ah, Wilderness!	Vivian Beaumont Theater	1998
Twelfth Night	Vivian Beaumont Theater	1998
Parade	Vivian Beaumont Theater	1998
It Ain't Nothin' But the Blues	Vivian Beaumont Theater	1999
Marie Christine	Vivian Beaumont Theater	1999
Contact	Vivian Beaumont Theater	2000
QED	Vivian Beaumont Theater	2001
Dinner at Eight	Vivian Beaumont Theater	2002
Henry IV, Part 1andPart 2	Vivian Beaumont Theater	2003
King Lear	Vivian Beaumont Theater	2004
The Frogs	Vivian Beaumont Theater	2004
The Rivals	Vivian Beaumont Theater	2004
The Light in the Piazza	Vivian Beaumont Theater	2005
The Coast of Utopia	Vivian Beaumont Theater	2006
Cymbeline	Vivian Beaumont Theater	2007
South Pacific	Vivian Beaumont Theater	2008
A Free Man of Color	Vivian Beaumont Theater	2010
War Horse	Vivian Beaumont Theater	2011
Macbeth	Vivian Beaumont Theater	2013
Act One	Vivian Beaumont Theater	2014
The King and I	Vivian Beaumont Theater	2015
Oslo	Vivian Beaumont Theater	2017
Junk	Vivian Beaumont Theater	2017
My Fair Lady	Vivian Beaumont Theater	2018
Camelot	Vivian Beaumont Theater	2019
Flying Over Sunset	Vivian Beaumont Theater	2021
The Skin of Our Teeth	Vivian Beaumont Theater	2022
Mike Birbiglia: The Old Man and the Pool	Vivian Beaumont Theater	2022
Camelot	Vivian Beaumont Theater	2023
Uncle Vanya	Vivian Beaumont Theater	2024
South Pacific	Vivian Beaumont Theater	2024
Mcneal	Vivian Beaumont Theater	2024
Floyd Collins	Vivian Beaumont Theater	2025
Ragtime	Vivian Beaumont Theater	2025
The Piano Lesson	Walter Kerr Theatre	1990
I Hate Hamlet	Walter Kerr Theatre	1991
Two Trains Running	Walter Kerr Theatre	1992
Angels in America[e]	Walter Kerr Theatre	1993
Love! Valour! Compassion!	Walter Kerr Theatre	1995
Patti LuPoneon Broadway[205][206]	Walter Kerr Theatre	1996
Seven Guitars	Walter Kerr Theatre	1996
Present Laughter	Walter Kerr Theatre	1996
The Beauty Queen of Leenane	Walter Kerr Theatre	1998
The Weir	Walter Kerr Theatre	1999
Waiting in the Wings	Walter Kerr Theatre	1999
A Moon for the Misbegotten	Walter Kerr Theatre	2000
Proof	Walter Kerr Theatre	2000
Take Me Out	Walter Kerr Theatre	2003
Gem of the Ocean	Walter Kerr Theatre	2004
Doubt: A Parable	Walter Kerr Theatre	2005
Grey Gardens	Walter Kerr Theatre	2006
A Bronx Tale	Walter Kerr Theatre	2007
A Catered Affair	Walter Kerr Theatre	2008
The Seagull	Walter Kerr Theatre	2008
Irena's Vow	Walter Kerr Theatre	2009
A Little Night Music	Walter Kerr Theatre	2009
The House of Blue Leaves	Walter Kerr Theatre	2011
Lysistrata Jones	Walter Kerr Theatre	2011
Clybourne Park	Walter Kerr Theatre	2012
The Heiress	Walter Kerr Theatre	2012
The Testament of Mary	Walter Kerr Theatre	2013
A Gentleman's Guide to Love and Murder	Walter Kerr Theatre	2013
The Crucible	Walter Kerr Theatre	2016
Falsettos	Walter Kerr Theatre	2016
Amelie	Walter Kerr Theatre	2017
Springsteen on Broadway	Walter Kerr Theatre	2017
Hadestown	Walter Kerr Theatre	2019
La Belle Paree	Winter Garden Theatre	1911
Vera Violetta	Winter Garden Theatre	1911
Robinson Crusoe, Jr.	Winter Garden Theatre	1916
Sinbad	Winter Garden Theatre	1918
Monte Cristo, Jr.	Winter Garden Theatre	1919
Broadway Brevities of 1920	Winter Garden Theatre	1920
The Whirl of New York	Winter Garden Theatre	1921
Make It Snappy	Winter Garden Theatre	1922
Greenwich Village Follies of 1923	Winter Garden Theatre	1923
Bombo	Winter Garden Theatre	1924
Innocent Eyes	Winter Garden Theatre	1924
Greenwich Village Follies of 1924	Winter Garden Theatre	1924
Big Boy	Winter Garden Theatre	1925
Sky High	Winter Garden Theatre	1925
Artists and Models of 1925	Winter Garden Theatre	1925
The Circus Princess	Winter Garden Theatre	1927
A Night in Spain	Winter Garden Theatre	1927
Artists and Models of 1927	Winter Garden Theatre	1927
Greenwich Village Follies of 1928	Winter Garden Theatre	1928
Ziegfeld Follies of 1934	Winter Garden Theatre	1934
Life Begins at 8:40	Winter Garden Theatre	1934
At Home Abroad	Winter Garden Theatre	1935
Ziegfeld Follies of 1936	Winter Garden Theatre	1936
Hooray for What!	Winter Garden Theatre	1937
You Never Know	Winter Garden Theatre	1938
Hellzapoppin	Winter Garden Theatre	1938
Sons o' Fun	Winter Garden Theatre	1941
Ziegfeld Follies of 1943	Winter Garden Theatre	1943
Mexican Hayride	Winter Garden Theatre	1944
Laffing Room Only	Winter Garden Theatre	1944
Marinka	Winter Garden Theatre	1945
As the Girls Go	Winter Garden Theatre	1948
Alive and Kicking	Winter Garden Theatre	1950
Make a Wish	Winter Garden Theatre	1951
Top Banana	Winter Garden Theatre	1951
My Darlin' Aida	Winter Garden Theatre	1952
Wonderful Town	Winter Garden Theatre	1953
Peter Pan	Winter Garden Theatre	1954
Plain and Fancy	Winter Garden Theatre	1955
The Vamp	Winter Garden Theatre	1955
Tamburlaine The Great	Winter Garden Theatre	1956
Bus Stop	Winter Garden Theatre	1956
Shangri-La	Winter Garden Theatre	1956
Ziegfeld Follies of 1957	Winter Garden Theatre	1957
West Side Story	Winter Garden Theatre	1957
Juno	Winter Garden Theatre	1959
Saratoga	Winter Garden Theatre	1959
Once Upon a Mattress	Winter Garden Theatre	1960
The Unsinkable Molly Brown	Winter Garden Theatre	1960
All American	Winter Garden Theatre	1962
Carnival!	Winter Garden Theatre	1962
The Lady of the Camellias	Winter Garden Theatre	1963
Tovarich	Winter Garden Theatre	1963
Funny Girl	Winter Garden Theatre	1964
Mame	Winter Garden Theatre	1966
Jimmy!	Winter Garden Theatre	1969
Georgy	Winter Garden Theatre	1970
Purlie	Winter Garden Theatre	1970
Follies	Winter Garden Theatre	1971
Much Ado About Nothing	Winter Garden Theatre	1972
Ulysses in Nighttown	Winter Garden Theatre	1974
Gypsy	Winter Garden Theatre	1974
Doctor Jazz	Winter Garden Theatre	1975
Pacific Overtures	Winter Garden Theatre	1976
Fiddler on the Roof	Winter Garden Theatre	1976
Beatlemania	Winter Garden Theatre	1977
Zoot Suit	Winter Garden Theatre	1979
Gilda Radner: Live From New York	Winter Garden Theatre	1979
42nd Street	Winter Garden Theatre	1980
The Catherine Wheel	Winter Garden Theatre	1981
Camelot	Winter Garden Theatre	1981
Othello	Winter Garden Theatre	1982
Cats	Winter Garden Theatre	1982
Mamma Mia!	Winter Garden Theatre	2001
Rocky the Musical	Winter Garden Theatre	2014
Wolf Hall Parts One & Two	Winter Garden Theatre	2015
School of Rock	Winter Garden Theatre	2015
Beetlejuice	Winter Garden Theatre	2019
The Music Man	Winter Garden Theatre	2022
Back to the Future: The Musical	Winter Garden Theatre	2023
Good Night, and Good Luck	Winter Garden Theatre	2025
Mamma Mia!	Winter Garden Theatre	2025
\.


--
-- Data for Name: theatre; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.theatre (theatre_name, address, opening_year, company_name) FROM stdin;
Al Hirschfeld Theatre	302 W. 45th St.	1924	ATG Entertainment
Ambassador Theatre (Broadway)	219 W. 49th St.	1921	Shubert Organization
August Wilson Theatre	245 W. 52nd St.	1925	ATG Entertainment
Belasco Theatre (Broadway)	111 W. 44th St.	1907	Shubert Organization
Bernard B. Jacobs Theatre	242 W. 45th St.	1927	Shubert Organization
Booth Theatre	222 W. 45th St.	1913	Shubert Organization
Broadhurst Theatre	235 W. 44th St.	1917	Shubert Organization
Broadway Theatre (53rd Street)	1681 Broadway	1924	Shubert Organization
Circle in the Square Theatre	235 W. 50th St.	1972	Independent
Ethel Barrymore Theatre	243 W. 47th St.	1928	Shubert Organization
Eugene O'Neill Theatre	230 W. 49th St.	1925	ATG Entertainment
Gerald Schoenfeld Theatre	236 W. 45th St.	1917	Shubert Organization
Gershwin Theatre	222 W. 51st St.	1972	Nederlander Organization
Hayes Theater	240 W. 44th St.	1912	Second Stage Theater
Hudson Theatre	141 W. 44th St.	1903	ATG Entertainment
Imperial Theatre	249 W. 45th St.	1923	Shubert Organization
James Earl Jones Theatre	138 W. 48th St.	1912	Shubert Organization
John Golden Theatre	252 W. 45th St.	1927	Shubert Organization
Lena Horne Theatre	256 W. 47th St.	1926	Nederlander Organization
Longacre Theatre	220 W. 48th St.	1913	Shubert Organization
Lunt-Fontanne Theatre	205 W. 46th St.	1910	Nederlander Organization
Lyceum Theatre (Broadway)	149 W. 45th St.	1903	Shubert Organization
Lyric Theatre (New York City, 1998)	214 W. 43rd St.	1998	ATG Entertainment
Majestic Theatre (Broadway)	245 W. 44th St.	1927	Shubert Organization
Marquis Theatre	210 W. 46th St.	1986	Nederlander Organization
Minskoff Theatre	200 W. 45th St.	1973	Nederlander Organization
Music Box Theatre	239 W. 45th St.	1921	Shubert Organization
Nederlander Theatre	208 W. 41st St.	1921	Nederlander Organization
Neil Simon Theatre	250 W. 52nd St.	1927	Nederlander Organization
New Amsterdam Theatre	214 W. 42nd St.	1903	Disney Theatrical Group
Palace Theatre (New York City)	160 W 47th St	1913	Nederlander Organization
Richard Rodgers Theatre	226 W. 46th St.	1925	Nederlander Organization
Samuel J. Friedman Theatre	261 W. 47th St.	1925	Manhattan Theatre Club
Shubert Theatre (Broadway)	225 W. 44th St.	1913	Shubert Organization
Stephen Sondheim Theatre	124 W. 43rd St.	1918	Roundabout Theatre Company
St. James Theatre	246 W. 44th St.	1927	ATG Entertainment
Studio 54	254 W. 54th St.	1927	Roundabout Theatre Company
Todd Haimes Theatre	227 W. 42nd St.	1918	Roundabout Theatre Company
Vivian Beaumont Theater	150 W. 65th St.	1965	Lincoln Center Theater
Walter Kerr Theatre	219 W. 48th St.	1921	ATG Entertainment
Winter Garden Theatre	1634 Broadway	1911	Shubert Organization
Edison Theatre	240 W. 47th St.	1931	Hotel Edison
Ed Sullivan Theater	1697 Broadway	1927	CBS
Empire Theatre (42nd Street)	236 W. 42nd St.	1912	AMC Theatres
Liberty Theatre	234 W. 42nd St.	1904	Liberty Theater Catering & Events
New Victory Theater	209 W. 42nd St.	1900	New 42nd Street
Sony Hall	235 W. 46th St.	1938	Blue Note Entertainment Group
Mark Hellinger Theatre	237 W. 51st St.	1930	Times Square Church
Times Square Theater	217 W. 42nd St.	1920	New 42nd Street
\.


--
-- Name: active_theatre active_theatre_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.active_theatre
    ADD CONSTRAINT active_theatre_pkey PRIMARY KEY (theatre_name);


--
-- Name: architect architect_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.architect
    ADD CONSTRAINT architect_pkey PRIMARY KEY (id);


--
-- Name: broadway_show broadway_show_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.broadway_show
    ADD CONSTRAINT broadway_show_pkey PRIMARY KEY (title);


--
-- Name: design_work design_work_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.design_work
    ADD CONSTRAINT design_work_pkey PRIMARY KEY (architect_id, theatre_name);


--
-- Name: former_existing_theatre former_existing_theatre_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.former_existing_theatre
    ADD CONSTRAINT former_existing_theatre_pkey PRIMARY KEY (theatre_name);


--
-- Name: organization organization_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organization
    ADD CONSTRAINT organization_pkey PRIMARY KEY (company_name);


--
-- Name: production production_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.production
    ADD CONSTRAINT production_pkey PRIMARY KEY (show_title, theatre_name, opening_year);


--
-- Name: theatre theatre_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.theatre
    ADD CONSTRAINT theatre_pkey PRIMARY KEY (theatre_name);


--
-- Name: active_theatre active_theatre_theatre_name_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.active_theatre
    ADD CONSTRAINT active_theatre_theatre_name_fkey FOREIGN KEY (theatre_name) REFERENCES public.theatre(theatre_name);


--
-- Name: design_work design_work_architect_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.design_work
    ADD CONSTRAINT design_work_architect_id_fkey FOREIGN KEY (architect_id) REFERENCES public.architect(id);


--
-- Name: design_work design_work_theatre_name_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.design_work
    ADD CONSTRAINT design_work_theatre_name_fkey FOREIGN KEY (theatre_name) REFERENCES public.theatre(theatre_name);


--
-- Name: former_existing_theatre former_existing_theatre_theatre_name_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.former_existing_theatre
    ADD CONSTRAINT former_existing_theatre_theatre_name_fkey FOREIGN KEY (theatre_name) REFERENCES public.theatre(theatre_name);


--
-- Name: production production_show_title_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.production
    ADD CONSTRAINT production_show_title_fkey FOREIGN KEY (show_title) REFERENCES public.broadway_show(title);


--
-- Name: production production_theatre_name_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.production
    ADD CONSTRAINT production_theatre_name_fkey FOREIGN KEY (theatre_name) REFERENCES public.theatre(theatre_name);


--
-- Name: theatre theatre_company_name_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.theatre
    ADD CONSTRAINT theatre_company_name_fkey FOREIGN KEY (company_name) REFERENCES public.organization(company_name);


--
-- PostgreSQL database dump complete
--

