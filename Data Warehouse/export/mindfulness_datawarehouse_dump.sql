--
-- PostgreSQL database dump
--

-- Dumped from database version 14.17
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

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: ensure_positive_followers(); Type: FUNCTION; Schema: public; Owner: kevinazrazzz
--

CREATE FUNCTION public.ensure_positive_followers() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Untuk youtube_subscribers
    IF NEW.youtube_subscribers < 0 THEN
        RAISE EXCEPTION 'Jumlah YouTube subscribers tidak boleh kurang dari 0.';
    END IF;

    -- Untuk instagram_followers
    IF NEW.instagram_followers < 0 THEN
        RAISE EXCEPTION 'Jumlah Instagram followers tidak boleh kurang dari 0.';
    END IF;

    -- Untuk facebook_followers
    IF NEW.facebook_followers < 0 THEN
        RAISE EXCEPTION 'Jumlah Facebook followers tidak boleh kurang dari 0.';
    END IF;

    RETURN NEW;
END;
$$;


ALTER FUNCTION public.ensure_positive_followers() OWNER TO kevinazrazzz;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: Dim_Channel; Type: TABLE; Schema: public; Owner: kevinazrazzz
--

CREATE TABLE public."Dim_Channel" (
    youtube_channel_link character varying(255) NOT NULL,
    channel_name character varying(255),
    description text,
    type_of_channel character varying(50),
    since date
);


ALTER TABLE public."Dim_Channel" OWNER TO kevinazrazzz;

--
-- Name: Dim_Youtuber; Type: TABLE; Schema: public; Owner: kevinazrazzz
--

CREATE TABLE public."Dim_Youtuber" (
    youtuber_name character varying(100) NOT NULL,
    gender character varying(10),
    email character varying(255),
    type character varying(10)
);


ALTER TABLE public."Dim_Youtuber" OWNER TO kevinazrazzz;

--
-- Name: Fact_Top_Channels; Type: TABLE; Schema: public; Owner: kevinazrazzz
--

CREATE TABLE public."Fact_Top_Channels" (
    youtuber_name character varying(100),
    youtube_channel_link character varying(255),
    youtube_subscribers integer,
    facebook_followers integer,
    instagram_followers integer
);


ALTER TABLE public."Fact_Top_Channels" OWNER TO kevinazrazzz;

--
-- Name: channels; Type: TABLE; Schema: public; Owner: kevinazrazzz
--

CREATE TABLE public.channels (
    youtube_channel_link character varying(255) NOT NULL,
    channel_name character varying(255),
    description text,
    type_of_channel character varying(50),
    since character varying(20),
    youtuber_name character varying(100) NOT NULL
);


ALTER TABLE public.channels OWNER TO kevinazrazzz;

--
-- Name: youtubers; Type: TABLE; Schema: public; Owner: kevinazrazzz
--

CREATE TABLE public.youtubers (
    youtuber_name character varying(100) NOT NULL,
    gender character varying(10),
    email character varying(255),
    youtube_subscribers integer,
    facebook_followers integer,
    instagram_followers integer,
    type character varying(10)
);


ALTER TABLE public.youtubers OWNER TO kevinazrazzz;

--
-- Data for Name: Dim_Channel; Type: TABLE DATA; Schema: public; Owner: kevinazrazzz
--

