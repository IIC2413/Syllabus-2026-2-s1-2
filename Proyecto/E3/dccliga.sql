--
-- PostgreSQL database dump
--

\restrict oM6L4xehhnuFFGb76ZOpWccEvgWO8sCZ0thQbLvXMzA3iqkCv0t29JeeapCeof1

-- Dumped from database version 17.10 (Postgres.app)
-- Dumped by pg_dump version 18.4

-- Started on 2026-10-22 17:28:40 -03

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
-- TOC entry 243 (class 1259 OID 28057)
-- Name: Posiciones; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Posiciones" (
    idcampeonato integer NOT NULL,
    idequipo integer NOT NULL,
    puntos integer DEFAULT 0 NOT NULL,
    golesafavor integer DEFAULT 0,
    golesencontra integer DEFAULT 0,
    golesdelocal integer DEFAULT 0
);


ALTER TABLE public."Posiciones" OWNER TO postgres;

--
-- TOC entry 244 (class 1259 OID 28063)
-- Name: arbitro; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.arbitro (
    rut_pasaporte character varying(20) NOT NULL,
    fecha_inicio date NOT NULL,
    fecha_termino date NOT NULL
);


ALTER TABLE public.arbitro OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 27778)
-- Name: campeonato; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.campeonato (
    id_campeonato integer NOT NULL,
    nombre character varying(100) NOT NULL,
    tipo_competicion character varying(50) NOT NULL,
    anio integer NOT NULL,
    CONSTRAINT campeonato_anio_check CHECK ((anio >= 1900))
);


ALTER TABLE public.campeonato OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 27777)
-- Name: campeonato_id_campeonato_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.campeonato_id_campeonato_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.campeonato_id_campeonato_seq OWNER TO postgres;

--
-- TOC entry 3993 (class 0 OID 0)
-- Dependencies: 217
-- Name: campeonato_id_campeonato_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.campeonato_id_campeonato_seq OWNED BY public.campeonato.id_campeonato;


--
-- TOC entry 224 (class 1259 OID 27840)
-- Name: cuerpo_tecnico; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cuerpo_tecnico (
    rut_pasaporte character varying(20) NOT NULL,
    id_equipo integer NOT NULL,
    rol character varying(50) NOT NULL,
    partidos_castigados integer DEFAULT 0,
    CONSTRAINT cuerpo_tecnico_partidos_castigados_check CHECK ((partidos_castigados >= 0)),
    CONSTRAINT cuerpo_tecnico_rol_check CHECK (((rol)::text = ANY ((ARRAY['Director Técnico'::character varying, 'Asistente Técnico'::character varying, 'Médico'::character varying, 'Preparador Físico'::character varying, 'Utilero'::character varying])::text[])))
);


ALTER TABLE public.cuerpo_tecnico OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 27960)
-- Name: designacion_arbitro; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.designacion_arbitro (
    id_partido integer NOT NULL,
    rut_pasaporte character varying(20) NOT NULL,
    funcion character varying(30) NOT NULL,
    fecha_designacion date NOT NULL,
    CONSTRAINT designacion_arbitro_funcion_check CHECK (((funcion)::text = ANY ((ARRAY['Árbitro Principal'::character varying, 'Juez de Línea'::character varying, 'Árbitro Asistente'::character varying, 'VAR'::character varying])::text[])))
);


ALTER TABLE public.designacion_arbitro OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 27858)
-- Name: dirigente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dirigente (
    rut_pasaporte character varying(20) NOT NULL,
    id_equipo integer NOT NULL,
    cargo character varying(50) NOT NULL,
    fecha_inicio date NOT NULL,
    fecha_fin date,
    CONSTRAINT dirigente_cargo_check CHECK (((cargo)::text = ANY ((ARRAY['presidente'::character varying, 'vicepresidente'::character varying, 'tesorero'::character varying, 'secretario'::character varying, 'dirigente'::character varying])::text[])))
);


ALTER TABLE public.dirigente OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 27786)
-- Name: equipo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.equipo (
    id_equipo integer NOT NULL,
    rut_equipo character varying(12) NOT NULL,
    nombre character varying(100) NOT NULL,
    direccion character varying(200) NOT NULL,
    correo character varying(100) NOT NULL,
    presidente character varying(100) NOT NULL,
    "división" "char"
);


ALTER TABLE public.equipo OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 27796)
-- Name: equipo_campeonato; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.equipo_campeonato (
    id_equipo integer NOT NULL,
    id_campeonato integer NOT NULL
);


ALTER TABLE public.equipo_campeonato OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 27785)
-- Name: equipo_id_equipo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.equipo_id_equipo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.equipo_id_equipo_seq OWNER TO postgres;

--
-- TOC entry 3994 (class 0 OID 0)
-- Dependencies: 219
-- Name: equipo_id_equipo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.equipo_id_equipo_seq OWNED BY public.equipo.id_equipo;


--
-- TOC entry 227 (class 1259 OID 27875)
-- Name: estadio; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.estadio (
    id_estadio integer NOT NULL,
    nombre character varying(100) NOT NULL,
    direccion character varying(200) NOT NULL,
    capacidad integer NOT NULL,
    tipo_superficie character varying(30) NOT NULL,
    CONSTRAINT estadio_capacidad_check CHECK ((capacidad > 0)),
    CONSTRAINT estadio_tipo_superficie_check CHECK (((tipo_superficie)::text = ANY ((ARRAY['pasto natural'::character varying, 'pasto mixto'::character varying, 'pasto sintético'::character varying])::text[])))
);


ALTER TABLE public.estadio OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 27874)
-- Name: estadio_id_estadio_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.estadio_id_estadio_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.estadio_id_estadio_seq OWNER TO postgres;

--
-- TOC entry 3995 (class 0 OID 0)
-- Dependencies: 226
-- Name: estadio_id_estadio_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.estadio_id_estadio_seq OWNED BY public.estadio.id_estadio;


--
-- TOC entry 228 (class 1259 OID 27883)
-- Name: estadio_local; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.estadio_local (
    id_equipo integer NOT NULL,
    id_estadio integer NOT NULL
);


ALTER TABLE public.estadio_local OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 27977)
-- Name: gol; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.gol (
    id_gol integer NOT NULL,
    id_partido integer NOT NULL,
    rut_jugador character varying(20) NOT NULL,
    minuto integer NOT NULL,
    CONSTRAINT gol_minuto_check CHECK (((minuto >= 1) AND (minuto <= 130)))
);


ALTER TABLE public.gol OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 27976)
-- Name: gol_id_gol_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.gol_id_gol_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.gol_id_gol_seq OWNER TO postgres;

--
-- TOC entry 3996 (class 0 OID 0)
-- Dependencies: 234
-- Name: gol_id_gol_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.gol_id_gol_seq OWNED BY public.gol.id_gol;


--
-- TOC entry 240 (class 1259 OID 28020)
-- Name: integrante_tribunal; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.integrante_tribunal (
    rut_pasaporte character varying(20) NOT NULL,
    id_sala integer NOT NULL,
    cargo character varying(30) NOT NULL,
    CONSTRAINT integrante_tribunal_cargo_check CHECK (((cargo)::text = ANY ((ARRAY['Presidente'::character varying, 'Secretario'::character varying, 'Abogado'::character varying])::text[])))
);


ALTER TABLE public.integrante_tribunal OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 27945)
-- Name: participacion_partido_cuerpo_tecnico; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.participacion_partido_cuerpo_tecnico (
    id_partido integer NOT NULL,
    rut_pasaporte character varying(20) NOT NULL,
    rol_en_partido character varying(50) NOT NULL
);


ALTER TABLE public.participacion_partido_cuerpo_tecnico OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 27929)
-- Name: participacion_partido_jugador; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.participacion_partido_jugador (
    id_partido integer NOT NULL,
    rut_pasaporte character varying(20) NOT NULL,
    condicion character varying(10) NOT NULL,
    CONSTRAINT participacion_partido_jugador_condicion_check CHECK (((condicion)::text = ANY ((ARRAY['Titular'::character varying, 'Suplente'::character varying])::text[])))
);


ALTER TABLE public.participacion_partido_jugador OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 27899)
-- Name: partido; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.partido (
    id_partido integer NOT NULL,
    id_campeonato integer NOT NULL,
    numero_fecha integer NOT NULL,
    id_equipo_local integer NOT NULL,
    id_equipo_visita integer NOT NULL,
    id_estadio integer NOT NULL,
    fecha_hora timestamp without time zone NOT NULL,
    publico_asistente integer DEFAULT 0,
    estado text DEFAULT 'Programado'::text NOT NULL,
    CONSTRAINT partido_check CHECK ((id_equipo_local <> id_equipo_visita)),
    CONSTRAINT partido_estado_check CHECK ((estado = ANY (ARRAY['Programado'::text, 'Finalizado'::text]))),
    CONSTRAINT partido_numero_fecha_check CHECK ((numero_fecha > 0)),
    CONSTRAINT partido_publico_asistente_check CHECK ((publico_asistente >= 0))
);


ALTER TABLE public.partido OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 27898)
-- Name: partido_id_partido_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.partido_id_partido_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.partido_id_partido_seq OWNER TO postgres;

--
-- TOC entry 3997 (class 0 OID 0)
-- Dependencies: 229
-- Name: partido_id_partido_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.partido_id_partido_seq OWNED BY public.partido.id_partido;


--
-- TOC entry 222 (class 1259 OID 27811)
-- Name: persona; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.persona (
    rut_pasaporte character varying(20) NOT NULL,
    nombre_completo character varying(150) NOT NULL,
    fecha_nacimiento date NOT NULL,
    nacionalidad character varying(50) NOT NULL,
    telefono character varying(20),
    email character varying(100)
);


ALTER TABLE public.persona OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 27816)
-- Name: plantel_jugador; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.plantel_jugador (
    rut_pasaporte character varying(20) NOT NULL,
    id_equipo integer NOT NULL,
    id_campeonato integer NOT NULL,
    sueldo numeric(12,2),
    posicion character varying(30) NOT NULL,
    habilitado boolean DEFAULT true,
    partidos_castigados integer DEFAULT 0,
    CONSTRAINT plantel_jugador_partidos_castigados_check CHECK ((partidos_castigados >= 0)),
    CONSTRAINT plantel_jugador_sueldo_check CHECK ((sueldo >= (0)::numeric))
);


ALTER TABLE public.plantel_jugador OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 28014)
-- Name: sala_tribunal; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sala_tribunal (
    id_sala integer NOT NULL,
    nombre_sala character varying(50) NOT NULL
);


ALTER TABLE public.sala_tribunal OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 28013)
-- Name: sala_tribunal_id_sala_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sala_tribunal_id_sala_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sala_tribunal_id_sala_seq OWNER TO postgres;

--
-- TOC entry 3998 (class 0 OID 0)
-- Dependencies: 238
-- Name: sala_tribunal_id_sala_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sala_tribunal_id_sala_seq OWNED BY public.sala_tribunal.id_sala;


--
-- TOC entry 242 (class 1259 OID 28037)
-- Name: sancion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sancion (
    id_sancion integer NOT NULL,
    rut_sancionado character varying(20) NOT NULL,
    id_campeonato integer NOT NULL,
    motivo text NOT NULL,
    fechas_castigo integer NOT NULL,
    fecha_sentencia date NOT NULL,
    CONSTRAINT chk_fechas_castigo CHECK ((fechas_castigo > 0)),
    CONSTRAINT sanccion_fechas_castigo_check CHECK ((fechas_castigo > 0))
);


ALTER TABLE public.sancion OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 28036)
-- Name: sanccion_id_sancion_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sanccion_id_sancion_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sanccion_id_sancion_seq OWNER TO postgres;

--
-- TOC entry 3999 (class 0 OID 0)
-- Dependencies: 241
-- Name: sanccion_id_sancion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sanccion_id_sancion_seq OWNED BY public.sancion.id_sancion;


--
-- TOC entry 237 (class 1259 OID 27995)
-- Name: tarjeta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tarjeta (
    id_tarjeta integer NOT NULL,
    id_partido integer NOT NULL,
    rut_persona character varying(20) NOT NULL,
    tipo_tarjeta character varying(10) NOT NULL,
    minuto integer NOT NULL,
    CONSTRAINT tarjeta_minuto_check CHECK (((minuto >= 1) AND (minuto <= 130))),
    CONSTRAINT tarjeta_tipo_tarjeta_check CHECK (((tipo_tarjeta)::text = ANY ((ARRAY['Amarilla'::character varying, 'Roja'::character varying])::text[])))
);


ALTER TABLE public.tarjeta OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 27994)
-- Name: tarjeta_id_tarjeta_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tarjeta_id_tarjeta_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tarjeta_id_tarjeta_seq OWNER TO postgres;

--
-- TOC entry 4000 (class 0 OID 0)
-- Dependencies: 236
-- Name: tarjeta_id_tarjeta_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tarjeta_id_tarjeta_seq OWNED BY public.tarjeta.id_tarjeta;


--
-- TOC entry 3708 (class 2604 OID 27781)
-- Name: campeonato id_campeonato; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.campeonato ALTER COLUMN id_campeonato SET DEFAULT nextval('public.campeonato_id_campeonato_seq'::regclass);


--
-- TOC entry 3709 (class 2604 OID 27789)
-- Name: equipo id_equipo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.equipo ALTER COLUMN id_equipo SET DEFAULT nextval('public.equipo_id_equipo_seq'::regclass);


--
-- TOC entry 3713 (class 2604 OID 27878)
-- Name: estadio id_estadio; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estadio ALTER COLUMN id_estadio SET DEFAULT nextval('public.estadio_id_estadio_seq'::regclass);


--
-- TOC entry 3717 (class 2604 OID 27980)
-- Name: gol id_gol; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gol ALTER COLUMN id_gol SET DEFAULT nextval('public.gol_id_gol_seq'::regclass);


--
-- TOC entry 3714 (class 2604 OID 27902)
-- Name: partido id_partido; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.partido ALTER COLUMN id_partido SET DEFAULT nextval('public.partido_id_partido_seq'::regclass);


--
-- TOC entry 3719 (class 2604 OID 28017)
-- Name: sala_tribunal id_sala; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sala_tribunal ALTER COLUMN id_sala SET DEFAULT nextval('public.sala_tribunal_id_sala_seq'::regclass);


--
-- TOC entry 3720 (class 2604 OID 28040)
-- Name: sancion id_sancion; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sancion ALTER COLUMN id_sancion SET DEFAULT nextval('public.sanccion_id_sancion_seq'::regclass);


--
-- TOC entry 3718 (class 2604 OID 27998)
-- Name: tarjeta id_tarjeta; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tarjeta ALTER COLUMN id_tarjeta SET DEFAULT nextval('public.tarjeta_id_tarjeta_seq'::regclass);


--
-- TOC entry 3986 (class 0 OID 28057)
-- Dependencies: 243
-- Data for Name: Posiciones; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Posiciones" (idcampeonato, idequipo, puntos, golesafavor, golesencontra, golesdelocal) FROM stdin;
\.


--
-- TOC entry 3987 (class 0 OID 28063)
-- Dependencies: 244
-- Data for Name: arbitro; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.arbitro (rut_pasaporte, fecha_inicio, fecha_termino) FROM stdin;
10001236-7	1996-07-12	2025-09-25
10001635-4	2000-08-08	2025-11-03
10001850-0	1997-08-20	2022-07-30
10001788-1	1974-10-10	9999-12-31
10001525-0	1989-12-06	2023-10-08
10001241-3	1988-06-18	2022-09-03
10001362-2	1991-07-18	2026-08-07
10001104-2	1975-04-29	2022-03-18
10001954-K	1981-12-03	2023-07-31
10001934-5	1973-11-10	2023-10-30
10001094-1	1999-04-14	9999-12-31
10001337-1	1991-05-01	2022-12-20
10001801-2	1990-07-20	9999-12-31
10001358-4	1984-08-31	2020-08-22
10001283-9	1996-03-09	2022-08-02
10001596-K	1991-07-18	2021-07-17
10001017-8	1974-04-19	2024-09-30
10001783-0	1988-04-12	2020-07-25
10001538-2	1998-03-08	2022-12-26
10001624-9	1997-08-21	2025-09-22
10001942-6	1993-04-04	2024-07-23
10001612-5	1973-08-06	2020-01-25
10001892-6	1987-04-07	9999-12-31
10001809-8	1987-10-15	2026-08-03
10001931-0	1982-03-21	2024-07-07
10001367-3	1992-02-13	2025-05-17
10001702-4	1988-08-24	2021-10-25
10001410-6	1985-03-11	2025-11-24
10001370-3	1982-11-23	2021-01-23
10001473-4	1980-06-23	9999-12-31
10001678-8	1994-08-12	2025-12-12
10001773-3	1973-07-01	9999-12-31
10001460-2	1993-11-23	2023-01-21
10001107-7	1997-06-15	2022-12-11
10001045-3	1994-11-19	2023-03-03
10001975-2	1978-11-22	2025-03-17
10001298-7	1989-06-17	2024-01-09
10001375-4	1984-11-03	2022-09-15
10001701-6	1984-11-04	9999-12-31
10001706-7	1978-02-26	9999-12-31
10001682-6	1983-05-21	2025-07-12
10001084-4	1996-02-21	2020-12-10
10001638-9	1984-03-25	9999-12-31
10001143-3	1981-10-09	2024-07-16
10001977-9	1985-02-03	2020-12-09
10001063-1	1992-03-16	2021-06-27
10001529-3	1980-09-19	9999-12-31
10001959-0	1993-05-01	9999-12-31
10001557-9	1983-04-19	9999-12-31
10001111-5	1992-09-29	9999-12-31
10001736-9	1978-09-23	2025-11-05
10001849-7	1976-03-25	2024-11-28
10001647-8	1995-02-21	9999-12-31
10001610-9	1975-01-18	2020-12-07
10001819-5	1975-01-29	9999-12-31
10001060-7	1974-09-29	2024-09-15
10001030-5	1978-06-29	2020-03-11
10001091-7	1982-10-26	2021-08-10
10001157-3	2000-05-18	9999-12-31
10001651-6	1985-09-16	2020-08-17
10001655-9	1981-04-29	2025-11-19
10001864-0	1981-11-24	2023-02-20
10001101-8	1985-09-14	9999-12-31
10001399-1	1998-05-06	2023-07-18
10001411-4	1992-11-24	2022-02-04
10001700-8	1990-12-01	2026-07-24
10001051-8	1994-02-20	2023-05-04
10001552-8	1979-10-19	2022-06-03
10001389-4	1974-11-30	2025-01-01
10001035-6	1993-04-20	9999-12-31
10001391-6	1974-04-18	9999-12-31
10001273-1	1980-11-10	2023-12-08
10001909-4	1997-12-15	2024-05-20
10001073-9	1988-04-05	2021-04-25
10001873-K	1995-01-02	2024-11-21
10001347-9	1997-11-13	2020-03-05
10001535-8	1983-09-16	2020-12-23
10001924-8	1995-03-24	9999-12-31
10001615-K	1987-01-09	2024-06-30
10001407-6	1996-02-07	2022-03-01
\.


--
-- TOC entry 3961 (class 0 OID 27778)
-- Dependencies: 218
-- Data for Name: campeonato; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.campeonato (id_campeonato, nombre, tipo_competicion, anio) FROM stdin;
1	Nacional	primera A	1933
4	Liga	cuadrangular	1933
5	Nacional	primera A	1934
6	Liga	cuadrangular	1934
7	Gato	cuadrangular	1934
8	Nacional	primera A	1935
10	Liga	cuadrangular	1935
11	Gato	cuadrangular	1935
12	Nacional	primera A	1936
14	Liga	cuadrangular	1936
15	Gato	cuadrangular	1936
16	Nacional	primera A	1937
18	Liga	cuadrangular	1937
19	Gato	cuadrangular	1937
20	Nacional	primera A	1938
22	Gato	cuadrangular	1938
23	Apertura	primera A	1939
24	Clausura	primera A	1939
25	Liga	cuadrangular	1939
26	Nacional	primera A	1940
28	Liga	cuadrangular	1940
29	Apertura	primera A	1941
30	Clausura	primera A	1941
32	Nacional	primera A	1942
34	Gato	cuadrangular	1942
35	Nacional	primera A	1943
36	Liga	cuadrangular	1943
37	Gato	cuadrangular	1943
38	Apertura	primera A	1944
39	Clausura	primera A	1944
40	Gato	cuadrangular	1944
41	Nacional	primera A	1945
44	Liga	cuadrangular	1945
45	Nacional	primera A	1946
47	Liga	cuadrangular	1946
48	Nacional	primera A	1947
49	Liga	cuadrangular	1947
50	Gato	cuadrangular	1947
51	Nacional	primera A	1948
53	Gato	cuadrangular	1948
54	Nacional	primera A	1949
56	Gato	cuadrangular	1949
57	Nacional	primera A	1950
60	Liga	cuadrangular	1950
61	Nacional	primera A	1951
63	Liga	cuadrangular	1951
64	Apertura	primera A	1952
65	Clausura	primera A	1952
67	Liga	cuadrangular	1952
68	Nacional	primera A	1953
71	Gato	cuadrangular	1953
72	Nacional	primera A	1954
75	Liga	cuadrangular	1954
76	Nacional	primera A	1955
78	Liga	cuadrangular	1955
79	Nacional	primera A	1956
81	Liga	cuadrangular	1956
82	Gato	cuadrangular	1956
83	Nacional	primera A	1957
85	Liga	cuadrangular	1957
86	Gato	cuadrangular	1957
87	Nacional	primera A	1958
90	Nacional	primera A	1959
93	Gato	cuadrangular	1959
94	Nacional	primera A	1960
96	Gato	cuadrangular	1960
97	Nacional	primera A	1961
100	Liga	cuadrangular	1961
101	Nacional	primera A	1962
103	Liga	cuadrangular	1962
104	Apertura	primera A	1963
105	Clausura	primera A	1963
106	Liga	cuadrangular	1963
107	Apertura	primera A	1964
108	Clausura	primera A	1964
109	Liga	cuadrangular	1964
110	Nacional	primera A	1965
112	Gato	cuadrangular	1965
113	Nacional	primera A	1966
115	Liga	cuadrangular	1966
116	Nacional	primera A	1967
119	Liga	cuadrangular	1967
120	Apertura	primera A	1968
121	Clausura	primera A	1968
123	Nacional	primera A	1969
125	Gato	cuadrangular	1969
126	Nacional	primera A	1970
129	Gato	cuadrangular	1970
130	Nacional	primera A	1971
3	Cartón	Primera B	1933
9	Cartón	Primera B	1935
13	Cartón	Primera B	1936
17	Cartón	Primera B	1937
21	Cartón	Primera B	1938
27	Cartón	Primera B	1940
31	Cartón	Primera B	1941
33	Cartón	Primera B	1942
43	Cartón	Primera B	1945
46	Cartón	Primera B	1946
55	Cartón	Primera B	1949
59	Cartón	Primera B	1950
66	Cartón	Primera B	1952
70	Cartón	Primera B	1953
74	Cartón	Primera B	1954
132	Liga	cuadrangular	1971
133	Nacional	primera A	1972
135	Liga	cuadrangular	1972
136	Gato	cuadrangular	1972
137	Nacional	primera A	1973
140	Gato	cuadrangular	1973
141	Nacional	primera A	1974
144	Liga	cuadrangular	1974
145	Apertura	primera A	1975
146	Clausura	primera A	1975
148	Nacional	primera A	1976
151	Gato	cuadrangular	1976
152	Apertura	primera A	1977
153	Clausura	primera A	1977
155	Gato	cuadrangular	1977
156	Nacional	primera A	1978
158	Gato	cuadrangular	1978
159	Nacional	primera A	1979
161	Liga	cuadrangular	1979
162	Gato	cuadrangular	1979
163	Nacional	primera A	1980
165	Liga	cuadrangular	1980
166	Nacional	primera A	1981
168	Liga	cuadrangular	1981
169	Gato	cuadrangular	1981
170	Nacional	primera A	1982
172	Liga	cuadrangular	1982
173	Nacional	primera A	1983
175	Liga	cuadrangular	1983
176	Nacional	primera A	1984
179	Nacional	primera A	1985
181	Liga	cuadrangular	1985
182	Gato	cuadrangular	1985
183	Apertura	primera A	1986
184	Clausura	primera A	1986
186	Liga	cuadrangular	1986
187	Nacional	primera A	1987
189	Gato	cuadrangular	1987
190	Apertura	primera A	1988
191	Clausura	primera A	1988
192	Gato	cuadrangular	1988
193	Nacional	primera A	1989
196	Liga	cuadrangular	1989
197	Apertura	primera A	1990
198	Clausura	primera A	1990
201	Nacional	primera A	1991
203	Liga	cuadrangular	1991
204	Apertura	primera A	1992
205	Clausura	primera A	1992
206	Liga	cuadrangular	1992
207	Apertura	primera A	1993
208	Clausura	primera A	1993
210	Liga	cuadrangular	1993
211	Apertura	primera A	1994
212	Clausura	primera A	1994
213	Liga	cuadrangular	1994
214	Apertura	primera A	1995
215	Clausura	primera A	1995
217	Apertura	primera A	1996
218	Clausura	primera A	1996
220	Gato	cuadrangular	1996
221	Nacional	primera A	1997
223	Liga	cuadrangular	1997
224	Apertura	primera A	1998
225	Clausura	primera A	1998
227	Apertura	primera A	1999
228	Clausura	primera A	1999
229	Gato	cuadrangular	1999
230	Nacional	primera A	2000
232	Liga	cuadrangular	2000
233	Apertura	primera A	2001
234	Clausura	primera A	2001
236	Liga	cuadrangular	2001
237	Apertura	primera A	2002
238	Clausura	primera A	2002
239	Gato	cuadrangular	2002
240	Nacional	primera A	2003
243	Liga	cuadrangular	2003
244	Nacional	primera A	2004
245	Liga	cuadrangular	2004
246	Gato	cuadrangular	2004
247	Nacional	primera A	2005
250	Gato	cuadrangular	2005
251	Nacional	primera A	2006
253	Gato	cuadrangular	2006
254	Apertura	primera A	2007
255	Clausura	primera A	2007
257	Nacional	primera A	2008
258	Liga	cuadrangular	2008
259	Gato	cuadrangular	2008
260	Apertura	primera A	2009
131	Cartón	Primera B	1971
139	Cartón	Primera B	1973
143	Cartón	Primera B	1974
147	Cartón	Primera B	1975
150	Cartón	Primera B	1976
157	Cartón	Primera B	1978
164	Cartón	Primera B	1980
167	Cartón	Primera B	1981
174	Cartón	Primera B	1983
178	Cartón	Primera B	1984
188	Cartón	Primera B	1987
195	Cartón	Primera B	1989
200	Cartón	Primera B	1990
202	Cartón	Primera B	1991
209	Cartón	Primera B	1993
216	Cartón	Primera B	1995
219	Cartón	Primera B	1996
222	Cartón	Primera B	1997
261	Clausura	primera A	2009
263	Liga	cuadrangular	2009
264	Nacional	primera A	2010
266	Liga	cuadrangular	2010
267	Gato	cuadrangular	2010
268	Apertura	primera A	2011
269	Clausura	primera A	2011
270	Liga	cuadrangular	2011
271	Nacional	primera A	2012
274	Gato	cuadrangular	2012
275	Apertura	primera A	2013
276	Clausura	primera A	2013
277	Liga	cuadrangular	2013
278	Gato	cuadrangular	2013
279	Apertura	primera A	2014
280	Clausura	primera A	2014
281	Liga	cuadrangular	2014
282	Nacional	primera A	2015
284	Liga	cuadrangular	2015
285	Gato	cuadrangular	2015
286	Apertura	primera A	2016
287	Clausura	primera A	2016
289	Apertura	primera A	2017
290	Clausura	primera A	2017
291	Gato	cuadrangular	2017
292	Nacional	primera A	2018
295	Liga	cuadrangular	2018
296	Nacional	primera A	2019
299	Liga	cuadrangular	2019
300	Apertura	primera A	2020
301	Clausura	primera A	2020
303	Liga	cuadrangular	2020
304	Apertura	primera A	2021
305	Clausura	primera A	2021
306	Liga	cuadrangular	2021
307	Apertura	primera A	2022
308	Clausura	primera A	2022
310	Liga	cuadrangular	2022
311	Apertura	primera A	2023
312	Clausura	primera A	2023
314	Gato	cuadrangular	2023
315	Apertura	primera A	2024
316	Clausura	primera A	2024
318	Gato	cuadrangular	2024
319	Nacional	primera A	2025
322	Gato	cuadrangular	2025
323	Apertura	primera A	2026
324	Clausura	primera A	2026
325	Liga	cuadrangular	2026
326	Gato	cuadrangular	2026
2	Chile	Primera A y B	1933
42	Chile	Primera A y B	1945
52	Chile	Primera A y B	1948
58	Chile	Primera A y B	1950
62	Chile	Primera A y B	1951
69	Chile	Primera A y B	1953
73	Chile	Primera A y B	1954
77	Chile	Primera A y B	1955
88	Chile	Primera A y B	1958
91	Chile	Primera A y B	1959
98	Chile	Primera A y B	1961
117	Chile	Primera A y B	1967
124	Chile	Primera A y B	1969
127	Chile	Primera A y B	1970
134	Chile	Primera A y B	1972
138	Chile	Primera A y B	1973
142	Chile	Primera A y B	1974
149	Chile	Primera A y B	1976
154	Chile	Primera A y B	1977
160	Chile	Primera A y B	1979
171	Chile	Primera A y B	1982
177	Chile	Primera A y B	1984
180	Chile	Primera A y B	1985
185	Chile	Primera A y B	1986
194	Chile	Primera A y B	1989
199	Chile	Primera A y B	1990
226	Chile	Primera A y B	1998
241	Chile	Primera A y B	2003
248	Chile	Primera A y B	2005
256	Chile	Primera A y B	2007
265	Chile	Primera A y B	2010
272	Chile	Primera A y B	2012
288	Chile	Primera A y B	2016
293	Chile	Primera A y B	2018
297	Chile	Primera A y B	2019
309	Chile	Primera A y B	2022
317	Chile	Primera A y B	2024
320	Chile	Primera A y B	2025
80	Cartón	Primera B	1956
84	Cartón	Primera B	1957
89	Cartón	Primera B	1958
92	Cartón	Primera B	1959
95	Cartón	Primera B	1960
99	Cartón	Primera B	1961
102	Cartón	Primera B	1962
111	Cartón	Primera B	1965
114	Cartón	Primera B	1966
118	Cartón	Primera B	1967
122	Cartón	Primera B	1968
128	Cartón	Primera B	1970
231	Cartón	Primera B	2000
235	Cartón	Primera B	2001
242	Cartón	Primera B	2003
249	Cartón	Primera B	2005
252	Cartón	Primera B	2006
262	Cartón	Primera B	2009
273	Cartón	Primera B	2012
283	Cartón	Primera B	2015
294	Cartón	Primera B	2018
298	Cartón	Primera B	2019
302	Cartón	Primera B	2020
313	Cartón	Primera B	2023
321	Cartón	Primera B	2025
327	Nacional	primera A	2027
\.


--
-- TOC entry 3967 (class 0 OID 27840)
-- Dependencies: 224
-- Data for Name: cuerpo_tecnico; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cuerpo_tecnico (rut_pasaporte, id_equipo, rol, partidos_castigados) FROM stdin;
10001899-3	1	Director Técnico	0
10001311-8	1	Asistente Técnico	0
10001890-K	1	Asistente Técnico	0
10001960-4	1	Asistente Técnico	0
10001353-3	1	Médico	0
10001721-0	1	Utilero	0
10001160-3	1	Preparador Físico	0
10001564-1	1	Preparador Físico	0
10001120-4	2	Director Técnico	0
10001141-7	2	Asistente Técnico	0
10001310-K	2	Asistente Técnico	0
10001817-9	2	Asistente Técnico	0
10001477-7	2	Médico	0
10001839-K	2	Utilero	0
10001270-7	2	Preparador Físico	0
10001537-4	2	Preparador Físico	0
10001629-K	2	Preparador Físico	0
10001716-4	3	Director Técnico	0
10001135-2	3	Asistente Técnico	0
10001170-0	3	Asistente Técnico	0
10001990-6	3	Asistente Técnico	0
10001381-9	3	Médico	0
10001988-4	3	Utilero	0
10001189-1	3	Preparador Físico	0
10001295-2	3	Preparador Físico	0
10001945-0	3	Preparador Físico	0
10001110-7	4	Director Técnico	0
10001065-8	4	Asistente Técnico	0
10001259-6	4	Asistente Técnico	0
10001778-4	4	Médico	0
10001789-K	4	Utilero	0
10001522-6	4	Preparador Físico	0
10001936-1	4	Preparador Físico	0
10001876-4	5	Director Técnico	0
10001437-8	5	Asistente Técnico	0
10001712-1	5	Asistente Técnico	0
10001652-4	5	Médico	0
10001521-8	5	Utilero	0
10001574-9	5	Preparador Físico	0
10001889-6	5	Preparador Físico	0
10001697-4	6	Director Técnico	0
10001083-6	6	Asistente Técnico	0
10001448-3	6	Asistente Técnico	0
10001821-7	6	Asistente Técnico	0
10001980-9	6	Médico	0
10001748-2	6	Utilero	0
10001046-1	6	Preparador Físico	0
10001415-7	6	Preparador Físico	0
10001762-8	6	Preparador Físico	0
10001396-7	7	Director Técnico	0
10001380-0	7	Asistente Técnico	0
10001560-9	7	Asistente Técnico	0
10001308-8	7	Médico	0
10001634-6	7	Utilero	0
10001300-2	7	Preparador Físico	0
10001870-5	7	Preparador Físico	0
10001524-2	8	Director Técnico	0
10001213-8	8	Asistente Técnico	0
10001943-4	8	Asistente Técnico	0
10001725-3	8	Médico	0
10001776-8	8	Utilero	0
10001169-7	8	Preparador Físico	0
10001244-8	8	Preparador Físico	0
10001481-5	9	Director Técnico	0
10001181-6	9	Asistente Técnico	0
10001600-1	9	Asistente Técnico	0
10001392-4	9	Médico	0
10001920-5	9	Utilero	0
10001488-2	9	Preparador Físico	0
10001760-1	9	Preparador Físico	0
10001865-9	9	Preparador Físico	0
10001268-5	10	Director Técnico	0
10001422-K	10	Asistente Técnico	0
10001609-5	10	Asistente Técnico	0
10001145-K	10	Médico	0
10001057-7	10	Utilero	0
10001128-K	10	Preparador Físico	0
10001385-1	10	Preparador Físico	0
10001576-5	10	Preparador Físico	0
10001812-8	11	Director Técnico	0
10001761-K	11	Asistente Técnico	0
10001768-7	11	Asistente Técnico	0
10001133-6	11	Médico	0
10001679-6	11	Utilero	0
10001072-0	11	Preparador Físico	0
10001139-5	11	Preparador Físico	0
10001948-5	11	Preparador Físico	0
10001266-9	12	Director Técnico	0
10001265-0	12	Asistente Técnico	0
10001730-K	12	Asistente Técnico	0
10001336-3	12	Médico	0
10001371-1	12	Utilero	0
10001554-4	12	Preparador Físico	0
10001859-4	12	Preparador Físico	0
10001731-8	13	Director Técnico	0
10001129-8	13	Asistente Técnico	0
10001527-7	13	Asistente Técnico	0
10001469-6	13	Médico	0
10001339-8	13	Utilero	0
10001054-2	13	Preparador Físico	0
10001360-6	13	Preparador Físico	0
10001677-K	13	Preparador Físico	0
10001175-1	14	Director Técnico	0
10001149-2	14	Asistente Técnico	0
10001487-4	14	Asistente Técnico	0
10001893-4	14	Asistente Técnico	0
10001686-9	14	Médico	0
10001257-K	14	Utilero	0
10001376-2	14	Preparador Físico	0
10001421-1	14	Preparador Físico	0
10001451-3	14	Preparador Físico	0
10001703-2	15	Director Técnico	0
10001173-5	15	Asistente Técnico	0
10001586-2	15	Asistente Técnico	0
10001127-1	15	Médico	0
10001675-3	15	Utilero	0
10001330-4	15	Preparador Físico	0
10001919-1	15	Preparador Físico	0
10001605-2	16	Director Técnico	0
10001316-9	16	Asistente Técnico	0
10001400-9	16	Asistente Técnico	0
10001970-1	16	Asistente Técnico	0
10001387-8	16	Médico	0
10001312-6	16	Utilero	0
10001198-0	16	Preparador Físico	0
10001271-5	16	Preparador Físico	0
10001445-9	16	Preparador Físico	0
10001852-7	17	Director Técnico	0
10001518-8	17	Asistente Técnico	0
10001902-7	17	Asistente Técnico	0
10001913-2	17	Médico	0
10001465-3	17	Utilero	0
10001505-6	17	Preparador Físico	0
10001555-2	17	Preparador Físico	0
10001888-8	18	Director Técnico	0
10001288-K	18	Asistente Técnico	0
10001377-0	18	Asistente Técnico	0
10001903-5	18	Asistente Técnico	0
10001153-0	18	Médico	0
10001798-9	18	Utilero	0
10001715-6	18	Preparador Físico	0
10001803-9	18	Preparador Físico	0
10001457-2	19	Director Técnico	0
10001886-1	19	Asistente Técnico	0
10001946-9	19	Asistente Técnico	0
10001221-9	19	Médico	0
10001944-2	19	Utilero	0
10001165-4	19	Preparador Físico	0
10001203-0	19	Preparador Físico	0
10001723-7	20	Director Técnico	0
10001254-5	20	Asistente Técnico	0
10001676-1	20	Asistente Técnico	0
10001714-8	20	Asistente Técnico	0
10001665-6	20	Médico	0
10001276-6	20	Utilero	0
10001654-0	20	Preparador Físico	0
10001915-9	20	Preparador Físico	0
10001526-9	21	Director Técnico	0
10001313-4	21	Asistente Técnico	2
10001691-5	21	Asistente Técnico	0
10001126-3	21	Médico	0
10001199-9	21	Utilero	0
10001441-6	21	Preparador Físico	0
10001520-K	21	Preparador Físico	0
10001828-4	21	Preparador Físico	0
10001226-K	22	Director Técnico	0
10001205-7	22	Asistente Técnico	0
10001744-K	22	Asistente Técnico	0
10001824-1	22	Asistente Técnico	0
10001197-2	22	Médico	0
10001044-5	22	Utilero	0
10001074-7	22	Preparador Físico	0
10001235-9	22	Preparador Físico	0
10001872-1	23	Director Técnico	0
10001545-5	23	Asistente Técnico	0
10001791-1	23	Asistente Técnico	0
10001297-9	23	Médico	0
10001743-1	23	Utilero	0
10001131-K	23	Preparador Físico	0
10001237-5	23	Preparador Físico	0
10001506-4	23	Preparador Físico	0
10001239-1	24	Director Técnico	0
10001078-K	24	Asistente Técnico	0
10001102-6	24	Asistente Técnico	0
10001307-K	24	Asistente Técnico	0
10001281-2	24	Médico	0
10001428-9	24	Utilero	0
10001327-4	24	Preparador Físico	0
10001627-3	24	Preparador Físico	0
10001640-0	25	Director Técnico	2
10001041-0	25	Asistente Técnico	0
10001573-0	25	Asistente Técnico	0
10001284-7	25	Médico	0
10001569-2	25	Utilero	0
10001296-0	25	Preparador Físico	0
10001309-6	25	Preparador Físico	0
10001871-3	25	Preparador Físico	0
10001177-8	26	Director Técnico	0
10001062-3	26	Asistente Técnico	0
10001151-4	26	Asistente Técnico	0
10001993-0	26	Médico	0
10001981-7	26	Utilero	0
10001140-9	26	Preparador Físico	0
10001269-3	26	Preparador Físico	0
10001749-0	26	Preparador Físico	0
10001835-7	27	Director Técnico	0
10001114-K	27	Asistente Técnico	0
10001272-3	27	Asistente Técnico	0
10001949-3	27	Asistente Técnico	0
10001540-4	27	Médico	0
10001328-2	27	Utilero	0
10001708-3	27	Preparador Físico	0
10001978-7	27	Preparador Físico	0
10001690-7	28	Director Técnico	0
10001193-K	28	Asistente Técnico	0
10001372-K	28	Asistente Técnico	0
10001511-0	28	Asistente Técnico	0
10001334-7	28	Médico	0
10001667-2	28	Utilero	0
10001366-5	28	Preparador Físico	0
10001646-K	28	Preparador Físico	0
10001166-2	29	Director Técnico	0
10001050-K	29	Asistente Técnico	0
10001971-K	29	Asistente Técnico	0
10001224-3	29	Médico	0
10001512-9	29	Utilero	0
10001565-K	29	Preparador Físico	0
10001786-5	29	Preparador Físico	0
10001880-2	29	Preparador Físico	0
10001653-2	30	Director Técnico	0
10001608-7	30	Asistente Técnico	0
10001673-7	30	Asistente Técnico	0
10001811-K	30	Asistente Técnico	0
10001984-1	30	Médico	0
10001461-0	30	Utilero	0
10001620-6	30	Preparador Físico	0
10001822-5	30	Preparador Físico	0
10001910-8	30	Preparador Físico	0
10001779-2	31	Director Técnico	0
10001455-6	31	Asistente Técnico	0
10001793-8	31	Asistente Técnico	0
10001412-2	31	Médico	0
10001502-1	31	Utilero	0
10001108-5	31	Preparador Físico	0
10001395-9	31	Preparador Físico	0
10001973-6	32	Director Técnico	0
10001434-3	32	Asistente Técnico	0
10001746-6	32	Asistente Técnico	0
10001823-3	32	Asistente Técnico	0
10001541-2	32	Médico	0
10001292-8	32	Utilero	0
10001404-1	32	Preparador Físico	0
10001534-K	32	Preparador Físico	0
10001965-5	32	Preparador Físico	0
10001666-4	33	Director Técnico	0
10001178-6	33	Asistente Técnico	0
10001185-9	33	Asistente Técnico	0
10001290-1	33	Médico	0
10001355-K	33	Utilero	0
10001561-7	33	Preparador Físico	0
10001751-2	33	Preparador Físico	0
10001777-6	34	Director Técnico	0
10001089-5	34	Asistente Técnico	0
10001486-6	34	Asistente Técnico	0
10001972-8	34	Médico	0
10001770-9	34	Utilero	0
10001121-2	34	Preparador Físico	0
10001752-0	34	Preparador Físico	0
10001807-1	35	Director Técnico	0
10001056-9	35	Asistente Técnico	0
10001498-K	35	Asistente Técnico	0
10001683-4	35	Asistente Técnico	0
10001223-5	35	Médico	0
10001722-9	35	Utilero	0
10001280-4	35	Preparador Físico	0
10001413-0	35	Preparador Físico	0
10001969-8	36	Director Técnico	0
10001228-6	36	Asistente Técnico	0
10001480-7	36	Asistente Técnico	0
10001953-1	36	Asistente Técnico	0
10001995-7	36	Médico	0
10001632-K	36	Utilero	0
10001096-8	36	Preparador Físico	0
10001932-9	36	Preparador Físico	0
10001950-7	36	Preparador Físico	0
10001431-9	37	Director Técnico	0
10001479-3	37	Asistente Técnico	0
10001693-1	37	Asistente Técnico	0
10001429-7	37	Médico	0
10001388-6	37	Utilero	0
10001867-5	37	Preparador Físico	0
10001966-3	37	Preparador Físico	0
10001192-1	38	Director Técnico	0
10001847-0	38	Asistente Técnico	0
10001908-6	38	Asistente Técnico	0
10001961-2	38	Asistente Técnico	0
10001242-1	38	Médico	0
10001069-0	38	Utilero	0
10001207-3	38	Preparador Físico	0
10001250-2	38	Preparador Físico	0
10001618-4	39	Director Técnico	0
10001081-K	39	Asistente Técnico	0
10001118-2	39	Asistente Técnico	0
10001379-7	39	Médico	0
10001251-0	39	Utilero	0
10001602-8	39	Preparador Físico	0
10001619-2	39	Preparador Físico	0
10001854-3	39	Preparador Físico	0
10001338-K	40	Director Técnico	0
10001115-8	40	Asistente Técnico	0
10001439-4	40	Asistente Técnico	0
10001974-4	40	Médico	0
10001633-8	40	Utilero	0
10001394-0	40	Preparador Físico	0
10001901-9	40	Preparador Físico	0
\.


--
-- TOC entry 3976 (class 0 OID 27960)
-- Dependencies: 233
-- Data for Name: designacion_arbitro; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.designacion_arbitro (id_partido, rut_pasaporte, funcion, fecha_designacion) FROM stdin;
1	10001017-8	Árbitro Principal	2027-01-31
1	10001107-7	Juez de Línea	2027-01-31
1	10001934-5	Juez de Línea	2027-01-31
1	10001410-6	Árbitro Asistente	2027-01-31
1	10001035-6	VAR	2027-01-31
2	10001399-1	Árbitro Principal	2027-01-30
2	10001030-5	Juez de Línea	2027-01-30
2	10001809-8	Juez de Línea	2027-01-30
2	10001347-9	Árbitro Asistente	2027-01-30
2	10001101-8	VAR	2027-01-30
3	10001931-0	Árbitro Principal	2027-01-29
3	10001143-3	Juez de Línea	2027-01-29
3	10001370-3	Juez de Línea	2027-01-29
3	10001525-0	Árbitro Asistente	2027-01-29
3	10001864-0	VAR	2027-01-29
4	10001337-1	Árbitro Principal	2027-01-31
4	10001073-9	Juez de Línea	2027-01-31
4	10001612-5	Juez de Línea	2027-01-31
4	10001615-K	Árbitro Asistente	2027-01-31
4	10001111-5	VAR	2027-01-31
5	10001873-K	Árbitro Principal	2027-01-31
5	10001157-3	Juez de Línea	2027-01-31
5	10001610-9	Juez de Línea	2027-01-31
5	10001060-7	Árbitro Asistente	2027-01-31
5	10001655-9	VAR	2027-01-31
6	10001063-1	Árbitro Principal	2027-01-30
6	10001535-8	Juez de Línea	2027-01-30
6	10001801-2	Juez de Línea	2027-01-30
6	10001788-1	Árbitro Asistente	2027-01-30
6	10001596-K	VAR	2027-01-30
7	10001051-8	Árbitro Principal	2027-01-29
7	10001241-3	Juez de Línea	2027-01-29
7	10001678-8	Juez de Línea	2027-01-29
7	10001104-2	Árbitro Asistente	2027-01-29
7	10001773-3	VAR	2027-01-29
8	10001094-1	Árbitro Principal	2027-01-30
8	10001084-4	Juez de Línea	2027-01-30
8	10001682-6	Juez de Línea	2027-01-30
8	10001375-4	Árbitro Asistente	2027-01-30
8	10001411-4	VAR	2027-01-30
9	10001557-9	Árbitro Principal	2027-01-31
9	10001045-3	Juez de Línea	2027-01-31
9	10001700-8	Juez de Línea	2027-01-31
9	10001850-0	Árbitro Asistente	2027-01-31
9	10001959-0	VAR	2027-01-31
10	10001236-7	Árbitro Principal	2027-01-30
10	10001091-7	Juez de Línea	2027-01-30
10	10001651-6	Juez de Línea	2027-01-30
10	10001473-4	Árbitro Asistente	2027-01-30
10	10001736-9	VAR	2027-01-30
11	10001104-2	Árbitro Principal	2027-02-07
11	10001091-7	Juez de Línea	2027-02-07
11	10001773-3	Juez de Línea	2027-02-07
11	10001931-0	Árbitro Asistente	2027-02-07
11	10001801-2	VAR	2027-02-07
12	10001682-6	Árbitro Principal	2027-02-07
12	10001060-7	Juez de Línea	2027-02-07
12	10001101-8	Juez de Línea	2027-02-07
12	10001736-9	Árbitro Asistente	2027-02-07
12	10001236-7	VAR	2027-02-07
13	10001819-5	Árbitro Principal	2027-02-06
13	10001460-2	Juez de Línea	2027-02-06
13	10001529-3	Juez de Línea	2027-02-06
13	10001610-9	Árbitro Asistente	2027-02-06
13	10001612-5	VAR	2027-02-06
14	10001615-K	Árbitro Principal	2027-02-05
14	10001375-4	Juez de Línea	2027-02-05
14	10001959-0	Juez de Línea	2027-02-05
14	10001111-5	Árbitro Asistente	2027-02-05
14	10001283-9	VAR	2027-02-05
15	10001535-8	Árbitro Principal	2027-02-05
15	10001094-1	Juez de Línea	2027-02-05
15	10001552-8	Juez de Línea	2027-02-05
15	10001273-1	Árbitro Asistente	2027-02-05
15	10001073-9	VAR	2027-02-05
16	10001035-6	Árbitro Principal	2027-02-07
16	10001143-3	Juez de Línea	2027-02-07
16	10001241-3	Juez de Línea	2027-02-07
16	10001407-6	Árbitro Asistente	2027-02-07
16	10001157-3	VAR	2027-02-07
17	10001337-1	Árbitro Principal	2027-02-07
17	10001410-6	Juez de Línea	2027-02-07
17	10001977-9	Juez de Línea	2027-02-07
17	10001391-6	Árbitro Asistente	2027-02-07
17	10001557-9	VAR	2027-02-07
18	10001647-8	Árbitro Principal	2027-02-06
18	10001389-4	Juez de Línea	2027-02-06
18	10001525-0	Juez de Línea	2027-02-06
18	10001702-4	Árbitro Asistente	2027-02-06
18	10001700-8	VAR	2027-02-06
19	10001045-3	Árbitro Principal	2027-02-06
19	10001051-8	Juez de Línea	2027-02-06
19	10001783-0	Juez de Línea	2027-02-06
19	10001678-8	Árbitro Asistente	2027-02-06
19	10001864-0	VAR	2027-02-06
20	10001347-9	Árbitro Principal	2027-02-06
20	10001706-7	Juez de Línea	2027-02-06
20	10001892-6	Juez de Línea	2027-02-06
20	10001809-8	Árbitro Asistente	2027-02-06
20	10001298-7	VAR	2027-02-06
21	10001391-6	Árbitro Principal	2027-02-12
21	10001525-0	Juez de Línea	2027-02-12
21	10001942-6	Juez de Línea	2027-02-12
21	10001809-8	Árbitro Asistente	2027-02-12
21	10001635-4	VAR	2027-02-12
22	10001411-4	Árbitro Principal	2027-02-14
22	10001273-1	Juez de Línea	2027-02-14
22	10001362-2	Juez de Línea	2027-02-14
22	10001241-3	Árbitro Asistente	2027-02-14
22	10001638-9	VAR	2027-02-14
23	10001801-2	Árbitro Principal	2027-02-14
23	10001094-1	Juez de Línea	2027-02-14
23	10001111-5	Juez de Línea	2027-02-14
23	10001084-4	Árbitro Asistente	2027-02-14
23	10001073-9	VAR	2027-02-14
24	10001375-4	Árbitro Principal	2027-02-13
24	10001143-3	Juez de Línea	2027-02-13
24	10001934-5	Juez de Línea	2027-02-13
24	10001060-7	Árbitro Asistente	2027-02-13
24	10001104-2	VAR	2027-02-13
25	10001975-2	Árbitro Principal	2027-02-13
25	10001347-9	Juez de Línea	2027-02-13
25	10001788-1	Juez de Línea	2027-02-13
25	10001529-3	Árbitro Asistente	2027-02-13
25	10001091-7	VAR	2027-02-13
26	10001655-9	Árbitro Principal	2027-02-14
26	10001017-8	Juez de Línea	2027-02-14
26	10001909-4	Juez de Línea	2027-02-14
26	10001460-2	Árbitro Asistente	2027-02-14
26	10001700-8	VAR	2027-02-14
27	10001407-6	Árbitro Principal	2027-02-12
27	10001157-3	Juez de Línea	2027-02-12
27	10001783-0	Juez de Línea	2027-02-12
27	10001535-8	Árbitro Asistente	2027-02-12
27	10001873-K	VAR	2027-02-12
28	10001298-7	Árbitro Principal	2027-02-14
28	10001283-9	Juez de Línea	2027-02-14
28	10001399-1	Juez de Línea	2027-02-14
28	10001773-3	Árbitro Asistente	2027-02-14
28	10001849-7	VAR	2027-02-14
29	10001030-5	Árbitro Principal	2027-02-13
29	10001107-7	Juez de Línea	2027-02-13
29	10001610-9	Juez de Línea	2027-02-13
29	10001051-8	Árbitro Asistente	2027-02-13
29	10001045-3	VAR	2027-02-13
30	10001557-9	Árbitro Principal	2027-02-13
30	10001410-6	Juez de Línea	2027-02-13
30	10001959-0	Juez de Línea	2027-02-13
30	10001701-6	Árbitro Asistente	2027-02-13
30	10001892-6	VAR	2027-02-13
31	10001473-4	Árbitro Principal	2027-02-28
31	10001030-5	Juez de Línea	2027-02-28
31	10001615-K	Juez de Línea	2027-02-28
31	10001773-3	Árbitro Asistente	2027-02-28
31	10001091-7	VAR	2027-02-28
32	10001788-1	Árbitro Principal	2027-02-27
32	10001682-6	Juez de Línea	2027-02-27
32	10001783-0	Juez de Línea	2027-02-27
32	10001410-6	Árbitro Asistente	2027-02-27
32	10001399-1	VAR	2027-02-27
33	10001736-9	Árbitro Principal	2027-02-28
33	10001143-3	Juez de Línea	2027-02-28
33	10001157-3	Juez de Línea	2027-02-28
33	10001624-9	Árbitro Asistente	2027-02-28
33	10001283-9	VAR	2027-02-28
34	10001700-8	Árbitro Principal	2027-02-28
34	10001529-3	Juez de Línea	2027-02-28
34	10001849-7	Juez de Línea	2027-02-28
34	10001892-6	Árbitro Asistente	2027-02-28
34	10001367-3	VAR	2027-02-28
35	10001706-7	Árbitro Principal	2027-02-27
35	10001073-9	Juez de Línea	2027-02-27
35	10001298-7	Juez de Línea	2027-02-27
35	10001635-4	Árbitro Asistente	2027-02-27
35	10001273-1	VAR	2027-02-27
36	10001655-9	Árbitro Principal	2027-02-26
36	10001051-8	Juez de Línea	2027-02-26
36	10001651-6	Juez de Línea	2027-02-26
36	10001924-8	Árbitro Asistente	2027-02-26
36	10001864-0	VAR	2027-02-26
37	10001801-2	Árbitro Principal	2027-02-27
37	10001407-6	Juez de Línea	2027-02-27
37	10001931-0	Juez de Línea	2027-02-27
37	10001017-8	Árbitro Asistente	2027-02-27
37	10001909-4	VAR	2027-02-27
38	10001977-9	Árbitro Principal	2027-02-26
38	10001337-1	Juez de Línea	2027-02-26
38	10001358-4	Juez de Línea	2027-02-26
38	10001035-6	Árbitro Asistente	2027-02-26
38	10001873-K	VAR	2027-02-26
39	10001538-2	Árbitro Principal	2027-02-28
39	10001063-1	Juez de Línea	2027-02-28
39	10001370-3	Juez de Línea	2027-02-28
39	10001060-7	Árbitro Asistente	2027-02-28
39	10001389-4	VAR	2027-02-28
40	10001975-2	Árbitro Principal	2027-02-27
40	10001111-5	Juez de Línea	2027-02-27
40	10001638-9	Juez de Línea	2027-02-27
40	10001236-7	Árbitro Asistente	2027-02-27
40	10001959-0	VAR	2027-02-27
41	10001410-6	Árbitro Principal	2027-03-07
41	10001073-9	Juez de Línea	2027-03-07
41	10001375-4	Juez de Línea	2027-03-07
41	10001977-9	Árbitro Asistente	2027-03-07
41	10001063-1	VAR	2027-03-07
42	10001030-5	Árbitro Principal	2027-03-06
42	10001389-4	Juez de Línea	2027-03-06
42	10001736-9	Juez de Línea	2027-03-06
42	10001273-1	Árbitro Asistente	2027-03-06
42	10001362-2	VAR	2027-03-06
43	10001370-3	Árbitro Principal	2027-03-05
43	10001035-6	Juez de Línea	2027-03-05
43	10001538-2	Juez de Línea	2027-03-05
43	10001773-3	Árbitro Asistente	2027-03-05
43	10001864-0	VAR	2027-03-05
44	10001924-8	Árbitro Principal	2027-03-06
44	10001850-0	Juez de Línea	2027-03-06
44	10001909-4	Juez de Línea	2027-03-06
44	10001931-0	Árbitro Asistente	2027-03-06
44	10001283-9	VAR	2027-03-06
45	10001783-0	Árbitro Principal	2027-03-07
45	10001017-8	Juez de Línea	2027-03-07
45	10001367-3	Juez de Línea	2027-03-07
45	10001610-9	Árbitro Asistente	2027-03-07
45	10001535-8	VAR	2027-03-07
46	10001091-7	Árbitro Principal	2027-03-06
46	10001241-3	Juez de Línea	2027-03-06
46	10001700-8	Juez de Línea	2027-03-06
46	10001596-K	Árbitro Asistente	2027-03-06
46	10001959-0	VAR	2027-03-06
47	10001942-6	Árbitro Principal	2027-03-07
47	10001525-0	Juez de Línea	2027-03-07
47	10001801-2	Juez de Línea	2027-03-07
47	10001873-K	Árbitro Asistente	2027-03-07
47	10001111-5	VAR	2027-03-07
48	10001954-K	Árbitro Principal	2027-03-06
48	10001060-7	Juez de Línea	2027-03-06
48	10001809-8	Juez de Línea	2027-03-06
48	10001407-6	Árbitro Asistente	2027-03-06
48	10001473-4	VAR	2027-03-06
49	10001399-1	Árbitro Principal	2027-03-05
49	10001682-6	Juez de Línea	2027-03-05
49	10001849-7	Juez de Línea	2027-03-05
49	10001104-2	Árbitro Asistente	2027-03-05
49	10001819-5	VAR	2027-03-05
50	10001678-8	Árbitro Principal	2027-03-07
50	10001391-6	Juez de Línea	2027-03-07
50	10001557-9	Juez de Línea	2027-03-07
50	10001347-9	Árbitro Asistente	2027-03-07
50	10001612-5	VAR	2027-03-07
51	10001407-6	Árbitro Principal	2027-03-12
51	10001073-9	Juez de Línea	2027-03-12
51	10001410-6	Juez de Línea	2027-03-12
51	10001655-9	Árbitro Asistente	2027-03-12
51	10001924-8	VAR	2027-03-12
52	10001596-K	Árbitro Principal	2027-03-14
52	10001084-4	Juez de Línea	2027-03-14
52	10001809-8	Juez de Línea	2027-03-14
52	10001063-1	Árbitro Asistente	2027-03-14
52	10001892-6	VAR	2027-03-14
53	10001682-6	Árbitro Principal	2027-03-13
53	10001091-7	Juez de Línea	2027-03-13
53	10001298-7	Juez de Línea	2027-03-13
53	10001101-8	Árbitro Asistente	2027-03-13
53	10001473-4	VAR	2027-03-13
54	10001030-5	Árbitro Principal	2027-03-13
54	10001094-1	Juez de Línea	2027-03-13
54	10001283-9	Juez de Línea	2027-03-13
54	10001525-0	Árbitro Asistente	2027-03-13
54	10001909-4	VAR	2027-03-13
55	10001819-5	Árbitro Principal	2027-03-13
55	10001615-K	Juez de Línea	2027-03-13
55	10001706-7	Juez de Línea	2027-03-13
55	10001942-6	Árbitro Asistente	2027-03-13
55	10001111-5	VAR	2027-03-13
56	10001375-4	Árbitro Principal	2027-03-14
56	10001060-7	Juez de Línea	2027-03-14
56	10001959-0	Juez de Línea	2027-03-14
56	10001975-2	Árbitro Asistente	2027-03-14
56	10001773-3	VAR	2027-03-14
57	10001783-0	Árbitro Principal	2027-03-13
57	10001347-9	Juez de Línea	2027-03-13
57	10001954-K	Juez de Línea	2027-03-13
57	10001651-6	Árbitro Asistente	2027-03-13
57	10001035-6	VAR	2027-03-13
58	10001635-4	Árbitro Principal	2027-03-14
58	10001801-2	Juez de Línea	2027-03-14
58	10001850-0	Juez de Línea	2027-03-14
58	10001017-8	Árbitro Asistente	2027-03-14
58	10001552-8	VAR	2027-03-14
59	10001362-2	Árbitro Principal	2027-03-12
59	10001358-4	Juez de Línea	2027-03-12
59	10001678-8	Juez de Línea	2027-03-12
59	10001931-0	Árbitro Asistente	2027-03-12
59	10001399-1	VAR	2027-03-12
60	10001700-8	Árbitro Principal	2027-03-14
60	10001337-1	Juez de Línea	2027-03-14
60	10001535-8	Juez de Línea	2027-03-14
60	10001104-2	Árbitro Asistente	2027-03-14
60	10001647-8	VAR	2027-03-14
61	10001410-6	Árbitro Principal	2027-03-21
61	10001298-7	Juez de Línea	2027-03-21
61	10001942-6	Juez de Línea	2027-03-21
61	10001273-1	Árbitro Asistente	2027-03-21
61	10001682-6	VAR	2027-03-21
62	10001375-4	Árbitro Principal	2027-03-21
62	10001706-7	Juez de Línea	2027-03-21
62	10001773-3	Juez de Línea	2027-03-21
62	10001051-8	Árbitro Asistente	2027-03-21
62	10001084-4	VAR	2027-03-21
63	10001030-5	Árbitro Principal	2027-03-19
63	10001535-8	Juez de Línea	2027-03-19
63	10001557-9	Juez de Línea	2027-03-19
63	10001552-8	Árbitro Asistente	2027-03-19
63	10001473-4	VAR	2027-03-19
64	10001073-9	Árbitro Principal	2027-03-21
64	10001241-3	Juez de Línea	2027-03-21
64	10001849-7	Juez de Línea	2027-03-21
64	10001529-3	Árbitro Asistente	2027-03-21
64	10001236-7	VAR	2027-03-21
65	10001701-6	Árbitro Principal	2027-03-21
65	10001864-0	Juez de Línea	2027-03-21
65	10001959-0	Juez de Línea	2027-03-21
65	10001101-8	Árbitro Asistente	2027-03-21
65	10001610-9	VAR	2027-03-21
66	10001111-5	Árbitro Principal	2027-03-20
66	10001389-4	Juez de Línea	2027-03-20
66	10001411-4	Juez de Línea	2027-03-20
66	10001615-K	Árbitro Asistente	2027-03-20
66	10001538-2	VAR	2027-03-20
67	10001337-1	Árbitro Principal	2027-03-19
67	10001060-7	Juez de Línea	2027-03-19
67	10001638-9	Juez de Línea	2027-03-19
67	10001736-9	Árbitro Asistente	2027-03-19
67	10001045-3	VAR	2027-03-19
68	10001700-8	Árbitro Principal	2027-03-20
68	10001091-7	Juez de Línea	2027-03-20
68	10001801-2	Juez de Línea	2027-03-20
68	10001934-5	Árbitro Asistente	2027-03-20
68	10001954-K	VAR	2027-03-20
69	10001924-8	Árbitro Principal	2027-03-20
69	10001035-6	Juez de Línea	2027-03-20
69	10001157-3	Juez de Línea	2027-03-20
69	10001624-9	Árbitro Asistente	2027-03-20
69	10001635-4	VAR	2027-03-20
70	10001702-4	Árbitro Principal	2027-03-20
70	10001358-4	Juez de Línea	2027-03-20
70	10001873-K	Juez de Línea	2027-03-20
70	10001819-5	Árbitro Asistente	2027-03-20
70	10001655-9	VAR	2027-03-20
71	10001389-4	Árbitro Principal	2027-03-26
71	10001283-9	Juez de Línea	2027-03-26
71	10001651-6	Juez de Línea	2027-03-26
71	10001635-4	Árbitro Asistente	2027-03-26
71	10001624-9	VAR	2027-03-26
72	10001942-6	Árbitro Principal	2027-03-28
72	10001367-3	Juez de Línea	2027-03-28
72	10001535-8	Juez de Línea	2027-03-28
72	10001298-7	Árbitro Asistente	2027-03-28
72	10001017-8	VAR	2027-03-28
73	10001101-8	Árbitro Principal	2027-03-27
73	10001411-4	Juez de Línea	2027-03-27
73	10001977-9	Juez de Línea	2027-03-27
73	10001655-9	Árbitro Asistente	2027-03-27
73	10001909-4	VAR	2027-03-27
74	10001063-1	Árbitro Principal	2027-03-28
74	10001337-1	Juez de Línea	2027-03-28
74	10001801-2	Juez de Línea	2027-03-28
74	10001529-3	Árbitro Asistente	2027-03-28
74	10001375-4	VAR	2027-03-28
75	10001473-4	Árbitro Principal	2027-03-27
75	10001370-3	Juez de Línea	2027-03-27
75	10001538-2	Juez de Línea	2027-03-27
75	10001104-2	Árbitro Asistente	2027-03-27
75	10001736-9	VAR	2027-03-27
76	10001391-6	Árbitro Principal	2027-03-28
76	10001143-3	Juez de Línea	2027-03-28
76	10001773-3	Juez de Línea	2027-03-28
76	10001035-6	Árbitro Asistente	2027-03-28
76	10001682-6	VAR	2027-03-28
77	10001596-K	Árbitro Principal	2027-03-27
77	10001702-4	Juez de Línea	2027-03-27
77	10001931-0	Juez de Línea	2027-03-27
77	10001094-1	Árbitro Asistente	2027-03-27
77	10001557-9	VAR	2027-03-27
78	10001157-3	Árbitro Principal	2027-03-28
78	10001111-5	Juez de Línea	2027-03-28
78	10001460-2	Juez de Línea	2027-03-28
78	10001959-0	Árbitro Asistente	2027-03-28
78	10001788-1	VAR	2027-03-28
79	10001084-4	Árbitro Principal	2027-03-27
79	10001700-8	Juez de Línea	2027-03-27
79	10001809-8	Juez de Línea	2027-03-27
79	10001051-8	Árbitro Asistente	2027-03-27
79	10001407-6	VAR	2027-03-27
80	10001819-5	Árbitro Principal	2027-03-26
80	10001647-8	Juez de Línea	2027-03-26
80	10001934-5	Juez de Línea	2027-03-26
80	10001954-K	Árbitro Asistente	2027-03-26
80	10001060-7	VAR	2027-03-26
81	10001975-2	Árbitro Principal	2027-04-03
81	10001367-3	Juez de Línea	2027-04-03
81	10001864-0	Juez de Línea	2027-04-03
81	10001557-9	Árbitro Asistente	2027-04-03
81	10001157-3	VAR	2027-04-03
82	10001073-9	Árbitro Principal	2027-04-03
82	10001094-1	Juez de Línea	2027-04-03
82	10001143-3	Juez de Línea	2027-04-03
82	10001934-5	Árbitro Asistente	2027-04-03
82	10001647-8	VAR	2027-04-03
83	10001051-8	Árbitro Principal	2027-04-04
83	10001283-9	Juez de Línea	2027-04-04
83	10001678-8	Juez de Línea	2027-04-04
83	10001700-8	Árbitro Asistente	2027-04-04
83	10001682-6	VAR	2027-04-04
84	10001801-2	Árbitro Principal	2027-04-04
84	10001783-0	Juez de Línea	2027-04-04
84	10001959-0	Juez de Línea	2027-04-04
84	10001411-4	Árbitro Asistente	2027-04-04
84	10001610-9	VAR	2027-04-04
85	10001017-8	Árbitro Principal	2027-04-03
85	10001612-5	Juez de Línea	2027-04-03
85	10001736-9	Juez de Línea	2027-04-03
85	10001538-2	Árbitro Asistente	2027-04-03
85	10001850-0	VAR	2027-04-03
86	10001615-K	Árbitro Principal	2027-04-03
86	10001111-5	Juez de Línea	2027-04-03
86	10001473-4	Juez de Línea	2027-04-03
86	10001298-7	Árbitro Asistente	2027-04-03
86	10001596-K	VAR	2027-04-03
87	10001030-5	Árbitro Principal	2027-04-02
87	10001084-4	Juez de Línea	2027-04-02
87	10001924-8	Juez de Línea	2027-04-02
87	10001362-2	Árbitro Asistente	2027-04-02
87	10001389-4	VAR	2027-04-02
88	10001525-0	Árbitro Principal	2027-04-04
88	10001273-1	Juez de Línea	2027-04-04
88	10001701-6	Juez de Línea	2027-04-04
88	10001358-4	Árbitro Asistente	2027-04-04
88	10001931-0	VAR	2027-04-04
89	10001375-4	Árbitro Principal	2027-04-04
89	10001091-7	Juez de Línea	2027-04-04
89	10001809-8	Juez de Línea	2027-04-04
89	10001347-9	Árbitro Asistente	2027-04-04
89	10001104-2	VAR	2027-04-04
90	10001635-4	Árbitro Principal	2027-04-02
90	10001399-1	Juez de Línea	2027-04-02
90	10001638-9	Juez de Línea	2027-04-02
90	10001909-4	Árbitro Asistente	2027-04-02
90	10001337-1	VAR	2027-04-02
91	10001596-K	Árbitro Principal	2027-04-11
91	10001624-9	Juez de Línea	2027-04-11
91	10001959-0	Juez de Línea	2027-04-11
91	10001809-8	Árbitro Asistente	2027-04-11
91	10001375-4	VAR	2027-04-11
92	10001337-1	Árbitro Principal	2027-04-09
92	10001647-8	Juez de Línea	2027-04-09
92	10001873-K	Juez de Línea	2027-04-09
92	10001801-2	Árbitro Asistente	2027-04-09
92	10001612-5	VAR	2027-04-09
93	10001535-8	Árbitro Principal	2027-04-10
93	10001529-3	Juez de Línea	2027-04-10
93	10001977-9	Juez de Línea	2027-04-10
93	10001934-5	Árbitro Asistente	2027-04-10
93	10001051-8	VAR	2027-04-10
94	10001060-7	Árbitro Principal	2027-04-10
94	10001017-8	Juez de Línea	2027-04-10
94	10001045-3	Juez de Línea	2027-04-10
94	10001273-1	Árbitro Asistente	2027-04-10
94	10001819-5	VAR	2027-04-10
95	10001700-8	Árbitro Principal	2027-04-11
95	10001073-9	Juez de Línea	2027-04-11
95	10001849-7	Juez de Línea	2027-04-11
95	10001407-6	Árbitro Asistente	2027-04-11
95	10001298-7	VAR	2027-04-11
96	10001143-3	Árbitro Principal	2027-04-09
96	10001367-3	Juez de Línea	2027-04-09
96	10001399-1	Juez de Línea	2027-04-09
96	10001473-4	Árbitro Asistente	2027-04-09
96	10001283-9	VAR	2027-04-09
97	10001111-5	Árbitro Principal	2027-04-10
97	10001358-4	Juez de Línea	2027-04-10
97	10001615-K	Juez de Línea	2027-04-10
97	10001635-4	Árbitro Asistente	2027-04-10
97	10001101-8	VAR	2027-04-10
98	10001942-6	Árbitro Principal	2027-04-10
98	10001391-6	Juez de Línea	2027-04-10
98	10001552-8	Juez de Línea	2027-04-10
98	10001702-4	Árbitro Asistente	2027-04-10
98	10001678-8	VAR	2027-04-10
99	10001954-K	Árbitro Principal	2027-04-11
99	10001091-7	Juez de Línea	2027-04-11
99	10001157-3	Juez de Línea	2027-04-11
99	10001362-2	Árbitro Asistente	2027-04-11
99	10001035-6	VAR	2027-04-11
100	10001370-3	Árbitro Principal	2027-04-11
100	10001850-0	Juez de Línea	2027-04-11
100	10001931-0	Juez de Línea	2027-04-11
100	10001788-1	Árbitro Asistente	2027-04-11
100	10001638-9	VAR	2027-04-11
101	10001596-K	Árbitro Principal	2027-04-16
101	10001030-5	Juez de Línea	2027-04-16
101	10001236-7	Juez de Línea	2027-04-16
101	10001977-9	Árbitro Asistente	2027-04-16
101	10001909-4	VAR	2027-04-16
102	10001051-8	Árbitro Principal	2027-04-16
102	10001017-8	Juez de Línea	2027-04-16
102	10001529-3	Juez de Línea	2027-04-16
102	10001682-6	Árbitro Asistente	2027-04-16
102	10001073-9	VAR	2027-04-16
103	10001557-9	Árbitro Principal	2027-04-18
103	10001389-4	Juez de Línea	2027-04-18
103	10001788-1	Juez de Línea	2027-04-18
103	10001954-K	Árbitro Asistente	2027-04-18
103	10001535-8	VAR	2027-04-18
104	10001367-3	Árbitro Principal	2027-04-18
104	10001241-3	Juez de Línea	2027-04-18
104	10001473-4	Juez de Línea	2027-04-18
104	10001638-9	Árbitro Asistente	2027-04-18
104	10001864-0	VAR	2027-04-18
105	10001931-0	Árbitro Principal	2027-04-17
105	10001612-5	Juez de Línea	2027-04-17
105	10001773-3	Juez de Línea	2027-04-17
105	10001892-6	Árbitro Asistente	2027-04-17
105	10001107-7	VAR	2027-04-17
106	10001084-4	Árbitro Principal	2027-04-18
106	10001358-4	Juez de Línea	2027-04-18
106	10001701-6	Juez de Línea	2027-04-18
106	10001410-6	Árbitro Asistente	2027-04-18
106	10001819-5	VAR	2027-04-18
107	10001700-8	Árbitro Principal	2027-04-17
107	10001094-1	Juez de Línea	2027-04-17
107	10001801-2	Juez de Línea	2027-04-17
107	10001975-2	Árbitro Asistente	2027-04-17
107	10001624-9	VAR	2027-04-17
108	10001934-5	Árbitro Principal	2027-04-18
108	10001706-7	Juez de Línea	2027-04-18
108	10001736-9	Juez de Línea	2027-04-18
108	10001157-3	Árbitro Asistente	2027-04-18
108	10001959-0	VAR	2027-04-18
109	10001060-7	Árbitro Principal	2027-04-17
109	10001391-6	Juez de Línea	2027-04-17
109	10001610-9	Juez de Línea	2027-04-17
109	10001924-8	Árbitro Asistente	2027-04-17
109	10001702-4	VAR	2027-04-17
110	10001460-2	Árbitro Principal	2027-04-17
110	10001283-9	Juez de Línea	2027-04-17
110	10001849-7	Juez de Línea	2027-04-17
110	10001525-0	Árbitro Asistente	2027-04-17
110	10001655-9	VAR	2027-04-17
111	10001107-7	Árbitro Principal	2027-04-30
111	10001091-7	Juez de Línea	2027-04-30
111	10001552-8	Juez de Línea	2027-04-30
111	10001647-8	Árbitro Asistente	2027-04-30
111	10001651-6	VAR	2027-04-30
112	10001073-9	Árbitro Principal	2027-05-02
112	10001706-7	Juez de Línea	2027-05-02
112	10001809-8	Juez de Línea	2027-05-02
112	10001473-4	Árbitro Asistente	2027-05-02
112	10001638-9	VAR	2027-05-02
113	10001624-9	Árbitro Principal	2027-05-01
113	10001111-5	Juez de Línea	2027-05-01
113	10001236-7	Juez de Línea	2027-05-01
113	10001909-4	Árbitro Asistente	2027-05-01
113	10001850-0	VAR	2027-05-01
114	10001051-8	Árbitro Principal	2027-05-02
114	10001407-6	Juez de Línea	2027-05-02
114	10001678-8	Juez de Línea	2027-05-02
114	10001931-0	Árbitro Asistente	2027-05-02
114	10001460-2	VAR	2027-05-02
115	10001273-1	Árbitro Principal	2027-05-02
115	10001241-3	Juez de Línea	2027-05-02
115	10001682-6	Juez de Línea	2027-05-02
115	10001635-4	Árbitro Asistente	2027-05-02
115	10001529-3	VAR	2027-05-02
116	10001819-5	Árbitro Principal	2027-05-01
116	10001337-1	Juez de Línea	2027-05-01
116	10001525-0	Juez de Línea	2027-05-01
116	10001655-9	Árbitro Asistente	2027-05-01
116	10001557-9	VAR	2027-05-01
117	10001975-2	Árbitro Principal	2027-05-01
117	10001538-2	Juez de Línea	2027-05-01
117	10001864-0	Juez de Línea	2027-05-01
117	10001298-7	Árbitro Asistente	2027-05-01
117	10001035-6	VAR	2027-05-01
118	10001849-7	Árbitro Principal	2027-05-01
118	10001399-1	Juez de Línea	2027-05-01
118	10001411-4	Juez de Línea	2027-05-01
118	10001873-K	Árbitro Asistente	2027-05-01
118	10001143-3	VAR	2027-05-01
119	10001347-9	Árbitro Principal	2027-04-30
119	10001389-4	Juez de Línea	2027-04-30
119	10001788-1	Juez de Línea	2027-04-30
119	10001701-6	Árbitro Asistente	2027-04-30
119	10001283-9	VAR	2027-04-30
120	10001612-5	Árbitro Principal	2027-05-02
120	10001375-4	Juez de Línea	2027-05-02
120	10001773-3	Juez de Línea	2027-05-02
120	10001101-8	Árbitro Asistente	2027-05-02
120	10001954-K	VAR	2027-05-02
121	10001624-9	Árbitro Principal	2027-05-08
121	10001063-1	Juez de Línea	2027-05-08
121	10001143-3	Juez de Línea	2027-05-08
121	10001101-8	Árbitro Asistente	2027-05-08
121	10001337-1	VAR	2027-05-08
122	10001596-K	Árbitro Principal	2027-05-08
122	10001091-7	Juez de Línea	2027-05-08
122	10001702-4	Juez de Línea	2027-05-08
122	10001411-4	Árbitro Asistente	2027-05-08
122	10001651-6	VAR	2027-05-08
123	10001389-4	Árbitro Principal	2027-05-09
123	10001706-7	Juez de Línea	2027-05-09
123	10001864-0	Juez de Línea	2027-05-09
123	10001358-4	Árbitro Asistente	2027-05-09
123	10001849-7	VAR	2027-05-09
124	10001809-8	Árbitro Principal	2027-05-09
124	10001678-8	Juez de Línea	2027-05-09
124	10001931-0	Juez de Línea	2027-05-09
124	10001298-7	Árbitro Asistente	2027-05-09
124	10001073-9	VAR	2027-05-09
125	10001638-9	Árbitro Principal	2027-05-09
125	10001094-1	Juez de Línea	2027-05-09
125	10001819-5	Juez de Línea	2027-05-09
125	10001241-3	Árbitro Asistente	2027-05-09
125	10001045-3	VAR	2027-05-09
126	10001525-0	Árbitro Principal	2027-05-07
126	10001104-2	Juez de Línea	2027-05-07
126	10001736-9	Juez de Línea	2027-05-07
126	10001538-2	Árbitro Asistente	2027-05-07
126	10001783-0	VAR	2027-05-07
127	10001460-2	Árbitro Principal	2027-05-08
127	10001610-9	Juez de Línea	2027-05-08
127	10001942-6	Juez de Línea	2027-05-08
127	10001157-3	Árbitro Asistente	2027-05-08
127	10001635-4	VAR	2027-05-08
128	10001892-6	Árbitro Principal	2027-05-07
128	10001552-8	Juez de Línea	2027-05-07
128	10001934-5	Juez de Línea	2027-05-07
128	10001873-K	Árbitro Asistente	2027-05-07
128	10001655-9	VAR	2027-05-07
129	10001557-9	Árbitro Principal	2027-05-09
129	10001347-9	Juez de Línea	2027-05-09
129	10001647-8	Juez de Línea	2027-05-09
129	10001236-7	Árbitro Asistente	2027-05-09
129	10001283-9	VAR	2027-05-09
130	10001370-3	Árbitro Principal	2027-05-08
130	10001399-1	Juez de Línea	2027-05-08
130	10001977-9	Juez de Línea	2027-05-08
130	10001924-8	Árbitro Asistente	2027-05-08
130	10001909-4	VAR	2027-05-08
131	10001678-8	Árbitro Principal	2027-05-16
131	10001111-5	Juez de Línea	2027-05-16
131	10001241-3	Juez de Línea	2027-05-16
131	10001529-3	Árbitro Asistente	2027-05-16
131	10001959-0	VAR	2027-05-16
132	10001101-8	Árbitro Principal	2027-05-16
132	10001143-3	Juez de Línea	2027-05-16
132	10001702-4	Juez de Línea	2027-05-16
132	10001655-9	Árbitro Asistente	2027-05-16
132	10001362-2	VAR	2027-05-16
133	10001337-1	Árbitro Principal	2027-05-15
133	10001535-8	Juez de Línea	2027-05-15
133	10001892-6	Juez de Línea	2027-05-15
133	10001873-K	Árbitro Asistente	2027-05-15
133	10001977-9	VAR	2027-05-15
134	10001460-2	Árbitro Principal	2027-05-14
134	10001399-1	Juez de Línea	2027-05-14
134	10001596-K	Juez de Línea	2027-05-14
134	10001954-K	Árbitro Asistente	2027-05-14
134	10001624-9	VAR	2027-05-14
135	10001647-8	Árbitro Principal	2027-05-16
135	10001298-7	Juez de Línea	2027-05-16
135	10001924-8	Juez de Línea	2027-05-16
135	10001934-5	Árbitro Asistente	2027-05-16
135	10001473-4	VAR	2027-05-16
136	10001612-5	Árbitro Principal	2027-05-15
136	10001017-8	Juez de Línea	2027-05-15
136	10001773-3	Juez de Línea	2027-05-15
136	10001975-2	Árbitro Asistente	2027-05-15
136	10001367-3	VAR	2027-05-15
137	10001864-0	Árbitro Principal	2027-05-14
137	10001407-6	Juez de Línea	2027-05-14
137	10001788-1	Juez de Línea	2027-05-14
137	10001931-0	Árbitro Asistente	2027-05-14
137	10001610-9	VAR	2027-05-14
138	10001615-K	Árbitro Principal	2027-05-16
138	10001094-1	Juez de Línea	2027-05-16
138	10001783-0	Juez de Línea	2027-05-16
138	10001411-4	Árbitro Asistente	2027-05-16
138	10001635-4	VAR	2027-05-16
139	10001819-5	Árbitro Principal	2027-05-15
139	10001538-2	Juez de Línea	2027-05-15
139	10001552-8	Juez de Línea	2027-05-15
139	10001283-9	Árbitro Asistente	2027-05-15
139	10001909-4	VAR	2027-05-15
140	10001104-2	Árbitro Principal	2027-05-15
140	10001375-4	Juez de Línea	2027-05-15
140	10001557-9	Juez de Línea	2027-05-15
140	10001801-2	Árbitro Asistente	2027-05-15
140	10001849-7	VAR	2027-05-15
141	10001411-4	Árbitro Principal	2027-05-21
141	10001035-6	Juez de Línea	2027-05-21
141	10001873-K	Juez de Línea	2027-05-21
141	10001809-8	Árbitro Asistente	2027-05-21
141	10001063-1	VAR	2027-05-21
142	10001538-2	Árbitro Principal	2027-05-22
142	10001410-6	Juez de Línea	2027-05-22
142	10001706-7	Juez de Línea	2027-05-22
142	10001391-6	Árbitro Asistente	2027-05-22
142	10001931-0	VAR	2027-05-22
143	10001975-2	Árbitro Principal	2027-05-21
143	10001104-2	Juez de Línea	2027-05-21
143	10001701-6	Juez de Línea	2027-05-21
143	10001934-5	Árbitro Asistente	2027-05-21
143	10001678-8	VAR	2027-05-21
144	10001407-6	Árbitro Principal	2027-05-23
144	10001157-3	Juez de Línea	2027-05-23
144	10001651-6	Juez de Línea	2027-05-23
144	10001788-1	Árbitro Asistente	2027-05-23
144	10001624-9	VAR	2027-05-23
145	10001236-7	Árbitro Principal	2027-05-23
145	10001060-7	Juez de Línea	2027-05-23
145	10001924-8	Juez de Línea	2027-05-23
145	10001362-2	Árbitro Asistente	2027-05-23
145	10001091-7	VAR	2027-05-23
146	10001107-7	Árbitro Principal	2027-05-22
146	10001615-K	Juez de Línea	2027-05-22
146	10001977-9	Juez de Línea	2027-05-22
146	10001051-8	Árbitro Asistente	2027-05-22
146	10001909-4	VAR	2027-05-22
147	10001700-8	Árbitro Principal	2027-05-23
147	10001017-8	Juez de Línea	2027-05-23
147	10001473-4	Juez de Línea	2027-05-23
147	10001959-0	Árbitro Asistente	2027-05-23
147	10001073-9	VAR	2027-05-23
148	10001525-0	Árbitro Principal	2027-05-22
148	10001535-8	Juez de Línea	2027-05-22
148	10001864-0	Juez de Línea	2027-05-22
148	10001143-3	Árbitro Asistente	2027-05-22
148	10001529-3	VAR	2027-05-22
149	10001635-4	Árbitro Principal	2027-05-23
149	10001389-4	Juez de Línea	2027-05-23
149	10001638-9	Juez de Línea	2027-05-23
149	10001399-1	Árbitro Asistente	2027-05-23
149	10001084-4	VAR	2027-05-23
150	10001702-4	Árbitro Principal	2027-05-22
150	10001045-3	Juez de Línea	2027-05-22
150	10001241-3	Juez de Línea	2027-05-22
150	10001596-K	Árbitro Asistente	2027-05-22
150	10001773-3	VAR	2027-05-22
151	10001273-1	Árbitro Principal	2027-05-30
151	10001051-8	Juez de Línea	2027-05-30
151	10001612-5	Juez de Línea	2027-05-30
151	10001035-6	Árbitro Asistente	2027-05-30
151	10001362-2	VAR	2027-05-30
152	10001298-7	Árbitro Principal	2027-05-28
152	10001535-8	Juez de Línea	2027-05-28
152	10001788-1	Juez de Línea	2027-05-28
152	10001358-4	Árbitro Asistente	2027-05-28
152	10001538-2	VAR	2027-05-28
153	10001107-7	Árbitro Principal	2027-05-29
153	10001367-3	Juez de Línea	2027-05-29
153	10001959-0	Juez de Línea	2027-05-29
153	10001473-4	Árbitro Asistente	2027-05-29
153	10001783-0	VAR	2027-05-29
154	10001596-K	Árbitro Principal	2027-05-30
154	10001241-3	Juez de Línea	2027-05-30
154	10001635-4	Juez de Línea	2027-05-30
154	10001407-6	Árbitro Asistente	2027-05-30
154	10001934-5	VAR	2027-05-30
155	10001283-9	Árbitro Principal	2027-05-28
155	10001060-7	Juez de Línea	2027-05-28
155	10001773-3	Juez de Línea	2027-05-28
155	10001552-8	Árbitro Asistente	2027-05-28
155	10001557-9	VAR	2027-05-28
156	10001655-9	Árbitro Principal	2027-05-29
156	10001809-8	Juez de Línea	2027-05-29
156	10001975-2	Juez de Línea	2027-05-29
156	10001460-2	Árbitro Asistente	2027-05-29
156	10001977-9	VAR	2027-05-29
157	10001873-K	Árbitro Principal	2027-05-30
157	10001610-9	Juez de Línea	2027-05-30
157	10001700-8	Juez de Línea	2027-05-30
157	10001864-0	Árbitro Asistente	2027-05-30
157	10001391-6	VAR	2027-05-30
158	10001091-7	Árbitro Principal	2027-05-29
158	10001892-6	Juez de Línea	2027-05-29
158	10001931-0	Juez de Línea	2027-05-29
158	10001157-3	Árbitro Asistente	2027-05-29
158	10001399-1	VAR	2027-05-29
159	10001084-4	Árbitro Principal	2027-05-30
159	10001624-9	Juez de Línea	2027-05-30
159	10001849-7	Juez de Línea	2027-05-30
159	10001850-0	Árbitro Asistente	2027-05-30
159	10001236-7	VAR	2027-05-30
160	10001094-1	Árbitro Principal	2027-05-29
160	10001615-K	Juez de Línea	2027-05-29
160	10001801-2	Juez de Línea	2027-05-29
160	10001819-5	Árbitro Asistente	2027-05-29
160	10001347-9	VAR	2027-05-29
161	10001104-2	Árbitro Principal	2027-06-06
161	10001347-9	Juez de Línea	2027-06-06
161	10001931-0	Juez de Línea	2027-06-06
161	10001236-7	Árbitro Asistente	2027-06-06
161	10001959-0	VAR	2027-06-06
162	10001017-8	Árbitro Principal	2027-06-04
162	10001241-3	Juez de Línea	2027-06-04
162	10001850-0	Juez de Línea	2027-06-04
162	10001391-6	Árbitro Asistente	2027-06-04
162	10001051-8	VAR	2027-06-04
163	10001678-8	Árbitro Principal	2027-06-04
163	10001362-2	Juez de Línea	2027-06-04
163	10001788-1	Juez de Línea	2027-06-04
163	10001091-7	Árbitro Asistente	2027-06-04
163	10001783-0	VAR	2027-06-04
164	10001924-8	Árbitro Principal	2027-06-05
164	10001060-7	Juez de Línea	2027-06-05
164	10001624-9	Juez de Línea	2027-06-05
164	10001107-7	Árbitro Asistente	2027-06-05
164	10001635-4	VAR	2027-06-05
165	10001819-5	Árbitro Principal	2027-06-05
165	10001143-3	Juez de Línea	2027-06-05
165	10001596-K	Juez de Línea	2027-06-05
165	10001375-4	Árbitro Asistente	2027-06-05
165	10001864-0	VAR	2027-06-05
166	10001909-4	Árbitro Principal	2027-06-06
166	10001035-6	Juez de Línea	2027-06-06
166	10001849-7	Juez de Línea	2027-06-06
166	10001954-K	Árbitro Asistente	2027-06-06
166	10001045-3	VAR	2027-06-06
167	10001702-4	Árbitro Principal	2027-06-06
167	10001101-8	Juez de Línea	2027-06-06
167	10001535-8	Juez de Línea	2027-06-06
167	10001736-9	Árbitro Asistente	2027-06-06
167	10001612-5	VAR	2027-06-06
168	10001073-9	Árbitro Principal	2027-06-06
168	10001411-4	Juez de Línea	2027-06-06
168	10001701-6	Juez de Línea	2027-06-06
168	10001700-8	Árbitro Asistente	2027-06-06
168	10001084-4	VAR	2027-06-06
169	10001157-3	Árbitro Principal	2027-06-05
169	10001460-2	Juez de Línea	2027-06-05
169	10001638-9	Juez de Línea	2027-06-05
169	10001801-2	Árbitro Asistente	2027-06-05
169	10001337-1	VAR	2027-06-05
170	10001682-6	Árbitro Principal	2027-06-05
170	10001273-1	Juez de Línea	2027-06-05
170	10001977-9	Juez de Línea	2027-06-05
170	10001094-1	Árbitro Asistente	2027-06-05
170	10001975-2	VAR	2027-06-05
171	10001460-2	Árbitro Principal	2027-06-13
171	10001391-6	Juez de Línea	2027-06-13
171	10001977-9	Juez de Línea	2027-06-13
171	10001051-8	Árbitro Asistente	2027-06-13
171	10001094-1	VAR	2027-06-13
172	10001864-0	Árbitro Principal	2027-06-12
172	10001624-9	Juez de Línea	2027-06-12
172	10001773-3	Juez de Línea	2027-06-12
172	10001063-1	Árbitro Asistente	2027-06-12
172	10001473-4	VAR	2027-06-12
173	10001850-0	Árbitro Principal	2027-06-11
173	10001298-7	Juez de Línea	2027-06-11
173	10001375-4	Juez de Línea	2027-06-11
173	10001954-K	Árbitro Asistente	2027-06-11
173	10001104-2	VAR	2027-06-11
174	10001073-9	Árbitro Principal	2027-06-12
174	10001030-5	Juez de Línea	2027-06-12
174	10001655-9	Juez de Línea	2027-06-12
174	10001638-9	Árbitro Asistente	2027-06-12
174	10001783-0	VAR	2027-06-12
175	10001367-3	Árbitro Principal	2027-06-12
175	10001107-7	Juez de Línea	2027-06-12
175	10001535-8	Juez de Línea	2027-06-12
175	10001538-2	Árbitro Asistente	2027-06-12
175	10001819-5	VAR	2027-06-12
176	10001934-5	Árbitro Principal	2027-06-13
176	10001370-3	Juez de Línea	2027-06-13
176	10001924-8	Juez de Línea	2027-06-13
176	10001610-9	Árbitro Asistente	2027-06-13
176	10001084-4	VAR	2027-06-13
177	10001035-6	Árbitro Principal	2027-06-13
177	10001045-3	Juez de Línea	2027-06-13
177	10001552-8	Juez de Línea	2027-06-13
177	10001892-6	Árbitro Asistente	2027-06-13
177	10001362-2	VAR	2027-06-13
178	10001701-6	Árbitro Principal	2027-06-12
178	10001389-4	Juez de Línea	2027-06-12
178	10001849-7	Juez de Línea	2027-06-12
178	10001347-9	Árbitro Asistente	2027-06-12
178	10001682-6	VAR	2027-06-12
179	10001651-6	Árbitro Principal	2027-06-13
179	10001101-8	Juez de Línea	2027-06-13
179	10001241-3	Juez de Línea	2027-06-13
179	10001736-9	Árbitro Asistente	2027-06-13
179	10001157-3	VAR	2027-06-13
180	10001975-2	Árbitro Principal	2027-06-11
180	10001337-1	Juez de Línea	2027-06-11
180	10001399-1	Juez de Línea	2027-06-11
180	10001410-6	Árbitro Asistente	2027-06-11
180	10001017-8	VAR	2027-06-11
181	10001678-8	Árbitro Principal	2027-06-18
181	10001706-7	Juez de Línea	2027-06-18
181	10001892-6	Juez de Línea	2027-06-18
181	10001849-7	Árbitro Asistente	2027-06-18
181	10001959-0	VAR	2027-06-18
182	10001873-K	Árbitro Principal	2027-06-20
182	10001337-1	Juez de Línea	2027-06-20
182	10001788-1	Juez de Línea	2027-06-20
182	10001647-8	Árbitro Asistente	2027-06-20
182	10001635-4	VAR	2027-06-20
183	10001407-6	Árbitro Principal	2027-06-19
183	10001651-6	Juez de Línea	2027-06-19
183	10001783-0	Juez de Línea	2027-06-19
183	10001073-9	Árbitro Asistente	2027-06-19
183	10001638-9	VAR	2027-06-19
184	10001809-8	Árbitro Principal	2027-06-20
184	10001273-1	Juez de Línea	2027-06-20
184	10001362-2	Juez de Línea	2027-06-20
184	10001924-8	Árbitro Asistente	2027-06-20
184	10001682-6	VAR	2027-06-20
185	10001612-5	Árbitro Principal	2027-06-18
185	10001391-6	Juez de Línea	2027-06-18
185	10001535-8	Juez de Línea	2027-06-18
185	10001101-8	Árbitro Asistente	2027-06-18
185	10001143-3	VAR	2027-06-18
186	10001954-K	Árbitro Principal	2027-06-19
186	10001084-4	Juez de Línea	2027-06-19
186	10001655-9	Juez de Línea	2027-06-19
186	10001819-5	Árbitro Asistente	2027-06-19
186	10001557-9	VAR	2027-06-19
187	10001460-2	Árbitro Principal	2027-06-20
187	10001045-3	Juez de Línea	2027-06-20
187	10001094-1	Juez de Línea	2027-06-20
187	10001610-9	Árbitro Asistente	2027-06-20
187	10001399-1	VAR	2027-06-20
188	10001060-7	Árbitro Principal	2027-06-19
188	10001051-8	Juez de Línea	2027-06-19
188	10001801-2	Juez de Línea	2027-06-19
188	10001241-3	Árbitro Asistente	2027-06-19
188	10001157-3	VAR	2027-06-19
189	10001370-3	Árbitro Principal	2027-06-19
189	10001347-9	Juez de Línea	2027-06-19
189	10001934-5	Juez de Línea	2027-06-19
189	10001017-8	Árbitro Asistente	2027-06-19
189	10001358-4	VAR	2027-06-19
190	10001975-2	Árbitro Principal	2027-06-20
190	10001111-5	Juez de Línea	2027-06-20
190	10001283-9	Juez de Línea	2027-06-20
190	10001389-4	Árbitro Asistente	2027-06-20
190	10001596-K	VAR	2027-06-20
191	10001035-6	Árbitro Principal	2027-06-26
191	10001107-7	Juez de Línea	2027-06-26
191	10001801-2	Juez de Línea	2027-06-26
191	10001892-6	Árbitro Asistente	2027-06-26
191	10001819-5	VAR	2027-06-26
192	10001975-2	Árbitro Principal	2027-06-27
192	10001063-1	Juez de Línea	2027-06-27
192	10001407-6	Juez de Línea	2027-06-27
192	10001030-5	Árbitro Asistente	2027-06-27
192	10001073-9	VAR	2027-06-27
193	10001678-8	Árbitro Principal	2027-06-27
193	10001241-3	Juez de Línea	2027-06-27
193	10001931-0	Juez de Línea	2027-06-27
193	10001655-9	Árbitro Asistente	2027-06-27
193	10001410-6	VAR	2027-06-27
194	10001411-4	Árbitro Principal	2027-06-25
194	10001060-7	Juez de Línea	2027-06-25
194	10001525-0	Juez de Línea	2027-06-25
194	10001701-6	Árbitro Asistente	2027-06-25
194	10001682-6	VAR	2027-06-25
195	10001651-6	Árbitro Principal	2027-06-26
195	10001473-4	Juez de Línea	2027-06-26
195	10001557-9	Juez de Línea	2027-06-26
195	10001736-9	Árbitro Asistente	2027-06-26
195	10001706-7	VAR	2027-06-26
196	10001959-0	Árbitro Principal	2027-06-26
196	10001094-1	Juez de Línea	2027-06-26
196	10001529-3	Juez de Línea	2027-06-26
196	10001977-9	Árbitro Asistente	2027-06-26
196	10001391-6	VAR	2027-06-26
197	10001864-0	Árbitro Principal	2027-06-27
197	10001157-3	Juez de Línea	2027-06-27
197	10001788-1	Juez de Línea	2027-06-27
197	10001909-4	Árbitro Asistente	2027-06-27
197	10001101-8	VAR	2027-06-27
198	10001610-9	Árbitro Principal	2027-06-26
198	10001298-7	Juez de Línea	2027-06-26
198	10001624-9	Juez de Línea	2027-06-26
198	10001552-8	Árbitro Asistente	2027-06-26
198	10001337-1	VAR	2027-06-26
199	10001367-3	Árbitro Principal	2027-06-27
199	10001143-3	Juez de Línea	2027-06-27
199	10001358-4	Juez de Línea	2027-06-27
199	10001017-8	Árbitro Asistente	2027-06-27
199	10001236-7	VAR	2027-06-27
200	10001104-2	Árbitro Principal	2027-06-25
200	10001283-9	Juez de Línea	2027-06-25
200	10001612-5	Juez de Línea	2027-06-25
200	10001051-8	Árbitro Asistente	2027-06-25
200	10001538-2	VAR	2027-06-25
201	10001298-7	Árbitro Principal	2027-07-04
201	10001084-4	Juez de Línea	2027-07-04
201	10001651-6	Juez de Línea	2027-07-04
201	10001410-6	Árbitro Asistente	2027-07-04
201	10001283-9	VAR	2027-07-04
202	10001143-3	Árbitro Principal	2027-07-03
202	10001236-7	Juez de Línea	2027-07-03
202	10001535-8	Juez de Línea	2027-07-03
202	10001931-0	Árbitro Asistente	2027-07-03
202	10001362-2	VAR	2027-07-03
203	10001959-0	Árbitro Principal	2027-07-04
203	10001612-5	Juez de Línea	2027-07-04
203	10001783-0	Juez de Línea	2027-07-04
203	10001157-3	Árbitro Asistente	2027-07-04
203	10001736-9	VAR	2027-07-04
204	10001706-7	Árbitro Principal	2027-07-03
204	10001389-4	Juez de Línea	2027-07-03
204	10001655-9	Juez de Línea	2027-07-03
204	10001104-2	Árbitro Asistente	2027-07-03
204	10001111-5	VAR	2027-07-03
205	10001391-6	Árbitro Principal	2027-07-02
205	10001101-8	Juez de Línea	2027-07-02
205	10001241-3	Juez de Línea	2027-07-02
205	10001358-4	Árbitro Asistente	2027-07-02
205	10001030-5	VAR	2027-07-02
206	10001892-6	Árbitro Principal	2027-07-02
206	10001035-6	Juez de Línea	2027-07-02
206	10001635-4	Juez de Línea	2027-07-02
206	10001460-2	Árbitro Asistente	2027-07-02
206	10001107-7	VAR	2027-07-02
207	10001954-K	Árbitro Principal	2027-07-04
207	10001073-9	Juez de Línea	2027-07-04
207	10001700-8	Juez de Línea	2027-07-04
207	10001934-5	Árbitro Asistente	2027-07-04
207	10001850-0	VAR	2027-07-04
208	10001615-K	Árbitro Principal	2027-07-04
208	10001411-4	Juez de Línea	2027-07-04
208	10001849-7	Juez de Línea	2027-07-04
208	10001819-5	Árbitro Asistente	2027-07-04
208	10001051-8	VAR	2027-07-04
209	10001060-7	Árbitro Principal	2027-07-03
209	10001624-9	Juez de Línea	2027-07-03
209	10001678-8	Juez de Línea	2027-07-03
209	10001017-8	Árbitro Asistente	2027-07-03
209	10001924-8	VAR	2027-07-03
210	10001407-6	Árbitro Principal	2027-07-03
210	10001529-3	Juez de Línea	2027-07-03
210	10001596-K	Juez de Línea	2027-07-03
210	10001977-9	Árbitro Asistente	2027-07-03
210	10001273-1	VAR	2027-07-03
211	10001273-1	Árbitro Principal	2027-07-18
211	10001473-4	Juez de Línea	2027-07-18
211	10001682-6	Juez de Línea	2027-07-18
211	10001615-K	Árbitro Asistente	2027-07-18
211	10001934-5	VAR	2027-07-18
212	10001538-2	Árbitro Principal	2027-07-18
212	10001157-3	Juez de Línea	2027-07-18
212	10001931-0	Juez de Línea	2027-07-18
212	10001283-9	Árbitro Asistente	2027-07-18
212	10001535-8	VAR	2027-07-18
213	10001017-8	Árbitro Principal	2027-07-16
213	10001073-9	Juez de Línea	2027-07-16
213	10001091-7	Juez de Línea	2027-07-16
213	10001337-1	Árbitro Asistente	2027-07-16
213	10001389-4	VAR	2027-07-16
214	10001954-K	Árbitro Principal	2027-07-17
214	10001460-2	Juez de Línea	2027-07-17
214	10001801-2	Juez de Línea	2027-07-17
214	10001101-8	Árbitro Asistente	2027-07-17
214	10001864-0	VAR	2027-07-17
215	10001655-9	Árbitro Principal	2027-07-16
215	10001635-4	Juez de Línea	2027-07-16
215	10001873-K	Juez de Línea	2027-07-16
215	10001410-6	Árbitro Asistente	2027-07-16
215	10001063-1	VAR	2027-07-16
216	10001362-2	Árbitro Principal	2027-07-17
216	10001060-7	Juez de Línea	2027-07-17
216	10001701-6	Juez de Línea	2027-07-17
216	10001610-9	Árbitro Asistente	2027-07-17
216	10001358-4	VAR	2027-07-17
217	10001612-5	Árbitro Principal	2027-07-17
217	10001298-7	Juez de Línea	2027-07-17
217	10001367-3	Juez de Línea	2027-07-17
217	10001143-3	Árbitro Asistente	2027-07-17
217	10001892-6	VAR	2027-07-17
218	10001706-7	Árbitro Principal	2027-07-18
218	10001557-9	Juez de Línea	2027-07-18
218	10001736-9	Juez de Línea	2027-07-18
218	10001107-7	Árbitro Asistente	2027-07-18
218	10001391-6	VAR	2027-07-18
219	10001236-7	Árbitro Principal	2027-07-18
219	10001241-3	Juez de Línea	2027-07-18
219	10001788-1	Juez de Línea	2027-07-18
219	10001407-6	Árbitro Asistente	2027-07-18
219	10001819-5	VAR	2027-07-18
220	10001084-4	Árbitro Principal	2027-07-17
220	10001104-2	Juez de Línea	2027-07-17
220	10001347-9	Juez de Línea	2027-07-17
220	10001651-6	Árbitro Asistente	2027-07-17
220	10001552-8	VAR	2027-07-17
221	10001298-7	Árbitro Principal	2027-07-23
221	10001399-1	Juez de Línea	2027-07-23
221	10001552-8	Juez de Línea	2027-07-23
221	10001638-9	Árbitro Asistente	2027-07-23
221	10001701-6	VAR	2027-07-23
222	10001864-0	Árbitro Principal	2027-07-25
222	10001101-8	Juez de Línea	2027-07-25
222	10001610-9	Juez de Línea	2027-07-25
222	10001407-6	Árbitro Asistente	2027-07-25
222	10001873-K	VAR	2027-07-25
223	10001051-8	Árbitro Principal	2027-07-24
223	10001111-5	Juez de Línea	2027-07-24
223	10001977-9	Juez de Línea	2027-07-24
223	10001809-8	Árbitro Asistente	2027-07-24
223	10001655-9	VAR	2027-07-24
224	10001063-1	Árbitro Principal	2027-07-25
224	10001635-4	Juez de Línea	2027-07-25
224	10001959-0	Juez de Línea	2027-07-25
224	10001700-8	Árbitro Asistente	2027-07-25
224	10001773-3	VAR	2027-07-25
225	10001045-3	Árbitro Principal	2027-07-25
225	10001389-4	Juez de Línea	2027-07-25
225	10001615-K	Juez de Línea	2027-07-25
225	10001596-K	Árbitro Asistente	2027-07-25
225	10001035-6	VAR	2027-07-25
226	10001241-3	Árbitro Principal	2027-07-24
226	10001104-2	Juez de Línea	2027-07-24
226	10001362-2	Juez de Línea	2027-07-24
226	10001702-4	Árbitro Asistente	2027-07-24
226	10001060-7	VAR	2027-07-24
227	10001612-5	Árbitro Principal	2027-07-24
227	10001678-8	Juez de Línea	2027-07-24
227	10001850-0	Juez de Línea	2027-07-24
227	10001801-2	Árbitro Asistente	2027-07-24
227	10001017-8	VAR	2027-07-24
228	10001283-9	Árbitro Principal	2027-07-24
228	10001535-8	Juez de Línea	2027-07-24
228	10001819-5	Juez de Línea	2027-07-24
228	10001107-7	Árbitro Asistente	2027-07-24
228	10001975-2	VAR	2027-07-24
229	10001143-3	Árbitro Principal	2027-07-23
229	10001460-2	Juez de Línea	2027-07-23
229	10001954-K	Juez de Línea	2027-07-23
229	10001651-6	Árbitro Asistente	2027-07-23
229	10001538-2	VAR	2027-07-23
230	10001084-4	Árbitro Principal	2027-07-25
230	10001337-1	Juez de Línea	2027-07-25
230	10001410-6	Juez de Línea	2027-07-25
230	10001473-4	Árbitro Asistente	2027-07-25
230	10001647-8	VAR	2027-07-25
231	10001035-6	Árbitro Principal	2027-07-31
231	10001736-9	Juez de Línea	2027-07-31
231	10001783-0	Juez de Línea	2027-07-31
231	10001610-9	Árbitro Asistente	2027-07-31
231	10001934-5	VAR	2027-07-31
232	10001959-0	Árbitro Principal	2027-07-31
232	10001367-3	Juez de Línea	2027-07-31
232	10001931-0	Juez de Línea	2027-07-31
232	10001410-6	Árbitro Asistente	2027-07-31
232	10001091-7	VAR	2027-07-31
233	10001362-2	Árbitro Principal	2027-07-30
233	10001283-9	Juez de Línea	2027-07-30
233	10001399-1	Juez de Línea	2027-07-30
233	10001236-7	Árbitro Asistente	2027-07-30
233	10001624-9	VAR	2027-07-30
234	10001535-8	Árbitro Principal	2027-08-01
234	10001407-6	Juez de Línea	2027-08-01
234	10001612-5	Juez de Línea	2027-08-01
234	10001635-4	Árbitro Asistente	2027-08-01
234	10001638-9	VAR	2027-08-01
235	10001375-4	Árbitro Principal	2027-07-31
235	10001107-7	Juez de Línea	2027-07-31
235	10001849-7	Juez de Línea	2027-07-31
235	10001557-9	Árbitro Asistente	2027-07-31
235	10001298-7	VAR	2027-07-31
236	10001241-3	Árbitro Principal	2027-07-30
236	10001347-9	Juez de Línea	2027-07-30
236	10001788-1	Juez de Línea	2027-07-30
236	10001819-5	Árbitro Asistente	2027-07-30
236	10001975-2	VAR	2027-07-30
237	10001552-8	Árbitro Principal	2027-08-01
237	10001111-5	Juez de Línea	2027-08-01
237	10001909-4	Juez de Línea	2027-08-01
237	10001051-8	Árbitro Asistente	2027-08-01
237	10001864-0	VAR	2027-08-01
238	10001337-1	Árbitro Principal	2027-07-31
238	10001706-7	Juez de Línea	2027-07-31
238	10001892-6	Juez de Línea	2027-07-31
238	10001073-9	Árbitro Asistente	2027-07-31
238	10001411-4	VAR	2027-07-31
239	10001873-K	Árbitro Principal	2027-08-01
239	10001389-4	Juez de Línea	2027-08-01
239	10001924-8	Juez de Línea	2027-08-01
239	10001060-7	Árbitro Asistente	2027-08-01
239	10001104-2	VAR	2027-08-01
240	10001529-3	Árbitro Principal	2027-08-01
240	10001647-8	Juez de Línea	2027-08-01
240	10001655-9	Juez de Línea	2027-08-01
240	10001651-6	Árbitro Asistente	2027-08-01
240	10001017-8	VAR	2027-08-01
241	10001557-9	Árbitro Principal	2027-08-07
241	10001399-1	Juez de Línea	2027-08-07
241	10001864-0	Juez de Línea	2027-08-07
241	10001407-6	Árbitro Asistente	2027-08-07
241	10001678-8	VAR	2027-08-07
242	10001615-K	Árbitro Principal	2027-08-06
242	10001084-4	Juez de Línea	2027-08-06
242	10001959-0	Juez de Línea	2027-08-06
242	10001783-0	Árbitro Asistente	2027-08-06
242	10001849-7	VAR	2027-08-06
243	10001358-4	Árbitro Principal	2027-08-07
243	10001389-4	Juez de Línea	2027-08-07
243	10001647-8	Juez de Línea	2027-08-07
243	10001035-6	Árbitro Asistente	2027-08-07
243	10001236-7	VAR	2027-08-07
244	10001977-9	Árbitro Principal	2027-08-06
244	10001073-9	Juez de Línea	2027-08-06
244	10001538-2	Juez de Línea	2027-08-06
244	10001873-K	Árbitro Asistente	2027-08-06
244	10001535-8	VAR	2027-08-06
245	10001051-8	Árbitro Principal	2027-08-08
245	10001700-8	Juez de Línea	2027-08-08
245	10001924-8	Juez de Línea	2027-08-08
245	10001391-6	Árbitro Asistente	2027-08-08
245	10001702-4	VAR	2027-08-08
246	10001819-5	Árbitro Principal	2027-08-08
246	10001298-7	Juez de Línea	2027-08-08
246	10001370-3	Juez de Línea	2027-08-08
246	10001367-3	Árbitro Asistente	2027-08-08
246	10001525-0	VAR	2027-08-08
247	10001273-1	Árbitro Principal	2027-08-08
247	10001060-7	Juez de Línea	2027-08-08
247	10001942-6	Juez de Línea	2027-08-08
247	10001801-2	Árbitro Asistente	2027-08-08
247	10001411-4	VAR	2027-08-08
248	10001788-1	Árbitro Principal	2027-08-07
248	10001635-4	Juez de Línea	2027-08-07
248	10001773-3	Juez de Línea	2027-08-07
248	10001624-9	Árbitro Asistente	2027-08-07
248	10001809-8	VAR	2027-08-07
249	10001612-5	Árbitro Principal	2027-08-07
249	10001529-3	Juez de Línea	2027-08-07
249	10001931-0	Juez de Línea	2027-08-07
249	10001655-9	Árbitro Asistente	2027-08-07
249	10001241-3	VAR	2027-08-07
250	10001337-1	Árbitro Principal	2027-08-08
250	10001104-2	Juez de Línea	2027-08-08
250	10001347-9	Juez de Línea	2027-08-08
250	10001651-6	Árbitro Asistente	2027-08-08
250	10001736-9	VAR	2027-08-08
251	10001362-2	Árbitro Principal	2027-08-15
251	10001358-4	Juez de Línea	2027-08-15
251	10001975-2	Juez de Línea	2027-08-15
251	10001236-7	Árbitro Asistente	2027-08-15
251	10001635-4	VAR	2027-08-15
252	10001367-3	Árbitro Principal	2027-08-13
252	10001407-6	Juez de Línea	2027-08-13
252	10001934-5	Juez de Línea	2027-08-13
252	10001783-0	Árbitro Asistente	2027-08-13
252	10001801-2	VAR	2027-08-13
253	10001850-0	Árbitro Principal	2027-08-14
253	10001030-5	Juez de Línea	2027-08-14
253	10001063-1	Juez de Línea	2027-08-14
253	10001241-3	Árbitro Asistente	2027-08-14
253	10001596-K	VAR	2027-08-14
254	10001954-K	Árbitro Principal	2027-08-14
254	10001460-2	Juez de Línea	2027-08-14
254	10001909-4	Juez de Línea	2027-08-14
254	10001273-1	Árbitro Asistente	2027-08-14
254	10001942-6	VAR	2027-08-14
255	10001647-8	Árbitro Principal	2027-08-15
255	10001051-8	Juez de Línea	2027-08-15
255	10001678-8	Juez de Línea	2027-08-15
255	10001651-6	Árbitro Asistente	2027-08-15
255	10001143-3	VAR	2027-08-15
256	10001410-6	Árbitro Principal	2027-08-14
256	10001091-7	Juez de Línea	2027-08-14
256	10001700-8	Juez de Línea	2027-08-14
256	10001931-0	Árbitro Asistente	2027-08-14
256	10001283-9	VAR	2027-08-14
257	10001924-8	Árbitro Principal	2027-08-13
257	10001473-4	Juez de Línea	2027-08-13
257	10001788-1	Juez de Línea	2027-08-13
257	10001612-5	Árbitro Asistente	2027-08-13
257	10001035-6	VAR	2027-08-13
258	10001101-8	Árbitro Principal	2027-08-14
258	10001399-1	Juez de Línea	2027-08-14
258	10001552-8	Juez de Línea	2027-08-14
258	10001073-9	Árbitro Asistente	2027-08-14
258	10001819-5	VAR	2027-08-14
259	10001773-3	Árbitro Principal	2027-08-15
259	10001411-4	Juez de Línea	2027-08-15
259	10001655-9	Juez de Línea	2027-08-15
259	10001701-6	Árbitro Asistente	2027-08-15
259	10001538-2	VAR	2027-08-15
260	10001084-4	Árbitro Principal	2027-08-15
260	10001525-0	Juez de Línea	2027-08-15
260	10001706-7	Juez de Línea	2027-08-15
260	10001535-8	Árbitro Asistente	2027-08-15
260	10001337-1	VAR	2027-08-15
261	10001706-7	Árbitro Principal	2027-08-21
261	10001157-3	Juez de Línea	2027-08-21
261	10001977-9	Juez de Línea	2027-08-21
261	10001801-2	Árbitro Asistente	2027-08-21
261	10001362-2	VAR	2027-08-21
262	10001094-1	Árbitro Principal	2027-08-22
262	10001091-7	Juez de Línea	2027-08-22
262	10001367-3	Juez de Línea	2027-08-22
262	10001035-6	Árbitro Asistente	2027-08-22
262	10001638-9	VAR	2027-08-22
263	10001873-K	Árbitro Principal	2027-08-21
263	10001111-5	Juez de Línea	2027-08-21
263	10001934-5	Juez de Línea	2027-08-21
263	10001143-3	Árbitro Asistente	2027-08-21
263	10001596-K	VAR	2027-08-21
264	10001538-2	Árbitro Principal	2027-08-20
264	10001241-3	Juez de Línea	2027-08-20
264	10001701-6	Juez de Línea	2027-08-20
264	10001959-0	Árbitro Asistente	2027-08-20
264	10001736-9	VAR	2027-08-20
265	10001030-5	Árbitro Principal	2027-08-22
265	10001389-4	Juez de Línea	2027-08-22
265	10001407-6	Juez de Línea	2027-08-22
265	10001473-4	Árbitro Asistente	2027-08-22
265	10001045-3	VAR	2027-08-22
266	10001236-7	Árbitro Principal	2027-08-21
266	10001682-6	Juez de Línea	2027-08-21
266	10001849-7	Juez de Línea	2027-08-21
266	10001552-8	Árbitro Asistente	2027-08-21
266	10001773-3	VAR	2027-08-21
267	10001104-2	Árbitro Principal	2027-08-21
267	10001535-8	Juez de Línea	2027-08-21
267	10001783-0	Juez de Línea	2027-08-21
267	10001525-0	Árbitro Asistente	2027-08-21
267	10001084-4	VAR	2027-08-21
268	10001298-7	Árbitro Principal	2027-08-22
268	10001610-9	Juez de Línea	2027-08-22
268	10001975-2	Juez de Línea	2027-08-22
268	10001017-8	Árbitro Asistente	2027-08-22
268	10001651-6	VAR	2027-08-22
269	10001850-0	Árbitro Principal	2027-08-22
269	10001051-8	Juez de Línea	2027-08-22
269	10001788-1	Juez de Línea	2027-08-22
269	10001283-9	Árbitro Asistente	2027-08-22
269	10001370-3	VAR	2027-08-22
270	10001060-7	Árbitro Principal	2027-08-20
270	10001347-9	Juez de Línea	2027-08-20
270	10001924-8	Juez de Línea	2027-08-20
270	10001700-8	Árbitro Asistente	2027-08-20
270	10001337-1	VAR	2027-08-20
271	10001236-7	Árbitro Principal	2027-08-28
271	10001678-8	Juez de Línea	2027-08-28
271	10001682-6	Juez de Línea	2027-08-28
271	10001411-4	Árbitro Asistente	2027-08-28
271	10001399-1	VAR	2027-08-28
272	10001367-3	Árbitro Principal	2027-08-28
272	10001850-0	Juez de Línea	2027-08-28
272	10001934-5	Juez de Línea	2027-08-28
272	10001060-7	Árbitro Asistente	2027-08-28
272	10001655-9	VAR	2027-08-28
273	10001610-9	Árbitro Principal	2027-08-29
273	10001525-0	Juez de Línea	2027-08-29
273	10001819-5	Juez de Línea	2027-08-29
273	10001612-5	Árbitro Asistente	2027-08-29
273	10001647-8	VAR	2027-08-29
274	10001773-3	Árbitro Principal	2027-08-28
274	10001045-3	Juez de Línea	2027-08-28
274	10001473-4	Juez de Línea	2027-08-28
274	10001362-2	Árbitro Asistente	2027-08-28
274	10001864-0	VAR	2027-08-28
275	10001954-K	Árbitro Principal	2027-08-29
275	10001535-8	Juez de Línea	2027-08-29
275	10001892-6	Juez de Línea	2027-08-29
275	10001809-8	Árbitro Asistente	2027-08-29
275	10001073-9	VAR	2027-08-29
276	10001051-8	Árbitro Principal	2027-08-28
276	10001370-3	Juez de Línea	2027-08-28
276	10001391-6	Juez de Línea	2027-08-28
276	10001241-3	Árbitro Asistente	2027-08-28
276	10001873-K	VAR	2027-08-28
277	10001706-7	Árbitro Principal	2027-08-27
277	10001111-5	Juez de Línea	2027-08-27
277	10001801-2	Juez de Línea	2027-08-27
277	10001143-3	Árbitro Asistente	2027-08-27
277	10001783-0	VAR	2027-08-27
278	10001977-9	Árbitro Principal	2027-08-29
278	10001273-1	Juez de Línea	2027-08-29
278	10001849-7	Juez de Línea	2027-08-29
278	10001104-2	Árbitro Asistente	2027-08-29
278	10001358-4	VAR	2027-08-29
279	10001931-0	Árbitro Principal	2027-08-27
279	10001063-1	Juez de Línea	2027-08-27
279	10001375-4	Juez de Línea	2027-08-27
279	10001091-7	Árbitro Asistente	2027-08-27
279	10001635-4	VAR	2027-08-27
280	10001407-6	Árbitro Principal	2027-08-29
280	10001389-4	Juez de Línea	2027-08-29
280	10001924-8	Juez de Línea	2027-08-29
280	10001017-8	Árbitro Asistente	2027-08-29
280	10001651-6	VAR	2027-08-29
281	10001682-6	Árbitro Principal	2027-09-12
281	10001367-3	Juez de Línea	2027-09-12
281	10001525-0	Juez de Línea	2027-09-12
281	10001975-2	Árbitro Asistente	2027-09-12
281	10001783-0	VAR	2027-09-12
282	10001094-1	Árbitro Principal	2027-09-10
282	10001073-9	Juez de Línea	2027-09-10
282	10001977-9	Juez de Línea	2027-09-10
282	10001624-9	Árbitro Asistente	2027-09-10
282	10001399-1	VAR	2027-09-10
283	10001959-0	Árbitro Principal	2027-09-11
283	10001051-8	Juez de Línea	2027-09-11
283	10001701-6	Juez de Línea	2027-09-11
283	10001801-2	Árbitro Asistente	2027-09-11
283	10001101-8	VAR	2027-09-11
284	10001063-1	Árbitro Principal	2027-09-12
284	10001610-9	Juez de Línea	2027-09-12
284	10001700-8	Juez de Línea	2027-09-12
284	10001298-7	Árbitro Asistente	2027-09-12
284	10001389-4	VAR	2027-09-12
285	10001538-2	Árbitro Principal	2027-09-11
285	10001647-8	Juez de Línea	2027-09-11
285	10001924-8	Juez de Línea	2027-09-11
285	10001773-3	Árbitro Asistente	2027-09-11
285	10001104-2	VAR	2027-09-11
286	10001635-4	Árbitro Principal	2027-09-11
286	10001596-K	Juez de Línea	2027-09-11
286	10001638-9	Juez de Línea	2027-09-11
286	10001337-1	Árbitro Asistente	2027-09-11
286	10001411-4	VAR	2027-09-11
287	10001391-6	Árbitro Principal	2027-09-12
287	10001529-3	Juez de Línea	2027-09-12
287	10001678-8	Juez de Línea	2027-09-12
287	10001706-7	Árbitro Asistente	2027-09-12
287	10001060-7	VAR	2027-09-12
288	10001942-6	Árbitro Principal	2027-09-12
288	10001017-8	Juez de Línea	2027-09-12
288	10001651-6	Juez de Línea	2027-09-12
288	10001460-2	Árbitro Asistente	2027-09-12
288	10001347-9	VAR	2027-09-12
289	10001358-4	Árbitro Principal	2027-09-10
289	10001091-7	Juez de Línea	2027-09-10
289	10001370-3	Juez de Línea	2027-09-10
289	10001283-9	Árbitro Asistente	2027-09-10
289	10001045-3	VAR	2027-09-10
290	10001473-4	Árbitro Principal	2027-09-11
290	10001143-3	Juez de Línea	2027-09-11
290	10001410-6	Juez de Línea	2027-09-11
290	10001954-K	Árbitro Asistente	2027-09-11
290	10001552-8	VAR	2027-09-11
291	10001701-6	Árbitro Principal	2027-09-25
291	10001389-4	Juez de Línea	2027-09-25
291	10001788-1	Juez de Línea	2027-09-25
291	10001407-6	Árbitro Asistente	2027-09-25
291	10001706-7	VAR	2027-09-25
292	10001638-9	Árbitro Principal	2027-09-24
292	10001535-8	Juez de Línea	2027-09-24
292	10001864-0	Juez de Línea	2027-09-24
292	10001060-7	Árbitro Asistente	2027-09-24
292	10001337-1	VAR	2027-09-24
293	10001273-1	Árbitro Principal	2027-09-24
293	10001529-3	Juez de Línea	2027-09-24
293	10001783-0	Juez de Línea	2027-09-24
293	10001809-8	Árbitro Asistente	2027-09-24
293	10001375-4	VAR	2027-09-24
294	10001612-5	Árbitro Principal	2027-09-25
294	10001411-4	Juez de Línea	2027-09-25
294	10001873-K	Juez de Línea	2027-09-25
294	10001030-5	Árbitro Asistente	2027-09-25
294	10001610-9	VAR	2027-09-25
295	10001678-8	Árbitro Principal	2027-09-26
295	10001094-1	Juez de Línea	2027-09-26
295	10001615-K	Juez de Línea	2027-09-26
295	10001850-0	Árbitro Asistente	2027-09-26
295	10001017-8	VAR	2027-09-26
296	10001977-9	Árbitro Principal	2027-09-26
296	10001624-9	Juez de Línea	2027-09-26
296	10001651-6	Juez de Línea	2027-09-26
296	10001700-8	Árbitro Asistente	2027-09-26
296	10001391-6	VAR	2027-09-26
297	10001934-5	Árbitro Principal	2027-09-26
297	10001241-3	Juez de Línea	2027-09-26
297	10001283-9	Juez de Línea	2027-09-26
297	10001736-9	Árbitro Asistente	2027-09-26
297	10001931-0	VAR	2027-09-26
298	10001635-4	Árbitro Principal	2027-09-25
298	10001473-4	Juez de Línea	2027-09-25
298	10001702-4	Juez de Línea	2027-09-25
298	10001236-7	Árbitro Asistente	2027-09-25
298	10001682-6	VAR	2027-09-25
299	10001157-3	Árbitro Principal	2027-09-26
299	10001347-9	Juez de Línea	2027-09-26
299	10001655-9	Juez de Línea	2027-09-26
299	10001107-7	Árbitro Asistente	2027-09-26
299	10001045-3	VAR	2027-09-26
300	10001460-2	Árbitro Principal	2027-09-25
300	10001410-6	Juez de Línea	2027-09-25
300	10001924-8	Juez de Línea	2027-09-25
300	10001370-3	Árbitro Asistente	2027-09-25
300	10001104-2	VAR	2027-09-25
301	10001157-3	Árbitro Principal	2027-10-10
301	10001347-9	Juez de Línea	2027-10-10
301	10001736-9	Juez de Línea	2027-10-10
301	10001701-6	Árbitro Asistente	2027-10-10
301	10001017-8	VAR	2027-10-10
302	10001635-4	Árbitro Principal	2027-10-10
302	10001091-7	Juez de Línea	2027-10-10
302	10001101-8	Juez de Línea	2027-10-10
302	10001399-1	Árbitro Asistente	2027-10-10
302	10001700-8	VAR	2027-10-10
303	10001358-4	Árbitro Principal	2027-10-09
303	10001051-8	Juez de Línea	2027-10-09
303	10001873-K	Juez de Línea	2027-10-09
303	10001362-2	Árbitro Asistente	2027-10-09
303	10001063-1	VAR	2027-10-09
304	10001370-3	Árbitro Principal	2027-10-08
304	10001073-9	Juez de Línea	2027-10-08
304	10001788-1	Juez de Línea	2027-10-08
304	10001954-K	Árbitro Asistente	2027-10-08
304	10001525-0	VAR	2027-10-08
305	10001529-3	Árbitro Principal	2027-10-09
305	10001104-2	Juez de Línea	2027-10-09
305	10001773-3	Juez de Línea	2027-10-09
305	10001819-5	Árbitro Asistente	2027-10-09
305	10001535-8	VAR	2027-10-09
306	10001143-3	Árbitro Principal	2027-10-10
306	10001610-9	Juez de Línea	2027-10-10
306	10001678-8	Juez de Línea	2027-10-10
306	10001236-7	Árbitro Asistente	2027-10-10
306	10001801-2	VAR	2027-10-10
307	10001035-6	Árbitro Principal	2027-10-10
307	10001337-1	Juez de Línea	2027-10-10
307	10001596-K	Juez de Línea	2027-10-10
307	10001975-2	Árbitro Asistente	2027-10-10
307	10001651-6	VAR	2027-10-10
308	10001473-4	Árbitro Principal	2027-10-08
308	10001410-6	Juez de Línea	2027-10-08
308	10001557-9	Juez de Línea	2027-10-08
308	10001959-0	Árbitro Asistente	2027-10-08
308	10001702-4	VAR	2027-10-08
309	10001647-8	Árbitro Principal	2027-10-09
309	10001391-6	Juez de Línea	2027-10-09
309	10001612-5	Juez de Línea	2027-10-09
309	10001977-9	Árbitro Asistente	2027-10-09
309	10001407-6	VAR	2027-10-09
310	10001411-4	Árbitro Principal	2027-10-09
310	10001682-6	Juez de Línea	2027-10-09
310	10001809-8	Juez de Línea	2027-10-09
310	10001934-5	Árbitro Asistente	2027-10-09
310	10001931-0	VAR	2027-10-09
311	10001773-3	Árbitro Principal	2027-10-16
311	10001538-2	Juez de Línea	2027-10-16
311	10001977-9	Juez de Línea	2027-10-16
311	10001337-1	Árbitro Asistente	2027-10-16
311	10001942-6	VAR	2027-10-16
312	10001035-6	Árbitro Principal	2027-10-17
312	10001094-1	Juez de Línea	2027-10-17
312	10001596-K	Juez de Línea	2027-10-17
312	10001959-0	Árbitro Asistente	2027-10-17
312	10001157-3	VAR	2027-10-17
313	10001060-7	Árbitro Principal	2027-10-17
313	10001736-9	Juez de Línea	2027-10-17
313	10001975-2	Juez de Línea	2027-10-17
313	10001030-5	Árbitro Asistente	2027-10-17
313	10001073-9	VAR	2027-10-17
314	10001107-7	Árbitro Principal	2027-10-16
314	10001391-6	Juez de Línea	2027-10-16
314	10001701-6	Juez de Línea	2027-10-16
314	10001655-9	Árbitro Asistente	2027-10-16
314	10001370-3	VAR	2027-10-16
315	10001283-9	Árbitro Principal	2027-10-15
315	10001143-3	Juez de Línea	2027-10-15
315	10001557-9	Juez de Línea	2027-10-15
315	10001615-K	Árbitro Asistente	2027-10-15
315	10001535-8	VAR	2027-10-15
316	10001612-5	Árbitro Principal	2027-10-16
316	10001111-5	Juez de Línea	2027-10-16
316	10001850-0	Juez de Línea	2027-10-16
316	10001873-K	Árbitro Asistente	2027-10-16
316	10001236-7	VAR	2027-10-16
317	10001638-9	Árbitro Principal	2027-10-15
317	10001375-4	Juez de Línea	2027-10-15
317	10001702-4	Juez de Línea	2027-10-15
317	10001347-9	Árbitro Asistente	2027-10-15
317	10001473-4	VAR	2027-10-15
318	10001084-4	Árbitro Principal	2027-10-17
318	10001529-3	Juez de Línea	2027-10-17
318	10001849-7	Juez de Línea	2027-10-17
318	10001700-8	Árbitro Asistente	2027-10-17
318	10001241-3	VAR	2027-10-17
319	10001104-2	Árbitro Principal	2027-10-16
319	10001298-7	Juez de Línea	2027-10-16
319	10001362-2	Juez de Línea	2027-10-16
319	10001647-8	Árbitro Asistente	2027-10-16
319	10001525-0	VAR	2027-10-16
320	10001367-3	Árbitro Principal	2027-10-17
320	10001051-8	Juez de Línea	2027-10-17
320	10001819-5	Juez de Línea	2027-10-17
320	10001678-8	Árbitro Asistente	2027-10-17
320	10001389-4	VAR	2027-10-17
321	10001111-5	Árbitro Principal	2027-10-22
321	10001538-2	Juez de Línea	2027-10-22
321	10001701-6	Juez de Línea	2027-10-22
321	10001678-8	Árbitro Asistente	2027-10-22
321	10001407-6	VAR	2027-10-22
322	10001107-7	Árbitro Principal	2027-10-23
322	10001788-1	Juez de Línea	2027-10-23
322	10001809-8	Juez de Línea	2027-10-23
322	10001638-9	Árbitro Asistente	2027-10-23
322	10001367-3	VAR	2027-10-23
323	10001091-7	Árbitro Principal	2027-10-24
323	10001931-0	Juez de Línea	2027-10-24
323	10001959-0	Juez de Línea	2027-10-24
323	10001651-6	Árbitro Asistente	2027-10-24
323	10001143-3	VAR	2027-10-24
324	10001337-1	Árbitro Principal	2027-10-23
324	10001473-4	Juez de Línea	2027-10-23
324	10001525-0	Juez de Línea	2027-10-23
324	10001104-2	Árbitro Asistente	2027-10-23
324	10001773-3	VAR	2027-10-23
325	10001819-5	Árbitro Principal	2027-10-24
325	10001045-3	Juez de Línea	2027-10-24
325	10001682-6	Juez de Línea	2027-10-24
325	10001347-9	Árbitro Asistente	2027-10-24
325	10001892-6	VAR	2027-10-24
326	10001283-9	Árbitro Principal	2027-10-22
326	10001783-0	Juez de Línea	2027-10-22
326	10001849-7	Juez de Línea	2027-10-22
326	10001399-1	Árbitro Asistente	2027-10-22
326	10001612-5	VAR	2027-10-22
327	10001273-1	Árbitro Principal	2027-10-24
327	10001063-1	Juez de Línea	2027-10-24
327	10001101-8	Juez de Línea	2027-10-24
327	10001635-4	Árbitro Asistente	2027-10-24
327	10001924-8	VAR	2027-10-24
328	10001241-3	Árbitro Principal	2027-10-23
328	10001391-6	Juez de Línea	2027-10-23
328	10001864-0	Juez de Línea	2027-10-23
328	10001529-3	Árbitro Asistente	2027-10-23
328	10001934-5	VAR	2027-10-23
329	10001702-4	Árbitro Principal	2027-10-23
329	10001051-8	Juez de Línea	2027-10-23
329	10001736-9	Juez de Línea	2027-10-23
329	10001035-6	Árbitro Asistente	2027-10-23
329	10001610-9	VAR	2027-10-23
330	10001375-4	Árbitro Principal	2027-10-24
330	10001624-9	Juez de Línea	2027-10-24
330	10001647-8	Juez de Línea	2027-10-24
330	10001094-1	Árbitro Asistente	2027-10-24
330	10001370-3	VAR	2027-10-24
331	10001060-7	Árbitro Principal	2027-10-30
331	10001347-9	Juez de Línea	2027-10-30
331	10001651-6	Juez de Línea	2027-10-30
331	10001682-6	Árbitro Asistente	2027-10-30
331	10001273-1	VAR	2027-10-30
332	10001104-2	Árbitro Principal	2027-10-30
332	10001045-3	Juez de Línea	2027-10-30
332	10001389-4	Juez de Línea	2027-10-30
332	10001535-8	Árbitro Asistente	2027-10-30
332	10001030-5	VAR	2027-10-30
333	10001638-9	Árbitro Principal	2027-10-31
333	10001236-7	Juez de Línea	2027-10-31
333	10001954-K	Juez de Línea	2027-10-31
333	10001819-5	Árbitro Asistente	2027-10-31
333	10001647-8	VAR	2027-10-31
334	10001892-6	Árbitro Principal	2027-10-29
334	10001035-6	Juez de Línea	2027-10-29
334	10001655-9	Juez de Línea	2027-10-29
334	10001337-1	Árbitro Asistente	2027-10-29
334	10001358-4	VAR	2027-10-29
335	10001241-3	Árbitro Principal	2027-10-31
335	10001101-8	Juez de Línea	2027-10-31
335	10001610-9	Juez de Línea	2027-10-31
335	10001773-3	Árbitro Asistente	2027-10-31
335	10001612-5	VAR	2027-10-31
336	10001977-9	Árbitro Principal	2027-10-30
336	10001063-1	Juez de Línea	2027-10-30
336	10001525-0	Juez de Línea	2027-10-30
336	10001557-9	Árbitro Asistente	2027-10-30
336	10001934-5	VAR	2027-10-30
337	10001678-8	Árbitro Principal	2027-10-31
337	10001596-K	Juez de Línea	2027-10-31
337	10001788-1	Juez de Línea	2027-10-31
337	10001624-9	Árbitro Asistente	2027-10-31
337	10001850-0	VAR	2027-10-31
338	10001091-7	Árbitro Principal	2027-10-31
338	10001367-3	Juez de Línea	2027-10-31
338	10001909-4	Juez de Línea	2027-10-31
338	10001073-9	Árbitro Asistente	2027-10-31
338	10001801-2	VAR	2027-10-31
339	10001942-6	Árbitro Principal	2027-10-29
339	10001410-6	Juez de Línea	2027-10-29
339	10001615-K	Juez de Línea	2027-10-29
339	10001370-3	Árbitro Asistente	2027-10-29
339	10001529-3	VAR	2027-10-29
340	10001157-3	Árbitro Principal	2027-10-30
340	10001017-8	Juez de Línea	2027-10-30
340	10001298-7	Juez de Línea	2027-10-30
340	10001931-0	Árbitro Asistente	2027-10-30
340	10001111-5	VAR	2027-10-30
341	10001241-3	Árbitro Principal	2027-11-05
341	10001529-3	Juez de Línea	2027-11-05
341	10001892-6	Juez de Línea	2027-11-05
341	10001107-7	Árbitro Asistente	2027-11-05
341	10001612-5	VAR	2027-11-05
342	10001819-5	Árbitro Principal	2027-11-05
342	10001473-4	Juez de Línea	2027-11-05
342	10001801-2	Juez de Línea	2027-11-05
342	10001975-2	Árbitro Asistente	2027-11-05
342	10001736-9	VAR	2027-11-05
343	10001977-9	Árbitro Principal	2027-11-06
343	10001638-9	Juez de Línea	2027-11-06
343	10001788-1	Juez de Línea	2027-11-06
343	10001236-7	Árbitro Asistente	2027-11-06
343	10001358-4	VAR	2027-11-06
344	10001157-3	Árbitro Principal	2027-11-06
344	10001557-9	Juez de Línea	2027-11-06
344	10001682-6	Juez de Línea	2027-11-06
344	10001783-0	Árbitro Asistente	2027-11-06
344	10001700-8	VAR	2027-11-06
345	10001283-9	Árbitro Principal	2027-11-07
345	10001525-0	Juez de Línea	2027-11-07
345	10001610-9	Juez de Línea	2027-11-07
345	10001934-5	Árbitro Asistente	2027-11-07
345	10001850-0	VAR	2027-11-07
346	10001959-0	Árbitro Principal	2027-11-07
346	10001635-4	Juez de Línea	2027-11-07
346	10001706-7	Juez de Línea	2027-11-07
346	10001051-8	Árbitro Asistente	2027-11-07
346	10001647-8	VAR	2027-11-07
347	10001094-1	Árbitro Principal	2027-11-07
347	10001655-9	Juez de Línea	2027-11-07
347	10001942-6	Juez de Línea	2027-11-07
347	10001407-6	Árbitro Asistente	2027-11-07
347	10001411-4	VAR	2027-11-07
348	10001101-8	Árbitro Principal	2027-11-06
348	10001337-1	Juez de Línea	2027-11-06
348	10001651-6	Juez de Línea	2027-11-06
348	10001063-1	Árbitro Asistente	2027-11-06
348	10001773-3	VAR	2027-11-06
349	10001060-7	Árbitro Principal	2027-11-07
349	10001460-2	Juez de Línea	2027-11-07
349	10001538-2	Juez de Línea	2027-11-07
349	10001954-K	Árbitro Asistente	2027-11-07
349	10001596-K	VAR	2027-11-07
350	10001367-3	Árbitro Principal	2027-11-06
350	10001298-7	Juez de Línea	2027-11-06
350	10001399-1	Juez de Línea	2027-11-06
350	10001091-7	Árbitro Asistente	2027-11-06
350	10001045-3	VAR	2027-11-06
351	10001347-9	Árbitro Principal	2027-11-21
351	10001051-8	Juez de Línea	2027-11-21
351	10001678-8	Juez de Línea	2027-11-21
351	10001959-0	Árbitro Asistente	2027-11-21
351	10001411-4	VAR	2027-11-21
352	10001236-7	Árbitro Principal	2027-11-19
352	10001073-9	Juez de Línea	2027-11-19
352	10001615-K	Juez de Línea	2027-11-19
352	10001399-1	Árbitro Asistente	2027-11-19
352	10001624-9	VAR	2027-11-19
353	10001375-4	Árbitro Principal	2027-11-21
353	10001612-5	Juez de Línea	2027-11-21
353	10001864-0	Juez de Línea	2027-11-21
353	10001030-5	Árbitro Asistente	2027-11-21
353	10001975-2	VAR	2027-11-21
354	10001977-9	Árbitro Principal	2027-11-20
354	10001063-1	Juez de Línea	2027-11-20
354	10001931-0	Juez de Línea	2027-11-20
354	10001557-9	Árbitro Asistente	2027-11-20
354	10001954-K	VAR	2027-11-20
355	10001473-4	Árbitro Principal	2027-11-20
355	10001788-1	Juez de Línea	2027-11-20
355	10001892-6	Juez de Línea	2027-11-20
355	10001700-8	Árbitro Asistente	2027-11-20
355	10001362-2	VAR	2027-11-20
356	10001358-4	Árbitro Principal	2027-11-19
356	10001538-2	Juez de Línea	2027-11-19
356	10001647-8	Juez de Línea	2027-11-19
356	10001060-7	Árbitro Asistente	2027-11-19
356	10001610-9	VAR	2027-11-19
357	10001651-6	Árbitro Principal	2027-11-21
357	10001391-6	Juez de Línea	2027-11-21
357	10001702-4	Juez de Línea	2027-11-21
357	10001337-1	Árbitro Asistente	2027-11-21
357	10001241-3	VAR	2027-11-21
358	10001084-4	Árbitro Principal	2027-11-20
358	10001101-8	Juez de Línea	2027-11-20
358	10001934-5	Juez de Línea	2027-11-20
358	10001111-5	Árbitro Asistente	2027-11-20
358	10001552-8	VAR	2027-11-20
359	10001091-7	Árbitro Principal	2027-11-21
359	10001638-9	Juez de Línea	2027-11-21
359	10001655-9	Juez de Línea	2027-11-21
359	10001635-4	Árbitro Asistente	2027-11-21
359	10001460-2	VAR	2027-11-21
360	10001283-9	Árbitro Principal	2027-11-20
360	10001143-3	Juez de Línea	2027-11-20
360	10001706-7	Juez de Línea	2027-11-20
360	10001389-4	Árbitro Asistente	2027-11-20
360	10001370-3	VAR	2027-11-20
361	10001273-1	Árbitro Principal	2027-11-28
361	10001017-8	Juez de Línea	2027-11-28
361	10001060-7	Juez de Línea	2027-11-28
361	10001849-7	Árbitro Asistente	2027-11-28
361	10001647-8	VAR	2027-11-28
362	10001624-9	Árbitro Principal	2027-11-27
362	10001655-9	Juez de Línea	2027-11-27
362	10001864-0	Juez de Línea	2027-11-27
362	10001552-8	Árbitro Asistente	2027-11-27
362	10001596-K	VAR	2027-11-27
363	10001347-9	Árbitro Principal	2027-11-26
363	10001529-3	Juez de Línea	2027-11-26
363	10001819-5	Juez de Línea	2027-11-26
363	10001801-2	Árbitro Asistente	2027-11-26
363	10001298-7	VAR	2027-11-26
364	10001934-5	Árbitro Principal	2027-11-28
364	10001615-K	Juez de Línea	2027-11-28
364	10001788-1	Juez de Línea	2027-11-28
364	10001045-3	Árbitro Asistente	2027-11-28
364	10001892-6	VAR	2027-11-28
365	10001612-5	Árbitro Principal	2027-11-27
365	10001391-6	Juez de Línea	2027-11-27
365	10001702-4	Juez de Línea	2027-11-27
365	10001375-4	Árbitro Asistente	2027-11-27
365	10001367-3	VAR	2027-11-27
366	10001809-8	Árbitro Principal	2027-11-28
366	10001236-7	Juez de Línea	2027-11-28
366	10001610-9	Juez de Línea	2027-11-28
366	10001358-4	Árbitro Asistente	2027-11-28
366	10001638-9	VAR	2027-11-28
367	10001030-5	Árbitro Principal	2027-11-27
367	10001873-K	Juez de Línea	2027-11-27
367	10001909-4	Juez de Línea	2027-11-27
367	10001084-4	Árbitro Asistente	2027-11-27
367	10001701-6	VAR	2027-11-27
368	10001241-3	Árbitro Principal	2027-11-27
368	10001104-2	Juez de Línea	2027-11-27
368	10001977-9	Juez de Línea	2027-11-27
368	10001091-7	Árbitro Asistente	2027-11-27
368	10001035-6	VAR	2027-11-27
369	10001850-0	Árbitro Principal	2027-11-28
369	10001063-1	Juez de Línea	2027-11-28
369	10001736-9	Juez de Línea	2027-11-28
369	10001362-2	Árbitro Asistente	2027-11-28
369	10001370-3	VAR	2027-11-28
370	10001111-5	Árbitro Principal	2027-11-26
370	10001411-4	Juez de Línea	2027-11-26
370	10001700-8	Juez de Línea	2027-11-26
370	10001157-3	Árbitro Asistente	2027-11-26
370	10001535-8	VAR	2027-11-26
371	10001030-5	Árbitro Principal	2027-12-04
371	10001236-7	Juez de Línea	2027-12-04
371	10001375-4	Juez de Línea	2027-12-04
371	10001849-7	Árbitro Asistente	2027-12-04
371	10001410-6	VAR	2027-12-04
372	10001977-9	Árbitro Principal	2027-12-05
372	10001241-3	Juez de Línea	2027-12-05
372	10001615-K	Juez de Línea	2027-12-05
372	10001959-0	Árbitro Asistente	2027-12-05
372	10001473-4	VAR	2027-12-05
373	10001101-8	Árbitro Principal	2027-12-04
373	10001610-9	Juez de Línea	2027-12-04
373	10001736-9	Juez de Línea	2027-12-04
373	10001535-8	Árbitro Asistente	2027-12-04
373	10001525-0	VAR	2027-12-04
374	10001700-8	Árbitro Principal	2027-12-04
374	10001701-6	Juez de Línea	2027-12-04
374	10001864-0	Juez de Línea	2027-12-04
374	10001104-2	Árbitro Asistente	2027-12-04
374	10001084-4	VAR	2027-12-04
375	10001809-8	Árbitro Principal	2027-12-03
375	10001399-1	Juez de Línea	2027-12-03
375	10001596-K	Juez de Línea	2027-12-03
375	10001060-7	Árbitro Asistente	2027-12-03
375	10001017-8	VAR	2027-12-03
376	10001143-3	Árbitro Principal	2027-12-05
376	10001557-9	Juez de Línea	2027-12-05
376	10001624-9	Juez de Línea	2027-12-05
376	10001647-8	Árbitro Asistente	2027-12-05
376	10001111-5	VAR	2027-12-05
377	10001370-3	Árbitro Principal	2027-12-04
377	10001273-1	Juez de Línea	2027-12-04
377	10001529-3	Juez de Línea	2027-12-04
377	10001283-9	Árbitro Asistente	2027-12-04
377	10001706-7	VAR	2027-12-04
378	10001783-0	Árbitro Principal	2027-12-05
378	10001035-6	Juez de Línea	2027-12-05
378	10001682-6	Juez de Línea	2027-12-05
378	10001678-8	Árbitro Asistente	2027-12-05
378	10001063-1	VAR	2027-12-05
379	10001367-3	Árbitro Principal	2027-12-05
379	10001635-4	Juez de Línea	2027-12-05
379	10001850-0	Juez de Línea	2027-12-05
379	10001407-6	Árbitro Asistente	2027-12-05
379	10001892-6	VAR	2027-12-05
380	10001773-3	Árbitro Principal	2027-12-03
380	10001107-7	Juez de Línea	2027-12-03
380	10001347-9	Juez de Línea	2027-12-03
380	10001873-K	Árbitro Asistente	2027-12-03
380	10001651-6	VAR	2027-12-03
\.


--
-- TOC entry 3968 (class 0 OID 27858)
-- Dependencies: 225
-- Data for Name: dirigente; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dirigente (rut_pasaporte, id_equipo, cargo, fecha_inicio, fecha_fin) FROM stdin;
10001025-9	1	presidente	1999-03-28	2028-02-19
10001844-6	1	vicepresidente	1987-07-06	2027-10-12
10001921-3	1	tesorero	1976-07-08	2030-09-26
10001449-1	1	secretario	1941-03-14	2026-10-18
10001684-2	1	dirigente	1955-06-12	2028-04-19
10001719-9	1	dirigente	1962-04-04	2008-04-29
10001735-0	1	dirigente	1972-06-29	2005-01-15
10001935-3	1	dirigente	1989-03-02	2024-07-26
10001306-1	2	presidente	1998-07-25	2031-02-12
10001614-1	2	vicepresidente	1978-02-21	2030-01-14
10001611-7	2	tesorero	1997-07-18	2030-11-25
10001468-8	2	secretario	1957-12-02	2031-09-06
10001007-0	2	dirigente	1959-09-08	2017-05-28
10001066-6	2	dirigente	1999-12-03	2007-01-18
10001080-1	2	dirigente	1940-08-17	2019-10-27
10001216-2	2	dirigente	1989-07-11	2011-02-14
10001275-8	2	dirigente	1991-11-15	2012-11-20
10001930-2	2	dirigente	1970-05-07	2006-08-21
10001261-8	3	presidente	1981-09-01	2028-04-19
10001200-6	3	vicepresidente	1952-07-14	2027-05-24
10001927-2	3	tesorero	1991-01-08	2027-07-02
10001152-2	3	secretario	1986-09-09	2029-04-04
10001001-1	3	dirigente	1998-10-31	2011-06-06
10001277-4	3	dirigente	1947-09-18	2007-05-25
10001508-0	3	dirigente	1988-05-26	2015-02-19
10001709-1	4	presidente	1962-01-02	2028-10-06
10001592-7	4	vicepresidente	1988-05-02	2029-10-28
10001416-5	4	tesorero	1944-11-15	2028-10-19
10001436-K	4	secretario	1978-10-15	2029-03-03
10001085-2	4	dirigente	1943-08-19	2003-03-27
10001315-0	4	dirigente	1962-11-16	2015-01-02
10001528-5	4	dirigente	1980-12-19	2004-01-15
10001211-1	5	presidente	1985-01-19	2030-08-11
10001217-0	5	vicepresidente	1993-07-21	2031-10-30
10001349-5	5	tesorero	1968-05-04	2028-02-11
10001255-3	5	secretario	1947-05-12	2031-10-31
10001144-1	5	dirigente	1968-04-27	2026-08-21
10001194-8	5	dirigente	1959-04-05	2010-06-14
10001256-1	5	dirigente	1950-04-01	2030-03-12
10001319-3	5	dirigente	1957-12-03	2028-08-01
10001495-5	5	dirigente	1985-08-04	2024-03-31
10001728-8	5	dirigente	1990-06-01	2024-11-18
10001781-4	5	dirigente	1958-09-19	2026-04-22
10001820-9	5	dirigente	1980-04-06	2022-01-16
10001335-5	6	presidente	1954-04-24	2029-02-12
10001023-2	6	vicepresidente	1940-08-01	2031-07-12
10001215-4	6	tesorero	1981-12-18	2029-04-16
10001161-1	6	secretario	1960-05-14	2026-11-17
10001031-3	6	dirigente	1951-04-24	2030-06-08
10001732-6	6	dirigente	1959-06-24	2021-11-06
10001767-9	6	dirigente	1949-08-29	2008-10-04
10001905-1	6	dirigente	1988-11-09	2024-05-12
10001926-4	6	dirigente	1966-04-21	2023-05-22
10001324-K	7	presidente	1962-02-26	2029-10-19
10001509-9	7	vicepresidente	1970-08-18	2027-10-18
10001086-0	7	tesorero	1972-07-11	2028-05-04
10001891-8	7	secretario	1977-08-26	2029-02-10
10001287-1	7	dirigente	1989-03-28	2021-09-18
10001440-8	7	dirigente	1945-09-22	2010-01-22
10001566-8	7	dirigente	1980-11-26	2022-05-05
10001674-5	7	dirigente	1990-12-28	2007-05-22
10001800-4	7	dirigente	1988-06-14	2028-11-14
10001884-5	7	dirigente	1984-01-25	2000-11-28
10001904-3	7	dirigente	1980-04-20	2009-05-30
10001274-K	8	presidente	1967-11-10	2027-07-12
10001808-K	8	vicepresidente	1957-11-21	2029-11-08
10001137-9	8	tesorero	1986-03-19	2028-03-26
10001848-9	8	secretario	1957-04-09	2030-03-28
10001040-2	8	dirigente	1953-09-05	2031-12-24
10001049-6	8	dirigente	1959-10-27	2017-01-08
10001351-7	8	dirigente	1949-12-13	2000-09-04
10001444-0	8	dirigente	1981-03-26	2022-07-21
10001660-5	8	dirigente	1950-09-23	2009-12-27
10001705-9	8	dirigente	1945-10-19	2030-08-09
10001720-2	8	dirigente	1956-02-14	2009-02-13
10001914-0	9	presidente	1961-06-24	2030-12-03
10001581-1	9	vicepresidente	1951-01-26	2030-04-05
10001713-K	9	tesorero	1946-06-21	2027-11-04
10001484-K	9	secretario	1993-03-29	2029-06-27
10001263-4	9	dirigente	1948-12-10	2031-08-05
10001393-2	9	dirigente	1963-03-05	2024-01-20
10001513-7	9	dirigente	1950-05-24	2006-12-30
10001595-1	9	dirigente	1949-07-18	2026-02-25
10001729-6	9	dirigente	1967-10-15	2000-03-28
10001937-K	9	dirigente	1951-02-25	2009-07-07
10001260-K	10	presidente	1980-05-15	2029-11-02
10001818-7	10	vicepresidente	1978-02-13	2027-05-26
10001772-5	10	tesorero	1962-05-28	2030-04-13
10001345-2	10	secretario	1980-03-25	2027-12-10
10001075-5	10	dirigente	1967-03-25	2023-12-27
10001112-3	10	dirigente	1976-03-12	2010-08-28
10001191-3	10	dirigente	1953-02-15	2031-05-20
10001490-4	10	dirigente	1939-05-21	2029-06-17
10001756-3	10	dirigente	1948-10-22	2011-01-22
10001878-0	11	presidente	1944-11-03	2029-02-04
10001043-7	11	vicepresidente	1954-12-07	2026-12-12
10001816-0	11	tesorero	1970-06-16	2030-10-19
10001515-3	11	secretario	1948-09-22	2029-02-24
10001021-6	11	dirigente	1956-03-28	2007-11-18
10001123-9	11	dirigente	1982-10-09	2029-07-08
10001299-5	11	dirigente	1993-11-02	2005-02-28
10001575-7	11	dirigente	1979-01-28	2002-07-10
10001626-5	11	dirigente	1965-06-12	2030-06-23
10001688-5	11	dirigente	1984-08-15	2029-02-03
10001964-7	12	presidente	1940-05-19	2029-05-06
10001782-2	12	vicepresidente	1964-05-27	2027-08-17
10001955-8	12	tesorero	1980-08-17	2030-04-25
10001148-4	12	secretario	1953-03-09	2029-07-30
10001167-0	12	dirigente	1986-10-18	2014-05-16
10001184-0	12	dirigente	1982-11-25	2011-08-03
10001587-0	12	dirigente	1955-02-23	2014-06-16
10001877-2	12	dirigente	1943-02-27	2004-06-05
10001941-8	12	dirigente	1980-03-25	2030-09-22
10001599-4	13	presidente	1996-04-26	2027-11-07
10001229-4	13	vicepresidente	1986-04-30	2031-04-17
10001687-7	13	tesorero	1978-06-13	2030-03-25
10001533-1	13	secretario	1957-10-23	2030-05-18
10001003-8	13	dirigente	1978-12-31	2019-04-04
10001087-9	13	dirigente	1963-04-27	2006-02-28
10001350-9	13	dirigente	1985-01-20	2003-02-04
10001523-4	13	dirigente	1957-02-03	2007-05-30
10001661-3	13	dirigente	1994-02-04	2023-07-10
10001739-3	13	dirigente	1971-08-30	2023-07-31
10001856-K	13	dirigente	1950-04-21	2006-04-22
10001590-0	14	presidente	1983-04-05	2028-06-30
10001861-6	14	vicepresidente	1999-01-16	2029-03-14
10001900-0	14	tesorero	1952-06-28	2029-10-24
10001183-2	14	secretario	1951-10-12	2030-01-24
10001474-2	14	dirigente	1952-12-03	2004-12-14
10001804-7	14	dirigente	1989-10-01	2008-06-30
10001933-7	14	dirigente	1980-08-17	2001-07-11
10001641-9	15	presidente	1940-09-30	2030-04-06
10001220-0	15	vicepresidente	1956-03-03	2027-05-01
10001881-0	15	tesorero	1985-11-22	2030-03-13
10001048-8	15	secretario	1952-10-20	2031-02-07
10001245-6	15	dirigente	1979-06-08	2001-11-17
10001323-1	15	dirigente	1990-12-22	2022-10-07
10001494-7	15	dirigente	1941-07-29	2015-04-30
10001546-3	15	dirigente	1960-08-09	2017-01-12
10001726-1	15	dirigente	1981-12-31	2010-03-16
10001799-7	15	dirigente	1962-02-11	2017-02-16
10001834-9	15	dirigente	1991-06-16	2008-01-21
10001896-9	15	dirigente	1971-10-18	2018-06-20
10001670-2	16	presidente	1995-08-28	2028-02-14
10001951-5	16	vicepresidente	1983-06-18	2030-07-18
10001637-0	16	tesorero	1943-11-27	2031-02-13
10001364-9	16	secretario	1944-02-06	2031-02-11
10001113-1	16	dirigente	1949-07-10	2024-03-21
10001409-2	16	dirigente	1977-03-15	2017-05-30
10001432-7	16	dirigente	1959-01-01	2013-08-27
10001551-K	16	dirigente	1998-04-18	2012-02-27
10001623-0	16	dirigente	1964-07-23	2011-03-01
10001912-4	16	dirigente	1987-12-08	2021-11-17
10001707-5	17	presidente	1958-02-11	2026-10-14
10001082-8	17	vicepresidente	1961-04-14	2029-11-28
10001390-8	17	tesorero	1984-02-17	2030-06-04
10001836-5	17	secretario	1970-02-16	2027-02-21
10001132-8	17	dirigente	1982-02-02	2016-01-23
10001134-4	17	dirigente	1984-12-13	2019-04-18
10001247-2	17	dirigente	1954-07-10	2031-04-16
10001568-4	17	dirigente	1945-02-15	2020-12-07
10001580-3	17	dirigente	1997-01-29	2012-04-13
10001625-7	17	dirigente	1946-11-03	2025-08-29
10001727-K	17	dirigente	1970-06-07	2018-11-15
10001737-7	17	dirigente	1989-06-16	2030-03-25
10001642-7	18	presidente	1990-05-22	2031-06-22
10001052-6	18	vicepresidente	1976-10-29	2030-03-25
10001424-6	18	tesorero	1951-10-05	2029-02-28
10001685-0	18	secretario	1939-10-25	2028-01-15
10001032-1	18	dirigente	1981-02-02	2018-09-21
10001036-4	18	dirigente	1962-03-14	2019-01-13
10001747-4	18	dirigente	1985-03-13	2011-01-29
10001507-2	19	presidente	1952-02-27	2030-08-03
10001039-9	19	vicepresidente	1990-07-27	2028-12-29
10001922-1	19	tesorero	1975-12-10	2029-03-09
10001011-9	19	secretario	1941-01-12	2029-05-03
10001202-2	19	dirigente	1996-04-16	2012-07-05
10001427-0	19	dirigente	1973-08-27	2007-01-16
10001613-3	19	dirigente	1961-02-20	2018-02-07
10001840-3	20	presidente	1998-08-11	2031-06-24
10001958-2	20	vicepresidente	1973-04-20	2031-11-22
10001860-8	20	tesorero	1953-12-25	2028-02-18
10001639-7	20	secretario	1997-12-17	2028-09-11
10001033-K	20	dirigente	1949-03-24	2015-08-21
10001208-1	20	dirigente	1989-01-23	2010-12-18
10001408-4	20	dirigente	1982-01-08	2004-08-26
10001454-8	20	dirigente	1962-11-07	2011-10-08
10001462-9	20	dirigente	1952-09-16	2026-09-26
10001532-3	20	dirigente	1943-05-20	2008-03-18
10001571-4	20	dirigente	1959-08-04	2025-01-14
10001401-7	21	presidente	1948-05-07	2031-12-15
10001539-0	21	vicepresidente	1989-06-26	2029-05-02
10001874-8	21	tesorero	1943-06-05	2030-11-05
10001103-4	21	secretario	1987-10-14	2026-11-17
10001238-3	21	dirigente	1998-02-19	2002-02-14
10001286-3	21	dirigente	1964-05-30	2012-08-28
10001378-9	21	dirigente	1939-02-25	2030-09-15
10001514-5	21	dirigente	1969-09-21	2000-04-11
10001578-1	21	dirigente	1943-05-20	2031-01-19
10001622-2	21	dirigente	1955-10-02	2001-06-08
10001645-1	21	dirigente	1973-08-25	2017-04-16
10001464-5	22	presidente	1958-10-15	2027-03-11
10001252-9	22	vicepresidente	1955-08-12	2029-01-29
10001558-7	22	tesorero	1974-07-13	2028-08-27
10001616-8	22	secretario	1966-08-22	2031-12-13
10001158-1	22	dirigente	1978-02-07	2027-06-19
10001417-3	22	dirigente	1939-10-30	2017-06-30
10001579-K	22	dirigente	1969-09-13	2013-07-08
10001174-3	23	presidente	1991-09-15	2028-07-02
10001598-6	23	vicepresidente	1945-07-28	2029-07-22
10001668-0	23	tesorero	1953-12-21	2031-12-03
10001004-6	23	secretario	1941-06-29	2026-11-24
10001026-7	23	dirigente	1968-10-19	2025-05-26
10001180-8	23	dirigente	1998-03-16	2026-04-02
10001419-K	23	dirigente	1989-10-27	2015-05-19
10001456-4	23	dirigente	1945-06-28	2025-10-24
10001765-2	23	dirigente	1946-07-01	2010-09-04
10001838-1	23	dirigente	1983-09-29	2022-11-09
10001662-1	24	presidente	1950-01-12	2027-03-03
10001470-K	24	vicepresidente	1997-04-29	2030-07-10
10001248-0	24	tesorero	1979-09-06	2026-12-19
10001826-8	24	secretario	1965-02-22	2031-07-31
10001067-4	24	dirigente	1946-12-22	2005-03-01
10001567-6	24	dirigente	1997-06-23	2000-11-24
10001582-K	24	dirigente	1973-09-29	2029-02-11
10001593-5	24	dirigente	1956-10-26	2005-06-14
10001656-7	24	dirigente	1947-10-11	2008-11-04
10001384-3	25	presidente	1976-05-11	2029-05-06
10001423-8	25	vicepresidente	1945-07-10	2029-12-16
10001885-3	25	tesorero	1994-03-23	2030-02-06
10001597-8	25	secretario	1944-06-27	2028-08-20
10001015-1	25	dirigente	1940-08-22	2015-09-19
10001130-1	25	dirigente	1981-03-02	2003-07-12
10001348-7	25	dirigente	1980-12-24	2003-04-12
10001402-5	25	dirigente	1957-01-09	2014-09-03
10001504-8	25	dirigente	1949-10-16	2006-04-19
10001517-K	25	dirigente	1978-02-14	2004-03-23
10001734-2	25	dirigente	1972-03-23	2006-06-12
10001704-0	26	presidente	1957-03-11	2026-12-11
10001547-1	26	vicepresidente	1945-04-10	2030-06-08
10001805-5	26	tesorero	1991-09-07	2030-04-16
10001947-7	26	secretario	1949-07-19	2029-06-02
10001005-4	26	dirigente	1968-08-15	2002-06-11
10001176-K	26	dirigente	1972-07-14	2007-04-10
10001204-9	26	dirigente	1941-01-09	2002-03-05
10001320-7	26	dirigente	1977-09-06	2028-05-11
10001583-8	26	dirigente	1999-01-11	2021-02-14
10001694-K	26	dirigente	1986-01-26	2001-11-11
10001853-5	27	presidente	1970-03-23	2030-10-09
10001119-0	27	vicepresidente	1965-09-29	2028-11-06
10001483-1	27	tesorero	1952-07-19	2030-07-22
10001467-K	27	secretario	1987-04-30	2028-03-31
10001122-0	27	dirigente	1955-02-15	2031-02-19
10001591-9	27	dirigente	1986-07-24	2008-05-28
10001601-K	27	dirigente	1952-06-22	2008-12-20
10001741-5	27	dirigente	1939-02-23	2023-04-11
10001829-2	27	dirigente	1984-04-28	2006-10-20
10001303-7	28	presidente	1956-01-02	2029-11-30
10001780-6	28	vicepresidente	1979-11-14	2031-04-19
10001182-4	28	tesorero	1953-05-17	2031-02-06
10001386-K	28	secretario	1992-12-19	2026-11-10
10001232-4	28	dirigente	1940-01-03	2015-12-17
10001340-1	28	dirigente	1958-03-07	2024-06-22
10001680-K	28	dirigente	1983-08-07	2021-08-07
10001710-5	28	dirigente	1962-09-15	2007-02-19
10001845-4	28	dirigente	1976-04-18	2031-10-27
10001869-1	28	dirigente	1971-12-23	2029-01-14
10001967-1	28	dirigente	1940-10-09	2019-03-08
10001589-7	29	presidente	1960-01-17	2031-08-19
10001785-7	29	vicepresidente	1944-08-08	2030-12-06
10001962-0	29	tesorero	1970-07-27	2031-09-22
10001543-9	29	secretario	1987-12-23	2028-10-26
10001109-3	29	dirigente	1950-02-07	2019-08-21
10001117-4	29	dirigente	1939-10-20	2013-06-25
10001253-7	29	dirigente	1979-08-30	2020-02-03
10001406-8	29	dirigente	1948-03-30	2013-02-04
10001447-5	29	dirigente	1942-10-27	2016-08-08
10001699-0	29	dirigente	1945-12-28	2026-04-27
10001757-1	29	dirigente	1996-10-14	2011-08-16
10001815-2	29	dirigente	1953-02-18	2023-03-12
10001359-2	30	presidente	1985-03-20	2027-03-31
10001550-1	30	vicepresidente	1986-07-15	2029-05-31
10001672-9	30	tesorero	1977-05-06	2030-08-28
10001172-7	30	secretario	1975-05-02	2027-01-15
10001027-5	30	dirigente	1961-09-12	2014-12-05
10001188-3	30	dirigente	1939-03-20	2013-09-07
10001212-K	30	dirigente	1987-08-18	2031-08-17
10001234-0	30	dirigente	1994-01-26	2010-11-24
10001240-5	30	dirigente	1960-08-17	2011-03-31
10001357-6	30	dirigente	1949-05-28	2001-12-13
10001717-2	30	dirigente	1945-04-19	2009-01-16
10001983-3	30	dirigente	1971-05-01	2019-06-28
10001029-1	31	presidente	1968-03-16	2029-02-26
10001034-8	31	vicepresidente	1989-04-04	2030-10-29
10001446-7	31	tesorero	1973-01-16	2028-12-20
10001369-K	31	secretario	1997-06-24	2029-11-12
10001124-7	31	dirigente	1942-08-26	2009-11-17
10001155-7	31	dirigente	1956-12-15	2022-02-20
10001179-4	31	dirigente	1999-07-04	2011-01-31
10001187-5	31	dirigente	1949-07-14	2006-06-14
10001225-1	31	dirigente	1993-08-09	2004-08-20
10001628-1	31	dirigente	1987-10-17	2015-08-24
10001740-7	31	dirigente	1971-02-18	2021-09-15
10001814-4	31	dirigente	1944-02-26	2019-03-28
10001136-0	32	presidente	1969-12-16	2031-01-20
10001485-8	32	vicepresidente	1964-06-18	2027-08-13
10001516-1	32	tesorero	1978-02-24	2031-10-05
10001496-3	32	secretario	1969-04-18	2031-03-10
10001022-4	32	dirigente	1941-10-30	2017-06-02
10001095-K	32	dirigente	1963-10-26	2015-02-28
10001100-K	32	dirigente	1990-06-15	2005-01-04
10001282-0	32	dirigente	1983-08-11	2023-02-05
10001418-1	32	dirigente	1997-11-10	2013-10-31
10001482-3	32	dirigente	1985-09-20	2026-07-16
10001692-3	32	dirigente	1944-03-09	2008-06-11
10001976-0	33	presidente	1965-02-10	2029-03-19
10001617-6	33	vicepresidente	1965-02-03	2031-07-27
10001842-K	33	tesorero	1988-05-30	2028-03-29
10001986-8	33	secretario	1972-02-08	2030-02-15
10001098-4	33	dirigente	1994-09-04	2012-03-07
10001305-3	33	dirigente	1954-10-06	2026-07-18
10001333-9	33	dirigente	1963-01-19	2023-12-28
10001354-1	33	dirigente	1995-06-02	2017-09-01
10001383-5	33	dirigente	1986-11-04	2000-09-06
10001443-2	33	dirigente	1945-10-23	2009-05-23
10001918-3	33	dirigente	1947-09-04	2019-10-13
10001957-4	33	dirigente	1956-10-31	2012-10-16
10001631-1	34	presidente	1945-08-08	2031-10-17
10001442-4	34	vicepresidente	1957-09-24	2026-11-01
10001897-7	34	tesorero	1964-12-24	2031-01-02
10001681-8	34	secretario	1964-03-05	2028-03-22
10001016-K	34	dirigente	1943-09-19	2031-12-14
10001058-5	34	dirigente	1998-07-12	2025-08-05
10001099-2	34	dirigente	1942-06-03	2026-08-02
10001426-2	34	dirigente	1993-01-31	2008-03-09
10001636-2	34	dirigente	1979-10-25	2026-12-22
10001939-6	34	dirigente	1946-07-11	2003-06-07
10001813-6	35	presidente	1950-01-13	2027-02-13
10001519-6	35	vicepresidente	1942-10-24	2026-12-05
10001775-K	35	tesorero	1949-10-10	2028-04-01
10001794-6	35	secretario	1958-05-15	2030-02-10
10001116-6	35	dirigente	1958-04-03	2030-12-15
10001195-6	35	dirigente	1955-09-12	2021-11-19
10001201-4	35	dirigente	1981-07-23	2027-10-16
10001466-1	35	dirigente	1971-07-15	2024-04-29
10001563-3	35	dirigente	1981-03-20	2024-10-11
10001671-0	35	dirigente	1993-06-30	2011-10-27
10001689-3	35	dirigente	1975-06-15	2009-01-16
10001738-5	36	presidente	1952-12-02	2028-06-08
10001669-9	36	vicepresidente	1993-02-07	2028-03-21
10001230-8	36	tesorero	1984-03-04	2028-05-05
10001733-4	36	secretario	1995-02-06	2028-11-05
10001105-0	36	dirigente	1992-08-02	2010-10-18
10001168-9	36	dirigente	1965-10-14	2017-05-14
10001368-1	36	dirigente	1970-08-08	2015-01-21
10001510-2	36	dirigente	1990-05-21	2015-08-15
10001562-5	36	dirigente	1964-10-27	2014-09-15
10001584-6	36	dirigente	1988-12-03	2030-02-08
10001698-2	36	dirigente	1996-04-12	2007-09-13
10001928-0	36	dirigente	1994-06-06	2002-03-26
10001530-7	37	presidente	1978-11-11	2029-03-12
10001028-3	37	vicepresidente	1959-10-14	2031-06-16
10001361-4	37	tesorero	1948-06-09	2030-04-27
10001093-3	37	secretario	1948-12-29	2030-11-27
10001037-2	37	dirigente	1972-07-18	2011-07-19
10001536-6	37	dirigente	1977-06-05	2005-09-28
10001630-3	37	dirigente	1963-03-14	2021-06-26
10001759-8	37	dirigente	1983-03-01	2022-04-25
10001837-3	37	dirigente	1991-04-08	2012-01-08
10001929-9	37	dirigente	1997-11-27	2029-08-17
10001875-6	38	presidente	1967-06-23	2026-10-28
10001243-K	38	vicepresidente	1951-08-14	2028-02-02
10001755-5	38	tesorero	1995-09-04	2030-05-18
10001664-8	38	secretario	1944-05-14	2030-09-04
10001231-6	38	dirigente	1946-01-22	2013-08-04
10001249-9	38	dirigente	1989-08-19	2015-09-13
10001267-7	38	dirigente	1955-12-02	2021-06-25
10001435-1	38	dirigente	1983-05-02	2004-06-09
10001556-0	38	dirigente	1956-05-24	2006-06-19
10001603-6	38	dirigente	1954-03-08	2030-06-20
10001879-9	38	dirigente	1964-11-22	2007-09-24
10001784-9	39	presidente	1959-04-12	2030-05-26
10001472-6	39	vicepresidente	1985-02-07	2031-09-15
10001070-4	39	tesorero	1987-07-28	2029-12-11
10001657-5	39	secretario	1996-07-29	2031-12-18
10001156-5	39	dirigente	1962-06-12	2002-10-16
10001262-6	39	dirigente	1943-05-07	2019-12-02
10001430-0	39	dirigente	1943-12-15	2022-12-18
10001458-0	39	dirigente	1952-05-15	2013-07-18
10001648-6	39	dirigente	1972-05-31	2030-07-27
10001649-4	39	dirigente	1989-07-24	2003-07-24
10001278-2	40	presidente	1985-04-17	2028-04-14
10001588-9	40	vicepresidente	1996-08-05	2029-09-04
10001764-4	40	tesorero	1997-04-08	2029-09-19
10001663-K	40	secretario	1951-05-07	2028-01-03
10001047-K	40	dirigente	1969-12-17	2003-10-08
10001304-5	40	dirigente	1964-05-20	2003-06-08
10001763-6	40	dirigente	1949-08-14	2022-08-24
10001787-3	40	dirigente	1996-03-30	2019-07-08
10001851-9	40	dirigente	1984-03-16	2003-07-25
\.


--
-- TOC entry 3963 (class 0 OID 27786)
-- Dependencies: 220
-- Data for Name: equipo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.equipo (id_equipo, rut_equipo, nombre, direccion, correo, presidente, "división") FROM stdin;
7	60000049-7	Parí Saint-Germán	Av. Los Deportistas 178, Rancagua	contacto@parisaintgerman.cl	Esteban Beausejour Müller	A
8	60000056-K	Juvéntus Criolla	Av. Los Deportistas 191, Talca	contacto@juventuscriolla.cl	Ronaldo Güler Araya	A
1	60000007-1	El Eterno Campeón	Av. Marathon 5301, Macul	contacto@realmadrizfc.cl	ColoColo Cacique	A
2	60000014-4	La U	No tiene	contacto@barzacatalana.cl	Andrés Bello	A
3	60000021-7	ManU Deportivo	Av. Los Deportistas 126, Concepción	contacto@manudeportivo.cl	Lamine Martínez Vásquez	A
4	60000028-4	Liverpol Andino	Av. Los Deportistas 139, La Serena	contacto@liverpolandino.cl	Esteban Pulgar Dybala	A
5	60000035-7	Chelsea Sur	Av. Los Deportistas 152, Antofagasta	contacto@chelseasur.cl	Jean Isla Zidane	A
6	60000042-K	Bayern del Maule	Av. Los Deportistas 165, Temuco	contacto@bayerndelmaule.cl	Álvaro Carrasco Cortés	A
9	60000063-2	Inter Milano Sur	Av. Los Deportistas 204, Chillán	contacto@intermilanosur.cl	Pedri Rodri Isla	A
10	60000070-5	AC Miláñez	Av. Los Deportistas 217, Valdivia	contacto@acmilanez.cl	Vicente Beausejour Modric	A
11	60000077-2	El Velero	Av. Los Deportistas 230, Puerto Montt	contacto@atleticocolchagua.cl	Enzo Pérez Vidal	A
12	60000084-5	Dortmundo Amarillo	Av. Los Deportistas 243, Iquique	contacto@dortmundoamarillo.cl	Toni Suazo Castillo	A
13	60000091-8	Arsenal Cordillera	Av. Los Deportistas 256, Arica	contacto@arsenalcordillera.cl	Santino Vásquez Tapia	A
14	60000098-5	Tottenham Costero	Av. Los Deportistas 269, Copiapó	contacto@tottenhamcostero.cl	Rodrigo Zidane Díaz	A
15	60000105-1	Boca del Puerto	Av. Los Deportistas 282, Osorno	contacto@bocadelpuerto.cl	Julian Bellingham Kroos	A
16	60000112-4	River Plateado	Av. Los Deportistas 295, Curicó	contacto@riverplateado.cl	Kylian Vásquez Sánchez	A
17	60000119-1	Peñarol Andino	Av. Los Deportistas 308, Los Ángeles	contacto@penarolandino.cl	Alexis Aránguiz Díaz	A
18	60000126-4	Santos Laguna Chico	Av. Los Deportistas 321, Coyhaique	contacto@santoslagunachico.cl	Santiago Arias Álvarez	A
19	60000133-7	Flamenco Rojo	Av. Los Deportistas 334, Punta Arenas	contacto@flamencorojo.cl	Rodrigo Messi Alvarez	A
20	60000140-K	Corinthios FC	Av. Los Deportistas 347, San Antonio	contacto@corinthiosfc.cl	Romelu Silva Ronaldo	A
21	60000147-7	DCC UC	Vicuña Mackenna 4860	contacto@ajaxdelsur.cl	Felipe Arias Lewandowski	B
22	60000154-K	Porto Alegre Andino	Av. Los Deportistas 373, Valparaíso	contacto@portoalegreandino.cl	Gavi Flores Mendoza	B
23	60000161-2	Benfíquez SC	Av. Los Deportistas 386, Concepción	contacto@benfiquezsc.cl	Marcelo Müller Mbappe	B
24	60000168-K	Sevílla Norte	Av. Los Deportistas 399, La Serena	contacto@sevillanorte.cl	Ronaldo Rojas Messi	B
25	60000175-2	Napolés Criollo	Av. Los Deportistas 412, Antofagasta	contacto@napolescriollo.cl	Gustavo Muñoz Dybala	B
26	60000182-5	Marsella del Pacífico	Av. Los Deportistas 425, Temuco	contacto@marselladelpacifico.cl	Gonzalo Sepúlveda Pulgar	B
27	60000189-2	Lyonés Andino	Av. Los Deportistas 438, Rancagua	contacto@lyonesandino.cl	Jaime Muñoz Bellingham	B
28	60000196-5	Zenit del Cobre	Av. Los Deportistas 451, Talca	contacto@zenitdelcobre.cl	Hernán Yamal Torres	B
29	60000203-1	Shakhtiar Minero	Av. Los Deportistas 464, Chillán	contacto@shakhtiarminero.cl	Cristopher Martínez Jara	B
30	60000210-4	Celtic Andino	Av. Los Deportistas 477, Valdivia	contacto@celticandino.cl	Bastián Soto Gómez	B
31	60000217-1	Rangers del Sur	Av. Los Deportistas 490, Puerto Montt	contacto@rangersdelsur.cl	Mauricio Gutiérrez Espinoza	B
32	60000224-4	Fenerbahce Criollo	Av. Los Deportistas 503, Iquique	contacto@fenerbahcecriollo.cl	Mauricio Zidane Vergara	B
33	60000231-7	Galatasarái Andino	Av. Los Deportistas 516, Arica	contacto@galatasaraiandino.cl	Diego Mbappe Pulgar	B
34	60000238-4	Olympiacos del Maule	Av. Los Deportistas 529, Copiapó	contacto@olympiacosdelmaule.cl	Mauricio Alvarez Benzema	B
35	60000245-7	PSV Cordillera	Av. Los Deportistas 542, Osorno	contacto@psvcordillera.cl	Carlos Neuer Riquelme	B
36	60000252-K	Feyenoord Sureño	Av. Los Deportistas 555, Curicó	contacto@feyenoordsureno.cl	Diego Herrera Morales	B
37	60000259-7	Estrella Roja Andina	Av. Los Deportistas 568, Los Ángeles	contacto@estrellarojaandina.cl	Gary Bustos Rojas	B
38	60000266-K	Dínamo del Norte	Av. Los Deportistas 581, Coyhaique	contacto@dinamodelnorte.cl	Vicente Bellingham Gutiérrez	B
39	60000273-2	Spártak Cordillerano	Av. Los Deportistas 594, Punta Arenas	contacto@spartakcordillerano.cl	Daniel Rivera Gutiérrez	B
40	60000280-5	Mónaco Andino	Av. Los Deportistas 607, San Antonio	contacto@monacoandino.cl	Gabriel Benzema Soto	B
\.


--
-- TOC entry 3964 (class 0 OID 27796)
-- Dependencies: 221
-- Data for Name: equipo_campeonato; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.equipo_campeonato (id_equipo, id_campeonato) FROM stdin;
\.


--
-- TOC entry 3970 (class 0 OID 27875)
-- Dependencies: 227
-- Data for Name: estadio; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.estadio (id_estadio, nombre, direccion, capacidad, tipo_superficie) FROM stdin;
1	Estadio Carlos Dittborn	Av. Comandante San Martín 400, Arica	15968	pasto natural
2	Estadio Tierra de Campeones	Av. Balmaceda 1300, Iquique	12000	pasto natural
3	Estadio Regional Calvo y Bascuñán	Av. Argentina 1800, Antofagasta	16380	pasto natural
4	Estadio Luis Valenzuela Hermosilla	Av. Circunvalación 1200, Copiapó	12000	pasto natural
5	Estadio La Portada	Av. Amunátegui 1350, La Serena	20624	pasto natural
6	Estadio Elías Figueroa Brander	Subida Cerro Placeres 2050, Valparaíso	22000	pasto natural
7	Estadio Nacional Julio Martínez Prádanos	Av. Grecia 2001, Ñuñoa, Santiago	48665	pasto natural
8	Estadio El Teniente	Av. Cachapoal 950, Rancagua	14000	pasto natural
9	Estadio Fiscal de Talca	2 Norte 1450, Talca	12000	pasto natural
10	Estadio Nelson Oyarzún Arenas	Av. Collín 1250, Chillán	10000	pasto natural
11	Estadio Ester Roa Rebolledo	Av. Roosevelt 1900, Concepción	25000	pasto natural
12	Estadio Germán Becker	Av. Alemania 0660, Temuco	18000	pasto natural
13	Estadio Parque Municipal de Valdivia	Av. Ramón Picarte 1200, Valdivia	8000	pasto sintético
14	Estadio Chinquihue	Av. Presidente Ibáñez 1400, Puerto Montt	14200	pasto natural
15	Estadio Regional de Coyhaique	Av. Baquedano 500, Coyhaique	5000	pasto sintético
16	Estadio Fiscal de Punta Arenas	Av. Bulnes 1050, Punta Arenas	8000	pasto sintético
17	Estadio San Carlos de Apoquindo	Av. Las Flores 13.400, Las Condes, Santiago	20000	pasto natural
18	Estadio La Ruca	Av. Pedro Fontova 4001, Huechuraba, Santiago	3500	pasto natural
19	Estadio San Joaquín	Av. Vicuña Mackenna 4860, San Joaquín, Santiago	5000	pasto sintético
20	Estadio Santa Laura - Universidad SEK	Av. Independencia 667, Independencia, Santiago	9500	pasto natural
\.


--
-- TOC entry 3971 (class 0 OID 27883)
-- Dependencies: 228
-- Data for Name: estadio_local; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.estadio_local (id_equipo, id_estadio) FROM stdin;
1	1
1	5
1	12
1	16
2	2
2	14
2	15
2	17
3	1
3	2
3	3
3	9
3	11
3	16
4	4
4	5
4	9
4	11
5	4
5	5
5	12
5	17
6	6
6	7
6	10
6	13
6	16
7	3
7	6
7	7
7	13
7	20
8	8
8	9
8	11
8	20
9	1
9	9
9	11
9	15
10	2
10	7
10	8
10	10
10	13
10	20
11	4
11	7
11	9
11	11
11	17
12	5
12	9
12	12
12	14
12	16
12	17
13	1
13	4
13	10
13	13
13	17
14	2
14	4
14	12
14	14
15	3
15	4
15	8
15	14
15	15
15	17
16	12
16	15
16	16
16	17
17	5
17	9
17	11
17	13
17	17
17	20
18	7
18	13
18	14
18	16
18	17
18	20
19	1
19	2
19	10
19	11
20	2
20	6
20	14
20	16
21	3
21	5
21	6
21	13
21	16
21	17
22	4
22	9
22	10
22	14
22	16
22	17
23	2
23	5
23	7
23	9
23	11
24	6
24	9
24	10
24	16
25	2
25	7
25	15
25	17
26	2
26	4
26	6
26	8
26	10
26	17
27	1
27	2
27	5
27	8
27	9
27	15
28	3
28	10
28	11
28	16
29	4
29	8
29	10
29	11
30	3
30	9
30	12
30	13
31	11
31	12
31	13
31	17
32	3
32	5
32	8
32	10
32	14
32	17
33	2
33	7
33	10
33	11
33	15
33	20
34	5
34	9
34	10
34	16
35	5
35	9
35	13
35	17
35	20
36	1
36	2
36	13
36	20
37	2
37	3
37	6
37	7
37	15
38	1
38	8
38	9
38	12
38	16
38	17
39	10
39	11
39	15
39	17
39	18
40	6
40	15
40	16
40	19
\.


--
-- TOC entry 3978 (class 0 OID 27977)
-- Dependencies: 235
-- Data for Name: gol; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.gol (id_gol, id_partido, rut_jugador, minuto) FROM stdin;
\.


--
-- TOC entry 3983 (class 0 OID 28020)
-- Dependencies: 240
-- Data for Name: integrante_tribunal; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.integrante_tribunal (rut_pasaporte, id_sala, cargo) FROM stdin;
10001989-2	1	Presidente
10001990-6	1	Secretario
10001991-4	1	Abogado
10001992-2	2	Presidente
10001993-0	2	Secretario
10001994-9	2	Abogado
10001995-7	3	Presidente
10001996-5	3	Secretario
10001997-3	3	Abogado
10001998-1	4	Presidente
10001999-K	4	Secretario
10002000-9	4	Abogado
\.


--
-- TOC entry 3975 (class 0 OID 27945)
-- Dependencies: 232
-- Data for Name: participacion_partido_cuerpo_tecnico; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.participacion_partido_cuerpo_tecnico (id_partido, rut_pasaporte, rol_en_partido) FROM stdin;
\.


--
-- TOC entry 3974 (class 0 OID 27929)
-- Dependencies: 231
-- Data for Name: participacion_partido_jugador; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.participacion_partido_jugador (id_partido, rut_pasaporte, condicion) FROM stdin;
\.


--
-- TOC entry 3973 (class 0 OID 27899)
-- Dependencies: 230
-- Data for Name: partido; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.partido (id_partido, id_campeonato, numero_fecha, id_equipo_local, id_equipo_visita, id_estadio, fecha_hora, publico_asistente, estado) FROM stdin;
1	327	1	1	40	1	2027-01-31 12:00:00	0	Programado
2	327	1	2	39	2	2027-01-30 17:30:00	0	Programado
3	327	1	3	18	3	2027-01-29 20:00:00	0	Programado
4	327	1	4	17	4	2027-01-31 17:30:00	0	Programado
5	327	1	5	16	5	2027-01-31 17:30:00	0	Programado
6	327	1	6	15	6	2027-01-30 17:30:00	0	Programado
7	327	1	7	14	7	2027-01-29 20:00:00	0	Programado
8	327	1	8	13	8	2027-01-30 12:00:00	0	Programado
9	327	1	9	12	9	2027-01-31 12:00:00	0	Programado
10	327	1	10	11	10	2027-01-30 12:00:00	0	Programado
11	327	2	39	1	18	2027-02-07 17:30:00	0	Programado
12	327	2	18	40	20	2027-02-07 12:00:00	0	Programado
13	327	2	17	2	17	2027-02-06 17:30:00	0	Programado
14	327	2	16	3	16	2027-02-05 20:00:00	0	Programado
15	327	2	15	4	15	2027-02-05 20:00:00	0	Programado
16	327	2	14	5	14	2027-02-07 12:00:00	0	Programado
17	327	2	13	6	13	2027-02-07 17:30:00	0	Programado
18	327	2	12	7	12	2027-02-06 12:00:00	0	Programado
19	327	2	11	8	11	2027-02-06 12:00:00	0	Programado
20	327	2	10	9	10	2027-02-06 17:30:00	0	Programado
21	327	3	1	18	1	2027-02-12 20:00:00	0	Programado
22	327	3	39	17	18	2027-02-14 17:30:00	0	Programado
23	327	3	40	16	19	2027-02-14 12:00:00	0	Programado
24	327	3	2	15	2	2027-02-13 17:30:00	0	Programado
25	327	3	3	14	3	2027-02-13 12:00:00	0	Programado
26	327	3	4	13	4	2027-02-14 17:30:00	0	Programado
27	327	3	5	12	5	2027-02-12 20:00:00	0	Programado
28	327	3	6	11	6	2027-02-14 12:00:00	0	Programado
29	327	3	7	10	7	2027-02-13 17:30:00	0	Programado
30	327	3	8	9	8	2027-02-13 12:00:00	0	Programado
31	327	4	17	1	17	2027-02-28 12:00:00	0	Programado
32	327	4	16	18	16	2027-02-27 17:30:00	0	Programado
33	327	4	15	39	15	2027-02-28 17:30:00	0	Programado
34	327	4	14	40	14	2027-02-28 12:00:00	0	Programado
35	327	4	13	2	13	2027-02-27 12:00:00	0	Programado
36	327	4	12	3	12	2027-02-26 20:00:00	0	Programado
37	327	4	11	4	11	2027-02-27 12:00:00	0	Programado
38	327	4	10	5	10	2027-02-26 20:00:00	0	Programado
39	327	4	9	6	9	2027-02-28 17:30:00	0	Programado
40	327	4	8	7	8	2027-02-27 17:30:00	0	Programado
41	327	5	1	16	1	2027-03-07 17:30:00	0	Programado
42	327	5	17	15	17	2027-03-06 12:00:00	0	Programado
43	327	5	18	14	20	2027-03-05 20:00:00	0	Programado
44	327	5	39	13	18	2027-03-06 17:30:00	0	Programado
45	327	5	40	12	19	2027-03-07 17:30:00	0	Programado
46	327	5	2	11	2	2027-03-06 17:30:00	0	Programado
47	327	5	3	10	3	2027-03-07 12:00:00	0	Programado
48	327	5	4	9	4	2027-03-06 12:00:00	0	Programado
49	327	5	5	8	5	2027-03-05 20:00:00	0	Programado
50	327	5	6	7	6	2027-03-07 12:00:00	0	Programado
51	327	6	15	1	15	2027-03-12 20:00:00	0	Programado
52	327	6	14	16	14	2027-03-14 12:00:00	0	Programado
53	327	6	13	17	13	2027-03-13 12:00:00	0	Programado
54	327	6	12	18	12	2027-03-13 17:30:00	0	Programado
55	327	6	11	39	11	2027-03-13 17:30:00	0	Programado
56	327	6	10	40	10	2027-03-14 17:30:00	0	Programado
57	327	6	9	2	9	2027-03-13 12:00:00	0	Programado
58	327	6	8	3	8	2027-03-14 17:30:00	0	Programado
59	327	6	7	4	7	2027-03-12 20:00:00	0	Programado
60	327	6	6	5	6	2027-03-14 12:00:00	0	Programado
61	327	7	1	14	1	2027-03-21 12:00:00	0	Programado
62	327	7	15	13	15	2027-03-21 12:00:00	0	Programado
63	327	7	16	12	16	2027-03-19 20:00:00	0	Programado
64	327	7	17	11	17	2027-03-21 17:30:00	0	Programado
65	327	7	18	10	20	2027-03-21 17:30:00	0	Programado
66	327	7	39	9	18	2027-03-20 12:00:00	0	Programado
67	327	7	40	8	19	2027-03-19 20:00:00	0	Programado
68	327	7	2	7	2	2027-03-20 17:30:00	0	Programado
69	327	7	3	6	3	2027-03-20 17:30:00	0	Programado
70	327	7	4	5	4	2027-03-20 12:00:00	0	Programado
71	327	8	13	1	13	2027-03-26 20:00:00	0	Programado
72	327	8	12	14	12	2027-03-28 12:00:00	0	Programado
73	327	8	11	15	11	2027-03-27 12:00:00	0	Programado
74	327	8	10	16	10	2027-03-28 17:30:00	0	Programado
75	327	8	9	17	9	2027-03-27 12:00:00	0	Programado
76	327	8	8	18	8	2027-03-28 17:30:00	0	Programado
77	327	8	7	39	7	2027-03-27 17:30:00	0	Programado
78	327	8	6	40	6	2027-03-28 12:00:00	0	Programado
79	327	8	5	2	5	2027-03-27 17:30:00	0	Programado
80	327	8	4	3	4	2027-03-26 20:00:00	0	Programado
81	327	9	1	12	1	2027-04-03 12:00:00	0	Programado
82	327	9	13	11	13	2027-04-03 17:30:00	0	Programado
83	327	9	14	10	14	2027-04-04 12:00:00	0	Programado
84	327	9	15	9	15	2027-04-04 17:30:00	0	Programado
85	327	9	16	8	16	2027-04-03 17:30:00	0	Programado
86	327	9	17	7	17	2027-04-03 12:00:00	0	Programado
87	327	9	18	6	20	2027-04-02 20:00:00	0	Programado
88	327	9	39	5	18	2027-04-04 17:30:00	0	Programado
89	327	9	40	4	19	2027-04-04 12:00:00	0	Programado
90	327	9	2	3	2	2027-04-02 20:00:00	0	Programado
91	327	10	11	1	11	2027-04-11 12:00:00	0	Programado
92	327	10	10	12	10	2027-04-09 20:00:00	0	Programado
93	327	10	9	13	9	2027-04-10 17:30:00	0	Programado
94	327	10	8	14	8	2027-04-10 12:00:00	0	Programado
95	327	10	7	15	7	2027-04-11 17:30:00	0	Programado
96	327	10	6	16	6	2027-04-09 20:00:00	0	Programado
97	327	10	5	17	5	2027-04-10 17:30:00	0	Programado
98	327	10	4	18	4	2027-04-10 12:00:00	0	Programado
99	327	10	3	39	3	2027-04-11 12:00:00	0	Programado
100	327	10	2	40	2	2027-04-11 17:30:00	0	Programado
101	327	11	1	10	1	2027-04-16 20:00:00	0	Programado
102	327	11	11	9	11	2027-04-16 20:00:00	0	Programado
103	327	11	12	8	12	2027-04-18 12:00:00	0	Programado
104	327	11	13	7	13	2027-04-18 12:00:00	0	Programado
105	327	11	14	6	14	2027-04-17 17:30:00	0	Programado
106	327	11	15	5	15	2027-04-18 17:30:00	0	Programado
107	327	11	16	4	16	2027-04-17 12:00:00	0	Programado
108	327	11	17	3	17	2027-04-18 17:30:00	0	Programado
109	327	11	18	2	20	2027-04-17 17:30:00	0	Programado
110	327	11	39	40	18	2027-04-17 12:00:00	0	Programado
111	327	12	9	1	9	2027-04-30 20:00:00	0	Programado
112	327	12	8	10	8	2027-05-02 17:30:00	0	Programado
113	327	12	7	11	7	2027-05-01 12:00:00	0	Programado
114	327	12	6	12	6	2027-05-02 17:30:00	0	Programado
115	327	12	5	13	5	2027-05-02 12:00:00	0	Programado
116	327	12	4	14	4	2027-05-01 17:30:00	0	Programado
117	327	12	3	15	3	2027-05-01 12:00:00	0	Programado
118	327	12	2	16	2	2027-05-01 17:30:00	0	Programado
119	327	12	40	17	19	2027-04-30 20:00:00	0	Programado
120	327	12	39	18	18	2027-05-02 12:00:00	0	Programado
121	327	13	1	8	1	2027-05-08 12:00:00	0	Programado
122	327	13	9	7	9	2027-05-08 17:30:00	0	Programado
123	327	13	10	6	10	2027-05-09 17:30:00	0	Programado
124	327	13	11	5	11	2027-05-09 12:00:00	0	Programado
125	327	13	12	4	12	2027-05-09 17:30:00	0	Programado
126	327	13	13	3	13	2027-05-07 20:00:00	0	Programado
127	327	13	14	2	14	2027-05-08 17:30:00	0	Programado
128	327	13	15	40	15	2027-05-07 20:00:00	0	Programado
129	327	13	16	39	16	2027-05-09 12:00:00	0	Programado
130	327	13	17	18	17	2027-05-08 12:00:00	0	Programado
131	327	14	7	1	7	2027-05-16 12:00:00	0	Programado
132	327	14	6	8	6	2027-05-16 12:00:00	0	Programado
133	327	14	5	9	5	2027-05-15 17:30:00	0	Programado
134	327	14	4	10	4	2027-05-14 20:00:00	0	Programado
135	327	14	3	11	3	2027-05-16 17:30:00	0	Programado
136	327	14	2	12	2	2027-05-15 17:30:00	0	Programado
137	327	14	40	13	19	2027-05-14 20:00:00	0	Programado
138	327	14	39	14	18	2027-05-16 17:30:00	0	Programado
139	327	14	18	15	20	2027-05-15 12:00:00	0	Programado
140	327	14	17	16	17	2027-05-15 12:00:00	0	Programado
141	327	15	1	6	1	2027-05-21 20:00:00	0	Programado
142	327	15	7	5	7	2027-05-22 17:30:00	0	Programado
143	327	15	8	4	8	2027-05-21 20:00:00	0	Programado
144	327	15	9	3	9	2027-05-23 12:00:00	0	Programado
145	327	15	10	2	10	2027-05-23 17:30:00	0	Programado
146	327	15	11	40	11	2027-05-22 12:00:00	0	Programado
147	327	15	12	39	12	2027-05-23 12:00:00	0	Programado
148	327	15	13	18	13	2027-05-22 17:30:00	0	Programado
149	327	15	14	17	14	2027-05-23 17:30:00	0	Programado
150	327	15	15	16	15	2027-05-22 12:00:00	0	Programado
151	327	16	5	1	5	2027-05-30 12:00:00	0	Programado
152	327	16	4	6	4	2027-05-28 20:00:00	0	Programado
153	327	16	3	7	3	2027-05-29 17:30:00	0	Programado
154	327	16	2	8	2	2027-05-30 17:30:00	0	Programado
155	327	16	40	9	19	2027-05-28 20:00:00	0	Programado
156	327	16	39	10	18	2027-05-29 17:30:00	0	Programado
157	327	16	18	11	20	2027-05-30 12:00:00	0	Programado
158	327	16	17	12	17	2027-05-29 12:00:00	0	Programado
159	327	16	16	13	16	2027-05-30 17:30:00	0	Programado
160	327	16	15	14	15	2027-05-29 12:00:00	0	Programado
161	327	17	1	4	1	2027-06-06 17:30:00	0	Programado
162	327	17	5	3	5	2027-06-04 20:00:00	0	Programado
163	327	17	6	2	6	2027-06-04 20:00:00	0	Programado
164	327	17	7	40	7	2027-06-05 12:00:00	0	Programado
165	327	17	8	39	8	2027-06-05 17:30:00	0	Programado
166	327	17	9	18	9	2027-06-06 17:30:00	0	Programado
167	327	17	10	17	10	2027-06-06 12:00:00	0	Programado
168	327	17	11	16	11	2027-06-06 12:00:00	0	Programado
169	327	17	12	15	12	2027-06-05 17:30:00	0	Programado
170	327	17	13	14	13	2027-06-05 12:00:00	0	Programado
171	327	18	3	1	3	2027-06-13 17:30:00	0	Programado
172	327	18	2	4	2	2027-06-12 12:00:00	0	Programado
173	327	18	40	5	19	2027-06-11 20:00:00	0	Programado
174	327	18	39	6	18	2027-06-12 17:30:00	0	Programado
175	327	18	18	7	20	2027-06-12 12:00:00	0	Programado
176	327	18	17	8	17	2027-06-13 12:00:00	0	Programado
177	327	18	16	9	16	2027-06-13 12:00:00	0	Programado
178	327	18	15	10	15	2027-06-12 17:30:00	0	Programado
179	327	18	14	11	14	2027-06-13 17:30:00	0	Programado
180	327	18	13	12	13	2027-06-11 20:00:00	0	Programado
181	327	19	1	2	1	2027-06-18 20:00:00	0	Programado
182	327	19	3	40	3	2027-06-20 12:00:00	0	Programado
183	327	19	4	39	4	2027-06-19 17:30:00	0	Programado
184	327	19	5	18	5	2027-06-20 17:30:00	0	Programado
185	327	19	6	17	6	2027-06-18 20:00:00	0	Programado
186	327	19	7	16	7	2027-06-19 17:30:00	0	Programado
187	327	19	8	15	8	2027-06-20 17:30:00	0	Programado
188	327	19	9	14	9	2027-06-19 12:00:00	0	Programado
189	327	19	10	13	10	2027-06-19 12:00:00	0	Programado
190	327	19	11	12	11	2027-06-20 12:00:00	0	Programado
191	327	20	40	1	19	2027-06-26 12:00:00	0	Programado
192	327	20	39	2	18	2027-06-27 17:30:00	0	Programado
193	327	20	18	3	20	2027-06-27 12:00:00	0	Programado
194	327	20	17	4	17	2027-06-25 20:00:00	0	Programado
195	327	20	16	5	16	2027-06-26 17:30:00	0	Programado
196	327	20	15	6	15	2027-06-26 12:00:00	0	Programado
197	327	20	14	7	14	2027-06-27 12:00:00	0	Programado
198	327	20	13	8	13	2027-06-26 17:30:00	0	Programado
199	327	20	12	9	12	2027-06-27 17:30:00	0	Programado
200	327	20	11	10	11	2027-06-25 20:00:00	0	Programado
201	327	21	1	39	1	2027-07-04 17:30:00	0	Programado
202	327	21	40	18	19	2027-07-03 12:00:00	0	Programado
203	327	21	2	17	2	2027-07-04 17:30:00	0	Programado
204	327	21	3	16	3	2027-07-03 12:00:00	0	Programado
205	327	21	4	15	4	2027-07-02 20:00:00	0	Programado
206	327	21	5	14	5	2027-07-02 20:00:00	0	Programado
207	327	21	6	13	6	2027-07-04 12:00:00	0	Programado
208	327	21	7	12	7	2027-07-04 12:00:00	0	Programado
209	327	21	8	11	8	2027-07-03 17:30:00	0	Programado
210	327	21	9	10	9	2027-07-03 17:30:00	0	Programado
211	327	22	18	1	20	2027-07-18 12:00:00	0	Programado
212	327	22	17	39	17	2027-07-18 12:00:00	0	Programado
213	327	22	16	40	16	2027-07-16 20:00:00	0	Programado
214	327	22	15	2	15	2027-07-17 17:30:00	0	Programado
215	327	22	14	3	14	2027-07-16 20:00:00	0	Programado
216	327	22	13	4	13	2027-07-17 17:30:00	0	Programado
217	327	22	12	5	12	2027-07-17 12:00:00	0	Programado
218	327	22	11	6	11	2027-07-18 17:30:00	0	Programado
219	327	22	10	7	10	2027-07-18 17:30:00	0	Programado
220	327	22	9	8	9	2027-07-17 12:00:00	0	Programado
221	327	23	1	17	1	2027-07-23 20:00:00	0	Programado
222	327	23	18	16	20	2027-07-25 17:30:00	0	Programado
223	327	23	39	15	18	2027-07-24 17:30:00	0	Programado
224	327	23	40	14	19	2027-07-25 12:00:00	0	Programado
225	327	23	2	13	2	2027-07-25 12:00:00	0	Programado
226	327	23	3	12	3	2027-07-24 12:00:00	0	Programado
227	327	23	4	11	4	2027-07-24 12:00:00	0	Programado
228	327	23	5	10	5	2027-07-24 17:30:00	0	Programado
229	327	23	6	9	6	2027-07-23 20:00:00	0	Programado
230	327	23	7	8	7	2027-07-25 17:30:00	0	Programado
231	327	24	16	1	16	2027-07-31 12:00:00	0	Programado
232	327	24	15	17	15	2027-07-31 12:00:00	0	Programado
233	327	24	14	18	14	2027-07-30 20:00:00	0	Programado
234	327	24	13	39	13	2027-08-01 12:00:00	0	Programado
235	327	24	12	40	12	2027-07-31 17:30:00	0	Programado
236	327	24	11	2	11	2027-07-30 20:00:00	0	Programado
237	327	24	10	3	10	2027-08-01 17:30:00	0	Programado
238	327	24	9	4	9	2027-07-31 17:30:00	0	Programado
239	327	24	8	5	8	2027-08-01 12:00:00	0	Programado
240	327	24	7	6	7	2027-08-01 17:30:00	0	Programado
241	327	25	1	15	1	2027-08-07 12:00:00	0	Programado
242	327	25	16	14	16	2027-08-06 20:00:00	0	Programado
243	327	25	17	13	17	2027-08-07 12:00:00	0	Programado
244	327	25	18	12	20	2027-08-06 20:00:00	0	Programado
245	327	25	39	11	18	2027-08-08 17:30:00	0	Programado
246	327	25	40	10	19	2027-08-08 17:30:00	0	Programado
247	327	25	2	9	2	2027-08-08 12:00:00	0	Programado
248	327	25	3	8	3	2027-08-07 17:30:00	0	Programado
249	327	25	4	7	4	2027-08-07 17:30:00	0	Programado
250	327	25	5	6	5	2027-08-08 12:00:00	0	Programado
251	327	26	14	1	14	2027-08-15 17:30:00	0	Programado
252	327	26	13	15	13	2027-08-13 20:00:00	0	Programado
253	327	26	12	16	12	2027-08-14 17:30:00	0	Programado
254	327	26	11	17	11	2027-08-14 12:00:00	0	Programado
255	327	26	10	18	10	2027-08-15 17:30:00	0	Programado
256	327	26	9	39	9	2027-08-14 12:00:00	0	Programado
257	327	26	8	40	8	2027-08-13 20:00:00	0	Programado
258	327	26	7	2	7	2027-08-14 17:30:00	0	Programado
259	327	26	6	3	6	2027-08-15 12:00:00	0	Programado
260	327	26	5	4	5	2027-08-15 12:00:00	0	Programado
261	327	27	1	13	1	2027-08-21 12:00:00	0	Programado
262	327	27	14	12	14	2027-08-22 12:00:00	0	Programado
263	327	27	15	11	15	2027-08-21 17:30:00	0	Programado
264	327	27	16	10	16	2027-08-20 20:00:00	0	Programado
265	327	27	17	9	17	2027-08-22 17:30:00	0	Programado
266	327	27	18	8	20	2027-08-21 12:00:00	0	Programado
267	327	27	39	7	18	2027-08-21 17:30:00	0	Programado
268	327	27	40	6	19	2027-08-22 12:00:00	0	Programado
269	327	27	2	5	2	2027-08-22 17:30:00	0	Programado
270	327	27	3	4	3	2027-08-20 20:00:00	0	Programado
271	327	28	12	1	12	2027-08-28 12:00:00	0	Programado
272	327	28	11	13	11	2027-08-28 17:30:00	0	Programado
273	327	28	10	14	10	2027-08-29 17:30:00	0	Programado
274	327	28	9	15	9	2027-08-28 12:00:00	0	Programado
275	327	28	8	16	8	2027-08-29 17:30:00	0	Programado
276	327	28	7	17	7	2027-08-28 17:30:00	0	Programado
277	327	28	6	18	6	2027-08-27 20:00:00	0	Programado
278	327	28	5	39	5	2027-08-29 12:00:00	0	Programado
279	327	28	4	40	4	2027-08-27 20:00:00	0	Programado
280	327	28	3	2	3	2027-08-29 12:00:00	0	Programado
281	327	29	1	11	1	2027-09-12 12:00:00	0	Programado
282	327	29	12	10	12	2027-09-10 20:00:00	0	Programado
283	327	29	13	9	13	2027-09-11 17:30:00	0	Programado
284	327	29	14	8	14	2027-09-12 17:30:00	0	Programado
285	327	29	15	7	15	2027-09-11 12:00:00	0	Programado
286	327	29	16	6	16	2027-09-11 17:30:00	0	Programado
287	327	29	17	5	17	2027-09-12 12:00:00	0	Programado
288	327	29	18	4	20	2027-09-12 17:30:00	0	Programado
289	327	29	39	3	18	2027-09-10 20:00:00	0	Programado
290	327	29	40	2	19	2027-09-11 12:00:00	0	Programado
291	327	30	10	1	10	2027-09-25 12:00:00	0	Programado
292	327	30	9	11	9	2027-09-24 20:00:00	0	Programado
293	327	30	8	12	8	2027-09-24 20:00:00	0	Programado
294	327	30	7	13	7	2027-09-25 12:00:00	0	Programado
295	327	30	6	14	6	2027-09-26 12:00:00	0	Programado
296	327	30	5	15	5	2027-09-26 12:00:00	0	Programado
297	327	30	4	16	4	2027-09-26 17:30:00	0	Programado
298	327	30	3	17	3	2027-09-25 17:30:00	0	Programado
299	327	30	2	18	2	2027-09-26 17:30:00	0	Programado
300	327	30	40	39	19	2027-09-25 17:30:00	0	Programado
301	327	31	1	9	1	2027-10-10 12:00:00	0	Programado
302	327	31	10	8	10	2027-10-10 17:30:00	0	Programado
303	327	31	11	7	11	2027-10-09 17:30:00	0	Programado
304	327	31	12	6	12	2027-10-08 20:00:00	0	Programado
305	327	31	13	5	13	2027-10-09 12:00:00	0	Programado
306	327	31	14	4	14	2027-10-10 17:30:00	0	Programado
307	327	31	15	3	15	2027-10-10 12:00:00	0	Programado
308	327	31	16	2	16	2027-10-08 20:00:00	0	Programado
309	327	31	17	40	17	2027-10-09 12:00:00	0	Programado
310	327	31	18	39	20	2027-10-09 17:30:00	0	Programado
311	327	32	8	1	8	2027-10-16 17:30:00	0	Programado
312	327	32	7	9	7	2027-10-17 17:30:00	0	Programado
313	327	32	6	10	6	2027-10-17 12:00:00	0	Programado
314	327	32	5	11	5	2027-10-16 17:30:00	0	Programado
315	327	32	4	12	4	2027-10-15 20:00:00	0	Programado
316	327	32	3	13	3	2027-10-16 12:00:00	0	Programado
317	327	32	2	14	2	2027-10-15 20:00:00	0	Programado
318	327	32	40	15	19	2027-10-17 17:30:00	0	Programado
319	327	32	39	16	18	2027-10-16 12:00:00	0	Programado
320	327	32	18	17	20	2027-10-17 12:00:00	0	Programado
321	327	33	1	7	1	2027-10-22 20:00:00	0	Programado
322	327	33	8	6	8	2027-10-23 17:30:00	0	Programado
323	327	33	9	5	9	2027-10-24 17:30:00	0	Programado
324	327	33	10	4	10	2027-10-23 12:00:00	0	Programado
325	327	33	11	3	11	2027-10-24 12:00:00	0	Programado
326	327	33	12	2	12	2027-10-22 20:00:00	0	Programado
327	327	33	13	40	13	2027-10-24 17:30:00	0	Programado
328	327	33	14	39	14	2027-10-23 12:00:00	0	Programado
329	327	33	15	18	15	2027-10-23 17:30:00	0	Programado
330	327	33	16	17	16	2027-10-24 12:00:00	0	Programado
331	327	34	6	1	6	2027-10-30 17:30:00	0	Programado
332	327	34	5	7	5	2027-10-30 12:00:00	0	Programado
333	327	34	4	8	4	2027-10-31 17:30:00	0	Programado
334	327	34	3	9	3	2027-10-29 20:00:00	0	Programado
335	327	34	2	10	2	2027-10-31 12:00:00	0	Programado
336	327	34	40	11	19	2027-10-30 12:00:00	0	Programado
337	327	34	39	12	18	2027-10-31 17:30:00	0	Programado
338	327	34	18	13	20	2027-10-31 12:00:00	0	Programado
339	327	34	17	14	17	2027-10-29 20:00:00	0	Programado
340	327	34	16	15	16	2027-10-30 17:30:00	0	Programado
341	327	35	1	5	1	2027-11-05 20:00:00	0	Programado
342	327	35	6	4	6	2027-11-05 20:00:00	0	Programado
343	327	35	7	3	7	2027-11-06 17:30:00	0	Programado
344	327	35	8	2	8	2027-11-06 12:00:00	0	Programado
345	327	35	9	40	9	2027-11-07 12:00:00	0	Programado
346	327	35	10	39	10	2027-11-07 17:30:00	0	Programado
347	327	35	11	18	11	2027-11-07 12:00:00	0	Programado
348	327	35	12	17	12	2027-11-06 17:30:00	0	Programado
349	327	35	13	16	13	2027-11-07 17:30:00	0	Programado
350	327	35	14	15	14	2027-11-06 12:00:00	0	Programado
351	327	36	4	1	4	2027-11-21 17:30:00	0	Programado
352	327	36	3	5	3	2027-11-19 20:00:00	0	Programado
353	327	36	2	6	2	2027-11-21 17:30:00	0	Programado
354	327	36	40	7	19	2027-11-20 17:30:00	0	Programado
355	327	36	39	8	18	2027-11-20 12:00:00	0	Programado
356	327	36	18	9	20	2027-11-19 20:00:00	0	Programado
357	327	36	17	10	17	2027-11-21 12:00:00	0	Programado
358	327	36	16	11	16	2027-11-20 12:00:00	0	Programado
359	327	36	15	12	15	2027-11-21 12:00:00	0	Programado
360	327	36	14	13	14	2027-11-20 17:30:00	0	Programado
361	327	37	1	3	1	2027-11-28 12:00:00	0	Programado
362	327	37	4	2	4	2027-11-27 12:00:00	0	Programado
363	327	37	5	40	5	2027-11-26 20:00:00	0	Programado
364	327	37	6	39	6	2027-11-28 12:00:00	0	Programado
365	327	37	7	18	7	2027-11-27 12:00:00	0	Programado
366	327	37	8	17	8	2027-11-28 17:30:00	0	Programado
367	327	37	9	16	9	2027-11-27 17:30:00	0	Programado
368	327	37	10	15	10	2027-11-27 17:30:00	0	Programado
369	327	37	11	14	11	2027-11-28 17:30:00	0	Programado
370	327	37	12	13	12	2027-11-26 20:00:00	0	Programado
371	327	38	2	1	2	2027-12-04 12:00:00	0	Programado
372	327	38	40	3	19	2027-12-05 12:00:00	0	Programado
373	327	38	39	4	18	2027-12-04 17:30:00	0	Programado
374	327	38	18	5	20	2027-12-04 12:00:00	0	Programado
375	327	38	17	6	17	2027-12-03 20:00:00	0	Programado
376	327	38	16	7	16	2027-12-05 12:00:00	0	Programado
377	327	38	15	8	15	2027-12-04 17:30:00	0	Programado
378	327	38	14	9	14	2027-12-05 17:30:00	0	Programado
379	327	38	13	10	13	2027-12-05 17:30:00	0	Programado
380	327	38	12	11	12	2027-12-03 20:00:00	0	Programado
\.


--
-- TOC entry 3965 (class 0 OID 27811)
-- Dependencies: 222
-- Data for Name: persona; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.persona (rut_pasaporte, nombre_completo, fecha_nacimiento, nacionalidad, telefono, email) FROM stdin;
10000001-6	Ezequiel 'Sanáguila' Messi Contreras	1979-04-20	Peruana	+56934597487	ezequiel.messi1@yahoo.com
10000002-4	Edinson 'Donmono' Soto Vásquez	1998-04-11	Francesa	+56929488604	edinson.soto2@yahoo.com
10000003-2	Gonzalo 'Ninja' Mendoza Hernández	1972-03-22	Chilena	+56918018767	gonzalo.mendoza3@yahoo.com
10000004-0	Rodrigo 'Masterpitón' Rodríguez Arias	1980-06-17	Argentina	+56921124824	rodrigo.rodriguez4@uca.cl
10000005-9	Alexis 'Megabambino' Tapia Castro	1985-11-08	Argentina	+56928610249	alexis.tapia5@puc.cl
10000006-7	Federico 'Superzorro' Salas González	1994-01-17	Peruana	+56965078866	federico.salas6@yahoo.com
10000007-5	Romelu 'Rinoceronte' Valdés Paredes	1982-11-19	Inglesa	+56954533864	romelu.valdes7@outlook.com
10000008-3	Guillermo 'Escorpión' Figueroa Di María	1979-07-08	Chilena	+56920925499	guillermo.figueroa8@gmail.com
10000009-1	Charles 'Superlanza' Jara Rodri	1970-06-19	Peruana	+56989057792	charles.jara9@puc.cl
10000010-5	Andrés 'Granmono' Cortés Lukaku	1977-12-24	Chilena	+56911805753	andres.cortes10@usach.cl
10000011-3	Erling 'Sanking' Ronaldo Bravo	2001-10-19	Española	+56952467576	erling.ronaldo11@usach.cl
10000012-1	Neymar 'Mastermaestro' Valdés Paredes	1977-11-15	Peruana	+56984258833	neymar.valdes12@puc.cl
10000013-K	Gavi 'Sanescarabajo' González Pizarro	1977-06-29	Colombiana	+56933902987	gavi.gonzalez13@usach.cl
10000014-8	Toni 'Mastermonarca' Castro Rodri	1981-05-23	Italiana	+56968079182	toni.castro14@usach.cl
10000015-6	Agustín 'Megaterremoto' Martínez Haaland	2000-01-25	Portuguesa	+56948607187	agustin.martinez15@outlook.com
10000016-4	Carlos 'Ultramuralla' Paredes Kroos	1992-04-07	Española	+56927214538	carlos.paredes16@puc.cl
10000017-2	Kylian 'Elronaldinho' Griezmann Bellingham	1979-05-11	Alemana	+56995818639	kylian.griezmann17@usach.cl
10000018-0	Kylian 'Granbarón' Vergara Herrera	1977-12-18	Chilena	+56984532515	kylian.vergara18@uca.cl
10000019-9	Thomas 'Santitanio' Gómez Rodríguez	1984-11-05	Peruana	+56952758736	thomas.gomez19@hotmail.com
10000020-2	Martín 'Sanpulga' Sánchez González	1990-06-15	Alemana	+56980205655	martin.sanchez20@outlook.com
10000021-0	Jorge 'Donespartano' Salas Suárez	1986-02-10	Chilena	+56936337323	jorge.salas21@outlook.com
10000022-9	Felipe 'Megaemperador' Salah Sánchez	1999-12-21	Inglesa	+56930565209	felipe.salah22@uca.cl
10000023-7	Hernán 'Granchupete' Vidal Mbappe	1984-11-05	Chilena	+56920936830	hernan.vidal23@yahoo.com
10000024-5	Ezequiel 'Donmatador' Yamal Cortés	1977-04-11	Inglesa	+56956714990	ezequiel.yamal24@puc.cl
10000025-3	Juan 'Mastermisil' Zidane López	2001-01-31	Peruana	+56923164057	juan.zidane25@puc.cl
10000026-1	Pelé 'Donpantera' Contreras Ronaldo	1985-03-22	Peruana	+56996548995	pele.contreras26@outlook.com
10000027-K	Sebastián 'Sanrifle' Pulgar Tapia	1991-12-22	Inglesa	+56954327545	sebastian.pulgar27@puc.cl
10000028-8	Toni 'Hyperbicho' Nuñez Beausejour	1976-01-30	Uruguaya	+56948192468	toni.nunez28@usach.cl
10000029-6	Guillermo 'Mastertorpedo' Valdés Espinoza	1989-03-04	Italiana	+56998533041	guillermo.valdes29@uca.cl
10000030-K	Robert 'Ultracañón' Soto Rodríguez	1986-11-20	Brasileña	+56959629757	robert.soto30@puc.cl
10000031-8	Gavi 'Hypercohete' Vidal Modric	1987-02-12	Italiana	+56974153900	gavi.vidal31@hotmail.com
10000032-6	Tomás 'Hypertitanio' Martínez Dybala	1986-11-04	Inglesa	+56956156776	tomas.martinez32@outlook.com
10000033-4	Jean 'Ultraduende' Soto Kane	1991-06-17	Chilena	+56960995150	jean.soto33@gmail.com
10000034-2	Nicolás 'Hypermatador' Pizarro Fuentes	2004-09-02	Italiana	+56925183914	nicolas.pizarro34@usach.cl
10000035-0	Johnny 'Ultraingeniero' Riquelme Valenzuela	2000-01-26	Argentina	+56938277014	johnny.riquelme35@outlook.com
10000036-9	Gustavo 'Brujo' Galdames Güler	2003-07-08	Portuguesa	+56924188942	gustavo.galdames36@hotmail.com
10000037-7	Thiago 'Bambino' Medel Aránguiz	2002-02-17	Italiana	+56998333469	thiago.medel37@usach.cl
10000038-5	Gonzalo 'Megalince' Castillo Toselli	1972-04-14	Portuguesa	+56979751005	gonzalo.castillo38@hotmail.com
10000039-3	Jaime 'Hyperfaraón' Valdés Gómez	2004-02-07	Portuguesa	+56922487074	jaime.valdes39@outlook.com
10000040-7	Martín 'Megahuracán' Valdés Di María	2004-04-22	Inglesa	+56989980116	martin.valdes40@puc.cl
10000041-5	Gonzalo 'Superhuaso' Flores Dybala	1991-02-27	Española	+56985109160	gonzalo.flores41@gmail.com
10000042-3	Cristopher 'Saningeniero' Rodri Salas	1993-04-19	Española	+56996650303	cristopher.rodri42@uca.cl
10000043-1	Eduardo 'Ultracóndor' Alvarez Arias	1986-06-15	Inglesa	+56939323879	eduardo.alvarez43@uca.cl
10000044-K	Johnny 'Sanroca' Modric Mendoza	1996-09-24	Colombiana	+56940418941	johnny.modric44@outlook.com
10000045-8	Francisco 'Mastercuervo' Pérez Aránguiz	1986-08-16	Inglesa	+56959282367	francisco.perez45@hotmail.com
10000046-6	Agustín 'Mastercomandante' Morales González	2001-11-11	Francesa	+56957616628	agustin.morales46@yahoo.com
10000047-4	Harry 'Relámpago' Alvarez Toselli	1995-11-10	Francesa	+56927521115	harry.alvarez47@usach.cl
10000048-2	Santino 'Hypergato' Haaland Bravo	1997-06-07	Chilena	+56934450159	santino.haaland48@gmail.com
10000049-0	Alexis 'Donsoldado' Kroos Vargas	1992-01-03	Inglesa	+56920987286	alexis.kroos49@puc.cl
10000050-4	Mohamed 'Superpuntero' Haaland Pulgar	1972-11-21	Alemana	+56978284538	mohamed.haaland50@hotmail.com
10000051-2	Gonzalo 'Megaescorpión' Gómez Araya	1991-02-09	Alemana	+56948228463	gonzalo.gomez51@uca.cl
10000052-0	Esteban 'Donapache' Flores Valenzuela	1981-03-05	Portuguesa	+56910766437	esteban.flores52@usach.cl
10000053-9	Ángel 'Sancapitán' Mbappe Contreras	1977-02-01	Brasileña	+56930064576	angel.mbappe53@outlook.com
10000054-7	Antoine 'Sanaraña' Sánchez Gutiérrez	2000-05-04	Uruguaya	+56936112424	antoine.sanchez54@usach.cl
10000055-5	Gavi 'Donhuaso' Aránguiz Güler	1973-01-06	Argentina	+56993229755	gavi.aranguiz55@uca.cl
10000056-3	Alejandro 'Masterlobo' Pizarro Sepúlveda	1991-04-12	Colombiana	+56932409885	alejandro.pizarro56@hotmail.com
10000057-1	Claudio 'Rey' Gómez Fuentes	1985-07-04	Uruguaya	+56933881356	claudio.gomez57@puc.cl
10000058-K	Maximiliano 'Superarquitecto' De Bruyne Aránguiz	1976-04-16	Argentina	+56966782804	maximiliano.de bruyne58@outlook.com
10000059-8	Matías 'Fideo' Pulgar Nuñez	1989-01-08	Argentina	+56938544903	matias.pulgar59@outlook.com
10000060-1	Daniel 'Hypercacique' Hernández Carrasco	1980-03-04	Española	+56994391766	daniel.hernandez60@gmail.com
10000061-K	Lautaro 'Hypercobra' Ramos Benzema	1981-12-15	Portuguesa	+56912899007	lautaro.ramos61@gmail.com
10000062-8	Cristopher 'Superhechicero' Riquelme Benzema	1970-06-05	Italiana	+56962682717	cristopher.riquelme62@usach.cl
10000063-6	Angel 'Grancentauro' Silva Figueroa	1996-01-07	Uruguaya	+56956036648	angel.silva63@yahoo.com
10000064-4	Alejandro 'Masterlince' Valdivia Benzema	1977-03-19	Uruguaya	+56944103667	alejandro.valdivia64@uca.cl
10000065-2	Ronaldo 'Masterjaguar' Dybala Pulgar	2003-04-11	Portuguesa	+56957789302	ronaldo.dybala65@puc.cl
10000066-0	Humberto 'Donmago' Herrera Rodríguez	1994-12-31	Inglesa	+56997540845	humberto.herrera66@hotmail.com
10000067-9	Pedro 'Granzorro' Galdames Neuer	1993-01-25	Peruana	+56979794722	pedro.galdames67@puc.cl
10000068-7	Sergio 'Maestro' Vinicius Dybala	1989-05-25	Francesa	+56934499357	sergio.vinicius68@puc.cl
10000069-5	Neymar 'Ultrajefe' Espinoza Pulgar	1999-11-09	Brasileña	+56999864787	neymar.espinoza69@puc.cl
10000070-9	Johnny 'Ultrapríncipe' Toselli Vásquez	1982-09-22	Española	+56997200018	johnny.toselli70@hotmail.com
10000071-7	Javier 'Sanzorro' Bustos Sánchez	1984-11-07	Colombiana	+56962012409	javier.bustos71@gmail.com
10000072-5	Luis 'Hypermonarca' Aránguiz Rodri	1994-02-24	Inglesa	+56911735668	luis.aranguiz72@outlook.com
10000073-3	Pedro 'Hypermuralla' Soto Mbappe	1971-06-06	Francesa	+56976491714	pedro.soto73@usach.cl
10000074-1	Gonzalo 'Superguerrero' Sepúlveda Paredes	1980-03-08	Brasileña	+56957073342	gonzalo.sepulveda74@puc.cl
10000075-K	Kevin 'Superjaguar' Vidal Pulgar	1973-08-29	Inglesa	+56924610710	kevin.vidal75@hotmail.com
10000076-8	Charles 'Granhuracán' Pulgar Gutiérrez	2003-04-05	Peruana	+56991003055	charles.pulgar76@gmail.com
10000077-6	Andrés 'Masterpulga' Soto Benzema	1982-07-21	Italiana	+56928365778	andres.soto77@gmail.com
10000078-4	Gonzalo 'Ultracapitán' Gutiérrez Maradona	1973-06-10	Francesa	+56939230540	gonzalo.gutierrez78@hotmail.com
10000079-2	Matías 'Mastertitán' Di María Salas	1972-11-03	Argentina	+56946788701	matias.di maria79@usach.cl
10000080-6	Bautista 'Superbicho' Fuentes Torres	1975-02-02	Española	+56920799945	bautista.fuentes80@puc.cl
10000081-4	Edinson 'Ultracosmos' Kroos Nuñez	2005-05-09	Francesa	+56942176905	edinson.kroos81@puc.cl
10000082-2	Manuel 'Búho' Silva Maripán	2001-12-11	Argentina	+56991589483	manuel.silva82@gmail.com
10000083-0	Humberto 'Sanhuracán' Vinicius Benzema	1988-03-27	Uruguaya	+56965148884	humberto.vinicius83@hotmail.com
10000084-9	Gabriel 'Minotauro' Vidal González	1992-04-09	Francesa	+56973861842	gabriel.vidal84@uca.cl
10000085-7	Francisco 'Sancaballero' Lukaku Maripán	2004-02-17	Colombiana	+56945771727	francisco.lukaku85@usach.cl
10000086-5	Erling 'Hypervozinha' Bustos Suazo	2003-01-23	Uruguaya	+56988730288	erling.bustos86@gmail.com
10000087-3	Luis 'Megacapataz' Valdés Alvarez	1980-05-16	Alemana	+56978972668	luis.valdes87@usach.cl
10000088-1	Diego 'Donmeteoro' Gutiérrez Valverde	1990-12-14	Brasileña	+56987901723	diego.gutierrez88@uca.cl
10000089-K	Harry 'Granapache' Dybala Arias	1979-03-23	Alemana	+56935078794	harry.dybala89@gmail.com
10000090-3	Sergio 'Dontiburón' Tapia Araya	1995-01-01	Argentina	+56969792182	sergio.tapia90@uca.cl
10000091-1	Cristiano 'León' Hernández Lewandowski	1984-02-27	Italiana	+56929080154	cristiano.hernandez91@yahoo.com
10000092-K	Gabriel 'Donbicho' Muñoz Figueroa	1989-08-10	Uruguaya	+56953084891	gabriel.munoz92@yahoo.com
10000093-8	Angel 'Ultragenio' Valverde Pizarro	1996-09-30	Argentina	+56966234753	angel.valverde93@yahoo.com
10000094-6	Matías 'Superbambino' Mendoza Silva	1979-06-01	Colombiana	+56992331811	matias.mendoza94@usach.cl
10000095-4	Cristian 'Megachapa' Di María Medel	1998-02-19	Alemana	+56960972834	cristian.di maria95@uca.cl
10000096-2	Nicolás 'Ronaldinho' Bellingham De Bruyne	1983-03-18	Portuguesa	+56950945991	nicolas.bellingham96@uca.cl
10000097-0	Matias 'Donguerrero' Jara Bellingham	1977-05-14	Francesa	+56998673105	matias.jara97@hotmail.com
10000098-9	Diego 'Mastercapataz' Suazo Cavani	1971-07-23	Alemana	+56914228345	diego.suazo98@outlook.com
10000099-7	Luka 'Megapríncipe' Bravo Gutiérrez	2000-10-01	Inglesa	+56988119628	luka.bravo99@yahoo.com
10000100-4	Bastián 'Megazorro' Zidane Pizarro	1970-12-31	Española	+56963107855	bastian.zidane100@uca.cl
10000101-2	Humberto 'Masterpiloto' Rodri Mendoza	1990-02-07	Colombiana	+56934661464	humberto.rodri101@gmail.com
10000102-0	Pedro 'Sanpitbull' Pizarro Isla	1976-03-15	Peruana	+56972886480	pedro.pizarro102@puc.cl
10000103-9	Gonzalo 'Supertanque' Gómez Díaz	1999-05-15	Italiana	+56970860913	gonzalo.gomez103@puc.cl
10000104-7	Martín 'Escarabajo' Yamal Sánchez	1993-06-11	Uruguaya	+56933059795	martin.yamal104@uca.cl
10000105-5	Bautista 'Hyperchupete' Ronaldo Dybala	1998-11-19	Uruguaya	+56981973484	bautista.ronaldo105@uca.cl
10000106-3	Thomas 'Megafiscal' Valdés Suárez	1988-10-08	Colombiana	+56927805540	thomas.valdes106@gmail.com
10000107-1	Pablo 'Ultratanque' López Beausejour	1999-04-27	Peruana	+56923329249	pablo.lopez107@hotmail.com
10000108-K	Gustavo 'Sanfiscal' Araya Contreras	1982-12-30	Peruana	+56950032668	gustavo.araya108@uca.cl
10000109-8	Gary 'Sanlíder' Maradona Dybala	1981-07-21	Brasileña	+56971682605	gary.maradona109@gmail.com
10000110-1	Humberto 'Supermariscal' Nuñez Álvarez	1990-01-21	Portuguesa	+56960294805	humberto.nunez110@uca.cl
10000111-K	Benjamín 'Ultraterremoto' Torres Tapia	1970-08-11	Colombiana	+56977010299	benjamin.torres111@gmail.com
10000112-8	Hernán 'Mastertanque' Modric Figueroa	1991-01-30	Argentina	+56952454544	hernan.modric112@uca.cl
10000113-6	Cristopher 'Sanpistola' Fernández Pizarro	1981-12-15	Brasileña	+56939513639	cristopher.fernandez113@outlook.com
10000114-4	Claudio 'Ultrapitón' Rodri Vergara	1991-11-15	Inglesa	+56994133950	claudio.rodri114@outlook.com
10000115-2	Gastón 'Hypersatélite' Soto Isla	2002-02-04	Italiana	+56985392655	gaston.soto115@puc.cl
10000116-0	Diego 'Ultraconde' Soto González	1984-09-18	Colombiana	+56944489162	diego.soto116@uca.cl
10000117-9	Alejandro 'Doncocodrilo' Figueroa Vargas	1991-07-04	Colombiana	+56968552060	alejandro.figueroa117@puc.cl
10000118-7	Ronaldo 'Doncapitán' Vinicius Modric	1995-11-25	Chilena	+56962679689	ronaldo.vinicius118@outlook.com
10000119-5	Alejandro 'Superflecha' Di María Castillo	1989-06-07	Argentina	+56936952701	alejandro.di maria119@yahoo.com
10000120-9	Kevin 'Ultracaimán' Paredes Torres	1971-07-18	Uruguaya	+56928494225	kevin.paredes120@outlook.com
10000663-4	Gavi 'Superduende' Alvarez Araya	2000-08-24	Francesa	+56984296553	gavi.alvarez663@uca.cl
10000121-7	Cristian 'Masterkeko' Álvarez Muñoz	1986-06-15	Colombiana	+56996778531	cristian.alvarez121@gmail.com
10000122-5	Esteban 'Hypertrueno' Tapia Di María	1973-04-30	Argentina	+56926698723	esteban.tapia122@gmail.com
10000123-3	Esteban 'Ultrasha' Flores Rodri	2004-03-06	Española	+56956310651	esteban.flores123@gmail.com
10000124-1	Sebastián 'Masterlíder' Bellingham Rodríguez	1974-01-14	Colombiana	+56985729996	sebastian.bellingham124@uca.cl
10000125-K	Claudio 'Ultrageneral' Fuentes Espinoza	1978-03-09	Española	+56911359930	claudio.fuentes125@uca.cl
10000126-8	Felipe 'Mastersoldado' Pizarro Hernández	1995-12-06	Italiana	+56926942289	felipe.pizarro126@uca.cl
10000127-6	Zinedine 'Supercosmos' Lukaku Müller	1976-02-06	Chilena	+56979827218	zinedine.lukaku127@outlook.com
10000128-4	Gonzalo 'Ultrapistola' Müller Fuentes	1993-04-29	Peruana	+56918265528	gonzalo.müller128@hotmail.com
10000129-2	Lautaro 'Mastercaballero' Torres Fuentes	1976-05-22	Italiana	+56911526914	lautaro.torres129@usach.cl
10000130-6	Charles 'Supertoro' Neuer Güler	1995-04-07	Peruana	+56980060153	charles.neuer130@yahoo.com
10000131-4	Toni 'Ultraescudo' Valdés Arias	1993-11-29	Inglesa	+56913913304	toni.valdes131@gmail.com
10000132-2	Zinedine 'Megacañón' Carrasco Sánchez	1999-04-12	Española	+56958531723	zinedine.carrasco132@uca.cl
10000133-0	Alexis 'Sanrinoceronte' Caszely Valverde	2003-12-21	Argentina	+56997109407	alexis.caszely133@usach.cl
10000134-9	Gonzalo 'Sancañón' Cortés Nuñez	1996-07-17	Uruguaya	+56933236709	gonzalo.cortes134@usach.cl
10000135-7	Erick 'Donsombra' Valdés Ramos	2003-03-18	Chilena	+56983940718	erick.valdes135@yahoo.com
10000136-5	Matias 'Hyperturboman' Contreras Figueroa	1987-03-14	Chilena	+56937754403	matias.contreras136@yahoo.com
10000137-3	Diego 'Puntero' Gutiérrez Torres	1995-09-14	Colombiana	+56982886122	diego.gutierrez137@puc.cl
10000138-1	Lautaro 'Hyperaraña' Aránguiz Riquelme	1997-07-06	Española	+56974939850	lautaro.aranguiz138@gmail.com
10000139-K	Gary 'Megasultán' Dybala Bravo	1973-01-20	Francesa	+56983973422	gary.dybala139@puc.cl
10000140-3	Agustín 'Sanlobo' Rodri Alvarez	1979-02-05	Uruguaya	+56975013515	agustin.rodri140@yahoo.com
10000141-1	Martín 'Hypergladiador' Castillo Vinicius	2003-03-23	Peruana	+56967971848	martin.castillo141@yahoo.com
10000142-K	Jaime 'Megacésar' Griezmann Fernández	1985-11-13	Española	+56926682632	jaime.griezmann142@usach.cl
10000143-8	Claudio 'Fénix' Dybala Aránguiz	1994-06-22	Alemana	+56925146794	claudio.dybala143@uca.cl
10000144-6	Andrés 'Sanescorpión' Morales Cortés	1985-03-03	Alemana	+56971255382	andres.morales144@uca.cl
10000145-4	Jaime 'Sanguerrero' Martínez Vinicius	1984-02-23	Peruana	+56942817107	jaime.martinez145@outlook.com
10000146-2	Karim 'Ultramariscal' Jara Contreras	2000-02-27	Colombiana	+56941171696	karim.jara146@gmail.com
10000147-0	Harry 'Superemperador' Álvarez Benzema	1978-07-02	Argentina	+56973445057	harry.alvarez147@yahoo.com
10000148-9	Francisco 'Grankaiser' Gutiérrez Jara	1996-06-24	Francesa	+56930996133	francisco.gutierrez148@puc.cl
10000149-7	Andrés 'Donescorpión' Rodríguez Lukaku	2002-03-22	Peruana	+56950277060	andres.rodriguez149@outlook.com
10000150-0	Pablo 'Granvolcán' Carrasco Rodríguez	2004-11-17	Uruguaya	+56936357801	pablo.carrasco150@gmail.com
10000151-9	Alejandro 'Grantiburón' Soto Paredes	1992-03-26	Española	+56927634290	alejandro.soto151@puc.cl
10000152-7	Erling 'Hyperguerrero' Silva Ramos	1977-08-28	Inglesa	+56992815359	erling.silva152@yahoo.com
10000153-5	Lautaro 'Sansha' Contreras Suazo	1976-09-11	Uruguaya	+56957361385	lautaro.contreras153@usach.cl
10000154-3	Gary 'Crack' Valdés Zidane	1991-11-16	Argentina	+56964559146	gary.valdes154@gmail.com
10000155-1	Álvaro 'Megasha' Haaland Valdivia	1971-01-27	Inglesa	+56926974894	alvaro.haaland155@gmail.com
10000156-K	Álvaro 'Supercomandante' Vargas Mendoza	2005-11-24	Chilena	+56972518390	alvaro.vargas156@yahoo.com
10000157-8	Lionel 'Masterchupete' Castillo Sánchez	1970-03-01	Peruana	+56949639854	lionel.castillo157@uca.cl
10000158-6	Cristiano 'Superkáiser' Yamal Müller	1971-06-16	Española	+56998180376	cristiano.yamal158@outlook.com
10000159-4	Harry 'Ultracaballero' Güler Vidal	1981-03-10	Portuguesa	+56950034892	harry.güler159@hotmail.com
10000160-8	Humberto 'Ultratitán' Figueroa Isla	1976-09-23	Colombiana	+56929643322	humberto.figueroa160@yahoo.com
10000161-6	Cristian 'Rayo' Yamal Dybala	1972-01-24	Inglesa	+56961171499	cristian.yamal161@gmail.com
10000162-4	Javier 'Megaescarabajo' Galdames Caszely	1989-06-23	Portuguesa	+56972579092	javier.galdames162@hotmail.com
10000163-2	Andrés 'Granduende' Lewandowski Kroos	1993-11-13	Chilena	+56955853180	andres.lewandowski163@uca.cl
10000164-0	Juan 'Pichichi' Kroos Castillo	2004-11-12	Peruana	+56930266499	juan.kroos164@gmail.com
10000165-9	Luis 'Sanvikingo' Flores Riquelme	1984-07-16	Brasileña	+56998805667	luis.flores165@hotmail.com
10000166-7	Marcelo 'Lince' Maripán Caszely	1996-03-31	Brasileña	+56938691089	marcelo.maripan166@hotmail.com
10000167-5	Gonzalo 'Sanemperador' Rodríguez Isla	1973-03-25	Colombiana	+56948123287	gonzalo.rodriguez167@outlook.com
10000168-3	Santino 'Megacometa' Pizarro Reyes	1993-12-29	Uruguaya	+56910866316	santino.pizarro168@uca.cl
10000169-1	Pedri 'Supercañón' Vargas Maripán	1984-06-30	Colombiana	+56914602233	pedri.vargas169@usach.cl
10000170-5	Agustín 'Gransatélite' Vásquez Beausejour	1994-07-02	Española	+56933696220	agustin.vasquez170@usach.cl
10000171-3	Jaime 'Masterrey' Contreras Riquelme	1994-01-27	Alemana	+56972288167	jaime.contreras171@uca.cl
10000172-1	Eduardo 'Granlanza' Neuer Benzema	2003-04-07	Italiana	+56941559022	eduardo.neuer172@usach.cl
10000173-K	Gastón 'Sanhechicero' Valenzuela Nuñez	1976-06-15	Francesa	+56936464203	gaston.valenzuela173@usach.cl
10000174-8	Robert 'Hypersombra' Nuñez Ronaldo	1994-12-25	Italiana	+56997315796	robert.nunez174@puc.cl
10000175-6	José 'Superbúho' Martínez Cortés	1992-09-12	Chilena	+56957489249	jose.martinez175@yahoo.com
10000176-4	Esteban 'Mastervíbora' Rojas Maripán	1976-10-20	Colombiana	+56955255930	esteban.rojas176@hotmail.com
10000177-2	Luka 'Hyperfideo' Medel Sepúlveda	1985-11-19	Colombiana	+56996480879	luka.medel177@hotmail.com
10000178-0	Erling 'Masterrinoceronte' Haaland Valdés	1972-02-20	Española	+56955310799	erling.haaland178@usach.cl
10000179-9	Jorge 'Pitón' Galdames Jara	1981-06-07	Inglesa	+56946548339	jorge.galdames179@uca.cl
10000180-2	Bastián 'Sanminotauro' Nuñez Contreras	1980-06-20	Francesa	+56922972806	bastian.nunez180@usach.cl
10000181-0	Santino 'Superaraña' Maripán Araya	1984-10-12	Chilena	+56978641008	santino.maripan181@hotmail.com
10000182-9	Mauricio 'Supertiburón' Jara Martínez	1995-05-03	Peruana	+56916654064	mauricio.jara182@uca.cl
10000183-7	Luka 'Superpalote' Mendoza Flores	1996-03-02	Española	+56971897182	luka.mendoza183@outlook.com
10000184-5	Pablo 'Ultrahuaso' López Haaland	1974-12-06	Italiana	+56959079348	pablo.lopez184@yahoo.com
10000185-3	Marcelo 'Titán' Isla Ramos	1981-05-05	Colombiana	+56935824195	marcelo.isla185@usach.cl
10000186-1	Gavi 'Ultralince' Di María Lewandowski	1980-09-25	Española	+56984631434	gavi.di maria186@hotmail.com
10000187-K	Daniel 'Dongaláctico' Lukaku Ronaldo	1979-06-19	Brasileña	+56956106532	daniel.lukaku187@gmail.com
10000188-8	Sebastián 'Hyperavispa' Maradona Haaland	1979-03-05	Española	+56927711337	sebastian.maradona188@uca.cl
10000189-6	Ezequiel 'Donchacal' Silva Rojas	1989-05-12	Alemana	+56976436410	ezequiel.silva189@usach.cl
10000190-K	Álvaro 'Monarca' Rivera Paredes	1987-05-17	Argentina	+56944865724	alvaro.rivera190@gmail.com
10000191-8	Robert 'Granhalcón' Ronaldo De Bruyne	1976-03-26	Argentina	+56997291318	robert.ronaldo191@outlook.com
10000192-6	Sergio 'Gransoldado' Figueroa Rojas	1971-09-08	Chilena	+56968038168	sergio.figueroa192@yahoo.com
10000193-4	Thiago 'Ultracometa' Rodríguez Suazo	1981-05-30	Portuguesa	+56985094319	thiago.rodriguez193@hotmail.com
10000194-2	Enzo 'Megaminotauro' Contreras Dybala	1979-10-17	Colombiana	+56945874012	enzo.contreras194@yahoo.com
10000195-0	Eduardo 'Ultraninja' Ronaldo Cavani	1993-11-13	Alemana	+56965953646	eduardo.ronaldo195@yahoo.com
10000196-9	Ignacio 'Granleón' Suárez Castillo	1993-04-25	Argentina	+56923509965	ignacio.suarez196@usach.cl
10000197-7	Johnny 'Superkaiser' Güler Vásquez	1991-05-16	Brasileña	+56913055814	johnny.güler197@yahoo.com
10000198-5	Agustín 'Chapa' Rojas Reyes	1983-11-11	Inglesa	+56974611438	agustin.rojas198@usach.cl
10000199-3	Santiago 'Sancosmos' Nuñez Kane	1984-02-26	Peruana	+56928930664	santiago.nunez199@yahoo.com
10000200-0	Gary 'Jaguar' Rojas Saavedra	1988-03-11	Alemana	+56975144964	gary.rojas200@outlook.com
10000201-9	Pedro 'Ultraescarabajo' Gutiérrez Rodri	2002-04-22	Argentina	+56994234058	pedro.gutierrez201@gmail.com
10000202-7	Jean 'Megaavispón' Saavedra Vergara	1981-05-08	Portuguesa	+56915226120	jean.saavedra202@puc.cl
10000203-5	Bastián 'Megadoctor' Haaland Pizarro	1975-07-15	Colombiana	+56913364024	bastian.haaland203@usach.cl
10000204-3	Paulo 'Hyperdepredador' De Bruyne Vergara	1989-11-18	Colombiana	+56992524884	paulo.de bruyne204@usach.cl
10000205-1	Robert 'Sancaimán' Tapia Gutiérrez	1981-01-03	Inglesa	+56939271325	robert.tapia205@outlook.com
10000206-K	Gastón 'Hypertorpedo' Messi Pérez	1970-05-31	Brasileña	+56952268090	gaston.messi206@outlook.com
10000207-8	Matias 'Matador' Rivera Torres	1982-04-25	Brasileña	+56967605984	matias.rivera207@puc.cl
10000208-6	Felipe 'Donleón' Gómez Ronaldo	2005-09-12	Uruguaya	+56996565172	felipe.gomez208@gmail.com
10000209-4	Arturo 'Masterhormiga' Díaz Isla	1975-01-09	Brasileña	+56937922627	arturo.diaz209@puc.cl
10000210-8	Ronaldo 'Hypercaballero' Castro Jara	1987-10-24	Alemana	+56965569268	ronaldo.castro210@uca.cl
10000211-6	Alexis 'Mastertornado' Salas Di María	2000-09-12	Española	+56980169428	alexis.salas211@yahoo.com
10000212-4	Santino 'Mastermariscal' Hernández Sepúlveda	1985-08-02	Argentina	+56985750729	santino.hernandez212@puc.cl
10000213-2	Thomas 'Superhalcón' Álvarez González	1974-04-12	Colombiana	+56951193542	thomas.alvarez213@puc.cl
10000214-0	Matías 'Cometa' Gómez Kane	1998-11-05	Chilena	+56955904571	matias.gomez214@uca.cl
10000215-9	Alejandro 'Hyperkaiser' Müller Yamal	1971-05-25	Brasileña	+56968697882	alejandro.müller215@usach.cl
10000216-7	Francisco 'Ingeniero' González Kane	1977-10-09	Brasileña	+56992290474	francisco.gonzalez216@usach.cl
10000217-5	Martín 'Superáguila' Gómez Modric	1976-09-09	Italiana	+56959617527	martin.gomez217@hotmail.com
10000218-3	Pedri 'Masterkaiser' Castillo Bravo	1981-09-08	Brasileña	+56986852417	pedri.castillo218@hotmail.com
10000219-1	Karim 'Donfaraón' Yamal Haaland	2003-01-28	Argentina	+56920130237	karim.yamal219@puc.cl
10000220-5	Agustín 'Sanvozinha' Pulgar Güler	1977-07-03	Colombiana	+56915064784	agustin.pulgar220@gmail.com
10000221-3	Gavi 'Megaespartano' Flores Beausejour	1987-03-04	Argentina	+56930837541	gavi.flores221@outlook.com
10000222-1	Jorge 'Pantera' Benzema Carrasco	1974-12-01	Chilena	+56974299301	jorge.benzema222@hotmail.com
10000223-K	Álvaro 'Donmuralla' Maripán De Bruyne	1975-02-21	Uruguaya	+56955393045	alvaro.maripan223@usach.cl
10000224-8	Ezequiel 'Granhormiga' Espinoza Figueroa	1973-09-24	Peruana	+56920568872	ezequiel.espinoza224@puc.cl
10000225-6	Alejandro 'Masterbarón' Neuer Kroos	1999-10-17	Italiana	+56945968372	alejandro.neuer225@gmail.com
10000226-4	Santino 'Hypergrifo' Rodri Caszely	1979-08-15	Peruana	+56979700187	santino.rodri226@usach.cl
10000227-2	Pelé 'Sansombra' Kroos Contreras	1978-06-20	Chilena	+56948807674	pele.kroos227@puc.cl
10000228-0	Enzo 'Donjefe' Bustos Vinicius	1995-03-19	Portuguesa	+56952813481	enzo.bustos228@puc.cl
10000229-9	Paulo 'Masterdepredador' Mbappe Espinoza	2004-12-15	Colombiana	+56981799678	paulo.mbappe229@hotmail.com
10000230-2	Alexis 'Masterespartano' Cortés Cortés	1970-05-15	Brasileña	+56955734139	alexis.cortes230@yahoo.com
10000231-0	Gavi 'Ultradepredador' Aránguiz Mbappe	2003-02-07	Colombiana	+56935588255	gavi.aranguiz231@puc.cl
10000232-9	Oscar 'Mastergladiador' Vinicius Bravo	1992-02-04	Italiana	+56939953327	oscar.vinicius232@puc.cl
10000233-7	Zinedine 'Megaalmirante' Dybala Bravo	1992-09-16	Argentina	+56992833617	zinedine.dybala233@hotmail.com
10000234-5	Joaquín 'Granmisil' Müller Beausejour	1992-07-29	Uruguaya	+56951500955	joaquin.müller234@usach.cl
10000235-3	Tomás 'Hypercrack' Müller Rodri	1978-04-19	Peruana	+56947874706	tomas.müller235@puc.cl
10000236-1	Lucas 'Ultraalmirante' Silva Kroos	1983-01-27	Alemana	+56978943299	lucas.silva236@puc.cl
10000237-K	Pedro 'Donninja' Díaz Gutiérrez	1988-07-22	Alemana	+56934611994	pedro.diaz237@gmail.com
10000238-8	Gabriel 'Masterroca' Valdivia Lewandowski	2001-06-27	Portuguesa	+56973077096	gabriel.valdivia238@puc.cl
10000239-6	Cristian 'Dongeneral' Tapia Toselli	1988-12-11	Brasileña	+56955245299	cristian.tapia239@yahoo.com
10000240-K	Cristiano 'Megahechicero' Haaland Álvarez	2002-09-10	Peruana	+56948316157	cristiano.haaland240@yahoo.com
10000241-8	Francisco 'Donpichichi' Rojas Soto	1974-02-28	Uruguaya	+56968652187	francisco.rojas241@hotmail.com
10000242-6	Paulo 'Supermago' Vidal Flores	2001-10-11	Española	+56978830925	paulo.vidal242@usach.cl
10000243-4	Zinedine 'Supercacique' Reyes Müller	1991-07-16	Uruguaya	+56924580994	zinedine.reyes243@puc.cl
10000244-2	Lautaro 'Sancocodrilo' Rodríguez López	1976-06-20	Peruana	+56989867245	lautaro.rodriguez244@puc.cl
10000245-0	Tomás 'Grandragón' Ronaldo Díaz	1970-12-22	Brasileña	+56981174612	tomas.ronaldo245@usach.cl
10000246-9	José 'Sanprofesor' Modric Tapia	1983-08-10	Chilena	+56958516575	jose.modric246@gmail.com
10000247-7	Jaime 'Apache' Martínez Cortés	1985-04-19	Uruguaya	+56952914512	jaime.martinez247@usach.cl
10000248-5	Daniel 'Hypermago' Contreras Modric	1980-05-03	Colombiana	+56988758791	daniel.contreras248@hotmail.com
10000249-3	Johnny 'Granpulga' Pérez Espinoza	1981-05-27	Francesa	+56937122066	johnny.perez249@hotmail.com
10000250-7	Romelu 'Gato' Flores González	1982-01-21	Inglesa	+56944125371	romelu.flores250@uca.cl
10000251-5	Johnny 'Grancocodrilo' Ronaldo Vásquez	1977-06-28	Chilena	+56953257011	johnny.ronaldo251@outlook.com
10000252-3	Álvaro 'Masterpalote' Valdivia Mbappe	1982-04-15	Portuguesa	+56916842611	alvaro.valdivia252@outlook.com
10000253-1	Manuel 'Hypersha' Bravo Saavedra	1981-03-04	Alemana	+56978801398	manuel.bravo253@puc.cl
10000254-K	Matias 'Comisario' De Bruyne Benzema	2000-03-21	Uruguaya	+56990135489	matias.de bruyne254@yahoo.com
10000255-8	Erick 'Masterpuntero' Mendoza Suárez	1989-10-16	Chilena	+56914113634	erick.mendoza255@hotmail.com
10000256-6	Vicente 'Doncoto' Aránguiz Alvarez	1971-02-27	Chilena	+56955120679	vicente.aranguiz256@uca.cl
10000257-4	Kevin 'Hypertanque' López Galdames	1974-08-02	Peruana	+56934668751	kevin.lopez257@uca.cl
10000258-2	Jorge 'Hyperpuntero' López Messi	2005-04-20	Inglesa	+56945052383	jorge.lopez258@gmail.com
10000259-0	Daniel 'Doncohete' Ramos González	1992-07-19	Francesa	+56979771978	daniel.ramos259@gmail.com
10000260-4	Charles 'Pistolero' Salas Rodríguez	2001-10-15	Inglesa	+56990438907	charles.salas260@outlook.com
10000261-2	Ronaldo 'Ciclón' Rivera Bustos	1988-05-03	Argentina	+56934449448	ronaldo.rivera261@yahoo.com
10000262-0	Thomas 'Santitán' Dybala Caszely	1995-11-15	Italiana	+56957160809	thomas.dybala262@uca.cl
10000263-9	Alejandro 'Hyperpájaro' Toselli Castillo	1983-08-25	Italiana	+56944091390	alejandro.toselli263@puc.cl
10000264-7	Julian 'Megadepredador' Espinoza Pulgar	2004-08-19	Chilena	+56955048903	julian.espinoza264@gmail.com
10000265-5	Lamine 'Huaso' Rivera Fernández	1984-03-26	Uruguaya	+56956153957	lamine.rivera265@outlook.com
10000266-3	Bautista 'Grangenio' Silva Caszely	1993-01-05	Brasileña	+56990036774	bautista.silva266@yahoo.com
10000267-1	Facundo 'Doncuervo' López Di María	1976-05-06	Colombiana	+56958153558	facundo.lopez267@hotmail.com
10000268-K	Gonzalo 'Dontitán' Mendoza Vargas	1974-05-25	Inglesa	+56941701404	gonzalo.mendoza268@hotmail.com
10000269-8	Gastón 'Megarayo' Isla Mbappe	2004-05-29	Chilena	+56968514199	gaston.isla269@hotmail.com
10000270-1	Facundo 'Sancacique' Araya Valverde	1997-06-15	Brasileña	+56939372648	facundo.araya270@usach.cl
10000271-K	Erling 'Supercometa' Gutiérrez Castro	1985-06-25	Chilena	+56991965236	erling.gutierrez271@gmail.com
10000272-8	Jaime 'Dongato' Vergara De Bruyne	1983-09-19	Peruana	+56999121658	jaime.vergara272@outlook.com
10000273-6	Ezequiel 'Megarinoceronte' Ramos Paredes	1980-12-04	Brasileña	+56971208913	ezequiel.ramos273@hotmail.com
10000274-4	Luis 'Supercobra' Beausejour Araya	1993-06-15	Francesa	+56983451184	luis.beausejour274@gmail.com
10000275-2	Charles 'Masterpájaro' Modric Fuentes	1999-08-08	Española	+56940077424	charles.modric275@yahoo.com
10000276-0	Esteban 'Hypercuervo' Sepúlveda Galdames	1991-11-17	Francesa	+56924680070	esteban.sepulveda276@outlook.com
10000277-9	Juan 'Megacaballero' Mbappe Ramos	2005-06-28	Peruana	+56951096073	juan.mbappe277@hotmail.com
10000278-7	Antoine 'Donchapa' Reyes Vergara	1994-04-05	Colombiana	+56910229735	antoine.reyes278@puc.cl
10000279-5	Lucas 'Megacentauro' Fernández Hernández	1985-08-18	Chilena	+56999195743	lucas.fernandez279@gmail.com
10000280-9	Zinedine 'Superrayo' Espinoza Pizarro	1984-03-06	Alemana	+56926584836	zinedine.espinoza280@outlook.com
10000281-7	Felipe 'Hyperchapa' Mendoza Castro	1999-09-28	Peruana	+56959378720	felipe.mendoza281@yahoo.com
10000282-5	Rodrigo 'Supercomisario' Toselli Vargas	1972-06-22	Chilena	+56968628480	rodrigo.toselli282@yahoo.com
10000283-3	Vicente 'Hyperbambino' Suárez Haaland	1990-12-01	Francesa	+56954529481	vicente.suarez283@uca.cl
10000284-1	Sebastián 'Sanrey' Lewandowski Aránguiz	1994-05-30	Italiana	+56940684603	sebastian.lewandowski284@outlook.com
10000285-K	Santino 'Doncacique' Sánchez Di María	1991-06-22	Uruguaya	+56968316396	santino.sanchez285@puc.cl
10000286-8	Gabriel 'Megapalote' Vidal Pulgar	1992-03-28	Colombiana	+56961170429	gabriel.vidal286@puc.cl
10000287-6	Tomás 'Ultragladiador' Maradona Flores	1987-12-26	Francesa	+56947822900	tomas.maradona287@hotmail.com
10000288-4	Marcos 'Grangeneral' Vásquez Mbappe	1980-07-28	Colombiana	+56928579634	marcos.vasquez288@outlook.com
10000289-2	Ezequiel 'Donchupete' Messi Arias	1999-08-24	Inglesa	+56981548643	ezequiel.messi289@puc.cl
10000290-6	Benjamín 'Ultrachapa' Vidal Griezmann	1980-10-24	Inglesa	+56956614377	benjamin.vidal290@outlook.com
10000291-4	Matías 'Cocodrilo' Castillo Mbappe	1993-10-18	Chilena	+56935469981	matias.castillo291@usach.cl
10000292-2	Gonzalo 'Superavispa' Álvarez Pulgar	1986-05-15	Brasileña	+56972715377	gonzalo.alvarez292@yahoo.com
10000293-0	Javier 'Zorro' Suazo Cavani	1983-12-21	Italiana	+56934027288	javier.suazo293@uca.cl
10000294-9	Vicente 'Mastertorta' Zidane Valenzuela	1973-04-26	Colombiana	+56918064930	vicente.zidane294@outlook.com
10000295-7	Lamine 'Hyperlíder' Muñoz Flores	1992-08-22	Italiana	+56971575807	lamine.munoz295@uca.cl
10000296-5	Esteban 'Grangladiador' Espinoza Lewandowski	2004-12-29	Portuguesa	+56993047868	esteban.espinoza296@yahoo.com
10000297-3	Erick 'Ultrasombra' Arias Kane	1972-09-29	Uruguaya	+56946658579	erick.arias297@hotmail.com
10000298-1	Nicolás 'Superbarón' Fuentes Pizarro	1976-11-08	Chilena	+56911573517	nicolas.fuentes298@outlook.com
10000299-K	Matias 'Sancentauro' Soto Bellingham	2000-07-04	Brasileña	+56971740627	matias.soto299@yahoo.com
10000300-7	Luciano 'Sancohete' De Bruyne Cavani	2005-03-31	Alemana	+56961694494	luciano.de bruyne300@outlook.com
10000301-5	Lionel 'Granjaguar' Di María Messi	1986-01-19	Chilena	+56912593307	lionel.di maria301@uca.cl
10000302-3	Luciano 'Hyperpistola' Haaland Mendoza	1995-09-10	Brasileña	+56947934680	luciano.haaland302@gmail.com
10000303-1	Romelu 'Megapistolero' Contreras Zidane	1993-03-26	Española	+56950155104	romelu.contreras303@uca.cl
10000304-K	Matias 'Megabrujo' Caszely Espinoza	1982-07-13	Peruana	+56941002228	matias.caszely304@hotmail.com
10000305-8	Raúl 'Grancosmos' Ronaldo Vergara	1989-01-11	Colombiana	+56961082764	raul.ronaldo305@uca.cl
10000306-6	Erling 'Ultraapache' Castillo Ronaldo	1997-09-05	Argentina	+56990119821	erling.castillo306@puc.cl
10000307-4	Marcos 'Sanmuro' Díaz Alvarez	1996-09-23	Inglesa	+56958722553	marcos.diaz307@usach.cl
10000308-2	Robert 'Superapache' Salas Medel	1996-06-24	Española	+56978899320	robert.salas308@usach.cl
10000309-0	David 'Superchupete' Espinoza Jara	1978-10-22	Española	+56918197413	david.espinoza309@usach.cl
10000310-4	Esteban 'Sanmeteoro' Contreras Salah	1999-03-07	Alemana	+56991778569	esteban.contreras310@hotmail.com
10000311-2	Andrés 'Mastermatador' Toselli Di María	1978-10-26	Inglesa	+56956787378	andres.toselli311@hotmail.com
10000312-0	Martín 'Cohete' Ronaldo Benzema	1987-03-17	Uruguaya	+56925808750	martin.ronaldo312@usach.cl
10000313-9	Benjamín 'Mastermago' Álvarez Haaland	1989-01-05	Argentina	+56964037755	benjamin.alvarez313@uca.cl
10000314-7	Guillermo 'Supermuro' Gutiérrez Pizarro	1981-10-10	Italiana	+56992157720	guillermo.gutierrez314@outlook.com
10000315-5	Luka 'Superjefe' De Bruyne Vinicius	1987-06-12	Uruguaya	+56965909027	luka.de bruyne315@yahoo.com
10000316-3	Cristian 'Megalíder' Kane Riquelme	2001-07-08	Colombiana	+56924603839	cristian.kane316@yahoo.com
10000317-1	Zinedine 'Superleón' Di María Caszely	1975-05-11	Alemana	+56962090192	zinedine.di maria317@puc.cl
10000318-K	Toni 'Ultrapichichi' Maripán Hernández	1977-11-16	Argentina	+56919573506	toni.maripan318@usach.cl
10000319-8	Jaime 'Superdragón' Silva Galdames	1983-02-16	Uruguaya	+56959678653	jaime.silva319@usach.cl
10000320-1	Álvaro 'Dongalaxia' Benzema Castillo	2001-07-11	Uruguaya	+56978146502	alvaro.benzema320@gmail.com
10000321-K	Cristopher 'Lanza' Cavani Rivera	1977-09-19	Alemana	+56937000476	cristopher.cavani321@outlook.com
10000322-8	Gonzalo 'Megamuro' Carrasco Ramos	1971-10-23	Española	+56966684646	gonzalo.carrasco322@puc.cl
10000323-6	Karim 'Ultratorta' Valenzuela Sánchez	1975-04-18	Francesa	+56959168704	karim.valenzuela323@uca.cl
10000324-4	Diego 'Superninja' Espinoza Messi	1989-03-22	Francesa	+56917285592	diego.espinoza324@hotmail.com
10000325-2	Lucas 'Grangalaxia' Maripán Gutiérrez	1982-06-25	Española	+56924937880	lucas.maripan325@puc.cl
10000326-0	Ezequiel 'Mastercometa' Lukaku Araya	1997-04-01	Inglesa	+56936782290	ezequiel.lukaku326@outlook.com
10000327-9	Matías 'Donpuma' Castillo Reyes	1979-01-28	Peruana	+56940957379	matias.castillo327@gmail.com
10000328-7	Neymar 'Superlíder' Galdames Torres	1991-05-30	Brasileña	+56929896101	neymar.galdames328@uca.cl
10000329-5	Lamine 'Doncomandante' Lewandowski Griezmann	1972-01-27	Portuguesa	+56919880848	lamine.lewandowski329@yahoo.com
10000330-9	Johnny 'Hyperfénix' Hernández Mendoza	1984-07-29	Española	+56960883179	johnny.hernandez330@puc.cl
10000331-7	Marcelo 'Ultraguerrero' Caszely Sepúlveda	1987-01-09	Brasileña	+56989680011	marcelo.caszely331@gmail.com
10000332-5	Matias 'Ultragaláctico' Soto Figueroa	1977-08-22	Portuguesa	+56951455263	matias.soto332@outlook.com
10000333-3	Gonzalo 'Supercohete' Valenzuela Saavedra	1990-02-19	Inglesa	+56937516993	gonzalo.valenzuela333@yahoo.com
10000334-1	Enzo 'Donbúho' Cortés Reyes	1981-03-20	Chilena	+56958987661	enzo.cortes334@hotmail.com
10000335-K	Zinedine 'Megakeko' Figueroa Muñoz	1976-04-01	Inglesa	+56995233177	zinedine.figueroa335@hotmail.com
10000336-8	Gastón 'Ultraciclón' Rodríguez Soto	2000-06-20	Italiana	+56924939627	gaston.rodriguez336@hotmail.com
10000337-6	Santiago 'Hyperpistolero' Yamal Müller	1979-03-11	Portuguesa	+56926649485	santiago.yamal337@hotmail.com
10000338-4	Zinedine 'Granpalote' De Bruyne Herrera	1998-07-08	Portuguesa	+56969473666	zinedine.de bruyne338@puc.cl
10000339-2	Antoine 'Muro' Maripán Pizarro	1991-05-25	Colombiana	+56965267377	antoine.maripan339@gmail.com
10000340-6	Gustavo 'Dragón' Kroos Herrera	1986-10-28	Inglesa	+56956905799	gustavo.kroos340@gmail.com
10000341-4	Matías 'Supertorpedo' Bustos De Bruyne	1978-11-30	Uruguaya	+56945162851	matias.bustos341@yahoo.com
10000342-2	Federico 'Hypersultán' Vidal López	1976-11-08	Argentina	+56973147251	federico.vidal342@uca.cl
10000343-0	Julian 'Megaarquitecto' López Valverde	1992-09-19	Española	+56935412343	julian.lopez343@puc.cl
10000344-9	Martín 'Sanbambino' Flores De Bruyne	1998-10-01	Chilena	+56969014484	martin.flores344@usach.cl
10000345-7	Pedri 'Megacomisario' Castro Suazo	1973-12-31	Alemana	+56912583191	pedri.castro345@hotmail.com
10000346-5	Charles 'Soldado' Lewandowski Figueroa	2004-09-24	Portuguesa	+56991764556	charles.lewandowski346@gmail.com
10000347-3	Sebastián 'Granbúho' Torres Toselli	1972-03-13	Española	+56968115312	sebastian.torres347@outlook.com
10000348-1	Santino 'Sanmaestro' Pérez Neuer	1983-02-18	Uruguaya	+56922011321	santino.perez348@hotmail.com
10000349-K	Hernán 'Grandepredador' Mendoza Figueroa	2002-07-09	Francesa	+56988538122	hernan.mendoza349@gmail.com
10000350-3	Pablo 'Donlince' Maripán De Bruyne	1979-09-05	Colombiana	+56993308539	pablo.maripan350@usach.cl
10000351-1	Antoine 'Ultramuro' Isla Isla	2002-01-31	Española	+56910110915	antoine.isla351@puc.cl
10000352-K	Carlos 'Grancoto' Paredes Figueroa	1978-08-30	Francesa	+56966983505	carlos.paredes352@puc.cl
10000353-8	Carlos 'Hypertitán' Güler Vásquez	1990-09-11	Colombiana	+56957235239	carlos.güler353@usach.cl
10000354-6	Javier 'Doncaimán' Valverde Castro	1985-10-02	Italiana	+56955156028	javier.valverde354@yahoo.com
10000355-4	Gustavo 'Torta' Rodri Lukaku	1998-01-30	Argentina	+56998034348	gustavo.rodri355@outlook.com
10000356-2	Ignacio 'Donvolcán' Salah Rivera	2005-09-20	Peruana	+56934439570	ignacio.salah356@puc.cl
10000357-0	Sebastián 'Megaflecha' Paredes Bravo	2002-12-03	Peruana	+56982873366	sebastian.paredes357@gmail.com
10000358-9	Vicente 'Megarifle' Paredes Muñoz	2000-09-15	Inglesa	+56945325186	vicente.paredes358@hotmail.com
10000359-7	Gavi 'Sanduque' Dybala Soto	2001-02-13	Chilena	+56926240777	gavi.dybala359@hotmail.com
10000360-0	Joaquín 'Megavikingo' Caszely Vásquez	1976-03-12	Inglesa	+56986188119	joaquin.caszely360@uca.cl
10000361-9	Humberto 'Mastercohete' Sánchez Ramos	2004-12-03	Colombiana	+56966306112	humberto.sanchez361@usach.cl
10000362-7	Gastón 'Donáguila' Vergara Bellingham	1997-01-10	Inglesa	+56912138030	gaston.vergara362@usach.cl
10000363-5	Álvaro 'Mastercacique' Kane Galdames	1990-08-13	Chilena	+56999862940	alvaro.kane363@outlook.com
10000364-3	Harry 'Superpuma' Messi Vargas	1976-05-15	Chilena	+56923532474	harry.messi364@outlook.com
10000365-1	Pedri 'Sanmisil' Beausejour Paredes	1983-08-16	Argentina	+56962273811	pedri.beausejour365@outlook.com
10000366-K	Lautaro 'Superguepardo' Figueroa Sánchez	1977-08-23	Francesa	+56918189667	lautaro.figueroa366@usach.cl
10000367-8	Jaime 'Ultraflecha' Valenzuela Maripán	1999-01-22	Alemana	+56961826575	jaime.valenzuela367@uca.cl
10000368-6	Harry 'Sanhalcón' Vásquez Dybala	1973-11-24	Italiana	+56975229184	harry.vasquez368@uca.cl
10000369-4	Rodrigo 'Masterpatrón' Kroos Lukaku	2005-03-22	Chilena	+56963444405	rodrigo.kroos369@puc.cl
10000370-8	Pedri 'Masterlanza' Messi Rodri	1997-02-27	Chilena	+56963941671	pedri.messi370@uca.cl
10000371-6	Pedro 'Águila' Pulgar Maripán	1994-10-20	Española	+56970737761	pedro.pulgar371@hotmail.com
10000372-4	Maximiliano 'Masteremperador' Toselli Bustos	1995-11-16	Chilena	+56965909485	maximiliano.toselli372@puc.cl
10000373-2	Pedri 'Hypercocodrilo' Müller Figueroa	1980-10-07	Española	+56971361600	pedri.müller373@usach.cl
10000374-0	Cristopher 'Ultravikingo' Hernández López	1971-01-11	Francesa	+56913316366	cristopher.hernandez374@gmail.com
10000375-9	Vicente 'Grantrueno' Toselli Díaz	1992-07-26	Española	+56934224467	vicente.toselli375@yahoo.com
10000376-7	Gabriel 'Megavíbora' Paredes Reyes	1980-03-29	Chilena	+56981038704	gabriel.paredes376@gmail.com
10000377-5	Gastón 'Megamuralla' López Güler	1973-01-29	Española	+56910266595	gaston.lopez377@gmail.com
10000378-3	Lionel 'Granhuaso' Suárez Bellingham	1985-08-11	Uruguaya	+56931459919	lionel.suarez378@yahoo.com
10000379-1	Agustín 'Megacomandante' Pizarro Castro	1983-09-29	Peruana	+56958684094	agustin.pizarro379@hotmail.com
10000380-5	Neymar 'Grantornado' Muñoz Martínez	1986-03-21	Uruguaya	+56998772723	neymar.munoz380@puc.cl
10000381-3	Cristiano 'Ultravozinha' Bellingham Valverde	1995-11-05	Argentina	+56933636014	cristiano.bellingham381@gmail.com
10000382-1	Pedri 'Cosmos' Güler Bellingham	1991-05-11	Alemana	+56939744283	pedri.güler382@outlook.com
10000383-K	Santino 'Masteráguila' Herrera Fuentes	1972-01-06	Peruana	+56941504562	santino.herrera383@hotmail.com
10000384-8	Thiago 'Megaescudo' Valenzuela Toselli	2003-11-05	Francesa	+56991870791	thiago.valenzuela384@yahoo.com
10000385-6	Álvaro 'Sanciclón' Müller Silva	2004-11-02	Chilena	+56940079291	alvaro.müller385@puc.cl
10000386-4	Lamine 'Megafideo' Haaland Suazo	1984-07-27	Peruana	+56914708498	lamine.haaland386@uca.cl
10000387-2	Joaquín 'Ultrapantera' Cortés Mbappe	1992-03-27	Brasileña	+56936631586	joaquin.cortes387@gmail.com
10000388-0	Rodrigo 'Donlíder' Nuñez Riquelme	1997-09-18	Peruana	+56989918767	rodrigo.nunez388@uca.cl
10000389-9	Marcelo 'Doncosmos' Espinoza Valenzuela	1985-09-22	Inglesa	+56936341364	marcelo.espinoza389@puc.cl
10000390-2	Luka 'Masterciclón' Toselli Vargas	1989-05-19	Inglesa	+56989193684	luka.toselli390@uca.cl
10000391-0	Gabriel 'Ultramono' Ronaldo Di María	1998-04-28	Italiana	+56949469004	gabriel.ronaldo391@yahoo.com
10000392-9	Kylian 'Donturboman' Arias Nuñez	1972-10-26	Alemana	+56915680609	kylian.arias392@usach.cl
10000393-7	Juan 'Flecha' Saavedra Hernández	1975-10-23	Portuguesa	+56961171022	juan.saavedra393@uca.cl
10000394-5	Mateo 'Masterfiscal' Espinoza Benzema	1974-07-20	Brasileña	+56975019605	mateo.espinoza394@usach.cl
10000395-3	Guillermo 'Ultracapataz' Díaz Pizarro	1996-11-23	Francesa	+56925504676	guillermo.diaz395@uca.cl
10000396-1	Mauricio 'Megacrack' Güler Gutiérrez	1975-03-31	Brasileña	+56973936172	mauricio.güler396@outlook.com
10000397-K	Kylian 'Torpedo' Galdames Silva	1999-03-28	Inglesa	+56987469629	kylian.galdames397@puc.cl
10000398-8	Hernán 'Tiburón' Castillo Güler	1980-07-24	Portuguesa	+56941200278	hernan.castillo398@hotmail.com
10000399-6	Pedri 'Hypertornado' Sepúlveda Beausejour	1974-10-19	Brasileña	+56984660997	pedri.sepulveda399@hotmail.com
10000400-3	Juan 'Granrayo' Nuñez Lukaku	1991-12-28	Inglesa	+56920903579	juan.nunez400@uca.cl
10000401-1	Pablo 'Hypergaláctico' Mendoza Muñoz	1990-02-26	Chilena	+56946511626	pablo.mendoza401@outlook.com
10000402-K	Manuel 'Granalmirante' Arias Neuer	1993-09-25	Argentina	+56958547275	manuel.arias402@usach.cl
10000403-8	Matias 'Granrelámpago' Maradona Aránguiz	1972-02-12	Francesa	+56924030923	matias.maradona403@outlook.com
10000404-6	Charles 'Sangalaxia' Figueroa Fernández	1999-08-07	Argentina	+56980470850	charles.figueroa404@usach.cl
10000405-4	Julian 'Megamatador' Bravo Salas	1971-10-03	Alemana	+56928510351	julian.bravo405@hotmail.com
10000406-2	Cristian 'Megatiburón' Suárez Pulgar	1992-08-16	Inglesa	+56981573572	cristian.suarez406@puc.cl
10000407-0	Hernán 'Mastergato' Salah Lukaku	2003-04-11	Argentina	+56919979573	hernan.salah407@puc.cl
10000408-9	Angel 'Kaiser' Isla Contreras	1973-03-08	Chilena	+56953013008	angel.isla408@gmail.com
10000409-7	Joaquín 'Keko' Caszely Lukaku	1978-12-19	Alemana	+56964050808	joaquin.caszely409@gmail.com
10000410-0	Luka 'Ultrakeko' Vásquez Messi	1973-01-20	Portuguesa	+56977701050	luka.vasquez410@puc.cl
10000411-9	Pedro 'Megacaimán' Dybala Lewandowski	2005-11-30	Chilena	+56975125192	pedro.dybala411@puc.cl
10000412-7	Hernán 'Superronaldinho' Cortés Mbappe	1994-01-12	Uruguaya	+56931651158	hernan.cortes412@yahoo.com
10000413-5	Gonzalo 'Superbrujo' Valdés Güler	1992-05-13	Italiana	+56912464378	gonzalo.valdes413@yahoo.com
10000414-3	Lucas 'Granpríncipe' Medel Muñoz	1980-04-21	Colombiana	+56995817098	lucas.medel414@gmail.com
10000415-1	Santiago 'Megapantera' Castro Riquelme	1972-01-01	Argentina	+56983104792	santiago.castro415@puc.cl
10000416-K	Joaquín 'Supercentauro' Hernández Messi	1978-10-23	Francesa	+56941207647	joaquin.hernandez416@puc.cl
10000417-8	Gary 'Ultratiburón' Pizarro Modric	1991-03-23	Colombiana	+56923239887	gary.pizarro417@outlook.com
10000418-6	Alejandro 'Ultratigre' Medel Suárez	1973-03-25	Italiana	+56924136510	alejandro.medel418@hotmail.com
10000419-4	Erick 'Ultrarelámpago' Paredes Mendoza	1986-12-06	Uruguaya	+56994600177	erick.paredes419@usach.cl
10000420-8	Arturo 'Superescudo' Valdés Carrasco	1990-03-27	Inglesa	+56920878145	arturo.valdes420@uca.cl
10000421-6	Gavi 'Chacal' Salas Ramos	1997-06-16	Brasileña	+56915610089	gavi.salas421@gmail.com
10000422-4	Facundo 'Hypercometa' Suazo Dybala	2002-06-07	Inglesa	+56923424128	facundo.suazo422@uca.cl
10000423-2	Matias 'Supermono' Suazo Vargas	1987-09-22	Chilena	+56915048113	matias.suazo423@hotmail.com
10000424-0	Manuel 'Supergaláctico' Maripán Pizarro	1994-09-05	Colombiana	+56980570120	manuel.maripan424@puc.cl
10000425-9	Edinson 'Sanavispón' Tapia Suárez	1994-07-18	Italiana	+56982674120	edinson.tapia425@usach.cl
10000426-7	Cristiano 'Halcón' Valenzuela Mbappe	2004-09-28	Argentina	+56986631239	cristiano.valenzuela426@hotmail.com
10000427-5	Rodrigo 'Masterdragón' Ramos Benzema	2000-05-06	Portuguesa	+56917005866	rodrigo.ramos427@yahoo.com
10000428-3	Arturo 'Mastergalaxia' Pérez Gómez	2002-01-14	Chilena	+56925230365	arturo.perez428@yahoo.com
10000429-1	Romelu 'Hyperrey' Pulgar Modric	1999-06-17	Colombiana	+56921486380	romelu.pulgar429@gmail.com
10000430-5	Agustín 'Ultratrueno' Pizarro Gómez	1992-10-13	Italiana	+56925447904	agustin.pizarro430@uca.cl
10000431-3	Cristiano 'Masterjefe' Vidal Sánchez	1995-12-03	Argentina	+56929801381	cristiano.vidal431@outlook.com
10000432-1	Julian 'Megaguerrero' Araya Neuer	1985-09-05	Peruana	+56949094682	julian.araya432@uca.cl
10000433-K	Romelu 'Megaciclón' Rodri Pulgar	1974-09-22	Portuguesa	+56970326808	romelu.rodri433@gmail.com
10000434-8	Gonzalo 'Megatigre' Salas Riquelme	1980-05-31	Portuguesa	+56983840350	gonzalo.salas434@uca.cl
10000435-6	Gary 'Sanpríncipe' Bravo Lukaku	1990-10-16	Inglesa	+56958981094	gary.bravo435@usach.cl
10000436-4	Daniel 'Megasombra' Cavani Soto	1972-08-30	Portuguesa	+56963768534	daniel.cavani436@puc.cl
10000437-2	Felipe 'Mastermuro' Pizarro Modric	1993-11-07	Alemana	+56920958597	felipe.pizarro437@puc.cl
10000438-0	Angel 'Donpulga' Maripán Gutiérrez	1981-05-21	Chilena	+56937684761	angel.maripan438@usach.cl
10000439-9	Javier 'Ultravolcán' Rodri Suárez	2002-06-10	Colombiana	+56996133708	javier.rodri439@outlook.com
10000440-2	Pedro 'Trueno' Mbappe Salas	1999-01-16	Argentina	+56965806226	pedro.mbappe440@hotmail.com
10000441-0	Matías 'Dontitanio' Ramos Bellingham	1977-09-20	Peruana	+56964792769	matias.ramos441@yahoo.com
10000442-9	Rodrigo 'Ultrafaraón' Díaz Valverde	1974-09-01	Uruguaya	+56926627548	rodrigo.diaz442@outlook.com
10000443-7	Antoine 'Granmuro' Salas Sánchez	1996-08-21	Alemana	+56969839388	antoine.salas443@yahoo.com
10000444-5	Ronaldo 'Superlince' Rodri Pizarro	1988-04-21	Francesa	+56987435236	ronaldo.rodri444@gmail.com
10000445-3	Bautista 'Ultradoctor' Isla Haaland	1989-03-04	Argentina	+56942203564	bautista.isla445@outlook.com
10000446-1	Bautista 'Sanbicho' Medel Díaz	2001-10-08	Portuguesa	+56938586695	bautista.medel446@usach.cl
10000447-K	Neymar 'Megatrueno' Suárez Yamal	1993-12-14	Colombiana	+56980786159	neymar.suarez447@hotmail.com
10000448-8	Gonzalo 'Hypermariscal' Gutiérrez Galdames	2005-08-10	Francesa	+56997340845	gonzalo.gutierrez448@gmail.com
10000449-6	Edinson 'Masterking' Alvarez Arias	1988-05-31	Argentina	+56938604501	edinson.alvarez449@gmail.com
10000450-K	Angel 'Supertorta' Galdames Alvarez	1992-11-13	Brasileña	+56934815184	angel.galdames450@yahoo.com
10000451-8	Marcos 'Granroca' Suazo Yamal	2001-12-01	Argentina	+56957170140	marcos.suazo451@uca.cl
10000452-6	Toni 'Granlince' Bellingham Griezmann	1979-09-11	Peruana	+56952799448	toni.bellingham452@outlook.com
10000453-4	Gonzalo 'Hypercapitán' Bustos Cortés	2002-05-28	Italiana	+56923127568	gonzalo.bustos453@yahoo.com
10000454-2	Harry 'Donhuracán' Ronaldo Gómez	1993-04-02	Alemana	+56980391354	harry.ronaldo454@gmail.com
10000455-0	Luka 'Sanmonarca' Lewandowski Vinicius	2005-11-26	Brasileña	+56997323240	luka.lewandowski455@puc.cl
10000456-9	Johnny 'Doningeniero' Herrera Mendoza	1996-04-01	Alemana	+56911258864	johnny.herrera456@gmail.com
10000457-7	Robert 'Ultraescorpión' Nuñez Torres	1987-04-01	Española	+56935991714	robert.nunez457@yahoo.com
10000458-5	Federico 'Ultrabambino' Toselli Salas	1971-11-30	Brasileña	+56931532348	federico.toselli458@yahoo.com
10000459-3	Arturo 'Ultracomisario' Maradona Mendoza	1994-04-28	Uruguaya	+56927441774	arturo.maradona459@gmail.com
10000460-7	Gavi 'Sanvíbora' Gómez Medel	1992-05-24	Portuguesa	+56935367661	gavi.gomez460@yahoo.com
10000461-5	Kylian 'Sanfénix' Suárez Pérez	1987-09-24	Chilena	+56962905725	kylian.suarez461@uca.cl
10000462-3	Gonzalo 'Masteraraña' Valdivia Herrera	1975-08-02	Uruguaya	+56947908424	gonzalo.valdivia462@yahoo.com
10000463-1	Kevin 'Caballero' Fuentes Salah	1984-03-13	Chilena	+56948417081	kevin.fuentes463@puc.cl
10000464-K	Gonzalo 'Ultraáguila' Caszely Dybala	1989-07-09	Portuguesa	+56953527118	gonzalo.caszely464@puc.cl
10000465-8	Hernán 'Megatanque' Suárez Valdés	1997-01-09	Brasileña	+56987634965	hernan.suarez465@outlook.com
10000466-6	Juan 'Supergalaxia' Rivera Griezmann	2001-05-02	Portuguesa	+56960910891	juan.rivera466@gmail.com
10000467-4	Pablo 'Hyperemperador' Mendoza Gómez	1977-03-15	Portuguesa	+56950031014	pablo.mendoza467@usach.cl
10000468-2	Santiago 'General' Güler Rodri	1979-01-01	Italiana	+56958335313	santiago.güler468@puc.cl
10000469-0	Juan 'Ultracentauro' Reyes Reyes	1971-03-22	Colombiana	+56985720131	juan.reyes469@hotmail.com
10000470-4	Kevin 'Ultraronaldinho' Salah Figueroa	1979-10-13	Uruguaya	+56924302187	kevin.salah470@hotmail.com
10000471-2	Santino 'Ultragrifo' Vargas Alvarez	1988-07-18	Uruguaya	+56963134219	santino.vargas471@uca.cl
10000472-0	Álvaro 'Megacohete' Arias Güler	1987-05-15	Española	+56956320660	alvaro.arias472@usach.cl
10000473-9	Eduardo 'Ultrajaguar' Nuñez Arias	1998-09-01	Italiana	+56913280319	eduardo.nunez473@uca.cl
10000474-7	Carlos 'Hyperterremoto' Müller Reyes	1996-11-26	Brasileña	+56925056411	carlos.müller474@gmail.com
10000475-5	Zinedine 'Grancapitán' Torres Lukaku	2000-10-05	Alemana	+56993813831	zinedine.torres475@usach.cl
10000476-3	Luis 'Donkaiser' Rodríguez Ronaldo	1986-08-17	Colombiana	+56922637304	luis.rodriguez476@puc.cl
10000477-1	David 'Ultracocodrilo' Contreras Herrera	1972-04-28	Italiana	+56989923701	david.contreras477@hotmail.com
10000478-K	Gastón 'Caimán' Mendoza Ronaldo	1970-03-21	Brasileña	+56924228846	gaston.mendoza478@yahoo.com
10000479-8	Lamine 'Ultrafideo' Castillo Caszely	1988-11-19	Italiana	+56933303930	lamine.castillo479@uca.cl
10000480-1	Tomás 'Superalmirante' Rodríguez Suazo	1988-10-04	Colombiana	+56983992509	tomas.rodriguez480@puc.cl
10000481-K	Javier 'Ultratorpedo' Vásquez Vargas	1974-10-25	Española	+56996608541	javier.vasquez481@gmail.com
10000482-8	Jorge 'Dontorta' Salah Alvarez	2004-05-13	Chilena	+56960409662	jorge.salah482@hotmail.com
10000483-6	Bastián 'Donprofesor' Vidal Torres	1987-05-23	Argentina	+56927395171	bastian.vidal483@uca.cl
10000484-4	Jean 'Sanguepardo' Bellingham Caszely	1970-05-08	Argentina	+56964022348	jean.bellingham484@puc.cl
10000485-2	Edinson 'Hypercaimán' Valdés Maradona	1988-01-30	Argentina	+56975880339	edinson.valdes485@usach.cl
10000486-0	Alexis 'Megahalcón' Martínez González	1988-05-03	Argentina	+56972700914	alexis.martinez486@hotmail.com
10000487-9	Sebastián 'Masterhuracán' Pulgar Figueroa	2005-08-08	Inglesa	+56996893111	sebastian.pulgar487@usach.cl
10000488-7	Claudio 'Hyperrinoceronte' Gutiérrez De Bruyne	1998-01-25	Italiana	+56949503235	claudio.gutierrez488@uca.cl
10000489-5	Alexis 'Superking' Pérez Martínez	1974-06-06	Alemana	+56997471355	alexis.perez489@outlook.com
10000490-9	Joaquín 'Sanpuma' Ramos Bravo	2003-10-26	Española	+56953148941	joaquin.ramos490@yahoo.com
10000491-7	Arturo 'Ultramaestro' Vargas Cavani	1982-02-28	Alemana	+56921666487	arturo.vargas491@hotmail.com
10000492-5	Pedri 'Hyperleón' Alvarez Mbappe	1992-01-21	Portuguesa	+56930164772	pedri.alvarez492@hotmail.com
10000493-3	Ignacio 'Hyperáguila' Pizarro Contreras	2002-10-12	Alemana	+56921590702	ignacio.pizarro493@hotmail.com
10000494-1	Jean 'Donking' Rojas Lewandowski	1996-05-15	Brasileña	+56984358730	jean.rojas494@outlook.com
10000495-K	Thomas 'Superterremoto' Lewandowski Cortés	1975-02-25	Argentina	+56992707715	thomas.lewandowski495@uca.cl
10000496-8	Matías 'Roca' Bravo Beausejour	1978-06-09	Uruguaya	+56910102007	matias.bravo496@hotmail.com
10000497-6	Matias 'Cuervo' De Bruyne Sánchez	1974-12-16	Uruguaya	+56923552425	matias.de bruyne497@uca.cl
10000498-4	Martín 'Mastertigre' Cortés Rodri	1998-03-07	Chilena	+56998776549	martin.cortes498@usach.cl
10000499-2	Ezequiel 'Hypercóndor' De Bruyne Güler	1998-11-11	Peruana	+56986368294	ezequiel.de bruyne499@usach.cl
10000500-K	Vicente 'Superfideo' Arias Pizarro	1986-09-30	Italiana	+56952846244	vicente.arias500@usach.cl
10000501-8	Ronaldo 'Donzorro' Galdames Caszely	1990-05-18	Chilena	+56922549942	ronaldo.galdames501@usach.cl
10000502-6	Luciano 'Mastercomisario' Bravo Sánchez	1973-01-28	Española	+56937950119	luciano.bravo502@yahoo.com
10000503-4	Thiago 'Dontigre' Kane Lewandowski	1997-05-09	Portuguesa	+56975501958	thiago.kane503@outlook.com
10000504-2	Marcos 'Mastercañón' Messi Vargas	1994-11-29	Peruana	+56995864029	marcos.messi504@outlook.com
10000505-0	Kevin 'Donterremoto' Messi Saavedra	1987-06-14	Uruguaya	+56933124695	kevin.messi505@outlook.com
10000506-9	Luis 'Donbrujo' Rodri Nuñez	1982-09-03	Francesa	+56954098653	luis.rodri506@gmail.com
10000507-7	Matias 'Megaroca' Fuentes Beausejour	1977-09-22	Brasileña	+56973712328	matias.fuentes507@gmail.com
10000508-5	Neymar 'Barón' Valenzuela Suazo	1994-09-10	Colombiana	+56983043894	neymar.valenzuela508@gmail.com
10000509-3	Marcos 'Espartano' Rojas Carrasco	1972-04-06	Italiana	+56954804378	marcos.rojas509@usach.cl
10000510-7	Erick 'Hyperpantera' Espinoza Mbappe	2004-08-21	Alemana	+56986559039	erick.espinoza510@gmail.com
10000511-5	Hernán 'Megageneral' Zidane Salas	1991-06-26	Peruana	+56999034599	hernan.zidane511@yahoo.com
10000512-3	Agustín 'Donarquitecto' Mendoza Morales	1988-03-06	Alemana	+56959737434	agustin.mendoza512@uca.cl
10000513-1	Gonzalo 'Santrueno' Bustos Hernández	2004-04-06	Brasileña	+56991958969	gonzalo.bustos513@gmail.com
10000514-K	Arturo 'Grancrack' Kroos Müller	1990-12-20	Peruana	+56988872823	arturo.kroos514@yahoo.com
10000515-8	Ignacio 'Cañón' Bravo Lukaku	1988-01-02	Uruguaya	+56969693880	ignacio.bravo515@uca.cl
10000516-6	Gonzalo 'Granpichichi' Zidane De Bruyne	1989-06-20	Chilena	+56913804049	gonzalo.zidane516@uca.cl
10000517-4	Mohamed 'Megahormiga' Kroos González	1992-03-02	Brasileña	+56960893620	mohamed.kroos517@outlook.com
10000518-2	Zinedine 'Ultrakaiser' Güler Aránguiz	1988-12-03	Alemana	+56936633442	zinedine.güler518@usach.cl
10000519-0	Erling 'Megatorpedo' Suazo Sepúlveda	2005-04-02	Colombiana	+56921714522	erling.suazo519@outlook.com
10000520-4	Enzo 'Masteralmirante' Kroos Muñoz	1975-11-03	Colombiana	+56953611820	enzo.kroos520@yahoo.com
10000521-2	Facundo 'Doncaballero' Salah Herrera	1973-09-28	Alemana	+56984934718	facundo.salah521@outlook.com
10000522-0	Álvaro 'Ultrahechicero' Rodríguez Cavani	1993-12-20	Brasileña	+56977905605	alvaro.rodriguez522@hotmail.com
10000523-9	Edinson 'Granpistola' Contreras Müller	1973-01-25	Portuguesa	+56965235781	edinson.contreras523@outlook.com
10000524-7	Luciano 'Hyperrelámpago' Lukaku Torres	2004-09-28	Italiana	+56936450240	luciano.lukaku524@yahoo.com
10000525-5	Jean 'Hyperalmirante' Griezmann Messi	2005-05-26	Argentina	+56994450272	jean.griezmann525@usach.cl
10000526-3	Thomas 'Pistola' Neuer Jara	1997-03-25	Portuguesa	+56973062810	thomas.neuer526@uca.cl
10000527-1	Luka 'Ultrahalcón' Zidane Espinoza	2002-11-14	Inglesa	+56927205226	luka.zidane527@yahoo.com
10000528-K	Santiago 'Hypercomisario' Valdés Salah	1991-12-04	Colombiana	+56953588606	santiago.valdes528@hotmail.com
10000529-8	Luka 'Megapistola' Nuñez Espinoza	1987-07-24	Chilena	+56969911804	luka.nunez529@yahoo.com
10000530-1	Santiago 'Sancometa' De Bruyne Modric	1982-09-06	Portuguesa	+56989749115	santiago.de bruyne530@hotmail.com
10000531-K	Sebastián 'Megamonarca' Vinicius Ramos	1997-05-26	Colombiana	+56973992422	sebastian.vinicius531@usach.cl
10000532-8	Bastián 'Megabicho' Beausejour Reyes	1978-01-19	Brasileña	+56915172490	bastian.beausejour532@yahoo.com
10000533-6	Eduardo 'Ultrapalote' Alvarez Gutiérrez	1974-05-15	Brasileña	+56948269918	eduardo.alvarez533@uca.cl
10000534-4	Esteban 'Megacoto' Isla Suazo	2001-04-26	Inglesa	+56949897516	esteban.isla534@uca.cl
10000535-2	Julian 'Megacobra' Cortés Nuñez	1996-10-03	Colombiana	+56997357315	julian.cortes535@gmail.com
10000536-0	Luciano 'Ultrachacal' Riquelme Isla	1995-05-16	Argentina	+56936625440	luciano.riquelme536@hotmail.com
10000537-9	Ezequiel 'Duque' Zidane Paredes	1975-06-16	Inglesa	+56911592647	ezequiel.zidane537@uca.cl
10000538-7	Javier 'Mastervikingo' Castillo Vásquez	1995-01-06	Brasileña	+56969084515	javier.castillo538@uca.cl
10000539-5	Martín 'Santigre' Vidal Martínez	1999-02-26	Peruana	+56957278749	martin.vidal539@usach.cl
10000540-9	Erling 'Donvíbora' Rodri Rivera	1988-07-11	Chilena	+56911795625	erling.rodri540@hotmail.com
10000541-7	Pablo 'Ultrasoldado' Muñoz Vergara	1984-07-20	Colombiana	+56921838870	pablo.munoz541@outlook.com
10000542-5	Cristian 'Megafénix' Di María Figueroa	2001-10-01	Argentina	+56935673092	cristian.di maria542@puc.cl
10000543-3	Ángel 'Fiscal' Araya Medel	2003-10-20	Uruguaya	+56999715208	angel.araya543@gmail.com
10000544-1	Carlos 'Masterapache' Galdames Ramos	1977-09-14	Brasileña	+56920601339	carlos.galdames544@usach.cl
10000545-K	Joaquín 'Sancomandante' Cavani Valdés	1996-02-15	Alemana	+56924242487	joaquin.cavani545@yahoo.com
10000546-8	Lautaro 'Doncomisario' Castillo Jara	1971-03-02	Francesa	+56933482806	lautaro.castillo546@outlook.com
10000547-6	Tomás 'Donroca' Dybala Kane	1998-01-08	Francesa	+56982106153	tomas.dybala547@hotmail.com
10000548-4	Mauricio 'Hyperpalote' Reyes Ronaldo	1983-06-17	Portuguesa	+56912659275	mauricio.reyes548@yahoo.com
10000549-2	Bastián 'Hypermono' Sánchez Lewandowski	1977-06-27	Española	+56971381218	bastian.sanchez549@gmail.com
10000550-6	Vicente 'Misil' Tapia De Bruyne	1996-06-28	Española	+56960209271	vicente.tapia550@hotmail.com
10000551-4	Luciano 'Hypertigre' Herrera Flores	1986-03-02	Inglesa	+56925317873	luciano.herrera551@puc.cl
10000552-2	Lucas 'Hyperkáiser' Caszely López	1998-02-21	Inglesa	+56939945667	lucas.caszely552@usach.cl
10000553-0	Neymar 'Arquitecto' Soto Valdivia	1972-09-06	Española	+56979705538	neymar.soto553@uca.cl
10000554-9	Alejandro 'Doncometa' Tapia Pizarro	2002-09-10	Italiana	+56937986556	alejandro.tapia554@yahoo.com
10000555-7	Gabriel 'Masterchacal' Suazo Herrera	2003-11-19	Peruana	+56990640803	gabriel.suazo555@outlook.com
10000556-5	Zinedine 'Megavozinha' Espinoza Carrasco	1978-05-05	Francesa	+56994019484	zinedine.espinoza556@yahoo.com
10000557-3	Santino 'Megajaguar' Morales De Bruyne	1973-01-18	Peruana	+56952033351	santino.morales557@gmail.com
10000558-1	Romelu 'Masterzorro' Bustos Gutiérrez	1970-05-04	Uruguaya	+56969997927	romelu.bustos558@usach.cl
10000559-K	Cristian 'Sanbarón' Tapia Vinicius	1987-12-07	Chilena	+56949832538	cristian.tapia559@gmail.com
10000560-3	Sergio 'Superpitón' Lukaku Vergara	1974-08-23	Argentina	+56993641817	sergio.lukaku560@outlook.com
10000561-1	Thomas 'Megatitanio' Sepúlveda Sepúlveda	1985-04-10	Italiana	+56992746241	thomas.sepulveda561@puc.cl
10000562-K	Gary 'Hypervikingo' López Soto	1982-09-26	Colombiana	+56967890146	gary.lopez562@yahoo.com
10000563-8	Gabriel 'Megaturboman' Ronaldo Vinicius	1976-05-09	Argentina	+56962790190	gabriel.ronaldo563@usach.cl
10000564-6	Ezequiel 'Ultraprofesor' Figueroa Morales	2003-10-08	Chilena	+56946466218	ezequiel.figueroa564@puc.cl
10000565-4	Mohamed 'Hyperhormiga' Ramos Rodríguez	1989-03-11	Argentina	+56927800753	mohamed.ramos565@uca.cl
10000566-2	Gonzalo 'Elvozinha' Neuer Güler	1978-09-23	Francesa	+56929256467	gonzalo.neuer566@usach.cl
10000567-0	Mohamed 'Superrelámpago' Ronaldo Vinicius	1982-01-12	Peruana	+56931464463	mohamed.ronaldo567@hotmail.com
10000568-9	Benjamín 'Megaaraña' Beausejour Jara	1971-04-29	Uruguaya	+56950570615	benjamin.beausejour568@uca.cl
10000569-7	Tomás 'Grancomandante' Reyes Vinicius	1995-04-08	Italiana	+56943472349	tomas.reyes569@uca.cl
10000570-0	Gabriel 'Hypervíbora' Galdames Rivera	1980-02-14	Peruana	+56921529590	gabriel.galdames570@usach.cl
10000571-9	Arturo 'Donbarón' Fernández Di María	2001-07-27	Chilena	+56940376227	arturo.fernandez571@usach.cl
10000572-7	Lautaro 'Granmonarca' Flores Espinoza	1984-02-16	Inglesa	+56913726654	lautaro.flores572@uca.cl
10000573-5	Thiago 'Hyperzorro' Gutiérrez Caszely	1986-05-28	Chilena	+56914028047	thiago.gutierrez573@yahoo.com
10000574-3	Maximiliano 'Hypermisil' Bustos Zidane	1992-02-18	Brasileña	+56970019009	maximiliano.bustos574@uca.cl
10000575-1	Bautista 'Ultraguepardo' Yamal Vásquez	2001-05-09	Alemana	+56963206876	bautista.yamal575@gmail.com
10000576-K	Cristiano 'Grantitán' Beausejour Fernández	1999-03-20	Portuguesa	+56924900038	cristiano.beausejour576@uca.cl
10000577-8	Guillermo 'Masterescarabajo' Rivera Flores	1992-06-25	Colombiana	+56981714674	guillermo.rivera577@hotmail.com
10000578-6	Facundo 'Sangaláctico' Morales Cavani	1978-08-15	Italiana	+56915385246	facundo.morales578@hotmail.com
10000579-4	Diego 'Masterrayo' Castillo Araya	1971-05-27	Portuguesa	+56955318849	diego.castillo579@hotmail.com
10000580-8	José 'Masterpuma' Jara Güler	1979-09-27	Uruguaya	+56915264308	jose.jara580@outlook.com
10000581-6	Erick 'Sanpuntero' Zidane Díaz	1991-09-03	Alemana	+56947104071	erick.zidane581@uca.cl
10000582-4	Santiago 'Ultrapuntero' Díaz Gutiérrez	1990-12-25	Italiana	+56970170588	santiago.diaz582@yahoo.com
10000583-2	Álvaro 'Ultratornado' Toselli De Bruyne	1978-03-07	Francesa	+56929853359	alvaro.toselli583@yahoo.com
10000584-0	Guillermo 'Mastercobra' Kane Salah	1982-02-16	Uruguaya	+56970970874	guillermo.kane584@puc.cl
10000585-9	Bastián 'Ultragalaxia' Kane Kane	1986-05-16	Brasileña	+56982308565	bastian.kane585@puc.cl
10000586-7	Diego 'Megapulga' Sánchez Figueroa	1972-12-31	Española	+56922624428	diego.sanchez586@hotmail.com
10000587-5	Mauricio 'Sanmono' Messi Isla	1980-02-01	Colombiana	+56952137242	mauricio.messi587@outlook.com
10000588-3	Sergio 'Mastersombra' Bravo Modric	1998-02-14	Italiana	+56923386423	sergio.bravo588@outlook.com
10000589-1	Esteban 'Grantorta' Flores Ramos	1976-06-03	Brasileña	+56996143774	esteban.flores589@uca.cl
10000590-5	Álvaro 'Grancañón' Ronaldo Salah	1986-01-16	Brasileña	+56924625032	alvaro.ronaldo590@usach.cl
10000591-3	Guillermo 'Megahuaso' Mendoza Rodríguez	2005-10-20	Española	+56955720175	guillermo.mendoza591@puc.cl
10000592-1	Romelu 'Granpitbull' Di María Díaz	1978-04-13	Chilena	+56983651928	romelu.di maria592@outlook.com
10000593-K	Esteban 'Ultradragón' Gómez Salah	1985-10-23	Inglesa	+56989199524	esteban.gomez593@yahoo.com
10000594-8	Edinson 'Sanronaldinho' Kane Yamal	2004-05-03	Alemana	+56979310510	edinson.kane594@outlook.com
10000595-6	Alexis 'Hyperavispón' Isla Kane	1970-04-28	Española	+56982785884	alexis.isla595@puc.cl
10000596-4	Matias 'Granrey' Pizarro Suárez	1982-08-30	Peruana	+56976879632	matias.pizarro596@yahoo.com
10000597-2	Agustín 'Donemperador' Alvarez Lewandowski	2000-11-02	Francesa	+56957835385	agustin.alvarez597@hotmail.com
10000598-0	Jaime 'Hypercapataz' Salah Nuñez	1997-04-28	Francesa	+56974296053	jaime.salah598@puc.cl
10000599-9	Arturo 'Mastermuralla' Caszely Saavedra	1985-04-05	Brasileña	+56949925156	arturo.caszely599@uca.cl
10000600-6	Lautaro 'Masterchapa' Maradona Caszely	1978-03-08	Chilena	+56928417855	lautaro.maradona600@usach.cl
10000601-4	Santino 'Gladiador' Flores Paredes	1973-02-11	Argentina	+56982030552	santino.flores601@yahoo.com
10000602-2	Arturo 'Mastergrifo' Cortés Gutiérrez	1995-01-22	Chilena	+56977287612	arturo.cortes602@yahoo.com
10000603-0	Gabriel 'Masterguerrero' Messi Pérez	1997-12-14	Italiana	+56940869157	gabriel.messi603@puc.cl
10000604-9	Pablo 'Hyperflecha' Torres Yamal	1999-05-23	Inglesa	+56992451358	pablo.torres604@yahoo.com
10000605-7	Álvaro 'Guerrero' Zidane Müller	2000-11-22	Italiana	+56943676427	alvaro.zidane605@uca.cl
10000606-5	Hernán 'Granpiloto' Gutiérrez Morales	1993-05-18	Argentina	+56977064656	hernan.gutierrez606@uca.cl
10000607-3	Martín 'Supermuralla' Riquelme Mendoza	1998-08-28	Peruana	+56931902140	martin.riquelme607@usach.cl
10000608-1	Joaquín 'Granronaldinho' Díaz Castillo	2004-11-11	Brasileña	+56927302705	joaquin.diaz608@outlook.com
10000609-K	Nicolás 'Megagenio' Yamal Valdivia	1999-09-22	Italiana	+56925235002	nicolas.yamal609@gmail.com
10000610-3	Marcos 'Coto' González Griezmann	1983-09-18	Argentina	+56979681827	marcos.gonzalez610@yahoo.com
10000611-1	Santino 'Mastercosmos' Yamal Pizarro	1988-11-07	Uruguaya	+56917883877	santino.yamal611@usach.cl
10000612-K	Ezequiel 'Profesor' Modric Neuer	1975-10-21	Uruguaya	+56965142759	ezequiel.modric612@hotmail.com
10000613-8	Paulo 'Supercóndor' Medel Modric	1991-12-18	Peruana	+56960932495	paulo.medel613@yahoo.com
10000614-6	Francisco 'Supersoldado' Espinoza Espinoza	1974-09-17	Francesa	+56983620935	francisco.espinoza614@puc.cl
10000615-4	Esteban 'Donpatrón' Benzema Pérez	1993-02-10	Uruguaya	+56910996468	esteban.benzema615@gmail.com
10000616-2	Julian 'Mastermeteoro' Maradona Jara	1998-05-22	Inglesa	+56922547004	julian.maradona616@outlook.com
10000617-0	Nicolás 'Supertitanio' Valdivia Cavani	1973-06-27	Argentina	+56918118626	nicolas.valdivia617@gmail.com
10000618-9	Paulo 'Mastersultán' Vidal Cavani	1989-05-22	Chilena	+56929095051	paulo.vidal618@puc.cl
10000619-7	Ángel 'Donconde' Martínez Fernández	1991-11-30	Portuguesa	+56928858956	angel.martinez619@yahoo.com
10000620-0	José 'Sanflecha' Toselli Pérez	2000-05-18	Italiana	+56944011507	jose.toselli620@usach.cl
10000621-9	Alexis 'Gransha' Suazo Di María	1994-09-28	Brasileña	+56973094847	alexis.suazo621@yahoo.com
10000622-7	Gonzalo 'Granjefe' Vidal González	1993-12-14	Francesa	+56964441201	gonzalo.vidal622@puc.cl
10000623-5	Bastián 'Hyperescudo' Bravo Bustos	1975-03-15	Española	+56971809306	bastian.bravo623@uca.cl
10000624-3	Guillermo 'Megaavispa' Arias Caszely	2004-07-30	Brasileña	+56913573656	guillermo.arias624@yahoo.com
10000625-1	Gavi 'Ultrarey' Torres Fuentes	1978-01-17	Colombiana	+56976725236	gavi.torres625@gmail.com
10000626-K	Gonzalo 'Donpitbull' Salas Figueroa	2001-06-06	Peruana	+56982667984	gonzalo.salas626@yahoo.com
10000627-8	Kevin 'Centauro' Vergara Pizarro	1976-03-31	Peruana	+56989387640	kevin.vergara627@uca.cl
10000628-6	Jaime 'Masterdoctor' Castro Jara	1999-08-02	Inglesa	+56982776639	jaime.castro628@hotmail.com
10000629-4	Vicente 'Granpistolero' Yamal Isla	2004-01-02	Inglesa	+56977920535	vicente.yamal629@yahoo.com
10000630-8	Lionel 'Sha' Contreras Díaz	1992-05-30	Uruguaya	+56942282831	lionel.contreras630@yahoo.com
10000631-6	Álvaro 'Meteoro' Silva Kroos	1990-05-01	Portuguesa	+56938019578	alvaro.silva631@hotmail.com
10000632-4	Sergio 'Supercuervo' Muñoz Valdivia	1981-05-31	Chilena	+56975482149	sergio.munoz632@gmail.com
10000633-2	Sebastián 'Megaprofesor' Castro Gutiérrez	1979-07-07	Peruana	+56984685577	sebastian.castro633@usach.cl
10000634-0	Juan 'Hypergeneral' Bustos Güler	1983-09-21	Española	+56946527121	juan.bustos634@puc.cl
10000635-9	Jean 'Hypertorta' Kane Jara	2001-08-04	Brasileña	+56951107748	jean.kane635@outlook.com
10000636-7	Bautista 'Granarquitecto' Cortés Valverde	1995-05-03	Inglesa	+56913030648	bautista.cortes636@hotmail.com
10000637-5	Gonzalo 'Ultraleón' Carrasco Sepúlveda	2003-10-20	Uruguaya	+56937287151	gonzalo.carrasco637@puc.cl
10000638-3	Pablo 'Ronaldinhorápido' De Bruyne Suazo	1970-10-09	Inglesa	+56947990138	pablo.de bruyne638@puc.cl
10000639-1	Rodrigo 'Supertigre' Kroos Beausejour	1991-07-13	Argentina	+56934551196	rodrigo.kroos639@puc.cl
10000640-5	Jean 'Donciclón' Silva Salas	1971-10-06	Inglesa	+56952694835	jean.silva640@yahoo.com
10000641-3	Angel 'Megaleón' Di María Muñoz	1980-01-29	Colombiana	+56958854844	angel.di maria641@puc.cl
10000642-1	Álvaro 'Megamono' Haaland Pizarro	1984-07-06	Española	+56968676964	alvaro.haaland642@hotmail.com
10000643-K	Alexis 'Ultrarayo' Suárez Muñoz	1998-05-25	Alemana	+56945501244	alexis.suarez643@usach.cl
10000644-8	Humberto 'Megadragón' Messi Álvarez	1995-04-26	Francesa	+56968855151	humberto.messi644@yahoo.com
10000645-6	Lautaro 'Superpistola' Flores Maripán	2001-12-21	Italiana	+56982503553	lautaro.flores645@gmail.com
10000646-4	Kylian 'Superdoctor' Modric Riquelme	2005-09-21	Italiana	+56976163148	kylian.modric646@gmail.com
10000647-2	Zinedine 'Granpuntero' Rodríguez Fuentes	1986-04-23	Uruguaya	+56975403838	zinedine.rodriguez647@gmail.com
10000648-0	Alejandro 'Megatoro' Herrera Soto	1970-09-19	Peruana	+56953058294	alejandro.herrera648@outlook.com
10000649-9	Carlos 'Granfiscal' Vergara Pizarro	1985-04-13	Italiana	+56979154081	carlos.vergara649@outlook.com
10000650-2	Alejandro 'Donjaguar' Alvarez Mendoza	1988-05-20	Chilena	+56976166586	alejandro.alvarez650@hotmail.com
10000651-0	Mauricio 'Superescarabajo' Figueroa Caszely	1997-08-18	Inglesa	+56983372489	mauricio.figueroa651@outlook.com
10000652-9	Nicolás 'Cobra' Muñoz Nuñez	1984-01-03	Italiana	+56978677106	nicolas.munoz652@outlook.com
10000653-7	David 'Gransombra' Maradona Lukaku	1978-08-10	Italiana	+56936428357	david.maradona653@usach.cl
10000654-5	Humberto 'César' Rojas Beausejour	1993-01-27	Española	+56952446270	humberto.rojas654@yahoo.com
10000655-3	Gabriel 'Sanjaguar' Kroos Gómez	2003-05-24	Uruguaya	+56915362581	gabriel.kroos655@usach.cl
10000656-1	Karim 'Supervozinha' Suazo Gutiérrez	1997-01-15	Uruguaya	+56969151875	karim.suazo656@yahoo.com
10000657-K	Juan 'Grancometa' Álvarez Morales	1975-12-21	Colombiana	+56941416876	juan.alvarez657@usach.cl
10000658-8	Kevin 'Grantoro' Toselli Müller	1981-10-21	Peruana	+56914141993	kevin.toselli658@hotmail.com
10000659-6	Pedro 'Sanpiloto' Salah Carrasco	1995-08-23	Francesa	+56979589366	pedro.salah659@uca.cl
10000660-K	Esteban 'Ultrabicho' Aránguiz Valdés	1995-05-13	Brasileña	+56962822921	esteban.aranguiz660@uca.cl
10000661-8	Sergio 'Masterninja' Bellingham Benzema	1987-04-01	Argentina	+56994294446	sergio.bellingham661@yahoo.com
10000662-6	Erick 'Hyperhuaso' Contreras Suazo	1986-01-18	Argentina	+56930022643	erick.contreras662@outlook.com
10000664-2	Gary 'Granfénix' Modric Vergara	1989-01-31	Alemana	+56995629317	gary.modric664@puc.cl
10000665-0	Agustín 'Donmaestro' Sepúlveda Fuentes	1991-05-05	Italiana	+56939536114	agustin.sepulveda665@yahoo.com
10000666-9	Sebastián 'Sanalmirante' Salas Salah	1980-05-29	Italiana	+56927950050	sebastian.salas666@yahoo.com
10000667-7	Angel 'Hypercosmos' Vidal Ramos	2001-01-19	Peruana	+56968094846	angel.vidal667@puc.cl
10000668-5	Charles 'Ultrakáiser' Salas Contreras	1989-03-05	Peruana	+56985702169	charles.salas668@outlook.com
10000669-3	Álvaro 'Mastertiburón' Aránguiz Pérez	1999-10-10	Inglesa	+56986879880	alvaro.aranguiz669@hotmail.com
10000670-7	Gabriel 'Mastertoro' Morales Gómez	1992-03-18	Peruana	+56966175740	gabriel.morales670@gmail.com
10000671-5	Charles 'Masteringeniero' López Maradona	1976-12-24	Española	+56977140332	charles.lopez671@usach.cl
10000672-3	Cristiano 'Grangrifo' Valdivia Zidane	1996-10-27	Portuguesa	+56990948418	cristiano.valdivia672@uca.cl
10000673-1	Gary 'Cóndor' Bustos Aránguiz	1977-05-14	Argentina	+56954948603	gary.bustos673@uca.cl
10000674-K	Vicente 'Supersha' Espinoza Soto	1979-07-29	Chilena	+56956726896	vicente.espinoza674@outlook.com
10000675-8	Santiago 'Conde' Suárez Hernández	2003-06-13	Brasileña	+56927957054	santiago.suarez675@gmail.com
10000676-6	Gabriel 'Almirante' Álvarez Suazo	1976-11-27	Portuguesa	+56990286700	gabriel.alvarez676@yahoo.com
10000677-4	Claudio 'Megafaraón' Castro Jara	1980-01-21	Portuguesa	+56961803353	claudio.castro677@hotmail.com
10000678-2	Juan 'Granbambino' Salah Morales	2002-11-18	Brasileña	+56925598081	juan.salah678@puc.cl
10000679-0	Maximiliano 'Masterrelámpago' Sepúlveda Saavedra	1992-05-30	Española	+56986338860	maximiliano.sepulveda679@puc.cl
10000680-4	Alexis 'Hyperninja' Contreras Torres	1976-08-15	Colombiana	+56929925033	alexis.contreras680@uca.cl
10000681-2	Gustavo 'Granmaestro' Ramos Rodri	1981-06-05	Brasileña	+56913818032	gustavo.ramos681@usach.cl
10000682-0	Cristian 'Santiburón' Rodríguez Bravo	1993-10-21	Italiana	+56913459302	cristian.rodriguez682@puc.cl
10000683-9	Julian 'Megaingeniero' Castillo Messi	1984-02-15	Uruguaya	+56971090920	julian.castillo683@usach.cl
10000684-7	Luis 'Sanbrujo' Rodríguez Alvarez	1985-03-06	Brasileña	+56976853659	luis.rodriguez684@hotmail.com
10000685-5	Andrés 'Emperador' Carrasco Sánchez	2002-02-03	Alemana	+56963819883	andres.carrasco685@puc.cl
10000686-3	Julian 'Megarelámpago' Salah Reyes	1985-12-10	Uruguaya	+56996412062	julian.salah686@uca.cl
10000687-1	Angel 'Sanarquitecto' Valverde Neuer	1995-05-12	Inglesa	+56992356872	angel.valverde687@uca.cl
10000688-K	Álvaro 'Hyperduende' Muñoz Rojas	1997-07-12	Brasileña	+56999045672	alvaro.munoz688@gmail.com
10000689-8	Juan 'Hyperpuma' Toselli Hernández	2004-05-18	Chilena	+56951349247	juan.toselli689@outlook.com
10000690-1	Luciano 'Mastercoto' Caszely Bellingham	1999-08-09	Alemana	+56968499126	luciano.caszely690@outlook.com
10000691-K	Martín 'Sanfideo' Valdivia Isla	1986-01-15	Uruguaya	+56980270600	martin.valdivia691@puc.cl
10000692-8	Thiago 'Hyperbúho' Caszely Bellingham	1998-05-25	Italiana	+56976661156	thiago.caszely692@yahoo.com
10000693-6	David 'Hyperprofesor' Arias Rivera	1983-10-25	Uruguaya	+56915938405	david.arias693@outlook.com
10000694-4	Gavi 'Supertitán' Muñoz Neuer	1990-06-05	Uruguaya	+56976765206	gavi.munoz694@yahoo.com
10000695-2	Bautista 'Vozinha' Rojas Medel	1992-12-03	Alemana	+56976242038	bautista.rojas695@usach.cl
10000696-0	Francisco 'Megaguepardo' Haaland Vinicius	1978-07-13	Francesa	+56929802232	francisco.haaland696@yahoo.com
10000697-9	Thiago 'Ultratoro' Jara Nuñez	1971-07-27	Uruguaya	+56967355693	thiago.jara697@gmail.com
10000698-7	Paulo 'Ultrarinoceronte' Riquelme Bravo	1991-02-28	Argentina	+56922216716	paulo.riquelme698@yahoo.com
10000699-5	Bastián 'Ultracacique' Tapia Haaland	1997-05-11	Portuguesa	+56963180161	bastian.tapia699@puc.cl
10000700-2	Matías 'Galáctico' Maradona Mbappe	1995-02-07	Italiana	+56916423582	matias.maradona700@outlook.com
10000701-0	José 'Donvikingo' Fuentes Salah	1973-05-02	Alemana	+56957951170	jose.fuentes701@uca.cl
10000702-9	Francisco 'Megachacal' Nuñez Mbappe	1993-10-14	Uruguaya	+56918550934	francisco.nunez702@usach.cl
10000703-7	Marcos 'Sancobra' Castillo Griezmann	2002-04-20	Brasileña	+56971654796	marcos.castillo703@usach.cl
10000704-5	Guillermo 'Mastermono' Saavedra Álvarez	1987-01-30	Portuguesa	+56939572251	guillermo.saavedra704@outlook.com
10000705-3	Tomás 'Titanio' Vásquez Arias	2003-03-29	Uruguaya	+56961310494	tomas.vasquez705@gmail.com
10000706-1	Jorge 'Mastercóndor' Medel Sepúlveda	1999-01-05	Italiana	+56981532723	jorge.medel706@usach.cl
10000707-K	Mauricio 'Hyperdoctor' Figueroa Rodríguez	1975-11-08	Alemana	+56994309694	mauricio.figueroa707@uca.cl
10000708-8	Thiago 'Santanque' Messi Vinicius	1985-03-16	Uruguaya	+56920373294	thiago.messi708@uca.cl
10000709-6	Gonzalo 'Grantorpedo' Pizarro Bellingham	2003-09-14	Argentina	+56998913830	gonzalo.pizarro709@outlook.com
10000710-K	Luciano 'Pájaro' Maradona Figueroa	1993-02-26	Portuguesa	+56972903542	luciano.maradona710@hotmail.com
10000711-8	Mateo 'Masterhechicero' Lewandowski Kroos	2000-06-24	Alemana	+56939556603	mateo.lewandowski711@puc.cl
10000712-6	Lautaro 'Mastercrack' Suárez Lukaku	1986-09-20	Italiana	+56971853950	lautaro.suarez712@usach.cl
10000713-4	Marcos 'Granpuma' Álvarez Ronaldo	1988-07-04	Colombiana	+56957593710	marcos.alvarez713@usach.cl
10000714-2	Álvaro 'Sanpantera' Vargas Nuñez	1994-06-28	Argentina	+56951303015	alvaro.vargas714@usach.cl
10000715-0	Mateo 'Donlanza' Valdivia Benzema	1998-09-15	Inglesa	+56983177742	mateo.valdivia715@puc.cl
10000716-9	Marcelo 'Hyperconde' Castillo Espinoza	1984-09-20	Española	+56966659647	marcelo.castillo716@gmail.com
10000717-7	Luciano 'Ultragato' Ronaldo Rodri	2005-09-22	Colombiana	+56924964292	luciano.ronaldo717@usach.cl
10000718-5	Federico 'Hyperbarón' Saavedra Rodri	1979-02-13	Inglesa	+56972680699	federico.saavedra718@usach.cl
10000719-3	Guillermo 'Sangrifo' Mendoza Martínez	1987-04-28	Brasileña	+56924881317	guillermo.mendoza719@uca.cl
10000720-7	Lionel 'Ultratitanio' Espinoza Suazo	2005-08-21	Francesa	+56970399260	lionel.espinoza720@gmail.com
10000721-5	Nicolás 'Hypersoldado' Pulgar De Bruyne	1981-11-26	Peruana	+56956969877	nicolas.pulgar721@outlook.com
10000722-3	David 'Mastercaimán' Dybala Ramos	2004-03-06	Brasileña	+56992792385	david.dybala722@outlook.com
10000723-1	Charles 'Granchapa' Castro López	1971-03-16	Alemana	+56998517686	charles.castro723@yahoo.com
10000724-K	Esteban 'Sancomisario' Vargas Carrasco	2005-08-16	Colombiana	+56958226836	esteban.vargas724@gmail.com
10000725-8	Nicolás 'Megagladiador' Benzema Medel	1983-02-13	Brasileña	+56981894298	nicolas.benzema725@puc.cl
10000726-6	Paulo 'Granescarabajo' Cavani Kane	2005-03-09	Italiana	+56969080599	paulo.cavani726@uca.cl
10000727-4	Javier 'Megalobo' Ramos Paredes	1983-05-15	Brasileña	+56980142239	javier.ramos727@gmail.com
10000728-2	Thomas 'Superrifle' Benzema Sepúlveda	2005-10-30	Peruana	+56925363913	thomas.benzema728@usach.cl
10000729-0	Mateo 'Megaáguila' Pizarro Martínez	1993-10-05	Alemana	+56996611279	mateo.pizarro729@uca.cl
10000730-4	Gary 'Sangeneral' Muñoz Castillo	2005-05-10	Española	+56997546085	gary.munoz730@usach.cl
10000731-2	Gustavo 'Megachupete' Isla Herrera	2000-11-19	Italiana	+56956793510	gustavo.isla731@usach.cl
10000732-0	Thomas 'Hyperchacal' Bustos Zidane	1980-01-14	Española	+56977472567	thomas.bustos732@outlook.com
10000733-9	Javier 'Supergeneral' Rodríguez Paredes	1991-08-20	Brasileña	+56911678846	javier.rodriguez733@uca.cl
10000734-7	Eduardo 'Granvikingo' De Bruyne Cortés	1981-06-14	Uruguaya	+56920402887	eduardo.de bruyne734@yahoo.com
10000735-5	Pedro 'Víbora' Álvarez Vásquez	1973-07-16	Brasileña	+56992911746	pedro.alvarez735@hotmail.com
10000736-3	Federico 'Palote' Salas Kroos	1971-02-14	Española	+56973278719	federico.salas736@hotmail.com
10000737-1	Gonzalo 'Grangato' Araya Bravo	1988-08-03	Italiana	+56925769235	gonzalo.araya737@outlook.com
10000738-K	Gonzalo 'Sanapache' Vidal Cortés	1976-04-11	Inglesa	+56972676436	gonzalo.vidal738@usach.cl
10000739-8	Luciano 'Granemperador' De Bruyne Salas	1991-04-26	Española	+56956314211	luciano.de bruyne739@usach.cl
10000740-1	Gastón 'Masterarquitecto' Valverde Cortés	2001-12-30	Española	+56928757594	gaston.valverde740@outlook.com
10000741-K	Humberto 'Sanleón' Dybala Valdés	1977-06-08	Portuguesa	+56948901405	humberto.dybala741@yahoo.com
10000742-8	Cristian 'Doncrack' Díaz Sánchez	1982-06-16	Alemana	+56920991568	cristian.diaz742@usach.cl
10000743-6	Thiago 'Sanmuralla' Modric Vargas	1991-08-02	Uruguaya	+56949595475	thiago.modric743@hotmail.com
10000744-4	Nicolás 'Megapájaro' Kane Pérez	1996-06-27	Portuguesa	+56927143864	nicolas.kane744@uca.cl
10000745-2	Hernán 'Ultrafiscal' Flores Sánchez	1990-07-20	Italiana	+56961561583	hernan.flores745@hotmail.com
10000746-0	Gonzalo 'Ultracomandante' Yamal Morales	1995-12-01	Argentina	+56927966829	gonzalo.yamal746@usach.cl
10000747-9	Benjamín 'Sanpichichi' Kane Dybala	1984-04-07	Portuguesa	+56995793734	benjamin.kane747@yahoo.com
10000748-7	José 'Genio' Rodríguez Haaland	1972-05-14	Italiana	+56927155897	jose.rodriguez748@yahoo.com
10000749-5	David 'Donhalcón' Nuñez Valdivia	1994-07-17	Francesa	+56989806136	david.nunez749@puc.cl
10000750-9	Francisco 'Megaking' Yamal Bustos	1997-08-19	Italiana	+56997038734	francisco.yamal750@gmail.com
10000751-7	Edinson 'Supersombra' Soto Pérez	2000-04-01	Peruana	+56961547334	edinson.soto751@hotmail.com
10000752-5	Ezequiel 'Ultraturboman' Maradona Cavani	1984-05-22	Francesa	+56999730925	ezequiel.maradona752@hotmail.com
10000753-3	Kylian 'Cacique' Saavedra Salas	1991-07-19	Alemana	+56990357247	kylian.saavedra753@hotmail.com
10000754-1	Karim 'Mastervozinha' Paredes Valdés	1979-05-24	Colombiana	+56994085256	karim.paredes754@hotmail.com
10000755-K	Maximiliano 'Ultraaraña' Rivera Vargas	1990-04-08	Italiana	+56941018094	maximiliano.rivera755@usach.cl
10000756-8	Gastón 'Superhuracán' Pérez Castro	1981-06-17	Española	+56933837686	gaston.perez756@usach.cl
10000757-6	Gastón 'Ultrabúho' Bellingham Gómez	1986-01-02	Uruguaya	+56912050160	gaston.bellingham757@yahoo.com
10000758-4	Diego 'Granterremoto' Galdames Modric	1994-10-01	Colombiana	+56994228551	diego.galdames758@outlook.com
10000759-2	Santiago 'Sancoto' Isla Figueroa	2005-06-05	Española	+56929522181	santiago.isla759@yahoo.com
10000760-6	Kylian 'Hyperpiloto' Ronaldo Jara	1971-02-12	Portuguesa	+56930966752	kylian.ronaldo760@yahoo.com
10000761-4	Javier 'Hyperlanza' Riquelme Pizarro	2000-08-24	Inglesa	+56915110391	javier.riquelme761@uca.cl
10000762-2	Agustín 'Masterturboman' Castro Torres	1980-02-01	Inglesa	+56921814107	agustin.castro762@yahoo.com
10000763-0	Pelé 'Megapitbull' Gutiérrez Griezmann	1981-08-28	Peruana	+56940322387	pele.gutierrez763@uca.cl
10000764-9	Álvaro 'Donrinoceronte' Lukaku Martínez	1991-04-15	Uruguaya	+56938682541	alvaro.lukaku764@puc.cl
10000765-7	Edinson 'Donfiscal' Rodríguez González	1982-07-22	Peruana	+56995637507	edinson.rodriguez765@puc.cl
10000766-5	David 'Granguerrero' Paredes Haaland	1990-09-22	Portuguesa	+56941092083	david.paredes766@outlook.com
10000767-3	Vicente 'Ultracrack' Salah Güler	1980-08-05	Francesa	+56917077930	vicente.salah767@outlook.com
10000768-1	Mauricio 'Donpitón' Vergara Tapia	1991-10-09	Alemana	+56959710271	mauricio.vergara768@uca.cl
10000769-K	Juan 'Hyperminotauro' Yamal Riquelme	1975-03-30	Chilena	+56958561101	juan.yamal769@usach.cl
10000770-3	Juan 'Masterpitbull' Fuentes Espinoza	1993-07-01	Uruguaya	+56923694386	juan.fuentes770@usach.cl
10000771-1	Sergio 'Masterpríncipe' Beausejour Martínez	1971-05-13	Francesa	+56999268502	sergio.beausejour771@puc.cl
10000772-K	Gonzalo 'Superpichichi' Tapia Bellingham	1983-06-07	Uruguaya	+56991416802	gonzalo.tapia772@hotmail.com
10000773-8	Paulo 'Dongladiador' Güler Rodri	1993-07-16	Uruguaya	+56930540911	paulo.güler773@puc.cl
10000774-6	Bautista 'Ultrameteoro' Fuentes Suazo	2005-10-06	Francesa	+56949257467	bautista.fuentes774@usach.cl
10000775-4	Erling 'Elchupete' Vidal Torres	1989-03-23	Colombiana	+56930513850	erling.vidal775@gmail.com
10000776-2	David 'Turboman' Vásquez Bravo	1990-08-29	Chilena	+56965321909	david.vasquez776@usach.cl
10000777-0	Raúl 'Superdepredador' Tapia Maripán	2005-01-03	Chilena	+56963542971	raul.tapia777@yahoo.com
10000778-9	Enzo 'Duende' Galdames Sánchez	2003-10-10	Inglesa	+56957280318	enzo.galdames778@outlook.com
10000779-7	Alejandro 'Ultracobra' Di María Dybala	1974-01-17	Uruguaya	+56957434048	alejandro.di maria779@outlook.com
10000780-0	Ignacio 'Megapuma' Saavedra Pérez	1975-03-13	Colombiana	+56972911384	ignacio.saavedra780@hotmail.com
10000781-9	Benjamín 'Dontoro' Paredes Muñoz	1990-12-02	Chilena	+56986033521	benjamin.paredes781@uca.cl
10000782-7	Lucas 'Granhechicero' Arias Zidane	1992-02-19	Inglesa	+56970360124	lucas.arias782@hotmail.com
10000783-5	Gavi 'Grankáiser' Ramos Hernández	1994-07-09	Peruana	+56959727841	gavi.ramos783@uca.cl
10000784-3	Jaime 'Sangladiador' Cortés Messi	1981-04-02	Española	+56993716835	jaime.cortes784@puc.cl
10000785-1	Guillermo 'Supercapitán' Martínez Caszely	1979-03-10	Portuguesa	+56999708624	guillermo.martinez785@gmail.com
10000786-K	Edinson 'Supersatélite' Isla Maripán	1999-03-18	Portuguesa	+56956462260	edinson.isla786@outlook.com
10000787-8	Angel 'Granavispón' Caszely Griezmann	1983-11-24	Argentina	+56973364078	angel.caszely787@puc.cl
10000788-6	Luka 'Grancohete' Di María Haaland	1990-10-29	Colombiana	+56953174339	luka.di maria788@uca.cl
10000789-4	Mateo 'Megagaláctico' Caszely Caszely	1990-07-13	Peruana	+56999749400	mateo.caszely789@yahoo.com
10000790-8	Harry 'Masterpichichi' Torres Medel	1988-01-20	Portuguesa	+56947723922	harry.torres790@outlook.com
10000791-6	Luis 'Ultrapájaro' Salas Dybala	1983-05-25	Inglesa	+56964756834	luis.salas791@puc.cl
10000792-4	Guillermo 'Megamago' Herrera Torres	1994-08-01	Peruana	+56967190672	guillermo.herrera792@uca.cl
10000793-2	Luciano 'Doncésar' Maradona Morales	2003-05-05	Portuguesa	+56922517584	luciano.maradona793@gmail.com
10000794-0	Juan 'Grancaimán' Vergara Vinicius	1992-05-31	Portuguesa	+56964506731	juan.vergara794@usach.cl
10000795-9	Romelu 'Ultrapatrón' Valverde Fuentes	1982-01-18	Argentina	+56979668235	romelu.valverde795@usach.cl
10000796-7	Benjamín 'Granpantera' Modric Figueroa	2001-06-13	Española	+56952161719	benjamin.modric796@gmail.com
10000797-5	Álvaro 'Granlobo' Aránguiz Valenzuela	1975-07-12	Alemana	+56912676010	alvaro.aranguiz797@outlook.com
10000798-3	Pedro 'Megavolcán' Salah Carrasco	1989-02-14	Italiana	+56980633233	pedro.salah798@uca.cl
10000799-1	Andrés 'Sanlince' Medel Fuentes	1985-12-05	Brasileña	+56914010639	andres.medel799@gmail.com
10000800-9	Jorge 'Grancobra' Bravo Maripán	1994-11-28	Uruguaya	+56942842278	jorge.bravo800@hotmail.com
10000801-7	Andrés 'Superfaraón' Tapia Suazo	1992-03-01	Española	+56932606986	andres.tapia801@puc.cl
10000802-5	Daniel 'Hyperronaldinho' Soto Mbappe	1980-01-05	Alemana	+56911509112	daniel.soto802@gmail.com
10000803-3	Felipe 'Terremoto' Reyes Suazo	2000-03-15	Colombiana	+56921024187	felipe.reyes803@hotmail.com
10000804-1	Pablo 'Bicho' Reyes Gutiérrez	1994-06-25	Francesa	+56931382920	pablo.reyes804@gmail.com
10000805-K	Robert 'Graningeniero' Di María Bravo	1996-01-24	Inglesa	+56958835343	robert.di maria805@hotmail.com
10000806-8	Toni 'Pitbull' Gutiérrez Nuñez	1988-10-15	Brasileña	+56942464133	toni.gutierrez806@puc.cl
10000807-6	Johnny 'Ultrachupete' Valverde Castro	1994-11-22	Francesa	+56987836596	johnny.valverde807@outlook.com
10000808-4	Romelu 'Volcán' López Vásquez	1983-09-28	Francesa	+56961040681	romelu.lopez808@hotmail.com
10000809-2	Humberto 'Donronaldinho' Kroos Saavedra	2001-07-24	Colombiana	+56982500136	humberto.kroos809@outlook.com
10000810-6	Thiago 'Sanmariscal' Galdames Hernández	1995-12-26	Francesa	+56973658470	thiago.galdames810@outlook.com
10000811-4	Federico 'Donvozinha' Gómez Mendoza	2002-07-08	Colombiana	+56947596421	federico.gomez811@hotmail.com
10000812-2	Eduardo 'Ultrasultán' Güler Díaz	1990-02-16	Italiana	+56958978741	eduardo.güler812@outlook.com
10000813-0	Zinedine 'Mastertitanio' Rivera Pulgar	1974-02-05	Uruguaya	+56978084712	zinedine.rivera813@puc.cl
10000814-9	Gonzalo 'Donkeko' Reyes Güler	1990-11-25	Portuguesa	+56997351935	gonzalo.reyes814@gmail.com
10000815-7	Bautista 'Ultralobo' Dybala Lewandowski	1990-05-28	Brasileña	+56931560453	bautista.dybala815@uca.cl
10000816-5	Johnny 'Superminotauro' Tapia Modric	1972-05-20	Peruana	+56983024042	johnny.tapia816@gmail.com
10000817-3	Humberto 'Supercrack' Carrasco Benzema	1989-10-26	Colombiana	+56934869371	humberto.carrasco817@outlook.com
10000818-1	Luis 'Ultraking' Tapia Hernández	1975-05-10	Brasileña	+56941515572	luis.tapia818@gmail.com
10000819-K	Karim 'Superavispón' Tapia Carrasco	1978-10-19	Chilena	+56938611738	karim.tapia819@puc.cl
10000820-3	Arturo 'Sanrayo' Caszely Vargas	1999-02-25	Colombiana	+56952420936	arturo.caszely820@yahoo.com
10000821-1	Matias 'Hyperespartano' Zidane Mendoza	2002-11-16	Colombiana	+56966547562	matias.zidane821@usach.cl
10000822-K	Gastón 'Hyperapache' Ramos Valverde	1999-05-03	Portuguesa	+56953178413	gaston.ramos822@usach.cl
10000823-8	Carlos 'Ultraavispón' Álvarez Rodríguez	1970-07-21	Alemana	+56910145871	carlos.alvarez823@usach.cl
10000824-6	Cristiano 'Doncapataz' Bellingham Pizarro	1971-02-17	Peruana	+56950296388	cristiano.bellingham824@outlook.com
10000825-4	Diego 'Granflecha' Valenzuela Arias	1994-07-06	Chilena	+56915972600	diego.valenzuela825@outlook.com
10000826-2	Thiago 'Donmonarca' Kane Toselli	1995-01-18	Uruguaya	+56980305418	thiago.kane826@puc.cl
10000827-0	Luka 'Ultraespartano' Lukaku Rojas	1990-07-26	Chilena	+56936683273	luka.lukaku827@puc.cl
10000828-9	Felipe 'Megaronaldinho' Jara Reyes	1996-02-03	Inglesa	+56972301565	felipe.jara828@gmail.com
10000829-7	Manuel 'Granaraña' Mbappe Dybala	2003-01-02	Portuguesa	+56913178825	manuel.mbappe829@usach.cl
10000830-0	Johnny 'Dondragón' Mendoza Maradona	1989-10-05	Colombiana	+56942200786	johnny.mendoza830@gmail.com
10000831-9	Zinedine 'Supercaballero' Pulgar Morales	1986-09-29	Uruguaya	+56917802082	zinedine.pulgar831@puc.cl
10000832-7	Tomás 'Masteravispón' Salah Maradona	1982-12-30	Brasileña	+56987868265	tomas.salah832@uca.cl
10000833-5	Romelu 'Dondoctor' Ramos Suárez	1989-08-13	Alemana	+56985645424	romelu.ramos833@uca.cl
10000834-3	Mohamed 'Granpitón' Araya Tapia	1994-11-04	Brasileña	+56934857472	mohamed.araya834@uca.cl
10000835-1	Álvaro 'Granchacal' Silva Caszely	1982-04-17	Italiana	+56976533798	alvaro.silva835@usach.cl
10000836-K	Pablo 'Hechicero' Pulgar Vinicius	2003-09-22	Uruguaya	+56972363845	pablo.pulgar836@puc.cl
10000837-8	Gavi 'Dongrifo' Valenzuela Maradona	1992-04-02	Inglesa	+56965764577	gavi.valenzuela837@hotmail.com
10000838-6	Esteban 'Hypercésar' Riquelme Díaz	1971-04-29	Peruana	+56977425411	esteban.riquelme838@usach.cl
10000839-4	Pedro 'Granmago' Galdames Pérez	1980-10-22	Italiana	+56947267466	pedro.galdames839@gmail.com
10000840-8	Gastón 'Sandoctor' Alvarez Hernández	1993-06-08	Argentina	+56950190316	gaston.alvarez840@outlook.com
10000841-6	Benjamín 'Megameteoro' Lukaku Valdés	2001-04-03	Francesa	+56916368952	benjamin.lukaku841@puc.cl
10000842-4	Erick 'Granescudo' Suárez Figueroa	1974-10-01	Colombiana	+56942582866	erick.suarez842@puc.cl
10000843-2	Nicolás 'Doncentauro' Valdivia Flores	1980-05-30	Francesa	+56968269006	nicolas.valdivia843@gmail.com
10000844-0	Antoine 'Granmatador' Nuñez Zidane	1984-03-25	Brasileña	+56966029414	antoine.nunez844@usach.cl
10000845-9	Diego 'Superpiloto' Ramos Rojas	2001-03-18	Peruana	+56954192393	diego.ramos845@yahoo.com
10000846-7	Lucas 'Masterfideo' Bravo Fuentes	1996-10-31	Argentina	+56999452510	lucas.bravo846@yahoo.com
10000847-5	Matías 'Ultrapiloto' Benzema Kroos	1982-09-13	Alemana	+56954468404	matias.benzema847@usach.cl
10000848-3	Martín 'Masterleón' De Bruyne Díaz	1975-07-17	Uruguaya	+56933180949	martin.de bruyne848@yahoo.com
10000849-1	Ángel 'Ultracésar' Vinicius Lukaku	1975-02-17	Francesa	+56964528720	angel.vinicius849@uca.cl
10000850-5	Luciano 'Granlíder' Sepúlveda Silva	1995-01-15	Alemana	+56952733204	luciano.sepulveda850@yahoo.com
10000851-3	Zinedine 'Hypertiburón' Valdivia Sánchez	1979-01-20	Inglesa	+56951087106	zinedine.valdivia851@yahoo.com
10000852-1	Esteban 'Granciclón' Mbappe Mbappe	1978-03-06	Española	+56936669610	esteban.mbappe852@puc.cl
10000853-K	Charles 'Vikingo' Silva Pizarro	1980-09-04	Peruana	+56997498733	charles.silva853@usach.cl
10000854-8	Alejandro 'Hyperguepardo' Riquelme Muñoz	1973-06-09	Argentina	+56916386661	alejandro.riquelme854@uca.cl
10000855-6	Facundo 'Mariscal' Arias Cortés	1979-07-12	Italiana	+56952417655	facundo.arias855@hotmail.com
10000856-4	Thomas 'Supergato' Bellingham Bellingham	1987-03-16	Uruguaya	+56975658189	thomas.bellingham856@outlook.com
10000857-2	Kylian 'Káiser' Lukaku Saavedra	1996-10-06	Alemana	+56955618021	kylian.lukaku857@yahoo.com
10000858-0	Pablo 'Masterpistolero' Figueroa Galdames	2002-08-07	Uruguaya	+56995771070	pablo.figueroa858@outlook.com
10000859-9	Antoine 'Masterconde' Espinoza Muñoz	1975-08-08	Peruana	+56925733632	antoine.espinoza859@puc.cl
10000860-2	Federico 'Gransultán' Martínez Pizarro	2004-10-07	Española	+56960357692	federico.martinez860@hotmail.com
10000861-0	Facundo 'Hyperescarabajo' Valdés Castro	2003-04-13	Peruana	+56941826683	facundo.valdes861@outlook.com
10000862-9	Luka 'Doctor' Muñoz Haaland	1981-09-22	Argentina	+56924127085	luka.munoz862@uca.cl
10000863-7	Pelé 'Ultrazorro' González Flores	1994-12-03	Uruguaya	+56956920817	pele.gonzalez863@uca.cl
10000864-5	Lautaro 'Ultrapistolero' Messi Bravo	1983-12-15	Argentina	+56996371834	lautaro.messi864@gmail.com
10000865-3	Charles 'Hyperpatrón' Rodri Rojas	1979-01-28	Italiana	+56978300253	charles.rodri865@puc.cl
10000866-1	Daniel 'Santurboman' Rodríguez Bellingham	2000-01-17	Argentina	+56930140084	daniel.rodriguez866@yahoo.com
10000867-K	David 'Masterhalcón' Espinoza Dybala	1988-09-14	Peruana	+56950855520	david.espinoza867@uca.cl
10000868-8	Antoine 'Ultrahuracán' Yamal Dybala	1981-12-02	Alemana	+56916857440	antoine.yamal868@outlook.com
10000869-6	José 'Sanlanza' Ronaldo Bellingham	1999-06-05	Italiana	+56953439852	jose.ronaldo869@usach.cl
10000870-K	Mauricio 'Superpitbull' Espinoza Pizarro	1986-02-11	Argentina	+56959526187	mauricio.espinoza870@yahoo.com
10000871-8	Lionel 'Superlobo' Vásquez Álvarez	1996-08-27	Española	+56992447472	lionel.vasquez871@yahoo.com
10000872-6	Kevin 'Superpatrón' González Reyes	1989-08-12	Inglesa	+56986078590	kevin.gonzalez872@gmail.com
10000873-4	Enzo 'Donpríncipe' Mendoza Álvarez	1981-03-11	Francesa	+56957427869	enzo.mendoza873@puc.cl
10000874-2	Bautista 'Donavispa' Nuñez Reyes	1978-09-01	Chilena	+56924058818	bautista.nunez874@puc.cl
10000875-0	Esteban 'Sanhuaso' Valdivia Haaland	1970-11-04	Alemana	+56970120175	esteban.valdivia875@puc.cl
10000876-9	Oscar 'Superroca' Espinoza Arias	1976-08-17	Alemana	+56974289047	oscar.espinoza876@puc.cl
10000877-7	Bautista 'Santorpedo' Güler Castillo	1981-04-15	Colombiana	+56951245816	bautista.güler877@gmail.com
10000878-5	Arturo 'Superpríncipe' González Rodri	1999-12-15	Española	+56939860575	arturo.gonzalez878@gmail.com
10000879-3	Gastón 'Masterterremoto' Vinicius Pérez	1988-07-13	Española	+56933679428	gaston.vinicius879@hotmail.com
10000880-7	Bautista 'Santoro' Ramos Figueroa	1974-01-09	Española	+56912476277	bautista.ramos880@outlook.com
10000881-5	Benjamín 'Masterflecha' Hernández Martínez	2003-08-12	Uruguaya	+56935033053	benjamin.hernandez881@hotmail.com
10000882-3	Toni 'Granespartano' Bellingham Valdés	1985-03-05	Argentina	+56927389881	toni.bellingham882@outlook.com
10000883-1	Marcelo 'Granfaraón' Flores Valenzuela	1978-03-19	Inglesa	+56922329037	marcelo.flores883@usach.cl
10000884-K	Pablo 'Lobo' Valverde Galdames	1994-05-20	Peruana	+56999840619	pablo.valverde884@puc.cl
10000885-8	Cristopher 'Hypergalaxia' Herrera Herrera	1992-07-28	Chilena	+56930175621	cristopher.herrera885@uca.cl
10000886-6	Mateo 'Mono' Soto Figueroa	1999-11-13	Colombiana	+56916535427	mateo.soto886@hotmail.com
10000887-4	Thiago 'Ultramisil' Vargas Güler	1977-02-11	Española	+56959277246	thiago.vargas887@usach.cl
10000888-2	Federico 'Superhormiga' Vinicius Mbappe	1994-10-25	Uruguaya	+56977098050	federico.vinicius888@yahoo.com
10000889-0	Ignacio 'Megacóndor' Vargas Hernández	1981-12-21	Uruguaya	+56991371075	ignacio.vargas889@yahoo.com
10000890-4	Jean 'Santorta' Güler Vergara	1984-01-14	Argentina	+56928273549	jean.güler890@puc.cl
10000891-2	Paulo 'Mastercocodrilo' Zidane Vinicius	1994-03-27	Chilena	+56967247041	paulo.zidane891@yahoo.com
10000892-0	Daniel 'Dontorpedo' Tapia Jara	1978-12-02	Argentina	+56964130510	daniel.tapia892@gmail.com
10000893-9	Sergio 'Dontornado' Hernández Mendoza	1985-02-16	Francesa	+56910205311	sergio.hernandez893@outlook.com
10000894-7	Santiago 'Donmuro' Messi Vidal	1986-07-18	Italiana	+56990396679	santiago.messi894@gmail.com
10000895-5	Lionel 'Sanpájaro' Bustos Suazo	1971-10-30	Alemana	+56947261800	lionel.bustos895@usach.cl
10000896-3	Nicolás 'Donrelámpago' Kane Valdés	1978-08-13	Francesa	+56915645046	nicolas.kane896@gmail.com
10000897-1	Matias 'Masterduende' Soto De Bruyne	1993-05-23	Inglesa	+56963728136	matias.soto897@puc.cl
10000898-K	Pedro 'Hypertoro' Bravo Kane	1982-07-29	Inglesa	+56969467202	pedro.bravo898@uca.cl
10000899-8	Francisco 'Donrifle' Hernández Toselli	1997-10-16	Inglesa	+56990718307	francisco.hernandez899@hotmail.com
10000900-5	Mohamed 'Masterbrujo' Saavedra Galdames	1996-03-29	Italiana	+56999716279	mohamed.saavedra900@outlook.com
10000901-3	Gonzalo 'Granking' Di María Bellingham	1991-09-26	Alemana	+56935401626	gonzalo.di maria901@uca.cl
10000902-1	Raúl 'Superciclón' Castillo Modric	1982-03-30	Uruguaya	+56941877026	raul.castillo902@outlook.com
10000903-K	Johnny 'Megabarón' Nuñez Martínez	2004-02-20	Chilena	+56932600323	johnny.nunez903@hotmail.com
10000904-8	Manuel 'Masterescudo' Carrasco Cavani	1992-10-10	Chilena	+56982975064	manuel.carrasco904@gmail.com
10000905-6	Pedro 'Superrey' Caszely Toselli	1974-12-14	Chilena	+56948150214	pedro.caszely905@uca.cl
10000906-4	Guillermo 'Hypermaestro' Vásquez Castillo	1995-02-21	Alemana	+56919253455	guillermo.vasquez906@puc.cl
10000907-2	Marcos 'Ultracohete' Vásquez González	1971-03-08	Peruana	+56947220374	marcos.vasquez907@uca.cl
10000908-0	Kylian 'Superturboman' Castro Contreras	2000-05-08	Uruguaya	+56960505760	kylian.castro908@yahoo.com
10000909-9	Gonzalo 'Ultraroca' Fernández Saavedra	1983-01-11	Francesa	+56979848582	gonzalo.fernandez909@yahoo.com
10000910-2	Jorge 'Megagrifo' Müller Sepúlveda	1981-12-04	Peruana	+56968190454	jorge.müller910@gmail.com
10000911-0	Lamine 'Satélite' Messi Bellingham	1975-06-18	Italiana	+56974196350	lamine.messi911@outlook.com
10000912-9	Nicolás 'Sancésar' Zidane Galdames	1988-02-05	Italiana	+56953051036	nicolas.zidane912@outlook.com
10000913-7	Manuel 'Hypercentauro' Pizarro Salah	1992-05-17	Uruguaya	+56932585804	manuel.pizarro913@yahoo.com
10000914-5	Sergio 'Ultrasatélite' Ronaldo Figueroa	1980-01-21	Inglesa	+56917868593	sergio.ronaldo914@usach.cl
10000915-3	Santiago 'Avispón' Castillo Cortés	1991-08-05	Chilena	+56957872350	santiago.castillo915@gmail.com
10000916-1	Guillermo 'Hypermuro' Araya Torres	1992-09-30	Argentina	+56911094112	guillermo.araya916@outlook.com
10000917-K	Oscar 'Grancuervo' Fuentes Kroos	1972-11-17	Inglesa	+56940750213	oscar.fuentes917@usach.cl
10000918-8	Gavi 'Hyperescorpión' Álvarez Messi	2001-03-06	Peruana	+56971550375	gavi.alvarez918@puc.cl
10000919-6	Lamine 'Granprofesor' Ronaldo Valdés	1986-09-17	Chilena	+56956048879	lamine.ronaldo919@yahoo.com
10000920-K	Ezequiel 'Sandepredador' Galdames Sánchez	2004-04-07	Portuguesa	+56910789253	ezequiel.galdames920@usach.cl
10000921-8	Santiago 'Granáguila' Gómez Suárez	1975-12-15	Colombiana	+56999435135	santiago.gomez921@hotmail.com
10000922-6	Ángel 'Donlobo' Espinoza Pérez	1982-12-09	Portuguesa	+56972759779	angel.espinoza922@hotmail.com
10000923-4	Thomas 'Donescudo' Vásquez Aránguiz	2002-11-19	Uruguaya	+56946915659	thomas.vasquez923@outlook.com
10000924-2	Toni 'Hypercomandante' Pizarro Haaland	1971-07-27	Colombiana	+56991694756	toni.pizarro924@outlook.com
10000925-0	Guillermo 'Supervíbora' Carrasco Cavani	1980-07-20	Peruana	+56938730983	guillermo.carrasco925@gmail.com
10000926-9	Gonzalo 'Sanfaraón' Caszely Di María	1986-03-22	Francesa	+56921403682	gonzalo.caszely926@gmail.com
10000927-7	Cristiano 'Megamaestro' Gutiérrez Müller	1985-01-16	Uruguaya	+56965826583	cristiano.gutierrez927@uca.cl
10000928-5	Thiago 'Megacuervo' Salah Flores	2005-12-26	Brasileña	+56968965323	thiago.salah928@usach.cl
10000929-3	Martín 'Donsatélite' Fuentes Rojas	1993-08-22	Española	+56987599164	martin.fuentes929@uca.cl
10000930-7	Álvaro 'Supergladiador' Soto Kroos	1998-07-19	Argentina	+56943776411	alvaro.soto930@gmail.com
10000931-5	Pedri 'Doncóndor' Araya Maradona	1985-11-05	Peruana	+56956509792	pedri.araya931@gmail.com
10000932-3	Gonzalo 'Donbambino' Di María Álvarez	1973-05-20	Española	+56920653680	gonzalo.di maria932@outlook.com
10000933-1	Rodrigo 'Supercésar' Carrasco Vásquez	2001-02-11	Uruguaya	+56943264412	rodrigo.carrasco933@outlook.com
10000934-K	Joaquín 'Grancésar' Cortés Lewandowski	1987-03-24	Inglesa	+56941417934	joaquin.cortes934@gmail.com
10000935-8	Carlos 'Supercaimán' Morales Maripán	1981-02-12	Peruana	+56925836887	carlos.morales935@yahoo.com
10000936-6	David 'Mago' Messi Torres	1979-04-25	Española	+56931893964	david.messi936@uca.cl
10000937-4	Lamine 'Príncipe' Nuñez Zidane	1976-04-18	Argentina	+56999516583	lamine.nunez937@yahoo.com
10000938-2	Facundo 'Hyperpichichi' Rodríguez Benzema	1992-12-29	Portuguesa	+56967199680	facundo.rodriguez938@puc.cl
10000939-0	Hernán 'Meganinja' Fernández Morales	1989-08-09	Española	+56980125451	hernan.fernandez939@outlook.com
10000940-4	Neymar 'Megasoldado' Gómez Díaz	1998-11-13	Francesa	+56976512025	neymar.gomez940@yahoo.com
10000941-2	Jean 'Granrinoceronte' Vásquez Paredes	1989-11-07	Brasileña	+56988004949	jean.vasquez941@puc.cl
10000942-0	Benjamín 'Sanpistolero' Paredes Sánchez	1985-11-15	Alemana	+56951958121	benjamin.paredes942@gmail.com
10000943-9	Pedro 'Grantigre' Galdames Fuentes	2005-05-03	Francesa	+56971059885	pedro.galdames943@uca.cl
10000944-7	Bastián 'Megakaiser' Isla Nuñez	1978-09-07	Uruguaya	+56982463985	bastian.isla944@usach.cl
10000945-5	Álvaro 'Masterbicho' Pizarro Ramos	1985-01-25	Uruguaya	+56950047616	alvaro.pizarro945@uca.cl
10000946-3	José 'Ultravíbora' Pizarro Figueroa	1981-06-13	Española	+56982683622	jose.pizarro946@outlook.com
10000947-1	Eduardo 'Sansatélite' Araya Espinoza	2005-09-14	Española	+56961353433	eduardo.araya947@yahoo.com
10000948-K	Martín 'Masterfénix' Pérez Silva	1976-05-15	Portuguesa	+56999962270	martin.perez948@usach.cl
10000949-8	Thiago 'Líder' Araya Soto	1971-09-30	Portuguesa	+56932955175	thiago.araya949@hotmail.com
10000950-1	Luciano 'Mastersatélite' Soto Vinicius	1992-01-13	Brasileña	+56940745000	luciano.soto950@hotmail.com
10000951-K	Tomás 'Sancrack' Valdés Beausejour	1990-10-16	Peruana	+56961906430	tomas.valdes951@gmail.com
10000952-8	Gabriel 'Supercocodrilo' Arias Sánchez	1974-06-17	Italiana	+56973354613	gabriel.arias952@yahoo.com
10000953-6	Jean 'Masterduque' Vásquez Mbappe	1995-05-31	Brasileña	+56938023582	jean.vasquez953@yahoo.com
10000954-4	Hernán 'Donaraña' Kane Nuñez	2003-09-26	Portuguesa	+56951218553	hernan.kane954@hotmail.com
10000955-2	Martín 'Dongenio' Di María Herrera	1975-12-16	Argentina	+56918392379	martin.di maria955@gmail.com
10000956-0	Bautista 'Pulga' Flores Maradona	1992-10-25	Inglesa	+56955698412	bautista.flores956@usach.cl
10000957-9	Eduardo 'Granconde' González Paredes	1978-04-10	Portuguesa	+56969186410	eduardo.gonzalez957@gmail.com
10000958-7	Joaquín 'Ultrafénix' Espinoza Contreras	1984-10-06	Brasileña	+56932338609	joaquin.espinoza958@hotmail.com
10000959-5	Luka 'Sanavispa' Suazo Valverde	1974-02-08	Chilena	+56911656029	luka.suazo959@yahoo.com
10000960-9	Agustín 'Grancacique' Fuentes Yamal	1984-07-18	Alemana	+56913378984	agustin.fuentes960@puc.cl
10000961-7	Luis 'Sanrelámpago' Neuer Isla	1985-05-19	Colombiana	+56933298409	luis.neuer961@puc.cl
10000962-5	Mateo 'Donpuntero' Pizarro Pizarro	1977-11-12	Alemana	+56940052172	mateo.pizarro962@gmail.com
10000963-3	Kylian 'Superpulga' Martínez Sánchez	1986-11-07	Italiana	+56939898405	kylian.martinez963@hotmail.com
10000964-1	Daniel 'Megamariscal' Sepúlveda Galdames	1983-01-27	Alemana	+56920154978	daniel.sepulveda964@uca.cl
10000965-K	Zinedine 'Sanvolcán' Álvarez Hernández	1999-09-25	Peruana	+56914081693	zinedine.alvarez965@usach.cl
10000966-8	Karim 'Granvozinha' Güler Paredes	2004-09-29	Italiana	+56955969157	karim.güler966@usach.cl
10000967-6	Nicolás 'Granturboman' Sánchez Reyes	2003-11-03	Inglesa	+56960148311	nicolas.sanchez967@gmail.com
10000968-4	Robert 'Granbrujo' Vergara Paredes	1985-02-06	Francesa	+56987845405	robert.vergara968@uca.cl
10000969-2	Alejandro 'Masterronaldinho' Castro Zidane	1980-02-13	Chilena	+56929281278	alejandro.castro969@gmail.com
10000970-6	Paulo 'Sanhormiga' Cavani González	1986-03-17	Portuguesa	+56926423872	paulo.cavani970@usach.cl
10000971-4	Juan 'Dontrueno' Haaland Ronaldo	1988-08-04	Alemana	+56943336589	juan.haaland971@hotmail.com
10000972-2	Enzo 'Donpistola' Pizarro Nuñez	1984-05-29	Uruguaya	+56921975004	enzo.pizarro972@puc.cl
10000973-0	Edinson 'Superchapa' Di María Sánchez	2000-07-25	Argentina	+56946441510	edinson.di maria973@usach.cl
10000974-9	Lionel 'Donpalote' Sánchez Pizarro	1996-03-31	Inglesa	+56918599532	lionel.sanchez974@gmail.com
10000975-7	Raúl 'Donduende' Díaz Suárez	1981-05-10	Española	+56975863538	raul.diaz975@outlook.com
10000976-5	Tomás 'Hypercoto' Lukaku Aránguiz	1971-09-02	Portuguesa	+56980454746	tomas.lukaku976@gmail.com
10000977-3	Carlos 'Hyperrifle' López Valdivia	1981-12-17	Colombiana	+56970715386	carlos.lopez977@usach.cl
10000978-1	Romelu 'Hyperjefe' Valdés Valenzuela	1975-02-17	Chilena	+56963652468	romelu.valdes978@puc.cl
10000979-K	Luka 'Doncañón' Castro Pulgar	2004-09-27	Chilena	+56965437023	luka.castro979@gmail.com
10000980-3	Oscar 'Hyperroca' Neuer González	1990-01-08	Francesa	+56958924018	oscar.neuer980@puc.cl
10000981-1	Nicolás 'Hyperkeko' Di María Yamal	1991-02-02	Portuguesa	+56984874488	nicolas.di maria981@usach.cl
10000982-K	Edinson 'Mastersha' Tapia Maradona	1996-04-12	Inglesa	+56990713647	edinson.tapia982@uca.cl
10000983-8	Ezequiel 'Megaapache' Suárez Bustos	1973-12-31	Colombiana	+56940309302	ezequiel.suarez983@gmail.com
10000984-6	Enzo 'Donhechicero' Vargas Ramos	1989-05-28	Peruana	+56971553355	enzo.vargas984@outlook.com
10000985-4	Lamine 'Megapichichi' Díaz Maradona	1981-06-22	Española	+56957668697	lamine.diaz985@hotmail.com
10000986-2	Sebastián 'Dondepredador' Haaland Suárez	2004-09-06	Argentina	+56930125483	sebastian.haaland986@outlook.com
10000987-0	Luciano 'Masteravispa' Hernández Galdames	1987-09-27	Argentina	+56947078616	luciano.hernandez987@outlook.com
10000988-9	Álvaro 'Sancuervo' Pulgar Vinicius	1971-05-03	Francesa	+56978089568	alvaro.pulgar988@hotmail.com
10000989-7	Cristiano 'Chupete' Galdames Modric	1980-07-21	Inglesa	+56933584186	cristiano.galdames989@hotmail.com
10000990-0	Lionel 'Hyperduque' Isla Araya	1988-05-03	Inglesa	+56987323935	lionel.isla990@hotmail.com
10000991-9	Lucas 'Grancomisario' Soto Rivera	1973-03-23	Española	+56950658449	lucas.soto991@outlook.com
10000992-7	Lamine 'Sankaiser' Maripán Rivera	1971-06-18	Chilena	+56913451973	lamine.maripan992@hotmail.com
10000993-5	Santino 'Ultrapuma' Sepúlveda Díaz	1990-04-01	Alemana	+56994595081	santino.sepulveda993@hotmail.com
10000994-3	Esteban 'Grifo' Suárez Vargas	1971-01-01	Italiana	+56969030922	esteban.suarez994@puc.cl
10000995-1	Julian 'Megakáiser' Nuñez Pulgar	1988-08-01	Uruguaya	+56941336625	julian.nunez995@gmail.com
10000996-K	Neymar 'Ultraarquitecto' Caszely Gutiérrez	1985-10-20	Inglesa	+56997191392	neymar.caszely996@yahoo.com
10000997-8	Lautaro 'Ultramatador' Medel Araya	1993-01-30	Italiana	+56955229463	lautaro.medel997@outlook.com
10000998-6	Julian 'Megabúho' Neuer Modric	1971-07-16	Uruguaya	+56976547044	julian.neuer998@puc.cl
10000999-4	Jean 'Ultraemperador' Contreras Pérez	2002-05-30	Peruana	+56922614820	jean.contreras999@yahoo.com
10001000-3	Johnny 'Hyperking' Castro Toselli	1979-08-31	Italiana	+56949042414	johnny.castro1000@uca.cl
10001001-1	Diego Valdés Reyes	1998-11-18	Chilena	+56967956433	diego.valdes1001@uca.cl
10001002-K	Pablo Medel Fuentes	1972-09-05	Chilena	+56948646486	pablo.medel1002@puc.cl
10001003-8	Lamine Martínez Vásquez	1991-02-04	Chilena	+56979850594	lamine.martinez1003@puc.cl
10001004-6	Esteban Pulgar Dybala	1972-10-20	Chilena	+56924680789	esteban.pulgar1004@gmail.com
10001005-4	Jean Isla Zidane	1991-04-05	Chilena	+56937330488	jean.isla1005@hotmail.com
10001006-2	Álvaro Carrasco Cortés	1994-08-21	Colombiana	+56941490164	alvaro.carrasco1006@outlook.com
10001007-0	Esteban Beausejour Müller	1980-10-27	Chilena	+56913816339	esteban.beausejour1007@hotmail.com
10001008-9	Ronaldo Güler Araya	1978-12-09	Chilena	+56961755388	ronaldo.güler1008@hotmail.com
10001009-7	Pedri Rodri Isla	1994-12-25	Chilena	+56930547905	pedri.rodri1009@yahoo.com
10001010-0	Vicente Beausejour Modric	1991-05-30	Chilena	+56970697625	vicente.beausejour1010@usach.cl
10001011-9	Enzo Pérez Vidal	1972-04-10	Chilena	+56967465433	enzo.perez1011@outlook.com
10001012-7	Toni Suazo Castillo	2003-04-14	Chilena	+56940504847	toni.suazo1012@yahoo.com
10001013-5	Santino Vásquez Tapia	1984-11-10	Chilena	+56935252927	santino.vasquez1013@usach.cl
10001014-3	Rodrigo Zidane Díaz	1981-12-21	Argentina	+56999900374	rodrigo.zidane1014@puc.cl
10001015-1	Julian Bellingham Kroos	1973-03-30	Chilena	+56933461589	julian.bellingham1015@usach.cl
10001016-K	Kylian Vásquez Sánchez	1975-10-22	Chilena	+56935712297	kylian.vasquez1016@usach.cl
10001017-8	Alexis Aránguiz Díaz	1993-08-18	Uruguaya	+56927955255	alexis.aranguiz1017@yahoo.com
10001018-6	Santiago Arias Álvarez	2001-02-09	Chilena	+56999412835	santiago.arias1018@puc.cl
10001019-4	Rodrigo Messi Alvarez	1988-07-14	Chilena	+56958384870	rodrigo.messi1019@usach.cl
10001020-8	Romelu Silva Ronaldo	1974-09-23	Uruguaya	+56956149248	romelu.silva1020@gmail.com
10001021-6	Felipe Arias Lewandowski	1993-06-03	Chilena	+56963431811	felipe.arias1021@gmail.com
10001022-4	Gavi Flores Mendoza	1987-08-06	Chilena	+56987894258	gavi.flores1022@puc.cl
10001023-2	Marcelo Müller Mbappe	1993-06-16	Chilena	+56942639906	marcelo.müller1023@outlook.com
10001024-0	Ronaldo Rojas Messi	1993-03-31	Chilena	+56911585265	ronaldo.rojas1024@uca.cl
10001025-9	Gustavo Muñoz Dybala	1970-11-11	Chilena	+56986339253	gustavo.munoz1025@yahoo.com
10001026-7	Gonzalo Sepúlveda Pulgar	1992-11-11	Argentina	+56982951794	gonzalo.sepulveda1026@uca.cl
10001027-5	Jaime Muñoz Bellingham	2002-12-06	Chilena	+56934320773	jaime.munoz1027@uca.cl
10001028-3	Hernán Yamal Torres	1978-09-28	Chilena	+56978774879	hernan.yamal1028@puc.cl
10001029-1	Cristopher Martínez Jara	1977-11-12	Chilena	+56946266532	cristopher.martinez1029@usach.cl
10001030-5	Bastián Soto Gómez	1980-08-19	Inglesa	+56986923940	bastian.soto1030@puc.cl
10001031-3	Mauricio Gutiérrez Espinoza	1978-05-04	Chilena	+56971070110	mauricio.gutierrez1031@usach.cl
10001032-1	Mauricio Zidane Vergara	2005-05-06	Argentina	+56933630022	mauricio.zidane1032@puc.cl
10001033-K	Diego Mbappe Pulgar	1985-07-13	Uruguaya	+56988904000	diego.mbappe1033@outlook.com
10001034-8	Mauricio Alvarez Benzema	2001-09-23	Chilena	+56937639758	mauricio.alvarez1034@hotmail.com
10001035-6	Carlos Neuer Riquelme	1998-03-01	Chilena	+56999906187	carlos.neuer1035@outlook.com
10001036-4	Diego Herrera Morales	1986-08-01	Chilena	+56922292145	diego.herrera1036@puc.cl
10001037-2	Gary Bustos Rojas	2002-01-09	Chilena	+56984683883	gary.bustos1037@hotmail.com
10001038-0	Vicente Bellingham Gutiérrez	1993-05-18	Chilena	+56976837473	vicente.bellingham1038@uca.cl
10001039-9	Daniel Rivera Gutiérrez	1999-09-14	Chilena	+56987993544	daniel.rivera1039@gmail.com
10001040-2	Gabriel Benzema Soto	1994-12-15	Chilena	+56940969609	gabriel.benzema1040@outlook.com
10001041-0	Luka Ramos Ramos	1976-10-10	Chilena	+56972527140	luka.ramos1041@outlook.com
10001042-9	Robert Castillo Mendoza	1992-08-30	Chilena	+56912706323	robert.castillo1042@outlook.com
10001043-7	Luka Reyes De Bruyne	1985-01-22	Chilena	+56953880555	luka.reyes1043@yahoo.com
10001044-5	Juan Suazo Messi	1972-07-28	Chilena	+56998142304	juan.suazo1044@outlook.com
10001045-3	Angel Espinoza Haaland	1986-12-08	Colombiana	+56937514933	angel.espinoza1045@yahoo.com
10001046-1	Sergio Bellingham Benzema	1976-03-12	Chilena	+56982372354	sergio.bellingham1046@uca.cl
10001047-K	Julian Díaz Di María	1990-09-09	Chilena	+56965966208	julian.diaz1047@uca.cl
10001048-8	Kevin Araya Benzema	1971-03-24	Chilena	+56972525521	kevin.araya1048@hotmail.com
10001049-6	Esteban González Reyes	2003-07-01	Chilena	+56990293891	esteban.gonzalez1049@hotmail.com
10001050-K	Mohamed Araya Bustos	1993-10-09	Italiana	+56965286832	mohamed.araya1050@gmail.com
10001051-8	Carlos Bustos González	1981-12-21	Chilena	+56931992991	carlos.bustos1051@uca.cl
10001052-6	Claudio Araya Tapia	1995-06-01	Chilena	+56938024336	claudio.araya1052@uca.cl
10001053-4	Thomas Vásquez Griezmann	1972-10-20	Chilena	+56977587774	thomas.vasquez1053@hotmail.com
10001054-2	Kylian Lukaku Kane	1996-11-11	Chilena	+56919160072	kylian.lukaku1054@puc.cl
10001055-0	Santiago Reyes Pérez	1989-03-05	Francesa	+56958881381	santiago.reyes1055@yahoo.com
10001056-9	Lucas Morales Suárez	1981-09-08	Chilena	+56981623228	lucas.morales1056@usach.cl
10001057-7	Lautaro Espinoza Lukaku	1974-01-24	Chilena	+56977137151	lautaro.espinoza1057@hotmail.com
10001058-5	Luciano Contreras González	1995-10-03	Chilena	+56941457293	luciano.contreras1058@hotmail.com
10001059-3	Raúl Arias Pulgar	1987-05-29	Chilena	+56964590607	raul.arias1059@gmail.com
10001060-7	Bastián Salah Sepúlveda	2000-03-20	Chilena	+56948957457	bastian.salah1060@yahoo.com
10001061-5	Álvaro Dybala Saavedra	1989-01-22	Chilena	+56954045451	alvaro.dybala1061@usach.cl
10001062-3	Benjamín Kroos Toselli	1994-07-04	Uruguaya	+56963578874	benjamin.kroos1062@uca.cl
10001063-1	Arturo Díaz Müller	1992-01-09	Chilena	+56974276690	arturo.diaz1063@puc.cl
10001064-K	Tomás Alvarez Cortés	1999-06-09	Chilena	+56948857768	tomas.alvarez1064@hotmail.com
10001065-8	Pedro Sánchez Muñoz	2000-09-29	Chilena	+56958944086	pedro.sanchez1065@yahoo.com
10001066-6	Gavi Cavani Caszely	1985-11-20	Chilena	+56926107911	gavi.cavani1066@uca.cl
10001067-4	Manuel Suazo Rivera	1994-11-05	Chilena	+56927769287	manuel.suazo1067@gmail.com
10001068-2	Pedro Kane Mbappe	1974-06-14	Chilena	+56948201029	pedro.kane1068@usach.cl
10001069-0	José Isla González	1982-01-03	Española	+56964127774	jose.isla1069@usach.cl
10001070-4	Julian Kroos Silva	1971-06-29	Chilena	+56961463446	julian.kroos1070@puc.cl
10001071-2	Mohamed Sepúlveda Fernández	1987-12-16	Chilena	+56961358754	mohamed.sepulveda1071@uca.cl
10001072-0	Daniel Pizarro Figueroa	1981-06-16	Peruana	+56958657255	daniel.pizarro1072@hotmail.com
10001073-9	Charles Beausejour Beausejour	1993-02-20	Chilena	+56987432470	charles.beausejour1073@uca.cl
10001074-7	Robert Saavedra Gómez	1988-08-02	Chilena	+56982824191	robert.saavedra1074@uca.cl
10001075-5	Jaime Maripán Jara	1982-05-01	Portuguesa	+56965954676	jaime.maripan1075@puc.cl
10001076-3	Santino Carrasco Valverde	1989-03-04	Chilena	+56980516207	santino.carrasco1076@yahoo.com
10001077-1	Toni Muñoz Cavani	1987-09-21	Chilena	+56945880197	toni.munoz1077@outlook.com
10001078-K	Gavi Figueroa Güler	2000-11-19	Inglesa	+56973285733	gavi.figueroa1078@yahoo.com
10001079-8	Vicente Fernández Fernández	1970-06-10	Colombiana	+56913795730	vicente.fernandez1079@hotmail.com
10001080-1	Hernán Muñoz Vidal	1972-06-11	Portuguesa	+56930022019	hernan.munoz1080@puc.cl
10001081-K	Matías Espinoza Flores	1971-07-07	Chilena	+56971939786	matias.espinoza1081@yahoo.com
10001082-8	Humberto Vidal González	1994-04-29	Chilena	+56984939636	humberto.vidal1082@puc.cl
10001083-6	Neymar Contreras Sánchez	1995-03-23	Chilena	+56957915685	neymar.contreras1083@usach.cl
10001084-4	Antoine Silva Bellingham	1995-03-03	Chilena	+56912650117	antoine.silva1084@puc.cl
10001085-2	Gastón Salah Rodríguez	1983-12-10	Inglesa	+56961888076	gaston.salah1085@outlook.com
10001086-0	Mateo Kane Salas	1976-06-13	Chilena	+56944289943	mateo.kane1086@hotmail.com
10001087-9	Marcelo Reyes Galdames	1985-06-22	Chilena	+56919469477	marcelo.reyes1087@hotmail.com
10001088-7	Romelu Valdivia Figueroa	2005-08-20	Alemana	+56912515144	romelu.valdivia1088@outlook.com
10001089-5	Jaime Contreras Benzema	1971-04-02	Chilena	+56935318923	jaime.contreras1089@uca.cl
10001090-9	Romelu Benzema De Bruyne	1974-08-17	Chilena	+56982172880	romelu.benzema1090@usach.cl
10001091-7	Bastián Zidane Yamal	1982-10-22	Chilena	+56947147843	bastian.zidane1091@outlook.com
10001092-5	Zinedine Fuentes Zidane	1989-10-13	Chilena	+56934130204	zinedine.fuentes1092@hotmail.com
10001093-3	Jaime Suazo Mendoza	1971-07-05	Chilena	+56929207799	jaime.suazo1093@gmail.com
10001094-1	Alejandro Muñoz Toselli	1999-02-26	Chilena	+56925749938	alejandro.munoz1094@usach.cl
10001095-K	Johnny Müller Gutiérrez	1974-04-19	Chilena	+56921655086	johnny.müller1095@yahoo.com
10001096-8	Santiago Griezmann Riquelme	1981-05-07	Chilena	+56913251227	santiago.griezmann1096@gmail.com
10001097-6	Neymar Maradona Valverde	1983-08-05	Chilena	+56968352649	neymar.maradona1097@gmail.com
10001098-4	Cristopher Paredes Herrera	1974-06-29	Chilena	+56996336589	cristopher.paredes1098@usach.cl
10001099-2	Facundo Vásquez Figueroa	1973-12-09	Chilena	+56938786707	facundo.vasquez1099@puc.cl
10001100-K	Lionel Alvarez Yamal	2001-01-12	Chilena	+56972615573	lionel.alvarez1100@usach.cl
10001101-8	Bautista Valdés Lewandowski	1977-08-27	Chilena	+56992856461	bautista.valdes1101@yahoo.com
10001102-6	Bastián Paredes Pizarro	1991-08-12	Chilena	+56911242506	bastian.paredes1102@puc.cl
10001103-4	Manuel González Lukaku	1994-03-20	Chilena	+56943521381	manuel.gonzalez1103@usach.cl
10001104-2	Alejandro Cortés Contreras	1988-08-05	Chilena	+56916575683	alejandro.cortes1104@puc.cl
10001105-0	Ezequiel Toselli Kane	1975-07-22	Chilena	+56952166773	ezequiel.toselli1105@puc.cl
10001106-9	Pelé Di María Di María	2002-05-30	Francesa	+56961083663	pele.di maria1106@uca.cl
10001107-7	Angel Benzema Haaland	1981-09-16	Peruana	+56916941345	angel.benzema1107@hotmail.com
10001108-5	Luciano Carrasco Díaz	1996-04-11	Chilena	+56952604741	luciano.carrasco1108@gmail.com
10001109-3	Gonzalo Griezmann Contreras	1972-10-01	Chilena	+56911037184	gonzalo.griezmann1109@usach.cl
10001110-7	Jean Pérez Isla	1989-05-31	Chilena	+56997273846	jean.perez1110@gmail.com
10001111-5	Arturo Salah Arias	2002-04-17	Colombiana	+56985748682	arturo.salah1111@gmail.com
10001112-3	Marcos Fernández Di María	1976-02-21	Francesa	+56979461369	marcos.fernandez1112@usach.cl
10001113-1	Francisco Fuentes Lewandowski	2003-01-27	Chilena	+56949771148	francisco.fuentes1113@puc.cl
10001114-K	Cristopher Beausejour Flores	1989-06-01	Chilena	+56946303294	cristopher.beausejour1114@puc.cl
10001115-8	Erick Müller Maripán	1978-04-03	Uruguaya	+56954750372	erick.müller1115@puc.cl
10001116-6	Claudio Pulgar Cortés	1973-04-28	Alemana	+56951082093	claudio.pulgar1116@puc.cl
10001117-4	Gavi Valdés Suárez	1990-05-07	Chilena	+56940204627	gavi.valdes1117@puc.cl
10001118-2	Ronaldo Pizarro Müller	2002-11-17	Inglesa	+56916918988	ronaldo.pizarro1118@hotmail.com
10001119-0	Felipe Rojas Zidane	1993-08-17	Alemana	+56957656420	felipe.rojas1119@outlook.com
10001120-4	Ignacio Silva Reyes	2004-10-31	Chilena	+56910019712	ignacio.silva1120@yahoo.com
10001121-2	Neymar Maradona Haaland	1997-12-19	Chilena	+56981894589	neymar.maradona1121@puc.cl
10001122-0	Marcelo Lewandowski Riquelme	1979-05-27	Chilena	+56915648124	marcelo.lewandowski1122@outlook.com
10001123-9	Lautaro Rojas Sepúlveda	1992-05-29	Chilena	+56965665391	lautaro.rojas1123@gmail.com
10001124-7	Guillermo Vásquez Güler	1984-04-14	Argentina	+56944863213	guillermo.vasquez1124@puc.cl
10001125-5	Pedri Sánchez Bravo	1982-12-14	Chilena	+56999691752	pedri.sanchez1125@usach.cl
10001126-3	Gabriel Mbappe Paredes	2002-04-25	Chilena	+56969341258	gabriel.mbappe1126@uca.cl
10001127-1	Zinedine Morales Riquelme	1987-10-19	Inglesa	+56976514435	zinedine.morales1127@outlook.com
10001128-K	Eduardo Hernández Nuñez	1972-05-15	Chilena	+56917737080	eduardo.hernandez1128@uca.cl
10001129-8	Mohamed Díaz Morales	2000-01-31	Chilena	+56994513317	mohamed.diaz1129@yahoo.com
10001130-1	Guillermo Gutiérrez Paredes	1996-06-14	Chilena	+56972650439	guillermo.gutierrez1130@uca.cl
10001131-K	Hernán Figueroa Saavedra	1994-10-19	Chilena	+56941103670	hernan.figueroa1131@uca.cl
10001132-8	Enzo Messi Ronaldo	1973-11-03	Chilena	+56984034903	enzo.messi1132@puc.cl
10001133-6	Mauricio Rodríguez Alvarez	2002-03-17	Chilena	+56948341173	mauricio.rodriguez1133@outlook.com
10001134-4	Javier Nuñez Ronaldo	1997-08-31	Argentina	+56995010221	javier.nunez1134@uca.cl
10001135-2	Mohamed Isla Nuñez	1983-02-22	Española	+56965505401	mohamed.isla1135@usach.cl
10001136-0	Ignacio Dybala Mbappe	1994-09-29	Chilena	+56998409646	ignacio.dybala1136@puc.cl
10001137-9	Erick Gutiérrez Valverde	1978-08-11	Chilena	+56970866337	erick.gutierrez1137@yahoo.com
10001138-7	Oscar Vinicius Pizarro	1996-03-08	Chilena	+56950905239	oscar.vinicius1138@uca.cl
10001139-5	Zinedine Vargas Sánchez	1987-07-25	Chilena	+56976974681	zinedine.vargas1139@puc.cl
10001140-9	Mohamed López Rodríguez	1997-06-02	Chilena	+56944500646	mohamed.lopez1140@gmail.com
10001141-7	Vicente Torres Torres	2003-03-19	Chilena	+56952621258	vicente.torres1141@gmail.com
10001142-5	Mohamed Maradona Torres	1971-12-29	Chilena	+56932342199	mohamed.maradona1142@yahoo.com
10001143-3	Antoine Vásquez González	1995-05-10	Chilena	+56923113480	antoine.vasquez1143@puc.cl
10001144-1	Luciano Neuer Fuentes	1993-08-24	Chilena	+56954839245	luciano.neuer1144@uca.cl
10001145-K	Facundo Castro Muñoz	1985-10-02	Chilena	+56933636445	facundo.castro1145@usach.cl
10001146-8	Rodrigo Rojas Güler	1976-11-06	Colombiana	+56933692863	rodrigo.rojas1146@yahoo.com
10001147-6	Thiago Rivera Tapia	1973-12-15	Peruana	+56949825696	thiago.rivera1147@hotmail.com
10001148-4	Gavi Pulgar Arias	1979-09-02	Chilena	+56910579064	gavi.pulgar1148@usach.cl
10001149-2	Facundo Muñoz Kroos	1971-04-20	Chilena	+56953112664	facundo.munoz1149@gmail.com
10001150-6	Santino López Benzema	1977-07-29	Chilena	+56939887520	santino.lopez1150@usach.cl
10001151-4	Johnny Neuer Modric	1988-07-19	Chilena	+56964065626	johnny.neuer1151@gmail.com
10001152-2	Erling Rodríguez Martínez	1979-06-10	Chilena	+56998597000	erling.rodriguez1152@hotmail.com
10001153-0	Matías Pizarro Maripán	1983-11-28	Chilena	+56917496104	matias.pizarro1153@uca.cl
10001154-9	Sergio Reyes Neuer	1987-02-21	Chilena	+56945170124	sergio.reyes1154@uca.cl
10001155-7	Luis Güler Maripán	1972-11-15	Chilena	+56939017361	luis.güler1155@puc.cl
10001156-5	Enzo Silva Valenzuela	1990-09-10	Chilena	+56926290561	enzo.silva1156@puc.cl
10001157-3	Bautista González Valenzuela	1973-12-14	Chilena	+56948291412	bautista.gonzalez1157@outlook.com
10001158-1	Lautaro Cortés Güler	1980-06-30	Argentina	+56923410368	lautaro.cortes1158@puc.cl
10001159-K	Thomas Carrasco Espinoza	1978-04-01	Alemana	+56963320422	thomas.carrasco1159@gmail.com
10001160-3	Santiago Pizarro Suárez	1971-08-09	Argentina	+56950102808	santiago.pizarro1160@puc.cl
10001161-1	Marcelo Rojas Martínez	1992-09-09	Chilena	+56963366277	marcelo.rojas1161@puc.cl
10001162-K	Santino Rodri Salah	1970-01-23	Chilena	+56983795248	santino.rodri1162@outlook.com
10001163-8	Pedro Messi Pulgar	1980-09-25	Chilena	+56963409820	pedro.messi1163@hotmail.com
10001164-6	Tomás Díaz Torres	1997-03-02	Brasileña	+56954022352	tomas.diaz1164@gmail.com
10001165-4	Maximiliano Pizarro Lukaku	2002-07-03	Chilena	+56957493842	maximiliano.pizarro1165@usach.cl
10001166-2	Juan Salas Gutiérrez	1994-01-28	Portuguesa	+56935939974	juan.salas1166@gmail.com
10001167-0	Kevin Fernández Ronaldo	1970-05-22	Chilena	+56926067710	kevin.fernandez1167@puc.cl
10001168-9	Karim Cortés Valenzuela	1999-01-28	Brasileña	+56993286357	karim.cortes1168@puc.cl
10001169-7	Luis Ronaldo Bellingham	1992-09-01	Chilena	+56975643661	luis.ronaldo1169@outlook.com
10001170-0	Pelé Yamal Fernández	1994-09-23	Chilena	+56931541999	pele.yamal1170@puc.cl
10001171-9	Zinedine Neuer Vergara	1986-07-11	Chilena	+56930254725	zinedine.neuer1171@outlook.com
10001172-7	Humberto Paredes Sánchez	2004-02-22	Argentina	+56961017662	humberto.paredes1172@puc.cl
10001173-5	Raúl Paredes Vinicius	1974-04-13	Colombiana	+56944851143	raul.paredes1173@hotmail.com
10001174-3	Cristopher Ronaldo Haaland	1974-08-17	Inglesa	+56955188525	cristopher.ronaldo1174@gmail.com
10001175-1	Agustín Suárez Modric	1972-06-14	Chilena	+56934209399	agustin.suarez1175@gmail.com
10001176-K	Matias Alvarez Valenzuela	1982-08-18	Inglesa	+56976507682	matias.alvarez1176@hotmail.com
10001177-8	Oscar Aránguiz Riquelme	1994-03-22	Chilena	+56959092105	oscar.aranguiz1177@usach.cl
10001178-6	Esteban Tapia Mbappe	1991-11-23	Chilena	+56994967924	esteban.tapia1178@usach.cl
10001179-4	Cristiano Vinicius Fernández	2005-01-24	Chilena	+56983166464	cristiano.vinicius1179@usach.cl
10001180-8	Matías Suárez Medel	1996-10-05	Chilena	+56945777538	matias.suarez1180@gmail.com
10001181-6	Felipe Rojas Bravo	1993-11-28	Chilena	+56993486544	felipe.rojas1181@puc.cl
10001182-4	Javier Neuer Vásquez	2001-06-20	Española	+56959775962	javier.neuer1182@puc.cl
10001183-2	Felipe Vergara López	1970-11-28	Chilena	+56946907079	felipe.vergara1183@uca.cl
10001184-0	Francisco Bravo Salah	1970-09-17	Chilena	+56915856316	francisco.bravo1184@gmail.com
10001185-9	Jorge Tapia Reyes	1997-05-21	Uruguaya	+56934147528	jorge.tapia1185@yahoo.com
10001186-7	Robert Messi Vargas	2002-06-17	Uruguaya	+56975756671	robert.messi1186@gmail.com
10001187-5	Javier Lewandowski Lukaku	1995-05-16	Chilena	+56951045803	javier.lewandowski1187@gmail.com
10001188-3	Cristopher Pizarro Yamal	1972-08-26	Chilena	+56913101196	cristopher.pizarro1188@outlook.com
10001189-1	Santiago Haaland Müller	1973-12-01	Chilena	+56937353087	santiago.haaland1189@yahoo.com
10001190-5	Oscar Toselli Carrasco	1970-12-24	Chilena	+56931434581	oscar.toselli1190@usach.cl
10001191-3	Erick Pizarro Riquelme	1997-05-17	Chilena	+56938535093	erick.pizarro1191@uca.cl
10001192-1	Javier Sánchez Jara	1970-02-27	Chilena	+56926738320	javier.sanchez1192@yahoo.com
10001193-K	Humberto De Bruyne Herrera	1980-12-27	Chilena	+56933677406	humberto.de bruyne1193@uca.cl
10001194-8	Facundo Rivera Beausejour	1994-06-02	Chilena	+56969893010	facundo.rivera1194@outlook.com
10001195-6	Gavi Figueroa Figueroa	1980-05-25	Chilena	+56923383373	gavi.figueroa1195@outlook.com
10001196-4	Pedro Bustos González	1991-10-24	Chilena	+56924587455	pedro.bustos1196@outlook.com
10001197-2	Gastón Suazo Salah	1995-03-10	Chilena	+56992116644	gaston.suazo1197@yahoo.com
10001198-0	Lionel Nuñez Beausejour	1979-07-19	Chilena	+56944944088	lionel.nunez1198@uca.cl
10001199-9	Luciano Rodri Nuñez	1973-10-23	Portuguesa	+56948245970	luciano.rodri1199@yahoo.com
10001200-6	Hernán Sepúlveda Arias	1976-06-07	Chilena	+56941434524	hernan.sepulveda1200@puc.cl
10001201-4	Federico Ramos Valdés	1986-04-07	Portuguesa	+56917056832	federico.ramos1201@uca.cl
10001202-2	Kevin Rojas Rodri	1974-05-23	Chilena	+56939077875	kevin.rojas1202@puc.cl
10001203-0	Arturo Haaland Reyes	1982-07-04	Colombiana	+56953051968	arturo.haaland1203@uca.cl
10001204-9	José Rodri Caszely	1976-09-27	Chilena	+56987106682	jose.rodri1204@puc.cl
10001205-7	Martín Aránguiz Díaz	1998-04-03	Chilena	+56993750962	martin.aranguiz1205@puc.cl
10001206-5	Nicolás Messi Rojas	2004-03-19	Chilena	+56992834942	nicolas.messi1206@gmail.com
10001207-3	Daniel Vidal Jara	2005-11-06	Brasileña	+56985500755	daniel.vidal1207@outlook.com
10001208-1	Johnny Maripán Sánchez	2000-11-11	Chilena	+56950035771	johnny.maripan1208@yahoo.com
10001209-K	Thomas Benzema Álvarez	2004-01-11	Chilena	+56954149129	thomas.benzema1209@yahoo.com
10001210-3	Sergio Müller Gutiérrez	1993-07-20	Colombiana	+56911556306	sergio.müller1210@gmail.com
10001211-1	Kevin Müller Aránguiz	1988-12-22	Chilena	+56928535287	kevin.müller1211@outlook.com
10001212-K	Cristian Gómez Messi	1982-06-26	Uruguaya	+56917504589	cristian.gomez1212@hotmail.com
10001213-8	Johnny González Rivera	1979-07-23	Chilena	+56990702555	johnny.gonzalez1213@yahoo.com
10001214-6	Rodrigo Mbappe Suárez	1971-12-02	Chilena	+56921076759	rodrigo.mbappe1214@gmail.com
10001215-4	Gustavo Rodri Maradona	1993-12-22	Chilena	+56980961263	gustavo.rodri1215@puc.cl
10001216-2	Luis Müller Rojas	1988-04-09	Chilena	+56926229110	luis.müller1216@hotmail.com
10001217-0	Gastón Vergara Morales	1977-06-05	Chilena	+56918018316	gaston.vergara1217@gmail.com
10001218-9	Pedro Mendoza Valdés	1970-02-20	Chilena	+56920080173	pedro.mendoza1218@outlook.com
10001219-7	Paulo Díaz Hernández	1992-02-07	Argentina	+56984305353	paulo.diaz1219@puc.cl
10001220-0	Jorge Toselli Di María	1970-10-22	Chilena	+56981685332	jorge.toselli1220@outlook.com
10001221-9	Arturo Paredes Bellingham	2005-02-20	Peruana	+56939937365	arturo.paredes1221@outlook.com
10001222-7	Pedri Gutiérrez Müller	2003-02-23	Portuguesa	+56976051469	pedri.gutierrez1222@uca.cl
10001223-5	Matías Castro Rodri	1986-02-19	Chilena	+56910240746	matias.castro1223@uca.cl
10001224-3	Julian Alvarez Contreras	1978-12-14	Chilena	+56947748279	julian.alvarez1224@usach.cl
10001225-1	Francisco Carrasco Zidane	1986-03-01	Chilena	+56989684987	francisco.carrasco1225@uca.cl
10001226-K	Erick Morales Sepúlveda	1970-08-04	Chilena	+56992338036	erick.morales1226@outlook.com
10001227-8	Thiago Rodríguez Isla	2004-09-10	Chilena	+56912520441	thiago.rodriguez1227@outlook.com
10001228-6	Eduardo González Espinoza	1995-01-29	Chilena	+56919852130	eduardo.gonzalez1228@outlook.com
10001229-4	Luis Ronaldo Valverde	1971-09-06	Brasileña	+56925210283	luis.ronaldo1229@usach.cl
10001230-8	Edinson Fuentes Benzema	2002-05-30	Italiana	+56995473792	edinson.fuentes1230@usach.cl
10001231-6	Diego Caszely Arias	2005-10-08	Chilena	+56952054452	diego.caszely1231@usach.cl
10001232-4	Johnny Toselli Tapia	1996-07-22	Chilena	+56939164142	johnny.toselli1232@yahoo.com
10001233-2	Álvaro Haaland Carrasco	1995-05-02	Chilena	+56957772140	alvaro.haaland1233@usach.cl
10001234-0	Luciano Mbappe Arias	1972-07-20	Chilena	+56922357889	luciano.mbappe1234@uca.cl
10001235-9	Gastón Fernández Dybala	1981-12-09	Inglesa	+56947087424	gaston.fernandez1235@puc.cl
10001236-7	Agustín Aránguiz Valdivia	1992-04-22	Chilena	+56999538478	agustin.aranguiz1236@outlook.com
10001237-5	Kylian Haaland Maradona	1992-02-11	Chilena	+56974206000	kylian.haaland1237@hotmail.com
10001238-3	Cristian Díaz Morales	1999-04-28	Italiana	+56972661231	cristian.diaz1238@hotmail.com
10001239-1	Lionel Valverde Valenzuela	1976-09-23	Argentina	+56936879060	lionel.valverde1239@hotmail.com
10001240-5	Mauricio Güler Suazo	1999-07-10	Chilena	+56943279075	mauricio.güler1240@outlook.com
10001241-3	Agustín Torres Paredes	2004-01-18	Chilena	+56965070551	agustin.torres1241@uca.cl
10001242-1	Gonzalo Arias Gutiérrez	1974-10-03	Peruana	+56995194271	gonzalo.arias1242@hotmail.com
10001243-K	Cristopher Vásquez Riquelme	1982-03-14	Chilena	+56939667785	cristopher.vasquez1243@outlook.com
10001244-8	Maximiliano Müller Haaland	1996-02-16	Portuguesa	+56973731478	maximiliano.müller1244@usach.cl
10001245-6	Diego Aránguiz Figueroa	1971-07-23	Chilena	+56918383934	diego.aranguiz1245@yahoo.com
10001246-4	Neymar Ramos Espinoza	1984-07-24	Española	+56996725910	neymar.ramos1246@usach.cl
10001247-2	Harry Haaland Rodríguez	2000-11-16	Chilena	+56973151698	harry.haaland1247@gmail.com
10001248-0	Erling Suárez Silva	1978-08-08	Chilena	+56984173830	erling.suarez1248@gmail.com
10001249-9	Humberto Vinicius Cortés	1988-10-31	Chilena	+56922193809	humberto.vinicius1249@uca.cl
10001250-2	Maximiliano Galdames Arias	1977-01-25	Argentina	+56981083386	maximiliano.galdames1250@gmail.com
10001251-0	Cristian Mendoza Maradona	1997-12-17	Chilena	+56973288631	cristian.mendoza1251@gmail.com
10001252-9	Edinson Álvarez Maripán	2003-05-02	Chilena	+56995042401	edinson.alvarez1252@uca.cl
10001253-7	Matias Griezmann Sánchez	1972-06-19	Peruana	+56920260043	matias.griezmann1253@uca.cl
10001254-5	Humberto Toselli Isla	1989-02-09	Italiana	+56994056587	humberto.toselli1254@hotmail.com
10001255-3	Joaquín Martínez Araya	1973-01-10	Chilena	+56958883350	joaquin.martinez1255@puc.cl
10001256-1	Marcelo Mendoza Rojas	1997-07-01	Chilena	+56944444870	marcelo.mendoza1256@uca.cl
10001257-K	Diego De Bruyne Fuentes	1996-02-05	Chilena	+56976732386	diego.de bruyne1257@puc.cl
10001258-8	Oscar Cortés Vinicius	1985-11-15	Chilena	+56989714506	oscar.cortes1258@puc.cl
10001259-6	Santino Benzema De Bruyne	2003-05-16	Chilena	+56915250430	santino.benzema1259@usach.cl
10001260-K	Juan Araya Neuer	1980-01-11	Chilena	+56992280871	juan.araya1260@uca.cl
10001261-8	Martín Mendoza Galdames	2001-10-02	Chilena	+56947555223	martin.mendoza1261@yahoo.com
10001262-6	José Medel Neuer	1991-08-16	Chilena	+56998342287	jose.medel1262@usach.cl
10001263-4	Martín Vinicius Suárez	1988-10-10	Italiana	+56945506379	martin.vinicius1263@uca.cl
10001264-2	Mohamed Salas González	2002-11-17	Chilena	+56941105704	mohamed.salas1264@hotmail.com
10001265-0	Daniel Martínez Torres	1982-02-06	Chilena	+56926707397	daniel.martinez1265@puc.cl
10001266-9	Robert Bustos Salah	1990-04-21	Chilena	+56934414628	robert.bustos1266@outlook.com
10001267-7	Ezequiel Cortés Hernández	1999-06-07	Chilena	+56931818022	ezequiel.cortes1267@hotmail.com
10001268-5	Cristopher Fuentes Haaland	1976-12-31	Chilena	+56954967876	cristopher.fuentes1268@puc.cl
10001269-3	Pelé Saavedra Carrasco	1985-11-21	Chilena	+56941304086	pele.saavedra1269@hotmail.com
10001270-7	Ángel Caszely Araya	1982-05-16	Chilena	+56917441704	angel.caszely1270@usach.cl
10001271-5	Angel Rodríguez Ronaldo	1978-06-28	Chilena	+56920638368	angel.rodriguez1271@hotmail.com
10001272-3	Daniel Carrasco Cortés	1994-12-11	Chilena	+56930045062	daniel.carrasco1272@uca.cl
10001273-1	Carlos Torres Herrera	1990-04-11	Chilena	+56918323693	carlos.torres1273@usach.cl
10001274-K	Marcelo Cortés Muñoz	1987-09-30	Peruana	+56981754244	marcelo.cortes1274@outlook.com
10001275-8	Ezequiel Herrera Rodri	1989-01-26	Peruana	+56965161760	ezequiel.herrera1275@yahoo.com
10001276-6	Harry Valverde Vergara	1980-12-31	Chilena	+56931291377	harry.valverde1276@gmail.com
10001277-4	Manuel Aránguiz González	1974-07-19	Chilena	+56939511595	manuel.aranguiz1277@gmail.com
10001278-2	Mateo Pizarro Salas	1988-02-24	Chilena	+56994967978	mateo.pizarro1278@usach.cl
10001279-0	Tomás Medel Neuer	1993-12-07	Chilena	+56993449879	tomas.medel1279@uca.cl
10001280-4	Diego Figueroa Muñoz	2001-04-27	Peruana	+56916496872	diego.figueroa1280@outlook.com
10001281-2	Humberto Rodri Bravo	1987-08-10	Francesa	+56951069320	humberto.rodri1281@puc.cl
10001282-0	Ignacio Güler Saavedra	1980-07-18	Chilena	+56990484413	ignacio.güler1282@puc.cl
10001283-9	Alejandro Valverde Valdivia	1993-11-01	Chilena	+56926490068	alejandro.valverde1283@uca.cl
10001284-7	Agustín Alvarez Rodríguez	1983-12-09	Chilena	+56916703838	agustin.alvarez1284@yahoo.com
10001285-5	Rodrigo Castillo Benzema	1982-01-25	Francesa	+56922738007	rodrigo.castillo1285@outlook.com
10001286-3	Gary Ronaldo Rodri	1979-06-04	Francesa	+56961021390	gary.ronaldo1286@gmail.com
10001287-1	José Saavedra Morales	1996-12-31	Chilena	+56918451502	jose.saavedra1287@hotmail.com
10001288-K	Enzo González Gómez	1985-01-04	Chilena	+56954286763	enzo.gonzalez1288@uca.cl
10001289-8	Toni Di María Ronaldo	1982-08-03	Chilena	+56931049082	toni.di maria1289@puc.cl
10001290-1	Johnny Jara Ronaldo	1994-08-09	Chilena	+56963002717	johnny.jara1290@outlook.com
10001291-K	Santino Soto Rodri	1981-07-18	Colombiana	+56963105714	santino.soto1291@yahoo.com
10001292-8	Eduardo Dybala Cavani	1996-01-30	Chilena	+56970465652	eduardo.dybala1292@outlook.com
10001293-6	Thomas Morales Vinicius	1971-05-07	Chilena	+56919359460	thomas.morales1293@usach.cl
10001294-4	Paulo Yamal Salah	1998-11-13	Chilena	+56912195312	paulo.yamal1294@outlook.com
10001295-2	Gustavo Pizarro Salas	1970-03-21	Colombiana	+56980499240	gustavo.pizarro1295@hotmail.com
10001296-0	Federico Muñoz Carrasco	1994-07-14	Chilena	+56934969112	federico.munoz1296@gmail.com
10001297-9	Bautista Vargas Fernández	1973-04-26	Chilena	+56943495328	bautista.vargas1297@gmail.com
10001298-7	Angel Rivera Martínez	1983-05-08	Chilena	+56966934853	angel.rivera1298@hotmail.com
10001299-5	Martín Mbappe Castillo	1991-09-21	Brasileña	+56989630289	martin.mbappe1299@yahoo.com
10001300-2	Marcelo Arias Haaland	1974-12-09	Chilena	+56935356230	marcelo.arias1300@yahoo.com
10001301-0	Sebastián Martínez Suárez	2005-07-14	Brasileña	+56946328959	sebastian.martinez1301@usach.cl
10001302-9	Sergio Martínez Valenzuela	1982-08-03	Inglesa	+56954896171	sergio.martinez1302@puc.cl
10001303-7	Hernán Carrasco Vergara	1993-07-07	Colombiana	+56943393905	hernan.carrasco1303@yahoo.com
10001304-5	Gavi Haaland Vergara	1988-11-15	Chilena	+56993318410	gavi.haaland1304@usach.cl
10001305-3	Lamine Maradona Vidal	1992-09-08	Chilena	+56949468845	lamine.maradona1305@hotmail.com
10001306-1	Gonzalo Neuer Contreras	1971-05-15	Chilena	+56984705511	gonzalo.neuer1306@puc.cl
10001307-K	Diego Nuñez Castro	2004-02-28	Chilena	+56981909176	diego.nunez1307@outlook.com
10001308-8	Bautista Vásquez Kane	1995-02-16	Chilena	+56977808538	bautista.vasquez1308@usach.cl
10001309-6	Maximiliano Medel Griezmann	1977-08-17	Brasileña	+56965097622	maximiliano.medel1309@yahoo.com
10001310-K	Felipe Isla Bravo	1970-04-20	Argentina	+56987324766	felipe.isla1310@usach.cl
10001311-8	Andrés Suárez Silva	1985-08-25	Chilena	+56914483702	andres.suarez1311@outlook.com
10001312-6	Mauricio Castro Güler	1970-03-14	Chilena	+56919815674	mauricio.castro1312@outlook.com
10001313-4	Maximiliano Galdames Carrasco	1973-04-06	Chilena	+56977927052	maximiliano.galdames1313@uca.cl
10001314-2	Santiago Gómez Griezmann	1994-10-14	Chilena	+56950247731	santiago.gomez1314@yahoo.com
10001315-0	Lucas Cortés Saavedra	1970-08-02	Chilena	+56915144982	lucas.cortes1315@hotmail.com
10001316-9	Kevin Soto Soto	1982-02-14	Portuguesa	+56994900742	kevin.soto1316@usach.cl
10001317-7	Sergio Salas Güler	1982-05-05	Portuguesa	+56992815484	sergio.salas1317@usach.cl
10001318-5	Pablo Kroos Vásquez	1997-08-21	Chilena	+56975996743	pablo.kroos1318@gmail.com
10001319-3	Gastón Mendoza Di María	1978-08-01	Inglesa	+56992727875	gaston.mendoza1319@usach.cl
10001320-7	Manuel Muñoz Castillo	1995-07-16	Uruguaya	+56924998904	manuel.munoz1320@uca.cl
10001321-5	Toni Pizarro Güler	1992-04-04	Chilena	+56935239182	toni.pizarro1321@gmail.com
10001322-3	Nicolás Haaland Medel	2000-02-09	Chilena	+56976383764	nicolas.haaland1322@gmail.com
10001323-1	Kevin Pizarro Contreras	2005-08-15	Chilena	+56932640804	kevin.pizarro1323@puc.cl
10001324-K	Esteban Kane Gutiérrez	1993-10-16	Chilena	+56972774390	esteban.kane1324@yahoo.com
10001325-8	Robert Castillo Hernández	1996-01-20	Chilena	+56919966673	robert.castillo1325@hotmail.com
10001326-6	Sergio Pérez Caszely	1989-06-10	Chilena	+56941928417	sergio.perez1326@outlook.com
10001327-4	Ángel Nuñez Modric	1983-11-20	Colombiana	+56977528534	angel.nunez1327@gmail.com
10001328-2	Gustavo Kroos Araya	1976-11-23	Chilena	+56927317552	gustavo.kroos1328@usach.cl
10001329-0	Maximiliano Sánchez Alvarez	1996-05-19	Chilena	+56993185768	maximiliano.sanchez1329@puc.cl
10001330-4	Ignacio Sánchez Díaz	1987-01-06	Chilena	+56993542604	ignacio.sanchez1330@hotmail.com
10001331-2	Vicente Toselli Vergara	1994-11-01	Chilena	+56931042684	vicente.toselli1331@hotmail.com
10001332-0	Pelé Castro Zidane	1992-03-07	Chilena	+56912040035	pele.castro1332@hotmail.com
10001333-9	Marcelo Nuñez Morales	1980-02-05	Chilena	+56981217207	marcelo.nunez1333@gmail.com
10001334-7	Pedro Figueroa Hernández	1998-08-20	Peruana	+56994564095	pedro.figueroa1334@gmail.com
10001335-5	Kevin Vergara Kroos	1988-01-28	Portuguesa	+56969481143	kevin.vergara1335@puc.cl
10001336-3	Ignacio Pizarro Saavedra	1987-08-07	Alemana	+56914815287	ignacio.pizarro1336@gmail.com
10001337-1	Alejandro Suazo Castro	1985-08-09	Uruguaya	+56945578829	alejandro.suazo1337@puc.cl
10001338-K	Nicolás Silva Valverde	1976-11-14	Chilena	+56975172149	nicolas.silva1338@outlook.com
10001339-8	Ronaldo Galdames Martínez	1974-02-16	Chilena	+56960337913	ronaldo.galdames1339@yahoo.com
10001340-1	Lionel Mbappe López	1981-08-18	Chilena	+56983216091	lionel.mbappe1340@uca.cl
10001341-K	Pelé Yamal Maripán	1982-05-21	Chilena	+56990512834	pele.yamal1341@gmail.com
10001342-8	Pablo Maradona Galdames	1975-02-05	Chilena	+56930667633	pablo.maradona1342@usach.cl
10001343-6	Vicente Álvarez Mendoza	1997-09-10	Chilena	+56991212788	vicente.alvarez1343@gmail.com
10001344-4	Pelé Valdés Valenzuela	1999-01-22	Alemana	+56931558811	pele.valdes1344@hotmail.com
10001345-2	Joaquín Gómez Tapia	1992-04-07	Chilena	+56920429720	joaquin.gomez1345@yahoo.com
10001346-0	Nicolás Pizarro Bustos	1990-07-07	Chilena	+56994940554	nicolas.pizarro1346@hotmail.com
10001347-9	Charles Ramos Fernández	1974-01-16	Chilena	+56931857795	charles.ramos1347@puc.cl
10001348-7	Joaquín Araya Messi	1994-04-28	Chilena	+56927331289	joaquin.araya1348@hotmail.com
10001349-5	Julian Flores Bellingham	1978-06-12	Portuguesa	+56916084966	julian.flores1349@hotmail.com
10001350-9	Javier Bravo Sánchez	1992-09-15	Chilena	+56948502596	javier.bravo1350@usach.cl
10001351-7	Gustavo Pulgar Valverde	2003-09-17	Italiana	+56978703354	gustavo.pulgar1351@usach.cl
10001352-5	Ronaldo Figueroa Valverde	1981-06-01	Chilena	+56938200476	ronaldo.figueroa1352@outlook.com
10001353-3	Ezequiel Suárez Medel	1985-12-11	Chilena	+56921510431	ezequiel.suarez1353@outlook.com
10001354-1	Gustavo Castillo Griezmann	2003-12-26	Argentina	+56997371781	gustavo.castillo1354@puc.cl
10001355-K	Lionel Silva Benzema	1976-12-10	Chilena	+56960162855	lionel.silva1355@outlook.com
10001356-8	Sergio Caszely Vidal	2001-07-15	Chilena	+56968940149	sergio.caszely1356@outlook.com
10001357-6	Maximiliano Caszely Bustos	1993-09-05	Chilena	+56928120418	maximiliano.caszely1357@gmail.com
10001358-4	Alejandro Valenzuela Flores	1981-08-31	Argentina	+56960263771	alejandro.valenzuela1358@hotmail.com
10001359-2	Luis Mbappe Griezmann	2005-05-19	Chilena	+56965940791	luis.mbappe1359@gmail.com
10001360-6	Ronaldo Ronaldo Arias	1976-04-12	Francesa	+56952128802	ronaldo.ronaldo1360@puc.cl
10001361-4	Lionel Gutiérrez González	1981-05-07	Chilena	+56974959681	lionel.gutierrez1361@yahoo.com
10001362-2	Alejandro Beausejour Castro	1991-04-08	Chilena	+56910814864	alejandro.beausejour1362@hotmail.com
10001363-0	Álvaro Maradona Rodri	1971-11-18	Chilena	+56994761230	alvaro.maradona1363@gmail.com
10001364-9	Cristopher Bravo Soto	1980-05-04	Chilena	+56971970054	cristopher.bravo1364@hotmail.com
10001365-7	Romelu Valdés Álvarez	1973-09-03	Chilena	+56995444525	romelu.valdes1365@gmail.com
10001366-5	Pablo Tapia Nuñez	2005-10-28	Argentina	+56916549104	pablo.tapia1366@gmail.com
10001367-3	Alexis Yamal Sánchez	1993-11-10	Chilena	+56969337302	alexis.yamal1367@gmail.com
10001368-1	Gary Hernández Rojas	1987-07-25	Chilena	+56925599200	gary.hernandez1368@usach.cl
10001369-K	Marcos Dybala Valdés	1988-11-01	Chilena	+56954471750	marcos.dybala1369@hotmail.com
10001370-3	Andrés Paredes Nuñez	1990-05-30	Chilena	+56929180203	andres.paredes1370@uca.cl
10001371-1	Álvaro Hernández Di María	1995-02-07	Chilena	+56977493031	alvaro.hernandez1371@puc.cl
10001372-K	Thiago Tapia Figueroa	1983-09-12	Chilena	+56931898955	thiago.tapia1372@uca.cl
10001373-8	Neymar Valenzuela Salas	1990-09-10	Chilena	+56919620703	neymar.valenzuela1373@hotmail.com
10001374-6	Tomás Beausejour Nuñez	1985-12-19	Chilena	+56983093096	tomas.beausejour1374@yahoo.com
10001375-4	Angel Rojas Rojas	2003-10-11	Chilena	+56938354155	angel.rojas1375@yahoo.com
10001376-2	Charles Lewandowski Rivera	1991-01-02	Portuguesa	+56936811451	charles.lewandowski1376@uca.cl
10001377-0	Raúl Castro Vinicius	1977-03-22	Brasileña	+56944244286	raul.castro1377@yahoo.com
10001378-9	Gastón Vásquez Mbappe	1976-11-17	Chilena	+56990821341	gaston.vasquez1378@gmail.com
10001379-7	Harry Pulgar Galdames	1995-06-12	Colombiana	+56937701966	harry.pulgar1379@gmail.com
10001380-0	Enzo Benzema Bellingham	1989-01-09	Chilena	+56971179142	enzo.benzema1380@gmail.com
10001381-9	Javier Vidal Salah	1987-03-29	Brasileña	+56941294608	javier.vidal1381@outlook.com
10001382-7	Tomás Valverde Medel	1980-03-18	Chilena	+56967216517	tomas.valverde1382@puc.cl
10001383-5	Claudio Pizarro Alvarez	1973-08-26	Chilena	+56992638554	claudio.pizarro1383@uca.cl
10001384-3	Jorge Modric Hernández	1971-10-20	Chilena	+56955476295	jorge.modric1384@puc.cl
10001385-1	Lamine Carrasco Silva	2003-09-03	Chilena	+56931478120	lamine.carrasco1385@gmail.com
10001386-K	Cristian Dybala Pizarro	1973-08-17	Argentina	+56977102601	cristian.dybala1386@puc.cl
10001387-8	Daniel Toselli De Bruyne	1993-06-27	Chilena	+56931443893	daniel.toselli1387@outlook.com
10001388-6	Luciano Álvarez Dybala	1983-12-12	Chilena	+56910481037	luciano.alvarez1388@puc.cl
10001389-4	Carlos Dybala Salas	1990-07-30	Chilena	+56937017574	carlos.dybala1389@puc.cl
10001390-8	Luis Vidal Muñoz	1983-11-16	Peruana	+56984566723	luis.vidal1390@puc.cl
10001391-6	Carlos Saavedra Pulgar	1988-01-03	Chilena	+56939049157	carlos.saavedra1391@hotmail.com
10001392-4	Erling Haaland Rojas	2004-09-09	Chilena	+56980390242	erling.haaland1392@uca.cl
10001393-2	Gonzalo Valdivia Beausejour	1976-04-08	Colombiana	+56980078537	gonzalo.valdivia1393@gmail.com
10001394-0	Edinson Kroos Lewandowski	1981-09-13	Chilena	+56936092263	edinson.kroos1394@yahoo.com
10001395-9	Ángel Fuentes Herrera	1977-09-17	Chilena	+56985347476	angel.fuentes1395@gmail.com
10001396-7	Matias Paredes López	1999-04-01	Chilena	+56981539993	matias.paredes1396@puc.cl
10001397-5	Sebastián Pérez Silva	1978-11-14	Francesa	+56914720586	sebastian.perez1397@gmail.com
10001398-3	Romelu Aránguiz Beausejour	1979-11-02	Chilena	+56910720034	romelu.aranguiz1398@yahoo.com
10001399-1	Benjamín Benzema Medel	2001-09-21	Chilena	+56948700888	benjamin.benzema1399@puc.cl
10001400-9	Gavi Pérez Salas	2001-07-26	Chilena	+56944616764	gavi.perez1400@yahoo.com
10001401-7	Enzo Rojas Messi	1997-08-24	Chilena	+56940845618	enzo.rojas1401@hotmail.com
10001402-5	Marcelo Castro Mbappe	1990-02-15	Española	+56920271729	marcelo.castro1402@outlook.com
10001403-3	Pelé Pizarro Caszely	1980-12-28	Portuguesa	+56954506998	pele.pizarro1403@outlook.com
10001404-1	Angel Vargas Griezmann	1985-12-11	Chilena	+56960355248	angel.vargas1404@uca.cl
10001405-K	Pelé Zidane Haaland	1993-10-02	Francesa	+56949593352	pele.zidane1405@puc.cl
10001406-8	Kevin Nuñez Bellingham	1979-04-30	Chilena	+56952484043	kevin.nunez1406@gmail.com
10001407-6	Charles Sánchez Mbappe	1984-09-20	Chilena	+56993402821	charles.sanchez1407@yahoo.com
10001408-4	Claudio Vinicius Muñoz	1984-10-01	Chilena	+56967014506	claudio.vinicius1408@uca.cl
10001409-2	Marcelo Vidal Hernández	1987-05-03	Chilena	+56977948643	marcelo.vidal1409@uca.cl
10001410-6	Andrés Isla Reyes	1999-05-31	Portuguesa	+56981436127	andres.isla1410@puc.cl
10001411-4	Benjamín Rojas Vergara	1989-09-26	Chilena	+56997346625	benjamin.rojas1411@gmail.com
10001412-2	Erick Paredes Araya	1971-04-21	Chilena	+56993292998	erick.paredes1412@puc.cl
10001413-0	Pelé Benzema Vásquez	1984-10-19	Chilena	+56990990435	pele.benzema1413@usach.cl
10001414-9	Pedro Fernández Vásquez	1975-10-16	Chilena	+56939862927	pedro.fernandez1414@puc.cl
10001415-7	Gustavo Lewandowski Castillo	1985-09-12	Chilena	+56948277363	gustavo.lewandowski1415@outlook.com
10001416-5	José Gómez Rojas	2002-03-22	Argentina	+56989404461	jose.gomez1416@outlook.com
10001417-3	Cristian Rodríguez Bellingham	2003-06-19	Inglesa	+56976911105	cristian.rodriguez1417@usach.cl
10001418-1	Jaime Suazo Suazo	1990-11-24	Chilena	+56977002290	jaime.suazo1418@gmail.com
10001419-K	Jean Zidane Ramos	1970-02-01	Chilena	+56982247398	jean.zidane1419@puc.cl
10001420-3	Thomas Rojas Fernández	1983-11-09	Francesa	+56984708237	thomas.rojas1420@usach.cl
10001421-1	Luka Morales Muñoz	2002-08-21	Española	+56989155906	luka.morales1421@outlook.com
10001422-K	Erling Vásquez Benzema	1989-05-17	Chilena	+56970199595	erling.vasquez1422@uca.cl
10001423-8	Guillermo Salas Morales	1978-05-08	Chilena	+56930984451	guillermo.salas1423@yahoo.com
10001424-6	Johnny Saavedra Di María	1979-12-03	Chilena	+56933456408	johnny.saavedra1424@puc.cl
10001425-4	Ángel Cortés Torres	1986-10-24	Chilena	+56980245925	angel.cortes1425@puc.cl
10001426-2	Esteban Muñoz Gutiérrez	2005-06-25	Chilena	+56972941319	esteban.munoz1426@hotmail.com
10001427-0	Erling Vargas De Bruyne	2001-04-19	Chilena	+56978007901	erling.vargas1427@yahoo.com
10001428-9	Mateo Müller Morales	1992-01-26	Chilena	+56920610593	mateo.müller1428@hotmail.com
10001429-7	Nicolás Arias Rojas	1996-02-29	Chilena	+56975165864	nicolas.arias1429@usach.cl
10001430-0	Jaime Mbappe De Bruyne	1991-12-31	Chilena	+56942955100	jaime.mbappe1430@uca.cl
10001431-9	Cristian Kane Zidane	1985-11-12	Chilena	+56948767676	cristian.kane1431@gmail.com
10001432-7	Gabriel Cortés Rodríguez	1981-06-25	Chilena	+56920326698	gabriel.cortes1432@outlook.com
10001433-5	Pedro Valdés Pérez	1990-11-01	Chilena	+56957878526	pedro.valdes1433@hotmail.com
10001434-3	Marcelo Díaz Bravo	1982-11-10	Chilena	+56991008216	marcelo.diaz1434@hotmail.com
10001435-1	Gustavo Araya Muñoz	2000-12-23	Chilena	+56917184472	gustavo.araya1435@gmail.com
10001436-K	Juan De Bruyne Muñoz	2002-07-16	Chilena	+56921998313	juan.de bruyne1436@yahoo.com
10001437-8	Mateo Valdivia Haaland	2004-08-09	Chilena	+56915915727	mateo.valdivia1437@yahoo.com
10001438-6	Ronaldo Castro Medel	2002-07-14	Chilena	+56914780868	ronaldo.castro1438@puc.cl
10001439-4	Alexis Bellingham Morales	1976-12-15	Chilena	+56939837974	alexis.bellingham1439@hotmail.com
10001440-8	Enzo Benzema Nuñez	1988-10-29	Portuguesa	+56942763034	enzo.benzema1440@gmail.com
10001441-6	Raúl Soto Bellingham	1990-08-13	Chilena	+56911883634	raul.soto1441@gmail.com
10001442-4	Guillermo Silva Figueroa	1978-02-10	Chilena	+56954706284	guillermo.silva1442@outlook.com
10001443-2	Facundo Fernández De Bruyne	1977-01-13	Chilena	+56954323760	facundo.fernandez1443@usach.cl
10001444-0	Enzo Vásquez Galdames	2005-12-28	Chilena	+56953391306	enzo.vasquez1444@puc.cl
10001445-9	Eduardo Müller Hernández	1977-05-16	Chilena	+56947327435	eduardo.müller1445@yahoo.com
10001446-7	Harry Lewandowski Benzema	1996-07-04	Chilena	+56953320120	harry.lewandowski1446@puc.cl
10001447-5	Esteban Cortés Álvarez	1989-02-27	Inglesa	+56914113226	esteban.cortes1447@puc.cl
10001448-3	Gary Contreras Gómez	1995-03-31	Chilena	+56925555565	gary.contreras1448@uca.cl
10001449-1	Manuel Sepúlveda Aránguiz	1997-12-16	Chilena	+56924363154	manuel.sepulveda1449@outlook.com
10001450-5	Thiago Jara Maradona	1981-08-07	Uruguaya	+56994176663	thiago.jara1450@outlook.com
10001451-3	Gonzalo Toselli Aránguiz	1992-07-30	Chilena	+56945976809	gonzalo.toselli1451@puc.cl
10001452-1	Rodrigo Alvarez Messi	1978-12-13	Brasileña	+56957773776	rodrigo.alvarez1452@usach.cl
10001453-K	Álvaro Rodríguez Pulgar	1975-03-15	Italiana	+56985344588	alvaro.rodriguez1453@gmail.com
10001454-8	Gonzalo Rodri Pizarro	1994-11-10	Chilena	+56964455729	gonzalo.rodri1454@uca.cl
10001455-6	Maximiliano Yamal Isla	1995-10-20	Italiana	+56980021491	maximiliano.yamal1455@hotmail.com
10001456-4	Erick Araya Martínez	1999-12-12	Chilena	+56943253566	erick.araya1456@uca.cl
10001457-2	Lautaro Sepúlveda Hernández	1981-10-09	Chilena	+56981849431	lautaro.sepulveda1457@hotmail.com
10001458-0	Cristian Suárez Gómez	1978-02-14	Chilena	+56996561989	cristian.suarez1458@hotmail.com
10001459-9	Sergio Toselli Beausejour	1997-05-25	Inglesa	+56957042180	sergio.toselli1459@yahoo.com
10001460-2	Angel Bellingham Ronaldo	1990-02-15	Chilena	+56964161714	angel.bellingham1460@usach.cl
10001461-0	Erling Flores Salas	1980-07-09	Chilena	+56958277495	erling.flores1461@usach.cl
10001462-9	Luciano Pulgar Pizarro	1982-12-22	Chilena	+56977616605	luciano.pulgar1462@puc.cl
10001463-7	Romelu Herrera Morales	1990-06-26	Chilena	+56931314964	romelu.herrera1463@uca.cl
10001464-5	Cristiano Ramos Araya	1979-02-21	Chilena	+56982267876	cristiano.ramos1464@uca.cl
10001465-3	Pablo Suazo Díaz	1996-10-28	Chilena	+56953608093	pablo.suazo1465@puc.cl
10001466-1	Daniel Morales Fernández	1977-04-15	Chilena	+56942837956	daniel.morales1466@outlook.com
10001467-K	José Herrera Saavedra	1982-02-25	Chilena	+56941208236	jose.herrera1467@yahoo.com
10001468-8	Edinson De Bruyne Cavani	1997-05-14	Chilena	+56975042296	edinson.de bruyne1468@hotmail.com
10001469-6	Luis Silva Gómez	1991-11-21	Francesa	+56934347781	luis.silva1469@yahoo.com
10001470-K	Gonzalo Vargas Maradona	1982-07-16	Colombiana	+56945229837	gonzalo.vargas1470@uca.cl
10001471-8	Mohamed López Hernández	1978-06-18	Española	+56913213022	mohamed.lopez1471@gmail.com
10001472-6	Gonzalo Sánchez Toselli	1997-11-18	Chilena	+56979896652	gonzalo.sanchez1472@gmail.com
10001473-4	Andrés Ronaldo Zidane	1997-10-04	Peruana	+56989493391	andres.ronaldo1473@usach.cl
10001474-2	Hernán Vidal Muñoz	1995-09-25	Chilena	+56918159324	hernan.vidal1474@uca.cl
10001475-0	Zinedine Suárez Medel	1979-03-17	Chilena	+56934782177	zinedine.suarez1475@puc.cl
10001476-9	Santino Díaz Valdés	2003-06-07	Chilena	+56914199464	santino.diaz1476@yahoo.com
10001477-7	Cristian Beausejour Jara	1972-09-30	Chilena	+56995828699	cristian.beausejour1477@outlook.com
10001478-5	Oscar Pérez Muñoz	2002-10-21	Alemana	+56921188809	oscar.perez1478@gmail.com
10001479-3	Enzo Kroos Jara	1988-03-24	Chilena	+56941368108	enzo.kroos1479@hotmail.com
10001480-7	Bautista Sepúlveda Vergara	2003-06-30	Chilena	+56994250573	bautista.sepulveda1480@hotmail.com
10001481-5	Juan Bellingham Aránguiz	1972-08-02	Chilena	+56996874744	juan.bellingham1481@outlook.com
10001482-3	Eduardo Castillo Saavedra	1986-08-10	Chilena	+56985231168	eduardo.castillo1482@hotmail.com
10001483-1	Jaime Flores Arias	1984-06-28	Brasileña	+56950421684	jaime.flores1483@hotmail.com
10001484-K	Felipe Morales Torres	1990-06-27	Francesa	+56977225770	felipe.morales1484@uca.cl
10001485-8	Julian Salah Figueroa	1982-03-05	Chilena	+56933351321	julian.salah1485@uca.cl
10001486-6	Ezequiel Dybala Dybala	1971-02-04	Inglesa	+56952097370	ezequiel.dybala1486@outlook.com
10001487-4	Matias Álvarez Benzema	1981-10-29	Uruguaya	+56997783017	matias.alvarez1487@yahoo.com
10001488-2	Matias Güler Herrera	2004-11-05	Francesa	+56971402066	matias.güler1488@yahoo.com
10001489-0	Ronaldo Valverde Vásquez	1970-01-21	Alemana	+56949692791	ronaldo.valverde1489@outlook.com
10001490-4	Karim Kroos Benzema	1994-11-11	Colombiana	+56923169906	karim.kroos1490@outlook.com
10001491-2	Álvaro Valverde Muñoz	1998-07-07	Chilena	+56932173886	alvaro.valverde1491@yahoo.com
10001492-0	Romelu Soto Salas	1995-02-04	Chilena	+56927643113	romelu.soto1492@gmail.com
10001493-9	Robert Neuer López	1971-01-08	Chilena	+56918855441	robert.neuer1493@puc.cl
10001494-7	Diego Castillo Salas	1983-03-16	Chilena	+56921184952	diego.castillo1494@usach.cl
10001495-5	Jean Zidane Araya	1994-06-24	Alemana	+56989529446	jean.zidane1495@outlook.com
10001496-3	Ignacio González Cortés	1971-03-14	Chilena	+56984216075	ignacio.gonzalez1496@puc.cl
10001497-1	Oscar Bustos Rivera	1988-11-09	Colombiana	+56928432197	oscar.bustos1497@usach.cl
10001498-K	Kylian Torres Vidal	1989-06-16	Chilena	+56966588343	kylian.torres1498@gmail.com
10001499-8	Sebastián Reyes Pulgar	1993-03-09	Chilena	+56962251746	sebastian.reyes1499@puc.cl
10001500-5	Neymar Pizarro Torres	1981-09-01	Chilena	+56925269837	neymar.pizarro1500@hotmail.com
10001501-3	Thiago Lukaku Haaland	1982-06-29	Chilena	+56944361153	thiago.lukaku1501@yahoo.com
10001502-1	Hernán Espinoza Galdames	1993-03-18	Chilena	+56983907816	hernan.espinoza1502@gmail.com
10001503-K	Álvaro Sepúlveda López	1978-11-09	Chilena	+56928717304	alvaro.sepulveda1503@hotmail.com
10001504-8	Ignacio Cortés Müller	1976-09-01	Chilena	+56947711266	ignacio.cortes1504@outlook.com
10001505-6	Thomas Suazo Messi	1979-03-03	Chilena	+56971857910	thomas.suazo1505@outlook.com
10001506-4	Gonzalo González Müller	1977-08-21	Chilena	+56993908413	gonzalo.gonzalez1506@usach.cl
10001507-2	Maximiliano Modric Aránguiz	1992-03-21	Chilena	+56914844698	maximiliano.modric1507@yahoo.com
10001508-0	Mateo Hernández Fuentes	1987-10-31	Chilena	+56954375149	mateo.hernandez1508@gmail.com
10001509-9	Eduardo López Soto	1989-11-27	Colombiana	+56979681426	eduardo.lopez1509@outlook.com
10001510-2	Luka Beausejour Pizarro	1996-04-05	Inglesa	+56968565760	luka.beausejour1510@puc.cl
10001511-0	Daniel Rivera Güler	2000-03-22	Chilena	+56918989346	daniel.rivera1511@usach.cl
10001512-9	Kevin Haaland Modric	2003-10-18	Chilena	+56932745334	kevin.haaland1512@usach.cl
10001513-7	Esteban Cortés Medel	1973-09-09	Chilena	+56985942254	esteban.cortes1513@gmail.com
10001514-5	Matias Castro Nuñez	1996-07-23	Chilena	+56975111954	matias.castro1514@uca.cl
10001515-3	Luis López Modric	1997-09-02	Portuguesa	+56943833574	luis.lopez1515@gmail.com
10001516-1	Jaime Soto González	1995-07-10	Brasileña	+56950435922	jaime.soto1516@usach.cl
10001517-K	Javier Kroos Espinoza	1990-09-13	Chilena	+56911078408	javier.kroos1517@puc.cl
10001518-8	Erick Suazo Tapia	1975-12-09	Chilena	+56942190365	erick.suazo1518@hotmail.com
10001519-6	Felipe Álvarez Toselli	1973-09-30	Chilena	+56992411307	felipe.alvarez1519@puc.cl
10001520-K	Oscar Díaz González	1990-05-23	Chilena	+56973475030	oscar.diaz1520@hotmail.com
10001521-8	Nicolás Carrasco Salah	1996-10-10	Chilena	+56931071929	nicolas.carrasco1521@yahoo.com
10001522-6	Thomas Muñoz Fernández	1981-05-21	Chilena	+56975954891	thomas.munoz1522@usach.cl
10001523-4	Lionel González Gutiérrez	1995-10-09	Argentina	+56943040867	lionel.gonzalez1523@outlook.com
10001524-2	Felipe Galdames Vergara	1981-03-27	Chilena	+56920085882	felipe.galdames1524@gmail.com
10001525-0	Agustín Ramos Tapia	1981-02-09	Colombiana	+56956009952	agustin.ramos1525@puc.cl
10001526-9	Gastón Riquelme Aránguiz	1984-01-23	Chilena	+56944218890	gaston.riquelme1526@gmail.com
10001527-7	Tomás Castillo Flores	1986-03-16	Peruana	+56979204287	tomas.castillo1527@yahoo.com
10001528-5	Luciano Reyes Carrasco	1995-05-21	Chilena	+56911209353	luciano.reyes1528@usach.cl
10001529-3	Arturo Herrera Vidal	1970-03-26	Chilena	+56955195318	arturo.herrera1529@yahoo.com
10001530-7	Matias Morales Lewandowski	1988-04-19	Italiana	+56977381424	matias.morales1530@outlook.com
10001531-5	Robert Beausejour Arias	1979-11-16	Chilena	+56918833729	robert.beausejour1531@yahoo.com
10001532-3	Johnny Alvarez Arias	1973-02-27	Chilena	+56945465181	johnny.alvarez1532@yahoo.com
10001533-1	Matias Pérez Torres	2004-07-30	Chilena	+56988531688	matias.perez1533@outlook.com
10001534-K	José Valdés Torres	1999-10-04	Española	+56921452485	jose.valdes1534@yahoo.com
10001535-8	Charles Reyes Maripán	1994-02-12	Chilena	+56973382952	charles.reyes1535@uca.cl
10001536-6	Felipe Rojas Vergara	1993-07-24	Chilena	+56988419984	felipe.rojas1536@uca.cl
10001537-4	Esteban Reyes Díaz	1982-02-13	Chilena	+56922916423	esteban.reyes1537@puc.cl
10001538-2	Alexis Gómez Caszely	1973-02-27	Colombiana	+56929414451	alexis.gomez1538@yahoo.com
10001539-0	Harry Suazo Dybala	1978-02-22	Chilena	+56936318310	harry.suazo1539@usach.cl
10001540-4	Sergio Herrera Messi	1994-07-20	Chilena	+56914869448	sergio.herrera1540@usach.cl
10001541-2	Cristopher Muñoz Fuentes	1974-04-28	Uruguaya	+56991267852	cristopher.munoz1541@uca.cl
10001542-0	Ángel Maradona Muñoz	2003-10-18	Peruana	+56995813027	angel.maradona1542@outlook.com
10001543-9	Cristian Herrera Sánchez	1999-04-05	Chilena	+56981364327	cristian.herrera1543@usach.cl
10001544-7	Sebastián Rivera Haaland	1971-12-08	Chilena	+56910254969	sebastian.rivera1544@outlook.com
10001545-5	Matias Suárez Jara	1997-03-18	Uruguaya	+56931548996	matias.suarez1545@puc.cl
10001546-3	Felipe Yamal Díaz	1970-04-27	Chilena	+56955978985	felipe.yamal1546@yahoo.com
10001547-1	Gabriel Beausejour Di María	1989-01-20	Chilena	+56998497948	gabriel.beausejour1547@yahoo.com
10001548-K	Ángel Pérez Rodríguez	1975-02-20	Peruana	+56927809455	angel.perez1548@gmail.com
10001549-8	Sergio Torres Rojas	1983-01-12	Uruguaya	+56940785767	sergio.torres1549@usach.cl
10001550-1	Claudio Pérez Vásquez	1991-11-11	Chilena	+56982098025	claudio.perez1550@usach.cl
10001551-K	Federico Valdés Valenzuela	1987-11-02	Chilena	+56932902200	federico.valdes1551@hotmail.com
10001552-8	Carlos Cortés Pulgar	1970-04-15	Alemana	+56955614064	carlos.cortes1552@gmail.com
10001553-6	Álvaro Jara Torres	1987-02-07	Francesa	+56963138613	alvaro.jara1553@puc.cl
10001554-4	Alejandro De Bruyne Jara	2002-12-17	Chilena	+56946699473	alejandro.de bruyne1554@uca.cl
10001555-2	Raúl Maripán Torres	1997-06-09	Argentina	+56910908361	raul.maripan1555@yahoo.com
10001556-0	Cristopher Jara Müller	1989-10-04	Inglesa	+56916516024	cristopher.jara1556@outlook.com
10001557-9	Arturo Rodríguez Paredes	1976-07-02	Chilena	+56974283612	arturo.rodriguez1557@puc.cl
10001558-7	Cristiano Contreras Saavedra	1971-05-25	Alemana	+56984540721	cristiano.contreras1558@gmail.com
10001559-5	Zinedine Zidane Castillo	1990-02-07	Chilena	+56962466702	zinedine.zidane1559@gmail.com
10001560-9	Johnny Espinoza Valdés	1982-12-23	Chilena	+56987797196	johnny.espinoza1560@usach.cl
10001561-7	Luis Maripán Rodríguez	1983-06-21	Chilena	+56992654445	luis.maripan1561@uca.cl
10001562-5	Matias Díaz Fernández	1971-06-28	Chilena	+56956829427	matias.diaz1562@usach.cl
10001563-3	Ignacio Zidane Suárez	1994-10-03	Francesa	+56998752130	ignacio.zidane1563@hotmail.com
10001564-1	Juan De Bruyne Tapia	1978-05-09	Chilena	+56966301373	juan.de bruyne1564@uca.cl
10001565-K	Pelé Riquelme Pérez	1973-09-13	Chilena	+56969310719	pele.riquelme1565@yahoo.com
10001566-8	Felipe Zidane Cortés	1971-11-30	Chilena	+56984081253	felipe.zidane1566@gmail.com
10001567-6	Facundo Jara Bellingham	1987-12-25	Chilena	+56968779837	facundo.jara1567@usach.cl
10001568-4	Lamine Kane Álvarez	1987-05-01	Chilena	+56996952350	lamine.kane1568@gmail.com
10001569-2	Santiago Güler Martínez	1992-02-10	Chilena	+56923845363	santiago.güler1569@uca.cl
10001570-6	Toni Gutiérrez Caszely	1983-01-26	Chilena	+56927471624	toni.gutierrez1570@outlook.com
10001571-4	Gastón Castillo Alvarez	1972-08-15	Uruguaya	+56998907275	gaston.castillo1571@outlook.com
10001572-2	Pablo Fernández Riquelme	2005-10-10	Chilena	+56913524164	pablo.fernandez1572@yahoo.com
10001573-0	Santino Valenzuela Nuñez	1997-05-14	Chilena	+56928661777	santino.valenzuela1573@hotmail.com
10001574-9	Guillermo Flores Bellingham	2001-02-07	Chilena	+56926899258	guillermo.flores1574@usach.cl
10001575-7	Lautaro Rivera Soto	1974-11-18	Italiana	+56945677742	lautaro.rivera1575@puc.cl
10001576-5	Carlos Toselli Tapia	1970-12-16	Chilena	+56910756939	carlos.toselli1576@uca.cl
10001577-3	Vicente Cortés Valdés	1978-04-01	Chilena	+56960640410	vicente.cortes1577@yahoo.com
10001578-1	Johnny Vásquez Herrera	2004-02-13	Chilena	+56990863625	johnny.vasquez1578@hotmail.com
10001579-K	Marcelo Vargas Soto	1994-11-18	Peruana	+56939584971	marcelo.vargas1579@gmail.com
10001580-3	Lucas Haaland Martínez	2005-09-21	Chilena	+56976683611	lucas.haaland1580@gmail.com
10001581-1	Joaquín López Haaland	1982-05-04	Chilena	+56915594537	joaquin.lopez1581@usach.cl
10001582-K	Luciano Pizarro Maradona	1986-10-04	Brasileña	+56984663517	luciano.pizarro1582@uca.cl
10001583-8	Jaime Beausejour Fernández	1989-11-09	Inglesa	+56988738808	jaime.beausejour1583@usach.cl
10001584-6	Hernán Suazo Pulgar	2004-11-26	Chilena	+56925263061	hernan.suazo1584@hotmail.com
10001585-4	Mohamed Vinicius Mendoza	1993-06-14	Argentina	+56988127541	mohamed.vinicius1585@hotmail.com
10001586-2	Federico Messi Sepúlveda	1992-04-17	Chilena	+56973356030	federico.messi1586@hotmail.com
10001587-0	David Medel Contreras	1975-05-06	Chilena	+56935463785	david.medel1587@usach.cl
10001588-9	Gastón Rodríguez Cortés	1995-02-17	Italiana	+56949892721	gaston.rodriguez1588@uca.cl
10001589-7	Gastón Vásquez Rodri	1989-05-24	Chilena	+56970158649	gaston.vasquez1589@uca.cl
10001590-0	Humberto Bravo Nuñez	1988-01-04	Chilena	+56953731861	humberto.bravo1590@hotmail.com
10001591-9	José Alvarez Valverde	1987-10-06	Chilena	+56970030355	jose.alvarez1591@yahoo.com
10001592-7	Lautaro López Vargas	1998-04-25	Colombiana	+56913676858	lautaro.lopez1592@yahoo.com
10001593-5	Eduardo Salas Soto	1991-12-03	Chilena	+56979623413	eduardo.salas1593@gmail.com
10001594-3	Oscar Gutiérrez Griezmann	1973-12-21	Chilena	+56912261721	oscar.gutierrez1594@usach.cl
10001595-1	Ezequiel Rodri Toselli	1997-03-21	Chilena	+56922680946	ezequiel.rodri1595@usach.cl
10001596-K	Alejandro Vinicius Paredes	1974-12-19	Chilena	+56960259108	alejandro.vinicius1596@puc.cl
10001597-8	Gavi Araya Lukaku	1993-08-22	Chilena	+56955572048	gavi.araya1597@uca.cl
10001598-6	Kevin Arias Isla	1976-01-07	Alemana	+56982453331	kevin.arias1598@puc.cl
10001599-4	Marcelo Arias Valenzuela	1973-01-26	Chilena	+56979017223	marcelo.arias1599@uca.cl
10001600-1	Erick Cavani Sánchez	1972-02-16	Colombiana	+56955575789	erick.cavani1600@yahoo.com
10001601-K	Eduardo Torres Cavani	1993-07-17	Italiana	+56985709930	eduardo.torres1601@uca.cl
10001602-8	Eduardo Di María Beausejour	1979-11-03	Chilena	+56951844606	eduardo.di maria1602@uca.cl
10001603-6	Daniel Benzema Alvarez	1982-05-07	Chilena	+56952470806	daniel.benzema1603@yahoo.com
10001604-4	Álvaro Salah Medel	1991-04-12	Peruana	+56998715919	alvaro.salah1604@usach.cl
10001605-2	José Tapia Flores	1982-11-26	Alemana	+56980139776	jose.tapia1605@hotmail.com
10001606-0	Ronaldo Zidane Rivera	1988-05-25	Chilena	+56994154617	ronaldo.zidane1606@puc.cl
10001607-9	Santiago Messi Vidal	1993-08-21	Italiana	+56934557010	santiago.messi1607@yahoo.com
10001608-7	Sebastián Suárez Espinoza	1995-09-06	Chilena	+56927036215	sebastian.suarez1608@gmail.com
10001609-5	Erling Díaz Tapia	1992-02-23	Chilena	+56955101471	erling.diaz1609@gmail.com
10001610-9	Bastián Flores Figueroa	1993-09-08	Francesa	+56936231174	bastian.flores1610@gmail.com
10001611-7	Cristian Torres Cavani	2001-03-22	Chilena	+56999388860	cristian.torres1611@hotmail.com
10001612-5	Alexis Salas Vergara	1983-09-26	Chilena	+56918748877	alexis.salas1612@yahoo.com
10001613-3	Matías Flores Müller	1987-06-16	Chilena	+56954864670	matias.flores1613@gmail.com
10001614-1	Edinson Pérez Espinoza	1975-08-21	Francesa	+56966256660	edinson.perez1614@uca.cl
10001615-K	Charles Sánchez Isla	1975-07-27	Alemana	+56921245730	charles.sanchez1615@uca.cl
10001616-8	Javier Kane Dybala	1994-10-22	Chilena	+56936940672	javier.kane1616@usach.cl
10001617-6	Joaquín Soto Kane	1991-07-12	Peruana	+56963981054	joaquin.soto1617@uca.cl
10001618-4	Bastián Vidal Araya	1973-12-09	Colombiana	+56951412769	bastian.vidal1618@uca.cl
10001619-2	Bastián Galdames Rojas	1970-01-29	Argentina	+56965928077	bastian.galdames1619@puc.cl
10001620-6	Antoine Haaland Vinicius	1994-11-15	Chilena	+56956792062	antoine.haaland1620@usach.cl
10001621-4	Oscar Valdivia Martínez	1970-06-14	Chilena	+56950895492	oscar.valdivia1621@gmail.com
10001622-2	Cristian Suazo Saavedra	1975-01-02	Chilena	+56966731741	cristian.suazo1622@usach.cl
10001623-0	Hernán Arias Arias	1975-12-03	Chilena	+56919924446	hernan.arias1623@outlook.com
10001624-9	Alexis Haaland Valdés	1972-09-13	Chilena	+56950882590	alexis.haaland1624@yahoo.com
10001625-7	Daniel Flores Vinicius	2002-06-27	Francesa	+56998243649	daniel.flores1625@outlook.com
10001626-5	Jean Lewandowski Ramos	1970-03-03	Chilena	+56965349296	jean.lewandowski1626@uca.cl
10001627-3	Thomas Messi Beausejour	1987-03-19	Chilena	+56910080938	thomas.messi1627@usach.cl
10001628-1	Gonzalo Dybala Contreras	1993-06-03	Inglesa	+56991488598	gonzalo.dybala1628@hotmail.com
10001629-K	Maximiliano Pizarro Carrasco	1975-10-20	Chilena	+56939296974	maximiliano.pizarro1629@outlook.com
10001630-3	Luis Vidal Figueroa	1999-07-12	Chilena	+56982339081	luis.vidal1630@puc.cl
10001631-1	Cristiano Kroos Castillo	1995-01-04	Chilena	+56945585057	cristiano.kroos1631@hotmail.com
10001632-K	Francisco Pulgar Paredes	1993-09-23	Chilena	+56983787479	francisco.pulgar1632@usach.cl
10001633-8	Facundo Valdés Neuer	1986-04-20	Brasileña	+56938233984	facundo.valdes1633@puc.cl
10001634-6	Jean Saavedra Castro	1990-04-28	Chilena	+56952897472	jean.saavedra1634@outlook.com
10001635-4	Agustín Jara Pizarro	2004-07-04	Alemana	+56992677717	agustin.jara1635@hotmail.com
10001636-2	Manuel Vidal Bellingham	1992-03-29	Chilena	+56939172039	manuel.vidal1636@puc.cl
10001637-0	Kylian Araya Gómez	1999-09-12	Chilena	+56950848984	kylian.araya1637@outlook.com
10001638-9	Antoine Silva Kane	2004-02-12	Chilena	+56936294588	antoine.silva1638@uca.cl
10001639-7	Lucas Fuentes Castillo	1998-05-08	Francesa	+56973785057	lucas.fuentes1639@gmail.com
10001640-0	Juan Reyes Martínez	1976-02-13	Chilena	+56995629914	juan.reyes1640@uca.cl
10001641-9	Cristian Arias Galdames	2004-02-07	Española	+56964448423	cristian.arias1641@usach.cl
10001642-7	Jaime Bellingham Bustos	2003-10-06	Colombiana	+56998926006	jaime.bellingham1642@puc.cl
10001643-5	Rodrigo Gómez Pizarro	1976-04-08	Colombiana	+56974139497	rodrigo.gomez1643@hotmail.com
10001644-3	Ángel Araya Vinicius	1980-07-25	Chilena	+56928839637	angel.araya1644@gmail.com
10001645-1	Cristian Maripán Torres	1993-01-05	Brasileña	+56964714857	cristian.maripan1645@outlook.com
10001646-K	Gavi Flores Kroos	1986-10-23	Inglesa	+56934175747	gavi.flores1646@usach.cl
10001647-8	Bastián Carrasco Pulgar	1989-05-18	Chilena	+56934491084	bastian.carrasco1647@puc.cl
10001648-6	Enzo Bustos Vargas	1991-06-19	Argentina	+56960341944	enzo.bustos1648@puc.cl
10001649-4	Kylian Sepúlveda Suazo	1990-10-13	Chilena	+56949918311	kylian.sepulveda1649@gmail.com
10001650-8	Tomás Bellingham Salah	1983-11-24	Italiana	+56970400953	tomas.bellingham1650@outlook.com
10001651-6	Bautista Herrera Müller	1978-03-24	Peruana	+56926733410	bautista.herrera1651@puc.cl
10001652-4	Robert Zidane Herrera	1970-04-25	Chilena	+56985429047	robert.zidane1652@hotmail.com
10001653-2	Jorge Vidal Müller	1992-09-26	Española	+56975066923	jorge.vidal1653@outlook.com
10001654-0	Oscar Lewandowski Morales	1993-06-13	Chilena	+56956658161	oscar.lewandowski1654@outlook.com
10001655-9	Bautista Modric Castro	1987-08-16	Chilena	+56939371662	bautista.modric1655@usach.cl
10001656-7	Cristiano Araya Vinicius	1990-11-12	Chilena	+56935431602	cristiano.araya1656@uca.cl
10001657-5	Marcelo Mbappe Díaz	1973-07-11	Chilena	+56964776898	marcelo.mbappe1657@hotmail.com
10001658-3	Santino Vidal Castillo	1999-11-26	Chilena	+56916595553	santino.vidal1658@outlook.com
10001659-1	Pablo Vinicius Pulgar	1977-02-08	Chilena	+56939874204	pablo.vinicius1659@gmail.com
10001660-5	Claudio Nuñez Salah	1993-08-06	Chilena	+56935635224	claudio.nunez1660@gmail.com
10001661-3	Matías Rivera Maradona	1992-11-18	Chilena	+56961034489	matias.rivera1661@uca.cl
10001662-1	Maximiliano Muñoz Lewandowski	1986-11-27	Colombiana	+56933451328	maximiliano.munoz1662@gmail.com
10001663-K	Lautaro Bellingham Zidane	2004-03-01	Chilena	+56924820008	lautaro.bellingham1663@gmail.com
10001664-8	Jaime Silva Vidal	2004-12-15	Chilena	+56929130782	jaime.silva1664@usach.cl
10001665-6	Javier Morales Mendoza	1984-01-31	Chilena	+56916574211	javier.morales1665@hotmail.com
10001666-4	Lucas Sepúlveda Valdivia	1993-03-20	Chilena	+56939325790	lucas.sepulveda1666@uca.cl
10001667-2	Harry Gómez Torres	1993-01-14	Portuguesa	+56913288450	harry.gomez1667@usach.cl
10001668-0	Jean Di María Valenzuela	1999-09-15	Chilena	+56975041129	jean.di maria1668@outlook.com
10001669-9	Johnny Benzema Herrera	2003-01-16	Chilena	+56986160276	johnny.benzema1669@usach.cl
10001670-2	Harry Hernández Rodríguez	1983-03-07	Italiana	+56992715467	harry.hernandez1670@gmail.com
10001671-0	Harry Cortés Castro	2005-12-02	Alemana	+56949468771	harry.cortes1671@puc.cl
10001672-9	Cristopher Gómez Muñoz	1981-01-04	Uruguaya	+56965970169	cristopher.gomez1672@outlook.com
10001673-7	Gustavo Mendoza Caszely	1999-11-29	Chilena	+56992350032	gustavo.mendoza1673@outlook.com
10001674-5	David Maradona Galdames	1988-12-18	Chilena	+56996841429	david.maradona1674@puc.cl
10001675-3	Enzo Haaland Contreras	1997-06-15	Uruguaya	+56998620691	enzo.haaland1675@yahoo.com
10001676-1	Gonzalo Bustos Martínez	1978-10-14	Argentina	+56927735436	gonzalo.bustos1676@usach.cl
10001677-K	Eduardo Rodríguez Galdames	1996-11-14	Chilena	+56964710860	eduardo.rodriguez1677@puc.cl
10001678-8	Andrés Sepúlveda Suárez	1989-06-18	Chilena	+56985100678	andres.sepulveda1678@gmail.com
10001679-6	Cristopher Morales Rodri	1991-05-04	Italiana	+56925206860	cristopher.morales1679@gmail.com
10001680-K	Felipe Vinicius Fuentes	1974-11-24	Portuguesa	+56984026810	felipe.vinicius1680@puc.cl
10001681-8	Ignacio Valverde Kroos	1992-11-13	Chilena	+56948446768	ignacio.valverde1681@gmail.com
10001682-6	Antoine Modric Álvarez	1990-05-29	Italiana	+56947899362	antoine.modric1682@outlook.com
10001683-4	Santino Morales Riquelme	2005-01-26	Chilena	+56945697002	santino.morales1683@usach.cl
10001684-2	Cristiano Di María Nuñez	1978-11-13	Chilena	+56942330799	cristiano.di maria1684@usach.cl
10001685-0	Gustavo Torres Caszely	2005-04-16	Colombiana	+56928778445	gustavo.torres1685@outlook.com
10001686-9	Lautaro Soto Reyes	2002-10-12	Uruguaya	+56949740903	lautaro.soto1686@hotmail.com
10001687-7	Esteban Bustos Figueroa	1989-02-03	Chilena	+56985484041	esteban.bustos1687@outlook.com
10001688-5	Gabriel Morales Griezmann	1990-11-23	Chilena	+56958432222	gabriel.morales1688@hotmail.com
10001689-3	Ezequiel Caszely Riquelme	1989-01-17	Chilena	+56927718013	ezequiel.caszely1689@usach.cl
10001690-7	Lionel Suazo Güler	1972-04-22	Chilena	+56922977071	lionel.suazo1690@gmail.com
10001691-5	Nicolás Zidane Caszely	2005-05-17	Chilena	+56979316264	nicolas.zidane1691@outlook.com
10001692-3	Martín Modric Valenzuela	1989-01-18	Chilena	+56988645697	martin.modric1692@uca.cl
10001693-1	Álvaro Ronaldo Torres	1995-07-28	Chilena	+56944979298	alvaro.ronaldo1693@gmail.com
10001694-K	Claudio Kane Valdés	1979-10-01	Chilena	+56989285334	claudio.kane1694@gmail.com
10001695-8	Oscar Aránguiz Bellingham	2005-03-14	Chilena	+56974840387	oscar.aranguiz1695@yahoo.com
10001696-6	Pelé Dybala Suazo	1997-09-09	Chilena	+56998084585	pele.dybala1696@usach.cl
10001697-4	Esteban Salah Castro	1995-05-23	Chilena	+56914310937	esteban.salah1697@puc.cl
10001698-2	Cristian Rojas Hernández	1974-03-19	Brasileña	+56922045852	cristian.rojas1698@uca.cl
10001699-0	José Muñoz Ramos	1985-09-01	Chilena	+56950473858	jose.munoz1699@outlook.com
10001700-8	Carlos Aránguiz Beausejour	2001-02-03	Chilena	+56915685144	carlos.aranguiz1700@uca.cl
10001701-6	Antoine Araya Castillo	2002-03-08	Chilena	+56987574779	antoine.araya1701@uca.cl
10001702-4	Andrés Fernández Herrera	1991-04-09	Alemana	+56912951657	andres.fernandez1702@puc.cl
10001703-2	Maximiliano Gutiérrez Reyes	1982-03-04	Chilena	+56945731243	maximiliano.gutierrez1703@usach.cl
10001704-0	Harry Espinoza Kroos	1975-01-31	Chilena	+56985107761	harry.espinoza1704@yahoo.com
10001705-9	Lucas Reyes Araya	1996-05-02	Chilena	+56974374386	lucas.reyes1705@yahoo.com
10001706-7	Antoine Bustos Vergara	2005-02-15	Peruana	+56961314308	antoine.bustos1706@puc.cl
10001707-5	Lamine Alvarez Bravo	1993-07-21	Chilena	+56996196511	lamine.alvarez1707@usach.cl
10001708-3	Toni Rivera Herrera	2004-07-15	Chilena	+56983555513	toni.rivera1708@uca.cl
10001709-1	Gonzalo Rivera Carrasco	1998-04-16	Portuguesa	+56928429110	gonzalo.rivera1709@puc.cl
10001710-5	Karim Di María Rivera	2001-08-02	Uruguaya	+56967518062	karim.di maria1710@yahoo.com
10001711-3	Pablo Modric Haaland	2003-02-16	Uruguaya	+56992096878	pablo.modric1711@gmail.com
10001712-1	Cristiano Yamal Paredes	1986-11-20	Peruana	+56953390915	cristiano.yamal1712@yahoo.com
10001713-K	Luis Griezmann Cortés	1986-02-01	Chilena	+56951630509	luis.griezmann1713@uca.cl
10001714-8	Matias Contreras Maradona	1989-04-02	Chilena	+56927259839	matias.contreras1714@uca.cl
10001715-6	Mauricio Messi Martínez	1976-02-06	Chilena	+56949501389	mauricio.messi1715@uca.cl
10001716-4	Diego Lewandowski Yamal	1976-12-03	Chilena	+56961117595	diego.lewandowski1716@usach.cl
10001717-2	Mauricio Vergara Galdames	1972-07-14	Alemana	+56949331696	mauricio.vergara1717@yahoo.com
10001718-0	Neymar Valdivia Salas	1982-12-18	Colombiana	+56945463153	neymar.valdivia1718@puc.cl
10001719-9	Harry Arias Álvarez	1981-01-12	Peruana	+56918527276	harry.arias1719@gmail.com
10001720-2	Jaime Valdés Riquelme	1994-07-16	Chilena	+56949706371	jaime.valdes1720@yahoo.com
10001721-0	Benjamín Carrasco Muñoz	2004-01-11	Chilena	+56944779364	benjamin.carrasco1721@usach.cl
10001722-9	Alejandro Ronaldo Salah	1994-04-07	Chilena	+56993824189	alejandro.ronaldo1722@usach.cl
10001723-7	Rodrigo Zidane Flores	1997-05-14	Inglesa	+56941181598	rodrigo.zidane1723@yahoo.com
10001724-5	Pedri Reyes Contreras	1983-12-10	Francesa	+56919042575	pedri.reyes1724@gmail.com
10001725-3	Diego Díaz Díaz	1970-02-13	Portuguesa	+56916706077	diego.diaz1725@hotmail.com
10001726-1	Luka Pulgar Vinicius	2005-11-05	Chilena	+56926934653	luka.pulgar1726@gmail.com
10001727-K	Manuel Mendoza López	1975-05-28	Brasileña	+56941355506	manuel.mendoza1727@yahoo.com
10001728-8	Esteban Gutiérrez Salah	1979-11-01	Uruguaya	+56936510085	esteban.gutierrez1728@usach.cl
10001729-6	José Fernández Messi	1989-09-27	Chilena	+56983920149	jose.fernandez1729@gmail.com
10001730-K	Julian Pizarro Vásquez	1994-07-21	Chilena	+56943678677	julian.pizarro1730@outlook.com
10001731-8	Agustín Kroos Haaland	1991-07-18	Chilena	+56944304756	agustin.kroos1731@yahoo.com
10001732-6	Gonzalo Suazo Beausejour	1992-05-01	Chilena	+56946701276	gonzalo.suazo1732@puc.cl
10001733-4	Erling Müller Muñoz	1999-05-10	Chilena	+56967781950	erling.müller1733@usach.cl
10001734-2	Lamine Soto Cortés	1988-12-05	Chilena	+56947666251	lamine.soto1734@hotmail.com
10001735-0	Luka Silva Espinoza	2002-07-01	Chilena	+56979921527	luka.silva1735@uca.cl
10001736-9	Arturo Torres Fuentes	1983-11-08	Chilena	+56980751220	arturo.torres1736@puc.cl
10001737-7	Diego Rojas Medel	1974-06-26	Chilena	+56922618648	diego.rojas1737@uca.cl
10001738-5	Gavi Morales Pizarro	1982-09-08	Brasileña	+56922669096	gavi.morales1738@yahoo.com
10001739-3	Guillermo Vásquez Alvarez	1980-03-01	Española	+56982116697	guillermo.vasquez1739@uca.cl
10001740-7	Julian Riquelme Fuentes	2005-07-09	Argentina	+56974129615	julian.riquelme1740@gmail.com
10001741-5	Eduardo Müller Valdivia	1994-07-11	Inglesa	+56989532153	eduardo.müller1741@hotmail.com
10001742-3	Pelé Díaz Sánchez	1989-07-17	Colombiana	+56934068383	pele.diaz1742@outlook.com
10001743-1	Neymar Caszely Griezmann	1989-02-07	Chilena	+56989317559	neymar.caszely1743@outlook.com
10001744-K	Bautista Álvarez Rivera	1977-08-19	Portuguesa	+56964391275	bautista.alvarez1744@hotmail.com
10001745-8	Álvaro Figueroa Zidane	1993-10-23	Chilena	+56994703305	alvaro.figueroa1745@yahoo.com
10001746-6	Gastón Müller Valverde	1979-12-09	Chilena	+56979777614	gaston.müller1746@outlook.com
10001747-4	Mauricio Salas Muñoz	2001-01-25	Chilena	+56998215756	mauricio.salas1747@outlook.com
10001748-2	Matias Bravo Saavedra	1978-05-24	Chilena	+56977860177	matias.bravo1748@outlook.com
10001749-0	Maximiliano Flores Salah	1995-02-04	Chilena	+56952362659	maximiliano.flores1749@gmail.com
10001750-4	Pedro Haaland López	1994-09-22	Chilena	+56967777281	pedro.haaland1750@outlook.com
10001751-2	Harry Valdés Ronaldo	1981-07-15	Chilena	+56948614154	harry.valdes1751@uca.cl
10001752-0	Guillermo Jara Soto	2002-01-12	Chilena	+56933878003	guillermo.jara1752@uca.cl
10001753-9	Tomás Riquelme Fernández	1998-07-09	Chilena	+56951820661	tomas.riquelme1753@outlook.com
10001754-7	Tomás Pizarro Contreras	1988-02-20	Chilena	+56913026736	tomas.pizarro1754@outlook.com
10001755-5	Matías Gómez Díaz	1986-10-13	Portuguesa	+56932086790	matias.gomez1755@hotmail.com
10001756-3	Matias Herrera Saavedra	1983-10-25	Chilena	+56999907617	matias.herrera1756@uca.cl
10001757-1	Enzo Reyes Lewandowski	1973-02-19	Chilena	+56984636333	enzo.reyes1757@usach.cl
10001758-K	Thiago Pérez Galdames	1993-02-14	Chilena	+56987798495	thiago.perez1758@outlook.com
10001759-8	Erling González López	1983-11-25	Chilena	+56918797663	erling.gonzalez1759@puc.cl
10001760-1	Angel Pizarro Silva	1970-08-20	Argentina	+56992570585	angel.pizarro1760@outlook.com
10001761-K	Thomas Espinoza Castro	1973-12-04	Chilena	+56914611093	thomas.espinoza1761@uca.cl
10001762-8	Gonzalo Díaz Toselli	1989-11-16	Chilena	+56942067388	gonzalo.diaz1762@puc.cl
10001763-6	Mauricio Contreras Gómez	1980-12-04	Alemana	+56990677770	mauricio.contreras1763@puc.cl
10001764-4	Daniel Jara Lewandowski	1998-06-09	Chilena	+56946982610	daniel.jara1764@outlook.com
10001765-2	Harry Bravo Toselli	1988-10-28	Chilena	+56956051102	harry.bravo1765@uca.cl
10001766-0	Paulo Toselli Vinicius	1980-04-18	Uruguaya	+56937523111	paulo.toselli1766@uca.cl
10001767-9	Federico Sánchez Herrera	1997-10-26	Chilena	+56934834090	federico.sanchez1767@uca.cl
10001768-7	Guillermo Espinoza Gutiérrez	1980-11-30	Chilena	+56980276069	guillermo.espinoza1768@uca.cl
10001769-5	Thiago Ramos Sánchez	1991-09-23	Chilena	+56954248089	thiago.ramos1769@gmail.com
10001770-9	Esteban Cavani Lukaku	1980-06-13	Chilena	+56928241163	esteban.cavani1770@hotmail.com
10001771-7	Álvaro Modric Rodri	1985-07-03	Chilena	+56936635000	alvaro.modric1771@usach.cl
10001772-5	Matías Pizarro Dybala	2003-11-13	Chilena	+56910174013	matias.pizarro1772@usach.cl
10001773-3	Andrés Yamal Zidane	1988-10-06	Chilena	+56971084052	andres.yamal1773@outlook.com
10001774-1	Álvaro González Cavani	1993-09-15	Chilena	+56984093168	alvaro.gonzalez1774@gmail.com
10001775-K	Maximiliano Hernández Vásquez	1993-07-22	Chilena	+56980723614	maximiliano.hernandez1775@hotmail.com
10001776-8	Benjamín Di María Díaz	1976-06-02	Chilena	+56973954828	benjamin.di maria1776@outlook.com
10001777-6	Luka Gutiérrez Paredes	1981-07-12	Chilena	+56925785047	luka.gutierrez1777@gmail.com
10001778-4	Romelu Salas Messi	1996-05-19	Portuguesa	+56916243059	romelu.salas1778@hotmail.com
10001779-2	Lucas Bellingham Paredes	1983-06-06	Chilena	+56967225779	lucas.bellingham1779@puc.cl
10001780-6	Cristiano Rodríguez Toselli	1996-12-14	Colombiana	+56982813451	cristiano.rodriguez1780@hotmail.com
10001781-4	Maximiliano Gómez Valdivia	2001-11-29	Uruguaya	+56960449582	maximiliano.gomez1781@yahoo.com
10001782-2	Lamine Valdivia Vergara	1985-12-01	Chilena	+56951028680	lamine.valdivia1782@outlook.com
10001783-0	Alexis Griezmann Valdés	1981-08-13	Española	+56914381853	alexis.griezmann1783@uca.cl
10001784-9	Juan Zidane Modric	1994-11-22	Italiana	+56973082773	juan.zidane1784@yahoo.com
10001785-7	Edinson Griezmann Maripán	1991-09-28	Brasileña	+56922430383	edinson.griezmann1785@uca.cl
10001786-5	Cristopher Cavani Aránguiz	2001-10-31	Chilena	+56983374084	cristopher.cavani1786@outlook.com
10001787-3	Luis Griezmann Messi	2003-08-21	Chilena	+56962599206	luis.griezmann1787@outlook.com
10001788-1	Agustín Messi Vinicius	1989-10-05	Chilena	+56930937196	agustin.messi1788@puc.cl
10001789-K	Nicolás Díaz Lewandowski	1974-05-07	Chilena	+56977490507	nicolas.diaz1789@outlook.com
10001790-3	Tomás Vásquez Yamal	1972-11-05	Chilena	+56998344195	tomas.vasquez1790@puc.cl
10001791-1	Rodrigo Soto Torres	1984-06-14	Chilena	+56980360455	rodrigo.soto1791@gmail.com
10001792-K	Vicente Martínez Nuñez	1979-01-23	Chilena	+56962592025	vicente.martinez1792@puc.cl
10001793-8	Angel Aránguiz Lewandowski	1997-02-07	Brasileña	+56983876959	angel.aranguiz1793@uca.cl
10001794-6	Johnny Valdivia Jara	2002-08-20	Española	+56967084259	johnny.valdivia1794@uca.cl
10001795-4	Thiago Lukaku López	1981-05-20	Chilena	+56957303263	thiago.lukaku1795@yahoo.com
10001796-2	Robert Vargas Müller	1984-11-24	Chilena	+56977783243	robert.vargas1796@outlook.com
10001797-0	Santiago Güler Griezmann	1975-02-08	Española	+56965645452	santiago.güler1797@outlook.com
10001798-9	Alejandro Figueroa González	1970-08-22	Chilena	+56998330742	alejandro.figueroa1798@yahoo.com
10001799-7	Gonzalo Müller Benzema	1999-03-14	Portuguesa	+56941827881	gonzalo.müller1799@uca.cl
10001800-4	Juan Yamal Morales	1977-09-08	Chilena	+56948776612	juan.yamal1800@usach.cl
10001801-2	Alejandro Toselli Morales	1997-04-27	Uruguaya	+56916051533	alejandro.toselli1801@gmail.com
10001802-0	Pablo Mbappe Vergara	1974-11-26	Uruguaya	+56957912737	pablo.mbappe1802@puc.cl
10001803-9	Álvaro Díaz Carrasco	1972-01-29	Chilena	+56980214519	alvaro.diaz1803@puc.cl
10001804-7	Javier Morales Jara	2003-06-18	Chilena	+56941782432	javier.morales1804@gmail.com
10001805-5	Eduardo Di María Saavedra	1985-03-23	Chilena	+56934375163	eduardo.di maria1805@gmail.com
10001806-3	Pablo Vásquez Lewandowski	1997-01-14	Chilena	+56989235841	pablo.vasquez1806@hotmail.com
10001807-1	Robert Espinoza Muñoz	1995-06-01	Colombiana	+56954451222	robert.espinoza1807@outlook.com
10001808-K	Maximiliano De Bruyne Rodríguez	2002-07-07	Chilena	+56970084662	maximiliano.de bruyne1808@puc.cl
10001809-8	Alexis Valdés Bellingham	2001-08-22	Chilena	+56963710365	alexis.valdes1809@usach.cl
10001810-1	Raúl Tapia Rodri	1987-08-08	Chilena	+56986507516	raul.tapia1810@hotmail.com
10001811-K	Maximiliano Rodri Caszely	1980-09-17	Chilena	+56974343932	maximiliano.rodri1811@puc.cl
10001812-8	Claudio Reyes Martínez	1990-05-23	Chilena	+56940586365	claudio.reyes1812@usach.cl
10001813-6	Marcelo Tapia Caszely	2005-06-12	Argentina	+56965252373	marcelo.tapia1813@puc.cl
10001814-4	Esteban Valenzuela Valverde	1992-11-12	Chilena	+56954014647	esteban.valenzuela1814@puc.cl
10001815-2	Humberto Hernández Beausejour	1972-12-16	Chilena	+56914518461	humberto.hernandez1815@usach.cl
10001816-0	Manuel Galdames Flores	1998-02-02	Chilena	+56949454429	manuel.galdames1816@hotmail.com
10001817-9	Nicolás Figueroa Cavani	1972-05-08	Chilena	+56979317444	nicolas.figueroa1817@gmail.com
10001818-7	Federico Muñoz Kane	2001-05-03	Chilena	+56963648923	federico.munoz1818@outlook.com
10001819-5	Bastián Lewandowski Muñoz	1994-06-11	Chilena	+56929695521	bastian.lewandowski1819@yahoo.com
10001820-9	Daniel Benzema Suazo	1993-06-13	Uruguaya	+56936651777	daniel.benzema1820@usach.cl
10001821-7	Sergio Morales Muñoz	1991-08-23	Colombiana	+56985356960	sergio.morales1821@yahoo.com
10001822-5	Ángel Kane Neuer	1984-05-24	Chilena	+56917671579	angel.kane1822@uca.cl
10001823-3	Humberto Neuer Bellingham	1972-03-16	Chilena	+56977699107	humberto.neuer1823@gmail.com
10001824-1	Lionel Jara Rodri	1979-05-25	Chilena	+56934294104	lionel.jara1824@outlook.com
10001825-K	Maximiliano Torres Pulgar	1984-01-18	Chilena	+56999243157	maximiliano.torres1825@gmail.com
10001826-8	Ignacio Hernández Alvarez	1994-04-15	Francesa	+56952869366	ignacio.hernandez1826@hotmail.com
10001827-6	Santiago Valdivia Vargas	1994-12-03	Alemana	+56953254262	santiago.valdivia1827@uca.cl
10001828-4	Gavi Rodri Salah	1996-07-15	Argentina	+56990144765	gavi.rodri1828@usach.cl
10001829-2	Gonzalo Messi Torres	1999-03-15	Colombiana	+56933354362	gonzalo.messi1829@usach.cl
10001830-6	Pelé Álvarez Vergara	2003-10-23	Chilena	+56992825611	pele.alvarez1830@outlook.com
10001831-4	Oscar Díaz Cortés	1996-09-30	Chilena	+56943396544	oscar.diaz1831@yahoo.com
10001832-2	Pablo Rivera Caszely	1996-08-19	Chilena	+56910108257	pablo.rivera1832@puc.cl
10001833-0	Oscar Hernández Caszely	1972-08-27	Chilena	+56923074423	oscar.hernandez1833@puc.cl
10001834-9	Matias Pulgar Reyes	1988-08-19	Alemana	+56920574474	matias.pulgar1834@gmail.com
10001835-7	Lautaro Cortés Rojas	1978-06-15	Chilena	+56983995612	lautaro.cortes1835@yahoo.com
10001836-5	Federico González Maripán	1999-02-17	Chilena	+56915948699	federico.gonzalez1836@hotmail.com
10001837-3	Gonzalo Gómez Arias	1976-10-21	Chilena	+56972737620	gonzalo.gomez1837@outlook.com
10001838-1	Diego Aránguiz Galdames	2001-05-19	Chilena	+56931825366	diego.aranguiz1838@yahoo.com
10001839-K	Martín Bellingham Rodri	1979-05-15	Chilena	+56962053864	martin.bellingham1839@hotmail.com
10001840-3	Gonzalo Castillo Figueroa	1971-12-07	Chilena	+56931321187	gonzalo.castillo1840@uca.cl
10001841-1	Maximiliano Valenzuela Castillo	1984-04-15	Chilena	+56950280672	maximiliano.valenzuela1841@usach.cl
10001842-K	Kylian Riquelme Valdivia	1981-08-27	Chilena	+56942706095	kylian.riquelme1842@gmail.com
10001843-8	Ronaldo Torres Mendoza	1982-08-12	Brasileña	+56924050405	ronaldo.torres1843@hotmail.com
10001844-6	Diego Aránguiz Castillo	1989-11-12	Española	+56993069081	diego.aranguiz1844@hotmail.com
10001845-4	Facundo Haaland Rojas	1989-04-19	Chilena	+56919554458	facundo.haaland1845@hotmail.com
10001846-2	Pablo Jara Dybala	1971-06-25	Chilena	+56946055374	pablo.jara1846@yahoo.com
10001847-0	Romelu Mbappe Yamal	1989-04-05	Chilena	+56931534136	romelu.mbappe1847@usach.cl
10001848-9	Federico González Hernández	1988-12-01	Chilena	+56983940815	federico.gonzalez1848@gmail.com
10001849-7	Bastián Bellingham Vargas	1984-08-03	Chilena	+56984644605	bastian.bellingham1849@yahoo.com
10001850-0	Agustín Kane Jara	1995-09-16	Chilena	+56951559465	agustin.kane1850@uca.cl
10001851-9	Luka Kroos Alvarez	1984-10-19	Chilena	+56942663247	luka.kroos1851@yahoo.com
10001852-7	Mateo Espinoza Riquelme	1998-08-04	Chilena	+56911869755	mateo.espinoza1852@uca.cl
10001853-5	Luis Ramos Galdames	1974-10-21	Argentina	+56990058668	luis.ramos1853@usach.cl
10001854-3	David Beausejour Vergara	1982-07-24	Española	+56982626915	david.beausejour1854@yahoo.com
10001855-1	Thiago Pérez Muñoz	1999-07-12	Chilena	+56912862353	thiago.perez1855@hotmail.com
10001856-K	Karim Benzema Bellingham	1980-12-21	Chilena	+56924084081	karim.benzema1856@gmail.com
10001857-8	Pedri Suazo Yamal	1979-06-23	Inglesa	+56982025877	pedri.suazo1857@outlook.com
10001858-6	Santino Álvarez Gutiérrez	2002-06-29	Chilena	+56975611176	santino.alvarez1858@gmail.com
10001859-4	Bautista Rodri Di María	1989-09-01	Brasileña	+56914783670	bautista.rodri1859@uca.cl
10001860-8	Johnny Ramos Maradona	2000-08-30	Chilena	+56920606354	johnny.ramos1860@uca.cl
10001861-6	Jorge Jara Güler	1977-05-14	Brasileña	+56952547831	jorge.jara1861@outlook.com
10001862-4	Álvaro Pérez Suazo	1978-02-08	Inglesa	+56968262040	alvaro.perez1862@hotmail.com
10001863-2	Tomás Flores Maradona	1984-01-31	Chilena	+56928455008	tomas.flores1863@gmail.com
10001864-0	Bautista Pizarro Flores	1975-11-23	Chilena	+56929736603	bautista.pizarro1864@gmail.com
10001865-9	Lautaro Ronaldo Kroos	1989-08-15	Chilena	+56923796350	lautaro.ronaldo1865@outlook.com
10001866-7	Thomas Fernández Isla	1990-04-13	Francesa	+56997227187	thomas.fernandez1866@gmail.com
10001867-5	Angel Medel Bravo	1977-11-19	Chilena	+56939839597	angel.medel1867@yahoo.com
10001868-3	Álvaro Bravo Suazo	1999-06-28	Chilena	+56955590424	alvaro.bravo1868@yahoo.com
10001869-1	Lucas Valdés Zidane	1986-10-18	Chilena	+56949621142	lucas.valdes1869@outlook.com
10001870-5	Erick Müller Salah	1998-12-24	Argentina	+56951999017	erick.müller1870@uca.cl
10001871-3	Kevin Vinicius Álvarez	1981-03-27	Española	+56984104946	kevin.vinicius1871@yahoo.com
10001872-1	Ronaldo Vargas Kroos	2005-04-26	Chilena	+56969577632	ronaldo.vargas1872@puc.cl
10001873-K	Charles Flores Sepúlveda	1985-02-10	Chilena	+56954293585	charles.flores1873@hotmail.com
10001874-8	Lamine Haaland Neuer	1996-11-11	Portuguesa	+56949105438	lamine.haaland1874@gmail.com
10001875-6	Federico Álvarez Dybala	1976-04-23	Chilena	+56932801200	federico.alvarez1875@usach.cl
10001876-4	Maximiliano Alvarez Pérez	2003-07-03	Brasileña	+56941959233	maximiliano.alvarez1876@outlook.com
10001877-2	Federico Vidal Espinoza	1993-02-26	Chilena	+56912903156	federico.vidal1877@gmail.com
10001878-0	Ezequiel Muñoz Díaz	1979-04-07	Chilena	+56988833811	ezequiel.munoz1878@puc.cl
10001879-9	Marcos Fernández Muñoz	1976-05-08	Chilena	+56971624506	marcos.fernandez1879@puc.cl
10001880-2	Charles Kane Rodríguez	1974-01-08	Chilena	+56946801742	charles.kane1880@usach.cl
10001881-0	Lucas Álvarez Gómez	2001-03-15	Chilena	+56967276787	lucas.alvarez1881@hotmail.com
10001882-9	Ángel Vásquez Mbappe	1977-12-27	Chilena	+56993078410	angel.vasquez1882@puc.cl
10001883-7	Pedri Beausejour Dybala	1970-05-09	Chilena	+56994001788	pedri.beausejour1883@uca.cl
10001884-5	Marcelo Valdés Castillo	1995-04-15	Chilena	+56935805885	marcelo.valdes1884@yahoo.com
10001885-3	Daniel Medel Reyes	1989-09-06	Brasileña	+56977360341	daniel.medel1885@puc.cl
10001886-1	Vicente Messi Pizarro	1983-09-21	Chilena	+56974302647	vicente.messi1886@puc.cl
10001887-K	Álvaro Kane Pulgar	1999-12-01	Chilena	+56954711032	alvaro.kane1887@puc.cl
10001888-8	Gary Vargas Valverde	1984-08-01	Alemana	+56917824632	gary.vargas1888@hotmail.com
10001889-6	Santino Rodríguez Martínez	1999-08-04	Francesa	+56946015574	santino.rodriguez1889@yahoo.com
10001890-K	Guillermo Arias Valdivia	1992-05-04	Chilena	+56983585941	guillermo.arias1890@usach.cl
10001891-8	Luis Jara Kroos	1971-01-19	Española	+56969727146	luis.jara1891@yahoo.com
10001892-6	Alexis Suárez Morales	1984-06-13	Chilena	+56983938775	alexis.suarez1892@hotmail.com
10001893-4	Federico Pérez Yamal	1980-03-08	Francesa	+56948777647	federico.perez1893@yahoo.com
10001894-2	Álvaro Haaland Rojas	1979-09-30	Chilena	+56921983214	alvaro.haaland1894@outlook.com
10001895-0	Ronaldo Güler Saavedra	1988-12-10	Alemana	+56939457424	ronaldo.güler1895@hotmail.com
10001896-9	Lamine Lewandowski Cortés	1973-12-19	Chilena	+56953026891	lamine.lewandowski1896@uca.cl
10001897-7	Cristopher Martínez Sánchez	1999-06-27	Chilena	+56929508099	cristopher.martinez1897@hotmail.com
10001898-5	Pedro Rodríguez Pulgar	2001-06-02	Chilena	+56950020807	pedro.rodriguez1898@hotmail.com
10001899-3	José Lewandowski Rojas	1975-05-21	Portuguesa	+56945441149	jose.lewandowski1899@outlook.com
10001900-0	Esteban Lukaku Herrera	1999-02-12	Argentina	+56912517624	esteban.lukaku1900@hotmail.com
10001901-9	Daniel Muñoz Caszely	1980-05-29	Chilena	+56919214124	daniel.munoz1901@usach.cl
10001902-7	Marcelo Yamal Arias	2003-07-28	Chilena	+56915216537	marcelo.yamal1902@yahoo.com
10001903-5	Johnny Vergara Mbappe	1975-11-04	Española	+56913422822	johnny.vergara1903@outlook.com
10001904-3	Lautaro Reyes Rojas	2002-12-03	Chilena	+56955397058	lautaro.reyes1904@outlook.com
10001905-1	Gonzalo Gómez Vargas	2002-05-07	Chilena	+56975382094	gonzalo.gomez1905@puc.cl
10001906-K	Oscar Sepúlveda Reyes	1987-05-27	Brasileña	+56988662806	oscar.sepulveda1906@puc.cl
10001907-8	Neymar Araya López	1986-11-07	Brasileña	+56968352674	neymar.araya1907@usach.cl
10001908-6	Julian Flores Alvarez	1981-09-15	Chilena	+56954246017	julian.flores1908@uca.cl
10001909-4	Carlos Vargas Beausejour	2000-07-14	Chilena	+56976378090	carlos.vargas1909@outlook.com
10001910-8	Gonzalo Vargas López	2000-04-15	Chilena	+56945681474	gonzalo.vargas1910@puc.cl
10001911-6	Álvaro Díaz Ronaldo	1975-07-01	Chilena	+56936208793	alvaro.diaz1911@usach.cl
10001912-4	Erick Alvarez Alvarez	1987-01-14	Chilena	+56988834857	erick.alvarez1912@hotmail.com
10001913-2	Andrés Medel Isla	1995-01-12	Chilena	+56930754726	andres.medel1913@yahoo.com
10001914-0	Marcos Isla Fernández	1991-08-06	Chilena	+56910009924	marcos.isla1914@puc.cl
10001915-9	Pedri López Haaland	1985-02-18	Chilena	+56925829401	pedri.lopez1915@puc.cl
10001916-7	Neymar Vargas Maripán	1980-05-19	Chilena	+56975750517	neymar.vargas1916@puc.cl
10001917-5	Robert Rodri Vásquez	2004-04-08	Chilena	+56923819579	robert.rodri1917@outlook.com
10001918-3	Cristopher Pizarro Valdés	1991-07-24	Brasileña	+56925639870	cristopher.pizarro1918@outlook.com
10001919-1	Guillermo Fernández Paredes	1970-01-26	Chilena	+56911228753	guillermo.fernandez1919@uca.cl
10001920-5	Gonzalo Isla Araya	1997-05-13	Chilena	+56946920940	gonzalo.isla1920@puc.cl
10001921-3	Mateo Galdames Muñoz	1977-12-17	Chilena	+56924270683	mateo.galdames1921@yahoo.com
10001922-1	Gonzalo Güler Paredes	1988-06-25	Chilena	+56987522512	gonzalo.güler1922@puc.cl
10001923-K	Toni Gómez Pérez	1999-01-23	Chilena	+56994410045	toni.gomez1923@usach.cl
10001924-8	Charles Rivera Benzema	2004-09-04	Brasileña	+56931458448	charles.rivera1924@yahoo.com
10001925-6	Santiago Cavani Güler	1994-01-12	Chilena	+56974300896	santiago.cavani1925@gmail.com
10001926-4	Jaime Dybala Contreras	2004-03-10	Chilena	+56930892894	jaime.dybala1926@outlook.com
10001927-2	Martín Álvarez Mbappe	1990-12-27	Chilena	+56966931106	martin.alvarez1927@usach.cl
10001928-0	Manuel Suárez Riquelme	1995-01-02	Chilena	+56928873187	manuel.suarez1928@hotmail.com
10001929-9	Luis Kane Gutiérrez	1970-10-03	Chilena	+56929987313	luis.kane1929@outlook.com
10001930-2	Facundo López Suárez	1995-06-11	Alemana	+56933525749	facundo.lopez1930@gmail.com
10001931-0	Alexis Vinicius Suárez	1984-02-01	Portuguesa	+56958984393	alexis.vinicius1931@yahoo.com
10001932-9	Jorge Castillo López	1982-10-16	Argentina	+56911435844	jorge.castillo1932@hotmail.com
10001933-7	Gastón Pulgar Alvarez	1985-01-24	Chilena	+56914418728	gaston.pulgar1933@gmail.com
10001934-5	Alejandro Espinoza Benzema	1975-09-11	Chilena	+56951794673	alejandro.espinoza1934@usach.cl
10001935-3	Jean Ramos Dybala	1980-11-28	Chilena	+56953257648	jean.ramos1935@hotmail.com
10001936-1	Angel Figueroa Muñoz	1995-04-24	Chilena	+56929045580	angel.figueroa1936@gmail.com
10001937-K	Gavi Cavani Jara	1983-07-28	Chilena	+56975431488	gavi.cavani1937@puc.cl
10001938-8	Ángel Neuer Valdivia	1992-12-26	Chilena	+56969993392	angel.neuer1938@usach.cl
10001939-6	Kylian De Bruyne Castillo	1970-01-14	Portuguesa	+56988824787	kylian.de bruyne1939@yahoo.com
10001940-K	Zinedine Riquelme Castro	1995-01-05	Chilena	+56955569794	zinedine.riquelme1940@hotmail.com
10001941-8	Karim Gómez Bravo	2005-11-02	Chilena	+56937979717	karim.gomez1941@hotmail.com
10001942-6	Alexis Riquelme Salah	1988-10-30	Chilena	+56935065717	alexis.riquelme1942@puc.cl
10001943-4	Pedri Arias Zidane	1984-10-21	Chilena	+56983435224	pedri.arias1943@yahoo.com
10001944-2	Esteban Galdames Contreras	1993-09-26	Chilena	+56936479811	esteban.galdames1944@hotmail.com
10001945-0	Cristopher Kroos Yamal	2005-05-11	Chilena	+56920624524	cristopher.kroos1945@gmail.com
10001946-9	Daniel Caszely Bustos	1972-11-17	Chilena	+56953329005	daniel.caszely1946@yahoo.com
10001947-7	Lionel Modric Benzema	1989-06-14	Alemana	+56920803351	lionel.modric1947@gmail.com
10001948-5	Gustavo Güler Messi	1994-07-12	Chilena	+56972860830	gustavo.güler1948@yahoo.com
10001949-3	Ezequiel Jara González	2005-12-23	Francesa	+56977881127	ezequiel.jara1949@gmail.com
10001950-7	Luciano Díaz Figueroa	1975-03-25	Chilena	+56910828604	luciano.diaz1950@puc.cl
10001951-5	Eduardo Mbappe Aránguiz	1994-12-25	Chilena	+56968559414	eduardo.mbappe1951@outlook.com
10001952-3	Neymar Haaland Díaz	1992-06-27	Chilena	+56986626170	neymar.haaland1952@gmail.com
10001953-1	Javier Hernández González	1984-11-12	Chilena	+56918397494	javier.hernandez1953@uca.cl
10001954-K	Alejandro Dybala Flores	1989-03-02	Chilena	+56912019262	alejandro.dybala1954@gmail.com
10001955-8	Hernán Fernández Bellingham	1979-09-26	Chilena	+56965668741	hernan.fernandez1955@gmail.com
10001956-6	Oscar Riquelme Paredes	1971-06-06	Portuguesa	+56913124491	oscar.riquelme1956@yahoo.com
10001957-4	Ignacio Ramos Benzema	1994-01-08	Chilena	+56918619363	ignacio.ramos1957@hotmail.com
10001958-2	Erling Rodríguez Griezmann	1996-10-06	Chilena	+56930156175	erling.rodriguez1958@outlook.com
10001959-0	Arturo Reyes Torres	1971-04-21	Chilena	+56935032604	arturo.reyes1959@uca.cl
10001960-4	Lucas Pizarro Araya	1980-09-24	Chilena	+56921755569	lucas.pizarro1960@uca.cl
10001961-2	Manuel Pizarro Vidal	2000-06-03	Chilena	+56951041744	manuel.pizarro1961@puc.cl
10001962-0	Mauricio Pulgar Martínez	1992-12-04	Chilena	+56998010148	mauricio.pulgar1962@hotmail.com
10001963-9	Zinedine Jara Caszely	1972-08-28	Chilena	+56941528904	zinedine.jara1963@yahoo.com
10001964-7	Gary Mbappe Müller	1983-09-27	Chilena	+56965616655	gary.mbappe1964@puc.cl
10001965-5	Ronaldo Cavani Lewandowski	1988-05-30	Chilena	+56969555364	ronaldo.cavani1965@yahoo.com
10001966-3	José Lukaku Bellingham	1987-12-01	Argentina	+56928846711	jose.lukaku1966@usach.cl
10001967-1	Mauricio Lukaku Suazo	1982-12-14	Chilena	+56991047914	mauricio.lukaku1967@gmail.com
10001968-K	Álvaro Álvarez Vinicius	1984-01-26	Peruana	+56996701060	alvaro.alvarez1968@yahoo.com
10001969-8	Antoine Medel Valverde	1977-05-24	Chilena	+56953131118	antoine.medel1969@gmail.com
10001970-1	Sebastián Vargas Lewandowski	1998-03-25	Española	+56997208865	sebastian.vargas1970@gmail.com
10001971-K	Antoine Gutiérrez Carrasco	2002-03-05	Peruana	+56925773779	antoine.gutierrez1971@outlook.com
10001972-8	Toni Cavani Suazo	1978-03-15	Chilena	+56966402049	toni.cavani1972@hotmail.com
10001973-6	Thiago Flores Pulgar	1993-12-07	Chilena	+56928830141	thiago.flores1973@puc.cl
10001974-4	Carlos Aránguiz Kane	1983-09-14	Chilena	+56976374600	carlos.aranguiz1974@puc.cl
10001975-2	Angel Kane Mendoza	1997-03-07	Chilena	+56986218576	angel.kane1975@usach.cl
10001976-0	Lionel Griezmann Ronaldo	2002-12-29	Chilena	+56975839577	lionel.griezmann1976@hotmail.com
10001977-9	Arturo Alvarez Kroos	1988-12-27	Chilena	+56966845127	arturo.alvarez1977@puc.cl
10001978-7	Álvaro Neuer Fernández	1992-04-02	Chilena	+56989050575	alvaro.neuer1978@outlook.com
10001979-5	Santiago Contreras Salas	1981-06-11	Chilena	+56962186444	santiago.contreras1979@yahoo.com
10001980-9	Luciano Vidal Dybala	1994-03-18	Chilena	+56986823682	luciano.vidal1980@puc.cl
10001981-7	Thomas Tapia Figueroa	2002-12-13	Italiana	+56952350442	thomas.tapia1981@hotmail.com
10001982-5	Robert Valverde Mendoza	1990-08-27	Colombiana	+56995155184	robert.valverde1982@yahoo.com
10001983-3	Joaquín Tapia Cavani	1974-07-08	Chilena	+56971480277	joaquin.tapia1983@usach.cl
10001984-1	Bautista Cavani Hernández	2000-10-17	Española	+56929078271	bautista.cavani1984@hotmail.com
10001985-K	Tomás Bravo Salah	1998-11-01	Chilena	+56935704663	tomas.bravo1985@hotmail.com
10001986-8	Enzo Dybala Mbappe	1975-10-31	Chilena	+56917633315	enzo.dybala1986@yahoo.com
10001987-6	Neymar Reyes Torres	2002-09-22	Chilena	+56962885381	neymar.reyes1987@gmail.com
10001988-4	Sergio Flores Valenzuela	1998-08-23	Chilena	+56960624983	sergio.flores1988@uca.cl
10001989-2	Rodrigo Medel Kroos	1992-11-20	Inglesa	+56943921459	rodrigo.medel1989@outlook.com
10001990-6	Maximiliano Herrera Güler	1999-11-02	Chilena	+56939742551	maximiliano.herrera1990@outlook.com
10001991-4	Erling Herrera Vergara	1982-09-05	Chilena	+56916836683	erling.herrera1991@uca.cl
10001992-2	Mauricio Vergara Dybala	1970-05-26	Chilena	+56934774016	mauricio.vergara1992@usach.cl
10001993-0	Claudio Gómez Beausejour	1995-09-29	Chilena	+56930585723	claudio.gomez1993@outlook.com
10001994-9	Marcelo Di María Hernández	1974-07-12	Chilena	+56924052825	marcelo.di maria1994@hotmail.com
10001995-7	Oscar Mbappe Espinoza	2004-03-13	Chilena	+56964201939	oscar.mbappe1995@puc.cl
10001996-5	Luis Castillo Ramos	1987-02-09	Chilena	+56988848645	luis.castillo1996@yahoo.com
10001997-3	Angel Maradona Lewandowski	1985-02-12	Brasileña	+56936390302	angel.maradona1997@outlook.com
10001998-1	Álvaro Herrera Bellingham	1993-09-25	Chilena	+56979345936	alvaro.herrera1998@puc.cl
10001999-K	Ezequiel Nuñez Contreras	1980-09-28	Chilena	+56924692878	ezequiel.nunez1999@outlook.com
10002000-9	Mohamed Flores Sepúlveda	1990-10-24	Chilena	+56933761082	mohamed.flores2000@usach.cl
\.


--
-- TOC entry 3966 (class 0 OID 27816)
-- Dependencies: 223
-- Data for Name: plantel_jugador; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.plantel_jugador (rut_pasaporte, id_equipo, id_campeonato, sueldo, posicion, habilitado, partidos_castigados) FROM stdin;
10000063-6	1	326	11750000.00	central	t	0
10000068-7	1	326	5550000.00	arquero	t	0
10000102-0	1	326	12200000.00	delantero	t	0
10000105-5	1	326	8350000.00	delantero	t	0
10000143-8	1	326	15150000.00	defensa	t	0
10000148-9	1	326	6700000.00	central	t	0
10000252-3	1	326	8100000.00	central	t	0
10000382-1	1	326	10000000.00	central	t	0
10000392-9	1	326	13200000.00	delantero	t	0
10000421-6	1	326	3050000.00	defensa	t	0
10000434-8	1	326	14500000.00	delantero	t	0
10000462-3	1	326	15550000.00	delantero	t	0
10000465-8	1	326	14750000.00	central	t	0
10000493-3	1	326	11800000.00	defensa	t	0
10000518-2	1	326	15550000.00	defensa	f	2
10000553-0	1	326	8200000.00	central	t	0
10000609-K	1	326	14150000.00	central	t	0
10000623-5	1	326	9500000.00	defensa	t	0
10000794-0	1	326	4900000.00	delantero	t	0
10000919-6	1	326	2850000.00	central	t	0
10000924-2	1	326	6800000.00	defensa	t	0
10000930-7	1	326	2400000.00	defensa	t	0
10000970-6	1	326	14350000.00	arquero	t	0
10000994-3	1	326	12700000.00	delantero	t	0
10000998-6	1	326	7550000.00	defensa	t	0
10000032-6	2	322	11100000.00	central	t	0
10000100-4	2	322	2900000.00	arquero	t	0
10000117-9	2	322	6250000.00	defensa	t	0
10000157-8	2	322	6300000.00	central	t	0
10000193-4	2	322	4300000.00	arquero	t	0
10000232-9	2	322	3300000.00	defensa	t	0
10000335-K	2	322	3200000.00	central	t	0
10000391-0	2	322	13450000.00	defensa	t	0
10000441-0	2	322	4150000.00	defensa	f	2
10000472-0	2	322	15150000.00	defensa	t	0
10000497-6	2	322	7000000.00	central	t	0
10000550-6	2	322	6850000.00	defensa	t	0
10000564-6	2	322	9450000.00	defensa	t	0
10000594-8	2	322	4950000.00	arquero	t	0
10000614-6	2	322	14300000.00	central	t	0
10000689-8	2	322	7550000.00	defensa	t	0
10000705-3	2	322	6300000.00	central	t	0
10000709-6	2	322	11550000.00	defensa	t	0
10000744-4	2	322	8800000.00	delantero	t	0
10000826-2	2	322	3650000.00	delantero	t	0
10000866-1	2	322	2850000.00	delantero	t	0
10000874-2	2	322	15400000.00	delantero	t	0
10000891-2	2	322	8700000.00	central	t	0
10000936-6	2	322	2900000.00	central	t	0
10000979-K	2	322	13950000.00	delantero	t	0
10000011-3	3	323	15200000.00	defensa	t	0
10000018-0	3	323	4250000.00	delantero	t	0
10000057-1	3	323	4950000.00	delantero	t	0
10000107-1	3	323	12200000.00	defensa	t	0
10000115-2	3	323	6300000.00	delantero	t	0
10000219-1	3	323	10250000.00	central	t	0
10000245-0	3	323	6450000.00	arquero	t	0
10000354-6	3	323	14900000.00	defensa	t	0
10000385-6	3	323	6200000.00	central	t	0
10000406-2	3	323	8200000.00	central	t	0
10000569-7	3	323	5800000.00	defensa	t	0
10000579-4	3	323	5300000.00	central	t	0
10000585-9	3	323	7100000.00	defensa	t	0
10000593-K	3	323	8050000.00	delantero	t	0
10000633-2	3	323	14100000.00	defensa	t	0
10000698-7	3	323	13950000.00	arquero	f	1
10000729-0	3	323	9100000.00	delantero	t	0
10000824-6	3	323	6350000.00	central	t	0
10000843-2	3	323	14650000.00	delantero	t	0
10000873-4	3	323	6550000.00	central	t	0
10000899-8	3	323	10600000.00	central	t	0
10000912-9	3	323	2450000.00	central	t	0
10000946-3	3	323	10800000.00	delantero	t	0
10000956-0	3	323	13250000.00	defensa	t	0
10000969-2	3	323	3900000.00	defensa	t	0
10000004-0	4	321	13350000.00	central	f	1
10000085-7	4	321	2500000.00	central	t	0
10000140-3	4	321	14850000.00	defensa	t	0
10000163-2	4	321	4850000.00	delantero	t	0
10000209-4	4	321	8450000.00	defensa	t	0
10000269-8	4	321	4450000.00	delantero	t	0
10000312-0	4	321	9950000.00	defensa	t	0
10000315-5	4	321	5250000.00	defensa	t	0
10000374-0	4	321	9550000.00	defensa	t	0
10000429-1	4	321	13350000.00	central	t	0
10000442-9	4	321	5750000.00	delantero	t	0
10000453-4	4	321	14050000.00	defensa	t	0
10000459-3	4	321	4450000.00	defensa	t	0
10000505-0	4	321	6450000.00	central	t	0
10000512-3	4	321	2100000.00	arquero	t	0
10000516-6	4	321	3700000.00	central	t	0
10000548-4	4	321	15500000.00	defensa	t	0
10000580-8	4	321	5850000.00	delantero	t	0
10000607-3	4	321	8200000.00	delantero	t	0
10000640-5	4	321	11750000.00	central	t	0
10000740-1	4	321	13700000.00	central	t	0
10000831-9	4	321	2100000.00	delantero	t	0
10000883-1	4	321	6050000.00	defensa	t	0
10000895-5	4	321	14200000.00	delantero	t	0
10000896-3	4	321	12400000.00	arquero	t	0
10000013-K	5	322	7300000.00	defensa	t	0
10000019-9	5	322	13550000.00	defensa	t	0
10000042-3	5	322	8200000.00	central	t	0
10000090-3	5	322	11850000.00	defensa	t	0
10000251-5	5	322	9650000.00	defensa	t	0
10000344-9	5	322	5250000.00	defensa	t	0
10000389-9	5	322	9750000.00	defensa	t	0
10000420-8	5	322	5200000.00	defensa	t	0
10000439-9	5	322	13350000.00	central	t	0
10000480-1	5	322	7850000.00	defensa	t	0
10000611-1	5	322	7000000.00	delantero	t	0
10000658-8	5	322	15700000.00	central	f	2
10000659-6	5	322	9700000.00	central	t	0
10000676-6	5	322	15750000.00	delantero	t	0
10000736-3	5	322	11650000.00	central	t	0
10000745-2	5	322	15000000.00	central	t	0
10000765-7	5	322	2950000.00	delantero	t	0
10000788-6	5	322	4550000.00	defensa	t	0
10000800-9	5	322	15850000.00	arquero	t	0
10000812-2	5	322	6450000.00	delantero	t	0
10000815-7	5	322	10550000.00	delantero	t	0
10000878-5	5	322	8700000.00	arquero	t	0
10000907-2	5	322	6300000.00	delantero	t	0
10000923-4	5	322	10850000.00	arquero	t	0
10000968-4	5	322	13000000.00	central	t	0
10000009-1	6	325	7550000.00	central	t	0
10000029-6	6	325	11650000.00	central	t	0
10000037-7	6	325	13700000.00	delantero	t	0
10000040-7	6	325	10850000.00	arquero	t	0
10000118-7	6	325	13100000.00	defensa	t	0
10000250-7	6	325	14100000.00	defensa	t	0
10000257-4	6	325	2750000.00	central	t	0
10000259-0	6	325	6000000.00	delantero	t	0
10000346-5	6	325	14550000.00	defensa	f	2
10000364-3	6	325	6450000.00	arquero	t	0
10000390-2	6	325	11100000.00	arquero	t	0
10000411-9	6	325	6850000.00	central	t	0
10000446-1	6	325	2700000.00	delantero	t	0
10000529-8	6	325	15200000.00	delantero	t	0
10000655-3	6	325	8000000.00	defensa	t	0
10000694-4	6	325	15100000.00	defensa	t	0
10000714-2	6	325	11550000.00	delantero	t	0
10000715-0	6	325	4950000.00	defensa	t	0
10000737-1	6	325	4550000.00	central	t	0
10000742-8	6	325	15950000.00	central	t	0
10000778-9	6	325	4700000.00	central	t	0
10000790-8	6	325	4150000.00	defensa	t	0
10000830-0	6	325	7500000.00	delantero	t	0
10000850-5	6	325	5150000.00	central	t	0
10000857-2	6	325	12150000.00	defensa	t	0
10000110-1	7	320	12950000.00	delantero	t	0
10000119-5	7	320	15950000.00	defensa	t	0
10000198-5	7	320	2500000.00	delantero	f	2
10000255-8	7	320	15400000.00	defensa	t	0
10000279-5	7	320	8500000.00	central	t	0
10000286-8	7	320	4500000.00	central	t	0
10000290-6	7	320	10950000.00	defensa	t	0
10000343-0	7	320	12800000.00	delantero	t	0
10000397-K	7	320	3200000.00	central	t	0
10000401-1	7	320	3600000.00	central	t	0
10000410-0	7	320	10950000.00	defensa	t	0
10000451-8	7	320	3750000.00	central	t	0
10000490-9	7	320	6600000.00	central	t	0
10000513-1	7	320	8350000.00	arquero	t	0
10000549-2	7	320	3550000.00	delantero	t	0
10000554-9	7	320	12400000.00	central	t	0
10000653-7	7	320	4750000.00	arquero	t	0
10000656-1	7	320	13300000.00	delantero	t	0
10000723-1	7	320	13450000.00	defensa	t	0
10000759-2	7	320	4300000.00	central	t	0
10000810-6	7	320	12850000.00	defensa	t	0
10000840-8	7	320	5350000.00	delantero	t	0
10000884-K	7	320	14150000.00	defensa	t	0
10000935-8	7	320	12800000.00	defensa	t	0
10000987-0	7	320	14700000.00	arquero	t	0
10000077-6	8	321	12850000.00	central	t	0
10000131-4	8	321	11500000.00	defensa	t	0
10000144-6	8	321	13300000.00	delantero	t	0
10000197-7	8	321	13800000.00	defensa	t	0
10000223-K	8	321	12350000.00	defensa	t	0
10000226-4	8	321	4800000.00	defensa	t	0
10000231-0	8	321	8300000.00	delantero	t	0
10000355-4	8	321	9900000.00	delantero	t	0
10000358-9	8	321	12550000.00	central	t	0
10000371-6	8	321	8650000.00	arquero	t	0
10000377-5	8	321	11600000.00	defensa	t	0
10000402-K	8	321	7300000.00	delantero	t	0
10000471-2	8	321	10600000.00	delantero	t	0
10000541-7	8	321	5100000.00	delantero	t	0
10000630-8	8	321	10600000.00	delantero	f	2
10000673-1	8	321	9400000.00	arquero	t	0
10000708-8	8	321	11150000.00	central	t	0
10000711-8	8	321	8750000.00	defensa	t	0
10000725-8	8	321	13750000.00	defensa	t	0
10000727-4	8	321	4700000.00	central	t	0
10000753-3	8	321	2000000.00	defensa	t	0
10000856-4	8	321	7050000.00	central	t	0
10000916-1	8	321	6150000.00	central	t	0
10000922-6	8	321	15200000.00	central	t	0
10000934-K	8	321	9950000.00	central	t	0
10000014-8	9	325	7850000.00	central	t	0
10000078-4	9	325	11350000.00	central	t	0
10000094-6	9	325	7850000.00	delantero	t	0
10000103-9	9	325	15800000.00	defensa	t	0
10000149-7	9	325	6500000.00	central	t	0
10000185-3	9	325	7250000.00	arquero	t	0
10000186-1	9	325	7550000.00	defensa	t	0
10000247-7	9	325	4600000.00	defensa	t	0
10000319-8	9	325	9400000.00	delantero	t	0
10000347-3	9	325	8550000.00	defensa	t	0
10000475-5	9	325	15700000.00	central	t	0
10000539-5	9	325	13650000.00	central	t	0
10000544-1	9	325	3950000.00	arquero	t	0
10000666-9	9	325	3450000.00	defensa	t	0
10000712-6	9	325	11900000.00	defensa	t	0
10000771-1	9	325	12700000.00	defensa	t	0
10000774-6	9	325	3800000.00	arquero	t	0
10000801-7	9	325	15200000.00	defensa	t	0
10000820-3	9	325	2050000.00	defensa	t	0
10000855-6	9	325	4950000.00	central	t	0
10000868-8	9	325	3250000.00	delantero	t	0
10000890-4	9	325	3350000.00	central	t	0
10000894-7	9	325	4750000.00	central	t	0
10000960-9	9	325	5200000.00	delantero	t	0
10000997-8	9	325	3700000.00	delantero	f	1
10000048-2	10	319	11350000.00	delantero	t	0
10000121-7	10	319	6900000.00	arquero	t	0
10000132-2	10	319	12000000.00	central	t	0
10000141-1	10	319	2250000.00	defensa	t	0
10000156-K	10	319	5850000.00	delantero	t	0
10000215-9	10	319	5250000.00	central	t	0
10000233-7	10	319	5750000.00	delantero	t	0
10000240-K	10	319	6050000.00	defensa	t	0
10000242-6	10	319	11850000.00	central	t	0
10000293-0	10	319	10200000.00	defensa	t	0
10000296-5	10	319	2750000.00	delantero	t	0
10000331-7	10	319	13800000.00	delantero	t	0
10000333-3	10	319	6900000.00	defensa	t	0
10000388-0	10	319	4400000.00	defensa	t	0
10000405-4	10	319	3950000.00	central	f	2
10000419-4	10	319	9350000.00	delantero	t	0
10000499-2	10	319	7250000.00	defensa	t	0
10000545-K	10	319	13000000.00	defensa	t	0
10000547-6	10	319	3900000.00	central	t	0
10000555-7	10	319	4600000.00	delantero	t	0
10000565-4	10	319	8900000.00	arquero	t	0
10000599-9	10	319	13900000.00	defensa	t	0
10000692-8	10	319	2000000.00	central	t	0
10000777-0	10	319	15400000.00	central	t	0
10000973-0	10	319	9550000.00	defensa	t	0
10000008-3	11	320	14100000.00	central	t	0
10000041-5	11	320	4600000.00	delantero	t	0
10000056-3	11	320	3650000.00	arquero	t	0
10000070-9	11	320	11200000.00	delantero	t	0
10000214-0	11	320	9300000.00	defensa	t	0
10000292-2	11	320	13600000.00	delantero	t	0
10000301-5	11	320	2850000.00	delantero	t	0
10000306-6	11	320	9800000.00	central	t	0
10000308-2	11	320	6850000.00	defensa	t	0
10000348-1	11	320	8850000.00	delantero	t	0
10000403-8	11	320	14100000.00	defensa	t	0
10000415-1	11	320	10800000.00	central	t	0
10000424-0	11	320	8600000.00	defensa	t	0
10000430-5	11	320	5450000.00	central	t	0
10000438-0	11	320	5150000.00	arquero	t	0
10000443-7	11	320	3250000.00	delantero	t	0
10000450-K	11	320	15650000.00	delantero	t	0
10000489-5	11	320	12050000.00	defensa	t	0
10000534-4	11	320	9850000.00	defensa	t	0
10000605-7	11	320	6550000.00	central	t	0
10000644-8	11	320	6800000.00	arquero	t	0
10000671-5	11	320	5850000.00	defensa	t	0
10000795-9	11	320	7300000.00	central	t	0
10000818-1	11	320	12600000.00	defensa	t	0
10000886-6	11	320	7750000.00	central	f	2
10000007-5	12	320	3550000.00	central	t	0
10000031-8	12	320	3300000.00	delantero	t	0
10000067-9	12	320	15400000.00	arquero	t	0
10000108-K	12	320	14100000.00	defensa	t	0
10000172-1	12	320	8500000.00	central	t	0
10000174-8	12	320	10750000.00	defensa	t	0
10000181-0	12	320	14050000.00	arquero	t	0
10000213-2	12	320	15850000.00	defensa	t	0
10000218-3	12	320	5700000.00	delantero	t	0
10000244-2	12	320	7150000.00	defensa	t	0
10000248-5	12	320	11250000.00	defensa	t	0
10000287-6	12	320	12300000.00	central	t	0
10000309-0	12	320	13900000.00	central	t	0
10000341-4	12	320	14500000.00	central	t	0
10000372-4	12	320	14600000.00	delantero	t	0
10000413-5	12	320	12300000.00	defensa	t	0
10000484-4	12	320	12950000.00	central	t	0
10000620-0	12	320	3000000.00	arquero	t	0
10000660-K	12	320	4050000.00	defensa	t	0
10000719-3	12	320	7600000.00	central	t	0
10000739-8	12	320	2500000.00	delantero	f	2
10000750-9	12	320	3050000.00	delantero	t	0
10000757-6	12	320	11150000.00	defensa	t	0
10000827-0	12	320	15750000.00	central	t	0
10000941-2	12	320	10800000.00	defensa	t	0
10000049-0	13	320	9300000.00	central	t	0
10000064-4	13	320	10100000.00	arquero	t	0
10000074-1	13	320	10450000.00	central	t	0
10000137-3	13	320	7600000.00	defensa	t	0
10000151-9	13	320	14500000.00	central	t	0
10000173-K	13	320	12800000.00	defensa	t	0
10000282-5	13	320	4250000.00	defensa	t	0
10000320-1	13	320	8700000.00	central	t	0
10000329-5	13	320	8850000.00	defensa	t	0
10000338-4	13	320	13150000.00	central	t	0
10000367-8	13	320	4250000.00	delantero	t	0
10000483-6	13	320	13050000.00	defensa	f	1
10000492-5	13	320	13000000.00	delantero	t	0
10000509-3	13	320	7500000.00	delantero	t	0
10000521-2	13	320	6500000.00	defensa	t	0
10000635-9	13	320	8100000.00	arquero	t	0
10000648-0	13	320	11400000.00	defensa	t	0
10000674-K	13	320	15900000.00	central	t	0
10000730-4	13	320	6750000.00	delantero	t	0
10000780-0	13	320	9850000.00	delantero	t	0
10000789-4	13	320	4000000.00	delantero	t	0
10000809-2	13	320	13750000.00	central	t	0
10000841-6	13	320	11600000.00	arquero	t	0
10000915-3	13	320	6950000.00	defensa	t	0
10000996-K	13	320	12150000.00	central	t	0
10000080-6	14	322	9250000.00	central	t	0
10000091-1	14	322	12150000.00	delantero	t	0
10000138-1	14	322	10100000.00	defensa	t	0
10000169-1	14	322	10300000.00	defensa	t	0
10000170-5	14	322	12300000.00	central	t	0
10000180-2	14	322	13750000.00	defensa	t	0
10000207-8	14	322	6550000.00	arquero	t	0
10000227-2	14	322	2300000.00	central	t	0
10000238-8	14	322	5250000.00	defensa	f	2
10000253-1	14	322	12000000.00	defensa	t	0
10000291-4	14	322	8900000.00	arquero	t	0
10000303-1	14	322	14300000.00	central	t	0
10000337-6	14	322	4350000.00	defensa	t	0
10000381-3	14	322	9000000.00	central	t	0
10000477-1	14	322	15250000.00	central	t	0
10000486-0	14	322	9100000.00	central	t	0
10000581-6	14	322	8300000.00	defensa	t	0
10000619-7	14	322	8750000.00	delantero	t	0
10000624-3	14	322	6350000.00	defensa	t	0
10000645-6	14	322	3900000.00	delantero	t	0
10000760-6	14	322	5300000.00	defensa	t	0
10000784-3	14	322	2200000.00	delantero	t	0
10000858-0	14	322	8800000.00	delantero	t	0
10000931-5	14	322	7750000.00	central	t	0
10000988-9	14	322	11450000.00	arquero	t	0
10000036-9	15	319	4650000.00	central	t	0
10000043-1	15	319	9800000.00	defensa	t	0
10000045-8	15	319	3950000.00	defensa	t	0
10000127-6	15	319	2100000.00	delantero	t	0
10000177-2	15	319	12250000.00	delantero	t	0
10000256-6	15	319	15050000.00	arquero	t	0
10000260-4	15	319	2900000.00	delantero	f	2
10000285-K	15	319	2700000.00	central	t	0
10000350-3	15	319	4100000.00	central	t	0
10000454-2	15	319	15500000.00	defensa	t	0
10000501-8	15	319	12750000.00	defensa	t	0
10000506-9	15	319	8150000.00	delantero	t	0
10000542-5	15	319	11100000.00	delantero	t	0
10000566-2	15	319	14850000.00	central	t	0
10000567-0	15	319	13450000.00	central	t	0
10000627-8	15	319	8250000.00	delantero	t	0
10000643-K	15	319	7100000.00	defensa	t	0
10000646-4	15	319	15400000.00	delantero	t	0
10000670-7	15	319	4050000.00	delantero	t	0
10000677-4	15	319	4450000.00	defensa	t	0
10000679-0	15	319	2950000.00	arquero	t	0
10000763-0	15	319	14200000.00	defensa	t	0
10000793-2	15	319	12200000.00	central	t	0
10000939-0	15	319	8100000.00	central	t	0
10000981-1	15	319	6750000.00	defensa	t	0
10000002-4	16	319	9450000.00	delantero	t	0
10000033-4	16	319	5450000.00	defensa	t	0
10000038-5	16	319	7200000.00	defensa	t	0
10000055-5	16	319	14550000.00	central	t	0
10000061-K	16	319	13500000.00	delantero	t	0
10000111-K	16	319	5100000.00	central	t	0
10000128-4	16	319	5250000.00	delantero	t	0
10000168-3	16	319	7000000.00	delantero	t	0
10000189-6	16	319	5050000.00	central	t	0
10000196-9	16	319	6300000.00	defensa	t	0
10000307-4	16	319	4550000.00	central	t	0
10000395-3	16	319	2500000.00	central	t	0
10000423-2	16	319	14100000.00	defensa	t	0
10000495-K	16	319	6850000.00	defensa	t	0
10000647-2	16	319	3700000.00	delantero	t	0
10000682-0	16	319	14450000.00	arquero	t	0
10000683-9	16	319	14500000.00	arquero	t	0
10000701-0	16	319	15100000.00	central	t	0
10000756-8	16	319	11400000.00	defensa	t	0
10000768-1	16	319	14750000.00	delantero	f	1
10000779-7	16	319	4700000.00	defensa	t	0
10000811-4	16	319	12700000.00	arquero	t	0
10000875-0	16	319	3550000.00	central	t	0
10000903-K	16	319	10650000.00	defensa	t	0
10000925-0	16	319	15000000.00	delantero	t	0
10000005-9	17	319	2600000.00	defensa	t	0
10000075-K	17	319	15200000.00	central	t	0
10000088-1	17	319	9900000.00	defensa	f	1
10000162-4	17	319	2600000.00	defensa	t	0
10000217-5	17	319	6150000.00	arquero	t	0
10000277-9	17	319	6350000.00	central	t	0
10000332-5	17	319	7700000.00	central	t	0
10000342-2	17	319	8750000.00	defensa	t	0
10000370-8	17	319	5400000.00	delantero	t	0
10000396-1	17	319	9500000.00	defensa	t	0
10000398-8	17	319	2650000.00	delantero	t	0
10000455-0	17	319	6100000.00	central	t	0
10000457-7	17	319	15500000.00	central	t	0
10000522-0	17	319	12400000.00	arquero	t	0
10000596-4	17	319	5850000.00	central	t	0
10000608-1	17	319	2350000.00	delantero	t	0
10000610-3	17	319	7700000.00	delantero	t	0
10000650-2	17	319	11600000.00	defensa	t	0
10000668-5	17	319	5450000.00	central	t	0
10000669-3	17	319	5950000.00	defensa	t	0
10000724-K	17	319	6450000.00	arquero	t	0
10000847-5	17	319	12100000.00	defensa	t	0
10000885-8	17	319	13950000.00	defensa	t	0
10000902-1	17	319	12300000.00	central	t	0
10000940-4	17	319	15350000.00	delantero	t	0
10000022-9	18	324	6850000.00	defensa	t	0
10000069-5	18	324	15450000.00	delantero	t	0
10000073-3	18	324	6250000.00	defensa	t	0
10000084-9	18	324	5400000.00	delantero	t	0
10000098-9	18	324	4400000.00	defensa	t	0
10000134-9	18	324	10800000.00	central	f	2
10000147-0	18	324	13950000.00	delantero	t	0
10000171-3	18	324	13650000.00	delantero	t	0
10000183-7	18	324	5550000.00	defensa	t	0
10000199-3	18	324	14000000.00	defensa	t	0
10000278-7	18	324	12100000.00	central	t	0
10000304-K	18	324	6450000.00	defensa	t	0
10000340-6	18	324	4750000.00	arquero	t	0
10000376-7	18	324	2500000.00	central	t	0
10000383-K	18	324	13150000.00	defensa	t	0
10000500-K	18	324	6950000.00	defensa	t	0
10000508-5	18	324	3550000.00	delantero	t	0
10000535-2	18	324	11300000.00	central	t	0
10000782-7	18	324	15500000.00	arquero	t	0
10000807-6	18	324	3050000.00	central	t	0
10000821-1	18	324	15050000.00	central	t	0
10000872-6	18	324	5250000.00	delantero	t	0
10000893-9	18	324	12300000.00	defensa	t	0
10000926-9	18	324	4400000.00	delantero	t	0
10000958-7	18	324	2800000.00	central	t	0
10000023-7	19	322	12400000.00	central	t	0
10000052-0	19	322	6950000.00	defensa	t	0
10000054-7	19	322	5150000.00	delantero	t	0
10000071-7	19	322	6500000.00	defensa	t	0
10000112-8	19	322	4750000.00	defensa	t	0
10000195-0	19	322	11350000.00	central	t	0
10000261-2	19	322	6300000.00	delantero	t	0
10000274-4	19	322	11900000.00	central	t	0
10000294-9	19	322	15950000.00	defensa	t	0
10000330-9	19	322	11350000.00	central	t	0
10000379-1	19	322	2600000.00	defensa	t	0
10000507-7	19	322	3850000.00	central	t	0
10000557-3	19	322	8450000.00	arquero	t	0
10000684-7	19	322	8900000.00	arquero	f	1
10000704-5	19	322	3050000.00	central	t	0
10000726-6	19	322	2400000.00	defensa	t	0
10000751-7	19	322	2900000.00	arquero	t	0
10000783-5	19	322	5700000.00	defensa	t	0
10000851-3	19	322	3950000.00	defensa	t	0
10000853-K	19	322	10650000.00	delantero	t	0
10000887-4	19	322	7550000.00	central	t	0
10000901-3	19	322	8000000.00	delantero	t	0
10000904-8	19	322	12650000.00	central	t	0
10000933-1	19	322	4650000.00	defensa	t	0
10000953-6	19	322	10300000.00	delantero	t	0
10000020-2	20	324	7500000.00	central	t	0
10000044-K	20	324	5300000.00	defensa	t	0
10000082-2	20	324	9300000.00	defensa	f	2
10000089-K	20	324	6700000.00	defensa	t	0
10000210-8	20	324	11650000.00	delantero	t	0
10000211-6	20	324	9800000.00	delantero	t	0
10000360-0	20	324	7200000.00	central	t	0
10000375-9	20	324	7800000.00	central	t	0
10000417-8	20	324	13850000.00	central	t	0
10000458-5	20	324	9400000.00	defensa	t	0
10000487-9	20	324	12100000.00	defensa	t	0
10000537-9	20	324	15600000.00	arquero	t	0
10000622-7	20	324	6350000.00	arquero	t	0
10000688-K	20	324	11550000.00	delantero	t	0
10000690-1	20	324	5350000.00	delantero	t	0
10000758-4	20	324	15300000.00	central	t	0
10000836-K	20	324	2300000.00	defensa	t	0
10000848-3	20	324	14400000.00	delantero	t	0
10000849-1	20	324	4900000.00	delantero	t	0
10000909-9	20	324	14500000.00	central	t	0
10000927-7	20	324	3650000.00	defensa	t	0
10000945-5	20	324	11200000.00	defensa	t	0
10000971-4	20	324	3150000.00	delantero	t	0
10000991-9	20	324	15350000.00	central	t	0
10000999-4	20	324	6450000.00	delantero	t	0
10000155-1	21	324	2250000.00	defensa	t	0
10000160-8	21	324	12050000.00	delantero	t	0
10000206-K	21	324	6250000.00	central	t	0
10000228-0	21	324	12250000.00	arquero	t	0
10000236-1	21	324	7200000.00	defensa	t	0
10000243-4	21	324	3200000.00	delantero	t	0
10000249-3	21	324	9300000.00	central	t	0
10000283-3	21	324	15900000.00	delantero	t	0
10000352-K	21	324	11950000.00	defensa	t	0
10000368-6	21	324	15000000.00	delantero	t	0
10000404-6	21	324	2250000.00	delantero	t	0
10000416-K	21	324	10600000.00	defensa	t	0
10000460-7	21	324	12550000.00	central	t	0
10000573-5	21	324	7600000.00	arquero	f	1
10000588-3	21	324	13900000.00	arquero	t	0
10000641-3	21	324	9200000.00	defensa	t	0
10000713-4	21	324	4750000.00	central	t	0
10000717-7	21	324	14350000.00	delantero	t	0
10000720-7	21	324	13600000.00	central	t	0
10000775-4	21	324	12900000.00	central	t	0
10000842-4	21	324	13850000.00	defensa	t	0
10000879-3	21	324	8750000.00	defensa	t	0
10000882-3	21	324	8500000.00	central	t	0
10000948-K	21	324	11300000.00	central	t	0
10000963-3	21	324	12200000.00	defensa	t	0
10000017-2	22	323	15250000.00	delantero	t	0
10000152-7	22	323	2550000.00	delantero	t	0
10000184-5	22	323	12450000.00	defensa	t	0
10000225-6	22	323	2300000.00	arquero	t	0
10000234-5	22	323	12400000.00	central	t	0
10000262-0	22	323	2750000.00	defensa	t	0
10000272-8	22	323	2850000.00	central	t	0
10000326-0	22	323	13000000.00	delantero	f	1
10000432-1	22	323	14600000.00	defensa	t	0
10000527-1	22	323	15600000.00	defensa	t	0
10000563-8	22	323	13300000.00	central	t	0
10000597-2	22	323	14700000.00	central	t	0
10000604-9	22	323	14750000.00	delantero	t	0
10000621-9	22	323	2650000.00	delantero	t	0
10000632-4	22	323	4250000.00	defensa	t	0
10000693-6	22	323	8350000.00	delantero	t	0
10000762-2	22	323	4850000.00	defensa	t	0
10000814-9	22	323	2150000.00	defensa	t	0
10000817-3	22	323	5250000.00	central	t	0
10000845-9	22	323	15000000.00	central	t	0
10000864-5	22	323	6250000.00	central	t	0
10000918-8	22	323	8350000.00	delantero	t	0
10000942-0	22	323	10500000.00	arquero	t	0
10000943-9	22	323	6600000.00	central	t	0
10000955-2	22	323	6500000.00	defensa	t	0
10000030-K	23	319	4150000.00	defensa	t	0
10000058-K	23	319	5400000.00	defensa	t	0
10000116-0	23	319	13200000.00	arquero	t	0
10000129-2	23	319	7500000.00	central	t	0
10000130-6	23	319	13250000.00	delantero	t	0
10000167-5	23	319	12050000.00	central	t	0
10000203-5	23	319	10950000.00	delantero	t	0
10000305-8	23	319	7500000.00	delantero	t	0
10000310-4	23	319	9300000.00	delantero	t	0
10000327-9	23	319	2900000.00	defensa	t	0
10000351-1	23	319	6400000.00	central	t	0
10000363-5	23	319	4300000.00	defensa	t	0
10000387-2	23	319	7300000.00	defensa	t	0
10000394-5	23	319	4850000.00	delantero	t	0
10000427-5	23	319	7350000.00	central	t	0
10000435-6	23	319	13450000.00	defensa	f	1
10000556-5	23	319	3600000.00	defensa	t	0
10000583-2	23	319	14100000.00	central	t	0
10000649-9	23	319	13300000.00	central	t	0
10000675-8	23	319	13050000.00	delantero	t	0
10000699-5	23	319	15600000.00	defensa	t	0
10000798-3	23	319	9400000.00	defensa	t	0
10000844-0	23	319	11500000.00	central	t	0
10000972-2	23	319	6200000.00	arquero	t	0
10001000-3	23	319	9650000.00	delantero	t	0
10000025-3	24	321	6350000.00	defensa	f	2
10000039-3	24	321	2850000.00	defensa	t	0
10000060-1	24	321	10200000.00	arquero	t	0
10000221-3	24	321	10350000.00	defensa	t	0
10000289-2	24	321	9500000.00	central	t	0
10000297-3	24	321	3400000.00	delantero	t	0
10000324-4	24	321	5850000.00	central	t	0
10000359-7	24	321	10050000.00	central	t	0
10000384-8	24	321	14450000.00	delantero	t	0
10000414-3	24	321	13000000.00	delantero	t	0
10000437-2	24	321	7550000.00	defensa	t	0
10000448-8	24	321	11850000.00	central	t	0
10000467-4	24	321	12900000.00	delantero	t	0
10000474-7	24	321	9550000.00	defensa	t	0
10000575-1	24	321	3800000.00	delantero	t	0
10000591-3	24	321	2050000.00	central	t	0
10000602-2	24	321	6600000.00	central	t	0
10000617-0	24	321	8600000.00	central	t	0
10000618-9	24	321	14800000.00	defensa	t	0
10000626-K	24	321	14650000.00	central	t	0
10000667-7	24	321	12300000.00	defensa	t	0
10000703-7	24	321	14550000.00	delantero	t	0
10000747-9	24	321	6800000.00	defensa	t	0
10000861-0	24	321	4450000.00	arquero	t	0
10000928-5	24	321	14000000.00	delantero	t	0
10000016-4	25	320	3800000.00	central	t	0
10000024-5	25	320	2700000.00	defensa	t	0
10000059-8	25	320	15050000.00	central	t	0
10000065-2	25	320	3800000.00	defensa	t	0
10000126-8	25	320	12950000.00	arquero	t	0
10000166-7	25	320	10600000.00	arquero	t	0
10000190-K	25	320	14450000.00	central	t	0
10000241-8	25	320	7050000.00	delantero	t	0
10000263-9	25	320	3550000.00	central	t	0
10000264-7	25	320	12750000.00	defensa	t	0
10000268-K	25	320	4900000.00	defensa	t	0
10000284-1	25	320	3650000.00	defensa	t	0
10000299-K	25	320	8700000.00	defensa	t	0
10000318-K	25	320	3050000.00	defensa	f	2
10000323-6	25	320	9300000.00	delantero	t	0
10000628-6	25	320	11050000.00	arquero	t	0
10000631-6	25	320	13850000.00	central	t	0
10000755-K	25	320	3650000.00	defensa	t	0
10000761-4	25	320	10450000.00	central	t	0
10000806-8	25	320	11500000.00	delantero	t	0
10000813-0	25	320	9900000.00	defensa	t	0
10000911-0	25	320	11650000.00	central	t	0
10000920-K	25	320	4600000.00	central	t	0
10000957-9	25	320	11350000.00	delantero	t	0
10000980-3	25	320	2350000.00	delantero	t	0
10000062-8	26	324	10150000.00	delantero	t	0
10000104-7	26	324	5600000.00	central	t	0
10000113-6	26	324	11450000.00	delantero	t	0
10000136-5	26	324	8850000.00	central	t	0
10000176-4	26	324	12650000.00	defensa	t	0
10000222-1	26	324	11350000.00	defensa	f	2
10000271-K	26	324	9350000.00	central	t	0
10000288-4	26	324	3150000.00	delantero	t	0
10000365-1	26	324	13350000.00	arquero	t	0
10000447-K	26	324	15400000.00	defensa	t	0
10000552-2	26	324	13150000.00	central	t	0
10000576-K	26	324	10350000.00	delantero	t	0
10000577-8	26	324	8750000.00	delantero	t	0
10000582-4	26	324	8800000.00	delantero	t	0
10000584-0	26	324	2250000.00	delantero	t	0
10000652-9	26	324	6600000.00	arquero	t	0
10000697-9	26	324	10500000.00	defensa	t	0
10000748-7	26	324	4450000.00	defensa	t	0
10000791-6	26	324	11650000.00	delantero	t	0
10000808-4	26	324	10350000.00	central	t	0
10000854-8	26	324	15000000.00	central	t	0
10000876-9	26	324	13800000.00	central	t	0
10000978-1	26	324	9750000.00	defensa	t	0
10000983-8	26	324	5500000.00	defensa	t	0
10000986-2	26	324	14800000.00	defensa	t	0
10000028-8	27	323	3900000.00	delantero	t	0
10000096-2	27	323	14550000.00	defensa	t	0
10000097-0	27	323	13350000.00	central	t	0
10000123-3	27	323	12300000.00	arquero	t	0
10000161-6	27	323	7350000.00	delantero	t	0
10000182-9	27	323	8950000.00	defensa	f	1
10000187-K	27	323	13900000.00	defensa	t	0
10000220-5	27	323	13500000.00	central	t	0
10000237-K	27	323	13750000.00	delantero	t	0
10000281-7	27	323	11850000.00	defensa	t	0
10000339-2	27	323	7650000.00	defensa	t	0
10000361-9	27	323	8300000.00	arquero	t	0
10000418-6	27	323	8950000.00	central	t	0
10000426-7	27	323	3700000.00	central	t	0
10000456-9	27	323	3850000.00	central	t	0
10000466-6	27	323	2700000.00	delantero	t	0
10000479-8	27	323	15300000.00	delantero	t	0
10000532-8	27	323	2250000.00	arquero	t	0
10000540-9	27	323	15250000.00	delantero	t	0
10000733-9	27	323	9850000.00	defensa	t	0
10000772-K	27	323	4050000.00	defensa	t	0
10000781-9	27	323	9000000.00	central	t	0
10000880-7	27	323	15750000.00	defensa	t	0
10000905-6	27	323	6950000.00	defensa	t	0
10000938-2	27	323	13000000.00	central	t	0
10000021-0	28	322	15200000.00	delantero	t	0
10000081-4	28	322	6700000.00	delantero	t	0
10000142-K	28	322	11400000.00	defensa	t	0
10000165-9	28	322	6000000.00	central	t	0
10000179-9	28	322	9550000.00	defensa	t	0
10000191-8	28	322	10500000.00	central	t	0
10000192-6	28	322	6350000.00	delantero	t	0
10000224-8	28	322	13350000.00	defensa	t	0
10000270-1	28	322	12200000.00	central	t	0
10000280-9	28	322	10600000.00	central	t	0
10000313-9	28	322	5750000.00	delantero	t	0
10000353-8	28	322	3950000.00	defensa	t	0
10000393-7	28	322	2300000.00	defensa	t	0
10000425-9	28	322	14800000.00	arquero	t	0
10000476-3	28	322	11900000.00	delantero	t	0
10000530-1	28	322	13900000.00	defensa	t	0
10000543-3	28	322	15650000.00	defensa	t	0
10000546-8	28	322	8850000.00	central	t	0
10000678-2	28	322	2550000.00	central	t	0
10000731-2	28	322	9150000.00	arquero	t	0
10000743-6	28	322	3600000.00	central	t	0
10000754-1	28	322	5250000.00	central	t	0
10000816-5	28	322	16000000.00	arquero	t	0
10000860-2	28	322	15100000.00	delantero	t	0
10000892-0	28	322	14400000.00	defensa	f	2
10000047-4	29	326	15250000.00	defensa	t	0
10000050-4	29	326	6750000.00	defensa	t	0
10000072-5	29	326	7100000.00	defensa	t	0
10000178-0	29	326	13650000.00	defensa	t	0
10000194-2	29	326	6800000.00	arquero	t	0
10000201-9	29	326	14500000.00	central	t	0
10000212-4	29	326	13300000.00	central	t	0
10000239-6	29	326	9100000.00	central	f	1
10000345-7	29	326	2300000.00	defensa	t	0
10000496-8	29	326	10650000.00	arquero	t	0
10000558-1	29	326	8650000.00	central	t	0
10000606-5	29	326	5500000.00	central	t	0
10000639-1	29	326	3800000.00	delantero	t	0
10000657-K	29	326	3750000.00	delantero	t	0
10000664-2	29	326	9750000.00	delantero	t	0
10000695-2	29	326	12400000.00	central	t	0
10000752-5	29	326	6350000.00	delantero	t	0
10000767-3	29	326	7100000.00	delantero	t	0
10000799-1	29	326	12000000.00	defensa	t	0
10000829-7	29	326	13550000.00	defensa	t	0
10000832-7	29	326	4200000.00	central	t	0
10000846-7	29	326	5550000.00	defensa	t	0
10000862-9	29	326	3700000.00	defensa	t	0
10000921-8	29	326	8650000.00	delantero	t	0
10000982-K	29	326	15300000.00	arquero	t	0
10000027-K	30	319	7300000.00	delantero	t	0
10000053-9	30	319	6800000.00	central	t	0
10000076-8	30	319	12300000.00	delantero	t	0
10000109-8	30	319	14300000.00	delantero	t	0
10000158-6	30	319	15550000.00	central	t	0
10000175-6	30	319	6850000.00	defensa	t	0
10000311-2	30	319	9000000.00	delantero	t	0
10000334-1	30	319	10000000.00	central	t	0
10000336-8	30	319	10150000.00	defensa	t	0
10000356-2	30	319	13550000.00	delantero	t	0
10000362-7	30	319	14750000.00	delantero	t	0
10000399-6	30	319	12350000.00	central	t	0
10000488-7	30	319	5050000.00	defensa	t	0
10000523-9	30	319	5000000.00	defensa	t	0
10000586-7	30	319	13400000.00	central	t	0
10000634-0	30	319	5550000.00	defensa	t	0
10000662-6	30	319	15150000.00	central	t	0
10000700-2	30	319	7400000.00	defensa	t	0
10000802-5	30	319	9800000.00	arquero	f	2
10000834-3	30	319	14300000.00	defensa	t	0
10000877-7	30	319	9150000.00	defensa	t	0
10000944-7	30	319	10300000.00	central	t	0
10000949-8	30	319	3900000.00	defensa	t	0
10000966-8	30	319	4250000.00	central	t	0
10000984-6	30	319	5150000.00	arquero	t	0
10000087-3	31	323	4550000.00	delantero	t	0
10000135-7	31	323	3850000.00	central	t	0
10000139-K	31	323	6300000.00	defensa	t	0
10000153-5	31	323	7250000.00	defensa	t	0
10000164-0	31	323	15100000.00	defensa	t	0
10000202-7	31	323	6050000.00	central	t	0
10000314-7	31	323	7000000.00	arquero	t	0
10000400-3	31	323	5100000.00	central	t	0
10000428-3	31	323	15000000.00	delantero	t	0
10000485-2	31	323	15700000.00	defensa	t	0
10000517-4	31	323	10500000.00	central	t	0
10000520-4	31	323	7400000.00	delantero	t	0
10000533-6	31	323	9900000.00	delantero	t	0
10000603-0	31	323	10350000.00	central	t	0
10000613-8	31	323	9200000.00	delantero	f	2
10000707-K	31	323	3900000.00	defensa	t	0
10000738-K	31	323	14050000.00	arquero	t	0
10000773-8	31	323	4350000.00	arquero	t	0
10000805-K	31	323	9650000.00	central	t	0
10000833-5	31	323	9400000.00	delantero	t	0
10000839-4	31	323	14100000.00	defensa	t	0
10000870-K	31	323	12100000.00	defensa	t	0
10000962-5	31	323	7250000.00	delantero	t	0
10000974-9	31	323	10600000.00	defensa	t	0
10000990-0	31	323	11750000.00	central	t	0
10000001-6	32	321	8800000.00	delantero	t	0
10000006-7	32	321	10250000.00	central	t	0
10000046-6	32	321	3700000.00	central	t	0
10000086-5	32	321	13500000.00	defensa	t	0
10000124-1	32	321	11850000.00	central	t	0
10000159-4	32	321	10850000.00	arquero	t	0
10000204-3	32	321	11300000.00	central	t	0
10000254-K	32	321	10350000.00	arquero	t	0
10000275-2	32	321	2450000.00	defensa	t	0
10000321-K	32	321	12950000.00	defensa	f	1
10000463-1	32	321	7250000.00	delantero	t	0
10000504-2	32	321	15800000.00	defensa	t	0
10000560-3	32	321	6550000.00	delantero	t	0
10000589-1	32	321	12150000.00	central	t	0
10000595-6	32	321	6300000.00	defensa	t	0
10000598-0	32	321	11050000.00	central	t	0
10000625-1	32	321	10400000.00	central	t	0
10000636-7	32	321	9950000.00	delantero	t	0
10000651-0	32	321	15050000.00	delantero	t	0
10000681-2	32	321	9800000.00	delantero	t	0
10000685-5	32	321	3300000.00	defensa	t	0
10000776-2	32	321	7650000.00	defensa	t	0
10000797-5	32	321	2900000.00	delantero	t	0
10000951-K	32	321	4350000.00	arquero	t	0
10000993-5	32	321	13550000.00	defensa	t	0
10000015-6	33	322	7950000.00	defensa	t	0
10000066-0	33	322	11200000.00	delantero	t	0
10000095-4	33	322	10300000.00	defensa	t	0
10000099-7	33	322	14750000.00	defensa	t	0
10000150-0	33	322	9950000.00	delantero	t	0
10000188-8	33	322	4200000.00	defensa	t	0
10000200-0	33	322	9250000.00	central	t	0
10000266-3	33	322	3150000.00	central	t	0
10000273-6	33	322	10950000.00	central	t	0
10000380-5	33	322	8850000.00	delantero	t	0
10000422-4	33	322	8100000.00	central	t	0
10000449-6	33	322	13300000.00	delantero	t	0
10000464-K	33	322	13850000.00	delantero	t	0
10000528-K	33	322	6950000.00	arquero	t	0
10000665-0	33	322	4000000.00	defensa	f	2
10000706-1	33	322	6850000.00	central	t	0
10000746-0	33	322	6200000.00	defensa	t	0
10000766-5	33	322	8700000.00	delantero	t	0
10000804-1	33	322	12400000.00	delantero	t	0
10000859-9	33	322	6850000.00	delantero	t	0
10000914-5	33	322	15800000.00	defensa	t	0
10000932-3	33	322	4300000.00	defensa	t	0
10000964-1	33	322	10400000.00	central	t	0
10000965-K	33	322	7400000.00	central	t	0
10000989-7	33	322	9850000.00	arquero	t	0
10000034-2	34	319	12750000.00	defensa	t	0
10000035-0	34	319	13600000.00	defensa	t	0
10000154-3	34	319	7750000.00	central	t	0
10000205-1	34	319	5350000.00	delantero	t	0
10000267-1	34	319	7750000.00	central	t	0
10000298-1	34	319	8050000.00	defensa	t	0
10000325-2	34	319	10300000.00	defensa	t	0
10000369-4	34	319	12750000.00	arquero	t	0
10000445-3	34	319	6900000.00	defensa	t	0
10000470-4	34	319	6050000.00	defensa	t	0
10000478-K	34	319	6000000.00	delantero	t	0
10000498-4	34	319	13400000.00	central	t	0
10000502-6	34	319	9000000.00	delantero	t	0
10000510-7	34	319	14800000.00	defensa	t	0
10000524-7	34	319	3200000.00	central	f	2
10000572-7	34	319	14050000.00	delantero	t	0
10000612-K	34	319	14600000.00	arquero	t	0
10000672-3	34	319	9500000.00	central	t	0
10000680-4	34	319	2900000.00	central	t	0
10000710-K	34	319	13950000.00	central	t	0
10000786-K	34	319	2200000.00	defensa	t	0
10000823-8	34	319	10350000.00	central	t	0
10000828-9	34	319	2650000.00	defensa	t	0
10000910-2	34	319	9100000.00	delantero	t	0
10000937-4	34	319	14100000.00	delantero	t	0
10000010-5	35	319	2500000.00	delantero	t	0
10000208-6	35	319	15000000.00	defensa	t	0
10000276-0	35	319	11300000.00	arquero	t	0
10000302-3	35	319	15400000.00	defensa	t	0
10000316-3	35	319	4400000.00	central	t	0
10000412-7	35	319	4200000.00	defensa	t	0
10000444-5	35	319	10850000.00	central	t	0
10000468-2	35	319	5050000.00	defensa	t	0
10000481-K	35	319	11950000.00	defensa	t	0
10000514-K	35	319	6000000.00	central	t	0
10000559-K	35	319	14750000.00	defensa	t	0
10000562-K	35	319	14150000.00	delantero	f	1
10000574-3	35	319	13450000.00	arquero	t	0
10000686-3	35	319	7700000.00	defensa	t	0
10000691-K	35	319	3200000.00	delantero	t	0
10000716-9	35	319	7600000.00	delantero	t	0
10000718-5	35	319	12100000.00	arquero	t	0
10000732-0	35	319	2700000.00	central	t	0
10000819-K	35	319	13400000.00	delantero	t	0
10000852-1	35	319	4200000.00	delantero	t	0
10000867-K	35	319	15800000.00	delantero	t	0
10000900-5	35	319	15250000.00	defensa	t	0
10000908-0	35	319	6950000.00	central	t	0
10000954-4	35	319	10750000.00	central	t	0
10000995-1	35	319	2700000.00	central	t	0
10000051-2	36	325	14600000.00	delantero	t	0
10000125-K	36	325	3100000.00	defensa	t	0
10000133-0	36	325	6800000.00	delantero	t	0
10000146-2	36	325	8300000.00	defensa	t	0
10000230-2	36	325	6800000.00	central	t	0
10000235-3	36	325	13150000.00	arquero	t	0
10000440-2	36	325	10550000.00	defensa	t	0
10000482-8	36	325	13200000.00	arquero	t	0
10000491-7	36	325	2350000.00	defensa	t	0
10000494-1	36	325	16000000.00	delantero	t	0
10000531-K	36	325	12800000.00	central	f	2
10000536-0	36	325	10400000.00	delantero	t	0
10000590-5	36	325	13700000.00	defensa	t	0
10000638-3	36	325	8800000.00	central	t	0
10000642-1	36	325	11650000.00	defensa	t	0
10000687-1	36	325	4550000.00	central	t	0
10000722-3	36	325	9200000.00	defensa	t	0
10000735-5	36	325	13750000.00	arquero	t	0
10000785-1	36	325	7550000.00	central	t	0
10000838-6	36	325	14150000.00	defensa	t	0
10000871-8	36	325	6600000.00	central	t	0
10000929-3	36	325	9200000.00	central	t	0
10000947-1	36	325	6800000.00	central	t	0
10000950-1	36	325	7950000.00	delantero	t	0
10000992-7	36	325	9100000.00	defensa	t	0
10000093-8	37	323	14750000.00	central	t	0
10000120-9	37	323	10950000.00	delantero	t	0
10000265-5	37	323	4150000.00	central	t	0
10000373-2	37	323	3000000.00	central	t	0
10000408-9	37	323	7900000.00	delantero	t	0
10000409-7	37	323	9900000.00	defensa	t	0
10000433-K	37	323	5250000.00	defensa	t	0
10000436-4	37	323	11550000.00	defensa	t	0
10000473-9	37	323	12600000.00	arquero	t	0
10000511-5	37	323	12950000.00	defensa	t	0
10000519-0	37	323	6050000.00	arquero	t	0
10000538-7	37	323	13600000.00	central	t	0
10000568-9	37	323	10300000.00	central	t	0
10000578-6	37	323	13950000.00	defensa	f	2
10000600-6	37	323	4850000.00	delantero	t	0
10000615-4	37	323	10950000.00	delantero	t	0
10000769-K	37	323	6750000.00	defensa	t	0
10000822-K	37	323	14700000.00	defensa	t	0
10000865-3	37	323	7100000.00	delantero	t	0
10000888-2	37	323	4250000.00	central	t	0
10000889-0	37	323	10250000.00	arquero	t	0
10000897-1	37	323	14250000.00	central	t	0
10000959-5	37	323	12700000.00	defensa	t	0
10000961-7	37	323	13250000.00	defensa	t	0
10000985-4	37	323	8700000.00	delantero	t	0
10000026-1	38	319	9100000.00	defensa	t	0
10000079-2	38	319	16000000.00	central	t	0
10000092-K	38	319	13400000.00	central	t	0
10000145-4	38	319	5450000.00	defensa	t	0
10000300-7	38	319	2250000.00	delantero	t	0
10000317-1	38	319	2750000.00	defensa	t	0
10000349-K	38	319	4900000.00	defensa	t	0
10000378-3	38	319	15950000.00	defensa	t	0
10000386-4	38	319	12500000.00	defensa	t	0
10000469-0	38	319	9750000.00	delantero	t	0
10000526-3	38	319	14700000.00	delantero	t	0
10000551-4	38	319	3150000.00	central	t	0
10000571-9	38	319	8450000.00	delantero	t	0
10000592-1	38	319	7350000.00	delantero	t	0
10000654-5	38	319	2750000.00	delantero	t	0
10000661-8	38	319	9400000.00	arquero	f	2
10000721-5	38	319	13950000.00	central	t	0
10000728-2	38	319	4500000.00	central	t	0
10000734-7	38	319	14050000.00	defensa	t	0
10000741-K	38	319	9950000.00	delantero	t	0
10000764-9	38	319	6100000.00	central	t	0
10000825-4	38	319	10800000.00	delantero	t	0
10000869-6	38	319	15100000.00	arquero	t	0
10000898-K	38	319	6100000.00	defensa	t	0
10000967-6	38	319	11150000.00	central	t	0
10000003-2	39	324	13550000.00	arquero	t	0
10000012-1	39	324	5400000.00	defensa	t	0
10000083-0	39	324	13400000.00	central	t	0
10000101-2	39	324	6600000.00	delantero	t	0
10000114-4	39	324	4900000.00	defensa	t	0
10000216-7	39	324	10600000.00	central	t	0
10000246-9	39	324	14900000.00	defensa	t	0
10000258-2	39	324	8000000.00	defensa	t	0
10000295-7	39	324	6650000.00	defensa	t	0
10000322-8	39	324	3100000.00	defensa	t	0
10000357-0	39	324	4200000.00	arquero	t	0
10000366-K	39	324	15500000.00	delantero	t	0
10000407-0	39	324	14300000.00	delantero	t	0
10000452-6	39	324	14650000.00	defensa	t	0
10000461-5	39	324	11950000.00	defensa	t	0
10000601-4	39	324	9600000.00	central	t	0
10000629-4	39	324	2650000.00	defensa	t	0
10000696-0	39	324	8450000.00	delantero	t	0
10000702-9	39	324	4700000.00	central	t	0
10000792-4	39	324	10650000.00	delantero	t	0
10000835-1	39	324	6300000.00	central	t	0
10000837-8	39	324	9350000.00	central	t	0
10000913-7	39	324	12150000.00	delantero	t	0
10000952-8	39	324	13500000.00	delantero	f	2
10000977-3	39	324	14450000.00	central	t	0
10000106-3	40	323	9250000.00	delantero	t	0
10000122-5	40	323	11000000.00	defensa	t	0
10000229-9	40	323	10300000.00	central	t	0
10000328-7	40	323	2800000.00	delantero	t	0
10000431-3	40	323	2400000.00	delantero	t	0
10000503-4	40	323	6900000.00	central	t	0
10000515-8	40	323	2950000.00	defensa	t	0
10000525-5	40	323	11350000.00	defensa	t	0
10000561-1	40	323	13100000.00	arquero	t	0
10000570-0	40	323	8650000.00	delantero	t	0
10000587-5	40	323	6500000.00	central	t	0
10000616-2	40	323	4850000.00	central	f	1
10000637-5	40	323	14950000.00	defensa	t	0
10000663-4	40	323	13500000.00	arquero	t	0
10000749-5	40	323	15150000.00	central	t	0
10000770-3	40	323	15900000.00	central	t	0
10000787-8	40	323	10650000.00	delantero	t	0
10000796-7	40	323	11850000.00	central	t	0
10000803-3	40	323	3950000.00	defensa	t	0
10000863-7	40	323	4550000.00	central	t	0
10000881-5	40	323	15100000.00	defensa	t	0
10000906-4	40	323	6750000.00	defensa	t	0
10000917-K	40	323	8000000.00	defensa	t	0
10000975-7	40	323	7150000.00	delantero	t	0
10000976-5	40	323	14200000.00	defensa	t	0
\.


--
-- TOC entry 3982 (class 0 OID 28014)
-- Dependencies: 239
-- Data for Name: sala_tribunal; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sala_tribunal (id_sala, nombre_sala) FROM stdin;
1	primera sala
2	segunda sala
3	tercera sala
4	cuarta sala
\.


--
-- TOC entry 3985 (class 0 OID 28037)
-- Dependencies: 242
-- Data for Name: sancion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sancion (id_sancion, rut_sancionado, id_campeonato, motivo, fechas_castigo, fecha_sentencia) FROM stdin;
\.


--
-- TOC entry 3980 (class 0 OID 27995)
-- Dependencies: 237
-- Data for Name: tarjeta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tarjeta (id_tarjeta, id_partido, rut_persona, tipo_tarjeta, minuto) FROM stdin;
\.


--
-- TOC entry 4001 (class 0 OID 0)
-- Dependencies: 217
-- Name: campeonato_id_campeonato_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.campeonato_id_campeonato_seq', 327, true);


--
-- TOC entry 4002 (class 0 OID 0)
-- Dependencies: 219
-- Name: equipo_id_equipo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.equipo_id_equipo_seq', 40, true);


--
-- TOC entry 4003 (class 0 OID 0)
-- Dependencies: 226
-- Name: estadio_id_estadio_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.estadio_id_estadio_seq', 1, false);


--
-- TOC entry 4004 (class 0 OID 0)
-- Dependencies: 234
-- Name: gol_id_gol_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.gol_id_gol_seq', 1, false);


--
-- TOC entry 4005 (class 0 OID 0)
-- Dependencies: 229
-- Name: partido_id_partido_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.partido_id_partido_seq', 380, true);


--
-- TOC entry 4006 (class 0 OID 0)
-- Dependencies: 238
-- Name: sala_tribunal_id_sala_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sala_tribunal_id_sala_seq', 1, false);


--
-- TOC entry 4007 (class 0 OID 0)
-- Dependencies: 241
-- Name: sanccion_id_sancion_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sanccion_id_sancion_seq', 1, false);


--
-- TOC entry 4008 (class 0 OID 0)
-- Dependencies: 236
-- Name: tarjeta_id_tarjeta_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tarjeta_id_tarjeta_seq', 1, false);


--
-- TOC entry 3784 (class 2606 OID 28077)
-- Name: Posiciones Posiciones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Posiciones"
    ADD CONSTRAINT "Posiciones_pkey" PRIMARY KEY (idcampeonato, idequipo);


--
-- TOC entry 3746 (class 2606 OID 27784)
-- Name: campeonato campeonato_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.campeonato
    ADD CONSTRAINT campeonato_pkey PRIMARY KEY (id_campeonato);


--
-- TOC entry 3758 (class 2606 OID 27847)
-- Name: cuerpo_tecnico cuerpo_tecnico_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuerpo_tecnico
    ADD CONSTRAINT cuerpo_tecnico_pkey PRIMARY KEY (rut_pasaporte, id_equipo);


--
-- TOC entry 3772 (class 2606 OID 27965)
-- Name: designacion_arbitro designacion_arbitro_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.designacion_arbitro
    ADD CONSTRAINT designacion_arbitro_pkey PRIMARY KEY (id_partido, rut_pasaporte);


--
-- TOC entry 3760 (class 2606 OID 27863)
-- Name: dirigente dirigente_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dirigente
    ADD CONSTRAINT dirigente_pkey PRIMARY KEY (rut_pasaporte, id_equipo, fecha_inicio);


--
-- TOC entry 3752 (class 2606 OID 27800)
-- Name: equipo_campeonato equipo_campeonato_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.equipo_campeonato
    ADD CONSTRAINT equipo_campeonato_pkey PRIMARY KEY (id_equipo, id_campeonato);


--
-- TOC entry 3748 (class 2606 OID 27793)
-- Name: equipo equipo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.equipo
    ADD CONSTRAINT equipo_pkey PRIMARY KEY (id_equipo);


--
-- TOC entry 3750 (class 2606 OID 27795)
-- Name: equipo equipo_rut_equipo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.equipo
    ADD CONSTRAINT equipo_rut_equipo_key UNIQUE (rut_equipo);


--
-- TOC entry 3764 (class 2606 OID 27887)
-- Name: estadio_local estadio_local_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estadio_local
    ADD CONSTRAINT estadio_local_pkey PRIMARY KEY (id_equipo, id_estadio);


--
-- TOC entry 3762 (class 2606 OID 27882)
-- Name: estadio estadio_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estadio
    ADD CONSTRAINT estadio_pkey PRIMARY KEY (id_estadio);


--
-- TOC entry 3774 (class 2606 OID 27983)
-- Name: gol gol_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gol
    ADD CONSTRAINT gol_pkey PRIMARY KEY (id_gol);


--
-- TOC entry 3780 (class 2606 OID 28025)
-- Name: integrante_tribunal integrante_tribunal_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.integrante_tribunal
    ADD CONSTRAINT integrante_tribunal_pkey PRIMARY KEY (rut_pasaporte);


--
-- TOC entry 3770 (class 2606 OID 27949)
-- Name: participacion_partido_cuerpo_tecnico participacion_partido_cuerpo_tecnico_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.participacion_partido_cuerpo_tecnico
    ADD CONSTRAINT participacion_partido_cuerpo_tecnico_pkey PRIMARY KEY (id_partido, rut_pasaporte);


--
-- TOC entry 3768 (class 2606 OID 27934)
-- Name: participacion_partido_jugador participacion_partido_jugador_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.participacion_partido_jugador
    ADD CONSTRAINT participacion_partido_jugador_pkey PRIMARY KEY (id_partido, rut_pasaporte);


--
-- TOC entry 3766 (class 2606 OID 27908)
-- Name: partido partido_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.partido
    ADD CONSTRAINT partido_pkey PRIMARY KEY (id_partido);


--
-- TOC entry 3754 (class 2606 OID 27815)
-- Name: persona persona_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.persona
    ADD CONSTRAINT persona_pkey PRIMARY KEY (rut_pasaporte);


--
-- TOC entry 3756 (class 2606 OID 27824)
-- Name: plantel_jugador plantel_jugador_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plantel_jugador
    ADD CONSTRAINT plantel_jugador_pkey PRIMARY KEY (rut_pasaporte, id_campeonato);


--
-- TOC entry 3778 (class 2606 OID 28019)
-- Name: sala_tribunal sala_tribunal_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sala_tribunal
    ADD CONSTRAINT sala_tribunal_pkey PRIMARY KEY (id_sala);


--
-- TOC entry 3782 (class 2606 OID 28045)
-- Name: sancion sanccion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sancion
    ADD CONSTRAINT sanccion_pkey PRIMARY KEY (id_sancion);


--
-- TOC entry 3776 (class 2606 OID 28002)
-- Name: tarjeta tarjeta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tarjeta
    ADD CONSTRAINT tarjeta_pkey PRIMARY KEY (id_tarjeta);


--
-- TOC entry 3814 (class 2606 OID 28066)
-- Name: arbitro arbitro_rut_pasaporte_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.arbitro
    ADD CONSTRAINT arbitro_rut_pasaporte_fkey FOREIGN KEY (rut_pasaporte) REFERENCES public.persona(rut_pasaporte) ON DELETE CASCADE;


--
-- TOC entry 3790 (class 2606 OID 27853)
-- Name: cuerpo_tecnico cuerpo_tecnico_id_equipo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuerpo_tecnico
    ADD CONSTRAINT cuerpo_tecnico_id_equipo_fkey FOREIGN KEY (id_equipo) REFERENCES public.equipo(id_equipo) ON DELETE CASCADE;


--
-- TOC entry 3791 (class 2606 OID 27848)
-- Name: cuerpo_tecnico cuerpo_tecnico_rut_pasaporte_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuerpo_tecnico
    ADD CONSTRAINT cuerpo_tecnico_rut_pasaporte_fkey FOREIGN KEY (rut_pasaporte) REFERENCES public.persona(rut_pasaporte) ON DELETE CASCADE;


--
-- TOC entry 3804 (class 2606 OID 27966)
-- Name: designacion_arbitro designacion_arbitro_id_partido_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.designacion_arbitro
    ADD CONSTRAINT designacion_arbitro_id_partido_fkey FOREIGN KEY (id_partido) REFERENCES public.partido(id_partido) ON DELETE CASCADE;


--
-- TOC entry 3805 (class 2606 OID 27971)
-- Name: designacion_arbitro designacion_arbitro_rut_pasaporte_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.designacion_arbitro
    ADD CONSTRAINT designacion_arbitro_rut_pasaporte_fkey FOREIGN KEY (rut_pasaporte) REFERENCES public.persona(rut_pasaporte) ON DELETE CASCADE;


--
-- TOC entry 3792 (class 2606 OID 27869)
-- Name: dirigente dirigente_id_equipo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dirigente
    ADD CONSTRAINT dirigente_id_equipo_fkey FOREIGN KEY (id_equipo) REFERENCES public.equipo(id_equipo) ON DELETE CASCADE;


--
-- TOC entry 3793 (class 2606 OID 27864)
-- Name: dirigente dirigente_rut_pasaporte_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dirigente
    ADD CONSTRAINT dirigente_rut_pasaporte_fkey FOREIGN KEY (rut_pasaporte) REFERENCES public.persona(rut_pasaporte) ON DELETE CASCADE;


--
-- TOC entry 3785 (class 2606 OID 27806)
-- Name: equipo_campeonato equipo_campeonato_id_campeonato_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.equipo_campeonato
    ADD CONSTRAINT equipo_campeonato_id_campeonato_fkey FOREIGN KEY (id_campeonato) REFERENCES public.campeonato(id_campeonato) ON DELETE CASCADE;


--
-- TOC entry 3786 (class 2606 OID 27801)
-- Name: equipo_campeonato equipo_campeonato_id_equipo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.equipo_campeonato
    ADD CONSTRAINT equipo_campeonato_id_equipo_fkey FOREIGN KEY (id_equipo) REFERENCES public.equipo(id_equipo) ON DELETE CASCADE;


--
-- TOC entry 3794 (class 2606 OID 27888)
-- Name: estadio_local estadio_local_id_equipo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estadio_local
    ADD CONSTRAINT estadio_local_id_equipo_fkey FOREIGN KEY (id_equipo) REFERENCES public.equipo(id_equipo) ON DELETE CASCADE;


--
-- TOC entry 3795 (class 2606 OID 27893)
-- Name: estadio_local estadio_local_id_estadio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estadio_local
    ADD CONSTRAINT estadio_local_id_estadio_fkey FOREIGN KEY (id_estadio) REFERENCES public.estadio(id_estadio) ON DELETE CASCADE;


--
-- TOC entry 3806 (class 2606 OID 27984)
-- Name: gol gol_id_partido_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gol
    ADD CONSTRAINT gol_id_partido_fkey FOREIGN KEY (id_partido) REFERENCES public.partido(id_partido) ON DELETE CASCADE;


--
-- TOC entry 3807 (class 2606 OID 27989)
-- Name: gol gol_rut_jugador_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gol
    ADD CONSTRAINT gol_rut_jugador_fkey FOREIGN KEY (rut_jugador) REFERENCES public.persona(rut_pasaporte) ON DELETE CASCADE;


--
-- TOC entry 3810 (class 2606 OID 28031)
-- Name: integrante_tribunal integrante_tribunal_id_sala_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.integrante_tribunal
    ADD CONSTRAINT integrante_tribunal_id_sala_fkey FOREIGN KEY (id_sala) REFERENCES public.sala_tribunal(id_sala) ON DELETE CASCADE;


--
-- TOC entry 3811 (class 2606 OID 28026)
-- Name: integrante_tribunal integrante_tribunal_rut_pasaporte_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.integrante_tribunal
    ADD CONSTRAINT integrante_tribunal_rut_pasaporte_fkey FOREIGN KEY (rut_pasaporte) REFERENCES public.persona(rut_pasaporte) ON DELETE CASCADE;


--
-- TOC entry 3802 (class 2606 OID 27950)
-- Name: participacion_partido_cuerpo_tecnico participacion_partido_cuerpo_tecnico_id_partido_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.participacion_partido_cuerpo_tecnico
    ADD CONSTRAINT participacion_partido_cuerpo_tecnico_id_partido_fkey FOREIGN KEY (id_partido) REFERENCES public.partido(id_partido) ON DELETE CASCADE;


--
-- TOC entry 3803 (class 2606 OID 27955)
-- Name: participacion_partido_cuerpo_tecnico participacion_partido_cuerpo_tecnico_rut_pasaporte_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.participacion_partido_cuerpo_tecnico
    ADD CONSTRAINT participacion_partido_cuerpo_tecnico_rut_pasaporte_fkey FOREIGN KEY (rut_pasaporte) REFERENCES public.persona(rut_pasaporte) ON DELETE CASCADE;


--
-- TOC entry 3800 (class 2606 OID 27935)
-- Name: participacion_partido_jugador participacion_partido_jugador_id_partido_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.participacion_partido_jugador
    ADD CONSTRAINT participacion_partido_jugador_id_partido_fkey FOREIGN KEY (id_partido) REFERENCES public.partido(id_partido) ON DELETE CASCADE;


--
-- TOC entry 3801 (class 2606 OID 27940)
-- Name: participacion_partido_jugador participacion_partido_jugador_rut_pasaporte_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.participacion_partido_jugador
    ADD CONSTRAINT participacion_partido_jugador_rut_pasaporte_fkey FOREIGN KEY (rut_pasaporte) REFERENCES public.persona(rut_pasaporte) ON DELETE CASCADE;


--
-- TOC entry 3796 (class 2606 OID 27909)
-- Name: partido partido_id_campeonato_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.partido
    ADD CONSTRAINT partido_id_campeonato_fkey FOREIGN KEY (id_campeonato) REFERENCES public.campeonato(id_campeonato) ON DELETE CASCADE;


--
-- TOC entry 3797 (class 2606 OID 27914)
-- Name: partido partido_id_equipo_local_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.partido
    ADD CONSTRAINT partido_id_equipo_local_fkey FOREIGN KEY (id_equipo_local) REFERENCES public.equipo(id_equipo) ON DELETE CASCADE;


--
-- TOC entry 3798 (class 2606 OID 27919)
-- Name: partido partido_id_equipo_visita_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.partido
    ADD CONSTRAINT partido_id_equipo_visita_fkey FOREIGN KEY (id_equipo_visita) REFERENCES public.equipo(id_equipo) ON DELETE CASCADE;


--
-- TOC entry 3799 (class 2606 OID 27924)
-- Name: partido partido_id_estadio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.partido
    ADD CONSTRAINT partido_id_estadio_fkey FOREIGN KEY (id_estadio) REFERENCES public.estadio(id_estadio) ON DELETE CASCADE;


--
-- TOC entry 3787 (class 2606 OID 27835)
-- Name: plantel_jugador plantel_jugador_id_campeonato_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plantel_jugador
    ADD CONSTRAINT plantel_jugador_id_campeonato_fkey FOREIGN KEY (id_campeonato) REFERENCES public.campeonato(id_campeonato) ON DELETE CASCADE;


--
-- TOC entry 3788 (class 2606 OID 27830)
-- Name: plantel_jugador plantel_jugador_id_equipo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plantel_jugador
    ADD CONSTRAINT plantel_jugador_id_equipo_fkey FOREIGN KEY (id_equipo) REFERENCES public.equipo(id_equipo) ON DELETE CASCADE;


--
-- TOC entry 3789 (class 2606 OID 27825)
-- Name: plantel_jugador plantel_jugador_rut_pasaporte_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plantel_jugador
    ADD CONSTRAINT plantel_jugador_rut_pasaporte_fkey FOREIGN KEY (rut_pasaporte) REFERENCES public.persona(rut_pasaporte) ON DELETE CASCADE;


--
-- TOC entry 3812 (class 2606 OID 28051)
-- Name: sancion sanccion_id_campeonato_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sancion
    ADD CONSTRAINT sanccion_id_campeonato_fkey FOREIGN KEY (id_campeonato) REFERENCES public.campeonato(id_campeonato) ON DELETE CASCADE;


--
-- TOC entry 3813 (class 2606 OID 28046)
-- Name: sancion sanccion_rut_sancionado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sancion
    ADD CONSTRAINT sanccion_rut_sancionado_fkey FOREIGN KEY (rut_sancionado) REFERENCES public.persona(rut_pasaporte) ON DELETE CASCADE;


--
-- TOC entry 3808 (class 2606 OID 28003)
-- Name: tarjeta tarjeta_id_partido_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tarjeta
    ADD CONSTRAINT tarjeta_id_partido_fkey FOREIGN KEY (id_partido) REFERENCES public.partido(id_partido) ON DELETE CASCADE;


--
-- TOC entry 3809 (class 2606 OID 28008)
-- Name: tarjeta tarjeta_rut_persona_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tarjeta
    ADD CONSTRAINT tarjeta_rut_persona_fkey FOREIGN KEY (rut_persona) REFERENCES public.persona(rut_pasaporte) ON DELETE CASCADE;


-- Completed on 2026-10-22 17:28:40 -03

--
-- PostgreSQL database dump complete
--

\unrestrict oM6L4xehhnuFFGb76ZOpWccEvgWO8sCZ0thQbLvXMzA3iqkCv0t29JeeapCeof1

