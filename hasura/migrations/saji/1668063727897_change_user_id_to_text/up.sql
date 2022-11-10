
alter table "public"."users" rename column "id" to "_id";

alter table "public"."users" add column "id" text
 not null unique;

alter table "public"."colors" drop constraint "colors_user_id_fkey";

alter table "public"."colors" drop column "user_id" cascade;

alter table "public"."colors" add column "user_id" text
 not null;

alter table "public"."colors"
  add constraint "colors_user_id_fkey"
  foreign key ("user_id")
  references "public"."users"
  ("id") on update cascade on delete cascade;

alter table "public"."slices" drop column "user_id" cascade;

alter table "public"."slices" add column "user_id" text
 not null;

alter table "public"."slices"
  add constraint "slices_user_id_fkey"
  foreign key ("user_id")
  references "public"."users"
  ("id") on update cascade on delete cascade;

alter table "public"."tags" drop column "user_id" cascade;

alter table "public"."tags" add column "user_id" text
 not null;

alter table "public"."tags"
  add constraint "tags_user_id_fkey"
  foreign key ("user_id")
  references "public"."users"
  ("id") on update cascade on delete cascade;

BEGIN TRANSACTION;
ALTER TABLE "public"."users" DROP CONSTRAINT "users_pkey";

ALTER TABLE "public"."users"
    ADD CONSTRAINT "users_pkey" PRIMARY KEY ("id");
COMMIT TRANSACTION;

alter table "public"."users" drop column "_id" cascade;

alter table "public"."users" drop column "username" cascade;