COPY public."Dim_Channel" (youtube_channel_link, channel_name, description, type_of_channel, since) FROM stdin;
https://www.youtube.com/channel/UCbuENEBzQ69QKmfX2iumnFA/videos	Yogapalooza with Bari Koral	Discover a wonderful world of beloved songs and magical activities that make it easy to teach yoga and mindfulness to children through music. Bari Koral is a widely recognized kids yoga expert and popular recording artist.ABOUT BARI KORALEvery day, thousands of children, parents and teachers around the world are learning and enjoying the benefits of yoga and mindfulness with Bari. Bari's songs and approachable yoga and mindfulness curriculum are used on a regular basis around the world. She is considered a pioneer in the world of kids yoga. To date, she has presented to over 100,000...	Influencer	2009-04-01
https://www.youtube.com/@TheMindfulMovement/	The Mindful Movement	Welcome! Here at the Mindful Movement, we are an oasis where you can come to tap into your inner calm, develop a positive mindset and heal from the stress that's blocking your fulfillment. We offer guided meditation, visualizations, and hypnosis as well as Yoga, Pilates and a variety of mindful movement practices to help you live mindfully, move well and feel great!We would love to continue working with you personally if you are interested. We offer self-paced, online courses, group coaching, and 1:1 services. You can learn more at our website: Themindfulmovement...	Influencer	2016-08-01
https://www.youtube.com/channel/UCpw2gh99XM6Mwsbksv0feEg	Moojiji	Mooji brings the possibility of Self-realization into the here and now. He drifted in a state of spontaneous meditation oblivious to the outer world he formally knew. During these years, he lived almost penniless but was constantly absorbed in inner joy, contentment and natural meditation. His communication is simple, direct and immediate. An invitation to move from person to presence -- and ultimately, to liberation. He speaks to you.	Influencer	2007-08-01
https://www.youtube.com/@TaraBrach/	Tara Brach	Tara Brach is a leading western teacher of Buddhist meditation, emotional healing and spiritual awakening. This channel is a compilation of Tara Brach's video offerings, including her popular Wednesday night weekly livestream; a library of guided meditations; short clips from the 'Tara Talks' web series; interviews and various other engagements. All content on this channel is owned by Tara Brach, PhD. All rights reserved.For more information, go to https://www.tarabrach.com	Influencer	2011-04-01
https://www.youtube.com/channel/UCqWB6EseWbMKnzunyewBDqg/videos	Meditation Vacation	Guided meditation got me through a tough stage in my life and by creating my own meditation videos. This channel is about how to meditate as my guided meditation videos explain what to do and can send you into a deep relaxation and through mindfulness. Using guided meditation on a regular basis can truly help with relaxation, sleep and peace inside.	Influencer	2015-06-01
https://www.youtube.com/@ChibsMeditation/	Chibs Okereke Meditations	Chibs Okereke's guided meditations and soothing voice have helped millions find deep relaxation, better sleep and less stress. He is a meditation instructor on the Calm app and an accredited mindfulness facilitator. Having personally struggled with anxiety, stress, and burnout, Chibs understands how important it is to feel supported during meditation, so these meditations will help you feel grounded, peaceful, and safe.Subscribe for regular meditations that blend modern mindfulness techniques with practical strategies for better sleep, less anxiety, and deeper relaxation...	Influencer	2007-01-01
https://www.youtube.com/@MindfulnessExercises/	Mindfulness Exercises	Mindfulness Exercises shares free mindfulness meditations, courses, trainings and resources for mindfulness practitioners and mindfulness meditation teachers alike.Sean Fargo created Mindfulness Exercises to help people live with embodied presence, compassion and resilience. We provide audio meditations, guided meditation scripts, mindfulness worksheets, mindfulness courses, and live online retreats...	Influencer	2014-05-01
https://www.youtube.com/channel/UCK7X0kE4vCbOXPi1VPVQYFw/videos	Mindful Music	Just fresh music. As always, please stay Mindful, discover, share, and inspire! Peace. All music posted is for promotional use only most of which is acquired via submissions and permission from artist/producer.	Influencer	2014-11-01
https://www.youtube.com/channel/UCFmUuRhirRUPRtROX0KiQcw/videos	The Mindfulness Teacher	⭐️Children's Relaxations for Mental & Emotional Well-Being, Calm & Focus in the Classroom.I help teachers, educators, parents & mental health professionals to improve their student's/children's mental & emotional well-being so that they can have calmer kids & calmer classrooms. Because my content is made for children, unfortunately the comments are turned off. If any teachers/educators or parents/guardians want to contact me, you can do so through the links in my channel below.	Influencer	2020-05-01
https://www.youtube.com/channel/UCjQxrBbp-9aCBzWIsiuHmiA/videos	Palouse Mindfulness	Dave Potter is a certified Mindfulness-Based Stress Reduction instructor. Palouse Mindfulness provides these videos as part of the free online mindfulness course (MBSR). It is an eight-week 100% free course and contains all the materials used in the in-person course taught by Dave Potter, who is fully certified to teach MBSR by the University of Massachusetts Medical School.	Influencer	2013-03-01
https://www.youtube.com/channel/UCaON5f-W7kWBixxZEkhYicw	Jamie Marich	Jamie Marich is the Author of EMDR Therapy & Mindfulness, Trauma Made Simple, Trauma and the Twelve Steps and EMDR Made Simple; Creator of Dancing Mindfulness. Learn about trauma in a way that is relevant to clinical work, including extensive coverage on PTSD and other diagnoses through a bio-psycho-social-spiritual lens.	Influencer	2011-07-01
https://www.youtube.com/channel/UCneFwNzUhZCuEyDxNHKdKVw/videos	Crossroads Psychology	Voicu Mihnea Simandan is a Certified Positive Psychology & Mindfulness Practitioner and Coach. He coaches & teaches Positive Psychology to athletes, students and parents; as well as leads & facilitates Mindfulness retreats and experiences.The Crossroads Psychology Video-Podcast aims at Encouraging Personal Growth.'A Wall of Ideas' Video-Podcast aims at creating a communication bridge to discuss topics related to technology, education, culture, travel, productivity, and the expat life.Previously, the channel's focus was on travel and sports, especially Asian destinations,...	Influencer	2007-02-01
https://www.youtube.com/channel/UCVCM37ofcquSCtnCpdkhxwQ/videos	Scott Todnem | Mindful Teaching	Mindful teaching and mindset leading.Scott Todnem has been teaching Health Education at Scullen Middle School in Naperville, Illinois since 2001. In that time, hundreds of students each year have gone through a course about the best subject in the world: LIFE.Social Health impacts who we are; our interactions from the past can drastically shape who we become in our future. Therefore, this YouTube channel, the LifeIsTheFuture.com webpage, and other social media have become a fun and creative way to express lifelong connections and learning... to remember the past and reminisce... and to...	Influencer	2017-08-01
https://www.youtube.com/channel/UCQTlKxfVk5o6B5SvbvYdSZQ/videos	Loch Kelly	No description	Influencer	2014-06-01
https://www.youtube.com/channel/UCyUMUmuQi9Ni9qh-FEkM9WQ/videos	Mindfulness | Shamash Alidina	Shamash has been practising mindfulness since 1998 and runs his own successful training organisation.He is best known as the internationally bestselling author of 10 books including Mindfulness For Dummies and The Mindful Way through Stress. Based in London, he runs online trainings and speaks at conferences all over the world.He is a keen educator and has trained almost 500 mindfulness teachers in the last 11 years. Prior to that, he spent 10 years teaching mindfulness/meditation as well as science, in schools.Shamash has been training practitioners in Acceptance and Commitment...	Influencer	2006-12-01
https://www.youtube.com/channel/UCpbhe71UUAh-j9prsMTyyBA/videos	Mindful Creative Muse	No description	Influencer	2015-05-01
https://www.youtube.com/channel/UCyuAzAFsNzcypnAa1XSlnog/videos	Mindful in Minutes || Kelly Smith	Guided Meditation | Yoga | Deep Relaxation | At Home Meditation | Sleep Meditation | Meditation For Beginners | Meditation Music | Yoga Meditation Hey, I'm Kelly, the founder of Yoga For You, and host of the Mindful in Minutes podcast, and Meditation Mama. Mindful in Minutes provides short, weekly guided meditations to help you stress less and live more. Join me each week for simple and grounded guided meditations that are 20 minutes or less and cover an array of topics that will help you with real life like anxiety, insomnia, self-esteem, and manifestation.I believe there isn't...	Influencer	2016-01-01
https://www.youtube.com/channel/UCUPP3b6x2a1FcUMTrsdAR2g/videos	Cory Muscara	Cory Muscara is a former monk, co-founder of Mindfulness.com, and bestselling author of the book, Stop Missing Your Life. With over 500K followers across his social media channels, Cory has gained popularity for his down-to-earth, engaging, and accessible teachings on mindfulness, wellbeing, and mental health. He has taught Mindful leadership at Columbia University, is an instructor of Positive Psychology at the University of Pennsylvania, and for the last ten years has offered mindfulness keynotes, workshops, and retreats around the world to companies like Bank of America, Prudential, Johnson	Influencer	2013-05-01
https://www.youtube.com/channel/UCR-d964e8gW0hZt9mxaEQvg/videos	Melli O'Brien:	Melli O'Brien is mindfulness teacher but, first and foremost, a devoted mindfulness practitioner (who's still learning, discovering and deepening every day).Sharing the art of mindful living is her passion and purpose. Melli's passion for teaching mindfulness stems from her firm belief that anyone can create the kind of incredible inner transformation she has undergone once they know how.Melli's mission is to help you enjoy a more fulfilling and meaningful life.She is not a monk or an evangelist of any particular religion or technique. She live in the real world and her...	Influencer	2012-12-01
https://www.youtube.com/channel/UCkGwhgfmKK3ghv2MDMOkMxA/videos	MindfulNEWS	10 years investigating the subject of happiness and podcasting about what matters most in life with scientists, bloggers, teachers, authors and the leading experts, on the subjects that matters most. Conversations with friends led to conversations on Mindfulness that led to a wonderful path of learning and better relationships. Podcasts, Videos, Vlogs, Car pool conversations, Guided meditations and On-line courses at www.Mindfulnews.uk (Mindfulnews.uk on instagram)	Influencer	2011-07-01
https://www.youtube.com/@SarahMcLeanMeditation/	Sarah McLean, Meditation & Mindfulness Teacher	Over 30 years ago I was searching for peace. My search led me to mystical places around the world, though I found what I was looking for when I finally learned to meditate. Since, I've lived & worked in a Transcendental Meditation community, helped Deepak Chopra start his Mind Body Health Center, lived in a traditional ashram in India & served as a cook in a Zen Buddhist monastery, & became the director of Byron Katie's school.No, you don't have to move to India, find a guru, or become Buddhist to do meditation 'right...	Influencer	2014-09-01
https://www.youtube.com/channel/UC-0g3lxbb3Ujskpr3rrzI-Q/videos	Rocky Heron	Rocky Heron is an artistic wonder a singer, songwriter, yogi, and mindfulness instructor with an eclectic sound. Known for his uncanny wisdom and in-depth understanding of the human body, Rocky's teaching is informed by years of study in many yoga styles and movement modalities. Considered in the yoga industry a 'teachers teacher,' Rocky works worldwide and online facilitating classes, training, and continuing education for teachers. Rocky's musical library consists of 'The Requiem EP', his sophomore acoustic project, 'The Love Demos', and the pop-inspired 'Nuffa...	Influencer	2007-04-01
https://www.youtube.com/channel/UC7LfxLU3jmBdiScY-_24OBg/videos	Mindful Yoga for Healers with Dr. Jessie Mahoney	I teach heart-centered yoga to relieve tension, aches, pains, overwhelm, and burnout. My intention is to help you optimize your breath, grow self-compassion, relieve stress, let go of frustration, and discover alignment.I am a life coach and yoga teacher. I coach those who are successful on the surface yet struggle underneath. I specialize in relationships, parenting, career transitions, and burnout coaching. I also co-host the Mindful Healers Podcast and host yoga, coaching, and culinary medicine retreats for women physicians who want to find calm and start living their best life....	Influencer	2020-05-01
https://www.youtube.com/@OrenJaySoferVideo/	Oren Jay Sofer	Expert teaching on mindfulness practice and Insight meditation, and mindful communication for wellbeing, balance and clarity in life and at work. Join author, meditation teacher, and communication trainer Oren Jay Sofer for guidance and instruction in living in line with your values, resolving conflict, and learning to meditate.Oren Jay Sofer teaches Buddhist meditation, Dharma, and communication retreats and workshops nationally...	Influencer	2013-11-01
https://www.youtube.com/channel/UCvb0vkbdBJF-Qx7tZ6HWqIQ/videos	Harp & Wellness	Nicole E. AndersonCertified Therapeutic Musician, Therapist/Life Coach, and Certified Meditation & Mindfulness TeacherSpecializing in Harp Therapy and Holistic WellnessWelcome to my channel! I offer content that focuses on self-care and mental health with a unique spin: harp music!My videos include harp therapy, harp music for relaxation, mindfulness exercises, meditations, and more. Join me for topical discussions, soothing music, mindfulness, and tips for self-care as we make our way through our challenges and stressors. Currently I am releasing harp and nature relaxation videos...	Influencer	2016-09-01
https://www.youtube.com/channel/UC5F4sqam3xc5hkYwqdMBW2Q/videos	Mindfulness With Missy	Welcome to mindfulness with Missy. On this channel, we will do meditations, affirmations, and visualizations. This is a safe place to heal your mind and become a happier, healthier, more calm version of you!Disclaimer: These meditations are not intended to replace professional help. None of these meditations should be listened to while operating machinery. Anything that happens while you listen to these videos is your responsibility and mindfulness with missy is not liable.	Influencer	2021-10-01
https://www.youtube.com/channel/UCyicqwQM9aIZ9mAw5xP4Q2g/videos	Anthony Ongaro	Hi, I'm Anthony! Welcome to Break the Twitch. I make videos about intentional living, and building a life in alignment with our values. Anthony Ongaro shares his explorations in how to live a better life through minimalism, habits and creativity.	Influencer	2015-02-01
https://www.youtube.com/channel/UCGYeWtdm9GXYcdgkLph9Rcw/videos	Fablefy - The Whole Child	Fly With Able and Fy is dedicated to bringing mindfulness to parents and children. Through our interactive animated series which can be used anywhere to help you grab a moment of peace in your life, we aim to create a space where you and your children can live mindfully. About the Creator: Hi, I am Shilpi Mahajan and I am a single person army responsible for conceptualization and creation of the channel. Any support via shares, subscriptions and likes will be helpful. If you choose to use portions of the videos on the channel, please seek approval. If you want a specific request, please...	Influencer	2017-02-01
https://www.youtube.com/channel/UCZVJN6ow1IeGWH6HkaNqu_g/videos	John Davisi	John is a certified professional coach, consultant, and advisor. In 2016, his passion and work in mindfulness coaching and as an HR leader merged while VP of People Operations & Mindfulness at internet media company BuzzFeed. While there he established and led the company's first mindfulness program, including facilitating weekly, live meditation sessions and mindfulness workshops for employees globally. He's written and narrated several meditations for @goodful and has 100+ meditations on his own YouTube channel. In 2022 John released four albums. The first in April titled Breathe -...	Influencer	2014-10-01
https://www.youtube.com/channel/UCWRGNm4blMTh_DsNTiuzyxw/videos	Voice of Mindfulness ASMR	I'm Ellen from Voice of Mindfulness, a self-healing & self-improvement channel that can help you relax, find peace and meaning and improve your life through mindfulness, sound healing and a touch of ASMR. I provide a safe and peaceful space for you to focus on YOU while you sleep.The channel also offers 'Sleep Heal & Grow' hypnosis, guided meditations, mental health practices and spiritual guidance infused with ASMR, to help find a deeper connection to yourself and the world around you. The videos are created with the intention of helping you sleep soundly, relieve anxiety, recover from...	Influencer	2022-07-01
https://www.youtube.com/channel/UCbjljhC9ecohK38jcEvGebg/videos	Mindfulness Place	Welcome to the Mindfulness Place!When you practice mindfulness you experience calmness and relaxation, higher levels of energy and enthusiasm for living, increased self-confidence and self-acceptance and more compassion for others. You also experience less stress, depression, anxiety, chronic pain, addiction or low immune function.We upload weekly free Mindfulness Exercises, Guided Meditations, and Positive Affirmations.The best place to start is by subscribing to our FREE Inner Journey meditation course at:https://nisandeh.com/inner-journey/	Influencer	2019-01-01
https://www.youtube.com/channel/UC4hp1CWJx7zUKeOpD7XzG6w/videos	Mindfulness in Blue Jeans	After denying his own trauma for eight years, Ron Levine finally fell apart in a crippling heap of anxiety, depression, panic disorder, and agoraphobia in early 1998. On disability and unable to leave his house, he began practicing vipassana (mindfulness-based insight meditation), which sparked a life-changing new direction cultivated on and off the cushion.With backgrounds in social psychology, information technology, and yoga, Ron emphasizes a methodical and scientific results-based approach to facing our demons and finding inner peace. From Ron: 'We each must walk our own path, but...	Influencer	2020-03-01
https://www.youtube.com/channel/UCSyNIDWAM9cRzkn7Uz4IwTw/videos	\N	Your daily dose of relaxation.Meditation Relax Club is the main Youtube Leader in Meditation and Relaxation Music. Born in 2012, thanks to the well-known experience of our composers and collaborators, MRC channel is working everyday with constancy and passion to give you a real experiece of relaxation, thanks to the multitude of videos we create everyday, with the most calming and peaceful new age music. The zen music available for users on Meditation Relax Club can be used as deep meditation music, sleep music (for those of you who need something really soothing for falling asleep),...	Mega	2012-09-01
https://www.youtube.com/channel/UC3JhfsgFPLSLNEROQCdj-GQ	\N	Headspace is guided meditation for everybody. Learn how to meditate, wherever you are, whenever you like. That's as well as mindfulness exercises for everyday situations like commuting or cooking, dozens of animations like the ones you see on this channel & 8 different meditation techniques, all taught by Headspace's co-founder, Andy Puddicombe, a former Buddhist monk. With hundreds of hours of content, Headspace is your personal meditation guide to just about anything.	Macro	2014-09-01
https://www.youtube.com/channel/UCoqtKR3DyzMoSaMxqSyrdig/videos	\N	Brain Education TV is a self improvement channel for the brain with videos on how to practice self care and boost your brain power. The foundation of our content comes from Brain Education, an academic study from South Korea that stems from over 40 years of research and application and has been practiced by millions around the world.	Macro	\N
https://www.youtube.com/channel/UCc1lvEoC5PZWm-MzgUfJQfg/videos	\N	Be Here Now Network is dedicated to the gathering and dissemination of spiritual talks, podcasts and writings of master teachers of Spirituality, Mindfulness and Meditation. Awaken through impactful, insightful, and entertaining podcasts with the wisdom keepers of today.	Macro	2016-06-01
https://www.youtube.com/channel/UCbcI2r4u2hyBjyNe9YcoDfA/videos	\N	No description	Macro	2014-03-01
https://www.youtube.com/channel/UCEhl4Grr46IolhzGhZ3agNw	\N	No description	Macro	2011-05-01
https://www.youtube.com/channel/UCJaUaqWbSdyTklGsWnuFtMg/videos	\N	Welcome to My Peace of Mindfulness! We provide the best free guided meditation videos on Youtube.Do you suffer from depression, anxiety or insomnia? Or maybe, you're looking to remove negative energy and stress. We produce short meditation videos on a daily basis to help you let go, meditate at home, attract money & positive energy and manifest the life you desire. Whether you're a meditation beginner or a meditation pro, our video will help you to relax and find inner peace. Please enjoy our mindfulness meditation videos in a relaxing secluded location.We'd love to hear your...	Macro	2016-07-01
https://www.youtube.com/channel/UC2ZvMgbK5X8j-nCY5CR06xw/videos	\N	Declutter The Mind is for the beginner, novice, and experienced meditator. It's where people who want to clear, declutter and understand their minds come.If you want to understand the mind, sit down and observe it. My goal is to help you observe it (much more easily and effectively) with guided meditations for mindfulness, anxiety, stress, focus, sleep deprivation, insomnia, depression and more.This channel hopes to help you meditate without the 'woo woo' or any religious undertones. I want meditation to be viewed as and used as a practical tool for anyone.I understand and want...	Macro	2019-01-01
https://www.youtube.com/channel/UC1ydk-XgJws0RCrg1Kofxbw/videos	\N	We support and empower Muslim women so they can not just grow, but thrive. Our channel gives tips and advice on love, parenting, inspiration, motivation and everything else associated with living a more mindful modern Muslimah life.Check out our website; www.mindful-muslimah.comReach out to me on Instagram at @MindfulMuslimah or via email at ****@mindful-muslimah.com	Micro	2018-09-01
https://www.youtube.com/channel/UCGliqsod-tQoGiHahxS9Wig/videos	\N	The Insight Meditation Center is a community-based, urban refuge for the teachings and practice of insight meditation, also known as mindfulness or vipassana meditation. We offer Buddhist teachings in clear, accessible and open-handed ways.Guided by Gil Fronsdal and Andrea Fella, IMC offers a broad range of programs and community activities.IMC does not require payment for any of our teachings, programs or events. The support of our teachers and center expenses is done through voluntary donations from the community. All the work in running and maintaining IMC and its programs is done by...	Micro	2011-01-01
https://www.youtube.com/channel/UCiYQrjtMgfJFYabJy0wY8nA	\N	Mindful Wing Chun is one of the biggest Wing Chun school in HK and is located in the Heart of Central. Our mission is to pass on Grandmaster CHU SHONG TIN's 'internal' method of Wing Chun which promotes health through cultivating MINDFULNESS and Deep RELAXATION resulting in a BALANCED Body and Mind.	Micro	2014-04-01
https://www.youtube.com/channel/UC0GmmgMoHnZArG4FNVfKPew/videos	\N	Mindful Mama Mentor Hunter Clarke-Fields, MSAE, RYT, is the creator of the Mindful Parenting course, host of the Mindful Mama podcast and widely-followed author of Raising Good Humans: A Mindful Guide to Breaking the Cycle of Reactive Parenting and Raising Kind, Confident Kids. Mindful Mama is about becoming a less irritable, more joyful parent. We know that you cannot give what you do not have. And when you are thriving, when you have calm and peace within then you can give it to your children. Learn about Mindful Parenting. Listen and get inspired!New videos are posted every week.	Nano	2013-04-01
https://www.youtube.com/channel/UCXsjej0djMYxtGC3RMHBUvg/videos	\N	No description	Micro	2015-05-01
https://www.youtube.com/channel/UC-sxY90UX6IiLDpYeQrxFYg/videos	\N	Discover the essence of mindfulness and learn at the Inner Mind InstituteStudy and practice meditation and mindfulness step by step, as a student or a teacher, through our online platform or in one of the Inner Mind Institute retreat centers.	Micro	2020-05-01
https://www.youtube.com/channel/UCt_di56chWq4svfsdGV5gRw/videos	\N	Metta Mindfulness Music is an innovative, one of its kind collaboration between leading experts in the field of holistic healing and master world musicians. Metta Mindfulness Music's Executive Producer and President is renowned healer, Dr. Richard Gold. Metta Mindfulness Music's Artistic Director is critically acclaimed composer and educator, Yuval Ron. Our Mission Statement:To create beautiful original music that enhances health, mental equanimity, and the daily expression of loving kindness. To create original music that is informed by ancient wisdom traditions and the most...	Nano	2015-04-01
https://www.youtube.com/channel/UCSA3tLxw52HgRdazOXidyXA/videos	\N	Hey there! My name is Julia, welcome to my channel. I'm a Certified Mindfulness Meditation Teacher and I created this channel to share my passion for conscious living, mindfulness, and meditation with you.On this channel, you'll find a little bit of everything that I love. From guided meditations to help you relax and destress, to tips and tricks for incorporating mindfulness into your daily routine, and even some delicious whole-food plant-based recipes to keep your body and mind feeling their best.I believe that living a more conscious and mindful lifestyle can bring a lot of...	Nano	2019-10-01
https://www.youtube.com/channel/UCw5A8RUBeBPc6PCQ2z_kLCg/videos	\N	Livestream and other content from Common Ground Meditation Center, Minneapolis, Minnesota.Common Ground is a community meditation center dedicated to the practice of mindfulness. Mindfulness meditation is the practice of waking up to the present moment and learning to be open and at ease with the unfolding conditions of life. With practice, mindfulness reveals deep wisdom, compassion, and intimacy with all things.	Nano	2019-03-01
https://www.youtube.com/channel/UCvlbwSot5weaTvzkXPtd02w/videos	\N	Hello! Thank you so much for taking the time to watch this video and to hopefully subscribe to my channel . This space, I hope finds you well and helps you in your day-to-day life become the best version of you. I believe in the power of human kindness and mindfulness. I am an educator, movement instructor, and mindfulness teacher. Why ? Because I believe in and want to share simple ways of how you can live a balanced, healthy, happy life through the personal bettering of yourself. I challenge you to subscribe and to follow. Take time for self-care each day and join me in providing love and...	Nano	2020-04-01
https://www.youtube.com/channel/UCsc3U-3MNgTjHVk7P42YFyg/videos	\N	RoundGlass believes that Wholistic Wellbeing is for all to experience. While life doesn't stop throwing challenges at us, we can be better equipped to handle them. Through meditation and mindfulness practices, end-of-life support, workplace solutions, yoga asanas, and healthy recipes, RoundGlass offers wellbeing in the most important quarters of life. Self-care, mental fitness, physical wellbeing, and positivity are the most important tools every human living modern life needs. Learn how to use them and bring many noticeable benefits in your life now. Explore how you can give more to...	Nano	2014-09-01
https://www.youtube.com/channel/UCG7euc9ON2PH8Ws_1Sux0Qg/videos	\N	At the Mindfulness Association, we believe that mindfulness is a way of life and not a brief intervention for relieving symptoms. We provide a long-term systematic training in mindfulness for life - from teaching the foundations of mindfulness for beginners right through compassion an insight training to our two Masters programmes- MSc Mindfulness Studies with the University of Aberdeen and MSc Mindfulness & Compassion (with teacher training) with the University of the West of Scotland in London. Our Masters tutors teach on all our courses at all levels. We train in being present,...	Nano	2016-06-01
https://www.youtube.com/channel/UCXa6UPiIRwNJQOTkAz5qnvQ/videos	\N	No description	Nano	2021-02-01
https://www.youtube.com/channel/UCp4s3mVqrfG29U_gDAFGMlg/videos	\N	Learn with a Meditation Practitioner and Instructor since 1980Deb Phelps is a certified Meditation Teacher, Sound Healer, Mindfulness Coach, and Yoga Specialist who uniquely assists her clients overcome stress, anxiety, PTSD, grief, and other life situations so that they can once again live purposeful, joy-filled lives. Deb has overcome significant life challenges aided by a variety of mind-body-spirit practices.	Nano	2017-07-01
https://www.youtube.com/channel/UCs0Hk7dGaWW2mJ97gZwqgLA/videos	\N	The Breathworks approach is grounded in compassionate awareness, with a gentle, gradual transformation of our relationship to all our life experiences, including our pain or difficulty. We invite everyone engaging with Breathworks practices and courses to take care of their own well-being as fundamental to our approach. If you suffer from physical, emotional or mental health conditions, please take care not to push yourself past your own safe boundaries when	Nano	2010-08-01
https://www.youtube.com/channel/UCR19sWAiaXuJtNx7mp6gcxg/videos	\N	Welcome to the official YouTube channel for Monash University's 'Mindfulness for Wellbeing and Peak Performance' and 'Maintaining a Mindful Life' courses on FutureLearn. If you're taking part in either course, this is where we'll post all of the feedback videos we record for each course. You're welcome to subscribe, like and comment here, but the best place to engage in discussion with other learners is the comments section of each course on FutureLearn. Join now https://www.futurelearn.com/courses/mindfulness-wellbeing-performance and...	Nano	2015-09-01
https://www.youtube.com/channel/UCH6fuu1ChJNrs7ecSDdR8QQ/videos	\N	This channel is designed to be a resource for people wanting to explore Mindful Self-Compassion practices, as developed in the Mindful Self-Compassion (MSC) Training designed by Kristin Neff and Christopher Germer. For more information, please see the Center for Mindful Self-Compassion website at www.CenterForMSC.org	Micro	2013-12-01
https://www.youtube.com/channel/UCaDM90dCqBHX_cfmBAno6uA/videos	\N	Are you interested awakening to your loving and compassionate true nature? Here you'll find the complete talks and Q & A associated with my weekly meditation group. The videos bring together information and experiential practices on how to do that, introducing material from Buddhism and other spiritual traditions told from a modern, secular perspective: focusing on direct practices for reducing suffering in your daily life. I have a PhD in social work, nine book publications, publications in scholarly journals, and over 30 years of Buddhist practice in the Zen and Theravada traditions....	Nano	2006-11-01
https://www.youtube.com/channel/UCfyCAAXLTPptpRoGAwzCJIQ/videos	\N	Meditate: School of Mindfulness leads Mindfulness Lessons and meditations as WE share OUR passion to help OUR clients and students WAKE UP and own their life in the most authentic way. MSOM offers Mentorship programs in Transformational Coaching, Meditation Teaching, Hypnosis Coaching, Mindful Addiction, Sound Healing, Yoga Nidra, and more.https://linktr.ee/meditate_school_of_mindfulness	Nano	2017-03-01
https://www.youtube.com/channel/UCjyoa02oSEutDPE6hGDi_0g/videos	\N	Welcome to the Omni Mindfulness Channel! I'm Shilpa, and I am a Mindset & Meditation Coach. Omni Mindfulness is a one-of-a-kind channel. Here you will find inspirational Podcasts, Guided Meditations, Meditation & Mindfulness Coaching Tips, and Practical Tips.#omnimindfulness #podcast #guidedmeditations #shilpaslewis	Nano	2020-05-01
https://www.youtube.com/channel/UCEFyWtl2OVeUJvNp3LqsPbg/videos	\N	No description	Nano	2012-05-01
https://www.youtube.com/channel/UCSPkYjJ6YLyEx7t2AjlYBhQ/videos	\N	Dr. Jessie Mahoney is a mindful life coach, wellness expert, and pediatrician. She is the founder and CEO of Pause and Presence coaching where she supports those who are successful on the surface yet struggle underneath with mindful coaching. She co-hosts the Mindful Healers Podcast and teaches Mindful Yoga for Healers. Her yoga youtube channel is https://www.youtube.com/channel/UC7LfxLU3jmBdiScY-_24OBgConnect with her at www.jessiemahoneymd.com.Coach with Her: https://www.jessiemahoneymd.com/coachingJoin a Coaching & Yoga Retreat: https://www.jessiemahoneymd.com/retreatsRequest a...	Nano	2022-02-01
https://www.youtube.com/channel/UC7A7xE0hrqqrhpr4GPOD7Zg/videos	\N	Connected Kids YouTube channel will guide you through tips, ideas and practices to empower you to teach meditation and mindfulness for parentingeducationages - kindergarten to teenstopics - autism, ADHD, trauma, SENThese videos are based on our 20 years experience of helping people teach children and teens mindful skills to reduce anxiety and stress.We've published 3 books on thisCalm Kids (how to guide for beginners) - 2012Connected Kids (for teaching more experienced levels and includes autism and based on pilot studies) 2014Robbie and Jess - fictional story for bed-time...	Nano	2011-08-01
https://www.youtube.com/channel/UCTznAC33vMRcubcXgvtd6Vw/videos	\N	A space for healing, mindfulness and wellness. I support women who are stressed, stuck and overwhelmed and who desire to experience Soul fulfillment and inner peace. This 30 min body scan meditation will give you an opportunity to slow down and to gently connect with your body in a deeper way. It will support you in releasing stress, anxiety, and pain, as you intentionally focus your awareness on different body parts. Remember to give yourself...	Nano	2014-02-01
https://www.youtube.com/channel/UCXpVSqlRfmke_NOcCSwJ4ag/videos	\N	Hi! I'm Brittany 🙂 After experiencing the life-changing effects of consistent mindfulness in my own life, I began sharing the practices that led me to a happier & healthier lifestyle. Through movement, mindfulness & reflection, I share self-care practices to enrich your life and nourish every aspect of your well-being.I post new full-length practices on YouTube as often as possible, offer online yoga classes & mindfulness courses & teach virtual sessions live with individuals, groups & companies. I hope you can join me for my upcoming retreat to Portugal in May 2023 or for a Teacher...	Nano	2011-10-01
https://www.youtube.com/channel/UCTVJils4_esMbAplQlK6fjA/videos	\N	We are an Irish wellbeing movement created to transform how we talk about and treat mental health. Our Vision is world where the wellbeing of humanity is the headliner on the main stage, and everything else is a support act.	Nano	2014-11-01
https://www.youtube.com/channel/UCwHJcMkEFM-KeybMRzggcBA/videos	\N	No description	Nano	2018-06-01
https://www.youtube.com/channel/UC2lY6h7PAxogV-O7CB31RXg/videos	\N	Mindfulness meditation is the practice of engaging and staying in the present moment, paying attention and bringing awareness to your breath, body, mind, feelings and your senses. When we teach children mindfulness skills we can help them gain the tools to meet the stresses of life with presence, self-compassion, honesty, openness and build confidence, resilience and hone their focus.You can introduce mindfulness to children through everyday informal practices that you can do along with them - expressing appreciation and gratitude, offering good wishes and compassion to others, enjoying	Nano	2021-10-01
https://www.youtube.com/channel/UCiNogi3RHmLDP2gCYRcsOcw/videos	\N	No description	Nano	2020-07-01
https://www.youtube.com/channel/UC91ItJhHAEyO_fuiixybLOw/videos	\N	Troy Devlin is a Health Coach and Mindfulness Guide with over 15 years professional experience as an instructor in the law enforcement industry.This channel is intended to share helpful insights that first responders and others might find useful when addressing the challenges to ones health and wellness that are typically encountered when performing high stress jobs.Troy Devlin is a certified physical fitness instructor and mindfulness guide but he is not a doctor.Therefore the information provided by this channel is for entertainment purposes only and is not intended to take the place of	Nano	2022-10-01
https://www.youtube.com/channel/UC1w0ZuVGeasmzZ1KO9muF-w/videos	\N	No description	Nano	2022-10-01
https://www.youtube.com/channel/UCa-ISJR_srhSGV-5AsGUpKw/videos	\N	The Mindfulness Project is making evolution happen. Nothing less than that. Our Vision is a healed, mindful and loving Planet.Rural Thailand, in a village near Khon Kaen, we created a volunteering society, which is the living proof that our vision works!And we have a community that is sharing this lifestyle all over the world. Do you want to become a part of this community? Here you go!On this channel we are sharing ideas to create a sustainable, healthy and ethically conscious way of living.Teachings about:-Personal Development & Psychology-Permaculture-Natural...	Nano	2015-04-01
https://www.youtube.com/channel/UCF9VgD1GEVjCrYb8RM63iyw/videos	\N	I am a Holistic Health and Mindfulness Educator. Specializing in the Gut/ Brain connection. I teach people how to improve their digestive health, reduce stress and tap into the health and well being they have been seeking.I teach mindfulness/neuroplasticity classes for students kinder through high school and staff development training's in schools that teach us to make our brain more flexible, release negative emotions from the body, increase brain function and become the master of our brain. The videos I post are designed to give the views some tools they can do at home to improve...	Nano	2015-11-01
https://www.youtube.com/channel/UCmZVqreZtq4w_MO4MciDgPw/videos	\N	I'm passionate about sharing yoga and mindfulness-based practices that are playful and accessible. Join the Practice with Lydia community: https://practicewithlydia.uscreen.ioJoin my mailing list for freebies, resources and news on upcoming offerings: http://eepurl.com/g9lcbDWarmth, Lydia	Nano	2008-11-01
https://www.youtube.com/channel/UCovYdXH3V4N0iWl5o3CYYMg/videos	\N	Samavira is here to help you elevate your meditation experience and live life at your best. All Samavira trainings combine Eastern principles, science, and experience design to bring wisdom to modern living. We empower you to create your individual meditation style and routine without relying on a device. Our growing global network of meditation instructors are bringing Samavira to the cities around the world. Want to live well, grow and connect? Join our community.	Nano	2020-04-01
https://www.youtube.com/channel/UCQIm0b0861AC9DmrIJOUWFw/videos	\N	Mark has devotedly studied mindfulness meditation practices for three decades and has taught mindfulness meditation in six continents for the past twenty years. Mark is a senior meditation teacher at Spirit Rock Meditation Center. He holds a MA in Clinical Psychology and is a therapist and coach. Through the Mindfulness Training Institute Mark leads Professional Mindfulness Teacher Training programs in the US and UK annually. Mark founded The Mindfulness Institute, where he has brought mindfulness teachings to companies and the non profit sector across North America and Europe.	Nano	2012-09-01
https://www.youtube.com/channel/UCKIy5smVsP6Ok8UwtP6AMlg/videos	\N	Mindfulness author and teacher Padraig O'Morain on mindfulness and related practices such as self-compassion and gratitude. These short (mostly) videos will bring you key practice points and attitudes derived from Padraig's more than 30 years of mindfulness practice and learning. Padraig is the author of many books on mindfulness, published in many countries and languages. His online courses and online mindfulness events are enjoyed by participants all over the world and especially in Ireland and the UK. Many of my events are run on a donation basis to make them accessible to...	Nano	2021-01-01
https://www.youtube.com/channel/UC8luOtW8BNWi21WxxUQHg-Q/videos	\N	Susan Young is a certified life coach specializing in mindfulness and guided meditation practices. Her action-based coaching helps clients find stillness and live with intention. Book a free coaching session at http://susanyounglifecoaching.com, or connect with her on social media:	Nano	2016-09-01
https://www.youtube.com/channel/UC2R-lG74F4tNQZSTG0oIgWg/videos	\N	No description	Nano	2022-04-01
https://www.youtube.com/channel/UCaM5KReAMKezUu31z3PcxKw/videos	\N	Making Mindfulness Accessible With over 30 years of formal Mindfulness training, I bring experience in traditional teachings blended with my social work career of over 25 years in individual and family supports in disability services as well as human rights advocacy work in the disability sector. I did my first 10 day silent meditation retreat in 1985, and have not looked back on this path of continuous practice. I'm a single mom and have loved doing mindfulness work with parents and families to make mindfulness accessible to challenging lives. I've been very lucky to work with a...	Nano	2018-06-01
https://www.youtube.com/channel/UCrMnVEusez7op8Nn1PzgKYQ/videos	\N	Alex Strauss is a bestselling author and creator of The Mindful Walker School of Wellbeing, where busy people learn simple, practical ways to harness the healing power of Nature Connection. Slow down, stress less, connect with the Earth, live with intention, and enjoy a more mindful, Earth-conscious life. Get started with free resources at https://www.TheMindfulWalker.com.	Nano	2015-02-01
https://www.youtube.com/channel/UCs0Hk7dGaWW2mJ97gZwqgLA	\N	Breathworks offers a toolkit of knowledge for lifelong use, drawing on the best of mindfulness practice & the founders' personal experience. We also provide specialist programmes for organisations & for health, education & social care professionals wishing to incorporate mindfulness into their work. Our channel both includes interviews & mindfulness technique videos with our founders, associates & teachers. In addition we aim to share the best videos from the international mindfulness community.	Nano	2010-09-01
https://www.youtube.com/channel/UCQBZpAYfvz8kigDbdqN72Rg/videos	\N	Vanessa Guild is a mindfulness-expert, trainer, speaker, and private coach. She has taught mindfulness meditation workshops for The Dallas Symphony, Morton Meyerson Center employees, SMU, Brookfield Global Asset Management (New York), to inmates within a maximum-security prison in Sydney, Australia.Her private coaching sessions for teenagers, teachers, to CEO's effectively strengthen mental concentration and self-esteem; dramatically decreasing stress.For further information about Vanessa go to: vanessaguild.com.	Nano	2010-04-01
https://www.youtube.com/channel/UCrgANrWsHCEEjjut89Vgx8Q/videos	\N	No description	Nano	2020-04-01
https://www.youtube.com/channel/UCR-d964e8gW0hZt9mxaEQvg	\N	Hi, I'm Melli. I'm a meditation and mindfulness teacher, and I run mindfulness retreats around Australia. She is the leading researchers, teachers and mindfulness experts will be sharing their wisdom, knowledge, tips and tricks about mindfulness.	Nano	2013-05-01
https://www.youtube.com/channel/UCzmIJgRiK5lsVc9JHUn9DCw/videos	\N	Sit down with host, Aimee Morgan, as she delves into the world of mindfulness with doctors, therapists, first responders and other mindfulness thought leaders. Listen as they share their mindfulness practices and help you become better equipped with practical tools to focus your mind and live in the present.	Nano	2022-10-01
https://www.youtube.com/channel/UCdfQL9wkxnHBi3FEBHdAv7g/videos	\N	Learn about mindfulness. Here you'll find the practices and current science in shore, easy to do, easy to understand videos. Mindfulness is a training of the attention. Your attention is your super power. Learn how to harness it for your benefit. Self reporting studies and neuro-imaging has show that mindfulness improves focus, self compassion, emotional regulation and overall well being. I invite you to enjoy these offerings.	Nano	2013-08-01
https://www.youtube.com/channel/UCDurv_diN_vwnFxo_3jmsVA/videos	\N	'Mindfulness 360' is aspiring to be your source of inspiration, guidance and support on how to cultivate a mindful mindset in your daily life so to enjoy a more meaningful and fulfilling experience in your social, personal and professional context.	Micro	2016-01-01
https://www.youtube.com/channel/UCf-nkEuAif3R1Lt4JKn0igw	\N	No description	Micro	2009-03-01
https://www.youtube.com/channel/UCA8iHe0Hgl4KVvpQ7wNW4LQ/videos	\N	Hi, I'm Olivier, welcome!On my channel, you will find videos to learn meditation and practice mindfulness in your daily life.When I was a student, I used to have many panic attacks to the point I couldn't breathe. Back then, I didn't know about about meditation and I had to go through many difficult moments.In my early thirties I also experience depression.Since learning about mindfulness and meditation and seeing the transformative effect of those practices in my life, I have been dwelling into those practices, attending retreats and teacher trainings. Because I knew I...	Nano	2018-07-01
https://www.youtube.com/channel/UC48VQRCUvPrzS14N6w5Iadw/videos	\N	Welcome to Elements Meditation & Mindfulness! A community for those in search of mindful relaxation to help quiet the mind.By subscribing to our channel, you will be taking your mind on a journey of exploration, self discovery and deep emotional healing. We know that we are all individuals and what may work for one person, may not work for another.	Micro	2021-03-01
https://www.youtube.com/channel/UCZ4AJ3yAUMzO-vA2Y-z4grg/videos	\N	Inward Bound Mindfulness Education (iBme) is a non-profit organization dedicated to improving the lives of teens, parents, and professionals. Through mindfulness retreats, iBme helps participants cultivate awareness, compassion, and kindness for themselves, others, and the natural world.We lead mindfulness retreats for teenagers across the country at retreat centers and in wilderness settings. We also provide mindfulness retreats for individual schools and in partnership with other non-profits that work with teens.	Nano	2014-03-01
https://www.youtube.com/channel/UCsLua7dma2V68-vR0lzp_RQ/videos	\N	The Centre for Mindfulness Studies is an innovative charity and social enterprise in Toronto, Ontario. We offer mindfulness-based therapies and professional training for health care professionals, social service providers, and educators.	Nano	2015-05-01
https://www.youtube.com/channel/UCC7LrjsxGO24fwYL94vCLPg/videos	\N	No description	Nano	2021-01-01
https://www.youtube.com/channel/UC7jTgGGhZxMgQ4PBFooytcQ/videos	\N	Hey there! I'm Sierra: a modern witchy woman & mindfulness coach. I'm here to guide soulful women towards a fully embodied life so they can exist from reassurance and ease, rather than struggle and lack.	Nano	2018-08-01
https://www.youtube.com/channel/UCVlpglql_LHPn15ANTk04DA/videos	\N	No description	Nano	2017-11-01
https://www.youtube.com/channel/UCCIZv5c7LAZVuI0v6mJALLw/videos	\N	Welcome to Pandit Dasa's Official YouTube channel. The goal behind this channel is to help humans become more mindful not just at work but in life as a whole as well as stay resilient when difficulties arise.Pandit Dasa is a Mindful Leadership Expert, Keynote Speaker for Fortune 500 companies, Former Monk of 15 years and the Author of 'Urban Monk: Exploring Karma, Consciousness and the Divine'.	Nano	2016-03-01
https://www.youtube.com/channel/UC793KKZqPca0iBZPeQNrw4Q/videos	\N	Established by teachers from amongst the country's most successful schools, Mindfulness in Schools Project (MiSP) aims to improve the lives of children by making a genuine, positive difference to their mental health and wellbeing.With a decade's worth of experience, our charity is the most established provider of mindfulness training and curricula for schools. 350,000 primary and secondary pupils have already benefited from our programme, which helps them to flourish academically, socially and emotionally and we want to reach many more.Schools and other educational settings are...	Nano	2013-03-01
https://www.youtube.com/channel/UCq8BbJ_KM-_3jATfQAE7ZiQ/videos	\N	The series of guided meditations on the Mindfulness Sanctuary Channel have been designed to help you cultivate greater emotional resilience and well-being. All the meditations have been written and recorded by a psychologist and experienced mindfulness/meditation teacher, to ease you into a state of deep relaxation and peace. The Channel is created by Emma Gray, a coach, meditation teacher, and Clinical Psychologist. Emma combines her knowledge of leading-edge neuroscience with traditional Eastern philosophies in a holistic approach to mind/body healing and wellness. Her passion is to help...	Nano	2016-06-01
https://www.youtube.com/channel/UC_EAU9IDpKjuQy8LMJQpW0Q/videos	\N	Hello, guest!Welcome to a Mindfulness Base. Here you will find videos with some tips and ideas, which I hope will bring more mindfulness, balance, happiness and flow to your life! I am a certified instructor in MBSR (Mindfulness-based stress reduction), a PhD, a meditator and a cat-lady. I will be sharing my passion for mindfulness practice, mindful living, making meditation sweet and potent, and of course, for cats. Stay tuned!Maria Sharapan, CFM (R)a Mindfulness Base	Nano	2020-06-01
\.


