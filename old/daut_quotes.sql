--
-- PostgreSQL database dump
--

-- Dumped from database version 12.17
-- Dumped by pg_dump version 14.11 (Homebrew)

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: counters; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.counters (
    name character varying NOT NULL,
    current_count integer NOT NULL,
    channel text NOT NULL,
    added_by text NOT NULL,
    added_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.migrations (
    installed_rank integer NOT NULL,
    version character varying(50),
    description character varying(200) NOT NULL,
    type character varying(20) NOT NULL,
    script character varying(1000) NOT NULL,
    checksum integer,
    installed_by character varying(100) NOT NULL,
    installed_on timestamp without time zone DEFAULT now() NOT NULL,
    execution_time integer NOT NULL,
    success boolean NOT NULL
);


--
-- Name: quotes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.quotes (
    text character varying NOT NULL,
    qid bigint NOT NULL,
    added_by character varying NOT NULL,
    channel text NOT NULL,
    added_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted boolean DEFAULT false NOT NULL,
    deleted_by text,
    deleted_at timestamp with time zone
);


--
-- Name: scores; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.scores (
    channel text NOT NULL,
    player1 character varying,
    player2 character varying,
    player1_score integer NOT NULL,
    player2_score integer NOT NULL
);


--
-- Name: streams; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.streams (
    name character varying NOT NULL,
    joined boolean DEFAULT false NOT NULL,
    added_by text DEFAULT 'trollabot'::text NOT NULL,
    added_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: user_commands; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_commands (
    name character varying NOT NULL,
    body text NOT NULL,
    channel text NOT NULL,
    added_by text NOT NULL,
    added_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Data for Name: counters; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.counters (name, current_count, channel, added_by, added_at) FROM stdin;
vaat	69	daut	artofthetroll	2022-07-17 21:30:08.584868+00
yikes	177	daut	artofthetroll	2022-07-17 23:04:17.584912+00
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.migrations (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) FROM stdin;
1	1	<< Flyway Baseline >>	BASELINE	<< Flyway Baseline >>	\N	null	2022-07-17 16:57:21.398113	0	t
2	0010	InitDb	SQL	V0010__InitDb.sql	1750059468	postgres	2022-07-17 16:57:21.880829	227	t
3	0011	MigrateStreamsAndQuotes	SQL	V0011__MigrateStreamsAndQuotes.sql	2035973121	postgres	2022-07-17 16:57:21.880829	120	t
4	0012	AddCoutersScoresAndUserCommands	SQL	V0012__AddCoutersScoresAndUserCommands.sql	1004887990	postgres	2022-07-17 16:57:21.880829	27	t
5	0013	JoinArtOfTheTroll	SQL	V0013__JoinArtOfTheTroll.sql	-821162157	postgres	2022-07-17 17:09:10.226148	8	t
\.


--
-- Data for Name: quotes; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.quotes (text, qid, added_by, channel, added_at, deleted, deleted_by, deleted_at) FROM stdin;
Kids are amazing. They don't judge. They don't ask how it was in the red bull. No disappointment.	2529	harooooo1	daut	2022-11-03 19:07:41.096855+00	f	\N	\N
monk is always a monk	2561	zekleinhammer	daut	2023-08-06 14:55:59.384157+00	f	\N	\N
Score is just a number	2600	batbeetch	daut	2023-11-09 02:47:14.348437+00	f	\N	\N
close us man!	43	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I don't know what happened but let's call that a win	2505	hyunaop	daut	2022-07-17 22:26:54.057296+00	f	\N	\N
accm touched my belly every time we met…and I like that!	2530	zekleinhammer	daut	2022-11-03 20:49:27.010011+00	f	\N	\N
ACCM talking about taking coaching from Daut: "i want to learn to push the deer"	2562	botcanarrow	daut	2023-08-06 15:39:56.548168+00	f	\N	\N
I swear my villagers are the dumbest things in the universe. There is MBL and then there are my villagers	2601	botcanarrow	daut	2023-11-09 03:10:52.736814+00	f	\N	\N
(daut to ele archers) those are always missing. but when they hit they do nothing	2506	hyunaop	daut	2022-07-17 22:28:51.27632+00	f	\N	\N
I might stream once a month but at least when I stream it is super short	2531	zekleinhammer	daut	2022-11-03 22:21:56.779626+00	f	\N	\N
"Whole Yo base is like the New Year. Everything is flashing"	2563	botcanarrow	daut	2023-08-07 14:56:44.273768+00	f	\N	\N
ok AutoScout you did amazing, I think that’s why I’m top score	2602	batbeetch	daut	2023-11-09 03:13:28.196802+00	f	\N	\N
(Daut using elephant archers) fart on him man or something	2507	hyunaop	daut	2022-07-17 22:35:09.746767+00	f	\N	\N
actually the art of troll was correct	2532	zekleinhammer	daut	2022-11-04 22:29:21.108423+00	f	\N	\N
wait im not top score? didnt' i already win this game?	2564	artofthetroll	daut	2023-08-18 15:49:57.375091+00	f	\N	\N
Hera: so if id taken notes from you i wouldve lost to mr yo after a clean 3 - 0. Thank God my set was earlier.	2603	botcanarrow	daut	2023-11-09 03:28:46.06643+00	f	\N	\N
the only good thing about this game is it couldn’t be any worse than this	2508	zekleinhammer	daut	2022-08-02 11:49:54.051627+00	f	\N	\N
I think the limit is 3...I will go for four	2533	zekleinhammer	daut	2022-11-12 02:24:09.325706+00	f	\N	\N
I am two times a day kind of guy	2565	zekleinhammer	daut	2023-08-18 22:28:13.032773+00	f	\N	\N
Imagine pushing deer for your income. I would not recommend it for my son.	2604	botcanarrow	daut	2023-11-09 03:51:12.15142+00	f	\N	\N
where are you going membrillos?	2509	synapse16	daut	2022-08-02 16:00:12.845437+00	f	\N	\N
when I start clowning, I clown til the end	2534	zekleinhammer	daut	2022-11-13 01:40:53.819393+00	f	\N	\N
I learned not to take things seriously…that is why I will tower rush the shit out of him this game	2566	zekleinhammer	daut	2023-08-18 22:28:41.116749+00	f	\N	\N
Carbo is a professional football player? He is definitely kicking me around here.	2605	botcanarrow	daut	2023-11-09 03:55:15.279697+00	f	\N	\N
I want Saracens to have market in dark age	2510	zekleinhammer	daut	2022-08-03 12:32:03.207128+00	f	\N	\N
I cannot even quickwall the afk player	2535	zekleinhammer	daut	2022-12-07 18:54:54.557913+00	f	\N	\N
my storage pit is disaster pit	2567	zekleinhammer	daut	2023-08-19 15:23:13.977213+00	f	\N	\N
damn i love mule… I love mule	2606	zekleinhammer	daut	2023-11-11 01:52:10.87465+00	f	\N	\N
he was afk for like 5 minutes and I was making countertowers and shit!	2511	zekleinhammer	daut	2022-08-14 13:11:52.304699+00	f	\N	\N
bad things happen when you are my flank	2536	zekleinhammer	daut	2022-12-09 00:07:55.836347+00	f	\N	\N
if viper is not going slingers, I am not going slingers either	2568	zekleinhammer	daut	2023-08-20 23:16:09.330103+00	f	\N	\N
Ah come on! 1 food, give me credit I will pay!	2607	batbeetch	daut	2023-12-18 16:49:53.440813+00	f	\N	\N
I think my apm is highest when I am luring the deer and pushing the boar at the same time	2512	zekleinhammer	daut	2022-08-15 22:10:21.872503+00	f	\N	\N
I gave him a good spank	2537	zekleinhammer	daut	2022-12-29 14:21:21.461127+00	f	\N	\N
now it is ok to fuck?	2569	zekleinhammer	daut	2023-08-29 01:02:11.318578+00	f	\N	\N
"I am getting touched!" (Tatoh: "don't get touched")	2608	artofthetroll	daut	2023-12-18 16:50:06.725694+00	f	\N	\N
make kids! Simple! Start booming!	2513	zekleinhammer	daut	2022-08-15 23:17:52.591965+00	f	\N	\N
my ass is fun	2538	zekleinhammer	daut	2022-12-29 15:06:08.168743+00	f	\N	\N
every month I switch day and night	2570	zekleinhammer	daut	2023-08-31 21:42:34.803856+00	f	\N	\N
"Trollerboi, will you come to NAC? No need to explain, I don't care that much"	2609	botcanarrow	daut	2023-12-18 16:53:27.872497+00	f	\N	\N
I am just fully open on this map? -DauT playing arena	2514	zekleinhammer	daut	2022-08-16 00:00:39.393381+00	f	\N	\N
damn my fast apm	2539	zekleinhammer	daut	2023-01-05 00:51:48.192042+00	f	\N	\N
if day was 26 hours I would have perfect sleep schedule, maybe because I don’t use enough energy during the day…	2571	zekleinhammer	daut	2023-08-31 21:43:32.526913+00	f	\N	\N
I love mules	2610	zekleinhammer	daut	2023-12-18 17:15:07.262571+00	f	\N	\N
never touch if it works man	2515	hyunaop	daut	2022-08-16 00:05:22.133459+00	f	\N	\N
"Look at this! Actually... don't look."	2540	artofthetroll	daut	2023-01-09 23:38:46.893073+00	f	\N	\N
eventually that one castle will give me enough stone	2572	zekleinhammer	daut	2023-08-31 22:42:38.759545+00	f	\N	\N
"Oops, I was scratching my nose honestly."	2611	botcanarrow	daut	2023-12-24 14:48:08.837345+00	f	\N	\N
market! you betrayed me!	2516	zekleinhammer	daut	2022-08-23 01:25:45.942007+00	f	\N	\N
"1hp, still kicking ass!"	2541	artofthetroll	daut	2023-01-09 23:39:58.002225+00	f	\N	\N
I don’t like when they go for my face	2573	zekleinhammer	daut	2023-08-31 22:43:59.074508+00	f	\N	\N
you want some music? there is no music	2612	zekleinhammer	daut	2023-12-29 13:22:23.071987+00	f	\N	\N
Let's go! units are supposed to die, right?	2517	zekleinhammer	daut	2022-08-23 01:31:09.73041+00	f	\N	\N
Okay I micro'd to my limits. They're not that high.	2542	sharkfin_aoe	daut	2023-01-16 11:39:09.590627+00	f	\N	\N
we are getting the god damn faith	2574	zekleinhammer	daut	2023-08-31 23:18:41.840084+00	f	\N	\N
market, you betrayed me for the first time in my life!	2613	zekleinhammer	daut	2023-12-29 14:49:04.597224+00	f	\N	\N
I don't enjoy being bammed. DauT losing Sicilian cav to Arambai.	2518	synapse16	daut	2022-08-23 01:46:13.528367+00	f	\N	\N
we plan to abuse that hole to maximum potential	2543	zekleinhammer	daut	2023-01-30 01:23:16.331715+00	f	\N	\N
"What is the purpose of life? make Coustillier"	2575	batbeetch	daut	2023-08-31 23:33:05.769035+00	f	\N	\N
wall is wall! ... and hole is hole	2614	zekleinhammer	daut	2023-12-29 15:46:02.280643+00	f	\N	\N
we are adding one more D to the chess	2519	zekleinhammer	daut	2022-08-23 02:32:47.177278+00	f	\N	\N
So whats up guys, we wait til my kids get old enough to play or what? -DauT at showmatch vs aM	2544	batbeetch	daut	2023-02-04 16:31:40.376071+00	f	\N	\N
if they nerf market I’m casting	2576	zekleinhammer	daut	2023-09-01 00:05:14.572127+00	f	\N	\N
Damn market is good... you just bam bam bam, bam bam, and you go up	2615	botcanarrow	daut	2024-01-23 06:13:52.873034+00	f	\N	\N
make market castle age building? Well then how do you get to castle age?	2520	zekleinhammer	daut	2022-08-29 02:15:30.407603+00	f	\N	\N
can you squeeze in your fa… don’t want to be rude	2545	zekleinhammer	daut	2023-02-09 01:40:36.43868+00	f	\N	\N
so I don’t need more TCs, then again I want more TCs…I will get more TCs	2577	zekleinhammer	daut	2023-09-03 02:31:45.512085+00	f	\N	\N
If youpudding does it, I can do it as well.	2616	botcanarrow	daut	2024-01-26 10:09:27.750138+00	f	\N	\N
I cannot resist good ole villager pounding	2521	zekleinhammer	daut	2022-08-29 02:58:48.443379+00	f	\N	\N
I don’t want to see monks in my life anymore. When I go out on street and I see an old guy I willl start screaming	2546	zekleinhammer	daut	2023-02-09 03:32:17.58192+00	f	\N	\N
¡Hola Guapo!	2578	zekleinhammer	daut	2023-09-03 15:48:14.161942+00	f	\N	\N
there will be poems written about this boom	2617	zekleinhammer	daut	2024-01-30 14:25:58.458255+00	f	\N	\N
once I saw 2 tcs was the meta in aoe4, I said, that’s my game	2522	zekleinhammer	daut	2022-09-02 02:58:50.417042+00	f	\N	\N
maybe I can be happy and go back…I’m never happy, I never go back	2547	zekleinhammer	daut	2023-03-12 23:58:55.124568+00	f	\N	\N
I will win both aoe1 and aoe2 tournament in the same fucking weekend!	2579	zekleinhammer	daut	2023-09-04 15:53:36.196237+00	f	\N	\N
He is really keeping me safe. I need to return the favour by booming like no one has ever before.	2618	botcanarrow	daut	2024-01-30 14:26:01.259056+00	f	\N	\N
Hoang is economy player	2523	zekleinhammer	daut	2022-09-27 02:53:54.425372+00	f	\N	\N
Mangonel is stupidest unit in game, at least when I'm controlling it	2548	hyunaop	daut	2023-03-15 01:10:58.817726+00	f	\N	\N
Yo needs to suffer	2580	zekleinhammer	daut	2023-09-04 17:44:13.414542+00	f	\N	\N
Clicking up without market doesn’t feel right	2619	batbeetch	daut	2024-02-05 10:16:43.050555+00	f	\N	\N
What's happening there.. oh that's me - not me! dautPickle	2524	deagle2511	daut	2022-10-02 13:30:06.009585+00	f	\N	\N
I have quite a few expensive dead units on the way here	2549	zekleinhammer	daut	2023-03-17 00:48:36.815924+00	f	\N	\N
"I was playing for content why didn't they chill!"	2581	batbeetch	daut	2023-09-08 19:06:13.783126+00	f	\N	\N
No reason to take this fight… but I really wanna take it	2620	batbeetch	daut	2024-02-05 10:45:51.66725+00	f	\N	\N
Everything is fine except my allies.	2525	artofthetroll	daut	2022-10-02 13:58:37.019377+00	f	\N	\N
can I do a light douche?	2550	zekleinhammer	daut	2023-03-17 00:54:15.388759+00	f	\N	\N
daut to artofthetroll: sling some resources, you greedy fuck!	2582	zekleinhammer	daut	2023-09-11 23:28:17.777887+00	f	\N	\N
my guy is fine…(sees 15 knights in his base)…fine-ish	2621	zekleinhammer	daut	2024-02-10 14:38:54.212683+00	f	\N	\N
Now he will make spears, normal people would make archers to counter, like Nili. i will make knights.	2526	harooooo1	daut	2022-10-02 14:57:14.433283+00	f	\N	\N
whatever I give him, he smokes	2551	zekleinhammer	daut	2023-03-27 21:10:52.913276+00	f	\N	\N
let’s steal a deer… that’s idea I will probably give up quickly	2583	zekleinhammer	daut	2023-09-11 23:43:30.520854+00	f	\N	\N
Problem is when you play with JonSlow, you don't know if it's pathfinging, or is him	2622	batbeetch	daut	2024-02-18 20:24:52.543005+00	f	\N	\N
Walls are part of the game. Let's use that part of the game.	2527	harooooo1	daut	2022-10-02 14:57:48.254411+00	f	\N	\N
I used to play like that before you were born	2552	zekleinhammer	daut	2023-03-27 22:24:40.089171+00	f	\N	\N
can sell a little bit of everything… when I say a little bit, I mean a lot	2584	zekleinhammer	daut	2023-09-11 23:51:13.875127+00	f	\N	\N
normally you hide stables…I’m coming for you madafaka…react to that!	2623	zekleinhammer	daut	2024-02-24 18:19:29.541128+00	f	\N	\N
they are going full por favor on me now.	2528	synapse16	daut	2022-10-04 15:37:20.505591+00	f	\N	\N
I have a huge ass hole here	2553	zekleinhammer	daut	2023-03-27 23:36:50.130092+00	f	\N	\N
this is a throwaway army… let’s throw it away	2585	zekleinhammer	daut	2023-09-12 00:00:26.938643+00	f	\N	\N
no, no, that’s too stupid even for my level	2624	zekleinhammer	daut	2024-02-24 18:30:18.237591+00	f	\N	\N
trade with nothing you motherfucker	2554	zekleinhammer	daut	2023-06-22 11:19:00.201187+00	f	\N	\N
typing that was way more important than pushing deers	2586	zekleinhammer	daut	2023-09-14 00:15:21.766691+00	f	\N	\N
DauT on ACCM: I know that smiley fuck would never cheat on me!	2555	byelo	daut	2023-06-26 13:16:46.435573+00	f	\N	\N
outpost my ass	2587	zekleinhammer	daut	2023-09-22 16:43:01.681962+00	f	\N	\N
please let me boom you	2556	hyunaop	daut	2023-06-26 15:31:57.929171+00	f	\N	\N
Dogao with the longest name ever. Makes me want to resign. We will play without the score.	2588	botcanarrow	daut	2023-10-04 16:49:36.173727+00	f	\N	\N
no free vision for you man, damn I sound like Nili right now	2557	hyunaop	daut	2023-06-26 15:45:29.070636+00	f	\N	\N
Doesnt he know the rules of the game? everything goes to me!	2589	batbeetch	daut	2023-10-05 15:05:19.094506+00	f	\N	\N
I have sword sharpness problems	2558	zekleinhammer	daut	2023-07-09 23:07:20.817054+00	f	\N	\N
wall that mothafucker	2590	batbeetch	daut	2023-10-05 15:32:36.218404+00	f	\N	\N
heh! late pusher	2559	zekleinhammer	daut	2023-07-09 23:38:15.591815+00	f	\N	\N
the moral of the story is, never attack	2591	zekleinhammer	daut	2023-10-11 13:52:43.570714+00	f	\N	\N
I don't know how to quickwall, but I know how to brain.	2560	artofthetroll	daut	2023-07-11 17:51:33.657019+00	f	\N	\N
Daut after not being able to click up after using the Market - ‘Now it sucks to do it the normal way with farms - Do I look like a Farmer to you?'	2592	batbeetch	daut	2023-10-11 15:54:15.44508+00	f	\N	\N
why can’t I attack this? Oh because it’s my castle	2593	zekleinhammer	daut	2023-10-12 21:21:43.65215+00	f	\N	\N
Do I ever make mistake?	2139	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Next!	2594	zekleinhammer	daut	2023-10-12 21:21:50.249295+00	f	\N	\N
Can I castle drop myself?	2595	batbeetch	daut	2023-10-13 18:38:45.295373+00	f	\N	\N
don't cheat man! That was a test!	2289	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
casting "a range, without villager on gold" -looks at other player- "a range, without villager on gold... It's MBL mirror!"	2596	batbeetch	daut	2023-10-27 19:09:05.334977+00	f	\N	\N
sorry I dont know pokemon	2350	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I will add fortified church and think really hard about my life.	2597	botcanarrow	daut	2023-11-02 03:25:33.212614+00	f	\N	\N
orgazing	2471	batbeetch	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
the things I do for 5 dollars	2598	zekleinhammer	daut	2023-11-02 03:47:59.870333+00	f	\N	\N
such a loomie fucker	585	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Hera: "I will study math and education." Daut: "Waaat, but you suck at both! I guess that's why you study..."	588	byelo	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
go back to Egypt man!	589	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Ohhhh! that's what you get you walling fuck	598	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"They are standing, but they are coming."	26	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"what happened man we once had beautiful army and now it's gone"	27	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"if I transition now, Jordi will say I told you so, can't have that man"	28	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I miss my secret boys	29	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
daut who would win in a bo3 bean or smarthy? ... how the fuck should i know man?	30	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
every girl wants to go where daut go	31	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"I'm not Liereyy, I'm not losing my age." Daut on his 33rd Birthday	32	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
you're going down little man!	33	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I kinda promised girlfriend I would spend the night with her, screw that, bushnite man! dautBush	34	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
i need to spend time with my girlfriend, she still thinks im playing tournament man! dautWat	35	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
i'm proper Lara Croft now dautWat	36	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"Long time no see my son" DauT coz he is sleeping all day	37	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Usually when i travel i tend to come back with much less bags	38	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I deserve to be trolled	39	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
come to my healing spot man!	40	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
hope u lost villager	41	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
You are proper Jordan Tati	42	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"Don't let my castle be DauT!"	44	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
They place me above you. So they place me correct	45	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
ok guys! keep making fun of viper while i go eat	118	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
It's hard to play Viper cuz he always make stupid moves, so you think he's stupid. But sometimes he have a plan	46	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"if only AoC was turn based like chess"	47	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
do i think viper is gay? well that's now a proper question	48	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I know shisha is bad for health, but i dont plan to live forever.	49	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"if your girlfriend is cheating on you go for man at arms"	50	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
talk with viper for 24hs that's a dream	51	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Tomorrow! tomorrow i will practice 1v1s all day	52	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm a fast fucker	53	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
tell me viper, how does it feels to cast my games every weekend?	54	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Ppl with more than 1 kid desirve so much respect	55	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
56 doesnt deserve a quote	56	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Art of troll is really good at what he's doing	57	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
shit goes wrong when i'm not there	58	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Who can hate me?	59	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
my luring skills are good, i should be fine	60	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Viper is full gossip girl of aoc	61	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
U live in snow viper. only thing u can do is sit and play	62	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
when u have lead you fantasy play	63	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
xD	64	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Samurai counter Cav Archers that makes no sense man!	65	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
If u get a boy in the first try. why keep trying?	66	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Time goes faster when u sleep all day	67	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
BAM! ... BAAAM!! ... come on i said BAM! there u go	68	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"It's a rainbow day here! KappaPride It's like I'm playing against 10 players here"	69	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"I'm not 2k anymore, man!" - DauT 2018	70	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
ok ok i'm dedicated to kill this deer	71	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
i will still find a way to lose this villager	72	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
never be nice man never be nice.	73	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
every gold in the map is my gold	74	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
sacrifice nicov is like main strategy for every player	75	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
The wolf is outmicroing me	76	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"You are such a nicov" DauT to Tati cuz he fast gg after one attack	77	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"I show up for events... sooner or later" - DauT NAC1 2018	78	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
NIli said "u guys can drink all this beer that i bought?" and i was like FUCK YEAH!!!	79	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
if u wanna learn how to micro watch my stream. if u wanna learn macro watch Edie	80	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
imagine they using our strategy and getting destroyed in ecl	81	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
You are jealous of people with hair viper	82	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Ok ok. just sit there and don't die	83	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
ok Memb i will do what you are saying because your are older than me and i respect you	84	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Tati u are the king of the migration and the king of the sling	85	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
my girl give me food man yours not	86	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I am bored, I go die	602	goldeneye_	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
you can put the sheep inside of the cow	608	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
he is converting my kills	759	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
every team with me as a pocket is a strong team	786	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
i was bussy complaining and crying instead of thinking	586	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Viper you are the worst team waller	590	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Man you are worse than Jordan	599	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Attack ground should be removed from this game	87	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Tati is nice guy.. Only I can make him mad dautKing	88	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
i should go take my family. but my gf is not answering so... Let's play one more!	89	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I can't be new Viper! i was Viper before Viper	90	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
That moment when you realize Viper is the longest sub you got. You ask to yourself what the fuck are you doing with your life	91	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
more mods i have, less stuff i have to do	92	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I like to mod people dautWat	93	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"I don't like to micro to be honest"	94	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'll go inside next time man	95	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
This hill I like... I take!	96	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
get converted fucker!	97	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
i always try hard	98	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I only killed spearmen man!	99	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Can you come to my tc?	100	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Can you tell me what you're doing, cause I don't have scout	101	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
it's like I like to be stupid man!	102	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
oh fuck sake, you and your fricking timing man.	103	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
you have a problem, just make a gate.	104	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"What tati? u can't go sleep! we are doing bushnite after this! grassDaut " DauT to Tatoh during bo37	105	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
time to reboom	106	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
What are you eating? Thats cheating	107	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
screw u fire. now i want bact to qualify	108	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
fuck this! i'm throwing now!	109	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
i'm super professional compared to fire	110	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I love my sleep schedule when its fucked	111	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"hope u don't qualify to kotd" Daut to mbl after losing 2 vills in dark age to mbl scout	112	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I will make nicov drunk and he will do secret things	113	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
who boosted me to 2k? 20 years of experience man	114	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
When your main army is 5 spearmen, you know you are fucked	115	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Report? report who? i report u now dautWat	116	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"how is his hill bigger than mine!"	117	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Viper: "Daut? why u stream so early?" / Daut: "Because i'm fresh. I'm always fresh"	119	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
“I love F1re, he is my favorite player”	120	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
if fire is coming i will come as well. I need to troll him	121	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
And me... I'm looking promising as well	122	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"Oh I have vils! What is the purpose of villagers?" - DauT 2018	123	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I will make Tati quit aoc again	124	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
All i want for christmas is extra gold dautWat	125	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Oh i'm host. was wondering why the game wasn't starting	126	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
That kinda fucks my aggression	127	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Hello miguel, happy birthday, u have your best birthday present! Fire losing	128	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"If i was Fire i will kill my self" daut casting Bact Vs Fire	129	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
We need to gather money for an elevator for nili's building	130	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
mbl playstyle can create serial killers	131	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Viper must be laughing at us like "Ha ha ha kiss me honey"	132	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
oh man i royally fucked up	133	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Don't call me MbL man.	134	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
T90 only knows how to play Forest Nothing and he even sucks at that!	135	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
fuck that's cheating, not even I can micro that man!	136	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
why is everybody buying food? I wanna buy food. Food is my friend man!	137	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
it's such a fast game actually, my APM can't handle this! dautWat	138	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
NOOOO don't resign yet! i want to kill u!	139	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I have camel archers now, you can't resign. That's the rules man!	140	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I miss the old me... I was a cool guy	141	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
That's lazy play. I do it often	142	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
i'm hard to catch	143	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Redemption is the counter to Redemption! New meta confirmed!	144	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
the best way to sellout is beg for the sub dautSellout	145	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
dautWat I am topscore? I did not expect to be top score! dautKiss	146	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Vaat? You're using that gold without asking? He did not even ask me! dautWat	147	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Vaaat? Comeback was possible. Never give up man, don't do a Nicov!	148	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
look at my tg rating man... i'm such a jordan	149	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"look at mbl, picking yellow. We are bald we are from norway we are yellow!"	150	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
look at tatoh man and his beautiful indian TCs	603	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I really have a thing for castles. dont know why. it's like hyun with camels!	732	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
now i see your base but i don't see your base	760	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Villager production? I don't need that	587	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Of course we are fine man! We have goth and khmer man, those civs are op	591	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Poor ACCM he was destroying all game and now he is dead	600	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
oh it's a hole-a? fuck my life! losing all eco!	151	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
why do I make castle? it's hard to resist not to make castle!	152	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Stop killing my villagers let me build economy!	153	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Vaat? Everybody can get to 2.3k, what's wrong these days?	154	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
apparently in germany viper is funny	155	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
he is just dying man! he doesn't care	156	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Nobody can plan kid, if it happens it happens man!	157	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"When someone holds your hand, you hold it back"	158	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
wall me in man. make me a tower.	159	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I will go out and lost all my army	160	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"this fast imp will not work" DauT trying to go drush into condos	161	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Who is trolling now!!!	162	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
i thought it will work cuz fire man! he's not the smartest guy	163	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"vaat? only 2 points... well u don't worth more than this" DauT to MBL after beating him in chess	164	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"OH! STOP PLAYING LIKE MBL!!!!" Daut to Mbl	165	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"oh viper stop making mining camps in the woodlines"	166	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"maybe I should have pocket.. maybe you should go fuck yourself" DauT to MbL	167	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"look at this micro viper! oh? what? u don't have carto? then why i'm taking this fight?" DauT going into micro war with xbos vs mangos	168	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"how is red score? oh is lower than mine" and daut procede with the fantasy play	169	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
should i tell my teammate that all his trade carts stoped... mmmm no, he's top score	170	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
i'll take grey color to counter Bact invisible color	171	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
when u think u fuck up	172	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
this si looking so much BAM now dautBam	173	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
You are learning the ways of prostagma viper	174	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Bolt your ass man!	175	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Go little useless fucks!	176	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
i will outlast everybody	177	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I don't want to be in discord with you man	178	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I guess i will mangonel your TC	179	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
one day I will wall in my towers	180	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"don't fuck around with arambai man I will fucking kill you"	181	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Dance is cheating	182	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"Burmese siege onagers? I'm not st4rk I can't make those man"	183	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"I need a 10 minute break man, I'm an old fuck"	184	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
i could sell stone and then kill myself	185	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"my son prefers keyboard so he will be a macro player" DauT logic cuz his son likes to smash keyboard instead of mouse LUL	186	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
This will be named Jordan villager	257	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I wish to get sponsor of sisha so i get one sisha girl preparing sisha for me all day	187	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
i want to hit you	188	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
i'm humble facka man	189	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
everybody who knows me in person is a lucky person	190	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"This is the type of map i like. just relax and smoke sisha" daut while playing extreme michi	191	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Forest nothing is actually so tense at the beginning	192	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
sorry tati wasn't listen to you. i was spinning on chair	193	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
There is no such thing as too many monks	194	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
oh yes we need to ban malay for them... but they probably didn't prepare so let's ban a meso civ	195	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
you're on a boat? a motherfucking boat!	196	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"I'm not supposed to talk about that, or is it announced?"	197	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
T90 we could have been the winners... well i could be the winner and you my sidekick	198	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"I do not have Snapchat I am over 20 years old and I am also human and male"	199	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
that was a dumb fuck	200	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Time for plan B!	201	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"200 quotes? time to write a book"	202	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"He knows the way man, better get my own cutters"	203	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
he betray me before i betray him	204	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
if i was fully myself on stream twitch would ban me	205	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
ey, you are not allowed to have that as an army!	206	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Is that really a question? Of course New Eagles man, look how pretty they look!	207	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Spit on it fucking sake	208	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
he will never see it coming! oh man he saw it	209	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I feel special dautLove	210	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
send more man i'm bored vs only 2 players	604	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"i hate the quickwalls man. if you are caught, you should die."	609	artofthetroll	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
How did I end up being this good? I don't know. Nobody does.	611	artofthetroll	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"i'm the best player in the world man! i'm sick!"	612	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
oh oh!! look at the meat	592	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
time to join heresy	248	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Do u think i will read whatsapp? i only read twitch chat... and only in between games Kappa	211	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"First we steal your game, now we steal your viewers! Who is the biggest lamer now!" daut after mbl host him	212	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Have you met my friend Stu? Stu Pidasso? -ArtOfTheTroll	213	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I can't quick wall everything I'm not that good	214	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Let's end the game with this little pretty units fighting	215	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"fly little guys! fly!!! I BELIEVE U CAN FLY!!!" Daut trying to garrison vills one tile away from tower	216	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
U never have enough forward villagers	217	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"I hope hico is not watching this stream" Daut 15min after getting 10k dono	218	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
You eat banana	219	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Stop microing or i will get ballistic!	220	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
everything that mbl says is correct	221	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"will totally not make fun of tati if he lose" DauT watching Tatoh Vs St4rk	222	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
i'm going to be a good little husband and take my gf to doctor dautKing	223	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"you are not attractive you are fat fuck" Daut to F1re	224	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
You are not a good player cuz you can't find your sheep	225	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
F1re: "where are you taking gold?" DauT: "Wherever the fuck i want man"	226	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"I am a little bitch"	227	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
are u going party with your grandmother?	228	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
everything turn from a little bit wrong into DISASTER!	229	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm not training viper i'm giving him false hopes	230	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
oh man they fuck me in the ass... was not pleasant	231	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm not medic man. I'm bush	232	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
don't land where u r going to get shooted	233	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
When u live in an island everything is in the way to manchester	234	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I will rush this lovely fucker	235	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Best way to fix this is shit tons of TCs	236	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
every poem is a valid one	237	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Top score! Top fucking score!!!	238	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"it's a safe castle, not a daut castle" dautCastle	239	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
thats why hand cannoneers suck you need to babysit them all the time	240	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Worst thing would be if i finish my 5tc boom and all my allies are dead and have to resign	241	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"DauT is out" is funny because it rhymes	242	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"Is a showmatch! IS A SHOWMATCH YOU FUCK!!! .... ok ok he will pay for that" daut after fire lamed his vill	243	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Maybe i can trap them all... or die trying	244	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
that's a jordan bam	245	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
to be in the same team with fire again is my dream	246	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
i will go maa yolo or some shit to end this	247	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
No Jordan can beat me	249	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I can't wait to see you again mbl	250	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Help? Where? Oh no that's too far away from me	251	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Oh full wall... this should put an end to my tower rush... That's what he will like to think	252	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
oh come on! you are spanish and you are villagers	253	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I didn't plan to do that. But I like it	254	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"get armour man, knights are shit without it'	255	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"well stop microing if you wanna fight with honour"	256	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"hopefully I go to his economy before he comes to mine, heh heh nice spider senses"	259	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"I feel like I am playing this game like MbL"	260	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
hit you fuckers AHHH!	261	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
what? I am top score?	262	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
If there is a nac3 and fire and me qualify i will pay individual room	263	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
If fire was vipers roomate he wouldn't have won nac finals	264	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
when I am with Jordan, it's hard not to laugh!	265	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I know how to handle my night life	266	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm not your content! I'm my own content	267	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"We are not splitting. That bit is whole mine" Daut about to play a showmatch with 1bit as prizepool	268	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
towers are our future, not kids	269	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
How i'm top score if i had nothing?	270	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
How do u tower rush someone who has no economy man?!	271	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
he wants to kamehame my ass man!	272	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Tatoh can't go to sleep he is too excited watching me microing	273	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
don't micro the ram man! let it die!	275	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
every time i lame something die inside me	276	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
mbl should pay a fee for those sheeps	277	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"Luring is for tryhards"	278	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Not a single kill? that was supposed to be a double kill!	279	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"it's full madness here"	605	artofthetroll	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Tomorrow i will start streaming 8am!	613	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I almost think going for elephants was a mistake	593	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
When mbl is the responsible guy from your team. You are doomed	280	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"I read people minds! do u see that!"	281	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"Where is my team? my team is disappearing!!!" Daut playing tg with memb and britney	282	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Go for the rattan fuckers!!	283	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
This game is full of Daut castles	284	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
When u r playing with Memb u never look at the score!	285	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Why are we on teamspeak? to make the loss funnier	286	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
no no no no... it was good... good for them i mean	287	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I don't want to be the guy making monks to counter elephants man... feel dirty now	288	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I fixed my sleep schedule! I'm european now	289	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
If we win it's working	290	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm top score man! If u are top score is cuz u r doing something right	291	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
We win this game in exactly 5 minutes	292	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Fuckers wall these days	293	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I do care about your opinion tatoh	294	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Our team composition is pikeman man 1111	295	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Noooo! no my relics! relics give me a hope for a better tomorrow	296	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
sometimes i'm a little bit late and viper is a little bit mad	297	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I want to stay on hill you dumbfuck	298	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
we re not allowed to praise viper here	299	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
people don't like when I'm myself. I don't even like me when I'm myself	300	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Lierey is my adopted kid. I will make a man out of him	301	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
being in TS with aM is too many information at the same time and all the information is useless	302	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
can we start feudal? dark age too long man!	303	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
no no no... Scorps are viper thing. Ballista eles is my thing	304	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
damn right, it's all about being unique	305	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
double nothing is nothing man, easy maths!	306	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
i'm in secret to win games and to piss off viper	307	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Best thing is to piss off viper and troll around and boom and then win the game	308	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
who needs boar when u can wall	309	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
if i'm fuck then we are all fuck	310	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Portuguese and vietnamese now this is mbl dream. He can lame whoever he wants	311	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I never get fucked	312	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Kids in the game, kids outside the game, what the fuck is wrong with my life?	313	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"enjoy point of view, i'm freaking playing here" DauT to nili cuz nili started to sling him in post imp game	314	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
oh fuck i made scouts instead of paladins. oh well it's ok they will think i'm out of gold	315	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"let's host the girl. probably viper is playing with the girl"	316	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I pray for the new age2 DE get smarter deers	317	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
what is the difference between a 2k and a 2k5? well u can go watch nili stream and then come back to mine and see the diference	318	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
everyday i fight those deers man! is so annoying	319	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
ModeratorVerifiedNightbot: Yes i'm trying to be the streamer cuz t90 is trying to be the player	320	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
i wish hera was here to share this amazing moment of casting t90	321	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
The good caster will need more sisha	322	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
When eagles kick in the problems begin	323	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Why are we top score? probably because of me	324	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"He doesn't read about civs" daut implying that enemy doesn't know about teutons bonus	325	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
ohhh now i have to quick wall everything.. let's better resign	326	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
we can go 2v2 and whoever gets nili is screwed	327	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
only nili knows what he is doing	328	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
i almost want to close the stream and go to hico's house to make fun of him	329	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
i should pm him to resing... i mean look at his score	330	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
to be fair deers are quite easy to push	331	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
lame teammates is vipers and mine speciallity	332	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
this was stupid... but it's ok, i'm stupid	333	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
come on spearmen, what are you doing? are you drunk or something?	334	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
what is he doing? OH WHAT I AM DOING???	335	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"I don't want to deal with this shit anymore" proceeds to drop a fwd castle	336	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
cmon die you little girl	337	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"maybe this is a bit bit agressive castle" Kappa dautCastle	338	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Farms is the imperial age unit to make	339	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
i don't think even i could throw this game.. but never say never	340	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"Fine.. die! See if i care" daut talking to a deer	341	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"this is our homemap" few mins later "we did not practice this enough man" DauT casting Secret vs Suomi	343	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
ohh oh nili you can't play. is 2k3 room	606	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I am made of micro	610	artofthetroll	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I want vivi man! he is the best teammate i ever had	594	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Freaking luck wasted in practice	258	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
There is no pride in laming in tournaments	344	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Come on Tati get fletching and do something	345	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
They don't know how to play so they won	346	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"i don't know man. I'm here just to cheer for Frantic" DauT kinda ignoring nili questions while casting Heresy vs Frantic	347	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Indian camels? Frank camels seems to be the way!	348	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
come on monks, convert faster lads.	349	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
He forced me to do stupid moves	350	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"I thought I was Jordan as well!"	351	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
did i lost villager? mm no? idk what happen	352	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Fun fact! i didn't ask slam if he wanted to play. i just sign up both of us	353	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"what friend? u have no friend tatoh! i'm your only friend"	354	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Sansa Stark is like Jordan in Secret	355	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
aM plebs always trying to be Secret	356	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"You lost tatoh! i won!" daut talking about a game where tatoh was his teammate	357	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"MVP stands for Most important player" dautWat	358	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm always romantic	359	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
You can do whatever you want. I will do the same	360	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
if I wanted to work I would get a job	361	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
There is no way he can hit me... my micro is just that good	635	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
ModeratorVerifiedNightbot: he thinks Khmer elephants are strong? wait.. just wait.	362	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
how do I quickwall out of this problem?	363	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I cant get through the shield of the meat man!	364	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
they tickle shit out of me man	365	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
he only got monks hes not cool person (daut going full elephants into monks)	366	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
faith is useless I'm still getting converted	367	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"Now i will go to watch your stream and watch you lose every game" DauT to viper at the end of the stream	368	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
It's one's personal opinion if u want to stay young or not	369	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Age of Empires keeps you young	370	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Is not trolling if it works	371	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Deleting your TC in team game is disrespectful to your allies. You only do that in meaningless 1v1 tournaments	372	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I have powers everywhere i go	373	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Nili and the random 1500 needs to split... i prefer him	374	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Why do u want me to play with no mistakes man? then we win and we start a new game. let's enjoy this one	375	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Me good micro	376	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Oh hera... you are a caster now! u should ask nili for caster coaching	377	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
they are trebing my ass man	378	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
The fuckers are fucking me man! i can't handle this!!!	379	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Is not yours if it's under my TC	380	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Don't "good luck have fun" me now	381	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
when somebody ask me to micro for them you know shit is really bad	382	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
yeah... people loves to smurf on my stream	383	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"u need to forget everything that hera told you" DauT coaching Tek	384	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Columbus reach The Americas faster than Viper Serbia	385	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Viper lives in north pole. He knows Santa	386	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Whatever i said I'm right man cuz i'm the older one here	387	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm not a stubborn old man	388	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I will go full mbl now on this guy... I need to take this out of my system	389	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Man it's so laggy to micro like a beast	390	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Someone is not doing anything and it's not me	391	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
We don't trade man! We kill!	392	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I would kick you as well Tati	393	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
oh i spent like 1k wood on quickwalls! can't even build barrack now.. was worth it 11	394	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
oh i have counter to his units. Is called TC	395	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
there is a certain amount of games that u can play a proper army composition, after that unique units are too cool to resist	396	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"We can't lose while we're winning"	398	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I don't even know what i'm doing! Will i go castle age? or feudal?	399	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Look at my top score and i don't even have a scout	400	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Don't let that winter come to me Tati!	401	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
let me finish paladin upgrade first and then we can go and die	402	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
If u are a kid and u own the ball u have guaranteed a place in the game	403	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
If i had to replace viper with other player i would chose Jordan dautJordi	404	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Camels are smarter than knights	405	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
It wasn't a prepared strategy. Just looked smart by accident	406	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"no no! don't tell the enemies we hate water! let them think we love to micro galleys and shit" Daut discussing strategies with slam	407	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
now i look like a stupid and an idiot	607	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
The masterpiz backfired	805	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
You died like a pig man	595	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
PLaying safe in a tournament? what year is this?	408	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
We got 3 wins and we are badasses	409	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Where is fire? oh he is playing team game alone	410	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
why can we just patrol each others like normal humans ?	411	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
hope the scouts will be gentle on me	412	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
You can't raid me, I don't have anything	413	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Quite a daut lumbercamp	414	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
i have a few demos... how many is a few? less than one	415	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
If artofthetroll was in my wedding, people will confusing him with my son	416	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Viper: "U didn't invite MBL to your wedding cuz he lames you?" DauT: "I should invite him and kick his ass"	417	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
You can basically lick tati before tequila. cuz he is so salty	418	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm memb man, I'm a caster man. what next? BibleThump	419	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Good luck guys, hope you lose	420	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Did hera give you coach and you are back to 1600 again?	421	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"I can't lose, I micro!"	582	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
wtf man! slam is top15 player man! and no! he doesn't come up with strategies! but he listen and he performs	422	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Nothing is more important for me that your love viper	423	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
who cares about micro when enemy is losing villagers	424	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
oh man what's my civ? .. Elephantos man!!!	425	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I lost all my economy to lions	426	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm not dead, he is dead!	427	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
tatoh! go with jordan man! fuck viper	428	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Hera is like mini mbl man	429	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
daut: "oh we can teamwall tati! lets teamwall" viper: "yeah we can teamwall" daut: "nobody ask you"	430	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
we make units and kill	431	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
bad luck in 4 games is not bad luck	432	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
So much potential to make fun of the people i know	433	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Did you burn your house?	434	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
When you believe hard enough your tower may hit something	435	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
How can you steal T90 content now that you are playing aoe1 viper?	436	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Just plug off the cable! there is always a way to fake a restart	437	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
This is regicide, we always win	438	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Screw the money, making fun of viper is all that matters	439	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I will win aoe1 tournament and never play it again. I will say then "i'm the best aoe1 player, i'm retired now"	440	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
oh!!!! look at his villagers!! 11 welcome to the defeated land	441	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Everything more than 2 clicks is hard work	442	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Win this and brag in tatoh's face is the best prize i can get	443	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I need to wake up at least at 2pm to don't miss my son's birthday	444	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I need my beauty sleep	445	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
It's really colorful in my side of the map	446	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"At least I have one relic" DauT after losing control of all his golds	447	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
We destroy one guy and then we wall	448	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Well sorry for being that good	449	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I want castle here. I get what i want	450	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I was touched man WutFace	451	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
(DauT to SY in a TG Nomad) compared to these guys mbl is more fun to play against!!	452	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
his walls got walls man	453	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm gonna treb his ass to the freaking dark age	454	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Worst case scenario I will end this game with an amazing DauT castle	455	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Freaking tati! stop drinking and smoking! Is bad for your health	456	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
There is always a fail	457	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
If there is a wall there is a fail	458	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I win to the deer but i lost to the boar	459	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm a little bit mbl these days	460	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"I would have won this game earlier" Daut casting Max vs Viper	461	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Shit is getting trickier everyday man	462	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"I have no clue what i'm doing with my life"	463	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I have no clue why u guys are watching this shit	464	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
This is family friendly stream man! I have family and i am friendly	465	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I don't trashtalk fire man, i tell the true. Is not trashtalk if its true	467	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
don’t fuck, man...girl!	468	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
zombie game is something mbl would enjoy. just wall up and make towers!	469	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
nah i won't be greedy... i think i have been making to many daut castles in my life	470	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
But what you must understand, I am a lazy fuck.	471	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
He doesn't give a single fuck man	472	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Man in old days i prefered to type instead of talking but nowadays i'm too lazy to type	473	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I know u guys wanted a daut castle but i can't	474	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I spent all day microing farms man	475	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I fail as much as ai could	809	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
You need to get baby viper! Dogs are easy	596	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"my quick wall is quick fail"	1	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"this zebra is asshole"	2	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"Build faster you little fuckers."	3	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"time for what we've all been waiting for. time for a dautCastle"	4	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"Everything is invisible to me"	5	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"You know the best thing, if I get divorced I probably have to pay nothing because I'm unemployed"	6	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"I will bench you so hard that you will never stand up."	7	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I don't need to micro. I have hill	8	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I don't need people to die man!	9	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"Look at this Daut mill. Best mill in the game!"	10	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"Maybe I should shave before the stream. Then again, who gives a shit!"	11	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"You see gold, you make mining camp..."	12	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"He challenged me in Vodka war. He will fail."	13	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"Even wolf is being an asshole"	14	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"... and you let JORDAAAAN play?!"	15	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Forest Nothing is like freaking game of thrones man!	16	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"They are hand, and they are cannons"	17	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Nothing type of maps are quite fun	18	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Kiss me you beautiful son of a bitch!	19	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I will send friend request to mbl	20	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
ok, ok, lets patrol this army and never look at them again...	21	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I need to balance troll	22	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"I'm a professional." - DauT 2018	23	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"i'm going around here fuck off of me" DauT to Viper during Nomad 2v2 Tourney	24	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
i send 1k wood. i'm a good teammate	25	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
He knows man at arms opening is coming and I will fucking give him man at arms opening	614	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm going paladin upgrade... Because i can!	733	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm streaming at all but i will wait instead of playing just to tilt mbl more	744	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"yes viper we are enemies... and tomorrow as well" they had showmatch vs aM next day	761	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I shift clicked it man.... i shift failed	787	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
You wanna fuck up with elephants man? You can not	806	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Nothin is dying for him man!!!	810	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"Fire you were closing to lose your iphone and your life" daut talking about this clip https://www.twitch.tv/f1reaoe/clip/ReliableSmilingDuckDerp	812	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I’m like the worst shift clicker in the fucking game	820	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
“Playing against inc makes me feel like Lierry”	829	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
let’s not go too all in - DauT with 0 food in the feudal age	837	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
choose the big one, it's the safest bet man!	839	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
we are chilling. I sound like a Hera now! but we are definitely chilling. meanwhile we can enjoy shisha	840	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
when they introduce auto micro, then we will talk	841	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
gg... He didn't let me enjoy...	842	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
how do I go YOLO when I don't know where enemy is?	872	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
OHHH HE IS MAKING ELEPHANTOS!!! I want to lose now man... He deserves the win	902	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
i Over boomed but i was expecting to lose more villagers than this	937	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Looking at nili defense is like watching AI playing	955	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Yeah he got gold at the back... A bit lucky but a bit not enough	1005	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
He is playing full army without full army	1019	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Pocket doesn't matters, unless is daut pocket, then it matters a lot	1030	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
oh man those castles are FULL of arrows	1038	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"Pfffft, I don't go Skirms in a team game, I am not MBL!"	1045	byelo	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I will never troll viper. You don't know me	1068	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Tatoh man! he is raiding me!! I have a daut castle every single game!!!	1081	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
First I take those sheep that are probably yours	1089	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
He is sending everything into the nothing	1097	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
micro and me had fight	1108	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I could teach you guys my disaster build orders but they are expensive	1125	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
now I have to scout for 1 cow? I'm not doing that. they can give me that 1 cow next patch!	1132	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I do want to be nice and sell out but I don't want to be t90	1140	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
What do we said about the farms? Not today!!	1147	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"Dropping a siege workshop would be a smart move; dropping a castle would be a cool move."	1157	fatrhyme	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
He must be really scared right now... of me hitting nothing	1163	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Let's go with an offensive castle first	1174	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
well elephants are there to... Look cool?	1178	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Why is my economy so good?	1185	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Now when I fail I take my whole team down with me	1194	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
hide the low hp, because that boar is microing	1197	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
let's go flaming fuckers! bam! bam!	1199	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I was semi-smart at least	615	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"I can be polite as fuck man!"	621	goldeneye_	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
You are a brainless little fuck	622	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Ok ok too much vipering too much vipering	625	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I went tryhard but full disaster	627	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Now this is a good boar... now is an asshole... now is good again	628	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Look at my beastly score	631	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Baby is crying and i'm not there... that's cute and annoying	634	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
if the girl is Roxy I don't want it, man	637	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I like saying nice things about myself.	640	artofthetroll	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Not paying attention is my transition	641	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"this time i won't drink" daut refering to NAC3	646	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"micro nerd that! young fuck!"	649	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm nice but I still got that asshole bit inside of me!	658	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I read your mind man! YOu can't beat the mind reader	661	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I wish i was responsable	663	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
i stonewall the shit out of him	669	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
i'm scouting tatoh heavily	675	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I need myself here	685	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Still smells like a fast castle	688	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"how slow are you man?" "just like my APM"	689	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Let's just push man i'm tired of following	690	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm bored someone sling me	692	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
But no! it was like Fuck!	693	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
if i masterpiz viper i will be so happy! .. OHH OHHH You are my bitch now	695	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"Grid mod is not working. But then again, grid mod is for tryhards" Daut being to lazy to reinstall grid mod	696	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
there is no honor on spamming galleys for one hour	697	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
My body is sick but i'm fine	698	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
oh man! he is really into the micro	700	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
yeah.. there was a hole... There is a hole in my fucking brain as well	701	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"Ok guys food is ready. Give me 4min and then we continue to 1k7" daut with an 1k8 elo	703	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Nah he wasn't salty. Although i actually didn't read his message	708	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Jaguars are destroying my ass	711	artofthetroll	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Most of the time in nac i spent it sleeping	712	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
man you saw that game! You lost it but it was so fucking fun	713	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"Nice scouting by him. He knows everything - so he knows he's going to die"	716	artofthetroll	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
why pause so amazing game?	717	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
MBL! You were the reason i started streaming	723	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I help and he wants to fight. kids these days!	734	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"Just boom man, who gives a shit?"	745	artofthetroll	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Maybe best thing i could do is just resign and stop wasting time ... I like wasting time	746	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm so fail man	750	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm a pasta guy	762	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Run away from my HP man!	763	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"I'm lierey, la la la!"	764	artofthetroll	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
i think i don't have handcart. But it doesn't matters, i'm playing nicov, so he doesn't have it either	766	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I don't even know when i'm sleeping anymore	774	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Lierey is like Hamster. he just collect everything	777	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
¨Pressure is high because i made fun of mbl for losing here.... I cannot lose now	788	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Why are you guys so stupid?	789	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Yeah i'm married.. even had kids and shit	796	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Oh Fuck! is 10am!	807	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Do i look like i ahve any job at all?	811	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
idon't give flowers to my wife cuz she will think i fucked up, cheating or sometihing	813	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
the best plan is always an easy win	821	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Should i cancel my hoang rush... I cancel nothing man!	830	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"I'm not Hera I don't ask my parents' permission"	838	artofthetroll	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Tell my best joke? ... Nili is a good player	843	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
We were supposed to chill and boom man! now you are breaking the rules	845	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"In HC I will do outposts and pretend I'm an idiot"	849	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"you see there are battles here. the shades of the colors are changing"	850	artofthetroll	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Thanks for 2k dono matt, i hope you fail	851	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
At times you fail and it still works out!	853	byelo	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I think kamikaze tower rush is the only choice	854	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
you should always trust robo	860	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
went imp and still making castle age units? Good job, me!	862	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Fuck my life! this kids are getting better	863	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I wouldn't like to be under mbl's command	873	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I need a lot of things, and I need them fast!	876	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
That's my game plan here... believing...	883	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
achievements? I have no time for achievements man!	888	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
ohh... he is now retreating and shit	616	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"Eventhough I have a wife and 2 kids, I will still have sex with you"	623	walterekurt	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
If I cannot read Nili’s mind, what the fuck am I doing here?	626	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"he mastapieced shit out of me there"	629	artofthetroll	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
This is a typical memb tower man in the middle of nowhere and protecting nothing	632	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
No no no don't come to Belgrade	636	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"If i go elephants that would screw me over" .. clicks elite war elephant tech on castle	638	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Kreepost are so small now dautLove they are so cute! they are cuteposts now	642	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Edie is my french fairy	647	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Luring deers is for people that care.	650	artofthetroll	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"I believe in you, snowballs!"	659	byelo	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
converting is faster than delete button	662	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm Youtuber aswell	664	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"Nicov! i want your puntos not your viewers!!" Daut after getting hosted by nicov	670	artofthetroll	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"Why should i make army when everybody is walled" Daut while viper was getting destroyed 2v1	676	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"I'm happy for you but I'm not happy for myself"	686	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
ohh viper?? i would like an ally!	691	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
To be fair deers were too close so i needed to make it harder	694	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"Finally Tati is useful" Daut after Tatoh agreed with him	699	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
if a made some micro that no one ever saw...	702	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"Yeah.. ok .. Fuck You!" Daut to one of his deers	704	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Will this villager war ever end? i hope not!	709	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I will risk it man! we all love those castles	714	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
An then we will see nicov! who is food and.. who is top player	718	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
oh hello there! You want to expand and shit ?	724	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
at least when I'm stupid. I am stupid with style!	735	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I don't have a castle man! Nor many villagers.. Nor chances of winning this game.... But i like playing	747	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
He got all the monk	751	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
camaaan you are cavalry archer man! you archer the horse!	765	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
the mistakes like this, only i made	767	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
my kid is waking me up and being an asshole	775	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
This is my job man! I'm telling my family i'm working	778	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Hera.. is not all about educational game you fucking nerd	790	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
yeahh.. i just made stable to be there looking good	797	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
i still have one fucker outside	808	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Maybe is time to start the fail lure dautLure	814	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
it was two militia now it’s three? They are multiplying	822	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
if he is going forward i call him stream cheater and resign	831	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
So much difference when you have luck in your game	844	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"I've got balls, I am made of balls!" Daut before luring two boars at the same time.	846	byelo	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I guess this is too greedy.... But i'm greedy boy	852	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Let's do a Daut castle and then end this with style.	855	byelo	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
oh are you trapped inside little eagle? oh, I don't have loom	861	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
look at the micro man, I don't know why I am doing all that!	864	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
me, mbl and megarandom. best love story.	874	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
they kill my future when they outmicro ballistics, now my future is gone.	877	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Change of plans... I'm going to towering him like if there was no tomorrow	884	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I choose to play like a man: daut adding two barracks in dark age at 25 minutes	889	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Next time i will coach you... You will still lose but i will get some money	894	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I have 7 villagers and I don't even know where they are	903	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I tend to fail a lot	938	artofthetroll	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I will wall and I will guide ad I will wall into wall and into guide wall	956	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Memb is playing? Well i will have to wait for 20min queue to find him	1006	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Ok Tatoh you practice with computer	1020	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
He is a team mate that makes outposts	1031	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
looks like the fucker is walled in	1039	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
First we became friends then you wish that never happend	1046	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Oh fire was in stark's channel? But is he on stark's bat? that's the real question	1069	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"I'm not losing with this many TCs" daut after 12TC boom + fishboom	1082	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
There is a limit to my micro tatoh man! And i'm above that limit!	1090	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
is not just a trade cart man! is MY TRADE CART!!!	1098	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I was laughing at the demos man, who's laughing now? BibleThump	1109	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Get fuck right there!!!	1133	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Ok, fuck that deer	1141	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
You can't do anything but you are a cool looking fucker	1148	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Does he have a secret economy that he didn't report to me ?	1158	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
The mastapiz.... The mastaWhoCaresAboutItpiz	1164	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I like my spot but i need more TCs	1186	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
you get housed when you don't make houses	617	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Look at this guys... WHAAAT!!! ok you guys can guess my point anyway	624	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I had a solid fast reaction and also have a solid asshole	630	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
No i don't use Tinder... I'm already fucked	633	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"die you steroid units" ... daut sending elephants into elite kipchaks	639	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"Who is screwing around with my pickle?" dautPickle	643	byelo	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"he had a good life" Daut after losing scout under enemy TC	648	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
i wish to under stand you hyuna. but then again you are a weird fuck... so thanks for the cheers	651	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
To be fair my micro was really bad	660	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Troll, you sick son of a bitch, you know stuff.	665	artofthetroll	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm microing my ass out here and i'm losing	671	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
i'm only making kts so you don't cry	677	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"I'm sleepy, I'm hungry, I need to pick up my family. I'm so sad. I can't wait to go to Hamburg and relax for 10 days"	687	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"Oh, it's a fail... Oooh, it's not a fail, it's a jebait" Daut saving a scorpion.	705	byelo	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
All my villagers are like one hit away from disaster	710	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
fight like a man, die like a clown!	715	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Ohh Double turtle! Double the pleasure	719	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
DauT reading chat.. "TATOH: DauT!! stop ignoring me on discord fucker" .. DAUT: No!	725	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
screw art of war someone should make a deer lure tutorial	736	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
good luck finding new opponent? that's the beauty of matchmaking. you can't escape me!	748	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
What? He think he can outmicro me? He doesn't know who i am or what?	752	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Run to your little TC	768	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I need a office where i can play and sleep	776	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm hot, funny and rich	779	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Ty for the gift subs man! Spread that christmas spirit! dautSanta	791	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
And then they said is a hard game man... just wall and boom!	798	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Nooo! Don't be walled when i have so much food...	815	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
my economy is four farmers	823	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"Come on, not more wolves! Hoang, how do you always sneak those villagers?!"	832	byelo	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm sick player, I don't even care if I lose anymore, already won in my heart!	847	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
It seems like it's a mbl game	856	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
My towers are more expensive that his castle	865	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Maybe he is thinking that i have a defense... PLEB!	875	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
i'm going to make a lot of happy towers	878	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Don't fuck with me kid!	885	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
its so stupid it was funny man. such a t90 man!	890	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
the scout can only watch woman die there	895	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I believe in my micro	904	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
death match is so easy, we need more death match tournament	905	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
It seems like I'm clown now dautArena	908	artofthetroll	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Slam! thx for the sub! now turn on the game for some action!	909	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"you don't even know if it's day or night lately" daut talking about his sleep schedule	910	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I want all the pokemons	912	batbeetch	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I will go for archers and my archers will be on elephants	915	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
And we all know that cool plays win the games	916	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Micro Like a God! Die Like a Hero	922	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Seems like those flowers are never missing!	928	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"Why are you all so low HP?" daut sending vills forward dautCastle	939	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"I don't quick wall my villager... I beat him with my hands!"	947	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I just needed fletching instead of lag	948	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
We won 2 out of one tournaments	957	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Luckily tatoh will sling me stone. If not i will mine his stone	958	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Suomi play stupids map good	961	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
how do I fix my economy at this point? *builds a castle with idles	967	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
i will buy some hera coaching for Viper. Like a hera coaching gift card	971	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
we are extreme sports now, I live a dangerous life	975	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I feel like aM are my kids	976	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
you don't need to leave my stream to hit 0. Twitch is doing that for you!	980	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
even my amazing micro cant deal with that	985	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I will show him who is best pocket. I am getting outmicroed by zebra	988	batbeetch	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
pick celts pocket and go fast castle mangonels. Is a bullet proof strategy man	989	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm hosting and disrespecting at the same time.	990	goldeneye_	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I wear black underwear, I feel sexy like that	991	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
how is it always arena against arena players? they can only ban four maps!	992	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"Everywhere I look I have a dead villager. This is why they invited shisha!"	994	byelo	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
stop raiding me! it's not how we play this game	998	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I would need a forward castle and that's too risky	1007	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I don't want to kill buildings, I want to kill people	1011	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
if you ever want to know how to micro just go to the VOD and watch it again	618	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
paladins with +7 looks nice... but my mangudais look nicer	644	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
grandpa got some moves, man	652	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm currently number 9 in the ladder but fire is above me so i'm actually number 8	666	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Apparently lions are beasts.	672	artofthetroll	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
You make carto instantly just to know what i'm doing???	678	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Ah? wha? nah? wha? .... Why i'm an stupid person?	706	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm stupid and i'm proud of that	707	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
that went well	720	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
In serbia womens say "screw that man! he doesn't weight more than 100Kg"	726	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
heavy plow or TC? I say TC!	737	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"Coaching from JonSlow? You sure you want to do that to yourself?"	749	byelo	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
everybody is fucking with deers early... bunch of fuckers	753	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
That hole man.. that hole fucked me	769	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
my life style.. i wouldn't recommend it	780	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Oh... well you can always do a daut castle	792	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
i'm housed and i have no wood for house... kill me one villager man!	799	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"We were talking! you weren't supposed to see that!" daut when lierey evaded his mangonel shot while they were chatting	816	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
When you lose galleys to a relic, you know you're fucked.	824	artofthetroll	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"Houses are an overinvestment... cuz they cost wood" daut going for the super late game in team islands 1v1	833	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Do I really need conqs... Fuck yeah I need conqs!	848	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
oh wait! We have turtles! he is dead! he is completely dead!	857	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Bodkin arrow is good when all your army is towers	866	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
imagine age of empires university	879	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"even if i delete all my walls i would fail here" daut luring deers on hideout	886	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
he started it and he dot me man, don't dot me man!	891	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
i'm the princess of the black forest right now	896	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Every time i remember to do it it's really good	906	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
i don't like booming girls	911	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Look at this old school camels they're not even on fire	913	batbeetch	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
i lost more villagers to boars than he lost to my push	917	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Stone is my best friend! I'm mongols!	923	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm training slam everyday so we don't need to use nili... I need extra prizepool for this	929	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
what's fire's weakest map? .. everything that is not islands	940	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
i would never be so mean with someone i don't consider a friend	949	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
you spit facts? I spit on your facts!	959	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
this little bridge will be full of blood	962	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
What time it is? oh is time to call it	968	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm just happy that that wasn't my hole	972	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
aM is not streaming but not cuz they are tryharding but to avoid the shame of losing like this on stream	977	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
you see a bunch of women running with knives and you hide in houses?	981	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I wanna join SY	986	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I saved 6 food. I'm happy!	993	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"So this is what it feels like to be Nili," said while dying in a TG	995	byelo	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
other parents in parents in: how does your father have no job. DauT: because I do nothing man! dautKotd	999	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
this is my last game... i have been streaming for 6hs already and if i wanted to work 8hs a day i will just get a proper job	1008	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Viper: "Why is my range so short?" DauT: "Poor Debbie..."	1012	byelo	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
This is so tilting man... Now i know how people feel when they cast my games	1021	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Look at your score! No wonder why you didn't qualify	1032	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I would prefer to beat viper myself but it would be more humiliating if fire beats him	1047	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I have half HP villager without loom walling	1070	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Man.. The moment when you start missing viper is the bad one	1083	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
nice help tatoh... WITH THE GENERIC STARTING UNIT MAN! Thanks you for the help	1091	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I deleted hera in one samurai move	1099	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
that's kinda sleazy...that's what I do against F1re	1110	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I don't care man, wait actually I do!	1111	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
it's a dautcaste! I know one when I see them!	1115	deagle2511	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
i'm not switching to skirms like some pleb would do	1117	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Oh no! i'm vs towers and my pocket is mister 0-4	1119	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
You are all problems	1120	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
You live, you learn... you wall..	1134	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
apparently Knights are slightly better than Scouts...	1135	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
My school failed me, I only know cursing	1142	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Everything is mistake here	1149	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"I will be the person I hate, I don't want to hate myself" - DauT May 2020 BibleThump	1152	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I hate when other people think as well	1153	goldeneye_	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
my patrol is broken	274	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Should i trade all my maa for one villager? ... YEAH!!! Let's trade all my maa for one villager!!	619	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
My knights are killing me but i'm happy	645	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
it can be sick but it also can't be sick	653	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Plan is take all the relics and then chill until imp	667	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
In hill we believe	673	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Where is the resign buttton? I dono man, never found that one.	679	artofthetroll	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
So much stone but no time to spend it	721	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
When i was young i was going to the gym and shit. Now that i grow up i know that is more about money than looks	727	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
So guys? What do you think about my micro? Was sick right?! i'm so proud	738	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Nili can't spy aM he doesn't know the game to be a good spy	754	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
when i say maybe it means i will be greedy	770	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm playing players that are at T90 level.. and i'm losing man	781	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
time for the surprise madafaka!	793	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Come to the castle! come and kiss that castle	800	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Deagle if you sub to me you will suck less	817	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
A daut taunt pack? ... It' probably won't be allowed cuz i curse a lot	825	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
We go hoang but with market	834	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Oh he is not even playing! come on! go out and play with me!	858	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
when somebody is cool he is just born that way	867	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
i want 3rd bombard cannon so i kill really fast	880	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I will host memb... Need to support the guy with a family in this dark times	887	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm so safe not even corona can enter my base	892	zuviss	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Monks are friends with the fast imp	897	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
DauT: Okay my favourite unit is elephant, I change my mind (nili: what was it before?) DauT: Mangudai	907	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm a weird person man	914	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"You are a brave boy but stay at fucking home" daut after a vill went outside his base chasing enemy army	918	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Punishment is coming back to our city	924	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
There is no rush for punishment	930	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I don't need stone man! Stone is for losers that boom	941	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
you're Viper of course you're fine	950	batbeetch	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
this is my team man.. always working against me	960	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
You can see that aM is playing serious cuz the benched nicov	963	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I don't want to play the arabia game.. Oh tatoh is not playing? then i want to play it. I don't want to play with tatoh yelling at me	969	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Tatoh!! I'm going for the forward castle man! You want to support that cause	973	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
tatoh is pushing enemy deer to TC. That is like disrespect outpost rushing!	978	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
ho ho, Hera snipe: DauT attacking a full hp Incan villager	982	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Comodo Dragons on Arabia? Makes no sense.	987	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I need to hit it twice to make it personal: DauT talking about laming boars	996	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"Look at him trying to fast castle like if its arena" Daut playing arena against dracont	1000	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Do i ever dream about viper? Everyday man	1009	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
daut kids vs viper kids?? I'm not even sure if he knows how to make one	1010	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
just because they cannot make cool elephants they are converting mine	1013	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
PLan? ok i guess i go afk for the first 5min to make the game even	1014	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Nili i didn't troll you that heavily but i let that for TGs later on the week	1022	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
This guy is an idiot	1023	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Look at him. Asking for practice and shit	1025	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I have a better game! Found where is daniboy on the map!	1033	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
We lost enough units, we can go back now	1040	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
He just wants to quickwall the whole map	1048	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Tati man! don't disrespect me! Is not like i lost to Yo 4-0!	1053	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
you scared my deer away with that sub!	1058	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
is it time to do this? patrol and enjoy!	1060	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'll go to the hill... And micro... And die!	1061	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
ohh i took hera spot.. AMAZING!!!	1063	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm not drunk i'm just stupid	1071	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I wish my dad was doing drugs... Also kids don't do drugs	1076	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
any other thing i can do for you, my losing team mate?	1084	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
For the new people it will look like i'm losing to the enemy team man, but no.. Is only tatoh's fault	1092	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
(DauT sniping a dock vill gathering shorefish) "I was just jealous that you remembered the new balance changes and I did not"	1100	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I know this game! I do this for a living	1101	deagle2511	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"I can't stop watching Nili's stream chat. Imagine if his hair never grows back. That was all he had."	1102	byelo	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
(daut to classicpro) "I have an ally in this game man, and it's a good one"	1112	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Once you share the bed with a guy, he is your's forever	1116	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Always cheat! Is not cheating if they don't catch you	1118	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
fuck me if i know	342	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
This is DE and in DE i'm a micro god	620	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"Today is my sloppy day."	654	byelo	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"You can hit this one" - Daut talking to towers	668	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
what's a good counter ballista elephants? everything, even villager kills those	674	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
oh no! i need to sling you fast before they resign	680	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Tower won't live a happy life	722	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Hello Mr. Tower!	728	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
he is trying to up without loom... You have to punish that shit	740	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I think corona virus started from the NAC	755	zuviss	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
the meaning of life is to die and become a zombie	771	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
how can i be a top player and make all those stupid calls all the time	782	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
i have to go destroy him! like a man!	794	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Oh no... my elo is so low that i'm playing slam	801	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Ohh You are a good galley! you are a good galley!!! dautLove	818	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm your hero? You have low standards man	826	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
yeah yeah.. baby crying yeah... I'm crying as well	835	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
why i'm still playing? ok let's wait for imp and resing	859	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
when you're unique unit is dying to the villagers. that's all I have to say about the unique unit.	868	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
hera! were you scared? imagine if i wasn't stupid!	881	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
If I played checkers I would have a daut Castle	893	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I am not freaking uber to you man	898	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
He is microing really good! or maybe is me being stupid	919	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Oh fuck it! Let's go tower rush and wall at home like a little pleb	925	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I remember a game against viper. I fully wall and he send all his chat to my stream to spam "walls walls no balls" but the point is that i won that game	931	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
We are playing no balls this game	932	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
At least we have Nili in our team so Excuse is ready	942	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"Is that your castle? Do I need to go there now, haha?" -DauT to dautBaldy	951	batbeetch	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Don't think Nili! that's your first mistake	964	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Let's play Adventure man! imagine Youtube title! Secret team goes on adventure to China!!!	970	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
The Vivi got spider sense for my daut castles	974	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
SPANISH??!!! Hahahaha... they don't know shit!	979	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
You should go for elephant archers qhen you already won the game and you want to troll	983	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"Who doesn't like rainbows, come on?" DauT to Viper while doing a 5 TC boom.	997	byelo	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
ohh he doesn't have loom! .. I wish i had fletching	1001	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
can I quick wall? I fight with villagers I don’t need quickwall	1015	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
if i was admin i will give AW myself here	1024	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
i don't really need help but i like when you are around	1026	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm the better team game palyer but also the better person	1034	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Hey MBL do you want to buy plans from RB? i have some to sell you	1041	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
i don't even know where to start with the disrespecting here	1049	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Man! He is playing like viper man! He should know how did that end for viper!	1054	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
When you hear that sheep sound you know that your scout did a bad thing	1059	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
You are not on stone young man?	1062	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
You know you hit low bottom when even daniboy is making fun of you viper	1064	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I can afford to be a bit aggressive, and a bit aggressive means right into his face	1072	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I prefer to work less than have more money	1077	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
We are playing alone and i have 200vills and you have 2 feitorias	1085	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
How does it feels to play a team game with a team?	1093	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
how do you fast imp without tc?	1103	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"look at my score, look at my ally score, look at my opponent score. Why are we looking at score?" dautKotd	1113	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
man shift clicking is made for old people	1121	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
aww and you wanted to raid me now? Should have messaged me earlier!	1136	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Overchoping will happen. I know it, you guys know it... Hera knows it	1143	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I didn't kill a single one. Not my idea of having fun.	1150	fatrhyme	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
It's all jokes untill you get defeated by the elephants	1154	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I couldn't find the sheep then chain disaster after that	1159	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Now let's not play like Fire	1165	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Ohh this is a cheap way to win the way.. I'll take it!!! i'm a cheap fuck!	1175	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Let's play capoch style. Like you have nothing but you have economy for everything	1179	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
does the loss against aM have any consequences? yes I am divorcing because of that Kappa	1187	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"You wanna get walled? You wanna get walled? Don't fuck with me."	1190	artofthetroll	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Let's go turtle boys!	1191	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"Make your own villagers!" DauT responding to MbL converting his trush vills.	1195	byelo	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I was counting on the prize pool to feed my children, man	1198	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
i'm that type of team mate	397	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Hera will soon have more games than rating	655	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"It worked, man, it worked!" Daut after making Tatoh and Yo resign with 105	681	byelo	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Did i lose my demo to something stupid ?	729	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Nicov, you fucker, you jebaited me, why did I listen to you	741	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"Is not that i'm tryharding, is because i have the worst flank" daut pocket nili flank	756	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
he cannot work when he is dead, that's how this game works	772	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
MBL and me will hunt fire down, and smurf him	783	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Yeah i think my map is not the best... But i believe and he doesn't !	795	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
freaking slam! i want to scout him but if he trap my scout i will look like an idiot... i won't scout him!	802	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I just want axemans cuz they are unique unit	819	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I don't know if he is smart or stupid	827	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Debbies is streaming a lot... I guess he is jobless as well	836	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
When shit starts, i have no time!	869	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I don't know why his economy was that shit. guess I am just much better!	882	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
time to kill his villagers for sport	899	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
come oooooooon!! don't take my camel away from me	920	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
i'm planish to get a tattoo of a daut castle in my shoulder... And never finish that tattoo	926	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm so good at reading games and getting lucky	933	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"Good boy, he did not want to take the shot, so now we lame his boar. He needs to pay the price for being nice!"	943	byelo	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Nili i don't want to put pressure on you but I'm casting and you are my main target	952	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
look at me quickwalling like hera. When i grew up i will be like hera	965	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Everytime i promised something i failed... So i won't promise anything	984	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Demo goes Boom! man	1002	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
OHH!!! This is failing tatoh!!! He got more elephants than me... we need new plan tatoh	1016	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"Am I going fast imp?? AM I GOING FAST IMP??? Pfff no.. i'm playing proper game" (daut being sarcastic going fast ip skirms in TG)	1027	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
You have only 4 mangudais man!!! And dany only has 4 camels man... Let me make 4 villagers and then we resign	1035	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
i go die	1042	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
i already met art of troll and reaper irl. So i kinda don't want to know more viewers	1050	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Im to mean to viper? Well someone has to be	1055	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
if only you could use market to buy houses	1065	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Suddenly sending all those forwards vills makes little sense	1073	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I Love F1re man. We even shared bed together... Wasn't a pleasant experience	1078	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"Usually i don't fail those things... They just happend" Daut talking about daut castles	1086	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"I will go to check if there is food at the kitchen" * 1min later * "I just order pizza"	1094	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
not impossible but not possible either	1104	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"I do something... I do nothing"	1114	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I am the best team player you ever saw	1122	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"You were not born when I was microing!" while trying to wall Dobbs in on Arabia	1126	byelo	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
The microphone name is like letters and numbers	1129	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Moo! Moo! Thats why I got new microphone	1130	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
there is no more cursing here, hyuna, so shut the fuck up	1137	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
There is no more cursing here Hyuna so shut the fuck out!	1138	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
well.. you didn't get a daut castle so unsub Kappa	1144	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"Two things you don't do: You don't lame Finns."	583	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Don't get it wrong guys! I'm dead, completely dead... Just want to be annoying before resign	1151	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
dropping a Siege workshop will be a smart move... But dropping a castle would be a cool move!!!	1155	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
this is the biggest bullshit in the game!	1160	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm not trying to pretend to be a nice guy	1161	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"I play low population or purpose, because with more units it's harder avoid the shots"	1166	byelo	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I am not allowed to speak if we played or not. We did not play it	1167	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
green dot is good dot	1170	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I see the green dot! green dot is good dot	1171	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
This is the perfect place for you to ask something serious	1172	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
There are freaking tits all over the map man! i can't focus!!!	1176	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Score says that it's over... But fuck the score man!	1180	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I need to order coffe from the wooman	1181	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I can't read the chat now but i bet you guys are all like "Nooo!! make hussars and you win!! Noo!!!" ... That's not the point! i have to win with jannisary	1182	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
look at them Xing, I will be part of the team I X as well (DauT Xes random spot)	1183	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I was fuck enough before this	1188	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"Look at him trying to micro ships like that! He is cute"	1192	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I don't mind playing boom war	1196	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
How do i communicate when you don't communicate	1200	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
How there is scout inside when scouts are outside	1202	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I like lucky	466	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm good at being evil	656	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
hopefully he stopped queueing villagers	682	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
haha hera snipe man. without even looking.	730	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
You move, I kill!	742	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
You are still an idiot	757	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I have the hill i have all the shit i need	773	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
better be walled cuz revenge is coming	784	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Vanja is like fourteen daddy fourteen!	803	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Seems like it pays off to worke more	828	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
not now! I have my own problems man	870	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I work for microsoft now because we found a bug	900	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Those flower fuckers are holding	921	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
vaaat 11 his army melted! 11 oh boy oh boy we have an epic game	927	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I will show him barracks and market so he has no clue, because I have absolutely no clue what I am doing either	934	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
i will show him market and barrack so he has no clue of what i'm doing... Cuz not even I know what i'm doing	935	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"What the fuck am I doing with those walls? I have no idea what my map looks like!"	944	byelo	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
They way i wall man.. disgusting... But i'm a disgusting human being so let's keep walling	945	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Oh nili nili nili... You can't produce for 2 range with 20 idle dead villagers	953	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Do you think? or do you believe ?	966	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"I will beat him with his weapons!" Daut about to go monks against dracont on arena	1003	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"I hope there is no water" daut luring deers instead of exploring the map in megarandom	1017	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
you spit on those militia and they die	1028	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
i didn't noticed he was castle age cuz i was making fun of you	1036	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
He is making the castle in my castle man	1043	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I destroy him with weaker civ man! i show class	1051	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
oh look look look!!! Evacuation party!	1056	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
OH FUCK!!! Those are tatar xbow on hill man!! they are like mameluks man! they are melting my knights!	1066	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Can i magically afford eagles? ... Seems not.. What magic unit can i afford?	1074	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Glokken I notice you every single time... I just ignore you	1079	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Freaking tati man, he is at restaurant while we are playing	1087	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Let's destroy my wonderful team mates	1095	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
your stick is so big	1105	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm too fast man... Too fast, too stupid	1123	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"This one HP villager is a hero, it's all we nee..." *castle kills Daut's army*	1127	byelo	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I feel like the balance team are a bunch of trolls	1131	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
How do people talk when they don't curse?	1139	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Guard Tower? Skirms? How do you sleep at night.	1145	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Guard towers? Skirms??? How do you sleep at nights ?	1146	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"I would love a castle there, I get the thing I love the most"	1156	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
That was the Jbait of the Jbaits	1162	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm going for the elephant fuckers	1168	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Don't you hate when you are thinking a lot about enemy strategy and they are just doing nothin	1173	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
i see your logic and it's a false logic man! elephat archers are terrible!	1177	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Yeah pity subs.... WE TAKE THOSE!!!	1184	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm pretending to be a good team mate	1189	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
NOO NOO!! DON'T GG BEFORE I FINISHED MY PLAN!!!!	1193	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
My APM is actually good for typing	1201	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm not your debbie man!	1203	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Why i'm trying to save you if you don't give a shit?	1204	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I will smoke sisha and watch	1205	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
*daut checking punishment coins requests* "asssjam request, we will ignore that one"	1206	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
He wanted to wall me in because I’m slow and old	1207	batbeetch	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Don't call my rams fat!	1208	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I have trash units but also i have a trash ally	1209	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
You weren't mine anyway... But I still want you!	1210	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
there are 8 players I don’t read all this. If I wanted to read I would have finished high school	1211	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I miss being higher on the ladder	1212	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
No i don't know what a daut castle is. Never made one of those. But sounds like an amazing thing	476	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I will put baby on webcam after i beat viper in memb's tournament	477	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
you are full of advices viper.. while booming at home	478	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"what the bell man? what the fricking bell"	479	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
if you have your own private island and cant find your sheep, then something is wrong with you.	480	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
man, it's not even my fault making daut mining camps, game works against me	481	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"The oldest trick in the book of how to beat arina clowns" DauT while trushing terror on arena	529	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"I give you the chance! I give you the chance!!" Daut fails the split "He took the chance man"	1213	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
nothing is ever my fault	1214	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
tati man, let's play crazy settings so mbl is forced to cast it.	482	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
My daughter is only learning how to eat and poop man. but she will learn aoe soon	483	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
2k players don't wall man! they believe!	484	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Yes viper... I'm comparing you to jordan... I'm mean both live in germany now	485	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I sent viper back to norway to collect some back from his skill	486	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"My favourite food? Snake meat, haha!"	487	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
What if i surprise him going scouts... Sounds like a suicide to me	488	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I can outmicro 10year olds	489	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
he is getting to that rate when u play mbl daily	490	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
What unit composition should i go for... I know! TCs!!!	491	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
People always find the way to fuck good things	492	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
”I Will never get this deer, this deer is asshole”	493	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"little he knows that I don't micro. I just spam"	494	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"Time for my famous Man-at-arms micro!"	495	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Two farm economy is not enough for villager production, just saying	496	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
do these games ever end? asking for a friend - daut playing BF	497	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Such a defensive trapping fucker man!	498	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Actually let's give viper host. If I'm host game will never start	499	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
MABAO MAN!! MABAO	500	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
We are all turning into MBLs	501	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
and BAM! i defeated them	502	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Mabao? Mabao my ass man! i go BAMbao man! bam bam! First BoomBao then BAMmao	503	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
When does my playstyle makes sense?	504	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
When you get berbers you must play like MBL	505	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
untouched, my ass!	506	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
you give me host, i put an add then end the stream	507	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
oh he picked his color. He is not fucking around	508	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I prefer streaming that been babysitting all night	509	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
My sleep schedule is megarandom again	510	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
asssjam question: "daut when u get a haircut what do you ask for?" I show them a picture of slam and they do their best	511	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Yes! you got scout! you are amazing! Fuck off now!!	512	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I think i will buy myself a one little castle...maybe a one little daut castle	513	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Let's ban that forest pond thing	514	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
We can go for goldrush is kinda regicide	515	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I hate this man i don't have regicide and i don't have mayans	516	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Oh we can give them koreans and when they try to trush we BAM it	517	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Is not bam is is BAM IT! like destroy them	518	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"You may experience some noise in the background" DauT when his kids start to cry	519	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
How is that not a bam?!	1741	51mpnation	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Oh man! dog! baby! BacT color!! what else do i have to deal with	520	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"I ban when i wanna ban!" daut to the admin of two pools tournament	521	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"TC is overrated" daut to slam when slam was losing his only tc to push and daut raiding instead of help him	522	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"This is going to be the best comeback you guys ever saw" daut before dropping a random daut castle dautCastle	523	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
He is trying to honor me with daut castles	524	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"Let's fast forward dark age because i don't want to feel depressed watching my viewers" Daut while casting DCL	525	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
ModeratorVerifiedNightbot: i will lure deers first. if you guys want my scout wait for 10mins	526	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"they didnt know i lost 4vills in dark age" daut during interview after winning ecl	527	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
i will prismata his ass	528	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Respect my tower rush man! don't counter tower	530	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Vaaats wrong with this game today man! everybody is laming something... and that something is me	531	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
At my prime? my prime never ends man	532	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
ok ok i know the map, i have the plan, you are dead	533	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
What are you doing? are you booming like a chicken???	534	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
It's all about lying man. It gets easier every time	535	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"I do nothing and I have time for nothing"	536	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Delete yourself	537	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
who is this player, the fishing ship is my unit, not archer, not mangonel, i play only with fishing ship from now on https://clips.twitch.tv/PolishedJazzyYakCharlieBitMe	538	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Me and JorDan best of 21. loser joins aM! LUL	539	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"I believe in you light fuckers" Daut sending light cavs to kill a group of xbos on his base	540	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
(daut doing dm vs tati) oh, sick I got goths. what civ is tati? oh fuck. it's mirror.	541	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
of course its towerfest man. it's like Oktoberfest but with towers.	542	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
5 is the magic number man. if you have 5 of something man you can fight.	543	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
hera you're welcome in my tc man. this is not aM!	544	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I actually have economy, problem is I have no ally!	545	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I don't click man	546	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
about quickwalling: I wouldn't do it even if I could	547	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
so that's what a daut castle looks like, kind of good when it doesn't happen to me!	548	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"No no You do T90 and i do Memb" Daut casting with Hera	549	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Do you know halberdiers used to no exist	550	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
only thing worse than scheduling with fire is been in same room with fire	551	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Good luck with that man! that's your guy man! i cleaned my guy man, i'm chilling and booming now	552	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"what did we learn last game guys?"	553	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Feed my kids with blood of my enemies? i'm not raising mosquitoes here man	554	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I have style man	555	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I don't need to make tower! i'm beast	556	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
guard it man! guard it with your life!	557	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"How did guy entered to my game? he is not supposed to be in my game" Daut being raided by the other pocket	558	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Probably boars are hosting their own talk show to make fun of us	559	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"why is he talking like Yoda man, berbers is he.. OH FUCK WHAT?" Daut talking random stuff when suddenly boar kill his villager	560	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Maybe i should start respecting people	561	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
this is disaster man	562	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Hera is young slam, not invited	563	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"there are better ways to balance than to just remove" also daut, "remove bbts"	564	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
let's prepare some shit for today for tomorrow	565	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
let's go genitours man, oh fuck he's going knights. he is going everything I don't want him to go!	566	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I believe in you boys, let's fight! why aren't you fighting man? we are gonna have a talk after this game!	567	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
making jordan die on tg is always something special	568	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
not losing a single vill to boar. that's what i call a good start	569	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
If i only had ballista elephants	570	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
fuck it man, I'm not booming. 5 relics is my boom!	571	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
5 relics is my boom	572	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I go unit that doesn't require micro	573	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I hear baby crying but I dont think it's my baby!	574	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
i know my baby screams man they are louder	576	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I like sasha grey cuz the name reminds me the sisha man! sasha, sisha	578	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I think Hyuna is the biggest pervert in my chat	579	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"First he joins aM, but if he is a normal person, he will join Secret" Daut talking of Mini-Daut.	580	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
nomad is the best fricking game in the map	581	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
do i need to mangonel his ass?	584	trollabot	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Maybe if you were a dog i would kick you out Viper	597	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I will be sleeping around	657	byelo	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
fishing’s ships cannot go in tower!	683	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
idk where is my scout. must be scouting	684	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
BOOM! Nothing sexier than that, not even your camels	731	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Mbl? did you really fuck yourself at the gym?	743	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I don't want to share that information	758	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
ok ok for that now you deserve another castle in your face	785	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
My gameplan is he not looking... Is a really good gameplan	804	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
i'm full fighting against my own dark age and he comes and do this....	871	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
i hope 2TC start maps never become meta	901	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Now that my friend mangonel is here! not more fucking around!!	936	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
ok fire, We as Team Secret can make a sacrifice for you and give you nili for BoA2	946	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Maybe i go to hard on nili. But then again now he will invite me to NAC4	954	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Who needs food.. I got imp	1004	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
And people will play for 2 weeks just to give you feedback nili... yeah .. sure	1018	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
You didn't have to help me, you wanted to help me	1029	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"if we both are pockets viper, and daniel is flank, we win!" daut after losing a few 3v3s with daniel pocket	1037	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"if only i had an ally... or two..." Daut playing 3v3 with aM	1044	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
i didn't made a single farm and that's usually a sign of bad economy	1052	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
You can not block without fishing ships	1057	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Patrol, TC, farm	1067	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I wish I could shift click my kids to get them to do what I tell them to do	1075	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
And now the battle of bad lumbercamps and shity woodlines	1080	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Those ar cap freaking rams man!!!!!!!!	1088	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
what? That's one nothing man, you are fine!	1096	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I should be forbidden to micro	1106	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
never allow me to micro again	1107	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I will get her, I alway get the woman	1124	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"My best hope is him misclicking. Misclick something, man!"	1128	byelo	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Hah! We stomp on that camel	1169	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Those guys are like trebs that always miss	1215	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I am a boomer man! I am a boomer in my heart! Once boomer, forever boomer	1216	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
He does nothing man hahaha... Kill him!!!	1217	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
oh there is a fake daut account on twitter? I hope he is at least posting when i go live	1218	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
go away! Komodo beast	1219	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I have zero food income right now, usually not good	1220	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
my population is out... and we don't want daut to be out	1221	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
deploy there you fucks!	1222	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I am a simple person. I run over the rocket guy, and I laugh	1223	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Daut showing his daughter on stream* "Well time for her to leave and for sisha to enter"	1224	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
let's all pretend we hear what carlos is saying	1225	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
at the start we have 3 villagers and that was his peak for him. the best he did in the game	1226	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"we all had 3 vils at the start, and that was his highlight. it only wend donwhill form there"	1227	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
zuviss not a single fuck given 1111111111	1228	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm not late. i have 3minutes	1229	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
zekleinhammer has a better economy than me	1230	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I feel dead all over again, it's like nobody cares about me	1231	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"Roxy is more manly than you" Daut to Hera	1232	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I lost all my pride when i put my family on stream.. that ship is sailed man!	1233	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
You got outboomed bitch!	1234	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"I'm a simple guy: I see Slavs, I make hourses, man!"	1235	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Sheep are okay, boars are friendly but deers are assholes	1236	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Nothing is ban when i'm losing	1237	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
We go casual	1238	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
if I lose to dracont i will lose my life	1239	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm king of nothing man	1240	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
draft is too complicated even for the programers that make it	1241	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Full archers agains skirms... what can go wrong? .... EXACTLY!!	1242	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
hyuna you know stuff, how can you be such a pleb in the game!	1243	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
This is fucking Asterix & Obelix	1244	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
first it was the Ha Ha! and now it's not the Ha Ha! Now it's a Hehe!	1245	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I hate reading	1246	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Play arena and shut up!	2173	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I go for the 5 tc boom, he goes for the 5 tc boom, let the better boomer win	1247	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
This is it! He goes for 5tc boom, I go for 5tc boom! and let the better boomer win	1248	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"not sure if that's a good strategy"Daut when chat asked him to go persian douche on arena	1249	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
the problem with skirms is you need a lot of them to be efficient, and they're still not efficient	1250	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"say what you want about my micro but that was not my fault! (DauT when he tried to quickwall on arena with DE lagspike)	1251	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"This is coaching stream and i'm getting schooled''	1252	fatrhyme	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm still recovering from that shot in my face	1253	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"When i play sub war vs tatoh i get deagle man! but now that i want to do something with my life i get freaking professionals!" daut playing 1v3 with viewers	1254	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"It's not cheating if it works"	1255	fatrhyme	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"This is helpful man" Daut playing art of war	1256	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I never listen to what I am told I do an easier way	1257	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Look at tatoh man! Alway looking for an unfair lead!	1258	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
we need art of war for pushing deers as well	1259	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Too many people in my head	1260	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
everybody matters, thank you for exisiting!	1261	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I wanted to do horse collar but didn't have the res so fuck it! i went towers and castles	1262	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
the score says that he is pushing deers or maybe i'm just much better player	1263	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
No quickwalls but quick deaths	1264	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"No quickwalls but quick deaths!"	1265	fatrhyme	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I think there are 2 cows somewhere on the map laughing at me	1266	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"somewhere in the map there is two cows laughing at me right now"	1267	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"Look at me. I'm liereyy, I'm 12 years old and I micro"	1268	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I am housed man, kill something!	1269	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm moving out now, fuck this!	1270	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
The range of those things, they are hitting me from another game!	1271	batbeetch	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Cya slamm. Ggs. Im going to fucking sleep	1272	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"I used to have trebs, I used to have everything!"	1273	byelo	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
my chat makes perfect sense. Always!	1274	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Everything went wrong for you. vills dying, archers attacking walls, we take those	1275	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
This civ is good against everything. Or maybe i am good against everything	1276	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
oh cmon, I don't have loom, danny boy you asshole	1277	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I will be Viper now	1278	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
he stole my boar I steal his units	1279	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"He is so wall in and so scared!"	1280	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
it looks look i'm trolling, but i'm not, i'm just dying	1281	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
outposts are so nice! you make them, then you know you are dead	1282	deagle2511	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
he obviously has the slight lead here, which is quite big	1283	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I delete but I did not shoot	1350	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
what do you do when you're housed as Chinese? I guess build a house.	1284	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
look at Hyuna man. Getting rejected by imaginary girlfriend. At least you have a realistic imagination.	1285	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Now i don't have hole when i need a hole!	1286	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Daut castles in every single game man! If i play tetris I will get a daut castle!	1287	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
don't treat me like jordan you assholes	1288	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
4v4 DM is actually fun. you don't know what's happening! .. I guess RM is fun for nili too	1289	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
This makes no sense man! i make units he make units but my units die!	1290	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
My aim here is worst than in fortnite	1291	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
inquisition my ass!	1292	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I would fuse with liereyy man. I would be younger. I can micro. If I fuse with F1Re I'll be like Fat Goku.	1293	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Okay we both die! ... But i die more	1294	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm mastering the new technique here... i called being mbl	1295	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I am aggressive guy... I am STUPID guy!	1296	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
he knows he needs to boom, and he will freaking boom. I respect that	1297	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm like Jon Snow now.... I know nothing	1298	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Just fight and lose so we continue playing!	1299	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm just lazy... But i will fix that... When i get less lazy	1300	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Dark age is really stressful for me	1301	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I need castle age ram i mean imperial castle age	1302	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
do you think im shitting stone here or what?	1303	artofthetroll	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I was repairing with my life, and I dont have life anymore.	1304	artofthetroll	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"are you dead?" Daut cuz tatoh was talking nonsense	1305	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
the chat knows man... everybody is trolling me	1306	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Spliting like a beast, dying like a hero	1307	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Where i am building the castle? Where??? where i shouldn't build a castle! there is where i'm building a castle	1308	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"Well Thanks you chrazini! for the little fish on new migration!" (chrazini has nothing to do with the balance of standard maps)	1309	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Trading points is not cheating if it is to remove mbl from rank1	1310	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
construyer the tower in your face	1311	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
He can switch into monks now... Or maybe his favourite unit: The walls	1312	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Hera: what are you goals? DauT: five more years of doing nothing and then retire	1313	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Drafts are still happening cuz is 1h of free content for the casters	1314	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
wanna be my seedie buddy?	1315	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
So MBL is like tic tac tic tac	1316	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Nili is not improving man, you coaching was useless! i didn't see any type of improvement	1317	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
daut to hera: your coaching is oh you lose three villagers thats bad	1318	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
You can do 3 tc or 1 tc or delete your tc. i don't mind	1319	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Now that everybody is in post imperial age you are acting like the cool guy? the cool train is gone	1320	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I delete this, i delete TC, I delete both of them	1321	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"Well, another stupid game again" daut after winning with civ advantage	1322	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
If I see Jordan above me I will go back to hospital	1323	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
if I see JorDan above me. I'll go back to hospital	1324	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I took one game from the hera, viper couldn't even do that and he plays everyday	1325	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I am happy I am not dead as well	1326	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"did the doctors ever PETTHEDAUT" ? "No. But nurses did" dautPrincess	1327	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
thought those monks were petards	1328	dfear	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
why they make sound when you are not touching them?	1329	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
you would think its not possible to be that stupid	1330	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
on socotra there are no nice guys	1331	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I see your economy, i don't like your economy	1332	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Tatoh, thank you for corona!	1333	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
He got hole I just get in from the inside	1334	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I can be 10 years old as well	1335	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
it doesn't get as fatter and lower than this	1336	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Man idk MBL probably even makes the sex boring	1337	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
What's the range of this magical tower?	1338	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Yeah tower, mining camp, dominate! We have the plan	1339	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I don’t need spearman...and I can’t afford it	1340	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Everything i want fails...	1341	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Time to show chris what i learn from blocking!	1342	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I feel that my economy will be like nili's soon enough	1343	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
MBL is practicing with me and I got Nicov in first round... That's a solid team mate	1344	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
how much is sponsor paying us? NOT ENOUGH MAN!!	1345	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"I was not planning to use those anyway" - DuaT after many xbow are killed by a mangonel	1346	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
There goes my pride... Hope i'm exchanging it for the win	1347	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm running out of gold but still can deliver the castles	1348	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I won't add more TCs... that would be cheating	1349	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
game gives me a free deer and I fail to take it	1351	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
He may think i will go mangudai... But he sees I'm not in stone... But still he is not the smartest player	1352	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm keeping it real man... Losing every tournament I play... NO!! EVEN LOSING THE SCOUT NOW! NOOO!!	1353	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
tala this one, man!	1354	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I got sponsorship but I refuse it	1355	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
She knows only what I tell her	1356	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
It would be good if you have won the RB viper and have the money to put in that wallet	1357	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I signed up the contract but didn't read it, so I just hope I don't get scammed	1358	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
You have the extra armor on your women	1359	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
What?! Why you move out man! You are behind you should stay home! Ohh that hurts... It's hard to play against players who doesn't understand the game man	1360	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"you want to be be new MBL when you grow up ?"	1361	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I did micro enough for today	1362	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"I Absolutely don't care about your problems" daut playing 2v2s with viper	1363	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
It can be bad but It can be really bad	1364	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
yeah defensive castle was an option but i like it on enemys face	1365	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Freaking Tati man... I have one girl at home, i don't need two	1366	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
That's why you wanted to be a ballista elephant when you grow up	1367	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"This is like TTF Racing man" Daut playing Fall Guys	1368	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm Like Flying	1369	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
The problem is that others don't understand the game	1370	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Ok Jordan you queue up for age of empires. i will beat you there and this game at the same time	1371	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Once you start failing it never stops	1372	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
call me a zero conversions DauT	1373	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
1 for 1 is fine... That's the maximum of my micro	1374	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
houses are for people to live, not for being part of a wall	1375	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
People is always rushing man, rushing here, rushing there... Why we can't just chill	1376	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm back! Playing stupid and win!	1377	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
the plan is to die, and the game is going according to plan right now	1378	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
everything that's cool is now gone. even soon I will be gone too.	1379	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I rather lose than don't respect myself	1380	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Yeah Fire is high rank for some reason. I don't know from where he gets the points	1381	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
when they wait, it's never good	1382	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I cannot even manage myself	1383	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Viper does a lot of things! Talks to people and ask us then we never reply	1384	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
If he counter attack i will hate him a lot	1385	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Tower is gonna fall and my castle will rise again	1386	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
That's tha speed! of tha beast!!!	1387	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
He is not microing that well... compared to me	1388	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I counter nothing with my counter unit	1389	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"I don't have loom, But i believe! I know you guys believe in me and I believe in me so let's do it!" Daut going for the forward castle in arena	1390	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Axes? why the fuck not. they throw things	1391	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Is so much easier when you don't fail	1392	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Well you were bald at 25 years old	1393	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Will I go yolo? The answer is... Hell yeah!	1394	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Against Rubenstock you can't have a proper game. He is like better hoang	1395	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"HA HA HAAAA!!! I love when that doesn't happens to me" Daut accidentally killing enemy mangonel while attacking TC	1396	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
We need a lag tournament!	1397	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
ohh baby is back, they were out... I guess i will have to stream until the got to sleep	1398	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
And this wolf probably killed 5 of my units so far	1399	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
When i was number one lierey wasn't even planned	1400	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I will lock up my son in a room with only water food and aoe4	1401	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I hope my son calls lierey grandpa and makes fun of him like "oh grandpa grandpa, you can't even quickwall"	1402	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"This is the style of a winner!"	1403	artofthetroll	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
that castle will put him back to the Kindergarten	1404	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
This castle will put him back to the kindergarden	1405	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Do you guys saw Kotd map? Bad things can happen... Hopefully not to me	1406	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
There is space for you fat fuck!	1407	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Bam! and one more! and get the fuck out!!!!!	1408	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
That's a double fuck for him	1409	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
guys shoot you fucks. you think you're liereyy or something?	1410	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
hyuna I'm not gonna ignore you next meetup. I'm gonna hug you. kiss you and give you my corona. then we can be even!	1411	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
ooh snapchat? full edie style, when we hit 1 million subs we hit full sellout style! we have the plan!	1412	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Tatoh is all about timings and pressure... i want to boom man!	1413	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
ohh that'sa a hoang! that's a hoang in my face man!	1414	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I found a girlfriend	1548	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"You know me guys, there is no plan B, tha castle is going up!" daut sending 20 more vills to finnish a daut castle	1415	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I like to stream naked	1416	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Why no cam on? I Like to stream naked	1417	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
if organ guns cannot counter goths than just remove them from the game.	1418	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
one gold, one FRICKING gold	1419	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
What should i do now? fast imp? Believe really hard? Probably believing really hard is the only choice	1420	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"slam go host drafting man!" daut avoiding responsibilities on the 2v2 tournament	1421	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
!addQuote Fuck this! I'm picking koreans! they are fun!	1422	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Amazing noises you put out of your mouth!	1423	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
If I open the door... Can I lose the game? ... Let's see	1424	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Call me surprised, but I... I'm surprised.	1425	artofthetroll	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
patrol is never enough these days	1426	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I want viper to win but I want him to struggle! like winning but 3-2 or something	1427	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Is all about the business here!	1428	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
And again teleportation man!	1429	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
it looks like a disrespect for the tourney because it is	1430	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"Man. they are wasteing our time!" daut being the only one ready in the gameroom	1431	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Man! why they dont start! i want to wall already	1432	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"dont think dont think! just play" daut to slam on 2v2 tournament	1433	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
May be i should use my twitter to retwit vipers twits	1434	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Don't worry i will lose all the archers before imp	1435	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Arabia with snow? I guess global warming did hit age of empires 2	1436	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I have villagers. When you have villagers you can't lose the game	1437	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Some people should not be allowed to sleep at night	1438	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Either I'm beastly or slam is not	1439	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"Come on... You have a boomy civ.. Do what your civ told you"	1440	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"What's a game without a DauT castle?"	1441	byelo	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Did he found the magical gold?	1442	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I can never stop a man from dancing. Not that kind of person.	1443	artofthetroll	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Actually is already 3am. May be it's my bed time	1444	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm not even lazy this week. Day is too short	1445	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I don't care that heavily that i won't even do loom	1446	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm not a good influence for the young people	1447	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm not stupid if I am doing it on purpose	1448	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Score is close. I hope that it's because we are good friends	1449	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm old and stupid let's not forget about that	1450	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I need to have an intervention about my castles	1451	artofthetroll	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
daut to hyuna: go watch viper. i forgive you for being traitor	1452	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
do you like those farms better. is it pretty enough for you?	1453	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
muss man! we need a new mascot. jordan is playing good now so we need a new one	1454	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"What you need to do here is click patrol, click here and you win the game" Daut coaching a sub	1455	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Next subwars I will need new viewers	1456	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
that ostrich scared me	1457	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
don't call lamers filthy. they are worse than filthy	1458	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
he thinks my micro is a meme or something	1459	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"He's just repairing man. He's such a repairing machine."	1460	artofthetroll	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
shift click that shit out of my game!	1461	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I want to be dominated	1462	artofthetroll	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
villagers are useless unit	1463	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
4 tc boom? why not make it 5?	1464	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
don't compare me to mbl but I agree	1465	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
do I look scary to you? Do I?	1466	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I will forward you to riut, you can obviously check mbl, he is amazing player, but riut is better	1467	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"4 villagers on farms and we are going Champions!"	1468	artofthetroll	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
you are a traitor and I am a woman	1469	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
that mining camp is invisible	1470	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"should I boom or should I DauT castle him?"	1471	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
my wall deserves to be tickled man	1472	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
flies are like f1re they are annoying	1473	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Why did the bulgarian happy music stop there? ... I liked it!	1474	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"ahhgg villeeese.... You used to be cool... Now you are just like everyone else..." Daut cuz villese denied his dautKrepost	1475	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
He is probably thinking "oh daut, don't you know you don't have crossbow with this civ?" I Know i have no crossbow but i have other things	1476	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
When you go for a daut castle you enjoy, you laugh and you go for a new game	1477	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Oh he is franks and I'm indians, he might think my civ hard counter his civ... Little does he know that I'm going elephant archers	1478	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Time for the double, triple... 4 tiles of palisade walls and enjoy the life	1479	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Ohhh You are playing a little bit of arena yourself, Mr I hate arena	1480	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
U just patrol in until you win	1616	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"you think you're cool because you can micro? i can't... and i think i'm cool"	1481	artofthetroll	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
When you have gold, you have everything... That's how this game works	1482	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Worst case scenario actually is all my units getting converted	1483	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Feitorias are your friend. If you don't have any friend, just make feitoria	1484	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
We are so close that forward thingies are his thingies	1485	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"This is my cow now? Ofc it is! I found it!" Daut stealing enemy cow	1486	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
he doesn't know about this castle, we are both friends here!	1487	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
he is building the castle with 1 villager! I respect that!	1488	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
jsut been there looking the fight is enough micro	1489	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm going blind hoang style... I don't even know where to attack.. I just want to attack	1490	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
oh.. raiding fuck! How did you get here?	1491	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Any game with a daut castle is an amazing game	1492	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I am not the best at quickwalling, believe it or not	1493	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm too nice for my own good	1494	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm a hard working man all over the place	1495	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I think you should hit everything without ballistics and with ballistics even more	1496	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
It has to be me failing for you to be smart	1497	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
My Knights make weird dying noises	1498	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Counter attack me??? Is that the way you want your kids to remember you??? COUNTER ATTACKS???	1499	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I would say they clean this shit up... But I don't want my kids to remember me like that, so I will just say I won this fight	1500	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"I feel its a fake nice but we take those"	1501	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
the best way to sum it up is oh fuck	1502	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I dont want to chat with ghosts im scared of the ghosts!	1503	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Sorry for my language	1504	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
At least I cannot die when I'm dead	1505	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I don't trust girls	1506	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Screw the tasks! I'm alive! (Daut playing Among Us)	1507	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I will promise you and it will never happen. Got to stay consistent	1508	deagle2511	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Vat? Viper was in chat? well I was busy dying!	1509	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
So many voices in my head	1510	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm not afk, I'm always afk	1511	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
VIPER!!! I overrate your brain! you stupid fuck!!!	1512	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I will pretend to be a snowman	1513	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
farms are units	1514	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
What do I think of viper civ picks? That he is an idiot	1515	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"Or he shit his pants when he saw he was against me. That makes sense too."	1516	byelo	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
He paused now to go to the bathroom? Probably he saw he is facing me and shitted his pants	1517	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I fail. I fail with micro. Believe it or not	1518	deagle2511	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm too fast for this game!	1519	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I didn't want to delete scout! I wanted to delete wall!!! dautPickle	1520	deagle2511	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
How did he smell it! He got a strong sense of smell there	1521	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
On the bright side there is no bright side	1522	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Double mining camp, zero tower aggression... That's every man's dream	1523	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
poke something! you poking fucks	1524	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
shut up and take my points	1525	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Derp man! Thanks for the 39months resub... still waiting for your game review?	1526	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I tend to be a lazy player	1527	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"im here to be bought"	1528	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I will show him a micro that he will never forget	1529	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
If I wasn't such a fast player I would be in troubles right now	1530	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Oh man I did all that and didn't delete a single villager! (Daut after deleting quickwalls on his woodline)	1531	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Zebra is even blocking my micro	1532	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
that zebra is bigger traitor than hyuna	1533	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Man this was embarrassing... I will have to delete VOD after this	1534	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Is hard to keep the energy of lying all the time	1535	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm like un-gate-able	1536	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Let's see if we can hoang out of this	1537	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
This strategy is actually shit	1538	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
What's best advice I can give to a 2k player? Never get married	1539	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Why is my rank going down so fast? well... i basically don't give a shit	1540	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Well rank is good for tournament seeding but I always get to play Nicov anyway	1541	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
We found game fast so must be a really good player *game starts* oh is not a really good player, is mbl	1542	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Why karma hits me now?	1543	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I wish to have students to paly with	1544	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
And what do you know? Is a kip motherfucker chak	1545	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Where is my treb... My only friend in this game	1546	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I would X the shit out of that	1808	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I just wanted to press the button, it's so big and red	1547	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
its like going scouts as britons and expecting skirms. it makes no sense and it's no intel!	1549	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I don't trust her and her one-eyed dog	1550	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
take a picture of my ass man. look at the picture!	1551	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
get your monk ass out of there	1552	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
and for the final i will need ultra instinct	1553	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
hello my stupid friend we are both stupid	1554	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Is okay i believe in musss, he is too stupid to lie	1555	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Yeah you are dead now, but sometimes you are not dead	1556	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Just look at the mangonel... looking sus	1557	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm maybe 35 but I'm still an idiot	1558	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
if I reach finals I will be so happy and then threw the finals	1559	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"There is a limit to my powers man!" Daut while microing	1560	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Ok slam, now I'm in your timezone so better be careful!	1561	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Was this greedy, or stupid?	1562	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
when I remember that villager it will be like skeleton	1563	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
If i cast i will be like "ohh hahaha look at tatoh losing scout to tc what a pleb" instead of casting	1564	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I don't full wall in the kotd but here I even stone wall... priorities man!	1565	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
He is top score and i'm not? vaat? what does he know that i don't ?	1566	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I bet you guys never saw walls like that	1567	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
BAM and... GG. It was a gg bam	1568	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"How much do you need to scroll to find this poor fucker?" daut searching for jordan on the ladder	1569	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"come on spanish vills you have blood of the tatoh"	1570	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
should I kill smarthy? does she deserve to die? yes she does	1571	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I can hide here in the darkness in the corner no one will notice me anyhow	1572	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
are those orjan guns? They are bad in every game	1573	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"This is very deep in the night for me" daut at 11am	1574	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
camera shake? pft, I don't want camera to shake with me - Daut playing AoE3	1575	goldeneye_	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Do i have pets? yes, viper. is a snake. i call it baldy	1576	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
oh this civ is like Burmese I see everything. (DauT playing Inca in Age3)	1577	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I have fat llamas! come here you fat llamas.	1578	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
What do I think of viper getting dominated by yo? .. well is not the first time	1579	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"You guys that know all the cards and the game... come queue up and play!" Daut to the caht on aoe3 stream	1580	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
This was almost as quick as mrYo vs Viper	1581	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Everything on this game is like "who cares" Best game ever	1582	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
We have the plan: Go up, and destroy! The important part is Destroy!	1583	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
When you play against robo, the counters doesnt exist	1584	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I mean I'm playing against robo! Losing is not an option	1585	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Panda! I don’t wanna kill a panda, not even for 55 gold dautLove	1586	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
je suis, my ass, man!	1587	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Is this a good fight for me? My units look way cooler	1588	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I was waiting whole game to raid there but now i don't want to	1589	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
The build is not good, the build is not good... But the player is amazing! so we will make it work!	1590	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Ok guys, you better kill all that without him noticing	1591	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I create the wood, man	1592	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Man the fights look much more better when i mix army... I'm done with mixing army, time for full cavalry!	1593	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
this is the game! they don't know me so they talk trash to me!	1594	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"That means you are worse than trash" daut after beating a guy that called him trash	1595	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"this is better than kotd, no one enjoys that" Daut streaming aoe3	1596	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
chargez his ass	1597	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
a man, a goat and a monkey. what the fuck is that army?	1598	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
welcome to the chargez	1599	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
why my villagers are not dancing?	1600	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Lets go forward! it will be magical! trust me	1601	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
my dogs will eat him alive!	1602	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I always listen to my chat... but dont read it	1603	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
it costed me a little bit of my soul but i win!	1604	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Yeah I'm going off. Goodbye fucker!	1605	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"A nice fucker here!" daut when the opponent told him it was an honor to face him	1606	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm such a bad treasure hunter!	1607	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
thank you man for making my life unhealthy I appreciate that	1608	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
he knows the modern micro	1609	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
He is expecting tech switch... little does he know	1610	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
get yourself your own llamas!	1611	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I love Russians!	1612	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I want to make top 50. If nili can do that in aoe2 I can do that in any game	1613	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
It is hard to click on that small cat	1614	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Even the halbs are like petting them gently	1615	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
hyuna welcome to the covid club	1617	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
We are not team playing the treasures man!	1618	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Yeah he is smart and you are stupid. This is how the game works	1619	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm unreasonable good	1620	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
So you are useless, that's what you are telling to me	1621	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I made mistake by trusting you	1622	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
You were all the game like oh help me daut help me daut	1623	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Our army composition is playing alone	1624	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
That's your counter attack? that's a pathetic counter attack man!	1625	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I know why u take so long on the bathroom viper, the doctor did you some things	1626	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
You are like talking shit and doing shit!	1627	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I won't even check enemy civ. I'm just doing my plan here	1628	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I did said i don't want double stable but i lied! I want double stable	1629	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Can you please stop running away and just die?	1630	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I should have deleted some units in that fight to give you hope	1631	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"You are not fun you are easy easy to kill" Daut playing aoe3 1v1s against viper	1632	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
You don't enjoy bush?	1633	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
You make the units, you kill the stuff, make a bit of economy, lose tournaments	1634	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm viper, I'm yellow and I have a viking hat!	1635	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm always weird	1636	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
camaaan you are stronger than cats	1637	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Yeah i was slow at ageing but not in real life	1638	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Oh you know that my army is not there and you give a single fuck about that	1639	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm cool, I'm powerful	1640	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"You need to lose some points and get weaker opponents and send them where they belong" daut getting viper on the ladder	1641	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"His clan name is washed up? VAT? They are taking our memes man!" daut playing aoe3	1642	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
You guys that don't know eddie are missing a lot	1643	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I was like "ah haha! look at those mustaches" and now I'm dead	1644	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Why I'm asking if I can't even read the chat	1645	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Screw you viper! just Queue up again	1646	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I will trust you more than the sheep guy	1647	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Why are you guys so happy? We are losing this game! Don't get happy for our loss	1648	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"This must be how nili feels" daut after losing a few aoe3 games in a row	1649	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Stop saying you played competitively matt! someone may believe it!	1650	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Voices out of my head! Feels good to mute!	1651	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Oh he stomped my ass	1652	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"Oh... food is in the oven and i can't pause!" daut not knowing aoe3 pause hotkey	1653	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I will turn them into man at arms... ohh noo i will turn them into nothing! I will turn them into graveyard....	1654	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Do I take his castle and end the game... sounds like an awful idea	1655	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Yeah i tend to lie	1656	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
you make a castle, I make a castle	1657	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
You look at my castles and gameplay and you feel better about yourself	1658	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
they are not even dying man!	1659	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
GG... The timeline will be embarrassing here...	1660	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Those look cool. They look like a happy group of people	1661	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Welcome to the third stream of the day	1662	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
you got to play mandinkas man. your dream came true. living the life.	1663	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
thats a fun fact. I am a fricking idiot!	1664	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I don't like him. He is mean to me	1665	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Hello and welcome to aoe3, The community that respects me	1666	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
cannot wait to get raided to death on that side as well	1667	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
The only good thing about corona being around is that we do not meet again	1668	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Every wall needs a hole	1669	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I remember to ask pro players 20 years ago like a little pleb "oh is that the best strategy?"	1670	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"Derp is just playing arena, no ones wants to see that" Daut ignoring Derp recorded game review for months already	1671	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm nothing if I'm not a castle builder	1672	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I hope he will push me and beat me	1673	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
OHHH!!! HE GOT ANSWERS FOR EVERYTHING!!!!	1674	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I don't care if it cost me the game! I WANT MY CASTLE THERE!	1675	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I was just trying to be nice, F1re, I don't want to play with you	1676	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I was trying to be nice with you Fire! I don't want 2v2s with you!	1677	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Boars against me micro like lierey	1678	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Playing TGs with Fire is him thanking subs in portuguese while not muting	1679	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Welcome to the arena player	1680	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
He tries to convert me and then magic happens	1681	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"Well maybe he doesn't notice this" Daut sending 3 battering rams agains a castle in the middle of enemy economy	1682	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
What is worst? Losing to chris or to jordan?	1683	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"I have no friends, you guys are all i have" Daut to the chat	1684	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I would do that, win a few millions a go live at the countryside. Not giving a single fuck	1685	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Lierey trusts me with his life man! That's respect!	1686	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I feel like viper! Only he dies so fast	1687	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
not doing anything is the micro! Predict that!	1688	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Did i just lose everything there? Nevermind they died by themselves... Not my fault	1689	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
He has more man at arms, but mine are cheaper... and cooler	1690	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
He is abusing market to create militia man! Only hoang does that	1691	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
He doesnt create vills? I dont create vills! Who does he think he is?	1692	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"Lierey is outmicroing me even through the chat" Daut cuz his boar went back while reading lierey on his twitch chat	1693	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"No no no no we stay there together forever and ever! You are my boyfriend now! You don't dare leaving me!" Daut after trapping whole enemy army	1694	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Usually when the plan starts with "I hope" the plan is hopeless	1695	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
He doesn't boom like me, my economy is cooler	1696	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"What do i do with my monks now?... He doesn't think of me" Daut cuz enemy switched to full light cavs	1697	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Do i buy my way up to imp and say "surprise motherfucker?	1698	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I enjoy having TCs	1699	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"We can talk about that, and discuss it" daut dening enemy castle	1700	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Lure me like a pig!	1701	artofthetroll	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
scouting bad against mbl who I just lamed last game... Not good!	1702	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
this must have been the longest conversion in the history of converts	1703	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Not going up... I'm going down	1704	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I dont have the numbers, I dont have economy... I just have idea	1705	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Jaguars make very little sense her but i will made them	1706	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
There is no problems when u have a castle	1707	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Rams are cool but they can't cut down trees	1708	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Let's enjoy the fight and type gg	1709	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I show that house who is the boss! Now let's do something	1710	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"Did they hire nili to write those tips or what?" daut reading the random advices from the game in the loading screen	1711	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Everywhere I look I see a dead vill	1712	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
look guys! 2 food saved! Is all about those economy tricks	1713	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"Aren't you supposed to be smarter than knights?" Daut to his light cavs	1714	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I don't see ding ding	1715	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Get TC get everything! BAM BAM BAM! oh no no don't take my own units! That's not everything	1716	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I scout everything and I see nothing	1717	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I don't even want to brag about that, just another day in the work	1718	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm definitely not a smooth clicker	1719	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I don't want to resign against him! I can't take another defeat!	1720	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"Maybe is time to take a small break from aoe"	1721	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"I can cut trees so... Why would i boom if i could cut trees" Daut going 1TC ballista elephants	1722	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
This guy is not 1k8! He is palying better than fire	1723	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
No no, I always boom but especially when my teammates are dying!	1724	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm hoanging the honag man! Let's see how he likes it!	1725	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I really like losing. gives me motivation	1726	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
You wont lose today lierey! You will learn! you will learn who is the better player	1727	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm just promising something that will never happen	1728	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I have more problems vs 1800 elo players than vs 2k3	1729	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
And you guys ask for a daut castle? This is a little preview	1730	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Why they do design maps like that man? Just to annoy me!	1731	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"It seems like lierey left us... Left us with all his points!!!" Daut after 4-1 ing the kid	1732	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Scared of the better unit? Or the better player?	1733	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Ok guys I gonna end the stream now, instead of watching other stream watch my VOD from earlier	1734	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"AH! jordan.... I'm hitting rock bottom" daut getting matched with jordan in 1v1 instead of lierey	1735	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"I'm ain't scare of a jordan man!" daut sending a vill alone to wall far away	1736	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
You are fucking up with me now! arent you little fuck	1737	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
we will chase him, we will find hime and we will have a feast on his blood	1738	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
*chat asks daut to check for a hole* daut: "it could be a hole but i wont check. if it happens it happens! it would be destiny!"	1739	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
That's my game plan right now. He sees my barracks and doesn't know he can make Cataphracts [on TheMax].	1740	51mpnation	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I don't know what my title says but is all a lie	1742	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I guess they are dead but... Where are the bodies then???	1743	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Civ win is still a win!	1744	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"He tried to outsmart me, but I'm not smart at all!"	1745	byelo	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"This woodline! Even my woodlines got holes, man! And people ask me why I don't wall!"	1746	byelo	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm getting less happy man	1747	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Bombard cannon goes boom! And we can resign	1748	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Nobody deserves to be Krepost rushed	1749	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
uh no! agrr ahhrr grwr... I do sounds for living	1750	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Get comfortable around there woman	1751	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
It's more fun with a market.	1752	51mpnation	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
That beautiful son of a bitch man! Look at him!	1753	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm drinking and having a feast here while playing! Next game will be higher quality I promise!	1754	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Probably we have an easy team wall with villese... But he beat me on kotd, he doesn't deserve to be with me, let him die outside	1755	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I was thinking we got TG we are chil... No one is chill anymore	1756	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I AM A GOD!	1757	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
The game doesn't allow me to be cool basically	1758	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I did asked who wins cataphracts or elephants... but now i don't want to know! Let it be a mystery!!	1759	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Daut to Jordan in hamburg "Jordan you are wasting your time working! come play videogames"	1760	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"Oh jordan you are so lucky" daut when they start TG and he is jordan's pocket	1761	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Im here to chill, boom, make imp units and patrol	1762	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Jordan or Nili I dont know who i make more fun off on my stream	1763	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Cuman scout, faster than an arrow	1764	51mpnation	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I need to record my voice and put it on my room so my family thinks I'm working so then i can go sleep	1765	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Ok guys i have to go and spend some "quality time" with my family	1766	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I am not the guy who traps - I am the guy who gets trapped	1767	goldeneye_	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Am I booming at home at least?	1768	51mpnation	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"You lose the army, I lose the game!"	1769	byelo	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
If I wanted to suffer, I'd be playing with my kids right now	1770	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"Pffft, I don't like right clicking you!" DauT to Viper.	1771	byelo	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Viper: "Dock the right corner, DauT!" DauT "What, I am not docking! Why would I dock!" #JustNomadThings	1772	byelo	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
If he converts me I go to the winning team	1773	artofthetroll	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
even if I played tetris they would still wall against me man	1774	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
he probably thinks I’m outbooming him... maybe I am: DauT with 0 on food	1775	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
you don’t want to see my fat ass	1776	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I don't even know what VPN does, man!	1777	artofthetroll	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
resolution for new year: learn to push deers	1778	deagle2511	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
How to test the map that nobody wants to play?	1779	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
poke it poke it, pokemon! (daut trying to get a spearmen to stab a scout)	1780	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
To be a good caster you need to know very little about the game	1781	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"People expect me to lose tournaments, so I lose them. I deliver man"	1782	goldeneye_	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I was busy for a month trying to survive	1783	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"When i was a child i used to cheer for the roadrunner but now i will cheer for the coyote man COYOTEE!!!!" daut luring ostriches	1784	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I will send coyote for you man!	1785	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"People expect me to play a tournament and lose, I DELIVER!"	1786	artofthetroll	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"maybe I went to a Daut mode to fast now"	1787	goldeneye_	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"one more game. then again, in other room i hear baby crying, so maybe 2 more games is an option as well"	1788	artofthetroll	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Hyuna if I know you're queueing up I am definitely cancelling	1789	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm still young... Ohhh I'm really young and stupid	1790	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
¡BASTARDO!	1791	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Go and catch mbl? He is not a pokemon man! But I'll try	1792	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Easier to catch pokemons than those deers	1793	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Wenegor are you really playing nili in a tournament? Did he really sink that low?	1794	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"I prefer losing rather than being called T90" daut deleting a bad farm to make a new one in a better place	1795	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Nili is joining Suomi? OH PLEASE LET IT NO BE A TROLL. I would love nili in suomi	1796	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"I hate viper equally as much" Daut refering to mbl	1797	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"I will give you 3 of the letters of the draft link and you guess the rest" Daut not wanting to gave the draft link to memb	1798	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
We play tomorrow but idk at what time. He ask me if we play tomorrow and i said yes	1799	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
The plan was not to afford things	1800	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I need a castle on his face... That will show him	1801	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Look at my resources man! I don't care! I'm winning this shit!	1802	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
At least I'm up! Is better that being down!	1803	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
am I right or am I right?	1804	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
are you a freaking monk? Stop converting the subs!	1805	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Practicing?	1806	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"I'm willing to take the sacrifice" daut about letting hera die so he can boom	1807	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"this game will be studied for the next generation"	1809	artofthetroll	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Who am I if I dont boom with 5 tc?	2011	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Well somebody is fucking up then... but not me!	1810	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
You were pressuring me "save the woman, save the woman!" and i did not save the woman	1811	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
i boomed with 6tcs man! If that's not effort idk wahat it is	1812	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Nobody trusts me	1813	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
What will happen next? Lets find out together!	1814	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
We are doubleing one guy and we are losing!	1815	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Are you having sex man? what are those noises	1816	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"Screw u guys! I'm going home!" Daut running away from the battle with his kts	1817	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Aren't other players in this game they can fuck around with?	1818	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
If you sub to me you get EMOTES MAN!!! emotes... and my love	1819	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I want to win and get paid	1820	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
That was madafaka yoink	1821	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"I will just go micro-god mode. I'm nothing if not that."	1822	artofthetroll	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"1, 2, 3, 4...6"	1823	artofthetroll	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"Oh I lost 20 vills."	1824	artofthetroll	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Don't fuck with me! Just give me the stone!	1825	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Now i say "screw u kids" I will play aoe	1826	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
better late than hyuna	1827	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"dont kill my house, i will get housed"	1828	artofthetroll	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
memb man, he's loud even when chatting	1829	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
why don't I get the instant conversion man?	1830	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I made hand cannoners? That’s not a bad idea! Good for me!	1831	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I don't want to listen to you. you are not smarter than me!	1832	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Why did I take that fight? I thoughtI had a cool army... And it was a cool army...	1833	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"He is 2k2! Everybody is improving, except one guy; me!"	1834	byelo	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
When i started to stream I coached art of troll and now he is worst than ever	1835	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Look at hera wanting to know what dautmas is	1836	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Yeah my kids are out of punishment coins so they will have to wait to play with me	1837	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
monks are the clown killers	1838	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
when you have two kids you don’t do a proposal you just get it over with	1839	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Time to switch my name to mbl to make the ladder full of mbls	1840	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Ill host daniboy. he is still a pleb but there is hope for him	1841	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Spanish builders go BZZOOOMM	1842	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"My fellas are toying with you jordan!" Daut during community games (daut team member trapped jordan vills)	1843	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"ohh.. my team is trolling you. I like my team" Daut to Jordan during community games	1844	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Your rating explains your spelling	1845	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I know you dont mind sharing your gold	1846	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
this is the hardest thing in the life of me	1847	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
No problem I'm just fighting vs 3 on the water and 5 on the land	1848	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I wish I was playing this good on torunaments	1849	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
You guys are too nice, are you sure you are from my channel?	1850	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
First time I do something good with my life and you do this!	1851	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I killed his vill cuz he was showing off too much with quick walls	1852	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
You got OUTCLASSED! DESTROYED!!!	1853	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Did wolf kill one of your people?	1854	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Even elite skirm warriors!	1855	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
cuz everybody is watching my stream! They only go to yours to check score	1856	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Nice castle! I'm proud of you	1857	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
If I had to lose let it be against elephants	1858	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"This was like the charity stream as well" daut after beating nili and getting 70% on nili's donations	1859	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
That's my new year resolution... Is a lie but people always lies with those	1860	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
it’s a DauT penta now!	1861	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I hate to play with tatoh man... He is so disappointed when i make a mistake	1862	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Oh I won, you are all dead	1863	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I should tell them there is a guy behind... nah they will find out	1864	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm going to wall his TC	1865	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Viper wasn't happy about that but we wanted to win	1866	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"I used to be #1 player, then Nili was yelling 'Daut Castle'... and now...I'm not"	1867	artofthetroll	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
and you still didn't beat me nili... 20 years of losing	1868	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
The next generation will even find the Pac Man complicated	1869	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Hyuna man you are one weird fuck, but you have a valid point.	1870	yuna_op	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Hello boy! What are you doing alone in the woods?	1871	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
mrYo streams on doyutv so his stream is like hera's full of adds everywhere	1872	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
How do people cast for living?	1873	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
“[On a donation] I actually forgot the message but still liked the monies”	1874	51mpnation	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
The only thing i did not prepare is my homemaps	1875	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I got lyxed apparently	1876	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I demand my demo to be in that gold	1877	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I wanted to be smart now I look stupid	1878	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"that's why this game is so good, when you lose a unit, you can make another unit"	1879	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
what kind of person doesn't let another person spam outposts	1880	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
If could travel back in time i wouldn't even play the lottery, I will just play aoe and win it all and laugh at people	1881	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
never always 5 tc (dautWat?)	1882	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
micro is always strong on the boars against me	1883	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I might be able to finish, might not	1884	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
nothing that my good friend the market cannot fix	1885	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Viper told me that jordan beated lierey and yo... I still don't buy it	1886	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
You lost to nili! is not too soon when u lost too nili	1887	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Welcome to the f1re club	1888	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Damn right he enjoys getting beaten off	1889	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Don't listen to me guys	1890	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm allowed to talk about legal stuff	1891	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I lost my virginity vs the mimmox	1892	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Chat wanted me to douche and i get persians as random civ... Is that a signal?	1893	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
We are super close adn he is super walled	1894	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
How do i post on youtube if i lose?	1895	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
No wood, no nothing... A lot of believing	1896	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Im nothing if i'm not crazy	1897	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
When you have villagers you are always doing fine	1898	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
At least i have something to turn grey! You baldy fuck!	1899	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
This SPARTA!! ... I thought this is sparta...	1900	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"I was thinking, this is Sparta"	1901	51mpnation	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
slam man! Dont be salty cuz you lose to the hoang and some people can delete vills and win	1902	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Why no attack ground with mangos? We dont do that	1903	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Is he forwarding me? ... nooo dont kill my fuuun.....	1904	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm doing podcast anyway	1905	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
VAT! He moved my militia man! He moved it to build his palisade	1906	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I cannot be such a nicov	1907	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"Better fight now. Trust me, soon, it will not be an option for you."	1908	51mpnation	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
What's Serbian moonshine called? Viper! Viper is my moonshine	1909	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I need to respect that viewer. Lets go full man at arms!	1910	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Don't do this at home, is a bad move... I just like doing it	1911	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
This is why I love to have memb in the community and in my channel... I feel young again	1912	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Ill attack u, look, im 10years old, look	1913	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"And he is like a micro player right? I heard stories" Daut playing with lierey	1914	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
If each of you guys send me two thousand dollars right now, I would be a millionaire Just saying	1915	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"You gave gift 50 subs to this guy! I appreciate it!" daut after losing half his xbow before imperial upgrades to a random mangonel	1916	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Ballistics dodgers!	1917	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
MBL is my friend, he is a little bit young and stupid but he is nice	1918	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
If aoe4 is a big success I will have to o professional interviews without curse and stuff... so I hope aoe4 fails	1919	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I dont like deleting houses! People live in those!	1920	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Seeing your support guys is actually more important for me than actually winning the tournament	1921	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Players are like my puppets! I pick their civs and they do as i want them to do	1922	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
If u take the risk and lose u feel good tomorrow, If u play scared and lose u feel like shit	1923	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
My economy says go for the wagons! I listen to my economy	1924	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
This time is when the throw begins	1925	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I so crazy how much u can learn from watching recorded games	1926	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
The shield armor, the fuck armor	1927	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
First place is the only that matters	1928	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
They are wasting my time here...	1929	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
U guys feel the pressure playing with the best player?	1930	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"I'm trying to be one of u guys" daut to his teammates after he won red bull	1931	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Yeah we were good and we are not	1932	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
GG guys! GG!! Thank you for dragging me down with you	1933	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Is play all 7 games so 7-0 is an option	1934	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I believe in Viper, he is like 2nd best player in GL	1935	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Whoever wins that fight both loses	1936	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Tatoh made me do stone walls so now i'm missing 1 TC	1937	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
A few more drop tricks and we got this	1938	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
If i send 1 vill forward i lose 2	1939	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
What do you need to get out of the Do Do	1940	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
We save indians for u guys to lose on acropolis	1941	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
slam was like "i got u daut dont worry" and then i lost all villagers and slam was like "sorry daut i didnt had stone"	1942	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Whoever won red bull raise your hand!	1943	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
if u want to reschedule please ask the same to all my team.. Im not doing your work for u!	1944	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"i can't sit but i'll not, LET'S GO"	1945	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I give you some konnicks	1946	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
All the deals in my channel are made with myself to myself	1947	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I went full fire here	1948	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Yes yes, i made my mistakes and i'm proud of them	1949	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I dont know if i stole somebody's sheep but i will	1950	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
freaking miguel man! everywhere i look a relic is being picked	1951	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I micro with the brain	1952	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Fire is slower than my internet	1953	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I think fire should do it. I gonna watch him	1954	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
and he just answers ok... that's such a girly thing to do	1955	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
he best thing is this is my last game so... hit and run! beat him and host him to let him with more salt	1956	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I take no peoples llama	1957	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
boost me, man!	1958	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"I have lierey on my side!" Daut when his kts were not converted by enemy monk	1959	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Man, is it hard to get wood or what?	1960	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
whats my best joke? nili giving up casting will make him a top player	1961	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
goodbye webcam, hello shisha	1962	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I respect the promise and still fail at the same time	1963	yuna_op	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Obviously casting hurts your skill... look at memb	1964	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I don't want to make hera mad, he will make a post or something	1965	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I dont want to lame hera man! he will make a post about me or something	1966	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
That lion is helping more than you	1967	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I want to build a castle but not only build it but also finish it you know?	1968	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Do you see my wood economy? well i not!	1969	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Yeah yeah, let's kill your guy so you look even better	1970	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I always ask myself how can i die for my team	1971	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
they cannot steal the shorefish	1972	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Jordan once again no knowing a single thing about the game	1973	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"Im not proud of my team right now!" daut casting TG where tatoh and jordan both did 3 layers of stonewalls in castle age	1974	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
No micro can stop Jordi	1975	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Microing boars, microing fighting microing	1976	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
why would I make scouts when knights are stronger?	1977	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Where do sign up for tempo?	1978	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Oh man u have more army, more villagers and still managed to lose	1979	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
good hole, viper, good hole	1980	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Viper: we actually have a chance to win now. Daut: no no no	1981	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Actually We are going for the win! Jorda! enjoy the bench	1982	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Lets do it like this lets guess how many continents there are in the world, the closest one gets to play... i mean cuz jordan once said there were only 4 continents or so	1983	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I have more economy this game that all you guys together, the whole team	1984	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
And viper was like oh daut can u please send me a few knights.... prety please!	1985	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"I have the feeling my team mates will attack me first" daut about to play a FFA event	1986	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm a bit busy for your bullshit hera....	1987	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
At least i'm the best of the worst	1988	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Why did i bully viper?? Didn't you saw what he did to my relic	1989	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
This is bad now I have to micro	1990	batbeetch	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Viper lowest score, i like that... doesnt mean anything right now but i like to watch it	1991	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Age of empires is much higher quality than those new shinny things	1992	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
are my units also invisible? No they are alive	1993	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Make man at arms faster or slower!	1994	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Douche? ... I absolutely get nothing from that	1995	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"WHAAAA whaa? whaaa? X please!" daut when scouts entered his presumed fully walled base	1996	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
ho ho!! Daut snipe!	1997	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"The hole was a lie, man."	1998	51mpnation	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"I'm going to try hard like it's a RedBull."	1999	51mpnation	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Stupid ass game!	2000	artofthetroll	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
One day I will make another Donjon and that one will be amazing!	2001	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Im gonna yoink you all day man!	2002	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Just get that castle down and i'm happy panda	2003	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I promise you I'm good at this game!	2004	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Why they put Regicide in the homemaps and not fortress? dautWat	2005	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"normally you would need skirms in this mix, but I'm not normal"	2006	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Now he thinks I got ballistics, but that was all micro	2007	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I win the fight I lose the game	2008	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
yeah vill count doesnt look good... but subs count is nice! thx for the subs guys!	2009	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Playing HC finals against fire would be my dream	2010	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I dont want to boom with only 4 TCs	2012	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I mean i will go sarjeants cuz is really cool to go for the unique units	2013	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
They have a little bit of everything and a little bit of shit	2014	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
their unique unit is a villager that can build but not collect resources	2015	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
HAHA!!! He overmicroed	2016	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"It did start as a fun game!" Daut after his inca rush failed	2017	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
You cannot win if you don't believe!	2018	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I get excited by stupid things and then i lose focus	2019	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
if I win HC4 I am thinking about retiring from competetive scene	2020	deagle2511	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
DauT: "He has monk in a transport ship...he should jump out, convert villager, then put the villager in the transport ship and delete it. Must establish dominance"	2021	batbeetch	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"'Oh my gosh, Jordan is making tower on the gold, is that amazing move?' Yes, if you're stupid"  -Daut casting TheMax vs Jordan	2022	batbeetch	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Yeah but i want to destroy a bit more	2023	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"A quick interview? With that loud fucker??" daut being asked for an interview after winning showmatch	2024	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Well if jordan can do an interview after signing up for a tournament, I can do interview after winning showmatch	2025	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Nili thinks that because i beated lierey and won RB he can improve as well	2026	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm getting trolled by my own economy	2027	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
How much money did I won in aoe? Not enough man! NOT ENOUGH!!!	2028	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
You didn't even attack me! U just splash damaged the shit out of me	2029	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Score is lying like in the last game! all lies	2030	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Stop running away! Just die!	2031	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"Actually i won't scout that! I want to be surprised in post imp finding a gold or something" Daut deliberately not scouting the back of his base in arena	2032	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"I prefer to win with luck that winning without any luck" dautWat	2033	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm not sure what i'm trying to quickwall here... apparently nothing	2034	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Zek man, whatever you do with your punishment coins today is not respected!	2035	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Can you chill man! is your smurf account! You are supposed to chill!	2036	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
NOOO I did so nice and then i did so bad	2037	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
don't do this at home	2038	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
We shoot to miss!	2039	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"Is halbs the counter unit? I don't feel countered" daut patrolling paladins into halbs	2040	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
deagle is not important	2041	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
the good thing is, nothing else can go wrong this game	2042	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Okay 26population is not what I have in mind for a comeback	2043	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I want pretty things too	2044	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I may feel a bit like a dirty sellout but we could do that	2045	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"This nice guy is collecting all the relics for me" Daut spotting a enemy monastery in the middle of the arena	2046	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Thanks you for the gifted subs and the gifted relic	2047	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Don't wall your boar	2048	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Give me that ding ding sound man!	2049	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I imagine the castle will be there. If i imagine it, it will happen	2050	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I didn't knew Celts was such a monk civ	2051	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
My units are expensive and my units are his units	2052	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Even if this is the best strategy in the game... Feels shit to play	2053	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Prize pools are now big enough i dont need u anymore! 11	2054	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I did ok top 8, losing to yo, it’s good as long as you ignore Jordan beating yo	2055	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm so happy i lost to Yo	2056	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I am proud to lose against yo	2057	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I micro like a beast when i see nothing	2058	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
that grandpa can dodge or what?!	2059	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
let’s kill those healing brothers	2060	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
man, the grandpas are not freaking dying!	2061	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
He did really good wit... Wall micro? ... let's call it like that	2062	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
No football player will steal a boar of mine!	2063	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I had the speed but the boar was mean to me	2064	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Everything is a fail	2065	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Football players are microing like me	2066	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Meow Meow?	2067	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
My favorite color? It's used to be 5 but then i grew up and i dont care	2068	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm showing the great stupidity there	2069	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
oh i forgot to micro them	2070	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
If you call me weird for play at this hour then look at the clock and look at the mirror	2071	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
When i started my stream and it was my job, i was thinking about my child and thinking i need to win tournaments to get viewers and then i saw T90 streaming low elo legends	2072	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
too much shit talk... I dont even know what i'm doing here	2073	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Is my TC broken or something?	2074	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
And these players that dont understand how the game works! he wasn't supposed to do that	2075	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
He doesnt have units to follow this push... And i don't have houses. Everybody is missing something	2076	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
He gets my fish but i will get everything from him	2077	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
It's time for hoang! Get out daut, this is hoang!	2078	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
He will not be able to micro that forever	2079	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"Soon enough i will be back to Europe" Daut playing form his home in europe	2080	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
DeadMatch is not for old people	2081	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Don't walk through me!	2082	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
and nili... nili can follow the plan :)	2083	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"He is playing cooler than me" daut beating sarjeants with cavaliers in sicilian war	2084	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
He dont notice	2085	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Look at nili! He is good at deadmatch and he is destroying in random map	2086	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
You will give me 100 dollars if I beat u in dodgeball? Ok i¿ll give you one thousand if you beat me in random map... 1 million even	2087	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
You will give me 100 dollars if I beat u in dodgeball? Ok i'll give you one thousand if you beat me in random map... 1 million even	2088	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
He knows where i'm moving before i know	2089	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I appreciate the 5 gifted subs but i don't deserve it	2090	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Feudal boom? against hoang? sounds like suicide... Let's go!!!	2091	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Why do i think viper lost intentionally to hera? well he has been losing for like 10 tournaments already, he likes to do that.	2092	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I wanted perfect angle so every arrow hit him in the ass but I failed... His ass is safe	2093	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I dont need to go for the kill, i can just boom and win. Obviously i'm going for the kill	2094	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I lost slamboy... could farm him like vinchester did	2095	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
score could be lying. I dont think it is, but it could be	2096	batbeetch	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I just happend to not be the smartest guy ever	2097	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
5 famrs? yeah 5 too many if you ask me!	2098	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
i believe in you ninja monk	2099	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
at least im losing with style! no one can deny that	2100	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm just kidding, jonslow is an amazing guy... but dont sub to him	2101	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
What? catafracts man! You are cats!	2102	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Risky moves always bring the fun games	2103	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
if I lost to Jordan. goodbye streaming. goodbye life.	2104	yuna_op	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
If he doesn't do economy upgrades why should do I ?	2105	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm not trying to lose, I'm trying to win but the strategies i use are a bit questionable	2106	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Why you kill me and I don't kill you	2107	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I think I'm negative five right now	2108	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
it looks really bright? as my future	2109	yuna_op	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I wish i could blame the chat for this bad strategy... but is all my bad playing	2110	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Tatoh started his stream with the title "we are playing this tournament" Little does he know i will be late	2111	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm disrespecting the tournament as hera... i dont know if is 1 rhino or 2	2112	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
at least I tried to micro	2113	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
looks like he sniped something. his chances to win the game	2114	deagle2511	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Sometimes you are lucky and sometimes you are not lierey	2115	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
You wanna play it like that? you gonna get one in the face!	2116	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
luckily I boom like crazy person	2117	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"Idea was decent nobody can say that" dautWat	2118	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
everybody beats Yo. Except one guy, one dautBaldy guy	2119	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
nice mangonel shot? shut up! We don't talk about that here	2120	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
When those turn into crossbows i will turn inot a dead boy	2121	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I want to take this fight! I don't care if I lose	2122	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Nili is going to carry... our drinks	2123	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Babies cry less and less, they are like kids now	2124	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Any food is a good food	2125	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"Do you want me to teach you how to play?" Daut to viper during TGs	2126	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"that's not being dumb, that's being an idiot"	2127	artofthetroll	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"I prefer to lose than be toyed with"	2128	artofthetroll	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
“Daut what is your pop?”... “the pop is gg”	2129	batbeetch	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I don't like deleting my children	2130	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Nicov man! click on that link! play to level ten! And make me rich!!!	2131	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I had to play showmatch vs Laaan and then fire and they both didn't show up nor sent anything telling they won't show up. they just ignored everything	2132	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Imagine the level of people don't giving a shit	2133	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"Oh i appreciate that new raider" daut selling out his Raid Shadow Legends sponsor	2134	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
This is my channel so is all about of me	2135	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
500euro coaching was booked and i don't really know how to deliver 500euro coaching 11 I may have to rpepare something even	2136	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
global warming hit ages of empires 2, man!	2205	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Probably viper used his 10th place prize to buy my 500euro coaching. Is an investment for his future	2137	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"Wait! I know what's my economy upgrade!" *Builds a market	2276	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
30 minutes? but you are trying to enjoy the game, that's not the point here (DauT sellout)	2138	deagle2511	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I will get a bit of help from my friend market	2140	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
3 stables knights? Nahh that's good for vikings. not for berbers. with berbers I'll go crossbow	2141	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
villagers can be replaced, markets not	2142	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
This is one blind ass fucker	2143	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
The only desicion i need to make is who to sacrifice	2144	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
That's my way of the winning. Sacrifice people	2145	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
walls-wise he is good	2146	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
orange color is dangerous one	2147	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I think T90 is the closest thing we have to a professional caster	2148	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I will leave the hole open	2149	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Oh he is passing in...	2150	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I will hoang him out of the game so hard he will uninstall the game after this	2151	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Give me that taste of market	2152	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
clowns are scared of archers, we know that	2153	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Should i pick all the tower rush civs? tower rush him back to the voobly	2154	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Come here with your smelly archers!	2155	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Apparently I don't know how to convert	2156	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
where should i send my beautiful army of nothing ?	2157	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm done defending you guys	2158	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"You defend me and I complain" daut discussing the game plans at the start of the TG	2159	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"You can tell the difference when jordan and nili are not here? this is like the opposite of losing"	2160	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I was playing like a butterfly, all over the place	2161	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
slam is an amazing player, especially in tournaments	2162	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I read it and i know what i want to answer but i had to type it and got lazy... ill do it later. maybe tonight	2163	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Wait?! Your army is 2 skirmishers!!	2164	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"Look at him!  Who is Lyx now??" Daut donjon rushing lyx	2165	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I will not host anybody, no one deserves the host	2166	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
One day, when i get all the upgrades, this will be a beautiful game	2167	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Damn, I am stupid.	2168	artofthetroll	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Units lives matter	2169	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
for 500 euros an hour I can show you how to lure a boar	2170	yuna_op	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I am not going to do that, I am just saying what I should have done	2171	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
If he sees this... nah, he is like fire, tunnel vision boys	2172	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
he! "britons are not the best civ here" you guys are clueless	2174	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Walling him in with castles is basically my plan here	2175	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
If luck was no fun nobody would gamble	2176	batbeetch	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
is he going scouts!? oh thats my scout	2177	batbeetch	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
if you are missing 5 food to click up you should be allowed to click up	2178	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
double walled for double the pleasure	2179	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
don't make a farm when people are dying!	2180	batbeetch	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Not everything is good from behind	2181	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
win only in tournaments? No, I dont win even in tournaments	2182	batbeetch	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
There's no limit to my micro	2183	batbeetch	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I have two options... Either to go for the water play, or basically eagles... I dont think plumes would do anything. But you know what guys? I'll go for plumes. Why? I like them	2184	batbeetch	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Being stupid is the new smart	2185	batbeetch	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Don't they teach you how to micro in the Starcraft?	2186	batbeetch	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
if i wanted an 8hr job i would not be a streamer	2187	batbeetch	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
he's going full Game of Thrones on me	2188	batbeetch	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm a BAD BAD player! I deserve everything coming to me!	2189	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Missing one relic... I want all the pokemons!	2190	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Other way to call him stupid: Misjudged	2191	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
kiss me you beautiful beast!	2192	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"Jordan congratz on 2nd place!" DauT after beating Jordan in Bo21	2193	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
it was hard to play mind games with jordi, he doesn't have mind	2194	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Is hard to play mind games against jordan. he doesnt have mind	2195	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm just competing in tournaments, streaming is my side job	2196	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Man! he is surviving left and right	2197	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
That's why they teach you in the freaking starcraft??!!!	2198	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
The plan did not working according to the plan	2199	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"ok maybe i need units and stuff like that"	2200	artofthetroll	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Give me your nili joke!	2201	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"Now you know how slam feels!" DauT after carrying jordan for a 3-0 in 2v2 showmatch	2202	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Let's dance the Tango with the mango!	2203	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I do not share!	2204	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Come on hello kitty! Get them!	2206	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I can do a lot of pretty things...  i dont know which is the prettiest	2207	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
“I will win the fight and the game? nononono, I want to play more”	2208	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
If you think this is enough TCs, you are wrong	2209	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Is GL B and B stands for nili	2210	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Never saw you guys lame as much as on this tournament were laming is not allowed	2211	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I got lamed by the boar... does that count?	2212	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I cannot go! I'm still laughing	2213	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
nili is playing deadmatch from dark age	2214	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
What's Nili's homemap? Who cares he is not going to win anyway	2215	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Is not like when jordan lose a tournament. that nobody cares	2216	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
We need triple elimination for Nili	2217	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
He is not under pressure man, his pressure is his speed	2218	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"Well at least you have deathmatch" Daut to nili	2219	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
And all change completely when slam did that micro I have been teaching him for all these years	2220	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Everyone learned this game from watching my recorded games	2221	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"OHHH!!! I cannot look! Wake me up when it is over!" Daut casting nili	2222	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Goodbye chair, goodbye slam!	2223	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
When s the giveaway? You can take nili! I give him away	2224	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Wanna micro young man?	2225	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Man! The hill is freaking saracens	2226	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
ohhh he is going to clown me down	2227	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I remember I told him he doesnt know how to play.. but i tell him that everyday tho	2228	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I don't want to be yelled at	2229	deagle2511	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
no stone walls allowed? But we made fortified walls!	2230	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Ohh mangonel micro tatoh I need you!... *wins fight* Haha! I dont need you	2231	batbeetch	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
*Daut using monks and mangos* do we have second building?	2232	batbeetch	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm hearing dying sounds... And i think those are my villagers	2233	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Is there anything with more than 0hp there?	2234	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm not dancer, I'm player	2235	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
well im good, im old so this will be my cup	2236	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
stop micronerding? no man! i learned that!	2237	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
No need to throw this game	2238	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Never micro is what you need to do.. or not to do	2239	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Actually i was housed so i had to fight. True fact!	2240	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"Is really bad for me to move out now" Daut while moving out with his army anyway	2241	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"Look at him! So old and yet happy" Daut watching memb's stream	2242	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I am a Jordan today?	2243	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Doesn't feel good to be a Jordan	2244	deagle2511	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
If market did not exist i would be 1k5	2245	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"I almost wasted resources on fletching" daut selling everything to go castle age without army	2246	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Those fuckers are like "we nerf market, we nerf market" ... NO YOU DONT NERF MARKET!!!	2247	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
And Aftermath lost to this? they will loe again	2248	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Onagers go BAM	2249	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Should i go halbs or  not halbs	2250	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I signed up for easy money but is not going that way...	2251	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I went there for a villager war and they didn't show up	2252	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I also don't know what i'm doing, i'm exited to see it as well	2253	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I want them to see it man, I want them to look to the death on the eyes	2254	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
It's all about perspective. It depends on what side of the wall you are	2255	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
We should tell them to alt F4 cuz we sneak so they know we sneak but they dont see where	2256	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Anybody else wants to go fast imp with us?	2257	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
to nili: I have a wood for you!	2258	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm a scary guy	2259	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Nili is my pond!	2260	byelo	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
he says elephants are overrated and he made only 1	2261	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
what can go wrong when I play like nili?	2262	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I am scared and confused at the same time	2263	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I lost so many units, that’s what happens when his units counter mine	2264	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Monks are a good thing, they take relics they... ?? .. best unit in the game	2265	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Getting to finals is not special anymore, even jordan did it	2266	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Don't try this at home, this requires a lot of apm	2267	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
don't try this at home. this requires a lot of APM	2268	yuna_op	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm capable of being smart sometimes	2269	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
This one is dead, or this one is dead! ... no one is dead	2270	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
where is your converting boy?	2271	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
if you cannot beat them with army, you boom!	2272	yuna_op	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Entirely blame this one on chat	2273	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Let me click up and then we fight again	2274	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
i dive in, i dont care	2275	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Relic goes YOINK https://clips.twitch.tv/HealthyColdPonyKreygasm-n24nocHPjFqs0HP0	2277	yuna_op	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
even with all those clicking I cannot get over 300, screw that back to the chill mode https://clips.twitch.tv/UnsightlyPreciousSrirachaSSSsss-lPq8ngV5VbgqLzUw	2278	yuna_op	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
that one is going to YouTube just because of my APM!	2279	yuna_op	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Yeah miguel is around but he lost red bull qualifiers so he doesnt deserve a host	2280	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm starting to believe that full cavalry is not the right play against full camels	2281	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I will outlast lierey as well, not only viper	2282	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I have a tendency to play stupid games	2283	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
if i could micro like a boar i would be unstoppable	2284	yuna_op	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Who will i play in the finals? well not tatoh or slam	2285	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
The villagers keep screaming in my economy	2286	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
i went ZUUUM! and he went zum... I guess my "zum was higher	2287	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Those settings are good... although i'm failing on that tournament miserably... yeah those settings are bad then	2288	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I think relics should tell me where he is? ... I have no clue where he is	2290	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
There is always a bigger hill	2291	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Even slam should be able to win from this spot	2292	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
report me to twitch? For being awesome? Go ahead	2293	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I will actually google it after the stream	2294	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
He wants a motherfucker win now	2295	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Can you say monkas? oh noo i said it.. fuck... i feel like viper now.. i shouldn't read that i was in autopilot	2296	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"oh he is housed!! he is housed!!" *fails to kill the vill* "Oh.. i wish i would have killed that one. then he wouldn't be housed anymore"	2297	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"if viper has the dog camera and fire as well, i can have the medal camera" Daut talking about having webcam pointing only to his red bull medal	2298	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"Traitor! nice, short and true" Daut after hyuna asked for a new name	2299	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I saw the dream team thingy on my discord, i messaged hera and lierey and we sign up for it	2300	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I got quickwalled by the freaking boar	2301	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Hopefully no monks... There is always a monk	2302	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Why I'm so amazing? I have hair	2303	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"I kill you, you dont kill me, that's the game we're playing"	2304	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I think i can attack the lame way	2305	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
hmm he is full of good moves	2306	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
If I was a castle where do i wanted to be	2307	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Oh a TC there? I would like a castle there	2308	carloscnsz	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Haha! getting out-microed by DauT!	2309	batbeetch	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"if i picked Chinese, i would have more villagers than I have right now"	2310	artofthetroll	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I was doing fine until you micro back! I hate when people micro back !	2311	yuna_op	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"Let's see if it's Serbian thing to micro badly or just a me thing." DauT, facing Big Don Bepis on Clown Arena.	2312	byelo	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Jordan, man! It was funny when I lamed, not when I get lamed!	2313	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
nothing to see here! I'm failing. - DauT when his stream is dropping frames and losing	2314	yuna_op	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
time to call it, my frames are dropping, I am dropping, everything is dropping!	2315	yuna_op	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
5 relics, thank you for collecting! dautKotd	2316	deagle2511	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm playing against some beast here!	2317	artofthetroll	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
afk? who cares, its just jordy	2318	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
my real job? I don't even know my real job yet!	2319	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
he think he can beat me in mangonel war? I guess he's right	2320	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Vikings are fricking Vikings	2321	artofthetroll	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
memb is playing, I will not forward you to the memb	2322	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
well, Viper is also going bald but nobody cares about that	2323	deagle2511	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I live for stupid fights	2324	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
if it is 5 tc it’s a good decision	2325	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
let the clowns study this build, thinking I did it on purpose	2326	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I don’t like to look in the mirror. I don’t like that man	2327	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I think any map is my home map	2328	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Friggen "Fabulo" man	2329	artofthetroll	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
this is the classic cup and we cast the classic way	2330	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Aztecs are like crossbow	2331	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Jordan is asking for advice, I can screw him over	2332	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I want to be Lierrey too. I never will be Lierrey	2333	deagle2511	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
cmon it's slam man. he is probably in ER man, trying to get his heart working again!	2334	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
GL finals. Been a while dautKotd	2335	deagle2511	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I am more than stupid	2336	batbeetch	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
let's do the one thing I know to do	2337	deagle2511	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Interview "daut, did you prepare?"  I prepare shisha, does that count?	2338	deagle2511	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I realized something about myself, I feel better when I’m winning	2339	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Another Day, Another Fail	2406	artofthetroll	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
don't blame the player, blame the game. Well maybe blame the player as well	2340	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
if this was a tournament game I would have to pay the damage for the breaking of the computer	2341	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I like viper’s body	2342	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"Yeah gbettos are very situational, and in every situation they are bad" https://clips.twitch.tv/HeadstrongRamshackleAsparagusGingerPower-aiCz9xQUFoj4AW5Q	2343	artofthetroll	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
When I start massing lancers... that's it... I am massing lancers.	2344	artofthetroll	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I use the market when I sleep	2345	deagle2511	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
everytime I met lierrey he is 16 years old	2346	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
oooh, my proud little moment just went to shit	2347	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I’ve seen some bams in my life and that was a good bam	2348	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
those people that raid are the worst….. let’s raid!	2349	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
so magikarp is a pokemon? you learn something useless everyday	2351	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
monks should need redemption to convert elephants	2352	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"He's gonna wall you in... He walled you in. This is a true zoo" -Daut casting Deagle's walled in Elephantos	2353	batbeetch	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
How are you not getting converted there? I would get so converted here	2354	batbeetch	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
this is what happens when you watch deagle too much	2355	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
if i start winning more people are gonna give up on this game	2356	batbeetch	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I am taking dock spot here, go away as far as possible from me	2357	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
deagle get out	2358	batbeetch	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I go to sleep at 4am like a normal person	2359	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
guys wanna see something cool? *fails to trap enemy scout* well not in this stream	2360	batbeetch	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
without memb, there are no amigos	2361	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
surprise, muthafucka!	2362	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
it’s all fun and games until it stops being fun and games	2363	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I put Serbia on the map	2364	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
could be a mistake, but heart wants what it wants	2429	deagle2511	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
He won't finish, and even if he finish, it won't last long., Okay he finish and it last long.	2365	sharkfins0up	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
This world makes no sense.	2366	synapse16	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
nobody saw that, or at least I didn’t, at least one person didn’t see that	2367	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
who cares about the hit and run? Just hit and hit	2368	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
AND THAT IS HOW YOU PLAY THIS GAME!	2369	artofthetroll	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
One day, I'll learn the game of Age of Empires.	2370	synapse16	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
it’s important to show the class even when you’re getting wrecked	2371	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Don't put your junk on me man	2372	woootman_	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
blacksmith! That’s why he is winning…screw the blacksmith let’s go up	2373	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Show me your junk.	2374	woootman_	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Don't judge me, I'm a market abuser.	2375	woootman_	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Guys! Always remember to protect and upgrade your junk	2376	goldeneye_	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I feel like Bambi on the ice playing this game	2377	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
*loses monk* I love that guy, he was like a father to me	2378	woootman_	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
woot, man they don’t need to know that I’m an idiot!	2379	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
justice for the no knight civs	2380	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
man the Khan is dominating my ass	2381	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I don’t want to play galley war into demos into killing myself	2382	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
hyuna: I just shared a useless fact. daut: no fact is useless to me	2383	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Daut castles left and right!	2384	artofthetroll	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
never do the Math on stream.	2385	synapse16	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"You will drop where I tell you to drop, or die trying"	2386	woootman_	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Holy Roman Empire without relics will not be so holy	2387	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I am a book to him	2388	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Nobody calls me a chicken anymore	2389	artofthetroll	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
lying is nice when people don't check, well they can but they don't bother (DauT lying to his family about his job)	2390	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
guys never be nice, nice doesn't pay man	2391	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Tatoh... don't talk to me	2392	batbeetch	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
if I do Alt F4 I get banned... I dont want to get banned! I do this for a living!	2393	batbeetch	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
ohhh I lost so many houses now!... luckily Im losing villagers so its good	2394	batbeetch	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Jordan Jordan! this is the most important thing in my life *attacks ground 2 petards*	2395	batbeetch	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
mamelukes are shit	2396	batbeetch	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
oh I got outmicroed here. also I got outstupid here	2397	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
If you are housed, you take the fight. thats the rule, basic age of empires.	2398	harooooo1	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
That stable says that he is up. I don't like when stable is talking.	2399	harooooo1	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"i know you guys all love slam, but he's just not there yet. just not there. he is younger than me, he's got time"	2400	artofthetroll	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I don’t want to play blaming game but it’s viper’s fault	2401	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"estupido!" -Daut to himself after hitting a boar with his scout	2402	batbeetch	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Im a GL player after all... if I know anything is how to hide behind my ally	2403	batbeetch	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
get the fuck out of my game! -pause- shut up guys	2404	deagle2511	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I have wheelbarrow, bitch! Let’s go!	2405	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
1 villager on gold is better than no villagers on gold	2407	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"Cannot focus with those d**** around the TCs". DauT forgetting to enable small tree mod after patch.	2408	synapse16	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
can you ascu the sheep? can you ascu the sheep?	2409	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
there is a few mysteries in this life, but the f1re being in top ten constantly is the biggest one	2410	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"Hussars!? That's so last year"	2411	woootman_	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
You're fat, you're cool. you're deadly	2412	deagle2511	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"BAM MOTHERFUCKER! delete the dock if you want in!"	2413	artofthetroll	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
That's my farm space you asshole!	2414	artofthetroll	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I hope he doesn’t realize my evil plan here	2415	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
score is not looking too good for me. but I kinda feel good	2416	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
yeah yeah go to freaking India and group up	2417	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
admiral my ass	2418	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
even my delete micro doesn't work, which is always amazing	2419	artofthetroll	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I don't delete my economy	2420	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"I could work as a baker? Well, I'm already roasting Memb, so..."	2421	byelo	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
it’s so much easier to play feudal age when you actually make units I must say	2422	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
what's dying here? dautKotd oh, my villagers dautPickle	2423	deagle2511	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
going full Dancing Queen on me rn	2424	batbeetch	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Isolation is actually a good thing. Then you don't need an excuse for staying home and doing nothing.	2425	harooooo1	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'd rather have castle age than dead units.	2426	artofthetroll	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
you were thinking I was dead when I lost everything	2427	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
now a castle? why not, I'm on a roll here	2428	deagle2511	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
castles can't run away, at least I have been told that	2430	deagle2511	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"always blame the flank"	2431	woootman_	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Can we exchange Kasva for MembTV? I want MembTV	2432	woootman_	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"I outmicro somebody!" *happy voice*	2433	byelo	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"I'm getting Redemption and he's Feudal Age... Don't do that unless it's Hoang"	2434	byelo	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I was like "Let's Go!" and he was not "Let's Go!", and now I'm like, "Let's fuck..."	2435	artofthetroll	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
man those elephants got big ass	2436	harooooo1	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I’m his boy toy	2437	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
daut to slam: ‘you know nothing’	2438	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
tic toc, mbl, tic toc…ooh, tic toc me!	2439	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Fine! I cannot finish	2440	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
But I wanna go unique unit then - to be cool at least	2441	goldeneye_	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
man are you guys gonna play age of empires or are we just gonna look at each other like its a staring contest?	2442	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
for my team I buy the time	2443	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
feels like he is more passive than jordi with girls	2444	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
they look beautiful, my little killing machines	2445	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
when you do supremacy, loom is like, why the fuck bother, waste of gold	2446	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I’m a gamer man! I eat where I play and then things get messy don’t judge me man	2447	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
gimme one moment. I will go to the bathroom and think about life a little bit.	2448	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Viva Las Vegas I think I’m dead	2449	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I can smell the gates from the long distance…call me a gate smeller	2450	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
nothing bonds people more than making fun of a guy who isn't here	2451	harooooo1	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Oh F1re I miss you in the LAN events... I miss those times when you and Slam were good players	2452	harooooo1	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I never microed this much since kindergarten	2453	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I stream like every day! The last two days	2454	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
that was supposed to be my deadly imperial army	2455	deagle2511	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
my ass is fine	2456	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
halbs? that will punch a kick I suppose	2457	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
dominated my ass	2458	batbeetch	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
everything is nothing man	2459	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
arena is such a cool map	2460	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I don’t know man, they scare me and confuse me at the same time	2461	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
oh those eagles got new shields	2462	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I think I pissed off everyone in aoe2	2463	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
the market was always there for me, cannot say the same about hico	2464	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
next to Chris I feel young	2465	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
yeah chill there, look at your friends die	2466	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I can promote shadow legend but recommending fire is where I draw the line.	2467	woootman_	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Did hoang get the expansion pack?	2468	woootman_	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
wrong scout!	2469	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
we in, we in! dautOver9000 Uh, we out, we out! dautPickle	2470	deagle2511	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
what the fuck man are we playing frozen here? Let it go	2472	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
don't go on hill and be funny. nobody likes funny guys	2473	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
sorry about the thunder. I can't fix that. hopefully next time I can fix that.	2474	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
tech switch is for the weak minded.	2475	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
hoang is jealous of my economy right now	2476	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I was greedy. I apologize! Yikes	2477	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
my best friend will cheat on me but that's fine	2478	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
my name is Darko, and I have a problem, I am addicted to the market	2479	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'll wear something pretty - DauT talking about redeeming channel points for a date	2480	synapse16	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I live to serve	2481	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
troll you are a player? Yes you are but you are a bad player	2482	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I hear something dying... *finds vills being raided under TC* ohh! my TC is dying!	2483	batbeetch	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I might end up tower rushing myself...	2484	byelo	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Viper: "what army do you have?" Daut: "stone walls"	2485	batbeetch	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Who got my nose? You got my nose!	2486	artofthetroll	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
is it weird that I'm top score and I want to resign	2487	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
oh poke him Pokémon let's go	2488	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
parejas mil -DauT saying 2,000 in spanish	2489	batbeetch	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
why apple??	2490	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
move your freaking fat wagons!	2491	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
we have been through worse before... but never managed to come back	2492	batbeetch	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I will dream of the banana, man	2493	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
WTF viper! what are these knights this is like modern age unit here!	2494	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
they can resign now *DauT getting to Castle Age min 35*	2495	batbeetch	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
man we got our ass fruited	2496	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
I'm mill spamming shit	2497	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
they deserve lifetime ban for dodging not one minute. they deserve jail time man	2498	hyunaop	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
"We are holding, the trade is tanking!" DauT, after seeing the enemies kill the trade instead of his five camels.	2499	byelo	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
you cannot out micro the micro god.	2500	artofthetroll	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
you disrespect market using it as a wall	2501	artofthetroll	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
double mangonel out micro, doable!….but not for me!	2502	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Back to daily streams... once a week!	2503	artofthetroll	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
arambai are back, baby!	2504	zekleinhammer	daut	2022-07-17 16:57:21.880829+00	f	\N	\N
Yes, eat the TC. It is healthy for you!	2599	botcanarrow	daut	2023-11-03 14:46:39.652729+00	f	\N	\N
\.


--
-- Data for Name: scores; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.scores (channel, player1, player2, player1_score, player2_score) FROM stdin;
daut	daut/jonslow	ganji/andy	1	1
\.


--
-- Data for Name: streams; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.streams (name, joined, added_by, added_at) FROM stdin;
artofthetroll	t	trollabot	2022-07-17 16:57:21.880829+00
daut	t	trollabot	2022-07-17 16:57:21.880829+00
\.


--
-- Data for Name: user_commands; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_commands (name, body, channel, added_by, added_at) FROM stdin;
vaat	Daut has said "vaat" ${vaat} times!	daut	artofthetroll	2022-07-17 21:31:57.519987+00
yikes	Daut has said yikes ${yikes} times!	daut	artofthetroll	2022-07-17 23:04:42.902865+00
quote	He's top score! Doesn't he know I'm winning?	daut	byelo	2023-10-10 16:36:55.403819+00
\.


--
-- Name: counters counters_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.counters
    ADD CONSTRAINT counters_pkey PRIMARY KEY (channel, name);


--
-- Name: migrations migrations_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pk PRIMARY KEY (installed_rank);


--
-- Name: quotes quotes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quotes
    ADD CONSTRAINT quotes_pkey PRIMARY KEY (channel, qid);


--
-- Name: scores scores_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scores
    ADD CONSTRAINT scores_pkey PRIMARY KEY (channel);


--
-- Name: streams streams_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.streams
    ADD CONSTRAINT streams_name_key UNIQUE (name);


--
-- Name: streams streams_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.streams
    ADD CONSTRAINT streams_pkey PRIMARY KEY (name);


--
-- Name: user_commands user_commands_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_commands
    ADD CONSTRAINT user_commands_pkey PRIMARY KEY (channel, name);


--
-- Name: migrations_s_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX migrations_s_idx ON public.migrations USING btree (success);


--
-- Name: counters counters_channel_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.counters
    ADD CONSTRAINT counters_channel_fkey FOREIGN KEY (channel) REFERENCES public.streams(name);


--
-- Name: quotes quotes_channelname_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quotes
    ADD CONSTRAINT quotes_channelname_fkey FOREIGN KEY (channel) REFERENCES public.streams(name);


--
-- Name: scores scores_channel_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scores
    ADD CONSTRAINT scores_channel_fkey FOREIGN KEY (channel) REFERENCES public.streams(name);


--
-- Name: user_commands user_commands_channel_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_commands
    ADD CONSTRAINT user_commands_channel_fkey FOREIGN KEY (channel) REFERENCES public.streams(name);

