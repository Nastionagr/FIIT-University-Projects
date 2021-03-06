--
-- PostgreSQL database dump
--

-- Dumped from database version 13.2
-- Dumped by pg_dump version 13.2

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
-- Name: allergens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.allergens (
    id bigint NOT NULL,
    type character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    CONSTRAINT allergens_type_check CHECK (((type)::text = ANY ((ARRAY['contain'::character varying, 'may contain'::character varying])::text[])))
);


ALTER TABLE public.allergens OWNER TO postgres;

--
-- Name: allergens_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.allergens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.allergens_id_seq OWNER TO postgres;

--
-- Name: allergens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.allergens_id_seq OWNED BY public.allergens.id;


--
-- Name: carts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.carts (
    id bigint NOT NULL,
    user_id integer,
    order_id integer,
    product_id integer NOT NULL,
    quantity integer DEFAULT 1 NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.carts OWNER TO postgres;

--
-- Name: carts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.carts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.carts_id_seq OWNER TO postgres;

--
-- Name: carts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.carts_id_seq OWNED BY public.carts.id;


--
-- Name: categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categories (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    url_name character varying(255) NOT NULL,
    description character varying(255),
    parent_category_id integer,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.categories OWNER TO postgres;

--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categories_id_seq OWNER TO postgres;

--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- Name: failed_jobs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.failed_jobs (
    id bigint NOT NULL,
    uuid character varying(255) NOT NULL,
    connection text NOT NULL,
    queue text NOT NULL,
    payload text NOT NULL,
    exception text NOT NULL,
    failed_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.failed_jobs OWNER TO postgres;

--
-- Name: failed_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.failed_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.failed_jobs_id_seq OWNER TO postgres;

--
-- Name: failed_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.failed_jobs_id_seq OWNED BY public.failed_jobs.id;


--
-- Name: gifts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.gifts (
    id bigint NOT NULL,
    number character varying(255) NOT NULL,
    discount integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.gifts OWNER TO postgres;

--
-- Name: gifts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.gifts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.gifts_id_seq OWNER TO postgres;

--
-- Name: gifts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.gifts_id_seq OWNED BY public.gifts.id;


--
-- Name: migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.migrations (
    id integer NOT NULL,
    migration character varying(255) NOT NULL,
    batch integer NOT NULL
);


ALTER TABLE public.migrations OWNER TO postgres;

--
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.migrations_id_seq OWNER TO postgres;

--
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;


--
-- Name: nutrition; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.nutrition (
    id bigint NOT NULL,
    energy_kj integer NOT NULL,
    energy_kcal integer NOT NULL,
    fat double precision NOT NULL,
    fat_saturated double precision NOT NULL,
    carbohydrates double precision NOT NULL,
    carbohydrates_sugar double precision NOT NULL,
    protein double precision NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.nutrition OWNER TO postgres;

--
-- Name: nutrition_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.nutrition_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nutrition_id_seq OWNER TO postgres;

--
-- Name: nutrition_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.nutrition_id_seq OWNED BY public.nutrition.id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    id bigint NOT NULL,
    shipping_price double precision NOT NULL,
    payment_price double precision NOT NULL,
    total double precision NOT NULL,
    paid boolean DEFAULT false NOT NULL,
    shipped boolean DEFAULT false NOT NULL,
    delivered boolean DEFAULT false NOT NULL,
    shipping_method character varying(255) NOT NULL,
    payment_method character varying(255) NOT NULL,
    gift_id integer,
    "firstName" character varying(255) NOT NULL,
    "lastName" character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    phone_number character varying(255) NOT NULL,
    street character varying(255) NOT NULL,
    apartment character varying(255) NOT NULL,
    city character varying(255) NOT NULL,
    zip_code character varying(255) NOT NULL,
    country character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.orders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.orders_id_seq OWNER TO postgres;

--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;


--
-- Name: password_resets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.password_resets (
    email character varying(255) NOT NULL,
    token character varying(255) NOT NULL,
    created_at timestamp(0) without time zone
);


ALTER TABLE public.password_resets OWNER TO postgres;

--
-- Name: personal_access_tokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.personal_access_tokens (
    id bigint NOT NULL,
    tokenable_type character varying(255) NOT NULL,
    tokenable_id bigint NOT NULL,
    name character varying(255) NOT NULL,
    token character varying(64) NOT NULL,
    abilities text,
    last_used_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.personal_access_tokens OWNER TO postgres;

--
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.personal_access_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.personal_access_tokens_id_seq OWNER TO postgres;

--
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.personal_access_tokens_id_seq OWNED BY public.personal_access_tokens.id;


--
-- Name: product_allergens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_allergens (
    id bigint NOT NULL,
    allergen_id integer NOT NULL,
    product_id integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.product_allergens OWNER TO postgres;

--
-- Name: product_allergens_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.product_allergens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.product_allergens_id_seq OWNER TO postgres;

--
-- Name: product_allergens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.product_allergens_id_seq OWNED BY public.product_allergens.id;


--
-- Name: product_categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_categories (
    id bigint NOT NULL,
    category_id integer NOT NULL,
    product_id integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.product_categories OWNER TO postgres;

--
-- Name: product_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.product_categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.product_categories_id_seq OWNER TO postgres;

--
-- Name: product_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.product_categories_id_seq OWNED BY public.product_categories.id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    brand character varying(255) NOT NULL,
    weight integer NOT NULL,
    price double precision NOT NULL,
    quantity integer DEFAULT 0 NOT NULL,
    sold integer DEFAULT 0 NOT NULL,
    images json DEFAULT '["/img/default_product.png"]'::json NOT NULL,
    ingredients json,
    description character varying(255) NOT NULL,
    origin_country character varying(255),
    dimensions character varying(255),
    nutrition_id integer,
    discount integer DEFAULT 0 NOT NULL,
    price_discounted double precision,
    is_offered boolean DEFAULT true NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);


ALTER TABLE public.products OWNER TO postgres;

--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.products_id_seq OWNER TO postgres;

--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    is_admin boolean DEFAULT false NOT NULL,
    first_name character varying(255) NOT NULL,
    last_name character varying(255) NOT NULL,
    username character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    remember_token character varying(100),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: allergens id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.allergens ALTER COLUMN id SET DEFAULT nextval('public.allergens_id_seq'::regclass);


--
-- Name: carts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carts ALTER COLUMN id SET DEFAULT nextval('public.carts_id_seq'::regclass);


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- Name: failed_jobs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.failed_jobs ALTER COLUMN id SET DEFAULT nextval('public.failed_jobs_id_seq'::regclass);


--
-- Name: gifts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gifts ALTER COLUMN id SET DEFAULT nextval('public.gifts_id_seq'::regclass);


--
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- Name: nutrition id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nutrition ALTER COLUMN id SET DEFAULT nextval('public.nutrition_id_seq'::regclass);


--
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


--
-- Name: personal_access_tokens id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personal_access_tokens ALTER COLUMN id SET DEFAULT nextval('public.personal_access_tokens_id_seq'::regclass);


--
-- Name: product_allergens id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_allergens ALTER COLUMN id SET DEFAULT nextval('public.product_allergens_id_seq'::regclass);


--
-- Name: product_categories id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_categories ALTER COLUMN id SET DEFAULT nextval('public.product_categories_id_seq'::regclass);


--
-- Name: products id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: allergens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.allergens (id, type, name, created_at, updated_at) FROM stdin;
1	contain	Peanuts	2021-12-05 17:46:05	2021-12-05 17:46:05
2	contain	Cocoa	2021-12-05 17:46:05	2021-12-05 17:46:05
3	may contain	Eggs	2021-12-05 17:46:05	2021-12-05 17:46:05
4	may contain	Peanuts	2021-12-05 17:46:05	2021-12-05 17:46:05
5	contain	Milk	2021-12-05 17:46:06	2021-12-05 17:46:06
6	contain	Coconut	2021-12-05 17:46:06	2021-12-05 17:46:06
7	may contain	Hazelnuts	2021-12-05 17:46:06	2021-12-05 17:46:06
8	may contain	Cocoa	2021-12-05 17:46:06	2021-12-05 17:46:06
9	may contain	Soybeans	2021-12-05 17:46:06	2021-12-05 17:46:06
10	may contain	Milk	2021-12-05 17:46:06	2021-12-05 17:46:06
11	contain	Hazelnuts	2021-12-05 17:46:06	2021-12-05 17:46:06
12	contain	Cereals	2021-12-05 17:46:06	2021-12-05 17:46:06
13	may contain	Chocolate	2021-12-05 17:46:06	2021-12-05 17:46:06
14	may contain	Cinnamon	2021-12-05 17:46:06	2021-12-05 17:46:06
15	may contain	Pistachio	2021-12-05 17:46:06	2021-12-05 17:46:06
16	may contain	Almonds	2021-12-05 17:46:06	2021-12-05 17:46:06
17	contain	Chocolate	2021-12-05 17:46:06	2021-12-05 17:46:06
18	contain	Eggs	2021-12-05 17:46:06	2021-12-05 17:46:06
19	may contain	Coconut	2021-12-05 17:46:06	2021-12-05 17:46:06
20	contain	Almonds	2021-12-05 17:46:06	2021-12-05 17:46:06
21	contain	Pistachio	2021-12-05 17:46:06	2021-12-05 17:46:06
22	contain	Cinnamon	2021-12-05 17:46:06	2021-12-05 17:46:06
23	may contain	Cereals	2021-12-05 17:46:06	2021-12-05 17:46:06
24	contain	Soybeans	2021-12-05 17:46:06	2021-12-05 17:46:06
\.


--
-- Data for Name: carts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.carts (id, user_id, order_id, product_id, quantity, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categories (id, name, url_name, description, parent_category_id, created_at, updated_at) FROM stdin;
1	Sweets	sweets	\N	\N	2021-12-05 17:46:03	2021-12-05 17:46:03
2	Bars	bars		1	2021-12-05 17:46:03	2021-12-05 17:46:03
3	Biscuits	biscuits		1	2021-12-05 17:46:03	2021-12-05 17:46:03
4	Bonbons	bonbons		1	2021-12-05 17:46:03	2021-12-05 17:46:03
5	Chocolate	chocolate		1	2021-12-05 17:46:03	2021-12-05 17:46:03
6	Gifts	gifts	\N	\N	2021-12-05 17:46:03	2021-12-05 17:46:03
7	Birthday Gifts	birthday-gifts		6	2021-12-05 17:46:03	2021-12-05 17:46:03
8	Wedding Gifts	wedding-gifts		6	2021-12-05 17:46:03	2021-12-05 17:46:03
9	Bulk Candy	bulk-candy	\N	\N	2021-12-05 17:46:03	2021-12-05 17:46:03
10	Boxes	boxes		9	2021-12-05 17:46:03	2021-12-05 17:46:03
11	Jars	jars		9	2021-12-05 17:46:03	2021-12-05 17:46:03
12	Sugar Free & Vegan	sugar-free-vegan	\N	\N	2021-12-05 17:46:03	2021-12-05 17:46:03
13	Vegan	vegan		12	2021-12-05 17:46:03	2021-12-05 17:46:03
14	Sugar Free	sugar-free		12	2021-12-05 17:46:03	2021-12-05 17:46:03
15	Gluten Free	gluten-free		12	2021-12-05 17:46:03	2021-12-05 17:46:03
16	Sale	sale		\N	2021-12-05 17:46:03	2021-12-05 17:46:03
\.


--
-- Data for Name: failed_jobs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.failed_jobs (id, uuid, connection, queue, payload, exception, failed_at) FROM stdin;
\.


--
-- Data for Name: gifts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.gifts (id, number, discount, created_at, updated_at) FROM stdin;
1	K8-Y7-GG-67	15	2021-12-05 17:46:11	2021-12-05 17:46:11
2	HH-YU-5T-6U	25	2021-12-05 17:46:11	2021-12-05 17:46:11
3	F4-T5-WW-XX	30	2021-12-05 17:46:11	2021-12-05 17:46:11
4	NA-NA-67-I3	50	2021-12-05 17:46:11	2021-12-05 17:46:11
5	D3-Y8-W1-11	75	2021-12-05 17:46:11	2021-12-05 17:46:11
6	DU-T5-T5-V1	5	2021-12-05 17:46:11	2021-12-05 17:46:11
7	AA-BB-I9-10	10	2021-12-05 17:46:11	2021-12-05 17:46:11
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.migrations (id, migration, batch) FROM stdin;
1	2014_10_12_000000_create_users_table	1
2	2014_10_12_100000_create_password_resets_table	1
3	2019_08_19_000000_create_failed_jobs_table	1
4	2019_12_14_000001_create_personal_access_tokens_table	1
5	2021_11_19_171410_create_nutrition_table	1
6	2021_11_19_171513_create_products_table	1
7	2021_11_19_172145_create_categories_table	1
8	2021_11_19_173043_create_product_categories_table	1
9	2021_11_19_193836_create_allergens_table	1
10	2021_11_19_204041_create_product_allergens_table	1
11	2021_11_22_140533_create_gifts_table	1
12	2021_11_22_140536_create_orders_table	1
13	2021_11_22_140751_create_carts_table	1
\.


--
-- Data for Name: nutrition; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.nutrition (id, energy_kj, energy_kcal, fat, fat_saturated, carbohydrates, carbohydrates_sugar, protein, created_at, updated_at) FROM stdin;
1	1716	446	28.47	26.08	1.2	11.51	1.7	2021-12-05 17:46:05	2021-12-05 17:46:05
2	2749	351	16.27	24.77	8.66	14.91	14.25	2021-12-05 17:46:05	2021-12-05 17:46:05
3	2863	430	24.21	10.98	5.45	9.89	19.08	2021-12-05 17:46:05	2021-12-05 17:46:05
4	1207	313	8.2	15.15	2.27	14.68	24.68	2021-12-05 17:46:05	2021-12-05 17:46:05
5	2728	229	5.23	22.96	1.82	7.49	11.81	2021-12-05 17:46:05	2021-12-05 17:46:05
6	2432	276	27.29	24.05	7.89	5.63	7.69	2021-12-05 17:46:05	2021-12-05 17:46:05
7	1451	497	10.21	1.86	8.65	9.07	4.91	2021-12-05 17:46:05	2021-12-05 17:46:05
8	2288	497	16.39	24	9.83	7.26	6.83	2021-12-05 17:46:05	2021-12-05 17:46:05
9	2138	150	26.58	4.18	6.55	13.45	4.81	2021-12-05 17:46:05	2021-12-05 17:46:05
10	2056	188	7.54	19.26	8.53	2.45	9.76	2021-12-05 17:46:05	2021-12-05 17:46:05
11	2980	231	11.06	15.7	6.51	14.29	17.45	2021-12-05 17:46:05	2021-12-05 17:46:05
12	1612	196	15.9	23.19	5.55	11.85	15.84	2021-12-05 17:46:05	2021-12-05 17:46:05
13	2851	195	8.36	19.76	0.5	4.84	19.1	2021-12-05 17:46:05	2021-12-05 17:46:05
14	2906	436	1.08	21.67	8.48	8.81	18.7	2021-12-05 17:46:05	2021-12-05 17:46:05
15	1907	221	6.04	18.55	7.79	4.92	23.74	2021-12-05 17:46:05	2021-12-05 17:46:05
16	1612	132	8.12	6.44	5.83	6.34	17.89	2021-12-05 17:46:05	2021-12-05 17:46:05
17	1036	195	2.92	25.75	7.6	14.53	11.03	2021-12-05 17:46:05	2021-12-05 17:46:05
18	1729	361	29.14	10.82	1.28	7.43	12.83	2021-12-05 17:46:05	2021-12-05 17:46:05
19	2830	350	5.23	29.01	1.6	3.78	23.92	2021-12-05 17:46:05	2021-12-05 17:46:05
20	1702	439	14.22	17.65	3.53	13.05	7.9	2021-12-05 17:46:05	2021-12-05 17:46:05
21	1912	190	2.34	29.98	0.27	15	14.67	2021-12-05 17:46:05	2021-12-05 17:46:05
22	1842	298	16.05	6.61	6.21	11.22	11.16	2021-12-05 17:46:05	2021-12-05 17:46:05
23	2700	345	22.13	17.17	2.38	3.01	13.32	2021-12-05 17:46:05	2021-12-05 17:46:05
24	2720	287	26.79	15.79	2.51	1.06	20.71	2021-12-05 17:46:05	2021-12-05 17:46:05
25	2905	481	20.37	27.69	6.57	2.15	8.85	2021-12-05 17:46:05	2021-12-05 17:46:05
26	2642	389	29.95	12.15	4.34	7.17	6.26	2021-12-05 17:46:05	2021-12-05 17:46:05
27	2844	372	9.55	22.57	1.02	12.83	21.65	2021-12-05 17:46:05	2021-12-05 17:46:05
28	2880	337	5.21	24.04	1.63	1.06	14.88	2021-12-05 17:46:05	2021-12-05 17:46:05
29	1072	198	15.31	29.27	1.28	14.12	3.17	2021-12-05 17:46:05	2021-12-05 17:46:05
30	2709	307	2.48	12.16	5.34	6.74	12.1	2021-12-05 17:46:05	2021-12-05 17:46:05
31	2528	417	11.6	2.23	5.59	0.84	19.07	2021-12-05 17:46:05	2021-12-05 17:46:05
32	2664	371	21.96	26.28	9.15	7.56	24.99	2021-12-05 17:46:05	2021-12-05 17:46:05
33	1346	112	10.07	25.44	0.25	1.3	16.27	2021-12-05 17:46:05	2021-12-05 17:46:05
34	1958	349	11.82	22.8	9.5	12.19	15.31	2021-12-05 17:46:05	2021-12-05 17:46:05
35	2846	350	1.27	2.08	7.56	3.18	17.27	2021-12-05 17:46:05	2021-12-05 17:46:05
36	1972	163	6.58	21.15	9.92	12.31	22.95	2021-12-05 17:46:05	2021-12-05 17:46:05
37	1463	233	3.07	15.85	9.97	3.17	20.78	2021-12-05 17:46:05	2021-12-05 17:46:05
38	1457	466	27.77	18.82	7.96	12.81	1.1	2021-12-05 17:46:05	2021-12-05 17:46:05
39	1068	153	0.12	10.2	9.24	3.17	10.18	2021-12-05 17:46:05	2021-12-05 17:46:05
40	2253	394	24.98	25.72	3.74	0.09	9.79	2021-12-05 17:46:05	2021-12-05 17:46:05
41	1526	159	28.86	7.28	7.28	3.05	12.52	2021-12-05 17:46:05	2021-12-05 17:46:05
42	1181	181	15.8	29.65	8.25	7.42	8.58	2021-12-05 17:46:05	2021-12-05 17:46:05
43	1520	264	5.2	27.6	2.64	14.75	18.95	2021-12-05 17:46:05	2021-12-05 17:46:05
44	1849	477	6.6	29.11	9.85	0.31	22.39	2021-12-05 17:46:05	2021-12-05 17:46:05
45	2545	399	26.48	19.84	1.04	1.82	11.63	2021-12-05 17:46:05	2021-12-05 17:46:05
46	2334	426	13.58	5.85	6.89	8.66	22.26	2021-12-05 17:46:05	2021-12-05 17:46:05
47	1052	224	24.67	16.13	4.38	4.33	6.24	2021-12-05 17:46:05	2021-12-05 17:46:05
48	1274	396	19.05	21.41	2.86	7.44	15.01	2021-12-05 17:46:05	2021-12-05 17:46:05
49	1143	253	4.14	7.98	3.79	4.89	23.03	2021-12-05 17:46:05	2021-12-05 17:46:05
50	2144	319	25.02	1.11	0.6	8.23	0.26	2021-12-05 17:46:05	2021-12-05 17:46:05
51	1529	357	25.22	12.34	7.86	6.12	0.73	2021-12-05 17:46:05	2021-12-05 17:46:05
52	2961	449	4.37	11.76	5.17	13.44	1.37	2021-12-05 17:46:05	2021-12-05 17:46:05
53	1942	430	2.01	9.4	4.46	7.81	15.56	2021-12-05 17:46:05	2021-12-05 17:46:05
54	2263	456	23.26	27.03	5.7	6.56	24.16	2021-12-05 17:46:05	2021-12-05 17:46:05
55	2293	269	25.22	22.39	6.99	0.2	11.1	2021-12-05 17:46:05	2021-12-05 17:46:05
56	2123	125	4.85	5.05	7.93	5.19	19.26	2021-12-05 17:46:05	2021-12-05 17:46:05
57	1238	463	8.09	0.36	0.01	1.86	18.1	2021-12-05 17:46:05	2021-12-05 17:46:05
58	2215	195	11.08	11.68	4.18	1.54	14.45	2021-12-05 17:46:05	2021-12-05 17:46:05
59	2640	220	23.78	15.03	4.75	14.15	20.12	2021-12-05 17:46:05	2021-12-05 17:46:05
60	2068	495	26.54	13.73	0.66	0.67	1.01	2021-12-05 17:46:05	2021-12-05 17:46:05
61	2597	482	1.15	27.44	5.33	1.77	5.17	2021-12-05 17:46:05	2021-12-05 17:46:05
62	2431	418	17.33	6.08	1.23	13.47	17.23	2021-12-05 17:46:05	2021-12-05 17:46:05
63	1539	256	16.99	10.86	5.91	12.62	12.5	2021-12-05 17:46:05	2021-12-05 17:46:05
64	1966	289	20.62	4.62	0.56	5.55	12.35	2021-12-05 17:46:05	2021-12-05 17:46:05
65	2689	186	26.9	1.94	1.22	6.07	18.71	2021-12-05 17:46:05	2021-12-05 17:46:05
66	2477	406	13.33	21.99	8.95	1.18	24.52	2021-12-05 17:46:05	2021-12-05 17:46:05
67	1656	390	21.96	15.08	0.25	8.66	11.96	2021-12-05 17:46:05	2021-12-05 17:46:05
68	2453	344	2.99	15.58	3.71	5.27	5.81	2021-12-05 17:46:05	2021-12-05 17:46:05
69	1910	306	29.1	20.87	3.23	4	7.41	2021-12-05 17:46:05	2021-12-05 17:46:05
70	2035	247	26.47	3.02	4.65	11.29	5.51	2021-12-05 17:46:05	2021-12-05 17:46:05
71	1270	428	14.79	7.73	3.4	13.89	18.99	2021-12-05 17:46:05	2021-12-05 17:46:05
72	1594	471	25.08	7.81	9.86	9.57	6.09	2021-12-05 17:46:05	2021-12-05 17:46:05
73	2333	133	0.49	14.7	6.74	0.48	19.74	2021-12-05 17:46:05	2021-12-05 17:46:05
74	2050	357	11.05	25.02	9.68	9.46	17.69	2021-12-05 17:46:05	2021-12-05 17:46:05
75	2935	356	1.44	18.4	5.37	12.75	7.43	2021-12-05 17:46:05	2021-12-05 17:46:05
76	2814	265	11.13	13.62	1.88	1.82	7.68	2021-12-05 17:46:05	2021-12-05 17:46:05
77	1862	441	14.44	15.26	7.44	11.47	14.99	2021-12-05 17:46:05	2021-12-05 17:46:05
78	1423	351	11.65	0.59	4.42	3.59	10.33	2021-12-05 17:46:05	2021-12-05 17:46:05
79	1351	321	12.38	27.3	1.31	5.11	5.49	2021-12-05 17:46:05	2021-12-05 17:46:05
80	1471	168	3.26	2.52	7.52	13.65	10.63	2021-12-05 17:46:05	2021-12-05 17:46:05
81	2602	342	9.73	25.16	6.65	12.45	10.56	2021-12-05 17:46:05	2021-12-05 17:46:05
82	1717	207	15.45	26.45	8.19	9.24	9.19	2021-12-05 17:46:05	2021-12-05 17:46:05
83	2090	195	19.87	21.16	2.55	2.68	2.45	2021-12-05 17:46:05	2021-12-05 17:46:05
84	1239	445	19.78	21.89	1.24	12	4.59	2021-12-05 17:46:05	2021-12-05 17:46:05
85	2570	245	4.79	14.08	9.91	2.4	18.75	2021-12-05 17:46:05	2021-12-05 17:46:05
86	1831	156	13.98	7.52	3.95	0.58	16.43	2021-12-05 17:46:05	2021-12-05 17:46:05
87	1728	495	11.08	12.62	1.04	10.81	17.38	2021-12-05 17:46:05	2021-12-05 17:46:05
88	1257	255	25.65	4.48	6.1	9.51	1.84	2021-12-05 17:46:05	2021-12-05 17:46:05
89	1046	185	0.28	17.95	9.8	1.48	0.31	2021-12-05 17:46:05	2021-12-05 17:46:05
90	1539	142	10.5	19.27	3.79	7.49	10.23	2021-12-05 17:46:05	2021-12-05 17:46:05
91	2917	112	28.59	13.59	2.4	12.19	15.41	2021-12-05 17:46:05	2021-12-05 17:46:05
92	1513	485	15.92	11.19	0.71	5.63	15.21	2021-12-05 17:46:05	2021-12-05 17:46:05
93	1953	339	15.43	7.77	5.22	1.2	11.93	2021-12-05 17:46:05	2021-12-05 17:46:05
94	1119	286	26.31	15.44	5.81	12.18	23.3	2021-12-05 17:46:05	2021-12-05 17:46:05
95	2068	142	16.84	27.69	3.7	11.75	20.25	2021-12-05 17:46:05	2021-12-05 17:46:05
96	1293	259	3.03	17.69	0.11	6.44	23.37	2021-12-05 17:46:05	2021-12-05 17:46:05
97	2977	390	14.17	23.03	2.44	7.01	17.73	2021-12-05 17:46:05	2021-12-05 17:46:05
98	2162	158	15.76	24.21	7.67	8.74	3.1	2021-12-05 17:46:05	2021-12-05 17:46:05
99	2136	158	14.98	28.66	4.33	2.46	14.08	2021-12-05 17:46:05	2021-12-05 17:46:05
100	1163	164	29.68	11.45	9.08	7.89	6.48	2021-12-05 17:46:05	2021-12-05 17:46:05
101	2354	166	13.75	23.68	7.69	1.88	4.26	2021-12-05 17:46:05	2021-12-05 17:46:05
102	2770	249	15.9	15.74	3.76	13.3	10.25	2021-12-05 17:46:05	2021-12-05 17:46:05
103	2963	401	2.2	27.95	8.49	6.77	0.73	2021-12-05 17:46:05	2021-12-05 17:46:05
104	1843	200	6.68	13.89	5.22	10.3	16.97	2021-12-05 17:46:05	2021-12-05 17:46:05
105	2768	453	0.27	23.13	3.95	4.12	12.6	2021-12-05 17:46:05	2021-12-05 17:46:05
106	1034	403	5.68	11.45	0.1	4.1	9.38	2021-12-05 17:46:05	2021-12-05 17:46:05
107	2066	166	23.46	7.67	7.67	1.17	16.43	2021-12-05 17:46:05	2021-12-05 17:46:05
108	1563	212	13.79	8.82	1.41	3.49	12.87	2021-12-05 17:46:05	2021-12-05 17:46:05
109	1479	434	6.49	20.07	8.56	10.28	4.84	2021-12-05 17:46:05	2021-12-05 17:46:05
110	1462	419	9.43	13.1	1.15	8.13	1.02	2021-12-05 17:46:05	2021-12-05 17:46:05
111	1917	178	26.85	13.99	4.51	4.34	16.05	2021-12-05 17:46:05	2021-12-05 17:46:05
112	1743	185	10.9	4.25	5.74	8.63	21.64	2021-12-05 17:46:05	2021-12-05 17:46:05
113	2363	357	7.58	4.52	0.4	8.67	13.78	2021-12-05 17:46:05	2021-12-05 17:46:05
114	2462	282	28.54	16.12	0.21	1.41	1.47	2021-12-05 17:46:05	2021-12-05 17:46:05
115	2895	475	20.09	8.15	1.24	9.11	19.43	2021-12-05 17:46:05	2021-12-05 17:46:05
116	2676	275	0.65	28.12	9.7	6.46	17.01	2021-12-05 17:46:05	2021-12-05 17:46:05
117	1967	119	28.37	19.52	9.15	12.5	11.7	2021-12-05 17:46:05	2021-12-05 17:46:05
118	2664	155	13.39	15.75	4.83	3.89	12.32	2021-12-05 17:46:05	2021-12-05 17:46:05
119	1151	300	22.39	2.4	8.02	2.53	11.28	2021-12-05 17:46:05	2021-12-05 17:46:05
120	2338	114	28.38	21.97	8.46	8.95	0.06	2021-12-05 17:46:05	2021-12-05 17:46:05
121	1510	412	26.76	0.84	8.6	9.9	12.48	2021-12-05 17:46:05	2021-12-05 17:46:05
122	2640	123	10.14	25.86	9.47	5.72	16.7	2021-12-05 17:46:05	2021-12-05 17:46:05
123	2125	302	29.79	10.74	4.26	3.82	2.07	2021-12-05 17:46:05	2021-12-05 17:46:05
124	1664	245	15.66	8.68	4.54	12.83	2.67	2021-12-05 17:46:05	2021-12-05 17:46:05
125	1271	407	10.09	29.62	5.13	5.64	15.88	2021-12-05 17:46:05	2021-12-05 17:46:05
126	1542	193	19.07	21.65	5.8	14.79	13.04	2021-12-05 17:46:05	2021-12-05 17:46:05
127	3000	175	21.84	24.23	1.8	10.32	18.25	2021-12-05 17:46:05	2021-12-05 17:46:05
128	1445	221	16.14	2.1	6.34	2.69	9.74	2021-12-05 17:46:05	2021-12-05 17:46:05
129	1357	332	9.42	29.2	8.41	7.01	13.14	2021-12-05 17:46:05	2021-12-05 17:46:05
130	2121	295	2.88	21.97	1.85	11.75	2.58	2021-12-05 17:46:05	2021-12-05 17:46:05
131	1633	226	16.42	17.73	7.88	9.27	17.83	2021-12-05 17:46:05	2021-12-05 17:46:05
132	1745	252	12.48	26.22	8.83	3.17	20.54	2021-12-05 17:46:05	2021-12-05 17:46:05
133	2462	193	6.19	26.8	1.66	10.09	13.25	2021-12-05 17:46:05	2021-12-05 17:46:05
134	2865	337	16.18	1.17	1.79	14.34	15.51	2021-12-05 17:46:05	2021-12-05 17:46:05
135	1126	470	15.87	13.42	6.92	8.73	1.26	2021-12-05 17:46:05	2021-12-05 17:46:05
136	1028	213	15.4	6.15	3.72	12.03	12.88	2021-12-05 17:46:05	2021-12-05 17:46:05
137	2323	102	7.46	28.31	9.14	6.58	12.87	2021-12-05 17:46:05	2021-12-05 17:46:05
138	1871	243	11.69	4.62	7.42	14.92	1.59	2021-12-05 17:46:05	2021-12-05 17:46:05
139	2109	181	25.17	6.11	3.17	14.52	17.58	2021-12-05 17:46:05	2021-12-05 17:46:05
140	2045	322	14.08	22.16	6.8	8.45	7.34	2021-12-05 17:46:05	2021-12-05 17:46:05
141	1650	232	4.99	18.84	2.68	1.51	21.13	2021-12-05 17:46:05	2021-12-05 17:46:05
142	1780	272	13.97	6.84	2.98	2.16	14.76	2021-12-05 17:46:05	2021-12-05 17:46:05
143	1135	392	17.85	2.85	9.35	4.15	1.66	2021-12-05 17:46:05	2021-12-05 17:46:05
144	2126	296	9.82	8.63	8.49	13.72	1.04	2021-12-05 17:46:05	2021-12-05 17:46:05
145	1400	385	19.83	24.66	5.93	8.69	1.23	2021-12-05 17:46:05	2021-12-05 17:46:05
146	1713	463	19.64	9.31	0.07	13.11	13.09	2021-12-05 17:46:05	2021-12-05 17:46:05
147	1157	150	16.68	12.36	4.62	10.16	24.78	2021-12-05 17:46:05	2021-12-05 17:46:05
148	2509	485	17.81	10.8	4.05	14.06	17.24	2021-12-05 17:46:05	2021-12-05 17:46:05
149	2725	434	7.33	17.37	9.23	9.14	5.76	2021-12-05 17:46:05	2021-12-05 17:46:05
150	1052	488	24.3	19.64	5.92	2.09	17.7	2021-12-05 17:46:05	2021-12-05 17:46:05
151	2271	123	5.58	16.07	4.42	7.95	10.87	2021-12-05 17:46:05	2021-12-05 17:46:05
152	2407	269	28.36	12.44	7.7	8.18	10.31	2021-12-05 17:46:05	2021-12-05 17:46:05
153	2601	410	15.09	14.97	2.83	11.94	12.79	2021-12-05 17:46:05	2021-12-05 17:46:05
154	2517	311	8.97	0.21	4.95	11.53	0.25	2021-12-05 17:46:05	2021-12-05 17:46:05
155	2838	152	15.86	1.38	5.95	9.49	2.72	2021-12-05 17:46:05	2021-12-05 17:46:05
156	2390	406	5.61	28.62	7.2	4.58	2.42	2021-12-05 17:46:05	2021-12-05 17:46:05
157	2167	242	18.37	3.56	6.66	0.83	5.75	2021-12-05 17:46:05	2021-12-05 17:46:05
158	1690	338	0.36	12.23	3.23	2.03	18.4	2021-12-05 17:46:05	2021-12-05 17:46:05
159	1599	290	25.8	28.22	1.22	7.63	5.71	2021-12-05 17:46:05	2021-12-05 17:46:05
160	2925	279	22.34	17.2	3.21	1.52	3.35	2021-12-05 17:46:05	2021-12-05 17:46:05
161	1625	179	12.89	2.89	6.64	3.88	7.55	2021-12-05 17:46:05	2021-12-05 17:46:05
162	1213	374	23.69	4.48	6.33	4.06	3.25	2021-12-05 17:46:05	2021-12-05 17:46:05
163	1398	114	25.03	20.57	5.38	1	18.99	2021-12-05 17:46:05	2021-12-05 17:46:05
164	2716	148	13.76	9.95	6.34	3.16	22.17	2021-12-05 17:46:05	2021-12-05 17:46:05
165	1220	303	11.83	25.84	9.14	1.82	17.87	2021-12-05 17:46:05	2021-12-05 17:46:05
166	2197	412	8.38	28.91	2.56	12.93	11.94	2021-12-05 17:46:05	2021-12-05 17:46:05
167	1857	500	25.51	6.03	4.94	5.31	3.79	2021-12-05 17:46:05	2021-12-05 17:46:05
168	2965	267	18.88	27.52	2.47	0.59	3.93	2021-12-05 17:46:05	2021-12-05 17:46:05
169	2073	417	11.8	14.03	8.4	7.99	15.26	2021-12-05 17:46:05	2021-12-05 17:46:05
170	2305	403	22.41	6.92	3.43	5.18	4.85	2021-12-05 17:46:05	2021-12-05 17:46:05
171	2102	189	9.52	5.82	8.34	2.88	18.01	2021-12-05 17:46:05	2021-12-05 17:46:05
172	1579	281	29.17	17.03	0.86	8.12	22.54	2021-12-05 17:46:05	2021-12-05 17:46:05
173	1802	411	8.51	23.04	6.48	13.71	14.4	2021-12-05 17:46:05	2021-12-05 17:46:05
174	1497	303	9.15	22.73	4.99	13.25	0.4	2021-12-05 17:46:05	2021-12-05 17:46:05
175	1479	363	15.03	23.47	7.54	12.53	13.52	2021-12-05 17:46:05	2021-12-05 17:46:05
176	2458	292	20.86	18.8	6.13	4.91	14.06	2021-12-05 17:46:05	2021-12-05 17:46:05
177	1504	252	17.14	6.52	2.27	13.99	23.07	2021-12-05 17:46:05	2021-12-05 17:46:05
178	1734	264	21.7	10.55	5.75	10.07	1.94	2021-12-05 17:46:05	2021-12-05 17:46:05
179	1458	140	14.27	19.81	2.39	13.65	13.34	2021-12-05 17:46:05	2021-12-05 17:46:05
180	2281	454	10.46	1.55	1.74	7.43	10.07	2021-12-05 17:46:05	2021-12-05 17:46:05
181	1174	187	10.76	2.35	2.06	9.57	16.66	2021-12-05 17:46:05	2021-12-05 17:46:05
182	2084	246	12.11	18.67	9.02	3.15	3.97	2021-12-05 17:46:05	2021-12-05 17:46:05
183	1805	454	17.56	2.63	7.29	4.59	4.75	2021-12-05 17:46:05	2021-12-05 17:46:05
184	1191	311	25.6	22.19	1.68	1.09	12.95	2021-12-05 17:46:05	2021-12-05 17:46:05
185	1446	330	14.02	10.87	6.36	2.36	23.9	2021-12-05 17:46:05	2021-12-05 17:46:05
186	1023	186	21.06	21.3	7.73	8.72	6.64	2021-12-05 17:46:05	2021-12-05 17:46:05
187	1068	491	7.57	2.45	4.27	9.9	8.39	2021-12-05 17:46:05	2021-12-05 17:46:05
188	1199	150	20.11	27.41	7.38	4.28	7.92	2021-12-05 17:46:05	2021-12-05 17:46:05
189	2443	213	23.38	7.25	5.45	1.35	11.34	2021-12-05 17:46:05	2021-12-05 17:46:05
190	2478	435	17.06	24.12	6.78	7.54	0.97	2021-12-05 17:46:05	2021-12-05 17:46:05
191	2392	436	13.71	7.45	9.27	13.09	19.8	2021-12-05 17:46:05	2021-12-05 17:46:05
192	1836	135	21.75	27.8	0.41	0.18	17.9	2021-12-05 17:46:05	2021-12-05 17:46:05
193	2300	191	13.1	15.25	9.07	11.58	1.45	2021-12-05 17:46:05	2021-12-05 17:46:05
194	2988	113	15.25	1.68	9.54	13	20.53	2021-12-05 17:46:05	2021-12-05 17:46:05
195	1920	450	23.32	21.74	8.46	3.43	15.31	2021-12-05 17:46:05	2021-12-05 17:46:05
196	2837	130	4.32	14.39	9.7	11.78	4.02	2021-12-05 17:46:05	2021-12-05 17:46:05
197	2421	147	17.44	8.49	5.01	6.05	6.07	2021-12-05 17:46:05	2021-12-05 17:46:05
198	2119	447	16.27	0.08	6.82	0.68	22.49	2021-12-05 17:46:05	2021-12-05 17:46:05
199	2057	441	16.59	14.23	9.05	0.15	7.56	2021-12-05 17:46:05	2021-12-05 17:46:05
200	2039	158	6.28	0.32	5.09	12.54	24.33	2021-12-05 17:46:05	2021-12-05 17:46:05
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders (id, shipping_price, payment_price, total, paid, shipped, delivered, shipping_method, payment_method, gift_id, "firstName", "lastName", email, phone_number, street, apartment, city, zip_code, country, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: password_resets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.password_resets (email, token, created_at) FROM stdin;
\.


--
-- Data for Name: personal_access_tokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.personal_access_tokens (id, tokenable_type, tokenable_id, name, token, abilities, last_used_at, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: product_allergens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_allergens (id, allergen_id, product_id, created_at, updated_at) FROM stdin;
1	1	1	\N	\N
2	2	1	\N	\N
3	3	1	\N	\N
4	4	1	\N	\N
5	5	2	\N	\N
6	6	2	\N	\N
7	7	2	\N	\N
8	8	2	\N	\N
9	9	2	\N	\N
10	10	2	\N	\N
11	11	3	\N	\N
12	12	3	\N	\N
13	6	3	\N	\N
14	13	3	\N	\N
15	14	3	\N	\N
16	15	3	\N	\N
17	16	3	\N	\N
18	12	4	\N	\N
19	17	4	\N	\N
20	16	4	\N	\N
21	18	5	\N	\N
22	19	5	\N	\N
23	11	6	\N	\N
24	5	6	\N	\N
25	6	6	\N	\N
26	17	6	\N	\N
27	3	6	\N	\N
28	15	6	\N	\N
29	10	6	\N	\N
30	1	7	\N	\N
31	2	7	\N	\N
32	12	7	\N	\N
33	18	7	\N	\N
34	13	7	\N	\N
35	9	7	\N	\N
36	19	7	\N	\N
37	12	8	\N	\N
38	20	8	\N	\N
39	2	8	\N	\N
40	18	8	\N	\N
41	13	8	\N	\N
42	14	8	\N	\N
43	10	8	\N	\N
44	16	8	\N	\N
45	8	8	\N	\N
46	11	9	\N	\N
47	21	9	\N	\N
48	15	9	\N	\N
49	8	9	\N	\N
50	21	10	\N	\N
51	8	10	\N	\N
52	10	10	\N	\N
53	14	10	\N	\N
54	18	11	\N	\N
55	17	11	\N	\N
56	6	11	\N	\N
57	13	11	\N	\N
58	15	11	\N	\N
59	7	11	\N	\N
60	19	11	\N	\N
61	16	11	\N	\N
62	22	12	\N	\N
63	6	12	\N	\N
64	23	12	\N	\N
65	16	12	\N	\N
66	1	13	\N	\N
67	17	13	\N	\N
68	21	13	\N	\N
69	19	13	\N	\N
70	4	13	\N	\N
71	14	13	\N	\N
72	23	13	\N	\N
73	21	14	\N	\N
74	5	14	\N	\N
75	18	14	\N	\N
76	24	14	\N	\N
77	12	14	\N	\N
78	7	14	\N	\N
79	13	14	\N	\N
80	9	14	\N	\N
81	23	14	\N	\N
82	4	14	\N	\N
83	6	15	\N	\N
84	4	15	\N	\N
85	3	15	\N	\N
86	5	16	\N	\N
87	6	16	\N	\N
88	8	16	\N	\N
89	10	16	\N	\N
90	16	16	\N	\N
91	5	17	\N	\N
92	23	17	\N	\N
93	14	17	\N	\N
94	4	17	\N	\N
95	19	17	\N	\N
96	12	18	\N	\N
97	17	18	\N	\N
98	5	18	\N	\N
99	2	18	\N	\N
100	11	18	\N	\N
101	20	19	\N	\N
102	1	19	\N	\N
103	5	19	\N	\N
104	2	19	\N	\N
105	19	19	\N	\N
106	3	19	\N	\N
107	14	19	\N	\N
108	9	19	\N	\N
109	11	20	\N	\N
110	18	20	\N	\N
111	22	20	\N	\N
112	5	20	\N	\N
113	14	20	\N	\N
114	16	20	\N	\N
115	15	20	\N	\N
116	19	20	\N	\N
117	9	20	\N	\N
118	22	21	\N	\N
119	2	21	\N	\N
120	11	21	\N	\N
121	12	21	\N	\N
122	1	21	\N	\N
123	7	21	\N	\N
124	15	21	\N	\N
125	19	21	\N	\N
126	13	21	\N	\N
127	4	21	\N	\N
128	1	22	\N	\N
129	2	22	\N	\N
130	21	22	\N	\N
131	20	22	\N	\N
132	23	22	\N	\N
133	10	22	\N	\N
134	16	22	\N	\N
135	20	23	\N	\N
136	21	23	\N	\N
137	11	23	\N	\N
138	6	23	\N	\N
139	7	23	\N	\N
140	10	23	\N	\N
141	9	23	\N	\N
142	16	23	\N	\N
143	4	23	\N	\N
144	22	24	\N	\N
145	17	24	\N	\N
146	16	24	\N	\N
147	19	24	\N	\N
148	11	25	\N	\N
149	10	25	\N	\N
150	9	25	\N	\N
151	13	25	\N	\N
152	7	25	\N	\N
153	19	25	\N	\N
154	11	26	\N	\N
155	12	27	\N	\N
156	21	27	\N	\N
157	1	27	\N	\N
158	20	27	\N	\N
159	19	27	\N	\N
160	16	27	\N	\N
161	4	27	\N	\N
162	5	28	\N	\N
163	24	28	\N	\N
164	2	29	\N	\N
165	12	29	\N	\N
166	6	29	\N	\N
167	20	29	\N	\N
168	22	29	\N	\N
169	7	29	\N	\N
170	4	29	\N	\N
171	19	29	\N	\N
172	14	29	\N	\N
173	15	29	\N	\N
174	20	30	\N	\N
175	12	30	\N	\N
176	11	30	\N	\N
177	5	30	\N	\N
178	24	30	\N	\N
179	13	30	\N	\N
180	10	30	\N	\N
181	16	30	\N	\N
182	23	30	\N	\N
183	7	30	\N	\N
184	6	31	\N	\N
185	21	31	\N	\N
186	11	31	\N	\N
187	12	32	\N	\N
188	15	32	\N	\N
189	10	32	\N	\N
190	19	32	\N	\N
191	14	32	\N	\N
192	21	33	\N	\N
193	20	33	\N	\N
194	1	33	\N	\N
195	12	33	\N	\N
196	17	33	\N	\N
197	19	33	\N	\N
198	2	34	\N	\N
199	20	34	\N	\N
200	6	34	\N	\N
201	24	34	\N	\N
202	4	34	\N	\N
203	10	34	\N	\N
204	16	34	\N	\N
205	13	34	\N	\N
206	14	34	\N	\N
207	12	35	\N	\N
208	5	35	\N	\N
209	1	35	\N	\N
210	19	35	\N	\N
211	23	35	\N	\N
212	13	35	\N	\N
213	11	36	\N	\N
214	2	36	\N	\N
215	17	36	\N	\N
216	6	37	\N	\N
217	2	37	\N	\N
218	22	37	\N	\N
219	18	37	\N	\N
220	11	37	\N	\N
221	3	37	\N	\N
222	14	37	\N	\N
223	19	37	\N	\N
224	15	37	\N	\N
225	10	37	\N	\N
226	18	38	\N	\N
227	6	38	\N	\N
228	23	38	\N	\N
229	16	38	\N	\N
230	15	38	\N	\N
231	12	39	\N	\N
232	22	39	\N	\N
233	6	40	\N	\N
234	15	40	\N	\N
235	24	41	\N	\N
236	22	41	\N	\N
237	11	41	\N	\N
238	6	41	\N	\N
239	5	41	\N	\N
240	14	41	\N	\N
241	13	41	\N	\N
242	16	41	\N	\N
243	6	42	\N	\N
244	21	42	\N	\N
245	18	42	\N	\N
246	19	42	\N	\N
247	23	42	\N	\N
248	10	42	\N	\N
249	15	42	\N	\N
250	12	43	\N	\N
251	1	43	\N	\N
252	9	43	\N	\N
253	11	44	\N	\N
254	20	44	\N	\N
255	21	44	\N	\N
256	24	44	\N	\N
257	3	44	\N	\N
258	6	45	\N	\N
259	1	45	\N	\N
260	17	45	\N	\N
261	18	45	\N	\N
262	10	45	\N	\N
263	16	45	\N	\N
264	20	46	\N	\N
265	1	46	\N	\N
266	18	46	\N	\N
267	4	46	\N	\N
268	10	46	\N	\N
269	16	46	\N	\N
270	3	46	\N	\N
271	14	46	\N	\N
272	12	47	\N	\N
273	5	47	\N	\N
274	3	47	\N	\N
275	7	47	\N	\N
276	9	47	\N	\N
277	11	48	\N	\N
278	12	48	\N	\N
279	24	48	\N	\N
280	21	48	\N	\N
281	3	48	\N	\N
282	13	48	\N	\N
283	10	48	\N	\N
284	14	48	\N	\N
285	12	49	\N	\N
286	18	49	\N	\N
287	24	49	\N	\N
288	10	49	\N	\N
289	15	49	\N	\N
290	11	50	\N	\N
291	24	50	\N	\N
292	12	50	\N	\N
293	22	50	\N	\N
294	5	51	\N	\N
295	18	51	\N	\N
296	5	52	\N	\N
297	10	52	\N	\N
298	1	53	\N	\N
299	17	53	\N	\N
300	22	53	\N	\N
301	2	53	\N	\N
302	5	53	\N	\N
303	3	53	\N	\N
304	23	53	\N	\N
305	19	53	\N	\N
306	10	53	\N	\N
307	8	53	\N	\N
308	6	54	\N	\N
309	22	54	\N	\N
310	12	54	\N	\N
311	24	54	\N	\N
312	20	54	\N	\N
313	23	54	\N	\N
314	8	54	\N	\N
315	10	54	\N	\N
316	19	54	\N	\N
317	15	54	\N	\N
318	21	55	\N	\N
319	2	55	\N	\N
320	19	55	\N	\N
321	16	55	\N	\N
322	3	55	\N	\N
323	14	55	\N	\N
324	18	56	\N	\N
325	1	56	\N	\N
326	6	56	\N	\N
327	18	57	\N	\N
328	21	57	\N	\N
329	6	57	\N	\N
330	2	57	\N	\N
331	17	58	\N	\N
332	2	59	\N	\N
333	18	59	\N	\N
334	19	59	\N	\N
335	22	60	\N	\N
336	10	60	\N	\N
337	15	60	\N	\N
338	13	60	\N	\N
339	11	61	\N	\N
340	17	61	\N	\N
341	1	61	\N	\N
342	5	61	\N	\N
343	8	61	\N	\N
344	3	61	\N	\N
345	22	62	\N	\N
346	20	62	\N	\N
347	11	62	\N	\N
348	1	62	\N	\N
349	6	63	\N	\N
350	5	64	\N	\N
351	21	64	\N	\N
352	12	64	\N	\N
353	17	64	\N	\N
354	8	64	\N	\N
355	4	64	\N	\N
356	9	64	\N	\N
357	15	64	\N	\N
358	21	65	\N	\N
359	22	65	\N	\N
360	12	65	\N	\N
361	8	65	\N	\N
362	16	65	\N	\N
363	9	65	\N	\N
364	12	66	\N	\N
365	5	66	\N	\N
366	1	66	\N	\N
367	11	66	\N	\N
368	4	66	\N	\N
369	23	66	\N	\N
370	13	66	\N	\N
371	19	66	\N	\N
372	9	66	\N	\N
373	6	67	\N	\N
374	2	67	\N	\N
375	17	67	\N	\N
376	11	67	\N	\N
377	5	67	\N	\N
378	15	67	\N	\N
379	7	67	\N	\N
380	20	68	\N	\N
381	21	68	\N	\N
382	6	68	\N	\N
383	10	68	\N	\N
384	16	68	\N	\N
385	14	68	\N	\N
386	6	69	\N	\N
387	1	69	\N	\N
388	12	69	\N	\N
389	20	69	\N	\N
390	17	69	\N	\N
391	11	70	\N	\N
392	12	70	\N	\N
393	19	70	\N	\N
394	3	70	\N	\N
395	23	70	\N	\N
396	16	70	\N	\N
397	20	71	\N	\N
398	10	71	\N	\N
399	8	71	\N	\N
400	7	71	\N	\N
401	6	72	\N	\N
402	18	72	\N	\N
403	17	72	\N	\N
404	23	72	\N	\N
405	7	72	\N	\N
406	22	73	\N	\N
407	19	73	\N	\N
408	24	74	\N	\N
409	12	74	\N	\N
410	21	74	\N	\N
411	1	74	\N	\N
412	12	75	\N	\N
413	20	75	\N	\N
414	1	75	\N	\N
415	5	75	\N	\N
416	24	75	\N	\N
417	8	75	\N	\N
418	13	75	\N	\N
419	20	76	\N	\N
420	18	76	\N	\N
421	21	76	\N	\N
422	5	76	\N	\N
423	17	77	\N	\N
424	11	77	\N	\N
425	6	77	\N	\N
426	24	77	\N	\N
427	9	77	\N	\N
428	19	77	\N	\N
429	13	77	\N	\N
430	10	77	\N	\N
431	12	78	\N	\N
432	11	78	\N	\N
433	22	78	\N	\N
434	21	78	\N	\N
435	4	78	\N	\N
436	13	78	\N	\N
437	8	78	\N	\N
438	12	79	\N	\N
439	21	79	\N	\N
440	23	79	\N	\N
441	13	79	\N	\N
442	3	79	\N	\N
443	14	79	\N	\N
444	22	80	\N	\N
445	6	80	\N	\N
446	8	80	\N	\N
447	7	80	\N	\N
448	16	80	\N	\N
449	10	80	\N	\N
450	20	81	\N	\N
451	9	81	\N	\N
452	1	82	\N	\N
453	6	82	\N	\N
454	21	83	\N	\N
455	2	83	\N	\N
456	13	83	\N	\N
457	5	84	\N	\N
458	18	84	\N	\N
459	17	84	\N	\N
460	22	84	\N	\N
461	24	84	\N	\N
462	8	84	\N	\N
463	23	84	\N	\N
464	19	84	\N	\N
465	20	85	\N	\N
466	12	85	\N	\N
467	2	85	\N	\N
468	2	86	\N	\N
469	22	86	\N	\N
470	9	86	\N	\N
471	15	86	\N	\N
472	16	86	\N	\N
473	10	86	\N	\N
474	23	86	\N	\N
475	2	87	\N	\N
476	22	87	\N	\N
477	24	87	\N	\N
478	11	87	\N	\N
479	5	87	\N	\N
480	15	87	\N	\N
481	13	87	\N	\N
482	3	87	\N	\N
483	21	88	\N	\N
484	3	88	\N	\N
485	23	88	\N	\N
486	19	88	\N	\N
487	5	89	\N	\N
488	2	89	\N	\N
489	21	89	\N	\N
490	17	89	\N	\N
491	22	89	\N	\N
492	6	90	\N	\N
493	1	90	\N	\N
494	19	90	\N	\N
495	13	90	\N	\N
496	9	90	\N	\N
497	17	91	\N	\N
498	21	91	\N	\N
499	18	91	\N	\N
500	20	91	\N	\N
501	2	91	\N	\N
502	11	92	\N	\N
503	12	92	\N	\N
504	2	92	\N	\N
505	20	92	\N	\N
506	1	92	\N	\N
507	15	92	\N	\N
508	16	92	\N	\N
509	14	92	\N	\N
510	3	92	\N	\N
511	23	92	\N	\N
512	20	93	\N	\N
513	4	93	\N	\N
514	13	93	\N	\N
515	10	93	\N	\N
516	8	93	\N	\N
517	14	93	\N	\N
518	6	94	\N	\N
519	22	94	\N	\N
520	18	94	\N	\N
521	11	94	\N	\N
522	23	94	\N	\N
523	5	95	\N	\N
524	21	95	\N	\N
525	3	95	\N	\N
526	9	95	\N	\N
527	10	95	\N	\N
528	19	95	\N	\N
529	13	95	\N	\N
530	1	96	\N	\N
531	20	96	\N	\N
532	24	96	\N	\N
533	8	96	\N	\N
534	16	96	\N	\N
535	7	96	\N	\N
536	14	96	\N	\N
537	17	97	\N	\N
538	21	97	\N	\N
539	20	97	\N	\N
540	14	97	\N	\N
541	8	97	\N	\N
542	18	98	\N	\N
543	5	98	\N	\N
544	6	98	\N	\N
545	11	98	\N	\N
546	1	98	\N	\N
547	11	99	\N	\N
548	4	99	\N	\N
549	10	99	\N	\N
550	14	99	\N	\N
551	13	99	\N	\N
552	20	100	\N	\N
553	11	100	\N	\N
554	12	100	\N	\N
555	18	100	\N	\N
556	2	100	\N	\N
557	4	100	\N	\N
558	9	100	\N	\N
559	19	100	\N	\N
560	11	101	\N	\N
561	24	101	\N	\N
562	18	101	\N	\N
563	16	101	\N	\N
564	13	101	\N	\N
565	9	101	\N	\N
566	14	101	\N	\N
567	2	102	\N	\N
568	5	102	\N	\N
569	20	102	\N	\N
570	21	102	\N	\N
571	16	102	\N	\N
572	3	102	\N	\N
573	20	103	\N	\N
574	1	104	\N	\N
575	22	104	\N	\N
576	2	104	\N	\N
577	17	104	\N	\N
578	12	104	\N	\N
579	8	104	\N	\N
580	1	105	\N	\N
581	22	105	\N	\N
582	20	105	\N	\N
583	3	105	\N	\N
584	19	105	\N	\N
585	13	105	\N	\N
586	1	106	\N	\N
587	3	106	\N	\N
588	9	106	\N	\N
589	15	106	\N	\N
590	4	106	\N	\N
591	18	107	\N	\N
592	24	107	\N	\N
593	23	107	\N	\N
594	15	107	\N	\N
595	9	107	\N	\N
596	20	108	\N	\N
597	6	108	\N	\N
598	24	108	\N	\N
599	11	108	\N	\N
600	5	108	\N	\N
601	4	108	\N	\N
602	15	108	\N	\N
603	13	108	\N	\N
604	19	108	\N	\N
605	20	109	\N	\N
606	22	109	\N	\N
607	17	109	\N	\N
608	12	109	\N	\N
609	13	109	\N	\N
610	9	109	\N	\N
611	14	109	\N	\N
612	19	109	\N	\N
613	22	110	\N	\N
614	18	110	\N	\N
615	21	110	\N	\N
616	1	110	\N	\N
617	17	111	\N	\N
618	2	111	\N	\N
619	12	111	\N	\N
620	6	111	\N	\N
621	23	111	\N	\N
622	13	111	\N	\N
623	8	111	\N	\N
624	7	111	\N	\N
625	11	112	\N	\N
626	20	112	\N	\N
627	1	112	\N	\N
628	18	112	\N	\N
629	12	112	\N	\N
630	8	112	\N	\N
631	3	112	\N	\N
632	1	113	\N	\N
633	16	113	\N	\N
634	4	113	\N	\N
635	18	114	\N	\N
636	22	114	\N	\N
637	4	114	\N	\N
638	10	114	\N	\N
639	15	114	\N	\N
640	17	115	\N	\N
641	1	115	\N	\N
642	23	115	\N	\N
643	13	115	\N	\N
644	19	115	\N	\N
645	10	115	\N	\N
646	21	116	\N	\N
647	11	116	\N	\N
648	14	116	\N	\N
649	8	116	\N	\N
650	4	116	\N	\N
651	7	116	\N	\N
652	10	116	\N	\N
653	5	117	\N	\N
654	6	117	\N	\N
655	12	117	\N	\N
656	9	117	\N	\N
657	23	117	\N	\N
658	10	117	\N	\N
659	12	118	\N	\N
660	17	118	\N	\N
661	3	118	\N	\N
662	10	118	\N	\N
663	13	118	\N	\N
664	23	118	\N	\N
665	5	119	\N	\N
666	24	119	\N	\N
667	5	120	\N	\N
668	21	120	\N	\N
669	17	120	\N	\N
670	24	120	\N	\N
671	6	121	\N	\N
672	16	121	\N	\N
673	23	121	\N	\N
674	8	121	\N	\N
675	21	122	\N	\N
676	10	122	\N	\N
677	9	122	\N	\N
678	4	122	\N	\N
679	3	122	\N	\N
680	15	122	\N	\N
681	6	123	\N	\N
682	5	123	\N	\N
683	13	123	\N	\N
684	19	123	\N	\N
685	16	123	\N	\N
686	9	123	\N	\N
687	10	123	\N	\N
688	20	124	\N	\N
689	21	125	\N	\N
690	23	125	\N	\N
691	8	125	\N	\N
692	19	125	\N	\N
693	20	126	\N	\N
694	12	126	\N	\N
695	22	126	\N	\N
696	17	126	\N	\N
697	5	126	\N	\N
698	15	126	\N	\N
699	11	127	\N	\N
700	20	127	\N	\N
701	17	127	\N	\N
702	19	127	\N	\N
703	24	128	\N	\N
704	17	128	\N	\N
705	12	128	\N	\N
706	11	128	\N	\N
707	21	128	\N	\N
708	3	128	\N	\N
709	18	129	\N	\N
710	24	129	\N	\N
711	22	129	\N	\N
712	23	129	\N	\N
713	6	130	\N	\N
714	11	130	\N	\N
715	10	130	\N	\N
716	21	131	\N	\N
717	16	131	\N	\N
718	13	131	\N	\N
719	3	131	\N	\N
720	5	132	\N	\N
721	24	132	\N	\N
722	17	132	\N	\N
723	22	133	\N	\N
724	20	133	\N	\N
725	4	133	\N	\N
726	19	133	\N	\N
727	24	134	\N	\N
728	1	134	\N	\N
729	6	135	\N	\N
730	6	136	\N	\N
731	12	136	\N	\N
732	14	136	\N	\N
733	17	137	\N	\N
734	2	137	\N	\N
735	11	137	\N	\N
736	6	137	\N	\N
737	12	137	\N	\N
738	19	137	\N	\N
739	10	137	\N	\N
740	16	137	\N	\N
741	20	138	\N	\N
742	2	138	\N	\N
743	11	138	\N	\N
744	1	138	\N	\N
745	14	138	\N	\N
746	3	138	\N	\N
747	8	138	\N	\N
748	7	138	\N	\N
749	22	139	\N	\N
750	18	139	\N	\N
751	1	139	\N	\N
752	17	140	\N	\N
753	8	140	\N	\N
754	10	140	\N	\N
755	9	140	\N	\N
756	3	140	\N	\N
757	18	141	\N	\N
758	11	141	\N	\N
759	5	141	\N	\N
760	8	141	\N	\N
761	14	141	\N	\N
762	11	142	\N	\N
763	9	142	\N	\N
764	19	142	\N	\N
765	3	142	\N	\N
766	15	142	\N	\N
767	7	142	\N	\N
768	6	143	\N	\N
769	10	143	\N	\N
770	17	144	\N	\N
771	1	144	\N	\N
772	12	144	\N	\N
773	24	144	\N	\N
774	23	144	\N	\N
775	9	144	\N	\N
776	19	144	\N	\N
777	16	144	\N	\N
778	11	145	\N	\N
779	24	146	\N	\N
780	15	146	\N	\N
781	3	146	\N	\N
782	8	146	\N	\N
783	17	147	\N	\N
784	16	147	\N	\N
785	12	148	\N	\N
786	6	148	\N	\N
787	21	148	\N	\N
788	22	148	\N	\N
789	17	148	\N	\N
790	12	149	\N	\N
791	6	149	\N	\N
792	24	149	\N	\N
793	2	149	\N	\N
794	1	149	\N	\N
795	22	150	\N	\N
796	1	150	\N	\N
797	20	150	\N	\N
798	23	150	\N	\N
799	13	150	\N	\N
800	20	151	\N	\N
801	18	151	\N	\N
802	14	151	\N	\N
803	10	151	\N	\N
804	13	151	\N	\N
805	1	152	\N	\N
806	24	152	\N	\N
807	3	152	\N	\N
808	9	152	\N	\N
809	12	153	\N	\N
810	1	153	\N	\N
811	5	153	\N	\N
812	13	153	\N	\N
813	14	153	\N	\N
814	15	153	\N	\N
815	16	153	\N	\N
816	23	153	\N	\N
817	22	154	\N	\N
818	18	154	\N	\N
819	1	155	\N	\N
820	24	156	\N	\N
821	22	156	\N	\N
822	18	156	\N	\N
823	12	156	\N	\N
824	5	156	\N	\N
825	16	156	\N	\N
826	15	156	\N	\N
827	13	156	\N	\N
828	8	156	\N	\N
829	14	156	\N	\N
830	24	157	\N	\N
831	21	157	\N	\N
832	1	157	\N	\N
833	4	157	\N	\N
834	17	158	\N	\N
835	13	158	\N	\N
836	14	158	\N	\N
837	4	158	\N	\N
838	16	158	\N	\N
839	24	159	\N	\N
840	1	159	\N	\N
841	2	159	\N	\N
842	17	159	\N	\N
843	9	159	\N	\N
844	6	160	\N	\N
845	5	160	\N	\N
846	1	160	\N	\N
847	7	160	\N	\N
848	23	160	\N	\N
849	10	160	\N	\N
850	15	160	\N	\N
851	16	160	\N	\N
852	18	161	\N	\N
853	17	161	\N	\N
854	7	161	\N	\N
855	14	161	\N	\N
856	4	161	\N	\N
857	13	161	\N	\N
858	16	161	\N	\N
859	2	162	\N	\N
860	21	162	\N	\N
861	6	162	\N	\N
862	10	162	\N	\N
863	21	163	\N	\N
864	5	163	\N	\N
865	1	163	\N	\N
866	11	163	\N	\N
867	6	164	\N	\N
868	21	164	\N	\N
869	3	164	\N	\N
870	11	165	\N	\N
871	24	165	\N	\N
872	6	165	\N	\N
873	18	165	\N	\N
874	20	165	\N	\N
875	14	165	\N	\N
876	4	165	\N	\N
877	10	165	\N	\N
878	8	165	\N	\N
879	7	165	\N	\N
880	12	166	\N	\N
881	5	166	\N	\N
882	24	166	\N	\N
883	6	166	\N	\N
884	21	166	\N	\N
885	8	166	\N	\N
886	9	166	\N	\N
887	10	166	\N	\N
888	24	167	\N	\N
889	22	167	\N	\N
890	3	167	\N	\N
891	4	167	\N	\N
892	10	167	\N	\N
893	15	167	\N	\N
894	9	167	\N	\N
895	21	168	\N	\N
896	22	168	\N	\N
897	16	168	\N	\N
898	15	168	\N	\N
899	2	169	\N	\N
900	11	169	\N	\N
901	21	169	\N	\N
902	17	169	\N	\N
903	2	170	\N	\N
904	6	170	\N	\N
905	12	170	\N	\N
906	11	170	\N	\N
907	5	170	\N	\N
908	10	170	\N	\N
909	15	170	\N	\N
910	14	170	\N	\N
911	23	170	\N	\N
912	24	171	\N	\N
913	17	171	\N	\N
914	21	171	\N	\N
915	11	172	\N	\N
916	20	172	\N	\N
917	21	172	\N	\N
918	23	172	\N	\N
919	21	173	\N	\N
920	1	173	\N	\N
921	5	174	\N	\N
922	12	174	\N	\N
923	22	174	\N	\N
924	17	174	\N	\N
925	6	174	\N	\N
926	7	174	\N	\N
927	1	175	\N	\N
928	20	175	\N	\N
929	11	175	\N	\N
930	18	175	\N	\N
931	22	175	\N	\N
932	6	176	\N	\N
933	1	176	\N	\N
934	15	176	\N	\N
935	19	176	\N	\N
936	23	176	\N	\N
937	3	176	\N	\N
938	2	177	\N	\N
939	12	177	\N	\N
940	17	177	\N	\N
941	7	177	\N	\N
942	10	177	\N	\N
943	14	177	\N	\N
944	4	177	\N	\N
945	24	178	\N	\N
946	1	178	\N	\N
947	6	178	\N	\N
948	2	178	\N	\N
949	8	178	\N	\N
950	3	178	\N	\N
951	7	178	\N	\N
952	12	179	\N	\N
953	5	179	\N	\N
954	8	179	\N	\N
955	9	179	\N	\N
956	7	179	\N	\N
957	4	179	\N	\N
958	1	180	\N	\N
959	14	180	\N	\N
960	6	181	\N	\N
961	13	181	\N	\N
962	23	181	\N	\N
963	8	181	\N	\N
964	14	181	\N	\N
965	16	181	\N	\N
966	5	182	\N	\N
967	24	182	\N	\N
968	22	182	\N	\N
969	21	182	\N	\N
970	20	182	\N	\N
971	7	182	\N	\N
972	4	182	\N	\N
973	8	182	\N	\N
974	18	183	\N	\N
975	17	183	\N	\N
976	22	183	\N	\N
977	11	183	\N	\N
978	4	183	\N	\N
979	7	183	\N	\N
980	18	184	\N	\N
981	17	184	\N	\N
982	24	185	\N	\N
983	2	185	\N	\N
984	6	185	\N	\N
985	1	185	\N	\N
986	18	185	\N	\N
987	10	185	\N	\N
988	15	185	\N	\N
989	21	186	\N	\N
990	12	187	\N	\N
991	2	187	\N	\N
992	24	187	\N	\N
993	16	187	\N	\N
994	8	187	\N	\N
995	13	187	\N	\N
996	18	188	\N	\N
997	22	188	\N	\N
998	2	188	\N	\N
999	12	188	\N	\N
1000	19	188	\N	\N
1001	11	189	\N	\N
1002	18	189	\N	\N
1003	2	189	\N	\N
1004	22	189	\N	\N
1005	15	189	\N	\N
1006	6	190	\N	\N
1007	11	190	\N	\N
1008	18	190	\N	\N
1009	21	190	\N	\N
1010	5	190	\N	\N
1011	15	190	\N	\N
1012	16	190	\N	\N
1013	10	190	\N	\N
1014	4	190	\N	\N
1015	13	190	\N	\N
1016	11	191	\N	\N
1017	1	192	\N	\N
1018	11	192	\N	\N
1019	24	192	\N	\N
1020	16	192	\N	\N
1021	4	192	\N	\N
1022	13	192	\N	\N
1023	7	192	\N	\N
1024	1	193	\N	\N
1025	20	193	\N	\N
1026	7	193	\N	\N
1027	10	193	\N	\N
1028	16	193	\N	\N
1029	20	194	\N	\N
1030	17	194	\N	\N
1031	6	194	\N	\N
1032	3	194	\N	\N
1033	7	194	\N	\N
1034	16	194	\N	\N
1035	21	195	\N	\N
1036	1	196	\N	\N
1037	2	196	\N	\N
1038	17	196	\N	\N
1039	18	196	\N	\N
1040	19	196	\N	\N
1041	21	197	\N	\N
1042	2	197	\N	\N
1043	18	197	\N	\N
1044	12	197	\N	\N
1045	23	197	\N	\N
1046	13	197	\N	\N
1047	18	198	\N	\N
1048	6	198	\N	\N
1049	22	198	\N	\N
1050	1	198	\N	\N
1051	17	198	\N	\N
1052	13	198	\N	\N
1053	10	198	\N	\N
1054	8	198	\N	\N
1055	18	199	\N	\N
1056	3	199	\N	\N
1057	23	199	\N	\N
1058	15	199	\N	\N
1059	4	199	\N	\N
1060	14	199	\N	\N
1061	17	200	\N	\N
1062	3	200	\N	\N
1063	14	200	\N	\N
\.


--
-- Data for Name: product_categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_categories (id, category_id, product_id, created_at, updated_at) FROM stdin;
1	3	1	\N	\N
2	15	2	\N	\N
3	13	3	\N	\N
4	15	4	\N	\N
5	13	5	\N	\N
6	3	6	\N	\N
7	13	7	\N	\N
8	16	7	\N	\N
9	8	8	\N	\N
10	16	8	\N	\N
11	11	9	\N	\N
12	16	9	\N	\N
13	15	10	\N	\N
14	3	11	\N	\N
15	14	12	\N	\N
16	4	13	\N	\N
17	2	14	\N	\N
18	11	15	\N	\N
19	16	15	\N	\N
20	15	16	\N	\N
21	8	17	\N	\N
22	3	18	\N	\N
23	5	19	\N	\N
24	7	20	\N	\N
25	14	21	\N	\N
26	14	22	\N	\N
27	16	22	\N	\N
28	4	23	\N	\N
29	8	24	\N	\N
30	14	25	\N	\N
31	3	26	\N	\N
32	16	26	\N	\N
33	11	27	\N	\N
34	3	28	\N	\N
35	11	29	\N	\N
36	15	30	\N	\N
37	4	31	\N	\N
38	10	32	\N	\N
39	15	33	\N	\N
40	13	34	\N	\N
41	3	35	\N	\N
42	14	36	\N	\N
43	10	37	\N	\N
44	4	38	\N	\N
45	15	39	\N	\N
46	5	40	\N	\N
47	10	41	\N	\N
48	2	42	\N	\N
49	16	42	\N	\N
50	15	43	\N	\N
51	11	44	\N	\N
52	5	45	\N	\N
53	5	46	\N	\N
54	13	47	\N	\N
55	10	48	\N	\N
56	7	49	\N	\N
57	8	50	\N	\N
58	10	51	\N	\N
59	13	52	\N	\N
60	7	53	\N	\N
61	3	54	\N	\N
62	4	55	\N	\N
63	14	56	\N	\N
64	13	57	\N	\N
65	5	58	\N	\N
66	10	59	\N	\N
67	14	60	\N	\N
68	11	61	\N	\N
69	5	62	\N	\N
70	13	63	\N	\N
71	10	64	\N	\N
72	8	65	\N	\N
73	2	66	\N	\N
74	8	67	\N	\N
75	3	68	\N	\N
76	15	69	\N	\N
77	4	70	\N	\N
78	3	71	\N	\N
79	13	72	\N	\N
80	15	73	\N	\N
81	8	74	\N	\N
82	8	75	\N	\N
83	4	76	\N	\N
84	14	77	\N	\N
85	5	78	\N	\N
86	16	78	\N	\N
87	10	79	\N	\N
88	13	80	\N	\N
89	2	81	\N	\N
90	7	82	\N	\N
91	4	83	\N	\N
92	8	84	\N	\N
93	14	85	\N	\N
94	8	86	\N	\N
95	5	87	\N	\N
96	10	88	\N	\N
97	8	89	\N	\N
98	5	90	\N	\N
99	10	91	\N	\N
100	10	92	\N	\N
101	2	93	\N	\N
102	10	94	\N	\N
103	15	95	\N	\N
104	7	96	\N	\N
105	13	97	\N	\N
106	4	98	\N	\N
107	7	99	\N	\N
108	8	100	\N	\N
109	3	101	\N	\N
110	8	102	\N	\N
111	13	103	\N	\N
112	8	104	\N	\N
113	4	105	\N	\N
114	16	105	\N	\N
115	13	106	\N	\N
116	11	107	\N	\N
117	16	107	\N	\N
118	15	108	\N	\N
119	3	109	\N	\N
120	13	110	\N	\N
121	3	111	\N	\N
122	5	112	\N	\N
123	3	113	\N	\N
124	5	114	\N	\N
125	14	115	\N	\N
126	11	116	\N	\N
127	3	117	\N	\N
128	10	118	\N	\N
129	5	119	\N	\N
130	16	119	\N	\N
131	2	120	\N	\N
132	11	121	\N	\N
133	13	122	\N	\N
134	5	123	\N	\N
135	16	123	\N	\N
136	7	124	\N	\N
137	5	125	\N	\N
138	11	126	\N	\N
139	8	127	\N	\N
140	15	128	\N	\N
141	2	129	\N	\N
142	15	130	\N	\N
143	16	130	\N	\N
144	3	131	\N	\N
145	15	132	\N	\N
146	16	132	\N	\N
147	5	133	\N	\N
148	11	134	\N	\N
149	13	135	\N	\N
150	16	135	\N	\N
151	10	136	\N	\N
152	11	137	\N	\N
153	4	138	\N	\N
154	3	139	\N	\N
155	4	140	\N	\N
156	8	141	\N	\N
157	16	141	\N	\N
158	13	142	\N	\N
159	4	143	\N	\N
160	8	144	\N	\N
161	8	145	\N	\N
162	4	146	\N	\N
163	16	146	\N	\N
164	8	147	\N	\N
165	13	148	\N	\N
166	2	149	\N	\N
167	13	150	\N	\N
168	8	151	\N	\N
169	16	151	\N	\N
170	8	152	\N	\N
171	2	153	\N	\N
172	5	154	\N	\N
173	13	155	\N	\N
174	5	156	\N	\N
175	2	157	\N	\N
176	14	158	\N	\N
177	5	159	\N	\N
178	10	160	\N	\N
179	8	161	\N	\N
180	14	162	\N	\N
181	7	163	\N	\N
182	13	164	\N	\N
183	13	165	\N	\N
184	14	166	\N	\N
185	5	167	\N	\N
186	13	168	\N	\N
187	3	169	\N	\N
188	7	170	\N	\N
189	16	170	\N	\N
190	14	171	\N	\N
191	5	172	\N	\N
192	2	173	\N	\N
193	5	174	\N	\N
194	4	175	\N	\N
195	4	176	\N	\N
196	13	177	\N	\N
197	11	178	\N	\N
198	10	179	\N	\N
199	15	180	\N	\N
200	13	181	\N	\N
201	10	182	\N	\N
202	3	183	\N	\N
203	10	184	\N	\N
204	8	185	\N	\N
205	4	186	\N	\N
206	13	187	\N	\N
207	5	188	\N	\N
208	5	189	\N	\N
209	2	190	\N	\N
210	16	190	\N	\N
211	4	191	\N	\N
212	11	192	\N	\N
213	14	193	\N	\N
214	5	194	\N	\N
215	10	195	\N	\N
216	14	196	\N	\N
217	2	197	\N	\N
218	11	198	\N	\N
219	2	199	\N	\N
220	15	200	\N	\N
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products (id, name, brand, weight, price, quantity, sold, images, ingredients, description, origin_country, dimensions, nutrition_id, discount, price_discounted, is_offered, created_at, updated_at, deleted_at) FROM stdin;
1	Nerds nougat sherbet	Bonapetitoo	42	18.12	57	0	["biscuit2.png","cake1.png","cupcake1.png"]	"Soy lecithin, Cream, Salt, Cocoa butter, Milk, Butter, Milk solids"	Et et officia eius ab. Minima ut nobis autem voluptatem eos odio. Debitis illo aut et voluptatem dolorem molestiae consequuntur. Et magnam incidunt et quia.	USA	18, 6, 2	1	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
2	American nougat bar	OmNomNom	195	9.95	61	0	["cupcake1.png","bar1.png","biscuit1.png","cake1.png"]	"Butter, Cream, Hazelnut pieces, Milk, Salt"	Quae maxime omnis laboriosam et molestiae eos. Et voluptatem voluptatibus ut voluptas molestiae accusamus. Occaecati aut eum nihil optio provident. Explicabo temporibus ex et quis.	USA	8, 6, 3	2	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
3	Nerds cream mix	Delicatesso	203	19	82	0	["biscuit2.png"]	"Sugar, Milk, Milk solids, Soy lecithin, Butter, Vanilla, Cream, Cocoa mass, Salt, Hazelnut pieces"	Quod et rerum et aperiam voluptatem ut illo. Qui recusandae corrupti architecto excepturi velit iusto consequatur. Nesciunt voluptate ut magnam ut laboriosam consequatur quod ut.	Poland	4, 3, 5	3	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
4	Delicate nougat block	Bonapetitoo	197	8.07	98	0	["biscuit1.png"]	"Butter, Sugar, Salt, Cocoa butter, Vanilla, Cocoa mass"	Nostrum ea eveniet asperiores. Deleniti quia repellendus quo aut quidem aut consequuntur. Ex ad tenetur ipsa.	Slovakia	14, 17, 2	4	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
5	Delicate toffee marshmallow	Roshen	263	19.32	20	0	["cake1.png","biscuit1.png","bar1.png"]	"Soy lecithin, Salt, Milk, Milk solids, Cocoa butter, Cocoa mass, Cream, Butter, Sugar, Vanilla"	Dolorum libero odio accusantium quia tempora. Consequatur nihil error facere. Aut et aut molestiae reiciendis sint.	Slovakia	1, 15, 2	5	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
6	Nerds nougat marshmallow	Roshen	201	2.87	75	0	["bar1.png","biscuit2.png","cupcake1.png"]	"Hazelnut pieces, Milk solids, Cocoa mass, Butter, Soy lecithin, Salt, Cream, Cocoa butter"	Aliquid sequi porro ut totam dolor. Sed quod officia non eos. Sequi consequatur sint voluptas aliquid modi exercitationem exercitationem.	Slovakia	12, 15, 16	6	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
10	Winter toffee candy	Nestle	196	9.41	60	0	["cupcake1.png","biscuit1.png","cake1.png"]	"Hazelnut pieces, Cocoa butter, Salt, Soy lecithin, Milk solids, Vanilla"	Atque occaecati magni qui ad. Velit aliquid quisquam et accusantium ullam. Id recusandae ut officiis ipsa non.	Poland	11, 11, 20	10	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
11	American toffee marshmallow	Sweetio	253	8.3	43	0	["biscuit1.png"]	"Salt, Sugar, Butter, Vanilla, Milk"	Perspiciatis qui est quibusdam tenetur quibusdam consequatur est consectetur. Natus qui deleniti animi modi. Repudiandae quisquam dolores sed. Nostrum suscipit at nobis et natus sint.	Korea	13, 5, 7	11	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
12	American nougat candy	Bonapetitoo	105	19.66	7	0	["cupcake1.png","cake1.png","biscuit1.png","bar1.png"]	"Cream, Salt, Sugar, Soy lecithin, Hazelnut pieces, Milk solids, Vanilla"	Error quo provident sapiente nobis sit alias nihil. Commodi alias consequatur hic sed nobis sapiente sint explicabo. Expedita dolore aut earum et quis.	Czech Republic	9, 12, 11	12	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
13	Hot nougat bar	Haribo	119	15.93	73	0	["bar1.png","cupcake1.png","biscuit1.png"]	"Cocoa mass, Soy lecithin, Hazelnut pieces, Cream, Milk, Vanilla, Cocoa butter"	Eum quisquam repudiandae assumenda corporis. Facilis et et aut sapiente possimus. Autem voluptates quia adipisci ut nostrum animi rem. Aut magni excepturi fugiat quidem porro.	Korea	8, 19, 5	13	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
14	Gummy sour lollipop	Nestle	287	4.45	6	0	["biscuit2.png","biscuit1.png","bar1.png","cake1.png"]	"Salt, Milk solids, Milk, Butter, Vanilla, Cocoa butter, Sugar, Soy lecithin, Hazelnut pieces, Cream"	Aut natus et numquam ad iusto molestiae. Nostrum quas natus ullam quae. Et voluptas maxime reiciendis ratione voluptatem. Velit iusto sit voluptate laborum veritatis fugiat sed.	Slovakia	3, 11, 7	14	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
16	Jelly sour bar	Delicatesso	169	6.73	19	0	["cupcake1.png","biscuit1.png"]	"Milk solids, Salt, Milk, Hazelnut pieces, Vanilla, Cocoa butter, Soy lecithin, Butter"	Nihil perferendis rerum occaecati atque excepturi. Vero et inventore porro officiis consequatur omnis. Repellat qui officiis ratione explicabo vel tempore harum.	Poland	2, 9, 9	16	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
17	Delicate mint raisins	Sweetio	202	9.97	4	0	["biscuit1.png","cake1.png","bar1.png"]	"Milk, Cocoa mass, Vanilla, Sugar, Soy lecithin, Salt"	Voluptatem eum non est ratione corrupti. Molestiae dolores aut minus quaerat sit qui. Beatae ea rerum et adipisci sit error quia molestiae. Doloribus aut sequi neque incidunt provident sapiente.	Czech Republic	4, 6, 11	17	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
18	American premium pralines	Milka	288	5.95	29	0	["biscuit1.png","biscuit2.png"]	"Milk, Soy lecithin, Milk solids, Cream, Cocoa butter, Salt, Vanilla, Cocoa mass"	Eum optio in sed provident reiciendis tempore voluptas. Vel et aut eos aut. Et dolores quas eius voluptatem error et ratione. Illo quasi similique maiores blanditiis fugiat omnis.	Czech Republic	7, 8, 16	18	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
19	Winter toffee mix	Nestle	272	7.36	93	0	["cake1.png","bar1.png","biscuit1.png"]	"Milk, Hazelnut pieces, Cream, Cocoa mass, Cocoa butter, Soy lecithin, Milk solids, Sugar, Vanilla, Butter"	Aperiam corrupti occaecati dolor esse est dolores earum qui. Accusamus est animi voluptatem aperiam assumenda.	Slovakia	6, 17, 5	19	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
8	Winter sour bar	Bonapetitoo	179	12.91	51	0	["cupcake1.png"]	"Soy lecithin, Cocoa mass, Milk, Milk solids, Cream, Vanilla, Cocoa butter, Hazelnut pieces, Salt, Sugar"	Commodi officia id voluptas consequuntur. Laudantium voluptas et tenetur aut at temporibus maiores.	Czech Republic	15, 19, 13	8	60	5.16	t	2021-12-05 17:46:05	2021-12-05 17:46:06	\N
9	White chocolate toffee bar	Delicatesso	154	15.3	97	0	["biscuit2.png","cake1.png","cupcake1.png"]	"Milk, Salt, Cocoa mass, Cream, Vanilla, Sugar, Butter"	Quis et praesentium error alias qui accusantium. Facilis officiis qui distinctio facere et nesciunt blanditiis. Alias ex dolores consequatur doloribus. Et ut cupiditate sed magni maiores excepturi.	Slovakia	11, 2, 9	9	10	13.77	t	2021-12-05 17:46:05	2021-12-05 17:46:06	\N
15	Hot cream cupcake	Delicatesso	213	8.7	28	0	["cupcake1.png","bar1.png","biscuit2.png"]	"Milk, Cocoa mass, Vanilla, Hazelnut pieces, Butter, Soy lecithin"	Quod natus odio ratione eum nihil et. Laboriosam necessitatibus provident cum. Ut eveniet assumenda qui ut natus dolorem in nihil. Qui rerum voluptate quas sed.	USA	14, 1, 13	15	20	6.96	t	2021-12-05 17:46:05	2021-12-05 17:46:06	\N
20	Best mint cupcake	Bonapetitoo	266	9.15	52	0	["cupcake1.png","biscuit1.png","bar1.png","biscuit2.png"]	"Vanilla, Butter, Sugar, Hazelnut pieces, Salt, Soy lecithin, Cream, Cocoa butter"	Nulla magnam non reprehenderit ducimus qui qui in. In sequi excepturi nesciunt optio sint voluptas. Ut optio delectus autem consectetur consequuntur aut commodi.	Korea	4, 5, 10	20	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
21	Ukranian nougat lollipop	OmNomNom	28	14.97	59	0	["bar1.png","cupcake1.png","biscuit1.png"]	"Milk solids, Salt, Cream, Soy lecithin, Sugar, Hazelnut pieces, Cocoa mass, Butter"	Consequatur consequatur fuga iusto eaque. Non asperiores quaerat illo non quibusdam tempora enim. Neque culpa minima placeat sint similique omnis molestias.	Germany	1, 8, 6	21	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
23	Ukranian toffee biscuit	Haribo	222	2.52	80	0	["cake1.png","biscuit1.png","biscuit2.png","bar1.png"]	"Cocoa butter, Cream, Milk, Soy lecithin, Sugar, Salt"	Praesentium quo sed possimus qui neque ut. Perspiciatis vel ut incidunt aut. Fugiat explicabo dicta expedita inventore vero ut in enim. Enim aperiam blanditiis odio qui similique.	USA	10, 3, 4	23	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
24	Nerds nougat block	Nestle	169	12.74	57	0	["biscuit2.png","bar1.png","cake1.png","cupcake1.png"]	"Milk, Sugar, Butter, Cream, Vanilla"	Iste qui numquam officia numquam. Dicta quisquam et dolorem molestiae quos. Ut nam dolor fuga. Animi dolore unde dolores et autem.	Korea	2, 8, 7	24	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
25	Gummy sour mix	Sweetio	252	8.32	74	0	["bar1.png"]	"Salt, Cocoa butter, Sugar, Cocoa mass, Milk solids"	Voluptatem veniam qui dolorum ut eaque et. Dolore eveniet delectus excepturi repellat. Nulla aspernatur impedit qui dolor nobis velit rerum. Impedit temporibus expedita excepturi eos repellendus.	USA	2, 1, 16	25	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
27	Hot toffee lollipop	Sweetio	41	1.95	61	0	["biscuit1.png","biscuit2.png","cupcake1.png","bar1.png"]	"Soy lecithin, Cocoa mass, Cream, Salt, Milk, Vanilla, Hazelnut pieces, Milk solids, Butter, Sugar"	Velit eaque tempore placeat ut consequatur et. Accusamus praesentium voluptas suscipit corporis quae explicabo distinctio vero. Enim laudantium quo mollitia dicta.	Korea	5, 13, 18	27	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
28	Dark chocolate rainbow candy	Haribo	100	8.49	75	0	["biscuit1.png","biscuit2.png","bar1.png","cupcake1.png"]	"Hazelnut pieces, Milk, Cocoa butter, Salt, Butter, Cream, Cocoa mass, Soy lecithin"	Aut quaerat sed inventore amet. Reprehenderit quas sed quam assumenda quaerat. Dignissimos dolorem qui est tempore laborum accusamus maxime.	Slovakia	5, 20, 12	28	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
29	Winter premium raisins	Bonapetitoo	119	19.18	45	0	["bar1.png"]	"Hazelnut pieces, Cream, Soy lecithin, Vanilla, Butter"	Autem dolores dolores et. Quos impedit et repellat suscipit. Aut aliquid voluptatibus expedita exercitationem aut ut eos. Quos tempore nemo distinctio dolorem et.	Germany	5, 17, 14	29	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
30	Best mint cupcake	Nestle	273	4.35	62	0	["biscuit1.png","bar1.png","biscuit2.png"]	"Milk, Soy lecithin, Hazelnut pieces, Butter, Sugar, Cocoa butter, Vanilla, Milk solids, Cocoa mass"	Quia ipsam facilis repellat. Porro soluta ipsa sit rem ad mollitia. Perferendis eum similique impedit id a accusamus saepe est. Id doloremque porro eum magnam minus sit.	USA	4, 10, 20	30	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
31	Winter fresh marshmallow	Nestle	198	12.17	31	0	["cupcake1.png"]	"Sugar, Milk solids, Cream, Cocoa butter, Hazelnut pieces"	Nisi eos asperiores culpa. Exercitationem natus voluptates est ducimus. Dicta odit maxime enim. Maxime aut aut est alias. Perferendis voluptates architecto consequuntur eius. Dolorum nobis non esse.	Ukraine	20, 4, 8	31	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
32	Hot fresh cupcake	Bonapetitoo	170	5.31	88	0	["bar1.png","cupcake1.png","biscuit2.png"]	"Cream, Cocoa butter, Cocoa mass, Butter, Hazelnut pieces"	Exercitationem labore et quia placeat. Molestiae qui minima qui non aliquam. Omnis adipisci optio occaecati consequatur quas dolor atque.	Poland	16, 1, 12	32	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
33	American nougat candy	Sweetio	151	16.28	77	0	["cupcake1.png","biscuit1.png","bar1.png","biscuit2.png"]	"Cream, Vanilla, Butter, Cocoa mass, Milk, Cocoa butter, Hazelnut pieces, Milk solids, Sugar"	Odio eius cumque cupiditate magni quas. Ea dignissimos quia voluptas impedit eius dolor. Omnis reprehenderit explicabo aut. Pariatur autem autem error vel itaque porro.	Slovakia	8, 14, 12	33	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
34	Jelly toffee bonbons	Milka	98	9.92	0	0	["biscuit2.png","bar1.png","cupcake1.png","cake1.png"]	"Soy lecithin, Sugar, Vanilla, Milk solids, Cream, Cocoa mass, Butter, Hazelnut pieces"	Quae et aliquam placeat provident eum. Reprehenderit facere nam nihil quia labore quia. Suscipit hic et illo natus reiciendis provident laborum.	Ukraine	13, 5, 19	34	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
35	Best fresh pralines	OmNomNom	260	18.64	94	0	["cake1.png"]	"Milk solids, Salt, Butter, Hazelnut pieces, Cocoa butter, Soy lecithin, Vanilla, Milk"	Sequi architecto itaque fugiat voluptatem consequatur et. Ea quia aut sed ut voluptatem qui architecto. Molestiae ipsam aut dicta dolore ipsum ratione ratione.	Czech Republic	3, 10, 14	35	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
36	Dark chocolate mint pralines	OmNomNom	36	2.41	39	0	["bar1.png","cupcake1.png","biscuit2.png","cake1.png"]	"Cocoa butter, Milk solids, Hazelnut pieces, Cocoa mass, Sugar, Salt"	Dicta et aut quo maiores rem. Eos est provident sunt aut quas ut. Id et neque fugiat ullam suscipit.	Poland	9, 9, 13	36	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
37	Winter mint marshmallow	Roshen	248	15.71	36	0	["biscuit1.png","cupcake1.png","cake1.png"]	"Cream, Vanilla, Hazelnut pieces, Salt, Milk, Cocoa butter, Milk solids, Soy lecithin"	Voluptatem quia ducimus voluptas optio. Nostrum sunt voluptas quis natus ut corrupti earum quaerat. Sint dicta quae rerum porro ut eius quo dolore. Id delectus consequuntur debitis dolorum dolores.	Poland	15, 11, 20	37	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
38	Great toffee marshmallow	Delicatesso	68	4.94	14	0	["cupcake1.png"]	"Cream, Vanilla, Milk solids, Milk, Cocoa butter"	Voluptatum nihil ab quo minus. Harum deleniti qui in vero culpa quod. Accusamus ut odit id non veniam. Aliquam non repellendus labore repellat et dolor veniam.	Germany	16, 10, 5	38	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
26	Sweet toffee candy	OmNomNom	85	4.29	85	0	["cupcake1.png","biscuit1.png"]	"Salt, Milk solids, Hazelnut pieces, Cocoa butter, Cream, Butter"	Totam maiores aperiam neque velit. Et et voluptate beatae molestiae. Blanditiis cupiditate molestias facilis error. Incidunt voluptates doloremque hic quo.	USA	4, 9, 9	26	70	1.29	t	2021-12-05 17:46:05	2021-12-05 17:46:06	\N
39	American toffee bar	Delicatesso	169	16.01	7	0	["biscuit1.png"]	"Milk solids, Milk, Hazelnut pieces, Cocoa mass, Butter"	Unde magnam cum et. Provident eligendi minus magni a dignissimos. Magni et et provident officia consequatur.	Germany	16, 15, 19	39	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
40	Ukranian fresh raisins	Bonapetitoo	178	3.38	67	0	["cake1.png"]	"Hazelnut pieces, Milk, Vanilla, Sugar, Soy lecithin, Cocoa butter, Cocoa mass, Salt, Butter, Milk solids"	Cum eveniet non quisquam ut. Aut architecto nemo nostrum eaque.	Germany	15, 19, 13	40	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
41	Sweet rainbow marshmallow	Delicatesso	114	2.6	6	0	["cupcake1.png","cake1.png","biscuit2.png","biscuit1.png"]	"Butter, Cream, Vanilla, Milk, Hazelnut pieces, Soy lecithin, Sugar, Milk solids, Salt"	Non dolore at quis praesentium quaerat velit aut occaecati. Odio rerum cum laboriosam est eligendi. Harum repellendus rerum dignissimos eius rerum.	Germany	15, 6, 10	41	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
43	Winter rainbow raisins	Sweetio	105	6.07	6	0	["bar1.png"]	"Hazelnut pieces, Cream, Salt, Cocoa butter, Sugar, Milk"	Velit autem quia et sint perspiciatis. Quo asperiores quo et quia delectus. Consequatur omnis excepturi iusto temporibus architecto possimus. Illo vel dolore aperiam eum.	Ukraine	18, 5, 12	43	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
44	Ukranian sour mix	Bonapetitoo	138	11.84	99	0	["biscuit2.png","cupcake1.png","bar1.png"]	"Salt, Soy lecithin, Hazelnut pieces, Cream, Sugar, Cocoa butter, Cocoa mass, Vanilla, Milk solids, Milk"	Aut quia dolorem et. Deleniti aut minus consequuntur ea error est. Sed maiores iusto assumenda et quisquam. Et blanditiis iusto quia in.	USA	6, 4, 2	44	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
45	Best sour mix	Nestle	81	12.26	39	0	["biscuit2.png","cupcake1.png","biscuit1.png","cake1.png"]	"Soy lecithin, Milk solids, Cocoa mass, Salt, Butter, Sugar, Milk"	Dolore eius doloremque voluptates aut earum inventore unde. Nemo eum doloremque ducimus. Cupiditate quia dicta alias fugit voluptatum iste quia id. Ipsa natus aut nostrum facere vero.	Slovakia	1, 8, 4	45	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
46	Best mint raisins	Roshen	252	8.33	42	0	["bar1.png","biscuit2.png","cupcake1.png"]	"Cream, Milk solids, Milk, Salt, Cocoa mass, Sugar, Hazelnut pieces"	Unde similique et et fugit. Numquam nihil dolor placeat rerum quo aperiam voluptatem. Dolore odio excepturi recusandae debitis.	Czech Republic	3, 16, 14	46	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
47	Ukranian nougat lollipop	OmNomNom	229	12.37	4	0	["cupcake1.png","biscuit2.png","bar1.png"]	"Salt, Cream, Cocoa mass, Milk, Vanilla, Milk solids, Soy lecithin, Butter, Sugar, Cocoa butter"	Illo qui rerum unde ut nemo. Fugit non amet tempora voluptatem exercitationem. Voluptatem fugiat voluptas expedita.	Germany	20, 15, 4	47	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
48	Hot cream block	Roshen	287	13.1	82	0	["cake1.png","biscuit1.png"]	"Milk solids, Butter, Cocoa butter, Hazelnut pieces, Sugar, Cream, Salt, Milk, Soy lecithin"	Assumenda delectus blanditiis voluptate. Ducimus tempore omnis ratione doloribus illum et voluptate. Et earum fugit officia omnis et.	Ukraine	14, 10, 2	48	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
49	American toffee candy	Bonapetitoo	194	12.24	35	0	["biscuit2.png","cake1.png","biscuit1.png"]	"Hazelnut pieces, Cream, Salt, Soy lecithin, Butter, Milk solids, Milk, Sugar"	Expedita qui repudiandae neque. Esse voluptas ullam perferendis tempore neque rem. Voluptates sint autem quos sunt doloremque qui non.	Poland	7, 11, 12	49	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
50	Nerds premium lollipop	Milka	268	15.18	18	0	["biscuit2.png","cupcake1.png"]	"Cream, Soy lecithin, Milk solids, Cocoa butter, Cocoa mass, Salt, Butter, Hazelnut pieces, Milk, Sugar"	Consequatur voluptates soluta nihil sunt et quisquam earum. Maiores vitae harum porro in quis. Incidunt rerum necessitatibus est soluta earum. Laborum dolorum non quasi dicta quia numquam quas.	USA	3, 15, 11	50	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
51	Best nougat sherbet	Roshen	227	1.67	36	0	["bar1.png","biscuit1.png","cupcake1.png"]	"Cream, Cocoa butter, Salt, Hazelnut pieces, Cocoa mass, Milk solids, Milk, Vanilla, Butter"	Ratione voluptatem qui rerum fugiat ipsam voluptatem. Nisi accusamus dolore commodi nisi temporibus quia amet. Tempora iure quos eius voluptatum.	Korea	20, 13, 7	51	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
52	Best sour cupcake	Delicatesso	162	16.99	80	0	["biscuit2.png","bar1.png","biscuit1.png","cake1.png"]	"Cream, Butter, Vanilla, Soy lecithin, Cocoa mass, Hazelnut pieces, Cocoa butter"	Iste distinctio nisi quo explicabo. Et et nihil ducimus nostrum laboriosam. Est unde voluptatibus dolorum dolores qui animi repellat. Consequuntur nemo dicta qui aperiam asperiores et non.	USA	12, 14, 3	52	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
53	Great cream bar	Nestle	224	2.47	18	0	["biscuit1.png","bar1.png","cake1.png"]	"Cream, Hazelnut pieces, Sugar, Salt, Milk solids, Cocoa mass, Vanilla, Cocoa butter, Milk"	Cumque corporis ea numquam ipsam. Minus modi totam molestias. Itaque delectus repellat numquam.	Czech Republic	16, 19, 12	53	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
54	Gummy nougat mix	Delicatesso	179	17.81	11	0	["biscuit2.png","cupcake1.png"]	"Milk solids, Salt, Butter, Soy lecithin, Milk, Cream, Vanilla"	Quia dolores et et deleniti expedita exercitationem. Rem est eum modi pariatur vitae.	Czech Republic	5, 5, 17	54	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
55	American cream mix	Bonapetitoo	234	19.8	4	0	["cake1.png"]	"Hazelnut pieces, Salt, Sugar, Cocoa butter, Milk solids, Cream, Cocoa mass, Milk, Soy lecithin"	Dolorem perferendis accusamus ut est. Ut quam est sunt non suscipit omnis. Animi libero adipisci quidem aperiam et dolores et accusantium.	USA	18, 17, 20	55	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
56	Gummy rainbow raisins	Bonapetitoo	77	4.96	43	0	["cake1.png","biscuit1.png","biscuit2.png","cupcake1.png"]	"Milk, Cream, Cocoa butter, Soy lecithin, Hazelnut pieces, Butter"	Id doloribus dolores quia nesciunt magni vero. Ipsa aut tempore sequi inventore eum aspernatur aut. Et aut qui porro autem facilis eos qui voluptas.	Czech Republic	13, 8, 11	56	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
57	White chocolate nougat mix	Sweetio	190	10.66	28	0	["bar1.png","biscuit2.png"]	"Cocoa mass, Milk, Hazelnut pieces, Vanilla, Sugar, Milk solids, Cream"	Odit aut rem nostrum deleniti fugiat. Omnis et non et reiciendis mollitia sapiente rem et. Est id et optio earum eum fuga pariatur.	Germany	17, 15, 8	57	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
58	Dark chocolate nougat biscuit	Roshen	287	17.7	75	0	["biscuit2.png"]	"Cocoa mass, Cocoa butter, Milk, Butter, Hazelnut pieces"	Molestiae beatae est aliquid commodi aperiam. Ad expedita dolorum sed. Excepturi ea ducimus tenetur eveniet. Quia consequatur ea fugit eligendi et quos. Similique qui voluptatem eum fugit quidem.	USA	11, 3, 16	58	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
59	White chocolate cream bar	OmNomNom	233	15.17	41	0	["bar1.png","biscuit1.png","cupcake1.png"]	"Butter, Salt, Hazelnut pieces, Vanilla, Soy lecithin, Milk solids, Cream, Cocoa butter"	Reprehenderit repudiandae aut rem aut ad. Suscipit et aut ut voluptas ipsam reiciendis distinctio. Iusto aliquid inventore voluptatem eius dolores sunt.	Ukraine	11, 1, 16	59	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
60	Gummy premium bonbons	Nestle	145	1.71	33	0	["cupcake1.png","bar1.png","biscuit2.png"]	"Milk, Milk solids, Soy lecithin, Salt, Cream"	Necessitatibus voluptatem vel nihil. Et numquam voluptates vitae mollitia cum voluptatum.	Korea	20, 11, 19	60	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
61	Jelly mint lollipop	Haribo	56	13.3	8	0	["cupcake1.png"]	"Butter, Cocoa mass, Salt, Cream, Vanilla, Soy lecithin, Milk, Cocoa butter, Hazelnut pieces"	Ut aut eius et delectus natus eos. Sit numquam et fugiat consequatur blanditiis quae ea. Consequatur voluptates et quisquam quibusdam nisi beatae nihil. Rerum consequuntur corrupti illum animi.	Czech Republic	6, 17, 17	61	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
62	Hot premium cupcake	Milka	87	10.61	19	0	["cake1.png","biscuit1.png","cupcake1.png"]	"Milk solids, Cocoa mass, Cream, Milk, Soy lecithin, Cocoa butter"	Eum velit dolor harum expedita maiores. Libero commodi dicta officiis quaerat voluptatem aut. Deleniti a qui recusandae. Hic culpa et nam est libero.	Poland	1, 20, 6	62	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
63	Jelly nougat biscuit	Milka	286	6.38	67	0	["cake1.png","bar1.png","biscuit2.png"]	"Vanilla, Butter, Soy lecithin, Milk solids, Cocoa mass"	Nisi et consequatur nemo cumque. Repellendus sint id dolores. Ut libero molestiae nisi minus animi.	Korea	17, 4, 3	63	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
64	Dark chocolate mint mix	Bonapetitoo	60	6.06	22	0	["biscuit1.png","cupcake1.png","bar1.png","cake1.png"]	"Milk solids, Cream, Vanilla, Salt, Milk, Cocoa butter, Sugar, Hazelnut pieces"	Repellat itaque autem veritatis aut. Dolorem dignissimos natus corrupti quia voluptatibus et a. Assumenda officiis eius modi architecto repellat reprehenderit ducimus.	Slovakia	11, 5, 8	64	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
65	Sweet fresh bonbons	OmNomNom	105	16.79	43	0	["bar1.png"]	"Milk, Milk solids, Cream, Sugar, Salt, Cocoa butter"	Vero eligendi ipsum odit iusto delectus sequi a. Non ratione voluptate molestias incidunt ut consequatur architecto. Veritatis voluptatibus aut nisi at distinctio architecto.	USA	5, 18, 20	65	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
66	Delicate sour biscuit	Sweetio	261	8.56	47	0	["cake1.png"]	"Milk, Cocoa butter, Butter, Vanilla, Salt, Cocoa mass, Milk solids, Sugar, Hazelnut pieces, Soy lecithin"	Doloremque dolore magnam omnis quaerat. Animi maiores culpa rerum omnis quia deserunt eos. Modi qui consequatur dolorem illo quam eveniet a. Corporis autem officiis magni voluptatibus.	Germany	4, 2, 3	66	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
67	Hot toffee candy	Milka	298	11.28	49	0	["cake1.png","biscuit2.png","biscuit1.png"]	"Milk solids, Cream, Butter, Soy lecithin, Cocoa mass"	Eum aut ea voluptatum adipisci. Deserunt ut et ducimus odit et et. Qui molestias dolorem exercitationem et odit consectetur dolorem.	USA	14, 16, 4	67	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
68	Nerds toffee pralines	Bonapetitoo	235	9.06	53	0	["biscuit1.png","bar1.png","cake1.png"]	"Salt, Butter, Milk solids, Milk, Soy lecithin, Cocoa mass, Cocoa butter, Hazelnut pieces, Vanilla, Sugar"	Accusantium qui voluptatum optio recusandae. Nihil qui deserunt fugit occaecati perferendis inventore. Fugiat dolorem est velit illo quis doloremque.	Czech Republic	13, 1, 8	68	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
69	Dark chocolate fresh bar	Roshen	155	1.98	20	0	["biscuit2.png"]	"Sugar, Soy lecithin, Cocoa butter, Butter, Milk solids, Cream, Hazelnut pieces, Cocoa mass, Salt, Milk"	Fugit qui ut nisi aut eos sit. Accusantium unde doloribus vel neque ad qui. Magni est provident nobis. Voluptatem et et reprehenderit dolore nihil aperiam molestias.	Slovakia	11, 9, 16	69	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
70	Jelly nougat sherbet	Haribo	260	2.77	10	0	["cake1.png","cupcake1.png","bar1.png","biscuit1.png"]	"Vanilla, Salt, Milk solids, Cocoa butter, Milk, Butter, Soy lecithin, Cream, Cocoa mass"	Sequi optio aperiam voluptas rerum. In ut sunt consequatur dignissimos qui. Delectus veritatis consectetur rem dignissimos aliquam ab quisquam.	Ukraine	4, 18, 12	70	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
71	Hot cream cupcake	Haribo	21	10.45	21	0	["biscuit2.png","cake1.png","cupcake1.png"]	"Milk solids, Hazelnut pieces, Soy lecithin, Vanilla, Butter, Sugar, Milk, Cocoa butter"	Sit non autem et. Voluptatem quae placeat deleniti magnam delectus at nobis maxime. Ex dolores suscipit nihil facere provident quia animi. Illum aliquam veniam optio.	Ukraine	11, 11, 9	71	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
72	Gummy sour pralines	Nestle	134	16.94	5	0	["bar1.png","cupcake1.png","biscuit1.png"]	"Butter, Cream, Soy lecithin, Cocoa mass, Hazelnut pieces, Milk, Cocoa butter, Vanilla, Salt"	Et tenetur laudantium quo laudantium quis reprehenderit ullam quia. Consectetur et ut et voluptas quia aut. Dolor voluptatem rerum labore. Sed quos aut rerum. Autem sunt a rem et.	Poland	10, 18, 20	72	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
73	Hot mint bonbons	Bonapetitoo	120	2.16	4	0	["biscuit2.png","bar1.png","cupcake1.png","cake1.png"]	"Vanilla, Cocoa mass, Butter, Hazelnut pieces, Soy lecithin, Sugar, Milk solids, Milk, Salt"	Quia dolores reiciendis in inventore maiores sequi perferendis quo. Autem aut voluptatem voluptatum laudantium et repellat.	Korea	8, 20, 16	73	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
74	Dark chocolate nougat bar	Nestle	258	13.75	14	0	["bar1.png"]	"Milk, Vanilla, Milk solids, Cream, Hazelnut pieces"	Optio odio et consectetur sed et. Ratione quidem rerum occaecati dolor mollitia ab ex.	Germany	13, 1, 1	74	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
75	Hot premium lollipop	Haribo	62	16.43	64	0	["bar1.png","biscuit2.png"]	"Hazelnut pieces, Vanilla, Milk, Salt, Cream, Sugar, Soy lecithin, Milk solids, Cocoa butter, Cocoa mass"	Pariatur inventore neque quis alias tempore. Aut a quibusdam quaerat ratione aliquid. Qui ipsam unde incidunt quo maxime. Et debitis molestiae libero ut distinctio.	Korea	11, 12, 12	75	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
76	Ukranian nougat biscuit	Milka	139	17.08	4	0	["biscuit1.png","cake1.png","bar1.png"]	"Milk solids, Salt, Cocoa mass, Cocoa butter, Cream, Vanilla, Butter"	Aut facere dolorum itaque voluptates. Ut dolores ad reprehenderit aut voluptas. Tempora omnis recusandae placeat enim. Consequatur numquam doloribus minima qui.	Korea	15, 12, 15	76	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
77	American nougat sherbet	Delicatesso	242	17.02	20	0	["cake1.png","bar1.png","biscuit2.png","biscuit1.png"]	"Cream, Cocoa butter, Milk, Hazelnut pieces, Vanilla, Cocoa mass, Sugar, Milk solids"	Odio sunt hic alias vero reiciendis distinctio quis. Qui et molestiae ut vero officiis rem unde. Quis quisquam laudantium ut esse asperiores qui voluptas.	USA	4, 12, 19	77	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
79	White chocolate toffee bonbons	OmNomNom	157	12.89	62	0	["biscuit2.png","cupcake1.png"]	"Salt, Butter, Sugar, Milk, Hazelnut pieces"	Beatae et consectetur qui et. Totam eos vel hic aperiam adipisci in. Dolorem quidem incidunt exercitationem ea et sapiente eos. Ipsa cupiditate doloribus rerum quae dicta.	Ukraine	9, 19, 17	79	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
80	Ukranian mint pralines	Nestle	50	0.93	46	0	["biscuit1.png"]	"Soy lecithin, Cocoa mass, Milk, Cream, Butter, Milk solids, Sugar, Hazelnut pieces, Salt, Vanilla"	Nostrum porro ipsa atque pariatur. Repudiandae sed perferendis modi atque. Voluptas quis a debitis fugiat suscipit. Id dolorem vel alias ex ut quis est.	Germany	12, 18, 18	80	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
81	Hot toffee sherbet	Roshen	166	14.52	48	0	["bar1.png","biscuit1.png"]	"Salt, Soy lecithin, Cocoa mass, Hazelnut pieces, Butter, Milk, Sugar, Cream"	Et et et aut non excepturi qui. Ut rerum quidem placeat necessitatibus non et saepe non. Deserunt est corporis ut et aliquid. Sed perspiciatis accusamus neque.	Czech Republic	11, 7, 12	81	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
82	Dark chocolate nougat raisins	Milka	182	18.51	14	0	["bar1.png","biscuit2.png","cake1.png","cupcake1.png"]	"Milk, Hazelnut pieces, Soy lecithin, Cocoa mass, Vanilla, Sugar"	Ipsam veniam tempora et. Dolores sunt fugiat est assumenda voluptatem asperiores.	USA	3, 16, 19	82	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
83	Best premium bonbons	Milka	29	2.03	69	0	["bar1.png","biscuit1.png","cupcake1.png","biscuit2.png"]	"Sugar, Salt, Soy lecithin, Cream, Milk"	Asperiores illo nostrum aspernatur dolorum qui possimus quibusdam. Quasi quo odit dolores ipsa. Ipsa voluptatibus neque aut amet aliquam enim beatae. Rem sunt porro delectus eligendi repudiandae.	Germany	2, 14, 20	83	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
84	Nerds rainbow cupcake	Nestle	82	12.64	71	0	["cake1.png","cupcake1.png"]	"Milk solids, Butter, Milk, Sugar, Soy lecithin"	Aut ea quos molestiae et. Officia iste est tempora voluptas. Placeat et est tenetur accusamus. Esse quia officia officiis odit porro ut aut.	Korea	17, 4, 18	84	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
85	Dark chocolate mint candy	Sweetio	108	19.91	94	0	["biscuit1.png","bar1.png","cake1.png","cupcake1.png"]	"Milk solids, Cocoa mass, Sugar, Milk, Soy lecithin, Butter, Hazelnut pieces, Cream"	Ex omnis consequuntur ut odio praesentium corrupti. Minus repellendus sapiente facilis qui tenetur deserunt. Labore nisi iusto impedit est pariatur expedita et qui. Id numquam quaerat ut.	Poland	13, 5, 20	85	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
86	Delicate premium mix	Nestle	215	0.66	25	0	["biscuit1.png"]	"Sugar, Hazelnut pieces, Salt, Vanilla, Soy lecithin, Milk solids, Butter, Milk, Cocoa mass, Cream"	Quis molestias a dolor alias harum soluta et. Id expedita eos dolorem molestiae velit. Voluptatibus vero nostrum excepturi nulla. Consequatur quis placeat deserunt molestiae rerum numquam.	USA	11, 2, 14	86	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
87	White chocolate sour sherbet	Nestle	67	5.54	9	0	["bar1.png"]	"Soy lecithin, Hazelnut pieces, Cocoa butter, Butter, Vanilla, Milk"	Sequi ab provident quis voluptates voluptas cupiditate sed. Sit excepturi nostrum molestias dolor. Autem inventore excepturi dolorem minus ut et rerum. Doloremque molestiae enim voluptatem in.	Poland	5, 1, 16	87	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
88	Gummy sour sherbet	Roshen	214	17.98	44	0	["bar1.png","cupcake1.png","biscuit2.png","biscuit1.png"]	"Sugar, Cocoa mass, Milk, Salt, Hazelnut pieces, Milk solids, Butter, Vanilla, Cocoa butter, Soy lecithin"	Veniam officia deserunt ratione ea animi. Ad eos autem consequatur et ut sunt occaecati.	USA	20, 6, 12	88	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
89	Sweet fresh block	Delicatesso	25	8.37	51	0	["biscuit1.png","bar1.png","cupcake1.png","biscuit2.png"]	"Cocoa butter, Cocoa mass, Soy lecithin, Salt, Milk, Sugar, Hazelnut pieces, Milk solids, Cream, Vanilla"	Ut cumque temporibus expedita ut qui facere id. Ut libero ipsum fuga rerum. Voluptas qui praesentium aliquid. Repellendus tempora et occaecati ratione ea est et.	Ukraine	12, 1, 18	89	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
90	White chocolate nougat biscuit	Bonapetitoo	235	8.59	72	0	["biscuit1.png","cupcake1.png","biscuit2.png"]	"Hazelnut pieces, Salt, Milk solids, Soy lecithin, Cream, Cocoa mass, Sugar"	Itaque autem beatae cum consequatur. Et ipsam vel modi quibusdam.	USA	13, 17, 2	90	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
91	Sweet fresh cupcake	Delicatesso	256	18.66	4	0	["biscuit1.png","bar1.png","cake1.png"]	"Soy lecithin, Milk, Milk solids, Salt, Hazelnut pieces, Vanilla, Cream, Sugar, Butter, Cocoa mass"	Rerum magnam vel commodi excepturi distinctio nihil quis. Praesentium non ea debitis omnis commodi voluptatibus dolorum. Officia id perspiciatis in.	Korea	9, 3, 4	91	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
92	Jelly rainbow bar	Bonapetitoo	218	11.84	11	0	["cupcake1.png","bar1.png"]	"Vanilla, Sugar, Cream, Cocoa mass, Butter, Salt"	Ex cumque adipisci blanditiis et dolor. Esse rerum et quo blanditiis. Eius totam qui et aut. Sed sed quia sit ad perferendis.	Korea	1, 4, 10	92	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
93	Delicate fresh bonbons	Sweetio	29	2.55	7	0	["cupcake1.png","cake1.png","bar1.png"]	"Cocoa mass, Salt, Hazelnut pieces, Milk solids, Vanilla, Cocoa butter, Milk"	Quibusdam quam possimus sint excepturi quia ratione libero. Rerum est quis minima aliquam velit voluptatum. Quo quo error qui ex sed necessitatibus eius.	Korea	4, 5, 20	93	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
94	Winter cream marshmallow	Roshen	32	1.07	95	0	["biscuit2.png"]	"Cocoa mass, Butter, Salt, Sugar, Soy lecithin, Milk, Hazelnut pieces, Cream, Vanilla, Cocoa butter"	Dolorem asperiores nihil illo quod. Rerum nesciunt aut voluptas quos deleniti doloribus omnis perspiciatis. Sit quos unde qui praesentium.	Czech Republic	7, 11, 8	94	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
95	Gummy mint lollipop	Bonapetitoo	241	1.04	5	0	["cake1.png","biscuit1.png","biscuit2.png"]	"Cream, Cocoa butter, Milk, Sugar, Soy lecithin, Butter, Hazelnut pieces, Cocoa mass, Salt"	Nemo ut repellendus in at. Nesciunt sed rerum repellendus iusto nobis nihil provident. Voluptas tenetur ab voluptatem voluptas. Tenetur sed illum dolore.	Slovakia	11, 6, 8	95	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
96	Dark chocolate nougat marshmallow	Delicatesso	216	14.09	35	0	["bar1.png","biscuit1.png","cake1.png"]	"Soy lecithin, Hazelnut pieces, Milk solids, Butter, Sugar"	Voluptatem pariatur esse repellat minima qui. Quod iste quod eligendi quod dolore corporis. Nam voluptate doloremque voluptatem soluta. Labore est perferendis explicabo illum aliquid nostrum rerum.	Czech Republic	5, 1, 14	96	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
97	Best toffee biscuit	Delicatesso	121	13.72	44	0	["cake1.png","cupcake1.png"]	"Vanilla, Sugar, Milk, Soy lecithin, Cream"	Et quis aliquid corporis asperiores non. Reiciendis et dolorem qui dolorem enim temporibus. Et eum nisi et et.	Poland	14, 10, 6	97	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
98	Winter premium lollipop	OmNomNom	20	16.23	17	0	["cake1.png"]	"Sugar, Salt, Butter, Cream, Vanilla, Milk solids"	Aut repudiandae est id. Alias atque ut neque voluptatibus eum. Sit magnam facilis qui aspernatur sapiente ab.	Ukraine	13, 6, 10	98	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
99	Sweet premium biscuit	Nestle	96	17.4	86	0	["biscuit1.png","cupcake1.png"]	"Milk, Vanilla, Cocoa mass, Hazelnut pieces, Butter, Cocoa butter"	Aut enim voluptatem et neque eos voluptatibus. Expedita voluptatem sapiente accusamus animi quod distinctio. Debitis necessitatibus in accusamus.	Czech Republic	19, 9, 8	99	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
100	White chocolate fresh raisins	OmNomNom	117	4.77	39	0	["biscuit1.png"]	"Cocoa mass, Salt, Sugar, Butter, Cocoa butter"	Autem ut repellat et modi sunt. Eaque qui ab ut debitis. Recusandae molestias rerum accusantium nihil alias in. Aut iure eos velit sequi porro vitae.	USA	18, 6, 11	100	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
101	Sweet rainbow sherbet	Roshen	167	2.38	22	0	["cupcake1.png","biscuit2.png"]	"Soy lecithin, Milk, Vanilla, Salt, Cocoa butter, Butter, Milk solids, Hazelnut pieces, Sugar, Cream"	Et nesciunt nulla illo voluptatibus odio. Delectus dolores possimus laborum voluptatum dolores quis aliquam. At dolor aut quidem tempore mollitia quia numquam.	Korea	19, 13, 8	101	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
102	Delicate fresh block	Bonapetitoo	129	9.16	9	0	["cake1.png"]	"Milk solids, Sugar, Salt, Hazelnut pieces, Vanilla, Milk"	Nostrum aut nam sint neque. Voluptatem cum et ut quia numquam voluptas. Consequatur soluta rerum aspernatur maxime quae tempore et nostrum.	Korea	5, 11, 11	102	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
103	Jelly premium candy	Milka	221	8.08	87	0	["cupcake1.png","biscuit1.png"]	"Vanilla, Sugar, Hazelnut pieces, Cream, Milk, Soy lecithin, Butter, Salt, Milk solids, Cocoa mass"	Voluptate sed ipsa explicabo. Labore ut voluptatibus illum omnis. Odit quod fuga earum ut est. Aut aspernatur earum ea dolorum.	Ukraine	10, 14, 17	103	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
104	Delicate cream bar	Delicatesso	121	3.12	11	0	["cupcake1.png","bar1.png"]	"Salt, Cream, Sugar, Vanilla, Hazelnut pieces, Cocoa butter, Milk solids, Milk"	Tenetur officiis maxime et voluptas recusandae. Nesciunt rerum at ut excepturi ipsa illum rerum. Quasi ut non dicta repellat quia. Incidunt pariatur veritatis itaque unde nobis dolorem et.	Korea	12, 5, 6	104	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
106	Dark chocolate mint mix	Sweetio	264	18.57	61	0	["cupcake1.png","bar1.png","biscuit2.png","cake1.png"]	"Vanilla, Salt, Cocoa butter, Milk, Sugar, Hazelnut pieces, Soy lecithin, Cream, Butter, Cocoa mass"	Alias voluptas qui ad quia quisquam ut. Repellat modi eum et eos assumenda. Omnis ea nostrum suscipit nobis totam. Iure ut maxime omnis minima.	Poland	12, 12, 13	106	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
108	Gummy premium marshmallow	Sweetio	59	12.47	26	0	["cupcake1.png","cake1.png"]	"Soy lecithin, Milk, Cream, Milk solids, Salt"	Maxime modi aut enim deleniti et. Cumque eveniet quis doloremque aliquid. Ipsa sed harum eius nostrum culpa doloribus asperiores.	Slovakia	8, 15, 9	108	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
109	Gummy rainbow sherbet	Sweetio	295	10.71	79	0	["cake1.png"]	"Hazelnut pieces, Butter, Vanilla, Cocoa butter, Sugar, Cream"	Et mollitia fugit quia incidunt. Officia nisi officia ut ab doloremque. Quos placeat autem et aut totam.	Germany	7, 11, 1	109	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
110	Best premium cupcake	Delicatesso	89	11.52	63	0	["biscuit2.png","bar1.png","biscuit1.png","cupcake1.png"]	"Soy lecithin, Cocoa mass, Cream, Milk, Milk solids"	Eos quaerat ut eaque magnam eius voluptatem consequatur. Ipsa voluptas nisi tenetur ea mollitia et. Aut qui alias quasi quia laboriosam eius. Aut accusantium id consequatur aut quam sed.	Germany	7, 16, 5	110	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
111	Jelly premium cupcake	Nestle	201	1.68	98	0	["biscuit2.png","cake1.png","bar1.png","cupcake1.png"]	"Sugar, Milk solids, Cocoa butter, Cocoa mass, Butter, Milk, Salt, Soy lecithin, Vanilla, Hazelnut pieces"	Numquam ea dolorem consequatur. Enim quas animi impedit voluptas ipsum. Animi aut et occaecati accusamus nam voluptas.	Poland	6, 16, 5	111	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
112	Winter sour bonbons	Roshen	220	1.15	38	0	["bar1.png"]	"Cocoa mass, Cream, Salt, Hazelnut pieces, Vanilla, Sugar, Soy lecithin, Milk solids, Butter"	Eum ea repellat iure minus odit. Debitis dignissimos vero vel aspernatur. Corrupti consequatur dolorem tempora rerum dolorem. Porro nam fuga esse sed doloribus rerum.	Korea	18, 14, 1	112	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
113	Dark chocolate premium raisins	Roshen	20	8.12	7	0	["biscuit1.png","cupcake1.png"]	"Soy lecithin, Hazelnut pieces, Cocoa mass, Cocoa butter, Sugar, Cream"	Et aut accusamus qui. Ea animi odio itaque dolorum atque esse est possimus. Laborum enim rem ipsa adipisci odit explicabo. Qui ab sint aut magnam quia. Qui consequatur debitis ut omnis.	Ukraine	3, 10, 20	113	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
114	White chocolate toffee pralines	Milka	27	3.26	52	0	["cupcake1.png","bar1.png"]	"Hazelnut pieces, Cocoa mass, Cocoa butter, Sugar, Milk, Butter, Cream, Salt, Vanilla"	Soluta ipsum nemo ut sed quia. Suscipit repudiandae in corrupti dolorem aliquid itaque. Deleniti sequi reprehenderit impedit minima perspiciatis.	Slovakia	14, 3, 2	114	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
115	Ukranian nougat marshmallow	Bonapetitoo	58	10.47	4	0	["biscuit1.png","bar1.png","cupcake1.png","cake1.png"]	"Butter, Cream, Milk, Sugar, Salt, Soy lecithin"	Aut sequi labore beatae delectus rem quaerat corrupti. Atque similique voluptatem ea. Hic tenetur vero perferendis et corrupti sed. Accusantium qui porro odio tenetur iusto.	Ukraine	17, 3, 3	115	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
116	Gummy nougat marshmallow	Nestle	43	14.72	80	0	["biscuit1.png","biscuit2.png","cupcake1.png"]	"Salt, Vanilla, Milk, Soy lecithin, Sugar, Cream"	Voluptates quidem ex totam sint alias delectus esse. Et rerum quaerat sunt provident consequatur. Quisquam similique dolor similique ea eos possimus. Corrupti illum tempora nemo.	Slovakia	1, 10, 7	116	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
107	Delicate rainbow bonbons	OmNomNom	256	6.71	84	0	["biscuit1.png","cupcake1.png"]	"Hazelnut pieces, Cream, Sugar, Milk solids, Milk, Cocoa butter"	Autem harum necessitatibus ipsa molestiae ullam dolore. Voluptas aspernatur fuga consequatur quam cum. Nisi necessitatibus quia voluptatum delectus repellat consequatur.	Germany	2, 18, 20	107	20	5.37	t	2021-12-05 17:46:05	2021-12-05 17:46:08	\N
117	Best sour raisins	Nestle	51	3.88	33	0	["cake1.png","cupcake1.png"]	"Cocoa mass, Vanilla, Milk solids, Salt, Cream, Butter, Soy lecithin, Sugar"	Voluptatum repellat autem quae qui sint. Perspiciatis sed facilis vel ut vel. Omnis qui harum excepturi accusamus.	Korea	1, 2, 8	117	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
118	Gummy rainbow pralines	OmNomNom	121	7.2	16	0	["biscuit1.png","cupcake1.png","cake1.png","biscuit2.png"]	"Butter, Cream, Soy lecithin, Milk solids, Cocoa butter"	Distinctio autem non officiis tempora. Voluptas numquam ab corrupti repellendus voluptatem. Molestiae ullam et voluptatem dicta ex non. Ut odit minus consequatur consequuntur velit aut sed.	Slovakia	10, 13, 11	118	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
120	White chocolate rainbow mix	Sweetio	135	14.6	31	0	["bar1.png","cake1.png","biscuit1.png"]	"Soy lecithin, Hazelnut pieces, Cocoa mass, Vanilla, Butter, Salt, Cocoa butter, Milk solids, Cream, Milk"	Pariatur corporis aspernatur inventore corrupti qui id maxime velit. Ducimus dolorum mollitia qui aspernatur exercitationem. Libero minus et voluptates quo.	Poland	8, 19, 13	120	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
121	Ukranian toffee mix	Milka	138	1.58	86	0	["biscuit1.png","biscuit2.png","cupcake1.png"]	"Milk solids, Milk, Cocoa mass, Cream, Soy lecithin, Cocoa butter, Sugar"	Quod dolor voluptatem autem. Et magni cumque provident consequuntur et sequi. Eum veniam ut sapiente et repellendus est ut ad. Facere mollitia laboriosam quae nulla sed.	Czech Republic	11, 16, 14	121	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
122	White chocolate toffee candy	Sweetio	21	16.45	59	0	["bar1.png","cake1.png","biscuit1.png","cupcake1.png"]	"Cream, Vanilla, Cocoa mass, Butter, Salt, Sugar, Hazelnut pieces, Milk, Milk solids, Cocoa butter"	Eligendi ipsum non sint nesciunt. Consequatur qui quia voluptatem error illum. Modi doloribus doloribus vitae dignissimos exercitationem esse est.	Korea	13, 5, 3	122	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
124	Great mint candy	OmNomNom	25	13.96	65	0	["bar1.png"]	"Cocoa mass, Sugar, Soy lecithin, Hazelnut pieces, Cream, Salt, Milk, Vanilla, Cocoa butter, Milk solids"	Accusamus enim magnam reiciendis et sed assumenda. Dolore et molestiae illum. Veritatis minima rerum aliquam. In ipsam sed doloribus eum qui quo magnam.	Poland	17, 1, 18	124	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
125	Jelly sour block	Delicatesso	49	13.44	42	0	["biscuit1.png","cake1.png","cupcake1.png","biscuit2.png"]	"Butter, Salt, Vanilla, Cocoa butter, Soy lecithin"	Omnis omnis ratione totam temporibus. Totam fugit inventore non labore ab necessitatibus voluptas. Voluptates dolorem fugit ea voluptatem est ab impedit.	Slovakia	14, 19, 12	125	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
126	Sweet toffee bonbons	Roshen	230	9.61	19	0	["cake1.png","biscuit2.png"]	"Butter, Hazelnut pieces, Cream, Cocoa butter, Vanilla, Milk solids, Sugar, Soy lecithin, Milk"	Blanditiis itaque aut dicta maxime corporis provident. Minima ex nobis quia odit facere sed dolorem. Expedita consectetur culpa quasi in architecto ut.	Germany	13, 17, 11	126	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
127	Dark chocolate toffee bar	Milka	210	11.52	11	0	["bar1.png","cake1.png","cupcake1.png","biscuit1.png"]	"Sugar, Cocoa butter, Cocoa mass, Milk solids, Cream, Hazelnut pieces"	Et ipsum omnis aut aut. Dolores qui qui et at. Autem aliquid velit eius soluta vel ex sed.	Czech Republic	8, 10, 10	127	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
128	Best rainbow block	Delicatesso	110	10.44	42	0	["biscuit1.png","cake1.png","cupcake1.png"]	"Vanilla, Soy lecithin, Salt, Cocoa mass, Butter, Sugar, Hazelnut pieces"	Eum mollitia tenetur eveniet consequatur blanditiis. Voluptates eum nesciunt est et. Dolor sapiente quae ad consequatur aut iusto. Quisquam expedita a soluta omnis rerum nihil.	USA	9, 19, 18	128	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
129	Delicate sour raisins	Haribo	209	14.32	84	0	["biscuit1.png","cake1.png","biscuit2.png"]	"Cocoa butter, Salt, Milk, Butter, Cocoa mass, Cream, Vanilla, Hazelnut pieces, Soy lecithin"	Aspernatur non ipsum eos. Quidem consectetur quia sit quia. Quos et voluptatibus cum eligendi.	Ukraine	18, 10, 9	129	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
131	Best fresh pralines	OmNomNom	227	13.7	18	0	["biscuit2.png"]	"Butter, Milk, Milk solids, Cream, Cocoa mass, Vanilla, Sugar, Cocoa butter, Salt"	Fugiat alias quas sunt nihil earum enim praesentium neque. Repudiandae et consectetur corrupti est occaecati.	Czech Republic	5, 7, 9	131	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
133	White chocolate toffee raisins	Haribo	274	13.75	44	0	["cupcake1.png","biscuit2.png","cake1.png","bar1.png"]	"Vanilla, Cream, Cocoa mass, Butter, Salt, Milk, Cocoa butter, Sugar, Hazelnut pieces"	Nihil neque eos aut aut. Itaque totam consectetur fugiat iusto fuga quos neque. Natus sed natus consequatur deserunt est quasi. Ipsum eos qui repellat consequatur consequatur adipisci.	Germany	3, 17, 15	133	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
134	Delicate premium bonbons	OmNomNom	154	8.61	50	0	["cupcake1.png"]	"Vanilla, Cocoa butter, Butter, Cream, Soy lecithin, Cocoa mass, Salt, Milk, Sugar, Hazelnut pieces"	Atque vel et consequuntur maxime inventore nulla quisquam. Et sed id et molestiae est.	Poland	7, 7, 3	134	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
123	American premium bonbons	Milka	98	11.86	97	0	["bar1.png","cake1.png","cupcake1.png"]	"Cocoa mass, Butter, Soy lecithin, Milk, Sugar, Salt, Vanilla, Cream, Hazelnut pieces"	Eos nam placeat omnis. Ipsum explicabo perferendis officiis similique labore. Alias ullam commodi sit sint magnam. Autem quia dolor quisquam dignissimos. Aut ut magni repudiandae.	Poland	9, 6, 11	123	5	11.27	t	2021-12-05 17:46:05	2021-12-05 17:46:09	\N
130	Great rainbow sherbet	Sweetio	83	18.07	12	0	["bar1.png","biscuit1.png","cupcake1.png"]	"Butter, Salt, Cream, Soy lecithin, Sugar, Milk solids"	Nemo quasi et autem molestiae magnam et tempore. Repellat minus velit qui rerum vel et. Id sunt explicabo rerum. Aut est quia quia recusandae doloribus distinctio rerum ut.	Slovakia	15, 4, 13	130	65	6.32	t	2021-12-05 17:46:05	2021-12-05 17:46:09	\N
132	Nerds cream lollipop	Bonapetitoo	300	3.17	63	0	["cake1.png","bar1.png","cupcake1.png","biscuit1.png"]	"Cocoa mass, Milk, Butter, Cocoa butter, Milk solids, Hazelnut pieces, Vanilla"	Saepe natus sed eum. Eveniet quidem ut aperiam aliquam et nisi. Sit adipisci cupiditate ipsam temporibus eum alias laboriosam qui. Corrupti animi dolor impedit itaque reiciendis qui.	Germany	14, 10, 11	132	35	2.06	t	2021-12-05 17:46:05	2021-12-05 17:46:09	\N
135	Sweet nougat bonbons	Bonapetitoo	242	2.85	20	0	["cake1.png","cupcake1.png","biscuit1.png","bar1.png"]	"Sugar, Milk, Vanilla, Hazelnut pieces, Cream"	Odit aut nesciunt sed. Aperiam sunt recusandae autem odio autem. Aperiam eum voluptatem aut quod dolor nostrum. Et recusandae non incidunt voluptatem dolorem.	Ukraine	19, 18, 3	135	65	1	t	2021-12-05 17:46:05	2021-12-05 17:46:09	\N
136	Sweet rainbow lollipop	Delicatesso	160	15.24	3	0	["cupcake1.png","biscuit1.png"]	"Milk, Cocoa butter, Cream, Milk solids, Hazelnut pieces"	Animi quaerat debitis est tenetur. Ut sit ullam eum suscipit consectetur facere dolorem. Molestias tempora illo vitae dolore quas consequatur.	Poland	6, 16, 10	136	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
137	White chocolate fresh cupcake	Bonapetitoo	75	12.38	30	0	["cake1.png"]	"Milk solids, Sugar, Hazelnut pieces, Butter, Cocoa mass, Soy lecithin, Vanilla, Salt, Milk"	Sit debitis ut vel modi officia quos maxime. Aut et velit in est tenetur veritatis.	Czech Republic	16, 7, 8	137	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
138	Ukranian mint raisins	OmNomNom	202	15.81	12	0	["bar1.png","biscuit1.png","biscuit2.png","cake1.png"]	"Cream, Sugar, Soy lecithin, Vanilla, Cocoa mass"	Qui laudantium et aperiam ex aut itaque suscipit. Veniam est excepturi aspernatur ab nihil voluptatibus voluptatem. Quo fuga nulla corporis ipsam fuga.	Czech Republic	19, 8, 3	138	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
139	American cream bar	Delicatesso	209	1.16	29	0	["biscuit2.png","cake1.png","cupcake1.png","bar1.png"]	"Cocoa butter, Cocoa mass, Butter, Soy lecithin, Milk solids, Hazelnut pieces, Sugar, Cream"	Aut recusandae voluptatem ullam ex. Provident molestiae itaque architecto consectetur laborum. Quaerat similique reiciendis velit saepe quia.	Ukraine	13, 11, 17	139	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
140	Delicate fresh bar	Sweetio	268	16.87	5	0	["biscuit2.png","biscuit1.png","bar1.png"]	"Salt, Butter, Milk, Sugar, Milk solids"	Accusamus quaerat vel quia eum quisquam hic consequatur maiores. Accusantium dicta aut enim rerum.	Czech Republic	2, 20, 14	140	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
142	Ukranian nougat bar	Nestle	259	12.17	4	0	["cake1.png","biscuit2.png","cupcake1.png"]	"Cocoa butter, Cream, Sugar, Salt, Vanilla, Milk, Butter, Hazelnut pieces"	Iusto labore asperiores natus praesentium. Veritatis soluta ipsum aliquam consequuntur quibusdam facilis.	Korea	11, 7, 4	142	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
143	Gummy rainbow biscuit	Sweetio	83	1.25	61	0	["cupcake1.png","bar1.png","cake1.png"]	"Vanilla, Cocoa mass, Hazelnut pieces, Cocoa butter, Soy lecithin, Milk, Salt, Sugar, Cream"	Velit nisi velit commodi est est fuga. Eveniet non perspiciatis voluptatem illum ut. Sunt rerum consectetur expedita est id enim.	Ukraine	14, 2, 11	143	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
144	Dark chocolate toffee cupcake	Bonapetitoo	300	18.72	12	0	["bar1.png"]	"Milk, Milk solids, Vanilla, Cocoa mass, Sugar, Butter, Soy lecithin, Cocoa butter, Hazelnut pieces, Cream"	Deleniti sed cum voluptas dolor vitae sint. Quam eaque saepe atque fuga id aut dicta. Aut alias consequatur vitae iste. Ut amet et eos non. Atque dolorem consequatur dolores possimus quos.	Slovakia	10, 9, 12	144	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
145	Great nougat lollipop	Sweetio	62	9.46	65	0	["biscuit2.png","cupcake1.png"]	"Milk, Cocoa mass, Cream, Sugar, Soy lecithin, Hazelnut pieces, Cocoa butter"	Explicabo qui neque aut mollitia. Mollitia omnis error delectus. Voluptatum est numquam quam qui et laborum quo. Dicta molestias nisi placeat impedit adipisci nesciunt cupiditate.	Ukraine	5, 2, 4	145	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
147	Great toffee sherbet	Haribo	268	3.06	6	0	["cake1.png"]	"Cocoa mass, Butter, Hazelnut pieces, Vanilla, Cream, Milk"	Optio labore ad porro qui soluta totam. Voluptas ut veritatis perferendis harum.	Ukraine	5, 4, 5	147	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
148	Dark chocolate fresh marshmallow	Nestle	29	5.73	71	0	["bar1.png","cake1.png"]	"Vanilla, Cocoa butter, Butter, Cream, Soy lecithin, Salt, Cocoa mass, Milk, Hazelnut pieces"	Exercitationem et qui maxime. Tempore numquam voluptatum perferendis. Nemo voluptas assumenda consectetur sint. Enim neque explicabo fuga et expedita autem quam.	USA	14, 9, 12	148	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
149	Best toffee block	Roshen	128	15.98	41	0	["biscuit1.png","cupcake1.png","bar1.png","cake1.png"]	"Cocoa mass, Hazelnut pieces, Soy lecithin, Cocoa butter, Salt, Milk, Cream, Sugar, Vanilla"	Incidunt atque maiores consequatur itaque est. Facilis facere dolores sint rerum a molestiae vel. Optio vero id dolorem perspiciatis.	Korea	9, 10, 15	149	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
150	Best toffee sherbet	Haribo	221	7.15	32	0	["biscuit2.png","cupcake1.png"]	"Cream, Hazelnut pieces, Cocoa butter, Milk, Milk solids, Sugar, Butter, Salt, Cocoa mass"	Maiores odit vel architecto voluptatem totam autem. Debitis quo et dolore earum odit ea et. Hic natus tempora consequuntur sed eligendi commodi quisquam. Dolores suscipit eveniet ab placeat expedita.	USA	6, 14, 9	150	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
152	Gummy rainbow biscuit	Bonapetitoo	50	15.88	37	0	["bar1.png","biscuit2.png"]	"Soy lecithin, Sugar, Milk solids, Cocoa butter, Butter"	Dolorem placeat beatae est eos sed. Aut qui laboriosam nihil. Est sit velit quia repellat et autem.	Korea	12, 10, 13	152	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
153	Ukranian nougat candy	Sweetio	88	8.45	67	0	["bar1.png","cupcake1.png"]	"Soy lecithin, Milk, Salt, Sugar, Vanilla, Cream, Milk solids, Butter, Hazelnut pieces"	Ex ipsa sint sint autem qui delectus error repellat. Esse asperiores eum et est minus molestiae. Fugiat qui ipsa suscipit non. Et aliquid ducimus quos commodi ducimus consequuntur ex.	Poland	20, 15, 7	153	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
154	Delicate nougat cupcake	OmNomNom	35	5.45	60	0	["bar1.png","biscuit2.png","cupcake1.png"]	"Milk, Cocoa butter, Vanilla, Milk solids, Cocoa mass, Sugar, Hazelnut pieces, Soy lecithin"	Consequuntur ipsum necessitatibus sed itaque quibusdam totam veniam. Omnis modi quis et. Temporibus rem iusto eligendi omnis sed quis. Quia vel voluptate nulla ut praesentium.	USA	15, 9, 8	154	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
155	Gummy toffee block	Roshen	220	1.31	63	0	["biscuit1.png","cake1.png","cupcake1.png","bar1.png"]	"Milk, Cocoa butter, Cream, Milk solids, Soy lecithin"	Ea earum culpa et aut. Ducimus illum explicabo accusamus ex incidunt qui reiciendis amet.	Czech Republic	3, 19, 13	155	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
146	American toffee mix	Bonapetitoo	196	7.68	92	0	["biscuit2.png","biscuit1.png","cake1.png"]	"Hazelnut pieces, Sugar, Milk, Salt, Milk solids"	Quod dicta iure voluptatibus sit. Repellendus ratione delectus accusantium explicabo quaerat cum. Delectus fugit non et repudiandae eligendi.	Slovakia	9, 18, 6	146	45	4.22	t	2021-12-05 17:46:05	2021-12-05 17:46:09	\N
151	Winter mint raisins	Haribo	233	4.14	48	0	["biscuit1.png","biscuit2.png"]	"Cocoa mass, Vanilla, Milk, Hazelnut pieces, Salt, Butter"	Est id perferendis et quo vero. Porro occaecati consectetur ratione saepe et. Necessitatibus nobis quaerat est. Doloribus consequatur repellendus blanditiis nemo laudantium expedita voluptas.	Slovakia	8, 3, 20	151	75	1.04	t	2021-12-05 17:46:05	2021-12-05 17:46:09	\N
156	Great sour block	Haribo	22	19.04	72	0	["cake1.png","biscuit2.png"]	"Hazelnut pieces, Cocoa mass, Butter, Salt, Cream, Sugar, Soy lecithin, Milk solids, Vanilla"	Ut sed aut eaque quasi cupiditate sit. Repudiandae adipisci quo ut rem. Qui consequuntur magni quibusdam amet non.	Ukraine	8, 14, 20	156	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
157	Jelly nougat cupcake	Delicatesso	149	14.68	50	0	["cake1.png","biscuit2.png"]	"Soy lecithin, Salt, Cocoa mass, Hazelnut pieces, Butter, Milk solids, Cream, Vanilla, Sugar"	Dicta ipsum pariatur doloribus numquam nesciunt. Consequatur illum doloribus dolor. Vel quisquam qui vel dignissimos.	Ukraine	10, 7, 8	157	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
158	Delicate rainbow marshmallow	Delicatesso	297	19.64	60	0	["biscuit2.png","bar1.png","biscuit1.png","cake1.png"]	"Soy lecithin, Hazelnut pieces, Salt, Vanilla, Butter, Milk solids, Cocoa butter, Sugar, Cocoa mass, Cream"	Enim dicta dicta id consequatur sint suscipit. Voluptatibus nam iure sed maiores expedita aut. Animi in reprehenderit quidem maiores debitis. Placeat quam esse et magni nam.	USA	15, 15, 20	158	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
159	Gummy fresh candy	Delicatesso	260	19.35	13	0	["biscuit2.png","cupcake1.png"]	"Cocoa mass, Salt, Vanilla, Sugar, Milk solids, Cocoa butter"	Tempora illo quos eius ea maiores nulla. Ad minima explicabo recusandae voluptas magni culpa ratione eum. Quos voluptatem saepe unde ut qui quasi.	USA	15, 6, 4	159	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
160	Great fresh candy	Milka	262	4.12	51	0	["biscuit1.png","cupcake1.png","bar1.png","biscuit2.png"]	"Butter, Hazelnut pieces, Cream, Cocoa butter, Vanilla"	Dolor enim qui minus molestiae est. Dolor adipisci quam asperiores labore. Aut quis magni quas aliquid corrupti inventore necessitatibus. Explicabo quia dolorem laborum dolorem consectetur.	Korea	5, 19, 13	160	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
161	Nerds premium sherbet	Bonapetitoo	40	10.34	89	0	["bar1.png","cupcake1.png","biscuit1.png"]	"Hazelnut pieces, Milk, Cocoa mass, Cocoa butter, Cream"	Velit cumque incidunt officia nam. Rerum itaque qui earum eos minima voluptatem. Ducimus quia deserunt et est qui pariatur. Provident placeat deserunt odio sit. Unde et aliquid at eum.	Ukraine	8, 18, 17	161	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
162	Nerds cream cupcake	Bonapetitoo	169	15.16	21	0	["biscuit2.png","biscuit1.png","bar1.png","cupcake1.png"]	"Milk solids, Hazelnut pieces, Vanilla, Milk, Salt"	Earum culpa voluptatem vero odio sit accusamus vel. Et voluptas dolor modi. In harum ea ullam nam non saepe ut provident. Sint dolor dolor magni laudantium atque provident.	USA	4, 12, 20	162	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
163	Sweet sour cupcake	Bonapetitoo	160	11.2	52	0	["bar1.png","cake1.png"]	"Cocoa butter, Butter, Hazelnut pieces, Milk solids, Vanilla, Soy lecithin, Cream, Cocoa mass, Milk"	Numquam molestiae aperiam sit sunt laboriosam sapiente dolore. Sed qui ea assumenda consectetur. Ut labore deleniti quam aperiam rerum omnis. Consequatur modi consequuntur voluptas.	USA	8, 12, 16	163	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
164	American rainbow cupcake	Bonapetitoo	131	0.85	30	0	["biscuit2.png"]	"Sugar, Butter, Hazelnut pieces, Soy lecithin, Cream, Cocoa mass, Cocoa butter, Vanilla, Salt, Milk"	Illum vel nesciunt ea molestiae molestiae. Voluptatem perspiciatis nam architecto assumenda aut. Similique fugit sit voluptate in impedit autem ut.	Czech Republic	7, 1, 20	164	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
165	Delicate toffee candy	Bonapetitoo	209	4.07	79	0	["biscuit1.png","biscuit2.png","bar1.png"]	"Cocoa mass, Cocoa butter, Butter, Milk, Salt, Cream, Sugar, Milk solids, Vanilla"	In et rerum magnam fugit aspernatur. Similique fugit asperiores voluptate a accusamus. Dolorem quia debitis voluptatem adipisci.	Czech Republic	2, 14, 10	165	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
166	Delicate sour mix	Delicatesso	164	10.36	93	0	["biscuit2.png","bar1.png"]	"Hazelnut pieces, Milk, Soy lecithin, Vanilla, Milk solids, Salt, Cocoa butter"	Inventore deleniti aut et aut aliquid perspiciatis est blanditiis. Omnis veniam perspiciatis ex officia. Magnam sint dolor ullam magni nobis ullam. Qui dolores sunt quia qui qui aperiam quam.	Korea	18, 10, 2	166	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
167	Delicate rainbow lollipop	Milka	237	18.43	62	0	["cake1.png","biscuit1.png"]	"Milk solids, Butter, Salt, Vanilla, Soy lecithin, Hazelnut pieces, Milk, Cocoa butter"	Assumenda sint laudantium fuga voluptate eligendi ratione amet cupiditate. Esse sit odio molestiae saepe illum. Molestiae quas quod dolorum quas non.	USA	9, 6, 13	167	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
168	Gummy premium cupcake	Delicatesso	133	4.44	48	0	["cupcake1.png","biscuit1.png"]	"Sugar, Soy lecithin, Milk solids, Cream, Cocoa butter, Vanilla"	Ad sunt nisi exercitationem. Aut praesentium eveniet voluptatem ullam. Qui atque facilis commodi tempore ut possimus repellat. Nisi quidem qui minus officia.	Ukraine	7, 19, 8	168	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
169	White chocolate premium lollipop	Nestle	165	16.38	78	0	["cake1.png","bar1.png"]	"Cocoa butter, Cream, Sugar, Vanilla, Salt, Butter, Milk solids, Cocoa mass"	Aut nihil ut culpa dignissimos quo voluptates distinctio. Est earum incidunt veritatis rerum consequatur. Aliquam quo itaque distinctio sit modi cupiditate fugit. Id non eius expedita.	Ukraine	14, 10, 6	169	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
171	Best sour mix	Roshen	260	6.36	56	0	["cupcake1.png","cake1.png"]	"Hazelnut pieces, Salt, Butter, Soy lecithin, Milk, Vanilla, Sugar"	Facere deleniti ratione facere accusantium non ipsa. Quia repellat quia nesciunt sunt ad mollitia. Eum consequuntur quis consequatur itaque nam et.	Ukraine	19, 19, 13	171	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
172	Winter cream cupcake	Bonapetitoo	145	16.22	56	0	["cupcake1.png","biscuit1.png","biscuit2.png"]	"Milk, Milk solids, Soy lecithin, Salt, Cocoa butter"	Cum quia quia voluptatem. Laborum veniam asperiores quam accusamus ratione quisquam. Reprehenderit eligendi quod eum vero est est in. Nobis voluptatibus ducimus vel qui.	Germany	3, 5, 15	172	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
173	Dark chocolate premium mix	OmNomNom	283	5.46	27	0	["biscuit2.png","bar1.png","biscuit1.png"]	"Salt, Cocoa mass, Vanilla, Hazelnut pieces, Cream, Butter"	Ratione ut voluptas non ut et voluptatibus et. Possimus neque error eum.	Ukraine	12, 14, 4	173	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
174	Sweet rainbow raisins	Nestle	75	10.78	54	0	["cupcake1.png","bar1.png"]	"Milk, Soy lecithin, Milk solids, Butter, Cocoa butter, Salt, Hazelnut pieces"	Nostrum quidem et dolorem similique. Delectus aut facilis quis. Quos tempora recusandae consequatur totam natus.	Korea	16, 12, 17	174	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
175	Nerds rainbow bonbons	Bonapetitoo	130	10.46	47	0	["cupcake1.png","biscuit1.png","biscuit2.png","cake1.png"]	"Sugar, Milk solids, Cocoa mass, Cream, Soy lecithin, Milk"	Illum corporis dignissimos cumque quisquam atque optio enim saepe. Numquam numquam doloribus corporis non maiores et sit.	Ukraine	6, 17, 11	175	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
176	Great sour raisins	Sweetio	99	19.5	63	0	["cake1.png"]	"Soy lecithin, Cocoa butter, Milk, Hazelnut pieces, Milk solids"	Optio voluptatibus rem illum quo voluptatum ad in non. Mollitia ratione aut possimus consequuntur porro. Beatae ut vel pariatur iste. Nemo iure voluptatibus dolor similique velit.	Czech Republic	14, 1, 11	176	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
177	Sweet nougat bar	Delicatesso	175	16.46	78	0	["biscuit2.png","cupcake1.png","cake1.png","biscuit1.png"]	"Milk, Salt, Butter, Vanilla, Cocoa mass, Milk solids, Soy lecithin"	Ea perspiciatis et consequuntur repellat voluptatum neque perspiciatis. Sed veniam animi laudantium ut.	Czech Republic	6, 5, 20	177	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
178	White chocolate premium block	Delicatesso	35	13.59	97	0	["biscuit2.png","cake1.png","cupcake1.png"]	"Cream, Soy lecithin, Butter, Hazelnut pieces, Milk, Cocoa mass, Cocoa butter, Vanilla, Sugar"	Aut quaerat at voluptas adipisci recusandae natus ab. Eaque quis voluptas assumenda. Quae pariatur eligendi in sed fugit. Possimus quia accusantium saepe ut dignissimos.	Ukraine	16, 17, 12	178	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
179	Ukranian rainbow lollipop	Bonapetitoo	92	19.07	99	0	["biscuit1.png","cake1.png","bar1.png","cupcake1.png"]	"Milk, Cream, Butter, Sugar, Vanilla, Cocoa mass, Salt, Cocoa butter"	Aliquid aut explicabo culpa recusandae. Iusto officiis atque laborum. Tempore qui sequi consequatur qui dignissimos rerum. Quae quod porro quaerat recusandae mollitia doloremque labore.	Czech Republic	1, 17, 15	179	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
180	Sweet toffee bonbons	Milka	112	18.35	64	0	["cake1.png"]	"Hazelnut pieces, Cocoa mass, Cream, Salt, Milk solids, Butter, Cocoa butter"	Qui id sunt ut eos. Minima itaque beatae vero qui.	USA	18, 4, 13	180	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
181	American cream cupcake	Haribo	253	4.31	66	0	["cake1.png","bar1.png","biscuit1.png","cupcake1.png"]	"Salt, Milk, Cocoa butter, Cream, Soy lecithin"	Molestias quos quia officiis incidunt. Optio temporibus et facere corrupti corrupti. Illum et et rerum repudiandae ipsa aliquam. Nemo ab ea similique voluptatem neque laudantium.	Slovakia	9, 1, 17	181	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
182	Sweet nougat raisins	Bonapetitoo	201	18.54	78	0	["biscuit2.png","cupcake1.png","cake1.png","bar1.png"]	"Milk solids, Cocoa butter, Cream, Soy lecithin, Cocoa mass, Butter, Hazelnut pieces, Vanilla"	Commodi non praesentium odio consectetur. Voluptatem illum et dolorum. Dolore est magni itaque veniam ut saepe quibusdam.	Czech Republic	13, 10, 18	182	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
183	Gummy toffee bar	Nestle	155	10.31	60	0	["biscuit2.png","bar1.png","cake1.png","biscuit1.png"]	"Milk, Milk solids, Cocoa butter, Butter, Sugar, Vanilla, Soy lecithin, Cocoa mass"	Qui tempora inventore aperiam necessitatibus enim. Est aut magni ex ut sed ut aperiam.	Ukraine	7, 7, 12	183	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
184	Great premium bonbons	Bonapetitoo	143	18.44	13	0	["bar1.png"]	"Cream, Cocoa mass, Salt, Hazelnut pieces, Cocoa butter, Milk, Vanilla, Milk solids"	Minus quam quis nisi aut et. Aut provident sed quis ad. Non quod nostrum possimus eum fuga necessitatibus. Asperiores blanditiis ipsam minus voluptatem quis quos.	Korea	15, 8, 6	184	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
185	Delicate toffee pralines	Bonapetitoo	253	11.1	56	0	["cake1.png","bar1.png","cupcake1.png"]	"Sugar, Cocoa butter, Milk solids, Butter, Soy lecithin, Salt, Vanilla, Milk"	Voluptate occaecati ea deleniti nam. Voluptas sit sequi consequuntur. Laboriosam explicabo neque doloribus molestiae consequuntur totam omnis.	Slovakia	10, 4, 20	185	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
186	American mint mix	Bonapetitoo	210	10.96	35	0	["biscuit2.png","cake1.png","bar1.png"]	"Vanilla, Soy lecithin, Hazelnut pieces, Milk solids, Milk, Salt, Cocoa butter, Cream"	Aut maiores perferendis ut. Repudiandae quas sapiente laudantium necessitatibus enim. Sapiente iusto nulla ex. Explicabo est qui iure esse. Similique ut eum et ipsam voluptas doloremque corporis.	Slovakia	11, 13, 18	186	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
187	Jelly nougat bar	OmNomNom	218	6.2	39	0	["bar1.png"]	"Salt, Cream, Butter, Cocoa butter, Milk, Milk solids"	Ipsum ea deleniti necessitatibus distinctio. Sequi qui praesentium qui magnam ut sequi. Ipsam dolorem qui corrupti in.	Poland	6, 11, 8	187	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
188	Great nougat block	Delicatesso	143	11.03	24	0	["biscuit2.png","bar1.png","biscuit1.png"]	"Soy lecithin, Salt, Cocoa mass, Cocoa butter, Hazelnut pieces, Cream, Vanilla, Milk solids, Milk, Sugar"	Quasi reiciendis officia qui omnis. Rem qui nesciunt iusto ea vitae. Eligendi sed hic aperiam quia repellat. Ut non corporis dolorem sequi quia dolore qui.	Slovakia	15, 5, 7	188	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
189	Ukranian nougat cupcake	OmNomNom	258	6.06	69	0	["cake1.png","cupcake1.png"]	"Vanilla, Soy lecithin, Milk solids, Milk, Cocoa mass"	Qui consequatur ut libero rem aspernatur. Nobis culpa quia quo dolor quisquam magni. Amet perferendis ut beatae ut.	Poland	17, 4, 3	189	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
191	Jelly sour biscuit	Milka	135	3.02	9	0	["cupcake1.png","biscuit2.png","bar1.png"]	"Vanilla, Salt, Cream, Hazelnut pieces, Soy lecithin"	A doloremque enim saepe. Quas molestias facilis dolor qui et. Qui aut numquam repellendus voluptatum harum accusamus. Laboriosam molestias quo aut esse corrupti iste sunt.	Poland	1, 18, 20	191	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
192	Hot fresh pralines	OmNomNom	294	18.62	94	0	["biscuit1.png","cake1.png","cupcake1.png"]	"Soy lecithin, Vanilla, Cocoa mass, Salt, Cocoa butter, Hazelnut pieces, Sugar"	Qui sed mollitia et magni voluptatem sunt laborum. Pariatur id nulla est consequuntur. Dolores fugit ad quibusdam aut magni aut facilis perspiciatis.	Ukraine	10, 20, 8	192	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
193	Great nougat mix	Milka	199	12.72	58	0	["cake1.png","biscuit2.png"]	"Cream, Soy lecithin, Cocoa mass, Cocoa butter, Butter, Vanilla, Hazelnut pieces, Sugar, Milk"	Voluptatem provident corrupti odit voluptatum qui architecto. Ut et omnis dolorum dignissimos non quia. Mollitia et temporibus omnis qui eum. Exercitationem excepturi ab dolor quisquam.	Ukraine	15, 15, 14	193	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
194	Nerds sour cupcake	Nestle	42	0.76	53	0	["biscuit2.png","bar1.png"]	"Butter, Milk solids, Salt, Sugar, Cocoa mass, Hazelnut pieces, Cocoa butter"	Dolorem non maiores non deleniti sed consequatur placeat. Consectetur magnam tempore laborum aut.	Poland	11, 1, 17	194	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
195	Sweet rainbow lollipop	Delicatesso	274	4.94	94	0	["cake1.png","biscuit2.png"]	"Milk, Sugar, Vanilla, Salt, Butter, Milk solids, Cream, Cocoa mass, Hazelnut pieces, Soy lecithin"	Amet neque voluptatem nihil maiores ipsam quam provident. Dolor nobis ducimus veritatis ab ipsam fugit facere sunt. Quam sed suscipit rem consequuntur ut.	Korea	19, 2, 11	195	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
196	Hot cream cupcake	OmNomNom	29	1.57	71	0	["biscuit1.png","cake1.png","cupcake1.png"]	"Cocoa butter, Milk solids, Sugar, Cocoa mass, Vanilla, Cream, Soy lecithin, Salt, Hazelnut pieces, Butter"	Numquam rerum laborum eveniet dolore veniam. Aliquid sint aut est nihil molestiae soluta laudantium. Enim eligendi beatae sit eveniet rerum et deserunt.	Germany	12, 19, 10	196	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
197	Nerds fresh bonbons	Roshen	164	7.07	53	0	["biscuit2.png","biscuit1.png","cupcake1.png"]	"Cocoa mass, Cream, Milk solids, Hazelnut pieces, Soy lecithin, Sugar, Milk, Vanilla"	Ipsa aut quos similique omnis eveniet quaerat. Qui dolores voluptatum recusandae. Accusantium excepturi sint voluptatem id magni. Libero libero eaque occaecati deleniti.	Korea	4, 4, 2	197	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
198	Ukranian premium block	Nestle	197	17.63	81	0	["biscuit1.png","cupcake1.png","cake1.png","biscuit2.png"]	"Sugar, Hazelnut pieces, Butter, Cream, Cocoa mass"	Distinctio alias dicta expedita corporis perspiciatis quo. Quaerat animi amet pariatur quia enim quod. Nesciunt minus sequi et tempora molestiae. Nesciunt id voluptas unde eos.	Korea	11, 17, 18	198	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
199	Nerds toffee raisins	Bonapetitoo	233	7.65	57	0	["cupcake1.png","biscuit2.png"]	"Cream, Cocoa mass, Sugar, Butter, Milk solids, Hazelnut pieces, Cocoa butter, Soy lecithin, Milk, Vanilla"	Qui amet et fugiat minus magni. Autem porro recusandae ipsam exercitationem iusto eaque eum.	Korea	17, 10, 9	199	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
200	Sweet cream mix	Milka	167	7.12	61	0	["biscuit2.png","biscuit1.png","cake1.png"]	"Vanilla, Milk, Soy lecithin, Butter, Cream, Cocoa mass"	Labore cum molestiae eligendi non qui exercitationem. Animi earum et velit sapiente. Et illum quibusdam optio non. Impedit distinctio consectetur voluptatem minus.	Czech Republic	7, 8, 5	200	0	\N	t	2021-12-05 17:46:05	2021-12-05 17:46:05	\N
7	Winter sour bar	Nestle	83	13.96	56	0	["biscuit2.png","bar1.png"]	"Butter, Milk, Cocoa butter, Hazelnut pieces, Milk solids, Cocoa mass"	Sed consequuntur facilis eum officia. Quasi ea voluptates molestiae voluptatem. Temporibus tempore cupiditate esse earum inventore architecto.	USA	10, 6, 8	7	60	5.58	t	2021-12-05 17:46:05	2021-12-05 17:46:06	\N
22	Delicate rainbow pralines	Delicatesso	35	10.45	36	0	["cake1.png","biscuit1.png","biscuit2.png"]	"Vanilla, Butter, Cocoa mass, Cocoa butter, Hazelnut pieces"	Provident perspiciatis iusto qui ut laboriosam architecto. Veritatis nihil quas vero voluptatem est iure consequuntur. Qui voluptas enim et aut laudantium et accusantium.	Ukraine	9, 11, 17	22	25	7.84	t	2021-12-05 17:46:05	2021-12-05 17:46:06	\N
42	Delicate premium raisins	Sweetio	86	11.91	56	0	["cake1.png","biscuit1.png"]	"Vanilla, Hazelnut pieces, Soy lecithin, Cream, Milk solids, Butter, Salt, Cocoa butter"	Doloremque sit neque velit voluptatem iusto ipsam libero. Iusto ex facilis qui quidem. Aut aspernatur nulla aut.	Germany	19, 6, 13	42	20	9.53	t	2021-12-05 17:46:05	2021-12-05 17:46:07	\N
78	Best nougat mix	Delicatesso	114	6.95	21	0	["biscuit1.png"]	"Vanilla, Soy lecithin, Hazelnut pieces, Salt, Butter, Milk solids, Sugar, Cocoa butter, Cocoa mass, Milk"	Est velit sequi occaecati molestiae repellat. Porro eum et sit nihil in non quia. Libero aut explicabo harum in culpa quisquam.	Germany	17, 20, 11	78	60	2.78	t	2021-12-05 17:46:05	2021-12-05 17:46:08	\N
105	Winter rainbow candy	Roshen	299	8.09	76	0	["cupcake1.png","bar1.png"]	"Butter, Milk, Salt, Sugar, Cocoa butter, Hazelnut pieces, Cream"	Amet distinctio consequatur consequatur ab. Tempore vero et eum quasi. Ut quia ex sequi vel ratione praesentium. Sit dicta possimus adipisci omnis illo asperiores aut.	Slovakia	13, 14, 7	105	20	6.47	t	2021-12-05 17:46:05	2021-12-05 17:46:08	\N
119	American sour mix	Haribo	197	11.7	32	0	["biscuit2.png","bar1.png"]	"Soy lecithin, Cream, Cocoa mass, Sugar, Hazelnut pieces"	Sed quidem architecto vero et cumque. Aliquam non tempora omnis possimus alias est asperiores consequatur. Quas sequi exercitationem pariatur et atque et aut. Quis corrupti et minus rerum.	Slovakia	18, 19, 8	119	65	4.1	t	2021-12-05 17:46:05	2021-12-05 17:46:09	\N
141	Ukranian nougat marshmallow	Milka	32	6.63	13	0	["cake1.png"]	"Vanilla, Salt, Cocoa butter, Soy lecithin, Sugar"	Perferendis voluptas quia quod voluptatibus. Alias ullam necessitatibus odio quia necessitatibus. Sit omnis veniam aut vero rem.	Czech Republic	15, 7, 7	141	35	4.31	t	2021-12-05 17:46:05	2021-12-05 17:46:09	\N
170	Hot fresh biscuit	Nestle	201	2.27	11	0	["bar1.png","cupcake1.png","biscuit2.png","biscuit1.png"]	"Butter, Cocoa butter, Cream, Vanilla, Soy lecithin"	Quis amet mollitia distinctio voluptatem non illo. Nihil aliquid error alias laborum omnis. Accusamus et dolor et optio velit nulla illum.	Poland	5, 1, 17	170	10	2.04	t	2021-12-05 17:46:05	2021-12-05 17:46:10	\N
190	Best rainbow bar	Nestle	293	17.56	13	0	["biscuit2.png","cake1.png","cupcake1.png"]	"Milk solids, Hazelnut pieces, Sugar, Cocoa mass, Salt, Vanilla, Butter, Soy lecithin"	Sed neque voluptas sit quasi dicta et. Reprehenderit sint reiciendis a occaecati praesentium. Velit veniam at sed aut nisi distinctio numquam.	Korea	2, 17, 2	190	40	10.54	t	2021-12-05 17:46:05	2021-12-05 17:46:10	\N
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, is_admin, first_name, last_name, username, password, email, remember_token, created_at, updated_at) FROM stdin;
1	t	Jozef	Bugal	admin	$2y$10$isPLh7pbxFBVPGSND3Ym9O1EI92b5enF52S1LWdM9l/P2ZArHvvpK	admin@admin.sk	\N	2021-12-05 17:46:03	2021-12-05 17:46:03
2	f	Nicolas	Parker	helloworld	$2y$10$uOaEfvvOtst.7Nd6WMvH7e2rI9eTbcPz0UKXcepYwI7wXKXZz2ncy	jozko@bugal.sk	\N	2021-12-05 17:46:03	2021-12-05 17:46:03
\.


--
-- Name: allergens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.allergens_id_seq', 24, true);


--
-- Name: carts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.carts_id_seq', 1, false);


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categories_id_seq', 16, true);


--
-- Name: failed_jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.failed_jobs_id_seq', 1, false);


--
-- Name: gifts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.gifts_id_seq', 7, true);


--
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.migrations_id_seq', 13, true);


--
-- Name: nutrition_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.nutrition_id_seq', 200, true);


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orders_id_seq', 1, false);


--
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.personal_access_tokens_id_seq', 1, false);


--
-- Name: product_allergens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.product_allergens_id_seq', 1063, true);


--
-- Name: product_categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.product_categories_id_seq', 220, true);


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.products_id_seq', 200, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 2, true);


--
-- Name: allergens allergens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.allergens
    ADD CONSTRAINT allergens_pkey PRIMARY KEY (id);


--
-- Name: carts carts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carts
    ADD CONSTRAINT carts_pkey PRIMARY KEY (id);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: categories categories_url_name_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_url_name_unique UNIQUE (url_name);


--
-- Name: failed_jobs failed_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_pkey PRIMARY KEY (id);


--
-- Name: failed_jobs failed_jobs_uuid_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_uuid_unique UNIQUE (uuid);


--
-- Name: gifts gifts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gifts
    ADD CONSTRAINT gifts_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: nutrition nutrition_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nutrition
    ADD CONSTRAINT nutrition_pkey PRIMARY KEY (id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: personal_access_tokens personal_access_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personal_access_tokens
    ADD CONSTRAINT personal_access_tokens_pkey PRIMARY KEY (id);


--
-- Name: personal_access_tokens personal_access_tokens_token_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personal_access_tokens
    ADD CONSTRAINT personal_access_tokens_token_unique UNIQUE (token);


--
-- Name: product_allergens product_allergens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_allergens
    ADD CONSTRAINT product_allergens_pkey PRIMARY KEY (id);


--
-- Name: product_categories product_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_categories
    ADD CONSTRAINT product_categories_pkey PRIMARY KEY (id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: users users_email_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_unique UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_username_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_unique UNIQUE (username);


--
-- Name: password_resets_email_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX password_resets_email_index ON public.password_resets USING btree (email);


--
-- Name: personal_access_tokens_tokenable_type_tokenable_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX personal_access_tokens_tokenable_type_tokenable_id_index ON public.personal_access_tokens USING btree (tokenable_type, tokenable_id);


--
-- Name: carts carts_order_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carts
    ADD CONSTRAINT carts_order_id_foreign FOREIGN KEY (order_id) REFERENCES public.orders(id);


--
-- Name: carts carts_product_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carts
    ADD CONSTRAINT carts_product_id_foreign FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: carts carts_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carts
    ADD CONSTRAINT carts_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: orders orders_gift_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_gift_id_foreign FOREIGN KEY (gift_id) REFERENCES public.gifts(id);


--
-- Name: product_allergens product_allergens_allergen_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_allergens
    ADD CONSTRAINT product_allergens_allergen_id_foreign FOREIGN KEY (allergen_id) REFERENCES public.allergens(id);


--
-- Name: product_allergens product_allergens_product_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_allergens
    ADD CONSTRAINT product_allergens_product_id_foreign FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: product_categories product_categories_category_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_categories
    ADD CONSTRAINT product_categories_category_id_foreign FOREIGN KEY (category_id) REFERENCES public.categories(id);


--
-- Name: product_categories product_categories_product_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_categories
    ADD CONSTRAINT product_categories_product_id_foreign FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: products products_nutrition_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_nutrition_id_foreign FOREIGN KEY (nutrition_id) REFERENCES public.nutrition(id);


--
-- PostgreSQL database dump complete
--