--
-- Data for Name: Dim_Youtuber; Type: TABLE DATA; Schema: public; Owner: kevinazrazzz
--

COPY public."Dim_Youtuber" (youtuber_name, gender, email, type) FROM stdin;
Bari Koral	Female	****@gmail.com	Macro
Sara & Les	\N	****@gmail.com	Macro
Anthony Paul Moo-Young	Male	****@mooji.org	Macro
Tara Brach	Female	****@tarabrach.com	Macro
Christian Thomas	Male	****@gmail.com	Macro
Chibs Okereke	Male	****@chibs.co	Micro
Sean Fargo	Male	****@mindfulnessexercises.com	Macro
Mindful Music	\N	****@gmail.com	Macro
Holly Morris	Female	****@thementalhealthteacher.com	Macro
Palouse Mindfulness	\N	****@palousemindfulness.com	Micro
Jamie Marich	Female	****@mindfulohio.com	Micro
Voicu Mihnea Simandan	Male	****@yahoo.com	Micro
Scott Todnem	Male	\N	Nano
Loch Kelly	Male	****@lochkelly.org	Micro
Shamash Alidina	Male	****@shamashalidina.com	Nano
Cynthia Hauk	Female	****@mindfulcreativemuse.com	Micro
Kelly Smith	Female	****@yogaforyouonline.com	Nano
Cory Muscara	Male	****@limindfulness.com	Micro
Melli O'brien	Female	****@mrsmindfulness.com	Nano
Gui Hung	Male	****@mindfulnews.uk	Nano
Sarah McLean	Female	****@mcleanmeditation.com	Nano
Rocky Heron	Male	****@rockyheron.com	Nano
Jessie Mahoney	Female	****@jessiemahoneymd.com	Nano
Oren Jay Sofer	Male	****@orenjaysofer.com	Nano
Nicole E. Anderson	Female	****@neamusic.com	Nano
Missy	Female	****@the-life-helper.com	Nano
Anthony Ongaro	Male	****@gmail.com	Micro
Shilpi Mahajan	Female	****@fablefy.com	Micro
John Davisi	Male	\N	Micro
Ellen	Female	****@gmail.com	Nano
Mindfulness Place	\N	****@mindfulness-place.com	Nano
Ron Levine	Male	****@mindfulnessinbluejeans.com	Nano
MeditationRelaxClub - Sleep Music & Mindfulness	\N	****@meditationrelaxclub.com	Mega
Headspace	\N	****@headspace.com	Macro
Brain Education TV	\N	****@gmail.com	Macro
Be Here Now Network	\N	****@beherenownetwork.com	Macro
MindfulPeace	\N	****@mindfulpeacejourney.com	Macro
Wisdom 2.0	\N	****@wisdom2conference.com	Macro
My Peace Of Mindfulness	\N	****@mypeaceofmindfulness.com	Macro
Declutter The Mind	\N	****@declutterthemind.com	Macro
Mindful Muslimah	\N	\N	Micro
Insight Meditation Center	\N	****@gmail.com	Micro
Mindful Wing Chun	\N	****@mindfulwingchun.com.hk	Micro
Mindful Mama Mentor	\N	****@mindfulmamamentor.com	Nano
Mindful	\N	****@mindful.org	Micro
Master Niels	\N	****@innermindinstitute.org	Micro
Metta Mindfulness Music	\N	****@mettamindfulnessmusic.com	Nano
Julia Delaney | Positive Pranic	\N	****@gmail.com	Nano
Common Ground Meditation Center	\N	****@commongroundmeditation.org	Nano
Mindfulness with Mariel	\N	****@gmail.com	Nano
RoundGlass	\N	****@round.glass	Nano
Mindfulness Association	\N	****@mindfulnessassociation.net	Nano
The Men Talking Mindfulness Podcast	\N	****@mentalkingmindfulness.com	Nano
Meditate with Deb	\N	****@peacefulwellness.org	Nano
Breathworks Mindfulness	\N	****@breathworks.co.uk	Nano
Monash Mindfulness	\N	****@monash.edu	Nano
Center for Mindful Self-Compassion	\N	****@centerformsc.org	Micro
Dr. Mindfulness	\N	****@carleton.ca	Nano
Meditate: School of Mindfulness	\N	****@gmail.com	Nano
Omni Mindfulness	\N	****@gmail.com	Nano
Mindfulness With Aly F Canavan	\N	****@alisoncanavan.com	Nano
Mindful Life Coaching with Dr. Jessie Mahoney	\N	****@jessiemahoneymd.com	Nano
Connected Kids - teach kids meditation	\N	****@teachchildrenmeditation.com	Nano
Gayane Kulikyan - Mindfulness & Healing	\N	****@concordinlove.com	Nano
Brittany Lynne | Beautifully Awakening	\N	\N	Nano
A Lust For Life	\N	****@alustforlife.com	Nano
Creative Mindfulness	\N	****@louiseshanagher.com	Nano
Mindful Meditation with Storytime Family	\N	****@gmail.com	Nano
Make Mind Spiritual	\N	\N	Nano
A Mindful Approach to Fitness	\N	****@gmail.com	Nano
Meditation Mindfulness	\N	****@alanspicer.com	Nano
Mindfulness Project	\N	****@mindfulness-project.org	Nano
Christy Jones Health and Mindfulness Coach	\N	****@gmail.com	Nano
Practice With Lydia Zamorano	\N	****@gmail.com	Nano
Samavira Meditation and Mindfulness	\N	****@samavira.com	Nano
Mark Coleman	\N	****@markcoleman.org	Nano
Padraig O'Morain Mindfulness	\N	****@gmx.com	Nano
Susan Young Mindful Coaching	\N	****@susancoach.ca	Nano
Peace & Love: Meditation and Mindfulness	\N	****@gmail.com	Nano
Sue Hutton Mindfulness	\N	****@gmail.com	Nano
Alex Strauss - Author & Natural Mindfulness Guide	\N	****@themindfulwalker.com	Nano
Breathworks Mindfulness New	\N	****@breathworks.co.uk	Nano
Vanessa Guild - Mindfulness Trainer, Private Coach	\N	****@vanessaguild.com	Nano
Mindfulness With Ms. Guerra	\N	\N	Nano
Mrs Mindfulness	\N	****@mrsmindful.co.uk	Nano
Mindfulness Academy	\N	****@aimeemorgan.com	Nano
Rita Geraghty - Mindful Life Guide	\N	\N	Nano
Mindfulness 360 - Center For Mindfulness	\N	****@mindfulness360.net	Micro
Quiet Mind Cafe	\N	****@gmail.com	Micro
Peaceful Breathing - Meditation and Mindfulness	\N	****@gmail.com	Nano
Elements - Meditations & Mindfulness	\N	****@mail.com	Micro
iBme / Inward Bound Mindfulness Education	\N	****@ibme.com	Nano
The Centre for Mindfulness Studies	\N	****@mindfulnessstudies.com	Nano
Mindfulness Meditation by Soothing Pod	\N	****@gmail.com	Nano
The Local Mystic	\N	****@gmail.com	Nano
Mindfulness Abundance by Dee Gardner	\N	****@thecounselingservices.com	Nano
Pandit Dasa	\N	****@gmail.com	Nano
Mindfulness in Schools Project	\N	****@mindfulnessinschools.org	Nano
Mindfulness Sanctuary	\N	****@emmagray.net	Nano
a Mindfulness Base	\N	****@gmail.com	Nano
\.


