-- Mirrors infra/supabase/schema.sql as first migration.
create extension if not exists "pgcrypto";

create table if not exists public.spots (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  latitude decimal(9,6) not null,
  longitude decimal(9,6) not null,
  bundesland text not null,
  gewaesser_typ text not null,
  fischarten jsonb not null,
  regelung text not null,
  angelkarte_preis_tag decimal(5,2),
  schonzeiten jsonb,
  catch_history jsonb,
  avg_crowd_level integer default 0,
  created_at timestamptz not null default now()
);

create table if not exists public.user_sessions (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null,
  spot_id uuid references public.spots(id),
  target_species text,
  weather_snapshot jsonb,
  lunar_snapshot jsonb,
  prediction_score numeric(5,2),
  outcome text,
  created_at timestamptz not null default now()
);

create index if not exists idx_spots_bundesland on public.spots (bundesland);
create index if not exists idx_spots_geotype on public.spots (gewaesser_typ);
create index if not exists idx_user_sessions_user on public.user_sessions (user_id);
