--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;

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
-- Name: account_emailaddress; Type: TABLE; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE TABLE public.account_emailaddress (
    id integer NOT NULL,
    user_id integer NOT NULL,
    email character varying(75) NOT NULL,
    verified boolean NOT NULL,
    "primary" boolean NOT NULL
);


ALTER TABLE public.account_emailaddress OWNER TO "timtec-production";

--
-- Name: account_emailaddress_id_seq; Type: SEQUENCE; Schema: public; Owner: timtec-production
--

CREATE SEQUENCE public.account_emailaddress_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.account_emailaddress_id_seq OWNER TO "timtec-production";

--
-- Name: account_emailaddress_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: timtec-production
--

ALTER SEQUENCE public.account_emailaddress_id_seq OWNED BY public.account_emailaddress.id;


--
-- Name: account_emailconfirmation; Type: TABLE; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE TABLE public.account_emailconfirmation (
    id integer NOT NULL,
    email_address_id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    sent timestamp with time zone,
    key character varying(64) NOT NULL
);


ALTER TABLE public.account_emailconfirmation OWNER TO "timtec-production";

--
-- Name: account_emailconfirmation_id_seq; Type: SEQUENCE; Schema: public; Owner: timtec-production
--

CREATE SEQUENCE public.account_emailconfirmation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.account_emailconfirmation_id_seq OWNER TO "timtec-production";

--
-- Name: account_emailconfirmation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: timtec-production
--

ALTER SEQUENCE public.account_emailconfirmation_id_seq OWNED BY public.account_emailconfirmation.id;


--
-- Name: accounts_city; Type: TABLE; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE TABLE public.accounts_city (
    id integer NOT NULL,
    code character varying(10) NOT NULL,
    name character varying(80) NOT NULL,
    uf_id character varying(2) NOT NULL
);


ALTER TABLE public.accounts_city OWNER TO "timtec-production";

--
-- Name: accounts_city_id_seq; Type: SEQUENCE; Schema: public; Owner: timtec-production
--

CREATE SEQUENCE public.accounts_city_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accounts_city_id_seq OWNER TO "timtec-production";

--
-- Name: accounts_city_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: timtec-production
--

ALTER SEQUENCE public.accounts_city_id_seq OWNED BY public.accounts_city.id;


--
-- Name: accounts_discipline; Type: TABLE; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE TABLE public.accounts_discipline (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    visible boolean NOT NULL
);


ALTER TABLE public.accounts_discipline OWNER TO "timtec-production";

--
-- Name: accounts_discipline_id_seq; Type: SEQUENCE; Schema: public; Owner: timtec-production
--

CREATE SEQUENCE public.accounts_discipline_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accounts_discipline_id_seq OWNER TO "timtec-production";

--
-- Name: accounts_discipline_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: timtec-production
--

ALTER SEQUENCE public.accounts_discipline_id_seq OWNED BY public.accounts_discipline.id;


--
-- Name: accounts_educationdegree; Type: TABLE; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE TABLE public.accounts_educationdegree (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    education_level_id character varying(3) NOT NULL
);


ALTER TABLE public.accounts_educationdegree OWNER TO "timtec-production";

--
-- Name: accounts_educationdegree_id_seq; Type: SEQUENCE; Schema: public; Owner: timtec-production
--

CREATE SEQUENCE public.accounts_educationdegree_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accounts_educationdegree_id_seq OWNER TO "timtec-production";

--
-- Name: accounts_educationdegree_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: timtec-production
--

ALTER SEQUENCE public.accounts_educationdegree_id_seq OWNED BY public.accounts_educationdegree.id;