--
-- Data for Name: Fact_Top_Channels; Type: TABLE DATA; Schema: public; Owner: kevinazrazzz
--

COPY public."Fact_Top_Channels" (youtuber_name, youtube_channel_link, youtube_subscribers, facebook_followers, instagram_followers) FROM stdin;
Bari Koral	https://www.youtube.com/channel/UCbuENEBzQ69QKmfX2iumnFA/videos	707000	3400	6300
Sara & Les	https://www.youtube.com/@TheMindfulMovement/	959000	12300	\N
Anthony Paul Moo-Young	https://www.youtube.com/channel/UCpw2gh99XM6Mwsbksv0feEg	835000	460600	477800
Tara Brach	https://www.youtube.com/@TaraBrach/	339000	373300	289200
Christian Thomas	https://www.youtube.com/channel/UCqWB6EseWbMKnzunyewBDqg/videos	409000	1200	434
Chibs Okereke	https://www.youtube.com/@ChibsMeditation/	94000	\N	8000
Sean Fargo	https://www.youtube.com/@MindfulnessExercises/	121000	\N	102300
Mindful Music	https://www.youtube.com/channel/UCK7X0kE4vCbOXPi1VPVQYFw/videos	136000	975	\N
Holly Morris	https://www.youtube.com/channel/UCFmUuRhirRUPRtROX0KiQcw/videos	110000	\N	\N
Palouse Mindfulness	https://www.youtube.com/channel/UCjQxrBbp-9aCBzWIsiuHmiA/videos	50800	4400	\N
Jamie Marich	https://www.youtube.com/channel/UCaON5f-W7kWBixxZEkhYicw	20100	10800	\N
Voicu Mihnea Simandan	https://www.youtube.com/channel/UCneFwNzUhZCuEyDxNHKdKVw/videos	12600	\N	486
Scott Todnem	https://www.youtube.com/channel/UCVCM37ofcquSCtnCpdkhxwQ/videos	5900	1300	10800
Loch Kelly	https://www.youtube.com/channel/UCQTlKxfVk5o6B5SvbvYdSZQ/videos	16200	\N	7600
Shamash Alidina	https://www.youtube.com/channel/UCyUMUmuQi9Ni9qh-FEkM9WQ/videos	2900	13600	2900
Cynthia Hauk	https://www.youtube.com/channel/UCpbhe71UUAh-j9prsMTyyBA/videos	12900	1200	4500
Kelly Smith	https://www.youtube.com/channel/UCyuAzAFsNzcypnAa1XSlnog/videos	5300	1300	\N
Cory Muscara	https://www.youtube.com/channel/UCUPP3b6x2a1FcUMTrsdAR2g/videos	17000	36300	1100000
Melli O'brien	https://www.youtube.com/channel/UCR-d964e8gW0hZt9mxaEQvg/videos	5400	63400	13100
Gui Hung	https://www.youtube.com/channel/UCkGwhgfmKK3ghv2MDMOkMxA/videos	3600	\N	1700
Sarah McLean	https://www.youtube.com/@SarahMcLeanMeditation/	4600	11800	\N
Rocky Heron	https://www.youtube.com/channel/UC-0g3lxbb3Ujskpr3rrzI-Q/videos	3800	21100	53400
Jessie Mahoney	https://www.youtube.com/channel/UC7LfxLU3jmBdiScY-_24OBg/videos	2900	\N	\N
Oren Jay Sofer	https://www.youtube.com/@OrenJaySoferVideo/	6100	\N	14500
Nicole E. Anderson	https://www.youtube.com/channel/UCvb0vkbdBJF-Qx7tZ6HWqIQ/videos	2900	215	\N
Missy	https://www.youtube.com/channel/UC5F4sqam3xc5hkYwqdMBW2Q/videos	2800	169	\N
Anthony Ongaro	https://www.youtube.com/channel/UCyicqwQM9aIZ9mAw5xP4Q2g/videos	67300	20400	2600
Shilpi Mahajan	https://www.youtube.com/channel/UCGYeWtdm9GXYcdgkLph9Rcw/videos	28200	846	\N
John Davisi	https://www.youtube.com/channel/UCZVJN6ow1IeGWH6HkaNqu_g/videos	12600	\N	4500
Ellen	https://www.youtube.com/channel/UCWRGNm4blMTh_DsNTiuzyxw/videos	8600	\N	\N
Mindfulness Place	https://www.youtube.com/channel/UCbjljhC9ecohK38jcEvGebg/videos	3500	\N	\N
Ron Levine	https://www.youtube.com/channel/UC4hp1CWJx7zUKeOpD7XzG6w/videos	3000	911	\N
MeditationRelaxClub - Sleep Music & Mindfulness	https://www.youtube.com/channel/UCSyNIDWAM9cRzkn7Uz4IwTw/videos	1700000	\N	\N
Headspace	https://www.youtube.com/channel/UC3JhfsgFPLSLNEROQCdj-GQ	779000	800400	\N
Brain Education TV	https://www.youtube.com/channel/UCoqtKR3DyzMoSaMxqSyrdig/videos	406000	2900	6700
Be Here Now Network	https://www.youtube.com/channel/UCc1lvEoC5PZWm-MzgUfJQfg/videos	208000	42600	\N
MindfulPeace	https://www.youtube.com/channel/UCbcI2r4u2hyBjyNe9YcoDfA/videos	235000	8100	\N
Wisdom 2.0	https://www.youtube.com/channel/UCEhl4Grr46IolhzGhZ3agNw	152000	56900	\N
My Peace Of Mindfulness	https://www.youtube.com/channel/UCJaUaqWbSdyTklGsWnuFtMg/videos	116000	\N	\N
Declutter The Mind	https://www.youtube.com/channel/UC2ZvMgbK5X8j-nCY5CR06xw/videos	163000	9100	2400
Mindful Muslimah	https://www.youtube.com/channel/UC1ydk-XgJws0RCrg1Kofxbw/videos	29100	\N	\N
Insight Meditation Center	https://www.youtube.com/channel/UCGliqsod-tQoGiHahxS9Wig/videos	26400	17500	\N
Mindful Wing Chun	https://www.youtube.com/channel/UCiYQrjtMgfJFYabJy0wY8nA	27300	30000	\N
Mindful Mama Mentor	https://www.youtube.com/channel/UC0GmmgMoHnZArG4FNVfKPew/videos	3500	\N	\N
Mindful	https://www.youtube.com/channel/UCXsjej0djMYxtGC3RMHBUvg/videos	12400	\N	\N
Master Niels	https://www.youtube.com/channel/UC-sxY90UX6IiLDpYeQrxFYg/videos	55000	\N	\N
Metta Mindfulness Music	https://www.youtube.com/channel/UCt_di56chWq4svfsdGV5gRw/videos	3900	\N	\N
Julia Delaney | Positive Pranic	https://www.youtube.com/channel/UCSA3tLxw52HgRdazOXidyXA/videos	8500	1100	1100
Common Ground Meditation Center	https://www.youtube.com/channel/UCw5A8RUBeBPc6PCQ2z_kLCg/videos	3800	3800	\N
Mindfulness with Mariel	https://www.youtube.com/channel/UCvlbwSot5weaTvzkXPtd02w/videos	494	\N	\N
RoundGlass	https://www.youtube.com/channel/UCsc3U-3MNgTjHVk7P42YFyg/videos	4800	\N	\N
Mindfulness Association	https://www.youtube.com/channel/UCG7euc9ON2PH8Ws_1Sux0Qg/videos	3200	\N	\N
The Men Talking Mindfulness Podcast	https://www.youtube.com/channel/UCXa6UPiIRwNJQOTkAz5qnvQ/videos	7200	\N	\N
Meditate with Deb	https://www.youtube.com/channel/UCp4s3mVqrfG29U_gDAFGMlg/videos	1000	706	581
Breathworks Mindfulness	https://www.youtube.com/channel/UCs0Hk7dGaWW2mJ97gZwqgLA/videos	5500	\N	\N
Monash Mindfulness	https://www.youtube.com/channel/UCR19sWAiaXuJtNx7mp6gcxg/videos	8800	\N	\N
Center for Mindful Self-Compassion	https://www.youtube.com/channel/UCH6fuu1ChJNrs7ecSDdR8QQ/videos	10100	29300	\N
Dr. Mindfulness	https://www.youtube.com/channel/UCaDM90dCqBHX_cfmBAno6uA/videos	3600	301	\N
Meditate: School of Mindfulness	https://www.youtube.com/channel/UCfyCAAXLTPptpRoGAwzCJIQ/videos	1900	\N	\N
Omni Mindfulness	https://www.youtube.com/channel/UCjyoa02oSEutDPE6hGDi_0g/videos	125	\N	\N
Mindfulness With Aly F Canavan	https://www.youtube.com/channel/UCEFyWtl2OVeUJvNp3LqsPbg/videos	1700	\N	\N
Mindful Life Coaching with Dr. Jessie Mahoney	https://www.youtube.com/channel/UCSPkYjJ6YLyEx7t2AjlYBhQ/videos	579	\N	1700
Connected Kids - teach kids meditation	https://www.youtube.com/channel/UC7A7xE0hrqqrhpr4GPOD7Zg/videos	874	740	1000
Gayane Kulikyan - Mindfulness & Healing	https://www.youtube.com/channel/UCTznAC33vMRcubcXgvtd6Vw/videos	480	344	385
Brittany Lynne | Beautifully Awakening	https://www.youtube.com/channel/UCXpVSqlRfmke_NOcCSwJ4ag/videos	1000	\N	\N
A Lust For Life	https://www.youtube.com/channel/UCTVJils4_esMbAplQlK6fjA/videos	1200	39200	\N
Creative Mindfulness	https://www.youtube.com/channel/UCwHJcMkEFM-KeybMRzggcBA/videos	1300	\N	\N
Mindful Meditation with Storytime Family	https://www.youtube.com/channel/UC2lY6h7PAxogV-O7CB31RXg/videos	1700	\N	\N
Make Mind Spiritual	https://www.youtube.com/channel/UCiNogi3RHmLDP2gCYRcsOcw/videos	693	\N	\N
A Mindful Approach to Fitness	https://www.youtube.com/channel/UC91ItJhHAEyO_fuiixybLOw/videos	630	\N	\N
Meditation Mindfulness	https://www.youtube.com/channel/UC1w0ZuVGeasmzZ1KO9muF-w/videos	1500	\N	\N
Mindfulness Project	https://www.youtube.com/channel/UCa-ISJR_srhSGV-5AsGUpKw/videos	1400	\N	\N
Christy Jones Health and Mindfulness Coach	https://www.youtube.com/channel/UCF9VgD1GEVjCrYb8RM63iyw/videos	432	\N	\N
Practice With Lydia Zamorano	https://www.youtube.com/channel/UCmZVqreZtq4w_MO4MciDgPw/videos	1500	\N	14600
Samavira Meditation and Mindfulness	https://www.youtube.com/channel/UCovYdXH3V4N0iWl5o3CYYMg/videos	441	\N	\N
Mark Coleman	https://www.youtube.com/channel/UCQIm0b0861AC9DmrIJOUWFw/videos	1100	2000	3400
Padraig O'Morain Mindfulness	https://www.youtube.com/channel/UCKIy5smVsP6Ok8UwtP6AMlg/videos	809	10600	3300
Susan Young Mindful Coaching	https://www.youtube.com/channel/UC8luOtW8BNWi21WxxUQHg-Q/videos	182	265	646
Peace & Love: Meditation and Mindfulness	https://www.youtube.com/channel/UC2R-lG74F4tNQZSTG0oIgWg/videos	466	\N	\N
Sue Hutton Mindfulness	https://www.youtube.com/channel/UCaM5KReAMKezUu31z3PcxKw/videos	433	\N	\N
Alex Strauss - Author & Natural Mindfulness Guide	https://www.youtube.com/channel/UCrMnVEusez7op8Nn1PzgKYQ/videos	334	\N	\N
Breathworks Mindfulness New	https://www.youtube.com/channel/UCs0Hk7dGaWW2mJ97gZwqgLA	\N	19400	\N
Vanessa Guild - Mindfulness Trainer, Private Coach	https://www.youtube.com/channel/UCQBZpAYfvz8kigDbdqN72Rg/videos	153	\N	\N
Mindfulness With Ms. Guerra	https://www.youtube.com/channel/UCrgANrWsHCEEjjut89Vgx8Q/videos	160	\N	\N
Mrs Mindfulness	https://www.youtube.com/channel/UCR-d964e8gW0hZt9mxaEQvg	\N	1	\N
Mindfulness Academy	https://www.youtube.com/channel/UCzmIJgRiK5lsVc9JHUn9DCw/videos	52	\N	\N
Rita Geraghty - Mindful Life Guide	https://www.youtube.com/channel/UCdfQL9wkxnHBi3FEBHdAv7g/videos	22	\N	\N
Mindfulness 360 - Center For Mindfulness	https://www.youtube.com/channel/UCDurv_diN_vwnFxo_3jmsVA/videos	35900	4300	\N
Quiet Mind Cafe	https://www.youtube.com/channel/UCf-nkEuAif3R1Lt4JKn0igw	12800	\N	\N
Peaceful Breathing - Meditation and Mindfulness	https://www.youtube.com/channel/UCA8iHe0Hgl4KVvpQ7wNW4LQ/videos	7800	\N	\N
Elements - Meditations & Mindfulness	https://www.youtube.com/channel/UC48VQRCUvPrzS14N6w5Iadw/videos	10900	92	843
iBme / Inward Bound Mindfulness Education	https://www.youtube.com/channel/UCZ4AJ3yAUMzO-vA2Y-z4grg/videos	1900	9400	3100
The Centre for Mindfulness Studies	https://www.youtube.com/channel/UCsLua7dma2V68-vR0lzp_RQ/videos	1800	\N	\N
Mindfulness Meditation by Soothing Pod	https://www.youtube.com/channel/UCC7LrjsxGO24fwYL94vCLPg/videos	2900	\N	\N
The Local Mystic	https://www.youtube.com/channel/UC7jTgGGhZxMgQ4PBFooytcQ/videos	2000	\N	4900
Mindfulness Abundance by Dee Gardner	https://www.youtube.com/channel/UCVlpglql_LHPn15ANTk04DA/videos	1300	\N	\N
Pandit Dasa	https://www.youtube.com/channel/UCCIZv5c7LAZVuI0v6mJALLw/videos	1200	2000	148500
Mindfulness in Schools Project	https://www.youtube.com/channel/UC793KKZqPca0iBZPeQNrw4Q/videos	667	\N	\N
Mindfulness Sanctuary	https://www.youtube.com/channel/UCq8BbJ_KM-_3jATfQAE7ZiQ/videos	389	101	192
a Mindfulness Base	https://www.youtube.com/channel/UC_EAU9IDpKjuQy8LMJQpW0Q/videos	353	204	\N
\.


