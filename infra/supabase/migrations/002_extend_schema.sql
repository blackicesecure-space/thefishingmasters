-- 002_extend_schema.sql
-- Erweitert das MVP-Schema um zusaetzliche Tabellen und Felder.

-- Spots: Neue Spalten hinzufuegen
alter table public.spots
  add column if not exists flaeche_ha decimal(8,2),
  add column if not exists max_tiefe_m decimal(5,1),
  add column if not exists strukturen jsonb default '[]'::jsonb,
  add column if not exists parkplatz boolean default false,
  add column if not exists barrierefrei boolean default false,
  add column if not exists beschreibung text,
  add column if not exists source_file text,
  add column if not exists updated_at timestamptz not null default now();

-- Spots: Defaults korrigieren
alter table public.spots
  alter column fischarten set default '[]'::jsonb,
  alter column regelung set default '';

-- Location-Index
create index if not exists idx_spots_location on public.spots (latitude, longitude);

-- Profiles (FK to auth.users for RLS integration)
create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  display_name text,
  preferred_species jsonb default '[]'::jsonb,
  home_latitude decimal(9,6),
  home_longitude decimal(9,6),
  bundesland text,
  created_at timestamptz not null default now()
);

-- User Sessions: Neue Spalten
alter table public.user_sessions
  add column if not exists score_breakdown jsonb,
  alter column user_id drop not null;

create index if not exists idx_user_sessions_spot on public.user_sessions (spot_id);
create index if not exists idx_user_sessions_created on public.user_sessions (created_at desc);

-- Feedback
create table if not exists public.feedback (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  spot_id uuid not null references public.spots(id) on delete cascade,
  session_id uuid references public.user_sessions(id) on delete set null,
  success boolean not null,
  target_species text,
  fish_caught text,
  lure_used text,
  note text,
  crowd_level integer check (crowd_level between 0 and 5),
  created_at timestamptz not null default now()
);

create index if not exists idx_feedback_spot on public.feedback (spot_id);
create index if not exists idx_feedback_user on public.feedback (user_id);
create index if not exists idx_feedback_created on public.feedback (created_at desc);

-- Weather Cache
create table if not exists public.weather_cache (
  id uuid primary key default gen_random_uuid(),
  latitude decimal(9,6) not null,
  longitude decimal(9,6) not null,
  temp_celsius decimal(4,1),
  wind_speed_kmh decimal(5,1),
  wind_direction integer,
  pressure_hpa decimal(6,1),
  cloud_cover integer,
  precipitation decimal(5,2),
  humidity integer,
  description text,
  icon text,
  fetched_at timestamptz not null default now(),
  expires_at timestamptz not null default (now() + interval '15 minutes')
);

create index if not exists idx_weather_cache_location on public.weather_cache (latitude, longitude);
create index if not exists idx_weather_cache_expires on public.weather_cache (expires_at);

-- Predictions Log
create table if not exists public.predictions (
  id uuid primary key default gen_random_uuid(),
  session_id uuid references public.user_sessions(id) on delete cascade,
  spot_id uuid not null references public.spots(id) on delete cascade,
  model_version text not null,
  bite_probability decimal(5,2) not null,
  confidence decimal(4,3),
  features_used jsonb,
  score_breakdown jsonb,
  rank integer,
  created_at timestamptz not null default now()
);

create index if not exists idx_predictions_session on public.predictions (session_id);
create index if not exists idx_predictions_spot on public.predictions (spot_id);

-- Updated_at Trigger fuer Spots
create or replace function public.set_updated_at()
returns trigger as $$
begin
  new.updated_at = now();
  return new;
end;
$$ language plpgsql;

drop trigger if exists spots_updated_at on public.spots;
create trigger spots_updated_at
  before update on public.spots
  for each row execute function public.set_updated_at();
