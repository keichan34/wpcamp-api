--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: metadata; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE metadata (
    id integer NOT NULL,
    key character varying(255) NOT NULL,
    value text
);


--
-- Name: metadata_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE metadata_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: metadata_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE metadata_id_seq OWNED BY metadata.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying(255) DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying(255),
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: word_camps; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE word_camps (
    id integer NOT NULL,
    title character varying(255),
    url character varying(255),
    address character varying(255),
    start date,
    "end" date,
    guid character varying(255) NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    thumbnail_file_name character varying(255),
    thumbnail_content_type character varying(255),
    thumbnail_file_size integer,
    thumbnail_updated_at timestamp without time zone,
    description text
);


--
-- Name: word_camps_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE word_camps_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: word_camps_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE word_camps_id_seq OWNED BY word_camps.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY metadata ALTER COLUMN id SET DEFAULT nextval('metadata_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY word_camps ALTER COLUMN id SET DEFAULT nextval('word_camps_id_seq'::regclass);


--
-- Name: metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY metadata
    ADD CONSTRAINT metadata_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: word_camps_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY word_camps
    ADD CONSTRAINT word_camps_pkey PRIMARY KEY (id);


--
-- Name: ft_description_on_word_camps; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX ft_description_on_word_camps ON word_camps USING gin (to_tsvector('english'::regconfig, description));


--
-- Name: ft_title_on_word_camps; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX ft_title_on_word_camps ON word_camps USING gin (to_tsvector('english'::regconfig, (title)::text));


--
-- Name: index_metadata_on_key; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_metadata_on_key ON metadata USING btree (key);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: index_word_camps_on_created_at; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_word_camps_on_created_at ON word_camps USING btree (created_at);


--
-- Name: index_word_camps_on_guid; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_word_camps_on_guid ON word_camps USING btree (guid);


--
-- Name: index_word_camps_on_start; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_word_camps_on_start ON word_camps USING btree (start);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user",public;

INSERT INTO schema_migrations (version) VALUES ('20131205114103');

INSERT INTO schema_migrations (version) VALUES ('20131205125935');

INSERT INTO schema_migrations (version) VALUES ('20131205150632');

INSERT INTO schema_migrations (version) VALUES ('20131206000215');

INSERT INTO schema_migrations (version) VALUES ('20131206005541');

INSERT INTO schema_migrations (version) VALUES ('20131207033908');

INSERT INTO schema_migrations (version) VALUES ('20131207082231');