--
-- Data for Name: channels; Type: TABLE DATA; Schema: public; Owner: kevinazrazzz
--

COPY public.channels (youtube_channel_link, channel_name, description, type_of_channel, since, youtuber_name) FROM stdin;
https://www.youtube.com/channel/UCbuENEBzQ69QKmfX2iumnFA/videos	Yogapalooza with Bari Koral	Discover a wonderful world of beloved songs and magical activities that make it easy to teach yoga and mindfulness to children through music. Bari Koral is a widely recognized kids yoga expert and popular recording artist.ABOUT BARI KORALEvery day, thousands of children, parents and teachers around the world are learning and enjoying the benefits of yoga and mindfulness with Bari. Bari's songs and approachable yoga and mindfulness curriculum are used on a regular basis around the world. She is considered a pioneer in the world of kids yoga. To date, she has presented to over 100,000...	Influencer	Apr 2009	Bari Koral
https://www.youtube.com/@TheMindfulMovement/	The Mindful Movement	Welcome! Here at the Mindful Movement, we are an oasis where you can come to tap into your inner calm, develop a positive mindset and heal from the stress that's blocking your fulfillment. We offer guided meditation, visualizations, and hypnosis as well as Yoga, Pilates and a variety of mindful movement practices to help you live mindfully, move well and feel great!We would love to continue working with you personally if you are interested. We offer self-paced, online courses, group coaching, and 1:1 services. You can learn more at our website: Themindfulmovement...	Influencer	Aug 2016	Sara & Les
https://www.youtube.com/channel/UCpw2gh99XM6Mwsbksv0feEg	Moojiji	Mooji brings the possibility of Self-realization into the here and now. He drifted in a state of spontaneous meditation oblivious to the outer world he formally knew. During these years, he lived almost penniless but was constantly absorbed in inner joy, contentment and natural meditation. His communication is simple, direct and immediate. An invitation to move from person to presence -- and ultimately, to liberation. He speaks to you.	Influencer	Aug 2007	Anthony Paul Moo-Young
https://www.youtube.com/@TaraBrach/	Tara Brach	Tara Brach is a leading western teacher of Buddhist meditation, emotional healing and spiritual awakening. This channel is a compilation of Tara Brach's video offerings, including her popular Wednesday night weekly livestream; a library of guided meditations; short clips from the 'Tara Talks' web series; interviews and various other engagements. All content on this channel is owned by Tara Brach, PhD. All rights reserved.For more information, go to https://www.tarabrach.com	Influencer	Apr 2011	Tara Brach
https://www.youtube.com/channel/UCqWB6EseWbMKnzunyewBDqg/videos	Meditation Vacation	Guided meditation got me through a tough stage in my life and by creating my own meditation videos. This channel is about how to meditate as my guided meditation videos explain what to do and can send you into a deep relaxation and through mindfulness. Using guided meditation on a regular basis can truly help with relaxation, sleep and peace inside.	Influencer	Jun 2015	Christian Thomas
https://www.youtube.com/@ChibsMeditation/	Chibs Okereke Meditations	Chibs Okereke's guided meditations and soothing voice have helped millions find deep relaxation, better sleep and less stress. He is a meditation instructor on the Calm app and an accredited mindfulness facilitator. Having personally struggled with anxiety, stress, and burnout, Chibs understands how important it is to feel supported during meditation, so these meditations will help you feel grounded, peaceful, and safe.Subscribe for regular meditations that blend modern mindfulness techniques with practical strategies for better sleep, less anxiety, and deeper relaxation...	Influencer	Jan 2007	Chibs Okereke
https://www.youtube.com/@MindfulnessExercises/	Mindfulness Exercises	Mindfulness Exercises shares free mindfulness meditations, courses, trainings and resources for mindfulness practitioners and mindfulness meditation teachers alike.Sean Fargo created Mindfulness Exercises to help people live with embodied presence, compassion and resilience. We provide audio meditations, guided meditation scripts, mindfulness worksheets, mindfulness courses, and live online retreats...	Influencer	May 2014	Sean Fargo
https://www.youtube.com/channel/UCK7X0kE4vCbOXPi1VPVQYFw/videos	Mindful Music	Just fresh music. As always, please stay Mindful, discover, share, and inspire! Peace. All music posted is for promotional use only most of which is acquired via submissions and permission from artist/producer.	Influencer	Nov 2014	Mindful Music
https://www.youtube.com/channel/UCFmUuRhirRUPRtROX0KiQcw/videos	The Mindfulness Teacher	⭐️Children's Relaxations for Mental & Emotional Well-Being, Calm & Focus in the Classroom.I help teachers, educators, parents & mental health professionals to improve their student's/children's mental & emotional well-being so that they can have calmer kids & calmer classrooms. Because my content is made for children, unfortunately the comments are turned off. If any teachers/educators or parents/guardians want to contact me, you can do so through the links in my channel below.	Influencer	May 2020	Holly Morris
https://www.youtube.com/channel/UCjQxrBbp-9aCBzWIsiuHmiA/videos	Palouse Mindfulness	Dave Potter is a certified Mindfulness-Based Stress Reduction instructor. Palouse Mindfulness provides these videos as part of the free online mindfulness course (MBSR). It is an eight-week 100% free course and contains all the materials used in the in-person course taught by Dave Potter, who is fully certified to teach MBSR by the University of Massachusetts Medical School.	Influencer	Mar 2013	Palouse Mindfulness
https://www.youtube.com/channel/UCaON5f-W7kWBixxZEkhYicw	Jamie Marich	Jamie Marich is the Author of EMDR Therapy & Mindfulness, Trauma Made Simple, Trauma and the Twelve Steps and EMDR Made Simple; Creator of Dancing Mindfulness. Learn about trauma in a way that is relevant to clinical work, including extensive coverage on PTSD and other diagnoses through a bio-psycho-social-spiritual lens.	Influencer	Jul 2011	Jamie Marich
https://www.youtube.com/channel/UCneFwNzUhZCuEyDxNHKdKVw/videos	Crossroads Psychology	Voicu Mihnea Simandan is a Certified Positive Psychology & Mindfulness Practitioner and Coach. He coaches & teaches Positive Psychology to athletes, students and parents; as well as leads & facilitates Mindfulness retreats and experiences.The Crossroads Psychology Video-Podcast aims at Encouraging Personal Growth.'A Wall of Ideas' Video-Podcast aims at creating a communication bridge to discuss topics related to technology, education, culture, travel, productivity, and the expat life.Previously, the channel's focus was on travel and sports, especially Asian destinations,...	Influencer	Feb 2007	Voicu Mihnea Simandan
https://www.youtube.com/channel/UCVCM37ofcquSCtnCpdkhxwQ/videos	Scott Todnem | Mindful Teaching	Mindful teaching and mindset leading.Scott Todnem has been teaching Health Education at Scullen Middle School in Naperville, Illinois since 2001. In that time, hundreds of students each year have gone through a course about the best subject in the world: LIFE.Social Health impacts who we are; our interactions from the past can drastically shape who we become in our future. Therefore, this YouTube channel, the LifeIsTheFuture.com webpage, and other social media have become a fun and creative way to express lifelong connections and learning... to remember the past and reminisce... and to...	Influencer	Aug 2017	Scott Todnem
https://www.youtube.com/channel/UCQTlKxfVk5o6B5SvbvYdSZQ/videos	Loch Kelly	No description	Influencer	Jun 2014	Loch Kelly
https://www.youtube.com/channel/UCyUMUmuQi9Ni9qh-FEkM9WQ/videos	Mindfulness | Shamash Alidina	Shamash has been practising mindfulness since 1998 and runs his own successful training organisation.He is best known as the internationally bestselling author of 10 books including Mindfulness For Dummies and The Mindful Way through Stress. Based in London, he runs online trainings and speaks at conferences all over the world.He is a keen educator and has trained almost 500 mindfulness teachers in the last 11 years. Prior to that, he spent 10 years teaching mindfulness/meditation as well as science, in schools.Shamash has been training practitioners in Acceptance and Commitment...	Influencer	Dec 2006	Shamash Alidina
https://www.youtube.com/channel/UCpbhe71UUAh-j9prsMTyyBA/videos	Mindful Creative Muse	No description	Influencer	May 2015	Cynthia Hauk
https://www.youtube.com/channel/UCyuAzAFsNzcypnAa1XSlnog/videos	Mindful in Minutes || Kelly Smith	Guided Meditation | Yoga | Deep Relaxation | At Home Meditation | Sleep Meditation | Meditation For Beginners | Meditation Music | Yoga Meditation Hey, I'm Kelly, the founder of Yoga For You, and host of the Mindful in Minutes podcast, and Meditation Mama. Mindful in Minutes provides short, weekly guided meditations to help you stress less and live more. Join me each week for simple and grounded guided meditations that are 20 minutes or less and cover an array of topics that will help you with real life like anxiety, insomnia, self-esteem, and manifestation.I believe there isn't...	Influencer	Jan 2016	Kelly Smith
https://www.youtube.com/channel/UCUPP3b6x2a1FcUMTrsdAR2g/videos	Cory Muscara	Cory Muscara is a former monk, co-founder of Mindfulness.com, and bestselling author of the book, Stop Missing Your Life. With over 500K followers across his social media channels, Cory has gained popularity for his down-to-earth, engaging, and accessible teachings on mindfulness, wellbeing, and mental health. He has taught Mindful leadership at Columbia University, is an instructor of Positive Psychology at the University of Pennsylvania, and for the last ten years has offered mindfulness keynotes, workshops, and retreats around the world to companies like Bank of America, Prudential, Johnson	Influencer	May 2013	Cory Muscara
https://www.youtube.com/channel/UCR-d964e8gW0hZt9mxaEQvg/videos	Melli O'Brien:	Melli O'Brien is mindfulness teacher but, first and foremost, a devoted mindfulness practitioner (who's still learning, discovering and deepening every day).Sharing the art of mindful living is her passion and purpose. Melli's passion for teaching mindfulness stems from her firm belief that anyone can create the kind of incredible inner transformation she has undergone once they know how.Melli's mission is to help you enjoy a more fulfilling and meaningful life.She is not a monk or an evangelist of any particular religion or technique. She live in the real world and her...	Influencer	Dec 2012	Melli O'brien
https://www.youtube.com/channel/UCkGwhgfmKK3ghv2MDMOkMxA/videos	MindfulNEWS	10 years investigating the subject of happiness and podcasting about what matters most in life with scientists, bloggers, teachers, authors and the leading experts, on the subjects that matters most. Conversations with friends led to conversations on Mindfulness that led to a wonderful path of learning and better relationships. Podcasts, Videos, Vlogs, Car pool conversations, Guided meditations and On-line courses at www.Mindfulnews.uk (Mindfulnews.uk on instagram)	Influencer	Jul 2011	Gui Hung
https://www.youtube.com/@SarahMcLeanMeditation/	Sarah McLean, Meditation & Mindfulness Teacher	Over 30 years ago I was searching for peace. My search led me to mystical places around the world, though I found what I was looking for when I finally learned to meditate. Since, I've lived & worked in a Transcendental Meditation community, helped Deepak Chopra start his Mind Body Health Center, lived in a traditional ashram in India & served as a cook in a Zen Buddhist monastery, & became the director of Byron Katie's school.No, you don't have to move to India, find a guru, or become Buddhist to do meditation 'right...	Influencer	Sep 2014	Sarah McLean
https://www.youtube.com/channel/UC-0g3lxbb3Ujskpr3rrzI-Q/videos	Rocky Heron	Rocky Heron is an artistic wonder a singer, songwriter, yogi, and mindfulness instructor with an eclectic sound. Known for his uncanny wisdom and in-depth understanding of the human body, Rocky's teaching is informed by years of study in many yoga styles and movement modalities. Considered in the yoga industry a 'teachers teacher,' Rocky works worldwide and online facilitating classes, training, and continuing education for teachers. Rocky's musical library consists of 'The Requiem EP', his sophomore acoustic project, 'The Love Demos', and the pop-inspired 'Nuffa...	Influencer	Apr 2007	Rocky Heron
https://www.youtube.com/channel/UC7LfxLU3jmBdiScY-_24OBg/videos	Mindful Yoga for Healers with Dr. Jessie Mahoney	I teach heart-centered yoga to relieve tension, aches, pains, overwhelm, and burnout. My intention is to help you optimize your breath, grow self-compassion, relieve stress, let go of frustration, and discover alignment.I am a life coach and yoga teacher. I coach those who are successful on the surface yet struggle underneath. I specialize in relationships, parenting, career transitions, and burnout coaching. I also co-host the Mindful Healers Podcast and host yoga, coaching, and culinary medicine retreats for women physicians who want to find calm and start living their best life....	Influencer	May 2020	Jessie Mahoney
https://www.youtube.com/@OrenJaySoferVideo/	Oren Jay Sofer	Expert teaching on mindfulness practice and Insight meditation, and mindful communication for wellbeing, balance and clarity in life and at work. Join author, meditation teacher, and communication trainer Oren Jay Sofer for guidance and instruction in living in line with your values, resolving conflict, and learning to meditate.Oren Jay Sofer teaches Buddhist meditation, Dharma, and communication retreats and workshops nationally...	Influencer	Nov 2013	Oren Jay Sofer
https://www.youtube.com/channel/UCvb0vkbdBJF-Qx7tZ6HWqIQ/videos	Harp & Wellness	Nicole E. AndersonCertified Therapeutic Musician, Therapist/Life Coach, and Certified Meditation & Mindfulness TeacherSpecializing in Harp Therapy and Holistic WellnessWelcome to my channel! I offer content that focuses on self-care and mental health with a unique spin: harp music!My videos include harp therapy, harp music for relaxation, mindfulness exercises, meditations, and more. Join me for topical discussions, soothing music, mindfulness, and tips for self-care as we make our way through our challenges and stressors. Currently I am releasing harp and nature relaxation videos...	Influencer	Sep 2016	Nicole E. Anderson
https://www.youtube.com/channel/UC5F4sqam3xc5hkYwqdMBW2Q/videos	Mindfulness With Missy	Welcome to mindfulness with Missy. On this channel, we will do meditations, affirmations, and visualizations. This is a safe place to heal your mind and become a happier, healthier, more calm version of you!Disclaimer: These meditations are not intended to replace professional help. None of these meditations should be listened to while operating machinery. Anything that happens while you listen to these videos is your responsibility and mindfulness with missy is not liable.	Influencer	Oct 2021	Missy
https://www.youtube.com/channel/UCyicqwQM9aIZ9mAw5xP4Q2g/videos	Anthony Ongaro	Hi, I'm Anthony! Welcome to Break the Twitch. I make videos about intentional living, and building a life in alignment with our values. Anthony Ongaro shares his explorations in how to live a better life through minimalism, habits and creativity.	Influencer	Feb 2015	Anthony Ongaro
https://www.youtube.com/channel/UCGYeWtdm9GXYcdgkLph9Rcw/videos	Fablefy - The Whole Child	Fly With Able and Fy is dedicated to bringing mindfulness to parents and children. Through our interactive animated series which can be used anywhere to help you grab a moment of peace in your life, we aim to create a space where you and your children can live mindfully. About the Creator: Hi, I am Shilpi Mahajan and I am a single person army responsible for conceptualization and creation of the channel. Any support via shares, subscriptions and likes will be helpful. If you choose to use portions of the videos on the channel, please seek approval. If you want a specific request, please...	Influencer	Feb 2017	Shilpi Mahajan
https://www.youtube.com/channel/UCZVJN6ow1IeGWH6HkaNqu_g/videos	John Davisi	John is a certified professional coach, consultant, and advisor. In 2016, his passion and work in mindfulness coaching and as an HR leader merged while VP of People Operations & Mindfulness at internet media company BuzzFeed. While there he established and led the company's first mindfulness program, including facilitating weekly, live meditation sessions and mindfulness workshops for employees globally. He's written and narrated several meditations for @goodful and has 100+ meditations on his own YouTube channel. In 2022 John released four albums. The first in April titled Breathe -...	Influencer	Oct 2014	John Davisi
https://www.youtube.com/channel/UCWRGNm4blMTh_DsNTiuzyxw/videos	Voice of Mindfulness ASMR	I'm Ellen from Voice of Mindfulness, a self-healing & self-improvement channel that can help you relax, find peace and meaning and improve your life through mindfulness, sound healing and a touch of ASMR. I provide a safe and peaceful space for you to focus on YOU while you sleep.The channel also offers 'Sleep Heal & Grow' hypnosis, guided meditations, mental health practices and spiritual guidance infused with ASMR, to help find a deeper connection to yourself and the world around you. The videos are created with the intention of helping you sleep soundly, relieve anxiety, recover from...	Influencer	Jul 2022	Ellen
https://www.youtube.com/channel/UCbjljhC9ecohK38jcEvGebg/videos	Mindfulness Place	Welcome to the Mindfulness Place!When you practice mindfulness you experience calmness and relaxation, higher levels of energy and enthusiasm for living, increased self-confidence and self-acceptance and more compassion for others. You also experience less stress, depression, anxiety, chronic pain, addiction or low immune function.We upload weekly free Mindfulness Exercises, Guided Meditations, and Positive Affirmations.The best place to start is by subscribing to our FREE Inner Journey meditation course at:https://nisandeh.com/inner-journey/	Influencer	Jan 2019	Mindfulness Place
https://www.youtube.com/channel/UC4hp1CWJx7zUKeOpD7XzG6w/videos	Mindfulness in Blue Jeans	After denying his own trauma for eight years, Ron Levine finally fell apart in a crippling heap of anxiety, depression, panic disorder, and agoraphobia in early 1998. On disability and unable to leave his house, he began practicing vipassana (mindfulness-based insight meditation), which sparked a life-changing new direction cultivated on and off the cushion.With backgrounds in social psychology, information technology, and yoga, Ron emphasizes a methodical and scientific results-based approach to facing our demons and finding inner peace. From Ron: 'We each must walk our own path, but...	Influencer	Mar 2020	Ron Levine
https://www.youtube.com/channel/UCSyNIDWAM9cRzkn7Uz4IwTw/videos	\N	Your daily dose of relaxation.Meditation Relax Club is the main Youtube Leader in Meditation and Relaxation Music. Born in 2012, thanks to the well-known experience of our composers and collaborators, MRC channel is working everyday with constancy and passion to give you a real experiece of relaxation, thanks to the multitude of videos we create everyday, with the most calming and peaceful new age music. The zen music available for users on Meditation Relax Club can be used as deep meditation music, sleep music (for those of you who need something really soothing for falling asleep),...	Mega	Sep 2012	MeditationRelaxClub - Sleep Music & Mindfulness
https://www.youtube.com/channel/UC3JhfsgFPLSLNEROQCdj-GQ	\N	Headspace is guided meditation for everybody. Learn how to meditate, wherever you are, whenever you like. That's as well as mindfulness exercises for everyday situations like commuting or cooking, dozens of animations like the ones you see on this channel & 8 different meditation techniques, all taught by Headspace's co-founder, Andy Puddicombe, a former Buddhist monk. With hundreds of hours of content, Headspace is your personal meditation guide to just about anything.	Macro	Sep 2014	Headspace
https://www.youtube.com/channel/UCoqtKR3DyzMoSaMxqSyrdig/videos	\N	Brain Education TV is a self improvement channel for the brain with videos on how to practice self care and boost your brain power. The foundation of our content comes from Brain Education, an academic study from South Korea that stems from over 40 years of research and application and has been practiced by millions around the world.	Macro	\N	Brain Education TV
https://www.youtube.com/channel/UCc1lvEoC5PZWm-MzgUfJQfg/videos	\N	Be Here Now Network is dedicated to the gathering and dissemination of spiritual talks, podcasts and writings of master teachers of Spirituality, Mindfulness and Meditation. Awaken through impactful, insightful, and entertaining podcasts with the wisdom keepers of today.	Macro	Jun 2016	Be Here Now Network
https://www.youtube.com/channel/UCbcI2r4u2hyBjyNe9YcoDfA/videos	\N	No description	Macro	Mar 2014	MindfulPeace
https://www.youtube.com/channel/UCEhl4Grr46IolhzGhZ3agNw	\N	No description	Macro	May 2011	Wisdom 2.0
https://www.youtube.com/channel/UCJaUaqWbSdyTklGsWnuFtMg/videos	\N	Welcome to My Peace of Mindfulness! We provide the best free guided meditation videos on Youtube.Do you suffer from depression, anxiety or insomnia? Or maybe, you're looking to remove negative energy and stress. We produce short meditation videos on a daily basis to help you let go, meditate at home, attract money & positive energy and manifest the life you desire. Whether you're a meditation beginner or a meditation pro, our video will help you to relax and find inner peace. Please enjoy our mindfulness meditation videos in a relaxing secluded location.We'd love to hear your...	Macro	Jul 2016	My Peace Of Mindfulness
https://www.youtube.com/channel/UC2ZvMgbK5X8j-nCY5CR06xw/videos	\N	Declutter The Mind is for the beginner, novice, and experienced meditator. It's where people who want to clear, declutter and understand their minds come.If you want to understand the mind, sit down and observe it. My goal is to help you observe it (much more easily and effectively) with guided meditations for mindfulness, anxiety, stress, focus, sleep deprivation, insomnia, depression and more.This channel hopes to help you meditate without the 'woo woo' or any religious undertones. I want meditation to be viewed as and used as a practical tool for anyone.I understand and want...	Macro	Jan 2019	Declutter The Mind
https://www.youtube.com/channel/UC1ydk-XgJws0RCrg1Kofxbw/videos	\N	We support and empower Muslim women so they can not just grow, but thrive. Our channel gives tips and advice on love, parenting, inspiration, motivation and everything else associated with living a more mindful modern Muslimah life.Check out our website; www.mindful-muslimah.comReach out to me on Instagram at @MindfulMuslimah or via email at ****@mindful-muslimah.com	Micro	Sep 2018	Mindful Muslimah
https://www.youtube.com/channel/UCGliqsod-tQoGiHahxS9Wig/videos	\N	The Insight Meditation Center is a community-based, urban refuge for the teachings and practice of insight meditation, also known as mindfulness or vipassana meditation. We offer Buddhist teachings in clear, accessible and open-handed ways.Guided by Gil Fronsdal and Andrea Fella, IMC offers a broad range of programs and community activities.IMC does not require payment for any of our teachings, programs or events. The support of our teachers and center expenses is done through voluntary donations from the community. All the work in running and maintaining IMC and its programs is done by...	Micro	Jan 2011	Insight Meditation Center
https://www.youtube.com/channel/UCiYQrjtMgfJFYabJy0wY8nA	\N	Mindful Wing Chun is one of the biggest Wing Chun school in HK and is located in the Heart of Central. Our mission is to pass on Grandmaster CHU SHONG TIN's 'internal' method of Wing Chun which promotes health through cultivating MINDFULNESS and Deep RELAXATION resulting in a BALANCED Body and Mind.	Micro	Apr 2014	Mindful Wing Chun
https://www.youtube.com/channel/UC0GmmgMoHnZArG4FNVfKPew/videos	\N	Mindful Mama Mentor Hunter Clarke-Fields, MSAE, RYT, is the creator of the Mindful Parenting course, host of the Mindful Mama podcast and widely-followed author of Raising Good Humans: A Mindful Guide to Breaking the Cycle of Reactive Parenting and Raising Kind, Confident Kids. Mindful Mama is about becoming a less irritable, more joyful parent. We know that you cannot give what you do not have. And when you are thriving, when you have calm and peace within then you can give it to your children. Learn about Mindful Parenting. Listen and get inspired!New videos are posted every week.	Nano	Apr 2013	Mindful Mama Mentor
https://www.youtube.com/channel/UCXsjej0djMYxtGC3RMHBUvg/videos	\N	No description	Micro	May 2015	Mindful
https://www.youtube.com/channel/UC-sxY90UX6IiLDpYeQrxFYg/videos	\N	Discover the essence of mindfulness and learn at the Inner Mind InstituteStudy and practice meditation and mindfulness step by step, as a student or a teacher, through our online platform or in one of the Inner Mind Institute retreat centers.	Micro	May 2020	Master Niels
https://www.youtube.com/channel/UCt_di56chWq4svfsdGV5gRw/videos	\N	Metta Mindfulness Music is an innovative, one of its kind collaboration between leading experts in the field of holistic healing and master world musicians. Metta Mindfulness Music's Executive Producer and President is renowned healer, Dr. Richard Gold. Metta Mindfulness Music's Artistic Director is critically acclaimed composer and educator, Yuval Ron. Our Mission Statement:To create beautiful original music that enhances health, mental equanimity, and the daily expression of loving kindness. To create original music that is informed by ancient wisdom traditions and the most...	Nano	Apr 2015	Metta Mindfulness Music
https://www.youtube.com/channel/UCSA3tLxw52HgRdazOXidyXA/videos	\N	Hey there! My name is Julia, welcome to my channel. I'm a Certified Mindfulness Meditation Teacher and I created this channel to share my passion for conscious living, mindfulness, and meditation with you.On this channel, you'll find a little bit of everything that I love. From guided meditations to help you relax and destress, to tips and tricks for incorporating mindfulness into your daily routine, and even some delicious whole-food plant-based recipes to keep your body and mind feeling their best.I believe that living a more conscious and mindful lifestyle can bring a lot of...	Nano	Oct 2019	Julia Delaney | Positive Pranic
https://www.youtube.com/channel/UCw5A8RUBeBPc6PCQ2z_kLCg/videos	\N	Livestream and other content from Common Ground Meditation Center, Minneapolis, Minnesota.Common Ground is a community meditation center dedicated to the practice of mindfulness. Mindfulness meditation is the practice of waking up to the present moment and learning to be open and at ease with the unfolding conditions of life. With practice, mindfulness reveals deep wisdom, compassion, and intimacy with all things.	Nano	Mar 2019	Common Ground Meditation Center
https://www.youtube.com/channel/UCvlbwSot5weaTvzkXPtd02w/videos	\N	Hello! Thank you so much for taking the time to watch this video and to hopefully subscribe to my channel . This space, I hope finds you well and helps you in your day-to-day life become the best version of you. I believe in the power of human kindness and mindfulness. I am an educator, movement instructor, and mindfulness teacher. Why ? Because I believe in and want to share simple ways of how you can live a balanced, healthy, happy life through the personal bettering of yourself. I challenge you to subscribe and to follow. Take time for self-care each day and join me in providing love and...	Nano	Apr 2020	Mindfulness with Mariel
https://www.youtube.com/channel/UCsc3U-3MNgTjHVk7P42YFyg/videos	\N	RoundGlass believes that Wholistic Wellbeing is for all to experience. While life doesn't stop throwing challenges at us, we can be better equipped to handle them. Through meditation and mindfulness practices, end-of-life support, workplace solutions, yoga asanas, and healthy recipes, RoundGlass offers wellbeing in the most important quarters of life. Self-care, mental fitness, physical wellbeing, and positivity are the most important tools every human living modern life needs. Learn how to use them and bring many noticeable benefits in your life now. Explore how you can give more to...	Nano	Sep 2014	RoundGlass
https://www.youtube.com/channel/UCG7euc9ON2PH8Ws_1Sux0Qg/videos	\N	At the Mindfulness Association, we believe that mindfulness is a way of life and not a brief intervention for relieving symptoms. We provide a long-term systematic training in mindfulness for life - from teaching the foundations of mindfulness for beginners right through compassion an insight training to our two Masters programmes- MSc Mindfulness Studies with the University of Aberdeen and MSc Mindfulness & Compassion (with teacher training) with the University of the West of Scotland in London. Our Masters tutors teach on all our courses at all levels. We train in being present,...	Nano	Jun 2016	Mindfulness Association
https://www.youtube.com/channel/UCXa6UPiIRwNJQOTkAz5qnvQ/videos	\N	No description	Nano	Feb 2021	The Men Talking Mindfulness Podcast
https://www.youtube.com/channel/UCp4s3mVqrfG29U_gDAFGMlg/videos	\N	Learn with a Meditation Practitioner and Instructor since 1980Deb Phelps is a certified Meditation Teacher, Sound Healer, Mindfulness Coach, and Yoga Specialist who uniquely assists her clients overcome stress, anxiety, PTSD, grief, and other life situations so that they can once again live purposeful, joy-filled lives. Deb has overcome significant life challenges aided by a variety of mind-body-spirit practices.	Nano	Jul 2017	Meditate with Deb
https://www.youtube.com/channel/UCs0Hk7dGaWW2mJ97gZwqgLA/videos	\N	The Breathworks approach is grounded in compassionate awareness, with a gentle, gradual transformation of our relationship to all our life experiences, including our pain or difficulty. We invite everyone engaging with Breathworks practices and courses to take care of their own well-being as fundamental to our approach. If you suffer from physical, emotional or mental health conditions, please take care not to push yourself past your own safe boundaries when	Nano	Aug 2010	Breathworks Mindfulness
https://www.youtube.com/channel/UCR19sWAiaXuJtNx7mp6gcxg/videos	\N	Welcome to the official YouTube channel for Monash University's 'Mindfulness for Wellbeing and Peak Performance' and 'Maintaining a Mindful Life' courses on FutureLearn. If you're taking part in either course, this is where we'll post all of the feedback videos we record for each course. You're welcome to subscribe, like and comment here, but the best place to engage in discussion with other learners is the comments section of each course on FutureLearn. Join now https://www.futurelearn.com/courses/mindfulness-wellbeing-performance and...	Nano	Sep 2015	Monash Mindfulness
https://www.youtube.com/channel/UCH6fuu1ChJNrs7ecSDdR8QQ/videos	\N	This channel is designed to be a resource for people wanting to explore Mindful Self-Compassion practices, as developed in the Mindful Self-Compassion (MSC) Training designed by Kristin Neff and Christopher Germer. For more information, please see the Center for Mindful Self-Compassion website at www.CenterForMSC.org	Micro	Dec 2013	Center for Mindful Self-Compassion
https://www.youtube.com/channel/UCaDM90dCqBHX_cfmBAno6uA/videos	\N	Are you interested awakening to your loving and compassionate true nature? Here you'll find the complete talks and Q & A associated with my weekly meditation group. The videos bring together information and experiential practices on how to do that, introducing material from Buddhism and other spiritual traditions told from a modern, secular perspective: focusing on direct practices for reducing suffering in your daily life. I have a PhD in social work, nine book publications, publications in scholarly journals, and over 30 years of Buddhist practice in the Zen and Theravada traditions....	Nano	Nov 2006	Dr. Mindfulness
https://www.youtube.com/channel/UCfyCAAXLTPptpRoGAwzCJIQ/videos	\N	Meditate: School of Mindfulness leads Mindfulness Lessons and meditations as WE share OUR passion to help OUR clients and students WAKE UP and own their life in the most authentic way. MSOM offers Mentorship programs in Transformational Coaching, Meditation Teaching, Hypnosis Coaching, Mindful Addiction, Sound Healing, Yoga Nidra, and more.https://linktr.ee/meditate_school_of_mindfulness	Nano	Mar 2017	Meditate: School of Mindfulness
https://www.youtube.com/channel/UCjyoa02oSEutDPE6hGDi_0g/videos	\N	Welcome to the Omni Mindfulness Channel! I'm Shilpa, and I am a Mindset & Meditation Coach. Omni Mindfulness is a one-of-a-kind channel. Here you will find inspirational Podcasts, Guided Meditations, Meditation & Mindfulness Coaching Tips, and Practical Tips.#omnimindfulness #podcast #guidedmeditations #shilpaslewis	Nano	May 2020	Omni Mindfulness
https://www.youtube.com/channel/UCEFyWtl2OVeUJvNp3LqsPbg/videos	\N	No description	Nano	May 2012	Mindfulness With Aly F Canavan
https://www.youtube.com/channel/UCSPkYjJ6YLyEx7t2AjlYBhQ/videos	\N	Dr. Jessie Mahoney is a mindful life coach, wellness expert, and pediatrician. She is the founder and CEO of Pause and Presence coaching where she supports those who are successful on the surface yet struggle underneath with mindful coaching. She co-hosts the Mindful Healers Podcast and teaches Mindful Yoga for Healers. Her yoga youtube channel is https://www.youtube.com/channel/UC7LfxLU3jmBdiScY-_24OBgConnect with her at www.jessiemahoneymd.com.Coach with Her: https://www.jessiemahoneymd.com/coachingJoin a Coaching & Yoga Retreat: https://www.jessiemahoneymd.com/retreatsRequest a...	Nano	Feb 2022	Mindful Life Coaching with Dr. Jessie Mahoney
https://www.youtube.com/channel/UC7A7xE0hrqqrhpr4GPOD7Zg/videos	\N	Connected Kids YouTube channel will guide you through tips, ideas and practices to empower you to teach meditation and mindfulness for parentingeducationages - kindergarten to teenstopics - autism, ADHD, trauma, SENThese videos are based on our 20 years experience of helping people teach children and teens mindful skills to reduce anxiety and stress.We've published 3 books on thisCalm Kids (how to guide for beginners) - 2012Connected Kids (for teaching more experienced levels and includes autism and based on pilot studies) 2014Robbie and Jess - fictional story for bed-time...	Nano	Aug 2011	Connected Kids - teach kids meditation
https://www.youtube.com/channel/UCTznAC33vMRcubcXgvtd6Vw/videos	\N	A space for healing, mindfulness and wellness. I support women who are stressed, stuck and overwhelmed and who desire to experience Soul fulfillment and inner peace. This 30 min body scan meditation will give you an opportunity to slow down and to gently connect with your body in a deeper way. It will support you in releasing stress, anxiety, and pain, as you intentionally focus your awareness on different body parts. Remember to give yourself...	Nano	Feb 2014	Gayane Kulikyan - Mindfulness & Healing
https://www.youtube.com/channel/UCXpVSqlRfmke_NOcCSwJ4ag/videos	\N	Hi! I'm Brittany 🙂 After experiencing the life-changing effects of consistent mindfulness in my own life, I began sharing the practices that led me to a happier & healthier lifestyle. Through movement, mindfulness & reflection, I share self-care practices to enrich your life and nourish every aspect of your well-being.I post new full-length practices on YouTube as often as possible, offer online yoga classes & mindfulness courses & teach virtual sessions live with individuals, groups & companies. I hope you can join me for my upcoming retreat to Portugal in May 2023 or for a Teacher...	Nano	Oct 2011	Brittany Lynne | Beautifully Awakening
https://www.youtube.com/channel/UCTVJils4_esMbAplQlK6fjA/videos	\N	We are an Irish wellbeing movement created to transform how we talk about and treat mental health. Our Vision is world where the wellbeing of humanity is the headliner on the main stage, and everything else is a support act.	Nano	Nov 2014	A Lust For Life
https://www.youtube.com/channel/UCwHJcMkEFM-KeybMRzggcBA/videos	\N	No description	Nano	Jun 2018	Creative Mindfulness
https://www.youtube.com/channel/UC2lY6h7PAxogV-O7CB31RXg/videos	\N	Mindfulness meditation is the practice of engaging and staying in the present moment, paying attention and bringing awareness to your breath, body, mind, feelings and your senses. When we teach children mindfulness skills we can help them gain the tools to meet the stresses of life with presence, self-compassion, honesty, openness and build confidence, resilience and hone their focus.You can introduce mindfulness to children through everyday informal practices that you can do along with them - expressing appreciation and gratitude, offering good wishes and compassion to others, enjoying	Nano	Oct 2021	Mindful Meditation with Storytime Family
https://www.youtube.com/channel/UCiNogi3RHmLDP2gCYRcsOcw/videos	\N	No description	Nano	Jul 2020	Make Mind Spiritual
https://www.youtube.com/channel/UC91ItJhHAEyO_fuiixybLOw/videos	\N	Troy Devlin is a Health Coach and Mindfulness Guide with over 15 years professional experience as an instructor in the law enforcement industry.This channel is intended to share helpful insights that first responders and others might find useful when addressing the challenges to ones health and wellness that are typically encountered when performing high stress jobs.Troy Devlin is a certified physical fitness instructor and mindfulness guide but he is not a doctor.Therefore the information provided by this channel is for entertainment purposes only and is not intended to take the place of	Nano	Oct 2022	A Mindful Approach to Fitness
https://www.youtube.com/channel/UC1w0ZuVGeasmzZ1KO9muF-w/videos	\N	No description	Nano	Oct 2022	Meditation Mindfulness
https://www.youtube.com/channel/UCa-ISJR_srhSGV-5AsGUpKw/videos	\N	The Mindfulness Project is making evolution happen. Nothing less than that. Our Vision is a healed, mindful and loving Planet.Rural Thailand, in a village near Khon Kaen, we created a volunteering society, which is the living proof that our vision works!And we have a community that is sharing this lifestyle all over the world. Do you want to become a part of this community? Here you go!On this channel we are sharing ideas to create a sustainable, healthy and ethically conscious way of living.Teachings about:-Personal Development & Psychology-Permaculture-Natural...	Nano	Apr 2015	Mindfulness Project
https://www.youtube.com/channel/UCF9VgD1GEVjCrYb8RM63iyw/videos	\N	I am a Holistic Health and Mindfulness Educator. Specializing in the Gut/ Brain connection. I teach people how to improve their digestive health, reduce stress and tap into the health and well being they have been seeking.I teach mindfulness/neuroplasticity classes for students kinder through high school and staff development training's in schools that teach us to make our brain more flexible, release negative emotions from the body, increase brain function and become the master of our brain. The videos I post are designed to give the views some tools they can do at home to improve...	Nano	Nov 2015	Christy Jones Health and Mindfulness Coach
https://www.youtube.com/channel/UCmZVqreZtq4w_MO4MciDgPw/videos	\N	I'm passionate about sharing yoga and mindfulness-based practices that are playful and accessible. Join the Practice with Lydia community: https://practicewithlydia.uscreen.ioJoin my mailing list for freebies, resources and news on upcoming offerings: http://eepurl.com/g9lcbDWarmth, Lydia	Nano	Nov 2008	Practice With Lydia Zamorano
https://www.youtube.com/channel/UCovYdXH3V4N0iWl5o3CYYMg/videos	\N	Samavira is here to help you elevate your meditation experience and live life at your best. All Samavira trainings combine Eastern principles, science, and experience design to bring wisdom to modern living. We empower you to create your individual meditation style and routine without relying on a device. Our growing global network of meditation instructors are bringing Samavira to the cities around the world. Want to live well, grow and connect? Join our community.	Nano	Apr 2020	Samavira Meditation and Mindfulness
https://www.youtube.com/channel/UCQIm0b0861AC9DmrIJOUWFw/videos	\N	Mark has devotedly studied mindfulness meditation practices for three decades and has taught mindfulness meditation in six continents for the past twenty years. Mark is a senior meditation teacher at Spirit Rock Meditation Center. He holds a MA in Clinical Psychology and is a therapist and coach. Through the Mindfulness Training Institute Mark leads Professional Mindfulness Teacher Training programs in the US and UK annually. Mark founded The Mindfulness Institute, where he has brought mindfulness teachings to companies and the non profit sector across North America and Europe.	Nano	Sep 2012	Mark Coleman
https://www.youtube.com/channel/UCKIy5smVsP6Ok8UwtP6AMlg/videos	\N	Mindfulness author and teacher Padraig O'Morain on mindfulness and related practices such as self-compassion and gratitude. These short (mostly) videos will bring you key practice points and attitudes derived from Padraig's more than 30 years of mindfulness practice and learning. Padraig is the author of many books on mindfulness, published in many countries and languages. His online courses and online mindfulness events are enjoyed by participants all over the world and especially in Ireland and the UK. Many of my events are run on a donation basis to make them accessible to...	Nano	Jan 2021	Padraig O'Morain Mindfulness
https://www.youtube.com/channel/UC8luOtW8BNWi21WxxUQHg-Q/videos	\N	Susan Young is a certified life coach specializing in mindfulness and guided meditation practices. Her action-based coaching helps clients find stillness and live with intention. Book a free coaching session at http://susanyounglifecoaching.com, or connect with her on social media:	Nano	Sep 2016	Susan Young Mindful Coaching
https://www.youtube.com/channel/UC2R-lG74F4tNQZSTG0oIgWg/videos	\N	No description	Nano	Apr 2022	Peace & Love: Meditation and Mindfulness
https://www.youtube.com/channel/UCaM5KReAMKezUu31z3PcxKw/videos	\N	Making Mindfulness Accessible With over 30 years of formal Mindfulness training, I bring experience in traditional teachings blended with my social work career of over 25 years in individual and family supports in disability services as well as human rights advocacy work in the disability sector. I did my first 10 day silent meditation retreat in 1985, and have not looked back on this path of continuous practice. I'm a single mom and have loved doing mindfulness work with parents and families to make mindfulness accessible to challenging lives. I've been very lucky to work with a...	Nano	Jun 2018	Sue Hutton Mindfulness
https://www.youtube.com/channel/UCrMnVEusez7op8Nn1PzgKYQ/videos	\N	Alex Strauss is a bestselling author and creator of The Mindful Walker School of Wellbeing, where busy people learn simple, practical ways to harness the healing power of Nature Connection. Slow down, stress less, connect with the Earth, live with intention, and enjoy a more mindful, Earth-conscious life. Get started with free resources at https://www.TheMindfulWalker.com.	Nano	Feb 2015	Alex Strauss - Author & Natural Mindfulness Guide
https://www.youtube.com/channel/UCs0Hk7dGaWW2mJ97gZwqgLA	\N	Breathworks offers a toolkit of knowledge for lifelong use, drawing on the best of mindfulness practice & the founders' personal experience. We also provide specialist programmes for organisations & for health, education & social care professionals wishing to incorporate mindfulness into their work. Our channel both includes interviews & mindfulness technique videos with our founders, associates & teachers. In addition we aim to share the best videos from the international mindfulness community.	Nano	Sep 2010	Breathworks Mindfulness New
https://www.youtube.com/channel/UCQBZpAYfvz8kigDbdqN72Rg/videos	\N	Vanessa Guild is a mindfulness-expert, trainer, speaker, and private coach. She has taught mindfulness meditation workshops for The Dallas Symphony, Morton Meyerson Center employees, SMU, Brookfield Global Asset Management (New York), to inmates within a maximum-security prison in Sydney, Australia.Her private coaching sessions for teenagers, teachers, to CEO's effectively strengthen mental concentration and self-esteem; dramatically decreasing stress.For further information about Vanessa go to: vanessaguild.com.	Nano	Apr 2010	Vanessa Guild - Mindfulness Trainer, Private Coach
https://www.youtube.com/channel/UCrgANrWsHCEEjjut89Vgx8Q/videos	\N	No description	Nano	Apr 2020	Mindfulness With Ms. Guerra
https://www.youtube.com/channel/UCR-d964e8gW0hZt9mxaEQvg	\N	Hi, I'm Melli. I'm a meditation and mindfulness teacher, and I run mindfulness retreats around Australia. She is the leading researchers, teachers and mindfulness experts will be sharing their wisdom, knowledge, tips and tricks about mindfulness.	Nano	May 2013	Mrs Mindfulness
https://www.youtube.com/channel/UCzmIJgRiK5lsVc9JHUn9DCw/videos	\N	Sit down with host, Aimee Morgan, as she delves into the world of mindfulness with doctors, therapists, first responders and other mindfulness thought leaders. Listen as they share their mindfulness practices and help you become better equipped with practical tools to focus your mind and live in the present.	Nano	Oct 2022	Mindfulness Academy
https://www.youtube.com/channel/UCdfQL9wkxnHBi3FEBHdAv7g/videos	\N	Learn about mindfulness. Here you'll find the practices and current science in shore, easy to do, easy to understand videos. Mindfulness is a training of the attention. Your attention is your super power. Learn how to harness it for your benefit. Self reporting studies and neuro-imaging has show that mindfulness improves focus, self compassion, emotional regulation and overall well being. I invite you to enjoy these offerings.	Nano	Aug 2013	Rita Geraghty - Mindful Life Guide
https://www.youtube.com/channel/UCDurv_diN_vwnFxo_3jmsVA/videos	\N	'Mindfulness 360' is aspiring to be your source of inspiration, guidance and support on how to cultivate a mindful mindset in your daily life so to enjoy a more meaningful and fulfilling experience in your social, personal and professional context.	Micro	Jan 2016	Mindfulness 360 - Center For Mindfulness
https://www.youtube.com/channel/UCf-nkEuAif3R1Lt4JKn0igw	\N	No description	Micro	Mar 2009	Quiet Mind Cafe
https://www.youtube.com/channel/UCA8iHe0Hgl4KVvpQ7wNW4LQ/videos	\N	Hi, I'm Olivier, welcome!On my channel, you will find videos to learn meditation and practice mindfulness in your daily life.When I was a student, I used to have many panic attacks to the point I couldn't breathe. Back then, I didn't know about about meditation and I had to go through many difficult moments.In my early thirties I also experience depression.Since learning about mindfulness and meditation and seeing the transformative effect of those practices in my life, I have been dwelling into those practices, attending retreats and teacher trainings. Because I knew I...	Nano	Jul 2018	Peaceful Breathing - Meditation and Mindfulness
https://www.youtube.com/channel/UC48VQRCUvPrzS14N6w5Iadw/videos	\N	Welcome to Elements Meditation & Mindfulness! A community for those in search of mindful relaxation to help quiet the mind.By subscribing to our channel, you will be taking your mind on a journey of exploration, self discovery and deep emotional healing. We know that we are all individuals and what may work for one person, may not work for another.	Micro	Mar 2021	Elements - Meditations & Mindfulness
https://www.youtube.com/channel/UCZ4AJ3yAUMzO-vA2Y-z4grg/videos	\N	Inward Bound Mindfulness Education (iBme) is a non-profit organization dedicated to improving the lives of teens, parents, and professionals. Through mindfulness retreats, iBme helps participants cultivate awareness, compassion, and kindness for themselves, others, and the natural world.We lead mindfulness retreats for teenagers across the country at retreat centers and in wilderness settings. We also provide mindfulness retreats for individual schools and in partnership with other non-profits that work with teens.	Nano	Mar 2014	iBme / Inward Bound Mindfulness Education
https://www.youtube.com/channel/UCsLua7dma2V68-vR0lzp_RQ/videos	\N	The Centre for Mindfulness Studies is an innovative charity and social enterprise in Toronto, Ontario. We offer mindfulness-based therapies and professional training for health care professionals, social service providers, and educators.	Nano	May 2015	The Centre for Mindfulness Studies
https://www.youtube.com/channel/UCC7LrjsxGO24fwYL94vCLPg/videos	\N	No description	Nano	Jan 2021	Mindfulness Meditation by Soothing Pod
https://www.youtube.com/channel/UC7jTgGGhZxMgQ4PBFooytcQ/videos	\N	Hey there! I'm Sierra: a modern witchy woman & mindfulness coach. I'm here to guide soulful women towards a fully embodied life so they can exist from reassurance and ease, rather than struggle and lack.	Nano	Aug 2018	The Local Mystic
https://www.youtube.com/channel/UCVlpglql_LHPn15ANTk04DA/videos	\N	No description	Nano	Nov 2017	Mindfulness Abundance by Dee Gardner
https://www.youtube.com/channel/UCCIZv5c7LAZVuI0v6mJALLw/videos	\N	Welcome to Pandit Dasa's Official YouTube channel. The goal behind this channel is to help humans become more mindful not just at work but in life as a whole as well as stay resilient when difficulties arise.Pandit Dasa is a Mindful Leadership Expert, Keynote Speaker for Fortune 500 companies, Former Monk of 15 years and the Author of 'Urban Monk: Exploring Karma, Consciousness and the Divine'.	Nano	Mar 2016	Pandit Dasa
https://www.youtube.com/channel/UC793KKZqPca0iBZPeQNrw4Q/videos	\N	Established by teachers from amongst the country's most successful schools, Mindfulness in Schools Project (MiSP) aims to improve the lives of children by making a genuine, positive difference to their mental health and wellbeing.With a decade's worth of experience, our charity is the most established provider of mindfulness training and curricula for schools. 350,000 primary and secondary pupils have already benefited from our programme, which helps them to flourish academically, socially and emotionally and we want to reach many more.Schools and other educational settings are...	Nano	Mar 2013	Mindfulness in Schools Project
https://www.youtube.com/channel/UCq8BbJ_KM-_3jATfQAE7ZiQ/videos	\N	The series of guided meditations on the Mindfulness Sanctuary Channel have been designed to help you cultivate greater emotional resilience and well-being. All the meditations have been written and recorded by a psychologist and experienced mindfulness/meditation teacher, to ease you into a state of deep relaxation and peace. The Channel is created by Emma Gray, a coach, meditation teacher, and Clinical Psychologist. Emma combines her knowledge of leading-edge neuroscience with traditional Eastern philosophies in a holistic approach to mind/body healing and wellness. Her passion is to help...	Nano	Jun 2016	Mindfulness Sanctuary
https://www.youtube.com/channel/UC_EAU9IDpKjuQy8LMJQpW0Q/videos	\N	Hello, guest!Welcome to a Mindfulness Base. Here you will find videos with some tips and ideas, which I hope will bring more mindfulness, balance, happiness and flow to your life! I am a certified instructor in MBSR (Mindfulness-based stress reduction), a PhD, a meditator and a cat-lady. I will be sharing my passion for mindfulness practice, mindful living, making meditation sweet and potent, and of course, for cats. Stay tuned!Maria Sharapan, CFM (R)a Mindfulness Base	Nano	Jun 2020	a Mindfulness Base
\.


