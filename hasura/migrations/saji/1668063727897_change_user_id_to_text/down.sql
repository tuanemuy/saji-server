
alter table "public"."users" add constraint "users_username_key" unique (username);
alter table "public"."users" alter column "username" drop not null;
alter table "public"."users" add column "username" text;

alter table "public"."users" alter column "_id" set default nextval('users_id_seq'::regclass);
alter table "public"."users" alter column "_id" drop not null;
alter table "public"."users" add column "_id" int8;

alter table "public"."users" drop constraint "users_pkey";
alter table "public"."users"
    add constraint "users_pkey"
    primary key ("_id");

alter table "public"."tags" drop constraint "tags_user_id_fkey";

-- Could not auto-generate a down migration.
-- Please write an appropriate down migration for the SQL below:
-- alter table "public"."tags" add column "user_id" text
--  not null;

alter table "public"."tags"
  add constraint "tags_user_id_fkey"
  foreign key (user_id)
  references "public"."users"
  (_id) on update cascade on delete cascade;
alter table "public"."tags" alter column "user_id" drop not null;
alter table "public"."tags" add column "user_id" int8;

alter table "public"."slices" drop constraint "slices_user_id_fkey";

-- Could not auto-generate a down migration.
-- Please write an appropriate down migration for the SQL below:
-- alter table "public"."slices" add column "user_id" text
--  not null;

alter table "public"."slices"
  add constraint "slices_user_id_fkey"
  foreign key (user_id)
  references "public"."users"
  (_id) on update cascade on delete cascade;
alter table "public"."slices" alter column "user_id" drop not null;
alter table "public"."slices" add column "user_id" int8;

alter table "public"."colors" drop constraint "colors_user_id_fkey";

-- Could not auto-generate a down migration.
-- Please write an appropriate down migration for the SQL below:
-- alter table "public"."colors" add column "user_id" text
--  not null;

alter table "public"."colors" alter column "user_id" drop not null;
alter table "public"."colors" add column "user_id" int8;

alter table "public"."colors"
  add constraint "colors_user_id_fkey"
  foreign key ("user_id")
  references "public"."users"
  ("_id") on update cascade on delete cascade;

-- Could not auto-generate a down migration.
-- Please write an appropriate down migration for the SQL below:
-- alter table "public"."users" add column "id" text
--  not null unique;

alter table "public"."users" rename column "_id" to "id";
