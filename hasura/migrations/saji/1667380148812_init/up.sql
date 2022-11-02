SET check_function_bodies = false;
CREATE TABLE public.colors (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    hex text NOT NULL
);
CREATE SEQUENCE public.colors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.colors_id_seq OWNED BY public.colors.id;
CREATE TABLE public.revisions (
    id bigint NOT NULL,
    slice_id bigint NOT NULL,
    content text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);
CREATE SEQUENCE public.revisions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.revisions_id_seq OWNED BY public.revisions.id;
CREATE TABLE public.slices (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    trashed_at timestamp with time zone
);
CREATE SEQUENCE public.slices_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.slices_id_seq OWNED BY public.slices.id;
CREATE TABLE public.slices_tags (
    slice_id bigint NOT NULL,
    tag_id bigint NOT NULL
);
CREATE TABLE public.tags (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    name text NOT NULL,
    color_id bigint NOT NULL
);
CREATE SEQUENCE public.tags_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.tags_id_seq OWNED BY public.tags.id;
CREATE TABLE public.users (
    id bigint NOT NULL,
    firebase_id text NOT NULL,
    username text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);
CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;
ALTER TABLE ONLY public.colors ALTER COLUMN id SET DEFAULT nextval('public.colors_id_seq'::regclass);
ALTER TABLE ONLY public.revisions ALTER COLUMN id SET DEFAULT nextval('public.revisions_id_seq'::regclass);
ALTER TABLE ONLY public.slices ALTER COLUMN id SET DEFAULT nextval('public.slices_id_seq'::regclass);
ALTER TABLE ONLY public.tags ALTER COLUMN id SET DEFAULT nextval('public.tags_id_seq'::regclass);
ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);
ALTER TABLE ONLY public.colors
    ADD CONSTRAINT colors_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.revisions
    ADD CONSTRAINT revisions_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.slices
    ADD CONSTRAINT slices_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.slices_tags
    ADD CONSTRAINT slices_tags_pkey PRIMARY KEY (slice_id, tag_id);
ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_firebase_id_key UNIQUE (firebase_id);
ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);
ALTER TABLE ONLY public.colors
    ADD CONSTRAINT colors_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public.revisions
    ADD CONSTRAINT revisions_slice_id_fkey FOREIGN KEY (slice_id) REFERENCES public.slices(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public.slices_tags
    ADD CONSTRAINT slices_tags_slice_id_fkey FOREIGN KEY (slice_id) REFERENCES public.slices(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public.slices_tags
    ADD CONSTRAINT slices_tags_tag_id_fkey FOREIGN KEY (tag_id) REFERENCES public.tags(id) ON UPDATE CASCADE ON DELETE RESTRICT;
ALTER TABLE ONLY public.slices
    ADD CONSTRAINT slices_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_color_id_fkey FOREIGN KEY (color_id) REFERENCES public.colors(id) ON UPDATE CASCADE ON DELETE RESTRICT;
ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;