--
-- Data for Name: youtubers; Type: TABLE DATA; Schema: public; Owner: kevinazrazzz
--

COPY public.youtubers (youtuber_name, gender, email, youtube_subscribers, facebook_followers, instagram_followers, type) FROM stdin;
Bari Koral	Female	****@gmail.com	707000	3400	6300	Macro
Sara & Les	\N	****@gmail.com	959000	12300	\N	Macro
Anthony Paul Moo-Young	Male	****@mooji.org	835000	460600	477800	Macro
Tara Brach	Female	****@tarabrach.com	339000	373300	289200	Macro
Christian Thomas	Male	****@gmail.com	409000	1200	434	Macro
Chibs Okereke	Male	****@chibs.co	94000	\N	8000	Micro
Sean Fargo	Male	****@mindfulnessexercises.com	121000	\N	102300	Macro
Mindful Music	\N	****@gmail.com	136000	975	\N	Macro
Holly Morris	Female	****@thementalhealthteacher.com	110000	\N	\N	Macro
Palouse Mindfulness	\N	****@palousemindfulness.com	50800	4400	\N	Micro
Jamie Marich	Female	****@mindfulohio.com	20100	10800	\N	Micro
Voicu Mihnea Simandan	Male	****@yahoo.com	12600	\N	486	Micro
Scott Todnem	Male	\N	5900	1300	10800	Nano
Loch Kelly	Male	****@lochkelly.org	16200	\N	7600	Micro
Shamash Alidina	Male	****@shamashalidina.com	2900	13600	2900	Nano
Cynthia Hauk	Female	****@mindfulcreativemuse.com	12900	1200	4500	Micro
Kelly Smith	Female	****@yogaforyouonline.com	5300	1300	\N	Nano
Cory Muscara	Male	****@limindfulness.com	17000	36300	1100000	Micro
Melli O'brien	Female	****@mrsmindfulness.com	5400	63400	13100	Nano
Gui Hung	Male	****@mindfulnews.uk	3600	\N	1700	Nano
Sarah McLean	Female	****@mcleanmeditation.com	4600	11800	\N	Nano
Rocky Heron	Male	****@rockyheron.com	3800	21100	53400	Nano
Jessie Mahoney	Female	****@jessiemahoneymd.com	2900	\N	\N	Nano
Oren Jay Sofer	Male	****@orenjaysofer.com	6100	\N	14500	Nano
Nicole E. Anderson	Female	****@neamusic.com	2900	215	\N	Nano
Missy	Female	****@the-life-helper.com	2800	169	\N	Nano
Anthony Ongaro	Male	****@gmail.com	67300	20400	2600	Micro
Shilpi Mahajan	Female	****@fablefy.com	28200	846	\N	Micro
John Davisi	Male	\N	12600	\N	4500	Micro
Ellen	Female	****@gmail.com	8600	\N	\N	Nano
Mindfulness Place	\N	****@mindfulness-place.com	3500	\N	\N	Nano
Ron Levine	Male	****@mindfulnessinbluejeans.com	3000	911	\N	Nano
MeditationRelaxClub - Sleep Music & Mindfulness	\N	****@meditationrelaxclub.com	1700000	\N	\N	Mega
Headspace	\N	****@headspace.com	779000	800400	\N	Macro
Brain Education TV	\N	****@gmail.com	406000	2900	6700	Macro
Be Here Now Network	\N	****@beherenownetwork.com	208000	42600	\N	Macro
MindfulPeace	\N	****@mindfulpeacejourney.com	235000	8100	\N	Macro
Wisdom 2.0	\N	****@wisdom2conference.com	152000	56900	\N	Macro
My Peace Of Mindfulness	\N	****@mypeaceofmindfulness.com	116000	\N	\N	Macro
Declutter The Mind	\N	****@declutterthemind.com	163000	9100	2400	Macro
Mindful Muslimah	\N	\N	29100	\N	\N	Micro
Insight Meditation Center	\N	****@gmail.com	26400	17500	\N	Micro
Mindful Wing Chun	\N	****@mindfulwingchun.com.hk	27300	30000	\N	Micro
Mindful Mama Mentor	\N	****@mindfulmamamentor.com	3500	\N	\N	Nano
Mindful	\N	****@mindful.org	12400	\N	\N	Micro
Master Niels	\N	****@innermindinstitute.org	55000	\N	\N	Micro
Metta Mindfulness Music	\N	****@mettamindfulnessmusic.com	3900	\N	\N	Nano
Julia Delaney | Positive Pranic	\N	****@gmail.com	8500	1100	1100	Nano
Common Ground Meditation Center	\N	****@commongroundmeditation.org	3800	3800	\N	Nano
Mindfulness with Mariel	\N	****@gmail.com	494	\N	\N	Nano
RoundGlass	\N	****@round.glass	4800	\N	\N	Nano
Mindfulness Association	\N	****@mindfulnessassociation.net	3200	\N	\N	Nano
The Men Talking Mindfulness Podcast	\N	****@mentalkingmindfulness.com	7200	\N	\N	Nano
Meditate with Deb	\N	****@peacefulwellness.org	1000	706	581	Nano
Breathworks Mindfulness	\N	****@breathworks.co.uk	5500	\N	\N	Nano
Monash Mindfulness	\N	****@monash.edu	8800	\N	\N	Nano
Center for Mindful Self-Compassion	\N	****@centerformsc.org	10100	29300	\N	Micro
Dr. Mindfulness	\N	****@carleton.ca	3600	301	\N	Nano
Meditate: School of Mindfulness	\N	****@gmail.com	1900	\N	\N	Nano
Omni Mindfulness	\N	****@gmail.com	125	\N	\N	Nano
Mindfulness With Aly F Canavan	\N	****@alisoncanavan.com	1700	\N	\N	Nano
Mindful Life Coaching with Dr. Jessie Mahoney	\N	****@jessiemahoneymd.com	579	\N	1700	Nano
Connected Kids - teach kids meditation	\N	****@teachchildrenmeditation.com	874	740	1000	Nano
Gayane Kulikyan - Mindfulness & Healing	\N	****@concordinlove.com	480	344	385	Nano
Brittany Lynne | Beautifully Awakening	\N	\N	1000	\N	\N	Nano
A Lust For Life	\N	****@alustforlife.com	1200	39200	\N	Nano
Creative Mindfulness	\N	****@louiseshanagher.com	1300	\N	\N	Nano
Mindful Meditation with Storytime Family	\N	****@gmail.com	1700	\N	\N	Nano
Make Mind Spiritual	\N	\N	693	\N	\N	Nano
A Mindful Approach to Fitness	\N	****@gmail.com	630	\N	\N	Nano
Meditation Mindfulness	\N	****@alanspicer.com	1500	\N	\N	Nano
Mindfulness Project	\N	****@mindfulness-project.org	1400	\N	\N	Nano
Christy Jones Health and Mindfulness Coach	\N	****@gmail.com	432	\N	\N	Nano
Practice With Lydia Zamorano	\N	****@gmail.com	1500	\N	14600	Nano
Samavira Meditation and Mindfulness	\N	****@samavira.com	441	\N	\N	Nano
Mark Coleman	\N	****@markcoleman.org	1100	2000	3400	Nano
Padraig O'Morain Mindfulness	\N	****@gmx.com	809	10600	3300	Nano
Susan Young Mindful Coaching	\N	****@susancoach.ca	182	265	646	Nano
Peace & Love: Meditation and Mindfulness	\N	****@gmail.com	466	\N	\N	Nano
Sue Hutton Mindfulness	\N	****@gmail.com	433	\N	\N	Nano
Alex Strauss - Author & Natural Mindfulness Guide	\N	****@themindfulwalker.com	334	\N	\N	Nano
Breathworks Mindfulness New	\N	****@breathworks.co.uk	\N	19400	\N	Nano
Vanessa Guild - Mindfulness Trainer, Private Coach	\N	****@vanessaguild.com	153	\N	\N	Nano
Mindfulness With Ms. Guerra	\N	\N	160	\N	\N	Nano
Mrs Mindfulness	\N	****@mrsmindful.co.uk	\N	1	\N	Nano
Mindfulness Academy	\N	****@aimeemorgan.com	52	\N	\N	Nano
Rita Geraghty - Mindful Life Guide	\N	\N	22	\N	\N	Nano
Mindfulness 360 - Center For Mindfulness	\N	****@mindfulness360.net	35900	4300	\N	Micro
Quiet Mind Cafe	\N	****@gmail.com	12800	\N	\N	Micro
Peaceful Breathing - Meditation and Mindfulness	\N	****@gmail.com	7800	\N	\N	Nano
Elements - Meditations & Mindfulness	\N	****@mail.com	10900	92	843	Micro
iBme / Inward Bound Mindfulness Education	\N	****@ibme.com	1900	9400	3100	Nano
The Centre for Mindfulness Studies	\N	****@mindfulnessstudies.com	1800	\N	\N	Nano
Mindfulness Meditation by Soothing Pod	\N	****@gmail.com	2900	\N	\N	Nano
The Local Mystic	\N	****@gmail.com	2000	\N	4900	Nano
Mindfulness Abundance by Dee Gardner	\N	****@thecounselingservices.com	1300	\N	\N	Nano
Pandit Dasa	\N	****@gmail.com	1200	2000	148500	Nano
Mindfulness in Schools Project	\N	****@mindfulnessinschools.org	667	\N	\N	Nano
Mindfulness Sanctuary	\N	****@emmagray.net	389	101	192	Nano
a Mindfulness Base	\N	****@gmail.com	353	204	\N	Nano
\.