--
-- Name: accounts_educationlevel; Type: TABLE; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE TABLE public.accounts_educationlevel (
    slug character varying(3) NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.accounts_educationlevel OWNER TO "timtec-production";

--
-- Name: accounts_occupation; Type: TABLE; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE TABLE public.accounts_occupation (
    id integer NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE public.accounts_occupation OWNER TO "timtec-production";

--
-- Name: accounts_occupation_id_seq; Type: SEQUENCE; Schema: public; Owner: timtec-production
--

CREATE SEQUENCE public.accounts_occupation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accounts_occupation_id_seq OWNER TO "timtec-production";

--
-- Name: accounts_occupation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: timtec-production
--

ALTER SEQUENCE public.accounts_occupation_id_seq OWNED BY public.accounts_occupation.id;


--
-- Name: accounts_school; Type: TABLE; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE TABLE public.accounts_school (
    id integer NOT NULL,
    name character varying(200) NOT NULL,
    school_type character varying(2),
    city_id integer
);


ALTER TABLE public.accounts_school OWNER TO "timtec-production";

--
-- Name: accounts_school_id_seq; Type: SEQUENCE; Schema: public; Owner: timtec-production
--

CREATE SEQUENCE public.accounts_school_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accounts_school_id_seq OWNER TO "timtec-production";

--
-- Name: accounts_school_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: timtec-production
--

ALTER SEQUENCE public.accounts_school_id_seq OWNED BY public.accounts_school.id;


--
-- Name: accounts_state; Type: TABLE; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE TABLE public.accounts_state (
    uf character varying(2) NOT NULL,
    name character varying(50) NOT NULL,
    uf_code character varying(5) NOT NULL
);


ALTER TABLE public.accounts_state OWNER TO "timtec-production";

--
-- Name: accounts_timtecuser; Type: TABLE; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE TABLE public.accounts_timtecuser (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone NOT NULL,
    is_superuser boolean NOT NULL,
    username character varying(30) NOT NULL,
    first_name character varying(60) NOT NULL,
    last_name character varying(60) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL,
    picture character varying(100) NOT NULL,
    occupation character varying(30) NOT NULL,
    site character varying(200) NOT NULL,
    biography text NOT NULL,
    accepted_terms boolean NOT NULL,
    business_email character varying(75),
    email character varying(75) NOT NULL,
    city_id integer
);


ALTER TABLE public.accounts_timtecuser OWNER TO "timtec-production";

--
-- Name: accounts_timtecuser_disciplines; Type: TABLE; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE TABLE public.accounts_timtecuser_disciplines (
    id integer NOT NULL,
    timtecuser_id integer NOT NULL,
    discipline_id integer NOT NULL
);


ALTER TABLE public.accounts_timtecuser_disciplines OWNER TO "timtec-production";

--
-- Name: accounts_timtecuser_disciplines_id_seq; Type: SEQUENCE; Schema: public; Owner: timtec-production
--

CREATE SEQUENCE public.accounts_timtecuser_disciplines_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accounts_timtecuser_disciplines_id_seq OWNER TO "timtec-production";

--
-- Name: accounts_timtecuser_disciplines_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: timtec-production
--

ALTER SEQUENCE public.accounts_timtecuser_disciplines_id_seq OWNED BY public.accounts_timtecuser_disciplines.id;


--
-- Name: accounts_timtecuser_education_degrees; Type: TABLE; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE TABLE public.accounts_timtecuser_education_degrees (
    id integer NOT NULL,
    timtecuser_id integer NOT NULL,
    educationdegree_id integer NOT NULL
);


ALTER TABLE public.accounts_timtecuser_education_degrees OWNER TO "timtec-production";

--
-- Name: accounts_timtecuser_education_degrees_id_seq; Type: SEQUENCE; Schema: public; Owner: timtec-production
--

CREATE SEQUENCE public.accounts_timtecuser_education_degrees_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accounts_timtecuser_education_degrees_id_seq OWNER TO "timtec-production";

--
-- Name: accounts_timtecuser_education_degrees_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: timtec-production
--

ALTER SEQUENCE public.accounts_timtecuser_education_degrees_id_seq OWNED BY public.accounts_timtecuser_education_degrees.id;


--
-- Name: accounts_timtecuser_groups; Type: TABLE; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE TABLE public.accounts_timtecuser_groups (
    id integer NOT NULL,
    timtecuser_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.accounts_timtecuser_groups OWNER TO "timtec-production";

--
-- Name: accounts_timtecuser_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: timtec-production
--

CREATE SEQUENCE public.accounts_timtecuser_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accounts_timtecuser_groups_id_seq OWNER TO "timtec-production";

--
-- Name: accounts_timtecuser_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: timtec-production
--

ALTER SEQUENCE public.accounts_timtecuser_groups_id_seq OWNED BY public.accounts_timtecuser_groups.id;


--
-- Name: accounts_timtecuser_id_seq; Type: SEQUENCE; Schema: public; Owner: timtec-production
--

CREATE SEQUENCE public.accounts_timtecuser_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accounts_timtecuser_id_seq OWNER TO "timtec-production";

--
-- Name: accounts_timtecuser_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: timtec-production
--

ALTER SEQUENCE public.accounts_timtecuser_id_seq OWNED BY public.accounts_timtecuser.id;


--
-- Name: accounts_timtecuser_occupations; Type: TABLE; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE TABLE public.accounts_timtecuser_occupations (
    id integer NOT NULL,
    timtecuser_id integer NOT NULL,
    occupation_id integer NOT NULL
);


ALTER TABLE public.accounts_timtecuser_occupations OWNER TO "timtec-production";

--
-- Name: accounts_timtecuser_occupations_id_seq; Type: SEQUENCE; Schema: public; Owner: timtec-production
--

CREATE SEQUENCE public.accounts_timtecuser_occupations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accounts_timtecuser_occupations_id_seq OWNER TO "timtec-production";

--
-- Name: accounts_timtecuser_occupations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: timtec-production
--

ALTER SEQUENCE public.accounts_timtecuser_occupations_id_seq OWNED BY public.accounts_timtecuser_occupations.id;


--
-- Name: accounts_timtecuser_schools; Type: TABLE; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE TABLE public.accounts_timtecuser_schools (
    id integer NOT NULL,
    timtecuser_id integer NOT NULL,
    school_id integer NOT NULL
);


ALTER TABLE public.accounts_timtecuser_schools OWNER TO "timtec-production";

--
-- Name: accounts_timtecuser_schools_id_seq; Type: SEQUENCE; Schema: public; Owner: timtec-production
--

CREATE SEQUENCE public.accounts_timtecuser_schools_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accounts_timtecuser_schools_id_seq OWNER TO "timtec-production";

--
-- Name: accounts_timtecuser_schools_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: timtec-production
--

ALTER SEQUENCE public.accounts_timtecuser_schools_id_seq OWNED BY public.accounts_timtecuser_schools.id;


--
-- Name: accounts_timtecuser_user_permissions; Type: TABLE; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE TABLE public.accounts_timtecuser_user_permissions (
    id integer NOT NULL,
    timtecuser_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.accounts_timtecuser_user_permissions OWNER TO "timtec-production";

--
-- Name: accounts_timtecuser_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: timtec-production
--

CREATE SEQUENCE public.accounts_timtecuser_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accounts_timtecuser_user_permissions_id_seq OWNER TO "timtec-production";

--
-- Name: accounts_timtecuser_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: timtec-production
--

ALTER SEQUENCE public.accounts_timtecuser_user_permissions_id_seq OWNED BY public.accounts_timtecuser_user_permissions.id;


--
-- Name: accounts_timtecuserschool; Type: TABLE; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE TABLE public.accounts_timtecuserschool (
    id integer NOT NULL,
    professor_id integer NOT NULL,
    school_id integer NOT NULL
);


ALTER TABLE public.accounts_timtecuserschool OWNER TO "timtec-production";

--
-- Name: accounts_timtecuserschool_education_degree; Type: TABLE; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE TABLE public.accounts_timtecuserschool_education_degree (
    id integer NOT NULL,
    timtecuserschool_id integer NOT NULL,
    educationdegree_id integer NOT NULL
);


ALTER TABLE public.accounts_timtecuserschool_education_degree OWNER TO "timtec-production";

--
-- Name: accounts_timtecuserschool_education_degree_id_seq; Type: SEQUENCE; Schema: public; Owner: timtec-production
--

CREATE SEQUENCE public.accounts_timtecuserschool_education_degree_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accounts_timtecuserschool_education_degree_id_seq OWNER TO "timtec-production";

--
-- Name: accounts_timtecuserschool_education_degree_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: timtec-production
--

ALTER SEQUENCE public.accounts_timtecuserschool_education_degree_id_seq OWNED BY public.accounts_timtecuserschool_education_degree.id;


--
-- Name: accounts_timtecuserschool_id_seq; Type: SEQUENCE; Schema: public; Owner: timtec-production
--

CREATE SEQUENCE public.accounts_timtecuserschool_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accounts_timtecuserschool_id_seq OWNER TO "timtec-production";

--
-- Name: accounts_timtecuserschool_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: timtec-production
--

ALTER SEQUENCE public.accounts_timtecuserschool_id_seq OWNED BY public.accounts_timtecuserschool.id;


--
-- Name: activities_activity; Type: TABLE; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE TABLE public.activities_activity (
    id integer NOT NULL,
    type character varying(255) NOT NULL,
    data text NOT NULL,
    expected text NOT NULL,
    unit_id integer,
    comment text NOT NULL
);


ALTER TABLE public.activities_activity OWNER TO "timtec-production";

--
-- Name: activities_activity_id_seq; Type: SEQUENCE; Schema: public; Owner: timtec-production
--

CREATE SEQUENCE public.activities_activity_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.activities_activity_id_seq OWNER TO "timtec-production";

--
-- Name: activities_activity_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: timtec-production
--

ALTER SEQUENCE public.activities_activity_id_seq OWNED BY public.activities_activity.id;


--
-- Name: activities_answer; Type: TABLE; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE TABLE public.activities_answer (
    id integer NOT NULL,
    activity_id integer NOT NULL,
    user_id integer NOT NULL,
    "timestamp" timestamp with time zone NOT NULL,
    given text NOT NULL
);


ALTER TABLE public.activities_answer OWNER TO "timtec-production";

--
-- Name: activities_answer_id_seq; Type: SEQUENCE; Schema: public; Owner: timtec-production
--

CREATE SEQUENCE public.activities_answer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.activities_answer_id_seq OWNER TO "timtec-production";

--
-- Name: activities_answer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: timtec-production
--

ALTER SEQUENCE public.activities_answer_id_seq OWNED BY public.activities_answer.id;


--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(80) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO "timtec-production";

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: timtec-production
--

CREATE SEQUENCE public.auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO "timtec-production";

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: timtec-production
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE TABLE public.auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO "timtec-production";

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: timtec-production
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO "timtec-production";

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: timtec-production
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO "timtec-production";

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: timtec-production
--

CREATE SEQUENCE public.auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO "timtec-production";

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: timtec-production
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: core_class; Type: TABLE; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE TABLE public.core_class (
    id integer NOT NULL,
    name character varying(200) NOT NULL,
    assistant_id integer,
    course_id integer NOT NULL
);


ALTER TABLE public.core_class OWNER TO "timtec-production";

--
-- Name: core_class_id_seq; Type: SEQUENCE; Schema: public; Owner: timtec-production
--

CREATE SEQUENCE public.core_class_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.core_class_id_seq OWNER TO "timtec-production";

--
-- Name: core_class_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: timtec-production
--

ALTER SEQUENCE public.core_class_id_seq OWNED BY public.core_class.id;


--
-- Name: core_class_students; Type: TABLE; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE TABLE public.core_class_students (
    id integer NOT NULL,
    class_id integer NOT NULL,
    timtecuser_id integer NOT NULL
);


ALTER TABLE public.core_class_students OWNER TO "timtec-production";

--
-- Name: core_class_students_id_seq; Type: SEQUENCE; Schema: public; Owner: timtec-production
--

CREATE SEQUENCE public.core_class_students_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.core_class_students_id_seq OWNER TO "timtec-production";

--
-- Name: core_class_students_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: timtec-production
--

ALTER SEQUENCE public.core_class_students_id_seq OWNED BY public.core_class_students.id;


--
-- Name: core_course; Type: TABLE; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE TABLE public.core_course (
    id integer NOT NULL,
    slug character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    intro_video_id integer,
    application text NOT NULL,
    requirement text NOT NULL,
    abstract text NOT NULL,
    structure text NOT NULL,
    workload text NOT NULL,
    pronatec text NOT NULL,
    status character varying(64) NOT NULL,
    thumbnail character varying(100),
    home_thumbnail character varying(100),
    home_position integer,
    start_date date,
    home_published boolean NOT NULL,
    default_class_id integer,
    tuition numeric(9,2) NOT NULL,
    payment_url text
);


ALTER TABLE public.core_course OWNER TO "timtec-production";

--
-- Name: core_course_id_seq; Type: SEQUENCE; Schema: public; Owner: timtec-production
--

CREATE SEQUENCE public.core_course_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.core_course_id_seq OWNER TO "timtec-production";

--
-- Name: core_course_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: timtec-production
--

ALTER SEQUENCE public.core_course_id_seq OWNED BY public.core_course.id;


--
-- Name: core_courseauthor; Type: TABLE; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE TABLE public.core_courseauthor (
    id integer NOT NULL,
    user_id integer,
    course_id integer NOT NULL,
    biography text,
    picture character varying(100),
    name text,
    "position" integer
);


ALTER TABLE public.core_courseauthor OWNER TO "timtec-production";

--
-- Name: core_courseauthor_id_seq; Type: SEQUENCE; Schema: public; Owner: timtec-production
--

CREATE SEQUENCE public.core_courseauthor_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.core_courseauthor_id_seq OWNER TO "timtec-production";

--
-- Name: core_courseauthor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: timtec-production
--

ALTER SEQUENCE public.core_courseauthor_id_seq OWNED BY public.core_courseauthor.id;


--
-- Name: core_courseprofessor; Type: TABLE; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE TABLE public.core_courseprofessor (
    id integer NOT NULL,
    user_id integer,
    course_id integer NOT NULL,
    biography text,
    role character varying(128) NOT NULL,
    picture character varying(100),
    name text,
    is_course_author boolean NOT NULL
);


ALTER TABLE public.core_courseprofessor OWNER TO "timtec-production";

--
-- Name: core_courseprofessor_id_seq; Type: SEQUENCE; Schema: public; Owner: timtec-production
--

CREATE SEQUENCE public.core_courseprofessor_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.core_courseprofessor_id_seq OWNER TO "timtec-production";

--
-- Name: core_courseprofessor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: timtec-production
--

ALTER SEQUENCE public.core_courseprofessor_id_seq OWNED BY public.core_courseprofessor.id;


--
-- Name: core_coursestudent; Type: TABLE; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE TABLE public.core_coursestudent (
    id integer NOT NULL,
    user_id integer NOT NULL,
    course_id integer NOT NULL,
    status character varying(1) NOT NULL,
    created_at timestamp with time zone NOT NULL
);


ALTER TABLE public.core_coursestudent OWNER TO "timtec-production";

--
-- Name: core_coursestudent_id_seq; Type: SEQUENCE; Schema: public; Owner: timtec-production
--

CREATE SEQUENCE public.core_coursestudent_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.core_coursestudent_id_seq OWNER TO "timtec-production";

--
-- Name: core_coursestudent_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: timtec-production
--

ALTER SEQUENCE public.core_coursestudent_id_seq OWNED BY public.core_coursestudent.id;


--
-- Name: core_emailtemplate; Type: TABLE; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE TABLE public.core_emailtemplate (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    subject character varying(255) NOT NULL,
    template text NOT NULL
);


ALTER TABLE public.core_emailtemplate OWNER TO "timtec-production";

--
-- Name: core_emailtemplate_id_seq; Type: SEQUENCE; Schema: public; Owner: timtec-production
--

CREATE SEQUENCE public.core_emailtemplate_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.core_emailtemplate_id_seq OWNER TO "timtec-production";

--
-- Name: core_emailtemplate_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: timtec-production
--

ALTER SEQUENCE public.core_emailtemplate_id_seq OWNED BY public.core_emailtemplate.id;


--
-- Name: core_lesson; Type: TABLE; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE TABLE public.core_lesson (
    id integer NOT NULL,
    course_id integer NOT NULL,
    "desc" text NOT NULL,
    name character varying(255) NOT NULL,
    notes text NOT NULL,
    "position" integer NOT NULL,
    slug character varying(255) NOT NULL,
    status character varying(64) NOT NULL
);


ALTER TABLE public.core_lesson OWNER TO "timtec-production";

--
-- Name: core_lesson_id_seq; Type: SEQUENCE; Schema: public; Owner: timtec-production
--

CREATE SEQUENCE public.core_lesson_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.core_lesson_id_seq OWNER TO "timtec-production";

--
-- Name: core_lesson_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: timtec-production
--

ALTER SEQUENCE public.core_lesson_id_seq OWNED BY public.core_lesson.id;


--
-- Name: core_professormessage; Type: TABLE; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE TABLE public.core_professormessage (
    id integer NOT NULL,
    professor_id integer NOT NULL,
    subject character varying(255) NOT NULL,
    message text NOT NULL,
    date timestamp with time zone NOT NULL,
    course_id integer
);


ALTER TABLE public.core_professormessage OWNER TO "timtec-production";

--
-- Name: core_professormessage_id_seq; Type: SEQUENCE; Schema: public; Owner: timtec-production
--

CREATE SEQUENCE public.core_professormessage_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.core_professormessage_id_seq OWNER TO "timtec-production";

--
-- Name: core_professormessage_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: timtec-production
--

ALTER SEQUENCE public.core_professormessage_id_seq OWNED BY public.core_professormessage.id;


--
-- Name: core_professormessage_users; Type: TABLE; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE TABLE public.core_professormessage_users (
    id integer NOT NULL,
    professormessage_id integer NOT NULL,
    timtecuser_id integer NOT NULL
);


ALTER TABLE public.core_professormessage_users OWNER TO "timtec-production";

--
-- Name: core_professormessage_users_id_seq; Type: SEQUENCE; Schema: public; Owner: timtec-production
--

CREATE SEQUENCE public.core_professormessage_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.core_professormessage_users_id_seq OWNER TO "timtec-production";

--
-- Name: core_professormessage_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: timtec-production
--

ALTER SEQUENCE public.core_professormessage_users_id_seq OWNED BY public.core_professormessage_users.id;


--
-- Name: core_studentprogress; Type: TABLE; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE TABLE public.core_studentprogress (
    id integer NOT NULL,
    user_id integer NOT NULL,
    unit_id integer NOT NULL,
    complete timestamp with time zone,
    last_access timestamp with time zone NOT NULL
);


ALTER TABLE public.core_studentprogress OWNER TO "timtec-production";

--
-- Name: core_studentprogress_id_seq; Type: SEQUENCE; Schema: public; Owner: timtec-production
--

CREATE SEQUENCE public.core_studentprogress_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.core_studentprogress_id_seq OWNER TO "timtec-production";

--
-- Name: core_studentprogress_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: timtec-production
--

ALTER SEQUENCE public.core_studentprogress_id_seq OWNED BY public.core_studentprogress.id;


--
-- Name: core_unit; Type: TABLE; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE TABLE public.core_unit (
    id integer NOT NULL,
    title character varying(128) NOT NULL,
    lesson_id integer NOT NULL,
    video_id integer,
    side_notes text NOT NULL,
    "position" integer NOT NULL
);


ALTER TABLE public.core_unit OWNER TO "timtec-production";

--
-- Name: core_unit_id_seq; Type: SEQUENCE; Schema: public; Owner: timtec-production
--

CREATE SEQUENCE public.core_unit_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.core_unit_id_seq OWNER TO "timtec-production";

--
-- Name: core_unit_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: timtec-production
--

ALTER SEQUENCE public.core_unit_id_seq OWNED BY public.core_unit.id;


--
-- Name: core_video; Type: TABLE; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE TABLE public.core_video (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    youtube_id character varying(100) NOT NULL
);


ALTER TABLE public.core_video OWNER TO "timtec-production";

--
-- Name: core_video_id_seq; Type: SEQUENCE; Schema: public; Owner: timtec-production
--

CREATE SEQUENCE public.core_video_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.core_video_id_seq OWNER TO "timtec-production";

--
-- Name: core_video_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: timtec-production
--

ALTER SEQUENCE public.core_video_id_seq OWNED BY public.core_video.id;


--
-- Name: course_material_coursematerial; Type: TABLE; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE TABLE public.course_material_coursematerial (
    id integer NOT NULL,
    course_id integer NOT NULL,
    text text NOT NULL
);


ALTER TABLE public.course_material_coursematerial OWNER TO "timtec-production";

--
-- Name: course_material_coursematerial_id_seq; Type: SEQUENCE; Schema: public; Owner: timtec-production
--

CREATE SEQUENCE public.course_material_coursematerial_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.course_material_coursematerial_id_seq OWNER TO "timtec-production";

--
-- Name: course_material_coursematerial_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: timtec-production
--

ALTER SEQUENCE public.course_material_coursematerial_id_seq OWNED BY public.course_material_coursematerial.id;


--
-- Name: course_material_file; Type: TABLE; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE TABLE public.course_material_file (
    id integer NOT NULL,
    file character varying(100) NOT NULL,
    course_material_id integer NOT NULL
);


ALTER TABLE public.course_material_file OWNER TO "timtec-production";

--
-- Name: course_material_file_id_seq; Type: SEQUENCE; Schema: public; Owner: timtec-production
--

CREATE SEQUENCE public.course_material_file_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.course_material_file_id_seq OWNER TO "timtec-production";

--
-- Name: course_material_file_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: timtec-production
--

ALTER SEQUENCE public.course_material_file_id_seq OWNED BY public.course_material_file.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    user_id integer NOT NULL,
    content_type_id integer,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO "timtec-production";

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: timtec-production
--

CREATE SEQUENCE public.django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO "timtec-production";

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: timtec-production
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO "timtec-production";

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: timtec-production
--

CREATE SEQUENCE public.django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO "timtec-production";

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: timtec-production
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- Name: django_flatpage; Type: TABLE; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE TABLE public.django_flatpage (
    id integer NOT NULL,
    url character varying(100) NOT NULL,
    title character varying(200) NOT NULL,
    content text NOT NULL,
    enable_comments boolean NOT NULL,
    template_name character varying(70) NOT NULL,
    registration_required boolean NOT NULL
);


ALTER TABLE public.django_flatpage OWNER TO "timtec-production";

--
-- Name: django_flatpage_id_seq; Type: SEQUENCE; Schema: public; Owner: timtec-production
--

CREATE SEQUENCE public.django_flatpage_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_flatpage_id_seq OWNER TO "timtec-production";

--
-- Name: django_flatpage_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: timtec-production
--

ALTER SEQUENCE public.django_flatpage_id_seq OWNED BY public.django_flatpage.id;


--
-- Name: django_flatpage_sites; Type: TABLE; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE TABLE public.django_flatpage_sites (
    id integer NOT NULL,
    flatpage_id integer NOT NULL,
    site_id integer NOT NULL
);


ALTER TABLE public.django_flatpage_sites OWNER TO "timtec-production";

--
-- Name: django_flatpage_sites_id_seq; Type: SEQUENCE; Schema: public; Owner: timtec-production
--

CREATE SEQUENCE public.django_flatpage_sites_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_flatpage_sites_id_seq OWNER TO "timtec-production";

--
-- Name: django_flatpage_sites_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: timtec-production
--

ALTER SEQUENCE public.django_flatpage_sites_id_seq OWNED BY public.django_flatpage_sites.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO "timtec-production";

--
-- Name: django_site; Type: TABLE; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE TABLE public.django_site (
    id integer NOT NULL,
    domain character varying(100) NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.django_site OWNER TO "timtec-production";

--
-- Name: django_site_id_seq; Type: SEQUENCE; Schema: public; Owner: timtec-production
--

CREATE SEQUENCE public.django_site_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_site_id_seq OWNER TO "timtec-production";

--
-- Name: django_site_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: timtec-production
--

ALTER SEQUENCE public.django_site_id_seq OWNED BY public.django_site.id;


--
-- Name: forum_answer; Type: TABLE; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE TABLE public.forum_answer (
    id integer NOT NULL,
    question_id integer NOT NULL,
    text text NOT NULL,
    user_id integer NOT NULL,
    "timestamp" timestamp with time zone NOT NULL
);


ALTER TABLE public.forum_answer OWNER TO "timtec-production";

--
-- Name: forum_answer_id_seq; Type: SEQUENCE; Schema: public; Owner: timtec-production
--

CREATE SEQUENCE public.forum_answer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.forum_answer_id_seq OWNER TO "timtec-production";

--
-- Name: forum_answer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: timtec-production
--

ALTER SEQUENCE public.forum_answer_id_seq OWNED BY public.forum_answer.id;


--
-- Name: forum_answervote; Type: TABLE; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE TABLE public.forum_answervote (
    vote_ptr_id integer NOT NULL,
    answer_id integer NOT NULL
);


ALTER TABLE public.forum_answervote OWNER TO "timtec-production";

--
-- Name: forum_question; Type: TABLE; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE TABLE public.forum_question (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    text text NOT NULL,
    slug character varying(255) NOT NULL,
    user_id integer NOT NULL,
    correct_answer_id integer,
    "timestamp" timestamp with time zone NOT NULL,
    course_id integer NOT NULL,
    lesson_id integer,
    hidden boolean NOT NULL,
    hidden_by_id integer,
    hidden_justification text
);


ALTER TABLE public.forum_question OWNER TO "timtec-production";

--
-- Name: forum_question_id_seq; Type: SEQUENCE; Schema: public; Owner: timtec-production
--

CREATE SEQUENCE public.forum_question_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.forum_question_id_seq OWNER TO "timtec-production";

--
-- Name: forum_question_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: timtec-production
--

ALTER SEQUENCE public.forum_question_id_seq OWNED BY public.forum_question.id;


--
-- Name: forum_questionvote; Type: TABLE; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE TABLE public.forum_questionvote (
    vote_ptr_id integer NOT NULL,
    question_id integer NOT NULL
);


ALTER TABLE public.forum_questionvote OWNER TO "timtec-production";

--
-- Name: forum_vote; Type: TABLE; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE TABLE public.forum_vote (
    id integer NOT NULL,
    user_id integer NOT NULL,
    "timestamp" timestamp with time zone NOT NULL,
    value integer NOT NULL
);


ALTER TABLE public.forum_vote OWNER TO "timtec-production";

--
-- Name: forum_vote_id_seq; Type: SEQUENCE; Schema: public; Owner: timtec-production
--

CREATE SEQUENCE public.forum_vote_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.forum_vote_id_seq OWNER TO "timtec-production";

--
-- Name: forum_vote_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: timtec-production
--

ALTER SEQUENCE public.forum_vote_id_seq OWNED BY public.forum_vote.id;


--
-- Name: joca_jocauser; Type: TABLE; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE TABLE public.joca_jocauser (
    id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.joca_jocauser OWNER TO "timtec-production";

--
-- Name: joca_jocauser_id_seq; Type: SEQUENCE; Schema: public; Owner: timtec-production
--

CREATE SEQUENCE public.joca_jocauser_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.joca_jocauser_id_seq OWNER TO "timtec-production";

--
-- Name: joca_jocauser_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: timtec-production
--

ALTER SEQUENCE public.joca_jocauser_id_seq OWNED BY public.joca_jocauser.id;


--
-- Name: notes_note; Type: TABLE; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE TABLE public.notes_note (
    id integer NOT NULL,
    text text NOT NULL,
    user_id integer NOT NULL,
    create_timestamp timestamp with time zone NOT NULL,
    last_edit_timestamp timestamp with time zone NOT NULL,
    content_type_id integer NOT NULL,
    object_id integer NOT NULL,
    CONSTRAINT notes_note_object_id_check CHECK ((object_id >= 0))
);


ALTER TABLE public.notes_note OWNER TO "timtec-production";

--
-- Name: notes_note_id_seq; Type: SEQUENCE; Schema: public; Owner: timtec-production
--

CREATE SEQUENCE public.notes_note_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.notes_note_id_seq OWNER TO "timtec-production";

--
-- Name: notes_note_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: timtec-production
--

ALTER SEQUENCE public.notes_note_id_seq OWNED BY public.notes_note.id;


--
-- Name: socialaccount_socialaccount; Type: TABLE; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE TABLE public.socialaccount_socialaccount (
    id integer NOT NULL,
    user_id integer NOT NULL,
    provider character varying(30) NOT NULL,
    uid character varying(255) NOT NULL,
    last_login timestamp with time zone NOT NULL,
    date_joined timestamp with time zone NOT NULL,
    extra_data text NOT NULL
);


ALTER TABLE public.socialaccount_socialaccount OWNER TO "timtec-production";

--
-- Name: socialaccount_socialaccount_id_seq; Type: SEQUENCE; Schema: public; Owner: timtec-production
--

CREATE SEQUENCE public.socialaccount_socialaccount_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.socialaccount_socialaccount_id_seq OWNER TO "timtec-production";

--
-- Name: socialaccount_socialaccount_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: timtec-production
--

ALTER SEQUENCE public.socialaccount_socialaccount_id_seq OWNED BY public.socialaccount_socialaccount.id;


--
-- Name: socialaccount_socialapp; Type: TABLE; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE TABLE public.socialaccount_socialapp (
    id integer NOT NULL,
    provider character varying(30) NOT NULL,
    name character varying(40) NOT NULL,
    client_id character varying(100) NOT NULL,
    secret character varying(100) NOT NULL,
    key character varying(100) NOT NULL
);


ALTER TABLE public.socialaccount_socialapp OWNER TO "timtec-production";

--
-- Name: socialaccount_socialapp_id_seq; Type: SEQUENCE; Schema: public; Owner: timtec-production
--

CREATE SEQUENCE public.socialaccount_socialapp_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.socialaccount_socialapp_id_seq OWNER TO "timtec-production";

--
-- Name: socialaccount_socialapp_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: timtec-production
--

ALTER SEQUENCE public.socialaccount_socialapp_id_seq OWNED BY public.socialaccount_socialapp.id;


--
-- Name: socialaccount_socialapp_sites; Type: TABLE; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE TABLE public.socialaccount_socialapp_sites (
    id integer NOT NULL,
    socialapp_id integer NOT NULL,
    site_id integer NOT NULL
);


ALTER TABLE public.socialaccount_socialapp_sites OWNER TO "timtec-production";

--
-- Name: socialaccount_socialapp_sites_id_seq; Type: SEQUENCE; Schema: public; Owner: timtec-production
--

CREATE SEQUENCE public.socialaccount_socialapp_sites_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.socialaccount_socialapp_sites_id_seq OWNER TO "timtec-production";

--
-- Name: socialaccount_socialapp_sites_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: timtec-production
--

ALTER SEQUENCE public.socialaccount_socialapp_sites_id_seq OWNED BY public.socialaccount_socialapp_sites.id;


--
-- Name: socialaccount_socialtoken; Type: TABLE; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE TABLE public.socialaccount_socialtoken (
    id integer NOT NULL,
    app_id integer NOT NULL,
    account_id integer NOT NULL,
    token text NOT NULL,
    token_secret text NOT NULL,
    expires_at timestamp with time zone
);


ALTER TABLE public.socialaccount_socialtoken OWNER TO "timtec-production";

--
-- Name: socialaccount_socialtoken_id_seq; Type: SEQUENCE; Schema: public; Owner: timtec-production
--

CREATE SEQUENCE public.socialaccount_socialtoken_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.socialaccount_socialtoken_id_seq OWNER TO "timtec-production";

--
-- Name: socialaccount_socialtoken_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: timtec-production
--

ALTER SEQUENCE public.socialaccount_socialtoken_id_seq OWNED BY public.socialaccount_socialtoken.id;


--
-- Name: south_migrationhistory; Type: TABLE; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE TABLE public.south_migrationhistory (
    id integer NOT NULL,
    app_name character varying(255) NOT NULL,
    migration character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.south_migrationhistory OWNER TO "timtec-production";

--
-- Name: south_migrationhistory_id_seq; Type: SEQUENCE; Schema: public; Owner: timtec-production
--

CREATE SEQUENCE public.south_migrationhistory_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.south_migrationhistory_id_seq OWNER TO "timtec-production";

--
-- Name: south_migrationhistory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: timtec-production
--

ALTER SEQUENCE public.south_migrationhistory_id_seq OWNED BY public.south_migrationhistory.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.account_emailaddress ALTER COLUMN id SET DEFAULT nextval('public.account_emailaddress_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.account_emailconfirmation ALTER COLUMN id SET DEFAULT nextval('public.account_emailconfirmation_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.accounts_city ALTER COLUMN id SET DEFAULT nextval('public.accounts_city_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.accounts_discipline ALTER COLUMN id SET DEFAULT nextval('public.accounts_discipline_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.accounts_educationdegree ALTER COLUMN id SET DEFAULT nextval('public.accounts_educationdegree_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.accounts_occupation ALTER COLUMN id SET DEFAULT nextval('public.accounts_occupation_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.accounts_school ALTER COLUMN id SET DEFAULT nextval('public.accounts_school_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.accounts_timtecuser ALTER COLUMN id SET DEFAULT nextval('public.accounts_timtecuser_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.accounts_timtecuser_disciplines ALTER COLUMN id SET DEFAULT nextval('public.accounts_timtecuser_disciplines_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.accounts_timtecuser_education_degrees ALTER COLUMN id SET DEFAULT nextval('public.accounts_timtecuser_education_degrees_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.accounts_timtecuser_groups ALTER COLUMN id SET DEFAULT nextval('public.accounts_timtecuser_groups_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.accounts_timtecuser_occupations ALTER COLUMN id SET DEFAULT nextval('public.accounts_timtecuser_occupations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.accounts_timtecuser_schools ALTER COLUMN id SET DEFAULT nextval('public.accounts_timtecuser_schools_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.accounts_timtecuser_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.accounts_timtecuser_user_permissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.accounts_timtecuserschool ALTER COLUMN id SET DEFAULT nextval('public.accounts_timtecuserschool_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.accounts_timtecuserschool_education_degree ALTER COLUMN id SET DEFAULT nextval('public.accounts_timtecuserschool_education_degree_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.activities_activity ALTER COLUMN id SET DEFAULT nextval('public.activities_activity_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.activities_answer ALTER COLUMN id SET DEFAULT nextval('public.activities_answer_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.core_class ALTER COLUMN id SET DEFAULT nextval('public.core_class_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.core_class_students ALTER COLUMN id SET DEFAULT nextval('public.core_class_students_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.core_course ALTER COLUMN id SET DEFAULT nextval('public.core_course_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.core_courseauthor ALTER COLUMN id SET DEFAULT nextval('public.core_courseauthor_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.core_courseprofessor ALTER COLUMN id SET DEFAULT nextval('public.core_courseprofessor_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.core_coursestudent ALTER COLUMN id SET DEFAULT nextval('public.core_coursestudent_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.core_emailtemplate ALTER COLUMN id SET DEFAULT nextval('public.core_emailtemplate_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.core_lesson ALTER COLUMN id SET DEFAULT nextval('public.core_lesson_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.core_professormessage ALTER COLUMN id SET DEFAULT nextval('public.core_professormessage_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.core_professormessage_users ALTER COLUMN id SET DEFAULT nextval('public.core_professormessage_users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.core_studentprogress ALTER COLUMN id SET DEFAULT nextval('public.core_studentprogress_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.core_unit ALTER COLUMN id SET DEFAULT nextval('public.core_unit_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.core_video ALTER COLUMN id SET DEFAULT nextval('public.core_video_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.course_material_coursematerial ALTER COLUMN id SET DEFAULT nextval('public.course_material_coursematerial_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.course_material_file ALTER COLUMN id SET DEFAULT nextval('public.course_material_file_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.django_flatpage ALTER COLUMN id SET DEFAULT nextval('public.django_flatpage_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.django_flatpage_sites ALTER COLUMN id SET DEFAULT nextval('public.django_flatpage_sites_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.django_site ALTER COLUMN id SET DEFAULT nextval('public.django_site_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.forum_answer ALTER COLUMN id SET DEFAULT nextval('public.forum_answer_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.forum_question ALTER COLUMN id SET DEFAULT nextval('public.forum_question_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.forum_vote ALTER COLUMN id SET DEFAULT nextval('public.forum_vote_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.joca_jocauser ALTER COLUMN id SET DEFAULT nextval('public.joca_jocauser_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.notes_note ALTER COLUMN id SET DEFAULT nextval('public.notes_note_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.socialaccount_socialaccount ALTER COLUMN id SET DEFAULT nextval('public.socialaccount_socialaccount_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.socialaccount_socialapp ALTER COLUMN id SET DEFAULT nextval('public.socialaccount_socialapp_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.socialaccount_socialapp_sites ALTER COLUMN id SET DEFAULT nextval('public.socialaccount_socialapp_sites_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.socialaccount_socialtoken ALTER COLUMN id SET DEFAULT nextval('public.socialaccount_socialtoken_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.south_migrationhistory ALTER COLUMN id SET DEFAULT nextval('public.south_migrationhistory_id_seq'::regclass);


--
-- Name: account_emailaddress_email_key; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.account_emailaddress
    ADD CONSTRAINT account_emailaddress_email_key UNIQUE (email);


--
-- Name: account_emailaddress_pkey; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.account_emailaddress
    ADD CONSTRAINT account_emailaddress_pkey PRIMARY KEY (id);


--
-- Name: account_emailconfirmation_key_key; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.account_emailconfirmation
    ADD CONSTRAINT account_emailconfirmation_key_key UNIQUE (key);


--
-- Name: account_emailconfirmation_pkey; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.account_emailconfirmation
    ADD CONSTRAINT account_emailconfirmation_pkey PRIMARY KEY (id);


--
-- Name: accounts_city_pkey; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.accounts_city
    ADD CONSTRAINT accounts_city_pkey PRIMARY KEY (id);


--
-- Name: accounts_discipline_name_key; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.accounts_discipline
    ADD CONSTRAINT accounts_discipline_name_key UNIQUE (name);


--
-- Name: accounts_discipline_pkey; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.accounts_discipline
    ADD CONSTRAINT accounts_discipline_pkey PRIMARY KEY (id);


--
-- Name: accounts_educationdegree_name_key; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.accounts_educationdegree
    ADD CONSTRAINT accounts_educationdegree_name_key UNIQUE (name);


--
-- Name: accounts_educationdegree_pkey; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.accounts_educationdegree
    ADD CONSTRAINT accounts_educationdegree_pkey PRIMARY KEY (id);


--
-- Name: accounts_educationlevel_pkey; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.accounts_educationlevel
    ADD CONSTRAINT accounts_educationlevel_pkey PRIMARY KEY (slug);


--
-- Name: accounts_occupation_pkey; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.accounts_occupation
    ADD CONSTRAINT accounts_occupation_pkey PRIMARY KEY (id);


--
-- Name: accounts_school_pkey; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.accounts_school
    ADD CONSTRAINT accounts_school_pkey PRIMARY KEY (id);


--
-- Name: accounts_state_pkey; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.accounts_state
    ADD CONSTRAINT accounts_state_pkey PRIMARY KEY (uf);


--
-- Name: accounts_timtecuser_disciplines_pkey; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.accounts_timtecuser_disciplines
    ADD CONSTRAINT accounts_timtecuser_disciplines_pkey PRIMARY KEY (id);


--
-- Name: accounts_timtecuser_disciplines_timtecuser_id_discipline_id_key; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.accounts_timtecuser_disciplines
    ADD CONSTRAINT accounts_timtecuser_disciplines_timtecuser_id_discipline_id_key UNIQUE (timtecuser_id, discipline_id);


--
-- Name: accounts_timtecuser_education_degrees_pkey; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.accounts_timtecuser_education_degrees
    ADD CONSTRAINT accounts_timtecuser_education_degrees_pkey PRIMARY KEY (id);


--
-- Name: accounts_timtecuser_education_timtecuser_id_educationdegree_key; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.accounts_timtecuser_education_degrees
    ADD CONSTRAINT accounts_timtecuser_education_timtecuser_id_educationdegree_key UNIQUE (timtecuser_id, educationdegree_id);


--
-- Name: accounts_timtecuser_email_key; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.accounts_timtecuser
    ADD CONSTRAINT accounts_timtecuser_email_key UNIQUE (email);


--
-- Name: accounts_timtecuser_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.accounts_timtecuser_groups
    ADD CONSTRAINT accounts_timtecuser_groups_pkey PRIMARY KEY (id);


--
-- Name: accounts_timtecuser_groups_timtecuser_id_group_id_key; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.accounts_timtecuser_groups
    ADD CONSTRAINT accounts_timtecuser_groups_timtecuser_id_group_id_key UNIQUE (timtecuser_id, group_id);


--
-- Name: accounts_timtecuser_occupations_pkey; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.accounts_timtecuser_occupations
    ADD CONSTRAINT accounts_timtecuser_occupations_pkey PRIMARY KEY (id);


--
-- Name: accounts_timtecuser_occupations_timtecuser_id_occupation_id_key; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.accounts_timtecuser_occupations
    ADD CONSTRAINT accounts_timtecuser_occupations_timtecuser_id_occupation_id_key UNIQUE (timtecuser_id, occupation_id);


--
-- Name: accounts_timtecuser_pkey; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.accounts_timtecuser
    ADD CONSTRAINT accounts_timtecuser_pkey PRIMARY KEY (id);


--
-- Name: accounts_timtecuser_schools_pkey; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.accounts_timtecuser_schools
    ADD CONSTRAINT accounts_timtecuser_schools_pkey PRIMARY KEY (id);


--
-- Name: accounts_timtecuser_schools_timtecuser_id_school_id_key; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.accounts_timtecuser_schools
    ADD CONSTRAINT accounts_timtecuser_schools_timtecuser_id_school_id_key UNIQUE (timtecuser_id, school_id);


--
-- Name: accounts_timtecuser_user_permis_timtecuser_id_permission_id_key; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.accounts_timtecuser_user_permissions
    ADD CONSTRAINT accounts_timtecuser_user_permis_timtecuser_id_permission_id_key UNIQUE (timtecuser_id, permission_id);


--
-- Name: accounts_timtecuser_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.accounts_timtecuser_user_permissions
    ADD CONSTRAINT accounts_timtecuser_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: accounts_timtecuser_username_key; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.accounts_timtecuser
    ADD CONSTRAINT accounts_timtecuser_username_key UNIQUE (username);


--
-- Name: accounts_timtecuserschool_edu_timtecuserschool_id_education_key; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.accounts_timtecuserschool_education_degree
    ADD CONSTRAINT accounts_timtecuserschool_edu_timtecuserschool_id_education_key UNIQUE (timtecuserschool_id, educationdegree_id);


--
-- Name: accounts_timtecuserschool_education_degree_pkey; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.accounts_timtecuserschool_education_degree
    ADD CONSTRAINT accounts_timtecuserschool_education_degree_pkey PRIMARY KEY (id);


--
-- Name: accounts_timtecuserschool_pkey; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.accounts_timtecuserschool
    ADD CONSTRAINT accounts_timtecuserschool_pkey PRIMARY KEY (id);


--
-- Name: activities_activity_pkey; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.activities_activity
    ADD CONSTRAINT activities_activity_pkey PRIMARY KEY (id);


--
-- Name: activities_answer_pkey; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.activities_answer
    ADD CONSTRAINT activities_answer_pkey PRIMARY KEY (id);


--
-- Name: auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions_group_id_permission_id_key; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_key UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission_content_type_id_codename_key; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_key UNIQUE (content_type_id, codename);


--
-- Name: auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: core_class_pkey; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.core_class
    ADD CONSTRAINT core_class_pkey PRIMARY KEY (id);


--
-- Name: core_class_students_class_id_timtecuser_id_key; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.core_class_students
    ADD CONSTRAINT core_class_students_class_id_timtecuser_id_key UNIQUE (class_id, timtecuser_id);


--
-- Name: core_class_students_pkey; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.core_class_students
    ADD CONSTRAINT core_class_students_pkey PRIMARY KEY (id);


--
-- Name: core_course_default_class_id_key; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.core_course
    ADD CONSTRAINT core_course_default_class_id_key UNIQUE (default_class_id);


--
-- Name: core_course_pkey; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.core_course
    ADD CONSTRAINT core_course_pkey PRIMARY KEY (id);


--
-- Name: core_course_slug_key; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.core_course
    ADD CONSTRAINT core_course_slug_key UNIQUE (slug);


--
-- Name: core_courseauthor_pkey; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.core_courseauthor
    ADD CONSTRAINT core_courseauthor_pkey PRIMARY KEY (id);


--
-- Name: core_courseauthor_user_id_course_id_key; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.core_courseauthor
    ADD CONSTRAINT core_courseauthor_user_id_course_id_key UNIQUE (user_id, course_id);


--
-- Name: core_courseprofessor_pkey; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.core_courseprofessor
    ADD CONSTRAINT core_courseprofessor_pkey PRIMARY KEY (id);


--
-- Name: core_courseprofessor_user_id_course_id_key; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.core_courseprofessor
    ADD CONSTRAINT core_courseprofessor_user_id_course_id_key UNIQUE (user_id, course_id);


--
-- Name: core_coursestudent_pkey; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.core_coursestudent
    ADD CONSTRAINT core_coursestudent_pkey PRIMARY KEY (id);


--
-- Name: core_coursestudent_user_id_course_id_key; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.core_coursestudent
    ADD CONSTRAINT core_coursestudent_user_id_course_id_key UNIQUE (user_id, course_id);


--
-- Name: core_emailtemplate_pkey; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.core_emailtemplate
    ADD CONSTRAINT core_emailtemplate_pkey PRIMARY KEY (id);


--
-- Name: core_lesson_pkey; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.core_lesson
    ADD CONSTRAINT core_lesson_pkey PRIMARY KEY (id);


--
-- Name: core_lesson_slug_key; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.core_lesson
    ADD CONSTRAINT core_lesson_slug_key UNIQUE (slug);


--
-- Name: core_professormessage_pkey; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.core_professormessage
    ADD CONSTRAINT core_professormessage_pkey PRIMARY KEY (id);


--
-- Name: core_professormessage_users_pkey; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.core_professormessage_users
    ADD CONSTRAINT core_professormessage_users_pkey PRIMARY KEY (id);


--
-- Name: core_professormessage_users_professormessage_id_timtecuser__key; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.core_professormessage_users
    ADD CONSTRAINT core_professormessage_users_professormessage_id_timtecuser__key UNIQUE (professormessage_id, timtecuser_id);


--
-- Name: core_studentprogress_pkey; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.core_studentprogress
    ADD CONSTRAINT core_studentprogress_pkey PRIMARY KEY (id);


--
-- Name: core_studentprogress_user_id_unit_id_key; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.core_studentprogress
    ADD CONSTRAINT core_studentprogress_user_id_unit_id_key UNIQUE (user_id, unit_id);


--
-- Name: core_unit_pkey; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.core_unit
    ADD CONSTRAINT core_unit_pkey PRIMARY KEY (id);


--
-- Name: core_video_pkey; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.core_video
    ADD CONSTRAINT core_video_pkey PRIMARY KEY (id);


--
-- Name: course_material_coursematerial_course_id_key; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.course_material_coursematerial
    ADD CONSTRAINT course_material_coursematerial_course_id_key UNIQUE (course_id);


--
-- Name: course_material_coursematerial_id_course_id_key; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.course_material_coursematerial
    ADD CONSTRAINT course_material_coursematerial_id_course_id_key UNIQUE (id, course_id);


--
-- Name: course_material_coursematerial_pkey; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.course_material_coursematerial
    ADD CONSTRAINT course_material_coursematerial_pkey PRIMARY KEY (id);


--
-- Name: course_material_file_pkey; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.course_material_file
    ADD CONSTRAINT course_material_file_pkey PRIMARY KEY (id);


--
-- Name: django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type_app_label_model_key; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_key UNIQUE (app_label, model);


--
-- Name: django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_flatpage_pkey; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.django_flatpage
    ADD CONSTRAINT django_flatpage_pkey PRIMARY KEY (id);


--
-- Name: django_flatpage_sites_flatpage_id_site_id_key; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.django_flatpage_sites
    ADD CONSTRAINT django_flatpage_sites_flatpage_id_site_id_key UNIQUE (flatpage_id, site_id);


--
-- Name: django_flatpage_sites_pkey; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.django_flatpage_sites
    ADD CONSTRAINT django_flatpage_sites_pkey PRIMARY KEY (id);


--
-- Name: django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: django_site_pkey; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.django_site
    ADD CONSTRAINT django_site_pkey PRIMARY KEY (id);


--
-- Name: forum_answer_pkey; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.forum_answer
    ADD CONSTRAINT forum_answer_pkey PRIMARY KEY (id);


--
-- Name: forum_answervote_pkey; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.forum_answervote
    ADD CONSTRAINT forum_answervote_pkey PRIMARY KEY (vote_ptr_id);


--
-- Name: forum_question_correct_answer_id_key; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.forum_question
    ADD CONSTRAINT forum_question_correct_answer_id_key UNIQUE (correct_answer_id);


--
-- Name: forum_question_pkey; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.forum_question
    ADD CONSTRAINT forum_question_pkey PRIMARY KEY (id);


--
-- Name: forum_question_slug_key; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.forum_question
    ADD CONSTRAINT forum_question_slug_key UNIQUE (slug);


--
-- Name: forum_questionvote_pkey; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.forum_questionvote
    ADD CONSTRAINT forum_questionvote_pkey PRIMARY KEY (vote_ptr_id);


--
-- Name: forum_vote_pkey; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.forum_vote
    ADD CONSTRAINT forum_vote_pkey PRIMARY KEY (id);


--
-- Name: joca_jocauser_pkey; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.joca_jocauser
    ADD CONSTRAINT joca_jocauser_pkey PRIMARY KEY (id);


--
-- Name: notes_note_pkey; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.notes_note
    ADD CONSTRAINT notes_note_pkey PRIMARY KEY (id);


--
-- Name: socialaccount_socialaccount_pkey; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.socialaccount_socialaccount
    ADD CONSTRAINT socialaccount_socialaccount_pkey PRIMARY KEY (id);


--
-- Name: socialaccount_socialaccount_provider_uid_key; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.socialaccount_socialaccount
    ADD CONSTRAINT socialaccount_socialaccount_provider_uid_key UNIQUE (provider, uid);


--
-- Name: socialaccount_socialapp_pkey; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.socialaccount_socialapp
    ADD CONSTRAINT socialaccount_socialapp_pkey PRIMARY KEY (id);


--
-- Name: socialaccount_socialapp_sites_pkey; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.socialaccount_socialapp_sites
    ADD CONSTRAINT socialaccount_socialapp_sites_pkey PRIMARY KEY (id);


--
-- Name: socialaccount_socialapp_sites_socialapp_id_site_id_key; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.socialaccount_socialapp_sites
    ADD CONSTRAINT socialaccount_socialapp_sites_socialapp_id_site_id_key UNIQUE (socialapp_id, site_id);


--
-- Name: socialaccount_socialtoken_app_id_account_id_key; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.socialaccount_socialtoken
    ADD CONSTRAINT socialaccount_socialtoken_app_id_account_id_key UNIQUE (app_id, account_id);


--
-- Name: socialaccount_socialtoken_pkey; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.socialaccount_socialtoken
    ADD CONSTRAINT socialaccount_socialtoken_pkey PRIMARY KEY (id);


--
-- Name: south_migrationhistory_pkey; Type: CONSTRAINT; Schema: public; Owner: timtec-production; Tablespace: 
--

ALTER TABLE ONLY public.south_migrationhistory
    ADD CONSTRAINT south_migrationhistory_pkey PRIMARY KEY (id);


--
-- Name: account_emailaddress_email_like; Type: INDEX; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE INDEX account_emailaddress_email_like ON public.account_emailaddress USING btree (email varchar_pattern_ops);


--
-- Name: account_emailaddress_user_id; Type: INDEX; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE INDEX account_emailaddress_user_id ON public.account_emailaddress USING btree (user_id);


--
-- Name: account_emailconfirmation_email_address_id; Type: INDEX; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE INDEX account_emailconfirmation_email_address_id ON public.account_emailconfirmation USING btree (email_address_id);


--
-- Name: account_emailconfirmation_key_like; Type: INDEX; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE INDEX account_emailconfirmation_key_like ON public.account_emailconfirmation USING btree (key varchar_pattern_ops);


--
-- Name: accounts_city_uf_id; Type: INDEX; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE INDEX accounts_city_uf_id ON public.accounts_city USING btree (uf_id);


--
-- Name: accounts_city_uf_id_like; Type: INDEX; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE INDEX accounts_city_uf_id_like ON public.accounts_city USING btree (uf_id varchar_pattern_ops);


--
-- Name: accounts_discipline_name_like; Type: INDEX; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE INDEX accounts_discipline_name_like ON public.accounts_discipline USING btree (name varchar_pattern_ops);


--
-- Name: accounts_educationdegree_education_level_id; Type: INDEX; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE INDEX accounts_educationdegree_education_level_id ON public.accounts_educationdegree USING btree (education_level_id);


--
-- Name: accounts_educationdegree_education_level_id_like; Type: INDEX; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE INDEX accounts_educationdegree_education_level_id_like ON public.accounts_educationdegree USING btree (education_level_id varchar_pattern_ops);


--
-- Name: accounts_educationdegree_name_like; Type: INDEX; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE INDEX accounts_educationdegree_name_like ON public.accounts_educationdegree USING btree (name varchar_pattern_ops);


--
-- Name: accounts_educationlevel_slug_like; Type: INDEX; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE INDEX accounts_educationlevel_slug_like ON public.accounts_educationlevel USING btree (slug varchar_pattern_ops);


--
-- Name: accounts_school_city_id; Type: INDEX; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE INDEX accounts_school_city_id ON public.accounts_school USING btree (city_id);


--
-- Name: accounts_state_uf_like; Type: INDEX; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE INDEX accounts_state_uf_like ON public.accounts_state USING btree (uf varchar_pattern_ops);


--
-- Name: accounts_timtecuser_city_id; Type: INDEX; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE INDEX accounts_timtecuser_city_id ON public.accounts_timtecuser USING btree (city_id);


--
-- Name: accounts_timtecuser_disciplines_discipline_id; Type: INDEX; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE INDEX accounts_timtecuser_disciplines_discipline_id ON public.accounts_timtecuser_disciplines USING btree (discipline_id);


--
-- Name: accounts_timtecuser_disciplines_timtecuser_id; Type: INDEX; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE INDEX accounts_timtecuser_disciplines_timtecuser_id ON public.accounts_timtecuser_disciplines USING btree (timtecuser_id);


--
-- Name: accounts_timtecuser_education_degrees_educationdegree_id; Type: INDEX; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE INDEX accounts_timtecuser_education_degrees_educationdegree_id ON public.accounts_timtecuser_education_degrees USING btree (educationdegree_id);


--
-- Name: accounts_timtecuser_education_degrees_timtecuser_id; Type: INDEX; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE INDEX accounts_timtecuser_education_degrees_timtecuser_id ON public.accounts_timtecuser_education_degrees USING btree (timtecuser_id);


--
-- Name: accounts_timtecuser_email_like; Type: INDEX; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE INDEX accounts_timtecuser_email_like ON public.accounts_timtecuser USING btree (email varchar_pattern_ops);


--
-- Name: accounts_timtecuser_groups_group_id; Type: INDEX; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE INDEX accounts_timtecuser_groups_group_id ON public.accounts_timtecuser_groups USING btree (group_id);


--
-- Name: accounts_timtecuser_groups_timtecuser_id; Type: INDEX; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE INDEX accounts_timtecuser_groups_timtecuser_id ON public.accounts_timtecuser_groups USING btree (timtecuser_id);


--
-- Name: accounts_timtecuser_occupations_occupation_id; Type: INDEX; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE INDEX accounts_timtecuser_occupations_occupation_id ON public.accounts_timtecuser_occupations USING btree (occupation_id);


--
-- Name: accounts_timtecuser_occupations_timtecuser_id; Type: INDEX; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE INDEX accounts_timtecuser_occupations_timtecuser_id ON public.accounts_timtecuser_occupations USING btree (timtecuser_id);


--
-- Name: accounts_timtecuser_schools_school_id; Type: INDEX; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE INDEX accounts_timtecuser_schools_school_id ON public.accounts_timtecuser_schools USING btree (school_id);


--
-- Name: accounts_timtecuser_schools_timtecuser_id; Type: INDEX; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE INDEX accounts_timtecuser_schools_timtecuser_id ON public.accounts_timtecuser_schools USING btree (timtecuser_id);


--
-- Name: accounts_timtecuser_user_permissions_permission_id; Type: INDEX; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE INDEX accounts_timtecuser_user_permissions_permission_id ON public.accounts_timtecuser_user_permissions USING btree (permission_id);


--
-- Name: accounts_timtecuser_user_permissions_timtecuser_id; Type: INDEX; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE INDEX accounts_timtecuser_user_permissions_timtecuser_id ON public.accounts_timtecuser_user_permissions USING btree (timtecuser_id);


--
-- Name: accounts_timtecuser_username_like; Type: INDEX; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE INDEX accounts_timtecuser_username_like ON public.accounts_timtecuser USING btree (username varchar_pattern_ops);


--
-- Name: accounts_timtecuserschool_education_degree_educationdegree_id; Type: INDEX; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE INDEX accounts_timtecuserschool_education_degree_educationdegree_id ON public.accounts_timtecuserschool_education_degree USING btree (educationdegree_id);


--
-- Name: accounts_timtecuserschool_education_degree_timtecuserschool_id; Type: INDEX; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE INDEX accounts_timtecuserschool_education_degree_timtecuserschool_id ON public.accounts_timtecuserschool_education_degree USING btree (timtecuserschool_id);


--
-- Name: accounts_timtecuserschool_professor_id; Type: INDEX; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE INDEX accounts_timtecuserschool_professor_id ON public.accounts_timtecuserschool USING btree (professor_id);


--
-- Name: accounts_timtecuserschool_school_id; Type: INDEX; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE INDEX accounts_timtecuserschool_school_id ON public.accounts_timtecuserschool USING btree (school_id);


--
-- Name: activities_activity_unit_id; Type: INDEX; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE INDEX activities_activity_unit_id ON public.activities_activity USING btree (unit_id);


--
-- Name: activities_answer_activity_id; Type: INDEX; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE INDEX activities_answer_activity_id ON public.activities_answer USING btree (activity_id);


--
-- Name: activities_answer_user_id; Type: INDEX; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE INDEX activities_answer_user_id ON public.activities_answer USING btree (user_id);


--
-- Name: auth_group_name_like; Type: INDEX; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE INDEX auth_group_name_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id; Type: INDEX; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE INDEX auth_group_permissions_group_id ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id; Type: INDEX; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE INDEX auth_group_permissions_permission_id ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id; Type: INDEX; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE INDEX auth_permission_content_type_id ON public.auth_permission USING btree (content_type_id);


--
-- Name: core_class_assistant_id; Type: INDEX; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE INDEX core_class_assistant_id ON public.core_class USING btree (assistant_id);


--
-- Name: core_class_course_id; Type: INDEX; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE INDEX core_class_course_id ON public.core_class USING btree (course_id);


--
-- Name: core_class_students_class_id; Type: INDEX; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE INDEX core_class_students_class_id ON public.core_class_students USING btree (class_id);


--
-- Name: core_class_students_timtecuser_id; Type: INDEX; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE INDEX core_class_students_timtecuser_id ON public.core_class_students USING btree (timtecuser_id);


--
-- Name: core_course_intro_video_id; Type: INDEX; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE INDEX core_course_intro_video_id ON public.core_course USING btree (intro_video_id);


--
-- Name: core_course_slug_like; Type: INDEX; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE INDEX core_course_slug_like ON public.core_course USING btree (slug varchar_pattern_ops);


--
-- Name: core_courseauthor_course_id; Type: INDEX; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE INDEX core_courseauthor_course_id ON public.core_courseauthor USING btree (course_id);


--
-- Name: core_courseauthor_user_id; Type: INDEX; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE INDEX core_courseauthor_user_id ON public.core_courseauthor USING btree (user_id);


--
-- Name: core_courseprofessor_course_id; Type: INDEX; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE INDEX core_courseprofessor_course_id ON public.core_courseprofessor USING btree (course_id);


--
-- Name: core_courseprofessor_user_id; Type: INDEX; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE INDEX core_courseprofessor_user_id ON public.core_courseprofessor USING btree (user_id);


--
-- Name: core_coursestudent_course_id; Type: INDEX; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE INDEX core_coursestudent_course_id ON public.core_coursestudent USING btree (course_id);


--
-- Name: core_coursestudent_user_id; Type: INDEX; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE INDEX core_coursestudent_user_id ON public.core_coursestudent USING btree (user_id);


--
-- Name: core_lesson_course_id; Type: INDEX; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE INDEX core_lesson_course_id ON public.core_lesson USING btree (course_id);


--
-- Name: core_lesson_slug_like; Type: INDEX; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE INDEX core_lesson_slug_like ON public.core_lesson USING btree (slug varchar_pattern_ops);


--
-- Name: core_professormessage_course_id; Type: INDEX; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE INDEX core_professormessage_course_id ON public.core_professormessage USING btree (course_id);


--
-- Name: core_professormessage_professor_id; Type: INDEX; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE INDEX core_professormessage_professor_id ON public.core_professormessage USING btree (professor_id);


--
-- Name: core_professormessage_users_professormessage_id; Type: INDEX; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE INDEX core_professormessage_users_professormessage_id ON public.core_professormessage_users USING btree (professormessage_id);


--
-- Name: core_professormessage_users_timtecuser_id; Type: INDEX; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE INDEX core_professormessage_users_timtecuser_id ON public.core_professormessage_users USING btree (timtecuser_id);


--
-- Name: core_studentprogress_unit_id; Type: INDEX; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE INDEX core_studentprogress_unit_id ON public.core_studentprogress USING btree (unit_id);


--
-- Name: core_studentprogress_user_id; Type: INDEX; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE INDEX core_studentprogress_user_id ON public.core_studentprogress USING btree (user_id);


--
-- Name: core_unit_lesson_id; Type: INDEX; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE INDEX core_unit_lesson_id ON public.core_unit USING btree (lesson_id);


--
-- Name: core_unit_video_id; Type: INDEX; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE INDEX core_unit_video_id ON public.core_unit USING btree (video_id);


--
-- Name: course_material_file_course_material_id; Type: INDEX; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE INDEX course_material_file_course_material_id ON public.course_material_file USING btree (course_material_id);


--
-- Name: django_admin_log_content_type_id; Type: INDEX; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE INDEX django_admin_log_content_type_id ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id; Type: INDEX; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE INDEX django_admin_log_user_id ON public.django_admin_log USING btree (user_id);


--
-- Name: django_flatpage_sites_flatpage_id; Type: INDEX; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE INDEX django_flatpage_sites_flatpage_id ON public.django_flatpage_sites USING btree (flatpage_id);


--
-- Name: django_flatpage_sites_site_id; Type: INDEX; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE INDEX django_flatpage_sites_site_id ON public.django_flatpage_sites USING btree (site_id);


--
-- Name: django_flatpage_url; Type: INDEX; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE INDEX django_flatpage_url ON public.django_flatpage USING btree (url);


--
-- Name: django_flatpage_url_like; Type: INDEX; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE INDEX django_flatpage_url_like ON public.django_flatpage USING btree (url varchar_pattern_ops);


--
-- Name: django_session_expire_date; Type: INDEX; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE INDEX django_session_expire_date ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_like; Type: INDEX; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE INDEX django_session_session_key_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: forum_answer_question_id; Type: INDEX; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE INDEX forum_answer_question_id ON public.forum_answer USING btree (question_id);


--
-- Name: forum_answer_user_id; Type: INDEX; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE INDEX forum_answer_user_id ON public.forum_answer USING btree (user_id);


--
-- Name: forum_answervote_answer_id; Type: INDEX; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE INDEX forum_answervote_answer_id ON public.forum_answervote USING btree (answer_id);


--
-- Name: forum_question_course_id; Type: INDEX; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE INDEX forum_question_course_id ON public.forum_question USING btree (course_id);


--
-- Name: forum_question_hidden_by_id; Type: INDEX; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE INDEX forum_question_hidden_by_id ON public.forum_question USING btree (hidden_by_id);


--
-- Name: forum_question_lesson_id; Type: INDEX; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE INDEX forum_question_lesson_id ON public.forum_question USING btree (lesson_id);


--
-- Name: forum_question_slug_like; Type: INDEX; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE INDEX forum_question_slug_like ON public.forum_question USING btree (slug varchar_pattern_ops);


--
-- Name: forum_question_user_id; Type: INDEX; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE INDEX forum_question_user_id ON public.forum_question USING btree (user_id);


--
-- Name: forum_questionvote_question_id; Type: INDEX; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE INDEX forum_questionvote_question_id ON public.forum_questionvote USING btree (question_id);


--
-- Name: forum_vote_user_id; Type: INDEX; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE INDEX forum_vote_user_id ON public.forum_vote USING btree (user_id);


--
-- Name: joca_jocauser_user_id; Type: INDEX; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE INDEX joca_jocauser_user_id ON public.joca_jocauser USING btree (user_id);


--
-- Name: notes_note_content_type_id; Type: INDEX; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE INDEX notes_note_content_type_id ON public.notes_note USING btree (content_type_id);


--
-- Name: notes_note_user_id; Type: INDEX; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE INDEX notes_note_user_id ON public.notes_note USING btree (user_id);


--
-- Name: socialaccount_socialaccount_user_id; Type: INDEX; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE INDEX socialaccount_socialaccount_user_id ON public.socialaccount_socialaccount USING btree (user_id);


--
-- Name: socialaccount_socialapp_sites_site_id; Type: INDEX; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE INDEX socialaccount_socialapp_sites_site_id ON public.socialaccount_socialapp_sites USING btree (site_id);


--
-- Name: socialaccount_socialapp_sites_socialapp_id; Type: INDEX; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE INDEX socialaccount_socialapp_sites_socialapp_id ON public.socialaccount_socialapp_sites USING btree (socialapp_id);


--
-- Name: socialaccount_socialtoken_account_id; Type: INDEX; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE INDEX socialaccount_socialtoken_account_id ON public.socialaccount_socialtoken USING btree (account_id);


--
-- Name: socialaccount_socialtoken_app_id; Type: INDEX; Schema: public; Owner: timtec-production; Tablespace: 
--

CREATE INDEX socialaccount_socialtoken_app_id ON public.socialaccount_socialtoken USING btree (app_id);


--
-- Name: account_emailaddress_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.account_emailaddress
    ADD CONSTRAINT account_emailaddress_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.accounts_timtecuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: account_emailconfirmation_email_address_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.account_emailconfirmation
    ADD CONSTRAINT account_emailconfirmation_email_address_id_fkey FOREIGN KEY (email_address_id) REFERENCES public.account_emailaddress(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_city_uf_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.accounts_city
    ADD CONSTRAINT accounts_city_uf_id_fkey FOREIGN KEY (uf_id) REFERENCES public.accounts_state(uf) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_educationdegree_education_level_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.accounts_educationdegree
    ADD CONSTRAINT accounts_educationdegree_education_level_id_fkey FOREIGN KEY (education_level_id) REFERENCES public.accounts_educationlevel(slug) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_school_city_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.accounts_school
    ADD CONSTRAINT accounts_school_city_id_fkey FOREIGN KEY (city_id) REFERENCES public.accounts_city(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_timtecuser_city_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.accounts_timtecuser
    ADD CONSTRAINT accounts_timtecuser_city_id_fkey FOREIGN KEY (city_id) REFERENCES public.accounts_city(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_timtecuser_disciplines_discipline_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.accounts_timtecuser_disciplines
    ADD CONSTRAINT accounts_timtecuser_disciplines_discipline_id_fkey FOREIGN KEY (discipline_id) REFERENCES public.accounts_discipline(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_timtecuser_education_degrees_educationdegree_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.accounts_timtecuser_education_degrees
    ADD CONSTRAINT accounts_timtecuser_education_degrees_educationdegree_id_fkey FOREIGN KEY (educationdegree_id) REFERENCES public.accounts_educationdegree(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_timtecuser_groups_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.accounts_timtecuser_groups
    ADD CONSTRAINT accounts_timtecuser_groups_group_id_fkey FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_timtecuser_occupations_occupation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.accounts_timtecuser_occupations
    ADD CONSTRAINT accounts_timtecuser_occupations_occupation_id_fkey FOREIGN KEY (occupation_id) REFERENCES public.accounts_occupation(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_timtecuser_schools_school_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.accounts_timtecuser_schools
    ADD CONSTRAINT accounts_timtecuser_schools_school_id_fkey FOREIGN KEY (school_id) REFERENCES public.accounts_school(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_timtecuser_user_permissions_permission_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.accounts_timtecuser_user_permissions
    ADD CONSTRAINT accounts_timtecuser_user_permissions_permission_id_fkey FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_timtecuserschool_education_deg_educationdegree_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.accounts_timtecuserschool_education_degree
    ADD CONSTRAINT accounts_timtecuserschool_education_deg_educationdegree_id_fkey FOREIGN KEY (educationdegree_id) REFERENCES public.accounts_educationdegree(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_timtecuserschool_professor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.accounts_timtecuserschool
    ADD CONSTRAINT accounts_timtecuserschool_professor_id_fkey FOREIGN KEY (professor_id) REFERENCES public.accounts_timtecuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_timtecuserschool_school_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.accounts_timtecuserschool
    ADD CONSTRAINT accounts_timtecuserschool_school_id_fkey FOREIGN KEY (school_id) REFERENCES public.accounts_school(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: activities_answer_activity_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.activities_answer
    ADD CONSTRAINT activities_answer_activity_id_fkey FOREIGN KEY (activity_id) REFERENCES public.activities_activity(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: activities_answer_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.activities_answer
    ADD CONSTRAINT activities_answer_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.accounts_timtecuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions_permission_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_permission_id_fkey FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: class_id_refs_id_8b44c520; Type: FK CONSTRAINT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.core_class_students
    ADD CONSTRAINT class_id_refs_id_8b44c520 FOREIGN KEY (class_id) REFERENCES public.core_class(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: content_type_id_refs_id_d043b34a; Type: FK CONSTRAINT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT content_type_id_refs_id_d043b34a FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: core_class_assistant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.core_class
    ADD CONSTRAINT core_class_assistant_id_fkey FOREIGN KEY (assistant_id) REFERENCES public.accounts_timtecuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: core_class_students_timtecuser_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.core_class_students
    ADD CONSTRAINT core_class_students_timtecuser_id_fkey FOREIGN KEY (timtecuser_id) REFERENCES public.accounts_timtecuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: core_course_default_class_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.core_course
    ADD CONSTRAINT core_course_default_class_id_fkey FOREIGN KEY (default_class_id) REFERENCES public.core_class(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: core_course_intro_video_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.core_course
    ADD CONSTRAINT core_course_intro_video_id_fkey FOREIGN KEY (intro_video_id) REFERENCES public.core_video(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: core_courseauthor_course_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.core_courseauthor
    ADD CONSTRAINT core_courseauthor_course_id_fkey FOREIGN KEY (course_id) REFERENCES public.core_course(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: core_courseauthor_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.core_courseauthor
    ADD CONSTRAINT core_courseauthor_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.accounts_timtecuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: core_courseprofessor_course_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.core_courseprofessor
    ADD CONSTRAINT core_courseprofessor_course_id_fkey FOREIGN KEY (course_id) REFERENCES public.core_course(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: core_courseprofessor_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.core_courseprofessor
    ADD CONSTRAINT core_courseprofessor_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.accounts_timtecuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: core_coursestudent_course_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.core_coursestudent
    ADD CONSTRAINT core_coursestudent_course_id_fkey FOREIGN KEY (course_id) REFERENCES public.core_course(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: core_coursestudent_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.core_coursestudent
    ADD CONSTRAINT core_coursestudent_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.accounts_timtecuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: core_lesson_course_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.core_lesson
    ADD CONSTRAINT core_lesson_course_id_fkey FOREIGN KEY (course_id) REFERENCES public.core_course(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: core_professormessage_course_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.core_professormessage
    ADD CONSTRAINT core_professormessage_course_id_fkey FOREIGN KEY (course_id) REFERENCES public.core_course(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: core_professormessage_professor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.core_professormessage
    ADD CONSTRAINT core_professormessage_professor_id_fkey FOREIGN KEY (professor_id) REFERENCES public.accounts_timtecuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: core_professormessage_users_timtecuser_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.core_professormessage_users
    ADD CONSTRAINT core_professormessage_users_timtecuser_id_fkey FOREIGN KEY (timtecuser_id) REFERENCES public.accounts_timtecuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: core_studentprogress_unit_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.core_studentprogress
    ADD CONSTRAINT core_studentprogress_unit_id_fkey FOREIGN KEY (unit_id) REFERENCES public.core_unit(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: core_studentprogress_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.core_studentprogress
    ADD CONSTRAINT core_studentprogress_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.accounts_timtecuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: core_unit_lesson_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.core_unit
    ADD CONSTRAINT core_unit_lesson_id_fkey FOREIGN KEY (lesson_id) REFERENCES public.core_lesson(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: core_unit_video_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.core_unit
    ADD CONSTRAINT core_unit_video_id_fkey FOREIGN KEY (video_id) REFERENCES public.core_video(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: correct_answer_id_refs_id_c0880920; Type: FK CONSTRAINT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.forum_question
    ADD CONSTRAINT correct_answer_id_refs_id_c0880920 FOREIGN KEY (correct_answer_id) REFERENCES public.forum_answer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: course_id_refs_id_3b74a469; Type: FK CONSTRAINT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.core_class
    ADD CONSTRAINT course_id_refs_id_3b74a469 FOREIGN KEY (course_id) REFERENCES public.core_course(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: course_id_refs_id_94dd8828; Type: FK CONSTRAINT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.forum_question
    ADD CONSTRAINT course_id_refs_id_94dd8828 FOREIGN KEY (course_id) REFERENCES public.core_course(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: course_id_refs_id_d3c48390; Type: FK CONSTRAINT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.course_material_coursematerial
    ADD CONSTRAINT course_id_refs_id_d3c48390 FOREIGN KEY (course_id) REFERENCES public.core_course(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: course_material_file_course_material_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.course_material_file
    ADD CONSTRAINT course_material_file_course_material_id_fkey FOREIGN KEY (course_material_id) REFERENCES public.course_material_coursematerial(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log_content_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_fkey FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_flatpage_sites_site_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.django_flatpage_sites
    ADD CONSTRAINT django_flatpage_sites_site_id_fkey FOREIGN KEY (site_id) REFERENCES public.django_site(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: flatpage_id_refs_id_83cd0023; Type: FK CONSTRAINT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.django_flatpage_sites
    ADD CONSTRAINT flatpage_id_refs_id_83cd0023 FOREIGN KEY (flatpage_id) REFERENCES public.django_flatpage(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: forum_answer_question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.forum_answer
    ADD CONSTRAINT forum_answer_question_id_fkey FOREIGN KEY (question_id) REFERENCES public.forum_question(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: forum_answer_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.forum_answer
    ADD CONSTRAINT forum_answer_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.accounts_timtecuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: forum_answervote_answer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.forum_answervote
    ADD CONSTRAINT forum_answervote_answer_id_fkey FOREIGN KEY (answer_id) REFERENCES public.forum_answer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: forum_answervote_vote_ptr_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.forum_answervote
    ADD CONSTRAINT forum_answervote_vote_ptr_id_fkey FOREIGN KEY (vote_ptr_id) REFERENCES public.forum_vote(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: forum_question_hidden_by_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.forum_question
    ADD CONSTRAINT forum_question_hidden_by_id_fkey FOREIGN KEY (hidden_by_id) REFERENCES public.accounts_timtecuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: forum_question_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.forum_question
    ADD CONSTRAINT forum_question_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.accounts_timtecuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: forum_questionvote_question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.forum_questionvote
    ADD CONSTRAINT forum_questionvote_question_id_fkey FOREIGN KEY (question_id) REFERENCES public.forum_question(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: forum_questionvote_vote_ptr_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.forum_questionvote
    ADD CONSTRAINT forum_questionvote_vote_ptr_id_fkey FOREIGN KEY (vote_ptr_id) REFERENCES public.forum_vote(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: forum_vote_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.forum_vote
    ADD CONSTRAINT forum_vote_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.accounts_timtecuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: group_id_refs_id_f4b32aac; Type: FK CONSTRAINT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT group_id_refs_id_f4b32aac FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: joca_jocauser_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.joca_jocauser
    ADD CONSTRAINT joca_jocauser_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.accounts_timtecuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: lesson_id_refs_id_22a5a3f3; Type: FK CONSTRAINT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.forum_question
    ADD CONSTRAINT lesson_id_refs_id_22a5a3f3 FOREIGN KEY (lesson_id) REFERENCES public.core_lesson(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: notes_note_content_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.notes_note
    ADD CONSTRAINT notes_note_content_type_id_fkey FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: notes_note_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.notes_note
    ADD CONSTRAINT notes_note_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.accounts_timtecuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: professormessage_id_refs_id_b94c5ff3; Type: FK CONSTRAINT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.core_professormessage_users
    ADD CONSTRAINT professormessage_id_refs_id_b94c5ff3 FOREIGN KEY (professormessage_id) REFERENCES public.core_professormessage(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: socialaccount_socialaccount_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.socialaccount_socialaccount
    ADD CONSTRAINT socialaccount_socialaccount_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.accounts_timtecuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: socialaccount_socialapp_sites_site_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.socialaccount_socialapp_sites
    ADD CONSTRAINT socialaccount_socialapp_sites_site_id_fkey FOREIGN KEY (site_id) REFERENCES public.django_site(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: socialaccount_socialtoken_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.socialaccount_socialtoken
    ADD CONSTRAINT socialaccount_socialtoken_account_id_fkey FOREIGN KEY (account_id) REFERENCES public.socialaccount_socialaccount(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: socialaccount_socialtoken_app_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.socialaccount_socialtoken
    ADD CONSTRAINT socialaccount_socialtoken_app_id_fkey FOREIGN KEY (app_id) REFERENCES public.socialaccount_socialapp(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: socialapp_id_refs_id_e7a43014; Type: FK CONSTRAINT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.socialaccount_socialapp_sites
    ADD CONSTRAINT socialapp_id_refs_id_e7a43014 FOREIGN KEY (socialapp_id) REFERENCES public.socialaccount_socialapp(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: timtecuser_id_refs_id_97a42891; Type: FK CONSTRAINT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.accounts_timtecuser_user_permissions
    ADD CONSTRAINT timtecuser_id_refs_id_97a42891 FOREIGN KEY (timtecuser_id) REFERENCES public.accounts_timtecuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: timtecuser_id_refs_id_9dbc3ee1; Type: FK CONSTRAINT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.accounts_timtecuser_education_degrees
    ADD CONSTRAINT timtecuser_id_refs_id_9dbc3ee1 FOREIGN KEY (timtecuser_id) REFERENCES public.accounts_timtecuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: timtecuser_id_refs_id_9f3fe1b0; Type: FK CONSTRAINT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.accounts_timtecuser_disciplines
    ADD CONSTRAINT timtecuser_id_refs_id_9f3fe1b0 FOREIGN KEY (timtecuser_id) REFERENCES public.accounts_timtecuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: timtecuser_id_refs_id_b0fe1c8f; Type: FK CONSTRAINT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.accounts_timtecuser_groups
    ADD CONSTRAINT timtecuser_id_refs_id_b0fe1c8f FOREIGN KEY (timtecuser_id) REFERENCES public.accounts_timtecuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: timtecuser_id_refs_id_b4f2e5d2; Type: FK CONSTRAINT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.accounts_timtecuser_schools
    ADD CONSTRAINT timtecuser_id_refs_id_b4f2e5d2 FOREIGN KEY (timtecuser_id) REFERENCES public.accounts_timtecuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: timtecuser_id_refs_id_d75a1b53; Type: FK CONSTRAINT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.accounts_timtecuser_occupations
    ADD CONSTRAINT timtecuser_id_refs_id_d75a1b53 FOREIGN KEY (timtecuser_id) REFERENCES public.accounts_timtecuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: timtecuserschool_id_refs_id_6228ffc9; Type: FK CONSTRAINT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.accounts_timtecuserschool_education_degree
    ADD CONSTRAINT timtecuserschool_id_refs_id_6228ffc9 FOREIGN KEY (timtecuserschool_id) REFERENCES public.accounts_timtecuserschool(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: unit_id_refs_id_55c44fa7; Type: FK CONSTRAINT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.activities_activity
    ADD CONSTRAINT unit_id_refs_id_55c44fa7 FOREIGN KEY (unit_id) REFERENCES public.core_unit(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: user_id_refs_id_922a4a2a; Type: FK CONSTRAINT; Schema: public; Owner: timtec-production
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT user_id_refs_id_922a4a2a FOREIGN KEY (user_id) REFERENCES public.accounts_timtecuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

