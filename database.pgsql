--
-- PostgreSQL database dump
--

-- Dumped from database version 10.6 (Ubuntu 10.6-0ubuntu0.18.04.1)
-- Dumped by pg_dump version 10.6 (Ubuntu 10.6-0ubuntu0.18.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner:
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner:
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: active_admin_comments; Type: TABLE; Schema: public; Owner: instajax
--

CREATE TABLE public.active_admin_comments (
    id bigint NOT NULL,
    namespace character varying,
    body text,
    resource_type character varying,
    resource_id bigint,
    author_type character varying,
    author_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.active_admin_comments OWNER TO instajax;

--
-- Name: active_admin_comments_id_seq; Type: SEQUENCE; Schema: public; Owner: instajax
--

CREATE SEQUENCE public.active_admin_comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.active_admin_comments_id_seq OWNER TO instajax;

--
-- Name: active_admin_comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: instajax
--

ALTER SEQUENCE public.active_admin_comments_id_seq OWNED BY public.active_admin_comments.id;


--
-- Name: admin_users; Type: TABLE; Schema: public; Owner: instajax
--

CREATE TABLE public.admin_users (
    id bigint NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.admin_users OWNER TO instajax;

--
-- Name: admin_users_id_seq; Type: SEQUENCE; Schema: public; Owner: instajax
--

CREATE SEQUENCE public.admin_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.admin_users_id_seq OWNER TO instajax;

--
-- Name: admin_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: instajax
--

ALTER SEQUENCE public.admin_users_id_seq OWNED BY public.admin_users.id;


--
-- Name: apis; Type: TABLE; Schema: public; Owner: instajax
--

CREATE TABLE public.apis (
    id bigint NOT NULL,
    name character varying,
    url character varying,
    key_attr character varying,
    key character varying,
    action_attr character varying,
    orderid_attr character varying,
    amount_attr character varying,
    link_attr character varying,
    type_attr character varying,
    custom_comments_attr character varying,
    username character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.apis OWNER TO instajax;

--
-- Name: apis_id_seq; Type: SEQUENCE; Schema: public; Owner: instajax
--

CREATE SEQUENCE public.apis_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.apis_id_seq OWNER TO instajax;

--
-- Name: apis_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: instajax
--

ALTER SEQUENCE public.apis_id_seq OWNED BY public.apis.id;


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: instajax
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.ar_internal_metadata OWNER TO instajax;

--
-- Name: clients; Type: TABLE; Schema: public; Owner: instajax
--

CREATE TABLE public.clients (
    id bigint NOT NULL,
    email character varying,
    phone_number character varying,
    first_name character varying,
    last_name character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.clients OWNER TO instajax;

--
-- Name: clients_id_seq; Type: SEQUENCE; Schema: public; Owner: instajax
--

CREATE SEQUENCE public.clients_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.clients_id_seq OWNER TO instajax;

--
-- Name: clients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: instajax
--

ALTER SEQUENCE public.clients_id_seq OWNED BY public.clients.id;


--
-- Name: comments; Type: TABLE; Schema: public; Owner: instajax
--

CREATE TABLE public.comments (
    id bigint NOT NULL,
    text character varying,
    order_detail_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.comments OWNER TO instajax;

--
-- Name: comments_id_seq; Type: SEQUENCE; Schema: public; Owner: instajax
--

CREATE SEQUENCE public.comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.comments_id_seq OWNER TO instajax;

--
-- Name: comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: instajax
--

ALTER SEQUENCE public.comments_id_seq OWNED BY public.comments.id;


--
-- Name: order_details; Type: TABLE; Schema: public; Owner: instajax
--

CREATE TABLE public.order_details (
    id bigint NOT NULL,
    link character varying,
    amount integer,
    api_order_id character varying,
    status integer DEFAULT 0,
    order_row_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.order_details OWNER TO instajax;

--
-- Name: order_details_id_seq; Type: SEQUENCE; Schema: public; Owner: instajax
--

CREATE SEQUENCE public.order_details_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.order_details_id_seq OWNER TO instajax;

--
-- Name: order_details_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: instajax
--

ALTER SEQUENCE public.order_details_id_seq OWNED BY public.order_details.id;


--
-- Name: order_rows; Type: TABLE; Schema: public; Owner: instajax
--

CREATE TABLE public.order_rows (
    id bigint NOT NULL,
    order_code character varying,
    verified boolean DEFAULT false,
    service_id bigint,
    client_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    paid double precision,
    payment_id character varying
);


ALTER TABLE public.order_rows OWNER TO instajax;

--
-- Name: order_rows_id_seq; Type: SEQUENCE; Schema: public; Owner: instajax
--

CREATE SEQUENCE public.order_rows_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.order_rows_id_seq OWNER TO instajax;

--
-- Name: order_rows_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: instajax
--

ALTER SEQUENCE public.order_rows_id_seq OWNED BY public.order_rows.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: instajax
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO instajax;

--
-- Name: services; Type: TABLE; Schema: public; Owner: instajax
--

CREATE TABLE public.services (
    id bigint NOT NULL,
    description character varying,
    s_type character varying,
    service_family integer,
    minimum integer,
    maximum integer,
    price double precision,
    unit integer,
    factor double precision,
    power double precision,
    intercept double precision,
    sale double precision,
    has_note boolean DEFAULT false,
    note character varying,
    req_method integer,
    active boolean DEFAULT true,
    custom_comments_flag boolean DEFAULT false,
    api_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.services OWNER TO instajax;

--
-- Name: services_id_seq; Type: SEQUENCE; Schema: public; Owner: instajax
--

CREATE SEQUENCE public.services_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.services_id_seq OWNER TO instajax;

--
-- Name: services_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: instajax
--

ALTER SEQUENCE public.services_id_seq OWNED BY public.services.id;


--
-- Name: active_admin_comments id; Type: DEFAULT; Schema: public; Owner: instajax
--

ALTER TABLE ONLY public.active_admin_comments ALTER COLUMN id SET DEFAULT nextval('public.active_admin_comments_id_seq'::regclass);


--
-- Name: admin_users id; Type: DEFAULT; Schema: public; Owner: instajax
--

ALTER TABLE ONLY public.admin_users ALTER COLUMN id SET DEFAULT nextval('public.admin_users_id_seq'::regclass);


--
-- Name: apis id; Type: DEFAULT; Schema: public; Owner: instajax
--

ALTER TABLE ONLY public.apis ALTER COLUMN id SET DEFAULT nextval('public.apis_id_seq'::regclass);


--
-- Name: clients id; Type: DEFAULT; Schema: public; Owner: instajax
--

ALTER TABLE ONLY public.clients ALTER COLUMN id SET DEFAULT nextval('public.clients_id_seq'::regclass);


--
-- Name: comments id; Type: DEFAULT; Schema: public; Owner: instajax
--

ALTER TABLE ONLY public.comments ALTER COLUMN id SET DEFAULT nextval('public.comments_id_seq'::regclass);


--
-- Name: order_details id; Type: DEFAULT; Schema: public; Owner: instajax
--

ALTER TABLE ONLY public.order_details ALTER COLUMN id SET DEFAULT nextval('public.order_details_id_seq'::regclass);


--
-- Name: order_rows id; Type: DEFAULT; Schema: public; Owner: instajax
--

ALTER TABLE ONLY public.order_rows ALTER COLUMN id SET DEFAULT nextval('public.order_rows_id_seq'::regclass);


--
-- Name: services id; Type: DEFAULT; Schema: public; Owner: instajax
--

ALTER TABLE ONLY public.services ALTER COLUMN id SET DEFAULT nextval('public.services_id_seq'::regclass);


--
-- Data for Name: active_admin_comments; Type: TABLE DATA; Schema: public; Owner: instajax
--

COPY public.active_admin_comments (id, namespace, body, resource_type, resource_id, author_type, author_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: admin_users; Type: TABLE DATA; Schema: public; Owner: instajax
--

COPY public.admin_users (id, email, encrypted_password, reset_password_token, reset_password_sent_at, remember_created_at, created_at, updated_at) FROM stdin;
1	instajax@instajax.com	$2a$11$w0KQsnzCuyRG5U/z7MH8i.MyxymRJC0HrD8qe/fuZ.U.LQt4Qx0Uy	\N	\N	\N	2018-11-22 14:39:42.45402	2018-11-22 14:39:42.45402
\.


--
-- Data for Name: apis; Type: TABLE DATA; Schema: public; Owner: instajax
--

COPY public.apis (id, name, url, key_attr, key, action_attr, orderid_attr, amount_attr, link_attr, type_attr, custom_comments_attr, username, created_at, updated_at) FROM stdin;
1	po	htp	key	123	action	orderid	amount	link	type	cc	po	2018-11-22 14:54:59.916749	2018-11-22 14:54:59.916749
\.


--
-- Data for Name: ar_internal_metadata; Type: TABLE DATA; Schema: public; Owner: instajax
--

COPY public.ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
environment	development	2018-11-22 14:35:49.484621	2018-11-22 14:35:49.484621
\.


--
-- Data for Name: clients; Type: TABLE DATA; Schema: public; Owner: instajax
--

COPY public.clients (id, email, phone_number, first_name, last_name, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: comments; Type: TABLE DATA; Schema: public; Owner: instajax
--

COPY public.comments (id, text, order_detail_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: order_details; Type: TABLE DATA; Schema: public; Owner: instajax
--

COPY public.order_details (id, link, amount, api_order_id, status, order_row_id, created_at, updated_at) FROM stdin;
1	https://www.instagram.com/p/BmQ5umnHXFu	30	\N	0	1	2018-12-02 14:01:54.393943	2018-12-02 14:01:54.393943
2	https://www.instagram.com/p/BmQ5umnHXFu	30	\N	0	2	2018-12-02 18:41:57.182445	2018-12-02 18:41:57.182445
3	https://www.instagram.com/p/BmQ5umnHXFu	30	\N	0	3	2018-12-02 18:43:56.232506	2018-12-02 18:43:56.232506
4	https://www.instagram.com/p/BmQ5umnHXFu	30	\N	0	4	2018-12-02 18:50:28.363321	2018-12-02 18:50:28.363321
5	https://www.instagram.com/p/BmQ5umnHXFu	30	\N	0	5	2018-12-02 18:55:11.376454	2018-12-02 18:55:11.376454
6	https://www.instagram.com/p/BmQ5umnHXFu	30	\N	0	6	2018-12-02 18:59:09.48325	2018-12-02 18:59:09.48325
7	https://www.instagram.com/p/BmQ5umnHXFu	30	\N	0	7	2018-12-02 19:00:35.267558	2018-12-02 19:00:35.267558
8	https://www.instagram.com/p/BmQ5umnHXFu	30	\N	0	8	2018-12-02 19:03:12.656933	2018-12-02 19:03:12.656933
9	https://www.instagram.com/p/BmQ5umnHXFu	30	\N	0	9	2018-12-02 19:05:41.359513	2018-12-02 19:05:41.359513
10	https://www.instagram.com/p/BmQ5umnHXFu	30	\N	0	10	2018-12-02 19:15:12.858627	2018-12-02 19:15:12.858627
11	https://www.instagram.com/p/BmQ5umnHXFu	30	\N	0	11	2018-12-02 19:22:58.474443	2018-12-02 19:22:58.474443
12	https://www.instagram.com/p/BmQ5umnHXFu	33	\N	0	12	2018-12-04 10:57:27.052481	2018-12-04 10:57:27.052481
13	https://www.instagram.com/p/Bm2-_yMn5Je	50	\N	0	13	2019-01-13 19:38:57.318788	2019-01-13 19:38:57.318788
14	https://www.instagram.com/p/Bm2-_yMn5Je	30	\N	0	14	2019-01-14 18:45:04.916802	2019-01-14 18:45:04.916802
15	https://www.instagram.com/p/Bm2-_yMn5Je	30	\N	0	15	2019-01-14 18:47:29.504159	2019-01-14 18:47:29.504159
16	https://www.instagram.com/p/Bm2-_yMn5Je	30	\N	0	16	2019-01-14 19:13:49.523151	2019-01-14 19:13:49.523151
17	https://www.instagram.com/p/Bm6AMFeH8wi	30	\N	0	17	2019-01-15 16:57:34.666153	2019-01-15 16:57:34.666153
18	https://www.instagram.com/p/Bm2-_yMn5Je	30	\N	0	19	2019-01-16 20:46:44.31057	2019-01-16 20:46:44.31057
19	https://www.instagram.com/p/Bm2-_yMn5Je	30	\N	0	20	2019-01-16 20:50:23.949026	2019-01-16 20:50:23.949026
20	https://www.instagram.com/p/Bm0RtuqnCvt	60	\N	0	20	2019-01-16 20:50:23.951906	2019-01-16 20:50:23.951906
21	https://www.instagram.com/p/BmQ5umnHXFu	33	\N	0	20	2019-01-16 20:50:23.955376	2019-01-16 20:50:23.955376
22	https://www.instagram.com/p/Bm2-_yMn5Je	30	\N	0	21	2019-01-16 21:08:28.8033	2019-01-16 21:08:28.8033
23	https://www.instagram.com/p/BmQ5umnHXFu	60	\N	0	21	2019-01-16 21:08:28.807346	2019-01-16 21:08:28.807346
24	https://www.instagram.com/p/Bm2-_yMn5Je	60	\N	0	22	2019-01-16 21:09:33.925039	2019-01-16 21:09:33.925039
25	https://www.instagram.com/p/BmQ5umnHXFu	96	\N	0	22	2019-01-16 21:09:33.92894	2019-01-16 21:09:33.92894
26	https://www.instagram.com/p/Bm6AMFeH8wi	60	\N	0	23	2019-01-16 21:16:12.905276	2019-01-16 21:16:12.905276
27	https://www.instagram.com/p/Bm2-_yMn5Je	60	\N	0	23	2019-01-16 21:16:12.924218	2019-01-16 21:16:12.924218
28	https://www.instagram.com/p/Bm6AMFeH8wi	30	\N	0	24	2019-01-16 21:17:48.896729	2019-01-16 21:17:48.896729
29	https://www.instagram.com/p/Bm2-_yMn5Je	30	\N	0	24	2019-01-16 21:17:48.91683	2019-01-16 21:17:48.91683
\.


--
-- Data for Name: order_rows; Type: TABLE DATA; Schema: public; Owner: instajax
--

COPY public.order_rows (id, order_code, verified, service_id, client_id, created_at, updated_at, paid, payment_id) FROM stdin;
1	\N	f	1	\N	2018-12-02 14:01:54.369641	2018-12-02 14:01:54.369641	\N	\N
2	\N	f	1	\N	2018-12-02 18:41:57.170671	2018-12-02 18:41:57.170671	\N	\N
3	\N	f	1	\N	2018-12-02 18:43:56.201432	2018-12-02 18:43:56.201432	\N	\N
4	\N	f	1	\N	2018-12-02 18:50:28.327791	2018-12-02 18:50:28.327791	\N	\N
5	\N	f	1	\N	2018-12-02 18:55:11.363874	2018-12-02 18:55:11.363874	31	\N
6	order-code	f	1	\N	2018-12-02 18:59:09.447994	2018-12-02 18:59:09.447994	31	\N
7	order-code	f	1	\N	2018-12-02 19:00:35.253276	2018-12-02 19:00:35.253276	31	\N
8	order-code	f	1	\N	2018-12-02 19:03:12.637348	2018-12-02 19:03:12.637348	31	\N
9	order-code	f	1	\N	2018-12-02 19:05:41.349175	2018-12-02 19:05:41.349175	31	\N
10	order-code	f	1	\N	2018-12-02 19:15:12.847727	2018-12-02 19:15:21.094726	31	PAY-8MM74102TP545933SLQCC6SA
11	order-code	f	1	\N	2018-12-02 19:22:58.451146	2018-12-02 19:23:31.820388	31	PAY-214926382M555472LLQCDCMY
12	order-code	f	1	\N	2018-12-04 10:57:27.027571	2018-12-04 10:57:30.289985	34	PAY-8B170075S98799630LQDF3GQ
13	order-code	f	1	\N	2019-01-13 19:38:57.300925	2019-01-13 19:38:57.300925	51	\N
14	order-code	f	1	\N	2019-01-14 18:45:04.902955	2019-01-14 18:45:04.902955	31	\N
15	order-code	f	1	\N	2019-01-14 18:47:29.493304	2019-01-14 18:47:32.817869	31	PAY-43B474223D510452DLQ6NSRA
16	order-code	f	1	\N	2019-01-14 19:13:49.511238	2019-01-14 19:13:49.511238	31	\N
17	order-code	f	1	\N	2019-01-15 16:57:34.653003	2019-01-15 16:57:38.69892	31	PAY-7U6189629K4143927LQ7BCAQ
18	order-code	f	1	\N	2019-01-16 20:44:45.434821	2019-01-16 20:44:45.434821	31	\N
19	order-code	f	1	\N	2019-01-16 20:46:44.287733	2019-01-16 20:46:47.5428	31	PAY-39L42086EX9435948LQ7ZQNY
20	order-code	f	1	\N	2019-01-16 20:50:23.945444	2019-01-16 20:50:23.945444	124	\N
21	order-code	f	1	\N	2019-01-16 21:08:28.797981	2019-01-16 21:08:28.797981	91	\N
22	order-code	f	1	\N	2019-01-16 21:09:33.920281	2019-01-16 21:09:33.920281	157	\N
23	order-code	t	1	\N	2019-01-16 21:16:12.883256	2019-01-16 21:16:15.02161	121	\N
24	order-code	t	1	\N	2019-01-16 21:17:48.876792	2019-01-16 21:17:51.730854	61	\N
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: instajax
--

COPY public.schema_migrations (version) FROM stdin;
20181122142721
20181122143134
20181122143719
20181122143720
20181122154443
20181122155045
20181122155421
20181122155457
20181202185128
20181202190007
20190116201734
\.


--
-- Data for Name: services; Type: TABLE DATA; Schema: public; Owner: instajax
--

COPY public.services (id, description, s_type, service_family, minimum, maximum, price, unit, factor, power, intercept, sale, has_note, note, req_method, active, custom_comments_flag, api_id, created_at, updated_at) FROM stdin;
1	likes	k_ss	0	25	150	1	1	1	1	1	0	f		0	t	f	1	2018-12-02 08:24:44.210325	2018-12-02 08:24:44.210325
\.


--
-- Name: active_admin_comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: instajax
--

SELECT pg_catalog.setval('public.active_admin_comments_id_seq', 1, false);


--
-- Name: admin_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: instajax
--

SELECT pg_catalog.setval('public.admin_users_id_seq', 1, true);


--
-- Name: apis_id_seq; Type: SEQUENCE SET; Schema: public; Owner: instajax
--

SELECT pg_catalog.setval('public.apis_id_seq', 1, true);


--
-- Name: clients_id_seq; Type: SEQUENCE SET; Schema: public; Owner: instajax
--

SELECT pg_catalog.setval('public.clients_id_seq', 1, false);


--
-- Name: comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: instajax
--

SELECT pg_catalog.setval('public.comments_id_seq', 1, false);


--
-- Name: order_details_id_seq; Type: SEQUENCE SET; Schema: public; Owner: instajax
--

SELECT pg_catalog.setval('public.order_details_id_seq', 29, true);


--
-- Name: order_rows_id_seq; Type: SEQUENCE SET; Schema: public; Owner: instajax
--

SELECT pg_catalog.setval('public.order_rows_id_seq', 24, true);


--
-- Name: services_id_seq; Type: SEQUENCE SET; Schema: public; Owner: instajax
--

SELECT pg_catalog.setval('public.services_id_seq', 1, true);


--
-- Name: active_admin_comments active_admin_comments_pkey; Type: CONSTRAINT; Schema: public; Owner: instajax
--

ALTER TABLE ONLY public.active_admin_comments
    ADD CONSTRAINT active_admin_comments_pkey PRIMARY KEY (id);


--
-- Name: admin_users admin_users_pkey; Type: CONSTRAINT; Schema: public; Owner: instajax
--

ALTER TABLE ONLY public.admin_users
    ADD CONSTRAINT admin_users_pkey PRIMARY KEY (id);


--
-- Name: apis apis_pkey; Type: CONSTRAINT; Schema: public; Owner: instajax
--

ALTER TABLE ONLY public.apis
    ADD CONSTRAINT apis_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: instajax
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: clients clients_pkey; Type: CONSTRAINT; Schema: public; Owner: instajax
--

ALTER TABLE ONLY public.clients
    ADD CONSTRAINT clients_pkey PRIMARY KEY (id);


--
-- Name: comments comments_pkey; Type: CONSTRAINT; Schema: public; Owner: instajax
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- Name: order_details order_details_pkey; Type: CONSTRAINT; Schema: public; Owner: instajax
--

ALTER TABLE ONLY public.order_details
    ADD CONSTRAINT order_details_pkey PRIMARY KEY (id);


--
-- Name: order_rows order_rows_pkey; Type: CONSTRAINT; Schema: public; Owner: instajax
--

ALTER TABLE ONLY public.order_rows
    ADD CONSTRAINT order_rows_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: instajax
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: services services_pkey; Type: CONSTRAINT; Schema: public; Owner: instajax
--

ALTER TABLE ONLY public.services
    ADD CONSTRAINT services_pkey PRIMARY KEY (id);


--
-- Name: index_active_admin_comments_on_author_type_and_author_id; Type: INDEX; Schema: public; Owner: instajax
--

CREATE INDEX index_active_admin_comments_on_author_type_and_author_id ON public.active_admin_comments USING btree (author_type, author_id);


--
-- Name: index_active_admin_comments_on_namespace; Type: INDEX; Schema: public; Owner: instajax
--

CREATE INDEX index_active_admin_comments_on_namespace ON public.active_admin_comments USING btree (namespace);


--
-- Name: index_active_admin_comments_on_resource_type_and_resource_id; Type: INDEX; Schema: public; Owner: instajax
--

CREATE INDEX index_active_admin_comments_on_resource_type_and_resource_id ON public.active_admin_comments USING btree (resource_type, resource_id);


--
-- Name: index_admin_users_on_email; Type: INDEX; Schema: public; Owner: instajax
--

CREATE UNIQUE INDEX index_admin_users_on_email ON public.admin_users USING btree (email);


--
-- Name: index_admin_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: instajax
--

CREATE UNIQUE INDEX index_admin_users_on_reset_password_token ON public.admin_users USING btree (reset_password_token);


--
-- Name: index_comments_on_order_detail_id; Type: INDEX; Schema: public; Owner: instajax
--

CREATE INDEX index_comments_on_order_detail_id ON public.comments USING btree (order_detail_id);


--
-- Name: index_order_details_on_order_row_id; Type: INDEX; Schema: public; Owner: instajax
--

CREATE INDEX index_order_details_on_order_row_id ON public.order_details USING btree (order_row_id);


--
-- Name: index_order_rows_on_client_id; Type: INDEX; Schema: public; Owner: instajax
--

CREATE INDEX index_order_rows_on_client_id ON public.order_rows USING btree (client_id);


--
-- Name: index_order_rows_on_service_id; Type: INDEX; Schema: public; Owner: instajax
--

CREATE INDEX index_order_rows_on_service_id ON public.order_rows USING btree (service_id);


--
-- Name: index_services_on_api_id; Type: INDEX; Schema: public; Owner: instajax
--

CREATE INDEX index_services_on_api_id ON public.services USING btree (api_id);


--
-- Name: services fk_rails_120f26c6ff; Type: FK CONSTRAINT; Schema: public; Owner: instajax
--

ALTER TABLE ONLY public.services
    ADD CONSTRAINT fk_rails_120f26c6ff FOREIGN KEY (api_id) REFERENCES public.apis(id);


--
-- Name: order_details fk_rails_41bf2837b4; Type: FK CONSTRAINT; Schema: public; Owner: instajax
--

ALTER TABLE ONLY public.order_details
    ADD CONSTRAINT fk_rails_41bf2837b4 FOREIGN KEY (order_row_id) REFERENCES public.order_rows(id);


--
-- Name: order_rows fk_rails_9bfe1cc48a; Type: FK CONSTRAINT; Schema: public; Owner: instajax
--

ALTER TABLE ONLY public.order_rows
    ADD CONSTRAINT fk_rails_9bfe1cc48a FOREIGN KEY (client_id) REFERENCES public.clients(id);


--
-- Name: order_rows fk_rails_b9beb1e135; Type: FK CONSTRAINT; Schema: public; Owner: instajax
--

ALTER TABLE ONLY public.order_rows
    ADD CONSTRAINT fk_rails_b9beb1e135 FOREIGN KEY (service_id) REFERENCES public.services(id);


--
-- Name: comments fk_rails_d985b1d53d; Type: FK CONSTRAINT; Schema: public; Owner: instajax
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT fk_rails_d985b1d53d FOREIGN KEY (order_detail_id) REFERENCES public.order_details(id);


--
-- PostgreSQL database dump complete
--