--
-- Name: Dim_Channel Dim_Channel_pkey; Type: CONSTRAINT; Schema: public; Owner: kevinazrazzz
--

ALTER TABLE ONLY public."Dim_Channel"
    ADD CONSTRAINT "Dim_Channel_pkey" PRIMARY KEY (youtube_channel_link);


--
-- Name: Dim_Youtuber Dim_Youtuber_pkey; Type: CONSTRAINT; Schema: public; Owner: kevinazrazzz
--

ALTER TABLE ONLY public."Dim_Youtuber"
    ADD CONSTRAINT "Dim_Youtuber_pkey" PRIMARY KEY (youtuber_name);


--
-- Name: channels channels_pkey; Type: CONSTRAINT; Schema: public; Owner: kevinazrazzz
--

ALTER TABLE ONLY public.channels
    ADD CONSTRAINT channels_pkey PRIMARY KEY (youtube_channel_link);


--
-- Name: youtubers youtubers_pkey; Type: CONSTRAINT; Schema: public; Owner: kevinazrazzz
--

ALTER TABLE ONLY public.youtubers
    ADD CONSTRAINT youtubers_pkey PRIMARY KEY (youtuber_name);


--
-- Name: youtubers check_followers_before_insert_update; Type: TRIGGER; Schema: public; Owner: kevinazrazzz
--

CREATE TRIGGER check_followers_before_insert_update BEFORE INSERT OR UPDATE ON public.youtubers FOR EACH ROW EXECUTE FUNCTION public.ensure_positive_followers();


--
-- Name: Fact_Top_Channels Fact_Top_Channels_youtube_channel_link_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kevinazrazzz
--

ALTER TABLE ONLY public."Fact_Top_Channels"
    ADD CONSTRAINT "Fact_Top_Channels_youtube_channel_link_fkey" FOREIGN KEY (youtube_channel_link) REFERENCES public."Dim_Channel"(youtube_channel_link);


--
-- Name: Fact_Top_Channels Fact_Top_Channels_youtuber_name_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kevinazrazzz
--

ALTER TABLE ONLY public."Fact_Top_Channels"
    ADD CONSTRAINT "Fact_Top_Channels_youtuber_name_fkey" FOREIGN KEY (youtuber_name) REFERENCES public."Dim_Youtuber"(youtuber_name);


--
-- Name: channels fk_youtuber_name; Type: FK CONSTRAINT; Schema: public; Owner: kevinazrazzz
--

ALTER TABLE ONLY public.channels
    ADD CONSTRAINT fk_youtuber_name FOREIGN KEY (youtuber_name) REFERENCES public.youtubers(youtuber_name) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

